Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ABDC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B4E112D49;
	Tue, 12 Mar 2024 09:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NerQMI2+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6675112D49
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwPIDmVfbwK6CRYBil64zRSIZBhQfT/7dQfISLG28moTYJMPN+mAcoDlA4FImzNHF0zIklZo5Dbl2jVFpo3p6sbxTPBuG1Fjbt0tcZNVmgoxf3Z8bHR9OWnrITt988Jl2EOjteJcM7dzr/I5P1gpl1g70+W2yrim8ATv4IzQUTWJV0TzMu9IPM9A+zKeohyif2hH7tyFBEUlHjhL8hK+miyJcuTJZb0r3ojtfDAk0tMRHMmIe7KgBPNuPuGKYMSSjN175RxtuQWtfh95W687bMB7Huj1C9Ltc7WKm1o8d7iAO+T4TGpw8CtcF8aqe2ESdjxyVYj7KQSxGCJJcMurtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBmoMHlA4bJEUxl6Zi4S5fs9gMhnYdNE/lir+/nu0TM=;
 b=Nwr0gUK20XqEYkXVvqc3JbV8xTFBJbTw4iDgSNPG53Xcf7a6pEEn06mDr4WDZoOSwkuEPfK8xJaxcZddMiNCa9gssObLgjCFEkrZYmS33+GIclO0IBsvwUjGmsWKDpI1IwjGXyhIWS+kmW/YK6IUzyvVcvUPwIfqEyrSFIYuSGZIISN/wWNkw1vDPSR9BlLckcgdiUFJ5w5jC8mNy4XiQ9S6w9RCB3sn5ltaj/gWS/efW4DkEJ+esO6/d+QbXruaim7H879FX2vE96KRkt5onjucYvD99bf6J0EY0s2ZDn5EPG5B+Jw/9IQc5MTug8Fb+wwoPYNyq1PPEHvYutoKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBmoMHlA4bJEUxl6Zi4S5fs9gMhnYdNE/lir+/nu0TM=;
 b=NerQMI2+Io0VU0s+qroVc/I8RIC3vcF0+TFEpBT2T0XjWaMykWIjqaH20Fdzgo84X7ujbMv5AGzV8o8wCsCN1QixWGmvKnU4YZdTtvxvF2fVVayYgow+MtaMq4+aUYEeugAj9A4DdzWEN6Dh+Hvz3hFRAle+XPgpI/fApquAxT8=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 09:25:22 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::9a) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:25:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:25:21 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:25:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 43/43] drm/amd/display: 3.2.277
Date: Tue, 12 Mar 2024 17:20:36 +0800
Message-ID: <20240312092036.3283319-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: bac6703b-c371-4abe-4b7c-08dc42765782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fodlpF6xKK7YfurIhc+L9Y1u/RqlJhZIE7Kbl+eM4vPM84FwTPv76Og+Gm/zU685qG6InvqQP0Q/2QzuzRtYYcbm+HDGAsy2OyYZRg+7e5bVF5g7/3zpRz9ouY79t9nUYzUoZ+AEfqe28Jls+xCJ6LMfEEE1vh0BRAZ3wq8e8ireo4xW0qIekUgEq0ZGStBBOZTxD7uj60UKDsTHDdaGrXyOnPLJxJXfNEwNL6Yv/ZUxKXyEjCrDf7Zgf8JorgV5uSYKrNe0kBooagtd9hJ3t+LPnl1+8aaV1/1IpHbaEishL9BPy49FrH4KcxIhYZpAwcIJxW1Tzuoxf1E/d3R2oGndVJP+34o2i0O9JH+HtXb2lo2gQO5ZTZMAmbnkgxxno7VQ7y54qYig9LPsckJfZlv2fiuCDQilSodYb9ToOjLjSZT6+62fGGuHmcHBYtpSt/29SzyAkzcofcQUIaW8VxWKXo05P3BZBBcFv3TWoC3oSe/UIlwlXyzsUoeM6GkefpNpGfHTJTdVWro2hTOaLQnXSVeU/nM74OSNEcfkifpbA3YuPWin3F9PPGOBiISvt0JUf0QMsD4U0YjMG1TTQcRlhgQbxeEciofUkxsMeuQ+3t2k47hAU30+sQM0AgANy4UBuDA32AdLOVyyLdF+2K/mG/E0fR6IX2zldKW0vrCSCxazxWaP8Q/2LnyoQiaNHhMWsyWyWKww1itTZpXXsMVZekw998ZgYIp9qQpWBZC2y7TjlvqIzMld0nUyK7L5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:25:22.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac6703b-c371-4abe-4b7c-08dc42765782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix few problems for DCN35
- Fix a bug which dereferences freed memory
- Enable new interface design for alternate scrambling
- Enhance IPS handshake
- Increase Z8 watermark times
- Fix DML2 problem
- Revert patch which cause regression
- Fix problems for dmub idle power optimization

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 673f36543f6c..e0b44c43e959 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.276"
+#define DC_VER "3.2.277"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

