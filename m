Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A53C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 04:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EBE2075A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 04:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EBE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDB96E5C1;
	Fri,  8 Jan 2021 04:22:43 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3C76E5C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 04:22:43 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id j12so8530380ota.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 20:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=+qGin/mouuTch80f6s1C4bbREeYiH+VskoOFwfQsjRk=;
 b=ci3U5IUSBS/SNtQeoCnJwa1nemPx47sEFMBzATbTJ9mnVEn5OHu47zGgJhCCom8lxQ
 AZ1SXf4QpL2TnzQGHv0AbOazDEIjPRJB8fYk/04asBdqOo0/VDSlYNTeA7J31xPoNPek
 XY041lWnzQMdzUA5sq4tSV53bZgSKfqmMnREfHSjE0GRgGA31taq+Hy0Nc2eMqeNkjlU
 DZspqOr6Qzf6OmCvubAyYAE3QMhxZgGCjYYGv2BpzQG3f8esFMtxOF4CoxSQln21ewz5
 P5UlHgQbzKI0IbdaBOkJGv4/sEsl1tb+LMUMO0Mil3lexqWReLJAwbHHX/wy6pw8nJRa
 EGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=+qGin/mouuTch80f6s1C4bbREeYiH+VskoOFwfQsjRk=;
 b=im+qO8i/mFwEGkj+2qPC5tHX4Yy6JWC9eZWQ+u2liEC+SV2/nM2EQxRJP6GXr2QSBL
 3nIZWF3pMwKTvUQ8lQGkxH4Jp43/ff7BnEP9vFGexy2u0r6YJthu13UDC/CjiGzgXclS
 o+jxxT+QUV7PLcoyu7CclRSA/BiDs5WUBgkCCl1OwAwPjk7jYL1DiK7WZeFf98GcJ6oJ
 J9lEq5tSTNf92Uksvj4oLr0VzjAL7GoJhUdamVXI51SYvvDwZJXGVTeLdhesdStKDN7S
 /GXllttt/1PmJdJnU58ChVBWU0DlJuY4Y4e5KedgG+Tx3+uEqM0ZOTIhk9STbiyhYdmy
 nWIw==
X-Gm-Message-State: AOAM530YbBQAiwy9iU2nxYqxvbqbbX7hOWayHT0eFajHzGsrfIhzARar
 Zf9v12imgqM47yQPjwXaB9Ila29UqmXA3ggDiCmaEUQbbOw6QQ==
X-Google-Smtp-Source: ABdhPJx6uiEzq7DSd3x7MNuq7eJepep3AogF4PaiJpV3VJAg4/10ROl8VuZq5Egl1eXPKJDHT5shkm4Kv8pr07CXrHU=
X-Received: by 2002:a05:6830:1c2d:: with SMTP id
 f13mr1314788ote.365.1610079762460; 
 Thu, 07 Jan 2021 20:22:42 -0800 (PST)
MIME-Version: 1.0
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Thu, 7 Jan 2021 23:20:56 -0500
Message-ID: <CAPEhTTFa_c3L8gpxT3=HOrQi9mQxhH2GaGo9_mfdc8gKpV2MXA@mail.gmail.com>
Subject: AMDGPU VCE 1: some info needed
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi there,

Some of you may remember I was working on porting VCE 1 from Radeon to
AMDGPU a few years ago... about 3 and a half years. I hadn't had time
to work on it until last Holidays. But why do I persist in this work?
Because GCN 1st gen was still used in some GPU produced 4 years ago
(Radeon 520 and just before R5 and R7 in the entry level).

I'm pretty happy with where the code is sitting now, however I have
some questions.

1- should the firmware be validated like it was under Radeon and as it
is done for the newly ported UVD 3.1 code? This would mean having to
work with keyselect, isn't it?

2- last time I worked on VCE 1.0, Christian was saying that it was
possible a new VCE firmware could be provided for AMDGPU. Then, it
wasn't that clear, GCN 1.0 (SI) being in trouble and it was considered
to strip it from AMDGPU. And a few months ago, UVD and DC were added
for SI to AMDGPU and a new UVD firmware was released (yeah!). So, is
it possible to have a new VCE firmware? I produced an "updated" tahiti
VCE file where a header is added (script available on my account on
GitHub). Still, if this can be useful, I'd prefer an official
firmware.

3- is there any documentation about VCE 1.0 that would help me
complete this work?
3.1- Some variables that were previously defined are not available
under sid.c, vce_v1_0_d.h, vce_v1_0_sh_mask.h and others. Since the
new values (mostly in the range of 0x8xxx) are completely different
from the ones defined under Radeon (in the range of 0x2xxxx), I'd like
to be sure to use the good ones. I would assume the masks and shifts
are still valid though.

3.2- Some statuses are undefined, sometimes magic values appear here
and there without being ever defined or documented (status 0x337f
anyone?), even under CIK or they don't seem to be easily portable from
other VCE versions. Having a name for a value is really helpful
without an official documentation, when the code is supposed to be
self-documented. I've been able to identify some of them by looking at
variables used under Radeon or under AMDGPU's UVD 3.1. Interestingly,
some variables were previously defined under Radeon, but were left
aside in AMDGPU...

3.3- Being able to know how to properly set/reset which part, in what
order, etc.

4- Any input about 40 bit address limitation on VCE 1.0 and how to
handle it if it applies?

5- Any chance to have some code reviewed even if it still doesn't work
if I send it on this list?

6- I have some patches on the side to help document the code and
define variables (even for Radeon), a few typos fixed, etc. Should I
send them on this list?

Cheers

Alexandre Demers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
