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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80444C2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2B8206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCINmJCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B8206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3592F6E19C;
	Wed, 25 Mar 2020 17:52:10 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 781F46E198;
 Wed, 25 Mar 2020 17:52:08 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id d198so3517687wmd.0;
 Wed, 25 Mar 2020 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yif9NVG5qM8UtBHACYI/xY6SaBYSsuiUhHBQ73NO1N8=;
 b=HCINmJCDnfcY8ewgVE3xtasrXb2Z2dK1xZ52g5yfs86Xu+IPOOFxFN0RMEDaM8WTn5
 MBdmdXdsuHYmIT/0c28kx9D2hOfJEBzEGOgkI4t4fDVyVoPXlSfq3fAJ8VTv/meZB2BF
 LxFLM5khMPsp0u2AaYEte0XdIlWmo0hPm0hrRpR0huyXcqinP6Eg9uZjMj05l/oKvdFx
 tawr0bAcJpT2ZyavV1b9qFOeXFOTOpQbBOTgIpdpKp/4D58sRQaEEwZcUkRIg9U2T5mg
 lSsMwVf97o2lFZ51zDH/XXzC9GApnYJOM8pGTbj6DEbxombPZbRtXzrcsKMm+3YS+5uS
 ynjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yif9NVG5qM8UtBHACYI/xY6SaBYSsuiUhHBQ73NO1N8=;
 b=Yl5O4zpoNDNbSZ2rt5BpHW28bf4obArCyFYEkgKURvYIvOvgsfZWhIzwUh34ahgRoE
 e74y51QHAH8WMlOcKwiAYaiuV74qnQRT1uG8GHjVNdQkdVcPrjDS1xOP2V5ezFgBYZgk
 yxxytFtdmHT9sg0HjOJ5nGgBvSZx7yZ07w5d6YCYxF0wIaIa/xO7Gev5rq/VDs5NZJB6
 TT8NWOeJMMIb4MtF2o99C5gBFHNcORG8l285cYemM46ns7cvybxy42By/eqq/YyXRQPJ
 bHNRCxfVWy78pIYgELiAFaTag4hb791K48oxNrz7lIldDbld6q5kgHkgBiwf73Sv18DP
 Sh0w==
X-Gm-Message-State: ANhLgQ1O7eNHUZfYitICM/7BA5Z3Pr4lbAFTORNkMPrzSgrP1JNU27Fw
 bUeqcIWB+YBbHU7mEbvkMrp0fc7xlTFNKWxylWM=
X-Google-Smtp-Source: ADFU+vsZ41U9VmICHzULJAe9eA3jQXQ/NCx1Q5ewlweYb1D4ftz0Lh9iocVH1RbzinRjkmpFzePMZ07vmsIXgYG/B/s=
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr4549621wmb.39.1585158727066; 
 Wed, 25 Mar 2020 10:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200325023250.163321-1-chenzhou10@huawei.com>
In-Reply-To: <20200325023250.163321-1-chenzhou10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 13:51:55 -0400
Message-ID: <CADnq5_NQgugmHe0U_-b6EZB6JHX-qqcu0ATKVKKy105sANgHxQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/uvd7: remove unnecessary conversion to
 bool
To: Chen Zhou <chenzhou10@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 25, 2020 at 4:17 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> The conversion to bool is not needed, remove it.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 0995378..20f10a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1694,7 +1694,7 @@ static int uvd_v7_0_set_clockgating_state(void *handle,
>                                           enum amd_clockgating_state state)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
> +       bool enable = (state == AMD_CG_STATE_GATE);
>
>         uvd_v7_0_set_bypass_mode(adev, enable);
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
