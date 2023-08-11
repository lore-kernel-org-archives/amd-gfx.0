Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C563C001DB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024EC10E0EF;
	Fri, 11 Aug 2023 13:45:01 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242DD10E08F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 09:02:09 +0000 (UTC)
Received: from 46.183.103.8.relaix.net ([46.183.103.8] helo=[172.18.99.178]);
 authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1qUO23-0003Fi-C9; Fri, 11 Aug 2023 11:02:07 +0200
Message-ID: <c2f38e22-547d-9dec-cb50-95df3ba62975@leemhuis.info>
Date: Fri, 11 Aug 2023 11:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <620b0254-cdf7-b3aa-adfc-d7bda286b641@leemhuis.info>
In-Reply-To: <620b0254-cdf7-b3aa-adfc-d7bda286b641@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1691744530;
 af053131; 
X-HE-SMSGID: 1qUO23-0003Fi-C9
X-Mailman-Approved-At: Fri, 11 Aug 2023 13:45:00 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 19.07.23 18:17, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 17.07.23 15:09, Michel Dänzer wrote:
>> On 5/10/23 23:23, Alex Deucher wrote:
>>> From: Philip Yang <Philip.Yang@amd.com>
>>>
>>> Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
>>> because it setup zone devive pgmap for page migration and keep it in
>>> kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
>>> only once in amdgpu_device_ip_init after adev ip blocks are initialized,
>>> but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
>>> SVM support based on pgmap.
>>>
>>> svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
>>> switching compute partition mode.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.

#regzbot fix: drm/amdkfd: disable IOMMUv2 support for Raven
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

