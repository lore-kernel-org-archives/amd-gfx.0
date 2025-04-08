Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D969C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 03:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777F110E1F3;
	Tue,  8 Apr 2025 03:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfc1u8Fw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A78F10E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 03:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxteYAw/+tObAEUXwB4ktbLPht64v/UCkmF0CH3yvDrOwFaErdCKJ4uQcbao7xy0V0zIvOyG8S10D7RbNb4kwTrkmAopX+Ro/ie1pvvNbv7GebfbBsG/EFwej5eFNEaLqKwoA6YD53W9m86YLqa8ufzEOKQiQMiYsE22x0h6fTeKOsxwQeCZskZ6NORfqjCMatyXB0BZVpIpn0kTQAk4S0Fb9Fr908PlJn3HEHkPwrO8pi7PkjyzEUCEzA1AyySIiPkIDSdPuP9wrZD0OWxplKWhPrzpIMO/YEyiiWvtI5uD63MV3zfP6txDwb2RobPbJn28PJMqytWOkwfahhuJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNonpLYOHU93Fzz/pnCwoPGeX7ZI5yikLCsOMuSj2PM=;
 b=WyM17nZXbrJsDpo98UjQDX6ZW14QARJFQfpmZfTDbT+wg/Ie2bY2hV344+Z5fKobRe+qrDsMwhoGloxgp6YaGdLtgOQsRdiwwWYLEPCZFdhp8APYWf79W9bL08QfS90pMIJvHqUT1JBUVBAttvjv7vV0c6BAM2PXD7W2zy7d/0tF6aQRoSu5oejKTWktfL9GcWTnb6PX9YBOEkb7CIzvA0g9OIxYp5FZ+qHsBDjNx07rh9HRc9UhY3RXzbHS+3JFHfrYuCORUkqcxljEWvnKbR6Z7GKJfq9aZum87av/TQhgIvGxUqVGwQfGjzQJKXiSSjJ4g12EAGvf7Uhj0HBg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNonpLYOHU93Fzz/pnCwoPGeX7ZI5yikLCsOMuSj2PM=;
 b=dfc1u8Fw4ib3KzTsY5jC/A6wx4A4tR+LeqKDajT8CILCleSBIkR42gat+A+FpRK65125VxEddOjk5lgEG8iFj+I61I49iJrHNp+yZOYp8cMJ+fZdu9mSJahx8+rcOmIr4NGtw/0xCiI8Qk8JZO0/CYzbAte3lgpKG9DPNjs8wok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 03:58:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 03:58:50 +0000
Message-ID: <a01b6e24-96d7-4b8e-a29e-0731371b3679@amd.com>
Date: Tue, 8 Apr 2025 09:28:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on
 IP v9.5.0
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20250403094355.1866897-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250403094355.1866897-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fcb107-6355-49a3-d3ad-08dd7651ab68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1djbjR0Z2FBalJkQjVsYXEvVjcycmUxbkwxSTRWS0xxd3FVN3pmNWMzbitY?=
 =?utf-8?B?UUtObFNaZWc3aFpwMzdqNG10RHFXRFhBMHZhVUZ2SmNabHg4eHhjdjVVZEJj?=
 =?utf-8?B?SHgwclFLV1RtRlNUcWtaWDVoNW5pTjI0ejZTOXJBdTF5N016NVNLWW1xUVBT?=
 =?utf-8?B?bGJHWGgyMnQxaFJsaHNySHhxQk9tVFlHS2NOeWNhYWltSkJKSHN6aGJvNFd6?=
 =?utf-8?B?T3lLM1JEYUVRU0NRYS9ESmMwK2YzOW9lRGs4VWpjSHFUaStzZmd0cHFLaFZC?=
 =?utf-8?B?M0xtRDMyTUdwblhEUVkycUtYaEJHQmxxZ0thelpFZ092K1cyTTF3RTJVekdj?=
 =?utf-8?B?bEdxc3hnRGtMbW9FT2lPL2dwVEhvREhRYjdYMlIyaVZzMGdsVXB5cjZHVUJT?=
 =?utf-8?B?L2NmcC9MVXNaMndCWWFqWUJRTVUzQVZZMzFzUXdhMU1Zbk1WdUlpdkNkbldz?=
 =?utf-8?B?VVptRlJXOUcyZVlrZ0tJYys4VVhmQWI5YmxTNERPTjdUbVpwV2JxNzE1dzRP?=
 =?utf-8?B?UU10em11ampKSE1RQURYSXdBUzRZd2RkYjZ2ZzZhSWtHS2U1ZzJ4b2xnYjQ4?=
 =?utf-8?B?SUdQZUkyL2tYM0NSRnl1VWdEWkRhSXJMSEY3SWhDelVFOUJoeEVmYWhVQnVI?=
 =?utf-8?B?RDZiQ29RS3ZOdXJSeHYva2V4SHBEM0RFMFc4NUxwbEJwTVdXTkwySkxOKzUx?=
 =?utf-8?B?dW5nNkU3dGc4OENENkJ2cjR0cTVlNFRuQmVqY0lYOCtIeW14YXRFNWRtMGdm?=
 =?utf-8?B?My9CMjZDbGNhNFM3SE9icDR6UWZJTFd4VS9HNHh0cXE5TTlPa212d3RXQkg0?=
 =?utf-8?B?dXh5M1k5b0sxOXdoWHNsRHM0UlhUa3hKUm1qLy90ek1QU1JZaWV5aVlmS3JT?=
 =?utf-8?B?OVR0MVdINVptMzJzQzhtQzNFb09adFhwWTZKa0RJSytEN251NlFoUmpBN2RF?=
 =?utf-8?B?UGtLd0FLOHpZellnVTkzQXE2VUp6Q2J1VUJqd2phZzVLanIyZEVhR2N4MjFn?=
 =?utf-8?B?dGw5YzhSMDd5QllQcGRza1U0QXY2c2VXSDREZUE5dTZrdHQ3VEg2L3ErbTdP?=
 =?utf-8?B?VTg5ajZEVW5TVGFvYWZjVTFneUtCeGYxSkF0dGZIQlphWTRSZVBjM2RQa3RK?=
 =?utf-8?B?Y3ZQbXkrVUNGZ1V0Y0JEbXZyZkxDeXFMS240Q1J1Zy9zVmVMZlc5SWJ2QjZC?=
 =?utf-8?B?WGkvY1FMSEt2alpFeHNxYmt5elphTS80YU1OaWdBSjcyTEU4TGZZRTlDaWox?=
 =?utf-8?B?b1NrTEVpZEkrVTJ2STBSa3pHbmN3UmIyVVRNTVRsajhrbXh1aFdXOTVocmZ1?=
 =?utf-8?B?b3lQQmhQdnptSjY2WndEUUZnVnNEdjBIT3pJOTl0bnQ1ZXBvV2c1c255Rzkv?=
 =?utf-8?B?aWN1bGRobldiMWlrc21SUlBOMlVvZFduSW5mV2VBZWlEc21aVjlPaytNUlVy?=
 =?utf-8?B?dWdVWGhLL1ZvUTRQQ2xOcWVFOVh5K1VQL2Z4T0Z0NGZ5dXArVzJZN3J3dEFK?=
 =?utf-8?B?WUZ4MHByZ2dtcFoycUcvZzJla1VFSlNjR2EzY1FPRk4zc0x0RnM4cWpxZkRQ?=
 =?utf-8?B?RGlhM2NicDRSaE1xbUV4b2tPODNZdWR6b3A2c3JDUGlmSDZzT2JPUUdmci9t?=
 =?utf-8?B?eUNjU0E4OHJkRnZWU2FaV1ZhSDFoUld6WjlpNnlwN0l2R2ZsbnV5UDNPcHpG?=
 =?utf-8?B?K0tnK2RQWTZoa3B4K3VFMDc1dmc1V2NQU0FyeEtWakdMWHRDbWpDcEZFb3Rp?=
 =?utf-8?B?ZGhSdjVVc09TTlFRRklWMXVsOHRyaW5sWWM1Y2lvSk9RbHFjbms2d3lxanBU?=
 =?utf-8?B?emNjWGFCVGtyVWhWdmsxV1lzSVVlOUV5R2VOR0M2VUsxZGpnMm1JaDN0VWVt?=
 =?utf-8?Q?K4AEkhLszAlol?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnQ0bmE3S21iZ0RTRUJ6SnVyZkx6QW1La3RSN3dTbWhoMG8xdGpoQWJraTNN?=
 =?utf-8?B?ckc1dmk0bnZicXByOStUc05jbGlhZFN3MjdyUUNCM1FvWEJ5TGYvQU9RdkNS?=
 =?utf-8?B?Vk9Ed0tTL3NLakxrbkd1OHZiRXJzQWc0VGVCbG0vVXAyTjVXNHlhellEVXpL?=
 =?utf-8?B?UDhZTzNLS3lJamdFMU4ra3VKY2s2RkhsekV3bjRpK3IrSXRORFF0K1VlYjRj?=
 =?utf-8?B?N1FEOHRVRW92cHhIL3hVOVM5TDlCRmpLTytPL0l1YXRIeTZjRWVPQ2pPVWNC?=
 =?utf-8?B?Vkt3cG9lTlhUZkZyV1FRMjlaTGVNYXF6bTZmQlNjUjVjYUpaR2dPVk15M0Ri?=
 =?utf-8?B?TWlVWVVjcktteVRiKy8wR0dxWWN4MGtJR0lCbjVPR1BGR3pkSUw5cW4ydmNv?=
 =?utf-8?B?YlQxekNoQkRkZm1oUVNZRHFiSlo1MXRhdUlPTzFia3JWeEIvbzlRLy9BN0ZJ?=
 =?utf-8?B?NXpCSVdaOFdVeUt4c0xOTlJuVE9oT08xMXVibndPNFZISGU5VTRPc2hOTG53?=
 =?utf-8?B?TkxaekFBN01SZndEM3JDTWszeUlFR3dhTkJxZVp2L0JIZjBoQlFoZXZRRUQ0?=
 =?utf-8?B?U3h6VHloYjRoK1pyMUpZaVlYNTZySStQWFlRNDB2K1MyWE8zVitRbmlwbHpn?=
 =?utf-8?B?Tk02S2swZ09BYnNrUVkyWko5VzZ6TXRJNGRuS3gwQ1F6T0tDdUJ6VVdER0Zw?=
 =?utf-8?B?TDloNzFneXE3WWJjNnI0STVwbFQrT0MvOHpucUdVSTRDU0I1eFpFSC9XZjJt?=
 =?utf-8?B?YzhHcWVoVm4vbjMwTGRlK1VOSWNJOGFia1lSQThScHpQUVJmdTllU1M1cGxZ?=
 =?utf-8?B?LzdvRDl6YjZFZ2NqaUV4Z3VKZEVGT2NpdGRFS25yU0Y5SjZIY0hnMVE3NG1Q?=
 =?utf-8?B?a0F2alFCVkFDZGtPL3gxcTIrNUZKUFNORmVzTTRNOTBrbDM0ZkpjNjhpSTdo?=
 =?utf-8?B?a1dQY3JRb0N1a2RWU1NKSUhDazRqekZDQ0pqbmFqQVdOSEV3cTBIM000SGI1?=
 =?utf-8?B?Z0kyYmhMTzhrb3FZeThMa2VSUElqL1ZsL2ZtY2xQcDA5ZmhMQVY1MlJwZW1o?=
 =?utf-8?B?U0lZZ2xZVGs3c3lQSnFEZG9GRWY4MDRrNU5UMk01Z2RsOG5vMTBqSjNXUVBT?=
 =?utf-8?B?aTMyWVo1eDhlR21jOUxRQ1NYMnZHd2M2MnRRWVF0V2dhalBRd3BhK2QvZWpk?=
 =?utf-8?B?VU9SaDVZQlFZOE9wUWdkd3J0cUF5dHErcWFWdWZYUmdJcnkxUllQM21xVyta?=
 =?utf-8?B?ZWZOa0w0MHdqayswSDlMTGVPclhNQmJWTmJSOXpvUEZSV3FoNSsweWt2VzBy?=
 =?utf-8?B?UkErMGluOXI0VXdVelZ6WG0xWmxYTzAzRnU1Z0hUK0FyMGlyV0loQXBsQ0F4?=
 =?utf-8?B?MmlVcU0vUFpjVlBhQjQ1OElrb2o5TXpDSUs2VnFxWER1dG1qMFNKWTJZNWow?=
 =?utf-8?B?akJmUStlOXU0WmtkRzFjQlIyeWFUWU1DZ2RrYnZXREtvOHJZNXVZZk5kZWhj?=
 =?utf-8?B?K0JuSElBVE9QS2dwYmxnbEZNbklvaHk4SGdBZWQ2dGI0Yk9BWTNJbjJyL1FP?=
 =?utf-8?B?LzU3SS9mY2JtYk1VLzlRTWVXRmNncGZKemg4WHdkR0tPd3Z2ekVwazlVYXBR?=
 =?utf-8?B?djhwYVh1VlZFUm4xN2FnZU5IOFZFakZuaHdNU3FQMjZ6cnBWeHlDUVZkdmVr?=
 =?utf-8?B?YXFxblJvOEhlUHVXZmZER1Q1Q2dKMFUzMkM5clpQOU1XNlJMNVROa1RWejFP?=
 =?utf-8?B?OUFNSDI0QkVOS2x6R0M5dGVqa1d5WEYraVdCRG9aQkh6R2VaSFRMOGVGT3BC?=
 =?utf-8?B?NE5QdGwvNXMrWjVyOHdvaGZHbmJ6ZDI1bXp2VElqY0FUaTBCc01rd0g2MGFV?=
 =?utf-8?B?S05LcVRzUnRMelVzUitEVzFSS0I1MitoaU9WdWt5d1luN2ZGRUx4d3prd0V1?=
 =?utf-8?B?cWFISktBeTdtRXkyZTM3dWsrY0RaSEpuVHBxN0hvYThTWjczek81clMrbG9x?=
 =?utf-8?B?RmVpWmF1eGllNlNaZ3V0QjVnZjBRYURlak5VVmh4emZsdlcydytSS2c1Z2Q4?=
 =?utf-8?B?NmJhY2p5UUQ4SU55b3htcDJKNTFQLzRsL0dPMXhSTFhRcWgxTTkwRmVsU29p?=
 =?utf-8?Q?OseBjHGpBnS3jry0gJ8Qab7Zi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fcb107-6355-49a3-d3ad-08dd7651ab68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:58:50.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGZyL3VkKnByO2VYk4k/gxDCN6OYLLJQnmwoHrWgbqbijDiFFAGt89jsE4u9vVjg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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



On 4/3/2025 3:13 PM, Jesse.zhang@amd.com wrote:
> Add support for per-queue reset on SDMA v4.4.2 when running with:
> 1. MEC firmware version 0xb0 or later

This is not correct the version. Firmware team mentioned Rev 15.

Thanks,
Lijo

> 2. DPM indicates SDMA reset is supported
> 
> Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..9a2a5eb93763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2373,7 +2373,9 @@ static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	case IP_VERSION(9, 5, 0):
> -		/*TODO: enable the queue reset flag until fw supported */
> +		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
> +			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +		break;
>  	default:
>  		break;
>  	}

