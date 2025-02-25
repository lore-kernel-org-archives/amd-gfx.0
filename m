Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDDBC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FACD10E581;
	Tue, 25 Feb 2025 06:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ASyg2nm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7258B10E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P78S17gJJE8BFOrtRPLgeU6RKzmL0Nl+FwWTyw/NnJsti/SEHGaj9gtg75JSsjW/Cv5+1J/6sXBd0JKEji+wQNHUiUMM2lZ5uJIYk4suNqBk03jwqVPVr3cCY2L0RxyUBI92KUNzVKhCXxWrxRMB0MB6IfaZG7XMunutK7QBbo2dfOwyI2XJEjYyqKaxjaor84fn3ckjlWAESF5jfNhpUQWApr1gfvLsxldzV+wFIahUtCH+WqCXS6EI4+qy+xUJrj2q7jXi6OEyz98V14uWSmGjQ4LZkzpzaL00xbxbZsdl86otmJI26mB33G8NvXq191V7Jr0I+xyZeFNHb79wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yogVZJo5UpdiD51ffIQkL7LzrOAPFqvHR5Iq0K6yKW0=;
 b=G2DqXS7AY8qRWCIu9vxFUp0WJcC9Li4DKIFsg1Bl1euLweTWZp9zIAKjBH0QM+Jb73bBdXd03lZMxYyl4XRq3BXmpCD8IJwQAN2FICBYEOkT6D0IQWyK+mAiwtLRsQ6VBVuCNEezwI6aJrqgycoFpZxTgNlAhVWaFmNcJP/8qMQ07h1H3IT7v5vA/IbEZgHpIIu7a/Sudmr5epNxZNj4j0E6N9fcqG51VEhBFmbAMx0wt2MXGH78A1lYJL1nswzEd/glOQFsLjSpv/23PHRCFY1z2iw0N/ibricJdR80kAJMVJQAkrHtNovkOK4+kXpjyHMqV+MMn2qdwCtZka9zMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yogVZJo5UpdiD51ffIQkL7LzrOAPFqvHR5Iq0K6yKW0=;
 b=2ASyg2nm2LxwmginWwuxqxWlh8CkXiCxAp+qV/idH5wz1CVt2SlPs9RygOF+p9IRZN5So0spB6yj0HRox6K1byF7wfbYM6HHrDLVa6X7SqqS8NHY65cO3z+6kKMeEujVt58gohY8sfsQ6DOwM4NDj+d/9O0/UdCCBJ9F5ZjYGD0=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 06:45:58 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::32) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 06:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:45:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:45:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: Remove unsupported xgmi versions
Date: Tue, 25 Feb 2025 12:15:35 +0530
Message-ID: <20250225064536.118278-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064536.118278-1-lijo.lazar@amd.com>
References: <20250225064536.118278-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 821aad18-d4dc-437c-2993-08dd55680fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JI5LZx4MANqWL+dMz0J/0ZXOjD7b0BymfC5eFJK4JKVjgVckYA2m2x7THWcC?=
 =?us-ascii?Q?tPrZ5LFLDlCyZrfuwpnuc0hPjEAJjMhR+YNSvdZg2lykGptQ8rN0/iRIgwbo?=
 =?us-ascii?Q?o0+lOb33OTyzx0Ozb3hwZgdnuI5RFPJwTfBmDdj0PcC7DEGuH0GAzJY86g+m?=
 =?us-ascii?Q?aULl5iOpiLoZwueUO5oOW/NWRT6X9+8FSEfgtMy8HpPESTM58jsGAMT2slFV?=
 =?us-ascii?Q?/ti+x5pqfLisAWnPWoH+OhLb/MtHjbag55GCC/sliihi7T8ZDE2QRXEicPq3?=
 =?us-ascii?Q?9wSpasJeB4vt0/RaIWHmmD+MEljaZMiTnGPoxmMOldv9anfWyjnJre5sXpoE?=
 =?us-ascii?Q?5g9Yx494eryBLcM2qOYmVCPWKeodcVr0xEKsnd64G6nzyt0v0ogpM+jwlJdc?=
 =?us-ascii?Q?QAWR6nwRVlxbySGLVDEyB86F27JgsG72kB+T+4gJgTAU/jSbMR+mNG4/L3y2?=
 =?us-ascii?Q?fyCloFSV9+u4DBK6zYx1Tg8DBYFhydn4cbwKTfzIAEbcQxgYD+xJgNGjBAb/?=
 =?us-ascii?Q?V9qP/AfloZW62latoEZNFd6lGvt240ZIszmwmpTMC40J85nYoxyMWwLyMiIh?=
 =?us-ascii?Q?F/NIEE/h0eamPcfL3+wNMiwI23tlUALLqOVN/aZA47crAkD+JqYiH6IqztMg?=
 =?us-ascii?Q?UKKQlYKpdlOd0obwam7idatz48MgXgjVo8eChDGTta+VDQ6fAHpe8L1zofUN?=
 =?us-ascii?Q?kEM+oCS9dm+Ruv66MNSo/o5UNfpakX8h4YQPrN+N2WzpuZk+vKfW1lP56zWi?=
 =?us-ascii?Q?rzC9xunwdfcVOOwkE6biK1n5f7BPvkKcnjY7CdoxsxiZy2v4qlAaBWHH7FW+?=
 =?us-ascii?Q?HyYLf9uosmwg4hwsrEAffKwTjNGfxhjx94FEB5YbXUhxZsUE7MvHZwFhtaqT?=
 =?us-ascii?Q?1q6MANCy1Q6cKBGuq/hAxl+5Bu7nMz1knWhx+MIGzI2sCYuI2hvoIG5aIDnH?=
 =?us-ascii?Q?SuMXEFRTWLt2t3BGzWfBDN7nNNEYRPQ9POWDI0q0OLnFgopbmm6i+k3AVhvi?=
 =?us-ascii?Q?ctWyLJdmEzwQOv1F8z430cx1/J99Joxu7dDj/vhp0ALmOCstWi/6anPA1XGP?=
 =?us-ascii?Q?/tU2iFhBSZ8vAKkQeXB1fGyu2/ZDjOqH4YGTJ0IncXoDoCzFiw/e1VkGYpL+?=
 =?us-ascii?Q?NwbEm4/HHarJfCns9Fc2JwVqhMLEsi2CrBVbMhnjZok40EPpeMfoMQLLUnMN?=
 =?us-ascii?Q?vPHvyPfj9SlQIBNUIMtNx8tJXfsFpWAHq7BwUIW5sA6l3FyXWg6yQpogPLqY?=
 =?us-ascii?Q?l/XagTlxniIdTGHGIZf7/dK53bheP26w9U9WwJHId2umvAGwVehjVKORczJK?=
 =?us-ascii?Q?hgcBxUv+K+lVIt9sCK05/NGnkVXDPR6eu8o+m4MILsFRuKLV+Hx9jk4aan/K?=
 =?us-ascii?Q?cpYJW3JiaHm0HEHO9vNVugbTAWZZd93srl+85eIDwkRCPupYnc5nMINB+dyR?=
 =?us-ascii?Q?Sw7qvvt8ikoiVTkNAEXZcas1/DVEXiCmyHCRwj9mdjLnq/jU/p/3VG1O6nME?=
 =?us-ascii?Q?WPhQ69aPjteoF6w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:45:58.3734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821aad18-d4dc-437c-2993-08dd55680fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

XGMI v4.8.0 is not used in any SOCs. Remove the associated functions.
Also, ensure get_xgmi_info callback pointer is not NULL before calling
the function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2:
	Remove XGMI v4.8.0 as it is unused (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  3 --
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      | 37 -------------------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e1d8f0039d0..b2e9e116be44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4410,7 +4410,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
-	if (adev->gmc.xgmi.supported) {
+	if (adev->gfxhub.funcs->get_xgmi_info && adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a4258127083d..967a992829bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2772,9 +2772,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
-		adev->gmc.xgmi.supported = true;
-
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 17509f32f61a..deb95fab02df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -505,42 +505,6 @@ static void gfxhub_v2_1_init(struct amdgpu_device *adev)
 	hub->vmhub_funcs = &gfxhub_v2_1_vmhub_funcs;
 }
 
-static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
-{
-	u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmGCMC_VM_XGMI_LFB_CNTL);
-	u32 max_region =
-		REG_GET_FIELD(xgmi_lfb_cntl, GCMC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
-	u32 max_num_physical_nodes   = 0;
-	u32 max_physical_node_id     = 0;
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(4, 8, 0):
-		max_num_physical_nodes   = 4;
-		max_physical_node_id     = 3;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* PF_MAX_REGION=0 means xgmi is disabled */
-	if (max_region) {
-		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
-		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
-			return -EINVAL;
-
-		adev->gmc.xgmi.physical_node_id =
-			REG_GET_FIELD(xgmi_lfb_cntl, GCMC_VM_XGMI_LFB_CNTL, PF_LFB_REGION);
-		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
-			return -EINVAL;
-
-		adev->gmc.xgmi.node_segment_size = REG_GET_FIELD(
-			RREG32_SOC15(GC, 0, mmGCMC_VM_XGMI_LFB_SIZE),
-			GCMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
-	}
-
-	return 0;
-}
-
 static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 {
 	int i;
@@ -696,7 +660,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.gart_disable = gfxhub_v2_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v2_1_set_fault_enable_default,
 	.init = gfxhub_v2_1_init,
-	.get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
 	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
 	.mode2_save_regs = gfxhub_v2_1_save_regs,
 	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
-- 
2.25.1

