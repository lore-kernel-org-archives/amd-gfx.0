Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090B606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuP/Ro94
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C8610E65D;
	Mon, 19 Oct 2026 21:33:29 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A11E10E65D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 21:33:23 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-15943c9be84so141627c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445603; cv=none;
 d=google.com; s=arc-20260327;
 b=Cx8TEIsr1K2ys398qsl5SiQv8zVAvic1IfNX4XZuOYs4nPRnGTBZzcg78jS99cdq9q
 81T6OZYndsg0VtKyNNWkM+LM97nF4FASSEfOhYByvn9Tg6BAfzRoGg+R4nIBl9jpomFw
 EMlNcnGA+A4HJ0fcHvFEOOOkJS02E1AETnAkSGsjht0TjiJdIBVoCEdZdPAGet1kwllh
 054KZruXqLS7zY1OhEB6fy3USS1UFKEtIvP0tsxdzIrsUJbybABcoIGCkyTvA+HA/OTN
 96fyhrX+vf/d/ypDyiJrkr3LBTGGgqPqlIUnmnKPC/194w8dgbDgN1u1UtRmX6T1eMd2
 47tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 fh=sD+YEeB28b/bC+Caee9KqRT80m8zu33TvuN51pwGMNo=;
 b=rE8ceQ3vGoFERtQGFKJOBwH6k3gjXANA22WqdNZQIIJE5LqpWtPvMinb2jMjck5Ugv
 tIw0KaKZ/TnHpFIZVysiJJzV8liOTvOBHmcU2ZXLwI1ZPdKUQuBuXOe1E/mUlqY8Xu3s
 pIxJ9S9Ew+KBcgsgwYDBZ6FncKorei8h+j3VBgsHuVHBBT+YL7vbE3nIOgUPoWokr/b2
 IrokPoe8xABtWihJtqsDC96aeMPi5T2BsSEtKJkw0LulPv+2wRONLpQsCbZreBvn2CDn
 Vt54fRNWIbZ4HzVvPl30AQPZRtlHNMnqYpJNSKNrsS9JsPXXgaBBcRgA99k/KUIRE80u
 TPQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792445603; x=1793050403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 b=MuP/Ro94aSNRREI0ASAM9ZO9rftym+kndRJvaPffFF6yiJtEVouMN3MPUxuTvWcTUU
 gaq+yulYrQXRqOqQWrUY3bQGWIjgCTBPunsJ2P2NnU9onGmD90/v5mF66hejlvO+ID8s
 ESSM2LERJ8OenAUP7e1ZgLdjv5s4wo13AvewyasWW8UjXiHBSHmwq+sPtPcQPG+iAWHc
 Z0Pwv2K6bXBKnUFhxS7cIfIXfXyI+qdvZ4sKsIkwfSA+pceKl1FiIDohm9NydglcDoRN
 D3AbgclC/KfCdfXwTv9lftPWvlv4Czrhb/J2sxjFseS32gmfFI0Ar/DAA4tcz5a3PvdM
 NPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445603; x=1793050403;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 b=M2yh8OASutsOcD+BgO0rYHL/AUG3++Jgzmob1gmG18CHlmH1C2bMRpnpqyx6eORXAb
 1o3I/1pjln5h7t+mHDzqx9SFmdhvLds4JCghnES9Ha6QgvSGZVeGnBUOpw/4SjhrgUwP
 gJ78y+mKgKgOoGHqVwHkvXkeuE/V60LWKs4Ou3RYvkE7kBiM0RQO3YB1RgcGjt1yhgtn
 XqAXKzj3Gm+y3tGvcjk9FKL9M3sdVz4IynAdAOX79jdRkyGcZU2jYRao0vn01DvuYxSX
 xVBi+iLyxzqL1CvjEXA3M1eXitOs+k1LlC5wJ/st1GYqyMipzfgFsuLw6RLjyJ85+hZG
 BQjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3r5tT+CZWuNdR6sQ3ub6DJXFCQBLU2L/EbeR1PadIxQjzBlvSTS4lzwBNNuLuTCoZUP3NmbKQ@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKi45WRCIhuvo/iIRTYHeIvurNo0NJuldV+9NKdwlkZDbeqQMGV
 Sv+Ga0qxIsoZQvUmzg4Oe4G6ULXvhFPx1rbnTqM3Lt72Hh8DkbCYYDHp+kLYs+pHUj26ErWDhYp
 UJz2SCTf2YCwpDHXlf47Hp5fBCYS3sbE=
X-Gm-Gg: AYBFou3HUlVcfipFl/Te3MQLcWW0YQ0rAaRG5/+Zr3g7NcND6POaEzeeOXclyZR8+0s
 Lf+lHmTMgU0wyW1hUJckU6CMtHLRRY8x+kgFtcpc0I7YDf1n8w0NHAiTzB/IM8EwkB+v8tjzXWj
 wreGKqUkpHYlu51g71oF9JAzTpJsEbRxdFVErNfoXebX9lRLWC9ezJxGd0WDUvf07B24L6m+2Pn
 l968ma+Hm5p5zc2z13nMgziOln64W8cfZBEtXaxkjnKOkY69PfYBjTCYid86ISvO52+opKXCKqM
 Q0LmTpb+EOmmG7zHpRfC4fPTWzL2pIvocelQMn3BdOXoDN5tJ/FuBJ499SzBhPsHl6wwfje1MQ+
 /IH0wnBd0LvYq7FpibFMvhyz7Kx5ucZtbegjA+O1B5A==
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id
 a92af1059eb24-18511adbd46mr19516085c88.2.1792445602643; Mon, 19 Oct 2026
 14:33:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016141504.2794541-1-yaojiale02@163.com>
In-Reply-To: <20261016141504.2794541-1-yaojiale02@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 17:33:10 -0400
X-Gm-Features: AclHuK_Me7TacYeo4mJbcJaHVL-oGV4AZjveGBSsw30ka30ykjikfca5QZHE9gM
Message-ID: <CADnq5_OneLPoTnDtowe2zVfLwN3_NZ3uFefNOw5itRKi6HivvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: validate SRAT subtables before parsing
To: Jiale Yao <yaojiale02@163.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 2:26=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> The KFD SRAT walker reads the first subtable length without checking
> that a header is present and trusts subsequent lengths when accessing
> CPU and generic affinity records. Invalid firmware lengths can therefore
> cause out-of-bounds reads.
>
> Validate the table header, every generic subtable range, and each
> supported typed record before reading its fields.
>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 35 ++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index 6e0df685503d..32d7573dffc9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2056,27 +2056,33 @@ static void kfd_find_numa_node_in_srat(struct kfd=
_node *kdev)
>                 return;
>         }
>
> +       if (table_header->length < sizeof(struct acpi_table_srat))
> +               goto invalid_srat;
> +
>         table_end =3D (unsigned long)table_header + table_header->length;
>
>         /* Parse all entries looking for a match. */
>         sub_header =3D (struct acpi_subtable_header *)
>                         ((unsigned long)table_header +
>                         sizeof(struct acpi_table_srat));
> -       subtable_len =3D sub_header->length;
>
> -       while (((unsigned long)sub_header) + subtable_len  < table_end) {
> -               /*
> -                * If length is 0, break from this loop to avoid
> -                * infinite loop.
> -                */
> -               if (subtable_len =3D=3D 0) {
> -                       pr_err("SRAT invalid zero length\n");
> -                       break;
> -               }
> +       while ((unsigned long)sub_header < table_end) {
> +               unsigned long start =3D (unsigned long)sub_header;
> +
> +               if (table_end - start < sizeof(*sub_header))
> +                       goto invalid_srat;
> +
> +               subtable_len =3D sub_header->length;
> +               if (subtable_len < sizeof(*sub_header) ||
> +                   subtable_len > table_end - start)
> +                       goto invalid_srat;
>
>                 switch (sub_header->type) {
>                 case ACPI_SRAT_TYPE_CPU_AFFINITY:
>                         cpu =3D (struct acpi_srat_cpu_affinity *)sub_head=
er;
> +                       if (subtable_len < sizeof(*cpu))
> +                               goto invalid_srat;
> +
>                         pxm =3D *((u32 *)cpu->proximity_domain_hi) << 8 |
>                                         cpu->proximity_domain_lo;
>                         if (pxm > max_pxm)
> @@ -2084,6 +2090,9 @@ static void kfd_find_numa_node_in_srat(struct kfd_n=
ode *kdev)
>                         break;
>                 case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
>                         gpu =3D (struct acpi_srat_generic_affinity *)sub_=
header;
> +                       if (subtable_len < sizeof(*gpu))
> +                               goto invalid_srat;
> +
>                         bdf =3D *((u16 *)(&gpu->device_handle[0])) << 16 =
|
>                                         *((u16 *)(&gpu->device_handle[2])=
);
>                         if (bdf =3D=3D pci_id) {
> @@ -2100,9 +2109,13 @@ static void kfd_find_numa_node_in_srat(struct kfd_=
node *kdev)
>
>                 sub_header =3D (struct acpi_subtable_header *)
>                                 ((unsigned long)sub_header + subtable_len=
);
> -               subtable_len =3D sub_header->length;
>         }
>
> +       goto out;
> +
> +invalid_srat:
> +       pr_err("SRAT contains an invalid subtable\n");
> +out:
>         acpi_put_table(table_header);
>
>         /* Workaround bad cpu-gpu binding case */
> --
> 2.34.1
>
