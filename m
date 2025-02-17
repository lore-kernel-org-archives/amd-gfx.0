Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61C2C021AA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 14:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF8210E2DE;
	Mon, 17 Feb 2025 14:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdedzJL4";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9CD10E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 14:35:43 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso978141a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739802943; x=1740407743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrkaniyPRDU3o24rcQDtgWYJicGEaYLAqAqhaf+eVBY=;
 b=BdedzJL4rzes6q2ow8QR8R0Qk2TDGBDXTw+9XNGJHt0fiSqNl1NXgCHrN7Uxmj/NT7
 NgiILE8EpbCA8O3wmYCiWlrflpfDXDpeEgB8doj+13UE539i4uipt2wAGOG4+wXxIihS
 mzO34nUppttGboQzDqrm04Zc/PXJEBQQ+EWBOvvG1wYcoTpxMzTPVBitB76ACvofD9OL
 BQ4oYNNy9ed9ylR2hipPwEOsbPMnMATgb/74ovY4KI5LvDQQC6FA3OADxYcgTfUGgKZX
 Tz33HIbBjlMwi30EZTpERXbHsSZyMXGoOdg5iuzzvt5taDqH8xW1NhKHW+VUq7DIIENN
 dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802943; x=1740407743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrkaniyPRDU3o24rcQDtgWYJicGEaYLAqAqhaf+eVBY=;
 b=tYGCzkMkXiojdSWQxFZxjm5nHtV3le9N72BCSa5GAhDC5UPxZn4Hw0X5i8n6fAVphF
 CeVy0HtZMBkDog72yxagvNsFJ4iVTruzP5poSNJBs+1ETVEPiIoPK28t1QruoVnKvSjh
 yBkDi3HZiTZ0tegrbt4NdC4MN/LWM2caSsWPoUVCaCMtwLwRoexgf7xD68I12GweduWe
 lY09DBQZQEdwD2l4ClGFJ2e4fHxdjOe/x4X9+FEL+uzpCN7/sQlCMP2bg+RANW4LLKHa
 Ve1ESsdV4ltv4IvuVwwciQk8AyjroIZvRD4chX7V7fmJNJDMd53CmqyiPltLYR98n1er
 WzIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWftaNGAbXXMZOnzUnuTw1mSEjBZcFTXLXaT2TgElrgOU+Hv9s0nqsDkc+YX885xiwr25AAJQ67@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7Y1wZRepSY/+fOAIC1TU8SRl/rLejiFZ+FKrktgy4KG9tTrob
 De8oXbyeZ51rI9nmH0cP7k0XLAk8jFYxLYvnR6bbPsWH+Mumxg7NKBcrIpusyfJ7+rsAIB2HIfE
 N5X022pyNH1/xcyvMn5sFhf1HB+U=
X-Gm-Gg: ASbGncv4jGXvncwuJu0X2iQFZeJYUlqiOztdoe/nx4tRFUBe9QBrcejEs+u4E1gFqze
 EQ9PLLQY5Afws9tMLQKTpajbvM6UTFu19a7DKXKqHEmoAXHa8MOqd7fwq7WSj8Wszx9qGGaDk
X-Google-Smtp-Source: AGHT+IHRtHZFI8OZWuTlxUMmIu6CYctE60rKDHBsP/JzNsIguLT/dxw2/qjN6KdXOhwPLqJVBEud0Ivy7vc4Yudikac=
X-Received: by 2002:a17:90b:4c07:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2fc40c1d80dmr6265886a91.1.1739802943081; Mon, 17 Feb 2025
 06:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20250214173522.2373211-1-alexander.deucher@amd.com>
 <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
 <CADnq5_OmnYXoc94h0LjG52wqwkOCAaB6eefYoqiJZY3k-hVm2Q@mail.gmail.com>
 <789dee33-a962-4824-b82a-375a36168420@amd.com>
In-Reply-To: <789dee33-a962-4824-b82a-375a36168420@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 09:35:31 -0500
X-Gm-Features: AWEUYZl1WvgtsEenipBbsMcA9fb56Xco2dVmxluidpCKeQdmxb3gy2Yqeg_4ErI
Message-ID: <CADnq5_Pm=epLrLRd842rsVriOo0ttTtB81_PK+BWHXkLwPPJfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Shaoyun Liu <shaoyun.liu@amd.com>
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

On Mon, Feb 17, 2025 at 9:18=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 2/17/2025 7:44 PM, Alex Deucher wrote:
> > On Sat, Feb 15, 2025 at 3:02=E2=80=AFAM SRINIVASAN SHANMUGAM
> > <srinivasan.shanmugam@amd.com> wrote:
> >>
> >> On 2/14/2025 11:05 PM, Alex Deucher wrote:
> >>
> >> Re-send the mes message on resume to make sure the
> >> mes state is up to date.
> >>
> >> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES"=
)
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Shaoyun Liu <shaoyun.liu@amd.com>
> >> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
> >>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
> >>   5 files changed, 32 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c
> >> index b9bd6654f3172..a194bf3347cbc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >> @@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolatio=
n(struct device *dev,
> >>    }
> >>
> >>    mutex_lock(&adev->enforce_isolation_mutex);
> >> -
> >>    for (i =3D 0; i < num_partitions; i++) {
> >> - if (adev->enforce_isolation[i] && !partition_values[i]) {
> >> + if (adev->enforce_isolation[i] && !partition_values[i])
> >>    /* Going from enabled to disabled */
> >>    amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> >> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> >> - amdgpu_mes_set_enforce_isolation(adev, i, false);
> >> - } else if (!adev->enforce_isolation[i] && partition_values[i]) {
> >> + else if (!adev->enforce_isolation[i] && partition_values[i])
> >>    /* Going from disabled to enabled */
> >>    amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> >> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> >> - amdgpu_mes_set_enforce_isolation(adev, i, true);
> >> - }
> >>    adev->enforce_isolation[i] =3D partition_values[i];
> >>    }
> >> -
> >>    mutex_unlock(&adev->enforce_isolation_mutex);
> >>
> >> + amdgpu_mes_update_enforce_isolation(adev);
> >> +
> >>    return count;
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mes.c
> >> index cee38bb6cfaf2..ca076306adba4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >> @@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(str=
uct amdgpu_device *adev)
> >>   }
> >>
> >>   /* Fix me -- node_id is used to identify the correct MES instances i=
n the future */
> >> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint=
32_t node_id, bool enable)
> >> +static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *ade=
v,
> >> +    uint32_t node_id, bool enable)
> >>   {
> >>    struct mes_misc_op_input op_input =3D {0};
> >>    int r;
> >> @@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amd=
gpu_device *adev, uint32_t node_i
> >>    return r;
> >>   }
> >>
> >> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
> >> +{
> >> + int i, r =3D 0;
> >> +
> >> + if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
> >> + mutex_lock(&adev->enforce_isolation_mutex);
> >> + for (i =3D 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++=
) {
> >> + if (adev->enforce_isolation[i])
> >> + r |=3D amdgpu_mes_set_enforce_isolation(adev, i, true);
> >> + else
> >> + r |=3D amdgpu_mes_set_enforce_isolation(adev, i, false);
> >> + }
> >> + mutex_unlock(&adev->enforce_isolation_mutex);
> >> + }
> >> + return r;
> >> +}
> >> +
> >>   #if defined(CONFIG_DEBUG_FS)
> >>
> >>   static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, voi=
d *unused)
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mes.h
> >> index 6a792ffc81e33..3a65c3788956d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >> @@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu=
_mes *mes)
> >>
> >>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *a=
dev);
> >>
> >> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint=
32_t node_id, bool enable);
> >> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
> >>
> >>   #endif /* __AMDGPU_MES_H__ */
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v11_0.c
> >> index 530371e6a7aee..fc7b17463cb4d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >> @@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_b=
lock *ip_block)
> >>    goto failure;
> >>    }
> >>
> >> + r =3D amdgpu_mes_update_enforce_isolation(adev);
> >> + if (r)
> >> + goto failure;
> >> +
> >>
> >> Hi Alex,
> >>
> >> Should this also be moved to mes_v11_0_hw_init. Please let me know you=
r thoughts?
> > I'm not sure I follow.  This is in hw_init.
> >
> > Alex
>
> Sorry, my mistake mes_v11_0_sw_init pls?

There's no need to call it in sw_init, plus the hw is not set up in
sw_init so you can't call it there anyway.  The whole point of this is
to update the firmware with the current sw state after a suspend or
reset.

Alex

>
> Thanks!
>
> Srini
>
> >>   out:
> >>    /*
> >>    * Disable KIQ ring usage from the driver once MES is enabled.
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v12_0.c
> >> index 6db88584dd529..ec91c78468f30 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> >> @@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_b=
lock *ip_block)
> >>    goto failure;
> >>    }
> >>
> >> + r =3D amdgpu_mes_update_enforce_isolation(adev);
> >> + if (r)
> >> + goto failure;
> >> +
> >>
> >> And Similarly here also?
> >>
> >> Thanks!
> >>
> >> Srini
> >>
> >>   out:
> >>    /*
> >>    * Disable KIQ ring usage from the driver once MES is enabled.
