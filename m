Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77252C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA7064F69
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA7064F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7BC6EC1C;
	Fri,  5 Mar 2021 19:14:14 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421436EC1C;
 Fri,  5 Mar 2021 19:14:14 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id m25so3619849oie.12;
 Fri, 05 Mar 2021 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vYJESrZoGMMpt93wyizWTgxvC6R+AKuRSC08jpC+CMk=;
 b=MAWB+SghDRYrejm0VlOu78ulG5W+KnucHMRxvhboJY0NrT62+hsxlDTfkLXD5oCj7y
 3f14Yn35dH1b8FF3A96mBM45mepaIFo/m2hcb9YWh82HPSS3VAjmeCZVnj3fh2WJxwuq
 HJ58AMb9MLnF/V+f/MxU0Pp6Qq+e0DKr0foQXOlIaxRuXGv8/949no/Ejjk82w0yTNqW
 BuO+qEdKT+JJnrCpR8Fv6hF2D7z0FIW3TLyyiO/WzwCfXU2N6jrz5RiWqWVNz7AD6YgS
 WomxAEpHm3O170IanB/lSo8LsP+4IRoDHDv9FGXAsfJsFfsc2zuP42JB4TzUFHHXpKYK
 bkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vYJESrZoGMMpt93wyizWTgxvC6R+AKuRSC08jpC+CMk=;
 b=lMJINKz/CBRWYdPfauzWCETPbbt7Mx8N703gmbSG2Xcl935AZwy5mwDB/vJAoF/SOy
 Of+XZsRZ7iNrr38Sla8tdJb1cv/OU9zj0+cOYvnI2zHZqf5lxsEL/Ds1xNswlYPadzQX
 QyYV7/h9vsBpVEJ8INFlP/5qqJ9kG2dejvixSJfwSa1Ar4JZ6ouxO2LqRjAlSRi22v8F
 +R75IxhvABbVLWi94QltchpsHvN0IPcQxXNJqGRgxwYIt6+tE7AqRV/UjAmNQ1Eq83Q9
 xzVUuzX0Pz0ecuEGgMuImv4NIblSpD53uuLjgSkgzPh5z7jBqtzRPzwAymH1t9YVT+1T
 f+ug==
X-Gm-Message-State: AOAM531ywT6Ccn/v97f88i3dYKeonzKhfh8t8XUD6E5K8DoKkjMikUnT
 B2CaQcr87tJio7/guYIPRapQ8vxLBtAqHyKLLzt9LsgH
X-Google-Smtp-Source: ABdhPJwohfI775nymjsDoAp+q59a9uUqDcZHasxQewDfv1hHKqiuwWkMXqmBKpTnPcEPZqkGWDuNQW1uDFoZJR9bUZE=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr8054191oiw.123.1614971653655; 
 Fri, 05 Mar 2021 11:14:13 -0800 (PST)
MIME-Version: 1.0
References: <1614926449-68399-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614926449-68399-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Mar 2021 14:14:02 -0500
Message-ID: <CADnq5_P1wgjQbkWkQfWXADBr+Q_-yhqXv+m1SS7AQ+GDp-N6uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same patch was already applied a while ago.

Thanks,

Alex

On Fri, Mar 5, 2021 at 1:41 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:8257:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3e1fd1e..10de6c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8307,8 +8307,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         hdcp_update_display(
>                                 adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
>                                 new_con_state->hdcp_content_type,
> -                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED ? true
> -                                                                                                        : false);
> +                               new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
>         }
>  #endif
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
