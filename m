Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD07C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4EB10E1B7;
	Tue, 27 Sep 2022 14:59:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D0B10E1B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpbj+iino/q//nGqw+AD4TPSbeheClA3mdk2ffBXLmX9hHSUl6EY++IpTFiinJfMSUgp+eMJnv48Qyk0b/YDhL3049KIMxd88FX+q/qnnlOSzL0R9IhmG2Gsn6ni4ZpyQwB3CAOukty7+IOJmaFUECBHBSpJBEWAo7LdR3bIkpD6lAHhaswqqv8VlYW3CNlhTT0FYAtwKD8Gwcft0Mioiw2vV8gH4Hid+eXCFxn+XDtgF6rqJH5Kz6fUIJeX4HxChV4nwS1j2INv/0MuPyfMJApQOdABYZ53tFVxYknsTmL5fMwkpUr3zi1f/hdP6JkPsMQ6AZmDMXDvqUSAqdhqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KayQzvIJisZ2kFY0uuz2dnfowkk5pNs0tqghk6LID/k=;
 b=QNjt3HrAuiuGs2SAXJ2SoIJ0iTllrLmeawDvFo5QCZMEGMXNAVUdoFT1jJt/QvoiRjRDWnzg6sFIG82Zy4xJREW0H5oZZTkPxRQACwl8ZD20lLi1J2Xg6vpBqZOftFe9hBMSzMvNSAhMWw8PKb0GrD8OS0mpQ40kbMhRaDlj3R4vMppoy+RY8j+Au3pToISLxamXV/T/f8XLnSAldwaiZjgcxSYtwF8B9aysi5wj4JEN2eP0H7tDCeFYI4ulLTtO9VTLPO49wY9WnUiBrIhpGYMl94Azv5ffv5UMH43sOU5iBrD7HIrCvgBqcJoKtKlz1qGO93PdFDMWy0hrS1d0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KayQzvIJisZ2kFY0uuz2dnfowkk5pNs0tqghk6LID/k=;
 b=VezXgBUCtCE6hYpGHm/aDBJRxIObLLG7Rvs9eX8Vpaa1H1m95jOnoWKSYPcuFo8MDCTfsxk7JkfB6Y8cgrK2vfXJwcPArmX79/BxSrfDT1TZ4n7/8CwVS3QiLdZwa/5hSXP5aY9AHyrb9YDfFs37jOaHySe7w+2LEcGuQnaG6wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 14:59:03 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 14:59:03 +0000
Message-ID: <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
Date: Tue, 27 Sep 2022 16:58:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: e4915eec-c476-46e1-97e1-08daa098d161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkGibCKXzulD2IgJqcF7IPJBYkMKf8gDJQw0b4m2GoKR2ZWPzUVECxFIdi2sZpUj8oCF+JxhodztK+IDyMeDzrS3C1bCE1Ml+8CvGDFAv38se6xUVrkAKRQKuQuqZx7ZzOjECTE3LkDtLLAARLrv0ha80BleKLqsbkz+TX5ggzYNZAp49juuEbhwgKrIvqCoQFfMY1CaajVUaQmf1ySVPSu7ijYjzR4aZrBlXfRHTTe0NxTOcQzvkHNWNqcFU5yOhgRwNkysBgnaS8DzyV2u/71Ea3Yvm0tzfctC0QW4dfO6ckLFAMsmsFnyiJrD966RxC3+UABDEPPsNeakX/I5cDeRNWaYBvdkm4Ad3L1rkIMvm5823bSUE4jmm+k7//wAJANmtM3v0MakNXkc6RlKEtmsEXLkHCXlsRKhcmPx4gSt3i12H2mFSEU7rxe/Dx3o5ovqaZMHkgGDjbqWuKFnuTH7hxv2agpeZ1IFsGrexwXR0qcxRWQtw1ENl/VByL2dZlQbKeHvsI05L6xnXfujo096gMz3nEF1/HBt1Wqch1HCKD1GCbLy7pD6QpgNHbuA8V4cSF0wH0OP0d+DMzIJ0IpmfmdVcp0v3tR+NUMM1KG4K0UAL+6UQPV9/I0jTiFx4oeKhN9JEF/L2qSnQIGkV7TWNebbK8ErL2Md5KbXFDPx01TqDAnHiwuUdnQwtzRC+rdFYSBggPARrqm+n0etpxZiGZNgpWf5hEjxYatM9fTBSkCBkh+qHjufBadiJFeWISjOLRt2SfYhh90Ig82tJJklZ26suhq0PKHc7cwiBQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(6512007)(6666004)(8676002)(26005)(6506007)(2616005)(186003)(5660300002)(8936002)(53546011)(83380400001)(2906002)(6486002)(4326008)(478600001)(66946007)(41300700001)(66556008)(316002)(66476007)(110136005)(31686004)(36756003)(86362001)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lESzBGZXY2OUdhSjBvWW1RUmtmRUZXZllPa0Y4eW5zSlNqWnJmZ0I2bHBi?=
 =?utf-8?B?UlVxQlVJWE9qeEFnVU1hVTFyZjRHVko1R3MveGhwaTBkcEF0Y0ZYMHhpeWdK?=
 =?utf-8?B?WUdkMDNoUFdUZVg5clk2eElRcGxhUlJiOXAwNWJIMTF1N25rVDN6Qm05czRY?=
 =?utf-8?B?ODB6WjFZY2JWSGxJNlpLdGRuak1ORXB0OEdGQW5xb1cya0N0L0Vtd2x5bFR6?=
 =?utf-8?B?N1I4b2ZKeS80NHRxRkNsOHI2YXZyQm5pV2t4cXQ3V0N2b25NcnNUdDZtWGR2?=
 =?utf-8?B?RElpa1pENG1pNWttalV3UXJ6RUpiRlFlWWhSMlJzUkhtZE5kU0tnSUtDbG1w?=
 =?utf-8?B?bWpQOXAvNDFkLzk5OUNoYWljaW1GQmllcUEwZUh1RUJFd3dtNFNjY2w1eENG?=
 =?utf-8?B?UUlVQnhwbzFmQWc0akdDU1M3ODBlY2l4a2Z1SEo3dm5RVEtRRUIxVVRqSTJs?=
 =?utf-8?B?aEN5azA5bjNMLzdWUXJCV1VGYUp4Q3l3UnV1NDhiNnJrOFBBSDlnKzN2WWdK?=
 =?utf-8?B?U0ZFRExpZ1hDWndBRThmVGlXZ29VOUJFRkVHdXAxY0ZmNUhoRDk3cnlDYVhn?=
 =?utf-8?B?VmczQVNRdkp6MTlua0gyRC9wZFJGYTk3NjRpRDhWZlEvTGI5cTNLOWxnTFBN?=
 =?utf-8?B?eEh3WVNFTjFMbEFyU3VHYXV1TmlwZDhMNEdxNGM5djhrQ3FSTCtmOWZjdGJC?=
 =?utf-8?B?NVNLNk5CemVxSVN4RDRZVS9UMjRYNDdrV09hbG0xNmhUQjVXMUlpcjgyc3JK?=
 =?utf-8?B?d3RMeS80OHJZR0I2THJ3TENrd1dRRCtNNGRZa1VGN1QvQWJkZFB6d3JJd1VU?=
 =?utf-8?B?RXVWcnF2SzdlUWJPekQwQjdHNGUxNlo1YndVQjRyMU8rdFpaQ2lHM2p1VUp3?=
 =?utf-8?B?c24vbTdINDFzUUsyYkluTTUwL0M3QzB3bitacjRHRHBZSlhWSkZab3hqdVJN?=
 =?utf-8?B?MDdsNXZhcHdIMjZVSWwvY2VRUG91RmJoR1g2V1FmN1FQL0NpNnBOdFZHRW0y?=
 =?utf-8?B?UFozSFhyTVM3QVEvMUw4RXlCWFVRSDZvUS85MXhod25ocURlSURLdVhyTWpt?=
 =?utf-8?B?N3RtdVFKTlNxdC9zaHhMMUhBOGROeEdFVUtnM3dxVVJFcXEzOXNVeElsM1Bi?=
 =?utf-8?B?TmJENnpVYzFtYnFvcENqd080SlpNRUI4RWtXUk0xVGtMMzJScDJ1Qm55anZJ?=
 =?utf-8?B?TGtQTVFjbjlOTTBlTE5zR0lqeEVaYllpekxjU29DUnRPTXpINmpXZGxCdXFw?=
 =?utf-8?B?UWVBTG9QeVZhcmhsaDhKeVBzV3M2OE9ocU5vMytRUFJ4bEQyOTdFeWtrVUxG?=
 =?utf-8?B?RVJNZy9qaERkY3hBN0JPTEZWWDd3VER2bENiM0hYOWRFOTR6Vmc0dk83Z3dp?=
 =?utf-8?B?TlF6YWxNZXJmYWtJdmw0K01PeXRaUHI3VVExbVp6eGgwOXlOUDlJU3JITVJC?=
 =?utf-8?B?SWcvZjNyaVgyR0dPelk4bCtNVWR1YXF3eHE1OUF3blp0dzN2THdYNGlCMVpJ?=
 =?utf-8?B?WUlPMzlZa3d1a3hnRDhFVEJVaG43UlJzMHJVRVpiNHFaRXBLVDR2TkNqb09s?=
 =?utf-8?B?cnBkenJhWVpCNGg4TWJNTmg1MHFUYWEwVE5ReGdFQ3VtNXVGV3piNEFrK21w?=
 =?utf-8?B?R2JYOHZ6WU8zVDREUUw4Rk9rOGxNR3JQZGxKUW5GOWhEMWtndXN5V0RqK2p5?=
 =?utf-8?B?UWJjdmNsaUJHODZSOERvbVhSMTJqa1VvSzVSTGVHWXZYdStyTitIRXdZQ2Jp?=
 =?utf-8?B?cHB4bUZsV0xXd0dPUHJJR1ZBL1UzOC9PSkZvaStZMVFCaEkxMU9XUTQyK251?=
 =?utf-8?B?eHY4M1hrVmJNRmI0SWZkdHU2RUk0THRFQlJjOVovN2Vxb3h2UnlMNVVKRFM5?=
 =?utf-8?B?MGptYncyaGRQZDNUK1Y3RXl1dU1Bb3gzcTRaUzRoeXNZVGczT25WOFlMSTlj?=
 =?utf-8?B?dEdYWC9yVHJCeEtoUDZXdVE3d0N3R2pUMzlKQWw1RmlyWUVaMDZyT3liOGUw?=
 =?utf-8?B?ZFU5YmcwVU41NktnWGNZSElwd1pubVJNNXgyaGhFeTY0S3V4K1h6Z0V0clVG?=
 =?utf-8?B?UjNUOUptWWF3N0RYUnFxMXBubFBpNkpLQTJWd2p3Z3YwTGZjQ0RLTkpMWnFy?=
 =?utf-8?Q?v0Mt13wYPnF318AUq+54wcC4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4915eec-c476-46e1-97e1-08daa098d161
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:59:03.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SgWePiiDckeeD+eRM1qadqcL7tHN7C3CZczFqOtYdNnOpNKoT6+xpETR1+WXx+kfcoftVO7MT7h7BZNcd4P8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Felix,

Thank for the review comments.

On 9/27/2022 4:48 PM, Felix Kuehling wrote:
> Am 2022-09-27 um 02:12 schrieb Christian König:
>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>> This patch switches the GPU workload mode to/from
>>> compute mode, while submitting compute workload.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>
>> Feel free to add my acked-by, but Felix should probably take a look as 
>> well.
> 
> This look OK purely from a compute perspective. But I'm concerned about 
> the interaction of compute with graphics or multiple graphics contexts 
> submitting work concurrently. They would constantly override or disable 
> each other's workload hints.
> 
> For example, you have an amdgpu_ctx with 
> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD 
> process that also wants the compute profile. Those could be different 
> processes belonging to different users. Say, KFD enables the compute 
> profile first. Then the graphics context submits a job. At the start of 
> the job, the compute profile is enabled. That's a no-op because KFD 
> already enabled the compute profile. When the job finishes, it disables 
> the compute profile for everyone, including KFD. That's unexpected.
> 

In this case, it will not disable the compute profile, as the reference 
counter will not be zero. The reset_profile() will only act if the 
reference counter is 0.

But I would be happy to get any inputs about a policy which can be more 
sustainable and gets better outputs, for example:
- should we not allow a profile change, if a PP mode is already applied 
and keep it Early bird basis ?

For example: Policy A
- Job A sets the profile to compute
- Job B tries to set profile to 3D, but we do not allow it as job A is 
not finished it yet.

Or Policy B: Current one
- Job A sets the profile to compute
- Job B tries to set profile to 3D, and we allow it. Job A also runs in 
PP 3D
- Job B finishes, but does not reset PP as reference count is not zero 
due to compute
- Job  A finishes, profile reset to NONE


Or anything else ?

REgards
Shashank


> Or you have multiple VCN contexts. When context1 finishes a job, it 
> disables the VIDEO profile. But context2 still has a job on the other 
> VCN engine and wants the VIDEO profile to still be enabled.
> 
> Regards,
>    Felix
> 
> 
>>
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 5e53a5293935..1caed319a448 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -34,6 +34,7 @@
>>>   #include "amdgpu_ras.h"
>>>   #include "amdgpu_umc.h"
>>>   #include "amdgpu_reset.h"
>>> +#include "amdgpu_ctx_workload.h"
>>>     /* Total memory size in system memory and all GPU VRAM. Used to
>>>    * estimate worst case amount of memory to reserve for page tables
>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device 
>>> *adev,
>>>     void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>>> bool idle)
>>>   {
>>> -    amdgpu_dpm_switch_power_profile(adev,
>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>> -                    !idle);
>>> +    int ret;
>>> +
>>> +    if (idle)
>>> +        ret = amdgpu_clear_workload_profile(adev, 
>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>> +    else
>>> +        ret = amdgpu_set_workload_profile(adev, 
>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>> +
>>> +    if (ret)
>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to compute 
>>> mode\n",
>>> +             idle ? "reset" : "set");
>>>   }
>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>>
