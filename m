Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0ECFD8FD8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F9410E9D0;
	Thu, 26 Feb 2026 16:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I48kEQ0X";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B51810E9D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:52:44 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-127337e3870so89480c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124763; cv=none;
 d=google.com; s=arc-20240605;
 b=BgttqP6ilbuo31nfnRW1rBf8CiuP09gBU3kVTOf8Rp+R//9n4zXYE1+z2vNPAQApH0
 8+cOxBZN4i/D+REFkNy3ew4TBufB6ZjEwzfhPb0BDvXvZzDwSsS7OLTjGQvGjWZuQgjv
 BsuaYTnjlg9buSbPpiPBw57U/F1zu2TSGS1fS3UnjHOxaeSbnngyJccSj8+uELLZC7Js
 BiQlQSqDLVjtSLOqbdrMIXHyAAIkXUgK2XwgyOqP7HEXZCLPB2LxlYY2+pVySoeeSMtz
 OrzBrHPoLKGbKt2PDjrRuqRmISQZ9LpldwGYpZGX/6qSBybL/thKTGmiGjvUginHS7Ok
 F+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZcazbR1DE/nxOEeZq1x5Zwqj0GPkDpZzY4fxC9HT/k=;
 fh=tm3ws3KpvnCXHWOEnUaoyqTCmywBdCbhPmtQeJfLG9w=;
 b=czkjS9yp9Z4H2jmoF0wCz/KZOGt0HJlVPNp3d7lD8UmsC0dcYj7SRGMWu/vQDwVvoY
 1DwgQqdQWJR3cEOOzslXgvJmxrgn4zuuPYfcWq+76u1B2RqMZWRlzw81tCwyqE4QohXS
 SbcxFilTouMhTIRiKKJbRjFkUDZwwQakHP9AmW3Cb3BPWTaTfF8AFb5v/i0WrhDmlPQk
 mAngYrW2UqLV2jkKkpEbYB3vpqO/mr1tCl6IYAct8cockGTHEn47xJZfvkXnrx1G3sRM
 y2VKFBxkd/Z7++/rM1ofD+zLSj8vEHUSqR5rqPZijAQWfF9h9pecv+UbI07U9vKiiTOa
 FJMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772124763; x=1772729563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZcazbR1DE/nxOEeZq1x5Zwqj0GPkDpZzY4fxC9HT/k=;
 b=I48kEQ0Xg6Vb2T2JhV7Ls4Q85cYsznVwUTqzNvViBBIGbC9A3Wian5OsxFO+WB5jgq
 wm4MDtdlMUT02G7c4sEFvkjfk8d2kJwdr8vtIu9u8172gDuC4AxcjxUehs2JZagGerzB
 APnmbRgPPeZbwgVmKOdxgWgint3zMkd2BNT8EkwEOyGp7yHTpdV1Rxi3TrpKMb2i9o3F
 pC/qpoTMWQEj+0Q0ut7W/yx/guxLX2BB7MG221q6qrWBLhfk3BjbYBrC47SAGHUxEp6h
 2SheJ0DPNFdTOmf3/KcRI6DsI0DHX1BBmmaTJjkzzySui+VQ9o29x/rBE6RiGdaFpmxw
 DIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124763; x=1772729563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZcazbR1DE/nxOEeZq1x5Zwqj0GPkDpZzY4fxC9HT/k=;
 b=oNZ0UhnP8uCu+0BsRnM5CsdT8g1rNl70tSNNr0X7EqxZrsC/u/wbot+pVp7fY5qWxp
 izL8MmufMfLtqPSS5CgTeEYK4ilBqBpenFHP0VV5abqJJYogEqpCiiUpf/cCzpG2t79o
 Madh3HSt1LbC4HIeKHuzfh1sg1Q3JxAUFar+Ew2r+oaK3tGRY+siqRpQutopk889iEBd
 E0f7WtEdv+gtdg8JTvDA3LunaZHWpMjKe8yW/aoNLeEeZ50+MQZ8WoPgFs/9ryPUmCQK
 jxk7rORnP+OBYs1fo8ANa4KvcITpIgTMxBP3iTmFZie24QQfC0oY11Fn7NE9eefST58o
 lrBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV323KJ4kNtBREnLVsSvwh4tZsJYseD35bc+8AyP2v8V92YvqasQ7OmtK+cZlQPOgIrdeDCs5ZD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYCbb6+lj/VLeY3i7O4oV0iEV1ub5gb0BG43DtFt+MpVudGMn2
 v20gvFlo5Oq5Xkts09pIjJ0bQfgaOgEyQDLmiyuhhrI5LwhxF6P6gDiw+GQBCx0xh4tImdOVXZQ
 b9dFOUGfmQext9HXvHuysM113444oGCk=
X-Gm-Gg: ATEYQzxDVN/ww8Ve4Vs+N/c1OXDbZj6XHl5Ywh41sFmcl+zG8M9LZzGfmt6EEHTPLaf
 xrpxkHaNwMgk9s67EYUDxeummrUmLZ6hQGw8JW+GM6gBnZ/HUSNN3gSnR09zS+MbSUT/KWV3kbF
 goqz+igE6dYV7CLit/BQst88A9TwnKytop4GArLOLzYutQb+CJcoyoo1Xdq9XFswnwXpjUQJ1A9
 3PREfrewHsGBQqPus/gAjgJnHysW8SFut3s2rwxnQVow2PcuUQWvMEn57HHduMCcsyQRi+Llyua
 hYQ6rPgAqG/9TLOLBJIJAP1mwmCNeu0XD0GUkkle9CGEz3hVE06/JRFYn5x4UsKEEfsSOg==
X-Received: by 2002:a05:7022:521:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-1276ad1a953mr3949889c88.6.1772124763232; Thu, 26 Feb 2026
 08:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20260226030038.1182961-1-yujie.liu@intel.com>
 <20260226030038.1182961-5-yujie.liu@intel.com>
In-Reply-To: <20260226030038.1182961-5-yujie.liu@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:52:31 -0500
X-Gm-Features: AaiRm52jUWhoVzS5sZVs0p1S_kaUAgI_vRYo0M4j1pIdWaWT3Go6larHclvpApA
Message-ID: <CADnq5_ObAojo6i2gwJR2Q6aL2gN3WEyxC5Uo_=yfW=9xqdndnQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amdgpu: fix kernel-doc warning for
 amdgpu_ttm_alloc_mmio_remap_bo()
To: Yujie Liu <yujie.liu@intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
 Gangliang Xie <ganglxie@amd.com>, Candice Li <candice.li@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
 Michal Wajdeczko <michal.wajdeczko@intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org
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

On Wed, Feb 25, 2026 at 10:09=E2=80=AFPM Yujie Liu <yujie.liu@intel.com> wr=
ote:
>
> Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1923 expecting prototype=
 for amdgpu_ttm_mmio_remap_bo_init(). Prototype was for amdgpu_ttm_alloc_mm=
io_remap_bo() instead
>
> Fixes: 96e97a562d06 ("drm/amdgpu: Drop MMIO_REMAP domain bit and keep it =
Internal")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index eeaa56c8d129..9789b778d491 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1908,7 +1908,7 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_dev=
ice *adev)
>  }
>
>  /**
> - * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
> + * amdgpu_ttm_alloc_mmio_remap_bo - Allocate the singleton MMIO_REMAP BO
>   * @adev: amdgpu device
>   *
>   * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
> --
> 2.43.0
>
