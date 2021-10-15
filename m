Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E57461040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E57461040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86806EDED;
	Fri, 15 Oct 2021 18:44:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57E96EDEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtA/Ia+iRwN3BRX8QurjSvPPv30GW8iJM8l6par3oOcZ/2v1HqVx6An8cQB7f2PbycJWSZV4hrUDFGiAYr+jlNfpFSnuOJQpDX32VILL4FjaBu1AnoCmYSyN1r24QaBS6JqLVg6bJDWWN8jPL1xHcuPzgL3nElNevtGCqeDYFmEf53mJuj0pRaK7ZDupuBUv3ABMwThb+zCVvKbXYjqlXHCVkmx1mspvG1Hr/fUVUebdWLx7q9GRNJBrYZrFreq3cww0Y9EZpYR70YWL/GH8OJuoCQEFkBLoT/12rRcfIa73WAeL0Wst0pE3kCrt2/IJZPYOsocBi9BAkR5A6y3Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dHrcPI/JYWzmdKDsMYbAwXlQ4U4yoIWK1odre3VxbI=;
 b=HnSMaOmEksDWu05swg7BpX+SZx415n1XAF2gE5HYWVT5XXdugWYTJ6RbgGWhVfRvwFD0vC62f7Fp/lTuNchhc+hBbpiMlcYZVvwow8ufgV+gL4trdNQXpzCgZ4/UQuIRC7RiIulhLyykqO77qIqTwCGsOmrvdKZxI75oACQc8Sz4ctMtD5XRRneInVcfTEBVHc9D+RNuv0Te9bDwHiaiWS1m9ul5ZNtZcb6ZOxwmZcP7oxsSjxXdKihzGEJip5fQgJO2shPenjdXeSPfUdGkxcyiPpbIrsk9i/YjAOmgsbieSDN75RgiFuA0w7wZeBasouPQK4TfMrVXZ2QafOATpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dHrcPI/JYWzmdKDsMYbAwXlQ4U4yoIWK1odre3VxbI=;
 b=KEwkGgN0pjsFoKqneo1njmi11s6QpAhN0kvxQoFRoYpB1gewxRRJW/rsXbBycsXYK0GyWMQjgiK/FeaFMpMvv6W6rLONCZdMaf5LObNdNgWFysW3E9OYPcT1lVXHXgyJ8kwpV3r6Qyw8Z5JKjvIfEYKHKze7DhiliLTWE4fbMBk=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 18:44:09 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::8b) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:09 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:04 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Nikola Cornij <nikola.cornij@amd.com>, "Ahmad
 Othman" <ahmad.othman@amd.com>
Subject: [PATCH 17/27] drm/amd/display: Increase watermark latencies for DCN3.1
Date: Fri, 15 Oct 2021 14:43:22 -0400
Message-ID: <20211015184332.221091-18-agustin.gutierrez@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53ada7d2-e97c-41d8-38a0-08d9900bc627
X-MS-TrafficTypeDiagnostic: BN6PR12MB1218:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1218CDF193BFAEA55DFD6AF2F5B99@BN6PR12MB1218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x+L0xqzQ3k+9H5d87kgC5lMJJbo3ybggXDcW+vbmFYX175RbYCk/IWK8c8xwZ9yHdtiG5ad2q+4VwEXPoOngzuNwTrKBAI5oJ3nClg4LD9TJm9cJhfoNT9bjEaKXy5NHDA3DeohH0tldd54uu9tU+EVLYMyufnIkav80WMfbik3K933UtO8PWj40XUSkP2OCNk9BiaZYXY2O34nantMyYh9Fi4s2+WP2qE4BkJmTM24BNUGLdk68xN4uyIyO2V0si3w8PRPEmxq0DNUxd/YIBfXt34gEx/wR7Vq90YRPeMzVj0V1LdTRnRuahfZ066sDvkNIFJLmndnHra4wgtMB8OGZw/8HyRNQ6jyl4PNPPgO7HkfR3ihlv6svLiFvZJPFVISHowDkptfaJR7NWVyDv9q40TBhIb4ORIzyKGJNrUFzkqSfgSQfcs2GDHWeeGPOkTcsr5DqkK1BBTRkLZJBDPtHBJomANGifd4FQ7tyRdmA/VueX9NypcQ0A03pAaD7de+dxTJRhRwuRviQGqL0Y5gjh3KLJowBAbUjsAvV2gS/OHqejqGKccr+LjhVaf4kHBODzNpm1Wm8cUxvDPmvwm83uLtWgJ8G8i/IYmFylaBpb/EhjPeI6YV88F8f7U9hs0SNsnv7obv9uSPdceFJ2nrGL3FZ9PL8f152/O6PkE+WJiRQsMBqXIsqQBc2BaDd09eHh4drvZWxyRJpOzJLnE/HfENhjqdgnK4oayjdfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(4326008)(36756003)(6666004)(1076003)(26005)(54906003)(2616005)(16526019)(70206006)(8676002)(47076005)(44832011)(86362001)(2906002)(186003)(6916009)(316002)(81166007)(508600001)(426003)(356005)(8936002)(36860700001)(336012)(83380400001)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:09.2325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ada7d2-e97c-41d8-38a0-08d9900bc627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1218
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

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
The original latencies were causing underflow in some modes

[how]
Replace with the up-to-date watermark values based on new measurments

Reviewed-by: Ahmad Othman <ahmad.othman@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 3fae1f1f028d..0088dff441da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -371,32 +371,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 5.32,
-			.sr_enter_plus_exit_time_us = 6.38,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.82,
-			.sr_enter_plus_exit_time_us = 11.196,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.89,
-			.sr_enter_plus_exit_time_us = 11.24,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.748,
-			.sr_enter_plus_exit_time_us = 11.102,
+			.sr_exit_time_us = 11.5,
+			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
 		},
 	}
-- 
2.25.1

