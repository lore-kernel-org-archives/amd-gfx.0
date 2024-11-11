Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A19D2E9E4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2B510E493;
	Mon, 11 Nov 2024 12:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sb+ijw2+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4A710E493
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEfIgBrHGJvMYkQ6wdKieH4hyyGfzge+wsw9e5FqcBKYzleSu2x5/0HWNWKdf0MhqF628yM7w2bmU+dvEc47nTBUV5xArO7755sWyDN1L0vGTigZZ4xJsvXJNzbjIXI36oNH6/qgEkmUwNtnv4Q+gdfm0nDcrvvWrrnDK/gfj/sLzcenTs1afMjhkJWYgGJri1f5HK0A+vE/iLzdh9PDSYE5rOVQYRcnKp5FyzJkr6K4Dto2p+SjFRCPvKurmJrV2sqVhtOj3KFJtHimoUBSHpNb5C3VW4y9dU1LrtGIeSYTIQgEgUEHHnu1V9aKoMtDTu/FDnDs0lXSTYgB2Xq1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tq341UjxeooglRY6t+LIuMvxFZxuNeU9bghiT+SOas=;
 b=wjLpdzjUHohC6IDLLKFtxKRL9TlLutUb34lpMc+t7quCobqgGVPZ8c+BsntDNBR4BXH6yvrLLXwXAQrmkLWxIleeJHtq/8plbACgSdbBlvZZSDrJW94XceUd8+IjwwcEtGkqZKLNHQXgY1CCbNX4unwSUyC8MV1iXVR/+eT4hwb3cYBIe7KuDvhHIkJT28Sy1QJ7xIOTEcn0UELADCFKsEtg/nNt5LRA6WjmLkEaaQHjzf19V3pBDzrOMZobjiRrtnQh5UFEcQXSI5sxXljZMDPigMnE4wH7EiD+uAE2JnPCRVNk3bL5pE3EvVLvmnO5CZV+6D55DXlmF9fhr/gwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tq341UjxeooglRY6t+LIuMvxFZxuNeU9bghiT+SOas=;
 b=Sb+ijw2+rVpufNCaZQDJ9UFt8ntCJp3CqBV5rJ31TDCy3Hh1f5MKwRhvEu+zR26WsR93fS9ASf7pCQECltCPBKWEUWxH9hJpeBigBjqZ5Nf70lTYX6/W/h558tFeFpuGw6CQeX9GPOUM94lIFHMpdf6nL5xQtjn4M5cxRzZ4P7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:30:12 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 12:30:12 +0000
Content-Type: multipart/alternative;
 boundary="------------XYIoyGq0wcTxvYVpJ1J00LQx"
Message-ID: <82c726b8-0cfb-4b04-a7b8-62afc2a82735@amd.com>
Date: Mon, 11 Nov 2024 07:30:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Add missing 'inst' parameter to VCN v2.5
 clock gating functions
To: amd-gfx@lists.freedesktop.org
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
 <20241111024612.1881727-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241111024612.1881727-4-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3dfbae-bf0c-43f6-4a68-08dd024c9677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djlpRFcycS9hUTNKbDQzZmJJb3g2aXJQQ2xZeG90R1pESVMyaVA0UXV5eitD?=
 =?utf-8?B?Y3ZPWE9QR1hQR05qSjlXWk5BY2wvWmNWaXY1dGVYRmZtOGFrSDdnNXBJc2ls?=
 =?utf-8?B?RzJrWFNLZ1J6NHVMc0FiMEh6ajUxbmF2a09HbjFsQ2NIQkppN2puL0NyWElG?=
 =?utf-8?B?aHNqVjFJM2ptSGYzNUcxSzZoeW82a3hFT21kaEdwVkY1MG9SbTFNaEkwL1BP?=
 =?utf-8?B?RjJCeXRFQy9VbEtUc1l4R2VLaFIvVmRqUjVxS0lmSWVZa1BxTkVtL29rQkV5?=
 =?utf-8?B?ekI0M0ZFSEdCNm1iakFlYjZZTStyQitpSEQxRXRLQ2NseXdDcEhRT3VlYkpB?=
 =?utf-8?B?YUdLVkVOYnN2YnBGUDVNeThUelF1ZSthQTlSR0sxbU9ad3ppVVo3bldQS0hx?=
 =?utf-8?B?U3puZVp2Zk9PSjV1aiswU3A4bDROT1h1STRJaFNIY3dLZEdwRHhhMUh5OVE0?=
 =?utf-8?B?R0xoWU51c3RaUzFmdlRkaThuaHpIMzY2STQ0MC9xOXNpbmVxTkFzWFRuUEV2?=
 =?utf-8?B?M003WFhYRkZDY2tUUXo0eE9XOGROTWxJT0hDY0NuZ1ljU1JzS1Fhb3NEK0hW?=
 =?utf-8?B?bHlLa3VHclEydFJOMlRQZkNrSGJuMUJWQ1BRTG9SYkh5NmVVUHJzL0ttQmJi?=
 =?utf-8?B?TkZXY1drZ0RDeFc1RXYyKzZxTXZkTWE2dUkxKzhvQkJ4a09RMitSZ2pHQlBM?=
 =?utf-8?B?aVNERnlBSmFqY3lFSzBDUGZyWm9LbTJoTk41NjJyS0kwU3ArbWthYUNmVk90?=
 =?utf-8?B?K0FxbnhhQWRxMkt4NUdlV0MvRmlZTk1uN2hWM05Vb29IMFUwMFBvbWR4ZlVM?=
 =?utf-8?B?TkFkOThrVU9KWmVYRXEvUHFyR0dkVXpQR01mYjBNN3JnZXdxUE8yTFZLM1k1?=
 =?utf-8?B?VmN0dkNOaENhbHpKNEhKWituSWVHUjBLQlg3QTlZb1VCdUJqZHdzbXpISVZV?=
 =?utf-8?B?bTZDUmdtSTh5cWlqcXBlb1lVdDJ4eWxjdWx1ampYYWo5QllpT0JSOVpCL1l6?=
 =?utf-8?B?c2lxS3RpMHNQVC9ReWs1aUNyOFdhR3NVRkxoa3R4b2p5MU1Zcy9qRWVkYlpI?=
 =?utf-8?B?azgwR2N6bXBHMzRKZXNaelJJMXNpbUdMU0l1cDgrekJiU2dCcXhaSzV1Smlz?=
 =?utf-8?B?Y0J0Q1hJUzBjRGZ6YXdGekVSOVpGcW9JeGdEUGhUYnAvaXpieHJ6YjF0ZmVz?=
 =?utf-8?B?cys4MUVvZE5sOU1mNVJGS2RGaGFkQWhGT1QxSGVrZ2hYdEJ0QzNlYjFxOW9Q?=
 =?utf-8?B?YXFVWHJpemVDN3ZwQzNNcFhvTlh2aWl2dy9mZjJkQy9ZejZackxBVVJjWkFG?=
 =?utf-8?B?L2RhS0hVQzBDVFJIVGRkZG5RS2kzWFRCclhyZjdBOW9jUmY5MW4zdXVyWnRY?=
 =?utf-8?B?Vkg4Ri9aRjZFaWF5clRUUHRsem5JZXgyT1hKd1Bnd2NWYVRxV3dGa0pHeTly?=
 =?utf-8?B?cTNNYkk3cllPa1duVDBQVGxWVlB1RGdheW15VStuaSszc2R3amtsNzdKZnZz?=
 =?utf-8?B?cEVjb3pWK29XMm40TnVuMjdLMnVzNnl1bXREYU9iWUh3ZTI1WWd2Nithbzkr?=
 =?utf-8?B?ME1ESC84eW80ak4zSkxadkFJZnFaYWZYUVdDdm5SdTFMZTNxTVBRL08yNmFp?=
 =?utf-8?B?ejBqcjNudG1Da2NNUFZuV1hBcVJCQUplR2krVlFhNUx3UkowYVB6MEprdXlB?=
 =?utf-8?B?ZjNHRjRNWFhtODhnYkY3MFNPbWw2S08zYzdDMjdiZDk1TWVvTkNUdllEcUl2?=
 =?utf-8?Q?dW4KskW0jm4Yexml83gJ8iLT6WNLB9fTu/K69cY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdYZW50eVhMd0tRM3J0Z0pKb2l5cHg0c1J5QXdxakVFQzYwbFArQWhUczYy?=
 =?utf-8?B?T3BvS3YyL2NrSSswUHdROERBaGZyOFl4K3YyOGZyaXRlR1p6UnlaUlF5MHV1?=
 =?utf-8?B?S0tnSGltKzUxZ2dsbnpYL3A3QlRkcVVTczB1enA3OTdIY1kvUFhWRldzbnAy?=
 =?utf-8?B?MUJ2dDQ5M3FmYkdKdE9NZFRGdDFkUVRXbTJNMTc3T3JMMUNTTUFTNWF4dTJM?=
 =?utf-8?B?bXQrOGhITjFCVlNxSWpUL3phOXZPcDg4eFpnUmgvT0QvQkorYnp3VzdEOU5t?=
 =?utf-8?B?OWlJT0hGcG1lbnBjZjg3akEzc1FlTHp1cDZwSytVK1h2ODJ1d2ZGWjY1amUv?=
 =?utf-8?B?OVpUanZvajVEKzBhaEdtN1liU1NaaFJkelRwUmdJbEpFZVF2VzVLRVRXSVdF?=
 =?utf-8?B?eU16UFpzbm05Ymd0QlhuUldsMXBCTmNSeGh3cXMzUm5hWmM1M0RlNFZ0bTRE?=
 =?utf-8?B?T0J2a09hSXdsVVhoWXRMODFxVTlnbHg2UjhhTHhXV3hReUlObFAvb28xNkZy?=
 =?utf-8?B?SzlHOHZhSGlUbTVYSXpYSjlvZlFRNFJWY1JYQ2hoaS85ajVjcWx1NU5EUUZ3?=
 =?utf-8?B?aHdBZXdlU2RZaksrZTJlOWNNeTQ1WHRac0tSOXkzWGwwZEEzLzNqVUx6WmFz?=
 =?utf-8?B?bEtoc2dGamwwdUlWU2h1c1hSYlNCSFpuWmM1TVFlY3FDZFk4SkQyK09HL05R?=
 =?utf-8?B?ZU5lamxYcWZNdGVDS2p1Y3I4TEVYT2M4L2FrQXRQMlFMNmZlU1ZoT1ZWOTFq?=
 =?utf-8?B?MFNkTkVHeHVScGZMbWErRE00bG5PdTMyY01kM0IvWkVGNmJBZkIrcGFvbVl2?=
 =?utf-8?B?ay9sMVFxMzdIZy9lTC9XZnQzQjFjR0xxWEdxRSsya1pUN2hPeWNaMzBmQUdE?=
 =?utf-8?B?bFlxK243VUdLZjBuSFd0Z0E1aXlQeVErZklkV3lBdFZVdXRLcnhwOXJUeWZM?=
 =?utf-8?B?amovNGVYWTd0bE9zQlIxbTlwckJXdXdkN29aVGlNVVVkOXhGeUxhQzZwOEdk?=
 =?utf-8?B?YzE2OWdscUF3Y1l1M0k3OWh4NDl4eDAwT3JQMTFienhGeFR2MDd1SmhXekdH?=
 =?utf-8?B?dDhnNU1YTG12NW5ib09YdUI0Rys4eEVGQWR2aHBVb2dOU1hkeUlqZ2pMeWtC?=
 =?utf-8?B?WGZtZHNENkd6cmhIcldhcm8xTSsvR2lKaW5ySm1zZ1NwOHZrbnkxVWFnSzdX?=
 =?utf-8?B?WlNmcU9EQThndjhiTURkRjNyZGpMS3BVYUhNNHdIcGRaSk5EOFl5VGFQRTlS?=
 =?utf-8?B?RExLMi9JT3ZQL25rMXg2d0pLdytBQUtFZVd2NnpNZll1SmdGM2lWMlU5cU9h?=
 =?utf-8?B?UmQwQlZ5RUpqclFkK1g4Ly9ObUtXNEpXUlkyYWZUZ3M3NUhIMTJhMlpVUmwz?=
 =?utf-8?B?bTVhY2pTYStQRHIvZUcxbzc3UUZRdXQ1N3lYbmQ0YkF3WVYzbG9XdExwSkQz?=
 =?utf-8?B?ZTI2d0huN01SdXBHNk5uNXYwODRMd3dZUVhSMWdpT0dTa3BzMithL2VMM2s3?=
 =?utf-8?B?azM0S0tKejZhVklSSitmeFRzb0VNWXhhaG52Vml6ZnRJN0Q2L3lKVWdORjE4?=
 =?utf-8?B?ay9BaCtmbXo4N05rOTJDdzNZSk1nbkJlK3pFVEo0T3FIODZCWnpNdnJ1TXV0?=
 =?utf-8?B?eVNIYml5ZmJQVjB2cXJEOEJ6K3RyWWNhWDh5NWdldmM3eFpyVnpUc2JQUVJP?=
 =?utf-8?B?d2dMaW5KeUtRUHY3TjdUS3U5dFlkSW1rNW94dERMYXpVNmNUOThZTTdMUUov?=
 =?utf-8?B?dmgyQk93NUFRcmVMSTJGZ1hYK1A3YXVIbE5renNIZ3k2UlpJNmc3ejAwNEpZ?=
 =?utf-8?B?UnhvL003YjVsaXlhRXBtM3hjNVNncVhQa0Y4bS9WZ2ozaVl6bldWV0RqTWxH?=
 =?utf-8?B?a0tac3d5dHlJWDdtL0M3VVBLV0tVWlhRa1laWjVkbUVrdTJpd05OOUUxdCs3?=
 =?utf-8?B?SWlSbmJucXZ4NEtKODZVUlBPYm0zeHFIYjU1ekVsTzU2eVd6cndBdXpUUDgx?=
 =?utf-8?B?K0p6b056TmR0VkRBUFBNT3JmVDdJU09yMDVrZHQyUENmNlNlOGdtM3VMZnNY?=
 =?utf-8?B?RWtxeVZRV3JLZTdVbnNwZDQyR0hWbEZHVkEzcTJ3UmFCWHZqQ1pFMGdic2V5?=
 =?utf-8?Q?SM9NYB+oTLDyGc72EGb4A6Yd8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3dfbae-bf0c-43f6-4a68-08dd024c9677
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:30:12.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QdrpsZH3WhvDJqqxmgeC6Gx1FovrlOBUICcXJE/Ioh/YWrAeGIlCcsEMm4e3WtoNvMKuZnNlqw2at/Jl6PZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

--------------XYIoyGq0wcTxvYVpJ1J00LQx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-10 21:46, Srinivasan Shanmugam wrote:
> This patch adds the missing parameter descriptors to the functions
> vcn_v2_5_ disable_clock_gating, _enable_clock_gating.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:616: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:778: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_enable_clock_gating'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index da3d55cc3ac1..deec881f0687 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -609,6 +609,7 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>    * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index for which to disable clock gating
>    *
>    * Disable clock gating for VCN block
>    */
> @@ -771,6 +772,7 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>    * vcn_v2_5_enable_clock_gating - enable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index for which to enable clock gating
>    *
>    * Enable clock gating for VCN block
>    */
--------------XYIoyGq0wcTxvYVpJ1J00LQx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-10 21:46, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241111024612.1881727-4-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the missing parameter descriptors to the functions
vcn_v2_5_ disable_clock_gating, _enable_clock_gating.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:616: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:778: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_enable_clock_gating'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div tabindex="0" aria-label="Message body" class="XbIp4 jmmB7 GNqVo allowTextSelection OuGoX" id="UniqueMessageBody_29">
      <div>
        <div>
          <div>
            <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody">Reviewed-by</span>:
                      Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnk671546">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
          </div>
        </div>
      </div>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241111024612.1881727-4-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index da3d55cc3ac1..deec881f0687 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -609,6 +609,7 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index for which to disable clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -771,6 +772,7 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index for which to enable clock gating
  *
  * Enable clock gating for VCN block
  */
</pre>
    </blockquote>
  </body>
</html>

--------------XYIoyGq0wcTxvYVpJ1J00LQx--
