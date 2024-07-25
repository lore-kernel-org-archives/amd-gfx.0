Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554C3C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAA410E8BF;
	Thu, 25 Jul 2024 18:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tqG2XcIS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AB810E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAxj5/8FjggmOQsSA0Er/HAep3JmxIc9Mt+GCTsIIFeBnidZCvC99QQbMueva51tBKweuYpkTiFJgzJidhvKp3T7nvju0X2TM2EDK9ID12KvE5oJ7mT3yzBOmzPwcQBduAkiTjvo7iB8w5jgA1E3Su9iCouJLurAIhrXeWM5JSyRG8eIriet+mdGarMBU8zrTCagH5TDdVvzGgCm5PTg3TAOUU5QhyqmFFxsSh5G3a09ZFPn8yYOIHBXK4IjO8Ie2l2gKy1+7BeWkrkNwhIPjC0AsvHJXBwDDu8L9poA/fgiccbwqYUHz8ZVRHl2y7vhQchCiJnuINYtsrjWEQ7icQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKaZi+lRkKxWVeDKw3L1SaNzrtkGARMPumJRRayGmxs=;
 b=MbXHpr99/eLVuT/aSAak5uVBhcFtrkUrtZeBEJ2ihF2YvMKC+n1Ez9IdBo5Xi3rntkGaXHj4wppg6Uhjf3cJhLmLKHZBIRHWHJqvqGWnWF2YUeJohmSaVgYRtViuS9hQ2I90SMmyC8VsvLho3gMj5VffpXAqTOnFpUaRsL2aqJ4T5JqcNGsdt+nGDJwk5bdVHb8tknmpjpPrrxnOigFD6C5KBsTUZRAnAmed5kLGIK+VXQDPNXxur9/QX2sLqtYNmmGK2cYtOJdVDVL+p21ZQqzWhNOR4u2KhhUihImPHOk15utFQP85IjO0gGPH175vkm2hsLlIrEeyFMg1ateOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKaZi+lRkKxWVeDKw3L1SaNzrtkGARMPumJRRayGmxs=;
 b=tqG2XcISijRrl5r4lGAyBEgGqjW8d+pg9mzaHHKLI/RrkqEUt9anLt0W55oE5/FZvVV/veA/lBRcJdi5cc9H690icID3RMbjFDdAqk4KSxpQGcx3lDxj+1wcYAMwap0qIjkjsYZlaDD3wRX8GE3lHckpUfHkTfcCLsDAIPI7tos=
Received: from CH2PR14CA0056.namprd14.prod.outlook.com (2603:10b6:610:56::36)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 18:04:42 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::d3) by CH2PR14CA0056.outlook.office365.com
 (2603:10b6:610:56::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 39/39] drm/amd/display: 3.2.294
Date: Thu, 25 Jul 2024 12:01:23 -0600
Message-ID: <20240725180309.105968-40-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 31785af1-f8f5-4860-5df3-08dcacd4426b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JojzoL0FdgxNjMO0y9KNabzhqgq5G0++10USBeLcnYoIF8eyfc2ki+mipiL2?=
 =?us-ascii?Q?fIWEamdX4ixNaLBWfbdmbhTOnqXJaundqyMt9lHmssyL5kS1gVsJSMkdEYb9?=
 =?us-ascii?Q?vYXGOJWdIzHOvTBCt3nEEFNlgqR3Z3oT4abGfVZmtw+gmH9hqj+Cp+ml+Z+Z?=
 =?us-ascii?Q?nZt7gttXn9QucBW1Sf76giIyTKanDeQ2fdzFj6fr5aGt+N7wd9sz1t47UGa9?=
 =?us-ascii?Q?bUVqZ3yDiJqnb2xyp1vKlSXaInauNm0uFaqT880YOrthvqrVW4bA3VrJqitq?=
 =?us-ascii?Q?EO1auMexeqFETONY66ToTydDFscSFQeoHjbaYfwF4fkkq/xqHYzRxVfRayWY?=
 =?us-ascii?Q?3TP4U1HVvcO6Oh3VimKruOn/ERGlrd28Pp+uJVblCxsbhy/szqsU9m92gmKV?=
 =?us-ascii?Q?SikPmDAxlEg4/ibglmzGomhKRUAy/hvE0UNvCrVhw6EVjoLeyXflieJRpFrj?=
 =?us-ascii?Q?E+WC1Mapw5bB2qaZ+8drIS2cjapT5i4PK0Ue7oxyyRlaSGBIVAl+5OsXk2pv?=
 =?us-ascii?Q?SCRwd8IkBOsxxd1cwzvac+/Rv4eH/onoUd5XUHPGqvxIQA0gZ4xtbwExUpfX?=
 =?us-ascii?Q?u20ZPDZdgH70OOhojVEcrxsGwHEVQ2ndtSvRLMBr8pLASP5AvgXXMjTgyd2Y?=
 =?us-ascii?Q?Y+wlKGW7cQiwgrEa8sCcIqVODm+ZVbQlf/z4Qk0S2kR6fMCrHkbcz1iH3q6E?=
 =?us-ascii?Q?bZY7fnTdl1wfeBwURghu+C8yb7ezaIqBoDkX6DVSL0/vMj/qfEEtgnZt8nrw?=
 =?us-ascii?Q?NerOra0cdiQQJE0S2d4AbPz3JJJukxKdagxlbCP0XkgWNIqqAOHNazLRi5Oq?=
 =?us-ascii?Q?YwcELZmcP7sClSeGIiGGBYrJygrGd7SY+SOZQdpXnL4RzS2WhvrVw6OJ5W/w?=
 =?us-ascii?Q?RHw8jOImyeNIF5DnLUV+2cFC/7alEmvYNGFYUAtEV+FLd5JbJlSpg4qE9g+A?=
 =?us-ascii?Q?6lcSry7on3f7T+MEvS28a9SaXBWXJgoKgT46k5VtDQiQecuFVVc30A7Yp/3O?=
 =?us-ascii?Q?YIob02rZPbtv+MuMopfHdMCYq3kZBs2PLcEQ/Yg93IgtdZ4fG7vLHwZ064VA?=
 =?us-ascii?Q?5FmLRoW0oqmReTl6fn1qVdQGN6WRXJa4GF6l9GzTGOF1jAbIyaWcNhxUw2no?=
 =?us-ascii?Q?edzgw7XHgc17XNfKcV9w1IbCd2MhH14MSZlqkjTLMkuzdNgn6fgy6qW9kmzt?=
 =?us-ascii?Q?gr0MH8Icrk4hDed56gGnKwqQusscjpFNgfaggxWoPa0FYV3LF3fu+O6FYtZM?=
 =?us-ascii?Q?jx3ZoN/kN+A3ZmiGBSro6jQJ6aTShExh8VeDUObWkYCFfa0zPYe9Q99Wj7+n?=
 =?us-ascii?Q?kdOG35OBWtQ2DgpxmKrosGkdq7eUReSrAXpjSO2+K+Db9KcgIgqBoPeIhsP6?=
 =?us-ascii?Q?TLdlyYvvRNiC0lTy6cvPAegowm/QMSc8Py43rjGW1ZOeBJAY72jkZgq0XBNq?=
 =?us-ascii?Q?g9dOghj+zLzmC+/fV/ebKmQl5JprSvmo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:42.4488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31785af1-f8f5-4860-5df3-08dcacd4426b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
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

This version brings along the following:

- SPL improvements.
- Address coverity issues.
- DML2 fixes.
- Code cleanup.
- DIO and DCCG refactor.
- Improve the PSR state.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4077c1ddb9c1..250d5d48c2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.293"
+#define DC_VER "3.2.294"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0

