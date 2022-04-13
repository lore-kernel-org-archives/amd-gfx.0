Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0BB10FB92;
	Wed, 13 Apr 2022 07:05:10 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8386510FB8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:05:08 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae908.dynamic.kabel-deutschland.de
 [95.90.233.8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C1DC561EA192C;
 Wed, 13 Apr 2022 09:05:06 +0200 (CEST)
Message-ID: <b63f60fd-d430-48c3-7b4a-3adf4184add6@molgen.mpg.de>
Date: Wed, 13 Apr 2022 09:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Update PF2VF header
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bokun Zhang <Bokun.Zhang@amd.com>
References: <20220412213116.131578-1-Bokun.Zhang@amd.com>
 <b1f77e9a-5100-1e4a-149e-f63b2214e401@molgen.mpg.de>
In-Reply-To: <b1f77e9a-5100-1e4a-149e-f63b2214e401@molgen.mpg.de>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Removed unintended paste in second line]

Am 13.04.22 um 09:03 schrieb Paul Menzel:
> Dear Bokun,
> 
> 
> Thank you for rerolling the patch. Please add the iteration/version in 
> the subject next time `[PATCH v2 1/2]` or so.
> 
> Am 12.04.22 um 23:31 schrieb Bokun Zhang:
>> - Add proper indentation in the header file
> 
> Please use that as the commit message summary, and the subject/summary 
> as the title for the cover letter? Maybe:
> 
> drm/amd/amdgpu: Properly indent PF2VF header
> 
>> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 95 ++++++++++-----------
>>   1 file changed, 46 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>> index 7326b6c1b71c..65433cbb00c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>> @@ -1,34 +1,33 @@
>>   /*
>> - * Copyright 2018-2019 Advanced Micro Devices, Inc.
>> + * Copyright (c) 2018-2021 Advanced Micro Devices, Inc. All rights reserved.
>>    *
>> - * Permission is hereby granted, free of charge, to any person obtaining a
>> - * copy of this software and associated documentation files (the "Software"),
>> - * to deal in the Software without restriction, including without limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom the
>> - * Software is furnished to do so, subject to the following conditions:
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>>    *
>>    * The above copyright notice and this permission notice shall be included in
>>    * all copies or substantial portions of the Software.
>>    *
>>    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>    * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> - * OTHER DEALINGS IN THE SOFTWARE.
>> - *
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
>> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>>    */
> 
> The header change seems unrelated from indentation?
> 
> […]
> 
> 
> Kind regards,
> 
> Paul
