Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3170C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7524C20663
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osttgXnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7524C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7B26E201;
	Thu, 12 Mar 2020 14:13:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555A26E201;
 Thu, 12 Mar 2020 14:13:06 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t13so120216wmi.3;
 Thu, 12 Mar 2020 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ZQgburGOOGmv4RWs5U4M1z5J1veDULphtrYnQJdpvA=;
 b=osttgXnp9s3DzDGznRj8yQb8aW3xDZxQnv2vruUMSqZNUkQC2lQ8Z6gsnIzcju7Cx5
 scoUOxawMh/xbpeLsyuBqQeBBaQzir9kT5UOcU2D8is3tCcL4ezdxasIDfpiNHbz1g7H
 BYGj5vRlVK2FvebuA5SrRbp0YY2OdbDPDARxhV4xPEFthGcagjVfdd5mxz37kC6fuMgn
 LZXHfBiK/Eddc9OdDWsoEqioyg5Ij0zrDC47MISa5m6NhyalMgc081BMTFbLenasgnCI
 oVbgwESoHl5nqNwkHSXZRTMOMb5VFOd13j3oSvyCOblicmTgLYP0o70RLAHOnZtJvrpY
 vlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ZQgburGOOGmv4RWs5U4M1z5J1veDULphtrYnQJdpvA=;
 b=CQjqWjN8NVjfuIMTPKmexyUh/0VMHgaIT4wiIH/7FnCGLA3SUUc4FcQWzrEoecPRCa
 wIlZNuRMLRwdiASoHu1tL9pqxOX0kdo3XHuKlaN7DZ7X/YYN/344UlJBS7UgKwk6czMk
 Mua8mQXIGgkHalO6aLu5esWZoiz9+eV/0+vE6zM0ZB9XtLfH1wKRt0v+Xu5FfUV73JT0
 e9iP979mT4NZHN2uLHeh2KAhgKUvUURzqv76wnlPjOCAU1H9LinQ/09nvEpIY8pM/qw1
 Ix7H/XEThb85d1b+VhMASPNFHq5KNiGl8XGpysHWt7jSF/181kHZsuWW12uEVxGKnOA7
 2Nfg==
X-Gm-Message-State: ANhLgQ3Md/7TxZsKn8FMXl2JhU51pYJrpJKP1Qf9gkt6erfvYOKejS3U
 zQMeiY8pIu3JF5LkVij2Oi3jeX6ubVAo0Dhr+ZI=
X-Google-Smtp-Source: ADFU+vtwVpkNC3AQTYUUgAKILzm0mOEzte8veCiEEVhf4jfVA0AQoiWrcFwV86WhV2txz+JGeINE8PlDAa3AL1STTsM=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5121813wmb.73.1584022385024;
 Thu, 12 Mar 2020 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com>
 <3cfc40c8f750abc672d6a60418fe220cb663a0f5.1583896349.git.joe@perches.com>
 <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com>
 <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
In-Reply-To: <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2020 10:12:53 -0400
Message-ID: <CADnq5_N5Ssc3rjY9m20t7UExkP5oBjQBpxj9wY6RVsqyuYwR0A@mail.gmail.com>
Subject: Re: [PATCH -next 023/491] AMD KFD: Use fallthrough;
To: Joe Perches <joe@perches.com>
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <felix.kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks.  Link fixed locally.

Alex


On Wed, Mar 11, 2020 at 6:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-03-11 at 17:50 -0400, Felix Kuehling wrote:
> > On 2020-03-11 12:51 a.m., Joe Perches wrote:
> > > Convert the various uses of fallthrough comments to fallthrough;
> > >
> > > Done via script
> > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> >
> > The link seems to be broken. This one works:
> > https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
>
> Thanks.
>
> I neglected to use a backslash on the generating script.
> In the script in 0/491,
>
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
>
> likely should have been:
>
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe\@perches.com/
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
