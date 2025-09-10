Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BE1CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8A110E846;
	Wed, 10 Sep 2025 05:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewuszfJD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145ED10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+yUyZtVtf5cnV7ze/jVRGwI4oNGHQ4h3fD5FkvWa/hh2j6sVvOn91Xu6+gVygikykBtaWqJ2Td7MQHLv5MCCT83//grYqsc4OJCoXQ+NqQ3kJoS9vD8B6ph4DbtV5LCnmeOlEIx+jP1aUbhkTO69tN7msWLotODmq5H0Dfu5uFa3ZsQ9w36LKw41c/I5hhI2S3seSp8aY0kDvORbnbipdG6dVt7RUrcUdaxhDeT+iKOh248YiRpYPuds2+K08taKk3duewk5h3fZTk8dJ4JL9SvH6XMyYU4kgq5tQLYFXb1eb7g939hFr4iGNmEd93Kp6pc5WagTeJ/sjtWDRip2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieLTa09e29GgyJU3xAaMIQXFSZtMMWMg0cOzOy+i4+E=;
 b=munDFXebfZN9hGPCD2jafHd4LCU0Ujb8ff88uq0mgCZSr086uLXZu7doafgWXEdfufvi4JVkNaAiJf4EjsBhjEm02+Y0wPofFe1HLjZOrzClpsUerP5GnVErnue7H3OF3vKqzl5W5z99272zr03ggKqMjLVrHAOcAu5wmZ3fG3YfsOf93PtxEtnVd1jwHuX43mn85AVImz6FE4fDuFuZBa+S850f5jMz7nDeSRgusCr8x8Q3gPnPF3D++HAWVkFMlS+T/XME7pfvAwFSbN99B5YesSCVMSxHPfKBxz/Yco4sh9yKoZosvIxuVgnVc+e4XNSzTKoPYaWPyVDoXUAOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieLTa09e29GgyJU3xAaMIQXFSZtMMWMg0cOzOy+i4+E=;
 b=ewuszfJDOk/XJ9tfbAEdXyIv+Sc8cfchqL/Lpwb9c9HzzYy0s6Ua7OHokSn/VF+OPDHOUMmiJofoypUWiI6U3xu5vY+V2RmX9aW9ON4OiK9/hPKjaOhfLGKnGETRbQY1DoykuMJW0JM3ac/KdET7z0mjquIP9MFnpCpOXUFC8+E=
Received: from MN2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:208:134::30)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:20 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::35) by MN2PR16CA0017.outlook.office365.com
 (2603:10b6:208:134::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:08 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:05 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Charlene
 Liu <Charlene.Liu@amd.com>, Chris Park <chris.park@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 07/15] drm/amd/display: limit one non-related log to dGPU
Date: Wed, 10 Sep 2025 13:22:09 +0800
Message-ID: <20250910052620.2884581-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f58ac3e-a7dd-44e7-e83c-08ddf02ab6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GkyldEU9ShOlj+JaODgbP+4ZcEZV6312o+yebyUxUUqq2iDW1yRXnFTgJZ/z?=
 =?us-ascii?Q?nGAF6aKaN3E/rwCdV88l9RF5CIjdjMyLG3U9a85j8PvpAgq15u0JniGHk6V3?=
 =?us-ascii?Q?R0UoKFpeYyOs7w65YakZXu2tE/XuuQO/rleIpdANVGqEeymxFb56PHhsuiZj?=
 =?us-ascii?Q?ZOOua9iFbatNn+1CGdiYN+p8O06J4GOR8cbq6ywAXh2mOE4sRJqpl5kKTWyv?=
 =?us-ascii?Q?6Nuxr0WL/NeSd36ZecUOPa7oNx9vz8b7F4gYK3XqETL/jw/BPpuUVSwCxLai?=
 =?us-ascii?Q?W3bGjujyj1933ok26sgYkTy0sNhwuyG26lECQnmGjopi/+tmiZKbjZ03da2e?=
 =?us-ascii?Q?tBg0cVZgnBwG5306NQowVpFGUe+wiPI+R4f3b9UUxOrFJrLV6We10ib4J34b?=
 =?us-ascii?Q?5Fp7eTQma3Tpfff1LL/RCao0jOpCfABYLOu/dtYrDCoHL8NOl9UPKwYdM8/g?=
 =?us-ascii?Q?m4aZD8uZbDvKSfL4IkMsmh0x+3a9kJ2KLCtugUz9mzkQZ+xgc1AfY8c1XXZg?=
 =?us-ascii?Q?WH+9h1ZnpHCLAYhOjInHMWzuWf/4XTuJh9tTGMYGwUWKSbfuHJmMVi0W0xG4?=
 =?us-ascii?Q?MJvDxQo0aVvtSxpqMZl3xTOruhBnnwqHfGJ3Lc2lqa2iUcf2fOmpAOvL2aNu?=
 =?us-ascii?Q?uD72snGktstzN/CLatNQ3J+fox7Ne/nlTY6U4A7QTooMQVD4qgea9fRGu9vT?=
 =?us-ascii?Q?g4n6vrmJRrocY32/vhLEzk6gu1VQau4gP5ur2a4nsmAe9Svo1+ZPMbKJoezX?=
 =?us-ascii?Q?1vRULK6zleagF/9iMBSrmIW8cD10FppUnC4SPhpwynjjg9WHd9HZ9j4xGeU4?=
 =?us-ascii?Q?VWESggU3YRI74p8PQ9XqpOKoBz4yV+KFk9jiVFptVQfdLnVuwEBUoBXwF710?=
 =?us-ascii?Q?HZw0/G8OKgArEEzNnO/c7+opVDZBRfUDgc/ZzVkyWntao3ej0zj4bwwBuTOp?=
 =?us-ascii?Q?Nd3JpFntz5EY/X/A+zAryn7McZryf9j1VmGXE4fSwSbmkcTAbTtdJI9W+5FY?=
 =?us-ascii?Q?SFI6b3srYklzs9M9XgMsy0flxNon1h7b5F0zfBs/oiaOmeD7oUC6VSImFbZQ?=
 =?us-ascii?Q?UDw/+J4xFmQbNzHsai0T6cWKG1+VL4XM5o79jtkoWrTJ+mLDJGuIyOhIkeiC?=
 =?us-ascii?Q?k/Fhf47Fjb29oDyEbXz11i/yqnkkuQ0AKLuKPpzYcm0L6L/cVUBeQktHtCOQ?=
 =?us-ascii?Q?kPhjlyvk5gjYuG8L16joQ0SIXOzRzZOlXPr2tHVoE5/278M4++RGk5iIIalm?=
 =?us-ascii?Q?FNtoRCQF9SJG+u4xb6SzDF+vLXKkhupY5HNyXlZ7w2aaoy1pbQAKaNBC5f0L?=
 =?us-ascii?Q?XZTv3vOpY54dyTM4DeKp/HLHK5mO2hih2zYEbRj4N1vLJZV1CyEyrxxfEttJ?=
 =?us-ascii?Q?pq4b6YQuN7oeYIbHjqy8Njc/fslCWdA4McLQPraTacGa+ItPgBINVC+zqrT0?=
 =?us-ascii?Q?FQkx3YgKDpvSPfrQlfhN5A+v6zK7imTffWb8Txt4slYiU2vcQbjT7xsAaL9x?=
 =?us-ascii?Q?JIVjq5gtYn+zlwTJh+GpLhtE5cVOU21gp++H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:20.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f58ac3e-a7dd-44e7-e83c-08ddf02ab6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
some log are for dGPU only.
Added check to limit log.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 269206ebee60..c4dd52ed377d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5622,8 +5622,8 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 			subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
 		}
 	}
-
-	DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
+	if (!dc->caps.is_apu)
+		DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
 			__func__, allow, idle_fclk_khz, idle_dramclk_khz, subvp_pipe_type[0], subvp_pipe_type[1], subvp_pipe_type[2],
 			subvp_pipe_type[3], subvp_pipe_type[4], subvp_pipe_type[5], caller_name);
 
-- 
2.43.0

