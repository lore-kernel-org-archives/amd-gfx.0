Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D849C001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 14:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BC810E581;
	Thu, 27 Jul 2023 14:27:00 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D342D10E58D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 14:26:57 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202307271626533544; Thu, 27 Jul 2023 16:26:53 +0200
Message-ID: <b97e6791-d0a3-b520-d95c-2e157016d678@daenzer.net>
Date: Thu, 27 Jul 2023 16:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: Philip Yang <Philip.Yang@amd.com>
References: <20230724175206.11054-1-Philip.Yang@amd.com>
 <497c1875-da06-38f1-8dae-002782840f99@daenzer.net>
Content-Language: en-CA
Subject: Re: [PATCH] drm/amdkfd: start_cpsch don't map queues
In-Reply-To: <497c1875-da06-38f1-8dae-002782840f99@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F17.64C27EAE.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/25/23 19:06, Michel Dänzer wrote:
> On 7/24/23 19:52, Philip Yang wrote:
>> start_cpsch map queues when kfd_init_node have race condition with
>> IOMMUv2 init, and cause the gfx ring test failed later. Remove it
>> from start_cpsch because map queues will be done when creating queues
>> and resume queues.
>>
>> Reported-by: Michel Dänzer <michel@daenzer.net>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>  
> This patch doesn't help for any of the symptoms I've described I'm afraid.

Actually, I failed to check one thing before:

The patch fixed both IOMMU page faults. The IB tests on the compute rings still failed though.

Interestingly, with iommu=pt there was still one IOMMU page fault, even with this patch:

 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x14105a380 flags=0x0070]


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

