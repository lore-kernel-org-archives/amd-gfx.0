Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71AC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17676611CC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17676611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B179A6E09C;
	Wed, 14 Apr 2021 23:10:59 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D290D6E09C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 23:10:58 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id m7so14218663ljp.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=azU0aUDJAvs0H7CoLdzoWsm0gYgYKMEYtjMz7QFyXNM=;
 b=Nt70CLzDUToE2TC0xWIJ6v6I/0cBYUmaiIa1SQvB4mNsAa4fV3PVACnr46Z400XJB6
 EET0huAMczwfKDOA1sRimGuykUwuDBBwg221LgSFt7tj7WfGVIQnYnhLAX7aWgZswhrK
 2AXUCFEUsmFPqujI8xUokqbaj/gI/s2G/XchRuheZCUYmFO32TZTMVBJnMHYQUwAdVAv
 MNWpUdDiFRGdzUreB7rHQ9h+a+J+V4FrQaWBkrFV7qQDaFjmzebyTiQs5XVZBFlGX5Wj
 o9x0w2PugSJWgxYb9QaeDs4h3AWtCgtrM5fpNVJTBZHKzXtY11R6gMKMJiQ4aEtrP6Hn
 dEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=azU0aUDJAvs0H7CoLdzoWsm0gYgYKMEYtjMz7QFyXNM=;
 b=nloPS2vbBHSN+QwKrxz/uh2ZtXF1L58nAhVzeReSK9vKqebcSIgrRlCubk2J3sZgF0
 MPx438UZ5pnnQnHTYAFQeykpsFjZzVMEsVECAYaU82hgjaSrPVJjAMBTwkilsRe5v4uQ
 X/+XUCWG2poV9T2Y6v5bcoT4rxSkK491t5vGCrIRT4IQ7LvdRForFl8iMMSXzps172y0
 3TXwzZV1Ug8eR7B7lcPgcUjHU8g4v/zsQXQMeYbpRD57aSwj+iNvZ5QHaWyJdYK1HA7J
 C84gV0Ui00woa7VqvuP7dc29JfCEhWbdzDjtwn3oF49zF9jPXAoxswqcx2wg+bSjmyIm
 OyeA==
X-Gm-Message-State: AOAM530Wloy7EAX35E0D8enBEdcrKyQ190ExJo4pd3k+aAQYsWT+0BgL
 WtOe6yGxdtT9O16dVTITYVOXTftjhaA1G3KUy/Q=
X-Google-Smtp-Source: ABdhPJyzbMN9KlRx0CAQrJ40RP2iOE2289A9R7Kgz8D89DUZ8ghaphQg+3MFz1wAg24wK1ZTcj1NlEra6t09B2fFp1s=
X-Received: by 2002:a05:651c:312:: with SMTP id
 a18mr192305ljp.52.1618441857138; 
 Wed, 14 Apr 2021 16:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <159a1ebb-07a1-f50d-5a6c-f4345eb97c3f@amd.com>
 <CABXGCsM7z9Vmsh420MykJ8FzaCiSMWdSGCCvtYG2XrQKaw+SLQ@mail.gmail.com>
 <f253ff1f-3c5c-c785-1272-e4fe69a366ec@amd.com>
In-Reply-To: <f253ff1f-3c5c-c785-1272-e4fe69a366ec@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 15 Apr 2021 04:10:46 +0500
Message-ID: <CABXGCsNEF+0OYmphA6MV-RhC5pMVKSVxY=z=zVfqSqEDDkjy9w@mail.gmail.com>
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

On Wed, 14 Apr 2021 at 03:22, Leo Liu <leo.liu@amd.com> wrote:
>
> This is decode command line, are you seeing issue with encode or
> decode?

I was means that described above the kernel panic happens only when
OBS record or stream video with VAAPI encoder.
Grabbing and encoding video with ffmpeg (given command example) is
free from this issue, but result video encoded with ffmpeg not played
properly. And I believe that this is not a bug of ffmpeg itself,
because with CPU encoder (libx264), the resulting video is played
properly.

> you also said `ffmpeg -f x11grab -framerate 60 -video_size
> 3840x2160 -i :0.0 -vf 'format=nv12,hwupload' -vaapi_device
> /dev/dri/renderD128 -vcodec h264_vaapi output3.mp4` doesn't cause such
> issue, right?

This command does not cause described kernel panic, but the resulting
video looks like 0.01 FPS.

>
> Yes.
>

I filled bugreport about VAAPI encoder in ffmpeg here:
https://gitlab.freedesktop.org/drm/amd/-/issues/1570

We can continue there.

-- 
Best Regards,
Mike Gavrilov.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
