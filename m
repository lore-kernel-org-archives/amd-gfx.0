Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26EC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2096410E508;
	Thu, 18 May 2023 10:53:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0532F10E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqBIGDGf4KPxzIAK/7gcymmWbMLdJ5BL2ObaO6my7lsLrQ65OOA/aRyhPKAZHFAfkI2NvVXvPOB+nGDPD5xiolAvm6X2VuaKurVgD333OjIdGwwBlwwFse6VidM4IVkt/Ssz4wjpddoR+PDy9MRpZFHfGW34jxBiyCzTGa+MvkO5PLxPhDvJyD74wZdcCKSphqVAHtGawINCsXGYKMa3GGxzLFPmO/H1/FWd5EM/rTid0vR9owCS7fkkOff/ZivXSquPcSdx1yhwW4dRla+XVTxc/j8Rhzsh/a4Cmt00wMELYn7Yp4KdWJ+SxtFeqb1UaIrYBmzCrszwy0I0b99oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BqdziGNVR5e0EhCttdZWYtDChSN0mF4qiJQlPQ6hGc=;
 b=Bm5DHmRhb7VuJo2Uzsha6yt5HNrcysZ9b1C13A0ikezmS76P5ro92Z/Yz5etWgaH+tQglNGUU17mldz5Yd/wQVKIuzmPtWfBy2BLa89MBV56LfS7qi8myosTMcoiPO2hkS+knRTL9z/f0X1a52WzkQZTk30GkRhSWIVHDqs0XEvc92MiJEr8c+GgFJGiaNHkfI8pEnXaFig2SXEBD5UzaEy5jL6kS4bTHwE87rueZ7Gcpm6GnPD464pJIZoy+7n2jgiZFrNprJl/1nO4eM5NOv1AM0b8TTVZundBfHml+l+nGqfzcFVf7DSlXCxN4sxESNQ7lCw3jNX8IfAaCfnpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BqdziGNVR5e0EhCttdZWYtDChSN0mF4qiJQlPQ6hGc=;
 b=FJkcMe9d+yN5UzoKpfbOkrmRgPabzkWQQqz8C3927rtQ7Q2DMELrP3BTrPzK7nWUItabHA+7tVeKO9qacQsh2KgQJxk2VdBP5e4sRFZdxL3ASLV5IUjmpE/AnfE7W/kjjIlRMsTybbacdsZcBXQ2H5lk0PVzmbhxBQYEkz5VL+E=
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:53:45 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::f1) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Thu, 18 May 2023 10:53:45 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:44 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: add asic type for aqua_vanjaram
Date: Thu, 18 May 2023 18:53:19 +0800
Message-ID: <20230518105325.15609-3-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b88761-7268-4a9d-df89-08db578e2736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7keArQom7RBbcDU9UMaJy0g42lDSYkjIL4D9katTcWHFkZP3v7Uj10FRU9G4f9AvuNUwSOotHtfGKQRezdIG3IAOEIUwYr6CSyTJbXbX0WCh+r4kegsRsmfBt3f/sQ2Y5NUHgW+QpzgKN0S7ebVWRHFZjN6eyRFA71GMl7CJE6PqT4TAich+0YpoCptUqSCKEhrv3zs1CaV9ETw+WOGU28g4Mxt/+0aWwpATiRtOnPYSHCDji6iEII28dfbTiERiRMl2a+6w+ckJMF7wGZ8/915s+nk+v0bzGivQo6Bfpvc2dKKN/Bpdkkor6QZqbI9iNIrZyeRQJkJOlAe52BIJRhaA7QSFVxgjYxe/YOW0NebpjwmWvTgk8t5moKov/VR4cBwtzrIieOymEwYfcL69kwdVfJwn+MP2q0AuVmwdKXFfqGNlN0KbOpYSGYidh3nAWZPESejlpWHR1EhfdAsFu84ZG3PWBfPVwAmbK1RYvJm+mQ1PB8wDZDUaGaqrtneIc5gu0BdR28sYp6S+MvORcVPnIsVt4HGB6Dk0LpNhJqFrzclaHf6Nn6BE54RRzgu4aVKeHAGAh5logUfIHh2WsrI0rcz7DysC9AJIwBAqz6j4nEnyPkolhnrulQA4S9FR1ZcVg9HvQZ+TqliXmBRvFu+kMRXlWPtGnKV+pdCLUBV48LmFAcazNguK2YTKeEpmJI2RUrtXjOo7DW0QkfsiNFH3IBhLpdstQjJhZhJyN5+Ju01YFW57/B+04ZvUbeCQEG3HjHZNtG2Z2XqLmQURA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(40460700003)(1076003)(36756003)(36860700001)(47076005)(83380400001)(40480700001)(336012)(426003)(81166007)(2616005)(82310400005)(86362001)(82740400003)(356005)(16526019)(186003)(44832011)(478600001)(2906002)(8676002)(8936002)(316002)(41300700001)(5660300002)(6916009)(70586007)(70206006)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:45.6531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b88761-7268-4a9d-df89-08db578e2736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

From: Le Ma <le.ma@amd.com>

Add aqua_vanjaram in amdgpu_asic_name array and amdgpu_asic_type enum

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 include/drm/amd_asic_type.h                | 23 +++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..a1312e1b5af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -125,6 +125,7 @@ const char *amdgpu_asic_name[] = {
 	"ARCTURUS",
 	"RENOIR",
 	"ALDEBARAN",
+	"AQUA_VANJARAM",
 	"NAVI10",
 	"CYAN_SKILLFISH",
 	"NAVI14",
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 90b69270f2fa..2b926f9888bd 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -52,17 +52,18 @@ enum amd_asic_type {
 	CHIP_ARCTURUS,	/* 23 */
 	CHIP_RENOIR,	/* 24 */
 	CHIP_ALDEBARAN, /* 25 */
-	CHIP_NAVI10,	/* 26 */
-	CHIP_CYAN_SKILLFISH,	/* 27 */
-	CHIP_NAVI14,	/* 28 */
-	CHIP_NAVI12,	/* 29 */
-	CHIP_SIENNA_CICHLID,	/* 30 */
-	CHIP_NAVY_FLOUNDER,	/* 31 */
-	CHIP_VANGOGH,	/* 32 */
-	CHIP_DIMGREY_CAVEFISH,	/* 33 */
-	CHIP_BEIGE_GOBY,	/* 34 */
-	CHIP_YELLOW_CARP,	/* 35 */
-	CHIP_IP_DISCOVERY,	/* 36 */
+	CHIP_AQUA_VANJARAM,	/* 26 */
+	CHIP_NAVI10,	/* 27 */
+	CHIP_CYAN_SKILLFISH,	/* 28 */
+	CHIP_NAVI14,	/* 29 */
+	CHIP_NAVI12,	/* 30 */
+	CHIP_SIENNA_CICHLID,	/* 31 */
+	CHIP_NAVY_FLOUNDER,	/* 32 */
+	CHIP_VANGOGH,	/* 33 */
+	CHIP_DIMGREY_CAVEFISH,	/* 34 */
+	CHIP_BEIGE_GOBY,	/* 35 */
+	CHIP_YELLOW_CARP,	/* 36 */
+	CHIP_IP_DISCOVERY,	/* 37 */
 	CHIP_LAST,
 };
 
-- 
2.17.1

