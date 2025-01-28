Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B5C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 15:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603BC10E688;
	Tue, 28 Jan 2025 15:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lcRxOYqG";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2D910E688
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 15:31:38 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so1352659a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738078298; x=1738683098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyrlm48eJ3OtiG2snT4+9nDJbulqIPkyeW2EEptP8Rg=;
 b=lcRxOYqGKJPjziMml/lI8e8nY/WYI3gU6VuUqjG+ETUlpvdomBdoDkUMUY+JiqARPd
 zgOo2OuoY4nVEmVm7moBIr8s891RzbMrHhpU6933fYsRVwRETZ8cYH4jy83sZ8iNNx4l
 mOCAuRca1cFjCvl7TOnf/geoy1NQgLsBmhzOsOPxXMHpfOtvim2xXSSTL5MXD33Wif8M
 P+/SgQ9A8KbZWT3wDsPtUUjp6YfwGi8g8NEWGmpGar+H8KNiqf/v+KsSjr+jg7r/rdqg
 t9r0ZuK9lFFUoosnBkco6i3JwUlK2rz3hzbaiPI4YEzeiYPYA9bAJDmIXq8OwXGh1QRL
 wbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738078298; x=1738683098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyrlm48eJ3OtiG2snT4+9nDJbulqIPkyeW2EEptP8Rg=;
 b=fqozUFj/H7YiOdh9ISs7WEn1vonPWdQe+k4ly/DE8nAr149gXnUIqehNGnwlBPsv/V
 UBjWg93Jh1RqYwae9QXEvqmcoMj1qtH090jRFZd+PJHEf8vBVCLX57G1/F/xXTyenxVg
 cXtjyCjWZuwg6m3/v3pOeuWTxXTF4tq1bkovZS2wVajvT4ZQVNU5mC+DO3hg4darHOok
 OVsYf/Idiwn6d3GOH7F2Az6hpCuEmRt0DCH3Z3k+bxi4CckA3ji/hG4UM4W2cCLE7D4S
 F2WiCXrugNg2P+YkK0isFPXRvAItkgVp/k7yqBXX4UCQpSLLHNe6uWGzRbAbv5wsvjl2
 AOVA==
X-Gm-Message-State: AOJu0YwTohNKBQ2iMDHEKKJznaJzB5/wxK+1XHZa1QnOc17OJ5IwzQMV
 BYEsxOzP4o12DPCPteTqCre1Q22ZNGXTTLXgLUorPY46sREhjfWaqbhhZFLUvWanPKlNZEDUZuO
 0ynVNImLmJnpodMxwAgY75O+8+K4/sA==
X-Gm-Gg: ASbGncv41sn1L2cTCXJYJCXw8H4NqUmYPhFvICwtJJ692eE2Oq+ItKL/SlH15lqWRzQ
 /kl3m/CXnzfEstBqPnCacd+RqdjTWgsvDhqoqa+LtQeG/sB3ub03BRl4RC6buUyJarhaliQmK
X-Google-Smtp-Source: AGHT+IGZzbTUlPTBqFK22Or26dyNAfNFOPlj5k55HyVCQoRwBdGHv2TocPTyso/bZdTslzf2oYZzFa5U9bBup+H+KaE=
X-Received: by 2002:a17:90b:2c84:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f782d3845fmr24205562a91.3.1738078298134; Tue, 28 Jan 2025
 07:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20250128063115.1690375-1-lijo.lazar@amd.com>
 <20250128063115.1690375-2-lijo.lazar@amd.com>
In-Reply-To: <20250128063115.1690375-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2025 10:31:25 -0500
X-Gm-Features: AWEUYZnWmxpVZdfU6CuOD_rurMAT5pcKrm8iUUw8eYApFAK6P1RVchRxt3W8clk
Message-ID: <CADnq5_OCDkEx2tum+=eXZ2wUaYHSdDc_iePZzhr3Zj96y7gb0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Use version to figure out harvest info
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Le.Ma@amd.com
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

On Tue, Jan 28, 2025 at 1:42=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> IP tables with version <=3D2 may use harvest bit. For version 3 and above=
,
> harvest bit is not applicable, instead uses harvest table. Fix the
> logic accordingly.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 27 +++++++++++--------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index d34b97a081d8..e3afdf933dc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -612,7 +612,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(=
struct amdgpu_device *adev,
>         struct binary_header *bhdr;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> -       struct ip_v4 *ip;
> +       struct ip *ip;
>         uint16_t die_offset, ip_offset, num_dies, num_ips;
>         uint16_t hw_id;
>         uint8_t inst;
> @@ -631,13 +631,14 @@ static void amdgpu_discovery_read_harvest_bit_per_i=
p(struct amdgpu_device *adev,
>                 ip_offset =3D die_offset + sizeof(*dhdr);
>
>                 for (j =3D 0; j < num_ips; j++) {
> -                       ip =3D (struct ip_v4 *)(adev->mman.discovery_bin =
+ ip_offset);
> -                       inst =3D ip->instance_number;
> +                       ip =3D (struct ip *)(adev->mman.discovery_bin +
> +                                          ip_offset);
> +                       inst =3D ip->number_instance;
>                         hw_id =3D le16_to_cpu(ip->hw_id);
>                         if (amdgpu_discovery_validate_ip(adev, inst, hw_i=
d))
>                                 goto next_ip;
>
> -                       if (le16_to_cpu(ip->variant) =3D=3D 1) {
> +                       if (le16_to_cpu(ip->harvest) =3D=3D 1) {

ip->harvest is a uint8_t so it doesn't need byte swapping.  Other than
that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>                                 switch (hw_id) {
>                                 case VCN_HWID:
>                                         (*vcn_harvest_count)++;
> @@ -663,10 +664,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip=
(struct amdgpu_device *adev,
>                                 }
>                         }
>  next_ip:
> -                       if (ihdr->base_addr_64_bit)
> -                               ip_offset +=3D struct_size(ip, base_addre=
ss_64, ip->num_base_address);
> -                       else
> -                               ip_offset +=3D struct_size(ip, base_addre=
ss, ip->num_base_address);
> +                       ip_offset +=3D struct_size(ip, base_address,
> +                                                ip->num_base_address);
>                 }
>         }
>  }
> @@ -1474,18 +1473,24 @@ static int amdgpu_discovery_reg_base_init(struct =
amdgpu_device *adev)
>
>  static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>  {
> +       struct ip_discovery_header *ihdr;
> +       struct binary_header *bhdr;
>         int vcn_harvest_count =3D 0;
>         int umc_harvest_count =3D 0;
> +       uint16_t offset, ihdr_ver;
>
> +       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       offset =3D le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
> +       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> +                                             offset);
> +       ihdr_ver =3D le16_to_cpu(ihdr->version);
>         /*
>          * Harvest table does not fit Navi1x and legacy GPUs,
>          * so read harvest bit per IP data structure to set
>          * harvest configuration.
>          */
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
> -           amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 3) =
&&
> -           amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 4) =
&&
> -           amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 5, 0))=
 {
> +           ihdr_ver <=3D 2) {
>                 if ((adev->pdev->device =3D=3D 0x731E &&
>                         (adev->pdev->revision =3D=3D 0xC6 ||
>                          adev->pdev->revision =3D=3D 0xC7)) ||
> --
> 2.25.1
>
