Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAFCE6400C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 20:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32A610E1FE;
	Thu, 21 Nov 2024 20:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7OPIaMZ";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2CA10E1FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 20:18:44 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7ee36621734so186466a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732220324; x=1732825124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Y4Qh/+W08jp6nif6LZsbNT6pSylm1KKtsuDvYHIxRs=;
 b=h7OPIaMZ3sGtU77Yir4QXqcMmWXJgThbWPU2ZxMmQfJxwOzvmk0hXXBJIUuwcM4fRM
 AEB7APiEGJXfmdvthMs+/5C06aPGlAEtORgZN8THnuGAcoUuaWIHrEe4AS1HnJ3q1ejJ
 3/WzaAL5kyzmt4GiPXoE/RhrAknimKCwhpuEHujpg0J14vvFMctFx1NgPJxjcA8AEj7H
 +vcbVsvhAt78hUV32CweYFUik2RP/RZUEv7SD4O8lNe3+MpmnGEoFwKcmFmr3KwK72+d
 ogCYodSABsMRomPDNG9ic7TtquAAzBbWqSyxGvx9Bkc+th2vtJDU9TpzPnkiSuWPwmpZ
 Icmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220324; x=1732825124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y4Qh/+W08jp6nif6LZsbNT6pSylm1KKtsuDvYHIxRs=;
 b=EwqUBgra+XXeJ802/x3M1qzYTPTw7WuU/VEePHGLjfZNsi+IoOV374PUbagy5lNbSD
 XW6gKIHgHHvbsyIOCG7StjsKoGoQ958YN90kasFmhzzSEHa4OpXSzb8mVxLVVqjQgbfP
 V++gURgwWR1BGSoaNe9xH84Gyt2StepV0P/qw8rKYUCmqTn8tOQDHX78n3rev+7L59al
 cRiUHQWTLwY0lHbIoI2BjHiQlD7OAIkL1UeAskMerPOejHsEqXnbGeaBZTgeAp1sDnEb
 4XwMh6eOXbqsbUZUhn1ktwsJwDAGgPSRpgUN8kHgcx8MoMrrZG5bebzQBqONLAgvaY37
 OCfQ==
X-Gm-Message-State: AOJu0YytDKZlua/fvkupBsyBlw3EtfH8AUgqYoN+N9Q84VRVtt0XnJqZ
 tKXrGVYDtPG8L2iNWaoBflRIAZZpKDYyvLQ1fyW4UbykP3Lgu4vSvqBVAfQwF3quvFv2NeMyw1C
 eAh7zJo1WTUxS2g+uKX5glnHxHXU=
X-Gm-Gg: ASbGncsZrkdH19m4vWHZiV0h09F8MuLV+vghhbVt1jwW0+li3WxgRxVYCfijPVYCEOs
 dbUymKWa1bsFBHuB3uSlkOmwtplF5wKI=
X-Google-Smtp-Source: AGHT+IFf1yQshZ1nV8MJgHIjlnP647BExVqzCZ7bTd/YAT79lR80FvgwCLNsuM3JRTaFB5rhKy1V1exZnCAtREjJ2fs=
X-Received: by 2002:a17:902:f684:b0:20c:f281:fbf0 with SMTP id
 d9443c01a7336-2129f239d54mr2315785ad.8.1732220324292; Thu, 21 Nov 2024
 12:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20241121133307.594-1-shashank.sharma@amd.com>
 <20241121133307.594-5-shashank.sharma@amd.com>
In-Reply-To: <20241121133307.594-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2024 15:18:32 -0500
Message-ID: <CADnq5_OZqEw+y_KS9+vjNc8dUOfjwN=u4kjF9FVhcF2=uNq=HQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/amdgpu/sdma6: update mqd init for UQ
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Nov 21, 2024 at 8:42=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Set the addresses for the UQ metadata.
>
> V2: Fix lower address mask (Shashank)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 6e9fa0bc89cd..9af6aeeca063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -891,6 +891,9 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *a=
dev, void *mqd,
>         m->sdmax_rlcx_rb_aql_cntl =3D regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT=
;
>         m->sdmax_rlcx_dummy_reg =3D regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
>
> +       m->sdmax_rlcx_csa_addr_lo =3D prop->csa_addr & 0xFFFFFFFC;

I think lower_32_bits is cleaner.  Plus, if the address is not aligned
properly, masking it here won't help.  The hw ignores the lower bits
anyway.

Alex

> +       m->sdmax_rlcx_csa_addr_hi =3D upper_32_bits(prop->csa_addr);
> +
>         return 0;
>  }
>
> --
> 2.46.2
>
