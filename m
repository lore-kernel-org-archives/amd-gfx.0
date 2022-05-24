Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF88C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9A910F991;
	Tue, 24 May 2022 17:58:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F8D10F9AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp385uoT80yd9NtK288KMsqRJhACQNzemrH2THAm6SL3+wjqb1ZlowqsfBpy2UiUSwSDp63VFRUGSKTlVMOHcSB0yrPvV0DepRZs0reJf9jUFjKE/fUuyuIhMNi/MbBZZMT4+65dcz4TnNZOftXM0NhBjLb0bPmIQTiqsZBADTll9rPFlbbOREtXIv8fI66ejP9cste56MDQ/HZNJo6nBISgIiJcbA7IP0zXl8x2aMhzgktjOOD//XDf0+XOuE9vnEnhKDO4eP28rNmioQOC8gptUyXVnQw7K/TlIj5C4eS7hQ0DTf/yzXbYO2G1JAPCji8nya8THDcHLQSH7fYtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESREIp7RPB0KLToSdkrrRGA8QUuE32CSI+SPi9r0PYo=;
 b=aFPnyDbzUsxwFQGzNrb/Gw0FkMDYOfyMxgeUup8h2taE8GQKH8At4rFt02T0192zrAL4oxHHN2TPXaoGg/hHEICJ9jpA94qhowX+XvkKPmozFIuEWDcPvA9RCd7MdYssY65vw9DCFq1lLwp8wpafZQRQY6glgMb2lXnjHozKsYS2oWtjyVPgwQlnsZPSo/BpsCPH1N/pkzb7KwuJTZHyMFhBxLXiuuPn62fX0v+TeoOwpwRcDRDLyL2Wsia0RifCkNCx876Mdx7HZenifAuu9V8e8lhmFZoEfQiCcT4J1krpYTbptZETpTmKFpyXkBwdhoi+ATvBrZq2iic5ICfZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESREIp7RPB0KLToSdkrrRGA8QUuE32CSI+SPi9r0PYo=;
 b=wgq/YUTqmRdXouqillLjJhGE5Nuhh2TYcEsXLQJh/Nj1nyCKGb5aw9laRsKGfi6WV2OeCGhHYAYUk9oBxeep5bzeT3yd2j4Ndq96fBRX63FXzj7dqjh9LJ4bd/oxyu2rxu+AmzwA3kDeIj3uNxRjxTMv/BMehlzIUmYJcvJP98U=
Received: from DM5PR07CA0163.namprd07.prod.outlook.com (2603:10b6:3:ee::29) by
 BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 17:58:13 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::b1) by DM5PR07CA0163.outlook.office365.com
 (2603:10b6:3:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 17:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:58:13 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:58:10 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/display: 3.2.187
Date: Tue, 24 May 2022 13:57:24 -0400
Message-ID: <20220524175724.126380-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc4a04d-3d74-4380-bff5-08da3daef8b0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB46447A599E100FF80481347BFBD79@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHWZf5KrjuQZH7SBr0GdtFMQTDK2Y1wz0QC8+9hhvAd4+LZoawITtenzuNmnWsgBDPfGnnTj2Y+//MtLuco8OFaTu87kXhMs4tr56V50DAs8+/mJmRgX3WAz5UWFSHUn6LcMMyy14LbUo9Xnr2dBD28tBUURLM8mBdLF54ZbM2gD+p2PSQgC3soqcmFu01/4nQnC+xyseoz6ubF/6/sSItHPmdrt/k0CEo68FtJQMvKrAbEYEVQJs4W+D3ECHq0up5Wgwf9wkO3a81pDObaUxWu/01BaMxc8NCL/l1GG/Qz8HlErGnykKmIAgifVeAzNCbrdIkfPvUR6GTqbnrQ/aIRTIGYh3PoxMisFa/VCJNII/N8mIYCQqxMRp2QTGMILlTAyoSCGL81coSG/iXaB2KhjusStEYsg33oaIDP3MVDRXFXGa/0wQmDhkReSLD3bcg/LBKB4MXDEDzP/7JnaL/s/3sGaijIXYup4m7stjBpYmMgmFmj7lJKLtFOc+nuOGEdLnvPc6ql9oMcmP8Ot7oDM7JtlPJCkEryGTDzSGuYxSCtLtfiCKMujB4VgA3zLl6G6Scaf49UI70l0YQtrDguqJxTS+HpqGKd8Di58EVzFV45N6GzWwB1PZKZ6b4o7mNVdCsriEcFHiixxZY49ZFdAIKZ/3bPvR3AMea2r6fsLf8f0QKSfwh20ndO0M19bRRnuGlpZsdYpV9OZbaBFbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(36860700001)(40460700003)(26005)(4326008)(70206006)(8676002)(4744005)(508600001)(356005)(5660300002)(81166007)(83380400001)(1076003)(2906002)(8936002)(316002)(426003)(6666004)(2616005)(336012)(47076005)(82310400005)(16526019)(36756003)(6916009)(54906003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:58:13.1345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc4a04d-3d74-4380-bff5-08da3daef8b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

* Changes to DP LT fallback behavior to more closely match the DP standard
* Added new interfaces for lut pipeline
* Restore ref_dtblck value when clk struct is cleared in init_clocks
* Fixes DMUB outbox trace in S4
* Fixes lingering DIO FIFO errors when DIO no longer enabled
* Reads Golden Settings Table from VBIOS


Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ea662af01b5..e8ef7788f91a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.186"
+#define DC_VER "3.2.187"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

