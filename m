Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18666EE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C313510EA61;
	Wed, 11 Sep 2024 16:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="me9Wg/v7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E43F10EA61
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ4D7vTgzYrhjzQ8hkQDH4ZHS0JcR3/oGNC1NAy/iE3cSZBQhG3MrJ1gsevb1v4kNlbfd/5q4r/CJ1nul2low+6+wlm6yT6RXaSTBbun3cGFU1Z2tHcOuqRKbYmadvnHZp/0l+IlDPZPT3LVN6jpbZr/zB398NkIGBuvExR+We4wfIRkczoanYpvHG5fbyQBRL0/QvNVOVj9nX4XRqDEqd7ZHIXNJjlWeNe+MUOA762R6GhnbsTRiG4yELXLd6sY2gS3N81tM1X3vDfl3dTasjpGyfsDfxvL5Iz7LZuiP7ID2QAU0UuMgSUeJJBEwJx+0I+rH5pqI87znEbzCdyTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d92Jofi561e9WWC3gAtfpu9kVAincsQsvYZcf6YXZLo=;
 b=SbB+DMJngFXbzssMshCizOLna/usmziawZ19hxDoUZaHiz5aDGzRJg0FdehCyrZDXhj7RpGPx0jJwSAunuyPcEVxe+G9nu+M8MC6ewZaMyM0khFQLy+0Nl9MP03T7iIE5tHued2MBDcBNRhJJqwviTM5rzfazJ+CgBmfCIetQUAYXucYVreSH+5rmTHxfIfI9x8gyjjaP2142i8y9I9kRV+imz6boCmmACZL+3KyC4o+fylhZhv8A2RLT50xY+tabmQ9V3v9a0v7TKHg70q7wt7UWmZly8YF59XslnCPHZ0ss9YglcLVbsrpw5PiWkPWt1sm7CtqeptStRnjSjXFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d92Jofi561e9WWC3gAtfpu9kVAincsQsvYZcf6YXZLo=;
 b=me9Wg/v7cFktivDU+urKCNhCAbHah0kP20XY+ERiC2cuNgdTVxTsYfyr7bJrXmJMVpVBwg5ygiUwjWpLmpvg3iLk60pgjGul5ECBq+a0ffd1+fC6Mdwd6nk4hXP2XAElc18netsGs4imH1M0eFxO7Z3BYSRffmAPXK6S+edoch8=
Received: from CH2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:610:60::27)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 16:26:44 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::9d) by CH2PR14CA0017.outlook.office365.com
 (2603:10b6:610:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:26:44 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:26:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 22/23] drm/amd/display: Clear cached watermark after resume
Date: Wed, 11 Sep 2024 10:21:04 -0600
Message-ID: <20240911162105.3567133-23-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: e36e2d95-7f6b-4f20-49a0-08dcd27e8667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2zUBG3u3PEpzjviE3nVhiew5+JON9FLvDBEMNavG6IY+iPALRiUN+OlDMTZw?=
 =?us-ascii?Q?46EJJMo9HOKlKenm6nEu+k74wegvONmnp6PloN5NyrANPiKsViJaU+P1VUtz?=
 =?us-ascii?Q?LuxWN/NFajhMQ5oQaoet9qNqsOcfgW9ET+zo4ma/4nWhn8BeHpj1KxnDLa5T?=
 =?us-ascii?Q?y5P/X4mYsqr+W8ZVyYtRajPvNB/uJggxePaRhK35ylmibjPxxiJNI9rEDzhv?=
 =?us-ascii?Q?KIcEnQB7xV5stew1perR79fxNOsawOSPltmaRF54mFUYSSyRkalY6m4EVanj?=
 =?us-ascii?Q?4fuwR/slWYcf3RWFPnWFNE7hFPzH5jW9zZDGCQcyhUFQ4ipgBala6DfB2D+2?=
 =?us-ascii?Q?sl+WbavwYDVC2E3brPNOVXQ51OA2G/33oqkcONxcP9CFfulIxvVzHoY9lgxg?=
 =?us-ascii?Q?hjqmfeVeZSo9m1WaxsausZSp/E1BImJzyKmHY24n7ZFjgntf0mM5nP2PGZkX?=
 =?us-ascii?Q?+ykmJV9qrlpV3ezJb0Nw89soffi4Ws6x+g978RWSGhpq/7iUiKkUT6VSnH7V?=
 =?us-ascii?Q?t0q9wQU62f30AUZgw679ku39+Qw9UD+QDpkwXj5/DcbApjESurznez6olzZS?=
 =?us-ascii?Q?Q5r5+MJWQQ4Z4BvyAS+AWtalZ+PnarQamVmTvWt/feBQHss2J/sWiv58c+yG?=
 =?us-ascii?Q?g2vqZ8ENcm5eXqr9KTVOOuSbwdBnNKJXEP27/oyL8twmal6s+6MM55azXTg4?=
 =?us-ascii?Q?/wSzUy4gaTaxaA8jOYfRLbT3ouEC36rqAEF+rhoLe0NJDd54Er856XMuhuPA?=
 =?us-ascii?Q?cDKyirVPFPMN4ASJdwvphkLp9TGDPIamCJMAhHeiw1UnMDjQ5U/RwsouCUGj?=
 =?us-ascii?Q?YQyLLNtQxgtFbQl1iZOnTb4wunLF178hvy2fUV4gqQ9EZBJXT6FaqRqtTANM?=
 =?us-ascii?Q?Ozc33Y5uIBtlHmY98184xtAc/A1W5aXjCUO0/5NOZBrurhSPXMJ0mwY3CKrf?=
 =?us-ascii?Q?TmJR0l9ZCcJvZ+i8S3Aklxelm5bLv8MWguELdSGFkQmkFBjNlw2iVY0yiAk7?=
 =?us-ascii?Q?CuDFBaPtlXQJYlIAd4cJE4/bWxy84RXsnz+QnXrsoCzMMhT+uphjXtz3h6sF?=
 =?us-ascii?Q?uAYrpytogq40UkqMa3c4zU2mU6QAFyy7qqiPv/1bPZPOwrxRUdbKGJMxFP+o?=
 =?us-ascii?Q?Y+xn8QNWlALOi3MZE8lmCnd8tE65iTYwWDtCyTD/fvEz3P+OJsTiNCvwGLP0?=
 =?us-ascii?Q?RgpVfPMBdRFl2P1VrJ7/OszAGOsfa6MblMKCsbMgrq53eEHNfTxAVvJuQEr3?=
 =?us-ascii?Q?/wo8cquBQR/n0SbmQfduuK+krwn0GJ+fuY9aqFYUkwjR6U5k+bjpXQ7c9goV?=
 =?us-ascii?Q?pM6hle+N53BZjxtnYtaz0inFTml5Wk+qwuwC9ct5q2YrEVt0hylLkchcF3kb?=
 =?us-ascii?Q?518rY8g/Hn05W1f/5uD/BElPFndUEwcIiZV8kQau771UOyELzl6MpBvWse7F?=
 =?us-ascii?Q?xGQ2Ref4IA2q/t2A3ri3FwcvYMAoNhLx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:26:44.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36e2d95-7f6b-4f20-49a0-08dcd27e8667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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

[WHY]
Driver could skip program watermarks when resume from S0i3/S4.

[HOW]
Clear the cached one first to make sure new value gets applied.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 6293173ba2b9..5eb3da8d5206 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -545,6 +545,7 @@ static void hubbub35_init(struct hubbub *hubbub)
 			DCHUBBUB_ARB_MAX_REQ_OUTSTAND, 256,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 256);
 
+	memset(&hubbub2->watermarks.a.cstate_pstate, 0, sizeof(hubbub2->watermarks.a.cstate_pstate));
 }
 
 /*static void hubbub35_set_request_limit(struct hubbub *hubbub,
-- 
2.34.1

