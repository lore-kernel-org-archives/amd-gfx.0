Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A814C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 12:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C088206BE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 12:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLh3V3yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C088206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178198915E;
	Tue, 30 Jun 2020 12:50:12 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BB68915E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 12:50:11 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k6so20012111wrn.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9b0w0NbDT5VsIyfasZKBlfTEkXBddO8nqBPaCUZ6AAQ=;
 b=DLh3V3yHblmolRnHSw0EGhNJ7jZLEPeq+/sPbdvS8rHN61MNVanAwhedaMDnbFsWag
 c/2zgWEZw0mwH/EuKqeMSUG+BBE6YHqqjStaABS3vWDmCLgDESg43x9QGAH/apkvlADA
 oCGmZTLiZiIM8+HMeZgLgXzRYdkGiKECR+gZ2WkALRU0K5UQVEizjkbHhwnDcI86v3Du
 pBouxx1hD7X8cn8QIu8qGLf7RAe/+l3tNZ6gF9P8d61SRGQ094e5ZS73pUmJw9qAvcIf
 nIkzjB/6yh2xvJajnhqt1nvAWoG1ZQ+ONm5+GH14nihDILpZ1JklzMHU8Jxt4bauJuGz
 gyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9b0w0NbDT5VsIyfasZKBlfTEkXBddO8nqBPaCUZ6AAQ=;
 b=SJ4+59VP14ZHjTZ508iwR/KHqO5c2aWZeeNjI85emfRsAsj3FcoozDx2xbt1Gh2Dyl
 5WLyVFcjZAjGd97JWlVJnNacpGVQtbZJ2lBBdrG9udzALETAlOvVIAy8TiLTPD+9y9FN
 24w1QDro8RgWqOGXOoAtXbDk4cfU9TusiDnevIX71hzim8HeRWf3yyTbYUNYsZUNNMj1
 Jv41mohtk1sV+lAnYrkWb5qdtxSllP/GzfIm0p5ZOa9wwY9QlzkuSxvHwIRRUy2s+mRJ
 /mRVXNB0LbeDhcB2672NU1qxYtjUKQCDESPtX37i49jiey9MzCxLcL/lJA0zFMI2/4eo
 x0oQ==
X-Gm-Message-State: AOAM530cIwzEaUBFy3JwQFlgsTjIdnN2UBLIOwhIqFPg6lrBh5Mh6+SN
 NmnUxkMcsaZa1G0jWsoH3AXcVqaf/ER1PoimHI0=
X-Google-Smtp-Source: ABdhPJzm/kcGiAHvHT6Z+tgZVuTl1QcFThXtgb3OCgBscypYexCZsZVuwHKj8FdjBFN5iCXzypUGxQ7SEsDmMXrMJrs=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr21352487wrl.362.1593521409702; 
 Tue, 30 Jun 2020 05:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200628111848.1234-1-evan.quan@amd.com>
 <CADnq5_NnQbOXs+oWEeb3xvgeVZEPKLCjiRWkBaS7e8zRfeNuBQ@mail.gmail.com>
 <DM6PR12MB2619EC0C31B9741F6B67D5EDE46F0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EC0C31B9741F6B67D5EDE46F0@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jun 2020 08:49:58 -0400
Message-ID: <CADnq5_OXnfraaqGoyaec30k8mz4xA7MnHoEH7rZcs1dGusFJ1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
To: "Quan, Evan" <Evan.Quan@amd.com>
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
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 29, 2020 at 11:54 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> That's because pr_warn/err/info are forbidden to use in power routines.
>
> /*
>  * DO NOT use these for err/warn/info/debug messages.
>  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
>  * They are more MGPU friendly.
>  */
> #undef pr_err
> #undef pr_warn
> #undef pr_info
> #undef pr_debug
>
Ah, right.  Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>


> BR
> Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, June 30, 2020 12:25 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
>
> On Sun, Jun 28, 2020 at 7:19 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > Fix the compile error below:
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
> > >> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of
> > >> function 'pr_warn'; did you mean 'pci_warn'?
> > >> [-Werror=implicit-function-declaration]
> >       22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
> >          |  ^~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:176:3: note: in expansion of macro 'BUG'
> >      176 |   BUG();
> >
> > Change-Id: I4e969082c41f8a8c91f1b0d19eb853eb0a2e0c0d
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
>
> I think this is probably a missing include.  We use BUG() elsewhere in the driver with no problems.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > index 677f8adb920c..48e15885e9c3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > @@ -173,7 +173,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
> >                 chip_name = "sienna_cichlid";
> >                 break;
> >         default:
> > -               BUG();
> > +               dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
> > +               return -EINVAL;
> >         }
> >
> >         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin",
> > chip_name);
> > --
> > 2.27.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> > an.quan%40amd.com%7C2962b4be8d5e4e72009308d81c49098d%7C3dd8961fe4884e6
> > 08e11a82d994e183d%7C0%7C0%7C637290447307762780&amp;sdata=v5oJldXwh7UQN
> > e0ETjZ048xkqODiPe6LiwmMIHu0Ur8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
