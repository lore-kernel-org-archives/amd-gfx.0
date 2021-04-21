Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD83BC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 21:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C53F61153
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 21:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C53F61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0AC6E9F4;
	Wed, 21 Apr 2021 21:35:32 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DF26E9F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 21:35:30 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id e186so43493677iof.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=mS80h0Qx1E3y5jPlHW7Fng2oe4Ws0ppqDFdSIQnQwdY=;
 b=qof50JZZsFe32l/pL+puAbgf3bD8dHQ9W1MeoOSytld09EDZKNt4KSR3p4ZQxbvkdo
 RSk3GSvDMS8EDL9nxO0raWXm9E/XpdIthiEnXeqlwtH9U8Kpya8bP8upm39bjMuJKbNA
 MCObR2Xqy6I3woyg9g3klnu8rH7eL1ML/Ev4MxjIP0mBIqi734hITNZDBd9G4MOPVkiV
 44tMM+CE+leWiloKZnj6e57nWOGA3TehBTdAZc1EDk7eODqyRN/IDJQLLEk1P7uE8Urm
 R5Gm+msLA9sv5lVw2dv75PjDdmEtSmBTiO9892go4AS2x1AekArhgM03P2n+5IaFS5cO
 eW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=mS80h0Qx1E3y5jPlHW7Fng2oe4Ws0ppqDFdSIQnQwdY=;
 b=KAvllMK16YWz660/WMIoxH21TZE/CmG5L8hia77sR051RTcuiy8nRit+GOH2+lcmWg
 yXiw01qMekmMQB5n/2BEnuguME1ryjZV1TwBgcysQmO26+bhoFKOOh5MAWop78BBvZId
 nLDl84fPYdFy6fmx94tl9WXWNrqeg+WvtSv6j0ULkjl+UPsdETWJIm6yrlOFBOmUJqrW
 1LpKQszLqi14slevHJFYxvxemMIilbKTUSBCcT4mwIXNLibVYhBURgrh3mu2Cq/puS2B
 PWb9++qXv5g5Vd/u4h7dRStJSg2JX6hUKOSHxv2ueiOxT2olPnOah6xhlq1wo2miii+L
 Ae1g==
X-Gm-Message-State: AOAM531kn7lLF4IhhZu45gsDI4i/tH3TfnG2/l3xxgFkBuBw1Y5BBKrA
 xtoL/cus0nt0L2Mg5W2NDRpTLkh1gclPHH86YwphzooI
X-Google-Smtp-Source: ABdhPJzGRhE6qJaKbySxRXDBL9NOUpl8O6/+U+3wCfkPhd3scnMB219PLuib0HOfIPqRTVq+yx/rLfr8LiSePzitIxM=
X-Received: by 2002:a02:a40a:: with SMTP id c10mr299583jal.98.1619040930353;
 Wed, 21 Apr 2021 14:35:30 -0700 (PDT)
MIME-Version: 1.0
From: Julian Picht <julian.picht+amdgfx@gmail.com>
Date: Wed, 21 Apr 2021 23:35:19 +0200
Message-ID: <CAAqfY0shOhS_eRytBoHX9Sp-Hxh77TUYeKqYMtwbwxyrpm4tYw@mail.gmail.com>
Subject: RTX 6800 XT 4K120 problems
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
Content-Type: multipart/mixed; boundary="===============0802594714=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0802594714==
Content-Type: multipart/alternative; boundary="00000000000087d57505c082575a"

--00000000000087d57505c082575a
Content-Type: text/plain; charset="UTF-8"

Hi all,

I recently purchased a 4K120Hz display and am currently trying to get it
fully working. It's connected via HDMI 2.1, because it does not have a
DisplayPort input.

I'm on 5.12-rc8, and it seems that the modes are not detected correctly,
the driver defaults to YCbCr modes (with chroma sub-sampling) which makes
everything look weird, blocky and broken.

I've patched in a debug fs flag to force RGB-mode which works fine up to
4k60, anything higher and the display detects the signal as YCbCr anyways
(false color mode looks interesting, but not very useful).

I've tested the GPU+display combination on W10 - works fine up to 4K120 HDR
(RGB 10Bit).

I'm happy to help implementing / fixing this.

My current suspects are: pixel clock limitations, and edid parser. Can
anyone tell me if I'm on the right track? Would me trying to do this
interfere with anything else that somebody is working on?

Cheers,
Julian Picht

--00000000000087d57505c082575a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I recently purchased=
 a 4K120Hz display and am currently trying to get it fully working. It&#39;=
s connected via HDMI 2.1, because it does not have a DisplayPort input.</di=
v><div><br></div><div>I&#39;m on 5.12-rc8, and it seems that the modes are =
not detected correctly, the driver defaults to YCbCr modes (with chroma sub=
-sampling) which makes everything look weird, blocky and broken.</div><div>=
<br></div><div>I&#39;ve patched in a debug fs flag to force RGB-mode which =
works fine up to 4k60, anything higher and the display detects the signal a=
s YCbCr anyways (false color mode looks interesting, but not very useful).<=
/div><div><br></div><div>I&#39;ve tested the GPU+display combination on W10=
 - works fine up to 4K120 HDR (RGB 10Bit).</div><div><br></div><div>I&#39;m=
 happy to help implementing / fixing this.</div><div><br></div><div>My curr=
ent suspects are: pixel clock limitations, and edid parser. Can anyone tell=
 me if I&#39;m on the right track? Would me trying to do this interfere wit=
h anything else that somebody is working on?</div><div><br></div><div>Cheer=
s,</div><div>Julian Picht<br></div></div>

--00000000000087d57505c082575a--

--===============0802594714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0802594714==--
