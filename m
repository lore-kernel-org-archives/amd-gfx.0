Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A1606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5NTFDHxS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB731125FD;
	Fri, 13 Nov 2026 14:45:59 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7151125FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzekO09wHphK4DK9arKP5HfVcsXCLvw93+zsNqhx28hfU5OGITS6UCxRSl6XFNzcm60bNJRmWNJDcy/BDGbvnoS0qAOl5l2nUfI5RWYIydVmTQT1xHPKFGMFae+I5gQ3rtMY9LuloOMmpHTl87atxzOb9HDL30Ltz6qXvNRPwLiq4vA9XkXfWzpsEuHwzoBks9qzeI1zjgUxoii1z2uNzK2lIFq6RjRQTG4BYgBrHLALy4+b8uh6ukQj1qGEEZpE424bU3tkSsacGD4vQiKEZFOTtaEFyDqn0hJY+3FgIzDporCFO6QhRarJdE0KXJR/4ZbWHQy8LlSoWTgJgVy8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zik5QIcS3N8GV6vy/LDt7TVPy6QW7QnpwlDG7a1JaWg=;
 b=Xszg/tlSatCQV6VXSteVNH+mNfuZ29JwCkfN7B486NyPJOHZ0f5mePiHeJ55x2Nc1d5cnCThjekxqL/ck1uMx27HwJdxdncamUAVUTb4bwsZ6TaC5rUTS804DH7mrLxhnXjbu1gdtFdQTsSk1BOojDBogaaTxcxza3wrWmFlcb6m7Vk6eFa16SxZyDvnkkFHr1ddV2mRgLbBnB6U4v7WSlTlhO4E7V0GuYjGNmLaqip9SBoToAWoiWZgBVO84takQBDaeIzDV3UnebhXhzOVsBSErJ1BzJFoUzS6nna4nGB2TB/wIKYvoiGKynzU/d91mplJy/PCQnlzJrDMmlYsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zik5QIcS3N8GV6vy/LDt7TVPy6QW7QnpwlDG7a1JaWg=;
 b=5NTFDHxSTZEKB69E7ZDuEUa9waQUKV/MnniN+RS7DGIRfG0uFCws0aPEXOSjlILaOOtbhFvTW852XL3hdN+vEadlc6VxghiS1h7O5bjuCDrpXGFr+ceEa2Svl0MLbdZxvu6PsC6Rj4Hzr7gEpSAv+LdUTpmVenQHvdlS9y17JCE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 14:45:49 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 14:45:49 +0000
Message-ID: <39c478fd-5b7d-4220-a503-b12cc1abd6b2@amd.com>
Date: Fri, 13 Nov 2026 09:45:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
 <bfc53181-53ac-49f8-b243-95b23999a638@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <bfc53181-53ac-49f8-b243-95b23999a638@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::16) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0b041f-a3c8-41d5-39e7-08df4194ce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|4143699003|11063799006|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|56012099006|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: ljDv8sC9NV+AOmFU4Niej8D/uqFIQlV2cakoyVNHWmsTCjulR+Se5aPdNz+GQDhKpaXoIaz/7+gGQt1PMzO33LJnEN+gfBEAqNyg4FmLfk/EYbTzw9nOXxs3ftXrRjFtM1D1LEP0g/3rvGjieGxeqS/GhYmP30qmDvBFzHYEtu09vsL6AEf1P3qAugnz8Ysbxv4xLRwjKCKhFiNodBGDNrfKzBZZzV4QU9KuzL5jNetVKI6bLoYadAY4jRtdYYwsOqRrHArTDOD4EQz9+3eAPIGKrHeRx0ZT9J1ivLDNyfFM9Q413+dKy748+ws4EWPvEL4b3AdslC6ZeS7icFARFnFyaExtO4L5xf21rwpxwK5TBA7vy5AEAutKdb3CYYLyTRNX0EmfMn3jcw1VshmF65qmyNiAOYPwch+iYzEQXK8sk90rB9pnzbgwEtalRbK9iL/05U9i3TbRlem6QPhKqTIN3B9oRphtJqgIicKzhhKiG2gkSuGbmYoP1gK1y9d3y6W8Pau1uU4imXC4e4htBVNNRG/eoFFyljzvPxHnuamZqHV3rOcoIAyjJx7TjPTsrOpleb/OAM4LDJxUvTBUWRodMHDv/UlZYJ82dh1AuMI2rQngE7fUeclbCAtyu1n/VvYkH+48wmxsG8FoTB67WoHHwc7YUYwME/ozqrbeQMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dCYVJJZ0lRMDY5RlhCOU14UmUxMFlpcmZyck1iLzNuZHBGclJDNDNpcytC?=
 =?utf-8?B?OE5YQW80cUl2ajNtcUp1eFZ6KzRVUnhncnJ0NXU5S3R1K3VTR3VObThRQ2JK?=
 =?utf-8?B?aTV2bVBwaHI3RTllaXRTaGJqbEplc3RUMTVMbk5Sb2pqcDFHaG1wOER0VWdQ?=
 =?utf-8?B?YW1ZeDA3aTFCM1VPMGpFYUs5WklRaEZ3ZFBERkFjbjhORzNjNmxXT0FyRjNC?=
 =?utf-8?B?YjlLd1NEbkEwWUF4SUxvMzV2Rm1UaStJWTFqaXJ2WitoZ2E0UWJQV2pmc0RH?=
 =?utf-8?B?aE5vRzA5SUZjSGZhUGpOOHR6R1lQb1Rhdzk5TEsyYjFLRWdkQnpkbmtzdmFV?=
 =?utf-8?B?ajhNaGhLRGZEOHo3K1h0RHZMbU4wd0N5SzlzejFhcjhIYTZ6YW93NmdYbzN1?=
 =?utf-8?B?anBXWnpBT2NLK0pmZWt4YkNWZGdwWnhzUnZXbkM4ZytsTGx5dzlpbVA4V1k2?=
 =?utf-8?B?NWZtalVVTVNyV0h0ZGlTc1ZhTmRZMk9IWXdhWmEzOTNLWnZDN2w4bVM3cDJ3?=
 =?utf-8?B?RThDa0JKVE10b1hqeGI5RTAwUnNDQnV1UHJRcitJUHo0bitOVTJ1dUNtRE1S?=
 =?utf-8?B?WTh2bE9CNit5em9yc2pLeWFPVXRrL3p6NXB5ZHZxY2tZTUFJa05LOVI3Mm84?=
 =?utf-8?B?OWMvTCtDQ0lrbmZwaHdaZFkzdGEzTm1rdXZvMS9qMjdUUUV6dlBXQllyVSto?=
 =?utf-8?B?RnhLazdwQ01UQlMzaFF1RGhybFMzZlpCZGd1bGUzeC80YWJyampNQTZHbUpU?=
 =?utf-8?B?dUFESzIrQWxtRnpVSHpjSDcyeDlKQ24yY0NuY05iTFZQQzlWRStnVlNBeE5K?=
 =?utf-8?B?M2E0M0VaVlBDeWtLWmphY0dDUUZiMVBaMjFVN1Y3ZkIzMGxjYUlJWEc5SXdv?=
 =?utf-8?B?U1dkZXdnR2prVyt0OUREM09oU2QrdWd3TS9WWTB6UEtmN3dJV2FuTTUySlY0?=
 =?utf-8?B?YkR1emdQRTFIUUtVTjJJU2hBUGc1bS9Vckw1S3pWU0MzSVIrR0llY3VTZ3JW?=
 =?utf-8?B?ZGdicWZHSzVFNXhsNExxb0xhWTBvcmJKVHFtK2ZwWk02RVgwMUR0bjMzYXI2?=
 =?utf-8?B?d1Z0WXFDaG5wKzVXNk4wYWhGcDAxZGI5bEhaMWpaUXY1SHRueHVVR1VQU3ZV?=
 =?utf-8?B?MkxMb2U1bnZ3M2dCTHdadlRnZ3ZXZ1o3bGJSR0xrRHkwcThNWm1nMGxlMnY3?=
 =?utf-8?B?OEVUODFaREk0dEtjQXhORTdweE1HNUJxVjNnVWlGd0RuNFJsRnNLVjk3RXFB?=
 =?utf-8?B?OHJFWWUxbUJ2RFRNWk5MSDR4TDRKd2JidGV5SFZlVmp4V0U2ZFZody9NbkRB?=
 =?utf-8?B?ZGQ3enJrM1ZGYURUbytzOXpva2h0WjhaU0FPVzhyUmRkZ0RldUpneEF0bEhF?=
 =?utf-8?B?T3FxWUlLeEhOUERwbXVLTTFBRXJUNEdRZStjMjIxQ0JpRS8vK1pycEZWV1k3?=
 =?utf-8?B?eGd0MVd4OGEvSm9kY242cGh4bEFWNHZVdTB6TVRqOUI3ZU9RRm1qVzE4Nnhj?=
 =?utf-8?B?OWlNK01OKzNjdnVBR0FGWWlKcGhKSkJNeDFlSGg1QzZrTy9hbFcyNy9lcXJy?=
 =?utf-8?B?YnRVZzBBUnZYZ3R2eUZuVmU1ZStmajVlR3FCRk1ldDZqSGRoc2M2RnlGU2t5?=
 =?utf-8?B?UElUaEp6MjhoVzhXbjBxNFlEVDdCTENuWmlCSkVMR0EvSHBWNlZPTjJzbE5B?=
 =?utf-8?B?Y3ExQWIrZjFZRnFscG9pTkJWSGsvOXptV2NLLzlZeko3VXJBeEtvY0VBSkY4?=
 =?utf-8?B?TlhVZXFocmJZeXIxTys4RmxtanM3bnFmSmY1eFdRcmVyc1dMdEw0Q0R1K2ZO?=
 =?utf-8?B?TTZtMXJPaDV3WE0xQVdGSWp5MUNjNTRDYVI4TW54TjE2SUxTY3RUcjNTa2JU?=
 =?utf-8?B?U0RiOFBiS3kwb2E3MmlsZXIvaGdwMHErZVMrVWJ5bHVFSkZrZE9CNXpLL2pT?=
 =?utf-8?B?ODJYVTJ6MEVjcWYyUTVNMHJJc1I4TUVvczZ0YkZWYTVGSXlKVTZSaDJVMzlU?=
 =?utf-8?B?dTJydHc3b0ZPaW96eTBZL0xOUjBmUnd3TnI1SVljc0dtZ0lzbDJuR2NIT296?=
 =?utf-8?B?YURocHRBNmRvMi85NmVaNHlvL3U3MjBkMkZOMTlpeGlaNmVsdEFwTXVTanYz?=
 =?utf-8?B?cm5tWldodlpTRlNvNVlETWkvVXNRYWVhTEZYQkZsbThwRHZSY2hTMEgxSjlT?=
 =?utf-8?B?eURDWXMzYmhuODhhbysyaHZoTGFLb0Z4YjhOeTY1T0QxY1VXbTZDWnZSb3VP?=
 =?utf-8?B?YlAzaDExV0ExUSs2OGxSc0VjcjdyTUI1bGNSQUV0K2lSSzFscGtLRmxrT21G?=
 =?utf-8?B?SWRHZUZ6bVZaTGxnaUtqaHNnSVJ4VTh3d3huY0FpSWN3OUdWSjlqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0b041f-a3c8-41d5-39e7-08df4194ce93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:45:48.9571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYuSeUjTBQSzFGsiSo+0PxeNYoL5JwNMizCRpPC7FvdsYHpgRlFk0q5mI/nz+ORr3FDKXpa6ZUkgWqPZiQRcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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


On 2026-11-13 06:58, Christian König wrote:
>
> On 11/12/26 17:44, Benjamin Cheng wrote:
>> Switch to stop using this deprecated helper.
>>
>> The original could be incorrect under certain circumstances, since the
>> amdgpu_bo_fence only reserves one slot, and at the time of calling the
>> SDMA commit and TLB flush fences were not added yet (the reserve_fences
>> is not additive). In addition this allows us to switch to use BOOKKEEP
>> usage.
>>
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 94b1cfe05e3e..fe6f2fcb88f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1212,10 +1212,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  	if (r)
>>  		goto error_free;
>>  
>> +	if (!unlocked) {
>> +		/* last_unlocked + SDMA commit + TLB flush */
>> +		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 3);
>> +		if (r)
>> +			goto error_free;
>> +	}
>> +
> That should have been reserved in amdgpu_vm_lock_pd(), but we currently only reserve 2 instead of 3 slots there.
>
> Please fix that up and drop this here. Apart from that looks good to me.


The reason I originally chose not to do that was because there are callers of update_range() that do not use lock_pd(), for example amdgpu_dma_buf_move_notify().

I guess I should fix those too? And I'm noticing that in amdgpu_dma_buf_move_notify() the current code doesn't even reserve space for TTM_NUM_MOVE_FENCES, which sounds a bit fishy to me.

Just wondering what I should do for these cases, since I only recently started to look and understand the VM code.


Thanks,

Ben

> Christian.
>
>>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>>  		struct dma_fence *tmp = dma_fence_get_stub();
>>  
>> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
>> +				   DMA_RESV_USAGE_BOOKKEEP);
>>  		swap(vm->last_unlocked, tmp);
>>  		dma_fence_put(tmp);
>>  	}
