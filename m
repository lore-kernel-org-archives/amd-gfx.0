Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D21DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CAE20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tNzqpUuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CAE20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E5C6E49C;
	Mon,  8 Jun 2020 04:59:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACF16E49A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJgvF6UmeN2hkMDboP/xAo84oTcOZMGE3W9NEUXCfkhfHjm36FhSAgr+L/ycGbnBepwnot0hff7eI7C50PC6xSuaG9UJ+JN+DP/fmMpL2VWJQdYG8EHmYxb+Aaj2yYz4nA4L23prTaYo7Ejk2WNq2/A/7hP3ho1V7wt9Orsv+Xgb+gmHU0o/99VuRVW7Snne/ctuGbFEOcEGdNpUts7aBaYbx8scndV4sn58FdHKgw6wT4BoLvYadZzg0mu5VkBRDpNB0lfG+wXbq73AXYMJ+qEVV1dTwugmkPiA/4ggHuEu2ZN4H+pWi/p3cImCzNl2KoeDlG3D2vZ7X5Lv49I7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOOYYCg6e6pnYeebdHII+SeHhJEqzGl21ygirTwXpH0=;
 b=j6TcYic98Whpm0vx3d+p9vNHX50sizOg0cT8K0io6LKacLE0OHqhGI2f1EYdrBuLB4uB0S1ZUxAlUIUhewz/t/roLr+mD/+kVIYAcz3VUfaQWdKRgUMf5BUP09vtjQppDcFu5XMN0NjW6pzvsyV1BuDbIbqvMu5e6EuMVA9WbrHgycWNea2fEHJcfLMu+u0WFopbEChlw3P+cMilWwkM9vts2c7ytqbKgxrB82LyEvVsZu23hbPKTHOrmwSvufh7dtBBqLM6anxv7az49IezIwBYAaDinloG0R+4oFoCwBB7qou53tLe34zhpFNSCeEaBn9rfZlYjjwANkwLEPlmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOOYYCg6e6pnYeebdHII+SeHhJEqzGl21ygirTwXpH0=;
 b=tNzqpUuz6GH7/5gne4ooJOLBD4k5DRKLK3VbO9fJT8wasz6FOhR0Br1Uxq73GsQ2rRupUO0r82Xh+KOByU4obfPEzQ+VNxhcXDvFerSV4Xr6ztR69XqOJ1DSk0cCJuVccFwOtzEUUQ1M4DPgNuZbpgIq6kPIcxjQsp0AOJTZQiM=
Received: from MWHPR04CA0036.namprd04.prod.outlook.com (2603:10b6:300:ee::22)
 by MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:49 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::cc) by MWHPR04CA0036.outlook.office365.com
 (2603:10b6:300:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:48 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:47 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:47 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/28] drm/amd/display: not reset dmub in driver.
Date: Mon, 8 Jun 2020 00:59:23 -0400
Message-ID: <20200608045926.17197-26-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(6666004)(86362001)(316002)(81166007)(2906002)(70206006)(186003)(8676002)(82740400003)(26005)(70586007)(54906003)(47076004)(336012)(356005)(5660300002)(8936002)(6916009)(478600001)(1076003)(83380400001)(36756003)(426003)(2616005)(4326008)(82310400002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e54304e-3fa0-4171-2e3b-08d80b68c5a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35835BFB9272A3180B8BEADCFB850@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVcVKEFBtUmrwx8TPF8xL5CeU/PZCsSnhDJ3SAw0P8UwKkLEwPrCBChHEk2c1eR8w7sOv0uHdm51r/4ooQChYns8O9/uJwjXvEdcX/8lLn5rRDE+D9ewh4X5GcHYoePfddlnYMniqpd7+MC16FwXg7IqBJTCopGPht1R+/Ck2cYZxMTADDFdcwsNfRVhuxJ/Xz1tugl/RuTkY4SfLSOaFUsZ/7rkgAQdCnVrBp9xrr75a2s/Xvp1dksS7saNy1bNZHKXuO+aAUJz/lpdlwyHvoEvbrpZuUNhr5y+jUs8OT2NiopcXzJAdjrYJv7k67cE8S5otR/Ra9TtH7a5duNYWKAvcQzVDTDCNZIm1LKWjsFiBXc6gqIA4FxRKlUyyD47c4xFd3Q+JfWb8ToOQLv2lw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:49.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e54304e-3fa0-4171-2e3b-08d80b68c5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
during S0i3, set power state is toggled a few times,
and dmub uC will restart with current reset/hw_init.

[How]
Remove reset in set power state, and before doing hw_init,
check if dmub is enabled, and doing FW autoload check only
if dmub is already enabled.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 1e03f6fdabd6..2c4a2fe9311d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -275,7 +275,11 @@ void dmub_dcn20_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset)
 
 bool dmub_dcn20_is_hw_init(struct dmub_srv *dmub)
 {
-	return REG_READ(DMCUB_REGION3_CW2_BASE_ADDRESS) != 0;
+	uint32_t is_hw_init;
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
+
+	return is_hw_init != 0;
 }
 
 bool dmub_dcn20_is_supported(struct dmub_srv *dmub)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
