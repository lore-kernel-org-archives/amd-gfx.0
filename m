Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4591BC44500
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 12:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCDA10E5D7;
	Fri,  3 Jul 2026 12:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QrWT7uN6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDAD10E5D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 12:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3Zb0MlTUEmR+IODHasyR0ve4FFLCTqDIb57MvQt0O9jtE1e2n9uZLFih71cLhb3JSD+u1ZxA7AqowCfxAXRIzyCWzHTc40sw6khKh6TbLay0BHMiT0VTG4Dmb1rwvkBaJ8iKjBQpQUq2CshWpGfNLsn2LBjUxB7dOYFQr2tH8bfVQGQi9wfxi0iXoBOGiYkwHhr1eNCHhgyVqQb7OmrK0/3Ceweh15A/gIahntxD3JucxHq2nB/V1CiMHcyG6bwaErkSmNFlN3kIHPH+rjzTWy+9+r0Dmise74jtk/IJhvBdHE3RAhNrr5pPJnGQbRTsNxzAUb72wm5NxeV3xq2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCbRWA8dFjdw+OPBeNeXBgcMnbNqf4Tk3mcFAjEkKu8=;
 b=r9gdRGpiR2LotlubgzXnvIDUm5B6+Of2gHUoERWsmO0bzkJr+OwLh8HpovRcBIFaVYC4gkHSS/+LCyD4KnWS84fOp0Lm+TmFu61uz2IJ9SQCjkaHxjgSsBRR1hvzueaI92PL6LHg1QEcB2Ue/GDC3kqypmF/wW1v1QNhXaQwQG8rADG+6yPYGIRevyXEcvBzv8nGdBQ5PV3gNjc6P67jUwIcoxCCz/W3CL46pqSKRPZ/gk04w0oZfsEJQjsQ68bCc+SDKQCLs4kex4RdRUJYfKT9TZ+wwax8wrF4Lc1sAvCDKTtYAEtRvWVtQ3SM+OVQgZTiozRZcVp8oL/5kVR3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCbRWA8dFjdw+OPBeNeXBgcMnbNqf4Tk3mcFAjEkKu8=;
 b=QrWT7uN621uMHp35r2xaAtOOV0bt841kTHMf9ULbZbvrkawNqVGMpyRTFjRuWPjpwGj0ezj0eB8r0qsi59fSnpMmj+byis8Dr8MyVzXN1ZDFiRZmw4EU9ZXTAgG0EspG2rv0xm/Ve845XAma9HLfhHLd+hSUYrV7cerB8kT4PaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 12:33:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:33:11 +0000
Message-ID: <f327d604-e7c2-4958-9a85-d6fa10cfb0c3@amd.com>
Date: Fri, 3 Jul 2026 14:33:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes12: Remove MES self test
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260703095645.3173463-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260703095645.3173463-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:408:d4::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccaa71a-1461-4b6a-a4c9-08ded8ff3eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BRUiCIBOZTOhrwPSwxTGNkEA3eB+E5jH69zefvNH8hJYCMtGgl/Jnh6Fv0jlDhDMbRkiHg+iqEh1NLvGG4B8BYckQfKLnLpBCHtcAHbk3tSXl01anwQTOGADGPN6zlho/U2p+FpO2R3vJzXkYSvGL3wIoNspYgcPZSt29FAYZpG70o1sGfCaXG3omEFG36/QyT9RsVmnfAhvPuYT5RNnzM2EGIDcW9Wmk7wjT/CWIVu7JsTQmimksGVdEn8IuXaEcmKQovy8ibVMmhyvs6IuG3unJ2kkLXwuOSWv9yWPzbrjHDq4WYZTzLpJhYF/dUXuD8wVkZE2Ket5+Q0KE8dbgq1Ii6P8uAnrRKG/LKJhdSPLgYn5hjwdS8Ra4M9cAYcX5LXC0Jc1iaMgBOPHbvoYfwAEnjV7pPc7cqoi4NpSGYtO1Fm8o5GOGtD10F56CmASByz0bwSYtA4DNhwOJj0gBAeBs/4VgwcMl/LCiTX68j0wyWvf5OOvAKJMZxjXb2SraQmf8FP8nmUZVmmkSOH8dS7/VsqfebXpD0toEm0QLm8RFwLhAaOvYuYHhTPLDuFo+ZsdCInVvP23b/GCe3TnTreLlaOEjbKTyNQq3KbasTJdMmlcsNPLYDhT3BXyJc2DHXCokLKSTGNvry2RtRcygFdT3uYYNPoLe9/dUTwLdkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdtL2lJYlRMbk9Sd1BObjU3VWZZbEFvRC92M2RmVmxwdUpuRjdBTmFuSDFl?=
 =?utf-8?B?OTZhRmN2SXZ2RkJ1Q1RXOXZKMzhrekxYRCsxeEtaZWpWS2dlT2dHQi9IcFJS?=
 =?utf-8?B?L1kzV3NteFNLVlYvdGg0Y1Z3dElwZEZTSWIxTmorNU9MNDR1ZWRwTXdOb0pj?=
 =?utf-8?B?T09lNHMwUHZJejVEbGRaL0R1Q2RYblNoKzFEL1JSZkE4L2dVR0twd1dyY2Nr?=
 =?utf-8?B?QlZBK3RWd1ZZVXdVaWxjeHgveXZ2eGhLTE4vbEZWT3pOTXFEV0llcXpIOFBq?=
 =?utf-8?B?bk9nTmI5NTB2bzl2anplTzB4ckJRZEdiWUdFSlVqcVBvZWdJeXUvdmM3SUhN?=
 =?utf-8?B?WGppTzdKaTNvUUR6anVnMlpldVEyTTJzZFRLTEw3SHhxczJxejBGNWFTdk1y?=
 =?utf-8?B?VGhMU0dEMDdHdWIxTldKZEdIU3R5emZ6aVFGUjRJSG1TMDBzTS84ZzV3Z2lt?=
 =?utf-8?B?NEppVmRhVUVuSlRYVEFPbmUwNFpOMXBpbE5ETndRK3NSV1B0QXYrWHYwQ0tJ?=
 =?utf-8?B?aVY5VHFyb1ZjZTZpbjBlM0NndTdmaWJmV05iSXRiRHFaeTcrNXVRdUlOY2s4?=
 =?utf-8?B?N1hDMkNNWFNhMlpoY0VtMTA1N295dWRoczhBUTIzSGI1akkvdW1GdzVHWG80?=
 =?utf-8?B?M21ORWxWM1pnU2FBZkk4YytIZSthaEpwdk4xaUpWRGVFeHJTNHpHbmxXZ0pU?=
 =?utf-8?B?NkNkeUxnN1dwRXdzMlBRUmhmM0I4M05mMEE4SWVTUG0zeHlGTGtqSWdWTG9w?=
 =?utf-8?B?MVdsdmxMREl3dWZOYmE5MGxFWjdjTzFpV2VUM1B4QjliQVJZUStWWTNxUWFH?=
 =?utf-8?B?SkdQaU1hQ0h5MG9QbzZmRTFFUVZsZ0xjRkltalBjOTI0dlF4a2ZIRHN0SnBB?=
 =?utf-8?B?UzR6cmhWMmhLSk9JN1NmZTQ0UzJNd0t1TFRuS2NHcjIvcEtUMVNHamxadTh4?=
 =?utf-8?B?dU41a2R0bTBTcUZJTU9JeVBEdkRSSDRTa3cxNlFUdHU5QnRBNm9zZlV3WUVm?=
 =?utf-8?B?R0p3K0ZSVWJsQmlyemd0OTVoMFQzMXVKdTBLdGFxMEx1UlQ2Rk0vTVYzcHNv?=
 =?utf-8?B?bk05VkdZcFRWZWsraTRVYm1HY1M2NjQ4UWltY214REdqRUN5NnJRQ0FnaFFG?=
 =?utf-8?B?L0F6bUYvK3BTdDU2K0JvczFLYzF4clA1NzBOYW9CMVVreUtZamxZck94T3dZ?=
 =?utf-8?B?dVR0d1dWZGZDZk90ZDFNenQ5YitzakJ2VlhiRWRhYndMZGp4Vk9ma3dTZ043?=
 =?utf-8?B?SE4ycGtQU2w2N0lNWGEySHJyeG8zWkVHMjl4bDFSZ1lxWEpNUE10NDQ5WU5p?=
 =?utf-8?B?OHNDRDBBNCtwdFZtRVVaZEJDWlRTSTVFaE1SWUJ3RjVZbk5STUxqVXZvaGZH?=
 =?utf-8?B?M2pUenRmZWhqM1paZ1UycExGQ3JCQ3pCSVVwTTJ2WUNCczhQS1FIV0dEZXJi?=
 =?utf-8?B?UkZDNU0vSkdkWHk0N1BoK3BWQXNaY09ZSTJPQy9ZUm43WERUbnUyeHBKR21h?=
 =?utf-8?B?ZUF2ZTVPKzFzMHpoRjZqbGw0R3Y5eTZUVVVaU0l2WXRlOUJzaDNNa2RqdXcx?=
 =?utf-8?B?TVUxemd1d1pVVkNFUUdCd2dEbS9sZU1ydzJDWlRFWWsySHFnL0xvRmZrMWp0?=
 =?utf-8?B?V3JZZ2NWeTk4VWtjSS8rblFrNFNZWlJNQ2ZlQ25EWmNIeW9ZM0U3UHBZbXhV?=
 =?utf-8?B?SFl1YVpWalNNU3pDVEdUUzVZOHBlajF2OXJhQ3RhRWs0VEUvSE1UZm5TTDRM?=
 =?utf-8?B?NDcyNDJFK3huaTMySi85QThsTFNycTRjWklHcHlEcnJIN1ZrM01iLzAvTm1J?=
 =?utf-8?B?dTNacVIrN3NLaHlEaTVKbGxPcTQrQUdRejZVYzVPN3I4cWdia3NPSmRlWHFU?=
 =?utf-8?B?L3ljNnVrbzQ1S0Y2VzM3REhtcHg1cHFPcUR6SzBGS3JvRk9XVCtEK215dUlw?=
 =?utf-8?B?am5sWmR3eHhDOXNLUFZlZ2pDSmgyVDMvcXE3a3g5S0M0am5MRkg3VFF1WlVH?=
 =?utf-8?B?bjBnUXIrdEpNVXArUjhYam94RDVKeWsrbGI0ZEt3TFdIZkp1L21NSkFiMWpS?=
 =?utf-8?B?dlpFN2U4ZjdXZEdLa1ZSSjd2ZWRCRDlZUHZLMWx5MzMyeVFCWGhtMXJjOG9k?=
 =?utf-8?B?Rk9saW9OQ2JVQy9RRUVOVHQ3amlzaXc1aHgyVTlKTVBDRWZ5UzE0Z0tScXEz?=
 =?utf-8?B?Wmlkejg4NDBzOUtUSlZDa0tIV05WNUR0N1N6WWRPRTRLM0NqTEVJQkcrSFN3?=
 =?utf-8?B?YWplUE9uOUo1RGY2RUt6TkhkcHh1V0VBQVpEUFpMM0JoMTVKQ21SUzEwSlJE?=
 =?utf-8?Q?4GyrYsPXHD6roZ1QCc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccaa71a-1461-4b6a-a4c9-08ded8ff3eb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:33:11.5840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8eE77e5RC/39OcRIgx5c+GCqLiDd3td+0Cl1RqmG8hKs5KzRLf6j6qC7JDIfOPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
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

On 7/3/26 11:56, Srinivasan Shanmugam wrote:
> The MES self test is no longer needed. Other MES versions already
> dropped their self tests since IGT now covers this functionality.
> 
> Remove the MES v12 self test as well.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 334 +------------------------
>  1 file changed, 1 insertion(+), 333 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 65b824144a2f..e7d7160f8fc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -43,7 +43,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id);
>  static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
>  static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
>  static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
> -static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
>  static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
>  
>  #define MES_EOP_SIZE   2048
> @@ -1994,31 +1993,10 @@ static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int mes_v12_1_late_init(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> -
> -	/* TODO: remove it if issue fixed. */
> -	if (adev->mes.enable_coop_mode)
> -		return 0;
> -
> -	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> -		/* for COOP mode, only test master xcc. */
> -		if (adev->mes.enable_coop_mode &&
> -		    adev->mes.master_xcc_ids[xcc_id] != xcc_id)
> -			continue;
> -
> -		mes_v12_1_self_test(adev, xcc_id);
> -	}
> -
> -	return 0;
> -}
> -
>  static const struct amd_ip_funcs mes_v12_1_ip_funcs = {
>  	.name = "mes_v12_1",
>  	.early_init = mes_v12_1_early_init,
> -	.late_init = mes_v12_1_late_init,
> +	.late_init = NULL,
>  	.sw_init = mes_v12_1_sw_init,
>  	.sw_fini = mes_v12_1_sw_fini,
>  	.hw_init = mes_v12_1_hw_init,
> @@ -2034,313 +2012,3 @@ const struct amdgpu_ip_block_version mes_v12_1_ip_block = {
>  	.rev = 0,
>  	.funcs = &mes_v12_1_ip_funcs,
>  };
> -
> -static int mes_v12_1_alloc_test_buf(struct amdgpu_device *adev,
> -				    struct amdgpu_bo **bo, uint64_t *addr,
> -				    void **ptr, int size)
> -{
> -	amdgpu_bo_create_kernel(adev, size, PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> -				bo, addr, ptr);
> -	if (!*bo) {
> -		dev_err(adev->dev, "failed to allocate test buffer bo\n");
> -		return -ENOMEM;
> -	}
> -	memset(*ptr, 0, size);
> -	return 0;
> -}
> -
> -static int mes_v12_1_map_test_bo(struct amdgpu_device *adev,
> -				 struct amdgpu_bo *bo, struct amdgpu_vm *vm,
> -				 struct amdgpu_bo_va **bo_va, u64 va, int size)
> -{
> -	struct amdgpu_sync sync;
> -	int r;
> -
> -	r = amdgpu_map_static_csa(adev, vm, bo, bo_va, va, size);
> -	if (r)
> -		return r;
> -
> -	amdgpu_sync_create(&sync);
> -
> -	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> -	if (r) {
> -		dev_err(adev->dev, "failed to do vm_bo_update on meta data\n");
> -		goto error;
> -	}
> -	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update, GFP_KERNEL);
> -
> -	r = amdgpu_vm_update_pdes(adev, vm, false);
> -	if (r) {
> -		dev_err(adev->dev, "failed to update pdes on meta data\n");
> -		goto error;
> -	}
> -	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
> -	amdgpu_sync_wait(&sync, false);
> -
> -error:
> -	amdgpu_sync_free(&sync);
> -	return r;
> -}
> -
> -static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
> -			       u32 *queue_ptr, u64 fence_gpu_addr,
> -			       void *fence_cpu_ptr, void *wptr_cpu_addr,
> -			       u64 doorbell_idx, int queue_type)
> -{
> -	volatile uint32_t *cpu_ptr = fence_cpu_ptr;
> -	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> -	int sdma_ring_align = 0x10, compute_ring_align = 0x100;
> -	uint32_t tmp, xcc_offset;
> -	int r = 0, i, j, wptr = 0;
> -
> -	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
> -		if (!adev->mes.enable_coop_mode) {
> -			WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> -				     regSCRATCH_REG0, 0xCAFEDEAD);
> -		} else {
> -			for (i = 0; i < num_xcc; i++) {
> -				if (adev->mes.master_xcc_ids[i] == xcc_id)
> -					WREG32_SOC15(GC, GET_INST(GC, i),
> -					       regSCRATCH_REG0, 0xCAFEDEAD);
> -			}
> -		}
> -
> -		xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
> -		queue_ptr[wptr++] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> -		queue_ptr[wptr++] = xcc_offset - PACKET3_SET_UCONFIG_REG_START;
> -		queue_ptr[wptr++] = 0xDEADBEEF;
> -
> -		for (i = wptr; i < compute_ring_align; i++)
> -			queue_ptr[wptr++] = PACKET3(PACKET3_NOP, 0x3FFF);
> -
> -	}  else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
> -		*cpu_ptr = 0xCAFEDEAD;
> -
> -		queue_ptr[wptr++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> -			SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -		queue_ptr[wptr++] = lower_32_bits(fence_gpu_addr);
> -		queue_ptr[wptr++] = upper_32_bits(fence_gpu_addr);
> -		queue_ptr[wptr++] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -		queue_ptr[wptr++] = 0xDEADBEEF;
> -
> -		for (i = wptr; i < sdma_ring_align; i++)
> -			queue_ptr[wptr++] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -
> -		wptr <<= 2;
> -	}
> -
> -	atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
> -	WDOORBELL64(doorbell_idx, wptr);
> -
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (queue_type == AMDGPU_RING_TYPE_SDMA) {
> -			tmp = le32_to_cpu(*cpu_ptr);
> -		} else {
> -			if (!adev->mes.enable_coop_mode) {
> -				tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> -						   regSCRATCH_REG0);
> -			} else {
> -				for (j = 0; j < num_xcc; j++) {
> -					if (xcc_id != adev->mes.master_xcc_ids[j])
> -						continue;
> -
> -					tmp = RREG32_SOC15(GC, GET_INST(GC, j),
> -							   regSCRATCH_REG0);
> -					if (tmp != 0xDEADBEEF)
> -						break;
> -				}
> -			}
> -		}
> -
> -		if (tmp == 0xDEADBEEF)
> -			break;
> -
> -		if (amdgpu_emu_mode == 1)
> -			msleep(1);
> -		else
> -			udelay(1);
> -	}
> -
> -	if (i >= adev->usec_timeout) {
> -		dev_err(adev->dev, "xcc%d: mes self test (%s) failed\n", xcc_id,
> -		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
> -
> -		while (halt_if_hws_hang)
> -			schedule();
> -
> -		r = -ETIMEDOUT;
> -	} else {
> -		dev_info(adev->dev, "xcc%d: mes self test (%s) pass\n", xcc_id,
> -		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
> -	}
> -
> -	return r;
> -}
> -
> -#define USER_CTX_SIZE (PAGE_SIZE * 2)
> -#define USER_CTX_VA AMDGPU_VA_RESERVED_BOTTOM
> -#define RING_OFFSET(addr) ((addr))
> -#define EOP_OFFSET(addr)  ((addr) + PAGE_SIZE)
> -#define WPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64))
> -#define RPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 2)
> -#define FENCE_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 3)
> -
> -static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
> -		     int pasid, struct amdgpu_vm *vm, u64 meta_gpu_addr,
> -		     u64 queue_gpu_addr, void *ctx_ptr, int queue_type)
> -{
> -	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	struct amdgpu_mqd *mqd_mgr = &adev->mqds[queue_type];
> -	struct amdgpu_mqd_prop mqd_prop = {0};
> -	struct mes_add_queue_input add_queue = {0};
> -	struct mes_remove_queue_input remove_queue = {0};
> -	struct amdgpu_bo *mqd_bo = NULL;
> -	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> -	int i, r, off, mqd_size, mqd_count = 1;
> -	void *mqd_ptr = NULL;
> -	u64 mqd_gpu_addr, doorbell_idx;
> -
> -	/* extra one page size padding for mes fw */
> -	mqd_size = mqd_mgr->mqd_size + PAGE_SIZE;
> -
> -	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
> -		doorbell_idx = adev->mes.db_start_dw_offset +	\
> -			adev->doorbell_index.sdma_engine[0];
> -	} else {
> -		doorbell_idx = adev->mes.db_start_dw_offset + \
> -			adev->doorbell_index.userqueue_start;
> -	}
> -
> -	if (adev->mes.enable_coop_mode &&
> -	    queue_type == AMDGPU_RING_TYPE_COMPUTE) {
> -		for (i = 0, mqd_count = 0; i < num_xcc; i++) {
> -			if (adev->mes.master_xcc_ids[i] == xcc_id)
> -				mqd_count++;
> -		}
> -		mqd_size *= mqd_count;
> -	}
> -
> -	r = mes_v12_1_alloc_test_buf(adev, &mqd_bo, &mqd_gpu_addr,
> -				     &mqd_ptr, mqd_size * mqd_count);
> -	if (r < 0)
> -		return r;
> -
> -	mqd_prop.mqd_gpu_addr = mqd_gpu_addr;
> -	mqd_prop.hqd_base_gpu_addr = RING_OFFSET(USER_CTX_VA);
> -	mqd_prop.eop_gpu_addr = EOP_OFFSET(USER_CTX_VA);
> -	mqd_prop.wptr_gpu_addr = WPTR_OFFSET(USER_CTX_VA);
> -	mqd_prop.rptr_gpu_addr = RPTR_OFFSET(USER_CTX_VA);
> -	mqd_prop.doorbell_index = doorbell_idx;
> -	mqd_prop.queue_size = PAGE_SIZE;
> -	mqd_prop.mqd_stride_size = mqd_size;
> -	mqd_prop.use_doorbell = true;
> -	mqd_prop.hqd_active = false;
> -
> -	mqd_mgr->init_mqd(adev, mqd_ptr, &mqd_prop);
> -	if (mqd_count > 1) {
> -		for (i = 1; i < mqd_count; i++) {
> -			off = mqd_size * i;
> -			mqd_prop.mqd_gpu_addr = mqd_gpu_addr + off;
> -			mqd_mgr->init_mqd(adev, (char *)mqd_ptr + off,
> -					  &mqd_prop);
> -		}
> -	}
> -
> -	add_queue.xcc_id = xcc_id;
> -	add_queue.process_id = pasid;
> -	add_queue.page_table_base_addr = adev->vm_manager.vram_base_offset +
> -		amdgpu_bo_gpu_offset(vm->root.bo) - adev->gmc.vram_start;
> -	add_queue.process_va_start = 0;
> -	add_queue.process_va_end = adev->vm_manager.max_pfn - 1;
> -	add_queue.process_context_addr = meta_gpu_addr;
> -	add_queue.gang_context_addr = meta_gpu_addr + AMDGPU_MES_PROC_CTX_SIZE;
> -	add_queue.doorbell_offset = doorbell_idx;
> -	add_queue.mqd_addr = mqd_gpu_addr;
> -	add_queue.wptr_addr = mqd_prop.wptr_gpu_addr;
> -	add_queue.wptr_mc_addr = WPTR_OFFSET(queue_gpu_addr);
> -	add_queue.queue_type = queue_type;
> -	add_queue.vm_cntx_cntl = hub->vm_cntx_cntl;
> -
> -	r = mes_v12_1_add_hw_queue(&adev->mes, &add_queue);
> -	if (r)
> -		goto error;
> -
> -	mes_v12_1_test_ring(adev, xcc_id, (u32 *)RING_OFFSET((char *)ctx_ptr),
> -			    FENCE_OFFSET(USER_CTX_VA),
> -			    FENCE_OFFSET((char *)ctx_ptr),
> -			    WPTR_OFFSET((char *)ctx_ptr),
> -			    doorbell_idx, queue_type);
> -
> -	remove_queue.xcc_id = xcc_id;
> -	remove_queue.doorbell_offset = doorbell_idx;
> -	remove_queue.gang_context_addr = add_queue.gang_context_addr;
> -	remove_queue.queue_type = queue_type;
> -	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
> -
> -error:
> -	amdgpu_bo_free_kernel(&mqd_bo, &mqd_gpu_addr, &mqd_ptr);
> -	return r;
> -}
> -
> -static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
> -{
> -	int queue_types[] = { AMDGPU_RING_TYPE_COMPUTE,
> -		              /* AMDGPU_RING_TYPE_SDMA */ };
> -	struct amdgpu_bo_va *bo_va = NULL;
> -	struct amdgpu_vm *vm = NULL;
> -	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
> -	void *meta_ptr = NULL, *ctx_ptr = NULL;
> -	u64 meta_gpu_addr, ctx_gpu_addr;
> -	int size, i, r, pasid;
> -
> -	pasid = amdgpu_pasid_alloc(16, NULL);
> -	if (pasid < 0)
> -		pasid = 0;
> -
> -	size = AMDGPU_MES_PROC_CTX_SIZE + AMDGPU_MES_GANG_CTX_SIZE;
> -	r = mes_v12_1_alloc_test_buf(adev, &meta_bo, &meta_gpu_addr,
> -				     &meta_ptr, size);
> -	if (r < 0)
> -		goto err2;
> -
> -	r = mes_v12_1_alloc_test_buf(adev, &ctx_bo, &ctx_gpu_addr,
> -				     &ctx_ptr, USER_CTX_SIZE);
> -	if (r < 0)
> -		goto err2;
> -
> -	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
> -	if (!vm) {
> -		r = -ENOMEM;
> -		goto err2;
> -	}
> -
> -	r = amdgpu_vm_init(adev, vm, -1, pasid);
> -	if (r)
> -		goto err1;
> -
> -	r = mes_v12_1_map_test_bo(adev, ctx_bo, vm, &bo_va,
> -				  USER_CTX_VA, USER_CTX_SIZE);
> -	if (r)
> -		goto err0;
> -
> -	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
> -		memset(ctx_ptr, 0, USER_CTX_SIZE);
> -
> -		r = mes_v12_1_test_queue(adev, xcc_id, pasid, vm, meta_gpu_addr,
> -					 ctx_gpu_addr, ctx_ptr, queue_types[i]);
> -		if (r)
> -			break;
> -	}
> -
> -	amdgpu_unmap_static_csa(adev, vm, ctx_bo, bo_va, USER_CTX_VA);
> -err0:
> -	amdgpu_vm_fini(adev, vm);
> -err1:
> -	kfree(vm);
> -err2:
> -	amdgpu_bo_free_kernel(&meta_bo, &meta_gpu_addr, &meta_ptr);
> -	amdgpu_bo_free_kernel(&ctx_bo, &ctx_gpu_addr, &ctx_ptr);
> -	amdgpu_pasid_free(pasid);
> -	return r;
> -}
> -

