Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDBCF436AB
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 14:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C08510E2BA;
	Fri, 17 Apr 2026 14:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKdUM3Z7";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E845110E2BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:05:49 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2bd801b4078so71206eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776434749; cv=none;
 d=google.com; s=arc-20240605;
 b=Xp0BuvRHoJiTahBrZWdmekKA/M8HmLmsbUhKxqp18cyk2Z4xegKWNIHYJvTyWBwfKQ
 KmERSTTqnliYc+lP3nYB4C7NO0C5gfEwCEDZJsYXeeU5gRmRDVxSl9gUvA8xxzjUOXQO
 eCT1QJJ6z/BY2uTSGoc74BaEfQkraRZXetq0vZAESiqS9FURhBHBsG9M92BsJLxz1Zdd
 v7LlUEg2aehH9TAy+3bwVBZHOOFwy0Tp8d7f7t1bE65YS5u6hxTqoe+iAPrgjmC6CviJ
 7GvoKQ35pPlXJrUKvq9giC/a+ACR8HWPmXJEvH9LJEfMUUsUgYhWqWw41BdppE4KTzBV
 3psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 fh=O1Mz4nTE958NAdoYdjWKFCar1BgQOp1ze/grwF9wZA8=;
 b=fvAnM1DcEF8/rdGMBUAreDapD8Y6k0NsNvg/rp36JVTPtPR3tgzKSXLre/YjBWNN1H
 pYazOz2aEinNbEDYQM44H+bSakO/upkryaIetkZAj5xu0Vk0jWuTx8i18ZwU5brBra5M
 BMNfjkBdqb7JFKa0UHvDgX9nZKCWcM/OuQjsiNF4MpltKFCL7DyYFAeteLto8pJAFf7B
 m3bonrM/b3WmcCoZx69wdwf0SI0UATX1Hpbkp3vY+Ao7CpFRguaDjP070wdySmGgJBQE
 6xBdMFzS+aq2tc4+1eQWx98h46N2+lZxyWKjNCjvE6oPObAxOO/WyqrLc+bS3SFxs1Jr
 2iIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776434749; x=1777039549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 b=TKdUM3Z7KGZxoUsLcUIrC3E2HCPC8Kn+RD50wVWWBJVFeYE5K0zxmWlNR0Sf3f+nBc
 phMRhMU1+Mhojct9RfhrpKZQ+U/ICPw8qbM/z6YPuHOCtkypvx4gWQqqc8DwrsOqKUCo
 frhjxQ+sbIYMHJdhu9Vp5VtHKj49zRFcU/P0gSJ7hP/0HaqDVaxY5hH4im3BB72eiWzP
 /BuFpRX6ewozCJoHduIJboxDCoJtC7ei+LxLLp/EODBpRLXBZUQJ37AVq3KjU3yjNTgc
 LC9wjet8s8hgsfdZ8ps3DvNMTTHYlcl3cAf1XUoO06/Gnd3piQOnEZJO9fvPuGgocy2W
 /5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776434749; x=1777039549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 b=ZANYqO3P+GGI+ZBzBtU8kJzD5/uDAtUcG7yn1TGgddNhZOPKtZi9o6mzYOlGXlB7T/
 BihdTXG97ZFGym0ZsBFJiEA/mKZgAKwDmH0Pfuc1eI/OI1S25jJEIPIiIyAcqxlTgMnH
 6fjYM83Irn+OArQvZGrVV5d3NnUPwtOYAxRxXXb1pKDViwXeAcivKmcroOGPmWQwz7e1
 6Ezia1DMZjrkbuOx9KWEVvXztg5yskBXxdP6q889bUYBNKpmrtkVEznmIuH2jaDAg+br
 WBJl5PV6859sYuui9awXa/vpjb6f1vGSWLLwXoNpVPXqihvtHdbfNbZPFRomcsvayy+D
 bGCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80uv0Komys/f5QyO6GnOX5L4qhipTon0pyMzBUPUrh5KpbC7yK9UL80O1naVh3mbyD7BRoURkD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP2FUDv4Z+1aq/yvwMTOi4WB1MHTBbv6X18xYvWXZOFXazjdqM
 rzZWrTdrntHdOyMEuJ4ZMcTyJ31RYM04bDNIYIuUYilhQRA/AjfkycOnilj67DJJcOkgEuoATG6
 Ok11FztGj9sk45Ijj+MsHf4bk/V0Heog=
X-Gm-Gg: AeBDiesy7AMoW7CStKkUtBBg9sAuDknhg/bDdlLtAsyPg5q8yjwmWBpKTlj8enAmONV
 32r+MGMowJxwUeLeaYYhvGhsWZGoQgZwQMXMsHy9aS0EFPyQ/cYSAxykFMaJwQPDIk1lMNCp3qe
 62ERI8Apgc4F3nrlZwRLzuypwJSOf/6a1Dr5spAzRaLhOISucaLA/UN1uALe9zjWijNsSwbZuAj
 MoELmEAAoHeWoJrPHkrDNHBU4j0Bk4sqAxmcfd3IT+H5BQSYTQdFjEnC6nJkN7MptZptDyorV41
 rbc/Gz+3htOgZEJWl80ajwt0ePZcOjxKMVrphIlqUpK5Pw0dNYSKODeE1JkWVoxDxTxiLnOxUeG
 xFIDc
X-Received: by 2002:a05:693c:3011:b0:2c7:2cac:8149 with SMTP id
 5a478bee46e88-2e4871fe6bamr672967eec.7.1776434749018; Fri, 17 Apr 2026
 07:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260416195537.3632-1-dbgh9129@gmail.com>
In-Reply-To: <20260416195537.3632-1-dbgh9129@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 10:05:36 -0400
X-Gm-Features: AQROBzDAAqMZZoPqgJldN_PKeIHlbSL12FRIFysUQMxrUkIadk_kNeR4nycyTco
Message-ID: <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: fix memory leak in radeon_ring_restore()
 on lock failure
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
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

Applied.  Thanks!

On Fri, Apr 17, 2026 at 3:06=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrot=
e:
>
> radeon_ring_restore() takes ownership of the data buffer allocated by
> radeon_ring_backup(). The caller (radeon_gpu_reset()) only frees it in
> the non-restore branch; in the restore branch it relies on
> radeon_ring_restore() to free it.
>
> If radeon_ring_lock() fails, the function returned early without calling
> kvfree(data), leaking the ring backup buffer on every GPU reset that
> fails at the lock stage. During repeated GPU resets this causes
> cumulative kernel memory exhaustion.
>
> Free data before returning the error.
>
> Fixes: 55d7c22192be ("drm/radeon: implement ring saving on reset v4")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeo=
n/radeon_ring.c
> index 581ae20c46e4b..a5dff072c1ac0 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -356,8 +356,10 @@ int radeon_ring_restore(struct radeon_device *rdev, =
struct radeon_ring *ring,
>
>         /* restore the saved ring content */
>         r =3D radeon_ring_lock(rdev, ring, size);
> -       if (r)
> +       if (r) {
> +               kvfree(data);
>                 return r;
> +       }
>
>         for (i =3D 0; i < size; ++i) {
>                 radeon_ring_write(ring, data[i]);
> --
> 2.50.1 (Apple Git-155)
>
