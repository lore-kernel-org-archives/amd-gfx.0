Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50515C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C9B61451
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9B61451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ADA6EC59;
	Fri,  7 May 2021 20:38:47 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3976EC59
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 20:38:45 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 q7-20020a9d57870000b02902a5c2bd8c17so9012013oth.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 May 2021 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=951piRO59wm4FVLa51o36BrS1xqV90CKsf2wDZ1fXN4=;
 b=kRPpQTRcItOinZlQkGF4dGuwxHmWKH4EBuYPMutVBvwRIkbW893ngKa57IkjMMwgKH
 6HjhQBJUR0QbTJZS/G6rcZyakVNM9h+qrwgGHfiG+mVvdq9oL3KaiDyrb3wIxmdDvHJj
 uiXbfxWc4PwdlhKDkDm9Zbqf/jiGg7vULxCXZ8dHCznmnYmQ9QNDtMdd14SjrruEpPZ3
 I75e7+9Wy0i7nQ9JFqxvsuZ9c5p696a9AqTntjxWRx0k5j8vTK2zwGjaSLUOdB9r9C1A
 WJpe1PhdzDNNeV3mdVE1jU3CbIkWYAWFB1ARO+9eLFtZ+ncMDeerxedanI7ShlsQsSS8
 JJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=951piRO59wm4FVLa51o36BrS1xqV90CKsf2wDZ1fXN4=;
 b=I/2ePhhKTj7eKURrGgALkB9cC786j7qXIVRny+rhPfUTTlv1E1OHWatuzq70n1FrPq
 y0YYHedXnA1dCE+fxDSb7E1wepSzBreGNy+STzI9RXbWAjaKr1TBl8NI77njWlr6F/5b
 fY0hKjRZhmENtE6uSSlJKmSB3NwMpfOMIPRxp2raKJOzy3EZOJc15FUY/d7q+Hox47kf
 vnkFjDNE7Wz2WYsJkQ0AMCi7FBno9+DuL/i3ynL4qRCQeyf/7n0bKPXd310UUuQenbka
 w2vmBB1KYLN3E43AovL4d+/1EB/QDDR0U5bHvSBvOi/RhEVJ3W/JsRC1TC7gnDyJi7DL
 jgTA==
X-Gm-Message-State: AOAM532Bv7vSnycG/2G+rCMDsItofSr2SJHjFRAlhfnLK8IZuYVO9gwN
 jC0dRo+5Hiwgc6XakiWTHipuN4JHsxV4KdYXG4Q=
X-Google-Smtp-Source: ABdhPJzAv99Ejh+sX4cZ8Fk+p1pfIvS2JCv88p4nyXmb90OdVc481kfZfNLll1ASkWCEJhFxgm/rq9syj6NuDsXydc0=
X-Received: by 2002:a05:6830:1f12:: with SMTP id
 u18mr10133775otg.132.1620419925149; 
 Fri, 07 May 2021 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210423204931.428241-1-alexander.deucher@amd.com>
In-Reply-To: <20210423204931.428241-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 May 2021 16:38:34 -0400
Message-ID: <CADnq5_M3UOFy1juETM1DFOyvYWqBtPBGREEmA_BSk=UcNdhZCA@mail.gmail.com>
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

Alex

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
