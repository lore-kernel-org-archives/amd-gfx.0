Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B7CC71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 04:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C1810E142;
	Wed, 18 Jun 2025 04:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imIvDPZp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E635B10E142
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 04:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scv1cS7RagZdnyrHrjHR6YwiEaWU7PamGJfSC3WEElF/gZOc1We3D4vK6Z2KgZYbHprE/qzGBtXOId/k5b+u7rRJ+QJWsCYDGOhqZz1/bZRuslXCvjL+hX6cS7x1mYjHJ/JJUakb/WwjChp8NmpnMu8pavs1O7oHcYa2z0b9nnrxPsu+Sxl13RTiKLkVBDZ2r9msq3BcwoGLJPBlRUxvhu3EsZC7H9KacdwQOw+2WI1RJwQUZPbvjGrBMfBaDrHruuxwRBBaXZIuxtD1NeNljbKtfT4HdXLLWIJ8/+PhkRnbQu81DCwMV4ZVpuv+qUJGo06IXMzONzPCVJRHriaDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXeEAcky41qdHbYlWvPuDsuFSC+2Oj0eLEMD5XpyyDQ=;
 b=ny5XpVvYhFco2Y0EYAhtJ8UoRhyKPJgN9MyPQq22OUBQafYlRYW5YU1ki7E4SBCPH3gJDz/q9KiTBaJ+XBcbhLbIiIQ5Tof2HpsPo2VVkr+EXwO3qDaKfyec0I+xUsh0UfdqS+I0AjZ5SKJxBw1aTpB2NUzaYeW7OhvOvLaGxMf6/mgQqhQ6a0H56uds0SuBE6wno4+7HWs0s7NSo6y9HXFcj8deAiHFTdk1Nl7cdTW/M0h0ppV2fU1RDpv1tgyZsES411F2prU6/cvjbwjSOhU5vPeJ3Q59J8xsTmV3lKuNhmQQhPZsj6XgRV3GWj2EMoZYWVl5NNay7DbfNc2t4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXeEAcky41qdHbYlWvPuDsuFSC+2Oj0eLEMD5XpyyDQ=;
 b=imIvDPZppQGLhK8uPsi5S1b+QOwMbuH70shlJY0HrSKDEnJPtLPGdYT+/qsIYsIz52eWDkfsgXHIvEqItXO62k+KrgQFPlJIJGVwf0k5mi/3z3yD8BizPnfCTaOZfHxjHBxQIkJnfUO5LTbQ1wwf630PwFAQj8pLW3zXzCVYcVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Wed, 18 Jun 2025 04:19:21 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 04:19:21 +0000
Message-ID: <5735b924-7a7e-4d47-97af-c37e1f806668@amd.com>
Date: Wed, 18 Jun 2025 09:49:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Marcus Seyfarth <m.seyfarth@gmail.com>
References: <20250617183052.1692059-1-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250617183052.1692059-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 37589b2d-6b09-43c0-0296-08ddae1f4c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk5nWEJpVkJHcTJabmUwZ012T1hES2ZNemVFU3FEZ2NnVkR2cmErbFZoZ3ps?=
 =?utf-8?B?Mk56QTlmN09CMDlOZ0tMbFBmQkJmNXM1bTJKM014SlVlSnZrUE5PeTQ1QTRl?=
 =?utf-8?B?c0l3UHlXWGpZYUhONEw1eGVEczZyVlkvcm5ucG9xOHhOb29paStrM0hpUmVY?=
 =?utf-8?B?UDlhSVU0L2hEU3RLTE5OVUh6Q3czajNaZGl1WFc0MFQ0MDU5dk5wK3BKdjFh?=
 =?utf-8?B?TTVQOXlUOU10VStXdEcvdzB3Nzl0bTlZMTZQRFNwTjFJNytPLzd4enFrUkhU?=
 =?utf-8?B?ZkRXSTFsNlU1VlJoRDBWKytIWVFGVnEvWkN1a3VIS2FYeWk4dUphRHQvdnJB?=
 =?utf-8?B?Q25zdUkxVkVPbVZQeTM3ODFuZi9OT1praDdwaHo5emM2Zjk2Wk05cUJLaVQz?=
 =?utf-8?B?TG9RVERZNVhiL3dseWRzVS9nS0c5YUpuOFZCZGZna3hkSGNUOURVeHdLdjVr?=
 =?utf-8?B?T0l6cEl2dmkzTi93MTBkVFZBUUZTT1RINjRxRk1jTlYzeVAwRmtSQlhrUFQz?=
 =?utf-8?B?WnhUN2NWV3o4cXRsQ21ieFF5Qmd6djFjVUtDV1p0bThzNVJQNXplY1JlZ0Zi?=
 =?utf-8?B?cFU0OHFLWjF1eGZMQ2tYZGxBK2FPSUZZMzlTRVhya054V0loVkhydFluQmR0?=
 =?utf-8?B?aDR0NjhZd3BXVnc4M1kyTmZkeVZpUEZNdG5XcEtIcFp1elgzMHh4TnpiV3RU?=
 =?utf-8?B?VVBvc3NVZ2I3R0tYeHBBekZXTFExcmJYRC8xVTVWZWk5ZkpxYlVjWjBvQ3Fp?=
 =?utf-8?B?MkxLVE5rOHptSVZwS3haT3AzZHBZNHJXS0tWYVpiQ1ZEOWdYZkVXdE9DQi9M?=
 =?utf-8?B?ZG0rbGZVc2VsdTREcDI5b2J4bjRZKzlQdzFhOG1tVXdtKzFjaGRUVVJXb2dh?=
 =?utf-8?B?OWQ5bXIvd2xvMXZwY0FxRFd3RVV3b1NlQUpWamRBb05kVkFhWFZiTHFGOUNP?=
 =?utf-8?B?SWlkWEdyTDBndEdwTnczbEJwL3RqRmpQL215a3RweVg3TWJlejRFcVBTaTB2?=
 =?utf-8?B?cjhHZXZLT3Z6OEhLcWRyZkVjbGlmU2UvMWlCUGRET0k3N05GWUxuckpOZS9X?=
 =?utf-8?B?QXltbU5OaEpJVkVtQzY3aDRUV3dLanVTc1JsdkgxOTI2NnEzeEkrcStURDZM?=
 =?utf-8?B?aHU4MjgrZkVOSnZVQkRtbGZONzBiQXRZNHR2VHlaeFNWaUNsSEhBaFZIV0hC?=
 =?utf-8?B?d3dyUDhoU2JkUDdIRUs0OG5pbjR5TU9CZ3M1ZlE2aHhTTUNUeTQrdWludFNF?=
 =?utf-8?B?OXpEaWovVHhERHNKMTd2NGxhd2FFMXBqVmFhMndESUNvL2RUQlpaZjBTSzYy?=
 =?utf-8?B?MVE1c2F6Z0IzVzlKN1ZFSGNxbmVCWDViSW1JeTRQR1llQmJMeEJaRzd4VFI3?=
 =?utf-8?B?QmV3ejhhdEhwRVdZc1F2WUhTM3BQTklKSTJrUjAzT2VyNTZXTGIraWYvUVVI?=
 =?utf-8?B?anp2RDNZV2VQU3psR1gzTWEzeTFDRG9YOUZUK0dwSnNNM0RBR2g5WkRadjdJ?=
 =?utf-8?B?eVZ1OFZLWDlqNGdYQkxJRWxkeTlNNCt4cis3aDBHRmtuT01UVlp2Q2M3ZDB5?=
 =?utf-8?B?NjBSOFAzRWRYMUZTZmpTc0pkaFRqbzNydGU4MERHSFhjYXdkMDlCWDZCQ3NK?=
 =?utf-8?B?N0k5ekhBOXlpdFFVKzV2RTRpM1hiTm9IaVhSczVlcHQ1aW5GbStiZEN5VHYr?=
 =?utf-8?B?MmR4SVhyRXB1eVR4Vm8vbk0xZXFJb1NmUjB1NHN1Q2lDMENGU0F2Tkd1cFVD?=
 =?utf-8?B?Z0ViV1U3ZitLMkU2dEdLNTd3RzJVYUU2dXBYeHNJSUhlUGY4NXNiYStOVUtP?=
 =?utf-8?Q?16ZOrLQDNNS9jTbg609PjjhtdZECCYKB7n2pY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1MRC91YkRabFZnWnlzMitNTkVKOWMzYkVzMGJucitNWWJ0eFV4cWM3WFZC?=
 =?utf-8?B?VDlSd1RRZUxiWHo5TEpOa2lLNUFJM1BYOVVjNUZ3OFhPZ1M0b2dxdXE2MkdI?=
 =?utf-8?B?RGkxcjVab2NnYVp4V0k1MTc0OExJN3hxcG1uTWtKTFJ1OHNxNStmNkw4bzhF?=
 =?utf-8?B?OVpVNkQzd2RMMzFiWjdOUUNlYTE0Si9tNHkwZStkRTNvZjhLT1BpMmN5TWVE?=
 =?utf-8?B?R0tnSjNXU3RDVTBrYStyMDQwOWhOMzFCbXVzNVpWK2dZazEyRDZ4c2ZPeVZT?=
 =?utf-8?B?ZTFReUhrNFZSQlg1Yk1ISVJiaHhOYXhzRGlRKzRJanJjWXNVVzR5VUpIakNl?=
 =?utf-8?B?WG9XZ2VTdStSY3AzTkIxaXppZmlqWXI3UkJFaWxsSXV4NkQ2RGV0TWFlOVVH?=
 =?utf-8?B?c09WNG45SWI4dEdSY3N5THdWdUc4Q1BQVG85MXNXQ3AvZlpodFVvV08vL1RH?=
 =?utf-8?B?Q2dnYlpyS2o2R3J0VHZkUTNCYW13dTBVZHRFQ3B1dmlyOTZBLzFTUHVxeWE0?=
 =?utf-8?B?dUpGTm9oVnA0M3VyZlY3RlZ6SzhvZllvSXZ4ZGFaeVBaQ1ljeG96cnpBd2JV?=
 =?utf-8?B?NmJsRCtFRUZEZ3lCRkJwdXFmOE8yUVU1cmExT3lxL3gxV3F2TFNGb0hnUlM1?=
 =?utf-8?B?U0wwdVk4MG83RGx6OGRhcExoQ2czM3RlL1UzODZQWWs4VGRQSC90VVBLZExI?=
 =?utf-8?B?SVovN3FjazVjT3BHZFdYYmR4K1hzTFloQ3JTN0lQTkZvbDlOZlJUU3p4R2M2?=
 =?utf-8?B?RlcxOEZwaDdEb3lzRHlKbGNJWEpVeUcxZVlBSnFFWWJHZldIK3Q4QlFXV3Ar?=
 =?utf-8?B?UnpmaFMyNDNCU2pxbFU5REJ2ZUxSaFBUMlVNYkdKVTFkUFB4RTNuNE5BTWdG?=
 =?utf-8?B?OHp0YjZYVWlsVkZwQmxZa29keUg4YS9neGlrSEQwUnhEc3ZmMHc3M2F3MTRD?=
 =?utf-8?B?L2ZMaFR5SEtINURFeENhWmgzMTRQalJTNzZHZkdXdXFzdFZiaTQyMmpoem9m?=
 =?utf-8?B?d1JFRGJqZmRCYXl6TDExWmcxL1o5U0djNDhuVTV6bmhKUTAyYlFxckY2Vm9m?=
 =?utf-8?B?OEUrZUpmOUlTK28rWUxWb3EwcUd2YjZzWDlsTVA3T0hMMkNHanR5R2plc0Np?=
 =?utf-8?B?SG9FZXBpMlI0QlNPdHhrTHRLYW9Dd1RONExlSC9GODlLZGJ3UlhkSno4U05K?=
 =?utf-8?B?Y2MvaTBIKzJEcExyempKVklqOU1MR0lVS0tSQy94Vk50Ly9wd2JZampuUTRX?=
 =?utf-8?B?aklESVFmMDVHOU5yUHlhRjBQNUlXcnQ3ZVljUnFidmw0emU4RStOWm9nZkY0?=
 =?utf-8?B?MGFwdzlzZmpWcE1jMGljSWVUR25vekNOUjIweTdPMHVUOU9MT2ZlcG04Z25l?=
 =?utf-8?B?UWRrcGg4TXBJMGFIOXp2RnY0Z2VNYm9IK1czV1RXZUNuZVpydHBFVHlkZThq?=
 =?utf-8?B?Yit1TlFYdm5aMDZWOU1abnYzdzdvK3pERk9yN2FZQmIxQTBsUWdCRko4K3Rj?=
 =?utf-8?B?aWc0cWpVTG1oUnhZcmd3cngxamUvczVJRHpjTXMzNjdnS3hSOTZVd1RoU3Av?=
 =?utf-8?B?NGVsQUloV0lydi9KRHUxVXFWTXpsU0xWTTZnRnlVeGxyODMrS1haYk5GeExw?=
 =?utf-8?B?UEJTUjBUQ3RaR1hsdE1rWFpHMkptTDM5TFBPS2lWUWtLWll0WUhraFdicm1B?=
 =?utf-8?B?RytFNHB4OGVBeWZoUkt6YjE2UlBaNjBzenNUL1FNNzJsWXV4aEhKb0VtSjhC?=
 =?utf-8?B?eXNxWEJyM2FTOERTUzJQNytLc3hseXFpMk9ZWXhWSHl2bU1SRGtDSFFUcWJx?=
 =?utf-8?B?NkIxRndreXlwN1dNUlUyVzJXUGY2UDRHbHcwLyt2V3ZBUW1FWjUvYXM0cno5?=
 =?utf-8?B?TU1VSDlmMlVDSTVZWk9zZjRnM0RyQUlMcmd5SkVlRzdTb3FWSG5XVGxuYnVE?=
 =?utf-8?B?YzBNTDdaSkcrSmF6OG1FbTVRNmJMbWREZGV3Q1pVaTVuTHVZZDJaUU90MlE4?=
 =?utf-8?B?bHU3cUNXOENoT2FQWHlxM1RtMmZwS1ljNVZZNEtDNjlBK28xbnpPaW4vZjUv?=
 =?utf-8?B?b3BhZWlUK0I1VDlJSWhZY05kek13bnU4MUJkbHFNQStnWVpseEFWdUlqYXFU?=
 =?utf-8?Q?T5DipEW0rdWZF4JhyXgj8wHZ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37589b2d-6b09-43c0-0296-08ddae1f4c71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 04:19:20.9866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv9whPFp2fp65drp3tsI2N3b+NGUhpfLbGgQ0bGt1IHlBvpRUmeUAOuxHnnn5UHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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



On 6/18/2025 12:00 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> available") added support for reading an amdgpu IP discovery bin file
> for some specific products. If it's not found then it will fallback to
> hardcoded values. However if it's not found there is also a lot of noise
> about missing files and errors.
> 
> Adjust the error handling to decrease most messages to DEBUG and to show
> users less about missing files.
> 
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
> Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file available")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Add tag
>  * Push error message into default flow only
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 25 ++++++++-----------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a0e9bf9b27108..a29bd807e59f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
>  	const struct firmware *fw;
>  	int r;
>  
> -	r = request_firmware(&fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
>  	if (r) {
> -		dev_err(adev->dev, "can't load firmware \"%s\"\n",
> -			fw_name);
> +		drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);

Missed this earlier. Could you keep it as an error message if someone
intentionally asked for it - if (amdgpu_discovery == 2)

That aside, patch is

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>  		return r;
>  	}
>  
> @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  	/* Read from file if it is the preferred option */
>  	fw_name = amdgpu_discovery_get_fw_name(adev);
>  	if (fw_name != NULL) {
> -		dev_info(adev->dev, "use ip discovery information from file");
> +		drm_dbg(&adev->ddev, "use ip discovery information from file");
>  		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
> -
> -		if (r) {
> -			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
> -			r = -EINVAL;
> +		if (r)
>  			goto out;
> -		}
> -
>  	} else {
> +		drm_dbg(&adev->ddev, "use ip discovery information from memory");
>  		r = amdgpu_discovery_read_binary_from_mem(
>  			adev, adev->mman.discovery_bin);
>  		if (r)
> @@ -1338,10 +1333,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  	int r;
>  
>  	r = amdgpu_discovery_init(adev);
> -	if (r) {
> -		DRM_ERROR("amdgpu_discovery_init failed\n");
> +	if (r)
>  		return r;
> -	}
>  
>  	wafl_ver = 0;
>  	adev->gfx.xcc_mask = 0;
> @@ -2579,8 +2572,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		break;
>  	default:
>  		r = amdgpu_discovery_reg_base_init(adev);
> -		if (r)
> -			return -EINVAL;
> +		if (r) {
> +			drm_err(&adev->ddev, "discovery failed: %d\n", r);
> +			return r;
> +		}
>  
>  		amdgpu_discovery_harvest_ip(adev);
>  		amdgpu_discovery_get_gfx_info(adev);

