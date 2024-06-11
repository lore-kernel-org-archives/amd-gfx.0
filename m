Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D05BC27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926EB10E6C3;
	Tue, 11 Jun 2024 16:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ds4d/tsE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A9610E13F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRycFy6hadTMRfsI752lqIQi05cIoDg+Ec0W+PZd88aEmpz9UGEyo4Kdu8DdfT5RPVpWG8f8oMmfM/7/Kk0iub9vUoV+WZIcLtmqEnOvpsdKIu/bn+2CL1nB+kcA6oTyHM6iCjRs6nKV+kRvTj7u+iO8cAjyr35CMY3Eslbmf4P2BvuTtDSmedGPCysvYVsNuqEEpGRQRHOIW44Y4s8cS/FAgUFqSbcqesCLQ/jQTqdJS2sUlEhD90Y63uIpYJUWnFEZhr9wrYUm55ZKbJmwhRAeZboJ+7DCHR5zjMnpOyUk19/NL4Hw2uInB+fmynpyKtXw0bbafPf6nl5d/GiKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LibY0RpxKwcT1eSgdG+F6MuO1c89YEdzt+XZrvCjyv4=;
 b=EbW2t67rrw7Br78EQzTRC39iaU5LuMs9IeuxptQZvahLCWIK40VEzXzLty4kv6vqgUh1T5pJrCa//PMmrPMPKpMfFmtXMHlSBd9Coq7PToK/XJKZEzez8kckUcvBHENIq6V0ifek0FT7UNwq2rjKOeve39Hl2xxMpH1S4dkqJaTgBRQnYlj0NT/qE25JIR66X0wodPcFc7z0fHvq/a5tUkAqwEU8N6aL2gTbdUu010rnKliSzP4ZXz5lNYPnYxnBriZ99hrtaeoMA69J6BUAYuTIqcGkI4hkMz1isIaXJ0jxVKpb7EkBw0h5ejE5NZsGQv8TQXZ8sdbuIrMZitvSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LibY0RpxKwcT1eSgdG+F6MuO1c89YEdzt+XZrvCjyv4=;
 b=ds4d/tsEiDrGH9KoyJ1x2e+lGXDASfL6vI/8PpJJ2QyUFavAfPD6fBXSt2k/QvYLDmDmuvrs6miXoHds3scs0B6KqQmLhpx4cnnNPFawnWDEwOPWatyZ/f1+Ccq+ODQcSGc7l+I2lQT6mjpsYgmR323/4AyvDZYaSTXOgGbggnE=
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:20 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::6e) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:18 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 02/36] drm/amd/display: Enable DCN401 idle optimizations by
 default
Date: Tue, 11 Jun 2024 12:51:05 -0400
Message-ID: <20240611165204.195093-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d615e1-d331-4075-7a62-08dc8a36dbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/K32oaTsVlWlJ1ujwZv9WQrTZkD2b2J8wTRHuIKoxjw0LWMV/FBp5AbJWRc?=
 =?us-ascii?Q?mnaJ9M7Qe6vMCm/6bK0yGPDbY0CQWHjo095LI0Kj4AnzPbazzWMe5s1hxFBO?=
 =?us-ascii?Q?m5MykU7eM6pJGuIC+UwpHiyVGhftZuxFzegmbSZyqMUVvu5xdgHYhqF/zD5a?=
 =?us-ascii?Q?nHISYlyqMXF3LweFiOdnIogAaikfIcGrfElHmiUCeo7X5yfVpgcW9geAYHTv?=
 =?us-ascii?Q?lPHXmr9kv2/THubl9RLMjpO141IkkQIYq+BToX1xCvBsYlHP9wDtxJSqcWpW?=
 =?us-ascii?Q?mYXjhcGXFtZKAh0K8CCKdLsovqxspHupE7oQHnT3e5XnolhphQgvbTpy835q?=
 =?us-ascii?Q?toACu+O5RM3TezExZdvnjYRBaPVf8iYipFqewbAiEUpt1i+2L/IUAvp5RMJZ?=
 =?us-ascii?Q?8kgenJl9q/PBjjwxc6GTNYKsoL0cXlU7JmJ9y+61nmNWO3PVqWHVl4v1qnHS?=
 =?us-ascii?Q?rrfnDigzsuXoQLDcrLCd5YwZH4VEAG3sRcX+Vk6zRHXzIBPWZ4UsRUFcK44h?=
 =?us-ascii?Q?hl45ARm0/9HqJVgAv6Rw5O7BnCFbPThSyZYf+oYWpdqm05YnWNCZNcJpLuSD?=
 =?us-ascii?Q?CpfGj1iCEkhmBsb3ip6aUXRTFcVpaz2F88iB+9B6FdmGnGRJrZmOBwKTfk6A?=
 =?us-ascii?Q?s4fvwjW2sYHqXBMJPejh4keXlwR6/z/F+Sj74cNnqtRJaJFBhkb3wmSJtll3?=
 =?us-ascii?Q?7eK5wX8oOUPTjm6F1rYOr/J1hkyNK/AQwpbLKRrt8SSI0a1IwRKa0QeGf9Zk?=
 =?us-ascii?Q?B9P9J6v1nsl5xnLJQcWZDXNPa8IUbyoYVKz3loIgic20fAkXsQ8trdKddjv7?=
 =?us-ascii?Q?LPKSLNCErGFNVsB36UmAAdSDo5vBf4/Q1oYTuTTy3v1rgF5od9Pn3aaBQ1Uo?=
 =?us-ascii?Q?iPiVOYrULDHm6PWWqwRO6whRe2nAaX3uSJDYnuRdDdKrmcZnzxnwFn9fylpY?=
 =?us-ascii?Q?E7BI5dDAEUAQ4w89k9me9DHLiRcwzr+IQAw83XYd0mb0Yys39dD+1pVC7i4B?=
 =?us-ascii?Q?l/lkrxYIN9oTQikFdzYNdfNa1wKAWmnM5aNMiIWvjdDmcPI/eGxP4ff/yPVu?=
 =?us-ascii?Q?yYMXlxan5IKmN+pXrTENo3gwnYNI7KHeKE9iuh8eHl41B1aVKm4XystFmmiK?=
 =?us-ascii?Q?kXc10q0Nf0cPNrq6G+aFXmNV0KojAfAFlmvU7+55Om/vs+4HnYLjop1pS3Bs?=
 =?us-ascii?Q?FKG0VbtjtJXfzXAwOsOFf0vAmA/chROPQYa6t+LChrm15RInHZAoIUXJ9Hux?=
 =?us-ascii?Q?rlOdhQgXcqcpd8mMh6Le0flqKPwOxTC9WoQ6YUHoW3jigf1aX3fNH8Uul957?=
 =?us-ascii?Q?QCTli+rzX6O+VcwB68+JTRXirzBleh1G5uldV5VI7igPwCl4gIytOA1WjOIw?=
 =?us-ascii?Q?yIJDYgVmhl1p/1Uu+yehZUnGrtHvQ+vyxRggvrwr6HjAIGmu5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:19.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d615e1-d331-4075-7a62-08dc8a36dbbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Re-enable idle optimizations by default.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 7781a0342d67..d78dc63f82fd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -731,7 +731,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
-	.disable_idle_power_optimizations = true,
 	.edp_oled_no_backlight_enable = true,
 };
 
-- 
2.45.1

