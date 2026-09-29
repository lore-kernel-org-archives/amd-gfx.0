Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70034CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 11:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF91910E122;
	Tue, 29 Sep 2026 11:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvCFM8gn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E112B10E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 11:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE2SGDRl50bIi1khMz7m2CiXIuv1jCUDY6Fh9fTGmYSBkdm/Qkg1/n10/tzaAU1DJHc4t5IcWUyIhSm3kzXJhIv+EdQXz+yPBWmn1v1EJy2y68gosYu8sYUP5WrNafuUF2EyaRHVjxNcbP0WI1rFa2K5w2Ba8dtZS9sdqQEnEFz8Trg23q75ePh9+jqkNdPHnMLs2fhx4mfR7xncUrK6Ng4ppnOU2MTG/e/TxDe4Di8Bog41IcKB78Ve3wmnjpTzsqqtEv08I3eaOWnefmKWnfkxddc/xgHYkyw6BvnvxUftrnlHM70MshPoS3p5feljpvrcUoAdIQJqp8OAYndQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO8t+h2QAApgHMexCHoHyDi3tQ+Uy7vY6j/bKfvLVHQ=;
 b=FeAUcjFUCroCcBO3TDD/5R7EY0csp7NVOwVR4gjNB9egmPF3zXHrQ4xEDQrDqV7Sk6xtV/yQhc7MCBhT+3mffdu5AWv6gGwOdfT0R/KxxbaB8dAhKmhqBL3SrNoMXz/w5S2AbRc9x7ztINeGZaJrPYFObQe451tO6zNnKTXjyMsbVmtzSau4vYPGbo/Ezcq2E8f3iA2yssibJJERAYD1CL4wMkuAZo+IypoSoTMua94ln6cjQcRsgFxWY6IigZX92b2IanXZTFrDt+tO1s9F+LJAGpK7m7vA/KIGV+GR2/xTU3VTUr8l3zyVqsDHL5x1l6ujwG82p2nNGq0gyo4yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO8t+h2QAApgHMexCHoHyDi3tQ+Uy7vY6j/bKfvLVHQ=;
 b=xvCFM8gnv9ve6wp+Ex4NfR8UY+pdxFUnSBUH1S3RgCtLXdJAeuisceFMoQ5iFnqAVMHieQXpX68wpA0E6yEMdkvFrR60ER1B/U+IT6giw6kuO46oFUJdkU0cgU70ZeP1qhkKDqM9kEWh6YRAZX86CfhJ84Cf1vcnFyYR6++L/4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 11:54:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 11:54:09 +0000
Message-ID: <761b532e-8b5e-4929-9526-5d7a55213a88@amd.com>
Date: Tue, 29 Sep 2026 13:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] drm/amdgpu: add spm_vmid and exclude it from the
 MES and KFD pools
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928185756.2382322-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHBPR12MB790180:EE_
X-MS-Office365-Filtering-Correlation-Id: cc26fe7b-342c-47ff-0d9b-08df1e205f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dmpK7wDgyGu2olqJQquTon5TFfb/AtCdxUjRzgjuNgCKS97ZnR/3J6AsntvUcFRvmpkMwLtfHrd6yE+uZi5tmDhv+bbYOiQnAClbUPNRfR4jnH/stEFlQZpP2lu4/dZh09bnX3d0pCC/AI5fKoNOLDScrk5YpAnuwXFLbSALmdMB7W+G0tjvA6gemrOIiA9bZGPQf3B65s/PSvAVAebHgjPREc3cmXq87V+xeQd3jN/5yWDp7hQSGe7gdc3Hb9sudQW8ktbD8BG7U+NNsc6E18t9iXmWHAAaDjOC6ZIFUCgAcSe8qE621AVcxpr5bBzZUmDNBoAD11u3NpsrSgIQ7xPYz9IdvCDJyejxA/ShAxYGrJRqjJg+o+7ef/KuuoojJymz1AHQmbwWzEVMn11lMCxA8Prj0y2w/MI5Xly8Ca08yamKHtNc/X5rA5nRtgKAYG8gjEDqUUd2GWpL06drc8zPvFc2dK2Ad3ulq5tAi27hTGYNntBbiszxLqHxDC5V3UdcdvQ3YrQQdfK/sWgrFr13tm83WTD+/bh96tuFuOt5PEwjP7+Zn7O9GGKR2FBeaozKyX+ZxfY3x1zOzZiNpCGem1sVxc7mLylkDb9RCLix8rij9vva+wnnkzPIcrQ3r+Rty2P6p17UYOedxIa0ndZGZgtEaDUYGSwap5mZfFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklQb25YYmZON0tDa3A0bXMxUmd5aE1ON1FvREFaOWNBUXhjWlNZbnI4dFBM?=
 =?utf-8?B?ODJicytpdFY3S3Y0VlFKaGFBVi9RNmpQMDB3SnBmRW1jRzM0b2V5dlU0dnB6?=
 =?utf-8?B?RVJWMWVsaGU1bDNWSGFuS0V5UTBOSW55K21ieUJpTURDV0pYYVRmV3NCOWJZ?=
 =?utf-8?B?VVJGSDN4QmtsaktQSFoxZnlTYSt2b2ViOHRZY2k2OEdJYVcwWXpHZmJFclMw?=
 =?utf-8?B?MUtXN05pczN0cnpPWW5BYmRHbjdqcHJsSUNLaEliODdyYm0xVDE1Y2JSVml5?=
 =?utf-8?B?MmdUTEgvZFBJbXJnb0I1VDZnS0pmMGtvZ1FjcUxWM2lrZ1hRMExCbHhhQ2Yw?=
 =?utf-8?B?KzB2T3ppdis4a0NrV0FWbmZEYlVWN2laZ2gyR1dWNG52QzR2QlpVOFZud3I2?=
 =?utf-8?B?ZWY1UVdhUmxaSGxxVkwrU3RqOHBPWU9LakVxRkUyL0YrU2tYQVlmRUhFUTFU?=
 =?utf-8?B?OXVxeDE4NmpCcVRWT3krT04yNHlGOWNRb09YVVltQzJidmI4TkZLSUpoTmZI?=
 =?utf-8?B?cVFJbENzK0tteXVxQzQ0T25kZitLczA1ZmJReXZGL2NJMGNTMU5jUTNZNzNB?=
 =?utf-8?B?WDlrc3U1QXhueGhkOUE3UHFzckNiY2dkUFZxKyswN3UzaUhIVk4yVnBaOFda?=
 =?utf-8?B?U2drVkt2LzZScmplOUtzdngvU1RKVHpkZy9Sd2UzSFh3bVY0dlJTdGtvWGhz?=
 =?utf-8?B?TGpjcERhc3JzRW1rZitpeE1Jc3ZFdkFoS3pXcHc5dlExQUVjRkVLRS9lWHph?=
 =?utf-8?B?WmUrYmUwQ1lZd1ZGSkNZVTNMcEYvWW9PbHpha0ZLeTh6c1lBbzhYZkpwNW45?=
 =?utf-8?B?UzZlaFNHc01BQUcvWXNOQUlSdElHYXV5NVJoaXNGMFB3VlJzM3UyV3cwNTB5?=
 =?utf-8?B?QTJtcVNEUU5sTitEMEtVNUVCL29uZ3NKNHl5MWVpdE15YU1SdmMvVXkyRUpi?=
 =?utf-8?B?d1F5SDh0bmovODFIRTRWZ3pMK2RRSU43SFltSUhUTEI5dXQ4M2dIL1FaSi9m?=
 =?utf-8?B?Z1VubmdrMGFDOHF6Q2Q4aHZEYnBvVUpKSW5nMFpra0w1NEJlN1JxbDhrRFFF?=
 =?utf-8?B?WnF5bTJSNkRpcWdYTHRYL3Z2QUdDUUZvaHlxUlhPOVg4S3M5MHV5V2VIbEph?=
 =?utf-8?B?a0xJS0JJMkJoYUR5OHhjSU84TVUxelBCQUtCaEFDQ214dG9ONEdrOGRMWnlL?=
 =?utf-8?B?L3diM3RWT2tlc1IxSS9wWWI0amxYY0F5VHNKM3I3L0dJQWVRaCtYYUdtZ28w?=
 =?utf-8?B?VCt6aHhsdDVYVmRRVHpoRlBET1JmUUg3YnRxNHNXS3JkYWhDN25BejgyUkE5?=
 =?utf-8?B?aVR1aE5Cc0JyVkRYdDY0UkkyeVdEckw1QThFZ1FmUWxLMk1EZ2dmWk9CSW5O?=
 =?utf-8?B?WXdLbXdmU2lScHlhMkZCSit6WnF3b0hTWlBpN2RURU5kVWhBcXp5R3ZqZDVa?=
 =?utf-8?B?YjRIb3NKalcva1ZuZXMyeHFGWW1Geldqc05qZ2svZTR2OEtsbWE4WFJldUpy?=
 =?utf-8?B?ZXFKTGNkSTlrUlg3MHBLR0pMSTN6a0dhOW1ocXlrWGhKeDJiUjV3Z0NLdk03?=
 =?utf-8?B?aEI3YUZYVGZkbTJnOU56ZGVKcDQxeTBaMk0wNkkzeHJWdHRSWE9BekhDNm9T?=
 =?utf-8?B?L0lWajFJYWozOUJTZWkxK21GN2xkT0IzVHdQem9qVVlJdVFPdThtVVFhblpV?=
 =?utf-8?B?djJsVUNoTnRLRWlzckpqZ1RxYTRDN21wSzMvYUYvd09sbG5hNm5sVUZWSXlz?=
 =?utf-8?B?cjlZV0wxSURwbmVNQ2l2QU9na3JCb3BiaGl3RCttK3V2YVJmandvODlhbnBJ?=
 =?utf-8?B?cnE0cjZwVlQ1Z0hVcDloQ0UwaU1wenZBZzZmWlRzbGFySmZDU2J4RGEwSFVX?=
 =?utf-8?B?NmFkU1lES0RYcm8yYTY0QkJab3hYV3M4bzEwNmVTOVB3TUN6K255aUNkeUdJ?=
 =?utf-8?B?UisvUk9FMUR0VG1mMjJpZmVHbkp4QTV1cmpQVnZjVFFORjd2S09PTlp2S3Z5?=
 =?utf-8?B?Z2hMUmR6U2hTYzJqdWoyeEl6WERSeEtvWE1oUmVldG5ablZlbXBCOGFJQ0h1?=
 =?utf-8?B?MjJ6TUJySWJHTWlkODNPOTFOeUw5TFZqMml3czRUZnNLaC9lL1NKeG5ZdC9w?=
 =?utf-8?B?NGdYWE1zbmd2UTdHREtTSStFSStISmRnU3RuM0xmUmtLN21sMTcxbkI4YVNU?=
 =?utf-8?B?SkVFSGlFQS9XdlpVVWdCaE4wcWVpWHl6Yk5JakdKaDZ6enZSeElpOGY4elNj?=
 =?utf-8?B?b1FMTnVpVU5EYW5uUkhwTzJBeFJkTmtsN3ZkTEo3VWt2V1AzUFJWemNra0Fr?=
 =?utf-8?Q?/BI+uYvohH8ipcligJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc26fe7b-342c-47ff-0d9b-08df1e205f0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:54:09.3733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppa7JrWzchrIV6eSa6Bz+8Z7hi+LZJNpVRANufcbaNh/+jdhaHoBBZ5QXKEH7Dvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
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

On 9/28/26 20:57, Sunil Khatri wrote:
> The SPM (Streaming Performance Monitor) path needs a VMID that is
> isolated from other GPU contexts. Introduce vm_manager.spm_vmid to let a
> GFXHUB dedicate a VMID to SPM.
> 
> When spm_vmid is set, remove that VMID from the MES user-queue mask and
> from the KFD compute pool so that neither MES firmware nor KFD ever maps
> another context onto it. KFD derives its VMID range from the shared
> compute_vmid_bitmap via ffs()/fls(), so clearing the bit there is
> sufficient and needs no change inside the KFD subsystem.
> 
> The field defaults to 0 (unused), so this is a no-op until a generation
> opts in by setting spm_vmid.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 ++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index afcfb92fb9f5f..71e47bdf11393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -207,6 +207,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
>  			clear_bit(i, gpu_resources.cp_queue_bitmap);
>  
> +		if (adev->vm_manager.spm_vmid)
> +			gpu_resources.compute_vmid_bitmap &=
> +				~BIT(adev->vm_manager.spm_vmid);
> +

That is quite a mess.

>  		amdgpu_doorbell_get_kfd_info(adev,
>  				&gpu_resources.doorbell_physical_address,
>  				&gpu_resources.doorbell_aperture_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 22ecb70fec2cd..afb56a2f9672b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -134,6 +134,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	adev->mes.vmid_mask_mmhub = 0xFF00;
>  	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>  
> +	if (adev->vm_manager.spm_vmid)
> +		adev->mes.vmid_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);

Please remove the vmid_mask_gfxhub field from the MES structure if possible and move all of that into adev->vm_manager or adev->vm_manager.id_mgr instead.

Regards,
Christian.

> +
>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>  		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 0f6634b749746..57070da337750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -414,6 +414,8 @@ struct amdgpu_vm_manager {
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  	unsigned int				npa_vmid;
> +	/* VMID reserved for SPM, 0 if unused */
> +	unsigned int				spm_vmid;
>  };
>  
>  struct amdgpu_bo_va_mapping;

