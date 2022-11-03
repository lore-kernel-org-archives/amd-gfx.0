Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B88EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 08:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE73310E701;
	Fri,  4 Nov 2022 08:36:55 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1210E78B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 18:19:46 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id f37so4212689lfv.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mBMwfHbD/obIGpPs9j+V0BXFmqdzMaCJLWzQ7EenF+0=;
 b=X2xULSmcdAu9gJij6k3LSg8njde8A4drH/VRx6Q7eyWoopc2IX1dFT0XdX9xh/Qlqk
 whUsadfEKmNi2mCZXtZAJhmDOOw/wynQJuhOUoRbbVfgB3hLwH3D+u6gEdmt+t4MtgHx
 hf/KUVYySudOJ6aw9TWiqP/bMqNVd7LJZ1LcIUP9YxIo/AnM3akljKVpW7tA2YYPfs5E
 cxMSpDidK4HeIuudiq84FWiMrNupce5W6pukJ/EZP0cGlT6PxvL4qo7caN3yrJxe8HVS
 sTx5bkQOQCZJNM9ye9t0pFMwH+bqLgX75IKyQ+wfwN+RpbXylX6jgyVJ/lqvjNGOru70
 p50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBMwfHbD/obIGpPs9j+V0BXFmqdzMaCJLWzQ7EenF+0=;
 b=6zT1ggT33lBdQK8dAcI/54Y/6in70xR9Y7mZYQi6kucNdfQAcRJ9snND0yppzscQO/
 aBPsCrBYSWLbSYWuPU2sBRFW0O+IwhJk+RRIUgSRd7rwq14TA1CznC5irQjvOXUNScLb
 t+vYYPtkz+vi8Y3RRvD/Ouz4SmfkKvDtxq72txJnRQUC2v3ydZpY/2V02A1b8BRj13cz
 TTRjvwBD+optSnKsViLpY3mHGPHIhzYhcpA8XXrLWPFtAteCGAaQN4PDeIBVzqXcVUPH
 e3Gd7AApvqqOKaYPtWk6qmhEQk1jZMuJk4xSROXfBWmu+CS0UIk5R6X2OUDB9SO7FUwI
 Q/Jg==
X-Gm-Message-State: ACrzQf3i0lakNCszsOv0RAgf3/pQTBZiiBusWEh8gHYXxzuIlagmKM54
 ZFXPE/KSGWOyykGhmTiBeAFPWIuhW6mXvrcdcxuM6m3oTBc=
X-Google-Smtp-Source: AMsMyM5m6X97qt7HCTWrHMkYajgU8PaWFZ/2b7PUP6VN/wkFMB7hbi7xEPcn3x4Ze1o/iH/I1eq6bNM5ghqrJjpukCM=
X-Received: by 2002:a19:505d:0:b0:4ac:a13f:9bb7 with SMTP id
 z29-20020a19505d000000b004aca13f9bb7mr13233775lfj.78.1667499584600; Thu, 03
 Nov 2022 11:19:44 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Springer <stefanspr94@gmail.com>
Date: Thu, 3 Nov 2022 19:19:33 +0100
Message-ID: <CAE4WtP_WeySs-QFueBX0TCN=pMMu+NNMpCikFH7qAKF=7yvdww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: workaround for TLB seq race
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000673cf105ec9500c6"
X-Mailman-Approved-At: Fri, 04 Nov 2022 08:36:50 +0000
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

--000000000000673cf105ec9500c6
Content-Type: text/plain; charset="UTF-8"

Working fine after 26hrs+ of testing, plus another 24hrs of the previous
version of this patch.
Sorry if there are multiple replies, I had to figure out how to properly
reply to a mailing list, such that the reply is picked up by patchwork (1st
time doing this).

Tested-by: Stefan Springer <stefanspr94@gmail.com>

--000000000000673cf105ec9500c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Working fine after 26hrs+ of testing, plus another 24=
hrs of the previous version of this patch.</div><div>Sorry if there are mul=
tiple replies, I had to figure out how to properly reply to a mailing list,=
 such that the reply is picked up by patchwork (1st time doing this).</div>=
<div><br></div>Tested-by: Stefan Springer &lt;<a href=3D"mailto:stefanspr94=
@gmail.com">stefanspr94@gmail.com</a>&gt;</div>

--000000000000673cf105ec9500c6--
