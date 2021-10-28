Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 08:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAE3610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 08:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFAE3610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC8F6E08C;
	Thu, 28 Oct 2021 08:33:02 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6516E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 08:33:01 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef59.dynamic.kabel-deutschland.de
 [95.90.239.89])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7778C61EA191D;
 Thu, 28 Oct 2021 10:32:59 +0200 (CEST)
Message-ID: <b1b2b722-d21e-421a-e8b1-5452d404533d@molgen.mpg.de>
Date: Thu, 28 Oct 2021 10:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu/gmc6: fix DMA mask
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 it+linux-iommu@molgen.mpg.de, Alex Deucher <alexdeucher@gmail.com>
References: <20211027182212.1484689-1-alexander.deucher@amd.com>
 <CADnq5_PzD5h0UmhQko7YE86a1xhm2LnPFhDgwgEhBe7iKNov0A@mail.gmail.com>
 <a0801433-fd70-f15d-3f63-7ca18fbf2244@molgen.mpg.de>
In-Reply-To: <a0801433-fd70-f15d-3f63-7ca18fbf2244@molgen.mpg.de>
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

Dear Alex,


On 28.10.21 00:19, Paul Menzel wrote:

> On 27.10.21 20:23, Alex Deucher wrote:
>> On Wed, Oct 27, 2021 at 2:22 PM Alex Deucher 
>> <alexander.deucher@amd.com> wrote:
>>>
>>> The DMA mask on SI parts is 40 bits not 44.  Looks like a copy
>>> paste typo.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
>>
>> Fixed locally.
> 
> As I have no way to reproduce this, as the ring gfx timeout error is 
> logged ten seconds after the IO_PAGE_FAULT, is very likely to be related?
> 
> Hopefully I am going to be able to test this on Friday. Does AMD’s QA 
> team have the cards to test the `iommu.forcedac=1` case? Is that test 
> case going to be added to the “test protocol”?
> 
> Lastly, should a Fixes tag be added, so it’s picked up for the stable 
> series?

Does the value of 44 need to be changed to 40 also five lines below?

-       adev->need_swiotlb = drm_need_swiotlb(44);
+       adev->need_swiotlb = drm_need_swiotlb(40);


Kind regards,

Paul
