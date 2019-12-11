Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89604C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594052077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dr9ARssv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594052077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231D56EB96;
	Wed, 11 Dec 2019 15:34:24 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CAF6EB91
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDPOi3Jo13HBxVY41i9E/X5SS/ZfRiODFa1QGSw65lZCqOqYwXTkSVSbR0Uv4z+wC9kuLu2OCPcecYrPvkmdnEvDw/+FS8DG4hakFw12ol04bixjx9eBiB6DcKNlb+y87Hgh85BREUrXPiNPywRBrXsMEFeLUmcBR/fOq1dUkugAkTgzFH1clywf7A80dpUo5PriWGuJ6iohZS8PUsipkRmL+HZTxMhlMvzFdR1LC2eeueRfA35yZGG3LyYKEI8ojv0ahoO14jgZr7+X5x4VMdvea/lBYpvisEdAXpozGAvDcUPV686J6yQ7pPbQHTSKVhs6X/zgUSA9+t5WmZLtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U8NUtkkqf8tP8fWTTYexvb2ISeaPM4CoRIByRuM/z0=;
 b=OgKc2h2RVh9WDeLgXqAZfk2i2C8Qqe0x+tJg5x5iec16cCk8pcMFZTHpOl+IZsR4VIKSnWaScXXqyr9EAqZFuLpBnXrTVAN6AjXn/jt4uFBlsgmEyvjVdPGaEFezy1cJCHM9XUiLnUP5DgX0tTyx4MeaQDCM/+yexAklfkqVEYtnz7qy8noWHRcfTTrBJ99oNWvMOK1P7fKraQXJwBmcaDkCC4TOf9PcBaIkML/B9Z/1Y+B1pFMUdf7SiJpzCzOfGm/1xRis6Fh7nj6EDHsK/WFdnysTqlP0P9AJcqRYm+85MVsMDF3HyeniHBVVpGLJ7G+GiqPDh3XD8jFP7AMjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U8NUtkkqf8tP8fWTTYexvb2ISeaPM4CoRIByRuM/z0=;
 b=Dr9ARssvYVXpth8OuJjOuncqyZTUorUVZyIZkydGRnhI7qrju7yTsBF/81BSmGczzqrdhg4fJndWJPZsv03NDKp6c+nb7dfsZwBHD7Ih5jHYrfXhF1F8JGGra+/wLlmWGu2pSZAgl5otkjI/N4u8Wp0TnivEQExFaVIoQ2nPsIQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:17 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/39] drm/amd/display: Formula refactor for calculating DPP
 CLK DTO
Date: Wed, 11 Dec 2019 10:32:50 -0500
Message-Id: <20191211153253.2291112-37-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bae9d27-a7a9-4036-e2fe-08d77e4f8467
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491E7166ED6CF3A13E8FDB5985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDgOrpaSmwIqEsAkhsIoz31bkOrjzk7MwTbvzZRWgbIoSkvWy3P924oCUWUmN8a+Ddq2p0OHGLBYJn6znsV/Wq6hehFJlymzW9yFEpJFS80WhTauET6IA17wKoRYrRcPFFSy/BLugKgGGnjKEMAMr8x4oHRPi7/p0/piW20stNGTAC9E+YmtTB0wiqKPS87CKSTa4SMs3y5eobNI+ckoV+K9XoVGHPRW0THW/ZdM6i+4dO8Uy2JyVIYJ6I8FyPYP8h1vdlb24qTBdobo+xerNH/Tt8Cl3B4FYAsE4ren0rrDUSF4ThBL165L5Xfd2zLlEqNRQqMew/Mdaidv4IN8Fa+K3xFclFUizowlw//POUdRYYxs3PP5hjzsiGcFwQi922ZvvB8dHv3DDgest/hEE4I2cIH7OHD6x8NTEzsRvGWVu6OIBrInntaeLIQOCaoG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bae9d27-a7a9-4036-e2fe-08d77e4f8467
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:48.6900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TwiYXHVVtxCXR7MHZd1NwXuGpRU80771pGGttMLrzZxNvbvDimoFgZ8Xja7GCyhOaCGz0ebrZzNe8h+3CcsCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
Previous formula for calculating DPP CLK DTO was
hard to understand.

[How]
Replace with easier to understand formula that produces
same results.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
index 1e1151356e60..50bffbfdd394 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
@@ -50,20 +50,20 @@ void dccg2_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 
 	if (dccg->ref_dppclk && req_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
+		int modulo, phase;
 
-		ASSERT(req_dppclk <= ref_dppclk);
-		/* need to clamp to 8 bits */
-		if (ref_dppclk > 0xff) {
-			int divider = (ref_dppclk + 0xfe) / 0xff;
+		// phase / modulo = dpp pipe clk / dpp global clk
+		modulo = 0xff;   // use FF at the end
+		phase = ((modulo * req_dppclk) + ref_dppclk - 1) / ref_dppclk;
 
-			ref_dppclk /= divider;
-			req_dppclk = (req_dppclk + divider - 1) / divider;
-			if (req_dppclk > ref_dppclk)
-				req_dppclk = ref_dppclk;
+		if (phase > 0xff) {
+			ASSERT(false);
+			phase = 0xff;
 		}
+
 		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-				DPPCLK0_DTO_PHASE, req_dppclk,
-				DPPCLK0_DTO_MODULO, ref_dppclk);
+				DPPCLK0_DTO_PHASE, phase,
+				DPPCLK0_DTO_MODULO, modulo);
 		REG_UPDATE(DPPCLK_DTO_CTRL,
 				DPPCLK_DTO_ENABLE[dpp_inst], 1);
 	} else {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
