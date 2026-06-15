Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF5CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 18:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC0410E569;
	Mon, 15 Jun 2026 18:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OymfvPub";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFE010E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 18:09:52 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-306f1213aadso325107eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 11:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546992; cv=none;
 d=google.com; s=arc-20240605;
 b=Y0GZLDAQhCW2rNzVm7qlXfXBH//iTd96I8ajXTmt/saP1NuFSsBZXXxACP0oCVS2ty
 DcFoJ5pzIWxSTeeWiFJ/GRAEqQAErVfzOWgk++Z0iOalHZyZheLCrjpjwqQbYOX9TyaP
 xQGm/2zlCHo6cplmO/UW84qnXw+LQYmZ3WnGLibZ2CjE/9cOqfSLBMpJtzDdFfM8mSxQ
 mAt38Rm/UCeaHNEs/pW6bb2TjFG48+wVRVUfEGZtnLGNbMpJD7EoqyIV8cinwJPnFzrd
 J5DJhOPi2VLSKrgwHkMbdmgN3adbE7DCcfkI/rFyjrNrtFX8dFwSzwcHHGuOn7Jd/wbg
 nE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eHZFXT8A0K9xNDtUJk1t/I9VTM1oh8bKg7wxG564NaQ=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=L5C9wM6VmyPVSj+yxGOQo9RJVe/yxJV6KY/1uDh8z8gZXAcpM9GsxuJGkR8W6jKrLB
 eNU3TIO60rRcYSKEMbKVN0aXQHmbE5W8GO69lN8UbvopQCMjTNoX8KZDQQrtjT1ygkVS
 z5oI5anHsjl+nE76h4TmkHL1yywSimXfA0bA2RmMcRQlyPYjeIrbpvXc4exaTIondz+T
 RLsmymN3LwAs39QT0IFJvUZOfwlo239ZMgqEgsGMdJweoS91nKlFxT3ym2ZvSOoOLtwJ
 foVhpfKg82cNACNKdPedvtDVgbDL5OijO3TOhP6+Zf4Sq9/BJrgPbQG0uyqF6lXFkNOW
 D/9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546992; x=1782151792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHZFXT8A0K9xNDtUJk1t/I9VTM1oh8bKg7wxG564NaQ=;
 b=OymfvPuboj5+UTl4zF/YbYmH8CvDC+NU7+5VN0n2d5M4r+OI3ORQ5rMmATsfa0ckDa
 lL6P8y0sarH586AlcH9ZL93Z4jeAJGZUtF8/t98djxslHkFHhEl0nfjk2ZIXe7b1aWm7
 ym9w/DZTzJCM2yRvgct7OgzWEJEYJPYI+YfXZWGEXJPjlAvdMxaVOsndKFyMIr8m1Gon
 zVBKd905wwxgjnxKhNwALFVDcWPDpRQ5L+PjH15f7wPZI92FzW1JkXkh2fqt16rT4KhP
 zVypJ5p/xQvVr5Kv7PUyo9A2m1ln+5Jg5LIYIjzwkhllsXwdd5dK1Roh20GCLwmc93hY
 ou2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546992; x=1782151792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHZFXT8A0K9xNDtUJk1t/I9VTM1oh8bKg7wxG564NaQ=;
 b=hlLNsYShQrs8KdV4UvekH4EJLqBrdCm7wZEEax2+JB7G11Bfg872flwDZNEGT5lg/2
 LVc7uYk7qd9DxGVv67oStUGzMoWQ8h/eFl/qEhzaz0q5VPAZox++TP8ANXp30VL+qI+j
 3vP7vmPFI7RgvVqctIZbaj4kZrTG41wTX7J/ueTfSfMRC8S4iH+I0u/o4+uRFhPyBUy7
 yx/2Go6HlRoDUHE1PzS0cOZeFmSthdZ3v+nMolKjBuwqLwLcTotK9Y9wihz3AaDkEETL
 OqxnpYQWQoF2/WZCT+tLiDqT9AQ+vcpG0ZBUbkddXhmjMVmFT6ga2JH68F3uO85O3dGC
 343A==
X-Gm-Message-State: AOJu0YxsWRib+gb90KFllU2VbvG4ol+N+knH3KDeHN5e4x0jHYgYRbaK
 GjuOj3dx2qNAWKEXXWof78xJpgoNfnA3ZQY8EVAlsEA8rRKG0CigC1jKpbXlfQCJAqyFEhhbhpu
 C97fa/h5QVnLsH39iByBjtupIvpqXmkS5WQ==
X-Gm-Gg: Acq92OH7JaiaYopL1wNrn6BnNibRJzxXZ4SddZwDv6R+hO9EkPP/WXipTuQwr3KUr1Y
 MDP6B3MSxgHmQZPccBo1Pm/MrrLHGuZz+mkyGWgkUQx8IavIurMR5FJsMzn+oioKi3UX9vGo80a
 kNRlhfUx7+QrAHcx5PxXHRcPiI0XZUe32KA7XnO4liMbLpr+TX5pT2YU+ZazGBksXVR6rDeuBem
 y9lbBpRWcvxEGg9hE6cppR9lAg9KTbaqt8wRt0zHqWycGUrXG2ReDAuPPvxY3f6h1/ZzQQXDHw1
 wY5inSVH9gt4LCge4Cpzt43OimvfenKAYudybLW6X7NQgf5+aWxa3e/hOtxmEufo0ONP79ZciGQ
 EXGS+
X-Received: by 2002:a05:7022:38f:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1384bb9ada0mr3131113c88.3.1781546991947; Mon, 15 Jun 2026
 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260613021153.1136397-1-mario.limonciello@amd.com>
In-Reply-To: <20260613021153.1136397-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 14:09:40 -0400
X-Gm-Features: AVVi8CdoZIiwh6GR-WdNnlXWFAHF5y2008ROQMu3RQ6tVW9x_gJd1ZwNoQk1LXc
Message-ID: <CADnq5_O-w46SSK+ESizm29b_yQa942jw3O+FdfwPJ-AgdqFkWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check amdgpu_vm_bo_find() result in
 GET_MAPPING_INFO
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Jun 12, 2026 at 10:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The AMDGPU_GEM_OP_GET_MAPPING_INFO path of amdgpu_gem_op_ioctl() looks
> up the bo_va for the buffer object in the caller's VM via
> amdgpu_vm_bo_find(), but uses the returned pointer without checking it.
>
> amdgpu_vm_bo_find() returns NULL when the BO has no bo_va in that VM,
> which is the normal case for a BO that has never been mapped. The result
> is fed straight into amdgpu_vm_bo_va_for_each_valid_mapping(), which
> expands to list_for_each_entry(mapping, &(bo_va)->valids, list) and
> dereferences bo_va, causing a NULL pointer dereference.
>
> This is reachable by any process able to issue the ioctl (render group)
> simply by requesting mapping info for an unmapped BO.
>
> Return -ENOENT when no bo_va is found, jumping to out_exec so the
> drm_exec context and GEM object reference are released.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 22ec4eb6e17f8..28f89ae8ca745 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1094,6 +1094,11 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>                  * If that number is larger than the size of the array, t=
he ioctl must
>                  * be retried.
>                  */
> +               if (!bo_va) {
> +                       r =3D -ENOENT;
> +                       goto out_exec;
> +               }
> +
>                 if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
>                         r =3D -EINVAL;
>                         goto out_exec;
> --
> 2.43.0
>
