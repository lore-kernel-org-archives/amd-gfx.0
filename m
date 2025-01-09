Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17E8E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 06:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554F910ECEF;
	Thu,  9 Jan 2025 06:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRRkjOs/";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7061B10ECEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 06:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZDda0YB1YGwBXUG3X+XYbQq51br9gNxDxKiCtmNGVcd4pjG+CqWcfBJ+5CErjUR8xJt9FANEjnrNV0opzGeG58vbFoPcrphgNSmxjn3d+21r8rpr/M2EENAiVOR/7eQeeC1fJnN3tWXiJ2+RrYyBPssiDfGSECFoLuwHUfyaliO6+Bf1d8tF0n35w5ddrnGFnFCnH6Y77sjQkqFJB80a1TI70hFzmohmJ85axbUYa4GULQ34ij05/sCHWVGqPxU6/5RFfqx1pC+RFYc4gIfpVXeZ36uBwaoT1+UNevyPPjf1iSmVgCpGKmkKpwSTXts2cTepX3piLinglfovqI7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42/T/i5NcJ6QsW9OyYX5+vsPZ7ppaXL+SYgKO3zTJrk=;
 b=ke060dilBkoxAHXxgf2bYyimabkm6HfbjYJgr9sQnZGhV7lTg0T6WFhfd3pdb3QPjDppT+hAyOQS2F8U9NqDrmiTrUwNAkB0Y2pBY79K6AWtpAaC9n4ouekhi4s4m1CtNHiFv4QDwardydX19UVp52QOduB9wKiYeIKzxH06qpGawJXGPl/xLyElrgYmv57ILHPW70SCVu3FU0y6xudvnVnh5TPb97eWuFz8T8NZxChSvR8mkQq6lFObBq10f69JTBpR3uGpdIPuMM3ClITTS6R+0w7Tz7iE9Y+7Ew6pPUgCPJHqrj6amnn2LQOguZG9IfC4I9Y0BCaNjo/vQTRJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42/T/i5NcJ6QsW9OyYX5+vsPZ7ppaXL+SYgKO3zTJrk=;
 b=oRRkjOs/WrvAOJjx5cEx66WqwFvwPw3MeFtmjD7tS9eYoH8CWL1pfhNMFi/xo6TX8MoV9B+mEd5VPNJhmLZo/u+UVlxhZAVVa4qATlC7yk2OTR9XRT2FkQMzmHcUPikLULFb3O+Bb5mNG+QYMcvhreR1UEZKrNmb3SwpRbly/vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Thu, 9 Jan 2025 06:14:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 06:14:13 +0000
Message-ID: <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
Date: Thu, 9 Jan 2025 11:44:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250108200121.2808908-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2f6788-9c46-4b12-8d12-08dd3074d6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXowM0J3bWNDWVVrd0dpbGRKakF3cSt5MzVCZ2E5SlVLcW5xYXFVb0FWbkY5?=
 =?utf-8?B?cXEvTnhYMWpmNUUrcmlnTkRlc2dpSXRFWmVONzJmYzdiOXJEaXJ3OGVHMElX?=
 =?utf-8?B?QUhyRVdSVDkvcXBvVkxzUytoeXc0WWpzcUx1bVNwbXoxRUNWRUlVK2JEMlY2?=
 =?utf-8?B?Kzg0ZXd5NkN5clFOVTg3UXRsUjRlVnZuTE8wZUxoVWRlWUcyZHhycWxmcjcr?=
 =?utf-8?B?aW1SUWZaSEFWbFhXcDcza2kwWjNDUkxwWUkwTGFmSHlTM0prTVpFZGRTY2po?=
 =?utf-8?B?UVFaUll2STFoZWFoVWNPRmJmWVhETFA0aFlKZGRpTjQxOUNIYk1NbUFSTU4y?=
 =?utf-8?B?WndEd2hzWnNhWUdlQlZWK3JzcFlmMXh1dFN1SHpkV1EzSW5nclBnTVBuVDNJ?=
 =?utf-8?B?N2c5b2Y5YjdKSW02cUZabkVCNXJyekVRUHdxNWVmVkRGaUFRcUVtOGxic0Nv?=
 =?utf-8?B?MGtJMmRCZzlFaDVtQS9rZ1dOc1R6TXNhYi84bnZYemN6MTJGeUpmcmh3dnk5?=
 =?utf-8?B?TGNvM01YU1MrcDVuSG5vN2F6NkExb1pwRk9JWXFXNm9BSTZBaG1PV3UxWWll?=
 =?utf-8?B?YlI5VTE2RmtWTEVTYTA1VmFqaDNHVnZ1WXNmb0J4M0xIbGFzaUZpS2dOSEVR?=
 =?utf-8?B?SWYrWUovaDVneFZBY0o1N0VETS9lY29QT1lWVnp3RHdVM1FGSjFWZlVJYnZ0?=
 =?utf-8?B?eCtnYy84S1p4dzVLK3FyRCs4ZWlpZUhxbWd6MmhLb2dLZ2hlUGkzOHFSSE5V?=
 =?utf-8?B?UVBoc2FvaURIMFlhYTUyNHVIU0dQNjBYU0l4UFBzaTVlOXFvNjArWTE0TWMx?=
 =?utf-8?B?c0NZWkV6bHo4cXZDRXg0U1gwMkhJeXBxYUE2NjJPVHdmd0NoV1FnS2dySE1B?=
 =?utf-8?B?ZE1xWEJBWFpRSUxFWjBQd21wWTFYSXNmQlp4NnQ2NG5WS2xtZ2ZZK3U4QVZ4?=
 =?utf-8?B?ZFYzMkJGRWh4M0thOUpqLzZuMmppYk0rbVJzNGdaSXY1QXBFN0krMi9Ha1Ns?=
 =?utf-8?B?Q0NuUmFQVlZ5SGhsL3p6eW0rcHN4d1hjYWFXL0VUMlJ2ODQrSEpxY2xqOHAw?=
 =?utf-8?B?YlBWdkNiZGpjR0pCRFJDK0hKME9KNDVlaUJ0MmpHMXpWMi95Y0huemxxUW5x?=
 =?utf-8?B?dFpmalhuZWRFQTdkblA4K240RVBKWnVxMnIzWWhpbmNobGRBcE5QTGhpV1du?=
 =?utf-8?B?a0x6elpBckdtSkIyYk1kTHZ0VXF1TFV5cXlsQXNwa1FlS3Vnc1dUSlY2QkZN?=
 =?utf-8?B?bGNZK1FVbE8vbkJ2a2UzRTlpSVU1OG9WcUNlNFppTDBhb3NDdi9uUXFjMkhj?=
 =?utf-8?B?QURPdTNyS3V2ZWMvd0FvV0h4MEdHVURFYURhdXk4WVBKd2hQdDRMeVVIMW1a?=
 =?utf-8?B?aW5vNUhYY2ZLZnBMcCtoT2ZvMlprcjZrT0dNSjBKV3hYM3FaMHY5RTc3d041?=
 =?utf-8?B?eEp1MnpMd1RmUVJwZElhUHZRby8rYzloQmU5dzZLMXRBN2NYTmExRnhQTGwx?=
 =?utf-8?B?UEN4M1NNd2dZdURFWGhsZis3RnlUdWhMeEFaSDZXdE1lY3QxazRGRTg3YVdi?=
 =?utf-8?B?RHpmbnJIaWtDWjc0L1dEUkowVkZwdXNxVGljU1h5eFMyNk9oT1hMd29kTFh0?=
 =?utf-8?B?WEFOVXVNNWxCcEVMdE1xT1BBdU1JTmgzNzVtQ2E4a2xsTVcwSWVQdjlYdjhz?=
 =?utf-8?B?eExMU2crOWkyUi9EWHRBYWRMOGl4UDJwdk1yMHJsdGY0R1BvLy9lMGgyS01w?=
 =?utf-8?B?YW9LSDJpWitQVkJMeHJ0UE5ybFZMSjViR3YydDhLNUM0Z2I4V3NRSGlPcWsy?=
 =?utf-8?B?N3hYdmJNMHd1WVY4eVBqb3ZYUlRPa2RaMlVlR2FUM1dnOEVFRnlRQjZNbm5s?=
 =?utf-8?Q?hpsfBgUeKK8MN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJ3bVNSV1cyNmc5TkRHbFVqR1hUb2xESWJyeFUwYkpibTQ5ajJPbzBzTy9z?=
 =?utf-8?B?ekY0L1NaZi8wanNCbmVKQzhYbUp1R2pTdUpHUWkzSWFPTUtpaFJzaW51SVpI?=
 =?utf-8?B?NTBxVlBKY3k3SzA3eUJKN0NpZ0Z5VmNaYzhsbWVMcnJhVHhteGF2TERoeHo5?=
 =?utf-8?B?bGg3dmw2R0tRYWV2RzIxajR2ellMOTlYNDdSR05KVHdBcEYwSEt0UGg2TmV4?=
 =?utf-8?B?cnZKV2RTcExHNnlZeDk1dUs5SkI0aWZyanVBdTdQVUhERk1FUEV3cTJJMkd2?=
 =?utf-8?B?ZExPV0g1WVRMNTZ6RTV4eWNEQXNYdXgzSmsraUhnU0RWVkFoUk1lbWJqdGhz?=
 =?utf-8?B?VTcybHJLTVh0TjU2RFgyTHF2bnpjNGYyM1NFTXE5RC9RUzd0UXJzL21Pejc0?=
 =?utf-8?B?WGhyejFjSzRKdXFYU1A5ZEVnVXRqd0F5UTBaT1hlZFQ4cUloZE1lbnZ3cTQ3?=
 =?utf-8?B?NExWaW1TMlVPTTl2THkvYU4xTEtSVVlwaTVCcWRpVlBJUmtBZUkrYm4wNEsx?=
 =?utf-8?B?YmN2OEcvOEtxS1hkWkJGNWlsWmlld2JCM1F1UUhmNENzeFVQUGRUVEF1Z1JT?=
 =?utf-8?B?OUgrK2grTG54cHFHMng2QUVicjdhR0NUSGk0SEZyYTBBSUNJajlNVDQ5TCs4?=
 =?utf-8?B?eVhNT2QrODlvL0xXbEFhSUpKRHUwbjhHSGkrUEVNUnBqWUd0dEozM0s4WlhN?=
 =?utf-8?B?dnNUalNEZkx6Yy8wa2cweXl3SW9qTTlLdmJ5UEtadHNwd0R4L1NMOGkvUXI2?=
 =?utf-8?B?MWFzOFEwSTV5SktvaW1qUXBoK0hYOUpSQkI1OHpmNEU0YkowbC9TdS82V2Nr?=
 =?utf-8?B?MmRCMFlkRGlZUGNBR1ZrNGRlb2FHZlU3ckZoa2pwS2xyaDBmNDVXdFZMMUxC?=
 =?utf-8?B?cHV2eERmVzZmMHVkb2Q3V1JINHFIbjRxOTV5WXllUVkyL0V1aHUvaUhIQlhN?=
 =?utf-8?B?S2t3cFJYci9BMlRranVvWjZaK1RjT2hpNld0OUs0Sk5WRlp5cTRJY0ZQV0tB?=
 =?utf-8?B?c3MvVUV5RjB6eDQxQVk3U1ZJZk1RY3JJK0lVYUlnbnJrZDZmQjRmRVkrbTFv?=
 =?utf-8?B?cjVPUGhmdDFDWE5WYW9uK09HZ1ZZSkJnbnlhZHBHVjAvM3cwKzB6NnV2Tnky?=
 =?utf-8?B?UStlV3NtZ2dJRVp2WEJWRmcxTDNWNzRMclc2ZERMenJjaWoxbE1wdVk3ZG5v?=
 =?utf-8?B?RHhYc01xTytnT2MxSm5zMktTb2VEQ0kwL3h0WGRqUm8wUmx4YU4vMjYzbkx6?=
 =?utf-8?B?djc0U001Tmg0NktRb1Y5Q1Q3WUt2L1ZyVjUzZVdRU1grVisveUtpYzVLelZP?=
 =?utf-8?B?d3p0N0ZOY0RQeXFFRXZnRWpucnpqZW42dlJFaFNHWkV4cklNNlkrOVRaZjUw?=
 =?utf-8?B?bmVha1lKa0h0a1NsS1FPV1loL2pyUzdlNlpzYTlubUJOaVk5clp3ZzVLNWt6?=
 =?utf-8?B?TzF2OGNaNHRlT0NqT21sME9TMzUwb2ljUndLTTJzV3Bmellram9YUUpoaDFI?=
 =?utf-8?B?TzlVWXhhSUlwcVhXRGUrUVM4UEhuSE9KMlVUNHNMcHA4U0lRWU8xM0kzNjFJ?=
 =?utf-8?B?OVpLU2hweDd5cjg5VXcrZjlETnYvREZtWTUrVmQvWTRrUld3dU9qeXdWZEZQ?=
 =?utf-8?B?Qyt5YzVMZ0dxMExrZXVxYkVJbmdiZ1lWZll3emRkTVpYSDJDYndEUlFYc0la?=
 =?utf-8?B?cU8xR2g3OE0xUlNVd0UyN2xmdnZjU3R3UklDRjE5amljVTZTTFdZT0ZDZGRZ?=
 =?utf-8?B?c2RNVVVZSXBubklsT09TazFZc052RDNoVUxhTmwvbHIyY0l6cmd1QTRxa0lW?=
 =?utf-8?B?TVloRDk0b0lYdU1UZEtGaWVTVnhBSFlNbFBXSUZ2R3BPUDRvQmlJNXhqT2ht?=
 =?utf-8?B?SHh1TGZ2cExxLzFQbjNPMmJDMUZuZXFaMWZvVys3SE9XemNVdTRQZk5MNnFD?=
 =?utf-8?B?dmtpRGJhNkp1SXFHeXZrQis1YzhHYyswRFFjMWwwNnFIbDIwYXY4YVI0dGRp?=
 =?utf-8?B?VG9QRHlqOGVXaGxGUTF4eUpoeWhPRkhTbFRsdDFyY3Q3MVRFcTIySVdZWmhj?=
 =?utf-8?B?b0liOW9yRy9GVGhoMGRYcy9BNXo0Z3orQXhwekFSckQyalYxMEJob01VSmZs?=
 =?utf-8?Q?Nk/ZO0btVhy/sYhrr6ilBAHVV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f6788-9c46-4b12-8d12-08dd3074d6a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:14:13.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/7W0hzSoSsSrUJyqjXYsIdUK5q+tOsfJ4d9ScIg1t1+hXJ8nGHJMUoQRYt/XodB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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



On 1/9/2025 1:31 AM, Jonathan Kim wrote:
> Per queue reset should be bypassed when gpu recovery is disabled
> with module parameter.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index cc66ebb7bae1..441568163e20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
>  	uint32_t low, high;
>  	uint64_t queue_addr = 0;
>  
> +	if (!amdgpu_gpu_recovery)
> +		return 0;
> +
>  	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>  	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>  
> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
>  	uint32_t low, high, pipe_reset_data = 0;
>  	uint64_t queue_addr = 0;
>  
> +	if (!amdgpu_gpu_recovery)
> +		return 0;
> +

I think the right place for this check is not inside callback, should be
from the place where the callback gets called.

Thanks,
Lijo

>  	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>  	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>  

