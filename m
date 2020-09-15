Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EFC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2CE20732
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aroVzs8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2CE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6BE6E8D7;
	Tue, 15 Sep 2020 18:37:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76586E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:37:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id y15so512324wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=51i9tPyL5HRmKB6eI88d4TPEZXxrm0wLlJzMM8ZpSgI=;
 b=aroVzs8A7yVOrX3Tteu2VsOigUBf2FvWI4YmJc5ADaB+7KdrwKqq8AKOa8h5rs9N2w
 K9/JNcuNMQPJu+4KwdpUxLssvKLBYwsgdvKcmikjsNv4yHGm9emLDa9HXtWRDiJOYHfU
 1MSVnRJbuGl3Zg+q7GfrI4C99QswTpvYksrvC7VBSBbYe/vC2v2LUh3u/7Abmn2hgDtJ
 zZ75jg/PfLYOR2nPMGmqqbaLJYLdliHgaTNA04YbVRvbkViblaF6hL8Z8ebCNswBibiK
 69Psk9e0H3/gqtP9riNNxwx/XLc3XZx+Dr1CU9BpAuX1oOE7CxuJfAQgbadhEhFEyluC
 VC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=51i9tPyL5HRmKB6eI88d4TPEZXxrm0wLlJzMM8ZpSgI=;
 b=SeZDPGcw7Mksm5SGk1o3hDDCqcOHtNnZhffenj6KXIKcCIlIBoQWNh3O0OOdiTVhFN
 sBCJOgjLk8bt+0CfkG6MRuEypWwixRb1+weZ1bSEHKtPtQ/YjMal59ZMteb2v+qLYkJR
 4uUxGEzqH4WvNrmePaper+stqxb9IlrHYUanqMOJm22QypUpoykBUvr8w4o9jAwq0H23
 PIMIKz5ZSIWFQPPcykaaNGa2idkAt3qndkCfCJalSxeK3VlgPSxyFGhfZl306mshnTD6
 zHayT6Pk9l5qsRXHpr3fSLQt2Dl7is3mfBw0vZPIV/hWzPhVk0dypbF2qXgR5/LaW7qs
 LDng==
X-Gm-Message-State: AOAM530JG98xldtws9tmf8AzsIpwYAyH/GwCnNFU3ZUl5Wu3M3dNpkyy
 838Rvf4RIybnjX1LJu1KOaQ7bu/z9jsFJrZuIW0=
X-Google-Smtp-Source: ABdhPJyuDWh6C0mf8wvz+kEChPF37ckyg4EGWqyJjOzq1KHeeyv3TkoxPr19Ww+2Reg0qJkeNKbInd8OrulnMI8buk4=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr736303wmh.56.1600195067364;
 Tue, 15 Sep 2020 11:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200907090126.2542-1-evan.quan@amd.com>
In-Reply-To: <20200907090126.2542-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 14:37:36 -0400
Message-ID: <CADnq5_Nkjbicb-Kk++LnUHmzo+j+J_C3=TLP_-i663yjoNN9aA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop dead code
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Huang Rui <ray.huang@amd.com>, Changfeng Zhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 7, 2020 at 5:01 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Raven never goes to swsmu path. So "adev->smu.ppt_funcs" will be
> always false.
>
> Change-Id: Ia55ad97bcf9ecf135a9bd795f36a5b521d718b20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>

Patches 1, 2:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index c5f2216e59c4..99ccabcc135e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -592,9 +592,6 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
>         if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
>                 pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
>                                                            &wm_with_clock_ranges);
> -       else if (adev->smu.ppt_funcs)
> -               smu_set_watermarks_for_clock_ranges(&adev->smu,
> -                               &wm_with_clock_ranges);
>  }
>
>  void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
