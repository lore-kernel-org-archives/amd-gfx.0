Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AAFD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9084E10E4C4;
	Mon,  1 Dec 2025 23:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSPlyTXn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366F010E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGISVGt19IXQBEBuA70LftaNXWYAy4sQ6J8CQLwN6k5ui0+wXG/DzGdJuWc4kLfHsIc3apnRkogXLcCxJqrEhpOk+3uWPPpyrdxHhwgaJV/Kz+SLnNfcB5dQUuf13AuKYZPa6UAn7Wd/iplCuIBe5UAdW2tx4qc3opcf80gc8oRfdLhngi9BjHZ09coyJqsF8xGDn86MnqpYOBS3t0JTy3vIHVFWFvwa1vq7bsvTgbij0Ap8HFYK5NNjeRehphulxmkrobrQm9DrIexyc9uHianzg1WiO6OJyZwY+oVRRQ7yj8K9jvf0QWPX9/4scKArxsGVUcm/F3dupPZXscH0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgJW0ER7Kc5Ecbf4a4q14KHoM7UX6jimpKdvE3JN8q8=;
 b=uaPzjUWjhZy2qi89KMdr1A1M6E9v4T0sau18Tx2W8YkPDRq/haPY1lb4ENR/jxe4swoRZlf7mUDk/bQrjKH2Aj608AQ4VNto5mK6P60kPBrk5WyMZ4IOFpGN4WrhmNxjwNgnGONJDu8S2//9NdgwIniM7TwBuIZMpbR9GnRCq6XYhftH54Ekry87iU1HoB0yOIP91a4O18P1ZyC6z2DHMy8YMptGJut8Cg3blhhqeMt6EsuZVS+tdYpi2ZITPKopadQkqSeSukm6TqfQoViFw7NKw8UGpQskJeAPwBwisidBw5IlG0lXWroy6bXbheFjsBOnd6/EWiaC/n1P0RcIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgJW0ER7Kc5Ecbf4a4q14KHoM7UX6jimpKdvE3JN8q8=;
 b=LSPlyTXnwzxdlWTUqhvNbxs7tnXuCBlg3I46/AW21cKkeJvb28EBI5VqES1iEzCiL0XW7iazYM3q5LYz1xZ9g0CQwRZ9VQGLxgMrsD99em1gjcIG1n6/vwjazr/FjBxTAw/jg89hqeedLnE2VJkbFjv5Idxb//JlKcfSP3OBlyw=
Received: from SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::9)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::13) by SA1P222CA0044.outlook.office365.com
 (2603:10b6:806:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:25 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update sh mem base offsets for gfx 12.1
Date: Mon, 1 Dec 2025 18:15:01 -0500
Message-ID: <20251201231509.791954-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dee558-225f-4aca-1913-08de312f82a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qLdqpJy3i7uaWzEpB4ZhRGgR6fsNDzUJs1CW+dLalX1dhJ9yt0t/6rWVuot?=
 =?us-ascii?Q?1CV22Xam3N9PW5vDLvYJXi/TQJlCthCJ3wUwf06zaP+OrJTNoriTGHwAP16F?=
 =?us-ascii?Q?lwjWrKutOpA8RfhULC021N3cv99c/AqX/wW/lSc5q3XzGaSEv9rGXaKJLIZY?=
 =?us-ascii?Q?myOqP4/5EZHvt+7+KFSGKNX5etavYWxwMtQ2F1GtO/TCFWY2x8mlZVhf/5eb?=
 =?us-ascii?Q?C8OksK7lnMu9iASOnaC5lPXKSuVWOvexeV2ef457wmVSbpsgnFO4EbihnirM?=
 =?us-ascii?Q?UG9S1knJCLREozt01lvE5qXrGMox+O7eQZr0rduBwWruK+0vrfQWX3x+IluY?=
 =?us-ascii?Q?ivSK6qlj3Yi9EZ8Qdll429kPP1ogxkrdtkWzCWAwKzJ+rytJbZ4Gj+sFlC0e?=
 =?us-ascii?Q?6fNbXEBzn1vskQFFJbcCwBSqsFK53jtOSIbU/ALgxn9JgcwXgwqjVAo8I5Ll?=
 =?us-ascii?Q?qvaf/USv7UhDwhNyeRDasrqMohKkuC/U98hgfC5aXcSUgMU6bYcfH/NI/hgj?=
 =?us-ascii?Q?23k7VjeEe+DDIQdM6GqbfLyEExJayWN3hyxKq/qouxxWSiBb2pMq4Z1pvA7n?=
 =?us-ascii?Q?Uy3GboXWkZLidQescCEJUUAS+MhPkhCxOQ+JPqCH7QI7eJ0QgfoHRtXSuwhC?=
 =?us-ascii?Q?Riu2xKQN2+obJ+TfrHgCHkVOT2/Fc1weZc8eP5CHFAQh9Fd4yHDVlWQd0G7e?=
 =?us-ascii?Q?b6JFIVYIqkaP4z+2iZQdgrv3xdEf77ILH2XgHsueONHipLQESsogNmwrnOXk?=
 =?us-ascii?Q?TfJyq4q9luz0Tlfjmyw45RnQ2IUBfa6FqePwobqqhexT+DvxpELUiHIFyLU5?=
 =?us-ascii?Q?eUWwZ12IhS1hgddjPCihqmI6EfN2fC8UZgSubV9WrSwCuXx1jS53NhXONpd5?=
 =?us-ascii?Q?856t0qpasLC7vEl9DlnMfir5msk0i7HrmYnjoOOzPit+x9lGNuP1zhbLFPgJ?=
 =?us-ascii?Q?Ztlx1n9ytFNWumrgOq+QOAiipiYjAft4doZKA6bMYIIlsExy8X66Tqaaxrsu?=
 =?us-ascii?Q?npQMwUJ5WEk64rY+3kyfxpzSxxE8d0o2yCo66pEfjEtTHgOugJH9ViidPENg?=
 =?us-ascii?Q?tc4i7OpnS0csyE9IgtRfw9FBfbIAwLXmmhCV2FJW8fdUbUlHXw2MyjBcHSrp?=
 =?us-ascii?Q?PphUU18nBMUerpk3mBoJzLUvDjfo0qcda4vsJKGLmcgqIjrAOyPqfvPoFwu+?=
 =?us-ascii?Q?eKvHhkOVyPmbWCxnQOvp8kxPDg900UGAvhbT3y8g4+A6N3kCp4YCTw9Uxlq0?=
 =?us-ascii?Q?wcercki5lDj43vR1RWuF5EaTIN4zg3ZV+gW2iMOCTXfYV6yfTxypHdqYheX7?=
 =?us-ascii?Q?PS22siFc6Yxb7y2QVNnd/70qyAuJDtw/KA1fqTj5XG6NRCQ3Uis/TjAIiPFv?=
 =?us-ascii?Q?oTUwwss1lQhuyeQL5Xgblc/NX6SU1jRUzmo1u/UWFojtUknrig8oztCnBN0B?=
 =?us-ascii?Q?HHZT3wOzP5a4XrHhioTA/mRlBX9p942bO60TkMaGCt/kXXXycdA0txDl4HH/?=
 =?us-ascii?Q?oLPcPpGV7L6WEHQUBDn8VbfmoiqepsCt3qMZW6p0wRKOO23ynN04wr18D00C?=
 =?us-ascii?Q?XU8qJlR+dS/LhZGMWDw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:25.7489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dee558-225f-4aca-1913-08de312f82a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
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

From: Alex Sierra <alex.sierra@amd.com>

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 14baf9423c89a..edd5b41a1e395 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1339,8 +1339,8 @@ static void gfx_v12_1_setup_rb(struct amdgpu_device *adev)
 	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
 
-#define LDS_APP_BASE           0x1
-#define SCRATCH_APP_BASE       0x2
+#define LDS_APP_BASE           0x2000
+#define SCRATCH_APP_BASE       0x4
 
 static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 					    int xcc_id)
@@ -1356,7 +1356,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
 	 */
 	sh_mem_bases = (LDS_APP_BASE << SH_MEM_BASES__SHARED_BASE__SHIFT) |
-			SCRATCH_APP_BASE;
+			(SCRATCH_APP_BASE << SH_MEM_BASES__PRIVATE_BASE__SHIFT);
 
 	mutex_lock(&adev->srbm_mutex);
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
@@ -1399,7 +1399,7 @@ static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 			     regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
 		if (i != 0) {
 			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
-				(adev->gmc.private_aperture_start >> 48));
+				(adev->gmc.private_aperture_start >> 58));
 			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
 				(adev->gmc.shared_aperture_start >> 48));
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, tmp);
-- 
2.51.1

