Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8457CD8CB2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 16:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6132710E3AA;
	Tue,  9 Jun 2026 16:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="btoFEW2l";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF5E10E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 16:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLPW3mJXR4F/foRaNegiySbzXPP5wvjdgCBDkh+NtdH9YI0Azo6lmQ03zrjclpiTzOCN6al7lrOnJDBNHxhirTobh6NjhQsrOs3Yxyre9JeL2SehNLpi6VyTU+dUoqboWLmDgqBgyJXCMN0qaZQQm0z0fybJUQRKVvyHfM4Gm3PyXiXl8MWzwnqWdTiomyLBZIAyahTjAb8RVpew5dNDVFCIWns2XbuZIwFwRa5qrOHrdmc49wt4mS+oZq4zZCelo84geSbdKm4OjkuvgARn+S9Hajdwm518OZgzNwEOqxEpJYk+acEdt4S5JCQYIPMSqSK3/tIGla7iy2Ear4QlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFGFzNXe9j42maKqOFhspGz/zNki4p4V6cdQEx6TBAE=;
 b=vVCjIXEaN0oU+jPqxXXnLGEfel9/wsgA1qXSqhNbIRFMgQPbK/bQJRT7d879mjLxYxe0bkW+US7vcZ3X/tj5qEkrbTbRHIlHyRQIaw/QOShxQgi2SvWtrthMRo8yr5Uk5q0za2PH7/Vu1GHYBPaF8MvBxgwbHSE6Dc9VLWDD769UCqGpyZYOFc06rZEijHH6A5bRYqce5Khy4OJ3QZ32V0zSK9Id8isjh+FCxEfZzOXI+VtggXu/WDXlHPt8vt8KLGQYKKJFaXv1wmReFzdQYKzbQdy5QmmvMnVSkZJ/RT/Ppo1n0f4+fWrV7HKXZg92GJucarMZXQZCDGgBUTXbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFGFzNXe9j42maKqOFhspGz/zNki4p4V6cdQEx6TBAE=;
 b=btoFEW2lmmOP/9Q6MB48ydnTiUN1lxv6+oVnN5BLy8icnKkVkqO4Tbqy8EbVtuB4IWEbU2So4Bb8bz6CRIazGIF7CspZ3EB6cqUyay6xjWEJwgmkG905+Bn329MLiuMsfCmCh0v6t4l4Oo9HI3u8YgKz/w4vcYbawePJ0VIF0Hs=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:47:03 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::86) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Tue, 9
 Jun 2026 16:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:47:02 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:47:00 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>,
 <alexander.deucher@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Fix reset event signal
Date: Tue, 9 Jun 2026 12:46:43 -0400
Message-ID: <20260609164643.3815222-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: eb254c5a-4379-43ad-8fbd-08dec646bb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: N+aphimwPGKzSl+p7kmTfiGBQ7pQjZzROYFL/rJeMco19af2fSR3WzJdR106FgAumVufQ5LqS4oj36EZ94TXhfi58GgTCyQjqPpDPzM9rPF5Wr3tnWowxYxj9GAnYvGS1BNxKjQT4/MfxGim7c1KIHvVEQDm9/BMW5TCjsbadwaMAz05OJ1Aa3Q3LqOQddfMnkdRA4fAyTJYmSZ+tm7T7QMG051aIakoAwh2HHmztXHFBjL2Wg6eiK7as1zdNHIg1ujaDH+ho1Iysd+q89UZEZytZdKiL+iItPifDqOffQbHbQyq42M+KHChP4ocayDvFsuJXrON3A48pE5VPrOp45A1Mju2JPRr7BL7rNbUJ29al021kerB8exaiHuE+CfQIo5ay6qseP4Ab+RP60CvYujpr+qDw9y+4sU08taruQzPKUqyYeIYt7V4gGXm/qBx+mjE851k5dI/lJoLR5euwdBk7ml2+Va1TIEJ+qEX0WdqISzvS2LSMxIiS5Qv111+bR2qA51yA6vwsRbJ+eBcaERAxHUkHw073OeDJ9R0IykG40EUZw8Rv8B3Zm+/TLvZDhEbO+ZFMp9bbe5R2tf67CxeVj107O4a/sE7buVId+bVcaR4s1OvoklnzO9PG4c60B641LoP6VeqJ7F9CSl/aTvATR1yHbsvwyspLiwfCbNpHVyQn2QifBjN5UKaQV8BwdW+sl1OS+xacjHMHLL7OY98aMqKtx6CLzVJybodikQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ys99c6HjeIkspU4NKL/EAcjCJxM53wP3i5XhR14vfi89lRFnUJRQoP+e2Rzfyzn5M8M1ty4i2mKpC1eGBNru5zNIWsE//H82tY6zSSo1DXM2K3UhxxYcJv7JbyRDY7nXJFnAl4M1cXwMHiZPfeGnJKoU3E+LH/wt2MO/n6NNZE3JnVx/qNafRONNU/88s2dkaVLKu5ZfTNC7hJAFcCpqt207qMvjj2hXSPVmsmbtniTTHE7oNI+eetEm4pHO021PsBmVbtpN/VLuACgRg2N5SP5rYI3AYmT7faWLhVNXDaX0jF8cvQRTMqvReZqcnD5ozTAQa2tpSoL6IHjmmtM2tSWKGD+HJu6tTU7EikD124Yzzz3Ein/H0ZAJFuXKm1KLSSUqlnQmnnuvwnBofSST/u2jCfVlgJ/EPr8VZ9oVViKBDoSWL7g/YgUCYoVFLvTq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:47:02.7088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb254c5a-4379-43ad-8fbd-08dec646bb74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

During the KFD/KCQ coordination rework, bad queues not requiring reset
were combined into the rework and generated wrong reset signals to the
process. Fix it by adding the reset check.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1d12901d4823..828a7ce6eeca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -474,7 +474,11 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 		goto fail;
 
 	dqm->detect_hang_count = num_hung;
-	kfd_signal_reset_event(dqm->dev);
+	/* When MES doesn't detect any queue hang, no reset happens. Don't signal reset
+	 * event.
+	 */
+	if (dqm->detect_hang_count)
+		kfd_signal_reset_event(dqm->dev);
 
 fail:
 	dqm->detect_hang_count = 0;
-- 
2.43.0

