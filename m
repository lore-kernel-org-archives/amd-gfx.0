Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE6ED7B95
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C75B10E5D8;
	Tue, 14 Apr 2026 09:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ru7mUBGl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A72810E5BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ndy4zuK4g2HR4PwlgYSEyuYHhRcb0dDrhf49Y9gsHVnwcXZ/Q83oBlaLAzQA3sRV68EvO8kMl8g8xnoFFvMd3qV+eySsKZi/EUvjOgL08BsRqyfdcOvaMNlyHd71tcljWvKQP7Ue/b4HTTZSAlmCkCpKk8wpzdjvFbGGod94K+uzYr5d6uPS1alNn3zR/iXF2Yr9MuJlhe1CXIStfprbq/3NbRVbOMX0Z4vBncgo0kLxpOOuzDTV7hlHIRlR/IYxxcTKoXU1pGZzQiFajouDZuumLuAX0r8jHCtmRlb4mBrCwjhCz4N8JyrDBSo48fiUYSQ6WH5FKgfKzBwUovamtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjPqnoOrbx7zNEJYC1OPXsiU3lX5jSucJUqB0sJjdVI=;
 b=cxMIjTmmuCDORqV846LfHbntXPXhSRj61jXYP3LeX3ePKUT52QrjyLQ7GFH6WmKNTI4I5VlkyCJX3rboDSM5gkBo33r51J4/0CqQr6DygxL6WqAlcu+SrRk1Yi2Th23d4fabpaCg9Y9ZuXQGUwMHXZ2bGZq5ikjBefPRqyJfbuzzJ91Rk7xO8BDNEk8cYfwRGu4ei7IuqQojRPclqVxbFwI9Fm5e+ocyI+TKXNMtjnFuyJNifZ9hbxV8S5xp1q5+SK7jXxV4gzJLjFTcVdq0oBuq0v0mSAXW54Rst0hJ+rk2E1xUvW/d5K6Harqtm2hhdfbLaajf6ADpjT9aGaejyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjPqnoOrbx7zNEJYC1OPXsiU3lX5jSucJUqB0sJjdVI=;
 b=Ru7mUBGlwBMSYw+iJhilxJplu2DeUUyA9cy55+tvOwccIsn3ZhwqGQTK1sa2QfFUZBovx4SdsyGouCTQE2KYmdicvA8Wa5VeZHgMmNRYcu4w1woJBL+CpeO6aP3GK0n/Ln7LLeX2circCUQcMausGzpxz2QZgzHgAYzphB7hmdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 09:33:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:33:04 +0000
Message-ID: <0485fe58-bb54-4d9f-9c2e-4bdf1f8e66c6@amd.com>
Date: Tue, 14 Apr 2026 11:32:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_vmid_alloc_reserved()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260312131625.1839044-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260312131625.1839044-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0e82d1-f7a4-485d-00de-08de9a08d427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: lgjMrfd+rA4+1TQ8Qn2arrVrebTGN4tFwHi46luHNtm6wuUFVW6FbpCMD7Xu/O/soV+VQqEHfAKc85Beblu1ESx/iUtzibRXy3vvKeGdPebRD1dgGuHlrCGhRTuZISUJjgZqubHPq3wc02/intJTGdGo/OyUzpzK5ImdaDUzv1qolE57VF0xSiHjJ2/I3eWV1ggo2xdhsrJ7iZ1zFZwDhvki7e6KWCtdUz/hNyjRJSmTc4Z+gZbL1G+DgCvK2f5+Gpf6yBreOLhNlh+byKHh7w3Ltk4OuJt+IHkFOenVqAx5sTePQXjKUdyXm947DjquldpnmzhbEjMjLajTsbI6HpSzMIiLNpz9rGNfOUqdCOsU/DYxN6DTy7niONx2KiURp9/cTMNdDGprqlOhHc4pGsXyh2Q90i91vfF11Y0o0/sOMWFn3oQbwRYfx9THW9QjK5NwTpYIRV1tdctIv8M5Atc9OjUY3k/wNl4/IjnY2/XekA5HIIALVmJbBKamnQC7b/DfmouMvaBMu+Vq36Sq8zIIy6bI6SKRh0ywhH5JKHsKMPhCW7Rm39e9iZfsZQrRNp5m8/jmG30+Yfu0ycaSdzDeSi0Eo7XHy0tEYjezeUyHqVytcJns+MdVkrzKee7ogeXEdrCSAFkws9hgP7yLknFkqdsRkLvKnX36KU3Ox4ytswsRiNb67HrvrzZmEAMCwjghmiVDw7WeNndQlq/TOEAsFxLlXhVlXkH8pMnJ1Eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RnTXNzbERoc2UyUUh3NzhPVElBVmtKZmpTcU50dEtLVmp2eXlUTUxpNFJ3?=
 =?utf-8?B?UE00c0FjRHd3UUR1S3lpdlJvTVZtVjE4NmxpaTRQc3VodEgrZm9UM2RQa0FQ?=
 =?utf-8?B?SGM2emppdUFNdFVEYWc1dmNRdU5xaXR2Wmd4cWtmZVdidGlXSVpYUW8zZGVq?=
 =?utf-8?B?bjk0dWEzN1A0ZFExZDRnQlB3SmdmU3hBR0h0bFNvSTAvamV1d2hnWFVLZFds?=
 =?utf-8?B?a3AwMDJTTm1oLzNjRlBpK1Npa1BkV2VyUzZNU1JuWW01QmpqUEN4a3hNcnIx?=
 =?utf-8?B?YklDS3NPU2E0ekw5WUh1SlRTNk5LSGt3N1BrVkdIVUxZdXdoVnJ5M25nd3Nn?=
 =?utf-8?B?MXp6R1hIaFBzMkJES1QxaU9LMFhZc21BcGZrcnFjT3BCV1JXTG00VXliNkhC?=
 =?utf-8?B?QVd6elRZV2ZHWnNKVzl5L1VPbjBRUlAvRUl2bXlqdjBOKy9FZmJUblhLaTdi?=
 =?utf-8?B?Uk1BZmRaMnY5dlZvUjhGTWRXRTQzcG5QZkR5bGdFVllnVVh5SHd3Vk1PMVJR?=
 =?utf-8?B?Mzh6SkRSQTlzKytCRzlSdzUyb1VpY2RiRjJwOU9sREgyRTJLVlFsRys0MFlI?=
 =?utf-8?B?bXFjajI1KzM5UHErdzRrV3lQV1FodXFhSU9VVkJaMTh3Qk5KSWFpc2ZFQUVT?=
 =?utf-8?B?cjhKNmpOOG1nMEw3dG5Ea0RRSjN5ek9QenZWYzlSU1pWUmFBdFh1N3IzZzRE?=
 =?utf-8?B?WWVxaUJLOWNIS293ZlZtTDJPNDc2azE5UURCSmNSZDhMQXVnTW56REl6MGs2?=
 =?utf-8?B?RmxNZUVHd0pHWWhHY2ZBNGJoNFA2NGs3TWJCc3dLU05ZMjdRWEo0cysvMm16?=
 =?utf-8?B?SlY2alpNQ2ZRTDMwbmpSNmFiZ1hYdTVwY29ZdG9DVERlZElSNTBWL0ZwVGQr?=
 =?utf-8?B?MldXRzdDSmhwK2FRUUdyTFcxY0h0NG03MGtrU0FTeUlxSDRGaktDRzNsOTNF?=
 =?utf-8?B?RDdIQjg1YWdvcTE1RVVnQmhtcm5mb0tVUHYvL3hzRW5qTGk5a0l5dmZBTmNj?=
 =?utf-8?B?R2FWTFIxV1VFSURXRENtQzJIVUFFcm4zc01VQjdZVFh5c1RwWUFpTDFvRW5N?=
 =?utf-8?B?MUtjdm1yZTJhZVBxMWtobG9IK285WERWQXJMSVRWeTVDOEVSeVRrNjl5N2xi?=
 =?utf-8?B?RjBZOEtCbjdTcXhVLzNXOW4wN0o5eklKNm9sUU81aFgzb1VDZlBnV3FYNFRZ?=
 =?utf-8?B?TC9Ga0tKaFMxQzJXWjFBQTh0WnFxUWpUWWl5VUpDaFk0YVdSdDRYeVM2ekxo?=
 =?utf-8?B?cE9oR2MvLzdpaUhJNzRFTk52VHJFSW0yMlZNTUdyTHpxSmFMVnJCbjVhMHpl?=
 =?utf-8?B?dEVBMnlUTXRQTnJMUlNQS1dpQmVmb245UkNxZWpzRjUxelUzMGdMTkZHSW5i?=
 =?utf-8?B?alhTcnh1NkZrWDJBclZ3VUQxZCs5aDRRVGlRYnNqaE5mVU1VWHBQdk9EY1pI?=
 =?utf-8?B?NU9PeWcvdGE3VTFmbG9JRFV1MVNZU3FUMW93UUd3WlI3TlpFdUJhamVEZG4r?=
 =?utf-8?B?aFRTcTdsRUU1TGhzdXg5Vlh3ckx4UUY4UFhpbThHWDZPZlJYTUtjMmlDUUt5?=
 =?utf-8?B?clZLOStrcDR5Nmg0dndhZm5Ldkx6YTJCd3lSZTlTV2Q4Zkl3VGlIclVDdVA5?=
 =?utf-8?B?enl2MGNBOHpCcUVnOGNsWlp0eHpraGVoV0ZqeHJ1SkhnRk9EYVc0WmoyQjJJ?=
 =?utf-8?B?V2xzSjJja1VKNlcvQjV4UWcrYUI5S3lWaWlNOFpsT3VvbXp2akZsMHFzbkFw?=
 =?utf-8?B?clBYYW15SUVoWENoY0kxMk04SS9PYVYyRllUOE8yVTN2VlRoNUR6b2JIamZZ?=
 =?utf-8?B?NVNpNlIrcy9oekZXQU9qOWJDRFA4OEJUaGt5MTdLT0E1bWRLT3lrVjFMWjRz?=
 =?utf-8?B?Tk55VmFuU25xMlYzWDR6VzVhSHhRYlU0RHY2WGd1czVheXV0ekhOZC9PckNx?=
 =?utf-8?B?TVBNalRlajY5Z0hCUnJZaGpXWjdFYVYvRVVmQjZuellVTGd2Yy9ySm4yVTQy?=
 =?utf-8?B?d05DNHhWWnJrditrcUNUNXZ5NFZtYXc5Mmc5a3R5Wm55YVcybkhNKzdSajZY?=
 =?utf-8?B?cHhUTkNkZ2VMZ3lqV0IxM281cmRPbkZXVjRVeDNTOHVGVnhMdXRFOFNEUnc4?=
 =?utf-8?B?TUcvK3lLejRQL1h3ZXRBdC9qRWcrbEQ1RFgyeDU0LzBEUE1sV21USktIK2NO?=
 =?utf-8?B?VE10NXU5cXRsaTR1eWFma2VNV1BBQlg1TFlUZGdyWHpQbEdZZi83UnpRZmxi?=
 =?utf-8?B?MStEVXBlTUwrSnZtNG9kWGdPTUxBSEtlaEtXUlo0eWI4OXUyalgrQUlWZFc1?=
 =?utf-8?Q?lz3hGKfue0yRqpwZXo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0e82d1-f7a4-485d-00de-08de9a08d427
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:33:04.4405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Yzscw3hAfbSEW/doyuWDLTJIfq0SW2TMND32555kgQLF7X4HG+xzY15aYbvJnGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

On 3/12/26 14:16, Srinivasan Shanmugam wrote:
> amdgpu_vmid_alloc_reserved() returns success when the VM already has a
> reserved VMID, but returns -ENOENT when the manager already has one
> reserved.

That is intentional.

> Both cases indicate that a reserved VMID already exists and the
> reservation cannot proceed.

No, userspace requests twice to reserve a VMID for this VM isn't a bug.

As far as I can see this change would break the UAPI.

Regards,
Christian.

> 
> Return -ENOENT in both cases for consistent behavior and to fix the
> Smatch about a missing error code.
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c:471 amdgpu_vmid_alloc_reserved() warn: missing error code 'r'
> 
> Fixes: 90e09ea4cfd4 ("drm/amdgpu: revert "rework reserved VMID handling" v2")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cab36322c16..d0dedac630b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -467,8 +467,10 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	int r = 0;
>  
>  	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub])
> +	if (vm->reserved_vmid[vmhub]) {
> +		r = -ENOENT;
>  		goto unlock;
> +	}
>  	if (id_mgr->reserved_vmid) {
>  		r = -ENOENT;
>  		goto unlock;

