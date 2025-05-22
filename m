Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B69C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC0710EC6D;
	Thu, 22 May 2025 13:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LNpJWyvX";
	dkim-atps=neutral
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B528810ED54
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 11:30:43 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so192952339f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747913442; x=1748518242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tO+EPnAPVJiuWHkuvnHJBaP5+AY092bC5r7Cuo5Qndo=;
 b=LNpJWyvXCwaHG4Pn84dQAGbRXAnQNSiqInB9aF79YvqWU9npcmw22j+y2UNMplMBUF
 i+fsBa6rzz6kj66rXOnwLQnMjqjC7Ta+Dp7vaJuhdLbC2/Ovxvrlj7madFk1VVF9qoXd
 w2vrixsljh7KHhpQoAdUSLlL/NoolH1iy4nzgO/XzK67VcrqOEfy506F8WmiCqgkPLBv
 smb7ZZdRFCbIDUzaho4Qbddp6wUdVjX8hbrQb14sNCc0x7chr1Flkc107eugfXGcGXbc
 IAPvwnE64nN9siSc+hPT0p2Bbyj6bf8qrFPF78jv9Z2Xml1MpjryFFL8xbp/HxbtJBQg
 wG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747913442; x=1748518242;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tO+EPnAPVJiuWHkuvnHJBaP5+AY092bC5r7Cuo5Qndo=;
 b=eqtvJ3G1KvtOW3ezqQw7c1MJOE5ONjDRDPtJmfkBHiVEu2rS8WYHSzSInwPPDEI3l2
 bNqnW2hCOJOLIVndDL18tTJ3FMiCvgR6PZB7POtVAT6maNjjxrCyNdNJReIq7UrKz/+m
 g5uBGqFUOjcecCNWqHhd4i3EwKA8/wopOuOid6UwVlsT7dT2dUyDaYvy73NEN8Y9wiQE
 HljsTp1gecdqn1KvFVuuMKv8oGIYVrCxhUEo2Un2IwSIVDmXJrNMxAPAN4Cy+ZPlSSrZ
 nJG5a7wI2/A5vW9Dm2rMGlTIA6MtdsdEizudGmz/NS+hayc6N6UfJrgX1ucFcZ+NTh8U
 NONw==
X-Gm-Message-State: AOJu0YxfkAcbtkv/liTH6n0uxi/5BEMPw0iZGVkyjxq9RGBaBEEZRkms
 ShluRks09jParzEaxU6li0vlhg26dENf2GJ6Bqc2uNNNZ2tEMpKaAEoIWS9ebMEXGakPA8D4vMD
 b1+VoTuHIiCyL4Rko1aHLLphBkObHFMaHGtNnyMlv0Toq
X-Gm-Gg: ASbGncsoOq+iAj76kkPlhvAwrzuLBjpwJ7iPxrChMarN5M0qDvFdAGp7TBpQXv+ql/q
 dFmLKBVwSV5+iwq3k4S31YUzCwtVykKS6VDcDCvlz7yI9AHdMfQp0TOk/fMgOsJgQ4ZvBib7jY+
 MihWDNhuBrKsutDvibKeo8za/YmswbLhs=
X-Google-Smtp-Source: AGHT+IGQoGOWevIkTplWz9TkR9JaToft2uJmM3q03OA0sccaFwSHS50uy9tOl+Ov9hgjeW8mCnQEzEQBjB11qIWGagI=
X-Received: by 2002:a05:6602:3799:b0:85b:4afc:11d1 with SMTP id
 ca18e2360f4ac-86a2319bccdmr3203445739f.5.1747913441690; Thu, 22 May 2025
 04:30:41 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Durmu=C5=9F?= <dozaltay@gmail.com>
Date: Thu, 22 May 2025 14:30:30 +0300
X-Gm-Features: AX0GCFscMOU6vP8UZ7irVCBVzgloDU9wjhyooSHHnzwONQS1fuipRkGZevNiFTc
Message-ID: <CABH-8xf3sg1CiHWM9nN0a3eSRTF9Lc_vkcZDzbvWZAH0f+Gf2g@mail.gmail.com>
Subject: Regression: RX 470 fails to boot with amdgpu.dpm=1 on kernel 6.7+
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 May 2025 13:11:55 +0000
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

Hello,

I'm experiencing a critical issue on my system with an AMD RX 470 GPU.
When booting with recent kernel versions (6.7.x or newer), the system
fails to boot properly unless I explicitly disable Dynamic Power
Management (DPM) via the `amdgpu.dpm=3D0` kernel parameter.

When DPM is enabled (`amdgpu.dpm=3D1` or omitted, since it's the
default), the system either freezes during early boot or fails to
initialize the display. However, using the LTS kernel (6.6.x),
everything works as expected with DPM enabled.

This seems to be a regression introduced in kernel 6.7 or later, and
it specifically affects older GCN4 (Polaris) GPUs like the RX 470.
Disabling DPM allows the system to boot, but significantly reduces GPU
performance.

Things I=E2=80=99ve tried:
- Confirmed that the latest `linux-firmware` is installed.
- Verified correct firmware files exist under `/lib/firmware/amdgpu/`.
- Tested multiple kernels (mainline and LTS).
- Using Mesa with ACO (Radeon open driver stack).
- System boots fine with LTS kernel (6.6.x) + DPM enabled.

System info:
- GPU: AMD RX 470 (GCN 4 / Polaris)
- Distro: Arch Linux
- Kernel (working): linux-lts 6.6.x
- Kernel (broken): 6.7.x and newer (currently tested on 6.14.6)

Thanks in advance,
Durmus Ozaltay
