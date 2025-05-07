Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91343C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249CA10E73E;
	Wed,  7 May 2025 02:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zT5p+hFX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF8D10E73F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmgS3zc2m0K9OUxVY+8TNB5K2VdcymUi7J+GnU/gTg2bCqBJ4Pn+a7pFU6qSBCMLKAfUQb9KeckdiH2YUkqOgxBsbFq4lIfVeRLQ7w7LsjDmVEILdIGq0mO0nguYomttQgP9JdtkLbDLcj1uNaMHpBPmdrh1iOE7L/s9LuFKBs8nGXHTP4DMHvLeKvlJLhAhg8B61lSdbRbY9aiI2k9oxM2NrthFMd0a3a0DqB1/+aFhQUcRI6itvZUHDhtojpqLmyiieFCAvgXCnIUJJwSgQUqmOBCvAnu9k8eBWP8qKfieOCc4VuC+IEbq9C5NbLU1G6rP/8s05QOc2fA7DQNvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXFJPEeQEGJHbIs7lhK1YGhKLANiXHHvMVrmSDicb+I=;
 b=PAdubu/Wya8ST+ZLTx+D2t6HNt9BiwRBz42Md+Q0wUtwE8aUXjDZqstCZ7Ym1qBY3fIgVZ+OHG9zxucVPdbXzdT20Xw8dgj/pcWFNqa8qo8iEPzGXbSiZdrbWdnPv1mOWvSKhWrGv5HHSwYM/Vb80poxA91JzRdpyuQpXm1WyUHCKn0mDUc8jJfinErf8LP30tKsiUd8o/fkqln/P7zrbgb68BE1oNJds0ZtsPldoiguZNNMq6qdAEX2eQkjQZXZbmygUQbTk4xSDHpzce4NSNGRP6TbOxVW7XvJ2RntRrBKHpR/Rugf438qocFu89SWqABRuH3xLbkDXkpeg7zwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXFJPEeQEGJHbIs7lhK1YGhKLANiXHHvMVrmSDicb+I=;
 b=zT5p+hFX6YA9U0DAMS//K9IGNSdBRcm8Rl9NinKHYz7ST+rJree+g/uZTcS9k1DQBoTKp9UKYrOxvYDMPtjpn5Fd5T6ZM4MosHW3X/6fCTDq8PKMS6dvk4MQvNqx9WuoGdzDYVZn5a2PuBoJBNSjZ4EAARs/HIALMcyPHzxdiIQ=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 02:44:09 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::8f) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 02:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:44:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:44:08 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:44:05 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 14/14] drm/amd/display: Promote DC to 3.2.333
Date: Wed, 7 May 2025 10:34:58 +0800
Message-ID: <20250507024242.1928299-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f495471-f312-4134-a775-08dd8d110ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x1FOrGUSH1sIQ8NVLPhm3LgM6/kIAMvSrK9KivTiJ9JaQO8WGDC25oYpb7DE?=
 =?us-ascii?Q?9EN2c3WmExDn30FV9cejQCfuWhKxmQ67Zg0s7zIX8rEcOk6h//4p8Xq6/+HC?=
 =?us-ascii?Q?Mb05EYIm2Z3zjTkWA8pX4NMUfozW8fuCpYb4x5rSMeS2vCMV79fNwUA10YsT?=
 =?us-ascii?Q?zJNXLaoNSyxjxZlDOAiOXGMcj0zpxQUDMh+VYYYtIInG5EEVB6JBmf6PvhJL?=
 =?us-ascii?Q?iTm1EXD2OF1COoqCKA1irgs6xqj3kecGoYg/V6E/TrlzyjIy1s553rywGg+V?=
 =?us-ascii?Q?Uev/zV0GKZv9IlWOGsSOCTjGPAmB44I3i+7xyOeqT1XqZBZmjZfsEXv4ETe8?=
 =?us-ascii?Q?IuKgIqs1LgBXGT2/BvgyN9A7Nn0GehFQtm8x4yN//1Z8PQ+3EH+yqbSGgCH9?=
 =?us-ascii?Q?3njBNU7tXrzQeQW8yeA9E1i7Udo/37KF+qd3twlfX8Z4kvKXOPR0sqRHr/Be?=
 =?us-ascii?Q?GqhmgE0Cu65lDNf5MGz2t1VpkklrztQ5UB4BeYlkRAXTsZkKkDVV2wAoBXAz?=
 =?us-ascii?Q?MAnjjUfsW2ycFS61zQtOZhEcAxQKvuENpWuE3oJuMP884ug0/pXjRyFPTW/9?=
 =?us-ascii?Q?fKo4+tkrCZNfYWEEIFPgITMbcyyZPLu9XsEeqkNzdg4RnOc80sm3fl0zFX9B?=
 =?us-ascii?Q?k9TH8PSw9+1vak9LjtoEaacK8nrooIfmEVWY+NJczyZz/DNseYboHWVa+IRy?=
 =?us-ascii?Q?Jb9c3TRN/tcHHtLkzoqLQnxdtHhYhbW5FrpSvBDdoL6gX7beKQ3A7fdx7ybs?=
 =?us-ascii?Q?T0Ez2pVDrW3P54JbBVQuFRhi5XtaVs+wbZL/5k2wBT4kJLIPa25fEY+C3mX/?=
 =?us-ascii?Q?XC6BXMhlXioIHJJsjvQZJwWEHNxybK9pR+lI+GSesvdMxx2qv3DTbk+j8HCD?=
 =?us-ascii?Q?Qe3yVveb7q7kN2STpPL5Yua/I6vhXuuwNyeAdmpKEGjVjKyp433LmlLXHrQ/?=
 =?us-ascii?Q?jwjMq0Nh42clsT8SMTilQbeFCBRnAoGGuRXreCh8y1NTZiwHuOsLCYUbYiCp?=
 =?us-ascii?Q?pY/hCpA4UmPWWMjzl+g/vLX3u1VxVUcf06Bf3aHjK8WxE9F4Z43ONo6GiPKa?=
 =?us-ascii?Q?9PivOyJrg8vuwviXHdNv0ko2UGh+JRlGuA37MIoukPSXPlvrG1WhQt/uAFfx?=
 =?us-ascii?Q?rQ1lB87MV20XlXqZ6/CtkkVGsLy3/Xq2A/amROdnk5sSEFcWdendTMkh/EU7?=
 =?us-ascii?Q?xXoCNFbgo5tZBOmW5t5WlKhpXiexRWfRAd8QMbLD4DdLoxONxQ4L22HiIfkT?=
 =?us-ascii?Q?nLGgxzkAcYkX7CUK49HD7bikxm0UUmw6RaLspPPTDdBMT7hy+tCN7vqlecl+?=
 =?us-ascii?Q?R8swNe1MDV+g4z3TjSos7Y0pb8jVyWBW1ZZnNqY+z5dwtR+BCoeeWR2K849L?=
 =?us-ascii?Q?evkuw69RpgMjYHNnbhTOBJYzg5MViASlFNWdmgvrsSp03GFPLi4zsj/ycHdI?=
 =?us-ascii?Q?a0elwIoNA8Jlrb4+kuiX+TVHr0gUwirOQ5tt+lwzgu2Z/pGbNEU7g01F/V0B?=
 =?us-ascii?Q?7tJNPOgxqLTn8tnKtLlPhV5PNjy2xIkzgW94?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:44:09.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f495471-f312-4134-a775-08dd8d110ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary

* Refactor DMI quirks
* Fix link-off issue triggered by quick unplug/replug
* Fix race condition when submitting DMUB commands
* Correct reply value when AUX Write incomplete
* Backup / restore plane config only on update

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2230e36c4f12..c14390efe633 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.331"
+#define DC_VER "3.2.333"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

