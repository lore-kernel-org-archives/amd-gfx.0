Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BB3C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3159E10E312;
	Tue,  6 Jun 2023 09:18:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB58310E324
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgzQWw/2Z9RkXHN7acblRW/qnJpeO2ckI83EIZxJlFxxUNRrIrk10aK0CIw4AJsn3EKRon6TGEmU58CHTdQQlDoRjhbUQUl4JHghlWnHmwLLqeOUTVjbysfQxSC0smE0d2PFMviXI2Z1z16OTa6Z/BbbPNs6ugscHDVaUGm1RMjuTMUw/NTDw4Sr/3IIxfnQg+eXTKugC2BhUvpiLiEcAjeqOwTN4PhRtMPZin8lEnBXxWmea/Ky/xK7uyyHkunwnp6uwnYByhjJ2UZnHwcMX8diRhSLM653i1PTF0BEr5pfu3BglyRbutsj1djlMEMR99OA1jJmW/BC+unsL3r0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGsvaYQq0KEHhNLtZDfQBQeg8Iu4kG+6Bc2h7Btu6do=;
 b=HMAIDSuAGUYCk7/6LfS2ajFAALcLRWXWFz027CN1OkObNiOp4R4Nf/dLnoITr9XH+1xy+43fEb1RYMrFOOod4Wwed0yM3OHljUIFV8jwa74ZDzdFL2iM3mP6BiHt/ywaR6W4s4/GA45UQRruBXW9QbhLHw6Rl4asOj8uAKMfULSUkurOx7dU49sX3zKf2VZE6/XOxDx8ZAfFlg4sE1fssyfP5IT9pj/DiRhF2arhysyppVvWmDMkrMGZmRjuWE6k2gbn9GvH2RcVCaSDqqnYg8Wf13ls6nHmhWp6Am93oB6TMe6ZdnydbUC/ZkDc9ZtVoJXd2tCLBuHDy0haPDn2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGsvaYQq0KEHhNLtZDfQBQeg8Iu4kG+6Bc2h7Btu6do=;
 b=Rkirrgxh5wTynwy4eQD08tCUExY5AEAy68LJXs43/VpRYmuhPCuerUXySFQyKl5oq4QUIza+StvMPfDussNe5tJrWWJU625Y2OeUVHPqGqxwfK8iENugMf3IBu758/62P4ZbXhKQ1FSaqOK8jQyPZ10BcMHRc/qxE2nocCzZ75c=
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:18:01 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::1a) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 09:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:18:01 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:18:00 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 17/17] gui/waves_panel: grey out inactive lanes of VGPRs
Date: Tue, 6 Jun 2023 11:17:25 +0200
Message-ID: <20230606091725.20080-18-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: b6713ed0-0355-4534-6fa3-08db666eed2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f3ykRh5FHeZ7W5MdQzoiFyRCnk9flBkun1RhYkbIqkxvCz55GX6K8DDuuXZAPuR7r0TBWbhM3vsrefml37DB5VF5k+/59tW+bI7lOBLRguJbtWi51GMX6ipfq5wJvP/mbU85D40sRAKEpSefweqFllMtVGjhzf869nV/Hm7it/E8/1F6n6xCZWGT/wrc6rtqbjRRy48R5BPp4jXQZgawC/3rgna2/lnfDlkZO3st6rOMHdy4g7eULL7FgKRQdZgYPzog6Wwa3b4vxT9ZhrcSj6rc03g5DX0kzSCTBhl3PyryFUiKTRdZSTNgBWJjTIV2WhjDqWzaMPAlTlmY22t1B3v7cTQE0vnJHUETSQkJAUo//Eq0NOfXggKzeZLaLRUrN10lEnnYpq+sgLG8W1PCgbz1eWAmj7T5F4NwiN5KogVJGj8qYfLK2gn8AxVVP7Vk21yl6OQD7KWzWuM7hAtZb/+s2QJDG7EOX9KxM95uVvYHePNW8A2IDdd5SH7IOhhqYpSY9Y1yQrSK62qyKIsmcA+FWWpR+ayW00LVt3g4AwcjCZRcZ6OqNrWheX9NLdyNbxgC91swK2pfDWLp1kPvnU5FhIJz+o+vPXdFBCbP1BFYRUNATiiDstR+tJbTNqKH/lVPWxdPv3F2Yjh9gdkmz1i7cL9z9nah4EWAWuivAJofRQU4HM+Ca+yqNBvf71uSiyOo96scWVHAFrY+ko8j8qtOtVxUdEvQ/hd5gAI0r87vVcyXf4TtjQFk07frBfwyTei8AhzmzaCekenCXBojDwrQk6znQAeHChdfK9FvZk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(110136005)(36756003)(40460700003)(2906002)(82310400005)(478600001)(86362001)(41300700001)(8676002)(5660300002)(8936002)(82740400003)(316002)(16526019)(356005)(81166007)(40480700001)(4326008)(6636002)(70586007)(70206006)(83380400001)(47076005)(1076003)(2616005)(26005)(186003)(426003)(36860700001)(336012)(7696005)(6666004)(17423001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:18:01.3395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6713ed0-0355-4534-6fa3-08db666eed2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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
 src/app/gui/waves_panel.cpp | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/app/gui/waves_panel.cpp b/src/app/gui/waves_panel.cpp
index 68b06ea..cc37a1b 100644
--- a/src/app/gui/waves_panel.cpp
+++ b/src/app/gui/waves_panel.cpp
@@ -153,26 +153,30 @@ public:
 
 		ImGui::Separator();
 		if (!waves.empty()) {
 			ImGui::BeginChild("Waves", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
 			bool force_scroll = false;
 			for (size_t i = 0; i < waves.size(); ++i) {
 				JSON_Object *wave = waves[i].wave;
 				JSON_Object *status = json_object(json_object_get_value(wave, "status"));
 
 				int active_threads = -1;
+				uint64_t exec = 0;
 				JSON_Array *threads = json_object_get_array(wave, "threads");
 				if (threads) {
 					active_threads = 0;
 					int s = json_array_get_count(threads);
 					for (int i = 0; i < s; i++) {
-						active_threads += json_array_get_boolean(threads, i);
+						bool active = json_array_get_boolean(threads, i) == 1;
+						active_threads += active ? 1 : 0;
+						if (active)
+							exec |= (uint64_t)1 << i;
 					}
 				}
 				const char *shader_address_str = json_object_get_string(wave, "shader");
 
 				char label[256];
 				if (active_threads < 0)
 					sprintf(label, "Wave %s", waves[i].id.c_str());
 				else if (shader_address_str)
 					sprintf(label, "Wave %s (#dbde79%d threads, valid PC)", waves[i].id.c_str(), active_threads);
 				else
@@ -288,21 +292,22 @@ public:
 								ImGui::PopID();
 								ImGui::NextColumn();
 							}
 							ImGui::PopID();
 							ImGui::Columns(1);
 							ImGui::TreePop();
 						}
 					}
 
 					{
-						static const char *formats[] = { "#6c71c4%d", "#6c71c4%u", "#6c71c4%08x" };
+						static const char *formats_active[] = { "#6c71c4%d", "#6c71c4%u", "#6c71c4%08x", "#6c71c4%f" };
+						static const char *formats_inactive[] = { "#818181%d", "#818181%u", "#818181%08x", "#818181%f" };
 						JSON_Array *vgpr = json_object_get_array(wave, "vgpr");
 						if (vgpr && ImGui::TreeNodeEx("#6c71c4VGPRs")) {
 							int s = json_array_get_count(vgpr);
 
 							ImGui::BeginTable("vgprvalues", 5, ImGuiTableFlags_Borders);
 							ImGui::TableSetupColumn("Base");
 							ImGui::TableSetupColumn("+ 0");
 							ImGui::TableSetupColumn("+ 1");
 							ImGui::TableSetupColumn("+ 2");
 							ImGui::TableSetupColumn("+ 3");
@@ -330,26 +335,28 @@ public:
 									int num_thread = json_array_get_count(vgp);
 
 									for (int t = 0; t < num_thread; t++) {
 										if (t % 4 == 0) {
 											ImGui::TableNextRow();
 											ImGui::TableSetColumnIndex(0);
 											ImGui::Text("%d", t);
 										}
 										ImGui::TableSetColumnIndex(1 + t % 4);
 
+										const char **formats = (exec >> t) & 1 ? formats_active : formats_inactive;
+
 										JSON_Value *v = json_array_get_value(vgp, t);
 										ImGui::PushID(v);
 										int aaa = (int)json_number(v);
 										if (*mode == 3) {
 											float f = reinterpret_cast<float&>(aaa);
-											ImGui::Text("#6c71c4%f", f);
+											ImGui::Text(formats[3], f);
 										} else {
 											ImGui::Text(formats[*mode], aaa);
 										}
 										ImGui::PopID();
 									}
 								}
 								ImGui::PopID();
 							}
 							ImGui::EndTable();
 							ImGui::TreePop();
-- 
2.40.0

