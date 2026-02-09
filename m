Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9733BEF070C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2599D10E27A;
	Mon,  9 Feb 2026 04:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YwvMVivg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93D310E27A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEbfIl9L/cUmJfQpNg8IkP6hVp4HdapNUXpcb0EG97VKCB9o/xYMGs7hlOFo1Es5VGwMqwVyEyMpUHrEfTs97KJbhtmuCyz7/CHUTDgJS3Bt/IjjGRXdvFU2e9Wol3Aan/geqsn2yxCRo3kKUYZrZiSDPUDyTvGsDJHf1Xuu4ZsZG51mHKG7Bs5PlaInHZNQgoS8YHWlCVRP9S3/ZNE/7ho6eYVUh/QvEOvSS1D3vkRmMMyohhk9pFBO6Zp1uTjtYv28ytASnzyvR77Kv5koVLrVgtpKzK1qUhZI71fAtRHATWu7we1B3mHIshFfSiGcJwRg1zc1aXdjK6si+M8hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PecotAvGvBc7LldM4sFLijTYrxLPOLmOIE2UjD/LTDA=;
 b=GRVozemuJXq7HkpvxM/cPK4yxfp61P0KsSIsOhPxYXXiOZMCgf3A1b5NrVxpdCpMSZekTrnC6HctrX+V9IWZpFmEkQ2uPt5VqFvmP6dRPaAHU+vYN0lpLdt5ecwgWbrALdylybdVpT3h5sRpjwFrmLd7GcyjL71t6BBEoosIi4r7v6uh8OyHV3RrmPV1ZrRhu1h4LceByONAfitlXJF3PL78Zzt32SBUVBRbsyQRU/OMEDoH4CROtlxN+TMkBGH3M/rTReFo+0LMnvkt+kaMd4WMR+BlBlN6UlJI/EFfnbcdcXZabjsm2tIX9T8VcICdMaUZqUJlddwqc04TClE0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PecotAvGvBc7LldM4sFLijTYrxLPOLmOIE2UjD/LTDA=;
 b=YwvMVivgy33HBbC4W8fWOOmQik4KeOU1ngCVFOybDxSPF0aKK84NgqDldrPFA7MJa+ovN5kqHa+IFrs19zzSJt3Fe2S+9tjU7T8NewEUWHzCTnk3uqEKNnp0vUtquQm5vj9jDePFE0iZIPGeomtKNw3x4sQ1MOs9cCSYyjGhjTA=
Received: from CH2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:610:38::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 04:57:18 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::b0) by CH2PR05CA0038.outlook.office365.com
 (2603:10b6:610:38::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 04:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:18 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:16 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v6 06/11] drm/amdgpu: Fix is_dpm_running
Date: Mon, 9 Feb 2026 04:56:44 +0000
Message-ID: <20260209045649.59979-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f665d0-77de-4ee8-5542-08de6797b3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Vqm8sRbU2m+EDbvEHN4eRFQ0iUvsOg5GmJFoJUTtbSNR5YtQ/jF5aVoUxUK?=
 =?us-ascii?Q?JnRU7LU+RgrNgFO3FP6iYVG58JHLAzma0pSkMX6UiHYZCvHHQzrr6a6XWHzC?=
 =?us-ascii?Q?AmSrv8lMAEtkGZLlEddkji+ACFjg0r3D2ZVaex/CqTgOqiLQag1xNbKQGOg5?=
 =?us-ascii?Q?soPYJOat01jU7SP31l4/8a7agT4ZvLo9y9qryvmfk6RrgF6BPri2S6lLt13b?=
 =?us-ascii?Q?cx9Hk7mSbr70GRORvUExrQq+FDnhYh4rgEwO5gbDd7IgivdL/jJEox8PdU+F?=
 =?us-ascii?Q?d9JnxL8s1dikJH92Gq4m6LE4KrQ4GeUe+PDeHfvgUzMtRjR71yKrQdrQqoAo?=
 =?us-ascii?Q?64ifoaB0kP+dCgXRZrnw7qKy2S6mBkpi1TovsMHEuFffzwUSX3OR53KH4wut?=
 =?us-ascii?Q?BegGZBLzAdjwJ9myJEzCkm/t1b44AnK23pqEOdryJWcxDzZWCBsXkNNMshsH?=
 =?us-ascii?Q?bsCQdcQObu0kzJlS6sNTiN5aJOCeebuSjD9BJKaFkJqd4Qv9osg9MF8d8Uoa?=
 =?us-ascii?Q?bqKZUvuTNKiWG+vU2Qfv8Aq9ggS4PScGtsN5NuTUd9w5E2A3/lVe4lo74+fy?=
 =?us-ascii?Q?ZiYS6to6/io/3D42jKY4x2hO41N7cIe6t0novxQ1ZeG7gmkmy9SQfmxVvOOd?=
 =?us-ascii?Q?vvMxR3wMJFnH464CeZRWZqdayZ8aBoxBa8P9MNlhWuyG2JOuhNZpvPyM0u60?=
 =?us-ascii?Q?DVMgO5NgW09vLrM7ifyJeZm6WCrjGfJoeEOZ8qM0dtMVoUxOqDBE9qSh4oU5?=
 =?us-ascii?Q?V7x/TwZEcScGgGMfFQuzThaivJjURSRxWlO3uqvrB0HFi/TMI042xUYmi8CX?=
 =?us-ascii?Q?JnzioemPQE22vtxdgAxq0dM4cimJs/QCjpgyEa5GDvc+I7YV1TXvljfTEifa?=
 =?us-ascii?Q?DJqCPHjDHYIwkh4IJIVL9XqYmMRJC5GbrC8bpGU0NVeh0mTZFTshcTJ6bF49?=
 =?us-ascii?Q?kCN111xt1thXQjJIu34D/kGsv9Z7NKNa3YfhqkwbHWsviRk6LqaXom5/Th9T?=
 =?us-ascii?Q?X+thszydsAPBqaX2zKtumqGWYw5Dneu0VsEKe16IHa16PidImU6E0T3IO2ie?=
 =?us-ascii?Q?SBDl81GTWECPGxagnsgdsfXq2sgk0lPo1QKC6m4/i0GUjwpylVZJGt8B2Txv?=
 =?us-ascii?Q?CDp95qmqPy21dKP8FiFaSWoTSJ6NkIUVNJkkxGPLAAZMplelFibDhVCLKTzk?=
 =?us-ascii?Q?wF6HJQrvyUwBimnI8uPaHR/iz+MalTu+AGGyrxcFKYSRn8HWE7GXW2Zx4B05?=
 =?us-ascii?Q?rEZQj10xyQodP2PI+jxTZFaFo6vKlibLyU2+XBS2r5848qzShzdPCwWcbADj?=
 =?us-ascii?Q?HqPGc1aYKZ3W1Iirr//xIQbh7Eo/lMIuvbJLH24e+A5/YKYHEVTb43WtYIEc?=
 =?us-ascii?Q?QfBANUKZqdquTfC6e9j+i3vqYN8x5bRxJlpDxzgdHll3qL1Jo+TBo9Caql9x?=
 =?us-ascii?Q?FjAcko4YrUtt9BUtXHJyZJAkXBD0RtDxEyj5Ns+6adPN/9ALf7bLpic1JhM7?=
 =?us-ascii?Q?RVwztGUWIKUIP2KhHop07ujF9OC0oQLW5ZNXiSt0SjmwRdldmCJOno3iVDhS?=
 =?us-ascii?Q?+Q5Msd0QvFitHHR5myqU5b1sRdwidj0zd2nSrJFqgdm+PPX5vzBteRgVHz/3?=
 =?us-ascii?Q?1Z2acGaM1c6+lIF2obwEOhORvAs8UUfWlP+CuI1pM90wYwtpAZtxlgdLVOS/?=
 =?us-ascii?Q?uyajjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iUgR3UpmKqdnFcWoqwoar6FWbyetNsGuYHhqf8o+JALS35746hl6ormwr7dKdPmcYtku5qYJOCjupPHe3uyoXnyNlye+ux7UaJy1ulKjuRPbZqTcNUGBS/fIjIzrSx5mKK77+opFQjTjYjVPWWUU0xFvIUSlPTMQyrNekDnyzMrNLdU9+D0el1kotMrHh5kKqz79TQe1vEMdBT7KOrn4uVpMQWSjACML/w5IsLGcXyUpuJdydKHh34a/zrGV2gw9kZkoXl8ZK4kC8RLqFPf55UeqjekkmopH2n+q6VEjRvFVVCNz3GjAypj+RQpLN3pjjDE6NDXbUPTiTQAKRE0srSvIzdQDrCnlPACIv0/eOtLWoZwv4UcChbykeYuOZOy8uJyyUsPjX60tZKBg/GBYJoga7pJ87FEY+Sh+CxoMPRqwlu97+pe55DBNXolxqa8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:18.4652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f665d0-77de-4ee8-5542-08de6797b3aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index b42d56f7e621..c1ce603fcdd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -479,12 +479,36 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	int ret;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (!ret)
+		smu_feature_bits_from_arr32(feature_mask, args.out_args,
+					    SMU_FEATURE_NUM_DEFAULT);
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1356,7 +1380,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

