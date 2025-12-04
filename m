Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7248CD2E03F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BE610EA3E;
	Fri,  5 Dec 2025 08:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRiVercW";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C82210E9E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 23:28:36 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-3e8f418e051so1150108fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764890916; x=1765495716;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TY8vn4+rw5BlELkE55Y40GYmlU2AL+AMWiRVce63tcM=;
 b=WRiVercWNDEgMa5PSRwb8OzaQjkwD+vMDuC8ORt/QVPiKJF56rxQUFqF6h/QvHvv9C
 JRZeSpdu90YFzqCGcGefURk90kjN9mLU5EUuAo9MHu6XQUsaqr9WUijpaa7EMKGtXOLN
 KFzlCJkSkMqnswLDltewxlMw9QQxcP0rC43pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764890916; x=1765495716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TY8vn4+rw5BlELkE55Y40GYmlU2AL+AMWiRVce63tcM=;
 b=Pckcq9DVDYL7OKm2dC7CSm+PO2wpSeRIbIIRdQ4bSMPFqaCCe/Y/C/c3NuGtGiM1XQ
 qmMDUD01+kdoDaAbGv8C1ouM7yZ+bOu1cipdUV+4I/wQX7xiyYQ4OOaRr73g2AN+KyWe
 TJeHqO+CBynN4HCQRqOrZ1irUo4UVzaV+WnEKMGJZ9vmwHLq+ULpakGvSpb/4GFhMkoi
 OKvZ5xW8OYIYg+CULF9xN1heHZa3+wn5CGaPcIWYDRRwLlVtt/gWWPbEdhEctZvHYVAT
 V0ZafKknH9yJ8/1waTrRlMANs5aO1Hk25pLrLkwbLHXK5sJcMSUQ0rDVdo2qkJwP5JNk
 hn/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPHjnghzhcYjencLf2pWOnCWwgEdorFgTj8JGBJQvAtH2E2rxStlWmEU67j+1X+xw/XBNX/yjB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzBUkjDPFENCUk9GH5P3hiIcU2k4cjQWmaMX9WPqDE0+PjpJ7k
 3SqQFQA/dfZCM7jFPUFelBYVTfzmN5u3eHf2Zc5oTlRdgzSCxv55febWaRY7P2jbYbI=
X-Gm-Gg: ASbGnctaq1eOV1ayIy4n0ToBCSpPDje1E3SjMtkhqbfya7tmEmG9AlKrLXuQLgtXHvd
 J0fsI9YZVHRPligDCH1MRWlJJpU0ISpMKDHszZFK5oqybdT2twbkjotNQDYXV+BgTKorBhtRd1p
 8k9roi2bOgvXBfCekrkD5d9sBsyczHzylawfB4tT6nd7MCoLjz8m01132jwWwpVoAxmsuAzh+MS
 6ljDgEr0VhhoewYqXKcq7xK3eWsiD/ZMRRLuRir/h+BguaLmU2XEf1QOwzhftjGB/aiHCDewVKb
 o8eGB0ZKt3WuIsS/bBETIC+1AflCoPPhdb1U2OB6rcUmFC+Pq2/vRQYJ3PK5QctUOfQO86RDhTS
 1oYLG8d8oUEOZiH+ga2Sm7kEugZTu9tmJgGtV+1p/3ZuobHD4bY/NNZ7iBZlaZcCkDlsIEtnGHs
 bFmYqrMZzQAcfLjX+5e6Zds68=
X-Google-Smtp-Source: AGHT+IHaMdSIvMY4kJabIh50Lp2Y7vLsnF75nwPDZ+uvTeHchqLesHf2HXJ3/okGx1/CR50Bnu4U5Q==
X-Received: by 2002:a05:6871:2941:b0:3c8:d325:b7ac with SMTP id
 586e51a60fabf-3f1691860c6mr5140679fac.4.1764890915718; 
 Thu, 04 Dec 2025 15:28:35 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50b5123f5sm2197586fac.13.2025.12.04.15.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 15:28:35 -0800 (PST)
Message-ID: <60fe7660-f3fb-4c94-b21f-20ebc9e14f5d@linuxfoundation.org>
Date: Thu, 4 Dec 2025 16:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18 amdgpu build error
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 akpm@linux-foundation.org, Alexander Deucher <Alexander.Deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
 <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
 <1f31b86d-283c-4878-92d0-ab90aed0c58d@roeck-us.net>
 <5af4522e-30ab-4eec-a861-c2760cdabd4f@linuxfoundation.org>
 <2bc690ca-fa57-46fa-949b-28b5441cd364@kernel.org>
 <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
 <CAHk-=whd-k3GhNGvVmP7W2p1d0d4ctqJ8iCuG8DbyKzgNqCL+g@mail.gmail.com>
 <3b6d6e50-91ac-435e-adad-a67d4198a5b5@kernel.org>
 <3cd2240b-ec2c-45d0-b73b-b66c83e75b9f@linuxfoundation.org>
 <CAHk-=wiEXy+7Gd3ONQ-v0e61e6qAmrtk+WE2dpW_61p83nMgXw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHk-=wiEXy+7Gd3ONQ-v0e61e6qAmrtk+WE2dpW_61p83nMgXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 05 Dec 2025 08:19:27 +0000
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

On 12/4/25 16:23, Linus Torvalds wrote:
> On Thu, 4 Dec 2025 at 15:20, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> I didn't see any problems on 6.18.
> 
> Ahh. So it might be just that buggy commit adfb6609c680 then, and the
> fix already being in rc7 (and final).
> 

Yes - correct.

thanks,
-- Shuah

