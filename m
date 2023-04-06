Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0C7C7619A
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Apr 2023 12:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B25810E342;
	Sat,  8 Apr 2023 12:39:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C2110E06D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680806684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LOzVIpJJM6v7k5No2ia8gTr6fhScQxv4U9oi5fa7u4c=;
 b=ToWgKrAL7WvZBCuvVwZ2XZmaVM7vkkx7si4tS+gQR9R/fafMq0ye38lXmTcPddG9seMwe+
 CoClHHSSgqJE/4EULmMmlZ/1PSyxfdNMlpHSg8hW77Ask1EyRS+j2CYBhk2dMRIv+IYTnv
 8sR2G9feByQUNelHlknPsNH8Sn09dSA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-vhPznP13OfeLAfkiwQ2WSw-1; Thu, 06 Apr 2023 14:44:41 -0400
X-MC-Unique: vhPznP13OfeLAfkiwQ2WSw-1
Received: by mail-qk1-f199.google.com with SMTP id
 r127-20020a374485000000b0074a6b927a49so2457496qka.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 11:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680806680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOzVIpJJM6v7k5No2ia8gTr6fhScQxv4U9oi5fa7u4c=;
 b=FX+zXiM5BFL9ttfFNu9/AOZDl67GwNr2h0aavhVAZRcoW4SI1PTKtIOZyPzAHxebYr
 oM43fjVeb/fmx2UPFkIWDR/GqQKsUHSSiDXd7E93eK0dL+kUd1EPmukvIxhSAPVsYbB9
 n9DZkyU2SeYpucfA7YCRvsTUFdBrVs/HdU6Qow9UljA7BUbc3R+D6qdhO/GXeiZE/mHT
 3S2HiFCARUCfVROnFdxmik1wxgyXlFK6gOijcYrIBiyWJjUE2Igyw9azW2xFpWZZnpRZ
 /ZjqYKoHcyVBT9taNmj1QfdJofsjV4X/FZyg42iOgU3FcopB4HVnJfvDP8oKQKwuD3pg
 nBQw==
X-Gm-Message-State: AAQBX9ecCy5orkUvdpKhBp2/Q03LA9VmLconmqKfPzfy8Xa3S/UddEAh
 dnZ2zWbaq02Rjx/ZjgXTfS+1V4/rVGCf4TCDJu83dF7GlRsBYxnCfuz5wv4Ne9WgS+zpDc1gL2T
 v1ULItPUmE0nDRyTAuFJMukOmsw==
X-Received: by 2002:a05:6214:21ea:b0:5e6:8e03:994e with SMTP id
 p10-20020a05621421ea00b005e68e03994emr271467qvj.38.1680806680528; 
 Thu, 06 Apr 2023 11:44:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2esvOM7SNf3mflCNYsRvsqb30rSrGo0KeUq5T2D+bFM8buWpXaMGtXaXNEy28BM83L3uLMQ==
X-Received: by 2002:a05:6214:21ea:b0:5e6:8e03:994e with SMTP id
 p10-20020a05621421ea00b005e68e03994emr271427qvj.38.1680806680099; 
 Thu, 06 Apr 2023 11:44:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 lb30-20020a056214319e00b005dd8b93458esm708436qvb.38.2023.04.06.11.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Apr 2023 11:44:39 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
 Jun.Lei@amd.com, Pavle.Kotarac@amd.com, chiahsuan.chung@amd.com,
 duncan.ma@amd.com, Charlene.Liu@amd.com, muansari@amd.com
Subject: [PATCH] drm/amd/display: set variable dcn3_14_soc
 storage-class-specifier to static
Date: Thu,  6 Apr 2023 14:44:34 -0400
Message-Id: <20230406184434.1956813-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 08 Apr 2023 12:39:00 +0000
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/dcn314_fpu.c:100:37: warning: symbol
  'dcn3_14_soc' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index c52b76610bd2..44082f65de1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -97,7 +97,7 @@ struct _vcs_dpi_ip_params_st dcn3_14_ip = {
 	.dcc_supported = true,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 		/*TODO: correct dispclk/dppclk voltage level determination*/
 	.clock_limits = {
 		{
-- 
2.27.0

