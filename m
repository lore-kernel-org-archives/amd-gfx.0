Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A065C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C5610EB5A;
	Thu, 20 Jun 2024 16:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nu7U4NXg";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2954D10EB5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:51:02 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so10275605ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718902261; x=1719507061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwAcT5u8P6ffQpzLSaZngEI85lZct3umZjUaZoURooY=;
 b=Nu7U4NXgI/gKNLUnsYKwOgU5/LdTKwsI2AEMkrLeU0oS9f+jNXbQPz4ub0wxANu1D1
 Y29qGRdOdAhlwutMm+5RJDvhMOEMaIJbpp0jBHeoStxiN33H487ZBqdML56Yk9Hk/6ld
 IZuoOSqPnK1SOXWgKV/IFndC6MYJ0P1gJFWYqXv/9Hp+XQQzHafqmJAPzihlUfwpWDPH
 vb0lv27h3GcaF9hMt7Y5FJ6m0ErnM/D/5zcXxakdfUpZRcv/EYpvPb5iq6u5DDGFP/D/
 /NmDZrcNKySZ60vY63RT3Yhb79PtR+emondHT6jBW65jdmpGdmAbTZhEH3W7LUUloMZG
 OgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718902261; x=1719507061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwAcT5u8P6ffQpzLSaZngEI85lZct3umZjUaZoURooY=;
 b=vyLYZlOPqN7gP8enMVOL/HC6OzPl7KnKc19kfYEzeKtXE0r24ltmz139XbZztkAbNd
 v3rX4aSEhxFPfD08L0IO+r1GK9SyLQlHkXbFO4xwSgLhPw4szYDId/WcdJHvA03YRgLC
 pHESN+2qCV4usyK4TEvR61gY17KtjkK7VYKDjiweITg0wwiqh7SpWl83Jx4rUBGXM2VI
 CKIRjXzPKtqqB89rebMF/j0SKT28IhEjTnncXRUeBRpJojffohOeXG2qr2IIU+dge1Tp
 nitjKHan/xMU/ZjnKXxYlyvnTZFcutSPjaan/UGW9LGruksKXaWpbLkqhM79yAQOwmEG
 AsAA==
X-Gm-Message-State: AOJu0Yy6X10LMJuyqBmMooZ5EhBi48wMgM6bnfwhK319j/qr0EOU/fK/
 JMrYFa6b8g0nay3QeLWzVakGaYqXBlfABBZozWUkVJYT7e3x6QfuhlEHuA9cBLbznMmVIhfmNio
 2b+s7umt1xjOdTHhZHqRT/pljtHE=
X-Google-Smtp-Source: AGHT+IGiuMPp3tdcG050jdTA1BeKKN/GMn4xoibmAsd8ULF8yd61blRckRbdbMXawdWqFpm+iFI5s0F6H1qk2+2b1+8=
X-Received: by 2002:a17:902:f68d:b0:1f6:3596:7c61 with SMTP id
 d9443c01a7336-1f9aa3bbab9mr65245725ad.2.1718902261188; Thu, 20 Jun 2024
 09:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
 <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
 <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
In-Reply-To: <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 12:50:49 -0400
Message-ID: <CADnq5_OMak3yK6frWXVMHBCdpzg9rTbQAYaB_d4DOrXJ8rRV7g@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 12:07=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> I think the "break;" there is to silence the compilation warning - it is
> ugly but needed.

Which break?  It looks fine to me.

Alex

>
> David
>
> On 2024-06-20 11:38, Alex Deucher wrote:
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Thu, Jun 20, 2024 at 5:07=E2=80=AFAM Jiapeng Chong
> > <jiapeng.chong@linux.alibaba.com> wrote:
> >> No functional modification involved.
> >>
> >> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_sh=
ared.c:3171:2-3: Unneeded semicolon.
> >> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_sh=
ared.c:3185:2-3: Unneeded semicolon.
> >> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_sh=
ared.c:3200:2-3: Unneeded semicolon.
> >>
> >> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9365
> >> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> >> ---
> >>   .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++--------=
--
> >>   1 file changed, 23 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/d=
ml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core=
/dml2_core_shared.c
> >> index cfa4c4475821..1a9895b1833f 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_cor=
e_shared.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_cor=
e_shared.c
> >> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_by=
tes(enum dml2_swizzle_mode sw_mode
> >>   {
> >>          switch (sw_mode) {
> >>          case (dml2_sw_linear):
> >> -               return 256; break;
> >> +               return 256;
> >>          case (dml2_sw_256b_2d):
> >> -               return 256; break;
> >> +               return 256;
> >>          case (dml2_sw_4kb_2d):
> >> -               return 4096; break;
> >> +               return 4096;
> >>          case (dml2_sw_64kb_2d):
> >> -               return 65536; break;
> >> +               return 65536;
> >>          case (dml2_sw_256kb_2d):
> >> -               return 262144; break;
> >> +               return 262144;
> >>          case (dml2_gfx11_sw_linear):
> >> -               return 256; break;
> >> +               return 256;
> >>          case (dml2_gfx11_sw_64kb_d):
> >> -               return 65536; break;
> >> +               return 65536;
> >>          case (dml2_gfx11_sw_64kb_d_t):
> >> -               return 65536; break;
> >> +               return 65536;
> >>          case (dml2_gfx11_sw_64kb_d_x):
> >> -               return 65536; break;
> >> +               return 65536;
> >>          case (dml2_gfx11_sw_64kb_r_x):
> >> -               return 65536; break;
> >> +               return 65536;
> >>          case (dml2_gfx11_sw_256kb_d_x):
> >> -               return 262144; break;
> >> +               return 262144;
> >>          case (dml2_gfx11_sw_256kb_r_x):
> >> -               return 262144; break;
> >> +               return 262144;
> >>          default:
> >>                  DML2_ASSERT(0);
> >>                  return 256;
> >> -       };
> >> +       }
> >>   }
> >>
> >>   const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_b=
w_type bw_type)
> >>   {
> >>          switch (bw_type) {
> >>          case (dml2_core_internal_bw_sdp):
> >> -               return("dml2_core_internal_bw_sdp"); break;
> >> +               return("dml2_core_internal_bw_sdp");
> >>          case (dml2_core_internal_bw_dram):
> >> -               return("dml2_core_internal_bw_dram"); break;
> >> +               return("dml2_core_internal_bw_dram");
> >>          case (dml2_core_internal_bw_max):
> >> -               return("dml2_core_internal_bw_max"); break;
> >> +               return("dml2_core_internal_bw_max");
> >>          default:
> >> -               return("dml2_core_internal_bw_unknown"); break;
> >> -       };
> >> +               return("dml2_core_internal_bw_unknown");
> >> +       }
> >>   }
> >>
> >>   const char *dml2_core_internal_soc_state_type_str(enum dml2_core_int=
ernal_soc_state_type dml2_core_internal_soc_state_type)
> >>   {
> >>          switch (dml2_core_internal_soc_state_type) {
> >>          case (dml2_core_internal_soc_state_sys_idle):
> >> -               return("dml2_core_internal_soc_state_sys_idle"); break=
;
> >> +               return("dml2_core_internal_soc_state_sys_idle");
> >>          case (dml2_core_internal_soc_state_sys_active):
> >> -               return("dml2_core_internal_soc_state_sys_active"); bre=
ak;
> >> +               return("dml2_core_internal_soc_state_sys_active");
> >>          case (dml2_core_internal_soc_state_svp_prefetch):
> >> -               return("dml2_core_internal_soc_state_svp_prefetch"); b=
reak;
> >> +               return("dml2_core_internal_soc_state_svp_prefetch");
> >>          case dml2_core_internal_soc_state_max:
> >>          default:
> >> -               return("dml2_core_internal_soc_state_unknown"); break;
> >> -       };
> >> +               return("dml2_core_internal_soc_state_unknown");
> >> +       }
> >>   }
> >>
> >>   static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
> >> --
> >> 2.20.1.7.g153144c
> >>
