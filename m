Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65228CE7A84
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 18:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14DA10E930;
	Thu,  5 Sep 2024 18:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GCAAhcus";
	dkim-atps=neutral
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9872E10E3C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 23:20:05 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e1ce8a675f7so1028425276.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Sep 2024 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725319204; x=1725924004; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9kMpMnZNN8xeF/Kd0n+gc33N/RD8m1Vri7joRo6FyEQ=;
 b=GCAAhcusUoSUMUEdJKkyhhYFEQeDDK4UBYrYBPeSngCsmBb7Wy/DKcGSjSck3HjO8o
 QX/UZJGNWo3J3s+qfZ2ciG986MEIxzvy3nifW3WjR1YRWL21c+LqOTKzEayaVwBYTJYU
 tDzDElmSBsF8gUx29xljy8XddUpUJ0hWqzgveuJlwo9gjzFHIzzbDdPzx49r+jT9AI1g
 ridMoVQFdqzkzuCLbztQBVOfIVKKrba/qXlTg+7eYHcU8GxhMbklETjNquWjyK8XqRfN
 6vIbuds38qJZnxHU8GToTLnlnP51RDVLgv5ZhsU5UuCdxXFAoaYtW8fEu4mzUD2TxNNx
 CfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725319204; x=1725924004;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kMpMnZNN8xeF/Kd0n+gc33N/RD8m1Vri7joRo6FyEQ=;
 b=LwSvDDvAZ3wmT+b92RYipPIDAydJLedAUPFEEy7ZrsjwrU09XiPkrHNopq+aE3ZfsM
 FGPZrVU3t6pNWICtA7WUSKvIs7RR96SE49l3vpdxVRWUren12PrdkioN4/t7DCmHgMxR
 j27TD19UAC5QZ4AjGk8BnBlWyU+5zrZJmxtKJDd8kclb5IfeYkW/Vvyv56EnCyUU2Y79
 Uq5yvYC+66jFIHOBYcv+p5sIUrocxBJK0rkDjP+YyLJZgdRt6k72KODXgdPo4GCTc6NZ
 JIlCkbZ9qWxygZ0BUhOdXWIxnCoPVGbiioanoM0qZXv4QeSTyJZ+6SX2OOz/wU1Rbp6x
 cPyA==
X-Gm-Message-State: AOJu0YxCnUs+xF4Vow73iX9dVWuJAkLhTcwkP+nsRV4Cl1RYJR6yp/aC
 NCWrH5mmksfBP6bcVMmZ/pmvsg+hYE38X0DOssKzIzDyt5B7YoFAb6exJue7KnfnfOPyrfB9c7+
 6CQWmSJCv8aRTDm7/HEehGkq7AVOnfg5B
X-Google-Smtp-Source: AGHT+IFyAcbXTf/zcRfdZwwBEslSgTQO0kdq4jkyF8GprPtcsI9fmcEfA7D6/XR2jjmLfILlrcKo1tnOv1H7JacVNQk=
X-Received: by 2002:a05:6902:c03:b0:e0b:c297:8a1c with SMTP id
 3f1490d57ef6-e1a79fdc00emr14865502276.15.1725319204134; Mon, 02 Sep 2024
 16:20:04 -0700 (PDT)
MIME-Version: 1.0
From: __- -__ <isapgswell@gmail.com>
Date: Mon, 2 Sep 2024 20:19:51 -0300
Message-ID: <CAN9WMdOgytm9pMdne625bHEpD5DbpghKE047m1cvSJKaqR=L1A@mail.gmail.com>
Subject: [INFO] bad desktop experience, external monitor attached
 nvidia-optimus-enhanced gpu
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000496b1306212b2eae"
X-Mailman-Approved-At: Thu, 05 Sep 2024 18:49:02 +0000
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

--000000000000496b1306212b2eae
Content-Type: text/plain; charset="UTF-8"

Hi,

This issue has a workaround.

put into /etc/environment
LIBGL_DRI3_DISABLE=1

Above envar force use of egl_dri2 defaults

According to https://docs.mesa3d.org/egl.html

Maybe it is a race condition with default MESA_LOADER.

What is the relation between iris and egl_dri2????

Both running is a good strategy??

Please investigate this performance issue ( i think this do not impact 3D
accelerated gammig perf )

Thx

Luiz

--000000000000496b1306212b2eae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>This issue has a workaro=
und.</div><div><br></div><div>put into /etc/environment</div><div>LIBGL_DRI=
3_DISABLE=3D1</div><div><br></div><div>Above envar force use of egl_dri2 de=
faults<br></div><div><br></div><div>According to=C2=A0<a href=3D"https://do=
cs.mesa3d.org/egl.html" target=3D"_blank">https://docs.mesa3d.org/egl.html<=
/a></div><div><br></div><div>Maybe it is a race condition with default MESA=
_LOADER.<br></div><div><br></div><div>What is the relation between iris and=
 egl_dri2????</div><div><br></div><div>Both running is a good strategy??</d=
iv><div><br></div><div>Please investigate this performance issue ( i think =
this do not impact 3D accelerated gammig perf )<br></div><div><br></div><di=
v>Thx <br></div><div><br></div><div>Luiz</div></div>

--000000000000496b1306212b2eae--
