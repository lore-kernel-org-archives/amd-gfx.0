Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28206C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A9610E525;
	Wed, 28 Sep 2022 17:46:05 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0405D10E50E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:40:06 +0000 (UTC)
Received: from [192.168.2.145] (unknown [109.252.125.248])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4484A660229A;
 Wed, 28 Sep 2022 18:40:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1664386804;
 bh=Jm9ILEfuHyG2z0tZsxVDekH5I/zgAK1ngUvVFZFDGtQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Yxr8+XsyvjuiDaqjF81FUvB74FoavF2b6so4WjTEJBokAPg8igpiGp50Is7/KBo5Y
 g/p6aoAextvbtP0fWI2C6XTM8G7mjNPThDG+jrrn5grJE67TEU9nYnVs5zIesKLeOx
 yaYRnTiBgPdiIwxNOiKPF/+O4nJoRopQ1GZUGov9tUnwuEvDK5q8In6M8ZUBOprNun
 iwyln51ICTmTVtsQ3gcBX0MH1sD/vbVCkBsNOFiQV7rtxPoozAAN6xzRf8FcRGyMrs
 BCbLkDk6D7HBMw9ssQ4Vta1Ox2CGp7GZiSc4N7lRTw15Ywbt2AJ+2MxjULrxVUIh3K
 MYI0UMfC5S96w==
Message-ID: <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
Date: Wed, 28 Sep 2022 20:40:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gao, Likun" <Likun.Gao@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 28 Sep 2022 17:46:03 +0000
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

On 9/24/22 10:14, Zhang, Hawking wrote:
> [Public]
> 
> Hi Alex,
> 
> Sienna cichlid rlc firmware binary needs to be updated to match with the kernel change.
> 
> I shall add this comment to commit description.
> 
> Regards,
> Hawking
> 
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Saturday, September 24, 2022 05:36
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>
> Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_microcode
> 
> 
> [Public]
> 
> This set seems to break RLC firmware loading on sienna cichlid.

This also broke beige goby. Please fix or revert. Requesting to upgrade
firmware is unacceptable.

-- 
Best regards,
Dmitry

