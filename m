Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8B1C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 15:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66497235FD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66497235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F325B6E415;
	Thu, 17 Dec 2020 15:17:40 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFA46E415
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 15:17:39 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id d20so9636711otl.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Or2sq2aXND3PS6YSpA9uXvzRVAAq0SOKt/+Pfnr2SY=;
 b=MQqV08fT1QJ4wNAPkV4yG6jDa5cGwaIlSeoNoBQ5mf7g5MTZ1wLg1lijJYfqPmPDgJ
 587vBM1+iWX1L37kJ84sNGjYgymgU+7OAidqUfRJORGtv/XSBCe3AeYX8hVfsfj6JdAd
 qOgh5PoxNk1veoQlenldI52I/UXiswfFonYN9E1b+w3aObXo3YX7Tt6+cvf/krW2IyuV
 O9kcTNM8JySC3TsoKZfv7iprZuwG84qMJ2RgiWxMR9JZmYrnj2d1iihCt2VmiWSbe4CX
 U6szKe0K9ZlhVB+tmRYQP/ABcTzmooM8myd3vS5bA/v21BAmQ+xBRNUuXsC2PeJdTVFN
 Yyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Or2sq2aXND3PS6YSpA9uXvzRVAAq0SOKt/+Pfnr2SY=;
 b=ppFPt93y/KXgBS4XsFRLcZGRjuhBXC18ft38T8lm9hmi66f+oF2xZcO4T3qKOYhdT4
 R0a27Bein8K/83UH5b7+Ka12N4qAMwEnsTn6jpa59g8k1zTeM5MsXRzCFNwKI19Azq8L
 y3iiybNCac6oHZxLsT84b8omUZQbTqh5eHOhAF+qC2YbBHNUlodo7oj8iF/GZJbTcTat
 mMXKAuHZwUrXbFDC3fy52B5E6T6LlIqpmkwpPi++fclXSUd+Ktwwj9Vpo7SFU39ikqQb
 CacKOkyd8oUnMd8MWb6YPKIgMFlMVglTeQ9u6AhC89XufD/uLbjwoJChgnCEpmXSzMrl
 BHVQ==
X-Gm-Message-State: AOAM532PlX1zbXfbmvmCPKwp1WzPwmJdhdJWhH5EQ6twR7YVBo0AojVD
 yGMuZYITDUbgi4bksgesijEXRw6T3snJqnF2aqo=
X-Google-Smtp-Source: ABdhPJztDSuFvWjC4OFAnvYkMd/O5w33mAN7dD64sG4Ih9InW8vJEpGKkzZEWz6HSxPLg0YWhdBhkeI8PjwP/jgHzTg=
X-Received: by 2002:a05:6830:1d66:: with SMTP id
 l6mr13082498oti.23.1608218258940; 
 Thu, 17 Dec 2020 07:17:38 -0800 (PST)
MIME-Version: 1.0
References: <30c555d1-e019-3668-c35b-021003e2a6e2@computerix.info>
 <20191021114731.GZ2819@lahna.fi.intel.com>
 <f5d7c7da-c7f3-df87-75b9-48db12f640fb@computerix.info>
 <20191021130541.GG2819@lahna.fi.intel.com>
 <cebaf35c-a5f5-94b1-7ccc-0e9636c95bc3@computerix.info>
 <20191021162022.GV2819@lahna.fi.intel.com>
 <313ae966-aae5-92a9-4eeb-02fec9cc43d4@computerix.info>
 <1bd561bb-593b-0576-93b8-eb70f37dcf79@computerix.info>
In-Reply-To: <1bd561bb-593b-0576-93b8-eb70f37dcf79@computerix.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Dec 2020 10:17:27 -0500
Message-ID: <CADnq5_NYLyazVT5pEVyVHA6ZMoPA=4QrCw7MTAYx-rj7JTOPyg@mail.gmail.com>
Subject: Re: [bug report]: Black screen in 5.10
To: Klaus Kusche <klaus.kusche@computerix.info>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 17, 2020 at 10:15 AM Klaus Kusche
<klaus.kusche@computerix.info> wrote:
>
>
> Hello,
>
> I don't know where and how to report amdgpu bugs
> as the freedesktop.org bugzilla is closed...

https://gitlab.freedesktop.org/drm/amd/-/issues


>
> My problem:
>
> With kernel 5.10.x, both the internal notebook display and any external screen
> become black (or go to the "off" state?) when the kernel boots
> (one or two seconds after the VGA text console is shown),
> and the system no longer reacts.
>
> 5.9.x is fine.
>
> This seems to happen as soon as the amdgpu kernel driver loads/initializes,
> even in pure text mode (VGA console or framebuffer), without starting X.
>
> Dell Precision notebook with
> AMD Radeon (TM) Pro WX 3200 Series (POLARIS12, DRM 3.39.0, 5.9.15-gentoo, LLVM 11.0.0) (0x6981)
>
> Tried all combinations of DC/non-DC, FB/non-FB kernel configurations
> (even happens when configuring Amdgpu without framebuffer!).

I think this may be the same issue as:
https://patchwork.freedesktop.org/patch/408230/
Does the patch there help?  It's already on it's way upstream.

Alex

>
> Many thanks for any help!
>
> --
> Prof. Dr. Klaus Kusche
> Private address: Rosenberg 41, 07546 Gera, Germany
> +49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
> Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
> +49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
