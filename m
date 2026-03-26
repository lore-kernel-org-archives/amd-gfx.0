Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9786109E546
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 04:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572D110E90F;
	Thu, 26 Mar 2026 04:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4J3pB8ua";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B505710E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 04:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOVfAf87brhHggqpNTqQf6txUJfAdkUQzlTTgeUiQimNsod2hOXUSPvhpABLVCdi9MGKeQKSO2YxgOsllhJLFCMYLG/r3uNqIKuQqE9fmeUGDLzjGYcZKay2MwqGqJwPzAdyXT3nUIrO63XRcLNE7Kt/3OXOFHSFSI1C5nYYv+0v/zRXwZwmBK2/L8q19f91bZXIViyMk6oX4rfQMqz2e106/Qoglk3omdU69lAh9ZYkx9hR7MV6du+y/HBZw49sP/Dm2pWBMWkHxAqNQulseUnaxnwkFKAW5vy0Uk8c8V6SUyEiwNz3kEm6kB7HIPBX8JtmfcV8jWE3JaxaAfFu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srW9xikumJg7Wiw7oPuO7iFPJwduwEEU7ruWnIK6uXM=;
 b=qV7TssorIsh8pxIPDUFIetqr0pTrWs9S7IoXZy2Ljy1cT7pmTu09VWYWsr3oEaFyZpe6jEmWT4VuJauhuEaAAqv7t07AIz8GCt6jYI94JH3crj8gjmkQ+bbsqU4V/UtskbBGbCAUr+AA0hEQ2L1GIIoh10oHL/zQVXoMchShbgy+6BRQO3nqXoL04r3Ih2ECWl0fj1YSriUj4rJXj9K2QO+k2cgDFwN/JukTV2If/qAfoJ3phXHCD2D1ISp4E+ODwmbIQJWCGuBdr+s5zeb7C10t3WWVZcvpuSAGpSRMDtCIo/6hG9S/tsRetB35+rxPOB3Ft8UI9nss3kJfmGUYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srW9xikumJg7Wiw7oPuO7iFPJwduwEEU7ruWnIK6uXM=;
 b=4J3pB8uaGee2p2Vsiri30yxBX3MwiOfCCerkmnI696Pp2EeWG3sviWuDKBdiB0s1NsRhuipBOwrvaIOavh9doSHYg9rxeAenleZJ6g8kxvsgzOfbf7caw64jkSpOOehlvmaNFp3BI+lj5cf8IjnD8zakeXu6dgb7+C9COQudUIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 04:23:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 04:23:48 +0000
Message-ID: <8614d12b-c713-4358-b610-1e1ac2c8966e@amd.com>
Date: Thu, 26 Mar 2026 09:53:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] drm/amdgpu: add support to query vram info from
 firmware
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260326032739.2140299-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260326032739.2140299-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::18) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bf1951-2639-4794-dda2-08de8aef78f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ZHpTysA80rCrIIVzX0HO7wQIQl0w16+zah5b2q6dc2X3OPHKE2R6m/phTrPo3HFVwb6JVhct1jXNu+2SjnX6v5tHOfWH066I9xxlwOuXIKhd0w4FNg3EOO07PUdso8BZb9LDYmmncGmIHcLcJK1Ox98gjvtqsckd76oNm6gOzqm7+WAblTACWObJ19f+/GmnWUGSR6iSdpzch/vx0/DnX6urXAAgGSEkUdS3le2Rj+/W6xgn4D0jsuoKn22ogKp9LPDBPO7BSIBBlqciPeHqjwBETttytltJPFZYY3dLVOKJK4N25VxEOinpOmsMrjR++YgDiYIwHEs6hJyH+kRlqv/PxkIc/FpPe7ytb0OIHwqPl/uqnCDNO41AbO9K4U+oeBVc+cmehvhUlU6FuJCt2lveZqv4zb8joE2kbSPwCdtzMOOd012EY+sOc1SxHVhfNKh6OoXcF0wBOD6gGZC5jSLWnuuM4tK1okmSLeqwUF/AVmMpv3Tvdld5LpCBEWZFVSCtwx6GgNTtB6kubId/vz3KD3IKE4GTP7gfLO6h3VMos/3iUw9VUkPjz+6dpE2ra/UJQLkktx+DHR7UndWjLRP4GB+pbewubznwbQiL8dsgKeZ3Q7xwQXV+85DviLzJJtFBhGa+C8w4CHeq/xEMdda6eL8oHMGhfqBGVb3WBqMBr2walESGVJ8mHWWWKErWeCYnC4mG3hUVUBgRq4+UcvDyAY2TMbkT8gTp34HCRNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElGNVZ5cnlNZ0dDNDhmRm1FRmlhUlQxT0ZKVWpPZGlEcVN2WmFqd0IyUDNz?=
 =?utf-8?B?VVVtclB1QkhtTnhwRmpYVFZqcWR4QXJLYlhzZmtNS0lmbnFwU2xuMUJ6bjJ0?=
 =?utf-8?B?RHBnZCtIdTJaYTBNUG41Wk1pL2lYQUtsZi9ubWplbTJwTEJzaGdRMkRwVG56?=
 =?utf-8?B?NGpwdEhyYytrQnVoVUFER3B3R2lZaVYyTkljNGxESUx3akpLd1E1cklheFFC?=
 =?utf-8?B?V2ZDUjhaQUIzUVRmc0hWc2NJaStNZ256K1JUL0NxQnNDZjdVbnpkSHdQbjBC?=
 =?utf-8?B?cmQ4RlpZVERBdjJMNy9uL1FGQjhDa240L3QvNW85akNzOThMdXNRVkJoeWdC?=
 =?utf-8?B?NlYyN3VtU05FSzdRT0tjdWFaMXBkMHVhMXlFakpuc09EemJ2ekdpaWVOcGVM?=
 =?utf-8?B?dENkc1hJbURteVV3MnQreWIybnhLWnQwajI4NmE0cUFwVlJYTytGTkRILzhs?=
 =?utf-8?B?a1VxTmd2T2hLa3dyUjI3OXhLZ3Y2MEthZGZtdWpjSWFTd3d6bDRBOWQ3aDZq?=
 =?utf-8?B?Tzg3cjg1UWxseVdvTmNBVGtYU1UrTnJDMTdwd1ptUTVQS2t0SjBvMTJDeC9Z?=
 =?utf-8?B?U2lFTnJCN1ArcGNtS0tNVGxFQUJ3enlSSFRPWEVSS1hTQ3RVYVA3M1B0SVFL?=
 =?utf-8?B?WG1CRGZObVBTbVhLTVI0QVduMTJ0RWMvYVBoWjZuQVBpM0s5UWsrWFNxRDNr?=
 =?utf-8?B?R29LWGZKUFY5VGNzWUJ6akJadDFaaksvRWZEZEgyYStEbjJUNUNZNnZneVpF?=
 =?utf-8?B?Qmc4SGR0aGNEdnJ6aDNsRENpdncrU0xEQjVES1psaWxJYnhVQXUxaUM4K1VB?=
 =?utf-8?B?bnMwd1Z0TEw0WTdFSXVYWEVFZ0FaUjJoSWdiTUpBd2VkVlM1NlRzYUh4bmVs?=
 =?utf-8?B?U1ZTUXNHSHprVVk0NnErcjdWRVIxZ3hSbStCTUlKY3dHTGo3U0tSUmxQelZ3?=
 =?utf-8?B?dUxURW02L2UxTzJLeFplWGN0OWhEMVNXbEs5MDkwV3kvSjU1MmNUc1J6dkRY?=
 =?utf-8?B?Sndid2NNQ3M3bGJzWGVONXF5UldVRkdLUlZKUGNDb1BMMDFRUTFjdGFDWTJY?=
 =?utf-8?B?TFZ0N0h3MXdVYW5idTQ2bFN0RjZTMmRveU9jM2hNNmg4dytlbFFSVkRBcHM5?=
 =?utf-8?B?UGlKWElMckNZV1hQNU5GWGFTRE16OE16UmZrQzFVSFVVaXJRUTJWMWx0Rzhx?=
 =?utf-8?B?UFRWVEc1QU5Pa21zaEtxdFFoMFRyalFZNVVMMVNNb0ZBN0tRNXRHOG8zSGo0?=
 =?utf-8?B?dmFBUWZnc0ZRUjlaZWp1WTZ5UCtDTUJNemZrUnRxTmJuME1uV3hHTVNUL2tV?=
 =?utf-8?B?d2RtOWdpZWErOTZJTm9sQ1pRSVhMbFh5cGViVWtSRHdJZzVWMTJOblZZbzcz?=
 =?utf-8?B?YnZFSVFLalpJZjRxZ2FvMHcvci8zWEhlcHNITjZFTlpOVGZSZW1pb29leWpV?=
 =?utf-8?B?QjI1SkNxRkVZYkV0RSs4OUd0MHpMNHUySytmT2d6WnB1TzdRVFU2NW9namF4?=
 =?utf-8?B?TmlYQlBmdFFQWlREWkdvNHpvbHNFOXNWVFh2RjF3OGFsWWtVbDJjQ3h6UzAv?=
 =?utf-8?B?aWkzeW94L05WdlRzNSt4MXJrVDdNWXJtTWVFbnRvSDNLdlhnbjFYZEhxVW56?=
 =?utf-8?B?VHVOYUVSS1pMVDI0U3BLdGZiQ0VIS3lmNTdUZWpFL0V1eWd4N05RU1c5aWgv?=
 =?utf-8?B?eHk5ekpyWmt0UnJ1c0ZKTmhxMTJvUUtNdkV0b25sMXZmZ1pIWERCWVNHTjc4?=
 =?utf-8?B?czU5YTVoeU1hbHBsYURqMGQ4eWdINklBd25LRnYyR1NDek1rdldsaGRuNzVl?=
 =?utf-8?B?WVpzRWo4Z0V5M01RMGIvNnpmbUI0NVd2MnppZjFjc2VBc2RrejRxV3BuVzhW?=
 =?utf-8?B?SGR6dnhQbjd0eWs0NUg1SE04eUdSTHdpOVc2WXplSzFRaU02Y2ZwS0lnZ1JZ?=
 =?utf-8?B?TkxXZTVrcEdEWTdhZm9Gd0d2ZVZtUDBsaGdlYTZmUVpWelg4dmtUMnhyRGJD?=
 =?utf-8?B?R0V2MHhtcW9FRjlZOWU5Y0MyQW5MQW9lTVVrWElpU1FyWnlZRndxYzcvYnpT?=
 =?utf-8?B?aUN3U05YczBUZVBYRTJjRWZVeDRTcEdTQ3oyRXdzRDM1S250MXRnNFhhZHRC?=
 =?utf-8?B?c1NaR0wzT0RwTVlldm1rZlRzb0M4anBUZmx5MUJETVZxSTlFTlFmV3FNbzND?=
 =?utf-8?B?MWxkWEwxRVdtMjhZRnoxZmI1aVlaZm1kNWgxYTJKdVZCazQvS0tSOTlJYWY0?=
 =?utf-8?B?YmZBZGRJamdnNldaMW02NHlhb05pUmU1anBOQ3h0M29TN0Y5SUg1QzJmby9k?=
 =?utf-8?B?clVveXVXN20xUnhwVzBWM0IvZXRyTytqeHNiRG5jVitZbEFFSUVpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bf1951-2639-4794-dda2-08de8aef78f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 04:23:47.9042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk161BinnNllAFEw7nN2DaAWx7T+OkfTPX2jON2biRSQbFmgUIdfghNuUm7wZcv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
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



On 26-Mar-26 8:57 AM, Gangliang Xie wrote:
> add support to query vram info from firmware
> 
> v2: change APU vram type, add multi-aid check
> v3: seperate vram info query function into 3 parts and
>      call them in a helper func when requirements
>      are met.
> v4: calculate vram_width for v9.x
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459 ++++++++++--------
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  28 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
>   8 files changed, 314 insertions(+), 243 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..cd9aa5b45e94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -373,249 +373,280 @@ int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
>   	return -ENODEV;
>   }
>   
> -int
> -amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
> +int amdgpu_atomfirmware_get_integrated_system_info(struct amdgpu_device *adev,
>   				  int *vram_width, int *vram_type,
>   				  int *vram_vendor)
>   {
>   	struct amdgpu_mode_info *mode_info = &adev->mode_info;
> -	int index, i = 0;
> +	int index;
>   	u16 data_offset, size;
>   	union igp_info *igp_info;
> -	union vram_info *vram_info;
> -	union umc_info *umc_info;
> -	union vram_module *vram_module;
>   	u8 frev, crev;
>   	u8 mem_type;
> -	u8 mem_vendor;
>   	u32 mem_channel_number;
>   	u32 mem_channel_width;
> -	u32 module_id;
>   
> -	if (adev->flags & AMD_IS_APU)
> -		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						    integratedsysteminfo);
> -	else {
> -		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -		case IP_VERSION(12, 0, 0):
> -		case IP_VERSION(12, 0, 1):
> -			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
> +	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
> +					  index, &size,
> +					  &frev, &crev, &data_offset)) {
> +		igp_info = (union igp_info *)
> +			(mode_info->atom_context->bios + data_offset);
> +		switch (frev) {
> +		case 1:
> +			switch (crev) {
> +			case 11:
> +			case 12:
> +				mem_channel_number = igp_info->v11.umachannelnumber;
> +				if (!mem_channel_number)
> +					mem_channel_number = 1;
> +				mem_type = igp_info->v11.memorytype;
> +				if (mem_type == LpDdr5MemType)
> +					mem_channel_width = 32;
> +				else
> +					mem_channel_width = 64;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * mem_channel_width;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +		case 2:
> +			switch (crev) {
> +			case 1:
> +			case 2:
> +				mem_channel_number = igp_info->v21.umachannelnumber;
> +				if (!mem_channel_number)
> +					mem_channel_number = 1;
> +				mem_type = igp_info->v21.memorytype;
> +				if (mem_type == LpDdr5MemType)
> +					mem_channel_width = 32;
> +				else
> +					mem_channel_width = 64;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * mem_channel_width;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				break;
> +			case 3:
> +				mem_channel_number = igp_info->v23.umachannelnumber;
> +				if (!mem_channel_number)
> +					mem_channel_number = 1;
> +				mem_type = igp_info->v23.memorytype;
> +				if (mem_type == LpDdr5MemType)
> +					mem_channel_width = 32;
> +				else
> +					mem_channel_width = 64;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * mem_channel_width;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>   			break;
>   		default:
> -			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, vram_info);
> +			return -EINVAL;
>   		}
> +	} else {
> +		return -EINVAL;
>   	}
> +	return 0;
> +}
> +
> +int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
> +				  int *vram_width, int *vram_type,
> +				  int *vram_vendor)
> +{
> +	struct amdgpu_mode_info *mode_info = &adev->mode_info;
> +	int index;
> +	u16 data_offset, size;
> +	union umc_info *umc_info;
> +	u8 frev, crev;
> +	u8 mem_type;
> +	u8 mem_vendor;
> +	u32 mem_channel_number;
> +	u32 mem_channel_width;
> +
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
> +
>   	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>   					  index, &size,
>   					  &frev, &crev, &data_offset)) {
> -		if (adev->flags & AMD_IS_APU) {
> -			igp_info = (union igp_info *)
> -				(mode_info->atom_context->bios + data_offset);
> -			switch (frev) {
> -			case 1:
> -				switch (crev) {
> -				case 11:
> -				case 12:
> -					mem_channel_number = igp_info->v11.umachannelnumber;
> -					if (!mem_channel_number)
> -						mem_channel_number = 1;
> -					mem_type = igp_info->v11.memorytype;
> -					if (mem_type == LpDdr5MemType)
> -						mem_channel_width = 32;
> -					else
> -						mem_channel_width = 64;
> -					if (vram_width)
> -						*vram_width = mem_channel_number * mem_channel_width;
> -					if (vram_type)
> -						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -					break;
> -				default:
> -					return -EINVAL;
> -				}
> -				break;
> -			case 2:
> -				switch (crev) {
> -				case 1:
> -				case 2:
> -					mem_channel_number = igp_info->v21.umachannelnumber;
> -					if (!mem_channel_number)
> -						mem_channel_number = 1;
> -					mem_type = igp_info->v21.memorytype;
> -					if (mem_type == LpDdr5MemType)
> -						mem_channel_width = 32;
> -					else
> -						mem_channel_width = 64;
> -					if (vram_width)
> -						*vram_width = mem_channel_number * mem_channel_width;
> -					if (vram_type)
> -						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -					break;
> -				case 3:
> -					mem_channel_number = igp_info->v23.umachannelnumber;
> -					if (!mem_channel_number)
> -						mem_channel_number = 1;
> -					mem_type = igp_info->v23.memorytype;
> -					if (mem_type == LpDdr5MemType)
> -						mem_channel_width = 32;
> -					else
> -						mem_channel_width = 64;
> -					if (vram_width)
> -						*vram_width = mem_channel_number * mem_channel_width;
> -					if (vram_type)
> -						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -					break;
> -				default:
> -					return -EINVAL;
> -				}
> +		umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
> +
> +		if (frev == 4) {
> +			switch (crev) {
> +			case 0:
> +				mem_channel_number = le32_to_cpu(umc_info->v40.channel_num);
> +				mem_type = le32_to_cpu(umc_info->v40.vram_type);
> +				mem_channel_width = le32_to_cpu(umc_info->v40.channel_width);
> +				mem_vendor = RREG32(adev->bios_scratch_reg_offset + 4) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				if (vram_width)
> +					*vram_width = mem_channel_number * (1 << mem_channel_width);
>   				break;
>   			default:
>   				return -EINVAL;
>   			}
>   		} else {
> -			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -			case IP_VERSION(12, 0, 0):
> -			case IP_VERSION(12, 0, 1):
> -				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
> -
> -				if (frev == 4) {
> -					switch (crev) {
> -					case 0:
> -						mem_channel_number = le32_to_cpu(umc_info->v40.channel_num);
> -						mem_type = le32_to_cpu(umc_info->v40.vram_type);
> -						mem_channel_width = le32_to_cpu(umc_info->v40.channel_width);
> -						mem_vendor = RREG32(adev->bios_scratch_reg_offset + 4) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						if (vram_width)
> -							*vram_width = mem_channel_number * (1 << mem_channel_width);
> -						break;
> -					default:
> -						return -EINVAL;
> -					}
> -				} else
> -					return -EINVAL;
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
> +				  int *vram_width, int *vram_type,
> +				  int *vram_vendor)
> +{
> +	struct amdgpu_mode_info *mode_info = &adev->mode_info;
> +	int index, i = 0;
> +	u16 data_offset, size;
> +	union vram_info *vram_info;
> +	union vram_module *vram_module;
> +	u8 frev, crev;
> +	u8 mem_type;
> +	u8 mem_vendor;
> +	u32 mem_channel_number;
> +	u32 mem_channel_width;
> +	u32 module_id;
> +
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, vram_info);
> +
> +	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
> +					  index, &size,
> +					  &frev, &crev, &data_offset)) {
> +		vram_info = (union vram_info *)
> +			(mode_info->atom_context->bios + data_offset);
> +
> +		module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 0x00ff0000) >> 16;
> +		if (frev == 3) {
> +			switch (crev) {
> +			/* v30 */
> +			case 0:
> +				vram_module = (union vram_module *)vram_info->v30.vram_module;
> +				mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				mem_type = vram_info->v30.memory_type;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				mem_channel_number = vram_info->v30.channel_num;
> +				mem_channel_width = vram_info->v30.channel_width;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * 16;
>   				break;
>   			default:
> -				vram_info = (union vram_info *)
> -					(mode_info->atom_context->bios + data_offset);
> -
> -				module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 0x00ff0000) >> 16;
> -				if (frev == 3) {
> -					switch (crev) {
> -					/* v30 */
> -					case 0:
> -						vram_module = (union vram_module *)vram_info->v30.vram_module;
> -						mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						mem_type = vram_info->v30.memory_type;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						mem_channel_number = vram_info->v30.channel_num;
> -						mem_channel_width = vram_info->v30.channel_width;
> -						if (vram_width)
> -							*vram_width = mem_channel_number * 16;
> -						break;
> -					default:
> -						return -EINVAL;
> -					}
> -				} else if (frev == 2) {
> -					switch (crev) {
> -					/* v23 */
> -					case 3:
> -						if (module_id > vram_info->v23.vram_module_num)
> -							module_id = 0;
> -						vram_module = (union vram_module *)vram_info->v23.vram_module;
> -						while (i < module_id) {
> -							vram_module = (union vram_module *)
> -								((u8 *)vram_module + vram_module->v9.vram_module_size);
> -							i++;
> -						}
> -						mem_type = vram_module->v9.memory_type;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						mem_channel_number = vram_module->v9.channel_num;
> -						mem_channel_width = vram_module->v9.channel_width;
> -						if (vram_width)
> -							*vram_width = mem_channel_number * (1 << mem_channel_width);
> -						mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						break;
> -					/* v24 */
> -					case 4:
> -						if (module_id > vram_info->v24.vram_module_num)
> -							module_id = 0;
> -						vram_module = (union vram_module *)vram_info->v24.vram_module;
> -						while (i < module_id) {
> -							vram_module = (union vram_module *)
> -								((u8 *)vram_module + vram_module->v10.vram_module_size);
> -							i++;
> -						}
> -						mem_type = vram_module->v10.memory_type;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						mem_channel_number = vram_module->v10.channel_num;
> -						mem_channel_width = vram_module->v10.channel_width;
> -						if (vram_width)
> -							*vram_width = mem_channel_number * (1 << mem_channel_width);
> -						mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						break;
> -					/* v25 */
> -					case 5:
> -						if (module_id > vram_info->v25.vram_module_num)
> -							module_id = 0;
> -						vram_module = (union vram_module *)vram_info->v25.vram_module;
> -						while (i < module_id) {
> -							vram_module = (union vram_module *)
> -								((u8 *)vram_module + vram_module->v11.vram_module_size);
> -							i++;
> -						}
> -						mem_type = vram_module->v11.memory_type;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						mem_channel_number = vram_module->v11.channel_num;
> -						mem_channel_width = vram_module->v11.channel_width;
> -						if (vram_width)
> -							*vram_width = mem_channel_number * (1 << mem_channel_width);
> -						mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						break;
> -					/* v26 */
> -					case 6:
> -						if (module_id > vram_info->v26.vram_module_num)
> -							module_id = 0;
> -						vram_module = (union vram_module *)vram_info->v26.vram_module;
> -						while (i < module_id) {
> -							vram_module = (union vram_module *)
> -								((u8 *)vram_module + vram_module->v9.vram_module_size);
> -							i++;
> -						}
> -						mem_type = vram_module->v9.memory_type;
> -						if (vram_type)
> -							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						mem_channel_number = vram_module->v9.channel_num;
> -						mem_channel_width = vram_module->v9.channel_width;
> -						if (vram_width)
> -							*vram_width = mem_channel_number * (1 << mem_channel_width);
> -						mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
> -						if (vram_vendor)
> -							*vram_vendor = mem_vendor;
> -						break;
> -					default:
> -						return -EINVAL;
> -					}
> -				} else {
> -					/* invalid frev */
> -					return -EINVAL;
> +				return -EINVAL;
> +			}
> +		} else if (frev == 2) {
> +			switch (crev) {
> +			/* v23 */
> +			case 3:
> +				if (module_id > vram_info->v23.vram_module_num)
> +					module_id = 0;
> +				vram_module = (union vram_module *)vram_info->v23.vram_module;
> +				while (i < module_id) {
> +					vram_module = (union vram_module *)
> +						((u8 *)vram_module + vram_module->v9.vram_module_size);
> +					i++;
>   				}
> +				mem_type = vram_module->v9.memory_type;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				mem_channel_number = vram_module->v9.channel_num;
> +				mem_channel_width = vram_module->v9.channel_width;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * (1 << mem_channel_width);
> +				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				break;
> +			/* v24 */
> +			case 4:
> +				if (module_id > vram_info->v24.vram_module_num)
> +					module_id = 0;
> +				vram_module = (union vram_module *)vram_info->v24.vram_module;
> +				while (i < module_id) {
> +					vram_module = (union vram_module *)
> +						((u8 *)vram_module + vram_module->v10.vram_module_size);
> +					i++;
> +				}
> +				mem_type = vram_module->v10.memory_type;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				mem_channel_number = vram_module->v10.channel_num;
> +				mem_channel_width = vram_module->v10.channel_width;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * (1 << mem_channel_width);
> +				mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				break;
> +			/* v25 */
> +			case 5:
> +				if (module_id > vram_info->v25.vram_module_num)
> +					module_id = 0;
> +				vram_module = (union vram_module *)vram_info->v25.vram_module;
> +				while (i < module_id) {
> +					vram_module = (union vram_module *)
> +						((u8 *)vram_module + vram_module->v11.vram_module_size);
> +					i++;
> +				}
> +				mem_type = vram_module->v11.memory_type;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				mem_channel_number = vram_module->v11.channel_num;
> +				mem_channel_width = vram_module->v11.channel_width;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * (1 << mem_channel_width);
> +				mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				break;
> +			/* v26 */
> +			case 6:
> +				if (module_id > vram_info->v26.vram_module_num)
> +					module_id = 0;
> +				vram_module = (union vram_module *)vram_info->v26.vram_module;
> +				while (i < module_id) {
> +					vram_module = (union vram_module *)
> +						((u8 *)vram_module + vram_module->v9.vram_module_size);
> +					i++;
> +				}
> +				mem_type = vram_module->v9.memory_type;
> +				if (vram_type)
> +					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +				mem_channel_number = vram_module->v9.channel_num;
> +				mem_channel_width = vram_module->v9.channel_width;
> +				if (vram_width)
> +					*vram_width = mem_channel_number * (1 << mem_channel_width);
> +				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
> +				if (vram_vendor)
> +					*vram_vendor = mem_vendor;
> +				break;
> +			default:
> +				return -EINVAL;
>   			}
> +		} else {
> +			/* invalid frev */
> +			return -EINVAL;
>   		}
> +
> +	} else {
> +		return -EINVAL;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index 67c8d105729b..0760e4510513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -30,6 +30,10 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
>   bool amdgpu_atomfirmware_gpu_virtualization_supported(struct amdgpu_device *adev);
>   void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
> +int amdgpu_atomfirmware_get_integrated_system_info(struct amdgpu_device *adev,
> +	int *vram_width, int *vram_type, int *vram_vendor);
> +int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
> +	int *vram_width, int *vram_type, int *vram_vendor);
>   int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   	int *vram_width, int *vram_type, int *vram_vendor);
>   int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index f165d4e401e8..10713be13579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -34,6 +34,7 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_reset.h"
>   #include "amdgpu_xgmi.h"
> +#include "amdgpu_atomfirmware.h"
>   
>   #include <drm/drm_drv.h>
>   #include <drm/ttm/ttm_tt.h>
> @@ -1748,3 +1749,30 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
> +		int *vram_width, int *vram_type, int *vram_vendor)
> +{
> +	int ret = 0;
> +
> +	if (adev->flags & AMD_IS_APU)
> +		return amdgpu_atomfirmware_get_integrated_system_info(adev,
> +							vram_width, vram_type, vram_vendor);
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +		return amdgpu_atomfirmware_get_umc_info(adev,
> +								vram_width, vram_type, vram_vendor);
> +	case IP_VERSION(9, 5, 0):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 4, 3):
> +		ret = amdgpu_atomfirmware_get_umc_info(adev,
> +								vram_width, vram_type, vram_vendor);
> +		*vram_width *= hweight32(adev->aid_mask);

To be on the safe side,
	if (vram_width && !ret)
		*vram_width *= hweight32(adev->aid_mask);

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +		return ret;
> +	default:
> +		return amdgpu_atomfirmware_get_vram_info(adev,
> +								vram_width, vram_type, vram_vendor);
> +	}
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b9fdc3276e81..32e73e8ba778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -482,4 +482,6 @@ amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
>   int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
>   void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
>   				   struct amdgpu_mem_partition_info *mem_ranges);
> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
> +		int *vram_width, int *vram_type, int *vram_vendor);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 2568eeaae945..fd691b2a6e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -767,7 +767,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
>   		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
>   	} else {
> -		r = amdgpu_atomfirmware_get_vram_info(adev,
> +		r = amdgpu_gmc_get_vram_info(adev,
>   				&vram_width, &vram_type, &vram_vendor);
>   		adev->gmc.vram_width = vram_width;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 6349e239a367..e6db87b94eb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -751,7 +751,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
> -	r = amdgpu_atomfirmware_get_vram_info(adev,
> +	r = amdgpu_gmc_get_vram_info(adev,
>   					      &vram_width, &vram_type, &vram_vendor);
>   	adev->gmc.vram_width = vram_width;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index f1079bd8cf00..6e184ea069ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -825,7 +825,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>   		gmc_v12_1_init_vram_info(adev);
>   	} else {
> -		r = amdgpu_atomfirmware_get_vram_info(adev,
> +		r = amdgpu_gmc_get_vram_info(adev,
>   			      &vram_width, &vram_type, &vram_vendor);
>   		adev->gmc.vram_width = vram_width;
>   		adev->gmc.vram_type = vram_type;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 1ca0202cfdea..d865059e884a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
>   		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
>   }
>   
> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>   {
>   	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
> +	int dev_var = adev->pdev->device & 0xF;
>   	u32 vram_info;
>   
> -	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -	adev->gmc.vram_width = 128 * 64;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> -		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> -		adev->rev_id == 0x3)
> -		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> -
> -	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> -		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> -		adev->gmc.vram_vendor = vram_info & 0xF;
> +	if (adev->gmc.is_app_apu) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> +		adev->gmc.vram_width = 128 * 64;
> +	} else if (adev->flags & AMD_IS_APU) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> +		adev->gmc.vram_width = 64 * 64;
> +	} else if (amdgpu_is_multi_aid(adev)) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> +		adev->gmc.vram_width = 128 * 64;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> +		    adev->rev_id == 0x3)
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +		    (dev_var == 0x5))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> +			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> +			adev->gmc.vram_vendor = vram_info & 0xF;
> +		}
>   	}
>   }
>   
> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
> -	if (amdgpu_is_multi_aid(adev)) {
> -		gmc_v9_4_3_init_vram_info(adev);
> -	} else if (!adev->bios) {
> -		if (adev->flags & AMD_IS_APU) {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> -			adev->gmc.vram_width = 64 * 64;
> -		} else {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -			adev->gmc.vram_width = 128 * 64;
> -		}
> +	if (!adev->bios) {
> +		gmc_v9_0_init_vram_info(adev);
>   	} else {
> -		r = amdgpu_atomfirmware_get_vram_info(adev,
> -			&vram_width, &vram_type, &vram_vendor);
> +		r = amdgpu_gmc_get_vram_info(adev,
> +				&vram_width, &vram_type, &vram_vendor);
>   		if (amdgpu_sriov_vf(adev))
>   			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
>   			 * and DF related registers is not readable, seems hardcord is the
> @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->gmc.vram_type = vram_type;
>   		adev->gmc.vram_vendor = vram_vendor;
>   	}
> +
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(9, 1, 0):
>   	case IP_VERSION(9, 2, 2):

