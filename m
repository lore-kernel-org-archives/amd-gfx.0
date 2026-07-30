Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1967C55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 14:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C66B10E18C;
	Thu, 30 Jul 2026 14:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caGqHjdW";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29D310E18C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 14:48:58 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so1773313a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 07:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785422937; cv=none;
 d=google.com; s=arc-20260327;
 b=HBAG4sLXoQz1g+Sgk4jfwpW0CZYA4CXW96h5OAJy9hLvahGDT5H4ZfAWgQ/nNY9/Y5
 0EgvtsbzsR379fjHmVHc55DCaKcQ7/yPqBvQzu7P+C8s8clT8WbfztzfZs67RAi2d/Rh
 oGUA89BeOE4ALZYiqLKcdr8mGtc+xxrZOvcATBsvdumAFAW6C0Io5VRKaAYnxGe3+Gvn
 WNSkB7jVaLI6lvoGyJuiIUHnGFCiNqwYe0LllXq0/zk6/NBBIqB7Z3rksLdhAIDxiyUa
 3L8aJyptsWyea6kJj5P3olEHi0kI1YLZPG2XOOA/+/juApEVgLIhTOR1gulrpuPpdOuf
 Xv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
 fh=9ralXsB84RRWk+f1rCpYIdzvFBvKJZ6GqcnrsG27Rpc=;
 b=EFaSFvy27DWfg12xU2d+2NQBERxyHEpMR3wF73YrEBQO5z/kmjsjBSYapeCKxrSXT+
 Y50Ojfa1JR86YUaeX6DW5z5daQEY8hidg0JUsfMzaG6HjLhPtJ1wIBlLSb+AYQ6le3bq
 Mt9Izkog+Wzvm7o6iBk9Swbt8e01sWdlDD1qyruSZYMQAs48duZVz9el8wE39BUlf66f
 /BK2s4TbAuX4ghzYKi/3l7/kFVFs5WRlq12rj+3pDm505LTg+Pyq4gDI58YqgefNo9Ap
 UDIAZFLZBAAXV0VNB0kKEZhi63B2eygoRZprz8K0ub/YOhXRv9UumxvLjBS3KfB7AkLK
 Pctw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785422937; x=1786027737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
 b=caGqHjdWfajfr+pX6SRqS8v2LvyINeg7/E916iJz7DxXpy7U0jiK88yL7ouJ9hlaiJ
 r8iLGSXxCaTJxdRcen1RKx0fBrvgoOixngTV7VTcp5VEYXPCMooDPj8bKJ8h12/ya+Vg
 vUQNAKyRNx7BZEglNn2rmZuSzyGedsm7dBh4LuHXYXEGw/DladEtQsEa2xWFylbbRTaB
 mgF+6YerfTTSeSNcAe9pkwXugS54kger2qpdtUQ7SFBr4Ubekz9sSoXny716ozdveY9l
 s41zqX4GnbIdim0LzxujG4Xb2GYRVvElXHuMaqQl4jSQIAq6VzWQ5Nrne0WGxcPJh3H8
 zhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422937; x=1786027737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=px6w1UbFxmXtT5EikDouH2woPAjJM9tv/Dll3Izn9mU=;
 b=RNcH79r+glg0zDxxm+SiA4nZrvKV7ItB9vmtfeJF5MIGANR+92+YawO86d07oQIjlV
 BDLTp9M8+KCbU7iBlBmZDf7tFxnb5VPY+JmGqvGwz0bP4L37udEButHGg0jacJhG2tic
 PqcVe4/ORbfqynTyJiKB1SBe4lV7/Au+wyZxZbNVDXkt3dlf199UEVD0/RMAhwRBiBfy
 S4Ih7J6VEdUeSF10xQWxg36rXuq1gNLWsgtXjHOc4maiFt19oNLtVYO1F6FgPs0i5aeA
 U51KSZLUGQWicr6QW9dlwDpgbWW3kMBMIqynH27YOfHCN74cOjp6lq9kveqIoWVVpRbj
 PBJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcgNUfl23YdCOQQpkINq11YaSTHIjzJNcccOIUHCWEqW+A2UlIEV11csq2PzNPBThsF47N/P3p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ/6HuoWiceE7Eb4ajWWOqOcKgQk/07Ps4TkSd6eAHSbB4By4z
 0jZA9V0dtgpGxXncvf6HcA7HIawJ8XFWPbCVsd96d1OhCLxAvPlM6or0F3nUDM+u7S9EdcY2+I2
 4wsjRubHHigsUbgyV6KBG+Lt1JD2C8JY=
X-Gm-Gg: AR+sD13KDp09+IffvHMMnG0AkSgLfCEZERYyScIkDCxE8PDZtKLC88at7oWTI/LZZyQ
 Y7C/cPk6CKcQKjxCMIwOqlWKfYIgs+POh5UqFjeJyI4fDP+F1SdeSyOHy84TmgF5UDqkbr1Fe98
 vNmfEF922qGb/JeOc4T/yOexEjPKDkMnac/lbv6nXzMNSLjkJSDMN9DZ5+5bjEfuuPy4QK12XCs
 fE37ZwANgBycjj+TeQmubuxSP47bGiHwlvwaqJesQp/br28p+us/xYn7TvouWxQvKKU8kFNmv0x
 qfldBh6SF3eOnZbcYO/SVlelPVz0+HRLUf4he/BFLtzDMA==
X-Received: by 2002:a05:6830:4983:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-7f03925069cmr647058a34.1.1785422937495; Thu, 30 Jul 2026
 07:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
 <20260723221910.85822-3-vitaly.prosyak@amd.com>
 <69043022-b215-43f4-87ff-71c52d999021@amd.com>
In-Reply-To: <69043022-b215-43f4-87ff-71c52d999021@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 30 Jul 2026 19:48:46 +0500
X-Gm-Features: AUfX_mwtO2881UT71vQP47iS7hve9V6LOCsE0Uggw8r4-1ND3LkHP3IzqD8kFhU
Message-ID: <CABXGCsPXb9zZA3U8XmPsx_Es8E_6M4w8SBNUC1_oQ_Qig1hYpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix lockdep false positive in
 amdgpu_lockdep_init
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
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

On Thu, Jul 30, 2026 at 5:35=E2=80=AFPM Arunpravin Paneer Selvam
<arunpravin.paneerselvam@amd.com> wrote:
>
> The fs_reclaim class is already registered by the core kernel on the
> first GFP_KERNEL allocation,
> well before amdgpu_lockdep_init() runs. Is it kept on purpose, or can it
> be dropped?.
>
> Otherwise:
> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

You are right, and it goes a bit further: the class is registered before an=
y
module init runs. Every GFP_KERNEL allocation goes through might_alloc(), w=
hich
does exactly this fs_reclaim_acquire()/fs_reclaim_release() pair, so the cl=
ass
is registered on the first such allocation in early boot. Registration is
idempotent and its order carries no meaning for lockdep (only edges do), so=
 the
pair here adds nothing.

So it is a no-op and dropping it is functionally identical. Data point: my
original patch did exactly that, and with the pair removed the reproducer n=
o
longer triggers the splat and lockdep stays active for the whole boot.

Keeping it does look deliberate rather than accidental, though: in the v1
thread Christian asked for the annotation to be moved outside the notifier =
lock
rather than removed, and mentioned pending work on the VM eviction lock whi=
ch
has a similar fs_reclaim ordering problem. So whether to drop it is a call =
for
Christian and Vitaly rather than a technical question.

--=20
Best Regards,
Mike Gavrilov.
