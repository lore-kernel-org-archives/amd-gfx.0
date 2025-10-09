Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4163ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA9C10E907;
	Thu,  9 Oct 2025 03:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WutmDXO4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EB710E907
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJqJU/nqyb+l69j8U6xlyILeZ7jkgnrgtfAke44Gn7undo63EEShXNRtlSgf36Vex+51hx1Pgjbsf0iErBAubgoQR+TPh4Og73dBrBZhhC6Wb44lyBENnpxRqe+FE/rRlvqMLlSLXSr2kdVHSlmjMXU6IoN4Bv6J6nhqiTYf4Kyq4pWruo6SgAHKn6Cz/5KD603gVmuaR46cZUxUS6JqYLgzN01K1ZmeVApQj07cJu6L7Yto3sgsWYylgwBauDQcBeMrWAVZ5vr1/8IDs2rMS2+44Jynih7qqrGaZCA69tyJE5Ox5wncwM1PzG4AWceOx1JjYskxsm85V146Bz4Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62tlbrYw4ElfmrOHa+n3Ut7JSXEenVpUFPN+t4P0n7E=;
 b=YUe1L4HDHnwyDy7Rw/PiYqQglSbJjlBwkncSe8ZUvfsKIQMHQdDxwe5RhB7P+sz5Lsuzna8S106AyLNn5q4LHmUp0h09fHIxzCZ3GMNzdVAPWJfEIIbCnQsYtseufLtjU+4NVSbjwKH+9jYZ72GWb7wfBrWbVpUwOmBDiqbBWAbBtCfBJmFmXcx9gpiZQtkMlqkkKkMfGUd/9Iif+/+nAwApjNw23rIewM3hjEyt4Mg1x3CshKWsIJda4yJNf6YWMki5HhkOEf5IFL3ffp5Tq9lo05Eno6/drdlwWaPJlLc4vtq8+oMU6h5uTYq6ZZsk9XgVcqgfsTnMvhGRfYKysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62tlbrYw4ElfmrOHa+n3Ut7JSXEenVpUFPN+t4P0n7E=;
 b=WutmDXO49BVuFexxYYULUA2QDK1rjhiOS5X3u9tbm+4eg2i0bU5cK1q2mFTVTk92/SvkdSiSvCsiPq028HmetJH9rffMFWMKR1NKnBjmgF9KUvrRvPifwzCVB7D/UQfL5mx/nybn7jvPvcPLUGYy1c4skneycdvmPuXGYPD0PSk=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:30:59 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::69) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 03:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:30:59 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:30:58 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critical
 region in SRIOV
Date: Wed, 8 Oct 2025 22:30:47 -0500
Message-ID: <20251009033047.25004-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f247c7e8-35e5-46d0-1e34-08de06e4441a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFZOdo2Lb6YcRMjfJEKE5uzyf0or8e6wBxKiK17FqCYUp5M4s/V644fIfj5K?=
 =?us-ascii?Q?SOxSFDuv2+zAH+zL394SoCV8T8QWMrJSqMMJk6xZbdtyBRoAD/K7HsZAFcfR?=
 =?us-ascii?Q?nMu4b+uvVY52s8gpiiG8e0wFNF9lfQ3Fk962fZjT6TkwEcpmH6csYVp6xYJ8?=
 =?us-ascii?Q?CamK9H2FWhu9WGTA4AqKl8kpsJJUWZLq+n3EhiUsheI3snfEc0UHviFDOCHM?=
 =?us-ascii?Q?ZBSP4j6G1tqHjx29LqaBxjzG/o2NroOTVp3szUeWcbckLVL7cXCPiIQtQ4Aq?=
 =?us-ascii?Q?9/9W4MEkoqSTZF6AcjIaDzETrRKM9GEGfRcOAfzwMoMA+upk3+JNFglOaSDG?=
 =?us-ascii?Q?4jReZRiB4CTQcN1zaPscwk3IhAi/59z3vTyPEr4uumY8cVs4C5Q1N2hG7ZvQ?=
 =?us-ascii?Q?8zTt4ZRW90YOI55aDGvcsYAIAcISSKxXbx0LXP49tBYnJkKITYWCawfBAY7K?=
 =?us-ascii?Q?3t+y3pKWBcUPIRhXCI1OTH8KvINv6wyCQGgfqtdthxSA3xQrkaPrYqH2Ca/1?=
 =?us-ascii?Q?Y6FBCOkon8A9c9ssd+zfq/hpiATPw4/D1olfZ1RJ8VpNMU7RSE7svYcmMRPa?=
 =?us-ascii?Q?YXWZIdNbFK27quFwVLBiF/szeypaWXAlRm6CXJlqqNCIWwvimq/u81v+cjqK?=
 =?us-ascii?Q?5/RyyZumDP1n0kPo+msjIEV/D+7KOTnO4hQN5d7B9ILXEFU4xJ/iN/quiH73?=
 =?us-ascii?Q?0o5WgCZ9Ae+PIUXYUZ84ZDMfYALxfs5nAa5vF3ACSEK9rGh0aNGs9OZSJ9Fo?=
 =?us-ascii?Q?c9Yr2XkmVHnoiL8usYyZPQBnko5/NuC+uckPN7zDeH9vrQmh8txuk6aGRBFs?=
 =?us-ascii?Q?+XTsMmWups2dp/1PS80N0fBNKg53wTiifEDGJRx5fpu6cpBOdm+cTdl22r4H?=
 =?us-ascii?Q?9HrAcE/37Sgz7TCjN8nuEaJ4xYpCOS8oUgWXQs4v/8yIIjjgaXSHBitMqv3+?=
 =?us-ascii?Q?4FHxG/r2RzJSaoI54SP/O175piU8vbUnGw8vsJYOjqRrTpuFbe8S5ou/fRv9?=
 =?us-ascii?Q?dWTJFiywMYOkfoXC8LFhF1DsEpATTN+SPokyrlxT01n7QvA4OwanlEnqHyvb?=
 =?us-ascii?Q?g4x6rqbIr27ACVI1B/PhJ/8YZKgBT0p+qqrZ2aU8UdVMr/v62Um5DxyiEeO6?=
 =?us-ascii?Q?rL9goghnPxTpGggQEBryLzxSDrNcGr5e9b/+RRIKuAkWFXnpqqIt5DsneMLo?=
 =?us-ascii?Q?CRFvy1AG0rOQGBXE6XA2DEVhMqd8S4NGiNHsvwMqN68ATluKovA6Qjn8/kT2?=
 =?us-ascii?Q?vBksJ99ekmj5VaogzZSZl1qBh/x1381IRCqaSfuk+zw5nnzaZjtUkZu732Yh?=
 =?us-ascii?Q?4757Us4Z+CVTGo4ahfJJl2qJOoNqBA8Kg0dRaUBY304Ax33H1BbzcPDnCHfv?=
 =?us-ascii?Q?r3TZ0CFZfT9ebQrHsNvt7NgJA+izt14tlQi8OdnWtimbt1+zq3JhXzdUpLU7?=
 =?us-ascii?Q?iPLbvih3e+8t6b/8CgncHHgALlHc/5y/RNPZw2PES4i42uPiSMw6AxzPzO3E?=
 =?us-ascii?Q?6Xpx4k7r/KYLK1W100lsaa8Or4hSCJS9trL10heDc/Di+Xm+7frssKVNbnhO?=
 =?us-ascii?Q?9IlX/3gyBSHELFtQ6TY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:30:59.7187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f247c7e8-35e5-46d0-1e34-08de06e4441a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

- During guest driver init, asa VFs receive PF msg to
	init dynamic critical region(v2), VFs reuse fw_vram_usage_*
	 from ttm to store critical region tables in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 33 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++++++
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 96bd0185f936..4ba34ba74671 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1943,23 +1943,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_drv_reserve_vram_init(adev);
-	if (r)
-		return r;
-
-	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
-	 */
-	if (adev->mman.discovery_bin) {
-		r = amdgpu_ttm_reserve_tmr(adev);
+	/* VFs using dynamic critical regions(v2) won't need to reserve for below memory */
+	if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)) {
+		/*
+		 *The reserved vram for driver must be pinned to the specified
+		 *place on the VRAM, so reserve it early.
+		 */
+		r = amdgpu_ttm_drv_reserve_vram_init(adev);
 		if (r)
 			return r;
+
+		/*
+		 * only NAVI10 and onwards ASIC support for IP discovery.
+		 * If IP discovery enabled, a block of memory should be
+		 * reserved for IP discovey.
+		 */
+		if (adev->mman.discovery_bin) {
+			r = amdgpu_ttm_reserve_tmr(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	/* allocate memory as required for VGA
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 46c19e96086a..e9dbab53cb06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -931,6 +931,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
 			init_data_hdr->bad_page_size_in_kb;
 
+		/* reserved memory starts from crit region base offset with the size of 5MB */
+		adev->mman.fw_vram_usage_start_offset = adev->virt.crit_region_base_offset;
+		adev->mman.fw_vram_usage_size = adev->virt.crit_region_size_in_kb << 10;
+		DRM_INFO("critical region v%d requested to reserve memory start at %08x with %d KB.\n",
+			  init_data_hdr->version,
+			  adev->mman.fw_vram_usage_start_offset,
+			  adev->mman.fw_vram_usage_size >> 10);
+
 		adev->virt.init_data_done = true;
 		break;
 	default:
-- 
2.34.1

