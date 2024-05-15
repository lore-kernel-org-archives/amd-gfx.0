Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F09C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 14:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5A710E9D3;
	Wed, 15 May 2024 14:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLF3Idcl";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E8210E9D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 14:04:40 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2b432be5cc9so5346906a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715781880; x=1716386680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdRcqtfX7Hc1M0ALRaZv4Vws85gX+vinkvLeSY+BNOw=;
 b=HLF3IdclKOlMiTE062W3AlSlinYxmYei0zSBU2QeZ+NuX46p0RYbB0/E9tyGHZu5RF
 klwajqbk+oL28n+pwh0dNGXLvpfaCFJ7dhNTfInXDConYovNEPYy6UWfrGatXIxK14So
 fybLj3Mj6aahAm70VTLWSMpOEDaNtCPKT5mOaRpYW1dnDgkT7qrDzJduD0U+8P2MpDnb
 5gwX6Gxm/DEjEAvmLo9HZgS30HBYfvdBpQsR/zfusU64qalxDRxtLIXrMMrQLHY+ZjP6
 am3IRile+C6ekWONQfrNd5D+kXm8q2BMjKOToiQXREbdsgqepcrbccLPCIRmR7QOQMp/
 U7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715781880; x=1716386680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdRcqtfX7Hc1M0ALRaZv4Vws85gX+vinkvLeSY+BNOw=;
 b=b+rcbvsvNTEbnmZghuZaz4oGK2ZDIcrw7Q/rV/KJEBXx4NLqZbKlE5GA50yxRLr1Jk
 MV7+wHUFl9Bx067LaSi2+xmjjTU1XeKmirPiWPoCQI2t3OUKbYM1QGacNCJmyu9E+CS6
 wa3fA6I76CT2ncXnpa7WKtATXQxGV2Zh7/8wjyDow3UebbD6MXNg5kpWi8qRNnytcJDV
 bRU0boz9jvEDOjml6TrL2O84JKMp5lOOZlZVlggcorgb6y5R52ii0HRjEzeXmzuaf5KS
 kHQGr+WTqrSGjkXMGZlFNqMhP8ZAkPlkAnAExUX+eo2gjmxQo8e6/8pwlw9vdaXLT17A
 sTVQ==
X-Gm-Message-State: AOJu0YwQ3VA7HMEZgn5RDMAbF9Re1YS0TbIGjGf0xWWMdEoVxO6uIg2i
 HjBvGc1m55K4tAVbp80jq4BA6gc7oD8fb2WWKyE2F3UTsRs4kWajpwX6qqj4xt/TPex0JNJaCdA
 pUDYjfNq4pMA1jYA3J3FmtIV3xSg=
X-Google-Smtp-Source: AGHT+IGtX4WPqjnvTQ8c/wgfWEW4WnkeqIksUKGViNlOKdAEbvnUG0Pi1VXdRL2+uC8Z7jbYo3X0ePkA27V5/HdIxNQ=
X-Received: by 2002:a17:90b:1bc6:b0:2b6:22f0:844c with SMTP id
 98e67ed59e1d1-2b6cceef190mr13185065a91.36.1715781879652; Wed, 15 May 2024
 07:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240515094945.3445876-1-likun.gao@amd.com>
 <DM4PR12MB5181173ED2778C6F179E81A6EFEC2@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181173ED2778C6F179E81A6EFEC2@DM4PR12MB5181.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 May 2024 10:04:28 -0400
Message-ID: <CADnq5_MiwDENepuswd5eGKqtQNN5SS3ckwVsXNybxpWJp5A-aQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: disable gpo temporarily
To: "Gao, Likun" <Likun.Gao@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, May 15, 2024 at 7:12=E2=80=AFAM Gao, Likun <Likun.Gao@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Kenneth Feng <kenneth.feng@amd.com>
>
> disable gpo temprarily since it is not ready in fw
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> Reviewed-by: Jack Gui <Jack.Gui@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 0e27cde82193..b594b748de47 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1867,7 +1867,9 @@ static const struct pptable_funcs smu_v14_0_2_ppt_f=
uncs =3D {
>         .set_df_cstate =3D smu_v14_0_2_set_df_cstate,
>         .send_hbm_bad_pages_num =3D smu_v14_0_2_smu_send_bad_mem_page_num=
,
>         .send_hbm_bad_channel_flag =3D smu_v14_0_2_send_bad_mem_channel_f=
lag,
> +#if 0
>         .gpo_control =3D smu_v14_0_gpo_control,
> +#endif
>         .get_ecc_info =3D smu_v14_0_2_get_ecc_info,  };
>
> --
> 2.34.1
>
