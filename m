Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB916C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 10:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2F110E91B;
	Tue, 31 May 2022 10:17:56 +0000 (UTC)
X-Greylist: delayed 489 seconds by postgrey-1.36 at gabe;
 Tue, 31 May 2022 10:17:54 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA57510E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 10:17:54 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4LC7LC745Yz9srx;
 Tue, 31 May 2022 12:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1653991780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQxPiyLxaGZGk2GEkpvomuOBIggphz35fMOUl8/1/7Q=;
 b=oWqCX+29OfciCrGmHal6QoqOpvBbKu8jEmskEJ1S5mLhIWA18wert4/jzikok6RqrUtbA8
 n1QaQVY1L/ia9s0HiaqmcUww9cdArAhvr3t+rcp0wm+5bepDcXEb63OFphLybO+eoPeIDO
 bSjKnpjzN3/V4OIkRO1A1H8AhlsITv+dxf1FcgFf/mbasnF4tgFaNLYm+mf9kKIgVLeArq
 WYRJp5glrHqB8rU2gvb3ijpp2v0QL25KOwlBpkzBVbXLO+ksKFnjROjLKCzkQt209k5qZQ
 2xS5LA853RQpUopT8LrZBg5GYLf9FRxPOvfP3rPnBXndvI29DICKgnuA/GbgRA==
Message-ID: <59bcf343-0fb1-f08e-bab0-4e4cd97e32c5@mailbox.org>
Date: Tue, 31 May 2022 12:09:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit type
Content-Language: en-CA
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220530070657.678863-1-evan.quan@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220530070657.678863-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n6zwptkhjjjdgzs8suijn9fqe3ey4b86
X-MBO-RS-ID: 11f45f69e9f7ceede3b
X-Rspamd-Queue-Id: 4LC7LC745Yz9srx
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-30 09:06, Evan Quan wrote:
> Suppress the compile warning below:
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292
> gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64 bit type?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: If5f83daeb4039d87c5b47c221f9c963c941400e1
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index cb581cfc7464..9039021361a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1316,7 +1316,7 @@ static void gfx_v11_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
>  		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
>  
>  	if ((id != SOC21_FIRMWARE_ID_RS64_PFP) && (id != SOC21_FIRMWARE_ID_RS64_ME))
> -		*(uint64_t *)fw_autoload_mask |= 1 << id;
> +		*(uint64_t *)fw_autoload_mask |= 1ULL << id;
>  }

This doesn't just suppress the warning, it actually fixes the bug where the code wouldn't have worked as intended for id >= 32.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
