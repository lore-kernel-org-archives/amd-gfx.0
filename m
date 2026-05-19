Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0907ACD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6DA10E21D;
	Tue, 19 May 2026 13:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnvybJ6q";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C9910E5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:05:15 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7dd73b7c757so1734254a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195914; cv=none;
 d=google.com; s=arc-20240605;
 b=irEgSAGeqjeoBi8tRvzHxEmHm3Vwg5Z6Pu5hpiAMj1Uys0XKgBdXCKdMmIDWpSSg4X
 9sYKp8liBAApGqCxfvM4y1WnbF1FlBPRZb5m3c7aTrMj0FoN3CYUthla/PWX++OFQuOW
 4N11c0RJCQar0YG/isnkpjodVMOPdPelE2GNSxIUmYgeJ7HYr767LIb16jpRd53h+3L4
 ACtDZJgRaiDIEesWenXuijbRQURDt2+4gcLzsdomkmTViBhNShDQHqexQkYcn2a+OVUS
 iDN9VHTJzJUknjfBtBUbnZQTeuim0NKXV6RRa+ognXf8KfT1ZIQP9cZvdBS2nui3FTTH
 LR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 fh=ltOybDYxq4CHgs9xj65K7x+cCIWA9NHEk3RaA8pBAd8=;
 b=T37Ewsxr6u7/rsBNKNxidRjm98zFWGXTPhjo6zsLxBxEv3/kqM5nQijHIk45ii5Xax
 i/GO8UyRME8OXC1WqBzMKdWcleSh0tnqZZnPwJhpgIysSDsko4CuU9MikYLaA0gZS9Cn
 RH+MLHl+V37PsIKhLt7h2Phnjz9cM7aHGiQKICEV5qFgMoM2TVQ6ygrDQT7JPDnyfbin
 OLh2qtuI9P5qb0sbTDJZ03VqNpgUvratQ6H9Ovmaai3jOuZjJwjNWXfJcfsytP7Ee4AZ
 VFrIuzNb+z6yrNmpeJd4Nm1YuuPWmRz80vTZGw3CjXY6jpzxe13u48XWknbbSmHrn/FV
 EJZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779195914; x=1779800714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 b=HnvybJ6qKrrhhmXNYX+M1taD53YhNmhfZsnQ4ewkG7ZqnD8FDKQDFkGbY5PJcfNHQH
 YpEs0SD5d67MYVUaIiYjoCGrPKDzJ8mfTYQej51Cpey6rZ1MbqvHoCNUBRewJgpdXT6o
 MdHpJT092eQ8qIBXoiSixmp56uHGHVPmkWEfuNh485rSWpXuaM1bRYhK35vYKOj6HgrA
 gIDCcP2Imp1gtIOGCUHw77uLyxaOOTUP1qqqyDZa7XJE1vduQfm5wYqAfKPrJb+bX1rS
 Le5ovpMDfn19/qBrx8AnW3jl05C9LBxTeCWozM3cBIM0uCxLPg1pVWtF2qCoZBujtql0
 u9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779195914; x=1779800714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 b=tJ1K/KIM9hSAqLvk3+6dXLTefxFl8LC32mem0vvH9cjEo1lm+qoz6NVU7BYG9Jujws
 1xd/C2IAGTQtnf37YRHYgf8v4+7P8wbPPKQzAozCzfl4K9a0SO5+U0PL9grdf/E0s/xa
 VIc39zB1dUTZCxMUkplBDmhbTfclBtFAi3t0ud96aYirJSqinoYJPCgIKbXhK2YzFQc5
 CHtyXTu/Zeyegr1v6AEjXqFP0taTKl3DsQsGSPVIkXtDF4TeAwQ3raUsfrkFBzliRRMV
 oBJcbfuicY0lG/rHc2WFmNXj2mre/Q1/smdEcGNOZgXbkAPKmRZsJPD0U0AjA4r/Gv+E
 xTng==
X-Gm-Message-State: AOJu0YyTf2u57upZpYtO2bU4zkMZ8tb3P0dBSoOVAc/MeRMlBH0xcJ3i
 45KarM2cvZbVIX6uxkZIbcU9MHB2oqGd2trGjlMXYTMqbF6ATy0TxBXOll72RlB2n03KhoBoOm2
 Fen8R+OB+26wpDGKUaCFIipGf3fx76FLCwkxPIV1DvtTvsKc=
X-Gm-Gg: Acq92OEho3itCEwH0YbLhAtGTddFe0gV3QsGKZaKKMCWq9iO4hpkyhFyJG5RgyGdzWp
 406hC3WQK36A2yIannPRfzEt+kR6xnkUwqfuAuc77qVqHOak5ArcnSriIQVTR63ug+KQoFeitVJ
 vUgp6+rbY7q5CHRHFamyUyJ4jnwleaQKKyYMXQt0PqiyoJl06sC19KqKDWmjyT4DT7zHLzUWEV/
 OCaAZHIeuO4pl2Av9qagnEgAkZifKACIj7uYw8hA6qdo7q9uNWUx+ambFmywgJixlf4Mjg7zuXD
 SxPJfMRjRg==
X-Received: by 2002:a9d:454c:0:b0:7e5:b3f6:c6ad with SMTP id
 46e09a7af769-7e5b3f6dde6mr1978777a34.4.1779195914046; Tue, 19 May 2026
 06:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 18:05:00 +0500
X-Gm-Features: AVHnY4KCjg5xnLKDTpF_UzV8orViAi1sRvhjRQeLBblOdok117UByI2OEfFaxHs
Message-ID: <CABXGCsM_YJ+UY86yFJF-jBcbQXRoc0qnSw0saaGWnaSYWG0mmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
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

On Wed, Apr 29, 2026 at 7:37=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When dumping IB contents from a hung job, amdgpu_devcoredump_format()
> acquires the VM root PD's reservation lock via amdgpu_vm_lock_by_pasid()
> and then, for each IB referenced by the job, calls amdgpu_bo_reserve()
> on the BO that backs the IB.  Both reservations are taken on
> reservation_ww_class_mutex objects but neither uses a ww_acquire_ctx,
> which trips lockdep:
>
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   kworker/u128:0 is trying to acquire lock:
>   ffff88838b16e1f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>   but task is already holding lock:
>   ffff8882f82681f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>    Possible unsafe locking scenario:
>          CPU0
>          ----
>     lock(reservation_ww_class_mutex);
>     lock(reservation_ww_class_mutex);
>
>    *** DEADLOCK ***
>    May be due to missing lock nesting notation
>
>   Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
>   Call Trace:
>    __ww_mutex_lock.constprop.0
>    ww_mutex_lock
>    amdgpu_bo_reserve
>    amdgpu_devcoredump_format+0x1594 [amdgpu]
>    amdgpu_devcoredump_deferred_work+0xea [amdgpu]
>    process_one_work
>    worker_thread
>    kthread
>

Friendly ping. Pierre-Eric, Christian, Alex =E2=80=94 any thoughts on this =
fix?

Happy to spin a v2 with any review feedback. One thing I'm aware of:
the `Cc: stable@vger.kernel.org # 7.1` tag is probably unnecessary
since the regression only landed in 7.1-rc1 and the fix will reach 7.1
final naturally via drm-fixes; I can drop it in v2 if preferred.

--=20
Best Regards,
Mike Gavrilov.
