Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B5C88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CF110E56E;
	Tue, 15 Sep 2026 21:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9lfdrhH";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4BD10E56E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 21:19:29 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8694801b07dso18373b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789507169; cv=none;
 d=google.com; s=arc-20260327;
 b=XtCNGY5s1E8lhGVPmqSnwSDUiTl2RFtAAuW1UcxiezOVoJ5cRSH+oMWQ5T9TSqL801
 bxKiMbr+wF1fP/lsvAB1CbGsS3RIGKXMZEWfogpMQpwk8GUzty3MGe0Woiy4b4aWeLup
 vadAf0iMN1b7vBPNoYlKM8RsDbbs4kYfAfvAcoPJAQXi6A6hDgw87tMHHl8B2wpKlydR
 shr1ofPjn603OZmRlS4a80hizgJcdK10MLr/35NUtej3/+1MMgsGtDVxw2DPMMWIEDcx
 bman8nYasbnslpEoan0yJwsZdpiO4pjpb40nFf9dxQUotx36iWCEDr3hE+YZYGT21WYr
 H+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 fh=el/FgNw22YlYRPg8Uu35ML/YaN4N56OVu6KnDSGzO0Q=;
 b=HA869vdInR0v3d4n1H9bttErCaDFssBC+2KVkZKaeQ/7ZE/3UyvnVQuGL1E+G2wZJo
 JGoPse6QuvE/wG9wOvsEYXmQLJ02ZND0lIW0ufRz484edsL8DcUcE0oUR0Qurkz4hBu3
 7forvri8ZNQ99tF7Ic2FooQX09Z7HyzaLavb9q4W0NnLbbULojU04RscRq+bEcx9hFAl
 KT+jj2TaGMPbfCixjV0tvZ9ElIElhcVuhD/LrlfedjKV8QVdwzyiRfUc5mfl+Qah3nJL
 4qlYgaJUQ9QHtA0Y4pyoF+VZujGkOLkTKxG2BYVs7Llm6LGvatqr7UYkh78X5HbR2Sss
 EoUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789507169; x=1790111969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 b=K9lfdrhHL5H8OUuX0jauBSq++j6KJm2i5jGQghvCdy4e15OaiPWWPrXAMvAQ5xRx8N
 TiJYhUmoRYOLYJZ08yM4BriMSPDrTDqNJxWBU9razJ6mqrrDtejEUARiGkcK3RJdR0TS
 bFEM7tJ+bqFgnE1nolYeQgB5jGMTWYJUZfhNTvkI06v89QT+mG2VRl1HNztAFf7H/hxz
 30264Ny7QG8fBhTpXxRfjwuDkvQvzmf55ElPbOAGoNNTRyMvJRlqGoCI3jyIXBVRJvN3
 DNoW8P/LuDGUbp+owAblIP6afdGgxEeNyfP/zZ5JgB3x9GIwTL6VeB05Oua6o2gHyiRm
 X1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789507169; x=1790111969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=27RlSNmJ/rh6QBvW1joFS9tTEzX+MG2zy1HOT3+SmIQ=;
 b=yKODkITNeQ1XJW3bJnxwmKvSQejACePFg4266yRVPetQny4kovVyqPIyrfCuS5fh8c
 0HpeKgwbvPDq5ygOVZr0qQQXEq35DuU3HnvKbv3ipMKONltctrolJPZR2HVXivsdIaJn
 OkixRuHTCuqe9TEv5YrxLhUvkrzGXPPj8jdOOtHBKj1sGhbiZFcwghDcZoqrCAz1klKf
 Umi43G+2QdOURYqQFXGToEWrXhpPrAiSUr6PnjRmm6e0NyGF74PySAn7O3prrtQx69ik
 lEfag1z3XC0mrLujnmmZNx4TanH6tQMO56Aa4pXc0lf2X8fnZL/eu4DZggCiu7afV+go
 p5xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSUICGci9EqRQeLovWK5cNV1CGhIOUhAEbn6Nce2AR+BeKRSSAZfpe0xKCN9GlX2zPTkT641Lz@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhkYrgSSwYL4i+08JHuIu5WzjEie+N4tLXc4yPJrbFkncDL5zK
 f3wJRiTffFH9YWJkoM2Ak0SkijRNe5a8xCCsC6gWeccW5BLagTHeIvT9kYNYmsQ1Nq+0YWPJyYS
 xhG0vkVpd3wvemi3pLitoCedi7L9wlRqk2A==
X-Gm-Gg: AYBFou22PU4/dwkeTM6IRE+jxK2aMvvOjbZeqn++HqNfcbAkHIr3oxlPIOF96fyMdWK
 3JCWvFtrngZ+5D3N95lBqlJp7APFxNqSMPXj7/mfujRVXtEF8iamNnGKU2DB66Yt4qAXuQwM1Uc
 +qES6Hp7DtUO76ulqxH4g0RiVD988aVvROOdl6t2Z6DMw5PwiLIjTFrk5OBZJlofOVm6X4vTpJX
 SpUzZT5Xp4yyIIf1xXD/glQQLb8PY2yrcLrQhU91apsL3s0hY6+qcIwSixr5eG2M0BDXRy94cG7
 kmjM7yYT4Ob5NpjpWVp8WTJIhUpmMGfoVx2pjMfXKB5UdwAUgDss1vBZGj+0IsWEDGX3JOAbLHO
 2BUDIxxlU5bodCRaywMeOd8bb4tQlCEnqFl6ZsOpfmA==
X-Received: by 2002:a17:90b:4d86:b0:39e:fbf:e7b5 with SMTP id
 98e67ed59e1d1-39e1ed3a90emr151963a91.6.1789507168853; Tue, 15 Sep 2026
 14:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <aql0WF8CnlzgS4nz@stanley.mountain>
In-Reply-To: <aql0WF8CnlzgS4nz@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 17:19:17 -0400
X-Gm-Features: AcwNN1UIlmrWYu-j75aUFWIeZN3UW5lDNCOHYA_6wiqw4odajfx7LULhYdnp4hE
Message-ID: <CADnq5_OhB4DVhvyGtQ2yCi12xg5yMUtmT0sRGuU-AxZk2ox0LA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: delete a stray tab
To: Dan Carpenter <error27@gmail.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Kevin Wang <kevin.wang@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

Applied.  Thanks!

On Tue, Sep 15, 2026 at 12:46=E2=80=AFPM Dan Carpenter <error27@gmail.com> =
wrote:
>
> This tab was accidentally added in commit 6c9e0328d1de ("drm/amd/pm:
> refactor PPT limits by controller and power source").  Delete it.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a29e76b03476..6beafabf1306 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -3077,7 +3077,7 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_con=
text *smu,
>                                 return ret;
>                         }
>                 }
> -                       return smu_v13_0_set_ppt_limit(smu, limit_type, l=
imit);
> +               return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
>         } else if (smu->od_enabled) {
>                 ret =3D smu_v13_0_set_ppt_limit(smu, limit_type, msg_limi=
t);
>                 if (ret)
> --
> 2.53.0
>
