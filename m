Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABA8CF256C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 03:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED49810E560;
	Wed, 19 Nov 2025 03:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eBEsyr0n";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FD010E560
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 03:46:06 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-345658375c7so661928a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763523966; x=1764128766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2r6bdbK5vIqHkIR8y7QUJf+ISX/VlEPF3NeE4sJ5EY=;
 b=eBEsyr0nIj5+RgUvCYeBs66E3g+R6RCVeVBU4sQ+4Kxt0HrNdcGhgdlnNE9x+tfefi
 gRteuYyCtCyLSRPc4NwBM88Xojg2goPFmEyuhcYW80TpUTNHK0rVF67xnPeUm51q9b5a
 +YDtV39LEH2SvSvYsCKK13Qtrb9GACp/jMMMPuBBQi2gFJFRwbR57gT7SfdYgKeteH2Y
 drI6VEFClLAfrPToCzjoyHjaL85xriZgtg12JIHKgaGlvljCMi3Ka2i0KwH/00XTc1E7
 1xMJMZ8zvubi0d09FYKbHIaZh0chhUzZkX3/fSw3XwKpZClG/pOF3E9oYVVtma9MtQEs
 2YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763523966; x=1764128766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2r6bdbK5vIqHkIR8y7QUJf+ISX/VlEPF3NeE4sJ5EY=;
 b=ozuZyqj5wqzjjeXPSQpQewdtGMmfCLs8E9WzFlY12ib79DsP3YeyYLnSYVVhuZxY06
 bOrdNJ57vHeGveErPU0KnswuW22/o1CbrPvsyc5ELubyMoV8axaNOfA+aaL5GSDReugV
 jVEvw21c10muNrWsaZlmCU3LspgCuhbBmOXhroY3NAZJkXfKZkJ1j7BUUNjelom5Q2kb
 duH5QrcHeI9CCzJd3OwZED6oLluV2oUUV9oLy2qcHcPLZZgqe3z4togFdcZPcfcG959s
 O+xEfCP1dkNUD9Rn6zenUb38UpZwfZNjWzMXwP8uuqQQNiO5ko86i0I1DUmpa9TkY2BH
 APwQ==
X-Gm-Message-State: AOJu0YxxPKxTsbdLjk36CEuHGakDY0kLmE4f1KLuLRBCFt5N+dd9GkPW
 iyp42lc9SXy6JsoiLuFdewMFtwFsrGRfj5I6N8u27Aws7Tjp5oIYFEHozva0ilbsXB+XIM03gK0
 haKxxtj6aEG/jogaOC3tF0tZsGVQhTjQ=
X-Gm-Gg: ASbGnctw2v3hiOnXO2yxlHgE06mcjJY/w/azYRU/Ckutj3GEPpRWbCmj/uSlkGgvYes
 GpXPflLnnMUdyaICQJbXLnomayCe0Qi7dzzbXoP+CZzoJb9RrHU4j1augBdz1kblrmRlfFUbjYn
 2WTjgbx/Z4cRZ/sI32OTWWT4+ByG45Rp0g+gVOa78S9qGAaQPznV8sG3tMtSHtN7CKQz54IZ+7h
 boHwfczilL9OyV9zHHDai0ATBhL4DujeRFi5ZbBrcz2JWYuqZ0lb6KccBSHW6ui/0wDAtOIMqQ8
 LKoGPZSg0AQ7qI+b
X-Google-Smtp-Source: AGHT+IFabIF2tAB/FgEf268lNNOgBJbOLCSI08Vh2ZYofxEL3N3kV7zJ5MwjJYQiKd/qu7pqq2bX/oSIqIzv+C1Mlsw=
X-Received: by 2002:a05:7022:ea46:10b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11c7966cf23mr1509711c88.3.1763523965996; Tue, 18 Nov 2025
 19:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20251119025927.1813858-1-kevinyang.wang@amd.com>
In-Reply-To: <20251119025927.1813858-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Nov 2025 22:45:54 -0500
X-Gm-Features: AWmQ_bl-ARIrVY1GCay6VieJcBnLel6al5hHA9JtYKMfyGKCWo0uS_AFX9m8b4g
Message-ID: <CADnq5_N8Gid+=Q29mwNDW9Qx771qPnoKxPocL=NZ_vDKf0ZJzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced on
 smu v11.0
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, 
 alexander.deucher@amd.com, candice.li@amd.com
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

On Tue, Nov 18, 2025 at 9:59=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> fix amdgpu_irq enabled counter unbalanced issue on smu_v11_0_disable_ther=
mal_alert.
>
> [  357.773144] ------------[ cut here ]------------
> [  357.773156] WARNING: CPU: 21 PID: 2202 at drivers/gpu/drm/amd/amdgpu/a=
mdgpu_irq.c:639 amdgpu_irq_put+0xd8/0xf0 [amdgpu]
> ...
> [  357.774651] Tainted: [E]=3DUNSIGNED_MODULE
> [  357.774656] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS F14a=
 08/14/2020
> [  357.774664] RIP: 0010:amdgpu_irq_put+0xd8/0xf0 [amdgpu]
> [  357.775563] Code: 31 f6 31 ff e9 f9 c3 4f cb 44 89 f2 4c 89 e6 4c 89 e=
f e8 db fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 d8 c3 4f cb <=
0f> 0b eb c3 b8 fe ff ff ff eb 97 e9 d3 8d 8b 00 0f 1f 84 00 00 00
> [  357.775573] RSP: 0018:ffffd28616ecba58 EFLAGS: 00010246
> [  357.775584] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000000
> [  357.775592] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  357.775598] RBP: ffffd28616ecba78 R08: 0000000000000000 R09: 000000000=
0000000
> [  357.775605] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8aac2=
01a8008
> [  357.775611] R13: ffff8aac0e600000 R14: 0000000000000000 R15: ffff8aac2=
01a8000
> [  357.775618] FS:  0000751c697b7c40(0000) GS:ffff8acb4fba2000(0000) knlG=
S:0000000000000000
> [  357.775627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  357.775634] CR2: 00005a844a5e7028 CR3: 0000001039a0f000 CR4: 000000000=
03506f0
> [  357.775642] Call Trace:
> [  357.775649]  <TASK>
> [  357.775663]  smu_v11_0_disable_thermal_alert+0x17/0x30 [amdgpu]
> [  357.776704]  smu_smc_hw_cleanup+0x79/0x500 [amdgpu]
> [  357.777857]  smu_hw_fini+0x139/0x200 [amdgpu]
> [  357.778908]  amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
> [  357.779698]  amdgpu_device_fini_hw+0x2e5/0x560 [amdgpu]
> [  357.780487]  ? blocking_notifier_chain_unregister+0x3e/0x70
> [  357.780511]  amdgpu_driver_unload_kms+0x4b/0x70 [amdgpu]
> [  357.781334]  amdgpu_pci_remove+0x50/0x90 [amdgpu]
> [  357.782126]  pci_device_remove+0x41/0xc0
> [  357.782145]  device_remove+0x46/0x80
> [  357.782159]  device_release_driver_internal+0x203/0x270
> [  357.782169]  ? srso_return_thunk+0x5/0x5f
> [  357.782189]  driver_detach+0x4a/0xa0
> [  357.782201]  bus_remove_driver+0x83/0x110
> [  357.782216]  driver_unregister+0x31/0x60
> [  357.782227]  pci_unregister_driver+0x40/0x90
> [  357.782244]  amdgpu_exit+0x15/0x3b [amdgpu]
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 78e4186d06cc..24d9f576846b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1022,7 +1022,12 @@ int smu_v11_0_enable_thermal_alert(struct smu_cont=
ext *smu)
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
>  {
> -       return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
> +       int ret =3D 0;
> +
> +       if (smu->smu_table.thermal_controller_type)
> +               ret =3D amdgpu_irq_get(smu->adev, &smu->irq_source, 0);

Shouldn't this be amdgpu_irq_put()?  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
> +       return ret;
>  }
>
>  static uint16_t convert_to_vddc(uint8_t vid)
> --
> 2.34.1
>
