Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B29C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 11:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AD510E66C;
	Wed,  4 Jun 2025 11:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPlx0ZIC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF3610E66C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 11:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBb8DqkJp7MMY8M1zk4HQjQgu6dhvZeur/qHKJaLe6BuL00cWdWP8izf46VlMgaSIFTglsR3Dh/TLklSSCJtVvOOEPQbsrO6r3uwMVGJbAPZkLSgU9m3SnAlrzztXiDYr9zR1gmY/LukVHkCXi6xhmZFYFO+HOMmd3wv6KmcSGefqcRhO2OBwFTXpoExpWMAG8izP3eW3PqtV5nIGzEnnG3HV5cjyd7+7y9ZhgNL5fgbyonlVkJAlmtVutLf0ddSx24M9NlJXjOze64uNFWs/YUnY3vJs78RK8bjcw8fNdXQEGVFz/hsPR4cJ3/aXvnvN32dSpt9PeWEPZLTtB17bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqtN6ysVXeTEPrfBqhjinUJUJ+9ntIA/mri3zb3HxXk=;
 b=ZMrdjk1xm1bOl04gC4NZqdhS/9JkcIiF7KlsuYbuX8DSVMPzVWthD+i+YKgMt0TJG26sQ9DLMRwm3Cu/EXIn5GJW32DmiRkmCZIm4jbCli2pslOCs7MNxmuBk71EXzI90mDKK/vKhHu4MmQgHNIioFWdXzWjxE7YM7ew4OzM2JzN8G/EatItThRpLAuKSP5Z5nN83i0Rm+b/VTzk/278hfMqzRXgC02CPp3S3rfT71Ws8O+ocOPO94bQmqJ3Ol9UpJKITeEPVvDSfu35LaB2gPz0z56fahrUzddU+IyM4nd3gIK3EdGgtqpYtovp1afThJjX8xSnonkM5cppBGBPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqtN6ysVXeTEPrfBqhjinUJUJ+9ntIA/mri3zb3HxXk=;
 b=cPlx0ZIC5L8v9Dd9b/vbKZwq1YD76fqkhGwj4949c97bfan/S7ETzxiO4E/o8u351Dwzsjiu0eXYEwqXZaofRvjXuBJCFOvaW9hJsb45pxW5hT3+3ZF9oxjxI1KSQZVDWBg/9JC5T6jDlrnW7dFuwQQExmcQZFRtYybPSGpac6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 11:46:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 4 Jun 2025
 11:46:03 +0000
Message-ID: <8c1ab1c5-e386-402b-8ade-802939214a18@amd.com>
Date: Wed, 4 Jun 2025 13:45:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 andrey.grodzovsky@amd.com, Alexander.Deucher@amd.com
Cc: Horace.Chen@amd.com, emily.deng@amd.com, yunxiang.li@amd.com,
 zhenguo.yin@amd.com
References: <20250604074715.2229924-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250604074715.2229924-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: dce5b347-bdeb-454d-d465-08dda35d6286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVJWMC9TTVJyd21CcFVTYyt3UDJOYk1XcUlEYlpyZnpRSExBajFFd2RXRGRV?=
 =?utf-8?B?V3VZWi9WS3R4b21MVGV4MUdsdDhGZmFqVHB4VUptRU10Tk9ZK21IWnBCVFBP?=
 =?utf-8?B?NUNCd3FROXpqS3dERURkYWc5R1l1aE4xYVlVcG9Lejl1RU45bFRtNGhvQWp6?=
 =?utf-8?B?S0NIcE01K3AxWStGUTFRTjkxUDN3eElKL2ptVTQ5Vm9HcjZ6MkxIOGE5WUti?=
 =?utf-8?B?T3hiMVR2L0tjeU5JczRick9EVDZ6cVpUOHJWNTIvcmdNa3hRQzJzd0c0OGNB?=
 =?utf-8?B?bXBoSWVhTy9EbWNxN2NaMnZ3bkRhU0I5RVZHalpLNEpqcmlmUWdMN2ZDcVdv?=
 =?utf-8?B?YytrdjdXZTNTd29PeXJBWUkwQ24vUm5MUE9UanZpYUYwREFETHB4VUZtTVdm?=
 =?utf-8?B?VExNUy9sL2NxaWxZVVZoNUxwd2w1SFhZcGlXNU1xMzZKZ3dyMllDYXY0UURw?=
 =?utf-8?B?SUlLbWQ1VDZQSTkzSkg5MjVTdFhxQ1hVY0pSSkhVdm5tbWNsMXdWdGJSTlZX?=
 =?utf-8?B?WE11QXlpOTBhQmxsWWEvNzVqNjZEQzRsT3hBdFBlTDZ1VkVpamJrR3lNTmg4?=
 =?utf-8?B?eW9VYjJwZEp4aUE0WHc3Tmp1SUoweDNmaGtROE00MWxKd1B2TERGVHY1cHNl?=
 =?utf-8?B?QXg5UDlselk4RmJJOWhmTGFjNWVQQ1Fhdk5DTEQxYVZTK0JIZFZpYk8vTEty?=
 =?utf-8?B?S0h1aW1VL0U1YWtMdnlwTCtCSElrYjFmbHpUaGFnMHlDSzFrOEN1OHlYYlZV?=
 =?utf-8?B?ZC82YnB5TFF5Y1krYlp2UEZTUFVsaURINEg4azYrOEJYdjFvVTh1anNFdjND?=
 =?utf-8?B?RFRrMnlEZFYvNWxEUWtMQXNMU096a3NlSVZCUytPaU0zOTR2N2VaTmROOG12?=
 =?utf-8?B?dlJYMHVzRmgvYS8xcnNYOUNid0pjUUVveklvZ1hrZmIzc2R1c3IxOHVFRCti?=
 =?utf-8?B?VmY2NzVvcHQ1WDk3c3RqaFpXOU9UeDFUVUFSN01hb1hmYm5WRGExYnN5U2hN?=
 =?utf-8?B?YTV3WktuekI5ZEk0NDZvQmozOVVFVWhPOVVLTUNzL0h4R0tBS3NsRG5Sc2Jt?=
 =?utf-8?B?ZTBkSlMvbTlyVXpZMXhYSnYyNjE4TkYzdTZhY0ZNM0JnMWNzQ0syTFE5OFNH?=
 =?utf-8?B?SUh3RUMrdVI1UEI2Y0N0aTRPMjRQMDRuYTBnUnU2U3pZSnVGYTNRUVpZTkFx?=
 =?utf-8?B?eERhTWFnT0cxb2p5alNUV2JaSSs2RnZFZVdwUlcxbXhwdXYrYXFyQnJPRDVQ?=
 =?utf-8?B?ME5BZVdXdVk1VXpGUGgvQlJ6OGRUVU5uWERjMWNpeFFDeHI1OHR2NWVZUGYy?=
 =?utf-8?B?a0Q0UVErclBjaTNLVzZqc29CUjQ3SzF4UFM0MGQ5cHJaTWg5RndNZXo3SUtK?=
 =?utf-8?B?cVFvTGVsNjVZNDQya2JrZDJMMUc5SC9RK25NcllxeVloOGRIa2liZUwyc2RI?=
 =?utf-8?B?bUJBNExMcVpOeVdZMlc1M05YYlFEc1FKZ2tIUmtScm9LOHFucnBSbnA1ZlNO?=
 =?utf-8?B?YWlydVVYWmZtUkVxZUQzY0lzUFFFekJNR002clZiU2p6ekVDOHpwbEtLUXVw?=
 =?utf-8?B?L28rZnNNTC8rMGZtcEd2Z2RNa2JnSkIwSjVzRE1sd0RMU0xlRXJCRG96TTdq?=
 =?utf-8?B?QTF3WGlOMUhDN0VqWU1qVUxKWXpRK2Z0QzlpWUJRZWorK3RMMUVWUFliL2tw?=
 =?utf-8?B?ajZ3V1BQamlDNUlFYkRQRTRjNjZPMGNQa3NrVFdWczc3OHNSMW1ZRGNpdGY0?=
 =?utf-8?B?elFLMUtWall1aEFyTW9EaVM5TzVOeWJkRUZtcG9QaXVGSVZJSUZJQXdKT1Yv?=
 =?utf-8?B?MW1XQytQdDN1S0ExZHdjQUI4SE5acTZ0bDJUcCtqVVMramFLZWUrbTVWaUZH?=
 =?utf-8?B?YWgvRnRRNVYvZWlDZjhYa1ovRCtuRjFSdUg0QWlCWWFMeVUwZWZQbld6NnhI?=
 =?utf-8?Q?WjQWALMpQPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0VTVzNIL3diQUVZZmNhZklUYnBVSUoxVUMzSDF5QVlKc0xtNDM1MGhpbEZr?=
 =?utf-8?B?akw5YmRIcTBvNlJDQVdrMHRQWHZPR2IvWmQ1dG5TWEM1bFlKNERxNlpRbHR5?=
 =?utf-8?B?dHdYU3ZTVFJmY09KOHViZXNYRnUvU1hQUXowVVlpaHozakluaVRRTlVzK0hG?=
 =?utf-8?B?MGIraG56SlJSZWR5eE1Bb0xCT0hnV2hyUmlXYmtaUWlxdlcrVmc0VS80UUlD?=
 =?utf-8?B?aFBacnJjL0txN0lWeThCY0Y5Wk9nTFVGckpVNzFNUjEvVTBNY3hWTE5veXBr?=
 =?utf-8?B?ZDRmWHcrbW1zV1R2d0I5VUN2eWdMTGFIdjFOeEFBYXZkbmhndWJuQ2hSVTBj?=
 =?utf-8?B?N2FmYXNtS0p1OWdKZTUreUlCL3NOTmY2VExlZTZKbmVmWXgrRlZ4dm9xNXB3?=
 =?utf-8?B?SDhKa0YxTGR5dEhVak85b01UajE4WHF5b2p3eWZja2ZMTGVlOEEvakpDTWVu?=
 =?utf-8?B?TWh2S0JkYjlUTlBBdU9LTUo0QWo0WjRRdGV1SktxTFhxdy9vNlB0Z3NoMEU2?=
 =?utf-8?B?MTNkeVZxQWhTZk5OUGR6MVQxN3Q5cGVBbEh0ZnZJRzdSMzZvRjNiMWJtSzkv?=
 =?utf-8?B?VmRWeXhyVGJySVlrUjJsazJnYWFlQldUWVd6TWloM2NLVmMxbTRVcXZ6eVIr?=
 =?utf-8?B?MkljZnYzenB5ZTMyT004WTBaSldFdVE2aUxES295VHhiZVFNakxrMTNEdWYr?=
 =?utf-8?B?SGFmaEN4UTVvdmpsWkhVOE9OQ1pucTFrNUNlVjBxclYvYmNVQ3dzbWJjdm5u?=
 =?utf-8?B?bEdRUDVITFJ3TUxYSXRoVXNkckwzQWZYMEFaN2RRRXA1amJSTFpBL1NFejlF?=
 =?utf-8?B?RUwxNFIvZjNyS0h0ekczY24yOWNGeGRzS0x3RVpVUEZyaXlZNm9Gd0dzZUxk?=
 =?utf-8?B?UVY0MWVvdkEzVk52R240Mm5BVDNzWWR2TCs2ZkRZVHJhcjB6M2NYL1J1U1Zr?=
 =?utf-8?B?cUN1VzZDenRSVmE4U2M0WjIxbkNwOUVYMjlhMU9rMkdaWjdLUDRNaXh3RGYx?=
 =?utf-8?B?ZzR5STg3ampnOVhlNk4zRk5XLytLTDRGMXQzNGRIaHllbTBFNlphWWlTSEl2?=
 =?utf-8?B?NXVZWVY3S0hxZzhRaDk1UCtIRFNaZEk1b2VRSHpKSVZtdTVUdjdrU1ZvRGZ6?=
 =?utf-8?B?MU9sYm1ac3VqZEZSTFF3ZzIxTDhNNDdaL09vZDRZZld4Vk1ub3FGejR0Zi9R?=
 =?utf-8?B?T1h2b3kvVk92Y0sxeFhqSFBzVGZFam56eUdWTTlKZ28vU3hmUjhNN0NLU0lU?=
 =?utf-8?B?RVBFREZJZTA2NkxwbmQyYW5FSFVpSEM3ZjhaUk5wWXowdXJ0U3ZlVEdRRGJo?=
 =?utf-8?B?NU9yZkVqQTZGTlJsaWxZYjg2RkREcjZnWXYxakthWDljaTk3aUhzT0xCOUc0?=
 =?utf-8?B?TnNONTkxdU1EWWwxY0VPMkh4U3FhVzFNNVFXQVBqcmJtQnJLbXA4dnkxYlBM?=
 =?utf-8?B?WSt1T0RvYnp6T3U2L2tDWnE3bkZEUHgrNXFwZTVlWmJMdXMxTFc5cUFoSU1z?=
 =?utf-8?B?LzFaNVMyemc2NkxMaEk4R09UMVZqTFU1eUo2Y1prTlBaOEtYZmUyUkVyL3Yv?=
 =?utf-8?B?T0ZTUEV0M295QytvSmVDRmQ0OE5MMWNEMkx1Z1F5UDhXaGVCNlhJeGwrdHJq?=
 =?utf-8?B?UnlUMUNpNS9iYW9ZWkxsUVFINFBZcDBLb2JPRkZ2QTZubXpWUGptMmJUbGhp?=
 =?utf-8?B?RkJ3ZEJDRG5ETjZWNTQ2ZEcvR1JZN09jZlU3MnpyNWtURTlZYlhzUWplRmow?=
 =?utf-8?B?Z2c2S3JZcHFnd3N3UmN1MVpYVWthL2J4WVh5bnZjTW1GaEJVcnkwc2NoQVUr?=
 =?utf-8?B?WkVRTnNQQWRuM01VMW1FQ3BZM2NlNWlCSFdGZDE5cVh5c0xxdmpNZGhxV0ti?=
 =?utf-8?B?VGRaVlcyUzB5cytDc3BaTzBEMkRVc2RoRGpjZmROQzQzYXlVNGQxUGZkTDdJ?=
 =?utf-8?B?NW9XZDJrb2dVMzRrdEFWUDJYMkFWTkU0dWZadlBWYzZjVHFxa3dUTnF0R3lY?=
 =?utf-8?B?WEFVd1dyT0xHTWNiMzdpLzRtS2Y3M1JTWUlITHdRbmRCRUI4SzRheEV2R21m?=
 =?utf-8?B?bTAzS1R2cmRsOXJ4NHF1MGJFaHQydzZuL3hGbG1hN0ZvckRNS3ltYysyck9O?=
 =?utf-8?Q?eEGLLnH2igon3CeDE/AHaiVlH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce5b347-bdeb-454d-d465-08dda35d6286
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 11:46:03.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRqtVXxpevUMUsK5VKaQWuqxwueMxuD272yKy9bHOqt4sik6rFceCVQlqae+UZd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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



On 6/4/25 09:47, Yifan Zha wrote:
> [Why]
> When host detected FLR earlier than guest, it will do HW reset.
> Under multi process scenario, MES could use hardware resource and failed,
> if host complete FLR work.
> 
> [How]
> - Lock reset domain in *mailbox_flr_work
> - Use AMDGPU_HOST_FLR flag checking in gpu recover to aviod double locking
> - Clear AMDGPU_HOST_FLR bit after recovery completes
> 
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 4 ++++
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e64969d576a6..d59053a2a7e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5413,7 +5413,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  		if (!amdgpu_ras_get_fed_status(adev))
>  			amdgpu_virt_ready_to_reset(adev);
>  		amdgpu_virt_wait_reset(adev);
> -		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	} else {
>  		r = amdgpu_virt_reset_gpu(adev);
> @@ -6098,7 +6097,8 @@ static int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>  				    reset_list);
> -	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +	if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
> +		amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);

Clear NAK to that.

As far as I can see the health check and other operations are intentional outside of the lock.

Regards,
Christian.


>  
>  	/* block all schedulers and reset given job's ring */
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> @@ -6293,7 +6293,8 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>  
>  	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
>  					    reset_list);
> -	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
> +	if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
> +		amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>  
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 48101a34e049..f16449fbbc5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -287,8 +287,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>  		reset_context.reset_req_dev = adev;
>  		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
>  
>  		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +		amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index f6d8597452ed..15e6e7cdd1da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -354,8 +354,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>  		reset_context.reset_req_dev = adev;
>  		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
>  
>  		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +		amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index e1d63bed84bf..c1b32081e7ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -524,8 +524,12 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>  		reset_context.reset_req_dev = adev;
>  		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
>  
>  		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +		amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>  	}
>  }
>  

