Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A28CE8E97
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 16:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9F810E39A;
	Thu, 24 Oct 2024 16:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N36VeO0G";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9124310E39A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 16:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4ckKqQWN+rfNEn6hmrI3kTdRu7xWy1QA6MsAl66jJerqPhiWQahyeZ+Ga3K/KXI94Kb42Z6XwmBKTZUkp5AN/wtedRaJwV1oeyzfNPLUyRyscZhdKtlzLtqyw2TVoeP3FSqrulqbwCPDRO2idE+fJKUPuszKEVctSyCDvGRj1DdGASuV7D/VFrKuYAnQNbdutdvlzDTppzYwo8EGdiQ5l1dbhXvEk+CbZJifaaCgFVyODGin9MfSaNaek5ZCVLy/ds5jxyUMcIDJIljWA4GbtrYctwXCwYIGuD+3l8cjqqPC9Nu8YRc2OffvzZ0SfCXIgqsKJUCtCFsrRWY+IQlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWHAH3XJNlnhA6UoDcQgfEaPuVzkTEwX57mPpKEZADo=;
 b=lM6aWu2U54lD0o9ekQhl5PWtZ99haLeNH6Rc+853G/X3j9RMrrhVXddaa+JJ9MFmxYcn9PC4mP4PoslfpCVs2SSWkkpIoHL3pTiMNJFmcSpbg1tTi+D930mLfqqvVBD7lW2rp3LJYhbPfVy7CCM7/FnWAc2CuC7YzNTpW2HxwWJIdMJzNHs/+6Zeas+3Uo52PYFDMrnsNvbti/HWlm3HQEBO6+pn+DJtvFUitWJkgxgfNY/MPhA8RB1Yu5M6DN+XNE9BB3BlN1qnMar9dNWeEpuPQqc0adki6+WVlrzZkxDe1uiVxowDd6+z7+bRaJEWGhrj0w305foXQHu7zM11Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWHAH3XJNlnhA6UoDcQgfEaPuVzkTEwX57mPpKEZADo=;
 b=N36VeO0G4UmfWR/FatoFSWiHwhmouEdzdVXuGOG41PyEZl2YsrheHgIazgA6vjkgMSxby/AoCS7IoxZZJmQbJi5b5l0ZIk7XZlKEy5SUNGcphZ2h+vMP00FhOmYvT6ST0BjbjRrYX8iKo2FCUvm7OS5yqhgJP5fTrm7+2a8t8S4=
Received: from BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 16:59:39 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::f2) by BYAPR06CA0024.outlook.office365.com
 (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Thu, 24 Oct 2024 16:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:59:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 11:59:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: add get_gfx_shadow_info callback for gfx12
Date: Thu, 24 Oct 2024 18:59:16 +0200
Message-ID: <20241024165916.439-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbb59f2-a343-4eda-579c-08dcf44d3f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NPtykNNJH7/DjBqJsb6ZciioqQ4hy2seRtHPpSwK6k4x7cIqLx5CPo74CBcD?=
 =?us-ascii?Q?6vWiQryiHg69076N9ecTHDVAlf+IanXQ37oGTkNIoqTZqO7myt3aDTFFYK2W?=
 =?us-ascii?Q?6X0RdYzqM9C+2wqDj7EVd6GNPbkvOcgWgwRGJh25YcwNyk8zyEI9hDQe04/x?=
 =?us-ascii?Q?RDaV60NqfLa+8OePK1vn3NfBAWjdSk7CQnBQ8fpXnjoo/4w1hLGtA6VEwsgW?=
 =?us-ascii?Q?jWHEs5BbB7KP0sQLS4ly8C4LWyGKoVIKSwKvfF4jo6HCbPBykk1+n9PLYKij?=
 =?us-ascii?Q?Muz2fZOf+kORj5Sbj6K+LVHH6+TtO/e3x8cenwy3gpvq59bw9+WYfFaR/aVq?=
 =?us-ascii?Q?IosLD4blyJ4pLV1k9Wb23mjD5Ko5ys70xDEJIoJ7te+XeoMSPd30L7muPvsw?=
 =?us-ascii?Q?FcAkZm+kU8lFWutOlbwJV/cYhvyoTHuMkK48RlquVgetW73SKL1Nz4Efo0sa?=
 =?us-ascii?Q?OsjrSnhzLpkn+qKtnSrwuk3jsofzPk/lDfdxgsQtiW24YnR+s4CHd54f58T6?=
 =?us-ascii?Q?mBmYYjzh1B5h1dxfzp57yYR3ZXZvUKip0f78f3Gm1HHII6JyGLP1TK4eYQ9g?=
 =?us-ascii?Q?MD0ddbJXG2ly7/tf1D5bDNNdYlXAHtFm8gxBc7i9otSWtzxa2SGF1tqx0mOY?=
 =?us-ascii?Q?xvPIFaRa0u9Dgj3l3rOTi09Il1qdpkN/vTrqk3/Rsf1o3dcNXudcP7ILdZTK?=
 =?us-ascii?Q?pvjeMWomzqvSSV0BclPS7jMYxTZs3ZzKga8sroV1kUqJuvZmBlMcRwR49G/J?=
 =?us-ascii?Q?DQtTN4fir3G2VLfYRWiAgMvz2IIVOkbtV7jcPFH0afQNYKfCN7NcjvNr4qVs?=
 =?us-ascii?Q?N8T9Q5P7ctIY/FtwR+VeIDqIaewiXRdpJhxhWqLk9gT+DfgUJ9qlMYo6zZH8?=
 =?us-ascii?Q?exrJEOiPOSR80ePPq7ka87vXvodDGAekRAFVgwkATARPppVMk/c8m51r2xlD?=
 =?us-ascii?Q?EUSZSPhusLishw6GLiXyCNPbZABxVVVt/1hR6YWl/GaaSl2rIxNUVtGqlf/4?=
 =?us-ascii?Q?RV3Ldq53xhhWWwjtaEqWrFzzTXn7vHNBA8EKF8qcnty6C/CTyqRjtXEf2lly?=
 =?us-ascii?Q?nen5yteJeO0lVzsXSrOB97ARiqqqhNduecC2LsAxlO17Wu/AjKyghMww41tQ?=
 =?us-ascii?Q?xvllUJaD09sJOggiQxq0WsNjlGA87Y8NHDI4azmURsfYa/zE7K4FUJnpmPW0?=
 =?us-ascii?Q?i0zvZfxH1RQL7EJSuvy7CfGy+zlRY1uwhi7lHEz6COjTi6FrbCXpG5T4I0od?=
 =?us-ascii?Q?yI9gmFd8sSZyMFlpl9CB2qH6ybXJdhSTjznerYzG4b3CYd2gOV+slDao+yAl?=
 =?us-ascii?Q?CSP0FyMblbDInOxwAyieie0Y6n/OgcfYQOchCq81WOTD+JptiRQl7vRJSZB0?=
 =?us-ascii?Q?N0iMbkrPtjtE5Hd2AUAacXoRd1FPqLGKaJOvoBjk2eVmw3OLTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:59:39.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbb59f2-a343-4eda-579c-08dcf44d3f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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

This callback gets the size and alignment requirements
for the gfx shadow buffer for preemption.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 02244bd2c418..0ac0222b178c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -860,6 +860,34 @@ static void gfx_v12_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc24_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static void gfx_v12_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
+						  struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+}
+
+static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info,
+					 bool skip_check)
+{
+	if (adev->gfx.cp_gfx_shadow || skip_check) {
+		gfx_v12_0_get_gfx_shadow_info_nocheck(adev, shadow_info);
+		return 0;
+	}
+
+	memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_0_select_se_sh,
@@ -868,6 +896,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v12_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.46.2

