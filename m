Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02EC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A20601FC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A20601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A170C6ECFD;
	Thu,  1 Apr 2021 18:22:20 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5BC6ECFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 18:22:19 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id x2so2688986oiv.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Apr 2021 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IMStuWpp3QD7fvHtiQJB3rR/G0xrekwPTTD6r8qMln8=;
 b=LT/Dr0X01sJ0NavA8JMBqte6i85URirf41Pu9HBab8qAR3vXnzTo1SYQCd3P1NYtHJ
 EQVV6T00hxRDQjfD0y6Txgp5wC8CZhVnBLmQV57jOoq3sUUiI3tpZw0FXb5J+Tz2B3mm
 PhWhjL7HqH/LjfM402hYa/uR4a9vNG8CcUJRuOjcbwvbPcezNmjsqLYqV4Yt9bJbZxEF
 T54uXQHx8yj4/EQEJsUB+Cz8lQRTZrYJUI/9fj0TMOIQeqnZ+dXL4GxjcMXwmK2WaUUW
 Y+ukZgDvTZoL/WFlkWPGG9R3Uh5+XOENBP9P9zS1qQa08YIzN9i59yuyjXUkK/KHhBgA
 9P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IMStuWpp3QD7fvHtiQJB3rR/G0xrekwPTTD6r8qMln8=;
 b=OHs4bjLRVAj8A+Xl/gs2vlbUSOREEiQZ9DtfWNcOzAwtobLXDoY6rnE0Si2HOf4jL6
 Q7IRBkaRkA2oQHgmdc62Y6129sLoDv06HUUWqpbKPwB9i6lfYXUVqrYD/NeeaF/I9XN6
 zTW1HMGwgvj/TCGluvzjMryWOxgXurWRnJmuWvVzDOoBQaCFG0TQrCamY4Cw511t40ny
 M9Oo/wjWUqf8hmGAo39mQmuLw5gPAS4QVQemx6/h/hPeH937HqRrk5VMGRlwyMVue52W
 Y0gtFuU6VZs4/W76XnsVbfqqkRCmYY92ZvsdprsrFvkYIwezXc32uwSpmIlRfmnw9LaI
 b2Ew==
X-Gm-Message-State: AOAM5332KhAKsdOc3AFYhtCpjQjUTTDK0NMNrsDRNVg3mgKbV/bGy0Yv
 YYuwbk51/NhzCoRejy/vlP7dGTcnMFmrq+4Qg/8=
X-Google-Smtp-Source: ABdhPJyCAE2LrblzytEefYE9SBsdLgz/7WP0qRUy4z+7cVNAse8czo9sv7h9q7AIZUfT0h3ngPSXgSBkHj7QayUJ5bw=
X-Received: by 2002:aca:4748:: with SMTP id u69mr6646305oia.5.1617301338703;
 Thu, 01 Apr 2021 11:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAGztBWXhxjoOAQ2AbiR0KGEV3g0dSxYaWwUGnOg8w70vCW1VuQ@mail.gmail.com>
In-Reply-To: <CAGztBWXhxjoOAQ2AbiR0KGEV3g0dSxYaWwUGnOg8w70vCW1VuQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Apr 2021 14:22:07 -0400
Message-ID: <CADnq5_NF6=_cDEW8gxrbEd38EAxfh0y9je9+F7fXKV1Eojdqqg@mail.gmail.com>
Subject: Re: [amdgpu] Compute kernels still run when the host process exit?
To: Smith John <ls.cat.kth@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 1, 2021 at 10:08 AM Smith John <ls.cat.kth@gmail.com> wrote:
>
> Hi, when I killed an OpenCL host process, the kernels it launched were not terminated, and still run.
>
> My OpenCL runtime is AMDGPU-PRO 20.20. OS Ubuntu 18.04.5 with  Linux Kernel 5.4.53
>
> I was wondering if it was a bug or the driver did not implement this "watchdog" mechanism.

In general, once you issue work on the GPU it has to run to
completion.  It is not stopped if the application that issued it goes
away.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
