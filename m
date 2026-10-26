Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32D606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EccwZXiq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E3810E383;
	Mon, 26 Oct 2026 14:58:19 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD5C10EF52
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 14:58:13 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35e8253292cso260218eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 07:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793026692; cv=none;
 d=google.com; s=arc-20260327;
 b=ozS91fvdalcarxzJKsV2sTmBbPrfP/0LDFyy7An9BqZFHDIVKwQECl42SdNtlw7vRa
 O6Ad8bTWHMR8k52Khe+rrjKNdQNSTtC7h0ZcFdq8QZQDbZ9cNiRzKKf7nIId7aEq7Euc
 G9xjL/4iTQwc5qLicnslS1XZTJy5ghR2wa7yGr6erCWClO6ZM8jMBRoycfEmIv3pdS/y
 SJS0lfP7sKV02zOPVD8fEtLLC2GYY5bBUuUwcxV5wV1rCJbtiJmnByfJWlGi90mUN5ea
 vw4cva0FaEbwQ2MrZm8NtgQq8NisXFuOlCsm041zEFqkeit3OwkTpABV/ooZ8bQ3w9dg
 sVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zAOwFj+rjpkzxxFwvDoJ/OHkuLqdKQZfBw/jUJd34GU=;
 fh=M2UILxsPGqz+RSf+JBU2phXwpHluAd1D7I6JJOnE14A=;
 b=hItBAZ3nJAi65ox24aKQfSraXrMF5Ox4cDPy85V0b9vUF3e4lyTVVF8U1ZQFwdU/H1
 lnjb4qDdKGiZrx1fATEVnEKSnIhugLhng+11IrlXP3PY/LGlOqhHBf9vmmNAps5uCUdi
 FYFtrMkv53mpv5Guhca9+m3Bfkz4dpp/FG7pedVEjB9Ss5/wK9kltdW3iw99nApW5sbz
 1le2Y1CZSUnsTeboR9RLyIdWIjGNlr3DhZsI/IL1DD7mtLJdUo5kMovcmCGhlpkF8Qrd
 IEfbYw46h4u+4oh2w5+hctEZP8qydOBbzgqKkkMUedq5d6Hvsl3sPvX7X3ggeEpLbNy0
 WTEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793026692; x=1793631492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zAOwFj+rjpkzxxFwvDoJ/OHkuLqdKQZfBw/jUJd34GU=;
 b=EccwZXiqgUdWiEXdsVTQd2i4LyA6DPAbJmspBYxKQ9M48rhA2bHFp4m8hCvsYSwjYu
 osUENVzXW6gP1Q4fYTQnLxfliOEeFGGuR3q7kcIa2r/IdsAugLA6ghcj46dWjcu00jAa
 urpcvR3dhPWieVeVWP7b3gQZX9ZlObxFWwNi7Ol78C2uXHTmeXwU3WD95/7sdwue8bG9
 9AnqHLFHRFnjdilacgCiHK2XdNHPdpn3s8JsJhxEh9l6yjo4+SUile/HAloq0cHls9MS
 K6PD44tTYMt/n/hJWd5fJO7y65mgiNCQv5BbmowXrPjTP/Z8OtbHcA+mMdHFDeeKNPvF
 vCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026692; x=1793631492;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zAOwFj+rjpkzxxFwvDoJ/OHkuLqdKQZfBw/jUJd34GU=;
 b=e+WIUJm2/J0C7UqZd3VSPxIz+EtpGu9YexLH595NwXu7XKfiqYnICjvnPm/Ls4o4jD
 X0QsGHX2MjyhPL5JoeAieC8LPbf1sysDmEv2eeQoy+Lz091C5zZ6/42C0uV7Ygu52i1Z
 ojKDRiTaQkUoizL334SnGFImADkfTaHud0L7B3WJza6cUVzQmd+jmycksmOLETYI4vBS
 JktX+cRcp6Q6dYTWD+l2VIExOozQ4JZEEWmDabKpAiz5x8wZrItk5y8B3EqPNPBb8ToP
 nsJxG0LzjVG+oh3CSsx4eHrJiPjySxaMqsKNEMqFmck9NWUs1j9JNOLYMzl3PvXZUDYa
 ADxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZLyxNUFSmrlhmU1QJxrgw6feVwahBLB9APpzum5AFnw0zpPBwmGv8MqpeJ4iutunWbvuIrP0Y@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLCkP2iHmQHmdi0kqCO/isZNAMxVcuPQW+Pqce63HwiHAh8Fj2R
 m1jKcV3uoLELRs01/8jmBVxerTr7tDMlrIESmIY2iKf4srjOrack7gkphv85inI3AZmtwmydSAO
 GrbM48NjHUm8Pgys4P6Kt9b6gRF6Bqe9N9XfD
X-Gm-Gg: AYBFou3sA+Q9oVQJVwUlovsBrzKkK6zHf3POdO5A97NUpyn08SERL2e/PVrVoNVzk1M
 wtgSO5cb4K2srKQIPN+nM1uPaKAhWNniKDCI5uh0XGsAVyqh8wF4fT2l7JnqCVL0uIP4q4Hbifd
 Aav22lwvW2ULJ+y8ouwQXwtYXqyUXdBZVpTO65FnHtz7lYWKNLthxw64FB5lTw1BeUaKHJZswoA
 tvhoNfrNultyjb8AZc74m/cxYQGxyX1syazRYdjAPL9TAiGyu/eTz+mpNIyB4tkNl8BG4Mhrq1c
 +Vm2Z6Di1I3UX1iIqV/EFdzImzL8WZqYHL3i+dYOKPIV+r2ZCftm8/83qQcuyMdv96Pkq5JVxgc
 efF/8SWP6wI0Ga8gTMmXUPzpoEin2ElrrXRBuhoUE5+pvFTpJjbA3EvJfSQNR28OMNNlPrvt/Vx
 DS7KczZxCN1gIEJ3TO7/94DzUQ
X-Received: by 2002:a05:701b:4308:b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1991bbd19eamr16655234c88.0.1793026692358; Mon, 26 Oct 2026
 07:58:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026065735.3299011-1-sunil.khatri@amd.com>
 <20261026065735.3299011-3-sunil.khatri@amd.com>
In-Reply-To: <20261026065735.3299011-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 10:58:00 -0400
X-Gm-Features: AclHuK8ygoYsTQWkgD1WsJc3NwXQBpBV3dWI9VkWslWj4Wtt3cGez08ESxJPatk
Message-ID: <CADnq5_MzaEFA5eaBv9qFUrpnrPGKxwCsB4dqJcDePjKROn0N8Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu/userq: remove extra blank lines
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Oct 26, 2026 at 2:57=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Remove extra blank lines from so many functions.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 6 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 --
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..4b3926241f75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -52,7 +52,6 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_de=
vice *adev)
>  static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *a=
dev,
>                                 enum amdgpu_ring_type ring_type, int rese=
t_type)
>  {
> -
>         if (ring_type < 0 || ring_type >=3D AMDGPU_RING_TYPE_MAX)
>                 return false;
>
> @@ -304,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amd=
gpu_usermode_queue *queue)
>         return true;
>  }
>
> -
> -
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *que=
ue)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> @@ -458,8 +455,6 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr =
*uq_mgr,
>         dma_fence_put(ev_fence);
>  }
>
> -
> -
>  static int
>  amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>                                 struct amdgpu_db_info *db_info,
> @@ -962,7 +957,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>         mutex_lock(&uq_mgr->userq_mutex);
>         /* Resume all the queues for this process */
>         xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -
>                 if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>                         drm_file_err(uq_mgr->file,
>                                      "trying restore queue without va map=
ping\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8c696e37d971..dd976a50e053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -457,7 +457,6 @@ amdgpu_userq_fence_driver_force_completion(struct amd=
gpu_usermode_queue *userq)
>                 amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
>                 amdgpu_userq_fence_write(fence_drv, wptr);
>                 amdgpu_userq_fence_driver_process(fence_drv);
> -
>         }
>  }
>
> @@ -821,7 +820,6 @@ amdgpu_userq_wait_return_fence_info(struct drm_device=
 *dev, struct drm_file *fil
>                 dma_fence_put(fence);
>                 if (r)
>                         goto free_fences;
> -
>         }
>
>         /* Lock all the GEM objects */
> --
> 2.34.1
>
