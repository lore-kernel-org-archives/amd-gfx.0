Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFC1CA5FC4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 08:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF6D10F78D;
	Fri,  2 Oct 2026 08:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g7Ih/YUy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A490110F78D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=ozR5DgeMo2sHLYrIrdJD6DC2PmZXJropfz6096M+bGk=; b=g7Ih/YUy9raqdTPDupHTEDKpeW
 wo96vlLUQGRpLqnJpQ50WWY3Eza3VAdWRPtdkh8ir6HT9vT8bXaFKhKpjZczEufxCt1HkrKDOSon+
 4bLjs5gYiXBoL2zhL5CHswwRDohKu5UwqFWCXrWzJ0nWVFcDnbDSH0TBJJf2/+HnCJ+1i8FUSR/Qz
 E0TOQWix2hdzSWliy/FzngL6J6/mHAry+hyX/AfTLOzLokC6ukg02nQlXbBMFAGyM8nrXENj+Pmqd
 mNWBZPJytbO51Ucl5/WT+4/r7ibOHCKsPEYtM96eg0gr4KYgZ3EFyP5A5Qt2t23cpagdMX5B8s92j
 MZfKptIg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCYNE-00AUTe-LG; Fri, 02 Oct 2026 10:12:08 +0200
Message-ID: <044b2508-00e8-47db-9f1c-17affd2e3786@igalia.com>
Date: Fri, 2 Oct 2026 09:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amdgpu display debugfs handling fix and refactor
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Roman Li <roman.li@amd.com>,
 Tony Qi <Haoming.Qi@amd.com>
References: <20260924114049.55201-1-tvrtko.ursulin@igalia.com>
 <ca2e957b-a0ad-459b-907d-d57fb8ce10dd@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ca2e957b-a0ad-459b-907d-d57fb8ce10dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Hi Alex,

On 01/10/2026 22:14, Alex Hung wrote:
> Hi Tvrtko,
> 
> Building this patchset with clang generated the following errors:

Thank you for trying it out. Apparently I was too eager with some local 
variable removals.

Fixed in v3 just sent as a reply to the original.

Regards,

Tvrtko

> 
>    DESCEND objtool
>    INSTALL libsubcmd_headers
>    CC [M] drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.o
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1516:6: error: variable 'crtc' is used uninitialized 
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   1516 |         if (connector->state == NULL)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1541:6: note: uninitialized use occurs here
>   1541 |         if (crtc)
>        |             ^~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1516:2: note: remove the 'if' if its condition is 
> always false
>   1516 |         if (connector->state == NULL)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1517 |                 goto unlock;
>        |                 ~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1492:23: note: initialize the variable 'crtc' to 
> silence this warning
>   1492 |         struct drm_crtc *crtc;
>        |                              ^
>        |                               = NULL
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1674:6: error: variable 'crtc' is used uninitialized 
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   1674 |         if (connector->state == NULL)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1699:6: note: uninitialized use occurs here
>   1699 |         if (crtc)
>        |             ^~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1674:2: note: remove the 'if' if its condition is 
> always false
>   1674 |         if (connector->state == NULL)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1675 |                 goto unlock;
>        |                 ~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1650:23: note: initialize the variable 'crtc' to 
> silence this warning
>   1650 |         struct drm_crtc *crtc;
>        |                              ^
>        |                               = NULL
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1832:6: error: variable 'crtc' is used uninitialized 
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   1832 |         if (connector->state == NULL)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1857:6: note: uninitialized use occurs here
>   1857 |         if (crtc)
>        |             ^~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1832:2: note: remove the 'if' if its condition is 
> always false
>   1832 |         if (connector->state == NULL)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1833 |                 goto unlock;
>        |                 ~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1808:23: note: initialize the variable 'crtc' to 
> silence this warning
>   1808 |         struct drm_crtc *crtc;
>        |                              ^
>        |                               = NULL
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1983:6: error: variable 'crtc' is used uninitialized 
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   1983 |         if (connector->state == NULL)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:2003:6: note: uninitialized use occurs here
>   2003 |         if (crtc)
>        |             ^~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1983:2: note: remove the 'if' if its condition is 
> always false
>   1983 |         if (connector->state == NULL)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1984 |                 goto unlock;
>        |                 ~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/ 
> amdgpu_dm_debugfs.c:1959:23: note: initialize the variable 'crtc' to 
> silence this warning
>   1959 |         struct drm_crtc *crtc;
>        |                              ^
>        |                               = NULL
> 4 errors generated.
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/../ 
> display/amdgpu_dm/amdgpu_dm_debugfs.o] Error 1
> make[5]: *** [scripts/Makefile.build:548: drivers/gpu/drm/amd/amdgpu] 
> Error 2
> make[4]: *** [scripts/Makefile.build:548: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:548: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
> make[1]: *** [/home/alexhung/develop/amd/amdgpu/Makefile:2144: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> On 9/24/26 07:40, Tvrtko Ursulin wrote:
>> I had some patches in this area ages ago so I re-visited them, tweaked 
>> and
>> decided to re-post.
>>
>> First is a clear fix while second is a serious refactor which needs a 
>> lot of
>> scrutiny. Mostly closing in on the desired semantics and thinking whether
>> changing any of the existing (incosistent) semantics is likely to 
>> break any
>> (hypothetical) scripts used for debugfs configuration. In it probably 
>> desirable
>> in principle since it removes a lot of redundant and somewhat 
>> questionable code.
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>
>> Tvrtko Ursulin (2):
>>    drm/amd/display: Use memdup_user_nul in debugfs code
>>    drm/amd/display: Simplify debugfs token parsing
>>
>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 600 ++++--------------
>>   1 file changed, 130 insertions(+), 470 deletions(-)
>>
> 

