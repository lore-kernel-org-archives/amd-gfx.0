Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFE5611F2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBFE5611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999B66E462;
	Thu, 21 Oct 2021 14:01:51 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29B86E462
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:01:50 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id r6so990178oiw.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=52ktmSD4+LW/TPNx/tRP7h9xebN3MTyMg9J0keAcRLo=;
 b=Di3uOhne/ifZpXKpNXTl6WZDH10/BfnjimhPaqDhj+OFQ4CS8GBf40NKLQCA+ZkB2H
 SskM7g6ygid6qP7ocTZiGBVZPEZbrS8TtxerXnIvS+HgP83jAyQp2MfneQbvdMIkCRLW
 TQUbG5tgQ/vCiv0nCv7T6GMjyI0SEDbM01kEBu8stjlUekdK7Z72eosCkFDp6dMyVtEM
 5lT2NbXjBe4KSrJljoq6KSyd1SPtlVTtzFKYTTOq9L4IBCvIhtbWeIOgOC9KQuBr2XGN
 7VopRQ6faWFIMKJweAsXiKP5fiW6nt3eANKYsVcKVrY6b00zZVtlRmL51E+gLCDdn7aE
 TUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=52ktmSD4+LW/TPNx/tRP7h9xebN3MTyMg9J0keAcRLo=;
 b=2/K6Osv4zqYfkwzNPubyr2a9NMoYoWP4ygt3UxwCo4QRUszVDQfu4Yv8dwIqj1G7+v
 aw15dDLe98BRLawZlFgUV4nXCM8uIxpHw9sf6NFwXbgD9cbrLhQZB/gnGtXrdkf9wcB3
 mzGZoG8GTRnbJUAs15HTkxFoAjG+sZJh6DB+IShLqghktreL0v8rXR48SDTWNBFHYfhv
 mpd4YIqBsqcDh5dSXYQtCFVUWwu6Xrtadw6UDXhCgTPAEdot0N67XzlIbw9NW1ufNOf0
 3AMD8SHpcb5rIuwLNBPJwpZa4hkkpTehBeSyDs7IIPBOINMas/N8GAwPgt+UIT3LL3MV
 r6Hw==
X-Gm-Message-State: AOAM533r49+ekjE4wiFnuqC4CbmF9IMg0en9Gzl/OF/t0gcx4ERrR9w6
 BVj+qB2TKLIgVT7qKUzaf6T1BpS/wdgVaxMKXUw=
X-Google-Smtp-Source: ABdhPJz9AHqhGdgjzzE7VGa4LEnioCTf9VAXFecSJVuCMR5ysky3WpWHIb8CHn5g7SLNyjVLOLU/jAxL4GFhXgx/ls8=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr4719840oia.5.1634824908723; 
 Thu, 21 Oct 2021 07:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
 <DM5PR12MB2469DF82D13B3FE947FCCC82F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB2469B136862C34B770761404F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469B136862C34B770761404F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Oct 2021 10:01:37 -0400
Message-ID: <CADnq5_MgRY6WpyhD57zQZtJjpFqg0WTTH3=f1b2crGYK7n7Y0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
To: "Chen, Guchun" <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
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

Thanks.  I think this patch set fixes it in a bit more future proof way:
https://patchwork.freedesktop.org/series/96132/

Alex

On Thu, Oct 21, 2021 at 9:34 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Additionally, in sienna_cichlid_dpm_set_vcn_enable, we also use num_vcn_i=
nst to set dpm for VCN1 if it's > 1.
> The main problem here is VCN harvest info is not set correctly, so vcn.ha=
rvest_config is not reliable in this case.
>
> if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_=
MSG_PowerUpVcn, 0, NULL);
>                         if (ret)
>                                 return ret;
>                         if (adev->vcn.num_vcn_inst > 1) {
>                                 ret =3D smu_cmn_send_smc_msg_with_param(s=
mu, SMU_MSG_PowerUpVcn,
>                                                                   0x10000=
, NULL);
>                                 if (ret)
>                                         return ret;
>                         }
>                 }
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Chen, Guchun
> Sent: Thursday, October 21, 2021 9:14 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_=
FLOUNDER
>
> Hi Alex,
>
> No, it does not help.
>
> adev->vcn.harvest_config is 0 after retrieving harvest info from VBIOS. L=
ooks that harvest info in VBIOs does not reflect the case that VCN1 is powe=
r gated.
>
> I checked several navy flounders SKUs, the observation is the same, so th=
is is likely a common case. Perhaps we need to check with VBIOS/SMU guys.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 21, 2021 9:06 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_=
FLOUNDER
>
> On Thu, Oct 21, 2021 at 3:15 AM Guchun Chen <guchun.chen@amd.com> wrote:
> >
> > VCN instance 1 is power gated permanently by SMU.
> >
> > Bug:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%7=
C
> > guchun.chen%40amd.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe48
> > 84e608e11a82d994e183d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C1000&amp;sdata=3D2vNLj9bXE2oV97rxBiUOiaFNpKopVSJefL%2BMcQE%2BSfo%3D=
&
> > amp;reserved=3D0
> >
> > Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>
> Doesn't this patch effectively do the same thing?
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.freedesktop.org%2Fpatch%2F460329%2F&amp;data=3D04%7C01%7Cguchun.chen%4=
0amd.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe4884e608e11a82d994e1=
83d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjPu3Yh%=
2B6OHR4F1BS5MWL3VyZ3pui6c0dP97Zl7yBJKY%3D&amp;reserved=3D0
> Where else is num_vcn_inst used that it causes a problem?  Or is the VCN =
harvesting not set correctly on some navy flounders?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index dbfd92984655..4848922667f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
> >                         adev->vcn.num_enc_rings =3D 0;
> >                 else
> >                         adev->vcn.num_enc_rings =3D 2;
> > +
> > +               /*
> > +                * Fix ME.
> > +                * VCN instance number is limited to 1 for below ASIC d=
ue to
> > +                * VCN instnace 1 is permanently power gated.
> > +                */
> > +               if ((adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3=
, 0, 0)) &&
> > +                       (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSIO=
N(10, 3, 2)))
> > +                       adev->vcn.num_vcn_inst =3D 1;
> >         }
> >
> >         vcn_v3_0_set_dec_ring_funcs(adev);
> > --
> > 2.17.1
> >
