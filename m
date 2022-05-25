Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF23AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D495A10F9EC;
	Wed, 25 May 2022 16:20:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB28410E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si0xaAS/ST1ZqRUVN+UTHR608jEsDgD3EeRIheytcAh2J9nFtwGKYwL4aSLdu7W+TNsATOiLCF+HMOveYEtOE0IU4EG+LN9DUYWuiEaVyl4XVW8HHjIq0jrTvkoiU+4Bgezd57l3Qs2Te0cBfHEzhBbG+xlkUqJcCED4vvck8o6GyxmsYYTZc7SzfurqfSaiO3iZI8o4F08zgvSnlc+/96SOjeasDsA5Ti6iaH8QW+2DJcdOc2HVen5PFH0ubwQXeoisby1LmJm7peShYAY1aeSMqNapvTc0pLVmJsQDsg9HBmVbWk/gMEp8TA91u3dhjJlu2Z7Uu8Ex3vbj+KPG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vzqLuLoyNQAdcrr6jwjdJ+ZTUha1Ap3/BFDo10VnyY=;
 b=Bt8leyJ0G1/uDor9qUZnsM2RaeEP3e297h4Fmdf8d+F3IZ45abYnr+1hUL+ZRWIexTHhZWV4WlqPPOceQbQsiEi5dURLpFqVPXfdTZTX4RW7MXQwGDFVGxV4Hxb704DLvY+9xOVfqqhuyn8eQYBkKh3e9U0b7G7juphqO6x2I3xGWZ+OQhtQyYaWikPHd7rW6L5bYlwb4TgNfBElHBOECYCTm0XAmPGgsMgF3bxvQWMrUaYA9EtGHCTS2awYsPNCF3hGPAXDGo+v57XuTQRhsrC5Uh8OlSGAlS/XOcjWpNxYJTjoIrSOTs8fR+TDcoZnMO/nTNuh9bjZ02RJx+Vyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vzqLuLoyNQAdcrr6jwjdJ+ZTUha1Ap3/BFDo10VnyY=;
 b=cGjzupgsgobwjVV9Nx77y1pakuRDTglTF5G19FMXeYM4QZwkYuH0bTcFxjO+g/alCyeMx6JLJ2bWqdKfLk3GiIka9AdU2jNiJi9B76FJDN7MmlkYBs0WxjvWS8jNn18eU/jHXkfJ6vYutO25N/Z7AhbnQ+ql9MOn8Gq6uGXzFkc=
Received: from DM5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:3:d4::14) by
 DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Wed, 25 May 2022 16:20:18 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::a7) by DM5PR05CA0004.outlook.office365.com
 (2603:10b6:3:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/43] drm/amd/display: do not override CURSOR_REQ_MODE when
 SubVP is not enabled
Date: Wed, 25 May 2022 12:19:29 -0400
Message-ID: <20220525161941.2544055-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a932a752-09b4-400b-1097-08da3e6a75a8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36573393679912950F68250CF7D69@DM6PR12MB3657.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGivYDpjTbgNWsM2ZJ6b574XXglifevKb35CSMEnXCjitoKqLuj45tzCNc53ZZvLJba1LgrHhPQ1XPf0dLwRKUmMfzBi3vebaCk5o+0WH0vVZbw95hQritpjWzZ1mwlNS/jQe6y7Bj3SMeYfxp/HK0tTjfmKySV1NYdAfLRP0f+2KFF/vh1Qjuk9vRceaazTPj2l9f1dqRDjAsK98nqcHcxJZJppvWenTQwzpK5nvoTNZLLCKtHXIsd/cq4i5oAQW5QerRiL938FMk5ZYJON+z97Utj2bGjW45PtxRBVSU4SJN9enTtKagxFMJL05tlQkmQJjNVipm/+gkG5otS6VJC3vQtJj8pwbToj9fExVRvT6enCfKR7tsiYPDej85IRXNFlfPEIC6ze4hyrDWzDGzic1y1SnfSZsE4JxdMJfhFNiLKdGAkL+rEItUx48PvaFD6/SQweFFq1BSAQ7wgxIE8//U7csruFyNA6qLmZlwiK3qEz0N7uz2gLd7OVBkxPgD3JASjepooiiVq//8aaISc9nqqOOu8JbkYCLZJY41vl/8PnAPC9nDehYvJFHBpAEIDUN7jT2TcNDPxRuQx8GCst6aNhmj2MspXr1EXKuh8lRLDC6WEssNrqOM1BfmKSB6YsWkEI3ghKeZCIFvsrHaJ6m1TMMS+mRajGmJYktDO39jL3VQ2GB5WFIDL5k01hLa5dzwhBfLfGp/jioYno8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(86362001)(508600001)(1076003)(4326008)(70206006)(8676002)(7696005)(8936002)(40460700003)(26005)(6666004)(2616005)(70586007)(186003)(6916009)(5660300002)(82310400005)(81166007)(47076005)(2906002)(316002)(36860700001)(83380400001)(36756003)(336012)(426003)(16526019)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:18.6813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a932a752-09b4-400b-1097-08da3e6a75a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Samson Tam <Samson.Tam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
HUBP_UNBOUNDED_REQ_MODE and CURSOR_REQ_MODE are normally set together.
In hubp32_prepare_subvp_buffering() call, CURSOR_REQ_MODE is set based on
whether SubVP is enabled or not.  For non MPO case, both REQ_MODE
registers are set to 1.  But since SubVP is not enabled, then
CURSOR_REQ_MODE is set to 0, overriding the previous value.

[How]
Do not set CURSOR_REQ_MODE to 0 if SubVP is not enabled.  This
will allow CURSOR_REQ_MODE to stay as 1 in the non MPO case.
Add note to follow up and check case for single pipe MPO and
SubVP enabled as this would cause both REQ_MODE registers to be
set to 0 but SubVP enabled would override CURSOR_REQ_MODE to 1.

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 40afd33ffec6..8eed05aad54c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -555,10 +555,13 @@ void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context)
 		struct hubp *hubp = pipe->plane_res.hubp;
 
 		if (pipe->stream && hubp && hubp->funcs->hubp_prepare_subvp_buffering) {
+			/* TODO - remove setting CURSOR_REQ_MODE to 0 for legacy cases
+			 *      - need to investigate single pipe MPO + SubVP case to
+			 *        see if CURSOR_REQ_MODE will be back to 1 for SubVP
+			 *        when it should be 0 for MPO
+			 */
 			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				hubp->funcs->hubp_prepare_subvp_buffering(hubp, true);
-			} else {
-				hubp->funcs->hubp_prepare_subvp_buffering(hubp, false);
 			}
 		}
 	}
-- 
2.35.3

