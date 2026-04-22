Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE37FA1FD9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 17:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0023510EEE4;
	Wed, 22 Apr 2026 17:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="SsFFmOva";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0B410EEE4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1776880205; bh=nwAQ65vyjGKqfQ9+EDHDmYy+Gjqoz7OgTxqBMrQ/4CM=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=SsFFmOva4KeOTd3i3DJ7ApUqHGTJgOgL961bta4L1hPNShTKNzND7OJrS/dvhNfoZ
 SDszbNPRr3EMckiRbPdQVHOif36aDP10mRHKU+XDDn8CaUDzDXFet0Loy94gzEo0un
 iE4OQV4jrhxufQthFdBZgHobNwAVlyt7YXeLBdbC2zSUzbpjuRPuqZDFG7AEG3n+ix
 1adoN8Ck38hC70ox4pssC0XCpLmDKwXaG5cacx/UmbvGiZjMEC4pGPjogdWYqxFaDt
 exzBt3nuAzYhN5c6+vC9SrvkTVrHnzAHz4WyoA3758IoVR/JhX2vy0Gz/nB+Lj90mA
 umXSEUo91AEHg==
Message-ID: <cc5aad8a-e69c-42ab-a36f-15770b1038a1@m1k.cloud>
Date: Wed, 22 Apr 2026 19:50:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
To: Mario Limonciello <mario.limonciello@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Aurabindo.Pillai@amd.com, wiagn233@outlook.com, stable@vger.kernel.org
References: <20260422162956.620362-1-sunpeng.li@amd.com>
 <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
 <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
 <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
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

On 4/22/26 19:42, Mario Limonciello wrote:
> 
> In Michele's proposal (https://lore.kernel.org/amd- 
> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/) there was a mention 
> that it was tested on DCN 3.5 too, which made me think that the exact 
> same issue was on both.
> 
> Michele - can you readily reproduce the page flip timeout on DCN 3.5?
> 
> If so; could you modify Leo's patch to drop the IS_APU designation and 
> see if it happens to be the same solution?
> 
>>
>>>
>>>> +                       /*
>>>> +                        * DGPUs NV3x and newer that support idle 
>>>> optimizations
>>>> +                        * experience intermittent flip-done 
>>>> timeouts on cursor
>>>> +                        * updates. Restore 5s offdelay behavior for 
>>>> now.
>>>> +                        *
>>>> +                        * Discussion on the issue:
>>>> +                        * https://lore.kernel.org/amd- 
>>>> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>>> +                        */
>>>> +                       config.offdelay_ms = 5000;
>>>> +                       config.disable_immediate = false;
>>>> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>>> +                            IP_VERSION(3, 5, 0)) {
>>>>                          /*
>>>>                           * Older HW and DGPU have issues with 
>>>> instant off;
>>>>                           * use a 2 frame offdelay.
>>>> -- 
>>>> 2.53.0
>>>>
>>
> 

Hi Mario, i had tested my proposed patch on multiple APUs in order to 
exclude regressions or side effects, but personally i only ever 
encountered this particular issue on dGPUs, specifically a 7900 GRE 
first and a 9070XT later.

