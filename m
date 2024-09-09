Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF6ECE577
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6B110E619;
	Mon,  9 Sep 2024 17:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Iz966UAV";
	dkim-atps=neutral
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D53E10E61B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:52:21 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e1a74ee4c75so4930536276.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1725904340; x=1726509140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewnn+I0cbL5Fc6YtuZyrPYuNwfjqJiKs03aOOqjG7A8=;
 b=Iz966UAVQ+ytGMStst701K5RZ9nILUemzx3sxR0c+6eCoBh6yjFoDtj1R2Zit/h5Xe
 2WLOOiE8CoGW1mAn8k15sizt3Rbbqbbi05VAl+/0avgLzySYykwV+snnaFxxgyOLXvbo
 tTmfSQnWzQEeyRUyVVgzMUlYwmKVskP02VcHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904340; x=1726509140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewnn+I0cbL5Fc6YtuZyrPYuNwfjqJiKs03aOOqjG7A8=;
 b=vREB0kqYakAofRFKMWarcJNKgp1KpI6ob4b6K3yMr+j38NlFxL7t9Kkl530Mm0XcYP
 nF1A4D1EVIogf/dQ7OkTNgqMXjgqmEk3YvTOQGudA4uZ6/EARcn9QYzmL4SEAxbzyrq3
 mUrvtIMpQqo/TBybMrbxnvPkOobP3GqtRuVRHEfIvd0TrV3AomXSTue/b4TrmwKQBLry
 MDCLFc9FBxHzy2cXauewyxYMivb+JXpaDNpCdpAzDtM6R7CO13oVq+G4+PexF8bQ8r3T
 PFkcouEAyakj3TeW3XCd3jT06QjQ/Qwr3mgygYyydPp68mTwFWKtLmqnCs51LT8vpemg
 jhlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPU14M1yqng7JrI6HJp2NRzpWf8wYG2KCGN4VSUxPdYo+tPSO0u4IQoKA8Dh+3YXg+R0krDA6j@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxfdCgGc5kgARAnvQE8BG0fnsAyH/qvhmxQZeybJzKHWxxV+C8
 BAbfac5yunQbkiPQ0t2rjzfIhOkor06d80uWKbmigjpHDM0iieiP/Z/jV0jynV48O58ya2L+bpa
 uDFqnppq6MF5vgyzaXex31Rw+zSZceqGLbu7F
X-Google-Smtp-Source: AGHT+IHDKPPn8dTPuWieyrmVdOyWupTxM3bjm2KyLBaOg4ntadLH/U0C1Wzi1TrHYhzoSYP/p/zfD2Wna/PMSgFmvmQ=
X-Received: by 2002:a05:6902:1ac1:b0:e13:e674:553c with SMTP id
 3f1490d57ef6-e1d3486ac3emr13335040276.7.1725904339866; Mon, 09 Sep 2024
 10:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240909113633.595465-1-tzimmermann@suse.de>
 <20240909113633.595465-72-tzimmermann@suse.de>
In-Reply-To: <20240909113633.595465-72-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 9 Sep 2024 13:52:09 -0400
Message-ID: <CABQX2QP705HDDUNFCQ0SNkq2-_SaXPGG4KZOw5EhZU68Yu_nZQ@mail.gmail.com>
Subject: Re: [PATCH v4 71/80] drm/vmwgfx: Run DRM default client setup
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, jfalempe@redhat.com, 
 javierm@redhat.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 9, 2024 at 7:37=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Quick note: I love what you did with drm client and drm fbdev. Thanks
a lot for that work!

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z
