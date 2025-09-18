Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B29CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17ED10E168;
	Thu, 18 Sep 2025 20:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WpVdMwox";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CD010E168
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:52:01 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-324e2c12f43so156617a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758228721; x=1758833521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYRJeW51wxnLp76xdotE5IRncO/thDQ4oGxTQVUjSqw=;
 b=WpVdMwoxwIlpGCk3149Bzz3NxfCoJfp2QDBz0IVwJBE8GvyLI7cxnUp7dQioYX5Q0y
 Q27pTIJDGqMrUX6sl3gVs4ua6gaBlc35hFCg9PqDxREDQRH0jkwEw4rv6Onpm5hisqkz
 7K9GHmG+iGTUIAv3NXYYTYtBARNbPY+gFOrEjxBNqKNGm+fP5vid3MSf7Ua5zOPcOeSQ
 Mk0LH/H8mLRr44+UeGxwyeJ8dRqUpFMDM4B2VMKGJLcCjBbd/UFpEpiUtUaLNBv4YT67
 AjFIQq8UCeZK91+LIL/WZXVf7hCb6e9XOa2rPNPyB4QiWZIYDES2iyOdQoE/eVsrCD0Y
 RAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758228721; x=1758833521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYRJeW51wxnLp76xdotE5IRncO/thDQ4oGxTQVUjSqw=;
 b=KB4rl7+CGg0peCjAFJjI2uQuwb57cEqQJY2sA5LfZwKEcjY3dtTop/mBFDeZPxZ4yb
 9lRxl1tFykdJ1vNOuGbbs9lKdqlNS+LXHPSZNwmzdIXhrx8A3zcM4es93pk6H0UjG/OU
 ZH1SuuM6gfY1JBMxZESUFPk2FK235l6rk8vVbdAHpJNTzwvX65UZTt1wdnnW5JaT1Ouh
 UlJuorDF+qVatL+Nak8E2dZrv9xqHH2fd+jW+lgxjsVL00sCSNKVqMw+VKHpDIOIh7uh
 r13yEttSlgJXIvghi8mopwdjWKjTzs6MfGC115ssBNSc0xHB445jjeOgEhpVSOW31Fev
 5erw==
X-Gm-Message-State: AOJu0YwomIEuZMxUwXZBXEiBZDbrEgpD78o+XJJS370MjC3h0JPPBH9T
 MDqhQh37fOJkRxixgIWmB1j1JTh83bid6KqnfDYsibQsAbaGKIz3r+0u16aps9RJcP+Oc47T379
 7sv9zrVaj/se+zeiWhqvpU/EQsZilHj4=
X-Gm-Gg: ASbGnctQfFaTCWzREuK4tsixzSv52i3YohjYqHEhXjTnMv/SQ/aerwXO+CmyR30CyAS
 /NQBHHRk8XKDRPGDTItflTJxpqZKwu4fuQHd+oIx7ts2MD/zYxulMqDB94ynbG/iLE/0lyOmTq6
 OnV1OVXLkzKBINXNgti33sE7Dr4v66ARr2M6IQ8KRm/Eqw1h4GkkxTuhU8oGn+H5zJoXu3i2NBm
 FjHrpbHRPQpwjldkKJE/NI2XQ==
X-Google-Smtp-Source: AGHT+IEhGoXdOO4CrmluJhpjfAnuxc0R0Nd62fwr7+OY+QoqWwvMfbRsBTrTBpuW8eQ7Bb/ZXePNYNfHHm4M7thJKOk=
X-Received: by 2002:a17:90b:1809:b0:330:88d7:9620 with SMTP id
 98e67ed59e1d1-33097fd448cmr586146a91.1.1758228720922; Thu, 18 Sep 2025
 13:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-7-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:51:49 -0400
X-Gm-Features: AS18NWBvtDsQ3Oz3ZkUMsAVA1eRkdkBw4y6FbemqGgLJl_4Ty76OtkmdUJmuMgc
Message-ID: <CADnq5_M7bp9_KuH=da7npTQjWZo58dotaeWMFF+ZEpEz35RCVA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] drm/amdgpu: track the userq bo va for its obj
 management
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Sep 18, 2025 at 4:18=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Track the userq obj for its life time, and reference and
> dereference the buffer flag at its creating and destroying
> period.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 71cac54791c9..3c8f05a9e82d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -138,6 +138,22 @@ int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm=
 *vm,
>         return -EINVAL;
>  }
>
> +static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *ad=
ev,
> +                               struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> +       int r;
> +
> +       list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, l=
ist) {
> +               r +=3D amdgpu_userq_buffer_va_list_del(queue->vm, va_curs=
or->gpu_addr);
> +               dev_dbg(adev->dev, "delete the userq:%p va:%llx r:%d\n",
> +                       queue, va_cursor->gpu_addr, r);
> +               list_del(&va_cursor->list);

Move list_del() into the amdgpu_userq_buffer_va_list_del() and move
the bo_reserve/unreserve() into this function.

Alex

> +               kfree(va_cursor);
> +       }
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -200,6 +216,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[q=
ueue->queue_type];
>
> +       /* Drop the userq reference. */
> +       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>         uq_funcs->mqd_destroy(uq_mgr, queue);
>         amdgpu_userq_fence_driver_free(queue);
>         idr_remove(&uq_mgr->userq_idr, queue_id);
> --
> 2.34.1
>
