Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213BCCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA35F10E2D2;
	Wed,  5 Nov 2025 15:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLwAJLRe";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BAC10E2D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZVunRbrk5D4EByo8IWMlMFD9CU26xGgaeoxXVO8D57Yq2/xpJpS/67PmaCWpcbN+fZMTWu80R8ERGPD51VltcMxuyMGZ2XFIWbkBpArnEArTi+63RxWl7Z2EWPI0H+jpz905ORVFSCceNkfji/B5uR/hvTesjliKosqJ8SOrGqyReuT2Gnm+xIWLat0OQe1i/2aHp2hSgf7Tp53XrGMzcvVsw3Y8iwYNpfPMuqt+NEY4q4gS+kdwUmaiFOqEfoTPv1ASESNPlo/nyTSKV9exuAL+gbrWIGNqJthBmSvAwzZcO3luX+PZw2NLX2Bcwkl9+IeuFXXy+aYV1faW2glsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSkfTxgwCdRwqo2BuQH3yB+LD3Dj08rHp9P7mMD1Gnk=;
 b=HJWelHcTzq/Cw8Fl0oLNQhJCBKUlnzfhANcA15TxaYijbVnRK/mLKcxlfPS2gxc9JDWXqxP1ZnLVrNIEw0GZSoq0tiOvg0j/6Rxep/ejA+DhjnYaCV4yBdMWw8KgeJU/hoyVxJReAnGFt6X0Hd1DgsqT/BuZKYFXGSslaWDq19QVaRIlYAfs1Jc4QDiadDrNYEZD1u568ZvrcIuMmv21GIuZkPnhpEquIJnfMOimndSf9TBghbIgE3jqctB9mgkcZ7TFyBXeErNpxL+HoBBNssWqoo0xTnJtAvRIWAzXvF0BJEtdKIu8Y1c244LahG77sq5fzck8Fuljb4Q7yCJKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSkfTxgwCdRwqo2BuQH3yB+LD3Dj08rHp9P7mMD1Gnk=;
 b=hLwAJLReZVMTpEauyfS7WHsN8S6UcW6oR7JgIX1nDeGWEsgwOlcUz6Vn77CiOo2iNBXB3cFKQmWwhtA6gqg1dCjYJrOmScK2SaHG4qvnXBV6gnmWDud6/XqMtAA/QN9MoaKTLYINqlfax+Jb8j0gIMCK1Pdm3QpS0Zo90ZdZvYE=
Received: from BY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:a03:1b8::45)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:41:16 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d8) by BY5PR17CA0032.outlook.office365.com
 (2603:10b6:a03:1b8::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 15:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 15:41:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:57 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:40:57 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:56 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Chen <leo.chen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/13] drm/amd/display: dynamically clock gate before and
 after prefetch
Date: Wed, 5 Nov 2025 10:36:25 -0500
Message-ID: <20251105154035.883188-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: c543da3a-8d00-40f7-3e23-08de1c81c1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDJCWFU2QWppbDRIdlVNblMrOStzN24zUXpJV0JqMHQ4a0hPamVNMWFMU0l3?=
 =?utf-8?B?WUlzMUt4M1ZGcnNqVUpSdmJUSVNQOXdZaFUvY042RlFwWHhBR3JTaVdnMFF6?=
 =?utf-8?B?V2x6QTlWNjFSOUJWOGViaVdVQlJ3bXlDcXNlOEluVGovS05tY0xFTXY4QTh0?=
 =?utf-8?B?STFMUWFqSnErT3RlcWU4czVrdDFPZGw5NisyTGJRQlI4cGlSNldveG9IMmw2?=
 =?utf-8?B?aVBrNyt3akdhNEh2c2ozOElaQzNDR3RKNUlvQktHaDNOZmJnclZzYzRqQ2E4?=
 =?utf-8?B?bE45KzB6TFV6b3QyY2RaL25ldUlkZXJWdEIxeGRNRTQ5ellrbDhjZDJzR0hJ?=
 =?utf-8?B?MThlemg0dHZ4a0ZGVjFGK0ZPbFNndmR5Mk45eC9pRU1tNUc2VGl6NnRJVDZK?=
 =?utf-8?B?OVFsdnEzRGFZODh6WXZYTmFCZEZoR21QSVdES2QwdUpIblVxdW5ITnJuMllU?=
 =?utf-8?B?RlZyUTlzYXdRWCsxVUtGS2tjY1J5N0g4ZHhNRm9WS3hzdVF6MGZkenpOSCtT?=
 =?utf-8?B?TWNBajdnQ1NwZitqaEFEbGc0UThpdzhBNzNZLzRudTZYb3BjaWtzYjJLWjhj?=
 =?utf-8?B?WUF1bSsyNC90OUpSbnZMQ2QzVlloYW1VOEhFT0ltUzFaeDQ2ditYZGF5VjBp?=
 =?utf-8?B?QitTRzh1RUZYTXV3NTVPY3B2MEM5L3hITGoySUs2eWwweHEyM29LZnhNWHFX?=
 =?utf-8?B?bmc5TFF6STNWbHZhOC9EenRkc2tjSittL0RLS2EyREJPbjlsTU5qT2JLSVlt?=
 =?utf-8?B?eGU2Zjc2djQxamNETTloU3kzZnNJeG9zcE10QUhkaVFaY0RDbnZoQkxIektB?=
 =?utf-8?B?ekFxNkdGRDJxM1V1YmxySCt0VkRiUEpZNlVWVENlbXZXejRENmhtMWl1SHlD?=
 =?utf-8?B?S1V2eVhrb2FBQUduaDgwbFkxNGcvMzZSdUg0Y1ZvNi9pdXJndi94YWFHTnVI?=
 =?utf-8?B?bnh2alVnZjBKTU52OGg3RVFSMTVlSFltNFR0azBPSDA5MW1LTlRDdFQ2Wnh4?=
 =?utf-8?B?L1VMRCt0MWsxTVdvR1piaG1TbDJxUWl3SWhFWlhnZTBlQ0hGNjBBNk5pQUw5?=
 =?utf-8?B?RUZlN2xTOTRsRkJyRVdIcnk2L0JjQmhlTVZMR0NzRHphbFhsNnFEc2VleGRQ?=
 =?utf-8?B?a2wwT3FCSUdsK3ZnVjVvem1RU2pES3VGKzZjYU85SEZmSHZnTjJXNnBIN3px?=
 =?utf-8?B?djFjNkRqZW53OVliemRqbnU0M0tTMVU4Z2czVExyUHM0c1hXMXpTdHAxM2hy?=
 =?utf-8?B?NXBjUjhjaDhTYXM1cGtQK2lCVnJubGpTeW1TUUNtcXJMNThpVzBEVDUvWnZG?=
 =?utf-8?B?a2JuZG41eVRzK0x5WDgyZEhXUnY3UHkyVWxydXlzUGZSTlR6Z051akNBWGdQ?=
 =?utf-8?B?SHVEdHFZbVpHelZ6STlWVHl3bFg0R0tmbS9GUmtZZUlqWDh1SUY0dXR4R2l2?=
 =?utf-8?B?MHlwVzZ1dWVna3NsT3JNQ2JCcXZWbGFzRUFPN0tjK29LTXlwMDNQYk4wZStI?=
 =?utf-8?B?VCtkTVdySDJsL3lOejgvb1hPZVVZbWF5OHZtM3k0d1BtYUp3Z21pOGpUdUtu?=
 =?utf-8?B?NGFBZWM5azUzK0xYMFJ1bUxXeDNrRHZ2UmlocUNrdWhlY3hJaUczWlZONzYx?=
 =?utf-8?B?b0tpZTlWeWx1N3JhQTg5U2dZUy9INCtFTUVTWGpKeWJVUVNHTTl2Rk9ncDFR?=
 =?utf-8?B?aWpZNWpGbWNpQk1CU0NKNFF1dTdMN1JJNUc2V3Vid3VLYzRHWGI1dU9ZNTZh?=
 =?utf-8?B?OTQxVDg2ZmFrazgzZVdGMmRmYW5HRURrajVsdEVYUW1MaDlWQ1N1WkRVR05C?=
 =?utf-8?B?NmZvcFNhV2o3Z05yakZqN0lxVFRZM2p3S21FZGlzKzJRaFhvVndwMW4vTFNL?=
 =?utf-8?B?REkzQ2Y1Z1dGN2RpTEoyVmR0TWdhYjBTb255ZjNiMEdISmdpdk0vMkw3bWsy?=
 =?utf-8?B?eWFWVzhaQXFBQ2ZYTFc2ZThGeW15NkZoOHNZZjR3dVZwRTdIcmwwOHU4Z3gr?=
 =?utf-8?B?Mm9pMXVFanBZam55N095c0N5M1JkMitZMCtISHFXc3MyOUluUWZpSS9ybm9s?=
 =?utf-8?B?S0FkL3VUcFBHWWIxU0YrZVFhUm0yQ0R2dzY2OHZrd2FXOUtBeVhuNXJ2dEZp?=
 =?utf-8?Q?DHIE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:15.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c543da3a-8d00-40f7-3e23-08de1c81c1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <leo.chen@amd.com>

[Why]
An invalidation request arriving during prefetch can potentially hang
the system if dynamic clock gating is enabled and memory power requests
are disabled.

[How]
• Disable clock gating and enable memory power requests for the duration
of the prefetch.
• Turn on clock gating and disable memory power requests again after
prefetch is complete.

Limit the scope for DCN35 and DCN42 only.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  7 +--
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    | 52 ++++++++++++++++++-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index d1aaa58b7db3..5a03758e3de6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -933,8 +933,8 @@ int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 
 		dcn20_vmid_setup(&hubbub2->vmid[15], &phys_config);
 	}
-
-	dcn21_dchvm_init(hubbub);
+	if (hubbub->funcs->dchvm_init)
+		hubbub->funcs->dchvm_init(hubbub);
 
 	return NUM_VMID;
 }
@@ -1071,7 +1071,8 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
-	.hubbub_read_reg_state = hubbub3_read_reg_state
+	.hubbub_read_reg_state = hubbub3_read_reg_state,
+	.dchvm_init  = dcn21_dchvm_init
 };
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub31,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 1b7746a6549a..43ba399f4822 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -549,6 +549,55 @@ void hubbub35_init(struct hubbub *hubbub)
 	memset(&hubbub2->watermarks.a.cstate_pstate, 0, sizeof(hubbub2->watermarks.a.cstate_pstate));
 }
 
+void dcn35_dchvm_init(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t riommu_active;
+	int i;
+
+	//Init DCHVM block
+	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
+
+	//Poll until RIOMMU_ACTIVE = 1
+	for (i = 0; i < 100; i++) {
+		REG_GET(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, &riommu_active);
+
+		if (riommu_active)
+			break;
+		else
+			udelay(5);
+	}
+
+	if (riommu_active) {
+		// Disable gating and memory power requests
+		REG_UPDATE(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, 1);
+		REG_UPDATE_4(DCHVM_CLK_CTRL,
+						HVM_DISPCLK_R_GATE_DIS, 1,
+						HVM_DISPCLK_G_GATE_DIS, 1,
+						HVM_DCFCLK_R_GATE_DIS, 1,
+						HVM_DCFCLK_G_GATE_DIS, 1);
+
+		//Reflect the power status of DCHUBBUB
+		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, 1);
+
+		//Start rIOMMU prefetching
+		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, 1);
+
+		//Poll until HOSTVM_PREFETCH_DONE = 1
+		REG_WAIT(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, 1, 5, 100);
+
+		//Enable memory power requests
+		REG_UPDATE(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, 0);
+		// Enable dynamic clock gating
+		REG_UPDATE_4(DCHVM_CLK_CTRL,
+						HVM_DISPCLK_R_GATE_DIS, 0,
+						HVM_DISPCLK_G_GATE_DIS, 0,
+						HVM_DCFCLK_R_GATE_DIS, 0,
+						HVM_DCFCLK_G_GATE_DIS, 0);
+		hubbub->riommu_active = true;
+	}
+}
+
 /*static void hubbub35_set_request_limit(struct hubbub *hubbub,
 				       int memory_channel_count,
 				       int words_per_channel)
@@ -589,7 +638,8 @@ static const struct hubbub_funcs hubbub35_funcs = {
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
 	.dchubbub_init = hubbub35_init,
-	.hubbub_read_reg_state = hubbub3_read_reg_state
+	.hubbub_read_reg_state = hubbub3_read_reg_state,
+	.dchvm_init = dcn35_dchvm_init
 };
 
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index 23fecf88556c..9f65fff1bd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -168,4 +168,5 @@ void dcn35_program_compbuf_size(struct hubbub *hubbub,
 	unsigned int compbuf_size_kb, bool safe_to_increase);
 void dcn35_init_crb(struct hubbub *hubbub);
 void hubbub35_init(struct hubbub *hubbub);
+void dcn35_dchvm_init(struct hubbub *hubbub);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index dafc8490efb5..1ddfa30411c8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -252,6 +252,8 @@ struct hubbub_funcs {
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
+	void (*dchvm_init)(struct hubbub *hubbub);
+
 	struct hubbub_perfmon_funcs {
 		void (*reset)(struct hubbub *hubbub);
 		void (*start_measuring_max_memory_latency_ns)(
-- 
2.43.0

