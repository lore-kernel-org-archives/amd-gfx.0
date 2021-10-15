Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B88160C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B88160C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36EE6EDB2;
	Fri, 15 Oct 2021 18:43:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF556EDA7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBj/bSW1Luhs4k2GWm7rCY9yJa9ETaLAcljOspuBUiTeQcdpN+9VAoF7jKmfDow2UyWrg9wmyjAX/eZVsedd3xFTOZaNcUz3m+DS9WGAavwDHPUHGJKbPHTD0IAGUmqnss7lQNYQgLxj58Nm/yB6xg+qR7pc42vcK9e4wNs9g47aPAhUytL2ox2QnpiVf3QYPabhnf11dtuKNW6ztBDwF4reubJMmGN8ipENHOkUipZ47oBvw5gldLRyxCyKrYdklCG5MT6HJyo2bScy6ZPWujNtrt1BqKC1xDYIZ9AHJAtgJW/o8D6aNJfqSHEGHwdAkYvhtaWpVCBmm1WR0ms4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrPsVu5/JPxiJaHo7HNgo7QQ+3RCTzntzyYihGTwyTY=;
 b=PKOb0WC/6iJK4A29R7CCO8m9iVe/HA0a3zwd3PYKxwZgOKQO6d6YjR6cwXIcsijrdsm6tVBzhUwoozzW2MisnUDwSh8PCJRMtta9lnlLKo5nvpglAaoMWc9M31SCDYJRIcSkAEmVPUp4vASpJazAjRAP7q2m0bgzI/Tk1K/2t054cpSk/1DneGDR3Fk1Rjp5AEuVJsPFJhbAmahobQ3T7er2RYkjJuGfSbjmKDrLxqMyNVvsBG2+BN8IZCYVmwav1YqLYcYPrLifAl/m6wHBZ7wJsJ5imxCvw6eTZVpbUa5PIbNJa2jVzn1oJpA+/438QsWFLRQ7a0Uwi4b7OVXDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrPsVu5/JPxiJaHo7HNgo7QQ+3RCTzntzyYihGTwyTY=;
 b=NiTdRh3mb83dEOKwqFqkyc0+ONnOcYPnGxfhPCCRVPQxhQiKZRuWXO9CrPyxfYMiUxvZ98onQLONBpWQtu7xaRGM0Zmi/HjSlvY06b+cQ0+z9Z9ifo4EuQPOxx6Cz4L5GvOej9+2dsEHZmR/lGZo/2QcTToClJq6QtUUF7cmyzY=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 18:43:53 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::4b) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:53 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:50 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 04/27] drm/amd/display: add DP2.0 debug option to set MST_EN
 for SST stream
Date: Fri, 15 Oct 2021 14:43:09 -0400
Message-ID: <20211015184332.221091-5-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a66ff45d-4a77-4a3d-d945-08d9900bbcca
X-MS-TrafficTypeDiagnostic: CH0PR12MB5057:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5057AB5C0D3980BF8343ABFDF5B99@CH0PR12MB5057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXA0pIaal8Rg4i0P915V3nhzNeUxK/FpBB9M3MZITh36FjsGdgcLcl1kdthW8p0fIWJUkjoDGKrs4HTFPloQT+fud1av/gTx/D6jM80eAOpXdy3sdyNlI6SqYsWuV/Vxg7BJopCKKny+8hZh8ssuw1L0yCfPNYxG6oZy3osiLLfkrCIuMvoMMg9s8r+aoRcbGYRaXKBJSbxKJZnVXCMBRhr2QtiIABjTF3JxUdNNqHAy4JZ4/ToIUwzX2ZvCDPqRGi0hiLr3FUwTghjq3BhA3iDakJF/rwS55/KVG3eitrMxZmBgwWXGaJV0v3hU3v8Gx900ImDH8HAL8AgIO/I5wTRxFa4bzaKN+7HTpKmShTZk+OysFrghjos1HivKvlluaNX/tU/2XwVcipBTuZ/GDZcovZUzegN6KHR95yA+1I6/QA6qNpJzpZFHXNuFtv2tFYL4SQsrczXSQDIdArxmFvfWC3eVHHnirdMP4g52vl9/HBr35yRIYU7GCIejMdNcB0hAEXxO/d/h1VpQfJ+rXrDArhr9iKdJdVGu70GPu9IOnnJuqBcTVYMzcs9jPCkS4irunUPqubVi8U32Yz8cdBZ1HtkTtFGeIokT8yoy24edPALHw1oUnE2hsBC9Incw2Xp0LL28CJm457tO7OKIYFGiVLT8n3J2GuQboDMxzN8n6aR59OaAw6VLwQcNmuu9ztHYEK3OaIhekndCPV5Z5nVGKoRAH/07J4Q9aYyZpYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(81166007)(82310400003)(186003)(16526019)(44832011)(356005)(8676002)(36860700001)(83380400001)(26005)(47076005)(86362001)(70206006)(2906002)(336012)(36756003)(5660300002)(70586007)(4326008)(2616005)(8936002)(6916009)(316002)(1076003)(54906003)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:53.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66ff45d-4a77-4a3d-d945-08d9900bbcca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Some DP2.0 RX requires us to set MST_EN even for SST configuration.
We added this debug option so we can configure this temporary workaround
for the RX.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca5dc3c168ec..fa11a2b094ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1869,8 +1869,13 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		do_fallback = true;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+	/*
+	 * Temporary w/a to get DP2.0 link rates to work with SST.
+	 * TODO DP2.0 - Workaround: Remove w/a if and when the issue is resolved.
+	 */
 	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
-			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			link->dc->debug.set_mst_en_for_sst) {
 		dp_enable_mst_on_sink(link, true);
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dd995905b0cb..254b760ae91f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -664,6 +664,7 @@ struct dc_debug_options {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
+	bool set_mst_en_for_sst;
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
-- 
2.25.1

