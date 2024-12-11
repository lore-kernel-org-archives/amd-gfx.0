Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992CEE77187
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6998310EDE5;
	Thu, 12 Dec 2024 14:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AotVFeh7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020AB10E08C;
 Wed, 11 Dec 2024 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Z5EkRMXSAAd6VugPHXUkDoDDuWALwNmWHDkbsYItPc=; b=AotVFeh7Uqefi7l5uxK5YZHyxa
 LJqoG7294B3siZZpD5zpe1Trm8d4i4ZBxNwapkO6TuelRgWreIJkHj6Lc8G6hHTJIJ+jFzokKg9kE
 XLBjBZGlZwbBSVh9C5pSBXyjDlUcwKETMbMrkap0J2DlitMy2g9Rg2oKDJ+O7GGxSVYFMzcHQ9Lk2
 yrHvPIhqhkAXpdFHM6rmE/w6TCqQ5v2KvCtvoN1iwA8mPl4LREPlr99zmhDCPe4M5mh5G46FDrT2w
 gfTjqDi+YwTDPNOM+o1bGL0gYOfAR/8D6y4WznmkH2KPVettO1IUwoh63VZBF5F4VmO9fLvRnH/ga
 smdqt0Sg==;
Received: from [179.118.189.35] (helo=[192.168.15.100])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tLVJ1-0025cH-AI; Wed, 11 Dec 2024 23:35:43 +0100
Message-ID: <6221fc3d-0b1a-4e91-9e34-a32f3c77b63f@igalia.com>
Date: Wed, 11 Dec 2024 19:35:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] drm/atomic: Ease async flip restrictions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Simon Ser <contact@emersion.fr>,
 joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
 <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:04:19 +0000
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

Hi Dmitry,

Em 11/12/2024 16:35, Dmitry Baryshkov escreveu:
> On Wed, Dec 11, 2024 at 12:25:07AM -0300, André Almeida wrote:
>> Hi,
>>
>> The goal of this work is to find a nice way to allow amdgpu to perform
>> async page flips in the overlay plane as well, not only on the primary
>> one. Currently, when using the atomic uAPI, this is the only type of
>> plane allowed to do async flips, and every driver accepts it.
>>
>> This patchset re-uses the per-plane function atomic_async_check() to
>> this purpose, so drivers can allow different plane types. There's a
>> `bool flip` parameter so the atomic_async_check() can do different
>> decisions if it's a complete page flip or a plane update.
>>
>> igt test: https://lore.kernel.org/igt-dev/20241211031820.115844-1-andrealmeid@igalia.com/
>>
>> Changelog
>>   v9: https://lore.kernel.org/r/20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com
>>   - Add a 'flip' flag to indicate where the atomic_async_check() is being called from.
> 
> I think something went wrong. There is no changelog for v10 and also no
> tags that you've got for v9.
> 

I have type the numbers wrongly, this is the changelog for v10, but I 
forgot the tags, I will send a v11 with the correct changelog and tags.

Thanks!

