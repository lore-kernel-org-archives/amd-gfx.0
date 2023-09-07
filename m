Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E88EE14D0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D6310E77C;
	Thu,  7 Sep 2023 07:31:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6434010E783
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 07:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahCTZxsvTn1k8EGEIRtqlo6oBrnKwEnstctjlwMi+g4AJMM7e/K09nn9X93aPFHS+AIilQlwh2vA8URecPklGToFusIkz7Qn8zvII4EoZ4+5xDbGC/pvceW2cZf9k6iPVi/mQfJ44r9cNRjS1oyu1JAhL47uqmvUofdprS5kwi7VRDc40pnwFl2J6/4PfaTCv4pIXLPFUvCPuhZfTOpeN7JAx0mFvftQ6wYVJ3Bfq5XSzfOHPeXuGrD96l9mfkvvnIwqbXbDYhmhec7SxQY7PqWlLHmRvhHvD5BkUFbcUZjt2GGk4aaoFcolhGMJIXGDTJ9CUn8o0DQGUCBKPpyG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cbg+a4G7a/L65vNqOafdOA43nD7fL2CxeT0AlZdsgQ=;
 b=j91gJ4pONLCu3YIW7oxoIYwVyxXFL/D8hHWNA5GBFQMCRY52+O8LgnM6uKNRdAmxndT00CCI1R+HetPrLtTJ2Y32nBEloNa2Bitm0NJbk1Cjnp0qTAYQ5Ee4yigXD4MbISSKEipSFD5Y98+a7/HKn+MJjXQnVNycvoZZA1IvWFWkUbMfvDMO/9HXanBydtozFWGVenBB2QKIpb5jSKVIE+aan2JFtk+DrwC1kvSNgnJNXtJ4YHs8Nj2WbTcG7X74ukOXEvc+kQ1rh/lJBd6pF3l+1aP0rOiTthkfnOIqZBQXUEYyaovCEm3SxiGIm76K05i8QtzafourZTsVwScRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cbg+a4G7a/L65vNqOafdOA43nD7fL2CxeT0AlZdsgQ=;
 b=iLL2df3w2JSHSirJ1AC8zmXETw38lXnldK3Lef0QTf+qab6BB6I06UyCK1psUGcVuqb9bCGNkWH0Q+tffOG8dRh5OmTg+aTXQyiwh4TLP2nrKoUuxqXPAhQvM0GD0ti7rsDSyFldqiSc8wTSXex4OrbwOM1D+M5JYMNFVp19YDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:31:09 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 07:31:09 +0000
Message-ID: <3b2d2550-650f-c591-8573-077a7e348508@amd.com>
Date: Thu, 7 Sep 2023 09:31:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
 <4995b233-e9db-93a0-1ba6-60376cb5d024@amd.com>
 <e75b6e4a-d4f4-7754-e102-4d9f64e8b70b@amd.com>
 <7e43a523-8ea9-486a-b48f-10ea7995dc31@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <7e43a523-8ea9-486a-b48f-10ea7995dc31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a908457-8a5d-46a5-88b7-08dbaf7467ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flf9ii3OE8dgM3k4pkI68BlwydkD8Righd9LqnNzmgMFzymPAPcABDvM4zMktD/Z/0kIbiYV12x7PIMfLkHtUOTzdizg9Ys/NsWdF9AV3JgrKhK14vZVu9jmlH8lWqHXdXKCyOvXa8dAM05QQubh9yda0DFuMBA+q8TNPZxnigk3kxfveQz8gqUOewxnvrGZSiZhAm9xeIEuTxkh0R18hb42q6aIWrVT3E/7ihYdk1Cpvw/U58fb5RWDh+ReoPj7G14y8UL3KScSdv+K7pgBKPduY8SeutVVQ72fycKxCFkc06WZ3H/uW7m4W75ZLfZz6P9YHR4VuED1mGnO5NYJYbt8WTzjeZlRgLO4tQFEdMQ/gQ6qf4UPjfRFPBYgi+KoranARHkSeGJeL8EEM0O60T+Aq2lOYGMwZlEMLZLuisJABYncRJDEbQZSlSp80FdAQ398Gq+7kPsaq83YQZK9kJowSQFS17D1b5wvFwiQihBv3p6V755iDC4Hdm17t2sB6/RjCuf+TnjOSg5dRpaf1MT5nCfSM4XdJOgI0qX5J4iZbFui5TkSNaGTEdhmwsT/UmEEKzd7cO54Zgvixe+A4EnRxQGkcHhNw2aikMPAuUS3MVOTSQYkz4Yt95CRK4h4prZ7ue9FZdfif4Jy9wqj4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199024)(1800799009)(186009)(31686004)(66574015)(66476007)(44832011)(316002)(2616005)(6666004)(86362001)(31696002)(66946007)(66556008)(2906002)(8676002)(41300700001)(8936002)(5660300002)(38100700002)(478600001)(6512007)(26005)(6506007)(6486002)(53546011)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlBWUViQUMwTkRLcTVSSURBTUdRYktEZUdBRlBKZlZtaVNlbUFiV1doUTJk?=
 =?utf-8?B?THFvaFpPUFllRlFDQzluSFpuTVV5UkU3K29iQWdxNFBwd1pHeHVSYXlna3lB?=
 =?utf-8?B?V1hkUEVkZ1pyaXlhZHFOUnA5N0Y3eG1RMjF1ZzYzTXgzck41OGNLcHd4MUM4?=
 =?utf-8?B?VDlsMGJTazU0NlJMSWp5UFpNSnR5d0xYWngxQnFMVjBHYy9YQnA1NmIvMS94?=
 =?utf-8?B?Z0docVVZcDJoeWh1UnN2TXg1a1orQktLa2R1bUd0OGQ3c2pJanBDYld1cDVr?=
 =?utf-8?B?bXliM0ExREZUN3AyZnJpR3Vxc3RkYUhqcWM1aUVWNGJQcmhHbmJUOFFGcHJC?=
 =?utf-8?B?UHJVdFVyNzJsVjhBam44akNrbmQxd2h1bHRJWE5YMC94b3IwVEwvT3N5K3Ay?=
 =?utf-8?B?WkRuYit5N3JjUG54d1kxTmFBVlNHbkNYM1dLd3hJR1hmenBONWJubGNab1pB?=
 =?utf-8?B?RFpPa0p3L2dBeklNdCs4UUV6aVJFZ0EyVksyVGlSYmZrUU1qQVZsQXRRUGdh?=
 =?utf-8?B?RXQ0MCt3UGhmOUE1U3lnazRjSDlWNUsvajRkYkpVTkRrci94U3FmVXdsaWdy?=
 =?utf-8?B?SjBZQlBSTmtLSDNScGtvbW1TakdVNkNmbWJtcVJBU0dsSEpBc1p4OVZlbTZJ?=
 =?utf-8?B?U0JONUprTmp3OWFYbkJOc3hzK0R2bmlIaS9SeHFoTENOalp4UnFvWWFsemkz?=
 =?utf-8?B?ZEhaOVRFWUhrSzRUNXdCaC9OYnJ5K1ViVmVMeUFiVDBHUExTS0tDSzI2dVZF?=
 =?utf-8?B?eXF4MUFDNmtDSzdNVS9yZjR5VlhuRUpYaGJ5YzExUUVidzF1aWducXhTQUJL?=
 =?utf-8?B?OUJUa0xQcnhMWDcycUc2WDVkZlJHZTI3dUhma29GaDI0WDJxWHJ1UXJ1Vyt2?=
 =?utf-8?B?V2hDQmROZ0o2bThpRkg3aWMvVjRsUDhsOHk5ejF0VC9XYjY1ZGUrYzlFcG9M?=
 =?utf-8?B?bEF3NFJNUHF1Z1UvaWZQWUVJc01JQktUemxrT0ZnM1dMNWNyeU5JR09DUE9n?=
 =?utf-8?B?eUtneisyUFJYT3lGczdkcmxPYnBkNUFCM0NURHIxdUlXVGMxZVh3NUVmUVQy?=
 =?utf-8?B?cENyNUFUek50UWZFZ2FkTmtOZklWV3ZLWTRRMmFLa3lYLzMwWUU1dU5RdFFn?=
 =?utf-8?B?MjRmeVk1eGxnaVh3bWtwRVNac1NVZ3UwTXo5NC96d3JOTzhlS3dscS9hOVV1?=
 =?utf-8?B?NHM2SFVTUnAzTTNKbkptejR1cE5Lb0d3YjVJWDdzYnh3eGZkRG9RdHNKcVVk?=
 =?utf-8?B?ZExXcXRCeG14dk1ZMWdUOWtyNGVOVGRDWmFQVjJvdDBhMUxsZkUydlk1dHdi?=
 =?utf-8?B?YVMxeXZJclpqZGowcmpwWHh0cjVIaENkc09IWXFWdWNqZzl4N0lkOHg5cEd0?=
 =?utf-8?B?R2ZVV1h5dHd1bHg1MUcwejFjRVNEQmVFVDV5dy9SaVQyVFB6cUJKdnBmL0VS?=
 =?utf-8?B?VmM2azJURzcrOHRHeExraGgyRm0wdFptOEdocTE2UWYzNmRrSWNUTDBieEN0?=
 =?utf-8?B?VTdpazM3MVFORmF0MW8xcHcxRFpTZFlzeWZ6M1FCZktqcWFKYW8vVmpSZ3Uy?=
 =?utf-8?B?QmVLVWlYU2JWdWdiRFNZZXdRaDlWd1BvcWRlOFFwREM0dVlGcW1xdWhlQ3c2?=
 =?utf-8?B?M2hMWG4xZVViSnF2YkRjcEhUYUszSE10NldMRFVleWh4Y3BwNXZvbnVKT2I5?=
 =?utf-8?B?aHJLaUdXNWFTVWtObEZVRWloUnpScHYvTzV5TkczWW9OVERHTVA5TkorcENv?=
 =?utf-8?B?eWt3VXptWkhSMEVVVWwyUUt5TXJmZHIxR29mM0dFcW5MOXFnL0JFcVFoT2FJ?=
 =?utf-8?B?U1EySUtSSVdsN2d3ZFJKUm1DTk9JU0FpSXNGdVdlMnFzTHZXWkwzVWJQY1ZO?=
 =?utf-8?B?S1dqTlg3QURGaVFOUkUzbjQxbG5Ud2tKRkxkQTRmVmhHRU5xR3NhODlETzNp?=
 =?utf-8?B?RHFkUFMyQTd2aW82bHNzREJxcmVjeE5kTzlUY0NUeUw4Z0g5VzZUaUZ0YU02?=
 =?utf-8?B?SDZPK3hDcmhHZ1VyQWo4ZVlLWFZsRDEvT1BpTTgyV1dlRUpWeVZadWNQYnIv?=
 =?utf-8?B?MHNJZTZKWS9Ya1dmanlsRlM1OGEzM014Z0lTVVZ2Nk5jNmxaWlNaVTZPWDdU?=
 =?utf-8?Q?S7JiNVJw9yq5vfYsQeMotYY1Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a908457-8a5d-46a5-88b7-08dbaf7467ba
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:31:09.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQNcnlPmfNkdBCIZOV/gGPcH2oxO0zmb6AHeag4Cgo+fmWNIldrhSOPFWK8bplZ4oTVEi1W6QBSkzyJr8keb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/09/2023 08:57, Christian König wrote:
> Am 06.09.23 um 16:35 schrieb Shashank Sharma:
>>
>> On 06/09/2023 16:25, Shashank Sharma wrote:
>>>
>>> On 05/09/2023 08:04, Christian König wrote:
>>>> Testing for reset is pointless since the reset can start right 
>>>> after the
>>>> test. Grab the reset semaphore instead.
>>>>
>>>> The same PASID can be used by more than once VMID, build a mask of 
>>>> VMIDs
>>>> to reset instead of just restting the first one.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>>>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> index 6a6929ac2748..9e19a752f94b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> @@ -33,6 +33,7 @@
>>>>   #include "amdgpu_ucode.h"
>>>>   #include "amdgpu_amdkfd.h"
>>>>   #include "amdgpu_gem.h"
>>>> +#include "amdgpu_reset.h"
>>>>     #include "bif/bif_4_1_d.h"
>>>>   #include "bif/bif_4_1_sh_mask.h"
>>>> @@ -426,23 +427,23 @@ static int 
>>>> gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>                       uint16_t pasid, uint32_t flush_type,
>>>>                       bool all_hub, uint32_t inst)
>>>>   {
>>>> +    u32 mask = 0x0;
>>>>       int vmid;
>>>> -    unsigned int tmp;
>>>>   -    if (amdgpu_in_reset(adev))
>>>> -        return -EIO;
>>>> + if(!down_read_trylock(&adev->reset_domain->sem))
>>>> +        return 0;
>>>>         for (vmid = 1; vmid < 16; vmid++) {
>>>> +        u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>>>   -        tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>>>           if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
>>>> -            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
>>>> -            WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
>>>> -            RREG32(mmVM_INVALIDATE_RESPONSE);
>>>> -            break;
>>>> -        }
>>>> +            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
>>>> +            mask |= 1 << vmid;
>>>
>>> I am a bit concerned here about the change in code, in the previous 
>>> code we were writing the 'first match out of 16' of tmp and of mask 
>>> and programming the registers with (1 << vmid), whereas in new code 
>>> set we are writing the 'last match out of 16' of vmid. Is that 
>>> intentional or expected ?
>>>
>> With last, I mean all matching bits until last :)
>
> Take a closer look :)
>
> The bits are ORed together for each VMID which has the matching pasid.


Agree, I saw that the previous code was programming only the first 
matching VMID (and then break the loop), but and then I reiterated the 
commit message and realized that it was the bug and this patch is fixing 
it :).

Please feel free to use: Reviewed-by: Shashank Sharma 
<shashank.sharma@amd.com>

- Shashank

>
> Christian.
>
>>> - Shashank
>>>
>>>>       }
>>>>   +    WREG32(mmVM_INVALIDATE_REQUEST, mask);
>>>> +    RREG32(mmVM_INVALIDATE_RESPONSE);
>>>> +    up_read(&adev->reset_domain->sem);
>>>>       return 0;
>>>>   }
>
