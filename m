Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80F5CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0FF10E583;
	Tue, 23 Sep 2025 07:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4YKEQQI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E68510E57D
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kefY4dU1fUrr7TodCVTWs8PrykRzPQ6ZY/jSOyfjRTJc4/1FlogZZDAhNnepuGSVVQp/LL9W7qt3V7pv2O7flgiz28YM4uf76TeHAn66pZ5w1Amf1jwoz3IIWEd35qekJf7Z1ZHP5gsYOWasIUiRMGNpnhdM9PTAkt0+OISwf5hG4ircMrvAKn1KK6aGMhph/x5XlEyNeD9obiaALgUjaSJmCIzI7AhUuzCOwoL2dnsOMxkkkt3rr7Yj1bLY0YhbdeL4fTUiCcm1xfWqiATl9yZuK1rD8kRVvs2IaKMuRLDVYYrUs4uSGNAJyYZenV4dwc3x8TVMhNIjnNK2aw/6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=443/uoIChGXPyJ5K7HKUv5RM1x7Vd2ZPcAvXkFdBa7Q=;
 b=C2MVbDbnAvBvEXvchhq65NBc4XzugIpOKt58DSYtdcUQX+Ggffi5VWCdYiY5t1zVVCRPhSs1rPY4IWjfAmiKN7Vcnt/J3UTEsQ8cJOB2qDk+/WEXYp92IsoIiqXIbrFTLDXxcjkXlmSrqWs+5naBuXJJRNgPJZ+Mk/2nPFXD4Ve3nucckJQktKncm9SpAfxZvpSV82PxfBWbbXXmGLq70nBybbYDRbS31FrWvGBq8Id1tzJcdyQPu2PO/a+HPTMhehNL9ZMXs8NpVs852XsgdTOlKHXMCQhukiBHfmH5tULJURHx/TnYoy42QyIQ3K7NP2a1wtZ2R5PDmGZQi2pZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=443/uoIChGXPyJ5K7HKUv5RM1x7Vd2ZPcAvXkFdBa7Q=;
 b=H4YKEQQIKLoPy1BTCrp69xbtnv0RTFNKCM8XodaTBX1fyFwcHl2pS2MgzKO1sqpRXle2g5NRc3edu+B54RNsZwqyRVoSvjir8EfkqzpsqAFz/CgQ7XmkcyfY2Er2ulOpldhCJg31jyvZ4YneSxJ9Iwcmwzb04mvS246hN915Hsw=
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:26:54 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::66) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Tue,
 23 Sep 2025 07:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:54 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:50 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 12/18] amdkfd: remove test_kq
Date: Tue, 23 Sep 2025 15:26:02 +0800
Message-ID: <20250923072608.252345-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: d75869a6-c632-4453-eb94-08ddfa72928a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wTyKAVQaFuxU3w3QIjIN/ZdKCpKguPL87GF4P8ax6rcc5xGwZAI7TTg5lFzV?=
 =?us-ascii?Q?DZK6dhGAfCfhz865+YzzHlm7nmNI5anNJbWpXP3GH+no+YAKxJl7puLg10h0?=
 =?us-ascii?Q?YuqOowfYCrEMw5kSAr3IbodGnMGOWyLaBWL3V+FNip6fvd1FC/APC5JA1F9R?=
 =?us-ascii?Q?/NbHholy7+qPAw7VJGvUEm6DLPrmk7aGPeW2VeRJBC55QKyI3vIv9JhCiGys?=
 =?us-ascii?Q?N34JNYylYTfvHXTkgJ/YP+jEfPWIt30xHMxXF/DT+r5dSkdHVQlpdbKi81lK?=
 =?us-ascii?Q?Wnv5Hnuv5qGKe8DPSAu2IrZ+udJjRZdzh5ljZXkNfpQra+G1pWxBMCvQnsLk?=
 =?us-ascii?Q?k9shtHKFSZx0H7bhIdlTtuOWXV4tcX2G1iec8AC3LhjF8gZMaF354HUhoPtM?=
 =?us-ascii?Q?Br0vrk+qJS3BaX3MBbbE1CPk9tb0BQB3+cvCHrI581haKgW7cEczZXh6aGUy?=
 =?us-ascii?Q?q1qSyFSE3e/akzP7ELkCj52Oo+LZtg1gkvAie1j0mSXYBcIGUegzEvHUzX7o?=
 =?us-ascii?Q?44Hk3HzPONGeiMuEw48otjqpmLjfoczq3dGvEnHVbLY4sypZgEEm2R7XosoN?=
 =?us-ascii?Q?T0ezODgrJ3lhKMisQhVdzgoG5fHKlboUuxCcTp9OxJlsocisDqhQROJUrJ1E?=
 =?us-ascii?Q?tfUVLMphAnD5zDY87GectedU+GEI+tZ3Hbk2Xp3d/MBYrOWPYA8XUpBiOIWQ?=
 =?us-ascii?Q?ZRoo3jq3c5XJa/UbQ0PsAIBn4xYZhBBvKDpoNgZgeyB6sKley7demlpzmck7?=
 =?us-ascii?Q?Mq1gKI0ejoibDP3ua+jUrUPU5wbMHyvk4XwYMXDxrTqAG0JgL1e2/uRMgMgq?=
 =?us-ascii?Q?J0o1u1TRsjqBBd1pgtDQitvgdrPK1onIrwjhWVSC1/m/3R6FEGGqsytU3i5k?=
 =?us-ascii?Q?nYPaCG1IGIeKLtr9/SkB6Ncf+M0ogeJ7/jtlo0la2pWYzo2w0BI3V5pW+a0s?=
 =?us-ascii?Q?9xHU1v7VoKiNwDU1/iTJy6pgdB0Zn3wK47Ha4AYOQjFtR3dsXI03C5M2FYjl?=
 =?us-ascii?Q?RrAXOU0DA25XXjdIPDWn7LgRxrATIFvT56mpKUORVbzUFO2GMa/4afcGEOlT?=
 =?us-ascii?Q?X6kKngdMbyyVDF+jg7NBGLoEZbmn6BbWvYOdNLaDG93Bda2mSil9BcjkymuX?=
 =?us-ascii?Q?F3dikHGVyq6RJL09F8jaJD9Gl0KCrdIrQ7tv5/bQBveLoWh5Guyz1aXa3bVU?=
 =?us-ascii?Q?0GOTd2hmOb5EwDk0MzwMlhrUzcP4GCq9LgjeCjrUfpMlVPEBDrFuV64M8BkT?=
 =?us-ascii?Q?+ByrU5p7kaB0qMEut2VFL8sFYQ5iZAXjuUO9wxapvgplE87wLaT7q6miOUjk?=
 =?us-ascii?Q?rDjsfJXQrkOZDq4fhGo1PWW7u3bMwWu3KobE1+FZihaJsxbuSiBAUMiKlKvt?=
 =?us-ascii?Q?D+enfzS2tza0fK5ceHOxhxvRr6cCHXGYR412PTRZqYUHq96EfQ0VezrJxoSo?=
 =?us-ascii?Q?nMAyexINdd71ZCX/vUpaXOlU94D5XZKTks9zx1o23XG6w108cV5pTvfIp/kZ?=
 =?us-ascii?Q?I3e9qVL/4//xWH/c9eB+UuRRnjTC7UGQr1+g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:54.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75869a6-c632-4453-eb94-08ddfa72928a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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
index 0a4f8e8dd77e..887cd7f2cd65 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -332,34 +332,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
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

