Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A896BCA600E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 10:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2809210E772;
	Thu,  8 Oct 2026 10:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pV6KfTsa";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E420110E6DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 10:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtDQXGBWr36IiYGvg37WQxjitVqVGmrZaXwqvT2FlXYbX/3nLYJZtb4u9KyCCSzDnRrdDIdbYtAHWraSs7CcaGMBQUniZ36/VUxsbpG4DM1XOCpFfGJZ4C2vX8f3ZlVOvAu6OfKV6eslkjweg5+jMD6ywIQXEiVK5YQbCO9Z+kS24p51Zke6HOLMrxsZG0damxK7faTq/S0quOX5hTCy0W9tABEM8jWJAU8NYx3X8vvQKlUZxEaWrxStHbv6KjhOC7wvxmQ14JB4GE3LrKa8JqC0Z+tRS74PSVNGfvv0uFx0kpqsZXMaJkdW5zO7aZZikAdRvpQBzf/3mWVl0cRZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBd9ybvY55M/95fIJJcMclR8JPrQ4X/MANkQ/YXxQdE=;
 b=VWYC5V0SkJmAXZMVnZ4HvcDtCKKJ1ly7bcGGth9YSSvu7jAVMpOtcoMZwDSGv+CdBKHe3Ymfs9QCSTTeqxo6JgEW5MkixwRrrK78LSeeqmYqi0/je9gNhVqpERyJJ1WzVyhP0afhcvaLQB1/aOlPsSMgYuznJv1DJ14QMDAKIqNlGZ9Pmy3tUloSJ67QYU02R4BBqiRBpzduytyoML/b0OdMOqbz0hZjQh1A7gZx5p3DWPoPDbfbmZAM5X70fxf0jOnHvJLMZVaap9fT6EIY/cJhahQe7+q9lgEpNB9HqIxVsrx6qy7WfxtHVVE7Wc5k8g9VLvViGCurNp1e6jnjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBd9ybvY55M/95fIJJcMclR8JPrQ4X/MANkQ/YXxQdE=;
 b=pV6KfTsaOy91mI1A0hN9+ICH93xmrW+4XI+mkypM2FtmpPlDZC05aI3i3VzaeyPBhZdipHmptIBrYWxcmbvGULGXlI7E3BUKji0aDvuK15eHHdpetnSNXKMHDd70idWYm0gSevPqG5FrbpyK0Zh32FRlsTXTrEncXvi/caar+tc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CY0PR12MB177289.namprd12.prod.outlook.com (2603:10b6:930:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:13:13 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 10:13:13 +0000
Content-Type: multipart/alternative;
 boundary="------------00nULXvyKSrBmIw6ePHqdbAt"
Message-ID: <fa2eb8bb-7f31-4afc-b356-24ea7e35a25e@amd.com>
Date: Thu, 8 Oct 2026 15:43:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: rename first_kfd_vmid to
 first_userq_vmid
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261008065234.2945047-1-sunil.khatri@amd.com>
 <592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com>
 <e1780cde-9ff2-46f3-b722-ee02b18d1ddc@amd.com>
Content-Language: en-US
In-Reply-To: <e1780cde-9ff2-46f3-b722-ee02b18d1ddc@amd.com>
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CY0PR12MB177289:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ede788-afdb-4e18-3d89-08df2524c2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|10067099003|8096899003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: JKIywHIWzc/ZXG5Y884RjfPSyAg5tmU6tyAY0NEc7lHfJIx6NmQs2Yt2rBCBTHXm+FJsiAezAoRtSvCdHjNHj7RNWR8HKYchSb3plfPdK6iYZpEvC/JrNXhKjDeGPoXfnpmEbRWpsiUKN6O33Moxyk5EYxH61rUTBJMU3GxIFGDKKCrXf3bDRpZt6jqauiBcoYeyn5P1hEEXmqQE9KM3itEMQsei79jG+QGBUfpnvA6LMHpwzeaTu4y7n2HRpSbNl5kBucqTub6W7FCxCJkjxNTQ+wODNSQyMcDFW6x0I1hAgu6AqnpAjg0v/Aa5BKh8GtevadAR0QHmFgIA8y4igaDN6qPi9dbiPrNtDnSEmiDWEoyZQwfID0exRn7r58MnE4b5qyJyA9aiK7j+ag8jmYxqesa/qWFRadN0ZFE0QPBHs4KMzC80v42KtZO62bzJ9a2TVsYgcCR/dHCFqJbbSDxTg6q4RNb+i33DuQac3bUwtpJ7g1OgX9sGkLvBx3kwS8+Od/lERueuVQFmgW/jnWuns/LyvtAHgNlzZIesLzOAphIudiIzuWt00ShfPRPbsQX+RXD+v3chk/B0tUqM4CVe5THWZ7wyvetfUtjjWAWZ0YPtWiL6WTNLx6ahPmeiinp0lDl25EBtZQOK0e19Zz5ELtq9gORgasoscqanhJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(10067099003)(8096899003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdmM2FEVW9kbU1hQ2w3UldLVDdqeTBNWEZPSEpIcVZGSE9SSXNKNXN3OFlX?=
 =?utf-8?B?SmpSU0NQOU80dE5RbFBHeWlyb0xleGRHdVRkWkZLeVMxZ1Myb3NoTllkSG9F?=
 =?utf-8?B?TVFLZHo2NVFKeDFTdFdCVkRKbk1RUVBaTWVycW1ZOWZuTVN4Skk2UzRTZnNk?=
 =?utf-8?B?ai9SU2k4OXNha0w5MUdDcXMzWkJWZEp5QmdsVkpKWWljeXI0NS92MnpNY1k2?=
 =?utf-8?B?R0RjZGh1NEhaeDk1bFg0bTN1NXN0S2RWMUpndUNRL1dybktidWNUc3VDYmdR?=
 =?utf-8?B?SmdTQXpMWGhHajBNQlpLZWZoV1YxQWppZmkzMTRXZ2l4S1dRR1FhVmc0RWp2?=
 =?utf-8?B?Qm1GNHdHQ2ZGYkV6eXFSeUNsK3FPajhGUFVXSEdGN2d5cDBnYjdmR2RrcCs1?=
 =?utf-8?B?WThTWEtTV1BOVlJ0c0toY1UxKzFhbCsrNHkrcUlnYTYyc3FEUmFtM2dnc2w0?=
 =?utf-8?B?ajVJT1psRzcxT21hZFkvMmVsOG1JRnlHYzRWMFZFZk91NVVnckF4L1VyVTZW?=
 =?utf-8?B?M2Y0cmJISUxJWnoySThteGNmRUpJRGQwZU11TzBEQlJkSTgzdFRJSjRqclRG?=
 =?utf-8?B?M21mYmhBaStHSHhBVms0VDJTaWwycW01azZkQU1FWU9TeThhS0hsSjl2T1Vv?=
 =?utf-8?B?WGJaVE5LNVovVThpN3c4MUF4ZjR5bjNVdjZiUHo1ak0zWWlWVVlzaThhNXl4?=
 =?utf-8?B?Zk5ka0thK3kyNUdZYXZTNGpaS0c3SjB3MnFabEpRcWc5THBaeE93Ti9QTGJB?=
 =?utf-8?B?eE9FVHhEQ3cveEk1WDBUVWdtTVlyQkE0MVQ5WmNJVE5aekV6V2pHRitKdEd5?=
 =?utf-8?B?a3Fwc2FPYkt4UkllTnJPOEZPUmZ6aWFtM0RBYXVKNUhmQVlNdk9MNGdEM1M5?=
 =?utf-8?B?Ujd3QnlhRG9jK3kvMUFZSGF5WG13K0JwSkV5TzQzcGs2NHlCZlpRMkxFMG51?=
 =?utf-8?B?ZUtqMENlQ3NRWG9GWENWNEc4WFdsOE9RdUYxd2NzSkd3OHdFcHNLK0hXUlhp?=
 =?utf-8?B?eGtNMG1YL1NKRk9URjRHN0g0K3RFblcvb0M0RHE2VlVPZ3ZrZnp3enNJZGZC?=
 =?utf-8?B?UXNPR1U0NVpaQVRObkJnSUJVZ3YrZ1gzMEQwZ0RZTUFSS1lqYlB2VW1HK05J?=
 =?utf-8?B?T1V0R24xelBYTGhLMTR0ZEVSYVk3SGF4OFBxT1NoUVU0RzI5VTlBemlsaU5Y?=
 =?utf-8?B?Z3dwU0daUFB2c25qU3R6MWxiOUprR2J3VEhtZC9EN0RtVWFmcGI5TUlDRjdT?=
 =?utf-8?B?TjhQM2NBWktRZk9BZ29LalM3UlBWSVZ2RzVicjJUWUZlMG9JbXR2cmFTZ0tF?=
 =?utf-8?B?Zno0c3N3S0QyeTBvOEZHaFoyaWFEYzBuK3JuRW5BbDBKR2pnVE5QSEVEQVRX?=
 =?utf-8?B?Y1UzVWh4cWdsMm9XSGJaZ0pCTldFUHdEVTgzVGNHSVZSZ0V1blc1NEdYMVly?=
 =?utf-8?B?K05OTDhPSWlYZW1aQXU3Mjh5bHZOZER5ZnBVbVpJMFFyMFNOaDRJeWZlZThV?=
 =?utf-8?B?ZWd3S3NjbTQzR2V3dEVGTW5hMHpSNG0xMWJpSVRNVWNzcDJCSTFFK2pFVnpH?=
 =?utf-8?B?eFBjbkRFbEhoS3B4emU5V29TQVhpRkYzY2dHMlRoQjZBODcxUi80YkFVdUFX?=
 =?utf-8?B?TmROUzNaTHdtQlVlN3VaMTRLVTlrdzZDUEtPQnJTQ1NBREl4MDBZUitIR0cr?=
 =?utf-8?B?RlNMZWlHdWtMR3RtckFDRno5Vk1FSjdCWHk5VWFkdElaSXp6TFhCNlpYelBR?=
 =?utf-8?B?QlZHZmhBSVlmR2RVWm9JSXZxNkVxZ1lkclM0MzNTaWJRdVNjQzJsY1VaRVNq?=
 =?utf-8?B?QTRJWUhHTjhZRkMxaFJ3TkhzbE41RHV2NkpvUmJqQlhxWkZRenRWcjY2ZFJT?=
 =?utf-8?B?UFlWTXNQZG9XSmh4K3FMMXhLNkZwQzB1ZUxvS3hsVXgzOGhnNEpSL3FIVnBE?=
 =?utf-8?B?cWpYT2VOUGVlUSt5UE9DSURFbWRFMjlGRmlPVXJvb0FMNFhZY1dQeVhwVUND?=
 =?utf-8?B?UHpUend3NUovcUp0WEdtdHVWYkZXN0RtekJ3V1g2YVVmZ3JpcCtCTU9xODlr?=
 =?utf-8?B?MlczanFxdXhPUFBlL2tMalV1V0tnT240Q211MEJYRGxobDBnVXpUUGJnemJO?=
 =?utf-8?B?dG9WQmhjUlZvVVBPbi84L1dNUUFKTVJ2dkhZZzBMRkN1L0FGaXBVcmJSb2VB?=
 =?utf-8?B?ZWt1NmcvdDdyeFQweHQ2K0Q1SWFSZ0lFV1U4WFFVcjRlSG9ELy9GMWJnNWdO?=
 =?utf-8?B?WFNBTGVlcHBYTWp0VEh2S3ZVMTJ0aGd5ZElHYjBFcUthNXUxVzRIYmZSU2VL?=
 =?utf-8?B?aTVYZ3dSd2RmWktVTVAzZS9WT1JNbnV3UlVWbTFxNVpHSUJOR015UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ede788-afdb-4e18-3d89-08df2524c2e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:13:13.1985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kYkwHdPcnLipGmfKMeZqMjdDg7PA35F6kiLuyKV9PbtqMc/TWvQg1xAPaRFwzgooJ26kgpZ9LX4Uu4oHehxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB177289
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

--------------00nULXvyKSrBmIw6ePHqdbAt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08-10-2026 03:36 pm, Khatri, Sunil wrote:
>
>
> On 08-10-2026 02:45 pm, Christian König wrote:
>> On 10/8/26 08:52, Sunil Khatri wrote:
>>> The boundary VMID is shared by KFD and KGD MES user queues alike,
>>> not just KFD, so first_kfd_vmid is a misnomer. Rename it to
>>> first_userq_vmid. Pure rename, no functional change.
>> I would make that a mask as well in the same patch.
>
> Do you mean me to merge patch 2 with this?
>
If you mean to use the mask instead of the variable... I did not use the 
mask directly as in various places in the code the vmid value is used 
lets say for a for loop etc..

Using mask will add on additional calculation of "vmid no from the mask" 
every time, just to avoid that additional calculation i continued to use 
this variable... and its not one place but many places

Regards
Sunil Khatri

> Regards
>
> Sunil Khatri
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
>>>   18 files changed, 42 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 3391e8c77f13b..38eef8e7155aa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>>>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>>>   {
>>>   	if (adev->kfd.dev)
>>> -		return vmid >= adev->vm_manager.first_kfd_vmid;
>>> +		return vmid >= adev->vm_manager.first_userq_vmid;
>>>   
>>>   	return false;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index 9cdd8870960a6..d2414b4656805 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>>    * @adev: amdgpu_device pointer
>>>    *
>>>    * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
>>> - * first_kfd_vmid, shared by KFD and MES user queues.
>>> + * first_userq_vmid, shared by KFD and MES user queues.
>>>    */
>>>   static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
>>>   {
>>>   	adev->vm_manager.vmid_uq_mask_gfxhub =
>>>   		((1U << AMDGPU_NUM_VMID) - 1) &
>>> -		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
>>> +		~((1U << adev->vm_manager.first_userq_vmid) - 1);
>>>   	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>>>   }
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 8e478d3bda1ac..4c407d705d0c0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -383,7 +383,7 @@ struct amdgpu_vm {
>>>   struct amdgpu_vm_manager {
>>>   	/* Handling of VMIDs */
>>>   	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
>>> -	unsigned int				first_kfd_vmid;
>>> +	unsigned int				first_userq_vmid;
>>>   	bool					concurrent_flush;
>>>   
>>>   	uint64_t				max_pfn;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 33403e16df5ca..cd1f01604c4b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		nv_grbm_select(adev, 0, 0, 0, i);
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>>> @@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	 * access. These should be enabled by FW for target VMIDs.
>>>   	 */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>>>   	}
>>>   
>>> -	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
>>> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_userq_vmid,
>>>   					AMDGPU_NUM_VMID);
>>>   }
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index d5f428ac19bf3..7d66f41aa8957 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   			SCRATCH_APP_BASE;
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		soc21_grbm_select(adev, 0, 0, 0, i);
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>>> @@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	 * access. These should be enabled by FW for target VMIDs.
>>>   	 */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 420ce997bebc7..9245fc1c95767 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   			SCRATCH_APP_BASE;
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		soc24_grbm_select(adev, 0, 0, 0, i);
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> index 4498e253846f1..4b7f90fa203b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> @@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>>   	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index 549d1239e326b..0bdb800dafc64 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>>   	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		cik_srbm_select(adev, 0, 0, 0, i);
>>>   		/* CP and shaders */
>>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>>> @@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   
>>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	   access. These should be enabled by FW for target VMIDs. */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index ab4123ddbb942..403ed29e7c0b1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		vi_srbm_select(adev, 0, 0, 0, i);
>>>   		/* CP and shaders */
>>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>>> @@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   
>>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	   access. These should be enabled by FW for target VMIDs. */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index 1678015ce5a97..231dacdf16548 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
>>> @@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>>   
>>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	   access. These should be enabled by FW for target VMIDs. */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>>> @@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>>>   
>>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>>>   		gfx_v9_4_2_debug_trap_config_init(adev,
>>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>>> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>>>   	else
>>>   		gfx_v9_0_debug_trap_config_init(adev,
>>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>>> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index 01ed1701c781a..1479dbc20c706 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>>   
>>>   	mutex_lock(&adev->srbm_mutex);
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>>   		/* CP and shaders */
>>>   		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>>> @@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>>   	 * access. These should be enabled by FW for target VMIDs.
>>>   	 */
>>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
>>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 490b4c4eb662a..259aca57a3ec0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>>   	 * amdkfd will use VMIDs 8-15
>>>   	 */
>>> -	adev->vm_manager.first_kfd_vmid = 8;
>>> +	adev->vm_manager.first_userq_vmid = 8;
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 3cdc7893587a1..daec00725b969 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>>   	 * amdkfd will use VMIDs 8-15
>>>   	 */
>>> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>>> +	adev->vm_manager.first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
>>>   
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index fcc1d580fa946..f3e9759833b77 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 */
>>>   	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>>> -		adev->vm_manager.first_kfd_vmid = 3;
>>> +		adev->vm_manager.first_userq_vmid = 3;
>>>   		adev->vm_manager.npa_vmid = 15;
>>>   		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>>>   	} else {
>>> -		adev->vm_manager.first_kfd_vmid = 8;
>>> +		adev->vm_manager.first_userq_vmid = 8;
>>>   	}
>>>   
>>>   	if (adev->gfx.disable_kq)
>>> -		adev->vm_manager.first_kfd_vmid = 1;
>>> +		adev->vm_manager.first_userq_vmid = 1;
>>>   
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   
>>>   	amdgpu_vm_manager_init(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index 71409eb718d39..2fb3b0687ab70 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>>   	 * amdkfd will use VMIDs 8-15
>>>   	 */
>>> -	adev->vm_manager.first_kfd_vmid = 8;
>>> +	adev->vm_manager.first_userq_vmid = 8;
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      true);
>>>   	amdgpu_vm_manager_init(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index c95e097241bf8..1208822b6ef8d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>>   	 * amdkfd will use VMIDs 8-15
>>>   	 */
>>> -	adev->vm_manager.first_kfd_vmid = 8;
>>> +	adev->vm_manager.first_userq_vmid = 8;
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      true);
>>>   	amdgpu_vm_manager_init(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 8d8a0775878ff..b21dc8fc6a9a1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>>   	 * amdkfd will use VMIDs 8-15
>>>   	 */
>>> -	adev->vm_manager.first_kfd_vmid = 8;
>>> +	adev->vm_manager.first_userq_vmid = 8;
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      true);
>>>   	amdgpu_vm_manager_init(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 85ba228f002d0..f9d2e82c34793 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   	    adev->jpeg.disable_kq &&
>>>   	    adev->vcn.disable_kq &&
>>>   	    adev->sdma.no_user_submission)
>>> -		adev->vm_manager.first_kfd_vmid = 1;
>>> +		adev->vm_manager.first_userq_vmid = 1;
>>>   	else
>>> -		adev->vm_manager.first_kfd_vmid =
>>> +		adev->vm_manager.first_userq_vmid =
>>>   			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>>>   			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>>>   			 amdgpu_is_multi_aid(adev)) ?
>>> @@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>   			8;
>>>   
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      false);
>>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>>   				      true);
>>>   	amdgpu_vm_manager_init(adev);
>>>   
--------------00nULXvyKSrBmIw6ePHqdbAt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08-10-2026 03:36 pm, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e1780cde-9ff2-46f3-b722-ee02b18d1ddc@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 08-10-2026 02:45 pm, Christian
        König wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com">
        <pre wrap="" class="moz-quote-pre">On 10/8/26 08:52, Sunil Khatri wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The boundary VMID is shared by KFD and KGD MES user queues alike,
not just KFD, so first_kfd_vmid is a misnomer. Rename it to
first_userq_vmid. Pure rename, no functional change.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I would make that a mask as well in the same patch.
</pre>
      </blockquote>
      <p><span style="white-space: pre-wrap">Do you mean me to merge patch 2 with this?</span></p>
    </blockquote>
    If you mean to use the mask instead of the variable... I did not use
    the mask directly as in various places in the code the vmid value is
    used lets say for a for loop etc..&nbsp;<br>
    <p>Using mask will add on additional calculation of &quot;vmid no from
      the mask&quot; every time, just to avoid that additional calculation i
      continued to use this variable... and its not one place but many
      places</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:e1780cde-9ff2-46f3-b722-ee02b18d1ddc@amd.com">
      <p><span style="white-space: pre-wrap">Regards</span></p>
      <p><span style="white-space: pre-wrap">Sunil Khatri</span></p>
      <blockquote type="cite" cite="mid:592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com">
        <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com" moz-do-not-send="true">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
 18 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3391e8c77f13b..38eef8e7155aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
 	if (adev-&gt;kfd.dev)
-		return vmid &gt;= adev-&gt;vm_manager.first_kfd_vmid;
+		return vmid &gt;= adev-&gt;vm_manager.first_userq_vmid;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cdd8870960a6..d2414b4656805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  *
  * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_kfd_vmid, shared by KFD and MES user queues.
+ * first_userq_vmid, shared by KFD and MES user queues.
  */
 static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
 {
 	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
 		((1U &lt;&lt; AMDGPU_NUM_VMID) - 1) &amp;
-		~((1U &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
+		~((1U &lt;&lt; adev-&gt;vm_manager.first_userq_vmid) - 1);
 	adev-&gt;vm_manager.vmid_uq_mask_mmhub = 0xFF00;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..4c407d705d0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -383,7 +383,7 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
-	unsigned int				first_kfd_vmid;
+	unsigned int				first_userq_vmid;
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..cd1f01604c4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES &lt;&lt; 16);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 
-	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.first_kfd_vmid,
+	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.first_userq_vmid,
 					AMDGPU_NUM_VMID);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d5f428ac19bf3..7d66f41aa8957 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc7..9245fc1c95767 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4498e253846f1..4b7f90fa203b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..0bdb800dafc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED &lt;&lt; SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..403ed29e7c0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..231dacdf16548 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
@@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 		gfx_v9_4_2_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev-&gt;vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev-&gt;vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..1479dbc20c706 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
@@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 490b4c4eb662a..259aca57a3ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a1..daec00725b969 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
+	adev-&gt;vm_manager.first_userq_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fcc1d580fa946..f3e9759833b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		adev-&gt;vm_manager.first_kfd_vmid = 3;
+		adev-&gt;vm_manager.first_userq_vmid = 3;
 		adev-&gt;vm_manager.npa_vmid = 15;
 		mmhub_vmid_mask &amp;= ~BIT(adev-&gt;vm_manager.npa_vmid);
 	} else {
-		adev-&gt;vm_manager.first_kfd_vmid = 8;
+		adev-&gt;vm_manager.first_userq_vmid = 8;
 	}
 
 	if (adev-&gt;gfx.disable_kq)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		adev-&gt;vm_manager.first_userq_vmid = 1;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 71409eb718d39..2fb3b0687ab70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c95e097241bf8..1208822b6ef8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8d8a0775878ff..b21dc8fc6a9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..f9d2e82c34793 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev-&gt;jpeg.disable_kq &amp;&amp;
 	    adev-&gt;vcn.disable_kq &amp;&amp;
 	    adev-&gt;sdma.no_user_submission)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		adev-&gt;vm_manager.first_userq_vmid = 1;
 	else
-		adev-&gt;vm_manager.first_kfd_vmid =
+		adev-&gt;vm_manager.first_userq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
@@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------00nULXvyKSrBmIw6ePHqdbAt--
