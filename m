Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D5C0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 17:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8C910E16A;
	Tue, 25 Jul 2023 17:07:08 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB48D10E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 17:07:06 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202307251907025095; Tue, 25 Jul 2023 19:07:02 +0200
Message-ID: <497c1875-da06-38f1-8dae-002782840f99@daenzer.net>
Date: Tue, 25 Jul 2023 19:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To: Philip Yang <Philip.Yang@amd.com>
References: <20230724175206.11054-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdkfd: start_cpsch don't map queues
In-Reply-To: <20230724175206.11054-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1A.64C00137.0030,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

On 7/24/23 19:52, Philip Yang wrote:
> start_cpsch map queues when kfd_init_node have race condition with
> IOMMUv2 init, and cause the gfx ring test failed later. Remove it
> from start_cpsch because map queues will be done when creating queues
> and resume queues.
> 
> Reported-by: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
This patch doesn't help for any of the symptoms I've described I'm afraid.


iommu=pt on the kernel command line avoids the IB test failures for the compute rings, but doesn't help for any of the other symptoms either, which still leaves the system unusable overall.


Sorry I don't have better news,


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

