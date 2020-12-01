Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8704BC64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 06:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F085B206CB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 06:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soRS4EMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F085B206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0AD6E483;
	Tue,  1 Dec 2020 06:58:17 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5576E483
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 06:58:16 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id y11so352090qvu.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 22:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=18uclYmC3tpEH/byXYroqurkoV+qBCTYMVcCBZTFKJU=;
 b=soRS4EMothi1Pxzzy01GSnJljzv6reK4QoNw9LDfXJo+0BSBQrhxav7ZGDFCnRx2N3
 C7CQwbaFsyeIABlAIOlxCW7fmehLlc4hFqM5+0j8XuVJPt8WrKIMrpG5c7C53vSA1NIi
 wUuKNQzS+YfWhiN3ZFT5xHnXsg550LMIn8ePmJLyjoSwqM7/jy/2L/Cgb4/YHU9cW2X6
 54D3CPDcnTHWdtpL2WMmqaL2v886CQX/WEkGvRJa0fhZsvl+gf/PqDchwzPaqtGncT1+
 Qlszqym/91cIYtCN6TPMNGlpoGN/ACU7ixVbnRINAgE/Tkj4qtJVoyNSVZ89eBALSvJe
 xh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=18uclYmC3tpEH/byXYroqurkoV+qBCTYMVcCBZTFKJU=;
 b=Dzgph0st+fDCqC/ZvrvEXlBLosBkWGAL3KJk/++cCY2fUuAwIFrUCcq/RisZCiF6dw
 O97k0AHY+LlZhKjiQ2nrAi8lhsgDWed/MMj63K6FOawhwRLURrp3DB0Ixon3/q4qYMBE
 TbPy8YOdvpoUqXNggembbw3Ra0RSTtSE08TK/xT53u3s2Nu50bEmKqXCGMwLnu0bGSD3
 ZIWm6k3dbruZuAwtgnr5kYbSubLT+FY8i3kWW8Spt75MCZh6hT9zwVa7znDiNPC1xB9X
 tfoh3mVtwrgQ3Qqoi2kKwcsqK8CqA5+HbVbORbEqpza5WKKw+MSvfwSM5sJ4w+2mdpNM
 Eavg==
X-Gm-Message-State: AOAM5329eNOBhVc0cC2z1naComgTsFVxDLWnZ6xhP80oQTSGWBA6t9Z2
 A31JFzuu6qGXYii/exV8PFryBGaAO72JTJdfi8QrudfK
X-Google-Smtp-Source: ABdhPJwFSZ0fwMngK1Idd54CvSC6KcGj4IlPDfS6LIE+zhNi7nzGTnDIkrkoUAVFVEfgsvmAiJR7Cy+QpXgou4WH0NE=
X-Received: by 2002:ad4:44ef:: with SMTP id p15mr1661739qvt.37.1606805895554; 
 Mon, 30 Nov 2020 22:58:15 -0800 (PST)
MIME-Version: 1.0
From: Smith John <ls.cat.kth@gmail.com>
Date: Tue, 1 Dec 2020 14:58:04 +0800
Message-ID: <CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com>
Subject: [amdgpu] Is it possible to disable page tables and use the physical
 address directly in amdgpu
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
Content-Type: multipart/mixed; boundary="===============0004101497=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0004101497==
Content-Type: multipart/alternative; boundary="000000000000a0a89f05b561a693"

--000000000000a0a89f05b561a693
Content-Type: text/plain; charset="UTF-8"

Hello!
I was trying to figure out the impact of gpu page tables on applications'
performance. I noticed that there are 16 vmids supported by the hardware *Vega
10*. Is it possible to use physical address directly in some vmids, or use
physical address globally?

--000000000000a0a89f05b561a693
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<div>I was trying to figure out the impact of gpu pa=
ge tables on applications&#39; performance. I noticed that there are 16 vmi=
ds supported by the hardware <i>Vega 10</i>. Is it possible to use physical=
 address directly in some vmids, or use physical address globally?</div><di=
v><br></div></div>

--000000000000a0a89f05b561a693--

--===============0004101497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0004101497==--
