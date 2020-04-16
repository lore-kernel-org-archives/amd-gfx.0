Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E632AC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD61121841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dQ+5Pj7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD61121841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6786E156;
	Thu, 16 Apr 2020 23:41:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237DA6E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPyyZdECiHdGBYVYB/3rDJb47D9TNwndZEF7taX85RDIw2eMUqCfhdb3MYvjOd9dIZOWHT9BsDxNFOy2TAC64TLlTMfscvIWIGoJyEJtnFxRvz4asyytMecU9JBtZRzTJsG8AYS7NM3ThoF9dYOI3siGmImXiIVj+khWl7W4RxeegZLXAgQAifAKaJw3S09E3I/z8/4vS+QXfSgaMCx2m3bxdgG+pbc9poCvaOFB4V4eYzQ7r9pleS7ZrpVz07PofN5HKR/tQGFL+B9n/GmL4xYpbl59/eWIEdoLWt+kITvMLzL9GU+QQcq2v3wxeQO32hIcMUOuJFloIhbGf7OLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ0bX0YLKs+KKLzFRXZfbjNrheH3ulc8zxT8N43e3OE=;
 b=QK8GqO1tDYrZSfxtXhCx+UsrS/a1KSLfYR4laUpN8VDBnOLxtTXQDyHUQuvhClM4mjXFTiL7m0bvVHIuNDpIYotoUjU9XRbq73PQwJodCeOIU0+4N8KkHoZNUZCnS2Qj7oZRuMTrIaKPZWN3JEA7VnEG8VOcitG6j/tf/gqVOwTr/lURRX3Hs5TEIcCX9u76db1FSse9uRI3zWtmqAIzq1+ZJpZMEtnsEhQPrSVoSHbsl7ZNq2CV7UDaGETkJv0VJrtMCJAbn0cGYu3r3RwUIJOXnTnhmSmlrVMaEirzyB5xvhTvZxYDCVdu6sl1uPGa2DpYrZOyNofpNhKfJp1ANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ0bX0YLKs+KKLzFRXZfbjNrheH3ulc8zxT8N43e3OE=;
 b=dQ+5Pj7W6IqPsXZnQRJjC8pbIBmseuq6qG7bRA+UdQBXbMbG521yUfa5Z0NXEqPr+B0LshMR9HaatEysqXI7bJ1MT8pnJAgovkOVgrf34sWDLtE1csPMdHd/T/lvPSloaPo+YnGI8QTko30NMh7mdPNTtFjvmWYv5XsYd6IRFXA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:11 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/35] drm/amd/display: Add user backlight level reg write
Date: Thu, 16 Apr 2020 19:40:11 -0400
Message-Id: <20200416234044.2082886-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:09 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ff55bb3-1428-45df-66a8-08d7e25fa49e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459B5B6A5DF5A06C5DCA29098D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(4744005)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSlwGh+drL5X1RsKXcWBpQBPqFDC7SGnXIeujBEP6UKvbfhPO2EhcUyWFfXy2TngdPaynNutsdb22hvHYux6R+xXiPmn8o7cwvOiSuUgjSXzEMcju4A5uEezRCdfDMNX1UUUrYsnDlhkKQ3UaA0YkqiyoU+EjQNfQy91N1L7QzI3QWpxPIwGhh2rfJnXEThjTp9mftaf5ufWgIkrmV7XmUo2Ew/bRiRMTbliVWaRIm2vveYcJswL0DNlpr85D/M7c1zngCFrzJ1UgcYKQY/2e5Ow1JVYNLoESR69FEtUgnymvly0PwYKjLTMsVYv5cePpj1bGDMybtZ8/5xNNXOdgk/x+2J9OXy6NVDd44Kcp3x1qyufT1ax6Vnk8gKvi65zt0sh4oXbENZyhUmpN4WWHvavg0obY4d3cM/W7lcmyH8RSRSfBoKgo7DFwEDYQ7Tw
X-MS-Exchange-AntiSpam-MessageData: KrGVxVtLfRiqQwaQSs9ww6opnlmEZzP0KmPYMjlxzNLRnc5btoZw31Kwbq3pft625Wlby2sVbgaIAXMkZphUhotWUMCih3M74o3AM5vJ8MpbWVwes6m04Kr+Xlb7Ect7QnlBtE3foBHPYJVsjCwcX0rP/tUNykv889U26ExmuJU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff55bb3-1428-45df-66a8-08d7e25fa49e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:11.0877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoHLdni1s6lAVF6J4YoK1J6ctVT0Pwr6mI6E6Dm2U9XQvMvFqeqQHHIwnhWbVmvt3fdF3ivIwqCk5xn4aGctjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Porting abm from dmcu to dmcub missed one register write.

[How]
Add this register write in the SetBacklightLevel sequence.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 06435ecaf6a3..59b2f0b621bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -136,6 +136,8 @@ static void dmcub_set_backlight_level(
 
 	dmub_abm_set_pipe(&dce_abm->base, otg_inst);
 
+	REG_UPDATE(BL1_PWM_USER_LEVEL, BL1_PWM_USER_LEVEL, backlight_pwm_u16_16);
+
 	if (otg_inst == 0)
 		frame_ramp = 0;
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
