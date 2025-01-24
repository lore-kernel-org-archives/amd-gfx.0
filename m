Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC68C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 17:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3425610E14B;
	Fri, 24 Jan 2025 17:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGFTsVds";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCA110E14B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 17:40:05 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21a0374a1fcso5409855ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737740405; x=1738345205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+gT5Po8V55YV1eOXlAYnneU0NPJQDBA400uRwosKeY=;
 b=cGFTsVdsR2Bzgdh8HOmAf1/5DFrcd9jfQ8TK+w6tObKsHiF/NsPnieTrdSfRTDjOTK
 XvcqBlWyvbhuoEkiPmPHvSmyszbHeNCRlLu5oDh6hiQ3/AMPdIVpWLHtYFI2mTs/hl6l
 ZckqdfGlrfMSg4xVW67fV1nivdjikEg8T706konA4nGv13ky/EVIgT6f+ah0Z9GfJBhi
 v3DNpEouNlF/WCvTjJRqDrv7y4SxpODFajEVp6fHYM1PkBfT+boBfXjraVlMYwEY1489
 oQNw3RC0AcazwCPbzs86JeBDvzbw/29ia81Zb4QovfZJxLRzEbFJKzCgB/JzXnaK6v77
 lBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737740405; x=1738345205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+gT5Po8V55YV1eOXlAYnneU0NPJQDBA400uRwosKeY=;
 b=PB28Yod88VUUxreVDzxlDrW3LEATz2ToZ4g6izEsGO1uepYJOOjzVqCArI8Li5IDa8
 cQNb9dYb/63YVwypEHFJO2Zrmza4BWqOau9tuej3PZqLWhk0ozYvW1cVVDE2Hqzzibe8
 AzHwDYsEob90ictBeGWv6Y0dMQu+YKfPi+HpDucdHecBvduNm9FKAHfQsHBC+OoYnNa0
 psd6k+y3vmp6AASfO4QQAIiWzsC4As8dySYw5o/vYAH6cons+urK98WfEGv2wv6z0UQ3
 8165Ll2v9hkstvc5kGI1EnO9zvPTZj4uI9DlFXw6ERozf9FdS17AFCrslyXHlQ/cixF0
 rpXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO+1pK4xZSAlxDd+kQGkuuw9e9yfbqbdz7rDtip92dNeR3e72EiIqR0oPmnSRGUXGj+TQYgPOt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytJwZpHrRe08mfvHpNjprP8GvwJlRBhcyUgDmIAVGtpOHFiTbB
 6Uhs+kiRCkqbCISfk1MDE5J/C44qWqrqIBx+e8Q/qjeFH3bi0Zob74R7QsOAGOiM8Y72dMx0rxL
 Ac8oZtEvnS5O7v/uOpLWZRl7KG7c=
X-Gm-Gg: ASbGnct6SUUate4s+lTo3zXrQ4bBXfEUPpfeTFB3uhggxtGoTpSCaAw8Yg65kNa5Tt2
 HMyMVfmMS/3xoJQ65nxNXODcnLneuFUDotEl8ra5OwPaSXN/AqSlVIGhv5prUew==
X-Google-Smtp-Source: AGHT+IG4QFED+yJuPU5N+UnBRYCBiOmCsf1dy5RkqYzJ4N/WjYI18qeZwpDKuLdwN8x9HkqJwpgFrSaOdXnqPuPAVLM=
X-Received: by 2002:a17:902:c401:b0:215:9a73:6c4f with SMTP id
 d9443c01a7336-21c355baf7dmr177642555ad.6.1737740404977; Fri, 24 Jan 2025
 09:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
 <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
 <91fb8f7c-f252-40fa-85ca-e77c04a6fd31@amd.com>
In-Reply-To: <91fb8f7c-f252-40fa-85ca-e77c04a6fd31@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jan 2025 12:39:52 -0500
X-Gm-Features: AWEUYZlm6of1YX33sNo7G3j1bI7aRulNqrc_qXYxuBF-OjR3PVQZiHGQTqgtxIM
Message-ID: <CADnq5_NY8JLhjWV522u30iY-C90un8cNEgvryHfuZ+moR5vf5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
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

On Fri, Jan 24, 2025 at 12:38=E2=80=AFPM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 1/24/2025 10:01 PM, Marek Ol=C5=A1=C3=A1k wrote:
>
> Does this commit really enable it though? Or is it just for sysfs?
>
> Yes it enables cleaner shader support not only sysfs.

It enables the functionality in the kernel.  It can be turned on or
manually run via sysfs.

Alex

>
> Best regards,
> Srini
>
> Marek
>
> On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam <srinivasan.=
shanmugam@amd.com> wrote:
>>
>> Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
>> isolation between GPU workloads. The cleaner shader is responsible for
>> clearing the Local Data Store (LDS), Vector General Purpose Registers
>> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
>> prevent data leakage and ensures accurate computation results.
>>
>> This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
>> previously available for GFX10.1.10. It enhances security by clearing
>> GPU memory between processes and maintains a consistent GPU state across
>> KGD and KFD workloads.
>>
>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v10_0.c
>> index 1878c83ff7e3..938f7d60a0ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>>         }
>>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>         case IP_VERSION(10, 1, 10):
>> +       case IP_VERSION(10, 1, 1):
>> +       case IP_VERSION(10, 1, 2):
>>                 adev->gfx.cleaner_shader_ptr =3D gfx_10_1_10_cleaner_sha=
der_hex;
>>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_1_10_cle=
aner_shader_hex);
>>                 if (adev->gfx.me_fw_version >=3D 101 &&
>> --
>> 2.34.1
>>
