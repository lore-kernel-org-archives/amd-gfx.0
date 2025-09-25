Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A693CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 09:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833D610E8B3;
	Thu, 25 Sep 2025 09:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGfuk8kD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B50F10E8C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9NmcIDOW41644VOFZvWzh8aE2lZYzODqyegWr+jNV8sg+N7sH9qLFascXNFtQwgD89KS/HOefbLc/WlwNg7Vd4Cloy2v7dpwvl51XLBHQu7TO5H8jw/HlBy61lGdSySmy6OV1iX9HWHDEK9mZUnX6JFbCkS7K6QV30Y+fnQinMRKn6TBR3RL/2sctc0Lpa0SfUWRlOSvhl3ul43vZ9ALglccskh6I8StoVFb+lXTxItWIUryjvaLPICr1ceDrcOrDF/6OZkjVSd5/dRSMW+A2LkczrlYLeG5kxXmBfn7k7emAeJ+AlcsMAZg4opl81PTsTaCqTq2BBGk/EOQI/nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLaQP/jOE3TF0eitsshvoQhlT1AxmAQVrnbB3YwBTuE=;
 b=AvPuf6eVtidLBhJL2b6Tye1Z+R1N+HLqDtkU449CROgew5k27xdyZLBFUjn8sUuGPlKQZnGufqzfWxuuVKcVW24V0LjusT//N9Ro48VOvlPtW6ATT51mmr1E+SooEZmtYiGxc4NrqGVSLe+VB7HZhHNZcDuaTq0h/szmt2vQpXpRGlztVc9pAL1Mc9fTh3Qg0RMMKTb0GF4GkImET1zDsrQgps/XcYHynvhy+rtH8xmE4HTycgZWRtA5P15pggZydQF0fdkAWU3bclKaelFLy4RT0b8lHrXM5S0ErYMKHK/p9XqtRqgSQWOmDO70BTwWur9hDlErlRr9kfUZ3B4jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLaQP/jOE3TF0eitsshvoQhlT1AxmAQVrnbB3YwBTuE=;
 b=jGfuk8kDg34yJiLz6/qh0aGqUSwXaDnoTmJHcw4tw//2J24AZGqaKqU0nbIAS8nyp04Ux8/lYoUVJu1ZuDpStdcTL2PbqmdmdoBL4Mo1/+5Kg8bz6CvZ4kWU4zG7TsmRF3n7ggY2dEjOlCUVUoiPkibxqulsk4ZuwbVijD6LCgs=
Received: from BN8PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:94::31)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 25 Sep
 2025 09:43:55 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::1c) by BN8PR03CA0018.outlook.office365.com
 (2603:10b6:408:94::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 09:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 09:43:55 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Sep 2025 02:43:52 -0700
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for GPU reset being blocked by KIQ I/O.
Date: Thu, 25 Sep 2025 17:43:34 +0800
Message-ID: <20250925094334.2012248-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb2752b-c1cb-48ed-1946-08ddfc180b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yw9SsQAJ+1+0JQmEwNyPTR/fyGShR/i3FBnSy+P9eVdSgzvTNLtiDxf4N/AA?=
 =?us-ascii?Q?4FnbjuvpklOaaOwnRMNfnCqpKnGjHCUMZ4FYaUD4zFegJNVsU8U7+Z+SWNW8?=
 =?us-ascii?Q?NT5Mj0BZMYkOB/1U2uMopcDbbYPg6p3YcMGTlHC5sS+y5bGoWQQTZWmjGKcp?=
 =?us-ascii?Q?WjAT5Y3sUo40czYfFfQAoXU3uInd15IXONn6EYTtAGLVQnVZXhLP7viK9IoM?=
 =?us-ascii?Q?TkGk3ImSPWFkHyTymSZ+tq63w3vdyhSOADtoEm3NTZCXU+XUxJVDX+VTzzz+?=
 =?us-ascii?Q?93+MVNNZbPKmfIkk6XFg4u036LjSpcaCEadutGjPBvunE3eOawTq2pbHzzcR?=
 =?us-ascii?Q?M3zl0A2oazixGAjjySREYS4xj52wv/PCs01wA9XPsMeUVQSFuShjsn69RX0Y?=
 =?us-ascii?Q?fwugDKBHBM74Si8ur08eBxS1fgoZtFyMA9UlApdoBm7lM/anmvSYDW4rT6Q8?=
 =?us-ascii?Q?kjI0MjCzMph4djaAIAu0F6n6kQigJKunJK/9rRyoIcjsExBPW4jevGGMWpww?=
 =?us-ascii?Q?n/HRtlMD0+CajpYDRNCDruQNx01UEwa/jMEAx409kz2WF/rsRGYltyqIDXbU?=
 =?us-ascii?Q?p7zu8QDhhXY3D+eKaQTuyb9L+JoTiLG4fXl8shZt1DerOyI/g480b5lzAfe9?=
 =?us-ascii?Q?/7OwOQECJQuT0rFZtOy+f9iAhRwI7qxmFZl33XjJR9y6+t0xaKQsKwx6QB8u?=
 =?us-ascii?Q?H38XaUAb7XltFW75aI1XM/PSGdMI5qQFQvjldwn4gzXup3pcsxxWoXwItsQi?=
 =?us-ascii?Q?8esTPBdtT8CJo+NLD05OzT/ZG/KpdPdBiPW6V1cCgAgdozI28aT62cGB3RnX?=
 =?us-ascii?Q?9+6ilC7VungzCzBMhrzbMX0Z+HAAZgq3ShM0U7UbU1MqXNQE9a5Rlmntg3VA?=
 =?us-ascii?Q?eOUvmll0LPz0Zvhxs+BrX12c0kQuVvRUnsUXl0vmSYlKhsJue9/O+mPWXV+2?=
 =?us-ascii?Q?UF5Sy6bdhe8zqVrrc6cR35Og8x9FsVgDKUiGw1sxWSbbOX4hz8ZyVWNRmabz?=
 =?us-ascii?Q?RxOKsQkphJMGCW5Q5b/3e0HC7NJ+o+XQilA6TuOMNSh4k6Dxmk1poyuqyD6V?=
 =?us-ascii?Q?BKUcZ6DzWkJwbBBODzfTRb51ipPgCOFt7CCsXqk8zQ6931cQz1+vbS6jrP+E?=
 =?us-ascii?Q?rxjyt+IB/63tb2CVTyi1dNtVsx5v7N4WOLiVwpUw5Ibue3QqwCLvzSm/+Cu/?=
 =?us-ascii?Q?6xcEVoCOs3bpoxPFzrEgeujaGbZDyfEkz2YzYqi6e522Tu/BQeEBooCFKNHj?=
 =?us-ascii?Q?PAbjmdGCrcCtbg4wCvt7K9uR0sZFBsFt91KhAQ7gXuLRwCsjqZoIbR23BQPc?=
 =?us-ascii?Q?ORchwXoDsHD46Ku3P2koiGJ6DgjrmrNGGG46PoMEa1fz+KFDhYkY1aNCeYaS?=
 =?us-ascii?Q?64uaQ6wsaA6WxZn35/joslzhoGSHyR9drOZNg363XggrrzUpk3NskBBWBDgX?=
 =?us-ascii?Q?3RVQtX0hmBwl+LhV/Ps8BLvNZ1UXjyeTuPPk/bpFv9IpIOWLjGmL08P1br1y?=
 =?us-ascii?Q?qP1xWmBx4OZAa53TPtqe6D3KU8RtXFyDoO6g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:43:55.3351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb2752b-c1cb-48ed-1946-08ddfc180b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 89fc1015d3a6..7f02e36ccc1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1102,6 +1102,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 
 	might_sleep();
 	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev))
+			goto failed_kiq_read;
+
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
 	}
@@ -1171,6 +1174,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 
 	might_sleep();
 	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev))
+			goto failed_kiq_write;
 
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-- 
2.43.0

