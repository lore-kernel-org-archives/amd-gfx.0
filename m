Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733A4C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56B310E9A1;
	Thu, 10 Apr 2025 13:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s4hjW5Y4";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EEB10E88E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 12:48:39 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so5448698f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744202918; x=1744807718; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nN+f3xNhDo5f6/GPhgaHpLiZWIHJJ1BBuI8jav4LKKU=;
 b=s4hjW5Y44QfGGouo1lSmeuUYTQdREbWLQgt61GEEshz17b7wHnm/zwWqjHYZ8M3FsT
 p7AXJNFUdj1sT1isu+EwrCytswQQOjqpCWXGO4FwfK9Jb2q7o6s6rYPCFx/W+m7Qj0j/
 +s9NPwW3h+wEsCYxbDLm6wBX++XH9Nd8yCa1kyH2IQZnWQrE6dRBQVZZgJgITn8Zx7rG
 VTmQ+wU7iz8wja6fa3AwgYX9mV1LjLiCM7tfZEyGbye/+6BGX2tWT0aomOHJ0/XyN5lB
 v/mMZO8icni04YnQq5IQ+65j7rxEw8qSo0zYeSwlM/mvPaoh8Ja7kM5PoU26qB9g+2t+
 tdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744202918; x=1744807718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nN+f3xNhDo5f6/GPhgaHpLiZWIHJJ1BBuI8jav4LKKU=;
 b=QODV07HoPL8MkWwi3YxoE5SVo5U+u/MlCl0YzC8fPPQ9qwHLPyfpCOQXrhNyvte+bt
 1qkAMzTr7lwFIN/7zvRbPKOnJrMcv9XwhG8vN1FabiG2xvolv9tpRiVGPPZAMlZ6LMb7
 +cDW4lmUQgCMYa3RGdxvpdvaFe81E3j1uKb6PC19EGF7moAWZpU33eCyPkZ2BcK10M1C
 +iPnr/keHnCUwfuRWxC9IgGefXWGqminBX5glQgPPOGYjPlMo7PwZ1j2n+0fuxF+q3fU
 ZS2MJVPeIRKAxt7YI4s1ww296a2XOVIv06j41DHYNgF90BgtsM1BMPOTB7rbNuGoBjEX
 nY/g==
X-Gm-Message-State: AOJu0YyPbr3GA4wXNghhEHJWurZJ7wF+T01qSOAUvJbjO50Tr6O2NWqx
 AklcsrRJOhE0prJ8sTLbouhnCxW3xTPL3voAfJ7wkWT3AUxZj6+lZ9PUSVCvLI8=
X-Gm-Gg: ASbGncua/2FB9h4HZD+fOIJv9KEFV0Pcrpm0laV5169PdzgE43vY/0p6tGT+9FKfdKn
 Zbo+rEjnzSOlQ/aWoNPVPRutmjHtb9mlCk06KeyojKoF/p+yYfK2WR6xNEp3rqPuOBTTUoIHLSZ
 tD8MHnn+ycMkq769Yesmj4359BbHJO107zfpxkLFNW4diSCbqhRWbW4EsLfR5TNKvaw88tMs+Nr
 iCHnnpzAaVqrc5ppPd/5CR/TgsLpJpkRVL6QljYSOvRsjShBOmDhAU6ZRNMPgeEO5qzDTqygnFB
 ui4+knPOTF+X+aUGCbeopJLVHdtrc4xKlB7DiMcIgBBLBg==
X-Google-Smtp-Source: AGHT+IGSuX5V0wmZRJqF/nbfqv0ZMV7sS8GfNZARq2yeaAei7PLfbUhLoEiTzCX7DN0Xon4EYLUFuw==
X-Received: by 2002:a05:6000:2289:b0:39b:f12c:385e with SMTP id
 ffacd0b85a97d-39d87ab3086mr2835111f8f.20.1744202918110; 
 Wed, 09 Apr 2025 05:48:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39d89377901sm1585596f8f.36.2025.04.09.05.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 05:48:37 -0700 (PDT)
Date: Wed, 9 Apr 2025 15:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ce Sun <cesun102@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning
 in amdgpu_pci_slot_reset
Message-ID: <5ea78eb0-3af4-4cbf-9700-9d38796a18bc@stanley.mountain>
References: <cover.1744200284.git.cesun102@amd.com>
 <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:32 +0000
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

On Wed, Apr 09, 2025 at 08:10:01PM +0800, Ce Sun wrote:
> Fixes smatch warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'
> 
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
> 

Thanks.  This doesn't change how the code works so probably the Fixes tag
isn't required.  But it doesn't hurt anything either.  Static checker
warnings are a gray area.

regards,
dan carpenter

