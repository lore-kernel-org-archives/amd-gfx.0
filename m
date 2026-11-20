Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB97606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W62p4KBw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D96112B36;
	Fri, 20 Nov 2026 14:56:28 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33411895CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 13:56:50 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3ae25d9e2fdso8492731fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 05:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795183008; cv=none;
 d=google.com; s=arc-20260327;
 b=A/qocZIH/zDdQ4rv6KFxVrCZkVv5AKvNkb8BPvciGaqqeZHXAhWoJWVtOaoMoLsQGZ
 eqEk/pcI1QijpkYB3/bvrYeIAoMaXtY5jTuixCDsn/xHnOZO+IHr+a8fSdeeM9DUz4AJ
 Gf4eZeVfxfLzEjlMC0USaoALW0SEsZ4h4mIcj/Sz55mYfcRRN8V9wVMrV+8n+sQoCXRB
 Cxeby5WnDbK1vZJMfxQE8Y1IyxdbIHHLfBjEqIvPNQcqjkQhTS1/p8BjeZUni9AxELGa
 6u+/plpFH7LT7Tv/rrYy//cvfIxdX3rmqII/xFv6q0OkvYjxdvZoRasBvYqcFSnc2XDh
 h2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GwH1m4JMwHsfP+EiyWDGvhr71t+yUseut1VTk6q1C1s=;
 fh=6lNLPP8fgImnSkXeU2NPTChiA0Ti68J30kKajPNauU4=;
 b=OrNIGhnEkhb3ccTcBXc8CC14op4JtMDtlmEJZ2sjCE05Z4EAXAh33v2xZMeFGIe1sD
 7kN09Sa/zMmgPexCHs8xa3Bq03YFNM44mIHLWnTdSeBvjlVA6P9Td1Xln54McmTgJZJF
 xe/rrXzlN3FpQ0tfp6B0wWDVj8Kw0agvWtzGtik/EG+eizF0v2Uo1XskwRklPK8xMRzy
 AR2DygeORy1Z2csTHVEwkWV5ZB1rPxeL7aNJ0ldlMyiQA7apsWKyEX5mIe+UEc9ewZ3g
 9aGPpVZUYu7FvFABaBgvqsQ1k80RZVpqSf6y5DIfeuJBhtFXSG9g5SZk+dgODryG+V7w
 cfmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795183008; x=1795787808; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GwH1m4JMwHsfP+EiyWDGvhr71t+yUseut1VTk6q1C1s=;
 b=W62p4KBwN6b+u2Xl1T4MigdesUBptTBH38uAMVJVOMJnYjk4LNib/TNOO7ICGybQe2
 Iy0aVdaLuYOPPBBcLhgOS9zLHErALV2s92lw8Gk4WXaPRVDV4dLk1knQ87nkxzaMSL/y
 jM3RdJt9qz1E/UN15iRTTE1YGi30gmTtj27QKvKESnSPW9KXnuEzbR+IvraMxgfJ2Hth
 ZHCNjKtIhlkiPhwcptwHHzE+efFLgVxkTzk0as9F8eMjZ1fWNvzyWS+boVGl8KBV+W4G
 j61UzMLjivf7SYSY0/omF5/hvz9OH94o4q/OjhkpJqX0NeNCuvqby58JbE1e4Qs1WzUv
 9R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183008; x=1795787808;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GwH1m4JMwHsfP+EiyWDGvhr71t+yUseut1VTk6q1C1s=;
 b=QwqxzvPRJRoCbhbW0XZoqCockyUOJt3aYZSgAfEssNmqXiJ9EKu1MGdqXvfpjixIKs
 Zo3pqvts6vocCDay3jvcAuJCjm9uWZFh8xhJS3Kg1GOHiZakf/C7kcf3H2xGzb8eLa/u
 Jf5+ZuTRtgNlEUf4D7RDA6lRq+StjN4apV3LUQXnVH/ssSUgmJowFokiZwW7E6+QXNpb
 oiFs7N0DacwD1UN2sW0miLMGMr9D0nA+TO2KI+ltFJikbQkgRYJ+RhjgM9ddtWpK7AYO
 LXuz6SgfvxhycuPMz+FMv1Q4PC7GZtuumlCnyT4hL6uAFdyTDM62U3vb3LUJhY3gRsx1
 vVKw==
X-Gm-Message-State: APuU4Z8jN08aqGlPMSQQqZP2S7dnhzpaLKID8+atWEArDGqQ9n98QOaI
 qPLdAcSuuleLbpzLwKJAuCljd/HdAJPJQ2vkdkzz+kbo/Mrqb8clQ0u14I85A/2X4++CYGUgGro
 ojCcHWDBPVNw8FQqWM7upE7DRjOYaWEA=
X-Gm-Gg: AZFdTZfuZXrzOGgnU7oSB5tBJWUJf+RRC6+crDh1k6SoeLqEymGmW8zXjx6ciewP/1G
 4A+5tCaqaC02Zspegg4+e+6rieQ65IpvLVYHrhwP+2OEit9gPgEZynpjSGk6QM0rSNeZd13I6YW
 wAQoo/n6hcWIzeFspo1q9jLC7UZ1qUXrWtTSxUJRDMKSco+eKdAI3/IX0SFssLIU2mqxMyO70QE
 KqpE9MzNrG2g8P9GLnhbut1KBAOAcz+7tP+PjAZjiJFGYG/jrRIyy70pwsa3gVLs+c08MAfy9kP
 xPARzMX0kMCkdmvlx/Us0SA6lmvmjLHYcm4f90XqLFYiJsRpa1sca5ciLQMRWBH7lch2sG3xcCO
 VO0qz33U1tqsNEmqQoJYoSgiXdYbSE/2FeAp1hQquywnyoTWPXQthFlJ0ZTUJofUs9/jxQr+xfo
 x6OnFi4ehew4wr4psnRGj0N3ajCLJsQTHP07SIs/Y6iRQVLIFZmg==
X-Received: by 2002:a05:6512:304a:b0:5be:4d35:c4c1 with SMTP id
 2adb3069b0e04-5c1bc844ba8mr928446e87.12.1795183007797; Fri, 20 Nov 2026
 05:56:47 -0800 (PST)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 05:56:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Christoph Berliner <caberliner@gmail.com>
X-Google-Nh-Sender: AW_J_Uo3eOKG5FYMtDEubOW4MF8zosojuYVCauWgip_o8IGzaruqCQegRQr7Cbzs597C5miIPxcLEKg9jM1oiJ5ZhKgIXXoG-9rhwWXtECe-0DB4v37rCFtCmKyCVSo_dnYtuybfY51TgMfP5HJKQPFZE7ePEvfr3EN6wqHmEA81dEcTOlZPDFGu0WWmV3fY-yvYSSyi2Fq2uoC0-Se7uHyVif3ea5ok5yKJcgd7SltSOUbsY_C3u5RJk7mWQuTeqTPoyQ9tgofbkGRXql1l2avc4iWhZds
Date: Fri, 20 Nov 2026 05:56:44 -0800
X-Gm-Features: Aa3M54rbN7TspTE-KJ0N5oXMN25HH5VXrb9hI1G70N_6Kk-bfn0lXBSIwyxXqCE
Message-ID: <nh-d4efc703-38e5-4ca4-8906-3e4f06e81f61@google.com>
Subject: Re: [PATCH v4] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
To: Jiqian.Chen@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 ray.huang@amd.com
Content-Type: multipart/alternative; boundary="0000000000007c9df00660b59d88"
X-Mailman-Approved-At: Fri, 20 Nov 2026 14:56:16 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007c9df00660b59d88
Content-Type: text/plain; charset="UTF-8"

Hi Jiqian,

a late test report for this patch (upstream as c3988a7ad479) on a Ryzen 5
5600G (Cezanne, gfx90c, GC 9.3.0, MEC firmware 0x1e3, HWS,
amdgpu.noretry=1, kernel 7.0.14 with this patch included):

The KCQ part works as described: after MODE2 the compute ring and IB
tests pass and graphics/Vulkan keep working.

KFD however stays unusable after the reset. The next HIP program hangs,
and the kernel prints

qcm fence wait loop timeout expired
The cp might be in an unrecoverable state due to an unsuccessful queues
preemption
process pid ... DQM create queue type 0 failed. ret -62

followed by another reset, and that repeats until reboot.

Dumping all compute HQDs before MODE2 and again at resume (before KIQ
init) showed that the HIQ (MEC2 pipe 0 queue 0) is still ACTIVE with its
old MQD/PQ after MODE2, i.e. the same stale-HQD problem you found for the
KCQs. The HIQ is not torn down during a reset because kq_uninitialize()
only calls destroy_mqd() if it can take the reset domain semaphore,
which amdgpu_device_gpu_recover() already holds for write at that point.

Deactivating all active compute HQDs except the KIQ before MODE2 fixes
it on my machine (same boot, old path vs. new path: hang vs. HIP/rocBLAS
tests passing). I wrote this up, with the two patches I use as a
workaround, here:
https://www.google.com/url?q=https://gitlab.freedesktop.org/drm/amd/-/issues/6177&source=gmail&ust=1795269404456000&sa=E

The patches only touch the GC 9.3.0 path and have not been tested on any
hardware other than mine. I don't know this code well enough to rule out
side effects elsewhere, so please take them as a starting point rather
than a finished fix.

Two small observations from the dump that may matter for other users of
gfx_v9_0_deactivate_kcq_hqd():
- the dequeue loop runs to adev->usec_timeout but compares the counter
against AMDGPU_MAX_USEC_TIMEOUT, so the manual CP_HQD_ACTIVE=0 fallback
is not reached;
- on Renoir the HQD registers of MEC2 pipes 2/3 read back as those of
pipes 0/1, so a loop over all pipes sees the KIQ twice.

The analysis and the patches were done with the help of an AI coding
assistant (Claude Code); all tests on my hardware.

Tested-by: Christoph Berliner <caberliner@gmail.com> # gfx90c, KCQ part

Thanks,
Christoph

--0000000000007c9df00660b59d88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Jiqian,<br><br>a late test report for this=
 patch (upstream as c3988a7ad479) on a Ryzen 5<br>5600G (Cezanne, gfx90c, G=
C 9.3.0, MEC firmware 0x1e3, HWS,<br>amdgpu.noretry=3D1, kernel 7.0.14 with=
 this patch included):<br><br>The KCQ part works as described: after MODE2 =
the compute ring and IB<br>tests pass and graphics/Vulkan keep working.<br>=
<br>KFD however stays unusable after the reset. The next HIP program hangs,=
<br>and the kernel prints<br><br>  qcm fence wait loop timeout expired<br> =
 The cp might be in an unrecoverable state due to an unsuccessful queues pr=
eemption<br>  process pid ... DQM create queue type 0 failed. ret -62<br><b=
r>followed by another reset, and that repeats until reboot.<br><br>Dumping =
all compute HQDs before MODE2 and again at resume (before KIQ<br>init) show=
ed that the HIQ (MEC2 pipe 0 queue 0) is still ACTIVE with its<br>old MQD/P=
Q after MODE2, i.e. the same stale-HQD problem you found for the<br>KCQs. T=
he HIQ is not torn down during a reset because kq_uninitialize()<br>only ca=
lls destroy_mqd() if it can take the reset domain semaphore,<br>which amdgp=
u_device_gpu_recover() already holds for write at that point.<br><br>Deacti=
vating all active compute HQDs except the KIQ before MODE2 fixes<br>it on m=
y machine (same boot, old path vs. new path: hang vs. HIP/rocBLAS<br>tests =
passing). I wrote this up, with the two patches I use as a<br>workaround, h=
ere:<br><a href=3D"https://www.google.com/url?q=3Dhttps://gitlab.freedeskto=
p.org/drm/amd/-/issues/6177&amp;source=3Dgmail&amp;ust=3D1795269404456000&a=
mp;sa=3DE">https://www.google.com/url?q=3Dhttps://gitlab.freedesktop.org/dr=
m/amd/-/issues/6177&amp;source=3Dgmail&amp;ust=3D1795269404456000&amp;sa=3D=
E</a><br><br>The patches only touch the GC 9.3.0 path and have not been tes=
ted on any<br>hardware other than mine. I don&#39;t know this code well eno=
ugh to rule out<br>side effects elsewhere, so please take them as a startin=
g point rather<br>than a finished fix.<br><br>Two small observations from t=
he dump that may matter for other users of<br>gfx_v9_0_deactivate_kcq_hqd()=
:<br>- the dequeue loop runs to adev-&gt;usec_timeout but compares the coun=
ter<br>  against AMDGPU_MAX_USEC_TIMEOUT, so the manual CP_HQD_ACTIVE=3D0 f=
allback<br>  is not reached;<br>- on Renoir the HQD registers of MEC2 pipes=
 2/3 read back as those of<br>  pipes 0/1, so a loop over all pipes sees th=
e KIQ twice.<br><br>The analysis and the patches were done with the help of=
 an AI coding<br>assistant (Claude Code); all tests on my hardware.<br><br>=
Tested-by: Christoph Berliner &lt;<a href=3D"mailto:caberliner@gmail.com">c=
aberliner@gmail.com</a>&gt; # gfx90c, KCQ part<br><br>Thanks,<br>Christoph<=
br></div></body></html>

--0000000000007c9df00660b59d88--
