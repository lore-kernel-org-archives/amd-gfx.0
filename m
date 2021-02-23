Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 11:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2186460202
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 11:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2186460202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F7A6E400;
	Tue, 23 Feb 2021 11:49:05 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358966E400
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 11:49:04 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id x198so7225430vsc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Me2e3ywtBHnO6/7juDAPtP+nwLLdOPCAX04CBXi8Re8=;
 b=KvYbgePsyQtBoxligqzEnypB87FBrhEy5Y6vYHcxqTmMDTgrbKjylwEvXW7M/k8z6T
 89G7FzS2QgM1fyOl/nA/IFJ51PvA6QjS9AYWXqV92M4nglBOte8/fxVOxdqOE8UoTeYI
 nUCbpmMoocT5nYZi/FqHBTIOdy0OkOh5QNp4uXS5UUkaHHQK3aQvnGwDRW4w4pQDZZ9H
 /h22pOH7N/WDQZMi3kkB83rOZi6cgkn5MxZzcu9IhrTQjIu9r9fd78LpRibnr8RAFIYa
 sChR/yMNNuDTFCX8OWK3rJ4Pn24WftbvI6kBPfut2tu0tainpAaaNKTqp3PDlAnMrplC
 ZXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Me2e3ywtBHnO6/7juDAPtP+nwLLdOPCAX04CBXi8Re8=;
 b=PnsLW8ML4Dya9tlGyujfRNeXhcKU7q877y2RwRQNVNICuD5Q8c1P/ES/ctr1Nk9Vw9
 u2ZPYgcqUR7CyxahwUZa2pqGWMds7ppQA7o4G2B7jV6Wl+rlUvEXP4MFuXTKqMVJk5Pi
 6Vd5fjmpojsQcQf9Eg4FzaaLATiX50QVgVg6/31VOTe0v2AYObvmNSMj5RyQKg/8DY4W
 EzOQG5iLG3vmc/TLJPXOeRkllVfxfIbYeNL2it/CRRrNOfWjK59xAr0CrD4OWNxcuUxD
 yBaYPi/Nzg19nEidZSQN8+zxK8auatFooGS5Op3zz4nJBPChw4gtKdPPUYzc3DnTVsVM
 TbyA==
X-Gm-Message-State: AOAM531hhO7B/dYlzpmoh9c6Tq//CHh5ANXXDWcOcJiYpKxZOLtq/SLZ
 G2QCs4xj/SCyAIqmbdvJxapeoNmcUoKxkJeM9gg=
X-Google-Smtp-Source: ABdhPJwQHTQaBVcbk+sg7bkoMyF/FrslcHNc7zXiLFXUnQ2LOMZEYJ7HKmxIMdunRsdm9jd10CFo/87mYcQpsdtJynI=
X-Received: by 2002:a05:6102:116d:: with SMTP id
 k13mr15671522vsg.19.1614080943223; 
 Tue, 23 Feb 2021 03:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20210222040329.1280956-1-evan.quan@amd.com>
 <CADnq5_PzDTq-499hdRQ-VL4PCPaWafMS-a-eE-Xg-83gaXrCnw@mail.gmail.com>
In-Reply-To: <CADnq5_PzDTq-499hdRQ-VL4PCPaWafMS-a-eE-Xg-83gaXrCnw@mail.gmail.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Tue, 23 Feb 2021 06:48:52 -0500
Message-ID: <CAAzXoR+fNnTO8-kAcy67aY-oseCVr3XHbRJtYV-MTc1=yafbXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1514982311=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1514982311==
Content-Type: multipart/alternative; boundary="0000000000004276a805bbff811a"

--0000000000004276a805bbff811a
Content-Type: text/plain; charset="UTF-8"

This is why I advocated for the sysfs output to be either standard packed
or serialized.  It was a hack as it is anyways.

On Mon, Feb 22, 2021 at 4:46 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Sun, Feb 21, 2021 at 11:03 PM Evan Quan <evan.quan@amd.com> wrote:
> >
> > To make sure they are naturally aligned.
> >
> > Change-Id: I496a5b79158bdbd2e17f179098939e050b2ad489
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
>
> Won't this break existing apps that query this info?  We need to make
> sure umr and rocm-smi can handle this.
>
> Alex
>
>
> > ---
> >  drivers/gpu/drm/amd/include/kgd_pp_interface.h        | 11 ++++++-----
> >  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                |  4 ++--
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  8 ++++----
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  8 ++++----
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  8 ++++----
> >  5 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > index 828513412e20..3a8f64e1a10c 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -332,9 +332,9 @@ struct amd_pm_funcs {
> >  };
> >
> >  struct metrics_table_header {
> > -       uint16_t                        structure_size;
> > -       uint8_t                         format_revision;
> > -       uint8_t                         content_revision;
> > +       uint32_t                        structure_size;
> > +       uint16_t                        format_revision;
> > +       uint16_t                        content_revision;
> >  };
> >
> >  struct gpu_metrics_v1_0 {
> > @@ -385,8 +385,9 @@ struct gpu_metrics_v1_0 {
> >         uint16_t                        current_fan_speed;
> >
> >         /* Link width/speed */
> > -       uint8_t                         pcie_link_width;
> > -       uint8_t                         pcie_link_speed; // in 0.1 GT/s
> > +       uint16_t                        pcie_link_width;
> > +       uint16_t                        pcie_link_speed; // in 0.1 GT/s
> > +       uint8_t                         padding[2];
> >  };
> >
> >  struct gpu_metrics_v2_0 {
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > index 50dd1529b994..f4e7a330f67f 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > @@ -284,11 +284,11 @@ int smu_v11_0_get_dpm_level_range(struct
> smu_context *smu,
> >
> >  int smu_v11_0_get_current_pcie_link_width_level(struct smu_context
> *smu);
> >
> > -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
> > +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
> >
> >  int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context
> *smu);
> >
> > -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
> > +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
> >
> >  int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
> >                               bool enablement);
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> > index c0753029a8e2..95e905d8418d 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> > @@ -52,8 +52,8 @@
> >
> >  #define LINK_WIDTH_MAX                         6
> >  #define LINK_SPEED_MAX                         3
> > -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > -static int link_speed[] = {25, 50, 80, 160};
> > +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > +static uint16_t link_speed[] = {25, 50, 80, 160};
> >
> >  static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
> >                 enum pp_clock_type type, uint32_t mask);
> > @@ -2117,7 +2117,7 @@ static int
> vega12_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
> >                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> >  }
> >
> > -static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
> > +static uint16_t vega12_get_current_pcie_link_width(struct pp_hwmgr
> *hwmgr)
> >  {
> >         uint32_t width_level;
> >
> > @@ -2137,7 +2137,7 @@ static int
> vega12_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
> >                 >>
> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> >  }
> >
> > -static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
> > +static uint16_t vega12_get_current_pcie_link_speed(struct pp_hwmgr
> *hwmgr)
> >  {
> >         uint32_t speed_level;
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> > index 87811b005b85..3d462405b572 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> > @@ -57,8 +57,8 @@
> >
> >  #define LINK_WIDTH_MAX                         6
> >  #define LINK_SPEED_MAX                         3
> > -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > -static int link_speed[] = {25, 50, 80, 160};
> > +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > +static uint16_t link_speed[] = {25, 50, 80, 160};
> >
> >  static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
> >  {
> > @@ -3279,7 +3279,7 @@ static int
> vega20_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
> >                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> >  }
> >
> > -static int vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
> > +static uint16_t vega20_get_current_pcie_link_width(struct pp_hwmgr
> *hwmgr)
> >  {
> >         uint32_t width_level;
> >
> > @@ -3299,7 +3299,7 @@ static int
> vega20_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
> >                 >>
> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> >  }
> >
> > -static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
> > +static uint16_t vega20_get_current_pcie_link_speed(struct pp_hwmgr
> *hwmgr)
> >  {
> >         uint32_t speed_level;
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > index 60ef63073ad4..86af9832ba9c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > @@ -99,8 +99,8 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
> >  #define mmCG_THERMAL_STATUS_ARCT               0x90
> >  #define mmCG_THERMAL_STATUS_ARCT_BASE_IDX      0
> >
> > -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > -static int link_speed[] = {25, 50, 80, 160};
> > +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> > +static uint16_t link_speed[] = {25, 50, 80, 160};
> >
> >  int smu_v11_0_init_microcode(struct smu_context *smu)
> >  {
> > @@ -2134,7 +2134,7 @@ int
> smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
> >                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> >  }
> >
> > -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
> > +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
> >  {
> >         uint32_t width_level;
> >
> > @@ -2154,7 +2154,7 @@ int
> smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
> >                 >> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> >  }
> >
> > -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
> > +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
> >  {
> >         uint32_t speed_level;
> >
> > --
> > 2.29.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000004276a805bbff811a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is why I advocated for the sysfs output to be either =
standard packed or serialized.=C2=A0 It was a hack as it is anyways.</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Feb 22, 2021 at 4:46 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gma=
il.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Sun, Feb 21, 2021 at 11:03 PM Evan Quan &lt=
;<a href=3D"mailto:evan.quan@amd.com" target=3D"_blank">evan.quan@amd.com</=
a>&gt; wrote:<br>
&gt;<br>
&gt; To make sure they are naturally aligned.<br>
&gt;<br>
&gt; Change-Id: I496a5b79158bdbd2e17f179098939e050b2ad489<br>
&gt; Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" targ=
et=3D"_blank">evan.quan@amd.com</a>&gt;<br>
<br>
Won&#39;t this break existing apps that query this info?=C2=A0 We need to m=
ake<br>
sure umr and rocm-smi can handle this.<br>
<br>
Alex<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/include/kgd_pp_interface.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 11 ++++++-----<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |=C2=A0 8 =
++++----<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |=C2=A0 8 =
++++----<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 8 ++++----<br>
&gt;=C2=A0 5 files changed, 20 insertions(+), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/=
gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; index 828513412e20..3a8f64e1a10c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; @@ -332,9 +332,9 @@ struct amd_pm_funcs {<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct metrics_table_header {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 structure_size;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format_revision;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0content_revision;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 structure_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 format_revision;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content_revision;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct gpu_metrics_v1_0 {<br>
&gt; @@ -385,8 +385,9 @@ struct gpu_metrics_v1_0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current_fan_speed;<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Link width/speed */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_link_width;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_link_speed; // =
in 0.1 GT/s<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_link_width;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_link_speed; // in 0.=
1 GT/s<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0padding[2];<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct gpu_metrics_v2_0 {<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/=
amd/pm/inc/smu_v11_0.h<br>
&gt; index 50dd1529b994..f4e7a330f67f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; @@ -284,11 +284,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_con=
text *smu,<br>
&gt;<br>
&gt;=C2=A0 int smu_v11_0_get_current_pcie_link_width_level(struct smu_conte=
xt *smu);<br>
&gt;<br>
&gt; -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);<b=
r>
&gt; +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *sm=
u);<br>
&gt;<br>
&gt;=C2=A0 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_conte=
xt *smu);<br>
&gt;<br>
&gt; -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);<b=
r>
&gt; +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *sm=
u);<br>
&gt;<br>
&gt;=C2=A0 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enablement);<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; index c0753029a8e2..95e905d8418d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; @@ -52,8 +52,8 @@<br>
&gt;<br>
&gt;=C2=A0 #define LINK_WIDTH_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt;=C2=A0 #define LINK_SPEED_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; -static int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; -static int link_speed[] =3D {25, 50, 80, 160};<br>
&gt; +static uint16_t link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; +static uint16_t link_speed[] =3D {25, 50, 80, 160};<br>
&gt;<br>
&gt;=C2=A0 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum pp_c=
lock_type type, uint32_t mask);<br>
&gt; @@ -2117,7 +2117,7 @@ static int vega12_get_current_pcie_link_width_le=
vel(struct pp_hwmgr *hwmgr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)=
<br>
&gt; +static uint16_t vega12_get_current_pcie_link_width(struct pp_hwmgr *h=
wmgr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width_level;<br>
&gt;<br>
&gt; @@ -2137,7 +2137,7 @@ static int vega12_get_current_pcie_link_speed_le=
vel(struct pp_hwmgr *hwmgr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)=
<br>
&gt; +static uint16_t vega12_get_current_pcie_link_speed(struct pp_hwmgr *h=
wmgr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t speed_level;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index 87811b005b85..3d462405b572 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; @@ -57,8 +57,8 @@<br>
&gt;<br>
&gt;=C2=A0 #define LINK_WIDTH_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt;=C2=A0 #define LINK_SPEED_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; -static int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; -static int link_speed[] =3D {25, 50, 80, 160};<br>
&gt; +static uint16_t link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; +static uint16_t link_speed[] =3D {25, 50, 80, 160};<br>
&gt;<br>
&gt;=C2=A0 static void vega20_set_default_registry_data(struct pp_hwmgr *hw=
mgr)<br>
&gt;=C2=A0 {<br>
&gt; @@ -3279,7 +3279,7 @@ static int vega20_get_current_pcie_link_width_le=
vel(struct pp_hwmgr *hwmgr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)=
<br>
&gt; +static uint16_t vega20_get_current_pcie_link_width(struct pp_hwmgr *h=
wmgr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width_level;<br>
&gt;<br>
&gt; @@ -3299,7 +3299,7 @@ static int vega20_get_current_pcie_link_speed_le=
vel(struct pp_hwmgr *hwmgr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)=
<br>
&gt; +static uint16_t vega20_get_current_pcie_link_speed(struct pp_hwmgr *h=
wmgr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t speed_level;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; index 60ef63073ad4..86af9832ba9c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; @@ -99,8 +99,8 @@ MODULE_FIRMWARE(&quot;amdgpu/dimgrey_cavefish_smc.bi=
n&quot;);<br>
&gt;=C2=A0 #define mmCG_THERMAL_STATUS_ARCT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x90<br>
&gt;=C2=A0 #define mmCG_THERMAL_STATUS_ARCT_BASE_IDX=C2=A0 =C2=A0 =C2=A0 0<=
br>
&gt;<br>
&gt; -static int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; -static int link_speed[] =3D {25, 50, 80, 160};<br>
&gt; +static uint16_t link_width[] =3D {0, 1, 2, 4, 8, 12, 16};<br>
&gt; +static uint16_t link_speed[] =3D {25, 50, 80, 160};<br>
&gt;<br>
&gt;=C2=A0 int smu_v11_0_init_microcode(struct smu_context *smu)<br>
&gt;=C2=A0 {<br>
&gt; @@ -2134,7 +2134,7 @@ int smu_v11_0_get_current_pcie_link_width_level(=
struct smu_context *smu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)<br=
>
&gt; +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *sm=
u)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width_level;<br>
&gt;<br>
&gt; @@ -2154,7 +2154,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(=
struct smu_context *smu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; =
PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)<br=
>
&gt; +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *sm=
u)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t speed_level;<br>
&gt;<br>
&gt; --<br>
&gt; 2.29.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000004276a805bbff811a--

--===============1514982311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1514982311==--
