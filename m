Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D5C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E6920801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QN0iDwvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E6920801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97D66E484;
	Mon,  8 Jun 2020 04:59:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F13B6E484
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5IdEl1qs4no7+GC7jdWKKb9BN5+oTVc3cbzi/04jxTkcA/TwlyByJgm0gTH/9QQwajR7bjFp0nyaWVa/TPyLbw5Wk7bBsmXFqTAUli+D4KxT9w3ADum0hc0RZIz4M8YeU4syUSt3Q1kKfFX3dK6QCyuTGJEA8Uw3mNBeH3B8doainuWc5xY0HZ4kk+KvA/01FtLDw5e5h5jrLHQnIScG+alHStRy1ghrZhqa0R/XlWRE58QOtHVojk373zWarDV+Eh509ncwkCBBAJHRKoYcpTYPUPqXdWGWFCwAkBVIM3rp33YDaapTzahw/UTSgpDuBM4ZqNPGfwGYaBD17FgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCB//a8g1/F0LVHlCurs5LYT0fjbyTfxYI9wv71TzGY=;
 b=Kmm0l/Ojx7eF+WDwyAw52CALqVDHRcHwg0qja6RKIHOLT2MqvwPP+U27yDWaxYeLaL5w/NTo//eB4fAJ0Q/Ou72n6Mmxph2vB38NssHQuQ37lEfaxz/GMW05R0SokHndbjA7fMaU/M1qRQFKtI5VK5Kjdy0rfu8e1C2PVzfXMwETwOTIz5zLQcCcLwBFGqA4aodMLsiS80uPDFbKzPeFI5NihG037/4YmqLtAa+AP6NKqJ4PO60JCgiF17JZCDAk8T9wUj0BDzWBIHnL4g0xzspiWPLaOOrBNOKYXjylIOCFhdxTbN65uTKoj4FTnaOe4oVEPAz8r43IRnTLt9h34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCB//a8g1/F0LVHlCurs5LYT0fjbyTfxYI9wv71TzGY=;
 b=QN0iDwvXIj24/SplsE85R4z4bp7W+7ytyYu9uCvAR9hoCCVCklsmv8yiNeptDm6yYfcVwKsQrzEvhSS+bAMCPTL46T2Y/n2+RP1wD2yMJ599JFiJz/lt+AMhYsFcFx5xmDunIpaJV8lbQzIzbhYb7bDQ9hiBpBMxXwu1qYkA2Kk=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by MWHPR1201MB0016.namprd12.prod.outlook.com (2603:10b6:300:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:33 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::e8) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:33 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:31 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:31 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/28] drm/amd/display: Use u16 for drm_bpp in DSC calculations
Date: Mon, 8 Jun 2020 00:59:04 -0400
Message-ID: <20200608045926.17197-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966005)(186003)(2906002)(8936002)(26005)(86362001)(82310400002)(83380400001)(478600001)(82740400003)(54906003)(4326008)(81166007)(356005)(47076004)(2616005)(70586007)(5660300002)(36756003)(1076003)(44832011)(336012)(426003)(6916009)(6666004)(8676002)(316002)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f04072-83b4-4478-5612-08d80b68bc4d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0016:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0016D7B7FA79DFD2A9AF2954FB850@MWHPR1201MB0016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrmN4JvXjKHNCeLG5R6rJyXi6Vp7C/7nOjWjVo/MHwjI7eXHLPiTsmRVMtQKfU1j6iqKN0WqKrfnjvDWAGJPgwZ4dlIxS7kVOErx7mvRqBPTnTlu3rc/nbPKualkgxvt/Ewbpq2cs8NgA1Tyna2vYN/i18hcHAy+5ZaZJt7k0s2gcVQGPZKTK9A4fDtYWprrEDdpVi9bmKkzWVbv4PcnEyOZi0FoPJIgNwRLcCnD/WCIO4Fdf/H8rLz7Mf9WApIAUHotLPQ8k9uQv+j+ivfXqUdcuaiJ+ySrukMeiKNPajMiRqggL4XS44A6fLJKKs6stu2n/JAStDI1BpkmgmbhFPDSs5WwFXZgb/wPKcn8gQPBfu6ob0fwKeWu2o2xIp/lG8RIKBGfRUs81Ub6ntUvTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:33.5025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f04072-83b4-4478-5612-08d80b68bc4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0016
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DSC calculations fail because the u16 bits_per_pixel from
the DRM struct is being casted to the u8 drm_bpp parameters
and locals. Integer wraparound is happening because this
value is greater than 255.

[How]
Use u16 to match what's in the structure instead of u8.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 667afbc260f9..4da21966ddce 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -175,7 +175,7 @@ static int median3(int a, int b, int c)
 }
 
 static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
-			       enum bits_per_comp bpc, u8 drm_bpp,
+			       enum bits_per_comp bpc, u16 drm_bpp,
 			       bool is_navite_422_or_420,
 			       int slice_width, int slice_height,
 			       int minor_version)
@@ -265,7 +265,7 @@ static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
 	rc->rc_buf_thresh[13] = 8064;
 }
 
-static u32 _do_bytes_per_pixel_calc(int slice_width, u8 drm_bpp,
+static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
 				    bool is_navite_422_or_420)
 {
 	float bpp;
@@ -321,7 +321,7 @@ void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps)
 	enum colour_mode mode;
 	enum bits_per_comp bpc;
 	bool is_navite_422_or_420;
-	u8 drm_bpp = pps->bits_per_pixel;
+	u16 drm_bpp = pps->bits_per_pixel;
 	int slice_width  = pps->slice_width;
 	int slice_height = pps->slice_height;
 
@@ -357,7 +357,7 @@ u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps)
 
 {
 	u32 ret;
-	u8 drm_bpp = pps->bits_per_pixel;
+	u16 drm_bpp = pps->bits_per_pixel;
 	int slice_width  = pps->slice_width;
 	bool is_navite_422_or_420 = pps->native_422 || pps->native_420;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
