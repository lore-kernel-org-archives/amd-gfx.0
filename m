Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2CECCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 20:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E647110E341;
	Tue,  4 Nov 2025 20:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6uI6V87";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB1110E341
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 20:54:21 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26808b24a00so9064635ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762289661; x=1762894461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38CS4dMLyTmbuMX/PTgsXw2LlPgZlPhvukBjistHz9k=;
 b=P6uI6V87nffqyJCdjhtZPqSb2469CNBz0vTJ77ZwmQRn3uGi8x88KQuDEAQCyUS48n
 B+g5AuKRg7aBc9/3Eryje4Yg7SLAeb8cvhccSTbTHWtI6sSE5NjBFbuUCx7g7xeu5kO/
 VExMJGhLk//VsmgCPOP/PF9/cTgrOgH7m08xx7Oj3ex+3EOXcfMsFLBIBIjvPCi2GnLw
 V5uvk3Ha4d1H+ncrOgNMCe8G62J4eDfa+m+Z9EAEEGqZFW4M5BNGSiLPqtDGvH/NMJhc
 nJKaijGZ6p2GOlZVlm1fZXlt2TKnP/xwoYspLeR1IHqjPPXlWi0/cvTho9VZXoiug8Rw
 xIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762289661; x=1762894461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38CS4dMLyTmbuMX/PTgsXw2LlPgZlPhvukBjistHz9k=;
 b=jb/PSDxvgxE4xfl3R2bwTCwaVgwizYSULsjDM6OaqFsXavbKecdfeLH4gT2OOmFOTI
 1lchKT5loz58iWIx+Q77VhlE6sUQCZO4FHujVWaNOS127uJuitJR9y/PoH9yg02OQM2u
 RVbnWYLM/YiVi/e0t1YWMIh5P6T/mQkZZvQSheRoVfhHpImGFLpa4emC55WQxCv3T3LG
 8Kr0B5sR2RtVkdyZQCJK2QBVA51n5ygsx5cIK6Fav8/jMoKdltn0IwFwAHxSqZjodLjF
 ty0FfC7ueSzO5H9ZvMbpF80Nk9BIVCzTqdMRLxo1Nfd1APR7brxBlGrEiZkKx4YNsJP5
 CQ7A==
X-Gm-Message-State: AOJu0YzeAEe2W1Yx3/EC86K9krHJCEy5fc4//qh/fG14wzp16RH/DONL
 aS1iKB85/IGlKCGhzc+y5aQ/pEyBwqOwbPYnOleazFf/c0EmJxt4Oa0Nv/H9vd0XhpevYhEfy0e
 IQZKXD7KEAyVHYa9tgWW/7S/xulPzD4I=
X-Gm-Gg: ASbGncs7SgnQZavMto4wLHv62bKwLtCBOTS+16fD8b586HX+YAmJpknPr23b9QCZDsF
 jYJ5t9Qm84DAHopD3kj6RkyG63IEAh/e0k0y66oKU3MafaeEuXBwEXdPXL+3vzcyHvrA1/mbW4a
 U7OoKT/qpmvxaLW+y8fQO6RU93v6pyLIChgxgfkM6iMGgHX4rB4HhBgBGHhSMPTAChFn+fkg37p
 xeYKxKiM6E5Nefb65LiK1Os40HidhdjKCWHUsrYXhDbL7Q2vhCkkcyP23jf
X-Google-Smtp-Source: AGHT+IHHMKU61LBsrixlbXdXn4URT5baMbS/qHn+uHmdpJlefWeTpe7yKriq97k3AZ0ris6eAK+5YbdsWTjKwW3T9fI=
X-Received: by 2002:a17:902:f689:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-2962adb116cmr6586445ad.7.1762289659646; Tue, 04 Nov 2025
 12:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20251104163932.263193-1-David.Wu3@amd.com>
In-Reply-To: <20251104163932.263193-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 15:54:07 -0500
X-Gm-Features: AWmQ_bmWNnzIXDn9yGQdjMBxlVo3zf86Lejmrt1GGYrkwSKff35q4ej17tifxZE
Message-ID: <CADnq5_N1O6Yy77tZgWZxDb3Qv7R_e2M=u+HxKX6Px-WHy_SuKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: check NULL pointer
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com
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

On Tue, Nov 4, 2025 at 11:56=E2=80=AFAM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> bo could be NULL in the vm->done list and the
> access of it must be avoided.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Sunil already fixed this in:
commit b15e3cc46803daf49625ab3289d103c437310ec3
Author: Sunil Khatri <sunil.khatri@amd.com>
Date:   Fri Oct 31 14:10:13 2025 +0530

    drm/amdgpu: validate the bo from done list for NULL

    Make sure the bo is valid before using it.

    Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
    Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index cc2f96ed7004..d0ff226c6dc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -943,7 +943,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_=
mgr)
>         list_for_each_entry(bo_va, &vm->done, base.vm_status) {
>                 bo =3D bo_va->base.bo;
>
> -               if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
> +               if (!bo || !amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
>                         continue;
>
>                 range =3D xa_load(&xa, key);
> --
> 2.43.0
>
