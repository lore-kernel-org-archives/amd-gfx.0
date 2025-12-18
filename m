Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC94D6D220
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F7110E451;
	Thu, 18 Dec 2025 13:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aqxxtvn/";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6694A10EB06
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:28:25 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-34c213f7690so308461a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 01:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766050105; x=1766654905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJiWLRgJo9tp7oY1C+RHdHHn+1eyK2bNbYU2ktmgLnc=;
 b=aqxxtvn/qpREXa4Cbhkn8JZzDQn6v2/TV6mK7zBgKQH0BRJoklAfQheEFSwY69mKUV
 HT/7IOZg65XdhSRc6YHGzyNTzf7yUL5rDouogDqgvjQwytlY/Sy9stuO0eohlUDgRQsa
 BIwSOq8FPyh4Eu2j93sK85myyU8oM2Jif1QpH7x2TWQswcuPSVfJipG3oKQOeFi7cztJ
 vvuttCe/53cb2ZDkj/sLvwLiMAB38rO6zJid1i2CVhWnSOqhJBe+y90IL5h+uuCHg/CA
 71E/Z5J0ZjWSXVECce6mWIQ3tvcyEgIpmzrAPrcGHDTCkYKdeo+MYhTpz65ISHgeLSWk
 NC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766050105; x=1766654905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EJiWLRgJo9tp7oY1C+RHdHHn+1eyK2bNbYU2ktmgLnc=;
 b=Sz1Y6J2WibiohWuSCrPrSy4cXkkdYiB1UKdDgtPXNbo5LboRbSdcnVBvaA0b2fUsLK
 wgrTkIJ7X1lI1aexbOMtNfZ+m5aYog3nUjMyAdNPUJZDjmwzATZUe4gtZdeF6qXQB+B1
 0zR2OspPG6L9GynR2ygweyKRLMoBckFHCqxL3fZuGDt1xaEl2GxiKPDoYGCIVI8IaQQG
 a4z80ICsndAvAltoywE+qG8gs+Nkb4lvW/POh0cY19gPAp+H0rNKuSdRge4gsaIA5qid
 sgy/1RPXt96DLmNdt4tdX7/I2sKwwdwJuQlfkQVa8NaxDyDX6WMhTQHTuMrXErJ062+5
 A9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhU4CNJ8YFJklPQqNjfk6DHArf6jnoWQWyZvAbNT5C8VdHJZKHqWQBRhcloRKKPtgl0NRjhoPd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVikvXN9Q5Ef2ePu+2qLJEiZi1X2VEXARR8WU7qEqUtagr2bVP
 cVWOK30SPLlT2+Lni0NbALidSVZb9iqkBk2M2Xa6bSQrvsp1GwUezvYtJBVNBEhYu6EIviYaGnE
 qPIWOanYAV6+fZjKbMXgPDLCMfmnd0cWL7ArhmXbjeg==
X-Gm-Gg: AY/fxX646KJOl4qNDmOipHPOhbDb65XfXdFhDaDUmYX7j8xqgzglzbpexr1HkmDiz8l
 irHNoPBPBeamLHorfkJwMU5tBNeIffKrTVmPYz7uwdYKq5OzR19BGYo11n+djKFf5DHPAl9wu/h
 M3sbBTfxA8yi5ZALrSkSPZ+UQ6mIFGyueHrxCZRCLo9ewlAJLK+jLY+hZMt6mkMiWia6qAsb/o+
 XD3ZXxoWpVI526R4V9XhH1jm+MfwLJU9vcbNl5c3qfW9YkkqGWQVhd0YDKqx2927mw/QeHp+gUy
 XIo0TqA=
X-Google-Smtp-Source: AGHT+IEXBcsVc8hlqDUN81ixxAXFeEkb9O19zutWwpIKpuQ7pq9LUb7JZ/885J2I1GT8Aeo3ovjOaxqMuEqAo1owGfw=
X-Received: by 2002:a17:90b:2ccf:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-34abd7617ebmr22164740a91.17.1766050104749; Thu, 18 Dec 2025
 01:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20251217170104.2767939-1-suryasaimadhu369@gmail.com>
 <b767cb12-3023-44cf-9d4f-2fbb40c1431e@amd.com>
 <CAB0uMAfx4uiXZg5HB=--0Hpnx6nD8pu4a=pWmFK2B8HHx4R=VQ@mail.gmail.com>
In-Reply-To: <CAB0uMAfx4uiXZg5HB=--0Hpnx6nD8pu4a=pWmFK2B8HHx4R=VQ@mail.gmail.com>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 18 Dec 2025 14:58:13 +0530
X-Gm-Features: AQt7F2pyWG9gfPVDIdJzpXzA3zdgwaHJnjiNZcENzl8bee2Wfatdzc7hVtdotg4
Message-ID: <CAB0uMAcjb2sZ7go+hF8=R2DvdABU=mM1z5PpKTenqkM=6z=ENg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 siqueira@igalia.com, mario.limonciello@amd.com, wayne.lin@amd.com, 
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:38:39 +0000
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

Thanks for the review!



You=E2=80=99re right =E2=80=94 I=E2=80=99ll switch those remaining cases to=
 pass adev and derive
the drm_device via adev_to_drm(), and I=E2=80=99ll also compact the logging
statements a bit.



I=E2=80=99ll send a v3 shortly.


On Thu, 18 Dec 2025 at 14:57, Sai Madhu <suryasaimadhu369@gmail.com> wrote:
>
> Thanks for the review!
>
>
>
> You=E2=80=99re right =E2=80=94 I=E2=80=99ll switch those remaining cases =
to pass adev and derive
> the drm_device via adev_to_drm(), and I=E2=80=99ll also compact the loggi=
ng
> statements a bit.
>
>
>
> I=E2=80=99ll send a v3 shortly.
