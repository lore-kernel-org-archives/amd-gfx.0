Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA07C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED0610E5DF;
	Tue, 13 May 2025 19:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2mdEAwY";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C434B10E5DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:30:01 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-22e4d483627so7672295ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747164601; x=1747769401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQL9rKHa6eIxzeKqIx21UjpXmWCgzsrGArP4bKRauLw=;
 b=O2mdEAwYB4Y2EHJzuJ8uY3eWqH/cMcpclQ/FymnxF5nbnkqyyd+Y2h27ihAA7GSJev
 iheqmR5ELrg83mucCwAm797Tp6dy/bXciiGCeZdj0hOJXef5Q8ruHrG1KVfzkBR/7Qg1
 RlOEyp8FaGzCfiWmmv7OqF6phf9BZimO2JCoQpawmzO37ePbQZrb9RVN/xsSVMBrPdg3
 PuSF964PbEaWWm/SMxwFhOkYtpRtaby6W2RgymiW0XhML0LPvHvWG0TY4VtV7l0VJTdy
 avKa/rjnWiH205M83/RRulWoWcP4glP/3oBA/YxAI+1z2PR7lYb+V98zUbwU5EGSIP1T
 UiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747164601; x=1747769401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQL9rKHa6eIxzeKqIx21UjpXmWCgzsrGArP4bKRauLw=;
 b=HakbRQwCNg6fi85hWMeBY3KGo5I9vS72/N1pYr7L3/M2+e9oxePaZKT41DDXcLsW9X
 O8BEws/6bt774BjGEDRrIkaibH1OKCGQCUsSCYO1FJIH3StVjInguegBs7X19NTQjQGb
 V3omXFVOgac5XMAX8wkLTqPshbmM0VAreQfDBy2pnMJ8aMlGKojnxH2LaSmfxpXvYiYV
 jj4XgkR8jXtUkLfJHZ/nXwE8H3ssd1az6cAJLzAteHiFkZ9fnyxtjoIwEO4zrwzqmlnB
 fN55p5AIChDXfhuU4F/HOUUGknGadG6Z1VIe3LLqGvO7DIFPRJAFvQaxdbUUTdAEUTm1
 Q5fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp07rtTcYCAcoYhuB4a0X42JiA3Z3f0Pq+gvDDPVrCz/NPq4c5LlY8Lk8t0PO6NFePNCgDMMIW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTk+X7rp0gVRebY57t9rXTlHZGjgfeASKJ4O71IFtr3qNArJpz
 PRtgosHd7EOIwHFsFcUWUId/Qk8FOtJNMzLi0Cwd/lwcxnHnUXPeK8Zr4Yd+yCdPcl9ob2w/Qr/
 5DwD04PnnqBIQJhvvCzT2mZmPp9+o4A==
X-Gm-Gg: ASbGncuMAML571O1XZDW2DbEaul38LmxIUxYEWWDeJU+mMjcR+2V8MMSNFYWFivJUy+
 o4YeYnsDG4U8ymLJpEiHSKDR4RcTdTL17b55Hm8ETNMs4dBchCGyif3gqtil9n4+S7AvohPnaji
 VqLUgPj+WB7vGl080C84vZnEARlC0DMh2r
X-Google-Smtp-Source: AGHT+IE/pA1QtfPzvEZct91Mz98SwHjsFPrvetyUTTGOeAPSGZXkT8s0j9FnYvzWprIiabysmnuVQtnUqhYfxTVNuZc=
X-Received: by 2002:a17:902:d550:b0:224:88c:9253 with SMTP id
 d9443c01a7336-231980e9eb8mr3643055ad.6.1747164601172; Tue, 13 May 2025
 12:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
 <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
 <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
In-Reply-To: <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 15:29:49 -0400
X-Gm-Features: AX0GCFvOUs83miVGz1beMoRn4vcLpkiPcdcKlqt_dphbo8QzcEeVnGwcBE2xp4M
Message-ID: <CADnq5_M2-3T8thYY-BtDOt_w+rxHFgyuPNCVnwyTY35kwKGsFw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, alexander.deucher@amd.com, leo.liu@amd.com, 
 sonny.jiang@amd.com, ruijing.dong@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Tue, May 13, 2025 at 3:01=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
>
> On 2025-05-13 14:40, Alex Deucher wrote:
>
> On Tue, May 13, 2025 at 2:23=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@=
amd.com> wrote:
>
> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
>     there are read-back calls already. New comments for better understand=
ing.
>
> Similar to the previous changes made for VCN v4.0.5, the addition of
> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> prevent potential race conditions, even though such issues have not
> been observed yet. This change ensures consistency across different
> VCN variants and helps avoid similar issues on newer or closely
> related GPUs. The overhead introduced by this read-back is negligible.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Maybe split this into two patches, one for vcn 4 and one for vcn 5.
> That will make it easier to backport to stable.  What about other
> VCNs?
>
> will split.
>
> This applies to those VCNs where regVCN_RB1_DB_CRTL is used for setting d=
oorbell index, which
>
> means VCN 4 and up - all of them are covered (similar code is already the=
re for those not in this patch).

Sure that prevents the doorbell from getting missed, but what about
other registers setup in the VCN start() functions?  What if some of
those are still pending when the doorbell is rung for other VCNs?

Alex

>
> David
>
> Alex
>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 8fff470bce873..070a2a8cdf6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst, bool indirect)
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
>
> +       /* Keeping one read-back to ensure all register writes are done, =
otherwise
> +        * it may introduce race conditions */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 27dcc6f37a730..77c27a317e4c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst,
>                 ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>                 VCN_RB1_DB_CTRL__EN_MASK);
>
> +       /* Keeping one read-back to ensure all register writes are done, =
otherwise
> +        * it may introduce race conditions */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
