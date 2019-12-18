Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A75C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A890D2082E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0ptiFsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A890D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D61C6EA68;
	Wed, 18 Dec 2019 20:03:05 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5956EA68
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 20:03:04 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p17so3296988wma.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aktUULzv0VpZO+CrSmNwsyZkiy4GpHR/fXur7UwKWd0=;
 b=R0ptiFsdzDHIPmTHCZetnzbTLvpV/KHz8H9H7M7dS4+4Pu6YtBXJUtsZPDfP6tHNCB
 bDe+P043sAII9dNCr/8m3otyWNoByq5lcYsyl534saS+uh3542q1LffUUexRx2iO7KvT
 4FTOMk8ISISI2q451QbIBWAaLLq3tMRxg/IbEYxkEh4RRaT8k1BfFFje++kLDmJJyPdt
 ejVGyuAIEitYMWLpCrCu9DmBtnK+e2YVZYIY5PHd4zdxeqL3yN/HCQoccPmE4yfHteRc
 Pct+N7fKG/RrU38pE3UML39DnCd0NZ/RD49kqjQcI8MgvPLzbpl0qIuDoNsVlNrAhPI5
 D6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aktUULzv0VpZO+CrSmNwsyZkiy4GpHR/fXur7UwKWd0=;
 b=PdSBNBPz0+TXqYO/YvY1i41kjVth3HDVKCL4oiKJNquMjuyTkDjlAhNmN9WvAFVKIL
 fP2J/agdVeh8UCIWh+2E+JxnCCMb7QODE9HHEffvJOpNSxEISirHQPo0zxfKOqF5isiT
 X5a85jWrcOPzEHH72dJR4V1jIpu81Oiefwotru51g6gs0tOGI8LPVqzFvt8FIwSDqyX+
 +XQEMoSHn4RT0/KFCmttc06xPsjnnc26BDNBiXTUoS/X5zHnoEovQA8ZMowVt6ORPlRA
 qFXd3GLeMlWipDjTwMBy6dkhEp9nsoPTpNT6C/LTkYvDi/QHBhN/BRU0KJMJokOzlIrh
 rDoA==
X-Gm-Message-State: APjAAAVMHr2gogoRDOMGXfkblzQZl00K7e/d3xSyu99pna/VPyL3wRzP
 1kxYvbHLOKe6hUPmHYeuOK3M8H0RuUvYS6VPHfiu3A==
X-Google-Smtp-Source: APXvYqxHdl7MS+gLsuJ9PljvopWz4etfQywHLxQJBni75e1wK7xDAtj/cBQFP+LrzwlQC+gQMIa8OyeBgbf9UDgHCq0=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr5578809wmc.30.1576699382865;
 Wed, 18 Dec 2019 12:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20191218121328.31759-1-Frank.Min@amd.com>
 <20191218121328.31759-2-Frank.Min@amd.com>
In-Reply-To: <20191218121328.31759-2-Frank.Min@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2019 15:02:50 -0500
Message-ID: <CADnq5_M3uvTkLbnijYrye2a3Ra_t-9etGLDhrvK_0y9oJSqdRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enlarge agp_start address into 48bit
To: "Frank.Min" <Frank.Min@amd.com>
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

On Wed, Dec 18, 2019 at 7:14 AM Frank.Min <Frank.Min@amd.com> wrote:
>
> enlarge agp_start address into 48bit with all bits set

Might want to add a note that the max range of the agp aperture is 48
bits.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: I36eb757310fa71555c8355f99f89c89fed306638
> Signed-off-by: Frank.Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index a12f33c0f5df..bbcd11ac5bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -223,7 +223,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>         u64 size_af, size_bf;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               mc->agp_start = 0xffffffff;
> +               mc->agp_start = 0xffffffffffff;
>                 mc->agp_end = 0x0;
>                 mc->agp_size = 0;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
