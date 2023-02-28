Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173D2C64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 08:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1910E4AF;
	Tue, 28 Feb 2023 08:45:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA8510E4AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 08:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLemQwCP86UvnWyu1HPisf8VpR1pv+6blBU2HWlGsCIEpb+0Xhvd3hU0MfUHZ66/Aflu1TmQXO3UjStSTO3SkGIF/Jmuis1D5fOjVaLHf3XCYaHAFAZP4Oir4zLIfiVhCDntSHrxOSW+HslxGUgo+ALxQW9mzZJ+1LnmAIi3ykaPUACD/n21y1fTkRduoXcO7SF0eXD1/Lv7RSGWkoMvdYuzavvUdEvppZkZ7ZvVyRUGLX70cHe3FfI/BDxpephOXbv3qa+sPwf5Ls4cGkVchaZ7d5coVOptj+EVzbpirO6XyP6CUxZbRM49fH7kb6ZUSaizxU1/ajdIxwwOhST3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jehjeZx+wLdNCvjnMUCSuIYho95y0Hk5iWJrm91qobY=;
 b=fUvJf1fLb26eX1g7AZ+zNiwwgLkDi6CQWPlCIw11SVRQL7/N+CMaAex1cq+KVpJaEb+Gw4q+cBsbuLyGMqm94UR1NJYbOLfIIVrYUGy1EiP+RsDJlmdA3ps+xlea/tDgKNWaGJw8HaeMkN8+lR76L7SFiW7SPMdoPhGSONSUPq9OvmA0wdcY9GgdY0ktfX41ZW69F7IUnv5AdNPnh71m5FIoGFeOXj5WuBcAa5KYYzkTnhBR6iBxNzhi0luGyrVDkzTpB9+4WYKY5dOCypKl+tpY3g2x+8wfaBrUHZiWLGbeqP4g+3ZiDpSHY3OAG7RpYKU/CdihqfnwiAJzsn5lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jehjeZx+wLdNCvjnMUCSuIYho95y0Hk5iWJrm91qobY=;
 b=TRX8lE9dW18MBeOnYV1hpUUAXs9lfd93d9NZhS2znMG7geDnma3murCNf6zpECuJbuabA9U2NohNYdTmx5H1oXZlm7qEltHL8K5oSccAWpFvVPD01jZ71I6YRMtXIl012VGs7iHc737qFa07uEXAQLjS1ua7UYjyASrGDXHIVVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 08:45:33 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 08:45:32 +0000
Message-ID: <4f216a52-e86a-4aeb-af6d-c9e4a885d11c@amd.com>
Date: Tue, 28 Feb 2023 14:15:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/6] drm/amdgpu: Implement a new userqueue fence driver
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-3-Arunpravin.PaneerSelvam@amd.com>
 <1f68e20f-3934-b66f-48d5-cb62da7f8895@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <1f68e20f-3934-b66f-48d5-cb62da7f8895@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4eb1de-5b6d-4bf1-d5dd-08db196826f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXEjfgHqCWkzdN0k0Z3nIuX0Z8VcbXjchMG6d4T6nh6BEV4Wp+2T/vZiL8WHQjVJwMwLgNksEwQfT6EW53bNwqQZj4e7IEkcxxhEPvuiEJNcNQxcwPt5a6z4EP3oGKsyOeRk2xUH+Nixu3g1Spn63ciOHYAQuBO4/7jwzH15a9kq7DGA76rTHJa4Qm9dyE92O0zNKHdFSV0ELDcIIAf1F3pH0H/k2xASwSFaP3ujo4AQgirofUYxVWW4nSDpqYfhbWhCjTEmqrMk1jNkMS0SXq6UnkxCly7sa9MEz+tldp+LTFcOwM0proh5deD4iRtJGsym7NnF65USWrcSWvSq4BCZD+i6i44kkB7MIkiz7u3ovitbVr8pkmkT5QSQPthNZeXL3sfMCV29XwsmdX1AAPVlAdHiQzwBzF0GxOiZ3Cf7oP4QgrGfgJtxfQoOsH4wP9EDJgBicvGwRWHRW/nc9hJKoG9ALzSUrqt86qI4nF6+xLVgmBP9/7ZeXWh8nOEcjggZ9pbmc0MZjAHwYN9Klkn4mM126kbHb0xUNGV04ZBJgdo1Vt+73Oa+ROLRLhlvr8IIBtkYcwyg7wWr7EFJXrzJdK3qAkalxsfho2GFJ9ODQoglPuoFeBbxdDd1BTNh/8LN0wUVVjsXJC/HAd59JsIoI9EvFrUN5P58Zrj3G+pP4j1HlOTaE7dp1suCuxj2rM0ZmfFP16DgBatRxYWXmrFEFMBFKmT7S+6JukV8VOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(5660300002)(30864003)(36756003)(86362001)(8936002)(31696002)(83380400001)(478600001)(66574015)(2616005)(6666004)(6486002)(66946007)(6506007)(66556008)(26005)(186003)(8676002)(66476007)(6512007)(41300700001)(38100700002)(4326008)(316002)(53546011)(66899018)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBmOW41MWhYMGdDTU1WT0I3MzE3RUlPQ2w4NGk1cUIvUDF6QjdiOVJGQm5Z?=
 =?utf-8?B?dUdpSEM5azRiek1XazdibXVHYWU2bjZiTjFsNE5LTUtMNkNRcVBkclN3YnBR?=
 =?utf-8?B?b2hxSDM2UGdHQm9WcWFEaSsxQWhuOFM2V3NWSUFrR3BrYTU0eDRpdm9IeGc2?=
 =?utf-8?B?YW1lampjakdxUVo2cHhMMmZuTGR2cjBlditvNVM2NTFwKzRiRjFSa0QwYk1C?=
 =?utf-8?B?d0xvcE1KTFZTenhqWXZvQ2JsYkt4UEN5RmJQWHQ5bC9HaE9NcFU5di9OelIv?=
 =?utf-8?B?MXdXZzhKbjF0VnVQZ1ErY2FOUjZZdjBFVmIvSStURDBNenNjSDR6bmJkVjBI?=
 =?utf-8?B?czgxQWI3MnNHSnpvZEhDcE9KQkRZekc5dU5CaGdxOFFiWGZHR3NiemRGV2E2?=
 =?utf-8?B?ODNoeWwvT3VjaUxuUjlaTkVkT0dnMEsvaHJYWHp5ekJPQjdmM0pnMkcyVm0w?=
 =?utf-8?B?cUs4dnUxU2lGZkFuYjd1akt5amM0TzRYYzJib1laQnhtSEkrODRwZ3luQms2?=
 =?utf-8?B?TmM5ZmkxbW8ya0tkNHVKNFBsUmp5K3FkWHcyWWFmRm9wSEpPZzNyK1MyTkJB?=
 =?utf-8?B?WFhuQ3RKQnNCTDREUWpLMm9YRVVYdzRJSmdnZmhTYkNqMkR2VnRGM3NPNmll?=
 =?utf-8?B?TXdIT21YWmRKaDBqSjNVMjBDck9OQVN1LzgrVnpkNDA5SnVqYVYxMExQbWpY?=
 =?utf-8?B?cGUxQmsxRjZJZ1gwU21MeDkyZ3hNaW5vWmlhWDdVRVVIa3NvQ1NpeU5aa3NO?=
 =?utf-8?B?QTFsZkVoTnZmSGtIUGxxRS93dHBVeHdXQ0k3SENJZzB5UGNNR1pLNXpoMDNV?=
 =?utf-8?B?TWRSVmd5c2R3d1p6Sk1uaFlZbUF3QnBFM1UxdkFrYklrcnAycmlUWDMzM2RH?=
 =?utf-8?B?bTQyV0hwWG9mQlFzb3BsbDdCbzZwOUE1Z0hwWU9HYWRWVUJoUHhmUEo3Q0pV?=
 =?utf-8?B?VWZmRGRiU2RzREZIUU9JUm4yWCtSaXJXUlJwZHVwVC9zeGsxYmxObU1hMTAx?=
 =?utf-8?B?STc5NWNUYlpFRjNGd0U2RUdSNXR4a0ZYN2dFNE9KSDVKNkR1aWZacHJoSXkv?=
 =?utf-8?B?c2k2dVlEWkgwUUFXc1VDY1ZTUTVEdjEvWUFqZUNQQzJyTTlLWW9oVzVsVzYy?=
 =?utf-8?B?VHRZM0Jqb29YOHFkanZYNkI5SDlGa2hBMzE1TlNGWmRuUXppekNaSE5sSzF2?=
 =?utf-8?B?aDl4OFJxbHFCakFvTjE0djhVSHl2R2ZraE84ZGVRVDRTMGx3VVhwK05qbURM?=
 =?utf-8?B?T2JmbVo3WXp4SmlRT1d6MW1hTUxBTGxiZXozdWtHSGFZR3U5ZnhNNXBuU20x?=
 =?utf-8?B?bHRjMjlkU011bkVyVnY2QkVYVHpRUzF5WTltd1JReUYwY1BESkxmYzF2Q2RI?=
 =?utf-8?B?cjd6YVlUc0o4eDRWZVRkQlJZNWY1aWcyRmk2OUNpQlZIWjJrekVRc05pSU9O?=
 =?utf-8?B?T3pPZW14cTV0b2hSTTVCREpiQTRvSTlGb0tYakpMelBVNVlzdWxFalhHQW9h?=
 =?utf-8?B?eEVGYTI1UmF4cDBYL2dwc0FPK2RXcURMN243Q0hDbG56cEZ3emd6cXBlNzdu?=
 =?utf-8?B?QlFhSURqZFdCM2w2U3A0Q01sRWV2UEo4Y2oyTjU2aW1GcUt5clhnS1Bucll6?=
 =?utf-8?B?NktoTHgxend5NVk5UGhMRGpRRFFFNzJ3dXViWWliN3F5bjlvOWZyanhZTC9K?=
 =?utf-8?B?NzQzcmNBcVdPNnNKSy9FYk5wZGRKMEtzUXRXcG8vUzBiY1N1dVpNNEE0MjFz?=
 =?utf-8?B?cy9wdkF6ZkF0d3VBSXNXNXJjaFRaOWVTTm1lTFluTjZWUlFvUU1XS0VEL1B4?=
 =?utf-8?B?Smc4U0U4S2Y0aFFSOVdpZVI5VCtncXpiblhzQ2w5cVdjUEFvd1NZZEdqd3ZF?=
 =?utf-8?B?VmJFbXphZXpsbmRqS2g3dUNFVUZoSHozVFBCSERmeEFMa0dNYldOSWV1Y2lq?=
 =?utf-8?B?Ylc1QjZRb3g4Zlh3U29kTFJ6Rkora2dTVzRucXFOZGxFWjcxYThkVWQwUzhV?=
 =?utf-8?B?K1d1eVJrWlhqZDZna0xHRCt4azV1MzJYTEJQWTlTMVk2MnlNMFRwMmwxWldG?=
 =?utf-8?B?d0tDRVMyWWdwdzVyVm1FQmZ5TVJ6bTZJMlJWdG5FOTdGNHdNWGRzdXRVK0s5?=
 =?utf-8?Q?y5Ph8te3XE1wsxDHIz1s1A7Yg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4eb1de-5b6d-4bf1-d5dd-08db196826f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 08:45:32.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjl5zNvPqALrlL9MTa8BeGXL2QFL3favwbkem31tvyw4byxfVGnnos5we+a41tgerbG6dwIT56yU5bFRrVtOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 2/27/2023 6:12 PM, Christian König wrote:
> Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
>> Developed a userqueue fence driver for the userqueue process shared
>> BO synchronization.
>>
>> Create a dma fence having write pointer as the seqno and allocate a
>> seq64 memory for each user queue process and feed this memory address
>> into the firmware/hardware, thus the firmware writes the read pointer
>> into the given address when the process completes it execution.
>> Compare wptr and rptr, if rptr >= wptr, signal the fences for the 
>> waiting
>> process to consume the buffers.
>>
>> v2: Worked on review comments from Christian for the following
>>      modifications
>>
>>      - Add wptr as sequence number into the fence
>>      - Add a reference count for the fence driver
>>      - Add dma_fence_put below the list_del as it might frees the 
>> userq fence.
>>      - Trim unnecessary code in interrupt handler.
>>      - Check dma fence signaled state in dma fence creation function 
>> for a
>>        potential problem of hardware completing the job processing 
>> beforehand.
>>      - Add necessary locks.
>>      - Create a list and process all the unsignaled fences.
>>      - clean up fences in destroy function.
>>      - implement .enabled callback function
>
> A few more nit picks below, but from the technical side that looks 
> mostly clean.
>
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 251 ++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  61 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  20 ++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>>   6 files changed, 341 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index a239533a895f..ea09273b585f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> -    amdgpu_ring_mux.o amdgpu_seq64.o
>> +    amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index bd3462d0da5f..6b7ac1ebd04c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -53,6 +53,7 @@
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_userq_fence.h"
>>     /*
>>    * KMS wrapper.
>> @@ -2827,6 +2828,10 @@ static int __init amdgpu_init(void)
>>       if (r)
>>           goto error_fence;
>>   +    r = amdgpu_userq_fence_slab_init();
>> +    if (r)
>> +        goto error_fence;
>> +
>>       DRM_INFO("amdgpu kernel modesetting enabled.\n");
>>       amdgpu_register_atpx_handler();
>>       amdgpu_acpi_detect();
>> @@ -2851,6 +2856,7 @@ static void __exit amdgpu_exit(void)
>>       amdgpu_unregister_atpx_handler();
>>       amdgpu_sync_fini();
>>       amdgpu_fence_slab_fini();
>> +    amdgpu_userq_fence_slab_fini();
>>       mmu_notifier_synchronize();
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> new file mode 100644
>> index 000000000000..609a7328e9a6
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -0,0 +1,251 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <linux/kref.h>
>> +#include <linux/slab.h>
>> +
>> +#include <drm/drm_syncobj.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_userq_fence.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static struct kmem_cache *amdgpu_userq_fence_slab;
>> +
>> +int amdgpu_userq_fence_slab_init(void)
>> +{
>> +    amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>> +                            sizeof(struct amdgpu_userq_fence),
>> +                            0,
>> +                            SLAB_HWCACHE_ALIGN,
>> +                            NULL);
>> +    if (!amdgpu_userq_fence_slab)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_fence_slab_fini(void)
>> +{
>> +    rcu_barrier();
>> +    kmem_cache_destroy(amdgpu_userq_fence_slab);
>> +}
>> +
>> +static inline struct amdgpu_userq_fence 
>> *to_amdgpu_userq_fence(struct dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *__f = container_of(f, struct 
>> amdgpu_userq_fence, base);
>> +
>> +    if (!__f)
>> +        return NULL;
>> +
>> +    if (__f->base.ops == &amdgpu_userq_fence_ops)
>> +        return __f;
>> +
>> +    return NULL;
>> +}
>> +
>> +static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>> +{
>> +    return le64_to_cpu(*fence_drv->cpu_addr);
>> +}
>> +
>> +int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev,
>> +                  struct amdgpu_usermode_queue *userq)
>
> Looks like you misunderstood me a bit.
>
> The usual naming convention in Linux for reference counted objects is 
> like that:
>
> _alloc() or similar for a function creating the object (the one which 
> has the kref_init).
> _get() for the function grabbing a reference.
> _put() for the function releasing a reference.
> _free() or _destroy() or similar for the function which is called by 
> _put() to cleanup.
>
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    int r;
>> +
>> +    fence_drv = userq->fence_drv;
>> +    if (!fence_drv)
>> +        return -EINVAL;
>> +
>> +    /* Acquire seq64 memory */
>> +    r = amdgpu_seq64_get(adev, &fence_drv->gpu_addr,
>> +                 &fence_drv->cpu_addr);
>> +    if (r)
>> +        return -ENOMEM;
>> +
>> +    kref_init(&fence_drv->refcount);
>> +    INIT_LIST_HEAD(&fence_drv->fences);
>> +    spin_lock_init(&fence_drv->fence_list_lock);
>> +
>> +    fence_drv->adev = adev;
>> +    fence_drv->context = dma_fence_context_alloc(1);
>> +
>> +    get_task_comm(fence_drv->timeline_name, current);
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>> +                     struct amdgpu_userq_fence_driver,
>> +                     refcount);
>> +    struct amdgpu_device *adev = fence_drv->adev;
>> +    struct amdgpu_userq_fence *fence, *tmp;
>> +    struct dma_fence *f;
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>> +        f = &fence->base;
>> +
>> +        if (!dma_fence_is_signaled(f)) {
>> +            dma_fence_set_error(f, -ECANCELED);
>> +            dma_fence_signal(f);
>> +        }
>> +
>> +        list_del(&fence->link);
>> +        dma_fence_put(f);
>> +    }
>> +
>> +    WARN_ON_ONCE(!list_empty(&fence_drv->fences));
>> +    spin_unlock(&fence_drv->fence_list_lock);
>> +
>> +    /* Free seq64 memory */
>> +    amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>> +    kfree(fence_drv);
>> +}
>> +
>> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>> +{
>> +    kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>> +}
>> +
>> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> +                  u64 seq, struct dma_fence **f)
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    struct amdgpu_userq_fence *userq_fence;
>> +    struct dma_fence *fence;
>> +
>> +    fence_drv = userq->fence_drv;
>> +    if (!fence_drv)
>> +        return -EINVAL;
>> +
>> +    userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, 
>> GFP_ATOMIC);
>> +    if (!userq_fence)
>> +        return -ENOMEM;
>> +
>> +    spin_lock_init(&userq_fence->lock);
>> +    INIT_LIST_HEAD(&userq_fence->link);
>> +    fence = &userq_fence->base;
>> +    userq_fence->fence_drv = fence_drv;
>> +
>> +    dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>> +               fence_drv->context, seq);
>> +
>> +    kref_get(&fence_drv->refcount);
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    /* Check if hardware has already processed the job */
>> +    if (!dma_fence_is_signaled(fence)) {
>> +        dma_fence_get(fence);
>> +        list_add_tail(&userq_fence->link, &fence_drv->fences);
>> +        dma_fence_put(fence);
>> +    }
>> +    spin_unlock(&fence_drv->fence_list_lock);
>
>> +    /* Release the fence driver reference */
>> +    amdgpu_userq_fence_driver_put(fence_drv);
>
> Hui? That doesn't make much sense. We should keep the reference as 
> long as the fence exists or at least as long as it isn't signaled (the 
> later is probably better, but tricky to get right).
>
>> +
>> +    *f = fence;
>> +
>> +    return 0;
>> +}
>> +
>> +bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>
> Maybe name that function amdgpu_userq_fence_driver_process() and move 
> that up a bit to group together the functions dealing with the 
> fence_driver and the functions dealing with the fence.
>
>> +{
>> +    struct amdgpu_userq_fence *userq_fence, *tmp;
>> +    struct dma_fence *fence;
>> +    u64 rptr;
>> +
>> +    if (!fence_drv)
>> +        return false;
>> +
>> +    rptr = amdgpu_userq_fence_read(fence_drv);
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, 
>> link) {
>> +        fence = &userq_fence->base;
>> +
>> +        if (rptr >= fence->seqno) {
>> +            dma_fence_signal(fence);
>> +            list_del(&userq_fence->link);
>> +
>> +            dma_fence_put(fence);
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    spin_unlock(&fence_drv->fence_list_lock);
>> +
>> +    return true;
>
> BTW: What's the return value good for? Could we drop that?

Working on v3, will include all the review comments.

Thanks,
Arun
>
> Regards,
> Christian.
>
>> +}
>> +
>> +static const char *amdgpu_userq_fence_get_driver_name(struct 
>> dma_fence *f)
>> +{
>> +    return "amdgpu_userqueue_fence";
>> +}
>> +
>> +static const char *amdgpu_userq_fence_get_timeline_name(struct 
>> dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
>> +
>> +    return fence->fence_drv->timeline_name;
>> +}
>> +
>> +static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
>> +    struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
>> +    u64 rptr, wptr;
>> +
>> +    rptr = amdgpu_userq_fence_read(fence_drv);
>> +    wptr = fence->base.seqno;
>> +
>> +    if (rptr >= wptr)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>> +{
>> +    struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>> +
>> +    kmem_cache_free(amdgpu_userq_fence_slab, to_amdgpu_userq_fence(f));
>> +}
>> +
>> +static void amdgpu_userq_fence_release(struct dma_fence *f)
>> +{
>> +    call_rcu(&f->rcu, amdgpu_userq_fence_free);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_userq_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>> +    .signaled = amdgpu_userq_fence_signaled,
>> +    .release = amdgpu_userq_fence_release,
>> +};
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> new file mode 100644
>> index 000000000000..230dd54b4cd3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -0,0 +1,61 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_USERQ_FENCE_H__
>> +#define __AMDGPU_USERQ_FENCE_H__
>> +
>> +#include <linux/types.h>
>> +
>> +struct amdgpu_userq_fence {
>> +    struct dma_fence base;
>> +    /* userq fence lock */
>> +    spinlock_t lock;
>> +    struct list_head link;
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +};
>> +
>> +struct amdgpu_userq_fence_driver {
>> +    struct kref refcount;
>> +    u64 gpu_addr;
>> +    u64 *cpu_addr;
>> +    u64 context;
>> +    /* fence list lock */
>> +    spinlock_t fence_list_lock;
>> +    struct list_head fences;
>> +    struct amdgpu_device *adev;
>> +    char timeline_name[TASK_COMM_LEN];
>> +};
>> +
>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>> +
>> +int amdgpu_userq_fence_slab_init(void);
>> +void amdgpu_userq_fence_slab_fini(void);
>> +int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev, struct 
>> amdgpu_usermode_queue *userq);
>> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver 
>> *fence_drv);
>> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> +                  u64 seq, struct dma_fence **f);
>> +bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver 
>> *fence_drv);
>> +void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 2f1aba1e9792..d4317b0f6487 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -23,6 +23,7 @@
>>     #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>> +#include "amdgpu_userq_fence.h"
>>     #define AMDGPU_USERQ_DOORBELL_INDEX 
>> (AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START + 4)
>>   @@ -264,6 +265,8 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>       struct amdgpu_vm *vm = &fpriv->vm;
>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>       struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>         pasid = vm->pasid;
>>       if (vm->pasid < 0) {
>> @@ -280,6 +283,19 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           return -ENOMEM;
>>       }
>>   +    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), 
>> GFP_KERNEL);
>> +    if (!fence_drv) {
>> +        DRM_ERROR("Failed to allocate memory for fence driver\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    queue->fence_drv = fence_drv;
>> +    r = amdgpu_userq_fence_driver_get(adev, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to get fence driver\n");
>> +        goto free_fence_drv;
>> +    }
>> +
>>       queue->vm = vm;
>>       queue->pasid = pasid;
>>       queue->wptr_gpu_addr = mqd_in->wptr_va;
>> @@ -339,6 +355,9 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>   free_qid:
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>   +free_fence_drv:
>> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>> +
>>   free_queue:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -363,6 +382,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       list_del(&queue->userq_node);
>> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>>   }
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index bda27583b58c..cf7264df8c46 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -73,6 +73,8 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_vm        *vm;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct list_head     userq_node;
>> +
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>>   };
>>     int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>

