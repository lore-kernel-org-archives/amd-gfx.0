Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25515D2E038
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB1010EA3A;
	Fri,  5 Dec 2025 08:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XBuAg5y2";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9FA10E1D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 19:36:55 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so355752666b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1764877013; x=1765481813;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hfmTeirb3cJ8WH4Elb1KL8rsHozjiNCHYSp9+LExjhM=;
 b=XBuAg5y2l2kWdxKZfm+K+TyzakVdIqCRuEBwjzd3uBLbO/V1r5yGLzWWg0Tga0yoA0
 +HFvh/TJbhXM4iw6hHSNd+sXWz9PHLwZANWsCpCI8p0Hvg3vflIHrKSLSEE8EihtYPJD
 m3trJ6SOxl+QAg1whTrK923y3cS9P0TYYkbtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877013; x=1765481813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfmTeirb3cJ8WH4Elb1KL8rsHozjiNCHYSp9+LExjhM=;
 b=rskjid/IBiV2BdkbinRqTkuHH42LHnZvtuHteIWgxwPDaJllk/36HrxYz93gzrVkit
 kFFVHbk8IrirYW2qZWwOyoxVvkXPEs8GmcZGhcwdnIHhZxNlRCUhiiHWMJI/Ykh7vQee
 5VF+7vtRCGxouBf+i6AppATAzbef0dx1dfEczB2ZmC93WilN2dSpb0CM+5X6gW2yu5QF
 KiGGtedB4KIOO+w/I7j9EQ2OFaJ3bVRyyyNbQm2e5gXgIlgbc/AuvZrc2uOKLMb8TgHV
 wjJ5XAqVk7WEIZ8qgbTGHwXnrpODPIMyr4swWyF7VHKoAuwB19rsZSUqiDQiLJFmIWDn
 wwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSU2o9eDY0TC0Cn34DrVOYXy618CaeN8K7SzNXMInH6yKb21SAGBTk+buSI0bzCuxFP/mHTA0r@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsmOTrMtEVm81Q3kLr++5teNB+Dn0K1+Qj39EMcv8oAmuGCqjg
 iroG18gN5gjXm46BWyb1IS+t9QcsV2u/CyxIHMDd5GTOV3Y1Yuwn9g8S9ge8isHjQus5H/aWwpp
 s6nhMSZg=
X-Gm-Gg: ASbGncvPm3dkXetWQAp7ZLKRsuj+q/Y9XoEFMdhojeupzYZDk74yJzD/mo8RoTrJ7Zt
 81sZTW9MtiLxkfUx+MDLfb/Or1fEe1L8MZ0cillA13HDaKOw9XaMcEPHen4s31e3Ck1Aa6KDgYG
 CH6C2WuMeHCPjyget3vf1kIZ+QkBRiI6smy1Vh4rX1KH9+WuR4WVz2k0RaZztiBd4WX0BCknGmU
 Tn7tLCcR1ICt9Gsm0jLXv9aYagYAcAlm1rS8EQX9A9tkRy40cBxn/Lk34d/87VTv88XLqWpzcWu
 GATGXi8dcoi6ShT/6NzLcFagzMBytCByen68XPuBQbGyjO41Vb523ofvu2y9dReXgcsAd3Wk2oY
 UHpRAeOl2F7tCNwru71HTcb4AkSv/XOpkBAeLp5E7TdotXiimBExjt9pxxNB6N6H3QaVcvLNLIT
 w2+hC1VfCM8mr9LwxtmqyIJYypwVeFCv+W5RsbuU/ixjSiUe7LmYox2zU5vhw1
X-Google-Smtp-Source: AGHT+IFk3o/pW2tkYMEmoLWkeZnap/gq7Q/SKpYMZ66ZXP3fvb16GTAUtMA0nOwVE8Lot0N9kRsqyw==
X-Received: by 2002:a17:906:794e:b0:b73:2d9c:9581 with SMTP id
 a640c23a62f3a-b79eb683380mr536674166b.28.1764877013573; 
 Thu, 04 Dec 2025 11:36:53 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4a78869sm193610366b.71.2025.12.04.11.36.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 11:36:51 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso2198094a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 11:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXNmLCUbpRK+7ZivGGdDofhR2LRMpMuAi0Hu1jY4T/hqr9EfVEWM6vrs3KSLwJ+3N+9bg8pY2pi@lists.freedesktop.org
X-Received: by 2002:a05:6402:5189:b0:640:9997:a229 with SMTP id
 4fb4d7f45d1cf-647a69e6acbmr4507453a12.3.1764877010898; Thu, 04 Dec 2025
 11:36:50 -0800 (PST)
MIME-Version: 1.0
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
 <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
 <1f31b86d-283c-4878-92d0-ab90aed0c58d@roeck-us.net>
 <5af4522e-30ab-4eec-a861-c2760cdabd4f@linuxfoundation.org>
 <2bc690ca-fa57-46fa-949b-28b5441cd364@kernel.org>
 <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
In-Reply-To: <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Dec 2025 11:36:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whd-k3GhNGvVmP7W2p1d0d4ctqJ8iCuG8DbyKzgNqCL+g@mail.gmail.com>
X-Gm-Features: AWmQ_bl15pRGGXuHFcuQkuAPhnzgKRm8fbeljiIJE8EGq1gNKXLgKf_oozB3SVU
Message-ID: <CAHk-=whd-k3GhNGvVmP7W2p1d0d4ctqJ8iCuG8DbyKzgNqCL+g@mail.gmail.com>
Subject: Re: Linux 6.18 amdgpu build error
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, akpm@linux-foundation.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>, Guenter Roeck <linux@roeck-us.net>,
 Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 05 Dec 2025 08:19:27 +0000
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

On Thu, 4 Dec 2025 at 09:40, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> This commit has impact on all architectures, not a narrow scoped
> powerpc only thing -  it enables HAVE_GIGANTIC_FOLIOS on x86_64
> and changes the common code that determines MAX_FOLIO_ORDER in
> include/linux/mm.h

So I suspect your bisection might not have worked out, and there might
be two different things going on.

In particular, hugepages were broken in 6.18-rc6 due to commit
adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero
folio").

That was then fixed for rc7 (and obviously final 6.18) by commit
5bebe8de19264 ("mm/huge_memory: Fix initialization of huge zero
folio"), but the breakage up until that time was a bit random.

End result: if you ever ended up bisecting into that broken range
between those two commits, you would get failures on some loads (but
not reliably), and your bisection would end up pointing to some random
thing.

But as mentioned, that particular problem would have been fixed in rc7
and in final 6.18, so any issues you saw with the final build would
have been due to something else.

Can I ask you to try to re-do the bisection, but with that commit
5bebe8de19264 applied by hand - if it wasn't already there - every
time you build a kernel that has adfb6609c680?

That way the bisection wouldn't be affected by that other known bug.

                    Linus
