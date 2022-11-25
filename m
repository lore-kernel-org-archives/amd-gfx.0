Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F7C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 16:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1C910E766;
	Fri, 25 Nov 2022 16:53:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5A210E766
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 16:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCN7aEkRWJ1O9gw/yeXe87XXpVKVv9MgflfV71MFezvxjhiRGKtXopjAKD7tzccKks2A5dlOwZRydofqICWgOWzxlfD8bUH53mw9VfwQ9RObgaHVcI+XpIGzb8eKsqCFHUVLDHF7yjPNJyRKaKcDtsY2X+lSJQKxs09qEe9jiWQe6/pHZog73eDsOcENLeBsdqfRgHJmB5X/BN9NDB2EdAIooPK59w2CjfDL6gdOOn6+zHuGSklR7Gg3VApovpMl4c/qs6RA01h9nQIadD5BRC3uNZI3SLhQlutjHgteOxM1MF1rmjV2hXIsky+KqXXWVIi8iw9wFoBUBDe74+QIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grne3haEggHY8YiKQNbwWwa7ApZZUNfwvw12D5uhMGE=;
 b=i95mUbBRpZG9mDqPtqww8V8XuIV4zykF8fmjHsVZlaqus10AYfE5jh28SoprP2Ms25xIcwTgCjST6oST5rX5k2cpVYdDaE1OiveRnCtH7ZXkqGI1nSxDRMIfM9VKdRsG5bSP3HBs9GL5XVYrh5cjFNzjvF9y5WRVGKQQLHDYfGvwsBPcJNdht4M/4B957U+geHFwBmJHEaRgheeCVuwLrbrZqVXRoJyoqbqFtSkoQLpPXKIInKrKLkViIGgL6Q547mh7txOaMp1Li9XEiIWVaqab3kard8eNrVxC7a0yeZ43MoYE56URrCw3joLkANs5sKIUrhhbApST7tRYa7hfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grne3haEggHY8YiKQNbwWwa7ApZZUNfwvw12D5uhMGE=;
 b=4Jti0fxkqxSZJ8Ie8pvs7zbXXn4+wICLXHNK9qF/F6GMa0saGJ9YhcE2C93DfbiXPj1kMwc6k2AXPfLjWV8msjUOqZahC1PKlMa/oQ7AnzNoKIL5j2mtZu5TUyXDc9L/6LR6HD42GiC8aWqLY95aLUo2xGWvrPiqtOlFtF/ntcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 16:53:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 16:53:16 +0000
Message-ID: <1e8b9ea3-bf0f-0d14-b206-359e918f93f6@amd.com>
Date: Fri, 25 Nov 2022 11:53:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-17-jonathan.kim@amd.com>
 <31f90d88-1db5-756f-02f7-456f721e9899@amd.com>
 <CY8PR12MB7435CEDE4322CDF570C3C2E8850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
 <33720c70-4d99-1c6e-0ab9-8b48b6e8238e@amd.com>
 <CY8PR12MB74357B1A5A6BBC13E99045A7850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CY8PR12MB74357B1A5A6BBC13E99045A7850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:610:4f::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: b1496d33-2525-48f9-731f-08dacf058c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZ14QvksN0OXmIF5c0ck9wjDWARHcNA+ei9YgOtj/dIXf2in+BlI+uPHDkTv6D5Z2GREID0eoVFT6avwN8wwjO7kRbTn9/EBX357E4+oX9Dh7LRJh/u5B92HWOsaKU4YKsNJR25HM2v/P0XAVy/jxCqmZaVXqSlfpZbOu0nbpt1LSaEzWcZbvxzymsMXpjRDoT80gBniX/SEWPCuTqjG1s21vncbYi3SUKeN0FjySIhZyXbEcYTCu9ESzvJWhhhkHuqzjagbcpJ3chWa/GLciCIcuY5zmTOGFN6XNrDN7zJxYyP4hmVHary36nbhDpS2PfUuEK0B7xIJ/Pyuzdpdf66pjsdKCntkTsbF95QaOIMJ1X7zL1oKfVYlKrI2B0E1mfpSenV/517vsxVNmViLx+V8EBwRCnNphnFctM+8EXToVrh/XeNigzo3ijpLi1MTEhjHDCRnfeLrtsVnbPXOFiWkKjv9rheXSEmIVQ6yhObl9W1mErVVE4YaWM9/D+kHV/70In+/6MhydEKoLdxx666hfDWqebNOAP5pl79yV3MzOEXy/bYdr4kArUE88xHAAV1T3xIT1RaU0sgs2/dyb3LujsiODJUxG0JOon0J+BDpzMvevQ5u394ztazAbIxd243skICMio1+7RA+6TW+NVb7YJWj7HMXVlbLEIZW9ev3QAn/PwT3tQagUdZESpYOIXawyTu5kTZl0RDJLLc1DUAbiyTxTiBItR5nqTOYiCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(38100700002)(83380400001)(4001150100001)(2906002)(31696002)(36756003)(86362001)(186003)(44832011)(8936002)(5660300002)(6512007)(26005)(2616005)(66556008)(66476007)(478600001)(110136005)(31686004)(66946007)(41300700001)(316002)(36916002)(6486002)(8676002)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1aOGlxVTM2bXR5SEhGOFhaSFNnclNmYTk4TVZ6di9INm14ZThaNGEvYzZ1?=
 =?utf-8?B?K1ZJYUlnQWhvek5Ca3pZWHgxVTZ4TG1uNktzZ1NBbHFrSGx3K0FqUHBPdzdk?=
 =?utf-8?B?eHgvYnpsQUhlaTdtYmJpK1lXTkdSUTg2V2I1UUpySmxxUy9SajVWOGQxWlZp?=
 =?utf-8?B?cUl5Z2xLQ0g5eE0xK0t2Q1JxVGRhbmRweWU2UzdLV3hTbUJ5S2lzRmpkMG5j?=
 =?utf-8?B?a2dhOFB4YmJWSlJuZTY0bkdoeEhUOFo2YTRobzZNUjNnVU9DbHhaRXBncUYv?=
 =?utf-8?B?bEJlUXBnMlZ1dlBVWXVhdkZaVXIxanJHZkxNanpDaUd0enZONHZGV3h1OHRL?=
 =?utf-8?B?ZVd4czVDYlhtUmtkK2ttL083cjF6amUzbE0xZERuRjJQT3BGN1ZBcUhFYTQ2?=
 =?utf-8?B?MXdjSTYvSjdnS0d1OGZkOHc1VnhiQmxyWTl4YlJscHBEQVdoZllLSmhqRmJV?=
 =?utf-8?B?T2lVNXk3RFRBSGl3VWNCRXlWSkY4MzhzeE8yUjM3bGlkMDFuVWRhdzhQdXBi?=
 =?utf-8?B?azRYSi9XbU5xaUpqM0RWZ3Z5WU9uWG9DbU5JSHdUZTZVYXJFOGlGR2pCeFNF?=
 =?utf-8?B?WTBrVjN2dU9oK3U3RjUrV2RWcDJQRTV6NlpwQjdGaUhEcWhrTjc1MGhRdVJH?=
 =?utf-8?B?T2hmVW5nN3hBdUkxcFpEQTFrRExxRE10L25vdnhsOUFCL2xDMDFrZFk3TzAy?=
 =?utf-8?B?c2VFT09OZWllMUJRbXJ0eXZ2anlJenpNNmtyYVBVNHZlZko1S094eFBabFVJ?=
 =?utf-8?B?b01PbG1wRDc0dGtQUVQ2QllhemRGRUVQQjVBemhaMXZBTFRDbGNqN0VwOXhh?=
 =?utf-8?B?djhnVUJSZlVJcHdOUzBLZGNHSFF6ZndEaFlLNFhpZFoxVWlKVzVmQzNMVGYr?=
 =?utf-8?B?Yi9DMEthOXByU21kckVYRFBKa3FYN3QyN3hoelNiRzVqd3p5NHFITkZhV0Y3?=
 =?utf-8?B?SHFXa0RHY1dWVlI3bkFFWW8vUTlHY3BKcW5IUzR2SFp3VVFQMno5TUtqZGpp?=
 =?utf-8?B?SU00VGw0ZlAxV0E1QzJoeXkxU0xrVzhBK083a2FNT3MwdGQvR1pzWEpVU0U0?=
 =?utf-8?B?OWFEUmNUamZEMzY1VE1hSklBM29RcEtJcU1oQnBQOXJvM1pVb2QvU1BMUkxl?=
 =?utf-8?B?dGhOS09NOGpjWVdkV3d0QzQ1L2JjSG9ST2xjeEZha3JLRlJEaXVRZ2FaaHhZ?=
 =?utf-8?B?TElwTDUrMHJsS3ZuamxJZU1rNDM1QU9JU3JRbWRhaGowMEhQRStWeDFsR3J3?=
 =?utf-8?B?VjRyUG4zWCtSWkhmUXJFcFlKdTcyV296WXdoTGF1TWluMkI3K2IyaURNb25Y?=
 =?utf-8?B?NVFhakFCT2VqVXNaVGF3Z2VKRWRETXNRTEJBK0kvb0JkbVZ2M01uTTdvNW5F?=
 =?utf-8?B?dERQajAvdW9qVGQyeHBsY2hUZnBqdlhPTlB4VU84KzQ5d0dhZlVjbVV6cUR0?=
 =?utf-8?B?TEE2V3FqTi9SS0FVQUN2RHJheEJwanE4QVBTK0phbWRQS1BTZjhDNEVKdlcx?=
 =?utf-8?B?UnZwQ3l5TlBnYmxaenNjdXRNYlFQS3BNQWxLaVRMMGxjTEFmYURuQnhNOWVC?=
 =?utf-8?B?TGUxRm5NOFEyNGRsNEhJTUc2Zzl5WWQ0SjROU25Qek5YaVIrNi9PaG42TWVy?=
 =?utf-8?B?cVI1amRDSy9QNHhBa3JHT3dvVmdxQ2xNTjkxSG1KV1gwQTJkU1lqQWtteGt5?=
 =?utf-8?B?VWs1NmIrenZNcUY1REJIK0xzdk1obkUzVUJ2NmNZLzhHVG1ORmdScm8rZUdr?=
 =?utf-8?B?Umt1NUp2TTlnVXd2akZDWTFNb3RJM0hKTW9HK2JIWUZXNkhzeEM3ejM4MjlO?=
 =?utf-8?B?aVJGZWEvdmhhMCswTjlCUkI2N29JbWNuWnJjcVhrRzQvWjRkdjlRdkxkL21M?=
 =?utf-8?B?UzNLejdYd1hzRkV2bU1OZm9IZURrbTJLZGFFUzE4azkvTFJ3UjdiZ3hxUE5O?=
 =?utf-8?B?cnpXTGYwbGFFZ2l1V0NJMzF1R1BJVG1tMHV3cVRRbDZ4VGxFK2phTC84MFlO?=
 =?utf-8?B?c1ZyeHIxUjhYZ2UyRlh6UWpFbWlPRTdvNUxZS2k3ck0vMkFMUzZtZ1NsVS9X?=
 =?utf-8?B?OGw0R29WdlFEZ0hZWndwV2FXdGIrUVBDOXZJb0ZsM0tnY2ZnTGJLL2lVRVhX?=
 =?utf-8?Q?M5NNGgJOZ6DF9oFYNEieB/YdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1496d33-2525-48f9-731f-08dacf058c70
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 16:53:16.6031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JMVZ1wQXUt/MirEStr4c7rQLrjdvSB30p9qHe8mbwM3WNMxpo2cCe7TEe0aziQhSjHLM2Fhprrv3COyOkifhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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


On 2022-11-24 15:27, Kim, Jonathan wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: November 24, 2022 11:24 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to
>> TMA
>>
>>
>> Am 2022-11-24 um 09:51 schrieb Kim, Jonathan:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: November 22, 2022 7:45 PM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to
>>>> TMA
>>>>
>>>>
>>>> On 2022-10-31 12:23, Jonathan Kim wrote:
>>>>> From: Jay Cornwall <jay.cornwall@amd.com>
>>>>>
>>>>> Trap handler behavior will differ when a debugger is attached.
>>>>>
>>>>> Make the debug trap flag available in the trap handler TMA.
>>>>> Update it when the debug trap ioctl is invoked.
>>>>>
>>>>> v3: Rebase for upstream
>>>>>
>>>>> v2:
>>>>> Add missing debug flag setup on APUs
>>>>>
>>>>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  4 ++++
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16
>> ++++++++++++++++
>>>>>     3 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>>> index ae6e701a2656..d4f87f2adada 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>>> @@ -193,6 +193,8 @@ void kfd_dbg_trap_deactivate(struct
>> kfd_process
>>>> *target, bool unwind, int unwind
>>>>>               if (unwind && count == unwind_count)
>>>>>                       break;
>>>>>
>>>>> +           kfd_process_set_trap_debug_flag(&pdd->qpd, false);
>>>>> +
>>>>>               /* GFX off is already disabled by debug activate if not RLC
>>>> restore supported. */
>>>>>               if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>>>>>                       amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>>>>> @@ -278,6 +280,8 @@ int kfd_dbg_trap_activate(struct kfd_process
>>>> *target)
>>>>>               if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>>>>>                       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>>>>>
>>>>> +           kfd_process_set_trap_debug_flag(&pdd->qpd, true);
>>>>> +
>>>>>               r = debug_refresh_runlist(pdd->dev->dqm);
>>>>>               if (r) {
>>>>>                       target->runtime_info.runtime_state =
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 9690a2adb9ed..82b28588ab72 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -1101,6 +1101,8 @@ int kfd_init_apertures(struct kfd_process
>>>> *process);
>>>>>     void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>>>>>                                 uint64_t tba_addr,
>>>>>                                 uint64_t tma_addr);
>>>>> +void kfd_process_set_trap_debug_flag(struct qcm_process_device
>>>> *qpd,
>>>>> +                                bool enabled);
>>>>>
>>>>>     /* CWSR initialization */
>>>>>     int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file
>>>> *filep);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 59c4c38833b6..d62e0c62df76 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -1252,6 +1252,8 @@ int kfd_process_init_cwsr_apu(struct
>>>> kfd_process *p, struct file *filep)
>>>>>               memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev-
>>>>> cwsr_isa_size);
>>>>>
>>>>> +           kfd_process_set_trap_debug_flag(qpd, p-
>>>>> debug_trap_enabled);
>>>>> +
>>>>>               qpd->tma_addr = qpd->tba_addr +
>>>> KFD_CWSR_TMA_OFFSET;
>>>>>               pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for
>>>> pqm.\n",
>>>>>                       qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
>>>>> @@ -1288,6 +1290,9 @@ static int
>>>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>>>>       memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
>>>>>
>>>>> +   kfd_process_set_trap_debug_flag(&pdd->qpd,
>>>>> +                                   pdd->process-
>>>>> debug_trap_enabled);
>>>>> +
>>>>>       qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
>>>>>       pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
>>>>>                qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
>>>>> @@ -1374,6 +1379,17 @@ bool kfd_process_xnack_mode(struct
>>>> kfd_process *p, bool supported)
>>>>>       return true;
>>>>>     }
>>>>>
>>>>> +void kfd_process_set_trap_debug_flag(struct qcm_process_device
>>>> *qpd,
>>>>> +                                bool enabled)
>>>>> +{
>>>>> +   /* If TMA doesn't exist then flag will be set during allocation. */
>>>> I would expect a change to the TMA allocation function, but that isn't
>>>> in this patch?
>>> The TMA is allocated under kfd_process_init_cwsr_* and CWSR enabled is
>> a pre-condition for the 1st level trap handler loading.
>>> The lack of context in the patch for those functions may be hiding that fact.
>>> Is the placement of this comment misleading?  Maybe it should go in
>> kfd_dbg_trap_activate when kfd_process_set_trap_debug_flag is called?
>>> Or should it just be removed since the combined calls within initialization of
>> CWSR + debug enable seem complete for enablement?
>>
>> I think the comment is fine. I was sort of expecting to see the
>> corresponding change in the TMA allocation in the same patch. So my
>> question is just lack of context. If that change in the TMA allocation
>> got squashed into another patch in the series, maybe it would make sense
>> to move it into this patch instead.
> The change to set flag on TMA allocation is done in this patch as kfd_process_set_trap_debug_flag is now called in kfd_process_init_cwsr_*.
> To my knowledge, CWSR init and trap handler memory allocation should be atomic and that has been upstreamed for a while.
>
> Did you mean the user trap handler assignment?  That should be independent from flagging.

OK, now I see where my confusion came from. I missed that ths same 
function was called from different places to enable the debug flag. The 
wording of the comment implied that this function is not used during TMA 
allocation and made me look for something accessing tma[2] directly 
somewhere else. The comment also talks only about setting the flag, 
while this function is also used to reset the flag. I think this comment 
would make more sense in kfd_dbg_trap_activate, where the context is 
"setting the flag when debugging is activated, potentially before the 
TMA is allocated".

Thanks,
   Felix


>
> Thanks,
>
> Jon
>
>
>> Regards,
>>     Felix
>>
>>
>>> Thanks,
>>>
>>> Jon
>>>
>>>> Regards,
>>>>      Felix
>>>>
>>>>> +   if (qpd->cwsr_kaddr) {
>>>>> +           uint64_t *tma =
>>>>> +                   (uint64_t *)(qpd->cwsr_kaddr +
>>>> KFD_CWSR_TMA_OFFSET);
>>>>> +           tma[2] = enabled;
>>>>> +   }
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * On return the kfd_process is fully operational and will be freed when
>>>> the
>>>>>      * mm is released
