Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B70C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 12:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04DA113D94;
	Mon, 27 Jun 2022 12:51:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD0610F72B
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656254789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5EXh2xkTs1zBkhfCl8CTHqf9DxClLVCKfcSwd9L8zzg=;
 b=PS9HfYGZyH9LNQ7CyYhQq9TjtRh9G9t3eGXI7nxEbTPoFiTXyPbIaCZHI0wbeFZaQOVymd
 vOEIWHfrEu2oNqMSBJjQ91YzPi2mF8v7RXeZhax5J2gshxXzJw0DkX8bcRxpkeuy2JxvY6
 6QuL6/uLGPyD80kVsU+bjcnaIPvbrRc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-Q3-R8B_SO9KiXwcS_JEYyg-1; Sun, 26 Jun 2022 10:46:20 -0400
X-MC-Unique: Q3-R8B_SO9KiXwcS_JEYyg-1
Received: by mail-qv1-f70.google.com with SMTP id
 10-20020a0562140cca00b004702e8ce21bso7130783qvx.22
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5EXh2xkTs1zBkhfCl8CTHqf9DxClLVCKfcSwd9L8zzg=;
 b=7IpRzXaMu/5zPBh4Jc1XRDM07brgmxVc18gEUcUCMrpGiGBdjZQW+DbMTw4XpW1zrX
 mErD1n3BZxkuykOFrGJEXE8POtGcqhbovGSca1bTJXsKxAtCQXsWL33CHwY0VmeU0dDH
 hrAz17PenSRh1PVLGDky8WpIlrZ7VdT8AwfuyP8LohHEFdIUWFCMoEuzJASUVBB6M7tY
 MFmeSTSkbyZmxc3C6r0qo02heu6kbNVvip8KVqC22m13P8dDmmIw4x6LpAUsUIJS2QgP
 o6aQqRDELzt7B8uU6gYH0F/HnKpe6OLWHOu7DyQzsMPqyQuFz/Y4NxrfbNmDKk3kRXEC
 pZHw==
X-Gm-Message-State: AJIora+lbj8/o44o66k3B7DzBnAPiJtrcbKlKGla5KmBVcl1k30/phGM
 JCJOvJCWQqUoXmFuYnkTWsdz74cQ1vDWMEi1lPwW4WcyqzLLKOWmIikBFMZyobKshofsdBnj9yz
 Ln7Hr6Lu5fltmQtOWPjOZt2m4CQ==
X-Received: by 2002:a05:6214:1c49:b0:470:5f70:4ab1 with SMTP id
 if9-20020a0562141c4900b004705f704ab1mr6041417qvb.13.1656254780353; 
 Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwKpbQh1t2Fwl4Ge8LmFUOf/3X70OZcbrAYYkN7/IZ4bcE826TN7H5F8YkD5GlSQNHaim5WA==
X-Received: by 2002:a05:6214:1c49:b0:470:5f70:4ab1 with SMTP id
 if9-20020a0562141c4900b004705f704ab1mr6041396qvb.13.1656254780138; 
 Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 22-20020ac85916000000b00317bcb6ad2csm5343266qty.17.2022.06.26.07.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 07:46:19 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, Qingqing.Zhuo@amd.com,
 mario.limonciello@amd.com, nicholas.kazlauskas@amd.com,
 aurabindo.pillai@amd.com, maira.canal@usp.br
Subject: [PATCH] drm/amd/display: change to_dal_irq_source_dnc32() storage
 class specifier to static
Date: Sun, 26 Jun 2022 10:46:15 -0400
Message-Id: <20220626144615.2227149-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 27 Jun 2022 12:51:35 +0000
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

sparse reports
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn32/irq_service_dcn32.c:39:20: warning: symbol 'to_dal_irq_source_dcn32' was not declared. Should it be static?

to_dal_irq_source_dnc32() is only referenced in irq_service_dnc32.c, so change its
storage class specifier to static.

Fixes: 0efd4374f6b4 ("drm/amd/display: add dcn32 IRQ changes")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 3a213ca2f077..b1012fa1977b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -36,7 +36,7 @@
 
 #define DCN_BASE__INST0_SEG2                       0x000034C0
 
-enum dc_irq_source to_dal_irq_source_dcn32(
+static enum dc_irq_source to_dal_irq_source_dcn32(
 		struct irq_service *irq_service,
 		uint32_t src_id,
 		uint32_t ext_id)
-- 
2.27.0

