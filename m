Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C70CD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242D110E34C;
	Mon, 18 May 2026 14:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="05MDIxlM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E22310E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce5GHvEyjJBKIDXXmxeBG6yS6St8idz5KQRa++fcaCMNhLjPW6gLTbu4KfuTj9shazqNceUd/OkY6IDeCHr2Pc1ValLP+Y2QtBAeIGj2GFrPot+WlSk2kHkFDC+3A9HbtVA6egsBepSYQItkbw+ZyOQdcvuoABniVNWi9zDAUg4JcrwD/LU8C2hdHd2Y5IiHCObRYFpaJzao8yM+iNRY4zH1Nq3fOokn1sBSlwhVwNrqkiWP8TCf9YnLfHCKPgArg+7ywDzk+t6DR1C7VbB5W3PxkLwt+VDDHFOA9sbE/HYdzeF0xmzHfzB+3kaUta3bkAvhefuOgTJ4NvW91FDiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3BHqR/owtQvrl4EVYR2LNADhzlYqps7VN6umofN5V8=;
 b=ld2oTu3l/1+p8X17T94Qg6fW2IsfHEJi7xpFKufOYCkeLVZ5vNt5B9CuTbG8Y6d0urDOI8V4t/TKl/ywxbkBEzdg7eWzGqR2Dn+FnYrm7/0n9jj8dMS6RNMq3X4ML1Rf4Dtz0r1y+VVxBbB582NE30CdB84qhu9rUZcasw4gXo4FkHw6jLdaE8zIQBgtGsqjfPdNvEC1824dMBwsd+1MIHLmEww0VZdmOYG1IV3Lji85d+KS7BDokqYgUi9fQJ0M1MBqizXWHqUHlrYsf6OjFB2DdftVCSgCnjGEfC5S4SehHBuL13W8iQo/o7xZN5+sql/mzDRKVucuHRli0nMgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3BHqR/owtQvrl4EVYR2LNADhzlYqps7VN6umofN5V8=;
 b=05MDIxlMrMLVUSTBDEJxY/ONl6PcXAxE6h1XuXlaE6kI0bqgfjZ4+gjwbXVDzuvPHqaSmNnzyxdcxtDaAqabUmbR9530LOo2zNnDL2+7CWFcgf8F1xbcRx3Ztnb0qIfmPVAI5uz+BQu5Vumwgwyfqfd569Zk15MhSzmapEF3l38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:55:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:55:04 +0000
Message-ID: <2ca8cd17-58f2-4b03-8fa7-3da869208c0c@amd.com>
Date: Mon, 18 May 2026 16:55:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: userq_va_mapped should remain true once
 done
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260513081418.1727864-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513081418.1727864-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: a855f6b8-4204-4928-3d87-08deb4ed714e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Npo2hI0sQNldSpzeRFDqOJBJ4TtSTwR4TIpUVB82JXgaQ5QxFYxPAEOPQF34dcWG5hcWTkUwns+ogmYvpY++eI2z3TJrKvCENt2V02M0+yYPQ+V7EWpPmUW7SNBnvmx7sEPO54gClKls9qLEDq9kvlVBC48Srgx20uGdwA+3+7Pyi6alXfcLnZYHUhubXb4g1VXKnNR/6BaY6/qRqdVXvGD16SiiGgAOvGrSF/odoBmYjFXwompdbMNJUhZNRer0nAS5gepWdHOTpU2JbrrOOMqUDgp2jPyq6wkxA2ulHJOWPF3e6hoXTynpYSBf52FgnnVXJQW51NO8bR8L0Y2J0HfW4XF55eZqKqXiTMJMAABJXJYE0vY4LqqQwqxBJR/YV7Dj8myTZcFalnFIKPSyoY+B9YdUf9LPpqBS2PQtjwNpMV3B7MM9EXZDXqRn/tudub+Ps3LbxeuAGz0OTB76qQEPMuuRCaRjEA24XekF4MTbASjHhO+5k88PdHMy9TxSFZlIVchh/SsJK3rZMugXHazMnUlWVPr0A/gaxPIsC2LGqfGX/ZLrf5yFBGESkqNAgPhEUUPyh6Sk1wvbXywXYqjsg4zX/QU8NQ+h5dx7dtuwKi/tAllRkZgMk+odH/twZnzWdY09hS7uM5NoRcR4fq2LSsnu72VdE8etFDTLqtzVtEELYHzkSuk+yIydWqSf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZMT1RTekM5ZnQwaVg5b0ErQm9HRytuK3E2UVJSSmo2T05mWDRNLzdLY0Nz?=
 =?utf-8?B?bGJSSWl5Z0dldytlbVJCQUxxUnBobjhCdm5zSVQxWTZaMzBsOU1TUHZKUDRm?=
 =?utf-8?B?cVl0T0tPSDErZDJHRWFZd3hvZFdhNmVWd3pJSHJ4bjZuTTIxSHBNaG9LVVpM?=
 =?utf-8?B?a1FmTDd1b1gzU09vdWM5NXA5Qi9RQkhPVnF5UE9jd2ovV2JMSGs5dFJqeFBo?=
 =?utf-8?B?MG1FSnA3d3RUMldabkJjK2Z6d01oS2s2SUxWWXQyVGRJMUc2R1JMVzJWK1FJ?=
 =?utf-8?B?c3FySXVqZU5WQVFGLzQ2Y0o1YlBTcis1bmp2Wnl3NUo2a2N4aFphVkk1aUF2?=
 =?utf-8?B?ck12MHNXWStoNVR6cGxPRHlSZitXcDFPL05pd2V5RWQwd2tmWngwWWRRVDN1?=
 =?utf-8?B?Vzk5QWdoYWpHdC9NcG9kbFdmVXRHeVA2dVlid0NZcy9pWWFPZEluMEJmNFhj?=
 =?utf-8?B?elYyMkhIc1pHU09WeEZVdjhCTjZNZDlUUS9jTmRRdnJ3QXZ1a3VBbDNja0FJ?=
 =?utf-8?B?QXBTQ2NBWFJOenpLVU9LUTg5a01YYmNQN211U2EreHZWZ3U4NkNRaUhISTcz?=
 =?utf-8?B?dkloODV5UHNrL1YvTUtOOFR2cThqQ3R4REJ0STE3Z1JTdXYvNXFTbkF5U0VU?=
 =?utf-8?B?Z1o3cXV4ZHNYMnJJemR1V2h4MTdsRG5QRHRoUHEyejVwcTFxbVliUUFFanpy?=
 =?utf-8?B?MDl0alFiRnlkOTVQYVRtdTN3YWloL2d0Ym54elQ0dVQ5WjhmQng3UkUxYlpH?=
 =?utf-8?B?eXh6S0tpYUJ0Uy80bFpCaXFlWWtjWmJRdFhsTGJ4d3pvOHQ2T0VyUm55M1Va?=
 =?utf-8?B?d3NrdU1lTjVpK3ZRTXRJYitsVXk1bVhtUG9LUUowWEJobk1UYzZQVmhLdldt?=
 =?utf-8?B?cDBzUHY5QjNkZkg1ak1sM3ArNTlnTlhoNjlIdnAwMUQ2RlNtVHBBc0Y2b3Uw?=
 =?utf-8?B?MU4zRHdYcVdmMXVFek43N2NXclJ1Ry9BQWpLektwS3gzZklCc1VRdVQzMkFK?=
 =?utf-8?B?b0F2ekhjWDFnT3pOS0JOUi9pVWdrVWpsZGVsUGVRMDVlazduU2dMUzFTcHdZ?=
 =?utf-8?B?MTNqb2tiRHlEM09aQkQ2eW1vckhrcGs1dDM2UjhMZFR2OERveVpPZTZrQ0ky?=
 =?utf-8?B?amtxR3dWd0p0ckhQTk5yTzhSd3RZeVhnNkdHSkRKQmRoQVVMSlUxaEJMUW5x?=
 =?utf-8?B?c2JseWd6aDF2S1o0VnVhMU4yejExYm5hdmNyZ1k1TnFOYzVjUUlqNUFqak9T?=
 =?utf-8?B?aTZIaU1aNFBsdTJNZFdFdExyZ0tqcGhtazlQWmRqUVN1SDBrL3RXbCsralBa?=
 =?utf-8?B?WDJOZ3BwMStxajZUeG45NUROeTFkRXNHejlKZ1BxOTZDZWR2ay82RzlBUEdN?=
 =?utf-8?B?RzJGY3FwYkpQTTVUb2VFdE5YSGdER01WSnVReEVyMGRZcFhDazRlWnhzV25p?=
 =?utf-8?B?a3hXUlBaeW93TGViVk9tN3hBNElMREMybCtRRUU3cnAreC9pbGwxK2t3TUNr?=
 =?utf-8?B?aUUveTBDeWVCenFkK2R5M3NUR0NWYXJDRjlIVk15VVVYSEZiRnVDYTYzYUZz?=
 =?utf-8?B?cDgycUEwYWxubzdpTDJjMlJlSTJadGM0R2c3WUdHajB2d0FOUFJnZUNuOU40?=
 =?utf-8?B?OEoxd3k2TW1hZkVzTkxsS25QZTJSaCs5eUtWZktnanN1bHMyc0t4UGhiV1hw?=
 =?utf-8?B?Wm9WRnpDaWtQNGgwanJYOFdhTndMWGFOMFhsN1BtL2U0ZGRWNC9jYkNrSm9D?=
 =?utf-8?B?NkFZNjNScVFxd0VzZ2hncmNOcHRKU1hTaWk3VGpMUU1hbVc5RHFsZFNHQ1Ex?=
 =?utf-8?B?WWREeTM4cG9HcGhJY1Y0WnhHREVkM2oydGpDc0lrVmNNOGJBa09YTThwNE51?=
 =?utf-8?B?U2Q2MUFtSkc4dkQvdGFrU0x5dlNFcnNFS29zWFdHUUFsZjVXakNBOE9kRU9v?=
 =?utf-8?B?MHF0Z0dORjA5Tms1czREZlBtemM3am5KL05YMUFDWWdXbzhQOVJvWjd4NW1B?=
 =?utf-8?B?NktibjE1TUhrYklCVUlyRjc4VmNjeGpkdS9qK2xTT3UzV0JJejhtRU05d2pN?=
 =?utf-8?B?VzNFd2x2U3dTL2FNRVFqcFJuSE9kWUQ1VkxRdFRSb3liOFVtb05taDF2TkNu?=
 =?utf-8?B?ejY3aHhUQUNVd1d3RkxKUFFHaFJ5TGJOUG05NVN2RnpwVm5WMDZiZDk5YTNM?=
 =?utf-8?B?M0RBSGd3L1crOGNoanFKRHlFb1BhdllOTnhGTHdMWjMvVVJJa0Y2eW1JUzRJ?=
 =?utf-8?B?V016YVJ1ZExwL1FRdm01WEJhRXR4TUwyM1JwYWZsU1FaVG5VYzEyNXVuQXJM?=
 =?utf-8?Q?dxXLRIMxj6coHFMjZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a855f6b8-4204-4928-3d87-08deb4ed714e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:55:03.6266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU8ovegfWsmedsLBUIxXS8etHGa/FfU2iv7TdDUxHP1xmKQgGuXWWVPN0s4D3Iuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

On 5/13/26 10:14, Sunil Khatri wrote:
> Multiple queues needs these bo_va objects belonging to
> the same uq_mgr. So once they are mapped lets not unmap
> them as at any point of time any of the queues might be
> using it.
> 
> Also userq_va_mapped should be a boolean than atomic.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one here, but I think we also need some follow up cleanup.

What is the userq_va_cursor actually used for?

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 912c9afaf9e1..4d68732d6223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -96,7 +96,8 @@ struct amdgpu_bo_va {
>  	 * if non-zero, cannot unmap from GPU because user queues may still access it
>  	 */
>  	unsigned int			queue_refcount;
> -	atomic_t			userq_va_mapped;
> +	/* Indicates if this buffer is mapped for any user queue. Once set, never reset. */
> +	bool				userq_va_mapped;
>  };
>  
>  struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 24b172a0d9ac..9225b3795e74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -227,7 +227,7 @@ static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>  
>  	INIT_LIST_HEAD(&va_cursor->list);
>  	va_cursor->gpu_addr = addr;
> -	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
> +	va_map->bo_va->userq_va_mapped = true;
>  	list_add(&va_cursor->list, &queue->userq_va_list);
>  
>  	return 0;
> @@ -274,7 +274,7 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  
>  	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
> -	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
> +	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->userq_va_mapped)
>  		r = true;
>  	else
>  		r = false;
> @@ -303,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
>  					    struct amdgpu_userq_va_cursor *va_cursor)
>  {
> -	if (mapping)
> -		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>  	list_del(&va_cursor->list);
>  	kfree(va_cursor);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82a1c19350ee..47c531ffc065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2002,7 +2002,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	 * during user requests GEM unmap IOCTL except for forcing the unmap
>  	 * from user space.
>  	 */
> -	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0))
> +	if (unlikely(bo_va->userq_va_mapped > 0))
>  		amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
>  
>  	list_del(&mapping->list);

