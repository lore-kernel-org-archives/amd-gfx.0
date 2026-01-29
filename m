Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79546D6B06C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 15:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C64B10E887;
	Thu, 29 Jan 2026 15:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GG9ZgkM+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F80810E887;
 Thu, 29 Jan 2026 15:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY4YmG9dnNhsOUxzwbc3TtNbLppyXr1jOXcNXMsXL0r+lEL5n73tqDbfGyofXBqBKvNJJ/7RMR6yDIEzvcn/c08oYId/c2CvIJkBCYdB1WsVT7jWkXq/CjmcQwAQUi/beLT03bLyUfWctGE72/Wys0PP6yRUmfaG7vk9ws6+zik+F/RW4lHvN3PMmVzw7TAU0G9lDNrMW5YJl+qwGDJai70u30ipsdjQ15YOaYJ5USca3PDnsIwnKGt7AtHHbJ5ZcL7BRzMbetQ5xDQwznj4a9eCTIXOWPi/NHaQsbqLNxuO2AVynbT+T4cFkwkrV2o8ysACMoF0jXKmo/GfG+EKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtWRTlNondbu02dtqv5/LeKo+MJQUZbUBn93r0EX5rM=;
 b=BFbhCkggpgsgsq1Zo6KJiFVYVAVEqpW+EhkNX1+4fkRBuR8y3jCCGARnZUyntqCLO40cGaZVLWJdEIIoFzHmBbO+1aRarhJRgrb1OUP6oa75BvsO2VxUFw4TwEydcGyrIpwExxfCWVkzZ0TcsHiPZRHY3SQTMPrLZmXLpBWLE9JRLjOOEYz5EkB8gCs1AVVb4Unra8Jcx4alEIoe8djs4oQcQi++PyX2hqyJ6cafXX+CYKPeZGCk/LB5NU8CMS5Im9f0f6MnR/vRELcG/xTimHbZTu5MQFX05S5l353S/vbpg6tlDE5WJvMdZk2njv60rwGPLERGjuIVP/2+pX3beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtWRTlNondbu02dtqv5/LeKo+MJQUZbUBn93r0EX5rM=;
 b=GG9ZgkM+8KXr7n4SS6kscOML3zAXGTevm3N9VWwuP9ZrWj522au2kwR8/ILaflNK4t0vl8Ig/8NHnoX8A4mFVsJIxoemeBVcGnKBuCaOQH3GLCxgDoaAAwuYvznz+cdwWfu+rdk75E44KZif74yAkXPLcO7YEjCCSOCEVBXzMgk=
Received: from MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 15:35:08 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::1f) by MN2PR06CA0024.outlook.office365.com
 (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 15:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 15:35:08 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 09:34:55 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 04/12] drm/amdgpu: add amdgpu_gtt_node_to_byte_offset helper
Date: Thu, 29 Jan 2026 16:33:16 +0100
Message-ID: <20260129153336.7473-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129153336.7473-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260129153336.7473-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d915e9-543a-4ba7-1c93-08de5f4bfb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TsK28wiktTDZbUlr+zcr9xwL+pL8PwDmhaXX/w+/feQKu6A0/07DEgl/ZzO?=
 =?us-ascii?Q?7dv3hcVXrL+Dr8pMPYOXx2YbIGrqACfkZlVaROkZfeUMrcOjoavSeXvGxlAp?=
 =?us-ascii?Q?lKWGQlXZtEFeOFbmY+0evKVbXtE7KuuwUMW2iK8iRhuOhKXV67M6WNeXnGNU?=
 =?us-ascii?Q?ebcnzucQ7aTet0ZDGQ6D2hyyThvAjB3Qmy//XDF+3qPR6mdUpW/kmxW3n1T8?=
 =?us-ascii?Q?erm8Xe5MsmupYpiy/3eP8AhN5LN3zqADtALrZ2efGXhi0sfeA/8Y2aPSPyF8?=
 =?us-ascii?Q?adPifX/tgg9YCfNAre0UrLButNXgmwmjtzexLl1mPJpf5yDfWmlNEYkPhd/V?=
 =?us-ascii?Q?Bc+cOc1w6Pc0El5emsq0dqFU7nNNZMwwXaRp7VCHjGYU3t+VzDQvGg/GBjIq?=
 =?us-ascii?Q?XV51ew0g9EZuli6oQ8mYN5lQiNxnwof2Qkc281oaQzCQDvRIzjAsMFsYGxxr?=
 =?us-ascii?Q?kdROmg80wBgrO8n+xfapiMM+OQ0oVP/1sTjiYzEAxOlROFTrPTK3b8xIwYGs?=
 =?us-ascii?Q?j2h03iFmfPzFwfAumc+FY+vWRLdqErPghxvD8sRfBQ5Z5bWuHMNpkhHBqJp7?=
 =?us-ascii?Q?xFAzSM2fXDoRqzXj923jI61zhph7De83HSca0DcSgwwu782nO8kQTQS572qY?=
 =?us-ascii?Q?0xfJic3wM/tYaTokLndki9rYp5r58Te1JwCTHk2BqHypUvyEy/aVK0qOEqHz?=
 =?us-ascii?Q?mxS7iVPwBFwN4yC2aAj2fWEhaGjN+U+ZrOYtxwERiiWq3q9PCb/Gh00rK9P1?=
 =?us-ascii?Q?0f1k5biz9v0QIUyXuMM+zVjf6BNcECZQTw00GOsYjJQIUgJo38pZbM1aa9SA?=
 =?us-ascii?Q?m2/7EVV4SZ8Wr58cME9PKgYiC584PdEhSxCaukvOX9tIPzBYJINCcUe8fUF/?=
 =?us-ascii?Q?0mvbnrKLOiLflChB+Ud/PWG3VSR2tvF6GPKxcjEBmjjdgz25DpXUPrFkHyvQ?=
 =?us-ascii?Q?ZYQO+lJAeepU5qLfIavutOdXHLxQ0qUPb+7SaOjNetfxjy9Kt9IDxmRXx7Cg?=
 =?us-ascii?Q?ktzcfuKYkEIK4SwEiNpw4CwRSv5+JM2nuHvcD/gxJ0agddrTkKSx7RwoFo1k?=
 =?us-ascii?Q?kEQxRC1cEZJjv4fIkcF1FEQpwQ0a9WKbDp3dsTiG5x6JxOnSMQSqABkKBHhb?=
 =?us-ascii?Q?DR4e+/rtcpr0zj4IxVTc4CkjurK6ARfT0HRQjorhbirKkus8kSWZSpbiYvQH?=
 =?us-ascii?Q?hi6Y7rPb8rZciaaVKqZMf7GgTNHWrcmHK7/Ej8srMUhuXA1ixvBBBrNk6b9o?=
 =?us-ascii?Q?TvxTai8g/FTFdm4ohfqZafZ16nxixD09WBTI1I8FJ64uBPGx8e3Ee9KUX6hO?=
 =?us-ascii?Q?7jbZgSqke1XKkfWE9HKITdKPBjhIKbJQkx3FIEGH6rmHqlXvt+Dsyp2qfXkP?=
 =?us-ascii?Q?myVn1Ksj4HpykV7BgmrOLmnOVTNlp3K2jPu8iGmRqgS9k8uM5Ms2W/ZRKqQC?=
 =?us-ascii?Q?+qeZVv/DUDB9XpAEjyCXw5AQ0WGll9j/iU09fEHqpqLIh8P8BMJiBM0DNueB?=
 =?us-ascii?Q?LRv4hCIfCOWUayCH9MGeuw1C9+4h3G05vKXC0bT2boXVWNWRm1d1P5+eJuGu?=
 =?us-ascii?Q?k7Pe+99SaCFS4lJPHf9YlVfVwZ2OH9/SfJrZys86/Gf74cMc/tfIj46a7Azm?=
 =?us-ascii?Q?xfarC8QvVhwKiWuyy+8k3cRXGFqJMa79JJouk6B3bnHY7iVatmMehpRuclwo?=
 =?us-ascii?Q?2Ui5Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uF4QOwvOdhVXUc8vQd51wAN9KkuLRWHebrYNy6GrOC5lnEK7Bsjumlx+M6vZ3BG/gr7BGMQZ4T2fmn5vZY9BZCmEwnEFO6yhJ3v4s+W3V795Lgm+i8bNNOvzouNYoCA351hrlI4fooXAJ+VqWCIzLaIrGcfcr4zcYuoY8Ud9cw+OoL4aphNp+KlSfQHeiFClxiMH4q7JEfWgojsuD4zeEWvRbIA1afn2Z9XxANb8whySw1oSsVRILYsuArKWCTQx92m4ZbeO4nRUMa+lCjo7m6i6QpS+9LLSHnb+RV5IEPcSmx0Gxr+8oxHrHv1h4ac6o0jY8zRf/BXf2L+qVKYeelRD4Ax9YmLSryoQPicW8M1QOfqjjNEWylVKc6IpJ7UmmwTtovLvAppd9iGtIl4Wj70zmDsDWL+o8iIP9lDrdJM5kgLWRjxZk9+T9abKSpLa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 15:35:08.0850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d915e9-543a-4ba7-1c93-08de5f4bfb96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

Having a helper avoids code duplication.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 871388b86503..c43f352df953 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -220,6 +220,14 @@ static inline u64 amdgpu_compute_gart_address(struct amdgpu_gmc *gmc,
 	return gmc->gart_start + entity->gart_window_offs[index];
 }
 
+/**
+ * amdgpu_gtt_node_to_byte_offset() - Returns a byte offset of a gtt node
+ */
+static inline u64 amdgpu_gtt_node_to_byte_offset(const struct drm_mm_node *gtt_node)
+{
+	return gtt_node->start * (u64)PAGE_SIZE;
+}
+
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range);
 int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
 			      uint64_t *user_addr);
-- 
2.43.0

