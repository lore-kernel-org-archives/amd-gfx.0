Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD71C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CA910E778;
	Mon, 21 Sep 2026 21:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pf0u2ILj";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372D910E80B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:31:04 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dfedbf80fso19140a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026264; cv=none;
 d=google.com; s=arc-20260327;
 b=A86kN/fnAZ+0fxgzrGXGgjUpWyPciyoP+/qJKDcagyzgfoGiD1UG12MMvj1yJTygK1
 2MAqkmoFLRXLqBHBY3UJU/0iPFqVSm2sIUWGPy5dvMwUHicNraRokH54KiSq7pTmwJna
 YbnsYsOlEhQWQbrsgQpsJT/m0gXmOFHpfeKxWTYX7z22CBmJknU8G0wCYogyOVf0VACE
 oojCQtPYG3CX6JMPAQEap6fw7mRj0XPdy21gO+HZZcD7MVmsu2txYoMj9PbrhRJCgrxW
 Por62hywFEkgkhJkMWMR+hCOOYbFc2Q2K8Yj2+iXK1wPRD3IZ7N5gALiXpZfDIO6tNfN
 NC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 fh=UgC6o/Revs0zCalHNxJZUxXuWmN6zTLwDhxS5VOW61c=;
 b=I7eAsKryxKtsICZ0FYxv4Ag2cCrndTJ9f6K9IiZWcrSBnyOjzqsmDmu9aF1VX6mAyL
 jMsz5Qqm13Mr7XzB9XUq0pOUJimF5VyTRrxCRsc7DQcVxnt6O/DH+aSqLH6Lg4cHTBhP
 0Vo9/cNsQNgzrwkpWFzM2R1JEtaFFo1fD8yZZBhnIJvSVfnJE4Sl18pa2UMs4xcjMTf5
 sSf0jq8lZQQDxbtEyB8OAyQ1Zz2qyHag2rMZIcSBM13ADe09REBkodP23QMDRW9fOrAG
 VVEe4JlfD/1NK2FCJPnTe7fyVkHw6QDBFWrNBgiqqrSX3J5GWtPGZ9Yxta5ErURr/nqK
 Ysew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790026264; x=1790631064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 b=pf0u2ILj5NgvU4MaKHGcwfYyBppD/F2rHVZkZ02whU7JyLPVTHkYQkfDi4rCioOFcM
 FCnnecqV7Ssd+c5zXmzACKeiT/NXs+IHAs77YXFC4iwFLT+USKigMrwVPtKTRVzLepva
 fOBxMRKlO3rI4Yn/IqPSmdlf2BEW7rYfUkI9zPXIQHrYIiABaQcOoaU0F+S0mB8xB2Vt
 6gooqLzULVqf7t1pNMGm7QrPWR4CcTZME7uFjiIQ421geN/lfTI+QUvSJcts3nGHxIWG
 QtrHpmd4ww64VEhRXHCQ4tAtY32mc9PJfz4ZjGFo2/HcxWxcgA5FMfEqgWGm9ojp0mso
 dr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026264; x=1790631064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 b=HnnP+vV8xAEL/w2spH6uGdahMLmKBA9hnRvLu+HCo+reJLKnAY5A5GQmkAlKeWqd72
 klzFbi0YlLu6hzhpJ/zcNaaWEXArkOcMb8HxwE6LMAh3551053fZc3T7gJG8Hi2lQo4E
 aZZDvQdHf/gQg/Mde6D80EFKcEUed0VI9yEiLEzVH01CeF49w3oOXAQOVqQMt5cBMWf9
 ApY0bzoJ0pqdTXFHPNoHSBjnXTmiE+LTWVDq7UFtBrgxHQoBSCS7jy72RMfA8zIiM7qC
 kUBLcq6+RR9hx0inAxR1Mw/d1ll3naFoQHJwYPUO70WHSsMM0MQ1FgC7KKrU1vuJFr2d
 r0og==
X-Forwarded-Encrypted: i=1;
 AKwUvByV+uy/80whW++fwwq9PpuAA3O2ybbhq9vzy4zuEWdWWhqc3z4XtinbNqD63g+feQtBGEQnRzC2@lists.freedesktop.org
X-Gm-Message-State: AFuF++nK/dF18qtKFy9AWHnfvvzikm6sqZ7/zqekEAZwc6iudFiQH0FX
 7sxSKi0swo+i1iUAA74SxzBmTLgLvz1q08yIvK7ocPw1gO2qqckGgvjc8tpSinvruEzgnYiyDl3
 P8eN0BiOKODDHDKhqN68ajshkw+qbTUs=
X-Gm-Gg: AYBFou3gQey0H+QL6ya37j+UBKlavwn249ob2Rholqj2Xu1/EFF4meM6490y6zbIrd5
 gFJmRXeb1S76T9U07d3o79/cSk0LVuAXX+zTR9QUWabe0XmddUJLS5Nmu+i3I43hpztu4qTkVSL
 v1slNtcpDhlIWq/hCxDjEiyldZuqCSsDth84ycPYvy5Y3GtyfPooXF+nrmmHf8QQdBEa1YD8Sro
 t5gnfaoKk009ofMI3vQzVtiWD80Ep1HvWNy9+BUQgD5hqUJY7S+43c2c1xIBwiOCxntv5sSXStB
 aZquWKfGh10CqPudJbuScuOj8i3XzMRo2ozFuFQfNixBTaTfrBmWmNlv/4U6AV99M6BmgTmJyg7
 Z5s25rtGNUmJsRSLsZlUukvCqFIz336GlWsiEJ1pQbng=
X-Received: by 2002:a17:90b:58f0:b0:39e:261:4e13 with SMTP id
 98e67ed59e1d1-39e54f42eefmr24972615a91.3.1790026263555; Mon, 21 Sep 2026
 14:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260920062510.166584-1-yaolu@kylinos.cn>
In-Reply-To: <20260920062510.166584-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:30:50 -0400
X-Gm-Features: AcwNN1WjjOBi88To3FSq581QqCOsezWgyru8to2rFEhGCyGgtBQdu6CsObQOUn4
Message-ID: <CADnq5_M19JOb6kSwUi6juWWSpMtQZtWazw5VtP7rhr5ZvC0-iA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note
To: yaolu@kylinos.cn
Cc: lingshan.zhu@amd.com, Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
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

On Sun, Sep 20, 2026 at 2:25=E2=80=AFAM <yaolu@kylinos.cn> wrote:
>
> From: Lu Yao <yaolu@kylinos.cn>
>
> Commit e1b73b64271d ("amdkfd: remove DIQ support") removed the
> KFD_QUEUE_TYPE_DIQ enumerator from enum kfd_queue_type but left its
> description behind in the note block.
>
> Fixes: e1b73b64271d ("amdkfd: remove DIQ support")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index d8631847f0eb..2847a5ec5ede 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -430,8 +430,6 @@ enum kfd_unmap_queues_filter {
>   *
>   * @KFD_QUEUE_TYPE_HIQ: HIQ queue type.
>   *
> - * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
> - *
>   * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
>   *
>   * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDM=
A engine ID.
> --
> 2.25.1
>
