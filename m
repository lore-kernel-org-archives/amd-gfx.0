Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEBC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E96103E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E96103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AA06E151;
	Wed,  7 Apr 2021 02:37:11 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E786E075
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 01:19:10 +0000 (UTC)
Received: by mail-il1-x12f.google.com with SMTP id c15so6026853ilj.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Apr 2021 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=QcirWEXwOfDkKXola0TPbt7Vi58VMnEuUCdMhcX29fw=;
 b=IyPtbU6l4wJZg4u7rjWTzmubYTy/S5OsuA9tdXMG4iucNQ0ozILiIZqPg1gf0Hw7o3
 QvHTm8lnGfft5w9k7Tex/y2LSkRA8ct4CSThbdF6rzf5Lp1kZxYeqflGzuXoTGFkrfJB
 t8gZeRLzB5OH2SvbsoEq2K8KBTxK96wdt661INRJDfm5+q+gujHKOr9uHlJSy80SXhoW
 /B5R17gZrneFxrfL+pz3RWLeFvfO7MND1GzCSdTEjyar1qKgilB/Gq6nFPUtR1dmtCJU
 qWUnKSwTqHTjsob70K2ija/TzKgQQ36pkbub1/riu6Um3OMzYD+SA3V9JVzSf/qtY+bF
 3XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=QcirWEXwOfDkKXola0TPbt7Vi58VMnEuUCdMhcX29fw=;
 b=gi0wwkrPLwpZAU/+XOoHehfmlc5UmHi07hSIsF5J4O6uTRocrgJ96xHOX9wo2l8ta8
 SAFbxnlSodvGAQcJRxpyYVv9XKKU+dcYfMM3SFfxeb8H4kXRKkR50hPAa1n+9NyaCfAW
 EL4Vj8ob0OU5PRd5r3FKeEIB2/g8PKxRkf/TMIE4g2+c//lcWeX1t3ioAewShOmdf/WI
 gpWywckHXI3p4u8Lof9RCVAL5TPgYDjynLzACdoWmQrAxo8gsGEPg4kcpkxWGccX2Jdq
 2dJZc9jyFITlXaxF3Oi7yfgvbxQ8bB4LQ8dxg/RtKSob/AgKz5UbjmP0YzSGb3qgoRou
 TKug==
X-Gm-Message-State: AOAM531BY7NekOUf1RjIIys4FoZ7PWPkfkaoaXg6ODkLvyxDsidM04V7
 Wef9b5tjWkKJenOx17OPHAJlhzbz+NGcgPHK6IrX8+9gYwg=
X-Google-Smtp-Source: ABdhPJzm/YoSSBYOAyI+pEvQsx02NqLTWtSibVyItAqlts0yZekJmEhwDOWraIevHowIWh5uwceZVdVRN+p2Rnm1XOw=
X-Received: by 2002:a92:de0c:: with SMTP id x12mr802585ilm.169.1617758349848; 
 Tue, 06 Apr 2021 18:19:09 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?2LXYp9mE2K0g2KfZhNmF2LPYudmI2K/Zig==?=
 <almswdysalh404@gmail.com>
Date: Wed, 7 Apr 2021 04:18:57 +0300
Message-ID: <CA+jaEHU9W=D-Wi3o5OEVL=WJ5w3Hgazg6GTqwSkJUE-V_VYaBg@mail.gmail.com>
Subject: Re: a quetion about buffer migration for user mapped bo.
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 07 Apr 2021 02:37:09 +0000
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
Content-Type: multipart/mixed; boundary="===============1954633464=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1954633464==
Content-Type: multipart/alternative; boundary="000000000000c6765305bf57b711"

--000000000000c6765305bf57b711
Content-Type: text/plain; charset="UTF-8"

771763840

--000000000000c6765305bf57b711
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><br><br><div data-smartmail="gmail_signature">771763840</div></div>

--000000000000c6765305bf57b711--

--===============1954633464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1954633464==--
