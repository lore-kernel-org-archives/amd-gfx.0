Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3DC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E7B619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E7B619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397196E8EC;
	Tue, 30 Mar 2021 13:24:41 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D85189D79
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:05:08 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id w28so1465281lfn.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=6MW4qo3qKDBdNRb1q5dWTyF6kc0Oc7Db7LMztidcgKw=;
 b=DmniTpmRtBqSoZSr12tvPb8NONXKL+xwm3NOI2aIkE3vLdNu69nY9lQ1rBNq3Jn62m
 Hrs3ur+64tPt/df86Krmwhc1Ad2Lg5xl8f5meRImUUn/Lqz5TJGQKyzSTFQ76Pt1s9F1
 56ozhwh+Rp3oTjPnDEFLZYDOSuNUa2qIPNCqFAQkxzmlGaa8pJdxoIe4J1Hw3u5+vGVt
 BjUfZ+puoixIQnOvsJx62PvooORibCxCncV/ULl0OI382+HL678dFG2VT8oB0Wjs92y1
 OMisCWqhnVFxDv2M3YvqnlVAQkjtf82nO8SPqwFfKbYDwaEcYLugXYKZ90WceCJCa8cD
 8zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=6MW4qo3qKDBdNRb1q5dWTyF6kc0Oc7Db7LMztidcgKw=;
 b=Yy4+29hU4nr3M6hQLd5AB3oP874zdQbDKJv8XpMy4oVPVxCNXwa7p5Lr+IHuH3xlEv
 xLOG1ugY/f7eJwi61GBOtNRTuZ5tExT3DYHbEHCKbw+uO/tasvHYWKH+iiacfEhc9l+D
 GUdQPFKSgkPyaY4U+Ywsht8uEPUplVsVLkUlZhAygi1U1yxuHyLgXX2hzKOyWPGePruy
 Mk7fhRrabDSLhPQlhIMiGJDUGJowwwcZJhtodm6AzTdyAiqRbWAzpfcPCzNZ2BzcRNV6
 WqIpdKtFi9FNll3tjWFugCBSOba5ge5MvjNqX7hpQ3N8jjKq16qhIlG1V2RJ1o335Dev
 KCGA==
X-Gm-Message-State: AOAM531b/MzHcwv+kV0e5P5EIVrE4dpK96/xc0sjJm59wESy19fcV8w3
 02+StiUDqIsfpW/7LXHJ8ISsOWq+BIxotRfIPplY7K2wQ10=
X-Google-Smtp-Source: ABdhPJxqmaSpCaGzC5TPMtfCLfr2Ex6JXAFzC+/BYx1fpeHvfavmqK2nu6XOCb2HJv9ZQOg5fFovbcqkGSaEUpqeiH4=
X-Received: by 2002:a05:6512:3a96:: with SMTP id
 q22mr18929599lfu.306.1617091506833; 
 Tue, 30 Mar 2021 01:05:06 -0700 (PDT)
MIME-Version: 1.0
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Tue, 30 Mar 2021 10:04:56 +0200
Message-ID: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
Subject: Interlaced resolutions hang the desktop
To: amd-gfx@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, benh@kernel.crashing.org
X-Mailman-Approved-At: Tue, 30 Mar 2021 13:24:40 +0000
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
Content-Type: multipart/mixed; boundary="===============1674223129=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1674223129==
Content-Type: multipart/alternative; boundary="000000000000d58c0905bebc7499"

--000000000000d58c0905bebc7499
Content-Type: text/plain; charset="UTF-8"

The entire desktop hangs after some minutes when using the module "radeon"
with an interlaced resolution.

Easier to trigger by playing a video on Firefox, at least on kwin_x11.
Wayland didn't exhibit the problem.

Other display drivers, from different computers I have tried, didn't allow
those interlaced resolutions all together. It seems they know there will be
problems.

--000000000000d58c0905bebc7499
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The entire desktop hangs after some minutes when usin=
g the module &quot;radeon&quot; with an interlaced resolution.</div><div><b=
r></div><div>Easier to trigger by playing a video on Firefox, at least on k=
win_x11. Wayland didn&#39;t exhibit the problem.<br></div><div><br></div><d=
iv>Other display drivers, from different computers I have tried, didn&#39;t=
 allow those interlaced resolutions all together. It seems they know there =
will be problems.<br></div></div>

--000000000000d58c0905bebc7499--

--===============1674223129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1674223129==--
