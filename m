Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8BCA5FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 13:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAC310E3D7;
	Thu,  1 Oct 2026 13:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hq6OQehH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC9010E3D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 13:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwEWgaSagbx5iswBZygibpSljNkEBlpDEZj7L0PNsfqsINC0brpRS6/fFbN1euVp/kT+VvVIjZBj0jkcVHgD9ZT83w4oOtOZT0aigCQJFAQV08xR2Cwwex2GMcm3NVqFtBLVaLltOgrn3+qYQsWHW29KavLNRM6oR2rXM9XHVfsJq4kjepg3iRwLq4rQU9tGs5AipYno/7SNPIkn0ZcUQD/znGhimutkeFutk6niJrHQumGKsz1xlw6uSEMJULoBkpA2+kk3djXhv2AU10pHsRMJgcpSiC/IjJFWtF9g7v7dLn0ewOOEgeQHPyMz5WYTkbSh3HwRN09bH8difJvZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov73ufCuuSQwyIk0huGiwi70ehjN6Q+W5h8pQEvE4Zo=;
 b=aCkZeqf97MP28oRRph4nW1Pn0HhbxjL0OoEPbpy4xtMiElXgTl6NQGFB594dRlYJcEH30H8KAFi4X40tg93xw4bCrrTKHBvrLvf0NzsNE0RR40JQrGW0pLEZCPFViG11Se/Kokd1Il2rV6Q3tk8hVgg9Nrcph6xfczupBMxN26pWNCCff8Mmzqg7lGuLNw1jqNOdJbezEFa/ZAXYqYF5DhoXICoR85LTuXthU2+pHS6qIgNqH3lr1EEG0H59etoWYDtx8x6cRz8kw7g+RQYUPKbSJXTtHqc1XYefJ0ERGjIbQJTN91cMsvW/jOiqQaHKDF7f8BMATNSjkzhMXENS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov73ufCuuSQwyIk0huGiwi70ehjN6Q+W5h8pQEvE4Zo=;
 b=hq6OQehHSHnTE3953gvUxX9w9uMu3D1mPRAl6u2Csl1ES6zOD5Reyhz+6PHXX2VpukW3ZGy2xOULehweW6uSAbuy2keqs65OEFZNgVM0ylWlQQXmcuUb5p2aAyLxSytj0kZFbVcKbac+wrnejj5VwnNH8tDLSEpGyDv0VAx9Arg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 13:36:27 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 13:36:27 +0000
Message-ID: <610259c5-bffb-4440-8e3c-43dbcd0038c6@amd.com>
Date: Thu, 1 Oct 2026 09:36:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
 <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
 <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
 <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d3b8f9-9646-4b76-7be6-08df1fc0fe2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|921020|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ii15xS4ct97OvTFLZN0VW/3NdMemMFCxEJvk1a7m2A4S8p36gPN1p5v6+9i/OerGNwz76A5dCL3gYWOuh/Ivpa7L8Lb8rlRnrl0T7jHke5Oqven/WN2U9yNaQOOmhZDxnZV/HQMpXX6Ass5xpHFLDZ+X/ihomq88b2v52NwlSyd44PVdoUCVUr5r4MAPbN3bMr3n9a/gZ8SptaA3bzyT9UsZarVRW/dGrwkp+5ivt1hfxRra0iVZKcuxpSLsjS9VIzgOg9PAl432okyfONbROYpRuWG1qSdc/OD56WA4hTtxgdsXDi0Ki/TMJrlROx6LW8S/p7yEW1s7mbRoPbnqB/iIB+/q/XCNM+D0EypIBTJ+VmhEXCC8ObQawDM5P3U05Pu5P655ejXn9ysdx5GMrSLT1VjkQLUPn+OgdqwxBmAr4VntIOJiAJhMvUq71VyQ992phFBW3fKgUvUQPNSbg5re98cKXdAAN2NG9gDiTnQMnlmskvnY1bMI+HZTwb6A3x+YrfQzLtstuXM4u0gQ/BtK0wfKtvuBXWEFmmhA6kOzSiBBt4h7TIwNvLvHv7V5nwLZepxD7IQrZuWaVxGUkWBXSauqDtASv+iXr8wIFjAH/5azBsVA9P6Cs8nAiXYVKcIqm9pjBXtUXrXHdkjd9cQBUNekhPfwhbGo/lc9hDoeK5cb+hl0wWIaen6jrtXuqgGSEbYGgjvq1atV5x3HvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG4vQlZVMUhrSVU5REYzV29NbStPb2VmVHRMZkdJS0M2K1l6YTNSMFVZT0s0?=
 =?utf-8?B?bTl0cFJCS0l5UW5JOHNRWjliNnNLa2ZsNmNDRTdIQ1F6Q2NUTmc1WFBxVlFX?=
 =?utf-8?B?d1FmQ1ZhdGxPQmhsd1UvY0tPSVBtREtXOUdxcUVhV0d1MjVIZjJNUE9EUzcv?=
 =?utf-8?B?QnB2VVpLV01oVytZZVRoaW9jQkpXcnhqajdjOXY2MWsxNmNlbTZYeFRCWUVU?=
 =?utf-8?B?c0I0a0g5Sm54K0FyVVl4b0xXM1lHZjdFYVFBMjhvcUJvY1c5Nlpma1QrMXhl?=
 =?utf-8?B?MFFrb1B5OTF4SFlPSjQ4Z2FSUGFIWk1yNW84eDlXV2cxM1ZkamtqbWFVWkEy?=
 =?utf-8?B?bkthUUJMelpUS0VFOU5aN0JLd2J2UmVnNm9hbVZmVXJUM01UdGh1Ry9GUlpx?=
 =?utf-8?B?cGFmTkV3ZXQ4Q1ZoZFA3bVo3V09GdjA4czNKVE5UWUZtQ1ljSlg4cGF6MFZp?=
 =?utf-8?B?bTdoNUt4VUx2R1IvYVlVaFArSVN0ZnhUbVoraDVzMm5uZjRIbTcwU1AzUXE2?=
 =?utf-8?B?UVJiVjZ3QlFZUlZkR21zcWdZWjNPdEh0SWplaEhMRHErTGdRN2xUNzZoQ0Ry?=
 =?utf-8?B?S0hocU1FRENxMndLZGE0RmUyTm9XUEpLNkV1dEl1VHpKd3dUVlFlK0ZFOTIw?=
 =?utf-8?B?Rm96Q25oVmFTYWxCUXdZd1l5Y0pVOGhGMHVmMXlTOXJXS20zcFlkOG92b0lW?=
 =?utf-8?B?QTlSRDdrNG9sOHJ6R1BHTjdQeW1lbEh3YmlTNHBvSnZWbXJQRmVtQUh1ejVo?=
 =?utf-8?B?VjlkNi82WTRLQjFrWTU0cGozQThjV3JvTEhFWmFwMjJNYVAwdGV2Ymtvdk12?=
 =?utf-8?B?WkdZZVJIVXI1ZmxsQXU5Tkp0aExhZE9STHJXaEtuM244allLdVA0M1dKZCsx?=
 =?utf-8?B?WlI4VnNRbE8wMFB1THVhTFR3RVJlZmdWdmwzOGVLWHE1VHJ0WUhiYVJRMmx3?=
 =?utf-8?B?UFhwL05VMmhyRmNGc1RjRzloRTI4OE1iS25FRXM4UFBjalA2YnJwMHdUY1lO?=
 =?utf-8?B?UENhakVxcW9UZHJUM0hqYlZCM0ZEaExhMlJBMzhPZm9qcDlXUGk3ZDREQmFS?=
 =?utf-8?B?WG8veGNUTDhhYklNdlo3N0JhTUV4clhJWERWNkl1Ymd0ZVh2SGMwZ3ZudUJ6?=
 =?utf-8?B?K0NBYTgwQXVVRGE0RnBJMjRNOXo4bEx4VGsveEtBOCtDNnhUVGt5dmhHdUtV?=
 =?utf-8?B?UUJNcmJaOWx3eGZDY2lhZ2xVYnNJbG1mSWE0TWdNKzllR29lSzdtZ1JwTmxL?=
 =?utf-8?B?V2xhclJUM1NXbWNtckg5eVg5MDhGR3l1WGtUMnpiV09meWNGaEpzZjQ5cDBp?=
 =?utf-8?B?VWFRejBPYXZhL2dTT0QzZnI0U1FNQjJYaEVaTVVnNkpMdlBaV3grRkFrblo0?=
 =?utf-8?B?WG5qdllBRmd3M0xzb1VLZ0t4UW5VVUd5S2NzMHNXY0ZTQWdmK0FESWkxbFow?=
 =?utf-8?B?VVpZZTVLMXZ1VVd1UFY5ZURaWVJjeDFBSmtrOVJPdjQrdCtOQjFkMTVDclRz?=
 =?utf-8?B?NTM0TVhiN0t4WEpGTEg4aGw1YVAydmowZnZzR1o4NFF0eXl1bFUrM2pITVRP?=
 =?utf-8?B?ZlZHRWtMVlAzKzhQUzFmbG5EanJkM2tEZkVUWExUSGxSTk9adFdHYzRveGdY?=
 =?utf-8?B?NGlQYmpDRklVQll1OXgyWDVuYktUT3Z1MTVoemFLUnpLNWJia2UwMnFQOEVS?=
 =?utf-8?B?ZUwzNll3Y1lxa0JFZU1LSUoya1llZ1lCODZhY0lmdER2bXd2ckZ1aU8wdnhy?=
 =?utf-8?B?UkxlY1Nvdkd3ZGFBR3BQcUZWTU5mT2FYdzFDQ1hVbkc2K1RVRSt3M3BDVzc3?=
 =?utf-8?B?MVgra2hQZ2ZTZWp1OTh5N2dGUFlxaWZJNlZ4TEQ5djlWbzNMakpub3ZET0NV?=
 =?utf-8?B?am5VYnVXU0lJQlBIM1U5L2Vxa2RTY3lsUUV1V3UxUWVOOS9ySXJzU0NZRkRq?=
 =?utf-8?B?WWRwcjhRbzJCcVhoM3N5Y216N2gvOHlKNkhlTG9LT2JpbDhlaThoRTJVWVlI?=
 =?utf-8?B?dHZWTTZuanlIOEpWU1Y3NEdrcDlIMjhZemxIWGVFTWhYcHlGd25MWjBhT0pB?=
 =?utf-8?B?Y1dnTEtycE1ySjN1cFd0MWdmaVVMaHZCWXpiS1hSVkZxMEJCUm50U1VNRlpj?=
 =?utf-8?B?MFNkUmNlalYyZDlndUE4ZjNwVnVGZmlQeTlYQXRlWUZsYnV6eUlMeUEyS1Ni?=
 =?utf-8?B?NzNWNXEveG9wUnM5SGFndVEzb1FRS1FBQ0FGN1haZlpyRTM4Um5EQWdFTmh3?=
 =?utf-8?B?aUg2K2M3MWZ2N3NWQTRJZGdJelRLbHlWZlVIN1ViYVFEeWV0cG5mVGNUVy81?=
 =?utf-8?B?OUhhQUROc0x3SkRmMGt1SXVpa1Fxc2xQVkFJZFl2SUQzV25CLzJ6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d3b8f9-9646-4b76-7be6-08df1fc0fe2b
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:36:26.9359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ErSP+cqOO8FLI46uR33tFMF6zih8oZoeEGqbzcF9px/G4opt+D3SfAcL1JAIwcaN+oboK2tt+ZBS2SS9JcYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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


On 9/30/2026 12:12 PM, Kuehling, Felix wrote:
> On 2026-09-30 10:59, Christian König wrote:
>> On 9/30/26 16:44, Kuehling, Felix wrote:
>>> [+Mukul]
>>>
>>> On 2026-09-30 05:02, Christian König wrote:
>>>> @Felix and @Philip any objections to this patch?
>>>>
>>>> It is actually a bug fix for the NPA support.
>>> As I understand it, this fixes the flags used when unmapping memory
>>> from the NPA VM. We passed adev->gmc.noretry_flags from
>>> amdgpu_ualink_unmap_npa_addr to amdgpu_vm_update_range explicitly in
>>> the flags parameter. I guess that's no longer needed with your fix.
>>> But I think the end result would be the same, right?
>> Not quite, passing adev->gmc.noretry_flags to
>> amdgpu_vm_update_range() is completely broken as well and also need
>> fixing.
>>
>> The flags parameter to amdgpu_vm_update_range() can't contain the
>> AMDGPU_PTE_TF nor the AMDGPU_PDE_PTE flag because those are
>> overwritten by the PTE callbacks.
>
> I'm pretty sure Mukul tested this and got something that worked as
> expected, at least for a time. I'm not sure if it regressed since,
> maybe during upstreaming. @Mukul, can you comment?
>
yes we have been testing this and it works fine. Having said that, the
patch looks good to me.

However, I have a question on one of the change in the patch below.


>
>>
>> That's why setting the AMDGPU_PTE_IS_PTE for gfx12 through the
>> init_pte_flags is completely broken as well.
>>
>> We seriously need to stop doing such hacks.
>
> Is there any documentation that tells us what flags can be used where.
> This isn't obvious at all.
>
> Thanks,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> On 9/28/26 21:08, Timur Kristóf wrote:
>>>>> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári
>>>>> idő Christian
>>>>> König wrote:
>>>>>> That was broken since adding the NPA support.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64
>>>>>> ++++++++++++-----------
>>>>>>    1 file changed, 33 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>>>>>> c03327f1242d3..e8f441e018839 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct
>>>>>> amdgpu_device
>>>>>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));
>>>>> \
>>>>>>             (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev),
>>>>> &(cursor)))
>>>>>> +/* Return the flags used for cleared PDEs/PTES */
>>>>>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device
>>>>>> *adev,
>>>>>> +                    struct amdgpu_vm *vm,
>>>>>> +                    unsigned int level)
>>>>>> +{
>>>>>> +    uint64_t flags;
>>>>>> +
>>>>>> +    if (adev->asic_type < CHIP_VEGA10)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    if (level != AMDGPU_VM_PTB) {
>>>>>> +        uint64_t value = 0;
>>>>>> +
>>>>>> +        flags = AMDGPU_PDE_PTE_FLAG(adev);
>>>>>> +        if (vm->is_npa)
>>>>>> +            flags |= adev->gmc.noretry_flags;
>>>>>> +        amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>>>>>> +    } else if (vm->is_npa) {
>>>>>> +        flags = adev->gmc.noretry_flags;
>>>>>> +    } else {
>>>>>> +        /* Workaround for fault priority problem on GMC9 */
>>>>>> +        flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>>>>>> +    }
>>>>>> +
>>>>>> +    return flags;
>>>>>> +}
>>>>>> +
>>>>>>    /**
>>>>>>     * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>>>>>     *
>>>>>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device
>>>>>> *adev,
>>>>>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true,
>>>>>> false };
>>>>>>        struct amdgpu_vm_update_params params;
>>>>>>        struct amdgpu_bo *ancestor = &vmbo->bo;
>>>>>> -    unsigned int entries;
>>>>>>        struct amdgpu_bo *bo = &vmbo->bo;
>>>>>> -    uint64_t value = 0, flags = 0;
>>>>>> -    uint64_t addr;
>>>>>> +    unsigned int entries;
>>>>>> +    uint64_t flags;
>>>>>>        int r, idx;
>>>>>>
>>>>>>        /* Figure out our place in the hierarchy */
>>>>>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device
>>>>>> *adev,
>>>>>> struct amdgpu_vm *vm, if (r)
>>>>>>            goto exit;
>>>>>>
>>>>>> -    addr = 0;
>>>>>> -
>>>>>> -    if (adev->asic_type >= CHIP_VEGA10) {
>>>>>> -        if (level != AMDGPU_VM_PTB) {
>>>>>> -            if (vm->is_npa)
>>>>>> -                flags = adev->gmc.noretry_flags;
>>>>>> -            /* Handle leaf PDEs as PTEs */
>>>>>> -            flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>>>>> -            amdgpu_gmc_get_vm_pde(adev, level,
>>>>>> -                          &value, &flags);
>>>>>> -        } else if (vm->is_npa) {
>>>>>> -            flags = adev->gmc.noretry_flags;
>>>>>> -        } else {
>>>>>> -            /* Workaround for fault priority problem on
>>>>> GMC9 */
>>>>>> -            flags = AMDGPU_PTE_EXECUTABLE | adev-
>>>>>> gmc.init_pte_flags;
>>>>>> -        }
>>>>>> -    }
>>>>>> -
>>>>>> -    r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>>>>>> -                     value, flags);
>>>>>> +    flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>>>>>> +    r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,
>>>>> flags);

We were passing addr before to the update() call but with this change,
we are passing 0 now for the addr argument now.

Why is that?

Regards,

Mukul

>>>>>>        if (r)
>>>>>>            goto exit;
>>>>>>
>>>>>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>>>>>> amdgpu_vm_update_params *params, flags |=
>>>>>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>>>>>            amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>>>>>
>>>>>> -    } else if (adev->asic_type >= CHIP_VEGA10 &&
>>>>>> -           !(flags & AMDGPU_PTE_VALID) &&
>>>>>> +    } else if (!(flags & AMDGPU_PTE_VALID) &&
>>>>>>               !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>>>>>> -
>>>>>> -        /* Workaround for fault priority problem on GMC9 and
>>>>> GFX12,
>>>>>> -         * EXECUTABLE for GMC9 fault priority and init_pte_flags
>>>>>> -         * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>>>>>> -         */
>>>>>> -        flags |= AMDGPU_PTE_EXECUTABLE | adev-
>>>>>> gmc.init_pte_flags;
>>>>>> +        flags |= amdgpu_vm_pt_clear_flags(adev, params->vm,
>>>>> level);
>>>>>>        }
>>>>>>
>>>>>>        /*
>>>>>
>>>>>
