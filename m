Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D9CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 04:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF9B10EAF1;
	Fri, 17 Oct 2025 04:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5dlH8o4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F258910EAF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 04:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjCQpXDrShbp6+Xhy64g2H2wia603ltTXqdKc2P/grLB1Q8yqnU9YcXY3z7FttVhYtNYMGHwSiX5+d2K4okSt9ayfYhtpHdmEtnQJSFgqk3wt1re5CF1tR1ZFSIOudaMjhU2YNg9YVtuT5lP5g7o5qw566oVnuGxae6K1YoCAcuUDDI7h5VnrCROiw5rxwLSBsht/KLJRcxnmONIYFvgEet1X1G46N+HQvVFbPT4IsHgjBwRM9XmTZ+2lUT/MA0IzNbyX553q7iBEKZocuRwd1Q44EgatU1yu/RLK7lwqrtDftdSbavnB64qgW+gJ6aV0KqNB+9fhnN0TjjEd3Kazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upprGOWLR6uFMdeiHDRDVMG7pJgOwcZQLK3NVq4dDKo=;
 b=e9Sr65RRxHz0zlphnmdayzMYJsCAiEPzgdd2DvBf6eXx5r3eETumK86wwO/DD+hqZNWgeSuTS9/gCbxjMHPOkmTklAjaZx8gtmV7oaNKJ1iW7RqUnpKBeSo119dtWvqmD+lRF7iIQdn3NPLvdqLVnpzGx6za/yXmRSoZWBeDq90/O1udkAEp4P0bYepoU9twX4+mvYl09/AXwJwVtpUx8+nml8jSZO1bxMYv478tEe7i/SDEFTiXyrNMKqu98rQgFhaOKUdlfilpBZOMcAlVucatXrvjoZbrEWJa+nW/nqvadtynYU8O1qBe5cqMmbDL2rctUO4eOUYAX3VjboFYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upprGOWLR6uFMdeiHDRDVMG7pJgOwcZQLK3NVq4dDKo=;
 b=o5dlH8o4Kj+oGhNTFm9kFjVWN1qMTgjL0uFNF3QHDE9E7hFGj1lbCQ59hjeSDtTvTZky0+JuDykz4CT6p8pLP07x4X8pudyDPLtIY/UdPYVMdH6PwRu8GYiO0cVIeZ5G5PzuriqD4YwRa+loJGqH5hR6ZaJVnl0Iger3Txau/KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 17 Oct
 2025 04:23:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 04:23:02 +0000
Message-ID: <80f855ad-8fd0-4d4b-935e-9cb2ee154b6a@amd.com>
Date: Fri, 17 Oct 2025 09:52:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251016180219.15879-1-yunru.pan@amd.com>
 <20251016180219.15879-2-yunru.pan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251016180219.15879-2-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 92803270-29d5-4bc9-8b58-08de0d34dc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU9LMUdEZW91ejlpK1FsVTRxS1hsVDZSTjFSaHVTcUppa3U2T2xEVEdqNGty?=
 =?utf-8?B?TGtiMFdsM291cktnYkk5aHMvd1pVdE4vRFJEa3drVmViTkdCVlRlb3hwRnRs?=
 =?utf-8?B?eXNrQXJEUTAzYTJKNXBuMEhSdEllbElwVWdUTDB5b3FlbDFLMXB5WWxGVGtu?=
 =?utf-8?B?dDNPOEJOT1d1MEpjZ1kvOUFNc0N3WUY2UVY4UUIxVnJ6eUg4OXFmRjQ1MzdJ?=
 =?utf-8?B?REtUbGVPb1RCSndMODVOYXljZFh0Qm4vY2pKZXk5OS94UXF5eFprU09UcVBQ?=
 =?utf-8?B?bUQydGppMXE2SUtKZ1VkQnhmOFNlMG5hQUN3eFBpbk5GVVFnUGZLQ3RBTkR0?=
 =?utf-8?B?Ky9XdzJ0UTNwL2VQM1J3QXBmOHdzN1JmOHIxWktQcy9RYnlkaXpmcVUzWHM4?=
 =?utf-8?B?RzlRSUJVUEdXRHAxWW40UGNVeDVwTWVLTVdLQXZCVXByd1ZuSzdFODBqQi9T?=
 =?utf-8?B?RDJsWWsyYWZla1hIcmIzZEZLMkRiNGJpOHBBYWxYN2xxVHFmYkRpbHUwMDd6?=
 =?utf-8?B?TlJOcVdnV3F1M21ZbTZVU3pWYVFLWFdCRnI2WWM5VVNDV1J6NUVHWVEza2dW?=
 =?utf-8?B?SXIvVThnUnp6eGs5RmFNUmorbENvNnNiQjVaVlh2aXhXcnJiUitxV3RrelJ0?=
 =?utf-8?B?TG5oQkNEYWFpTUlCQ1RyZmN4bXJXRHdLdDZxMk5YTmJhdno2YmNtL2NsaTdM?=
 =?utf-8?B?MHBlYWJ5QzdNdWhYREJhalBTWlNjbUlsb0JJUUNtSW9OMFpqNEw1YlI3S25k?=
 =?utf-8?B?R2hjTjNDeXM3Z0hsaFZCNHJZa2hmV3RpNm8xTGxOditUWEZidFI2bEJtZnI5?=
 =?utf-8?B?V3hReGhOaWozTEI4YWk4cUl3QmJkT3IvR3RmRTF3UzJ2aU9pYXI3OHBWeWk2?=
 =?utf-8?B?NGZtZVMxS2RKSHdIdml2VnBhNzFQcjRHenJXSGdEY2FybjV5TjhLSkVCK3JW?=
 =?utf-8?B?S2YvTlBRcGpTUFNQY0prNGx2K2wyZVM2L0x4TEF2RTFPSnlvMjdtWENKaDFv?=
 =?utf-8?B?emx1N3libGdiajQvMEVjTHR0cVR2eThHL2doeDhTMTNBNUlFQ3hIRElCWjlU?=
 =?utf-8?B?a0FNdFM1T3JNbVdPSFRUSE45bVNpUlpSbWo3SXNPSVlZVVphNm9GMWxPelE1?=
 =?utf-8?B?dG90N3hBc3htTjhDUGo1RjlNV0NRS1VwelE2TjdWTlJOOVU3STdJUWZ4eGJK?=
 =?utf-8?B?U1EyOVBJMElzbnIyNTVmdTQrakRwamNBbzM3aDBCU3NXOHBQTEdGYU5kNWFT?=
 =?utf-8?B?Tm1oWDJhemdjRGNkWkxCRG1BalZBZXFFM1IxbnE5ZTAxYkxwK3A3YW5FQ25M?=
 =?utf-8?B?V2oxdmR0VjNLWEJwUC9VYVEvZ2lwZ2JGWk41ZzFldVJFN3RsOFUvNU5wYmxD?=
 =?utf-8?B?QVVnZlpmSkxlek1rZUJjQjh1eGJnMnVmVHhMcWFvYVQzQWg5cC9vOWlxajU5?=
 =?utf-8?B?OHdBQmx0WkVuelFMMGtScjIzS3BZbWZiMXhIaHdXYlJGeGFldXN6STlreWcw?=
 =?utf-8?B?U09JZE14WkltN0ZNVzYvd3g1TGZsa21rUkw5UDFSUDFDOVFwOWphWWpaRGsy?=
 =?utf-8?B?Sjd4cjE3Y3ZucG1MTkVSTm5Hci93TFpjaEZRMW5tdVJIbm1PVUk1VjNDclhW?=
 =?utf-8?B?aGpheGE1TXNUYU5DN0VTK2dVbmFaRU9jc05JTjZWemtHY2ZKMTVkUjJxSW1Z?=
 =?utf-8?B?ZGpNcDVMWS9pSE1BMHN0K3ZRYmFWNmc0a1Y4S21WM2pON3htbUdTR01DeWNr?=
 =?utf-8?B?SGRocDJvU0pnWmwrZEhFZk5RbGNHYW9RMGlkV29rbWJyOWJTS0htMmpSNFhH?=
 =?utf-8?B?SFZDZXpxMXFaendpRmpjUWQzNDdrWVUwU0xmbFdFOXRSVnFpQ0EzYlkrUVVY?=
 =?utf-8?B?UTk0aGVRemNaYnozNjdPTWhkdGhUY0pGVzdhWURqMk5LaGE0dnRVeEFvQ3dy?=
 =?utf-8?Q?DUyjEfzZ98KpJ00piqEzOspirqRDXsKQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhiNXNBdUVNa1dnRzJsVXZGRkIydDVpWFF0S1Btc3phY2thcFZpYVNlMXJt?=
 =?utf-8?B?VmxENytZK05nV3dQSkdCcnNpM09NZks3emZsWTJWWmtsNE04bWhaZENDVWVp?=
 =?utf-8?B?cERKMVFITm1IYWpxRThMOXBqMExMRmpicHJHUTlVaTNRTmlNb3JPVzBHRTNj?=
 =?utf-8?B?bkQ2TXBua2xxcVBtMUIyOWdhSG1jZk1ZaWI5VXk0WTREMVpoWE1IdmZEOFhW?=
 =?utf-8?B?S0pjK3V0dnZNaVZGWEdZSnB1dWlCdGwwMXB3N1pFTlh0aWJjeEJHc0RMSXcv?=
 =?utf-8?B?bVJGdVpCTEh4aUtXZ3BKRndDdjdtTlRlYVcwZDlJS1F6MytBangwSklIblNj?=
 =?utf-8?B?eXg1TzVRMldLZEVjMDBSemZLSjFxbnJiQ3ZCeG5wV0pobnJqZzVEK0IyVjBx?=
 =?utf-8?B?Zi9QajJmR0hxRjRUcHJjNnlKRGhCamtRTDFwTXlwL2pKQXh3MFB0ZE1vY0tE?=
 =?utf-8?B?dWh1dGNMQmdyMWNub3NEOFBzeFFOOE1PcitmWDdWS3VjWGJURnBzSDJPNGdJ?=
 =?utf-8?B?Z05WWkl2VUJaVmVJV3VMTHZ3a2FKcXk3RHAvZ2srelpVMjBNNk1Udlpyc1pX?=
 =?utf-8?B?MVoyRk1rc0h6TDk0VFdlVGtISW56Z2lUU2svRVJKYjlCWG40eTlqOUVvUWJx?=
 =?utf-8?B?L2pjeU5hemFzeXFydHNuRXhaeEIrVGdZaENrZmlGUStydU1ZVnRhWkV2QjRu?=
 =?utf-8?B?RUZKY2JYZW9VQnFJalEyZW5mVFNzamJYbS8vQk1uM0lmQ2gvYW9KZjRsNCtv?=
 =?utf-8?B?K2tlbUZTTnpqTUZlRlVrRU8rR2pKcmtZOEVOd1JHQTVkdml5NkJ2SVpaS0ho?=
 =?utf-8?B?ejFkSHpLNkVMSHpwQitZWjJrWE9Yc2ZzMHpFbVkxR2xMaVZxN1hEY3lReW1X?=
 =?utf-8?B?ZnZzRkI4N0s3MlYwcW9USHFxT0hMOXI0ZTVJb0x3c0xwRlVlRHBtdzFYR1hk?=
 =?utf-8?B?VUhScFlsR0IxWEFEWXZSS0tkcDNKdHFIMndNRC93ZXhLT1AyNDFOOWxQRkhm?=
 =?utf-8?B?VUlQNTRUcXJsV1Rhb1d3Z0xnY0Fxdml1Vlc5MEdPNkJ0Mm9rWnlIUEVieFd4?=
 =?utf-8?B?TVg0NWJObVB1ZkZkUzVwK1ZmbXBTR3hiS3BvZ2RzRHVBQ0wyOHIyZStOSHJ0?=
 =?utf-8?B?ZnVoNC84Zzl3UDRONnpZTENVa1N2VDZ1VFFLNERxSDFyVVF0RVdrUlh4ekNK?=
 =?utf-8?B?ci8zTm00N3hyR29HaUJRREk5YkJ1SlFMeXJ6RmNpRjc5Z29RSkhTWmZ6aHFa?=
 =?utf-8?B?SDc5a1NYQ2NJYVQrSFVJU0dYRDk3RCtJbVNWTHp3OXNTQkZJNTBnWDltcVFa?=
 =?utf-8?B?UzdFQTRabFVERWdTcTNmZ2dKZkI0S0RJRnMycExYNEFvWEdRTVlwVUhWRm9h?=
 =?utf-8?B?djlhcC9pa2ZnV21LTUxjdURxd25sLzdSK29xcmREczdtbHRuL0dPcm1vVndu?=
 =?utf-8?B?cnVkeEgrSWM3d2JqNUZOb1ArVk9sRFZKdTh5NzY2T1N6cUVwTStzc09ySUxr?=
 =?utf-8?B?Y2tVWDRhT0gxdGhwK2tzYzRMRm9id05OOG1Ham8zUkxaQ3BYcXNuMGFWSGxX?=
 =?utf-8?B?V3NWRlF1bStLeFBTTlo1ZUtLdkVkZTRYWktuSDBPL3lVbmZRRkhSZDU2S0pv?=
 =?utf-8?B?ellqYjQrRUxVYzdmWlYzWVJCbU1MYzBsTDdIUGoyRE0xRG9XU3loUUFVYXBQ?=
 =?utf-8?B?OTJ0Z1A4VFBNMlEzaU1pMWhoQ3F1S0V6L3pFbjBERkZtV3dkN3U1VllLeC9z?=
 =?utf-8?B?NTJwZyt0c2xEbGlybkdMd1I3MzhjbnlzRzZoQW5TWURZS0RrNDdHZk9ZSk14?=
 =?utf-8?B?a2UyKzJqRTJma3VVanlMbTV3NkcweFpaZWl2dzB3TG1XTVlyNm9kS3Byd1hs?=
 =?utf-8?B?MnIzT2dZcisxMDZQVG1YNWtHaEZsMGc3RkNrNXdtYU42R3I1SVVicDVPNjZr?=
 =?utf-8?B?VkVhdHB0eTRReXZROGFCWmVzZ0pGQ3JnekxkbGhmWXF6eGRrUVVuVlhEY1NI?=
 =?utf-8?B?VktzaUx0M2xPZTZqakJ5RDlzMEpzb0ZiZVdNTnVOajBiQ1h2aDlzQnduTUdH?=
 =?utf-8?B?b1RnbTlMaGQ0VkJnZi9VL0Q1Uzh0YmNoQnNiZ1dydjNhTmZpZldsZGU0Rnhk?=
 =?utf-8?Q?dcb7iHX6dpDoIZ6iAaZaU+0kr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92803270-29d5-4bc9-8b58-08de0d34dc38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:23:02.1108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gc4WrSednSasOEyWKXGVY7Da6J+AZLKu/e71U4rgGLxO3JXJ9bGmzOS1oBZusKal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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



On 10/16/2025 11:32 PM, Ellen Pan wrote:
> 1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
> 2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 34 ++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 26 ++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 37 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
>   4 files changed, 85 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 00e96419fcda..070fd61f8463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -96,11 +96,12 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>    * part of the system bios.  On boot, the system bios puts a
>    * copy of the igp rom at the start of vram if a discrete card is
>    * present.
> - * For SR-IOV, the vbios image is also put in VRAM in the VF.
> + * For SR-IOV, if dynamic critical region is not enabled,
> + * the vbios image is also put at the start of VRAM in the VF.
>    */
>   static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   {
> -	uint8_t __iomem *bios;
> +	uint8_t __iomem *bios = NULL;
>   	resource_size_t vram_base;
>   	resource_size_t size = 256 * 1024; /* ??? */
>   
> @@ -114,18 +115,33 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   
>   	adev->bios = NULL;
>   	vram_base = pci_resource_start(adev->pdev, 0);
> -	bios = ioremap_wc(vram_base, size);
> -	if (!bios)
> -		return false;
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
> -	if (!adev->bios) {
> -		iounmap(bios);
> +	if (!adev->bios)
>   		return false;
> +
> +	/* For SRIOV with dynamic critical region is enabled,
> +	 * the vbios image is put at a dynamic offset of VRAM in the VF.
> +	 * If dynamic critical region is disabled, follow the existing logic as on baremetal.
> +	 */
> +	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
> +		if (amdgpu_virt_get_dynamic_data_info(adev,
> +				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
> +			amdgpu_bios_release(adev);
> +			return false;
> +		}
> +	} else {
> +		bios = ioremap_wc(vram_base, size);
> +		if (!bios) {
> +			amdgpu_bios_release(adev);
> +			return false;
> +		}
> +
> +		memcpy_fromio(adev->bios, bios, size);
> +		iounmap(bios);
>   	}
> +
>   	adev->bios_size = size;
> -	memcpy_fromio(adev->bios, bios, size);
> -	iounmap(bios);
>   
>   	if (!check_atom_bios(adev, size)) {
>   		amdgpu_bios_release(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4e75334f3b3a..863ceaad8c21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -303,10 +303,26 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   	 * then it is not required to be reserved.
>   	 */
>   	if (sz_valid) {
> -		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
> -		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> -					  adev->discovery.size, false);
> -		adev->discovery.reserve_tmr = true;
> +		if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
> +			/* For SRIOV VFs with dynamic critical region enabled,
> +			 * we will get the IPD binary via below call.
> +			 * If dynamic critical is disabled, fall through to normal seq.
> +			 */
> +			if (amdgpu_virt_get_dynamic_data_info(adev,
> +						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
> +						(uint64_t *)&adev->discovery.size)) {
> +				dev_err(adev->dev,
> +						"failed to read discovery info from dynamic critical region.");
> +				ret = -EINVAL;
> +				goto exit;
> +			}
> +		} else {
> +			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
> +
> +			amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +					adev->discovery.size, false);
> +			adev->discovery.reserve_tmr = true;
> +		}
>   	} else {
>   		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
>   	}
> @@ -315,7 +331,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   		dev_err(adev->dev,
>   			"failed to read discovery info from memory, vram size read: %llx",
>   			vram_size);
> -
> +exit:
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 083823f58c15..5c846798f4e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1008,6 +1008,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>   			init_data_hdr->bad_page_size_in_kb;
>   	}
>   
> +	/* Validation for critical region info */
> +	if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
> +		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
> +				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
>   	/* reserved memory starts from crit region base offset with the size of 5MB */
>   	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
>   	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
> @@ -1026,6 +1034,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +	int data_id, uint8_t *binary, uint64_t *size)
> +{
> +	uint32_t data_offset = 0;
> +	uint32_t data_size = 0;
> +	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
> +
> +	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
> +		return -EINVAL;
> +
> +	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
> +	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
> +
> +	/* Validate on input params */
> +	if (!binary || !size || *size < (uint64_t)data_size)
> +		return -EINVAL;
> +
> +	/* Proceed to copy the dynamic content */
> +	amdgpu_device_vram_access(adev,
> +			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
> +	*size = (uint64_t)data_size; // update the size as out param.

// comment style is not allowed, please remove while submitting.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +
> +	dev_dbg(adev->dev,
> +		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
> +		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
> +
> +	return 0;
> +}
> +
>   void amdgpu_virt_init(struct amdgpu_device *adev)
>   {
>   	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 8d03a8620de9..2a13cc892a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -442,6 +442,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_virt_init(struct amdgpu_device *adev);
>   
>   int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +	int data_id, uint8_t *binary, uint64_t *size);
>   
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);

