Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0218EC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753DB6146E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753DB6146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBE56E8F9;
	Mon, 10 May 2021 21:24:17 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A2E6E8F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 21:24:15 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so5562246otg.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nP2AadwVLrnhX9FA6/X8klgvF92DLe/YRLZ5gLkjKi8=;
 b=YrYuf95QF/e6e0FRlmsjGUHFTG0KD97n8pzcjMaLGQBazMQ+ha4O2Gcx9QpdUVvn3L
 IHvnzEi1TtJoSLScK9p5wu751F5iOnN9YZBbv8tS0w4VyqPtwugByz/rYli23ioxwFLr
 23A0Jmrsw0ao3/lRrgCq34tglvlrrUmhTOvrrk61ZxMO+9RZmMuwamPWNMrSmXGsWGmh
 6cyxjkDI9mTeD+/ovgsRU1ocZ2VIUxvy2GZ8wxfEzzHL/TxIw/lg6lm8Mz0R2W/1y9Gj
 rnQ9jB1GNeHwyJPGVXXNJrtS52Px4eY/JNLIjAkITzOhnfZK4zj3ns3vXj++owsIiGgq
 ZTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nP2AadwVLrnhX9FA6/X8klgvF92DLe/YRLZ5gLkjKi8=;
 b=AyWVq94aYEnl5B7elx8Dn1vlgAbmNyw3/gbYPONwwVx6yU5GKPCeoUYjoCzZcigaQ4
 8WYtM4XOzW2Ric5EVhebsFk74dz9/MG22nO4JGSJ9PrImrHtTSCH/qoE0ZAUU/mpE8B8
 uAVT2sxmOPpLbHRsNrfHgep6Qw63se2OlGw9zjHhZhHhW3p6hlVRjv7vYB0uG03R9Dd8
 GlAMbGFplTynTF9miEHu0JPy0MvoXuu2yzaHQbRHV6DOhvjwAMnwHsumnV1rU4asnhZM
 KLM0K8gIYYKwymVmPRFnKoyh/xzm915fHYcaluhSgtKrQb6PTzDcM911MHSuuJPJ7evs
 fIAQ==
X-Gm-Message-State: AOAM530TUXkzZK3srLSr/mzSoCUyd+/no4YzpP7tpV4iIm+PYise3Wt5
 y23gsu0WK2I8HTsuOeIChW9Awkr+ABqFAcRM3Qs=
X-Google-Smtp-Source: ABdhPJy1IvmIMCzpAhojrLPJGZV5h7vY13kE37jhc+zWy7AiEovZmTk/KCQ+6uXtTxtoI5MGR4/uxAI8TSYCtAoW2A8=
X-Received: by 2002:a9d:51c6:: with SMTP id d6mr16707682oth.311.1620681854906; 
 Mon, 10 May 2021 14:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <44b4dbe2-a808-9788-7a4f-dfd628a93256@gatech.edu>
 <20210510093039.28502-1-david.ward@gatech.edu>
In-Reply-To: <20210510093039.28502-1-david.ward@gatech.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 May 2021 17:24:03 -0400
Message-ID: <CADnq5_O=mZvtNVCowzzk=HgwrTuROspuOTnfs174Sufwif9PPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Initialize attribute for hdcp_srm sysfs
 file
To: David Ward <david.ward@gatech.edu>
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, May 10, 2021 at 5:31 AM David Ward <david.ward@gatech.edu> wrote:
>
> It is stored in dynamically allocated memory, so sysfs_bin_attr_init() must
> be called to initialize it. (Note: "initialization" only sets the .attr.key
> member in this struct; it does not change the value of any other members.)
>
> Otherwise, when CONFIG_DEBUG_LOCK_ALLOC=y this message appears during boot:
>
>     BUG: key ffff9248900cd148 has not been registered!
>
> Fixes: a193ed2094ba ("drm/amd/display: Add sysfs interface for set/get srm")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1586
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: David Ward <david.ward@gatech.edu>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 60f91853bd82..6965126d771d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -644,6 +644,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>
>         /* File created at /sys/class/drm/card0/device/hdcp_srm*/
>         hdcp_work[0].attr = data_attr;
> +       sysfs_bin_attr_init(&hdcp_work[0].attr);
>
>         if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
>                 DRM_WARN("Failed to create device file hdcp_srm");
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
