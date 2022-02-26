Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE49C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 10:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0005910ED6E;
	Sat, 26 Feb 2022 10:01:18 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBC810E257
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 00:06:51 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id 75so6012199pgb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=ZjLQKbKQVDLn52FA0QdOLo7HacPr2ImdnIOTLxHo9Xw=;
 b=ngp043fuL45p2+Xs1/SFzfqHNr3MpllIF6hNqG+xSN1i+Z1sH+gRh67mMFCDNQsklE
 BtP9cwv1GcaAYFR5H4OsvdF8zwgUEHUqdiiaeN6y8o5IMNkYUlnse4lpWYZlMdnYjgAy
 FkTJljXynBfrOTnZhwa7krr/o58Ydlf7SOhWAe/BitjPnYcT/wHRjtf/smdPFmZU7S/K
 Y4Z0YwGR9h4E/qIzvoZ20PMOQKiZBIIukZSOj5rdw5Y6oyPbJS/xXsPZdD3UglS0vEaj
 4FGGBpvnnaZmurQA5K2+JiWghd0+btBQy0hd9PbsCysxFH5xp8cwt1SQXNCXoN3NXNFP
 bx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ZjLQKbKQVDLn52FA0QdOLo7HacPr2ImdnIOTLxHo9Xw=;
 b=dolrdDpKNF5DhAgWAmkvJtp0XWkcBs/LhcGvTkjogvkeTNWjH1yfirxVMIH1Ilx8Dq
 r5A47LHLKMFbjRNo/OwokWKyaJh+k7qx4b30/UXwen/CabN/494iJE1KL5i1l2/gaf+t
 iqFvRnl0agq/lLHKrfUmm6Kr0z89dO5zlkcwtZhH94IQxqll2JJX/q29SisVyQOtQ73a
 WPdksUp73Slwi14xgyPWW7sGeBIjhG7nOVpfZYRzHXJLWE2ede/qsk8Unr8jyn3plP4o
 eCUW1YNWjv051W5rfLx1y9PakINm9eYmB5vEobpQiwfCiFtTvY1rgSR02Z7ru0AQfWzu
 fxsA==
X-Gm-Message-State: AOAM531iLvd5sA8Vnb31CJ7E5ZKcpGptYD4+5lXwMASSvaZRl43CjSXz
 SytyQxFjgUBn+hzevkpx1E/VWPR01ULzonOP2rTJCaql7+UBwQ==
X-Google-Smtp-Source: ABdhPJw2g6W69INMB1O/vGzN6mPhcnAo0NEzxjlYcdFi1hPGOtjr4ZVQV224XTjVaoNOvhjhK7wnZPZNFL0FPhZUfk0=
X-Received: by 2002:a63:914a:0:b0:36c:70c9:8057 with SMTP id
 l71-20020a63914a000000b0036c70c98057mr8056669pge.597.1645834010605; Fri, 25
 Feb 2022 16:06:50 -0800 (PST)
MIME-Version: 1.0
From: Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>
Date: Sat, 26 Feb 2022 01:06:37 +0100
Message-ID: <CAALKErFVZt9+5pPuDYj=zcaB9xr0=iWN4whQR2WRVK6vGe=bdQ@mail.gmail.com>
Subject: kernel amdgpu problems
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000008fbbfa05d8e097d2"
X-Mailman-Approved-At: Sat, 26 Feb 2022 10:01:18 +0000
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

--0000000000008fbbfa05d8e097d2
Content-Type: text/plain; charset="UTF-8"

i have observed at least two major problems of using amdgpu

1. cant be built-in instead of module, display stays blank
2. when kexec reboot, doesnt work anymore, after second such reboot display
even is blank, like in figure 1)
when kexec it errors out like AMDGPU_ACCELERATED=0 from x server this is
not exact just figure what it said

--0000000000008fbbfa05d8e097d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i have observed at least two major problems of using amdgp=
u<div><br></div><div>1. cant be built-in instead of module, display stays b=
lank</div><div>2. when kexec reboot, doesnt work anymore, after second such=
 reboot display even is blank, like in figure 1)</div><div>when kexec it er=
rors out like AMDGPU_ACCELERATED=3D0 from x server this is not exact just f=
igure what it said</div></div>

--0000000000008fbbfa05d8e097d2--
