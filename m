Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E8FCCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452A610EB27;
	Fri, 24 Oct 2025 17:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9YP+7oZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579EE10EB25
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7f37SyodB+KFBxjFkSLepgUllHSp/tiu+RTciPcSQ/cXhXTPsqWmYMgr592jwZMyTebM5LgC2iVi/OydE3UfSgWUvuvNW4hSBS9dTkYEUThBcwEejusuNvVKcZPImrxpSvm9WlQPBDKwe33yHRqqafRMfatFOI40qsxIPufRlcJUiOmuaM2PjQmykEltLSqvfhNeuXW0Tpcs6GOWOEjJ/zqwdAW1Vjm0WohXFVXuhJtHPUHLZ2Oopmftl6dKYy3ywA7/VlJf5irdlw25XIR73t6LTLWrnPQiqbIDJiwYuWsUQIa8kYq1lqa/a3zI04NW8+rZQBAs12iajafHiDryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhBbTcVi3GKEO626ENbT0bIgN+wbk+d5Gp9axGeoVB8=;
 b=ttPyF9Wxtf4w6bl0KktYmSwtP1mxJmV+MAERNeiCe/9cjhQmgPzDTMXEXJxXnFbi5hp3/UD6RFX7nMHbulAA3qxHwJpQrAN4r94U/cSaGyb/CTx0ZikqVNXxP9IxfdKSvU5wY1tT6tho484ZHI1VYTduXkPF4Z0bi2t+maK/BZ6Tyyo1i0WE16JOCZFWSZ09PdeR7hHvtp8RZW9EJFR+/MjVRlkN2hJz1GRQB5a6QjoD2m9vAWBkczkVJkGR6k2u5gWsf8mpclcn7/SerWTfv7pK9dfh/EtY6B9NEC2IsVLp22RpHflUpaxRUApbF5utx8tauoCISIcF03ujuqlhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhBbTcVi3GKEO626ENbT0bIgN+wbk+d5Gp9axGeoVB8=;
 b=K9YP+7oZlhLWz+M+1kSum+l/QPISYD5KT3fcOJtFD1KJX2tjGjRrd8qCvwdtFnRHsCf0F5DOLA+DsZpRLu1A0o+z1SX+VovluPGk2FIOqYKH1UM3Pj+pcSM0K2PVEDh3jw8bgCTcwOnuVbgIaFge8TTQ/QX9eAt+3QEhQJl08bU=
Received: from PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::34)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:08:30 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:33a::4) by PH7P222CA0013.outlook.office365.com
 (2603:10b6:510:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 17:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 24 Oct 2025 17:08:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 10:08:28 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lkml@antheas.dev>, <bob.beckett@collabora.com>,
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
Date: Fri, 24 Oct 2025 13:08:11 -0400
Message-ID: <20251024170811.57760-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170811.57760-1-alexander.deucher@amd.com>
References: <20251024170811.57760-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4424431c-bbaf-4669-1fb1-08de131ff441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sN9eV0gfgL6MHcYm9oNl3yGqH2lDp2WeHRhp2XVf6eQjRUfGqoD3dNRyclFR?=
 =?us-ascii?Q?PC8oj/hDxQmgqjyT2/FLBog2FZKJaAlGWyczZMGPY0+1Tbd5n+FjhMaEs8iz?=
 =?us-ascii?Q?ontstZLPVI+gIHa4BNJSHBSCvfCFmZVAps4vnIvtsDKsZdrNp5rPXspJ5toE?=
 =?us-ascii?Q?j/cgvSAvNDdckSO8HxW+AhRNjTLzFCYb2KKvWiWF3GiqNnFyOxaiuW5/J+RR?=
 =?us-ascii?Q?RLFLA2KoIn28T0tUtIJNBB9ptPnj2OhQTfkw6NokTZSRdolJqDzEJp2dphSI?=
 =?us-ascii?Q?4rIH+oL/iEQrf1pTFAze0zln+mHn9Bmmmd0XsXFuzVXFf02nkuT5r/t3Qp4J?=
 =?us-ascii?Q?knZAWrjPAb94Yv+EuEW0ThV1JSq4IYLuS7/jhw0OZycdlduUfn3O+LqZGt0s?=
 =?us-ascii?Q?qCWsqYoE8AOhsYwUfgvERQFG2e9q2i7+hxi1lepFN8ZbxL+CfMXdR9FKjJrY?=
 =?us-ascii?Q?nDjODLE8w9mQCH/xJoTmJ3HZOT5ChdNivL42z24OD9Sgbqc3JV6fsNVsiz1c?=
 =?us-ascii?Q?25WaCCRUxsxPbxUkn0/SIZ9C38yxK4lJ/h1AgFY22xj0yg5HU4BoRaVdihJh?=
 =?us-ascii?Q?/TkGC4+kumbtaLhCKtJ0Mie2MSMHuTvPAdykd5zCjrjjv4IrQgUbyuv1DPW2?=
 =?us-ascii?Q?GvR9r+XoqLqbiBrFOXhJ+vxdYs2Dbd1P96v39KhAZiU+zzeT8YVRYqwZfpae?=
 =?us-ascii?Q?W2j3sbD2YYdmqp1MZ/30guaYdtTxFtmyx5wu+DHV83V+IGAtNSLnBltnQJtN?=
 =?us-ascii?Q?IEJ+P533DDycocG9f8+XnrkUrH9vRGK2iFXFKM53oPWvOaZrtT4DYaTiejor?=
 =?us-ascii?Q?/QKuQVcXoZ99gZ0kTcO0Yl98IwASm/HdnRxGq1vPx20QvpqR/ir/cLOCjgvo?=
 =?us-ascii?Q?z1JSw8SbOiS9K0Pu2WnWuQDVI/sC09aKDb7MivvrDrtKryZrz8SjJHXw/cfK?=
 =?us-ascii?Q?Ko5FjlREGLe08zdKVs930Nwd7PS+l1Rz1+sEJMcpkGkwG5gsdbg32M31Fpj/?=
 =?us-ascii?Q?gigCz33Ap2FwPW7MUP6K0PEUWoX8hTufrcpp+HYzfGIUot1mN+GCfyyVrYWV?=
 =?us-ascii?Q?/mWSa2Dzbe0IrKaZ+T9bNHWzbCfwwrS0ZP52n9F72qRJ4WSbOx03ZRSBghr2?=
 =?us-ascii?Q?D48gGNiOdQIyfPQmMHtKD+w+nsxTSCJuXIPRNi+dd1A6jJULV7ZWCuHW/7JK?=
 =?us-ascii?Q?VKoKlSned/a5HhQTAPGx8Had39J63rL/rT29YAs80nnZiF3amsnpaFRtPqzz?=
 =?us-ascii?Q?wsocfWRVEFfdV9WymL7L/5JpwdroFS5VqUnQ12Y0EjAz+fZtwmeP6Qr58jyy?=
 =?us-ascii?Q?4jfr7lI4bzDQ1W2oUJ/SdA8aI+ZEKDe5XBBkleOLU+H0lN43IWg+LIhL7zap?=
 =?us-ascii?Q?6CvIdZ53uyGE3z4gnOthFpabZhdLNT9MR+iQTgurjKkuHWf8X0Q66kmcw6bQ?=
 =?us-ascii?Q?x3/VqJ9NmL0ZGnCFJBbBh4BtEPjA4aGF3dDrFNaMgGb6DGUABVyf3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:08:29.4678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4424431c-bbaf-4669-1fb1-08de131ff441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

Fix the flows for S0ix.  There is no need to stop
rlc or reintialize PMFW in S0ix.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 10d42267085b0..5bee02f0ba867 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 	    smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
 		return 0;
 
+	/* vangogh s0ix */
+	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+	     amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
+	    adev->in_s0ix)
+		return 0;
+
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
 	 * BACO feature has to be kept enabled.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 53579208cffb4..9626da2dba584 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 	uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
+	if (adev->in_s0ix)
+		return 0;
+
 	/* allow message will be sent after enable message on Vangogh*/
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-- 
2.51.0

