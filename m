Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EDC43460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 21:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA84610C7
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 21:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA84610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884196ECCC;
	Thu,  1 Apr 2021 21:10:45 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804CD6ECCC;
 Thu,  1 Apr 2021 21:10:44 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 v24-20020a9d69d80000b02901b9aec33371so3362420oto.2; 
 Thu, 01 Apr 2021 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dn6QNqzedYyCxFSxmCymnqkmYNnWvvinHAK+WCVgT1o=;
 b=eD3LuB/1TLZ6RQvi2aXVuaq7Mu/BK6RTGFlbZgj9QzZS0B9/VaYkn2iiKXGC/LxVMR
 7LBtF9L40qMkvafrx+OTjPicPY0KLHHJQ7kPaD1wYoS38jrWLlXvNRC9ZOpJ/MbzXh5l
 7tEyKyJ88E7M3OsTW7tyiybe16wMxuIYQ8Mk5AfOOIx2YFRYYvSs0ti0lh5YXyhagEya
 7HZHrzp/7rxyNRkCsJJC1FIKA5wb6AiSACbjkt8ykoA+Qr2nIw/0uM/IMOkdzEZhhOZD
 k4HA8lB+luvtGDoE0CYZdQjn1mEOCLUnXIUuWhjoSh02BymInuzaMVWzevml3jolBs/q
 P+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dn6QNqzedYyCxFSxmCymnqkmYNnWvvinHAK+WCVgT1o=;
 b=Gp13KZZ48nYvCKXFD62ILMdlpXK/NWPpFsRnljbAtlWZT7ZBDvNiNL7OCeDyVafMvZ
 YCDCOJ6gvxxijz7VLc5A9PPySJWEYP2z9ZsyMQELSfn3oGyYOdo5JH7BZnv958q8NUD9
 tnlvKB823gQwaoHYF++XB6VWZqTltu6JS3DztNEi8oX/zWCDGjrhE+EABZkG7LFLb4kh
 iQaP7fcJvJN7OExSJwj8ZD5Z4mkB3+KUVsXqTyk2RRJW9/ets4/pstM+LK24MFJ4JgEf
 whiQjpKwD7BNgUwManE9VvUw6C80K28y+83R+ybA60Dh0PbP9R4cl06/NDyjmXayEPqm
 Ku4A==
X-Gm-Message-State: AOAM531kxW7kJs9m3Qfx+s+XSizdJV04QDiqd/xu0Sciw2oX/7YK/YaT
 RFuHH3FR0YZ1weg5FGgdtsRZWOIOxKq/PY5ov/ae24ZsTg8=
X-Google-Smtp-Source: ABdhPJwrD9U1EuoDIcewRKSx9Axm1yuo3/l3feLiLMVJfjlNhkKopbZgudfF0DMMZz8wuNUo7fNvoSvHi9mEKNnGQZM=
X-Received: by 2002:a9d:7288:: with SMTP id t8mr8955661otj.132.1617311443744; 
 Thu, 01 Apr 2021 14:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210331131218.60768-1-bernard@vivo.com>
In-Reply-To: <20210331131218.60768-1-bernard@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Apr 2021 17:10:32 -0400
Message-ID: <CADnq5_MR1_LaTfhAym=dbORhaBLLZxxgO13CyB4j3QA1D1RC1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: use kmalloc_array over kmalloc with multiply
To: Bernard Zhao <bernard@vivo.com>
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
Cc: opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, Mar 31, 2021 at 9:36 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Fix patch check warning:
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +       buf = kmalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 17d1736367ea..246522423559 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -81,7 +81,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>         struct kfd_smi_client *client = filep->private_data;
>         unsigned char *buf;
>
> -       buf = kmalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);
> +       buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>
> --
> 2.31.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
