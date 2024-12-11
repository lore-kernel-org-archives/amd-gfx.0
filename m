Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C0EE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB1D10E408;
	Wed, 11 Dec 2024 17:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8R739YK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30DD10E408
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLGFtqnF6XwLq1ECdh5EYx5l/rYS+oGUe9LL6pEum6HBQmNXFaDLUFckm2ZU6RXibnUdMgM3CNx8Xs9YYizJFSh441JccT87IB+BYu866cZSd5wAhsGP2ysDDzBmhz46SCMuoYxSg3QEibX3hZdcMIWM+akmEvVEz0f6wll4OoETpjfAX0nTHCUCMC8DaGJESJrZO5H3XPhX6t1cX3kgE3fBou4qTdmAqu0Va7SoDYSmN5hGSW6NJ0GyZpCu9dvetnKfch/67PJIHzOFmVuKFfUqzNZ+yRPWoHJ8Mor/oGxk6Buuwkh6p4SHGOsXyk3QqHEpKdMEO1hrPhTIKHbLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/NkvwOqa0AIDkr7t2967OD5x3YLEd0dALhyeqcHOew=;
 b=Useyd3lLq0s9tqsmNaiC3uSK/mohgRrfDU+E1ARndI1u3J6bZ+wB91fmKRQSKBq7GZJdOmXprddPF2EU82HqkLa7GvbHsmU+eg8zjczNx7imF0jfR2cD/E8ITHKsBnDLcJT/UScqIkhMUehOsyTOejTZDj46G7/f9wx7LkRzL3DxkFzeNJaJUKNSOXd5m7VyJ7jCK6A63Ag1Mlm7CJFV9U3DOPTibOjXlru6O4V34KNOL4V3CncpX0xTRCoLs3HOztQRK41qoz3E3ChOgLWCZxX92tGQbVaM4CH/I74dBiu3VKytr9V25ZPbvE15OnurM3p6kkr6n+vvVajCeYhjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/NkvwOqa0AIDkr7t2967OD5x3YLEd0dALhyeqcHOew=;
 b=i8R739YKPd+TbJB6JZEKsZV/8zLPvvd/JSzeCzq+66E6oOaA6JfxsfqXSRsbk74xplX3GL9intiLvsdBwiKqbwWR20mJ/IlD8uqyf8xZ7ImApSWQcwAF+XC5+QN09PTF/qpp+nCTTMNZHLBf4PkK5Uzagtc81cAsMKBLLH96Suk=
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 17:12:57 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::79) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 17:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 17:12:56 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 11:12:54 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: don't access invalid sched
Date: Wed, 11 Dec 2024 18:10:48 +0100
Message-ID: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a085f2-a2c9-49e3-9c0f-08dd1a070ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rA6oIt1ulU/VfuPm3A8YJe32h1/9jTqowIFDuqGGX+HsWUWfC6z7O+bBPCAY?=
 =?us-ascii?Q?dNHRU2uydr19T8C4uONMoQdBHeJSffdv3vjHgsf6pgDgitdRpW2fwAFytG61?=
 =?us-ascii?Q?QAv+Qw4+AXcTiFqU5cUogEuBx2hh+AR/KDjQF/RpmrYCGGa2MoT3u/PBgKzB?=
 =?us-ascii?Q?8lzsZ545MVFYLVb6zjntcDYBmH2lQ+Ub/1g27x6QP0shZz3KC6tRSMHbUJO1?=
 =?us-ascii?Q?uW9h8G79JnFz7ROYk88wCfkymCgjmwSTdhVD9HcT9t51Ze94DvGGmKzePptX?=
 =?us-ascii?Q?tKy3kkbFWQBHxCde9mj5Wbp0jEHwqNhPBiwlPfiC4J+RGYfleoq0BrpB1+Qq?=
 =?us-ascii?Q?1f6GO+UDtctX+NJJNNITMcTN42BdqXnfa4wN7XUZGwJXDxe8k5kLNdV0/4z2?=
 =?us-ascii?Q?cquUlNV9APHqbnvJE3L1rG+SJp6VwHPtPlXTEcs4PLj4SO9hNSny7WinWT1E?=
 =?us-ascii?Q?j7a5itLgCSdnudewcgaBVQWfSy0ssJwxP5CHRpy9Sp3wNd+ru6KLv5AUDQwo?=
 =?us-ascii?Q?f/5BFhDpIz7ZqedbLFXzO2qV8inog8tUvdJ9/eNHF6Wca/n+4wwUahe6xPlg?=
 =?us-ascii?Q?wC/hT/TXnr4Eiy2Q72QJ45dDbvetBio4XGtdeeXNx3/TTdiXFr/JX5Ili0Ct?=
 =?us-ascii?Q?fmb1t9/oVAFmMS/lgPpa+ix92DNjMOWcM6eGIrCYeMd3lMp33pTIjIXoerMK?=
 =?us-ascii?Q?vik5mPMqNZyOpTeiJ8da7BPoApaVZY4qO7d0jOVxS0BySusssgyK+Xjs0qpT?=
 =?us-ascii?Q?PxkSyVaPakPs7PzoXz4GbCegaAJKWBe09AclRBS2b68njCrDAwVgTr49DNBB?=
 =?us-ascii?Q?7DxDeFU6ADLqlUFY5+GpXf3JZ8i3qc/k47yI1Ha4Ac658AFjBDTpMv3kcMnV?=
 =?us-ascii?Q?7r4F0IXEJ+FFNtYP/VodkWFpEKNAZzbSHoGfnrNAFm5TuS46+0HPg0AA4doI?=
 =?us-ascii?Q?M3qXiBi2Tj0/1UisDKoIOlTOtr05jIBxJeqRGh67mnMkiwJ9HXTb+3X0Fwhz?=
 =?us-ascii?Q?im/EdVXAz8PbFsvhWKvRkFHgM/few00tEL2qqjVpGmSJ580+CDma29ZprYH8?=
 =?us-ascii?Q?j2aPYU4qwROEfNV+N6wUzQB1PYbWOUYSbnzTMbSxV+7DFUq5K+7vTNJb4JCF?=
 =?us-ascii?Q?oS8S+exmbaB44Z9tK46bJExqFUlLqvr+2ZJ2lF489p8DX8e8wcrruEVRlAyq?=
 =?us-ascii?Q?0xDRMu2ocvYLl50zY07twJutUXJRZtV+XpbuUqVZXyq1kULKFu70NbBlIzn6?=
 =?us-ascii?Q?3NGLUqWdT7AeXLj3bTsAy63Q0VqaH8sT1Es8x4zqSykTq/dDgJdEmzfHJ1Lt?=
 =?us-ascii?Q?lzrmGd/MdBGyuJazkBLXuVjI3SE13TFG+Usv6ojcWj7j8YHKSEvoylomWunH?=
 =?us-ascii?Q?gzw69uR/xdNuw+zIMIU0hUudRX2Ipo/b06Ng+xrB4XLa8CNywbthAAucn4o8?=
 =?us-ascii?Q?sp17cdWXHcixC9hui4Z9Lv9F03WRCXlu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:12:56.9382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a085f2-a2c9-49e3-9c0f-08dd1a070ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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

Since 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")
accessing job->base.sched can produce unexpected results as the initialisation
of (*job)->base.sched done in amdgpu_job_alloc is overwritten by the
memset.

This commit fixes an issue when a CS would fail validation and would
be rejected after job->num_ibs is incremented. In this case,
amdgpu_ib_free(ring->adev, ...) will be called, which would crash the
machine because the ring value is bogus.

To fix this, pass a NULL pointer to amdgpu_ib_free(): we can do this
because the device is actually not used in this function.

The next commit will remove the ring argument completely.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9b322569255e..9ec8d5a8e48c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -256,7 +256,6 @@ void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 
 void amdgpu_job_free_resources(struct amdgpu_job *job)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
 	unsigned i;
 
@@ -269,7 +268,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 		f = NULL;
 
 	for (i = 0; i < job->num_ibs; ++i)
-		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
+		amdgpu_ib_free(NULL, &job->ibs[i], f);
 }
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
-- 
2.43.0

