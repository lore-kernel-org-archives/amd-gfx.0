Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B8FCD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7406510E816;
	Tue, 16 Jun 2026 18:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E4zUtX11";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBFF10E816
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:54:47 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-306f1213aadso443336eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781636086; cv=none;
 d=google.com; s=arc-20240605;
 b=R82tkawUshn3kGieGSrVHMYmkfUM/I9tMV26MxvOwRMweMqViA0Oelc2jEiMZWGcs3
 AveJYdHtWTEKZF+rJuTYFsUewoCeVXeIeTPc0BqG924jk4EqfBRo6iuEu35CEDl+SicC
 YfC0eRuwm2q+RmQMxmaq8Me1fkOWoXcjnBJ2uLbRgi0G2t2+lQ/fpudRZtOjxFRQWuzB
 dZFitZv7TR2vYau3IKt7ypFAdlL6wrkiMy/GunJMyB3TV+a72hYACC+KtwdwoEWfEoLl
 87RqZtXKPiechiRhka8HBK+zPh/buA63JtcaDmeRIpfI5tBYhnIn+Qn41MNQGaVqql06
 Lp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MCOSiee7KXjPkCFlHhQFxxSs4KWMyl8PnWZ0V0RhntI=;
 fh=6Rq3UneHV95hylUZYAnHyFMBUQ6GQHaf5Xr7W5qpcz0=;
 b=aBWEPKVsdOPO0PCTPeFXCCSHLs5QbkT6Q5qIWyQuPRSP/aGlLnMzP+w4/hRu7vYJPP
 DjY96rSVfdff/b1Kndi7Y08KzzDVVuo8kkCmI004W74YpT3ngWyG8sbMx/G1Xx4xV8HR
 tAxsTP16NwQgfs3P9Yj2nSJx0UX+kLjJC0Ii+OdRkWmzgf8SYERRWIH9vn6xWRhQkVpU
 l5KSz4spSYbejerQfzA5JJruCZiKv6U0dgSsrM5U4RrUzMAKvRNC2yVl+qN8afXjBDbF
 YcyH6hskmaR9htKys38X+lojH96VUl/tW25biE4gdLqXsjKkacR9s6ctY1sgwN23JAkL
 nhcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636086; x=1782240886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCOSiee7KXjPkCFlHhQFxxSs4KWMyl8PnWZ0V0RhntI=;
 b=E4zUtX116r2HCAnMRtuDa194DXt6ERShHziDcL80/+Nhtec3UGGlRNiBSKs+SJpxc4
 F6e1Bu2FIjEd9puuZcSxgy3Pbwpt16pTLmCH1Fba+PMUhpyP3Te3loZngE1nJLBEVBSg
 xeAdRiVdFIyGmuvU90yM9fczcInpuuRiah7H3vSij7r1jgmJNDphguWjwiWoG2imxz7Z
 n5pg4dW+ejJ9XKOrOYzaCS+btllL8ZPR4WRkKyyEr84n5ItyoXfUJOYhWwpQFNTHMGIP
 cXvqAArdAHBE+ECNOK49pRVA2MqKnWK93EGR1PHAw7k+yYb25ByBDXToQv9Jvm0C+oAK
 YcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636086; x=1782240886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCOSiee7KXjPkCFlHhQFxxSs4KWMyl8PnWZ0V0RhntI=;
 b=FHkxNwk57UdzQglZW/19CZykMJpBPW2ZxWmFmzzZERgokgubCoaRsPW4LMiPK/sgHM
 RtNvI/N/t9Z/d67JKmghf3fKz8So1bX1MSuPWC7LxsC+TJrYOm0zKB871z/6N9075G46
 nXJxI3HK4t8neYgbMe1wvMiH74LqXkIMTvPBm2m/hB4m9m/v1SoA/T4mmWfZ/5YQLiV1
 uWzFKkyfwH4at/FM5YNQuaTJLGLeWWxG5weYIHkG8/rZT7e+hhwc1sX5sOREK6riK3rF
 hafvU5PxbASjAPK/gvYDgm96xTngXYUbs3u1qFeIyHi9mMWsBqMOWxN3KCY2+PCIVeD6
 WL8g==
X-Gm-Message-State: AOJu0Yy1yvgI6nUymr60uc9FI5QckeTwiSfhscxgKKbZjMCNSVmWae9m
 6ywVmPulXcF3Y2Js6rZw9/cn4l6jTUMXA72rJVYUI9Oc/lEhmL9qP2mjmE+vQ3XMLL+9v1qBJew
 nQuw0nTgSoe6X0LcRBv6qtj86bvot1Cw=
X-Gm-Gg: Acq92OFsJsfo3xkcpSToY1YJXbiZt2vZyV0+K9hA41R+FTlcpZjS5itcI/AbC70MGeJ
 Kf3kBm8S3yV9IOezkBOO+lZKrDlpUsItpM3fRSxTjquhw5XSAxhdO9bzCLNfesUScG8rmtNWN5j
 JwwnxPcsnYxldL0SIkc7730HftJ1qRMxYgeTEdUzRlzD1iuartuDdTNXKmYunj432akCcR+7xfB
 E7shwH6KPVUxuN1sjuwdNccTlIPmkYFUppgn6xEeNaQ05bRMD6XRBZFChxknCVUYs/skIUPRJaH
 XklwBZRZjQUPsxO6BSxDdQDgFIL29WVty0f7geRXKZTbH5miU66kWy65UIY5VDTr0G5ahw==
X-Received: by 2002:a05:7022:6981:b0:138:3432:4f6 with SMTP id
 a92af1059eb24-1398f6c603emr40953c88.6.1781636086410; Tue, 16 Jun 2026
 11:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260616091050.110064-1-geschw@pm.me>
 <20260616105553.13062-1-geschw@pm.me>
In-Reply-To: <20260616105553.13062-1-geschw@pm.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:54:35 -0400
X-Gm-Features: AVVi8CcMitJrUy-JihCbkDqEzdH6bqLbZvkER3aP95k0NiRN5BGB7OhOK604isU
Message-ID: <CADnq5_PV0BF9RkrG7ZN-OBOr2YQ=TdtvknkuDpBnwqswLNiZBg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Use exclusive bounds for SVM split
 alignment checks
To: Gerhard Schwanzer <geschw@pm.me>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 regressions@lists.linux.dev, 
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

On Tue, Jun 16, 2026 at 6:56=E2=80=AFAM Gerhard Schwanzer <geschw@pm.me> wr=
ote:
>
> SVM ranges use inclusive page indices: prange->last is the last page in
> the range. The split-remap logic introduced by commit 448ee45353ef
> ("drm/amdkfd: Use huge page size to check split svm range alignment")
> uses ALIGN_DOWN(prange->last, 512) to determine whether the original
> range can contain a 2MB huge-page mapping.
>
> That aligns the last page itself down. Thus a range ending one page
> before the next 2MB boundary is classified as if the final 2MB block did
> not exist. When such a range is split inside that final block, the
> split head or tail can be left off the remap list even though it was
> derived from an original range that may have PMD mappings.
>
> Use prange->last + 1 as the exclusive upper bound when computing the
> original range's last 2MB-aligned boundary. Then use the actual split
> boundary for the head and tail alignment checks: tail->start for a tail
> split, and new_start for a head split. new_start is equivalent to
> head->last + 1 and directly names the exclusive end of the split head.
>
> Using head->last for the head-side check can both remap a head that ends
> exactly one page before a 2MB boundary and miss a head whose split
> boundary is one page after such a boundary. Philip Yang pointed out in
> the review of the original change that this condition should use
> head->last + 1 or new_start.
>
> Xiaogang Chen identified the inclusive-last cause and posted the
> candidate fix in the regression thread. With the culprit change active
> and the local revert not applied, the unchanged C/HSA reproducer
> completes 10/10 runs with this change on an RX 7600 XT.
>
> Fixes: 448ee45353ef ("drm/amdkfd: Use huge page size to check split svm r=
ange alignment")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
> Link: https://lore.kernel.org/stable/IA1PR12MB85172F7FE9157C092EDA46A0E31=
12@IA1PR12MB8517.namprd12.prod.outlook.com/
> Link: https://lore.kernel.org/all/32ce2b72-aa16-4202-9f99-92e3cd4408bc@am=
d.com/
> Suggested-by: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Gerhard Schwanzer <geschw@pm.me>

Sorry, I missed this patch earlier.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Applied.  thanks.

Alex

> ---
> Changes in v2:
> - Use new_start for the head-side split-boundary checks, matching Philip
>   Yang's original v4 review guidance and avoiding aligned-head false
>   positives / unaligned-head false negatives.
> - Keep the tail-side last + 1 exclusive-bound fix from Xiaogang's public
>   candidate, which fixes the reproduced RX 7600 XT SDMA0 fault.
>
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 72cfb4a..59b15d5 100644
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
> +       if (huge_page_mapping && new_start > start_align &&
> +           new_start < last_align_down && !IS_ALIGNED(new_start, 512))
>                 list_add(&head->update_list, remap_list);
>
>         return 0;
>
> base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43
> --
> 2.54.0
>
>
