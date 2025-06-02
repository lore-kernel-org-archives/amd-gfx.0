Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E10C5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 13:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FDF10E51C;
	Mon,  2 Jun 2025 13:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h48Z9llq";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677C010E51A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 13:03:22 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a585dc5f4aso19441421cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jun 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748869401; x=1749474201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+NFmMTWeskFJyv2llzd2ZQIJhS7yCVaqcy5jfmqGvZ8=;
 b=h48Z9llqTXYFsDlhE2TyYW3CauI9K1VzIfSHmL0LqAJK9b5OsKM+3Lf29HQdXbdgqm
 PFyzt+X7XtQ1LVzvO0cWKDdepR1H8bXSKYFnmu1Vr1KyamYrbbO3QMQF22MV7STOzQZB
 YrrDxwh/kxh1HGvg2P5Ttv1gAkVD/UGtEjFvNWUkgxw510R0uBdgmcEK9JN2KRf8ObjB
 T69Sf/McO9h8IyoiaEu/PsG9vzHMKKibn+klBsYt/0KW+I8qe4laynNrAXy8OmXGggEo
 +BI+oSd3mCyCPvrS4rCkdxMQ6PIfw+bZfM3+WU1I+H2J2ca1dVloznTDYvu+2ObSXZr6
 70Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748869401; x=1749474201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NFmMTWeskFJyv2llzd2ZQIJhS7yCVaqcy5jfmqGvZ8=;
 b=hCfajPvFeTE3TeywMv998ws6c2ks3FDti4BuJAAECAAoK9F3kjdlk9wHexCCsU+VfD
 qcNh/R75Lh1Tq8SokavoJmF4f89NJOqIr+ZVrKgkRNocXPh5ErBSBK9xcyIL7QfmVBbh
 D1IYPnVaxU7JUR6Ndm1Io4tbaOqoLAjGTslVfTM0AhRk1wI6YhxqTdSVOZRCFIsWw5O9
 WdZS61kO5/VyvlN60sumX7YTCETysVDcH5dmFKJz1y9C4kKWxWBz4z+2F21FK2TSJGUR
 fBDzmW1j4rFI7BFTQxVu9dwj52wFaxn/M/zNho4vORgYw+lnwTBtISTt7KRTevkBga5K
 dDFg==
X-Gm-Message-State: AOJu0YyacxwTsWaeLAilgNMresZ9xICyA0ViJdnBkCxJBmzgSfgqOdOQ
 YvfDRQgNIlhbCTtmE8tE+IZQd1ubA9xwrr9UIUs8iPhxx6Iz3KPzp+rT
X-Gm-Gg: ASbGnctwIa0jPo4rtUlZQcQgtRd9OblEwUibxCEiei/GDspdAgRLkHIyowUUm3CHjux
 +9wjFVONanRdBUTHxxPHOBkjhxDUe7jERgoqpZNM4CFcTvlG9eQOAagicL+yOEf82OhnpOIUC04
 ooeExIH+LN4EqrYi3QplM2+MLyFWKFqFYSbg7EslY1duiigPPuREsBwaZe6K01750GRz80v8j2b
 13lnw0uG8M4PZsO6T+Y3Oy88TymomqmUYffu+8uZc5MPb8Opqa9YNncaJIWWoGh6EfegfPld2g/
 n7qKd4XqE/JxsddoohP6I9Q3UZgcki/xo72JpzEkiwxBuLhGFvYi/hKC8UfG4UUyWllFmbI=
X-Google-Smtp-Source: AGHT+IGyQ7ewgiR0E18sww2kgRLTnuBofCL6/beGj2pQdrNQq6KpQmOZEQLEkCnFBwRZuv5lHT03aQ==
X-Received: by 2002:a05:622a:229f:b0:476:980c:10a9 with SMTP id
 d75a77b69052e-4a44005d830mr192916461cf.21.1748869401301; 
 Mon, 02 Jun 2025 06:03:21 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 d75a77b69052e-4a4358d3053sm55959901cf.41.2025.06.02.06.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 06:03:20 -0700 (PDT)
Message-ID: <4b919d57-1f90-48e8-9c7b-5a1814c4a07b@gmail.com>
Date: Mon, 2 Jun 2025 09:03:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
 <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
 <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/2/25 6:00 AM, Christian König wrote:
> Hi John,
> 
> first of all thanks a lot for taking a look into this.
> 
>>> Okay, I did a read and compare after each write.
>>>
>>> Both writes seem to go through on both the Kaveri and s9150:
>>>
>>> Kaveri (512MB UMA Buffer):
>>> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF41FA00000, addr=0x00000001, wrote 0x00001001, read 0x00001001 [same]
>>> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF41FA00000, addr=0x000000F4, wrote 0x800900F4, read 0x800900F4 [same]
>>>
>>> s9150:
>>> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF7FFA00000, addr=0x0000000F, wrote 0x0000F00F, read 0x0000F00F [same]
>>> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF7FFA00000, addr=0x000000F7, wrote 0x800900F7, read 0x800900F7 [same]
>>>
>>
>> I've also confirmed the patch works fine when segments other than
>> [0, 256M) are used.
>>  
>> E.g.: Both init and VA-API playback work fine with a UVD segment of
>> [1792M, 2048M) on Kaveri with a 2G UMA buffer.
> 
> Oh, that's a very interesting find. Could you try to turn around the way the patch works?
> 
> E.g. instead of forcing the UVD FW into the first segment, change amdgpu_uvd_force_into_uvd_segment() so that the BOs are forced into the same segment as the UVD firmware.
> 
> That would resolve my concern that this could overload the first segment. The feedback and message BO are usually rather small (4 or 128k IIRC), but the firmware is a couple of megabytes in size.
> 
> When we have other FW and VGA emulation buffers in the first segment as well then that could result into clashing that segment to much.
> 
> Thanks,
> Christian.
> 

Okay, yeah, that should make for a significantly simpler fix.

>>>>> I will try to find a Kaveri system which is still working to reproduce the issue.
> 
> I unfortunately couldn't find a working box of hand. Would need to search in our HW stash for a box which still works and get that shipped to me.
> 
> And that is overhead for this issue I would rather like to avoid.
> 
> So if you can come up with a simpler patch which works for you I'm happy to take that.
> 
> Regards,
> Christian.

Sounds good.  I'll get started on this variant.

Thanks,
John

