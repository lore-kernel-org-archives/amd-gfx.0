Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C51CD98ED
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 20:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD3810EB32;
	Wed, 17 Jun 2026 20:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ClUr2lnc";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230A910EB32
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 20:46:22 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-13835f3db17so3425c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 13:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781729181; cv=none;
 d=google.com; s=arc-20240605;
 b=ND9lvvbawwGyQPX5i/kQwS45G/x1J9gaHJn1tfAQCp2SZYBtmm8PhxCaqfbgTh7xv8
 4IehNGZmIWp2NToBJavWpLSqN5hpQjg+Hn8PyE7Ahs1/O8ZhJQ8kGcMBgYoPNTfFg+kK
 bNWNP34sVrrX69Ca4Sa4Ju4y5JoNyu7nOz+EaVp1BvD8osIQ4FAVn8+H5RTixSd3OpF1
 GOKZQIZXC0CbMijVhOUJVrznYC4e4k/hO11hCjk+TbULnSqIT9+eTf79wq71Z7yuaOYz
 a//qc0fxKqefHdiGM6955P0YTiFodQ2ISSAuPh6UiU3VaEaXiOkZEjFCPUZfuWdZEl9n
 Z1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HGrM/69cCWHfeWLxXnSQbS6U28/SYZASxOX71TiVmwk=;
 fh=YFqqTxdR3R9j06ZYM4qB+o3OGNiDDAN5wTvPWvcIcoo=;
 b=LwupvoQhGNVWYLCTocb1UIlh5ZyuR59NwySfWTeUIB1SumBEMHADbG39u0LkgxD+2y
 yHX4UA7X4jFsGDykUEtKwojXVzlR5LKaQ/mtBjhRO5NjGMxeZxkxojHDb/5IkO4PJIDo
 eUCjKodQ/rrjEJxo3EBL6CFmd6QgfqHcce803VFR3PsVUa10ZnJW03U88KAwcmu8N3G9
 xpBfDDEB7ydrajiR1r0bVvarFyxNF2D9xLnaXSQ0Vjsi7VWTzqJ/1wh6y9WIIYyPdpBu
 2BFPMeLWBxH5g0PT7e+gifAP3WVSIp9PUNZsUgbbzQ+COy5yj2mS8cwmqDzSw/SXSnqI
 r6Ng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781729181; x=1782333981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGrM/69cCWHfeWLxXnSQbS6U28/SYZASxOX71TiVmwk=;
 b=ClUr2lncNKc1r5QWMA9w2r72DWf719rszfsqyzvG00g/DxI/8RAmgr56wVtmXUAe0x
 QaqsuFTJpwp8Z2PpGcQSnFMoOVa4EAnSwaVD38gQoO7n2RZ1AyI6Cy00hVmDlKYSKnn3
 OAbdD8ie0fXHxfGVTrFv3pDC2ItDq97xsNSe7C3DZgBhk3V8AZmalmNumMu0zQzaA+TO
 9AYHjHPqN4cUx0wJYkWkfzGW18bjFk3lSUPCGS787kHaNLZxmeOMPrQj2se9b2c9crIj
 ZvqV7XcQBVPM++mD5VSe8BKFqhPb3I9dBhH/ll39SGTndLMYJOQtsheyrbDLyeMReqsG
 Ca4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781729181; x=1782333981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HGrM/69cCWHfeWLxXnSQbS6U28/SYZASxOX71TiVmwk=;
 b=o5m0VxoFXYDQHloXJcVmyWbQsSrySpAPypz+i5D/5qagkJ1vydaO3LsUn5BlRfWajw
 8HeEpGPH+JllqCgGGtCPLr3Sv08PPSSYwDhFzewU9fVG6h3a5CN3RjmL8UHboek/ylvn
 g/DJ0NK8Pm1maypnDkNrYg91zxdFVIsh8ZL3Br5g2orMknR6OHfQnep4aten9Tz42HOO
 MQdd3TGhPYjHzW/ktDJLfprMsSFahtlMivj3qxHOZ0XVbhM3OmlvCR0KEuuNAMYVT21l
 2D6VTkfSisMBaZ4vr2hNDkGXZ61p5LrDOGOiK+/fVxS427oy2U1dR2VFAfPmg83uh96r
 mYFA==
X-Gm-Message-State: AOJu0YyucCnxsS+XRkxuTCQ5d5FDKsCnLUn5igqQTCFz5fVXw5oWn4/+
 nPlULQXgbnUcVlneZeT+s/t6vxP7d3ChWaFO65W9jDxLGocxYaS6HTmMCC4mUGZUKb/IhrffD2Q
 tVq49VWlgRJWmIbFPpAjNEUyb/CbYAFQ=
X-Gm-Gg: Acq92OGVV7sqVgGHvKffKayZKFF3R2iY+QoE98wIL6dZBs29PBXPnRe3Uhlc9vDQgx+
 PgxWBY0I6Fa5xjRvmsT1BTwns8F/8RGAu3g4SNCrZdln0owF1hJz+q4bWOliT+XYh6OLDiC/VZw
 bUifGIzAMSqGRDBo+yIsBJiBb7ZwN586CYUinZK65Fi9sWghiUj87XvPalwTbTINZB13lAtvho6
 0oNcrzwdCF4UTfOBOUrpuutrMCnBtvoVVEC2bDJhBVUqRiyG44xmQM8ZZteyB/eR4u2NEi6/Al2
 fYx2ZE1qTwWDTinwa2yszq/2w1sE9SZoDpo3v/aH4oBLsKooro0DMLYxrQY=
X-Received: by 2002:a05:7022:60a0:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-13997ba3dcamr177829c88.2.1781729181266; Wed, 17 Jun 2026
 13:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600B8CF45B3F28171F9BFCB9FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 16:46:09 -0400
X-Gm-Features: AVVi8CdgNNzolD6PYvDAFD6qxHWTnGZMEtre77UXol9qE5SO41IuRLGqIcmhREE
Message-ID: <CADnq5_OA_xfm-w8-_nve4V6jQ-tP12+2wpUpw9z1CEsoWNV+GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix QID bit leak in pqm_create_queue()
To: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Wed, Jun 17, 2026 at 4:13=E2=80=AFPM Marioukhine, Vladimir
<Vladimir.Marioukhine@amd.com> wrote:

I'd suggest fixing your git setup to have your name in standard order.  E.g=
.,
Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>

>
> When MES is enabled and amdgpu_amdkfd_alloc_kernel_mem() fails during
> the first queue creation for a process, pqm_create_queue() returns
> early via 'return retval' without going through the err_create_queue
> cleanup label.
>
> This means clear_bit(*qid, pqm->queue_slot_bitmap) is never called,
> leaving the reserved QID bit permanently set in queue_slot_bitmap.
> Over time this leaks QID slots, potentially exhausting all available
> queue slots.
>
> Fix this by replacing 'return retval' with 'goto err_create_queue'
> so that clear_bit() is always called on the error path.
>
> Fixes: AILIKFD-813
> Reported-by: Deucher, Alexander <alexander.deucher@amd.com>
> Signed-off-by: Marioukhine, Vladimir <vladimir.marioukhine@amd.com>

Same here for the Reported-by: and Signed-off-by: lines.  E.g.,

Reported-by: Alexander Deucher <alexander.deucher@amd.com>
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>

You can also drop the AILIKFD-813 line.  That's an internal ticket
number so it's not really useful for external parties.


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 1234567..abcdefg 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -378,7 +378,7 @@
>                                                      false);
>                 if (retval) {
>                         dev_err(dev->adev->dev, "failed to allocate proce=
ss context bo\n");
> -                       return retval;
> +                       goto err_create_queue;

I think you actually want:
goto err_allocate_pqn;
here.

Alex

>                 }
>                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
>         }
> --
> 2.34.1
