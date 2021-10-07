Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4DEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 06:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43875611AE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 06:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43875611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD5D6E830;
	Thu,  7 Oct 2021 06:14:23 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D286E830
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 06:14:22 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id r10so15469504wra.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gI5co4o1rYvGRdi2WZK3gX+GZfZ3PfZ5qkVmEV61ypM=;
 b=ipDEUW6fCIZj20IJZstMPYxQ5mXG1IB8w198w1WbBiD70rzgEr3CURVfEnGenTJJ8C
 uxmcxXru1MZ4v2vA5sc6AgUZRHqHm2goP6/NKjqRuQmypVn9DTxrGiWDfdZ0qksjIQVe
 afgs+fOmqP5uKYzoxOyE7U7eur5LObBtvcca7cK1q03L0t3hO44ACd8OofMwpt8dmHOv
 hrj+2yQ79BZ9sD01FXkhgTE8sMBMMWiaGmLd2NfK1zK/GmJDOQzoFexdrN/kCigCb4sz
 otor5Gy84gq1s9Ck2WUKEyaMqG6DMuRONHolPyCmYL0Y+9Lv03sndKZze5kYNPLV194D
 S5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gI5co4o1rYvGRdi2WZK3gX+GZfZ3PfZ5qkVmEV61ypM=;
 b=O6ubN/sR1+bxTWmiGdKoe2BQsalNKuuUewDkYv5/kOOWJAfFXYBGJsRflpyrmMGqTm
 HssNeE+wIOhyDQXUyLW2FaVqBl5/oLk8u8wdu09klczm5t/iZErL6blOcY7G0zo2IpwI
 6e4sSEXVbHf8vSgKYNg6cxFTQ5d8tRcNoQwRkifqhywf9lTw6Zi/cwHFMJIHYwmMnR5N
 AEnqRjWG8+JDCvV03GWsXA5TvZIlCbLhX0/7o3D9x51sw2z1XwAWoYhHJiU1Lz8nAn1X
 /QVyJ/fwhG3PmqrHetUwj48ehAHUgDKuiptstYKInC+jqDuxHezwwnV66wTNmwui/k8n
 xFsQ==
X-Gm-Message-State: AOAM5339ukCvPqtsTZwSIyRmv8Z0k8dghkbi3Iu2YYOAvf/kJ0qJFHun
 YZcjrB3OUC2PQ8Lmi/kuyI1sZI0f/ts=
X-Google-Smtp-Source: ABdhPJwnStOUraV9oDx+23WCZQ+1j6dkJGavjzn+ZPg0qrN1LiCtA29uqSx3HfJKxuDs0PJhy03JgA==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr3033384wra.373.1633587260830; 
 Wed, 06 Oct 2021 23:14:20 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id a25sm7147675wmj.34.2021.10.06.23.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Oct 2021 23:14:20 -0700 (PDT)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
 <CADnq5_M2y1tUAcUPNOrmB=pHfBGtnqMtTrw24ZC45202hg-kYw@mail.gmail.com>
 <YV351s3Fyhnmen9g@zn.tnic>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d3001b64-7b31-a0ab-d7d9-44b145d412f2@gmail.com>
Date: Thu, 7 Oct 2021 08:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV351s3Fyhnmen9g@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 06.10.21 um 21:32 schrieb Borislav Petkov:
> On Wed, Oct 06, 2021 at 02:21:40PM -0400, Alex Deucher wrote:
>> And just another general comment, swiotlb + bounce buffers isn't
>> really useful on GPUs.  You may have 10-100s of MBs of memory mapped
>> long term into the GPU's address space for random access.  E.g., you
>> may have buffers in system memory that the display hardware is
>> actively scanning out of.  For GPUs you should really only enable SME
>> if IOMMU is enabled in remapping mode.  But that is probably beyond
>> the discussion here.
> Right, but insights into how these things work (or don't work) together
> are always welcome. And yes, as 2cc13bb4f59f says:
>
>      "... The bounce buffer
>      code has an upper limit of 256kb for the size of DMA
>      allocations, which is too small for certain devices and
>      causes them to fail."

To make the matter even worse, bounce buffers don't work with APIs like 
Vulkan and some OpenGL/OpenCL extensions.

In those APIs or extensions the assumption is that you can malloc() 
memory in userspace, give the pointer to the kernel driver and have 
coherent access with your device and the CPU at the same time.

In other words you don't even get the chance to bounce the buffers 
between CPU and device access because they are accessed by both at the 
same time.

Regards,
Christian.
