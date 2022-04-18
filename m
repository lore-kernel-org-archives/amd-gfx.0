Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DBBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 07:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E156B10E794;
	Tue, 19 Apr 2022 07:45:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418D010E19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650311316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xoFC0RlqU29MoZ59ErURITWrPmQFVCqFinpLIIkANfM=;
 b=abm8T/oC3efv8jtDyYYMQHn0xoN0IvtVzF5git/OONh5IaGJcrOEcOsx0iVerxt+DIIfwn
 AuZ07buq2mJVe8uq2yvlgdPjE4zqqrgxuhq5w1vYXP9AcN66IxM4eBZvM3CCBwYcE0Wxnq
 ikDqpMldePS2dvCmtj4cXdWc17aG3Cw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-qQMB4uvSNdqpvEym5WcQOg-1; Mon, 18 Apr 2022 15:48:36 -0400
X-MC-Unique: qQMB4uvSNdqpvEym5WcQOg-1
Received: by mail-qt1-f198.google.com with SMTP id
 bb32-20020a05622a1b2000b002f1f41e6caeso3301158qtb.19
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xoFC0RlqU29MoZ59ErURITWrPmQFVCqFinpLIIkANfM=;
 b=Unvb8+q3xqyw+8T/sgoxQjvhoo0NwdbBTmphcJb3Npq8XYeryrbply1T1JkyAeBN2c
 L2M+YcDdpUa6N1YTvB3kXr1FuVUZzgjelHudaepx+A8ZYj0phRXHOL8jp64PIWghCwKw
 YfP0bj7ydDpVHU92HZu5DTODhs8UNzpAbFVMZElr7FJ97Rhm/6ggdgMdOlz1KY0QbWwG
 HsyDMPnMODBL3yf8LTBtlF/e3yLFgdt36XrzLQ7nWuB31w7iaUIZ2fB0rFWo2bPCV0eY
 I5X8IbAwkPbOSM684lho+LOn6HFKiLQGaCjoWSa9AtAWzDo4QbveiMwrGNJoXsl6xv8g
 3AKw==
X-Gm-Message-State: AOAM531RCvy5GhcqKeovnwn+p3iv6RrXewKqIUE3UM96WHE1cmTUnBEO
 Gl3Xk1Rh4I/VPDQ55sXsvLXL6PGVNe7R8gESoELExlPlhb0StsxBhxQSvXnTVUnoREa0O+RdbHv
 WI8v4uL7dsYxCpN2xEKh2sQiogw==
X-Received: by 2002:a37:5502:0:b0:67e:a143:80da with SMTP id
 j2-20020a375502000000b0067ea14380damr7634841qkb.329.1650311315542; 
 Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygpNhttVMJUTFKmX/4Fl6amPuHUl9AtPkfNHtmHbJyX+T1xlwpJ6/GzrDPFtzLWBf4yMrmnA==
X-Received: by 2002:a37:5502:0:b0:67e:a143:80da with SMTP id
 j2-20020a375502000000b0067ea14380damr7634826qkb.329.1650311315300; 
 Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 3-20020ac85903000000b002ee83037459sm8393773qty.42.2022.04.18.12.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Apr 2022 12:48:34 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, stylon.wang@amd.com, Jun.Lei@amd.com,
 wenjing.liu@amd.com
Subject: [PATCH] drm/amd/display: add virtual_setup_stream_attribute decl to
 header
Date: Mon, 18 Apr 2022 15:48:30 -0400
Message-Id: <20220418194830.3266024-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 19 Apr 2022 07:45:11 +0000
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

Smatch reports this issue
virtual_link_hwss.c:32:6: warning: symbol
  'virtual_setup_stream_attribute' was not declared.
  Should it be static?

virtual_setup_stream_attribute is only used in
virtual_link_hwss.c, but the other functions in the
file are declared in the header file and used elsewhere.
For consistency, add the virtual_setup_stream_attribute
decl to virtual_link_hwss.h.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
index e6bcb4bb0f3a..fbcbc5afb47d 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
@@ -28,6 +28,7 @@
 #include "core_types.h"
 
 void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
+void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx);
 void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
 const struct link_hwss *get_virtual_link_hwss(void);
 
-- 
2.27.0

