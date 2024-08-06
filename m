Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8564EC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 18:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3608310E065;
	Tue,  6 Aug 2024 18:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SVCUQTT7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC2810E065
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 18:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFJ2r9TzwwzpHhGYjtk4+Oc+MwcwA+7YvQLVFnt2BDZW7eTtXdNWBQVx23dCOTFKBJ0CkF5/e3eGHKkFXczcmQ+D26e3q8qZ6xdSJ7KWd9+628eTJJM4bRgTDq7FzK0ffnvo/+RYLmMxpDsXBUY5NRbywD2DbH5pv/XoMRSDuI5a3RTPPnwMjxolvmoaYFP4ij92u7JC2eGuKREkw5F8YxiojfiIkKEJzg/xmTVx/R2237Ac/697TElmdpdsO2wYz12dYPbNOIgqxd2COWdgOxNfgqZPCS+/1cflM9qIsZsGWyMWPBRvgex4IARWr0aAaEgWSdCUhexyI30+trfNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfc5YNtb4LSGIg1FqXZ51V+3fvVMadMxCw+cQZNwW2M=;
 b=Yeib7OC4cHn/D/5+nxVJisGq/FUTvrW4oTI4HED3dOosjtNOaVZ+1niguKWpzQIvGtSXKZeYz+QBr5PMXt9AVsXkC4l6BApFPOmkdP7s51jSXDH15QT2UHcj01YEttGFU2No/3w3YMxpG3t2yOMMJygbuFYS/oegCbReoomFU3BZOL+eE7YkHyiU7OI7ZM872EM6lbwAf6qQ6VtIDepb2EBPXVsMmj+diZLLP8/2cgozFlcfMjs5c1vFl0o5OjcyYjMGYYHCK+Zcitf+LbqvBW1a0UIc8qRrCEiqDmXSHNQggivLe79dD3BuCOGkf8EbwHCFOuZ9vh52qShVj3XWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfc5YNtb4LSGIg1FqXZ51V+3fvVMadMxCw+cQZNwW2M=;
 b=SVCUQTT7oiW6UFHYpcBAQ0+rmnerI/CqW/cnI/nA8Nn26aVb1Z6EYovyFwlB6ZCG+nIKdtEiqA00TMJELgIjKhJesO4RthRG9SRv1if62k5hah6OnzodH+BBztKD7A8uOqKX+FbyW+LEouR3Vohiwsmxt26S70rH2yUMMF5yIw8=
Received: from BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 18:39:17 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com (2603:10b6:a03:d4::4)
 by BYAPR06CA0012.outlook.office365.com (2603:10b6:a03:d4::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27 via Frontend Transport; Tue, 6 Aug 2024 18:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 18:39:16 +0000
Received: from yinjiyao-test0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 13:39:14 -0500
From: yinjiyao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <ruijing.dong@amd.com>,
 <yinjie.yao@amd.com>
Subject: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Date: Tue, 6 Aug 2024 14:39:03 -0400
Message-ID: <20240806183903.198416-1-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1d6d95-1991-4153-9199-08dcb64713a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pqqpQoiByJI2q+uTbaEInYtckjRfmBQM8zN+P1TOW1VglUmrYfcNhbJcf+SC?=
 =?us-ascii?Q?pYQbkNT8M9N9PpgVgKntqoQ0gaVrjpieHCJrSKhDRdmdkDGn7S57wEjkYSSY?=
 =?us-ascii?Q?t03H1YZSvPM+VLZmu29+grx9OEuY0KdJKkWq23DZSHF9PKL2ltk+Qu5d+e88?=
 =?us-ascii?Q?QvkTqNFFEBiYsmPsVBXBpEFh48n4Ju9oA4ShzCE+cEJG6eFtIZxg/g4KrnKf?=
 =?us-ascii?Q?bzjp6i/ag6M6VCqsjB04aPxDrJfvSW0+TNogivvG0hBLByzMOEdh719A8kgl?=
 =?us-ascii?Q?7lCS8FEHOudnH4rIiTsQitdP5QxnGpTLdppOIrDMHkwpw5k/rS0AFTOO4pJy?=
 =?us-ascii?Q?ZIs4FLV7jjhNghEA1YoS2h5FslGEbLKnyTKIi+6qv2nDihbfUSCTj+wCMKaP?=
 =?us-ascii?Q?wUt+t/Yy5o36LoRXlSDXKl5D+askI/Tlj1p8Sb64fmJMI/3FkFhP7ZZZGE1k?=
 =?us-ascii?Q?8S18EzN8BUfi+G8ZqqylzQmC0Tw24lDQoM2DyxVJNCYiqt792+X99GMoamTq?=
 =?us-ascii?Q?TeUDEkQgAZ2w42tMh/mcNwUw7HOacgRTdecC0ZOQpOtC54TeekkuL8i3RZIo?=
 =?us-ascii?Q?LsYO3rghMNIERSukSuSqtI5ALFxIOwvFmiWq8c5oDbFKqS8xyNmBbBmY3IE6?=
 =?us-ascii?Q?94FaJ/8XVr6ReekPCmmqejLQ8YnRIJwQVM/5Zx4Y9K9veCt70pXoAZzbm5a4?=
 =?us-ascii?Q?vmTya5zkEQDyZV0dA6wCMHLJbroNw1wIM7xZjUTAeUdiAklVTg78mUKxaPa2?=
 =?us-ascii?Q?RYlcyBkSHRL6sL/wz+jd8HTtU6nuIrMTdUikEmtGjb3AHdlgCR8qt2ATnot0?=
 =?us-ascii?Q?XBGAJ7oKI1s83L5zMRy58HHAWw8GshBoaohQMbKikhHlEzVdOHpdx9AYAVBv?=
 =?us-ascii?Q?bCFpF+VF6LUvBP+nNLB6QOGFOrZQMkXG3tkLD/fsHyEsLTbN3T1OzfCI7itC?=
 =?us-ascii?Q?QL83rCDWQYoNfbB7HpJC7fnniQmSVnN1LmG4+vDK2WQU+GmP97iJqPdwG1FN?=
 =?us-ascii?Q?ekC4N5cEdJpcYoue1oe8axaXCCHokMDADLeiTv3YuwLj7t+/0ZuW/hNi3aR1?=
 =?us-ascii?Q?bWtWzIo5gIebRPhNn7J0NtwPQfyH6sIia8AjmUNyuxHGa5JXYrzydpVBSRT4?=
 =?us-ascii?Q?fCou1PVDWqSftniCoTCInpRVxrS9o9QW2Cp4U+CriMXYjcimP59s/7UEEJDQ?=
 =?us-ascii?Q?UUwFKJrBu4a9/jNAvkffbWyGAWN+bbIb0usY2RBhpBabeOM80XkPV7XXzFU/?=
 =?us-ascii?Q?u6QSggNN9KobM+IYHVqnQddE3iZ42KH5v7ZMVR0XLOC5UyDLrqWO3bnlU3UM?=
 =?us-ascii?Q?NZVjUT4lrj2Wc2in9k5wPP4YcgvapqwZnihrsEchjah2qVI7v6wA/kpy3+Nj?=
 =?us-ascii?Q?iKKw/aP4LzHRSbI72e+U3C8JZxXJbnNIVoGMx4bzkdG/BIqnML5kODO53x1k?=
 =?us-ascii?Q?hYZlRAnOV40S38vn7t9pwymAueRh2veg9JzIr6CgVytUeUcyX5amhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 18:39:16.6181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1d6d95-1991-4153-9199-08dcb64713a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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

kmd_fw_shared changed in VCN5

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f127eccf59d7..2a1f3dbb14d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -464,8 +464,11 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
-	uint8_t pad2[4];
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.34.1

