Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7252ACD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1450010E79A;
	Wed, 12 Nov 2025 18:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HcKm7i7Z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD56610E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjvGm3O/QipAi+8MZLpsRePI2NINDX8M6OsuaJv4QnAt6HaWQYTG43J9T2QInC71hM5td+8TQ/UQfMpZhwDRZP0HGO03Vdz5xNwoFpkdAZjldYDXrLI4YWPG3zY1BxK2Tyb69jJTDQ0KnLzQqduL9wOeaLazbrEBy7mLXwbl4AE3RyJHahdoB2h86xP/9PWEi6eHwcvODXioyCVvFyc1EjGoWhscbnTxK3CaUpnKqMUxtlptcLBhJFNZA3sAYD1+Q1sVOJDnq/LrbiMFe1GLchKyfpDsd3F+8ApJ/5kxjco7W8CUBr6wv0RK3trM6YGa1TpEXLCM+C9ia6f2xfUuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCHdLFF8eqVOGUxCqKmNEQCBBiiNX+7jGO+tf28Qv5s=;
 b=sT8BWXIk/JUdbX3ojBueXxUbe0e3FT/1wQM6mhIhuFmX+GLiHAhO8CyHKTjfwwxqNwOKZBFJeOb2w6v/O7nX2HDpOsjCtZf+CCPfSCyq5lFS0H4pb2CcJ4iBk70oAkIkOLhCh37g3cKupLM39ab7oZd6bDgmB5YqNmHRMzx8XeaMfhgtf4M1wG2wfP4BDzsx7q6jtwjNH2h5WlgtLrq4YKGjH6mmJfOJ7XCXq9LYPYYcMhfJFzPzo8B0nhKMzQ8mK9klxsqbBY0IzYkjFw4jb0ZNAtsM7bG8yyZi8GgNcIanHwZ/o+YRNhqtdJ2kU8TAyU2WU3vR9pFyC8Ptyk7L2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCHdLFF8eqVOGUxCqKmNEQCBBiiNX+7jGO+tf28Qv5s=;
 b=HcKm7i7ZqH/mqcMUeSW5ErT6+7wbpSfaFRGOT1YQAqfRD8KO+iBiLy5oScA1km+4O5QAiXfefrGml9AOepOwtq9hFw5rw/t7E9EUX0HwC0XDvI8DslPHT7SbYkcO6T7866WGbjEAXyjrs+tJa9LW0vgJo8e8Yeuc9wFay9hFPQo=
Received: from CY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:930:1e::26)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:23:27 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::fe) by CY5PR04CA0004.outlook.office365.com
 (2603:10b6:930:1e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:23:07 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:23:07 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:23:06 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 16/16] drm/amd/display: Promote DC to 3.2.359
Date: Wed, 12 Nov 2025 13:20:34 -0500
Message-ID: <20251112182212.559007-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f94861-21bc-4930-ec45-08de22189221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PAdzT0/OzzQQqizGsO1Cq2BN2oNOhQLB5BjpaUOKOSm58OCeLVCpweBGGAd2?=
 =?us-ascii?Q?okfS09qSaQ1vcSrUOu+xoxhMPO4pn1IKzi6p/OXsscLcCF204ptK90nRjDGp?=
 =?us-ascii?Q?GkgA9vMozn0UM94tiLqL6nxjbBAh6Py/NvkMFfkgtt1N3/BLBbeHWrv13Hcc?=
 =?us-ascii?Q?TPmMmXWcAJu2fJBo/iZAsb3pTPqXuI0lruqymrRznVeRN2fZnuuK+lo6ydBE?=
 =?us-ascii?Q?6pdGb7n1zilYIH7Imcnu4gzWIsSvXv/aQoAVJZdAm4zak2XQgIU4rUGg2cFb?=
 =?us-ascii?Q?QtXAxew1J/hWZkemyxd8xQOE4Bk7j2oF/OSsic3o2/ISou/BFPbny8tYIjc2?=
 =?us-ascii?Q?rmbn1sq7ftIj+3lzcL8Tz0baz1p6vnfHd3BJ/A2oqVy2Ov1oGlCojM5q4+HT?=
 =?us-ascii?Q?VsKHTHVXT4o1HqOy0qUrZdumKquNT9n1iRSHyf/z9VzGEteC/RobbWMJam1n?=
 =?us-ascii?Q?cvbruMfsQHyicpnLf0K+vlaJ7ui6SBNbQ3Jn/k1jcRMmV9dhbOQ7uexCONTH?=
 =?us-ascii?Q?4mXTU0alQhzAlvB8IuY4zoC+XMTUfpPyXnlUItGSLehYQO9dcyhwsrDB9jrs?=
 =?us-ascii?Q?4zseB6oBQw8q9N/YuAiWKwnciMpec5tZljCWaw3ZAdgddfXOxKYZYbu63aL7?=
 =?us-ascii?Q?+UQGUtG3TeulDvyfQLbACoQfLcoI9Wu74SEo/YkXL/hZHjdFoyVmzBX2AJaI?=
 =?us-ascii?Q?W7mtFeW0rQB/lMWe5/bIXuc3Y+enhByiHmNZBstakLyOjfWB/oVhQxleltxA?=
 =?us-ascii?Q?GGfqrE/LL3cYmilIM88vAO5HoXpdSpzA+++2Fvs0Xd07t1bab9dX25MzZePL?=
 =?us-ascii?Q?a8LEGp9xVHJKLcJUsuCkOCLL1pi/ZOwiD7R0YI3MHW2S1TvmnzLQZrHRFH3Y?=
 =?us-ascii?Q?CcbLcFub3y9WtCmi/orOc1PsNZWU2Y7x9TS0Rp4GiCd0pSbGJxf5kWQeL1gh?=
 =?us-ascii?Q?ahsU+SjRwNyj6vNIPmCyblVPpCNAXAaT5TLM71CVOtyJT5ZokjCdt1w9K01l?=
 =?us-ascii?Q?TfYSdWrLmfY4IXEMz3Vh5WfXitV1tgLOJHMDAiCBDxmZd+hXKhp21J5gLpOJ?=
 =?us-ascii?Q?7jfonsPGjp31DdnKhfVY2AIAer1V28QA1va+CiRKw/viArvAiGsgi4YCLDg+?=
 =?us-ascii?Q?gM4bH4Gg0Mx1cAjt/Eil+THTdzVX0gYmrnh6WS+nJqloJJGwMlk8NsCSGQqg?=
 =?us-ascii?Q?XI2pFUodM0D3qqBBtjfo2JydVWv+wGuUp+VPvnBt8UPHcksJmovhRS6rmE7h?=
 =?us-ascii?Q?BNhqzm8MjDR5xeG9mpuKpMPYpo1zv+p7puvMAT988T9mUPOg9IG1CgEmwXf1?=
 =?us-ascii?Q?+Tz9niZZEmVHfw31k3RVkf2RmTWj7kk9U+/PJ3f1olWUhspiLBGho6ueln0/?=
 =?us-ascii?Q?5YrXGYRZ+efrbDjITPPSqMXOCxHs3Hw20XxhwEEQFQcO7cBieOaTZSzQtrxH?=
 =?us-ascii?Q?dzkiQnMx1bbxO1iZ5dleWgRi2bgVIM2gwC0xCl5WPNqdI6OcQJaJH7KFJHFw?=
 =?us-ascii?Q?eZKorZ8OX8Yp7VLr9MUSgbnZYsOilvMCbnXByILp8vrlGQF5lth+K/P2e0Yf?=
 =?us-ascii?Q?UfcDUdFz0GoZhCK751c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:25.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f94861-21bc-4930-ec45-08de22189221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

This version brings along the following updates:

- Add interface to capture expected HW state from SW state
- Add panel Replay capability detection, DPCD reading, and enablement logic
- Re-check seamless boot enablement on subsequent dc_commit_streams
- Improve DPCD link capability retrieval with increased retries and per-retry delays
- Add HPD filter for HDMI
- Add pipe topology history tracking to DC
- Fix MST initialization on resume when switching from SST to MST during suspend
- Fix double cursor on DCN20 & DCN30 in non-native scaling
- Check DCCG_AUDIO_DTO2 register mask before access
- Fix pbs to kbps conversion

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2016d75c21a0..4205f896aadc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.358"
+#define DC_VER "3.2.359"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

