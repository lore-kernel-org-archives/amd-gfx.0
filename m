Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6CFC982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 13:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC7D10E0C6;
	Fri, 18 Sep 2026 13:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j2m0jQ+l";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4704810E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 13:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEnOMJfc9XUQ5DwE9A3qmOhhYv5pBbsL4Mn3VQTM0CEwo03MJmRq0oXG5c/RHSf+5q+8/Yl2hpCPCI9eIfAvxwIj7O+ReZjKUCvGn0PBPQ40Bz+uH1r81dfSCtm2EcU3NYL9CP7EEjS8gp8Nj7orDDkqa+rSn+2tppr1LaHKHZD+3vSiEj9xJwgYv9kzM/J2MiifMIj2/n8m75hr96fmcGs4iwdoVDxmJgQKD7jYSt2wy7b5Qwrh3dvA8Vc4Nd0GSEl00AGdRDk/SGdnL4/kp27YQPWDpolyDkRHpV24YeDuw77IpJUIGQW+u8+vJH5rQsCFxSH2zy2iQ//1/Aab1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dGdSTDM2ZpSb9X4NYfDi6PQpEtnqCpVgL8kSJE9rMM=;
 b=Ub5Io86VsIGVuZ1VSjVoHDUM1Apf6R+GkVtSscClv+Ifzm0OKjuYsu+sX8jk6iR5A925LgUbnU+F+CbnkGbc/BmPVkHCXVYvXariTs2HyNtsdN5qkNsfs+rh8tgzN74Zb9fCpRMFI9JPuLatyv97tsoUeQ4JyPiApCOoF42y+xlCMypFMVXC+3l+h3X39H4JYol4oLC5OHc4sL7Zygk35kG+RGxKfjjKCDIc1G/qRvRBe4iGnNhjhXTt93K5SCXL2v9sdK18iaBgsAfO95txWGdvHPlChSAfa4VkQfw6qSIPaKih4OXoWtkmhsJ0rWCanird88kaKLvVc4aFm+y+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dGdSTDM2ZpSb9X4NYfDi6PQpEtnqCpVgL8kSJE9rMM=;
 b=j2m0jQ+lFrD6UU/UQ+RuWeUfW/JZbBR6g4au6vcC4J57yScAbpN6q2OhUa8K8nICApcCmf22bTiRoSYCkV2O9+0w4HwoWQPRpN1Bd4LPP8X0bl6oe5o5sHMWtcN8DXIuDiuc3lEpH1Cys3heIYDRNV2D+6fFJ1WnRbvipwDT33o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:24:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:24:05 +0000
Message-ID: <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
Date: Fri, 18 Sep 2026 18:53:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
 <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
 <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: ee81cebb-79c6-4beb-2b5e-08df15881ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5V+g4OtQC5GbaZJsu+pQHekFzRrL5KqcfTIzNo/LZbOxgcvCNe+aq5LBOnFTZSwcEMezSXDVUcSfobR59sU+eHnrazESh8+RJSs+4aE7N3V4ykqMmnukHHV2Dj2bQuf0J+bP0aCqqu5sE2JBdouScYWbDEU0xK1Y9VQluJwZMryVNrgJvyWYgdZZdOniY0DjuncQ3366P3O19Jzs7hKfuJs39kYGUD4eKNqd56xeEAHNFUSNCVuDjbGLHHDywztb2Y2hzfYmSaJ0arC5HK0HRheUzrwY/E4ZgeAhY+kfHnk2zN9BbDQTJlb/qeWX8UxJWHm00pisM1ZDQ9fD45HXYcXijBcAtzqsyxl23kGjkYFgKi6smRJaQNRcSxTJ8Qlk5c2J+7UODWDkcThSvCyxb8eMZcEt2Jmr8Zx7pJBI5xfUL3+ExqaV6g82hhXaCmAGxWGrugVTFWUTQg2Z5jf2L75NMbP9Dw/JFKIJOnHZzXoQ6F9RG8O4iLlqv8f30AEPtUdM6lPN98vp/6H/qbosFcH0GAWSFnSJ+s0IZmQUqTm99zfZ3NPTLsWQSVSHUx9gMo2qpVXkYQXrg0UMlbzezyeNMyppTL53M9YzxWC2GOnAYuHyT94tniuhIfqYmjihoq4ayiFiOoyV4dm5a2K5MAsTi1GyEUsjEKkulBYbQbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVMxSmM4ZFNDT1BRV1lTdWdrbTNKWW9rS3M4WGZ4Z2hZdXgzcjRnQmRsUDI2?=
 =?utf-8?B?RVR1dndtUXprQ28xZVd1aFFpUjdIOVZQYy9XT1RLWjA1SVpCVC94ZHlGL2JI?=
 =?utf-8?B?eUc3dXJsV0NiV3IvWDQ5UysyeEtOWEdjU1dvRXU5bFBkVU5EQjNIRk95SFBh?=
 =?utf-8?B?QjcxY0VYNDJESUltUUx0Ri8rOStmNXFkN3lFb3pjWFh5dUM2QjNiZE15alpM?=
 =?utf-8?B?K1drbWQ3S3RyVHk1Vm05bVk5aWpxOVhyRVNyZWx2VUNud1BLaTR5bVhYUzFI?=
 =?utf-8?B?NWZLYmFNMkI1VnBJNHNNNm50NDY5a2hRUUtlQmY4ajMxR2dHam1NdENoS0Ix?=
 =?utf-8?B?SjZtaWtZWHNkZTJHeFBpcW5BWnB1RjRuM1I1RVg3NDZFWmRxVy9BdHNYNHVQ?=
 =?utf-8?B?MjRiS25tZHVONlBEU3VsWGo3TVZJdWtQeDc3L0NWVGRLeDBkcGthamxzYzBw?=
 =?utf-8?B?cmliTUdRWGFST2dsTTZOT0JDSkV3MXJ2SlA4MzRvMlVGak5PV1JlV0NpOWtx?=
 =?utf-8?B?MmtFSVJBd0lOaUd5ZEZ3dmhzNXRjMzJPMnpSRmx0RXhIZDNERVk4TkNuS0NP?=
 =?utf-8?B?R0U2N05zbTdtMmM5ck93M2pOMjRjMWpoWmlVckNEcWdSYnZyRlhoRFhCQlIv?=
 =?utf-8?B?YXNrcWtkRS9aTGdXYnNmdFRubFdwV0NtWTFmZG5pWm83K3ZMNXByVllYUWZj?=
 =?utf-8?B?bHFZUXppZGRtYVBlYW4yaVcza2xCNFB4UFFoQTg3dHk0aDNVOGxZazlhbUwx?=
 =?utf-8?B?aUp0cmxRUUtWcjJ2akNwWm9PZW9kZUFHSFJJaGZRMnRBRm5yOGd1WVdyVVVt?=
 =?utf-8?B?STFQWUFYUU54Y3plSURpM2hLeXVicjhkYU9oV20yNEtPaEdDdHA1WHlDbDV6?=
 =?utf-8?B?NVBwVEsxbFJpUjBFY2FNa3hBNFQwTlFHd0R5VUlzeGxaU095Y0ZmRWVyTGs5?=
 =?utf-8?B?ODNaQlJ3eU80ZWJBSDRKb1Q2Yi9ucmJoaWZsR3h3UlRuUU1NTkFDN2xsWU5K?=
 =?utf-8?B?UFFuNXczbUFQdDRjYnM2QVNIRi9DVFVIRmtkSlRCOUtMeHRrc1lGajNzdmZ4?=
 =?utf-8?B?OU52bGNJOVN2R0RDK3hRSy9URnR4STQ1UFJIRHBVUkdFU0ltVmxaaHBRbjJ3?=
 =?utf-8?B?YmNwcEprdWpZcFBzN0M0ZTBtSEZieGNnSWpsc3lHaGt4Qzl5WTE4ZVZSQXdt?=
 =?utf-8?B?dHI1TUVyNjZ3TTVOb1hreThMaVQxekpHY1dNMXNOamtXODNqRVpXdmxaYXNu?=
 =?utf-8?B?M0doN2NIbC9hUlA1YWRVazlCODlLdzlLTGVPMFpaamlRUVEwUk1tSnFsaU1l?=
 =?utf-8?B?dlRVcWo1NWExd1BFdHQ2MllrREtpMlpZQTFQbFVNR0tDVDV0dHl6WDNXZklD?=
 =?utf-8?B?amhjK2R1cjRnRzhRanZVNUQ3Q3QzejVOMGpkU25qU3FuY2JLT21pa25yZUcr?=
 =?utf-8?B?KzVYR2FURjdSWXJvbStFU2dHWVBTbXlFaHgyd0RNb0NXeGFYL0pGUE1Jckdl?=
 =?utf-8?B?R0VtdDBkWU5HZy9MVEU3NlZFOWw2RlMxUGVaMldGU051Sm5ZVFBOTkpaUFhS?=
 =?utf-8?B?U3ZIelJsL01iTHl1dlpiQVVla2k0ZTFxZ3RMcVRLdW1pWjZZL28yVUpUOXBF?=
 =?utf-8?B?MXZEdXZramZOelNiaExpQ2dxK2pub1ZkU1NRTjl6QUpleGwyUE5uZGlmb2Qz?=
 =?utf-8?B?R2R1L1pCR0hycXgwTXl3VCtsQzNtL0VVSkJWQTdwY3NuOWU2U1ZWMk0vVWVs?=
 =?utf-8?B?WXl4Zlk0MDJmSGs4eGhLY3VUTFNYK1NDZTNUeWpzVWFaTDZBK2lLN0IvT1hQ?=
 =?utf-8?B?NGZOMVZlT0ZkSDlPeWRsZ2hpVm16OW8wa3d6azhZRG1YZzZvVVh5TDJpaGxV?=
 =?utf-8?B?ZUlWR0tmRHR1RS9qMi9VcmJlYnlKOEN0UTBIakp1YW44UzgxTWZoais2bkhZ?=
 =?utf-8?B?Uks1d0hiRVhPVDdoSnJNRXEvTkwxMExnZEk1LzBTZDllTTk1eGpDQTRhVjJJ?=
 =?utf-8?B?ZGVXRXZZT1l4cWRrMWs0RldyUXJOMmhLcFZGQzZycy9LMzZPL1l6VGorWmtO?=
 =?utf-8?B?ckJPYThCMVpzYmprc00wZFFOa05iTFpCWnF2azNuQTlIWGwyaHBHNjdsa1BI?=
 =?utf-8?B?enJEMWs0bVI4SmJnZEYyMWVaUlpZZi9QNnl0YXZ1S2kzY2NBTU5jaXBicldZ?=
 =?utf-8?B?eUZ0aVpwN2drVTR0bjBJUXJYSDgrNnlpcDcwS3lzSlJpNzlwREk0clNhbGlU?=
 =?utf-8?B?eDFoQWxKblNjMXhYZ0FIczQyT2xoNk5IMERkRTNicU9LUjh5NEdJVWZFbVpv?=
 =?utf-8?Q?XM/768pHIjtfo6azMz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee81cebb-79c6-4beb-2b5e-08df15881ca5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:24:05.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ief1+SgnfC89ReOvTOTUe/fqMiMveeuALpUEa8V7CVChF4v9CxgO1kNxE3Cf7cd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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



On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
> 
> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>
>>
>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>> Avoid constant register reloads while emitting IBs by using a local 
>>> write
>>> pointer and only updating the size at the end of each helper.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>> v2:
>>>   *  Fix decode buffer overwrite
>>
>> Overall for this series, below type of calculation  -
>>
>>      ib->length_dw = ptr - ib->ptr;
>>
>> is not anticipating a case like below.
>>
>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>          if (r)
>>                  goto error;
>>
>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>          if (r)
>>                  goto error;
> 
> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug there? 
> Help me see it please.
> 
> ib->length_dw update is enclosed in both of those helpers, same as 
> before the patch.
> 

What I'm saying is -

It's the same ib pointer that is passed to back to back calls.

Legacy implementation fills like -

ib->ptr[ib->length_dw++]

So no assumption that it is starting from offset 0 always. After the 
function is filled, length gets updated based on what is filled.

I don't see the same with an assignment like

	ib->length_dw = ptr - ib->ptr;

Thanks,
Lijo

> Regards,
> 
> Tvrtko
> 
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 +++++++++++++-----------
>>>   1 file changed, 75 insertions(+), 59 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_vcn.c
>>> index 17db7264269e..2c367ee6e182 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>> amdgpu_ring *ring,
>>>   {
>>>       u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>       struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring- 
>>> >me].internal;
>>> +    uint32_t nop = PACKET0(internal->nop, 0);
>>>       struct dma_fence *f = NULL;
>>>       struct amdgpu_job *job;
>>>       struct amdgpu_ib *ib;
>>> +    uint32_t *ptr;
>>>       int i, r;
>>>       r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>>> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>> amdgpu_ring *ring,
>>>           goto err;
>>>       ib = &job->ibs[0];
>>> -    ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
>>> -    ib->ptr[1] = addr;
>>> -    ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
>>> -    ib->ptr[3] = addr >> 32;
>>> -    ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
>>> -    ib->ptr[5] = 0;
>>> +    ptr = ib->ptr;
>>> +    *ptr++ = PACKET0(internal->data0, 0);
>>> +    *ptr++ = addr;
>>> +    *ptr++ = PACKET0(internal->data1, 0);
>>> +    *ptr++ = addr >> 32;
>>> +    *ptr++ = PACKET0(internal->cmd, 0);
>>> +    *ptr++ = 0;
>>>       for (i = 6; i < 16; i += 2) {
>>> -        ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 0);
>>> -        ib->ptr[i+1] = 0;
>>> +        *ptr++ = nop;
>>> +        *ptr++ = 0;
>>>       }
>>>       ib->length_dw = 16;
>>> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib 
>>> *ib,
>>>                           uint32_t ib_pack_in_dw, bool enc)
>>>   {
>>> +    u32 *ptr = &ib->ptr[ib->length_dw];
>>>       uint32_t *ib_checksum;
>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* single queue checksum */
>>> -    ib->ptr[ib->length_dw++] = 0x30000002;
>>> -    ib_checksum = &ib->ptr[ib->length_dw++];
>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw;
>>> +    *ptr++ = 0x00000010; /* single queue checksum */
>>> +    *ptr++ = 0x30000002;
>>> +    ib_checksum = ptr++;
>>> +    *ptr++ = ib_pack_in_dw;
>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
>>> -    ib->ptr[ib->length_dw++] = 0x30000001;
>>> -    ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
>>> +    *ptr++ = 0x00000010; /* engine info */
>>> +    *ptr++ = 0x30000001;
>>> +    *ptr++ = enc ? 0x2 : 0x3;
>>> +    *ptr++ = ib_pack_in_dw * sizeof(uint32_t);
>>> +
>>> +    ib->length_dw = ptr - ib->ptr;
>>>       return ib_checksum;
>>>   }
>>> @@ -803,7 +810,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>> amdgpu_ring *ring,
>>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>       uint32_t *ib_checksum;
>>>       uint32_t ib_pack_in_dw;
>>> -    int i, r;
>>> +    u32 *ptr;
>>> +    int r;
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           ib_size_dw += 8;
>>> @@ -825,18 +833,20 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>> amdgpu_ring *ring,
>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>> ib_pack_in_dw, false);
>>>       }
>>> -    ib->ptr[ib->length_dw++] = sizeof(struct 
>>> amdgpu_vcn_decode_buffer) + 8;
>>> -    ib->ptr[ib->length_dw++] = 
>>> cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>> -    decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib- 
>>> >length_dw]);
>>> -    ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>> +    ptr = &ib->ptr[ib->length_dw];
>>> +
>>> +    *ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>>> +    *ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>> +    decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
>>> +    ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>> +    ib->length_dw = ptr - ib->ptr;
>>>       memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>>>       decode_buffer->valid_buf_flag |= 
>>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>> -        ib->ptr[i] = 0x0;
>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 
>>> ib_pack_in_dw);
>>> @@ -934,7 +944,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct 
>>> amdgpu_ring *ring, uint32_t hand
>>>       struct dma_fence *f = NULL;
>>>       uint32_t *ib_checksum = NULL;
>>>       uint64_t addr;
>>> -    int i, r;
>>> +    u32 *ptr;
>>> +    int r;
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           ib_size_dw += 8;
>>> @@ -947,31 +958,33 @@ static int amdgpu_vcn_enc_get_create_msg(struct 
>>> amdgpu_ring *ring, uint32_t hand
>>>           return r;
>>>       ib = &job->ibs[0];
>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>> -
>>>       ib->length_dw = 0;
>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, 
>>> true);
>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>> -    ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
>>> -    ib->ptr[ib->length_dw++] = handle;
>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>> -    ib->ptr[ib->length_dw++] = addr;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> +    ptr = &ib->ptr[ib->length_dw];
>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>> -    ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> +    *ptr++ = 0x00000018;
>>> +    *ptr++ = 0x00000001; /* session info */
>>> +    *ptr++ = handle;
>>> +    *ptr++ = upper_32_bits(addr);
>>> +    *ptr++ = addr;
>>> +    *ptr++ = 0x00000000;
>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>> -    ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
>>> +    *ptr++ = 0x00000014;
>>> +    *ptr++ = 0x00000002; /* task info */
>>> +    *ptr++ = 0x0000001c;
>>> +    *ptr++ = 0x00000000;
>>> +    *ptr++ = 0x00000000;
>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>> -        ib->ptr[i] = 0x0;
>>> +    *ptr++ = 0x00000008;
>>> +    *ptr++ = 0x08000001; /* op initialize */
>>> +
>>> +    ib->length_dw = ptr - ib->ptr;
>>> +
>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>> @@ -1002,7 +1015,8 @@ static int 
>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>>       struct dma_fence *f = NULL;
>>>       uint32_t *ib_checksum = NULL;
>>>       uint64_t addr;
>>> -    int i, r;
>>> +    u32 *ptr;
>>> +    int r;
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           ib_size_dw += 8;
>>> @@ -1015,31 +1029,33 @@ static int 
>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>>           return r;
>>>       ib = &job->ibs[0];
>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>> -
>>>       ib->length_dw = 0;
>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, 
>>> true);
>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>> -    ib->ptr[ib->length_dw++] = 0x00000001;
>>> -    ib->ptr[ib->length_dw++] = handle;
>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>> -    ib->ptr[ib->length_dw++] = addr;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> +    ptr = &ib->ptr[ib->length_dw];
>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>> -    ib->ptr[ib->length_dw++] = 0x00000002;
>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>> +    *ptr++ = 0x00000018;
>>> +    *ptr++ = 0x00000001;
>>> +    *ptr++ = handle;
>>> +    *ptr++ = upper_32_bits(addr);
>>> +    *ptr++ = addr;
>>> +    *ptr++ = 0x00000000;
>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>> -    ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
>>> +    *ptr++ = 0x00000014;
>>> +    *ptr++ = 0x00000002;
>>> +    *ptr++ = 0x0000001c;
>>> +    *ptr++ = 0x00000000;
>>> +    *ptr++ = 0x00000000;
>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>> -        ib->ptr[i] = 0x0;
>>> +    *ptr++ = 0x00000008;
>>> +    *ptr++ = 0x08000002; /* op close session */
>>> +
>>> +    ib->length_dw = ptr - ib->ptr;
>>> +
>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>
> 

