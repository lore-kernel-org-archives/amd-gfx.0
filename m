Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 21:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DAD64FA9
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 21:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DAD64FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9556E884;
	Mon,  8 Mar 2021 21:15:07 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA176E1A5;
 Mon,  8 Mar 2021 21:15:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id u6so5189547oic.2;
 Mon, 08 Mar 2021 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bK1egWRIYmAM57JGkevuvF9LMdJfxUITtPUiQtDDxH8=;
 b=EenPaZb8C5Pijx6LJUC0kSF/ossy/pi8y6ZPOsNrLIEGnRwr+gDjWinvE/IfeHPl0B
 Kwqh/gBucHSUJfPse7F9QsHL5OVGBnSGQKBvNrth5IPfVHFNyAmfGDaYvPsFCY8eKkYv
 25ug1JFNnNqDwSqXhPd0HUU13YhGyUgxMOVAT1MU7U4Z+1YfDTV3KW3E1ViLyLdhUkBV
 SAD5oPTvLGBS5fHJQG28JKAG4kv/V74CAvHXT4uTHKMVl7klbfdMvgelxr1ug53dP26X
 6F0sQtG4CBIVgJMwx5RxRaIkQXs4YjFcBFuQUz/WOVlptAMzm6R85WPpyqUIMnBigfch
 JLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bK1egWRIYmAM57JGkevuvF9LMdJfxUITtPUiQtDDxH8=;
 b=iRMWvyPE0x56Zv6NPAjsBKeN+bndUwDIXxLCewY77u5+ms5NSJKES3pXMLWyY9KEcA
 CfopdoUVMgXRyjb8fqZ6MM38T70hShhPzkscge38IPKeYiLIB/pH62eFPkYFtEYUVil3
 mAx94RM6TDlwLhlgQXS9dx2WW+YMncklpv3mfvPHM8u4+36hIyfzSqkPzr2gmutUpMxO
 Yng5WyiEU9faB8wqPEDp1XszvdECS9sZHnczcueZIGg6JGnDWPYeDG64z7UolziTamnY
 mdvKf/WfqLPSpmvoPhMp47g0GKBl+u4OcQ8p7DhMkcMm+gRpWesCz0LmW0n/gAJFr4K0
 woVQ==
X-Gm-Message-State: AOAM533dwntXhEIhvjsjdyJKalfAuw/G/r+3cSf/icIUna3BH0wXTmfO
 zF04WLeWOknZt+7B1y0xrM6TJM1t1MQ8INZCEhgWVN4L
X-Google-Smtp-Source: ABdhPJxScjMLq05XElf34SOT5GTz4dxjnLMllur9XID5rsea9TR6bipOie5rALc2/DMyuKzAGrR7QNAHzksvpQaARGw=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr606723oiw.123.1615238104977; 
 Mon, 08 Mar 2021 13:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20210305035428.6750-1-baijiaju1990@gmail.com>
 <DM6PR12MB26198FF9499CD3ADCCF93546E4969@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26198FF9499CD3ADCCF93546E4969@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Mar 2021 16:14:53 -0500
Message-ID: <CADnq5_MquFxnRxLrfjrUL_jcj6fSi=5ymuDS5ovMRiBJH3odMw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: swsmu: fix error return code of
 smu_v11_0_set_allowed_mask()
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "airlied@linux.ie" <airlied@linux.ie>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Jia-Ju Bai <baijiaju1990@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Mar 4, 2021 at 11:02 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Public Use]
>
> Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Sent: Friday, March 5, 2021 11:54 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; airlied@linux.ie; daniel@ffwll.ch; Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH] gpu: drm: swsmu: fix error return code of smu_v11_0_set_allowed_mask()
>
> When bitmap_empty() or feature->feature_num triggers an error, no error return code of smu_v11_0_set_allowed_mask() is assigned.
> To fix this bug, ret is assigned with -EINVAL as error return code.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 90585461a56e..82731a932308 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -747,8 +747,10 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>         int ret = 0;
>         uint32_t feature_mask[2];
>
> -       if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
> +       if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64) {
> +               ret = -EINVAL;
>                 goto failed;
> +       }
>
>         bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
>
> --
> 2.17.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
