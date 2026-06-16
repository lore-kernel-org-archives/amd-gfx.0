Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13498CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 15:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E15310EC61;
	Tue, 16 Jun 2026 15:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fHP4qTvi";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA7F10EC7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 15:33:10 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-307b668e1f5so374599eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623990; cv=none;
 d=google.com; s=arc-20240605;
 b=kTQXZkEnioE5gKrvDFA7Hpzx5mb0FxhuL1m/FOKKcUTHXF2qNuw3hrkcZfvauBvMyW
 lj5kpem4dResAxu2M/BSndpaLX2FHmZIfvNcwF3WGhKJg5cQRf+cI/zphRlZyRZcvFUf
 fbuk6iKbRz16vZhLhH0aQAYDsc0Y7Rt5jzxOLVO0VttZmXlFqdnxqSMsmCXUT3IUNVsq
 G8pkZLquJ93lPFDW7EeSh/SFbW9XryqPqNLOXFjVICjpprA55n05NRPT+Q0SRv75Qn8N
 3mp9w2plvJMaipNWPrBy0/0kbqXggcN3VhR0ukqCQRUO5jjXwbgY896En+1sqMQAJxLs
 pGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ul3HEHOzQoFRGqhoek6FSLJd+zuNQfA61jocPxfdrhY=;
 fh=B7dLQc5CrYeBfy9ghHLVhK1zIppwkljE6nqwDD1LkI4=;
 b=A9otQjUtrhqx+hLNVUZQUPKUuiSsPM3r40a53skH4MQO0YI8ze0SUQ3qanPh5fMnLA
 3813y3sLPGNkr+kixV6UpCVwOCfgfsCDwdIxUpEkzQUtyb3Nab4C/Ll1muKN+xfYYkc1
 VKzjVktcDSk1eNhH3U6u4ckmvkvnbBph4gh8ac8zEtJb9A0lr0dKp/zdG0J2oJDo5gVp
 GsZwBuvDL0SVvPh6GXegqnPQhVtqptQ16toUvKHM4ppzDiSUhBHOHvFt6A+Rn+C6RvOI
 R6PHF/l9+HmEZ+IAY8aBJf+TQilZJOm+xin53UuoiiQj/QqjlrQHkc7FH5eDfTGSRknC
 OAGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781623990; x=1782228790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ul3HEHOzQoFRGqhoek6FSLJd+zuNQfA61jocPxfdrhY=;
 b=fHP4qTviPKwGRdmF/FreqZiaucnReYQL5gajJUhDrGujZfMNCgOQ2kMKmc6FwQju+Z
 taPm9qeGPYpEH3EuGwIlwVBsvRQgXtI0SUHvs7TJkyEV1U0B7XvkCapsZDt3sWVk07jQ
 2j/gIYgHNxaz+/EUQtg/glfZhvyjmKTYaAstymzfP0nhKl0gJw4NvvTdYqh+Xht4CtwQ
 CPKN9DYU1MzXjvVUzW1milcE+qA53gnaYSwAKo0HupO9uiXQWwXQOKxwsSnW4zxwWwbi
 2800OnYJfLWKQvyplLlOgAbn/QDtZHYU6yK4OJDSPgX2k3hNTYgugi5DtGfsMwsDGg15
 r4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623990; x=1782228790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ul3HEHOzQoFRGqhoek6FSLJd+zuNQfA61jocPxfdrhY=;
 b=IWalfGQvHxZ8vD47NpSO5uNqphD6pibSiZMyXAoSkJqqtQ9ZacZZZInWrOJZ7JkGHO
 BG1ds6xq7lsQ6RGzFVDrIRzFEdNJAfP2MIoyd/sOC3yRVWyHXW2+Hb/VIlC8T3b8osY3
 DG6NHwLlTFstz6PoxBRwrp15u9hY2ztBbQFKXiGJqqI+W3/PNXPrwEwS9WsT8HeU4hsu
 S+7bX1FIjgJeEX9q7oVtnIPJP6og2dRtrEUrDdnNO9Z0DxrSvTcB0gEzZY/SZr4mZ3io
 R/uqqQE4ZGqahWtcxU8imMRKM8OVnmXDhFerqYtGsmx3AFPdO3PTiscK90kJhckJidF9
 rTNg==
X-Gm-Message-State: AOJu0YxGks1OIKO+bTSgJCMOonddhvOF9IuW/RyXZ/vN9aE8BuPngl59
 zT7QZFb3QZCHgKXOHv3qS7oF+oybe7FEGaywVtrjq+WIUaFZ0itMJRmKCjGcnLPG7X0K+pW9+nq
 DM5k30XE23i7wQBg6uxwY3blJbU/vylY=
X-Gm-Gg: Acq92OG1NgQofb9gxCV9J/F8rAwt/jyyKD2cGjmLAhn2F0keToPxdFEhLOdKwaT6doS
 TJi67PqXPWjihPH1lihg3biEz0wfhDX0ai4MUYsIPXEU3EqLgCLtu+pOXdyIiipgYMsUy4uW5db
 PFv/Tiqvr3YFUhq1Q5JUAFEZ7mcid7l7VNoq7zsr5J6zcpoZk1kvUATepHM5qjSkHLSKsp5McFZ
 auLeIx9LExeXC3Y8CEqR2eo/rnzNM4EBq7uLa8X95KTqGXMo3yXELusMcw5m2T6hATyPqVfQ7Cd
 uTA77TU27X8Q0RbSUWGZlisDX9k8c2I+RgrGV0ZeTujoVloqdqAeQJ4FehRay9G0gVPePw==
X-Received: by 2002:a05:7022:f86:b0:138:43f1:e491 with SMTP id
 a92af1059eb24-1384bb979abmr4564469c88.6.1781623989250; Tue, 16 Jun 2026
 08:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260616151253.303003-1-xiaogang.chen@amd.com>
In-Reply-To: <20260616151253.303003-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 11:32:57 -0400
X-Gm-Features: AVVi8CeKrl6qsCldd3c1-Zs1PJQk1GZf7WBf1LrnNH7r7m06JpBn1wmkbODBNJs
Message-ID: <CADnq5_OYNUifgMJFsy31=diLbyj9-bpXZX7HVfa0Gn+2BhOVCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge
 page alignment
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Philip.Yang@amd.com, Gerhard Schwanzer <geschw@pm.me>
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

On Tue, Jun 16, 2026 at 11:24=E2=80=AFAM Xiaogang.Chen <xiaogang.chen@amd.c=
om> wrote:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> The last byte of svm range is included. Should use last + 1 to check
> 2MB alignment for possible huge page mapping.
>
> Fixes: 448ee45353ef("drm/amdkfd: Use huge page size to check split svm
> range alignment")
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> Tested-by: Gerhard Schwanzer <geschw@pm.me>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 25b3ecf85f30..20ccdc4dde6b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1144,7 +1144,7 @@ static int
>  svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>                      struct list_head *insert_list, struct list_head *rem=
ap_list)
>  {
> -       unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
> +       unsigned long last_align_down =3D ALIGN_DOWN(prange->last + 1, 51=
2);
>         unsigned long start_align =3D ALIGN(prange->start, 512);
>         bool huge_page_mapping =3D last_align_down > start_align;
>         struct svm_range *tail =3D NULL;
> @@ -1168,7 +1168,7 @@ static int
>  svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>                      struct list_head *insert_list, struct list_head *rem=
ap_list)
>  {
> -       unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
> +       unsigned long last_align_down =3D ALIGN_DOWN(prange->last + 1, 51=
2);
>         unsigned long start_align =3D ALIGN(prange->start, 512);
>         bool huge_page_mapping =3D last_align_down > start_align;
>         struct svm_range *head =3D NULL;
> @@ -1181,8 +1181,8 @@ svm_range_split_head(struct svm_range *prange, uint=
64_t new_start,
>
>         list_add(&head->list, insert_list);
>
> -       if (huge_page_mapping && head->last + 1 > start_align &&
> -           head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, =
512)))
> +       if (huge_page_mapping && head->last > start_align &&
> +           head->last < last_align_down && (!IS_ALIGNED(head->last, 512)=
))
>                 list_add(&head->update_list, remap_list);
>
>         return 0;
> --
> 2.34.1
>
