Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4232210E32D;
	Sat,  5 Feb 2022 01:51:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA9710E414
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn8FVg+6gNmQoVY4gDd/avm9eQ7YbHrSLkZTskxYV16N+UPTax70MvKqIXW4gMXuE/cBJddslsTQf9wv4OW841HdrGekmIkHQ/SnIgozKztxNRe/w/X58EPk0DaSUOE1kyG/C4csMcUCyMMOiGx1ybKO92hLstLI51VsWLxfC+pc6WGodT/BckYuPmDTFEGiV++LMv60Orv1cKhBzcLW0Eu67uWi6czTmP6NEScKcxJy40KqbDRTFpG/6/0vQ5lfLAq/tQQHx6Ctx4avuv/QeSxF/Innq95xV7Ilu0yizxuMTmnMhM5l2nNwDXAfEfU9bpeE7OaYQr18XyTVC7Sa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B6MW5NlRDcMt43wkoSV5FLSpxf36+2lUkldWeu9NAw=;
 b=D5WkmT4lX1zrwqlFzTmEogTkDbrvYDsgmq91MK+8BoPu+XNgPMhdua+iYXTp3r7T6qsJRKQPO99MwuZdc6eVVLImrNxEJnAvak2ec53/HdDaUpMviOZnTD6YVoBOm+GH478JW5nyuckMUC6guNKBaXLYhGLwJcse5spVBuZmsObPW/185g5G1sMdrwFicDjEi8aIoj2vJQYPW2jLFcpnrZh7hPKb8cKbKM0u67SUVx3SpnAiQ0xtvjvO9IdrVNjOheTsiBx7VrlSZet+GFuc9vf6VIRMIoFnY5LvTu9QX09Rcf1VFo8+zTxQfkTcIkaGQ8lpoSd/W1IgKqJqTZ96Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B6MW5NlRDcMt43wkoSV5FLSpxf36+2lUkldWeu9NAw=;
 b=5Qg3DtUtpIrT8lMErrG3gZFZjjgqI/AeowZ7DimrS4647Qh6G1wIZdt57Jr6VDzqsv2K6ztYdmdPeR5YCrep4iP8CgXOi8Qs7Pn6Oe9y+jMHCnf2KaxGtnJg74jVlpDf1TrWGVukhHml+febCdCt2brcF3XXTQoK5gnN2T2Y1b4=
Received: from MWHPR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:301:14::24) by DM6PR12MB5005.namprd12.prod.outlook.com
 (2603:10b6:5:1be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 01:51:04 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::61) by MWHPR1701CA0014.outlook.office365.com
 (2603:10b6:301:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:03 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:51:00 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Fix DP LT sequence on EQ fail
Date: Fri, 4 Feb 2022 20:50:25 -0500
Message-ID: <20220205015029.143768-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99ed1e4-ea08-43cb-566d-08d9e849f7ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB5005:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB50059FCD3C3D36D102C9229BFB2A9@DM6PR12MB5005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+9spqXQW3rI41Rr1TPYwMzh94ftUmoTDHnt9vuRfZUXr3Vo6FehZWjLig9xKTAaIUdtUhLVLvEr66+u/WEYWCQPe/p6tcekVPmliiJ4JXcoPPJdIyjrkTLI/SjUe5eapuo5xbGIR70R9SOwzn/8o55gLEhRCXK29vnNcpDf6ifVVof+apvdopSO4NqZZglJKnjWJfNyjgD3lrcbbisri6k9QfhFPQXK6ddmvWWIuHHY8gagPX8k19Z0U5SM8ic55CelksJIYehwgdU2t+oAdUbafN69xzVVLlnuWAawcnh4yvHsQO4sQcsgMKAR8sY18RvoyibF161wQFsLjQHbJCM0XmCFxEgNghVXMBZlwKfQ/BRimxZSaTDIul8Xwr8Fp7PIhsOog1uPBx8TIoRpUHDGAtEwAnFoZ7csYxesob0sOKKGVEnYbXOpS/z4lRUH0R9GyXJQ4y56Y9RWtYw1V87mTcUsooJjnV5JjsE06zqZNaUpoNksY6Ltfn89Rl4YooJECv/cm7rdPS76Z9rC0YegO+Wm67lQrlsDP0IDuSOAWBI1WMCCte/bg421UDwyuIfW+DAUSbq0m2jbxlXM8MaMmWi/Pex6cd6gs1bpvpAQ+nsyxoWHZwgtjUyLuE2SaYUHMpJ65ATthchizX0ldyx9sIaygHyR+BEeWBrKL+lQfJ5yLgb+fhArHF2Go9F6njzA5JpuwzOrwEiGKER77w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(508600001)(47076005)(82310400004)(6666004)(356005)(81166007)(36860700001)(2906002)(2616005)(36756003)(186003)(70586007)(70206006)(26005)(5660300002)(40460700003)(1076003)(336012)(426003)(83380400001)(6916009)(8676002)(16526019)(8936002)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:03.7675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99ed1e4-ea08-43cb-566d-08d9e849f7ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
The number of lanes wasn't being reset to maximum when reducing link
rate due to an EQ failure. This could result in having fewer lanes in
the verified link capabilities, a lower maximum link bandwidth, and
fewer modes being supported.

[How]
Reset the number of lanes to max when dropping link rate due to EQ
failure during link training.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ilya <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d0cb40df60a4..cd9c31b5e55d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3504,6 +3504,7 @@ static bool decide_fallback_link_setting(
 			current_link_setting->link_rate =
 				reduce_link_rate(
 					current_link_setting->link_rate);
+			current_link_setting->lane_count = initial_link_settings.lane_count;
 		} else {
 			return false;
 		}
@@ -3516,6 +3517,7 @@ static bool decide_fallback_link_setting(
 			current_link_setting->link_rate =
 				reduce_link_rate(
 					current_link_setting->link_rate);
+			current_link_setting->lane_count = initial_link_settings.lane_count;
 		} else {
 			return false;
 		}
-- 
2.25.1

