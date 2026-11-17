Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZeVZpTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F62310E20F;
	Tue, 17 Nov 2026 15:12:39 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72DF810E20F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:12:33 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4b2b01478d0so195231b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928352; cv=none;
 d=google.com; s=arc-20260327;
 b=fSITypyAFuzXjofzsRHUrD7WDQJUym8Pk+vkuoKfAHH/h3er8krC1XMbdaMQtnk4i9
 9ph/vvLRgXiCPysfxK6CLXBCTt2MhwTuOoLvagY73TxmlHZUIF151dF73M+ZBFEJG4Hr
 QGxI0QbiiCAmGyv7TANGFeE+TLfriBGPKSRcExfqJMEO++/YwuV/9Mbb8qfbhQKKWnho
 Ls9dqUMX14CiH3Bro7fxrJy6WOTTB7SRR+tUHtZoe8VwbiDq77MVsZPDBlmti4ClWQnc
 JUuRplR/lF+R+J7X0lPJkXrd5qHdLFmBwISL1yqDsQizi1b+7NRBNeNsFwsKV4KiL7JV
 icHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XxBKEH1MerCjoO9n5/a74in7TfYlSslctzFoDpb89ZI=;
 fh=ZxvrC6rNjWHvCh5o5yNM8zSSCYAFdK0GMEIYqGOthl0=;
 b=ZAiKdYxzo59UhTM12gIVuQIkUvliBShTS0f5A+aI75C4wGFKxPWVMFCVx2+j+PRE3y
 zD34TT9TpAEp/PX5hg/dejhundcVV7c80pl12CJeduMvdBKc9JYWxEGbbOoPU54FLPP5
 08b15GLDiaTkOF4Lbe1uidRGhVST3ig0ZfWQFHOC2gOhu3tXIW5FVoMmTJTcGOSfYd7s
 Xbvqd9L2zPZz3nkgJtNXQa1AXPsKrnYA50JOcIRJw9KrVRHTm9/3cc90lFyB8sh54uJQ
 H3de6lvion4DqCEIeBE5o0d2fq1RePO59a/cNT8S5WHc15dIxzvewNX7XG7T5rRrbcUh
 BdoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928352; x=1795533152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XxBKEH1MerCjoO9n5/a74in7TfYlSslctzFoDpb89ZI=;
 b=oZeVZpTC5gn98CCLprzC5yhTa+D1knldqgAQeaLU6jXjTi56x8fpNYlRH6jaHX1Fsr
 YMa+C9alLXb0jY5NMIGrRC8W6HKPLA8e1KgW/YM6TGeyiCpu7XSoAv+TMIEnKfVOF470
 1P6QLlvhCZK3McW1kf8Cpu/zeOBwPlQ4S2HasljcEjNDuqgBCszm/OGo4b8wQt0fOF5R
 /LusQOrhqC5s2Ws4/0KzlsjIbaSG5pLcwljNKoceseA7Xb3XCKigkZZLaveP4P/4cThs
 ADLAyIqaUtm67mZr9U787L9qrTQmVFflEHy9rUHKxTUpoilkbftKbQmKQyyq8MEVkYmV
 VZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928352; x=1795533152;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XxBKEH1MerCjoO9n5/a74in7TfYlSslctzFoDpb89ZI=;
 b=237/aIgrKM/Eau/oJ9ZUQE4EuuXXM90PuMJSj7TjDqlE2sZyiiGCO7mjcahICK+d2S
 rpGeVQ+/T58VsbVlBip/0CEmmKfCfnYws9Pmvns9ya/b2xNBJ1yBDxRY2wcEehlyuO0u
 0P2XJ9KUxNRpniGmpg/X1IcIq3j89mm5bSfzzWY3GcuAADm2tlg/TDBfcOTEGXpxsLrz
 H80zB+/p5ziVSHqqnqeZPRz7A8fyMwt5HeREPSFET04SBdCZITAQbY2/sLENIeb9m1cX
 eiGqxFepNnYUzRnJtZ3Qxbf+zDA7lTFpB6NE8C79+SWQYj9ZySVcXDoK2Z+ilUqeqn84
 TXtg==
X-Gm-Message-State: APuU4Z9TlHfkeZTiaEYQeLfHjXobXIwSrRArGqDPUdxS5Ne+gMtIck+T
 yKN/xSUl/vGJ59PlNa4blUNruVgWWTEHZO/S/1qAykd9crb4f+Nwh3mL9cxvMwIoyNQytTkRG3i
 qMUzal+BgrjVnhTbFGYcF3GpnubPH6e6e0731
X-Gm-Gg: AYBFou0GSBRBf9LUNi7PwqID0zu3v/lYvg/X5NUCgMIFxPDOWG+DCv+nwV4L1Ta01rf
 Zsb8SlYPSiFAJN6pYJShNUp+RBGUaoYxnbqYgRZUTsFriAfTGnSp6DiFTH1ISrwhPZXctkv3Ofb
 sNmqqfpyYPEIDSLi9XTEYOBdoCvjwdz4BM3fsyKtkC7cWrTb1zkLdm+H3d/yUZBnA4GD9nMYBpY
 OxYxYtRZj1E8h3wTIbew8bWeyDe/AtOpIpWcYt3KOSbKvrvOkSFnTHMXhUfmaHVLA+YdlMr52VC
 gu7fM69I2uoquJXL1ssxDRM9Mo51gSNph6EOmu6I0GDulHQtZ4HwwMkUYQm4HmuBemml7qMM5Ek
 X+x1d//DduhUTtNn/pqbz5vKzvk/qSZybiUxuEZubFqGZ12UgKBM4Dlh5GfkpRXNwvNcGogTnjD
 2A91xC6pKWeixRrCTQAJeaWzRFAM4Aln78DKoILhu9Xp9Dz4gaMYsCHgpSYtA=
X-Received: by 2002:a05:6808:118a:b0:567:de70:d493 with SMTP id
 5614622812f47-56e66989723mr17904468b6e.5.1794928352530; Tue, 17 Nov 2026
 07:12:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000525.3850296-1-alexander.deucher@amd.com>
 <20261105000525.3850296-2-alexander.deucher@amd.com>
In-Reply-To: <20261105000525.3850296-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:12:20 -0500
X-Gm-Features: AclHuK8P-yTVntT1A6r5OZItsEQ6JaNnMvfjU_Fp5uBMQt2VtzXnnuYR11IUAsw
Message-ID: <CADnq5_P_Q_Mm+=GxBwk_Mk0ztTfDmEXOEP60K1cZKMC8tCxQmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: update table info retrieval from
 discovery binary
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> Update table info retrieval from discovery binary to align with
> discovery table update.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 47 +++++++++++++------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 79a2b1268b23a..351a1e61f525e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -604,18 +604,36 @@ amdgpu_discovery_get_table_info_from_bin(uint8_t *d=
iscovery_bin,
>                                          uint16_t table_id)
>  {
>         struct binary_header *bhdr =3D (struct binary_header *)discovery_=
bin;
> -       struct binary_header_v2 *bhdrv2;
> -
> -       switch (bhdr->version_major) {
> -       case 2:
> -               bhdrv2 =3D (struct binary_header_v2 *)discovery_bin;
> -               return &bhdrv2->table_list[table_id];
> -       case 1:
> +       struct binary_header_v2 *bhdrv2 =3D (struct binary_header_v2 *)di=
scovery_bin;
> +       uint16_t version =3D le16_to_cpu(bhdr->version_major);
> +       uint16_t binary_size =3D le16_to_cpu(bhdr->binary_size);
> +       struct table_info *table_list;
> +       uint16_t num_tables, i;
> +       size_t table_offset;
> +
> +       switch (version) {
>         case 0:
> -               return &bhdr->table_list[table_id];
> +       case 1:
> +               table_list =3D bhdr->table_list;
> +               num_tables =3D ARRAY_SIZE(bhdr->table_list);
> +               break;
> +       case 2:
> +               table_list =3D bhdrv2->table_list;
> +               num_tables =3D le16_to_cpu(bhdrv2->num_tables);
> +               break;
>         default:
>                 return NULL;
>         }
> +
> +       table_offset =3D (uint8_t *)table_list - discovery_bin;
> +       if (table_offset + num_tables * sizeof(*table_list) > binary_size=
)
> +               return NULL;
> +
> +       for (i =3D 0; i < num_tables; i++)
> +               if (le16_to_cpu(table_list[i].table_id) =3D=3D table_id)
> +                       return &table_list[i];
> +
> +       return NULL;
>  }
>
>  static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
> @@ -628,8 +646,8 @@ static int amdgpu_discovery_get_table_info(struct amd=
gpu_device *adev,
>         *info =3D amdgpu_discovery_get_table_info_from_bin(adev->discover=
y.bin,
>                                                          table_id);
>         if (!*info) {
> -               dev_err(adev->dev, "Invalid ip discovery table version %d=
\n",
> -                       bhdr->version_major);
> +               dev_err(adev->dev, "Not found table for header version %d=
 table id %d\n",
> +                       bhdr->version_major, table_id);
>                 return -EINVAL;
>         }
>
> @@ -640,15 +658,16 @@ static int amdgpu_discovery_table_check(struct amdg=
pu_device *adev,
>                                         uint8_t *discovery_bin,
>                                         uint16_t table_id)
>  {
> -       int r, act_val, exp_val, table_size;
> +       int act_val, exp_val, table_size;
>         uint16_t offset, checksum;
>         struct table_info *info;
>         bool check_table =3D true;
>         char *table_name;
>
> -       r =3D amdgpu_discovery_get_table_info(adev, &info, table_id);
> -       if (r)
> -               return r;
> +       info =3D amdgpu_discovery_get_table_info_from_bin(discovery_bin, =
table_id);
> +       if (!info)
> +               return 0;
> +
>         offset =3D le16_to_cpu(info->offset);
>         checksum =3D le16_to_cpu(info->checksum);
>
> --
> 2.56.0
>
