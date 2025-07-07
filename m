Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D51C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 09:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECC310E434;
	Mon,  7 Jul 2025 09:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dI07akTn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E8510E330
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 09:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M97dEf2aHa6LjRwBTkty7jiHdRlxzep8UuM84DZ0b1cdhjGmPPVFLuaJ9lm/euzhZwpEemP+nMrOj81DotTLxKcxdA+0Zf6XkUpDwZoz4Y+Q9G6WDQAddG7rNpCpPUcLG4uM6ZTKdkBH6MKmKQnK/iF1CfOaMhXUef9cxsryGwmEOYBaSx225/PuThsEW5XhHmJtZvqSH/so8SofBmzS7CgP4R0x6DifY0i1dPFsKQ5ETO1Bk9VueVwJERuSAs+vxQH5laxWhN6wqi8L7S9vZEPmB+KB9FpKTICA+yO/haqpTPdCHG7v2oThgfFi5M559KU7iI/0sp1z26M6OgN7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqFtN2STE3ki3xJ8w286ksqhiTrLULYAPMkL0z6jEVU=;
 b=Z11wF2guS7XAshO7UV7zqGZSrTaQy+p/x5uzsT5SLdh0MSWwS+Moozs42pPGmK3fv7o6viYNK3lguRj+VKJBu3i7gxaHDT6T6sqvgZe+wTJSDeUvF3jmOJB8bXbik8XrlG8L2M/RrLtu8sEfBmf4jwqNI1yO0rq2oGZrM3J0bs/G+DvVk4dUNXQZpsix7wpj7ZOF59EaX5S2tItRv6hfxciDWOPAhRzZxwqW1Wk604qTs7hS/DmwEt4zZWdjWV55X4KNH1bpuzh85RpeJGst1s4vWyrh8O4yXrmvGu3XH5yYL1I6Y8yLiaAz9z4FXTEfADKw0K2W6NtmpKGFfzzQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqFtN2STE3ki3xJ8w286ksqhiTrLULYAPMkL0z6jEVU=;
 b=dI07akTn39ljCPEoRz6YTckeUvpXIVEblq2bY4p7r8s+1hCiePZoTbgkz75TZOIVHqN/aIS46KBPTtR4o9PgIEuW1TUpAHYc5If/rByiaN6WdZX1U4/DXzScj6R20RzU6sUJIoqciJvrz3L2ibr/ponQrjPxhNz+Z5d9o5Redt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 7 Jul
 2025 09:42:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:42:35 +0000
Message-ID: <ec6cded3-daa2-40c2-91bf-4686e8a03e7d@amd.com>
Date: Mon, 7 Jul 2025 11:42:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-8-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250704103308.1325059-8-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3bb17b-1586-442b-e6f3-08ddbd3a9a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHpnQ0cvTzhnbVdueWxPNkUxSFRlWmpFa2RrRXpMTTFxRWs0NzZ3b0N4QVNn?=
 =?utf-8?B?eFUzbkxXT2N5WENaRmxMbko2QWozYko2dWR0dmcvc1dmc2pGL0ZXOXUvbW41?=
 =?utf-8?B?NDd5VHU0dklDRmt1YS9FSlM2UUNxZkM0amNvb0o5Y1BDdG5HVUdVWnlud1Rq?=
 =?utf-8?B?RGhaWFpFbjBpYzBCbmo4c3k3Mnh0b0FTdUVqU2dFWHZPOUw1U0ZwMHZNTG5w?=
 =?utf-8?B?SVNTT3pWNVlDMm83bDVFcnhwNEdlZXVadXA2TlpGVVdmZTBEVkVXT3lOMmU5?=
 =?utf-8?B?QXo2NE5MaTZJVm5yaEhpOEJCQnhBcnIwblAvTE5OQlBMUjBNU2I0aDVrOUdH?=
 =?utf-8?B?aGR4OG9HdHpYYmdycXdwUEN4QnZHOHVKV3VLMXpCckhiVFhBdDZ6U05HSDNm?=
 =?utf-8?B?VTdpc21UYnNsQXhybThkTTJEUmluZFpmaWdlQTVtR1BLeGczNkRBTUxPWllW?=
 =?utf-8?B?anFZakRGanVqS0R5SUJxSFovSGVmamhuNERQZkJkSlpKc1dqVFFpSERVQ2pr?=
 =?utf-8?B?ZFFtMTc2TXBRbTd1dzBuWWUzTlpEWlhuK1Y1VlpYNDNjTEVQcDNCbWxXcW1N?=
 =?utf-8?B?K3MzWmpqRkdWdXg0WnlMMHFERVhucWZENlBiV0wrQzBYdTlRb0VsNVJjaW1L?=
 =?utf-8?B?KzJTWW9JU1gwc3hJU0lCZVowKytzcEwzeFFOcUpqR3RsRUxCVlFxV1J1c1pW?=
 =?utf-8?B?dnRCWU01Z2dFcCtDcGUxT2wvalEreGlYZnliUitodVM2dzRkV0x6NmZjbjly?=
 =?utf-8?B?Nmd0OEd0WkpVM29jdFRCMC9vOXFtSHhsbWR1RmlZRWZIc2FzRVRzTkJLVlFF?=
 =?utf-8?B?ejEwTmx6YmZRWkEzckVYNlFzdU1KdnhqY2pvNWJqOXU4ZktYVTdsVXpxRU5R?=
 =?utf-8?B?WHQ5VTBDbXZzc0lOYWtRNW10SWpySXJUQ2dPYk5SQ2FINjRyc0NnUDliQ0l3?=
 =?utf-8?B?K1I3bHd1QmVCME5CbkFKdmZhbFMvZ21OQ2RjY1J2ZGtiSTVydkxTenZGQWpO?=
 =?utf-8?B?MzYzNkdnODdSY3l0UnJjcG1NeHNYbXZROEs0TGhCajlIN1dwWEo0VTdtS3VZ?=
 =?utf-8?B?R3VvVVVBWGhIZXd3QTRiUGhmMUJUbzNWaXB6cG9GL3k5WmFzRk1IanRvdGI5?=
 =?utf-8?B?SzkxUWprUG16VDh3SDhtdVVPWWhydW1TODdhM3NaT1c3ejQ5b2JoRnRNMjla?=
 =?utf-8?B?UEJOUU1OZHc3QndYazFDektnUVRMeUkxNTVLeGlLSWF2RXVhYWVKYWNtemtU?=
 =?utf-8?B?cWdsbmhzeSs5b1BsbkE3SHM2bUhqcjlEQmIyOVppbVdjaWYvMldCTWJDWS91?=
 =?utf-8?B?bHR2dU9LeVIwZHk4dnZyL2xTRW05YVNwNmY2djZzaEx6UFZaUWdXU3MwUmdT?=
 =?utf-8?B?MngrZ1BURXJmdTFUSWJuNld3cGIxbXdnSmcyWm5LVisyckRiekRZdFRMK3d5?=
 =?utf-8?B?R1laNGRxK0VvbDBicSswTGRyZldTWjRMUEhtU1U3ejAyQk5SaE9qZ3pZNjRT?=
 =?utf-8?B?UXZDQUJWWmtNZVhLUjdNWWZqME1acFZwREZHeDZrVjJxS1h6ZnlQdEo4T0tz?=
 =?utf-8?B?RGxQNXJTdmxMN1AySitlUDhRZDllZU5YZTg2NC93ZE5IdVVnTzk3dE1nV2sv?=
 =?utf-8?B?c1VkSjJIdXV5Q2I2VkhRaU5MRGVtYzVOZ2dZdUw1b3pkSUJXSlZMN1J1bU9D?=
 =?utf-8?B?R2J1UVZBelluUVV1dHBVQjJPeG43d1N2N0dnQWlBNDRQZlBqU0lMWDFyMk9v?=
 =?utf-8?B?QWcvYzZPM252K1A3UU9qRU1TUzBSbG9ubXhqVlZnSmEvV25ueVFWdGhUMU01?=
 =?utf-8?B?NksvYXNlWnROam92ZGVBOEg0YXJLbnJ3cjZsVmtFSDNTZjlLdFNLMmxFbE1q?=
 =?utf-8?B?ellUNHRtZ25vMU9PWktRMFY4Q0JTaDRZUGwvTHAxektsOGxXV0tETE5idkE2?=
 =?utf-8?Q?cDtOGKa2qOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU91a1c2NWh1MHgrWndnVC9rczcxeWxLRmhydlQydksvZGprb3FScGd2SlBG?=
 =?utf-8?B?TlRFTDRrS2duL3JDaENONURQTkczNjl1Q3YwRk5zQmh5VWt4NmlJK0tBa2Nx?=
 =?utf-8?B?dDZDSDRqTUJhTWZvZGgrdXFtM0p0M2V2QWdYQ2JXb1pXRTY3WjFGQzZqakI5?=
 =?utf-8?B?V0Z4WEYzb2lyYThGRk9IMDFyYVp6SkZRSXhmMEZGajNNR2hDd1NFUEZFNjVE?=
 =?utf-8?B?dG8zWlJBWHVvZ2FwTzIyZGdIajNMQXlWTS9NSFp1Ni9sRWdDdkNGWTJaVEUy?=
 =?utf-8?B?NysrYWwwTHZYRElkZkkyckpxMUlvemlISWs3N1RacGhCRVhSZEp4dnBoTUxj?=
 =?utf-8?B?S2wrOTlUQm1uRHJOZUJxTHdpY2FwYXhoNFhwVENEeHNoc1k1VXdTRlpjT2p4?=
 =?utf-8?B?QWdLZDcycmtTVlYwZHNvdGVEbEdGMHQrcUppUXBsTkI3RGFPZ3FBcnl2VlB5?=
 =?utf-8?B?N0NTYnpEbXlJMFVXVHYvWGtwa3grRHQwLy9yRDN0MFBtVjdNeXpMWjNOS1VZ?=
 =?utf-8?B?bjdZNmpsSUZieDFFZUVVK2g5NTVQblB3cWgxZlVueG8xQWwvbnVSVUNKVVFw?=
 =?utf-8?B?V0Z1Y1FiQlEvcSt0SlNabHZjcXlMSmd3YVYvcUgyc05rM1pjcVJrVzVvTGMw?=
 =?utf-8?B?U3ljVWloQkN6VlBpbWF2bTBTK25RNFFyYXQvWFZVTW8wa1g2Ym0vcDIwUzc2?=
 =?utf-8?B?RnB2MnNmZ1dabmRQVGJaYU5aZGRBaitOT2t4bXhvYnEreUJ6OFErQjE3MWJB?=
 =?utf-8?B?U01qYVlrb2RJK3crUVN6a3l1S0M5enVVeEtreW9rUGpqSUljRFNHOTlrN3BZ?=
 =?utf-8?B?NkdRQzJTVHdSOXJRNE1vL01aMFR1NE1XUml4cXpRY2tLb0NLUVF3YUNCV3FZ?=
 =?utf-8?B?a2VkUllXUCtPcGZrQ3VGMTRDdU5zMWNMeS9xTmlDQVZZMk55L3dKbStiSzgv?=
 =?utf-8?B?MmluejczVDdCQ0FBeXpkY1Zqa2NRV0I5REMxZG9sUlovMXRPQloyVnBCcy9O?=
 =?utf-8?B?UTF2elpHTW5OcTE3RnlMUk1YSnV3Z3N1b3h5Qm9MS3FPN2NzQzZkd1VhNXJh?=
 =?utf-8?B?K3hVL2J3YVNleEhYQnRNVEU5UFFZWDdLdzRIUVBNNThobGN1QWQ4Z2wvZHZQ?=
 =?utf-8?B?Wktnd3pudmpuemp0WTROTzVNTjV2TUlsRTk2OEtoNDc3Q1VTUmN3bUZBM3JR?=
 =?utf-8?B?ci9UZXlvcGJTa1VvUjBkOHlNYWFCUG02OWQ0cDdOZFlIRVB0aUdFUTJwTElJ?=
 =?utf-8?B?NVBxZUdrdHFUWm5yWnBJRTRGN1dNbkVoS1lubjRGRWVhQnR2V01ERStkcWV0?=
 =?utf-8?B?OU5sNGlWUTQrdmNpQmV4SDVhaWxSUFpiazh3dnZ1NzlxeUM1Um9EVVNWVzdk?=
 =?utf-8?B?NDllVE1yRVhvNjlodWZic0lVOFpRUGdGQzBNeEV4c3kyRGdXdTNNZE9uZ2Ix?=
 =?utf-8?B?YVZiOXNNYUF1Y2s4UVVwY1p3bzB4dlhST09HQVd0RTYwanVzWEFJVG44N25F?=
 =?utf-8?B?S3oxS3piQkN1Y1JCc0c2L2dNa1RNclpDNnJPMUtwR0kwQ2thOHZkNVhXd3Zl?=
 =?utf-8?B?NHNUcnFTVFlDUEdrN2NGcTAvZkUwb1dvbjllLzd4K2JPVlVTZUJFbTFLaGJV?=
 =?utf-8?B?bHJSeElLZVdQSjlvVWhjRDBsUEpXVHFkM3grenJIcGpQK1h5OUc1S3YzbWQ1?=
 =?utf-8?B?UTNqRzdaS2Zyd080NVFaeE8vK2VVaUdkVS9NUXZLL0tUNzFSRmlOb2IvNUZL?=
 =?utf-8?B?ZTdDQW51ZFNxZEJtY0VTVXQ2cXlsbm5YQUdvOERock95MXNPTUJtZEtCVnIx?=
 =?utf-8?B?bDJCbGU4YWdoNWRpWERDRUhkdUMxbXlMSmR1QzFWSTNSRmFEdHZnK2tRSWdO?=
 =?utf-8?B?clRIQVBNVjlOaGR0aU1aZElqZ3hLcFF2TEVyaENpdElLRVBYZjFua1R5Zk1t?=
 =?utf-8?B?bVhRaDdWOVFZV01HNmVMdDBEWE5wNkhEK2JkWXdJay9Sdy9Ec2RQd0ZxUEZT?=
 =?utf-8?B?MWdlRFN0RzlnT1NpT25lUjdramUwZE1UZnpxZm1BNWQ0N1BpM1ZKTWFFM2d6?=
 =?utf-8?B?dDVxKzRlMjJLOUZNNGtlSU1zUzlWZzJrNWV5WklDUi9iMXFnU1g4andHZFQ2?=
 =?utf-8?Q?WWkeuOruHg8aFJTQcihb6Dt7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3bb17b-1586-442b-e6f3-08ddbd3a9a95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:42:35.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXMC/Zr78fEloXtrecFmv2tjquvEwGAj7mXmxoHXqJkAty0VMFeL+sjiJMF/S+YT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

On 04.07.25 12:33, Prike Liang wrote:
> The userq VA unmap requires validating queue status before unamapping
> it, if user tries to unmap a busy userq by GEM VA IOCTL then the
> driver should report an error for this illegal usage.

Clear NAK to the whole approach.

We should never deny unmapping a VA because it is used by an userqueue. This can cause a rat tail of problems in userspace.

Instead we *must* suspend the userqueue when the VA is unmapped and deny resuming it.

I think we can do that by adjusting the usage of the eviction fence for the BOs used by the user queue.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  9 +++++++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 30838e5279bd..221292b6417a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_usermode_queue *queue)
>  {
> @@ -290,10 +290,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  
>  	if (f && !dma_fence_is_signaled(f)) {
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> -		if (ret <= 0)
> +		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			return -ETIMEDOUT;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void
> @@ -509,7 +513,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		mutex_unlock(&uq_mgr->userq_mutex);
>  		return -EINVAL;
>  	}
> -	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
> +		/* For the fence signal timeout case, it requires resetting the busy queue.*/
> +		r = -ETIMEDOUT;
> +	}
> +
>  	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	if (!r) {
>  		amdgpu_bo_unpin(queue->db_obj.obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f042372d9f2e..c8cdd668a8f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct amdgpu_vm *vm = bo_va->base.vm;
>  	bool valid = true;
> +	int r;
>  
>  	saddr /= AMDGPU_GPU_PAGE_SIZE;
>  
> @@ -1949,6 +1950,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  			return -ENOENT;
>  	}
>  
> +	/* It's unlikely to happen that the mapping userq hasn't been idled
> +	 * during user requests GEM unmap IOCTL except for forcing the unmap
> +	 * from user space.
> +	 */
> +	r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
> +	if (unlikely(r && r != -EBUSY))
> +		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
> +
>  	list_del(&mapping->list);
>  	amdgpu_vm_it_remove(mapping, &vm->va);
>  	mapping->bo_va = NULL;

