Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C17DC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C4C10E25E;
	Fri,  8 Jul 2022 16:36:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C8B10E228
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw86qgEZLeIvS59SOQgGQZcp6gT5Zop1CkHK1W1eqLMbnic7pqQH8wFQcCR8TBZi/9ZmdKaaonU10329eceWNmVQcVIau9l0T45iomLQnGlsnfr9AXHjKt4JS2jPnubN+QFxnFZUWET3vkjqQxVs0rX/ojv0M6+1RuoVu/1pauakdc9tVJ0cYgig8SzF9OtD8Z5H+AKQ4dpNws81YvCjjTPNWYz/CqA9tQc3sY4aMhgKYpyNqzPorNiYvnHmfh4lmjmnj8Q72udWltI2rwPovbeLEorWRVgu738OHVQiezhfOXDG+7oQ5qDcBp0M7AxOwTnl64c6ek69wXX0uxBU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN5l++sjgd5CCjvcr51ex5xppQ+RAH6YAAiam4Xmy8Y=;
 b=C79JxPiO5O4vKagLpsVaX4GwPcjY7q9nKodyKjP2p43TuKkCv44Jpi+QpihMgScABRIsmx/7quBTN/CTGYzpeYk8pum5u2cMK5i0AT5RcUqM/AfL3oSEdrd4hbtqN6x1JugCG480Zcieu31Znhz6Fd6XXYlWHyL28EOTpt8hVzTLH5sa79/AdECp4C9+wh9oQFwuJs5PYVqmm8O04DKgAo9em4o1BzCDPUxGDn2kRyNCYwo06CNfcCF51fNRKZpYbxEGEWbKEA4FeIuHeMf0qdGDvnap0DbZEMyPiKUuDBR+znREByWLwSwU/IPt18sGfwtOrfWNaWvyXAKrTTyEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN5l++sjgd5CCjvcr51ex5xppQ+RAH6YAAiam4Xmy8Y=;
 b=L7ckDffz1Ds++LBfrRumFjbcT1jSVNiPCoEyPZK+7yZovkb25oTkwFG4h7WrKlsGhXRxOxqSCCE/n6+nHOYblv1xo+t7IFEexYyndQfb6+ZAk+DqiAk7IycsEyYqraYSCk/F5NqBgeE/A4E11Tm+s7hIx3YgofEgamlVDvjfiTw=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:36:41 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::4d) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:41 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:36 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: Fix black screen when disabling
 Freesync in OSD
Date: Sat, 9 Jul 2022 00:35:16 +0800
Message-ID: <20220708163529.3534276-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba9b7af-b6e2-4043-5c51-08da61000959
X-MS-TrafficTypeDiagnostic: MN0PR12MB6078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F67F4K47TrN3i1H9d7SqnPQK1npsTSnq9nZ4pEdkrjST9LdqxtAjWdocdPvD4sTMVMYBcPVaA0/f8zsiEUvRfffp2EywELrYQo1NILyYSRkHkvbwDCZxBGC9xPbQrEDcbOqoXfmSrGqHjjZBE4/+r+R37s85Zrzxwh2YhlAQrBHzYkXLuNeTJBDCO0EII0//DCThpRsF5qooP8xdEinMWfORdocRU4dTqLo6507lBy3oSsfAcg6TGHrJ1iCfRVQbebZRNKw2shc+3tjSw5hvjGedEYOVTC8zCEwebCLqjrbs13+nXl7yvRrfEmF/2PA9iKmQiGIKdzfp+V6JTWSL0QMV9latP0WjLxhJRIRxHwkDqyoPD7YM5G0pKfLIUyHJVCE0e2b5NEGiKdybNExIEufhnHSh/I77hTK+rsXDIo17SnFrxUHeSR+ivaUHf2ftScY7HvNI2IPkY0J6YRmeaOI1+mbMk2XfvDVMLEYqODXwjhbk36UxmdHW2Rcg/1L1Iy+hpzkcwnJOyOb2FVjVER/33kf4pLh9KUdFchLzOZzE34+P/FJtdUC45eaYF94B913V84/rby8eSWIa7iql2N8hYHtz2bZQ0iAeLY/a+cAdZ7iQGPZKg3WJVV3ee2etG7PEcwP/anYPlTra4YaKnWrxIKru3pWQCxhQUG3wFMVBTEXhnu8cMSPJKJqY1XtM7/IflTI73n/GK4b2HvtQ8GpC4dRWrvtaB4JYW98JCEo5+4C7ACwyGHAEKWCB+VZfN2cPLsNVcf7I2Cz78ndLY6igWy8QdcHeds/W6XSB3LPxayI55WRWl39Fz5csq+MXtZQeEb/e7aS9vF/Any04sbhD6ajWkzruZlkLuN5VxhNXO2lfooyM3ffTXApzySFQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(40470700004)(36840700001)(46966006)(426003)(47076005)(186003)(16526019)(70586007)(70206006)(8676002)(36756003)(4326008)(26005)(1076003)(40480700001)(7696005)(54906003)(6916009)(2616005)(34020700004)(336012)(40460700003)(5660300002)(82310400005)(6666004)(86362001)(36860700001)(356005)(478600001)(316002)(44832011)(41300700001)(8936002)(82740400003)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:41.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba9b7af-b6e2-4043-5c51-08da61000959
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Black screen encountered when disabling Freesync through OSD on some
displays.

[How]
Set the should_disable flag when new top pipe has no plane state to
ensure that pipes get cleaned up.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a448696ee8f2..6b37c653f45e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1085,6 +1085,16 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				dc->current_state->stream_count != context->stream_count)
 			should_disable = true;
 
+		if (old_stream && !dc->current_state->res_ctx.pipe_ctx[i].top_pipe) {
+			struct pipe_ctx *old_pipe, *new_pipe;
+
+			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			new_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (old_pipe->plane_state && !new_pipe->plane_state)
+				should_disable = true;
+		}
+
 		if (should_disable && old_stream) {
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.25.1

