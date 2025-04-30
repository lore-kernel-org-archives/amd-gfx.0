Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA6C3ABAD
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2C010E264;
	Wed, 30 Apr 2025 02:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/osaJ1K";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C4E10E264
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es0GpYzq2AbT8ouxUYoQbIlEBqn3LpauVR8pa+HtU2PNH1PYZ7Evqs2LeCa9tv3s9H2tPwxqVhRJqhBsq4clyT7smOC2KEusSorPdANcr6lXqnI7jrScNQu9MGRgiL1A+PY+aeJ/ykR5cKBi5pVPwsgjvgG9GrXleq9d5WJS3RLWfp7xuBYyt+TULfppsRWSA1kHl88xkmHf5lhF0YHiuK2ukqx4m0Sb5rJBkd4XgtYtrymIe8EHhmYFp2vFT0e9yrjouT2VtECltm/pn71oIgoUEtNd8YrLmme9m7n+ipXd3rknx/kkogL/UFSdItDZcpYdynzUUW1QOyqA9c2Kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHM2SWCOaE6ks/A3SxX16hFPOs44HilPuxB1gvRgHWM=;
 b=Xt9xBlV5P4xR+cwbnIHRXmdfG1aGbJNKPwrdZdicRqgqes/w/cP2lAD/ql139Rf4bab5M5784UdoeweYkwTXsaZoRLvFmSF4QOURyajMYVSCUV6aj4fe3g5btMvZ8UN1S8j+DjaYZVfaSZmp9OGk7I8LDcJgbYZGFZ91hQL6i+ecCJJ/sPxBQoLa4VxLTd0Wfq0hnSn0XP9IlQVHdVpus9ymQnH3YQ2wkqbnLy2Tty0kNN9yVzyr0Yabr2ZW8hkbNHXxaComZfaffan/Dxv3queogB0sauu7y/l7vDSBtOwtH9idvLlWTcN0KGmw+2iyCqXueF38wmwLtRT55s3hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHM2SWCOaE6ks/A3SxX16hFPOs44HilPuxB1gvRgHWM=;
 b=k/osaJ1KTp0kePZKIn6Qo79TlketLXltzNgw+D1BWr9Vfun4JQt1cqoyyQezODDFdEXkECevOwzz5VQYlY3egsU4HZhP2yOIqEq2XTMAH+sanVyStdMTpnT++9RsISZ2gxmVmwNUeQmPGFNgX9o+8fHwRr8UfEkEFHprNDfBLXk=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 02:41:08 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::77) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 02:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 02:41:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 21:41:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction fence
Date: Wed, 30 Apr 2025 10:40:51 +0800
Message-ID: <20250430024054.4093239-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430024054.4093239-1-Prike.Liang@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: d54cd73a-2b00-4dce-e27f-08dd879075f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YRbdGN4kLBTfjYoNeIbyqi71qiUhjxunR5phhbK0HAU3N6JoButeco/xcd2h?=
 =?us-ascii?Q?GecIT71N9h2FUk6rpznxUIEr0ikkxvBiJSNs5XWtRZfE5A9XC7k/27ZV/V98?=
 =?us-ascii?Q?C87iKyigMsdRZ3150SKvjq0GuzHMRgM/exyMTBcLmh7zqfIYJfdMyffq9ro3?=
 =?us-ascii?Q?NAFbsbp4rBK58xzE8m4HUExulY0FeoCUPyKmr9Di5i+6846jzM+97S5UIji3?=
 =?us-ascii?Q?+Ix871CT1H5cTJooc7G7go43/0RrEhev+4gp5VJp9iBfgR0zzoIzeCtMxmx1?=
 =?us-ascii?Q?Gafqww9R5+okpnrSEdKowq+Bia69aktEY9j9SpggxEu846XQJvNgKKsUanG0?=
 =?us-ascii?Q?QtpIXyYcQrvhVSdsgk2AvB/JFwegCTn1o2MUBn5F7wsVHTTB7jOgbE/tfmw0?=
 =?us-ascii?Q?nnYpDDqbjrCiSR5KN/qTrW/WTT9YawpsSysJKnlDu1IYUBXBmbejICB7wM90?=
 =?us-ascii?Q?zFxUGtQAwTlgHaV/vzHIQQ78E1ArCIQAM2B6MX0U/2ncShB+xHescQFGzdQP?=
 =?us-ascii?Q?W+ncAlCagK3Z2crh1p7h5VnQKOUUq7+IIf5YphktmIDLSnrGBEM0DIHheWdy?=
 =?us-ascii?Q?7M8GL6xDsSm29WfjfAPgCB8ubC4bTWEYwDovVPcTtRaUN2o0bQa1tVSGZmMi?=
 =?us-ascii?Q?smQO+zdm+jl2gJ/LOlut6JkhrjUq/uEDxvUEH7i9J9ECz715SlbauIcNclQ/?=
 =?us-ascii?Q?1z3LgKASeumsnP83GLqFL/EBU4r4BvNECLr6xQ97vKJ9lCBYedrs46k7gvdw?=
 =?us-ascii?Q?KMlE5nQPBqX4vn7lzhfUdiYFFiEyFmP92bUGhadEa0MsRwUb0Yg473dUgzuf?=
 =?us-ascii?Q?k2meJiM7iRb3L6Vfq1yJtN0eUFzN2YRapwyIdcRUgVJzSidsuEAyL48P70rL?=
 =?us-ascii?Q?Mh9TUeTmPBFDUpXfARxKNTrlTps2jY0zw3H+2dx42kRZV9A+NPW/gKV/XmUC?=
 =?us-ascii?Q?g1eizX4qOatbns1DZ3qWWpiyj6mGMHVYlI46CFjyj+zQIoU9nmrs4069AGxr?=
 =?us-ascii?Q?Kcp7bvyCDWNSZ7i3/wP9DzQYx8QtHCR0FOz5NqbrtOUfZP2IaBvcQMbipjeE?=
 =?us-ascii?Q?vxuLx3l6/jd9s25NKcf2IXSzw/u5I0Ztwd/4Xt7l4p/4wWmPX89eLG1cIohi?=
 =?us-ascii?Q?8ATNoD+dl326J0jCvSvQxrCW1uEchR+A294d1D69pJxkrff9mFRWGVOaXSf8?=
 =?us-ascii?Q?b6S6UCfKftgPi61yLrfRxrEOdS4C73Sj1HyF1cECXZjkiMd9Kjb/wLVz24KB?=
 =?us-ascii?Q?xj4Ah3at17NFCGATp4DQY7k81GH9dEyxh8zaES14Rfkk55guI1rrER/7k3QN?=
 =?us-ascii?Q?87yIMna7MeKw4+/ZpbGFyukQ15MH6infdQAhWqf/Rf7B6mA6NTE/2wt42DNR?=
 =?us-ascii?Q?sdi5Kj4s4AdGrhz7qdVZDqTWAEcAERM6qBcFX/zR+K2IB+0ERgdBlgdte1SV?=
 =?us-ascii?Q?bxc3Uqccy5vvQ1tc8Chn2fQw560el9BRGul/opobxgYGW7UsosazXzoPpD+I?=
 =?us-ascii?Q?YA4H+5P9N53pJp2vwEEl3545keh3dT2v1BYt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:41:07.9899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54cd73a-2b00-4dce-e27f-08dd879075f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Don't return and sync the user queue eviction fence;
otherwise, the eviction fence will be returned as a
dependent fence during VM update and refer to the fence
result in leakage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index d86e611a9ff4..6c9b2b43a929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -224,6 +224,17 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(stub);
 }
 
+bool amdgpu_eviction_fence_valid(struct dma_fence *f)
+{
+
+	if(!f)
+		return false;
+	if (f->ops == &amdgpu_eviction_fence_ops)
+		return true;
+
+	return false;
+}
+
 int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	/* This needs to be done one time per open */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..d4e1975cac71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {
 };
 
 /* Eviction fence helper functions */
+bool amdgpu_eviction_fence_valid(struct dma_fence *f);
 struct amdgpu_eviction_fence *
 amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..8ac685eb1be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -185,6 +185,10 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 {
 	void *fence_owner = amdgpu_sync_get_owner(f);
 
+	/* don't sync the kgd userq eviction fence*/
+	if(amdgpu_eviction_fence_valid(f))
+		return false;
+
 	/* Always sync to moves, no matter what */
 	if (fence_owner == AMDGPU_FENCE_OWNER_UNDEFINED)
 		return true;
-- 
2.34.1

