Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B605822CF6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B605822CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED316E071;
	Tue,  5 Jan 2021 17:23:42 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79856E067
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 17:23:40 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id k9so117745oop.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C15fsFx4hgVJJoR91RviXlYArBlb4hR6+5bQwHUvDOw=;
 b=Lb72RbX6T3WFaVYGpF2glUKhX5RPuX1whE93XiWd7Q1P9mDMVFe9bRhBUJ+UCf8M22
 JRTs36m6jboyhcU4FiNQgDHlHjxAIgxGqW8k83huypCXbrTVzycB2sBVHQDQHmF7Dsb2
 4y3RVtDtG9/iQqMpXHL305T2Mu8Mhuxh3PQ0dWLDRKiC9deL8pUKYli90WHLn5RO2pvk
 i+ZePHYwFjy72AKh4/IB0tTfTXmj78/cqOgoeMgDVV+2kM/ZUWwQpi2PwSDLJGfcImzs
 4nqGIKJGC/EpjIS/o2Su5uduKQ0buQ5K+sZ1TdQB5L6wBMUTdp3vserNv1mir0iOv12N
 mwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C15fsFx4hgVJJoR91RviXlYArBlb4hR6+5bQwHUvDOw=;
 b=btqlevzbbezXn5a3p7tkJjDrkUofSpowlY/pAfEIb9uhwKwyEXRgySErPn0pcFCcJi
 UWMKQAI/+OfTujQn1VO35+kc+K9I6nqKATZPtwx/CriUNXuEi8uIzdkUnXzFNmpkIYyi
 XSvVEyXkfU0JqYI96P14h8Fk3XJi+c8fTpp9Fu1nSgPPrrHg7jQckQsnj+EC7olIkSGV
 Z1JQxOFPfSSXmAsVzw0Grsi+RfcVMo+WEl4ni/9bJIueL1dhJCNm5EsPHDwP7JJFurWr
 F07wlbv20NUoJ96N28GVbulrsDucDML31NOy+sTE8i22g9GYCbF2lbCUOJImMESTvSmZ
 I4Mg==
X-Gm-Message-State: AOAM530skgFZnLJh4Qfiqi6lmChyb1jvNfBT3XAhUZKg8ewmUFQ4iCXn
 KN5Jk3zFb+3TOMofKMd7dn7/Wabqjpk0oh1PkLA=
X-Google-Smtp-Source: ABdhPJw5/cTHhvJ5+B+I7mci5WdFNooxlR9z96w0eGRncIWhdBwQSx4AZvQFlUJ2AhPFud7x53W5h4PW8yZB3cNHp9A=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr63625ooq.90.1609867420141;
 Tue, 05 Jan 2021 09:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
In-Reply-To: <20210105083717.468585-3-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Jan 2021 12:23:29 -0500
Message-ID: <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
To: "Emily.Deng" <Emily.Deng@amd.com>
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

On Tue, Jan 5, 2021 at 3:37 AM Emily.Deng <Emily.Deng@amd.com> wrote:
>
> Limit the resolution not bigger than 16384, which means
> dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 2b16c8faca34..c23d37b02fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector *connector)
>  static int dce_virtual_get_modes(struct drm_connector *connector)
>  {
>         struct drm_device *dev = connector->dev;
> +       struct amdgpu_device *adev = dev->dev_private;
>         struct drm_display_mode *mode = NULL;
>         unsigned i;
>         static const struct mode_size {
> @@ -350,8 +351,10 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>         };
>
>         for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
> -               mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
> -               drm_mode_probed_add(connector, mode);
> +               if (adev->mode_info.num_crtc <= 4 ||  common_modes[i].w <= 2560) {

You are also limiting the number of crtcs here.  Intended?  Won't this
break 5 or 6 crtc configs?

Alex

> +                       mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
> +                       drm_mode_probed_add(connector, mode);
> +               }
>         }
>
>         return 0;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
