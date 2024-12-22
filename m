Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A3E77190
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 08:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E91B10E467;
	Mon, 23 Dec 2024 08:56:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2D75110E0CC
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Dec 2024 04:27:52 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8CxC+JGlWdnk15ZAA--.44085S3;
 Sun, 22 Dec 2024 12:27:50 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMBxReRDlWdnEC0FAA--.29113S3;
 Sun, 22 Dec 2024 12:27:47 +0800 (CST)
Subject: Re: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction()
 noinline
To: Xi Ruoyao <xry111@xry111.site>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <20241217015006.30305-1-yangtiezhu@loongson.cn>
 <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
 <20241218190558.g2hykmjgbny4n5i3@jpoimboe>
 <CADnq5_PFcHzob4poLa86_K4yP5gUT7Ei4Rz5vSUofvZTmB48-g@mail.gmail.com>
 <4bace457-cc26-13a3-bc90-ad6ad12bc2ed@loongson.cn>
 <20241220103100.GB17537@noisy.programming.kicks-ass.net>
 <20241220223403.GA2605890@ax162>
 <05cdb3b4c9bddf25f7b839229b635d2dec5140a4.camel@xry111.site>
Cc: Alex Deucher <alexdeucher@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bc35fddc-498a-cc58-b6a1-f5234a4f6d0d@loongson.cn>
Date: Sun, 22 Dec 2024 12:27:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <05cdb3b4c9bddf25f7b839229b635d2dec5140a4.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qMiowMBxReRDlWdnEC0FAA--.29113S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWfJryDGr13JF18Wr1kXrc_yoW5Jr1kpF
 4rJFyUGrWDXFySvFZFkw15Xa93A3yfJr4kGFyrur1rAa47AanY9rs3t3WkJayakr42yr40
 va98KFyqyF4qyFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
X-Mailman-Approved-At: Mon, 23 Dec 2024 08:56:35 +0000
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

On 12/21/2024 03:40 PM, Xi Ruoyao wrote:
> On Fri, 2024-12-20 at 15:34 -0700, Nathan Chancellor wrote:
>>> Now, the thing is, these ASSERT()s are checking for divide-by-zero, I
>>> suspect clang figured that out and invokes UB on us and just stops
>>> code-gen.
>>
>> Yeah, I think your analysis is spot on, as this was introduced by a
>> change in clang from a few months ago according to my bisect:
>>
>> https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448
>>
>> Since the ASSERT does not do anything to prevent the divide by zero (it
>> just flags it with WARN_ON) and the rest of the code doesn't either, I
>> assume that the codegen stops as soon as it encounters the unreachable
>> that change created from the path where divide by zero would occur via
>>
>>   dc_fixpt_recip() ->
>>     dc_fixpt_from_fraction() ->
>>       complete_integer_division_u64() ->
>>         div64_u64_rem()
>>
>> Shouldn't callers of division functions harden them against dividing by
>> zero?
>
> Yes I think it'd be the correct solution.

Thank you all. Do you mean like this?

--- >8 ---

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c 
b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 88d3f9d7dd55..848d8e67304a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -79,11 +79,13 @@ struct fixed31_32 dc_fixpt_from_fraction(long long 
numerator, long long denomina
         unsigned long long arg2_value = arg2_negative ? -denominator : 
denominator;

         unsigned long long remainder;
+       unsigned long long res_value;

         /* determine integer part */

-       unsigned long long res_value = complete_integer_division_u64(
-               arg1_value, arg2_value, &remainder);
+       ASSERT(arg2_value);
+
+       res_value = complete_integer_division_u64(arg1_value, 
arg2_value, &remainder);

         ASSERT(res_value <= LONG_MAX);

@@ -214,8 +216,6 @@ struct fixed31_32 dc_fixpt_recip(struct fixed31_32 arg)
          * Good idea to use Newton's method
          */

-       ASSERT(arg.value);
-
         return dc_fixpt_from_fraction(
                 dc_fixpt_one.value,
                 arg.value);

With the above changes, there is no "falls through" objtool warning
compiled with both clang 19 and the latest mainline clang 20.

If you are OK with it, I will send a separate formal patch to handle
this issue after doing some more testing.

Thanks,
Tiezhu

