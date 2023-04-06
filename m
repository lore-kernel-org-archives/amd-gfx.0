Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F8CC77B6C
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Apr 2023 12:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6351C10E345;
	Sat,  8 Apr 2023 12:39:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285B810E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680811105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LRqwdTQMWkbHJObb62Qyqd5cmfrq+lMBU33zKFDK0cA=;
 b=VO96n2bGTU/YzYB71Qq2wcqF9UiUzCyzJzq3yw665XitJdXIJRtgBN+Ho9g362N27HnLEt
 w6779i7hzBpaU68AwjeQ2D5oh/Z8n3K3WqFxB/gorBRgol/xahG2vnanSAvcDMlhYG0P9v
 UVJ8mGD74PKQ1qxTbQkLkyNxvqaGo6c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616---yPPjIKM0aDa4owaBhfaw-1; Thu, 06 Apr 2023 15:58:22 -0400
X-MC-Unique: --yPPjIKM0aDa4owaBhfaw-1
Received: by mail-qk1-f198.google.com with SMTP id
 187-20020a3707c4000000b007468d9a30faso18262498qkh.23
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680811101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRqwdTQMWkbHJObb62Qyqd5cmfrq+lMBU33zKFDK0cA=;
 b=zFBB2alWs6P9EhtDhCnATmli7DVD5qtAtOSGBZot6jZRJ3m1rJ3PHFF2IgypRDzLZ/
 Tek21/3ShNHSFgkRz53JqlE5V7V/a9QAcLDLHV75BgJRmZtTbILmf4k99g0bX+cWZyJM
 7vzvzYoKMKKGjVJYbMkstecdAukl0+H1IUYw4ZqVPQbpQl2UOaCFPAdPMlTOHfZ9yAaD
 fTpEzBqDkm4GTNRPsfTp3wpK+S6Alu2QKiREzce9pRVYF6BbBE0G1nwWddCaBoUvCCdy
 T6hXAreiVOTPBT2yw518sjKQ6uRkNIHTKtLvL4xMQ6zZy6vJUaFsjSqbEuZSUkfrjahl
 6qww==
X-Gm-Message-State: AAQBX9d41yOLqqy4NrAXtWvg7O8em8yyZPp4Ua/G0oU49PibirRgjY1A
 y8/sg08ZXktO+z9a+XeAEGO3yy/TZ8toQ9aN2trE0umRT7BASJPVZdsDMRm85I7lSNRPqmC1P3p
 zxjmOyYCyX2YkLMie0vRhnJnO0Q==
X-Received: by 2002:a05:6214:d88:b0:56f:52ba:ccf7 with SMTP id
 e8-20020a0562140d8800b0056f52baccf7mr731004qve.14.1680811101488; 
 Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zp+eBXfawoiv3Bq3fAJCCQ9Lkm2x6dWbrn6iRjoMte3WoDewQoxo6DwdNhkhrR4LeP5Aop1w==
X-Received: by 2002:a05:6214:d88:b0:56f:52ba:ccf7 with SMTP id
 e8-20020a0562140d8800b0056f52baccf7mr730984qve.14.1680811101252; 
 Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 mk21-20020a056214581500b005dd8b9345f0sm733097qvb.136.2023.04.06.12.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Apr 2023 12:58:20 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Brian.Chang@amd.com,
 Martin.Leung@amd.com, David.Galiffi@amd.com, Ethan.Wellenreiter@amd.com,
 martin.tsai@amd.com, tales.aparecida@gmail.com
Subject: [PATCH] drm/amd/display: set variables aperture_default_system and
 context0_default_system storage-class-specifier to static
Date: Thu,  6 Apr 2023 15:58:18 -0400
Message-Id: <20230406195818.1958162-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:758:10: warning: symbol
  'aperture_default_system' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:759:10: warning: symbol
  'context0_default_system' was not declared. Should it be static?

These variables are only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index a142a00bc432..bf399819ca80 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -755,8 +755,8 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
 	return false;
 }
 
-uint32_t aperture_default_system = 1;
-uint32_t context0_default_system; /* = 0;*/
+static uint32_t aperture_default_system = 1;
+static uint32_t context0_default_system; /* = 0;*/
 
 static void hubp1_set_vm_system_aperture_settings(struct hubp *hubp,
 		struct vm_system_aperture_param *apt)
-- 
2.27.0

