Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE7C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B160246A1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUtmERFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B160246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A6B6ED41;
	Thu, 27 Feb 2020 21:04:24 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F956ED41
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:04:23 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p9so985449wmc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/sHz3cKSHYIwI2Sz5/foVEHqq911dVZYLRiY/yC+2Xw=;
 b=cUtmERFvoR+8BD3I8SOariCSLrOydTY+BKUbSjbTb78Pcp6YnbqW9GEBoRyOqPXq63
 N9RuoTJz3f6UmuuWkTjArdQanTpMoiaqYvBwIkVB6rNAKEL3frRIPYAXyJB16TzE2QY9
 UeenhYkg10Ussojpm5zrLwQRgRWEGMP5dKgaDPPA/2pftRMEE6w0ra/E3f7Szw/9kgN2
 SrJdCsH6k0yKg9wgCELCFXOObAWLppy24j7XGPYXkf25YJX2MGerwFmXcgA6tSx9I4I0
 lrioa3ZToKNSKC0ap/T+7CpMASlqrrKwt8HX/1Pgb0XVaXvV+/iqdg1vBfFupgB7j0KG
 pdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/sHz3cKSHYIwI2Sz5/foVEHqq911dVZYLRiY/yC+2Xw=;
 b=hJHye69F23pvIxAcdnve3JsNcO/k8Uco22Whg8M+v3me7FO3pK9+odnwM4fQoPMt0z
 DEveFeJv0yd7Bh0MQflrSqBqpnEI6MUS4P9grNXxNhlNOtnpTGDc/y5tlDLJ/kv76reQ
 f7Hh3rl0LP6CDG+FMadAjRALS3velAvHAaOpv1iGS5nrQSXakZm473+FvJailC9V9wNk
 w/9Yd8g27NzW9X5DaxyqcK6U6FoGuURaXHm2E/zjOueQ1Scgl2qn4PAEfNw4RhLA7gqN
 l+Ps+WMdad0aFXBMFYGEBBv4DL3r1bZ2D253Ip4cz4P7WOcnHHgf8wesqIPn8r2FWH13
 NjFQ==
X-Gm-Message-State: APjAAAXwi8ADFWFhpo0+6E3rVPOyxDPg5Rm7dLJyBBydNNCMs4l9fLoj
 qI+hH71DqiUnqaze237/B8oey5UUaKoymfm9Y46PwA==
X-Google-Smtp-Source: APXvYqyw6TZXDftlcYvS5ryryss3Xhe73btUL12xVtJULRWbfMsaGa6KMwTwlTWFMSoQLZ/uhgyYfP+HihCvyyqW1hM=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr646364wmc.39.1582837462045;
 Thu, 27 Feb 2020 13:04:22 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>
 <cover.1582758921.git.mcoffin13@gmail.com>
 <CADnq5_Mco=rKBNc9JfZZFUK22AaXMM4My7=AcxzQ1QUTseN_sw@mail.gmail.com>
 <06eb44df-572d-2aaa-47e3-407505e56c6c@gmail.com>
In-Reply-To: <06eb44df-572d-2aaa-47e3-407505e56c6c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 16:04:10 -0500
Message-ID: <CADnq5_MteAXm_vbYx9S9wJa-r75rN7-b_TA+VojTWE+mKeTRoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Implement SMU message register protection
To: Matt Coffin <mcoffin13@gmail.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 4:01 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
>
>
> On 2/27/20 1:49 PM, Alex Deucher wrote:
>
> > BTW, I think you had another change to clean up some of the navi10
> > code, care to send that one out too?
> >
> > Alex
>
> That was in there just since I was doing some debugging related to
> https://gitlab.freedesktop.org/drm/amd/issues/1053 and voltage levels
> being different on linux compared to Windows at the same overdrive
> settings. It's not of any use (currently), so I just left it out. It's
> not related to this patchset. I'll toss it in the series I come up with
> that would fix that issue (If I ever get there... I'm pretty stumped at
> this point).
>
> Thanks for checking, though. On it's own, that change would have been
> functionally moot, only required if the GetVoltageByDpmOverdrive SMU
> message becomes useful in the future.
>

Gotcha.

> Not to piggy back on this, but if you have any results, negative or
> positive on the voltage problem, or power limit firmware "problem"
> (https://gitlab.freedesktop.org/drm/amd/issues/1043), I'd love to either
> help reproduce, or work on a fix.

Someone is looking into it, just had other priorities before they
could get to it.  Will update the bug once we get some results.

Thanks!

Alex

>
> Thanks again for the snappy responses, glad I could help out some more!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
