Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CAEC54E49
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 10:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1382F10EFED;
	Mon, 26 Feb 2024 10:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x2/32k8c";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF85C10EFED
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 10:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIZECE11503KX8JKdoI1jFUDLJ/hor4punNKyFplnaHhVHnrN7rqDCQGcqYLjueHl3dQZNg6Fp0Ps0G0G7Kh1OuL1e1yNVthPCjKV5G9JSUikRnl1lZZw0TmA8XWEj2EEastGl5RIImTNukFbYw7pkSM6zVhzq6+9eSM4WDNU2883CHDvwRLRMN8JuM2FXGw8qnaJwshjfhIZeJdbND4TlxZovObLji8DDOh/MOSKo5YfPa9DnxZwGAOCrS2Bh5cwjR4QhCfehfOTwituCD+qXkHwRbX0i1pg76Cd0s8iGBTR3dW1xnptNO1nRZyFYjD7/DYnVDEc8mYCKbPvZIqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Em7D1OgrbaIoEKeTmYGRNQcQ+pC6rVguMQB5Zu8Dkw=;
 b=XZOMxrLTr0R4kVYD0ooGGgu+77HaxX8YwON/HCh75XaOlnJkCW6EIeFXCB33wdXTlm9ehKCj8FWrWsx2V2kT9FoPbTg5y6XmkzXe0EKoCL+u84K9bFgljW5cVyg5AbCRhcnhGO0j02Tfgh/GMNn4GywSqozKglBKhAgppnxuVOJzWLW2NRRKFt8vZCZgelJclpECBjrhc7GkPtgULrZJEV+I7rXQEbKPFBO7RoCHz6zW/xY74qRXxgisUBhkQ60udV/5dEmaKB43RCPRwP4jJivRGvg7ZdfkkKkEOcJAuaCDgnj06ohLSYyXNK2k0LPT71frFwgabuZAeXslGjDMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Em7D1OgrbaIoEKeTmYGRNQcQ+pC6rVguMQB5Zu8Dkw=;
 b=x2/32k8cNwUEbr+05FFYLeJQfqty7ZXqCoHjircovwPaR6PKcKx/EyWiStJYSpC/hKpSVxAZyglmKLK1U0wbEqfoGQB2E8hCRJw96JBGvdMQ/9TwZVZUBTzkhHnhQholAC8bIuSEOH5ZffAj5jMSTOiXKfzF7G9Hrrw9zad+LXg=
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 10:38:14 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::38) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 10:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 10:38:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 04:38:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Increase SMUv13.0.6 mode-2 reset time
Date: Mon, 26 Feb 2024 16:07:56 +0530
Message-ID: <20240226103756.196437-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fcd4e6-ab2c-4849-12e9-08dc36b7091d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JioW6iJk/JA/YaJGdtMcaN+rtclRH5DrBf/4vzxJtCS0ftXffnGMMUURsVNq+iEDIGia4O1PnlU2FB95SG0FhRlMWsU5V4aa6ijLdCnhq2vVzDj90NRinXQKUoYGtPK40+uJXtGMUjI9hLT4knZ+P2fs8Pj0fT323Jnmr4dRvfzum/3Q+KPPKUUxNXID9nBitR/wKkDl+sA7xvad91VuiNQuR7GPzHGS0aT8zwI5D1/+NMspx/jsGwwAY6oXG7lno2WxlHqlma5uulommDIJ6Kvvg1vyHuZl4TKrn5CI9D8JLxmMm2kOmTwnYhnNQKnPGFcFQur3HOMCu7DmfOeaTw2fQ9JUZhhIvD0v2yMVGptBjrFiUK3BNzrTsQ2wDmXOE51FfR4F6f9pLrk0N2Y3H93iI8S24SjcpRhHwZKHlYHqytf7z+KkGy1gRnOqW1Wkr/YxbboCmOeVaWw3b0PverkK6xQMNqmpo5P0q7eTKjKjM0W4r2bAwmkRwmPP6TXb8Lsrj7zP03y1Vd3pBNJikB9LWWJkdH+beAS1b2kS7wtOCCmIihk7SOFK/K3FEHjuo7PbZdAwJCW+n60e6RA2BTvo/ig1o3+sag9tlUwNP/jtQykNhJ2b3Nbuno4uhRqYS4Rea/0VXkOiHn+wOPbQX0g9uYiwNLBuYdZltzjaBdzgKx8z5j270RqpDGkW5SWuT8x4MukgGn2XcRXM/4zKMvZxH+VuK/NdNAby0NtD6hPRpofNmkGPbNiU8+opHrN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 10:38:13.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fcd4e6-ab2c-4849-12e9-08dc36b7091d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

On SOCs with SMUv13.0.6, mode-2 reset takes a bit longer. Wait for 200ms
before trying to restore config space after mode-2 reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 29c102fe650d..2b7a60b23d6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2307,8 +2307,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
 					       SMU_RESET_MODE_2);
 
-	/* This is similar to FLR, wait till max FLR timeout */
-	msleep(100);
+	/* Reset takes a bit longer, wait for 200ms. */
+	msleep(200);
 
 	dev_dbg(smu->adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
-- 
2.25.1

