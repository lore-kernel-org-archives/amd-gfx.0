Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAEAC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFD16509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFD16509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908CA6EC4A;
	Fri,  5 Mar 2021 20:05:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DFF6EC49
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7gthMqbeE81KGU/a4HoZ37fG0hnj583Z1jp63RPIJRzZPn1jH/8sn1olZ7MtJX/Zjg83katm7qxpc2ttobCGAtWeglz25XfAaeRQm0vZmup6l7b+XSqtGN1vTvxY5DYybRNASSuh/obz9fM9lwBzB9zpj7IO1PAbVaPRt1p1exVVfTswgJSLtkKWuPAi5uFs+9BEYZnekcPT3XVoT7nt8ZklFwObcXVgXRTlCkIewQvtpl9q/qOtfSs0zckI+UaVOQ7sROn0jGsOuoB5Inz8PeHCtziaQJQ2/hAgBE40tpCR0Kb1XqAZ+6+xJpBK1MIiWSJQJHlsohc2495BhuPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z7EW6165waWIAyexq8v+rf7c5grQQteFBUyfgI2UZA=;
 b=VCJotlRFej7F7A7YAwCCJtqfzr7Tx+1FoH5VVXMuZZ5glAxMWyuKvIHJG3AAiudLDH/PIsZh3KrkWcUt9Efegc99fB1GzZftOXRox350RIfaTpIgxuqobmpB9yb8jMstZi0iLunaYM2iZP4lJnRkdkordqCYpd6909cHezXbkC7zlgbr/cKideg11Vou70ekuYUvdMp4HI3kr3fxUD8h2s8kEUA6hm87m6W7yTX0NUEbMtZJpKvn8ZK/9BzX8XHgawzqE8tL1DOa3O1SH37cAK8Oy/Ha2ObAE9QMhFH9BLB8+VuJGf/d3CnCtuf+nRabSOSfKvLGlsBkwhB1CJNbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z7EW6165waWIAyexq8v+rf7c5grQQteFBUyfgI2UZA=;
 b=1ZmbK7pvn1MPCgjxXbJS2krOEFmp1vwsCcxttujdMdVxibjF4fIKzL6E7uQWSCxl1S8/3yp4OTN1vLPSi/kLwxlRFFoE/yeaZWNAk+p9yuhuuK6SOMIlolODux2qVovv01iVF529/C5g7i29SKWiWQ5ZNtNZtZQtnF7LIZPcSm4=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 20:05:13 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::85) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:05:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:11 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:11 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:05:05 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: Revert dram_clock_change_latency for
 DCN2.1
Date: Fri, 5 Mar 2021 15:03:00 -0500
Message-ID: <20210305200301.17696-14-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94fcf69e-6668-44ad-ad3f-08d8e011fc31
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4107A4B4E6C707BC8851B013E5969@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1pvvggGgCWhlUivVwsVjA6VDNSSoajfvKnq3WJbscmRMUBvNMtrLVHlJGhAHOQspzO3QkBMVltsLsfwIkjh+SBhRVIj+fGjKasmsMKVjEbsoQ8E2np9Tu91/GzIrCCJiCAXd+7KRQVGiIDeWBFVOsRptx4iDNz/+AVAkTyxrfn5uLIXA1YrPG2mflGDn9ixkJCy8uJjetefmS7ug30KRH8oSMfQb0rlS556h7wMNSaYLUeWh+e2twLkNm2tMtWvC2FgcK7tA+GXWU38noX0skuiqT5BmyYDIZyiWhvS3CPHFXGxFjCWJqPKhMkB6oIirrxcySYLqWlyuhO2V7JK+VzDCgV3Siv2mbmg7rdIQtAJRMueEOy3LpuK5esClLXKus9PUSITMplVlA4dTPx9nyhaAzMz9cSBQmBygVJv+LF48jHInVzJ18wcrVS891HGGI5b6QxQgJXDWzLV+tMwNP+EiyYE23Q/cdWHy5U2XKUewpmpN0mscs5nyTQFM3qoyETdtWKvzf0woE2h9kSF5I/Yu3HhDka8PF1vv85Cls5ewmsNo/QiV9+E311boAxepWelAxdlC97MZP3Kcuw3Hp9Qr8XFdZR7s3NyyPYH1ccvS3fk6JqUUX+sEuySL1YpiNXmvowIvdWUXMv8srQ87zw/7rJQOeqhMCSFk/1nW/aq+P/aWjJ12o8SeCwuGMho
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(336012)(186003)(47076005)(54906003)(8676002)(70586007)(478600001)(44832011)(82740400003)(86362001)(36756003)(356005)(4326008)(316002)(81166007)(26005)(1076003)(6666004)(5660300002)(82310400003)(2906002)(6916009)(36860700001)(426003)(8936002)(83380400001)(70206006)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:05:12.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fcf69e-6668-44ad-ad3f-08d8e011fc31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Haonan Wang <Haonan.Wang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
Using values provided by DF for latency may cause hangs in
multi display configurations. Revert change to previous value.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Haonan Wang <Haonan.Wang2@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a30ba6c6dd5e..3c71fa8e015a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -296,7 +296,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.num_banks = 8,
 	.num_chans = 4,
 	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 23.84,
 	.return_bus_width_bytes = 64,
 	.dispclk_dppclk_vco_speed_mhz = 3600,
 	.xfc_bus_transport_time_us = 4,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
