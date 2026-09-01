Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8056CC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 13:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E685910ECEF;
	Tue,  1 Sep 2026 13:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvwVHVEm";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1AA10ECEF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 13:27:28 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-39930bee237so39986a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 06:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788269248; cv=none;
 d=google.com; s=arc-20260327;
 b=fghZD+fhpkZlT1OKbf2mXLbbhR7xdAbQG0A+jYQrgLkQaHq5+dakTvyLbzy0WpPfoI
 oKrBj2U7e5L3DU836vVXa9vnpFLQJJcqg96tytpqMLdMiot4xU0XXPL258YjRE3t3gC/
 KT79L/RcBcupG3iDOTKH97rks+gxamVDCsiRQyRE250ipBGvv+WPrCzpeMdZXuCa/wAV
 GR79kqFEB9NO/WUqI6qOO95KZR+pPrMJQaz1lUxSyaavZrXS60hZbIsUsOjcx6SeKolH
 Bj/LNgK4tEY2wLYPHdPKFlojrN9piYFCY1UpFjU/O8EMeJwD0XY6cxdWchhCMM6BYHvN
 45FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qk3mkA0hRs+b7jl16xw/iUkWxnECYIkYA74kqu6TmR0=;
 fh=/pQqhhcgyDQSojRB63JcFSOdY/brWlux2efOQZLNdeY=;
 b=TngLTd10eMla04eRQPVai7fdTor8ivrjc+2OWng98ojRqs1uwzk3gVyOA4yyPBzQJh
 NQtl7LSbFkkYD3/2jKni+JX9vMQvUpfVo8miGOWbPynTyv2MIZShgfRE39Qn6AfAubOl
 M/RNerHbO424vTYml+gqCxCjVPSUD+rDPtzTHnrmaiHoB+yIEuYFqQbqcxezWP9tp1Pa
 Gg0OhDXjk14gnK4g4ZqnTOEX59loCvc0qisv2vKPvmLEbVvUHS3DaS2NFSdHqOnRxh6R
 pa8P20/tGqDjhfkl8VSPGohhrFhAJXn1yViKPeXopHhFtGvnnY3a9tRGNBLv5Qmv79i9
 gS1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788269248; x=1788874048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qk3mkA0hRs+b7jl16xw/iUkWxnECYIkYA74kqu6TmR0=;
 b=AvwVHVEmYjy5w5XTTyqWDjYlAol9bFgHAcLnY/C7+3C/izcwXEr4BWNKlXiZo/rSF1
 /v+PQCEolddPneA7/Ir9SVAPQOeITsVjwGViotErIHnM4zj74xgJf+ZFvvEnsGYpE+d3
 T833qCq2oRootQfr4LKHHFnJDxDJ11mda55Ah+YB3fmhHzmGA9Sn8tuioAcRJ6w8cO0w
 l8ZfOMbuekVzugrdG+87VaX6vuZGSu2Xg9YrAEGNiHR+gz6hjikfLBTT7PAX95lhU50C
 LVIgdI54RNlp9GLyZyRh2ahCab8Q7VYW/bxH8x+o2WVeZUmUeGu5Q/f+0dRopP6KUYDG
 1jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269248; x=1788874048;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qk3mkA0hRs+b7jl16xw/iUkWxnECYIkYA74kqu6TmR0=;
 b=RTCUINdTRkbnFzCBXr6YXuInyQQs2hdavvnzbY+5/uIhWZbmgO8xtDMWGz1kVFwKuA
 3dQIa+ZWvQXrwgL0RmoO12Ry6WrEFtGWAUnnkt8E+kxN90VwihXZnUIIj/ly3q4QC9Qg
 rwRaywgfVgBUiLE6+6d/g2AwSvnMM727HSe4C2IRWkY4QliH+/+1rhBEYbi9toV0TC8d
 5zdOwpG8tccTQ5FpKjb9dL37GYUkRXNiXw8HYtokSW+1HfFhvAS1l05sANWOGaY56I88
 wnDlpa/K6CzIBO3dS5i55Z02wh374m2hHc2KhTUgtvAuA77JRDRMxtHNTmY+pN0aEHPb
 2XGQ==
X-Gm-Message-State: AFuF++mXbFnlL/VLNVy0Klq6tVHQckqmKZuCy3c+Xs6WpN6J8tOTDi0Z
 b6jHQ2n23T5DBz/CNGIRo/PQZG8opBtF3qQz373u2wqFdgfqUBpjv2xIvdlRbfoo/vSqVJXo6xG
 3iaOQyghR7kn07MRM89+WQeey8yEgz7jMFQ==
X-Gm-Gg: AYBFou3+Zg6/JB4QmMFEjl4q8pQdKp+eWjyQk4NpCGYeFDFYXZDKWeIV3m7h6fOkH37
 WuMEnnCyfxqhOCSZWWjlSWZxL6psP/AjHxLndX6hDzQV9gE+cmTosBOfp8I/YzjAiozca65ff/Z
 CNowhyrET51zRXz8e6a4xC67wjcwwpHFfajx2l2MHxA/bO7jFdE9QbRQDqT2flZ9gkQldjpXxna
 XFFOcF+rgYSqZqlZ9dGml3eXeRI/B6MDg7l+fm+k4EYCk8vfYV5N6WfKvYdbIJABzFvfQHcX7z6
 +zKNY/GqLmvQ50orAFM0MvIZlyECQ6lIDWhqNfkMggq2QJosGC6Wzc5uZZ2CKTC+Oue93DrOkSz
 uMab0VMxiIk6khFDVmJHti3Z0hxhdODMAUWGBa9D5rw==
X-Received: by 2002:a17:90b:2682:b0:396:a47f:d38f with SMTP id
 98e67ed59e1d1-398bab83937mr19896995a91.3.1788269247715; Tue, 01 Sep 2026
 06:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <24915fec-468c-48f6-85cc-da7b008b937f@rawbw.com>
 <CADnq5_MAeEZbqsb9-0_7PsDQNgcoHaaUfiNX7Duz2of4+nBubg@mail.gmail.com>
 <a7a1bc98-3517-4794-8fa3-4ba736e99f1d@rawbw.com>
In-Reply-To: <a7a1bc98-3517-4794-8fa3-4ba736e99f1d@rawbw.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2026 09:27:16 -0400
X-Gm-Features: AcwNN1V-vBD9TrBnxmVxcMRQ-qFCPqcKMAC9NQp5OxHYDE1F8T3ITF4Gm1-lQps
Message-ID: <CADnq5_ML24Q7Ae5ipTUtTCHvKcVZk0QZQgEjYm+nAw2iQuEecA@mail.gmail.com>
Subject: Re: error messages "[drm] Fence fallback timer expired on ring
 gfx_0.0.0" are printed after which Xorg becomes unusable
To: Yuri <yuri@rawbw.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 1, 2026 at 1:33=E2=80=AFAM Yuri <yuri@rawbw.com> wrote:
>
> On 8/31/26 11:47, Alex Deucher wrote:
> > Most likely interrupts are not getting delivered on your system for som=
e reason.
>
>
> This system had a working graphics with the same hardware but then it
> began to hang like this after a system update.
>
> Do you know what to look for in the changes that were checked into the
> kernel?
> Just interrupts?
>

Can you bisect?  Could be an MSI change, or a bios change on your system.

Alex
