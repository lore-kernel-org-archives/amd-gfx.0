Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D7BC636CC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 04:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831F610E052;
	Wed,  8 Feb 2023 04:29:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C14810E052
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 04:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVj2LUYn2aPKXdqEv7ZfOGduPUTWPGznHWhAUAllxPfnrv8PU0/j1TZBV7ab3ZtV7rMBqgCtl2aOw3nojRNsTMtmdrPkDBjk0s6fgn4swU90dWx/HcU8z57U0xrhZxjbMx8DbGipUDG4kksbKIy9xdVly8Z5hLeDiK/Ssx+syqhUc2XiwhIDbA2G8pUfAMw0WnlkrksRmuV2iJJEwD3/dVLA6nYI3VOu805/vHeIduosiHzL7pagk+PKXmTrZpAk4GvG0Jp49NODkV0Nz/6HkBioLiHXM0LD2YlUTG7cQ6suuOZU8NKzdgaWJXkslvN8HUKIVH7VTUWt4gLIYOy0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97CiBFGTzv9I4A3oMMp9cOxuiDB8ZHN76gn1eZxg5FA=;
 b=RoVghmZM3tSV+2m08ylrQnOKyZv51owWuvAfxuG7/SEkIiGHoaeX1feaXwngMdCsH3NPv8rcGMtGWNDhjMS/Bb7FWWciI+qmo5O8yXwY/nBeMfBebaicetbch++wi5PPQiCbo54LVsn0ZBOpQJamxG8OM3sJBr/pcaZO3EFkPBbzgCqhyktSv/97oHPBpLMOo95zIUMu2j6gwKF7z94s5Rms4x5TX8sLZ8qgQgym0p8bR1VanPJjs5/LzCtJNFgnxM28lhleHL4bA2UiVPGUX19tLP2sCwpCpwGIK2ZVcrVcmbZwYMRDdd9yikB4eg7cE/ApMR+M+5/3Y7gPNOkE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97CiBFGTzv9I4A3oMMp9cOxuiDB8ZHN76gn1eZxg5FA=;
 b=MLko7jdTxxAylJwhXtVsOIdyvAgN1wyxnz2yTYTKAPEIBPdlstZhixZ9knrnm+nX9gUxxGq2qoDB74I9wS0Zo2c1JxiDxWVr7KsWqKA8nfjd4c6+id0aI7qXi3Bwbg5Sj2BCUVBahqdJo3vEfR5+CrZ9Bea1k+H6dJVDe6u69QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 8 Feb
 2023 04:29:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%5]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 04:29:10 +0000
Message-ID: <dd133e14-55ad-b240-1c78-27632fac6716@amd.com>
Date: Tue, 7 Feb 2023 23:29:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Prevent user space using both svm and kfd api
 to register same user buffer
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230207203504.879056-1-xiaogang.chen@amd.com>
 <3c62317d-7ef8-9f5d-4ca3-1b1bb9d56b14@amd.com>
 <d0043f07-183b-f6ca-c97b-faf45cde3ce8@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d0043f07-183b-f6ca-c97b-faf45cde3ce8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 389481c5-2e60-44da-2230-08db098d0681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRi1uG0Iphi4srd4x9oD3vmotGYfUlc/tsSLptTPaFJcYbVj1ENKiumg8HSG6uJb5pCquVO8fwz3ctT+4INv9raBRI9w0qto6M7y7RiuHzwA3IKhgyQtqrT2h/cjtpzhrarPzVd+02lWfAr+zLXOnd/rO9QN6fBMU4vO9HFRMHClH1j9pNU/j/TvUgcB4jY1JIQBYasZ0FB7uC+n0J7qt9Vxi+TTPaK/YQ3+Pvq0DC8wm0HIP1e7Oo7iBLeNvZUgc9Fxo4/73fH5mvzXZpiLJJvpEec4pfrx1FB91UGJY/Bg1TmMxtFo99rZlWBQ+tcHDGNxSAaHYbrZgzm7Bpw/ur50qo91RP1gNXjJXBtYtYqDmS6oz32EFtCaE0iMqr9Hg81sDv32IDRQDcrIaiBuBr1oE3CERHp8DuQwaF7DNPVw9C60Jy69TMY5FKCo1a30JvSfQ0aFl0NbbSgbm4hWMAS8NuJOIPfO/XjrBjcSIofjfZus7x8+cN+p81GolNrcW/qRCdp4poYbcp1ojDq3MIP+Vje390uXMjln36XG3YmFjvV+X3qhCEpAT6/GTPrjOrm4wGEm9/mZBFbbaqwd4c6ejliwFQxIDgQztKq8x58jmkSCGS7OriHjxeGm/9yOtWno2jOmRdRirqulBncAhgumZBNqqEhKMI9CMbosVTH1/tql9gLQtXT1uLysgtbmWz9H6Z2BC0BcwfBSGiYn1TsRticPH5grxui5Gn3MAhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(2906002)(31696002)(44832011)(5660300002)(38100700002)(6486002)(478600001)(31686004)(6506007)(53546011)(186003)(83380400001)(26005)(6512007)(36756003)(86362001)(41300700001)(66476007)(66556008)(8936002)(66946007)(316002)(2616005)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhDTXoxQmZkR3RKSlNXdDNUNjhsaE5HQ0YxcGVpK1RXZldyR1Mrd1R0Uzls?=
 =?utf-8?B?NU15aHRrcENVdWNJYkxMSXQ3WFdTOExTaHV6UlRBTW1ya3JLV1RLYTdvNmRz?=
 =?utf-8?B?UVA4cGF6V29JWUVwQmNsRVZkaG5FUzlDM05OeE1pUE00eUo4N0FxaE95azBP?=
 =?utf-8?B?UGN3QnFZK044ZTlzL1NWZnNLRUNhQjJHaEIyaVN3bWRobFRQRXNvTndiUk9J?=
 =?utf-8?B?cDY5NTU0a1cyRzNZNnM4RTRZVk9PLy9ML3N0SEdzZmtsZUpSQUN6ZklEdGVm?=
 =?utf-8?B?OGhUWWtleFdGeDdZVzg2WnNTeHZmSVJOZzdxdnhCTndxbXVUTnVjSkdKdENp?=
 =?utf-8?B?NHJjcHdqNXM2azZzZGRaSnlWeUQ2c1FPZjVsaG9EeWNwUEhtQzFZVTJ1eE5T?=
 =?utf-8?B?TWdvc2ZnVkNuTDl3N2RIMmVWeTE3d0FydXIvY2NVN1JVeWt1TUpMZE93UUtY?=
 =?utf-8?B?alVnc1JtYmtHNjkxaTJ1RC81RERCVnZaOHgxNU9TNlJGemlnK2NOUVJFSytH?=
 =?utf-8?B?c1FxM0pQeDI4QXdXWkJIcDJmYS9idWYyd3FRL2FyQmRsY1piMm1qYkV5R29n?=
 =?utf-8?B?SWx0c2JTWk1zQTVIM2VHMS9wWU9QOFU0QUp2YXBHTHNTbysxaFF0TGtzcDF6?=
 =?utf-8?B?QUx2UklDdXc3SkZmSkpQbmg2NjBlUkgvRVZPM1MvelUzVXNDZG5YRjdYSmtx?=
 =?utf-8?B?UXp0aElYVGt0VGxFdUpOWkdsd28vVVNPQzRTczlsbkY0UENzQUV1dkFoeWtl?=
 =?utf-8?B?bzRodHU0QU1qZjNFVFQrckhFMGRmeEZFYXpKTWxidmtoK3I5di8vWGtaZDI3?=
 =?utf-8?B?azRneS95SUFxZVdTTWpSeW45SVVtb2ZSRkNwTkZ1aHhoQkFpRk9PWEhTczIz?=
 =?utf-8?B?VWg1Y0d6M2dRZnI2dml1RFllUnlleVZrRithSUFQZE1UcUF0RHUrQUpNYm9Z?=
 =?utf-8?B?bzU5d3R4ekVaelBEeEJkUG9PcHlYWWVGWU44SDBBVVloV2IzelpMWHp6dGdj?=
 =?utf-8?B?cE1ibkMwcDBmcms4SFBQS3NHblJNSmZsNjBrc1VKUm9EUWNMVkNmMk5WbHZ1?=
 =?utf-8?B?LzBxaVBnNTNJSmhyeVY5cFJWWSsrcE4wYmJYRmJ6a3JVNUo2VXBmL2h3R1hk?=
 =?utf-8?B?OXVxSUNobTAvR2tua3IyUkNkbmJEYXJxVG1idnBZVWROZU9UL2lQQmdrUFRj?=
 =?utf-8?B?M1o3MC9YdnBjZmdVWnNRdkpIR1VCYmxacmxsOGdrdXZpUE5KL09rUVdqOWRh?=
 =?utf-8?B?Rlo3aWpQNUFWbnY4UktRSDhmOTVKcGhhaU9wbUx1bDFPMk94dXdmcm1RV1Vn?=
 =?utf-8?B?RTFkZmRnb1Y4VGM4YW5wYTdKVC92QUZka2ZVUEw0ZTFGUE93MTFzWk5hcDVK?=
 =?utf-8?B?aUlDWVhuNnJhcFAyeGpKZkNCOEZIdHFHaGVjd3JuQjhZWDhGNS9MaytiTklO?=
 =?utf-8?B?U3doMWFoRzRtNzZzYmFNakFkS00zWExEMHljV3cxK2s3YmJUelRvNU5ULzRo?=
 =?utf-8?B?Y0pGSnpwWWN0a09Wbmd5N1NPUnNMZXYxM2ZDZDBTWW9yVm13RVJlN3p2dTd5?=
 =?utf-8?B?N1pLR2hpUUhaTXpGNk9oRVlqT1hDaUlBZkNmenlQeXJlb05RS0d1T1pvNVlr?=
 =?utf-8?B?L1ZqdUozYlU4V0s1ZXhrSXZmSGVnbjQ3WURsclNiczRBdDJ2VTVLWXdVYlJL?=
 =?utf-8?B?eHpYUzN0OWd1bEUvNEt0RlFKakFLUjIrTE0zb01DWVBtdjh6TmVNbEpIU25D?=
 =?utf-8?B?a1dJbGFCc1FtM0pTVkhocTZtditqS1doTXQvbE14MFF5MjJXN0VtOHlFd055?=
 =?utf-8?B?dWlKNWpQRktiWXZ6K3d4TVo1eHdjeWlkZm5vSnpKTHNYN3FHU3kxOGlFMldH?=
 =?utf-8?B?Nzh4Wmd2VXU3SDcrajJiUkxWei8vS3ZmNHhmNkhObS9DMDl6RTZnQUxTZmds?=
 =?utf-8?B?YitBYXNjWG9sQ2RpeVZkU0FVTFk1STVEM2xMdTJVUWE4SzdBSHpWR3crRlph?=
 =?utf-8?B?OTVkR09JR1hkZnlHVkVwQlVzQlo5RDVVenFaU1FNenZyaTQ5R21HZndSa08x?=
 =?utf-8?B?b2hqMTRQSkZkU3F5YVM0L1V2NkV3T1hSblFsR3kvenpRL1VNaHVtN1EwTENm?=
 =?utf-8?Q?3EtjduGGodYoZc7YVawYXLskq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389481c5-2e60-44da-2230-08db098d0681
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 04:29:10.8784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD79sOz3LzMrdeP3aQ+1zHZOx/gRxy3AU/Cx+HxKE/Kl0DcR6AsOy0VVN1CNfTD+0+HIHN6Nt7ai05M7l2Lneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
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

Am 2023-02-07 um 18:36 schrieb Chen, Xiaogang:
>
> On 2/7/2023 2:48 PM, Felix Kuehling wrote:
>>
>> Am 2023-02-07 um 15:35 schrieb Xiaogang.Chen:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> When xnack is on user space can use svm page restore to set a vm 
>>> range without
>>> setup it first, then use regular api to register. Currently kfd api 
>>> and svm are
>>> not interoperable. We already have check on that, but for user 
>>> buffer the mapping
>>> address is not same as buffer cpu virtual address. Add checking on 
>>> that to
>>> avoid error propagate to hmm.
>>>
>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index f79b8e964140..cb7acb0b9b52 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1065,6 +1065,23 @@ static int 
>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>           mutex_unlock(&p->svms.lock);
>>>           return -EADDRINUSE;
>>>       }
>>> +
>>> +    /* When register user buffer check if it has been registered by 
>>> svm by
>>> +     * buffer cpu virtual address.
>>> +     */
>>> +    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>> +
>>> +        if (interval_tree_iter_first(&p->svms.objects,
>>> +                untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
>>> +                (untagged_addr(args->mmap_offset) + args->size - 1) 
>>> >> PAGE_SHIFT)) {
>>
>> Instead of nesting two if-blocks, you can write this as a single 
>> if-block like
>>
>>     if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
>>         interval_tree_iter_first(&p->svms.objects,
>>                      untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
>>                      (untagged_addr(args->mmap_offset)  + args->size 
>> - 1) >> PAGE_SHIFT) {
>>
>> I'm also not sure untagged_addr is needed here. If it is, we're 
>> missing it in a bunch of other places too. Most notably, we don't 
>> untag pointers anywhere in the SVM API.
> memory virtual address tagging is architecture dependent. Ex: if 
> virtual address is 48bits and use 64bits pointer, people can use 
> additional bits for different purpose. From kernel source tree seems 
> only arm64 and sparc define untagged_addr that are not noop. For other 
> architectures it is defined as noop. I think we want have it if run on 
> different architecture cpu.

Fair enough. But it has to be consistent. If the SVM code fills the 
interval tree with tagged addresses, we can't look for untagged 
addresses here. Given that the SVM code currently uses (potentially) 
tagged addresses, we should not use untagged addresses here. A proper 
fix for untagging addresses in the SVM code would be needed as a 
separate commit.

Regards,
   Felix


>>
>> Regards,
>>   Felix
>>
>>
>>> +
>>> +            pr_err("User Buffer Address: 0x%llx already allocated 
>>> by SVM\n",
>>> +                untagged_addr(args->mmap_offset));
>>> +            mutex_unlock(&p->svms.lock);
>>> +            return -EADDRINUSE;
>>> +        }
>>> +
>>> +    }
>>>       mutex_unlock(&p->svms.lock);
>>>   #endif
>>>       mutex_lock(&p->mutex);
