Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BF2CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 17:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F0910EAA9;
	Wed, 17 Jun 2026 17:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjSlJzGL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A2910EAA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 17:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHOrZ0XuStXxzZlBdST98bt6QIkcuhZlvkKAIWUMgsyxEB2xZswA5qQ71AbE9imk1M7OFkxjqzZVLtCQjoSJo/YFPcpIWHtWt7zn3zmbcrrV2xcmC31N32SZVPgRNWm0juEdTCkTnvjwYWVYOI/RCecWC1tEshoLGEhUlh2zUsIHbvxJeKxSWEFK7ZGamEtU5vntrLJC1yPH8Wds4Zrpzb8YbmKYKF90W76Fc1w4Pt875HLukqQ1ZpES+5ve+HdzMlw0llRm0uDwPKZGHcPck7mFnIPxNIk5NA1iKZKEFxNk1iLxIBBFTBKpIpdR6JP9uauyZHzxLy8BdOWRGWiJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sY4Hoq/T494G+ubH2gl3QKIWD6gmfeM6wGse6/sJeU=;
 b=xm/guizLrgx+RYUJjn0eGj41TSG2deKWTaxKsIUX6vVqkanQgKlYSwWFleHvjScOI7FxH5ktqsTHdyUB7TIaCDzBaqXIPaSzJiPXGiTShAbUOdj2qM/W3xq6+sjHOhh8VvFv2ty+wt26PS0Uk7s8CgHNBqxOOpNP0AYhEf1pfVHK2aA0aJeNvkORE6dGu7NP/df2TBHFCsrfdFy4pjnLmSETvz4MCAtpYlhH/oBBOiXMo1Y76SsLjZSXseE17ZQgK+6fZMjwEjMVtqRPrdzhhkqGQFPck0SKTlCnDUH/dBLpT93YuGXwfRwepQ5PFt0SZr2LEJrRuoIKcMg5sPlGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sY4Hoq/T494G+ubH2gl3QKIWD6gmfeM6wGse6/sJeU=;
 b=MjSlJzGLb8nLPfrWPFznhUztsRJ/TUVffrpRrp1nimsUR7GkFa+PBjon61RnIT9GpBvLp9hqfwDD2on1tsaSmJD0ph3uaoJSsNQ8Sz3vaQjwzunXf3R7poG6W0QzX/s45E6XmT+DUtnfCN3aUsDovNkTiosN3UQW+6HOuJOxyDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH2PR12MB4200.namprd12.prod.outlook.com
 (2603:10b6:610:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 17:44:20 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 17:44:20 +0000
Message-ID: <46f79c77-b432-4417-b78b-4bd4bf2e6bf8@amd.com>
Date: Wed, 17 Jun 2026 13:44:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Unmap svm range when all GPUs set to
 no-access
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-2-Philip.Yang@amd.com>
 <a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com>
 <37555d80-f60b-4b59-b083-e3e47c55a063@amd.com>
 <cb289cab-f676-4d37-b62b-e931ab83b91c@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <cb289cab-f676-4d37-b62b-e931ab83b91c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: ab28a912-57bf-4568-232f-08decc980f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|22082099003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +Qa/YKXaapWwQQL7G9t7x0aYcBUiRDPIDHIwDwVrpbZPJBbLJBE1KhPcJexsutIGI+QrCjBZBf4hYzbS3hahV0bUp3ajQSu8G3yWhEIy22tRvr/v8rcaCIj7I7WN1syc7o0N/ME5f6N2S3itQW1YebyY4/xfn6aMgfbMgB6AdDx6ywgNwNpThQQJQz6CzQeKtFsl4Se1/kMaVAEpddHQoAZDfA15ePWFRhOOc/Awj+3On0oVVOmoivzMfwS2ME3KxBpHo1KtDLRKZBZZxlulH0mdclu58m5dXaWD5WCDpO0v8dCFE+//vGpIVWw2vXrBR1tIn5bhpvHMRqGAMHYct6LsumTy3XZJN76sctyereMq8/f2cMEs0PpKzZW0OuEBUIZTr8cu+ezrKvOkaU+PvcHMKWK/7dcy1jiE/sidUw5VAYzczXwKPavbVYNrBCmuNhTz2KE+Yr6Q5kr0ISZft6ZOmyMDvClLcVf9mwfsFBzjojHCih+fbGmHe6q8lOQv9P2aJgvaWB/Zvv/jDfVj+enoPEBe3PNnQXYBpAluL3rs8WBxr3DcuBqPNBE7oisotTeBstDJfj4kQ0/qdaj/KT+Zp9znEeIjBVWSObTO0XB38jh2ntpC4t+A1tGyWIVbS+JZ1ko7A5aof9zX+9p0zsAjkKFgxq++urSlB/zBk3NgHg7SEPy3zSp7mXCohADt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9FWGN6OWhHa0VQTzJKdnIvdUMyOU1DYjFVNDhuWWJhakxMcUpiNmRtc2s0?=
 =?utf-8?B?SnZIdm4xMG9yMTdFdWFqWm5acXAvMXVVL09zN2ptVVY5T0c5b1pDMnZBVmxx?=
 =?utf-8?B?WXRrK1VEZFgzWGRoMUpGZjBvRWxnandNazNGL1N0b0lScnVGa0kyNGlJaTkw?=
 =?utf-8?B?SGtFQjFuWlVpbUZoZlFkUVlBV0dDUVoxSlR5a25CL01FY2hWdGp2ankyckZy?=
 =?utf-8?B?TVRPNE1tOG5sMHlwSmpBY3VCNDJlQW14MTcwMXpzZlZpbDQrTEJFQmw4Q0Vh?=
 =?utf-8?B?SmRDVUF0TWEvTEZJbEpuR1NBK0d3c2swQ051RHhXTUNSQjIvVHljRjdxMzlH?=
 =?utf-8?B?cW9XNWhXZEk1V1FjRmloZW9QenRUdlZaM3VoOUx6WjFVS3VRWUwrSlJGa3Bh?=
 =?utf-8?B?VFhaTkJqdnR2VHZVbzVqMm9rZlhHelhjVERDcjg3TFkvSXQ0eFJDME9OalZl?=
 =?utf-8?B?clJpT2ZvVkhvZ1JWdjFQeXVKNTZZRTBqNFFVaGFUUmtSUGdCc0p5ZG9USDNX?=
 =?utf-8?B?NDZwdVl4dDhaSFNxeE53Z1hmQzkyby9DUlJkSSt6L290Si8wWGpoOXhMUXdU?=
 =?utf-8?B?MWppcjlDdmRiTVpkaHhhN2J3VVoyc3BFQ1JiTHZOZUxDamF4M29oSVR6QzVZ?=
 =?utf-8?B?cklwMEgzSC9kQ1pCWFJuWTNtMFVCejRJa1ZzQXFoNjZPRndJM0hNMTRjdjc0?=
 =?utf-8?B?akpvbHlOVjhwTlh3TGV2WGhEWlhkaFVyQUJ5WkFQQkgzZXRVYkozMmsvekZD?=
 =?utf-8?B?VEhQazNmSUl0S3AxWitjQmUxYUpmcW9PSWlnV01BaDUrMWprbXhXMzFGd1lR?=
 =?utf-8?B?VVJBVjFQMldDMDBibi8rbkFvbG50OGJnUzJKTFVKVEREVmZkdHY1RUNxZ1lp?=
 =?utf-8?B?a2lKU0EvRVoyMDMzdkh6WllHSXNMa1dPWnJxaG1zUUFoeHFZVXJoQXBERXRh?=
 =?utf-8?B?WDUwamEzbUJkVlEwSzJiK1RVQlk0SXBDSjZMRnpPVVFGNHZyOGxWL1pkaGl0?=
 =?utf-8?B?Nk5Oc0M2cm1NQkdiTWJDUnBnTGNIZ2tWdks0U0JNTjc4ek5uUTVPeEdJaWdN?=
 =?utf-8?B?K3BzTVpWRVg2cHRpV1NHZGhlTC9IR0taUm5sY0FyNFk5VGNjdllyWUF4emJs?=
 =?utf-8?B?Yy93clY5TkFjeGFNTlErZjVpV1k5bW04V0gveVp2S1ZBdFJWQTFBSE1mMUZQ?=
 =?utf-8?B?YnBOMklkaDI4MnVjWWljamhuMForU1l1S3BqdUt0amF6a1dIK3hUUW1oNU1Q?=
 =?utf-8?B?TGtkRVhqWVlEcUw0YTNTcW5Wak0yTWQrMG5UeWx6M29OQUQwcVdZMXpXb2ho?=
 =?utf-8?B?RTAyL3FKYWs2MzJ6dER0bUZoUHU3b3dFQWY5d0JVb2E4RjlKVFdEc2tCbHl4?=
 =?utf-8?B?RFZMY1F0cFdLQVdOSUZJSElrQmNkeWtSZGtGeTJUUVlrd3JBcEhSUnYxOFFY?=
 =?utf-8?B?QUczL25PakZFWDRhckJNQStjaHJRZ2NsaWtCdzJncVZvY3FrQ2UrNy9jTkR2?=
 =?utf-8?B?elo4YnFtbVlIdlliQitBcHBFUGVON2JuT202bmZ5ejFlMWFVYnhld0JzcDBJ?=
 =?utf-8?B?RW02TWRYSzBqYitFZkxzckdvaHc2aWprU2hUb3BWTmNUaGlWK3YwTVViZHVV?=
 =?utf-8?B?WGdKUEZzb3RwZEM2ZGJuWEQ5ejdTVm5zWE9QeThNNWFmTkxYUE5Hd3dsdXk4?=
 =?utf-8?B?MUNzeHBBdTBuMDQ2STVNeXpwSUNzY04vOHJ3WjZLWmp0ckZWRlZrTmxJOWk3?=
 =?utf-8?B?R3hLK1hXbjhNMnYxUHJpNUdOZ2tYcVp4UTNCdDVXRDBNeXorTmljRmx5bmJs?=
 =?utf-8?B?ZndoYlQ2Q1RaUElxVTY2ZVFTTi9ObDJjN0w5ejB1MkFjL05HMkJJMG5WSWQ5?=
 =?utf-8?B?NTRrMHNwanpxd3ZUWks4YThpMlFrUGtZQUNYdi85SGFjUUsvc25WNFYwa3Bq?=
 =?utf-8?B?bDVqREw0N3ZOaExUdzlUWExGdDZpcHhRQ3MxWEs3cjFpRGNYRGM0K053UXhN?=
 =?utf-8?B?Q0hQNStVYzczSlh0Q0hFbFArMEdSZHFjZHhBYlhQZExSaURqUXB4S2NBMUw2?=
 =?utf-8?B?NHE1ZUw3bHlQU0FzdmJ2dDU3NEk0eXo2NGJKd1dRZ3ZzUWZ3bURUQzFJSzJn?=
 =?utf-8?B?YVpoVXo0UkJWVGkvRk1GZXpsdWtPai9KemlaZ1lFRDNGRm1FbDBZSVJRVm1C?=
 =?utf-8?B?bnkxMXpNSHV0VythbCtQWHpGNmhvRk5ZSHlsMG54bDkrV1BKQTQxem9rUnZN?=
 =?utf-8?B?QVVMeGsyc3AzOFB1RWlaSlh4NEhhK0R5cDdWMDBnV2JPSzIrTHY2UDBpTFFk?=
 =?utf-8?B?cmw4SUJyWlV3eUFaRnVSNE5ZUDl6S3hDcS9DZ0tLUWVtR04reUROUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab28a912-57bf-4568-232f-08decc980f87
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 17:44:20.2477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mQAoi/+wxUVtggS+1L3zX8FuTeLuL0lpT79YxVRN+MtB0Ivkg0SFq5fJhoittPExHFTF6QZQ7eg6yN87ONC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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


On 2026-06-17 13:22, Chen, Xiaogang wrote:
>
> On 6/17/2026 11:24 AM, Kuehling, Felix wrote:
>>
>> On 2026-06-17 12:15, Chen, Xiaogang wrote:
>>>
>>>
>>> On 6/16/2026 4:16 PM, Philip Yang wrote:
>>>> When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
>>>> SVM range mapped, unmap the range so the MMU notifier can skip queue
>>>> eviction — safe because no GPU will access it.
>>>
>>> KFD_IOCTL_SVM_ATTR_NO_ACCESS means shadder will not access this 
>>> prange on a gpu. It does not mean driver needs unmap this prange.
>>>
>>> At MMU notifier stop queue or not should be decided by affected 
>>> prange's access attributions:
>>>
>>> KFD_IOCTL_SVM_ATTR_ACCESS,
>>> KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,
>>> KFD_IOCTL_SVM_ATTR_NO_ACCESS,
>>>
>>> or
>>>
>>> bitmap_access/bitmap_aip.
>>>
>>> Current kfd uses mapping info to decide evict queue at MMU notifier. 
>>> I think it is not right. Should use prange access attributions that 
>>> are from user to decide whether stop queue on this gpu. If user has 
>>> specified KFD_IOCTL_SVM_ATTR_NO_ACCESS on this prange and this gpu 
>>> driver does not need stop queue on this gpu at  MMU notifier.
>>>
>> I strongly disagree with this. The kernel mode driver cannot trust 
>> user mode. User mode could say "no access, I'm not accessing this any 
>> more" and then access it anyway. In the MMU notifier, the kernel mode 
>> driver must guarantee that the memory will no longer be accessed. It 
>> either has to unmap it from the page table or stop the user mode 
>> queue. There is no way around it.
>
> In svm gpu vm is mirror of cpu vm. kfd driver unmap a gpu vm range 
> when mmu notifier send MMU_NOTIFY_UNMAP, so gpu vm keep aligned with 
> cpu vm.
>
> If driver unmap a gpu vm range for KFD_IOCTL_SVM_ATTR_NO_ACCESS, then 
> cpu side still has this vm range, but gpu vm has not, though user did 
> not ask to unregister this range. The user mode may think this gpu vm 
> range still mapped since it does not ask to unmap it. It just told 
> driver there is no access to this range at present.
>
> I do not know how to judge "The kernel mode driver cannot trust user 
> mode". If shadder still access the vm range that user mode said "no 
> access" to it is a user mode bug.

It could be a user mode bug, or malicious user mode that is still access 
memory that the kernel could have assigned to a different process. 
Allowing that to happen would be a security bug in the kernel.

Regards,
   Felix


>
> My concern is separating "no access" from unmap from gpu. I think they 
> belong to different categories.
>
>>
>> Stopping user mode queues has a large performance overhead if done 
>> frequently. So we are trying to minimize that by unmapping memory 
>> that's no longer accessed. That's what this patch is about.
>
> Queue stop can be avoided by kfd driver to check if there is 
> KFD_IOCTL_SVM_ATTR_NO_ACCESS attribution on the prange at MMU notifier.
>
>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>>   Felix
>>
>>
>>> This patch seems introducing unnecessary complications if the goal 
>>> is to not stop queue at MMU notifier when 
>>> KFD_IOCTL_SVM_ATTR_NO_ACCESS has been specified by user. Driver 
>>> should use prange access attributions to decide queue eviction at 
>>> MMU notifier.
>>>
>>> And access attributions can be dynamically changed. User component 
>>> can change a prange from no_access to access(or access to no_access) 
>>> at runtime, then driver has to remap the prange if it had been 
>>> unmapped during no_access. In other words mapping is not exact 
>>> equivalent to accessing.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>>> Replace the mapped_to_gpu boolean with bitmap_mapped to track which
>>>> GPUs currently have the range mapped. Set bits in 
>>>> svm_range_map_to_gpus()
>>>> and clear them in svm_range_unmap_from_gpus(). This is separate from
>>>> bitmap_access/bitmap_aip which track user-requested attributes and 
>>>> must
>>>> not be used to determine mapping state.
>>>>
>>>> Add bitmap_needs_unmap to svm_range, set when a GPU is given 
>>>> no-access.
>>>> Add svm_range_needs_unmap() to trigger the unmap once 
>>>> bitmap_needs_unmap
>>>> equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.
>>>>
>>>> v4:
>>>>   - Rename and set prange->mapping_done to false if validate and 
>>>> map not
>>>>     complete successfully (Felix)
>>>> v3:
>>>>   - Correct error handling, support app retry update mapping (Felix)
>>>> v2:
>>>>   - Add bitmap_mapped to not break get_attr (Felix)
>>>>
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 
>>>> ++++++++++++++++---------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>>>>   3 files changed, 73 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> index 9d4838461168..5d55407069a4 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> @@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct 
>>>> kfd_process_device *pdd, u64 addr, u6
>>>>           if (!prange)
>>>>               break;
>>>>   -        if (!prange->mapped_to_gpu)
>>>> -            break;
>>>> -
>>>>           r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, 
>>>> &gpuidx);
>>>>           if (r < 0)
>>>>               break;
>>>> +        if (!test_bit(gpuidx, prange->bitmap_mapped))
>>>> +            break;
>>>>           if (!test_bit(gpuidx, prange->bitmap_access) &&
>>>>               !test_bit(gpuidx, prange->bitmap_aip))
>>>>               break;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index df7fca65e9a2..e039b6f2942f 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>>> struct svm_range *prange,
>>>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>>>>                   bitmap_clear(prange->bitmap_access, gpuidx, 1);
>>>>                   bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>>>> +                bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>>>>               } else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
>>>>                   bitmap_set(prange->bitmap_access, gpuidx, 1);
>>>>                   bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>>>> @@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range 
>>>> *new, struct svm_range *old,
>>>>       new->prefetch_loc = old->prefetch_loc;
>>>>       new->actual_loc = old->actual_loc;
>>>>       new->granularity = old->granularity;
>>>> -    new->mapped_to_gpu = old->mapped_to_gpu;
>>>> +    new->mapping_done = old->mapping_done;
>>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>>> MAX_GPU_INSTANCE);
>>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>>> +    bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE);
>>>>       atomic_set(&new->queue_refcount, 
>>>> atomic_read(&old->queue_refcount));
>>>>         return 0;
>>>> @@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>>     static int
>>>>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long 
>>>> start,
>>>> -              unsigned long last, uint32_t trigger)
>>>> +              unsigned long last, unsigned long *bitmap_unmap,
>>>> +              uint32_t trigger)
>>>>   {
>>>>       struct kfd_process_device *pdd;
>>>>       struct dma_fence *fence = NULL;
>>>> @@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range 
>>>> *prange, unsigned long start,
>>>>       uint32_t gpuidx;
>>>>       int r = 0;
>>>>   -    if (!prange->mapped_to_gpu) {
>>>> -        pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
>>>> -             prange, prange->start, prange->last);
>>>> -        return 0;
>>>> -    }
>>>> -
>>>> -    if (prange->start == start && prange->last == last) {
>>>> -        pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, 
>>>> prange);
>>>> -        prange->mapped_to_gpu = false;
>>>> -    }
>>>> -
>>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>>   -    for_each_or_bit(gpuidx, prange->bitmap_access, 
>>>> prange->bitmap_aip, MAX_GPU_INSTANCE) {
>>>> -        pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>>>> +    for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
>>>> +        if (prange->start == start && prange->last == last) {
>>>> +            pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 
>>>> 0x%x\n",
>>>> +                 prange->svms, prange, gpuidx);
>>>> +            clear_bit(gpuidx, prange->bitmap_mapped);
>>>> +        }
>>>> +
>>>>           pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>>>>           if (!pdd) {
>>>>               pr_debug("failed to find device idx %d\n", gpuidx);
>>>> @@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range 
>>>> *prange, unsigned long offset,
>>>>               continue;
>>>>           }
>>>>   +        set_bit(gpuidx, prange->bitmap_mapped);
>>>> +
>>>>           r = svm_range_map_to_gpu(pdd, prange, offset, npages, 
>>>> readonly,
>>>>                        prange->dma_addr[gpuidx],
>>>>                        bo_adev, wait ? &fence : NULL,
>>>> @@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>           bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>>>>           bitmap_set(ctx->bitmap, gpuidx, 1);
>>>>       } else if (ctx->process->xnack_enabled) {
>>>> -        bitmap_copy(ctx->bitmap, prange->bitmap_aip, 
>>>> MAX_GPU_INSTANCE);
>>>> +        /* Update mapping on already mapped or access in place GPU */
>>>> +        bitmap_or(ctx->bitmap, prange->bitmap_mapped, 
>>>> prange->bitmap_aip,
>>>> +              MAX_GPU_INSTANCE);
>>>>             /* If prefetch range to GPU, or GPU retry fault migrate 
>>>> range to
>>>>            * GPU, which has ACCESS attribute to the range, create 
>>>> mapping
>>>> @@ -1719,14 +1720,12 @@ static int 
>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>           }
>>>>             /*
>>>> -         * If prange is already mapped or with always mapped flag,
>>>> -         * update mapping on GPUs with ACCESS attribute
>>>> +         * If prange with always mapped flag, update mapping on 
>>>> GPUs with
>>>> +         * ACCESS attribute
>>>>            */
>>>> -        if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>>>> -            if (prange->mapped_to_gpu ||
>>>> -                prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>>>> -                bitmap_copy(ctx->bitmap, prange->bitmap_access, 
>>>> MAX_GPU_INSTANCE);
>>>> -        }
>>>> +        if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>>>> +            bitmap_or(ctx->bitmap, ctx->bitmap, 
>>>> prange->bitmap_access,
>>>> +                  MAX_GPU_INSTANCE);
>>>>       } else {
>>>>           bitmap_or(ctx->bitmap, prange->bitmap_access,
>>>>                 prange->bitmap_aip, MAX_GPU_INSTANCE);
>>>> @@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>                   e = min(end, prange->last);
>>>>                   if (e >= s)
>>>>                       r = svm_range_unmap_from_gpus(prange, s, e,
>>>> +                               prange->bitmap_mapped,
>>>> KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>>>                   svm_range_unlock(prange);
>>>>                   /* If unmap returns non-zero, we'll bail on the 
>>>> next for loop
>>>> @@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct 
>>>> mm_struct *mm,
>>>>           }
>>>>             if (!r && next == end)
>>>> -            prange->mapped_to_gpu = true;
>>>> +            prange->mapping_done = true;
>>>> +        else
>>>> +            prange->mapping_done = false;
>>>>             svm_range_unlock(prange);
>>>>   @@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, 
>>>> struct mm_struct *mm,
>>>>       if (!p->xnack_enabled ||
>>>>           (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>>>           int evicted_ranges;
>>>> -        bool mapped = prange->mapped_to_gpu;
>>>> +        bool mapped = !bitmap_empty(prange->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE);
>>>>             list_for_each_entry(pchild, &prange->child_list, 
>>>> child_list) {
>>>> -            if (!pchild->mapped_to_gpu)
>>>> +            if (bitmap_empty(pchild->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE))
>>>>                   continue;
>>>>               mapped = true;
>>>>               mutex_lock_nested(&pchild->lock, 1);
>>>> @@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, 
>>>> struct mm_struct *mm,
>>>>               s = max(start, pchild->start);
>>>>               l = min(last, pchild->last);
>>>>               if (l >= s)
>>>> -                svm_range_unmap_from_gpus(pchild, s, l, trigger);
>>>> +                svm_range_unmap_from_gpus(pchild, s, l, 
>>>> prange->bitmap_mapped,
>>>> +                              trigger);
>>>>               mutex_unlock(&pchild->lock);
>>>>           }
>>>>           s = max(start, prange->start);
>>>>           l = min(last, prange->last);
>>>>           if (l >= s)
>>>> -            svm_range_unmap_from_gpus(prange, s, l, trigger);
>>>> +            svm_range_unmap_from_gpus(prange, s, l, 
>>>> prange->bitmap_mapped, trigger);
>>>>       }
>>>>         return r;
>>>> @@ -2112,10 +2115,11 @@ static struct svm_range 
>>>> *svm_range_clone(struct svm_range *old)
>>>>       new->prefetch_loc = old->prefetch_loc;
>>>>       new->actual_loc = old->actual_loc;
>>>>       new->granularity = old->granularity;
>>>> -    new->mapped_to_gpu = old->mapped_to_gpu;
>>>> +    new->mapping_done = old->mapping_done;
>>>>       new->vram_pages = old->vram_pages;
>>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>>> MAX_GPU_INSTANCE);
>>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>>> +    bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE);
>>>>       atomic_set(&new->queue_refcount, 
>>>> atomic_read(&old->queue_refcount));
>>>>         return new;
>>>> @@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>>> start, uint64_t size,
>>>>           next_start = min(node->last, last) + 1;
>>>>             if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>>>> -            prange->mapped_to_gpu) {
>>>> +            prange->mapping_done) {
>>>>               /* nothing to do */
>>>>           } else if (node->start < start || node->last > last) {
>>>>               /* node intersects the update range and its attributes
>>>> @@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>           s = max(start, pchild->start);
>>>>           l = min(last, pchild->last);
>>>>           if (l >= s)
>>>> -            svm_range_unmap_from_gpus(pchild, s, l, trigger);
>>>> +            svm_range_unmap_from_gpus(pchild, s, l, 
>>>> prange->bitmap_mapped, trigger);
>>>>           svm_range_unmap_split(prange, pchild, start, last);
>>>>           mutex_unlock(&pchild->lock);
>>>>       }
>>>>       s = max(start, prange->start);
>>>>       l = min(last, prange->last);
>>>>       if (l >= s)
>>>> -        svm_range_unmap_from_gpus(prange, s, l, trigger);
>>>> +        svm_range_unmap_from_gpus(prange, s, l, 
>>>> prange->bitmap_mapped, trigger);
>>>>       svm_range_unmap_split(prange, prange, start, last);
>>>>         if (unmap_parent)
>>>> @@ -3706,6 +3710,23 @@ static void 
>>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>>       svm_range_bo_unref(svm_bo);
>>>>   }
>>>>   +static bool svm_range_needs_unmap(struct kfd_process *p, struct 
>>>> svm_range *prange)
>>>> +{
>>>> +    if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
>>>> +        return false;
>>>> +
>>>> +    pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
>>>> +         prange, prange->start, prange->last);
>>>> +
>>>> +    svm_range_unmap_from_gpus(prange, prange->start,
>>>> +                  prange->last, prange->bitmap_needs_unmap,
>>>> +                  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>>> +
>>>> +    bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
>>>> +
>>>> +    return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>>>> +}
>>>> +
>>>>   static int
>>>>   svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>>              uint64_t start, uint64_t size, uint32_t nattr,
>>>> @@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>           svm_range_add_to_svms(prange);
>>>>           svm_range_add_notifier_locked(mm, prange);
>>>>       }
>>>> -    list_for_each_entry(prange, &update_list, update_list) {
>>>> +
>>>> +    list_for_each_entry(prange, &update_list, update_list)
>>>>           svm_range_apply_attrs(p, prange, nattr, attrs, 
>>>> &update_mapping);
>>>> -        /* TODO: unmap ranges from GPU that lost access */
>>>> -    }
>>>> +
>>>>       update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>>>>         list_for_each_entry_safe(prange, next, &remove_list, 
>>>> update_list) {
>>>> @@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>       list_for_each_entry(prange, &update_list, update_list) {
>>>>           bool migrated;
>>>>   +        if (svm_range_needs_unmap(p, prange))
>>>> +            continue;
>>>> +
>>>>           mutex_lock(&prange->migrate_mutex);
>>>>             r = svm_range_trigger_migration(mm, prange, &migrated);
>>>> @@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>             if (migrated && (!p->xnack_enabled ||
>>>>               (prange->flags & 
>>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>>> -            prange->mapped_to_gpu) {
>>>> +            !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
>>>>               pr_debug("restore_work will update mappings of GPUs\n");
>>>>               mutex_unlock(&prange->migrate_mutex);
>>>>               continue;
>>>> @@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>               continue;
>>>>           }
>>>>   -        flush_tlb = !migrated && update_mapping && 
>>>> prange->mapped_to_gpu;
>>>> +        flush_tlb = !migrated && update_mapping &&
>>>> +                !bitmap_empty(prange->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE);
>>>>             r = svm_range_validate_and_map(mm, prange->start, 
>>>> prange->last, prange,
>>>>                              MAX_GPU_INSTANCE, true, true, flush_tlb);
>>>> @@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>       }
>>>>         list_for_each_entry(prange, &remap_list, update_list) {
>>>> +        flush_tlb = !bitmap_empty(prange->bitmap_mapped, 
>>>> MAX_GPU_INSTANCE);
>>>> +
>>>>           pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>>>>                prange, prange->start, prange->last);
>>>>           mutex_lock(&prange->migrate_mutex);
>>>>           r = svm_range_validate_and_map(mm, prange->start, 
>>>> prange->last, prange,
>>>> -                           MAX_GPU_INSTANCE, true, true, 
>>>> prange->mapped_to_gpu);
>>>> +                           MAX_GPU_INSTANCE, true, true, flush_tlb);
>>>>           if (r)
>>>>               pr_debug("failed %d on remap svm range\n", r);
>>>>           mutex_unlock(&prange->migrate_mutex);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> index a63dfc95b602..0da635532aff 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>> @@ -100,6 +100,9 @@ struct svm_work_list_item {
>>>>    * @child_list: list header for split ranges which are not added 
>>>> to svms yet
>>>>    * @bitmap_access: index bitmap of GPUs which can access the range
>>>>    * @bitmap_aip: index bitmap of GPUs which can access the range 
>>>> in place
>>>> + * @bitmap_needs_unmap: index bitmap of GPUs which currently set 
>>>> NO_ACCESS
>>>> + * @bitmap_mapped: index bitmap of GPUs which currently have the 
>>>> range mapped
>>>> + * @mapping_done: true if range_validate_and_map complete 
>>>> successfully
>>>>    *
>>>>    * Data structure for virtual memory range shared by CPU and 
>>>> GPUs, it can be
>>>>    * allocated from system memory ram or device vram, and migrate 
>>>> from ram to vram
>>>> @@ -135,7 +138,9 @@ struct svm_range {
>>>>       struct list_head        child_list;
>>>>       DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>>>>       DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>>>> -    bool                mapped_to_gpu;
>>>> +    DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
>>>> +    DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
>>>> +    bool                mapping_done;
>>>>       atomic_t            queue_refcount;
>>>>   };
