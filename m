Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F821C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 21:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F379B613CE
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 21:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379B613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3996EC45;
	Wed, 28 Apr 2021 21:07:05 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAAF6EC43
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 21:07:03 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id u80so30808450oia.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BW12G2bSDGlhvkZw3Vp8ecl9Dd7g4sbZSpH4qCy+9aA=;
 b=T5UtzoPr2tLrzrd2w9ccnKfdPc1aculOCBDW1JL7IT3wCYtnPFH9/y8tol+OIWG1zs
 Qw48XT58ESOZeVPBIOiVOn4liIsidtOA9nZzTKj3egdD+SrCx528XeE3UnltSNCRVmhK
 Zich/ehQlOpjDB+S27VUoTUtl3cgQOH0rVzVHWrktCV9jXSotkQh4VdkHRB+PwxrbTk3
 BeD8GrjHR51emodeBj0mFVuDJGrmEI3mrdsnGZW1Mu78FrdPd1cvc0PdEgpcPC/Ye/s+
 Ml0E51gD2fyWyAAKgxp3tW01CPaPWE3f/ouu0vvPOofit+oYmv0v9VDAeGA+hzbnymgz
 oYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BW12G2bSDGlhvkZw3Vp8ecl9Dd7g4sbZSpH4qCy+9aA=;
 b=WRcbL0qOGN7QSmHV759OoRL45mjD3/49MBrltcGSosvF3reGZSra2TJk7thlWE8Yeu
 f6fu/Xzhs+4UC4m6DUBBnCo0uslrJV/VhylmP4dPJYuQhjE5vYzB3SiQAzxTOcE2m5m5
 I32rBNduiOpH/A8/ds1OrBBgUAMSUgWGFwiqdlsVyCoZGH0SpgrzsSnAuxSAuEyKUU/7
 +dC9ZxDl5ovEdu8NSwC7OpvgnAj+MDBj4Jq4hsfl8SdNDON80e6EwL/mjopdZcC7PjDJ
 R2XQaWDCHnC3FuNWmRAYB5ISOBKO5raOFtRJLcY6F2k+glaZfjsh1eFOmLOUcyCQcf19
 NoJQ==
X-Gm-Message-State: AOAM531N/Cd9EPIcaZUGXCBGqiN4aChcQHloZfmWviTfqRnEIEiozTT4
 ernU8Wp6/T6+V5Xv4TaaUcCk4zXiD87PJwGQblY=
X-Google-Smtp-Source: ABdhPJy+7Ex0ZHRFhMlhpk+qLrrFS4HSjcMjnNtCxAG9pPuncfJt29iqK5p3mR7oUs+j080TFumEuaPk3wARZFUhoqM=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr21598748oig.120.1619644023096; 
 Wed, 28 Apr 2021 14:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210423204931.428241-1-alexander.deucher@amd.com>
In-Reply-To: <20210423204931.428241-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Apr 2021 17:06:52 -0400
Message-ID: <CADnq5_MhJkPMAWV3XuHGer6DC8PJXcgv0yz9BTCXVUfu2Rth0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix dal_allocation documentation
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Fri, Apr 23, 2021 at 4:49 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Add missing structure elements.
>
> Fixes: 1ace37b873c2 ("drm/amdgpu/display: Implement functions to let DC allocate GPU memory")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 77e338b3ab6b..d6a44b4fc472 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -135,6 +135,10 @@ struct amdgpu_dm_backlight_caps {
>
>  /**
>   * struct dal_allocation - Tracks mapped FB memory for SMU communication
> + * @list: list of dal allocations
> + * @bo: GPU buffer object
> + * @cpu_ptr: CPU virtual address of the GPU buffer object
> + * @gpu_addr: GPU virtual address of the GPU buffer object
>   */
>  struct dal_allocation {
>         struct list_head list;
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
