Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A9AC7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EFD10E31F;
	Tue,  6 Jun 2023 09:18:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBCB10E315
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLuBZOUKTmIa70TMSK1udPQmQ/Zs/Vvu1iyNCvHEi1JIlR3DH/Z1DYWyuSLOJVkCm1GM64Wm+glPF6zo0rK+foDvgD3kOtqFKdFGvPhxh/m2jR6dyow38riBOxj6Swo4rWhAbRuYa5z/anSuCch3WQKivnI+KWTnHnfE+obitpjxIafsftS6RUMb75F0wNjKj9NHzYzwboGsyFrRUuKxYesW1TXBqQ2UY8A2bswHP01yGKPT5BZIIfCuefINYlsdpckuNRC9P260bm0hfvy6YyRZEANeXKS7DG7YAPkBcSpyhgF4au1q7qK1BIyxSHHhhu/+NPgHQmmfxyB1IDyemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKeE6K4G6WWjFlQyq1urB5+RZIeK5FHXtAD66pjUv2E=;
 b=Ai6JZitFWyclLJjCZPD8uvFFZbrXTrJvTlT0HUWJDIAnd+Y+KlkMROApVcnl2ACOlrFgPYkf8HHjCBeYUo2qyuYGZjP7SXhGQQOchTqtuStrJrnQvPAle1m/e7x5txmhCKq/9pDQA9IAPCt+qACWYfvep7oYZanXYwmAFTLfou3FAs9XYyFC6p1rPFTGPw3A8mwaj7uT2Q7DFnmAqoV5XRMHCL1OR9KUYTKwzKqsSXBT0GXZ7Lvt2ZiezIYt/p7ZGBO4HDL3YVj1Hc1s0UywZg34ZLyZc1yfdx7mcke8HiKTFjAv0UBBaN9vI3UcMrkU9rbppv9kjHRLyJktk1EbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKeE6K4G6WWjFlQyq1urB5+RZIeK5FHXtAD66pjUv2E=;
 b=GjLQxawJrWoHaZgtmAYJhjQsKgVKRRyjbE3hWisO0XrPxHfgYWfqeO+lKEyCJVAfc5E2gWbKyoCqInGQ7IZRX3YNwys+b1aJyJRWWAWvNIPNN14blwVg+pcF+jCkUD+tEXFxfLopkGv2draIa2i/H5tVRKin4Qju2T+i1bNYVx8=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:56 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::f4) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 04:17:55 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 12/17] server/waves: always report threads (exec)
Date: Tue, 6 Jun 2023 11:17:20 +0200
Message-ID: <20230606091725.20080-13-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d828c0-7ce3-4c5c-b382-08db666eea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kazXICoVIs56Yi7vTTr1a9DJa20QivuAq3rICUv62Gor4+JNFp96eK7EC0xqrn2bkvFRMI0npZcTAZkzebJClMBS6atuttUpVwFlPs03vQ2vC80AuJXul5bQgYyGy9LozXVvCtYnH4iG4zWdOHB74ZyxUjqLMXqg1RggjWuzyCT6yhV5HjpKBPMxJqcHCf0BgUq5VsRzV9GeeVB6mUvX9X1GsUiUwes1rphEN+BPsBth+k0b/JaKXmPu4a+31T9vAEO2rtBGf3oSRAA7CtqBnCTo6uGg4ziclR01OjYnZ81TrcLMWVfgIR2Vl8O/kI5rwf13aU7Zg9Ihdgt4GxvaNFIJ4TtzoQDj1Ib9f5XRWLmpLjIlYjDtaEucSJs3hZ4jw69OKlooWq4VRE+fQ5SgWwSm4ZuZhqPb3/4M43UpmilGjO1C/tlVPOlE0bG8l+/n09/3WjYU48Hl6TzD2epwoK5TD1rSe7WabuYCpeGXyZQujlOynyqDs6m/tCpKprqxNDx8DUNXyowQUsBlIbfDEAzpzFySOndtMMSiUMscORTnWcGpFvoilUP5Hgxk8zd4r0xEhLbGK4haJAaIvlTzxT0ahqIGMFJ3RsIGxyD1quULihbvf63ghQI3yHJ3g9HWkpQbPkhHOx66r8AhD6Ifz9K5MplZt5+9mjPi/5VIJ81stfjljlvfniaG7DTxsQ1ftt//8gGv6hPVM60v1ITe1izGK92JeiD19PKRhnzTYIsJpianSFR7k++dxIWvWQ2buwTlyGSMJ9I95SkOJyRG8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(1076003)(2616005)(41300700001)(426003)(336012)(6666004)(47076005)(26005)(186003)(36860700001)(16526019)(83380400001)(40460700003)(82740400003)(478600001)(40480700001)(110136005)(82310400005)(6636002)(316002)(81166007)(356005)(70586007)(70206006)(4326008)(8676002)(5660300002)(8936002)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:56.5899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d828c0-7ce3-4c5c-b382-08db666eea5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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

exec is read like the wave status and should be equally reliable or unreliable

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/gui/commands.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/app/gui/commands.c b/src/app/gui/commands.c
index b7b28a7..1e5e854 100644
--- a/src/app/gui/commands.c
+++ b/src/app/gui/commands.c
@@ -1618,20 +1618,28 @@ static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shade
 			json_object_set_number(json_object(hw_id), "pipe_id", wd->ws.hw_id2.pipe_id);
 			json_object_set_number(json_object(hw_id), "me_id", wd->ws.hw_id2.me_id);
 			json_object_set_number(json_object(hw_id), "state_id", wd->ws.hw_id2.state_id);
 			json_object_set_number(json_object(hw_id), "wg_id", wd->ws.hw_id2.wg_id);
 			json_object_set_number(json_object(hw_id), "compat_level", wd->ws.hw_id2.compat_level);
 			json_object_set_number(json_object(hw_id), "vm_id", wd->ws.hw_id2.vm_id);
 			vmid = wd->ws.hw_id2.vm_id;
 		}
 		json_object_set_value(json_object(wave), "hw_id", hw_id);
 
+		JSON_Value *threads = json_value_init_array();
+		int num_threads = wd->num_threads;
+		for (int thread = 0; thread < num_threads; thread++) {
+			unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
+			json_array_append_boolean(json_array(threads), live ? 1 : 0);
+		}
+		json_object_set_value(json_object(wave), "threads", threads);
+
 		JSON_Value *gpr_alloc = json_value_init_object();
 		json_object_set_number(json_object(gpr_alloc), "vgpr_base", wd->ws.gpr_alloc.vgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "vgpr_size", wd->ws.gpr_alloc.vgpr_size);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_base", wd->ws.gpr_alloc.sgpr_base);
 		json_object_set_number(json_object(gpr_alloc), "sgpr_size", wd->ws.gpr_alloc.sgpr_size);
 		json_object_set_value(json_object(wave), "gpr_alloc", gpr_alloc);
 
 		if (is_halted && wd->ws.gpr_alloc.value != 0xbebebeef) {
 			int sgpr_count;
 			if (asic->family <= FAMILY_AI) {
@@ -1639,29 +1647,20 @@ static void wave_to_json(struct umr_asic *asic, int is_halted, int include_shade
 				sgpr_count = (wd->ws.gpr_alloc.sgpr_size + 1) << shift;
 			} else {
 				sgpr_count = 108; // regular SGPRs and VCC
 			}
 			JSON_Value *sgpr = json_value_init_array();
 			for (int x = 0; x < sgpr_count; x++) {
 				json_array_append_number(json_array(sgpr), wd->sgprs[x]);
 			}
 			json_object_set_value(json_object(wave), "sgpr", sgpr);
 
-			JSON_Value *threads = json_value_init_array();
-			int num_threads = wd->num_threads;
-			for (int thread = 0; thread < num_threads; thread++) {
-				unsigned live = thread < 32 ? (wd->ws.exec_lo & (1u << thread))	: (wd->ws.exec_hi & (1u << (thread - 32)));
-				json_array_append_boolean(json_array(threads), live ? 1 : 0);
-			}
-			json_object_set_value(json_object(wave), "threads", threads);
-
-
 			if (wd->have_vgprs) {
 				unsigned granularity = asic->parameters.vgpr_granularity;
 				unsigned vpgr_count = (wd->ws.gpr_alloc.vgpr_size + 1) << granularity;
 				JSON_Value *vgpr = json_value_init_array();
 				for (int x = 0; x < (int) vpgr_count; x++) {
 					JSON_Value *v = json_value_init_array();
 					for (int thread = 0; thread < num_threads; thread++) {
 						json_array_append_number(json_array(v), wd->vgprs[thread * 256 + x]);
 					}
 					json_array_append_value(json_array(vgpr), v);
-- 
2.40.0

