Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F058C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 23:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1222910E880;
	Mon, 18 Mar 2024 23:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8hOLR8T";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF5110E880
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 23:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoQdm6nxJC4hTIxWCLzHoz52c6GFH0oZD3FpBmgWSLBpWoNztumomAJPmQ7LPHTaTuEcsA7mJRdMF6hRWsGvRg6zlnTEnbaCValTvH+Ga4J3tXiBiab/dF6qQ6OD198+Zh4bME1oI+Da7fLXC3O/ScUQTaxxXaerg4c5ck5nR4k6b8MChJbXUryWEgPthc2jGCICiBq9d4SP49vKVmJq7WndmeZ8yPtUyql1TwLkiLOcNXptKgupDjWxc8szLIihYNiKOOPUt5Ht13MvOSuBEWUQxzmpgAr+W+9tCnywEG6M2NBU38n8IaIXHpoDNO8aJNcRIHIGfsXk3fOKFBqrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbsaKPUGUmmwvw1gl+vQ5n23BCBpyFnXpc95MAWG/kI=;
 b=RWmgZHHwhpx9xA/Avdxwz0irE8MoMiSRndCR4E5z2l/OMoDmtijluw6ZXdVQZkysqC/yftXzbQI1P77nK3L+AidO3FB3J01sb0haVw+V2aw4tUVaMKJXYsY8LKChl1JDeFp0F53oNx2Tm+gMRBMmZcsW564Y+pnPtyiEBNDs1fe0Wo5/GGRL+8BAX5Oe2lL1Z4z0B7cSqysknEfm6u79NodfiDdBMmPQs/yaUnZvjWTERCZlsce8MTWGcYtLPyCCGfxteq97Gz2SgeCsAn8WQv33xx5hWgWezzsoTgoPgPcAgKHvp3iL1612al+ftNZe36v6ewM8J1HYAGUyn6HD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbsaKPUGUmmwvw1gl+vQ5n23BCBpyFnXpc95MAWG/kI=;
 b=f8hOLR8Ti2Z5kgnGFAwafuBBo/SO/8Q2BsmPa49YlNzXt6MlWsE/s4/UC0QWGBpcdJTv2BBO5tu5OqB2fasy3bKHcENPW8W5K7l6YK998Wp7tY/+zmm6wYmVywWo4g02LrIb+CjkfLvjeemkfgr0q0anZM7N4dDEiZ4n9h2OJ5w=
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 23:05:11 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 23:05:11 +0000
Message-ID: <bf44de6d-4984-4626-a815-b15a400014e0@amd.com>
Date: Mon, 18 Mar 2024 17:05:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant condition in
 dcn35_calc_blocks_to_gate()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
 <20240224063939.1512278-3-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240224063939.1512278-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:d4::14) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|LV2PR12MB5798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2CCKqALE+KZ7mFqEthafZWp/82unJkt7cKLY9s60KVt2M2ka1Rf+EL+Zy7Bu/3X6IrpII3P3vkhBnrRw/UhLJ28p9Wjh5IUjC4oob8Sq3DhIUoppDrdfMVTHCkI4g0HZUwinETmyF1sTQWi5+OozaONhCMffG+vcPVVHaPWT2CcgPjqPsrCiK80EOVid8FPMeXLBlaVk9nlNyUJzYVTdJ4lsEWwGIlxf9IJoJJ5xhdsqgKJ2nAD9T5v2N1CnDNnaG5zlNuYQWMQF1g3CFRSH+8n6AZjiWgdU6RRBTgqM9+NTmymev3Svwp6zSJIEKSGF5THpJ1hs0rtLOumEmzHMFaqlclJo60U+bpEHedUgPTQpAQDqJ9UHTxZ6xE8qqv9nZuAk5e0sF0feEnVRkUvohZ8YnDe43cKn8vZ3lUJYnsi2NqPQxXSQPSdZOokHnt2hHoPKZq7XWnKKkm+BaXyAPZEqj4DsZG8hgLRiCfW2F6wSHZDpwbd/CUw0UwaESusZ8ts9mRZsm3tVtYR5841p6E4RAODFbay2LS4owEwrhXFa16y1MSupqpoT6Wd8QIiwDWrLCHbXM2gIOXzSXykuYKmau/NAYcyngo4e3T+AdIhWDKqp/XRk3DGQGBYZfbIl0U8T7B8JG9g6tJS/qbCo09qqRrhrwvvPHRgQQSoMLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBxanJGYjlSUmVVOUpweDBxT2I3MTV3ZUI3QUdVcGtlcEFlczBablhkWmMy?=
 =?utf-8?B?YzlBbXluVEVQSitKMXYzT1JoQ0hnUUJWNytRcDY4NXVZajNuaDhaT2taNHRt?=
 =?utf-8?B?NGhLZFlZeEdHUEJvb0tWRzNDZXlPVzBzVmQ1bkQ5MFZqVWo5eHdhMGNqVVVw?=
 =?utf-8?B?ZmN4SlB3ZldXYVpGcVM5NUtjV2FpUyttNzNWeUErNFg3dTFBYlNYdkVBdkpZ?=
 =?utf-8?B?blRnSno3ckxaRW9sa3JUT2VscWx4WkQ3a0VDVDkvcHRvdFVmR0NVQlkrQXhk?=
 =?utf-8?B?VVdubjdSRjF3ZFdPSmtVRG40elBMN1hTTlU4Q1hEOWpEZFRPTVhHUk92emtB?=
 =?utf-8?B?THZqNG00NlBIMUdpMDJyUUdDRS9XWk5UVkFuSUpZQlU2L1ZKU3dacUtwVkxE?=
 =?utf-8?B?ZGliNnhDZ3NhT1BCcFJSWWQ4eXA0NjdpU08veFhJcC9ITXpLUitLamNqQlRR?=
 =?utf-8?B?ZGNQMkx4a3FDK3NDUHVxSlROcEVGL3Y0dWM1emI0cndTNm9paVlISVowTk0w?=
 =?utf-8?B?dDk5VHZZQzkvY1ZLTjcvMldSMi9GUlBHTFJnWFpPOU9XbXhyZWptRW44Slli?=
 =?utf-8?B?ZU9wZ2R1Qk9lUEw0RGhIZTg0a1AzVHQ4dWZVd1Y1ZUk5RFNiYzRsdHk0VTVE?=
 =?utf-8?B?eXplSW5PTVptN0xqRHlkYWxDTUdRZmIxdW45cnkxWGQ5bHlibUtFYTJwTloy?=
 =?utf-8?B?c3ljZlZEaURBSWgrdk1RWGJaT2FxcnNucnFBTzZBTHlOWTQ0WHZ4MC9neUFp?=
 =?utf-8?B?VHB3QXBHSm9IY1N3NGhQclNYSFFBNEJ3Z3JlS3NJTlhib0NmbEdUcWpCS0RB?=
 =?utf-8?B?R1ljd3B4dFlHZ3RCTzJVUDh4a0ttTnlYWEQyZnY3UDJPVTNmZFo2eHlTanFX?=
 =?utf-8?B?OUFKb2FkRTNZZkRnYzJ6VFV2bzlQUi9uaDFlWmdvN1JLZGd0Q1dTNGRJTG12?=
 =?utf-8?B?czV2RGpXeWFiemFTZGdyOTJPUWpWTm5kL2ovYU9ubVdTUEpma0szQ245SmY4?=
 =?utf-8?B?aWtGYUxNR0ZjNWVEQkJGZHhzS2Q5Q295WVhNS1VvZ1VFaFkyekdRR0ZsQ01J?=
 =?utf-8?B?dkgwVmM2bFBRTE9LblpzUno1dVlLRnpZa0x5TkE2R1BzVTUweDdudzJoRm9D?=
 =?utf-8?B?UnBVYWtZYU9FL3N1Z0hiZjBVTFN2RXcwVkFQSnN5STIxOTUvczF0VXZVWWRq?=
 =?utf-8?B?aWN3K0VMeXZHZTVyWGJuTE9jR0MyK1RMTzFlWHFpVVJZTHFuMTFPOWtjMmsw?=
 =?utf-8?B?dzVoWVRpVzgvYmtiUXhIYklBN2pVLzZOKytsOGZOMFlCRVlGWVdFaDJwNXRP?=
 =?utf-8?B?aDlmdUxGRGh5alBXZm1kTStoNUloOGZ0b05aMmxScEZiSTVRKzV4cVUwYWRC?=
 =?utf-8?B?MmE3NWFsalB3RDNDaVQ3eDgzQ3lscmkzRGs0VC9iR2pTaEJzd2FmZTVqVWNX?=
 =?utf-8?B?RkJWdnlKTzVnMkJEUXV5V3hWSm5VbFpSakI0QjhFNTVhWjBORHRzZVpyZlgy?=
 =?utf-8?B?LzIyZmZnTlVjM3pCdGVsMkhwLzZIT2F0N3JSV0dMcTBJTTBvY2RxdTdmejJK?=
 =?utf-8?B?Q2pXeWMvanBIVXQvU21UdUprYWI2SHkvSnlsQlg5SW16V2NsYUFpa1JtNlpY?=
 =?utf-8?B?SU45OGNQdnVkTFRSN0VvQ0ZDQmV5NmhMNk1XT0VzMGFsZ3l5aWJockpnbE9H?=
 =?utf-8?B?Y25Td3huczljbW1xekRIaFQrYTVCOG5RelRwMTdoZjROVzlSa2YyNkh0Q0tu?=
 =?utf-8?B?Y0UybDNMZUZ3OU95R1E0aHR3L3U0WC9Zem11WVEyamZxVVVoVkF0TEU2QUxl?=
 =?utf-8?B?amg3bDYxeVdtTGU4aHoxcTVDT3ZZNzR2eER4eFBlS2hHWlNHb1JkeUVkWWNu?=
 =?utf-8?B?eDJTNkxMSDN3YUNmdXB1K2o4bTR5SlFnODg2clRxOElaLy9pWWJuZ0U4V0JN?=
 =?utf-8?B?U2pUb1JDK0FxdEpLTHNQdjB1dmgzajVkMWN0NHRhY01FdFJCMW1SSXB1bVNX?=
 =?utf-8?B?MUVMcFYzRGxjR0RSTG1paWFjRWJiejZoSUdxQzE3WGtZdWx0WXUwODV3N21t?=
 =?utf-8?B?cDZVVmw2M2FlbTBsQnZ6Tkk4RHJvM2tpaXR2cDJHeWU4K1h3RVpHOFVaR3E2?=
 =?utf-8?Q?r3spn0XgjsNffeW5P0HxayO6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd2366f-11da-4950-4913-08dc479fdd07
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 23:05:11.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUBkE8esWz3hCOd5/HPYJm5FQGpv/WSrHzy1aK0ZUIhoZkvVyIgx4dz3Jh5YQEJj+11uurLSj8vsRDrdFP+Y8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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



On 2/23/24 11:39 PM, Srinivasan Shanmugam wrote:
> pipe_ctx->plane_res.mpcc_inst is of a type that can only hold values
> between 0 and 255, so it's always greater than or equal to 0.
> 
> Thus the condition 'pipe_ctx->plane_res.mpcc_inst >= 0' was always true
> and has been removed.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1023 dcn35_calc_blocks_to_gate() warn: always true condition '(pipe_ctx->plane_res.mpcc_inst >= 0) => (0-255 >= 0)'
> 
> Fixes: 6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index 4b92df23ff0d..3dbbf6ea2603 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -1019,8 +1019,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
>   		if (pipe_ctx->plane_res.dpp)
>   			update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->plane_res.hubp->inst] = false;
>   
> -		if ((pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp) &&
> -			pipe_ctx->plane_res.mpcc_inst >= 0)
> +		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
>   			update_state->pg_pipe_res_update[PG_MPCC][pipe_ctx->plane_res.mpcc_inst] = false;
>   
>   		if (pipe_ctx->stream_res.dsc)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
