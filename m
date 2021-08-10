Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49421C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 06:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115CA60720
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 06:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 115CA60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C6F89F03;
	Tue, 10 Aug 2021 06:56:00 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C58898F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 04:45:31 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id w10so14502318qtj.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JP5HzsVfGjKPzrxvK0ptYPFHVZwktnLilwL98CGYBnY=;
 b=CiGCgex0ru1ueqRuTNvsM0kvDbCIsVNxM94gCT1YF0gH0HILRJK+z7nFaGzHbZaas7
 l1QN12DcpmmkbgGhUEFEy9GFiQTlJQbN2Kub8UfY3b65YM5Di2DW98Zjw7aUbqOyAvWX
 YzLXbFD1XBLjPn6/gWVabb31WtUb/fVOO7Qs2afzBWUGeWOLBFs+S7JzxaFANRfm/EXv
 8E8ZbXomrewBZeAAtY9eulh9TlTxHSfszaFv8J7fFADGZZ1HmpBzEL2DO+Tqj6rNqyx5
 0tytb/dxsw97HxfbZS3jTJxb0HDHeXX5GK8nUCJYUQbMBp46gf1S6/d644SSF3A2Cz8A
 8BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JP5HzsVfGjKPzrxvK0ptYPFHVZwktnLilwL98CGYBnY=;
 b=DEAElY+hGy5HySs/flvlTvzjZlIjrFEX7e2U8i7d4wq5WgMsjyrXbXL0xRMKo6W6Lj
 yswlGu9qF1OcKT21d9RdQhrOGihlJ95pgjiPoZGDxR1gA0OwCE15h0f/UGGZ9hzuUY57
 99sm9Su5cXDQP9UkNn3Jy014HFLP2xnATHzuspAjhmm/16bPWNnA6oZkWLhbIy3WwgV8
 Qw6/CmCt5oflo99M2oaGdaXpHavldkaoW6bNBO4BP8pbYyt03hGt6NzS5Gp2Ttl+UqPh
 rU6d0jXNwvq6w9WvrfFyPmuyjvLNJWpMcurR2MNtJUXs9S3dy/6aR+6KbZFyxv8iVwKw
 RxcQ==
X-Gm-Message-State: AOAM532hbdwmQ1R4qXv5HiMp0W7pzfQGV/rgDnIgmYQaSNOTQIWuNe5L
 uAA6gTBI7scwyEJbK2jJ3OqlBAvu2aTpqnUJkYM=
X-Google-Smtp-Source: ABdhPJwqIuWu/n1Cnu7F9ejAuhoZAXAG3w/rPZeZHyt+LuIujzQ9suNZqG/os9wZwcFtVVSn2rptEgrw6mnZGUMxuyo=
X-Received: by 2002:ac8:7d0c:: with SMTP id g12mr23661710qtb.152.1628570730057; 
 Mon, 09 Aug 2021 21:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
 <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
 <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
In-Reply-To: <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
From: Mario Limonciello <superm1@gmail.com>
Date: Mon, 9 Aug 2021 23:45:18 -0500
Message-ID: <CA+EcB1MYQOBypQN6Ktdu52sfqg1N-sfzurSeTQDW1kPz9H+iUw@mail.gmail.com>
Subject: Re: Req: about Polaris with RKL platform
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Koba Ko <koba.ko@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Anthony Wong <anthony.wong@canonical.com>
Content-Type: multipart/alternative; boundary="000000000000db551605c92d2b81"
X-Mailman-Approved-At: Tue, 10 Aug 2021 06:55:59 +0000
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

--000000000000db551605c92d2b81
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 9, 2021 at 9:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Mon, Aug 9, 2021 at 9:59 AM Koba Ko <koba.ko@canonical.com> wrote:
> >
> > Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
> > AMD provided a parameter.
> > #modprobe amdgpu ppfeaturemask=0xfff7bffb
> >
> >  I thought it's better to check and assign values in amd gpu.
> > Have a trouble determining the type of pch(RKL or else),
> > search in amd drm driver and can't find any about this.
> > Would someone please guide me? if there's an existing function.
> >
> > here's a proposal, check RKL PCH in amd driver,
> > the pch definitions must be splitted off from intel_pch.h in i915
> > folder to include/drm/intel_pch_definition.h
>
> Yes, something like that would work.
>

Can the issue that prompted this also happen with other ASIC with the
newer SMU families?  If so, should it probably be added to all of them
or further up in the code where the mask normally gets set from module
parameters to add the extra check there.


> Alex
>
>
> >
> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > > @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct
> pp_hwmgr *hwmgr)
> > >
> > >         data->mclk_dpm_key_disabled = hwmgr->feature_mask &
> PP_MCLK_DPM_MASK ? false : true;
> > >         data->sclk_dpm_key_disabled = hwmgr->feature_mask &
> PP_SCLK_DPM_MASK ? false : true;
> > > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask &
> PP_PCIE_DPM_MASK ? false : true;
> > > +       data->pcie_dpm_key_disabled = is_rkl_pch() ||
> !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> > >         /* need to set voltage control types before EVV patching */
> > >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> > >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
>


-- 
Mario Limonciello
superm1@gmail.com

--000000000000db551605c92d2b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 9, 2021 at 9:37 AM Alex D=
eucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, Aug 9, 2021 at 9:59 AM Koba Ko &lt;<a href=3D"mailto:koba.ko@canonica=
l.com" target=3D"_blank">koba.ko@canonical.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Previously, AMD had an issue about noise=C2=A0 with AMD-DG on the RKL =
platform<br>
&gt; AMD provided a parameter.<br>
&gt; #modprobe amdgpu ppfeaturemask=3D0xfff7bffb<br>
&gt;<br>
&gt;=C2=A0 I thought it&#39;s better to check and assign values in amd gpu.=
<br>
&gt; Have a trouble determining the type of pch(RKL or else),<br>
&gt; search in amd drm driver and can&#39;t find any about this.<br>
&gt; Would someone please guide me? if there&#39;s an existing function.<br=
>
&gt;<br>
&gt; here&#39;s a proposal, check RKL PCH in amd driver,<br>
&gt; the pch definitions must be splitted off from intel_pch.h in i915<br>
&gt; folder to include/drm/intel_pch_definition.h<br>
<br>
Yes, something like that would work.<br></blockquote><div><br></div><div>Ca=
n the issue that prompted this also happen with other ASIC with the</div><d=
iv>newer SMU families?=C2=A0 If so, should it probably be added to all of t=
hem</div><div>or further=C2=A0up in the code where the mask normally gets s=
et from module</div><div>parameters to add the extra check there.</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
<br>
<br>
&gt;<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct p=
p_hwmgr *hwmgr)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;mclk_dpm_key_disabled =
=3D hwmgr-&gt;feature_mask &amp; PP_MCLK_DPM_MASK ? false : true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;sclk_dpm_key_disabled =
=3D hwmgr-&gt;feature_mask &amp; PP_SCLK_DPM_MASK ? false : true;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;pcie_dpm_key_disabled =3D hw=
mgr-&gt;feature_mask &amp; PP_PCIE_DPM_MASK ? false : true;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;pcie_dpm_key_disabled =3D is=
_rkl_pch() || !(hwmgr-&gt;feature_mask &amp; PP_PCIE_DPM_MASK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* need to set voltage control t=
ypes before EVV patching */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;voltage_control =3D SMU=
7_VOLTAGE_CONTROL_NONE;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;vddci_control =3D SMU7_=
VOLTAGE_CONTROL_NONE;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><span style=3D"font-size:x-small"><font color=3D=
"#666666">Mario Limonciello<br><a href=3D"mailto:superm1@gmail.com" target=
=3D"_blank">superm1@gmail.com</a></font></span></div></div>

--000000000000db551605c92d2b81--
