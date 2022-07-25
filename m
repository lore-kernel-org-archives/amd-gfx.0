Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A992CCA47E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D248FAB7;
	Tue, 26 Jul 2022 12:54:22 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE8A10E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 22:40:43 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id y24so11699714plh.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=+gsloq9DrRj40wgtL1Bj5I/zKXAptLmoCHjL2BnUObw=;
 b=qUtmtma6HAQJVGOAzv8j1zpuhY/PD+n2lLtrvXqfLjDEbW/92oJFBSdQSqvu0vrBl1
 6wA5y5aBh4XKOitO+OtYvo6eIpaT54/UGk0fdpdZZrk5dWPezSTLL1T1dX5bNd6Fejmy
 wLZQ58Uh9DVm4Q9Vwasenaz16K7iKmeICk5jmwSYudByNWr4HffVTxdC0gZv5NSfXM7d
 h38haZ1YMo7ToVhCDJr7KtgZ+MhXyr2vZFb8eeHqZk9oqtrUHMJN2887ZizkRpG4a9Xq
 a/V6LSSiy7mRYJSLoWW67r75jEdfwxX8h22LSYiYxrZqvGTo1UdtTggGJHe6S4fqi1gM
 pIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=+gsloq9DrRj40wgtL1Bj5I/zKXAptLmoCHjL2BnUObw=;
 b=339MCkPqcKp/rSMS104CJn7/NoF1nVmtLl1nilrhWq+XF/1xw7mOUxxo3ojsbedSAX
 C4+rp5Gvw0yo8oUl/NQK7OTOoAaNoXAYXJvYz6ulaK8+jLq5sJKjezDsCqSnmxd2vzzZ
 p5u/G7xL7xX9bkMIwnu7+Sl3uQnEcwTeuE34TH5vCBZqzFLxdKcrIozigPJGuaSL8gOn
 MuABh0fiWuImFBcRChQBUoyZ1aZKQkNk4tt6dMuMcE7oXflvXEGTedc84WpbqONIxXzM
 6pYXReWmGXtLLy4e/u7Raa9a/950tY4B87Kt/hsNp2Bu2JxD833bAj6Gsf1k+2n0+Gj8
 WFLg==
X-Gm-Message-State: AJIora8zDSETHpEhf/1dQVcXFoRzKTXfWZQQ30X1fGefYz9N+lq5ttgD
 IUrdCfZnePVt06OgrVN7auc=
X-Google-Smtp-Source: AGRyM1sY6xs2vLFIRjWV2bnzc91l1WGwCvv+DJXVUNptBy7iZlV1vdS9ruecuC6uACy/vvyxKuwSiQ==
X-Received: by 2002:a17:902:ba91:b0:16c:6b8e:cd06 with SMTP id
 k17-20020a170902ba9100b0016c6b8ecd06mr13859080pls.33.1658788842670; 
 Mon, 25 Jul 2022 15:40:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z14-20020aa7958e000000b0052a75004c51sm10440383pfj.146.2022.07.25.15.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Jul 2022 15:40:41 -0700 (PDT)
Message-ID: <5ef016a9-c1bb-91dd-454d-504d26074477@roeck-us.net>
Date: Mon, 25 Jul 2022 15:40:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Timothy Pearson <tpearson@raptorengineering.com>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
 <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
 <20220725204217.GU25951@gate.crashing.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
In-Reply-To: <20220725204217.GU25951@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 26 Jul 2022 12:54:21 +0000
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
Cc: =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/25/22 13:42, Segher Boessenkool wrote:
> On Mon, Jul 25, 2022 at 02:34:08PM -0500, Timothy Pearson wrote:
>>>> Further digging shows that the build failures only occur with compilers
>>>> that default to 64-bit long double.
>>>
>>> Where the heck do we have 'long double' things anywhere in the kernel?
>>>
>>> I tried to grep for it, and failed miserably. I found some constants
>>> that would qualify, but they were in the v4l colorspaces-details.rst
>>> doc file.
>>>
>>> Strange.
>>
>> We don't, at least not that I can see.  The affected code uses standard doubles.
>>
>> What I'm wondering is if the compiler is getting confused between standard and long doubles when they are both the same bit length...
> 
> The compiler emits the same code (DFmode things, double precision float)
> in both cases, and it itself does not see any difference anymore fairly
> early in the pipeline.  Compare to int and long on most 32-bit targets,
> both are SImode, the compiler will not see different types anymore:
> there *are* no types, except in the compiler frontend.
> 
> It only happens for powerpc64le things, and not for powerpc64 builds.
> 
> It is probably a GCC problem.  I don't see what forces the GCC build
> here to use 64-bit long double either btw?  Compilers build via buildall
> have all kinds of unnecessary things disabled, but not that, not
> directly at least.
> 

 From what little documentation I can find, there appears to be
"--with-long-double-128" and "--with-long-double-format=ieee".
That looks like something that would need to be enabled, not disabled.

FWIW, depending on compiler build options such as the above for kernel
builds seems to be a little odd to me, and I am not sure I'd want to
blame gcc if the kernel wants to be built with 128-bit floating point
as default. At the very least, that should be documented somewhere,
and if possible the kernel should refuse to build if the compiler build
options don't meet the requirements.

Guenter
