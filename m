Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E6CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 07:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B633610E52F;
	Tue,  4 Nov 2025 07:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLRWEnRa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3D510E52E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 07:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4brPQRTg8LBm+FDXRouH7owJhCt0OyjJ3CFwpZjMtuDzqgb6SiPWHq6dhEzKVnVkNB77JF86wWtZp6u3fPvWBL9Cc9S0TJ3pDwS4zBYFXMkMuiiq3huXrFSUmgOv9Ij36Bz7T0Qv4wpRh5BnrlhCRJOzrbQYavCAC0sPD3am60rawhmwoyrRWVhVbGdqMauajfMIBJ/+ItxhzzRDWokgNRv78P89pUv0nk9HezIVfIBd8eVZhn4at9/SaBGjj6pmTXJifN3dz4mLoyRgINXWi3ZP6WkPIla/7llY+AsoDjRw+j6vetMGrP4MWWZjX/LIKNZOWnnI4I92zfgZKiFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmFp/f55m7n7gbPlfJZo6NnK+tmDyLAQGfnCjQsI2zU=;
 b=in2PM0Nc9JgHdy4RpK/PrrCBHFxHWfhfIfmharCMUA07rFIOzrNAk44HfJHeeT1tEBx5edxBmAaMlHvBhdoVG96oqpeGCXxRpml2OO3SzDIy3QBtak4j3CnArs3acfX15NXvRge/AciroxfyiZulFXPosmNTm9bIKU3lG+e+JarZo0DCoWRB2Uiz1H57Sk0mpyjxY//Q1a6aliYFESN8Z/MpLry+kLEHW7u9fZaH19Wj3NoDFtWQqQovpe4HIlHOVJawDDw/JxT9W+QPxp4aeg+Dx1wVNYOomzh9E/NjQm3nekAevNUugsSZUk36N9USNQJu6x08pQMWfXLu1+hSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmFp/f55m7n7gbPlfJZo6NnK+tmDyLAQGfnCjQsI2zU=;
 b=dLRWEnRa1JoQG7PIajl+Gw/LPEEbXxZNtiluHa6WGarkgoT7by3psb1XK4Af50jwrsMdHDNb+H8NZa3x+cQjFe9ujzGnUvjYzpTXtvE7YUpRhEQkqzHMX/3y9dUOyxguqisGgNp7UwuOYOghmKM/1mxnkgPdad0RVLxbCJ0+nIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:23:41 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 07:23:41 +0000
Message-ID: <45e0ba2f-8bad-48fe-abce-fa7ac76c80be@amd.com>
Date: Tue, 4 Nov 2025 12:53:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: suspend ras module before gpu reset
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 Stanley.Yang@amd.com, Jinzhou.Su@amd.com
References: <20251103082733.2671013-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251103082733.2671013-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c9206-a547-4020-a4e3-08de1b73142f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXBLNDZReTF3L2RlSTlmK0dKZ1J6aGV3Q3JkWmlnNi95MVp0SzI4bDMyYkdM?=
 =?utf-8?B?aWFsWCtjdXJjREdORHVSek9KR01jQ2JXbGtQb3NpOXBoWElMc0pjZGlidmRj?=
 =?utf-8?B?UDI2bWpLWEh2aG1sbk1jOE1zangzUUJvTWRRRzBoRENwdmIrWFhSMmVDT2Ry?=
 =?utf-8?B?NUY0L1dpQXNXSjczTGlJK1FCd1J5WVFSK1VSYmNYamp3RnRFVFBCWG4rMktC?=
 =?utf-8?B?aDBWMkdKR3E1VjJNYWdja0o2eFJMR0xyZkgydmsxQkpyaElZUmpHVi85UXR3?=
 =?utf-8?B?K01BVzdUd2JiL3RiWEJ5UnpGdlFaSk9GN213dXlpTWlTTnZGeWQxZ2VSSlBn?=
 =?utf-8?B?MGpEdWpLdWpHWlRFS1lDMWdheUw1OFpZeDRtWWZHRkNiRUcrdVdoTksrQTdX?=
 =?utf-8?B?MFdLS3pxaGh4L2QydEVwMlFIK0M5VVNSUU9TaUdIODBFdlZZR1pLZGRManJy?=
 =?utf-8?B?OXNXaGxIZlBuRDdBS2l0dXJGMVRzVFhScm9STXRKK0ZKT3RqOXlWejU5cEYr?=
 =?utf-8?B?NFBnWlArVlVrSGhGc00vMTV5bEJkMnhlSk43S0tPRFJwb3A0Sk1HTHcvQnh5?=
 =?utf-8?B?OXFtdkEwSDFXUmNObFN0SzVDNW1aeE1WdXNyU2EwTTllcFlmSjUxTkVaYysv?=
 =?utf-8?B?WXFEajVKM1RnNVBXZ1VZOHRvYktncEc5bktKUWM1MWNyQWs5MXN4S2tMWlNR?=
 =?utf-8?B?T1BYTitUTXhEdTN2a0l3a3FzUFVkQXhvYzNIakFHeUVwTFVUaTlrU0luUk4z?=
 =?utf-8?B?L3d4NEpSWDNCVnpPd0dtN29zMUhnZURkY2tjcnJMY1Q2ejdJc1Jld0JDQ3BH?=
 =?utf-8?B?UWhjVzBTNHkrcUVHNS9wUUc3WkNGNUV1elg5d0xNN1NJeCtwV0Qxek4yaGtl?=
 =?utf-8?B?VEF0ZjMvQk1KOHdLWDVSOGJVeGd2aFNvNlg0QmRzK0RmUjZXYnR5RlJkcG82?=
 =?utf-8?B?VVVHeUFpZC9VUFFJMFBwYnlkdHNxZjl0K2NQMW1ZZU1MTzI5VWc1MCs0Vm9u?=
 =?utf-8?B?NlJYOTNUVW5tY0hnSE1FdlA1RlgyY21raldCc2d5ZzVBRHBiRXk1WWtsaGkx?=
 =?utf-8?B?UHVQdFE5cy9WakZRbEVsQ0ZTcE9LM2VnR0hxYnpJb3FsVitNK241VlRjMVRR?=
 =?utf-8?B?ZEZFc1JUWFBILzBrRkh1eTdtVVlIK2UzSisrZWp6c1l2eVVKWm8yN3pWalEy?=
 =?utf-8?B?cjZUVldEVHVjSWYwUnRTRldMQWRnSnc2VXFmVEJJSk8yQ2d1SEhVUk9HaTZt?=
 =?utf-8?B?ZVYzZkhXSXYwS2Y2MG52enZXTVpFNkNtRlErVFVOdjMyVDkvMnZwdG4xaGhI?=
 =?utf-8?B?UlRJeDFqNHlRSTBUeldVNzJ0RGQ3WmVtVkVHcnhTQ0NQYnd3WlRkTHAwc21H?=
 =?utf-8?B?RmtlM2JGUDdNMUFNdU9LVGVseWI3eGRsYVVNMDg1TUVRSCtDb2hVcHRvQ2N4?=
 =?utf-8?B?VzdwOEN6NVNnNHF6WHhIamtBUEczRVJpUlZmTkZHdlZKTVpNdUVKY2U1aWRn?=
 =?utf-8?B?MTQ4WEN3ZGllOFdabWJPRFg5MnFmTkJKVmw1eE5FRDhvNVk5Qm1lVHB1M3gy?=
 =?utf-8?B?MzU4ekJVdXlHWmIyTU0zUkVLTmI1QXdtS1J1bUtNOStoNmZmTDRFM0h0NXJp?=
 =?utf-8?B?Q01GUGpZd1gzQ1cvNE1tRVlNMzA3NWVRZGRZV0J6TGw0d2dlS3VZNHV3UGJS?=
 =?utf-8?B?UjZOeEV3Q016WC9IRjZvcDh0cWVwMDlBRTlvOFA0RjU4VlFFK0Q5S0s4TXZs?=
 =?utf-8?B?K3FDeDl3Y2w2UWJpRFhlMWJPS0sycXBLQUpCdXJ3UHFvRmJMOUc1Q2NUbmVL?=
 =?utf-8?B?cWhyVzF5b1hneEtOcFlJc1B6VHFiNm9DNm5BdzEzSE9vN212MVR6UlFOZk1J?=
 =?utf-8?B?ZlgvMkpoNi9vWkRnWElpRWdrbVE2c0RUQi9Lajd0MWlBYi9aWWtiWTFTc0sw?=
 =?utf-8?Q?hGgSgrktZYXQQdNBvTMctQoNHCSuvbeu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3F5WTV6VTI2S2F0b211N0NtaW01enZpNzdCUzVoYmRudk10bnVUZ2U0Y2NO?=
 =?utf-8?B?VElxb3ByL1ByWW9oSFdlbkR3STNkK0toZHFpL01IVmZwblBWY3pDNTlTSDhj?=
 =?utf-8?B?TDFxemplcXZuRmdvU2lBb2NpSmIzRC9FVGk0UEw5QmxPMGlqSENjVVJxNHR0?=
 =?utf-8?B?V0YvanByZWQ3Sk8rbnJ6TFZqa0V4UFdIYzFiQzVmNUhoVTBtRG90dyt0cjhn?=
 =?utf-8?B?MWlmVkQ1dUlsWUowZXJZNVprZHQra3p2NS9zWkxub0RLYlYzZFYxaXpMZUlk?=
 =?utf-8?B?MEVmUVhscnpsUjFlTS85WUR1bFZ6L2ozbFdMdUdxSGFKYjZVdmprdExVRDRn?=
 =?utf-8?B?NlJsa0tjV2tGMXREWXJRbXJBNDdNdGE4NU50WVdqQWRodHNNdEoyV3poNnJF?=
 =?utf-8?B?ZzVqVHVSWTlGNkpVL25rVlIrc1FEeEVraGo0bDd1alczS3RFUGhCSDhNMGxX?=
 =?utf-8?B?ZHZzSlkxMmpQQzlmVW1XMTRrMmhCWjVoZGFPRmFPSitNMng1RVRRbjN6V0E1?=
 =?utf-8?B?YnBrckFxRS9xNDQzZmM4VDVHVHdoRlFZUEwraU1hb1phNnJ4Uit1c1ZmSWMr?=
 =?utf-8?B?U0ZoeXdoems3SUY4cGIwYjloREx6UEZUMll0MmI5MjMrVXRZZDE5U2VtK1R2?=
 =?utf-8?B?aDFET1hWVS8zcWIrMSthby9xSVcxRnlvQjRqSjhGaGhxVmdlaDNSdis5MEVt?=
 =?utf-8?B?d2lndk44K0pnWVZxZE44Y2NSdVFjWjlOOU4rdUhobkRXMHRhRVJRbjNyUVlu?=
 =?utf-8?B?Vms4UENOcS95RlpnSStIY2xOWkh2QnFqK3RsbEozU2hNNnV3YUltZG1UQ2Jx?=
 =?utf-8?B?em1nM0dUYVdjLzhRODRCVG5hbGozVE1iMFJESC9xRXdMMWtEQTF2UUZJZHpQ?=
 =?utf-8?B?a0pkWWtLbjJRWFJoUVQyZTNoUUt3UEwyTDJSUSsrZ3FyNG81VGR4RnJyZmpp?=
 =?utf-8?B?RnM5VjlvYmJlZHJpd0xUdWhyN2QvOHFJcGt5UW0rMHo1NkhCNTd0ejN0RTV2?=
 =?utf-8?B?Y2NKVUNMU2dJYW52bm1lLzlBQXZrSWJzbndwUVFPcHozNzRWV0ljazdocWJy?=
 =?utf-8?B?VWorTUkrRE51NERCbkRzQTVuOXJQck05d1VOaGNNYWMyaEZkMGN6WmZVdUs1?=
 =?utf-8?B?Z21MMjM5YXdHQldpQmpQMURxUkFZd05GUG94UnF4QnR5MUYwL0U0bUpOSDhp?=
 =?utf-8?B?MC9HT1IvbEptMlI2M3VGNkcweHZ0dUNVbDFPSWdXZCtheWNZWjNHbDVaYzlM?=
 =?utf-8?B?Rkh5OCtjallMTEtGVjl3aC80aDhEeWV2L2FMWWttQ3JlOEtKc0Z0cWpsQ0hr?=
 =?utf-8?B?Ym16SWFGd0tQVGIwSU4zb2xZQ1NQdUJwMUN3Y2tTaFMrREVFTGlQZHQ0c3Q1?=
 =?utf-8?B?R2l3QUQyclBldCtnSGprNWtlc2EvT01KOHc0b081MHRjRmFQOVRCNWZ1RFBL?=
 =?utf-8?B?OUF5WmJEV1pNOWFqcEw3d0dITHdyS3BjbWRNeWQ0QjFYeEt6cUNBWHNMVkox?=
 =?utf-8?B?RTBkdlQ2MFd3M0dPNkRoaWxqaWtWK1RSSWxWYlN4ekhZdEthOU9OcEI3MTgy?=
 =?utf-8?B?MHU4dHV6RjJQTWpsd0p6K0ZiWW81N1p1ajduOTVSbzBzdkIyYnMrb2tWazEz?=
 =?utf-8?B?N1BHbzAzbzhNcjFPa0lkSWxyREdwWGhSRk5Dc04wRG1ONDM4SHFwbjVQSTRa?=
 =?utf-8?B?a2poZmRHaXBBWm12aTV0UVhQbzcvYXNTOC9iQVk3T0MzcUhkcFlndzVkTXo2?=
 =?utf-8?B?VVVPM2ZxaDFtZTVySWRSUk9OV3VBMGRVczlzbFlNOWtqMlJ4aFJxQ2hxRnJ0?=
 =?utf-8?B?Zm9qUXJaUjJUeXgvaytuajNoTk9QUVVEYU1kZUcvZjkyeStka3JYKzBySnFn?=
 =?utf-8?B?b2RLTkpkWmNtNk9ka2pCUDdSdHpEMFBzMHk2TEdwU2hVOGlwVytTc3ZhOTlJ?=
 =?utf-8?B?L3pVY3ExZm0xL0VXRDMrS1pJWTZ4NWhQY1FzRjVyTXYyeDVGOG9OVFlNa1NT?=
 =?utf-8?B?NXZoV1R5QkpPQWhvbWZPem96TDJyWGtzRWFIdFVpSlllVFhxRVJWWUF3VzNK?=
 =?utf-8?B?MjZ5OGRvbjJiWEswMjZzenE5TytzdHdvRmxEdUhqS2hrbHhWaVpPYmZMV2FW?=
 =?utf-8?Q?7CpKo2+sQGihzGOZqmz5ZtP/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c9206-a547-4020-a4e3-08de1b73142f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 07:23:41.1308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMbWlvT5psdgqpWd7Y1SkUq/CNkTEmBAzyM1IS7LPYNAi5RalYFaoMHyH8yNJhR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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



On 11/3/2025 1:57 PM, YiPeng Chai wrote:
> During gpu reset, all GPU-related resources are
> inaccessible. To avoid affecting ras functionality,
> suspend ras module before gpu reset and resume
> it after gpu reset is complete.
> 
> V2:
>    Rename functions to avoid misunderstanding.
> 
> V3:
>    Move flush_delayed_work to amdgpu_ras_process_pause,
>    Move schedule_delayed_work to amdgpu_ras_process_unpause.
> 
> V4:
>    Rename functions.
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  8 ++-
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  5 ++
>   .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  | 64 +++++++++++++++++++
>   .../drm/amd/ras/ras_mgr/amdgpu_ras_process.h  |  4 ++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  6 ++
>   drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 +
>   drivers/gpu/drm/amd/ras/rascore/ras_process.c |  7 ++
>   9 files changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc6e59208cac..9e8802ccc75e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -71,6 +71,7 @@
>   
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ras_mgr.h"
>   #include "amdgpu_pmu.h"
>   #include "amdgpu_fru_eeprom.h"
>   #include "amdgpu_reset.h"
> @@ -6586,6 +6587,27 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>   	}
>   }
>   
> +static void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		if (amdgpu_uniras_enabled(tmp_adev))
> +			amdgpu_ras_mgr_pre_reset(tmp_adev);
> +	}
> +}
> +
> +static void amdgpu_ras_post_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		if (amdgpu_uniras_enabled(tmp_adev))
> +			amdgpu_ras_mgr_post_reset(tmp_adev);
> +	}
> +}
>   

One nit - could you move above ones to amdgpu_ras.c or ras core related 
file?

Thanks,
Lijo

>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
> @@ -6660,6 +6682,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			goto end_reset;
>   	}
>   
> +	/* Cannot be called after locking reset domain */
> +	amdgpu_ras_pre_reset(adev, &device_list);
> +
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> @@ -6691,6 +6716,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   reset_unlock:
>   	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
>   end_reset:
> +	amdgpu_ras_post_reset(adev, &device_list);
>   	if (hive) {
>   		mutex_unlock(&hive->hive_lock);
>   		amdgpu_put_xgmi_hive(hive);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5377cde0c55d..cb4f4b5668ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2921,8 +2921,12 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		type = amdgpu_ras_get_fatal_error_event(adev);
>   		list_for_each_entry(remote_adev,
>   				device_list_handle, gmc.xgmi.head) {
> -			amdgpu_ras_query_err_status(remote_adev);
> -			amdgpu_ras_log_on_err_counter(remote_adev, type);
> +			if (amdgpu_uniras_enabled(remote_adev)) {
> +				amdgpu_ras_mgr_update_ras_ecc(remote_adev);
> +			} else {
> +				amdgpu_ras_query_err_status(remote_adev);
> +				amdgpu_ras_log_on_err_counter(remote_adev, type);
> +			}
>   		}
>   
>   	}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index f8ec0f26a9e7..36c665c3ee48 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -622,3 +622,25 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
>   
>   	return ret;
>   }
> +
> +int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ras_mgr_is_ready(adev)) {
> +		RAS_DEV_ERR(adev, "Invalid ras suspend!\n");
> +		return -EPERM;
> +	}
> +
> +	amdgpu_ras_process_pre_reset(adev);
> +	return 0;
> +}
> +
> +int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ras_mgr_is_ready(adev)) {
> +		RAS_DEV_ERR(adev, "Invalid ras resume!\n");
> +		return -EPERM;
> +	}
> +
> +	amdgpu_ras_process_post_reset(adev);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> index 42f190a8feb9..8fb7eb4b8f13 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> @@ -52,6 +52,9 @@ struct amdgpu_ras_mgr {
>   	struct ras_event_manager ras_event_mgr;
>   	uint64_t last_poison_consumption_seqno;
>   	bool ras_is_ready;
> +
> +	bool is_paused;
> +	struct completion ras_event_done;
>   };
>   
>   extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
> @@ -75,4 +78,6 @@ bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);
>   int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
>   		uint32_t cmd_id, void *input, uint32_t input_size,
>   		void *output, uint32_t out_size);
> +int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> index 6727fc9a2b9b..5782c007de71 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_ras_process.h"
>   
>   #define RAS_MGR_RETIRE_PAGE_INTERVAL  100
> +#define RAS_EVENT_PROCESS_TIMEOUT  1200
>   
>   static void ras_process_retire_page_dwork(struct work_struct *work)
>   {
> @@ -57,6 +58,9 @@ int amdgpu_ras_process_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
>   
> +	ras_mgr->is_paused = false;
> +	init_completion(&ras_mgr->ras_event_done);
> +
>   	INIT_DELAYED_WORK(&ras_mgr->retire_page_dwork, ras_process_retire_page_dwork);
>   
>   	return 0;
> @@ -66,6 +70,7 @@ int amdgpu_ras_process_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
>   
> +	ras_mgr->is_paused = false;
>   	/* Save all cached bad pages to eeprom */
>   	flush_delayed_work(&ras_mgr->retire_page_dwork);
>   	cancel_delayed_work_sync(&ras_mgr->retire_page_dwork);
> @@ -124,3 +129,62 @@ int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
>   
>   	return ras_process_add_interrupt_req(ras_mgr->ras_core, &req, false);
>   }
> +
> +int amdgpu_ras_process_begin(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	if (ras_mgr->is_paused)
> +		return -EAGAIN;
> +
> +	reinit_completion(&ras_mgr->ras_event_done);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_end(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	complete(&ras_mgr->ras_event_done);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +	long rc;
> +
> +	if (!ras_mgr || !ras_mgr->ras_core)
> +		return -EINVAL;
> +
> +	if (!ras_mgr->ras_core->is_initialized)
> +		return -EPERM;
> +
> +	ras_mgr->is_paused = true;
> +
> +	/* Wait for RAS event processing to complete */
> +	rc = wait_for_completion_interruptible_timeout(&ras_mgr->ras_event_done,
> +			msecs_to_jiffies(RAS_EVENT_PROCESS_TIMEOUT));
> +	if (rc <= 0)
> +		RAS_DEV_WARN(adev, "Waiting for ras process to complete %s\n",
> +			 rc ? "interrupted" : "timeout");
> +
> +	flush_delayed_work(&ras_mgr->retire_page_dwork);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_post_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	if (!ras_mgr || !ras_mgr->ras_core)
> +		return -EINVAL;
> +
> +	if (!ras_mgr->ras_core->is_initialized)
> +		return -EPERM;
> +
> +	ras_mgr->is_paused = false;
> +
> +	schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> index b9502bd21beb..d55cdaeac441 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> @@ -34,4 +34,8 @@ int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev,
>   		void *data);
>   int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
>   		void *data);
> +int amdgpu_ras_process_begin(struct amdgpu_device *adev);
> +int amdgpu_ras_process_end(struct amdgpu_device *adev);
> +int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_ras_process_post_reset(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> index f21cd55a25be..45ed8c3b5563 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -142,6 +142,12 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
>   	case RAS_EVENT_ID__RESET_GPU:
>   		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
>   		break;
> +	case RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN:
> +		ret = amdgpu_ras_process_begin(ras_core->dev);
> +		break;
> +	case RAS_EVENT_ID__RAS_EVENT_PROC_END:
> +		ret = amdgpu_ras_process_end(ras_core->dev);
> +		break;
>   	default:
>   		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
>   		break;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index fa224b36e3f2..3396b2e0949d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -115,6 +115,8 @@ enum ras_notify_event {
>   	RAS_EVENT_ID__FATAL_ERROR_DETECTED,
>   	RAS_EVENT_ID__RESET_GPU,
>   	RAS_EVENT_ID__RESET_VF,
> +	RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
> +	RAS_EVENT_ID__RAS_EVENT_PROC_END,
>   };
>   
>   enum ras_gpu_status {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> index 02f0657f78a3..3267dcdb169c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> @@ -162,6 +162,11 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
>   	uint32_t umc_event_count;
>   	int ret;
>   
> +	ret = ras_core_event_notify(ras_core,
> +			RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN, NULL);
> +	if (ret)
> +		return ret;
> +
>   	ras_aca_clear_fatal_flag(ras_core);
>   	ras_umc_log_pending_bad_bank(ras_core);
>   
> @@ -185,6 +190,8 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
>   		atomic_set(&ras_proc->umc_interrupt_count, 0);
>   	}
>   
> +	ras_core_event_notify(ras_core,
> +			RAS_EVENT_ID__RAS_EVENT_PROC_END, NULL);
>   	return ret;
>   }
>   

