Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF8D3B9AA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECC010E62D;
	Tue,  9 Dec 2025 23:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTv833VH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A7110E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxDSKik1SPx4Uo3fbyexepb5iSWQ10J4tkTvUPvxh/3g1DgyrVPVgw+6Y0O2EWTsyfkrl4H1+32GomXdIlEfHTnP2blvriUABOTm4CPURJ9LFPHScfKCSd/6nQYJt/+DgYssmmsUcuFk4pjqCQKnyx0IAh0ZTXdpY2MI8aR+qac3a4VI08MQZSp7KMGpj9syVF1wYdT3f5PyInpstsb2ofbxZxzELbvxUsgdmG9FqgBFHvTfmO0skWcH5sVJdAvq6AKVVPdniNaO8AgUh6WF2oYJtnb7a145GKpbG6x+i25d1ljE8+h/R4GMGY+XPNbjNYwjussQhzzlXyOcF+QJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBU2K1PpFqnl2cBcX7hSsuxnTfWzVr7lLnP+mwQFj+A=;
 b=uI3NEKO+Tl7xmEeP96wdRxWp9pzei/dAgvahu2OyWzKQDFXj74ZCTtTt3paZul0YEuJSKQTh7b6AOEGw3bUoYl+evY/A8Vvm3Zvw/IR6q8JQXDE44qvAq9nLeEPkRMkX1+4yNJ+ECCOHtONIgOd01A5XX+bDmejr/NhhA5Q5yolotUt8sBajDi8HIYeKVQmo3+f6dmIV1RxtV7QzoSnjV7QUg9jZRY/W1D+SiFgpe2kTh+/KzRNwcXYQzoTajHU44XpblnMc5fpJfl8K8s2CBWWKJSoygnuwpSsaUl+GAKzpLstwA74bmgZkbYhoZWtRwk9b94hRo74c6IGpnacI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBU2K1PpFqnl2cBcX7hSsuxnTfWzVr7lLnP+mwQFj+A=;
 b=xTv833VHYkin4FeMqi974IV+AWuoKK0fpLKGlrrZJ9gRUQ3riglhpgcQ/kGDOsDAIvMOqjVZZiuyXMytdVcbKbuo4wX8fjgScq4eoV6R0dgP8aeCiabKadIZ7JJQT+yX454i1hBL3XMApnAGJQdFMB0c1drmmRboFmvYaLmQTYs=
Received: from CH0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:610:e5::19)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 23:44:05 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::60) by CH0PR03CA0254.outlook.office365.com
 (2603:10b6:610:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 5/6] drm/amdgpu: Add helper to alloc GART entries
Date: Tue, 9 Dec 2025 18:43:27 -0500
Message-ID: <20251209234328.625670-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4887cf10-485d-4834-b2e2-08de377cd70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k9laTx602PV0RXGzJXZ5bSfuTrwm09yk3q2XSUYyHaVC4DrnpbwyVHtfMz+g?=
 =?us-ascii?Q?/X6ZLlCCBWoLCpwxMKuEqpA7e3mhULhn5y7MX4bqBFZrbc4GOCaYj2i0wYeK?=
 =?us-ascii?Q?4xB775pvdCuY+LYFXodRiiHu4QJ/fBusYeXrMWJmMAMnU1l1dU2vHPcrfYMS?=
 =?us-ascii?Q?+OJsIFifUdHStTNPYZ2h83BSrwQskGBcXS/nsAzFkeHJUpQRCC5vLVuS3cWQ?=
 =?us-ascii?Q?t4bHWUP0qy040ATHtsYXsnrQvXW7lhQ1/hDIxOn2YIcpFlugyPT0QKx28kBd?=
 =?us-ascii?Q?Okt/x+q4sKJuNMvTTy63Wzvl/qfPuhUdsRhWB2gncnnIBCW8gvEZCgAnRqSo?=
 =?us-ascii?Q?RDBlek5wT+mDMleXfmyc1R4SLhmHqD0qWQcTKfZr4RAcLH+WpM75g5SSQHNK?=
 =?us-ascii?Q?S8Tl7Sgopgyri1WvQ8yOAxMdwVIC36j/xKNWbosfGrhmNkmmTKt2dpN4QyGi?=
 =?us-ascii?Q?on3xYfKdnFA5kfULAuk+ag4qSPVoL7FbFs2XNM8ayiSq6PtVyNO1HqXWU6Ft?=
 =?us-ascii?Q?pxBnUR+vPTy48vDab1ndUvu/eFpCd9yn/v9zxAVSO28AMMwcSyPaEGvpXtO3?=
 =?us-ascii?Q?IFQ7FOtPoWy7eKRLhYe6nwa2+z9Xi9SQ75lUHRvIXM36+bGtHiacHve1Pg+R?=
 =?us-ascii?Q?yhRykoFpZ/3l6Ujn5QUwJ9sjNwWLeLS3Kg3v11RqOBZbT1OZuWmC7Uz72wZj?=
 =?us-ascii?Q?867w5u6Z2RrKiXnpjpfNoeJRduTlu5JYKVXI7x07LMVEpqqke4FneBdE1iQS?=
 =?us-ascii?Q?UsROEIkixnEiy0bq2+2elPAUrp/0hfHa3NiHva5Acwbb8klKNB8n3Kg7DVE9?=
 =?us-ascii?Q?UtKzc7eq0kRtxe9Q8qvymbOWJxPmC09U/e0NRAyBauoG54KiQ7I7RTJguhuU?=
 =?us-ascii?Q?iQQC14XFpScXQzGGjYNjUOeyNO6JZV7Kj0r9GVF+Zq+anSLGahdcs062Akzh?=
 =?us-ascii?Q?FWrBUaeAZgMDMq8QiJfQKWc9JonensHD0HDjCZGTZoaoMqWDztYiputxFVc/?=
 =?us-ascii?Q?hJh5KLsddstFjVhvTodViikoCJcMQGS0iLg8/95u8N0WL4d5kYmmHcl2iieM?=
 =?us-ascii?Q?yn9p3DmDDAe/c3jOQT5KZ+G95bzPLb/bAFy79R80euZFrzDmqDYFN5hT57QU?=
 =?us-ascii?Q?VSCijqUj6WI9Bc0uf5xVOy7g69gQfEji8uBZXAxtjigMGLiZCz5pw6qbSCFq?=
 =?us-ascii?Q?fmb92CkF399q0qXD79DuPoiZxYSAAJKeE4nDwn6xZYNBeSPN73vu3nGrT++7?=
 =?us-ascii?Q?dvyIPFQys5BZ1CP2QjqnvW1L9kC9MLxiYPb26Y6CRuD8dDNcT3WkTY4diA6r?=
 =?us-ascii?Q?RLATK22VicvK9fWCpORfZltTNGf+aDpKqLkxfN5XuEbUfUXYvr0BHxVhQMFF?=
 =?us-ascii?Q?1k2MOuXCJREBl6TSU00m99TIufrEp/5DttVK0+CtEHyHAhB3u8y2sR5NHefK?=
 =?us-ascii?Q?+jtNy5DcNJ2NcgN5BmGKbQxoMxJozQ5VlipANc5BE8wOZh1H3Wl5V2Rxxyhr?=
 =?us-ascii?Q?2RI8id99ByRF39xDZ0d9LyDKev1eStF6KDPx+JUuMfKoLR55ug+uV+V+4uOt?=
 =?us-ascii?Q?WEPi/Kd8eiKD5592Ugw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:05.5926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887cf10-485d-4834-b2e2-08de377cd70d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

Add helper amdgpu_gtt_mgr_alloc/free_entries, export the configurable drm_mm
allocator parameters to caller.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 27 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  7 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 895c1e4c6747..d21c7187e4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -321,3 +321,30 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
 }
+
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *node,
+				 u64 num_pages, u64 alignment,
+				 unsigned long color,
+				 enum drm_mm_insert_mode mode)
+{
+	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
+	int r;
+
+	spin_lock(&mgr->lock);
+	r = drm_mm_insert_node_in_range(&mgr->mm, node, num_pages,
+					alignment, color, 0,
+					adev->gmc.gart_size >> PAGE_SHIFT,
+					mode);
+	spin_unlock(&mgr->lock);
+	return r;
+}
+
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *mm_node)
+{
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(mm_node))
+		drm_mm_remove_node(mm_node);
+	spin_unlock(&mgr->lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 72488124aa59..28511e66d364 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -141,6 +141,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *node,
+				 u64 num_pages, u64 alignment,
+				 unsigned long color,
+				 enum drm_mm_insert_mode mode);
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *mm_node);
 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
 
 u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
-- 
2.50.1

