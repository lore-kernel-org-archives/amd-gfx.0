Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE3D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 15:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E65510E3E8;
	Mon,  1 Dec 2025 15:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OxR8T6yz";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF9C10E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 15:26:18 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7bb2fa942daso501514b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764602778; x=1765207578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ml4/jt6v9m5Now3kxrI0IR0extujYxAC/QOxG8WPGm0=;
 b=OxR8T6yzN5mNlchqsigeRvh8GXHdMWDtKqGQFWElaHUXnDWPIsS+erXX8PF97KKscF
 SiDMceZE4xTS1wAeXcsy+ZR/08aoUqOwYA1ZrvXupmBK2+/JEGZemosHPY49uQ6ZzCva
 gTLAGOlVwSdzbZt59JxIBJuRzm44ek4Rug3ufU1ci05g8eQsXBlAC0tBDEvYQeonYsu3
 t0yG0vBq/u/fLf0bZVVG+0A173B4z9fcyP2yCNkKaUsWNs0UZEsyghj6PGyC9zuQhWG0
 +0phF0U0IqwLDjahMirNJthCcg+yDM5bEVV6GLjQd08G3XznCq/DVDfGUV+Vl3XnVJH8
 8/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764602778; x=1765207578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ml4/jt6v9m5Now3kxrI0IR0extujYxAC/QOxG8WPGm0=;
 b=JD/RexpTokxFcjakQRiwx/GH/WkTkuF/WGuG+iK/WQQQmjnaiXh718Lr5OY/UuP7LU
 Wgs+YGgMnB2O2JIMT+f+tEvAILARtyeE1OhQC5k/GnNrGYmprkauPCGIyI85UFKtw1fg
 X92NRWjYjZJKDjJ/YW2V5scRSUPj6UWJ+3xwoAQ8wCdYwx/7MXMwWwHKnJa4rGIbuQkR
 ewMZ92BQbntf6ru5DM13d4KPVhRxrM1eEaEFdkNFpXJxkjRMPo342osllu+HSlVB1fM6
 d9g2feML6orWr92fWyVawCId9rd+F3I3hu4PiMmMFt5LiV6rO+sF2hsyUvHBVkl2Bywb
 6Cbw==
X-Gm-Message-State: AOJu0YwPu4pCfsPj2wuhEpAv6quKAK30humXM6QKkKRb6PyvpUNV7f99
 gR8VmB5ISsxx6o+J53ef0WbJivQ0q5P8cOgqFTar3jR0g1vzY9RTBnMCokE1I6HzTOeBj/kjg/2
 xlZwxOJeYP8ocjgUOOu0eB6yYUwFBc4U=
X-Gm-Gg: ASbGnctfEbVxlB7/CX66zEnzC/dy4kEU3L5lobZUAfNs+0L6iE+921T3ProLmi5BmHT
 c77NgtMeEzAVae3dsdkZReaarpS+yG/sCpyxLLx5XMxZW8PrCQNp+SrQyIXXVSGxsWPyt1g6WcI
 bDplShyXmpN3AeOPmx5OyrUDcobioMRMU2ASipfQn2/jqcqGiWTLQDuiTOLbhXRDx4ltkip4U2U
 MrFFtZFqQLu8o3Ffic0JCaWzlL7/0VuR01v7QcjZkK1r8O/XwpGfaQIrGTQxf7TQm9UAMA=
X-Google-Smtp-Source: AGHT+IEo5eOKFQybJ7oJWziii3cU2U8R71t10tboKYyXA446i38d2bhKE7Ghk/6+/ewuFX7+BcHVftjWChtzUxq/hGU=
X-Received: by 2002:a05:7022:1305:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-11c9f24442dmr16336662c88.0.1764602777634; Mon, 01 Dec 2025
 07:26:17 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
In-Reply-To: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 10:26:06 -0500
X-Gm-Features: AWmQ_blzDv7rBj8r_CoF_O-zSK531vVPwo0Qzlxk-wnoVnQFGAfNKsIJkQuP5T0
Message-ID: <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Hi,
>
> I was wondering if SI GPUs support reporting power and voltage values
> at the hardware level? I read somewhere that it was supported from
> GCN1.2 (Tonga and over), but I haven't found anything on prior
> generations. Going through the register names, I wasn't able to
> identify any who may correspond to power or voltage level.
>
> So I'm asking, just in case it is supported and I missed the
> information while searching for it.

Correct.  There is no interface to query the power.  For voltages you
can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the current
DPM level and then convert that into struct si_ps to look up the
voltages, similar to what is done for sclk and mclk.  See
si_dpm_read_sensor().

Alex
