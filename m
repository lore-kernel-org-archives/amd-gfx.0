Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A79CA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 11:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323F610E845;
	Thu, 14 Aug 2025 11:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="p/nKzN3J";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DBE10E845
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 11:07:27 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b9d41baedeso423499f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1755169646; x=1755774446;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EhzC1LIt1LNTjS6++SEvIb6wixTsS4zRbZp52DT3w4U=;
 b=p/nKzN3JP1JqO08/ExViVLgi7SeprxLgpLff3woyc3t5gi3S0SsKfU06gMvwQAzj/r
 ABVRiTLWMjzQbFvIagrhikB2y5XNdrPy7y801xZlpmyZ7mUGcKkANI4NqU4QysLwcx5U
 O5CVx1l1qt+eMIRYI4k0l/pAFlj9QpD1SSd4hRGGFr+VQ3VpdUmPdj5w55AbZe3pLZiv
 kX7oHvfa10EtAvILzk0Mx0Ja8aSC2an9VtstQQ334onciQlKIkWQrnKBjDDZP9DeN9Oi
 6s1nyIAOoRTKY3AAkl6cirvGUYfgaamKvQ4BHHCd7ge98UMn4AGAitz+HddkbsYE2soA
 5rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755169646; x=1755774446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EhzC1LIt1LNTjS6++SEvIb6wixTsS4zRbZp52DT3w4U=;
 b=ay7v7ciDImF3fJZX4lnoavtcunewunBiiVjmskJv2im+dZVdhIr9/RXHKkF6rffWPi
 V6GwthHzSmAJAwt8NdfINO6YYkNvUdlUjvo/z+LudUIEA2jlyxYV5kYeOTopH87OcdKf
 BW4S/IfJ4R16KzTfs64IjEIsGyVEyfw0b7WdD2rU63lY4kUmPuIQKxPqA83ZoBspM8ov
 bF2XHHc48ukqaGIdo9tnQc33iWpN/16WSFT/aR84gtUenzNpeWz6RTxjKEj5T9ExwbKl
 82Qn9eqTt4CRdvQzdGqWg5sts+S5M+mQcSzOlOC8lcCbjN91Vdj90kbCHGSVyIx3tv0u
 ZMVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr91oFHgM+YjWxlIiuDNwUGEVOVMVKOHKN9gHRxHttInS24UsTFzcs97GWa2R3HccJIDMtt47D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmpBDs61wHHU1nOsKUp+ZgEl2Wr6VUJXAMtNIcZuYV8dYwqAx0
 i7CxR0CAYupIgOb8tTZDE3c8BpJOaFbomA6plcrrYEm0RSCCGAmsCUcBMOU/dJw13ig=
X-Gm-Gg: ASbGncuIS5GTkPsFXFg+jF8iw86vhEvaj5Ax2IYxTi9VNt2eb+f2OfwazHO6uFt5/Nv
 +lRx1PXZBjHK6kQ9joTWWix3/XI6TdkiwwPKnN6APR6/5WJawYcr99q3OMu7svRP6zU/UH7QkaZ
 fs5B7B2laDKoKhVlMwh0De7yEw5NCWUzfclwnBM+vyE9cpyJ8KmNRspPgJt1Dn3cW4nVWnGGFG8
 3ff1tCtx1ELzUawY6fViW5cAKaNtNDGfA/NilN5mHs+LrzAWfWcmnmZHITVMRafsJYqMeFndFTs
 W2scdhQsWKdXlXkwPxBsFUZZrRJM6NsGgZW3HDnajTqjd7Bq0NqD2ZpIuBEGOsMeBERQ+B/tLfk
 gYqjwkYiuQE+39WGBnksTr06bI1ShqAF7Ri6I+aP/4Y2CUg==
X-Google-Smtp-Source: AGHT+IG+WqGjfQftYWUvsowlRp0/lbM82rvGxjJZqJkNe/p0TTWmDn5ifF6edyehRMIL0CNuZ2dMUQ==
X-Received: by 2002:a05:6000:2887:b0:3b8:d15d:933e with SMTP id
 ffacd0b85a97d-3b9fc362529mr2344546f8f.56.1755169645890; 
 Thu, 14 Aug 2025 04:07:25 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abec8sm52567672f8f.8.2025.08.14.04.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 04:07:25 -0700 (PDT)
Message-ID: <14ed323d-de4c-4f98-a16c-8bdb1b92c34d@ursulin.net>
Date: Thu, 14 Aug 2025 12:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Move the memset() function call after the
 return statement
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liao Yuanhong <liaoyuanhong@vivo.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250814093957.137397-1-liaoyuanhong@vivo.com>
 <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
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


On 14/08/2025 11:11, Christian König wrote:
> On 14.08.25 11:39, Liao Yuanhong wrote:
>> Adjust the position of the memset() call to avoid unnecessary invocations.
> 
> Hui? That doesn't seem to make much sense to me.
> 
> We memset the local variable because we need to make sure that everything (including padding bytes) is zeroed out.
> 
> Even if that isn't sometimes necessary because of error handling we clearly shouldn't try to optimize this.

To interject with a curiousity, it is even worse to move the memset away 
from the declaration block when the often enabled 
CONFIG_INIT_STACK_ALL_ZERO is on. At least when they are close compiler 
can figure out it only needs to memset it once. Move them further apart 
and sometimes memset happens twice, yay.

Main point when CONFIG_INIT_STACK_ALL_ZERO is on, and it often is, there 
is no way to avoid the sometimes pointless init. I have some local 
branches which try to address the worst offenders but it is so much in 
the noise that I don't think I ever sent them out.

Regards,

Tvrtko

>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>> ---
>>   drivers/gpu/drm/radeon/atombios_crtc.c     |  8 ++++----
>>   drivers/gpu/drm/radeon/atombios_encoders.c | 20 ++++++++++----------
>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
>> index 9b3a3a9d60e2..0aae84f5e27c 100644
>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>> @@ -770,13 +770,13 @@ static void atombios_crtc_set_disp_eng_pll(struct radeon_device *rdev,
>>   	int index;
>>   	union set_pixel_clock args;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev,
>>   				   &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -832,12 +832,12 @@ static void atombios_crtc_program_pll(struct drm_crtc *crtc,
>>   	int index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>   	union set_pixel_clock args;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev,
>>   				   &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
>> index d1c5e471bdca..f706e21a3509 100644
>> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
>> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
>> @@ -492,11 +492,11 @@ atombios_dvo_setup(struct drm_encoder *encoder, int action)
>>   	int index = GetIndexIntoMasterTable(COMMAND, DVOEncoderControl);
>>   	uint8_t frev, crev;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	/* some R4xx chips have the wrong frev */
>>   	if (rdev->family <= CHIP_RV410)
>>   		frev = 1;
>> @@ -856,8 +856,6 @@ atombios_dig_encoder_setup2(struct drm_encoder *encoder, int action, int panel_m
>>   	if (dig->dig_encoder == -1)
>>   		return;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (ASIC_IS_DCE4(rdev))
>>   		index = GetIndexIntoMasterTable(COMMAND, DIGxEncoderControl);
>>   	else {
>> @@ -870,6 +868,8 @@ atombios_dig_encoder_setup2(struct drm_encoder *encoder, int action, int panel_m
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -1453,11 +1453,11 @@ atombios_external_encoder_setup(struct drm_encoder *encoder,
>>   			(radeon_connector->connector_object_id & OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
>>   	}
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		/* no params on frev 1 */
>> @@ -1853,11 +1853,11 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
>>   	uint8_t frev, crev;
>>   	struct radeon_encoder_atom_dig *dig;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -2284,11 +2284,11 @@ atombios_dac_load_detect(struct drm_encoder *encoder, struct drm_connector *conn
>>   		int index = GetIndexIntoMasterTable(COMMAND, DAC_LoadDetection);
>>   		uint8_t frev, crev;
>>   
>> -		memset(&args, 0, sizeof(args));
>> -
>>   		if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   			return false;
>>   
>> +		memset(&args, 0, sizeof(args));
>> +
>>   		args.sDacload.ucMisc = 0;
>>   
>>   		if ((radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1) ||
> 

