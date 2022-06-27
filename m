Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4FCC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 15:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB5710E0A6;
	Mon, 27 Jun 2022 15:34:06 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8760410E548
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 15:34:05 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id z19so13558946edb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/PkAOfxj8epdq9qpef3M5OQenkwqv1ZxKVu3KS8Vq04=;
 b=iZnZET2HHvvCu5UIQYf2SZWBjfpxf0792jpeCHcKISZJk8YhJJAAfSx7UTuXaCH1sG
 u0HL2SZaFfRf6c6kn5SnR8qHcXo/ALXwVDoml1RGxnGSRLY1jgiaqKp14xV3Pc+68gCd
 1JR9NL/aGPW4rNpfFJ0TLkvs9nqxpb7cyc7PdLOVJO3Js+hVJygjLQ1fUcSQJy5QgHc3
 +cXoFMuafCnj3uFEJolhAPVYDp/2clYdQgwW/0u2YRkdoicrb68Gu5BTQzZQJ5IXRrKE
 j+aB1Y1M2Wt8jT0/kiI5tJGpQ/bO/4Zdhc2cXRUqrmp7X6fqbwh2I5JXOtFb7xczsLjb
 RXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/PkAOfxj8epdq9qpef3M5OQenkwqv1ZxKVu3KS8Vq04=;
 b=tWOlgD2568iDDE0Uulyx9wkmWP2W6K8vC4FNQkyvul3Cc0KUZDDcOk61Bg5fJyKvue
 oH87XoO1B5COvYUavwFi+IDciPt4Bd6ai14aPXMwOhXPgoH3b6TdfA03YycvZqr+K93c
 o7cLpeNmX3lme0an6Z83NUcTlQOpTz0HR9G1aY9X9tdMEByfRwqbSZIyod4ED2nbv5fD
 jlcgMB7Jjn8rrFLCTQbHevDmMfVA9v1GmzlVPmhKWgdex1uIW/oK+HdZp65RMIwr05dF
 HeQcyc41hNnI9IzReedXySYlKPbCdQl116t2CSbJ/3ZJWWDEP+EGI7K4jR8YAz64SGT/
 y6mQ==
X-Gm-Message-State: AJIora+WeKE0bnk8hHmFPI8/n7P7lW0uFReno/JgW5X5vSYDqYQ2yHnz
 GEqhAGp6YIjOv8YyW0k3DC4hNY86rO/9mA0RHvc=
X-Google-Smtp-Source: AGRyM1v+/netI7+itVrPUKBRir65YI8CpeNSysY16pgQ70jetGYnlr2wkkLbpPmlWBfcT6MEQnGxXeBOg9Z+9igeQxI=
X-Received: by 2002:aa7:de88:0:b0:435:9a54:168a with SMTP id
 j8-20020aa7de88000000b004359a54168amr17117970edv.73.1656344043994; Mon, 27
 Jun 2022 08:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
In-Reply-To: <20220624160243.83693-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jun 2022 11:33:52 -0400
Message-ID: <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
To: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 24, 2022 at 12:03 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> It is to add new options for always keeping gpu mapping
> and custom of coarse grain allocation intead of fine
> grain as default.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Can you provide a link to the proposed userspace for this?

Alex

> ---
>  include/uapi/linux/kfd_ioctl.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index fd49dde4d5f4..9dbf215675a0 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
>  #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
>  /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
>  #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
> +/* Keep GPU memory mapping always valid as if XNACK is disable */
> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> +/* Allow set custom flags instead of defaults */
> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
>
>  /**
>   * kfd_ioctl_svm_op - SVM ioctl operations
> --
> 2.25.1
>
