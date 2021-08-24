Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7BEC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FB861206
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5FB861206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DFE89ABA;
	Tue, 24 Aug 2021 15:57:32 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8DA89ABA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 15:57:31 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 y14-20020a0568302a0e00b0051acbdb2869so40544581otu.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X27sm7XRJloh7TYC16b8bidIz7tS9xlzanMCh+7pg/0=;
 b=XdbRGi4/xxxpl/ndGsjItcDBt9YYDql6ArJnAKPQWbGna4AOMWlO7a0Z3OOS5k0jRV
 yQW0gr/9eEah9ZHViP/HKoJa5Cz+/euHaWecXA26T04uzZtjdwVaRPRizCigqg+PD8Fd
 8RNWTStsEmwdk+0tWagb9H0zBgxdhlpLNmunCxmabLsrRSa2s44H+LoVt/jx7B8/4m4o
 eMNdKf3U07cwFWNdpvdK9OQCzvpwf7pXWBXO7FutF0tk/CRAfLjmTCznzy1KmxsUEwFj
 YkJz6wpGrKJh8m0D7xeB0ZboVEJrQWCQra2c8d31fIphrpPbvx6HUt0Zvck6nZHjUWTH
 S47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X27sm7XRJloh7TYC16b8bidIz7tS9xlzanMCh+7pg/0=;
 b=RfsdMCgIN5Z88rajrBo9m2mzIp2MXmkpFaaDjabgaXiJIp5/59NUnuho6zDQa6BCIy
 5oXr3XqbdKFnKDaSSPpwYSw2eXkE25725lpc7Sl7Sr6aFysSKkki0KyrSr5p/KE0uULv
 aSLXOzU+5ZOmwj7VoMuih2pzAmj7ZVknkUavuysORckmJ2rsx5GBzXMCfCWR1uXIKi/I
 Whzowp99UH/wbleA86kmm00jN4C8j470UqDzuZqJROiZ257RGJsY+PC88/TCdv9cVFPJ
 wAfl/AkBLT8omh3Rp2mjpSaMHTqxXFGxRFKEiH7y17ETuZqy4ZBxrn9lMKnuZn5Hffhl
 zjyQ==
X-Gm-Message-State: AOAM530GVg+Ixi/iURCn8qmyoyhr+24GrgEBZ/33IiiJYQh1Ds3Jrtn7
 YMDs0RFQ8V0Cl8JNAptQT9fqYXI7d6Til5N88VY=
X-Google-Smtp-Source: ABdhPJyPQRalck3DahrxIbbctemODf7n5JPHNPSc984wGNf7NLLsoBJ4dx6nhPQ9eWWKFduLlQouz30eBNZzqRFm0wY=
X-Received: by 2002:a05:6830:1c69:: with SMTP id
 s9mr4883042otg.132.1629820650421; 
 Tue, 24 Aug 2021 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic> <2d7e3536-fc3e-629a-4f0d-2ac5ccacccc5@amd.com>
In-Reply-To: <2d7e3536-fc3e-629a-4f0d-2ac5ccacccc5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Aug 2021 11:57:19 -0400
Message-ID: <CADnq5_N0493Bv7i4H7dcMr7SJVqVExFTpSx_6PovHq5beVFJpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing pm_suspend_target_state
 module export
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Alex Deucher <alexander.deucher@amd.com>, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 lkml <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Tue, Aug 24, 2021 at 11:16 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 8/24/2021 3:12 PM, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > Building a randconfig here triggered:
> >
> >    ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgp=
u/amdgpu.ko] undefined!
> >
> > because the module export of that symbol happens in
> > kernel/power/suspend.c which is enabled with CONFIG_SUSPEND.
> >
> > The ifdef guards in amdgpu_acpi_is_s0ix_supported(), however, test for
> > CONFIG_PM_SLEEP which is defined like this:
> >
> >    config PM_SLEEP
> >            def_bool y
> >            depends on SUSPEND || HIBERNATE_CALLBACKS
> >
> Missed this altogether!
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > and that randconfig has:
> >
> >    # CONFIG_SUSPEND is not set
> >    CONFIG_HIBERNATE_CALLBACKS=3Dy
> >
> > leading to the module export missing.
> >
> > Change the ifdeffery to depend directly on CONFIG_SUSPEND.
> >
> > Fixes: 5706cb3c910c ("drm/amdgpu: fix checking pmops when PM_SLEEP is n=
ot enabled")
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flkml.kernel.org%2Fr%2FYSP6Lv53QV0cOAsd%40zn.tnic&amp;data=3D04%7C01%7CLi=
jo.Lazar%40amd.com%7C71b6769cdd574a05b32b08d966e37525%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637653949420453962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dai%2B95gtZz0r0pXYaUkG97tiuaiykEy8%2FB%2FtmHP3W4Zs%3D&amp;reserved=3D0
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 4137e848f6a2..a9ce3b20d371 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
> >    */
> >   bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
> >   {
> > -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
> > +#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> >       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> >               if (adev->flags & AMD_IS_APU)
> >                       return pm_suspend_target_state =3D=3D PM_SUSPEND_=
TO_IDLE;
> >
