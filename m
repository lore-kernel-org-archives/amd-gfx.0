Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D58C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 17:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C36C10FE7E;
	Fri, 20 May 2022 17:30:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8204610FE7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 17:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPo1pQXMFv9cEPCc4zW960Z+ogXQbw1YgusuZJUfxMBsrIMvjmL0598Dg5LVCpQqqvZS3Z+jA5gl+T41xTIfUaSataW3+SlQBfyLqp71DGoGmhBaVm0LS204oVHgWeQn72CbCNKfCud8tdh40UAJ3QYDDvbQzakS1UzY6H1tioHuUFtdjY4uIaUhmaPS6VlYz6Z+1qBNo5PyPRUKCPonxHvcqceqPVgNsgkVk3BCUz9BAGeTXIil70jkBwhvc+5JnN8j8neAD4knVKbifsUQJYdfam+RaBvRJqrrs276vUjwlF51JnjxEYtAKM3jWXMD9txU1+P0sqDOyjmQWd63QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLCuyXCexoZksQcByUGyp/mqnzYUJYI4gdVHhaJ/+VQ=;
 b=U3DB21nmsNHSrR6aTVFYgtNlTuslk1vZ5ZrCDn0mopu4Q5fTptL0oGyWkLKFtLYalnR/I+Ec51BFI82rRiZku1Ipo70A/UBequ1+c83VTx2jKoop439QcDobopkqYtSk+6C7Mcbx+j2mR8O0SsfYERFFRGxxSsVcblVA337ddDCOCw3HBY+KqI43dhFhQmJxom1wIdiQccrwqsZBwfukpRSNzHvZBIZpDvLP0xF2zSgyOxckZiVeX8xabuXxlPjJGGYcA/PeLLlwo+8QiFDk73BOw4AgA284aupw7q2RHyFeKyC+TmJltzALeCpY82KvAZofF63Iik0LS3Av/dIYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLCuyXCexoZksQcByUGyp/mqnzYUJYI4gdVHhaJ/+VQ=;
 b=0SU8r95YXZMOas0v5h+gHWXpPYuWt3k5tb/MAlDNCbJolbW+VhYXpybVZ+up02c3PiXv8YpFTrRXjucEp2TJenCjojsLw4NJnJfGJEWBW0NxyqrSkUvXSDrJhK6PLfazv0imftHu8P5uNuUX+6FO7QBQcJYiA4Y5AW98weGsnEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by MN2PR12MB3389.namprd12.prod.outlook.com (2603:10b6:208:ca::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 17:30:07 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::2c05:6d91:e76a:6e24]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::2c05:6d91:e76a:6e24%4]) with mapi id 15.20.5250.019; Fri, 20 May 2022
 17:30:07 +0000
Message-ID: <ff8f4a51-ab95-56a9-26ff-d93b1f3e5e20@amd.com>
Date: Fri, 20 May 2022 12:30:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, philip yang <yangp@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
 <20220519162153.6268-2-alex.sierra@amd.com>
 <9ec46333-ec80-f258-febc-7c7110cecf56@amd.com>
 <d9242fbb-fb5e-e03a-fc04-4732c310c947@amd.com>
 <0838194e-91d8-de41-aa7e-87531498a953@amd.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
In-Reply-To: <0838194e-91d8-de41-aa7e-87531498a953@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To SN6PR12MB2717.namprd12.prod.outlook.com
 (2603:10b6:805:68::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f1aaac3-1e08-43fb-4aee-08da3a8661d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3389:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3389AE228312FF20DF0B669CFDD39@MN2PR12MB3389.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKwFXUi4nE45TbIsO4isrVXhmkEjdTrU4OqGJPkij5+4XJSZqnZ+IadSY9c9+nUMKH8CaredCsT4xFeBbZDEQb0S1YbgM7DSV4v+bS4XLAisGNmbJTn7EfveglEQlDePpjM3NdCqArQcR2Yd71kwP2hOUvr03lzdpCF+Q6rV+0XRDXHKOZjKm00UUR2MO66Vtuzfyh+h4F/Fq0GUv8S/0JErCii2mCMppluXKnNszBy8t61qdKqGngrQCzhSgd65Ef2cymp0AnV7X9PjgcYkg/Qokey+itIVMOqmGBYBBA1pFiM732kx7zQtc5f9j7QKn3P3gH1pOHYK9sinhihao+Q49OE0klfFcoaj7xSdgbd3ukQ46ombmmIq4EVKZICZwM5dYFvVjbUbRNp/OIeDBR0W2dzwuk0ZJNYAZ/HWagHnPVZgGL4OaUqOkUEbLu2yNaoQayR8dc4BpsbAVQ1WPCIB1k1VsZolMeVvboobkYgAWY5ENAzyxx5mglLbA57YkqnM9eevOa63H1JvOwICALLS8Vfocytb6arAnx84WcSDwpNB4WjG23t1p0ApZuuRjQd/uFJFkuyAuhYFa61MQNvt8rgcv7rUk8/goPmKYMHtSmZ5phRXcoL4iasQsxP90cRkSl9RfYeShMWBIvAhIaym1Zt2LLJ2/WSURXS+p4FSGpMi8Tgqufesp0LID75xc4gEVd1prWJb6XIcWaxF+ff9dL/uL7n8t8xuE+oaQ74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2717.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6666004)(53546011)(38100700002)(31696002)(8936002)(2906002)(5660300002)(30864003)(83380400001)(66556008)(66476007)(66946007)(8676002)(86362001)(36756003)(26005)(6512007)(110136005)(2616005)(31686004)(186003)(6486002)(508600001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpJNS9HVGIxeDlIelNJUlRSa3VVazNjVmo5ZHEzZ0lvc2lWclRLKzc3cHpI?=
 =?utf-8?B?Rmd2UlFvbzN0UlQwRWNicFUvMmhZN1hYWUJ0eXMyOGtMT01OY2VTZWw1aS85?=
 =?utf-8?B?a0JySlFKakdBQ2pUcGlPb1ZBbS84ZWNHRWxvZGkvK2h4U3QzRmQzN1NRQnVE?=
 =?utf-8?B?WDY3Nk5lWGFDTlZvSWk3QjN1emdDQU4vYWdEUGo5ekgwL3ZkY3FpYThWdHNz?=
 =?utf-8?B?RThEWWQ4Y2JJQXhRcWhKZGN6MVdMd0pWbHM4UWdLcHRsTDRtTE5rdmhWTWlv?=
 =?utf-8?B?K3JCWmpFU2JudDJPVWtQOExoTVczWkszaDZsTmZwSitGWGh6c21ndmcyeGxP?=
 =?utf-8?B?K0lxK2RoU0tOVWM4MGJDZ3VabXV0OEVGNE5BQWR4MVh0QWxlWkZrcHZuY3R1?=
 =?utf-8?B?djBOUm9ZMzFXTmNMaHNwVmRMMWhJY05yZytFMzZ1UXV5bFR5RU96ZDIycjds?=
 =?utf-8?B?YVA3dmdvSGIxRGNoa0NPS1JaU0FRS3Q4RXNSTTVFTzFmVTQvek5TSUFLT1c1?=
 =?utf-8?B?MmlvUThmbzR2Z3JaemxjdnRSOTVINEFWbFVqTU8rWXZSSk1QUE9zSDBWdVA4?=
 =?utf-8?B?ZlRRdG43bnA0Wjludkg5MDBLRFZEemhUR002cW9sc1hZZ0NyMDRHQTlObnYr?=
 =?utf-8?B?U2g2MXpUV1FIRmlZNCtGU2MzT3NhWlNyTnJveDg0L3lLU3NUYklWRERYYjZ6?=
 =?utf-8?B?VWN6enpkbEFJS0pQNGlVNEEyUGxuK0dPMDJBRjltQkdXeFNiM2VGaDVJSDZy?=
 =?utf-8?B?S3BVRC9qQnVUb21lSVQxWnFiS3l0dDNBc20xQ3NQUUFWV3ozVmxjN0VIQm5a?=
 =?utf-8?B?djNpTnlqRWRzUkcwWHBIaDFLZWRhY0lxVEdxUlZGVUZ3a01vVFB1TlY3REtS?=
 =?utf-8?B?TnFYck1TVEltUmMrd2VCVUVwOEV6UldRQys4VDFVQ0FlZlpPTG4yUHRsSnlU?=
 =?utf-8?B?RWpUb1hQQ3pkZ3ZWVEZoaGpoZTVPRDA3VzM1QU9LTjN3OS81cEE1YkpQSUpm?=
 =?utf-8?B?aDdFVmdaTGpnVEpNZkFnNER2QXp1MDFtYUZmaFd2VkMzRFc3VUZmZEVLcnAw?=
 =?utf-8?B?N21tU0cxYm9XOG1ZT2hETHRsSkxaRnVWa28vdzNOM2RiWFdFVGdPWFIvQTB5?=
 =?utf-8?B?SUdsMDU1RE44dGVybFpLSkdqTjhlUkRxemhiVTF4bFRzWUtMTTFOc0xMbUJx?=
 =?utf-8?B?SkpHS2VyNFFQVmFGRVgyOVEvWE5tZUkxZzFZdWlnNzlOVFZ6SXN5ZndyaGQw?=
 =?utf-8?B?dUVlZDZqanRKVTJybm4yZHk4dVB2ZW5IcU1hV1RiejRGcnY0ZXFmU3hTMWEz?=
 =?utf-8?B?QmpJeWhnM2ZtaWpRMlFIQVdhNDV1WmUrRGlyKzZIWjlwK2lsK3F0bllhMmVm?=
 =?utf-8?B?Rk5Nczc1NFdJckhzK2lsTk8wcWlHbGhTcjNJRmxITzZHdVVnTFJkZjJzQmYz?=
 =?utf-8?B?QWV0cW1nSHFNa04vNjdXSG1sRjJNVllGWG9OakRYd3FPc0NuMk1SdUYzZDNy?=
 =?utf-8?B?eC90RVhQWkVMcnVNOFFXUkRhMllDakdPNlVWa2pEOHBJUXZDaUlNbTIvWnRw?=
 =?utf-8?B?eGVqVWhweWlyMk8wTXdlUGIvRjltQm9DdHVMMkdaRzlrR21TQkk4UUdDTmJ0?=
 =?utf-8?B?bllvbHZSVTcyNTY2STFRU2hMWnNra0ZnYlhpRzc1cmtQU2htQXpuQ0JSUjRD?=
 =?utf-8?B?WGVZRXZZUnBpcHpaTkJMd3VNRXZBbUl2eGhiM2FBcCtrZm9PdmQ5RUxmOEtR?=
 =?utf-8?B?QllrbkJLY1hLNThROUlzRmNzeElHak9xdkRGeHZXR3BVODQ0TW1GWktRWWh4?=
 =?utf-8?B?bkxmdnc3bUxzYktmQjBTS0Q2K1dORHc4YytnMTNyZ20rY1poZzFTSlhTcW5V?=
 =?utf-8?B?Ty9HRFhLM3Y3T20vb2FRYlllU0dmOSs3Q1QrWmF5VnhvNFlaRWQ2aGNvQ3M4?=
 =?utf-8?B?eU9ocXhrS2NWYkxPRFRMUFdFQzUvTExNR2RsZ2o5ZHJodmRpV1ZhN1hTY296?=
 =?utf-8?B?WkVBSmxnT1JwVzJaRU9hLzRGU2lqZXZUMkd0SDczVG42b0xsbStJZW1jOW5K?=
 =?utf-8?B?ZU4wdjVjUUE0WWhTN21Ybm9GRi90bjVZdGpuaTFIc0libjNOYmZPekdVc3BV?=
 =?utf-8?B?ZkVrYWRGSTlVcjBaK2x5dVJnZ1MzSTRnejk5aTFmRktCTU9US0JRSzlUM0Nh?=
 =?utf-8?B?bTB1ZjZ1ZVhERitoZUw1dEc1UmdNTzhtZDNjOHBlOUd0T3RSZEQvVzRFYkJw?=
 =?utf-8?B?MTRPcjVIUmljeDhGTVFYeEIweEpuQkJYMzBCREJ0elBYUkl2QS9VMFJYVXp5?=
 =?utf-8?B?NnFMb2RMS3FmYXZ2ZnZDWDY2SnFXTlRZOEl0QW5CZ0Jacm1VbE94Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1aaac3-1e08-43fb-4aee-08da3a8661d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 17:30:07.2536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQgDbR5awa/UQQlsAMnFqZh+ePTTiYiO7THjJAqkwzAACnht8saU7lgXhg0DoXm5Q85OXa9iTydPkUcKcznxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3389
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


On 5/20/2022 10:12 AM, Felix Kuehling wrote:
>
> Am 2022-05-20 um 08:45 schrieb philip yang:
>>
>>
>> On 2022-05-19 19:08, Felix Kuehling wrote:
>>> Am 2022-05-19 um 12:21 schrieb Alex Sierra:
>>>> [WHY]
>>>> Unified memory with xnack off should be tracked, as userptr mappings
>>>> and legacy allocations do. To avoid oversuscribe system memory when
>>>> xnack off.
>>>> [How]
>>>> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
>>>> API and call them on every prange creation and free.
>>>>
>>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 
>>>> ++++++++++++++-----
>>>>   3 files changed, 43 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index f8b9f27adcf5..f55f34af6480 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct 
>>>> amdgpu_device *adev, struct kgd_mem *
>>>>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>>>   int amdgpu_amdkfd_criu_resume(void *p);
>>>>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct 
>>>> amdgpu_device *adev);
>>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>> +        uint64_t size, u32 alloc_flag);
>>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>> +        uint64_t size, u32 alloc_flag);
>>>>     #if IS_ENABLED(CONFIG_HSA_AMD)
>>>>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 966714dd764b..615e2b34fe12 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t 
>>>> size)
>>>>    *
>>>>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>>>>    */
>>>> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device 
>>>> *adev,
>>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>           uint64_t size, u32 alloc_flag)
>>>>   {
>>>>       uint64_t reserved_for_pt =
>>>> @@ -157,8 +157,8 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>            kfd_mem_limit.max_system_mem_limit && 
>>>> !no_system_mem_limit) ||
>>>>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>>>>            kfd_mem_limit.max_ttm_mem_limit) ||
>>>> -        (adev->kfd.vram_used + vram_needed >
>>>> -         adev->gmc.real_vram_size - reserved_for_pt)) {
>>>> +        (adev && (adev->kfd.vram_used + vram_needed >
>>>> +         adev->gmc.real_vram_size - reserved_for_pt))) {
>>>>           ret = -ENOMEM;
>>>>           goto release;
>>>>       }
>>>> @@ -166,7 +166,8 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>       /* Update memory accounting by decreasing available system
>>>>        * memory, TTM memory and GPU memory as computed above
>>>>        */
>>>> -    adev->kfd.vram_used += vram_needed;
>>>> +    if (adev)
>>>> +        adev->kfd.vram_used += vram_needed;
>>>
>>> Add a WARN_ONCE(vram_needed && !adev).
>>>
>>>
>>>>       kfd_mem_limit.system_mem_used += system_mem_needed;
>>>>       kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>>>>   @@ -175,7 +176,7 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>       return ret;
>>>>   }
>>>>   -static void unreserve_mem_limit(struct amdgpu_device *adev,
>>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>>           uint64_t size, u32 alloc_flag)
>>>>   {
>>>>       spin_lock(&kfd_mem_limit.mem_limit_lock);
>>>> @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct 
>>>> amdgpu_device *adev,
>>>>           kfd_mem_limit.system_mem_used -= size;
>>>>           kfd_mem_limit.ttm_mem_used -= size;
>>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>> -        adev->kfd.vram_used -= size;
>>>> +        if (adev)
>>>
>>> Add a WARN_ONCE(!adev) here.
>>>
>>>
>>>> +            adev->kfd.vram_used -= size;
>>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>>>           kfd_mem_limit.system_mem_used -= size;
>>>>       } else if (!(alloc_flag &
>>>> @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct 
>>>> amdgpu_device *adev,
>>>>           pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>>>           goto release;
>>>>       }
>>>> -
>>>> -    WARN_ONCE(adev->kfd.vram_used < 0,
>>>> -          "KFD VRAM memory accounting unbalanced");
>>>> +    if (adev)
>>>> +        WARN_ONCE(adev->kfd.vram_used < 0,
>>>> +            "KFD VRAM memory accounting unbalanced");
>>>
>>> This could be simplified to WARN_ONCE(adev && adev->kfd.vram_used < 
>>> 0, ...).
>>>
>>>
>>>> WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>>>>             "KFD TTM memory accounting unbalanced");
>>>>       WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>>>> @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct 
>>>> amdgpu_bo *bo)
>>>>       u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>>       u64 size = amdgpu_bo_size(bo);
>>>>   -    unreserve_mem_limit(adev, size, alloc_flags);
>>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>>>>         kfree(bo->kfd_bo);
>>>>   }
>>>> @@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>>       /* Don't unreserve system mem limit twice */
>>>>       goto err_reserve_limit;
>>>>   err_bo_create:
>>>> -    unreserve_mem_limit(adev, size, flags);
>>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>>>   err_reserve_limit:
>>>>       mutex_destroy(&(*mem)->lock);
>>>>       if (gobj)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 835b5187f0b8..1380c2fee0dc 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct 
>>>> svm_range *prange)
>>>>     static void svm_range_free(struct svm_range *prange)
>>>>   {
>>>> +    uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>>>> +    struct kfd_process *p;
>>>> +
>>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", 
>>>> prange->svms, prange,
>>>>            prange->start, prange->last);
>>>>         svm_range_vram_node_free(prange);
>>>>       svm_range_free_dma_mappings(prange);
>>>> +
>>>> +    p = container_of(prange->svms, struct kfd_process, svms);
>>>
>>> You could initialize p in the variable declaration above.
>>>
>>>
>>>> +    if (!p->xnack_enabled) {
>>>> +        pr_debug("unreserve mem limit: %lld\n", size);
>>>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>>> +                    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>>> +    }
>>>>       mutex_destroy(&prange->lock);
>>>>       mutex_destroy(&prange->migrate_mutex);
>>>>       kfree(prange);
>>>> @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t 
>>>> *location, int32_t *prefetch_loc,
>>>>     static struct
>>>>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t 
>>>> start,
>>>> -             uint64_t last)
>>>> +             uint64_t last, bool is_new_alloc)
>>>>   {
>>>>       uint64_t size = last - start + 1;
>>>>       struct svm_range *prange;
>>>> @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list 
>>>> *svms, uint64_t start,
>>>>       prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>>>>       if (!prange)
>>>>           return NULL;
>>>> +
>>>> +    p = container_of(svms, struct kfd_process, svms);
>>>> +    if (!p->xnack_enabled && is_new_alloc &&
>>>> +        amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
>>>> +        pr_info("SVM mapping failed, exceeds resident system 
>>>> memory limit\n");
>>>> +        kfree(prange);
>>>> +        return NULL;
>>>> +    }
>>>>       prange->npages = size;
>>>>       prange->svms = svms;
>>>>       prange->start = start;
>>>> @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list 
>>>> *svms, uint64_t start,
>>>>       mutex_init(&prange->migrate_mutex);
>>>>       mutex_init(&prange->lock);
>>>>   -    p = container_of(svms, struct kfd_process, svms);
>>>>       if (p->xnack_enabled)
>>>>           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>>>                   MAX_GPU_INSTANCE);
>>>> @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, 
>>>> uint64_t start, uint64_t last,
>>>>         svms = prange->svms;
>>>>       if (old_start == start)
>>>> -        *new = svm_range_new(svms, last + 1, old_last);
>>>> +        *new = svm_range_new(svms, last + 1, old_last, false);
>>>>       else
>>>> -        *new = svm_range_new(svms, old_start, start - 1);
>>>> +        *new = svm_range_new(svms, old_start, start - 1, false);
>>>>       if (!*new)
>>>>           return -ENOMEM;
>>>>   @@ -1825,7 +1843,7 @@ static struct svm_range 
>>>> *svm_range_clone(struct svm_range *old)
>>>>   {
>>>>       struct svm_range *new;
>>>>   -    new = svm_range_new(old->svms, old->start, old->last);
>>>> +    new = svm_range_new(old->svms, old->start, old->last, false);
>>>
>>> This won't work as intended. When a range gets cloned, one of the 
>>> clones will be freed later. So when freeing that clone, you also 
>>> need to skip unreserving its space, because the other clone is still 
>>> holding it.
>>
>> Thanks Felix for catching this, svm_range_free should skip 
>> unreserving the cloned ranges from remove_list, otherwise we don't 
>> account overlapped head or tail range size now.
>>
> Also, in the error handling case of svm_range_add, we have to skip 
> unreserving the cloned ranges being freed from the insert_list.

Could we just treat the cloned prange as new reserve? Eventually it will 
be removed either by old->remove_list or insert_list in case error 
handling at svm_range_add

Regards,
Alex

>
> Regards,
>   Felix
>
>
>> Regards,
>>
>> Philip
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>       if (!new)
>>>>           return NULL;
>>>>   @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, 
>>>> uint64_t start, uint64_t size,
>>>>             /* insert a new node if needed */
>>>>           if (node->start > start) {
>>>> -            prange = svm_range_new(svms, start, node->start - 1);
>>>> +            prange = svm_range_new(svms, start, node->start - 1, 
>>>> true);
>>>>               if (!prange) {
>>>>                   r = -ENOMEM;
>>>>                   goto out;
>>>> @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>>> start, uint64_t size,
>>>>         /* add a final range at the end if needed */
>>>>       if (start <= last) {
>>>> -        prange = svm_range_new(svms, start, last);
>>>> +        prange = svm_range_new(svms, start, last, true);
>>>>           if (!prange) {
>>>>               r = -ENOMEM;
>>>>               goto out;
>>>> @@ -2585,7 +2603,7 @@ svm_range 
>>>> *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>>>           last = addr;
>>>>       }
>>>>   -    prange = svm_range_new(&p->svms, start, last);
>>>> +    prange = svm_range_new(&p->svms, start, last, true);
>>>>       if (!prange) {
>>>>           pr_debug("Failed to create prange in address [0x%llx]\n", 
>>>> addr);
>>>>           return NULL;
