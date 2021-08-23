Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25045C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 19:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E896361368
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 19:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E896361368
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392C989AFF;
	Mon, 23 Aug 2021 19:49:53 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC19B89AFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 19:49:51 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 j11-20020a4a92cb000000b002902ae8cb10so456790ooh.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zTRs4BS0zxZLB3LmR+LQQP1mEXdfXgwLSSOmcQuzVM=;
 b=TKOlOqAtEwSItfC/SYqWQ37BFqbPOoDsulmCCgWgHgxQsR0HiSEu9vYLc504KkwwZF
 4WttrWCItzSxKu0zYwLopJ9VUrw7baHi3lpfWY2rE3Py53K1prRnh2+yhi4KRwCy56al
 lmqoD8Yvb10KZeYt+sI7YLl98qplcFklcsdKGXmbCVrUllZKCOnZuSbLwTGpys0YcHG2
 NNSv34fNQ8tlamnSauPHfp7cJ3FoR3rwbxS4otUpNoPNAsk4xuaCahbAhihPP9PjbWao
 NBWeEp1orLn0B4WXbON4TnfxqUmHu4hLO1LsVM7FyRvA5krg2NHtBaYms9yjPVYuiz+Q
 7ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zTRs4BS0zxZLB3LmR+LQQP1mEXdfXgwLSSOmcQuzVM=;
 b=G6ruuC7QCUMFCw32T09Ma3Sxplm8rmviiQxlMpt5AStCHPei/EKDYpTNmfvYfZ7N9x
 zGtoMZguqNBfbgKfrB41kOzv/ALtn1+MFDFLruidKemAYck77TMDjojr0QU4Jf1K3UiL
 QBP9QbKZNjq5f19jrkeFd704hdhkbsHZ8Z7isq9aHoMukg7YmSM1Kc8hhrO4Wjc/Kd5x
 toRaufz1M/M2o0LsrFiSK4vEmsMHsDTFXGNfXTrJeTEDvO5WJKJJD62zYv05CiPUonrB
 t5CJUtdvbysCpuqeR2TCNYPp+bWw1UxQ8p1O4c6zXOMMy8PUU5LSiWGuZjS88uMWo87N
 cPjw==
X-Gm-Message-State: AOAM531DWWfh2e0zbjgU38BKJr1u8w0nL8acuUjnozIhx4tOpyQwJHvK
 kSykfBnsx8Kc6MS0+F65pmmMD2l87bXm0XF43wE=
X-Google-Smtp-Source: ABdhPJwtqT1MYncFYx1ABQOt4lWM7n/Z3lCopKobiq4xA1qo98CVYGAMhhzxlNjsp/B4DmLNC5MG2pfDXNh+XRwLE8I=
X-Received: by 2002:a4a:4484:: with SMTP id o126mr3720094ooa.90.1629748190992; 
 Mon, 23 Aug 2021 12:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic>
In-Reply-To: <YSP6Lv53QV0cOAsd@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Aug 2021 15:49:39 -0400
Message-ID: <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
To: Borislav Petkov <bp@alien8.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 lkml <linux-kernel@vger.kernel.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 23, 2021 at 3:43 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi folks,
>
> I'm seeing this:
>
> ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
> make[1]: *** Deleting file 'modules-only.symvers'
> make: *** [Makefile:1766: modules] Error 2
> make: *** Waiting for unfinished jobs....
>
> with the attached config which has
>
> # CONFIG_SUSPEND is not set
>
> on latest Linus tree.
>
> It probably has been fixed already but lemme report it just in case.

Maybe fixed with this patch?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5706cb3c910cc8283f344bc37a889a8d523a2c6d

Alex

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
