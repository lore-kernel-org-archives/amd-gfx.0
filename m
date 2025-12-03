Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE60D20697
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 13:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE55110E97D;
	Thu,  4 Dec 2025 13:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dBZzyRdt";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A31610E821
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 22:16:26 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso195066fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Dec 2025 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764800185; x=1765404985;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/BQ+aq7QV9wwUu5JnIoDoUm9ffc2261+vDlHLPgQixY=;
 b=dBZzyRdtIZO4iccSV/sdMjsZuUzemP1ybtmiVKw5ffikM4sBbGLUWg3DSgdeTHXeQ5
 bF5Q7Wec9xNeCSOjO9n6z4Db3AMdv8px8BgESebJ1yUo43jtLdZcyIfriPR6rlF5gp85
 bPN3GEQ1LzwDf3sYu5yUG03kxlnmfmaiA+VAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764800185; x=1765404985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BQ+aq7QV9wwUu5JnIoDoUm9ffc2261+vDlHLPgQixY=;
 b=O6Kc6E4S6Ue4Fc9R3F3KNq0k8VACoKRFa67XyclkcUfoutOdls+i0AQLId08eLr3Gy
 Wes3uQbWq8bR/dgSAC6jpQSV2Dg9DfNksCfo0dXAbXU8Vm0lh+3YX+6x4BGIq1MWoSO3
 JLWuGhcVrNm0W7cW5qDESJG78xkVbIghzFQpfKXgH3+Yd2grj+g3rzFQ8TUb2kAPBePj
 3OYM37HOf7xjI1OMfhHrD3vt2Tn8jVP910S+zkP+tBHXv329LAvJ/1MgnfbM2+dDX3dE
 4dgjGX3yD2HadbH/LMCRew9TGoMqRO1wzYaHYZii5r/66i+EThj0Xrns2jtehlNuilq2
 Uxvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWze2u3RX1wYluGvUO/RyKdWH0XMirfiFc0EyS2Ofzvp72Q5GxW0af7/gPiWt8rD6hpa6hpiB+B@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJdhMFQ8k9mOz31KunT358Zwn7ggSu3kUOD3omiUTldQacBz15
 e8UPZJHoa+tLfquQy1JxPX2ghEjZ761K0gEkrUr1En+UwNzKn4uOjBIzUtwZXIA8l6M=
X-Gm-Gg: ASbGncsvA0QQn2QIwmvfLWmnsMDeCJy4Qb1mzAIlmCApHZ8iZUrzDauebWvah+iT3/r
 Kwu7LXaqvUKvfuPVv/EfIqJzQaFZdsiJPXdc/U1Y4OTou+SEFm6nJ90q5JB+ObGD/zd7zW7PR6f
 E8XeMmiSTnuv/S6nAif2HErUTDERVHLykELjTa7fAF0bjutTZPFquXJCIo3Qj0uqhBav42s7OHy
 c+imV+0luHJTxjvTBCsnfwhGTdxMaYtSmHmQhdXZTg7o/9NcKzk5eOsMnwZ9275pb+M/OSAx1sn
 pFyikcWOEr2jrB1sMqeNKoFx/hwUmEVLOFg+bQCPXhpZ2jEpG/HZS9wG2kdgwN3ZDpl5gMEZf2W
 EPYKTX4nrCc/GvH3itE0pQ2kMhyv1WyNP15ume2BwfjBjKSY7iDDe+yjh
X-Google-Smtp-Source: AGHT+IGLm/MMHH27TVNlqYSIvX9zWGRL2Q08ixVb50qRPPkAoiUKIhGS/PeUtokINd7b7Xw8Q53j8g==
X-Received: by 2002:a05:6870:d607:b0:3ec:5a09:3014 with SMTP id
 586e51a60fabf-3f50634f9cemr438772fac.3.1764800185136; 
 Wed, 03 Dec 2025 14:16:25 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa34d4fsm15449fac.5.2025.12.03.14.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 14:16:24 -0800 (PST)
Message-ID: <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
Date: Wed, 3 Dec 2025 15:16:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18 amdgpu build error
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:40:42 +0000
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

On 12/2/25 14:23, Guenter Roeck wrote:
> On 12/2/25 13:01, Shuah Khan wrote:
>> On 12/1/25 19:31, Guenter Roeck wrote:
>>> On Mon, Dec 01, 2025 at 03:17:49PM -0700, Shuah Khan wrote:
>>>> Hi Alex,
>>>>
>>>> I am seeing the following make error on Linux 6.18.
>>>> I started seeing build failures since rc7 and rc6
>>>> build was just fine on the same config file.
>>>>
>>>> LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.o: error: objtool: elf_init_reloc: .rela.orc_unwind_ip: reloc 39935 already initialized!
>>>> make[6]: *** [scripts/Makefile.build:503: drivers/gpu/drm/amd/amdgpu/amdgpu.o] Error 255
>>>> make[6]: *** Deleting file 'drivers/gpu/drm/amd/amdgpu/amdgpu.o'
>>>> make[5]: *** [scripts/Makefile.build:556: drivers/gpu/drm/amd/amdgpu] Error 2
>>>> make[4]: *** [scripts/Makefile.build:556: drivers/gpu/drm] Error 2
>>>> make[3]: *** [scripts/Makefile.build:556: drivers/gpu] Error 2
>>>> make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
>>>> make[1]: *** [/linux/linux_6.18/Makefile:2010: .] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>
>>>> I tried "make clean" and "make distclean" just in case, still see
>>>> the same error.
>>>>
>>>
>>> My test system does not report any problems. What is the configuration
>>> and compiler ?
>>>
>>
>> My one test system didn't report any problems. The other one did.
>> I am using gcc and the config is the same as the one used to build
>> 6.18-rc6 with no issues.
>>
>> I will keep digging to find what's wrong on my system.
>>
>> gcc version 14.2.0 (Debian 14.2.0-19)
>>
> 
> Interesting. That reminds me ... I used to have that kind of machine specific
> problems when building with CONFIG_RANDSTRUCT enabled. I worked around it
> by using gcc builds with plugin support disabled. In my case, there was
> nothing wrong with the system, just that each system has a slightly different
> hardware configuration which somehow influenced structure randomization, even
> across "make clean/distclean".
> 

CONFIG_RANDSTRUCT is disabled and so are the GCC_PLUGINS in my config.
I am also seeing issues with cloning kernel.org repos on my system after
a recent update:

remote: Enumerating objects: 11177736, done.
remote: Counting objects: 100% (1231/1231), done.
remote: Compressing objects: 100% (624/624), done.
remote: Total 11177736 (delta 855), reused 781 (delta 606), pack-reused 11176505 (from 1)
Receiving objects: 100% (11177736/11177736), 3.01 GiB | 7.10 MiB/s, done.
Resolving deltas: 100% (9198323/9198323), done.
fatal: did not receive expected object 0002003e951b5057c16de5a39140abcbf6e44e50
fatal: fetch-pack: invalid index-pack output

Happy start to the end of the year :(

thanks,
-- Shuah

