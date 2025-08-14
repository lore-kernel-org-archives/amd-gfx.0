Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 12:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B42A10E848;
	Thu, 14 Aug 2025 12:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="UHCjInKB";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407D810E848
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:10:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b00a65fso4359955e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1755173405; x=1755778205;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMfECu090Asn46qOQ2dw2oUBhAroiHJn3Pg+69ai6I8=;
 b=UHCjInKB8zYnANnKOJwkOHXjefNEjTH9Igt142awuhzMml1OaLD6F5W1wUy8ruKE74
 v2snrvIxJNZrr0GsRlX3CtvBoAAhMr2zpB6c6fH9iwQFjHaOlI81g8q4Cwvcbl+WlkZ3
 iDXJTn+nByEPXV1xj5cdvjGYcHUBMDyWzg8J7djAZhVwzTZ2lGiRBaMQNpe5F/XBUG72
 j16c50el66qbnCLhYYA6m+gvY4Y5u/vtVzVbkZg7kXPTqkkv0rPlQUshfLkaNMGhklxq
 y9zxVW9kLMwFyM+409GLrsNmZym+TSRmmsCHPnnqwoYx/LrXsYk96aPO+ai0T2PFujfL
 xgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755173405; x=1755778205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMfECu090Asn46qOQ2dw2oUBhAroiHJn3Pg+69ai6I8=;
 b=kNG/SjCUH0b8/1tHVfI2tR4d+rGYkR8ml/oqOmWs/snkC1GLmE3U6UzGf7pDHQ8G5L
 nvg2YDkVY6d6VyaCGOm9pUf5W05Ij0ZqWw4AsWrewp6lbpLQrvR77MdGUR8LpB9zASJH
 Wjpd1mSBkX/LCWrWuu8SM0GKymWE+0AbZT1DCiGLbgdKOFyouWuu7q6G8GzHaz6O9esl
 IcohLBa35uWlWRezA8CVOAkzeEV6o01XRDT4ZSOiE4ZP8joctqpAJSd95FtuRaQ1I1qn
 N71A16Sx3oFfuhaDFELsEbXd0jVV3oi97iIhdv3Z2zwxYzxtLGuFTuswCbHQrqyRandy
 5wyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXbijlYmTt+YNx9vlpCbNEScJFG8ks+1lT73CN7hFq1i4RUm13QiwwF7TGrJF89CDI+QjtCrLq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcJG2WfFjQi/81bVtOaBu4DQbC3GHC9X6ARWA6bIdbxCwACNAZ
 QLBHgmuUzHcELnOgo/zl/vmfUTkaxO4d7wH4uA+b1rptokn1VsVjYBQDjtghWx1YaV8=
X-Gm-Gg: ASbGncuissWtLNhJcyMdcIXc3BWSI1ISYROUYZhkpjy4hpjr+s1oLg6SWgHOs9kDx3x
 VaUFDsWj58ZrTTF18o9YmeErOiOH3W+GTqrjwgLHTJK8DT1E7UCpPZecCknMOuUeRkN+uVETwWO
 G73HdX5sUR5mnWU/Jy5KU1pj4srNtPY0OMRbzkm4hmJoDmtvPhEYG5nMHc8xQXA/wPyBtp5KXA4
 PU6QL0j7xt3DqXNwg2HMB34x5hPZzDXk3VHBXUiSpmTxnyNKGD1vnDRLqq8x5x4bqB7ivhfKFuN
 ySGHGp/nZkeHsIEY0ja+XzXz9ATFHph0vjSVV9yWR0wBjpmd1YPDi2CWq2ilcsUmDILVv9OReDV
 RI3bZPsDz/CEpvWC1WXpHcaVHL2RE8nKQexKUl7oSeTeMvA==
X-Google-Smtp-Source: AGHT+IG+yZlmNZm+tYodYzm9SENbA0HuEUq5BXpzMK/In9ImWIQo9CrfZVmScyOift/+Mqu/LZUnXg==
X-Received: by 2002:a05:600c:3596:b0:453:66f:b96e with SMTP id
 5b1f17b1804b1-45a1b60f9a3mr21155785e9.11.1755173403395; 
 Thu, 14 Aug 2025 05:10:03 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b91b05b28fsm4433541f8f.21.2025.08.14.05.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 05:10:03 -0700 (PDT)
Message-ID: <f1b5499f-1c7c-4a40-b986-74a014897148@ursulin.net>
Date: Thu, 14 Aug 2025 13:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Move the memset() function call after the
 return statement
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250814093957.137397-1-liaoyuanhong@vivo.com>
 <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
 <14ed323d-de4c-4f98-a16c-8bdb1b92c34d@ursulin.net>
 <6ef5e1e8-3868-46c0-a31b-505f8a91d37a@vivo.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <6ef5e1e8-3868-46c0-a31b-505f8a91d37a@vivo.com>
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



On 14/08/2025 12:56, Liao Yuanhong wrote:
> On 8/14/2025 7:07 PM, Tvrtko Ursulin wrote:
> 
>>
>> On 14/08/2025 11:11, Christian König wrote:
>>> On 14.08.25 11:39, Liao Yuanhong wrote:
>>>> Adjust the position of the memset() call to avoid unnecessary 
>>>> invocations.
>>>
>>> Hui? That doesn't seem to make much sense to me.
>>>
>>> We memset the local variable because we need to make sure that 
>>> everything (including padding bytes) is zeroed out.
>>>
>>> Even if that isn't sometimes necessary because of error handling we 
>>> clearly shouldn't try to optimize this.
>>
>> To interject with a curiousity, it is even worse to move the memset 
>> away from the declaration block when the often enabled 
>> CONFIG_INIT_STACK_ALL_ZERO is on. At least when they are close 
>> compiler can figure out it only needs to memset it once. Move them 
>> further apart and sometimes memset happens twice, yay.
>>
>> Main point when CONFIG_INIT_STACK_ALL_ZERO is on, and it often is, 
>> there is no way to avoid the sometimes pointless init. I have some 
>> local branches which try to address the worst offenders but it is so 
>> much in the noise that I don't think I ever sent them out.
>>
>> Regards,
>>
>> Tvrtko
>>
> If we converts memset() to = { },can it alleviate the problem?

Yes, for example I have this patch:

commit c780f63e20cb0fd66d31f3c1a37b37983a30f318 (240813-amd-csmemst)
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Wed Jul 17 08:28:56 2024 +0100

     drm/amdgpu: Remove hidden double memset from amdgpu_vm_pt_clear()

     When CONFIG_INIT_STACK_ALL_ZERO is set and so 
-ftrivial-auto-var-init=zero
     compiler option active, compiler fails to notice that later in
     amdgpu_vm_pt_clear() there  is a second memset to clear the same on 
stack
     struct amdgpu_vm_update_params.

     If we replace this memset with an explicit automatic variable 
initializer,
     compiler can then see it and avoid clearing this struct twice.

     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e39d6e7643bf..ecdc8fffe941 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -361,7 +361,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, 
struct amdgpu_vm *vm,
  {
         unsigned int level = adev->vm_manager.root_level;
         struct ttm_operation_ctx ctx = { true, false };
-       struct amdgpu_vm_update_params params;
+       struct amdgpu_vm_update_params params = { };
         struct amdgpu_bo *ancestor = &vmbo->bo;
         unsigned int entries;
         struct amdgpu_bo *bo = &vmbo->bo;
@@ -398,7 +398,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, 
struct amdgpu_vm *vm,
         if (r)
                 goto exit;

-       memset(&params, 0, sizeof(params));
         params.adev = adev;
         params.vm = vm;
         params.immediate = immediate;

Or a bit uglier, different approach, but more on fast path:

commit 31c9f97d69dcc455fe45eb297bcb06c2b87d8204
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Wed Jul 17 08:28:45 2024 +0100

     drm/amdgpu: Remove hidden double memset from amdgpu_cs_ioctl()

     When CONFIG_INIT_STACK_ALL_ZERO is set and so 
-ftrivial-auto-var-init=zero
     compiler option active, compiler fails to notice that inside
     amdgpu_cs_parser_init() there is a second memset to clear the same on
     stack struct amdgpu_cs_parser.

     If we pull this memset one level out, into the amdgpu_cs_ioctl(), 
compiler
     can then see it and avoid clearing this struct twice.

     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9aa952f258cf..554289eb1913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -51,7 +51,6 @@ static int amdgpu_cs_parser_init(struct 
amdgpu_cs_parser *p,
         if (cs->in.num_chunks == 0)
                 return -EINVAL;

-       memset(p, 0, sizeof(*p));
         p->adev = adev;
         p->filp = filp;

@@ -1411,6 +1410,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void 
*data, struct drm_file *filp)
         if (!adev->accel_working)
                 return -EBUSY;

+       memset(&parser, 0, sizeof(parser));
         r = amdgpu_cs_parser_init(&parser, adev, filp, data);
         if (r) {
                 DRM_ERROR_RATELIMITED("Failed to initialize parser 
%d!\n", r);

Regards,

Tvrtko

> 
> 
> Thanks,
> 
> Liao
> 
>>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>>> ---
>>>>   drivers/gpu/drm/radeon/atombios_crtc.c     |  8 ++++----
>>>>   drivers/gpu/drm/radeon/atombios_encoders.c | 20 ++++++++++----------
>>>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/ 
>>>> drm/radeon/atombios_crtc.c
>>>> index 9b3a3a9d60e2..0aae84f5e27c 100644
>>>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> @@ -770,13 +770,13 @@ static void 
>>>> atombios_crtc_set_disp_eng_pll(struct radeon_device *rdev,
>>>>       int index;
>>>>       union set_pixel_clock args;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev,
>>>>                      &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -832,12 +832,12 @@ static void atombios_crtc_program_pll(struct 
>>>> drm_crtc *crtc,
>>>>       int index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>>>       union set_pixel_clock args;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev,
>>>>                      &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/ 
>>>> gpu/drm/radeon/atombios_encoders.c
>>>> index d1c5e471bdca..f706e21a3509 100644
>>>> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
>>>> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
>>>> @@ -492,11 +492,11 @@ atombios_dvo_setup(struct drm_encoder 
>>>> *encoder, int action)
>>>>       int index = GetIndexIntoMasterTable(COMMAND, DVOEncoderControl);
>>>>       uint8_t frev, crev;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       /* some R4xx chips have the wrong frev */
>>>>       if (rdev->family <= CHIP_RV410)
>>>>           frev = 1;
>>>> @@ -856,8 +856,6 @@ atombios_dig_encoder_setup2(struct drm_encoder 
>>>> *encoder, int action, int panel_m
>>>>       if (dig->dig_encoder == -1)
>>>>           return;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (ASIC_IS_DCE4(rdev))
>>>>           index = GetIndexIntoMasterTable(COMMAND, DIGxEncoderControl);
>>>>       else {
>>>> @@ -870,6 +868,8 @@ atombios_dig_encoder_setup2(struct drm_encoder 
>>>> *encoder, int action, int panel_m
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -1453,11 +1453,11 @@ atombios_external_encoder_setup(struct 
>>>> drm_encoder *encoder,
>>>>               (radeon_connector->connector_object_id & 
>>>> OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
>>>>       }
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           /* no params on frev 1 */
>>>> @@ -1853,11 +1853,11 @@ atombios_set_encoder_crtc_source(struct 
>>>> drm_encoder *encoder)
>>>>       uint8_t frev, crev;
>>>>       struct radeon_encoder_atom_dig *dig;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -2284,11 +2284,11 @@ atombios_dac_load_detect(struct drm_encoder 
>>>> *encoder, struct drm_connector *conn
>>>>           int index = GetIndexIntoMasterTable(COMMAND, 
>>>> DAC_LoadDetection);
>>>>           uint8_t frev, crev;
>>>>   -        memset(&args, 0, sizeof(args));
>>>> -
>>>>           if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>               return false;
>>>>   +        memset(&args, 0, sizeof(args));
>>>> +
>>>>           args.sDacload.ucMisc = 0;
>>>>             if ((radeon_encoder->encoder_id == 
>>>> ENCODER_OBJECT_ID_INTERNAL_DAC1) ||
>>>
>>

