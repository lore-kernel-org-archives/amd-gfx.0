Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03317C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A358464E25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A358464E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388746E153;
	Wed, 10 Feb 2021 04:43:29 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEBB6E153
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 04:43:28 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id l19so689496oih.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Feb 2021 20:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZeXXgOnylFrgrNNUJdDlwKp1GE8V/SgpX284Wk8jjiE=;
 b=CnTt4tKLmjTY5bVR4MBMYM3YqKQgjGViPjwMohyigLl/Yh1Vdstg4LA3LqNrHd2kEi
 tbN6UTtvcKYsv2vsO43QSjNzKXs2UCBlSD6SDbW7dTqI21FX0cA3aN0cRcY9lBsjgWB2
 Rz1sPJRejIu8IT/bm1pW7qU+EWVjPRsoQlJtlxb3XUxB8uWNuMEyhaaRx9EcapTk7Q66
 3VXMKLWO4bH51Vak9sxnalrmUzNbFwGDJxve6BzK7+ZppIcO3f+P1YQp+tyIvCoyHHQQ
 AzyUjMzbgduW5OJ6Up5VPYo7NoCtH8u5VeJI1IUL54NpWfKvL7FFjcwI3+uW059q3t00
 PlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZeXXgOnylFrgrNNUJdDlwKp1GE8V/SgpX284Wk8jjiE=;
 b=LNieMQg18j+6DFSVklMXfLJkirF2zeYCjAqoVrWAU1g68Me1x/bg8SK40d0Kv7u6zx
 f7RXJZcrVz5K7Gb0VA0jRbYlcNSb1yA/4mwjP8vGx3HJUMr5wdG2oX5bBfzGtTvCqk7i
 I2mMNVU20w7hhKZ0inBXMubfKrsoWuKloQYEMKR3pENvBaGmlrK4eiB4Vj/k2ECupp/S
 ZlzdbIi0Jh5PjdqJMb82Bdgi3QJPoRnlY+aeIpRhKCqQ+dOgLb/28pkgwB2IBusY/SJd
 PPw7CnLvFxOJgRgvRTKWbUzrXnyp7+RLKE/QdNlX1oXazKtwhnjFOIqloQzVFntVSqeX
 k/mg==
X-Gm-Message-State: AOAM532qm6r7LM07pezuCJJN9+hKksqiF4JxddOsRMZ8xL5D+0ad8LN9
 KoIuTLovZgA43u0Fdwcw+8uYm14CVIwsgTQHJns=
X-Google-Smtp-Source: ABdhPJyH2DXKRrQx8j8aeEiEIZvhPfnL3MRueWYBB85O0l8oDRsJMlojUw3YtSz2HRibqXNNsupmKI77jXcvuVygFVY=
X-Received: by 2002:aca:c786:: with SMTP id x128mr865503oif.120.1612932207931; 
 Tue, 09 Feb 2021 20:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20210129212752.38865-6-Anson.Jacob@amd.com>
 <20210210025742.7855-1-youling257@gmail.com>
In-Reply-To: <20210210025742.7855-1-youling257@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Feb 2021 23:43:17 -0500
Message-ID: <CADnq5_NF=Q3V0FJNC5ev3XKoewm8bekSDEycXCwKTf6KX+xopg@mail.gmail.com>
Subject: Re: [PATCH 05/27] drm/amd/display: reuse current context instead of
 recreating one
To: youling257 <youling257@gmail.com>
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
Cc: Eryk Brol <Eryk.Brol@amd.com>, Anson Jacob <Anson.Jacob@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 9, 2021 at 11:02 PM youling257 <youling257@gmail.com> wrote:
>
> From: youling 257 <youling257@gmail.com>
>
> This patch cause replug hdmi blackscreen, https://bugzilla.kernel.org/show_bug.cgi?id=211649

Can you test with my drm-next branch:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next
Are you able to repro the issue there?  I wonder if there is some
additional commit missing from 5.11 that causes the issue compared to
-next.

Thanks,

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
