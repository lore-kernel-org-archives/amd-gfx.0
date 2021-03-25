Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B7C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFB961A11
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB961A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FDD89079;
	Thu, 25 Mar 2021 16:12:21 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B966ED92;
 Thu, 25 Mar 2021 16:12:20 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 w21-20020a9d63950000b02901ce7b8c45b4so2447042otk.5; 
 Thu, 25 Mar 2021 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XAKcexRoaqmSV+ga5FMWaKZ2LD2prEBZjj1CEnzFUQI=;
 b=eKIjpZuiC+2lpxSYfEGvjUJEA2TEAFaLbUG91dV/D2pPx+gPSiLIhm0LsZHqEADRV8
 lpeFYaA7oZ7zUP4LECBTrhQ9nLzjcYzz0HXbz7ikkItOSHvtFbTrq66TfL8rSiRXCDy/
 vDfXRhrqEWG/yUh1XRmQ9H9AJ0870gFMd9vm2SOcOxMh0t+6O6UB9gBhnWLB4XGrCSut
 cnLLe6mY1UqAxWsoQnrmeBYi/isBBwclq5SUElgZ2BH+t1Wes+yPX2ON7/KRTQ3Bt2W2
 Hr83BmNoTLeHjScCoAjl3hzXjoY8xfAIv2lnE9N/AfCi2CnCQTVgAuLMgVgn8pMUjSKH
 RGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XAKcexRoaqmSV+ga5FMWaKZ2LD2prEBZjj1CEnzFUQI=;
 b=Cukjzk2HFjnfjsAoJPQ033f1v9Ej/lrDpOgyq3PE9EI3HPWcBW0Zu+vxbyOn8aKwYW
 /EJyAZ0wDnSRRy7PhhanIGYbzL+91Al+/tXL3yY9vtllP3zYmPFwaHYTnynpjcp3SgUg
 wOzURIIVV4hXw7un4Y5VZ0Gf+VOw4vGDCMATqIGWYnsfEA1Kthxdt4ZmuIuXX7oc+NkA
 FV4D12FtJ+78ebMM8nV+9pUUSFz/ujj+AHdZIrdmVkeM/7Gg7mySH2yIugjRA1Zfqb4d
 1yd1PzwtGORWuAfKIyihX0AmnAoiqo+K6iDtAhwt6bqCCwpnD9MIH/FM6I7UCNQvN/dv
 dxXg==
X-Gm-Message-State: AOAM53397phm4nfm4OtcgDiXqu0VFhoQUlgnH9tCxF0nIgu06ENnuSEc
 6WwE5BYMyyHIdDkYhlK49+UbTaZbtM1nNcfcL5QFHgoQ
X-Google-Smtp-Source: ABdhPJzzAqGsqkVEwsFdmh9GNTAnM7sxcfDdDo3i7fxrmRn+k129bfD8QWkWqDJbKayWcUVREsEJHQUpPf5SguF8vU0=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr8337664ots.23.1616688739885;
 Thu, 25 Mar 2021 09:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <e557c681-4218-dbe3-4e92-f6eaf352b614@tuxedocomputers.com>
In-Reply-To: <e557c681-4218-dbe3-4e92-f6eaf352b614@tuxedocomputers.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Mar 2021 12:12:09 -0400
Message-ID: <CADnq5_N9AqX=Lx=yVKCFQahREFT6SCER17KMbZyw-iQ2wnTVqA@mail.gmail.com>
Subject: Re: Color mode exposed to user space?
To: Werner Sembach <wse@tuxedocomputers.com>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
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

+ dri-devel

I don't think it's currently exposed anywhere.

Alex

On Wed, Mar 24, 2021 at 5:11 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> Hello,
>
> is the information which color mode is currently in used for a display (RGB, YCbCr444, or YCbCr420) exposed to user space somewhere?
>
> If no: Where would be the best place to put code to expose it to sysfs?
>
> Thanks in advance,
>
> Werner Sembach
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
