Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15414C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23216052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D23216052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D1289D7F;
	Sun, 24 Oct 2021 13:32:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C221B89F9F
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFe4E3tVpnLMet7m6v0er/GjyuPKQcmSAOMdcwLMHkjjXIiTEXqeEE/Avu6n9vXDKFtijxTOn3Hm4ToNoOPMHVkxZQgvAO6HgROzTAK3hzEZA8CS06TDkQBfLCwcJ/6R26PVu3hYPFqH4iE1EcgWiClSbIFp3RcGT8pGsOtaGzDGtZ755vM0UCzZOYkxQU2M3HZoeh+MxFuTqPXusqG0YN4G6k/UblOLJF/fdFhHT9lZhr1hkT9/n6v+etcAzBvPhTVXu0YA+NANVBnDu+cc4VQvrhci691uPTZJX6rgjXfk/DG68TUZTeeT4jzpfJfHIUGtdggVs2YxzYBXP0NXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRARofabUVKSHvrsHDYDP/Yu08TqulO2UKgKMBCIXxE=;
 b=WGmd15FSKq0WdIzNvh/lZGg1yBt+UOGpvbwSwaZ80S1HSpxKCxQ7nT9dOZbECIK34+6nDymdUNoKgiiqKU5Uw9YaGjXRay6e0icWX+fEKovAf7Vbc94aCB1+GV8WVV7BDOAWsdRxNBO78mdr8/kK0axRU20v/LLjZKomHhPrPytWZoqcYhwOGYi/qlQHcUznX+ThB/RVF+xm/H52RMDySa7RjTnyC2UPyB4xXSKns9PyA4hbBQrgJAaZ6T3oZkLYU8H+L+e0FvViiRJ6xf7nHgxQ1dtGkIkkT6j0r7nbEX+7ppX4BfJlMM+8My20IjJgtFMH5ayvolWkZqdX1kXPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRARofabUVKSHvrsHDYDP/Yu08TqulO2UKgKMBCIXxE=;
 b=ukP43S/lTkpXw66fuHEvxJxzLjdg365dTZW7GrfOHP7ovTxGR+PSaiBcd38RkQAo/Xg9W1uVtRM+k0HLsWA1o19Wi78d4wd9DJ5PaMPKVDZe7Gbmjp4hSEB9EBCyhb0zzzlSsApKTPCHYc2GJBwn/qjCZ5ewek8xLqXM/MVmmjI=
Received: from MWHPR1401CA0006.namprd14.prod.outlook.com
 (2603:10b6:301:4b::16) by DM5PR12MB1178.namprd12.prod.outlook.com
 (2603:10b6:3:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:13 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::be) by MWHPR1401CA0006.outlook.office365.com
 (2603:10b6:301:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:13 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, "Guo, Bing" <Bing.Guo@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 03/33] drm/amd/display: Get ceiling for v_total calc
Date: Sun, 24 Oct 2021 09:31:11 -0400
Message-ID: <20211024133141.239861-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c892f078-9db3-45eb-1adb-08d996f2b04e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1178:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11782ADE139AC4ECCAD3F4B398829@DM5PR12MB1178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xmga3MUs3y7/o06VQBU03/SM9DTeASHcxFqPu1u7VdGV4e+FLbbiKAiHewugn6EbaZI4pqLsP6E6vp12Xscc72xyyvO3PqMz2veceelC7pLGsaSZamQRHbu8bJX4o4A5g14Xi4dhDHqpV0kzLSy+V+BWpCYYxMuwuDFIR4XJJoV+QfK9RkeAyEamxg+RRbPf2h+kfxrUhxSOoQ92+sNdkF4vKGWawSHxe2FZXwjusNjWCyBnjUTnFOoOHcaoVqDlhn2yPflCDBGBCBOQD5o7V2KW52J+lM7UsIZ2Ik1yUY8IK6bklEJ/TBzlnYIGCPMaq9kvOlSXwK2YhXYyvMs9nP3UaxhKx2xQcu/Te4nIbiXYTqeOpRN/4Hr0wqblcHNsK+QDAFUIh2zleh9o0/+bnAkdv+g0WcBcnJYJlPJ1SFuFHAVqbKSFJEI6YXDcwb0NYOU5ezl23scs5CBu0BBNpaTlVIALkHcdMmjEV53yQUSNOedtHbSnN0zctq39RnIXbCQ3aDSXP2f1vgE3vQ7m2v/K7F/9p4DEGe/exjzkDirl2eWhmIrHy9MQ1yrjoNLKAQmrScx8CEevKyO1h14eSUlICF5wq/KKWyUyTSkerp1LBW1dV7dN2YjPXlsJGwRB7vtd7S90NbVVGI3EIY9GVJIUI71IEBX0vJoJzfgC0ErjX9fumsp3LSL74Kjt+2bGl5Mft33QCWwYqQPS0Hzrndb2FGmu2zetYFj82B0az+A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(70206006)(2616005)(47076005)(8936002)(186003)(70586007)(16526019)(83380400001)(508600001)(36860700001)(316002)(336012)(1076003)(2906002)(54906003)(426003)(356005)(81166007)(26005)(86362001)(82310400003)(36756003)(6916009)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:13.2247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c892f078-9db3-45eb-1adb-08d996f2b04e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
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

From: "Guo, Bing" <Bing.Guo@amd.com>

Updating certain variable blanking calculations to use ceiling function.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
---
 .../drm/amd/display/modules/freesync/freesync.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index b99aa232bd8b..bd1d1dc93629 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -155,9 +155,18 @@ static unsigned int calc_v_total_from_duration(
 	if (duration_in_us > vrr->max_duration_in_us)
 		duration_in_us = vrr->max_duration_in_us;
 
-	v_total = div64_u64(div64_u64(((unsigned long long)(
-				duration_in_us) * (stream->timing.pix_clk_100hz / 10)),
-				stream->timing.h_total), 1000);
+	if (dc_is_hdmi_signal(stream->signal)) {
+		uint32_t h_total_up_scaled;
+
+		h_total_up_scaled = stream->timing.h_total * 10000;
+		v_total = div_u64((unsigned long long)duration_in_us
+					* stream->timing.pix_clk_100hz + (h_total_up_scaled - 1),
+					h_total_up_scaled);
+	} else {
+		v_total = div64_u64(div64_u64(((unsigned long long)(
+					duration_in_us) * (stream->timing.pix_clk_100hz / 10)),
+					stream->timing.h_total), 1000);
+	}
 
 	/* v_total cannot be less than nominal */
 	if (v_total < stream->timing.v_total) {
-- 
2.25.1

