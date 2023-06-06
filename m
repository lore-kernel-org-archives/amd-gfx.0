Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD07C7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5569010E321;
	Tue,  6 Jun 2023 09:18:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8872F10E320
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLV8EeA5foBD+7BIfgi7DzPaFIwZ4UH6g2XvoDrNynmpRozhaW/bIJBl/8kwc2g4NMP3AIeybMkYNGVNX5z3fWBxN29+ox4VtrwIBfR9NyTGT+oUnjbzFVIO9Iwpz7oTq9Ajq5QTdFutRF/KGRk3ZEYiVHOx29fcmYCZVhCx5xtwg3+BFUpd/v3oUZN0O7IOb99GiGBKeAscwY5k3ibaTtaEd1N1ji3i8RKEYU3vHFh/PnUooQRKSPC6Qt2By4W2ySd3XRLf7FTs7ZDg8+vcTphGhvN4gt+RrA93mFIEQjjktDueC7KJxxKfnVAwnk9QUtCtDDc+f8ONqHR/1WJTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpgEXzriLe0bRYTYsa1eM9mOyzh+aTwP8uo2hGHKgGQ=;
 b=VUDVcbxGT6q6c1WG4OBpdKrMI7SyiCBzBKs+IUKd/smkKYDW8uoja7l0OwU5x5+PCoOEEBv/dnlsNkqsdmugL5uJelBa/pk1aVj8bXN9rOC2b9C7sGQrr1dmPujaBJD1wcB4z8MPNu4keIgywFaLxHtKGygHIIkqGf67rDK+dwAZob2RHe96GKC1BOjzoJ1odrXap8yzp8Hvi/GdwlIhqXp0docWbpON/lGmAASe/sUuBAQuTNCDJdIf6+kvFPPCYapnR/gU8A4yVSuQbEABBazYZWFEPp0eDj5xJMmTf/A9JL48FAO383UY914WgDFMB9U51+S4EdUSNAw+KPzF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpgEXzriLe0bRYTYsa1eM9mOyzh+aTwP8uo2hGHKgGQ=;
 b=vhYv4ckE+deO+vCIBN6/9XHj0qK0tGs+JV/tGMZytOdUJUA+wIfac4b6/LTtNyWL0zLsh/IAuHUGODChdYaBxaGD3omPFDAjgTn0utLwyOZqCTNL0XCbV8wib5rKY9i/uaUQYwU5Kwsu7+BFVsx8rJQjBzGZNYlRwXtEg9SNEmY=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:18:00 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::5f) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:18:00 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:59 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 16/17] gui: add a wave single step button
Date: Tue, 6 Jun 2023 11:17:24 +0200
Message-ID: <20230606091725.20080-17-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: b29ef301-e54c-489c-c5b5-08db666eecc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bq1Q58Gmx9M1cv3kPqTxOJSTHvpbszfztR7sqtphevZVNBEydW648EIQpvFnWHnn/hW9qXKqDXVVJkl23OTNILYZuinPb4nn3t1u+UEwxYFvA0pEma3a0JRpe9bWU2psmnjiwy/V3eETX0cqsG7Kv3uZWJkEtMmO/YnKqrb6sBBqGLKk4YDj6PKRmqJkcuBANJtAgsTsk3S6ei5TYlB+ee3si8p5YEYkA8/acNojwbVbqNEl6ojEL47RNcItnoUnp52CR7GTgCKseeywP4AUPjSoMgb0KJ9IsgiuXXuXcxD6ZwSFkcOvVjKv8BgjawY8GI9veYGoCOR6JHIfVp4IKc3AQoYjOc3at02jmsqIO9GsKudZSbGXj0T7T5rR41fntN28ZMbDvQvCkTQRn1C94UWAr2n4FhzLyCRBmkb0+lyYzwIorojWIVoWI0W7dhJEmFusBS2IW6CiYNzIskw76oC/I9FbHkN7eLyy1FYBtFEhWm6QWR3bJ9eX8VqDsbmJMoLLmlPMcV+8E9ly8iJgMsZHyWGwwhBWRAnVXMb4nmsa1+X3HYOTl3USDHFfhPAhUwub5EBZjDG+NyjjUgJ0F7+BAifERxIK56uBsn22VXIJOv2hlwg2/GHMf8qppWeh8BZ39odkRu1RepLTzCC+x/RpobBRNFqlNh9gwiPRCw59E0ko8kI3qbR7tpU+NsQCdw3Ej2jrABXKZujxb2aVhwROLbfz6M4pZ7XWary5wOm9Ym+5+0txAXELVeSxNRWBP7ceZGNR70QAqL1TIQZy9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(110136005)(36756003)(82310400005)(40460700003)(2906002)(478600001)(8936002)(41300700001)(86362001)(8676002)(5660300002)(82740400003)(316002)(356005)(81166007)(4326008)(6636002)(70206006)(70586007)(83380400001)(40480700001)(47076005)(66574015)(1076003)(2616005)(26005)(186003)(36860700001)(426003)(336012)(16526019)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:18:00.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29ef301-e54c-489c-c5b5-08db666eecc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/commands.c      | 50 +++++++++++++++++++++++++++++++++++++
 src/app/gui/waves_panel.cpp | 40 +++++++++++++++++++++++++++++
 src/lib/scan_waves.c        |  2 +-
 src/umr.h                   |  2 ++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/src/app/gui/commands.c b/src/app/gui/commands.c
index 38ae44d..fb6efa0 100644
--- a/src/app/gui/commands.c
+++ b/src/app/gui/commands.c
@@ -2036,20 +2036,70 @@ JSON_Value *umr_process_json_request(JSON_Object *request, void **raw_data, unsi
 		answer = json_value_init_object();
 
 		waves_to_json(asic, ring_is_halted, 1, json_object(answer));
 
 		if (disable_gfxoff && asic->fd.gfxoff >= 0) {
 			uint32_t value = 1;
 			write(asic->fd.gfxoff, &value, sizeof(value));
 		}
 		if (resume_waves)
 			umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
+	} else if (strcmp(command, "singlestep") == 0) {
+		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));
+
+		unsigned se = (unsigned)json_object_get_number(request, "se");
+		unsigned sh = (unsigned)json_object_get_number(request, "sh");
+		unsigned wgp = (unsigned)json_object_get_number(request, "wgp");
+		unsigned simd_id = (unsigned)json_object_get_number(request, "simd_id");
+		unsigned wave_id = (unsigned)json_object_get_number(request, "wave_id");
+
+		asic->options.skip_gprs = 0;
+		asic->options.verbose = 0;
+
+		struct umr_wave_data wd;
+		memset(&wd, 0, sizeof(wd));
+
+		int r = umr_scan_wave_slot(asic, se, sh, wgp, simd_id, wave_id, &wd);
+		if (r < 0) {
+			last_error = "failed to scan wave slot";
+			goto error;
+		}
+
+		// Send the single-step command in a limited retry loop because a small number of
+		// single-step commands are required before an instruction is actually issued after
+		// a branch.
+		for (int retry = 0; r == 1 && retry < 5; ++retry) {
+			umr_sq_cmd_singlestep(asic, se, sh, wgp, simd_id, wave_id);
+
+			struct umr_wave_data new_wd;
+			memset(&new_wd, 0, sizeof(new_wd));
+
+			r = umr_scan_wave_slot(asic, se, sh, wgp, simd_id, wave_id, &new_wd);
+			if (r < 0) {
+				last_error = "failed to scan wave slot";
+				goto error;
+			}
+
+			bool moved = new_wd.ws.pc_lo != wd.ws.pc_lo || new_wd.ws.pc_hi != wd.ws.pc_hi;
+			memcpy(&wd, &new_wd, sizeof(wd));
+			if (moved)
+				break;
+		}
+
+		answer = json_value_init_object();
+
+		if (r == 1) {
+			JSON_Value *shaders = json_value_init_object();
+			JSON_Value *wave = wave_to_json(asic, &wd, 1, /* todo: stream */NULL, shaders);
+			json_object_set_value(json_object(answer), "wave", wave);
+			json_object_set_value(json_object(answer), "shaders", shaders);
+		}
 	} else if (strcmp(command, "resume-waves") == 0) {
 		strcpy(asic->options.ring_name, json_object_get_string(request, "ring"));
 		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_RESUME);
 		answer = json_value_init_object();
 	} else if (strcmp(command, "ring") == 0) {
 		char *ring_name = (char*)json_object_get_string(request, "ring");
 		uint32_t wptr, rptr, drv_wptr, ringsize, value, *ring_data;
 		int halt_waves = json_object_get_boolean(request, "halt_waves");
 		enum umr_ring_type rt;
 		asic->options.halt_waves = halt_waves;
diff --git a/src/app/gui/waves_panel.cpp b/src/app/gui/waves_panel.cpp
index 7e13b48..68b06ea 100644
--- a/src/app/gui/waves_panel.cpp
+++ b/src/app/gui/waves_panel.cpp
@@ -106,21 +106,38 @@ public:
 
 			JSON_Array *waves_array = json_object_get_array(json_object(answer), "waves");
 			int wave_count = json_array_get_count(waves_array);
 			for (int i = 0; i < wave_count; ++i) {
 				JSON_Object *wave = json_object(json_value_deep_copy(json_array_get_value(waves_array, i)));
 				waves.emplace_back(get_wave_id(wave), wave);
 			}
 
 			JSON_Object *shaders_dict = json_object_get_object(json_object(answer), "shaders");
 			update_shaders(shaders_dict);
+		} else if (strcmp(command, "singlestep") == 0) {
+			JSON_Object *wave = json_object(json_value_deep_copy(json_object_get_value(json_object(answer), "wave")));
+			std::string id = get_wave_id(wave ? wave : request);
+			size_t i = find_wave_by_id(id);
+			if (i < waves.size()) {
+				json_value_free(json_object_get_wrapping_value(waves[i].wave));
+				if (wave) {
+					waves[i].wave = wave;
+				} else {
+					waves.erase(waves.begin() + i);
+				}
+			} else {
+				if (wave)
+					waves.emplace_back(id, wave);
 			}
+
+			JSON_Object *shaders_dict = json_object_get_object(json_object(answer), "shaders");
+			update_shaders(shaders_dict);
 		} else {
 			return; // should be handled by a different panel
 		}
 	}
 
 	bool display(float dt, const ImVec2& avail, bool can_send_request) {
 		ImGui::Checkbox("Disable gfxoff", &turn_off_gfxoff);
 		ImGui::SameLine();
 		ImGui::Checkbox("Halt waves", &halt);
 		if (halt) {
@@ -185,20 +202,29 @@ public:
 					ImGui::Columns(1);
 					ImGui::Separator();
 					ImGui::NextColumn();
 					ImGui::Text("PC: #b589000x%" PRIx64, (uint64_t)json_object_get_number(wave, "PC"));
 					if (shader_address_str) {
 						ImGui::SameLine();
 						if (ImGui::Button("View Shader")) {
 							active_shader_wave = waves[i].id;
 							force_scroll = true;
 						}
+						if (asic->family >= FAMILY_NV) {
+							ImGui::SameLine();
+							ImGui::BeginDisabled(!can_send_request);
+							if (ImGui::Button("Single step")) {
+								active_shader_wave = waves[i].id;
+								send_singlestep_command(waves[i].wave);
+							}
+							ImGui::EndDisabled();
+						}
 					} else {
 					}
 					ImGui::NextColumn();
 					if (ImGui::TreeNodeEx("Status")) {
 						ImGui::Columns(4);
 						size_t n = json_object_get_count(status);
 						for (size_t j = 0; j < n; j++) {
 							ImGui::Text("%s: #b58900%d", json_object_get_name(status, j),
 														 (unsigned)json_number(json_object_get_value_at(status, j)));
 							ImGui::NextColumn();
@@ -436,20 +462,34 @@ public:
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
+
+	void send_singlestep_command(JSON_Object *wave) {
+		assert(asic->family >= FAMILY_NV);
+		JSON_Value *req = json_value_init_object();
+		json_object_set_string(json_object(req), "command", "singlestep");
+		json_object_set_string(json_object(req), "ring", asic->family >= FAMILY_NV ? "gfx_0.0.0" : "gfx");
+		json_object_set_number(json_object(req), "se", json_object_get_number(wave, "se"));
+		json_object_set_number(json_object(req), "sh", json_object_get_number(wave, "sh"));
+		json_object_set_number(json_object(req), "wgp", json_object_get_number(wave, "wgp"));
+		json_object_set_number(json_object(req), "simd_id", json_object_get_number(wave, "simd_id"));
+		json_object_set_number(json_object(req), "wave_id", json_object_get_number(wave, "wave_id"));
+		send_request(req);
+	}
+
 private:
 	struct Wave {
 		std::string id; // "seN.saN.etc"
 		JSON_Object *wave;
 		bool vgpr_show[512] = {};
 		int vgpr_view[512] = {};
 
 		Wave(std::string id, JSON_Object *wave) : id(id), wave(wave) {}
 	};
 
diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
index ca1d9fb..533c5d0 100644
--- a/src/lib/scan_waves.c
+++ b/src/lib/scan_waves.c
@@ -530,21 +530,21 @@ int umr_parse_wave_data_gfx(struct umr_asic *asic, struct umr_wave_status *ws, c
 	else
 		return umr_parse_wave_data_gfx_10_11(asic, ws, buf);
 }
 
 /**
  * Scan the given wave slot. Return true and fill in \p pwd if a wave is present.
  * Otherwise, return false.
  *
  * \param cu the CU on <=gfx9, the WGP on >=gfx10
  */
-static int umr_scan_wave_slot(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu,
+int umr_scan_wave_slot(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu,
 			       uint32_t simd, uint32_t wave, struct umr_wave_data *pwd)
 {
 	unsigned thread, num_threads;
 	int r;
 
 	if (asic->family <= FAMILY_AI)
 		r = asic->wave_funcs.get_wave_status(asic, se, sh, cu, simd, wave, &pwd->ws);
 	else
 		r = asic->wave_funcs.get_wave_status(asic, se, sh, MANY_TO_INSTANCE(cu, simd), 0, wave, &pwd->ws);
 
diff --git a/src/umr.h b/src/umr.h
index 8981986..030124f 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -1392,20 +1392,22 @@ void umr_free_maps(struct umr_asic *asic);
 void umr_close_asic(struct umr_asic *asic); // call this to close a fully open asic
 int umr_query_drm(struct umr_asic *asic, int field, void *ret, int size);
 int umr_query_drm_vbios(struct umr_asic *asic, int field, int type, void *ret, int size);
 int umr_update(struct umr_asic *asic, char *script);
 int umr_update_string(struct umr_asic *asic, char *sdata);
 
 /* lib helpers */
 uint32_t umr_get_ip_revision(struct umr_asic *asic, const char *ipname);
 int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws);
 struct umr_wave_data *umr_scan_wave_data(struct umr_asic *asic);
+int umr_scan_wave_slot(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t cu,
+		       uint32_t simd, uint32_t wave, struct umr_wave_data *pwd);
 int umr_read_wave_status_via_mmio_gfx8_9(struct umr_asic *asic, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields);
 int umr_read_wave_status_via_mmio_gfx_10_11(struct umr_asic *asic, uint32_t wave, uint32_t *dst, int *no_fields);
 int umr_parse_wave_data_gfx(struct umr_asic *asic, struct umr_wave_status *ws, const uint32_t *buf);
 int umr_get_wave_sq_info_vi(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws);
 int umr_get_wave_sq_info(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws);
 int umr_read_sgprs(struct umr_asic *asic, struct umr_wave_status *ws, uint32_t *dst);
 int umr_read_vgprs(struct umr_asic *asic, struct umr_wave_status *ws, uint32_t thread, uint32_t *dst);
 int umr_read_sensor(struct umr_asic *asic, int sensor, void *dst, int *size);
 
 /* mmio helpers */
-- 
2.40.0

