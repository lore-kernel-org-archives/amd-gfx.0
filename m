Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100ACC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 02:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D1A10E0DC;
	Thu, 18 Jan 2024 02:27:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C32510E0DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 02:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS1JhWM3wVZquaGb1K+S7T7raxwvODqpRXyKiXARiA82jUJ9Gu07YTpJ0nbvuEui77oESIqb2tT9nCqkiIMwJebBU+SuwAT/vL0bJMptYIeZCne9etgjRxtDc6J9tB81heGfpFQsw7yvoSqE2aIh0yHkzt4K0zJqlhO11RCxjqCgFLNixtL8EmXOegSgp+0gP1/+tBGS/ak8D1y4u3iJoCXUcTXn58R2/dVtZ1wAI72bdk6yocG4e9sFsI+wIntHYWWjewlwIX8aSiBYEmRkBkXBxJ3G7+TUvsMhso64EtRqa48LBvtI5YA0DRy8ZNDapWDt6DGWPJ8O9nNjlq9pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFzmupu404yU3dBSdeIna/vWVxAWEsnzKEV9UXL7ET4=;
 b=GuHXL5Nsxs23R9Ag7PmoTAG3OhozMU/I0M798N3JCMy9KRu0RWK2hdj7LD5hFEYkuutMJ8iRbjZ/ePf8m/3YVi1LwZUYwfJvy/794jA4FdweVyDER0+JjNlopAEkiSo0/A08mTTcDuV3pUeScIVLm34OEFXZH4DfvcF3/DhO0dEByYFCoea7iMp/M3/G8s+fpr4pzPQ4wLqT73yAWw58EiV/cRhMgk8DAZOqOe78ddrI4KnWWqcHLxCDW8oro7nTSOJKj3c2XKU3qdlYG4FlmnBTj2KZYQLhSGoXTCHNCTWDKV0of5j5F0gBqmLTGRYruixm5w1MPmJ/TiPF51QqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFzmupu404yU3dBSdeIna/vWVxAWEsnzKEV9UXL7ET4=;
 b=q0qkP3TypIxvvFGWXKfXvaJAba9eU+DnShwoncvcV2bo23f/wweXVbjXpRKbTaBjju+JkVoIOTP2ElJGnPkq2JaUx4x5Y1Go5uxdt7JTpyml43RQFbPmqgL2NBVWuaqFfPatxhIDO8gnk8lfDtw39/TM1J6GDKhW51SFdh4PDQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 02:26:58 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 02:26:58 +0000
Message-ID: <26f85e84-4638-4781-942e-ba3cc0c380fd@amd.com>
Date: Thu, 18 Jan 2024 10:26:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
 <CADnq5_NUFJYOdNa2sm4y_KU108EUvwpR7MxTQySwdK+S=1G1hA@mail.gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_NUFJYOdNa2sm4y_KU108EUvwpR7MxTQySwdK+S=1G1hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d54c971-69b0-4c5d-069a-08dc17ccf1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k40zOToppl0RFTjKiKUt1mv0JCvrr2QE5dxmBwYnF4tHQhu028NsaNg/d6+6tEBYP2aZ/AM10Z5BIbvPpirq+0V7LjcEEOx4Zr2kf4QaymFkJfdTLxCrLeqPqXVTfdlA/u6qiWAE0zl+pFGhFBl0MORfA8d8uiUrY6mqbWO17OtMurKCWP+nL8f1hvnl9Hj4rRN23IjXBmZabSBh1ipnhMpux5L7fzTrWq23njmWGwYxEdu3ZCbVvlFHdmRzReTVLPjtKTabC1NHPREnv0S8Adx9PXWVI0/LJfFryan0VDER8anYCaC+iWDjBYgMcwrrhRoR3w19UhvZpsQe/L8EIqoxbFn+Wv6oqaMpmL3xIAoh0QTFksiqx9TEp+B1PybQcGtLzPBQlCV1o0f3CRIrJdh81vX8Hx+90ROvByJ5ZRMxb7u81TB9Sy0TDlYlNgM8zy3tzP46/ZtohvLU4sM4ngNuPDdEyJ9u4ZiNRQY1V9SVeZPXnyefrABk+d/ZvRZp9prt/+kE/Md3EaZ+8iQ0wmoDKRmvoMKANSMW0diZbpZjDoxaTggN+yIrrOoVBdEbcR/szMWQ8jGfZAknz1x6q199wKJJFq3zYkuBtcOzB1MYlWahIPe8j8Vj3883PGnN3G0M2yivV9oEZMDByFPYJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(83380400001)(36756003)(31696002)(38100700002)(41300700001)(66556008)(66476007)(66946007)(316002)(110136005)(6636002)(5660300002)(2906002)(8676002)(4326008)(8936002)(31686004)(6512007)(53546011)(2616005)(478600001)(6666004)(6506007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXp5YS9BTkJQQnlqRzZaS21wODZDUVkwc1JBcnZUYVVxSDJXWnpOMGxWQyt2?=
 =?utf-8?B?MGZCVk12cDNtQVFYNVcyWFhITlU0bDdnL2tYTytUcEl0Wmk1NE9qc0JmZFg2?=
 =?utf-8?B?SEVFZlVWRXJrcVJJNFh0ZDF4RjlmdlFsMGpsN3lwYUZZSGIrL01BL2szTHVj?=
 =?utf-8?B?em9nZ3I5RnZLWjJOd2wyZzdkR1ppTm1VQlhMME9DZ2ppMjFjaWNGemNFZXpL?=
 =?utf-8?B?M0JmY0hsZGdwZXk0VFg2QUlLODFYK1doOU45YUVNaHVMQmNHT25LN082RmxJ?=
 =?utf-8?B?cTR4M01KbU1GTjVzZDMzWnFiOTY4NHEraFR3Wk1tY3NwY0x6SzNJR0EyUVU0?=
 =?utf-8?B?WDlpS05qQ3pveHlmWFduTFd0SDl4Y1NQMFE3VHEvRGdhM2g0MktFTDBYSVBP?=
 =?utf-8?B?WDNWd1NOS2p1SFRHc1l1S0t4VzJIT2FCVzg5Qmw5WnZjazJIR21xQVE3eFVv?=
 =?utf-8?B?TWFnbktiSmNrWS9Oems4Umh5SitmRnpsMGVBVWFLTnU3QmdsZFdZckpKWjB1?=
 =?utf-8?B?OGRFT3RRWFFTQnB3TWRaNkg0UGxHeTllM0JxTk5QemJnSVVjSnRaNEw5RTJq?=
 =?utf-8?B?bjk1UU5mR1diZEtyT28wekxRYTNuL2JQV1dBVmwxVHFlcHhYTzBlREVtcVBF?=
 =?utf-8?B?emRTakhIck02UERZSWp4L3pxVU8wdTBNSDY3ZkJzTlpsSEJ4ZXVpQVZpTjhk?=
 =?utf-8?B?SGloNXR5RURDQWhURTVsc3MyMnhBTWh3ZjlyL1RpdDRaUVZTZHRBQ2EycDRm?=
 =?utf-8?B?K2tZMnVQVjZVS2lneUZlWmY5NUN5Nk9oUC9lRkNja1hZWVozREEvTDNLVUl1?=
 =?utf-8?B?bWd2bm5tcTYvbzBDeXlxRWxkQWJXdGMvU3QyQUw0M3BkSDJmUzc0NXBYT05l?=
 =?utf-8?B?ek5mdjl3Nm5zc0dRRFN2MHA1TVJxN2pxTkJNM3dqb0FKaXZ4Zy9zSmxYbXBs?=
 =?utf-8?B?REs0QzcyY0ZGWVNMbFhaY3puUHEzUlh0WklRbS9VOHVUSTRNR3NoUkpySFV6?=
 =?utf-8?B?V085cHFUbldyVlliVVh3QWVCVzZqQUhMVjRQY1B6bDF3Q0Z4OWlvY2NMR2pD?=
 =?utf-8?B?MGtTaDFOUUY5aW9FMmhVc3Y3N1hrTklVUGQwQVluaVpZTVdnWkhZMmVFRTVP?=
 =?utf-8?B?d3BjYkFqb1BITXJXWFEvWUJSWXgrTUF2SE1YMTRUZm5WUG45cUk1Wk1JUWJG?=
 =?utf-8?B?VktrV2xvMWpJRC91UTlmUk1DVzNNbmxqT0tlUEVXOXRBTWhkQlhoR0NqSnVM?=
 =?utf-8?B?ZEN5MnZjU3YwWmNtSUQ2WGt1ZStxTnRDTTlDK1hXeGlyZlpEZnhFM3VhSlpi?=
 =?utf-8?B?TEUwUGU5b1lRR1BHQlUwcEZHZmNQSWNvMzY3bHhJeFBwanRoSXhJd1EvU2Zu?=
 =?utf-8?B?K2gyWmx3MmFtZkNWT3poY0Z1YnlaUEd6YXRBRXdhZGIwV01FcXVYOWd0aXNj?=
 =?utf-8?B?VS85VHpQNG1hRE9Ebnh3S0JwTE05eTFhbEllNmZqd3AvK1N2RWl0ZC9MUFBa?=
 =?utf-8?B?ZDNFZmZ5bDJEenhlUWVyd1FYdTVRd1ArV3NQRzRiRGZPeEI1SzZRb3hOTmtY?=
 =?utf-8?B?M2VBYUtJRk11YjlhbG5kU0RTU3FTTmFVamFJYzF3RVRpWkhDWGNVN3ZwVWI0?=
 =?utf-8?B?aTF3a3FuQzBUNjRRL0dpblpBYmgvUDdvYjdYVDZDMGx2aUVsdndMMG92ckhP?=
 =?utf-8?B?WlYrbTRlYXowb1FUMnYybm4vUkt1ekpuSnVzMVRNcDNxdHRrUWhsblVNMlZh?=
 =?utf-8?B?aDZvR2dCNlgwcjllMnNTL3FJV2x6a2k2cHdTOFR0ZUVyejJib0tBUVYvNWZ0?=
 =?utf-8?B?RCtFTDJ0ODVMeWJtN2xuM25QMXN3a2dyMlFINGpLc0M1WVlPU1hrRzlZMnJN?=
 =?utf-8?B?UGRpUnlsWXQvZzdMNzNhWGRPZEJVa3ZWcXpMc05wblhZMVljckVjY2ZtU3Fm?=
 =?utf-8?B?b2ttd2tiZlhqdWg5R2NObzFQZUM0NnBPelY0eGl3aFlLYk9ZZzd1ZjJuVXNU?=
 =?utf-8?B?Vk81UFBrOUtvSHcvTXdTQTAyZjJybVdJSjhGdzRNSnFIUE1xUUNhVVc3SGNE?=
 =?utf-8?B?aS9kSUNGNTBjTDJOUGZxSnhkMk5McFpZL3Nod2xsT2VnU0hzaHpzWU12Ynh4?=
 =?utf-8?Q?eCJo4CY/TrcDC14zfgY0twKcy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54c971-69b0-4c5d-069a-08dc17ccf1ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 02:26:58.1912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlmCpfTOmNO/VFXC1FLq5EZmCAb1ucqndwylL0kNRrSSWzJtrnJBy4QrJjG7BQ8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 1/17/2024 10:13 PM, Alex Deucher wrote:
> On Wed, Jan 17, 2024 at 4:01 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> The power source flag should be updated when
>> [1] System receives an interrupt indicating that the power source
>> has changed.
>> [2] System resumes from suspend or runtime suspend
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>>  3 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index c16703868e5c..e16d22e30a8a 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -24,6 +24,7 @@
>>
>>  #include <linux/firmware.h>
>>  #include <linux/pci.h>
>> +#include <linux/power_supply.h>
>>  #include <linux/reboot.h>
>>
>>  #include "amdgpu.h"
>> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>>         return smu_set_config_table(smu, &adev->pm.config_table);
>>  }
>>
>> +static void smu_update_power_source(struct amdgpu_device *adev)
>> +{
>> +       if (power_supply_is_system_supplied() > 0)
>> +               adev->pm.ac_power = true;
>> +       else
>> +               adev->pm.ac_power = false;
>> +
>> +       if (is_support_sw_smu(adev))
> 
> Do we need this check here?  This is the sw_smu code.

Thanks，will drop this check in v2.

Regards,
Ma Jun
> 
>> +               smu_set_ac_dc(adev->powerplay.pp_handle);
>> +}
>> +
>>  static int smu_late_init(void *handle)
>>  {
>>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>>          * handle the switch automatically. Driver involvement
>>          * is unnecessary.
>>          */
>> -       if (!smu->dc_controlled_by_gpio) {
>> -               ret = smu_set_power_source(smu,
>> -                                          adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>> -                                          SMU_POWER_SOURCE_DC);
>> -               if (ret) {
>> -                       dev_err(adev->dev, "Failed to switch to %s mode!\n",
>> -                               adev->pm.ac_power ? "AC" : "DC");
>> -                       return ret;
>> -               }
>> -       }
>> +       if (!smu->dc_controlled_by_gpio)
>> +               smu_update_power_source(adev);
>>
>>         if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>             (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index 2e7f8d5cfc28..8047150fddd4 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>                         case 0x3:
>>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
>>                                 schedule_work(&smu->interrupt_work);
>> +                               adev->pm.ac_power = true;
>>                                 break;
>>                         case 0x4:
>>                                 dev_dbg(adev->dev, "Switched to DC mode!\n");
>>                                 schedule_work(&smu->interrupt_work);
>> +                               adev->pm.ac_power = false;
>>                                 break;
>>                         case 0x7:
>>                                 /*
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index 771a3d457c33..c486182ff275 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>                         case 0x3:
>>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
>>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
>> +                               adev->pm.ac_power = true;
>>                                 break;
>>                         case 0x4:
>>                                 dev_dbg(adev->dev, "Switched to DC mode!\n");
>>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
>> +                               adev->pm.ac_power = false;
>>                                 break;
>>                         case 0x7:
>>                                 /*
>> --
>> 2.34.1
>>
