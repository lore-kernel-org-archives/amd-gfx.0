Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FFACCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E3810EC85;
	Fri, 10 Oct 2025 21:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bnBvvXNf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18E010E16D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWuhMOVqpNSkkee6I9PntZs5sI0N1X0ckIuZDLBGhaz6EqK1MyawYmfBsh7nNcceJqAeC673aUBKgruhWNtNaQH+z51THeYrbdQTHw7ajCPq4cJNKgKRJlqMJFDWO8Js8EGwGcCbwYJaCfebkxdUIczFjcb35pSp1W8K/7VXyRnr2cD4cAxQreheKnM7ml8K5xYLXM+nGMBkJfX5z0mVjVht4aCf4eG1uB3cLs/7omcsPxQWLctuwbdth4FO/dLvCEgv9UM++7+vIaWVXA3DTJCPVHtOCgyrduqazem6PXU2JshK+O1m9lvltHZUIv2WlKu8NvfFxxFfbvtCUgG6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn2YLeu0/H2pAFfRnRTpZMKszmMTZCC4ddmcIcBSYw8=;
 b=MlLVPGgTGThzmTjINhV4O25xwv7/SlyOI/7CGY5rEtn+dcnixqn2ISX43D8Ffx05BEHvdGJ/9JPRQD+vCpsX3W6FV6KLIFDjZZAH8dQ/zF3c5NQKm1dbD13AkvbdDx90ZPahcTsFzBWzRufzsj5s0LBWhKmNSHlXf3ADKQeiWGogRWqwwHGM1RJFrGO6T9wJSWgMtSvrQJgYe7UJ/7Ruoz0oBvMm6ucOnWQYcVq1fpX6MHNP7qr7nkegH8RgzWumJ3ZUvAhmIx4l0a6YF2IemYOqA3ySBxjyx2zLb4PD+f8Amk/j3DD7I+71zf/y4VkrSM84yukH6bP8t1JVA4MElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn2YLeu0/H2pAFfRnRTpZMKszmMTZCC4ddmcIcBSYw8=;
 b=bnBvvXNfDPHsAFb1FCGqEHMjhOT9RAeMLrUB0L9WKFiWZwYj1YtNtSNq1zySfGrsrK2lls9AnoJp/aED5kgVJRfRSJL6VwuaXf3CPCDuX25hbvKzbGcWqr3aviKKX4Jg9LMtlbfGKR3CxhlpsyUnCATmlRbxKWvL41o5ATUvpKM=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:15:41 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::17) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 21:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:37 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 compute
Date: Fri, 10 Oct 2025 17:15:08 -0400
Message-ID: <20251010211510.1528572-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a344b13f-0780-4f5a-3437-08de08422ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TOXM5Cx5M24hZ6govwXI4Cbassg91AgW3DNrlwlSlW2TNCeXN0AYp+VE7bq0?=
 =?us-ascii?Q?HOR4tbAEhbwIeKnc3+7D5kWQVs5O1wvTqT4Jfb3jQ3i3AehkhEZO7yVlYbam?=
 =?us-ascii?Q?eSzwNE5kWmqDJgVEkeuco3/IP0qteBn+zpy+ZSkol8W97U6Wx4HgMlBJoXav?=
 =?us-ascii?Q?VmKzOck1dhkXb7GBj5LQmOt/wkH169KYaxIZlYYBDzWdjBY7jm91XvzkrOit?=
 =?us-ascii?Q?d07tCEnvzsJn3MEcmNABWh+R1NhhKK4Zjt83jx5MpMC4OYrq0L84BhIjPnSs?=
 =?us-ascii?Q?b7vKod7oySRX6ohRSngEia+1K5kJLBuiW1zhj3vJlNCgWukZMom8yK69+kXi?=
 =?us-ascii?Q?rNF/hK4PNMO5s6CY7iMRsRAjMyq7NZeJFOBJ4uQePdL22M2LWiityYUgD53u?=
 =?us-ascii?Q?Ps8o3Qvz++EhbI8LB2Atc367+q/AvRCAG5s28EJKN4gR9qW1vzFTALrCLQFy?=
 =?us-ascii?Q?5y0VW7c2iAaTT0r2OBFQjLiithtrVFxY+fGbh26XcBoM/9cO7qnRhReHBAhp?=
 =?us-ascii?Q?CrGy0U/N5YDfCgIPvNpzXih0wdp+v4kEdKzvVLhPtkxe7m1hLr8chy42w3jk?=
 =?us-ascii?Q?xy8O8Ho2arKUQsfUPAsF1sBswcyIaODy0ljEuQ7Sp2HzD9LSBmXUIYWc1lIi?=
 =?us-ascii?Q?X/O1MLAmWLCGKYLDSHd0T7+jPUG96ffWVn5YB4+tLwoIJfQHiOjmVS7/I32R?=
 =?us-ascii?Q?X2nW9YgDCEGPUH2C2EohZJOHG6CsL1yWj0CkBJ3RdsE9AGlxo/snBFjwgssA?=
 =?us-ascii?Q?XFNUYjecWmGeou6JscTZ9JHPHHiaGqCuoaHtLOzlI4Z+oGpj+n34Slm++QFp?=
 =?us-ascii?Q?ncZSVozq/HtDrexlNZc0DNv9wT4nUhehivSnnE38hsgnHJpIvNnBoCR3LAe8?=
 =?us-ascii?Q?AJGpYcUcyTFeUt0NgfR6nwkMypA0xSfYyQrYbH5Esnre0OA5e3LrPD1SECsR?=
 =?us-ascii?Q?/CbT3D/+fR24voMzpGzCCIbwI/64nBU9q5CjWuiDzQqt9mIcmsYCZ3DO+gow?=
 =?us-ascii?Q?8y9tOd0mkIueqs9JdaMoeUdNdGOy5/+JAZ2fNF3ifSetob7zvKLRKcldhHa1?=
 =?us-ascii?Q?p8z3OFHaIGfJyvMLxQQtY3yE8ZgsTpYXhGWZTpwInKaDtE/NXV2WuLF1TgGO?=
 =?us-ascii?Q?OMzUr65shLDs/NP6e8KCYFg7EMDLXqI3qoKzF3ub+UFNpslTFqweKnndMvs4?=
 =?us-ascii?Q?CjIUOV18vCWGH0rErc2nNQaNCSLlEPZEXpO/FBzdV8nr68jTRyBhw/uIJ2BX?=
 =?us-ascii?Q?zN/LS14DrGwo78NvLEtQeutFr8VVxgMMVptGMtra41mwww0li02wOYHV5RXh?=
 =?us-ascii?Q?elRvb/tY8njNGVuBY1KiMkd01D/X6MegHty+hTFlpAGCyyf8UYYwIPz955SP?=
 =?us-ascii?Q?o8gp/f2lMInqRusTm+FTcUKUwFxtRus/WSdcO9IETqbt87iUgohwUIRHLBOR?=
 =?us-ascii?Q?oSJEfcMKUYr5b41iOBEiNQDkfCj9Pqo89BVykTfemrQvxiSbIt68mAPDXWi2?=
 =?us-ascii?Q?ogZ9WdZgSmG4bDhyWv3m4OHqtvixxl6T2G96tSOJmoPON1Z9zwTgwReeL/Ii?=
 =?us-ascii?Q?XL2Un84zvYzAkXHiXno=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:41.2163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a344b13f-0780-4f5a-3437-08de08422ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

Add a query for compute queues.  Userspace can use this to
query the size of the EOP buffers for compute user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a9327472c6514..f368bda40be41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -391,6 +391,24 @@ static int amdgpu_userq_metadata_info_gfx(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_userq_metadata_info_compute(struct amdgpu_device *adev,
+					      struct drm_amdgpu_info *info,
+					      struct drm_amdgpu_info_uq_metadata_compute *meta)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adev->gfx.funcs->get_gfx_shadow_info) {
+		struct amdgpu_gfx_shadow_info shadow = {};
+
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow, true);
+		meta->eop_size = shadow.eop_size;
+		meta->eop_alignment = shadow.eop_alignment;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
 			     struct drm_amdgpu_info_hw_ip *result)
@@ -1359,6 +1377,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 
+			ret = copy_to_user(out, &meta_info,
+						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
+			return 0;
+		case AMDGPU_HW_IP_COMPUTE:
+			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
+			if (ret)
+				return ret;
+
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 			return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index e5252bf597b36..881e8cc986e2b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1638,9 +1638,17 @@ struct drm_amdgpu_info_uq_metadata_gfx {
 	__u32 csa_alignment;
 };
 
+struct drm_amdgpu_info_uq_metadata_compute {
+	/* EOP size for gfx11 */
+	__u32 eop_size;
+	/* EOP base virtual alignment for gfx11 */
+	__u32 eop_alignment;
+};
+
 struct drm_amdgpu_info_uq_metadata {
 	union {
 		struct drm_amdgpu_info_uq_metadata_gfx gfx;
+		struct drm_amdgpu_info_uq_metadata_compute compute;
 	};
 };
 
-- 
2.51.0

