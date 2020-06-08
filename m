Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F9CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199AA20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BJpfY3ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199AA20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46916E461;
	Mon,  8 Jun 2020 04:59:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700078.outbound.protection.outlook.com [40.107.70.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36326E489
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9mv3frtDTdYFsHuc8pk3lBQ/nDBkbWR96vh9b8U0evFAWLWYpppdgLkkPwzYtClOzGjvhVEeO3u97zxSi0h8ndu7qO/Xn9y6tOw85GKcNy1uWN4YnGiRLq2FS2eXoJsMIPiLFAESsqkyaTizgJKVBv2eqtu7OH4JtDlMuOhiFuWNLAk3HO+ugNbQCco5VBxP1HUzP+3nK1i2Fow9HRyi9iNeklvoA7SgiuUbezz/QX4gYgE+jfAGLpHQIVeqOJ+1LcHQml7G0KrpJf9G4AEfKS0Zc42QHT3jRyITbhdYfrQECsi+ykw/JBVE2l4WRBiIxkTuF5WRdBjrarA/kbhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acjb9vHTjbZJNJdIeIw2mYrY8ERsKgiimM+abc9rELE=;
 b=CKTCoai74T0JSUZ72JGUI78hovKlz0BcB48v749MOtl0DXCbx0QaW0oiHVVmEK09zdv3KGNdkBNbbyu2myYlOF1AEMz5X4sZP2SrvvCG+fmYtcYLRqdm7CFaWqK0R1sVXhNtn0PR7LwNDXa648rxNMy2JVEjIAOEbQ0K02qwXcVbEw8a122AyxrlzrM0xiW3/buC9UW5uG43xYK91M6RmPSn03OtayEwfWYuwG6wjZvL0WMaKrvXK6hm80BELP3ZQA1L6oXo+e38/5G6IGWy9hh7CpokDzwWCrBkM7xjp5Um/PMcgKRvxFdRKXPv7Akgttq3yp3yiMfId10YRBTtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acjb9vHTjbZJNJdIeIw2mYrY8ERsKgiimM+abc9rELE=;
 b=BJpfY3htPuRL8ibG8uKJ5G51if8ylQm9YrrPOX3MnTSqNIB5RPOpVXp16lvaxu+ltxSRuWXcdFEGX1d/fMkxt/uDkxEzOqP/ugFMmslg64Cqiv4j46fYyEotDfLWcHq6U78KS3VeJwSC3dGCpSNDNAHp4ZpNAgAwoMyV32Q1+Ao=
Received: from MWHPR22CA0004.namprd22.prod.outlook.com (2603:10b6:300:ef::14)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 04:59:40 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::61) by MWHPR22CA0004.outlook.office365.com
 (2603:10b6:300:ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:35 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/28] drm/amd/display: Force delay after DP receive power up
Date: Mon, 8 Jun 2020 00:59:11 -0400
Message-ID: <20200608045926.17197-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(316002)(82740400003)(47076004)(70206006)(70586007)(44832011)(356005)(478600001)(5660300002)(1076003)(426003)(2616005)(26005)(81166007)(36756003)(54906003)(336012)(4326008)(6916009)(8936002)(86362001)(186003)(8676002)(2906002)(83380400001)(6666004)(82310400002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a73e87d-a2d6-4e2d-ee21-08d80b68c04d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15497AF17A09BD71165818BBFB850@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XONZsovUGBG9Cvc5oaDMqqFjYTxXPZ9AO1Mm5o+EQK5VoibXGIsJhY3ObxFn+d1yxALXfkyzoSu7Bq8vCDr3cJttgIiGzztqR8WGnE2z8grneiJeEWTu1F1dSMnBC+5MUctwg6AMuyJb02EAKLAF1JpNWVzS7lBtZMHHwDZAHhnz11IW/dkBoZrPfqIGav7SYQAdHjS2OgyTGzmLPW4Zl9zcdr6gEj2yAFEVuJBZTK+nL1V1TwqJP4uUundhctkBneDZYMSCg5jzVUmDe7SFuy7iBWI386FKLRBrDp0v+oVk05SlrFFh7ALrgkiHA0/OVdIEq4rUB5hMniYzd8wwzsGRXmyemom9cHACF92tDozcDnaQNQLX67cofAoaqO5cUEzu8tlibGX5i1Uok1YEvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:40.2043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a73e87d-a2d6-4e2d-ee21-08d80b68c04d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
Cc: Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Some sprcified monitor scalar cannot recognize timing
change on demand. Once the link phy disable and enable
during a short period then the Sink protection mechanism
could keep the screen in blank and cannot be recoverred.

[How]
To add 100ms delay between enable link phy and link training.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 08c3b32e188c..674f53aaf2b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1559,9 +1559,10 @@ bool perform_link_training_with_retries(
 			pipe_ctx->clock_source->id,
 			link_setting);
 
-		if (stream->sink_patches.dppowerup_delay > 0) {
-			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
-
+		if ((link && link->dc->debug.dppowerup_delay > 0) || stream->sink_patches.dppowerup_delay > 0) {
+			int delay_dp_power_up_in_ms =
+				(link->dc->debug.dppowerup_delay >= stream->sink_patches.dppowerup_delay) ?
+				link->dc->debug.dppowerup_delay : stream->sink_patches.dppowerup_delay;
 			msleep(delay_dp_power_up_in_ms);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8cdbfa15874b..9138adf63f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -498,6 +498,7 @@ struct dc_debug_options {
 	bool usbc_combo_phy_reset_wa;
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
+	unsigned int dppowerup_delay;
 };
 
 struct dc_debug_data {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
