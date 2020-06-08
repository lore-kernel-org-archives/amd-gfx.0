Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9572C20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XhILkcxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9572C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBE96E49A;
	Mon,  8 Jun 2020 04:59:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D116E49A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMME5aCqfa8wdFP/IofPC2q40bPL7KRPBcyR6zKyChFK3XGB+ugFDAuS33287fRdRqcHWKog1NB1BMMGVmhKoqtgKe034NfXLHQLD+r/Ij+rqhWS2nxsJJfsxIrRD0U2zKFswz3xfBJ/ONAyJNv0Iuv6/SfzgxMbDKz85e2fEyqNrWnQAkFn8SRptZqoUhwZbAuHUYsLlHumVjMVp0kWXWHWsGIBprCPjyr5Wt+Vhn+DFBOrgw6qcGHE7hcOthaQuD2FjhI6VYIpgSPIMTTxuqTKChAP6ssIIMzETwmvvswfgZ3sCX1bgAW2xqM8Nc6RyYPYm2xwoj2KuqvBQDTjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbiVkjP3WrKlzOIUH6GfS0CCJOKPRtPFYq/il9smkg8=;
 b=kPde+Bf2z+f5ARChdI/2JSWlhZPpreHHfniPjD29JAPr1zumuyimxtEUiDDFo13Vzx7ZlNgj/rTU1YQkB0/Z5mxdBg4otvKp9mi/ToDrcNKsgfmYMaaYpdJvU57dctXiVdkvaZEhOOeH8Av1mjpTMuefCrlgfV6tGvtDDIE/jizG6Xls54WPHgo8PGkWJmfnqyjuZv8t3B2/4ByU3zMy/9IdAEFNR7TWZVZ7nHef3QYPxjq35hNI7avaJ4Qq5Jxt5lv8fwTbVjKLuG7ZIIoB4auhimcRN0V9rOeKdKOJK8Xc6nopoidyjBUeHCXO/hkg0eV+qLyZAm8q2Bhuid0saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbiVkjP3WrKlzOIUH6GfS0CCJOKPRtPFYq/il9smkg8=;
 b=XhILkcxpjbvxj1V1qTbvMd1rM6JUW85QCn74g8IKLrxhcn++RVQfo89At8kf1JoJOshkdsDlgTicypBhb6k7qMYSkjpyECGwtAZDytrPkH/ZJWDo9UAkht3SPp6vYUGReeI2KYB/B0jhB2P6mB1JqALQ4U8hBtuD4W0ulYrsiSI=
Received: from DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31)
 by DM5PR1201MB0043.namprd12.prod.outlook.com (2603:10b6:4:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:49 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::64) by DM5PR1101CA0021.outlook.office365.com
 (2603:10b6:4:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:48 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:48 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:48 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/28] drm/amd/display: Not doing bios data pack.
Date: Mon, 8 Jun 2020 00:59:24 -0400
Message-ID: <20200608045926.17197-27-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(2906002)(1076003)(6666004)(8676002)(36756003)(8936002)(86362001)(5660300002)(26005)(70586007)(186003)(6916009)(478600001)(70206006)(316002)(44832011)(2616005)(81166007)(54906003)(4326008)(47076004)(336012)(426003)(82740400003)(356005)(82310400002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e8532e-a1fb-482a-7afe-08d80b68c5be
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0043:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0043F1E2296C23504D386C8BFB850@DM5PR1201MB0043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7oCZy6caGAKObziz+7uacDhVmx55w8a2EjIVpdHRDQOZZwi14XJPRn0S+mSGyTTPqAFmHXyQ0SJgzBGb7W3iWA2+JBMVS6eTatXtOPjPKHhQvTZzNN9vQR1r61lsX2odMPiqzNvwPiRw1g1uKFvro5CDVFdL5F4VdPcvuvoEQ2+5tySfpoOH1h9Wcj2mvQNbZZX8LRK4SJ2TlXKCssEbDCa5PQOB5DK/0JN8JJBpj8jz8q89SAEzE7twvU/ZHfL0SnbDXLp4E7kVSeAeG0SDdRHSdGJOdCqVsS5uYrgExbzJF74NxHeqloNZV9xVvoXg3z/k03tvAfYF+fETOrPzwCfGuRphY5BNW29+xY5vbSBFzXT4XatkC6x9y0s6gr5s1wGgGMxHE5CRV0lJY/Q2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:49.4184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e8532e-a1fb-482a-7afe-08d80b68c5be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0043
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
dmub FW running abnormal after resume from S0i3 due
to data aliagnment issue.

[How]
Before having a solution for this issue, temparory
not doing data pack.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 150cdbc02d44..9311fec1643c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1880,10 +1880,12 @@ static enum bp_result bios_get_board_layout_info(
 	return BP_RESULT_OK;
 }
 
+
 static uint16_t bios_parser_pack_data_tables(
 	struct dc_bios *dcb,
 	void *dst)
 {
+#ifdef PACK_BIOS_DATA
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct atom_rom_header_v2_2 *rom_header = NULL;
 	struct atom_rom_header_v2_2 *packed_rom_header = NULL;
@@ -1975,6 +1977,9 @@ static uint16_t bios_parser_pack_data_tables(
 		}
 	}
 	return packed_data_tbl_offset;
+#endif
+	// TODO: There is data bytes alignment issue, disable it for now.
+	return 0;
 }
 
 static const struct dc_vbios_funcs vbios_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
