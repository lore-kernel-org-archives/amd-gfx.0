Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66785C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363F82082E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZnVtCSMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD56E15B;
	Fri, 20 Dec 2019 21:52:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDB66E15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDAJl9Gyxt6o55zdNegI9E7HADQKabBTS2GmlMbZ2rGQ2JatCwC1e2+eUZJ8/HTJ9TiyGFS5o+U1wXd5mwacau9AAO8ZfajA88v4y87tS3tIyxARF0fAQJ7IwmsiEAMnZSnFJkmS4T43xUQ7PmMxsfJBtv2ifFF/NSkKQlyafvYPlJAKcFwAYzb7DZsekwkgBMBEigicXz9OvamCUK90VF3m7vbTnbVi2IYV7AUAe/afEpfmM3WH4fEq9g849HaukS292M9DTQDO4eI1IruXf/4s+i/DTtEDCZt/WQM+bzwgShQwqXFnRxm1ils9W2sX4n+v3Ff1HHOCmIGEC58CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6t6doE8/At8lyRo5kJUhBnVC2LwQhZoSd15A7jKe+k=;
 b=RBXxZTp2DBxtiOPjp3R2hYgr7Ax9eB0fRRaiEF90M8AxLMbSVh+aaYX+tdeeVctmZp4oF6bxmVsYnKuhLhjK388WRE9CL7oCyuCejBBE9tsRrW2bnVjskgI5zcPvqZEzvwJ/NLp6p6shkCb27xCCzoE8U4AdY6yIwnK69DINMDmW7nelPOUzc8UdAXUyKlqGmyw7g6U97yqNEqiI2SU7Sfg/XuSNMUvlLCC2E5qPsc8zzyxZ1l/4NGppTQcYb/x0lL+Fd+Oja8SsjG5TL+HWiZn2HS4WVl5x77972IoNV8daGgNp7IWrs/vqUQWILNZbpGEsJyzQtvI1NixWqNVLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6t6doE8/At8lyRo5kJUhBnVC2LwQhZoSd15A7jKe+k=;
 b=ZnVtCSMgwvgt6BR2JDPWsoBICOzpYiTIcMbUIoVpXEQrHLfGeLuK33+sRjFjg+DI2olTPJnFeaEX1fCspl8232zLlvlBFI7yIPJ2SVOpClC3IKUlgAfyeQLjPvDXnsQ0Xo87dalxq9FDMXB57fzgEcIo9ShtdLKVYfOVSUNmyuM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3402.namprd12.prod.outlook.com (20.178.198.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 21:52:53 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 21:52:53 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V4)
To: Alex Deucher <alexdeucher@gmail.com>,
 "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
References: <20191219091623.3922-1-tianci.yin@amd.com>
 <ae29000d-fb99-4846-6d66-3ce5f67013c5@amd.com>
 <MN2PR12MB29574DEB22704EAD912B00A8952D0@MN2PR12MB2957.namprd12.prod.outlook.com>
 <CADnq5_N0QbrFs3pvyd7gT0_5=+KXk1COj5K8-Dw=N6K-AW+P=A@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <0e623827-46eb-2742-61f4-7a75ffc30de0@amd.com>
Date: Fri, 20 Dec 2019 16:52:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <CADnq5_N0QbrFs3pvyd7gT0_5=+KXk1COj5K8-Dw=N6K-AW+P=A@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 21:52:52 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87aacfab-eff6-4569-9eb7-08d78596f6cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:|DM6PR12MB3402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402B2C013A7B95E35E47665992D0@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(4001150100001)(53546011)(110136005)(16526019)(81156014)(6486002)(52116002)(26005)(4326008)(31686004)(81166006)(6636002)(8936002)(6512007)(8676002)(186003)(956004)(2906002)(66476007)(36756003)(66946007)(5660300002)(66556008)(2616005)(31696002)(54906003)(6506007)(15650500001)(478600001)(44832011)(316002)(86362001)(45080400002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3402;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoTuA6ap36trbjq0Z7bGTvGNbrADqP1/DoPM8AcoPLmtDaR6Nar7NE9cp/cRyMIRE1xTwdbFgd1Rs1dVOockfe9seC6GhszyPI10IHhkmXdVzknpcv9G+FQomeMpfR0xvQuR4naik3Z4SjsZEswmRRx1zk5zXs9yeMXdnYALZBs9RhBp6xoOyroqdZLi304uHThk4jws5DofMQGSH21FoYHYdpLLKi6LOv7/gXPiZIv0Xe55Nmkiy6267b/37g5l6MFYN6yqwtp8aCtgTe18mVCxglHREasuShJ+NK1EX2WRixtbv7TC3WL23WhHZ6XbVleR8qCxEPXR8iRgo9XLiYfubm1R+32jXJf+5NJ5LNWR/oQ1jjPlhsSeTPPRmrG2wE9x693omDU6XM6faWDR6ABfORYXPXiqQm7WIH8fPqBbWEz18HoqOiGxtA7pB9TF5IG8OH5mFs3DM12HBqBsAqB7/0MIUSKjm0WiJvwuu1E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aacfab-eff6-4569-9eb7-08d78596f6cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 21:52:53.0123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX9/KJGPOnDkCDF6ui+MpkhnIIr54l0V3xmIkKVCi29aNPniYinKtxRMDN8phJQo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-20 10:27 a.m., Alex Deucher wrote:
> On Thu, Dec 19, 2019 at 9:00 PM Yin, Tianci (Rico) <Tianci.Yin@amd.com> wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi Luben,
>>
>> May I have your Review-by?
>>

If you'd like--it's completely up to you. If you choose to, like Alex's below.

Regards,
Luben

> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> Thanks a lot!
>> Rico
>> ________________________________
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Friday, December 20, 2019 3:47
>> To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory training(V4)
>>
>> Yep! That's perfect--good job!
>>
>> Regards,
>> Luben
>>
>> On 2019-12-19 04:16, Tianci Yin wrote:
>>> From: "Tianci.Yin" <tianci.yin@amd.com>
>>>
>>> The method of getting fb_loc changed from parsing VBIOS to
>>> taking certain offset from top of VRAM
>>>
>>> Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
>>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>>>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
>>>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 ++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
>>>  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
>>>  7 files changed, 23 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index a78a363b1d71..fa2cf8e7bc07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
>>>        struct amdgpu_bo *reserved_bo;
>>>        void *va;
>>>
>>> -     /* Offset on the top of VRAM, used as c2p write buffer.
>>> +     /* GDDR6 training support flag.
>>>        */
>>> -     u64 mem_train_fb_loc;
>>>        bool mem_train_support;
>>>  };
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> index 9ba80d828876..fdd52d86a4d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>>>        if (adev->is_atom_fw) {
>>>                amdgpu_atomfirmware_scratch_regs_init(adev);
>>>                amdgpu_atomfirmware_allocate_fb_scratch(adev);
>>> -             ret = amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
>>> +             ret = amdgpu_atomfirmware_get_mem_train_info(adev);
>>>                if (ret) {
>>>                        DRM_ERROR("Failed to get mem train fb location.\n");
>>>                        return ret;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> index ff4eb96bdfb5..58f9d8c3a17a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
>>>        return ret;
>>>  }
>>>
>>> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
>>> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
>>>  {
>>>        struct atom_context *ctx = adev->mode_info.atom_context;
>>> -     unsigned char *bios = ctx->bios;
>>> -     struct vram_reserve_block *reserved_block;
>>> -     int index, block_number;
>>> +     int index;
>>>        uint8_t frev, crev;
>>>        uint16_t data_offset, size;
>>> -     uint32_t start_address_in_kb;
>>> -     uint64_t offset;
>>>        int ret;
>>>
>>>        adev->fw_vram_usage.mem_train_support = false;
>>> @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     reserved_block = (struct vram_reserve_block *)
>>> -             (bios + data_offset + sizeof(struct atom_common_table_header));
>>> -     block_number = ((unsigned int)size - sizeof(struct atom_common_table_header))
>>> -             / sizeof(struct vram_reserve_block);
>>> -     reserved_block += (block_number > 0) ? block_number-1 : 0;
>>> -     DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n",
>>> -               block_number,
>>> -               le32_to_cpu(reserved_block->start_address_in_kb),
>>> -               le16_to_cpu(reserved_block->used_by_firmware_in_kb),
>>> -               le16_to_cpu(reserved_block->used_by_driver_in_kb));
>>> -     if (reserved_block->used_by_firmware_in_kb > 0) {
>>> -             start_address_in_kb = le32_to_cpu(reserved_block->start_address_in_kb);
>>> -             offset = (uint64_t)start_address_in_kb * ONE_KiB;
>>> -             if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
>>> -                     offset -= ONE_MiB;
>>> -             }
>>> -
>>> -             offset &= ~(ONE_MiB - 1);
>>> -             adev->fw_vram_usage.mem_train_fb_loc = offset;
>>> -             adev->fw_vram_usage.mem_train_support = true;
>>> -             DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
>>> -             ret = 0;
>>> -     } else {
>>> -             DRM_ERROR("used_by_firmware_in_kb is 0!\n");
>>> -             ret = -EINVAL;
>>> -     }
>>> -
>>> -     return ret;
>>> +     adev->fw_vram_usage.mem_train_support = true;
>>> +     return 0;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> index f871af5ea6f3..434fe2fa0089 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>>>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>>>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>>        int *vram_width, int *vram_type, int *vram_vendor);
>>> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
>>> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
>>>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>>>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>>>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 2ff63d0414c9..1515413fd356 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1687,6 +1687,14 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
>>>        return 0;
>>>  }
>>>
>>> +static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
>>> +{
>>> +       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
>>> +               vram_size -= ONE_MiB;
>>> +
>>> +       return ALIGN(vram_size, ONE_MiB);
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
>>>   *
>>> @@ -1705,7 +1713,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
>>>                return 0;
>>>        }
>>>
>>> -     ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
>>> +     ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
>>>        ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
>>>        ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index f1ebd424510c..19eb3e8456c7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>>>        unsigned long                   offset;
>>>  };
>>>
>>> +/* Definitions for constance */
>>> +enum amdgpu_internal_constants
>>> +{
>>> +     ONE_KiB = 0x400,
>>> +     ONE_MiB = 0x100000,
>>> +};
>>> +
>>>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>>>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> index dd7cbc00a0aa..70146518174c 100644
>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>>>    uint16_t  used_by_driver_in_kb;
>>>  };
>>>
>>> -/* This is part of vram_usagebyfirmware_v2_1 */
>>> -struct vram_reserve_block
>>> -{
>>> -     uint32_t start_address_in_kb;
>>> -     uint16_t used_by_firmware_in_kb;
>>> -     uint16_t used_by_driver_in_kb;
>>> -};
>>> -
>>> -/* Definitions for constance */
>>> -enum atomfirmware_internal_constants
>>> -{
>>> -     ONE_KiB = 0x400,
>>> -     ONE_MiB = 0x100000,
>>> -};
>>>
>>>  /*
>>>    ***************************************************************************
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CLuben.Tuikov%40amd.com%7C3297c2cd4a9347a202ff08d7856137ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124524929052366&amp;sdata=0z7AeiekGUW1PsvttFCi%2FcxV1tmLlnRZU%2FkvTRUPm70%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
