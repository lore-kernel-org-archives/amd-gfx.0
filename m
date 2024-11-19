Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D92D591D3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB2910E5D6;
	Tue, 19 Nov 2024 06:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJnrUclW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDCC10E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmh+X+YHeV1Q4uM5HsrySZMf0QFAM5eAuybACkExEYbAqkpCykiv4AyCeVUJ7jJHSBPtEodSJ+dViWJVOuqebXYZdbBqEyLHy/RZ9Qwfj0aH1Ke7Su1DFBLscAR1Jug6T2iHTddzYglmls9qLAgJIS4hfhu/YP3AXgPp+0LsCyzZ7G/hs/GnKt9W8mLqVUubOPPaHatewpeZRajRVIFo6UnXk6HzZ8XlkOQSO+SuuzCPvWcKn1kaVPXCqI1wWv9DElku6E8NyEEV05y/llVnDxcPqfgRIQ7o9FfoJIio6o/B1s8IE8xlf19eV1UQZg7TOlJl/cd327MPPbTo/wWykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTgi41NpX20/RJnbjUr+yNLminujqcsH3l1hjyY1c5U=;
 b=KFAsDs6NSaMky7xkCsOa4efbVadCnj7n9SJaTgAUpvQYRgZeVsbnYRs9ZHaKB4+NHGOFrX207EwLsiLsZK1VOxa6wMFf4ilwp2/BqusytJpJGBTnQTXOG+GoXi049lUcmTDFuEiEODy1DiAVZXqAE1Qwphvbl614dwmaHpHyYogyJnyE+7NmXdlFdXYndIPizbQ/cEHJP0MYagzCAB4hk7w//std43yBBApTf/JXsnc0YFHuv40J/NnBH+lUYo2PEKCDjrpuXX8ncSAC+/EjGtwgtSoRl5SaFMtalUpAGk0eQlCZfpOxBmp1hyoYoUONL63IIReZTM57por6XJ2ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTgi41NpX20/RJnbjUr+yNLminujqcsH3l1hjyY1c5U=;
 b=QJnrUclWzMI1czOAhD4/FiCT/4EzHrqqWYBLZhCeFsosh5dxMKXhN0Z92n3zQO0Ri7Vrs+NHI3e1mHs/dJjpes/Bg2x6bnCcFsq1vIxv7rZac9sEQ6bUtIUg8qeIwpv6Wqjh6k745dHP0EPgXqYGUFMoJO18dh0doGcnYwk9dNo=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Tue, 19 Nov
 2024 06:36:47 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::ac) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:47 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:45 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 19/21] drm/amdgpu: parse legacy RAS bad page mixed with new
 data in various NPS modes
Date: Tue, 19 Nov 2024 14:36:02 +0800
Message-ID: <20241119063604.81461-19-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3f5787-3a4a-4c57-6c49-08dd08648ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QNsb7R/cmFuLZt+lncG85B4VotpojsCOvmOBcTsDsdTglI0VJXJl086XX8Xk?=
 =?us-ascii?Q?NEZX6mTQLyF0g0i7vlC3f0+rbZMVrxJsIppOiHfLP3hkDOtCN2yoYx6SZrL3?=
 =?us-ascii?Q?KVEp/oJg4kYgFQbVyaxsB4hF00NIzlz/HGbuCrTJW2zOWgB3RSlx9p9wLkRv?=
 =?us-ascii?Q?NYu1K3XYXnjJjT45GN0+7ZmkMg3ZK2c/l/zLX7N9iPI3/PFKYC7namIoEOmV?=
 =?us-ascii?Q?EYAC0vrm5hixO893l1RHE4GflasxuTQKlFGosanfgqPlzPhpTLCna1OnaOBG?=
 =?us-ascii?Q?AsgWDN2HaY7LWLU7eexfeLaLy7fI//OSFyYkw1W08Eg5xGNotEfGtluTIgrv?=
 =?us-ascii?Q?HR24ozw+ueeAR8Dwxna6YHHryKHqAzTOaqv7ZjKx7cIGpdCx5ztZf2LOwiq5?=
 =?us-ascii?Q?XOocCskqialsVtllk698bhdOUF8vLH2RPAVA1554F+6eijxh0v8QbTkQc5Jx?=
 =?us-ascii?Q?DMjGj07n7quvoAN3Qi06r3CdT5glqfI1f0ZdSVbvDy8HGTphcGb4Vcy7cC56?=
 =?us-ascii?Q?1ldJWwgAVgD/KmfvKythd4JBu8C0pB0AsU9nVLIOUb4LZiu5d1qzaQOpqixS?=
 =?us-ascii?Q?zZyPBY09ujRL9vfZLJxYZ357bkCokFMR7oWprS06/wEi0Rj+nTBbQ/crbFtZ?=
 =?us-ascii?Q?BJQo3IMR5VidM+AAKqQ/yc+fFUxKme8dkLk67W4u/O15yysEB1SU9pxm0MeO?=
 =?us-ascii?Q?j7T4IERjvv8/Sb1sgkfHQgfq7vRFxjY4Iu/chH/2ka62JpGJf4YMPmggoiAF?=
 =?us-ascii?Q?+75KHsnIf/J6rLNT6HUCIY6Cj35r9CeqcvN7BhJVkHihEREmKk9L4UWukD5V?=
 =?us-ascii?Q?v9Lz5/NLShUSEtpEl/L/Q0G+TvbAFx4zf6wn0FtoZHq7lKPHPD84J9tUGj/+?=
 =?us-ascii?Q?4dRFKmBQtkPvfFYErmrRxjDbtqsUzRHIpuFzGYdKl/E8wb04VFQB5VJLi1F6?=
 =?us-ascii?Q?b0lWK7/yG/44lKFboLLMoEnwuFZAjcqpDfLrmV/vGcee9oW5cUHwgu+Zl5+3?=
 =?us-ascii?Q?dEdrPgK9JubyYQNr2NzrY0xyodpamNDT01ZGV5s7useMR3riRIstfDDwbr8x?=
 =?us-ascii?Q?GMIfAc4J4KW5nYi1m/R8PKA9VHx/eUVFW9vt+tPt0tRBNJ5M6TyRZTM4nJPy?=
 =?us-ascii?Q?HrMLOmxB/GVlP4imCcTiisAitS377L3kKUdFMeo3daIevkciZok82gHzyx9o?=
 =?us-ascii?Q?Zf8wiq7zYJeX52rNOc6zB4DcWpWv3PL3OtjjszV697WZFK9eKQN/xo1ie93e?=
 =?us-ascii?Q?7NU/hZN2OOhXl3r7Inwc4Sf59OF2kDXmx1405rAxaqgTUULeU5rovHs9U33v?=
 =?us-ascii?Q?0jAeT8FMmd0w5c44fMACAGFTBAj25Pb2Zato+T8wsQjwzboc/eJdwaApeadx?=
 =?us-ascii?Q?oy/Ir60zSzcKyjmcREsz5kVfY9cM8slnVCqK3x5ljbVHzOow6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:47.0981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3f5787-3a4a-4c57-6c49-08dd08648ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

All legacy RAS bad pages are generated in NPS1 mode, but new bad page can be
generated in any NPS mode, so we can't use retired_page stored on eeprom
directly in non-nps1 mode even for legacy data. We need to take different
actions for different data, new data can be identified from old data by
UMC_CHANNEL_IDX_V2 flag.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 45 +++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index be56938932d1..76cd095f96b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2757,12 +2757,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			is_mca_add = false;
 	}
 
-	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data)
-		goto out;
-
-	if (is_mca_add) {
+	if (from_rom) {
 		err_data.err_addr =
 			kcalloc(adev->umc.retire_unit,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
@@ -2773,11 +2768,17 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}
 
+		err_rec = err_data.err_addr;
 		loop_cnt = adev->umc.retire_unit;
 		if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 			nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	}
 
+	mutex_lock(&con->recovery_lock);
+	data = con->eh_data;
+	if (!data)
+		goto free;
+
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
 			if (!find_pages_per_pa) {
@@ -2799,10 +2800,34 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 					goto free;
 			}
-
-			err_rec = err_data.err_addr;
 		} else {
-			err_rec = &bps[i];
+			if (from_rom && !find_pages_per_pa) {
+				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
+					/* bad page in any NPS mode in eeprom */
+					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
+						goto free;
+				} else {
+					/* legacy bad page in eeprom, generated only in NPS1 mode */
+					if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+						/* old RAS TA or ASICs which don't support to convert addrss
+						 * via mca address
+						 */
+						if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
+							find_pages_per_pa = true;
+							err_rec = &bps[i];
+							loop_cnt = 1;
+						} else {
+							/* non-nps1 mode, old RAS TA can't support it */
+							goto free;
+						}
+					}
+				}
+
+				if (!find_pages_per_pa)
+					i += (adev->umc.retire_unit - 1);
+			} else {
+				err_rec = &bps[i];
+			}
 		}
 
 		for (j = 0; j < loop_cnt; j++) {
@@ -2826,7 +2851,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	}
 
 free:
-	if (is_mca_add)
+	if (from_rom)
 		kfree(err_data.err_addr);
 out:
 	mutex_unlock(&con->recovery_lock);
-- 
2.34.1

