Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C64606A32E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pnYTHaHS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778D610EC4A;
	Fri, 13 Nov 2026 15:47:36 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5F210EC4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHgXB4HWUHg2V+BYP7EkybhJEqlGlsvJKIRqwsiFHSzAxvwrFuKafSk4YK2Q7hxcKJwPWBtglBVwzFe1oJ7kvuttZCJdqmogUoQUZ/8i6Xgv1ei5/1qNqlURro1fLy/F/CyLUqjC5CVzasJN8SVQJ9mAsmnE2bSKxpMTJ4/QzQxJ92jif5YyYHRJc9FgBz6zNnyFUhM64g2CJVEUSRfG9IzTxMWnLI6dTec8E25Eku/R8SAb99C6Qe5BKcGxR8wrP67Czef6B5RofHwZoUvioPKeYqgNdinMf7DcqDUMozKM8VtSwzx9KyBzaG2knPXXlJTE5vnfupyEBqKLaMjFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jj/cTktW/zKqwGxKZfaDqP20iqG3SYgSe/ibtVRq1M=;
 b=RFNv1LH0kZXnc18lUnqaSviXEdILo3CjQ7l4eS6rYTgarCS8SsmuqtkCuG5VCL+kL6hNwVkgRie9sIGOwMDXOKe4I3P9r9tDqBiq7zygdPF1ez5w4bq+gFsF9JoIUgd2MwLFjVNK+euDbZywp5npKxD8s6uhEBNiTigr7cEG+GFINNEgeN9YbTlGgvppu+TMlccjtz0C55sS0Pu7hS7itO2u5G9bcgguqbU3YLGUUF1jWrD71R7Dd9otH0AikNR/FqEqTUypReXLHMbEoK+StTuYgzAwcjpqjU4VmDg46U7nwJ+yrv4y9RXkSJcGVZRVaJdhQKFFpHalxdXEPYkjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jj/cTktW/zKqwGxKZfaDqP20iqG3SYgSe/ibtVRq1M=;
 b=pnYTHaHSLefKV9VoGS6F3J1l5QgDo2xdk+AGq/b48s5Gynnm4xbH0gUfqRqkMs4+Z+ddGGXzC0G2O9sSjPeqsD0tG5dkNC/X2jRao5L+pFo6TrD9sJ31OI3E173921W39YlOKAZKgiHWAl2OPAFmBzQa6O3m1fmLwEnSHaPkM98=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Fri, 13 Nov 2026 15:47:16 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 15:47:16 +0000
Message-ID: <4c1fe25b-9e5f-4377-b45d-6b8ee5aae32d@amd.com>
Date: Fri, 13 Nov 2026 09:47:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init failure
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org
References: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
 <20261113-superm1-amdgpu-memory-leak-v1-2-4a495cfc2c92@amd.com>
 <sashiko-outbox-213039@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <sashiko-outbox-213039@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0130.namprd11.prod.outlook.com
 (2603:10b6:806:131::15) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 06deb3c2-8801-4a8c-6e55-08df419d644b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GUvZsbpqC5FR+nbYnY7azFtfltDLzdndwrirmiolf5BW6gbc47ySztf1PvvnrLyppM0RywsEcBWl2v9q9CKrpjCoBwdXWQb4pn43KkgcA6bJYhawmrKGx2TtENuUqLJ430kpQ1LeREz0/bXwRGX2GIV4L3CmfxGx2EWgaKtgupaob8P2QpUSLIIV2p6cPlL4nyg5b/X5Drz/3MHJ2/mIuEV7LNRqbDlcTjHkYL3wFr0ydYq4QkAKQ8hItDHHzfUtwkDWvNoeVsJq/hC/TugCMFSAXtVC43DUiy1Ncrod6/c4HSX5Xgsg+osgHz6DCbqzIMa7PZlQCZeIcphmCnug8RllrPle3ymUwncJjK57XrZmbHWHQiRP8QKhu1jGvJnsFu6lK7c7sMOZJVGQ3G4s41dGtg21a/DPCK253booWa3r369WCzaURQoGfdLuVOvXwUATQGS0roFyT+46iIHFkTpqFhLL+vhzoV2mb69MojvWWgKBQilpEfJnnjkDZT596hmVjJ78U+qBv/z+GD29lF+CFo7OdALc3C0gh27+57ehirXLT0/Dr1tdkwLnQLTbC5/Pczh0aYLp1b5fIJtJ/j4KqjzhYHdIsa0+tMbFz1r5/ELeJYHroTXD4M1FwXSz0sCI+x0BpPrRf6b1L3ypEVL9QF+jmMkBVnGBl+kal7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkIxQmhaeXg0TmRobm5lSFFJd2xqa0R3WUM0QUJFbWUwQWZOamQxTUhnWm1w?=
 =?utf-8?B?aUswQzFqNXFUcmUvUU1tcDFmbHJDVHlKa1JyT0daNjRmL3hXY044WlJERWJ0?=
 =?utf-8?B?QTdRMVJGZWJld01wSUpUcUxLREdjM1RCdlR4MXNDR1BrK0tBb3ZOa2lTdm9N?=
 =?utf-8?B?ZlBxTUhmS2JmRXJrWnVjUnFWMVEvRFVTTWpFUDcxR1JDVkp0SlR3WllXekQ0?=
 =?utf-8?B?Nk5TQjRWazZKbmJNa0JVWDhBcG9SeGQwcHdjSTVldGk1T0o3MzZENE05Z01v?=
 =?utf-8?B?RW5uMEtNdTFHMFhibjNiR2J0VHZMTnRQWkxnU2tDN0tzU1Z1WWtCNDZuVHFF?=
 =?utf-8?B?RURRQ0FCclMreVE5YzBNdHNndEJqbjc3ZGZzaUFNa3BkcG1hYlJUWmxhQVdx?=
 =?utf-8?B?YWxaTlU5dit3L0pES3RJM283RE51cTRJUi9xYVUwbXRnelVPZnZDU0JrL2FN?=
 =?utf-8?B?YmpDU0dabkpINHFnRC9DWHY2QVlWb2V4OEF3Sklac21Qc0g1UnV6VU85NURY?=
 =?utf-8?B?VlkvaE1tSi9kVUptcDI2TUFKcXRYN3VrM2xoQmJDaHpUZTBlZnlHWmlDVXpM?=
 =?utf-8?B?MUs2WktFL3FUTi9rZGVsNm1IWkpCeFMzRnlYejdqMWhGcnVHdUFGYlFSdkdi?=
 =?utf-8?B?REFDQnphU2UzdDhpZHp1Y1V4TXMrTXU4TndBazBqaGdDNjJDWnV2WDFGcFMz?=
 =?utf-8?B?RFVZK25OWk1TSnlwVzQyR29PZ3p3d1pBbkp4MDJKd1RsNy9UK1VyYkUyVmR1?=
 =?utf-8?B?a1Nub3BONGlzTkE5aGZSMjhlMVlDcTlsREh4ak1Id3l4OUlPaFh5UEFyVEU2?=
 =?utf-8?B?QjV4QUJ6WTBsdWJhUC80dlVGY1lGcktGU0kxakpXOE1VZi9HZlZmcjFoeURJ?=
 =?utf-8?B?OWw3amViOHU2TVJKQ2NCdG5RM0VjVlZiRURmQlF0YnFRUG9MdXVTSFEwOGU0?=
 =?utf-8?B?L1BJQzExVGNadEhqWnJaZG92UXFzYS9nNXZJWGl1ekx5QTEwaDZCSitnWGxC?=
 =?utf-8?B?SlROYTdhNzAvWlFLY3ltUUpCd2lERkxoZHFrOHBzdWM4UDF6Z2dTazZzR2hY?=
 =?utf-8?B?Z0EyN0J4UmNnZFpWS1VYZ1oyVjhSVXpGVDlLTjFiYWlQZ3VxY3dYb3VyZVpB?=
 =?utf-8?B?bHZ0RERQTjQreTF3V0dySU1MelpMUi8xVWplVzFoVDhGbVNTTU9vOGpsUnlC?=
 =?utf-8?B?cWtOMW96SWhBYWhPQUl5SjdlcVR3L09tWUVEbWFVd3d1cS9VYVpwZW9GR0FZ?=
 =?utf-8?B?Z1cyT3FBYktVaUtyMTg2UWJ2MlJ3MzI1RlU0UEF4b1haUVhSYlNoQWZ3N1NL?=
 =?utf-8?B?eXd1QXpMV3hQbFp4a3dxMUZSeUZNNWptWTdxMEZjY3RKM3ZhU1FMWHdJbGNi?=
 =?utf-8?B?V1BDb0JPWklkTG43UXlJbStxdDZla0hWbmtrVGw0TXk5bS9oZXpMTG5LVVpu?=
 =?utf-8?B?bG92TzJLbkRTYVp0UVBLaXhXcXFPanQwUDIyL09VS1VCbDFwV3dieGtBbnAx?=
 =?utf-8?B?MlRqbDRqU0wyRTRBb2tZeGNyeUVXdkZhWU9KNTFTVEFnWm1zWHU3WG0yRG1s?=
 =?utf-8?B?bG50R21OV201MVQzYkpKT0UydDFCaGtLWm9RRXhYcmpUQzdTTjJXNFRMdTZY?=
 =?utf-8?B?UDdFUGhLY1k5Q1RkU2ZIdDNhOVNWd2tLU1RIOXJkTE1tZ094cFRqSis1VVNa?=
 =?utf-8?B?TVIrQkJVRHp5SG9PRE0vQnFQNDJXWUZzWmVUODBHWEYwTTBpbGdpdW5JcE5B?=
 =?utf-8?B?Q09KRGxTUnNKdFJpSytKR0RwSEp1M29ZR1pIdmF6UllJZWFZRVNIWHhXdGdr?=
 =?utf-8?B?V2pVZUdQWmNjVUl1V3djN3MvYXB4VlNIUEVvVjMwR0NMSGRqejdQbUl1T09i?=
 =?utf-8?B?NUVwdkM3NkluaXBuM3VCV2pSMDE2OTlQenYrQ0xWM3Ayc3J3S3FLUERROVhW?=
 =?utf-8?B?eWRRQ04wTEJ5Z0xzZFhSQm84VGNBK1dncFhNcEhEeG5sLzNxd3VPeXU2T3BN?=
 =?utf-8?B?RHByZHpWZXpXVEV0RUYxdFhVMjFWRGRGMU13MXZlNGdCZTFoZ2xQVHJqbEsx?=
 =?utf-8?B?ZnNaYzMrcVJON2gwNEFhSWxxbmlydk44N21kek0wUWF5SDJxTGtBYmpGUlds?=
 =?utf-8?B?WmNsQnFIdlM0Mi82dXRJM0paVWE1Tkw2NzY5OWV5ekwvU3c1ckxSQXRta2px?=
 =?utf-8?B?bUpIaTRNbitnbmNlQ2tQOWE2dzUrTTJ1MVB6THVpd09lZE9wYW9ITS9ybGh6?=
 =?utf-8?B?UlNFdFhHSW5UVFY2cW9KR1pleDFYMXBudWRFMmFPMW5lY2IybWExaUt3azNO?=
 =?utf-8?Q?4o9ifmGXkPeJyujR7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06deb3c2-8801-4a8c-6e55-08df419d644b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:47:16.1359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZuVLefj8uJeYWQjJ5hBsN2UYRH+cy/GzuCVWgvtCfcI4rPmeybn1qT8+EmS5Ao2r0PkjjCLIkpGqCznDgIEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/26 08:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/amdgpu: gmc_v*_sw_init() calls amdgpu_bo_fini() with
>    GART/PDB0 BOs pinned
> --
> 
> commit 4e2abeed7577cfdf2a67e81d9af414ebfbc361c6
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> drm/amdgpu: unwind bo_init on GMC sw_init failure
> 
> This commit unwinds amdgpu_bo_init() and amdgpu_vm_manager_init() when
> gmc_v*_sw_init() fails after initializing the memory manager across GMC v6
> through v12.
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 49f593fe2a876..e59fee3955af0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	r = gmc_v10_0_gart_init(adev);
>>   	if (r)
>> -		return r;
>> +		goto err_bo_fini;
>>   
>>   	/*
>>   	 * number of VMs
>> @@ -880,9 +880,15 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	r = amdgpu_gmc_ras_sw_init(adev);
>>   	if (r)
>> -		return r;
>> +		goto err_vm_fini;
>>   
>>   	return 0;
>> +
>> +err_vm_fini:
>> +	amdgpu_vm_manager_fini(adev);
>> +err_bo_fini:
>> +	amdgpu_bo_fini(adev);
>> +	return r;
>>   }
> 
> [Severity: Medium]
> Does jumping to err_vm_fini tear down TTM while adev->gart.bo is still
> pinned?
> 
> gmc_v10_0_gart_init() allocates and pins adev->gart.bo in VRAM.  If
> amdgpu_gmc_ras_sw_init() fails, err_vm_fini calls amdgpu_bo_fini() without
> first freeing the GART table as gmc_v10_0_sw_fini() does.  Because pinned
> BOs cannot be evicted during amdgpu_ttm_fini(), gpu_buddy_fini() and
> drm_mm_takedown() hit warnings and leak the pinned BOs and their backing
> allocations.
> 
> The same missing GART cleanup affects the err_vm_fini paths in GMC v7, v8,
> v9, v11, and v12.  On GMC v9 and v12, gmc_v*_gart_init() also allocates
> and pins adev->gmc.pdb0_bo when amdgpu_gmc_is_pdb0_enabled() is true, so
> both err_vm_fini and a failure in amdgpu_gmc_pdb0_alloc() within
> gmc_v*_gart_init() reach amdgpu_bo_fini() with pinned BOs still allocated.
> 

This finding looks correct.  I'll re-spin.

