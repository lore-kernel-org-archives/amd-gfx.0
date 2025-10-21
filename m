Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3F5CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 09:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7BF10E2DB;
	Tue, 21 Oct 2025 09:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOmOLgCG";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D1110E2DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 09:30:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b5e19810703so886514866b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761039036; x=1761643836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KN2QwZhoP7kv3EuO6spTtd6lpjar6b5udo6Dl28kHEI=;
 b=AOmOLgCGUaGkm6kWKx23XmlsMI7pX/JnjRBEdJOM0/9XmCYSR2uPa3bTSuTY3rlpZp
 bA5dCR4nGJOUMbBZI6z8JFWLCnOxFGY1Xcg8Z/5pjDksU5yfiIJclrnnvfqfJAW9JdNp
 ZA3fuv70W7xiDac77VsiJwEVpk9IOGxH6x/B2FLdnUJkeE6jwB1pRhMeGKDpcB4WLxkd
 CTXAMpihUAtIzg31S0JE8Imn3PiTGCPHJCutHggY3R4ru1g0OxYzvuAWMbkKZ20CwR4H
 xgCYdDTNGjPiyLXBvmC0LRfGCwO6iW4yrIWDUzNFJM8W2vFxLh/XeuIOVzbCDc0XUs7f
 vGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761039036; x=1761643836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KN2QwZhoP7kv3EuO6spTtd6lpjar6b5udo6Dl28kHEI=;
 b=JSyjvq8w6IoM5pu1pFX6pgE5EEKk8UB8zxH3M1UyOrRhEl9hDN6PSnggr4GxiJQAxO
 TQRGyJ9+ghqjhrAGAEh6kxueYnPk4TsvWjf1DkSzAuNIlS7atJzPrrxr55Q5iOcbf3nI
 Uxjrq0sdDvX+eLhZc7RjnqxCMFicuZbq/YSPwjU8iGTCqnrZCcuH5Hbn/+wzzGGkKiA6
 ILnh9qcpv0bTzRehtv4J2RGqJk3uDDWdNOuO0cgcUruIVxS7t+MjyJpttdL+jsqfSAau
 Xuk+3sYcLwvaXAwpCpjDSwU+7MiLsinYyJyZm7Zrfk1ZjgiSnW+1a+X+/+XfupwayzA5
 mlUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlMIzcIkHATqpj2Icx7m68d8CrWWjPL1iIXo37t5LczyDw+X9jXj7tLgMGUMj6SapAjPow8rRz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/mDYISVUta/DY2hc1nkbtlvb/rCDIE1OJgLeAOTWH+AyLp2u4
 OiU23+oZ/0Q/0FXqSQF7l2VrHl6jbHvkNvzwPR7N18u8JT9sY1hlEYpS
X-Gm-Gg: ASbGncvgzS9M74jTDr+efYjONaTt41AjoTioMIZ+2v1Bi4g105aNRfUzalMS62YZHDY
 +QMj5RoGfa5+UatuPFJBxvEytsIORtwGOfZmMaLFSop6ut+U+nLUJqRlgAkfmO5ehFWkd5G5CYa
 v7+O0WnMiDbFPcYKMr1+qcWIicx4SKiptgRAiLz54TD0qdQ3z7Sp4Td6g0g7a0tQIOAzAoAbHX9
 37srAOsvuZRS4PYApXtjljqpolsrBVwGKwX1P9GaTm/RmjXDR6mtAkbh2IP9AEBH9XoknAYtDGH
 L93ARXCk2Td23yZwhMZ4H4BCSzReN0aexXhL+RRbENrlwwJPNd5HFecqTY644Z+tws8I6j4kZwD
 t4d6GV8sc5VPLsDxK9qXhc3lUY5bK3zFON44EsxFfprjF3oqmxYElzf5RCkt9nq6lfNrHqAwQme
 Sq+9v092HoMgmiTOePlfotjcWUjmyA7VIdlwTe0tz2gsfefEF8d8K7IT8Li7ZnQ9S9bJB/yg8Vk
 uc47nFKoOSCwOBJIKp9FULUiqWQ6Vh5u7PEOIlhm0MrfL/L+0mYFFM=
X-Google-Smtp-Source: AGHT+IFO6kfBr3FF9kit9pULY2yeRwa9enAsOMw5+zSpfjMKunFbu+zZn6gDgE+ImpTRpn7FwQRlmQ==
X-Received: by 2002:a17:907:a07:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b647443cef7mr1847820666b.36.1761039035464; 
 Tue, 21 Oct 2025 02:30:35 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24da:f700:36af:90f4:d5fb:1eff?
 (20014C4E24DAF70036AF90F4D5FB1EFF.dsl.pool.telekom.hu.
 [2001:4c4e:24da:f700:36af:90f4:d5fb:1eff])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e83976a2sm1006518166b.32.2025.10.21.02.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:30:35 -0700 (PDT)
Message-ID: <70dd27f5-a72f-4c0d-9c74-996c005655e6@gmail.com>
Date: Tue, 21 Oct 2025 11:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] Documentation/gpu: Expand generic block information
To: Alex Deucher <alexdeucher@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-4-siqueira@igalia.com>
 <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
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



On 10/20/25 22:28, Alex Deucher wrote:
> On Mon, Oct 20, 2025 at 3:56 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
>>
>> This commit expands the overall explanation about AMD GPU IPs by adding
>> more details about their interconnection. Note that this commit includes
>> a diagram that provides additional information.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>> ---
>>   .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++++
>>   Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
>>   Documentation/gpu/amdgpu/driver-core.rst      |  25 +
>>   3 files changed, 702 insertions(+)
>>   create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
>>
>> diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentation/gpu/amdgpu/amd_overview_block.svg
>> new file mode 100644
>> index 000000000000..8d9ae95bd9a5
>> --- /dev/null
>> +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
> 
> Got a link to the diagram anywhere?  These looked good at XDC.
> 
The cover letter of the series has links to all the diagrams.

