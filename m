Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A450C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A979112D12;
	Tue, 12 Mar 2024 09:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThI1EhLN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04027112D12
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNPYK6o5stQIU8UBk1z5Jj2fIG+IbSfOzeV7BJflYy9LHUApWuM6LBAa2SccsYKE3jNRDcV9p57Wuc1CDpQR1srMwbEkjFh4pgFm9S7DQkl3hj2+Wnbt4HcY1qHKSQCizgOml6ypm117oBqa4b7fo5CU1a1a7MNRWGF1WOJrewyddjY/i5nuH8YtEXIPtyNs7V7We1LEmggNZcQ5DogP8FKd+xxnwZxSr0UuRf8yDMq/dWFWyXBx9k3XZ0QYYvxn7gi/6mLn2bTzrr8qb50nJ2I7dx6wqUCakqfhZLmZ9BZLkxDp/C0Swr2VuM2M+8bP1Ul/B3lf6ypUNNT+pN4kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+An4Y37pJZVTHXeUOPaICQZ864O3IdDlKTuoz6YkqKc=;
 b=QxiOOAh3oOJI+GSh5hTU91mG7RN6HFUbLYkb6UrrdS04y/zZHsn9aW7h9z8OEJ9ZSMDxljMxbfJn/EkCydVjPvIFKP07ILM89qoUTDogbm6nXGCYd8Onbvr5eCi/juxA16Q/7PH1Nc/Io+EAOAbTghk7jjpg20NMOCPMccaBVg6x5eSj0o2aEOGamM7DVpdgBrT6I579uv0VI1zuJN6zSA/8TL8oP1wzs4+PZ9Y7vDvyH6/7UjDN/AKhbWVqupj+WMIYNyqzX4BcaW6iZ9ZBS5RrC1YyeZRBAo8SJNMYrbqvmjqdj8VqU0SCQNh8MM9pmn29gXWz3lN/KKKoNGlb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+An4Y37pJZVTHXeUOPaICQZ864O3IdDlKTuoz6YkqKc=;
 b=ThI1EhLNXgxALjxCSuSw3D0ODv+1ztHlnGDF4gwrVyq/SZlvvqip1tdSzFQnjPBCnTFdKfxFU+wn3bv02Iwj68sEdlMF2mPZKgxuzOFDFT1sJRLUptpFFue8Bq2xXTxF7Yw4homaFJepsZEC4xQ5DOQjXdnvlTj6vhZDU7BSr3Y=
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:24:01 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::1d) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:00 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Natanel Roizenman
 <natanel.roizenman@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 30/43] drm/amd/display: Added debug prints for zstate_support
 and StutterPeriod
Date: Tue, 12 Mar 2024 17:20:23 +0800
Message-ID: <20240312092036.3283319-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 043a086c-9836-49d5-c8f7-08dc42762735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXuHPl/acv5cHhiRBguJRB2JQr15BjlJkDv0YvdN3Gh4AxZehOZh39zQIt7ZfzEw4k5NYAkfsqj2NueQn2JZ2nt4Ww7cm+8tNaO82LispT1JA/9Y5KTBXYt9gWRlC6rG4iqBuRXFfI1mpjTqHikTwlCJY/GTRphdGyEIxCdw3KUam8Nz68oROGvsaW3CCQfj/wPBooDaiWxlPQ0ui5bWTSXQcJBzE2+9hJ5EA/JNbVmnmlzYSZlKBYMP/mX4LZdmcczWNAVuB0FKnUPbBISr+f/a4utVfMXKNSAP5SIVpuNS0db0MlBwdtg5UAu7XOCXI+vhrQQJwXbg9I3BrxTYj39SbsAOm14EdLUX+DmrgvgPO92RGvG9MZav0FK+B07KkdVryLSN/5Fud0F1P2MhzjNrt+TICECrB9sCZEWva48hbc0Ia6opQCHdInmN/cWceYp3hPlLzjCoTx6+ggmg9BYTz7jmFZLOyMMiKCUXcpsuEFiJj5HgAFjknASPZI9sk6IGf6nKIiPXMOgRwyrY3Jarp51MWSEg86P8PLq6RJW7YrFK7n9ojrWkZs9RH92ru4mkMS0j1RVkNYJbbnkwRuuA+KPJu8sOKbEfgLf2MAmjcdx3XR5p66ymawoYgOS1yw96vTFGx3KuZ4TvMZcqqfC/+/B2qBSEK2uXEFM5D680xpJKnmcHB+1Dk0lkcc/DyPH+bAHrUq68L3YoiRnz5XHHUaMN3EvSo8Sh7C6KnRxvz9sXLj96UvB/W7SgwXmP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:01.0397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043a086c-9836-49d5-c8f7-08dc42762735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

From: Natanel Roizenman <natanel.roizenman@amd.com>

Added debug prints for zstate_support and StutterPeriod in
dcn35_decide_zstate_support for testing.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Natanel Roizenman <natanel.roizenman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 4d7bcda8ef72..9ac3bc6643c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -577,6 +577,7 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 {
 	enum dcn_zstate_support_state support = DCN_ZSTATE_SUPPORT_DISALLOW;
 	unsigned int i, plane_count = 0;
+	DC_LOGGER_INIT(dc->ctx->logger);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
@@ -608,5 +609,8 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 
 	}
 
+	DC_LOG_SMU("zstate_support: %d, StutterPeriod: %d\n", support,
+		   (int)context->bw_ctx.dml.vba.StutterPeriod);
+
 	context->bw_ctx.bw.dcn.clk.zstate_support = support;
 }
-- 
2.37.3

