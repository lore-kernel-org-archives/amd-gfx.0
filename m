Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB1C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B695F60FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B695F60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CD06E93F;
	Mon,  7 Jun 2021 16:49:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1FB6E942
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUZyheyXj1RQWnC+rF10loGCpSqdoSWZzvi59YctsgegXGatr4NErZTfofZwIiYSyncE6IX/hdUX+YP9jqpHLUd5OuZ0R+r73A+UWvIcq1v+q9dvNWJIR2JBKQrLOOpsKYFjB6RCy3H0ZTgeGPu+//YbzQbRumQng43kgfIpB9heBmZjKpazZJbByuY7JEGk228E2X4g4A4KOsSyi7Ekh6MUSnrHVhK0vaBfEYwb5PZ+ZQSl/+mCvse3epnpQBI0/74IGYJU5KunSEvKo2OYO8QVYtVKJo39rTz2YQMjxqFlkvRpkM8GdXz0sgXgxI0PI7gNl+eYKIJHKj3ZoFfw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOFmP21ERTWLtL/Vuzsr7JaGgMtqnX9EDB6kG+LYj+I=;
 b=WjeCr6e+kbAnkTTe9fKZl54SYOkSFL0hgcAGHEIFF44GaII20wRis/k5ErHqPI2JcribcVUedWspkzVkvxI+eAxaoiPJMv/80MYYYmHVTn3BHUnnLHTD/banbPbRYeva16AkqWU/jVo+zN3gLa9/onNkP5PZzeSrff5FQ+TU8O2QZSAewi3LrTpDnlysQa6Q8ZiqWIDilL/U5GIWd+Y9vqMH2jKLdtUZqaM2yqj3op/d1Z4Cp0tdrnV7L2Pw33CW3uGAKDKe4d9yAaaJpl3ghRZnPoTk0bcNYRF/oSjHy7HHgpUZBpFneSazrugHFYTJYlejINk8G8OWZp1XupCu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOFmP21ERTWLtL/Vuzsr7JaGgMtqnX9EDB6kG+LYj+I=;
 b=uFriXP0AT+dOD5yXsCGT7JI6OqzTQfAZ8oB5fDjJjcpLXhaU/eVm/yAg4IM31nuukVB8hy9mCznSkC/mvcODD1V5/wlbJYMW0/eEPo653BS9oIEXvm8vbfSxcKUxhMHuO3bl8Qu8GDjTo8iC0n0TzS3CNJV9AOLrVg9Cm+bjSjg=
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 16:48:59 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::d6) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:58 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:53 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/30] drm/amd/display: Set DISPCLK_MAX_ERRDET_CYCLES to 7
Date: Tue, 8 Jun 2021 00:47:05 +0800
Message-ID: <20210607164714.311325-22-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0ee6ea-266b-42d0-cf1a-08d929d42573
X-MS-TrafficTypeDiagnostic: BY5PR12MB4871:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4871B5157128EDAFD745BFDCFF389@BY5PR12MB4871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lSTI5efsuMJCuTxGGn7OxAGocGpm1KK0IQmwg3j6v0OsKOE2a3IKEerGiIYnTfkK7wot2Oupgm/p3Qbosx23Nq/uxLW6IPI2CfE1I6xt0Z36TPMXs5E5Q/jM+vCZ7pdY+85clj0TDjA/mL4L8N7IwZeB0s9guqQg54Z3HNb0LIBHzCCy8bbrd6dtbRHdxmBZDRwh2VsvhdNS/ZM7/d6/+SXrx7zg2dEEs9rkuZeLuQ6eal1j0vLRSOcdr2CcGgvxYvAggAl72oJXo1XDrT06pPmKQrsYhocR19IF0lK2jfmghl8T/X10SP/0r3urttjnzA+wjyaolrlrdNcGmCBqxcvvk5s+X6Zrny+FHRP075WHYtrFa9bS2eGlIlfKLoRmC7bIYGQpLgAgCArFHuoiTSWRgvjDp0McAPiTCXwBdCuWD5V/yjbgcyuloIWFeAZnYugbAqmgqBNtaIqsHWd7DCXtX6y3MIoUPrt+FJsF9xXVOFzrBkJS4p9cL8+nm99J0mN7ETCCH7m1LFe6PgVk0GIX/CuYJfwzWGQszGwpRTzLzVwU8jBapIruSJvf6+/XMX8Xp5ZZ8uF6pzRvVJQ/iUHW6ZUYQwvAee/JVNO4J8PveI5inAlzZ6MEq3IWtjNAMPo0NazrL7ka2RJ/WInCIMVlddFlaAKhcdz4veWHjV1ODVnysOGOJmhxCMEj/j1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(426003)(81166007)(82310400003)(86362001)(356005)(316002)(6666004)(16526019)(54906003)(186003)(47076005)(6916009)(36860700001)(1076003)(2906002)(26005)(478600001)(336012)(4326008)(83380400001)(70586007)(44832011)(5660300002)(70206006)(8936002)(36756003)(82740400003)(8676002)(7696005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:58.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0ee6ea-266b-42d0-cf1a-08d929d42573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DISPCLK_MAX_ERRDET_CYCLES must be 7 to prevent connection loss when
changing DENTIST_DISPCLK_WDIVIDER from 126 to 127 and back.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6df9009a6764..a48467d75e3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -244,7 +244,7 @@ void dcn20_dccg_init(struct dce_hwseq *hws)
 	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x1186a0);
 
 	/* This value is dependent on the hardware pipeline delay so set once per SOC */
-	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x801003c);
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0xe01003c);
 }
 
 void dcn20_disable_vga(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
