Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC80C021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691D210E40A;
	Mon, 24 Feb 2025 13:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXf3HNgb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875C410E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 03:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdjU/zviU0fzGhkfiPyJ2d3ZL50LH89lDfzZzDqOwx1OThUZTDN4uPwxButyI+x+WKvQHbiah1ew/oU/KGeIfBFDieYDH/hut9fE61awaS0idcxwG0CXlzwbO3YgOXZypFlRJIXRDpugJ6DSY1XbibSHK1R4o0tyxvL+Ku9esanMjxrbSdUYSFVdQ8YyO7L3eECQaMu0i0cJ26zhEZdqBXaoE3WZgLEOxk6ZLvDt3vZJDO3wxyNsS13jSPKNHs58rpN4+GB6HL04gCKwbxLQeKqw713PzaNHt0HVYcb9ZplPdfPgMBLBBnJ/YoluxzJGDyVclPBF+B7fl2nVMC8cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HisgrFPQW6a3IJHuNCScUiSZptYWgRVwGcg86a5BRhA=;
 b=ZzPmthGo1juYbE7i9jNrxqpyNzAWs34dydsn38vzO/16Rc4XMVtiOTCf2Z8Wu0iYBYkPy8jP0cOFxnkyxMP7DNOVPWdSYoZBwjE1FdRLL1bNIFj7ImeCvVoQTIpq6BlrUuTcFgBkTFMiSXgiAfyObWgqiTowLGz20e8JVZuqcb0zhaoJ7m5rwFqTQQj6dCP5aqcFFm/2iwC5s/FiKia0/1qaBJlOr1jcBB7jkX7Ns5WIFupxoDVU4GS1oUUu/dOSYsHzH1mb5WMtI/H6W2MRJolsxLy1fEqiICWo8LHN+qKwPArRtVTSqntEoCiRBmuok0TzlTdibvLgvg58MrdYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HisgrFPQW6a3IJHuNCScUiSZptYWgRVwGcg86a5BRhA=;
 b=UXf3HNgb49WeyZuVlXBjvZKz7zEy4s0Xq7faXsehCapPpVWpsqpblveQTpsjLcfFKC4khLKJvslIkpfQuiuLumPsTy5m4G1szz1bsyaJW9teukkrw6GWKP1XSjs4oikCMRKfcPv7giGKEs82gNuQnyva6Y24o91XjnX7KhSUPYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 03:51:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 03:51:24 +0000
Message-ID: <c7d2bb3d-0109-4039-85f1-a843dce52ce0@amd.com>
Date: Mon, 24 Feb 2025 09:21:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Get metrics table version for smu_v13_0_12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250222171312.791450-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250222171312.791450-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: d11e981f-f6c5-44a6-99e7-08dd548681e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDVhMDluS3U1OElESVlCRVM5MnE0eVloMUhlREd5UWxzM2xNdGNRY1d6UERB?=
 =?utf-8?B?aVJVc1ZJOXRISVVGWEtic2ZFajZ1Ui85UlZsU3R3NDZpaERFU0wwSDBXcTdT?=
 =?utf-8?B?c0FydG8vSUNKQ3NEZkdrQTBucHAvYzFaWE53WlRkMmVOQnQ1dStobTVTQ051?=
 =?utf-8?B?R2h4bElJRmVwYi91amVmS2xEbmFZT1d1YWI2c0xHeEFKcW9EcGprbExuZTgx?=
 =?utf-8?B?KzZyZGtWY29PbXJQZktGcDFwby9VZlByNDhKY2RldnhLVXN3MERWRnBUYWJN?=
 =?utf-8?B?VDZFaURWZUFOVnNaWWRVbFVPa1NmR2pldStjQ2RzY1d0azVoc3hGTjhzVHFx?=
 =?utf-8?B?MTRlT3piQ2h1Yzd3dHIzdGpCQkU5a2U5ekNXL0xOVjRTMUNmSWxOei9yNHRy?=
 =?utf-8?B?eTF6MjIweElUa1lkekpnVU1GbjJ2RmZjb0h6NjNGSFJBaVRHYzlLcUlDem84?=
 =?utf-8?B?MXM5ai9GMmY1anVLbGJIdzFsRENqbFkveGJpdXc1V0d5QjI0UWFXMGhybllF?=
 =?utf-8?B?Z1BkYXcxQ2kxaGI0Q0lGOFBrY3NPazU1TzA4L1VyOHdIQlZWT2JibTdCL2hR?=
 =?utf-8?B?WVZpS3JOVWtLVGVuMjlVTGoyOXI5Y2wrYzBQeGNCejVRb3h1dXprZHpvQXov?=
 =?utf-8?B?elFxRTBWMEJNRDNHc1c1cjhSYi9ZYk5yckJMbE5RMXhTd3lUS3E3LzlpS2xZ?=
 =?utf-8?B?NVgvN2lKeTRzM3pkMFpWN2ZyQUluVk5ydVRnblVDL1kvZEJDUVZOMTU0UW8v?=
 =?utf-8?B?akQ4Y2pVQVhkT0ZYMm9Gd1hoSjVRZmYyTTl6Q2V1N1VncWxxUzVFT3pvM2hC?=
 =?utf-8?B?a3RieXU0KzFLdlhoRk05RW5kRVBqRG05UVdjREh2bWl1Q1ZRNVQ1SFVreXJv?=
 =?utf-8?B?TTFENkhWR08xZk54Qm1BL0ZWNVNic2FveGJqM0RGc3BOTFJFdTRUdWg4SnBD?=
 =?utf-8?B?bFh5QUdzcmtKMjFJZmZROVg3ckJUMG16cW91aTIrcC81VVlpNjNXMFZVREdp?=
 =?utf-8?B?UFdvZXBKc3dNYnJFSWlhWDB0MURLWFBEdDRWV3JNTUpjTUlTVHZMNmpVdkli?=
 =?utf-8?B?ME1zWmNjV1RwbmxrNDNvTDlrVHZ0bUR2T2xDWDhyOTlwV2pJYXFBbTluKzBi?=
 =?utf-8?B?UE1TSzFTUW5scGhSTlY4Z1phc21oVlFmZXVmMWFUVnJPTDgzODhHSG9Wejg0?=
 =?utf-8?B?RkZIbkNEc0EyQmhGbENNUm9DTFVvZ1ladmY1YS82Zk5EUEhvYWVLcGF5cUMy?=
 =?utf-8?B?TXlTZTZhUnhvbjRpWnJ0MTJrMkVnTXRNak5PaDJjRks4TVcwbjYwMEFLU0xU?=
 =?utf-8?B?bGdpQSswSTBuakRHZXdYZUF3aU9vblNxbkswOHlPQXFITGNQQUdiYmtNOWlz?=
 =?utf-8?B?M09kOXFWUlJibmt0V01ybG1KenFySG9iVmdld09DVjZobSs5eEF4NEZXbG9D?=
 =?utf-8?B?Mng4MkZrUFM0VTlMZ3dFSy90Q1Q4V01oMFRBNzFRZm5tVnRzYlgrbldsQ0tD?=
 =?utf-8?B?WWZUa0VMeUN5Rlo5d2FVclJJbEVvUGZWN09aUHVodDBKUnRHZDNFVWl6RWFT?=
 =?utf-8?B?eHZ4N3dUVHB5blh6MWw4c3pWOFRDbThHc1JkR1ZxRXB1L1BCcWFPei9SMERm?=
 =?utf-8?B?TXhFQ1BPS3ZUNmdJWVRuRWJxbElrNEhxN2drRTFVa0NScUM0dG9tMTJaRlNa?=
 =?utf-8?B?WkhrNGlCTnJHZ21oODFMZFo3VWkxenpGYlEzeUFaaTczVlZVc3JvdkkrTzlx?=
 =?utf-8?B?R2ZYZXZaOUJTeURCdFo0NlkxY2YwaXFuMlpQaitNUFZpQzk5QThlYzdmdWJP?=
 =?utf-8?B?aVVjdDRraC94eVhWUzZLNGhzTlM1NnZKTmJnSnU2WUVaSElWK3NyZG9GemFp?=
 =?utf-8?Q?TAFENwNmZy6/L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJjSXFib0FoOHFuRVA5MnRSbHh3cmM4UjZvT2RORmZJN1hQTHd2UnBrdnBu?=
 =?utf-8?B?eHVLVHBBSmFVY2M3SDEvRnA3eGtldzJ6VjRrQXRWc2N3OGNKYjlPaXM3cWJW?=
 =?utf-8?B?VFBVNWJCZmlzUEd1allnVEIralZjdmJSWDlMbUw1eFZQVnh0eWk3aVFmUkhU?=
 =?utf-8?B?M1Jqc2dmMFYxdXYzdUd1a0dYYzVwQnhNTDlISWkrdmp5NWVkZ3EvSDFCVnFS?=
 =?utf-8?B?REx3MDlJUDlvZnU2TkQvcFcwL1RsWWVvT1VTN011QUFQcHhmcDBPQ2lHQy9N?=
 =?utf-8?B?SXVYQUU3cXNkZWtRaFYvZi9KUzlMZG0xdktiOE9KaGRNdUE2aTNYL0ZXRWlJ?=
 =?utf-8?B?VGNjRy9yRjdIRmVidmNjS1lCb2RkUXNMSkkwS1RkRHJSajUyWkxyUE1RVXBv?=
 =?utf-8?B?TG5FV1A5NDR3aWc5WVYwcU5rNkZoMi9TcmI2b2QxUjIyTjFDVlJXdG5DODl4?=
 =?utf-8?B?cXRJb1ZSRnpTL2JzM1d3SzJBUHQwR05nNFl0d1FZMERycGZKZ1pIMEZaa05q?=
 =?utf-8?B?bkdjd1pXNmNsUkZMMzM2WFpiaXBTTnZSai9oVXVvejRhYm5PeldJSDZGYnhR?=
 =?utf-8?B?bVVkVW8vZ1hWOWpneTViTXR6RUlDYjFHWTEwUStqR0tVakRqcVRjL0N0MHhG?=
 =?utf-8?B?UDJUdVNudHpFdHpHRDcvajE3UTZvYm9hejRscWl6V1ZUaVJCVVdpWVh1OG1M?=
 =?utf-8?B?Qm0wc0pZakJBTkZvSmVCQ1BVRkFJRWNMeGlia09LWDZ4TU9WZm1hUUtIYXJD?=
 =?utf-8?B?VjNRZDVrTWl0Ykg1Nll5b1NQUU9jbWpEMjd2Z2FhVUJQck1tOTR0OGRtOStO?=
 =?utf-8?B?Nk5EWS91N1VqR0dnNTg2M2d1S3NqSm5sSEhQc1F0VitDU3liSE5aazBQc1lX?=
 =?utf-8?B?SmZuUUNSZjJEYk5ldEFYM1VNTXdZNG1sdUJqWmY0L1NhUFhKY1IrT1I0elVn?=
 =?utf-8?B?WFFwQ0k1Z1VabFRoa3BFU09QYnl3QXh3NEN0QUVFNkVqVUg1WXFMQWxvRXRp?=
 =?utf-8?B?NzBsaW91blVUdWJGOGVXMXVYb2JNVzRIbTZ4Q0RnalBJL1dROG94Ly9VbHMy?=
 =?utf-8?B?M3JaNGhFRWc0MnJmTHo4Nm9scFpDeVFpQVAwa3lJN2IxUk4vaGJBbDRsSDRU?=
 =?utf-8?B?cTdrbklUcHc5WWZJb0J6WmlZU2hRTndKTUg5TEVGVlJLK3JZQlF3d1FqdGVq?=
 =?utf-8?B?aGtMWGZYR095ZDFBYWxueS8zTW5GNlE0WjV3cUQxVGJnQWdPWlU5VW5VRFU3?=
 =?utf-8?B?YlVJNUpuMXM1K0MvVTAzbkVwRDVPRDltRjFnc283RjhsS1lzV0M2aVE4cjZY?=
 =?utf-8?B?WTUxaHA1Rnh2RTlzZEtNaC9TRE5SNlZzbkRrUDdvNy9NU0sxY2VQSmVYUmVx?=
 =?utf-8?B?aEhUT3Z2RmdpRjJnRXVRTUw1OXYyQ08yOGtpNkxXejNSdnlkUXExVXZMZFUy?=
 =?utf-8?B?TEo3MkRndk1KaHNwWmNhRWt3Y1RQMndrUm1sdVpMV1RHK3BaQmZrOFlVRGhG?=
 =?utf-8?B?TlRCb0FPdktXb2YrUWR2b2F4N2hTS3hGSlltUXJ2TzFWNzh3RDJHV21XYldF?=
 =?utf-8?B?MVpPQ2JiRXFCaDZyR0VQU1VBWktqWmNMYmpEUk13WGVUY2p4aitoYkVyMmNE?=
 =?utf-8?B?a2NCM3NVdU9wdWxzZTRScWNRWmtzSzZjb0JPdC9jTHI1ZzYzMS91dm5vb3dE?=
 =?utf-8?B?UmJPazhjMTVFOVcxUWV6dVNCcytPTGE5NitBSDFxRkV5Q09OZ1kzeXlRa1Av?=
 =?utf-8?B?QXR5R01wMTcvK2VEZTBhMi9Wck1DL3hDSGRFSlozL3Y5SERGYkc0REFCN3JB?=
 =?utf-8?B?QzFYWXk4M1VJOElQcXZwQStDVytrOWN4OE9nakV3R01EWXNtSHJlSUtjWjZm?=
 =?utf-8?B?WGIvNmg0TlZZclBHaWhKd3dibmtXWDFuYmFsTXdlL2dzMXpyN2dsTVJGWGFD?=
 =?utf-8?B?bDI1ZjErRm5Wbno1M0NBTnR2eUFXaVZnelBBNm92M205MVRKNlVUcjdDVHli?=
 =?utf-8?B?cmRKOE9FWWpOMllDZHhZdjZJL244SU9oN29QOCszMkdzZHJpZGRCMmhuYThp?=
 =?utf-8?B?cEROOVlpR1dhcnMvYTdjUCtmT21xY3dmVkZBOEJ2eUM0YUdiOGxQaTBtMEtk?=
 =?utf-8?Q?4X27J+bpVGPRplclTk22SBpH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e981f-f6c5-44a6-99e7-08dd548681e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 03:51:24.1770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IEuWjOYasxdIcIqVQHRKgTKkvmaLgdGPBr9Eex8XEuR/MQmwyLj7OkrB0Xmjg0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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


On 2/22/2025 10:43 PM, Asad Kamal wrote:
> Get metrics table version for smu_v13_0_12 and populate pm_metrics
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 5e7e97d90805..5e80b9aabfc9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -208,6 +208,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
>  	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
>  	struct PPTable_t *pptable =
>  		(struct PPTable_t *)smu_table->driver_pptable;
> +	uint32_t table_version;
>  	int ret, i;
>  
>  	if (!pptable->Init) {
> @@ -215,6 +216,13 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
>  		if (ret)
>  			return ret;
>  
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
> +					   &table_version);
> +		if (ret)
> +			return ret;
> +		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
> +			table_version;
> +
>  		pptable->MaxSocketPowerLimit =
>  			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
>  		pptable->MaxGfxclkFrequency =

