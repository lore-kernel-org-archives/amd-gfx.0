Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DFC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B827410E8C0;
	Thu, 25 Jul 2024 18:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfqdLDGt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8005410E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtWE2nd0M3of5vdbMzGbKGR8aTQBak9ZTEkyp26hcr+2Yh5Lj82LvBDipPw+c3//P1tXW8iVKB/zdAkOrjQEyl6w/h7DwVSs3P+9lR1S1ygltanHbjNDsYeyp586l4tMb799uaZw60BcHjBR0wmEPBmET1cWJEedhLTNK4tpZ1YOj+hFoe8+QoYNZZ9FxZD7p2LFI54PDd8UrEf/gqiQcLduGKJW6bHN/3jwcyLryg809NDBcjOIEwObgyoGcUAPY/suAtzsqdVIg/8yq8Dw8j9GpL2TI771gycEtj3weEgC+yr6uznhv4e/IxJPwkigm30zft/Ho8Vypk0XsiozyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcuTMrEsTJUPNtcKXqP35bIvo/dS+DwlwBYr+90z7U8=;
 b=yQNZTsXY/womRSUqBN0gXAK+qgCov1U6oViEO1lfezSkwyQk1Pc9ueobq6xn89Jf4BndqDhMqpOwYWx+J54sF+rn2S/hu4hutGh3QiFSoPABEwWJcXrETBWqPdIWMOkfb54ERTvM6Uzio4sjjkAjsZlq5gooJv8X/+XH0W4pYHLZJPNJxniyuPkwxszMELc0U0Uyl8wbXozSRS5y+SLC21m215lm5xqZy4n0FtShrsmGMYYx71BN0LijEOgSR6xytp/vbOeJ7IdeboNqTMOrJNFL7cHrYjWR64l1HI7DSqmFz5MOvkAezYQ7KHODWMt4Ik2WsA8tp5X4VLr9uVbdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcuTMrEsTJUPNtcKXqP35bIvo/dS+DwlwBYr+90z7U8=;
 b=bfqdLDGtzKKemAgnWYcjILPTi6ypJcg1WMq3FrtVRw5cfPcw33eeTN3YhsVbCCvHcFcwB4DFQf86XjY3CnAQ/YvDRMf94o+57+IMCZZQtSJFohIRtZD7YjXksLtW8lCvcSgxJsouHU9ZwYCmxjnfnd2pT3yhnsXcx+bRaCvUYvA=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:04:41 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::47) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:32 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 34/39] drm/amd/display: Remove duplicated code
Date: Thu, 25 Jul 2024 12:01:18 -0600
Message-ID: <20240725180309.105968-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: f60280bd-f786-4f9e-3601-08dcacd440be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEG0ywVROFi7epIqRu2C27wUgrKOfxQp+a+AontVTiwzmBa1iUpFNqggEaUn?=
 =?us-ascii?Q?hS698Q7qkg2LLa9EJOi1VWkYERZALIdsw31asFCVx2WpDbA/KEF9WvQIRhK/?=
 =?us-ascii?Q?8dp7RlfFBcd4+ueRWXlUb7gw+gUn1zCv7voPnBlUD8xZ/ttdWkKSq1A/HKpN?=
 =?us-ascii?Q?nd9SnWSYAMk+Pbli+QtTG7LSwNBp/AhNBZo9goxj213keUMNXCr+Lms9/PKy?=
 =?us-ascii?Q?oob+mKIrtFluHWyoBvXWG/vS1Sps7wYhUgIHy8MyrrGCmov9jt5ojTcrlX2H?=
 =?us-ascii?Q?AHcMSOX/t4X+ZIwHfKlwbxRoHGyBje1dpsSjJl2INgrBhJRgpYB53hx+uBCI?=
 =?us-ascii?Q?4XveLJaqKS3QIwv+0mSdpKyxBxJbpH/ouPrQv+pCwPto3y7VVocbNoUlIri8?=
 =?us-ascii?Q?UwI7OQMyq2FKnVg2ccMrNnkqAuTbICGKGBSlbcQgVy3IX+O9gAiUfQd0KMB2?=
 =?us-ascii?Q?7U1YL1ycAlhUNzJgjGyHlON7yFR9gsTRuvXPpO8EtQRYhYeVRyEAqI3OZlQ+?=
 =?us-ascii?Q?2+W+p1UoA1QuqJKhhlgLTbBEl2qVbj1Id3A4/zYa6DclPJujRf/xR1jWADQe?=
 =?us-ascii?Q?q5Bpsv9pqzWkEv3AZShyHbwDscEbg21by5gnR+TOjIF8OHny8EgDQKjPRUs5?=
 =?us-ascii?Q?1da3zdn+lghRKHglNR5y9VoMykgSFXNMMOZ5v037eN+wP9X/Pqwxc3iL6oUk?=
 =?us-ascii?Q?HVvYs3aJwH7sT4RP5LBcRTPtpCXF15Xp5WMOCw8YYCZu5e3rhLyEuA01Smjz?=
 =?us-ascii?Q?bRxr7wQP85I1fCgVuJICTl1l/hpjfROq8iwO6S8s0b5UKp7htDrnZk4xbuR6?=
 =?us-ascii?Q?19R8utHpke3VstdwIIKui1kGCceoZH6KnQnbpprfnusrms9sRjehotsOd9Dj?=
 =?us-ascii?Q?D9fnjb5q2/6IH+A6740MoTal4q7eJrbmAJV9/i9VK56YjpuzsxkJEenYHSuZ?=
 =?us-ascii?Q?9Skqwmy5b1tBl+v6PqE4qlNQYpeYKOnQJ5KAABV2cqmEWTIxjNrROvCQ0oY/?=
 =?us-ascii?Q?KbMNCZHLH4CTqX8a8GhOqsqU5uBGMEAO2SW2UtRUTWJDX9kqrnYewuVvO1ss?=
 =?us-ascii?Q?pFs93uutZOLJQT+uT3T/n6mg8uF23eOgO0AxcACKenagycY3nKPDrZI3KM+Q?=
 =?us-ascii?Q?IXFHlUt/rMqvGR7CpF9fcQQ92pbv+hmFUXDl8cFJybH6CoCrZK6lgV13louY?=
 =?us-ascii?Q?TlGLboLMYHI6TBTJ5USl0Zdb1HxDMUkMG6MM+38BeayxPPy1eWS1AlBZunTK?=
 =?us-ascii?Q?EmoEEBA9QTj7prk3CHIht14hxzH3n7Nx2+yZZELUvASbCmAquTTwLtRnafui?=
 =?us-ascii?Q?OZiaEIn2+ukQU7BexJxrJGdhn7lTNt9sHrJV7JkoGc+hdcwmUN8V67QJYBbJ?=
 =?us-ascii?Q?/dhvrklSWPoJco8vqSb02qshHj4NexiwNV7wU2E4PnltWJmCh6v4xX29K02P?=
 =?us-ascii?Q?oi+zlO9CS+KkKPzI1cnKhogTlT8RfG/M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:39.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60280bd-f786-4f9e-3601-08dcacd440be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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

DCN_MINIMUM_DISPCLK_Khz and DCN_MINIMUM_DPPCLK_Khz is declared twice.
This commit removes that duplication.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index c55d7279fe51..2d06067ff36d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -29,9 +29,6 @@
 #include "dc.h"
 #include "dm_pp_smu.h"
 
-#define DCN_MINIMUM_DISPCLK_Khz 100000
-#define DCN_MINIMUM_DPPCLK_Khz 100000
-
 /* Constants */
 #define DDR4_DRAM_WIDTH   64
 #define WM_A 0
-- 
2.43.0

