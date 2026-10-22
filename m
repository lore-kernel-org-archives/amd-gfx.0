Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC63606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nDUaJNnV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9CF11240B;
	Thu, 22 Oct 2026 08:35:57 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593EB11240B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4wIf8q2BU2NXOY5iGFHp/f4a1zxOGp5LMOOb37hrIGF93XZ+pKBMVDlMu+xs1sE3SkWRKfMUg+/FH3DsAsNNU0wAllaVpEZA8Wl6qdcN6Yotnc5fZB/WkG8HjnpbXAejp2JRnWePg5KIn3XnF95FwxQRPDPSccufCh5ywd8yGpDQHlG2SfEvy2PHQQ1WElmNB7Aq6auGHuAsgFloicHL0bgj758zvvL/AmV+m1aSacfFTg4Zwq9GL8A+9FHcCcORDf4IIW06o8GaP7DMjlB+CSP9oLkjxJ1LPwgCK7HmyTEn64DGcxx06g+mNrlOsFbKHIIwN6yMkIX/fg3w/k07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSuOtHiIyMX0pcxkDCWpdtCajaOYDcbhUsctecTwooc=;
 b=Ran05fb6FK3teGC7eAcuyHiDYJATP+ATg3SH+3BRZUJAyIF7jQDwsy2eQv0AWlg2zg3agS+/c0yBRffMZWLx8oLVE9ucHkSvcJKScrsaByWoz7/36zWgxMTSz97WSGYy31gv9wmntzl/G8BfO2XXkpu2rKe20VU/KoBjaHhvL+1N9HRXFT3TiY0I6xN8wqlhA4ELUdZRdIVY37VmgvAcgSoHMXMWuY35UblPF4rKsh7KvbiK1LEQqjq24bJvw8MU8LIAojOSDaUq+98Hh8MevsHtsWt7vKE+ntfSGhQwwcXk8jEwlhKtbsK8hXi9IEGAHESJ9KhX0CwCqVXfngXErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSuOtHiIyMX0pcxkDCWpdtCajaOYDcbhUsctecTwooc=;
 b=nDUaJNnVlZA/M04AcMgTdE7XpKpwQoQvT9tO1QxS4XIgMwdTNqSJ7kDpg3PyOFLQ2wYV9VEkzz4pv8PMLTV7P2Nlb5LItOa5sEfHADIeHyNKNhR+gQ9curLZS0sjCWhhWdrQ71zf+Nz8QN3PeMjwr/YG/mCehc6A7Wls6Z7BUyU=
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:33:48 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::5e) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:33:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/uvd: don't allocate or lock BOs in the direct
 IB test
Date: Thu, 22 Oct 2026 16:33:26 +0800
Message-ID: <20261022083331.3019779-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 91748f39-709d-4dc6-8da5-08df30173140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261021121427099003|11063799006|56012099006|261021123027099003|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DbRsQgAwF7kX0nbg8Hapk96aYdAEw1seDy0to2aQaHMQSzbwhZS+EfmrbHpO7QogNLDGMgBATDu2yBaiVPmZzqYW0BOIe8i2jpUOrQ4QF6lpnfyof/JaFzK5ak80sUYdaupfrA7kH9G5tRCkq0s4dCqllK0jjLxAqsaFzJVdiXRYlDKke+I1L3Og9f6OYhNxTg9Py+IQC4d+NViQ5CY2W0OW2j02c+keLdMWmgCiOVZHTWzckuzXLA+HnrULlBA9ExkeYBDhGm0E2rPRRjxcVLTnRNvMRT3j0I5dgegFsy8AqnblKiXdLcCV8va5LfH9bc32IENnj3LGuSOeT16VwyS6+u1kScxcW9gm2wqQCefyd4ybTHZdykqCW0HN8Q/N6kyAg7YoFg6sbHyTvqbuFhXBI9MDI5htnfWAB/APTwbPZ6WRXHCGJdqR/cQNsdotuW7FEOqdwYoVqiX8IS3bBx4UDSl0+khXc407yAawI9AV5Jb8hRrmuZoD47xua6V1dmsXnI/eCY80FvddLAQYHezERxPRWakeD2GdylRekPT9FlqN5ECAt6r2zw1Sxt00Y6pgFKjGL0tm7PkxuhTiaA70MDf85A5q51DdKBBUT/0P97kFIFFN7tQoaQmbRPwVnUq5RjcqoWOACxAMUtpSyTy0NAsq5kmFLJwLcrq8w/0lVbFJQfszAzkpn+HBKA0gWK3cdyHbDshSGOtjd3WgjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261021121427099003)(11063799006)(56012099006)(261021123027099003)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WBmpBMHncDZo4o/+fRsAmsZa7Ni43S6MvbYrPCIMEST+DFuB861Vw+TugDvL8FlzpmL3UkGjgAcrSf3bN9riJHLXE1FhS8idEeIJPrBuK+qcvuxviYCE+hoWlHcjeJz/z61vQgvSJFzby+RhY3z+T3N3SZFtAgV6mk9g6wfkGsnsm7hnQuWqzzv3uU2sNWVDDynF5IkEsbC3E4kJgydTnDHnjjxs7gT7fygPAHBpE1RZGCp+UlqyhI2qb6nGKE0anc+0csPi60fbCw5SI50+Uye03gwmXAziNA8iTKFCjiMxeeVAnPL+4U6klBIp9lQaNsG57I5E8zB6aMNviQ29s59BrFnWCmcibX8v8LgAQLXRWeRk9IB3TNuDLZeoDOMu9txJRCZb0lBYt4flMuvDp11OF3QH97o+T57rpTE46M4mqVSrh07ij2M+mvCZj0J+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:47.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91748f39-709d-4dc6-8da5-08df30173140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IB tests run inside GPU recovery, which must not allocate memory with
reclaim, take BO reservation locks or depend on eviction. The direct IB
pool and the job allocation use GFP_ATOMIC for this reason.

amdgpu_uvd_send_msg() still passes the UVD scheduler entity for direct
submissions, so drm_sched_job_init() allocates a scheduler fence with
GFP_KERNEL that the direct submission never uses. It also reserves the
message BO and adds the fence to it, which takes the reservation lock,
can allocate a fence slot with GFP_KERNEL and falls back to a blocking
dma_fence_wait().

Only pass the entity for scheduled submissions. The direct message BO is
only used by the IB test, which waits for each fence itself, so only fence
the BO for scheduled submissions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index ecd7caa95d4b..bc15fed6fb9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1114,7 +1114,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED,
@@ -1159,11 +1160,11 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err_free;
 
 		f = amdgpu_job_submit(job);
-	}
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
+		amdgpu_bo_reserve(bo, true);
+		amdgpu_bo_fence(bo, f, false);
+		amdgpu_bo_unreserve(bo);
+	}
 
 	if (fence)
 		*fence = dma_fence_get(f);
-- 
2.34.1

