Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDABC71155
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 13:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA9C10EB66;
	Fri, 20 Jun 2025 13:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mz9qYsHr";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3477F10EB66
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 13:41:36 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so200405a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750426896; x=1751031696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/6bsuNfHkfBce2A7YapT8iGJm2v+0j1xrLUx7YRlc0=;
 b=mz9qYsHr+MABhsYbFsaONoK5IC6hFNUh0irMQKHVJlLBjbwev8zEuuqT1yqZHvzJnd
 w3qU5qdsvJs46XuqREq8orbO23vkMrF5EPWZqoQmXUXRk+NdrXG39lbh8xUMvSjnidA8
 2at/pcLwsFnQfgymOhBhclkXaw/drKzs5+PMQ4AV7swBtF+DmGl5/6dvk1VVE4C+TOWl
 szoFgMUkLkVnFvSUfrp9ODMDx7od8HigEwVZD1x34pN22I+Y+z6vmIrdZoI0lpCsgDCI
 g88E+A1BVRqrpxcf7+vHK/pHkFNKEOlA4pc0nJGeYUxNfmOf3W0PHgmnaXn2m2/MZNZa
 gGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750426896; x=1751031696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/6bsuNfHkfBce2A7YapT8iGJm2v+0j1xrLUx7YRlc0=;
 b=XG4Mocn1t4ttcJuZPO5LXGre9MUK9Te7PIvJZx9C4x4lfzUlzHwfGRPajdYz/lHFzN
 +RN96h438yAWa19GBO1QCqlzqcdYBnrDFQIGINsr2zirY3uu6EkBHpCGyqthJaZcYMNr
 ya+Qr2zwEpzXvw+PN/xUDA8IzgltxnsnKtJGQSAJ4D+f8FYf9gMQbn3/4dVDSyZrPR8y
 9byB5rtOLGH2zGMeo9y5C6FcHhxHu1TwjpaERBB48g2e7/FxDJ5tp08WhHdsvskFvFa+
 R+2kRdj4V3ynVd90HKG5EWIeD1HkaSguPBb+uh5r5+5FfLHkuJi3K42H7/0Ee03gQKV0
 7AqQ==
X-Gm-Message-State: AOJu0Yy19M56lGt1Yp4qPNQT4ndI+EyJ/k1q4i/nvzri1r5MZ/WSnnVR
 0F2dixM6JtOFmYTIuHkEl2SCVq6C3lSukc7l3ch6neO4b4YuzEIqUM/MzG7R+nZ4bS4NPsibSzP
 zuxtYJsMxuWhX2HX0U+hVw/mTgNxzQXc=
X-Gm-Gg: ASbGnct1540euHsN5l6zDGWy3tyhYWuwgr9u8lTYHaH5/z6k4xZWGPAjjYn5+4gCTeo
 6o6FVFvP3ywt+lAcy0I5HOizDdDkKiaXAJ+4td24hLXOub9o0gLTWroA4Qac2YFOW9rvpwtIRCc
 e8f94JhEaqScPHGNKgr4gUITXg8OUeDzu4xD27uWfx5a3782Q/b8YdZzw=
X-Google-Smtp-Source: AGHT+IEiuxfb5OfCJr98Qy8xuxfo2rVL0locDdLR0wj7pNrr/iSaeVKUEfAfX9pFCyE+DIRcDPlLsUAsMW9E2rjM9Cc=
X-Received: by 2002:a17:90b:1cc3:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-3159d632714mr1869703a91.2.1750426895566; Fri, 20 Jun 2025
 06:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250620041420.3585005-1-superm1@kernel.org>
In-Reply-To: <20250620041420.3585005-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Jun 2025 09:41:22 -0400
X-Gm-Features: AX0GCFtUw6m8bfUgxvT6gYCeZkCOIjgmiyUwlk-uuYosh436gDpCN3Uh6eOMNIM
Message-ID: <CADnq5_MSvtEaN+UJXZkms6dj0pjznBM-dQOPqiuEMpeQuW_edw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add missing kdoc for amd_ip_funcs `complete`
 callback
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
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

On Fri, Jun 20, 2025 at 12:22=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The `complete` callback should be described in kernel doc.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250619205931.41cf9332@canb.a=
uug.org.au/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index a06e92b1b2ef9..bfb446736ca8c 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -396,6 +396,7 @@ enum amd_dpm_forced_level;
>   *                   (such as allocating any required memory)
>   * @suspend: handles IP specific hw/sw changes for suspend
>   * @resume: handles IP specific hw/sw changes for resume
> + * @complete: handles IP specific changes after resume
>   * @is_idle: returns current IP block idle status
>   * @wait_for_idle: poll for idle
>   * @check_soft_reset: check soft reset the IP block
> --
> 2.43.0
>
