Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305BDD1950F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C478310E48B;
	Mon, 26 Jan 2026 20:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fal2Mwg9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC55C10E48B;
 Mon, 26 Jan 2026 20:28:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0091360097;
 Mon, 26 Jan 2026 20:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F86C116C6;
 Mon, 26 Jan 2026 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769459331;
 bh=6AGIQTIAuc+1DK7b99fA31po9zh/FI8vc1CCrG6JgzA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fal2Mwg91TB1qWA+QR2oXUK1G8Nt54ERGbmg+WwntpMPNKYzXfc4U/icB0PDZSplf
 cE/ui7zPl0XojbcOrWyeppAUDi5ebkcYo083mKFjRBmXy2fF0N0U2YiI+Bh5lqAI8g
 dDEizX1dEQYnUO2h/QOYSBlugpImNiXtC2Le8BYBegHlm1o9zARzV9lqsrOxWteqJu
 DpBRUnOrrz6dHP4NPcE84VNwSHwrb/ZOSzz1wEnaHErQ0E92Fpc/wfjZXYHypqmwno
 prMQgJqlEYiS9pX0bAKPMmrRQYlo62qWxOFO+pLZc3y0h4Ii+qEHJN7jALmxGusAf5
 z7BXR/E+h2//Q==
Message-ID: <e8e1e479-0c13-40f2-b9be-d87e4503dcb4@kernel.org>
Date: Mon, 26 Jan 2026 14:28:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
To: Alex Deucher <alexdeucher@gmail.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ionut_n2001@yahoo.com, linux-kernel@vger.kernel.org
References: <20260106125929.25214-6-sunlightlinux@gmail.com>
 <77fa0344-3507-420e-9d77-d454ace55cfd@amd.com>
 <20260126194057.7376-2-sunlightlinux@gmail.com>
 <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
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



On 1/26/2026 2:25 PM, Alex Deucher wrote:
> On Mon, Jan 26, 2026 at 2:52 PM Ionut Nechita (Sunlight Linux)
> <sunlightlinux@gmail.com> wrote:
>>
>> From: Ionut Nechita <sunlightlinux@gmail.com>
>>
>> On Thu, Jan 8 2026 at 13:36, Christian König wrote:
>>
>>> Question is why the KIQ is not up and running before we do anything with it?
>>
>> Thank you for the feedback. I completely understand that my patch is
>> just a workaround and not proper engineering - you're absolutely right
>> that the real issue is KIQ being marked as ready before it's actually
>> functional.
>>
>> I don't have experience with GPU drivers and video subsystems, so I'm
>> not familiar with the proper initialization sequence for KIQ. I'd prefer
>> not to keep a workaround for this issue in my tree.
>>
>> Is there a proper fix available, or could you point me in the right
>> direction? I'm happy to test any patches on my AMD Cezanne (Renoir)
>> hardware where I can reliably reproduce the issue after hibernation.
> 
> Can you get a stack trace when this happens so we can see the call chain?
> 
>>
>> Also, regarding hibernation support: you mentioned that hibernation is
>> not generally supported with the driver. Should I expect other issues
>> beyond this TLB flush problem, or is this the main blocker?
> 
> The biggest issue with hibernation is that it's not compatible with
> secure boot so most distros don't officially support it.

And by extension of this it doesn't get as much testing as s2idle/s3 do.

>  The other
> issue is that when we go into hibernation, we need to evict the
> contents of VRAM somewhere and at the point when that happens, swap is
> already offline.  So in a lot of cases, we don't have enough memory to
> back up the VRAM contents.  There were patches to the Linux PM core,
> but I can't recall if they've all landed yet.  

Yeah everything should have landed now, so swap will still be enabled.

There's also the
> possibility that the user's swap partition is too small.
> 
> Alex

I heard something about /sys/power/reserved_size being too small by 
default still, so if you're having problems you might increase that.

