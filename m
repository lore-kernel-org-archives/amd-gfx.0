Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB228D2629A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 19:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6218410E05B;
	Tue, 20 Jan 2026 19:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j5TlcKWR";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2575010E05B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 19:53:03 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b7063004daso53780eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 11:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768938782; cv=none;
 d=google.com; s=arc-20240605;
 b=Ip2X7q17V89xezzHqMoVUtBNWTx44e9DGQkSYX5qfk8wSH7dj73TztOg70YLYwQPPz
 PAsebv8oSTD+Xzi8tsm/NCsQjY82zRA2lB56qsGEjS+SR4iGeK5sP2BNGTQ1n0Wwu2W4
 jttQJbLIFD6xDM92wDQwpMXJ5aJ5v585PSvqfNV8VorCT3YH+WV1HPSJqsGPdBC2403o
 r9OufXcen89Ot7DZjOAp3IMCeeIlJvH5/vLhQhIt21Vh2LMqN1g3UdyGiEVJYjZVshUT
 nTihnLNila7NR26Z7/eTFkPdFd82fm2RYIsqr2qJl4AhVgUhkAISDPe+gUgJfHY/l48F
 kbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cP6Ui3hdVeWb2IvSHDZoOOHidwMq1Q5k/ZlHS1KcnOc=;
 fh=JVVyiAmZp/kVLZ3ul/Tc3JYad37zw5ivX7CBZ/AloAY=;
 b=S/YbYeiIEO4aKtPiOY1CfTcde+LNHLOpqTEzBJ2jgnzc6dAWD6206HWhQpElrotm00
 7vzhXqYZbZjFYKrVI2JSueF+1BiaGS8cgtdNE9XmWxYNNNUFI6G05QdnSwUNzBQkaKJt
 wgU9QUb3xzckxiBlPS8TDrbbIA0uZ77IcJxZEcS5rxPJaH7xnQmcqJQ+dL0q1fLIQVW8
 qpc8trsuXS7o6PW5jv42nGCD/f+Dp0FkdRLvjxTcIcz2t9ySKbLkgZTIGqZ/lUUmxJc6
 kw3JqGnQiipliH6wiKERdEimNLpwVQF2k/wzxjO5mwlgy2l5g0RXa1ndrzqcumqsIvjM
 PErg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768938782; x=1769543582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP6Ui3hdVeWb2IvSHDZoOOHidwMq1Q5k/ZlHS1KcnOc=;
 b=j5TlcKWRYTHosoUxZHHJFxSgE0kg7xMsynYLTm0/wXUzZ/pxLtbfGbJBt9tJ7MxVFc
 i30wTqACZkiRRWcGCzf6l+Wv/1tYUnUJGVjNvcGkp8wOINC0IsqMbXS8u877M9s/Mb2P
 cfJlChmVqGZGDiLCn/uxLUeD3Cbx4JxyjY/91RhZeMQFJkUyy+GorzMMrjN4TPiQLbCY
 +0Ypg7PDKjhY0gn/c2UeMS6cr446bggstooJFMLF1AOIp6SjVde4z6bdCkfuelEJPDoM
 Mg2frvcPwj82T5H00p9NJZdJT9k6NkiSaRvy10Y7/eH5hEbHcEuiHNLrtS39+Cm6G21z
 CAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938782; x=1769543582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cP6Ui3hdVeWb2IvSHDZoOOHidwMq1Q5k/ZlHS1KcnOc=;
 b=wndCnJbMecdTfE+yqTrdtxkyP7v3ztFb+mz5ngDXwEFkGWYRUdbSxgQZLXBtQ7/VA7
 6umni6UkK4sjSyeMQN28xEV7Om++JGk72Q4cltY6pjJ/iLdvXV6edV/9n6UaZp7gnraP
 lUkoclMOxKGfOv0UHnf2oyJYq1Nj5KGCmHGxni8ZN4vX297Bmo3vj+CU7xPd6USLiKBy
 vzbCeHfyoYEJnsg3c8l/kQukpai7/sy9sgQDPz3wkUglqOpojw7RLV8Fj9DD2l0XmUPo
 X6GFaWmKEPV8363VdXqduyh1tMi8hbc4WLRcLw05ZOpGag/aF/R8V1OCcZNfz1guGoxA
 S4Uw==
X-Gm-Message-State: AOJu0Yx2NpdmWorog4MqFUbxtrAA6+OEXmelP6uVfOM3v0Kk/uKWB28R
 QCBiM0XZYRje0kyK8jAiN6ksrOnGZVO9buXDa8hSgAXXQSIY6P+a/tJ91l9YI87RKZdDOU+Mp2s
 3+kSlHwcrZLgi/8GSJuilO3n7L7Tp648=
X-Gm-Gg: AZuq6aKyPJOvRg8m4ntzVSTuLYPDHmfDsMVNc1Nj7isWuKaHbSc/rq8HYvgt3LBk/mK
 9aKkihtttielHuYNao0gCaPy8ON7I0uD2k3Ii5yEbxGoZnjUZIX4c7qPnH/JZZm592fizBGp+40
 xsu6wB//sQC/nO8oq9kwuR+SniWw8hDahSuhNKFAkywfcf/nMrVIjKF95mkpQhLdUntiwvIBX7D
 7ViKCbG2IExjR2VEN5PtwIjOG7uFNeokndKXyu0LrfW2JIHYlKlPO/0rGE5VjaK5ctLpwSY
X-Received: by 2002:a05:7301:3f16:b0:2ae:5e96:9d1b with SMTP id
 5a478bee46e88-2b6b40ed366mr6240303eec.5.1768938781894; Tue, 20 Jan 2026
 11:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20260116045319.773093-1-lijo.lazar@amd.com>
 <a42a5b10-b0f2-4833-bac3-c2cc83aa6921@amd.com>
In-Reply-To: <a42a5b10-b0f2-4833-bac3-c2cc83aa6921@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jan 2026 14:52:49 -0500
X-Gm-Features: AZwV_QjLQvEbHLd9paNziQK9vhdkf9A2NbDgaUe5HVTK3OVgvj_qDdpKPG3nhrg
Message-ID: <CADnq5_O7wZFui8VML8o3ogE2jKkH19mWn1N-hgu_NXmMvK6Q6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid excessive dmesg log
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, victor.zhao@amd.com, Chong.Li@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jan 20, 2026 at 11:02=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
> <ping>
>
> Will reword the description as "KIQ access is not guaranteed to work
> reliably under all reset situations."

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Lijo
>
> On 16-Jan-26 10:23 AM, Lijo Lazar wrote:
> > KIQ access won't work under reset. Avoid flooding dmesg with HDP flush
> > failure messages.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 6abe5103a78d..2bc305b9aa26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1298,7 +1298,8 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *ad=
ev)
> >   failed_unlock:
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >   failed_kiq_hdp_flush:
> > -     dev_err(adev->dev, "failed to flush HDP via KIQ\n");
> > +     if (!amdgpu_in_reset(adev))
> > +             dev_err(adev->dev, "failed to flush HDP via KIQ\n");
> >       return r < 0 ? r : -EIO;
> >   }
> >
>
