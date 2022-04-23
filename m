Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E490C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8B510E5A7;
	Mon, 25 Apr 2022 07:33:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C910D10E174
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650744126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TmI4HuYyRoxvHL+vw/EIwCgtYuWPzs344Ybx3U2pVv8=;
 b=OyieoyHuQbjMyCFGG4UwDwj/f391pV/30PgVAF2pFiUdon+CZPrpc+eNYQ51lVK12qqEuT
 WSjBT8MW6wxLgHQe09rKzPwBW/HbhZWJpI4X/P0LZ2T+Lbdq5OJRNvkCC7+agu26FcGL9V
 go45nFA1sLCkEZBCWUl3o1Cwa1sHcCo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-G63JjZ9WN_6jJmjPtGn2Jg-1; Sat, 23 Apr 2022 16:02:02 -0400
X-MC-Unique: G63JjZ9WN_6jJmjPtGn2Jg-1
Received: by mail-qv1-f71.google.com with SMTP id
 k10-20020ad45bea000000b0044c3ec9f75cso7126569qvc.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TmI4HuYyRoxvHL+vw/EIwCgtYuWPzs344Ybx3U2pVv8=;
 b=mLdAzRDQBzQ8Gb5TVkfImyOQpA9pUn7cvJAxf5u+C+qStiByGRsDYcEV6re2UMM44R
 ZulLwGrebXI+FHEiWHyThG3MLmJzrv+MsaWKO6bp4RbVsS9qe7dhKAbqA6JDc7hho6ij
 FClRxpnWXAsLDChbidnHtyYyxMvkrppP6Fvl7iNZyu2OfCyZ0uY2So58bwu5iTlqN0AU
 buJ3Q5eDxW85WqWOV5AItat+sGVDfmFioVScem+rCD1PvwMZrn0kA073n2jk6vSPAqMG
 AYKSxNoxmEChWjMDWGKpo3mY6uyMJA//XLntfbDVKEDk3Q8P6Fh64alfBVqTen2mzAwK
 c9Ow==
X-Gm-Message-State: AOAM532leh1POg7+QYYpfc6wJDrgO5aNWDfZFJ2nR3+52InrEFPMTkPw
 p90cZXXcw10uVkaYQbky1cALGNJiSXIDIXY5Zxn+1IvYBEL4V9jNXk6WoqjldVc5Nz7jBVAGYnS
 4XIsjtyj8nOXbj9sAOT4uMRUk7Q==
X-Received: by 2002:a05:622a:1b91:b0:2f3:45f0:d9fb with SMTP id
 bp17-20020a05622a1b9100b002f345f0d9fbmr7608099qtb.147.1650744122294; 
 Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmfh+uSxEWKmvVX8l/LATjWvc9VwFZNJueNhicXlKtCgy74l29do1f86Ksx39bNBVQ+S9p3w==
X-Received: by 2002:a05:622a:1b91:b0:2f3:45f0:d9fb with SMTP id
 bp17-20020a05622a1b9100b002f345f0d9fbmr7608083qtb.147.1650744122071; 
 Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 e26-20020ac84b5a000000b002f35d11c5dfsm2348748qts.65.2022.04.23.13.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Apr 2022 13:02:01 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: change cac_weights_* to static
Date: Sat, 23 Apr 2022 16:01:55 -0400
Message-Id: <20220423200155.1735336-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sparse reports these issues
si_dpm.c:332:26: warning: symbol 'cac_weights_pitcairn' was not declared. Should it be static?
si_dpm.c:1088:26: warning: symbol 'cac_weights_oland' was not declared. Should it be static?

Both of these variables are only used in si_dpm.c.  Single file variables
should be static, so change their storage-class specifiers to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 3add39c1a689..fbf968e3f6d7 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -329,7 +329,7 @@ static const struct si_dte_data dte_data_malta =
 	true
 };
 
-struct si_cac_config_reg cac_weights_pitcairn[] =
+static struct si_cac_config_reg cac_weights_pitcairn[] =
 {
 	{ 0x0, 0x0000ffff, 0, 0x8a, SISLANDS_CACCONFIG_CGIND },
 	{ 0x0, 0xffff0000, 16, 0x0, SISLANDS_CACCONFIG_CGIND },
@@ -1085,7 +1085,7 @@ static const struct si_dte_data dte_data_venus_pro =
 	true
 };
 
-struct si_cac_config_reg cac_weights_oland[] =
+static struct si_cac_config_reg cac_weights_oland[] =
 {
 	{ 0x0, 0x0000ffff, 0, 0x82, SISLANDS_CACCONFIG_CGIND },
 	{ 0x0, 0xffff0000, 16, 0x4F, SISLANDS_CACCONFIG_CGIND },
-- 
2.27.0

