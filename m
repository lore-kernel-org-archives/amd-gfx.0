Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F251C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 19:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92B10E382;
	Mon, 10 Feb 2025 19:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGc28stk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F1E10E382
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 19:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgaHyyCHKJs/s8ro73SPmkq7Zd9h580Q55jkL1lIXNdSQryaAiJIm4F3T89I45QxARB5DtwjbwukFZ82HNAX6M9HtUHsjLBcZh952Jm5anQUszMravbIcWDEmUW2RH7kQ9EYS++KPHcNDI3/qbOauWByQiJ0x8Q0qqTUPWJn4KfE8Si4XP9ilctpvMeDQmcr/XRCj1tXHWjrPTD+I94JniK4AD4xAyCWxVWKyqr5tZR9RjH7hqXnNpFue0DkKBmmyAoR3JJflroBT1scaDtE5dlmUnI3HtVWmpPEMfPybxbHnHXd57bteFsB1QheAaiCEWRh09k2omEvAO1KfwxNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNrgsjLq8UiC/fmr76DbQvx77GyvuRuGcpwZ0mIfEKo=;
 b=L566/RxpgNRp2AE9/AF1w83E+01vfH9oTG84LvxNtiSTepOqTHrprrlkaY6TZ2JuXp5K2YwlZs7KPGZeJR025Tj9p9kC+DUvhRL73nw7lzE1rceR9qwfwXck2DTmh8m0Ns9nS3YY4kG42KO+n7ACUVDPbVqSv6PFlGPmezOpRvqW0WqekNQIx9yHR443/JTOLXyzcmnoYIj0t7rMjRCq22WO6tu6CNrfSf98ez1ad2pbw1mpwBCRmlH10mMjVWNLyuikg5w4Q9eecKndNYdy8vUvKNWaKwUjWSbfjagzMSbch6qPrNaSfa40x+/bcsV/skKwJHFu0TzBGmgYXi9AQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNrgsjLq8UiC/fmr76DbQvx77GyvuRuGcpwZ0mIfEKo=;
 b=ZGc28stkvZ2wTn4mlpGn2tty/B7DwOG+dpuoiqXYcnZmhfKwT8hUeKJ+kxLchqT6dtzRXqW202nxH9i9jqkfZXtwRgawEQpnbvQbn9DX+DDMp5sSrh/+pS+MaSgJ9XA5N0GQ3DjgLHHjyUlxncDkQI9e3Q4P0t9yrLtWydWSI6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 19:22:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:22:10 +0000
Message-ID: <2fd0d40a-db7b-409b-84b5-6cd47eec12e9@amd.com>
Date: Mon, 10 Feb 2025 20:22:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
 <20250210142548.2321625-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250210142548.2321625-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: d9baa7d1-b1d8-41a8-ef4a-08dd4a08371a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzY1Zng0VjNpbkl4U1NZWVpYMitzRWs5cVBSbGRiVWJlVUQ3MEVTMGhqTEI0?=
 =?utf-8?B?T0xyVEpxSHJKTUU5ZTc3cTFoU2xKVWVIeTZDRnlMUjJhNFJNYWJwRms0eHNi?=
 =?utf-8?B?RzBhVzJFekNVcHlqRERKRE9GRjJWMVQzRUEyN3QvaGl4ZDQxT2pPVkFPdWNM?=
 =?utf-8?B?SHpJK3phMGtURDlRNWdlRFc5ZUpvZFFQaGRoSlZrd1NldzErQ09jVWc0K2h6?=
 =?utf-8?B?TlFRZzRnd3RSQlBKQkUxTjVJd0hldHNGUTY5RzMwMWpKNWNTRW4vb2FzY0pm?=
 =?utf-8?B?VXlzNWg1MDBLb0RxMEZMandJNGhGMVZEeDVZb3d2SHNvU1N2L05rR3NkWEJM?=
 =?utf-8?B?TWExVUNqQ0ptUHlhZDB1TzcwRnVGRTdtNkZYZ1J5bnNKWHk4eXh6U203MlQ0?=
 =?utf-8?B?WTBlVTlkL2swalpnOEVWVEx0aEtlSkJKbW1CRDJVQlZPWi82WGdzTmhJdTMy?=
 =?utf-8?B?S1I2c3hKUmxzVTRIMlRPK2UzQXpzbWZwRHVwblAzdW1wdDZuUFhMalJOY3U3?=
 =?utf-8?B?MmJjcjhUc3hoQmFsM3BmTWNjMjZsUVVUY3I1QnY4Tnk1ZDBJNWVhbkhHTCt3?=
 =?utf-8?B?ZE9hYWJGb083Sy9uMTRRUVd2S0tONEVVOEhmMVZqeEtqUXh1MHc3UmwwVjV5?=
 =?utf-8?B?bXVtcVV1ZTFNQk9xUXNTemh1cGdvSyt2QnNjQkxCeVVhT2NpYmZDS3FDMUJ1?=
 =?utf-8?B?S2VoNUpuY21ESHdVdGVTNEJ0R3pIUy94ZEYvdnlKbHJsUkJaS1dlWTRaMmJp?=
 =?utf-8?B?NXlaMUtrZXorOXdwTFViaGF3bVl2VW1Wa0piUyswNFBjazNTM2FXc2JZTTR1?=
 =?utf-8?B?QnZjalJtMFJLb0tBcnhmaXAyclZMdEw3MTJSbEt2QStDVHorL21IVXgxTStp?=
 =?utf-8?B?czhmeHhaYko0MUViMHFZdzZmcm1WMGFBZTBSVHFHQkttZVh1QUdNSlhmYUdC?=
 =?utf-8?B?aWtzMkJVY0JpU0NJNi9vb1hXa2d2VGp4WU44TWY2c29wWUJFY3ppOVVaQkRu?=
 =?utf-8?B?dXQzbkJobmh4ckc0akxkeDQ4Z3lldU5sbEJjYk1tMmFUbXFxNGtMbkZKbXMv?=
 =?utf-8?B?K0VTdG1pOWt2aXRtQnlEU0NiR0xDRmNQdjJuTHRvam9qN2tJSlJNbGJjNm9Q?=
 =?utf-8?B?ZCtFSUoyOXRSNHpITEJhOGFpcVdJakZFMkxYeDIvYWNCcTdUR0IyUmJVUVdn?=
 =?utf-8?B?aW1QYXRsaGZ6bGFVTndlVVlodjNhS2dZZjFaTGp6K09nSzRxckZHU3FoM01O?=
 =?utf-8?B?a0NhQm5xL3BaWlNFVnROMndwNWJ0U09lWU5jd1dLdjhreGVUS3lIb2tENi90?=
 =?utf-8?B?WG4xUTQ1bzdiV2NjSURpNnJ2VE03RXdTVlVvdGs5dmlaTzJ0SDZQSk0wRHAy?=
 =?utf-8?B?OU02NU9ENzJoY3Z1UlBGN1E1cVVIVllucm1DOW5GUHNEV2JFTlR0WU1lek5z?=
 =?utf-8?B?VnNBcURtOW9ZMk1mbmdVcWdjYThuK3ZrU3dwdHVJL1hCa0tBUWs2NnF5dmdL?=
 =?utf-8?B?UGdQbHlqQXZmM3RQckpPcjFiZ0FtajhodW1vYzlKQklYaXk2MnQyRDgwQUE0?=
 =?utf-8?B?U3pCKzFhNGxjMmtaWnZhWGx4cG54Yzl2Z2lCYThuejhDT3FhTXUwMXZJdVZm?=
 =?utf-8?B?V1AzUXora0k1aFBkd0Zva1pIa1JWSVhDNXVOL2VxTHFyNG81aWVEL2tmWWhV?=
 =?utf-8?B?RnJHOWVvbStxazQ1Z2swOVlvaVl3SXl3c0VNaFNnQzdMeTkvOFJLek5aZzNo?=
 =?utf-8?B?U3EydFN1K3ovdEpKNmgzTG5DTHE3VEZQMERoa2NPRkVhbDR1YTdSMGp6UHZQ?=
 =?utf-8?B?MzdGR2lnVThZalkxYzB2YklFYWgyUzZRclNseEhCMjUreU5LcFhPcm1kUk5r?=
 =?utf-8?Q?xZPhmucpnm/fj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStiWEZIeEV3QXNaU2w1V2FVK25BOWVDUGRjRXJTYi8yZXpha1RIYzRFYTRK?=
 =?utf-8?B?WHI2dWhJcU4xTWFJOVlac1REMmFsQ2JLbFlaR0FsSzRCVWxmQVdjTC9LTG0y?=
 =?utf-8?B?bWRhdEI2aTZ4OEZJSVhncm5yTys4TG1OL0RoeGpEUlRxeWlMMjMrOFh3V0hh?=
 =?utf-8?B?TUdTRnpHeXl4REwxR3ZGTWJkQy9mQXJlVjVlK05yTjZla05jUFJGemlFZGdo?=
 =?utf-8?B?dUVVYzVaZkVTVCtPYWRpSDRRN1ZVazE2NjMwaXZycURzTXhtWDM1ODl0YXRR?=
 =?utf-8?B?a2tnZnRaaDZBc3hOV09xVlQ3dDM3RnJoVm1rcGE1TXl5a1dZKzVlNXpCWTBZ?=
 =?utf-8?B?MnZ3ODJIZE9CLzRlcUxta1JMYUhRV1hoTGlrL2ZuR09DMCtEQXU3bjcyVk5W?=
 =?utf-8?B?WlpvTllIampuTHdsZ2NVckgxVGprRTkrWU9oQndHbndSTldTcjA4WjR0MTZZ?=
 =?utf-8?B?RGRMNGZSK0g2b2lHeWRmb3pFblMzYXIxNEtJd2E0TDRINmlMWHBBVlREUk9j?=
 =?utf-8?B?Z3p2NFRWSmZpWkVvZ0o2V1p6VnlGUml4ZVFpa3JSdGoxQjFnd2g1SCtVMDZW?=
 =?utf-8?B?b0FFSGE2NE16QXVxc29BdnQzNFJEU0RLMW0rOXZ3Mmt0SmhFRGszL2E5dDdQ?=
 =?utf-8?B?WjNLK1lYOUhCMjM5cmxRODYySVlCUEpZUGU1N21KR1FZS1orWEprT2VDOXFH?=
 =?utf-8?B?YWVtSm5NcTV6eGdJZkowSU95WEVHVDVBbHhWZURYOUpFSDZ3NzVSMXdaVUdJ?=
 =?utf-8?B?N3kwNSsxQzJyMkpLbFVvbEhOWUNLSjZ2d2djblpSMFgxcUcraitXeEI2ZlRs?=
 =?utf-8?B?bTdRVjVqZkQ0T1lGUFdBN2oyZDVLTlpHdkdYUGVsb3U5NWZvcSsxY2FqQ1dr?=
 =?utf-8?B?KzBoUUFJM3A5YjF0eWQ3YWIxOUpMVHllZXdGdksxVUNlM1NNVllGQjBRWlUx?=
 =?utf-8?B?M1V0aFpBSVpaTmtuWU5LK3BNekNPMVVmY1IyQ0g3MnpyTFZURE05cHpWRDZl?=
 =?utf-8?B?UWp0UkVEZmg2WGh3cmIzVTVMd1lJTGtrZ1A1YmszeDJzaUFyMkxnTHA0QlYr?=
 =?utf-8?B?dGVxaUVjZUM2cU1nQlV6blg4T2JIcXR4ZWdTL3FEdzFEM295K2crZndQY1Nj?=
 =?utf-8?B?NWFnUVY4VW9QR2lkTXdtdTcrTnUxbWw5OWhUd0N1MitEZXdMMy9SZGNvUDY0?=
 =?utf-8?B?NWtTangwNmN3aGVuMjRTKzIrTFVGSUZJMjBtR24rUFNOUkt2TFh5KzRJZkFV?=
 =?utf-8?B?VDdLNldQL0ZrbjhBQnVkSnZHZnJwWmlsMktkT05RRmtQbkZCL1JQKzBSdG44?=
 =?utf-8?B?STQ2Y3JRVnFWQ1pPYWJ4ZXJRUDBYZjNjMlNJbklHSUZ1QTNxRE5TMkNHeUJJ?=
 =?utf-8?B?RTVjZEFMck9WN01hbkYvNXVXM21LSFRtUDRycGdtNVkyZE9ZVGJQWkIyS2Ni?=
 =?utf-8?B?TTRaQ0tMKzdHeXNtQ3dzaERDRnJhY1JjUmpVRlhMWFFRZkpTWWx5cGNjWlls?=
 =?utf-8?B?WDRzc29OdC9NNktEazBZREZ3VWpteEpXV2RFMXV5OVFrUTFpamd0ZSs1SjJH?=
 =?utf-8?B?MkFJd1lkeTJoR1Y0a01oMk5HTVFadTliVDJ0L1pxdjJvd0R5cGMwbXU0ZGJN?=
 =?utf-8?B?Z1BqYlJFOGp3c2JlcWc3TE5zV3JEZUdySWhROUxQZmxvN0dqK3J1L25oRjNT?=
 =?utf-8?B?QmZuNVdTdkIrSG1OYkd6SXVIZW5rZzN0VHJIVWRadTFBb1hWMjlTb1BXQ0g0?=
 =?utf-8?B?bmZpdnFlZXVEc2ROaHhCbi9aRFMyNGo5T2NDUFhzb1VLRFdEQkxER2pFMzY4?=
 =?utf-8?B?ekJzckhtdTg0VWx6TVRDdEQ2TlY5NFg1Mmg3S3FHTFMwK2czTmVmTmFoMkJL?=
 =?utf-8?B?S1VEMmdkY1d1d0ZCQmpGVTBqNWcyVmJ0RVR5QzJRS21lZEFYN2ZqeFpVMDMz?=
 =?utf-8?B?RnpwTjZETDdtTG9Oenc3TEpQd0NKTi9OdnJpbjBRTyswUXR5WHlRb1c0UVdQ?=
 =?utf-8?B?QUdMNUxOR0daQmxZcUkxYjZmVHZoVEYrOEViV3Vab0lyYUFvaWNreUNJL1lY?=
 =?utf-8?B?cmFZT082QklGMEFoSDBXdWIxb3JyOUNGeXN0Qmo0OWdtMkdsdmJKaDdaSEx2?=
 =?utf-8?Q?/utgn7jXocqhta7WR6wlYxhH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9baa7d1-b1d8-41a8-ef4a-08dd4a08371a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:22:10.3878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YJZW1Rqk7IYdtQ0b16jLvVgo6l1rPkwS8tbkiepa+QC/M+4r3xSnKM042L2qMCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

Am 10.02.25 um 15:25 schrieb Sathishkumar S:
> Add helper functions to handle per-instance and per-core
> initialization and deinitialization in JPEG4_0_3.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>   1 file changed, 98 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 2a97302a22d3..be0b3b4c8690 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -525,6 +525,75 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>   	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>   }
>   
> +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int inst)
> +{
> +	int jpeg_inst = GET_INST(JPEG, inst);
> +
> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> +		     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> +	SOC15_WAIT_ON_RREG
> +		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_ON << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);

Please double check the coding style with checkpatch.pl this here 
doesn't looks so well.

Regards,
Christian.

> +
> +	/* disable anti hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
> +		 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> +
> +	/* JPEG disable CGC */
> +	jpeg_v4_0_3_disable_clock_gating(adev, inst);
> +
> +	/* MJPEG global tiling registers */
> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* enable JMI channel */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +}
> +
> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int jpeg_inst = GET_INST(JPEG, ring->me);
> +	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
> +
> +	/* enable System Interrupt for JRBC */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
> +		 JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
> +		 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
> +
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> +			    reg_offset,
> +			    (0x00000001L | 0x00000002L));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> +			    reg_offset, lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> +			    reg_offset, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> +			    reg_offset, 0x00000002L);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
> +			    reg_offset, ring->ring_size / 4);
> +	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +					 reg_offset);
> +}
> +
>   /**
>    * jpeg_v4_0_3_start - start JPEG block
>    *
> @@ -535,84 +604,42 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>   static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *ring;
> -	int i, j, jpeg_inst;
> +	int i, j;
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		jpeg_inst = GET_INST(JPEG, i);
> -
> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> -			     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> -		SOC15_WAIT_ON_RREG(
> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_ON
> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> -
> -		/* disable anti hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -					  regUVD_JPEG_POWER_STATUS),
> -			 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> -
> -		/* JPEG disable CGC */
> -		jpeg_v4_0_3_disable_clock_gating(adev, i);
> -
> -		/* MJPEG global tiling registers */
> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -
> -		/* enable JMI channel */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> -
> +		jpeg_v4_0_3_start_inst(adev, i);
>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> -			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
> -
>   			ring = &adev->jpeg.inst[i].ring_dec[j];
> -
> -			/* enable System Interrupt for JRBC */
> -			WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -						  regJPEG_SYS_INT_EN),
> -				 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
> -				 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
> -
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> -					    reg_offset,
> -					    (0x00000001L | 0x00000002L));
> -			WREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst,
> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> -				reg_offset, lower_32_bits(ring->gpu_addr));
> -			WREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst,
> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> -				reg_offset, upper_32_bits(ring->gpu_addr));
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> -					    reg_offset, 0x00000002L);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
> -					    reg_offset, ring->ring_size / 4);
> -			ring->wptr = RREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -				reg_offset);
> +			jpeg_v4_0_3_start_jrbc(ring);
>   		}
>   	}
>   
>   	return 0;
>   }
>   
> +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
> +{
> +	int jpeg_inst = GET_INST(JPEG, inst);
> +	/* reset JMI */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
> +		 UVD_JMI_CNTL__SOFT_RESET_MASK,
> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +
> +	jpeg_v4_0_3_enable_clock_gating(adev, inst);
> +
> +	/* enable anti hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
> +		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
> +		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> +
> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> +		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> +	SOC15_WAIT_ON_RREG
> +		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_OFF << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> +}
> +
>   /**
>    * jpeg_v4_0_3_stop - stop JPEG block
>    *
> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>    */
>   static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>   {
> -	int i, jpeg_inst;
> +	int i;
>   
> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		jpeg_inst = GET_INST(JPEG, i);
> -		/* reset JMI */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
> -			 UVD_JMI_CNTL__SOFT_RESET_MASK,
> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> -
> -		jpeg_v4_0_3_enable_clock_gating(adev, i);
> -
> -		/* enable anti hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -					  regUVD_JPEG_POWER_STATUS),
> -			 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
> -			 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> -
> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> -			     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> -		SOC15_WAIT_ON_RREG(
> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_OFF
> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> -	}
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
> +		jpeg_v4_0_3_stop_inst(adev, i);
>   
>   	return 0;
>   }

