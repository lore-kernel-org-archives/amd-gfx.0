Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7473CC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DA810E311;
	Mon, 14 Apr 2025 17:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+dqLoLa";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7896A10E311
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:24:42 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-30363975406so852092a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744651482; x=1745256282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQf1CzgnkKSl0esukpBiTxnJ28MGal2/6IDbGTXM2WU=;
 b=U+dqLoLaz842t3JgqPDGhQh2h1ZhpMgcgsi0jx+Y1Slxuc1Q6MBit2vREmGExsEZQv
 37Qg6ejbmLNQa2ZleB1S0wy8l4IruZPSFnb/WUdioGWrVS4I/isratOM9SMBdTXthASX
 3JZUv+iM3GE1KnEyLzBDVGQYEafwdzSNvAk158RQ8UzIdQEFMblxr+gDuWo5hkuZO4N4
 f5AnfqI0JnNNTsxv0VeGZxSaa/61TeigByxDitR+qNf5bG2jo+D82j7LwGSOaLxeuBkn
 VHii7uN68kNVkwUn3YsvLDHhob+xElJmggUeoHxAEAxzbAGcdEJUGspElWtjjQbNP1xQ
 DdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744651482; x=1745256282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQf1CzgnkKSl0esukpBiTxnJ28MGal2/6IDbGTXM2WU=;
 b=WP2B9uY6jEaILt3S/bOP3UAXpbOT88X2ZKkqDLQ4wLtl2LSGU1ymeIrBvPr/NMSj3H
 KfRlkYV8sN85+So9/zc+6nGhL8yOCDQPTN4IGfhPp6ImjfOqdAwwU/kjU54idO8vePdb
 YEXL93MsOFkBg0cyGbene3Muzlwzadle9wQrNMO+Egk5L/MvsBOP4aYen9auTsaRkDVC
 eyedSaHIPid+lBdJTg3GPCsBGq0U0Q9Cm3DvdJlKAaTRtxGpygAF7NKw03Ong3ysNyzX
 V8rl5qyLUWCLTxMah+xNLFbSbdxLZb2HNg7g0wMp8bJ5NDTFVhImuACYDPtW0S3WHFtD
 08nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVslinovdy7lUzPlH8BOsV8Vm+KJSdGfAsyYlG9JduQCVL5YKiPtlxTONg67WuTc6eoZlzPbPqD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUDGp3+b6haCqNzOuD8XKk4RbPCgBz+kzuG07SJODPsr6M52xU
 G2bFTmkG5Ea56WBt2uIzZIODcYVTXiOd8RB3htW6RVq98ZtqgAgZKkbg1PfgHJhdPInjuPbyzOJ
 gS64MjBt0YHsx9N3+WxL1sBQ/EyE=
X-Gm-Gg: ASbGncvRI7A3JZ98yR/+81jVESOaGznm3BlZW0/6l6MbuOnsIgeka+Vy3dO4P0GggQI
 mOgGNnfmiY4Glys1y11lzsoIP6AsYMsYa9DMF1Z5u3flyimjmAGZpggenpkHQVNBNs6wn+cwifK
 STFZI3KCVesVP94NmoOZ/IVw==
X-Google-Smtp-Source: AGHT+IEc/FxkOR/lO0tCTfsHAznsxiP3gfsAkAILxKnSNmkKCwhKtkc7SmrCDgFj/w54wm+Uq52kvsxocZ6jSAoZB8Q=
X-Received: by 2002:a17:90b:17c4:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3084e7660a7mr357662a91.5.1744651481655; Mon, 14 Apr 2025
 10:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
 <CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com>
 <7138346b-3063-4b06-8e5a-ec7e42bf21ad@amd.com>
In-Reply-To: <7138346b-3063-4b06-8e5a-ec7e42bf21ad@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 13:24:29 -0400
X-Gm-Features: ATxdqUHzU4gGiPmmtSE2DOo1Gt0YMX0ruc7y4XpIm58RIW6ppK5ZCD6VKQ8upD0
Message-ID: <CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Apr 14, 2025 at 1:17=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 4/14/2025 8:59 PM, Alex Deucher wrote:
>
> On Mon, Apr 14, 2025 at 5:44=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> =
wrote:
>
> This is how i see the future of this code and we can do based on it now i=
tself.
> disable_kq =3D 0, Use kernel queues.
> disable_kq =3D 1, Use User queues.
>
> disable_kq =3D 0 means allow kernel queues and user queues.  disable_kq
> =3D1 means disable kernel queues.  I think we'd want to allow both at
> least on current chips.  I think if we want a general knob for kernel
> and user queues, we should do something like:
> userq:
> -1 auto (whatever we want the default to be per IP)
> 0 disable user queues (kernel queues only where supported)
> 1 enable user queues (user queues and kernel queues)
> 2 enable user queues only (disable kernel queues)
>
> In case of kernel queues we should not be even calling gfx_v11_0_set_user=
q_eop_interrupts at all. Instead its better if we add a this check "if (ade=
v->userq_funcs[AMDGPU_HW_IP_GFX])" before calling the gfx_v11_0_set_userq_e=
op_interrupts. I am assuming there wont be any mixed use of kernel|user que=
ues together. Let me know if you think otherwise. Regards Sunil Khatri
>
> We should only be calling it if user queues are enabled.  I think
> there will definitely be mixed user and kernel queues on current
> hardware as we ramp up on user queues.
>
> Alex, are you saying we could expect some device where Kernel queues and =
user queues will be working in parallel ? If that is the case i can see we =
need eop reference for both the cases and this change then makes perfect se=
nse but,  if its either kernel or user then disable_kq feature check looked=
 better in control.
>

That's the case right now for gfx11 and gfx12 dGPUs.  Even if we did
add an option to disable user queues, everything would still work as
expected with the way things are coded in these patches.  The presence
of the userq function pointers determines whether user queues are
enabled for the IP.  If they are NULL, then we skip the extra
references so the logic works for any combination of user queues and
kernel queues.

Alex

>
> Regards
> Sunil Khatri
>
> Alex
>
> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>
> Regardless of whether we disable kernel queues, we need
> to take an extra reference to the pipe interrupts for
> user queues to make sure they stay enabled in case we
> disable them for kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 7274334ecd6fa..40d3c05326c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>  static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
>        bool enable)
>  {
> - if (adev->gfx.disable_kq) {
> - unsigned int irq_type;
> - int m, p, r;
> + unsigned int irq_type;
> + int m, p, r;
>
> + if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>   for (m =3D 0; m < adev->gfx.me.num_me; m++) {
>   for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>   irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struc=
t amdgpu_device *adev,
>   return r;
>   }
>   }
> + }
>
> + if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>   for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
>   for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>   irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struc=
t amdgpu_device *adev,
>   }
>   }
>   }
> +
>   return 0;
>  }
>
