Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC34C18E5A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DFD206E9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfJ02Lq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DFD206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CC06E487;
	Wed, 11 Mar 2020 15:16:30 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D206E487
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 15:16:29 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l18so3094694wru.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uUnTI7paB3QaLGUabq+sY9eL4Hg7bC0f3EaumyuqcA4=;
 b=WfJ02Lq9XJhwooWon7Tvu7rM2YfO1JZ4+ZMN626HnOicPTLth/5UxcXpUqUjgbrMTo
 MEFpHLx2OhZ2Gr9x/R5r5syprr9o89FXDN5SdTPjOlhz5H/a1n9wTAyZbLY8Kkm6DcAb
 QPSZhJSuVKxki5Sy4DlcN02ezmbxoS0u4xnXXPZeYpbKyGKPbAkNKOLeuE0JPX7tpPIs
 wWgrRJneOmxuPRWFBKnzOqS8isxp0FqH/CcNsPrwsg8iKV5KXtfuC7WwbgIvjWRuWI1J
 m3hj582MFDTbjnQK+xQg4aVQoMfT0wanXAk2f8LPPVs2pNZYbCF0KL7tSLVc7561cPB2
 IADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uUnTI7paB3QaLGUabq+sY9eL4Hg7bC0f3EaumyuqcA4=;
 b=V6kYn5my5LmdgP38KwBzlOQclvARHYMtGQ9h3senDxVuLk+aLai9cJZ/IT17czTuN5
 T1ZE6Bm88HP//FmndTEuo3MTBRSMs8Z2aPf9+8bS//77wkv3jccsqwCF1hvqhdO2m9Tm
 aO+Pct2RN5i8Esfv7IjXWIbEh379IAqP0F7FKujEEXpz1KbuoIyun6s6Tai0M+yq2edI
 TWKqMm9qtSZNUT8xhDndnkYvy3bMKEX53aErLfbZT2KdAhM1GPX2fYmf8NUmaXFH9pkC
 sfh2U6XEhwnMejf+qse8yWX87gDGcKgKTg0KbGOytyVnbuJpWL3eyzTbuAmNZ4tUxo03
 Flsg==
X-Gm-Message-State: ANhLgQ0DDCtkl1D0Rz0wmmcc6lkkHtvPpOOj6lNy2VPNI3Qrc/1HMh7g
 a1lP85/ZSwMUmUM49LXqHeEMSEGTBNvyaxor4oaeeA==
X-Google-Smtp-Source: ADFU+vudS6G0tCE5JNRGQgqWVGOnjLt+olIhsNBTijmpsHfpeNKf/q+tzakIpfAG3VabpxH25jrdHg/JpelQWLgApDA=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr5176155wrv.419.1583939787907; 
 Wed, 11 Mar 2020 08:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200310125314.83981-1-tom.stdenis@amd.com>
In-Reply-To: <20200310125314.83981-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Mar 2020 11:16:16 -0400
Message-ID: <CADnq5_PghktJ1AGT92-f6OE0FDhW8Ydqr0_wLpdcia51YAf=Uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 10, 2020 at 8:53 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> The offset into the array was specified in bytes but should
> be in terms of 32-bit words.  Also prevent large reads that
> would also cause a buffer overread.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index c573edf02afc..e0f4ccd91fd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -783,11 +783,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         ssize_t result = 0;
>         uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
>
> -       if (size & 3 || *pos & 3)
> +       if (size > 4096 || size & 3 || *pos & 3)

Is size in dwords as well?

Alex

>                 return -EINVAL;
>
>         /* decode offset */
> -       offset = *pos & GENMASK_ULL(11, 0);
> +       offset = (*pos & GENMASK_ULL(11, 0)) / 4;
>         se = (*pos & GENMASK_ULL(19, 12)) >> 12;
>         sh = (*pos & GENMASK_ULL(27, 20)) >> 20;
>         cu = (*pos & GENMASK_ULL(35, 28)) >> 28;
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
