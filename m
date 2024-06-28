Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903EC41513
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C09910EBFB;
	Fri, 28 Jun 2024 09:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="VkBjhkYU";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="EcDnWtic";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C4910EBFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1719568017;
 bh=BZTOAB+/oVLhLTBwR+jHoZ0
 C6uH1xmGHTRtFECuCIA4=; b=VkBjhkYURsEfNgaGjAybPicEdsNV3pROI7ahAmNO0GR6GxUpFY
 ynLDmpSHMb97bAY64G3m5/s3ua0bgcOajQN5RcD5c74PhUHpBhUhkMXN3/DIYqqAKGZgHEFGXER
 WTG51FaZEEJa0BjwjixyVLGvvoJKTdvSd5Oz3L2ifjap2gw4INpRf9xqPbriPqy0Jo5OLlkcocF
 ZvgPjWuUzmXppAe5s3TBsUc+4GDkB2TDV1NZpd49ZBEwDwi2QsF1Wcko3PmkcvDtjiOW5990bHz
 0b0f4+XkB9e0d69sWz51Z1M7P78TsD4cODvfCaZ7j8fG6QHAAs/9OZ9eCiuxzqp7/3Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1719568017; bh=BZTOAB+/oVLhLTBwR+jHoZ0
 C6uH1xmGHTRtFECuCIA4=; b=EcDnWticjylCsqJkOt/wXyPxwQdyV/F4jSzl3bfDrRmiybBARf
 u48PVVqN/rVSNnoIC+vuAEUzMwQpssCdh0Cw==;
Message-ID: <ae71a654-bb42-49c0-b550-448fc6898624@damsy.net>
Date: Fri, 28 Jun 2024 11:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: check bo_va->bo is non-NULL before using it
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_N+ofUFOWhDvKkWSy2zXYMHaHHD0m63hAPLs4EG6mTVzw@mail.gmail.com>
 <e18a1ebd-1c19-4dd0-aa59-1e6dee593db1@amd.com>
 <CADnq5_M8+qPhK57bywCv5=PTd0TC2YYL05oCGfLd6h3AwgE6eA@mail.gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <CADnq5_M8+qPhK57bywCv5=PTd0TC2YYL05oCGfLd6h3AwgE6eA@mail.gmail.com>
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



Le 26/06/2024 à 15:59, Alex Deucher a écrit :
> On Wed, Jun 26, 2024 at 6:54 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Am 25.06.24 um 19:44 schrieb Alex Deucher:
>>> On Tue, Jun 25, 2024 at 10:32 AM Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com> wrote:
>>>> The call to radeon_vm_clear_freed might clear bo_va->bo, so
>>>> we have to check it before dereferencing it.
>>>>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Should I push this to drm-misc-fixes or should Pierre push it to
>> amd-staging-drm-next?
>>
>> Might take some minor work from you when you start to handle radeon
>> change as well.
> 
> Does this depend on anything in drm-misc?  Otherwise, I can just take
> it via the standard channels.  I already handle radeon patches via the
> amd tree.

No it doesn't depend on anything in drm-misc. I'll push it to 
amd-staging-drm-next.

Pierre-Eric

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>> ---
>>>>    drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
>>>> index 3fec3acdaf28..27225d1fe8d2 100644
>>>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>>>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>>>> @@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
>>>>           if (r)
>>>>                   goto error_unlock;
>>>>
>>>> -       if (bo_va->it.start)
>>>> +       if (bo_va->it.start && bo_va->bo)
>>>>                   r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
>>>>
>>>>    error_unlock:
>>>> --
>>>> 2.45.2
>>>>
>>
