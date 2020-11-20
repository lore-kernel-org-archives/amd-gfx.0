Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1FDC63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87D022D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W3JABc/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87D022D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219E56E91A;
	Fri, 20 Nov 2020 20:20:44 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B79D6E938
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv+QtVQEURDZYlCjA7DMQT/GU66nOykiUEHCVNOQcKnKdzbdvq0o3NLXYTV0HI/NKdSz109p6A+QCMsxBNdqUVo7C77Ea0wi9ghK2WKR4sWthTz3gYuSBP4+Zc3VeZEEgXGXZqu76Vt118Yxkl2SjfT+Dk1fxfiInRrDJmUw5iNJaCYzgQhWD2YGLiOxaWwZVwPPDb9bh7pCo8QcfMV2hFJlJJQjVy6xMHEpjC6RnDu9d+fTLoyr78CJIMe8/FjTIk6oBhtygMciZUeUqW6eeOuTcq6tkrfrSKOO5J4N+WRxL/klz0TmK9EGkDtZo+5WrkKuhrWsp912NHbaQY9fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSlQF31ItePy2raORYHBN4FBHbnFcMrlm7vahsun+ls=;
 b=gEUEAGy2Q6yFkEbpVBf55dTyeorh5kX7HzdBfCDwuONbbKLaXgmLqpkdvCSgxl4oWhYZTv9AR55d02bZ8BzuRh7RTSjFrLP/l3SjyVJLjaUDew/dfnkrznIT3YiW8vTh1sTY/iC3RqWaWT4xFCWDM0tTsIRLtaD/Lu6tAYIFqGb4mWjmRUkRy0YKlUF9n93oVy8FKVG36MyrYiBTHy8i2lcKnNteR+WE/QgcqvG6mjM6GFDLjf7LpRSne+1AEGSEb0n335yPkk5gc9SRlBQk1TB0IOgMZ1i+p3qFcxU1QQ3qxLD0aYr+zEOnCo7+hptoTV/EhQ5gBjU8wP5JvsPL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSlQF31ItePy2raORYHBN4FBHbnFcMrlm7vahsun+ls=;
 b=W3JABc/t4VBKDALijS6/v6O2T4TovsPOmFU/y4pxH1lUVmcb+QRVBzqbf/keEhBH5PcHdLMcQlJSpGOIMktEQpQ3eWkiIV8tUX6/KxCh//BOnfIEqudEeyLs7zF/7yya2iZLVs/VIj1lzQl7UdaIwK8CE9nX/CA0ISdv3XN0UgY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:34 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/18] drm/amd/display: To update backlight restore mechanism
Date: Fri, 20 Nov 2020 15:19:57 -0500
Message-Id: <20201120201958.2455002-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7267a1f-b59a-42f6-6b02-08d88d91bc7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3717CDC237F759853F7806A498FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAVo8OT4V65Dpkwa+HPMfpioM/nmOMZTEbgmmv2MPOAySMwPmpfacL3L2F4hr7Nm0aBN+5xYPWeab9WV3lbJKaoPtjlPpSuHqC1O9P8J3OuxoXWEqG0FiZ7pCKuLp1Y8EK0GcF6PVaJVqgh4Cdx0x6SpBzDh3B2dCiDyxdyIpXam2PZjvvixP2lBeSD4lHZcVWX/jquyfOKPqH/zgP6HhVQstQtpgrXtFj2INZmypQRKX5DMkEbr/Ml7vaSvmfPBAc7YKEEoV/PzZD4asac3E4M3JglL3fvAUsr9+kwuD+RuCucrMdHU/BR5gFyO71NATWvHUouNIB9pldq7K7OHjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(15650500001)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OEl0m8V7FrULqxJhPOaMJqZkqc2h47OewdiPhT4wZMElszsR8fWGd7yXwoJune8H3U2jiL5Kv7cjpQ1GAIeIvaOBRK1y1hXuC5AEnl87+vHLY8dCCAyqgPDA5xh+725hjL0RFV3R3I+Qu5v82ZN+Nkc74sY+bN1dXSbMFOzNk+HPEJ396htIoFnFzysqJwYnefrGEYI3+xEyP+On2BsTTy7iAqkT/TAukz2xlPaC/XzL2CiG6zSZBqSbXpiiJftAqPapDEpyzVFQmPthsXRJqTn51++wl4SEtsrBDH5CrdB6h0O+fsJ76KbHawS61SyTyVZeTpessi1B/KpFHIGCxG4eH4iHhu3s2TDWhpsfwGARv7kR7zL4eq8asAoeaWirCL+BkT3XrVzXk37coVR5Y12lH8P9ZEgy8Iu0OyrlL+5gEfXEKuRraXBr+sLucV3B7SEAK4JKmAQnA38Hn4Oxv9V1gUo8Su1WUTW+W02aNdGfeTcwtiEMOJIzIu/Ra9BX4s9AoJXUBGOR8lpYcWHLIeJjb/uudAPVZ3MaiYf4lWcAcCOOmfZaXhHVKfecpw2ETGgopVHSAd3XiHmUvDoEuuaq6+5eRMhCwtL8vzl4sIl7Qvc5GHmS7330PsBLX3UbqamigxXRmNdMfc4r/u1+NVtwXQwUj85NWE5CD1VqT68JA1xbgAwATv2zFQZBk2ElHwy21djlVVVh5n5oPtYCPtun/ihMhisO+eJc/ae3SiSvnnU66psK/+vt+cqcZekhUhbV0mXOUCXj+IaS4lLlF/6MqqWyRW/I8RmiD10lxKrVIfW/gBpmrgImiXgDB0xl1mzsuaDES++eISP6Utt4WC4+z9KccfTbqY+nbucVyI9fL4YDBYb7waeMQ6gYiZNqcqlpeaJqmmiXRdXlTJ6cM38Is30xNfxVpraBQzeKhNonC/hbl+0RbpCMafyIOf2D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7267a1f-b59a-42f6-6b02-08d88d91bc7e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:34.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ7fdlvvAVMmZUB446XJ+Vkdxa5aGOyusKZuH+ZeMtjmuYDDDk45XNSKQNyi1Wv7LiwIMKV75IuJ4sFSGMtKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Camille Cho <Camille.Cho@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Camille Cho <Camille.Cho@amd.com>

[Why]
Cached backlight is never being updated since panel_cntl specific
registers were moved from abm to panel_cntl.

[How]
Update cached backlight in set_abm_immediate_disable as what we used to
do. Also, update the priority of backlight restore mechanism so that
cached backlight has the highest priority since it is always correct.

Signed-off-by: Camille Cho <Camille.Cho@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 36 +++++++++----------
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  4 ++-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index 74f7619d4154..761fdfc1f5bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -108,25 +108,17 @@ static uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	 */
 	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &value);
 
-	if (value == 0 || value == 1) {
-		if (panel_cntl->stored_backlight_registers.BL_PWM_CNTL != 0) {
-			REG_WRITE(BL_PWM_CNTL,
-					panel_cntl->stored_backlight_registers.BL_PWM_CNTL);
-			REG_WRITE(BL_PWM_CNTL2,
-					panel_cntl->stored_backlight_registers.BL_PWM_CNTL2);
-			REG_WRITE(BL_PWM_PERIOD_CNTL,
-					panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
-			REG_UPDATE(PWRSEQ_REF_DIV,
-				BL_PWM_REF_DIV,
-				panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
-		} else {
-			/* TODO: Note: This should not really happen since VBIOS
-			 * should have initialized PWM registers on boot.
-			 */
-			REG_WRITE(BL_PWM_CNTL, 0xC000FA00);
-			REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
-		}
-	} else {
+	if (panel_cntl->stored_backlight_registers.BL_PWM_CNTL != 0) {
+		REG_WRITE(BL_PWM_CNTL,
+				panel_cntl->stored_backlight_registers.BL_PWM_CNTL);
+		REG_WRITE(BL_PWM_CNTL2,
+				panel_cntl->stored_backlight_registers.BL_PWM_CNTL2);
+		REG_WRITE(BL_PWM_PERIOD_CNTL,
+				panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
+		REG_UPDATE(PWRSEQ_REF_DIV,
+			BL_PWM_REF_DIV,
+			panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+	} else if ((value != 0) && (value != 1)) {
 		panel_cntl->stored_backlight_registers.BL_PWM_CNTL =
 				REG_READ(BL_PWM_CNTL);
 		panel_cntl->stored_backlight_registers.BL_PWM_CNTL2 =
@@ -136,6 +128,12 @@ static uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 
 		REG_GET(PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
 				&panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+	} else {
+		/* TODO: Note: This should not really happen since VBIOS
+		 * should have initialized PWM registers on boot.
+		 */
+		REG_WRITE(BL_PWM_CNTL, 0x8000FA00);
+		REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
 	}
 
 	// Have driver take backlight control
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 1fa193078803..96ee0b82f458 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -171,9 +171,11 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl)
+	if (abm && panel_cntl) {
 		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
 				panel_cntl->inst);
+		panel_cntl->funcs->store_backlight_level(panel_cntl);
+	}
 }
 
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
