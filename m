Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA03EB8FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3620C10E012;
	Wed,  6 Sep 2023 13:36:49 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBE310E012
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 13:36:46 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ab2a0391c0so2471855b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694007406; x=1694612206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lAJQkuOt3iVYUXyfZDf8GBkzKWKVsttzkZfJysYGtA=;
 b=dgFeDttmnmcvMJU0/Ucq6JVaxalFHYi2CmXlr3niX+jWNluMB84eEFMnhKMLKo8fe5
 bMD36L6cuBCpG81K0iRZa2g6Gd/fk41nRU0nYjZZcRlNkY6gLgRqsxvqiFRor4wnQi8q
 8U8KeaDKyh/YfbxJhpTeeO0J4UFoXpARr77L7o1p6n+EHeyjkahm2X7SpfI5QMzULSGg
 bM/robF2Ocz9MTV4148t1N1NPdrzZMHjLMZPuwDUqJ60xwCNfo+Le+8Qikp3q0eFx1i/
 aKMoGyEXzRIAzaFV4c4Xmw5k4LzHuQKhQLHKrV1HQkNpjBVBE5ZbNy4j5hVVSp0MRTaA
 2iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694007406; x=1694612206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lAJQkuOt3iVYUXyfZDf8GBkzKWKVsttzkZfJysYGtA=;
 b=ccGhPCL+8fnc4POA3F3x1QzwLAa6Ez170DdnNSRYf7uS/bjvGSr0C6ud6ZKLPc9aEV
 yTCQtnGZ+bQBx3qhr+/Dw29RvLMT5T5QnstdgiwPWjnwwUr1jhMXiQdBCOT3fArv4gWj
 iGhHRO1/IZj0ACG59kTEVyS3GJFryrFsFvsPFJtw6Gy9aiupq+Pxqr8CEsYPdRLAEMjI
 VXSMr6MIT2kRNekkRdYPvZVBZUAhgzLcI/UNXptUpNlZ9SeefBrg4SEftakCap1SyYOV
 e7Zbmbx+VRttQbKgUr18S1RmMVaC829SWaZvQ6D9D3RnCDKn9ZMtz3PnX97Da16KvbZb
 7KqQ==
X-Gm-Message-State: AOJu0YzRuNdfkZ4NPGr3o+pYckdYkZNIL0N/4HmmgD/wLiwow6xd9KyE
 5PY8uiF8inCoRumcfRSR5286i/5+M29MJiAlg5Q=
X-Google-Smtp-Source: AGHT+IGpaQL7V9WNsc6VJhr2I5J0nCKAG6BmALWt03hrex51uLs90dmOTPscKLs3GL3Z4pMPD3ReW6pUhwteH9lzkzg=
X-Received: by 2002:a05:6808:158d:b0:3a7:540f:ca96 with SMTP id
 t13-20020a056808158d00b003a7540fca96mr20418161oiw.4.1694007405882; Wed, 06
 Sep 2023 06:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230906015415.227847-1-lincao12@amd.com>
In-Reply-To: <20230906015415.227847-1-lincao12@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Sep 2023 09:36:35 -0400
Message-ID: <CADnq5_OrodhXfbUzkFfJpLkzmackf5dY82cx8CcfX2xSz4yd1g@mail.gmail.com>
Subject: Re: [PATCH] SWDEV-420310 - struct pm4_mes_runlist in amdgpu is
 conflict with spec struct pm4_mes_runlist is different with mes pm4 packet
 nv10 spec Modification: add last dword of the design of spec into struct
 pm4_mes_runlist
To: "Lin.Cao" <lincao12@amd.com>
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
Cc: JingWen.Chen2@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 10:05=E2=80=AFPM Lin.Cao <lincao12@amd.com> wrote:
>

Please fix up the title and the patch description.  Something like:

drm/amdgpu: update pm4_mes_runlist

struct pm4_mes_runlist in amdgpu is in conflict with the spec.  struct
pm4_mes_runlist is
different with mes pm4 packet nv10 spec.  Add last dword of the design
of spec into
struct pm4_mes_runlist.

Alex

> Signed-off-by: Lin.Cao <lincao12@amd.com>
> Change-Id: I1322c010d1428b2c1df5080b72da94e90cf17fec
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gp=
u/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> index 8b6b2bd5c148..d50feaf59b8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
> @@ -129,6 +129,18 @@ struct pm4_mes_runlist {
>                 uint32_t ordinal4;
>         };
>
> +       union
> +       {
> +               struct
> +               {
> +                       uint32_t level_1_static_queue_cnt:4;
> +                       uint32_t level_2_static_queue_cnt:4;
> +                       uint32_t level_3_static_queue_cnt:4;
> +                       uint32_t reserved4:20;
> +               } bitfields5;
> +               uint32_t ordinal5;
> +       };
> +
>  };
>  #endif
>
> --
> 2.25.1
>
