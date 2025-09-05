Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D565CA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 07:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009DA10EB2F;
	Fri,  5 Sep 2025 07:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1un+Tsk5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E9810EB31
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 07:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXiGIftjNkD7eJqp6cQb7Afqu/L4R+QXh4cednZKxbg+v9KKEB/OSkkqJr7te+SSJHaq9TvBwLwJNlmf7L5qL42AsOqwsmIZLeSGmi+xY/PJyjZg3p7RwGYP+uE7m9ICF9YfcLb2dPd523Ky7nYztoF9uaqKH1YUkiYpO8UwnDXh0vYL6jqlOLbbJ7m4/7a7VxvoYpT6RGfNqhU/JOb2DU8jBBwOPybTdkqeXRcg5blXjB/QZobZiZQKLuYKwZ2XDvllAi7HQ0UoTcgiX4npJ7HgDedFHEcUMZBX6Oo387ipq3nRbgvIXG9XjX04F1pKMnsjgQ+6QnebOgpNqCN0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKhWbV5enyy9QqBierEgLcldbkh7BzC2NdXs71YujUM=;
 b=tZkd6rVtJpKCpIR91QFzP56yv9ue2L85Qa/PsWPq4LgK4riOhdI8ZcCGR6NNo93E+O6pXKFE+sV5ud9AzPmmu5HsQWiGJANRmFRyn29iSJXWtLrxjRDDUFvdSc1m2c4jK9Ak/ME1y11riLjM8zZlqWiD1eeN7ykhPdXWhQQBsSN4402CBvthJ4+j2NPeUPKAJNagmQPIj0ubw8sjrhTuM23Hu7hnNkv+AiyCUENikvovBGBRW38BpvtC6/m04xl0MA1+nNnm8cULeetmjMQkACKJfZZLoijXKfv5J8o1++hZd5/je+OIXV0hFgg2d8BgCUziBPKMl6f/mmIW1Lx+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKhWbV5enyy9QqBierEgLcldbkh7BzC2NdXs71YujUM=;
 b=1un+Tsk5eckoiur4VqpJPq4Xy/Hrwf7JipjVrzOP/5dgXGgDYnC/fvEqGbp2gRLXSL5s8uzl1GbFIzbaPySLUyJkG2UbtAkHipLLlJxlKr9jO4jFze51Iodp0Tztn1sAwuUlXxtwNvmLGkux8gD3el36x0Ag0lK7gN5zDQRgr6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 07:22:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 07:22:39 +0000
Message-ID: <8c6125fb-965e-470c-be6b-d91059966cf6@amd.com>
Date: Fri, 5 Sep 2025 09:22:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad
 context
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250904144546.59539-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250904144546.59539-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2226cad6-33af-47f4-5aa7-08ddec4cfed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGh2c3VEZWJzcXhsbHBWUlV6V1JXNFNWK1NQN3JPcVdpU1U3ZFJTQzJGamhP?=
 =?utf-8?B?M3NyM1JWMjF5dEhvWTJKOHQvVnRxZTdGTGZNbUVNREY4elRjVVBZS3N0eFN2?=
 =?utf-8?B?aEhEb2JBZ2Q3b015L09EalRqem5YMkVlOHV2ZGNhdFhXRTZNMDJyQVhpVkZD?=
 =?utf-8?B?QjgwRERIVzVKSWdybWlHZEQ1cVpiWGI4dk1jM0RIeFFNWi80bkZwL2dmcWkv?=
 =?utf-8?B?R1JGOW90TitlYXQwS28wbnJDZEpmUkFVYU9JRDMrTGRRTFNaK2lkZXZtL055?=
 =?utf-8?B?WjVieU94Wm5LaHArTWtXcklxdlJCQi9hUFJESHgzZStKditOWU5adGVDUXUz?=
 =?utf-8?B?RWpqWkp4ZzJENTdwMU9FNWhHc2ZYT1lEaHczUnpMVU9XSDBjancrZS9hQ0gr?=
 =?utf-8?B?TUtveCtrZ3BBZGtpMktLaVVPbGlFMjUwRDNsQVVGdGFmZHVoY2VVdFkyS0g4?=
 =?utf-8?B?ekZBTUx3c21ITUZSUFRYbVA4S2tqYzVBbFVzTjA3Q1NVTGFpci9RbUNDRkxo?=
 =?utf-8?B?YTdmM2o5TlNETUk0ZkFhRkhVSXVqWnRZczFrb1hrOWtoQjV3NHdYQnYxYnp2?=
 =?utf-8?B?VFBzQjVycmNvN0ZyeDA2dnNGZkNmcjlQSXpkUytWUlBEVElWL0tDcytFZ3lY?=
 =?utf-8?B?OEppNnFlT01yeWNtYnBZY2F2MjAwbnJZNTZjR25tWTR3RlRhMVNzTUl2MjVR?=
 =?utf-8?B?U3pSTjBSUjFQd2JlanlhKzlXc0hwUDVoMmIyditONXVtWTcrTi9oRGFNelR3?=
 =?utf-8?B?T1VBVlE3WVNtM3ZyMnV2eEx2R1dBOS9vc1FNcDFYZWhjS09IZk1YT29sS3kw?=
 =?utf-8?B?SHA5eTVyekZsY0UzWkpWLzJsUVRMU0l3VGNobno5M2tRVkZWd3ZCVzQzS3FW?=
 =?utf-8?B?SDNTQ0E5L01rZjZKd0kzSjAzNHE3YUlhWG12Z0wxQWw3NE1BYVB0SXBpTE00?=
 =?utf-8?B?UUs3bzdJNnBqcy92L3ZvZEtIOTh1L2ZoL05iQnU1Zys3OElqUnVPNTNDTDBx?=
 =?utf-8?B?TjVyTjZDS29yWU96YXh4RmlaZXA3N2hBc3RnUFYvWmVaUU9BSFpJaTFKSEF6?=
 =?utf-8?B?SE1tUks3Z0pxdERVMDBXTnJERWh6NWhLdWZJa1Y5RUJVWVpGMzhnNWJITGps?=
 =?utf-8?B?THMwVGVlVkwvYnRkb1NHSEFHemJNMzFUMktSMHlHQVJwRkhiRlA0NVlZUGt1?=
 =?utf-8?B?c1g0aVhuRnhkMWQ3WTZ1bGRKMm9yN0tpQ1pjc0dhUGNFam40NDJDY1VlVDAr?=
 =?utf-8?B?YWV3dlh2b3F2am9KMDF3WnRsSHpDakQ0Zlc5Z0EyQmR0VlBJODN6REtkMit4?=
 =?utf-8?B?cmd0OFZITXhnNUlnRGtIOHEwTEdSbm1TalgvdFFhRnlvTVFDZEhWTVAxT0Mr?=
 =?utf-8?B?RXBEQ1NZcW5wQzAwM0R2U2wwTDlqOHhDREQ4VTA4ajlWUkdLQmMzN0M0YjJO?=
 =?utf-8?B?R2xWVFBxMWR2TmRqckJ6aGl0TFYwc1F2UWt4dXFuTkZzL2xsd2FNNlBjT3NR?=
 =?utf-8?B?OHNmS0VsSUtPVSt4dDBlQnNZNC9NSk54QmIwTUZwcnhXSjAzR0w4V01lSWN2?=
 =?utf-8?B?YWlpb1VmeER5Zlk1WEV5c1J1b1ZwTUFwd1JJTU1UUGpsN25vV0N3OHVrd3Fi?=
 =?utf-8?B?aVRhSTVPUXpCeXVvM2ZlL0dqM0N5UVRsaUhvWlZrQ3ZZNU0rSGxjUkFhVmRE?=
 =?utf-8?B?amhzS0NwTjhmNGw5OC9XSFJhRDVjOGcvN0s0NFR5bnpRRzVhOHdDT3hVWGxn?=
 =?utf-8?B?YjBZYVdVRzFML3hJbjV3cFhWZmFDQ0hlQkt3NzZvM3VOdDFIaCtCVm56OXlB?=
 =?utf-8?B?bUVIOHhtMUVYY2NEcjkwVDFlWDFFQ0hUU0w5L0liV3ZpdGN0amZ4aTRlY2ZZ?=
 =?utf-8?B?RjNHV0ttaVQvMHpZa3Z4Q1BTR2F2RWVGbFgyK2p3bGgvc0s3eWRmRXB3WHJU?=
 =?utf-8?Q?c63gQ4MOS8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1AyQzFMUzhEelpVSWpsVkNKdEFuSXJlTkduZnBUWW9scVNEb1pmVkFpYjJT?=
 =?utf-8?B?ditCc0hLTUg5SkNCUWVRTHh0VFk1Y2RUN3B5ajBucTZWaDlqUHBwN2JDQVVP?=
 =?utf-8?B?TWhzOHVhTzRzQ0YwOWJJcWxhTWtvNEdwQ3BWUEhkOU5QZ0lEcU9OakxvaG96?=
 =?utf-8?B?dDltRzlrRHgxMDFzaC9zd0Z5ekxUQTFSQWoyQWV4L2J0YW4zWEZJZjV6cWti?=
 =?utf-8?B?cjhpYVlMZ0hTak5wN2R2dEVxclJaMi9DdDBRSmlOZ1BzTy9JUU85MGJxQzE0?=
 =?utf-8?B?aGlXL2R2ZUtwUnpWdXl2SG9tVHBQODVUNHhXZWhCb0pvNGY5enNwRlVkcElQ?=
 =?utf-8?B?MndGRk1MQm1XbG51K2dvK09sOTBrZVNyanMxWHlZdWtFY3QvSXVsQXZSNGkw?=
 =?utf-8?B?MlFXK1hBa01MZEUyUFF6K0dIT2JsZXdhQWo3UkU0OFc5L2EvdnVjMmdwdm1i?=
 =?utf-8?B?Z0VWc0EvTnhFU3J4djlrbS9PTGNzeitqeUhvZ3l6dVFYajYreXhUejZVdDNy?=
 =?utf-8?B?NURpNmxILzFWdmJhdTNnY3lNZURsRjd4SGxDeTJ0YTNlUXBSZnZSb3BpWllt?=
 =?utf-8?B?djk0UGlmUzBCOVFOckdTd3VMa3pmQzFyOWpINzY4SXhOOEdHMW02N1dlU0ps?=
 =?utf-8?B?QWh1T2h4aU51OWJDV1NpNkdpV3RJT25kVFpQSkcrQ0Q1U1g0R0pXYkhTNmpD?=
 =?utf-8?B?ZlZqK1RZRDlwZTRXS2xmZ1BUYmJCRW1tTVVXOUN2ZHgwNG9HN0RjcTZoaisr?=
 =?utf-8?B?dGpTc0RmY256d05LSzVFVlBDTTZ3Tmg3ajNjREkwMEU0SGFJVXNxdmpzZkVw?=
 =?utf-8?B?STVHdm9sRUhsMG9KV0tYeHVON3RTbWl0VC9NTFdhOGJESFloaWV5aXh2QlpJ?=
 =?utf-8?B?cjY3Z1prTjNOYjFqNGZoQTJIcGE4STRXenBFQ0IzNUxEbnhEVHNzSHpNZTJj?=
 =?utf-8?B?ek5aeVdLNHZkS2ZkTmR5QjdHNlNWNURlbXVvVDZuZXJrenpCS2xnVU9RUEtJ?=
 =?utf-8?B?eVBOQlhzemU0c0F5Y2ZmLzBWNWZ4a2l4WExyYkl2NW5YZ0Z0MUZWcHNaclha?=
 =?utf-8?B?aTdUSk93R0FOUVRyWldvWVAyUWF4K0lFZjZOb1B3UGlEM0p3Unp3amFaZWRQ?=
 =?utf-8?B?UUxxdFRDLzBiUGo3cWN4QmNCNVNkMGpwTDFmTXp3YjcrcEUvNTFyUFNtSTIz?=
 =?utf-8?B?QUlEbUIxcFJHUU1GSjJuVlFXaGlpd3B6YWdJcWIzMzlhMzJUcndFNk1kMk82?=
 =?utf-8?B?ZFVFa0h6bU1xTVc0SUZ4N29GQUNIRVJkMk5PajJlTEdab3k0Skp1M2RQeElt?=
 =?utf-8?B?Ymc2cjBYVTFxVE9TdnZReGo4UEd0akUvZ2FFejl5UzFscXI0TmlzMUFwOGdq?=
 =?utf-8?B?VzBhc0pnVTkzaDZlYXBMNGI4TzFvYXlNbVZNWDkwZTgzd2pDUExqL1V5b1FJ?=
 =?utf-8?B?eDdHUTErL3N2Ui9RZmI3WDZpZjIySXhNRGNSdnRUaDRpeUdybmtxcEtDS2FV?=
 =?utf-8?B?eFdkbUgvVmFSUkJaZWZnNlB3dHR4VXdoNUw5T3lzSXlrZnIxLytHQWtPNkhR?=
 =?utf-8?B?ZHZsdnQ5Nk1uMndob2IrbmtVaXFqcFBzejBFQVF3STg2U2ZrYWNWUlJINUY2?=
 =?utf-8?B?cXJ5am9rdkhQWDFuVTBaMUZWbTBzSTFZcThtOTdRc2RHZGt4UytaT0k1UWVW?=
 =?utf-8?B?eXpJNGZHbGlhWXhIdXZkcXhYREIvUnk2VXVPc1JuUDFHWm55aXo3WW1OTUVZ?=
 =?utf-8?B?RDE3QXNtOWFNazE4NWlxMnN2SzhVQXVON3c3QUwxWDhjaC8rb2NaMXVJb3lU?=
 =?utf-8?B?YWhCVndTVFVQS2FyWnBkZDZITi93ODhtN3o4elVlekdjblp3U0dLQTdqYzVq?=
 =?utf-8?B?bTFwbFBMZEJqWEc5ck9KeVJhVWh1dHpNbTdHdTBNMFQrZ2hTVlhqREtkMnh3?=
 =?utf-8?B?T2RRQ09KYlNiRWlmbG1OdWpDd3M5M29GVXNxSVhBY2RaYklWUk1VSmJVUmho?=
 =?utf-8?B?RXRrS3Bvb1RRUk15UWRBcVRYRThtZVFSM2t0U21KckdjTnRKT3RvWHNqaG92?=
 =?utf-8?B?YkhGeE1PVXh0ajBBMzJyTllHQk12WXVTSE1aUy9QOEtnZkdnN2xsOFgrNm16?=
 =?utf-8?Q?+K/e7NFN8rxH5Th895lqUi6hy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226cad6-33af-47f4-5aa7-08ddec4cfed7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:22:39.6826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msVr/miCN0CPe/TF1VpSK3rGk1jOISxnLEco8XeBW/OuMbjnVizMsy2KlZgWFwp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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

On 04.09.25 16:45, Alex Deucher wrote:
> When we backup ring contents to reemit after a queue reset,
> we don't backup ring contents from the bad context.  When
> we signal the fences, we should set an error on those
> fences as well.
> 
> v2: misc cleanups
> 
> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 28 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index fd8cca241da62..1a2710f453551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -758,11 +758,31 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   * @fence: fence of the ring to signal
>   *
>   */
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>  {
> -	dma_fence_set_error(&fence->base, -ETIME);
> -	amdgpu_fence_write(fence->ring, fence->seq);
> -	amdgpu_fence_process(fence->ring);
> +	struct dma_fence *unprocessed;
> +	struct dma_fence __rcu **ptr;
> +	struct amdgpu_fence *fence;
> +	struct amdgpu_ring *ring = af->ring;
> +	u64 i, seqno;
> +
> +	seqno = amdgpu_fence_read(ring);
> +
> +	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
> +		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
> +		rcu_read_lock();
> +		unprocessed = rcu_dereference(*ptr);
> +
> +		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +			fence = container_of(unprocessed, struct amdgpu_fence, base);
> +
> +			if (fence->context == af->context)
> +				dma_fence_set_error(&fence->base, -ETIME);

This now needs to be protected by the spinlock we use for signaling.

Otherwise it can be that dma_fence_is_signaled() return false, the fence signals in between and dma_fence_set_error() throws a warning.

Additional to that I think it would be better to use -TIME on the timed out fence and -ECANCELED on all others.

> +		}
> +		rcu_read_unlock();
> +	}
> +	amdgpu_fence_write(ring, af->seq);
> +	amdgpu_fence_process(ring);
>  }
>  
>  void amdgpu_fence_save_wptr(struct dma_fence *fence)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5ce..77ea1ef46236d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	/* signal the fence of the bad job */
> +	/* signal the fences of the bad job */

"Bad context" or even completely drop that comment. Should be obvious what happens and why is explained on the function doc IIRC.

>  	if (guilty_fence)
>  		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
>  	/* Re-emit the non-guilty commands */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..0704fd9b85fdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>  void amdgpu_fence_save_wptr(struct dma_fence *fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);

