Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D9CE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B3910E32F;
	Tue, 14 Jan 2025 14:05:10 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id ACD6910E1E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 11:52:24 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx73P2T4ZneSljAA--.8859S3;
 Tue, 14 Jan 2025 19:52:22 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMBxReT0T4Zn2gUiAA--.2756S3;
 Tue, 14 Jan 2025 19:52:21 +0800 (CST)
Subject: Re: [PATCH v3 1/3] drm/amd/display: Add ASSERT_BUG() macro definition
To: Huacai Chen <chenhuacai@kernel.org>
References: <20250114061507.30765-1-yangtiezhu@loongson.cn>
 <20250114061557.31120-1-yangtiezhu@loongson.cn>
 <CAAhV-H56-xQm5XnS7M4weHj29Z_bB8ZBiF_H4fd+eGe6g+naow@mail.gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1d34d05c-d408-4ee3-c385-f9367b7c3be5@loongson.cn>
Date: Tue, 14 Jan 2025 19:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H56-xQm5XnS7M4weHj29Z_bB8ZBiF_H4fd+eGe6g+naow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxReT0T4Zn2gUiAA--.2756S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7GF4UZw4xKw47WFyrGF15GFX_yoW8JrWfpw
 48GFyqka1DJa17KwnxKa15Xry3G3ykGFW8G34rW3s0yFyDZ39xGFn8CF4UGFW8uFW2k3WS
 qasaq39xWF4qyrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
 UUU==
X-Mailman-Approved-At: Tue, 14 Jan 2025 14:05:05 +0000
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

On 01/14/2025 04:29 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Tue, Jan 14, 2025 at 2:16 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> In order to keep the current ability for the aim of debugging and avoid
>> printing the warning message twice, add ASSERT_BUG() macro definition to
>> harden the callers of division functions.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  drivers/gpu/drm/amd/display/dc/os_types.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
>> index f2ba76c1e0c0..932bbe05ee0a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
>> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
>> @@ -79,6 +79,11 @@
>>                         dc_breakpoint();        \
>>         } while (0)
>>
>> +#define ASSERT_BUG(expr) do {                  \
>> +               dc_breakpoint();                \
>> +               BUG_ON(!(expr));                \
>> +       } while (0)
> I don't think this is correct, if KGDB is enabled, then whether expr
> is true or false, ASSERT_BUG() will break to KGDB.

It should check expr first, something like this:

#define ASSERT_BUG(expr) do {                   \
                 if (!(expr)) {                  \
                         dc_breakpoint();        \
                         BUG();                  \
                 }                               \
         } while (0)

I will send v4 later.

Thanks,
Tiezhu

