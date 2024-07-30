Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEB8C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 13:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9C110E266;
	Tue, 30 Jul 2024 13:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ufofFwkp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210AB10E09D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 13:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbbjUhHGXUOHtOmI1K1iB6vkslu1Mq24nA+oIkierMTf0pWp/bmrPTPT46MtSzQJWPO+pNA7giWI4VSGPCYA3o/uKPHwQ3YTuD0YxwbUYfDM/2BoMS5gBJ40cYdRT4XGL48kPKuntycENPxvSoFb3DBMvWov/baBI4yT9EEFP7DdGLqgX3/PsaNdcQRuVVNEaZJtvJutjozfGKW1fLcqD2Tj+f3zBTuQgeXQOOYwq/6FVIC3G38bKfHOALgqwc/sTTLsYE5NAQuTzN1raC+fudHj6014XuALqCz8+bmHAW/GfxTfW6S829/vJ2RPPYE6HskeMTv+dXd9Ww05oxFZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMoJJJHG3WYNRESmjKk7kF2lBNxp+cnEj/HqBiLVLrU=;
 b=HuLsZ1sQ8WIEJomHkO/20+9YmvpUoJrrDIP8/ytCz0QUjslo9BXR0U4LznhJwRDRq+S3Q26pNgA5wUXNDe1l/W42dAAoCH5QtcnS00j8/3XEyKCg8ILSacyW/j2I9qo4fZZvtBL59L5IxoUz1D/eQ9B10DefPE5wvgmSVrjAUqZnzaQ+xtb7f3ds5TjNldmwJh9n5dxt/HpGPF9M3USSErzC/lqdkXYDAQraEURArhlMF4dONLBJq47Tu7OioA2SH3j57QwJz5fYsJf4/0ITTi35M5MN+V7BU2plQGj+wx0kj34Yp5/g2eUG9Tj8wbUt8x9fQN+87T7YobwJa7G/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMoJJJHG3WYNRESmjKk7kF2lBNxp+cnEj/HqBiLVLrU=;
 b=ufofFwkp9q0CgwClQftR2iC7VDjHxh1jHjbrdEhibxpEP5nqyCQebtTWsKOmZm4jrMx3SmB15jKcP+4Z9c4iSbwy2l3XkZ0r9fry4zFXYJW6dbzOZVuS+Erg0RQ9MYuWB5r2Xc2Tk0TaEtiyd8re9jogNUd2Wc83b7HMQz9YxYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 13:17:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 13:17:23 +0000
Message-ID: <e080e4bd-be14-4431-888d-3bf9421158ea@amd.com>
Date: Tue, 30 Jul 2024 15:17:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240730124332.38030-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7d6a1e-d0e6-4721-022d-08dcb099f32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUFNeUR0RXU2VTBkOHdNZFVzRE9pRXl4dHI0enNaQi9wTW9wOXlxbC9CeUFO?=
 =?utf-8?B?U3Z3bGVVMXN4cXgrMDZYZnFvbW9TWmJ4bG1BMGg4cjdLZERrbEVoVzhDTkN5?=
 =?utf-8?B?ekhWYnJJSW5CeWlUdzljeGdwU2xhckNMcFplMkZLVGxyMFgxckhnVkRFMVFQ?=
 =?utf-8?B?dlBxRklNeGtzR2Q3c1p0TXVzVHk5blZpYjBJMGhDcGlkcXJlWVFzcGlaTm1I?=
 =?utf-8?B?bldjbXRVTjM1TFNFVWZ6c0tlYmlRWTU0NWh3SzI1YkpwVGIvNHJQTzhoS0xt?=
 =?utf-8?B?Ri9OcnF4NUhiOEh6dExmUGxZckFBYitwVHovVHVkS0lMV1BBcUVmeXFNcjU2?=
 =?utf-8?B?elV0clpkVFZIakZxaW1wU0o5anlHRnVacTA5aDgrUHhKbjEyRmRXd2RpczdU?=
 =?utf-8?B?aDZ6dXpMTEx6NmJmRnpuSUFMTU5tdjNmREJaaGJSY3JWejMvYzJoRUpVWjBv?=
 =?utf-8?B?bWl3aTJaZzVWb1VKektvVjJhLzVkajc2dmpsd3E1WFpCNTdpZTRyN09RNHJm?=
 =?utf-8?B?L2ZYeTBLUnBQc0FmZW1hZW9vbUthMUxXeU4wZXMxSFo0VVBmbVpJd3hwZzFh?=
 =?utf-8?B?ZFJSOUNoTGdSTkJLc09iQ0x6TVdYUkdnNjc5L0YrUGhkc3FhZjFwazdybDZH?=
 =?utf-8?B?cG5kcmhqZURsV2Z4NHRVWUs1QkxZd3l0QzRXMG0veGIzYTR3ckNHdzBPYUZj?=
 =?utf-8?B?anpneUw1bGFsZ3dkZU9zT2NpMlFBMTJRNjhkVDc0ekFycVIzT3BnUmVrOFRB?=
 =?utf-8?B?bitOcmZQRmlIWGhYZFkrak85YzRiRUNZeUgyNFhWaDQxY0pmM0hIeWYxNldk?=
 =?utf-8?B?RVpPZGdCRmx1cWJVd3JMY25PaUozQXpDQlpGaGVIZHRtbFdvM2QwaDYxaHVZ?=
 =?utf-8?B?NEtkRlRTOENGbS83QzNyeGZTajdzSi80QkhNaHFUVUlGUnpITTdMeG10SU53?=
 =?utf-8?B?a2dKZzZLaDB2Y1lXb0FlSi8vNWx6RlR3c2FaV0pLdFhFYlAwdVNjTkR5ci9W?=
 =?utf-8?B?UXFmcDZ2ampvL2lTcUVVRzBLUi9FWnRVWjVncUQ1NHJTZ0JldW04a3ZTOEZZ?=
 =?utf-8?B?dEsvVm4yT0hQaHBNSXUrMlZxWklTZnM1dEJ3Q3F1THhMdjh3STJ2OWNMMEtR?=
 =?utf-8?B?cndKTmdZcXRnVVhaa2NVMzNzZEdINnUrRFhhKzRpdEZvNUVyQUJQS0VkeWFT?=
 =?utf-8?B?T1VNNmJtOGNoc25xNXdhVGY1MFd4VHdVSzAzQjAxTFVlbUJmNjZWdDB1b2FP?=
 =?utf-8?B?RDVrc05Hd3JYOGtDTVZNTEFWcUc1TFE5c01lR1FRZmoraS85YnVHNmNmK000?=
 =?utf-8?B?VDFodlNNOU9aZm5SVDYyWXBKZWVMeHJiS1RLcHVUTldROHAxNFZuTnQ1VEYw?=
 =?utf-8?B?K2FpUldBeE83NUd3UlZZMDloUHJnekRWM0hXYm8yWVNwWUZzelRMd2pRRUt3?=
 =?utf-8?B?eW1JOVBCK2oybzhVOUZaL2FoZ1hIZlphM0o4a0ZlZEZhSnlrS0Q1SVBxck5B?=
 =?utf-8?B?S3gyc1NTVFJDTFlHNVhpbFRPNGtZci9ib1BSQkNmYXc1aERLUVpoRFNTaW1G?=
 =?utf-8?B?RThqYXRuY2RpTjZJMkdZdmhlMk9FTmoyd3hHa0tLT2dZRXdnby9DRGY5a0ZD?=
 =?utf-8?B?ZDNEbFNDdWVYUFNJS05LZ1JCL3ZJV1FoYjZTUUd4Y0U5dDQ5eTQ3ZnhCc0lW?=
 =?utf-8?B?blBaQmdGcDhRSm5UM3o3dkRSYWVGemVQU21Zd1hFelMxNnBlTU1LVHl4MmJZ?=
 =?utf-8?B?SlNYTC92bHpiVXZyQzE3OVpHVi9TVndmUDJ1MWNMcWh6ZCtrZjdSc1VyT2ZT?=
 =?utf-8?B?U2JxRmtZRlBDRjJGOXhGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVB6THpHTFJvZWZNSWhDZmp1aEtKUkl6ZzJaNWh0K3RWUUN5RjN4ZkNjTWJx?=
 =?utf-8?B?ck5GRHQ0YmQ4NGdRT0hVbGpWS3dDRFR3RHZmRmUvUmgzeUd2Z1JIemI3QzEr?=
 =?utf-8?B?bDB5eUszb2tRMm5hL0J1V3JTYklyTG1qRzdBckZ3amlTdWFVNXdRMXVoYk5z?=
 =?utf-8?B?SFJ0anU4N29OYWNJODJzNXBMM2NiQk50ZjRJRlpaN01uekVLTmdsVmVVbU9E?=
 =?utf-8?B?Si9neVo0VlJ0VERhZmlVaGlFMmtQT2F3NXIvWkhPYzhkcWcrSTFXN0Nsb0k0?=
 =?utf-8?B?MUp6bnV6NCtXWDRhUGlzTTIzMDNYNk5jazhoOFhjRytDZXF4UjNIdXdPMG1y?=
 =?utf-8?B?elpLaVNMVXFPUzNaOUZON2pRc1ZhdkgvRStrUW5SZEdIcjA1UFkyQVpPdndY?=
 =?utf-8?B?L01LbStnd0pPa3kzenRiemphYW5wTGNwREhzSTlKYmUrRW5UM05HalJ6RE5T?=
 =?utf-8?B?YjZ2OU9iSTR5cWpZK0pHQngwcDJORVM5UHR3ZFRxdzJIZVdKOG15elRLb0xV?=
 =?utf-8?B?d1Q0MGw3M1FUUjJsRXdzSFJzQUliTEZ2T1NkYkFtNTZnRVNOWW5iOEVVd2da?=
 =?utf-8?B?aGQ0c1hpMExWcFgwYU1KdERyb0xhL1dlRlNwN3REYUtVdFBNc05LTUZOQ01E?=
 =?utf-8?B?NWpKVFpmQStiSGZ1aXk3cjVIT1AyK3BUWWhGUjJWeUw0VVN5V0JIZ0ZJMGs2?=
 =?utf-8?B?Ui9RcVhET2FGNVVmcitZbUQ1TVEwWVNtbERNQ0dJQjhFdkN4SHlpUTVNa1pm?=
 =?utf-8?B?bFZESDhIOFhYOThRTFVmOE1FakpsbmloVWlXS0pEK1NaNE5kOHRhai9NM3RR?=
 =?utf-8?B?S2RqT1Z2WCtIZjNrK0NEcDVsdUN4QWpWUXN3ZkNzMU1wYVJ6aUg3MkVBOXZE?=
 =?utf-8?B?bkRtRnhScmp4QzJtVllCZHlROVhuZVhpaWN3VzZRUWlEdUh1T1hxUC9SRmt6?=
 =?utf-8?B?RmtUZFVEM2duWDBJZUlNbG85TFJMY3ZWWkVCY1VDSDg0Z2dwamFUY1NTQTVR?=
 =?utf-8?B?T2RHSENZT05iV3ZtM2d1UTFqU0RJNVJ6aTZ6SjVUSDBwSmxCb1lHcXNEdlRv?=
 =?utf-8?B?Q0M3MTQrRkZwMTA1N1F3S2NmUi9lQTBhZnpBWnVrUXZxOHUzelZVamVEb0Zv?=
 =?utf-8?B?bjNhR29BK05jNkJkZmlpYlVsL1V2dkFUT2habm1xVGZGUDZSNmpzUTUvMWs0?=
 =?utf-8?B?RXBuQkRGK2dZUlFlUWtyRU9rNCtkd1hCc0owSDRKWFozNUFVa1YwUVVKeUlC?=
 =?utf-8?B?YTQwUG1RTjhMc1NLdGg0NysxN0tzK3JOSGxsdDF5OWx5ekVUTUZ3ZHIvUlE3?=
 =?utf-8?B?YUQ0Y1g0L0wyc1hhYkxhS0l1cU1oSk1WQzZHa1lhc3JZWU50Y1NUTUhFWWFE?=
 =?utf-8?B?eFVBNjQyNEJoRDY3VXNPeTAwT0hDNlQ5YTZMZ0lYRThyTkxWZDM2NEN1SEQv?=
 =?utf-8?B?TjBFWnlnN05JOVdXdllvaUE2UmRaZ1ZMU3VKS1Y2V29qc1h1eVJ6eDFEbmlR?=
 =?utf-8?B?UnZ0c3FLZGxRaGJnTnpnODBKV2V6eXZ0SGphRDB4L0JnenNPOFVDSk5UckFD?=
 =?utf-8?B?WDM3SUVrbFNPOG90aG90R2E1Y2JPcXUrL1BRTFMrVS9IVDhiZkR3NXZNbHFZ?=
 =?utf-8?B?ZVF0ajlhRktOZGVmSHdqeDZ4K0Voa1cvM3NyUDN2VTVib1FGQlp1cForQVhP?=
 =?utf-8?B?RVdXYjY1dU1pa3JHaDZNRzlhZDFxaVU2aTI4Zm9DRktjK25nTktxTVk5ZmI5?=
 =?utf-8?B?T2tMRjZUR25sSTFYQXVoWTRZTWFJa3c2WDJJSmlnWEh4VTc3ZlM3cFZ6cGM1?=
 =?utf-8?B?OGY2c0ZkNTNhUGxVcTJ2NlRIUzdEc0VUaHB5aStUY3ZPU3VPQVE0M0YxVWxN?=
 =?utf-8?B?WktFaDg2Q2NkbHlFajdaRkZvZlFHVVJ6QXR3R2k0eG50MHlzZGpBR1h0dXZy?=
 =?utf-8?B?cXlwVHk3YWVEaXl1cWQ5VHhKckV4RjJMRnhiMWw0OUQ2Sm9hVzFkYXo2WXd3?=
 =?utf-8?B?YUVIUEVreFNyM25mOFYrSEE4Wm1SUGlkeVhDYUhPOEhEd2hzL1kwZVhMcE5P?=
 =?utf-8?B?clhndkJqV1h6dnpGV0VyRWdVeTVOWlAvODZCY0J2T0xjL2NJZllPQzREejRa?=
 =?utf-8?Q?9VNxYidPLDlmfW0sscL8h0F96?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7d6a1e-d0e6-4721-022d-08dcb099f32b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:17:23.7965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmHLEGyYpwyJMfHtkOrPJ5RiBHTapsD7AdG1031ujFWueN18tYa8IpzptxdKOUcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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

Am 30.07.24 um 14:43 schrieb Sunil Khatri:
> Adding NOP packets one by one in the ring
> does not use the CP efficiently.
>
> Solution:
> Use CP optimization while adding NOP packet's so PFP
> can discard NOP packets based on information of count
> from the Header instead of fetching all NOP packets
> one by one.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Tvrtko Ursulin <tursulin@igalia.com>
> Cc: Marek Olšák <marek.olsak@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 853084a2ce7f..edf5b5c4d185 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>   }
>   
> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
> +{
> +	int i;
> +
> +	/* Header itself is a NOP packet */
> +	if (num_nop == 1) {
> +		amdgpu_ring_write(ring, ring->funcs->nop);
> +		return;
> +	}
> +
> +	/* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
> +
> +	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
> +	for (i = 1; i < num_nop; i++)
> +		amdgpu_ring_write(ring, ring->funcs->nop);
> +}
> +
>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_switch_buffer = gfx_v10_0_ring_emit_sb,
>   	.emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>   	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>   	.emit_fence = gfx_v10_0_ring_emit_fence_kiq,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_rreg = gfx_v10_0_ring_emit_rreg,
>   	.emit_wreg = gfx_v10_0_ring_emit_wreg,

