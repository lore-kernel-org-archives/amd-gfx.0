Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E00AC54FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A2910E808;
	Fri, 20 Feb 2026 08:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwNaf1eQ";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0438710E34B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 02:55:31 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-59e6b7b11ebso1915729e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771556130; x=1772160930; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1wlu+Egy8kX5COPwj3XJx/HFDM+oi/MNIFa11uC12I=;
 b=BwNaf1eQJKsaXJ3JWd/smP4Cviiqmyjtzx1njvw92q6qDpPz8lulQcF+x7MwmYYmom
 lHQeQsxXHyYLDHJahmF6xMITdYyM1xpVveqbAaqV77MMkCpMmNNqaiuWkEPv9yssYK+M
 XS6oawbNBbPRmjWsmj0XLX+cwCILiklIQrwcUD+4Mb1R00jWK9zYImFIUJcj3WeS3Y4c
 58ypcQ5HhnYC5VprNVXPXa2WA3tMcR87YY9AHQ7I83OJMFvR1QF3KBOIR1zhAwN1fo2F
 HyA4Zg6em0+ehHXR3ai9Zh7nXkBiKtGx+SZGRFUdEQignaiqQrxsAkKbL//ldgmRFOAj
 /hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771556130; x=1772160930;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O1wlu+Egy8kX5COPwj3XJx/HFDM+oi/MNIFa11uC12I=;
 b=tJ6b9uHQobu/yHHPubR+bNBrhN26AL+W5EY4LTylrvss+cCau9e9jEKwvrauI5mfWs
 aqoiLYIPbKDpPLki4b/awUbrC3e3JwGcy4O0OnptOjJq+/utM6NdIxVVaaSdRuwGDeTP
 U978z1htKYThZp5ZE2QWwF3dUakUqlblmtx4zK7Yh+BqNK2LXuHJzrX9UeW/wl9/0vyI
 jMRuVsZE2HxNt+ieoFYg97614iDEulS+UdqZ2FhKNWBkGAmhitzhb3c5YeURrFNT39YV
 j1Dm6a6U47MfGuKET6hhWSKxvcHh2Xbw4Wnx9LVewz5WNZLJQksSBHMTtzQlkjLagyXU
 Co2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOmxCsQj4la2t9DVsSdG9uMBMBlbUhaUD+JXThQoVS4I4TcjsKTXbCBYjBU1NSVgXFzl1667h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoNY5Jd5vLkiFjdVT+Pvy70irJnTCZU9wtY0Lw3pcjmP7t1CG4
 DgYr/ipc3qM+n/XmwzFAkwYHVhoI0ChH4f3Y+89fVQ28A6Bivtp8x18=
X-Gm-Gg: AZuq6aK8QOxxGHqCX18iE8AyuzbxNeyBAiGP0xBGKJS3DZfOMaJDkRZtyAbunTOlfuo
 FmlPeUswo4nRp6I5mgPsNT08/GUzyYh95FH+j18gZxLdgsDJb/AZ7pK64ycfBCbmv51KSVIrJXS
 K9gSpdtVHY8ZEe51jVF7nSgWu6aV+uAomZdn8d1TLX0TZiSNqcZkAwKbhljZZzJ97Vgvo+onB/y
 86U1w8b4NNvGbDJ4utVY5uzQafoutU6UC2BFbWj6+Kdu/5BeIcneXEaE6xTxyQOXaxof6hGzREG
 vfHe/PJUyo3d/OraC1LuMJ2kYdrgfpWWYdXQIWUBieWrpzECDtErz/+e/YdsFD942p6ArXSHRY5
 NibpzjJ2/4JmWsWTH02siQaf7MLOEYLAo/B1UtHKx8ZLRin/ggyJB7pKU9VDa94V6h6n1m0ZEi9
 ML7PunvIA=
X-Received: by 2002:a05:6512:3b9c:b0:59e:ccca:87f2 with SMTP id
 2adb3069b0e04-59f6d37ec2amr6050451e87.39.1771556130186; 
 Thu, 19 Feb 2026 18:55:30 -0800 (PST)
Received: from localhost ([2a0e:e6c0:20d0:4f00::1d])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e5f5b21f7sm5679427e87.78.2026.02.19.18.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 18:55:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 05:55:29 +0300
Message-Id: <DGJG8IIRDS5E.297UI3P1W2PWC@gmail.com>
From: "Ivan Sergeev" <ivan8215145640@gmail.com>
To: "Ivan Sergeev" <ivan8215145640@gmail.com>, "Mario Limonciello"
 <superm1@kernel.org>, <amd-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>, <regressions@lists.linux.dev>,
 <mwen@igalia.com>, <mario.limonciello@amd.com>, <alex.hung@amd.com>,
 <daniel.wheeler@amd.com>, <rodrigo.siqueira@amd.com>,
 <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <christian.koenig@amd.com>, <huangalex409@gmail.com>
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
X-Mailer: aerc 0.21.0
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com>
In-Reply-To: <DGJFVPAQJA15.378GMU7XZXLU@gmail.com>
X-Mailman-Approved-At: Fri, 20 Feb 2026 08:45:29 +0000
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

Checked commit 7f2b5237e313, it still has the issue
