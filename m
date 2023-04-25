Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B0C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 03:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4396210E626;
	Tue, 25 Apr 2023 03:09:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4602A10E626
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 03:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npwnszweE5NIRuHTyUMXFzSt1xAz//tIgTUfCcoctNJIeBIvrYL1sWDVFA8E694uOSd2IMW1EZOjBNNdvdMWcM7/wE1g0VnYFEXPpcGPqECZIF9GKSJOr2RAgYh7Un3rxdwQlLwKemVW/f2MtetuSVtlkvnt9iRGFVkxQ+4QdV7b8CJ9xYsNsSmPJgjgvjLQJNA2Dmmtz654fChoiI0zKhM7pD5ykWeMiNh7lNp0TtpNufLKlIukyKTximQZafIyQr+bmXPoTdL4OUZPP4QC1w6kk2LjP/+h998UekXwHjlF+oRYA+R5wstNxNh6/N/J4RUFYghOLF3hNfpOplDDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOHnya8UBhYRWt7tB4fPK0uKwf51Ms0ddgmJ8/bSK+g=;
 b=cu2C/6EaRlNgU+/CUootMlrPtTZyEDk86Y+AevDogeB+8nZYxGcM8TB1YBOpIvu+YLOk/hn/YDHQ7N5DFxFIL4iMGFhItxbPjKqisfLdgwSoZ7wnhVb5Fo1CPmq0ZRgqxjRyeYXSXp0arEAUi/pzfLLYCX46CQk56/TO4+GCWcbNO3i1owbTanAh6BFUWjDuCvKZC4QqFeSM55eaaugzv48hM6gNH9D2xUQefB+xuix67o5i4hUpO7Yp9DQioMSD7HZrzvw6meuMnpO4FLTqb3+j2w5LuKaK5oqz33fbBoYTcQvfDmBGTtkIQRLg8+EqzgDJmAOrPy6ytRWJjWhJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOHnya8UBhYRWt7tB4fPK0uKwf51Ms0ddgmJ8/bSK+g=;
 b=B++3F4TCZdEx8cJbDw909+n4MJJbRY6A7sLC0RdBerYjNlW4N1lzOAxu51APbohg8CdR2GeGnkxOoq9L7pmv5JIjuU0UNE6VKm5EKbl8KcXMV+R2aDMy0uq2F28FCpfumAw/+1x33Fo/6t/BkEKf/O5JlF+RiLF3x4DsXTx/qdg=
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 03:06:48 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::7e) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 03:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 03:06:47 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 22:06:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Jerry Zuo <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: Add logging for eDP v1.4 supported sink rates
Date: Tue, 25 Apr 2023 08:34:17 +0530
Message-ID: <20230425030417.1213167-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d4c153-f08c-4168-d691-08db453a1bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3ItMnStXFmIOfxXMM5WenMd58xh40P9mWi7ugYQc9d8DGrzY6l1T3VhUnNG5/nBnhZmTBGZtuenjFDpA0yf1YBUcOyd06LOG69yqJ6YTnXMW9RyaWEP5/0raDWoPT9Gnc4HmSFes2gnI/kxkzkPgW3Rzt3o0sIGSrTl1akD7NfKtiQbgiO6wZkkxTtmWI+j1HQ2xZ0DNIo8KRQl1L+vHJL6CHwvyrsLSioEdaXagcWh9FZQ67JmVNg5OvSJlvyNaQO+ToZ5fBQHBdqL7yZQf4RnC6BqW7mO+w82PBVjx6Qdh/mLNczRx6X55wleqc5Yur2WrmzvL2sCXBGmLZsifwLUWDmD/B1je7vJR/KMg/zBM+GDxx8HC/PcYuha7WSeTB9UunQnj3NE1q/uusFC+R1ozpduLB8an6mpeLEFlaIknaG2ubxuRGAYV7q4ba/vA/Llg30xr5ayYrWRfBcXS00//nHWFfQrK1s2MHPZJ7gLGLvj+f+XGBLKtUvuJ9pKtXOUa3JuCe3VvyWjTnQJKeFopTDpLDrl57+5l0/vYGwrhQ/lYiFpENAZD4Ktv64+tFCsKWrlNSG2NFWmVhV3fA0xqbjZMilg4XVhfIzw13V1kIrgd2QgErGfXIs4DRAWO/xGHoltl+nH7Z/2gRS0lnURP4QCtncggrLelQizryK9YyOGDUrZ4HPhc7I7LJ85wAbt3iDXGNzSCiMxsIcrAV8cotbK7vfnEHAxAqmkzMU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(16526019)(110136005)(54906003)(6636002)(86362001)(36756003)(186003)(26005)(82310400005)(1076003)(40480700001)(4326008)(316002)(6666004)(82740400003)(44832011)(83380400001)(70206006)(70586007)(36860700001)(2906002)(336012)(356005)(426003)(8676002)(41300700001)(81166007)(7696005)(5660300002)(8936002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 03:06:47.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d4c153-f08c-4168-d691-08db453a1bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Include eDP v1.4 panels supported sink rates in debug output,
useful info for knowing optimized link rates

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 84265dc66bba..b69187ce8adb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1952,6 +1952,9 @@ void detect_edp_sink_caps(struct dc_link *link)
 			link_rate_in_khz = (supported_link_rates[entry+1] * 0x100 +
 										supported_link_rates[entry]) * 200;
 
+			DC_LOG_DC("%s: eDP v1.4 supported sink rates: [%d] %d kHz\n", __func__,
+				  entry / 2, link_rate_in_khz);
+
 			if (link_rate_in_khz != 0) {
 				link_rate = linkRateInKHzToLinkRateMultiplier(link_rate_in_khz);
 				link->dpcd_caps.edp_supported_link_rates[link->dpcd_caps.edp_supported_link_rates_count] = link_rate;
-- 
2.25.1

