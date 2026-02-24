Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCDF357A3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 14:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD6410E32B;
	Tue, 24 Feb 2026 14:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VcGMDq2C";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC39310E32B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 14:25:27 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2bdb8250007so25706eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 06:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771943127; cv=none;
 d=google.com; s=arc-20240605;
 b=DoF0TrsyxkykMNyzD0sdp4XHtYUMP//hg8Ga3aenMcsr1AArUINK6HBNSqs08BGhdK
 5PKfphtKJ2ygSZAzLUuvGwMqMVfWVM+YUmqJZlq9n/MaxFP0ZdwfaII5dIlpls5nLE5b
 TEdsxiTrp+KzRpd0+z8jLv2adUq/ec0Qe4843fhEkCH30WHmi4YSVceLlnPVvUBPx1r3
 tqXcQoq+PIo2C9xyRX8AN2Lo/NMZ24rcqdgSTAi9QFeoUkbmTgsIon9fMm0wIq/ju/4l
 NgbXg22kbe/cGdQ1tOd0ISLOdGR+GlOBpAJnQukFxBjNMDJICaC7KO4FfWJqxndkK9vO
 mxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gLWFzp2mvSCI7v1mJwSLgktknPipwV9L4/4r0gPjR4M=;
 fh=rhfqgjeWhm6LyL4ZBhUckQhRoOKRAbydmNk04Hzsp6Q=;
 b=KCLZ0yo3Tz6Dx7Q4PrDPowXH6N2J15tRFFFn5LbmfA95MNhjGlUT6NAnl5yUDr7WSh
 MxpymiKZsC/04X3+BZvali0jxFpGIHOt/aQB2Tli0it7c5DL/+9942CivIR+5cXJCJq1
 F+i8YMLCHwmaTttyHskCgPnzkyq/v/SOH2YmnF2JZv4UkNYz3U+KEWm/1B5nDfpRuas9
 9Nh1I+JDBrp0vr2bLgU0s6UlFdaEXzu3n0Fi4RlAOWj3dl89OVvNmAZHBsmMuwBgbmVC
 M7yHFS53DGk/YOmm9vNGiaFYBau6BWVfUML3AqyoinuQzCYWRRREPTOcHWNzVo8UG6Vv
 3FiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771943127; x=1772547927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLWFzp2mvSCI7v1mJwSLgktknPipwV9L4/4r0gPjR4M=;
 b=VcGMDq2CyYLYNA9xANZqawp06xJ5hWJkT+bM25BuGliaFbJIdmovlqPnAp+KiFXIym
 65iQ0CdZElYaFddV7QAMUAxc/zxtuPSx8erjHnsqu24RbHYUJomHZH09Ew7xzzcudBzz
 dRXd02GeHK5ZPngPfX2+uphZCT6fGaz117ws2lhDDwROhVcD6X6Aviuz/1SGJCUkDWbp
 ma3dGzcBRcZj3oQHXBDBaTwDSwpIXgd0G56TcrHR2znG6Kk9navNW2tQddqv7rcVOOZE
 NvGfTQdLR9hgKKgOepXCvCuRtXdtK86MdjaiQg2P2W69UCqousRqKM0YF21EoSv9eDjI
 2pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943127; x=1772547927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLWFzp2mvSCI7v1mJwSLgktknPipwV9L4/4r0gPjR4M=;
 b=A/qNF8900D299z/ePYJGMAmGTjda0rRTpt+BLfWe+d3EW2gbOB8ot8bYC9wYLikb+n
 gOFrUBwpHHMZ76tgTcK22gUbX18o4zgLxfqbAzvBRByaSf90zlEzGMkHE3OVwnR7KKMF
 Q+b1EKaQg1x5b5meJrszlTi+sxXKrczJNoaTXnMgNffDc8xE8RCF6+sDel0zMBMvb3A6
 TSgddfmTozusIArjTm1nz7fB7OdYSQnPd/YC3RZERbBDxttR7MFS0fErnJYj/NV+vp/0
 v5V5YnBe0bAMPKAzkvrTBIkKj+30pX1y29NiWgZ/wuSAaw9IYSHTyHqmijBsxHAjeIxs
 qm8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpAUUzOzWUIbZaGSsIcy4Tr8Bkf4/6d0KE1aCmJtTnksxFwB8u26FuDlE9i6qz3IMkcku5bUbh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTViP4IfKs18Zl3ZcBd6qMhOSfPj8LLMfiMkS+qP5BEY3TiZV4
 y93BtXZCY82To+QWIkykx3M6oyR4r9mWCHMsZe8dIsQuCyAPJ78wqxbeLzj4qcfq964YzeVjUd1
 bD02RFXsHdSLMIl8+nju7dLhoiGsdyPo=
X-Gm-Gg: AZuq6aIzhQSU1f7N+YB0EiAgdI718/9IUfonxgw0ICe2uCxVAVVI7ZCRvenUVy3PymZ
 E/FuAu1YCD8NbnkA7b60bOgeYAlzxpr/jvAO6Gzp2PIeZmLex5cjURLrV38KP6U3FJiUnOPOxb2
 ZfDhuplz+sYw2C/Zlo1UdsAwc4GQSItAP0JmK+mhU6hBQJbj5lIynnaooxayEGzO+l8jUuNYi3L
 xTp+gxK0cv27Q4gHGgGlOCxc1ZeBj2pyuDTYJhRDjChP6DHx+wxRO782GkfuT0Za6qdZ177xFX+
 /MvIdmY4D1UeKEp4vVaOKpf6o15tpy5zypK3HRqlw6/7KnniOXA6eMiIrf7c9HMohxeRXy7gJuL
 O4jqQ
X-Received: by 2002:a05:7022:f40f:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1276acad4c1mr2415585c88.2.1771943126801; Tue, 24 Feb 2026
 06:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
 <20260223220102.2158611-8-bart.vanassche@linux.dev>
 <DM6PR12MB29727B8394F53F1A0282D7E98274A@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB29727B8394F53F1A0282D7E98274A@DM6PR12MB2972.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 09:25:15 -0500
X-Gm-Features: AaiRm53sCbSnoTScwu0L5hqMpvSfxt_dr4rA6LxIHhpJCNmB61AZT6P-pZ7-F0s
Message-ID: <CADnq5_NSb-g57UyaMm-X=97=1pjh8xTZ2B9fgyHrWCfu6sDA7g@mail.gmail.com>
Subject: Re: [PATCH 07/62] drm/amdgpu: Unlock a mutex before destroying it
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: Bart Van Assche <bart.vanassche@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marco Elver <elver@google.com>, 
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

Applied.  Thanks!

On Mon, Feb 23, 2026 at 10:59=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Bart Van Assche <bart.vanassche@linux.dev>
> Sent: Tuesday, February 24, 2026 6:00 AM
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>; Will Deacon <will@kernel.org>; Boqun =
Feng <boqun@kernel.org>; Waiman Long <longman@redhat.com>; linux-kernel@vge=
r.kernel.org; Marco Elver <elver@google.com>; Christoph Hellwig <hch@lst.de=
>; Steven Rostedt <rostedt@goodmis.org>; Nick Desaulniers <ndesaulniers@goo=
gle.com>; Nathan Chancellor <nathan@kernel.org>; Kees Cook <kees@kernel.org=
>; Jann Horn <jannh@google.com>; Bart Van Assche <bvanassche@acm.org>; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH 07/62] drm/amdgpu: Unlock a mutex before destroying it
>
> [You don't often get email from bart.vanassche@linux.dev. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Bart Van Assche <bvanassche@acm.org>
>
> Mutexes must be unlocked before these are destroyed. This has been detect=
ed by the Clang thread-safety analyzer.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index afe5ca81beec..db7858fe0c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -641,6 +641,7 @@ static void aca_error_fini(struct aca_error *aerr)
>                 aca_bank_error_remove(aerr, bank_error);
>
>  out_unlock:
> +       mutex_unlock(&aerr->lock);
>         mutex_destroy(&aerr->lock);
>  }
>
