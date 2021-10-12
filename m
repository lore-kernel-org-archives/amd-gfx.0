Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3DDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 08:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F74361078
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 08:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F74361078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49796E7EA;
	Tue, 12 Oct 2021 08:51:26 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AE26E804
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 08:51:25 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae924.dynamic.kabel-deutschland.de
 [95.90.233.36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3F0A061E5FE33;
 Tue, 12 Oct 2021 10:51:23 +0200 (CEST)
Subject: Re: [PATCH] drm/amdgpu: enable display for cyan skillfish
To: Lang Yu <lang.yu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211012061605.809634-1-lang.yu@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <fb7a3b6f-4f53-59ec-d9da-031145b08ac4@molgen.mpg.de>
Date: Tue, 12 Oct 2021 10:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012061605.809634-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dear Lang,


Am 12.10.21 um 08:16 schrieb Lang Yu:
> Display support for cyan skillfish is ready now.

What is the last commit making it “ready”?

> Enable it!

How did you test the patch?

> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 2bebd2ce6474..4228c7964175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -736,6 +736,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(1, 0, 1):
>   		case IP_VERSION(2, 0, 2):
>   		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 0, 3):

The numbers are not ordered. Could you please put a patch before this 
one, fixing the ordering?

>   		case IP_VERSION(2, 1, 0):
>   		case IP_VERSION(3, 0, 0):
>   		case IP_VERSION(3, 0, 2):
> @@ -745,8 +746,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 1, 3):
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
> -		case IP_VERSION(2, 0, 3):
> -			break;
>   		default:
>   			return -EINVAL;
>   		}
> 


Kind regards,

Paul
