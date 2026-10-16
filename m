Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D7CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B8310E023;
	Fri, 16 Oct 2026 13:25:50 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF63010E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:25:43 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-150b2fbd784so257793c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792157143; cv=none;
 d=google.com; s=arc-20260327;
 b=GgeYhm2473l4FKf54gKQT5bahVxeVIfLNLztUwQe3g4SbkIPaxkVOKlsnARz6xa1fD
 jzy+TeRy1nFhPX/mKY/kzR+XK/FCfhJAZHzOBLSQ6oq1Z0NUOoz9r45Rg/osavsy4pyV
 DFOq9HhmL74ND6tlS5h8lOsemSui261qLrdXlGwtkiDUTlNIqIhhXwHx+jaLGv2QNd0d
 7Y8eat+94J+l404ShZnA7UqUUqjuIlbPJofFYcV/U+GxTmwOgD4K7kdxtplr8w1siDTu
 lzON1AiBArPJcVJfd3FsnAiZD9yaxRFWxvgNzjLGh1V+29yVEUtWds2oxyysr7tiYE/V
 Fs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bediDoorgtzZnvpbMRu1ifY2I30i39Gb7j2T7qtJrsk=;
 fh=I+9AfXZpwjzmmFEKAqU8ufa0Dkh/CnseoLKPAXkyuTE=;
 b=JWpTUA8vI2UthZpZ0Ag6PDl+HmZ6cDdybAD2pWCFgXQeS4+dyh9pBQUEG1URFUtPIW
 RqInjp0Q5WzwkoAIx1VFIUc3CMdsxGZcfvR6QoNyLVqlBouTCCIsu3yU5Z2tC8OfpI9f
 f9p5gZCbPCNWm13Ihi07UMNT4L9XnM8tmzdnb1Pg5eRJvPGBWLmeOReCyzEtEDL2LUX3
 a8F8af05RPwSVZiNvgLDXvpMUA8nLOu9R+2y4R5xZggKGWMuQvy9R0aqxOeNrMoy+LLc
 HmDf3AhA9a0X7gsUrP1zZ61GYXYL15o/1KjLhCt4yov/PfZ6tgGngRbzO8DHy0XCe84o
 s/kA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792157143; x=1792761943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bediDoorgtzZnvpbMRu1ifY2I30i39Gb7j2T7qtJrsk=;
 b=pMrY97VSGUKdwCrBfJEFFy+vyk8Ym2lfik6DyoFdGchnjV7uWjQhkFHK9LGaqvfcHB
 GsiShDL8x9oTvVQjvGQ0Egp7uWeMPWct4soEepkBDymQHwKKLCDiCuLPGppZ7fpKmJVf
 Og5OByyQQtCqhj4MSO6Tl/0LsMU47Huy2DfSinuHjvCJN12hyNk9IXplEJnehcK00gQP
 2QFAUbJLWdeG688NH+Y30h38/hDkIE6w4DJOWB2lFyK3d6pIRW5k14kfTQI8JrPl3h1O
 ka+7SdkxP9gRa8LqrY1RwkCif+e8yVgHLsq3jJAei4V/5wJ9ESEoumIrQaKHdHfY4u7E
 9LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792157143; x=1792761943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bediDoorgtzZnvpbMRu1ifY2I30i39Gb7j2T7qtJrsk=;
 b=dIQXvngNTJOKDAy72y+lcz/mu0LJ8+rCa28vs4ar0kYGdfBAEGRuOIBaQHwMaOOHLL
 AERiAuypIRDHko9lGW6sj3gWSPJEI1t4ukF5JqgyYQXCJyMXjjPpWMLQjP32wDGwt3Cv
 dTSx6hKMKVN12gM4LWY80MjqF8EW92GTjoUag9bMgnUioG2eZaGHbS6rJW873sMqhO8G
 MkZCZplMqFicS31Ucp41OTfFkBte0P+rfNMECG+KgdETdIit3VlBUoLchirZkhwaNP+T
 VCMOenQhuDdGLqYGuQdtaui8ulQK6iqP9db3W3z3oaZnNPmLLLSDFA1O4Q7RSaOzfDDf
 6CnA==
X-Gm-Message-State: AFq9FYJirIPK+Ef/b6sJ/uvb6axqTlv8mhkQs5VsOFyp9aPtd5ScogZA
 PnccqszDl4/U6AI4y4b653VR4V3y/y3mWle/M6wyak8tgyH+BCjqR3RPSu95vRDg2Vdvb2N7LRU
 NLYgoduMN5pe5P/66xljidjKFsaMrOxk=
X-Gm-Gg: AYBFou2UIb7J4jiu6Po6C9Mn95RxhIkz1IGuTU4Rdj7DsVchM3zHV3S60nImmwENXgM
 gfSXofTxD5oB+ZpplMimqcRnFXC1/V/omJBka9s1AFiPYz+0WQIaMSSwx6rOL5t996YxQi37S4a
 4BKqLUgXBTqYD91xVB9uHcZATtROG1BVkoec4Pw98xWpy6cjopjmCEJn/nLbeyaEb1sznhsEVEx
 CPpp8/qUj4/qjhoNnRLUh3X8TR93QCf0hETX+GBaHu0tNWeKCG+HturtHBoUinRxgh0lHlA5hRZ
 KJ5hkJgj0Oywazto9/OtznELn1oFSXCHUzejg3pMQ69sO5pveG5LR8Eqo5jOqyR/8n7nGWo75pv
 scJwtlliSQfMygSe0tiamUttlRUeqqKuREbpD5IXyjesmIthszqn2
X-Received: by 2002:a05:701b:2310:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-17f641e849cmr12184812c88.1.1792157142959; Fri, 16 Oct 2026
 06:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261016095224.461911-1-Victor.Zhao@amd.com>
 <20261016095224.461911-2-Victor.Zhao@amd.com>
 <CADnq5_MKWAwEZJTH8-9ssPjxBi5VewAQdcPyqgaCyhgt8fa3Rw@mail.gmail.com>
In-Reply-To: <CADnq5_MKWAwEZJTH8-9ssPjxBi5VewAQdcPyqgaCyhgt8fa3Rw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:25:30 -0400
X-Gm-Features: AclHuK-V8o_iAKL2voKzQWH_olkYEYAUAmahaPztwCcV4ggrUr8O_nD5MBXJYHA
Message-ID: <CADnq5_OYgJcERMrTSSckm1ftSM92-fP8vB71+Yiyby12TvfnKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo.Lazar@amd.com, 
 Alexander.Deucher@amd.com, Davis.Ming@amd.com, Gavin.Wan@amd.com
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

On Fri, Oct 16, 2026 at 9:24=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Oct 16, 2026 at 6:11=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com>=
 wrote:
> >
> > [why]
> > GFX12.1 VF timestamp queries need a SMUIO Golden TSC sample, but
> > direct SMUIO MMIO access is restricted on VF.
> >
> > [how]
> > Read the consecutive SMUIO Golden TSC upper and lower registers with
> > amdgpu_mes_rreg64() on GFX12.1 VF. Swap the returned dwords to
> > reconstruct the counter value.
> >
> > v4: use SMUIO Golden TSC for GFX12.1 VF timestamp queries
> >
> > Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index d6f70d33201a0..93c8f8e449bf4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -37,6 +37,7 @@
> >
> >  #include "gc/gc_12_1_0_offset.h"
> >  #include "gc/gc_12_1_0_sh_mask.h"
> > +#include "smuio/smuio_15_0_0_offset.h"
> >  #include "soc24_enum.h"
> >  #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
> >
> > @@ -3168,10 +3169,35 @@ static int gfx_v12_1_wait_for_idle(struct amdgp=
u_ip_block *ip_block)
> >         return -ETIMEDOUT;
> >  }
> >
> > +static uint64_t gfx_v12_1_get_smuio_gpu_clock_counter(struct amdgpu_de=
vice *adev)
> > +{
> > +       uint64_t clock =3D 0;
> > +       uint32_t reg;
> > +
> > +       if (!down_read_trylock(&adev->reset_domain->sem))
> > +               return 0;
> > +       if (amdgpu_device_skip_hw_access(adev) ||
> > +           !adev->mes.ring[0].sched.ready)
> > +               goto unlock_reset;
> > +
> > +       reg =3D SOC15_REG_OFFSET(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
> > +       if (amdgpu_mes_rreg64(adev, reg, 0, &clock))
>
> I don't see this function in the current tree.  Are you missing a patch?

Nevermind.  I see it now.  Stupid gmail keeps blackholing mailing list emai=
ls.

Alex

>
> Alex
>
> > +               goto unlock_reset;
> > +
> > +       clock =3D (clock << 32) | (clock >> 32);
> > +
> > +unlock_reset:
> > +       up_read(&adev->reset_domain->sem);
> > +       return clock;
> > +}
> > +
> >  static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *=
adev)
> >  {
> >         uint64_t clock =3D 0;
> >
> > +       if (amdgpu_sriov_vf(adev))
> > +               return gfx_v12_1_get_smuio_gpu_clock_counter(adev);
> > +
> >         if (adev->smuio.funcs &&
> >             adev->smuio.funcs->get_gpu_clock_counter)
> >                 clock =3D adev->smuio.funcs->get_gpu_clock_counter(adev=
);
> > --
> > 2.50.1
> >
