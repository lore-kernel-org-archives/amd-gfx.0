Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B1AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 10:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796AA10E517;
	Thu, 15 Dec 2022 10:30:28 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BFF10E517
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 10:30:25 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NXpQ53618z9sf4;
 Thu, 15 Dec 2022 11:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1671100189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0PYd1t7yf0K+aJZMGkprpdY9ve8z54wBXceE/DMGO0=;
 b=a8cJzoWCQdOeYvyPi/bTsIvF2L3ALqhry2lfnTdAcJLT9Hu2rm2Z6v2uZviYBQbIj/JjJk
 XY/PjyflgBpQzeB5krhl8jW82AjzR3tNtd6TK+MiH8j08TyvqNXwZZphZAOMrab7rPc9r2
 HvvEYqrh3hUkPuhfvnPqw/kU+jGCd8Xj14GqAZnY2ghTbwLInIZ4cbibqE5oCWlXL5A/Dz
 V1eHXko4YeOmbT4INhTMgcruczrCYjqXTNOFtFgv76s6b0byVaT3u3S5G1DZr5WVIbpY/0
 +jmhfoh3f9wECszSug1WlLUNpMXCXjKr1FXuWV4ztsm8sAwcfhFAhoEOfhzjuw==
Message-ID: <e8801420-3212-702a-93dd-1b3f323bfd87@mailbox.org>
Date: Thu, 15 Dec 2022 11:29:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
Content-Language: de-CH-frami
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
 <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
 <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
 <e2337d02-594e-9c69-d8a4-b046fc9c221f@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <e2337d02-594e-9c69-d8a4-b046fc9c221f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: srugthiztfd39q6pxii8871s5up35q34
X-MBO-RS-ID: 634695db2b79c8098da
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/15/22 09:09, Christian König wrote:
> Am 15.12.22 um 00:33 schrieb Alex Hung:
>> On 2022-12-14 16:06, Alex Deucher wrote:
>>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>>>
>>>>>>>>>> [Why]
>>>>>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>>>
>>>>>>>>>> [How]
>>>>>>>>>> To replace msleep with mdelay.
>>>>>>>>>
>>>>>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>
>>>>>>>> The msleep was introduced in eec3303de3378 for non-compliant display
>>>>>>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>>>>>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>>>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fkms_bw.c%23L197&amp;data=05%7C01%7Calex.hung%40amd.com%7C81664450189542a7bbc408dade27d0e9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066559844526853%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=M%2BF4H2qddXItPoUZRVyhlc5N8UF1%2FHIh8PpfT%2BCmdZ4%3D&amp;reserved=0)
>>>>>>>>
>>>>>>>> It is possible to workaround this by reversing order of
>>>>>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>>>>>
>>>>>>>>       igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>
>>>>>>>> Hangs:
>>>>>>>>       igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>
>>>>>>>> No hangs:
>>>>>>>>       igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>>>>>>>
>>>>>>>> However, IGT simply exposes the problem and it makes more sense to stop
>>>>>>>> the hang from occurring.
>>>>>>>>
>>>>>>>> I also tried to remove the msleep completely and it also work, but I
>>>>>>>> didn't want to break the fix for the original problematic hardware
>>>>>>>> configuration.
>>>>>>>
>>>>>>> Why does sleep vs delay make a difference?  Is there some race that we
>>>>>>> are not locking against?
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>
>>>>>> That was my original thought but I did not find any previously. I will
>>>>>> investigate it again.
>>>>>>
>>>>>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>>>>>> mdelay on x86_64 only and keep msleep on other platforms or just remove
>>>>>> the msleep for other platforms, something like
>>>>>>
>>>>>> -                       msleep(60);
>>>>>> +#ifdef CONFIG_X86_64
>>>>>> +                       mdelay(60);
>>>>>> +#endif
>>>>>
>>>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>>>> important is the IGT test?  What does it do?  Is the test itself
>>>>> correct?
>>>>>
>>>>
>>>> Agreed, and I didn't want to add conditions around the mdelay for the
>>>> same reason. I will assume this is not an option now.
>>>>
>>>> As in the previous comment, IGT can be modified to avoid the crash by
>>>> reversing the order fb is removed - though I suspect I will receive
>>>> questions why this is not fixed in kernel.
>>>>
>>>> I wanted to fix this in kernel because nothing stops other user-space
>>>> applications to use the same way to crash kernel, so fixing IGT is the
>>>> second option.
>>>>
>>>> Apparently causing problems on other platforms isn't an option at all so
>>>> I will try to figure out an non-mdelay solution, and then maybe an IGT
>>>> solution instead.
>>>
>>> What hangs?  The test or the kernel or the hardware?
>>
>> The system becomes completely unresponsive - no keyboard, mouse nor remote accesses.
> 
> I agree with Alex that changing this is extremely questionable and not justified at all.
> 
> My educated guess is that by using mdelay() instead of msleep() we keep the CPU core busy and preventing something from happening at the same time as something else.
> 
> This clearly points to missing locking or similar to protect concurrent execution of things.
Might another possibility be that this code gets called from an atomic context which can't sleep?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

