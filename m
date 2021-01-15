Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2480206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2480206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630FE89381;
	Fri, 15 Jan 2021 17:31:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078A289381
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHnfvCGmFog80buGemE97603Xde4uylBwqHQBTdLZlxIahKgM8y9PZT08Tw2MB8Otq5R4HseK6+pnOf/QiV15D6/ypv+GQX8jy4y3EMShM3YaFW/c17AHHY4WIkVAtjKu3hjwmE/M732ghgJ2jknp12aciQ45sKi1iVSNRBkBpoJ6uvbTxjdoLcvxEQ4iIgNBf7ETx+fBYFJNcrfM+Y39VH0qQteBKgKnn+Vnejnq/u/X+I0p0KneydnfH0cYXkVXxAw4rqe2enLqTGiIH7mM9ZVE/iHlEloFfkmnpcdTFhH+HrIg9afEOvf5nuWhYPZJUl0BccaJI4mLFu0I466Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FDyLSXHi+KHqiakLOLSTizmiWzTL37a+c0Yai8TWwc=;
 b=kzbZDmm+VBKuDHDvRuWOk1SVaBgmuA0YDpLfr8J5olEbk0ciO1UsyLDRq4yYNFNlMSW79H+cDAPtDfhRngIFpRgiSA5ZRobktftyFCE1YlOD4KBVwRx+PUNPuKpmHzfFd2oeZotFYsvsyA9InupqNMVutRhAUrqcfX44ns0xdjah/veX7E11ltYTSADxQh4j6KWRq9ZdjeA+aY2VekI6xKvc+HasJo4mFLlodPY+I5EcU2e2qC8suBIARUw3bwSsHBiDQ/K2JtYO6BKQxWf42pHlJm1J4GmUTsSBc5MePyLzw/Af0IvCDoN5mT714yttA/2iXmntOPhkJGuE3+40lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FDyLSXHi+KHqiakLOLSTizmiWzTL37a+c0Yai8TWwc=;
 b=WFvV3f1Ui7ib4Rt+Ix09WXco5v4sVFJO1AsqPjjUGp2h/FG55qw3ydm9EjYbGSNJxkTrGHQ3F0wQvisYanJNPTn5YIU0HPcPJRg32TMjzUMy3ia7bjuaCaVuG2s/WIBTRFjH64+PZou4N5drJ8K+Rd1vygDAYBBHF7Xcjs6fzIY=
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:31:47 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::5a) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:46 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:46 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:40 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Update dram_clock_change_latency for
 DCN2.1
Date: Fri, 15 Jan 2021 12:27:16 -0500
Message-ID: <20210115172714.126866-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57dc7424-3a00-42b9-909a-08d8b97b6ef7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:
X-Microsoft-Antispam-PRVS: <BL0PR12MB238517421CA468284658535CEBA70@BL0PR12MB2385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVroxTLtIKjyX6kzD5O1mDl6OPsQUa57pJh2aZAZKh8K0jUT3yohtfSyAz4YtW5XmxwTGpYz2CZd1moASSEU6hH/1SvkN02C39h1WQ9PJQyWANCDwhHdQg5aqyCHhZpo8Dd0oy3FBTiaSaEgiPBS+9Yzl1VjRpd1Yptohr+cmWg3JxlBmTX3uGnIuIQ9I5GOARfHefvagA4x0WxT4Rx32uj57OhS83VOjj6MWlUGlJXxwM/RIl1F+h7rHVTbegyE6fazMXFGnSmgUenA6Hn01Gi2IxVcKQI91CDild4RTMU0TsWq54lYiM0WXnRlUGO7gmyc/ZeISA7KjGOJFbdMdTMLfHzwEwkOwWJj3e+vAbhkzuQYZlCg3ckRu5bAF5UsFdeatCvpXzsG6RO1xBOb67emlqIYT2tJ+3Bhs91MXn3gm+2Sko3XIlAaM02pJIvZ0x+Qo+fRb01dV3nPGRxgw927rCu0TI/rSEvG4KlmCOX24g2E/tz8FIO+WbPUrzID
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(70586007)(478600001)(4326008)(70206006)(81166007)(5660300002)(8676002)(82740400003)(1076003)(47076005)(336012)(7696005)(82310400003)(8936002)(83380400001)(86362001)(54906003)(186003)(34020700004)(356005)(2906002)(15650500001)(6916009)(316002)(426003)(2616005)(36756003)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:46.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dc7424-3a00-42b9-909a-08d8b97b6ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
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
Cc: Sung Lee <Sung.Lee@amd.com>, Eryk.Brol@amd.com,
 Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[WHY]
dram clock change latencies get updated using ddr4 latency table, but
that update does not happen before validation. This value
should not be the default and should be number received from
df for better mode support.
This may cause a PState hang on high refresh panels with short vblanks
such as on 1080p 360hz or 300hz panels.

[HOW]
Update latency from 23.84 to 11.72.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 1c88d2edd381..b000b43a820d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -296,7 +296,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.num_banks = 8,
 	.num_chans = 4,
 	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 23.84,
+	.dram_clock_change_latency_us = 11.72,
 	.return_bus_width_bytes = 64,
 	.dispclk_dppclk_vco_speed_mhz = 3600,
 	.xfc_bus_transport_time_us = 4,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
