Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F99C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B90910E43D;
	Mon,  4 Aug 2025 11:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gsL8MfI1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A53210E43D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTvdg6sxbpVw/JfxA0cKVKr31nDjBJBqU+I1laGnkvPGKjXEgyzOWvBrfXJDXFDMwsorRobTywtTrQ6mvzJv8cyf/xwiSCe65rsGRHKlsHPzqq5TP0N71lQYi55Z+ypQBmok4zvqSrMBOv5S9jdY/b4NjqWs+Dpl0f7KmS5dXiJbETm6admmwG/RQyJS+qKPTBdsQb/yAW2bT8syfLOCEZurbjI3S4HYRNAk5yeHavlA/WzwSqQKas1v81nxGpoo/5F/ZpE+riSLIcmnnaD0ApRTaLP1yguuBzGLhcK75Glzf4KNP/6qhZ0qDl9kIB3Bz5ZN6nuJew9ATHxpSSNZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz/LLX9OS/OPiJS2BtxaccvTk8WX9CWGYUgATsh4mnY=;
 b=cnkYNhL2FNTCoOzKswtXL4xw68bJz2hhjDfWV0Tp+OE4kynqHPwRX5lW+QAzPuCPOVHv0cZRx9XALamKdz+wSpnzWp5D1sZzy3PlkQ/UpnbeYC81j9RZpblz8qEUMRBWjN/Ymfowo5ngchVfWOjltJEyx3iKlWBZoFwZkEFNOEA9n07SQ2Hk7vCGqvSZOni6PY+nmw3jE6n10pcpvQsRmBrrmeEN9Z9JJKM7Tqlzyyu81bvouqXDy9dQqdexXUm/OmJmuLa7bdwl3qxl0lYejGpNlYX9YQh6CS1sTnPts1B4QEpdhpUeBmA/2td3eu1kuDniIPZP4f56ddl6In5imQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz/LLX9OS/OPiJS2BtxaccvTk8WX9CWGYUgATsh4mnY=;
 b=gsL8MfI1hi0EbOgQ91Dv/nGTICrPIVsWJPGpZoa6G0wCmc8D90jb7CCBkhOtgNrugXTCriue5/fZPI/0bqCJkGZU8d/VY22nPeep3Guzyg8T0Noq6LJamIYwL8IdEgrBprVDujMYgA8cgHAEIoGysqoJkuPop2wehtnnZhe+8O8=
Received: from BY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:a03:1a0::30)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:51 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::c7) by BY5PR16CA0017.outlook.office365.com
 (2603:10b6:a03:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:50 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:48 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 12/13] amdkfd: remove test_kq
Date: Mon, 4 Aug 2025 19:05:49 +0800
Message-ID: <20250804110550.261311-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b71f59a-05bb-4674-b62b-08ddd3470344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a3bxymR2ONTq0wP/zXPw530euBPETlhxMjMiQnAW1e/cBJ3PzpQHs/amKIzI?=
 =?us-ascii?Q?lEfFNHuZZeBPQpHcIedybPI8lsX8KEgR/huqLqNr4sNxXwJwUB+fU4B6AF6n?=
 =?us-ascii?Q?IadcvP26vkpXkAGtVLmah1DHGsDrt8E7awY2aYSZeCZ7J84FlkcX/xm0mWrQ?=
 =?us-ascii?Q?zK9bck9f4cvassrwV9VQ80aeKoknkx+Y72qxDIDraY8XhD6DXMYk/dOTNl+x?=
 =?us-ascii?Q?2T5r/xuf7hR2tyAA5PwbplIMEXGVprg+7fj15luu+Udp9EiDoVZCqKQ133Jf?=
 =?us-ascii?Q?j4vN+wsLvvt0eeLnVY9YdNPYb/g4LshcdwZPAkFn8bLVl8UMjRBRJYWXAfEL?=
 =?us-ascii?Q?kBU6tbjS1gF3sF6XZV9xzqVb8DvSKS7yLPblreV8daeHSki5qIOcfJ2aCKmz?=
 =?us-ascii?Q?+OCqzk+DTfOU/GiBvpD56cv0FsFZhcKf298bv8vKaGeevW/+Ik8M0w++M881?=
 =?us-ascii?Q?k2A7NgwkCgAMCu30B8b7yoKPZsIZ6UO9hWTk6bhelJhM8HteChQyGyoe1sel?=
 =?us-ascii?Q?j0LWHeGK4fpeF4mxyz6l2ys6U7osWUVEw6d+n+4rrmjh1F4ZjTfu18T5X/sk?=
 =?us-ascii?Q?AsWtzkX1w4R8MC3Snbul2mNj4V1cPggVU+4EkjweHm8T1ZcpokWKjkJJpXEw?=
 =?us-ascii?Q?Ah74BL8XcwhDPSYCJJFDYtTjvE5WpG8fMnsRP73ov3v/Rm4OmTysDIU3PvNA?=
 =?us-ascii?Q?6XNpK0V2Ci4nZc8jDYzifYxD96fGMKCbW2nOiuPKahK5l31a4qdVYRXDILXI?=
 =?us-ascii?Q?yPPxwo7n62tsWx+WbbRJne5WcJHFdS/IbMIT+0M5RfzecjYnax6ONo39BZjP?=
 =?us-ascii?Q?k5JJhlaDQheKwA+KZ0KhgJ0uoUdjtB2cu4Qxvk6Ow0n/DEddbp8WqrFeOwJR?=
 =?us-ascii?Q?qgLV7pI26/UWGsNJEwHdh/4g9ttY4plU2P/cj2477Lgjt36AwiLuogveCvRu?=
 =?us-ascii?Q?0Te/5zEzlE2tJJetCEhlK6qoTz9tHdGzzVyVmagShmvlRhRj+/bTeYexIERG?=
 =?us-ascii?Q?x//1qnJADypMzUMqouTi/bBP2RDIKJMsvZTP3maXf8YFs1ovcXGL9InWe82R?=
 =?us-ascii?Q?zCzcq+tkzP0iZUWOvGQeRyQfZE3SuUVgrtgMwMOtPeFrYQNtjAgLvlBcKnvY?=
 =?us-ascii?Q?K7q1ykX5qFppNYTR1LvJiRWuJLKXQxpfnKkIMEPwjZbLPVS8H+B3aMKmZ8/Q?=
 =?us-ascii?Q?45bmm7s9/aCaoZ7OOlFWCvJycYZzupBsa5j45KIFX+QgeOa7e5zlWJ4XImRb?=
 =?us-ascii?Q?GryxctMv8IpJM+drqcw0wHgXCTdSMQCWZvTx389BL7Ri3Do2GYQIeMihVxQH?=
 =?us-ascii?Q?kcWYmdgW3MTmrUVR9ooGXzqjq1cGHMdFDPxccNAR+m0SpOZCS/N9lu4Hm/QV?=
 =?us-ascii?Q?UJWY+rtgltparardrHt+ZGpOnaJ8cy1f6C/sJu9qV4lN7vx4j3m8se7d5Ywu?=
 =?us-ascii?Q?CYHbzN0+1PCg+hwNy2GAu5N+NtiGucgH1l5Cpq1lW/ewxILqaHDisKGvLrQw?=
 =?us-ascii?Q?TFXM+9odRNzLGVYn80FS1NzE9xdtNKoVq3zr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:50.6114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b71f59a-05bb-4674-b62b-08ddd3470344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index f676b7419984..6aa8b0348bad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -339,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
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
2.47.1

