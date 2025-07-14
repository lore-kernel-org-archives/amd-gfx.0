Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DD7C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 13:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B4A10E07B;
	Mon, 14 Jul 2025 13:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQpzsvgd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226EA10E07B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 13:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPQmKXP/y+FkE4qSGOj5iVRK2ldd1so/hSXp0g34l9lb+Oun+VDrz/YHlnMiIkXinc3djkkDbdjaq872BEBsIZbU4ZzcELfA/FxvvCCZOva2sDrDUkQkKBzy6cQXgf7NymR+Tx50r83NH5MKI6T8Y2VXpGSpMHqWn6iGTL/A6u2fSH3X3i9ga2ZRRjsyLviu7gqPF3SeIap/Npg0PX7TgT4cB5fOWSrRBJDrFgIF0FBOIHM3I/aIpfpQrmmh+T393q10DMAKRLYaKnMSDHeEXgnEHJpqjde1foxvu9uqvUkEQAZcUpWjzpFOtyirZ7u/z5BOUR0snXLM4BasOlUgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyLhGB+bPmPxEzXz7O62mZkO/WJ/TtZ+Q6U3KIZvVaw=;
 b=W8BYcZZ9njhqUOh4CCGoy7ajCCuXgK+OzADTtcQ7EYu4dslDm+QzP3sakhO3tz6gl36yNJPw30wYv1G8KY+m0tbC/oq2ZTGYuaQz6rCMF7K4OlFHqIdWKW+PAupeufKRim32RtfYLjRoKOMIHy+ftjEI0XXG61q2t2UzP3VZZOvVGoU2Ke/d+R74F4dYlPYJRyz+A0o9IY7SHiexkLaNT+uoIeD+rNK2blkYVHS0JK8tM/yPCPKYD9gwGayw0IIKoBeCVV+G8foE92DNKxiTy5e4sqYPorEbsK7RqN3c4KDj83yyk/+DhI6pZkmPMM211DvKNWiVv4ZFHbevTHVJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyLhGB+bPmPxEzXz7O62mZkO/WJ/TtZ+Q6U3KIZvVaw=;
 b=bQpzsvgdmMN9doR1HvYmqcypBRKf0DK0KWqvgHrsvHd2V4QU1xjaD0oruOxVkogxM8QGB2pJLTcn+DCAWm8LOyrBYtJ+2XgaHI+WZWpEgYL7vN4/KldCpyvgY9KoGeO9CwiP90TLQQgLFQzVkczpmbkYhHpARj0mtsRr48Jw424=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:29:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 13:29:23 +0000
Message-ID: <7a024e0d-e863-4b6d-8e1b-dbfbdb972e8f@amd.com>
Date: Mon, 14 Jul 2025 15:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] drm/amdgpu/jpeg2: add additional ring reset error
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711224024.410506-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 36744cc6-896c-44e9-58db-08ddc2da7242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJ1eTBaeitTR0FRWHdzV01iMS9pa2kzSXdvMUtKTjBHRnM2L0ZUSzNxL3kv?=
 =?utf-8?B?bkpsd25jUWtLR21GQ1VKNnVzZDZvWWlsL3ExS0ZTWVB4R3J5cjFXMFNjbzJE?=
 =?utf-8?B?R1RmR1duZE9jcE5hcWNNbVVtdnV5SHRXMmJBNU9rR1lkWlkraHhXZG5FbUN0?=
 =?utf-8?B?V3hwQ240Vllxd3kyOURYTlkvMnBOckFTYkRYMjY1SzJmTHFqa24zYndZUVEy?=
 =?utf-8?B?b1c4cHpQM0pYQW0wNWlXUTRHdmFscmlqRUV3Q3JzMXhiWlhzdkFIN0IxWlpn?=
 =?utf-8?B?T1dsTzVqTElqcDB2VVBab3JrWG14UWZEcWVMUmdKVWY5aFV6TUErbjhIcHZh?=
 =?utf-8?B?MFFmMkNFT01OYk9Ld1BDU1BnaDRqL3A5NkMrQ3M1VDhUWlYwSzdIQkhFWHJj?=
 =?utf-8?B?N1BlUXZXQlJXL3dkOWYwcnZNMlN5R0Jwbmp6T1drclhKT3BpdmFaSTNXRklz?=
 =?utf-8?B?UWw2MVFUSFoxWERyLzhTS1JzNjFDb3pnNlVCSjJwWVlvaG1qYW1qMEh1RDFj?=
 =?utf-8?B?N0JkQXd0bVVUQzUrcmJjNlVvNGtvVzMxaGcxU1JLSG9WM25tRDVnSXh6aVlV?=
 =?utf-8?B?RW55bER1dHJ0WFdnQmxIZnhrdHpTRG0wc01ybkZScGZBZnhSYUNVSFVHVVlh?=
 =?utf-8?B?VE5sS21tUmdJZEtMSmFQMHpucGR0cHBzbzZYVkE1aC9wNXkxL1hGWFdsQUc4?=
 =?utf-8?B?eE5yN3Y1WEpVRjZqVEdmTGxzREdiOHNxb05pT1UvSDRlR09KVTN5czZFZWhY?=
 =?utf-8?B?UnZJTm1LK2l2eWhGdTIrakx4eEVFdHk0ZG9uNHd3TjBWNWd6NjFFdERFRHgw?=
 =?utf-8?B?a1FCYUlJSWxpUk1TY1V4SUI2OGFGYjlJRlliU000RVB1TXYvR3d0bk1zTUpR?=
 =?utf-8?B?S09SUThVUE4wR2JLMEYwdUVqRG9uSkgvKzFaVmhRRitmZlJsUmNEMXlZWFQ2?=
 =?utf-8?B?MWFmeENrUUs1MEQxNzBxU1gwQ0orNkJXOUIyZFREblZyTFBRY0p0QlU0VGxG?=
 =?utf-8?B?TmhXSlBkc2VwRHVydWo2ZVNTa01rNmFuc05FamxsZ0FXdUhlT2tEaVpDMnBH?=
 =?utf-8?B?bHplTWdiMFdCZU5FRkNoSnBFdTJJa2Q4endMYmFaazd3Y2ZrOSsvaFRVSlh6?=
 =?utf-8?B?S3F6MVVwUlhQTUdQZTFiSzR2MUpseHlyNkJ3aktqOUVHM1NGK0ZLdlQ2SXEx?=
 =?utf-8?B?d1N0U0xVREVhQXZtTTB1Z0VOQ3ZwRHdRTDkwS25STWt1VVlrYzNQWERDWXV5?=
 =?utf-8?B?allCS3c5UWFtc1BBRVhnaEZ4MENpNHV5TnNXREp0QnFFSUx0TjlJeXFDbUlS?=
 =?utf-8?B?aHVKcllkSTBXWHRQQ3c0YklCWmIzTlRVcDJoMTNFMk96bjU3b1BKckV6YzlN?=
 =?utf-8?B?K2FkdjMzck5BZHFzSjhKcDc5Um9UVmhPTnZUejV0aVdBb1RLcm5WTEs1STgr?=
 =?utf-8?B?dkwyR0p1RG9CUnNpZjRQbXlPZHVsdzlWWGlLL01hYWd4aUVRUkFJbC93Nkg0?=
 =?utf-8?B?RCtiOWh4S1pHSmgwTzJxdkg4ZGxuaW5ualJacmkzdkRrQjg5Y0p1amJYb1Ju?=
 =?utf-8?B?OFRCdkFKTzVxaWlyOEpxTUxhQ3h4dHpEUDhkTU9FL0JhU3YwV3NteDJUMGpS?=
 =?utf-8?B?WFVTYWhGT0RQRktoVFdFNnpWZ3ZlbzUyYVRySWVtZDhyTy9jbGRlOWtYQlV1?=
 =?utf-8?B?MU1MbFVtRHp4anRMa0NqZHdndDdwWEo5R0czSG95TWhHYzV2R2wwK2VCM3I2?=
 =?utf-8?B?bTNZR0VzQ0JneXhBbDQrV3poV1M0ZFVZTWxlQXJ2enNHVHIzOUVIeElyVWha?=
 =?utf-8?B?bFFydExwUzN4QjljNy9wemxSNlp0RUdoQW9mVW9heHplZDJLK2R3Z3o1c2k5?=
 =?utf-8?B?cTBNUENCWFQxRDc2SmdCSDFsLzNoeXBkWk1TWEdZaHRHOGVSYi9XaTUzdHI4?=
 =?utf-8?Q?8dri5EUz0Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVWVDBma0w3UEdtZzVRbHlqeWFWUFE1UDFqWDFobkJpU3ZtUmM1cjNnQTFO?=
 =?utf-8?B?MzhIVVBUb0hqUEYxcFdMY0g3VHN1elhLWEg1bU5Oc3o5c2pkbUh0dVlDNFBO?=
 =?utf-8?B?QTRBQStCWEt5ckVWOUNwa0xzQlNKYW9iaFMrV2VoN29aNmtiRE9MYllPU0RE?=
 =?utf-8?B?ZVBXVEEwMit6RGlCUFllOTRBSVNoeERuN2pjN3dIaWN4alI2WWdxWU01aGFB?=
 =?utf-8?B?THUvaitTLys3ZmxkR1Y5eUpONWlmYWR1NldGTk9SaTJtdXpIWGFLdCs0VFBm?=
 =?utf-8?B?VERJZ3NqU0tsQk1pTzJ1c05IQmdjenZoRnFSNHRvVFNONFR4Wk84WHRzMGwx?=
 =?utf-8?B?NktlQ3c1SitUZGF4YlVuNlhQd2NmRzhBWXgwK0J3SDZJM0h2MUNRNUxzbzhn?=
 =?utf-8?B?OFlNSGt1elI0VVAwWFdPMms4OXVrZWZqa0Y1NnROdW9CdTUzeWhYOTNvbG1l?=
 =?utf-8?B?dnJEVDFJQkI4S0xzRlZXUk9kbmhzMFZSTEdoK2FxNU5tZ3FibjA1ZjhuQXR1?=
 =?utf-8?B?QkJYbnljWWtWMUhqVGRXT1M1SlROZ2RCcFJ1ODQ3ODlrM2RWVmFvMTBVdDgw?=
 =?utf-8?B?QWRrMTZqSHk5ZHE3OWNJU0c3QmhueWJVaEtOOFlnK1RhQXZZbldDelpqM0Ri?=
 =?utf-8?B?Z3Z1S2h2ZDFCWHIxZ0NwdWtIVFZCRWdNUVZ5K0lhOTRDQ04zbFp2UUhrQjRn?=
 =?utf-8?B?UE5lUEVpMFg5clFKc1RRaExXWkF5OVJBOVlGYldvUU5ncHg0bXUwZk9UQ2Jq?=
 =?utf-8?B?R2F2MWxGQnVhbFV5eGRMWEYzN2J5MVpSZXhYajB6V2lyUUtDUGtJUEdaTmx2?=
 =?utf-8?B?ZTZ3THNMTzVnTTk5VWpVbmVNRWhKRXhCZ0tlenZoVS9MVGFxZEdMTmMyUzh2?=
 =?utf-8?B?TEdHdGlEY3cwcVZVcW9JL1hEL3JKMGg0WHhRN043Vk1jOS9kZisyd3pRQ0tr?=
 =?utf-8?B?cXVlQ1pKNDFEZThTRG5LR1pBdDJWc1hqV3BVUDZxUXFQb2lkdmR1ZXgyTEky?=
 =?utf-8?B?Qmg0VG1SUVdYeEVFeDFkM0h3SFBZRWtnbDRTUU95dGNTNlZ3WXp5Y1RwVDJu?=
 =?utf-8?B?THU4dWRZd0ZQY2cxaUVJUWMxL3loekZBUTlnWWJHTTNnY2toTFEvZm13VGtL?=
 =?utf-8?B?Wi9PV3RrNmdQVkxwTUI5QUJZRmIyektVNlBwdWQ4MDV5aVdXWDRjMFFPMnh3?=
 =?utf-8?B?VGgwVjB3UTlFTytYalpDdnU2Q0RtMmNrZVl2ckV6Y1ByUTlKZC9Jb2psNDlJ?=
 =?utf-8?B?eWxvdDNOcEhqU2E5M2kzcjhPTkQvdjlFQ2ZockoyWDhVbW5Wc2c5Y2R1KzFD?=
 =?utf-8?B?MzlvMjhJazhYNzBiQTRVMiszcm92VzlsdjJOVHJOMXU4NjdLdStDYWlDVjNY?=
 =?utf-8?B?Z0Z1ckxsVW5iN3FrRUJqOHpHcEhIZlRoeEJqNkMxOURxdVdzNkdUMUtzMm5l?=
 =?utf-8?B?cEdSRkhtaE5UMUNOTVlFU1BYcVRVa2VXVEFjdTRQWVFJTjd6dUYzeStNKzZl?=
 =?utf-8?B?bTEwaGNHRWdLOERVWktRUVpmbGRwYUtiOHMwSkxadmpnRjR2NDBYNEZ6SGJm?=
 =?utf-8?B?WTdBYWVuaWdUa25xZjAwa3RRdjkzUHdaTjhxdmdJcWh6TUdacUxER1hDUTJu?=
 =?utf-8?B?aFdvV2pJS25oTjVucHdFMjhzdnZIM3gvY2ZlVDdNM0c3dkRtV2czWG1IMG9C?=
 =?utf-8?B?QlB4bVhxRWdPdkNrczNMc254Rmp5bXI3L001dGtNSWZ4dGNXQTVuZlB5VTlu?=
 =?utf-8?B?a1JXc0t6Zmc0T3ZjM3l1WHVpS3NSVWt6S3JhSFdUSGhzVVBkV3RCSy9ORUQ1?=
 =?utf-8?B?cjV0TENOOEw0QjhmdXVieUVpdjNjVm9hQStsOE5qbkxJaWNPSnVDUTdtcFFU?=
 =?utf-8?B?bG1PNEszcnFIWVdPV00rci9JUHFWemZHT3VxNEZsSUhvdUtkT2RKbnlXUmVB?=
 =?utf-8?B?aHZlMm1ZTDYwL01LK0lpMm5lb3ovNXp1NEV4bEprNmMwM1NnRnBBanVYcTI3?=
 =?utf-8?B?WEJtbVVrWEY0eWlQdldqY2hRbzNkeWdqUWJMRkJwdkpyS2ZKS0dzaW5xU2w3?=
 =?utf-8?B?S1lQTkkwV2o0ckhCNm12dVIxOWV0MXJZakdKQTUwNlBjNmxsSWcrZnhuUkk4?=
 =?utf-8?Q?FWIoDnb/9FO7887+HXuM8rHqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36744cc6-896c-44e9-58db-08ddc2da7242
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:29:23.4924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScZMhomyJ18b8KTTiJlwdDqDx19vbc7Z580yW7T8bYNSNJFPpzBXPhBRwXMUD3b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

On 12.07.25 00:39, Alex Deucher wrote:
> Start and stop can fail, so add checks.
> 
> Fixes: 500c04d2a708 ("drm/amdgpu: Add ring reset callback for JPEG2_0_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for patches #2-#4.

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 781a5a8a83614..5ba1c5ad9a5e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -771,8 +771,12 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>  	int r;
>  
>  	drm_sched_wqueue_stop(&ring->sched);
> -	jpeg_v2_0_stop(ring->adev);
> -	jpeg_v2_0_start(ring->adev);
> +	r = jpeg_v2_0_stop(ring->adev);
> +	if (r)
> +		return r;
> +	r = jpeg_v2_0_start(ring->adev);
> +	if (r)
> +		return r;
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;

