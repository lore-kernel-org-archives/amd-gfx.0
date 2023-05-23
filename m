Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B65C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 13:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F4610E091;
	Tue, 23 May 2023 13:48:13 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD0610E091
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 13:48:11 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6af6db17a27so1304114a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684849689; x=1687441689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bv/qj1dyuBXH/X+QBITKQLKMKN/siH6lihCzwWMM8yY=;
 b=fkz5ZO0g6UZf27Cdb9uOeqPFMpktXIJg6j8djXibNal3dH4wKBvPl6EpUMw0YIZ3yV
 wCzlmRu8tZSClrg1TkO8pcKh+bWAomyoDl18i4z7e8TVe/gEB2VRHNwInlfJYCECNgJk
 x+1Q9fSlN7Ea4nVgr36HB6+cq21y8E+qRJOkH9GKJ3HC2g8WE3ZTFEhBCJW+67RbIZan
 jZ1Fbya6d0tnSRK3lJN7yinhDqSOxT58bJ6ZqcIHe2baZFA8wK6tkV4RAaA9qqwrRxdL
 PO2wsrXZtz7jq4MkD+RhEapIYuoZ7/T7RLzYlnfTm/rZz/2a2filoqRzQ+TPV47C7Qqs
 L3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849689; x=1687441689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bv/qj1dyuBXH/X+QBITKQLKMKN/siH6lihCzwWMM8yY=;
 b=CMyl+RKBot6W7bEvL3rDbZjN0Luqn203rp6E5jxFAIpIcu1CLEARcrd6ZqK4lMVjDI
 3hKSftpPW6ld/HlqFOUmZhLJWw1qFGGNBIi7k9TM1sCOsH8rrCtOru0UwDS4aL2eJVcU
 Mn3W7wu8R5JwdzfwybnolH+wkLT8tmpkOh1ghcAE4x1KCm+CgGz0aVs1TIlxttLmuO5V
 HxcAQbyHNl/km34y04YCq3TM9FN7WtC/a/laqKdFXy5rRQPyVf16zm7SVWfqsMDFFBsd
 nURI/TzN3W81dZE23Q5GN8VgJxCYB9VvO5x6AvRLLZkxxY6Fkzg6IIiledhf12cptm6Y
 97kw==
X-Gm-Message-State: AC+VfDw56LTB03aKE8rmfcr8xfV2/eROjstvyF1Oez5lfzvXgpHT5AOW
 E1SaNZmtclqBm9cUUdWsJ9uXD8VsXBn1zRXpx7onijro
X-Google-Smtp-Source: ACHHUZ6Mgpq5fJZ2vimcnINI175R854b2ncRESS2UcAfLkK/DVisFn8HbdPOO5P61PTuFLc6bDTkLrWMe1nyP6QTlm4=
X-Received: by 2002:a54:4095:0:b0:398:581:aec8 with SMTP id
 i21-20020a544095000000b003980581aec8mr4045707oii.52.1684849688800; Tue, 23
 May 2023 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230523101712.1134980-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230523101712.1134980-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 09:47:57 -0400
Message-ID: <CADnq5_M3z9Y6-W_vhh3d9ZscPK03e2rAijTeR1-56GxXkbmNkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_acpi_get_node_id &
 amdgpu_acpi_get_dev functions as static
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 23, 2023 at 6:17=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Below two functions cause a warning because they lack a prototype:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:904:13: warning: no previous pro=
totype for =E2=80=98amdgpu_acpi_get_node_id=E2=80=99 [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:930:30: warning: no previous pro=
totype for =E2=80=98amdgpu_acpi_get_dev=E2=80=99 [-Wmissing-prototypes]
>
> There are no callers from other files, so just mark them as 'static'.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Arnd sent a similar patch yesterday.  Already queued up.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 1a66febf6981..82653f8496bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -901,8 +901,8 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_=
info(uint32_t pxm)
>   *
>   * Returns ACPI STATUS OK with Node ID on success or the corresponding f=
ailure reason
>   */
> -acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
> -                                   struct amdgpu_numa_info **numa_info)
> +static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
> +                                          struct amdgpu_numa_info **numa=
_info)
>  {
>  #ifdef CONFIG_ACPI_NUMA
>         u64 pxm;
> @@ -927,7 +927,7 @@ acpi_status amdgpu_acpi_get_node_id(acpi_handle handl=
e,
>  #endif
>  }
>
> -struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
> +static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
>  {
>         struct amdgpu_acpi_dev_info *acpi_dev;
>
> --
> 2.25.1
>
