Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125FDCF9C71
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA8010E394;
	Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCKnBlJ3";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B77E510E84B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 16:31:13 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-710d9b33303so1436729a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726849873; x=1727454673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kFNgjU2lRuthexlytRySW/QoHblcc+yb5R2qeY2kiQ=;
 b=TCKnBlJ3jDHrSixlMGmQyIqBX3M8QQ/aLttmstbyEgNAp5V2ZwguDM52L/EFc5Wyqa
 8lx0ERFCK4m/vGX28dG/R/1BGzPgq4Br1YLDdyaxSHy9QMtz6PkKK2UDhIfzPheLw2w/
 zYxl9M21DIIR+TPEulH6uF1CWm1sOeb3C1YsK3jWvP6ezeVHi2ruRt6AS0lFXPoPZrCi
 U8QNXSYUTBE/t6cnI4yWFgpdzpJAgq+3ClcsCZe2VlpisfFYSp/3tYnP2y7rdNKQ6tf5
 QfRNf+ezoDVjiRYjwYpYeabidfeeeYiZ9NcsXDziq97qDry2QydTHd9M0Px+azNsXXPh
 jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726849873; x=1727454673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kFNgjU2lRuthexlytRySW/QoHblcc+yb5R2qeY2kiQ=;
 b=TJtUIsER6SZVZDMcWjzeKuhP3Vavnkaa0A6DCDrL/L+3T55lnLfRmkjlPf/bC9zjue
 RCq5YzacbcsEPmuYNFt1fIg67r0FKpI552BK2m2wPgwPAjqtQxgMd33cqF+LMiwA+ngZ
 eafNXTYejnfGAoyiyUNBJhffcFRLM4iyQEa/UD7W9AHL+9vjAOwMojK7LpLan6QqirAS
 WLAzu5IsDQifi2E9Jbcox+60NlUaW7cOkKhAl7VTznd/0qvLc461QJ8sHrrOtFQxP1hc
 3RcOJEs2UM8SLQld+MbBqAk3lUq5CgQPMFg6H6+aUv/aa4ZKYuIkqVBGFFGIATvYDoTV
 yXjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw3VSHJcWZyEnwMJyfYM75rRz0/R/c6E84Xl3qBqrg5bMq8DtEv+2OvaOhneM/SeG6dybEH/kR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCvvsFj4cKXFtuK61F99okecq9XEbLoNucpIZXdAE4BX+Mj8NM
 +kos1IVM6vo+o5V86W6gve7ga5/4l5ZGq2GSEe3WRrjyP2whehImzv3dgZ2VybOmROMluJf2c4B
 647zL+8XWgFg7GRMrGobNV8aIxoA=
X-Google-Smtp-Source: AGHT+IG6kSExes68WvrmTD2Klk+8Mr4krZ64XIuYYOLEOyvVWgd+wL1Sl4mG/cbKjJ2o12LP4IyHlsUuR8XI/I/z6Eg=
X-Received: by 2002:a05:6830:25d6:b0:710:fa02:94b0 with SMTP id
 46e09a7af769-713933e16a2mr1944810a34.0.1726849872894; Fri, 20 Sep 2024
 09:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240920090959.30755-1-kdipendra88@gmail.com>
 <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
In-Reply-To: <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Fri, 20 Sep 2024 22:16:01 +0545
Message-ID: <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com>
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
 airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Sep 2024 07:25:17 +0000
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

On Fri, 20 Sept 2024 at 16:01, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> > '''
> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null poi=
nter dereference: fence [nullPointer]
> >   return fence->timeline_name;
> >          ^
> > '''
> >
> > The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> > or f->ops !=3D &amdkfd_fence_ops.Hence, check has been added .
> > If fence is null , then null is returned.
>
> Well NAK, completely nonsense. Calling the function with a NULL fence is
> illegal.

Thanks for enlightening me .

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > index 1ef758ac5076..2313babcc944 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(s=
truct dma_fence *f)
> >   {
> >       struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);
> >
> > +     if (!fence)
> > +             return NULL;
> > +
> >       return fence->timeline_name;
> >   }
> >
>

Regards,
Dipendra Khadka
