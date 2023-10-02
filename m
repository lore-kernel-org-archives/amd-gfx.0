Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DB2E784BE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B0210E2DA;
	Mon,  2 Oct 2023 15:42:39 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359DB10E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 15:42:38 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dceaa7aeffso1726679fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261357; x=1696866157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58gyx6oEc50QSA+3gDO/VREfScg978m8wlhKnpLG5H4=;
 b=cwySD/xUqLooznayw9nqmjf3UUyCsPAkR7TJSKhdpM82ldx03HebtRqbgkCRwc4dTE
 ieCoG1RGER0EH9NYDY/OcFyKAy8Ja5Jzp3Y8YLaxVxr1bkGHM1F9kGtJyZh1HylMQQC+
 sKevfUeviOtWskqdlhcNhFJRb0E4T2enIOcHpsA/idClQ80R/jNHTwPC55DzUOnYLQJQ
 sSmQwrvVY5T6QYhy+knagjdx1Uxi2dJslEIMH+rRVTcAq1WWzF+KWd4rTa93G43ImHcS
 358FxbAFHTslYvuB5EwVKuIdTsRawFw25ciAGjjX2hBJGK+27Irt2vqYclu1Ng8sdobn
 hK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261357; x=1696866157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58gyx6oEc50QSA+3gDO/VREfScg978m8wlhKnpLG5H4=;
 b=UqEwJV1MVIRZoHYiUYq/5ILCI/Bwp3EAqqBer0n7YZn0b4bpCj1Z7kwfda31IohJf2
 r0MMlhWcZ7H7i9RQKQxxdgGyLl1aZA2qh6X61rD51SktjeQEvXZYxncY8pVBe18DX3KN
 mqP2LPNKtu3rjoHucdUnZfqBBcHKDauzBEMTEqLzsuguxixM/FFbd9InmKceUjdzQbss
 2ZubgOH7LHh2XA3WzY3rDPUi3/j2klhFvtnCg5Yir6rCq/mUc9NHozIC+0dIPUCAHper
 a8zuywEmYH7zy/8I1mqCJUgvysuXW0KLs858A4Ll3P0E/wbvV3KAuDvA5z9oWM6K9xQN
 5YpA==
X-Gm-Message-State: AOJu0YxZy6PB7c9tIUkuY89V/qJ948vLE0NR5AFe9C8hbenp7LU/Ksae
 467kffdlMi2C8FZI/UVHjaLXbFX/Ua12zwyLWkI=
X-Google-Smtp-Source: AGHT+IF1L56vI3YQQv53yGIQ1a46lmAD2KVRzqSjh+qVHKoefqWUH/aZXtXUupExWwKw2Ge/7vbvsl6V5Pa9JNRqgQs=
X-Received: by 2002:a05:6870:b612:b0:1dd:bd0:aa45 with SMTP id
 cm18-20020a056870b61200b001dd0bd0aa45mr6683398oab.18.1696261356863; Mon, 02
 Oct 2023 08:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231002010835.14798-1-rdunlap@infradead.org>
 <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
In-Reply-To: <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Oct 2023 11:42:25 -0400
Message-ID: <CADnq5_PXf0uq07iPFFbtR-W4HMR6bmtU8PoemNY0P7vcUoU9Kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Oct 2, 2023 at 6:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 02.10.23 um 03:08 schrieb Randy Dunlap:
> > Correct typos of "occurred".
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   include/uapi/drm/amdgpu_drm.h |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
> >   /* unknown cause */
> >   #define AMDGPU_CTX_UNKNOWN_RESET    3
> >
> > -/* indicate gpu reset occured after ctx created */
> > +/* indicate gpu reset occurred after ctx created */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
> > -/* indicate vram lost occured after ctx created */
> > +/* indicate vram lost occurred after ctx created */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
> >   /* indicate some job from this context once cause gpu hang */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)
>
