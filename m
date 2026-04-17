Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61607F8DFFF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 17:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B7E10E0D9;
	Fri, 17 Apr 2026 17:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nob5vw2a";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1028F10E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 17:54:52 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2e59d6b11e5so48895eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 10:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776448491; cv=none;
 d=google.com; s=arc-20240605;
 b=QE5xhx4IuiN8InPwhj5d4O0nGGiKGiPafnINm3N3NYoPAcMf4/Ga4AZqSgV0s+O78S
 RmjeBcrXIRVKc55XxE3J/XinPNKNwJrEtZ9+MfmWBP037jxgQ8hiUuig6Wye9j2Z0Alc
 MgDiOw8dvJf2bvNVFjNrl4iTXjvWmOroFX5PJhNDAma0bH6PmcskrLwmfonzC2692M/T
 pT8mj2Jj4I/a3DT1f6V22Q5fqQyPGLeImhkOI0Hdnaq/qiGrR65kkQksfWYG8vKzMTHo
 Ebf1xdjdJrSWFQOtKxNS1PKRU67KjtN9II7JiC7YTRjWk3n25fvjRXfY/m0TPs8ZT8d8
 VY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ODWd0R+7gGwy0u0xVfZ5pMwHEbY1KoY+22G58Ak12XQ=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=bg308tWxziALDN/XAqKLDn0E4H6aXYsX6D9JLfZdBFwf/tg45YWvt9Ku0400sREm+N
 Kr0k75WSr0KdW9ZwPpSKRPB+dBQswIx74Xv7eaZuqti7TU5E/ewGCGEmBHeQrtgrcxza
 YiMcokmbEHkZGMZQYHg+3Y6MlfjL9hqsJZ90dDAJoBP2GZj9fcK+42i5UqHJrEqO3z8C
 g081NN7goUjC4/+gUv9xqPHYJhZGHAshp6dKdLgrYdKFBwLf54FHmcYTDRUycXj/uu/3
 JAu9iCYaU7YoJqrhDuaEc8E/4ZwTOi8E7ojyJM4/PIF+/mmmOwrnocNFWC6LGEQatp2C
 Utdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776448491; x=1777053291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODWd0R+7gGwy0u0xVfZ5pMwHEbY1KoY+22G58Ak12XQ=;
 b=Nob5vw2aL/G0pB/vQ3Cl4cY8ElPsUEt5ebxFy9p3xDWPSVedDMnE1Jn1+pO4/JByyQ
 mSLyvTdmFcJwUwsUy+DtNvZvXGHsBiEcod27Dlfg+B0yBTG3NHU5+Cwt61R4D7wzwefr
 /dyN4cndra4UQI8djMeLt+uOD0Mt4QbFBTlajXLNrrluPgtHXZBUi1kf5PK5Nwu5MJGA
 0jelz7G/nsKRNt5hwrENyGTcm+xKsBMF89I6+QjrX+f/DYhdYUPq7xJfFn+GbrcSlY0C
 pxJnpi6IM6MtAc9eSvymhjqxSdlxALUwfjFDNTD+vFlSsAPjDtakcI1XqYF3GZo7qIJt
 y7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448491; x=1777053291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODWd0R+7gGwy0u0xVfZ5pMwHEbY1KoY+22G58Ak12XQ=;
 b=WPME2UbVPgoS0qLTVv4jF/SY4VcVNjQSv50fLD/R55/3XLu41xrjlVPtcN4buioXeV
 3CfP69NFUrevmFcrnPdSI6GlqtGl6pOLNW9ljBtkDHajzdab1KxZOuL+wrrB4NhZ5RXB
 M7UDexSm5I/NR1/55cMZi5TyoygK2pNb1XUGpez39sUjuXjuRnLOuEJnz53U2fsQTzc/
 yPm0ecjLgh27Dxlv1SCPn0kjlebMSQOWhzcU85HvncYX2IuwNPtD6piBW4QNXlx4klj4
 /+D7RQnBnA0oq3rgP17aLg5Be4dJoMMTrNtO9llTkwwo1A94QnZY+uHzLMj3NdywpCGx
 C07A==
X-Gm-Message-State: AOJu0Yz2m6pxjPTAKBuKjCujmvJ4eehU73O4iELXIwEQm0XDb9ZdQr/U
 8QgCRaPGOgJLEYGITE/HQ+I69f7ydg09I/qP4Y3o/MaTcnLiNIawKhtLuuKdngAQAPle41sXGuG
 5nyoZ2YYBaBiKGIXiXe3Zcb/NueN6jWdU1Q==
X-Gm-Gg: AeBDietQNJdFjGq5xPoYkExlbgbp7CEeDBfb6Skd7pqF2L3E55Qht65zKXFTO5tEj0b
 ctEqMwbSHQzSzHAddbayKGtHrPzbH4iXIVv64jaEfNHjOnx411+6ZtkhU09rhlKvGfAmg2Fy1J6
 oY299RlhAJkohL7v1SNw4ZhMfgFFzrJie43nkZLs5qgLGyu37K9LawiCyWH/rDe3rpvboJJ7aJ4
 l+Q8BdtmdVdf8chUXLXkr7KUJA7ESo+a6UDfMrLjvvNEZIn5qUGMXCNVuBmBT27kzQJwrklk/e2
 FnmMf4JMNbqJzIDof0wGF3Oif+xSfDUW6GGMfBBXKfYaDxXPKNYCypSf4DFV9W7xPl4OfTCrqPN
 1SfkN
X-Received: by 2002:a05:7022:6289:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12c73f98f56mr725319c88.3.1776448490984; Fri, 17 Apr 2026
 10:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-8-alexander.deucher@amd.com>
 <CADnq5_N-b61C4=n_L87J6Pyf_Tv7UCGse317qYzECPtK_OgnZw@mail.gmail.com>
In-Reply-To: <CADnq5_N-b61C4=n_L87J6Pyf_Tv7UCGse317qYzECPtK_OgnZw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 13:54:38 -0400
X-Gm-Features: AQROBzB99e5meANnntZwNvmcgvIfRUqzsu8hv4wV61Y6My2_W_NvweqOpIzoAVA
Message-ID: <CADnq5_N-r_Y=p-n4BM3C_-KouuLkapiNbjYvcEcg2J3j512cXw@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping?

On Fri, Apr 3, 2026 at 10:03=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Wed, Mar 18, 2026 at 10:19=E2=80=AFAM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > Make sure to set the quantum bits in the compute MQD
> > for better fairness across queues of the same priority.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index db49582a211f7..98dc6582b7aa6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -2246,6 +2246,11 @@ static int gfx_v12_1_compute_mqd_init(struct amd=
gpu_device *adev, void *m,
> >         mqd->cp_mqd_stride_size =3D prop->mqd_stride_size ? prop->mqd_s=
tride_size :
> >                 AMDGPU_MQD_SIZE_ALIGN(adev->mqds[AMDGPU_HW_IP_COMPUTE].=
mqd_size);
> >
> > +       tmp =3D REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1)=
;
> > +       mqd->cp_hqd_quantum =3D tmp;
> > +
> >         mqd->cp_hqd_active =3D prop->hqd_active;
> >
> >         return 0;
> > --
> > 2.53.0
> >
