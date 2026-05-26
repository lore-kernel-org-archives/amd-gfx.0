Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6845CD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FC410E0F6;
	Tue, 26 May 2026 10:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bn2ibU9h";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09C010E0F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx0HbZZNcxtBARlLd42hqxwFIq3TtVUYkrdWnl6TlvhgHpK0ucFC3Ffw2Q/qJ4qQH2ACyp2z7tIj9AdlDPceLlCzFc8vGlHKhNBN1vp6k/aB5mO6/S1eHkflQWacDBp+edFKtJ01ID+ZJWFV2ei8miWXrdoxLjKJm4BNXw7UM/afbC3HRTlmoK37uXfdrc1xMYGdb0qmZ9ogKswxbthZYJzhP9Ob0N+TScZeLkAB/s6SU35MUtud93yj39eBxlJyf8ykRaam11Ilxz5vWdY5xZvajrh75aPjjw5S2m16za4s0mJ7+FlgXvfCYk2jgn2VbQECBG8lwU5Qb3/PU2eAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91+k/121rc1zmKhYZtOteDb8rX5yigHDqnu/Xrgcx4c=;
 b=hDLm7rq3ckWNK1E1q2CrMpM4mCq+JhK5vRfGy5bqjFeA8WEnTYr95anLq6F0uAPh8LY/3T8ckHMWizO+Gs/0Wc0K45FHDattenvaa1LUpMOel2rmgqTBY3CrUvwKWZ9+RREzGMWLD+X3znCooskIYjZfrjrTkCA7FLFji2vzXap7xyBrEwkbEAZYxE+kL20+z7S9KIXlmP49k68IWM/WDvYbZHjncK8Sbo85vW/UT8vJNxzuB5R/7uLXaAhvloZq46uOX6bvl4f+1SctIk/LVrXFOT7Db8fPhS3dTKGVKnNGKUWP9IQaT15qm51LrN0iseVHhvgMP4xiwJp6NbaAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91+k/121rc1zmKhYZtOteDb8rX5yigHDqnu/Xrgcx4c=;
 b=bn2ibU9hL5Vp4FQURiW3QxaCuO+fLRluBdCLwOpWUhxyxRwZYAo2RKoUF4Y8zaZjgg7tgoO02iKFPDiZRcKuXVtPC8qmA0xfkmwhFsG1/tfYsJgo26EO30QBIeVkmaJMMhIwjmfHQJP1RCalfZ8op71xVs2YDH3HTcF2yO+jkEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 10:44:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 10:44:31 +0000
Message-ID: <5169bf26-7608-4b79-addd-55466baa64c6@amd.com>
Date: Tue, 26 May 2026 12:44:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu: restructure VM state machine v2
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Vock Natalie <natalie.vock@gmx.de>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <2840173.vuYhMxLoTh@timur-max> <34270690-46ec-4212-92a8-8c782ab644b6@amd.com>
 <2389346.vFx2qVVIhK@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2389346.vFx2qVVIhK@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0ca644-0e30-4d67-492b-08debb13c4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: anoOzpRY+qrI/6su3sx2TDH/VwFHLfRyk1pG70TVO/+DMXhciK8DevZVs4+qcAFDFXBL91KMZPEgxnFeityBVq4Jz/oB9ooQ/QE+sz9RNtbP2NZKSmHRu0x+HFzgftYGNb/Z3/R1zmdgXwhs7KmHYULPnvSkdlMypAwOLxMMSyj7xVge/ZJoymb+YGXh57i3MVVmdTRvS5aV9MS85QX6No9eLl6N5sHyRJILVhY/c63OJR44Zivo9QIiPHGAsyScxZmTJZ3D4XfiSAV+/T6Kxv6XIqAw+3O+VrFyb/8b1uk1brKRadqHTeu43vDwQ/Xm0YoAlGudROXdxAV66kWmEJYVrlr5t3y6qVZlF3dkQ/SK6X7RClNJE5cvf3QE5Kk7rHE4T450pkflP5MF/VNImlONoGROX8ROylLFImdmMJ309XFat141F9sqBIku21/+qiPuII3Q1bURyYOGVeGwJPJzr3UzSE4N/S3oW77STziqpqiRbDGnvTObFNhsutg027i/ZQOPKvXu/tuVQ20n0e+20vBBu2D+0j/VCf5Wttsa9F+s6RQIPsYG3VKchiPEVWq2SyKeW4SrMvundwFTM7LTwUk9NV1QH/NvP1zXPukZMFLeQfCRZrIAH3KbQoDmuB5Yy4HRozKzR2LKSQbFz48ZPButRlidQs4JkeWt5U/tRHM1h0v8mn2lyiO43jl4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTlRa2pQQUsxdWNKM00veDQ1VVNlZUtTSXM4OTFxQkQ2dWNRWW5lQ3lVbUdL?=
 =?utf-8?B?OUgwRU1PV1F0QzI5WlBwSXJUYi9mM2FISjNac21TYisyUGs0QTh5Mk5TVHI2?=
 =?utf-8?B?YTZmMUFZWHdJQ1l1SjRQVDdhOEV4S2dxNlEzZXdoZmdYRzR0citwRTlyajR2?=
 =?utf-8?B?ZmdkZkJtd0J6VGRkTnkxeUFTUFlCNnNhaUdWSXYxa3F6SlZ6U2xWMnJpZ3Ur?=
 =?utf-8?B?ek5lUXFJV0Q5dTFPakNGVnM3RDVRY0tVQm1RaWJWVjhYZmx5bDBPVXZ5QTRQ?=
 =?utf-8?B?elpCS3c3b0pleXp6Y3lBYm9OZTBjQWxESitpOU9hOTZORWpZVEJUREh2REZP?=
 =?utf-8?B?ZFZ3SGxIR2czaktrdG5kR0ZxbUtOZFFXaVk3Wm56c1N1VmU3TVBHY0FOLzBs?=
 =?utf-8?B?cXN5V3p3SlBVRnJCM2NQeXJYWDQybG9RSVRESDVCMkE0Nll0KzdkMU1SMmdT?=
 =?utf-8?B?SGtPeUtKSjNXN0pXTlRDVThKRGpoSG1jeEh5MExFUS9uTUllbFlNelhvUGx4?=
 =?utf-8?B?a1RoRGpjMFNIRGFUUURlMDhkc2pMQWtqa3pNZExUSXZoOGlXa0FaOGw1MmFO?=
 =?utf-8?B?UVNyeUp6UnVIVjcrTGdBL3dqSk5QM05sem5HUWVKem9ndE1Wa1BKalU2STVC?=
 =?utf-8?B?d3QzUFV2bHNGNWozenNNMFZiWjhHbHpUM1dpS0Y3N2VFTU5oSzkyelIzcjcx?=
 =?utf-8?B?QTdQeXFyY3R0UHF4NzlvT2NtVThqaHhmakJxYmJHZnpPTkliVUprekJtcXNJ?=
 =?utf-8?B?NFFaa3pJbUpBMEtlcjI3VVQxaDFwa2diZ0JJNTF3VnlaanNPR0l6eVNGTnRT?=
 =?utf-8?B?UjRsR2l3Zi9TNGErT0dXb3gxdEVHNkJTKzJnQUxTUk9MQjZiRm1MK1lkYzRX?=
 =?utf-8?B?UE0xdUN1bGc0OEVYQVc5YXlwQnd2bldWaU9tdmdEYWZuaEVtZWNDYmh2bFg4?=
 =?utf-8?B?LzVQVXV6WnVGV0N6bFNhdU04c3EyNnZyMjdhQ0QwRGMrWE5FbFcvUVRqbU9q?=
 =?utf-8?B?WStsVHU0UVpHSlFlaDhaZG55RHBPYVhtejNxcTZMdkFDQWI0RzlKQXJ1NWxI?=
 =?utf-8?B?TUc0VW9nQVpiUTR4bmNNYWMrYU1TQklLSEZUTmtsOUpxcjNOQmhhV3pjdi80?=
 =?utf-8?B?azNqNm5LUHdwRHZ3MzJ4VjNzWHdqMG1uRGNpd01pSFZmenZmZHVBb0w3S01H?=
 =?utf-8?B?elJGSEM2c25HZDNvdTNXYnZBSzBWc0pLVlRWU3dCMXNUL0RrTzdOSXQvc0Vk?=
 =?utf-8?B?OGgxL3ROQTJ4ekFrZDRLY0hkNnpZc3pGREhSYTYxNkV4bExialVYaXlaQUhj?=
 =?utf-8?B?YU1aNmRhQjFGN09Na3paclNxYnVBVnhpSmp2TDB2MzJsdFNONFU2U1l5L3hl?=
 =?utf-8?B?anQvQ1Azb2NaY0liZnJUTjhYOEhVTm5lNENTTS9iaUE4QnZyeVZCKzJwb3g0?=
 =?utf-8?B?QWhrNDRGb0NCR256eWlLeDlPMXRJVHYzTVpEenVWY00vclo3Wkt3Rk1MYWsz?=
 =?utf-8?B?ODlEZGNZSjNLNUpvbWRPTW1icEhxb2hObVlOSzUvRlFxdi94K0hhUHhZZ1NZ?=
 =?utf-8?B?S21RZ1BLS0NDQVNCQ1hYWEdhMUtiTWVwMHhVOWx1T1I2czNKcHA3QUVkQnNW?=
 =?utf-8?B?dXRObXN6OWo3SVMyOEZ6ZU03ZGRTUnI1R2NCSEpqbTlKS3A3aGR6a015SkRz?=
 =?utf-8?B?ZmR2dnpCZWNLUlU2eER3ZEhQZFQzNGF5K244Q0dBTkhKZmZKbFZaZnY0VCtB?=
 =?utf-8?B?bWVqOUk1K2s3VXBBWWwwRTc4NTJLZzR5Z3pIRFY2UytnU1BzbUkyYTNNMDJ6?=
 =?utf-8?B?cFdHKzNudDBRbTRoZG1jeVBKNHNvclQydk9ITjdWdkkzMzlUZnNJOTF0YUFl?=
 =?utf-8?B?UWhjdnpqVndHdXJuYkdYY1F6UysvSkprajlqWjI2TCtoZUFUUGhQQjJ1QVZk?=
 =?utf-8?B?R3BXM0xhU2ZTT0srSlEwMnpKaXB5dy9aZCtLTjQ4cGpPaHRVRVQyVDJzcFVq?=
 =?utf-8?B?UnoyalpFOEQrWHNkSEJGNlhTQ1RGaEFDVjBjMG5FZEUxdWR5aTYzY3dIMGVt?=
 =?utf-8?B?M2xRcE9vZExUeUVwQ3pzT0RPRk5EM3RUa29pcEFRY3Q4b1VjdXVVcDlzSlRj?=
 =?utf-8?B?YjhkUTBFWEFOUmJGdU5LdTZvYkxQNjFLdHRlUEVTNTZYVXpKNFQrWSt4eXU4?=
 =?utf-8?B?SGp2UnMxZUplaURRU0NydVdlYVRJNVZ5dXlzMytWOVgydEFwRGdoUlI2c0Rj?=
 =?utf-8?B?L3FCN3ZSZ0hVVHNZRUlXUW1BZkk5WDhmcXpPUUplWG5rQVlTd3A4L21mQTlY?=
 =?utf-8?Q?7jHekeDlawerfF3HON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0ca644-0e30-4d67-492b-08debb13c4b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:44:31.4350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL/4xdM39whv6CmsULsjRohHZKKbExM7tdLhuek+asZTWJ3AefZoC+xmUDjVH1zO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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



On 5/26/26 12:11, Timur Kristóf wrote:
> On 2026. május 26., kedd 10:51:38 közép-európai nyári idő Christian König 
> wrote:
>> On 5/26/26 01:29, Timur Kristóf wrote:
>>> On 2026. április 27., hétfő 20:27:23 közép-európai nyári idő Christian
>>> König> 
>>> wrote:
>>>> Instead of coming up with more sophisticated names for states a VM BO
>>>> can be in, group them by the type of BO first and then by the state.
>>>>
>>>> So we end with BO type kernel, always_valid and individual and then
>>>> states
>>>> evicted, moved and idle.
>>>>
>>>> Not much functional change, except that evicted_user is moved back
>>>> together with the other BOs again which makes the handling in
>>>> amdgpu_vm_validate() a bit more complex.
>>>>
>>>> Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
>>>> considered the VM ready when user BOs were not ideally placed, harmless
>>>> performance impact for kernel queues but a complete show stopper for
>>>> userqueues.
>>>>
>>>> v2: fix a few typos in comments, rename the BO types to make them more
>>>>
>>>>     descriptive, fix a couple of bugs found during testing
>>>>
>>>> v3: squashed together with revert to old status lock handling, looks
>>>>
>>>>     like the first patch still had some bug which this one here should
>>>>     fix.
>>>>     Fix a missing lock around debugfs printing.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>
>>> Hi Christian,
>>>
>>> This patch regresses GPU recovery.
>>> (Tested on SI, haven't had time to test other GPUs yet.)
>>>
>>> It hits the following warning:
>>> WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:635 at
>>> amdgpu_vm_pde_update And then this error:
>>> [drm:amdgpu_gem_va_update_vm [amdgpu]] *ERROR* Couldn't update BO_VA (-22)
>>>
>>> Please fix.
>>
>> Yeah that's a known issue. Fix is already pushed to amd-staging-drm-next.
> 
> Hi Christian,
> 
> Where is this fix? As far as I see "restructure VM state machine v2" is the top 
> commit on amd-staging-drm-next right now.

The patch is called "drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine" and should be on the mailing list.

Regards,
Christian.

> 
> Timur
> 
> 
> 

