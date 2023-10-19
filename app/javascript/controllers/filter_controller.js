import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "tableRow"];

  filter() {
    const keyword = this.inputTarget.value.toLowerCase();

    this.tableRowTargets.forEach((row) => {
      const rowData = row.textContent.toLowerCase();
      if (rowData.includes(keyword)) {
        row.style.display = "table-row";
      } else {
        row.style.display = "none";
      }
    });
  }
}
