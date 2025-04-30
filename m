Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4315BC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 10:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA90F10E71E;
	Wed, 30 Apr 2025 10:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rl7VWxSC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2766F10E71E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU7J+FgAHjOojLUzGyfVX3B97T0kJxXq1HYP7Ks9Rjf/NF6M8/rXAKGrbC9axnk62U84Ad4LQXg1Q9KA218PrG8ffzZt/XgWsrxrTlUi2j9tzaV6dWs11m1MHa2DlL0T7If1SUPL3fXvDqoJ8X9v9NW83mj6RA0tKRKdeYvSDnRAPXwJtrMBTBC6yuVyeFc6Mh0ia/hJnA/t9Fm3XLrpRZMxqJiqRlreZMOhBvFB+MHzui+YWQs44nbDcHgUkZAxL+ddIbXKqqLTjpLGAMIkSkZP0eP41okCsdeFVidGbuhar+l9oL6u7qyUgv6BXbAHo8UXURwT1bX7rmTCcEb4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWp8l6oixCKNgtOQMeVMnulRGDZ8IJsLAoie2QhWh0Q=;
 b=Mf9AtCHEV4vB+EVTOAspX2Tl/9onor3WhfQMgRla2HeDTMADyKbY/5uWoQMNea5a58jrdDIgNxten7c2BE4i9TW7djRSHLXewr/SyCd+Llu+16kCs1cuge3pRARrVp85JTpvwJHiMiXs0UGcTu3qEuZI3I3n404wn57S3OtsBNSRa3lXm1JuRY0tEc9kd9GL6wwtN5TKIf63calAVyBRzFplQA4t3VGc9WKPRo3SsijPZWs9DA0qfOiRzJ9hyaqUhhsv2Ah2guwjZTOSwe8KOR5rKqJ38XEJPRtfdSzF784p9UTNXZUCW+1PSMblA67U3t+SKWB4+Ljxb/JjJCMMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWp8l6oixCKNgtOQMeVMnulRGDZ8IJsLAoie2QhWh0Q=;
 b=rl7VWxSCUNlAkG1qZq1lPFgmqoHIg9k7O4xBX63YVQ2j1et2Rk9m8gCXzURHi/1dhJsGXVdmn3K0QEqGlTaKrbfk0RqJsj0hlePCZftokruzYDlxubKjZ00CSpvweK7Ii0UZ2XTMC2KUDpt3i4M+PDRvcvdkJGhfewLax5uAG6U=
Received: from CH2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:610::41) by
 DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Wed, 30 Apr 2025 10:18:55 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:0:cafe::2a) by CH2PR05CA0028.outlook.office365.com
 (2603:10b6:610::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.16 via Frontend Transport; Wed,
 30 Apr 2025 10:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Wed, 30 Apr 2025 10:18:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:18:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:18:53 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 05:18:52 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>
Subject: [PATCH v2 1/3] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Date: Wed, 30 Apr 2025 18:16:36 +0800
Message-ID: <20250430101638.649274-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250430101638.649274-1-guoqing.zhang@amd.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0489449d-c9e3-41aa-224c-08dd87d06969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pPyw7aRFTldcZNFboegC8lntASgUk106Uxap9v0PP1zUUI7me4owgObvg3QP?=
 =?us-ascii?Q?LzIUZAagTrsP9Eqe09g2YXpAAM00iu9hKSbiy8XnENw6Jd1At1SDriE2sD+n?=
 =?us-ascii?Q?87yDY7bT1Hgxh+gdTEYBuWCmE0HKivJS83ozahTTwSasP32A8Hal4tORYdDJ?=
 =?us-ascii?Q?nHo+n1NLtDVZ5e4OEafHi/068KyZydJLmDBHM5jYApTRHQBm3Tm1RiUg7TC5?=
 =?us-ascii?Q?GOqIEfCC6FHeicTwEb5plhS4B12dDZwcYEAxz/M6deeTfLxUTRgfGBJVwHmn?=
 =?us-ascii?Q?H+FtOYgzBlAgeIJs2IiYsEUkxyyeegNP84ri2cP9zceQTfwBo1u0HZJHPVHm?=
 =?us-ascii?Q?ik7ra3x2C2EIQzmkR6n9YYOFNf/Apij6rSfkQ5wlNyGv2wWXdI0KYD6gLNkX?=
 =?us-ascii?Q?XNzfbEtogNDDWYfNQvZ3DtA9meOzJ1Sko19ACGDtUaWhEPKDVu/KUPYC7C+N?=
 =?us-ascii?Q?9xG5TxSehXI5Sy7XAEVDyat1E0s/BNkrLoPuozH1QG0pA9WSpp4ermsEkly3?=
 =?us-ascii?Q?mJSrwfC/Mw+t1HocCOMljp8M9OtFRZi91kqHQPE80hRAmlL+I3HvG7PtF8Am?=
 =?us-ascii?Q?Qd73sbagGV2WeLtmMi8vKlrLFYKSmSU1d8US2ktsZrWzLBoqc8cIEd6Yvynb?=
 =?us-ascii?Q?AX1Uj/swv4rUKu7BIyITBxeEtcIjdcxAxDjMdGeB2pktuYfiprVqbYrwFF2W?=
 =?us-ascii?Q?Naa2gKuF737DyqJdwXoWnqr5r3oeybJGZpHSPafjOpahx5zMB78X2bevjUc5?=
 =?us-ascii?Q?61xlHi5dz4B3Xd/uMO3yrUiu75yMCW+uksAM85dNIcDJ+1uRuTeTHEJssPfF?=
 =?us-ascii?Q?WOTiF8Jrq0IKULQ/rQMc3+eyXLk2/bYzQ8tvqLxRMwdbLgpUYnlApSh5D+vV?=
 =?us-ascii?Q?DmHKYALS1V5kAeKofm/itmWPhOCG2C9TOs86CoxSCZaX4PubFQidPiixu+tT?=
 =?us-ascii?Q?Nzrip90I4rL/p24kekQAndw6W6fWYzjz/rqMoXXNLgikiTVgFLJRYu8LWEOF?=
 =?us-ascii?Q?iPcRah6EZ1xvHq7ez4ShdxGhywlFT/Cg0OeieV51APVx/CiPZaP/DXrzWD2B?=
 =?us-ascii?Q?xy9iKIJid9meXmIaMs01A6Nqu3ITNhn5J3VVQzNQmSJgNKSdEWAgPbvZG19k?=
 =?us-ascii?Q?RV4cpfTYxIOHL64SX5tbDpjmxsKKvluQguxfY4l1P3Fizxr7miABt9AnDp9I?=
 =?us-ascii?Q?358DtTqM/aWBYxgdiyrYwwOM1rPt1PkN7XoUk0F/RljaNeU/5hcNY8ce5Z7/?=
 =?us-ascii?Q?JxuL2CwcQXb3TOS2fg1iNvLM4t/Rk25CRuWkHuB5ikH52ImE09iFVdq5/338?=
 =?us-ascii?Q?jZJswcPCgHR6nYGWGIG5159211G+WShdrol/xSWege1amQXmJjktFNH00zxN?=
 =?us-ascii?Q?dxKr151+Xm1XvmB2j83OmCKGd5Bsj+nRnAiyL6RjXeQ1cY4TDALUrPCv4Xug?=
 =?us-ascii?Q?sg/BPafHOMgqyi//4XkaLRPFm79bC0XsY33mvKdYJRfanD/sr6Fj6EVbBRSi?=
 =?us-ascii?Q?ZCWOJbyVqVEfWKsbNc2EvijJRxrCscZX1H6y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:18:54.7285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0489449d-c9e3-41aa-224c-08dd87d06969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

For virtual machine with vGPUs in SRIOV single device mode and XGMI
is enabled, XGMI physical node ids may change when waking up from
hiberation with different vGPU devices. So update XGMI physical node
ids on resume.

Update GPU memory controller configuration on resume if XGMI physical
node ids are changed.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..af2c784a6ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5040,6 +5040,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static int amdgpu_device_update_xgmi_nodes(struct amdgpu_device *adev)
+{
+	int r;
+	unsigned int prev_physical_node_id;
+
+	/* Get xgmi info again for sriov to detect device changes */
+	if (amdgpu_sriov_vf(adev) &&
+	    !(adev->flags & AMD_IS_APU) &&
+	    adev->gmc.xgmi.supported &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
+		prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
+		r = adev->gfxhub.funcs->get_xgmi_info(adev);
+		if (r)
+			return r;
+
+		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
+			prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
+	}
+	return 0;
+}
+
+
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5059,6 +5081,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+		r = amdgpu_device_update_xgmi_nodes(adev);
+		if (r)
+			return r;
 	}
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..a2abddf3c110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	if (!mem_ranges || !exp_ranges)
 		return -EINVAL;
 
-	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
-		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
+	refresh = true;
 	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
 					    &range_cnt, refresh);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59385da80185..3c950c75dea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2533,6 +2533,11 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	r = gmc_v9_0_mc_init(adev);
+	if (r)
+		return r;
+	gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+
 	/* If a reset is done for NPS mode switch, read the memory range
 	 * information again.
 	 */
-- 
2.43.5

