Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490DACA5FA7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 17:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F8910E18B;
	Tue, 29 Sep 2026 17:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zC7SbKU4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3AD10E18B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 17:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/zKCiq+BD6BSgenlSgoigA9ibRgiJUxLwqxmqlTFhoI/s+Mmpb8EY1e830ETIH0jG9l0Jdd63YJxtfjsdAExcXOIiX0nh+nt+j9sfdvplXCt0Q2AA0m3ipJNmFjQ0ZTcwh0DPKxQe00l1Q1UoFvZhO9hHRhrVlftSwpTkXhoiJ5FNWpHiyVBHKffS+VJ7hPUrIrxMYgzKXS+Yx/v7rPDFoYCWli4aPEI9z4RWnFtbQhhH1ovuA9TZfP91JlbA1lfcyBGruPtijM1jIm+s+sTDYVuwJsdk7SaBG+ZJs7YGuyCxaGnAhx7nhBq4VO6c9BxShURZARhLRZHGPCdXSxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htitcq4c7Ewd+TN5pfEsNsmeU+QHJ93XYSclMY9d8Sg=;
 b=YmSwXbNrPOCfv+oAEWVH7sjlCqjXYCG+9yIr2q6+l5wk3aAseb+RovUIBmgkrUgmURRVWszsECPJdAaWdZuSUOVYNeaibtjan7FcJeWLPMkKJdWfN0ja6zf/urz5aJm8YEGl93EFeWGZ8E1owODVV6BH7zTyU6+ggZqRJpxDSUB3Va5SqIW2r4uHVKBeUdGH97HDGZM1nIdijEK6//LWGTFeN3S8mOwstZLs6FHfIUD3J8LTuxD2Zm2hkRpuehXI7wGNXeQrnX4wft7yXa4W+rOLWnIf6i2EVXI+pICa14ji91+HK5v6l1d8O/eXvRaFuh5QOK7+TMRG2fubjFadww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htitcq4c7Ewd+TN5pfEsNsmeU+QHJ93XYSclMY9d8Sg=;
 b=zC7SbKU4vJ6JDNtp/PM7jjOqz+68ylhal/C4ggFn0xYmOXQuvdQJ1sZdZIZsNhkMAfkWxe0VbidwKrJH3aCOvX35pf8s4tJ+B99D5vjO6seSmx8PHYX4HThohGpgoDgZ56f8rXwSqPgjELDfDelvHeluMGzG2bzUchJ6lD5goKU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:13:26 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 17:13:25 +0000
Message-ID: <39db1027-cb18-498c-b93e-6d237263ecf2@amd.com>
Date: Tue, 29 Sep 2026 22:43:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-9-sunil.khatri@amd.com>
 <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
 <3233a346-d95f-49b4-9193-769e04493d8d@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3233a346-d95f-49b4-9193-769e04493d8d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: dd66f7ad-29af-49f5-a068-08df1e4cf8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pL4GYz16jdmeUz46NyUh+vJ22oYB1jZ4gg3F53NaJ8r6eKvxcZkCuCoRTuMqSNQWk3Of2dwFSGveAzheYLwByg++005eyF/m8C2LsLeKp/q2sL11k2fuok40KYrZSPHJtwm17QAAOWudX/WKVJ+JJmYzGPpl3m6WzwJDk3UPdcQjE7wvMWqZEIO4jmQTqUE99TC9WvSx7AHQ8h1owwtRRYv+IFcFQ0GDzNyKntJU5B9tIwGITHt7ghUzrDOkUp0bNVW/JSfbkyaq0528V9cTXw5ymQKZ87gNNQIodZBqrG+xI8BLEa5kMdItot+G6SgjB+sUd7zH9zLfHjoFstOCr1cK4cEUFORXBSq1OH2Pm43gHWLf6vQi3Qn6CoI3HoIxhWUvhoNt/DBw88U0i3ty1mycjv42W91HgVfcgGpkN8GuinPC4bn8sL4ml3P1L6YLcLVkhPd1nFZIz5lbdth8vrCyQ+DcbCKAG895ze0LtlM1kqYz9Px+TrG0VMM3i0h3QRrbYpW65Lb+SBF/Vl5MnH2+zXNM2gw+whRoXYCK63VIanHPjBWPdBTLSwndgs9OItUuhri9IF70cq8k3dw5B9KBjwaTqjLIDVkvkVrBrFIhiT3BhG3KlcxBvUyV+5MOQfMiKi8IXu9Lelo9QaW3rX6TFoa8k1IQ1IOHYG/hyMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRzcUtXM2JuT3AxclNQaUF2TjFQdEI3bFRmRW04azFUQ0tIeHJHZCtqdW1U?=
 =?utf-8?B?d09GbkZjdU9sb0FncXVkb3YwNkl1RFV3TVFhU0RwT2x5OE9RUEg5QUNyK2di?=
 =?utf-8?B?WjNPU3N3MHo1ZGZwUWd5aWpvWTZnVHZLNlBjbmNIK0Z0cWVLVXlxcnZOU2g0?=
 =?utf-8?B?OVk5ZHpxcFhuT1NMcTBPWEZOVUYyMS9NTXpreFRTMEMwL21NT0kxaEtYSWth?=
 =?utf-8?B?SExkOEV5dG5laTdrK1hoYkVLRlN0MEpKTU5IRGFJRlYrOVZBUk5JYS9JRW8y?=
 =?utf-8?B?eHNVeWV1TjRSbUpFWHo5SUNSYnJLM0VVSjlqM3drbGd0NGF2bTRlZGJyc0di?=
 =?utf-8?B?cG1teFUxVlcxR3lJekpjU2NYZFI4NWhGSmtUUmNLaURFSzM4cDFkaU44RTRv?=
 =?utf-8?B?SmVpVE9mNGFtYmQwL0JvOXp6TmVsUU55aW9YNU0rSU5qZ3QvOUtVWjJpVXlm?=
 =?utf-8?B?bnFzVDJZU2src0hxdTVhSXlZMVNLamJqU2gybHc3Uk9vK2pxWWxpUEI4ZFpJ?=
 =?utf-8?B?bjFHWUZaZk5oRCtjYkF0V3BId1hWOENNSjhVTlI4RGZJMTBiY3BHUU10TWNP?=
 =?utf-8?B?MXdMdW1Bb0xvZUpBQ2QvamZCaHpJeG1TSGdJZ2p6QUVxVlJtall5VW51TS8y?=
 =?utf-8?B?aE5LcW5mS3BJRWo1T2k3SXBSWEFvQ2pDbnV0akd2cjNycitwcUdyQ1g1ODA3?=
 =?utf-8?B?bU1DRUxmbFNGUkpwaElOdzFvcGlMRHVxbFIxbENFa3dmK2dzbzFsTkVXS0Zz?=
 =?utf-8?B?Q2dUWGphSm5YRjErbE5lRFVIR0g3ZDQ2TEI5L2p3bWxweG03R3ZPTXExTzZB?=
 =?utf-8?B?Zm1EUkRRb0pVK2RoOWtGWWpSa3BjUFZrNHVFVUw1dUFra0tTMHVBL0F5amNu?=
 =?utf-8?B?aGFEb0dzL002RXNLWGNWR1RxejExTWJlbFVaaEpWMmdocUpOOE9YS01GZzBv?=
 =?utf-8?B?L3JqaUpKNnRldjNDSXBBdFNYclNDU0QyalJ1ZCs0RHZMcVB5NlZ3cWxGdTB6?=
 =?utf-8?B?WUxYUDJudkpyOXVrYy85Ulh1a2JLVWJGdS83MUF4WTNlaU1aMDI5UUhXTkN6?=
 =?utf-8?B?VzR5TFdwQmZOekNqRGVLbURUUTZ4TnU5Y1o3a054UHlkaWJsTUlYTVlEZUdB?=
 =?utf-8?B?OG5kQ0pUTnFlblpVZDZUNjROc0p6dHY0dE4wWXdocHE0Y0x5OWRmcW5CRDdI?=
 =?utf-8?B?TGNUa254WllEYWJEdGI4SU1sOFVYUHJHbDlYLytTcHdLWTNqdWErS2U2QmFQ?=
 =?utf-8?B?VENEZXB3S0M5bE9JVHE2WFY5bzhZekpNZmNmNStwT09WWlg2elVYNVRQeENX?=
 =?utf-8?B?WVlaenFOZ05iTzRJZUhQcVAveVNsUTRkamVQZ0dVN3RPV0JUaG1MUEpqQjQy?=
 =?utf-8?B?VzhKMkIzWWkzMGZZVVdRRk9oMjdiODZZa3NaOXhHbkxnWUs0L0hsMVlxVUdT?=
 =?utf-8?B?UnlEODM0MTRPY1FNZzBrVERaUWpnbkpRdFJxbjNaTis1VGVCNkFCUDk4bXFH?=
 =?utf-8?B?NUJkUnludzNTaWhRejR5NnNvaWdxL1E1bFZ3eEYyWUVXVU82OHNDMm82ak5Z?=
 =?utf-8?B?R0pZQ1BGWEowbVpRMy8wYk9yNmpFUllmQWlZNGhRa2VvdmdUN1cxeTRHcGxM?=
 =?utf-8?B?Rm9oQi9Fd3NzNGxncjYxVUdhVUlwZEpnVGRaMCtOS2ozRnFybWlBVkVuRDJm?=
 =?utf-8?B?eUpPZCtic3VPbWg2UUF4VnpGKy83UXAzK3lRQjBFUE02N1A5QXlEY2ZHa1oz?=
 =?utf-8?B?YTNZVTNEa083eFNFakllZHNMc2tZR1ppV3RnUlNncWpLUUZqQW9BRDUrTXV3?=
 =?utf-8?B?MVJ3aXFXVHYyOTluUkpuUnJnTHRjbUxnazBQbnhHY0NiM3Yrei9xZFU1YUJh?=
 =?utf-8?B?WDRQc2liZGFEUm0rWDdEYnpoWGdQZ0d4UDNDL1UxbENJREVDU0dPa0pTSHB6?=
 =?utf-8?B?aUxYbU5UYlErdnc3Kzg5a3gwcU9Mb1R6MVpZenBLb09vWmY5WmdjUHFSckEv?=
 =?utf-8?B?M0N3S2FuYVR3eG1WbXFweGtINzlROFpnTkxiVHk0eWgzeFhLWU5scnhOMEZa?=
 =?utf-8?B?WElhMTlsMG8xOUYrVGZhTHdLVTNRZ2ZLNlUwRGhQdG1tTWsrVUU1eGczMDB3?=
 =?utf-8?B?enROQzNlVldNdGJVNmZRYVQ4SmZLZFNmaCtXR0tJT2oyb0JFRFM0aWpFY1NP?=
 =?utf-8?B?LzNjUFE3MTVPdEVMSFdJYURUOHpBelE1Q0hzL1NSbUJHWUJockI2YlBoOHNR?=
 =?utf-8?B?YmpqWjUxTE1Oa2lUNW5wWk9UTnUzUWZCMGYweU5wMDZuQWVnVkxFNk9xRlFs?=
 =?utf-8?B?eGFOZjZxemVNT05uMmhQYTFRMW9UZDQ5US9xK2FRM2tNTUZFMk40QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd66f7ad-29af-49f5-a068-08df1e4cf8ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:13:25.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikeM3xZHsqw3xpaBHYqU6TSUw+Wnq4wzk8tthDfDCooGqaW0fgw5uwofrEDacRVFYZsjX6LPLa/KiluYaYTvhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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


On 29-09-2026 08:26 pm, Mukul Joshi wrote:
>
>
> On 9/29/2026 8:04 AM, Christian König wrote:
>> On 9/28/26 20:57, Sunil Khatri wrote:
>>> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
>>> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
>>> vm_manager.spm_vmid, use it directly so the idle default matches the
>>> VMID the reservation path hands out.
>>>
>>> No functional change: spm_vmid is the top VMID (0xf) on all affected
>>> generations (gfx7 through gfx12).
>
> I don't see the full series for some reason so pointing it out here.
>
> We are reserving and using VMID 15 for NPA VMs currently on GFX 12.1.
>
> Currently, we are using it only on MMHUB. But this may change in the 
> future.
>
> So maybe refrain from using the same VMID 15.
>
@christian,
Whats you suggestion here on using the vmid15 suggestion that Mukul has 
shared.
>
> Also, since I can't see the full series, please look at 
> gmc_v12_0_sw_init() on how we are reserving the VMID.
>
I am not sure Mukul why you arent seeing the full series... I am aware 
of the NPA VMID 15 reservation in MMHUB and I will check have a look 
at  gmc_v12_0_sw_init.

Regards
Sunil Khatri

>
> Regards,
>
> Mukul
>
>
>> You also need to remove all the calls to adev->gfx.rlc.funcs->update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 33403e16df5ca..88f9f0b0bf524 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>>   
>>>   		gfx_v10_0_init_csb(adev);
>>>   
>>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>   
>>>   		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>>>   			gfx_v10_0_rlc_enable_srm(adev);
>>> @@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>>   
>>>   		gfx_v10_0_init_csb(adev);
>>>   
>>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>   
>>>   		adev->gfx.rlc.funcs->start(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 7bfc8cbdcad85..036d1b7ade4e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>>>   
>>>   	/* init spm vmid with 0xf */
>>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index b75512e7b1db6..4caa43ff50a1b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>>>   
>>>   	/* init spm vmid with 0xf */
>>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> index 91764f2e5ad01..a3d72cbaa6cf1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> @@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>>>   	int r;
>>>   
>>>   	/* init spm vmid with 0xf */
>>> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
>>> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>>   		gfx_v12_1_xcc_init_csb(adev, xcc_id);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index 549d1239e326b..04ee7e1725a94 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>>>   
>>>   	/* init spm vmid with 0xf */
>>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index ab4123ddbb942..61ba71b57b8e2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>>>   
>>>   	/* init spm vmid with 0xf */
>>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index 1678015ce5a97..4862d17a58237 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>>>   		break;
>>>   	}
>>>   
>>> -	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
>>> +	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>   
>>>   	adev->gfx.rlc.funcs->start(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index 01ed1701c781a..add8099cf8e05 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>>>   {
>>>   	/* init spm vmid with 0xf */
>>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>   
>>>   	return 0;
>>>   }
