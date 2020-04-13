Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D7AC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 14:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5DD2075E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb0jklcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5DD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF7789E50;
	Mon, 13 Apr 2020 14:16:13 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CAE89E50
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 14:16:12 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id r26so10137159wmh.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=psx2DCeUJ2Lx/jHBatz0phxuqF2h9n7Lc6+GC2jMxv8=;
 b=bb0jklcFzCi0zqr8zUaXq9RviSno1nUVvbsEchXtObB5p5yf/u+GYoZA93vFefgcZ2
 G2N9N0KYUeT4eIo0dxStGrAW3FXU83MbUX1DPOHlSQVvxavXGq2OcWAkJ6yAu+5U3TQb
 9jMTer6/0jmcuGuq7f0bN2ofUgHvtA+HagMghIh1+v/IzNlruQ7O87J0aa1Df5EFrv1T
 Is2d82AqE+xI3GN6NbIwS67Oj08m6f69zfejn3M/woST8SMv6Na2oaB6DZ3DlNdYPyg2
 7R4yT3aLIOJL/jfAyPOtD+2SJGIlTko7OaZr54vbVfrwnrR9ZtCW5t7FBHdg+RpGHZzQ
 PDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=psx2DCeUJ2Lx/jHBatz0phxuqF2h9n7Lc6+GC2jMxv8=;
 b=HG89gnh+ejx0hAB1nLDdhF3cWl1Mn2OEFCi/qDg6DWgnAZLyAXwX172smM36Q9Wn+x
 9KZ909vNWNndmYxFztK1tCgSbBrl4MPbpA/KejnI68R9I94dbXNVFDq8mdpXzZWLQhN6
 8t4zYeLhHdrKK3fDGdrsbsE8v4iN/7xwNJNYhHu9dSKN9dkst09EYrCGCKt/OC9GUdXJ
 beOB0Y9aomnojsd/vv7Frpy3bmBZ0Og/LbOsQzzsZc66Wq3rEBjxIzJLA2/YJagpvRWm
 q1UA2h8ZH325Fapg/ANj2JRDw7FXsXvc4qnLy50klgSQ5D2w3ZkTNv2dPd92TescLHSm
 ELBA==
X-Gm-Message-State: AGi0PuZlokcR+DafYaAxEuclR7T/7NSw3IyR6KjlbQ9zjYA/X6TI0sm6
 7tKPQjL/AYxxTPTMf/zEig93Ks6DbyjKtH5QowQ=
X-Google-Smtp-Source: APiQypI1GbSedGaYhAjTSmlpEwZHJTBuVoJftWzcLOZtijLdAFqaSr6UaHJCKG7wORW8IXxunk9M1RQr2b+nmwQp9kY=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr18696295wmo.73.1586787370366; 
 Mon, 13 Apr 2020 07:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200413085347.590-1-evan.quan@amd.com>
 <20200413085347.590-2-evan.quan@amd.com>
In-Reply-To: <20200413085347.590-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 10:15:59 -0400
Message-ID: <CADnq5_MECJ7hDrwO3=Gk93Hb9fSPp1OJXbPTY3_eQUP5=YCarw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: bump the NAVI10 smu-driver if
 version
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 13, 2020 at 4:54 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To fit the latest SMC firmware 42.53 and eliminate the
> warning on driver loading.
>
> Change-Id: I3f524d03e53ec6778b7118ef72652a538eec4ace
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 674e426ed59b..e786d63b1e79 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -28,7 +28,7 @@
>  #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>  #define SMU11_DRIVER_IF_VERSION_VG20 0x13
>  #define SMU11_DRIVER_IF_VERSION_ARCT 0x12
> -#define SMU11_DRIVER_IF_VERSION_NV10 0x35
> +#define SMU11_DRIVER_IF_VERSION_NV10 0x36
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x33
>  #define SMU11_DRIVER_IF_VERSION_NV14 0x36
>
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
