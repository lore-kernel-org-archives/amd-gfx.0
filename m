Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F93CC43602
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 10:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33B310EEDC;
	Wed,  1 Jul 2026 10:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oq3HzeKe";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EA710EED2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 10:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz0NYNSW952ORQ4+bCzI3b0hygIQu37DXzxkfmMtXJJsSb2vPr2aOP951o8kdu+XDhIjpXroxxPIi8awnz1djW0HZPcOsDLgln847Uy2WMnJ9cJIKprq2OZqtt4YZbZpSxZ00+BjGren+sCWgbBMxfYTJgcmAUYi6Sd76SQvwAKBbxE1jIYq4YsiF1NelaV/3Tp0l6XI/kX8ZnxIWVq0hL7Z17ZcqkpvP+LoZpINPoBBsbg5rtrGniIXC00TDCbhmwRJZ3s65poEwO3dZVF4T1khoZZFr1yeL5iX62WkpL7ZiJFwoOGBmXvfT0gxvkv8E7E5g53TppQ6Bo4F5QVEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy69dojHpiMs8y/a6nTh4NfW2I7L25PxNyqDEDR5Cis=;
 b=DICewrTe1z8gvfGD9RCrNNPQJ+bQp/yW8Ojx+t9bNarHrjj81hzKfrlaWDrfaqu0AstN2SkDACO78ldph4VIMt9mH6zmGGq3jy2XMUNOwH17ocJULbAsqECMtrdeG8xwVLAbKVdwvIJg0e5Cy10KIIorqQTj8MACr8zU/UnLV6TPGGI4OM1AA2Llus2noGY+pHacLh7B/SuiDOFuK4Es9dOzoR2mek2IGBqs8B0k9nbCqDB+RMVgs8B/AdmabpfJVzJGEv304nNXmnY7TGWIzpt8pFulzneuXTlKKMocuy4mJAaw847ByAQDi4ClsqBM3HFjD6zvIM88cXR1Fd3Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy69dojHpiMs8y/a6nTh4NfW2I7L25PxNyqDEDR5Cis=;
 b=oq3HzeKepL5phyz+j5Bu1+8am3Q5Prh2aD5JHm/MdbuDSRNKr+3ZW7J19I0BHhLYnTCGSbbctPvy8auWD39VyIyz/6eaozhp53D2xhHm3GncAtElwbcLrExTb06uxnoKcTIkgjj2Vi8VtHlhaFRzLrWGhl0g4wGXXQ09FDMZPho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:51:37 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:51:37 +0000
Content-Type: multipart/alternative;
 boundary="------------pkpbmRF5TdiZG72mViemwJsJ"
Message-ID: <6c2a8b01-bf87-48f0-baef-3a8e5ac94d20@amd.com>
Date: Wed, 1 Jul 2026 18:51:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260617065442.16432-1-lingshan.zhu@amd.com>
 <c76044ce-6466-4909-b3d5-6ef13df192a9@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <c76044ce-6466-4909-b3d5-6ef13df192a9@amd.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 88218d12-706d-4c13-e405-08ded75eb929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|8096899003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: iiIZISvO2mn/C1s6+Dt9lzwg9lxGfq8WgPLe8/QMndLpfW3hGlorRDqbL629otVlePvGj/mkxZWxSCvCfiymMuBWmPQF0twlgsISPZRg9qJIKRLRjxocHUg6I5yy96spVz0Jbye4Fxkz16fgH3nAtYHoSLH75Rc3IS1BHxK/JFv3IEeExQ72zSaG5qkF0Xl2INlyTXLdAj4JxQqdIsoYPw5F7ARi5eYyNmHa4n0NA4tC95bFsZXD6/aJ7zrOLgHEeyaOedaWICBRoXscDCDNvnzfWQ0EDUWWuHKRiqi6sZFCAYfqVp6pswIla9w4QS8+SkBHe/LHuECbgYjfQVE3akf9SlsHs3nt6fsHnLs6a3tVH5LzL7T7QR+zRDIOvQpXUGXibaitlihbdYAJdiYNEbr8GHpO/nwAVWPgQrKumvRiTYLKvhtube6mvEu1bv+ipewbtzIuQ+aWpEuatQ7eDwCCwmAU+wWV90OWrBb9aNGw/rQX56tcbHUS9DlBWXTy1NwUHPgB1M2mJSrxwivCSMuI6h+Im63Q8A1RrDcy0is7wDH5A/e0jR2nnNXkvLuobvHwH+faVwamCVDqjyjEyvG+0ERWqiGJKYhuupFSYZLiIwU5/0quUr+sP8i3b063sKg0qPT3+Q4vWbCi+InCvSXku4IxnasrXqE/SU7CmKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(8096899003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZ2cEFJSnBVZUYrU3pRcFlITk9OdTQyNll1K3c2cS9HRkJyYmZYNGQwcVVF?=
 =?utf-8?B?c3BITkFWTGxMdU9hbEFqdHBsMXpEVzl6TTVyNVZBa1hCTEJ5OXlGaVVBemxQ?=
 =?utf-8?B?T25yMFdEN1VkcWNrTERZSVFNOUJuQ3hjMkFYTW0wL2tJbFF2VUxPMDVraHNv?=
 =?utf-8?B?T3l4NHp6VnBkbVBqVjZTSHJoMTdwaEV0V0Q1b2RYVUkvUWVNR2szdDJXVVRE?=
 =?utf-8?B?R2FDSEl6dlhadDg5cjF3TFphUDBOVnZXZ09jaWNTakxtVFY4ekRzaFZ4RHhr?=
 =?utf-8?B?VWJ1a2gwbUtiellnY0FLQlJ2RkRIMkV4VzFEbWZ3eWhDSm11VzAxOUpkSGJT?=
 =?utf-8?B?NmNSekpOQjQwTHAwaUtGK1Nkd1lQNWFkUFN1WElYcnpxOU5uS1FBeTlZOE5Y?=
 =?utf-8?B?czhuVmgyTmRxMXFFdWlIUjF1aVFmZ1VreEVTb0RadHl2cklHS0VhaTF2ZnJu?=
 =?utf-8?B?N1U5My8zanIwRUQ0T3crRmNBN0xPNVBUMDZ4UTBHSjByVmlrajd5eVhBK3BW?=
 =?utf-8?B?WXJ1dENMcXYxOE5YM09aaDNQeVZ4YnRybVdMZ0krZHBEL3pTdVFiY1dDbXoz?=
 =?utf-8?B?MVJjaWEveWxJYUpGdFI4MUdwMkZYeGplN2tZZy9MMXo3dXEzWjJYaHJHS0R3?=
 =?utf-8?B?UUJyV3F3SzYwcTByM1ZtZkQybGRtaUdwS3NJQy9tbUkzemVLK0tQeGVFaFpz?=
 =?utf-8?B?QVlMcHpmOGdnSFFleXBMU2E4OGt3bE9LRU5DNkhwRlppdm52aFNrbXVOWXla?=
 =?utf-8?B?OG40ckU1NzArUWUyTHFiaUZ1dHNqYzBJM3VRZzlBU2JSY0V2dmxKL3hzbmo3?=
 =?utf-8?B?d0tQQmx4akx6YVJNdGdtMnJoaHZuY1p1R21wYS8vRFI4eDlxUE1uRlJEOTJv?=
 =?utf-8?B?QUJGaTFTYkhybUM3cVZyMjRUMW9mZERTbjNEczJYMnpBRit6bjVFK3I1TmZp?=
 =?utf-8?B?bndiVGNYcXd6RXNRd1cvQS92ZnArTlg1YngyeTk0dFdSNkhnVzllTTdmL0NT?=
 =?utf-8?B?clA1azZVNjcvQmdmbWpTc0JySFZOV2FCZTBueGtoeWVrQ0RZaElteHJIRjJV?=
 =?utf-8?B?U25QR20xOVRsenRpR3JJNEVKRzhwdjUyYitJU2QxWXBud1dxY2ZXZ2puYnBz?=
 =?utf-8?B?Y3AxRVM3eXZkeVpQbkthNEZzM1p0cTFtU0YweE83KzJ5TCtyK3ptQnc4UHZD?=
 =?utf-8?B?UU1IV0pTVmVkdG1iYmNBN3ZkUjBrNFNJUEIrWXBBUHRVai94RXpmaEZoSHcv?=
 =?utf-8?B?T09mQ25telpqcEJteUI1MXg1ZUxGZVZ3UkttbU40bXZLamJJNEpwd3ROZlhp?=
 =?utf-8?B?b3pobzFjcFNVaDVZQkViSFhWaDBHVC9jWTFJY3VxeHZhdCtFTU55emJPK2pP?=
 =?utf-8?B?bUo2R1ZMR1h2UXB2WkhRQU4rWHB5VEtkZEFmVTl3d2ZwL0FLMXRFZm4xc08w?=
 =?utf-8?B?eko0cnBudG5UTE9RWkpJV0o0UUZuU1Y4M1Q0TzJpWHBzL2tLYkE5a0RIK0Rn?=
 =?utf-8?B?MXdrdkRCVjRITHpGZHNhTDVmZGRidGx6SllJTVUvNGp0UFErQkU2UzFWc00r?=
 =?utf-8?B?R2MrTklUeTdGTGE4S3JzNFFwRWVhdUJIT0VEeXhva0pwZXBzMlhJQ0FkdDht?=
 =?utf-8?B?dWhpeE90RU5reVlpVnhHSkNFWTFJUWNUUzBlZXQrWUJtRmtzTzRmcHZrbDRQ?=
 =?utf-8?B?NmZMMk1CZ2J3TjlsMnZNMFlsQnBDaThoV3VKOTYrdVIwR0ROeklEUFFRZXVv?=
 =?utf-8?B?Ynh5VkkrMlJZMkQxSHdaNlhsY0lXTXF1eUExaTRpc2dRMG5WRWFWT3pyZnRa?=
 =?utf-8?B?VUFtWnZsSnVyY2tOLzFtd2RMTURxczR6UXJmdjZRdStCNE1veFpLOVczS1pB?=
 =?utf-8?B?NTJGZmFwNTBxWXBQNnlKUFhpMlYzajV4OGg2TXp0SVhla1l0amcvZGVFc1Fp?=
 =?utf-8?B?U3Q1Q0NaeFl2ZDNkVklhNnFTeFZYcEY2WHpkSWlxODRJK3BPTDZMUVdaNkJy?=
 =?utf-8?B?NjEvYllNTkMva09mOUVvczYrMGZZQVQzeklvamlZMVZZTmpFRVIrckc0anRj?=
 =?utf-8?B?eUJpdXkyTUxqdlpIWmphQ3VYY1E0eTlYU3VDS2p1bjVvQTJ0TmRiTUljWW55?=
 =?utf-8?B?ZXFiampsQmhlRnRvSXFMWUpFMHczQkh3OFlLZU40U28rZ0xIOE81em9VREFj?=
 =?utf-8?B?MWpZMVZkWkY5V3UyZjFyNVpiN3BBUzhaRFRic0lJZGsxU3YzYld0bUpQM045?=
 =?utf-8?B?RlNMc0RyaXZXbGxhTlhHNzNoRjRPOW54bVlHcXU1eWRkdHpodkl5Q2RKeHF5?=
 =?utf-8?Q?YCdy8IwuCKCIe/htqM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88218d12-706d-4c13-e405-08ded75eb929
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:51:37.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/jzEZ/oV/DZYdNM+/eVG2xcpmMQz2/DQUE91SYmwv6uSvn0OaP935uuskAq6l5YRHT5OI8kqHHpiWmeUIS4Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

--------------pkpbmRF5TdiZG72mViemwJsJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/2026 5:13 PM, Christian König wrote:

> On 6/17/26 08:54, Zhu Lingshan wrote:
>> amdgpu_bo_create_reserved() only allocates a new BO when
>> *bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
>> NULL, it simply skips creation when *bo_ptr is non-NULL.
>> But it unconditionally reserves, pins, gart allocates
>> and maps the BO afterwards.
>>
>> When the same non-NULL BO pointer is passed in again,
>> for example firmware buffers that live in adev and are
>> re-loaded on every resume / cp_resume / start
>> under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
>> pin_count unconditionally, however the matching teardown only unpins
>> once, so pin_count never drops to zero, so TTM is not able
>> to move, swap or evict a BO, causing BO leaks.
> That's a good catch.
>
>> Ideally the BO should only be pinned once at creation. So this commit
>> splits current amdgpu_bo_create_reserved() into two helpers:
>>
>>  - amdgpu_bo_create_pinned(): create + reserve + pin + alloc_gart and
>>    return the BO unreserved. It requires *bo_ptr == NULL on entry,
>>    so only pins the BO once.
> That sounds like a bad idea to me, just move the pinning under the if as well.
>
> This just creates a wrapper function for a wrapper function.

Yeah, that is a good idea, will send V2 soon.

Thanks
Lingshan

>
> Regards,
> Christian.
>
>>  - amdgpu_bo_get_access(): reserve + map gpu/cpu addr + unreserve.
>>    This function is idempotent and is safe to call multiple times
>>    on an existing pinned BO, for example, on every resume path.
>>
>> amdgpu_bo_create_reserved() now calls amdgpu_bo_create_pinned()
>> only when *bo_ptr is NULL, then calls amdgpu_bo_get_access() for
>> CPU/GPU address mapping, and reserves the BO before returning.
>> Repeated calls no longer take additional pin references.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 175 +++++++++++++++++----
>>  1 file changed, 143 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4dd7c712b8c3..dd0a59137028 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -217,57 +217,53 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>  }
>>  
>>  /**
>> - * amdgpu_bo_create_reserved - create reserved BO for kernel use
>> + * amdgpu_bo_create_pinned - create and pin a BO for kernel use
>>   *
>>   * @adev: amdgpu device object
>>   * @size: size for the new BO
>>   * @align: alignment for the new BO
>>   * @domain: where to place it
>> - * @bo_ptr: used to initialize BOs in structures
>> - * @gpu_addr: GPU addr of the pinned BO
>> - * @cpu_addr: optional CPU address mapping
>> + * @bo_ptr: used to return the newly created BO, must point to NULL on entry
>> + * @cpu_access: true if the BO needs to be CPU accessible
>>   *
>> - * Allocates and pins a BO for kernel internal use, and returns it still
>> - * reserved.
>> + * Allocates and pins a BO for kernel internal use, and returns it unreserved
>>   *
>> - * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
>> + * Note: *bo_ptr must be NULL on entry, this helper always creates
>> + * a new BO and never reuses an existing one,
>> + * so it never pins the same BO twice.
>>   *
>>   * Returns:
>>   * 0 on success, negative error code otherwise.
>>   */
>> -int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>> -			      unsigned long size, int align,
>> -			      u32 domain, struct amdgpu_bo **bo_ptr,
>> -			      u64 *gpu_addr, void **cpu_addr)
>> +static int amdgpu_bo_create_pinned(struct amdgpu_device *adev,
>> +				   unsigned long size, int align,
>> +				   u32 domain, struct amdgpu_bo **bo_ptr,
>> +				   bool cpu_access)
>>  {
>>  	struct amdgpu_bo_param bp;
>> -	bool free = false;
>>  	int r;
>>  
>> -	if (!size) {
>> -		amdgpu_bo_unref(bo_ptr);
>> -		return 0;
>> -	}
>> +	if (WARN_ON(!bo_ptr || *bo_ptr))
>> +		return -EINVAL;
>> +
>> +	if (WARN_ON(!size))
>> +		return -EINVAL;
>>  
>>  	memset(&bp, 0, sizeof(bp));
>>  	bp.size = size;
>>  	bp.byte_align = align;
>>  	bp.domain = domain;
>> -	bp.flags = cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
>> +	bp.flags = cpu_access ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
>>  		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>  	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>  	bp.type = ttm_bo_type_kernel;
>>  	bp.resv = NULL;
>>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>  
>> -	if (!*bo_ptr) {
>> -		r = amdgpu_bo_create(adev, &bp, bo_ptr);
>> -		if (r) {
>> -			dev_err(adev->dev, "(%d) failed to allocate kernel bo\n",
>> -				r);
>> -			return r;
>> -		}
>> -		free = true;
>> +	r = amdgpu_bo_create(adev, &bp, bo_ptr);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r);
>> +		return r;
>>  	}
>>  
>>  	r = amdgpu_bo_reserve(*bo_ptr, false);
>> @@ -288,27 +284,142 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>>  		goto error_unpin;
>>  	}
>>  
>> +	amdgpu_bo_unreserve(*bo_ptr);
>> +	return 0;
>> +
>> +error_unpin:
>> +	amdgpu_bo_unpin(*bo_ptr);
>> +error_unreserve:
>> +	amdgpu_bo_unreserve(*bo_ptr);
>> +error_free:
>> +	amdgpu_bo_unref(bo_ptr);
>> +	return r;
>> +}
>> +
>> +/**
>> + * amdgpu_bo_get_access - get CPU/GPU access to a BO
>> + *
>> + * @bo: the input BO, must be pinned
>> + * @gpu_addr: optional, returns the GPU address of the BO
>> + * @cpu_addr: optional, returns the CPU address of the BO
>> + *
>> + * Note: *bo must be already pinned!
>> + *
>> + * Returns:
>> + * 0 on success, negative error code otherwise.
>> + */
>> +static int amdgpu_bo_get_access(struct amdgpu_bo *bo, u64 *gpu_addr,
>> +				void **cpu_addr)
>> +{
>> +	struct amdgpu_device *adev;
>> +	int r;
>> +
>> +	if (WARN_ON(!bo))
>> +		return -EINVAL;
>> +
>> +	adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> +
>> +	r = amdgpu_bo_reserve(bo, false);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
>> +		return r;
>> +	}
>> +
>> +	/*
>> +	 * The BO must already be pinned. A GPU or CPU address of an
>> +	 * unpinned BO would become meaningless because TTM
>> +	 * may then move or evict it at any time.
>> +	 */
>> +	if (WARN_ON_ONCE(!bo->tbo.pin_count)) {
>> +		r = -EINVAL;
>> +		goto error_unreserve;
>> +	}
>> +
>>  	if (gpu_addr)
>> -		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
>> +		*gpu_addr = amdgpu_bo_gpu_offset(bo);
>>  
>>  	if (cpu_addr) {
>> -		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
>> +		r = amdgpu_bo_kmap(bo, cpu_addr);
>>  		if (r) {
>>  			dev_err(adev->dev, "(%d) kernel bo map failed\n", r);
>> -			goto error_unpin;
>> +			goto error_unreserve;
>>  		}
>>  	}
>>  
>> +	amdgpu_bo_unreserve(bo);
>>  	return 0;
>>  
>> -error_unpin:
>> -	amdgpu_bo_unpin(*bo_ptr);
>>  error_unreserve:
>> -	amdgpu_bo_unreserve(*bo_ptr);
>> +	amdgpu_bo_unreserve(bo);
>> +	return r;
>> +}
>> +
>> +/**
>> + * amdgpu_bo_create_reserved - create reserved BO for kernel use
>> + *
>> + * @adev: amdgpu device object
>> + * @size: size for the new BO
>> + * @align: alignment for the new BO
>> + * @domain: where to place it
>> + * @bo_ptr: used to initialize BOs in structures
>> + * @gpu_addr: GPU addr of the pinned BO
>> + * @cpu_addr: optional CPU address mapping
>> + *
>> + * Allocates and pins a BO for kernel internal use, and returns it still
>> + * reserved.
>> + *
>> + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL. An
>> + * existing BO is only re-accessed (get CPU/GPU mapping) and not pinned again,
>> + * so repeated calls with the same BO do not leak pin references.
>> + *
>> + * Returns:
>> + * 0 on success, negative error code otherwise.
>> + */
>> +int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>> +			      unsigned long size, int align,
>> +			      u32 domain, struct amdgpu_bo **bo_ptr,
>> +			      u64 *gpu_addr, void **cpu_addr)
>> +{
>> +	bool created = false;
>> +	int r;
>> +
>> +	if (WARN_ON(!bo_ptr))
>> +		return -EINVAL;
>> +
>> +	if (!size) {
>> +		amdgpu_bo_unref(bo_ptr);
>> +		return 0;
>> +	}
>> +
>> +	if (!*bo_ptr) {
>> +		r = amdgpu_bo_create_pinned(adev, size, align, domain, bo_ptr,
>> +					    !!cpu_addr);
>> +		if (r)
>> +			return r;
>> +		created = true;
>> +	}
>> +
>> +	r = amdgpu_bo_get_access(*bo_ptr, gpu_addr, cpu_addr);
>> +	if (r)
>> +		goto error_free;
>> +
>> +	r = amdgpu_bo_reserve(*bo_ptr, false);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
>> +		goto error_free;
>> +	}
>> +
>> +	return 0;
>>  
>>  error_free:
>> -	if (free)
>> +	if (created) {
>> +		if (amdgpu_bo_reserve(*bo_ptr, true) == 0) {
>> +			amdgpu_bo_kunmap(*bo_ptr);
>> +			amdgpu_bo_unpin(*bo_ptr);
>> +			amdgpu_bo_unreserve(*bo_ptr);
>> +		}
>>  		amdgpu_bo_unref(bo_ptr);
>> +	}
>>  
>>  	return r;
>>  }
--------------pkpbmRF5TdiZG72mViemwJsJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/1/2026 5:13 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:c76044ce-6466-4909-b3d5-6ef13df192a9@amd.com">
      <pre wrap="" class="moz-quote-pre">On 6/17/26 08:54, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">amdgpu_bo_create_reserved() only allocates a new BO when
*bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
NULL, it simply skips creation when *bo_ptr is non-NULL.
But it unconditionally reserves, pins, gart allocates
and maps the BO afterwards.

When the same non-NULL BO pointer is passed in again,
for example firmware buffers that live in adev and are
re-loaded on every resume / cp_resume / start
under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
pin_count unconditionally, however the matching teardown only unpins
once, so pin_count never drops to zero, so TTM is not able
to move, swap or evict a BO, causing BO leaks.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That's a good catch.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Ideally the BO should only be pinned once at creation. So this commit
splits current amdgpu_bo_create_reserved() into two helpers:

 - amdgpu_bo_create_pinned(): create + reserve + pin + alloc_gart and
   return the BO unreserved. It requires *bo_ptr == NULL on entry,
   so only pins the BO once.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That sounds like a bad idea to me, just move the pinning under the if as well.

This just creates a wrapper function for a wrapper function.</pre>
    </blockquote>
    <pre>Yeah, that is a good idea, will send V2 soon.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:c76044ce-6466-4909-b3d5-6ef13df192a9@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
 - amdgpu_bo_get_access(): reserve + map gpu/cpu addr + unreserve.
   This function is idempotent and is safe to call multiple times
   on an existing pinned BO, for example, on every resume path.

amdgpu_bo_create_reserved() now calls amdgpu_bo_create_pinned()
only when *bo_ptr is NULL, then calls amdgpu_bo_get_access() for
CPU/GPU address mapping, and reserves the BO before returning.
Repeated calls no longer take additional pin references.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 175 +++++++++++++++++----
 1 file changed, 143 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..dd0a59137028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -217,57 +217,53 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 }
 
 /**
- * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ * amdgpu_bo_create_pinned - create and pin a BO for kernel use
  *
  * @adev: amdgpu device object
  * @size: size for the new BO
  * @align: alignment for the new BO
  * @domain: where to place it
- * @bo_ptr: used to initialize BOs in structures
- * @gpu_addr: GPU addr of the pinned BO
- * @cpu_addr: optional CPU address mapping
+ * @bo_ptr: used to return the newly created BO, must point to NULL on entry
+ * @cpu_access: true if the BO needs to be CPU accessible
  *
- * Allocates and pins a BO for kernel internal use, and returns it still
- * reserved.
+ * Allocates and pins a BO for kernel internal use, and returns it unreserved
  *
- * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
+ * Note: *bo_ptr must be NULL on entry, this helper always creates
+ * a new BO and never reuses an existing one,
+ * so it never pins the same BO twice.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
-int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
-			      unsigned long size, int align,
-			      u32 domain, struct amdgpu_bo **bo_ptr,
-			      u64 *gpu_addr, void **cpu_addr)
+static int amdgpu_bo_create_pinned(struct amdgpu_device *adev,
+				   unsigned long size, int align,
+				   u32 domain, struct amdgpu_bo **bo_ptr,
+				   bool cpu_access)
 {
 	struct amdgpu_bo_param bp;
-	bool free = false;
 	int r;
 
-	if (!size) {
-		amdgpu_bo_unref(bo_ptr);
-		return 0;
-	}
+	if (WARN_ON(!bo_ptr || *bo_ptr))
+		return -EINVAL;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
 
 	memset(&amp;bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = align;
 	bp.domain = domain;
-	bp.flags = cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
+	bp.flags = cpu_access ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
 		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	if (!*bo_ptr) {
-		r = amdgpu_bo_create(adev, &amp;bp, bo_ptr);
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;(%d) failed to allocate kernel bo\n&quot;,
-				r);
-			return r;
-		}
-		free = true;
+	r = amdgpu_bo_create(adev, &amp;bp, bo_ptr);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;(%d) failed to allocate kernel bo\n&quot;, r);
+		return r;
 	}
 
 	r = amdgpu_bo_reserve(*bo_ptr, false);
@@ -288,27 +284,142 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_unpin;
 	}
 
+	amdgpu_bo_unreserve(*bo_ptr);
+	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(*bo_ptr);
+error_unreserve:
+	amdgpu_bo_unreserve(*bo_ptr);
+error_free:
+	amdgpu_bo_unref(bo_ptr);
+	return r;
+}
+
+/**
+ * amdgpu_bo_get_access - get CPU/GPU access to a BO
+ *
+ * @bo: the input BO, must be pinned
+ * @gpu_addr: optional, returns the GPU address of the BO
+ * @cpu_addr: optional, returns the CPU address of the BO
+ *
+ * Note: *bo must be already pinned!
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+static int amdgpu_bo_get_access(struct amdgpu_bo *bo, u64 *gpu_addr,
+				void **cpu_addr)
+{
+	struct amdgpu_device *adev;
+	int r;
+
+	if (WARN_ON(!bo))
+		return -EINVAL;
+
+	adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
+
+	r = amdgpu_bo_reserve(bo, false);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;(%d) failed to reserve kernel bo\n&quot;, r);
+		return r;
+	}
+
+	/*
+	 * The BO must already be pinned. A GPU or CPU address of an
+	 * unpinned BO would become meaningless because TTM
+	 * may then move or evict it at any time.
+	 */
+	if (WARN_ON_ONCE(!bo-&gt;tbo.pin_count)) {
+		r = -EINVAL;
+		goto error_unreserve;
+	}
+
 	if (gpu_addr)
-		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
+		*gpu_addr = amdgpu_bo_gpu_offset(bo);
 
 	if (cpu_addr) {
-		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
+		r = amdgpu_bo_kmap(bo, cpu_addr);
 		if (r) {
 			dev_err(adev-&gt;dev, &quot;(%d) kernel bo map failed\n&quot;, r);
-			goto error_unpin;
+			goto error_unreserve;
 		}
 	}
 
+	amdgpu_bo_unreserve(bo);
 	return 0;
 
-error_unpin:
-	amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
-	amdgpu_bo_unreserve(*bo_ptr);
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+/**
+ * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ *
+ * @adev: amdgpu device object
+ * @size: size for the new BO
+ * @align: alignment for the new BO
+ * @domain: where to place it
+ * @bo_ptr: used to initialize BOs in structures
+ * @gpu_addr: GPU addr of the pinned BO
+ * @cpu_addr: optional CPU address mapping
+ *
+ * Allocates and pins a BO for kernel internal use, and returns it still
+ * reserved.
+ *
+ * Note: For bo_ptr new BO is only created if bo_ptr points to NULL. An
+ * existing BO is only re-accessed (get CPU/GPU mapping) and not pinned again,
+ * so repeated calls with the same BO do not leak pin references.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
+			      unsigned long size, int align,
+			      u32 domain, struct amdgpu_bo **bo_ptr,
+			      u64 *gpu_addr, void **cpu_addr)
+{
+	bool created = false;
+	int r;
+
+	if (WARN_ON(!bo_ptr))
+		return -EINVAL;
+
+	if (!size) {
+		amdgpu_bo_unref(bo_ptr);
+		return 0;
+	}
+
+	if (!*bo_ptr) {
+		r = amdgpu_bo_create_pinned(adev, size, align, domain, bo_ptr,
+					    !!cpu_addr);
+		if (r)
+			return r;
+		created = true;
+	}
+
+	r = amdgpu_bo_get_access(*bo_ptr, gpu_addr, cpu_addr);
+	if (r)
+		goto error_free;
+
+	r = amdgpu_bo_reserve(*bo_ptr, false);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;(%d) failed to reserve kernel bo\n&quot;, r);
+		goto error_free;
+	}
+
+	return 0;
 
 error_free:
-	if (free)
+	if (created) {
+		if (amdgpu_bo_reserve(*bo_ptr, true) == 0) {
+			amdgpu_bo_kunmap(*bo_ptr);
+			amdgpu_bo_unpin(*bo_ptr);
+			amdgpu_bo_unreserve(*bo_ptr);
+		}
 		amdgpu_bo_unref(bo_ptr);
+	}
 
 	return r;
 }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------pkpbmRF5TdiZG72mViemwJsJ--
