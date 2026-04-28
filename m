Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7AFF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FC510E32D;
	Tue, 28 Apr 2026 10:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oCcPm1gH";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB5110E32D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:20:50 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso939991266b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777371649; x=1777976449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEcSM6duMh0crQ17Olr83ZKHna1cjEFoGG+FAN8fjUg=;
 b=oCcPm1gHfEZ3B0sJIaOkBwBizGqsBmL4qQZUYFuKXRu6+Sc8nlgzEDCZm9nrf9dIbV
 VAXztzIKzs9lREF65qdxuhsgaoBYsTH5jSkUcGH83XtvqrjxS/zZ4X/xe+H9PL3M5cXr
 VLR+OaHnwUhvof5w+pq5vhXdWmAPcFBWNb62vB6VRanROFzLlM1njeI/TV4MxixpvmF9
 O+Wkx8D4Mx5vU4jbkMmpJJ5ZxLw1G1bLFXMHUtGuLiPLAa7QfKhn6hgEBxWO3TJ2NN/F
 UOzvjo+11Xg6UgofnVXGoxNIs/ejFAZ5dSY/jr3N3V4/Y6RRVX8CKUeWClYJVlIWAW1y
 +GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777371649; x=1777976449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rEcSM6duMh0crQ17Olr83ZKHna1cjEFoGG+FAN8fjUg=;
 b=TLJlCvTsNP9ERgU7U/AAy/qCIra/HndQkaW9G90/r26JvEDoYWlcah9rbV0KQbIA3L
 Pxck5ru8Ro7g9ix0Dh3d3Ci0pZpnWGTDvdVv7Pkj9VvU6rtwLmAWP9dDTUIs/jKE0dr2
 xrwIWot9/3NiT/7R3Ya+5me27mdf1IHpTXwTI6aDjfYq0fSsYuTWMxTYuh4enYJdvDGW
 7nV7I8xYjikCFo+5jpG7kh33G1Ok/bsr+M/PCfe5hsyHrkoK0hCPyWe4ahJh0KS0TB/V
 lKsyc1s+ONdw6XJbBnopCFfY5CKm0/gV20Oidvp7i3gvbmuPbtRv+l9XUooG6JKiZ8Rf
 XuSQ==
X-Gm-Message-State: AOJu0Yxj6FKLIRrjW/XgokmFVhnwwS6z9kQr6oqyAlKHYPBeGF2W2jTM
 6BY6zdqGW9cOYytJGLX3mNhiC1bDVIaCgdO9O+pSDN3n0h3/uHR1sEScbJJzqw==
X-Gm-Gg: AeBDies6QXCHpb0Lw/3alkKrKFNCTiMIhG03kTfJEPvFUW3tkK9QC/fd6iW6ETAWb2p
 zcwAQI9Ye4l1lQyCK6SaGIbm0SV1FAN829dXCi0LE5fhnD1H819NIXZo2gxp8eU/EQHhS0zk3Cf
 46gyH5dar3uvaeDQ0chsTIW18ikFaG3hQN0IUdDeawt6wErAuQb001FjBUawOTXAvbo3WHH8mAX
 kd3FNnBPzcQAKR2SDvsAH/qXDzL6lSEuPmRt8yR8YJHcxDNP22HJdVSDvzrASTiydHIPKKTT8gD
 YT9Asje88CyaOOAL3uedMDOezW35xkXkGHw8CWpRBIxxi5cRPQVu2p2/hs1CvDOqVXPYYaqmD1g
 5l5GPI1rXbIN1gGlXF/cvYcdONtoMJx+jpvtn37L+s/XMjMJ4GRwd3kbSeLEUTb3CRzl4X08KhR
 x1bxg+wI6Jjfrl+NknwEdAcGBNSGOMIUt4PHKKRN62HrxWFZvhVRL/5yF39lVSzwo5Abc4puIYn
 66SBT2HKGmp4GJ5lJsb
X-Received: by 2002:a17:906:ef05:b0:bad:8491:85f3 with SMTP id
 a640c23a62f3a-bb804c32754mr132989166b.34.1777371648287; 
 Tue, 28 Apr 2026 03:20:48 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-679b6843509sm565723a12.18.2026.04.28.03.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 03:20:47 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: add missing revision check for CI
Date: Tue, 28 Apr 2026 12:20:46 +0200
Message-ID: <3692901.dWV9SEqChM@timur-hyperion>
In-Reply-To: <20260427173103.1020723-1-alexander.deucher@amd.com>
References: <20260427173103.1020723-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Alex,

On Monday, April 27, 2026 7:31:02=E2=80=AFPM Central European Summer Time A=
lex Deucher=20
wrote:
> The ci_populate_all_memory_levels() workaround only
> applies to revision 0 SKUs.

This makes good sense. Looking at issue 1816, seems that the affected GPU i=
s=20
revision 80, and looking at my Hawaii card, it seems to be also 80:

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/
ATI] Hawaii XT / Grenada XT [Radeon R9 290X/390X] [1002:67b0] (rev 80) (pro=
g-
if 00 [VGA controller])

Can you please add a few tags for additional context?
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
=46ixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (=
v3)")

>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c index
> 69d8b05ef2457..6e89a032e3dcf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -1333,8 +1333,9 @@ static int ci_populate_all_memory_levels(struct
> pp_hwmgr *hwmgr)
>=20
>  	dev_id =3D adev->pdev->device;
>=20
> -	if ((dpm_table->mclk_table.count >=3D 2)
> -		&& ((dev_id =3D=3D 0x67B0) ||  (dev_id =3D=3D 0x67B1))) {
> +	if ((dpm_table->mclk_table.count >=3D 2) &&
> +	    ((dev_id =3D=3D 0x67B0) ||  (dev_id =3D=3D 0x67B1)) &&
> +	    (adev->pdev->revision =3D=3D 0)) {
>  		smu_data->smc_state_table.MemoryLevel[1].MinVddci =3D
>  				smu_data-
>smc_state_table.MemoryLevel[0].MinVddci;
>  		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =3D

It looks like amdgpu and radeon behave differently here: radeon overwrites =
the=20
MinVddc and MinVddcPhases vs. amdgpu overwrites MinVddci and MinMvdd.

Without knowing more details of what the workaround was trying to achieve,=
=20
it's hard to judge whether radeon or amdgpu was correct, but it would be ni=
ce=20
to make them consistent. If radeon was correct, could you adjust the amdgpu=
=20
code here to do the same? (Or vice versa if amdgpu was correct.)

With that, the series is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thanks & best regards,
Timur



