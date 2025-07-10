Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F40FC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19CA10E969;
	Thu, 10 Jul 2025 21:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAG+m173";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA0110E969
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUZl3NjlW3bDtpR0+3Rj+XLWHcWvVDLmMm7kowInMFxTw4eUSMjjDg/PCZB8JduQi/j7U40MYjv1kksBojT0PaO4YBP2cV5k82fuvpB1r7jiSVjNIKxGg4Kvo6JXy9GNZJjIVuk68uazhq61PdHk6pRI8YgWYOJXoFxsAioDMkDT666JtTAiZFr91CDcOrCovDd36PoUg4z8Frm0PWm4y5jFqgng7bB/cp/CtMxyoivDI9DCjxr086IqntCuDD5WdDTH+yp2Xoe3AILq5aAo8t0miwJ3qla5us4GTd1bBpQqRuSWXYKewrRxps2CJhSfkqY6Uq1XSOA+ekKhvCTwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aQpgkBPaDuEultdN2DMMjzVQXpbdO3p+FT/YM96K70=;
 b=dcFExk7IcrLfDB/jGvj9rIrsoNk6h1hGL0rX5BrawEM+Gv4+ccQdcXyCIILPJjEaj5nPvulXB0ZtD6d0fsLiDXHf68yZ4sDAB6SCLsJWnNSjp0ahoIpDP3yoiaFgmB4TFHA3A5MDYvTt1z9hND7AvHttk8oisQkt3pzePzXdwDSQnaDB8Hs13Zk4VWuChQFFl3uQRSMOybdsbinQRpIGfYE7lVkOfTocuXA59sWxXNIPRBwjZtGCJ7oENXrCOwpzG1Hl4l//AE9Z1ZJRi/1OSxNgweDjDsU1Yjk3F81FWFaCqBYYXPKlDS5BqrkqnHta/ooY4dsZNRlsL0XmtiIwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aQpgkBPaDuEultdN2DMMjzVQXpbdO3p+FT/YM96K70=;
 b=EAG+m173aKg55d5cpcVXWBuIi5ixRAHkzzVSbpi1gJa5JQz4Fz+zUo0MR3vxoI7S71V08mqGsG9pOs49N8MUCOS4F3Bpf1N7LNaY8+S7Xb6Sp0NiE5edmwdPnU6wJHElUkVwyI4UKk7kdKVa7Zxql3YK0Rfk3pvOoz1fl55d5QQ=
Received: from CH0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:610:e7::7)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 21:30:53 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a3) by CH0PR03CA0212.outlook.office365.com
 (2603:10b6:610:e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 21:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:46 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:46 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Syed Hassan <syed.hassan@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 06/18] drm/amd/display: limit clear_update_flags to dcn32 and
 above
Date: Thu, 10 Jul 2025 17:25:39 -0400
Message-ID: <20250710212941.630259-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b284e9a-0c35-46c6-f7ec-08ddbff90b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8+vKKyIRhqB++lsOfuJo8MEHYwsd1OTSv9YNuTC7XcUCJo1+obKSqW0Ihspl?=
 =?us-ascii?Q?gj/yJV3nRkU4G0Z54P6paEaQJU2Xvz2XAowb7IfaZdR7gfbuzRx3fYWrYGMj?=
 =?us-ascii?Q?pV1TcVXLSbeLneOPwNgXFiuGbpLLn8z9MG2Qb86SS/RIvnGoG6PvorrPJRag?=
 =?us-ascii?Q?XlSDG8mSg9RzklgXuElU3z8jWYJT3YBf3I85UkFQ9uCeff6Ret90Zmq2Q4uO?=
 =?us-ascii?Q?7UWgyJFdpCMECjpqfaJDWsB0zQFHG6r31ONSlGID8ATIp+35TeswU31Mm6X/?=
 =?us-ascii?Q?clvemTmoZkgoqW0I6lDWJPy5ObN3wz9FicAumIaHymF3C+r5nKl31VqBKLGV?=
 =?us-ascii?Q?xen3uQ4AppX3729h1dkn5YoIi02GFtvvt6Rqc2uODvghUzx7LobSU/vWSNY+?=
 =?us-ascii?Q?VRbhCJSIvScwi6kk+OnFMGFCSQzkKGsjMw3CKWEPpgMoXkWgrTQcJTfmcS2d?=
 =?us-ascii?Q?VAqvHTWbYeYjlMMeVzU7eP44MNVY8hRMzsUGAGwBcIvku1t/OaqqpdEp3eDA?=
 =?us-ascii?Q?6lZp6c1pN770IOrnMUU0odCXi+Vdb3mB1H4n3YvoYKzFo1ogAZIhnx/HG16u?=
 =?us-ascii?Q?Um/IEIEkuj9VtECDaIzZWNQc4o0oTx/ZjmjQabvk4p1jI2UcN11aK7Im1+gq?=
 =?us-ascii?Q?S6v702gmjxqPjYGU5rkBRtMdjhIgLVgCQXdnaLsANLa/tXgCivsgRV0zthre?=
 =?us-ascii?Q?PP2ra5vSezmypSmtsFKqsTxGlFUb22DFGQ7gZ21RDAMkIqbtYBKkL8UcbwTe?=
 =?us-ascii?Q?DXUQ7zsTHRN3rIanLucVsVk7gIEZq+Ldi6br8PkeHIhzl4C4yGREX89xejWm?=
 =?us-ascii?Q?rJQaWULqrTS8/Yc/ecTcQEXLhnCsZtred7Ss6pGFVT521e6Y3v3OdHsnP7jg?=
 =?us-ascii?Q?bErOekrQ44F9nMyoMeFGUgRFbe9yigpdQn+jVmn5M84w31GAPmK1/IpY0Utn?=
 =?us-ascii?Q?1ZuefHdffyVyvXTMnGueHtGvd8TJU0vq32jcsPPQ5qBKj0Rv6I3VpBvtRbd2?=
 =?us-ascii?Q?6YtHudtyihqLLDbYg5iiR334aujc3TpWbOYLIH4SbpLvKsV6dSUFxZARfnJ1?=
 =?us-ascii?Q?6YNbzur5rMTyivZRRP6lBosbLypXczcUxKObYmCuQny1T8CqDtlUvg01OLFa?=
 =?us-ascii?Q?MWghWubcrJYe0C6mLRjyDNUhc5Py+scV6hA5hBK0ZsFl3HVwxBoDG2CZOwCW?=
 =?us-ascii?Q?fhkl4YYDyPB+VZNMBXc4GrieowDWkxUH88AykGQ1ElaGyWHEYCkZp6dJ8q84?=
 =?us-ascii?Q?NXSVAxjaufuLdR+qXjeEPwOMN9Dnw6ZCu7rPr0AiCw2twXfgB0pUYIde59xV?=
 =?us-ascii?Q?JKtYXh+6Nk3JjwBhdJidFiXE6hA0Mkr5q/8GCU+d4vUPJlmnMDeFSIeYxF+u?=
 =?us-ascii?Q?CGSFcE9m1fF9WDXUITDfstPqtZRRee4uV/+7QTNHMgjiR+lYX+SXzGUnfPGW?=
 =?us-ascii?Q?VC1WKIsbepIygvEwprXjCo93L0cNZZpg+mybHgAOiET2A8xlp60HfWmc3/DT?=
 =?us-ascii?Q?+xrtoAsHBKDFkdN9pqVZNlQ2PkP+6yFK3RTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:51.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b284e9a-0c35-46c6-f7ec-08ddbff90b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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

[why]
dc has some code out of sync:
dc_commit_updates_for_stream handles v1/v2/v3,
but dc_update_planes_and_stream makes v1 asic to use v2.

as a reression fix: limit clear_update_flags to dcn32 or newer asic.
need to follow up that v1 asic using v2 issue.

Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f37ed24b2430..cee45fe7cec9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5443,8 +5443,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	else
 		ret = update_planes_and_stream_v2(dc, srf_updates,
 			surface_count, stream, stream_update);
-
-	if (ret)
+	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
 		clear_update_flags(srf_updates, surface_count, stream);
 
 	return ret;
@@ -5475,7 +5474,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
 				stream_update, state);
 
-	if (ret)
+	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
 		clear_update_flags(srf_updates, surface_count, stream);
 }
 
-- 
2.43.0

