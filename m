Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E72CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5A910EA9A;
	Fri, 22 Aug 2025 08:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRQxM45d";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60C210EA9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipx24VcjTmiSwdbkVLu4HQJKjVVZb72b7MRAOvQ9eFvrUda5TS1wdbCXj4XP7claaLOppNANUkNVyGivNDmGwifZC8Z2qfIfK9Iwtg/bRWaUmif7Hk9sIMSqv1Im1i1Y2LG40t3W/BawrfFTuYB0giCVgZx3VHxsw2X0S9c7ZmrfDBSuOpV3861TqdpBtDFwbg1kNVeSWO0gW1Cq1rtziPO0loLR7wZnrwh7TH7NCNp+WGA5S3KHsA6a7oo7nu7k7qdnhHma2WcD0cxtskjSkzX8FyPmKxA+q0gp0TlR+9/b7y00eBrGhsMZPP1oOJIXBFFhNypwIDP7nrrgJcaqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=JtsNq6ZyQV6xWIlnlcPdcLaJ/cxxRranSVJJ3icxdBNxLJ1K9Qs6CwHE/qBTYZ4j/3pQcoX1fiZeNUdS2fPcXpOq8SH45dQqfKcB1hWM6zJ8Rg4YxDVhJ1aB2ff9lz7G6raWymkAfDhQFwwK1MHEiMJWRW40VfGW2yetrM0nX2S0OseggJNE0183cVcC9QjUVisGnX2mxwIfrA8tcBtb3m3QSN2KnLhdoTpQykl+LgC+CcUaTm0+YtFl+KMWdoWXZxmVpkKTUU8XNBy5LeZ/mF3cwwI1i+t/wVvgE6nGxxTvIW8bIoHSWk3m6f3JQpvS3KQpKyW+KEFJaEVMQ9C1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=dRQxM45dF4MMkv8SQLp17DfcvpJFsemGvd+p28HKnLsuQl5GizEOersagN4egFVeOMWoi2eWtkofzjj1uG8JjsbcJn7iQ0XMq20wgebJRI+F8+h41v0JY5xBB+xJNIQbHTGMbzD6OSuCtzWplsPefcwZ6f5EFBc+ks1HRKewH64=
Received: from BYAPR06CA0016.namprd06.prod.outlook.com (2603:10b6:a03:d4::29)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 08:54:43 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c4) by BYAPR06CA0016.outlook.office365.com
 (2603:10b6:a03:d4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 08:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:54:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:54:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 01:54:41 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:54:35 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Fri, 22 Aug 2025 16:51:04 +0800
Message-ID: <20250822085434.970798-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bc4457-a17b-4e08-4551-08dde1598923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r3/rnwVl4bi9wTwR3nta+7/1RnqshaTvEeaVO99asUVrW7yiRKf3gu9PnfAt?=
 =?us-ascii?Q?sZtS8giASrwMrf2INOlv/FYfYWUvz5z2SoyOswh6KnQgc4p0uILQo/X5icYB?=
 =?us-ascii?Q?WcSpD2u/kcAGRdj2i8/L2lo0tBULxEFa2cIzCyCAuwiVf1AJ6f2/nIMNXoms?=
 =?us-ascii?Q?K/YeDFncGQriNNvxrwwLk4+WGNbvVE6xuzQQKzer1n2J0TT+qnoIllpsDxIb?=
 =?us-ascii?Q?niDkmk8rvCmPQEiYiVhw0AYtn/GGDfTGL/PvlcZUur0K64eiqgmutlkXEDWE?=
 =?us-ascii?Q?Snc31L3sGWY7vf/vPX3bX0ZXI04x/fhInfMX4uZkN6hkTOVmqH0rkGSczvYi?=
 =?us-ascii?Q?YW+jk1CkLfsTWbP0QOnZEZKpZ3c1OAtGP2AOmqAE6CbiXDGVRIQXXutEcxkL?=
 =?us-ascii?Q?Ey1l8W/levUXyMW3yIzb4Rka314I/NN/4EEbi1RieaIAy2+gzzhScph8qvXI?=
 =?us-ascii?Q?sqK2WXMsuBoxbRb+sthFw1qp1Exm9uIFTobHrPvWUBrYJkgBHcXMwHkw+BWG?=
 =?us-ascii?Q?DK8TdhMgJ1b5ChApiajV/T7LN1G1/PVJ22V8bNQTUpkMQmFTkaP6HSUHlPWm?=
 =?us-ascii?Q?gdIlJhnBnAl42ZchWgT6Rg6leYgPKPQ1LIdw+r+4MdYM8txdHYbmFnZG1mEH?=
 =?us-ascii?Q?zRKWObHMbElnxnPriBW6elbbYKoXohVFvlQ3p330ESbPp+d8LmHdxEonbqj+?=
 =?us-ascii?Q?mhF4jHJhFbdV4dhPr0pbIgjNAhPPbVYMgrcqc41lrPri6gwbJ9BimbffcgrI?=
 =?us-ascii?Q?FIOxchQWHvoMYAbxBNB3dXbZZPKxFmFWi3wR6Btwab22h0cP3avH2A/FSEVE?=
 =?us-ascii?Q?/j2w6ZkeoKQ8uIsOPvHYB1Z8+g4SjDfV2a5Blk0dN0WHC5Q54+5BCypUGxFQ?=
 =?us-ascii?Q?tAubUtI6fr4k/kKwQtWF3FSINHkHmNBAffLD9cT/u4oP4yhUdiSwzXRLhQGN?=
 =?us-ascii?Q?SyiaN/lR/CGPgMxT8vnqAGajSaJfNxt3WkwfEHk8ZyZbzqsNAyc4JWWa/5je?=
 =?us-ascii?Q?EqQi2Y51CSo3uLtvvZ0bn9kOUyMogjiP88UoLTD62+yGd9JhtVDTwD2KYyLb?=
 =?us-ascii?Q?7I5zVPhtYym/ZUTPGBnv7kNTVxCWY2cOnfCoTK0Qf1zajXYkGHPW7AxosMgI?=
 =?us-ascii?Q?NW+rQj/mbjIBK4JJGHd2kE2I6pHkyE2rpGAsN6QD4E6egJSRjhICfh2sLw6a?=
 =?us-ascii?Q?0H0qBg8Hg3iN9Bcw7eLKbjUoISX3eqpVBAJ/yWJBZ7F6GsjDagpfpASHxv5b?=
 =?us-ascii?Q?egcaoNOdaNiBCRRs5bmNtaO709kp/kAKYxj2pHfyhpISCI6jKfY17YqRAOCY?=
 =?us-ascii?Q?peKGGSd8cHKRIb0eiE3X5V7qD4zvuoYLOMvjutvzaQI6xnilYt1xDVqkmHcB?=
 =?us-ascii?Q?ZD5ZlVEA4Ki+bsmuK/aPzVQmsbs0PIGW6NshtfkNap/sCPeZv8rNExiEzbEx?=
 =?us-ascii?Q?e8Ec9T8mYogM6WKEfCAKkhpxO/L1hElurcRgTYUMTyzZO2Amqy+HbaA90vbI?=
 =?us-ascii?Q?ACdEgljvFz/2vUatOj1VeZoOpsxCkFsGFim+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:54:42.4350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc4457-a17b-4e08-4551-08dde1598923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

