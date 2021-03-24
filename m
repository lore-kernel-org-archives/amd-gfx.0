Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B9C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0779361A12
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0779361A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9F66EA40;
	Wed, 24 Mar 2021 20:18:28 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA5A6EA1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 15:32:54 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id u9so3092679ljd.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=izPOmieh1WevNujIwbAbL3OCIGkPjE9MVyJVOgBEtC0=;
 b=GXPU6UVxcNBB1W5pdqZxUcCvkqUaXc1PQ1SD7DVlwqDi1RCCzHdvPP+enpOlhWdyaG
 BiBzy+GFpja1pfdj9b5Fq4/6Ecf+dH5X7+osSKghK3uaFt29fJlL7ixqJUSh07K9dcOb
 3y8x5qPfLq5K+fnrdAWTqA3VtH7Apqrxu7OKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=izPOmieh1WevNujIwbAbL3OCIGkPjE9MVyJVOgBEtC0=;
 b=kHystKJfctnLtyALRZb/0ViHuwfEoDRb4NOlDcVn70Fm8J/P8qpZTbpHLESnHszQxP
 fbbqmSZfbiFlP/nk7DsIZTWxw/L4DbHuxlK39yiY1dS6tykJg486td/Oa5vIibkwiqzc
 mZcXnmvxu5J9r80xoPLo0fI0kS3fxqcHN019P2kgh0GLkK0Xjp1OiFlzW39mtLIVGifQ
 po0DcrVjgvY00SJPURzmVH/tlu8ZFLSHu8nvrhRgOL81yel6YoFPO06l+G7gp86BrKXL
 x/Zr/1/hJVI0/tvYPyEXqnB443Msw5hkYj3TL8UmkhWOowssDmhzhLTIwzmcY8/rS71v
 rsMw==
X-Gm-Message-State: AOAM530Os+D9RtnWyHi9FRAgxUlGzodXZVrZBfMUusL99BA4LYWhFDnJ
 VQAfU3HY0ACN1HfxgeN9cPrNFDgqWMCNJKgDgEKO+g==
X-Google-Smtp-Source: ABdhPJzZGpJaY54yuPyrvOaJAifQDTulUlejaz+CQ+C1jq4wkC7RDiMZzbxvKHmkxqci78nRS1gxWK0y89++eh7Vv8Y=
X-Received: by 2002:a2e:810c:: with SMTP id d12mr2545673ljg.49.1616599973170; 
 Wed, 24 Mar 2021 08:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210310161444.1015500-1-markyacoub@chromium.org>
 <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
 <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
 <b4070483-5aa5-c712-6435-dcb4a206ca76@daenzer.net>
 <CAP+8YyExtmmZbFfAO_YR=XWHE+HbH6m7JqyJV4LB_hbGwsihBA@mail.gmail.com>
 <CAPj87rP+WkUPbS3yyGGfy0SRm_hsnCCUav99Dg2Q+tXCiJ5D+A@mail.gmail.com>
 <CAJUqKUqQ0yrxpr+QVRXYXMk1hBRNByD0TP6mM0oLY54jDZimbw@mail.gmail.com>
 <CAPj87rMGcha9jGe3rRH8OvMxYSo42z1d0ZCxhRUxz+aAXMow2A@mail.gmail.com>
In-Reply-To: <CAPj87rMGcha9jGe3rRH8OvMxYSo42z1d0ZCxhRUxz+aAXMow2A@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Wed, 24 Mar 2021 11:32:42 -0400
Message-ID: <CAJUqKUrWsXdipa2FRMBFEWR0MfoWZ2O6BCXGnZs6CgKP559sBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
To: Daniel Stone <daniel@fooishbar.org>
X-Mailman-Approved-At: Wed, 24 Mar 2021 20:18:27 +0000
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 24, 2021 at 11:25 AM Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi Mark,
>
> On Wed, 24 Mar 2021 at 14:58, Mark Yacoub <markyacoub@chromium.org> wrote:
>>
>> So you mean it would make more sense to be more explicit in handling
>> DRM_FORMAT_MOD_INVALID as an incoming modifier (which will, just like
>> DRM_FORMAT_MOD_LINEAR, will return true in
>> dm_plane_format_mod_supported)?
>
>
> That's correct. Not passing any modifiers is the same as explicitly passing INVALID, both of which mean 'the driver will figure it out somehow'; that driver-specific determination is not the same as explicit LINEAR.
>
> (I cannot regret enough that INVALID is not 0.)
I feel you. When I tested it on a board that doesn't support
modifiers, the modifier value was Zero. when I checked it, it was
basically LINEAR.
I'll amend my changes to explicitly handle INVALID.
>
> Cheers,
> Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
