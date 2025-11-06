Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252CECCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C5E10E80E;
	Thu,  6 Nov 2025 06:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5GJFiwl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A594310E80E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx7HUYJbfbWwK4AI5g2K1Kp8WCdeYioQljjrIeS8S9giMQYjJ39kd5RJyvbQOd/CQjrKA+aqMvDZuakwyXAO6HcAOelHZZEUgK5Rvwqx6wsApkAn8JKq1+xEwDY/zIePDtvAaht3cmNmb5IHxynezIWOsTDOz3zGxYVs28E/bzMBWDquxN6PwTL9dQtNPzyUak15L/SlBNK7rB9/klZoMXPgk/OlseRt7v22cUa+0dGbUMKRKWcgsxl1GYSotue4cPyig2DI88wytTKYn0RjkKeAEVpbK6AaBhOdwP6FOVrKhXOlwCSHZo81pPC7FzsiWlGetCQoVTaC3uCQwvS98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=QBnFf309Z9JUkr4SQaVjedQ4j/8IZLJwMfb59FiGvqUOvfYPY4Ajikf1U4CnCZjU/NRnw+27D79dIcjEJiUrTlu+2P4+4JO6fUuzbYPhybTde3+aXvcH0gwgqPtIG0yUPRopKHJbaVD8XRLL35knoxyWIVwUy0Ui0RQ0JAINAdAUn9m+0aaejbQffDwmyAu+ApOsJFNZ8NZXVt8XStb/S00JekV8Lbe2oLumC+e4mPOJctZXv0tcicTkG5AHcv5QxPNQYNhsqrF02U9k+9DzjbE7Fvz+H55O9Nxvl5LpYxFO3ZQL6OZpKdVaF7PALDzsGtdGbr49y2Bzs/kQtFglBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=m5GJFiwlah6vzA36OT1n9ctPPAAPt7IIMo2+rm1tFCX9TiiCm8jbA7UD5cl6GJEm2UvxIIw+8ZVFdTFoNmZC4qJvu1KfB5Rs5B1Ztk7Wm4O3esfahe4OyzF0WVKRD1iL8LiTTpRYULzJJiOIJ/ToD9gLQuc3BEJoWLImt8XCVrc=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 06:08:27 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::82) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:26 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:24 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 12/18] amdkfd: remove test_kq
Date: Thu, 6 Nov 2025 14:07:33 +0800
Message-ID: <20251106060739.2281-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: b3139b3a-255e-49f1-1847-08de1cfae662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltRHTsqjhjfyQx3HjwdJWS0QXVsa799kCPeJxYqOsatswDpx7neXT4YFroiw?=
 =?us-ascii?Q?b3u3gqK/jfnRWsaTSkfkUdjleI8kgX0UqlshQO2ofd4bnQ51ffdxLNqSncov?=
 =?us-ascii?Q?5Jwcaep7O08uQPXY8CQIBrvPV+uyXr01u8HALwzkehz0R5YvD+oS+Ers/mY2?=
 =?us-ascii?Q?shUMB9RWa9jNqjSJIoawrnRG9P9ngcBL3NuPYXUG98At3Im9wDeb/aX6Tq7t?=
 =?us-ascii?Q?oo6eNjjWJcHvta06XiVimjkw+aWdhd/MH9MNufe58q3yaSY9w8+kCa3rhWMu?=
 =?us-ascii?Q?paLm9ODBXAJtD5DG+171f325BJn6Xu1/4AbzsNfKEEVlVY643m5qmiEgLJU7?=
 =?us-ascii?Q?fcMCfCG3a5sVLeAO9ksAiPlmellNKLMoTNJlwcG8W4uiW6zIDHI1Lj62W2r9?=
 =?us-ascii?Q?b/moVb7xH2fbxylQVKrV+DEA57EGuuzTx4pKbWXUTMu4dmXoB3xwmtFK4ayG?=
 =?us-ascii?Q?0oQUa2Y/wu4j52nvh1mtjgOgRntsG8eY+DcQc0YX0P+7d2TLR8GpP1GBP/u7?=
 =?us-ascii?Q?s5+V3AhNicH+IYcQZkIhqykFt3SntOU+ka3fItqklPkdPE6tacvvPycksnPz?=
 =?us-ascii?Q?sLQ6LZn6zoP0DSwU8/wP0aGXvlhf5G9ee8hYb6Y50vpLqYBjskeK6zQvrqm1?=
 =?us-ascii?Q?jxHG5YcgqtD46pZs32Ga936ryCHOu1434oj5fsSnyZFKYlZUhpbrtrTN8piy?=
 =?us-ascii?Q?9smFrXTg7NGYq5rVzk8iGI2uXMpxQM2rlLZkv1ejghAm6J3k0GQV+Fg7q0hY?=
 =?us-ascii?Q?kyqYXmmgPat6W876biRzcv9ZVfpTptgYU1D55yELoo9eJxPdMU+8/N5+9ZA/?=
 =?us-ascii?Q?BxG7LdjWo3pp45v5puMmXgvIeBvLpD7hnHwlnzyS02gf3ApHAz8idW/yzela?=
 =?us-ascii?Q?aVqKEz+jV8ZdzuRn3eo+SwLzUMDnX+qmQKYip9Xj0zYz6gHDZGObje7oNUA5?=
 =?us-ascii?Q?WrnzOvxZCdY66gidalO36Af3BDeyFiU+6XTcUsEsSxQs2R6Y+hdXgKhdegT9?=
 =?us-ascii?Q?+deVlImKgnnviegbOJV9osEI6oUYTnPZYPywQkeg7Poo/G5e2iQ11PrwBW5O?=
 =?us-ascii?Q?p1i8uA6zleG3mSBNiVbPAjIgU7caXMK3XXvj0S8xC0uNwapEtFt/NdHJnOqh?=
 =?us-ascii?Q?aTkHPzWdzLRxGxQAbKaH9GH9SOPSvP9GigbYX4bclriy3fUjq2FqjsdTMUCe?=
 =?us-ascii?Q?OQ/rM4hW66F2+8vPdXZMQGoIfy4cSs3EX5swMULve8YNY5ja0rLe9iWJYWqC?=
 =?us-ascii?Q?mvjmi5XOsDnhVM7CB9nOEzHMM9Gud80lUG1vCHCfK17LbgHT9i3Gq1bLADxe?=
 =?us-ascii?Q?GqjP2XHlltvdj3/LJUuEbemsSPUb+p4THPu441Rvz2nc7gYibYZmyZfgTvDK?=
 =?us-ascii?Q?ES9K4D2vckYqTQXkSllElPAjVe5nwv4WI1mImxBCESoAwDkdZNlq+BvgKqpg?=
 =?us-ascii?Q?wWf+h5Y7QSHLzu8CTo2StJFR/yHV13uVng1RvIVPswoXDOjWZvfmhQKbVJ1d?=
 =?us-ascii?Q?X7izk6w5ydDZOQbpYpvAV5CFTW8uEVORuhc+8fbTd0M8OyakQmqllZZ+Sauo?=
 =?us-ascii?Q?Mbe/M29i+N2tEFBDpIc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:26.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3139b3a-255e-49f1-1847-08de1cfae662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

This commit removes test_kq() function becuse it has been
marked as unused since 2014 and no other functions calls it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 19ea759568a6..baeabe3feef8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -327,34 +327,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
 	kq_uninitialize(kq);
 	kfree(kq);
 }
-
-/* FIXME: Can this test be removed? */
-static __attribute__((unused)) void test_kq(struct kfd_node *dev)
-{
-	struct kernel_queue *kq;
-	uint32_t *buffer, i;
-	int retval;
-
-	dev_err(dev->adev->dev, "Starting kernel queue test\n");
-
-	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
-	if (unlikely(!kq)) {
-		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-
-	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
-	if (unlikely(retval != 0)) {
-		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-	for (i = 0; i < 5; i++)
-		buffer[i] = kq->nop_packet;
-	kq_submit_packet(kq);
-
-	dev_err(dev->adev->dev, "Ending kernel queue test\n");
-}
-
-
-- 
2.51.0

