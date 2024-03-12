Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1FBC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E846E112B9C;
	Tue, 12 Mar 2024 09:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyTsuMMo";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B77D112B9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEB36DFmn/lQH0lxKgbkWAluFTsNgS46lPkkWF2Ma3jvn45iVxCBagWEy00rRz+yXzgw7lcu8Cy4Q5arMZarmXjy9kLGLMip4AgZ1dpMzOdNYVadet/0899ZHhKSml4FsFZobaADVRlKqurCgaAfmLNC8N5l6MveeZjd3Ci41uFpTNLhgv/BQqiJjrVbWqt39eaIU4OzV4tJQ65BabCDkk2YQZ4Uay/LyPH9DCTOI14RmM2aDnmGGS4MpAeZLp/M27AvkeigGKsXGccnDJ8+XCOdLE0N+j8UD4z4ybw7NKtkM0FtB6DjJOs+cXrpNCJHCa90ZRPQ9AiEysdc+bNi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I89l30iNcVAGMABHYfQNEwFAvqzxKRmgUNzgfz/qMT8=;
 b=HjWeRlI9Dikbg9hFE8Kjn41GLspDunwoTZwfQ1k8vgBtpvcoC0h9V8MSeWnXzXUqz8oU2LUiirCpVhiPiw4PWnq179AdlehrIALT1q5XTE6axShaBsADyGWh1HRlYJxkbh0yIp5kxyApIgkOPIhh/BVLjYbLv+Xi3XsuBuqP/HCMycGPuQaf7TWRnOOLV/9MA0hrct+ZGL0DGvcYI2Poq4HD71N+oza9bqvMIXAR15UaMj4YWHXwXa8J1YS2UeJrY3e3F5CnOzQq9/gPJQgu5ZN1wxtXqL3r7Ts/+APuTm8rb5Xpkd+3gdl/5y597IKDOqBlBqmxshmbMJ9PdESF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I89l30iNcVAGMABHYfQNEwFAvqzxKRmgUNzgfz/qMT8=;
 b=zyTsuMMobHC2+sAoXHTAVOI4EU9kkgiFAzhANNwZiYrD6LnMD9FnVRTv3SZfiE5XDkVyYYuyOI6tWy41O+KQ/ZR1LkPt51RE1HG6NNRMv4ZZwKcE/cTlPPnFmZ/WQNJgoWPQLzjzpsS2FUz3P2ZOC6Ej/Rgs3XKASglulZuf8d4=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:23:30 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::30) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:23:29 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 25/43] drm/amd/display: 3.2.276
Date: Tue, 12 Mar 2024 17:20:18 +0800
Message-ID: <20240312092036.3283319-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 994c4e90-24a0-40d7-c8fc-08dc42761533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJwPgBfwQOTsv+UjYHE7ZX4BV+VPiAz8xbL3vRY/F7kA1hY2R14O1TFbhc3uktz7FVU4LnBS+fadrlnsBQWo4aBPNDunO2EWTeV+KEidoJXbkLK4VZ1OMeRyK/FJwmjibIYGsxUnrBSK5ZjZhnzr7ztcF8bryTh36sfZV30CICRNvTIPGhUnY6mN4U/4ZrfdbwTVD4lKWrzvDVrtQ4usnEJ8z5O8me5nOhiezXin1zXf54hoWIyGvW/fTyhOQggG6WFlcGeN8iwjGFESz7YzDGvqPyaTWMqbdw345ns44RMs8L58+NC+8Bb1Q4fWiyAKvetx82skPodFKkra675FCp5Jgbzs7irD6ms65Hi0Z7vY2MQ9qjbmDyhoJYxCEaD5309NTtbGTGs+s2zArr+dS0rrRYRdtuP+1UzrZAyk7Y/lFksYVk0E0KYlErmdISMDOdq/yplVibOBeYoefpAoDtdpd3bK2+TCyyfwuIqrHUoEFyNA3q+vMUD5VwYDYvvDdXgYb5Js93HGb8CCMBvdMBfBOGUp25xbLFmw7h2bxF0ukWgdmaFDXfR2PZzr//7ptNmG+fwNWzg3uWF52gMUd+I3VB/Pn/ifAfm2FBN2bWr8WAKIOYokn89g3xdWSwVxor2yW9ZMq8m+B1O5RhaUhe9ZpZtIpuXkg/ltYWH7oGXA/DQX1qieq1okmRCdse2TBOIF4qw2rWA3l+CLCFOirQ5O9ObVTG7aj3rhvfzclxWsZVnTJRbYEGfhVeTz75x9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:30.8275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994c4e90-24a0-40d7-c8fc-08dc42761533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
- Clear mpc_tree in init_pipes
- Program pixclk according to dcn revision
- Add stream clock source to DP DTO params
- Enabling urgent latency adjustment for DCN35
- To adjust dprefclk by down spread percentage
- Add debug option for idle reg checks
- Revert few patches which cause regression
- skip forcing odm in minimal transition
- Fix noise issue on HDMI AV mute
- Enable fast update for DCN314
- Enable 2to1 ODM policy for DCN35
- Fix DCN31 underflow problem
- Add the MALL size in the fallback function
- Modify coding style/errors and remove redundant codes
- Add missing registers and offset

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8abd19e7f826..7b22c2efed77 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.275"
+#define DC_VER "3.2.276"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

