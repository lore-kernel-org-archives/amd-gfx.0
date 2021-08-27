Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E05FC4320E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 18:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7BE60FD9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 18:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D7BE60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694096E9A0;
	Fri, 27 Aug 2021 18:05:08 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FF46E99A;
 Fri, 27 Aug 2021 18:05:06 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id t4so5231963vsm.5;
 Fri, 27 Aug 2021 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=88JiBN68KFkPvgUKvvgM6auDxOEjKddEpXMvH74tSU0=;
 b=OlwWwQfPg4x+JJlvPNh300Bq1LWQakwQ25UjGQSFu+e/ONGVka7NnKHJa+lgNw1pXV
 O/VaBhbQV0p5s2/S3HszX9pzR0SadV3bqBaL/0a48gJ9IGvbaB4+SIEcxTiCHR7KQJ8B
 J1a5QBQJPr4qWh90Oj3DuALxdosTczcnDdni2cSNTkI8cSuqR8wklMDBXc8ldGdEK46o
 0zcdpFqpN0s/xEFW3FLjXWWA1ZwBWL+8GLjzKkkgYnRZh7SCSIlTLkDqH2XmtErs4aPk
 1rqZ/YjPwLsXASog5KOY4AHNWfaWbxESg1O/qpwsb3e0lfivzJjauzD88S0GagWg5pQz
 pVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=88JiBN68KFkPvgUKvvgM6auDxOEjKddEpXMvH74tSU0=;
 b=HZ5nwJ+TfaN1KFaxclzph4OsR4Ac4WJ+aXTexK3/mFEWC0hTHMDmX/PmX4IbhL/Wud
 htPomGH0Z9Sh7yTsqhhAS3+iGBAmJnG0tc1chHc54Q7vU1y74EtmgWBOkhYCLZeGCOMp
 kudfJWOiy9PC/2N7GTGzFCLVWJB53FvB0GswENKL5p2kolhhtBHTWVcljJbf/mWzIxww
 TdTz6nyEuBD5sPVAbhZkqV+0HamwQaLKMMyuRcAQmCEhsnFzcqaf5a5zbyZlcI7SAc/n
 EujE3XL3dLH3n8lbB9dUzE9wIfOx93C93vE4U/6WqczxBWoDEDLgyhIFwTGdoKo3znDq
 +A+g==
X-Gm-Message-State: AOAM531QQwzkzafoLtctztBdf27KkcF0gSQd3fDzSx3cE7M+NzNmRgG+
 t3O3Pkqr1RoRwbS+fI61Jdw9EvgeqingDzxUll8=
X-Google-Smtp-Source: ABdhPJzGaciYM1/s8m8/B975vUfIbvCRz+B6Bp+lNCm9eTPHyZtDPjmUuOFML4/BZkts2fosFQFBO2nGMugI2IF9+i8=
X-Received: by 2002:a67:c789:: with SMTP id t9mr8673774vsk.60.1630087505693;
 Fri, 27 Aug 2021 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
 <20210822222009.2035788-2-jim.cromie@gmail.com>
 <c83b0814-b8e1-91f5-ba28-f9db3f363ce1@akamai.com>
In-Reply-To: <c83b0814-b8e1-91f5-ba28-f9db3f363ce1@akamai.com>
From: jim.cromie@gmail.com
Date: Fri, 27 Aug 2021 12:04:39 -0600
Message-ID: <CAJfuBxz83LUFqPmApV22d0R1pHxFH4ZhObi7PgQeQ75w4zvb7A@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] moduleparam: add data member to struct
 kernel_param
To: Jason Baron <jbaron@akamai.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sean Paul <seanpaul@chromium.org>, 
 Jessica Yu <jeyu@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 intel-gvt-dev@lists.freedesktop.org, 
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>
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

On Wed, Aug 25, 2021 at 11:13 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 8/22/21 6:19 PM, Jim Cromie wrote:
> > Add a const void* data member to the struct, to allow attaching
> > private data that will be used soon by a setter method (via kp->data)
> > to perform more elaborate actions.
> >
> > To attach the data at compile time, add new macros:
> >

>
> I wonder if kp->arg can just be used for all this and avoid this patch entirely?
>
> define something like:
>
> struct dd_bitmap_param {
>         int bitmap;
>         struct dyndbg_bitdesc *bitmap_arr;
> };
>
> and then just pass a pointer to it as 'arg' for module_param_cb? And then in
> the get/set callbacks you can use kp->bitmap and kp->bitmap_arr.
>

yes, thanks, this is working out nicely.
I think I was thrown off by the arg name,
if it had been called data, it would have slapped me

> Thanks,
>
> -Jason
>
