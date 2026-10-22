Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C31606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Sl7kWCCC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7C41124FD;
	Thu, 22 Oct 2026 11:08:38 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A661124F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb4HPFUDgoG8p5pC/hgF757Cql/oX4UO+KiaGCIYF0eA+fg9Ocg4fKPWBHoS99rNWtRsV/hbr0Dtq+/CQ8VljuWV/NAwrbX42UOi4CiODnikH2DTkufFMfCw0V08DeqSf/AQ+KWhpmiNeD0M1f7cnegcZEaMdU59iroIKxmpxGLiiktf0IlbxDWpwhbq8b0XeZalshrwoL+BF+TbzLejKFDH5W3bOIT4Ct2uN0pGXeKoY7vuDZJ/gFQqYYz+IK0u/QDlMPqAiQF+2mXySeFkuN46EkjvFGY0NkFkzbZX/5zkbR6NbR4iGCu2QcKtZRS8Rhr91481cuJm9Cs7/ZdKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEJQtGY2XscdnHaGL3iL8lngYm7h0FjmX4e5Oqc8bBE=;
 b=x1g8a3WMusHHnXWGWyLrt7QlUvx8GxJjamY22O4ZVxc3Du8YlNvdbofnvALzb440mjukaNx4rZ2EQGPXhEb9EtV13yKKOEAqAYcE+Ib79J+mUsKuVrIkbObyuL+72+HuRKk8DuxkTD72WGay40A8oisQ+Q1iFAFWXMuGPKd+7Y3A+YLHZyWUtDZf6X6/MDMpB7UgaOEFaW1KMyY3txmQlIX0XoPLS8slzh8SXGKP4YBEKBFpx8P0S/aVhibJalDnqAKEAmRyqgtkfS4IDFW2ztPITz7J3dktvtrlLVfIWcxFV0UvZjHQcERcGIx5rC24aO1PlBlXI1Ca/Eb0kZK0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEJQtGY2XscdnHaGL3iL8lngYm7h0FjmX4e5Oqc8bBE=;
 b=Sl7kWCCCHJDtwK7DfUTybwkQfeiyqNRtytG5mXDNa3ycx5RLmAV3IUsgcLfr+jkmpXfTqOU2+l5nSl89jCpaKIx/C4ebTT99//VWBePExi/S5sFp1tVJemkfvy12p20m/zlqg0OVlnK2jejuLwtGHF/xC6ZwC2H50y6iCFqqt3c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:08:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:08:21 +0000
Message-ID: <a7a63ac1-1164-47e4-8704-6d0985f7a81d@amd.com>
Date: Thu, 22 Oct 2026 13:08:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: add 1 to to result of vram_lost_counter
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
 <20261021201459.715423-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021201459.715423-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: a286632c-617d-4f3b-d99e-08df302cc84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cDWUHFehDV5kl7pNwJPTHHymMo2har9gxO5ofsK/tZLzXc2cXGdGyr7/dhnaYd5CLwwPtvMJZJL+LwD+NoIK30dd5KjimNRrZby1jSpH6niAt9fnAZwY0X1b851/5n5LR0RAXQ24HuC6Dgy3xQ0bxn5zuhHH0GyBOOw7qolZq6tploU2bXQz/AVV3N6v3kwrwICUMMMPasePToeDpcRj6qqtO7BLJeG77DriUioHPUkzmNnPw6/9Be+rP7TLDnADJMjSbb9Nq6FB+EKJTwl9m4kvXmMedbbGu5I05vMcVYmd2OfXyowPxLotfR9MIkdUyVcobDxGflnl5w1MBqo2zg9a5JBl/z+ov0xpw+CCf5G5kR26Z1QoS9DD1lTtSiFb1flbP+gOjowL0e3KuQFyqFQgwfAo948m3xvgIgp+XBvoXaFaWeKCMKNjJsSohAYmsArYJmAfv6XadvglAgLnePJ5YIUovl0nJJdk4wtEchNCtI6genVKQWAMTS9a1oZxi2Fc2jVUh4d6CS8vddmHRyEXABx+6VTzg94pSDUZZFdc4ls2EnzFleC2EmL9IAkuZK6omIUs2XsD2wAPWFVg/N1o3kFHxpyh8ztYjc7vW3zAJGHdozbTo4UQ1XTZL1PXJMZBWjdcGl4cacd7XRqTooxtx+aCOq/fyP81xarntgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpGWjJhdkh0Q3plM0h6dVo1akE3cU5jV3NjM0NIRHZTdHpyZkdZQm9sUkFt?=
 =?utf-8?B?Vi9WdVNwVGFKYkJvNWhqdlVjUGFnQWpkMzhrL1VyL3d4dGVSdzl5UmpURGR2?=
 =?utf-8?B?aHJlSFVJOGlYdHArN3NHRmJJRC8zM2s5OTVLemdGTmM2aURZcURIL1d2WEh0?=
 =?utf-8?B?dGtoQUtuVVRqaU1YZmlSdHI3bGN1TzZUL0grRXdyOUlKeVR5cEF2RCtMU21k?=
 =?utf-8?B?ZW5FUkVVM2NwSDVkMER0NzVDM2lzdHllRHpVNnQyOUQ4T0cyek9ReWc1SWN0?=
 =?utf-8?B?YjR1NUNlaUErTTlPNno1T1RNSDJLVXZBOU8vUS9rZUdreEFsVXpYK0xFbWtp?=
 =?utf-8?B?ZEpJNXNlSldsK0xxbFZIenRnU2JUYnZuWTRuMEs3WUY3NXVtVk9yM1JqQjFW?=
 =?utf-8?B?Nmp0UU53R0Npb1NOSHdmMzBnSDFzMzBIVjhna0oxeWc2UUlVRHE2REx6aDdX?=
 =?utf-8?B?R3BacWNBa0QzN1FnTGRCRml1LzRFaFJjbzFZazY0djNzWFVSM3ovRFBFeEVt?=
 =?utf-8?B?RUlhdjlUUzFnTGFPaUcybnk2cEJCN2NGNzdJWWs1T0pmSTdtVFpJV1VxSFpC?=
 =?utf-8?B?ZWZaYy9EdlJxSlk5VFY3QmNta0l6blZ3UzMrT0lzVVpDcHJZNStrcEs1Sktt?=
 =?utf-8?B?MUFWc2Vtd29kTmY1eFI0ekZGcGtFd0RZRzQ3eEJGVy91Zy9tcGN1Z1F4QzlO?=
 =?utf-8?B?bk4wRnFZU2QxZERPcVhnZDRzY01XS1V2NndaLzZJVkNGWURGMC9weDVSOE1h?=
 =?utf-8?B?bVdmRjZrcllYZHhMOGlwdWVyZ2xPdTlhTGZwb0Z6TjJZVkdMZHoyL3VNSDdp?=
 =?utf-8?B?QUpNYlIrcXZyZHlubUlzaVB6a3cxSjBjeEszZkh3c1hWeitEbWd5aytuZDd4?=
 =?utf-8?B?YlNPYXZKN3dqOCt2b2VQcU0wUGxUOVdwOEFGMkUrWVJDMGtMeHhZLzlFb0lW?=
 =?utf-8?B?eXpQVllKL3BkQlIwVHZPZnVwbFBVWWI0WEhZclkrZ2JveEpVWXdGVVZmK0dv?=
 =?utf-8?B?NGpVMWRHNVdtazBJbHJ0THduNjV0Ym53cnhRTS9JN241VkVUT1EvU0tsNDNE?=
 =?utf-8?B?REt0R1FqWldpb3RTNi8zcVdqbWpNZngzWFY3bFZDNkdkVTRZcW5ZdFN5czJV?=
 =?utf-8?B?YjAwOGh1dW96ZmFUcDZhUFlXS0FaZFJVK3BPRVBJNlJFejRNRGJxaVQ2TTZn?=
 =?utf-8?B?eEFEVTJxQkNNU3BnM0dMOUdiWmZySGlZTHFsZGhpdHdWOGlic0czcTlHTm14?=
 =?utf-8?B?QXRubFNUVGdCRnRleUZ4YmE0UGVhSXVhYncweUx5bW1FSWNsYUJINjVrRnZ1?=
 =?utf-8?B?elpzcGFqYU9HbXhZbHppVEpQUTVqdFNUcEQ5cVdSb1UvbWl1QmVGdWExaFVn?=
 =?utf-8?B?OU5zd1MrbzJhVGJwYWcvUTVzTDFRUitBckw2eWhHOU12aGdDU0MzdjR5ajBD?=
 =?utf-8?B?Sld6VnhXSUVCaXAwdGYvVFArdHlzZHgwN1ZEMktFWFEyVWtXYzlSMnNsR1Iy?=
 =?utf-8?B?dUdoV2pRK0xkWkdYUDZZMVQyU3p4ZmpPTTNXUFNYai9yNUZ6VUo2UEJySHZ6?=
 =?utf-8?B?OHhEc21oUGdpdy81N29sZ0hHOEZ1S01uT2ZTM29tK1AwTjU0cXN3d2I2NEMy?=
 =?utf-8?B?UVFCVmwwSWw0SFIzVVRKVEU0VkVxaFd1Y1YyY3lCaUtpMXNrOFpRMjc3S0pi?=
 =?utf-8?B?L1RGZW5ieUUrc3dsNnhHWEk3czJoSDJJbU4zaFNndkdVbzZUWWhmUjEzODdt?=
 =?utf-8?B?T2RFOVdJZEljSkNaeVBCWWduVXJNL3RmN0RyZmRpWFB4SjRndXY0YXMyUi96?=
 =?utf-8?B?aWxEZm01OVIrb3BqalBzenQrWmdaQTF5U0hRUkJxcW4yOEFzU3pVREt1cFBY?=
 =?utf-8?B?c3dLb0ErUXV4OGV3NDl3UDE1SGRZcmNNeHpjdGR0REdHS0czOWRtdEpwVTBO?=
 =?utf-8?B?aFdwdU8zUWN2WGZIV0R2RmFmcGlqT0pFUUtlenVMTkpsUDZFSitoZHRvaFMz?=
 =?utf-8?B?UnB6dG03S0JOOTFVK2pHRTRmaFpxdS9CMWtiMUFOSlNWNHhYL2dyYW0rcnE0?=
 =?utf-8?B?d3Y5bDdhYjNGRU9IcFViL0xIdUgycnhManVpSGw0Q1Z5NUhCK08wcnA1Q1Ri?=
 =?utf-8?B?ZlRNYjROQnppdHBLNWNSeVVtUDhRSVFSRkZodi9yNldqbS9aU2VHQ1NwYkw1?=
 =?utf-8?B?VDJVZkhmTUgxbFhyeDBoZlhkeUpvQWF3cUlrWjZKSWJRSlBGOTZkUC9NQ1Y3?=
 =?utf-8?B?Mm5mWEt1QnQrUmhPeHk0SDFjRzVhM3o2ajA3SGo2d2RJQmkzL2liVDl2WjNs?=
 =?utf-8?Q?M9EnUYgAmPyvBw438/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a286632c-617d-4f3b-d99e-08df302cc84a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:08:20.9652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVODKpqIXO8Cp4C8tYPvifAla2C6sGqtHv8/keyXOfbkc4QNphpxBE08isqnKRqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

On 10/21/26 22:14, Shahyan Soltani wrote:
> [Why]
> The current implementation of page table validation does not process a
> vm->generation != amdgpu_vm_generation() mismatch if vm->generation is
> never assigned a value. This discrepancy is due to vm->generation having
> a default value of 0 on kzalloc.
> 
> [What]
> By simply adding 1 to the result of the vram_lost_counter, 0 is never a
> valid result of amdgpu_vm_generation(). This forces a mismatch between
> vm->generation and amdgpu_vm_generation() if vm->generation was never
> assigned a value.

Interesting approach but I would rather initialize vm->generation to ~0UL.

Regards,
Christian.

> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3f19d03fd7d8..1843b9d7bbf9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -555,7 +555,7 @@ static void amdgpu_vm_fini_entities(struct amdgpu_vm *vm)
>   */
>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  {
> -	uint64_t result = (u64)atomic_read(&adev->vram_lost_counter) << 32;
> +	uint64_t result = ((u64)atomic_read(&adev->vram_lost_counter) + 1) << 32;
>  
>  	if (!vm)
>  		return result;

