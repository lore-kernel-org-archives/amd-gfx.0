Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D99C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 10:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560D8112F8E;
	Thu,  9 Jun 2022 10:24:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AB2112F49
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 10:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ3h1Vbm9lxcapz31u8VxspNOQ+1sqFrc7Cv2UGR5lPiGRy4Ozs54/+lAZjeo33BcpUNyMtlRqJMXyJoZQUjzEQpqZWEHbkl6WxjEAjiHpdlJtbuvK5XOUHLS4CKf12FVNr5xsiZvD5jEGCmiorckIDciWwNAuJGy4tlSqwK6IyYYgmqh+Hk+M1EJhwMxfAU31g6yBUg1VhF+za8cDPBiVjd0k4W/6F2lihIQfXmOPKtZbFVS9FsHa3uCp2W4Uj2OnhVpYM2EFGi5+yBYj0et/jgbDJgNazdMgbSLSTFMhehQYVzSKERPTsyMmBPDYpE0mNiU8yUllIFCw12RKr/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQfqTmcQLIlWeoNUmhuawH/drIUN00o0J4Qt41Tn6CE=;
 b=IaLuf2/Pa/zr6TWzTYXd2n0OXhjwNqU+M6nXfGZDr90nHoiOebt8lzGjErl1cS0cgbT+OG/mHYrsuTB7CKwx5zMTFoE2AwHOKSS9DPDXyoPfGkkj0V2CZ6SVNtuJQZsk8W0QOuEXXoRQJEMjXXotTV6cD1UoPS+SqLKio3/SNsHM9/oNiCwwzyIlIN45VlwwWFuxYk1RL0tq61IanlWzeXlrpeGyrLTS0D7UvM/7YDy6HFsVSlYjjbSvLhxvEvd0xICHSlnn5gFd+xnUjwB1mHElXQHyHP4ORuBa6Yjb1hqT4Re++j2guz22e/XB0WietKO46FoaYslBaIjzJmEMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQfqTmcQLIlWeoNUmhuawH/drIUN00o0J4Qt41Tn6CE=;
 b=pkVL9OZwmndc4h8DJN95VCkw5pdvUm1M/gxKKnJ7lhC+jFfA/I19m875HTp2okHsoNhGUTq7xLX1Nhw9aL3Ckf9SBO6Z75nF1aDWTwGY9i6D9lZgnF18FAP8q3V2GNmeo7j8kCeYl/3+/pm4TkjwkSKBBZnK4R4IpNHqfxMM/ns=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Thu, 9 Jun 2022 10:24:36 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::8e) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 9 Jun 2022 10:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 10:24:36 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 05:24:34 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: disable GPA mode in backdoor load
Date: Thu, 9 Jun 2022 18:23:10 +0800
Message-ID: <20220609102310.2163021-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ce856d4-0aeb-4143-b688-08da4a0240ef
X-MS-TrafficTypeDiagnostic: CH2PR12MB3815:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB381548ADB22CBDB6B2AFC9E8C1A79@CH2PR12MB3815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: steB0QWp4shNrGhfsqWjmLEypZY4EnOlItGGFunFrZgjPngnRANWRjyiNJfJl0m0eMtOUaI9hHl3izLEVePiNEX1DWfipCMj1Rv3BKzngZjiiPuRLH9UcdfuBl4Z+ShSywOwThXBxTTFdZu/jNr4qmSO+dDaDoBsrRUcO58pVcW3eVUukH8GQ6kRdex1Zwc2mmTDGhc+Rgox70Gv8e/nwZ8Dp+HBASg8r5wubNcAWqBuJ0rYxfoU8O1uahBkP2pL6kCKcyGcN+v0Dc58+2DojWggKZfpVq4swQOkl1ZEZmSIC304nzpqStnZPjxAxiSDgkHEdObFADd5XNfTjYQ+cMsjFO4x17cYySRUqNYLDeJ7I4VS31e+AehH3P1V2ovzpDBOrF5wE9eO3Bksptk8ZqVnYpQWrfHSPovHOG8GxWl9yagvGaHIGT2D8wVPsiNWoOO+2IIv8G2dUgOjN50uSI2LgwunwqebfHWkEUDxpH3jcUTNatm4O9dNEIXXOgSrnKsiOXkgU24yzd3h3p/LUUyZznGtPNynV0XtCjEuZzh3NQ3QfYebzN6ilcN1p3aw1X/R3Uj9GTGCBvDRM9I+SXzx7lKYHN5/PrFAfq8+8PnEkwou0s/RcIdF2f1ilUWd4NDDaPUjvleAnTEDwH6vycqZChI4gQBCqtygJw/xIT7UpOZHvavkTce/IpUhUOhs6ihJWPshbKUSRu3dwcFwvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(47076005)(36756003)(508600001)(81166007)(7696005)(6666004)(2906002)(40460700003)(83380400001)(316002)(8676002)(6916009)(336012)(36860700001)(54906003)(5660300002)(426003)(356005)(8936002)(16526019)(4326008)(70586007)(70206006)(2616005)(4744005)(186003)(86362001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 10:24:36.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce856d4-0aeb-4143-b688-08da4a0240ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Ray.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPA mode should be disabled in direct load.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e331ea387ef0..571f13eb139d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4562,6 +4562,9 @@ static int gfx_v11_0_hw_init(void *handle)
 				if (adev->gfx.imu.funcs->start_imu)
 					adev->gfx.imu.funcs->start_imu(adev);
 			}
+
+			/* disable gpa mode in backdoor loading */
+			gfx_v11_0_disable_gpa_mode(adev);
 		}
 	}
 
-- 
2.35.1

