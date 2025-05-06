Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6152AC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFC210E069;
	Tue,  6 May 2025 09:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXQXMHpa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C1010E069
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4ctq/lJHb+sgy/r4K7eHqqWzKXXJYMguq9FW5xLOAMjHmCWDzEK+w6bxQxUvBjXS0OCGy8yA80TjkDG/fMOxSAck45h0X2uXQky68s/+ocnG6GyMgPgl4Cn6CkH2C0r+UlHp26LK++aZ+B5oB2a5qUx2cMzlsTtDj3MiyA4MNsHL7i3BSEtRLMAchroSWuUER9mH6xyQbp9ZWQqofOdKth1vkg1pCABDKVUPlIFm+hU4G2fVwiKu4pgXqhCVQYXH8fExDcvClpuC9ghBL5QmSUkrJyJggxAE7Y90nm4DeT7jhQqDg1cmBxqA/gJGz57QtuUl3lqES3yfHmDKmVfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AL6k7QSqmWt+AOv8PuyB7P1Lr+7dDMEUCCCr1ZxjZg=;
 b=rS4rDiYwWPmDPUCB01xeQEeckRslJDfdxG5iyCMKesqhOMni0Edm0fPCAoKgNAizbmgiJ+c3tCcvxpl5IGKA1att45o1+MIGzeVQxoC9iKokxuMMC8wc7z/RDN1xxoiazY7W/yOPWVjrdlIHOlPYc79r3SfyPKAiH6wrCOm9lTFsjDndwSEkJUXbVX272DDjbXE5j0cjbLxPhe+y2CslKyShI/w5moACMATZnR+eqaq1Epga9lgpJlkVMPmc1d0zxKPTGa20QPLmXqhF8dmyqFAMEAlmOJVVHZ1BqX1eo/9Gc0AZHArYoPDNXitUSXuFESrCPwpoFOj1OPnwhomJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AL6k7QSqmWt+AOv8PuyB7P1Lr+7dDMEUCCCr1ZxjZg=;
 b=uXQXMHpa+DfqAAlnQH/4rLYQe/lk657xhWTH8966DZtr+KQx44lnED2PqbzzbFu8NovlJqI0toPGE8dYgYX7Lmybb/2a95zuZdMPox8z6iX0bfhQi50zl2l9BRm0MMUN5Qy92MPV1KgkdB7P2QurnJmmkZjetrqmtCkzqwNKc4Q=
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 09:38:05 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::c1) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 09:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:02 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:00 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Date: Tue, 6 May 2025 17:36:23 +0800
Message-ID: <20250506093629.249792-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a0e4fc-052b-4bd8-b439-08dd8c81b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rbNYBP9Jsobgn1bwK4kcsAC1vvAj2kbUHjvgsPIKTCR1IDFw/xskOpLbMgFp?=
 =?us-ascii?Q?DXopGSDrIs81ySBXhvcHtl1Jfv7oF1a5SMlrJXRQcUUyFngKcaldD9C1jzkz?=
 =?us-ascii?Q?1m6b4NuDBAWcKsfcUlSQJ8rwF/9q+c3kTnfeDejEaOo8LAFdx1VnhiZL0cmy?=
 =?us-ascii?Q?kskPfkh0nRHqp4F/wP3y7MLFtV3oyN+6yVI2F7nhs+8zTh805MXRBihfvvfq?=
 =?us-ascii?Q?B3k8dFH/XLKgjoNnxBlD8gKjZZPan+ifZjEKHLQEJjhgeei2UbfpoL54avHs?=
 =?us-ascii?Q?4iS/RHCcH2Cx2aV/RUG9m2VAQeZB6s9BnPsTXUicNLDSsTScnndp4iKjO4KZ?=
 =?us-ascii?Q?/MziqiD5+loldI9PjiNVpSsz22gB//dsrk9aGpHzXqxuqVxZfcmCSo5OZkBv?=
 =?us-ascii?Q?DzizMLmU+52yFGoCvudHP6xBI9qqbQZOJFSF9eXLOujq9UaDYOgKLfyO2+xu?=
 =?us-ascii?Q?aq5L88SO+rSFpHZ3EIvHOaOKzy08Uey90UAKlJe9I+yFuoZjWTWZsSmvCsH1?=
 =?us-ascii?Q?yMVvOT70yZM9qfd9MFINSLFdjg3XBdNs4Vm4SxX7Fo4pNzkSDDWMItSLKPVm?=
 =?us-ascii?Q?dDgrY70wYTz9wptZT4PmtiP019LCXtHGUWft9DCRP2KNVf4ngnJua6ufEGKJ?=
 =?us-ascii?Q?x2sNAgLiKpD/kGA3suR2JNm/dbNzGGev+83W4R9WJF7uVg+pKWzcliyWcXdM?=
 =?us-ascii?Q?/0KwriFXTM27JZZi9Em1zT/8PBkecgXXV1iFo/kMVzFmtZYpEFh5DxZgFCV3?=
 =?us-ascii?Q?sfBx0chHXoCg2HWxQ1gMUhKksSZvtm8XpxVp0A788dqeJE4sTvuF4oWSLw//?=
 =?us-ascii?Q?v1pzQ8ehO9UW1BadehD0OSIBZCs0FXahbDWXedYt8deDS7j/U0bLHFDn4jWM?=
 =?us-ascii?Q?P5EZzTV9hxLksFMnTPgw1uuQeYZajT9+Ofn6HPFm9lsaDPK/RyxrBMqOm2t1?=
 =?us-ascii?Q?7njgraguST7HAXqyk4APGJOFsPCbBQ9f0omIWMiOtHlRsqxwLBijatX6QDia?=
 =?us-ascii?Q?yjMRy7T+YAEMxz/w5NgkXyC84zazVilFY/9yVf49RUClzDNd2pqQoW2zrakN?=
 =?us-ascii?Q?BPy0qWunqLLpmVJUq12tcvTwoVxQUhsvbhoMR87lxLIFW3QqFJy5sQ7+Ga4w?=
 =?us-ascii?Q?Dpphg/MThDXjIMyrQ+C1O3fANlqQqyQa1kUQ9j4wvubGQkD5VhFNC+rCluQj?=
 =?us-ascii?Q?jjnpqhGtY21Cekqc1mvhGtD+sCqIdSaO9tOBkff0+zn98D6++EG7oyp5cr27?=
 =?us-ascii?Q?X7bRF4hiIDIGg34auDdMroxCrpGJSAJKXBKJjHZ7cU1myZA4MBkb6ZcfgMoY?=
 =?us-ascii?Q?pvgrT/90YRxp8+dC8sOSHf2qaW/5o7wahSDgALOxoq3tA8UJAHJTrb6l7PYS?=
 =?us-ascii?Q?24NMamEgCyVMak7uOWwAix013dYAOxdrdFN7LVyK+40EuRKjguiLZUYKGTjk?=
 =?us-ascii?Q?Gt8dxHtUGnGyITNscFE/TJqOLXzxIGTMkiTmMMpQvFH5TmqHrwJFiJSwMw0g?=
 =?us-ascii?Q?bI9WAPOr1fjvMaQPuOQnQl2iehgHR5lN8eMh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:04.3632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a0e4fc-052b-4bd8-b439-08dd8c81b35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..e795af5067e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
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
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+		r = amdgpu_device_update_xgmi_info(adev);
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
index 59385da80185..1eb451a3743b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	r = gmc_v9_0_mc_init(adev);
+	if (r)
+		return r;
+
 	/* If a reset is done for NPS mode switch, read the memory range
 	 * information again.
 	 */
-- 
2.43.5

