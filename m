Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2BFCD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 17:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11FA10E1FB;
	Mon, 11 May 2026 17:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWn26w4c";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488FB10E1FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 17:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVb0ihdmYCFL3yGGVV8Siq2i5yIM6yhXle6wz4qV67W2TbotC9fjh1HgQ6+1v5n+cgdZXGJVEk55k57EdeB5eMk2uTYXq0C3hER9hhdPQZyjNyyEHavnzwk0+/NCBmPOrtMu0k/rdKRu1vGdR6+s9+pIYBeoaP/W0jhxwvepahv78DTP5TSdNcfCq46+0K5ffcR+h/AkKcgn+lWfA3X6SN3YQsu00nHF15VBikG2FLsvWzfq507z8C+bPHBuMNLN567FyQthgPDeMxHu6Wn2fVP4IlZRczNR8mIGc+J2GUoe6JfBcJgeJBIHETw6U2YIcug+Ndzh97Txx9517cRXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s65eMOnl67kPLQ82AUBRzhGzc2TGFnumyGKX9koBpJI=;
 b=ZFkMDVUUl9ayMhtNLpnJl4agbs3/zPBe1aK0pObYgBTMxJkvqY+CsR46/ahoHwTam0t82ffpL3sIoB8/n/2ax0UAjCf2KE1VryppLpmN+Dwusl4SVTfPCr7J3QdF34ddWU1ieOPsAqXkERKr1bNMSVUkOaV6V5no9xBUKalJBikcNnbiNPAIeCYShwfDe6Y0EvJZPtSOc+S3mUhPQ3HmlqEP7mYoIN2wJb+ecW3VkBzIoYdpGffW0kGVFZ9snsSq4vjMIBLmfXwGQ/SAT5JowMUk8AT48mjGF7MY0cbM+zB4gMYRgrJmoLbYgSPN64bfjPgo5esYScNJ5gIlTZfQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s65eMOnl67kPLQ82AUBRzhGzc2TGFnumyGKX9koBpJI=;
 b=RWn26w4cmnN9uNkAnIjIdP51IijZoWhImXlqhCpPyTaCrs5uicyypEji5jSbmAyptcWzMOZCLidRgQLSr3W31YsKUsYyBcAa2QYWW5OJOBxpEmU41V4drv++6LsNrYKFcmLeilObfK+dKC0PWTEvr0gi8eDQw/dQpLqzFVJ9qq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:59:05 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:59:05 +0000
Message-ID: <694e41a4-2439-4deb-885a-5d1c3421ed1e@amd.com>
Date: Mon, 11 May 2026 23:28:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu: rework userq reset work handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-8-christian.koenig@amd.com>
 <99fbb7b9-bdd4-4c97-b089-5f6a3bb7a6c8@amd.com>
 <bbbde7b2-f9b5-4e58-859f-05c85ca3e589@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <bbbde7b2-f9b5-4e58-859f-05c85ca3e589@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b167d2b-b7ee-40a4-bab7-08deaf86fd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: xQaJTj0vQ82zvatrWqxwLrI15jePLLuKV7HZ7RixOsZ5uQUBB4gMo5UbNO+TGCHNuU9la1Muvo2L4Bva0f8UKXjZiugE7QiYjnRD3O3CLq7lF6iIBGto40ZuyM7Jit84Qj+S4vMbWzVyuyZBnIVmV11PMKwcehUVAXYZ/4xj3SjAcYcUPz6EiIPQ0UCuuM/HlItn9fydIht2fRDLPCmFR0tRbwtnLEl4ZPQsWhSq9y/qNyoaAFAFhnr7S8YFQMjXMhmZRvwrtHEc9c8bniHKU1/D9zV1rUMyFEL9t0PGp5YfJWwlSxELdGwQQtfq1PA460gJY2ySVCs6R+798WBN3QPQiehkaL0h6yM8AGgYfRYNtaag+NqibhYlptJh7dtjaod0INLknWlrAXBvqvLVnzyvd/9iaKpwuvn02CZkHcn/T1od6zpTSpVu1B63SXPyV7ZANldq0iySWMB1JJzd3EEwiGrLxfmYYFRUqKxpvxOAr5IgD/iIpeNjybc+ELG/mk+8SpbCnJSHE37uaDjYt7tJ5s4i7JAHS29xryyQOjN8+cck0NAZ0IG6xh9NaBTL6hm9905NPZdlAFb1ADL2e3BWqbZgu7yAKJCHE4+JyVTVuTZ1OiJO+K8jddx5sbB+8vSk86c5GPT7E4C9cvZY/dTxZsCwem8+ZESgryyBGX0ZFPGegVYDuZ7Ho6Cv9+4g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0N0SjdLRU9RcHhnQTNrUzYzOUR4TkFmbTFyVWFtT3dJSThOSnMyVW5jSUZ0?=
 =?utf-8?B?NnllaG5TWHNUVTh3aEZHWlBpNXJyWTBFd0UrbUN2ek03bUJjSHZ2UWFPSU5T?=
 =?utf-8?B?Vjk1aC9saWhncjVKN1pHSncyNldrUENSOVM3US9xOEw5Y3JCeVlESUFOazBZ?=
 =?utf-8?B?Mk5RM0FHQm9VOURzREovWlZobHZPeUFJbS8vanVDMDA3aWVHdldaalZOYWo1?=
 =?utf-8?B?TFlYYytOQzRmUDdEMFRkT0ErSk0wQXJRUG50OEY4SVRhTmdna0tkMVZwM0Zn?=
 =?utf-8?B?YVRlZGJoYmpuS250Nzhjdm1ySmo0U2FTOXVXUGhKYUttNFhjcDRTYW55dUZi?=
 =?utf-8?B?RXc2RitveXBGdFJxaWxLTStlV3RJL3VhUnVnZlVSSDQxLzRTbHRVM1JmRll2?=
 =?utf-8?B?dkpvTVVvd3JKQWUyM2cwMEVoSlRjYlFHY0Q1NkJ0RmV0WVpkemZQY00zaU5l?=
 =?utf-8?B?UEl4aHN3TVRjSGhOYit3MXJZNkpRbE1DU0dTU0o3cEpMUG41K2NsY2lKTjhG?=
 =?utf-8?B?TWVCV2RlWm9TY1pML0ovTHdBMGFndGxlM2pybXQvclRQemt5MW9PYVNkSnBY?=
 =?utf-8?B?dVV0MGdYdDVZSHAvUFhzNTY0Ny9zZG9wNGNSN04wMmVUODdBL1FhZEtoaXVG?=
 =?utf-8?B?L3E1TGdEWldjMGNqRHVrYWNrWFJxWFN5emlRcit4d09wUk1xUEg2UGRQWFlI?=
 =?utf-8?B?V2htYWFidUt3TXFMcGRwMmNFTzZSZFp4MUw0bk9UN3hFaDhMUXZlL3gzeFlH?=
 =?utf-8?B?R3lJSUJXc29pQ3MyZVd4WXl4bU8vVDJqSHZIdWlYR2RLUW1Dc3FuUjJVTmtn?=
 =?utf-8?B?Y1pscExXUTJudWNjTkpJc1A0NVM1dUg4WWVXc3JraXdWQnJOOVNLWC9NWnBW?=
 =?utf-8?B?VjI5b0xVN3lmcThHQXZLNDczK0lFL3hUWENibnplUTdmSEg3Nm5RQmFPNk41?=
 =?utf-8?B?cndXZ1Y3R0plMUJhNS9qeVFLaTJTeThkQTU1MFR4OERTWmpZbVRacUdNekUr?=
 =?utf-8?B?K2xBRTVJdXIreVBLNGRGYThhM1M5d0JaR2JQbjNXaTAyelhvQ0JuVU5Jc01Y?=
 =?utf-8?B?eHlZK25oSmJJUnBDSlFsK3hMUnlDNXJDZDdINWZqd1Exam56K002ODhGUkpW?=
 =?utf-8?B?VXhsODBuSHpHYWlsWXUxWHlIUlBlNjNMeW5pVG5tNHdYZzNZT1dTSDVVRDdn?=
 =?utf-8?B?cGxYZnRpYzh6MVhzVmovNzdhSkRvaFdTSzhLaDlGZjc3TTVJbWpiRmFsVmp3?=
 =?utf-8?B?bk5RWjVKY3hnSWtya1MyRzRXV1lzbzFNajd3aHgweWE2Y2dwdTRRTEtnNm1x?=
 =?utf-8?B?SFBZYU0yaEtYOXNWV1diZkJpdlNBbjVvcThWdkZsalpWYXVLQ3U5TU1TTXQ4?=
 =?utf-8?B?K2NoYlBoK1pCT1VTcnBaeWdUY29vMVVPVGNPbUloUmFIdGRTUWJ1eHVXNmJj?=
 =?utf-8?B?eW5qTjE5eEpsc1JNN0Y3eHpTbjhja2N0SjNnTDhxaTI4aGdaZi9raE1Ecm5S?=
 =?utf-8?B?aTFQZGVldDRYdXk0cmJibnh6Qk5LR09qeGdyNHNGemo1ZWU0cEVzRVprUnJD?=
 =?utf-8?B?dzBaK0tlOGE4eHdvbXd0ekV1TjBSakEramxrcWtoa0V2YjhSckZ0ZHdoYUxx?=
 =?utf-8?B?Ulg3VXdvc2FsYmg4UFVOTVFPQzBaN21CcmRqMzdKRWhEZGRNUmhvSWNSUjVz?=
 =?utf-8?B?NlNWWHpWYzRSQlVPTHcySjZLNncwcVRmQXBGWWZCUWo4V0dPWkE3S3lQR1BI?=
 =?utf-8?B?dy9kL0FkRjlqUEkrQ0dKWlVaelpodllHd0pYZEY5L0M0ZWZTNmtNVWxNdGFN?=
 =?utf-8?B?bzdna3Q0bStxN2lDSW13a2YvL3hBaTJ0TWNMb0IwVzQzM3U1TjJKdHVnMEFr?=
 =?utf-8?B?UWt6VjBMRTNiQnVMMVVKaktCVG5KcWdoc3VnN3hPM01zb3h1aE5qZlRpdDZ5?=
 =?utf-8?B?RUJHSGFhRlc1VXJRU2gyb2tVd0JtanhYclNZK1dtYjVLR2MrdUw5NDErQ2Nj?=
 =?utf-8?B?b0JLbklLWTBBNzNNNGtJZUJWQjloRmJJd1p3WENTWTFUMU1JYmoxN3Y0RldB?=
 =?utf-8?B?bzZQVGRMalpybFNyZEpIRHFEdm93V0VDcG02cXFwMHc0L3YxNnQ4QXoxSlF2?=
 =?utf-8?B?WHFjTW9EamxiaElIS3VHTmUvRno2QVl6TEhCNEJEN0tza21iTWVJK2pIWkNM?=
 =?utf-8?B?bVJaSFdENWFscWdvN2tTdWI4T1NnRStSOW0zQ0cwSkhqSWhoVXJvWkpBYXRj?=
 =?utf-8?B?YlRxUTR6V3Uxa0lXcDlYSFgyK3ZwdE83MEx5NVUzM2JaSkVvT2lXcHRhTStX?=
 =?utf-8?B?L3BHVE5qVjRrSlpLaWZOM2NWb2s2U2tKeVBqWS9qTGNOOTVNRVRJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b167d2b-b7ee-40a4-bab7-08deaf86fd8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:59:05.1852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6Bbcn/BSwEL3lr6hBrwIC0reWUs+oAk4RXIhN1fTDohFb6oUe+xuT52Sa5mrWDtstp9PHmKlOpD0G8YD63w7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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


On 11-05-2026 11:20 pm, Christian König wrote:
> On 4/23/26 12:43, Khatri, Sunil wrote:
>> On 21-04-2026 06:25 pm, Christian König wrote:
>>> It is illegal to schedule reset work from another reset work!
>>>
>>> Fix this by scheduling the userq reset work directly on the work queue
>>> of the reset domain.
>>>
>>> Not fully tested, I leave that to the IGT test cases.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 84 +++++++++++-----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 16 ++++-
>>>   4 files changed, 60 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 39894e38fee4..17341e384caf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1191,7 +1191,6 @@ struct amdgpu_device {
>>>   	bool                            apu_prefer_gtt;
>>>   
>>>   	bool                            userq_halt_for_enforce_isolation;
>>> -	struct work_struct              userq_reset_work;
>>>   	struct amdgpu_uid *uid_info;
>>>   
>>>   	struct amdgpu_uma_carveout_info uma_info;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index b11c4b5fa8fc..cf61be17e061 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3786,7 +3786,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>   	}
>>>   
>>>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>> -	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>>>   
>>>   	amdgpu_coredump_init(adev);
>>>   
>>> @@ -5477,7 +5476,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>>>   	if (!amdgpu_sriov_vf(adev))
>>>   		cancel_work(&adev->reset_work);
>>>   #endif
>>> -	cancel_work(&adev->userq_reset_work);
>>> +	amdgpu_userq_mgr_cancel_reset_work(adev);
>>>   
>>>   	if (adev->kfd.dev)
>>>   		cancel_work(&adev->kfd.reset_work);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 0a4c39d83adc..ad6dac17dd21 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -82,19 +82,11 @@ static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
>>>   	return false;
>>>   }
>>>   
>>> -static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
>>> -{
>>> -	if (amdgpu_device_should_recover_gpu(adev)) {
>>> -		amdgpu_reset_domain_schedule(adev->reset_domain,
>>> -					     &adev->userq_reset_work);
>>> -		/* Wait for the reset job to complete */
>>> -		flush_work(&adev->userq_reset_work);
>>> -	}
>>> -}
>>> -
>>> -static int
>>> -amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>> +static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>>>   {
>>> +	struct amdgpu_userq_mgr *uq_mgr =
>>> +		container_of(work, struct amdgpu_userq_mgr,
>>> +			     reset_work);
>>>   	struct amdgpu_device *adev = uq_mgr->adev;
>>>   	const int queue_types[] = {
>>>   		AMDGPU_RING_TYPE_COMPUTE,
>>> @@ -103,12 +95,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>>   	};
>>>   	const int num_queue_types = ARRAY_SIZE(queue_types);
>>>   	bool gpu_reset = false;
>>> -	int r = 0;
>>> -	int i;
>>> +	int i, r;
>>>   
>>>   	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>>>   		dev_err(adev->dev, "userq reset disabled by debug mask\n");
>>> -		return 0;
>>> +		return;
>>>   	}
>>>   
>>>   	/*
>>> @@ -116,7 +107,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>>   	 * skip all reset detection logic
>>>   	 */
>>>   	if (!amdgpu_gpu_recovery)
>>> -		return 0;
>>> +		return;
>>>   
>>>   	/*
>>>   	 * Iterate through all queue types to detect and reset problematic queues
>>> @@ -141,10 +132,19 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>>   		}
>>>   	}
>>>   
>>> -	if (gpu_reset)
>>> -		amdgpu_userq_gpu_reset(adev);
>>> +	if (gpu_reset) {
>>> +		struct amdgpu_reset_context reset_context;
>>>   
>>> -	return r;
>>> +		memset(&reset_context, 0, sizeof(reset_context));
>>> +
>>> +		reset_context.method = AMD_RESET_METHOD_NONE;
>>> +		reset_context.reset_req_dev = adev;
>>> +		reset_context.src = AMDGPU_RESET_SRC_USERQ;
>>> +		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>> +		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
>>> +
>>> +		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>>> +	}
>>>   }
>>>   
>>>   static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>> The function and the work handler for are using the same name and it causes confusion to understand.
>> queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
>>                             msecs_to_jiffies(timeout_ms)); The queued item here call the work item where the function name is same , so its better if we can keep a different name
> Mhm, usually it is good practice for naming the function and the work item similary.
>
> Why do you see an issue with that?
There is no issue but i got confused with hang_detect_work then 
amdgpu_userq_hang_detect_work and i guess there are more similar 
names... But it's ok, functionality wise it looks good to me.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri

>
> Thanks,
> Christian.
>
>> Regards
>> Sunil Khatri
>>
>>> @@ -153,7 +153,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>>>   		container_of(work, struct amdgpu_usermode_queue,
>>>   			     hang_detect_work.work);
>>>   
>>> -	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
>>> +	/*
>>> +	 * Don't schedule the work here! Scheduling or queue work from one reset
>>> +	 * handler to another is illegal if you don't take extra precautions!
>>> +	 */
>>> +	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
>>>   }
>>>   
>>>   /*
>>> @@ -182,8 +186,8 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>>>   		break;
>>>   	}
>>>   
>>> -	schedule_delayed_work(&queue->hang_detect_work,
>>> -		     msecs_to_jiffies(timeout_ms));
>>> +	queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
>>> +			   msecs_to_jiffies(timeout_ms));
>>>   }
>>>   
>>>   void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>>> @@ -1256,28 +1260,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>>   	if (ret) {
>>>   		drm_file_err(uq_mgr->file,
>>>   			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>>> -		amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>> +		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
>>> +					     &uq_mgr->reset_work);
>>> +		flush_work(&uq_mgr->reset_work);
>> Flush work is called here with userq_mutex held? Is it ok to run for that long time and not sure about it but the flush_work might try to take the userq_mutex again, that was problem initially during reset.
>>>   	}
>>>   	return ret;
>>>   }
>>>   
>>> -void amdgpu_userq_reset_work(struct work_struct *work)
>>> -{
>>> -	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>>> -						  userq_reset_work);
>>> -	struct amdgpu_reset_context reset_context;
>>> -
>>> -	memset(&reset_context, 0, sizeof(reset_context));
>>> -
>>> -	reset_context.method = AMD_RESET_METHOD_NONE;
>>> -	reset_context.reset_req_dev = adev;
>>> -	reset_context.src = AMDGPU_RESET_SRC_USERQ;
>>> -	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>> -	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
>>> -
>>> -	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>>> -}
>>> -
>>>   static void
>>>   amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>>   {
>>> @@ -1311,9 +1300,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>>   	userq_mgr->file = file_priv;
>>>   
>>>   	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>>> +	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
>>>   	return 0;
>>>   }
>>>   
>>> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev)
>>> +{
>>> +	struct xarray *xa = &adev->userq_doorbell_xa;
>>> +	struct amdgpu_usermode_queue *queue;
>>> +	unsigned long flags, queue_id;
>>> +
>>> +	xa_lock_irqsave(xa, flags);
>>> +	xa_for_each(xa, queue_id, queue) {
>>> +		cancel_delayed_work(&queue->hang_detect_work);
>>> +		cancel_work(&queue->userq_mgr->reset_work);
>>> +	}
>>> +	xa_unlock_irqrestore(xa, flags);
>>> +}
>>> +
>>>   void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
>>>   {
>>>   	cancel_delayed_work_sync(&userq_mgr->resume_work);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 85f460e7c31b..49b33e2d6932 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -84,7 +84,13 @@ struct amdgpu_usermode_queue {
>>>   	u32			xcp_id;
>>>   	int			priority;
>>>   	struct dentry		*debugfs_queue;
>>> -	struct delayed_work hang_detect_work;
>>> +
>>> +	/**
>>> +	 * @hang_detect_work:
>>> +	 *
>>> +	 * Delayed work which runs when userq_fences time out.
>>> +	 */
>>> +	struct delayed_work	hang_detect_work;
>>>   	struct kref		refcount;
>>>   
>>>   	struct list_head	userq_va_list;
>>> @@ -116,6 +122,13 @@ struct amdgpu_userq_mgr {
>>>   	struct amdgpu_device		*adev;
>>>   	struct delayed_work		resume_work;
>>>   	struct drm_file			*file;
>>> +
>>> +	/**
>>> +	 * @reset_work:
>>> +	 *
>>> +	 * Reset work which is used when eviction fails.
>>> +	 */
>>> +	struct work_struct		reset_work;
>>>   	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
>>>   };
>>>   
>>> @@ -134,6 +147,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>>>   			  struct amdgpu_device *adev);
>>>   
>>> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
>>>   void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>>>   
