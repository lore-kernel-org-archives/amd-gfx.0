Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1435FC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 20:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6373A10E0A0;
	Wed, 28 Feb 2024 20:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FafKSYv8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A9710E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 20:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR75rUgaT32wO00N12DrTsBZWnpdbz1MB2ztOKKXDNE8dH/VqXqr5PWtvlV/UXJ6QFXDj+lhlFNlZYnZ/wLC3+/M6bqILzjbsSG8kJu8iqHxQNlon1FY5vErT7r/ztVr03Ef8K0Rm10PZOtu3cB+oY9Z+2HEQT933XnR4UKKoGh1M2wJs/lXnH9RgQtrL8Ep2mWzd/54z4MYoBtXR+i3oVKjPm1fn5yvp7NPmS+y8/JclkpcBwJHQcipz1ddPcOBkE8xfBFYGrTp8xqNVS8XW/afuDT1Syts9nzkb7xZWMqBol/3b3Zwh6uLDZBm89/LR61K3j5TYuWz2poO4U76qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TJRwAcfdAcVmHavIvYuNgmGc8jOPfTcl+p7zqkKjU0=;
 b=Hnj6BbEuWIQGHEjs4HH20bxC4N8hc4D6tAcQDp3rHyiZgBfwVC4ARFNbK/WMpJ7FoigOqx55CA9Bv+SIJZz9A5FZqg3LMFQgYSditkOtQ5CbtpmMowQUtWiQ9a37mQH0dvMTo+ecGuWow8gw71jWvV0goGK4tw8CNCuFRPvSxt+MEZYZ2MS3mdCou5frjqwr5iYgzLB3Fm6lClU2cdem4jun4QZbkS3GtnySmfxirdSXOk/RDYHLHA5O/Rdogxx0AQ5IGMJtiVebAd+a61WMVaTbdpW3860ovM6s9a/Im0UjqgcDN/FbSpKQdo1QzB+EkNWABU5+qf8zdLBLe+hH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TJRwAcfdAcVmHavIvYuNgmGc8jOPfTcl+p7zqkKjU0=;
 b=FafKSYv8LFiP9emvM1Msr1UrjSj+wP5ikKFiZpf9oaHq4J8u2j4AKHN43C7a1dW7bb23+MuwNoH9yuPj3TDG4HAT4ZtxSZjPeLQCLgoi1PCcDC6UmpIgGi+LsxZvz4CdtkHE9w1V3RzS15iLnoJpWIGozDnbOkUa1L//tSxFUB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 20:48:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%6]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 20:48:26 +0000
Message-ID: <e9316e00-b35c-4031-adbc-13d8770e1e28@amd.com>
Date: Wed, 28 Feb 2024 15:48:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Yifan1.Zhang@amd.com
References: <20240228050446.89436-1-Jesse.Zhang@amd.com>
 <b49d2f47-6e24-4c42-9a49-a65cca59fcc0@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <b49d2f47-6e24-4c42-9a49-a65cca59fcc0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd2747f-54ee-4e4e-b90c-08dc389e9c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYtMm/HRyzCZDCcEgPO44qa4QtoHePsyIYFfdwIQbDDu2lU+WJ0Qz550GMh7w02tPHQLUPPJHyXYxQcwnqqu15B5yksI8a4R0QJYW/EhJs/7dLChI7Jybx2bXoJLS6+NsNgzomZqyztqg51ngd+owsLdiA14VyX0/soNab3a7K1B4/WHouj0mS/ea7/isGJmErHGM3AS2x+FGs07uqoJvZS87OJSuwEv6jYXi8lBu94hykpTVsl9UPlcS+eYjbKV6CAEgUhC21BVlBySIsikVPnVZaitLwkkHG5HXxXFAs3Dc9rB06vdnq9EjY6hpF7eMfOTTTwy9k8HWqQW9f2Lzuuv4QhJ7jOW37AiyntK/EdLtWxe9reDNRfw9VfC2/9J3CGhBn1xJmQvuWX/PBP8D/LEuPefBxPEAcRX6aFZpEvRWRWsCylSXdoBQ30y1z2VOKdKcBfqI9lIqlZQHZJns6X+eKrb159Grq/81sxCJfrPpEQVk9JxUKPobtRCkmuDOlfxwlwUQyvrjKh+ss6B6BZy5nSgnt0kKgWCD3/TdaxsHI1BgXeLtrvOGLsmpmL/K3CeWraq6Js9tnFw0DvJq8fXTDQrWCaZGMlPaoNBseds3vZHUAl2TL8UAIhQCE3lJrWqs0Rdi5aVxe74gEmkWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtRb3c2cm96azhGcVo5VXBTdFRVZzdIc0ttS2NuVFAvenE3YVg4c2ZXaHlT?=
 =?utf-8?B?WkZGTUZmZ0hYenI1YkxGZWJDME5kc0N6RDJlQStKVWRZTDRGbkdrb2xsSlB3?=
 =?utf-8?B?VDZxRy9Vdk5SbE8zQnByQ2k0NElKdlF6Nm9WMFVRbmlFUXNXa3JsSlVhQXdq?=
 =?utf-8?B?eU9mRUlQQjVNTnlzbDUrRUJVaVRDTE9TTGEvZjVkekhNTll4akVtTXNaRGJu?=
 =?utf-8?B?T0lEVzdOVWxpS25aR0JOQ2xLYW5qcGg1eEpWY3J1ekVCeVNGcms3YW1MY0ta?=
 =?utf-8?B?dDlsTFJCN1hRREZ0YndwSzhzS2lwK0h6WTl5R1MrYTYxZ1lhSGdsMlNHeC9S?=
 =?utf-8?B?aGNnUkl2TElVWXFnR3VYczQ3TGdldGkzSUtwYTQzSml4cXpFUWRsNGNPdmpB?=
 =?utf-8?B?clNRcDFDMnNwMm9zbVZZZ0VZbmFuL3dTNFdScUFFR2Q2d2YySGJRNTFLOGlS?=
 =?utf-8?B?QjVLTkdMRFdQemgva0NDQ0p3dVNVV2dJK2FXY3VEdWxXcXo0bkpFWHRZbHo4?=
 =?utf-8?B?VjNqK0lsV3JubFpSQld0TFNxc2I3Z1JzOTVKN1ZveXJYKzNpUWVTMUZxWDIw?=
 =?utf-8?B?WFFoV2FZcXhtWDZJRzJaK2Z2OTkxMVRlS25EUi8yZCtZRkU1VDZQMEJ6Z0xH?=
 =?utf-8?B?TUhnSWRiTFhQTG1Dd2xNb013WGF6TTJwQTF3UmVMWkdRV1lWeXJyUC9JejdG?=
 =?utf-8?B?WUpsN1RhWUpGcUV1RVJzTzVQSmRwSk1CVjhjZ3JNd0VjQ1RrdXI5N25WY3U5?=
 =?utf-8?B?cjBXVC90N1o4MjNxNy8yUUU5MlJjbHQvMkJpbXdqSy81eEkxNjlZRmlYV21F?=
 =?utf-8?B?U1FlVGErODdTa21WQ1N3ZHdNUXhFUjdaUlVDd1I2T0l0dXpqMlhzZFNhd1U2?=
 =?utf-8?B?cmNka2ZpWnlQc3l3aUM5NGMvTDhZaHNoaEVPWGFXbVJpcU1lcERUUFBNVmFn?=
 =?utf-8?B?WEJNUFRCM1V3cWsreVpKOGU4N21HSnhYVWJXY2FhWEMwSjI0YTJndDlKRkQw?=
 =?utf-8?B?MVVSN2RZQnE3Vm0zQ001blBPeWJEazlGMU5semZ1SVNWRVhPc1h2anFkSklI?=
 =?utf-8?B?TDlpREE4dEV6UGNtWUVESWRTUi9aQ3pKc1ppbi9MaExIQU1aTS9SZ1AwcGZo?=
 =?utf-8?B?czY4TnlmS3N1V1FuZUZuNjd0RXYvbnFna3BxanpkSG1WSzhwcThwU2RxL3hl?=
 =?utf-8?B?YnczQnJ3RG9NaHFneUsyZGhHWXBnZFhOZWtzaHljb1g3KzdWeWF2TTc1empv?=
 =?utf-8?B?VzNHL3R4Vm5Gbk5UcnAzWEVMc2dRVldiVU9maWFhWk9ZK1FiZi84UGcvTnZB?=
 =?utf-8?B?SGtJOS9lanlibUdDTW51bGJBSGtacmR6MTB2cnBBN3ZweGc5SG9YcnQwbGFI?=
 =?utf-8?B?Mk9KSStZMFk1Y295ZkVRUjdFc05rWC8zcXJWR2hrQ0FrelBsTG9CYkJiMys3?=
 =?utf-8?B?M2JsL1hGbHNWNCs2YjFkU1U5NHBqekdET3BTRDczWEtYVDYyODh1RGM2by9i?=
 =?utf-8?B?eG5lb3dhU2VrcEdCSThpNnhmL3IyU1d6MFJ6eHNDT2xTTWZCclJoRDliNml1?=
 =?utf-8?B?NVdVYzgyczFsVEhwcmNQWUZndzB6ODJEWXI0aFRlanZKRXIyVWYzYmdaS1dE?=
 =?utf-8?B?WlJDd3ZxL3lrcUJ1WDhZcm5MazVwd3QxVFNzTjBaSHNBdGlmaEJwUWNVYXB1?=
 =?utf-8?B?ZXd1ZGd6eE1MS3oyR0R2L1V4K1Foc3dhYTcybWJXVnFkdDFOSU5TZEVNYmc1?=
 =?utf-8?B?Q0l5VzZyYlBHamJ4WTZQRHRyZ0NaaE9PN3lKa1ZjWGkwaXQyOUxNV0RZa3o4?=
 =?utf-8?B?THVFWmFLRzNyNlFTZGpWbDlXajFSZlZJc0NWSWxTeGxJcWJUd0ZrZEtyRGNm?=
 =?utf-8?B?TFQycURkQUlKSkJYeDhUa2JkWVF4cXlzSWhVL2Ixbjd2a1c4QkhqNmNPOTN1?=
 =?utf-8?B?a1pVMFJ4UUE3QTNDUzJsYyt6Nkg3a0tjUWhHMzFSYzZIaUQ4Q3RKelNuVFhq?=
 =?utf-8?B?LzFtOGFvV1NpN3JweEIvazRRTUgyQWZNaFFBT2l1WWd2U1JrU3YrdGFaSjE5?=
 =?utf-8?B?enl1ajBTeWpTdXdNSDNMT0JBYTMrelQzS0E2R2w2MnRBUG1EVjRYN21kRFU0?=
 =?utf-8?Q?YVHUyQVfMIillm56EobH/J+uH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2747f-54ee-4e4e-b90c-08dc389e9c5b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 20:48:26.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq2zTy8hhv1+sBEuxZyROFRZLQKbTvSQZ3eCrJHAbG68cixtr94uSO557xADC8XuKIPnKpIeFyOwN2KoBPcWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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


On 2024-02-28 01:41, Christian König wrote:
> Am 28.02.24 um 06:04 schrieb Jesse.Zhang:
>> fix the issue when run clinfo:
>> "amdgpu: Failed to create process VM object".
>>
>> when amdgpu initialized, seq64 do mampping and update bo mapping in 
>> vm page table.
>> But when clifo run. It also initializes a vm for a process device 
>> through the function kfd_process_device_init_vm
>> and ensure the root PD is clean through the function 
>> amdgpu_vm_pt_is_root_clean.
>> So they have a conflict, and clinfo  always failed.
>
> Big NAK for this, you removed the check but didn't solved the problem 
> in any way.
>
> When Raven still needs the ats feature than it is intentional that 
> this fails.

I agree. I think we should just remove all the pte_supports_ats stuff 
from the amdgpu_vm code. We no longer use IOMMUv2. So there is no point 
setting invalid PTEs to fail over to ATS any more. As far as I can see, 
this will require changes in amdgpu_vm_clear_freed, amdgpu_vm_init, 
amdgpu_vm_make_compute. Then you can remove amdgpu_vm.pte_support_ats 
from the struct and remove amdgpu_vm_pt_is_root_clean.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index ed4a8c5d26d7..0bc0bc75be15 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2361,12 +2361,6 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>        * changing any other state, in case it fails.
>>        */
>>       if (pte_support_ats != vm->pte_support_ats) {
>> -        /* Sanity checks */
>> -        if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>> -            r = -EINVAL;
>> -            goto unreserve_bo;
>> -        }
>> -
>>           vm->pte_support_ats = pte_support_ats;
>>           r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>>                          false);
>
