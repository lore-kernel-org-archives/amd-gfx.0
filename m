Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 17:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFA410E295;
	Tue,  8 Mar 2022 17:20:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC1510E295
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 17:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZQeOAQnRdEb+UvF3+UZo8l8tfAkcWCCb3VMMD1E+hG2osElKh+zAAhdO5qokv+jNSVibncsfk91w0heGcwi7J+jbHojlXpTIWdOJ6flTlZLD/+BdnmRwA1LF8cdjHfcabw1GkqWuK3YraniV3B0MYYcp78lXmCbgBF2yHQWjrTaYpd0JGq4EIpoQ2pa8R5USWaaj0AllVAN2bugG0EhGg0Pu9D8c8nKEa/Exp1Sb/zt5iyqGWfs+1Qc7aaxciaCzyM+P3zzarHSbIKWICd2h/tRAm/hNYk+OYW+fvXRlQ++mutT09ZYrkb3J0eqNpobJnQEf6XA0is6rly03K2kZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKffTqzUJysKLpSZVUEzOkCj8w6ewUZG8NJpNmtuchw=;
 b=NrwmHFnwzFmL50SSF8ImkwYjXzMmIN+UJtkdu2kuw7SEzM5D0KON6ILYvAE26xvtAjEapTWYd8KnoLVVBQmD8+M5KYZ3AUN9tfahothZjCo/qRPqKHHu6g7fWtpcOg4MhzM2zNPMPnh7ErKAk5Klph4paoNhEqQDgkKuPvsuzEUTwT6OhwAFSqyM8H7za5M6tjY+swd95s0u4LP4gEjIEJG4IzMYIA8tQmWZVBJyPVbUbzpVZ94OlPzM2f4PjL2RNJZ32QNB65PTEDlZDIBMDcJ3q2JoH8jVAD6aVchawXvnNzFRVpM5dlqg8hhakHkcnc4YoxIFxCS7VZKFpWCqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKffTqzUJysKLpSZVUEzOkCj8w6ewUZG8NJpNmtuchw=;
 b=RgYBuFNITrQsindZsQuJvmwg6QqoCnC68V0qTfZlvOFh6OKwFf2Uwm8sZY8IOERsKuNSvhwNub/SL21IzaaSpQw9YIbsUziX+tU8g7erViWwtIp28FVdeF9doJq/rNZtZg3AULUrWnk9XbFu9YFK/77Osyq9Wo/co6fjS1tpfxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:20:21 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:20:21 +0000
Content-Type: multipart/alternative;
 boundary="------------759AQCww3SbzT8uf5vQWZab8"
Message-ID: <abf6d329-6a3f-26f0-1d5b-75b3ff55acfd@amd.com>
Date: Tue, 8 Mar 2022 22:50:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
 <9de42884-d1e2-309a-e669-5132539fbd22@amd.com>
 <bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com>
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a23f2bf-5cc6-4653-d0b3-08da0127ec48
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368348FDDC2E30F60AAB642F8099@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5rtMv+uuyfLNkulmNk+bF+QocghyfcZm1kT1L2at6SA8WumrhUrS1HPQbsn6d9DgpxRS7SXD1ZHLKHWHK2CpBLTC+PzzD4qF+xg39pLl7pXdv1s8rUBtNDmUKQ66+DaWxf74rYmam8OFcDcVg41ltyOl/xG1tn6CJZSOSFJ5E/JlvF8PU4bstGmBqvpcFXjgPHtN/s+Cl0AHMD125g8rlaieitSiRdS6k7mel2XWXrE1Kclhis6ejYDStsE2bmLMP3jkKz5BmFlhSFS5MlqKyA1ypgjWD95vAgxEMZPuJHRiwCm6hMDm75tNPth5WJMr6L/QKl1X81YovS7uzLYmhMdRyrCyap39kWhJD0w/2VF22MaGwliMmBC5zS20/ea/yNdd0mWOuvsJkQTHOqRrvcRu7l1MAUDxQdOuYg37DESzK+LWlO1bdSlc0h7d+cQ6h3cSuTx6oI5dHEbaaAowwwRsIwBaQrrXsELfdwFFiZjE2dpO/QZy4xm99AZLJeIDF8cM+U5uhrTqpRc7BTYCQ9C+SAao5yddob2Dx/hhKu8tU/c8jHgbjIPKJ1+lorvMgODVos/5H43X3xka0eXWp676fXP60XGcsDaaN/8Y5mYN9kDpXHgh0HAQdSks+Cob3QAQzl+egE3W1TgkViJ9BR3TfFl6YlXd3k4d+KNiI7KGAt7QdPrGmHO7SM3s0PyF5M6tBeK7gwsiQt+vNjJDJsnzhwLd8lBi94lh9QCf4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(53546011)(4326008)(6666004)(6512007)(6506007)(36756003)(38100700002)(8676002)(33964004)(66476007)(66946007)(83380400001)(54906003)(6486002)(110136005)(186003)(26005)(2616005)(316002)(508600001)(2906002)(31696002)(31686004)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BHR0d2WmppR2RVdUpONDM0OXE4YTJpMUZZUERwYzlWbWZFQ2N4Tmt1UDA5?=
 =?utf-8?B?YlZvUVFwMXJnWDNZVEg5a0xOeFp4R2Nzb3B0ZWJjUXoxUHQ2T0lIdW1uRE8v?=
 =?utf-8?B?MWZGZURnd2lmSE9YWXNLa1cvajhhZ1hjR1B5azdNMVVPM3MvSWJZM1pFVmE3?=
 =?utf-8?B?T3FieHhWbkE3UkZocG1GUXNyL2NhWXk2eWNJRGNOOVlTL2Z6L1d5dS9uK3kz?=
 =?utf-8?B?M2txUHdneXNGejB3YmNZMzVnUnVObElGOFFKZGh4WUFSem5rZkJJbU0wQ3gr?=
 =?utf-8?B?VWRYaXNmcTRwTUFyUmw4T0ZZbkhOOUxxRm5uS1pHcURFMVRGcVFDV2VuR1Fw?=
 =?utf-8?B?NGNoMXRxancra2VhZGNuS05NS3pjeHAvajQzUlc1RExHTlYxcHpVQlpwTnpI?=
 =?utf-8?B?aFR0Z0Zlc0UxQkcxUkI2WElROTdvaERka2FFLzl1NDVKdU1PN00wOXJoTVpK?=
 =?utf-8?B?Z1R3eGNKUENOQ2oxUkNWcDhrVW93dk1qNktDdE5vZVBSamxMU3BncVhrUjIv?=
 =?utf-8?B?eTgvR00wSk5jM2Rna1VTaGZjQUp0eXNuQ0JwQVFaZ0p5SkxxQkh0Vk50bXBM?=
 =?utf-8?B?UmVtMWhlTFMwRHRudnhmSDNBTDhQWFJQRnlNbTRvcEZKVmFBN1drRUI2TVlX?=
 =?utf-8?B?RitLZDNsZDZ0K0pLMTRtbUN4QU9EVWRZcjBXUitYWXVBREpMRlFWZytHeUl3?=
 =?utf-8?B?eTdGK096MFdCUGU4bHVTR0VFSGY5ekZESEM2VFhMbE9NcTQrUE56Z2JqKzZ2?=
 =?utf-8?B?SmJYLzA5d2U3bXU1ckN5dDRoWWh2K2tLVzdQYjhxSnp0bmxPOFZpNmlXNllx?=
 =?utf-8?B?Z1Z5VWRIN29sSXNnTDc4RkJGWjJVTzRKQlNST296TGowUzlzdnJaYlNybVpa?=
 =?utf-8?B?NW02SHpiMzh4Q0ZkOGpMRm8wT1R0Vkg0NTNDMStHVjJuQnR5RWZtRTBnRENa?=
 =?utf-8?B?OWQvdTl3ZTNveWcva2RWZ0ppcVQvMkFDbkw1TnBOTytJL2daQWJhdkhWZnRE?=
 =?utf-8?B?RmtNT09oR2hpaVJ4bDBBdGdTdlNWT3RsUU1ZN1NEcUIzdERib3BISkxLbFh2?=
 =?utf-8?B?V3lwODlhV2Z6MC8zRWxGa1pCOWpBdDNaUWRXY0lnbE1NQStXT0RXUVJSSFRK?=
 =?utf-8?B?UG52cW1HNWxwOEFVUStwWkR0Y0FYYk1jeEc0aENDNnAxUmVuWXFnRHpCZDl4?=
 =?utf-8?B?U3BKbjFOZU8vYUlyKyt2V3N6MEZjWG9nak9UQWtydjBwZ2loWG9MdStzQmdS?=
 =?utf-8?B?djZDUVoxa1JFQ0ZnQTkxOUtoOVdvRExkZHlXcENKTm05T3JsYmY4V3MxRU1l?=
 =?utf-8?B?OTcrZDJLSExrN3hrWkcvYnh3bkRRcVVWM0liQ0ZCUmtwbTJiU2w0R1BENzhp?=
 =?utf-8?B?cFJCUmV6V081SUpNME95M3JrQkNHMXd1TjdVd3Vmam1KWTE4aVk3RDNUMExS?=
 =?utf-8?B?NmovdzdhUDl6c3FjRnB6dFNvSWR5V0ppY0JJbmcxeXFiK3dvSDNodTZRN2Vo?=
 =?utf-8?B?TDNqbVZaVUdTNlJ0NldveS9YdGJ2ZnQrNUdwUklkaEROaTdnNTBwa21Bb1Fh?=
 =?utf-8?B?TDRKcWFZQWswMkI1N2tUTEd3aGczK0MyRnZqRVFPcVk3U2tVWjFvY09KczFQ?=
 =?utf-8?B?RjRNZjhJaGlCUlJRRWI5Z0hkaEQxdG5MM1B1ZlkxRTdHRjlYMDlENElQWkdm?=
 =?utf-8?B?eXlLMHdmVXRUR0kvbzdlWDVnTlkrWFZidHpoTGFTYzljMXpNc0dMbXZ6OE9k?=
 =?utf-8?B?M1A2RmZDSjMvQnIzRmJLc3BRK01jMEtDWWdJTENrS3BhR25hNVpUUHFGRTVv?=
 =?utf-8?B?ajd0T1JzbHZrZDNQdWFXTC8rRWVlTWhuRUZrbU83Y0FhdUtReGxQVVUyeEtQ?=
 =?utf-8?B?WEdZZ3hhNVNXaVJOTGovUlVJYWs5bkduQ21BYjhDQU9vYUk2UXEzSytxakJJ?=
 =?utf-8?B?U2Y2b0dQSlZmbGJBZDlsSUIwSGZXUks2ZnBEcUI5aVBxNWIzZGR5djN3MVcw?=
 =?utf-8?B?L0FHMUFTV3ErV3V6UU4zcUpmSFlyOEZjdHkzVElJdXJTd1hmdHBpUFpCWVpi?=
 =?utf-8?B?cWJaZ016akdHS0EwVDFnNVlVQ08vN2NxSEZ2eE5tekZqVzB1a25OTnN6TUs4?=
 =?utf-8?B?RDd3ZlBZSFhEMmVQT21JaDdYQUxNSmJ0UzQxblRwa3Nwd05oQ29aQ3R4NE1U?=
 =?utf-8?Q?TF3XCrxainy/UQDHd/s7EcM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a23f2bf-5cc6-4653-d0b3-08da0127ec48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:20:20.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjHKfxbG7mvGJlEpXgDit2TrQFkp/NDO8de2tcC0jNHGCJHNzyyK5Aw+pW7AiNMc6jLN2tmqAlyAKJdMDdgFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------759AQCww3SbzT8uf5vQWZab8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/8/2022 10:00 PM, Sharma, Shashank wrote:
> Hello Andrey
>
> On 3/8/2022 5:26 PM, Andrey Grodzovsky wrote:
>>
>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>
>>> This patch adds a work function, which will get scheduled
>>> in event of a GPU reset, and will send a uevent to user with
>>> some reset context infomration, like a PID and some flags.
>>
>>
>> Where is the actual scheduling of the work function ? Shouldn't
>> there be a patch for that too ?
>>
>
> Yes, Amar is working on that patch, on top of these patches. They 
> should be out soon. I thought it was a good idea to get quick feedback 
> on the basic patches before we build something on top of it.
>
schedule_work() will be called in the function amdgpu_do_asic_reset ()

after getting vram_lost info:

vram_lost = amdgpu_device_check_vram_lost(tmp_adev);

update  amdgpu_reset_event_ctx and call schedule_work()

  * vram_lost
  * reset_context->job->vm->task_info.process_name
  * reset_context->job->vm->task_info.pid

Regards,
S.Amarnath
> - Shashank
>
>> Andrey
>>
>>
>>>
>>> The userspace can do some recovery and post-processing work
>>> based on this event.
>>>
>>> V2:
>>> - Changed the name of the work to gpu_reset_event_work
>>>    (Christian)
>>> - Added a structure to accommodate some additional information
>>>    (like a PID and some flags)
>>>
>>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index d8b854fcbffa..7df219fe363f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -813,6 +813,11 @@ struct amd_powerplay {
>>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>>> +struct amdgpu_reset_event_ctx {
>>> +    uint64_t pid;
>>> +    uint32_t flags;
>>> +};
>>> +
>>>   struct amdgpu_device {
>>>       struct device            *dev;
>>>       struct pci_dev            *pdev;
>>> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>>>       int asic_reset_res;
>>>       struct work_struct        xgmi_reset_work;
>>> +    struct work_struct        gpu_reset_event_work;
>>>       struct list_head        reset_list;
>>>       long                gfx_timeout;
>>> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>>>       pci_channel_state_t        pci_channel_state;
>>>       struct amdgpu_reset_control     *reset_cntl;
>>> +    struct amdgpu_reset_event_ctx   reset_event_ctx;
>>>       uint32_t ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>>       bool                ram_is_direct_mapped;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ed077de426d9..c43d099da06d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -73,6 +73,7 @@
>>>   #include <linux/pm_runtime.h>
>>>   #include <drm/drm_drv.h>
>>> +#include <drm/drm_sysfs.h>
>>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct 
>>> amdgpu_device *adev)
>>>       return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>>   }
>>> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
>>> +{
>>> +    struct amdgpu_device *adev = container_of(__work, struct 
>>> amdgpu_device,
>>> +                          gpu_reset_event_work);
>>> +    struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
>>> +
>>> +    /*
>>> +     * A GPU reset has happened, indicate the userspace and pass the
>>> +     * following information:
>>> +     *    - pid of the process involved,
>>> +     *    - if the VRAM is valid or not,
>>> +     *    - indicate that userspace may want to collect the ftrace 
>>> event
>>> +     * data from the trace event.
>>> +     */
>>> +    drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, 
>>> event_ctx->flags);
>>> +}
>>> +
>>>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>>   {
>>>       struct amdgpu_device *adev =
>>> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>                 amdgpu_device_delay_enable_gfx_off);
>>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>> +    INIT_WORK(&adev->gpu_reset_event_work, 
>>> amdgpu_device_reset_event_func);
>>>       adev->gfx.gfx_off_req_count = 1;
>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
--------------759AQCww3SbzT8uf5vQWZab8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/8/2022 10:00 PM, Sharma, Shashank
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com">Hello
      Andrey
      <br>
      <br>
      On 3/8/2022 5:26 PM, Andrey Grodzovsky wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 2022-03-07 11:26, Shashank Sharma wrote:
        <br>
        <blockquote type="cite">From: Shashank Sharma
          <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
          <br>
          <br>
          This patch adds a work function, which will get scheduled
          <br>
          in event of a GPU reset, and will send a uevent to user with
          <br>
          some reset context infomration, like a PID and some flags.
          <br>
        </blockquote>
        <br>
        <br>
        Where is the actual scheduling of the work function ? Shouldn't
        <br>
        there be a patch for that too ?
        <br>
        <br>
      </blockquote>
      <br>
      Yes, Amar is working on that patch, on top of these patches. They
      should be out soon. I thought it was a good idea to get quick
      feedback on the basic patches before we build something on top of
      it.
      <br>
      <br>
    </blockquote>
    <p>schedule_work() will be called in the function
      amdgpu_do_asic_reset () <br>
    </p>
    <p>after getting vram_lost info:<br>
    </p>
    <p>vram_lost = amdgpu_device_check_vram_lost(tmp_adev);</p>
    <p>update&nbsp; amdgpu_reset_event_ctx and call schedule_work()</p>
    <ul>
      <li>vram_lost</li>
      <li>reset_context-&gt;job-&gt;vm-&gt;task_info.process_name</li>
      <li>reset_context-&gt;job-&gt;vm-&gt;task_info.pid</li>
    </ul>
    Regards,<br>
    S.Amarnath<br>
    <blockquote type="cite" cite="mid:bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com">- Shashank
      <br>
      <br>
      <blockquote type="cite">Andrey
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          The userspace can do some recovery and post-processing work
          <br>
          based on this event.
          <br>
          <br>
          V2:
          <br>
          - Changed the name of the work to gpu_reset_event_work
          <br>
          &nbsp;&nbsp; (Christian)
          <br>
          - Added a structure to accommodate some additional information
          <br>
          &nbsp;&nbsp; (like a PID and some flags)
          <br>
          <br>
          Cc: Alexander Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
          <br>
          Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
          <br>
          Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++++++
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19
          +++++++++++++++++++
          <br>
          &nbsp; 2 files changed, 26 insertions(+)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          index d8b854fcbffa..7df219fe363f 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          @@ -813,6 +813,11 @@ struct amd_powerplay {
          <br>
          &nbsp; #define AMDGPU_RESET_MAGIC_NUM 64
          <br>
          &nbsp; #define AMDGPU_MAX_DF_PERFMONS 4
          <br>
          &nbsp; #define AMDGPU_PRODUCT_NAME_LEN 64
          <br>
          +struct amdgpu_reset_event_ctx {
          <br>
          +&nbsp;&nbsp;&nbsp; uint64_t pid;
          <br>
          +&nbsp;&nbsp;&nbsp; uint32_t flags;
          <br>
          +};
          <br>
          +
          <br>
          &nbsp; struct amdgpu_device {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev;
          <br>
          @@ -1063,6 +1068,7 @@ struct amdgpu_device {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int asic_reset_res;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_reset_work;
          <br>
          +&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_event_work;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_timeout;
          <br>
          @@ -1097,6 +1103,7 @@ struct amdgpu_device {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_channel_state_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_channel_state;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl;
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_reset_event_ctx&nbsp;&nbsp; reset_event_ctx;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_is_direct_mapped;
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          index ed077de426d9..c43d099da06d 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          @@ -73,6 +73,7 @@
          <br>
          &nbsp; #include &lt;linux/pm_runtime.h&gt;
          <br>
          &nbsp; #include &lt;drm/drm_drv.h&gt;
          <br>
          +#include &lt;drm/drm_sysfs.h&gt;
          <br>
          &nbsp; MODULE_FIRMWARE(&quot;amdgpu/vega10_gpu_info.bin&quot;);
          <br>
          &nbsp; MODULE_FIRMWARE(&quot;amdgpu/vega12_gpu_info.bin&quot;);
          <br>
          @@ -3277,6 +3278,23 @@ bool
          amdgpu_device_has_dc_support(struct amdgpu_device *adev)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
          amdgpu_device_asic_has_dc_support(adev-&gt;asic_type);
          <br>
          &nbsp; }
          <br>
          +static void amdgpu_device_reset_event_func(struct work_struct
          *__work)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = container_of(__work, struct
          amdgpu_device,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_event_work);
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_reset_event_ctx *event_ctx =
          &amp;adev-&gt;reset_event_ctx;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; /*
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * A GPU reset has happened, indicate the userspace and
          pass the
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * following information:
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - pid of the process involved,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - if the VRAM is valid or not,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; - indicate that userspace may want to collect the
          ftrace event
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * data from the trace event.
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp; drm_sysfs_reset_event(&amp;adev-&gt;ddev,
          event_ctx-&gt;pid, event_ctx-&gt;flags);
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; static void amdgpu_device_xgmi_reset_func(struct work_struct
          *__work)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
          <br>
          @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct
          amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_delay_enable_gfx_off);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;xgmi_reset_work,
          amdgpu_device_xgmi_reset_func);
          <br>
          +&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;gpu_reset_event_work,
          amdgpu_device_reset_event_func);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_req_count = 1;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power = power_supply_is_system_supplied()
          &gt; 0;
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------759AQCww3SbzT8uf5vQWZab8--
