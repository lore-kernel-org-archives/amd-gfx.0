Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 05:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEA6205CB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 05:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srx+ksMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEA6205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A76B6E115;
	Fri, 15 May 2020 05:19:37 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF436E115;
 Fri, 15 May 2020 05:19:36 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id l17so1925944wrr.4;
 Thu, 14 May 2020 22:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p+Mc6Bj80WK0H9pdKOC9OmOjNwdh1IR7a/pcEnxhdps=;
 b=srx+ksMo2QU9B5B1tPddJiAsRa9nYbEAyI64NAJN7HdmCSIi5QWJbfuWik4hOECKx9
 kDCZtWjKyrsTDa9xmWyGUsLUDoWO1SgeN+r/bjI2/oOVzJn37a7VMoV7gDGz23aAT9g0
 tmlW6qJpxibOLxIuTF+34oxXRlzjXLnQaddD7dBTjNTVF7xUqwgjuLkZ41ARjXpE67Bn
 tgXUBVZ9mVvYeq2jCqGov7qTUEO1dfZTwBxeb0fNH9BxlFwOC/MTCyMELnJlEN4NU3sy
 0hRnRiX7l3PG7d/qMSjGRPAb2ZTqjoCOjHLRHqZVs9Rj2eGPoeITWh+S285pu+6bGZwi
 XX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p+Mc6Bj80WK0H9pdKOC9OmOjNwdh1IR7a/pcEnxhdps=;
 b=lGeERNFurJZb/MJ2wVLKyUTfiYf3dncPMkySUEnGkKAFeADV7esGacibnDb/c/Rg1r
 d+hGhS+XyePWDO0abeJ8evaMsgplabVvCp6qe52nVKFIhUe69gkh4yVV30un9+ydkClB
 lzFDflezvmvsol4OT9Bv71klfOXKbAPMskiwJcb6aJRPrakpHXLgQ+QJ6cFBJrClSGyb
 eShLJbBw5K+GUQacexxoV1vg9amS1QYXekCbpDaIofqoz6HO93Wfk1OGeMTdOpKP+Xkg
 8NMwnNxOA31DoeqtPRYoa4syw0rgeLSQCLFbBwGc8UfqihmJ5duDeB1LoWsCPEiswDeY
 dVWQ==
X-Gm-Message-State: AOAM5327Def5yXO5eXfD6goP8CMyjJxKXOnivjUHizMQbdzhwxWP+ahr
 NydfvIJcLJ482WsQUoKQ6W4rJqY7FZ8=
X-Google-Smtp-Source: ABdhPJzqJuDbviQbnT4QK+HvhUf7RPJXKJH51YaBQpNHALGj4MJ4yTMIfYUZvwvgs0jNpYoPASSt2g==
X-Received: by 2002:adf:f907:: with SMTP id b7mr2156397wrr.203.1589519975297; 
 Thu, 14 May 2020 22:19:35 -0700 (PDT)
Received: from twisty.localdomain
 (dynamic-2a01-0c22-c877-2100-f914-43b7-6b66-02cf.c22.pool.telefonica.de.
 [2a01:c22:c877:2100:f914:43b7:6b66:2cf])
 by smtp.gmail.com with ESMTPSA id s8sm1554631wrt.69.2020.05.14.22.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 22:19:34 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: fp16 support in xBGR order, and for DCE-11+
Date: Fri, 15 May 2020 07:19:22 +0200
Message-Id: <20200515051924.12331-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

two patches. The first one adds the xBGR ordered variants of fp16
in addition to the xRGB ordered variants that were merged just
very recently.

These variants are required for direct scanout of OpenGL and Vulkan
rendered content, as both OpenGL (GL_RGBA16F) and Vulkan
(VK_FORMAT_R16G16B16A16_SFLOAT) expect RGBA channel order for fp16,
instead of the previously exposed BGRA fp16 ordering.

I have a proof of concept patch against the amdvlk Vulkan driver
that allows fp16 rendering and presentation with this format, but
not with the xRGB format. Nicholas already has the test patch in
his inbox. Results look visually correct, also when used on a HDR
monitor.

I also tested with Patch 2/2 on top on a Polaris11 gpu with DCE-11.2
display engine, and also got correct results, so maybe it makes sense
to enable fp16 scanout support also for DCE and not only DCN?
Patch 2/2 does not enable fp16 on DCE 10 or DCE 8, because i don't
have hardware to test it. But it would be nice to expose fp16 on all
supported display engines.

Thanks,
-mario


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
