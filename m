Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD76606EE81
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HbMqXisq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450E610EA25;
	Fri,  6 Nov 2026 14:43:33 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394F810EA25
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 14:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvsBtwzhXzpCTdVzA0RWSBXSoa4dKfnjW9cHmuWeNDPdzGz28YDC1z/RiLXyqGWyi21+mzxwEKkf+Vu9+yJYInSWIRI+2Tc1TgCC+XPxuOa3/qJqfjuH2RAZtq46t+NWaoZphYT8pBloGEkDppjPRBIGZEo5dwK0Q3tqPFvP+mfkJZWVgyWRIENPiD0MMeYCGUFBzysIbv3QwDZlhL8y/SBVH6QkrJSvEnFDCilAU6wQNHLs47vdwmDTc4ZV6gDgHi7FIkyvSl6eiZ9NlKqkaI5RV+K6nA6o1J2oevSqJciq1LQfbGqgAP2k3F1+axW0r038hUHUWFRCoCwbwtNr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQTc1aYiLrmVQmEQgXlQ/nJBB0dDIm5YOla1Cp06fxc=;
 b=JJ0mCQqjiwHYaWekdQlmcHxXR2WO8U8MQkBunDRrqgoSi0JcG07MImBRW09xGIvsIdXv7QYKbZnm6C1IbSscwhfrcLwGfOBy/oUm/bgB3G5mFA/9paQNrmjmhMZC9BVuYEzVz2Hz5ZVPq99U1mwY1WsTdT08JErv9LshVjxw+t0YAxWBvxlQxdJ20UEAn6nwszurl4C8GmEh3SRo8oDmCoPrCiLMw0A/mnuAx7o9VJ5cAhGwlWpgFYS9um8lPD7omEEijyAtvmA7NQYxuM5FDP0WOgbZcJtsGpLNt6aTh9cDkTW/YefgCzTCWWYgcIVVUcyPYETL1UvZgqf/Lpdcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQTc1aYiLrmVQmEQgXlQ/nJBB0dDIm5YOla1Cp06fxc=;
 b=HbMqXisq+Tvn8BFWGospgmKqsITn1ehLSxYJtCD/qtthLHTFjXE5cRltWOFswZe3+Lzl25mf9fiymW9zbzetyZFY++fNc9TsLbkyOIxJ1UGEBcjo4QhgS3tWZAotw6i9JyfYvE+JGpwC4fmGOY14h5chLlG87OSwjP+U8OStXMg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 14:43:22 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 14:43:22 +0000
Message-ID: <e1c7084d-e0a7-40a1-ba70-41ec1e0ca562@amd.com>
Date: Fri, 6 Nov 2026 09:43:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
 <76cbeae6-fb4f-4809-bdaf-b7fe5f5bd5a1@amd.com>
 <55da7c06-b53c-49d6-9878-b03f7c339766@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <55da7c06-b53c-49d6-9878-b03f7c339766@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::29) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f82e1b6-30d0-47b6-b6f8-08df3c144e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2W4Ve/6mqyFdw/0GTjrOlEYVKVuRfEHEGWse0CC+8v2j1Ir6FKRoDstl6jOC0vuTSRWVs5FcnT/UW4VAT67UKyIjLrh+r6kbbb5j7SwMgOvVibitkuKzD6G716AdRMfoig5/HfsozpseNKhT6I5jnR961bRZN+VTDGCir1Ka8qjc/J7NhNw9ABEVxGhjQ8KZkDv6GqrtmogZ7u2REn0nkKUWT5heJw2jnvJHMjtMLzXzmoX/YlzIesd3g9BBzG5FDlX/UXRKzNlBPFhIiTHYgi/E9IziE0yAKyLccVAoUfhUz0ozbSgHiU/W+PHeiFYnPA9xm3OzM5GL7TC0+NMCQeRxAuuyrYhnYJKSvXoSdlugGAvyyoRS6omGVg4k5XjEfrjZ87XzGLA+NU8dOr3hShVj/tEzYbEtNDaAZrXusA9KxPPPeVYY8DO4oYsV/vRAPA06/TUOYOiz4HoAtXKew+PHsw46NiHd0x9gg5rv+ijHAogiGN0VOsHECZzhrCkfdK+q2DVmMlRaXXPWoYYsf00Ki5x2t5XCrgkYB3bbC0oEgRp9Lcgcr6T39827cUUseJV1vZ9B0SrRLDG0/3XqdBEogmMm9VrFC4Ua55zob/0SRH0Fouvdk+MmZdNhGrqSq9tbDlFNqFFkG7QLyOpukaqP/H3XYRNIRwVRYBi7dJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk52d1NxdTBRMDFrNWVWVm81RkNWdHU2cnUyNXNMVVRDRzZrUDhUZmZkMTBL?=
 =?utf-8?B?RVg0RElaZ0oxMUNkR3lqOTlrL3RIL01ndzdBd1lCdTVKeXZ0VlltUmdhc0xu?=
 =?utf-8?B?bFdVVnR4NWNJSThaREZuMTgyaStIRVRRZVFkc2ZXWEd6ek5HTDg2QmFwT3E4?=
 =?utf-8?B?TUthRHhSaU5jVHRaL2MzT044YkdzT3pvcVdIMXFDYTJWR3EyeVlNaE9XdjJh?=
 =?utf-8?B?KzA1K0VhRGZXNGEzUUtWalp2eU83eU94NGYvQjdVcWtSQnlySlVVOHFWc2tS?=
 =?utf-8?B?eWN0cFJUMy9qc3lEei9QZHFnaWpBcUNCSkhVME90bUt0NEtndUtaeVVyYmdj?=
 =?utf-8?B?dEdseHh6TTk1djhsTk1qYmpsY0Q1TXNiZm1Uc3dLVUt2ajZ0QWk2dVNlWmNN?=
 =?utf-8?B?VFVkdTE3RC9BazB5TCtLcXNnYkFIYmZ1TFZRT1B5czRwZ1FWd0MzcEVjTjRp?=
 =?utf-8?B?TmxyS08waS9vTHVlVU5abnd3MUNNVFJNeEJhbVg4NEpKdVFUQ1JhUXdQaTF2?=
 =?utf-8?B?cEh5c3dsclJoVktza0ZZdk5hK0R3U2VCS2lqOG9mR3dnTWlERThnci9lMGt6?=
 =?utf-8?B?Q1h1REtDYmJNYmZ2Q254MVZhdFZDSUVrbnVzeXJQTUNMVDJvZW5adFcwS3JG?=
 =?utf-8?B?TXhZNklHd2dYOXVUVFFETUdhR29OZEJ4VWpGWE1hRmhOcms2M3ZqMU5iTGlr?=
 =?utf-8?B?MFVzSXlibFhES25UaGxIcVMydlkyN3MrUXpaWS9wb201RWRiM2h5QWt2K1dl?=
 =?utf-8?B?NFNjNm9lcWk5WEJGMk15d0duK0hZeldZMFY1RlhzR1NlK1p2ZFlMK0haWVpM?=
 =?utf-8?B?ZWp5R3dabVRmQmlTMXZqSll4cEFmMW94NVhsclpBYmxsL3A0bTlvVDI4RU8z?=
 =?utf-8?B?MlN3RDNmVitnTWlDR3IvWW4vVlE4Mnc1L2tuN1ZOZFJrSElhanpzdUFNZmcy?=
 =?utf-8?B?djI3Z2NJTkJvOSt2Sk11ckVuMlBQM1ptc0dIVTUzSG9BOHZMYWdSVFoyTDVR?=
 =?utf-8?B?OXc5UitqTjBJK2tCemdKT0NySG5BTW4vdWtMTXJIZ2tORzF4K1NKVy9Vc0s1?=
 =?utf-8?B?eEZmekVGQ3RYclU3UldVOS92Smp4bDRkcytNM3Y5WlhJa2V2M1NUT2lvMEdt?=
 =?utf-8?B?S1pIK2ppMVBMVXo4WVFseVAzWVVHM0VnSXErWjJWc2FGZWZpMjEycmNiRVdL?=
 =?utf-8?B?TVF3dnJ4bzU0TzJxbWxKdjcrUEs0UjBNK3NmS1lrcmpDSWYyWVArblltRmRF?=
 =?utf-8?B?MHFZUDMvWm5rbTlJWTNndmpwZ1lWM1FXSHRPbjJYTE1odnduSFpDa3pkODZS?=
 =?utf-8?B?bjhtZlVUa3BDaElUV2tCM2d2VG1DR3hOR1M3Y0tnU1ZqV2lpdk1sZkFuMDhT?=
 =?utf-8?B?TzZuOHJEUUUrWFlIcTFwTTJDYWQ0M1p2MU03UStVSGxaSWR6WnZyM1A4VmtU?=
 =?utf-8?B?dnAxV2dDVUFPNDV3ZWlPKyswOFVWUE8vd2h4YTNzL0dnSlRJeDJaT0h3c090?=
 =?utf-8?B?QzRJV1U2cWZod2FYM2h2KzlqM0pLNDhOMVRyTE81cVNHVml3d2tGZExPN1VK?=
 =?utf-8?B?MU5ST2JPSWdNUjFueEtjSzVMaTdnSTJWN3o3S3MyNjNSQVlpc09mem0zbXV5?=
 =?utf-8?B?Mmh3VlFNbGFmSFJxZjZ1bUd2TXpGUEtKc0xKNHJacjF2L3MrM0wwY1dBdHVV?=
 =?utf-8?B?M0FPNDA1QTRyaytDRi9Sd3B5TVBqSyttVWxKUGEwUnBTVldqUWhjeHorcERJ?=
 =?utf-8?B?VkZ0MTBUZFBjQTdDVlpST2I2Yldldm9rWEthZGRWaEhVbTgwb1NWV0p6dlBr?=
 =?utf-8?B?OXR1eTgwbVRyN2U4L1pRMmhsSzk5TmJHVDNpbjFSQUVkZU1jMmlSTjhxbExo?=
 =?utf-8?B?amNIcTJHZHlobFNXbkw1Q0pFS05BeFgxQVVTSEl4TzlrN1Z0Q29KQ3dTT2xP?=
 =?utf-8?B?bi9OSVdyVTNTTHdYRFlUWGdWZWgvQWlNWHRyOWZJTWU4Yjd2OGRLUGo0U3FT?=
 =?utf-8?B?T0hTMlV3dHdGQjZ3SFlwZXo3SFlDbklUWEFxZm8vaWswR1NTOG9iMHRuYmZy?=
 =?utf-8?B?ZnB0OTN6Z3IrZ0lYL2JRTGFXa1poZjNNUDlvK3JqR2VFeGJzRnYrd0ZTNDc4?=
 =?utf-8?B?aXhsSytKZ2FZRVdleExJYXdXOUtYd1AvMXpaVGlqMit4MUdHdTR2aTE4VFRH?=
 =?utf-8?B?eExnYnZuRlVQRW9ZaWYyWTZzWmxrNVRJRmdoSUZXOEFlK3RFcDErQmFhRzJ4?=
 =?utf-8?B?bGN2YWM5dWtwL21TTVRZbXA3S0VtQlpGd251aitRUFVXWWRWU0ozbzRuT1J0?=
 =?utf-8?B?SGRCQWlqSE1sSWlVOFdpUExzVXZqUlgyUWxtMEV4ang1WDNIUjhEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f82e1b6-30d0-47b6-b6f8-08df3c144e7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:43:22.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlKSLMbV/91XqiBhFc652bo592c7IFoQOv2ToCp79Lk0QIfLzt3IGQJkmld/LwbJrTQad57s5MWJoYWDB59AEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-06 09:22, Christian König wrote:
>
> On 11/6/26 15:18, Benjamin Cheng wrote:
>> On 2026-11-06 03:55, Christian König wrote:
>>> On 11/5/26 22:00, Benjamin Cheng wrote:
>>>> In the happy path, the job gets freed when the job is submitted.
>>>> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
>>>> would leak the job.
>>> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
>>>
>>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
>>>
>>> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.
>>>
>>> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?
>>
>> I see, thanks I'll take a look at the previous patches.
>>
>> Should we consider reverting commit 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location") in the meantime then? As I wrote in the cover letter it exposes this issue and can now be detected by IGT tests, which makes our CI flaky.
>>
> What is the rational that "drm/amdgpu: move amdgpu_vm_bo_update() call into correct location" should make this flaky?
>
> As far as I can see that is completely unrelated.


The amdgpu_hotunplug_with_cs test submits a CS while another thread unplugs the device.

The commit made the seq64 mapping happen lazily on the first CS, and during the PT handling for that, the unplug happens, causing amdgpu_vm_pt_clear() to fail, triggering the use-after-free and leak of the SDMA job.


> Thanks,
> Christian.
>
>>> Thanks in advance,
>>> Christian.
>>>
>>>> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
>>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 2ba33212d507..f6cb2b5854dd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>  
>>>>  		tmp = start + num_entries;
>>>>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>>>> -		if (r)
>>>> +		if (r) {
>>>> +			if (params.job)
>>>> +				amdgpu_job_free(params.job);
>>>>  			goto error_free;
>>>> +		}
>>>>  
>>>>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>>>>  		start = tmp;
