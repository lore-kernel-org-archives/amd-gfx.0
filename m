Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC81CE7B14
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 13:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFDE10EA5F;
	Fri,  6 Sep 2024 13:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzVThkKH";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6D410EA5F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 13:42:48 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2055548469aso1922895ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725630168; x=1726234968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4CYXxXm5NlDEdw9Fh0ZFV5njTV/KUkdwBPwFbHkk0g=;
 b=OzVThkKHn5KVxTDj0h++UxOy1D7fbttyjR47Ri9caESlLcZBEojnMaAXpbuLhAEzI5
 ZyWeUIkBWbk/RD2wSu2UvYfDK92GAnTo5wbGGAQW8N4tF0e230BCdh+CbAUACeZWnjtr
 B90dafcIMSDQLWD9DY/zb0wMa11u91CHnEJ+Io8qocONkv66ShpNKls7xTqLJeFpZkoa
 es5s5HmjXljDxiotqFICHaPgN2PAoFMkfgRHwClrUEdCPQUuOqe7snkfbz2A2xV0X1Lw
 ztusNpP/pbv0mEwqpGgZMqwxzXbOZPy7YMZV6sU3QbAh87aEMGhW6pkILDwvKdnqEa32
 2hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725630168; x=1726234968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4CYXxXm5NlDEdw9Fh0ZFV5njTV/KUkdwBPwFbHkk0g=;
 b=HlIPnGhAQydmXSGpPlgJhKNd2iw5/MzlnwSLMQX4ZWeehbbo8j7DdObmtR3+beW0UR
 sETvBL3JzvYFaH+SiWfXcBxwVabth5F3HvRJBbVFcc2VY4b1lwBn+3huo00Rmssoy2wW
 PdQy65W4PAOZo2XUsC3bKrX1hJwEZrGetneevEIFCWolagao/chVyYsecVW/yLKaWzAh
 zEQ38rnQAQShQ8mqr+rEV+9VJk+Rh5hb7V40msPDBpjYiPGc/E0SFd5HBF5eToTusZ38
 sPdFe3Q1yUR/tlkvSqEMd6vrZXQP7eiSaeNl0P92pjxs6Ahic50PW0gxu9i2l6gDE/ic
 iKDQ==
X-Gm-Message-State: AOJu0YzBxQAzUbd6xaL56oH9NFiVVwLJ6DYMfTDA38nvNasY0MnY7WT3
 4bDecdLf8D/PIXCaO03OkuH5loDm/g3tJyGmLikDvxn8iNTULtywvPUd7cC3xw+uIx3Z973x1ie
 T6vnTR/MxC7FXGsa6H4OQdCpIoeI=
X-Google-Smtp-Source: AGHT+IEv7n1TJ945IMUTVI7QqY2SBBBv6uGvVmHd5upY13WqgiZtbCaIuCaH8TKgzUx2IwgbBGfFL62snIdEm+p1VOE=
X-Received: by 2002:a17:902:c40c:b0:205:9204:d0be with SMTP id
 d9443c01a7336-206f068a66cmr13773855ad.10.1725630167954; Fri, 06 Sep 2024
 06:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240906125242.263564-1-kenneth.feng@amd.com>
In-Reply-To: <20240906125242.263564-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 09:42:35 -0400
Message-ID: <CADnq5_P2wmTUTQzW5UDWyWwXV2_Mg2i4PTXWDf3X2QHdbHOO8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Fri, Sep 6, 2024 at 8:52=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com> =
wrote:
>
> fix the pp_dpm_pcie issue on smu v14.0.2/3 as below:
> 0: 2.5GT/s, x4 250Mhz
> 1: 8.0GT/s, x4 616Mhz *
> 2: 8.0GT/s, x4 1143Mhz *
> the middle level can be removed since it is always skipped on
> smu v14.0.2/3
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index a31fae5feedf..30f6cf0d9555 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -687,6 +687,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct s=
mu_context *smu)
>                 pcie_table->clk_freq[pcie_table->num_of_link_levels] =3D
>                                         skutable->LclkFreq[link_level];
>                 pcie_table->num_of_link_levels++;
> +
> +               if (link_level =3D=3D 0)
> +                       link_level++;
>         }
>
>         /* dcefclk dpm table setup */
> --
> 2.34.1
>
