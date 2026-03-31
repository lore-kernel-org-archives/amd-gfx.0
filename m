Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F601109B467
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A638310E8C4;
	Tue, 31 Mar 2026 13:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YRxixETP";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B3210E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:46:39 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12a6b260693so619448c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 06:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964799; cv=none;
 d=google.com; s=arc-20240605;
 b=cvyqmIAjdR3cCkmKdfmC7UDe6EryXDD8OS/+m8DUl+t5LiqQBzPw03DfPAXAg0W6O6
 YTQM+Hvr+DBljWUiH9sgPvyPcuWgvMW1MoKGYo8y4TjV+006d7jAieI6ZnBHCqSi4bJo
 VnSkhJsHckHNo1mtY0YgsIEgC7A7u02bMH2DgS5Trt7ND2FFq+uTrCrxKL8/K0v3ecND
 FJwqtJw4pcXTqoZTkGEUUs6JBWpX/Pym9RqMTa9h1phgpb8oMD8ZqlNKw1F6d0ErAjxL
 CEDyn1fA5MfAW9FxFWR9J+Lh+lnn/54qzhr6QOXcQW29Bzlr/8YWg+kLrA+bfEmr+Hyv
 pICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VmGrzCLDAQwYUgYA3K37Po8QFNwyIEj2EJ7TnJkgl/c=;
 fh=+d/d5pB6qaVNK2qpFXE2lQgpEk2ocZHKRdmuzMHqAwY=;
 b=Q5Ia7fFA3u3rg/FySs5EkF/Jn4+VjYesM+xXPxsss2VlN/6xntDI0ZUKGoueGLmyR9
 Ru46JtEnOfq1gwOA9WbY0J3cpmuhAUc8q5l/2/acFxo1koinLf2/tI0f9RMiz1j0ToVQ
 AeYq634TQoI6tdNkzq0NodHLICNmk6kbG3sWDSwli1b9QrKlJ5Ar1chmr1lXrSTp0jZ3
 8hOFVtPs9TiBUPCXthomewHMv+n7vIQ62adClGt+Y0P8MTJLpcEmimmtqKxLKbt1kTrd
 mcBV1+vwzNNELlhbRunxmEdTnI5B9k2I/voiusacb1b88JVKQaoDZNVzv9Zl681YP4wt
 zc4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774964799; x=1775569599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmGrzCLDAQwYUgYA3K37Po8QFNwyIEj2EJ7TnJkgl/c=;
 b=YRxixETP6yazMlq7E/W7/SegwUetw0p6haRCuYMlG8iEl3M68JQfqkV0V9VzgIYkOx
 sjLvlPwj6f6qQDKNTuSEYiMUKZGnKiCc8rpYBxrjeLyt3L2kQVD8BpVy/IDf9Im5jkBf
 YsTpg9uw9+8m5m3W6VHUz/pjuF2Rb3lXDwfOFDUu6AnYHwXdNToeDj/yFX+syHb5fER/
 WuHBCSNVmrPPnZ+l+dBTi4PYzEskepWyCcrLSW0YgwGxZFez0jGVWjZdtn7QYWjOhfIK
 QzlPKrLNTUs4j3Qd2Av/VySUoHHij4DJnxz6+5xSx/ODlW7JQcYlmPATqYlhMOgiq9ui
 mJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774964799; x=1775569599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmGrzCLDAQwYUgYA3K37Po8QFNwyIEj2EJ7TnJkgl/c=;
 b=CyM6Vg4u6bTC14qo9TLMx4tYDN7/f70i9864qD8jLhh2EdLmdpn/OI7RDRLz0PRFnD
 VY5hef4fNKC1N1eP/pQfLAoJQP0BIav1rH6f1lugk3/HLLZ44xAnmJfuITVgGee6Q3go
 oTsOUC27xWzO4CO35BQd6qux9iODgIwled7NyOBMSvv3ZsiVwBqH6WiN8Xv28/Gdv11H
 xtiwZpMdNQxsmlYgiHBwqYJDhtnZISKhtqp9N06nfCvlC0ka5Y1rjcVopRzF1gvxspBE
 zkWNXhuXsFdGp5SvimY5JvubCoKGXBcplEeQ6roo6oaYkeVgQsu+bQG0lAo69UCTC+nt
 A01A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6TPanuTD4kbUcMFoaqxS8+qr9Y2YFHcwctj94KLDPWbvinr0mKfJpXJ11IDREqSqWf6PynwJu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIpjmaMLxJ6JElP99LqoBb5Cuy9GJhuwLlGeimJyqdGr7QuzmV
 Thj2DyRnvugeAtrCmD0nAiR2+ijmCI6fb43+DBiiVPch0t8l8v7E0mY1iF6NEr1yDCsmcdJRP4O
 iU+gdlLzEhD6NkePp973LegRPRej+C80=
X-Gm-Gg: ATEYQzxKQ8beMLcc6RprEteNHRwOUgm6PXLR91BaNOEXgcsuG8DZt8YHDQA+sRqRN0I
 k1hN9GVWVBnvIwzKEZn4cY3etj/5aKn4J2Zv9R2bCgRm+hjy/mEdLN+Fsqk+49EDvVtABYnIe0O
 ivr12qLgfINrXEL8q+cAxLYixThsZAx2u2hLJBxz5unsvi35HclEg7yyYMGIrkKibsxkhksuJ9e
 wKhUWZUYE9+3bipxuiXZwz98GtEN2BCT7F/F7W1ocvWhKdY0gLPCTuZrw96Y9RtuV+391XxU8Qc
 9cvBhINOF8FlBQYF7niFBuiL8Sx4+rRdqD/a6+nl7y3kAPRUCj4HRdA+upjArKf16Kjfa1vQp2t
 npD1e
X-Received: by 2002:a05:7022:f94:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12ab275706dmr4466221c88.0.1774964798572; Tue, 31 Mar 2026
 06:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260331134129.1688799-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260331134129.1688799-1-Kanala.RamalingeswaraReddy@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 09:46:27 -0400
X-Gm-Features: AQROBzAjI5AbfyNT7Jff71J9e2js_gKZP14xwYG7INCB4EfKwJkV1ZMus9Y-P4k
Message-ID: <CADnq5_NCdRSOAYuS29ny5A1TN9qzt0oPG0AtC2TeLDFKJ47P3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and
 lower count.
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Pratik.Vishwakarma@amd.com
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

On Tue, Mar 31, 2026 at 9:41=E2=80=AFAM Ramalingeswara Reddy, Kanala
<Kanala.RamalingeswaraReddy@amd.com> wrote:
>
> Define and use regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0 and
> regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0 for TSC upper and lower count.
>
> Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@a=
md.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 31 +++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index ae39b9e1f7d6..a40479fb00f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -64,6 +64,11 @@
>  #define regPC_CONFIG_CNTL_1            0x194d
>  #define regPC_CONFIG_CNTL_1_BASE_IDX   1
>
> +#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0               0x0030
> +#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0_BASE_IDX      1
> +#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0               0x0031
> +#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0_BASE_IDX      1
> +
>  #define regCP_GFX_MQD_CONTROL_DEFAULT                                   =
          0x00000100
>  #define regCP_GFX_HQD_VMID_DEFAULT                                      =
          0x00000000
>  #define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                            =
          0x00000000
> @@ -5234,11 +5239,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(s=
truct amdgpu_device *adev)
>                 amdgpu_gfx_off_ctrl(adev, true);
>         } else {
>                 preempt_disable();
> -               clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(SMUIO, 0,=
 regGOLDEN_TSC_COUNT_UPPER);
> -               clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, 0, reg=
GOLDEN_TSC_COUNT_LOWER);
> -               clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(SMUIO, =
0, regGOLDEN_TSC_COUNT_UPPER);
> -               if (clock_counter_hi_pre !=3D clock_counter_hi_after)
> -                       clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO=
, 0, regGOLDEN_TSC_COUNT_LOWER);
> +               if (amdgpu_ip_version(adev, SMUIO_HWIP, 0) < IP_VERSION(1=
5, 0, 0)) {
> +                       clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(S=
MUIO, 0,
> +                                       regGOLDEN_TSC_COUNT_UPPER);
> +                       clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO=
, 0,
> +                                       regGOLDEN_TSC_COUNT_LOWER);
> +                       clock_counter_hi_after =3D (uint64_t)RREG32_SOC15=
(SMUIO, 0,
> +                                       regGOLDEN_TSC_COUNT_UPPER);
> +                       if (clock_counter_hi_pre !=3D clock_counter_hi_af=
ter)
> +                               clock_counter_lo =3D (uint64_t)RREG32_SOC=
15(SMUIO, 0,
> +                                               regGOLDEN_TSC_COUNT_LOWER=
);
> +               } else {
> +                       clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(S=
MUIO, 0,
> +                                       regGOLDEN_TSC_COUNT_UPPER_smu_15_=
0_0);
> +                       clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO=
, 0,
> +                                       regGOLDEN_TSC_COUNT_LOWER_smu_15_=
0_0);
> +                       clock_counter_hi_after =3D (uint64_t)RREG32_SOC15=
(SMUIO, 0,
> +                                       regGOLDEN_TSC_COUNT_UPPER_smu_15_=
0_0);
> +                       if (clock_counter_hi_pre !=3D clock_counter_hi_af=
ter)
> +                               clock_counter_lo =3D (uint64_t)RREG32_SOC=
15(SMUIO, 0,
> +                                               regGOLDEN_TSC_COUNT_LOWER=
_smu_15_0_0);
> +               }
>                 preempt_enable();
>         }
>         clock =3D clock_counter_lo | (clock_counter_hi_after << 32ULL);
> --
> 2.53.0
>
