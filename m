Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D647EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 07:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB3E10E02F;
	Thu, 22 Jun 2023 07:21:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205B910E02F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 07:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnpl3dpbWWsCnQvv+ezQ9FukoGRQMJH0VDzdbp6QIQxB7KoUaVDUcfm1QXnKfagTBys/dCGPzPW+dWVeKPkEMFGGywn0SgkTwa+OqdtnhzAVD5UbyrlEKhJhQW/eGIjB8+h2U7E+eNZr2m3301uq6dd5lxrh/dqkUUHblLGzNgyfglWHMp+5T7UEsV2BHh9tQbSIOke10KtrL+KGrTw/qZHoauttwTPyDL1VwNFOIYPN7UESnoqdwugvpr1nW5EwPdahAQINVfURiR1/XfFgJ/BSeUvOLBj81Rk8mqKPpHT0US3hSKdmspytQ8WxSqUO+e8xT8xIPS9LHtpxLTUs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7KbQcx4muqOgOO3VE+gJ5L+mPPbQ27cqsVZb5c3a+A=;
 b=FaqEy8di+m2FgxDr2Ef0SLGftG+CjXd4+aEwB1Qtz4CqEKjnHfk8vbaIukzZDs0y2wlm7Ozr+VIbqCV3cqF5jyr8LNtH5Lmk9yYqjoMJ8i8tBHPLz+OpIBDyNefx8VtSyFrTHKdwBITr6Ag1/IWIH3wPj1nbVOwKy77K++2N5tkXg2IR7cTRviQuaGaLYlcfvsHlMneM9Jx3aQoIsjqO2Q279mV34gVtzr7O0QrDFSJvW1tyRA6TSxqwhYyIRmuZn1Uo6sCOgdvDg4WQ//6ZukPAhpYPkbEUy2itLztwaQwUOmuQS3wudUZCYMcZ0FNEIQl3cpX+XENYbm5UyRx3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7KbQcx4muqOgOO3VE+gJ5L+mPPbQ27cqsVZb5c3a+A=;
 b=kMy+hiVyXlLHe7dFihTLMpadSTxajNgjUJH3fAseb9G0PrjC3eke9z5kU96Uuufte/2r4E27PgmBkvtjZLum1wSqTbD/LxcrVvUiXJ+51tQv/HpkAP+2ANYv7EWx8pYggGCaCy+3UBhnVJR4JEppzQ0eh+rsgNPsqkFwQutS/ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 07:21:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 07:21:28 +0000
Message-ID: <30e99e9b-94f8-8c53-1fe2-8caeeda4060e@amd.com>
Date: Thu, 22 Jun 2023 09:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Forbid kfd using cpu to update pt if vm is
 shared with gfx
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230621094623.1357399-1-YuBiao.Wang@amd.com>
 <a373e7e8-1cb6-44d8-ea75-0e90bfe55e39@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <a373e7e8-1cb6-44d8-ea75-0e90bfe55e39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 58732415-040c-4574-d79c-08db72f14b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98uM0LEfY/GejBnHeZyXAC9TFgY9zbVoQKdNyxLgCbxcC+FgpWSLbAPjTzFoh+RIBFQ1pLCJD3/eZ66I49leJfYuWpc0lVX1XgKaeDdEX2wopy3jLfZU4ArgeOUs33+gnKvmaCl5y7gQBet+MlrW53+QNcsZL39966l+hADa8evAcQge6N3bV3kelAYKUgHKrN5SXTZ5U4kc6zenNqaniFzJOniELUx61j5EmEmZ48W+ad23nV27jeLyHPcDrdf4oC4cW0fTyKepvU8OySJcxj3DBn9yYB3Ip68e8shncYMOnxRUeI3zb+homHQXZLISQTkAkDUHlFp9S9pWk17KwQpsPxNHrmf+P5tDTcrYEVNfm0iTKuBeFtoSG9RCer+tGarnpVRYqJAyqOPBiC1QP2W/CYbxJodVwQqWW6getiwDrCGGYEZj+HwbXmcuoBR4WiiCSINZpY+umQwMgFjd+LqhnQ6yYSps09w+pgk5YTNLOXwi7SI7fvVXehjoSRA6C2XfTZvWXC9fsHflQzvfERK1g4uQi8PtS62H0rwTpQktgPzNOu1G7/Pg+hYvunbKNKl7GrpjDM2J0EMBoD9Fm+VtiFcpX+OS6Ytl6aWJoMsGizY0ygWt3lK9QuNCSphpwfQlb4HNaFe1FUwzr4e6gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(6512007)(4326008)(6666004)(186003)(54906003)(110136005)(36756003)(2906002)(31686004)(31696002)(86362001)(2616005)(316002)(8936002)(66946007)(66476007)(66556008)(5660300002)(478600001)(6506007)(6486002)(15650500001)(83380400001)(41300700001)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZhZklMTjJuK0MvNFhyNUQ4NU1Sc1JidnYyeFNDUXpFNEtHWEhBbEsvbE5s?=
 =?utf-8?B?Q0s1ZUhsaHNpQTJ2Z2RtQ2ozY0czKyt0MVhZMzd4a2tPU3RRT3R0ckJwM0Zl?=
 =?utf-8?B?cXRlbTh5NUkvRlI3dUxoeWtwYkRTTkhmWTdDaFBkUVFrQ0VmaDZDMmtObDlQ?=
 =?utf-8?B?N2ZJWUZNeW9KaHdwalhHNnNyb0YzVDRvUEs3bGhSblVSNTJvM1FwUU5SSFhC?=
 =?utf-8?B?L1JPMWl0YjlYVVQvT3o0ejBxa1M4cjRsR1ZSVDEyK0ppTG9LM2g4T1dhZ1RL?=
 =?utf-8?B?OTFVR29WelNPVERMYVAweFhZTExZZ3p5ekNUdHU1Mm9IWmkzekhhN3Z6NXZD?=
 =?utf-8?B?alRQVE1rUDZXa2dxTyt2bjZHYkw4T21Rb0l1Z2tCQytwWWZ4WVhackgrQ3NV?=
 =?utf-8?B?NkNHNHMwZE50VVo1OWxMckxOdkh1UWFOVWVIMVJDOXI3cmc4cXFCY0p0VHQx?=
 =?utf-8?B?SldJdjhnTEdBdHVKdzVIb3NIbFdpdVBUTGFXRXpnSEdhQVQ3aSs3NXA1SnN3?=
 =?utf-8?B?amNEYWlnM0tKWkkxd1M5RktLckh0RS9UVlVYUDljM1gvS21RbVRXQlhpaFR0?=
 =?utf-8?B?Z3BhdUJqR0VmREVDVlQ0M20rZnNvd2IzZ2NPUTlVeEppQlZybk5EYlRUY0hT?=
 =?utf-8?B?MjFLL2R6ZE9IbTdndWx0KzArV3VOaWJSc1VxQm9UQTdVSXl5L3loaWFtNkpP?=
 =?utf-8?B?MGhmbG1xZTJyVDJVQzVEY1N0eW9PYkZpQlJaNzM2WjZ6dGhmTFNFa1F4dGVB?=
 =?utf-8?B?bFdWMjhUV3hSdFpnM2tmYU56OHZJVVJpemk4Y2tWbEU1YVVhcGRPT1d0T0RK?=
 =?utf-8?B?YjZST1E1ZDhMRVlhUWpsVnMrSStqcE1ocTdjc0VNVmxqZWZFNVZqNEhuYzJn?=
 =?utf-8?B?bm5yS3UzczhleEJrbk5RdG1WeEFUSkZDOU9tWCt5UjBuU1BYcGtma2EvdDdy?=
 =?utf-8?B?aXdlSHViNllCdFJ4WTV5Z01FSnpLbjJSanVIdHNqYkRaUWR3eWdGczY0QVlI?=
 =?utf-8?B?NnRzVTdoWDlNZXFqR2tzTnNHdEtqUUZqUmQrNnJ1WmdRUFFxYktyZWJnMlRQ?=
 =?utf-8?B?WW5MbTlmS3pDekJQYmIxWnNPemlTUUdicTlsR21xVTNDUWZSTUpSOWpZUCtY?=
 =?utf-8?B?ZlUwemM1TUlHM2szWkVpb3dMRjUvVm0xWmhaUDAvNEFBZ3BnN25nbm90Zkd6?=
 =?utf-8?B?OUc5YWkxWFpFQmRJVEl2b05JdHBtMEZjbkp6VWIxYUxDbHltVXdCUDR3ekto?=
 =?utf-8?B?Wko1RkQ0TGk4Ymh2T1BnNHpiei84OWsrTGJTaTlYZU0vOGx5a3Q1cHhWY0ZD?=
 =?utf-8?B?SldJaFc4dm5RRUtnUEYxbyt2SDF5Vk1MOWZ0aStQUjRmOHBFcjNRc0lCcDVw?=
 =?utf-8?B?b2Z3cERmSlg5OGF1MG1vQ2gzRTJZdGk3c21mSUVjRmNNM1M1VzdmYTJoRHJt?=
 =?utf-8?B?SHR5UDFwQWRjbUNWNnpweStWNk1GWlBkaUtOcXYzdjJJZkdITFNMWmYwL3di?=
 =?utf-8?B?a3IxazFyQ0xVQ1JkdmthQ1p0SCs3T2pHTy92aFBOZE5mbUx2VDNkR05XNm1B?=
 =?utf-8?B?bytaOS8yTHkvZUwxeEllMThQa051a0I4bEV1NFE4UitmaHZDR1VDdFpzWGZ1?=
 =?utf-8?B?YklMbUlZbWRFTDJneHpQbXNWM0kwVWZYeGZRTlVwUkFSWktkQXpjTnBSMlRI?=
 =?utf-8?B?d3hPblBKM0R4bDhXak5SbjUrbnRWaVBnSlBsY1VQazN3TEFFeEhQME5ZWWdY?=
 =?utf-8?B?SlVrWTBPalVENlB5KzBXQXNnMVpmVlFqdldiUVhrenErK0RpL1dQVkEzMldZ?=
 =?utf-8?B?NG82OUE1STl4d1hzd0ZNUWVmRmFwTDZoS2hoZlhUenFzSno2VDd3M3JWNDBp?=
 =?utf-8?B?NTNyVnRLUVN2bXZtZVBHYTlYNmtyamxpNnkxR2svLy92VGt5RW5VUi8yY1ln?=
 =?utf-8?B?US9PNkpGZlhkUnlHY1lxejBZUENheWlpTUpWVm96Q3dBYWxTMVlJVEsxZUtY?=
 =?utf-8?B?dmRuRmpHdGNMakd1VG5sckZpSjVwZ3h5OUR2dWRwQmxFRy9la2JaaG1sNUM4?=
 =?utf-8?B?R3FmZndIamdaT2lIRHVZOHdOSm5JeC9nVzVmdHZHbUxxMU1ZWnYzWitsN1hx?=
 =?utf-8?B?a0wxa3hDby9Uc1BpTUpQMDZVTXJyVldZRVkrYUVLREI2WkdnU3o2L2lVQnd2?=
 =?utf-8?Q?5vFholf46o4y11hdrksi1pXKqOONN+O6P6StuNFTJAX3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58732415-040c-4574-d79c-08db72f14b26
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:21:27.8744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gXipqwXWEYRb0HfNKy4yub+uBr1zjt9NzxqyLR3yZT8mAox5AlVjt3jZNIo3bAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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
Cc: Xiaogang.Chen@amd.com, Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I have no problem dropping the AMDGPU_GEM_CREATE_NO_CPU_ACCESS flag from 
page tables no matter if we have large BAR or not.

That should only be necessary when BOs are pinned and since we never pin 
page tables it shouldn't matter.

Just set AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED after switching to CPU 
based updates for all already allocated page tables.

Regards,
Christian.

Am 21.06.23 um 17:16 schrieb Felix Kuehling:
> Can we change the flags if needed. E.g. see what 
> amdgpu_bo_pin_restricted does:
>
>         if (!(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS))
>                 bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>         amdgpu_bo_placement_from_domain(bo, domain);
>
> This shouldn't really change anything about the BO placement because 
> we only enable CPU page table updates on large-BAR GPUs by default. 
> Alternatively, we could create VM BOs with 
> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED on large-BAR GPUs to make it 
> possible to switch to CPU page table updates for compute VMs.
>
> Regards,
>   Felix
>
>
> Am 2023-06-21 um 05:46 schrieb YuBiao Wang:
>> If a same GPU VM is shared by kfd and graphic operations, we must align
>> the vm update mode to sdma, or cpu kmap will fail and cause null pointer
>> issue.
>>
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 291977b93b1d..e105ff9e8041 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2239,6 +2239,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>>       bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>> +    struct amdgpu_bo *bo = vm->root.bo;
>>       int r;
>>         r = amdgpu_bo_reserve(vm->root.bo, true);
>> @@ -2265,6 +2266,10 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>       /* Update VM state */
>>       vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>>                       AMDGPU_VM_USE_CPU_FOR_COMPUTE);
>> +
>> +    if (bo && !(bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
>> +        vm->use_cpu_for_update = false;
>> +
>>       DRM_DEBUG_DRIVER("VM update mode is %s\n",
>>                vm->use_cpu_for_update ? "CPU" : "SDMA");
>>       WARN_ONCE((vm->use_cpu_for_update &&

