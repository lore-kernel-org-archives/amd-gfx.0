Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1EC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D122076A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daMI5R6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D122076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516366E876;
	Wed, 25 Mar 2020 15:19:52 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A82C6E876
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:19:51 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id l20so3133403wmi.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qIHUREPZ/jeILcDXTfKttieiXKcDTT3o0kzsYp+/7cA=;
 b=daMI5R6PXK2HQOUZ5Vkyam/7w1RbPDD1imgihQTrY2CoRDhcMuxEs4XEHOu2BKK4MA
 b78mhEGbO/HQ+67YFmiN0nmZtJggHje67jiK1equZocpJGcccpHOhgyW4wbyO47CcMAo
 CgQJYjfOeVSFkO8IxXHnd7TwAZRQocyswfPaFdtkzdfiJeQbKhDXFLwbs/ySBopddH/z
 kEYWXW1hA2+ehD9MVc8KnfJ3iqWUhDoU10sX3oM8+b4mPRNVi2WMuzr2gZ8+WDODZ68c
 ls4cFpAQS86kJUjSOjIIl23cyoCb1aB7JY/y3h6+9nJx7KKSadwj1DtI4G8nBoSWNGhm
 zUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qIHUREPZ/jeILcDXTfKttieiXKcDTT3o0kzsYp+/7cA=;
 b=sRZPdn+bQg1GzH7oXB7g8S+YmWqTJrZlJ9tTqKyBC8rzxQ3u8pZEkiewq8QdYHMnLu
 K9A/j74kMZFFxfGb5mFqEXVbmecdghTafRbFY9cpKrM09KosNlFbTkhLrwLlNXhv1Wac
 XQUVmOX2W0ptrQTB5oHjBUy70MsRZ2a5V4v3RBpjx5qdUs4uEgE2cLZJnb5hS1aj7BXQ
 X2kL0mgNSfFQM2NsX9hADw7YtPK4ey92eBsYVPzydVv2E6mBtR30la/wZi+grXjZWRB2
 OxcrzxyNVfuGMqTsZBnwyR/t1Vt+Wv5QgmNeiyWp44G4NaGj0ZiRIaDdbtXxQfOVD4Ku
 w4/A==
X-Gm-Message-State: ANhLgQ1eoAPZk6u0KyxPg23y9N2198up231GOOYX0yUM5SF5HntUgmcT
 S0+JMjSfj/mX+gr8C34RHF3cs0Q4q6nUz7D853z9HG8T
X-Google-Smtp-Source: ADFU+vv5z+MZYms5V3pEBvWdOGJg0UY20rBYt9wCplwteAiUXX7wNdoHBGkWfdUj3ilboyfCKAtwasZENkNK2JRzN3Y=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr3956192wmo.73.1585149589892; 
 Wed, 25 Mar 2020 08:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 11:19:38 -0400
Message-ID: <CADnq5_NdxJLBMqeHGdThvJbdzDLBGyMFLfohcqVNUtiffRy-uQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from psp
To: Emily Deng <Emily.Deng@amd.com>
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

On Wed, Mar 25, 2020 at 4:33 AM Emily Deng <Emily.Deng@amd.com> wrote:
>
> As the VCN firmware will not use
> vf vmr now. And new psp policy won't support set tmr
> now.
> For driver compatible issue, ignore the not support error.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Please fix the patch title.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c2bf2d9..1a46050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -205,6 +205,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>         int index;
>         int timeout = 2000;
>         bool ras_intr = false;
> +       bool skip_unsupport = false;
>
>         mutex_lock(&psp->mutex);
>
> @@ -236,6 +237,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>                 amdgpu_asic_invalidate_hdp(psp->adev, NULL);
>         }
>
> +       /* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in SRIOV */
> +       skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a) && amdgpu_sriov_vf(psp->adev);
> +
>         /* In some cases, psp response status is not 0 even there is no
>          * problem while the command is submitted. Some version of PSP FW
>          * doesn't write 0 to that field.
> @@ -243,7 +247,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>          * during psp initialization to avoid breaking hw_init and it doesn't
>          * return -EINVAL.
>          */
> -       if ((psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
> +       if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
>                 if (ucode)
>                         DRM_WARN("failed to load ucode id (%d) ",
>                                   ucode->ucode_id);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
