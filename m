Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D3C43327
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834A510E19F;
	Tue, 30 Jun 2026 07:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S64bhzJE";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2238610E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 16:11:27 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7fe4808741eso36574857b3.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 09:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782749486; cv=none;
 d=google.com; s=arc-20260327;
 b=giXNiTbfcbpEW1uyr6P3SWW8iX6H/lCrtee+IHAEtwXTEIwUonIBmGeSADbOdKbj5t
 4ai27XNikMiNrtFP8hCZdOrjJ7CFqPErtFcDjxXJoOyC/XbV2e29KCqr9AKLKJ9vjSUA
 LNEGsV2aDOiyRoBv1yOJh4HW/XSY9LQuq0/cY8fH/C2iUrOOFTIxvBlHes1bvui06v4N
 L+iufbRfpJOuKOypbAUhL9YWxStsI11uBRw9284X/yQB6M1garXDnDAWz/2tSJ4j+tey
 BGT4RTbjl6rQrRQZUE0Q5qz8ONNMSG2UvdFgYaQj93CFmtBrSdZGnD7IsI2UV5DFi2Bf
 iHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 fh=yfkqUbls+AZqIh2sqP2waD3jqGp5mCg/TynTJPzWqXw=;
 b=StL36okSxdqZqB3XMDD4I1ohf/OaHhkJzX8gC/DGIeGOXbERtFSM+Y6kgjsYS7Freo
 OwoerV5WwEoHgcIM6IYGK8hQ6qo8YBz7UMb0PZYTWo6x8wtt0uMADm4XTwfooYm/RFlL
 c1nBHR7PizMZhDZ1EXYpqcepsBx3F/Pm0yKtkudrg6y4nOcy0t5Kt2Pziq3UeOBSmYo5
 GA9umumvqv6bbWQVki5zmGhDFFO49OxAslOE5nQuDTUxiYygDOxCOQMEZgR+BcqlBSwr
 xhikZTLjqKY6rRT6mqLTueJgDd01dr2e4hOrsD7Umatpn3wNJMCY8lR6uNG6WXtRDceL
 836g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782749486; x=1783354286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 b=S64bhzJEWiypbXInEkOvudDhTB0kIhPy4Nx6RCKhQDcyIU9EwlIpUe0c1Ofre6zmhS
 tqRI0VspWwKOorUwxyBNcu/C+DThmfmycFy/py4sn1jYuL6b5k2+Fc33KS1G1uN5x/mj
 ZAg0/SDiX8qN8WO2KjP/5pweFgWC74m0xOaJRU08/tgod6ZYTAzMuAMTuhtBzCr86tLX
 YbIC0tFuo9GyFFbi0KIRe0rFd1S6ZJLSMrdqVOu0XI1InTBKneHAuRixJkcSTk1ZaoXV
 T1dgqAzaYhk/5uS6nYCxHBFjCPNTgkwWrh0qQ3aIW70GwR2O/eKizYlEvKZV3BPWblsK
 AXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782749486; x=1783354286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkyoBnzoIQerSE+/V0M26u2wrPFOgYsVxxOErmVrYLE=;
 b=hn6kDMf/DudXVs//gIUDun9U1GF/nwGnzu9M/XK/lr8h63EYvzLqoElqtGCnwwn1dd
 nlIAoCITdrXR0Ob2EGd2SzjehRmVEY6s8+TZGDWLcAYml8GQNWfrKvtX8+va/+8sr6N1
 LVk0zPuoNCX6Ak3yGSm+z+uacfWu87OxI244BeH5NCk8lPQmw0kZa+5l4A9jJnfFLWgD
 3gVWO0OpDBHP2htAmc0neFuhZoHt68EkSYv7lSV1XK8YBi5AGNg4QJg0nmUYE8fA0kb1
 xra6w1pfodhOT/IkrVqZqzQEpL9Bl5SKUsnx0cqXsR94Z+eFSWPbT4G3ObOQM3Cg00+8
 Fu1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNxyMUu1MU2BK+sGJ4RCxyJ0xDs2KrdIZ2kFaX7EThDzDjgUtECaPQSK6HwX4lX/lV7tSI1MYg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE3TjFBBRowz97P5apjNjo056OjSrPr02zc3ffRB4W7JbtJZLd
 E74SZnxlunadGFIay2TPCgxOb5YjSWJxLU/eJlwTgKS5mNqorI0Uvv6yaaumyNhMMR6xYUsLQW2
 Br0ZMHD9CWcnAPHyeSBmW8rfRPH5WVvE=
X-Gm-Gg: AfdE7clz75yRYh/FlaXiyjUi1HXaF/FvrLqyKjOux42ukd2EwRkKlBbqq0wK+439XjT
 tQur6FlxTCE1OLBVKs+cmQk97FpVnBb0NTp+29aoaJxOD+itgKlINiFSaLbONBu3I1GXDeUhaKm
 g8F1JWmRjClT9BdCH0PhQDnlVM9SXvQ5bcK1OCHss6CaNSjBF8LKYTd+CDSW6csjC6ATFcEmwia
 EFeJAO0jtNnQB1z3jq2zvBJG5CW/kczUhIK+zmnJ0c3FGyqE89CpxtF6uoXSo0mPFfpGZn0
X-Received: by 2002:a05:690c:6c03:b0:7fd:e030:23db with SMTP id
 00721157ae682-810d8edb122mr1823157b3.31.1782749485666; Mon, 29 Jun 2026
 09:11:25 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 11:11:24 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 11:11:24 -0500
In-Reply-To: <20260629152807.13492-1-alhouseenyousef@gmail.com>
References: <20260629152807.13492-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 11:11:24 -0500
X-Gm-Features: AVVi8CewJuorlk7vVm2WjIOaBKBFN1AO6yCKlkqQYzjQNGpeFQjuVHfzv5rEKHQ
Message-ID: <CAMuQ4bXQQYJb1nAYKJUtbz7WLi_oMtVyCSpLPVKmd-XMdG0wyg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:28 +0000
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

Please drop this v3 as well.

I rechecked current origin/master and this fix is already present as
commit 93475c341119 ("drm/amdgpu: check amdgpu_vm_bo_find() result in
GET_MAPPING_INFO"), cherry-picked from 528b19377aff. It uses the
existing -ENOENT behavior for a missing BO VA, so this v3 is obsolete.

Sorry for the noise.

On Mon, 29 Jun 2026 17:28:07 +0200, Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object before taking
> the object and VM locks. The object reference keeps the BO alive, but a
> concurrent handle close can remove the per-file BO VA before
> amdgpu_vm_bo_find() runs.
>
> The mapping-list walks then dereference the NULL BO VA. Return -EINVAL
> when the BO is no longer associated with the VM.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v3:
> - Generate a clean patch against drm-misc-next instead of stacking on v1.
> - Keep only the intended !bo_va guard for the handle-close race.
> - Clarify the v2 withdrawal confusion in thread replies.
>
> Changes in v2:
> - Describe the handle-close race instead of an initially unmapped BO.
> - Return -EINVAL instead of -ENOENT.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 27be5083f2af..83ec994ad36b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
> struct drm_amdgpu_gem_vm_entry *vm_entries;
> struct amdgpu_bo_va_mapping *mapping;
> int num_mappings =3D 0;
> +
> + if (!bo_va) {
> + r =3D -EINVAL;
> + goto out_exec;
> + }
> +
> /*
> * num_entries is set as an input to the size of the user-allocated array =
of
> * drm_amdgpu_gem_vm_entry stored at args->value.
> --
> 2.54.0
