Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12401106ACEE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 21:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837E510E174;
	Thu, 12 Mar 2026 21:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z38V46hr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC5410E174
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 21:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCm9nS/5fBsZw12y+7Lbt/Yn5VQZpuLTauwPBpv1b4R6B1aFLT8NTrmlfpgbW8OIjbNQDVyhSXbjjIs+o3RgKR4gyL3XqWeNJAhCCduCIcWc1UPjeFSnN4d2WfdmPK148pn+gavH7MCJU9P786Rn8Kf58kQ9IoTNKOiFcEzv0J08+zj/ivg0tSD3zemuCPuZ3yuruyY/iG1zVMg/Pm6Uo4nkGaSW7dQO0oso9IzGDuMVxoVN3eVMpXtcTHNjyfgTvyampshLsCVp2pS85Rv6Rk57HroR8i3O/S214Ji3T6dhY1xLF1gzra39QIMQjV8e+XinhlVYSFVHRlFQHat8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CTvZMdwTzzO0MZ+wr+Cn3ZgDw7X+Sw2erVbbTRLGn8=;
 b=UE79/l9ioByJWlmov+nukNR1ywFzj8dl7Qh0VVVTYjZYaYcD8OGBdsr1EQYEcxGk+lPd33jBtJi9a14Y9vqo88F2IzfCW+ae0nIPWUmkEL17n5PU3A7xiL1i+y8WkpuF9uYu/e6QGMbxwYRMNNGSujhwW1cvYPnqFIpsHZCl3tg8xHowhJmH8cRYJqa1MY8U+lBJS8A71wy55HiJOPfmT3E95pz33oia8L3rEjIngqx1Fw7oW/aGklhu+U3Ug69CTU9tuMR1yOSvNe6QdIHhiKvUvq86mBfuEldCD+xUJECZH1F0wZIxXjRrKEm94uy+XMLeviwJe7V1isydJ1jXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CTvZMdwTzzO0MZ+wr+Cn3ZgDw7X+Sw2erVbbTRLGn8=;
 b=z38V46hrFOHastW5PAWg6WsILAocPoHSBpqxBPM6F0Pz9cx3e0Qof9sE9m6o5pDXyNXd+gyqFq7h74Q8bLGvwxA3wHXd1vNMs9mhJ+Cr9lv2Dz1Hx93axtR4JKQz1fxAOhsu1Wafgk7HP8Xopaz9p0X6W0yQtzBtc7m1rYGgMw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 21:09:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 21:09:02 +0000
Message-ID: <39534a37-ace9-4623-9bce-dee0f7e7fa06@amd.com>
Date: Thu, 12 Mar 2026 16:08:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
 <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
 <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
 <541ae425-cd9b-4088-addf-0a212df9dd8e@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <541ae425-cd9b-4088-addf-0a212df9dd8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:52::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d12c80-c7f1-4ec1-72bb-08de807b9633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: tfZDzXvFerdz+BPK91nPlVBMWjxF7b1j9hZdMhEVdX9d4iwlAYsgz/oNixpKHehMpVHB68aFfw0d2CrRot7BZEmlqn538fufo0LWr4xAg6zkoRNxeRqj2st58ET+VaNLdRV7R6x1GGpDsI5fLw8AGt/8Fx9Mwyl6f5WioKDQ11AfPffDBL1WF2qn6A6hY3wil5cj9lHljC+gFztSYK8/tF8TfPNZAQareVfZB+JVLoJKHArWCfSZR0sHwuXNcG3wNLfRN0rioPJiG0o//Xa+/Dtsiy+QrOrq+qz4PEpMFfyGz5wBvIeQMEwuDFOdII/221UuMzBKfzEQ34+SSoCQch1S0CEMzO5QTtK8FA7awgWIOEeAUCDtYxra2P+q/7bs7yJ7mzmlXL/AltRCTUana0gABwP0e5SEB8tphiOrG83N0CMlcrcgqtwWtW4e2aTbxQfwtaG5M0FjgoCmr0keqskSO+ekYaAtX9JiOCkyr7+Z2TFSiAl8OsPRsDD0d3lF3hqGXpyx0TgrCeDNy7zvJeynzD3ovB8sC4Z/VfsAIAdUklY6zFNeOCF8l7dcFp296TbNtYkhogDI20VBD450qvLBJKsXgy7eJGo5PeVH0M0/gKg5lBJezCxTEvKpXKUdYCrufHMYzDNh0zeBdCQf/mApnYRsAjsIV2Q3accV8dOTcHZn65Srqww93YrziIo8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVpUXk3VW9EQzFCVVp3cHR3emQ3c1FQRjJ5eG05VUhZaU5tdkNCdVZuQ3ZV?=
 =?utf-8?B?MHptOUVZRmNuNHhXK2pzSmc4dXVreTFGSUlXbDVYWWJaS25DL0pGWFczcjNH?=
 =?utf-8?B?WFFHZzFmRVkvdUxYa1BVN2dBNFFHL1JNVE8vU010VlNPNlFhV09DYWM2TGhY?=
 =?utf-8?B?WE90aitPOEJjbUtzcFk5SnZTU1lYUWkrelZqdU1HbkR3dHYrYkxwNFFNWUwx?=
 =?utf-8?B?eHBXNWxjd1AvMkxETlVQbEVRMUFkQXZnTmRvNk45eTFFTGJVMHArOXg1U0Jr?=
 =?utf-8?B?eDBQN2xJVG4xM1kvM1BJWUVMRS9zT0tsRUVVQzRKZEczclovQm9XcTJqUjZU?=
 =?utf-8?B?dFF5b0ZGeERMQmdtdFU1SmYrWmFlNzRFNVloVEFkb3BiN2VqalE2V0J6S2hj?=
 =?utf-8?B?S2pmd1FUYmoyaTgzVmU1ZktaN1ZJejJBM0RWNzlxVDFjeHNHNXo3MFFhd1Bs?=
 =?utf-8?B?b2hDVE1MT2thb0UwVGoxL0ZPOVhLcHI3S0ZNZnJzQURNanBmS3l0RTNpUndy?=
 =?utf-8?B?enlCWDZEa1JMK2c1OXg3YVg5WjZGUFFLa1ZiMWJFeW1oNVZiTkkzdDFJU0tU?=
 =?utf-8?B?U2tlR2d6bFczY0xtbmlBOXpocnlpRk1POGdzQXBKN3FZeW5VcW8vLzFEWGNz?=
 =?utf-8?B?d1NpekRaWXc1dVRjYkpYcXZYS05ZVFV3RTJiUGdZa2ZyYmlPM2xlREtYdng1?=
 =?utf-8?B?U3VQZlpoYXRXNVNZK3FZSW9TRmUzUWRWVTFERDFCTFQ4bnFhaUNFMU5IcGdu?=
 =?utf-8?B?RGVwYWY2UmFseDU4SDQ5aGk4aTgyT1ZqRFgwWGpGOEYxVnp2TXYrU2hSNkdE?=
 =?utf-8?B?bDVVTlFhTTFkNjZHUENzS1lQQit1Q1l5MG5YUE5XcnFGdXNsWWxHanpMcTZu?=
 =?utf-8?B?azh4QmkvS01kZjRRZ0pnT2lOU0tJcWRqaGNPVWx6WXVyb1hsbkYzd3k2RmtH?=
 =?utf-8?B?UXVoSEZMRXg4MC9LUTg2Ui9vWnBvTEtsRzMvZWVQZlBUOHhhOEVLcVlYRy9D?=
 =?utf-8?B?S3FiNmVLREdLakQwM3IydENPQWl1STFkK24zUXhhbU40UFV3UHlrY2wwTmNi?=
 =?utf-8?B?V0FEUFpIQmtyeVIxOHVzdUNnb0FXNHhubG0vOSsrZ0tlcHIzYTFTTG9KS1VO?=
 =?utf-8?B?Rko1QWhxU0grOWZPZDBxNG9lU0w1SFVZOHgvVWR2NXk2WlRsNUNjenA3VjdD?=
 =?utf-8?B?N1FuVGJZOFNlTXM1SEwvOEFWbXdjeFcxZkdkVmhCVzFKS01kazc4d1pBVVor?=
 =?utf-8?B?SEEya3QveE5wSXZack0yalg1amQ5dk1qTElCRjZPVTJKbjJIbHNRM0VlN0Q0?=
 =?utf-8?B?czB4L3hDWk4yVjJpN2VJdVBQc3M3RFRvNlY2YWNrZjZKZHh3OVA4MGtFdU9z?=
 =?utf-8?B?cE92Z05NcVAwSTkvM1pKTUcvV3Y4cVFidGxFN2JxMG9GU3Qvd3lpZFVjcitE?=
 =?utf-8?B?c1lwNk1nczBrMmpVeWY4ZkFJQkF3V1FSZmlDdHF3U2tQZDRKWlZldnpOOFZE?=
 =?utf-8?B?bW9Cc3dkZ1dOc0JBbXlvV3p4T0tpdWNkSnJVSzFybHhrclBFaFVvKzh1NGht?=
 =?utf-8?B?eWxRTndHRUcwa3lwQTdDTWM1ZHVnMkhqcGZYTGpuM005L3kzMExwV0lnTkpM?=
 =?utf-8?B?T3c0UnN5TnZNYzVmb3B1OFR0WEJ4WUw1QWpOMkdsaVJFZHhwSGt0KzVkMWJp?=
 =?utf-8?B?c3YwSDMvU1JjSFlBamR0WU45M1ZvMWk0WWorN2dnbnVZVWwrWEcxUUh5dHor?=
 =?utf-8?B?dHJSMWJVbXVkK3V0b3Z0ODlYa0Y4MFNUQlpnelRxWHVzc3JCUmZ5QWo4a0ds?=
 =?utf-8?B?eWhXNkdqZDJxNTN3QnhIYlN0dk9ZQTRWR3RwckQrY2cwVWdHbkIyT1AvaStQ?=
 =?utf-8?B?dWY4K2JzZVV1VHF0RG1VY0UzRXJOM1hrTlEySDBxenE4d3N4SGpWc2U3VTJk?=
 =?utf-8?B?OTh2VkNZVmVzb2VYOGNQTU91VkZyRjR2RUJaK0J1SlpUeHVxU1J1QW8waDNl?=
 =?utf-8?B?MkZGRFZzVldiY0JJMDQxZUg0TDRteUZGMmt3enVidWNiQkJaa2hXRFJ6ckhk?=
 =?utf-8?B?Vmd2bjhkN0JaWHpLWjJEc2lSOHdaWGZ5TXBpbFBCamxmTUFaUzYrZXF6cjM4?=
 =?utf-8?B?VWZwZW5Kc2hyWi9iZ2NWam1zYzBVZG1jRENYekJQaEV1ZHhBVEx4SHpJblJ0?=
 =?utf-8?B?UGlPenJaWGk3ZnpMTTZTTHN4TnNqTmVXdWo3R2EwNGsyS3d6b0JJMkxtQWxF?=
 =?utf-8?B?WWlGaFlPRmRRbU5uODZuNW9Bc3FnSWpMc2QwSFJtcGViNFpic0RTeDkvNnNZ?=
 =?utf-8?B?cVQ2NTMwa1VGUk8ydC9NSEZleVJBYlV6TEJhZUl2SVd5dWMwREFvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d12c80-c7f1-4ec1-72bb-08de807b9633
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:09:02.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qvs2OSkz6L+xes2z3EikadkK8Um03HPhRg+7d0/cqvvVGYDbR5+MRwBHP9JgCDL3CgewPngWLDe9w6zW1aaW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

There is actually a contingent of two people who claim that this patch 
is the cause for MES resets here:

https://gitlab.freedesktop.org/drm/amd/-/issues/4749


On 3/5/2026 3:43 AM, Christian König wrote:
> The original reporter already mentioned on the ticket that this patch is not the actual cause of the issues.
> 
> It basically just changes timing to create and eventually wait for the TLB fence to signal.
> 
> Let's see what the reporter finds with his extended bisect.
> 
> Regards,
> Christian.
> 
> On 3/5/26 07:48, Liang, Prike wrote:
>> [Public]
>>
>> It’s possible that we failed to save and invalidate some active pages during suspend, which then prevents those pages from being restored correctly on resume.
>>
>> For now, we still rely on this patch to keep the userq page tables updated and synchronized. Until the full solution is ready, how about we fall back to the initial approach and restrict this TLB flush to only the userq path?
>>
>> Regards,
>>        Prike
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Wednesday, March 4, 2026 9:57 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>> Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
>>>
>>> On 3/4/26 14:54, Alex Deucher wrote:
>>>> This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.
>>>>
>>>> This causes framebuffer corruption after suspend.
>>>
>>> But prevents massive memory corruption with userqueues.
>>>
>>> I have strong doubts that this is related to the FB corruption in any way, it will just
>>> change the timing.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Prike Liang <Prike.Liang@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 01fef0e4f4085..25b1d679ba262 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct
>>> amdgpu_vm_update_params *params,
>>>>      }
>>>>
>>>>      /* Prepare a TLB flush fence to be attached to PTs */
>>>> -   if (!params->unlocked) {
>>>> +   if (!params->unlocked && vm->is_compute_context) {
>>>>              amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>>
>>>>              /* Makes sure no PD/PT is freed before the flush */
>>
> 
> 

