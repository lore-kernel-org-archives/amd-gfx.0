Return-Path: <SRS0=zsti=PS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E381C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 01:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CC76101B
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 01:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05CC76101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BFE6EAA1;
	Sat, 30 Oct 2021 01:07:40 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236236EAA1
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Oct 2021 01:07:39 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id a132so10033885qkg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=P2wuB9b7qR64DTDls4Ah+rlCgCIq9Mbz559x1jZFgQI=;
 b=CEpgg1A25LUh7VmfgnM9/jIKb8mBh/lLhzuki3vju1KTv5RVEAjmOm2M5JztIDOv2i
 670E+cPFnLP7K9oa/QzuFJzGtlZv1NgzWachnzzVzeqVhNCvMnnI6mab4GsDPsx8rXTT
 jHsXI2VADg2of4PXfGePkeDN0S7Yn1beshb2qt7rO3ug24KrxnTmEyrBlKFAue/2DJ48
 oouYwSYUJ2GU1aNuaUyyNBOdE1CD46kPxlJWSo5clgJ9QpBUx7t2XOFcrcL9RMKWEk+8
 Ls1XuB/EJ2G9GZn+6hWSjyjlmZ07h5Qlgq04bQVEvTu3z8puSgyLaESuSEKKhkE8nBeb
 M5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=P2wuB9b7qR64DTDls4Ah+rlCgCIq9Mbz559x1jZFgQI=;
 b=w18nex6do2M8ZQ1WA1fyv2PvvSYzFAUa9Qw+Wiza8QXXcfB+McgWYGmij7F51XYTVb
 dK+04Lcl/ZJqzTD4FgulSwGWazLHfgknDM4ApT05fDjxtJ71C0I8nVSXfJ4Figfl+12P
 baC6AAt/ZOs0a1f9FJA8IYyNDSvWdYwfHHYHsSzlT40Co3gSkyxF9P3Avv7EzNIrh+8/
 kdne935iCDzzAb9tjxaYYuO/f8NxT767swiFXHHEqJNQLqpikjNNOJavP16LQfHnWSJG
 dLpyW0+PS9HbXF8g9TeXhnSHV7Gf/BLJjLJl2Uzh7Qkj22e03Gpc5vrUTCVpPx2XjDQc
 1Spg==
X-Gm-Message-State: AOAM533kvU6vnptcHJPfIloORgcK7JYLyUbcKhUhCbVyzhXlg2WTmjxA
 A7/YZB8zU6Y0e/itzWyXnOg=
X-Google-Smtp-Source: ABdhPJw4a3i6RVsQCFUN8/fXqqIk6W0rtUnHB2/OrblEGj2xsBJ4AvsNCX4UhF1F4aTnDxjvW1JUbw==
X-Received: by 2002:a37:b206:: with SMTP id b6mr11571893qkf.447.1635556058131; 
 Fri, 29 Oct 2021 18:07:38 -0700 (PDT)
Received: from mua.localhost (99-169-220-75.lightspeed.miamfl.sbcglobal.net.
 [99.169.220.75])
 by smtp.gmail.com with ESMTPSA id n19sm5487932qta.22.2021.10.29.18.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Oct 2021 18:07:37 -0700 (PDT)
Message-ID: <2d9179a2-5d80-8609-58ac-64090941e5a2@gmail.com>
Date: Fri, 29 Oct 2021 21:07:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU
 + kernel 5.14.13
Content-Language: en-US
From: PGNet Dev <pgnet.dev@gmail.com>
To: lijo.lazar@amd.com, alexdeucher@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
 <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
 <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
 <27b8936d-ba79-cc13-7768-692565bedc2f@amd.com>
 <9e964b4c-6a99-6605-63ae-f42537fd01db@gmail.com>
 <8684c741-4604-440e-870b-5ee81bfc110c@gmail.com>
In-Reply-To: <8684c741-4604-440e-870b-5ee81bfc110c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: pgnet.dev@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I got this comment from ASRockRack support re: the 'purple' screen:

"
Did you also get that background color in the BIOS menu? If not, it appears that this is the color may have something to do with video driver and it seems to be common with open source operating system. I came across these two forums with similar experience, there are some solution mentioned that might help you fix the driver issue.

https://forums.linuxmint.com/viewtopic.php?t=202548
https://askubuntu.com/questions/1219150/ubuntu-19-10-stuck-at-purple-screen-during-boot-using-kvm
"

Doesn't seem like either of those two are a specific fit.

But the point is that ASRockRack is suggesting it's the driver/config.
