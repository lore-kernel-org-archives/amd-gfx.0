Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9EAC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A8410E623;
	Fri, 21 Oct 2022 07:43:14 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E23010E61D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:43:04 +0000 (UTC)
Received: from thor ([85.2.99.24])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202210210943006397; Fri, 21 Oct 2022 09:43:00 +0200
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1olmgE-0009he-2l;
 Fri, 21 Oct 2022 09:42:58 +0200
Message-ID: <a182d22b-ee8a-3d17-e43d-0dec2e7c3c33@daenzer.net>
Date: Fri, 21 Oct 2022 09:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: de-CH-frami, en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 jiadong.zhu@amd.com
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <4046cec7-88a1-d91d-9553-678d5165d308@daenzer.net>
 <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
In-Reply-To: <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F29.63524D85.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Luben Tuikov <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-20 16:59, Christian König wrote:
> Am 20.10.22 um 16:49 schrieb Michel Dänzer:
>> On 2022-10-18 11:08, jiadong.zhu@amd.com wrote:
>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>
>>> The software ring is created to support priority context while there is only
>>> one hardware queue for gfx.
>>>
>>> Every software ring has its fence driver and could be used as an ordinary ring
>>> for the GPU scheduler.
>>> Multiple software rings are bound to a real ring with the ring muxer. The
>>> packages committed on the software ring are copied to the real ring.
>>>
>>> v2: Use array to store software ring entry.
>>> v3: Remove unnecessary prints.
>>> v4: Remove amdgpu_ring_sw_init/fini functions,
>>> using gtt for sw ring buffer for later dma copy
>>> optimization.
>>> v5: Allocate ring entry dynamically in the muxer.
>>> v6: Update comments for the ring muxer.
>>> v7: Modify for function naming.
>>> v8: Combine software ring functions into amdgpu_ring_mux.c
>> I tested patches 1-4 of this series (since Christian clearly nacked patch 5). I hit the oops below.
> 
> As long as you don't try to reset the GPU you can also test patch 5.

Sure, I can test it once there's a fix for the oops.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

