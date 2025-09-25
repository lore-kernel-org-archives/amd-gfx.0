Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4ABCAC5AA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 07:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40AF10E85A;
	Thu, 25 Sep 2025 07:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gc/xiV+p";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B2710E860
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 07:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWVdh2Cme+hk3NNq51JEeKBlHwV18AQ3GJ/YjXEPKGC04NuDVbtKRQKUZXoWr2RZxUTC2QYQhM/Ta+fZe6Y/KljDBpd7wsOSa7SFkFo7LubU4Hz53W5VdGtSek5teuodPlb3pYSYsnxPMvP6QGC05OKjfRr1qjpaBwResAkWe8u0ncNIiLQvGcqg3hstLq/A4vGiP5vn1hLR0m/c9fQh0/KPDrvk8kebLD1lnzFyAlFL84w6XGVdYSltxH89jTaS/hpV/Wz3YkGoPS44aqQ27EctVGIZSUSFogU7yOTnvsRG14c22xltEZsexPwboctqJ4KnnQ06yj0ImepgNNkUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVeIE5N5UzlJZ8sEXeJTOyRITIgob2sNf45ze2CoqwA=;
 b=r+R9IOD25Bz3GT1R5I530BTdbBDGeEpyM5pJ/6yIBDMhCKkWmz5QaddyL/UgeElKuHPEvFyEitkdulpwhEBSvpKSjqNGFft784w3Swi02hgrLlTgXvKnQHAhBZL2LwIRvOIpiA41ZrJozTDxzkbdZ04SuoyGGxFeTOOcDPe1Uew83n7Got1OtrMTRXtx8+NF+sSzMvOc4AO6vbK/grr2umSQ1r2I1GD7Zo/J+9KslW4wxdREZRHMo34UD1MdlEUZNsW6WcdIk5ybRwdEkbsInUwVfVUJeYddnn9cDwQjEsbtgrPI8RhdVS3cC9CkurUBPzJNd8w9G+Ivln82RgUJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVeIE5N5UzlJZ8sEXeJTOyRITIgob2sNf45ze2CoqwA=;
 b=gc/xiV+p6KTlQ/f20a4V7nOhwOwqyCtdjTfFyzceTSi57XLWqXEqOip1JQMRkx0OnEw4v2qNVqNcdVs4qnzm5RqZTkRNhVr5gMVyl6e4coN5f5lVTfvC54vh5IHzPzONoIa+r4vA0bTiKVUmf8W3Gzya0svDEPB0T0xnnmay0Y0=
Received: from SA1P222CA0134.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::7)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 07:34:19 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::b8) by SA1P222CA0134.outlook.office365.com
 (2603:10b6:806:3c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 07:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 07:34:18 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Sep 2025 00:34:10 -0700
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for GPU reset being blocked by KIQ I/O.
Date: Thu, 25 Sep 2025 15:33:47 +0800
Message-ID: <20250925073347.2010568-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 7328b75a-f28d-463c-c6e1-08ddfc05f027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1gDOlUI9/4OqVP2fbRUjS7AsihAE6PqHL5xNuP2td45mCocDwYIqUQA2cfrv?=
 =?us-ascii?Q?M+VMqkpCzmg9lafbXPwWkZMXIhSnTnMmD9qSJssEf8jS2YLrViWtyszFKMy5?=
 =?us-ascii?Q?MfvytJbqXBs6eTzezdfSBETPKJdcOyUD08DRRYl/32WHyjdH8wHRek96BUMR?=
 =?us-ascii?Q?vWNbhItuft9zMwWny8/DT0SfHZGWV35+UNx3zg5mFXg9BQr8vupneytMinWN?=
 =?us-ascii?Q?3oRJePmAA9Nf80sxKqmfNjwF/SBhiAYuVNsw2eoRUYYv/PL7I5+eS4DNfxGt?=
 =?us-ascii?Q?y7Cg5nEjDbpzFuZOaV5HZS0BHrvYZvlOhdGb1UOkhQOHqwf9/7i4hFLe2Vj0?=
 =?us-ascii?Q?07Q/M4KHeDzuByYrEAIcRXXrqWkx3vJTmP/d/1zaXukQXjdywZ+sjS3iJIFv?=
 =?us-ascii?Q?pAaoeDpiAUZPk7ZeSPzIyp6AeWnsqepqpW9Tt6plev+y58HIUWz1aTzcchO6?=
 =?us-ascii?Q?zD398mo9vAL1T6GozkZ7Q2w/456u5J0CWRYtUvo6Fe4Q+DnpieBncUWSL06G?=
 =?us-ascii?Q?dvSDXcXWJAqAF+HLaO54Lb1UzkY+GC7mXUptghUPqXgsU+qdfmZ9qOBGuaqY?=
 =?us-ascii?Q?K7nPMd3X2B6OJutP0vPAZ9cm7d7EvuCB/SRq2Mca2QH0noSimV6QcoF9mVhZ?=
 =?us-ascii?Q?CrvEswJr1qe3iasm21+d0eOYr+DQal5vp66xGoBZErFoIL2DsD7J+sRQ09gi?=
 =?us-ascii?Q?OiXzJTWPXt9yqBTk6WQczvf6zbSKTe+TPj8LUUWxnc585oO3eLnlLu+MBNIw?=
 =?us-ascii?Q?P+663/GtLh15F5uPpAeWkGLKSCYfc2lMnh4uCG75uq4rSW4xjnoIwziyh/Bg?=
 =?us-ascii?Q?scIZ90IQLbrUHED7Ox+mF8YAtjJiL4ES2PS76e2cqPu+s6NQKMcoFxHXRvdS?=
 =?us-ascii?Q?jk7lTiWj1rwvLT7IO1YPkxdf2zE+5tOPUSrrQQVVTtPhFdP0SGLZ20/0ulZ5?=
 =?us-ascii?Q?CjjVphHptXus9nfMsGYVhysf/fSjtP6PugYF7Xnx/LLMVqlI9CSzxcRGXu9u?=
 =?us-ascii?Q?+0BPvHkrAy9W1lbHFKoE4xXHdx6uxj0tHLN0g6yO7IxESq9AabcYwmRUash3?=
 =?us-ascii?Q?aervyTisXmPOwlXZ5OOr1s1jJZhoivTgz/tD9XqYjVM2xBa5FlmQDrz6hp6V?=
 =?us-ascii?Q?wDj7eX6hgChf9bxQ1FekQ7Yvrra8Qc56qMFDbC1Wltxd+0sTDYzoTsR4SNDd?=
 =?us-ascii?Q?4EDWD1vnc0dy+DGt3Ir0DSTvS3bpa4Tq3lwLJKUO5Z0X/9sH9jEZmKnS+5a0?=
 =?us-ascii?Q?fh5Szda+s8PY+xcIq/m0W00GFhzWLt8xOzowPBpfiKzdH96ahYs0tLFdPv70?=
 =?us-ascii?Q?UnWrmbhsctpUUJGXHY2ZLTApfzAVKj3ONyQaoHkfC3WzS0T7L6kqA25c+jHS?=
 =?us-ascii?Q?gb8KFhIscFARvfCNdROiVrqtGUpFCDhNEoxDvboZX2iA6kb/yGhe5zYCwcyc?=
 =?us-ascii?Q?z8JM1ifchmO7Ian92i0p/HSI0ejzs3ZAyiQyOuA8D8YnDJ1XYBiu/67Qc/jh?=
 =?us-ascii?Q?UAwvZnMBo0SaUQ5bHBYGLX4rYLJR0sGpdsvS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:34:18.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7328b75a-f28d-463c-c6e1-08ddfc05f027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

There is some probability that reset workqueue is blocked by KIQ I/O for 10+ seconds after gpu hangs.
So we need to add a in_reset check during each KIQ register poll.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 89fc1015d3a6..b6a88103adfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1102,6 +1102,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 
 	might_sleep();
 	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev)) {
+			goto failed_kiq_read;
+		}
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 	}
@@ -1172,6 +1175,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	might_sleep();
 	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
 
+		if (amdgpu_in_reset(adev)) {
+			goto failed_kiq_write;
+		}
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 	}
-- 
2.43.0

