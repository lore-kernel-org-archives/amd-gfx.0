Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9AAE77188
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 09:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDEC10E056;
	Thu, 26 Dec 2024 09:00:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7284610E10A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 09:44:03 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8DxmeDb02tnTFFaAA--.46919S3;
 Wed, 25 Dec 2024 17:43:55 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMBxzsXa02tn5bcIAA--.37718S3;
 Wed, 25 Dec 2024 17:43:54 +0800 (CST)
Subject: Re: [PATCH v6 9/9] drm/amd/display: Mark dc_fixpt_from_fraction()
 noinline
To: Nathan Chancellor <nathan@kernel.org>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <20241217015006.30305-1-yangtiezhu@loongson.cn>
 <CAAhV-H4WpcWjrQdkm3Sx4DVbp=2oW9nNGAbNqR4BEmiryrptNQ@mail.gmail.com>
 <20241218190558.g2hykmjgbny4n5i3@jpoimboe>
 <CADnq5_PFcHzob4poLa86_K4yP5gUT7Ei4Rz5vSUofvZTmB48-g@mail.gmail.com>
 <4bace457-cc26-13a3-bc90-ad6ad12bc2ed@loongson.cn>
 <20241220103100.GB17537@noisy.programming.kicks-ass.net>
 <20241220223403.GA2605890@ax162>
 <05cdb3b4c9bddf25f7b839229b635d2dec5140a4.camel@xry111.site>
 <bc35fddc-498a-cc58-b6a1-f5234a4f6d0d@loongson.cn>
 <20241223214645.GB1188382@ax162>
Cc: Xi Ruoyao <xry111@xry111.site>, Peter Zijlstra <peterz@infradead.org>,
 Alex Deucher <alexdeucher@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <73c297f1-05a7-e786-557c-b267b125b6d5@loongson.cn>
Date: Wed, 25 Dec 2024 17:43:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20241223214645.GB1188382@ax162>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qMiowMBxzsXa02tn5bcIAA--.37718S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4UJF4DZw1fZFy5ZF47Awc_yoW5JF45pa
 yfKF98Zr1DAF4xtasrGw18WFW3Aa4fGF40gF15C395u347AFn8urWfJF1kGrW3Gry7AF4a
 qF4DKrWUJF1qyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
X-Mailman-Approved-At: Thu, 26 Dec 2024 09:00:11 +0000
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

On 12/24/2024 05:46 AM, Nathan Chancellor wrote:
> On Sun, Dec 22, 2024 at 12:27:47PM +0800, Tiezhu Yang wrote:

...

>> With the above changes, there is no "falls through" objtool warning
>> compiled with both clang 19 and the latest mainline clang 20.
>
> I am somewhat surprised that changes anything because the ASSERT is not
> stopping control flow so I would expect the same problem as before. I
> guess it does not happen perhaps due to inlining differences? I looked

It is weird and I think it is not the correct way.

> at this code briefly when I sent my initial message and I was not sure
> where such a check should exist. It does not look like these functions
> really do any sort of error handling.
>
>> If you are OK with it, I will send a separate formal patch to handle
>> this issue after doing some more testing.
>
> It may still be worth doing this to get some initial thoughts from the
> AMD DRM folks.

I think the correct way is:

Keep the current ASSERT for the aim of debugging, just add BUG() to
stop control flow if the divisor is zero.

--- >8 ---

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c 
b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 88d3f9d7dd55..e15391e36b40 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -52,6 +52,7 @@ static inline unsigned long long 
complete_integer_division_u64(
         unsigned long long result;

         ASSERT(divisor);
+       BUG_ON(!divisor);

         result = div64_u64_rem(dividend, divisor, remainder);

diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c 
b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
index 131f1e3949d3..ce2036950808 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
@@ -30,6 +30,7 @@ static inline unsigned long long 
spl_complete_integer_division_u64(
         unsigned long long result;

         SPL_ASSERT(divisor);
+       BUG_ON(!divisor);

         result = spl_div64_u64_rem(dividend, divisor, remainder);

It looks reasonable and works well both on x86 and LoongArch, there are
no the following objtool warnings:

   dc_fixpt_recip() falls through to next function dc_fixpt_sinc()
   spl_fixpt_recip() falls through to next function spl_fixpt_sinc()

If no more comments, I will send a separate formal patch for your
review in the next week.

Thanks,
Tiezhu

