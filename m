Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE407D20694
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 13:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B718510E89C;
	Thu,  4 Dec 2025 13:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btrrAhUU";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F8610E1AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 02:34:33 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7c6da5e3353so400564a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Dec 2025 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764815671; x=1765420471;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J15Qzup8zpCFV/gNARQXdZ6OyPMzPDnFJCLC0cemZ8E=;
 b=btrrAhUUAM7uAc6BGokXFBTkZOUp0eVXznSIQitZMhXnwbm/q2oVD5FCEmwfBM6RWJ
 NyyqtiWUXIMEVZtthvgs4Ao+Mj37OeoraBtcK9MVdTTBaxRbNYtn1UU52IIvGtXVTYqp
 93akYRrYE3UEA2mxXK61z+xdIDVK25zIdqscQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764815671; x=1765420471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J15Qzup8zpCFV/gNARQXdZ6OyPMzPDnFJCLC0cemZ8E=;
 b=rVAIXy2ZmX5C4i4yk4GRVcE0YvaMsC2v2tFVek46C0FvDDGhwXGW7f8YDv79NMUuuS
 Q1xGZejp6+Pe+Vzo9zkw5gnr4kNbD/9W12wy/j11r2UBOjRau3bppGsedpIWPVYteF4+
 AoFkgCGzg0TBY/DjLEwuxIa/Z93odt/pzFGb8/TDMLuhLFpHxx1QDKCXVoea7xb9RJol
 rb3PcT4jrTPwp68nbuamw1HS3EXZkClRLlymWAaA67SGuSzxljMI1P8VHCtyKZH4GqgF
 h8KK+VMmI7f8Bs81XOu7YhI1YjozIGlgvpndjf1u6NWjHqXpj01h76IDqNHf42KlSt97
 OLFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK9AdCY3RbR21VdlOygPE31ZeG3bMDCOCIv7KZbIuwgTyP5iJmGOnIbBW08AWMhPxuRvPFkUnK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/O3ZS2jjQWRPxIwNQ31p8Ie9G11M0Nh+ZIpqz1y3+zDg3JW7U
 Kko5Y21AP+ip6SpvgGMJthNMfn+WWaz4ZKzqeKtq+qlnuhy+/LGDMGBhL8wcLjFlGAs=
X-Gm-Gg: ASbGnct/VmrAMI4zhzXwKf+egMF/jpAjFbcKh72ElkopMEidEM6GW8l2ALAMAfXlp6o
 h4j6V5rUjsbJ7I8n58WOHC+a+LzPI2bZkhzRkd+r/dRUf4sV/aUdQegke81ywBxfed0B7JvEgBi
 9h57RNWi6/POeEVboHrmMYLgIi8qzEB59VUayrWS2YlrHuI7jEGqzlKZbRTI4sWo35oKx9ZT9ub
 k6Ju+iMn+vhKLFRvgY5PXO9acYD70Pbro8U7/upM71mZKe0kuBf1A04yVgXD2KBqJhT/rDzatMT
 +lH6uIskT7I3jCVEKEXp0HWDyB4n01lHPQ5xSMeL4W+RZXy2omdgxU9mC0Qb9B7M6th6IG7gnIE
 E5/yyOo0ymVl6N/c8LXVar7iUfE0LQgVghCwp820XOCp7Td2REhLdfzTS8V28ygyClg9/3vjeto
 3lWA4KCcneGYgDsaG5SQCu+Ls=
X-Google-Smtp-Source: AGHT+IEWnMa2HXMsFLErerMFo+SUotzMPb4bdwSPX42eEhpYWTcWb/bFzyKol4nu8Pe7T8YoPPT7HQ==
X-Received: by 2002:a05:6830:411a:b0:799:de78:29d1 with SMTP id
 46e09a7af769-7c958b91783mr870804a34.15.1764815671317; 
 Wed, 03 Dec 2025 18:34:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac84d2bsm415620a34.18.2025.12.03.18.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 18:34:30 -0800 (PST)
Message-ID: <5af4522e-30ab-4eec-a861-c2760cdabd4f@linuxfoundation.org>
Date: Wed, 3 Dec 2025 19:34:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18 amdgpu build error
To: Linus Torvalds <torvalds@linux-foundation.org>,
 akpm@linux-foundation.org, david@kernel.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1f31b86d-283c-4878-92d0-ab90aed0c58d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/3/25 18:06, Guenter Roeck wrote:
> On 12/3/25 14:16, Shuah Khan wrote:

>>
>> CONFIG_RANDSTRUCT is disabled and so are the GCC_PLUGINS in my config.
> 
> I guess that would have been too easy...
> 
>> I am also seeing issues with cloning kernel.org repos on my system after
>> a recent update:
>>
>> remote: Enumerating objects: 11177736, done.
>> remote: Counting objects: 100% (1231/1231), done.
>> remote: Compressing objects: 100% (624/624), done.
>> remote: Total 11177736 (delta 855), reused 781 (delta 606), pack-reused 11176505 (from 1)
>> Receiving objects: 100% (11177736/11177736), 3.01 GiB | 7.10 MiB/s, done.
>> Resolving deltas: 100% (9198323/9198323), done.
>> fatal: did not receive expected object 0002003e951b5057c16de5a39140abcbf6e44e50
>> fatal: fetch-pack: invalid index-pack output
>>
> 

Linus, Andrew, and David,

Finally figured this out. I narrowed it to  to be the HAVE_GIGANTIC_FOLIOS
support that went into Linux 6.18-rc6 in this commit:

 From 39231e8d6ba7f794b566fd91ebd88c0834a23b98 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Date: Fri, 14 Nov 2025 22:49:20 +0100
Subject: [PATCH] mm: fix MAX_FOLIO_ORDER on powerpc configs with hugetlb

This appears to be large change than the powerpc scope. It broke my workflow
completely. I sent a revert so this doesn't cause problems for others.

I can reproduce this problem om two systems - with this commit

git fetch-pack fails when cloning large repos and make hangs
or errors out of Makefile.build with Error: 139. These failures are
random with git clone failing after fetching 1% of the objects, and
make hangs while compiling random files

These failures are random and confusing sending me down the path of
looking at tool chain. Without this commit, I can clone and build
kernels on the two systems I was seeing problems.

thanks,
-- Shuah


