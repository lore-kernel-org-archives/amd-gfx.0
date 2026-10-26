Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05B606A321
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q33GwpKk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C326010F0C1;
	Mon, 26 Oct 2026 18:51:17 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E9910F0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:51:11 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-369fc2e984fso134303eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 11:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793040671; cv=none;
 d=google.com; s=arc-20260327;
 b=CkmO+pLjtOysnTuYHyYsQPBY2m/jMurE6bGvBVR3D8JiHyDqpE7b5VIRvYm5wyJ1wl
 UkyrRBkihqN1E5dwLxRa8KPiiNXVyb0WhkZGW5nR+yawJmafldP7iJuCNec+6HTtepEa
 g+4cY6z5iFfy+ghQ/gkyNsDaoLNZc/iO7+JYv7LIdPw4jOEYF9SqgEDiinbmTPHgZ4y6
 Grlac4gnPR9s54hjs7HRyHgGaDermv81UGb6vHfhkl3FOJCYR42+MRyCWe5pjmuN6bY/
 Zy1URfuj3OHzC4ZwOeSXLf2DhwC95f39vuEdd+pl/xBptQJ7fJKcEj1qIp7/wNRD05sU
 mC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wqy+U/eNoSrka88//FzuP/0bHFzoFAWbQVt9E7/zjAI=;
 fh=qQPJ2C1cUZTI88KvdTTxpDqLRX3dsSacqfr/T5CS4Tg=;
 b=MPb2f/c+oxihhzZPSjrwyq8MEn6WZdkWHgkiEUVcYd5zPYxldsOwOt3qljgoyM4SrR
 a5gzQJHdMEsATmkvq0uCcc977YDoPwGV8mDIqtabHrPjbbdsQoBgJcKTIeco66+8Z3Hu
 SJFnYQuEn2MexOvWagjdY1LeQQe1wSMfm9EpdGWNzBj9dKsOT89BwsxEoI3CSUcDIZx3
 WHCQDIBQI4myPg3Ui1b+xRQnhbT9trJQleMvLg9KO6CZbXiNw5XYQbzpdwO6rMHmik2E
 lqH0dQ/7TYwgWMUnnYasvMJLnlg++ute060ttXZhRMVb+ofW4gwakhpPBv9Outg09+qd
 966g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793040671; x=1793645471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wqy+U/eNoSrka88//FzuP/0bHFzoFAWbQVt9E7/zjAI=;
 b=q33GwpKkZL38vqnKzFDodJpfLPIk9uwDbUNpuggCtGepYyrpuV8CIhf2Ce8Pu/ANTG
 +zmY3UeNnGkg/cko0XiY5VfEuqu0hBP/tWrR5t5HODlpOn4MTZglLXcfqesMakHJ+wDB
 k+qN6X2O7XH41Y/Ed3IoTjnVg5CA2uw9qcZa7Hq8BCtjitEDruIpcWLIGZMmf0KYV78d
 04zNeys0sHKtTuONFWgiz8ACcHjEY3arW5pLIwjNLwqxiIn/YnePpe0WB4r1F/nl5rD0
 9rKErODOOp/dl6+r6BmiPgASS1rbU0Sieh9YBZcrv56BsAER37iSiJvy1xH+4f74oRhU
 OBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793040671; x=1793645471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wqy+U/eNoSrka88//FzuP/0bHFzoFAWbQVt9E7/zjAI=;
 b=jRafcKbMTqmRAPa2UfV/Oi1WkmS3tyaqiFhqGxdnZ74kBTlVEUlAaASzTW5d2vs6vY
 d/rC+v+D2Sao15hwcJyfb6NHogU8wStyr5bZ2ZfbecoxxATUzT1FLBzSBHjK9Eh1zZVr
 6HTXrWxU6FLtBlPa1i7Fx3Cm8xsXMmUt87MR3QeqVw/KuIz1HhbU/NPMDL0eFpBDJNkt
 Y14TgZOZ8psdzbLdIPlpFXnIKf/PDzsvuDfptsGFEsBeT0lGZxSgKyoO0cJD7kT4AwdV
 VBL1iw5RGhFWG9X7CUSMq4/NZYWWrFm/Ol/49GSS9XXdhFr1YE6olAdf5e7FWl9foRFr
 M5Fw==
X-Gm-Message-State: AFq9FYJcbVVH2tzpLEQcUfyK6PBO+OD3u+Y79HHZY9LiFZwodXxTWj1w
 l0bxj3naZ+94Ls8c/lFZJneZGv1+pj8/X4lzUKgvi2ctUNr27V7ENyGQQ736MrLPQREDnme+vCc
 xNvCFl/GQyBTk+bQ/0nj9ysXLUH7v1jkz8KObBHU=
X-Gm-Gg: AYBFou0ollPLw4yw5yJ4S/Brdr8wyqFO6iPPsb2FuE93v/+4ALfXJBsrpJb0/2m+3uE
 87pqymSHMLoAdi0FpBCYtPrrAtW+L22+mETD8B+lmIjtmfZgH3gM+XEVs4m/AJ52PoE0/veFDNw
 hyKHAWhW0zyyMA79tvHn7UqSkLShrD1QiziTkhjK9PKpxezP3jOg5RTN5UlcVzH+w2DzkbKo2LR
 oB6YCQAQqX19UTcQvlyzc+ERmfRfkvZx+dn5t7YPvUzX+uDk6yYcjyMVRsWTpOX/wySdm+h0cSh
 vAhLOL2sl4NUTU/ev5RyuqCSRqn84iWa9sZId6IbftGshrjjBWg+q3tfAv+XMasoon6zII7Ser7
 1BoIfWM06Ld21K5S0M+1zWWCtoaVt3Exsr8uunbKHFg0t/mlGRX+QkaexWy4gLjm8M0JbHg2CKy
 1S9IbAKBR6clc5Al+tg7HSsq4=
X-Received: by 2002:a05:701b:4308:b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1991bbd19eamr17594583c88.0.1793040670795; Mon, 26 Oct 2026
 11:51:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024194334.305636-1-erhan.bilgili@gmail.com>
In-Reply-To: <20261024194334.305636-1-erhan.bilgili@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:50:58 -0400
X-Gm-Features: AclHuK-kmOXWKo6oWycda5Of6rgDRCxKLgMNNguCQFggynhp4LcGoHX5sTF6fW8
Message-ID: <CADnq5_OBqDH0hoQQQDBxKGoiv0FdgbY7EiM0juqj1QpPyOSSOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Report MES ring wait timeouts.
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Jack.Xiao@amd.com
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 4:51=E2=80=AFAM Erhan Bilgili <erhan.bilgili@gmail.=
com> wrote:
>
> Return -ETIMEDOUT when the fence wait before submission expires instead
> of reporting success without submitting the packet.
>
> Fixes: 34e087e8920e ("drm/amdgpu/mes: fix mes ring buffer overflow")
>
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index b2e4da70d208..674ef3260001 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -218,8 +218,11 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         r =3D amdgpu_fence_wait_polling(ring,
>                                       seq - ring->fence_drv.num_fences_ma=
sk,
>                                       timeout);
> -       if (r < 1)
> +       if (r < 1) {
> +               if (!r)

I think you can just set r =3D -ETIMEDOUT;.  No need to check !r.


> +                       r =3D -ETIMEDOUT;
>                 goto error_undo;
> +       }
>
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index ce577f49b630..e25d6018fd56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -195,8 +195,11 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         r =3D amdgpu_fence_wait_polling(ring,
>                                       seq - ring->fence_drv.num_fences_ma=
sk,
>                                       timeout);
> -       if (r < 1)
> +       if (r < 1) {
> +               if (!r)
> +                       r =3D -ETIMEDOUT;

Same here.

Alex

>                 goto error_undo;
> +       }
>
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
> --
> 2.56.0
>
