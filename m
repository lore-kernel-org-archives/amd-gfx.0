Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FDC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E96E61206
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E96E61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4796E202;
	Tue, 13 Apr 2021 21:24:25 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DA56E202
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 21:24:24 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id g8so29633778lfv.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W1c5jM7vxV5o1/Pbe80kgcBUbwQISNXjbuivu5BPYnA=;
 b=tSH0Bwu+RU3hOIbG1Bg6fXAqfXuigtAoUkXj2dxV9brKx4cz9w+7QUKBGij/1Zv7ju
 nFQYfhlPp4Lo4fRLHip0hU1LT60hGlIf4jhSYj4mkwh5MPLpr7G7YDqJMYUxYXr8djIa
 7BUCyH3ImBn/A23rgCXMp5qcm21fVHJlCLQbNL6swS0YuUPsl0JsIMAxBeSrcgzXhynr
 rQSiSP/UCi8PkbjR1r+lxwhQQb/5zuWBYV4IVl5+kgmpxcFDOeMGJc3UAPJM3MjovUCb
 hFIlHQ9Bt12INg/8mZdlWqMVBsHlFtRIHY+pA0qmBNUkn7l7cP1C0WeGLbg0cond03Y4
 P9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W1c5jM7vxV5o1/Pbe80kgcBUbwQISNXjbuivu5BPYnA=;
 b=BJuW270E3TfHqUGYcWVgJHzEIZpS2UBI6DvmdBgR1vIzXoQfPhqPmNioF39GSl7s6r
 ZgtJTOyo6MEtBn7E41Z5CLHpo7Sd+mtp7kxng1ZmVLinWFFnEHTjmIHOUB+UMfRjZ1te
 3DDKvSESoznwvwUlNJI8SSSDZFPwxDX3AJHkJ2Pptie18FDysvV8Xq97YJa5l+4L4OwE
 hgxYY8JH02aFv5MjIoTsPG9KOjHghwBDXU2xFfY/1I03RBibjoYn/BOVi3zCUyfKoKcN
 sQp424aKT/GKXZFxFXAWW3nkzzzzaZvDpHe9L9J1GXT4WBMbtjyfaM86B4yCdIpHRs5N
 NHIQ==
X-Gm-Message-State: AOAM530BC+4KcbzIP2IFNtahC3V1yX4ZHXhzwDxo0ChGLo+ZB0tfrW38
 ASRyiPMf+cjhxFuj6rbiEASdGZXTh/mOOYQH+38SzS/5SyyaWw==
X-Google-Smtp-Source: ABdhPJw9vdaonEroGZJZgdpI08/p5hdytj3n2dZvmmOymzvGKFJQvrZaYruiKO2YtbYyTATEVxMsDs67t0WyhUBrI7s=
X-Received: by 2002:ac2:424f:: with SMTP id m15mr20991652lfl.66.1618349063073; 
 Tue, 13 Apr 2021 14:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <159a1ebb-07a1-f50d-5a6c-f4345eb97c3f@amd.com>
In-Reply-To: <159a1ebb-07a1-f50d-5a6c-f4345eb97c3f@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 14 Apr 2021 02:24:12 +0500
Message-ID: <CABXGCsM7z9Vmsh420MykJ8FzaCiSMWdSGCCvtYG2XrQKaw+SLQ@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Leo Liu <leo.liu@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 13 Apr 2021 at 04:55, Leo Liu <leo.liu@amd.com> wrote:
>
> >It curious why ffmpeg does not cause such issues.
> >For example such command not cause kernel panic:
> >$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
> >'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
> >h264_vaapi output3.mp4
>
> What command are you using to see the issue or how can the issue be reproduced?
$ mpv output4.mp4

And of course, I know how it should works because when I encode video
with CPU encoder (libx264) all fine.
$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0
-vcodec libx264 output3.mp4

> Please file a freedesktop gitlab issue, so we can keep track of it.
Here? https://gitlab.freedesktop.org/drm/amd/-/issues

Also, I found that other users face the same problem.
https://bbs.archlinux.org/viewtopic.php?id=261965

-- 
Best Regards,
Mike Gavrilov.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
