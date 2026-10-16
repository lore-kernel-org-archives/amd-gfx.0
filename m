Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CBCCCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 12:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5DB10E2A3;
	Fri, 16 Oct 2026 12:44:36 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E66711276A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 11:15:26 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b0a921ee46so30894347b3.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 04:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792149326; cv=none;
 d=google.com; s=arc-20260327;
 b=r9NU/Fj5He9q/xkB8EkXLgjiMPo2G8cRL/hvjNpdZjFOMs/Afo3MVeKYuwo9lyipyn
 TW+xV7fzwEY07P5JZrOoMO37jol/5miMakV2bf/9bf2btwWo5+HS7UBIt1rGj+CkWsZU
 /1ATdikKzQLWe0Lkf6Me+4vzJuqXfhoNElP9ampuqaLJb7RrLLQVgIfbNqhrttbrAKzf
 snU3hycf4SIIr+eyEZ1XxKHHjShz8dEKH/jn0kSp1m9aIi5Vc5bcYXpFDeYTW7iIDUlj
 L8PkWNN5ZbnD7LihrRizn+YfbZlxUeHWLfHWgC36Vi5cGvGanECVEgckyX6oufX1967R
 MLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Yx94PXlf2eeTLJDrMiAX6dM5Tplp+ob0ifdhom6VJ9M=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=StBHQD08C4hospIpPCI1GQOToz8QH0B916j9mH36x9CQzK5a380iXF7ShbNtv30E4R
 n1h7C3nHxFeCN8ZFNLhBRAbyPIscZyE7Ylo2NQJ86B1TtFFM3C/r+ksYDiY2XewwWigH
 i0D2D98EMm2OMTOQoEyPCkf+uRMDdVi0CyDbH6zyXMlo0ZwwlvGvsjAdtqe64R6/nEfv
 ew6YDpTHS9esMduvo2dRPXDpoIKr3MyEReDuK4nx2jsqaw4Yhi89Xtievv00rBotU7Gl
 b05ivQKMMx6xG8uiLkT4UXyJ4xNbohD8QLYgHwUJ6A7PapPb4IO224AmifR1jxxEGkf7
 tHoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20251104.gappssmtp.com; s=20251104; t=1792149326; x=1792754126;
 darn=lists.freedesktop.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yx94PXlf2eeTLJDrMiAX6dM5Tplp+ob0ifdhom6VJ9M=;
 b=Fc/m+pElBcaHCIwPwVApuMujK5c6xfVgctHwbaRwXQc/Huax/1BGdVhdv7NB4CGdA3
 ojz33QhguO7A/lhF/2HP4YH/5RJRPxXt+bPHfPF5PMM/y2evOqa7CgtRlD4ItEFZ6eOs
 dv7OraSATQL7tyrJF37dCtqYMpMBb7Ek5COgyDUp9DZX2nI+WZdsUkGdnOL0NAA63q9W
 lGhSp+94h2hw+midkkh/0C0nH4+yfNjWOsIiziGggNXRggpE3b4oacXsvgIqXhGx2suU
 4IknNp1lfZgxcpYLKaPNI2tb2N/UH0vZ9KPJppN52OuJgSNzb6PHc/R7GoR/QXnMLORz
 PhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792149326; x=1792754126;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yx94PXlf2eeTLJDrMiAX6dM5Tplp+ob0ifdhom6VJ9M=;
 b=gaYGFEdExeRSR8TrAYyvqlnTfOBU+5esbQmFMdLoaeyaarobd9n7QyNFd+eUY0dyd5
 Ig9ykMCKBJmh4dFwKEZhoxIoYqMlYjDeTN33BkcyJt+1LGk6YC22lwB3CsTvfBtGxTef
 c+I5BHf5sNasZ89yCQ/UHg4pZjUntY2PmH0PwytN7vRyS4JNIh3KbKpEZBn8yoxomQl7
 vzr8xpwd3B8MBJd+b64ahDuUnV/IwqA0ICQMGOMtY4Mh3n9GizsaKNoUWdVgJYH+M2bN
 TwcIqTMdJ2415toGS+YBpYTpK2sdBkmYkhQNjZS1rcMe2X72s783U3xnTNb4uYQ4y8nU
 7ptw==
X-Gm-Message-State: AFq9FYLeCcAnImv323yVB3uo/UblRYuehqRvHVwSjwym8KWet2l28vCL
 8JQqzNGrR+ylzZtP0tJiTmZAIj94UDUkC396R/hEAlBMr6Bal1SP0ggV9bpBVOz98CbgGJDQsw5
 khu1BjEuENIUkzhT1DiFqVIEbpD0KxOvqg26QoqecQ4ZhNVVLVsKkIJM=
X-Gm-Gg: AYBFou1epNLGq3KGM5AXWKvmCbMuEhsuAPeXZmbbpRSIvupmt5w5/crqTpR3Wx7apBM
 HLXGxPukJpqjkdMh12x+7MciFPFfiVi5UGDEt7n3GdVwSMWYvil+HkzcxZReGW7CHlFBrbov7EQ
 YUYT05gtLnlFd1OT995oxZ//GWS3z3njf30bBcyXX/nhY/fYX8sc5Y9vQe2h0DDC8jP7C1YQDFG
 oQXx+vI5o4GurEJnhP/NY3GKUyIFqV2cEMT8copsdnwhPgNugzTZG+AJOtCCAhaAEiNMRCyN9gg
 EPVtZtKdONFt1q+Q5HdiAVLHGcBwEH3hdo9XbO39288q2P+wgNUWLOEJNpa4KS0pZE+JbcTRJbh
 W84rkFH9MBEM1sZGC02V+KyH3ypxNV72w/0jsKPnM++lzrxBmbcwrzaDoO53f2U8LE0ZFo51yJh
 guYwT+MTs8+Se2TKm3vwRvkuYdD7AKkv8=
X-Received: by 2002:a05:690c:4992:b0:8b0:f074:75c2 with SMTP id
 00721157ae682-8b0f0747a02mr170977b3.83.1792149325555; Fri, 16 Oct 2026
 04:15:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
Date: Fri, 16 Oct 2026 13:15:14 +0200
X-Gm-Features: AclHuK_YNrVwXW5fSCFeW7xoWQpnwUdxwisJ8IlKUubeaRhDrpX8_E__N60zMSE
Message-ID: <CADTJRYdDAY0aYDeUCGWb2BuhKSGU2EzLoUwQHkv2SEqU53fjLA@mail.gmail.com>
Subject: TUNNEL_DISPATCH on gfx12
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000ef3d95065df3471c"
X-Mailman-Approved-At: Fri, 16 Oct 2026 12:44:35 +0000
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

--000000000000ef3d95065df3471c
Content-Type: text/plain; charset="UTF-8"

Hi,

Kernel commit 9196339 enabled tunneling for gfx10,11, but this was never
done for gfx12.
Is that intentional? It seems like gfx12 code was copied from an older
version of gfx11 and this
hardcoded zero value was never revisited since.

Regards,
Jakub

--000000000000ef3d95065df3471c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Kernel commit 9196339 enabled tunne=
ling for gfx10,11, but this was never done for gfx12.</div><div>Is that int=
entional? It seems like=C2=A0<span style=3D"background-color:transparent">g=
fx12 code was copied from an older version of gfx11 and this</span></div><d=
iv><span style=3D"background-color:transparent">hardcoded zero value was ne=
ver revisited since.</span></div><div><br></div><div>Regards,</div><div>Jak=
ub</div></div>

--000000000000ef3d95065df3471c--
