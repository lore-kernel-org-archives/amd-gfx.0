Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0608CF9C5B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BE710E390;
	Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Urdkylm3";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DA310E881
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Sep 2024 04:26:06 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-502b405aa6dso773883e0c.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 21:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726892765; x=1727497565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dB6Zo0YpdRHWofuC2qdabJVVvwBxgLbN85YWc73d7aY=;
 b=Urdkylm3wLH2nTBt0VsmLz6OJrM4XzOn+HkquMKIFj/m3j7LjfmI7xZFK5dlQ9OgrE
 lb9vHvJV07SQLb9UvaDhKJoHvCIvZl5l7CHYp8v3kOd1u6WTF/tQaMH1QZKic7pDk0Iv
 Y53MeqhSCfCUeIkUxYy/WsdBj8HJWvoSypMVgRu7lwxpoUtDzH1rEU0PDqFMxWd86Frt
 sUgFTWNf94r4+2Z/riwtHN8sSgxrng2QXpGGk9gIWV4QLjxbPj9hA8+2BU6ehtB02XfV
 UAiYcD/yZHON/VbrFUVeOZiWHXAwkE4yuANyNSIhb6MiVC+JKvnTDWZ8oe4eNp8ieanm
 ZrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726892765; x=1727497565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dB6Zo0YpdRHWofuC2qdabJVVvwBxgLbN85YWc73d7aY=;
 b=qpvzqIqs3muHp7d9RDxBKnwAx0WmmepGOsNUU1w66vTaDI5+ln51JXnz5OnMSrq09a
 BxPm4uzzjZxP8oNK+QVXCFA65DDvi23iP3siP+XSo9EuKTSffzCd/Q+VQeBdqySt5kqA
 DqTMffVCrRb4MgBo4l2BAg8l4Jg1Do48rEY92o2BiS47ttYH/d+OIi9dvldcBTztATLx
 YIQ2nObjqpEgoJZnf8dAXjSjiiJTZs14eKTyLJrGlz0HcE+cTgwwXhZtuESpaWVrP1QT
 6JSwc9gu8PO+sL0izhm2hsEegxFvWmetkt/MzsKc5QwtwAW7/HsQSL3xIVsa+YIAx9Ff
 X6eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYSaFIsKRb0dpuQps5OtidTMjRy0EgAgBrc4q0YQmC5xDRyyhD5hL3c8tQffYOEMJw+I0J2xKI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiA8quWOqaXIg49FQ6juMSQJOYXUZ6v0noOkxy/VK6p9gK6e8s
 xFul5gfeDl1c2+G2j/Msm1ZSb/75BvrB1g0ISFpeTtpk1U6M1SdpcEoCE/lkSi2KJPPi5CwlRtA
 7UHpziPgPDuBuY0yyjAH/lohSa3A=
X-Google-Smtp-Source: AGHT+IE+M0wXVkx1o8/hbYFnA8ugAtdyDuWOvZYYM4vokGOVWCl0bNvvui3kLaZxw7PDt1aUj47fV6hcH4VEztV2rgI=
X-Received: by 2002:a05:6122:891:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-503e418c86dmr3592219e0c.9.1726892765089; Fri, 20 Sep 2024
 21:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240920090959.30755-1-kdipendra88@gmail.com>
 <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
 <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com>
 <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com>
In-Reply-To: <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 21 Sep 2024 10:10:54 +0545
Message-ID: <CAEKBCKMNZOof8KP5upY45djTC9Bk9+AFHZyZVoid2eevTtjykA@mail.gmail.com>
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

On Sat, 21 Sept 2024 at 00:43, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 20.09.24 um 18:31 schrieb Dipendra Khadka:
> > On Fri, 20 Sept 2024 at 16:01, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> >>> '''
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null p=
ointer dereference: fence [nullPointer]
> >>>    return fence->timeline_name;
> >>>           ^
> >>> '''
> >>>
> >>> The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> >>> or f->ops !=3D &amdkfd_fence_ops.Hence, check has been added .
> >>> If fence is null , then null is returned.
> >> Well NAK, completely nonsense. Calling the function with a NULL fence =
is
> >> illegal.
> > Thanks for enlightening me .
>
> Well sorry to be so direct, but what the heck did you tried to do here?
>

Hi Christian,

cppcheck reported null pointer dereference in the line  " return
fence->timeline_name;" in the function "static const char
*amdkfd_fence_get_timeline_name(struct dma_fence *f)".
In the function , we are getting the value of fence like this :
"struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);"

When I went through the function " to_amdgpu_amdkfd_fence" whose definition=
 is :
'''
struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
{
struct amdgpu_amdkfd_fence *fence;

if (!f)
return NULL;

fence =3D container_of(f, struct amdgpu_amdkfd_fence, base);
if (f->ops =3D=3D &amdkfd_fence_ops)
return fence;

return NULL;
}
'''

Here, the function to_amdgpu_amdkfd_fence can return NULL when f is
empty or f->ops !=3D &amdkfd_fence_ops .So the fence in function
"amdkfd_fence_get_timeline_name" can be NULL.
Hence , I thought dereferencing NULL fence like "return
fence->timeline_name" may result in the runtime crashing. So, I
proposed this fix. Sorry, I was not aware about the behaviour of the
fence.
I am interested in the development and tried to fix this .

> I mean that is broken on so many different levels that I can't
> understand why somebody is suggesting something like that.
>
> Regards,
> Christian.
>
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> index 1ef758ac5076..2313babcc944 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> >>> @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name=
(struct dma_fence *f)
> >>>    {
> >>>        struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f=
);
> >>>
> >>> +     if (!fence)
> >>> +             return NULL;
> >>> +
> >>>        return fence->timeline_name;
> >>>    }
> >>>
> > Regards,
> > Dipendra Khadka
>

Regards,
Dipendra Khadka
