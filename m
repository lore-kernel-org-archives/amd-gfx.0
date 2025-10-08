Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A6DCCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903BD10E8B2;
	Wed,  8 Oct 2025 18:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SG/yJ9ag";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E887910E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaRyQbKGeg384gp+Fua4LEgRFAc0SRzGLs/U7MKg1mu7wFglNWYXmfbUT3ki+nBXD3buRkTDlRibFg3BIV0dZwQHeJkzbdM+L3ELx0xLXOCaDlQ9ouOYRveDOYapVrkZiOlEcJWYMYqny35nNSU3vlqve/P4LN+AeYVeuv+IeVCVqM1JYZpyq9YPlNa5mVg32r1u5dW4oUodSqG+VtcMAOcc+1jjalInagMmeNWet9AUt051dyPY1bCYnWDD1PqP0kFL21t4dRz37TP6DQMmhOxuao1YtR6CFZf08qBTqIXZVQ86UX47tCa/w/fHms9DwlFyGU3w52EM1finqdb5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqtKvQrmuPPE+3OneN0YQxS9WD+Hak4Qg/C4HzW2ohM=;
 b=cdxIpASIUCXGOrBuD7gAVmTtR61ewY8254juPg2RyaPE4AILGPCO13ri6u6aKaWubreJxnsE1uW0CYBXP8lG01RGoICTkdBzzJAOFlCkb0xR1seO83OyaSPdzFop/1M82JMZp6erdVm3Kp8V/tksTb76RiIrtnC5DxVbxT9MRybC97L7/fHKkIwv8GiZmyfY2adSMS10lx7+HptW+7E2IOCY6mL1Ina+V79/lqq6wPTkifh0gyXau8UN+/Df9ms9IMUAL3FbnWtk8NsaEID5fsxns//5U2LCj7HIP6cqGo6/czWHUFi6QD26e3na/kXzmmRSnNNb+fX/MGneY6K/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqtKvQrmuPPE+3OneN0YQxS9WD+Hak4Qg/C4HzW2ohM=;
 b=SG/yJ9agiUaiNqg/uhJ8JNAhcPC3GdC8+uzXuUf+mSzweLLppamYqSY2aJM06JQK6SX6NKtfFivzhLO0IfVwM6f6kOMDXcXvVoGej8gCHjQ1+RBCLgKOe22cvhLxDVo7Q5BYbo2gw+jQWhTAauMJHKwr8M/GXFqusqXylFv8ols=
Received: from BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 8 Oct
 2025 18:49:38 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::8d) by BYAPR06CA0070.outlook.office365.com
 (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:55 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:55 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 22/22] drm/amd/display: Promote DC to 3.2.354
Date: Wed, 8 Oct 2025 14:47:16 -0400
Message-ID: <20251008184839.78916-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: ee230bc9-8957-449b-4173-08de069b6f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOm8lwlJb5JVGLsZ5b46jq3tgAXtbNGKsg73QvSRN0aZwL260ItATdyVDz8h?=
 =?us-ascii?Q?74Ty+UAMNm+SBRN2gx5qnjlWXV7Mt94GEVJ4++FXHTWyyWLSMyDzmTDs6eQ0?=
 =?us-ascii?Q?UI/G0myNsXsg4plJwG5EGKS2Vfny8bvNG6XFABfvjM/2V8+DMixX/FPjTsDD?=
 =?us-ascii?Q?nkClu00Iq2j4vhZXEB0O16sYNx1PWeFWPfHdrUVS4uxuGZknv9y2OmWUcqx0?=
 =?us-ascii?Q?Dz9QWKtj6FdI7KfIhhcNgfmeWg2pGnnkn0CKW9x6Nsh0nANa6ANtBYXHJTss?=
 =?us-ascii?Q?HNyib9utDSkTA29R1JIHBZBhtKbzfwkjrFh6qD6v/9ehO/4pcu/LN3v7jK+X?=
 =?us-ascii?Q?ROgHf9nf25PHHt7NKFO6l2yPaswCzzB106cHvpyqbamC2viPC3vXoBkzjipO?=
 =?us-ascii?Q?mNNpejhixz0Znrgfuslh/k1Nr69XZtvlV2Az3SQrYWBobS8DyXL/cn2EyVn+?=
 =?us-ascii?Q?rxMsY2m3TTivCfyxnjcZGSxEWguMREy5LYFoiYqzBnD0Wx3t/5PqP7+6/k7d?=
 =?us-ascii?Q?vfEEkIhImLmdB8vwJFXVNksujpUwSHplJB20HzXTYwh30f43YV7Z1uKEn2GF?=
 =?us-ascii?Q?yU7zyxHoVf9YyeIDyCO1QYcv6dUTgRIEfeSNa/0DCiI4qyflWQ06nTx/v5n/?=
 =?us-ascii?Q?rTntfiA+bUu9W5lsLZWXdKsBuLxmI7QFS8WRwmOy+ciSOC6/3/eAVGcUdKSI?=
 =?us-ascii?Q?aoDPzTfVWTe90R4MWzZ5lRjUgI564mRIKuaFqig530aFzh4NSXLcD9MO/jpn?=
 =?us-ascii?Q?rLi6OQyrImwHjt6Iq5OLyKIDPvu116m3F7qkIgMCVRC3SeCiAdvsR00JmI+J?=
 =?us-ascii?Q?X1zeYi0yjMIvBUBwSJTCSrj7e5c9/Ft/r3K3hIY1YL5zPy6EA2euhklsVgEG?=
 =?us-ascii?Q?3iUJLlpJ5Svw9CGuFJd1+GRoW0XjUBhKphckj/mtGz7XyufPeD5ekX9bvWET?=
 =?us-ascii?Q?pto4JoY7031+FKH+aopEqVFWoYNYCkEb/eXjUH9/oUE+ljb7WyCBcsRX5eSQ?=
 =?us-ascii?Q?IBaUMw0PJqEklIcX2k3q5fgUAp6HXrdIhCvZtUb/nmcBWEDG7Gly/zrq3M/O?=
 =?us-ascii?Q?g9WxCYFjyVMZGJ3JMx2kGcsTugMB4C/TYreakPtO8Ad3/YyWkF7V50xPi0Nv?=
 =?us-ascii?Q?A47YjVvvHrURW77DOcgUBQZ/iiKEnl4mkUwnuVjrl9rgUsDmdIoNj7l+2QLb?=
 =?us-ascii?Q?aAO0Jfjz+r2dQpuhyE9GCuqlrmq3X534mtoQqpbwCjam/RjQ5oNhOD5iJhXY?=
 =?us-ascii?Q?3JOPvzhtjnP4k6kd18GatVPieUacWGVKv8f2eyLLZKdqWGGgmwmTSlbkBh+v?=
 =?us-ascii?Q?YKB7/YuRHfvfdihiYQmiWd2puZXXff4iKKxi+ayGaQA6gjL0V//YzazFk2vS?=
 =?us-ascii?Q?PC3fm9SMs2NBGffoqMGR1mN74mgebtN6We3muw7NAPdD2w5irwBwPhiKRzYu?=
 =?us-ascii?Q?YyIXDOprQVozHR4Yna3zRRQKywnZZN/mAmyYM19I11Aa+PiJ3GOC9zDpVnAK?=
 =?us-ascii?Q?MVU902wfa64MFqIEdgHtaV0z1+sNhcPJbazjMKWL23MXc+K1F++CK3yBYv6s?=
 =?us-ascii?Q?YCLwaIaQbUSZ5guQk1U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:38.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee230bc9-8957-449b-4173-08de069b6f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

Display Core v3.2.354 release highlights:

* DCN35 dispclk, dppclk & other fixes
* DCN401 cursor offload fix
* Add new block seqeunce-building/executing functions
* null ptr fixes
* DPIA hpd fix
* debug improvements
* Fix performance regression from full updates
* Firmware Release 0.1.31.0

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1a5cf81e914a..b39ed429a312 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.353"
+#define DC_VER "3.2.354"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.51.0

