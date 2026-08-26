Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60450C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C616F10ECA1;
	Wed, 26 Aug 2026 12:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAp0OtKR";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE1610ECA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 12:45:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so117306a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 05:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787748342; cv=none;
 d=google.com; s=arc-20260327;
 b=l3Gtl9fPiNPqfs5RCca6Wa1XFFc045K8qqx6PtZvkM4QQ0mKZzUeIu0FYiNYprarLv
 +IQaGBsAkLZffhbPKjYZfhLpx3PH9qAYBo4Nl31Ah/4+DbZ3+Kp4aDIimMl1QdvJKqwr
 WA2ekPT0OyBx+NFpE2V7cMtDGJ4PZQ+b4pjWCpNfhM32WKg/+/VLviVHqrBIv2cNqaLc
 KY/udtdtjk/myIolzS1a1/9sACtVh6YkSvFJgkqXLqV7nkuFpxt59FlaJoQJppHSpvm9
 FJo2azfVFsVsHwdMps/sPib5yxfEmoCHWmQ8OfFqr2pnGiDQoaQMuf8TlCVp8nScNwF3
 gFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 fh=Tg8JXiAWcAjiH+8XMWkutFii1c2LFDioG/TbQC6meyk=;
 b=R0e+T7mVsp4ZnAa1DA7PW+g0Vju/dqtAaF/tAVzZ3M2ptemANuR3Oy8Ik5FIqEkMrz
 GMLR1euzSReIV9PWtoIUNAReQFgPhEKvlrFEa5lxFD8x05WZVsZr3oVqBZFx4aYYY2Rk
 tL1CgGs6PKN5zy1rNOjONFcQueyFdsd//VcWvFDGEaunvQHBo8P8vNdA6rX+wShFJDTF
 U0dipdc6lmvGNv0Cz/ax9VD2dVFdEVJF0TD6lFtayDX55uF+YfDawbggkUxrRTiFNaUi
 JJSmou3PnOAuE12dk0gNlT+/VwhHZK3Logrxc46nY3okCwqhZ4YS5UQObzEdOv8EUNP+
 532w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787748341; x=1788353141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 b=LAp0OtKRTbgDx4X7banDbBQYMupkKuIbY/OkiDj7zOWCaQ/pcEPrWz9N9++Wab5HYL
 g5LZ26U58+WTeEZjhY+k9Aokr4Dy0AIUJfHMUdIpyhdz9/kAenIgjADuxIhV/1oAZzOQ
 gLjOuD6BDJAKNQiqPWYXofsaOQHBXcfWvBrLmH1ZpUgnrGlKa0q/EDG+a2reLDkIZ7dQ
 /ZFhebd/PG2BD3pi7tZv4QPs+NMSmtqIE6n9nqobT/Oh+7RCqA+4yoLr96DJOcXTJaCM
 6DE1TB4KVmVfoPs0ATb8ASYsTlraVP0pYfcLixbfTzod2p7FyT0nvh+b8oZ6pzC6kIXO
 tNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748341; x=1788353141;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rehlg9L9OKEDKVNBASHXFjO/8t99DdcLutVFyfw9+WY=;
 b=TNRt0GLlBWigY4ZGG0+3XxKYQKEJm2wbNEyg48B79St9SmT1sk96x6zZsrue/jjAvZ
 +lY8IUnYMk3O393ziphCWEk3zs97BEMhgdee5udpn+TJVSN6Uy8EVRMrx2ZRbnLt/tKL
 Qs8SaGr37nIRnmksYIZOKJs2TUBNUnaYLe1fXKVKQ2xdjMGP8ShksSAAvXwz+U9wJAjs
 ppIeVR00fCQXkmkNIgYnvh/yQlcUpTpTfOeOx0S48JNAN1fzVSqvTCkHRQPjnk3uJ9rU
 orRZ84g87sPQ35+Lo1QOi6cpEhtegqyAdFUqZx7AJL6DHwnPb04c3tNpXGx+kbHklKXU
 MR+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRHP2hkO9nqWbQF28fhF67JE4YqgZiL9jqPt/R2OEPb4ptvvrxw7XVLtz0Fs+DLkAHVbpWHGJc@lists.freedesktop.org
X-Gm-Message-State: AFuF++kW26tinVvozMEsYpf5Jlr0e55y2pAUJIoED+Iww3fAs2uk66gH
 3gEWq6/Re/O/EX/oMwp5+sZsCOJIc7UaeDmEFwasIjB1n1LmU+EBzIzt0DabXaEfznOc9u5Wvhm
 tJdqjbX2+XSe9X3grHS5txyt2oU4epFY=
X-Gm-Gg: AR+sD12Qo6Ou/SxVEI+OK/KPr5Lcy+UdDrg37HJ98H96HI4kTOYvm7bNOF6XDTWnuWK
 S55rSfGsoxWAgLb/Uud1MhMPDDqI9wr60gdXP/ULcylYmDVO9qsXqDMTcZFgcb5rvUIFBg28g2o
 i5/6og3n1RdJ+AfKH51Ve8eGyNJnangBMyWhSVhBTy9HSFAdqr2vOgV2DgHXDQYtbLg2xlvAans
 ZxvW4zTNG0XbihzlfxDuTZp6w9Mo/8sUaX5MA7q4tmwmJtgg2deeCWTC7zW7LqRAv82/RiuORUl
 IATTI80UcXQi/b9143UsCINZHQq/1KkgvqYFaA4QPi90SzEofuTw5FX5xt8yWnuM3FXQe2p3+wF
 rtVz5NDy7amQofKLWLCVqre0tUHSCmBzRnrOM1m4STQ==
X-Received: by 2002:a17:90b:288e:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3966d45e721mr6855576a91.3.1787748341497; Wed, 26 Aug 2026
 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
In-Reply-To: <2026082644-monetize-tingling-0abd@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 08:45:29 -0400
X-Gm-Features: AcwNN1Wi4qRmt7UZywPFb9Mu4Qo0qCm21_O_0_7g9jDgE2jJYcKlwMDKSsD2hGE
Message-ID: <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Aug 26, 2026 at 6:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> > Applied.  Thanks.
>
> Any hints on where this was applied and if it will get to Linus "soon"?

It will show up in drm-next after the merge window closes. 7.4 material.

Alex

>
> thanks,
>
> greg k-h
