Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C81C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8061310E50C;
	Wed, 28 Sep 2022 17:48:28 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1207610E50C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:47:43 +0000 (UTC)
Received: from [192.168.2.145] (unknown [109.252.125.248])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 314FE660229C;
 Wed, 28 Sep 2022 18:47:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1664387261;
 bh=wZcY6WmMgoaGx4y8DP3Y59a4+1XHeFBxWZnDXMN98P4=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=KJ5HSjpemnitc1Rj8bhQAuVG0ZDn/tpTE1iPL4BeBD5A6bKgbcGPQbaGtoa/bwjIU
 elyL5n6pTVgdqH6e4p/uqjYf7557eBRsZZBW81sQJavHr6q49SFzKCq8JMpjL5DAel
 8D7huUfPU5ezCndumrX7odiixBG7ONnQ4BT2ysnrlt7A+3eD3gmtVBosXi8fBUYj5n
 1FgeTu6ZIiSsNPFK0OVC16w5hRRaGVqUbn5pygW2jWqPq0iNtX5rTQUkZu8iJUDybc
 SiY6I5H/RZVjlE4XVa8O1pxnJJyxg281qEnKVT899eJ7W7nVdWlKZ8GpVaZsGBz3KH
 sf9GissGOdOdw==
Message-ID: <2da3a6aa-8f3e-a640-d351-c923c8c924e5@collabora.com>
Date: Wed, 28 Sep 2022 20:47:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gao, Likun" <Likun.Gao@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
 <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
 <BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 28 Sep 2022 17:48:27 +0000
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

On 9/28/22 20:44, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
> This should be fixed in a backwards compatible way with this patch:
> https://patchwork.freedesktop.org/patch/504869/

Good to know that it's already addressed, thank you very much for the
quick reply.

-- 
Best regards,
Dmitry

