Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA76C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 19:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E824210E119;
	Mon, 22 Jul 2024 19:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgQYOI0L";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059E210E15A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 19:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gconpj9W5JDvBxFciqwh1UuuTlf3H1zK3nrgJlQglLxoj8GqU48Tah+FdIxvfl9MJkrVDOC0ulA7R3bsBrzHmq/9RHe4Eq47XjKjq0rMoZ5XF6/ZOzlx9TMLQ/w1qKbotuYQE3LCAHAAED4766z6sZwQtv8b//GyhJj4/5urv2VtUppuvqEPLPakJYOV07NIqv8hRgmoBk1Df6QCvG6zN9iMaDoAhIyf5IUm0/3g/Hle6/bk3JsSNctPa9PuloQ2B/zJQV1PZO10wypFmg56KAKZ/t8ZJLRpF6MmDKw5msth7lLZEuFt+QPqQyRvkphWFv93aDl/ZjExwd9M5TzaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7EseC4r2Wtoa9+9mIEfSIvcPSBj70E5H18R4OIwlEk=;
 b=u7VeUDR0w7tHO+NCIuBebGyQXXVPb+O0fO2U1bQCi6rebPW1Gv9m6YTaggZBurUwML+BRACEv9twhqjj7uSkdmcSPbcORU4VpYMbZZWZio4iUUaIf3My8Pj05iZPa7FgBVklDGgG3uVs4nSTlDpZ8tg0WC5xkCeZUZkVxhl8ff/jtOrhdz23xQMyz6Ys6IXRvZFjyf9vq+UJr9qPdQU9mda5DbkthBOaV+S9pJNKLHI7avDbiCYrhAJdVf7iyd//NsHs+nDOkRvwKwbt644hey9OnfUCGVy0yIrdPf3ovtO1Ui/QUHjbWeo6cC32cr2x0pnzAU06E7I5bTcieSSbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7EseC4r2Wtoa9+9mIEfSIvcPSBj70E5H18R4OIwlEk=;
 b=sgQYOI0LsknZ6htOaGTqxu/aopWR8hgpaimThuI6uRlVTSfXBhOTCfx2ZG1pj1RYjLRHJ1+zglrMXsH2KSDlCw85XKfD/7CuKt/+UBcWqH8NblQem8GYT15AP4Ek0+rlVZp3HPMrxoHk3eVM14B1Dd/1ORqau0/pTXhaSBX/7uQ=
Received: from BYAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:c0::30)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 19:50:34 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::9f) by BYAPR05CA0017.outlook.office365.com
 (2603:10b6:a03:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 19:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 19:50:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 14:50:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: set sched_hw_submission higher for MES
Date: Mon, 22 Jul 2024 15:50:16 -0400
Message-ID: <20240722195016.1752979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 01861f9a-a3a5-486f-12e8-08dcaa878cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WWUVcO61U9YuNVwbHYVEW1DLpW0rej8IVq1gfl/d3VA0ceCJKB9XW8Nag3Bm?=
 =?us-ascii?Q?bOipk1lidoxnx3dRAkwCliUTYWQiBmP1/HHG57r0ODNZ66tBMtReX0Kb29BR?=
 =?us-ascii?Q?YjWuI28GzsUIKLNFanYVkpUBvpnLb3D4xqd5PelitZJxAoOXBcriJER4DzGv?=
 =?us-ascii?Q?plgNvQ5/pHGuOHW8HX+ZnLdRu8j9vCMTXArNtxPq4Iwu4i5z/6LzP4+j4cN3?=
 =?us-ascii?Q?BhdT99Qck0FX7VHY6vRa4dU54VgSt2dkIbXJsehzFN0ujGKXRLrqMwbExZSY?=
 =?us-ascii?Q?zZXBczUOCRy+LgNk/lt3v/zpNBTjsJdDUmw3zLH/CyAGrEw4PH5UPEv6FpFp?=
 =?us-ascii?Q?x5tekF0N7TqO4PqiaMCmL9vuQcmDhsT4u0FVfqy926etO4xyulVauONhJTSP?=
 =?us-ascii?Q?Og73hIW6wR5ahA5/vyJMzP/kVNUoyjTzlHNTMOALn3/RwG01lfcEDwHNbAGb?=
 =?us-ascii?Q?xuhxmaiHRWkOlROJIT2GbEJsg8fb/G27dyaL8YM0svN3tw3Cq5QjhWeJ5CE7?=
 =?us-ascii?Q?XgVqHCL12NEtbr51d+JwyXQ5ZfczkCPYb60dvhLeTM6ORMSyAYMeFa2qn0+Z?=
 =?us-ascii?Q?HjwEwNOtM9JSwR2+blJb6HzWfWumPZC2hsAhbUDj/UC+orlxZyb4sF854jYN?=
 =?us-ascii?Q?HfhZCklbd2Zi6OYwPaTmbPD+1Yd4vytxGs22LDFiQSKk5DWTws5EY3SpDCYg?=
 =?us-ascii?Q?hEWFVhvH5kVRmR8JEX6tIx392qY3bJPUCP/jl7wgD6Coa7F88MesDu4QrFRY?=
 =?us-ascii?Q?zDLGBWU9DWGr5kI4bWZGciX0hkKsaQ4aklYXYI4mTS5sfqciZgXUDzfEzKln?=
 =?us-ascii?Q?DLBLqPbJLGCzH7/KJaWGNxqT2/wKaoO54HIHRtv45CdTmeyoXR8cdM7/bUsx?=
 =?us-ascii?Q?3yUUGKjxlLZlEgydT7af+Dg9Aknf1l6Vz6spiez4mADCWO3f7iXfu4XG2a23?=
 =?us-ascii?Q?2hG9XEbOKMDy7MYBRISzODh7H8yjxgpuV7ZYvN7MMBfnRaJdox/rLccrvlTz?=
 =?us-ascii?Q?vlKUxMti7aKdLvVrQrnnth5fYw1C5IbesWmvS7Pvp47CDbUBGTLCSH1EuLWG?=
 =?us-ascii?Q?/gezbrp9bsjDBWlMflaCre/6B4lOdWeTG4DFYL774Jfs6etaLmZoDe7jtNe7?=
 =?us-ascii?Q?v8MRce28zEYYLlrKssaeDT7uTRACvThLqNwR3wJr+sQdKidMaAjL8RZYoDbw?=
 =?us-ascii?Q?wtX4gHEbPm7WFVHWHCKtj+OyKzL+6N6T470w8ZFzJHmLThC/uG4ilhAe5t0M?=
 =?us-ascii?Q?oFeTVzBZpUmC6f2Kq7NAt6M/TQvqBoZ34Ls8uzszwf+9SzYIftFB0yna/Pfp?=
 =?us-ascii?Q?yJdWuNW9a/sHct7q4ojHWAdVRJEW5mBiaQ5A36zaEUivxSKV3IXNmTvxaAi5?=
 =?us-ascii?Q?5/+mqKJiL90J0FuLyZ9ZwHCtRyZYlFjMpS0b6xj18GVZTahf3MZR5iktRvUH?=
 =?us-ascii?Q?s3TxBn0qja8BPPetHhBKi5djSoGWymx7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 19:50:33.6451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01861f9a-a3a5-486f-12e8-08dcaa878cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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

Apply KIQ logic to MES.

MES doesn't really use the GPU scheduler.  The base
drivers generally use the MES ring directly rather than
submitting IBs.  However, amdgpu_sched_hw_submission
(which defaults to 2) limits the number of outstanding
fences to 2.  KFD uses the MES for TLB flushes and the
2 fence limit hurts performance when there are several KFD
processes running.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jack Xiao <Jack.Xiao@amd.com>
Cc: christian.koenig@amd.com
---

Jack, does this fix the overflow issue?

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..345823d14113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -204,13 +204,14 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	u32 hw_ip;
 	unsigned int max_ibs_dw;
 
-	/* Set the hw submission limit higher for KIQ because
+	/* Set the hw submission limit higher for KIQ/MES because
 	 * it's used for a number of gfx/compute tasks by both
 	 * KFD and KGD which may have outstanding fences and
 	 * it doesn't really use the gpu scheduler anyway;
-	 * KIQ tasks get submitted directly to the ring.
+	 * KIQ/MES tasks get submitted directly to the ring.
 	 */
-	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_KIQ) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_MES))
 		sched_hw_submission = max(sched_hw_submission, 256);
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
-- 
2.45.2

