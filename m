Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD9C10F1B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 17:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F28D10E1C4;
	Tue, 13 Dec 2022 17:58:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1637B10E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 17:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVisfIsm1fhpPWKeGsliX4564shW/Jng0LtIKg79jnGuLz5aqcM71V8GSD8Yjx6vG64ZDNzRF2+aBrrfMN0YBeW4V/Gyb7v0bW+MfjKQ4zAfShAkgm2f23Q2XZFVHWP3tw//CvCYuI9bqNxSqUBX+U1wCdvPV8ORHbnBCb1VUKNG4btcoDpAs6aerD2hIETkhEzGn3XqPIe+s+1pjpRQHOxyEVc6ecH6Bj+SfXzGyMAP+FkjQCzF0HaFpLcRHO34xSj457or+HBHMMBoCMX0kFn21wwHfhOb6alctMAmzynuHc4pJWWEJ0MQq43s/lcWx1qlpX/hTqV2+h1COV40GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fui2eAxzVvCVO2USIUEtMsN4d9J4jqh/exuROrOjQ4U=;
 b=QnK4jawKTlaUOJvJlTW3SJwjke6wBbu6DnlY3CFJMJ1MBde77doFS5pfwV+YGhV2a5x1ihs4TIv/yy+sB1N/KJga+L/WTGI7yTP8GwwLoa4+v3vzb+MQKBeQVHgXLm+7gA6gTYZmraEx1O0HD11xIT86AyQ7ngXx9Qb/Esz7zN6rrJk8hTf7SPajbvRNr+zZJThhwriAoWESaari/CF6UFd/XK8+ur/7B2mqRX5BxkqZJ//AJQ22UfYG1hCn3eccw99eHpmSIFUnpa2jmf/8EmG+vJCwrrxyqENYjKciQlfGyv8YSnVTNzt6c1YYOzEGOyicLKOmzFlcndhiqseWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fui2eAxzVvCVO2USIUEtMsN4d9J4jqh/exuROrOjQ4U=;
 b=yXzzKALMaXiZYeeCnB/DxzzD+OfiuX+db7WTe3fgln7AZ21ONhluDEqsjezVMFpNAILJcAI2UhbR/y4t82PL+iPJn6UfalfxzqP7bxIfMZKDBm/mTrc8dzS/Ew8GgTFh6VcXUovN1V/jx8BBtRkuhTUIenccJUBVI7WU6aLzrk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:58:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:58:25 +0000
Message-ID: <ebac34f8-50be-82eb-85e1-c097d57f9991@amd.com>
Date: Tue, 13 Dec 2022 12:58:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix double release KFD pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221213154910.705-1-Philip.Yang@amd.com>
 <ddd80a3a-b393-41c2-c259-e4f9ec8facb5@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <ddd80a3a-b393-41c2-c259-e4f9ec8facb5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a16c716-6438-459d-4afd-08dadd33a1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IX3mxtDXxD9/CkCqTpFUvRH998WTpTvpqQTlh97Y+uE2mFf5tmETy3JEPyO4yZr8y4B/JUd6xuXVpIW7OedXL+imNke/j0JIj7Bsy/xcD0MJACLzaQ8lxrqtrgAAzZmhu4YlhbFZ/aaABRldHf0xNRkwUew4ut4h6SH39d4N0Ol/FRtrd2hhK9W0moHfnyxSPF6rSI/HUCyECRfs6qQNP0w9kxsOXxrYcMLNPmErtt7qEMGHmcuLKq81j3T9yyO6uYqV13VBgc1LiZRQYkpmY1Rox8EfCNxINstNJmwukCBMdPBGbC+E9lDDMsqdY+95V2M7WYXPrUmIjXrv0NL/IjYClQTrSeTUjAkGWJS+FO45ClqxI3d7djbA1JRtk2Gg5lJqgn3Bl04VdcRWl8KKU8TazTFz9eYbMPrXa0NCZPcJapgqUU50YN8m+nD5Ozi8PLSPwDy00mkfFn/RvA0qCmotfsG1h+Djve2UkcAP1mAyvYczwfIPnhNAOPIIuavwSLMozNiuydNpFtup6zUmxHYB2jhxJ58ePLZ1n7jl3rS0J065pqC9udoJnKLaqsG2ljyvw6DnqL7MjY8AQefKhjefQExRUVi3dnF59rFM/DMKE/a22Whf6/k85V5yAmeH+4pHHi8UdaCrMfZ8uf+vnzZXuL1ustCm1TPfyFRWx2HagehdlsO9oA0JxUUzUwKQlECHdfp1kkgn7KS3p5rhKuZ9bQ1Zh5Yx97GJB3ig8+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(2616005)(36756003)(44832011)(66946007)(2906002)(86362001)(4001150100001)(83380400001)(31696002)(110136005)(66574015)(6486002)(36916002)(6506007)(53546011)(478600001)(26005)(6512007)(186003)(5660300002)(38100700002)(4326008)(41300700001)(8676002)(66556008)(66476007)(8936002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtlSDQ1cWNzU0JoZXYrcllSNGs3UHJ3TnU1VGFtRGhLQWxZQ0pkYlNzUDRB?=
 =?utf-8?B?b1J4Y3JFM0FyNHd0czR6cktGZWRuSTRNMytJdHB0OVpIaFRzeERrak1XeFpw?=
 =?utf-8?B?WXVxbFYxbEp1V3VGdGFDb09UZzQ5ZmtOSDNHeVlDV3JjQUVWZkZxeDN6elF2?=
 =?utf-8?B?RGM4QnRlckdtVkpnYjJ5YU9yT3dRUmNETHU4Qk54VEsyZjRGcjNOK2ErWVNv?=
 =?utf-8?B?QUw0Q2QyNDJzOFdCYndLVkxpQVczTXh0amFHa0M3Qytza2MyYzdybCsvWE5p?=
 =?utf-8?B?RkIzNnk1UzVqbEFYUW9VTVRQa283SHlGVzBHSCtkQ2UzV2dqNldNZERSOEgr?=
 =?utf-8?B?cDJ3bFRmZi9UY2ZTL2JWazZ5NzVmckRybTd1MWc4c1M2YjJnRm1vVjZhTHNZ?=
 =?utf-8?B?aWJHV0NzQW1MTVU3Mk0xZElMb1BIQkNKSGRzeWFQczBQL3BjSk5jUE92eG9F?=
 =?utf-8?B?RjRLNWJ3YUsrSzhUaEhNR0FISzZkdmsvNVAvS2pmQnl5QlZRcy9DYW54YlRY?=
 =?utf-8?B?SUw3L09vVlFqRXZ4Ukt4SmtQZkdIQys5UExLNDNqUnozTnphcFBDU0o2MUMy?=
 =?utf-8?B?SEFIOFljc08rb3hXaWJhY2VCblV5Zzl4N0tiWElNdm5UM2tYaG1xZ1phdGVo?=
 =?utf-8?B?UEYrMjVGQlFXbEdMa3JQL0x1NXd0SXNrQUlVQUJvUGJrUUtkR1VLSnBkN2Mw?=
 =?utf-8?B?Y1JVZDNYMUxYR3Z0RmR4Vk40TDNaRWJYUzhVOVZRbkN1Z0NWYW5lR292Z0NV?=
 =?utf-8?B?cHl2aGxNYTJkaDVxdkpIbHZ6enRmbnVKVlQ5eTVrNXlPcGtNM1ByWHBvZHVG?=
 =?utf-8?B?L0Z6SWhSSUdtZ0I5cVJTZzd5OVo1MkVFQjlSM0xMVHNQSC9VcDRxUXdvaGFS?=
 =?utf-8?B?VExmaEp3YWxqdFJIRTRvbnZ5Q2NieEZoYVp3K1dhbXFrS2tMand6bmJNOTNL?=
 =?utf-8?B?aTNXU3RuamhRZ3dSMjRRb2dLbTUvNXBobnZZamY3TUVLRjQ0Nzcxc3ozQlFv?=
 =?utf-8?B?M1RHcXhLU0krbGZSdjZlcUkwMjJyVXZRQklGeGo3bXVuNzZ0SzVsYnA4alB4?=
 =?utf-8?B?MUJjamdKM0NNRldudzVvWUZuZklUT2hSNmJJRHd0QzRYTkd2NEcrYjFGbUxE?=
 =?utf-8?B?UXQ5VEZzK05zM0J3dW5nNU1Tb2loTE1Uci9Pd2d6QWZ0RnF4M1IrUzlUQzZx?=
 =?utf-8?B?U1NQNFYxV1VURXA4VHJVdkRPUTdsSktuYzVoaEY4UXlSWE9RQit2MFFjSDNQ?=
 =?utf-8?B?MlljaGlYTDU4ZlJRcGpxbklmNG1rcHA0dVlPYzA0S1dpUTFqclVSVitmUTcr?=
 =?utf-8?B?UDZHN0gxV2Evd2pGemhMWVgzOU10RDRNd0x5ZDF0QUE5TzZhc2VncVk5c0t4?=
 =?utf-8?B?QnJOSGFhVktpS3FyN0NSb2pBVTNNQnlwT3ZLTFVoTFZkU243c0tCSE9mVkFX?=
 =?utf-8?B?cERjNlEwNzNTS01oaGZRc1lEeG5yZVZwRVhrelpONk5hQmlFZGFEaDE0aGxW?=
 =?utf-8?B?ZEpnZytKaUlHR3BuRi9SQ3N4VGVOMVF6Mzc1Rm1EeXNQaDJpTDJSVVlaMTRt?=
 =?utf-8?B?QzhmeG00MzFJczh3enIreE9FaHZSbTMvam1JQy9IeUozRmhmSVppbFFpMWZO?=
 =?utf-8?B?Sm5EYjBZaE1KN2hhdzQxbnhiRE9aQ2lpODVjaUxwUGEvUlh5bGVGWlErbHdu?=
 =?utf-8?B?OXV3MElKVUlmQkNYdk5ZdnVaZVRkdDJ2NEV4aFVUSGl5MFF3UXhHd2UwcStK?=
 =?utf-8?B?UFd0LzBKdXdZWHVUb3ZnRTJXR09IRm1obXEzNFZWZ0NVSkk2YzNORG9vN1Ay?=
 =?utf-8?B?UFhSRmh6U096dmZra0dTTkNWc0RtUVZrYktFQ2tQdTE3bE9kWUlFeWNrYlFn?=
 =?utf-8?B?TjkrOGVQcDh3NjlFQ0VsOFZmRm16MzduVTVaYkJ2UGFuSzVoeEhsTlAvRHI1?=
 =?utf-8?B?S0lYNGdoOEI2b2N0Y2lWZ2pvM0p3SzJlU1NpWERtOXFOcDN6dnhXVk93ZSs0?=
 =?utf-8?B?d2FnZnlmZWgyL2hiZDFRdkV5V0lZR3dmek9OcEhCT0traTVKbXc5UjVQSEY5?=
 =?utf-8?B?YS9UZW1OZ3J3U1ZkWXJBc0p1dktrQW9QYnF1c3hXZjhXaGJVazR2aTdzaXJs?=
 =?utf-8?Q?LxIYMLFrh7QCL+IWSIykgiDKx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a16c716-6438-459d-4afd-08dadd33a1d3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:58:25.5958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfeQdfRgNSWjgDq/F+Eb3EckjtxTtOwiQG5xnZQu3dnSeBrU6k2IApImifcTkTkD/cInaSzTRFm91ZxwdKUtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
Cc: kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-13 10:57, Christian König wrote:
> Am 13.12.22 um 16:49 schrieb Philip Yang:
>> If amdgpu_amdkfd_gpuvm_acquire_process_vm returns failed after vm is
>> converted to KFD vm and vm->pasid set to KFD pasid, KFD will not
>> take pdd->drm_file reference, as a result, drm close file handler maybe
>> called to release the KFD pasid before KFD process destroy to release
>> the same pasid and set vm->pasid to zero, this generates below WARNING
>> backtrace and NULL pointer access.
>
> Well NAK. If you fail after making the VM a compute VM the correct 
> approach would be to drop this in the error handling again.
>
> Since we don't need to reallocate anything that should also never fail.

I don't understand this comment.

The fundamental issue, as I understand it, is that compute VMs don't own 
their PASID. Multiple compute VMs on different GPUs share the same 
PASID. Therefore, freeing the PASID when the compute VM is destroyed is 
wrong. The PASID is freed by KFD when its process structure is destroyed.

Regards,
   Felix


>
> Christian.
>
>>
>> For compute process, KFD manage pasid and drm close file handler should
>> not release KFD pasid to avoid double release.
>>
>>   amdgpu: Failed to create process VM object
>>
>>   ida_free called for id=32770 which is not allocated.
>>   WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
>>   RIP: 0010:ida_free+0x96/0x140
>>   Call Trace:
>>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>>    drm_file_free.part.13+0x216/0x270 [drm]
>>    drm_close_helper.isra.14+0x60/0x70 [drm]
>>    drm_release+0x6e/0xf0 [drm]
>>    __fput+0xcc/0x280
>>    ____fput+0xe/0x20
>>    task_work_run+0x96/0xc0
>>    do_exit+0x3d0/0xc10
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   RIP: 0010:ida_free+0x76/0x140
>>   Call Trace:
>>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>>    drm_file_free.part.13+0x216/0x270 [drm]
>>    drm_close_helper.isra.14+0x60/0x70 [drm]
>>    drm_release+0x6e/0xf0 [drm]
>>    __fput+0xcc/0x280
>>    ____fput+0xe/0x20
>>    task_work_run+0x96/0xc0
>>    do_exit+0x3d0/0xc10
>>
>> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index efc0a13e9aea..bf444c3f6656 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1244,8 +1244,14 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>           amdgpu_bo_unreserve(adev->virt.csa_obj);
>>       }
>>   -    pasid = fpriv->vm.pasid;
>> +    if (fpriv->vm.is_compute_context)
>> +        /* pasid managed by KFD is released when process is 
>> destroyed */
>> +        pasid = 0;
>> +    else
>> +        pasid = fpriv->vm.pasid;
>> +
>>       pd = amdgpu_bo_ref(fpriv->vm.root.bo);
>> +
>>       if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
>>           amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>           amdgpu_bo_unreserve(pd);
>
