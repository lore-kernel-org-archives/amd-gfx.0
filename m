Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D451C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B1F610CE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B1F610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2736EA6B;
	Thu, 15 Apr 2021 15:37:21 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09106EA6B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 15:37:20 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 o13-20020a9d404d0000b029028e0a0ae6b4so3896564oti.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6cnSyS81gtJxK5XlvhAGJTTDceWC0+7kCRBNEW/P23I=;
 b=O8824nETIoxl5TZFdBVg2tDLFCU89mq9qIW8eHU/5N3M4ee0gFudaEiM/BPK8ilgB8
 NvzLJk1NuszQwotEv6xp+n9mae4KREKUk1KTbPM4W+PC5vf+d6/5tM1Tp5FbtUtgsmCW
 vDetGFQ43M+w4pVdBb5Tz5mOvP/B7Ch6MBx4PcFWmFgxKPE0FFSU/vnQE1lMmCP1cBoU
 LLe5U0tDaeutR3ZIujW76O+n+84opPeQddhmre7r+oKDjSmi7TYkLvI4nJwwyP49oYqT
 ir68Aj3YR1gTnqy47uFoLDSD9i1xopVy67NlhZ/X8TzYIKMHpOZIpGswpH6Q4qPrJVs0
 CKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6cnSyS81gtJxK5XlvhAGJTTDceWC0+7kCRBNEW/P23I=;
 b=GQc59vCLrE0e2z6QVV6+3S/8sU75+fmLZaPlHcOwj0mtKIhMD+HU+XWZlyInbFavQX
 XJqzxm7QfaaR8AE2QsJgt187ZIwn7jPMlsKkq4QksSu+hBk2e2ehwpHFKPR00nyK//Fz
 mvTa5V0tRg53o5BtS0zdi+/FoL0AqQKFHxek+XfiNRIpEJdJNWs8/L0864MggsYF0pIK
 RQSpA61ezCzePK0EEiUgstmj4MOVufVF01vnp5UVjuUeZhDkoRM2zaVXrv2bJglxpYY4
 z/VS5A4w4YQujZmlO0limwtnwV/f+xi0839w2YiTjh01Ep6l72VlH16Dl5dcUL8j1JiF
 l20Q==
X-Gm-Message-State: AOAM530vo8bm6FMz0SonY5N1VQXLrJ2/NYkq9MO6SwH/bqUuM2RMqBl0
 Na4n3/Ck9FNWZidlR9FBNQGPg0SNp52u0BkFwwg=
X-Google-Smtp-Source: ABdhPJwQMYjIxpczhWs8K7sVdpFakfN2eVgZ+NVdfvjGE61tAnnrvgNsqvjOGFJ7JKjHWIkLl0pViVhe7SlCUs9meyE=
X-Received: by 2002:a05:6830:17cf:: with SMTP id
 p15mr3215835ota.23.1618501040118; 
 Thu, 15 Apr 2021 08:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210326165944.1310-1-contact@emersion.fr>
 <YsPGje8t2-fY1GTI6waUph1jQzm5WtagjUUi0lFy3Q7_I20gG8Ln1bIBqi00nj5RMzdkFhrftPbUrpqwrV2bSvEJbDD8IG9dPHAaZNTLQM8=@emersion.fr>
 <CAP+8YyHeiB5OyTgQkTAuFv1MhP7ZpeLqmZe9oHBj5f0ez6Pa3Q@mail.gmail.com>
In-Reply-To: <CAP+8YyHeiB5OyTgQkTAuFv1MhP7ZpeLqmZe9oHBj5f0ez6Pa3Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Apr 2021 11:37:08 -0400
Message-ID: <CADnq5_M7O75XJCDdjLoFoRVuazDp2tikHTOB2tCqckS6Hr+h6w@mail.gmail.com>
Subject: Re: amd/display: allow non-linear multi-planar formats
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sun, Apr 11, 2021 at 6:21 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>
> On Fri, Apr 9, 2021 at 3:19 PM Simon Ser <contact@emersion.fr> wrote:
>>
>> Hi,
>>
>> Can you have a look at this patch?
>>
>> Thanks,
>>
>> Simon
>>
>> On Friday, March 26th, 2021 at 5:59 PM, Simon Ser <contact@emersion.fr> wrote:
>>
>> > Accept non-linear buffers which use a multi-planar format, as long
>> > as they don't use DCC.
>> >
>> > Tested on GFX9 with NV12.
>> >
>> > Signed-off-by: Simon Ser <contact@emersion.fr>
>> > Cc: Alex Deucher <alexander.deucher@amd.com>
>> > Cc: Harry Wentland <hwentlan@amd.com>
>> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> > ---
>> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>> >  1 file changed, 4 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > index 36ee52104007..66e3ecf123d1 100644
>> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > @@ -4216,13 +4216,6 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>> >       if (modifier == DRM_FORMAT_MOD_LINEAR)
>> >               return true;
>> >
>> > -     /*
>> > -      * The arbitrary tiling support for multiplane formats has not been hooked
>> > -      * up.
>> > -      */
>> > -     if (info->num_planes > 1)
>> > -             return false;
>> > -
>> >       /*
>> >        * For D swizzle the canonical modifier depends on the bpp, so check
>> >        * it here.
>> > @@ -4241,6 +4234,10 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>> >               /* Per radeonsi comments 16/64 bpp are more complicated. */
>> >               if (info->cpp[0] != 4)
>> >                       return false;
>> > +             /* We support multi-planar formats, but not when combined with
>> > +              * additional DCC metadata planes. */
>> > +             if (info->num_planes > 1)
>> > +                     return false;
>> >       }
>> >
>> >       return true;
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
