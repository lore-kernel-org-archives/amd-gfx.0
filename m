Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CC8C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 16:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D7A10E953;
	Wed, 26 Feb 2025 16:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="boH7IxiJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B2D10E94F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i7h1ddaq9Zyk7YU+NhxjxSDsmXTRjhKpLQaMToN12Q0=; b=boH7IxiJiFVDo8SHQ3t4HD75Nv
 JSwOrjQZEB+Pyhqqv9G52hDhPpE64JsoTeVWSUC4yTVl5f22dW8lcGEz59Vgy6CURMvCDtsFfrqzS
 597we+E5aWh9q1iiKcdn6qb8hIXJ6xJbIWUiBt/tPxgIq33C2eZMofnf0glnDaJvYd3v3NqOrY0it
 OVyXZftlJEr8kTd4EZigqFWBbz3/HbXw070ySGLsWIOmXGaN1kNZksuaiW1BTyBbgN9AJl1ogjDCP
 S7jd6fy9GM8LBgCD9i8/Q0CL/4aaEl+f/z05AdaHseGxdfN4SiU0O8Jkp24KWxZo4LFI0+SpehG9m
 ON0ixFpg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tnK2s-00136A-Vl; Wed, 26 Feb 2025 17:14:09 +0100
Date: Wed, 26 Feb 2025 09:14:04 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation/gpu: remove duplicate entries in different
 glossaries
Message-ID: <7by2wuo3qeytgmt3vystmatz24yxfeqniyi42kp2wceeztxij4@wjfzw6qge7c6>
References: <20250226143929.3450065-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226143929.3450065-1-alexander.deucher@amd.com>
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

On 02/26, Alex Deucher wrote:
> Some items were defined in both the general and DC glossaries.
> Remove the duplicate entries.
> 
> Fixes: 2df30ae0ba0b ("Documentation/gpu: Add acronyms for some firmware components")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/display/dc-glossary.rst | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documentation/gpu/amdgpu/display/dc-glossary.rst
> index 0b0ffd428dd2e..7dc034e9e5862 100644
> --- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
> +++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
> @@ -167,9 +167,6 @@ consider asking in the amdgfx and update this page.
>      MALL
>        Memory Access at Last Level
>  
> -    MC
> -      Memory Controller
> -
>      MPC/MPCC
>        Multiple pipes and plane combine
>  
> @@ -232,6 +229,3 @@ consider asking in the amdgfx and update this page.
>  
>      VRR
>        Variable Refresh Rate
> -
> -    UVD
> -      Unified Video Decoder
> -- 
> 2.48.1
> 

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

-- 
Rodrigo Siqueira
