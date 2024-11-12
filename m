Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA78CD42B9B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 15:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5452710E604;
	Tue, 12 Nov 2024 15:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4NJpN8e";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B9B10E604
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 15:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHoMpdzNy6FEwCDkxd8XsX4tvJty9D+IZPRuDsiiIzAFoMCPARJtrCHG3Dmayg0r1JTJ8y4TbqNh0oDSD1Uqn7SMSkGR3K49J3ZyKYABsI/3NltcJtUyxCItDvQqSUt/608NDosGy5PhEDxggB0myZdgf7i5LAO1cgrpnxxI5dAk7wPsPBLg2lcTBmtbZZFkek02iKhUCQ3/gjeglEcWiRZMNCmRoWV46RXhXVepvOqqvUyu4p44fPy0kep3vQls4oG3Fbh4O8/6+EerTMBgmw5M8LoqkSU5/ZtswRCFWjB24aW4OIL9UZOs2jOSPbYsYXQGNVVWLyOeZiKsfAIuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnh9Erz1wrEvpz4s3R35QrXrcXWB8/EGNDa8bE3S0Iw=;
 b=xaYZRXB6N1K54hEfqSmccIMmPjmrAQHi7+85bTYmzmlgRkybBgqEc4tup1m9MewkqyMEp3KpqAnUZUPAxfU3X2lWvcnTV72lKFDuG23L2Ve9HvdfkycqpyOMB9dUSxn4MC5GNltQc/ZW/4Ix7e5vUfvwofYE3GZj0NeQwFE/NV9Yu+3pBTlbRuxyIpEDdnyYx1SHJ/BKFUbayHdnLochdTdg3FUr1qmicABN5/9UBNf57ZstRD/Kimja6pXRUL7IejYobMqVIeMn6qnXOy+dWYQPyM39EFZAzmLGWbcSBERckmoA3rp9bOMNcIQgYtu1EqsVcNWGC4dqRK/sD6ivlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnh9Erz1wrEvpz4s3R35QrXrcXWB8/EGNDa8bE3S0Iw=;
 b=O4NJpN8eQhQhxB+3dZ45I1oiLHSecfe5COMHttK4trFZD2C5M+64tbDoI1zTCwrmRiEv+qH4McRAml3m9MeE6AEHQ0+JvF/O881MZacUxKxMYwX3H/TZ2VSBBvvp+R0VB6WV7IdcK7m1oXqatgu1OAB/96PRGRdNer6zo1+MDZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:28:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:28:49 +0000
Message-ID: <8a319ae4-5ed6-47a4-8838-9096d05270dd@amd.com>
Date: Tue, 12 Nov 2024 10:28:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Revert "drm/amd/display: parse umc_info or vram_info
 based on ASIC"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: aurabindo.pillai@amd.com, hamishclaxton@gmail.com
References: <20241108150152.983465-1-alexander.deucher@amd.com>
 <20241108150152.983465-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241108150152.983465-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::44) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cc0db4-2933-42ec-74e5-08dd032eb4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmNQRHNYVFozVjVWaUdaWGVsdnBvdDhObnQxdFpMTFhPTUZlNWZxdU04enNG?=
 =?utf-8?B?ZVprUEwwYjNZZFFBcTg2MDFrVGdmUS91R1Fha0l1WWZyUzRMRmdRM0pJU1ZL?=
 =?utf-8?B?QVFlaTlvUHlKcVpla1p0ZXpJSnFiVCtMbzNpaXZ5YjVGd0Z5eDFkNysxSlNJ?=
 =?utf-8?B?WSt5Q2RGUnpHeTd1R1hnV0Y3RXBnSVYramZkWEpxcEI0c2ppNVMreEo5Y0d4?=
 =?utf-8?B?K0YrTkZqWWY1eGt0RVBCOG9QQkZoVHVnVWJuTzVjdkc1ZWF4YnU0UmtDeVpi?=
 =?utf-8?B?OVBhZkMvSlYzVWt5Q2o4elVLb3lvQ3NYQTFRYmYyT2gzYW5xdGJ3ZWNvZThX?=
 =?utf-8?B?WHBucXprWDA1emlOTWM3ZTJNUXJlZHBxSlZERCttUHlOMkRhajNpdGUzcUN0?=
 =?utf-8?B?SkhHUHh2Q2gzVkVEa1JQRWkybEQxQXd3bFdzaksvQnJIUFJ6allwd0k1cEZ2?=
 =?utf-8?B?aUswZzY5VEsrOFNhT2UyTlZzM3ZJUzVZcWZZaFkxeXVlcGppVXNPaVlUY2lI?=
 =?utf-8?B?WTYxczFmczBhcEFYajFPZWRxL0FVY2IxNGpFd0ptOEdVYVJaY29KTDl3Rjh5?=
 =?utf-8?B?eHlzbDcwcWo5cTRzTnJxcEVBbjIrK1pPMWxWcEtzVmgvQUVtTUc0Qm1IMlEy?=
 =?utf-8?B?eVJWYjZob2ozR2dDQkFLVEhMWncvUUZFSmhVeWFOazR5KzJPV3oycTIyVjha?=
 =?utf-8?B?NWhtWEtrcG5kcHBWNFpEWVA4aG00OE9qMUZ5bG81dXBOeDNsbWJJSUgwUEJZ?=
 =?utf-8?B?Zk15cjdIVGZRTnBEOS9FcXFKVHp0SjlncGxQcjJlWW10dGp6VDhUL1VpRjNY?=
 =?utf-8?B?NHFFWDNjak55NHI3STJlOTlNKzZaT213aFA2YXViSTJNTlB3TXNaZm1qVWtD?=
 =?utf-8?B?a0xodmcrT1hEdW9VUEJoRk5GOTArSFI0bUllSzNlcmF6REFwd0RtbXlVallO?=
 =?utf-8?B?MWdPckUyRDJLU3ZtUk1HZEhLQ0VxUjhURHFud0RrRVlBL2Z4dThyU1kwaE1k?=
 =?utf-8?B?Ym95VXpSRlF6Q1lhVjdjRHlSNDhMazVXbHdkM29mcVZRc2xJT2ZZZ1U3amRM?=
 =?utf-8?B?MGpybEdwK3FYRWZsZnB5ZVVZKzMwOUllMDVZYm5JZTZxYWVnUktBZzNHL3pk?=
 =?utf-8?B?b0k3Y3Bvc0hTai9JbXo1akdqV21XaHpoZm9wTzNQRUtGNHl2Zlg2MTNzSXZJ?=
 =?utf-8?B?U3NrZmNqdzZWazVCOGhST0kvR2ttSUdEeGZoZGlndEpXRzV3Z0pid0R0RjZm?=
 =?utf-8?B?U09PblRqWjJHL0IxOWtIblRBVUNlcS8waEsxZXpQMlBnV3BqK05PYVc4aSt1?=
 =?utf-8?B?eXZ1bTI1NjBVTGIxQ2xITTRhR2tSa1cyVytDd2FvelVMVVZhMEIvR09zeGVT?=
 =?utf-8?B?b1JNeW13alZVVUNTY2p6WGFkTC9xSXk3SXl1bGI4UEhSci9JdnFiUjIxRm1K?=
 =?utf-8?B?Q0RqQUtuaCtmUUQrR25RNFJObkxoODRmSkJaQmRnNXlPNXF6NDc0RXk2WU8z?=
 =?utf-8?B?R2xaR3dLYjFLUnZkYmVvaGc1TFFtWFE2ZjU4d1hqaHVjck12ZmQwSWZWYWxK?=
 =?utf-8?B?VlVjN3d4b01wYk1LN3Jnc3dSYlNxbVNLb2NrdjZza3dWZ09LczZCQ1BOOTRP?=
 =?utf-8?B?VGxGVHdRMHI3ZVZLZ0lWdjhhZjJ1cU1OS1lUalR3Qk02eDhza25YdHdvZHNO?=
 =?utf-8?Q?0qeyzwUWYvw60Vmdaa/1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjMweHdUdXpvMWJuZnRoMHR0RFcxZGVzdFQvM3l4WUY3bjVWMXEyNjBQS2xG?=
 =?utf-8?B?UHBqcmVucUNXYjh6SWxxSlhsd3lDam5jYkVqa0pWQm91ZkFNcHNINUM3S3FW?=
 =?utf-8?B?WVhXQmx5TTJpbCtPNGtOUEc1OE04TTZ3amRBWFpPV1VBbFlMaEtzZllvWC8v?=
 =?utf-8?B?Ri9FRzVwUzNCcWM2SmJYM1JlUFBjN2lHQzVhOUJqeWszUWJNaTV1NUVycHFu?=
 =?utf-8?B?TE1BUTN4ck5GZjhoNUFSOWw4ckE5VlNzZCtZbzhHdjJmUkt6N05veFl6OEZL?=
 =?utf-8?B?T29BeDVLbU1xM2hlQWRFSHAzYW1EZlVJeC9tVDNneWdKMFRKUytkQXlLOXFn?=
 =?utf-8?B?UWtjTml1Vm56eWRjaTY3RGpockNxamxlK0hnOEhPTmExUlpvenRxQ1laWlFW?=
 =?utf-8?B?OXhZMzhCME5WMUF1V0V5MlNPNmlVWmhXaG9Uc3Jla2lkM2lmNW94YWlFSXRo?=
 =?utf-8?B?dHNGdURTK0xIUWtsUGZIcVZDL2lZUGliOE5TTjNRdTQ5enVFbDMxQ25vcEp2?=
 =?utf-8?B?aEJXVHR3bEFNZ2xyZU9hVjhkV2NrS1V5WHJiMXlXWTEySnhnckMxNEtBaUJT?=
 =?utf-8?B?OUxHK1RodUUzU2Vjbmg4MmlTZGpvMUhzUTI4ZEMrNkNJV0sxZ0pIUVl6MlJi?=
 =?utf-8?B?RHBwU3RnRkt3OEZNc1I5WlBNY01XbW5NckVKcG5sWXcyOS9JR3c4N1pkelY5?=
 =?utf-8?B?UHVDREdUY2FvU3NhOWxaZ0ZzV25FZFV0T2l0bXBMM09GRktYb3BXVmNZTDVI?=
 =?utf-8?B?LzlxZzAyVDFDR1I1WVhvcFRNZEVmeDRJUnRheVF2TU1FclFqNTJUNUIzcUhr?=
 =?utf-8?B?WXBheFZWMGRkWW5vREhROG1ZL0d3YXZMNE9uTFVPcnV3K04vOGFvNklWckhq?=
 =?utf-8?B?LzNOcDlYVmdPU2g0Zm9NeFZHaXNhMkRqVjB2U2o0M1g5Wit1dldpdkdhZStW?=
 =?utf-8?B?aVFWUHQ2OUx0Nml3MTNxMTI5b01Ed2ZyRktObEhuQ251NWtIRmJSVUg1MUJj?=
 =?utf-8?B?bEVRdG9Vd1c2Vzc1azBoRkEzbmZ4ZUtvVHpCT0lRK2RjTUQ4MmRQTllLMGZJ?=
 =?utf-8?B?T1duS0FpbDVwQkswUCtoS2tlbVNhd2J4eXU3UmljZEZLT1REQXZ3UkxzbHBX?=
 =?utf-8?B?RFVOcUpXQlExYmtLWCtZb05wYXRaQk9VY2NRRTJSdmg2M2JZclF1Vnh4RFlH?=
 =?utf-8?B?ZmhnRkduZi8zNzlPdThjeFQyL2FyOWFtUExOMSt4T256WEZyajVaZ05rRTBS?=
 =?utf-8?B?VWdqZm9TS0Jhd3lyY3BqVVZPK0FGZkhLT2Vab2dObmNLVmcxdTN5ZFR0dndF?=
 =?utf-8?B?REdHUEIzQmpEeXNTanB6UTJNUGxjcVBzZ1dKcUNiSGxwcjQ5azd5NGovSTNL?=
 =?utf-8?B?LzVLb3FSUm9CV0dYSlB2eTlmZGFjYjlNb053dmR1OFF3TFVrd0VFTGlrSnFK?=
 =?utf-8?B?RGFBUzdObzVEUHpnbDZKNWZxTUIzRGRGbm0wdS9HUXIyNEFkTUNjV2YxK0Fw?=
 =?utf-8?B?d2xaeDRjTnJLdDF1eklXa28zQWRRVGhGUFo2MVQ3aURzckpqeWpBcU1iUmJE?=
 =?utf-8?B?aCtBbTFIbmxtc3FvNVpXUTVMZzUrWlBVZHMwL3Q4NVd0cDRVVzlYUThlMDQx?=
 =?utf-8?B?NEYxL1hWV1dZZmovMFloMDM3aXgwai9Ub24rVC9hNXcwZ0ZzZXhlMXpsanRV?=
 =?utf-8?B?Z3hNRGFjUWlZNFJ3ZlN4UjdGUHdzNEdaYkt3anl3VjRkNXFGcTAzdlBtNG5I?=
 =?utf-8?B?SlkxWEd3UnJHZFM1bW5IZnA5SkVaNDBnYS92SkRKUDRHQ21CZkV6QXhCUFAw?=
 =?utf-8?B?S2RFdkUxYWFPSVJXdThyNjI3MjB3VnZiSUQvMU5MOWZHSHdySGZMdFlQY1R6?=
 =?utf-8?B?MUF6K1UzTWU1VTdCU2NJaFIxeEJjY0crWEhmUXdNclQzVm9DUzFoUXBNb2c5?=
 =?utf-8?B?bTFRMUo1MmlkaHBWTFRrRE92eGE1ekpwT1BrVVVrVG4wSVNOZmhFbXNOOTVk?=
 =?utf-8?B?c2dWaXNvVHN2cm1xRk0yUnNVQUZrWHlPZ1N6dHVPdTg0YWJlRnlrT2FEUlFN?=
 =?utf-8?B?UmZTOVpqZ0hTOForeXBSSEtNR2lUYitUT3p4SHVCRm9VUzF6c1loZk9NWlpB?=
 =?utf-8?Q?CmNUrKPIbEDdxE9ApFq1Zz5BU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cc0db4-2933-42ec-74e5-08dd032eb4b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:28:49.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/Fvr0VqSFO7tn7+/1CRF6U+CX5d7Qbynl5CEm+LiBNYszKvmUaAF0CiBWECagYCHgNbsTJFw9tduyiY9vXZ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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

On 2024-11-08 10:01, Alex Deucher wrote:
> This reverts commit 2551b4a321a68134360b860113dd460133e856e5.
> 
> This was not the root cause.  Revert.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3678
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: aurabindo.pillai@amd.com
> Cc: hamishclaxton@gmail.com

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 902491669cbc..c9a6de110b74 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -3127,9 +3127,7 @@ static enum bp_result bios_parser_get_vram_info(
>  	struct atom_data_revision revision;
>  
>  	// vram info moved to umc_info for DCN4x
> -	if (dcb->ctx->dce_version >= DCN_VERSION_4_01 &&
> -		dcb->ctx->dce_version < DCN_VERSION_MAX &&
> -		info && DATA_TABLES(umc_info)) {
> +	if (info && DATA_TABLES(umc_info)) {
>  		header = GET_IMAGE(struct atom_common_table_header,
>  					DATA_TABLES(umc_info));
>  

