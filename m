Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB8C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7D324671
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDUzwZQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7D324671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9286EAA4;
	Wed, 15 Jan 2020 22:44:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A888F6EAA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 22:44:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d139so5821852wmd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zDNLklkCARJy7hD0HR6mIev5qLAwLGCVYSnEmcFjWZY=;
 b=mDUzwZQshmBKN3q4WJ6srLk/pTpnBz/ldsxkzoL2LPfBmwOXAUGN0Lqi70Cpd5ezIj
 185NbUO8Fzg6DmcsRfAtsp2b4sY+zazL4xkkN6p5AcRxXJwjTVsaAK0QhmeTmt43cT/r
 bc4dy0Oq5ZZzrP66LnGyjifpl1nxhV/wS41n6yEA7WmnaPpTQ0aMAJGKN6aEQcM3xwPF
 BZoKzH6NAoVUrHnIiPIV+yyPGgIFDwFlHqk82khVHy2q+zwzwT9Mp2WeHAPsGjyWblqV
 OZI3fYqNG8RjPC2FgKG0M5e2zv/ow3tt68JKqQjj/T/9Yfva7xiwI/7w48gw0bY0BWJ3
 pccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zDNLklkCARJy7hD0HR6mIev5qLAwLGCVYSnEmcFjWZY=;
 b=fjH2MWuu4rbwNMe8nPdx0fopHAyzYrpu61vJ8TH+/4EIEtflXJW6b6ceSQHef2KIFu
 l5lmD7U4HBAeVQkpkNXuk51VpB0VfhkOAODImAPtufabPpl2M9mMcN2l1MIdNI5okhpM
 ErJt/HxoTWVEU/XOx28VrczgArcOKytm9Nwr7XHEfMrf5WI5NR7xdEMUu8jRfoO2XM/N
 vfHd4nox+6LtOqUpWMrynWdDJucfS49Z3zWMgCyLR9aToTvo1cSjbF6sabTEu5mU0srY
 MCDdJkG/iJVQhRbJ4yZv0iujtjGUS8DmZDA818IyNUIBiBRNc5U/yOA/q7hVtsPLNfga
 iwJQ==
X-Gm-Message-State: APjAAAWyagh6cnz6MJuOGYbAF+2mArDgNC3A9N/zkeqYnwK1MTn6b9qq
 8VwK0FeBy3akiyyEGV9kPKAIRshsnJxLuMrFaxes9g==
X-Google-Smtp-Source: APXvYqzZak57HqEAu4yY5AYe2H/Cm7W4ZCHDoaU1wzG/A33Bd4r6yRDUREYlA/uWotslquzKj9JwPXwzGZTJKVEet/Y=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr2395563wmq.65.1579128287245; 
 Wed, 15 Jan 2020 14:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20200115221544.1712687-1-alexander.deucher@amd.com>
 <20200115221544.1712687-2-alexander.deucher@amd.com>
 <DM6PR12MB3914270CA4F7D77B64710716E5370@DM6PR12MB3914.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3914270CA4F7D77B64710716E5370@DM6PR12MB3914.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2020 17:44:35 -0500
Message-ID: <CADnq5_MYqHFQVnAfWi5FAMY5RZC8+Mg_7CY9QyX_HAACyqgQ2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/vcn1.0: remove duplicate defines
To: "Liu, Leo" <Leo.Liu@amd.com>, James Zhu <James.Zhu@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 5:40 PM Liu, Leo <Leo.Liu@amd.com> wrote:
>
> The value are different between VCN 1.0 and 2.x.
>

Ah, sorry, missed that.  James, please fix the conflict then since
amdgpu_vcn.h is included by both files.

Alex

> Regards,
> Leo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: January 15, 2020 5:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/vcn1.0: remove duplicate defines
>
> These were added to amdgpu_vcn.h so remove the duplicates in this file.  Fixes a warning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index a70351f2740c..2b9e3098d4e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -39,11 +39,6 @@
>  #include "ivsrcid/vcn/irqsrcs_vcn_1_0.h"
>  #include "jpeg_v1_0.h"
>
> -#define mmUVD_RBC_XX_IB_REG_CHECK                              0x05ab
> -#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX     1
> -#define mmUVD_REG_XX_MASK                                                      0x05ac
> -#define mmUVD_REG_XX_MASK_BASE_IDX                             1
> -
>  static int vcn_v1_0_stop(struct amdgpu_device *adev);  static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);  static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Cd684fdd7f88f4246831608d79a088016%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147233724222499&amp;sdata=jFi5Npjg6nXtQlA5JEu3dHnjiKHeBZfOWbr2KBrqYI0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
