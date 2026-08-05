Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5CEC561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60AC10ECEE;
	Wed,  5 Aug 2026 06:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RunYAxSg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FAAA10ECEE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEO/YUeUTIuuoaDNYjDHvLNOUktxWLsbAS1/S6GYao9amTnzNQVsHbbrDj3ulDdCB5YEdZ3Fl1/haNi31hb4qJ8nL7dIwlYTCSEkcit7RQubVwlUzQLr9ZvSykggUPvRmYRkz2c97xNlBTXGoxOoEM3pRZ0at/xwDEIFSHvFFN4+NdaHHl+0amEGmKn27qvjq5I1ZXLHhPdkoFT1OQXyfB12Q1qa3YGc8pYDWNxgbhrkr0Fup60Exv6c2mA2gnD7vc1BLBB4Z/EHJPO3BhKDU10c9NSF5HgY9MT+KuPICkJ9KwbEGKx/ukkpxUs4zjVrvAZzkrGqqDTm4jqjtr7rDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0/alV5P228uFFCgz48fVX20MCN+heonpDupEwKjqX0=;
 b=Sd1EOe51sdwhZeP3DmS2X8luOS/0u64TQyXsR+VcLeJD8tHhRDy8FOpksFfdloFH6FDhAN3acUK8SJ3AUIhq+5gLY67WguZNoqnQtuA3ERbdQroCYM1pSdX8RYaNnzvIa8ffdlMDhO5joF70HoYcb/PzeiDW0zpxItCa3q2CSqYwM0LsRKA8ChzetNhq0uFiG1VqYhF8eIFat6ayD0+HjLLlo+yH52OabpjVgRKV4ubgwLM+VuctujDP/c2VobXvozvik+u/PjPVGlfi8mx5AkLD63JrAMWGbQFKGNxNyhfqgJN87UKw23IUtdMiG7OPa3YaKxeiFv43VG+MghoZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0/alV5P228uFFCgz48fVX20MCN+heonpDupEwKjqX0=;
 b=RunYAxSgQF7fA7waQTRuqsUVXz0mJwkDT8A45qLE3nQzgYz1T5IqmlK9ETmb7MUshrxQlMb8E9qwogSqItatkjHWCrE4tO9Qrbh0CmW6Hw+1aOhDvZKccir0ajTFX3PU/LP0ZXE0USGIrg92RYFzN0dOartnrne+DoifNMOzRCA=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:41:19 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::36) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:17 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:09 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 21/34] drm/amd/display: Extend DMUB wait for DIG PHY
 programming commands
Date: Wed, 5 Aug 2026 14:36:33 +0800
Message-ID: <20260805063937.2145774-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: e56e88f8-3202-4a86-6411-08def2bc8e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|11063799006|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: je/i3sVtPK0Xop84PG3TfbrN06SIdEnqeQV2HXPBrsjXxwAy7y5tG7/lfPMjU7gdT4u8DCISD8/8wL5hOBzgkFX3Y3dWBumojxVGLFznNekTDTG1Io3jMeqbAwQKNJrVW68X9NyMS572vbEq6iriVH9Ub4K76g9soYQeBJDFQj6kirmFtHlBYfiVM/GXvPGU4O/bmM/40Zt0h+YNUMZss71ixw2jPAQ0/nwfLsWseJYWwtAOyRYv0+SDZoBlTmfiS2QJXB6ycip7+2Eb3GBokSXtuYSODqTJj53pS636jRhTcXlj40bvgvclevHAL6XVZsWTUg93jZnKgA4FmQ0C4qGOXFCpM30/3bZWHeHySOXsWMUeKVIv/7ziS6ikVGMft7DrlnspJn283c7gPduy2cp7/g77hZbo6vGNLLsbIEvKglc7XjMI0idSVSvDMEKT9eWfFPryGKjXfcWHBalBwH9IFvOXkgOaIR3R6GtvVliAwH3rpP3D6v+GwltnKkdkmiUBUfORjXDm0++vfPYQMcfDKQuM1JWr7EYvOv32cIXxheZv44kdOLB3cMrtuf+UHFlMLNCZt7Y9M9tDYaUV8vk2YGj+GzDoCYHVbGocYXkAVFgjL/cnpB/ptS3Y+bwiQVL9y1PeV7345SPN9K2YZCzKTUXUywbcPmSSn/6cenEcqyZr4k5eyelUzru62ChVMtp2HGxwrVz7vXsJnqliyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RA1vmGEgHok9o502FI87mHRbpW+Q7J4RAJ/bBVrZzS55EihkEXB+pqSHdTjWVCqOoHAvfZrcAnbShm0nNQ+szs2f9b1uGc41+FlwElDXjWRLLonRhRveZAfjiDaqiL2xeu2rj5yA48V6QJf7yi1G/nhsFquQaTKnx6Z8Wr9jaG3FA2KNHItB4T+LxYoauRPupavZcJ7e8Ebv3wZnYZvJYq/67S94fUPkIJEh/8NdN9so1+QNAygGtA5K2UxMyIWncfeNzLr0AEdU+pT3nVpp1ALqNPL4rFLlYAyTr8c0Oxf2cKhhbgXbAzc9c8kkCvgq2VBiOeQBadUUQiHhTOBdkLyI2f86G++GEnyFpQoDMZogOkfni3HHR1HGDQ9ErYqWKkQY+v7I0Ibnon85szjKt363wlsxt4q/Zylx3F9/cLxeauR+fwEU3doRW/E33Qiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:18.6838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56e88f8-3202-4a86-6411-08def2bc8e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
DIG transmitter ENABLE and voltage/pre-emphasis VBIOS commands can
take longer than the default inbox timeout after amdgpu reload, while
DMCUB runs extended DPPHY polling before advancing INBOX1 RPTR.

[How]
Extend the waiting time to 500ms

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b9fd375a3997..01864fe816a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -41,7 +41,7 @@
 #define DC_LOGGER CTX->logger
 #define GPINT_RETRY_NUM 20
 
-#define MAX_WAIT_US 100000
+#define MAX_WAIT_US 500000
 
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
-- 
2.43.0

