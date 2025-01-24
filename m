Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05B8C0218B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 21:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5278C10E1BD;
	Fri, 24 Jan 2025 21:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KmQTMIqP";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246A010E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 21:41:16 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f7d35de32dso590512a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737754875; x=1738359675; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg2njswS/7JzjlIlqwjwFtKGfjbvuDgFKj4YQdk66EA=;
 b=KmQTMIqP/HQUMNkDLYg4z6HcAYDAGhESdBDovByZvDQ3l+/n3Kr6A9LVbs8lcyxL4Q
 vKoQmXv8VV2+Hw5zqpSgzY4iWnGFIl9J8WGqL+vLQS87g4GnZoopj/5OCGFDHNlIhLzX
 MKcgd9eytYB+9I/zyYR70sHsl8r3+scyZ1MJO4c88FggxbZZDIxHwxj9Cw9rAbWA/gCt
 CXoK87jDNyX1BR6txauNFlLgfvT4iyPVrrvPL8H9j2wcPS/VBPnDa59kRUgdLYUHDKEn
 j4JJs4pgajuI3Rwso9xKuvck4g5DyDhHbomAvgVYGVN/zPqGNdEVvcY6b39Dnb6xhisu
 EhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737754875; x=1738359675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pg2njswS/7JzjlIlqwjwFtKGfjbvuDgFKj4YQdk66EA=;
 b=XMt2TtGdDoio15N2lb/m9jerEstAhRGkS7TSD8Fa5OJRhWL3WJuVUwnYOri6D4+1u8
 d7HDbUBXjVUOcEhBBYCGHxvBRC8C2b5+XUVBPs1EqCot+7Xslb502dgpnFmkz/lTSzS/
 +ZiLmYcveaKAFBtIEgqreHFO+JOchFGW2RhIS+UMyIBudIuXkF0G/KdCWlDlZd0iQj9p
 owlCmcvedD2h+T+ybwMfKjYRtBLAb2X/3n+DZuSVYykM3j7bp8Xbh/ccmO8Rr5FDToK+
 WRGu8q3GLMo34i4RiTPAnXnP9pZTtu8WxdCw8xor0X4FSKZ/iVyqZFYlHaxUipsTAGlO
 /zOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/lUE4m+DyznItFJFDnCMe2n1wb7C3gTGKXpGnoWKeYzFfF5KHqbKV3lm+NuyDwzotKyNACt84@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGneRhhOHIBUsjDqoZLDVuGKDkqEU4kFQhMnBphFE6N3CT1CIN
 6Hvomxjfsf1G344UNU0fpolRJ1cgE/rmBFtm4iyPx2eX3KPxc5HLMvLrl9F6/nLRiq2254oHshb
 e9XGg/cOIvrSIsjfgOhl6LSFxdjI=
X-Gm-Gg: ASbGncs3MT4BGQuTb9TnNVCqXqLd6rB6DoIIbC2IGUJvwEoJjBspCQlAf2rhfXDNak1
 sLLyRRI6MhzX35SKdvJYOdrojHini8KmcwNe/U3Nev8mQOql3OVyUjD3AH6LIAQ==
X-Google-Smtp-Source: AGHT+IH78dPyIwTy2/Op3e5HbQwmWRHD2N3cIboAsfV2eA8/iuaO05FImKYkiDrqzLXmT9LVwfS3eAnErffocoqK5ZI=
X-Received: by 2002:a17:90b:4ece:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2f782c5502cmr17790776a91.1.1737754875539; Fri, 24 Jan 2025
 13:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
 <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
 <91fb8f7c-f252-40fa-85ca-e77c04a6fd31@amd.com>
 <CADnq5_NY8JLhjWV522u30iY-C90un8cNEgvryHfuZ+moR5vf5A@mail.gmail.com>
 <CAAxE2A6kgb0A8j1H4Cv3EwV-cCV5Pz=sBTReW-RfM9TjxWDreg@mail.gmail.com>
In-Reply-To: <CAAxE2A6kgb0A8j1H4Cv3EwV-cCV5Pz=sBTReW-RfM9TjxWDreg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jan 2025 16:41:04 -0500
X-Gm-Features: AWEUYZmsT9PXc9z6rnImExm7ayvvAxma11od71WDn-W5ixRuowx8iBBgAS1EZxU
Message-ID: <CADnq5_Oa4psu950x9y+9XAXi+g49zhRg-sy7JCHaPA55_+VLgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jan 24, 2025 at 4:34=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> So it's implemented but not enabled by default, right?

Yes.

Alex

>
> Marek
>
> On Fri, Jan 24, 2025 at 12:40=E2=80=AFPM Alex Deucher <alexdeucher@gmail.=
com> wrote:
>>
>> On Fri, Jan 24, 2025 at 12:38=E2=80=AFPM SRINIVASAN SHANMUGAM
>> <srinivasan.shanmugam@amd.com> wrote:
>> >
>> >
>> > On 1/24/2025 10:01 PM, Marek Ol=C5=A1=C3=A1k wrote:
>> >
>> > Does this commit really enable it though? Or is it just for sysfs?
>> >
>> > Yes it enables cleaner shader support not only sysfs.
>>
>> It enables the functionality in the kernel.  It can be turned on or
>> manually run via sysfs.
>>
>> Alex
>>
>> >
>> > Best regards,
>> > Srini
>> >
>> > Marek
>> >
>> > On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam <srinivas=
an.shanmugam@amd.com> wrote:
>> >>
>> >> Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
>> >> isolation between GPU workloads. The cleaner shader is responsible fo=
r
>> >> clearing the Local Data Store (LDS), Vector General Purpose Registers
>> >> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
>> >> prevent data leakage and ensures accurate computation results.
>> >>
>> >> This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
>> >> previously available for GFX10.1.10. It enhances security by clearing
>> >> GPU memory between processes and maintains a consistent GPU state acr=
oss
>> >> KGD and KFD workloads.
>> >>
>> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> >> Cc: Alex Deucher <alexander.deucher@amd.com>
>> >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> >> ---
>> >>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v10_0.c
>> >> index 1878c83ff7e3..938f7d60a0ee 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
>> >>         }
>> >>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> >>         case IP_VERSION(10, 1, 10):
>> >> +       case IP_VERSION(10, 1, 1):
>> >> +       case IP_VERSION(10, 1, 2):
>> >>                 adev->gfx.cleaner_shader_ptr =3D gfx_10_1_10_cleaner_=
shader_hex;
>> >>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_1_10_=
cleaner_shader_hex);
>> >>                 if (adev->gfx.me_fw_version >=3D 101 &&
>> >> --
>> >> 2.34.1
>> >>
