Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2EC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770CD2074D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N1qxpYow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770CD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32ACD6EC58;
	Fri, 13 Mar 2020 20:42:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4156EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 20:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y098KontWA+pmIFoD3ZAcKc5ot3PodhtAL0dTr/lN+2FrX0YApxVvXbdZH3+6KR46/6BIdCGkEmjsYlji7BT6i0TcBX1QUgSbhpuFKp8sIyeI2dABFD91WArGeNnFxAGafSpvXNNpUxj68YXd9HHrvBTQFEIu+cc80hXWbR4j+JE5JWBLU15Db6mLD67oHRDKYPwEtBOqQbNAG4qfsuPm43oJzyJ7rzz26Tp5q0GRElbxqlYtzQsLHfmsFy8CrBSHCuMFTY7ySXi+2CkVbWufgwcCEvgmJftm5o1out0ObtIUMHN+cFyV/M9d5ZkjZfS7hnB/cLkg0VCJRv5vxTaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY/fijX06+pWpFc9kX0wvos6kAhS9wZRidnBKsigRkM=;
 b=C4mycTb/6+u0u0ulMNETd/TCO0jE/o85D8rlVsLIzhhO3QC/GdAiNKDZ3unp8T5pixh55/302ohVxtxLedb5kgp2n9dgfUu6z03xhO5wzLanMeDQ7to4nZQa926G/fQDlRr93HR+FVCDSvcDn5FS8j5g56GNMwhxp6XYboa7RVGx8MMQti0+ckGF6lKLLp9AeKiTYSJgOrShbcfyGS9ubF21wFcD02aaCQeYKDKbpp6baoFb8BYw/bGY0QhcRn34J/Y/uu6KcKR85q16Lo644z6NEyTyDANyRu9AO4eOGbj6w5kp5zoB7FO1G0uuV1e4oDPgTYpDjP4q1GtWYn1gRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY/fijX06+pWpFc9kX0wvos6kAhS9wZRidnBKsigRkM=;
 b=N1qxpYowSmcRHLjrRXTeb6fjteA5ZOSLVGAfjkJmQTOSjbSYe4CgvKgwomCU0NJHeae+3O0tKpHnAhJc3V5ijeRypxhl05JtwwBPP8RH0LsBSGTJsDV5NOsz09UafEAOaxOe7sg9VM5gQXJs4/oJGSMb9ompxC5t516i27zDI4A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 20:42:52 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 20:42:52 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: Alex Deucher <alexdeucher@gmail.com>
References: <1584120001-30678-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_P3FheHhJyOMUiYMq=AVPdqDxnKSf8CN=kNDdPPDob=YQ@mail.gmail.com>
 <9fb91951-aa8e-e5aa-241f-078f283adfbb@amd.com>
 <CADnq5_PMZ-FErHuF911=F0txW+5XyKfbN6s4h8DO2tO-KvKweg@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <fe6daa8c-712c-41e2-d4a2-873bef53ff73@amd.com>
Date: Fri, 13 Mar 2020 16:42:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_PMZ-FErHuF911=F0txW+5XyKfbN6s4h8DO2tO-KvKweg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 20:42:51 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f889d721-8678-4998-19ac-08d7c78f19ca
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:|MWHPR12MB1839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1839A1B2FEBCA0EF5CA21423EAFA0@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(8936002)(316002)(956004)(186003)(81156014)(8676002)(31686004)(36756003)(26005)(2616005)(16576012)(54906003)(966005)(478600001)(16526019)(31696002)(81166006)(53546011)(45080400002)(6916009)(52116002)(30864003)(4326008)(66946007)(86362001)(5660300002)(6486002)(66556008)(2906002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1839;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I960gk5tewLVzMEAQR2W23DE6aoSqbRtNPtaznAO9/TXVS6+uGer1MnHXnsKOsOQRiOjd2NWnFsreERVAt6ZqMl1r36L+CyVzJSKgjUFp/ag/0xGsI110SbQkGsmPKf5FWzKyM9Kpf8X11fwA/akzNf56ToSp2/qlwiuz7mdhX49M9KIEf7kHT4qVnVL00kavx4kG1kRoPX/JySKPxYR5jBoH81+FRIhwR77gKhYXHqFpAb+zlYeDCxDA1UHCkMM1A9MQDdN3BrH2zn8ZSQhBIOgvwOt6qgwxbLA9d8AgTHm2i+wQP89nEVc/LwxmTYhlw05yXGTo4kqdaPwgRERMZPiYrJ0A0O28tSG4H3RSIbpJ1OIIld8QdRdIOPYqy0nPKg5FZLq+laU2kl3Qjp7suj9w1nAAKNSvVFM+sIvoJtYq23Pv928XVJQr/zfq7J7Q0GbXVZQU6GXSOHyX/ozw6p7V4Db5OGr8H+KwndvtZsxgQLKojFuDxKcuNuZ4JmdelOq2Zeao0sXy2riO9s1RQ==
X-MS-Exchange-AntiSpam-MessageData: 7IW76Q7YLpEq8/ktihPhJtw+EksqRTLkequ2LgNPIbYdvTFr0OO3952uRUE2hGRkm4SrREoErbeipzOIY4n5H3qKEqcSH/k3Q/lPIdmCVHa74ZDjuQCcfwNjAeM8oJs3q9ean0zvk7ZgmFUPvhnlOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f889d721-8678-4998-19ac-08d7c78f19ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 20:42:52.4959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUw5P8ffBcENp5Ze096D3ts5utzgRV1HlQ3UlVEmAWcYAm8H+dW8ClvXHjrmQWuOkEn+pH6+i1QJztSLF+lVog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/13/20 4:35 PM, Alex Deucher wrote:
> On Fri, Mar 13, 2020 at 4:27 PM Andrey Grodzovsky
> <Andrey.Grodzovsky@amd.com> wrote:
>>
>> On 3/13/20 2:29 PM, Alex Deucher wrote:
>>> On Fri, Mar 13, 2020 at 1:20 PM Andrey Grodzovsky
>>> <andrey.grodzovsky@amd.com> wrote:
>>>> Puts the i2c adapter in common place for sharing by RAS
>>>> and upcoming data read from FRU EEPROM feature.
>>>>
>>>> v2:
>>>> Move i2c adapter to amdgpu_pm and rename it.
>>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
>>>>    drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
>>>>    drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
>>>>    6 files changed, 54 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index a35c899..c04107b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -68,6 +68,8 @@
>>>>    #include <linux/suspend.h>
>>>>    #include <drm/task_barrier.h>
>>>>
>>>> +#include "smu_v11_0_i2c.h"
>>>> +
>>>>    MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>>    MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>>    MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>>>> @@ -1848,6 +1850,33 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>           return r;
>>>>    }
>>>>
>>>> +static int amdgpu_eeprom_init(struct amdgpu_device *adev)
>>>> +{
>>>> +       switch (adev->asic_type) {
>>>> +       case CHIP_VEGA20:
>>>> +               return smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
>>>> +       case CHIP_ARCTURUS:
>>>> +               return smu_i2c_eeprom_init(&adev->smu, &adev->pm.smu_i2c);
>>>> +       default:
>>>> +               return 0;
>>>> +       }
>>>> +}
>>>> +
>>>> +void amdgpu_eeprom_fini(struct amdgpu_device *adev)
>>>> +{
>>>> +
>>>> +       switch (adev->asic_type) {
>>>> +       case CHIP_VEGA20:
>>>> +               smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
>>>> +               return;
>>>> +       case CHIP_ARCTURUS:
>>>> +               smu_i2c_eeprom_fini(&adev->smu, &adev->pm.smu_i2c);
>>>> +               return;
>>>> +       default:
>>>> +               return;
>>>> +       }
>>>> +}
>>>> +
>>> I think maybe you missed my comments on this part.  I think it would
>>> make sense move these function calls into the relevant SMU sw init
>>> code.  E.g., call smu_v11_0_i2c_eeprom_control_fini() into
>>> vega20_smu_init() in vega20_smumgr.c.  then add the whole switch
>>> statement to smu_sw_init() in
>>> amdgpu_smu.c for VEGA20 (alternative powerplay code) and ARCTURUS.
>>> And the clean up in vega20_smu_fini() and smu_sw_fini()
>>>
>>> Alex
>>
>> Sorry, missed that indeed. For the ARCTURUS use case at least i am
>> worried it might brake the code because from the comment here
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.6-rc5%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L1907&amp;data=02%7C01%7CAndrey.Grodzovsky%40amd.com%7Ca9b64f335ebe4240a99208d7c78e0abe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197285188033276&amp;sdata=b6QUINZjP%2BuadZW76IIf3xi9u729OyFBTokBKzo0pX4%3D&amp;reserved=0
>> i remember that smu_i2c_eeprom_init (ARCTURUS init call) must be called
>> after HW init fully done and SMU is active while SW init happens way
>> earlier.
> ras_recovery_init can stay there, it does a lot of other stuff.
> smu_i2c_eeprom_init() and smu_v11_0_i2c_eeprom_control_init() don't
> actually touch the hw, they just create the i2c device.  It doesn't
> get used until we actually try and access the EEPROM.
>
> Alex


Right - now i remember the original issue was with trying to access the 
bus - this part indeed looks harmless.

Andrey


>
>> Andrey
>>
>>
>>>
>>>>    /**
>>>>     * amdgpu_device_ip_init - run init for hardware IPs
>>>>     *
>>>> @@ -1936,6 +1965,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>           if (r)
>>>>                   goto init_failed;
>>>>
>>>> +       r = amdgpu_eeprom_init(adev);
>>>> +       if (r)
>>>> +               goto init_failed;
>>>> +
>>>>           /*
>>>>            * retired pages will be loaded from eeprom and reserved here,
>>>>            * it should be called after amdgpu_device_ip_hw_init_phase2  since
>>>> @@ -2196,6 +2229,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>>>>
>>>>           amdgpu_ras_pre_fini(adev);
>>>>
>>>> +       amdgpu_eeprom_fini(adev);
>>>> +
>>>>           if (adev->gmc.xgmi.num_physical_nodes > 1)
>>>>                   amdgpu_xgmi_remove_device(adev);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>> index 1685794..936d85a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>> @@ -448,6 +448,8 @@ struct amdgpu_pm {
>>>>           /* powerplay feature */
>>>>           uint32_t pp_feature;
>>>>
>>>> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
>>>> +       struct i2c_adapter smu_i2c;
>>>>    };
>>>>
>>>>    #define R600_SSTU_DFLT                               0
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> index ed15b1f..c009609 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> @@ -25,7 +25,6 @@
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_ras.h"
>>>>    #include <linux/bits.h>
>>>> -#include "smu_v11_0_i2c.h"
>>>>    #include "atom.h"
>>>>
>>>>    #define EEPROM_I2C_TARGET_ADDR_VEGA20          0xA0
>>>> @@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>>>>                                    unsigned char *buff)
>>>>    {
>>>>           int ret = 0;
>>>> +       struct amdgpu_device *adev = to_amdgpu_device(control);
>>>>           struct i2c_msg msg = {
>>>>                           .addr   = 0,
>>>>                           .flags  = 0,
>>>> @@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>>>>
>>>>           msg.addr = control->i2c_address;
>>>>
>>>> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
>>>> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>>>>           if (ret < 1)
>>>>                   DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
>>>>
>>>> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>>>>                           .buf    = buff,
>>>>           };
>>>>
>>>> +       /* Verify i2c adapter is initialized */
>>>> +       if (!adev->pm.smu_i2c.algo)
>>>> +               return -ENOENT;
>>>> +
>>>>           if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
>>>>                   return -EINVAL;
>>>>
>>>>           mutex_init(&control->tbl_mutex);
>>>>
>>>> -       switch (adev->asic_type) {
>>>> -       case CHIP_VEGA20:
>>>> -               ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
>>>> -               break;
>>>> -
>>>> -       case CHIP_ARCTURUS:
>>>> -               ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
>>>> -               break;
>>>> -
>>>> -       default:
>>>> -               return 0;
>>>> -       }
>>>> -
>>>> -       if (ret) {
>>>> -               DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
>>>> -               return ret;
>>>> -       }
>>>> -
>>>>           msg.addr = control->i2c_address;
>>>> -
>>>>           /* Read/Create table header from EEPROM address 0 */
>>>> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
>>>> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>>>>           if (ret < 1) {
>>>>                   DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>>>>                   return ret;
>>>> @@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>>>>           return ret == 1 ? 0 : -EIO;
>>>>    }
>>>>
>>>> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
>>>> -{
>>>> -       struct amdgpu_device *adev = to_amdgpu_device(control);
>>>> -
>>>> -       switch (adev->asic_type) {
>>>> -       case CHIP_VEGA20:
>>>> -               smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
>>>> -               break;
>>>> -       case CHIP_ARCTURUS:
>>>> -               smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
>>>> -               break;
>>>> -
>>>> -       default:
>>>> -               return;
>>>> -       }
>>>> -}
>>>> -
>>>>    static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
>>>>                                             struct eeprom_table_record *record,
>>>>                                             unsigned char *buff)
>>>> @@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>>>>                   control->next_addr += EEPROM_TABLE_RECORD_SIZE;
>>>>           }
>>>>
>>>> -       ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
>>>> +       ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
>>>>           if (ret < 1) {
>>>>                   DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> index ca78f81..7e8647a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>>>> @@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
>>>>
>>>>    struct amdgpu_ras_eeprom_control {
>>>>           struct amdgpu_ras_eeprom_table_header tbl_hdr;
>>>> -       struct i2c_adapter eeprom_accessor;
>>>>           uint32_t next_addr;
>>>>           unsigned int num_recs;
>>>>           struct mutex tbl_mutex;
>>>> @@ -79,7 +78,6 @@ struct eeprom_table_record {
>>>>    }__attribute__((__packed__));
>>>>
>>>>    int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
>>>> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
>>>>    int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>>>>
>>>>    int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>>>> index c902f26..9bffbab 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>>>> @@ -46,8 +46,7 @@
>>>>    #define I2C_NO_STOP    1
>>>>    #define I2C_RESTART    2
>>>>
>>>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>>>> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
>>>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>>>>
>>>>    static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
>>>>    {
>>>> @@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
>>>>
>>>>    static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>>>    {
>>>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
>>>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
>>>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>>>
>>>>           if (!smu_v11_0_i2c_bus_lock(i2c)) {
>>>>                   DRM_ERROR("Failed to lock the bus from SMU");
>>>> @@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>>>
>>>>    static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>>>    {
>>>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
>>>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
>>>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>>>
>>>>           if (!smu_v11_0_i2c_bus_unlock(i2c)) {
>>>>                   DRM_ERROR("Failed to unlock the bus from SMU");
>>>> @@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
>>>>                                 struct i2c_msg *msgs, int num)
>>>>    {
>>>>           int i, ret;
>>>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
>>>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
>>>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>>>
>>>>           if (!control->bus_locked) {
>>>>                   DRM_ERROR("I2C bus unlocked, stopping transaction!");
>>>> @@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
>>>>           control->class = I2C_CLASS_SPD;
>>>>           control->dev.parent = &adev->pdev->dev;
>>>>           control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
>>>> -       snprintf(control->name, sizeof(control->name), "RAS EEPROM");
>>>> +       snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>>>>           control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
>>>>
>>>>           res = i2c_add_adapter(control);
>>>> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>>>> index 61596e8..3c55a2d 100644
>>>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>>>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>>>> @@ -41,7 +41,7 @@
>>>>    #include <linux/pci.h>
>>>>    #include "amdgpu_ras.h"
>>>>
>>>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>>>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>>>>
>>>>    #define CTF_OFFSET_EDGE                        5
>>>>    #define CTF_OFFSET_HOTSPOT             5
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CAndrey.Grodzovsky%40amd.com%7Ca9b64f335ebe4240a99208d7c78e0abe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197285188043270&amp;sdata=MRYASixIMQnp0oQF4RqXACiqGpLLGqAPGvvfUjH%2FZzA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
