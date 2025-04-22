Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AD8C369D3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3255810E2D1;
	Tue, 22 Apr 2025 13:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RW14fhDv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63ED10E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5ULtPVW/tsRxtcGYRgDsLAtFfT1DhAAg30PSty2fXg1oUBQ54h10gcXzb8f5k02FVAiIuQRpwlxgH4ifu9FnrVAZoAqX9xxkm5sxmcW3EEKJf8v7VcdpT34Gxq4GNxdTMIRwMOr3gxsXWrfSIBPGhY0/qO/JLGltbChsC2Ilx8Q7jID6aFwG7EyysLmiQ1kHgWiBCg4vN7ivAOPmGesxA1fzpmqOthh3PZdHoGz73cMb+5xxjW7zg2NxJOMg9nsw0v4sq2YjfZTAbqDFEVBha1hx3qw5hIg7rVM4tTq7S0cHviSuaHX2Cl5mlB+I333WFv5cL/OAS5vQf9eiqb6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcNQgd2V6dgKtEEQlBnL9wIEePjr0cZPq5sZ/SuzNJo=;
 b=O7pYeJD6VpPpVinmNcK3umvRF4MReUaaHPkPkAnur7WTNrcwrwvew/VwKfGZG5qs0iwoB1WhW5Yfxygf7oUOuLaOXIVy3LcdWZpVvSK0hUgZ+Q7Z9syalmgHkoiywgSnvsmoEARuIALyz2951TU0/StiIHZsTGVLSrZFKQStHIZogDzkE8eyAUiJAV4tqH7dZR33/oqn7mQ0GgaKOluMPCJG0+sVHq+Xzx8VObfax/gYFnOLhNldu1+S/LUNTCk61QPWxP1429hBdIpf3C1d24zrTiTyQpfPyVcHTdcYY8Umq5QTJueEmOby6y+2m3Z04NB2V2nOwbUxzuYfLIdgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcNQgd2V6dgKtEEQlBnL9wIEePjr0cZPq5sZ/SuzNJo=;
 b=RW14fhDvuoqQr4RVU0IX0rTIgKSGd4mYpo02qQbmL4Z0jFPfuH9iVI6dYS8s22hG3Mj1Ih/RtNGkQ8hmf+SMeIKAgvBTE836LqMgoLg6laeaKk1BANCeiZKylh+aHJW6K+Oi2NHbZYTBWz9TesJX18+OfWcEjQuEUQ/FcVvr9BA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 13:36:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 13:36:54 +0000
Message-ID: <4720bc65-7c42-4924-841e-277782290eea@amd.com>
Date: Tue, 22 Apr 2025 15:36:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: add the evf attached gem obj resv dump
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250422132352.3988185-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250422132352.3988185-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 61544aec-17ac-4ca4-7b5e-08dd81a2bf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE1rV2FVSzcyNFRlNSswZ2FQSjFFbmVaZTZhbWUrTlJrUXluV2MybEZrSzZj?=
 =?utf-8?B?R21HdWhEdWNROU9SbHdaakRJQjZQVmhWZDNNVlh0K2JxMlhCVjFGNytDbVpS?=
 =?utf-8?B?bzllZDNVeUhFRWZrWVUyRVR4QzJlNWsyclJzRHhTOG9uM1dpZjVKSjhDcENp?=
 =?utf-8?B?Y1BIUE9SL2Q2bmRZME1FNVNBSTgyNjBOMEI0blBtZVJzU0ZEOG5vTzc5c05k?=
 =?utf-8?B?Z08yTGt0SkF0dGh2VzJBUFcybjMxYkZQZTdySkxnVnJ2bjdTcFpyT0g5MFMw?=
 =?utf-8?B?VnIyK1FjdmxOcFlUZkF4R2tYOUZWangxVEgyand2RmRpd0FwcGh3VEMrRHg1?=
 =?utf-8?B?TTc1ekRuZGVDZUlGa09SYUNrSWhRbFVVYVI2alZIRjBNMmdJcEEyMXVHVVkw?=
 =?utf-8?B?VTZzMDlNekZ5bnBQeTI3QzB6M2J2U3B3WTEyUGFaQWEzU3RsbXJ0aGtUWncz?=
 =?utf-8?B?aUt0czVuUFFmU0pBWXZBc0EwMHFoMTE1R3A5TzUxdHBpWHpDdkRJTithTWMx?=
 =?utf-8?B?S3dLaC9OSjRRajdGcVFrK0xUKzROS3hvRmZxV3dHQ3ZRZytyZENHblYvaFEz?=
 =?utf-8?B?UEN2eXB0VFQyZGxQUUZrbS9sTnBqL1puOHYvbm04UW1pVnJFQlNQU21tblpj?=
 =?utf-8?B?UFdjdEE5dng0L2RGbSt2b2xrZ3hEZmdick8vMTJpaC9NL2JMdERNZExmQmZQ?=
 =?utf-8?B?bkNsRkNiQVV1ditjendkVyt3TGdVRzNLaFNoWGFHanNnengxNW0vWVFyWGRC?=
 =?utf-8?B?MzVibDRicVU4RjUrN3lXcCtLZ0FYS2U3V3JLTkUzS2p5aDZVRWpGWVlubDNS?=
 =?utf-8?B?ZXZpM3UxYmFQWWJTMzNNdkxWQTRFa1BvcllEVGRaWEI5Z09xN3pIb2ViTFV2?=
 =?utf-8?B?dnBFN1M4NS91SHY1am5sMnZEUEM0SWErM1V0N0dpLzhrMmdrcG9uL1RlcE1Z?=
 =?utf-8?B?WUxQSXJuQmd0OFo3VUdtNTJBQVF0L0dNLytPQ3p1ZzVhVHFodUxTaVJrdnh6?=
 =?utf-8?B?Rk9sMERWNGdORmFDSFJVc0gzMWVXR3l2dUpIbUtQd1BMTEp1aUZEWmJLdDkv?=
 =?utf-8?B?VTFhWVNhUktmOStFQ2I5NVhZYTQ4TFRZZ1N4YkNCT2VhU3NIK3p5cVFxS2JE?=
 =?utf-8?B?dHNVRmlvbUdBNHk5OFJwY1RiWWU3cHlabFlOU3ZwVnNSWE9acEJEMkdJK3pH?=
 =?utf-8?B?ZUxaVWNVU293R3dTcnZzUWNxQTQ3UGp4MVIxMWhTcDNDOEdvZ01LTHdRSitM?=
 =?utf-8?B?aXFKeTZVdThuSjVqeXdMTnJ3YWZjRmUzN3FTWGdRTXVRSUNrdHV3SVY0dzNk?=
 =?utf-8?B?eFJ2UlFReXQ3TE1OTWNUNUhZVjE0anVPUFhNL2JyOHM3alR0a3BoVnJ4bUxC?=
 =?utf-8?B?RHQ5cERFM1FXYVRxZEJ2MllqbElsSU9KS1JqZlFEc0VtV2F3UUh4blJ5SS9l?=
 =?utf-8?B?QXhzaUhnaTdFWWIyaWVYZzFNcHpCaVBUOVBSYWJDYTVIWW1ha05XYXcwMUxF?=
 =?utf-8?B?NFhIVHAvVmJnU05Wemg4bi9FSDZra0VyV3llb2dQNVB5Z0NYUDFVaGtKZmpy?=
 =?utf-8?B?ZkxJdjZZWGQvZDQzdy9EQTRUTGNBbVBPanBzT1lZamZ3Zk9jbWFuWmoyNHpY?=
 =?utf-8?B?V2s3YVBpV2I5WWtsajlFdkZTUS9IT2lFaDU5NXBVTlFxU0JZdmxEUC9vS3Y4?=
 =?utf-8?B?bGNWM0o3SEZoQVdDekY0WlBzRXExR0lFVjh1a0gwVGU5UTZub3p1SVRXMU01?=
 =?utf-8?B?OUhYcmNqdWZvNjNQSkJCRVNscWJpNkl1M0crM3FhaUxHZ0VwRGgyRHlXR0hz?=
 =?utf-8?B?UEhOR2hwSEZ3TktSdndwOWNoY3ltYzF1eXE4eGxhNDNzbEJ1V2Y5aGxibG9y?=
 =?utf-8?B?M09zU0diSWdNekd0WTV6RGQ0WERHZ2ZBcXlmRHFJVGxzMU1peWwvR3d5K0o4?=
 =?utf-8?Q?Y84ddZJEPYs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRyaUVHbmsvaWdkSGMxVldUcVVTaWpoSnVuYVJsWnB6S3M2dGJTWnd1TXcv?=
 =?utf-8?B?YXBvaEZsRFFUNTBlUDByTnoyLzd4ZjdGRS83T0NOQlVPcGY1TUJYWUlRdmtJ?=
 =?utf-8?B?TURRcWxCWlZXYW1xZW9XK254VVZlYmxKL01VQjZFd0huWTNLWVliZ1EvVjlz?=
 =?utf-8?B?UmhEZVd2YkZQeHI5eHhINEpzeUtpWUFPZy9MUS81ZG5HUjMzMER3RHlJZGtv?=
 =?utf-8?B?eFJNQ1ZsaHZmenFVZTFnWnhhZlF4dGY3TTNIU2RCMnRHN2twSEsxWFBYTkNK?=
 =?utf-8?B?NVhxUnRMV3N1WVN0ZTQySHdiSDQxUjI2RXJ3MUpNWmx1WFVyNSthaU81RDdS?=
 =?utf-8?B?dURKT1Yvd1NaT2tGRzliTVpHbzhRMG9qWmtxOEdScXpQRDdISEZzQVUrQVpk?=
 =?utf-8?B?d1JRcStuREpNYXIxc08xU3ZPVk94VlMwdzNKelREVDN3YUY2RUlxQW1pVVZD?=
 =?utf-8?B?TSsxMndINGlRRExacSsyRHFuQzRoQjhKZDlVREJzNityNHdHZ25ka3hPZWZP?=
 =?utf-8?B?U0M4M0h4UkRZeVIrUUQ2YmR6c203aEdVc2lNbk03UzNOMGIyUDJUZzZjQmNa?=
 =?utf-8?B?QjAwTFZOSk16Qzdqb2RsNFFzdzhpYzF3WEY0c3hha0JNMnJHTG92MHFCQXp3?=
 =?utf-8?B?eUllSVhLNlhPbFFUU0wrelUvbW45amNGU241WUtYQW4rS2FmWCt1eVBGenZK?=
 =?utf-8?B?cWNBSWFEbXh5TTA2Y1JKNUN1ckUvVWZpUnVvYW5IL2FiTTk5SkpXaTFmOE5Y?=
 =?utf-8?B?amJSTkRpdk1TYkNOSlFwM3ZXUjNJY2dLMnhFcFdkdEhMb3M4cTVCUElybjFK?=
 =?utf-8?B?WHZ1Y2xTV2FVQ0ZZcHdCbTB4WFdoZHZEcFpyRXpISFppYW5Pd2QzSzhNRTk1?=
 =?utf-8?B?RURKWjk4VkxwRGdlR3FmeHdsTyttLzkrZ2NReTFNOXlEV0NvdlNoaC9WWk5N?=
 =?utf-8?B?WEZCSlNiOHhBNEV4Nld6WWVwcTQ4WE51UzR5TjVvemRROEhsbDZxeHgxWXlP?=
 =?utf-8?B?NGMxQTlXek81TEJaYmJxNG1LTHlpN3VVdDlQQmY2bllNUzVXVld5bGM2R2Uz?=
 =?utf-8?B?aHNaNXcyR0FkUTFmSjJHMWxteWlqZStrOGIvejcvUWxRbWpNMUl1UzNyMjJs?=
 =?utf-8?B?am1TMWNDQzdOcUxPWk9MZkpBWU1JYVRDbDlGRmFSV1hjRkNtUlQ4Zml3eFdh?=
 =?utf-8?B?N3NueWc4ZFdjRkl3d05zTVFJWmV5RzFWUklQSTRteHA4bzc0L2ExTDNQRkNq?=
 =?utf-8?B?Z05vUXVKZllXeHJYRXptWC9sVU9hUUx1QUlxeUhsWXNNNERteXVGZG1UbFZx?=
 =?utf-8?B?ZTE3R3Ewa2pyYlhXYVdvalo2TElCZm1DS3pzMnE3RXVoT1RRZ3B0WHE0VmJF?=
 =?utf-8?B?WVRyV1VGa1d0VnpXUlBPVkwrYkNtZHdPazlyN2NmUnNxSmNpdUlERzd0amZD?=
 =?utf-8?B?d1hjd2FCbmxXeUNYOFptaHBDelNJUjVLdVdXWG9ubkpaem9sTlRaVHVId2Z3?=
 =?utf-8?B?emhHTzh5b1g4Vzl6WW8veEJmamtUR0dIK1FzNGlUK1QzaW9DSlhibjRxMXFj?=
 =?utf-8?B?V2lkME1iUHJNNUwzdGtDL3hydGkzTWtNWGh3Vk1SZDhrbER1Vk9KZmZvSFBB?=
 =?utf-8?B?UnhqVDMwTEdpNWN5RWNBaE9MMWlaZGRld29ldUFlSDBYNkNYQXBmdm9PMkJz?=
 =?utf-8?B?TWxaaFRlSk8za0hjOW5mZ20zT1VkWC92MFc3WURNTzVUZkhQd0VSWWdEM2Zr?=
 =?utf-8?B?WGkzVDdYMVJ6WjdjVmN1RjcxYUtBbnJEeVI1ejI2MEdFRmtLMVQ0ZTQ2d2Zi?=
 =?utf-8?B?aXVwY1hPM1JCMk1HeU05YVM3MDlzY1lOQkM3Rno3dmtvMTkzUXhyK1dDRXdn?=
 =?utf-8?B?QW8rMERpS0RwSWs2dkJBTkFuNEJSbndsaTdnUnR5N2NPTmZkRkNRdC9hWGg3?=
 =?utf-8?B?a2gyYjh2WlVONkFNV29hZjN1d1I3NElvQVdLb1ZwdU1iaUpvWi9qampxOFNH?=
 =?utf-8?B?MU5rL3dqSFpndVBUUFlEYWRURGhURVh4aUs2UlBwNnRpaFdzRFZkaTNFV0hx?=
 =?utf-8?B?Uld0SjFOeEk1b1VZNm1wQjdtR1I1ai9kWmFucmtEb0I4VFZOQmJiM1BtZ3Ji?=
 =?utf-8?Q?uf8MNfgQVhaxgVYz6vjOvVD6l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61544aec-17ac-4ca4-7b5e-08dd81a2bf01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:36:54.8645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LB94zb2tSpWY5dc6JaP4rTmzh9gWH5D+yR4IADmTktxsNTeKS0qAmNaJFsQa+Kfl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

Am 22.04.25 um 15:23 schrieb Prike Liang:
> This debug dump will help on debugging the evf attached gem obj fence
> related issue.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d09db052e282..1e73ce30d4d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>  	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
>  	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
>  	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
> -
> +	/* Add the gem obj resv fence dump*/
> +	if (dma_resv_trylock(bo->tbo.base.resv)) {
> +		dma_resv_describe(bo->tbo.base.resv, m);
> +		dma_resv_unlock(bo->tbo.base.resv);
> +	}
>  	seq_puts(m, "\n");
>  
>  	return size;

