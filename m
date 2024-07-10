Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06671C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 13:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFF410E7C9;
	Wed, 10 Jul 2024 13:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KeMwsmAw";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5A110E7C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 13:44:15 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso3734533a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720619054; x=1721223854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jChNdLaiBcupPG5WhK/GSRQVKUinf8MI7EUAt4O3o9U=;
 b=KeMwsmAwUlgPcg78EwAPrcNK9/um65DakO36Ti1TXWfKZAA7JdtcxF0yZBbMjWbJFY
 P24SMeqi2rxizOJT3T4OStbAf8wUT/1w//uAuh1XlhkeyYBmJMWUrFrb2Ch4mvHLu1C7
 Hutr3dq3fi6d84ym2czPiOeIcIu9KDoZNiVnZkbElRQSiq+nFSqYn1lq5xku/t0pfcv8
 3k1E18dPC/izUzakeF3Gq+Fc1VqfY2gWfQQORATlmHd1mvr2GQsquBlfy2/ov/G6N6pV
 ocFSXjzK92rdAsdUhVApnn/iAo2XrqFeUj6RzefQfUjPdfM1ME/ry+VPwqdlQPvalGuj
 MgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720619054; x=1721223854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jChNdLaiBcupPG5WhK/GSRQVKUinf8MI7EUAt4O3o9U=;
 b=lqk8L9AshFQ7tmhSZdvUOFPn/5RFn6VC0o7fz5+dHP7V/5y0xYBp1KLho8TKbNmLcQ
 9fBrGDxd8o8k6dbl06Dv5/3UZzZ6ZQpijvl58ZyeJ+vLoSQEWYz6mSs+frf0xPSVZh9A
 Aly0mOzn6SgWPixz7yAU+b3CJXO4qU+57qKA2guFO54N7n9uply80CTAgt0gDAu1lLOH
 NyXd2sHrpnAnRhNHEEFMn8KkIifYvo9EdUFT+KMjxS9soRrnAW+liN2WtDhk457MJajh
 /Uc4yAomP8Q6nFSEnaCKhFkIsWME+z2MqrjVUDNCTz+RRltVSsyNJD543eVGG2B+lp7r
 H3Vg==
X-Gm-Message-State: AOJu0YxRCE5eyIILfxcNkXks0jjGlMA4dG1SZ7gUHxLZgDfIrJ5AB8i0
 MLl/vJdNYL9xD1VmNxjk32Zf9MraJDfVKV1q77oH8LuuSnPjBw5W6zWMkxMGCiDZGZBMgjc2QPn
 Gg5z3Xxw/UfV6Jt7oZAWZuf1ert6MjA==
X-Google-Smtp-Source: AGHT+IESd0C4b2TxVtVFZx/vSDwzsvdu5+MYRP1vX3b6s24+HNXTJ7xbGxxZmwVIc45dY7zURPs3SuT+newjokCxxBk=
X-Received: by 2002:a05:6a21:9997:b0:1c0:f288:4903 with SMTP id
 adf61e73a8af0-1c2982232b7mr6728664637.17.1720619054268; Wed, 10 Jul 2024
 06:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240708215041.529979-1-alexander.deucher@amd.com>
 <20240708215041.529979-2-alexander.deucher@amd.com>
In-Reply-To: <20240708215041.529979-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Jul 2024 09:44:02 -0400
Message-ID: <CADnq5_PqBm9Nue1Lc-wR4XmccoeDKjQcH8TKxui2BVFT+CvPSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
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

Ping on this series?

Alex

On Mon, Jul 8, 2024 at 6:30=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Fixes the indexing of the string array.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 106eef1ff5cc..c9f74231ad59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -99,6 +99,7 @@ static const char *mes_v12_0_opcodes[] =3D {
>         "SET_LOG_BUFFER",
>         "CHANGE_GANG_PRORITY",
>         "QUERY_SCHEDULER_STATUS",
> +       "unused",
>         "SET_DEBUG_VMID",
>         "MISC",
>         "UPDATE_ROOT_PAGE_TABLE",
> --
> 2.45.2
>
