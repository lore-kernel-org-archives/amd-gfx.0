Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D9DD591AE
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 19:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4CF10E273;
	Mon, 18 Nov 2024 19:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I7mCeBd+";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21B510E273
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 19:15:14 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-20cf3f68ff2so2993375ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731957314; x=1732562114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e32HBoCOcP3ZmSpTAn3KsOQM9KyhD7uBHyrPIbHdh1U=;
 b=I7mCeBd+dZSG5KvqQkHqNjXHbbHiggYD9xoQbDJY9VZxBKU1N/qRP68AKW79rU6fWk
 GnfN0dACpvd0TvTA7gtzsXY0N34maLSpebJMuBWIiBaYAmeZCi46f9lBpBpo++h014MP
 gZFmEupLKhDaKIdGEc9EMKS60DbDbFViQkXBzmRKvAZXooG/xytGotZrHguugs9OvinT
 QyKePdM0IvYVUXTbuSe+uhyn/74TwcRpmh7ioqE/6P5847tdACZ2j5LtfyG5812GAZyD
 IjK6ORA+xzrZNoQGFcyb8Wjbum9xwsa7AjH5z1ZU9/9RMezdZK5utIW4hnKM/tEZBZVa
 0D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731957314; x=1732562114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e32HBoCOcP3ZmSpTAn3KsOQM9KyhD7uBHyrPIbHdh1U=;
 b=dXojLV/6MbiUNFbB13/XOdH7eSaQK3f/ZaIFxRk7/txpwfuX4NwsbNHvG4fpkYRMqb
 9LbOfO1XF9S/15AMNGy7GaARO1UbjvMraWyba1ZFpmKQkXQg4rTsy9gfL0TjZO3bS8go
 RUMu3nPX6GAZqjabRg5lgFp3vHfaKHm8CiBz+XzaCN5XRK0FSHYzuwFgZtGKMj9Yoh5D
 QVl3+Z2adZ2/guEjDmNKu4gyLcKMDD2szcbRhfHOzT+ZJkc5N3A+6vO890M8ZeByTOGS
 g8eo0a05w3/TZ6NFwn5+vNVbI9BviAMy+AgJn5ludfz5HI1lv0pnuIXpPAGJ3Wzv74XA
 GcUQ==
X-Gm-Message-State: AOJu0YxHf9HGqwnAm+Rc5p4sqokkRDDUwSPu3L5mKi3we83Z9ZaRV3u1
 +MypMlhVtOs4vh0vqdGf0COVGjFHISkWCXk3z3x8rfEbfvhpdjcdr9Lt3jEf7teIP9KkhPZmFjW
 PBNuzebkw2k31Duib3iArPAIfwtIAvA==
X-Google-Smtp-Source: AGHT+IHBPU2+ilBA7PFLXHPZsvVrOKvq8LrUKunz2ExlHEKR1NZDdi3PjZugC97zgjO3FvM0BtU5EeX77Sx06MuSHl8=
X-Received: by 2002:a17:902:c945:b0:20c:6bff:fcbf with SMTP id
 d9443c01a7336-211d0ec63f6mr74339285ad.10.1731957314157; Mon, 18 Nov 2024
 11:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
In-Reply-To: <20241118053434.3382003-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 14:15:00 -0500
Message-ID: <CADnq5_PU3SgvJKeusMrTWo+8ajHJWNZX1LTodz5CO6YRZL--Tg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, mukul.joshi@amd.com, 
 Harish.Kasiviswanathan@amd.com
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

On Mon, Nov 18, 2024 at 12:35=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Write pointer could be 32-bit or 64-bit. Use the correct size during
> initialization.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_kernel_queue.c
> index 4843dcb9a5f7..d6037577c532 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq, st=
ruct kfd_node *dev,
>
>         memset(kq->pq_kernel_addr, 0, queue_size);
>         memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
> -       memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
> +       memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
>
>         prop.queue_size =3D queue_size;
>         prop.is_interop =3D false;
> --
> 2.25.1
>
