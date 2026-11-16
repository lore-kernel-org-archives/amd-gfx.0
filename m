Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4F606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n8F9F+OS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B2810EAA4;
	Mon, 16 Nov 2026 19:42:07 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB5510E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv68lrNilQKdvkdPrw+WQ2IHz9jp6qlsswpCOwOY/NXqFmvLBpejn+SYQvJ7X+++NCnbrmgp9MWS3kOG663gx3REKS+44ODI922K3rs6J95Pvk621MHQvSDHMbiNzof3hFCArjjjDerLq25eslCIbuuthqM309XBD1NGRMzifTGCuSPkw7s4Av5lUNBlVGimprZTROaINOqxtbyRtRrjahuQi1bBycAtf7c0Pg9OoXcnSyvg/g1iO7uMj13o+WvTAlEF2Vy2UcZ9wGalDPnrPyN3LO7TfKBQTCPH9ZRow95ji/Zt6p04J36cq3x0kruDmRoIKVpZmxzIwrzwpAV4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBKBDBYwvKs/Krg8XnD43AShugLrjT/p+coFdiHwIpM=;
 b=ZBf+LjOJWX2rgZbVFdwlkIzq7AvJq4AliW0eTMEAoHH0/gFDpDtygwm5xeQJfThaufFjKnBB6+7tbaoSbEUkiaUhPgBaMHsXhd2rcOT5LZyPl6sbhqb147Wqw5Dd1twTUnI7MJsLy/GYzeJSxNZFCt7X/LIc/KwJFneTvetWc4JSSGDH1kUSIM6Xlx5tzcx2jYH5JTAzWPaKSmp/A3WNmHJTXRoFD5Ki/dJTEj//l1R6qH2M6YHK7MNRJGxk3+t8MaxcCd695Sqj4wwqbyZTnbkg/QQv0Nfyc9J4bSr8NlvCa2H+P53FDircgIMnXp+gBfOxRsGLmzDnwUMwNO0enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBKBDBYwvKs/Krg8XnD43AShugLrjT/p+coFdiHwIpM=;
 b=n8F9F+OSalycZBjmYlpUNdPgHklxHY0Uwza5oOlBwEfiE8podJPobqWB44w8UpBnsuYrQy+Ew3G33zAICDQbSVmcc8AHRU9pU8e0SG49fVunSRb76w56W5K8lLGChdrjnDsmc89ip+W6wMNnoKJBp/eAX9zzwshePTklrUGQLIA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0SPRMB0093.namprd12.prod.outlook.com (2603:10b6:8:1d3::18) by
 SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 19:41:52 +0000
Received: from DS0SPRMB0093.namprd12.prod.outlook.com
 ([fe80::3c02:b65a:ebf5:7bef]) by DS0SPRMB0093.namprd12.prod.outlook.com
 ([fe80::3c02:b65a:ebf5:7bef%4]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 19:41:52 +0000
Content-Type: multipart/alternative;
 boundary="------------TjfSvDll5i0HPTLxoNnMBrCL"
Message-ID: <ecf12967-a1ec-4a99-9816-6ae966efd80c@amd.com>
Date: Mon, 16 Nov 2026 14:41:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
 <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
 <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
 <ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com>
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To DS0SPRMB0093.namprd12.prod.outlook.com
 (2603:10b6:8:1d3::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0093:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: b174fa99-9572-4e91-acfa-08df4419a9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|8096899003|4143699003|11063799006|10067099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: +9DhNZroHYziGP7AVdHRrc7Vn0HdbP2kbdJSbj3ZIcwh6gvjHpT5ac9XaGfl4V2/W/2JNIvZHWVxJPTM+tC4rf93EcDNmihQszP3c/lZpmfJ6Af6R4ysIw3jiL0qj0xqMikTIuMT8zqR/FjBgltv+j4xikJMia4P9WmPGE+ALWaR17sGcMr/oDhmNJgyVQxa9gtdDUqvtKXTmryRQAoUdKHFExXY7sP5kAorFc20Hb2VIg5WSRL4w2FIpzlNW70l8B9D06nxoiMSWrc3gNSYk3+rbLiIUTj+VT8LMPqekJar4O46iVIYrfMKlsBnw/5qExrorRXyepZYHOVC2avBH+YqnJeQ7O/3ZanjssInyK+yit+DFYdJ2TnuurKkAI7lX1xY+uwQsDl51bfZf2ain9LJ1934td9/kTpuFLkdrWY0Fp/cZ6heax2HELtSZXn8oO9Scnj1d8cm4tPLyXYnwSBqLIT6q8vZfz85R+fmdZS7T2Dc35FisicJ9K0AMqFcMD1xG9ZZqVotrsrhNkrFsRZ7bcU8DZCmwBsuDdbHoztm7eA2E9uZq/io0G8fka3q+WTUSoVGPA6vg+PPM5NVfH0BOqGJZ/eFsG9m6HZiX1LyeaRdj1sfYBtse0TOVH8qtQURIRvmz0C0zRuJPd4MydhEMX36GLzrNTxjf/5f1hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0SPRMB0093.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(8096899003)(4143699003)(11063799006)(10067099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZWV3hGQkRWcEhDc0UzSGd2eVpSSGNaNmp2bGx6MG5LbEZLSjF5aVdQVG43?=
 =?utf-8?B?N0s3NURHR084NFdSTmoraWlhMXg4cEEvZ0VOdUlVbEJENGZKN1NzV2lqRjhW?=
 =?utf-8?B?RlJEVFRmUWs2RFpFWFhOSGxTNFh5WGoxMEJsektoZnN0STJ0MXFIaTF1QVRp?=
 =?utf-8?B?VklJb3BXMS9id294c0NwcEc0UGpnMjRPYm9LQWNkSXg0RVZYZWNheHJrV1c5?=
 =?utf-8?B?Z04rNDhpVzFVNGhVcmo1aTlxdzNGWmF0UTRoMlNQMUxhcmxwSVVhbmZrdmx3?=
 =?utf-8?B?Ly8xZTIvRG90dTRWVVB2NFd1d3hheUtXU2JWLzN5R2c0MVM3czRHcTdXSGo3?=
 =?utf-8?B?a292UFdjVTJuOXE0RTFCQk9icUN1TVNXNGVjdlRSamU5bjFKSzFWUW5oNzRV?=
 =?utf-8?B?b2ZjTTRxTWVkNkNiMG5kNWZEb014TW1oN2dSNm4rbkU3NkRLd29hdmJhMm4x?=
 =?utf-8?B?N3dRNk16M3JncGlQUWNFS2JxWW1weDNBMWs3eXZUcVBaSFZoVlZHNjNMQmVG?=
 =?utf-8?B?cHBOZkhiNWVOTGt0dktXbVRxa0lqOGNPWHloakpWRWZzNnBmbHlxRVBjQnhB?=
 =?utf-8?B?MVdqcFYwU00yZldJalh4RFJIT1NBMmpsNzBKamN3bTBvSjJ5Q0RyVU9Dd2E2?=
 =?utf-8?B?bnphTGpuMURBSXhPdWsxT2NrN2pzN2JMVnRwbExwd1p2d2s2eU5rSXFmYmhT?=
 =?utf-8?B?eTVZc2lzWG53Kzl5L1k1N1RGOUkxU2d3Skx2TXo0UVRtWThPMlZiOW9Bdno1?=
 =?utf-8?B?Q3hQR0IrWEd1VzA1QXlqQkVvM2hhSk5qUGppMnJ2VThTYTkvT3JzOHBrQnp4?=
 =?utf-8?B?UWN4bDMwT1BBS1FPMmVHbTdPa055Wm13eGxSSjFpcm1jcUNNV0svcUtQRDR2?=
 =?utf-8?B?aSt5T0doOGxBVTZRY0RvS3hYczFIblgwY0RKV1RVMzR2YkprZUZGNkNOcVVU?=
 =?utf-8?B?cUJ6R0lNOVR0UUtzQlFLbElkemk1ZDl3MEc2azRlQ3ZwbVFucmw4YUEwdDZ0?=
 =?utf-8?B?bldHYkxGQ3RZRUowZzUzOGFoVFFWTkxTdStoY2RmUTdjTmZxN2tNQlBrK2No?=
 =?utf-8?B?b2Q3Wm8rZnZZc2N0WFJ4NFZjUmNUQVZOODUwK3JyeGxwdFc3Z3BCdjJYV3RV?=
 =?utf-8?B?TjhqemlBdTFyWGFNZTJzRUpDdkI2RE9mYUhOOStKRC9UV0FqdVRRZ1JseEdS?=
 =?utf-8?B?ODZGZnFxZkdQcnRqa3JGdEFVb2tCOUhTMlE0cG1SWXMxMjFkSXJoN1Y0M1oz?=
 =?utf-8?B?YXFSUGtadyt2Yml6bjM5OG12V1ZGRkkyYlVCK3I2Ylk4NG5GZmsxU0RsYUt4?=
 =?utf-8?B?OXVGNHJzNGhnN3hKSEVLWTk3OG45d3JtdHhoZUdJRkpicXlIajFMRzJ4enZw?=
 =?utf-8?B?bXVJSW5hY2FlWkhFQ0FWTi9kcktwbWdBK1I5WjdCVm9KM1pmMVc2YzVSeHQy?=
 =?utf-8?B?dXNHVHVpZTZzSFBJTys4YkYwS1F4NklwZFZBL0VYT3A1Rk1HakJOa1Zya2lX?=
 =?utf-8?B?d3JFd3htYVdjMWhYVU5zZE5hMjB3SFhOM3pnYzdDSmR0WGZkRW5QTDRBTWNE?=
 =?utf-8?B?UFQ4MGsyQ1lnc0xJYWk4NDQ4YyttZDN6M200dXhzQkVhMklvNE9SUlRla3VO?=
 =?utf-8?B?bW44cTB2a3lCUUh0WGxNSEFkVjNWT1RnWk0xdTZ6dEUxelphSEJjRjY3TVF5?=
 =?utf-8?B?Qkd4bTdtOTdKWEU2SytkKzZpRVdUcHNxRFpWc1N4UWhNbUN2OENnZi9qZkJt?=
 =?utf-8?B?dk5IMFFlblJveENXL1pxSFUvM2lkOC81bjZMVFI0SUNpMWUyT3UwYmFEVXlJ?=
 =?utf-8?B?UWJGaEI0bTEyZFVJSGhNbnpmT0JqM1orcDAyM3p6UFNZSjNKVWxjY0QvcWF2?=
 =?utf-8?B?ZzVoSEU5eC9mdzhsek9WY3pMK2pPQ2twUUw3V1J0ZVZDeHdhN0VETHZPRmU5?=
 =?utf-8?B?RVhQZFU1QnV6anF3U0Uvcy9NNGh4VXBTV09FV3Mvdnc3Zm1oNytDN0NrdTg5?=
 =?utf-8?B?UjhaVzBhdmVoOHlxT0FCLzU3aUdKRUY3dG8rSE95Rll1a0w3amtZVm1VbFNE?=
 =?utf-8?B?L3c0Wm4rZmR0MDRwVk1NYkhMb29DVGxpQmtvaExTR1hGWjVFcVhhVzhiSzNk?=
 =?utf-8?B?VHA0WVlXWkZZWlRXSUJTZS91SVhlaXN6dzlVSUhIYlhWTm5ZLzAwdFZHN285?=
 =?utf-8?B?VDRyOTY3NXRxeGtLR04zMlY5aGhsN3M5U1BaVTMySks2SHBMVVJkVkxGYlNZ?=
 =?utf-8?B?VVJZUXQ2U28vSS8rclFVS1p0U3k3OGxGSVB3WTZQQXkzNnZMUTNwbXQzQUk5?=
 =?utf-8?Q?eEDNCy9dQC27gIfd+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b174fa99-9572-4e91-acfa-08df4419a9a2
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:41:52.2567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GeyZI2PDUJdDDbj7ORkIOJxVZjB7faXqIyhwSM7gXelI9kFBGFPUIW6e+F8nNgUUl08q1KGZD1VqfbJiAxUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------TjfSvDll5i0HPTLxoNnMBrCL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-16 11:15, Philip Yang wrote:
>
>
> On 2026-11-16 10:24, Christian König wrote:
>> On 11/13/26 21:40, Kuehling, Felix wrote:
>>> On 2026-11-13 15:29, Shahyan Soltani wrote:
>>>> Previously, the root PT was never cleared after setting vm->is_npa =
>>>> true within amdgpu_vm_make_npa(). This resulted in the flag
>>>> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>>>>
>>>> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
>>>> been pinned/validated. This allows the root PT of the NPA VM to be
>>>> cleared with the correct value.
>>>>
>>>> If the pinning or reservation of the bo failed, the vm->is_npa flag will
>>>> no longer remain as true. This is to avoid conditionals outside of
>>>> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
>>>> the VM is a correctly initialized NPA VM.
>>>>
>>>> Warn if the VM already has mappings, since clearing the root PT will
>>>> break existing mappings. Do a heavy weight TLB flush after the root PT
>>>> clear to avoid any stale translations being left behind from a previous
>>>> table.
>>>>
>>>> Remove the redundant second setting of vm->is_npa = true.
>>>>
>>>> v2:
>>>> - Add the WARN_ON sanity check regarding an empty VM. (Felix)
>>>> - Change the return handling to only set vm->is_npa = true upon a
>>>>     successful pin (Felix)
>>>> - Add the heavy weight TLB flush after the root PT clear (Philip)
>>>>
>>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>>> Signed-off-by: Shahyan Soltani<shahyan.soltani@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 94b1cfe05e3e..c7187e0f99b3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>>     */
>>>>    int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>>    {
>>>> -    int r = amdgpu_vm_make_compute(adev, vm);
>>>> +    int r;
>>>>    +    r = amdgpu_vm_make_compute(adev, vm);
>>>>        if (r)
>>>>            return r;
>>>> -    vm->is_npa = true;
>>>> +
>>>>        r = amdgpu_bo_reserve(vm->root.bo, false);
>>>>        if (r)
>>>>            return r;
>> You need to reserve fence slots both for pin and clear after locking the root PD.
>>
>>>>        r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>> +    if (!r) {
>>>> +        /* Check if VM mappings are empty, clearing would break existing mapping */
>>>> +        WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));
>> You should probably move that to the beginning as if (WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root))) return -EINVAL;
>>
>>>> +        vm->is_npa = true;
>>>> +        r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
>>>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>>> The TLB flush isn't really needed IMO. We don't expect there to be any previous mappings that would need to be flushed. If there were previous mappings, we're in a broken state anyway, and the WARN_ON would tell you about it.
>> Completely agree. Sashiko-bot also complained that this wouldn't even compile.
> I agree that there is no mapping on VMID 15 beforehand (which raises 
> the question of why we clear the page tables in the first place?)

The reason we clear the page table after the switch is, that the NPA 
page table uses a different PTE encoding for invalid entries. We want to 
cause non-recoverable faults by default for unmapped addresses. Normal 
VMIDs cause recoverable faults for unmapped addresses.


>  My concern is stale entries in the cache: after we set up the VMID 15 
> page table address, we could still get an invalid translation.
> Sashiko-bot complained "premature TLB flush in amdgpu_vm_make_npa()", 
> probably means we should flush TLB after vmid 15 pt setup, like this? 
> amdgpu_ualink_manager_start() { .... amdgpu_vm_init amdgpu_vm_make_npa 
> amdgpu_vm_pt_clear

Let's assume clearing the page table is done by amdgpu_vm_make_npa.


> setup_vm_pt_regs amdgpu_ualink_flush_tlb

Doing this here after setting the PT base address makes sense. That 
said, we're also doing this in amdgpu_ualink_metadata_npa_mapping, which 
is probably sufficient. Setting the metadata needs to happen before any 
remove GPU can use UALink. It runs right after amdgpu_ualink_manager_start.

Regards,
   Felix


> ... } Regards,
> Philip
>> Regards,
>> Christian.
>>
>>> With the flush_tlb removed, this patch is
>>>
>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>>
>>>
>>>> +    }
>>>>        amdgpu_bo_unreserve(vm->root.bo);
>>>>        if (r)
>>>>            return r;
>>>>    -    vm->is_npa = true;
>>>>        vm->need_tlb_fence = false;
>>>>          return 0;
>
--------------TjfSvDll5i0HPTLxoNnMBrCL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-11-16 11:15, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com">
      
      <br>
      <br>
      <div class="moz-cite-prefix">On 2026-11-16 10:24, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com">
        <pre wrap="" class="moz-quote-pre">On 11/13/26 21:40, Kuehling, Felix wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 2026-11-13 15:29, Shahyan Soltani wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Previously, the root PT was never cleared after setting vm-&gt;is_npa =
true within amdgpu_vm_make_npa(). This resulted in the flag
adev-&gt;gmc.no_retry_flags to never be applied for the NPA VMs.

Call amdgpu_vm_pt_clear() after vm-&gt;is_npa = true is set and the bo has
been pinned/validated. This allows the root PT of the NPA VM to be
cleared with the correct value.

If the pinning or reservation of the bo failed, the vm-&gt;is_npa flag will
no longer remain as true. This is to avoid conditionals outside of
amdgpu_vm_make_npa() that depend on the vm-&gt;is_npa flag to determine if
the VM is a correctly initialized NPA VM.

Warn if the VM already has mappings, since clearing the root PT will
break existing mappings. Do a heavy weight TLB flush after the root PT
clear to avoid any stale translations being left behind from a previous
table.

Remove the redundant second setting of vm-&gt;is_npa = true.

v2:
- Add the WARN_ON sanity check regarding an empty VM. (Felix)
- Change the return handling to only set vm-&gt;is_npa = true upon a
&nbsp;&nbsp; successful pin (Felix)
- Add the heavy weight TLB flush after the root PT clear (Philip)

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shahyan Soltani <a class="moz-txt-link-rfc2396E" href="mailto:shahyan.soltani@amd.com" moz-do-not-send="true">&lt;shahyan.soltani@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
&nbsp; 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..c7187e0f99b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
&nbsp;&nbsp; */
&nbsp; int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
&nbsp; {
-&nbsp;&nbsp;&nbsp; int r = amdgpu_vm_make_compute(adev, vm);
+&nbsp;&nbsp;&nbsp; int r;
&nbsp; +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_make_compute(adev, vm);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
-&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">You need to reserve fence slots both for pin and clear after locking the root PD.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_pin(vm-&gt;root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+&nbsp;&nbsp;&nbsp; if (!r) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if VM mappings are empty, clearing would break existing mapping */
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root));
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">You should probably move that to the beginning as if (WARN_ON(!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root))) return -EINVAL;

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm-&gt;root.bo), false);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">The TLB flush isn't really needed IMO. We don't expect there to be any previous mappings that would need to be flushed. If there were previous mappings, we're in a broken state anyway, and the WARN_ON would tell you about it.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Completely agree. Sashiko-bot also complained that this wouldn't even compile.</pre>
      </blockquote>
      I agree that there is no mapping on VMID 15 beforehand (which
      raises the question of why we clear the page tables in the first
      place?)</blockquote>
    <p>The reason we clear the page table after the switch is, that the
      NPA page table uses a different PTE encoding for invalid entries.
      We want to cause non-recoverable faults by default for unmapped
      addresses. Normal VMIDs cause recoverable faults for unmapped
      addresses.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com">&nbsp;My
      concern is stale entries in the cache: after we set up the VMID 15
      page table address, we could still get an invalid translation.<br>
      <span style="white-space: pre-wrap">Sashiko-bot complained &quot;</span><span style="white-space: pre-wrap">premature TLB flush in amdgpu_vm_make_npa()&quot;, probably means we should flush TLB after vmid 15 pt setup, like this?

amdgpu_ualink_manager_start()
{
....
   amdgpu_vm_init
   amdgpu_vm_make_npa
   </span><span style="white-space: pre-wrap">amdgpu_vm_pt_clear</span></blockquote>
    <p>Let's assume clearing the page table is done by
      amdgpu_vm_make_npa.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com"><span style="white-space: pre-wrap">
   setup_vm_pt_regs
   amdgpu_ualink_flush_tlb</span></blockquote>
    <p>Doing this here after setting the PT base address makes sense.
      That said, we're also doing this in
      amdgpu_ualink_metadata_npa_mapping, which is probably sufficient.
      Setting the metadata needs to happen before any remove GPU can use
      UALink. It runs right after amdgpu_ualink_manager_start.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com"><span style="white-space: pre-wrap">
...
}


</span>Regards,<br>
      Philip
      <blockquote type="cite" cite="mid:2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com">
        <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">With the flush_tlb removed, this patch is

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
&nbsp; -&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;need_tlb_fence = false;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------TjfSvDll5i0HPTLxoNnMBrCL--
