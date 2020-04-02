Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A56C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715022078B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="A6wogXWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715022078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2DC6E9E9;
	Thu,  2 Apr 2020 07:26:19 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66D56E109
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 02:35:20 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id 19so1587842ljj.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2020 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ce4+jt1QnAedyVF+O0B43RTY85VjYC1oRuPq2H/Wy7k=;
 b=A6wogXWb5tIgKQaMIGu+zexhgOwdF6lvWAZm6SmTGOJJnskmH/gBZkeLs280lc9mCO
 76K5tHRHF4bNPBFY1Vw3xv/9kq5Dr5z498LI8cgExeQLhvzQx1m2F7QHYF4+dItfiqPC
 ECRlkqxZn7xuEYE0nqIxocSu12YOryDxx7NKkYYfx5xOoD2qPQsMG09WDVc0TQHDFAwe
 FoOp3yCdSi2sIKf8B95fjPdXWjsMhNsoPcv2TnpUkB9dote+qhBOl3SM4hrV0s3OsqhX
 gqlCnOtXyW93zxJkpnd1o7QcfHXxxDy3zwD2Doa4MmUyJV1LZeCgrJFBmMpEXVg0B+Fo
 5HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ce4+jt1QnAedyVF+O0B43RTY85VjYC1oRuPq2H/Wy7k=;
 b=IU9Y73TguHSsEwjPs5vWJqoJacJSeOKQ8UA9Xh7na9048aLrHS4c94OW6MLQn+xFuU
 OLiRTOtGYWf4Md4KdAo4BIymbvchpqdgpWAY//vVUS9FB33JIPjPH63tPH+4nf4f4Lfr
 vwrO4aDfS1tCz9KV11EP8+Saep2G10/8Fploses15vPHBeT46pCwYH5V9E7THMogaI5i
 HXZsxMAfmNyvb/c9KBX7kSRZmUmFzqLW3JyMSfrHQNrYoGKE9C/52KDLEj3hG3aWvq3l
 +cNHlbISA1fTbV/2JiPC9dQdqUKwFEQwYNK/5HK+h5GZ6HqkqdsKm5Se3zoJt5e/Ln9V
 wkTg==
X-Gm-Message-State: AGi0PuZwoh5DbkO3sQmfYDZJSJiSNshjVxHxzaIMAbDIHWleC+X5EY8r
 UswN2fVVFGInyetDVII/1dymbEzaEFkVyfxKjjJusA==
X-Google-Smtp-Source: APiQypJpsCcfgA88Rqg61SjKw/yEVQICGOjzMNwDc7ZgAnbArwj2jd/Vav3GV4epq4pobOo308nYOYZ95TdiDSNZSBI=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr575345ljg.215.1585794918859;
 Wed, 01 Apr 2020 19:35:18 -0700 (PDT)
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Thu, 2 Apr 2020 04:34:52 +0200
Message-ID: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
Subject: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
X-Mailman-Approved-At: Thu, 02 Apr 2020 07:26:17 +0000
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[x86 folks in CC so that they can chime in on the precise rules for this stuff]

Hi!

I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
turn on floating-point instructions in the compiler flags
(-mhard-float, -msse and -msse2) in order to make the "float" and
"double" types usable from C code without requiring helper functions.

However, as far as I know, code running in normal kernel context isn't
allowed to use floating-point registers without special protection
using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
require that the protected code never blocks). If you violate that
rule, that can lead to various issues - among other things, I think
the kernel will clobber userspace FPU register state, and I think the
kernel code can blow up if a context switch happens at the wrong time,
since in-kernel task switches don't preserve FPU state.

Is there some hidden trick I'm missing that makes it okay to use FPU
registers here?

I would try testing this, but unfortunately none of the AMD devices I
have here have the appropriate graphics hardware...
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
