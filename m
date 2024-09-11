Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307DCEE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FA810EA4F;
	Wed, 11 Sep 2024 16:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PpekOuI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B338510EA4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKLA8Yk5mUnOw5ir2JG0ieCsR9R2doXNotrR42VSKhc1QkfusdG7JPBDsRdjUor3rb5Ck2fJwulWh9IQeoxMWQ6yCfERo64nWTVEli6kmX1+kjOQNz+7gIIwqYkyH/nBelortpKnPLhFoJA+2sRMcQPkwq1kY6K86j2tQigEMsKkrUd99xid5E21/a3d5vcZKHZ4TZXBk9LldpXwB1tUx6HLuuuas4QVBKh2FVydbglfZsX888mtcSEPwXXYtOGPzILfpEj7UvmL6GyerFXjyqUp8RfJe2qx6tg7nYKGHdxfYSoCnDeRUcVUoMa6DZWIlhDpfLjHfnFQUyCTw2Htew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DMPS0cOeK0j9bu78fGX1lL+SG2FAON3OGZsexygngw=;
 b=jS9oU4Y9FQmIq7F9pVPEHKDd462lFxUrlG/bRdgTZkhbHxOG0qdo2tDWOtzo6XtRysn1KgEbzOaTapoeQ5U8sp90bDj8kwzyKbu0Kjr/bDHqXXI0AnIuHwxlr60JrnSuN9ySP6TOyl2aT1KCOeOIGHjZeaxjDkOAD4oWuPbzvHyhqX7JJqBfpZI73IwXMO4asjqJrJ5XHfxK1sAn2arCKnrJORDYbuF4Z7PHxB1dD9Dwz5ulu+wKvEkTDdRA7/hn4Owzt75jFz31YIKqbebLb+iaXEW664/z4R/cZxWK9I/jW8C9yZ9mvO718bRKja0Mtl5/wT1NySK6dZsrWJayow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DMPS0cOeK0j9bu78fGX1lL+SG2FAON3OGZsexygngw=;
 b=3PpekOuIFv/MWYzusQ18MhpSOhmgAP+xtLqvLCkhh0VKBoc7UH82P4nPej07qlDXc5qmQ4LhDLYz4/8Ho5d6h+y0t0hsHMyRSeg6qIo0UUAvRwWx1sw9Y33IvyTgjfai/6OKEi5i8gCE76p9Vww6y9tijP8+nXPxeeZLifbHPNk=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 16:22:33 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::6c) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:22:32 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:22:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Daniel Sa <Daniel.Sa@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/23] drm/amd/display: Emulate Display Hotplug Hang
Date: Wed, 11 Sep 2024 10:20:46 -0600
Message-ID: <20240911162105.3567133-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 834de370-514b-4a6f-a03a-08dcd27df08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vW/qMq1mG42979vGkOTwtXbL2Ut76JRNefnTEg/ZyoGnU6fhEQEQtH0TBmxq?=
 =?us-ascii?Q?m4adbhpyZz4bMBq/sYclIQoNRwSWlqEvINRVM8GMghxZltbcfK9zg0GGgl7x?=
 =?us-ascii?Q?FAlfP2J1u5ds6A+oA8SMa8GoEvTFZ1QQtUiYNLwDLdMrpMMpTP0hKVtOO1ha?=
 =?us-ascii?Q?Dp5J59DsY2g/gVKOQBprzNj4ssoi1sZ3s9fqGf4wHZlsAwVcEmoLh82LFLc7?=
 =?us-ascii?Q?/klSTMsZSRjKli+lp3Me5pBpO+f9G8D6yJCccEjA41axLtV0RKU4eqHkVW7B?=
 =?us-ascii?Q?L4fbR0zQSb+Ri0jND0KdTmYI/78FOuY6QlKJik4NAwBiLcn2V8rRp++rha9R?=
 =?us-ascii?Q?HhQjbpSNvsayOxreRWHsaPP3RWEiT4MBcdlyERtqndnY4EVdks1i8EfYXegu?=
 =?us-ascii?Q?1Ag5llkJw+w1PLdtXjQjbZks4lS/LSC8HTC+HXC2nbKIZ3o1qRSdP2HL/b8m?=
 =?us-ascii?Q?jiUrtIk7iW725oDNudbLTYV2kOLtNJ3gxHr/KsYq0RXr7TkA3YBGY2Duvjqr?=
 =?us-ascii?Q?IAq2z2JjDUxROATJu3dycqrBcToH0bZ3fHUvyRuNyl3VjBhrcjIvc/j1g7Wm?=
 =?us-ascii?Q?7Yi1pcRZBd7GJ6V+8cKRj2qDu4vC87EjDUZVi1CkdkuTcOAavfIGLbnUHU1s?=
 =?us-ascii?Q?nrlVPhD1cJ0UHBAO7aY3e7c9GJS7FJLidb/5p4zHnzEiLFPrcCwGUi+c6tHW?=
 =?us-ascii?Q?EBvWVM7jRfXiH51PPXkw7Xqt1hJd7y4kk44qx8hk7ylhzdkocw8+2IFL43lo?=
 =?us-ascii?Q?p7nqEOIiRBTzqn9X5uxkKxlyETfhxlA/W8b1ZtLIJtGXA7WhWsAWA1DZITzf?=
 =?us-ascii?Q?prPSbbCzNS1HOmC3meW43hbvZ2yQgkUgIU3eK/n55EylkodKxb4dKJwxBfXe?=
 =?us-ascii?Q?ykIR5DAO5Et3y3e1JKPxxVFBQZSd1ZT+651UOMnAyQqIYlwBiPnvt00EahCJ?=
 =?us-ascii?Q?OURKWfc+DKsE5+LGj1g8Z2+60ofURt1FKRwkPwr67E0N4+kNBiXhG74irmOE?=
 =?us-ascii?Q?TAUJUVnqvjwU3diUQhOqx+dyt/LMCpKeNo3/1i+i3X9P8b2jzRQ72RqqtBDu?=
 =?us-ascii?Q?Bm0w5TsTGhYYL/ZJmq8jznBs0lY5FguHSQOYOzPPbG0I5rk7SOvSmgxGGUvY?=
 =?us-ascii?Q?/Bxuf/a8oK7D9lbnLe8uBeUf+OPvF2+XIc3MGJsAqzH5TL7juMM3M6qAXNzE?=
 =?us-ascii?Q?Eo/RjI7NxJtavnENlreeAG0RCscik75t7UTqAjyrDXJPuvOQ4EJvzeEsLuXl?=
 =?us-ascii?Q?uyUhrRgxUQSWl08jB9WGltNIV+C0s/zzdOKyfYI7//WbWmKmixsDwlCCVZCE?=
 =?us-ascii?Q?Kmy8VFkKQXG/5t6W83P3l/GgV08CN6JgDl3axTNC9pDmhPerXnYOvb7taCKZ?=
 =?us-ascii?Q?oGJoPpDvjsYcmCuq1yurs1AoLzw/ufT/da6NXysEkiURmjnZBKQce1ZiqEKp?=
 =?us-ascii?Q?jxKUGH4QmE58f9oEwAbaewfTJnbIviSG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:22:32.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834de370-514b-4a6f-a03a-08dcd27df08b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

From: Daniel Sa <Daniel.Sa@amd.com>

[WHY]
Driver reports 0 display when the virtual display is still present, and
causes P-state hang in FW.

[HOW]
When enumerating through streams, check for active planes and use that
to indicate number of displays.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Daniel Sa <Daniel.Sa@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index f770828df149..0e243f4344d0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -59,6 +59,7 @@ int clk_mgr_helper_get_active_display_cnt(
 	display_count = 0;
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
+		const struct dc_stream_status *stream_status = &context->stream_status[i];
 
 		/* Don't count SubVP phantom pipes as part of active
 		 * display count
@@ -66,13 +67,7 @@ int clk_mgr_helper_get_active_display_cnt(
 		if (dc_state_get_stream_subvp_type(context, stream) == SUBVP_PHANTOM)
 			continue;
 
-		/*
-		 * Only notify active stream or virtual stream.
-		 * Need to notify virtual stream to work around
-		 * headless case. HPD does not fire when system is in
-		 * S0i2.
-		 */
-		if (!stream->dpms_off || stream->signal == SIGNAL_TYPE_VIRTUAL)
+		if (!stream->dpms_off || (stream_status && stream_status->plane_count))
 			display_count++;
 	}
 
-- 
2.34.1

