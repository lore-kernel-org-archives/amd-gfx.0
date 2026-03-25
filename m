Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C16FFEA80A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 05:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9832D10E78B;
	Wed, 25 Mar 2026 05:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gza0cJu9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D1810E77B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 05:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep31k3pIyXwYsw+Xzs9K/oVuluWlzE5Q83BAPBhNGwRbLEifG/g+mEreuXUrTQTl/vXbnMVc8lPJvwlwUnJE9xv1gxhBmfeJreVsfdFgq9ryaF+Hmj747BrxOBfat6wLfpVIZPJdj5z4pPq2wVzeKLnWVmAtStRkv1oCz0J6SlFl5hq1Eri4ys/r+OVlKvjd/4xE6LzXSb1Szyu7lg7yOIA9EcoJETg/9BrLzz02sKfRyiEbsAYvTWosw4XLGITsYNBmpFhy/NxfDf9ENl6jGv6DbzWJmj9SvoYuQLnLxI2Bn7bx5VTXhph95CWuR7J8fpw0akw4DTHoSnPp9TYy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2plAY3n0rF4n2pD+C5Zn0kDMh+tw3+ebdIO0t1IEJKY=;
 b=rmnBUfbbPoJehhP0HHz0H70zd56ezuuEWJa4oGfr68G9rwiERZ9MvIYFwb4ymFuH15GXffVFpwR3VIEeeWeeqZxHPBfrKlo9fxGtFq2H4fnqq0YMbOA0bXQq67VPqT4Voesi+8xNZ3UD7KwrNFhfWO2nVUeftFQNuM8Z4CDR1jOPbdfS5tjHwkof/lkt00Kq7hNRJSN74R+TzIWhLoPc1OY9IIvJ4+axeuq1ZJ/XfxvZbLX9HMndgLrO322XMrppKqMqzc5u718YORDur1zmjuZyVuG4OFSbxWBuA7vl+Hku1RIySwkgWFsiR7EVo+eqUiYCjGuPfrK1TBXvOqMBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2plAY3n0rF4n2pD+C5Zn0kDMh+tw3+ebdIO0t1IEJKY=;
 b=Gza0cJu9H8AcgOnvMQ7oFuH6wHcxJN5eqYloF5xYTwtfzGF2t7sgen3YClQOcvmb3AHdfrgEOepUgC7cp5+NA9A2LMh+tDC8wnwXIwgC7xnVfe+GJ1NxxT+Akyu4cgAdB2AC8oPbmy1IBmW2pPLhHxn95xEcm7L04H7gNGrVt0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:40:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:40:19 +0000
Message-ID: <48d5730b-384f-4b97-918b-ce9a63e5ad8e@amd.com>
Date: Wed, 25 Mar 2026 11:10:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: add support to query vram info from
 firmware
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260325040727.2016678-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260325040727.2016678-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::25) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6572a3d0-f8d1-442f-3b91-08de8a30ff9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 1TsRbG50iA9hBsrrXeZlqucXJ24UcFgumDSINU9zJuRvPyHt9zDYLXXKUICGUZOaWK9BS5+9gjRDuM6/pO+b2mJaSm/XTCxH+4Mi83Mk1EzEMjletH5VRiN7TZEOVw8JKP9WRc6KmRaWHU+atydAHa3p+xBg+uTUTlgAzXpFgj8T+4k2GsUBpEWt7v83xhi6UL3dpjHI6k1ke8s9qVkU90kPN0njopzNdhDBSghkaJh/AZO9pyKtm6N2NhD94P/ba1I+pUy1DoJnYch5l7YsAovPCA2amubGUXRvv2dLPS+yR7xo4pVzTC6W5dOExhyvkOv/+g6lyuaaFXhkmJ+KTHfI19T7QWbaayH4QEg56a3bBBeAlKr9+fkl5nVeMK4qrUU/PE4BBO2u6JL0OieRoHFpBjrxADxTca14wcqSsyj6Fh1h/fgj3PT2Mue18ypeMGgrXJuQFLjo3osm6jXMXrRcdAZvrqDO3YelVE7v3mMGSIBHldkTfGOjSy0iy3LwWEbtbXrM53j1buF1C0fjk37BlW4nMJLcl/iyoi67TQ8yWUU1wix/LfC3ryLuzOa+fhLR1ur056Ts6li287+KY45emMgYhE5dEj+rdGYrvYd4UBpBCfBbZPDObT98ycNFL4UGtI9w9V7ueoKeVpU5bxWiz2CwX8yNkX+RaaIP5vL42WDLIUL/WCENjzWxmrBDDxopf9BKb7MTNYYVzZmYi2txwIeeVo8/og8NvUYGqpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlQRHJ6WDZSQmNUc3RBeDRraFhkZGlhMHEweDRuRG45R1FzdzRFdXNCVXhF?=
 =?utf-8?B?NXhtUVBheEtrZW43TlNLb0hzeTVtUEFyYzZ2Nm0rcTBmaEdZY1RhT1hMN2FQ?=
 =?utf-8?B?dWdwWncvWFJDRWVCNTV3N1FGdmFBblJ5VXFmTDJROVNCZDlWb29SWjJlUVBK?=
 =?utf-8?B?ZlZhNnZnYTYzSS9CRVY0RnlKUGlvcjVueVJPdFFMNkNMRkJKa3ZRTmRzdVpQ?=
 =?utf-8?B?S1RJK2ZOblM0VWxNSzFHOTVlYlQxYmJPVTIzTEZ5Y2tBSDJIRUt3S1YrdHV0?=
 =?utf-8?B?aDlQU0dyTm5xOWY4aytqUCtla0VsVEpVV08zRUVncjJyeWRyNzZJM0JZS1Uv?=
 =?utf-8?B?a3BFYUthamZ0SjROZDNRSHpNZ0NiK2MvdW5PYTR0UWNuTU52NjRZMktQemRW?=
 =?utf-8?B?VEtYbW8wb2tQS2dQb2xzei9DS1pUWURpV003enJ1Yi9VN2J5Y3BHOEpkOVpw?=
 =?utf-8?B?NjVLbjRYV3NMaWp5ZDROcXB0TXNhNFZnNjdvNndOc3NmVTk4aHkvUWxqbWdi?=
 =?utf-8?B?NHdTcVRkY0RTVlBvaDc4Z2FIS2xNUUg4REkxaUpaay9HeVp0Qi9mL0ROZ3gv?=
 =?utf-8?B?ZWxHQ01mdzY3VzN3aHl0NExXdU9qR3dISmNLcWxwOVZzRWZaNDJ3UmpJdnJI?=
 =?utf-8?B?MEw0WkNxVUxFdmc5U0FETzdKOVBaRzU0L21YczIwL0d6VkloVFhJZm5YLzFq?=
 =?utf-8?B?WTc3bEJBajJOU3ZvUlpxVFlPN1BOWkRhbmZRdEx5N2hCZDZreHBsZkZ4S0Nv?=
 =?utf-8?B?TkE5dkQ3QTQ2aUdyYm1ZN2xMTmNSa1RIYzhxTDZxbDhrbWwrV1U3UE9QZTM3?=
 =?utf-8?B?b0UzVWdJVW84cC9WR25ieXJPcExNYTRQMU1VVkNrOHUvS2V0dzhDU1RwN0lz?=
 =?utf-8?B?UzVvOUl4RWN4LzhGMFk4eU1lb2JqNWNvZ1puVGhsaUt6WVBsYVZDdlEwRWdO?=
 =?utf-8?B?L3FLa1VsRmRJK2JtOHdCT0g4cXZSQlZCdFdrUEJzZ0NzN1hqZnBndlRjaWU0?=
 =?utf-8?B?Rmc4b3FHck1pZW05OHRJemY3WmN5SGFHSHdvdmIzS1NzdTFpcW5yRk0vdG0z?=
 =?utf-8?B?RDdod21LT2RGcE1rczZ0NG04QUJaS0R1WWl5WHY2YklzV3VLOUpHdysraTh2?=
 =?utf-8?B?cHRrVjJYUVJrcWIyR0hXNElYbzBsM29NTTFVSlNQVkxheEs1Q3ZKL2J0eGo5?=
 =?utf-8?B?Z215QSswWkNHVmhPc01pNDNqSUtDc0RFYXlEUGgzcTIyRldJVWd2bUpNV0FW?=
 =?utf-8?B?K3I5MEYvNnlTN0t4TXA1Tis5b29QZU1xMkNwUFo1am9HQ3FXc3F3dy8xYWMz?=
 =?utf-8?B?S3hpV21FTFdiTWJJQU5kcThIN1YwYjNJS2RJTUloeWdmY0RJUzBDQnYxMXhU?=
 =?utf-8?B?WkNyS29HMWY4OFpzck4ydTRQZktGcUJ1U0liZVEvQ2pQWHdwY0x3Q1EzWW1h?=
 =?utf-8?B?eURTQXhoM3EvTnBwYTlsaUtHKzJaVG5rSjgwQjVUbG0vcUJkQW9mcGl3Zysx?=
 =?utf-8?B?bmxHU2l1OExENCtFck9GTUZON2J0em1WQ0lEeHFHcmNSbG9Zb3hTSDJxaWYw?=
 =?utf-8?B?bUp2TFdqTjR6U0tSN1JDdk1nOEIvQURJRlNDYUY4Qm9TNloycGgrS2ZpTXU4?=
 =?utf-8?B?UVFYUk8vOGdydTlBenhqN3RTVWIweHI3a29LNDN1MEhUYUhGb2pYMW8vdkNI?=
 =?utf-8?B?UTNWYUk3V0dQYWQ4dnpxdUNKdnN2OTBUVUE3Ynp1Z1A3blBYUHlla3pqb1JM?=
 =?utf-8?B?MU56MkRQNVRvNklxRGNWZS9SSmdCcWRyTGtFNDFCb3NTQVUxNmZhTHo5K0lp?=
 =?utf-8?B?c3g4Y1ZHNWlIUTl6eXRLdjVNclF2RWJHUWc5eCtTSk9FTVZnTFFlZ0lUYytZ?=
 =?utf-8?B?NWlxTVVacnhYUEI4TWtaLzdCcTFuM1g4WWhyNHJyL3NTM1BZdnpFb2o3RlV5?=
 =?utf-8?B?NVRaYWRuUXZDOXROekJvOEdCUk1sZUk0VWp2UWhiYXVDM2xiRUNQRHJ1bjhz?=
 =?utf-8?B?cG9rY09ybE9nWDlUZndKYU43UWorb2QzdTcrQm9rcFlMNVk4RUNyRjBMbHdz?=
 =?utf-8?B?cnBoRkM2RlpHQ0V5Z2N3OXhWWExub3JXT3NGeDU2RFVPYVlpU3N2WnRwTms0?=
 =?utf-8?B?QmhLZTRnSTNRNmdmVFRpd2tETVRpeFg2TVJ1UWRkV1R6dWl4cXEycjh3d3oy?=
 =?utf-8?B?Nlh0SmNBdld2RWd6cWkvTFEzYVFCeUNsbzIzZVRHbTRjc0R3QW5XdkE1MmVT?=
 =?utf-8?B?d2VGVFNXS25yVFpJaW5kMW45MndFZkh1VUpraTdGRnpzNUFRTldSaGZXUVdW?=
 =?utf-8?B?ZkRrdXBRc0hPTmF5Ump3NU1pZFk2emJmREtTMU9PWi9WeUNtN3hzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6572a3d0-f8d1-442f-3b91-08de8a30ff9d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:40:18.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7kx7klV+Qnbhkyai9Z5f1lEdNSvjzvQ8XatFF98HwLOkwXDg4C0fZebZk7bSC1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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



On 25-Mar-26 9:37 AM, Gangliang Xie wrote:
> add support to query vram info from firmware
> 
> v2: change APU vram type, add multi-aid check
> v3: seperate vram info query function into 3 parts and
>      call them in a helper func when requirements
>      are met.
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459 ++++++++++--------
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  22 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
>   8 files changed, 308 insertions(+), 243 deletions(-)
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
> index f165d4e401e8..ecb42b304ccc 100644
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
> @@ -1748,3 +1749,24 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
> +		int *vram_width, int *vram_type, int *vram_vendor)
> +{
> +	if (adev->flags & AMD_IS_APU)
> +		return amdgpu_atomfirmware_get_integrated_system_info(adev,
> +							vram_width, vram_type, vram_vendor);
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +	case IP_VERSION(9, 5, 0):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 4, 3):

These can be cleaned by up checking if umc_info >= 4 is available, fetch 
info from there within atomfirmware logic. That may be done separately.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


> +		return amdgpu_atomfirmware_get_umc_info(adev,
> +								vram_width, vram_type, vram_vendor);
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

