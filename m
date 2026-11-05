Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6A606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MC8b9Opz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06F610E0D8;
	Thu,  5 Nov 2026 11:29:52 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2D910E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 11:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBEvzo8l23nGyaV1YchAJpAb99oMlv+mYlu+/lUcaOOlJSW+CWEPRu4dp1KfZLeQsGWx9oohnp1hnfFh8X1FyvTakVDZGimucuLfaUjP524HUX9Ce3/aYLltErN3vVkZcAREJdRPEQmr9HTPKb5yGhPJKffBDbBjD+j0EhsaRuC48bwn+iHnvtArXb2BqqAmibJIiSl8ScidgYKQxWGinzspaPB2+0wKtm5auGWnobBxrrMmmBVQfR+7nPcd7+AAPTdc4SN5vB8R15HxXWy+KzBDVxkuov6XfAyKumlKCItcSTWB4pRijF/mN0jF8TLwSGdfOq6fsfnYhkFBYAtRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9fuhHkE8BuBgMJgz2yxVjQLMMODlCPzDuh563Km/GY=;
 b=zKkASj114ZudkWKCve3ebuye+9v+oiIs9ilSagg4kFlijNHh/sBPy6+/X5S/l+oFdrcO6N81LdLdTCo4oyKwr4DNErpvf7wU4QZboUN/PBYjaqwJZY/2acmShx1VxSeDCcM5juK6D/9XZbRrzD01JukU6fW00Rv977QF/G0lTVkoJdmycgKGvBnSQBBzen1bupMhccOc6arTtg+Cpfd1WulAn1fga9XcpDMDW1lGbqkvDBifFOKbWwOWGxiiRAevgOzOHEbNHoG05ANcd8v150SCgZU02Wy4Zl4uYqfaAaQGbPsCDXHRlzhrl1QKcs+ez3Id3DKdcAjccScw8lO2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9fuhHkE8BuBgMJgz2yxVjQLMMODlCPzDuh563Km/GY=;
 b=MC8b9OpzBiq5AIlS1dII5iuNxEdDT1W0IVnhmhGmfoXjCXHYVG0xmgaLBD28JIcuv86F3o1tevKUP0XuQ0zgESn9TFSV+KaWCJvlOqno2TNl5bznq8fIs/nI+RDN/SWB6CkmJpgu46biMWNhIGJKDV5nh1Cg4+LS1ZBkS3eyQVc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 11:29:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:29:40 +0000
Message-ID: <7d1e794a-a8ec-42d7-81dc-47ed61870f64@amd.com>
Date: Thu, 5 Nov 2026 12:29:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep SPM VF VRAM at GPU address 0
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261104200152.77286-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261104200152.77286-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0434.namprd03.prod.outlook.com
 (2603:10b6:408:113::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: b9677126-2f24-4505-8353-08df3b3014dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|261102123227099003|261009223027099003|261028144727099003|261022105027099003|11063799006|56012099006|261026121527099003|261026140227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: hwnIrMVkKw26aKGx/g5O51hS/wCSoLK6X0dfRbOulYFnWo1bME1af2yyQkYhZ64Nqoiy4d0X8noxK/PBZ3xCS4dmYlI29DRAmRkX8Ui4qMS5XZqaXl+S+WOI/U0HvKqu2sQpOEE0DLEnrNcagd8zNYW7exsAEG0Nw2i0cYuEVnekrJ8vlKOJ6zfys8ktvog2LsLqjF9mkKkEldIDSU3/oiqgvyTZSNPm7cGGT3qIUyT3HiDx6HAbIue4rxeZtjN50jBZlxTd4bXc/5grdQdpOSF1VH5mhcqHsZaHfYQ1eIiwh7RwAoTDL/fjD7w2OrAycSWNPWU90F1jk3bqijiKMrDDGcwN4VXsrb/lyohKE9wvIKH1E2yNtWAzkHjRu5wtEAmADHT9BFgJbJ8VT3tUbCOQTYVhqm7fMGcYDOpPoFoCjVpovfJsaf7DemSASHgP3P9g1qK/ePtIMP55r2700uR02m07BFgGTXV2hicPuF9G+TN6RAmtraQfXMzppGeYcn7tiTbEYdvfr7qymZAibCUJyq78H29nlozYZ8mk7YseSbVgtqcCllJUGcN/iJCfv7w7ytX3OduE65hKZ0aAefxnenJLRpZtsPIyV/M7KiXFYNPW4L2Lqx67TtGDPv5tijg9ys8v3TAvqpzJz2gOWcpaRepZ5bB5LmXrSy0jKAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJHYXF6Z0Z3cThRbWFuMnpyTFNJVEJHc3paNVdVcitKRU95OXJNSHBCaExE?=
 =?utf-8?B?U0MyZmRnY0tRVmU4ZGNOTWd0elpyWFcveTVCMmNoNk5uWmUvZFdJS1RFZml3?=
 =?utf-8?B?d213QXNRL0VWdGdoMGpyU3U5WU9lZWM4Uk1EbUpMS0FrZmVRTGF0bGNzS2hx?=
 =?utf-8?B?eCt4TEQ2a1U4bWpENTh1dWhCK0pUZGZwT3phUUV2aGpHVjVNOU4zR3BKZERa?=
 =?utf-8?B?NFQxYnNkWVFOc2dLUytIQXZtTFpaYUQzMGNMRTR6NDlzYjhjZDJjUFFGRitj?=
 =?utf-8?B?bUF6bVFraHhzMUpJRVdlYktvUU9kZ3JtRmU4LzREa01la2dzTjVUbGdrcVVB?=
 =?utf-8?B?anMvdnlpYnZoVVhTOTJ5dFVmWUFyN1hXRDAyYnFjU3dxYk95RC8wUW1HSmg4?=
 =?utf-8?B?SERndzlBck5ML3pmMXpiTHVUdjJiTWNWbVVIczJGdHZtT1ptMTZEalZXRUVo?=
 =?utf-8?B?M25xVUdudjdPaWVHa3Z4ZWJmTTJvRHpuT2lkREdHQTR6WWZDNGppTXNtajNl?=
 =?utf-8?B?L0JidEV0dStYODRsWWQ3eklDWElHcUpNQWZHc2QxaS9YNkhkM3NQWnJxR1VC?=
 =?utf-8?B?NWdGamV0c0x3RThnQkFzaTdzcFhGZlBtYVc0QWhHQ0sxbVZ3cXBiRmp2K1oz?=
 =?utf-8?B?eDFZQ2VMWUhjMCtlRDRtc3VLOW1FWDVLTlkwZFc2ZFhOOFgwNmc3NlFVTE12?=
 =?utf-8?B?MGI4S3U3YW9CbzUyNXUvNmFQNHhySjZTeE9DR05VN0k2aHlrcUY0cmRuazVL?=
 =?utf-8?B?L28wWGRVKzJYd0FrOEl3SVQ5K2tVNFU5aSsvSWJjRVdRdzMzMmZOWHE0T05J?=
 =?utf-8?B?MkFETlY0UDlYQlBnVGtJa0U2eEEyNEpzSVU4UTFBZ0pwSTNkSG1URXJoTWpN?=
 =?utf-8?B?NVhQLzc3d0xzb1RhQVN4czR0L0FacnVBb1F1WXZUci9lTFVxTEpGUzg5ZVdr?=
 =?utf-8?B?WTNHSlorcUREaFJmQmZ6SDIvV2lFcFdiK2VLYnpKd09JMTcweVdYQmxGMis4?=
 =?utf-8?B?aWxaTnJ4YnBpV3ZGeXc1NFdFTDhiazNKbzVGM1BLRHNiYW5WTGpxUUU3MlJq?=
 =?utf-8?B?V3YwdDd3UlhTa3VBam50MGlhUG1CWkttcUVOd01XNlVZNTF1eDdSRmV2THVS?=
 =?utf-8?B?MmJyV01MdmhHeXFBaU1vSkZzampBeGppNFFDR09UbFY5TURJaGwzRVRMSEJ1?=
 =?utf-8?B?WG14cXJrY1ljOCtkTDZTWUh4czhhQUhxbkIwSGJVMXhxSjVUVTB3MnAwMHRv?=
 =?utf-8?B?RFhIMjBDaHpER3hzbThvdm1pWGV4czl6VC90UFRCSUpCcmRIMEJGY2JxeGVV?=
 =?utf-8?B?clJCZ1VZamxsSzRQdVVKMEF6blNqZnJMbmRyYmhSd0lYSHB2eGowc2pOdnlo?=
 =?utf-8?B?NDIweGZmR0ZvNXkxdThlOEtodm9qMmtZa25vdkxHdTltbXZITmJNY3RqbVU4?=
 =?utf-8?B?MVlSNStLWk52czhhbVI2T1p2UUppd2pMR1ZpcVhETTMvZGZiKzJ0VVYxM3lI?=
 =?utf-8?B?ODRIRnhxS09zYlNjMU5ROEZqbEJvNjd6bGVjR1FqOHZ4QXhEeDFGbmRPUy9G?=
 =?utf-8?B?dkxJL0pmVjNpdEFzaFFsM045MWdkK0k1d0JPazJESDBHZW9tMDJaZ25BREFO?=
 =?utf-8?B?S1J0WEdoVHhtMEZRUGE4VnhiUWZ6bkZXR3hqMHNTUFkxUnFUVXVRVHZJNVNk?=
 =?utf-8?B?STZ0bVhraG9PYkR3SjRHM2dSUktqaTMweGgvV0UwWVNIWGlhZHpHR3VjQUU4?=
 =?utf-8?B?alRvaGNGWHdRRDNWZEhjWTJqRCtIdEZEUFF6dDBwUTUzZ1lpUU5TWEZZd1N6?=
 =?utf-8?B?b3VYaWQrWW83TFc4b09NcTJSUWhNeElaS1JrYmZFU21WakNPVzY5TTFmamFL?=
 =?utf-8?B?NElHR1c1bDJGTzBsM0dVUENOTUJQbGJXMEF0UUk5a3gwWGM5TjJUR1M2aHBr?=
 =?utf-8?B?SDhUKzFjeVV6TUp1eXAvTzFkdktoVC9XUS9nODJNMFFtRWxoengzUFZmVFdR?=
 =?utf-8?B?bldJRVVsd0xnUWdpMU1KRVRoWjJ1bWJ5OXJoV01yalUxcEZndmFqakk5SEJD?=
 =?utf-8?B?SXJxRmVCZzJZaWVRQUw0SnlGdWFSMXZZUDlDeEp3QlMya0RLa0RzaXJtSy9O?=
 =?utf-8?B?VndTZ1F3NCtqYmhlVklhNVZBY1dyQmdVM2c4bGdaYWJ1MVdqWmZrbHoyN2RY?=
 =?utf-8?B?SjVkL0hxSzd3YXB4MmNvOEdwZXJWRXlsTTF1bXNkTE9HMkdyUE5xVHY0K29i?=
 =?utf-8?B?Tm10NFo0ZWkxMnM5djdiaTEwdW4vSElSaEhta0ZDMGh2c2F1YzFkMU9KNzAx?=
 =?utf-8?Q?j/sarAB3tXUTNoWQjP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9677126-2f24-4505-8353-08df3b3014dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:29:40.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ib+LNM4DqR52cndphxti1f2XzyWbmk9q0YcBRgWG3zf5KV71O+yZ5cYs10XkNRL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

On 11/4/26 21:01, Zhigang Luo wrote:
> - bug 'amdgpu_virt_resume': resume added the xGMI node segment on top
>   of the MMHUB FB offset for SPM VRAM; use aper_base and skip the node
>   offset
> - bug 'gmc_v12_0_vram_gtt_location': the initial load path added the
>   same node segment after aper_base; skip it when VRAM is SPM
> - bug 'amdgpu_gmc_sysvm_location': SPM used the hive window and a 4GB
>   GART alignment; zero the VRAM GPU window and place GART after local
>   VRAM on an 8GB PDB0 boundary
> - bug 'amdgpu_gmc_pdb0_alloc': PDB0 covered the hive; size SPM coverage
>   from mc_vram_size
> - bug 'amdgpu_gmc_init_pdb0': SPM subtracted the node segment from
>   aper_base; keep the system physical base


First of all please write a proper commit message. That here is clearly inacceptable.


> 
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 22 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  6 ++++--
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9326f811c500..7a664b7b1ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4677,9 +4677,15 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>  		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
>  
> -	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> -	adev->vm_manager.vram_base_offset +=
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;

Well that is totally nonsense as far as I can see.

The vram_base_offset and the PCI aperture are two completely different things.

Please explain what you try to do here?

> +	} else {
> +		adev->vm_manager.vram_base_offset =
> +			adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id *
> +			adev->gmc.xgmi.node_segment_size;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4204c3c750a8..78fae3fbee11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -42,6 +42,8 @@
>  #include <drm/ttm/ttm_tt.h>
>  
>  static const u64 four_gb = 0x100000000ULL;
> +/* PDB0 block size 12 covers one 8GB entry. */
> +static const u64 eight_gb = 0x200000000ULL;
>  
>  bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
>  {
> @@ -60,7 +62,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
>  {
>  	int r;
>  	struct amdgpu_bo_param bp;
> -	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
> +	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
> +		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;

Clear NAK from my side for such hacks.

Please describe the requirements and proper integarte that into the handling.

Regards,
Christian.

>  	uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size + 21;
>  	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) - 1) >> pde0_page_shift;
>  
> @@ -266,16 +269,21 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> -	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
> +	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> -	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) ||
> +	    amdgpu_virt_vram_is_spm(adev)) {
>  		/* set mc->vram_start to 0 to switch the returned GPU address of
>  		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
>  		 */
>  		mc->vram_start = 0;
>  		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>  		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
> +		if (amdgpu_virt_vram_is_spm(adev)) {
> +			mc->gart_start = ALIGN(mc->vram_end + 1, eight_gb);
> +			mc->gart_end = mc->gart_start + mc->gart_size - 1;
> +		}
>  	} else {
>  		mc->fb_start = hive_vram_start;
>  		mc->fb_end = hive_vram_end;
> @@ -1274,7 +1282,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore NC/RW?
>  	/* Each PDE0 (used as PTE) covers (2^vmid0_page_table_block_size)*2M
>  	 */
> -	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
> +	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
> +		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
>  	u64 vram_addr, vram_end;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> @@ -1292,7 +1301,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
>  	vram_addr = adev->vm_manager.vram_base_offset;
> -	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev) &&
> +	    !amdgpu_virt_vram_is_spm(adev))
>  		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>  	vram_end = vram_addr + vram_size;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..e37c84f10709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -734,8 +734,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
>  		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
>  	}
>  
> -	adev->vm_manager.vram_base_offset +=
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	if (!amdgpu_virt_vram_is_spm(adev))
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id *
> +			adev->gmc.xgmi.node_segment_size;
>  }
>  
>  /**

