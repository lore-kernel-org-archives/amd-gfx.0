Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1488F9B5F6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 09:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B2110E99D;
	Wed, 22 Apr 2026 09:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tc4sFHdW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B701310E99D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 09:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnTjTzuIiNpWDb4jAY2xlKuKWI9Igs1Lc/f9iQ19sNJjmki8/wz+bog10opxrQsBGfir5FLtcvIoO8TMoQ2A2V5z07NM78FYCY7gb0TOVEr0ryELbcbzAcVgx8ldzQgHmVkR5UYfjOXoUlcBdHv2zFZBPwP4WwxxJL0ZL3h5unhpIK+1x6khylfDWG70XT3Wgn3smmRB9O3r9e1VdW3a2eBpnuvcQLGrKsrdEuL+gtGIaL3lch4Td0yQQ0EwA23x0jC5quFIo+wl5J0vJgdRKyOhWoW7KxZMap0A8GGmi9KO03FRHxu/Ih8/7GVtH6oPVUH+BV8wTzu0FwgazxNW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl30h14X83Fz/EU0RfJ3WB39BomFxId9I3reZFWmDK0=;
 b=cqym2b5vkQmQ9NgZbgyE/ZqCyP6Dc3Tp2s/Z059+IQgJkXw9Rl+RO0hGjJ+084bZz2uquj+4BdxzxcYRFe1ARMVoHfGctza5/1K5K54Vs4h5himCHlUHdPo//WWRioZAiFKuiWGB4ZuUO7JneXBxqkAuZhrowTYBXl46cM7r5tqjzMoDimjh2TI4RxQ7Eu0DvkQ5mM3cxYCi5aYNox9l7CyRUi3oOJWxzDoHbB2llqgkyIS3/Gwfv7RrpONTB6EVU/LyToY2pWSC3zW2cUdIsriORZm+XDGsJJ9xEHM/Rh78L3I63qJ6KrkZS9qX08Blk3sVyvFhpQfdqcO2BxLtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl30h14X83Fz/EU0RfJ3WB39BomFxId9I3reZFWmDK0=;
 b=tc4sFHdWxnMTYNvR+P1Y0hNwD2vnu6K6/qUI91ub9k37BDNvAVxhRrRqeHyK1jhIcWqVUCBhBVCOVNgedDn9HoGHBNGt9Qg2/cxsEyCP6CFMOa7xUCz2UVesTY7NCIX9HIXeF8W5+M4CU+xMrwuHHTqfozU1a5JKMwRzy3wLTHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:26:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:26:50 +0000
Message-ID: <b53997ef-f55c-4813-bca6-2308475db357@amd.com>
Date: Wed, 22 Apr 2026 11:26:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-3-christian.koenig@amd.com>
 <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e676c2c-b25f-49df-94df-08dea0514840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: KJlIXk5Og6qvKA6q2IrZsCMeJEGm66CD+t49OuYRcT8om6om1cjJjpfbly0XhFQPifWx6Mu5Woa/5SR61KMHsmKsf6BJh4gBmEOWqF2EEUrRX7baEon/MlSLdI0MeMr3iV1/+LmLusXPCRDBYKysha+8k3YQB0d2PsDIeaj21BxHlxlm9vn4iacoqGJaee7CuxWBtpRMsd7TjL3mC41bcufLO4pYYJSPuDgfbKvGq8SJJ+44/GHJp0mdmZk/sx67pxBd8BOsFHV6uPJNTbjeGY9kBCuRtOOoblqlLICXErYVmcexSA9wry6zDHTTeM/Nczyrln7btpP5bAzU8XruALgXMAg4PgiF4V2vWNA7dfgumdL+eDpsuF/n8NbZKomCOGmBgoNXTWpKFmqn1xgKhNfRe6Rim51emunNN6Drl9CiJQJtDZ/r6NFzxF5ebs+HHLWx+g3UMLXdz94f+1j5H0i7jc1OUgt09+XRFbfO8rkmTY2R9dOmQRqcGQkKIwmU5Mbo9m/27/5jnLgJ2Npn6l0yfiKhe3EJfUmXTfzyjEGThQm8y25oNJKfdJHEiwwNPJtHsBRGyehUttb7TXZhMqSpTXu2OsE3py3ph4jF2/zU1sciLW5VYWjBd9kc9nbLRMsK7LWb5vsQRtRdw45RF4CY2PbyXKry/csdSl6fJBfLl72TUHpGQvpNC3tUq0qUMww3dh+vU+kj6zutqTyv1gy9mxGYKCmJ397vfl3TVrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEF5V2RXdWpobytucUk1NlpPelN5SHJWTkpXNkxrY2pDSGZCRWoyYk9tSEd6?=
 =?utf-8?B?RTFRY2dOYUo2UytWQ1lNY29SSURCSCtrdDFuZjVWV3NVZEo1VVIyT2F3Y1c1?=
 =?utf-8?B?eGNJRzhFS0owRDZ3SDFBQ3Btb0N0eHBvc3VlNGNaWFZTVmVJcHhYYWNyRzE2?=
 =?utf-8?B?QTFmbWRzTjlTdmZtUk1GQ3B0WG5pRHlIbFI0c3JlMk9ZM2hLUTFTa1JqZmh6?=
 =?utf-8?B?dVdMa01CSWVET00rQ1hIalZvUXdDZjRVMmRpbGsvYXZzTzZnVWg3OGtCVXYw?=
 =?utf-8?B?OExRbEgrWUY4NHVMN2MzdzB4cWppcVBmbXVhSUlDTHhWZk0ySzMwbExxQ3Jx?=
 =?utf-8?B?VitUbGNveHNJL0U4ZjFRcmJkaU1mT3NSN1BnUHZ6UEEvelhYa2ZUc1p6czRw?=
 =?utf-8?B?Mzk3cGo5bmIwUFJoaXlyQ2pEYnJNVFZnbEc4Z3Ftcmh1eUpBN3RReFF6b3o5?=
 =?utf-8?B?N1UvWXNzOXNSWll6WHFLeTl0NE45SVNYWk9nT1JUd0k5ZGY0b0duZXQ4blJG?=
 =?utf-8?B?T0tVTUlRVjJ3SmRENnlKL0RhQjBoODBoTmZiRDlUekxPYzdJUEU0N3NGbldv?=
 =?utf-8?B?RnBJTmZjTTRXeU94MGJ1VCs0aC80Wk9iUXo4ZE9TME91bzFrMXpqamtIQnla?=
 =?utf-8?B?OVNnYTV0NTVQSUtlbm93Q0lZRWZjdEVvWXk3SzZOVHM5OHh6VlVKeVV3TEZk?=
 =?utf-8?B?N0ovRnR4Z1ptRnVQR3J6aURCcHA1TWF6U096NEY1clUxRE12WE9JcU1DN05K?=
 =?utf-8?B?UkFyRzRSNjJsb3BxWGFSY1Z2YTBGb29qWno4V0tOejdIdjdTT2EwTE9nYjJH?=
 =?utf-8?B?RVkyRFV1YnZsWW9ITU5OdkNuYzEwVDZWWnNlZ3hXdUtuQzJvMXF4Q1J3a0Fy?=
 =?utf-8?B?RWZGTGZ2YU1yMmN0TUZFc3hlZ2dlazkrWm8zQjBtaFIwU0dSdjl0VUNEbmRM?=
 =?utf-8?B?ejRrblkrTUpyVjBORUFlVEN6Q1dMQnJoTE52OFJObHFKeUtNOURwK01kTW9r?=
 =?utf-8?B?TXYyMUlxYzhIeDIrbjM2M2NmaW9tUTkwV1p0OFNKbmlyZXRMOFIvYnR3dXhM?=
 =?utf-8?B?NHFodGpnWmJ0K0ZZYTZCYkM4T0lta0JkWk0vMjhUbFJ4T05YbzNFdG5nZlpW?=
 =?utf-8?B?SXd5Ry9Rd0w2WUNpclZhVkJrcXFEdnQ0YkpaQ01PM2o4d040MGFrSW8vQlVR?=
 =?utf-8?B?TUJRUWVMUnU0WVhtRGI0ZDNVV2FoMTloODNaWEVpc1E2SHV5d0p4enBQQkhj?=
 =?utf-8?B?Z1dqTm12SVBoUTVteDgwb0VKbytEcDVEQ1NyTUVXUmpJcWg2ZHZoRlM0WWpx?=
 =?utf-8?B?M1lBMStmMjhMWGQybVBtc0hjMk1xV0szZHdFRmR4VXdjM0NYSXoyczdRa1Y1?=
 =?utf-8?B?MHRrUE14c2pKdnBocE5jeXVydTM3RGFPeEJ5elRiVUNSMStqWHpFUGRqRnJB?=
 =?utf-8?B?d3hocWllYk5JYVJvNW9JdE9ncXRHQ1htYyt5QmRRTFRFcnJrT3VjMUQ1VHJI?=
 =?utf-8?B?NnBiYXM2SkZPSlMxM1dueHd0OUFPVHlGaDFkeHlFdUxZaHJXdnU3WFVqQ0V1?=
 =?utf-8?B?VXkzTU81QWdjNnQ0NlJUYW5iZHNyWVVtK1RVbWs0QkFjdUlFNVhua1lJQ1Fj?=
 =?utf-8?B?dG5xLzV4WC9jS29iOUNORkZ1NUJlZy9nQml3MlFOTzd5Mkc2K29RSjBZR3pD?=
 =?utf-8?B?MFd2czdhY2R5aDBOWUkyWVpWU1pHeXFucnlLVHhSVVFnZVhiSkVjOFlVSzRN?=
 =?utf-8?B?eVI0UHVLdnpoMTVrcFFXUHFBcjFwVFA4bDZOR2VFc2plT0Ftejl1Y3FJOURo?=
 =?utf-8?B?bWFnTTRCSVpWSUJRNWFJM2hJSVhSQVlncDVoYWNCQXprTTA1SklVbEQvTzRH?=
 =?utf-8?B?YmxHck40VkNheUprc0grVHRkNzN3M3FjUjZxcGdZbHEyaDRUcHFIU1NjOVNP?=
 =?utf-8?B?cHVLRG1xc1M1dWNVTlBnNllHME8rZkRXcWZEdWpsL3YrcDQ0ekR4dkpMRzNw?=
 =?utf-8?B?Z0szTDd1c25xbkhzM0pIUUVFQit2cXpKMzlWZWhCelkzdGJYRE9rRE9LalBI?=
 =?utf-8?B?eW1wNEI4YWlxK1VHODMzeEFaakVIT3N3ei9Ua2pBSG5GQ2pRVUZFa2hTWmNC?=
 =?utf-8?B?d1RqeC8vYjBSYzhzbjJ6M0RxZGU2ZEt5b3kzT1FKb05qRy8xcTJtd3BZNG5u?=
 =?utf-8?B?aTY2clRCT20vbk5oa1FkYm9iSW5mK0dJVHhIWE1GaVMrREZiRmNKdjRnczV6?=
 =?utf-8?B?OEVXZi91SGpPMHVEaHp1L013Z1NKTjVTTklIM0pXaHlDWU9KOHRZanVoWHNy?=
 =?utf-8?Q?tmghSIbRQ3BEl1Enu5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e676c2c-b25f-49df-94df-08dea0514840
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:26:50.1711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIP63i39zLxjGSpZ5qwme+3j6EzDzrJ8lMLh4+bGTv9tDh9LfcjgjBdUaVh2n+jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

On 4/22/26 10:29, Khatri, Sunil wrote:
> 
> On 21-04-2026 06:25 pm, Christian König wrote:
>> As preparation for independent fences remove the function and do all of
>> it's cleanup directly after signaling.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
>>  3 files changed, 31 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index c6546a858597..1b15b51dc3f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
>>  
>>  	r = amdgpu_sync_init();
>>  	if (r)
>> -		goto error_sync;
>> -
>> -	r = amdgpu_userq_fence_slab_init();
>> -	if (r)
>> -		goto error_fence;
>> +		return r;
>>  
>>  	amdgpu_register_atpx_handler();
>>  	amdgpu_acpi_detect();
>> @@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
>>  
>>  	/* let modprobe override vga console setting */
>>  	return pci_register_driver(&amdgpu_kms_pci_driver);
>> -
>> -error_fence:
>> -	amdgpu_sync_fini();
>> -
>> -error_sync:
>> -	return r;
>>  }
>>  
>>  static void __exit amdgpu_exit(void)
>> @@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
>>  	amdgpu_unregister_atpx_handler();
>>  	amdgpu_acpi_release();
>>  	amdgpu_sync_fini();
>> -	amdgpu_userq_fence_slab_fini();
>>  	mmu_notifier_synchronize();
>>  	amdgpu_xcp_drv_release();
>>  }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index a58342c2ac44..909bdccc2a92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -32,29 +32,9 @@
>>  #include "amdgpu.h"
>>  #include "amdgpu_userq_fence.h"
>>  
>> -static const struct dma_fence_ops amdgpu_userq_fence_ops;
>> -static struct kmem_cache *amdgpu_userq_fence_slab;
>> -
>>  #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>>  
>> -int amdgpu_userq_fence_slab_init(void)
>> -{
>> -	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>> -						    sizeof(struct amdgpu_userq_fence),
>> -						    0,
>> -						    SLAB_HWCACHE_ALIGN,
>> -						    NULL);
> Are we not having benefit enough to continue create a cache here ? If that is fine that LGTM, 

Using all those kmem_cache instances was a bad idea to begin with.

See the idea of a kmem_cache is to reduce the number of CPU cache lines and memory you need for certain number of objects when the object size is not a power of two.

So for exampe two objects with 96 bytes only take 3 cache lines and 192 bytes instead of 256 bytes and 4 cache lines.

But that difference is so marginally for most use cases that you absolutely don't need it.

Regards,
Christian.

> 
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> Regards
> Sunil
> 
> 
> 
>> -	if (!amdgpu_userq_fence_slab)
>> -		return -ENOMEM;
>> -
>> -	return 0;
>> -}
>> -
>> -void amdgpu_userq_fence_slab_fini(void)
>> -{
>> -	rcu_barrier();
>> -	kmem_cache_destroy(amdgpu_userq_fence_slab);
>> -}
>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>  
>>  static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
>>  {
>> @@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>  }
>>  
>>  static void
>> -amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
>> +amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>>  {
>>  	unsigned long i;
>> +
>>  	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>  		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>  	userq_fence->fence_drv_array_count = 0;
>> +	kfree(userq_fence->fence_drv_array);
>> +	userq_fence->fence_drv_array = NULL;
>> +
>> +	amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
>> +	userq_fence->fence_drv = NULL;
>>  }
>>  
>>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>> @@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>  		fence = &userq_fence->base;
>>  		list_del_init(&userq_fence->link);
>>  		dma_fence_signal(fence);
>> -		/* Drop fence_drv_array outside fence_list_lock
>> +		/*
>> +		 * Drop fence_drv_array outside fence_list_lock
>>  		 * to avoid the recursion lock.
>>  		 */
>> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>  		dma_fence_put(fence);
>>  	}
>>  
>> @@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>  
>>  static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>  {
>> -	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
>> +	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>  	return *userq_fence ? 0 : -ENOMEM;
>>  }
>>  
>> @@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>  
>>  	if (signaled)
>> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>> +		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>  
>>  	*f = fence;
>>  
>> @@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>>  	return false;
>>  }
>>  
>> -static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>> -{
>> -	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
>> -	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>> -	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
>> -
>> -	/* Release the fence driver reference */
>> -	amdgpu_userq_fence_driver_put(fence_drv);
>> -
>> -	kvfree(userq_fence->fence_drv_array);
>> -	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>> -}
>> -
>> -static void amdgpu_userq_fence_release(struct dma_fence *f)
>> -{
>> -	call_rcu(&f->rcu, amdgpu_userq_fence_free);
>> -}
>> -
>>  static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>  	.get_driver_name = amdgpu_userq_fence_get_driver_name,
>>  	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>>  	.signaled = amdgpu_userq_fence_signaled,
>> -	.release = amdgpu_userq_fence_release,
>>  };
>>  
>>  /**
>> @@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>  	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>  	if (r) {
>>  		mutex_unlock(&userq_mgr->userq_mutex);
>> -		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>> +		kfree(userq_fence);
>>  		goto put_gobj_write;
>>  	}
>>  
>> @@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>  	for (i = 0, cnt = 0; i < num_fences; i++) {
>>  		struct amdgpu_userq_fence_driver *fence_drv;
>>  		struct amdgpu_userq_fence *userq_fence;
>> +		unsigned long flags;
>>  		u32 index;
>>  
>>  		userq_fence = to_amdgpu_userq_fence(fences[i]);
>> @@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>  			continue;
>>  		}
>>  
>> +		spin_lock_irqsave(userq_fence->base.lock, flags);
>> +		if (dma_fence_is_signaled_locked(&userq_fence->base)) {
>> +			/*
>> +			 * It is possible that fence is already signaled and the
>> +			 * fence_drv now NULL, just skip over such fences.
>> +			*/
>> +			spin_unlock_irqrestore(userq_fence->base.lock, flags);
>> +			continue;
>> +		}
>>  		fence_drv = userq_fence->fence_drv;
>> +		amdgpu_userq_fence_driver_get(fence_drv);
>> +		spin_unlock_irqrestore(userq_fence->base.lock, flags);
>> +
>>  		/*
>>  		 * We need to make sure the user queue release their reference
>>  		 * to the fence drivers at some point before queue destruction.
>> @@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>  		 */
>>  		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>  			     xa_limit_32b, GFP_KERNEL);
>> -		if (r)
>> +		if (r) {
>> +			amdgpu_userq_fence_driver_put(fence_drv);
>>  			goto put_waitq;
>> -
>> -		amdgpu_userq_fence_driver_get(fence_drv);
>> +		}
>>  
>>  		/* Store drm syncobj's gpu va address and value */
>>  		fence_info[cnt].va = fence_drv->va;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> index d56246ad8c26..d355a0eecc07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
>>  	char timeline_name[TASK_COMM_LEN];
>>  };
>>  
>> -int amdgpu_userq_fence_slab_init(void);
>> -void amdgpu_userq_fence_slab_fini(void);
>> -
>>  void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>>  void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,

