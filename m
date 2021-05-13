Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64323C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C4461433
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C4461433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CC46E894;
	Thu, 13 May 2021 14:17:59 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF216E894
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 14:17:58 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso23738965ote.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dfnosBslQXQ6G/XHnjEn8kNJdLQMZYIRcVlnHPvH2C8=;
 b=mq4tFwhiYBB2EaSet++vzh5Sr0pU/IBg1ujAlt3d1n8aY0afTSIoGsqVLWsqJAEkyj
 EE2OqfqAJkDAG+W9DlxKQqM559NMkfDH7Lv0PRszYSA7bHr5mDt56BmrlF1fvJNazVZ7
 Ojie/HAjVIAsyV6ibcX25qDqVN6FOCG82G+cyUbg6ZafyoCUontwMeZpXn5+NE2z3QGq
 j25EmTnu7lqWQPmcsxGDGFZL56mhOy/fW736B2xxNVga1uQvZf74YK1jziIQyq9Elxjb
 M6fH10MTu38vp3Pbrk+h9Z6evwEA2vmUyw9fi3p9JA7WgNQb7jipIdrjz/PozkHLD8EU
 pQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dfnosBslQXQ6G/XHnjEn8kNJdLQMZYIRcVlnHPvH2C8=;
 b=kEnVfZS0XE4tm+ZZazAZJtu3AEkxrFb8YDm2ypj26JSTdXbhTlJ7TTs6aTX3Z3Ph+W
 1azG5gQvyTvk/NX/RYtA5hdMEsiIDOwZRaNwviWpWsOcbZj2JhHKCG3usmhRJQ3dyVV0
 fnCsCED5DJnW626vuwTTSxDnpZ2uV3iBd6GZojKfdI5bbo5UsMR9oQxcaF/DUu/DTF9X
 bGA6uPSxixQsD0BT6D01myWDMaL7V2BwDOukevsj/T15iFbht1a9BRlcgXyWlTVAvj2G
 o3T8JEpCc2Ub1IUrfa/CpXorOyLyp5aoS2nVDYFoP2fH98y5cFgf3xaU/mHb7AJ/hyDM
 yelw==
X-Gm-Message-State: AOAM531Xr2+E84iRU1nj5BTLF3nj5NGZKgcPlPib9rPoaPUzHDUf64vO
 AiQF+r6jJEo+Q+LQCVfycebfZBc+cvBVCN7fNks=
X-Google-Smtp-Source: ABdhPJxTuKONdTHhjCot+kHIbRUAsCd1jXu+Acx3Qqmz3ej6XXD1jWsLndeTtun90RmyYhqJQhoePg3XzWEPbbCSZPo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr33353968oti.23.1620915478199; 
 Thu, 13 May 2021 07:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
In-Reply-To: <YJz3CMBFFIDBzVwX@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 10:17:47 -0400
Message-ID: <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
To: Borislav Petkov <bp@alien8.de>
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 9:26 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 03:20:36AM +0000, Joshi, Mukul wrote:
> > Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is defined.
> > I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile the amdgpu
> > driver when CONFIG_X86_MCE_AMD is not defined.
> > I can avoid all that by using is_smca_umc_v2().
> > I think it would be cleaner with using is_smca_umc_v2().
>
> See how smca_get_long_name() is exported and export that function the
> same way.
>
> To save you some energy: is_smca_umc_v2() is not going to happen.
>
> > You can think of GPU device as a EDAC device here. It is mainly
> > interested in handling uncorrectable errors.
>
> An EDAC "device", as you call it, is not interested in handling UEs. If
> anything, it counts them.
>
> > It is a deferred interrupt that generates an MCE.
>
> Is that the same deferred interrupt which calls amd_deferred_error_interrupt() ?
>
> > When an uncorrectable error is detected on the GPU UMC, all we are
> > doing is determining the physical address where the error occurred and
> > then "retiring" the page that address belongs to.
>
> What page is that? Normal DRAM page or a page in some special GPU memory?
>

GPU memory.

> > By retiring, we mean we reserve the page so that it is not available
> > for allocations to any applications.
>
> We do that for normal DRAM memory pages by poisoning them. I hope you
> don't mean that.
>
> Looking at
>
> amdgpu_ras_add_bad_pages
> |-> amdgpu_vram_mgr_reserve_range
>
> that's some VRAM thing so I'm guessing special memory on the GPU.
>

Yes.

> If so, what happens with all those "retired" pages when you reboot?
> They're getting used again and potentially trigger the same UEs and the
> same retiring happens?

The bad pages are stored in an EEPROM on the board and the next time
the driver loads it reads the EEPROM so that it can reserve the bad
pages at init time so they don't get used again.

Alex


>
> > We are providing information to the user by storing all the
> > information about the retired pages in EEPROM. This can be accessed
> > through sysfs.
>
> Ok, I'm a user and I can access that information through sysfs. What can
> I do with it?
>
> > Hope it clears what "bad page retirement" is achieving.
>
> It is getting there.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
