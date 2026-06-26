Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA002CDE015
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BBF10F492;
	Fri, 26 Jun 2026 07:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="nhr6fhie";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E809B10E2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 02:51:22 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30c09f29b64so354616eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442282; x=1783047082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4ytSY1eyQvTl6UG4nVit076xPC5OGBl0m+lhuK6BuQ=;
 b=nhr6fhietvhcSYsLK4ph3IHlYKBaFafGE1lPgqZT9Mucaj4odkkckS2uTP7lqROW59
 qOzPSl78xrT8ckGs4knkukcAGac2pAxnEVjoIsaHDwz8HFb+EchAmriJFENVws4prNoo
 9H1WVuFpMUaxmBhHvHMbeiNu9I0pVAQSsPjSux56PHsYMlJvvv4A/XyOrpfZ2NrBNrQz
 UorKXSqpnVhZ10KH/z738yQ2TdIfaFWApizsDTGEQlUCvJBHcf0Oka5x0e+XVFfWLT4l
 xjwTVqVMwWCVQ1p9LvJl5eSeN91qh/XitQxOz6hPh6CCy0oXieBsooQ2nwrxDqFEz4U6
 BmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442282; x=1783047082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4ytSY1eyQvTl6UG4nVit076xPC5OGBl0m+lhuK6BuQ=;
 b=UtxQF2YK8ZOYAC+w1SW/zwh3/fPg4N2mypVGKczlOuoCEsvC3tkho49OYbOnqul2n8
 ho/B5x9pJx38yluHIoW2LoHOwN0Oqs0leIgiVnSsx5O5CkHIyR8/1pPgTB7tdkuUFoK2
 LBggTMdzKD2tHW0o3A2VHtbnZktXjCs7MkvD7Zzt+0uT9Xjoda4/mEYyLebNnPial8AX
 wJ3efT74AtxOcDvPEBz2qbPlq5ZXB9sovpJkH8azCAhAnQz1XlxaWlyJ4uik8VV8Fitc
 T4QpJ2WuJY94LJLF3r2rr/Tpj/avPI5hLRDmNBjHG2jWh8+vPv3nE/g87azQy+Gk+hjP
 Hfaw==
X-Gm-Message-State: AOJu0Yz8dkPRk3PgnWDG5c8WSrQD8QCgwEipQDyPxSU1E9DCiJL4SxCC
 XL7C2O7dTz4rYWFGf5FD9nc8zgtD5kzW3RN4KhkFUK+QO9HX95tSrJDXloJ5plvrEGDKpu8Mime
 UKTURh04FrQ==
X-Gm-Gg: AfdE7cnlsmOQwz94ua3kPATFq/7Out1vXvOCjsdJ3Oy4vOpYFr1Aa6MHyAJLXq89wL2
 W2Vcq3VgJExcf5o4Y/Jm5ip1OfvW1WQkjds2xMZGsUh+/ZharES/xVvW1ZKWoMI2JYj5ccJ5v4h
 i1VcioWXeu24bMlulAPzp8ooZm9ea+OO8rctCJokMOdartqBEJLn1feAMq68wUcwJ9SXOUvXWLx
 L/oOoegW7iZrahsuyYzRs5XkdGqWxJI3LFYckNr963e8eDPUj5uaPWyGhxxPoCA2K2MdK7GxQll
 /qJFu7UoALbsnCl4dPRtOjMqw8PJ/IVOS+YQ2Uoj/XvvKsuKVdp5heIfM+Out71ur22GQZEtIPE
 +OyWRVbYxQe2HJxaZfN0lvhdJnRGP3onM+Xmd2M1FIhA9e1C+6NkcPwf8qxpG7rQeqv0SYn4uP6
 y34fKpMn/CpFlWiRwW8/mABITqPasADRP/0B8nSFXMK0C0fpslpd0KBJ44CdEEHvp4JIJqqw==
X-Received: by 2002:a05:7300:d407:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-30c55641f4dmr8168585eec.18.1782442281681; 
 Thu, 25 Jun 2026 19:51:21 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm12905797eec.23.2026.06.25.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 19:51:21 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Thu, 25 Jun 2026 23:47:22 -0300
Message-ID: <20260626024948.19131-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them.

v2:
- Replaced macro aliases with direct function pointer assignments in the irq_funcs structs, as requested by Alex Deucher.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 6 files changed, 13 insertions(+), 42 deletions(-)

-- 
2.43.0

