Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C5C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1C610F856;
	Mon, 29 Apr 2024 07:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykcGGJsg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9917210F856
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL5KSCWQDez4M+f6bYxZU8Vv8PLa8Uo/f2b9K50BTjyvRRZ60RXhLrMR8eg6pOgldW8d6Ls9eo4b3l0QTaEaOMcdAh/aLofHpwja0q69BC9Mhra7w6exEvRzhaWRlsOWOPRLqEvFQFGNl2Sm4ZWdi7dvkHwjLoqhMzOahff/ZM7Lg+d5Rk/j8MCVsGV4ac7zFjS2684JS45xeF4p4I6fcEAXHCFz0VyLJdVeJAkmMvDZkaja3phvdNO6Z7/KIPfa3I0QcGjlsfdBppqT3cLCbeYJLFr/7QDDoEFM8BaE2HEsp8+gKLXhbzEHE1UiY+lga/+ymdF4h/3oOeESFSqm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjCHzBnaz5KlsJ7tVi8CVPJyfcshj0QyA8A1/aZUVQ=;
 b=ceeEaow28QG2jD4Pq4SGwYMEnYHb+ZaKc2bgc/HVYeaCCyiFTK4IOUNogS5ubhA4X6r7qu1Dq4qBrUUV5Ecp3iQnWi3xIg+TX8UyDi5jCYEa2SJAA5WLo7ZH7Ou0ZPcE6XpjYxg3LXCZZC/vRvADyqm2jUhsZeNQtP/TTr/Uxeb6TOkJ+/OLKhy4E3BP2G6QuSN1JfxdxR3yi+e71Kwjf0wbd+4qLLyRm84Uixag74BHNEsxaq1dw8NU0ove0rAXpCEvd3m/S1cntafvZnJONM1EVgZ4X/IPFkxNrSh3We1lsIuBuBPAqAWUilE8QrYvImuCa3oGrd72thai/4fGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjCHzBnaz5KlsJ7tVi8CVPJyfcshj0QyA8A1/aZUVQ=;
 b=ykcGGJsgTb/pCwecA97OyY9frgTz9o2uMA+OOhVquE4u7swPvwk2EeH7YCoYbl3TFjRK3ZT0pq+gnT/tWL7r5T3uejrrX0x2FW9plze7woeD8jcwwBLQXyjBeSvSxepTTsKM72a1pbW9tvPz0KY/MJSCHKGvutw9og4Zzi8vfwo=
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:31:37 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::44) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 07:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:31:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:31:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:31:36 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Mon, 29 Apr 2024 02:31:34 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Owen.Zhang2@amd.com>, <Maad.Aldabagh@amd.com>, <Qing.Ma@amd.com>, Kenneth
 Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft recovery
Date: Mon, 29 Apr 2024 15:31:31 +0800
Message-ID: <20240429073132.12611-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b6f664-bd71-4f02-2391-08dc681e6743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?scudYCObydJYPUtbGR/eeZU/JA9OMC+YN+Y14//nOKyg+5B6mm5dx82O4ONH?=
 =?us-ascii?Q?07f++N+LWDUyLvRhojm0tCqLgRSAoO8iPL24bI6C/zm4AwSa0qDQy7KO39Wf?=
 =?us-ascii?Q?i4XuUSVp7/vlb4zv26L+Xr3sTHL+xX21900ozR3kLFd/qxe6We2Rfhk6Po7F?=
 =?us-ascii?Q?XZD/BTmikxXGX0m0fDfcKIXP1yxso2CehueaCzJ3uVR39ZlvRDqh2QMNgM6E?=
 =?us-ascii?Q?zLJeXjBhNLC88QzqZMFUCyi6holK5VzaX+nHLA9MD5/V/9rlPfjTh8jB1wDx?=
 =?us-ascii?Q?modwzuTebBZTQeZGf8GQnlJJrSW0qd11/X3BuTXCDOnGzBG3qcceVYXln42n?=
 =?us-ascii?Q?rx+b4+2g48/Qz0G6VpsYr1tcEaedWBGLwuETlHII1iuv747qvCOSjJYH+hmk?=
 =?us-ascii?Q?4zSgcB51lxu+Xdu6+PTDdp9JLylVxtR72B4FCVRsmFMTn5TU2tUSQ1bEKZEB?=
 =?us-ascii?Q?jHu/EuHkR8l2feHD2mdVtMjqYC9E8IM1kVYICJTaG47Nd/yvbBmlU3dY059r?=
 =?us-ascii?Q?XMcjwXnwWUZhEYd3QlqWUGR/jnLedKMTxk0tzyMmrvCCDjrAO/X+W9eyNilN?=
 =?us-ascii?Q?yH23oJX4yTeDbSomPCWblPBgL9riF64UdLTGAbofVBt651KDas6489BZ1r0V?=
 =?us-ascii?Q?ob029QjMTQuUQ8s1Z1vCEOHj9/7Er7sWxN0xGO1vtEjgppPbnL4Ce8DYpJZF?=
 =?us-ascii?Q?OdxXz2HW0dHTB+ZcZgFLg/VTpd7EMigWwMO7pDBZeGGllT9DHq4P3hfOrUYG?=
 =?us-ascii?Q?Mu0K9ymbc+vhKrDJ3HKLva+up3tP4xtxTbsvLh9y5QdZ+XaUtyCZ2ZCt6oUj?=
 =?us-ascii?Q?b/o/3ksyBOrqaV8gHH1I0Km1uEn9a7ntW46lKXr2lz2dVGqgyB0POXWCJZSY?=
 =?us-ascii?Q?m+o2CDdXtz3RhbFoRai7vTideBtvkCOZllm6rqE19J2E4GNA8WFMku/sK4+1?=
 =?us-ascii?Q?8xTqnaCaoPHjnlp7XUiv2f94VVJ/Fu+1EkefhnSEPkHiyMAREK7wbCJr5uLb?=
 =?us-ascii?Q?xWB79tgyPbxY1r87tcGE+x97SVhOhSKZ7y/D7WOEKlkJ+t93j5C7T7JUtXvl?=
 =?us-ascii?Q?lxcB0LeEpi7f6xsTfmc99GlLLhCkg/27aA0VU1GhbD1o9kypf1PBAreI8HQQ?=
 =?us-ascii?Q?pMjPcR589sDRvlms5Z4NXv8bkwvv+Q+y44GyMyPnLTV8XlMNAwY6Q2zeosnK?=
 =?us-ascii?Q?nc4+pK+RXkYcwquGnjx4qPVUbZvI+nc2gEhmlardMcuIWs+LcxnwyHqWMkLX?=
 =?us-ascii?Q?RMeaZ6vxTSFFaOZeeqXxcyAJKRWqIBWtf62TSwswcjKHFHcnaW1J7PfGKFSA?=
 =?us-ascii?Q?TuNk4am9Mx7Rzg8a+nCKjl6aj6T/q/Ec1EQ1lxBtqYWIX6glXX2VDQEQCW/M?=
 =?us-ascii?Q?oyMbxT4QiKmeapys1IQqUNIC8u90?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:31:37.0059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b6f664-bd71-4f02-2391-08dc681e6743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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

customized the reset to skip soft recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..65c3a387fec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -548,7 +548,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
  * DOC: gpu_recovery (int)
  * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
  */
-MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
+MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto, 2 = customized)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..5c75993698a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -51,7 +51,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	adev->job_hang = true;
 
-	if (amdgpu_gpu_recovery &&
+	if (amdgpu_gpu_recovery && amdgpu_gpu_recovery != 2 &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		DRM_ERROR("ring %s timeout, but soft recovered\n",
 			  s_job->sched->name);
-- 
2.34.1

