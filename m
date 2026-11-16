Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932C606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PWIRKvwT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EE310EE1F;
	Mon, 16 Nov 2026 10:09:57 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1828210ED07
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 10:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH0BR7WxN7wAEcu2Uix5NbTE+3RvzSRlhNw0+CivFSnltHSB8/L/zvTK0/Ob+xBO0g63MhtUTs2gdhhvVsyPtC4fsjbk3OPCIn6o4O0A3yrT5zWU/bu46b7YakW9fAsoQD1znLMlyV2idllSo6JXiJYPQC3bWSQ4JfAwmxwnyG6MzhGdkhIM9Ua62+PZzecBIi5+rLbJEEH6IhcRo5nF7mTzvMouqWyqsUQk/Mt/TS3DXzOuiLdZ6P46Bq8SDNoiH57xPB6/EVjWLaQgRbgX5dsCsf9TGW2v5jqU9lCaaPubxbY98TaPE4Xn85zS/JSEWUUwFQ3BGuv4lH0KZ/z0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhggiZ88EfL+husI2fQk58YpmvwQgT9Ztdqz/q9ECIg=;
 b=bd2uHF4XcSK7gRf3WroemtG1dGToQDYl9XNpxvpb9Xdnqb/S7YM+eSgGDHjCdTOQIygII+Qj/f083R+gIi9eq1cRje5DZIQuEejvQi0aV2IpHWFdaeExQul+OwGRPrTEVOu6q+MHOPd11PsU1wkkJv2MLGiNTZyiS0NFRJEoqzPWxxK4PIqqgNyI2A4RdtKcQh69HCsLtIxz5oNRc8H4AqWkEDw5aaNItb4NZ/glIzDZjOUNfYDkGs269Q3phIUGgxP/0Nav8Rf2ANGWIIEqKw+VSp7YheXYBjicddoh3B2b69tPkKD8JEmtVSM8GwojaoCjoZcuJbf7z53HqusIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhggiZ88EfL+husI2fQk58YpmvwQgT9Ztdqz/q9ECIg=;
 b=PWIRKvwTdsuYZx3tEevTCx+RJZCzorxZHkonx+nlvJ2XeFWuwmdf/LqUa42EZE4WN2N01hRWn/eHY6jd1IYZv/mv7Az9A2ecmT49JDG1Q93jrbB1NYSL69QcUBDPgTC3vryHzv4zRjbXjfG4ytWwOZeQZ9TA5zWBti9FwVZAyh4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:09:47 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 10:09:47 +0000
Message-ID: <af096ed6-cf84-4b58-957a-d2100fe51f24@amd.com>
Date: Mon, 16 Nov 2026 11:09:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: align the sysvm GART start to 8GB
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-6-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261113145702.323968-6-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR12MB5684:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: ca489506-0c4a-40c5-92fb-08df43c9b6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|4143699003|11063799006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: neGTCq1irYMDk/zlVqJqDzHqV16ovpIm5Zpiq6AGKbJPSn+30FCImig9BMWG/1fpYa3C2rgJ3iWqB6pv7S/kKzzwafcV0o5t1BnJHTOGDO/SS2HFeFJBwdX/lSRCrSVPVDJyhF/eCQTnzF6YAXQ0w4tc+bWHvIw2MuamL3OXCXr+0CzhPBCQqmnNQaeCJtnuKqMHtEQfYG5U8jMTouCf9hU3bVF8D56zVCX4phLlLDVchMTXsk8gND0m4sEQHPDeIf1++D8tcn45I9TXu0nv1XaiucsIJMuumAHCnluCraefQli0uxlxyw8XTqhrCmnV1JGNndCuiTmY1DhCaR0MYwCg69SKvW/Ax+R4g2hU5ev+wp/oYqgAJ46VUNKRd6zzG8FK682RnYJHWtPCfg0F1NqSRYi/dTfKTeNO4mw4etvEW9gtEPtQZoz7r3HD8A4Zy+//nSpOlFPLmT+tBpGjCHLr/jUKDVz3BMTFclOWdzl0DQRaAt88U7K4t87UVeZLkQKTOvJf/FRKau5NG6+S0rI8JMxYFSMCJA31xVsvM7+rVuhu0W6xtk27OxOrUK4qxUBiVcatVmxUsCnUUq++wjh8ckVnxJli3VMu1gI/19zXHij/hrHL7tIu5fMASOFny8TjsTSD4XeCicgzSbk5DG1B79yzL7RefAQfy17mTOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJzU1l2ditocTNEKytjS01lUEhub0h3Vy9QOUJQbmplUmxKUUFWelI1STNO?=
 =?utf-8?B?V0FJQW41TmZMTjVsd0lETEU1M0RYT0lQMHZIUDFwS2Z6UVJya2krOWk4Q05o?=
 =?utf-8?B?V3FEYmVySEQrbi9haEpBRWZzZStLL3lBZGppTmJGVEhCS0MzNUtpeDBZb01k?=
 =?utf-8?B?bnpSRFUzRG82ZTJ4YkVzdWlBN2dvVGFaeFZlNSsxVHg5UHB4cnRxaFljcTRn?=
 =?utf-8?B?c2xQMTY5MWp4U1Q3MzJoQjVpWUc5aXArTGdMYTVMdXBtTWJiTlFzYnJrNjB4?=
 =?utf-8?B?TFRVU3FhMWo1M2g5RnZqdHdWSWx3VXJrYTZ1eFNIMlFwRkhtU29pNk9qWXN4?=
 =?utf-8?B?WTUvN2NFYzdLdC8renlLTXJTbjBIRmlKQmlQdkxlVjI4WnpDeThHNmZ4VkNr?=
 =?utf-8?B?UWlKQ2lhTTVoM3RhV0s1bTlDbWV1RjNPcDN0WnFKb2R4Q0VtNERkRTMrS05y?=
 =?utf-8?B?MHVlTUU4eitMYnZ4YXJmSFpvbFg3cWJCTks3MDhFZ29PbERDWnRlcW9DbW9y?=
 =?utf-8?B?NndaR2pxUy9WaFNDYUk5OEdyNWwxZGxjc1lhTXFhQVFjMVl6NmpPMC9jdmUw?=
 =?utf-8?B?QllxZFBYODNzVDRzVTVkYUlROTNtWnVQcWxFSlpiSlJ5TXRWaHd6b3hDV3l1?=
 =?utf-8?B?TlB2VWdwQmZsY3VQaUF1YlZMUXBHT1owd0JTOUx2TEEwUDJva3BzRmUweXFC?=
 =?utf-8?B?cXd3dzlMNzVTR2EzNVZpbngyNUpGUDBTcE02VThlWWFLcGQrclpWZThQUE1l?=
 =?utf-8?B?ZzFDUmVlaDZxMEloSDd2eDh2YS91dUdCN29FUWkyYklIY2x5T2lpb1lNSDFM?=
 =?utf-8?B?VjFEYjMwRGhxamNRbGFpd09XTmJmenBKLzlZTVhpV0lma3lsTHZDTTVWN2Np?=
 =?utf-8?B?VHIwWTRIdzJqSDdzSVNISCtkVEo0Y2NNU00zelVvOHVxOWlzY092V3JVdU5p?=
 =?utf-8?B?VmVkZ1VpbVpkd0taSE5nVFlqcThBT3ZMajYySklqMW9helJRQTJmY3lYci95?=
 =?utf-8?B?RldlN3h1aHpFR1Q5L0NGQ29FQUNHR3BoQkVOYWNTR1JQeU5RYkRjN0dQalNt?=
 =?utf-8?B?alA5WExqeXRnYUhmSUNwRUpydzNYZ0hUZTI2VkIrUnNidTU3TjdJSVJJdlJW?=
 =?utf-8?B?UDNKZFkycTA5T2ZSVDBqK0hGMThoMWJvREJiNHVrMEc1b0drOXNCU3Fpcy9L?=
 =?utf-8?B?bzNYMEpKa2lWalIya1J6d1ZxdlQ2UjlhL0Q4bWhhWlVJTkxLL3NWdStVenJ4?=
 =?utf-8?B?REM0ZlhyYzRUQnN0eG5SMkl3bldpUDBwcXZDcFB3UDZmU01tZjRYeWUwWHNt?=
 =?utf-8?B?SW04Ym1udmJpVFZhS1AwWnV6Mk1nakpoQk5TM1I5WUp5QlVMazdkVXB2Tkdp?=
 =?utf-8?B?QnZMNndNM3JCdGRxamRraG83eFNnbDh2S3hnOHZMSmhUYVMyY1dDRmEzd3ph?=
 =?utf-8?B?UUFDTDRDNDRYL1BkaGlBcDZ4cWE3SHh2RWgybnZKNWtTdGRZb1JwODduV0hC?=
 =?utf-8?B?dG5uTTVNSzJONjBvWDE4Y05HTDIybDZhcVlxMjV5eDIxbHpjNXB2L1JGRlVm?=
 =?utf-8?B?cGxZUUZqOUxTNlQ1eW9JT09HekRHZmRjbWlhMFFHOU5seUJaVXdneTlSSUM4?=
 =?utf-8?B?R1B3QmlkT1FaOFdPSVNQaS9lNzVPenZ5REwyWXpTTlh1UHhVV3BDcHpZNGR2?=
 =?utf-8?B?bEw0aUUrZmc5YnRIbW5CNlVtcVlkdUIvTHRiN2QycWdKMmUzVlEvdVAxUnZZ?=
 =?utf-8?B?UTBBMmNpQ3RpMTNWWHp4QmQyQjJWblVNMmxlc1h2N1BCMFlwb09Ga3Y5M3dJ?=
 =?utf-8?B?aTd5SzVJVzlBQWF0bEViUWlNU010Wk9yMHU3VEo3VTJjTHgwTTRtaGFQSEZW?=
 =?utf-8?B?NWY1UlVCN3hXMkZHTXFNTXUzVW5hd0UrMmUvV3ZGWDYxNlRFTTdKOFJLVHZ0?=
 =?utf-8?B?dzdiMzlQMSs1Vi9rVEo1Y2ErdTRSck5MKzY3bHFlNzNjYTVwaldaak8rckJL?=
 =?utf-8?B?SXBoNFhYaU5sZHpPUDRvcG9KRVppRSs5RGdmVklJNktkQXgycDloVG5zZHpq?=
 =?utf-8?B?U3g4Sm9CREZhWTlrbGhFZDc4emVBNXVnWmJBaXZiM0dLOHAvMnFJQUhsUUZ4?=
 =?utf-8?B?bnRWK0V3dURSVENyMDBKODVBNVRyYWxDakxQTUlNMzBOSzB1NjNUOGx4c2NH?=
 =?utf-8?B?cVR3VmdoaFNHYkJvZklYVm5sSjE1Y0tXbmhaZWdMTUl1ZGZWWDhiMDZBejRD?=
 =?utf-8?B?QkcrMURBMUpJOFdjbVVQSlVCZURTc0hWY2pMUGxHdTAwQW4wSEJId1FZMWlY?=
 =?utf-8?Q?RuL34Q3+POA8o9IgmH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca489506-0c4a-40c5-92fb-08df43c9b6d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:09:47.3432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGFytdnptHHcBnvZ1Tf14VrCyELLB418qGcXl+8OOt0ssuvOj3N4X6GOsVRiMRaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

On 11/13/26 15:57, Zhigang Luo wrote:
> PDB0 block size 12 covers one 8GB entry. A GART start aligned only to
> 4GB can land in the middle of that entry. Align the sysvm GART start
> to 8GB, and use SZ_4G and SZ_8G in place of the local size constants.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org

Please take a look at the gitlog and add a Fixes tag when the VRAM PDE workaround was added.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 04cf02dd22ac..8a62f4f3aace 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -25,6 +25,7 @@
>   */
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/sizes.h>
>  #ifdef CONFIG_X86
>  #include <asm/hypervisor.h>
>  #endif
> @@ -41,8 +42,6 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> -static const u64 four_gb = 0x100000000ULL;
> -
>  bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
>  {
>  	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> @@ -261,8 +260,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> -	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
> +	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, SZ_8G);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>  		/* set mc->vram_start to 0 to switch the returned GPU address of
> @@ -313,7 +312,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  	 * the GART base on a 4GB boundary as well.
>  	 */
>  	size_bf = mc->fb_start;
> -	size_af = max_mc_address + 1 - ALIGN(mc->fb_end + 1, four_gb);
> +	size_af = max_mc_address + 1 - ALIGN(mc->fb_end + 1, SZ_4G);
>  
>  	if (mc->gart_size > max(size_bf, size_af)) {
>  		dev_warn(adev->dev, "limiting GART\n");
> @@ -328,7 +327,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  		if (size_bf >= mc->gart_size)
>  			mc->gart_start = 0;
>  		else
> -			mc->gart_start = ALIGN(mc->fb_end, four_gb);
> +			mc->gart_start = ALIGN(mc->fb_end, SZ_4G);
>  		break;
>  	case AMDGPU_GART_PLACEMENT_BEST_FIT:
>  	default:
> @@ -340,7 +339,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  		break;
>  	}
>  
> -	mc->gart_start &= ~(four_gb - 1);
> +	mc->gart_start &= ~(SZ_4G - 1);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>  			mc->gart_size >> 20, mc->gart_start, mc->gart_end);

