Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96082C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 05:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D379238E7
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 05:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D379238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BFC89DFB;
	Thu, 14 Jan 2021 05:13:49 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C3389DFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 05:13:48 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id x5so4173679otp.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ObqK2E7jcWMyiocQCSh52itw79n9P7V/RiyBTicV/Y=;
 b=q6c3OPWlyftmh8IQG4vzaam+sLB2yZNu1Ov6VmRE9Dpwf9fbStSvmbIX7ViCmBe8Zf
 7ohphKaniuI2YaZUtON2/dFWY4YKJeurNsCDYO/pvI1m5KcuY0XEgktpO2nGU9isoSc6
 gVyk1VPvl9A0S7eepMh1xKHoEhqnxR8iNeCskLtbCm8+HLewehUiumhA6YzkuYtJfbAK
 q8IUxCGQTBZ/tau16tHzR68YpISNvkqq0LU3lxTBMZu1xIj2NWY5ivxN7W9Qd7Kfq87H
 U/9DiWMUTlyu4Hx7iv0AUFLhrhvAEHXN/pYjl+ZI643jB3Yky4skmwdWgifp71OiT8ch
 oI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ObqK2E7jcWMyiocQCSh52itw79n9P7V/RiyBTicV/Y=;
 b=pZ8zoi4pd/LV5pNVpbIvdqIWXIXggIusPcqYc+tW3uNoKbUSMFcFgnvzUG91GPeT0U
 uEFIZpA+DKUE5mEA2wzhdYYKLnWf/+1lKjDf9rR+BvVyoy+HsJ3wcVLMbwTnegTEF4mS
 SBndDF5RUzUgVMprpzne2X4F+OH7LiEHlKaFEBblf7IJI2VS/zo4ZVI5jeHuf2oEogBy
 Yyh9acnQgjUcG3fOczEM55xRNc8wKWBmi8OdWaBQLGMqY6oJlcIclEEyOSLZyIOlFN0P
 Dki3gzun+g9z8MBRZANzsmv4vZTeUBaSuzq73mq69bLRm0hWDm8mb981HRVZrf+synoG
 qgaQ==
X-Gm-Message-State: AOAM533PfrmWoMUVZM85+xm17E6vGDi0xzTOLD6u385Bhdszr1iMWks+
 RCpz10X8d45DQmdYe1wnArUq43Hsjwt5hgnCtQU=
X-Google-Smtp-Source: ABdhPJzPSZXD4tp+lX29EOwrtUFurCqOcLk51vi5hTsgLv4KbpwjvmGzXrC/kgLgOqiaguG0RE8b22fGKyjgz+U+JR4=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr3509478otb.23.1610601227683; 
 Wed, 13 Jan 2021 21:13:47 -0800 (PST)
MIME-Version: 1.0
References: <CAKR_QV+SN2Q962_v0WpeCL9tRBUBQpZ+EO6FvF8ZQ-8DG8UwMg@mail.gmail.com>
 <CAKR_QVJ6NRXZhrJEph=HxPe2O_DYwzhE3Hj52BKkX2PGEMoyAw@mail.gmail.com>
In-Reply-To: <CAKR_QVJ6NRXZhrJEph=HxPe2O_DYwzhE3Hj52BKkX2PGEMoyAw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 00:13:36 -0500
Message-ID: <CADnq5_Nh7gdVfPNBix=u7HqUGHjhBuD=juFJZnxphFOpFPAh7w@mail.gmail.com>
Subject: Re: mclk stuck at low state
To: Tom Psyborg <pozega.tomislav@gmail.com>
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
Cc: "alexander.deucher" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 8:51 AM Tom Psyborg <pozega.tomislav@gmail.com> wrote:
>
> Hi
>
> I see the message didn't make it to the mailing list? Any reason for that?

No idea.  I never saw it until now.

>
> On 10/01/2021, Tom Psyborg <pozega.tomislav@gmail.com> wrote:
> > Hi
> >
> > Have an ubuntu 16.04 system here with kernel version 5.6.14, running
> > on a laptop with FX9830P APU.
> > During graphic load I notice the memory clock is always at the low
> > state - 667MHz, never switching to 1200MHz. These two states are the
> > only ones listed in pp_dpm_mclk output.
> > I checked system memory with dmidecode, it is reported as 2400MHz.
> > Same bug is still present with live booted ubuntu 20.10
> >
> > Does this introduce any regression in performance, or is just a
> > cosmetic bug and actual mclk is the same as system memory clock?

Can you provide your dmesg output?  On the APU the mclk is the system
memory clock because the APU uses system memory.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
