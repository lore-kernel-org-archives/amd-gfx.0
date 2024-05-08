Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD20C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8EE113117;
	Wed,  8 May 2024 17:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cNi0VrV2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043C8113117
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXsi55Ls7V41/w78jEn3Ss2emJXfU8xMXPTgt852Hd2eRtqePZiCKAblZunkbtl5/kTfCNBSHMinGA+RrjZBrTelRlZRzjodgEapF3hIreTemhHLtjI3mq8ZlKIN+uEqTzw2BXM6mg6OimHyoEmQf3rZlw1KbCklV1ZKCXoT3hmVuLcq1oNeIaNRJU8Hrydln6SvfQwtGGBPRSriHFD6InCdVu6ErgqhhD/G7avoj/JF6jIOQfxsPSEGGjroFa47jl9ldfs1CUMa/u8II6YcIkzzraIOtwBGjeQd3MRH1bUhrXDgO3Nc1344pKyl1tgqCXEYz4WVnlJmuxADbm0A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06pW4veSlfDoSR8zQVgSJLfTh0OIyFSD7btq5m/geOg=;
 b=Em5qFH6Ea1I73KOnzphdBZp90KI+UEvimMKEkE4B9SkCW1ICb9ulAxJH1KK/BNq114RNfO/ba2AXlEkbtIrErbUxDpngiaX6yv+G2KGuxGZIP8ewLg/XaZgaMRvG8BfHe7Et+Lxe6gU5yekptWuRl3GEwBAkphd9GoVpjx2NX1BMKVnzpoTASyu7jH2UDdNIvxHG1g91hGtNfd9PGUkzlF0ElZG3A2i4l9m758sF19LmnYW3r6c4nH1rjIyiEN9jWt6AgG5wBZj8bzhAh6Dm7VP3KAjKhisqx+5Q7kqpHlTYpiKJyE3F9fqaZR9Fv1bRDC4q60QVyfgROUyOEsS1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06pW4veSlfDoSR8zQVgSJLfTh0OIyFSD7btq5m/geOg=;
 b=cNi0VrV2bRgUSvoOEJmz1zNQNBs+jkmGDW6F1vsI88POiC9fBvD67betBQneYJxdn45Dkg5jGBTKEvbUlo4FPehGSMrBDBpip979kZ2CXsLqq3n/wPVFklKt2DCtZHdDsS9kf/B5HCUaaKGuLxNoZBEVg4j8AOxyIiydAEZW3YE=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Wed, 8 May 2024 17:16:20 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::84) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:16:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:16:18 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Adam Nelson <adnelson@amd.com>,
 Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/20] drm/amd/display: Fix 3dlut size for Fastloading on
 DCN401
Date: Wed, 8 May 2024 11:13:06 -0600
Message-ID: <20240508171320.3292065-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fd28b9-3507-47e8-9d93-08dc6f829479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLtS9o2B/ycZKXrURQY7VrLUr1BukbyKHsg5SS9eHC29lROwoVjarTMas8yX?=
 =?us-ascii?Q?/aVADs1UvwFbqgMPRFFf/M7Eobs7QIdEoeQdtq99Bwo5ALPad7NEsbhMCgwF?=
 =?us-ascii?Q?YaC/Nlv5Rc4FCp+T5UN61g7pucLc6yAblTuu4Q6XkUM9BVIankt8lcO8Grx7?=
 =?us-ascii?Q?1Gai/BjuV56QNpCK5Pd3n58qdNQ/9gBhUnmpoiKTohPMZT1J3URoKqzZ5wuf?=
 =?us-ascii?Q?L6dGF/kXWqMB4y9KYeXnsEfddkBSt5Fo8ywASXwUBc5IxZw/tWXOXCRlP/YL?=
 =?us-ascii?Q?XoJl0tCeEG0uGCDpF/0py8YQACgBFS7lSKAxfmfur6/pHvbCKwDxIjgB/RNO?=
 =?us-ascii?Q?T7Zwsgu03P6eMJ1gCAuoDXdmFdhZeBp/pGHRf7w5lPJAcSRcUnlTZP4+wzpb?=
 =?us-ascii?Q?WnWYkQWIap4IQkdfN/APEVA0Za1DT3+2u26zyMG6cVEj9NMhh/3Yq8g7jMTI?=
 =?us-ascii?Q?OZQ3XLbJ3pWsBB2HsZFGZoCpHCyfS02Jt4skD+YGY4dreW/cOXZUVGhLCEmm?=
 =?us-ascii?Q?VWIgsMInFnpdR205Ajq1eptWa0r8xySU6uM9sbB+FNtW6BrcakHxP0mOi5bO?=
 =?us-ascii?Q?qKNT9Y6qjddaCvUWuuNfexTkCe53vwgg10echzhhSVtYw1WkwT8CBJVwleE0?=
 =?us-ascii?Q?HD5YKlCDpxdJ6T9amVz53z6wqFkJ8qruoFsh7ir2CkOfeWEkmX3DroaqSzZQ?=
 =?us-ascii?Q?YlYMEA8ESwPyE3RQdxmuEBgF9Thx3rtqPKebqGJ4veMhNVxoFhqE3eAvd+hW?=
 =?us-ascii?Q?O9jvgpc4wv+nWjWjSP8jt2u6RMIjq8Bs4pYGtyngUBSRWEfcYsu3urVuN76+?=
 =?us-ascii?Q?NUM1H8jwRuovqOatCG06Ag5Pr994tVJ3o1yE4/UERXchm90aUg00tMlZQosT?=
 =?us-ascii?Q?pF6eG++FDgPv7VpX2bCfMIe+KkkC1/0V/y+7GSx1taNOkk/0d8deJId/7iuk?=
 =?us-ascii?Q?bvwzIU7zp2t4D4fnqRBSxmnUmYbf1HyUJyjwF0BTgLf562TjmTfcDcHb6SgY?=
 =?us-ascii?Q?Usk8PTaPf8ubg1NVbuoPwYeSPA7CqZyRwTR54n2Ir7vMa9V3tcXlFUEUmEqy?=
 =?us-ascii?Q?pLLxAvyEVlhQV2lDXkaEO7zGcInvRaB/fnuW5mHQ8latkO2eiqFBkOAo9kcp?=
 =?us-ascii?Q?wtQo0EOgQxmtRh1uwp5WU5pAVCqE2vXYLAJK7JEkKEFLac85OXFz/EUkZT1I?=
 =?us-ascii?Q?QDdDXRjPNjudBwYBljZXXFdzV8vadfJYsKyh9ezxQdzBcuRwxMEd4oBZWLhT?=
 =?us-ascii?Q?Jt1oqMJuTVmo+Da+I7QZ2XTW2kfAJjOAtmjjvP4cSrtIehS3aMERV3J8fXQC?=
 =?us-ascii?Q?UlY3tFtN0RoCb5VD+V/wNkU7Tk2Yqrj0L0dmu6nZw95rA14uJRRG9MaIMu9I?=
 =?us-ascii?Q?ya0jXjcnPNnGzxvn1z4JPNvUxR/Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:16:20.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fd28b9-3507-47e8-9d93-08dc6f829479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

From: Adam Nelson <adnelson@amd.com>

[WHY]
After a non-3dlut test the MPCC_MCM_3DLUT_MODE::MPCC_MCM_3DLUT_SIZE is
incorrect.

[HOW]
Add register write to make valid.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Adam Nelson <adnelson@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c        | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h        | 5 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h               | 1 +
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c
index d6c99c6c2b35..37ab5a4eefc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c
@@ -297,6 +297,13 @@ void mpc401_program_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_I
 	}
 }
 
+void mpc401_program_3dlut_size(struct mpc *mpc, bool is_17x17x17, int mpcc_id)
+{
+	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
+
+	REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, is_17x17x17 ? 0 : 1);
+}
+
 static void program_gamut_remap(
 	struct mpc *mpc,
 	unsigned int mpcc_id,
@@ -615,6 +622,7 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
+	.program_3dlut_size = mpc401_program_3dlut_size,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h
index a8ef67695757..af44054c2477 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h
@@ -221,6 +221,11 @@ void mpc401_program_lut_read_write_control(
 		bool lut_bank_a,
 		int mpcc_id);
 
+void mpc401_program_3dlut_size(
+		struct mpc *mpc,
+		bool is_17x17x17,
+		int mpcc_id);
+
 void mpc401_set_gamut_remap(
 	struct mpc *mpc,
 	int mpcc_id,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3b74c4a9c2a8..5b87186598e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -478,6 +478,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
+	bool is_17x17x17 = true;
 
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
@@ -543,6 +544,8 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, mpcc_id);
 		if (mpc->funcs->program_lut_mode)
 			mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a, mpcc_id);
+		if (mpc->funcs->program_3dlut_size)
+			mpc->funcs->program_3dlut_size(mpc, is_17x17x17, mpcc_id);
 		if (hubp->funcs->hubp_program_3dlut_fl_addr)
 			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, mcm_luts.lut3d_data.gpu_mem_params.addr);
 		switch (mcm_luts.lut3d_data.gpu_mem_params.layout) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index dd786600668f..34cf8efc5cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -576,6 +576,7 @@ struct mpc_funcs {
 	void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id, bool lut_bank_a, int mpcc_id);
 	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
 			bool lut_bank_a, int mpcc_id);
+	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
 };
 
 #endif
-- 
2.34.1

