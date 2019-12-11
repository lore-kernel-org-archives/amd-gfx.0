Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2434C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82A82077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ArazrNRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82A82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBE36EB72;
	Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D246EB94
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnEFRtgY95cc9RJK3DS9NdjKDPilncRJ1JwiwZ2KsZ8ntVQSn61y2fPux5yqvobOPV8daubEv5WS50/8wa5DMKHHPK2HkJQMBqwECchdRSkZzEgz1zpZgcvR3QR5j41e4iwnes47VSynEKyVsxNtMK3RtxnPbSPaWom88vePTdxx7VTZFg17apVp6l02IkXAONV6BGvxPAGjxSW9VfeeTigxGtWyb53p4mYSh2K0bwvU1EwBblKDer6Pi71oRtAlw4O8oRcEQUGS3rigrMv55Oj/fmKFZYvriBTQ9HR0AqvK/jC5u+QO5cqJgMJ8sWDh8GVM+uIt8Lnz2TyJ98upDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd2cKdCkwpaPrlLBdBeEYpOstVB4Tbjn0+b5gcmFiWw=;
 b=XMRkErrHhCPfMeEKz6tfqgjtdMqifx6k5W5TlEa1h/tF0Ev1geqIrELhrrNV13W3NZmwUtS7+FBVJwt4hBg36DQp70FzW1YZUCcWATurzxDuzZUBcY/WG5sXpAkT3Uzs8Ju5OzOEBeRBZyOdrLm0HdHr9D6IRKgxFwB/DI8ObU8DmR6I2mt8RqzWutmeJTMD3DDM7ATZ/xjVIGYbY3qB/gkcKo4m1dMv3aIrKuSVcv5U+PL3CSzUGJU3PPWEaOr3Dsmd6Ue8AYZSLn+CpC4LpMcYxAxkMLpn+Cd+pbkuMzsYLyoGwhK4vKk2XebAZxe1CCrYvkzU6M7ufED11ZswXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd2cKdCkwpaPrlLBdBeEYpOstVB4Tbjn0+b5gcmFiWw=;
 b=ArazrNRQmhgXXvhufVVBYriyiJXhFvaVc6PkF8NJ+JUzVEbGQNAYMeICgvYjxqZEGsePLZSVggDLlcOOYpZZzgTEsCw0paInbsIvhZcfea3xdJg6lCs06gkfMi201LRIVtR1i1DUkadDTEioLf5nzKEvs47q+YZjf2KolstRQs8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:15 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/39] drm/amd/display: Fix manual trigger source for DCN2
Date: Wed, 11 Dec 2019 10:32:47 -0500
Message-Id: <20191211153253.2291112-34-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cea4fa6d-3abc-46ba-8a8c-08d77e4f82c9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24919AF284B32FD16B37F592985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
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
X-Microsoft-Antispam-Message-Info: MsjCevSwLsD34+vZmvTsrwfAr86tLhbIlIyhwLgiUN7lBPj29y7vC/FeQmJSiCKM1IcFBKEl6UJ+JOY2zomAAgr2sr2McioiVqB9IUDIhniwyGErp06Q6wwzXnLmSIyyiqPiQHvCQN/pXp8nGe7oBw7ieFnclUMI9WZWa5FdJoYOif8xJuAjt7d1ZtPyOAUvxd5hKB4m5y6qLs0UiRsQru+2VsoO1TKgWAErWHNRtVai15CNV567sKkArcNSU/hy+rtIylys+PeWdNZ27jjBfvgiFlUTGbU9YqfXoqn7bPNoYAmYvmDNvZcrFaloHW5qOFu06tA/Ur6lqk62kc4XaYjpNan3phVN7byqXpUq+i5muYju6mZLCdnMc5/MlT2ta6wi1xVnAw9FCHpZcuzMk/exP+TbNtlNcObuNZ0wusGYj5wn44auqCp3hzWD4YZL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea4fa6d-3abc-46ba-8a8c-08d77e4f82c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:45.9725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRjcslVPTDH5m1QaUTMZal5pNTJsVYGOanAuyNqrEy9yfrHI6wTemxWPAWaoMA3xVl3JARSG5TOiVEeopZMMNw==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Fix manual trigger source correctly be TRIGA for DCN2
rather than MANUAL_FLOW.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 8 +-------
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 9b36fec549d7..d875b0c38fde 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -390,14 +390,8 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	REG_SET(OTG_MANUAL_FLOW_CONTROL, 0,
-			MANUAL_FLOW_CONTROL, 1);
-
-	REG_SET(OTG_GLOBAL_CONTROL2, 0,
-			MANUAL_FLOW_CONTROL_SEL, optc->inst);
-
 	REG_SET_8(OTG_TRIGA_CNTL, 0,
-			OTG_TRIGA_SOURCE_SELECT, 22,
+			OTG_TRIGA_SOURCE_SELECT, 21,
 			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
 			OTG_TRIGA_RISING_EDGE_DETECT_CNTL, 1,
 			OTG_TRIGA_FALLING_EDGE_DETECT_CNTL, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
index ac93fbfaee03..239cc40ae474 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
@@ -106,6 +106,7 @@ void optc2_triplebuffer_lock(struct timing_generator *optc);
 void optc2_triplebuffer_unlock(struct timing_generator *optc);
 void optc2_lock_doublebuffer_disable(struct timing_generator *optc);
 void optc2_lock_doublebuffer_enable(struct timing_generator *optc);
+void optc2_setup_manual_trigger(struct timing_generator *optc);
 void optc2_program_manual_trigger(struct timing_generator *optc);
 bool optc2_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
 #endif /* __DC_OPTC_DCN20_H__ */
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
