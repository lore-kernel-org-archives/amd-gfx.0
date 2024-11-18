Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01FD10F57
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 05:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1F710E30D;
	Mon, 18 Nov 2024 05:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVOmaE4t";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C22210E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 05:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdEsUlU73Mh8mEUKegSmag9+Cztbd27p7K5yzpMHVY2m2W5J7XRSxc0QsNU5wond1jve9z8huYsq8c4bESuktyGKevpJ5Mb8Voe2iiVfD10ri0i8sNQBFCvauY/4KIZy+30SGjfQIwLrBRnF8D85Y9jt6sGXlFKem+NiN2DayKKg3WnopuHJOrtiEmJ2smTQLBA76iermF5R8EX/PfMDtrIjzQe48V2BEqMGvVx8feJ1GPYs+bTBn5Z5fz1u50fYa0LqP3aecMZdcf/On2xSqfqLEUn09Dj0oq6MDAftG8xNerSNl9Z5Zz9SrNdDjBd+lxtjv0P0siof6h43D8YjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yiDQmtDWR8hA9Sn0GMhrhZqCpAArUCldQx25POQyQo=;
 b=SUFgW3SeD5lB1Wlz5oHIDv8qQ9te/qbVlgVD5VLf/hAFAQnYZNDr7rw5Qcp9xXKOA8Wvd99ecz/fEism26TMQymk962wm2/2dJY778i+0V4gSKPmmWSffLesM0jDfP7G97DjLzG/IjiAheZQHZQnIrj/GHFll6EqURSttn3gC0qmYuC1PbT4bzejrjc7d3A4vzx7tuZS8Jkq8KiEB9U+g3Y8c9cOcM9+JVeeETcfRQP2yy/lNkBNhJg/LxcUEg+iIli9sq90rnmNHKD6ESiVxp92ottLoQZOjcPlls67c/HWCkXGrRDedmemignPCRPQ3SYbosMkaQEgAaQiMoJtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yiDQmtDWR8hA9Sn0GMhrhZqCpAArUCldQx25POQyQo=;
 b=cVOmaE4tn7XPk5bG4UgrTXZFM3hL1JpefRhmFs+H5MFWB4iYZLSxgPYUynoaH69QIk+LvIKEGJ22RUMVlX75aC/0OmE/6IoqGk7+0sm2XeA64JIXIhNuBlqtsSIeYKZuDDZrvknuXpbaZXnJCf/UM/tH6NVkvlTbS0f2VCwDCkg=
Received: from BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::9)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 05:34:56 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::12) by BN9P223CA0004.outlook.office365.com
 (2603:10b6:408:10b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 05:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:34:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:34:53 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <mukul.joshi@amd.com>, <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Use the correct wptr size
Date: Mon, 18 Nov 2024 11:04:34 +0530
Message-ID: <20241118053434.3382003-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 43178499-2e61-4a41-a7b0-08dd0792bc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tt+kL35BBtdf+Rh9kYItbT/f/VNUmZtOHq15RG6twVdBOznkVyyfBj0yLoXj?=
 =?us-ascii?Q?LoME8bi2ciGk8J6E/uxfvGKuurbYQj0m+0yNhXHIts4wOxw8SUUw5EJh59Tu?=
 =?us-ascii?Q?zVRnBra8z/jDw5QQitDevStwue+7RDGFiC+iMqolkXEgzI1cj8p4gSHSh3op?=
 =?us-ascii?Q?QJuuKIXaQzNoUC5O8UQOu8QGYouJO0IU+qhmhhX4asRqPBMBFbCJVvY0Tiet?=
 =?us-ascii?Q?tnSOSrtjAdO1QjNSA6rnXGPMXgHcg0wBGCgf7emJoRD0Dhz5zJItCc0lA7ly?=
 =?us-ascii?Q?hFqK2qbTt/o9fQL/vwiYHmkFejyufA4u3El3os5YH1WQRWbE+YoNM8/vUdmt?=
 =?us-ascii?Q?wOlP9n9oD5SzVtrO+FjPtjvWs0cdC1DNpaDkLsZbKOKUKQYsg5+oZgkVhLZK?=
 =?us-ascii?Q?eREwHPyrnFNzB0ZPN6pY0X3+ln9QRFHL/7pIH98V1KWVuIQq79viplo5/uJm?=
 =?us-ascii?Q?kKrR7NNHLuYkZs6X6yNF6pc94c6iOEY+ts2YFaim2hUGjZ0ogUEJCw9vhZ45?=
 =?us-ascii?Q?7UiVGoH5DPfWrmp2yW6AIvmfTxbMyFZdiAaUQkOrKU4puWLvwNFaaVZ3ilbv?=
 =?us-ascii?Q?cheSSFo7mMPESuIxI9plwT0Ogo5zPTMq3OHU2o76gr00PfrnPiL+1gJSKwtG?=
 =?us-ascii?Q?at639e6SWWz1qqqQLWg0VJMHIYydx68WY4YBLLeqWvS+wS5g+K4FpyaOb6B+?=
 =?us-ascii?Q?/sIlJC38gmAcOnMnoW562Yq/XIaGyqQ+yN5mPlZoGV9i96wmzZr7/s0JJRZB?=
 =?us-ascii?Q?HcnkFA70s0gpStXJl2jH24BWnnMqC/+t0qTPSkFaoLQWVrQNXJvfu/2c9+B9?=
 =?us-ascii?Q?6TnQVfU8FKiN+9eSqZZHIOyu/GTJSUkvN49IM5bFXwyrQscOX6jYyGOlzjkL?=
 =?us-ascii?Q?7vMT76np6md6ZF03xgypBuRr6LJzFD3FzZ9e8D3etUXmYXu5zaDPQBpxGk9x?=
 =?us-ascii?Q?263x9tip9xzCQEJkvyprSPLjx99kV0M+kOAlIDSzX8LXLVs7zFETWSE6NRmt?=
 =?us-ascii?Q?KBw0fqRsv88Ri6b5sc4X6Vf2O4J62HSMB+DxOfjR8TXA711A68YhoQWF8j3D?=
 =?us-ascii?Q?+j7bztIXWud8S3wpAAcaz5OYlU1kuAQu/b28yP7zsa5FNButiQXmxwfvbMCQ?=
 =?us-ascii?Q?Yokyvc4Y74Qw3hwaubSfico5gdGuN4hQzZC7gpIabMu+62WvQErPxZCfgjnw?=
 =?us-ascii?Q?5Ei/MwehirIzWmcLYI57RAuJ77WETAyK0b/mtQGRT4ZsESYbMVV/jy9OJV7x?=
 =?us-ascii?Q?vKrp+j+9cwiD0BlMVwRZEZeOzuSDCWFNrOi60xvcCAbBu9fWl/3dy5b1eh/M?=
 =?us-ascii?Q?uj7kx+AVjF7wx4hMWYIDREnRHAkDNYGr3bzlg2O5CioY34j8sd1SbAhrQ0Zt?=
 =?us-ascii?Q?JNGu0rfdOtrM6UMDGJDyuLslfOkF+HYX07PjGtTpOs2uVkjEWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:34:56.6372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43178499-2e61-4a41-a7b0-08dd0792bc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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

Write pointer could be 32-bit or 64-bit. Use the correct size during
initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 4843dcb9a5f7..d6037577c532 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	memset(kq->pq_kernel_addr, 0, queue_size);
 	memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
-	memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
+	memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
 
 	prop.queue_size = queue_size;
 	prop.is_interop = false;
-- 
2.25.1

