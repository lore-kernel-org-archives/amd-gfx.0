Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC474C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CE76100A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74CE76100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001FC6E103;
	Mon,  2 Aug 2021 16:32:51 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC826E103
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 16:32:50 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 o2-20020a9d22020000b0290462f0ab0800so18001285ota.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Aug 2021 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P3oWFPkG1F1VR8TVXPR4jQO14m3Zjzhw4GqXacR/XpI=;
 b=XjT67qKCy32oTmHb/Qb1l1f6YpkE0DsggAQZ1obe+JsPeUH8O3ObSk1CZ38BeQcscm
 k92ApUFFKdz9eVKZ4o6X8MB80Qa+j3jeo+nT5I5Wab6u6+IMIu4mvLkdQy47knji13aE
 OQAGPLpsv5X725trqJtEGCUWApH5GIMbjSsfQz/K41JHBD6BZ6wSJ0TUaNDy3kMQWql/
 bWD6QjiUN/HLntfKin02lwMUtmB+VWuwviYSY3FXZjGFYExQcNvqO2+CNXE7tQYTEfsE
 9uJ41sJf+Gmg0BiDJdHA9MQf6EPvOmbDST3OPjgtQgIkrstrdZ1r45dv78PxcXByIeFr
 LhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P3oWFPkG1F1VR8TVXPR4jQO14m3Zjzhw4GqXacR/XpI=;
 b=W5CHty0Q5WDlpa31NNGrh7kYSGTz+pUveZi+fPanb/1ZTnRKKQguonMRdDoayc/2yr
 DuksPHCEV/h7oPY/4s9TA4k5+e56eMqmtzQTOq+8Q2uiOzr3QjhlwFRUgPtew+dj1e0Y
 dgsYMMmmuHvXCC67KMF9Tu9gUIwSODWa8pzyCPvlPytCZKhgpizBLCksdd4o0JBHIpCM
 Xq+xUmAMxQqswKpPE7X4l8zSM3svq09b0bCcldafZGqgFFIOWbLrLTbYCg0ux3cu9j0Z
 Y4k1UMgyGw1CtKe72qoKypHYEMy9H77pwUTmuIxdScdDJZ6ZIKCYnlq3OqIMqmNr0WgF
 Ykqw==
X-Gm-Message-State: AOAM532sZ4kPfTJzkHdNB+1oL7f+W6VKWpSzk9Nu+L0DkKbfzLBHVT9n
 sDgke/MR5Zo3Sjdg74lS2D/WStselE1zhQG0GTc=
X-Google-Smtp-Source: ABdhPJzyUF5ogpAGCxiUUz0ertj6FXxFv0OPERz9rtkFQ2bKKrBEgQeK7oYqiwwzwl0X7bF0Ubr0wOXJrS4Ol/LWLuY=
X-Received: by 2002:a9d:2072:: with SMTP id
 n105mr12845014ota.132.1627921969773; 
 Mon, 02 Aug 2021 09:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210802093026.277263-1-lang.yu@amd.com>
In-Reply-To: <20210802093026.277263-1-lang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Aug 2021 12:32:38 -0400
Message-ID: <CADnq5_NgfriV2g7UMTMnBKDKKTUQZeNz0Hq9bj86yL4-_197Sg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check CG flag before querying CG status
To: Lang Yu <lang.yu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 2, 2021 at 5:31 AM Lang Yu <lang.yu@amd.com> wrote:
>
> For ASICs which don't supoort clock gating, querying CG status
> may cause a hardware hang issue. So add a CG flag check to exit
> directly in such a case.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b1d2dc39e8be..a7afcdc50ca8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1671,6 +1671,11 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>  {
>         int i;
>
> +       if (!adev->cg_flags) {
> +               *flags = 0;
> +               return;
> +       }

This is fine if someone has disabled all CG flags, but maybe it would
be better to check each flag individually within the
get_clockgating_state() callback for each IP.  Do we need a similar
check for PG flags?

Alex

> +
>         for (i = 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].status.valid)
>                         continue;
> --
> 2.25.1
>
