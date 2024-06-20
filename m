Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670C5C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 17:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD39010EB65;
	Thu, 20 Jun 2024 17:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dC3gpyo7";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20CA10EB65
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 17:22:04 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-1f862f7c7edso10051525ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718904124; x=1719508924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zro6oG9bVwZWtzMPy0fXphg6ld9fCaW1GKgBTtaMEXk=;
 b=dC3gpyo7uFQh49WXzwQiDiBfHns5MVuY5upwahrN1JAE/E5I3WhMYwkm9p1b5iTPBJ
 5yvxAgBzKqV6GfsDucy6c9orEjoeMuV0c01hbcRYvYDi6JssivA0Wdw2M+fc3dglDPRm
 BFxPB8ctQqkMEK3sRqdFMep0schk472ozrQ933BJ2spnm6MIQCl+EDV5qpKRau6epFyv
 HicKDrTZ0W+jjXGu1LWvORJbZD7PSW6yWawTzxodh8w0LaRvx+BPeI6MLOmnfUU0IBg4
 ezOmn7MiRmVkCd+EbUtoYGb+zg6N9LCL2QdVRVgQg23By4PR7d6/LJdcQVzoxCxz6vgi
 8Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718904124; x=1719508924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zro6oG9bVwZWtzMPy0fXphg6ld9fCaW1GKgBTtaMEXk=;
 b=uxu5AN+HXTl8WbfuLBuMurm0+RJdVMYpyDyX++goPFUDCTTyYBWJ0xWfFygXrXLDzI
 pR6LT/YBHG/0AyxWxv+nri9VQeNFD0DGXQ+fpCyh0eB0ezdfw4ce4zWmD2rbObM7eQrw
 pnE9kF1UYNUodKhGt/pDPDFC+auUqViZo7SIbGezMzrrJRF/CZVgcY5nteFrz5x17AAg
 k4M3QzKifiseAnv3zhYamYRfwV2t89+nBSxtjreji0alXybiTch3V9J8ue9EHAF/h6lI
 sc+wJ5J2jQ1SN/AroKr1VozhxuA/ougmG5l4wNE52ZkDIkaxOF851u5OH+7SDF5LsAbz
 mupg==
X-Gm-Message-State: AOJu0YyOWREUFWfG+D4Fmu8oNjJuH2dQNOd0C7zKFnPXUi7GPbvV2Omh
 aVRNQ+T7Z3myrofbfB71kIC9GirnK5CmqgeR9B9BNZx0BYib+294X7r1aqLf7BFPS3A29maoRhg
 Op4JoSbeJG+C1rM6MuG5VdOHpXt6EAQ==
X-Google-Smtp-Source: AGHT+IGFpzU46HFyVGSLHf5gIZkwtGozoAODSnS8ofFm1I3Rlyc1OYKY5YLWnXNcGHZNpLpo+XfZtKaT0dD+E50VSwU=
X-Received: by 2002:a17:902:d4c7:b0:1f7:243d:821f with SMTP id
 d9443c01a7336-1f9aa3f63f5mr57289365ad.35.1718904124033; Thu, 20 Jun 2024
 10:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
 <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
 <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
 <CADnq5_OMak3yK6frWXVMHBCdpzg9rTbQAYaB_d4DOrXJ8rRV7g@mail.gmail.com>
 <8f42df03-54ff-49a7-a25c-581e379a9837@amd.com>
In-Reply-To: <8f42df03-54ff-49a7-a25c-581e379a9837@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 13:21:51 -0400
Message-ID: <CADnq5_Pc-+uQJY1F7ia=s9xfpTur5OFPg0iOK9gJaYZo7uf1Uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant code and semicolons
To: David Wu <davidwu2@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jun 20, 2024 at 1:18=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> see inline, please
> David
>
> On 2024-06-20 12:50, Alex Deucher wrote:
> > On Thu, Jun 20, 2024 at 12:07=E2=80=AFPM David Wu <davidwu2@amd.com> wr=
ote:
> >> I think the "break;" there is to silence the compilation warning - it =
is
> >> ugly but needed.
> > Which break?  It looks fine to me.
> example here - code is fine but the compiler will complain about missing
> "break" for case statement.
>
> -               return 256; break;
> +               return 256;

It shouldn't.  Actually a number of checkers will complain about
having a break after a return.

Alex

>
> >
> > Alex
> >
> >> David
> >>
> >> On 2024-06-20 11:38, Alex Deucher wrote:
> >>> Applied.  Thanks!
> >>>
> >>> Alex
> >>>
> >>> On Thu, Jun 20, 2024 at 5:07=E2=80=AFAM Jiapeng Chong
> >>> <jiapeng.chong@linux.alibaba.com> wrote:
> >>>> No functional modification involved.
> >>>>
> >>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_=
shared.c:3171:2-3: Unneeded semicolon.
> >>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_=
shared.c:3185:2-3: Unneeded semicolon.
> >>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_=
shared.c:3200:2-3: Unneeded semicolon.
> >>>>
> >>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9365
> >>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> >>>> ---
> >>>>    .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++-----=
-----
> >>>>    1 file changed, 23 insertions(+), 23 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core=
/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_co=
re/dml2_core_shared.c
> >>>> index cfa4c4475821..1a9895b1833f 100644
> >>>> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_c=
ore_shared.c
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_c=
ore_shared.c
> >>>> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_=
bytes(enum dml2_swizzle_mode sw_mode
> >>>>    {
> >>>>           switch (sw_mode) {
> >>>>           case (dml2_sw_linear):
> >>>> -               return 256; break;
> >>>> +               return 256;
> >>>>           case (dml2_sw_256b_2d):
> >>>> -               return 256; break;
> >>>> +               return 256;
> >>>>           case (dml2_sw_4kb_2d):
> >>>> -               return 4096; break;
> >>>> +               return 4096;
> >>>>           case (dml2_sw_64kb_2d):
> >>>> -               return 65536; break;
> >>>> +               return 65536;
> >>>>           case (dml2_sw_256kb_2d):
> >>>> -               return 262144; break;
> >>>> +               return 262144;
> >>>>           case (dml2_gfx11_sw_linear):
> >>>> -               return 256; break;
> >>>> +               return 256;
> >>>>           case (dml2_gfx11_sw_64kb_d):
> >>>> -               return 65536; break;
> >>>> +               return 65536;
> >>>>           case (dml2_gfx11_sw_64kb_d_t):
> >>>> -               return 65536; break;
> >>>> +               return 65536;
> >>>>           case (dml2_gfx11_sw_64kb_d_x):
> >>>> -               return 65536; break;
> >>>> +               return 65536;
> >>>>           case (dml2_gfx11_sw_64kb_r_x):
> >>>> -               return 65536; break;
> >>>> +               return 65536;
> >>>>           case (dml2_gfx11_sw_256kb_d_x):
> >>>> -               return 262144; break;
> >>>> +               return 262144;
> >>>>           case (dml2_gfx11_sw_256kb_r_x):
> >>>> -               return 262144; break;
> >>>> +               return 262144;
> >>>>           default:
> >>>>                   DML2_ASSERT(0);
> >>>>                   return 256;
> >>>> -       };
> >>>> +       }
> >>>>    }
> >>>>
> >>>>    const char *dml2_core_internal_bw_type_str(enum dml2_core_interna=
l_bw_type bw_type)
> >>>>    {
> >>>>           switch (bw_type) {
> >>>>           case (dml2_core_internal_bw_sdp):
> >>>> -               return("dml2_core_internal_bw_sdp"); break;
> >>>> +               return("dml2_core_internal_bw_sdp");
> >>>>           case (dml2_core_internal_bw_dram):
> >>>> -               return("dml2_core_internal_bw_dram"); break;
> >>>> +               return("dml2_core_internal_bw_dram");
> >>>>           case (dml2_core_internal_bw_max):
> >>>> -               return("dml2_core_internal_bw_max"); break;
> >>>> +               return("dml2_core_internal_bw_max");
> >>>>           default:
> >>>> -               return("dml2_core_internal_bw_unknown"); break;
> >>>> -       };
> >>>> +               return("dml2_core_internal_bw_unknown");
> >>>> +       }
> >>>>    }
> >>>>
> >>>>    const char *dml2_core_internal_soc_state_type_str(enum dml2_core_=
internal_soc_state_type dml2_core_internal_soc_state_type)
> >>>>    {
> >>>>           switch (dml2_core_internal_soc_state_type) {
> >>>>           case (dml2_core_internal_soc_state_sys_idle):
> >>>> -               return("dml2_core_internal_soc_state_sys_idle"); bre=
ak;
> >>>> +               return("dml2_core_internal_soc_state_sys_idle");
> >>>>           case (dml2_core_internal_soc_state_sys_active):
> >>>> -               return("dml2_core_internal_soc_state_sys_active"); b=
reak;
> >>>> +               return("dml2_core_internal_soc_state_sys_active");
> >>>>           case (dml2_core_internal_soc_state_svp_prefetch):
> >>>> -               return("dml2_core_internal_soc_state_svp_prefetch");=
 break;
> >>>> +               return("dml2_core_internal_soc_state_svp_prefetch");
> >>>>           case dml2_core_internal_soc_state_max:
> >>>>           default:
> >>>> -               return("dml2_core_internal_soc_state_unknown"); brea=
k;
> >>>> -       };
> >>>> +               return("dml2_core_internal_soc_state_unknown");
> >>>> +       }
> >>>>    }
> >>>>
> >>>>    static bool dml_is_vertical_rotation(enum dml2_rotation_angle Sca=
n)
> >>>> --
> >>>> 2.20.1.7.g153144c
> >>>>
