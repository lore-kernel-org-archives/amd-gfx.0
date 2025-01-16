Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B2C02187
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A50710EA0D;
	Thu, 16 Jan 2025 21:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GnV3Iobc";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9448C10EA0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtjcCff4nImQ48MbgxIkNChdx7oy18cmzRXS7d4C4ZlrgDULPfwtTLYpAkuWbZheoRcqNYJR9l3CfkFsrBmpNM3XYrVrzaxaeIrldMLy8nAw/jKI+pTTp46GGUm2Rhoya4vEjX4RQJGZ8YDsMOEKQuz/1OVxw4SLFrUjId55AzoT3HHF8gMjxJXc7esYJOqxZqtvgv8OYk/w0vBnvi+hpz28Fmp3qW9prl1K/x6QUMzvkM7/mVFw6Z/9nFCh/boojde7y6Onza7QJvOWtKjuyUG5WP2tlry7QvOH+kBDsh1P11raHtIgQTZTjhn/xH5S6L3T4CheiToMZTmJ/LtXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tz235h+T67V/29PDtw4Ww60Ky6wsnuFgE2E4m3BvAY=;
 b=Yk71DqGpY4Nd1fAB7agXjK0mwoRg4lGKvc8eRgiSuysEDHWI3nSX4vFK0s51dzwJN0TLvuWOJOGrL/xJBUhXiZqxL1LSPxrsfM/bnuNS4/ietqrVJO+AGfwJg96VTznoo05/0hSe+YFdFwLLgtfjE6qahKEqc9kWp4rBWhtspX5H3N2QN5i9WgkhT4I5gbbyuHUspkDB1jmzoeTCV97qPEW03h6Hvw4BSifHLyVLiQ2+GZoq2cXXgPVK4JUAZYE0qfvC/cdhUTXBTtTicZWVsv7NVgQ7A+EwDembpzD/2thXxcngIHXQHMQVJyxYLqW8sbSnq3jADqIEYMB7SnyaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tz235h+T67V/29PDtw4Ww60Ky6wsnuFgE2E4m3BvAY=;
 b=GnV3IobcFm1ns7AXkqog6zS5e8gNefE2ojcyf2lN9gJj/l1BH0DsyETCwzCrWbQjVfD6FMn3cgf6XMQylpKqFXuTY47lHOjjveIlo9Fbjf/1bjmFiaElmEdQ0UUmHm/naekvIhq0r2Am2uazXEPJDP7wsDIM+1/Y2kDIJcWL3OU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 21:30:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 21:30:06 +0000
Message-ID: <e8e45267-caf8-455f-9a99-886dc7ab0188@amd.com>
Date: Thu, 16 Jan 2025 15:30:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/15] drm/amdgpu_dm: enhance amdgpu_dm_early_fini() for
 PM ops
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <d84286e5f7c01a35afdb4affba2141d8ea0281d7.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d84286e5f7c01a35afdb4affba2141d8ea0281d7.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:806:121::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: d55ca51f-b63c-45d5-cc98-08dd3674f1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US9RNi9IMmN0UksrT1hrWXZMS0o4clN6TEVUMi92RnJibUYvUXFMYWhGc001?=
 =?utf-8?B?RjRITHFZSjVrR0tRZ2hlYk9jVVQ4ODUvY1gvYXZLalBpTERST0RnbGc1VDFB?=
 =?utf-8?B?c2gzdUZzeXNMNjRsRnM1NEVYNDJTVHR6WEgvWUxEUlcrMWpjbTNiaTZUS2Rh?=
 =?utf-8?B?Q203WkVaRTVZajhxZ0dIWGRBRWVxUmd3enErWXFZMmppcnNidFFjd09Gc3BO?=
 =?utf-8?B?SE4vQUNtSmU0dE9kL0YzaHRwa1ROYlRUVXYzNHRFVUxEbXFPeTRrOUFFdi9y?=
 =?utf-8?B?ZU8vS0JLdU1PZG4zbkg4MHdTNEl5a25xSURUZlpCU3U0bnh5SEdqc3hJOVgy?=
 =?utf-8?B?ODNyNFlrYnVramdRSUVuallQNGlvOHhLUmFEZFNCTWpVUHNWallwWDN5bi9h?=
 =?utf-8?B?UmRtZ1owamg4cGZmMFhBbmRhRld1akQrbXMrSUhqak1kSDErYnMxeWE4T3dr?=
 =?utf-8?B?L0dHb1dkelIyZUNNS0xqM0hMUUp4MGl6cWxvRVFLVm5nVFdPODBWNlBseDlu?=
 =?utf-8?B?a09aK0VpZGdoS09jRDZqeUd0UTIvL1oveEl3K1BHYW0rdXVGQjl5WHJwTm91?=
 =?utf-8?B?d3QwZ0lDT3JuNTdvODUwdVFrQkFZYmZaWC91dUozNnZNU1ZldFl2bk9Kd0xU?=
 =?utf-8?B?ZW1oRHFsdERRdjg2N3pNL2ZzdG1qRFh3czRuQ3c0aERoMjJ2US81SzVUem1h?=
 =?utf-8?B?VjVJbWljbVpyWXZWMUpBaC9jTzd2ZEdpcVM2VHR6TzRGdnc3Y25sNDFobkpT?=
 =?utf-8?B?Ukg3dVp2UTdBcjdxUUVzdHdhQ2RMZ082TVI4ZGpLbEZCc0ozTlhwQ3lHZUFM?=
 =?utf-8?B?YWpsTmpTNGVTZFYxVWhtbVBqWFkwOXBHM1I2SnBhb3lseVZzK0RsUXJWelVh?=
 =?utf-8?B?VTArYVdobXgvZStRcVZjWGVkWkR5REF4cG5QeWRzMklFMGJxazdnbzdmTFFU?=
 =?utf-8?B?OGZiZmVOZXp5VlNVOGZGUTdRcmFUUlZuTjhJSDdqamtReTdtQlk3WlYxQ0Vu?=
 =?utf-8?B?KzYvWndHMVAwdmF1RTRnRGcraUlNaWN2bndvVEIvMjY5dWdna3BLS1JXTDEy?=
 =?utf-8?B?SFNSVGhNQmlUMloxanRiR016bXNLRWlGNkYxbmlqekk0cmZQd1pVbGRaS3k4?=
 =?utf-8?B?clpKbUdvc2h6OUFOL1I2TjVpQUl3SnAzV21OWlhzOS9xOUhZUDQ2RVJwdk04?=
 =?utf-8?B?aXA3bmxpaTQ1V2ZtZjdKOCtadFppR205Y1FEN3AyMXg4UERoVFJ4R1Bab09G?=
 =?utf-8?B?UW4yeEY2R1MxWTJad1NLL29rNFEzR25GTGMxdEVMMXc2VWZ4NXpsL0QzY0tq?=
 =?utf-8?B?MjlHQmROamtsVERUeDlaQlAvNnBNVVlkckdzdE9UWG5veGJHL3BjRGtld21S?=
 =?utf-8?B?cnZhR1daWmIvOW4xNlJ4UWVxalpobDIvVi9HUjJvQURnZ2ZlUFpiTzZYSXU4?=
 =?utf-8?B?MVZ3bFBUY0ZhNmYxVHpFRWdvSjkweUVHTStLTUw1bUhVMW42YkFmRE1yT1Vk?=
 =?utf-8?B?YjdKb1B6TkhvamcwVGl0Njhwc08vd0tQcGFmbkxhZFBTaEVWajlVWnUxNEZU?=
 =?utf-8?B?cVJVeXhtUkZ1aHFneWNDcTlTTjh0VHczMk00QmFYaktlTUpWRm4xNUZGcEtC?=
 =?utf-8?B?aUlxcXRYNlRaNVZRd0xtWitkK25xVUYwcWJOb2dNelBFV0RGTG9ITEsrQ1pE?=
 =?utf-8?B?aHZrcnljVnhOL3dnc3VKcVpPNXBoMjBKbnlDY0ZvWFRFeWZJSkJGRDVCa1R6?=
 =?utf-8?B?M0JCNzgwRGZxSEdwa3ozZ0xHK2NBcTlmaHBqM3o0c1dWTjJRRzZxS1VZK2J0?=
 =?utf-8?B?M04yYzU0ck9yUjBCR3M1cWdnV0JDYkRyVmNyMCtrZmlPeVh5OURrMjF3TldW?=
 =?utf-8?B?TXB2d2p0MzhzcVlHMlJ2QjcwMnpuV0pzV1V4MVNOTXRIaDZZNStyUzhDdStr?=
 =?utf-8?Q?F+x8E44onLk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVsWXJQendIYTVWQ3FSYjBpb2pxd3FxSTRtMlNtTWJxb2RwVVI4dzRsVTRN?=
 =?utf-8?B?LzZFVWMzTGt3SkxEVU9BbEZaUmRGaW1La3JKMnlzdGRkbDIzUmlaZC9UNW5Q?=
 =?utf-8?B?cnhNK3lxazRHWkJBL0xUcFArbGpKaFgwQVkrZlNwUmlYaUZub3dwTVFwNWdD?=
 =?utf-8?B?bFpBRWtQeFlkMHhDQjEzYUdFOXhxVUlrYjJFWUcwc0pWdHo1TU9qdm9vbTZm?=
 =?utf-8?B?YkI3QzNCN1VDNE9senp6TUp4T1E5dkkwOXBTdWdZY00ycnUwRzJtM1kyMVZB?=
 =?utf-8?B?SzdET1p5NXNEdlFyaFh0cW1jUnoyZkdsK2R4TmJRSjNKanVzS015ZTFxdnRO?=
 =?utf-8?B?UDZuSWFRTmY1YkdvUmdYSFZDMnBwMDNMWDVJWFdXMHozR3NDQVJrdmZlRXJZ?=
 =?utf-8?B?SWFEU3NrMEplTjRxeDJZSDgxL2R4bVdOczQvYzBMTFkyTFgrbVdNVS96czho?=
 =?utf-8?B?eHhKT1BoRzFGS1pCcXRjWGFHM2t2R0cwYm5CMCtDdkozSEY2Vjk1Ni9DcnpR?=
 =?utf-8?B?RG91dEVQdXpoYmxuLytKZDJXU1lBcmQ4M0M4Vm1ZVEJwejY5cTQ1SWVvUDlz?=
 =?utf-8?B?aGptcDd3YUFza0tvUzJ6NGN2UWlERjIwSVh5WXNOTExaTS9DRnlZOFk4MUxO?=
 =?utf-8?B?SnB5SmZLSUJtc0pVUXg5TDJ3cGh3bDk2N1hKdzZsVjJTSHJlMXNIU0RDREhR?=
 =?utf-8?B?LzYwM3VEcExnQlQ0OFZMeGp3dlZBWFZCekxnRHFFSDJkdTNlVDRlK0dmUUdR?=
 =?utf-8?B?dGFtaENqM1lWZzZNWHBNeWc3SHRHRk1KUmM1Zms3RVZOWGZIZmdxakIwMVBF?=
 =?utf-8?B?bWJWZUl2c1d4elRlL1g4dzEvMVVzUDFsY0dWVmJzZ2tzVkhqUVlpcmJ5UlN1?=
 =?utf-8?B?WXA2ZDFwZWZjRVB6RnZzOVBpRmxDYllpREovbCs1Ri9ybWRHd1lsZnpXZVhl?=
 =?utf-8?B?QWhGNksyUDlRc3U0RnpVY1VzSUx5R1M1QVJrem5BRzNKLzN6bWQ2SkNZMUpn?=
 =?utf-8?B?YXlZRnoxQ0t0VzFUUHBsYkxnZ1g3UGxneHdqWUIxTnBvN2hEZ3IrMHVuVVVS?=
 =?utf-8?B?U2hMUXpjNHd6RGFkT2ZFVS9HN1NZcUxCOENuTHNJWHlLUm1MYWRlRlFJenh0?=
 =?utf-8?B?L0RKenFFODh0ZGtCeUt0K1orNVVqeUV4U2t4RXVib2JHaE54U0VyalRDTlh6?=
 =?utf-8?B?eUZQRVhIZlM5VnEzUHpuVm5zWmJ4SXNDSnN2WVFzREdVUlFQRGR6VVhvbmJ1?=
 =?utf-8?B?UVlERG94S1haUlNjeDgzak5jL3BQSVhJQ1d0a2cvdlc5QVB2N0FwanNrS3M1?=
 =?utf-8?B?Q1ZMTmtqSXV0eXlISi93ZTVMVldqY2tnRWZCRWU4SG1nemtqYWJFSTloUjFZ?=
 =?utf-8?B?YnRsUVJCb08vRmpwWm95SmNscDMrN09wdUhFTHViNWlGM3g5T2wyY2xvUXlT?=
 =?utf-8?B?bkU4dkZiVkVJR1NBTDlscE10dk1Cb2hGQTdHQUl0RmE5QkVtNWlKWC9pSWx5?=
 =?utf-8?B?L01vNGg1TFlBMzBmUGVwRVVsMUpWbnppK2pWZCs0Q1RtU3FjS29oODMwVDdp?=
 =?utf-8?B?QXJyek9sdk5YeDBPNXRBa0lVaXBieGw5bFlyT3AvWTAzVld4WkFqK1JMOHdP?=
 =?utf-8?B?QSt5SVprb1NSYjlBajU1ZGpWalhVVmNzL3FJYndZY1d5eXVmZE9rZk4wbmFU?=
 =?utf-8?B?cG1qWnQ1YlVzUFhoRG1pVGdpeTg0WlVPMGJZeXhGT2lSbUZZelI4MTBvVmdF?=
 =?utf-8?B?OTlMMlFzM2J0WmxBU3k0NEhKTkRuM1NwV2prZUlQRjhPcDZmbWpnWmpDNkRN?=
 =?utf-8?B?Q1N0cS80SzNtRGlOZ1g4enYrTmk1ejVMeW1MN3dTMXZSZzNjQytlNTJKZXRC?=
 =?utf-8?B?ZDlmTi9MNDZ6Mm5nMlpNNTQ5Mng1dnRmN1pFcHFnQTZYTy9FYzVsV2xUY1lk?=
 =?utf-8?B?K212WElaUXB0djJ4dlVtek9XdDA3OXdsMXpiY0dFMmhGcmFhQjhkSVZTRk9U?=
 =?utf-8?B?L05ENnR1Rlo3L0lOS1ltTG9neTlDdDdXUkREdXBsSGFpODdXZXIyYkJ5UzRO?=
 =?utf-8?B?UGRDOExDYXdOcEo2Q0F2bDJKOXlkUVdwUVRKUDk1a1hSL3dIWUhGRjBhM3pU?=
 =?utf-8?Q?0rzrS28Y9i3XRs5VwxuJ87XW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55ca51f-b63c-45d5-cc98-08dd3674f1ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:30:06.2146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK0NEpzVKe+fuu7gvYynPpAU4LmsBLwsiseH46B+0mJX+/urj1OY2DdmRZ+fET+R7/aWaF7MNNmXqNFSRc7lUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Enhance amdgpu_dm_early_fini() so it can be called in power
> management operations.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9121abe0e5ef..7b900b293c0d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2175,6 +2175,9 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (adev->in_s0ix || adev->in_s3 || adev->in_s4 || adev->in_suspend)
> +		return 0;
> +

I'm a bit confused how this has even happened over suspend.  The call 
stack I see is:

amdgpu_pci_remove()
->amdgpu_driver_unload_kms()
->->amdgpu_device_fini_hw()
->->-> amdgpu_device_ip_fini_early()
->->->-> adev->ip_blocks[i].version->funcs->early_fini()

Is there another call stack I'm missing?

>   	amdgpu_dm_audio_fini(adev);
>   
>   	return 0;

