Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09CC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 06:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B607860720
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 06:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B607860720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0799589F08;
	Tue, 10 Aug 2021 06:56:01 +0000 (UTC)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA6389CE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 04:57:47 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id E76EF3F22A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 04:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1628571465;
 bh=mH2pfwcHripVOHfQOFgWXLfXMfNRSThWQXSwffRxBek=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=PZsbi8To84MntrUEk+qZkBEGAhDTVwJMliaBi00kTrX7H4K4V/O6yVJH8J2k5FgDS
 rh/ajMCZ5EBpj9hpNw2gVwxHl8LwRc22+I4t/kJQvhvV7Q6gYp86erbm/il9JqahnX
 jfYQRcbXoNqU4v52IA5NQwUcw9FepqKplNQHjgTWXQG6zfB0ZyelqQw4J2Lz4yWYtX
 pVQIDbTpRVFDPLEm+0uIrMmgstEkV0GcTwBOLWYojIparA/U6iMdG5cY1kraBJI3wX
 lMD9kKBTm1Na5uC4b93kDeouNxpohDbAggr4kvenJ06EaIZB5FWI7uNwb1stqa0OCp
 XVhecvn3ikVEw==
Received: by mail-ot1-f69.google.com with SMTP id
 i9-20020a0568302109b02905090e0df297so1255702otc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 21:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mH2pfwcHripVOHfQOFgWXLfXMfNRSThWQXSwffRxBek=;
 b=kZC084FDCA6dQzpwWwpFCS4Ehsb8m5PoOqsfUS3xLGJO3I5C9M/SVLyqtYbR9St5At
 Yso86G4psiv6vTQbKgDEIx77Omc9z6QEIYXsQeoHUJmN8p/i8cM3O1oK1Qlwz/Y5Yeob
 pDTn9emF+WH4irHxTdnUjAiaYFuhhlxSVBTRkoX5yOkz5ajwOD7Rkm/mXpw/b8vrXV32
 0hzQqB4k2nQpeknWL3ImBUlmAjqIW+5B3ogvQPx8YkNm6dVP0+CVKYMVT0LmlmdZ0PHb
 YRD8+Q/iJ83F3UYyG3bUILj/HetuH3icecLmcgWWJjRFTljk7oteuNuonvOag2zYX5gx
 wCkw==
X-Gm-Message-State: AOAM532DSl/uSekhaBVCVJOC0TeJWtJWDohi/90vjS521md9gt5Rv1F2
 S8nBaT8yKwbBKK8jbrx2mnHO3GBOBv2DwTrW1PlOpdvsUaCoFWNia2AoRjBVG7UX9QIS2f5OPm4
 /APjFTa6vXLl3tByNec1JB4uh/x1EJWxp9wPmtxewk49F1/X3w7YtYGIFEeI=
X-Received: by 2002:a05:6830:4407:: with SMTP id
 q7mr18925443otv.246.1628571464584; 
 Mon, 09 Aug 2021 21:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj94jffkLgraksnPZ6InwiL+N5CtgZdv0o8jkg2n1QlRHKN+R8ggd5FoqCR3Ypp/boJlVF2FIAVs2MhIowXHI=
X-Received: by 2002:a05:6830:4407:: with SMTP id
 q7mr18925427otv.246.1628571464292; 
 Mon, 09 Aug 2021 21:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
 <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
 <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
 <CA+EcB1MYQOBypQN6Ktdu52sfqg1N-sfzurSeTQDW1kPz9H+iUw@mail.gmail.com>
In-Reply-To: <CA+EcB1MYQOBypQN6Ktdu52sfqg1N-sfzurSeTQDW1kPz9H+iUw@mail.gmail.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Tue, 10 Aug 2021 12:57:33 +0800
Message-ID: <CAJB-X+UD7-aSKP1Ozc2UUbOZ5MYY6wD5jMUY3+MeS_KKQzaxdA@mail.gmail.com>
Subject: Re: Req: about Polaris with RKL platform
To: Mario Limonciello <superm1@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Anthony Wong <anthony.wong@canonical.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Aug 10, 2021 at 12:45 PM Mario Limonciello <superm1@gmail.com> wrote:
>
>
>
> On Mon, Aug 9, 2021 at 9:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Aug 9, 2021 at 9:59 AM Koba Ko <koba.ko@canonical.com> wrote:
>> >
>> > Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
>> > AMD provided a parameter.
>> > #modprobe amdgpu ppfeaturemask=0xfff7bffb
>> >
>> >  I thought it's better to check and assign values in amd gpu.
>> > Have a trouble determining the type of pch(RKL or else),
>> > search in amd drm driver and can't find any about this.
>> > Would someone please guide me? if there's an existing function.
>> >
>> > here's a proposal, check RKL PCH in amd driver,
>> > the pch definitions must be splitted off from intel_pch.h in i915
>> > folder to include/drm/intel_pch_definition.h
>>
>> Yes, something like that would work.
>
>
> Can the issue that prompted this also happen with other ASIC with the
> newer SMU families?  If so, should it probably be added to all of them
> or further up in the code where the mask normally gets set from module
> parameters to add the extra check there.

Would amd guys please clarify this?

Currently as i known,
for smu series, amd upstream this commit only for smu7 and also
provide modue parameters.
1.https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d03730ecbc5afabfda26d4dbb014310bc4ea4d9
2. #modprobe amdgpu ppfeaturemask=0xfff7bffb

>
>>
>> Alex
>>
>>
>> >
>> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>> > > @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>> > >
>> > >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
>> > >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
>> > > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
>> > > +       data->pcie_dpm_key_disabled = is_rkl_pch() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
>> > >         /* need to set voltage control types before EVV patching */
>> > >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
>> > >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
>
>
>
> --
> Mario Limonciello
> superm1@gmail.com
