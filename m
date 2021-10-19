Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596E1611EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 596E1611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DB06EB3D;
	Tue, 19 Oct 2021 07:44:24 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A706EB3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 07:44:22 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de
 [95.90.239.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B39F261E5FE00;
 Tue, 19 Oct 2021 09:44:20 +0200 (CEST)
Subject: Use of conditionals with omitted operands in amdgpu (x? : y) (was:
 [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock frequency
 (v3))
To: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
 <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
 <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
 <fbd8a354-4f09-ffd9-ae0f-fdaa16903bc8@amd.com>
 <65580f09-1ad8-07ba-b392-dc4aad2464ee@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <137ec58c-a8e9-19d4-c49b-19b6e0aad144@molgen.mpg.de>
Date: Tue, 19 Oct 2021 09:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <65580f09-1ad8-07ba-b392-dc4aad2464ee@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Dear Luben,


Am 19.10.21 um 06:50 schrieb Luben Tuikov:
> On 2021-10-19 00:38, Lazar, Lijo wrote:
>>
>> On 10/19/2021 9:45 AM, Luben Tuikov wrote:
>>> On 2021-10-18 23:38, Lazar, Lijo wrote:
>>>> On 10/19/2021 5:19 AM, Luben Tuikov wrote:

[…]

>>>>> -			if (ret)
>>>>> -				goto print_clk_out;
>>>>> +			freq_value[1] = curr_value ?: freq_value[0];
>>>> Omitting second expression is not standard C -
>>>> https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html
>>> Lijo just clarified to me that:
>>>
>>>> well, i had to look up as I haven't seen it before
>>> I hope the following should make it clear about its usage:
>>>
>>> $cd linux/
>>> $find . -name "*.[ch]" -exec grep -E "\?:" \{\} \+ | wc -l
>>> 1042
>>> $_

     $ git grep -E "\?:" -- '*amdgpu*.[ch]'
     drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c: * Solution?:

So for the AMDGPU subsystem, as the only result is a comment, currently, 
conditionals with omitted operands are not used. So, it’s a valid 
question, if the use should be introduced into the subsystem.

The GCC documentation also states:

> In this simple case, the ability to omit the middle operand is not
> especially useful. When it becomes useful is when the first operand
> does, or may (if it is a macro argument), contain a side effect. Then
> repeating the operand in the middle would perform the side effect
> twice. Omitting the middle operand uses the value already computed
> without the undesirable effects of recomputing it.

So, in your case, there are no side effect, if I am not mistaken.

I do not care, if the extension is going to be used or not. The 
maintainers might want to officially confirm the use in the subsystem, 
as using these extensions is surprising for some C developers not 
knowing the GNU extensions.

>> Thanks Luben!
> 
> You're welcome. I'm glad you're learning new things from my patches.
> Would've been easier if you'd just said in your email that you've
> never seen this ternary conditional shortcut before and that you've
> just learned of it from my patch. (Or not post anything at all in
> this very case and get in touch with me privately via email or
> Teams--I would've gladly clarified it there.)

In my opinion, asking this on the list is perfectly valid, as other 
readers, might have the same question. But being more elaborate to avoid 
misunderstandings is always a good thing.

> I hope the find+egrep above is also edifying, so you can use it in
> the future in your learning process.

I hope, you like my solution without using find. ;-)


Kind regards,

Paul
