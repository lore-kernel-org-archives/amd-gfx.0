Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA90EC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 15:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444BD20724
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V4U6ngfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444BD20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE4689CC4;
	Fri, 13 Mar 2020 15:22:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF48689CC4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 15:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndrN+JMOfoMuYqtVuURA015kprVxeWm2O7jfDgnaSFiWeS6MN6NBDz8XazToeF31cMuUwv/KtcZlPHtmGiA/+xH7TlapBTotSI023213H1ohHZKfscv3tgrvi4BfiRJregdxYBgq+Lq9mRQFKd8unlzk/LkJaoEV1Aye0TOCdjC3Zd9yDRaOaX6HIKwS5IH16qb16wTSH+1AERIk3Z9HCNU5/Vr46jiLUP30gEi0NuftbeOqjgDoE5L1v2KjZPfm6W+3dZFa94wNA9/O5aiI1jPMY7y20+iTqhxNsKKkYWjrLTHxJZyRBe13ILbv3ku7frx9vk9z15svpyS6DMXMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHma3EX0SuFAc0Pfd/TZvZEB6ysY2TYNLDtJAuX/cks=;
 b=HnkQArjR2OIZtD7pYhXTs+wWBa2JXC0L2NZdYov3F/dbQfzA6WU+Br0e3o9ceiMCWmcfnullWorg9haCZZvYqSSP/fMgWCxLe+MnewHhnZQJXQLlQ0QY61QCyiuHh705vLiv9OgjmqnqtbzRzt+2Q+q/Iwtqd0CVKHuW+o2AE3PToJHAdVIskZedu6Jdv71N+DQKNsuAvAO0d4vI3JFWtKUNfghJbMrgikT1jQV8kh6EaULoAkL2isc9tm8W+RJbf2MVuRBjzvJ0QjejKhsTKCSUcBtk7YdeQD7z4W7MWszmf4RGGBzbQaOgjsxkLsB2Ucn+5hYD8+uyF2xOlkGVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHma3EX0SuFAc0Pfd/TZvZEB6ysY2TYNLDtJAuX/cks=;
 b=V4U6ngfGp+YsEGCcxQ260OgFyTfyTM9CC+/bo5oZ3WI2IKlPLaYmytTCmuog7xrvuQHABpFnZsW2dGJIs8jnD6P2M71qClVMSV7YbBfEOF8+ZD48VQUBHeC8FurqrbcEDPbjzmab9+pV5zjleYc07o3FWyBWv6GJpmES10D0/y4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1325.namprd12.prod.outlook.com (2603:10b6:300:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Fri, 13 Mar
 2020 15:22:03 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 15:22:03 +0000
Subject: Re: [PATCH] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: Alex Deucher <alexdeucher@gmail.com>
References: <1584111429-16165-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_Omf-e_OZExaCmASjs2WeNtp3sCKrcLGRhngDEhq+Vu+g@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a50c30f4-0277-37b1-2abf-c7b58a656f44@amd.com>
Date: Fri, 13 Mar 2020 11:22:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_Omf-e_OZExaCmASjs2WeNtp3sCKrcLGRhngDEhq+Vu+g@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 15:22:02 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e048725-0854-4957-be62-08d7c7624856
X-MS-TrafficTypeDiagnostic: MWHPR12MB1325:|MWHPR12MB1325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1325E806228EFD6CC57AD03DEAFA0@MWHPR12MB1325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(478600001)(54906003)(5660300002)(52116002)(53546011)(36756003)(966005)(16576012)(316002)(30864003)(6486002)(2906002)(45080400002)(16526019)(31696002)(86362001)(26005)(186003)(8936002)(81156014)(81166006)(8676002)(2616005)(6916009)(66946007)(66476007)(4326008)(66556008)(31686004)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1325;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n+WvgKDWC+OuXdNGsLNfGA8aArgW3vBRcc/mBkO7qa5sCOMLn0G9FB/ocZwG4ZIYu6Wui4uvbyb6aPzK/aAg0/k0Z3xIf3eEGBb25jk2/mFaYGJe+B8D1Y6rgghtIG/KlueaYSs9+agBUAcf1lOsanAal8s2LoTXwziBZR5slcH56uPrgIdxnBeweKW0FFCG4QmJSWmWmF6QEU+mMqvmDg5Y+RWzJ+7ee2dS7K/KJPi/aVEOXiX/PU1MJOO6hokmnA/AljC9oZz+5xCupAOP5U0UID+zCo6+AxDZmJGl7zk/A13wCd78rJ+doB0yZIz0ZNS62MugUKFhoE1zwJI5F96U/kbhr35n8MDMHlK9Q02PmMOKUhJdBTpRuvjdun7d0/6gQ3KDEVQl4/QnRA5TA99FdkFlN9wsnhYRlpAj8bG62OsAuUS4MkAJ3I7VVS5GxupIuyBUX950uMqTUno/QyyOBAepYnOJO1GQQ6Sh4Y=
X-MS-Exchange-AntiSpam-MessageData: mxJZmLj1wpAJ6vbYVXC/cE8z8cnadr6jiIpxKpgNZQxrV8NHQ0JAzlLK8ihfO8i4wEv7eqFdpvxnde5z8uedsrRRZB0jiYlhoxklYgOblN2qARBdrCZVGNeq9i2fVMGdOPMyBA9jDPO3P4LcqI1yFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e048725-0854-4957-be62-08d7c7624856
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 15:22:03.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iK+3vlBRuAXGlfnLsBIXJNY0wpZ7IYwXQaO3J1yq1ZtoDvR7BzGN7z5bDevZBAvdDRnRovzKd7CCcNYbcemiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1325
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


On 3/13/20 11:10 AM, Alex Deucher wrote:
> On Fri, Mar 13, 2020 at 10:57 AM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> Puts the i2c adapter in common place for sharing by RAS
>> and upcoming nvmlDeviceGetSerial from FRU EEPROM feature.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
>>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
>>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
>>   6 files changed, 55 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index c00831f..f807237 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -979,6 +979,9 @@ struct amdgpu_device {
>>
>>          bool                            pm_sysfs_en;
>>          bool                            ucode_sysfs_en;
>> +
>> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
>> +       struct i2c_adapter eeprom_accessor;
> Maybe call this smu_i2c?  Since it's not really eeprom only.  Also
> maybe put it in struct amdgpu_pm?

amdgpu_pm makes sense for MI-100 where we go through amdgpu_pm interface to send SMU message
but for MI-60 where we do I2C directly  it seems to me at least that this has nothing to with amdgpu_pm

Andrey


>
>>   };
>>
>>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a35c899..80fcc16 100644
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
>> +               return smu_v11_0_i2c_eeprom_control_init(&adev->eeprom_accessor);
>> +       case CHIP_ARCTURUS:
>> +               return smu_i2c_eeprom_init(&adev->smu, &adev->eeprom_accessor);
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
>> +               smu_v11_0_i2c_eeprom_control_fini(&adev->eeprom_accessor);
>> +               return;
>> +       case CHIP_ARCTURUS:
>> +               smu_i2c_eeprom_fini(&adev->smu, &adev->eeprom_accessor);
>> +               return;
>> +       default:
>> +               return;
>> +       }
>> +}
>> +
> Please put these in a separate amdgpu_eeprom.c/h files or call their
> contents directly from their respective powerplay SMU files for each
> asic since they are tied to SMU init anyway.
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
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index ed15b1f..14f6571 100644
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
>> +       ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
>>          if (ret < 1)
>>                  DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
>>
>> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>>                          .buf    = buff,
>>          };
>>
>> +       /* Verify i2c adapter is initialized */
>> +       if (!adev->eeprom_accessor.algo)
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
>> +       ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
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
>> +       ret = i2c_transfer(&adev->eeprom_accessor, msgs, num);
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
>> index c902f26..1df57ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> @@ -46,8 +46,7 @@
>>   #define I2C_NO_STOP    1
>>   #define I2C_RESTART    2
>>
>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
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
>> index 61596e8..94edb29 100644
>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> @@ -41,7 +41,7 @@
>>   #include <linux/pci.h>
>>   #include "amdgpu_ras.h"
>>
>> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
>> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
>>
>>   #define CTF_OFFSET_EDGE                        5
>>   #define CTF_OFFSET_HOTSPOT             5
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C5742bd5089f541184ff508d7c760c33e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197090716969372&amp;sdata=GWCh4fy1nKfoUJm4VvS5iBKIU6i1NzcBjUNF3bs81ms%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
