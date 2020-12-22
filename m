Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62559C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 05:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1863822B2D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 05:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1863822B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CBB6E0CB;
	Tue, 22 Dec 2020 05:12:31 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007C16E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 05:12:30 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 3so933528wmg.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 21:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=y5fMjtTySYlpfYj5YDagYXpuA4AnzJLUV91Ld1XwzpY=;
 b=HdzANavOKa/9rch60mWSSedvG5sS5LykkU98GQRp6fkvH1vlpWtsIqhknc5dUV7fv+
 S60EI1XndZJeiYycUkU9hMXS+3X9DSigV1diJi5nqHBuR1dWAE0NDQeF3rwAiUC7b7tc
 t13COmXnJD0PnnaU9K9pq+kTq6+cc6GQO8myLQUYk7o8JN0juVsAT3mTWIEjLffnuwF0
 jMPnz7Cb9dy2NIIkA02j7Tobi5Fh0A1o+lVzVAPt8F7ZcqebcuLuImWwSZQJHXB4ZbOr
 TBOsWTZIlxtzmwT0MBFmnEu5Tv+wBiEkCFLereWwybRTAOT7mmT/qZQv/jxpIIrf1W1i
 4NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=y5fMjtTySYlpfYj5YDagYXpuA4AnzJLUV91Ld1XwzpY=;
 b=Dd/H1GzlEIHf4fMBEcph2aQAt0uZdTOsgRKegIOa9Y1x/gAVF6fHc2hBxsN2gl3fpq
 g4/EXPehAqYEnFCjpyYUZPqpjN1CBJCWt639z8C2w3r52r68134/GYGGX5qTnjsAmgu/
 FGvpsR7LyXlE2zHTlMtSmwt17MFR9IbVftF3UyhJQwG3zEgWkVRrYGdeP50djuYBMByc
 1nJ/kwkuoNt3epEcGM1izHp3gAYBzOvYkkLUYPt6EA/cXbjOSMlYgIUzbVmxWHuE9nU6
 eSIV4+57awHPUHY1D/Wbt6/QEja9Wd3PNiauWuAUQV1hYtIyfTNMB6d2wPDlo8IjXRGC
 E0vw==
X-Gm-Message-State: AOAM530z/jQReRuPcouiQJeC5nbS60kAz8cYKjjZEu2RLx9PVvlhXpin
 /Etp0HYpnp+SxWPCnQ15swcYrh64w58T106sd1ftBckfPuw=
X-Google-Smtp-Source: ABdhPJyGqGwsw2UjrzJ/VMyQN/8q0/XH3Y7GN54EWn4BEgSVfqSmV6GuhtaZHI0p4E6hlf/tDeBjDJ7oUq7PEi3aWrE=
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr18512304wme.76.1608613949511; 
 Mon, 21 Dec 2020 21:12:29 -0800 (PST)
MIME-Version: 1.0
From: Smith John <ls.cat.kth@gmail.com>
Date: Tue, 22 Dec 2020 13:12:17 +0800
Message-ID: <CAGztBWW964hgRAMsdJvY3WFFHeE7wKG5um0iFqDbuS2n=4Cd3g@mail.gmail.com>
Subject: [amdkfd] where are AQL packets processed after writing the userspace
 doorbell
To: amd-gfx@lists.freedesktop.org
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
Content-Type: multipart/mixed; boundary="===============0255894708=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0255894708==
Content-Type: multipart/alternative; boundary="0000000000000a9a6505b7069fb7"

--0000000000000a9a6505b7069fb7
Content-Type: text/plain; charset="UTF-8"

Hi! I noticed that the AQL packets are more concise compared with PM4
packets. It seemed that AQL packets need more post-processing than PM4
packets.
I was wondering where the AQL packets are processed, such like calculating
the code address using code_entry_offset, resetting packets' headers into
INVALID, and writing values to the completion signal when finished.
Are all these operations done by the firmware?

--0000000000000a9a6505b7069fb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi! I noticed that the AQL packets are more concise compar=
ed with PM4 packets. It seemed that AQL packets need more post-processing t=
han PM4 packets.=C2=A0 =C2=A0<div>I was wondering where the AQL packets are=
 processed, such like calculating the code address using=C2=A0code_entry_of=
fset, resetting packets&#39; headers into INVALID, and writing values to th=
e=C2=A0completion=C2=A0signal when finished.=C2=A0</div><div>Are all these =
operations done by the firmware?=C2=A0</div></div>

--0000000000000a9a6505b7069fb7--

--===============0255894708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0255894708==--
