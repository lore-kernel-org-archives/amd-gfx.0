Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736CC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5ABF225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWiqc/n8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABF225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFF86E85D;
	Tue, 14 Jul 2020 18:24:51 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D443E6E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:50 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id 6so13610987qtt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2K/3BkmpXcKqXrMj2itulIWQo6fWKNnwqG6/Dtcivi4=;
 b=EWiqc/n8KFFWADH2rbICFKTX5XDD1Hdw5hWNcNkbwZwqTwCKfAGMPRvzZbqKUXNSU3
 uBX7Tf81kHnnDUIMoOwa1wPV4LsiwHkcjMtZJmlAp+kiZHbLF60gJDcmOGmk+wC9qol/
 K/G3z8O4R41d/6+vZKSzbJJ+KpcqQa+D87vW2Tmeyloo8kS4HpZpulNNKmA24CswHA96
 TTrBMYKJlVq05eqg2jdOvMe0QBLXIuACAQ5nnes2gtbYpvn5gxN67jaB7EuhOn8sdu8j
 Snnm7ZUG+RTXSXJJF7Pk5CJ3ADgWq8H/J03dsvfZjZ0+B8tkAxYQP5qeff480w18p2/E
 rt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2K/3BkmpXcKqXrMj2itulIWQo6fWKNnwqG6/Dtcivi4=;
 b=H+Hy3qhXh6i+RqlRAvM1U4VZYczUllVfXbxfuSLOG957DNI6WzZDLbgdlSkrZI+UFg
 TAIbjeN/vOoh511WxhO7jXqdYl6EbIxgZR46nTeU9+rTysdLXYGD00CpfnAZ5Eyuvgjr
 +qADbY2NHRZgMmw8SXcNaA2wuOEVrdIzSyNS+0btUuXgl3Hen4HupEOrbmKkkAtEm+Fp
 reTkzA9EXcIWtSZp/wM6F/FZYvQqNbEv/CFgvXJxitBfAc5SnPNJYx4+zOnFqYiAqqr4
 oEOrMT9WyJOQV2Xm/vt86VOr1uv0qMbyaet95o/ULp+BKi3mZenakHBHZX7bQr26Ftd3
 Y6cA==
X-Gm-Message-State: AOAM532OCqF4MKQIsVBQLy9+Wl5RsvNRYk1KsJgB1Cx9T2i45I1wR9gR
 Y91OzRSJ/uGDG9i9Aiv5XP02oyhF
X-Google-Smtp-Source: ABdhPJxjkn8oxFSYOqiRiG8P7a+Qf2/+rBUrMoPtyl9rO6qT+4PGtegjueZjs7yk+kyk93qToMF6ug==
X-Received: by 2002:ac8:7959:: with SMTP id r25mr5791108qtt.85.1594751089860; 
 Tue, 14 Jul 2020 11:24:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/42] drm/amdgpu: enable cp_fw_write_wait for navy_flounder
Date: Tue, 14 Jul 2020 14:23:42 -0400
Message-Id: <20200714182353.2164930-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

It's the same with sienna_cichlid, cp fw for navy_flounder
can support WAIT_REG_MEM packet.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ad9b5969c3b6..3f189348cee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3538,6 +3538,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 			adev->gfx.cp_fw_write_wait = true;
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		adev->gfx.cp_fw_write_wait = true;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
