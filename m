Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C52C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 10:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C4810E5A5;
	Thu, 20 Jul 2023 10:46:54 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A0710E5A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 10:46:52 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202307201246472303; Thu, 20 Jul 2023 12:46:47 +0200
Message-ID: <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
Date: Thu, 20 Jul 2023 12:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
Content-Language: en-CA
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
In-Reply-To: <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F22.64B91099.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/17/23 15:09, Michel Dänzer wrote:
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

Actually, it doesn't seem to break HW acceleration completely. GDM eventually comes up with HW acceleration, it takes a long time (~30s or so) to start up though.

Later, the same messages as described in https://gitlab.freedesktop.org/drm/amd/-/issues/2659 appear.

Reverting this commit fixes all of the above symptoms.


I reproduced all of the above symptoms with amd-staging-drm-next commit 75515acf4b60 ("i2c: nvidia-gpu: Add ACPI property to align with device-tree") as well.


For full disclosure, I use these kernel command line arguments:

 fbcon=font:10x18 drm_kms_helper.drm_fbdev_overalloc=112 amdgpu.noretry=1 amdgpu.mcbp=1


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

