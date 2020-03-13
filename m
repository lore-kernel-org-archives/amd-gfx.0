Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA54BC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3D920751
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1y9IRj2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3D920751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6696B6EC58;
	Fri, 13 Mar 2020 20:27:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0586EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 20:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9UmR+Xt87osg42duc+98zl8wWc/UkYQZgM1hW1HpsqvxQLcNJOgG3VHWtl08bKxUy6oU2Dc0Z1nKApNNKjW97rft9Wvp6OODUvwrepOTn8JcKnh3QYV9n1azv8dj/wFxMMZAtuzrQHltYUOIB8MIoZUWUb/GseN+PUxulx5/9zIt14rVPsdqk/fY3VOXvqLch9j+7vKdpm8jlF7VdiPB5o+wSmn3T15x9lM2rz4vUZfsCB5FtnmzuF1pXG2SU2aA2OO6aJVsauG3KAgwDngwacHDZ0tYgKd3PHseYANzsgYO/qTJK0EnqBUUmzFiMzfYhUBj9YEtmveSpi5mErzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5u2I74McotYQbx8N0vsbNZlA8GkK5vzVcZgi+wOwoA=;
 b=RWRJ70Cb6K9Gm3neIOOxyhNrwD4D9onqVh7uhTY2/JztHx5viQ1eQ7H/l9eFuC8di1UUfW+/necEDsu9DUdu6gIBFl3Pdv9yRDGR6pXgHNyJDn97xyWF5IwGQsgB65onZAnghq8ZMozPqmxM1IjfWrTQ9qS4Gm8Vj5nqVP4y1gJBAQExpvBAkFi7ajINna+enCpfc+j74mkVOpWcCGGDp0iPiGHosUU5fNUsLoYJRHWAGuQBmD2H6uer4cmNs6d6ukESyHftXzVexmU0KbBmDQLQKSmnsPOS/eKBOXo6fTLj4Y9zD1aSV/7G6vlKJvhPTUYOKo1WYWPUIZR4Gv8/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5u2I74McotYQbx8N0vsbNZlA8GkK5vzVcZgi+wOwoA=;
 b=1y9IRj2Gx72Vaiqao8CeYrf8pxi7my3VHhsNPw+F4WlqNRJv8tSeiLVVGwj7NX379PFUdUkf+NKOc8oe425qZeRu0JcVau9YyP+IybAje/Zf4ELX6wRZwYFNP15CY4+2cSG2X67WJxiRgj9l+R9vu08DkB23iyekguLDvm6uqkk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Fri, 13 Mar
 2020 20:27:52 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 20:27:52 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: Alex Deucher <alexdeucher@gmail.com>
References: <1584120001-30678-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_P3FheHhJyOMUiYMq=AVPdqDxnKSf8CN=kNDdPPDob=YQ@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <9fb91951-aa8e-e5aa-241f-078f283adfbb@amd.com>
Date: Fri, 13 Mar 2020 16:27:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_P3FheHhJyOMUiYMq=AVPdqDxnKSf8CN=kNDdPPDob=YQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend
 Transport; Fri, 13 Mar 2020 20:27:51 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a8be64d-c136-42a1-183b-08d7c78d0159
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:|MWHPR12MB1728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1728247A3EFE9277267ABBFBEAFA0@MWHPR12MB1728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(2906002)(36756003)(26005)(5660300002)(6486002)(16526019)(186003)(8676002)(81156014)(81166006)(16576012)(66476007)(66556008)(66946007)(8936002)(316002)(54906003)(6916009)(956004)(45080400002)(30864003)(966005)(4326008)(478600001)(53546011)(86362001)(52116002)(31696002)(31686004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1728;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPCO9RPiNvoqjK/4NKA7L5eH4nIDehRl+AhEl3H9Hayl2ziHlDkPUUrooR0jOLJR6V6QfeIuO4r9p+cHIUN2iAEwfDwkZqFeFrp/bgBu9kbqw07sDdGhWnBm9SDwAG+x6y0/FYPMceAga0mIuMIw4Dfk+wV26+3/gTCESUdVYBYG93rHMXDEIXiQkFibNVo+3BbwEaE2RZwq9mKK0pt2Dq9M10rDFajHotE07Wt2ZDdZn9z0BjJCVuGAfk67BvCe4kFynaw0+UGc0tBuEWJfJ0jxAhNhRWzx7CnoI4iSNxJoj0Tgj7fNUpRbs5x1naOhxbqFyZsqrepmyusiiLgyzaPKTgMTkn5PgDm9NGQNYYXMYj2Opiac5/dBTdFCCxjoBtehlsAhfcE6/artohltHSlzhvP4KRhydqX+NPSQljL5yXUUQp5m6Ep2YQ00pJz96Wylg2Pkydq7ZA9y545wlVKb2vGb5d5tosStYfWMoh4kbmD4fx64KR61x2VBvxs/ABnoDT1FeuGelSjoNbPunw==
X-MS-Exchange-AntiSpam-MessageData: YsUhHFO+JG3hhjMy4p5GKmI8b6S8Y2airrXmHb/we+LzfyD2ceJkEMEl/7o9An2S7YgijFzyQatSQbzhhqT+giSrgWhX2BWcyYhCARdQaeMjcXIeUqL5w+DnxIwbsGK1+/FEOUEN+5MqLPy9pPDEZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8be64d-c136-42a1-183b-08d7c78d0159
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 20:27:52.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPoBSDW8iDzYc3fK3oWRzZPrjJuQ/LFn3GEdPuRI38kbcHo9+ncY1OTLM4I1Z5fU3Z1rdr96Fdl5LgQH65axfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
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


On 3/13/20 2:29 PM, Alex Deucher wrote:
> On Fri, Mar 13, 2020 at 1:20 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> Puts the i2c adapter in common place for sharing by RAS
>> and upcoming data read from FRU EEPROM feature.
>>
>> v2:
>> Move i2c adapter to amdgpu_pm and rename it.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
>>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
>>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
>>   6 files changed, 54 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a35c899..c04107b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -68,6 +68,8 @@
>>   #include <linux/suspend.h>
>>   #include <drm/task_barrier.h>
>>
>> +#include "smu_v11_0_i2c.h"
>> +
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>> @@ -1848,6 +1850,33 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>          return r;
>>   }
>>
>> +static int amdgpu_eeprom_init(struct amdgpu_device *adev)
>> +{
>> +       switch (adev->asic_type) {
>> +       case CHIP_VEGA20:
>> +               return smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
>> +       case CHIP_ARCTURUS:
>> +               return smu_i2c_eeprom_init(&adev->smu, &adev->pm.smu_i2c);
>> +       default:
>> +               return 0;
>> +       }
>> +}
>> +
>> +void amdgpu_eeprom_fini(struct amdgpu_device *adev)
>> +{
>> +
>> +       switch (adev->asic_type) {
>> +       case CHIP_VEGA20:
>> +               smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
>> +               return;
>> +       case CHIP_ARCTURUS:
>> +               smu_i2c_eeprom_fini(&adev->smu, &adev->pm.smu_i2c);
>> +               return;
>> +       default:
>> +               return;
>> +       }
>> +}
>> +
> I think maybe you missed my comments on this part.  I think it would
> make sense move these function calls into the relevant SMU sw init
> code.  E.g., call smu_v11_0_i2c_eeprom_control_fini() into
> vega20_smu_init() in vega20_smumgr.c.  then add the whole switch
> statement to smu_sw_init() in
> amdgpu_smu.c for VEGA20 (alternative powerplay code) and ARCTURUS.
> And the clean up in vega20_smu_fini() and smu_sw_fini()
>
> Alex


Sorry, missed that indeed. For the ARCTURUS use case at least i am 
worried it might brake the code because from the comment here 
https://elixir.bootlin.com/linux/v5.6-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L1907 
i remember that smu_i2c_eeprom_init (ARCTURUS init call) must be called 
after HW init fully done and SMU is active while SW init happens way 
earlier.

Andrey


>
>
>>   /**
>>    * amdgpu_device_ip_init - run init for hardware IPs
>>    *
>> @@ -1936,6 +1965,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>          if (r)
>>                  goto init_failed;
>>
>> +       r = amdgpu_eeprom_init(adev);
>> +       if (r)
>> +               goto init_failed;
>> +
>>          /*
>>           * retired pages will be loaded from eeprom and reserved here,
>>           * it should be called after amdgpu_device_ip_hw_init_phase2  since
>> @@ -2196,6 +2229,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>>
>>          amdgpu_ras_pre_fini(adev);
>>
>> +       amdgpu_eeprom_fini(adev);
>> +
>>          if (adev->gmc.xgmi.num_physical_nodes > 1)
>>                  amdgpu_xgmi_remove_device(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>> index 1685794..936d85a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>> @@ -448,6 +448,8 @@ struct amdgpu_pm {
>>          /* powerplay feature */
>>          uint32_t pp_feature;
>>
>> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
>> +       struct i2c_adapter smu_i2c;
>>   };
>>
>>   #define R600_SSTU_DFLT                               0
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index ed15b1f..c009609 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -25,7 +25,6 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_ras.h"
>>   #include <linux/bits.h>
>> -#include "smu_v11_0_i2c.h"
>>   #include "atom.h"
>>
>>   #define EEPROM_I2C_TARGET_ADDR_VEGA20          0xA0
>> @@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>>                                   unsigned char *buff)
>>   {
>>          int ret = 0;
>> +       struct amdgpu_device *adev = to_amdgpu_device(control);
>>          struct i2c_msg msg = {
>>                          .addr   = 0,
>>                          .flags  = 0,
>> @@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>>
>>          msg.addr = control->i2c_address;
>>
>> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
>> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>>          if (ret < 1)
>>                  DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
>>
>> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>>                          .buf    = buff,
>>          };
>>
>> +       /* Verify i2c adapter is initialized */
>> +       if (!adev->pm.smu_i2c.algo)
>> +               return -ENOENT;
>> +
>>          if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
>>                  return -EINVAL;
>>
>>          mutex_init(&control->tbl_mutex);
>>
>> -       switch (adev->asic_type) {
>> -       case CHIP_VEGA20:
>> -               ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
>> -               break;
>> -
>> -       case CHIP_ARCTURUS:
>> -               ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
>> -               break;
>> -
>> -       default:
>> -               return 0;
>> -       }
>> -
>> -       if (ret) {
>> -               DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
>> -               return ret;
>> -       }
>> -
>>          msg.addr = control->i2c_address;
>> -
>>          /* Read/Create table header from EEPROM address 0 */
>> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
>> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>>          if (ret < 1) {
>>                  DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>>                  return ret;
>> @@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>>          return ret == 1 ? 0 : -EIO;
>>   }
>>
>> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
>> -{
>> -       struct amdgpu_device *adev = to_amdgpu_device(control);
>> -
>> -       switch (adev->asic_type) {
>> -       case CHIP_VEGA20:
>> -               smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
>> -               break;
>> -       case CHIP_ARCTURUS:
>> -               smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
>> -               break;
>> -
>> -       default:
>> -               return;
>> -       }
>> -}
>> -
>>   static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
>>                                            struct eeprom_table_record *record,
>>                                            unsigned char *buff)
>> @@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>>                  control->next_addr += EEPROM_TABLE_RECORD_SIZE;
>>          }
>>
>> -       ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
>> +       ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
>>          if (ret < 1) {
>>                  DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> index ca78f81..7e8647a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> @@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
>>
>>   struct amdgpu_ras_eeprom_control {
>>          struct amdgpu_ras_eeprom_table_header tbl_hdr;
>> -       struct i2c_adapter eeprom_accessor;
>>          uint32_t next_addr;
>>          unsigned int num_recs;
>>          struct mutex tbl_mutex;
>> @@ -79,7 +78,6 @@ struct eeprom_table_record {
>>   }__attribute__((__packed__));
>>
>>   int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
>> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
>>   int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>>
>>   int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> index c902f26..9bffbab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> @@ -46,8 +46,7 @@
>>   #define I2C_NO_STOP    1
>>   #define I2C_RESTART    2
>>
>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>>
>>   static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
>>   {
>> @@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
>>
>>   static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>   {
>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>
>>          if (!smu_v11_0_i2c_bus_lock(i2c)) {
>>                  DRM_ERROR("Failed to lock the bus from SMU");
>> @@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>
>>   static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
>>   {
>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>
>>          if (!smu_v11_0_i2c_bus_unlock(i2c)) {
>>                  DRM_ERROR("Failed to unlock the bus from SMU");
>> @@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
>>                                struct i2c_msg *msgs, int num)
>>   {
>>          int i, ret;
>> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
>> +       struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
>> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>>
>>          if (!control->bus_locked) {
>>                  DRM_ERROR("I2C bus unlocked, stopping transaction!");
>> @@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
>>          control->class = I2C_CLASS_SPD;
>>          control->dev.parent = &adev->pdev->dev;
>>          control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
>> -       snprintf(control->name, sizeof(control->name), "RAS EEPROM");
>> +       snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>>          control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
>>
>>          res = i2c_add_adapter(control);
>> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> index 61596e8..3c55a2d 100644
>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> @@ -41,7 +41,7 @@
>>   #include <linux/pci.h>
>>   #include "amdgpu_ras.h"
>>
>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>>
>>   #define CTF_OFFSET_EDGE                        5
>>   #define CTF_OFFSET_HOTSPOT             5
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cd2dc864bf8084e145daf08d7c77c899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197210006888820&amp;sdata=vw%2BE2j%2Fx8mkaTEvRyHMB4xRwRslv7sHMIBXZ92i7YqY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
