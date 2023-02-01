Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECFC05027
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Feb 2023 18:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BDD10E43B;
	Wed,  1 Feb 2023 18:16:40 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB2B10E43B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Feb 2023 18:16:38 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1636eae256cso20331616fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Feb 2023 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rmpn0bwyxfzucO979Sx7Kx4N36KQpvw5EIddfi1K1O4=;
 b=f45VHdZu/Lj0Y/tUcOowAf/SXMXDRie58wQ7V/5WG/GynGcZmAFcgK/ZUHaR8LiMZQ
 o/KjWY9hTfa5yEeCa060pJ9Y74lM45WJZsFRtAb+WDzpmGQVUbtE45DRg+bTdKn71pP+
 QhsiBmSv5+kVxQOt1CkeMZ5J4MAwKkJ3Mo+zXpr/8YgG6thbvuyk4KpE8zvuowUfEcdl
 GBUk5NAlBz9Vc7Jn//KE34zfoYPGLSvge92GsTuk95WFrw8FceR+05TUeex4Zoyb3AFv
 QW/H0cYx+q8x8OhqbGk2NH7Wh9K7qLM77qbbJi39HeXKOIVCNhmp0z6ySJbe5FIF4sZA
 7/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rmpn0bwyxfzucO979Sx7Kx4N36KQpvw5EIddfi1K1O4=;
 b=M/OV3wc068rCKoOwJg5clRB3lXBzt9msHzGQrHPMaSLUX1zTKQ00UlCQOLIpFnk8WK
 bd9wHT8CDKmgq3hUc2CH4O/xjK0R5tneaw/M421CLijZTbBoRuY3R0DSqTzWY/AF26Mm
 aMtUnNalE5q4qeXAPjWymxC8SJ35eQnQvDMkNcrhTtxO0XO/fddp8CO7MMsWgQgrX/VW
 Vd4NH6ODRf7M/EJl3gHw21U9B7IZWKw5AJC3EgYClFN00qcoteIYO6jfCI/Vi3mUwMVA
 hTi+TKy+lWSBNMsiZktmpKZ7APsJzijQ+mUmEJy6tZubOvnWrWJpXdCyV61qvANPu88V
 E37g==
X-Gm-Message-State: AO0yUKV5Xbh/DIBFUpkRKPSyISYDeEaUlCT9pg7+VX3gZ8j2goPrdGxR
 ELEZN5AtOByGzyc9JnoHlZ7Vqa1hBa1EdjzFPjpvsHFMsnE=
X-Google-Smtp-Source: AK7set934bh2HRwDIXinlpenM0+8S3UFLxXZzyjBHMyk+36Ai3sUE1H27BIvDjxVNJcKaS4gKHj4xAe8BLiCNibKtCQ=
X-Received: by 2002:a05:6870:b524:b0:163:8cc6:86a with SMTP id
 v36-20020a056870b52400b001638cc6086amr364892oap.46.1675275398114; Wed, 01 Feb
 2023 10:16:38 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A73GBHFYxYc4Q8h5=ohd5Qsp9E_750U_Xkc+Q9Y4GnvyA@mail.gmail.com>
In-Reply-To: <CAAxE2A73GBHFYxYc4Q8h5=ohd5Qsp9E_750U_Xkc+Q9Y4GnvyA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Feb 2023 13:16:26 -0500
Message-ID: <CADnq5_MqzoEOk9NdGa8+ieZxkhLVBWDnJGpAr7komHinJ0bOOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add more fields into device info, caches
 sizes, etc.
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good to me.  WIth a link the mesa MR which uses these, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

For TA_CNTL2, an alternative would be to add this register to the
AMDGPU_INFO_READ_MMR_REG and just cache it in the KGD if you think we
may need other fields from it in the future.

Alex

On Mon, Jan 30, 2023 at 12:57 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> w=
rote:
>
> AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD: important for conformance on gfx=
11
> Other fields are exposed from IP discovery.
> enabled_rb_pipes_mask_hi is added for future chips, currently 0.
>
> The patch is attached.
>
> Thanks,
> Marek
