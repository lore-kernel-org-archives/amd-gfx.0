Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F481EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 16:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047A910E0DD;
	Wed, 19 Jul 2023 16:21:42 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1474F10E0DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 16:17:50 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1qM9s4-0006fi-6H; Wed, 19 Jul 2023 18:17:48 +0200
Message-ID: <620b0254-cdf7-b3aa-adfc-d7bda286b641@leemhuis.info>
Date: Wed, 19 Jul 2023 18:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1689783471;
 48f62746; 
X-HE-SMSGID: 1qM9s4-0006fi-6H
X-Mailman-Approved-At: Wed, 19 Jul 2023 16:21:41 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 17.07.23 15:09, Michel Dänzer wrote:
> On 5/10/23 23:23, Alex Deucher wrote:
>> From: Philip Yang <Philip.Yang@amd.com>
>>
>> Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
>> because it setup zone devive pgmap for page migration and keep it in
>> kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
>> only once in amdgpu_device_ip_init after adev ip blocks are initialized,
>> but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
>> SVM support based on pgmap.
>>
>> svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
>> switching compute partition mode.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.
> 
> The IB test fails for the compute rings, see dmesg below.
> 
> Reverting this commit on top of the DRM changes merged for 6.5 fixes the issue.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 84b4dd3f84d
#regzbot title drm: amdgpu: HW acceleration broke on ThinkPad E595
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
