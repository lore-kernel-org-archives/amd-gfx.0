Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F0C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2867D20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zwgcxgjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7466ED2E;
	Fri, 15 May 2020 18:14:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933BB6ED2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHk2fChNwifrwpGC2bNCnptA/CXTbsU2q6mKPuYLpL4jRrzZtedb9f3MVjqs5jL0bBzbvx+KB+Tm111B3vlHgT0037M25xCnKrXDGF56hHHMYxcN83ImrWqAragV6Rx/yjvsTQ0AQak0z5T42L1dLqwP2ZEIuVmzMcpfW+P76QrjX1Kzgc+bPus+g3oxGocNVtiG2OMKU9dCW9EYTfIyP955o+FBb7DfYlbAuDLd6FeFfc1Hfun/DDd6YA+ZZ99RlPdt0+8F6ULi2cy1VXGIdKGJ+CEPwx7Rdae68Bk7fMQoMw0LPKxA8JcstC7/hiGzqNL1GeYohOpkczeKsv6vnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EazozOo7LWV3BiNp9MsOC13GM5nl8FM13Fo8KYtLNIk=;
 b=ELrvPqvWFxxVYuy4wykg5IuDHeZRL/ZZJeUo0qXiG9tJ+lRlBHgUHQwSpm6WI107leHmH9Of3JAiZT+yitYeJvUtiqFrccbWxu0xjOJjT42f7rnqxIlt8Ck3O9kwsa7runc9FbqXvkfgpupO1HEgwXrNoIkBuwTpa8TEHh6kes5L+3mmI5v/YWEWaaHRsovMCUIO4QF52UVbVl6vX+cLjzFyXq+h3s9V5qqJFd+7rNkyk9kRUMnZ+v61DJumoSzLMyfybTXBnk11WoJ0arXl9oH17meQ0k9GTEWBdhFSSM2gnExHkbwm+kYG/ONnlorYSyHI3bSABzfIuu7RdstI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EazozOo7LWV3BiNp9MsOC13GM5nl8FM13Fo8KYtLNIk=;
 b=zwgcxgjWAyqLBtahDLmNTlyRk3Z30u0WR+8AvqPrTjkfZrIlFkXNYDQ4Asnb2VwDSjBPupoyAwzmsqQLWvjRrv1NYfyMlsB6KBr7GieHI11XfPXTzxuENE2m2sIa+TdmGw3D0TU2ozcJjhMPX8CzaIhoKlN8mLHSAjV4yMX+Kis=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:04 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/27] drm/amd/display: Set/Reset avmute when disable/enable
 stream
Date: Fri, 15 May 2020 14:13:13 -0400
Message-Id: <20200515181315.1237251-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:14:03 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a80efe2a-cf77-4ee8-3609-08d7f8fbc011
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974F5F92E98E26B7AE8ED7098BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFaAxbBrl+thL01b/J/kup5jPLJb619F1RpKYoRoc/z+nkqO7Pi9bjiQ32BnUmqF+oMvyWP+URxgO96KkAa9fd7pNYKzwH6IZ8iwin3W9VaxKAL9u0ojsIwo6rvXKYRyeTVxpTpMMrI36RhUmWj3DuSpAglOejVzE6lIYbydLq6OrKGesf+sF+7RBIlC4ecmS5myDMmuKByXcrFmG2NGeEZjnhJEM5cevO8YbQ37z855D68g6XBjgb0dywmSO41FCoKMDx/NoaBPNa5msZT9v8XxtnTNj9lfcwNI4sZ3vBnwHi759PjCWSBaFPDfbtBtP8Hy5ypcm57RtfSkXTude0x16VK02aYsnhRGLwAL3qgO5wH4zsL7Hdrvb7YwCvsVWCDJ+v0azJVsJf4Wwg0B36Z8xw3Bq+5McCjvpQpR33Pmr0vuQ12JxDYHwVyT6fu2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: skhFagw0OQiC65E1bm4ILN1cVrsXco5Gs72QqBmzvxvJg9oEhkB94I2/PyRa/y2U965jkzxMQtF8FlUvlzbzgKUdSL+3TX54/Q5s369ilJ4DTDXBNfheFOpF7gpAc2DGWTp7jG3XAi7Je0VdSf7kozymWmrsOpIWhLbdXnwHjj+XTRrauFGxrA671AzEdU2OSNVJ2PmguP+b0ZzJ0KVgcMHVYEo43M5bVAVbLN1GKERawwS+4fwPTksgGAGZ5HnyKohT+2eSbXFjol8sVxkaUlKKlc3XckxmqbTCYn3DVpZwkWI2CIpQGxxNU1/b8qT2lOwSHCzJX48mBxdRi+HvbzBSkkPJ7oXF2uST9jfFESGVwyeI5uybSIH0hMejbsoi9qU9k1vnpDJEOz6c1bFPIRZx7UfOiIJiHxQcdQh67DfakhGkqOHeLzm6CCjlJdDvm9g0/Iouc9Wf07qmctYZkdFxj+rie96ZCR5hJtYDTv/IZarRz8CemYHKvS/7cKFC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80efe2a-cf77-4ee8-3609-08d7f8fbc011
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:14:04.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csI9HIOuhOm2QpZZNoJ+WDvdIBv/GgRwzEUlpvmQu7EBT987lafhRoBrn3VawExY4M3rtQeSamwYRVPxzRyjNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Jinze Xu <jinze.xu@amd.com>,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jinze Xu <jinze.xu@amd.com>

[Why]
When disconnect fe from be, something such as unstable clock may cause
garbage occurs.

[How]
Send set avmute at the beginning of disable stream and send reset avmute
at the end of enable stream.

Signed-off-by: Jinze Xu <jinze.xu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index e920d046f026..d80b2de3ee82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3244,6 +3244,10 @@ void core_link_enable_stream(
 			dp_set_dsc_enable(pipe_ctx, true);
 
 	}
+
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		core_link_set_avmute(pipe_ctx, false);
+	}
 }
 
 void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
@@ -3256,6 +3260,10 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		core_link_set_avmute(pipe_ctx, true);
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
 #endif
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
