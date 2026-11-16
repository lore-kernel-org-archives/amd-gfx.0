Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC7606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=prqvXSZW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3CE10F054;
	Mon, 16 Nov 2026 12:45:05 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5943210F054
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 12:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr9g31YYugdlLtK5QuA2iAEjwk8zuihjesBE7aBnOQT1OelIaHhxF9R70zYlRtADTp4CfJ0blcvaYWikU872x7oS1iWQdm3j6nNLIWfTtN8D6LaDGuiJKTje7/Bbxl3QrIflVS+PwuyrcWD89N926jJlnRFF37iPCx4+lzTOmsaTW8RMi2u+ApSsoX9A4l2k18Bgxg2Nj5M3RBpZj2xyopSP5PPXGfg1Cs32EyfFRQYJbmoKB/dw7y6gTMoiivqh5muvEprtORqiPhPYkywf50ls+nh5fRLRqg2YLfLMmirFvGcEGJellrLLru/7XNtVlLOFx+2n1NxJVKtF38jwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X4WYzE8W1BYjwiy1EeEUt7wkWjUaw3NEtkXaa/RkFo=;
 b=Dc69b1rIPwHIDPQbslQiXehOpfZxPkOg0G6b/VA69OwNJUblfgEF4ktO3GQ0d4CtB/m+4AwWqaEhyesGV/f1EnhYOlPiDCUVAHi48g8n4GRTpt23jXXUUGBXOV5+bN0zgKhw3ZBa8Go3fxf2vxv84DOG+AK/2ovZcsZtoyVmt/+409zW4msKa25dZ4yrkZXXCoqxvpamx8rdSRfruATaQFh6LYC3CnmjeG4GtfuFrEHQirXlfIZLFoJB4vTt9psI41nuNRCXZOI1SGBrIZqjrTY0RbqQgifP09Y7L4XKU+24nNPSPxlhJm7Xuc+ahp09rOF17hPuHVZ1s5IrIm/+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X4WYzE8W1BYjwiy1EeEUt7wkWjUaw3NEtkXaa/RkFo=;
 b=prqvXSZW36bS6MHvpW636BJ3Q+/akGAAEbP0S4vm1hJJH59u0Ornro8lUQtYnNzgv8dZU2+xRSr994kUcKSTX/PJJzc+breE5pOqSBeNToWYiGpM27WRskXqWIZov/3TNc4+RKs87I5MINRU7+qt9+fT8rZQ53UChm0R0HAD/O8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:42:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:42:56 +0000
Message-ID: <bc6e8907-4425-4a87-a2c9-c32029587239@amd.com>
Date: Mon, 16 Nov 2026 13:42:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: look up the L2 trap handler mappings by GPU
 page
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20261116032304.2023851-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261116032304.2023851-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:208:2be::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e62733-81c9-4384-46e5-08df43df2378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JUG7sL8QM2ge4SobU5zorc5GWJC6E3FmCHnlBKsZNkatzMDlSGybAkALNU1Y4+/2p2+B8AsBF2UEplKuaq+9w/bDsBPBPpGDpVjLUlptbAavjVxmGc/7PlZuUyxnqzGJEHZt9ZZazTafG86rTt8fANXu3m+BSRsdlZpPq1SUTbQszdu1ARMY74SUPDNdMq9OiP/RZqiRvWh3C9IVVy5jHrZdQya3cNM3a7+ShZIXcqQQHHgcNbP7IFSHaGakDs3h2vglvtuT7mQO7RC2mxRLTpSWlJ0BtfytrZVuoJZdYKm0vg4yWVa8FeGe+kX8ze704hhUCQqpYdbRDV0PhYkVofJ5EWMrwYSx6bm2JIM2677AxaGiUqGHO7T7/cq5T4iZYjuwv5nXpZpCbxnMpF6CZ6n3AoXCjtzKEfzcxnCM8PV5NOwIGXDtNJY9g9dABG7tDI+GRuT5cbWQGPF1pjO0L7Vy4wdqiHRE4HeHJklM4GOYorAxCcC9D1x/pG4Byh+uOGi5nitKF1PAeUfTt34uqrLoL8TalNZ7QEN5xRDfYieBIXkJ+0I28mK3Ev6Iw5RMisZyVuPhQEqeruLGNLUVsTsGz00ZciYjAcNHe2q/zKEFl5uemr0sgx9nyYzG04tGCjOpP2A/WrDd0+HqdEyRQMBy6bgR5IVk9KubMSDuJt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlSM29UeHZhL2JxMHVWUDJnM1V0VG4zTnJaTzIrSDdyeGxTNTRaeUp5eG5p?=
 =?utf-8?B?dGtBUzYxOUFnMW9DYnNHNHFJK2dEWWl4YWdEQ0JURzBkVHpQL3VzVGJSamRm?=
 =?utf-8?B?K3liSldTVDFWZkVjZjhhalE2UEFrWFM2VC9BbjY5d0R3UmJiMXErYW1JNDli?=
 =?utf-8?B?QU1mVWJNNG8vK2pmQzdFU2ZRZFlnZ1k0S1p0Mi9NSXdRU0NLQ0Z1ODl5RjA2?=
 =?utf-8?B?WFF4dnZQUzB1NDdnRFNqL3hwRy9Fb1U5Z1c4ajMzTzMwNkZUNEpPajZTeFZl?=
 =?utf-8?B?R2Y4cmNLb1JYcUVWbnpoUkpuVlRXWUZvUVkvck0wR0V0UmtjTXVtbFFmblBS?=
 =?utf-8?B?Y1J1WFFGbDNIbTd4Q1BPd2QvQWVsQ28yTlE1UERSZitmM3d6SlhBcmhteXI2?=
 =?utf-8?B?M2tSc3B0cWhhazJvUVl3dWhqS0xTeUxMQTUyOVBIQVpLVEZ6eUp4WmJCN3kv?=
 =?utf-8?B?eGlKSzk1aytZNTBkQy9IRmZXai9HNVc2QlFqWUtLRUFqb0dNM1YyTWw0aktX?=
 =?utf-8?B?UGdHbW5YazEvR1AvYUxLbVVHNHM5QmhpVlVxb1o0aG96Um51bGZmbnN2WHZU?=
 =?utf-8?B?d1hHYVhDYy9TdE5PSzhmSFBmWklpV0FXQ0ZOSjlNNnVhd1FySHN5UDB1Zlhy?=
 =?utf-8?B?eEs1SEVKNFltYmZGUTlpZWdGU0xyTzBGdmhFWS8rVU1xNEhXOFZJOWNWMkJE?=
 =?utf-8?B?U1NsZ2tqTkhCSFh0VWE0Y3hWUjQ5VVhYU3hvc01BakpqQXdCS2duWm5xSks5?=
 =?utf-8?B?SCtuUzNBNjRmd3RSeWVCYmRwZ1lvbjBiSSttdnlIUnByYnRTMnYwcXR3UTdR?=
 =?utf-8?B?N0R4THRTZFNoSTA1YkNhWG9ic3UzVGw3cG1kRk1iTFlwaXdlcGdPSTRYZWxC?=
 =?utf-8?B?QjBBekxvUUF0Z3lVRmxTemMwc2xwYVc3bkpYSklPbkNsUXhGQ2JINk4wMVBJ?=
 =?utf-8?B?OC9pUWc0cnd2b2o2SDhxM3ZZY3Z6UVhiVkFMSGNDYTJteU9HTTU1M09kZkxC?=
 =?utf-8?B?VmJTQW16d0x4aUhhS1JmNmxidXpuYmExR3MrVy9qUFBRZVdPdnJUOUJPeC8v?=
 =?utf-8?B?OHVMenNaRnNxQWJEY3VlR0FBcS9xTHdsZFR4Z3hCbFFRYVJKTlJXeTJaVktm?=
 =?utf-8?B?V09Mc25DUFpvMVFEZVFkMWN1Z1dROVM1QXIxUjg4azF6NWgzSll0cTl6RktU?=
 =?utf-8?B?aVRsT3ZNdXBwVWl6OUtkWjg3Nk1Ta0NDSG9MejVpdmcyc083WWUvODZUWFhn?=
 =?utf-8?B?UjZlcE5ZZDF5SS8zK0NKL2R3Um51dXlaZktHb0RzVmtHYVdBUVN4WVlOR3h2?=
 =?utf-8?B?WHJsaytiRFNRbFAwc0RIK2xYQTU1ZEt2NmZNRHBxSCtXeENheWdoRmhaUnVJ?=
 =?utf-8?B?ekZJNkJENy9ZbXhvWU9GYmlWVkY4SCtackRtK1p6SkFRakN1N0lWUmpISzl6?=
 =?utf-8?B?SjE3cWFyZVlCUXUrSlBXbEJWYURhWU4vSXJaTzMzbXptTU5YTUhqdVNwL3Ra?=
 =?utf-8?B?eHdRbUF0TVBSZUZDd2VENzVOSmxXM1Q4SEZTalNJaHRGLzlZeWZwaFk0YUs1?=
 =?utf-8?B?YUc1RDVWakZjR0xVZThqRUNCamFnZnFMQzd6YmZ3RW00ME1EZno3Z3BkY1Iw?=
 =?utf-8?B?bmJXTG56blBnZll5TitEekdQR0pnSnFtSzVwcWk5VkhNaFNNSVlHSU1DYVRk?=
 =?utf-8?B?QUU3NittNEo3Z3Z0STlZT0VmN0NLWWRja2xZSUY5dUwzVkF2bjFuWTM0Ym5T?=
 =?utf-8?B?RGNZK2ZJS1BjQmx3UmZ1RVQwT2F1V2hKa3lDK3F5SHVWeHp3czJCTW1JV2U2?=
 =?utf-8?B?Y3J0OTJ4TW5mcXFJVGxDa2VIcWFKWXk2WVBOYllybUtNNzEwT1ZWSkhEVkkx?=
 =?utf-8?B?dStha1A3SjdhK2pWU2FodTJpRG4zcTMzdHpQaURldmxmdlphM0ZSbWFaclho?=
 =?utf-8?B?aUhjMlYwUjBWODNzdERkVzFKZ3FPRVBBVHp1MnlwVGxvZDBsTUxiZlNodUNX?=
 =?utf-8?B?cVRpTlpTeGlNbVdCaWdlWmZpamQydnhRVDk3RFJnNTUxRyt6MWR0Qis3TEh1?=
 =?utf-8?B?MmVrdzlJOVJWdzhGK29QTno2ejBDdDZ0SXR4NkFSbWtFb2hGVTVuNENFV0lH?=
 =?utf-8?B?eXJ1MUxyL1VJY1U2ZDkxakpyRnI2cGFMZ0luSG0ybmdkYTBCczlqMEx1R0FZ?=
 =?utf-8?B?WUg4V0hmdEpvcXVMMEN3MXFZblRud1dSUkM0Yjg1NlB5TEdTREpwbUJKR2Vp?=
 =?utf-8?B?SlUzejlxYTFheGdmbkpvTnRvTEdNVGVxWkc0WSsrTitVc0VKS0M1N1U3NVpZ?=
 =?utf-8?Q?PdKdNGLyPuCT0Inv77?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e62733-81c9-4384-46e5-08df43df2378
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:42:56.4005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWaH+tPkPk6hXAd444sy+GeI5n2Ms1FqK8UBepeuS1k6JY10IPTX8GPm9kBxnfGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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



On 11/16/26 04:22, Jesse Zhang wrote:
> amdgpu_trap_validate_user_addr() passes the byte address of the second
> level TBA and TMA to amdgpu_vm_bo_lookup_mapping(), but the VM mappings
> are indexed by GPU page number, like every other caller of it does and
> like the range check right after it assumes. The lookup never finds the
> mapping, so SET_L2_TRAP fails with -EINVAL for any valid TBA/TMA.
> 
> On navi48 with the VM ioctl SET_L2_TRAP added, the IGT slth-* tests map
> the TBA at 0x100000000 and the lookup of 0x100000000 returns NULL, while
> the mapping is at page 0x100000. With the page number the lookup finds
> the mapping and slth-{gfx,comp}-kq-vgpr-proof, slth-gfx-umq-vgpr-proof
> and slth-comp-kq-returnproof pass.
> 
> Look the mapping up by page number.
> 
> CC:Alexander.Deucher@amd.com
> CC:Christian Koenig <christian.koenig@amd.com>
> CC:Lijo Lazar <lijo.lazar@amd.com>
> CC:Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> Fixes: 1a6f95d4a5d7 ("drm/amdgpu: Add second-level trap handler infrastructure")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 3660f94a0929..52e4d30e63fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -622,17 +622,14 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>  	if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
>  		return -EINVAL;
>  
> -	/*
> -	 * amdgpu_vm_bo_lookup_mapping() expects a GPU VA,
> -	 * not a page-shifted address.
> -	 */
> -	va_map = amdgpu_vm_bo_lookup_mapping(vm, start);
> -	if (!va_map)
> -		return -EINVAL;
> -
>  	addr = start >> AMDGPU_GPU_PAGE_SHIFT;
>  	last = end >> AMDGPU_GPU_PAGE_SHIFT;
>  
> +	/* The VM mappings are indexed by GPU page number */
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
> +	if (!va_map)
> +		return -EINVAL;
> +
>  	if (addr < va_map->start || last > va_map->last)

Only a nit but the addr < va_map->start check here doesn't make sense, only the last > va_map->last does.

With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  		return -EINVAL;
>  

