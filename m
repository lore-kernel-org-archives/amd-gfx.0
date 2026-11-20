Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BF606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VADaVpiI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445B4112816;
	Fri, 20 Nov 2026 09:52:40 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C52112816
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+N2zasl8EnfDYDjOY437Tw7lWY8FP53oslMj7yQ4pU3Y+9XD0FM+jbW/aIFaRL0GAYWDRgl7DEk9w8pBLiPHxLGiVV1qJdCWiD6nSeXlOe5aHBzNIavgMRSTgu8/XaaD8irrI6cJRR/vtjOIBv3W9KjxRrC4FFzyms6kE608/zfrUFpr9vU/Q0P+gLRRXpPSnur5GU/fb14BRK7h5k77eTVwkgKvwsVOS1f+q3vpMUOGlG80e6P123mwRxzKJNetyydvkq0oxX3UbE06B8vUsN/GAaE+MJy/+gWdNKmNTXEWRga89bQRsWXGTCm64m6xpihoBSI48FKda+XoA4Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eoii148960+t/QBK+4krf5aoVS5VPaAWjUjsJLLMg3k=;
 b=ms0TV+880/7JKU88IbEvnPynTOjLT3fbsG7K2W1R1oSqVQv6wVl1M/xOhhalQfvparMMwanQy17WYLqR0cZivsXtbGk1hbhYkgtXA7PqGAJOzYblnJHwWK1z3gVe01cZLmtiumc8dPRwTHNFSklaQqa3L1l3eg0QxB6flw3p+U37majr2IEAT0eSvLPkGj5pChiUVjL2K8bAQaA1tx4Nbamo4t0nO4j0wRvBOTxQgZW4S5y1FjKPoWDuxLeHYiOEhysjkz3l2ipPIIjTKILzSQobEko3XdmSg+Xi3BIdfZBJzMN9DCNA3yQSC4FKdHRLkUl4F250+9JZCasPAez6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoii148960+t/QBK+4krf5aoVS5VPaAWjUjsJLLMg3k=;
 b=VADaVpiItBVqCnijaDPKMqJfXSqaCsh75CuxeH/ypsVln3a+VVa7fwdJBN5Tr4Bh67okX7S/afGB7gGGUH8L2giraoIIqbT7I4VPPpJlKBAde0GUdJvZ+MKLT/275bSzhNJkf63+V1aodnHJDZ9zQCpVgmaeDbvva76RGDLjmcU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 09:50:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:50:25 +0000
Message-ID: <f62a5a28-44e8-4f21-9045-6f3d1406a8e8@amd.com>
Date: Fri, 20 Nov 2026 10:50:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm/amdgpu/vm: reserve TTM_NUM_MOVE_FENCES in
 amdgpu_vm_lock_pd
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119144049.2057674-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:91::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: a89ab57d-ca8f-47be-e8f2-08df46ebb361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: roZXghulSuDT4q2wrejTw0bpcik/4PKZNbmjSdvlai2ikWpUOPVKHz0JR9L0IzAQJGJRa2zvOMa0Zfl7PZsAyFKv22qekK00XjbJTp+cBT+YpnzvSRmg2ECuAle3JY+ApROt9jw69BLFcGn6rcLEvgJKMc+QLLg9SUpvjbGfukL495dACqxm6A1Hq+MIcbhLeAO7kd7BwPlHb2rRTH1WPDnXyzF1CimycUqrQYSRWY6GkWNUuFNCvzTlf85fU7V10X/jEiqA0bZn4fZvs+FHVmbc9H73m1wT8/XJsvkZKQNnHHV46tHuSqlW0lvWReUozKFtf8oMaPRKuRD6Y5TyXSyAQ/Hf9wBROM33kUHMr5cUrW56EbKwQJ7obMANdKbh/3zZ+Bzm1rydeB+fhjDYxzAJraZ1OYktCUioU9sok2WrCx7Zcrpl4IZSvo70KyyNZpt2+najajJPex/iOQKn6Tr56kloAO6UKV7oELSW7xQfkE7VToYTmo4qoIc8lnIFCErejbScMcUMyrAxgGKjcwLAdmKWtbauQG/CT6jjcY1xFU3be9AltEc4j1NuBF3F6TqbBDPXpFs6oCRRw6fz/vSfRFuglpcLkiVn8J1o/fjSxr7mRjbkGesY+NkrbnrkprJMDDBcq7ATuSJplChRCxPzNktSyDxIg/dM7X/cZNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzF5VjkzNmJzYXM4YUZ1VWp6Z2hFSUZISk1QYnUvTTZsWGF1RWY3SDZiTkFT?=
 =?utf-8?B?Qmo0NDZ0Vlh3MlhBcUdaRjRiNkdhWjkxdHR5K2szV2xGcWpMSldVRGQ2Qnl5?=
 =?utf-8?B?TzU4RWhtQkszZEN5Q0VBVDVvSlVBY0VIUnlycm5CLzJYdjkwNEZsNml3cGxR?=
 =?utf-8?B?MHhBWW1zR0htVVo1ekhxUEJNeUgxNFJFenNYSWVNVjRTbGlpQm16V1hEd1hI?=
 =?utf-8?B?NUk5QjMvVCtyd0s2eVZLN09kMlNxdU92SFRFSDZjR2t6Y24zM3lLQ1laSXdz?=
 =?utf-8?B?YWdNT3FKVlRCZk5hbXZSZTFHTFUvZzBhSGJpaUx0K0s3R3JveGw0TzBkYnUy?=
 =?utf-8?B?VzJvRmxpZDQxRXpIYlExS2huVkhKb0NXVS83NGd4OVVJclg1YjBQUkdBQndr?=
 =?utf-8?B?M2d0ZmpVOTBHczdWRTBPZE5PdlRMNVQzWk1DT3VQZnd2cC9KQjVVblNxelJ1?=
 =?utf-8?B?Z0ZvQnIwR2N5YnZCL21FcW43Vk9DRXpFY3d4TW5vWlR6bFUzM3RpZklnUUNL?=
 =?utf-8?B?R09wSEU2SnJvWXh2cWpQVUplK3RjZGl0dzJwd3Q5L0NkUXN3czhSQ0FQRm5T?=
 =?utf-8?B?MlNKU1JMNUYwckxhS1Z5Ly9ycDg1THpLMGNKbmFrZ0NPNWcvZU5USFRRZWlj?=
 =?utf-8?B?R3FLVWlDVGl2c3FxQzMyWDFjNCtydElPWm5Ic3NndXYraVZIdkVUcWtLVzNH?=
 =?utf-8?B?bDYwbFkxSVYwbnFEVFV5RHVEWXYrZktnNXVFaEM0OWc0VXlGc2dnMk4zMkFj?=
 =?utf-8?B?d1l6REJNQldzR0NkcXZKeWFCbGw5SGpFS1Nsait6UVNWV212R212b3RHQ2Rv?=
 =?utf-8?B?UXhTbk9mMG1URTd6d0xMUVh5ZVRDT2JPcVZSbHVJVnJqVVExYVFzRGVHdWE0?=
 =?utf-8?B?RW5TR1BqVzBWR0Z0Ujljd2dmL1hYRG1ObW1RRDZBNllFOEFDRTZmTmRNRFdZ?=
 =?utf-8?B?V2pRZFN0WWphanNwSERoTXJRcStTMUZZQjVEeGZ5d1BxZzJBTzY4aUNUd29k?=
 =?utf-8?B?K1hRV0tlV0JvTmJaalV4Y0E3a0lpT3ZtZHhiM1BOdjdpTUM3eTh1WE1sWnI4?=
 =?utf-8?B?R3N6QUZQdTJBTVo1dGdpaC93M1VUUEUydDYwcHYySGpiSWZxeU5WMjVtUmJV?=
 =?utf-8?B?Nnl6YkZWamFySXM1aDNkUnlqU1c2bVVXWWdyQnlEQlJ3VXM2MUROMVlqb3pQ?=
 =?utf-8?B?NHdZQ1pWdi9mVXlOWnZPeWdxTEdUMGF3aGhPd1Z6UlVIQUZkdXZPS0MrMGlv?=
 =?utf-8?B?VWNBYThGZnZTbVU0VW1tYy8rVHhGNEtWVEIwVTVlM3J1MUFJMlUzRi9iU2xq?=
 =?utf-8?B?Ry92STBna2ovS2wrRWsybHhZZGd4T1dDbjR1L2dVRWFkNUlmd2lZNUdqVkJ4?=
 =?utf-8?B?M3h2RW5tREVhK3NRMTl1ak5nMnVLakY3VkdBRFN5dnVyZlR6RjdxTVNweDlV?=
 =?utf-8?B?VDZIbFU1TVVDcjUxTDdrdGtRSmFvZnVQNFh2QXpsbUdKYThqQXM5cnAwVFhu?=
 =?utf-8?B?K3d5Zno3ZjVaaURsRFJxZGR2R0VCSmR1RkVkQ2p0bGdnMzdEWjR5azFxRnY5?=
 =?utf-8?B?N2d0ZmNhQnVGQm84YnRxV1hKZGRoQ3dqekJWYUxMT1M3TXA2OERiT0YxbWZv?=
 =?utf-8?B?VDk1N21hRzRqYkV0VWFZRlNKK3B6aWpXTTkwb0pFNml0Rjg0bE5SdjA4V2x3?=
 =?utf-8?B?NnhkNXZTVkErT1A5aFZJK0VKalZSM0hVRzNWN2lOSlJBZXhLMnB4REczTG5Z?=
 =?utf-8?B?Wmp6eSsyQlJTU290Tm9sZ1YxcVliTUhHek5idlI2RmlnT2UzNEphRGNnZDNo?=
 =?utf-8?B?alFDTGtYWndCbkpuRkFjNSt6Y1NFbUUvaG1kM0JyU0YvbGg5SThEMldIQlhG?=
 =?utf-8?B?M3ZyNEIwdXVNZTg5bm12c0Jvc2tPT3RSdWhrUWZ5dVZNa3Ywd25adGpFT0Vv?=
 =?utf-8?B?Ynh5VzBIRUdCRXpobzUrb0xhSG5BRy9nMElybW9HamJ1QnRjczN3OWl4RVhv?=
 =?utf-8?B?UzNEaGlFc2hyWGY3WWhBWVZhSHZlOGlON3pYSVZIdmliaXg4M1VYZFRsS1NM?=
 =?utf-8?B?UUdZT1dlOGVERzBxb0xLYW1UZTNzYjJseTNndEpCM2Eyam5uUHZMMGRjZTRD?=
 =?utf-8?B?cERlSmhmOVZwYjUvUXBmL3R3M1cxS3lDM255VWdPSHRrcTdRWGpnK0E4cUxZ?=
 =?utf-8?B?Q3Q5MDBKa0dwOUpTUUV6L0JRUUlyYkpPUlBYRGNtMmNDNm5aZnlLNUM4Nmwx?=
 =?utf-8?B?RGlYVGZOeWJEUVZlWUtVWjk3VjM3aUlBb1VVazQxdHlNU2M5Ynczb0NsOTVs?=
 =?utf-8?Q?EXdGjfoBaxOvSE+DMD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89ab57d-ca8f-47be-e8f2-08df46ebb361
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:50:25.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W7JmNbesRmtUDXDIQ/E+XUdrf7b4uMOcTCGWIa2GWRBK1AMBYmeVig1Fo0RiduL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

On 11/19/26 15:40, Benjamin Cheng wrote:
> Page table updates may result in PT/PD allocation, which can add up to
> TTM_NUM_MOVE_FENCES to the resv.
> 
> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
> Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
> v3:
> (Christian)
> - Don't introduce AMDGPU_VM_UPDATE_FENCES
> - Use 2 instead of 3 here since last_unlocked and SDMA commit are from
>   the same entity
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8cc5964f29c0..4d31c41fb684 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -464,7 +464,7 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>  {
>  	/* We need at least two fences for the VM PD/PT updates */

Please update the comment as well:

/*
 * One fence slot for clearing newly allocated PDs/PTs and PDE/PTE updates,
 * another fence slots for TLB invalidation fences, TTM_NUM_MOVE_FENCES
 * for validating PDs/PTs after eviction plus anything the caller requested.
 */

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
> -				    2 + num_fences);
> +				    2 + TTM_NUM_MOVE_FENCES + num_fences);
>  }
>  
>  /**

