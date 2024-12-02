Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03560D10DCF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 08:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97B010E68A;
	Mon,  2 Dec 2024 08:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5CnykqXL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E0710E679
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 08:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2WBnx8Kju0QYJHdNDI+cwgoZI8UcqjNiQU+EBb5Db+fI+Vha+wBnQNc1FcsbmpEYasEEf2Iilv8Beg0UKV1unt8jMDSSBzvHHxdjIFdmhLkzkgV2beWNuOfngtJ6LfyKBtKwBbPbPNWm7EtodK8YVBVRQqWZLuqgXvSZZcToUYI/HOsIAHjz7U6glLI1QZVC0ZwYp+ETuJuFbV8GW7Bq6V5iv6HMHlLzm+OUzKHc9EnUzzc1kzxhHxop0J2ncIWTj4UXidhEeUNqNcYmotR2dTrQh+NEFiz6dfnMzPRePXyrBU1eZDtmrLtS53V0awEHpuPPQT8ptyMpuDFF6+wDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzgG/lQ5LIgTl0P+bMyFv1yTVSfs8GxrgStsjfF3zbA=;
 b=HJSZtGKFEFTLmI95e1ICdXS6pye3z8FhzD5lhEcHbETD7UEZKb+BaFoeHgFwxpBpbACGAFwVBLSgS7kkZDMowWuex+2IGbdRlZMw//xUpbDn0brvJD90YeqvV49ULlOUvHZhe/fuLmJZIjTiibazd4Gb44PnmukJbdCSs7VNeuXZkwZ8cftAgpDVGHlWxulN0sk6daalD2dCPfZxqSWkEIB8Z6DVDVWTuwtQ19z+RlZyQ2qy9l7jujqPCegLdeaptbIMXwGWoazP/hkRDypsBFGPqREutRAmd01a4qizNvaKNAqlPdmUEkgle5c2ygAvRqTVgjhfOZTFNLOgoToopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzgG/lQ5LIgTl0P+bMyFv1yTVSfs8GxrgStsjfF3zbA=;
 b=5CnykqXLGv9YwmtJmoq7RB/k/qAi11sxJbwDwidw9SBYvSSowueCU+4LhyXkR1m14+aw74m3FLgFQMNqC0LCmP6IJkhEGzTeZAWBDpZHXMsSRPllqcoUGOu2z+kjzKgHf1azwzi4Rm5mQUFgw5ZjEz1L+wmHS6ZapRH/+DUm4Uc=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 08:49:03 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::9b) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 08:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 08:49:02 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 02:49:00 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <stanley.yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: move common ACA ipid defines into amdgpu_aca.h
Date: Mon, 2 Dec 2024 16:48:48 +0800
Message-ID: <20241202084850.1960341-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c01276-7775-4997-822e-08dd12ae2bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J2RXwayCs18A+pstxfqin1KSkXK18VlCWNjGD8dfKOYOp+MB36yT0e8CNgck?=
 =?us-ascii?Q?hNQVlCz7aXT0bpewUG93pGIs2ay1aSDm2CGoyAMKt6YmTqM48qYkGedR2Y4l?=
 =?us-ascii?Q?bUKFxAQHDP8aQcAitm+adCZL2D0+ThaOpeowLY6NKewxfCJtNnlsBtwBEvri?=
 =?us-ascii?Q?AlNt/8beOJqh7GdFnrOI9jjXWO0nYummpc+hhBuxXLGMH90kZvQHhKiNxk08?=
 =?us-ascii?Q?grWhlPUiLkPdbnB9yAPoB2AWkvOcsQ9mFa1R7+h7ouDU6re5fLETgHZXtWGm?=
 =?us-ascii?Q?Ta5WKZTnmBvs91QRk4IiVklkLf/ekheG/dFxtWhBA8TWrQlNOPYXk4sDA/ny?=
 =?us-ascii?Q?0QTYBaX0FNaSx74PacClwna5CTglv9Gj2NImTKiAcMbWiqq7bbcmUEfR/Y1o?=
 =?us-ascii?Q?AB5HGL+RBXmOLhLK4fNVlHZDq/aQ9uIFD+QV4sm+JA//8Upx850nq5t2GFdp?=
 =?us-ascii?Q?hnPyM6+TWU7ZatXA60RR3o34kIzftCSvKjnObWYkqETzab8TgpuG087ESQIu?=
 =?us-ascii?Q?FxXH0xmzI+boBJccjckihJ00z+2/NWEyM5WSfxjN7wW6uxP93vW697Zlxs9S?=
 =?us-ascii?Q?HpmqiHPFrsfGH6AxplfWLCWKQJjEs5sj8mwdnqzagrfgwM5IJ5MieINgpNGV?=
 =?us-ascii?Q?0G3DILfExgng4wR6AuceV8rAj1DOZ5ehi80ZJd31j9WLoCHZWLsrV/7N+jJh?=
 =?us-ascii?Q?apakMoAZr/j74Onkqi3OTklMoRckhFoOwDdOGyLM0YaZaDVddX9EccjwRuQv?=
 =?us-ascii?Q?Ax71MnvJFczKNM/yJr2T2sR6Dz9vQAov1RmgJQ6RL6Hb4yi2eooXFENAiRK+?=
 =?us-ascii?Q?4OKFkMVIgnBSTpQKhhMto55DIlN4/WjfH3QFYum+XLbnBByfwGufJ7YwkQqM?=
 =?us-ascii?Q?cVKuxrGYW7siUX2fbnatEc3dV+uetKC4itqHH92idey5NN01TftZ8huHRUCz?=
 =?us-ascii?Q?i2TVwYFCizMiWnRjOfS22QP5fh6zHxSDMh8yIzvokv3TZMPmycvRRRZcf2Ew?=
 =?us-ascii?Q?cDS9AnXITuLNbn6HgKSYf14NB6hSwHnwkq1ftFdKqH/2XtlJUx2VShBU8Ely?=
 =?us-ascii?Q?buj3QpCE9Qg/IgG4E06aXyDXB2v2Gbhy9b70hIYZGwiaUYeV6/u2GICrqgwn?=
 =?us-ascii?Q?vCYmixLStbnm///AupJPEi+s5S4hnCX3rZE6C+uiTD16/8qHXGpPmEW4nGY4?=
 =?us-ascii?Q?0+CweUCnLPRAvWXXWVptNvajkRklXh1aEv5dIdQGODAVdLmgAGAmH+kMrwWa?=
 =?us-ascii?Q?/KTyhycglUDTR+7BI6kkrTHD1SmphOJZvmL4suyV1MN22AGZykPjnTDKaBlR?=
 =?us-ascii?Q?5GXlsKiOUasoe7AEiDcqRf7qTfrmdKKhLg7SuiMI8mLlByisclh7f35o/H5b?=
 =?us-ascii?Q?FQQe4kjqNFgIU610hQEEyAWb9sFUqZXkLaiRLKXboG1fYUA0KA3PFqY2WOmY?=
 =?us-ascii?Q?i7YZllxD00YRge5lJ6LlI5QLHmZzg+ZL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 08:49:02.5153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c01276-7775-4997-822e-08dd12ae2bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

move common ACA ipid defines into amdgpu_aca.h file.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 -
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 5ef6b745f222..f3289d289913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -71,6 +71,11 @@ struct ras_query_context;
 #define ACA_ERROR_CE_MASK		BIT_MASK(ACA_ERROR_TYPE_CE)
 #define ACA_ERROR_DEFERRED_MASK		BIT_MASK(ACA_ERROR_TYPE_DEFERRED)
 
+#define mmSMNAID_AID0_MCA_SMU		0x03b30400	/* SMN AID AID0 */
+#define mmSMNAID_XCD0_MCA_SMU		0x36430400	/* SMN AID XCD0 */
+#define mmSMNAID_XCD1_MCA_SMU		0x38430400	/* SMN AID XCD1 */
+#define mmSMNXCD_XCD0_MCA_SMU		0x40430400	/* SMN XCD XCD0 */
+
 enum aca_reg_idx {
 	ACA_REG_IDX_CTL			= 0,
 	ACA_REG_IDX_STATUS		= 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f23df55d72fd..4e920607a278 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -52,10 +52,6 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 #define GOLDEN_GB_ADDR_CONFIG 0x2a114042
 #define CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301
 
-#define mmSMNAID_XCD0_MCA_SMU 0x36430400	/* SMN AID XCD0 */
-#define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
-#define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
-
 #define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
 #define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
 #define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index b01bb759d0f4..e646e5cef0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -33,7 +33,6 @@
 
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
 #define regVM_L2_CNTL4_DEFAULT	0x000000c1
-#define mmSMNAID_AID0_MCA_SMU 0x03b30400
 
 static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 {
-- 
2.34.1

