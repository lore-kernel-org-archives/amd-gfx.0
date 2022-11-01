Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0E1C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 15:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D9D10E3E8;
	Tue,  1 Nov 2022 15:25:37 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B0810E3E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 15:25:33 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-13b23e29e36so17145516fac.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wpOVILxkqBYeDdmRMZz1kJkAkqShn9Fvz6ubV6ItVwE=;
 b=fpd2vchiW4bHj3yaYa+MgzxrdcYTBwFsasmvLY0/4F1ZIoG3BVTVRVZ+AvuSgKPp93
 zS3R3vhBkcBCgA9GwUhlw7pLwaKGzJkkfgvyMFOu1Cs4K1788zSQaPv4XM5xSSQIfTQa
 zl10+xLO7x/ucjH4tIh1vW1qhdeavPYQ2IJ8btIf1/AfCpn/BK7bEy5/1FtmUZuQvg25
 NrXptkswAK7gglEVTMUfHnEFGMDmKsTEKOc4Ml1RnjY2sro6BNSR6JC/4jDiD48Z0ylH
 WUjN2xEPrVZABR74ySBF7tKscZU827CJ2bGN6t51aqPSBbvw4Ckh6n+tf3XjXIc03Tr5
 unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wpOVILxkqBYeDdmRMZz1kJkAkqShn9Fvz6ubV6ItVwE=;
 b=Zi6j3+F82VA53OqrosOseDOWKVgj0R5rqLaGTNyez2SufVqz3cieOYJ1YLMz/ucFe6
 v7S4HmBLuwkS22WnzhSp0KCZZhLnaEBbT8YH/+uQG99u06H372lpQEq3h6lWqrASmMrX
 nKnoUC99zkqzDm7Py2S2DBg8tURkhmYhag2FuGA+BUfMTNvYpygUNv4McDft71AuvNYX
 yNlRJlzo1J9/FP388QruCzwWF99n04iEPu+N4/lJKKYjoE6XGjV8ZoW5hoPDx9Ew4MMi
 50n1efLIL0Ubla3j6HEXRJkexSx68hgGcdWTdhX9FIjEvNr6xrsLorxEjmZ6VvIslv0G
 2XMg==
X-Gm-Message-State: ACrzQf0rTuH5L+yqJyx+uTD4s1BRt/lk84FJeL+gZd0UtegTr/Y4e602
 hpuTsb9VZX+hvVIKuuETymhhwm6t/nm3zkpQLhTt4Ek0888=
X-Google-Smtp-Source: AMsMyM7VnHVEN8gSNJng7uotM9qZ8BsEjfbCO1P56IFQ1jXkHUFbaGKxomJCg7YhslV0AXr0N7xmOj4pcycPDKakEuk=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr11571811oao.96.1667316332623; Tue, 01
 Nov 2022 08:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
 <20221101051450.1261693-2-Perry.Yuan@amd.com>
 <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
 <CADnq5_MtoWMSy-YWp3mL805SOdpS0hJnbV0xo61YvtDFZ4RB_g@mail.gmail.com>
 <DM4PR12MB527832A011FA4DC91A6333109C369@DM4PR12MB5278.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB527832A011FA4DC91A6333109C369@DM4PR12MB5278.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Nov 2022 11:25:20 -0400
Message-ID: <CADnq5_PJwxwJ7NM4yRcKO1CJqjJCc6yPjZfM3QOE3ThNTC0Fgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Shimmer" <Shimmer.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 1, 2022 at 11:19 AM Yuan, Perry <Perry.Yuan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Alex
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, November 1, 2022 9:25 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Huang, Shimmer <Shimmer.Huang@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery
> > path
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Nov 1, 2022 at 9:23 AM Alex Deucher <alexdeucher@gmail.com>
> > wrote:
> > >
> > > On Tue, Nov 1, 2022 at 1:16 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
> > > >
> > > > Add the missing apu flag for Vangogh when using IP discovery code
> > > > path to initialize IPs
> > > >
> > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > Swap the order of the patches.  With that, the series is:
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Actually, you also need to fix up check_seamless_boot_capability() in
> > amdgpu_dm.c.  Switch that to an IP version check.
> >
> > Alex
>
> I am not sure if the IP versions only correctly match the GPUs.

It should match gfx IP_VERSION(10, 3, 1).  You are using that to set
the APU flag in this patch.  The DCN version (3.0.1) is also unique to
this chip and that would better match the fact that this is a DCN
related function.

Alex

>
> How about using the apu flags  like this ?
>
> bool check_seamless_boot_capability(struct amdgpu_device *adev)
> {
>         if (adev->apu_flags & AMD_APU_IS_VANGOGH) {
>                 if (!adev->mman.keep_stolen_vga_memory)
>                         return true;
>         }
>
>         return false;
> }
>
> Perry.
>
> >
> >
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > > > index 3993e6134914..52a92add12ea 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > > > @@ -2161,6 +2161,7 @@ int amdgpu_discovery_set_ip_blocks(struct
> > amdgpu_device *adev)
> > > >                 break;
> > > >         case IP_VERSION(10, 3, 1):
> > > >                 adev->family = AMDGPU_FAMILY_VGH;
> > > > +               adev->apu_flags |= AMD_APU_IS_VANGOGH;
> > > >                 break;
> > > >         case IP_VERSION(10, 3, 3):
> > > >                 adev->family = AMDGPU_FAMILY_YC;
> > > > --
> > > > 2.34.1
> > > >
