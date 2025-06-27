Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B3C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 16:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D62F10E06B;
	Fri, 27 Jun 2025 16:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osWnaghN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DAA10EA39
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 16:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4fEQVT932sy5/1KqtVzL4fAtkQoQlLqN1dhtoD90K2kbz3yazLSLusFFnxS9nX9WnkLfUPdWc9QAm0Dlm+FPSAmR/j3TRG6cT+y44rw/3lKJYFmHCs9zTJid2y9SsheVZd/PepSCsKnodmOOUeNs4CmgLNrbafKxzL5jA+neALXO1lruzLSm1d2gctBfK/moCuy2wIrvTiELc5cwFyC+1uTldAT8fVXERGBlTlrAxmvNBRsl6c86O/Qs4VQHgqpYsT7qFFM5n3nZzHs5D97pD1odB0lFDWDHzc403ViwKm2r4ber0G+aJUDAedpWF8P0tpFqaG4ViD9Ykw1ZJVctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgPQlh/Y1c2G6jyTKXuhXgYTwEERpmDF+sa3mnAaW/Y=;
 b=cB7lw8vqGpUO0czwV8GUC5hVPRgTzP3D6Dvf1ybRuS0e9oneLFgpwaocPDUPAL/jpaKX5nuC5bZlSXuEQfp/PpaaNNG+s9eMVNyL60dWoYl8xdZzq7FJJD3oTH3JGYJvcj9W5XcxxrQfvcZB4asPbRv4TmpZytZhliUuI78vQ3fbkSu3bzL/XxWKiuSpdB9NvExqpZMO83J/JaCDWhSOTXpp1JND1sXRY+88UIyZxBO0jHz+7jsnJSTIb3GeAsDo9qFfzUcTa1WrwyhY/xllrH22S9Cv28QY6bHM4Gl24W2ThSak/h7oMKg2O7awjo8bkUUozueQHQTAjqckAurU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPQlh/Y1c2G6jyTKXuhXgYTwEERpmDF+sa3mnAaW/Y=;
 b=osWnaghNU6CP7a3EdzpX2v+C0MIuxxWL1w1rytQI6biNMRVLeh92ITktxpyCsmff0+JkoP2vn0n8ENcVDIoYDqNfUt6ogrhqXX2p1SrHeznExO8EPDQbuc6Fz2ebzTSWHdCCGyl5xv2FBLoIB2t4JsZCi+1wbHbRjxD9Ko060nY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 16:38:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 16:38:20 +0000
Message-ID: <3b1dff7d-06cd-4f82-a7d1-b8aac8c1467e@amd.com>
Date: Fri, 27 Jun 2025 22:08:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
To: Meng Li <li.meng@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Cc: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250624015254.1162196-1-li.meng@amd.com>
 <20250624015254.1162196-2-li.meng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250624015254.1162196-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c59b22-768a-4f12-82b9-08ddb599067e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnZPTllpUUluV0tqSmVLbVUzUXh4TllCY2taQUlVdW9vejhZbTZZZmNCTDRv?=
 =?utf-8?B?bzVYTW1sK3UzMnAvaTBFa0c2aUVVZ1J2aHI4MmoyQ0s0eWFwUGorU29OU3Fs?=
 =?utf-8?B?dGRxaXFTalNGMzBYTnJCaThSb1dUUEJWK0FialdrWGNtSmFYcGxTNTJYd3RP?=
 =?utf-8?B?Y1dvSXlDd2x6SU8rMkQveWUrMUJzdlM1OHNqQlI3Z3RKdllQTGhqZFZVSitD?=
 =?utf-8?B?cUpTU1lBamk1WTNnZHVaU2M0VStzMkdDbkRDenMvc3FhR3MvUVNIYW5rTWpi?=
 =?utf-8?B?Ylk4akNqWVlDRkd5TWNoeCtyOVk1UkRaSVA1M2xGaG9GWXAwSGJrTnZmbWh4?=
 =?utf-8?B?UjNRdG50UGxqa04xcFZDZ1prUW1ZdDJiaHNrSFhCMmd3ak9McUh3NGwxTE1j?=
 =?utf-8?B?bHNFemtBLzBlV2oxQ3hxcmRpU1RDQWk5NC91aGdzd3lKKzMxVlJMOEFhb0M2?=
 =?utf-8?B?NUtNTXVjbDRLQWt2TDRVMmdXYzhNY2ZVdEtKTU9xVG1YZEdKMWg1T1dBeG12?=
 =?utf-8?B?VlFRZ3lVZGVSd0czMDdrVzBLckhlb0FrYnU4cWhjSHZhSjU2NW5XZjdmSXY2?=
 =?utf-8?B?R3RqN0s5SUFBbC9JSVFNWTJlNFRubU5ZQjBXWG9VSFBWUnZOSG9iOXpGVnFJ?=
 =?utf-8?B?WEtITDIyeW50SWJFMjh2Njl2Vzh6NlYzQTdEUDBsZTV3QjZTM3MwWlVmU0o1?=
 =?utf-8?B?Qkw1MVRndkJ1VW40Q3hYNjR6Rnd4cXBuaGJDeFVyc2NITjZ3SnE0NE1HY25J?=
 =?utf-8?B?Mk5aNlhDdzFJa3hnMHh6b3ovaVQ2dEJUUm4yVk9tTXpRdnFFWU5laHZ1TnNk?=
 =?utf-8?B?RGdjYSswRExFZUk0YTlsY1RGUlNFTjNGQ1ZzSHA0QTBCNkxOMXlKbE9qWXFn?=
 =?utf-8?B?bEJvcjg3N2QzaGZMV1dSOVoxS1BGS2lsMzNjckt1N3NORTZjbFdBdDdVczcz?=
 =?utf-8?B?eWNjRlVEQVdYUFlmbTliVEc5NFFVQjBoZjlzU2d3WitOYzg2TmJVN0hTQlBP?=
 =?utf-8?B?c2J1bWhLVVF5bWppTTNrY21aeVJuYkdyOUJialVnRFIzbkdENEVxR3B1NGly?=
 =?utf-8?B?NjlsWTEvYVN1QWgwdEdERU1UdmtZU2xxci9NZ0VoNGlYdjFxVWdIZTJpYVh4?=
 =?utf-8?B?NnpiaTlGUXRCcjhOMkp4V0lYSVBVWXlEZStyUXEva0dhaHl3NUxxTUVNKzBy?=
 =?utf-8?B?ZUJsVDd2MnZNQmV2em9nY2pLb2RxYTdneE5OWnp5OTVBd2I2SnJPYU96R0s3?=
 =?utf-8?B?OG52NWpiY3EyVGNIczZ4bHNxVXg4cVRYblRSSlAzankxL05heGpDYTk2Z0xB?=
 =?utf-8?B?WGRhSnVJbkJhcEJuV0tMNHVCRVNWTEZxUFdpZGc4VDBPQncwZkpObkdpY1FC?=
 =?utf-8?B?L1hTMkhramdpUHpBVW00Qm14TFdqYmM1RWhkSjF5TkZSME0xTkdNM3p2OE9C?=
 =?utf-8?B?cDk0bDVvdDFlcHBsZTJyMURpYXJlQXBtOVNQaUV6L0N1Z1hKTDhLTk4vRXB6?=
 =?utf-8?B?d29YRkFQL0RFMlY5TjU4QU5hd1FTVUd3dFAwNU9nYVJhRUtrVTF0T3F2MitI?=
 =?utf-8?B?QTRSN1BQM2dULzc5eVBvSkY1bzZFa1JQaTJZNDNUejEvYmt5em9ObVpZMGdm?=
 =?utf-8?B?TEJlRlZQVEVlQzhMWm9QbXVXS3N6T05nWUxnemdndFlIc2ptbExGVFZUTDA4?=
 =?utf-8?B?eGNJNlV6S0NhTldTT21OVWtUVGNtRG5abmc3bkM4VUpVQjdCSVd1Vk5uUjdH?=
 =?utf-8?B?RlZ3bVFud3Mza01FYm16M3NQNFB4WDl5aWNJcGF4Y1hTYk9PNDh3bSsvWGla?=
 =?utf-8?B?SCtTNUJ4YTVrbXdvZ2hVMy9xa2owMkROaTlSUHBacVFEbS8zVndyMnRDdU4w?=
 =?utf-8?B?UXJaaVQyWGh0d2MvcGtUQ0tsNm5SSGE5a2NpQU80UDlPdUNuZURNOVpXeVNT?=
 =?utf-8?Q?KINZUxsewJo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnI3YmxpTE41S3AzSC8rV3IxRkt0LzBTZjIzMUdJY3NUQURabzlKZXdoVjcy?=
 =?utf-8?B?b0w5VEw0eEFqcGg4ZCt1QmtVTTVYSGZZSERXV3VveTlZdW5iYWVDQWppcHA5?=
 =?utf-8?B?blQzSTY1TExETTExMnM3Y05zMTlKNmMrU0FqWVd5QUhsSjJub3ZyazFERkZX?=
 =?utf-8?B?czcrbTBYTjErZXMycWgwKzBudVNFTWx4MkJXSlhnZXIzT3UvTXhQenRwMTls?=
 =?utf-8?B?VjRLNmhmS2RqVzlxM0JLRnlva01VUnkwcmplV1JScG5HTU50aXF0SlFlaWNJ?=
 =?utf-8?B?aGZFR3lNVkU4U09RZHVYVWJ1U0NpZVBRblc1NGlCdkR2eEI4MmJqMzRRc01t?=
 =?utf-8?B?cytZSkliU3E5c1BrQnNCU2RYMlNOV0FRNExsRTFsWVpNREZtb3NsMWt3Yjdl?=
 =?utf-8?B?dE02dmtwOU00R09kSi9zVXlIZ0JiNXdrNWJDbksyZEJNWTg1QnJadEVJTUZL?=
 =?utf-8?B?N2ZLT2Z2SzVidDVuanNLYTRXS1hSaWRjaFJTQTJOUnF6QnJEeTd2azl2Wmt3?=
 =?utf-8?B?UHZaMGpwYXZpYUEzM2N5aFBlUmE3UzVsRWVLYVAvWnNkamZIdU9OL0FPcFJE?=
 =?utf-8?B?U0Mwd3F3TjhaWElmVnROMDlpbVRjZnVaTUFYWUpRZko1QlNaeW40UE4wM0sw?=
 =?utf-8?B?VFFiQlJLNjU5QzJwd2MrWDliUnovT3Z1NVJJNmd0VEtLTlJrOU9pNEtZQVZz?=
 =?utf-8?B?bURkT0ltaUNDall2K0Q4VzhWZ3VGS0NkT0RGM0NGVzRKWm5kdm04a1A2cmpP?=
 =?utf-8?B?bGRJNEJWSmtEQitWRVByb0xhdmpFTTFvUGRrYjF0OGRSTG4vTDIvYnlibDgy?=
 =?utf-8?B?WGNsMGFSR0E0THpXQXF2R0phL2NHcTROeEZIR0hlb01jZEdmL2JLdncxaXNt?=
 =?utf-8?B?VUtnTEN5OGVjVnBWTG1PcGxHVG9kc3RTMTUyTHRCazZxYTlJRTZ2UDVEWEVI?=
 =?utf-8?B?TjUxVjdrbERRcmVTSHpnSyt6bDdpdHlLT1djNkJOMzMvU3ZpWXViQ2lKK1Zl?=
 =?utf-8?B?WXBBY2R5d25SVXdRbXZVc2FDTTYwK2oxSjVCVXcrZWIxaWF1cnRESEhZdmR6?=
 =?utf-8?B?Y2k2U0NWbzJlcE5mQnpzSHVBRUdvTnR5VHpNQzVoT1F4ejFvNldHcmNMcHQx?=
 =?utf-8?B?eUpKWCtKTlBPODRoYllsWEREWlpMb0VydWl4ai9XdnBZbmw1dXdWNlRFZVVt?=
 =?utf-8?B?eDNobm53eGhRRGtFUXpMbXJUeElQRHYxQnMzQTZkUGsvK0VYbjdrVlQ0U092?=
 =?utf-8?B?VFR3aFZUdG9ESE1aTlFPWWpVa1ZiZTB4THV2ZUNhRlM4QmQ4ZHJGRm1kendV?=
 =?utf-8?B?TFUzQzgvdWl6L1hQUDhCVVdLVGJ5WUFoY0hQRXp6RE1lcmlya3J0Y0pkdXFN?=
 =?utf-8?B?OFJFTXlzeTRaMW5WSXZZV1pUTE5Tblo0dUNHQ2E1anpBV1pEejNMaGNtSDdE?=
 =?utf-8?B?dHJmQVRaVWtWY1I1dDhUTVp1aCtCTng3ZTEyeHVsa1V6VENHRHl5emxMa0lL?=
 =?utf-8?B?N29YSXc4amtyYkdiVzYzc3YxTS9SZnQwMklUQk9LNE5SdzVvbE13dGg3SDFB?=
 =?utf-8?B?SndPTVRhdm84WXRiYVNNYytwZlZESjYxLzZESWlCN2E1QS8wQVpicEtkVlg5?=
 =?utf-8?B?Y1hGc0MySERRbWtsZGxjUkhJd1dteWlndjRMZ2VEM0EzN29XU3JKMWx1c3ZL?=
 =?utf-8?B?aDBreXQyODJNc01FdG9DZHFmYnovYTZGRHNmcXAvTktxVVBrVlVRR2Myc2Nh?=
 =?utf-8?B?Q09xb0szUDBrTlhXa0Fmd0V2NU9rdEtiYUd1MVJHWEd6dTJMcmZuaUpnNUEv?=
 =?utf-8?B?elVINHdzMzhzYUZQWFNDS2d2NzEyOURMeXBWY2lNMmFDbktEVHZ1d0xZL0hJ?=
 =?utf-8?B?YlFKV05PSlNyT2hkY2o1NGxUZGRKSTdmRkhLRzFpRlVCa1FWZFBtZEpoYkVj?=
 =?utf-8?B?VWZha0tEWGFJMExQdFJQZjhvb1JSMDNXUVhNWlVkS0lhS2J3L29TbjM0K2dK?=
 =?utf-8?B?L0xZV2dEY0tFU3dXc01Oa0JkaklzQ2ZmaVd4WHI1YVkraTMwMkJyWllycUwv?=
 =?utf-8?B?T2krcGdHZWVmbXRoV3Z5a3lLVVBHTzdnWTNkdjVZRkprM2VVME1EMVBvTFA5?=
 =?utf-8?Q?LgkBRAlC9cMd3OUwNKBnH6H+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c59b22-768a-4f12-82b9-08ddb599067e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:38:20.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxwhWnWfMaN9CTTBq8yWinmTeciRSLtna7BjHwJ6Z9U0Kpuixfxs+8IcrWE5MBlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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



On 6/24/2025 7:22 AM, Meng Li wrote:
> Add a new API amdgpu_xcp_drm_dev_free().
> After unplug xcp device, need to release xcp drm memory etc.
> 
> Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  3 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 322816805bfb..70c44961af95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		amdgpu_xcp_drm_dev_free(p_ddev);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..3a8f3dd19a12 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,29 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, i;
> +
> +	guard(mutex)(&xcp_mutex);
>  
>  	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>  		return -ENODEV;
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if (!xcp_dev[i])
> +			break;
> +	}
> +
> +	if (i >= MAX_XCP_PLATFORM_DEVICE)
> +		return -ENODEV;
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> @@ -72,8 +83,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[i] = pxcp_dev;
> +	xcp_dev[i]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
>  
> @@ -88,16 +99,47 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> -void amdgpu_xcp_drv_release(void)
> +static void free_xcp_dev(int8_t index)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
> +		struct platform_device *pdev = xcp_dev[index]->pdev;
>  
>  		devres_release_group(&pdev->dev, NULL);
>  		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +
> +		xcp_dev[index] = NULL;
> +		pdev_num--;
> +	}
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int8_t i = MAX_XCP_PLATFORM_DEVICE;
> +
> +	guard(mutex)(&xcp_mutex);
> +
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
> +			free_xcp_dev(i);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
> +void amdgpu_xcp_drv_release(void)
> +{
> +	int8_t i = 0;
> +

No need to init i.

> +	guard(mutex)(&xcp_mutex);
> +
> +	if (pdev_num > 0) {
> +		for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {

You could avoid if checks and simplify by

for (i = 0; pdev_num && i < MAX_XCP_PLATFORM_DEVICE; i++)

With those, and comments from Alex addressed -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +			free_xcp_dev(i);
> +			if (pdev_num == 0)
> +				break;
> +		}
>  	}
> -	pdev_num = 0;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

