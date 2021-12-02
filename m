Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCF3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 08:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D676E430;
	Thu,  2 Dec 2021 08:56:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CB66E52D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 08:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDw6XmLuOG91ipMoJn3jRj5fMV6nEOqu7Hb0T9hTZ8fNlNaIHxYj8D+NuxEOvcL9yWVUkoeWF1t0RXWvKC3KtXjSc1WyHbqVuzDGLIcqxmaZ5x3cbvultmjHBV5fmTPacndqK36JnRfR6jhrEToPC7Fz4/1lC339AwKMn0y2asF2rwbcN/vM73UtEk3EgAaVR+KYa0wnWRt6LGTQmv1r+3s8Uco6PH+VLlgP4kLg20KkWew2+1fhkHaHw3Rvy8/y834TplVOnX7XieR0B7Pl7+JHVf8ORP8OEw1CQy4/w+03MN6NZBM7VaZmZNfax8YIpikB80Ha6y6XQDLFJz/Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZg4bfxtKx82K9DxRKzQl16gRPCTbQutR7d4DyyuvSs=;
 b=JvEdiAKIAsUpYFpnhaowPY32MXMskpF8AvWu0FfTE0tBO+qCu7RDpgjhEKa5n297BxTHgY3RBFTldg4Z8zbDIEO4Gbe+mtkdblv/+GmS+eOt7BucXU5TT8nb2yZSZfap0Y8Mx4xtAfg0mn2dYTKqdeNlfUv+dpZJi9srosr6GurEk46ZXx9cJwWtQUBnZeWFmFdcJhg3eIiiQimcQ1Cu4tNaQIOMhpGw1ejqE8Nxk2cqFZuKmHYDDhdjvytPgd60xNJ6C3jAQxYOqbGrROoCazyC6B+E9m+MDZG582/wtWk2bSGcxsgX1TjKA/c/EXLbb/r5I7CAPsrslNTJBGNnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZg4bfxtKx82K9DxRKzQl16gRPCTbQutR7d4DyyuvSs=;
 b=qQlnc5hGs0gBwGkwXt1OTSNROMkRPvpz4p2cKAI+mWdTo/JpS1b5XP8pDwyRm4G8Qx1kCw5jBdA5UwTJJbXwy+qoE6tY8BJD2iRD9FE9cUVGOHftZ9xIRhCQn5R/i2G8gaaVe9RpJLQBg7PR2vQUal9yVUU/wlDcJIwByOO930Q=
Received: from BN6PR19CA0088.namprd19.prod.outlook.com (2603:10b6:404:133::26)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 2 Dec
 2021 08:56:16 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::64) by BN6PR19CA0088.outlook.office365.com
 (2603:10b6:404:133::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Thu, 2 Dec 2021 08:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 08:56:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 02:56:16 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 2 Dec 2021 02:56:15 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Correct the value of the no_atomic_fw_version
 variable
Date: Thu, 2 Dec 2021 16:56:11 +0800
Message-ID: <1638435371-30851-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9c08165-d3eb-4670-270c-08d9b57199e8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:
X-Microsoft-Antispam-PRVS: <CH2PR12MB429613D59450A2DD214382F49D699@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rERGhqwbMCGd1mrHIjYAPuSmjxzLu4fbNHni6Xf2pp4Z+zoUNvFGRbWszY9At3kKfKbjaWxSjt1PkTpj4yVqoDhmIi7nePTJRKc9BTTc+RJq0nic9QcF4X9Nccf+HqmAR7QHVPEiG/Lj7j0IpakU3dbbow1qZjytiiTEp36/njGH1E09Iav8WUvVOB7Vk6Hh8HQgvsmqBZUvIVgSaI8bHNLKcXKv1n3Nx7a0n9q+3TFHpYI/wjfNMPQe473n24ujaJSQI7d2vclczNa+F/pzI0GP5dOXMmy47GRflEpZjm/3UHjclyZuHj2J8zakLleYILUmIZ8cm0rFrAuRyc6ny3FRfRjvBBRPG/et7p3/39dMb3MkMPyjUf9aGo5OM7D1KYtwSPO1AYxXkA5Ql05gGK91wDHpyYWjFf3RpX6STSr5W3dPvhe7hhsyMZ/S+nrFB4rY5CsBzwAd8tbrDXB8xohzkTOH0NVIYlV2DB0aMsKkDHL11IB+PrZOQinoS7JGzYcXcXpx907oW8XoPaJ7VQRNXxMXvB2bg8dxllpotB8kruYrXVErZ1F6u9A9U+neZtviDJ4kLz+JxRb5lRbYXNa/CKTV5xdDx1qeMdgQTuLZhvaZJO1RlZOrsxQRrajyN5/l2r9ZzPEx8syoZJ/Bm2eqP+jimoDZmLq1pZnsjaIZXaVEtFuzcYPyiPIepi9WN/jNLO1WbdgvW/Xrm0LU0HDyQLmNPBZdl3YNUpuyCLo5Yp73g2YSlv9O3YF1VirJOp7USxy26Y9ComsDBrfJCcbFdibezvF04cwuDAREOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(8676002)(86362001)(54906003)(40460700001)(82310400004)(36756003)(316002)(7696005)(81166007)(2616005)(336012)(356005)(5660300002)(4326008)(26005)(70206006)(83380400001)(186003)(6916009)(426003)(6666004)(47076005)(508600001)(70586007)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 08:56:16.7383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c08165-d3eb-4670-270c-08d9b57199e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: Graham.Sider@amd.com, chen gong <curry.gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

145:
navi10            IP_VERSION(10, 1, 10)
navi12            IP_VERSION(10, 1, 2)
navi14            IP_VERSION(10, 1, 1)

92:
sienna_cichlid    IP_VERSION(10, 3, 0)
navy_flounder     IP_VERSION(10, 3, 2)
vangogh           IP_VERSION(10, 3, 1)
dimgrey_cavefish  IP_VERSION(10, 3, 4)
beige_goby        IP_VERSION(10, 3, 5)
yellow_carp       IP_VERSION(10, 3, 3)

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e6fded7..267668b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -94,9 +94,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 		if (gc_version < IP_VERSION(11, 0, 0)) {
 			/* Navi2x+, Navi1x+ */
 			if (gc_version >= IP_VERSION(10, 3, 0))
-				kfd->device_info.no_atomic_fw_version = 145;
-			else if (gc_version >= IP_VERSION(10, 1, 1))
 				kfd->device_info.no_atomic_fw_version = 92;
+			else if (gc_version >= IP_VERSION(10, 1, 1))
+				kfd->device_info.no_atomic_fw_version = 145;
 
 			/* Navi1x+ */
 			if (gc_version >= IP_VERSION(10, 1, 1))
-- 
2.7.4

