Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F729CEF174
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E810E52C;
	Tue,  8 Oct 2024 13:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TAJ3AN6z";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9456410E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728386497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcSbnHbbfGHslEagghc2Oxwyxy36QouRWHaSbNT3wUQ=;
 b=TAJ3AN6zcox+NDeIVtUEcb5jYOA9mhiNuBcVkFc4HSuti5c11lCUrO9ekRc/TFjop7j0Pk
 ITXVy4reSZHi2wKKdJJBiWo7GJmBsuqRuoOW0OqrwqgDsC2istAJPTJg3irShgbB3eiKLa
 kcecGW/Py6phvvC0pcmYSEqSRwtQKEA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-0W-ChxqMP9ykUeg0LUJdfQ-1; Tue, 08 Oct 2024 07:21:35 -0400
X-MC-Unique: 0W-ChxqMP9ykUeg0LUJdfQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2fae60b3ea9so45925131fa.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 04:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728386494; x=1728991294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcSbnHbbfGHslEagghc2Oxwyxy36QouRWHaSbNT3wUQ=;
 b=EPARBmHezRxn7Vr8LilkWNZzIlULobmAKs4BS/oWHl+feQ/2zzY3RBBgO0J6WISaxx
 bD87jKTLaGdSDq2hVwKDKIfMWi+tIB4byFe/H9bzDpUtMwa92L6E3mAQF9cg8GqeG8nj
 BVTXW+SJAJb5WT3HPiUED92FTNB8MTGsQG6JaSIV++pa5FLkjMSPiP0sd6klvRm66Ke0
 5AJyqs6kKpDLxgXFJRUwC1uxWQFsPz0BdP+UVjSeX+3VMtBCjapd5Drx/omjcMiMwzUG
 zzGrzlSIAjoBIO1JoLN2BwmUR9d54roDkdvr+IDDH+q3EBLg5suXE/4e8QTelfQ69SbM
 zUkA==
X-Gm-Message-State: AOJu0Yw+LuQfkVoddpvqclTbT+1UMMjsozF2qo10eY4H1ofhxG3/gnxA
 Wcy0x0IV6GfeV09l8iYaLcRbSyxfIKGbBg5Gjp+eCVnmrSnQvV59GrUdMwsIYMt4Z3Mqx/YX8Uw
 jt+LtbphxZraRqZehHIIGFh/E3zlkkxVbSG5ixEUeiMR9aC7grTLtsBqaBOlHk1c=
X-Received: by 2002:a2e:b88a:0:b0:2f6:9787:5fc0 with SMTP id
 38308e7fff4ca-2faf3dac8d3mr66249381fa.40.1728386494370; 
 Tue, 08 Oct 2024 04:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn2Jp70nRLjgKoeAmV801MzedN7vDdq+hQbk9ltsQB4TOJl1+VpU+6sPFbkWBrgoF9jOUbfQ==
X-Received: by 2002:a2e:b88a:0:b0:2f6:9787:5fc0 with SMTP id
 38308e7fff4ca-2faf3dac8d3mr66249211fa.40.1728386493852; 
 Tue, 08 Oct 2024 04:21:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05c0dc1sm4221672a12.52.2024.10.08.04.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 04:21:33 -0700 (PDT)
Message-ID: <779e26f3-87e0-4c28-b535-f9276d9628ae@redhat.com>
Date: Tue, 8 Oct 2024 13:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: always set GEM function pointer
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, Wu Hoi Pok <wuhoipok@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20241007183241.1584-1-christian.koenig@amd.com>
 <CADnq5_PpmkbYppJWR6QLzm7J_iR4GpSOYYQbTR2Ni21t++R34w@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PpmkbYppJWR6QLzm7J_iR4GpSOYYQbTR2Ni21t++R34w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Oct 2024 13:25:13 +0000
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

Hi,

On 7-Oct-24 8:36 PM, Alex Deucher wrote:
> Add a few people.

Thank you.

> This should fix the radeon ttm gem conversion.
>
> On Mon, Oct 7, 2024 at 2:33 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Make sure to always set the GEM function pointer even for in kernel
>> allocations. This fixes a NULL pointer deref caused by switching to GEM
>> references.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")

I can confirm that this fixes gdm not showing with 6.12-rc1
(after the "drm/radeon: add late_register for connector" fix):

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>> ---
>>  drivers/gpu/drm/radeon/radeon_gem.c    | 3 ---
>>  drivers/gpu/drm/radeon/radeon_object.c | 1 +
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
>> index 9735f4968b86..bf2d4b16dc2a 100644
>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>> @@ -44,8 +44,6 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj);
>>  int radeon_gem_prime_pin(struct drm_gem_object *obj);
>>  void radeon_gem_prime_unpin(struct drm_gem_object *obj);
>>
>> -const struct drm_gem_object_funcs radeon_gem_object_funcs;
>> -
>>  static vm_fault_t radeon_gem_fault(struct vm_fault *vmf)
>>  {
>>         struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
>> @@ -132,7 +130,6 @@ int radeon_gem_object_create(struct radeon_device *rdev, unsigned long size,
>>                 return r;
>>         }
>>         *obj = &robj->tbo.base;
>> -       (*obj)->funcs = &radeon_gem_object_funcs;
>>         robj->pid = task_pid_nr(current);
>>
>>         mutex_lock(&rdev->gem.mutex);
>> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
>> index d0e4b43d155c..7672404fdb29 100644
>> --- a/drivers/gpu/drm/radeon/radeon_object.c
>> +++ b/drivers/gpu/drm/radeon/radeon_object.c
>> @@ -151,6 +151,7 @@ int radeon_bo_create(struct radeon_device *rdev,
>>         if (bo == NULL)
>>                 return -ENOMEM;
>>         drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size);
>> +       bo->tbo.base.funcs = &radeon_gem_object_funcs;
>>         bo->rdev = rdev;
>>         bo->surface_reg = -1;
>>         INIT_LIST_HEAD(&bo->list);
>> --
>> 2.34.1
>>
> 

