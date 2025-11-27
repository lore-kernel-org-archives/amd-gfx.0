Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D8DCFD2F6
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Nov 2025 09:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9944210E7E8;
	Thu, 27 Nov 2025 09:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqbw90Sm";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEDD10E778
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Nov 2025 07:43:21 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-640f2c9ccbdso469539d50.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764229400; x=1764834200; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Udrm+c3cvRe0PZBI7WCq1bwJxvb52QeR4dMmkLo9SG4=;
 b=bqbw90SmO1Xok0Wloly6XqqVlwWBrGPi2Jf0oPTqfSadaVi8yn9xVNcwPXM1FCZyiT
 E+UYQb6q781fTRFGvt/5wcCLBu36HCAol9lQk2nPepq+O5eYrmzTOYxZ33GarEFeqx56
 zm3bjZu4WAbvG1mhCGRLhE72I2yiGYfHYLAYTJftQgwVWAFXPNADipdyvVQkuG42VzRQ
 qGCHv32uleHFGGHFhIqOa/CSZCBEL55Ji8Ox1acNtWJnJiVl4Mq/aQIPEqCGzkqEi554
 yEF00kXDtvxJODnUDC7kUruYUsQHLRMG8RxUja2s7FBvQ8Yuf6Q8jLfvu024BRxBXSNN
 c4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764229400; x=1764834200;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Udrm+c3cvRe0PZBI7WCq1bwJxvb52QeR4dMmkLo9SG4=;
 b=QaK5b+4DIsvHPshjPrJPYMPPFihPLY2n/wjMxwsJBPOOtBbI8bAePK6OFiegNucmii
 tOhxT9IzGWs+oTBQQ9bXDWtNNvXPGRg9n0m1uw0agFpyZ0dhamVhoAzd3+MNlDeO++2h
 lfwBXZhmXnw8MioBe+D/vtqGiheyjX8IEomfwWd2rICWe9yAWBGVR0brBQoF+EasSHPB
 H+In1SGgPTBHFQzPw3Qwi2w9cSxBI2F/WPPWCTUEtePMO0YAaV2ukpHZZAkm8kypJpb0
 AubEVaeUWwgpxS18NMPhzQ19ev9hNrMQnG95VW9y0rk+xwxRWYN5Uxf59kjIO7NVz1TP
 34aQ==
X-Gm-Message-State: AOJu0YyUldEC0C4Qvru/wRZps6s14faX1gsL/05iheYtFMpuYOYXTd/T
 5/MIvgqg+88jdnl3p+3WRSJIpSW47VmWQZIFVOicpH5x4dwHGdaovu3ShW+x3/QASI4Wx1lCAu4
 gb0pJG7IPnzfzKjVGQQ6emVaxHaV7GvLUl9/fHVg=
X-Gm-Gg: ASbGncuLxZw7gD9mpG86UImqTh7pGyViMsW7Fe6HeegecPJk4kvJpXrv+z6GC5Z1vFs
 8QlKsXnwXHd0110Iwwc4jUEeq5yO+F59P3B95l2SP+FiA85yVzUWWkkqrgek4n7ptJNV2ihwW3M
 qQAkL5UZaMebC3MkAhT4WUbS1vc59NUb6b8q3U9wiWrc4/87hETnLaK3L7JQYxROHcZBkDF0F31
 rTqYrazXzdNCY0AkhFLTxbVfYhmHUvJ11nveNj+/yXXVs1POvgcfdKKTSGi3vWRWItSGZf/vAwV
 1a/AzzvRGTO0P3nnHTFbGZSzmqRd6Gc6M3F/rcU=
X-Google-Smtp-Source: AGHT+IFLa6rAGG/CWLcv+3cb7N5jCCg5tWzzTbTJQgn1vCbGNH0WUq2eHiCfBmX9hp98XLIoG5KdGHNM+NEWUzYk12c=
X-Received: by 2002:a53:a10e:0:b0:63f:9f5a:a555 with SMTP id
 956f58d0204a3-64329399ff8mr4792599d50.50.1764229399913; Wed, 26 Nov 2025
 23:43:19 -0800 (PST)
MIME-Version: 1.0
From: Yash Anand <yashanands112@gmail.com>
Date: Thu, 27 Nov 2025 13:13:08 +0530
X-Gm-Features: AWmQ_bmP3_UOvHbjw12I-F86Cyc3APqPqfCMSl29DIPC4S2svYlTfaNyOpuZOe4
Message-ID: <CAKpMnw3=GYLxggX1cJMG99XbfxNg4vC5Qb+-VNzEhgFAxEoYRA@mail.gmail.com>
Subject: [REGRESSION] Display signal loss (blink) on input at >100Hz since
 v6.1 with AMD Graphics Card
To: amd-gfx@lists.freedesktop.org
Cc: regressions@lists.linux.dev
Content-Type: multipart/alternative; boundary="000000000000af295306448eaabd"
X-Mailman-Approved-At: Thu, 27 Nov 2025 09:25:38 +0000
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

--000000000000af295306448eaabd
Content-Type: text/plain; charset="UTF-8"

Hi, I'm Yash. I would like to report a regression I'm facing with my AMD
graphics card (RX 6500XT) and its driver amdgpu. This is happening to me in
ALL the kernel versions above 6.1, i.e, linux 6.1 is the last kernel tested
by me in which I'm not facing this issue.

The Issue:- Whenever the refresh rate is set above 100hz (the max refresh
rate my monitor supports is 120hz), the screen *flickers*, or *blinks,* i.e,
it turns off for around 2s and turns back on whenever I click on things
like- new tab button in firefox, type things in the terminal, press the
super key, change the theme from appearance, etc.

The system is responsive, but the display *flickers* or *blinks *while
doing normal tasks in my system. This doesn't happen at 100hz, or lower,
like 60hz etc.

System Specifications:
GPU: Powercolor AMD Radeon RX 6500XT 8gb
CPU: Intel i3-9100f
Monitor: Acer EK240Y G0 23.8 Inch IPS Full HD. I am using it at 1080p at
120hz. Connected through HDMI
Distro: Manjaro with XFCE. Also tested with fedora, linux mint, and some
more.

Last Working Kernel Version by my testing: Linux 6.1.153-1 LTS
First Bad Kernel Version by my testing: Linux 6.6.107-1 LTS
Also facing issues on the latest Linux 6.17.1-0

Please let me know if you need any specific logs and also the command to
fetch it (I'm a beginner in terminal and its commands)

Thanks,

Yash.
#regzbot ^introduced: v6.1..v6.6

--000000000000af295306448eaabd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, I&#39;m Yash. I would like to report a regression=
 I&#39;m facing with my AMD graphics card (RX 6500XT) and its driver amdgpu=
. This is happening to me in ALL the kernel versions above 6.1, i.e, linux =
6.1 is the last kernel tested by me in which I&#39;m not facing this=C2=A0i=
ssue.</div><div><br></div><div>The Issue:- Whenever the refresh rate is set=
 above 100hz (the max refresh rate my monitor supports is 120hz), the scree=
n <i>flickers</i>, or <i>blinks,</i>=C2=A0i.e, it turns off for around 2s a=
nd turns back on whenever I click on things like- new tab button in firefox=
, type things in the terminal, press the super key, change the theme from a=
ppearance, etc.=C2=A0</div><div><br></div><div>The=C2=A0system is responsiv=
e, but the display <i>flickers</i> or <i>blinks=C2=A0</i>while doing normal=
 tasks in my system. This doesn&#39;t happen at 100hz, or lower, like 60hz =
etc.</div><div><br></div><div>System Specifications:<br></div><div>GPU: Pow=
ercolor AMD Radeon RX 6500XT 8gb</div><div>CPU: Intel i3-9100f</div><div>Mo=
nitor: Acer EK240Y=C2=A0G0 23.8 Inch IPS Full HD. I am using it at 1080p at=
 120hz. Connected through=C2=A0HDMI</div><div>Distro: Manjaro with XFCE. Al=
so tested with fedora, linux mint, and some more.</div><div><br></div><div>=
Last Working Kernel=C2=A0Version=C2=A0by my testing: Linux 6.1.153-1 LTS</d=
iv><div>First Bad Kernel Version by my testing: Linux 6.6.107-1 LTS<br></di=
v><div>Also facing issues on the latest Linux 6.17.1-0<br><br></div><div><s=
pan class=3D"gmail-router-outlet-wrapper gmail-ng-tns-c2785337336-0"><p cla=
ss=3D"gmail-ng-star-inserted"><span><span class=3D"gmail-ng-star-inserted">=
Please let me know if you need any specific logs and also the command to fe=
tch it (I&#39;m a beginner in terminal and its commands)<br><br></span></sp=
an></p><p class=3D"gmail-ng-star-inserted"><span><span class=3D"gmail-ng-st=
ar-inserted">Thanks,=C2=A0<br></span></span></p><p class=3D"gmail-ng-star-i=
nserted"><span><span class=3D"gmail-ng-star-inserted">Yash.<br></span></spa=
n>#regzbot ^introduced: v6.1..v6.6</p></span><br></div></div>

--000000000000af295306448eaabd--
