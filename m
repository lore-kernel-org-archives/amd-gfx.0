Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC7C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC35B10EADD;
	Thu,  6 Jun 2024 21:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQTVc4yO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284AF10EADD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb5W7Yno5Y0dtnoS27qXHDuGrSxGF+Rw5cHdkSBlswh4FlDsN8HnssNhdJ4czlJG/pcQJuQf3SKEgBu9pkBee+FeZt+AbKWqLU76JouOVJxk1TvVmRA0Wx1qFDDHgCWjoKONl1SsxgXorL001XX8BE589ES3xfZELCNGL0weKN77Gso5N/GxlBsWSpIq6i/VnjTclKWqmc4Tft51c4Vi0eJXBu+WiaRuxdH1uL5tiJAuMs2nMEzReCNsx3t6A9ik0JMYMA+Ap/m3g1JaD2UfnwXJDFo3qyQJSsZG5jUKtO5QKpB1Dw1QT/kJarWgNTEUONmUDyLdLklfWHReyWtJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm15vZfAnNhBXcsXMsd+itv/6fPEWv8rDOl7zcaVoPI=;
 b=JkSEccGtOeWrKU0GN0ZNav6Ha9zKvt4xVlwzU2svpBk/xEa3OouoT3FuUKfguq3O2VaDc5ulG9JX81JV7bVZA7A9gqLWjKMYNTjYxSSML0OxljkdbxycUqrnAMqkbNjwGICRs3ESdVk9UdrFWS7hp63gn0IreiiFFy7rcKD8/fwnJ61b9iCpoL514ae5nVG3+BKr/mSEMmAWI3fsdhdp5Eetwtq7eP+28sAhBEfGpLviyYP+gU9dfXVP0VuV1cdLSR8bpXknzIMy19gSkyf9R+sGOhVQ+WVSkC7uU/vmsu5oXGpmpV9fKS1mzY4YTzTpZeANH0kGrhdATK2jWZ/RcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm15vZfAnNhBXcsXMsd+itv/6fPEWv8rDOl7zcaVoPI=;
 b=TQTVc4yOVNSLdafStg8y+2gDaglwZNN/zkKaro7VYE/Of9cRw7+pWqE4Dy9jIj5TtfMoYJFd+j4+tpEt13poedZ55wMdKZxG70yK3yH+h1O0lPYR9qdzkvbWJ39kFnQT/CfSIzCRZHwoIAVP7g2Rq351jNkAgrWHJxfPm5qcFqI=
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 21:57:22 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::d7) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:21 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:20 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, winstang <winstang@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 22/67] drm/amd/display: added NULL check at start of
 dc_validate_stream
Date: Thu, 6 Jun 2024 17:55:47 -0400
Message-ID: <20240606215632.4061204-23-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cd81a2-3a85-4bb7-69ba-08dc8673a47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bS58N7mY23lUBC4GsNzcjJWC63y9e4oqcCeM3cVMrp+rwh5K5OeMbJxGmZQ0?=
 =?us-ascii?Q?9H3gDJBcpsblieVPWmqC5WUog7WL4j9ng3V6no20+nTSe/tfcMmdxW9T2AAD?=
 =?us-ascii?Q?nF4UlICb2ASSYKuLp0PDm5Oh2Wt0saDa0n258OlDOj/jWo0jbuLzOfOj/VBB?=
 =?us-ascii?Q?5cEkJ2+mc+jl+kl2QlxKH6DDfn4jQYhXF6S6hnnjdFL+4ZWq4lb8K9Ew9Pnl?=
 =?us-ascii?Q?E8ObAVTmRJuBR6CgcTpPcbVFkIS+IcRIZvXqa2hWCZxfMoHdQF1yWo0KqTUp?=
 =?us-ascii?Q?VzAHCgf+65uJmOXdNF654DEK199/RUPgbFUcd1cL03BGCjx2vM+AEBjjfQQ+?=
 =?us-ascii?Q?BgvIjPdL0p70WdtooLrWS/HZrK0qB78dQCGIM6DquLY008mupvir9/8JG8iG?=
 =?us-ascii?Q?dHPd2Bq5ZJOI8O6T/ycui3/nRXn+6jokZy5iD8mF/zJeoZLNczQCmoLEveU/?=
 =?us-ascii?Q?5PN3muU7o5S9YsgjDhCynj+CQm/Z+G6A7AR3ghPlWxjEa8T3aTbzLdEE7ZDb?=
 =?us-ascii?Q?hVIUKTBFXickqEERvOLAKnuYmVIbgowaIpzacHedl7UH0qXthGlaSqQKLl+y?=
 =?us-ascii?Q?XwRlarsjQcvZKl3QhXy11LU+Z0fyepthruh/vFrn5pqCmKSfIduyJ2nGhrg6?=
 =?us-ascii?Q?zKXQHwkPpIYyXouAnALBV/4I9IL5nTICwPQREkHb+SA6A1bDX7AkToGTDZEa?=
 =?us-ascii?Q?6dwPYFPkoXWwDuk8wW5g2kVOB7b80+5Vn60pL+42RmvIGBM6h2w+Yty9iK5t?=
 =?us-ascii?Q?Sxb9cLrgrXvLBKbS4Dmosu3vtctBTl7le8chTLGhTH8somrQr/wGIoIgkRCM?=
 =?us-ascii?Q?fBndJ78w1HOkfmtep3o/R/oZGvCnnrW3p5JsL7NZ5DjVaxNzdQjTwKMYgXYg?=
 =?us-ascii?Q?yGLKCJXloFv9AcQXlCo0ipgVkog7c1imUr1CCuyuCYR5J2FIqulP8avGM83a?=
 =?us-ascii?Q?0RKp8/+MbysUwvNKrVOHbjceidk8u0lNDYlCY7uabd4a26a3wCqhXPtC9J7Y?=
 =?us-ascii?Q?zecvidXOZ6EVyiOCTzC4ezOv1UzMirDx8OY0O+cUvIHoIIk53StDiHbfVLSu?=
 =?us-ascii?Q?x0UEmbqKfbgTD96YBOCdfcapO5uKd1LAakK0X9Oup1sYPeZHTlfW7mC1ZJTt?=
 =?us-ascii?Q?iZb+3qNY6kLvH6vjskXZQwCnHqGieAPDLe8pR0E4WMEg7FhXR3oE3cXxBbGh?=
 =?us-ascii?Q?Y5/noEiCfDhUICoq5Oj0R0aXTXoehLZa1higLNw461n6S1jXCdQ7+UFbuZdM?=
 =?us-ascii?Q?yjYUFTWfDi8yVzzvWgzyzhrh4K2Twic0A5UuebXT4FI40/mFJas+iu7sO0Bj?=
 =?us-ascii?Q?ydKInG09jg0cjkiL32acTvLibRpgNVAx7KV/GrwIV2/PoGVJon9STt5arym8?=
 =?us-ascii?Q?lZ8Yb4tpwg+V3/lFfKu0m1Z6d+zTRVfSlMFKBGd86/HKaFW4Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:21.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cd81a2-3a85-4bb7-69ba-08dc8673a47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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

From: winstang <winstang@amd.com>

[Why]
prevent invalid memory access

[How]
check if dc and stream are NULL

Co-authored-by: winstang <winstang@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: winstang <winstang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 45a719fe884e..6d4d4c95243f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4754,6 +4754,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
-- 
2.34.1

