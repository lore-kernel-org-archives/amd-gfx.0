Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F62AEEB591
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 11:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A51F10EA43;
	Thu, 12 Sep 2024 11:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q761VUcl";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C266310EA43
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 11:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d964+fir4lAWpvLHUmi1OXhs4BCPe7zeJVOt7fHchKJ/j4xQR9WwgYeBDlwdrqFJwtkNcukeNQqajMVfWhlHUjfEFbFv4ouYuMFgvT4weclRrJEU57G2dyfoc4Pn+Z8qK3X6wez6f2t5lrnfONJ4ejyCvr/4CS1zTLhR8t5tK7uEiVPWElUC0zgy1VRxwauyI5QSj8PmhZOS6P5ygsiY+9inh3pgQSJSWYmTUl6lk0RSsDKmM5E0xQCPfJQANJ0FwfjVmuoPHPPHHSHpprIQbIcae1xkDhRFWzG6JXONBsZEuLpl5cwx2N4WuRX5xhVG0ICO+6/V3MT3IXOk8LRTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vYAL3oubLV9kWybdkIk5ac1UHnpNLcnTqhyPlNW14Q=;
 b=w/07wiimhtbI3Ivg+yxh3geUfBgUJFLi0C4rNFgH/VUv13iIQidbxeaDx7DBmkuxmgRPEFccMezqK00LcsooPTl0evhfdxEfcmgzjBkd9AD3PkpMQHaAGLpB3373YZKy/yTUx4lo+PxzYw7ZJrNpHGvtyhX1lLoUSbJbpPq+Gnl7hS1ebj8CstZfLuqvMmjv24mnz/I2tj7LoCUB/aI8+p2PtQ4rrCBPAxHy3LHY2uirhRqz9nZ5wfLbF1O8ksdexLu4ZCTVr9dKsbt/yMa0VwgcALej1OqKM9mcvBYiArkhTuh0x+ycsXae3l2SzUIdnKLc4UY8M451eP7oJM4ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vYAL3oubLV9kWybdkIk5ac1UHnpNLcnTqhyPlNW14Q=;
 b=q761VUcl/f8ACEgvJcswnPe94G+zXV+NOdUawVsrXookeMp4TpoLvFXGR4xjlPUxxKCbce2fHO0FFwRDHg6TkBh/sTDm5OxWFNaV7PTdqH/0fUACr5bdc8T53wCrxhm5SF62rVt7d6b2RhRmVJ9w+++W8k5+06E9LOUnuh9I2RM=
Received: from DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 11:11:16 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::d) by DM6PR17CA0005.outlook.office365.com
 (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 12 Sep 2024 11:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 11:11:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 06:11:14 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Asad.Kamal@amd.com>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix XCP instance mask calculation
Date: Thu, 12 Sep 2024 16:40:58 +0530
Message-ID: <20240912111058.2252065-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 692bc107-8108-452f-efcc-08dcd31b9eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vv583FNuYFI2Qu/P4QlIBi21kHceAhe6nc/kU0FmrXiGfc6LrmeSMDsb4LtV?=
 =?us-ascii?Q?B0lZL0PYFEgLqkIB+rZK9q0T7KVw8gIz+5eTFmzUCuw3ycJaumnMtai0Imzy?=
 =?us-ascii?Q?xIP4spXfJ0J7WX0Jk4Solsy82jr/qmXcOOY2fSHcQscCoehKy7iZ2/mH8Zj4?=
 =?us-ascii?Q?Fas23gXQ+Z+HyiJPfedXVAbCEkqWYUzxOtdPP70TSU1wDboT6wn/SIqYIgK7?=
 =?us-ascii?Q?C8HpTjrPcogDrdUcuW3yVWKELWXjyyWSWfyLwyDw1BKz+UPy3EG8GEUmm2mX?=
 =?us-ascii?Q?3JqYd5iuzgpaci8EW3LxobLGIuXf63zdglK0UtDuXYWQ8MLv+Ile8MyqpuMW?=
 =?us-ascii?Q?AVyex5HzeJv1u0CflcupzGmwK9zygzAA3yxXa6evZjcBH6oQ4rjJkWbgIuCq?=
 =?us-ascii?Q?D1kVTBgjBDFMmx2mhf+gsbNwQX5s1Ph+Ftv7oTtTnCFsHjHveBP29EcsJAqr?=
 =?us-ascii?Q?3hIDFnSUKtFROiSh71cqu9Tk3p9gNhmZIutVWY1nKYvxGxNKoBfNuDgXChdr?=
 =?us-ascii?Q?7hEmwA8G0fgMEzrfHIvGLCSuV+Fz7qaH7+TbvbW2xGH5D0D6WWkJWeOQSNMk?=
 =?us-ascii?Q?k7uCizPkM0rwGLMGYNfqz/+S68XYWdZf/1+1JvQg6NSx8ZtQQjRwuXlzrbN1?=
 =?us-ascii?Q?yyfkIWd8SzbZ+g0n073Bk5AKmjv9DUQ7lZoqDJvJDjSl4WQyiMboiIOuw2oT?=
 =?us-ascii?Q?J1LdCluKv/LW9YLW/VvW+FgL7vJI8rWfiikpTE8+p9kLFhbEiMAZZR326MaT?=
 =?us-ascii?Q?URqRS3Yf5KTew5IE7g7xQpu9zZc2IcA1ZzrZrRrXkRrEjxrQgP0AnKE7ildd?=
 =?us-ascii?Q?rQwroCR99pFANS538z5BlRbo/y4jMk/DiZjyW/ZZ9m2u4w6bWE7/9aPFf1mj?=
 =?us-ascii?Q?MbJ6lrszQq7pRkEKXDqbk685UdY2WSM8DOLDczfF79agfgsKD82FhtTDL6ea?=
 =?us-ascii?Q?PStqazfG7pl51W7w/It/39A1lnhY784EiLPPo02ncyc2LPv+9ot0+Y5yipAS?=
 =?us-ascii?Q?I/IoUmEeENCQ2iIwBoZYoxysOhJYE1FFxesaOn99Lc2u8oUS07lBGqJ9edwS?=
 =?us-ascii?Q?dh1BBxtG5BLziD49t3Aq8+Jp2RxojMO7wrwe7PC3wjcpWT81iaJCTwtHljtJ?=
 =?us-ascii?Q?U5X1UOcp3k5nE2QOHtZnmoug0deaqz0atkN5eoRDUa0OB79wfU2ZBxSUbJ2q?=
 =?us-ascii?Q?sWiLi1MK+2RvUCLgNtW9sMHOiJqxf6xChNdD1sHC6p1xD5d481pa0MqM/ZaX?=
 =?us-ascii?Q?RKpbnb2t6FBkrEWBgL1WDaDMCWbYiMo7TXxTBeVOD2JevH/mbYiIT8IWz7qC?=
 =?us-ascii?Q?vG22IyRqx2OLLOejvuVX9vZ9DaYwxt2RM15Gqi8M+8fJtpD68rMqkxc1NmPE?=
 =?us-ascii?Q?nlPLTKcbi707rYhJSITwwcbo1ROiS6vR4l0G4q+65bChEKblEyIwHK1FlX8O?=
 =?us-ascii?Q?pxFHSETvAm3SvDGSyt6jHLvyZhO6isTM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 11:11:16.2710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692bc107-8108-452f-efcc-08dcd31b9eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

Fix instance mask calculation for VCN IP. There are cases where VCN
instance could be shared across partitions. Fix here so that other
blocks don't need to check for any shared instances based on partition
mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 32 +++++++++-------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 8381dcaa68e2..719f1aa6a429 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -94,8 +94,6 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	case AMDGPU_RING_TYPE_VCN_ENC:
 	case AMDGPU_RING_TYPE_VCN_JPEG:
 		ip_blk = AMDGPU_XCP_VCN;
-		if (aqua_vanjaram_xcp_vcn_shared(adev))
-			inst_mask = 1 << (inst_idx * 2);
 		break;
 	default:
 		DRM_ERROR("Not support ring type %d!", ring->funcs->type);
@@ -105,6 +103,8 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	for (xcp_id = 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
 		if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_mask) {
 			ring->xcp_id = xcp_id;
+			dev_dbg(adev->dev, "ring:%s xcp_id :%u", ring->name,
+				ring->xcp_id);
 			if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
 				adev->gfx.enforce_isolation[xcp_id].xcp_id = xcp_id;
 			break;
@@ -394,38 +394,31 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 				    struct amdgpu_xcp_ip *ip)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_sdma, num_vcn, num_shared_vcn, num_xcp;
 	int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
-	int num_sdma, num_vcn;
 
 	num_sdma = adev->sdma.num_instances;
 	num_vcn = adev->vcn.num_vcn_inst;
+	num_shared_vcn = 1;
+
+	num_xcc_xcp = adev->gfx.num_xcc_per_xcp;
+	num_xcp = NUM_XCC(adev->gfx.xcc_mask) / num_xcc_xcp;
 
 	switch (xcp_mgr->mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		num_sdma_xcp = num_sdma;
-		num_vcn_xcp = num_vcn;
-		break;
 	case AMDGPU_DPX_PARTITION_MODE:
-		num_sdma_xcp = num_sdma / 2;
-		num_vcn_xcp = num_vcn / 2;
-		break;
 	case AMDGPU_TPX_PARTITION_MODE:
-		num_sdma_xcp = num_sdma / 3;
-		num_vcn_xcp = num_vcn / 3;
-		break;
 	case AMDGPU_QPX_PARTITION_MODE:
-		num_sdma_xcp = num_sdma / 4;
-		num_vcn_xcp = num_vcn / 4;
-		break;
 	case AMDGPU_CPX_PARTITION_MODE:
-		num_sdma_xcp = 2;
-		num_vcn_xcp = num_vcn ? 1 : 0;
+		num_sdma_xcp = DIV_ROUND_UP(num_sdma, num_xcp);
+		num_vcn_xcp = DIV_ROUND_UP(num_vcn, num_xcp);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	num_xcc_xcp = adev->gfx.num_xcc_per_xcp;
+	if (num_vcn && num_xcp > num_vcn)
+		num_shared_vcn = num_xcp / num_vcn;
 
 	switch (ip_id) {
 	case AMDGPU_XCP_GFXHUB:
@@ -441,7 +434,8 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 		ip->ip_funcs = &sdma_v4_4_2_xcp_funcs;
 		break;
 	case AMDGPU_XCP_VCN:
-		ip->inst_mask = XCP_INST_MASK(num_vcn_xcp, xcp_id);
+		ip->inst_mask =
+			XCP_INST_MASK(num_vcn_xcp, xcp_id / num_shared_vcn);
 		/* TODO : Assign IP funcs */
 		break;
 	default:
-- 
2.25.1

