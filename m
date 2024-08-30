Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C064CA100C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 18:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9B910EAD8;
	Fri, 30 Aug 2024 18:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g9N5W/cx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738C810EAD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 18:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4MBkrL2vhdi+npNEtY2oouVS0IlONpIshnNpd/LqKdQI/WRQanBs8hTsq2GPs1iE3EB1KwbtG8aitcziwd9a7IiilhNDBSyVmkisKkMEW/VnLbqt+fotXXFj/iXaHs1Vk7FoiAlVkaBWQn9p/8MHCY6XGa3chgPna4nvwtRnaV98n5+pmk5xn4bSlzXhiiPg3mJaLscMepWLHIxiMGhuSIICEDE1yScHJMjPZtbMQA/sY5TbcFQ/Be9HKLd4HSo/tJg2OvtlNzZXwvIqdYEFWoaCF6sl4CGiSZo/O9lTFEqKUaCl2J9TZvHD0MAld2A12yia3yqeJx6AJs1aYUWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq2k0PGopZUK9JVekTkwdmi0bzW2WwIkQcDztkbXNdY=;
 b=Zr2qbMU0JjJdMkGAUv9DY2b2hCOVcET+dXb8Saiz2C/y6NnLZYHIHvLPis4EGYLXoIP0cup5Id+sYJlZ2PXpIlOILMMEYs4sU8loaWFGYqXSPtdB41eCrihXvXf0ywJgjJAT7tWx+ZxOK+5xIzVs2VCz8xb5vqzFV00C8KVZgDtHRu0E0WV1Ms/7Ox/q6aXZVbM6zvl7qORg+/66f2QX0VxdwE4p1cdegJCyQG5jYgUEhuFa9Cj7gguwB/+XWUIE5e/29FT842GFTVaEFqSlEFxs//nWLmZbJMhmrmFEnvsWVGEPt1xFZWV3PgWkXpdm8NVFFsV4qejaZhBtfD0S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq2k0PGopZUK9JVekTkwdmi0bzW2WwIkQcDztkbXNdY=;
 b=g9N5W/cxSYp1ShLEL/TwOofCE3jXEDAvAbgLdRYkbuabCbBl47k5D7C5CiTOZE4KPEhS3q1cdNxT4FKOJhMyTARxNe9/cSRYEnpzMCZ0KY4RcU2LVX5gtuQlhgzJkJya3Riz8tW8b/SQOTNE63hDvuz9QTV6dP4ULyIGhvrRgcs=
Received: from BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:44:06 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::d5) by BY3PR10CA0014.outlook.office365.com
 (2603:10b6:a03:255::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Fri, 30 Aug 2024 18:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 18:44:05 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:43:58 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Add wait IOCTL timeline syncobj support
Date: Sat, 31 Aug 2024 00:13:18 +0530
Message-ID: <20240830184322.1238767-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 360b13ea-3db6-413b-7200-08dcc923b9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dJknh10SUzSFfd1SjJkIILvOaQgoGpe/pa2/mZSXkJVeaiDIgTlwFufolb2S?=
 =?us-ascii?Q?FxenwmE4zhf4T4PEJ5pw7xS9ZMx4ITRKWVMrf2gqMlacU6yvv4Ymiy6K3RYc?=
 =?us-ascii?Q?b42DAqIRme/wRVoBjl6zI/MJs47rpXoQyLP4UCIo5F47psCJiCHfpElCbFbs?=
 =?us-ascii?Q?2qMRfqNSC84HqXv41oZXC6E9EDXBO6XCIIlveOQfkiu0LXC22UWXFaNnHvMo?=
 =?us-ascii?Q?ZRQnjOwOdh6ecSziZo34NkaBXWgs5AzL0PZYnnVk01/OrriO3K+W2edpXJLG?=
 =?us-ascii?Q?IB3ZQjILv4+6CaF76ZdJz7hRGWsU5KGGulNIfbinNm6wTKZKb2NG8wPbLc0J?=
 =?us-ascii?Q?NMCP2ic/oFPa8NV8RgjdquUPvWsRRh+1y/D6nfuwcjUQOi8y2dAZ1Jn+MO09?=
 =?us-ascii?Q?s6w9eJiKJgCaqp+G2IzFLrh4DQHws7h6n20uX0DWe79/XdSYzGZkmALfKd0c?=
 =?us-ascii?Q?V9mqkcR7hL20AXBCR5XqSB0Dudp3+6r1YXxSeo7n5iMlOdVvtkz5X+Dji4DN?=
 =?us-ascii?Q?yWacV/7WiApmRzK66JsH+LDIIB47HjSpUITTRGL2OV1DtV2n7l7faA/1uA8m?=
 =?us-ascii?Q?VeZN3Ns0kHyjRysp8aHyM4ldysJ7J8zI6t81ScYtgZJkB71yqmGnhFPx/usL?=
 =?us-ascii?Q?YABEBISgx7EpGNLIegTx+5DbLKvFwOWTBcLR9WD3xz7v3zpvjzPsuXPl3LAZ?=
 =?us-ascii?Q?kuQ6dxIPe4ZnsWI1vz8JbR5ajYhUbcg+Wg3okUQuboWwBE/zayLgBof9mqU8?=
 =?us-ascii?Q?7aRIXmFd5ZqbDNfmjhojd2L07Zdhq9s9manz3CeNIrSn0JJmjAgjRgGh8MvH?=
 =?us-ascii?Q?tpbbi8/vmbA4Ysu6DzUKQBPjpIh+Q5tcJ3Kot3IJT36z+zhNv9qKP/XFQPE8?=
 =?us-ascii?Q?Ja8dIIGQq42rTb50PtR7kc6fSowFs1L9x5qg+mhwn5C7MNE+oMjW7qF/KVYQ?=
 =?us-ascii?Q?OvXY/ByhPXNYRpgV/IDfc5Xc5QrebkBvIs3qAFFjH9AsRPGjL7eCItJ14nzL?=
 =?us-ascii?Q?BJkjXuHUwCFPnVMFKBEQZHchItgVnKmBqCDiO/eh0Y5rwEhBNZYa/9WPrp72?=
 =?us-ascii?Q?JtXDQt+Fui8F4mRisSVdjIO9JTFQAuzn7RUrTbXG/RF3M0tpl+Alcp2OUCgo?=
 =?us-ascii?Q?J0e3NEnqJx4931A1d8reofMRACiSEWKtofJdxZ+ls7VCaBOCLJSkmEd7uG3L?=
 =?us-ascii?Q?/3/e1juAFbf+CzEpPMuuyiyEnkZs4swHZvypyYoYAY360Ntj1SPrRlnfPigH?=
 =?us-ascii?Q?jFThj2VImz7b5njxQfwqEeI8wItBReNZAa6baylC4kKM7XGPsxj3GXLUkOiS?=
 =?us-ascii?Q?7RKFojKwlIXoN3I0iqaR2f6qKtZQX0yraAeKUhYGieIgyL0Bh+9kU+p/A2PI?=
 =?us-ascii?Q?eoSYNK35iKipmA3TMAm+scPkqdsCazqvHmqfDFDDmW6rDi6lZUe7yMPJny5t?=
 =?us-ascii?Q?WJezg6LNvUIo8i5d6ChX5G6SqAp/8nJv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:44:05.1194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b13ea-3db6-413b-7200-08dcc923b9b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

Add user fence wait IOCTL timeline syncobj support.

v2:(Christian)
  - handle dma_fence_wait() return value.
  - shorten the variable name syncobj_timeline_points a bit.
  - move num_points up to avoid padding issues.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 82 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 16 +++-
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index ea806cc2c1b0..d2e1d0d0f29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -468,11 +468,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
+	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
+	u32 num_syncobj, num_bo_handles, num_points;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
-	u32 *syncobj_handles, *bo_handles;
 	struct dma_fence **fences = NULL;
-	u32 num_syncobj, num_bo_handles;
 	struct drm_gem_object **gobj;
 	struct drm_exec exec;
 	int r, i, entry, cnt;
@@ -492,11 +492,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_bo_handles;
 	}
 
+	num_points = wait_info->num_points;
+	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
+				       sizeof(u32) * num_points);
+	if (IS_ERR(timeline_handles)) {
+		r = PTR_ERR(timeline_handles);
+		goto free_syncobj_handles;
+	}
+
+	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
+				      sizeof(u32) * num_points);
+	if (IS_ERR(timeline_points)) {
+		r = PTR_ERR(timeline_points);
+		goto free_timeline_handles;
+	}
+
 	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
-		goto free_syncobj_handles;
+		goto free_timeline_points;
 	}
 
 	for (entry = 0; entry < num_bo_handles; entry++) {
@@ -518,17 +533,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!wait_info->num_fences) {
+		if (num_points) {
+			struct dma_fence *fence;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r || !fence)
+					continue;
+
+				dma_fence_put(fence);
+				num_fences++;
+			}
+		}
+
 		/* Count syncobj's fence */
 		for (i = 0; i < num_syncobj; i++) {
 			struct dma_fence *fence;
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0, 0, &fence);
-			dma_fence_put(fence);
-
+						   0,
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
 			if (r || !fence)
 				continue;
 
+			dma_fence_put(fence);
 			num_fences++;
 		}
 
@@ -583,12 +615,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			}
 		}
 
+		if (num_points) {
+			struct dma_fence *fence;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r || !fence)
+					continue;
+
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+			}
+		}
+
 		/* Retrieve syncobj's fence */
 		for (i = 0; i < num_syncobj; i++) {
 			struct dma_fence *fence;
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0, 0, &fence);
+						   0,
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
 			if (r || !fence)
 				continue;
 
@@ -611,9 +665,15 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				 * Just waiting on other driver fences should
 				 * be good for now
 				 */
-				dma_fence_wait(fences[i], false);
-				dma_fence_put(fences[i]);
+				r = dma_fence_wait_timeout(fences[i],
+							   true,
+							   msecs_to_jiffies(1000));
+				if (r <= 0) {
+					dma_fence_put(fences[i]);
+					goto put_gobj;
+				}
 
+				dma_fence_put(fences[i]);
 				continue;
 			}
 
@@ -673,6 +733,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	while (entry-- > 0)
 		drm_gem_object_put(gobj[entry]);
 	kfree(gobj);
+free_timeline_points:
+	kfree(timeline_points);
+free_timeline_handles:
+	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
 free_bo_handles:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index af42798e901d..3b24e0cb1b51 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -521,12 +521,26 @@ struct drm_amdgpu_userq_wait {
 	 * matching fence wait info pair in @userq_fence_info.
 	 */
 	__u32	bo_wait_flags;
-	__u32	pad;
+	/**
+	 * @num_points: A count that represents the number of timeline syncobj handles in
+	 * syncobj_handles_array.
+	 */
+	__u32	num_points;
 	/**
 	 * @syncobj_handles_array: An array of syncobj handles defined to get the
 	 * fence wait information of every syncobj handles in the array.
 	 */
 	__u64	syncobj_handles_array;
+	/**
+	 * @syncobj_timeline_handles: An array of timeline syncobj handles defined to get the
+	 * fence wait information of every timeline syncobj handles in the array.
+	 */
+	__u64   syncobj_timeline_handles;
+	/**
+	 * @syncobj_timeline_points: An array of timeline syncobj points defined to get the
+	 * fence wait points of every timeline syncobj handles in the syncobj_handles_array.
+	 */
+	__u64	syncobj_timeline_points;
 	/**
 	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
 	 * wait information of every BO handles in the array.
-- 
2.34.1

