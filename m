Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F9FC77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87110E197;
	Wed,  3 May 2023 01:43:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653F210E197
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWv6Vifodnp+y7Gjx2guqiP7e5o5Sv4w0BmZfOsxwaSui2pEyU0fBpEDi9eZc/mH74QLp+vDZjcWzhuMjt6HmWe7YKce5Q9dStQaobc8KGsaF/7J64g6CY/IAjKN001WatBNIW/CfUBm1C3k0KSKRPpYLCR2pDiMOW8SC7y43nbHUUSPHqewj5kNQoI0XE/3Z7Wrjmug8ZIsRrfgXGJRwxRvaXqmmudPi+Yk7DIHHEIxAoZd1Qq7uiC3qB8I9Sdf1AXyWR4c4vT0czvG/gKLSUNdbXNGK2/zz3tApphMPcX14y0kLs/4EifLoqFf96f6u+3VdZUJW077JHte9nrq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVkILfNi+y0uhSh2Abani2zOrwhNOwPMj51zxLuJew0=;
 b=h1ZUjs8b2yCN42uKHcr8rz2UNrPLfGstYFMaXskr2ImdEIXyAjCRkS8wqST6Le+F84O6/a0SqxQtLG6MBYEybsWwPJcQ8NzqC7pTh3D26a5z+yDHmbbkvnQApCPmBvmTArmMOW+8y4C8o0lylJZwZIe+oPl1sZFrbHYO7BMky8ThKHJuWaSL8K70o0SKxwbYziozDR3pfetZdaqr1HU6XJI8ZrsOqvkB5tRuiGN9vuMFM+UqJzcm07gNF+z0Kkt7nWd/8FVoZf5bEuf70lw3/NynKgtR9leKEp6WX3sxrH9zU7OELUGBzh6JVtrsM6E9PZAMIo9XajOpNA98Tt+lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVkILfNi+y0uhSh2Abani2zOrwhNOwPMj51zxLuJew0=;
 b=KdaRdw1v/Zh5tdEyOLy3hXuQnc6r/4OcLinFt+qcWk5su/0A3iLrLYCQiC9xqJuggeRF1U4vz3R2Sg81pmHIlTQQbBABwq7UkhvT2FL3qWWuY+kLS1TRSRWyeMuCIA0Ysy3mQoWzKBGXpC52O61FLV9zr6ficHv226j+TEJGKzY=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Wed, 3 May
 2023 01:43:12 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::13) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 01:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 01:43:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:43:09 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/display: Promote DAL to 3.2.235
Date: Tue, 2 May 2023 19:38:53 -0600
Message-ID: <20230503013853.2266793-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baaf81a-c88a-4617-d230-08db4b77c148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQmG0gH6DjJs2KrRF8yqzl1tmM8jZnsw7uyRSQuix3gDybdORMN9BRJQ/yT1/wCYsTRMhh1uP9ArjjJ64HSLNQPTCBKgd4j5tndUo1bMzMJXH50M+6uWCZmW06XqQODxvOplIvKMgb/X65Wt6jTMPa9DaHS6PkWqOQ01XF9Ouzv45XJWKmUb5w5GetrOIqnNw7wp+YJSaeYnyK+vTo+rVjxTFdpvxI8CBkZEgUCtChPfck9Wgb4hPvzpSznY7SElcQllW3MgC2L0hY5w1MgdCklKc6YlIjm/y4tyrVUwK1Z7IcZcESq4gbFnuLEKLMQKtx9TLyiRSGtzrgc2I3o0E4BahtL0ztN9Um7Y3nvxtjEA1GlWlrfq9kkdYR44Z/A5oObIZiAYH5uVOAn9UfnziCnFj91vFg28L/cOg0LKfRbqkMD6IjZUi07rJ1C0U0JGlKZPa35ONwbZzh7qjr1/jTmE6ai7Kwej7K5weKnJFi9rh14OuxN4lNHfyOMWRDx5kIO7ADaezAlWearm/srtTWj3Kfv4bOK47FboTu1z6+KMO7Kur1OeYvkk6P0WKl2GkWHfkU9QrLwzo17izanx7CYP/KbKYWHGN0RY6k4qkzUfa7z7FCiklPsglPMz2NEqS6TdZuA133vguWEkP30MNlB3rNcAvEJxTsgGILXFwfPI1BGmcs34uvX5Cb2yJFWIxQltTIE+lsFkUKjl611+zUWgQdglnKSvjo0S96B3GiQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40480700001)(2906002)(4326008)(70206006)(41300700001)(316002)(6916009)(70586007)(40460700003)(5660300002)(8936002)(54906003)(44832011)(82310400005)(8676002)(82740400003)(16526019)(2616005)(47076005)(83380400001)(426003)(81166007)(356005)(336012)(36860700001)(86362001)(6666004)(36756003)(7696005)(186003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:43:11.8242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baaf81a-c88a-4617-d230-08db4b77c148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Block SubVP on displays that have pixclk > 1800Mhz
- Block SubVP high refresh when VRR active fixed
- Enforce 60us prefetch for 200Mhz DCFCLK modes
- Check Vactive for VRR active for FPO + Vactive
- Add symclk workaround during disable link output
- Show the DCN/DCE version in the log
- Add additional pstate registers to HW state query

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7e3f20a3a02f..f4448b545d70 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.234"
+#define DC_VER "3.2.235"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.0

