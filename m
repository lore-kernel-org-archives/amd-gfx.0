Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1F0F588DE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 14:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554A610E66B;
	Mon, 20 Apr 2026 14:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LnbDqKgi";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2CAB10E669
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 14:13:59 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso393495eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776694439; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbpT1AUuHccuVz9BJMPps3DzsA4BiOBht4V13Igq376vRgrpMplO78VzQ5WX1pit3F
 3WeGt1yfRcMr1HshN9T3WrRdd3wSr+9ZNU83CKsahXjRvvwuXlahLcl5oueWN7Hd0Es0
 uwka917wwLs+C6exIoY0MPNvHTHTsd/smKM0TRk5+k864jsfV/qSK1mC8dORvPkKViPc
 qmNznSJFpkVLq25yRKy5N57WJ82erEQH3yzVWtWxnpcUQMp6r6xzxLfY/NTeqZ8YuM2R
 bRGlH1XgsZgcVA4fcCPhfsqZW7CfyVv6hVPWq5gIPNaspj5ITq+CFWYmBuAc+rDGVVcI
 DtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 fh=5MIwGJEwjviyNMWj3YtKTrtn1spn0TV9edMQ86er9aM=;
 b=N67bhYdP+RClQKxuwKbRDf/vZzDHAk1xhn9Ibed7tVX8xMVwCY81HQR0NtBdT+s4te
 N2w7A2cI6iDwiJUsxrq42DZtLdIE3FS5y7EtU0aCRIp4qPbkJPO3rCJMLm5yYTUDmqz1
 9ml0dDnx9MEGUtIJe75pl423WH7xdTv9WJU2Y0meEhLMTnaZIv+jtPCqIHg2KVthfffC
 g2C4AnzF9WmXBuzfQ4FMihpjWWacJR/0KRayiAnqsKXlQlymcs1uMxlSbkSpJwokagFD
 Fd1IYeEiTH5rTUe37Kg07bWaTurW7wdVbEAaQ32aCPGWDYcEhOJHzNB+44IzwsSQ9MEn
 Y2/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776694439; x=1777299239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 b=LnbDqKgiGrndxNVJti7Ge16wGm+/hHexjcjdJjPgZn+fGDpOguH/YMG3P+eXeTP8FS
 kxAGL11lye+zgQt5WnWVWpQGs7EaRGoiyyp7xD98rE10pBURw7OA+iu6nPJjf1S/QVZ6
 29QepGYY6ush0+1l/6pjmNIu3ncpqvQhIub9EKzEWBcvk/BX3fsNepGWOKR2CQ7cv/JD
 5GQ8tUk4XW3QfxpU0Oty/Ox9PHiRKqQ9Kh8XWHsCq+YR6po7GPxrdbkad2x2LHzIIgma
 xFEtsw6ebF3/wpvmavvPI+RfotpBeNH2iInxdjySx6WMXsjFT3fULShUlcjij7dSu/KY
 v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776694439; x=1777299239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 b=dhPWxVt9sq4dGfkKu9dwfaROgEfDJFDPRXbb5MaF56gULcE8NLj7WDbxxsk85tiN1/
 BBJ7Cko3EufHwukeDq/Fpq4XKFDorsmZFSs0776CzQ8LFQyWDfy9i8OYPAhPy0Indugw
 JPLptFiWFxbuhcVsUHDTySpYADj/2rsyjAo3VYUEjheMOHOCv1LIAA01FI6DmnRhLuqM
 u4mZGEoRE4vXRGKEbg2sEBQQ98c0X9JH7DTW5HojsrztSTXKFs+8DQ9j6NUENnV/5oBW
 9IXehUjvXhrLx9zFAZESrTzvFPjJVKnnP6dZPqc48ClpSh9PC6DWsYSUCG3/gJdOE0Bf
 mmVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fA69yhZKTtAltQTq+CQK3/G9Je4r+vbCiBKlT9ZEY2RGTDft7UH7pYY1e6wz/W+17/UDYNNri@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvhDx/fMGCNxw4wUtIiXoQy6v3tBFW6Vyw1+nTP5KbRM7H+ZKJ
 afl5UhTqenPcgrHAfVvuJqqS0pokEPP2r0VWTmNg7SRCVwz+afjHrq0fUekJahemYFUFcD18ipO
 aBH/lPoa3YQ+16XZ6UZiBH2fADzY/WkQ=
X-Gm-Gg: AeBDietGPt9oriRgF56gq8/b6WhFIrww6Sm0WH4uggG+Wj6wDtQZ0Z9oWjgFTUUGwoe
 EfXZ3xDiQZPfPKstTiT4+lgJaawsYFzH7DGlbA4Qn7nVfAGI/wByVYBZDNGOmiYoXqmo+za+4+X
 7AtiEQ1sleC/yG9uvCxZHaERk+WGZFL4w909XW0HT89d2vbJ58IJbMc5Tz9bkyE25yfVhrXVZ+E
 vCpIcQwAukN5mIJeHBvGB2A8rSQ6izCIl1ybEyQqCbozk41+MJ1Lftm8+9t/i3eKa0IXKmBeASt
 qI+Vzn8Yh58/WDsxvQVsqvsfEkPxDczKtA2+SW/4hqgtZC83fR1quRPTdUaaLKhX10GBufPW0kp
 RhsFH
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr2635816c88.0.1776694438767; Mon, 20 Apr 2026
 07:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260417213221.937722-1-mjgajda@gmail.com>
 <43120d24-2b69-4038-9540-dc204c75a14d@amd.com>
In-Reply-To: <43120d24-2b69-4038-9540-dc204c75a14d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 10:13:47 -0400
X-Gm-Features: AQROBzDE_MPDw_jDdkeLrsu71yoHraxPuk43vC4IBtnWXH1xEiFdYBv6eUf2-co
Message-ID: <CADnq5_OwGSGzSAZp=H1P2N+iePiVND9+1CD3Zf34oC5E8zzcwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: mjgajda@gmail.com, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, dri-devel@lists.freedesktop.org
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

On Mon, Apr 20, 2026 at 5:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/17/26 23:32, mjgajda@gmail.com wrote:
> > From: "M. Gajda" <mjgajda@gmail.com>
> >
> > GC_THROTTLE_STATUS is a read-only hardware status register present on a=
ll
> > RDNA GPU generations (GFX10/11/12).  It reports the state of the GFX
> > thermal throttle finite state machine:
> >
> >   FSM_STATE    [3:0]  non-zero =3D GPU currently being throttled
> >   PATTERN_INDEX [9:4]  active throttle duty-cycle pattern
>
> Mhm, according to AMDs internal register documentation that one is not av=
ailable everywhere.
>
> My educated guess is that there is actually some SMU function you should =
call to get this information.

This is already available via the smu metrics table.  I suspect this
register is probably just a scratch register anyway since it's FW
which handles the clocks, not the HW and as such, I'm not sure it
would even get updated.

Alex

>
>
> > The register is never written by the driver.  No side-effects occur on
> > read.
>
> Oh that is not correct at all. Reads can have tons of side effects all th=
e way to a spontaneous system reboot!
>
> > Add it to the per-ASIC allowed_read_registers[] tables so that
> > unprivileged userspace can query it via the AMDGPU_INFO_READ_MMR_REG io=
ctl
> > (libdrm: amdgpu_read_mm_registers(3)).
> >
> > This enables monitoring tools such as radeontop to display GPU thermal
> > throttle status without root privileges -- information of the same
> > sensitivity class as GPU temperature, which is already exposed via the
> > AMDGPU_INFO_SENSOR_GPU_TEMP sensor ioctl.
>
> Yeah, but that one asks the DPM functions to talk to the SMU to get the r=
equested data.
>
> That is clearly something completely different.
>
> Regards,
> Christian.
>
> >
> > Register offsets per generation:
> >   GFX10 (RDNA 1/2): mmGC_THROTTLE_STATUS  0x2032  BASE_IDX 0
> >   GFX11 (RDNA 3):  regGC_THROTTLE_STATUS  0x1b0a  BASE_IDX 1
> >   GFX12 (RDNA 4):  regGC_THROTTLE_STATUS  0x1b1c  BASE_IDX 1
> >
> > Source: drivers/gpu/drm/amd/include/asic_reg/gc/
> >   gc_10_3_0_{offset,sh_mask}.h, gc_11_0_0_{offset,sh_mask}.h,
> >   gc_12_0_0_{offset,sh_mask}.h
> >
> > Public ISA documentation:
> >   RDNA 1: https://developer.amd.com/wp-content/resources/RDNA_Shader_IS=
A.pdf
> >   RDNA 2: https://www.amd.com/content/dam/amd/en/documents/radeon-tech-=
docs/instruction-set-architectures/rdna2-shader-instruction-set-architectur=
e.pdf
> >   RDNA 3: https://docs.amd.com/v/u/en-US/rdna3-shader-instruction-set-a=
rchitecture
> >   RDNA 4: https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architec=
ture
> >
> > Signed-off-by: M. Gajda <mjgajda@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 7ce1a1b95..80594c793 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -352,6 +352,12 @@ static struct soc15_allowed_register_entry nv_allo=
wed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x2032): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_10_3_0_offset.h / gc_10_3_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, mmGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index fbd1d97f3..8c2472bd0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -304,6 +304,12 @@ static struct soc15_allowed_register_entry soc21_a=
llowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x1b0a): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_11_0_0_offset.h / gc_11_0_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..617ee0a4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -130,6 +130,12 @@ static struct soc15_allowed_register_entry soc24_a=
llowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x1b1c): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_12_0_0_offset.h / gc_12_0_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > --
> > 2.51.0
> >
>
