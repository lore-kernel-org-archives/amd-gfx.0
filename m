Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5589D1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0977110E12C;
	Thu,  8 Jan 2026 14:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkSxR3jY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3915D10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0hzc87NTAP4vc3JmwGUW61uIlVFrjmUmtOm9r9tX/XVFHtIHEV7hfBTFys+aEEDvVGratmjBuWSLqiLaHoOKtqHBNLZGw/d3wz2gMReXN3RwWFw8t1hhMLXpYGlMee7doBlJlRPmK6KU4hPxF3IWBHfE85PlJKQrNtMdzkqy1A2rAApRXsHS/f4EnR/Z5RVi4OL9ahM+uKAgSSY/l55OwHweTEg/DudIid6x09qGI2D3AABMmwd9lrF++vANVCNWA9GhT1e+QZPurTlOehTUnvAxGQ43PkVT1MKhEjCssMvdDIc/hRAjAL3Es9vyv13aIhHnS3JnVsdgnej5zFvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSCxRWzown2PVOZqzlSFRR9HHW/c4r1xQqBLYEJ23Wk=;
 b=p5QqeNGfmwz0cbJNL4dRUsPmabGXXCesRjmbODfZtxTApPrpBf0Nu3cJI/7qc0PxMix0vvz3MMx+3XMab8zVaQHgS7n0JSyN1A0kAUkiYIctHMKz/YZf5dkde15YFhIA9vLZbpbWyQEfykIFz10hqE4k9EVf6gkorMMNj0DOZZbmLu2v7Mtyw5seRrSTSf4QbiD71oCvnEpDOvvBFeIiC3GbWl49NzpDhcdHdZIeQlv3bB1FEjePXGDREBgwJcxVdi1gOrEGVwxN5ldga2v/C1jT5D1f5UrtWvkfeZyw5RZb95py4OYCfcTrfKW0vXsU8IKjrD7HzqjgfP+k+3lQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSCxRWzown2PVOZqzlSFRR9HHW/c4r1xQqBLYEJ23Wk=;
 b=pkSxR3jY3CRWN/yBNiDigIoKXCegQATXgcgkRHq+gTWEaloIHysyVTTLtgMEZojJ7Cmas2j9vwMDuDphDQWNzAuf84GD3Thwi350Heu6nd3tQmCTBJV+kfuu/6tvMQvgs+6K9bYua8ZwDFJ4dMMTfpzpofxvmvz+rpRFcF1cfuM=
Received: from BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:48:54 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::2e) by BL0PR02CA0134.outlook.office365.com
 (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:48:50 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/42] drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
Date: Thu, 8 Jan 2026 09:48:02 -0500
Message-ID: <20260108144843.493816-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: a692c312-7fb4-474f-decd-08de4ec50acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTz3l3eCoHdTH9kg/F6PhnuzKehZH5KwQMpqrrxNMzjmaAG0IgcKd4t0izns?=
 =?us-ascii?Q?HKRrVVCINtI4kb4cgICLEUlJmtDaj12Zyh13dOSmFhe/D+yIF5GY+OsTHv4U?=
 =?us-ascii?Q?lQBGnMpV5a0t14mUjYuL+WNFw+TEQc8YjTgQHbN/i6rwsbsaRvPFTSNWOcAp?=
 =?us-ascii?Q?moPsDp+Fcq2SQRshme+jXJWR8jMXBj+odV9tAb6FKl66ZGGnmYEHlMTsC4YS?=
 =?us-ascii?Q?g4FIoy+rhqOCm8avOcH07oeMK5H0CMcnuOzihN4NVUlDRR0XU0VFqY3LAuHH?=
 =?us-ascii?Q?JnQpaBkVPSAn9qZtA2DA3qQa4bKjRNRVsVz/Y8tZ7ZXk9AWfoeJNnKQbG0ev?=
 =?us-ascii?Q?MRO0Pw+3vd2HDSW96iNqssgHDFrUNMRtHhL+GmyLeqGxGDYF8e+Db2TpDS7p?=
 =?us-ascii?Q?hYA46OD4hR/VT0w05cYvb6ZNUsFBwTAU00y08Sx5szilrNFMhan/GP34Qhc3?=
 =?us-ascii?Q?GTUDv/QnJaEdzbPcIWz5mUz9LLprhoXwRGNs+Z1LsNn3jJiTyJ34Pt3HXQej?=
 =?us-ascii?Q?w9KvEJE/Wsyx/8U2ZYtQ6Y8YnnziRMG0bGsEHekMM6pUjfGnHIXH+dqHlLPF?=
 =?us-ascii?Q?40KNcpLEHhgnEnBssG6qGCmjnSYyN1yKbjya6NKWSaodkwzxFboAqTonsIkr?=
 =?us-ascii?Q?iNppOdOD/59jEWXKh/xMqsYkCclbYO1tAcxvNZO4Sg46hW0maOmLOU8PtTWW?=
 =?us-ascii?Q?f2wuWaLpeH6ZFcfspSNVpqhfGNtVrjdekSvaeQ+5wAYC5RahYIdz+zIczUAr?=
 =?us-ascii?Q?ymDLH9VFC7Pu4pNpYYicujqWLCgz/d3HSbOBkbcjqsfpybUgFCg5JMtKV2a0?=
 =?us-ascii?Q?aDDaDaHmJ69k82ubJdH4KX2oaDP0bS+rhjq1ZEEkkPODseUlrHowgyz0EI3I?=
 =?us-ascii?Q?skXlbYMRXJMAbHaX57VGgyT1YbGqIPVlr/MnetdTZ6JNYzwrZ/QH/QPlsxJJ?=
 =?us-ascii?Q?a2xbChRGozxqiIZy2esI0+DoWmslawavhCh4zlGP2Za+RLvUswqdij/qEXQi?=
 =?us-ascii?Q?3G3JlBS48dfJGRdjJLxEGh8aFZBzwN7YfcWkbf9r3YKHF4QUc3YFPMjguXFd?=
 =?us-ascii?Q?ggkKKqMCqT0/VtwrIykyfpB7N4Om2MI62jfcW3HTB5JeiGCvLejOFVFgQdDU?=
 =?us-ascii?Q?zxYL62/hsQ1nqlP1wv5bqQNKMcP7F8DmM/YJeOPK+5NMTc8ZUz3zof+Mz4W4?=
 =?us-ascii?Q?TSrutesD/PG+UEwiV/vJ+NOhJVqaWaXD2JBFPjrh3u61UHnbCHahhyDrZS1m?=
 =?us-ascii?Q?M+pM124cXgiRSJRwPocxOt4fGKkqsFybPWN6jGupecQ735JCNQViOMjEhW8l?=
 =?us-ascii?Q?gqG51ByIJFgOMHKc40BNEw1fyV50BEgWGd0F8pVanjsYRfI0OuNOhQu9DVlu?=
 =?us-ascii?Q?3eDUk/lUG30249npddBmSsc9lkRhqQpAjDx1Gy+pYLF7tS6a/wHBeSb2dPs2?=
 =?us-ascii?Q?q52H2lVaeeEYUenYrkN4waz33EVv+r+NMZ2nnMVvdbmutBhCa27mEUtK5PhW?=
 =?us-ascii?Q?2vwKopIzSPH5e7TbbDPCK7R4h/NCdB+gYVIvB565sgNqhyDIpveLVa1vvbiN?=
 =?us-ascii?Q?/6lS3cFsoulpEbx4lEc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:52.9666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a692c312-7fb4-474f-decd-08de4ec50acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
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

The per queue reset flag is only set when sr-iov is
disabled so this check is not necessary as the function
will never be called on sr-iov.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index aae7328973d18..50ed7fb0e941c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1145,9 +1145,6 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	if (amdgpu_sriov_vf(ring->adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-- 
2.52.0

