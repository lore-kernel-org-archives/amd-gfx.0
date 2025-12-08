Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C69D3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7719610E11E;
	Mon,  8 Dec 2025 08:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOCrG5Y9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C681610E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPjfSd/S98Pat7IOA9qaKwDNK6wVQqzJdPSDOhUKNEdVkn5D65r2MQTxjy+8Ogrn7xC04NTip5qvYC800IEBQ5dGgDjX5rjfXl8ISv8FvQVYAVciE8nV+lJjDcRaIrGC4s8Z/evYvBvimJMAQrh4zuwc0q5lYVy9RYJYPOMe2kEknymMlmCgYKMV35rZpfvD/XzEa2vu8yCw7ZKynXwlRGloIlt52PNC0yRIKj6M/Ky3Df0Yz1A42M6FXqruOwdKxiapAaZdZsXzjIKisWg2va2bIGWW12/MUXLRWXGkO93Wt000fDjSc4JXueaqcvj575kpCbOFBi8adWBZqm9aJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJFaHQ1F9BajMQTFm5u/AeLxp/1b1FOcLjp0/1sJF0M=;
 b=T2uf2vXtWxsCQhp0LGADBPPTd5BPYYtOfcLYh33TPtaDLB6hcYudA8z7CbVw30dvb/9sFTj+y+uJSW8jsqJnOYkWphLXZcOij6WIZMe5gBKr+rp/tAiPr/PhXcwnhpnXIrndlogk30uqISRp3ACABHmB4J/AmEFlH/36eiiTGKywXEErsiOH/TEdNuC8XT49RTESlO+lWAirSDdGPos1qtk3NlSg3D98/c6kH44EtgMRlC2+iHs2KDgThrvcus1FFZTSmRPhUtdj+65tJs03F5HhfFcv4fvnWZbvIgEs9+JOBPggkblgV2TOimFa73BrYsyAVRcTnrjGPI+Uy0Mesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJFaHQ1F9BajMQTFm5u/AeLxp/1b1FOcLjp0/1sJF0M=;
 b=tOCrG5Y9ISLoizpp4zLPcOLcJkxBiPFAYcnfXwAeKEp9/yz9E2e8E2hasLBNnxQgVZp8kIzPjPYOIbu1CGT4jRxvw00MM/psSF3ZjuMH36myW/ORECKbj4OEUSHFo41EEaApYJVXqw2wJ7KlLTMaFhJOoRAKkrMKQh2SySJu9vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:41:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:40:54 +0000
Message-ID: <a90486e3-e27d-4f05-a129-82068f4c9093@amd.com>
Date: Mon, 8 Dec 2025 09:40:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-6-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205214922.1095629-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: c39b172b-d360-4e8f-326d-08de36358008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnVlNVEyQkcvbk1LcnNIb1d5L3p6YWd5Rm9DbDJROFBQR0FLbGJOU0RqcDBD?=
 =?utf-8?B?RUNSZGRGMUZZMHZmWGpldDhqbUxZTkRrd0RWNEdodFNUdSt0ODdyM1lNV2g4?=
 =?utf-8?B?QkI5WHZFcy9QcFAvZXdkRm0wbVZ0ZFE4ekw1MmU1Ni95VTRjVXk3cmxVL0Np?=
 =?utf-8?B?eFp5UE9MWGxmOHp2Q1YvaW1GVHJsN25wVWVHTjBvbmNvM0RsTlJQMkVoaS81?=
 =?utf-8?B?SFFkUFowY2dkTytTOXNGdFdaTDJOMGFrN3orOGU5bTI2OFp6WG1rczVVc0gr?=
 =?utf-8?B?dWJncXdMSkNHY2twM2RCSFJPaG05Y3UyZTNWc1FQYlZvT21IbWk5SXp5dHox?=
 =?utf-8?B?ODBJeG5DT2IvVUY0VVlrN2c0S3hSS2xWamVqL0lIZUxNY2g2ZENXU1ZjRHM2?=
 =?utf-8?B?aFJlTXo3WU1FWmwyOC80dnk5WHJmKzVBNm5DR3BpYzdMZVBoZkM4bkRzZU83?=
 =?utf-8?B?dlExNlVGV0NUeXFPQmxBYklxbGlPeVkxSlkvUGdpMFZxVG5jOTBDL3BtSVYw?=
 =?utf-8?B?YXFyWU5hVS90anhwRlBJRlVKb3kweHl5TFdZS2JjY1Q4ZnYvc1BmT3VNU3gz?=
 =?utf-8?B?OVNLa0lxblN4RkNyWmRtZ3FMdGUwcFJxSGp1U0xjQkF6NUNoRXQxRXBibVd4?=
 =?utf-8?B?R2RiSFRnTHZzakJ3amloS0pMVTlQa05qUWYyamNXY3ZnWi9qYWw5c0ZXL25F?=
 =?utf-8?B?RUZoOUQxemZ5bmZURVhBaU5yMVZWSTN1dGgvNUJYRkVBbnpSQVU3M25ZdE11?=
 =?utf-8?B?NnVLTEtWbjFyc1g1Wlc2U0RjNHVsS1hwQWRrR2w3czQwZ1JGUzVybHpKRGFS?=
 =?utf-8?B?azIyL2VLb2E3KzVYSXpJMnlxWVRlVFE2d3h4NENjUzczeGVrODRJV3pnR3BU?=
 =?utf-8?B?Q1h0SnRDKzhIMDE1TE4vQ2dvQTFMWU1TVGpDWGw3OVF4QmdocGxDTGtrR25h?=
 =?utf-8?B?V3ViZXA1cDZ5Rm5aUTVTOThickhKb0g1SXJPbnY0UlVpandnVXU2anEzb1Rs?=
 =?utf-8?B?V0Ridm5RU1ROLzJKRDV5OHZFL2ZyUGViZ2FzN2duY29mOWUzUWJNTGZjeEJh?=
 =?utf-8?B?eHBnUmRUT2FuMGhBYzNzcHZXaFZDZmh0eDIzWUV0WURacFFibVB3MzhyYkRs?=
 =?utf-8?B?OHR0S09LM2lYWVlERTkxa1duSzFvS25obVlVVnlOYkRNZi9hY3FRTTVDWXpR?=
 =?utf-8?B?cDNxMk52QVZXUmt1YmFZY3JkblNCYzBneVByNERhWm5iR3laRVZSVXlyVVdv?=
 =?utf-8?B?MVJBcFRHbVdBbFAxQ2tnSUhVSGF1VE8wLzFwN1V3UWZGbGJYanJ1SWVzMWFT?=
 =?utf-8?B?cFhPVExBaUFqa2FKM3c4cEdHQW5kNlU2bUorbUtZb3Q3L1B5ZEdUcE8za3k2?=
 =?utf-8?B?eHFIR05YWXVDSUxuNVZTQXVjNTVvMk1Yc2ZXSWRHdkk5eEJIQ0VnaDFaMEFx?=
 =?utf-8?B?Ynp5SEp3cklZT0F5SW9hOTNHNGYxWXdHcXBLQzJsM2tQcHNuMi9VTFU2eE14?=
 =?utf-8?B?UGV6ZWJUY1ozV1RVRndxV0liVUl5TUNWZzVqNDlLVFFNYU1peXBDaXozVHFZ?=
 =?utf-8?B?ckxhQWptcnlhS1kvNnZrcmR0NnJib3RKNkIzMmtMWDgrOVJWUzh5NWJMekF0?=
 =?utf-8?B?eHVaaGFPQzFCc29aQnJ3NVVycXJoUTV1U244Nmp3RmtGSDRHdVhTam1pZHpS?=
 =?utf-8?B?aG9rY1VXRnZsMkk5M0RiZDc3SFF5YWdydDFxRzZYK1R1N3BXZ3NXNGplL0Vi?=
 =?utf-8?B?Z0dMQ25lU0tpZVptNVV3a2piUDJSTDVPTHR1MUl3Qy94NVZuWjlyVEZKTzNE?=
 =?utf-8?B?NjNQSUtiaUl3cGFQcXVHU050cW9DOFJZSFFKdFAvNlk5UUxRMUg2Z0pITHl0?=
 =?utf-8?B?Q2xkVCtHMUFpRjVXTHNERHZ4aFN4dmZ6ZnRJL3JjNGx4bHBCRW50VFlFcEE1?=
 =?utf-8?Q?sKIp+p6VQOgwKIiOP0NzvnAn8VBCQYLB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lUSFoxeDYwK1V6bEhoNmlyQnFudEdKdGl4MHVmRVQ2NVRZalA5cUZDTXMy?=
 =?utf-8?B?cHMvQnhYODBLeDUzSGp6UDJSSStUdzJtRW5hMW9LcHozR3JUNUNYdWorS1VV?=
 =?utf-8?B?dUtmT1dxK3dUd3RrSUdmYmRGZ3YzZk5lam85TkRqQ1NIYitlSVlHaUUrcFM3?=
 =?utf-8?B?aEcweGRiZWhUWGdoOEd2S3M2YW5ZeW55bXY3OVdkdGFnazlFNmxHY0lVeXVx?=
 =?utf-8?B?akVrNkVqSlhUZ3MzZ1hpTC9GcE1NSEhwSVVHMFZMcW9QNGJuVVljcVhnTWpx?=
 =?utf-8?B?TUpJV3RRMGs4RmxmdGEzc1RiWXk3NXcvdHdqNUh6U0o4Qkk0UFlVNnVJT3Bp?=
 =?utf-8?B?RlZOWWZFdGY5U3AxbkNNdzlmSnk0TWVGZGZxenllQmJ0Rml1MCtsRXdKcGRr?=
 =?utf-8?B?cWNXeWlXcDJQcGcwVUhDT3JxdHl3UnUvcEJYNVhKUDY1TlZqVEJUWlBGbmNu?=
 =?utf-8?B?N0NIbXFmN256OVZJbFkxbTFYODJmU29RNGE5Z0lycmE4U3VWSW1yblgrQ0di?=
 =?utf-8?B?NnRxb3ZoRmdoSkpGZWxFYmFRek9rejJISnVoMmQrU25RaVNwVEptQ1BKWGds?=
 =?utf-8?B?cnJrYmhDYWNodE52VkJRRk1nbVRJRnd4UzdicEFTZ29OZnNUcXo3Y0QyNVZk?=
 =?utf-8?B?VFVma1l4UFFYc21nOFV3NHplbWw1SXRZRzFaNWI5b2JNWk1SMTJtb2xvSThK?=
 =?utf-8?B?QUlQUzZFQXZSY1FKT2dZZlNBd2xDREtDNWw2RXBRUVNoT2NBK1ljQWE3dlh1?=
 =?utf-8?B?NVFub1B2MURmYVJUaUt6c3kxWU9xaDRWZGR1enExR0RUTTBXbjV4a2FocEc4?=
 =?utf-8?B?d3o0ejE1YktXZHhQa0VkbjdjaEF1cy8zeDg4czJGTE1CNTJ6KzZYbVovc2p0?=
 =?utf-8?B?cHAreWQrQVVNUFJqUWVRbVR4TG9iRGZLT2Q3MEl1UVdEb25sNFdtU1B1SEp0?=
 =?utf-8?B?eDRqRXVjdEZwZ3I2NDJzWTl4S2hPUkhNUFhpVkVGQnV6b2ZMUUdlVVZXWXlx?=
 =?utf-8?B?Ym5JR01lRXRFOEhpM2FvTFQzZUhLRytoMzRrZWgxWGh2dFdTV2Rpd2Q3WDBH?=
 =?utf-8?B?TlRaaXlIdHc5NmdFQ1doSExQT1dkY3hkMXhGYkY3ODJabVJ4MXFBVTI3cmtC?=
 =?utf-8?B?WldPZEEwMFE1TG5BNFB0ZDNraFgzcGxsRUpySk5wSjdKRytwT0NGMzY1V2RO?=
 =?utf-8?B?OUk5clB4WlNXSGFvYUk4aE80aDJkWS9qY3UxWklWODIwUjRwenB2QWhRcURo?=
 =?utf-8?B?U1ZPbm52RFNRcU5hU3hyWWYyMmRsazA0NmNueENIV0lKYzdFbWVKWm4xRXpS?=
 =?utf-8?B?TjNURUs4UzkramZNTU80NU5hbklZeWQ0MWdpMVhiSWtVMTFWVGJHYUl4OHFT?=
 =?utf-8?B?V3dNWVVUaTRNM3lmT0xOWVBxRDdjOGhVbFFWMW5Ga3U1ZnFmenR3ai9jL1M3?=
 =?utf-8?B?dk04K2l4RjlwWnkwcE1kL2hZZjlVRFVEOUROYXE1TGdQcUl5L1FkT1RTcTF6?=
 =?utf-8?B?YlJmbW1oTGhScWpKNTFMc3hlR0IrQ1BPUHByeWhUM3grZUF1TktzUjJmbW5l?=
 =?utf-8?B?emxraGtkRC9GTStOZlNsb2hQWkV0SnlzT21VRWw3blFkamxmSnNxdzdHZktB?=
 =?utf-8?B?UXNNeGxIc0I0RDNibjlDS3IzU1JLZHFWM1ozSFl4UHZQTnNSSTZ2b0taSWhW?=
 =?utf-8?B?ZG5ma2xueWNWa3RIb3N3RkxhU1hNVGZxWTFxN2J2bG92WDkxVzZ0M0daRWRF?=
 =?utf-8?B?SUQ4TXg3OUI3eTR5N0ErNHpycFpkemZvOWVVTjdzbS8vZ1RKOFRaRHhiUDd4?=
 =?utf-8?B?eG95T1BEMXFlZ3BuelJudGdZMTRFNUQvQmNnOS85Y1FDUnU0VkJYUjM4cmww?=
 =?utf-8?B?WHJEU01iTUxHTEpPVmxwSStRaGN4amJ3WjNYZnBtVWtzeXlNMGhuZjlGY2Fa?=
 =?utf-8?B?TDRBbHJYanRwYzdIQWJhVXBhMnhhbUxvZVIyMm5PM2lmZ1IrYmcxeFhpdUZG?=
 =?utf-8?B?L01xL2srZGFVck9LYUFycGhRT0J1MlRuNjhUbVFwcVBPeFJxbFFZUzVRSjRJ?=
 =?utf-8?B?ZmtKSDYwbUFyN1pBMFZnQU5KamRhWWtOb1E2R1lHM3hXT2IwTHlraStXSEFY?=
 =?utf-8?Q?RWPjARV4ivpowtY+LflhgIvKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39b172b-d360-4e8f-326d-08de36358008
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:40:54.4427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OenmaK4H/xXZ9pediqMd7dE2OTbhu/caEQ5T8bNShGtOGPZN9OeNBPRf6pdk9lwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

On 12/5/25 22:49, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency.
> 
> Add helper amdgpu_ttm_alloc/free_gart_entries.
> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
> to GART mapping.
> 
> Add GART drm mm_node to kfd mem obj to free the GART entries after
> MQD is freed.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 103 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   1 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>  5 files changed, 122 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..fc6f4daa9b87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	}
>  }
>  
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
> +		u64 start_page = mm_node->start + page_idx;

Don't use resource->start and ḿm_node->start directly. Use the resource iterators for that.

> +
> +		pa += adev->vm_manager.vram_base_offset;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
> +					   flags, NULL);
> +
> +		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
> +					   start_page + 1,
> +					   pages_per_xcc - 1,
> +					   ctrl_flags, NULL);
> +	}
> +}
> +s
>  static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  				 struct ttm_buffer_object *tbo,
>  				 uint64_t flags)
> @@ -1017,6 +1053,73 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
> +				  struct drm_mm_node *mm_node,
> +				  u64 num_pages)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +	int r;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> +					0, 0, 0,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					DRM_MM_INSERT_BEST);

That belongs into amdgpu_gtt_mgr.c and clearly not here!

Regards,
Christian.

> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
> +				  struct drm_mm_node *mm_node)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> +
> +/*
> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
> + *
> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
> + */
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
> +		return 0;
> +
> +	r = amdgpu_ttm_alloc_gart_entries(adev, mm_node,
> +					  amdgpu_bo_ngpu_pages(abo));
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> +	return 0;
> +}
> +
>  /*
>   * amdgpu_ttm_recover_gart - Rebind GTT pages
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..cb6123358843 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -185,6 +185,14 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
> +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
> +				  struct drm_mm_node *mm_node,
> +				  u64 num_pages);
> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
> +				  struct drm_mm_node *mm_node);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..00e1e5b30a3a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>  	      struct kfd_mem_obj *mqd_mem_obj)
>  {
>  	if (mqd_mem_obj->mem) {
> +		amdgpu_ttm_free_gart_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>  		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>  		kfree(mqd_mem_obj);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 29419b3249cf..fdde907836fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	void *mem;
> +	struct drm_mm_node mm_node;
>  };
>  
>  struct kfd_vmid_info {

