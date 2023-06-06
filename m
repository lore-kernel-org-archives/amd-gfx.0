Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FD3C7EE31
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AF910E325;
	Tue,  6 Jun 2023 09:18:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253D110E315
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXPxTDaHnL3XfqMHRRV7m4xForH4MwVsq7c5UijkMGXLgY/nJ0lylFqcczHvJ57OekHv60n+aixJ1ZcPjTGIJF055vLkkPY3Tf7OM+7t/I19fuo8aCRzXBFarHkYkhJM3tfqYDdYW7cS5E6a4pfDu1dLuoyJg6dfOJmi4CEbI+oUf2j2fPJp/L7f1LSp14FEJEy+r+1UgjH2T0/LISiMw5dvE3XixWgglYkPcl+6orSRgDZTB0Iv1F3JWO3lIytrBERUy2l/Mf8V5KWYmIrjZkWx4pnZ7+4YXiX9tM77RtC2jmi8bPRv1M5a5HByiYt2xH8bL4kazVxIZFra8GymqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvvdPsv56qxtQYYGs/wWsQ/xnc58Ob3QMtBo8HH24hE=;
 b=G9S+QiTmSA426Bw/sgz9FlITKX0gpmO72UUNNzvN/+h5JMcHg7DwRGytU6lpoKCc2VnFJK2707n5NfYoLFQPcJqJ5N1ySX6g7DweYm9Lj5YsjjqR23q247ihSXecfjWtCJNQVvHLOmk5IFdLRZ1WjNg+NmQGgFUb0eJd4vvC9mHI4J/lA856WZBPkJCgrk9hCpfT8zqcfN83XUr+ElmmPv/1CkqnV+WGVSMvl1Fes2Ns7Z6QJvVIaTmSUi2S8p1xK+d/RE0RvNzZxI+yW6L6qL71Npn9+m/a/+kyJq6SuIHuPLbVUH/goa/X/irBsexeI3Qhgq2J1+xweXuGl4Uruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvvdPsv56qxtQYYGs/wWsQ/xnc58Ob3QMtBo8HH24hE=;
 b=Hp1PUJPyvtErYA8+oos9GiH9xaWAoarBfc72Q3R5a7WNftbnNvotZw7/8MOwo6uflLCcMmjmew9tYzXQd9K8hyw3F0VnSM7gupfywWS74gtUtyg0v08fQCQHvilOA0mY7ZOfKkU7eiYgMAFv/u8MnHdCQB1EZ1Vb693Ou07c8y4=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 09:17:56 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::48) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:56 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:54 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 11/17] gui/waves_panel: refactor the wave storage and wave
 identification
Date: Tue, 6 Jun 2023 11:17:19 +0200
Message-ID: <20230606091725.20080-12-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 99daef05-a510-4d24-a532-08db666eea09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL9P/5dusS2aytedscvzBexIn2y9dcRGeeNq1G/MhEI/nXWt/Q5bOBM0ar2H7tppiWdvzU69cD9WfcH1+ZlTqwZczjVRO7HeSKH3ewhKLGdgRTuSq/x2zDSUS2cNyDrHzeFqdk/zvboJGY5xVpGBAiKL9WiNlC7kYEnBBjETtX6rzpKFkIELxbEW2xPmYOa6gvbsW/HuoXV+qRKbPgKVgipbLpylRVPKqB1utMUJnyLVLeCsaru7Rp8tUrQhKY5ht8Gtk2vdJnFJs28m9KlHeIp5t6j2Nn0l0TgWo2e0EPn82widezTNEqYH879qzDHUGz/g8HsyUIweBKHIdI+EGm68ObOimcYM56sS8YdkvEQhO7FRfvMdIzuFiwBM6fpQC0ptVzr5n2COPatSm5MySj9H/Uicdabp0njRCnRWjzzuaBb8EvKVtXkzoXCjm+ikiYuMQxXoZOGYXOefeQcJrUaiJrisWvwmpTcatygGfya6WW4uABeJDIV21CL8V5ehCQfNS2XctEAYGB70LfjWcQ3LEVeJ/lJcKpXsvhevFJ/P7g1a9A2XqYV8FNMo/ArFj2FojzAx3Mi5PU1vNz8eTxijZQa/lp4hGzH5MOxEc7A61zmf0ua1zNsAFN99DYhej2NGGrxN1+XfpHiRbj3UPiTt7d+coEC9xMmD3yt5fxTuJnxQLKalV5Cj1EqgPQZ8t5F43En1EjUBbCFp7Cz/8kb+cZeR4eW3Dl5wrw2Gvvaslxvn32c8EVzjIrngsQ2/crYtaUBiUY6//4zFZ6wbzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(30864003)(2906002)(41300700001)(8936002)(8676002)(5660300002)(316002)(70206006)(70586007)(6636002)(4326008)(66899021)(110136005)(478600001)(6666004)(36756003)(7696005)(16526019)(40460700003)(186003)(66574015)(47076005)(40480700001)(86362001)(2616005)(426003)(336012)(36860700001)(82310400005)(83380400001)(82740400003)(1076003)(26005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:56.0587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99daef05-a510-4d24-a532-08db666eea09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store the waves' and shaders' JSON objects individually in STL structures
instead of keeping everything inside of a giant parent JSON object. This
is a first step towards updating individual waves.

At the same time, identify waves by their HW ID. This makes the collapsed
overview more informative and presumably behaves better if the set of
active waves changes between queries.

Also handle the CU/WGP distinction correctly for gfx10+ and add some
robustness to the active shader display.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/waves_panel.cpp | 280 ++++++++++++++++++++++--------------
 1 file changed, 170 insertions(+), 110 deletions(-)

diff --git a/src/app/gui/waves_panel.cpp b/src/app/gui/waves_panel.cpp
index fa4521e..7e13b48 100644
--- a/src/app/gui/waves_panel.cpp
+++ b/src/app/gui/waves_panel.cpp
@@ -18,149 +18,185 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
  * USE OR OTHER DEALINGS IN THE SOFTWARE.
  *
  * The above copyright notice and this permission notice (including the
  * next paragraph) shall be included in all copies or substantial portions
  * of the Software.
  */
 #include "panels.h"
 
 #include <regex.h>
+#include <unordered_map>
 
 class WavesPanel : public Panel {
 public:
 	WavesPanel(struct umr_asic *asic) : Panel(asic) {
 		/* SGPR */
 		shader_syntax.add_definition("(s[[:digit:]]+|s\\[[[:digit:]]+:[[:digit:]]+\\])", { "#d33682" });
 		/* VGPR */
 		shader_syntax.add_definition("(v[[:digit:]]+|v\\[[[:digit:]]+:[[:digit:]]+\\])", { "#6c71c4" });
 		/* Constants */
 		shader_syntax.add_definition("(0x[[:digit:]]*)\\b", { "#b58900" });
 		/* Comments */
 		shader_syntax.add_definition("(;)", { "#586e75" });
 		/* Keywords */
 		shader_syntax.add_definition("(attr[[:digit:]]+|exec|m0|[[:alpha:]]+cnt\\([[:digit:]]\\))", { "#3097a1" });
 	}
 
+	~WavesPanel() {
+		clear_waves_and_shaders();
+	}
+
+	void clear_waves_and_shaders() {
+		for (const auto &wave : waves)
+			json_value_free(json_object_get_wrapping_value(wave.wave));
+		waves.clear();
+
+		for (const auto &entry : shaders)
+			json_value_free(json_object_get_wrapping_value(entry.second));
+		shaders.clear();
+	}
+
+	std::string get_wave_id(JSON_Object *wave) {
+		unsigned se = (unsigned int)json_object_get_number(wave, "se");
+		unsigned sh = (unsigned int)json_object_get_number(wave, "sh");
+		unsigned cu = (unsigned int)json_object_get_number(wave, "cu");
+		unsigned wgp = (unsigned int)json_object_get_number(wave, "wgp");
+		unsigned simd_id = (unsigned int)json_object_get_number(wave, "simd_id");
+		unsigned wave_id = (unsigned int)json_object_get_number(wave, "wave_id");
+
+		char id[128];
+		if (asic->family < FAMILY_NV) {
+			snprintf(id, sizeof(id), "se%u.sa%u.cu%u.simd%u.wave%u", se, sh, cu, simd_id, wave_id);
+		} else {
+			snprintf(id, sizeof(id), "se%u.sa%u.wgp%u.simd%u.wave%u", se, sh, wgp, simd_id, wave_id);
+		}
+
+		return id;
+	}
+
+	size_t find_wave_by_id(const std::string &id) {
+		size_t i;
+		for (i = 0; i < waves.size(); ++i) {
+			if (waves[i].id == id)
+				break;
+		}
+		return i;
+	}
+
+	void update_shaders(JSON_Object *shaders_dict) {
+		int shaders_count = json_object_get_count(shaders_dict);
+		for (int i = 0; i < shaders_count; ++i) {
+			shaders.emplace(json_object_get_name(shaders_dict, i),
+					json_object(json_value_deep_copy(json_object_get_value_at(shaders_dict, i))));
+		}
+	}
+
 	void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) {
 		JSON_Value *error = json_object_get_value(response, "error");
 		if (error)
 			return;
 
 		JSON_Object *request = json_object(json_object_get_value(response, "request"));
 		JSON_Value *answer = json_object_get_value(response, "answer");
 		const char *command = json_object_get_string(request, "command");
 
-		if (strcmp(command, "waves"))
-			return;
+		if (strcmp(command, "waves") == 0) {
+			active_shader_wave.clear();
+			clear_waves_and_shaders();
 
-		active_shader = NULL;
-		if (last_answer) {
-			json_value_free(json_object_get_wrapping_value(last_answer));
-		}
-		last_answer = json_object(json_value_deep_copy(answer));
-
-		details.max_vgpr = 0;
-
-		JSON_Array *waves = json_array(json_object_get_value(last_answer, "waves"));
-		int wave_count = json_array_get_count(waves);
-		for (int i = 0; i < wave_count ; i++) {
-			JSON_Object *wave = json_object(json_array_get_value(waves, i));
-			JSON_Value *vgpr = json_object_get_value(wave, "vgpr");
-			if (vgpr) {
-				int s = json_array_get_count(json_array(vgpr));
-				details.max_vgpr = std::max(s, details.max_vgpr);
+			JSON_Array *waves_array = json_object_get_array(json_object(answer), "waves");
+			int wave_count = json_array_get_count(waves_array);
+			for (int i = 0; i < wave_count; ++i) {
+				JSON_Object *wave = json_object(json_value_deep_copy(json_array_get_value(waves_array, i)));
+				waves.emplace_back(get_wave_id(wave), wave);
 			}
-		}
 
-		if (details.max_vgpr) {
-			details.vgpr = (bool*)realloc(details.vgpr, wave_count * details.max_vgpr);
-			details.view = (int*)realloc(details.view, wave_count * details.max_vgpr * sizeof(int));
-			memset(details.vgpr, 0, wave_count * details.max_vgpr);
-			memset(details.view, 0, wave_count * details.max_vgpr * sizeof(int));
+			JSON_Object *shaders_dict = json_object_get_object(json_object(answer), "shaders");
+			update_shaders(shaders_dict);
+			}
+		} else {
+			return; // should be handled by a different panel
 		}
 	}
 
 	bool display(float dt, const ImVec2& avail, bool can_send_request) {
 		ImGui::Checkbox("Disable gfxoff", &turn_off_gfxoff);
 		ImGui::SameLine();
 		ImGui::Checkbox("Halt waves", &halt);
 		if (halt) {
 			ImGui::SameLine();
 			ImGui::Checkbox("Resume waves", &resume);
 		}
 		ImGui::SameLine();
 		ImGui::BeginDisabled(!can_send_request);
 		if (ImGui::Button("Query")) {
 			send_waves_command(halt, resume, turn_off_gfxoff);
 		}
 		ImGui::EndDisabled();
 
 		ImGui::Separator();
-		if (last_answer) {
+		if (!waves.empty()) {
 			ImGui::BeginChild("Waves", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
-			JSON_Array *waves = json_object_get_array(last_answer, "waves");
-			JSON_Object *shaders = json_object(json_object_get_value(last_answer, "shaders"));
 			bool force_scroll = false;
-			int w = json_array_get_count(waves);
-			for (int i = 0; i < w; i++) {
-				JSON_Object *wave = json_object(json_array_get_value(waves, i));
+			for (size_t i = 0; i < waves.size(); ++i) {
+				JSON_Object *wave = waves[i].wave;
 				JSON_Object *status = json_object(json_object_get_value(wave, "status"));
 
-				ImGui::PushID(i);
-
 				int active_threads = -1;
 				JSON_Array *threads = json_object_get_array(wave, "threads");
 				if (threads) {
 					active_threads = 0;
 					int s = json_array_get_count(threads);
 					for (int i = 0; i < s; i++) {
 						active_threads += json_array_get_boolean(threads, i);
 					}
 				}
 				const char *shader_address_str = json_object_get_string(wave, "shader");
 
 				char label[256];
 				if (active_threads < 0)
-					sprintf(label, "Wave %d", i);
+					sprintf(label, "Wave %s", waves[i].id.c_str());
 				else if (shader_address_str)
-					sprintf(label, "Wave %d (#dbde79%d threads, valid PC)", i, active_threads);
+					sprintf(label, "Wave %s (#dbde79%d threads, valid PC)", waves[i].id.c_str(), active_threads);
 				else
-					sprintf(label, "Wave %d (#dbde79%d threads)", i, active_threads);
+					sprintf(label, "Wave %s (#dbde79%d threads)", waves[i].id.c_str(), active_threads);
 
-				if (ImGui::TreeNode(label)) {
+				if (ImGui::TreeNode(waves[i].id.c_str(), "%s", label)) {
 					ImGui::Columns(3);
 					ImGui::Text("se:            #586e750x%x", (unsigned int)json_object_get_number(wave, "se"));
 					ImGui::NextColumn();
 					ImGui::Text("sh:            #586e750x%x", (unsigned int)json_object_get_number(wave, "sh"));
 					ImGui::NextColumn();
-					ImGui::Text("cu: #586e750x%x", (unsigned int)json_object_get_number(wave, "cu"));
-					ImGui::NextColumn();
+					if (asic->family < FAMILY_NV) {
+						ImGui::Text("cu: #586e750x%x", (unsigned int)json_object_get_number(wave, "cu"));
+						ImGui::NextColumn();
+					} else {
+						ImGui::Text("wgp: #586e750x%x", (unsigned int)json_object_get_number(wave, "wgp"));
+						ImGui::NextColumn();
+					}
 					ImGui::Text("simd_id:       #586e750x%x", (unsigned int)json_object_get_number(wave, "simd_id"));
 					ImGui::NextColumn();
 					ImGui::Text("wave_id:       #586e750x%x", (unsigned int)json_object_get_number(wave, "wave_id"));
 					ImGui::NextColumn();
 					ImGui::NextColumn();
 					ImGui::Text("wave_inst_dw0: #586e750x%08x", (unsigned int)json_object_get_number(wave, "wave_inst_dw0"));
 					ImGui::NextColumn();
 					ImGui::Text("wave_inst_dw1: #586e750x%08x", (unsigned int)json_object_get_number(wave, "wave_inst_dw1"));
 					ImGui::Columns(1);
 					ImGui::Separator();
 					ImGui::NextColumn();
 					ImGui::Text("PC: #b589000x%" PRIx64, (uint64_t)json_object_get_number(wave, "PC"));
 					if (shader_address_str) {
 						ImGui::SameLine();
 						if (ImGui::Button("View Shader")) {
-							active_shader = json_object(json_object_get_value(shaders, shader_address_str));
-							sscanf(shader_address_str, "%" PRIx64, &base_address);
-							pc = json_object_get_number(wave, "PC");
-
+							active_shader_wave = waves[i].id;
 							force_scroll = true;
 						}
 					} else {
 					}
 					ImGui::NextColumn();
 					if (ImGui::TreeNodeEx("Status")) {
 						ImGui::Columns(4);
 						size_t n = json_object_get_count(status);
 						for (size_t j = 0; j < n; j++) {
 							ImGui::Text("%s: #b58900%d", json_object_get_name(status, j),
@@ -245,23 +281,23 @@ public:
 							ImGui::TableSetupColumn("+ 2");
 							ImGui::TableSetupColumn("+ 3");
 							ImGui::TableHeadersRow();
 							char label[128];
 							for (int vg = 0; vg < s; vg++) {
 								ImGui::PushID(vg);
 								ImGui::TableNextRow();
 								ImGui::TableSetBgColor(ImGuiTableBgTarget_RowBg0, ImGui::GetColorU32(ImGuiCol_TableRowBgAlt));
 								ImGui::TableSetColumnIndex(0);
 								sprintf(label, "show v%2d", vg);
-								ImGui::Checkbox(label, &details.vgpr[i * details.max_vgpr + vg]);
-								if (details.vgpr[i * details.max_vgpr + vg]) {
-									int *mode = &details.view[i * details.max_vgpr + vg];
+								ImGui::Checkbox(label, &waves[i].vgpr_show[vg]);
+								if (waves[i].vgpr_show[vg]) {
+									int *mode = &waves[i].vgpr_view[vg];
 									ImGui::TableSetColumnIndex(1);
 									ImGui::RadioButton("as int", mode, 0);
 									ImGui::TableSetColumnIndex(2);
 									ImGui::RadioButton("as uint", mode, 1);
 									ImGui::TableSetColumnIndex(3);
 									ImGui::RadioButton("as hex", mode, 2);
 									ImGui::TableSetColumnIndex(4);
 									ImGui::RadioButton("as float", mode, 3);
 
 									JSON_Array *vgp = json_array_get_array(vgpr, vg);
@@ -302,102 +338,126 @@ public:
 								json_array_get_boolean(threads, i) ?
 										"#859900on" : "#dc322foff");
 							ImGui::NextColumn();
 						}
 						ImGui::Columns(1);
 						ImGui::TreePop();
 					}
 
 					ImGui::TreePop();
 				}
-				ImGui::PopID();
 			}
 			ImGui::EndChild();
 			ImGui::SameLine();
 			ImGui::BeginChild("Shaders", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
-			if (active_shader) {
-				int scroll = 0;
-				JSON_Array *op = json_object_get_array(active_shader, "opcodes");
-				uint32_t *copy = new uint32_t[json_array_get_count(op)];
-				for (size_t j = 0; j < json_array_get_count(op); j++)
-					copy[j] = (uint32_t)json_array_get_number(op, j);
-
-				uint64_t base_address = json_object_get_number(active_shader, "address");
-				char **opcode_strs = NULL;
-				umr_shader_disasm(asic, (uint8_t *)copy, json_array_get_count(op) * 4, base_address, &opcode_strs);
-
-				char tmp[128];
-				sprintf(tmp, "0x%" PRIx64, base_address);
-
-				ImGui::BeginTable("shader", 3, ImGuiTableFlags_Borders);
-				ImGui::TableSetupColumn(tmp, ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" 0x0000000000 ").x);
-				ImGui::TableSetupColumn("Raw Value", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(  "0x00000000  ").x);
-				ImGui::TableSetupColumn("Disassembly");
-				ImGui::TableHeadersRow();
-				for (size_t j = 0; j < json_array_get_count(op); j++) {
-					uint64_t addr = base_address + j * 4;
-					bool is_pc = pc == addr;
-					if (is_pc) {
-						/* PC points to this instruction */
-						scroll = ImGui::GetCursorPos().y;
-						ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0.5, 0.5, 1));
-				   }
-
-					ImGui::TableNextRow();
-					ImGui::TableSetColumnIndex(0);
-					ImGui::Text("+ 0x%lx", j * 4);
-					if (ImGui::IsItemHovered()) {
-						ImGui::BeginTooltip();
-						ImGui::Text("0x%" PRIx64, base_address + j * 4);
-						ImGui::EndTooltip();
-					}
-					ImGui::TableSetColumnIndex(1);
-					ImGui::Text("0x%08x", (uint32_t)json_array_get_number(op, j));
-					ImGui::TableSetColumnIndex(2);
-					ImGui::Text("%s", shader_syntax.transform(opcode_strs[j]));
-					free(opcode_strs[j]);
-					if (is_pc)
-						ImGui::PopStyleColor(1);
-				}
-				ImGui::EndTable();
-				free(opcode_strs);
-				delete[] copy;
-
-				if (force_scroll) {
-					ImGui::SetScrollY(scroll - avail.y / 2);
-					force_redraw();
-				}
-			} else {
-				ImGui::Text("Click on a wave's PC to show its shader disassembly");
-			}
+			display_active_shader(dt, avail, force_scroll);
 			ImGui::EndChild();
 		} else {
 			ImGui::Text("No waves.");
 		}
 		return false;
 	}
 
+	void display_active_shader(float dt, const ImVec2& avail, bool force_scroll) {
+		if (active_shader_wave.empty()) {
+			ImGui::Text("Click on a wave's PC to show its shader disassembly");
+			return;
+		}
+
+		size_t i = find_wave_by_id(active_shader_wave);
+		if (i >= waves.size()) {
+			ImGui::Text("Selected wave has disappeared");
+			return;
+		}
+
+		JSON_Object *wave = waves[i].wave;
+		const char *shader_address_str = json_object_get_string(wave, "shader");
+		auto shader_it = shaders.find(shader_address_str);
+		if (shader_it == shaders.end()) {
+			ImGui::Text("Error: Shader for selected wave is unavailable");
+			return;
+		}
+
+		JSON_Object *shader = shader_it->second;
+		uint64_t pc = json_object_get_number(wave, "PC");
+
+		int scroll = 0;
+		JSON_Array *op = json_object_get_array(shader, "opcodes");
+		uint32_t *copy = new uint32_t[json_array_get_count(op)];
+		for (size_t j = 0; j < json_array_get_count(op); j++)
+			copy[j] = (uint32_t)json_array_get_number(op, j);
+
+		uint64_t base_address = json_object_get_number(shader, "address");
+		char **opcode_strs = NULL;
+		umr_shader_disasm(asic, (uint8_t *)copy, json_array_get_count(op) * 4, base_address, &opcode_strs);
+
+		char tmp[128];
+		sprintf(tmp, "0x%" PRIx64, base_address);
+
+		ImGui::BeginTable("shader", 3, ImGuiTableFlags_Borders);
+		ImGui::TableSetupColumn(tmp, ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(" 0x0000000000 ").x);
+		ImGui::TableSetupColumn("Raw Value", ImGuiTableColumnFlags_WidthFixed, ImGui::CalcTextSize(  "0x00000000  ").x);
+		ImGui::TableSetupColumn("Disassembly");
+		ImGui::TableHeadersRow();
+		for (size_t j = 0; j < json_array_get_count(op); j++) {
+			uint64_t addr = base_address + j * 4;
+			bool is_pc = pc == addr;
+			if (is_pc) {
+				/* PC points to this instruction */
+				scroll = ImGui::GetCursorPos().y;
+				ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0, 0.5, 0.5, 1));
+			}
+
+			ImGui::TableNextRow();
+			ImGui::TableSetColumnIndex(0);
+			ImGui::Text("+ 0x%lx", j * 4);
+			if (ImGui::IsItemHovered()) {
+				ImGui::BeginTooltip();
+				ImGui::Text("0x%" PRIx64, base_address + j * 4);
+				ImGui::EndTooltip();
+			}
+			ImGui::TableSetColumnIndex(1);
+			ImGui::Text("0x%08x", (uint32_t)json_array_get_number(op, j));
+			ImGui::TableSetColumnIndex(2);
+			ImGui::Text("%s", shader_syntax.transform(opcode_strs[j]));
+			free(opcode_strs[j]);
+			if (is_pc)
+				ImGui::PopStyleColor(1);
+		}
+		ImGui::EndTable();
+		free(opcode_strs);
+		delete[] copy;
+
+		if (force_scroll) {
+			ImGui::SetScrollY(scroll - avail.y / 2);
+			force_redraw();
+		}
+	}
+
 private:
 	void send_waves_command(bool halt_waves, bool resume_waves, bool disable_gfxoff) {
 		JSON_Value *req = json_value_init_object();
 		json_object_set_string(json_object(req), "command", "waves");
 		json_object_set_boolean(json_object(req), "halt_waves", halt_waves);
 		json_object_set_boolean(json_object(req), "resume_waves", halt_waves && resume_waves);
 		json_object_set_boolean(json_object(req), "disable_gfxoff", disable_gfxoff);
 		json_object_set_string(json_object(req), "ring", asic->family >= FAMILY_NV ? "gfx_0.0.0" : "gfx");
 		send_request(req);
 	}
 private:
+	struct Wave {
+		std::string id; // "seN.saN.etc"
+		JSON_Object *wave;
+		bool vgpr_show[512] = {};
+		int vgpr_view[512] = {};
+
+		Wave(std::string id, JSON_Object *wave) : id(id), wave(wave) {}
+	};
+
 	SyntaxHighlighter shader_syntax;
-	JSON_Object *last_answer = NULL;
-	JSON_Object *active_shader = NULL;
-	uint64_t base_address;
-	uint64_t pc;
-	struct {
-		bool *vgpr = NULL;
-		int *view = NULL;
-		int max_vgpr;
-	} details;
+	std::vector<Wave> waves;
+	std::unordered_map<std::string, JSON_Object *> shaders;
+	std::string active_shader_wave;
 	bool halt = true;
 	bool resume = true;
 	bool turn_off_gfxoff = true;
 };
-- 
2.40.0

