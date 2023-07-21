Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCD2EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E722610E1D2;
	Fri, 21 Jul 2023 08:55:54 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AC210E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:55:51 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202307211055468600; Fri, 21 Jul 2023 10:55:46 +0200
Content-Type: multipart/mixed; boundary="------------t5seGxc850RDW0Iys53ppYET"
Message-ID: <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
Date: Fri, 21 Jul 2023 10:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
In-Reply-To: <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
X-CTCH: RefID="str=0001.0A782F18.64BA4815.0019,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

This is a multi-part message in MIME format.
--------------t5seGxc850RDW0Iys53ppYET
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/20/23 22:48, Philip Yang wrote:
> On 2023-07-20 06:46, Michel Dänzer wrote:
>> On 7/17/23 15:09, Michel Dänzer wrote:
>>> On 5/10/23 23:23, Alex Deucher wrote:
>>>> From: Philip Yang <Philip.Yang@amd.com>
>>>>
>>>> Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
>>>> because it setup zone devive pgmap for page migration and keep it in
>>>> kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
>>>> only once in amdgpu_device_ip_init after adev ip blocks are initialized,
>>>> but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
>>>> SVM support based on pgmap.
>>>>
>>>> svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
>>>> switching compute partition mode.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.
>> Actually, it doesn't seem to break HW acceleration completely. GDM eventually comes up with HW acceleration, it takes a long time (~30s or so) to start up though.
>>
>> Later, the same messages as described in https://gitlab.freedesktop.org/drm/amd/-/issues/2659 appear.
>>
>> Reverting this commit fixes all of the above symptoms.
>>
>>
>> I reproduced all of the above symptoms with amd-staging-drm-next commit 75515acf4b60 ("i2c: nvidia-gpu: Add ACPI property to align with device-tree") as well.
>>
>>
>> For full disclosure, I use these kernel command line arguments:
>>
>>  fbcon=font:10x18 drm_kms_helper.drm_fbdev_overalloc=112 amdgpu.noretry=1 amdgpu.mcbp=1
> 
> Thanks for the issue report and full disclosure, but I am not able to reproduce this issue, with both drm-next branch and amd-staging-drm-next branch tip on gitlab. The test system has same device id, running Ubuntu 22.04, latest linux-firmware-20230625.tar.gz, and same BIOS version.

FWIW, your system has PCI revision ID 0xC2, while mine has 0xC1.

Also, I'm currently using linux-firmware 20230515. AFAICT there are no relevant changes in 20230625, but I'm attaching the contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info just in case.


> I attached full dmesg log, could you help check if there is other difference, maybe kernel config, gcc version... it is hard to guess what could cause the basic driver gfx ring IB test timeout.

I suspect the IOMMU page faults logged in my dmesg might be relevant:

 amdgpu: Topology: Add APU node [0x15d8:0x1002]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x122201800 flags=0x0070]
 amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x1125fe380 flags=0x0070]
 kfd kfd: amdgpu: added device 1002:15d8

There are no such page faults with the commit reverted.

Other than that and the IB test failure messages, our dmesg outputs are mostly identical indeed.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

--------------t5seGxc850RDW0Iys53ppYET
Content-Type: text/plain; charset=UTF-8; name="amdgpu_firmware_info.txt"
Content-Disposition: attachment; filename="amdgpu_firmware_info.txt"
Content-Transfer-Encoding: base64

VkNFIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDAwMApV
VkQgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMDAwCk1D
IGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDAwMApNRSBm
ZWF0dXJlIHZlcnNpb246IDUzLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMGE2ClBGUCBm
ZWF0dXJlIHZlcnNpb246IDUzLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMGMyCkNFIGZl
YXR1cmUgdmVyc2lvbjogNTMsIGZpcm13YXJlIHZlcnNpb246IDB4MDAwMDAwNTAKUkxDIGZl
YXR1cmUgdmVyc2lvbjogMSwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDA2ZgpSTEMgU1JM
QyBmZWF0dXJlIHZlcnNpb246IDEsIGZpcm13YXJlIHZlcnNpb246IDB4MDAwMDAwMDEKUkxD
IFNSTEcgZmVhdHVyZSB2ZXJzaW9uOiAxLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMDAx
ClJMQyBTUkxTIGZlYXR1cmUgdmVyc2lvbjogMSwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAw
MDAwMQpSTENQIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAw
MDAwMApSTENWIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAw
MDAwMApNRUMgZmVhdHVyZSB2ZXJzaW9uOiA1MywgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAw
MDFkMwpNRUMyIGZlYXR1cmUgdmVyc2lvbjogNTMsIGZpcm13YXJlIHZlcnNpb246IDB4MDAw
MDAxZDMKSU1VIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAw
MDAwMApTT1MgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAw
MDAwCkFTRCBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13YXJlIHZlcnNpb246IDB4MjEwMDAw
OTAKVEEgWEdNSSBmZWF0dXJlIHZlcnNpb246IDB4MDAwMDAwMDAsIGZpcm13YXJlIHZlcnNp
b246IDB4MDAwMDAwMDAKVEEgUkFTIGZlYXR1cmUgdmVyc2lvbjogMHgwMDAwMDAwMCwgZmly
bXdhcmUgdmVyc2lvbjogMHgwMDAwMDAwMApUQSBIRENQIGZlYXR1cmUgdmVyc2lvbjogMHgw
MDAwMDAwMCwgZmlybXdhcmUgdmVyc2lvbjogMHgxNzAwMDAyZQpUQSBEVE0gZmVhdHVyZSB2
ZXJzaW9uOiAweDAwMDAwMDAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDEyMDAwMDEyClRBIFJB
UCBmZWF0dXJlIHZlcnNpb246IDB4MDAwMDAwMDAsIGZpcm13YXJlIHZlcnNpb246IDB4MDAw
MDAwMDAKVEEgU0VDVVJFRElTUExBWSBmZWF0dXJlIHZlcnNpb246IDB4MDAwMDAwMDAsIGZp
cm13YXJlIHZlcnNpb246IDB4MjcwMDAwMDUKU01DIGZlYXR1cmUgdmVyc2lvbjogMCwgcHJv
Z3JhbTogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDA0MWUyYSAoNC4zMC40MikKU0RNQTAg
ZmVhdHVyZSB2ZXJzaW9uOiA0MSwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDBhOQpWQ04g
ZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAyMTBkMDA0CkRNQ1Ug
ZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMDAxCkRNQ1VC
IGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDAwMApUT0Mg
ZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMDAwCk1FU19L
SVEgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAwMDAwCk1F
UyBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13YXJlIHZlcnNpb246IDB4MDAwMDAwMDAKVkJJ
T1MgdmVyc2lvbjogMTEzLVBJQ0FTU08tMTE0Cg==

--------------t5seGxc850RDW0Iys53ppYET--
