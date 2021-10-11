Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D48B60238
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D48B60238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB366E4FB;
	Mon, 11 Oct 2021 14:21:58 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBCF6E4FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 14:21:57 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 934DD61E5FE33;
 Mon, 11 Oct 2021 16:21:55 +0200 (CEST)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML
 <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Borislav Petkov <bp@alien8.de>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic> <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
Date: Mon, 11 Oct 2021 16:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dear Tom,


Am 11.10.21 um 15:58 schrieb Tom Lendacky:
> On 10/11/21 8:52 AM, Paul Menzel wrote:

>> Am 11.10.21 um 15:27 schrieb Tom Lendacky:
>>> On 10/11/21 8:11 AM, Borislav Petkov wrote:
>>>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
>>>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but 
>>>>> otherwise, yes
>>>>> this looks fine. The help text could also be updated to mention 
>>>>> problems
>>>>> with AMD Raven devices.
>>>>
>>>> This is not only about Raven GPUs but, as Alex explained, pretty much
>>>> about every device which doesn't support a 48 bit DMA mask. I'll expand
>>>> that aspect in the changelog.
>>>
>>> In general, non-GPU devices that don't support a 48-bit DMA mask work 
>>> fine (assuming they have set their DMA mask appropriately). It really 
>>> depends on whether SWIOTLB will be able to satisfy the memory 
>>> requirements of the driver when the IOMMU is not enabled or in 
>>> passthrough mode. Since GPU devices need/use a lot of memory, that 
>>> becomes a problem.
>>
>> How can I check that?
> 
> How can you check what? 32-bit DMA devices? GPUs? I need a bit more 
> information...

How can I check, why MEM_ENCRYPT is not working on my device despite the 
IOMMU being enabled.


Kind regards,

Paul
