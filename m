Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944EFD25940
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 05:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E8210E136;
	Tue, 27 Jan 2026 05:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JhxDxnjt";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10F310E136
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 05:55:52 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-123387e3151so323735c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769493352; cv=none;
 d=google.com; s=arc-20240605;
 b=WVKfoSct3WaexUNHYaUaPdG2iP9VUFu4kkNCMerUBMaDAxZi64w/JbhGfNLMmqdVka
 RmGgDrS/7XEazIXb9NS7c2OM0MW6uaTf4cVbHTAmHB94gNkMY2jznq9A9Q6FQGK0dmy5
 JulNT+4YyFXfvYkZbQvpyVPxNzUwwBY2i01GKo2tYb+oOeea5SxDXT0vCJJZFZj9YIpr
 XkdSqzqpP/uR9Gflj4rtYyzwPSRUMuMTZYW0/JhJFIAz6hn+V/NRYEQ6oUfK8LCQGV8d
 QRDVNN3lfQ2JatvOFf4ENa6a7dJ1nWIJvfldfAdJRDzjzj/GiaBTxFCBUbGHsIHaeyQE
 AjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lyqgd3JNK5ppWHxGI7vX2AwQNZLlDOxrWSRDq1AGlm8=;
 fh=hetNsZY7cg7D/HWlCvW9pGm8HtgTQAhFQDlASYZrYag=;
 b=MdjVfelmVivaL+2/SHngnOqQTeflnj+nJyHe3dqDzJnK77OqdptNbAx0Z8a8jQ6kQ3
 k6pB4I02xYbRtIihXfvH1fsT2uMr7arVlwLf92fFKnBfuQz+8TJtuM9+DfcI1UWcPuFZ
 f8IdrEJwhGBgFCqvnb1nuiCdvBRXGliTIfD4Rn3A5l+ZlNSu7WQzT9zNwyXqflzunPQF
 GQk7yKMRcLUOLQ80zTMZGpGfyVgpSOyBiwoNMzFOQ9tF3ksGV3u23MK5PIPI5fXNJWGI
 G9RMgef79ps/9yZIW0GnWc2h9CIQDDbMDqTzAKeK4xP6nQq6GynAG4IGa5BZ0liBUhKT
 Sq+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769493352; x=1770098152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lyqgd3JNK5ppWHxGI7vX2AwQNZLlDOxrWSRDq1AGlm8=;
 b=JhxDxnjt7Ct/sMoG4COqjWr8IfYUKUsS+ztMD1ln7K9i7jm+Ks7EAOx79thNI1ESvq
 R9WwH7Y+8JBtJ1jN+EUJr3YnJFQP6SigMpPWpNafvWl9UIAkuA4mjG8nURCRpCBWEBLT
 TOlWS3PBE0K/rmD82bEc228YRoe6mS6pFFAHsjbxWzYmrWXKYsCHEO4/ErfW5qXJYv4p
 h5jddufZRuIwjymNtbAjYPvfDCI9jaM2QY/B/l9Oun8Jj/YdQ03PmzAdGWfQYcjWHAg3
 dsjW7qJ7K46AMLKvcPib5eLptBpJjnv/V9d2gIhzW39QH0BKozAki44P+XEsZdrRJWnY
 zMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769493352; x=1770098152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lyqgd3JNK5ppWHxGI7vX2AwQNZLlDOxrWSRDq1AGlm8=;
 b=Z3Tr3Hfv6ALBKNE2AMqWqfx1Zp4tSY3ZwEqcs8WrukBBGfy2Bj0iEBnc0C3wQ+1CfQ
 mutkj1240ekqwf+GM8jE0f4mMcTAXJjoMOkMfFqenkYGAhTVC5JY2SpbPYs8qW4Q/zve
 Xd9CpS7aKwSxUyIO5fhh3mNQXGlPNGBVDG4lsnTMmfk7+7BhQtcgaQhLjHfP4JHFBW/T
 giiwI1sAyShhMaGaa9WA333SwcQLtYO0WOfKSZcoaXTWWo4c02cOLvRF7aRos/V6o/0K
 jZEJpUCuFq0nWSkNLoiiyzuMRJPwz1sy/lpJjXePNz3bFhD6TIpMRjP+GmousmtPMXrL
 tAkA==
X-Gm-Message-State: AOJu0YzGhUT3jlcSxIiXkAaqW/m31oURhZ4fhfS2VS5xGF2Fi6uNd1v9
 rcWVbc78UKj/nr0U3CtIQe8m8bklxPMhyM4/wrbEkR6/ce12chDLcZfqAYYdEWyibLCL/ZYoej3
 tu4I7EY7Ykic4KrCb5bY4ceGd9RxSM4o=
X-Gm-Gg: AZuq6aIYRjLS1qKzlq5qoARxcko4rDi+THUznITZr+2GvQm68Os9OaDT+BVdpERps5K
 MA5wkbRGi3tJwUBkY6MPXty6oUbDakrWxwI5jKOmdWowIKgho/YBhivj/97e1yB6VMyM+LHzMAq
 BEzt5OcngSCRiK2Prkqw7rBKghhMfA/pevxxLbsgDS7RJO66qxL83AqMqZl0/go9TYTmZTMIWtb
 zMYNUuISKs+JR+fsWoKMvRxyVVedHNz6gsWejtPjgbcC4yNZXDK3xY2q2GTQlMH6WzzKf52xgN/
 QKpVPx4=
X-Received: by 2002:a05:7022:90f:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-124a00f48a6mr165048c88.4.1769493351833; Mon, 26 Jan 2026
 21:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
 <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
 <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
In-Reply-To: <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 00:55:39 -0500
X-Gm-Features: AZwV_QicjIC38YkpZrqTF_6DLYgKOvqjcJp96L7xemshVJodCLye3yWFkRV6nJA
Message-ID: <CADnq5_P243kbtXDgv0JqgjmB9taA+2uMUbYtR90aVzPU4APXUw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Tue, Jan 27, 2026 at 12:35=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 24-Jan-26 2:14 AM, Alex Deucher wrote:
> > On Thu, Jan 22, 2026 at 5:52=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com>=
 wrote:
> >>
> >> Add an interface to validate user provided save area parameters. Addre=
ss
> >> validation is not done and expected to be done outside.
> >>
> >> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++=
++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
> >>   2 files changed, 55 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_cwsr.c
> >> index 80020fd33ce6..32d9398cd1d1 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> >> @@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct =
amdgpu_device *adev)
> >>          return true;
> >>   }
> >>
> >> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_=
xcc)
> >> +{
> >> +       if (!amdgpu_cwsr_is_enabled(adev))
> >> +               return 0;
> >> +
> >> +       return num_xcc *
> >> +              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_db=
g_mem_sz);
> >
> > These could overflow if userspace passes in especially large values.
> >
>
> Sorry, I didn't get that. cwsr_info contains driver calculated values.
> This function returns the size required.

Sorry, I mixed this up.  See below.

>
> Thanks,
> Lijo
>
> > Alex
> >
> >> +}
> >> +
> >>   static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> >>                                           struct amdgpu_cwsr_info *cws=
r_info)
> >>   {
> >> @@ -425,6 +434,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
> >>          return r;
> >>   }
> >>
> >> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> >> +                               struct amdgpu_cwsr_params *cwsr_params=
,
> >> +                               int num_xcc)
> >> +{
> >> +       struct amdgpu_cwsr_info *cwsr_info =3D adev->cwsr_info;
> >> +
> >> +       if (!amdgpu_cwsr_is_enabled(adev))
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       if (!cwsr_params)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * Only control stack and save area size details checked. Addr=
ess validation needs to be
> >> +        * carried out separately.
> >> +        */
> >> +       if (cwsr_params->ctl_stack_sz !=3D
> >> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
> >> +               dev_dbg(adev->dev,
> >> +                       "queue ctl stack size 0x%x not equal to node c=
tl stack size 0x%x\n",
> >> +                       cwsr_params->ctl_stack_sz,
> >> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * num_xcc))=
 {
> >> +               dev_dbg(adev->dev,
> >> +                       "queue cwsr size 0x%x not equal to node cwsr s=
ize 0x%x\n",
> >> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc=
_cwsr_sz);
> >> +               return -EINVAL;
> >> +       }

cwsr_params->cwsr_sz has no upper bound check.  Can this cause an
overflow elsewhere?

Alex


Alex

> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *=
vm,
> >>                        struct amdgpu_cwsr_trap_obj **trap_obj)
> >>   {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_cwsr.h
> >> index 3c80d057bbed..96b03a8ed99b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> >> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
> >>          uint32_t xcc_cwsr_sz;
> >>   };
> >>
> >> +struct amdgpu_cwsr_params {
> >> +       uint64_t ctx_save_area_address;
> >> +       /* cwsr size info */
> >> +       uint32_t ctl_stack_sz;
> >> +       uint32_t cwsr_sz;
> >> +};
> >> +
> >>   int amdgpu_cwsr_init(struct amdgpu_device *adev);
> >>   void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> >>
> >> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amd=
gpu_device *adev)
> >>          return adev->cwsr_info !=3D NULL;
> >>   }
> >>
> >> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_=
xcc);
> >> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> >> +                               struct amdgpu_cwsr_params *cwsr_params=
,
> >> +                               int num_xcc);
> >>   #endif
> >> --
> >> 2.49.0
> >>
>
