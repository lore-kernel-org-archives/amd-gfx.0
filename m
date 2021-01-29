Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622DC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B8F64E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B8F64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E836EC20;
	Fri, 29 Jan 2021 21:28:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54FA89D43
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV4hvQMz/vhRtDiZ9tXh9R7bmtDvmPDHRlqrwDvJN51U6bEJQd7giLY5B7TAVzBPFNtpaTB5wWIZk20YxJrvgSVbM46NJVJHB2cZsCJnXdHsdVcTfdhsqNYIgPLceMtK7wgp6KDMp3hDoSODcB4QeWhNB11yalOa0ze+j5nZrKPhIDRKiYfbi3tSmGhPO3Xe/piFmzBxwHsIL1E3RIehVSeEAyP2Ku5KTKQ4N/st7CRbA2kTKTLjj8Ihgq1w2bJELVBO0ywV6JRcCoI882g3Z4BW34duwk8vFrwknnNsR29oBeEpz1OELKHITNHPDkS2R2VAv19vf4RcXT1j/fizwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up0jmqazYnW525m3tI9PvDKdQkTcWZNSmi4uSORGSNs=;
 b=OT07aCd13WBS++RGcJonrLiObmi8o03A2TqJDnPgP+x3eyTqb12oAVf7qH5PXohYpga8ZaTyrCR5AY+S5gP3pVP7qhzPkKCwu+JcxMIl6+KPh1XNYyiNieYrIOV2quGcG2skScGhCMQGRX1/UL2UbZwWhH1b1Nl3+nvXau3XAh+sVrCmjGeRe/VzpkJgNsMaL/wn/xXQLNsmz8+Ec+t9UmDjQSDAcqXcHPToS2hTRrcfnMV5gvCziF7qmJtalpVqHVaGQ9J/QsdWn//eMIIdpXI4OXn/5Kzj0G8nxD0QvcsYyTRIUedw6hDAly7vDCIacOMuHPsy6U9A2IGeHP/2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up0jmqazYnW525m3tI9PvDKdQkTcWZNSmi4uSORGSNs=;
 b=cM9uixW97zUTxUingwmajmAvyAxMUbJp7VT7U6Pph/w5YzmgBVFy0zyc+YWsgGro5+g4Z0qe4CBrMDxf78Tra9zG0N+zmj2UVul4N7v0zXXLXXVFY3uH4NOWPYoAyrL+busKtoeUbHGCaTGWd2bfAAp5EDgPtqfKs2loem9tIQQ=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 21:28:06 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c5) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:02 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:02 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:01 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/27] drm/amd/display: initialize i2c speed if not
 initialized in dcnxxx__resource.c
Date: Fri, 29 Jan 2021 16:27:28 -0500
Message-ID: <20210129212752.38865-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d854b5-1ce7-42d4-ebad-08d8c49cc34e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4867F508CEA2CF264635D0FAEBB99@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlzEdl9CYOIIDtgyXy5wNfQnMO59x2TkGsqjxSmhEBZIGOcfh8dAXQ9Zm1hImXq7FexhGMyEOUk9oLbTqu3+ofG0P+i8fTcbHEAIgMFrKTYEGy8DtD0gCr4HpmEXV12GaKEYOrGxNrBwicO/GJpAM/ZjvhelPviZYsKe08MTAjhGrBRWztZBolMhXeZRST/FVzKoxH7Y/yc2aVeByJGXLNjVyvYmyFN6cH6fPTXB7J5klE5dFJVWxhLJulo3gFwEVpvzgN2XkL19nDZ+8S3DmCPP7Qo47Z6jXJ9eIHLF8DNiIokmVMphkHvZaNqaJuLoAXwJ3x2k1TLjBL7EOq0aiG7cbltMz4+t/1veBoilgfl05EPKWNeqNK5CTZ2BLn6c25efrZF+adPN+E0dGcyOdzvRKTTfD4CLsoAm7uXRtVJKkVRYnekEJH2ZtrdDP7Mx31B6Zox4eMkSn1RPc78MHm5JkYMWLxHhJspjMKtvKgWOZGNRd2H/fGSCa2ZAwZQ35hhpirnM2itZrQcsgQ6I2RI5cnAjsKEbiqaaEVkF8My1YN9wkhM+BNk1dn6X8Igl8oqBJbaBpXbvzsodtOp2y75nRYiQGbCrF/BrsU8QUlGS+q+gjHE18fkDIcofEqDl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(86362001)(26005)(478600001)(186003)(8676002)(5660300002)(1076003)(47076005)(336012)(36756003)(54906003)(316002)(356005)(6666004)(82310400003)(70586007)(2906002)(426003)(82740400003)(7696005)(4326008)(2616005)(81166007)(6916009)(8936002)(70206006)(101420200001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:04.1957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d854b5-1ce7-42d4-ebad-08d8c49cc34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
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
Cc: Charlene Liu <Charlene.Liu@amd.com>,
 Brendan Steve Leder <brendanSteve.Leder@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brendan Steve Leder <brendanSteve.Leder@amd.com>

Some dcnxxx__resource.c do not initialize the i2c speed; this patch adds
the required initialization at dc_construct().

Signed-off-by: Brendan Steve Leder <brendanSteve.Leder@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2bb0ec6a86b8..8fa179cbed32 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -761,6 +761,10 @@ static bool dc_construct(struct dc *dc,
 	if (!dc->res_pool)
 		goto fail;
 
+	/* set i2c speed if not done by the respective dcnxxx__resource.c */
+	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
+		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
+
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
