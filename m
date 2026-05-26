Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F17CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9047910E690;
	Tue, 26 May 2026 14:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSemOEIH";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A9C10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:15:33 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f114d129c0so869122eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804933; cv=none;
 d=google.com; s=arc-20240605;
 b=Ohcb7X0vLneSsTXS3MpcNfC75YWEuw7c8BxPryVqQYZpyex06icW7wBpe2LYCkjsNm
 iGYg0O23/TELcyOdq+q8J/YmyXcoat2MNVyFX10+xTq6j+c4dig9k/ZHoK5UBM0KAYbk
 z7tas4/Gd0kHnrqh/n8TwgypTONkNMk/tvt7AwpBcWp/XX54wXvOoLeTBYOYNCZuommz
 uQBIsBBceW+HNwEVhIyZRG2dtVMLl9/TF4QiM+lwAEeMmz+UOKUl+hkb3hArnp3mV+RU
 4pKnVRiZHpHPznyXbXR28OAcOR6cLtJX4iVtw4HMifJcgkQBYMABkIskMiPJvgp94S8P
 VGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 fh=szcvs7nhXeXyLvJP+ZoTdXEyGFS+1mzcTWsKQmKH0nY=;
 b=NGOLbzQxKHPoQmGx5HxKkDrGjOycL66ho+ANIpMIeZKeObsFsXY8RCki+jJBIitNJX
 b8aKFrns484GDjovwWSJGBVkJfCD9t6InfrYY+Od2m3D8TvNpNYTEYnFSQB0YDNEaU/7
 KRnWy9nzFrHLtN08xR163ILVZW+x+Z4NCIhWkVnf7h04nL/FBhS2pF2jHcmqRZW/xF9N
 qRvhbgambbGyr0hdMwOq1FYQafwPaor7b8QCLKFTN2KauZD1FaDj2IwYArXA7Aao7W7U
 iwFpAEBIteX6z3z7aUjuC/5/Ao7FFR9qPSjxFIM7Uo+7jwasav65A/EGddTIC6Uh8bQp
 v+NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779804933; x=1780409733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 b=eSemOEIHzoTsRnZXP/ZWZWTJAh74l09/uX35xQHxYuQyi4z9HUrk3ICx+YrCUhyS5y
 0zjCPAwf8eOv+rGDlKt60E25/pBUwxMz/ZpYniDupM54U4LXa1gaPGnbRc4Ysxkquwo7
 7xZrLZzY9a9GCYH2HFSp/BDnE5+krbgg1TkJOikYuVo9zcf+NCN/xQZFvFNXDK8amVWp
 /bFYHWrKyp2YCvqEoZx+ltixyzXRndDCkHkHdsrrrCEgljLd7O0ws5rlcUB6T0jkW2No
 8qUmOY0ZarOim2yAw2Hsc5GP6vra48/r27TBA/x6svPuALnhyFuPtfUDuPbWtrAHOr6q
 ZVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804933; x=1780409733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 b=XUCB9bsJeHe5NIIqwFoU8/Itqpy7CZf27He+45Hm13dHPTrjAiA0uxtgQ97K+3XjAc
 kMBPHp1DCO4Nrj+HyHJHV0uSPN95cPDRx7YBl7/Flp+uXNEssCNnJGxnIJaKyZ1erFw2
 q3IXQ99lE7Xy7Obg2W3EVPU82rV3avfrFUeDN92C0TW1Y+KNztJdR3SxUogFN+UaSSoQ
 SNbiIzYsb4LzsXod/dajiUTo4Wv5mIbz2lNmp57XTxcfFgcvJiueaVNqmPq+6tgI8VYY
 SOkgmBq4C/jBQHLF/haeXMxpe0aDeb5xeQNgibT3iZtwXoItRTk1PWiY+RrQC4p7VpQX
 aSFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IvGfNPeSHN56uUcz1NnTF5Ml+S2a94gxoIc4nEbViYbAuDYdoIBE3vTNLAJCj80+irrs64q/W@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzgoj2vaInbpIMy4EyoXxBYcNLJJYPq4uSnTZ7HOd3634yy6lWq
 MdXNqsRnz8Oks/QX0Oz8g78kOZtPI2E/46I80OzAQzCsjEnbjWUyUJlEPYJKpqvzIGCkHxMVmlu
 EezwEhTifdSeP4AXs2q7xcUqL5hJ0fU3WPIOK
X-Gm-Gg: Acq92OHPYa24fOoMJ+0Xo2Mqn/JPfEQ/nB/3oMvuMA3cUHVnmvOQSroGRTwm7SVlrdT
 8za4qx3CvJhR//hUmL2zPYywfQ56qHaB8xZZLVRHd2NkFDCzRr6OjfJrROHQwpGdz53zWblI9Sk
 8yOgqRt7I98IUEJvs31ya4cfl7+zdBDbjvrRYBb5y0o/Ox3H7B1u1TrBR1cyNcb/ZWI6oZ9g9wB
 GiD19BF6YyRVI6ETJyakb/UqKz8/aIlZYl+APkGk+s8mJvm1YJnt0v+hpMuF+7j1yUOgilDz5Hx
 Eb6mymW4g9OjfuTmsiaJ4hdMZPgOy7/fzr5oAdVOsXnXDauRYq9pHWAcnu8/p/5fvXehSQ==
X-Received: by 2002:a05:7022:626:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1365fa3ef8bmr2984957c88.3.1779804932490; Tue, 26 May 2026
 07:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
In-Reply-To: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:15:21 -0400
X-Gm-Features: AVHnY4J0ZB2mv1xChxAt83HPpsLFRk-FKZaQO5ikwPX2QY_kbwvz-npmP2bMC6U
Message-ID: <CADnq5_N+GpmKk+1oTLGhahwkCeT8F5Ru-yig7WJYK3XrANXhLA@mail.gmail.com>
Subject: Re: [PATCH] Fix kernel-doc for amdgpu_display_manager
To: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Apr 30, 2026 at 3:49=E2=80=AFAM Kenner de Azevedo dos Santos Mirand=
a
<kenner.linuxdev@gmail.com> wrote:
>
> The struct boot_time_crc_info is not described in amdgpu_display_manager.
>
> Running the `make htmldocs` is showing the following warning :
>
> WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct m=
ember 'boot_time_crc_info' not described in 'amdgpu_display_manager'
>
> i added the description that fix the warning and describe the struct.
>
> The warning is not showing anymore in make htmldocs after change.
>
> Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmai=
l.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..201b4796b591 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -347,6 +347,7 @@ struct hpd_rx_irq_offload_work {
>   * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
>   *                         transfers are done
>   * @delayed_hpd_wq: work queue used to delay DMUB HPD work
> + * @boot_time_crc_info: Stores CRC information collected during boot

This element has kerneldoc within the structure already:

    /**
         * @dm_boot_time_crc_info:
         *
         * Buffer info for the boot time crc.
         */
        struct dm_boot_time_crc_info boot_time_crc_info;

Alex


>   */
>  struct amdgpu_display_manager {
>
> --
> 2.43.0
>
