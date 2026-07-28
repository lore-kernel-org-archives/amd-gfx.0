Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2836AC53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B408B10E9D6;
	Tue, 28 Jul 2026 18:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cS7b+rdb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1881A10E9D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9b7MoyXn6p9KV4hkUJvvJ7Ig+/DZXkvSrqt3OAetWJk+G1654brwC6/QzGuTMOfO1vTED7A4QFHGWBwEJGyjNslRCcrFbgikfmpUfNs3YoQ0I1Om6wIzwBF+pAIt9OXODPkjLf4OE/S0AGcXZYsgR9E4AzOXdB8RPqCHtNzV4iQTk7dv1ZWlGu6OMtyGm5rIfiH3A2tWRly7aQtbcfFkJDwjN8XJTvInSTPzx1SNQPB5lydKgZtlRoPKBw+yqamNklGGiRyOK3//EwuUZ5+cRl9d8v09UL/UcYu9QKCQ+icY4SepsJcPxuGrUUm0WS2y3ctyBHPeCkPWhOy88u2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfYNFW0sDDGyDiqPtQPv5bHb7Xb1HwWbtdBZ+ezqbyw=;
 b=VsHU7wK288W8WA8FaVS+mFuh0UE+JJ2SjM1YxCejj7D3VDJ/XY/RjSdLPKZJfFuGM2t1Qfo4XTAUg2/YRDOgoXRXYxjoODGiPX7GxRGWT5uGMsNWiLzAberd3uoS04XiWx3qoiIEfdVblC7kD+Q2ViWg6czmULZ9nk9oQetHs+zVrTgypwt8dhsvFi2HaAQsnnx7t2QhydqrCXSVUYhIi60FDqhKICICoKUB8yTQIGd7RKJ++/k9qRGki/ZfX/7FGlZXri/6nI+gg2xQtqYrCAnfe2q7SohPnUmUfk3FiSgr70gktkLWafD9WQaYP9hacMfRWSoLQBWSkrKYlE/log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfYNFW0sDDGyDiqPtQPv5bHb7Xb1HwWbtdBZ+ezqbyw=;
 b=cS7b+rdbFWjvaOhUJpTG20LgipIOusTLB4te8N4JiJssCyxYfX7Yb/JhqcEulnCjRPG9JSG2Mblm1+jY35EKCw6EsVsZqSEiCgsSxKniX20Yb/+UatgrrAyuCWfCJazeZoFrFZX+vbdHCokVDVIrfWzdeMDUYt+WXWF3aXe60Ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB6955.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 18:57:56 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Tue, 28 Jul 2026
 18:57:56 +0000
Content-Type: multipart/alternative;
 boundary="------------78PGE3qLbQ0KfnXJNS0scqm0"
Message-ID: <bad73216-b43e-4c25-bf04-a86c0e101989@amd.com>
Date: Tue, 28 Jul 2026 14:57:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
 <5b457aea-892e-4df6-bd1d-5fae0f15c5ff@amd.com>
 <SA1PR12MB73432D05527388F774BAB3E5EBC12@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB73434AC08F3012E7445E23CEEBCB2@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <SA1PR12MB73434AC08F3012E7445E23CEEBCB2@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::29) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b6e8b0-bdbd-45ca-fbd2-08deecda2250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: NRyZtL9YipcJY/mSdGHq7mdn/Vd/G/M60TyHfJKTFvaHJm9bqWDoBMq1IDZmf2IqSjl7b4LK7bSxWZLUQJt+9RS/oVLi3eJ8A5zl5o/RNCFJy4S9naFhPIjPEtHVzEbr/LSb67812yL9AdlFO4wFBJyHzc4NoRPLZ6+eeyogsOssp7zlg5zCj37BfujSw9uNjZ7jCF7b++ooB+wrI9tilRuArdFA8GHdPeOR7+NzY4E71Qb+c0SI/ucP7jt1wMzKck10nil3YUz34kdXZA7lzgNRwLaargJvdIh6IO0PG9nLxoIA2lIPoQ9Ql7zrHYL9gdwxYn0T1el2649Urg9QJs2Vvfj3J48fP5u/U7YyWAGf0eY5wIDyxAYKJyFxT6tA8VgVw6xpYF9MRnaym59gsveKRRfCp4c5Qmw/OCpbsJc6PWhfqy+ZRY1gAbW6aGMPdkHSxj5RTuOCvmvixxkmBYsDOZ96HZBCYnkHtN12z0Y9Y5gkc7tC+GsSTNN7ID5ZsnArvCTd5DHinAn9t9Jt3+qzjtec7FCVL1PMaFhhCpmJiw+Umn4XawWTfTFxrU9L/PB1XhR4z3dKTLO+sasmoJM8BMCBP9FGUhWqFJd+AruoHqaQ5rDuuQHjfnLA6AfGr97VSZxkO5BZU2rVvz0w81WOvbAyC5znmeQQR3tV1Mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZXZDFsRjlDVDZXdG56YjB2MkRwNzRBQkw3c1plT0RTNklUY0w3aWRzUmR0?=
 =?utf-8?B?eUE3MnlpamkwK2JOWnkrSTVyTlNYczl1Zk45YU5DR1JNREcxR3BDQlZhRGc2?=
 =?utf-8?B?S1c1OUJQazVDcFhjOTJGalVvUVRkWFZjL1NsdlkrMW16dFFCWDNrVjdOc2Mz?=
 =?utf-8?B?WmJxc2FqL0FPUTZKMllsWFpZVHM5bW1EczZva3l6TVJUV3BTQ3hEd0wwSzV4?=
 =?utf-8?B?WHRiNDJoa1J1MFBEMHd6UHl0bkVYenhTYWFrOGQrQVRRaDV6MHNVcVBURy9V?=
 =?utf-8?B?eXJGa1JmalpNc01FVkMvZnFaTzdBQ2cxRmlUYS9HQlcycVBMY0d1NWgwR3Jy?=
 =?utf-8?B?aVM1ekJTTVgyV3ptY1hIangrSFE4enVJWnlpL2xTOGQ2K0pMYXhpWkRSdDJG?=
 =?utf-8?B?dlM0UXJzckJtSzYwSDVtd3NOczJiQ2ErU3c3YnFKMHZyMVU5MlIya2QwcHRU?=
 =?utf-8?B?RjVsajJyQmFOSFV1Unc4NnBFN2MwMnNpSWZ3LzUybVRNdDVFenplZDhVejlI?=
 =?utf-8?B?NDJUTHI5UDZDNk1VVUplL2VsRkp2RFNKbVgwQVpuc3RhcGl4YTFuMnZmNkti?=
 =?utf-8?B?dmFzSHNBNSs1ODZqMnM1bzBzTzRuaDd4U2xPU2poY2pZMjdNNGtUYkROdkRt?=
 =?utf-8?B?d3FqNUFnTXRPbzdOOXBqSXFlazVLMXY3U1ZtZWNxWUoxM3ZrUjY2RkVqSnRo?=
 =?utf-8?B?Ynp6WnZHdXNCSTJtSGRVUU1XL3ZGMXgvMGRaaWhMcU1JYXB0VURYN0xEZzNo?=
 =?utf-8?B?TUZIWENDNDRXQ0Y3K1ZBRTN3UjRCbEhkK1VTOU9IODg3akZteEM0LzZtQ0RZ?=
 =?utf-8?B?aTk5eE1OcFFaMlJhSFBkWTQ1ci9nai9TMUg2NXJkQVNoQ3M3ajZ0Vllpei9w?=
 =?utf-8?B?a0U1RlV2cFY0YzZnbHB1L2QzUWFYWklEcW1rVUtyTTZqWjdnVmV5ODgvNjds?=
 =?utf-8?B?cm9hSFExUmF2VFVZdGlSNGFCUHdQOUI5SFJsYzhjeEd4OEl6TjN2MXJKYm42?=
 =?utf-8?B?K1dtTStFUXVLcnp1SjdUSUw0eXY2b2hQOWZ4VWswQitOUi9qbGxtMUVJZDI2?=
 =?utf-8?B?aFRqL1R2RmFaSlBmNmg3d0U2amNVcDQ4K0tFaTI3ZUJTQ2YvYlMxUDluSnlR?=
 =?utf-8?B?dFhMdWtCbDZGZ3QrSm9keUVSR1VSOFNUckpaaWh4bHJQUUtYMzh6d0xuWkFF?=
 =?utf-8?B?SXNkVnZCOEw5dTFXU2RYV09VcGtUaUkrRUp3UjJpWk1zZ2paWW1nTFZnbXFa?=
 =?utf-8?B?cHp4UFlxbm5PYi9xR251MDNLZEFOSkdpSUQyS29GZW0ycmRVSGdNYWJzai8x?=
 =?utf-8?B?aXkxbnVzYWZlL3VoQnZSRUR6eWlnU0xOTFo4dDVDcm5sdlRhZjVyakpuTitl?=
 =?utf-8?B?OGViZmYwaUduMy81c3lqS01kUzdHSm40OXF1RTJYM2l5WG1xMHpLTjg0S3da?=
 =?utf-8?B?TzBkZjM0NzVaT3o4eElSMzQvYm45bklSOUdUMCsvRkdVb2NsVEhTcTFOVklY?=
 =?utf-8?B?M0tOZG85bThOTXZ5YTY0c01kU3VqVk5lejhqcjFiYUgyall6aUxCeWhXVG9k?=
 =?utf-8?B?bE1hOFZlSmttNmRjeW0vdDM0ZGwwZ0E0MGpsOFlWbkNSNG9YTFl1bmYzcFRs?=
 =?utf-8?B?emZZdHVVREh0bS9rbjVsM2ZCV3FHek9hZUJ0UFgrTGEwbi9GRk5iWEFHVTg4?=
 =?utf-8?B?WUVNdDdWSDFDRmhmY2xMQmFrS0VmTGNOVE1CVHJvNE9ubUZqWlY2VGNqWnV2?=
 =?utf-8?B?TVRkMTNPbXo5TkhJL2paV1Bmb1NZNTltYlJZUWZKbXJ0UHRVWTVPbzZ4MjVO?=
 =?utf-8?B?OWFULzBSNTE2bndzZDlZa04yODJhWE5ERDRsa1g0UkpRb3JUbktGZThxbzBC?=
 =?utf-8?B?TVVaSWVIOEJ3WnBDd2FiMlppS0U4WWt0Nzk2R1NmYmhLSjh2RGRYOWZEUHJP?=
 =?utf-8?B?L2ZBTHVvdHQzVlJYbzJyVWpaQUphMGxxQXBvTld4T3N1Z3hhZFpKZ29mVDMx?=
 =?utf-8?B?WmFUbHBYeW1vUWFLTWZvbTkxdzJVOS9DaE1jbmRFM3VURHRIT2doekloR3Rq?=
 =?utf-8?B?OUFWZWp4clorNXNBZWt6Rkh5RStwWGdkcGVHN2hsN3FxbmtsRUJHcG1iK1Az?=
 =?utf-8?B?dHl0MHpOdW9uVWo4MGZLaWtvNmhzcHIrSHVkWGNjNFFTVGg3OFhQT1RNcmM2?=
 =?utf-8?B?R1pURk1LMDZ4ZDhVQzFEVnpIdmxDUWh3bEVwNmdNWlIwWkxCcUZYbitkNW80?=
 =?utf-8?B?MWd3MC9ZNCs0endmUW5FaFVMSHFneDhYMVhtMHRsZFkwRERTVjdxaWZoNzBP?=
 =?utf-8?B?TzNpaS9QRWVtUG9LQ2lUME5sNEpCZHpXKzNWMkltcVdLRWp6ZUdkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b6e8b0-bdbd-45ca-fbd2-08deecda2250
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:57:56.0263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwMthkbNCKe6lxApeMOQiOT1epiyMQpqQoXLXEymde2wcfDeHzBiqz9i4FRoIIyQTx4eIM2c/lgL6C2QfmEkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

--------------78PGE3qLbQ0KfnXJNS0scqm0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-07-27 23:10, Fan, Shikang wrote:
> AMD General
>
> Hi @Kuehling, Felix <mailto:Felix.Kuehling@amd.com>, could you help 
> take a look for other comments that you might have?

I don't have other comments per se. Maybe another idea for saving and 
restoring MQD contents. If allocation during suspend is a problem, you 
could allocate the backup space in system memory during queue creation. 
But using the general eviction mechanism and dealing with changing MQD 
addresses is probably cleaner.

Regards,
   Felix


>
> Regards,
> Shikang
>
>
> ------------------------------------------------------------------------
> *From:* Fan, Shikang <Shikang.Fan@amd.com>
> *Sent:* Wednesday, July 22, 2026 11:22 AM
> *To:* Limonciello, Mario <Mario.Limonciello@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; SHANMUGAM, SRINIVASAN 
> <SRINIVASAN.SHANMUGAM@amd.com>
> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; 
> Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
> hibernation when MQD is in VRAM
>
> AMD General
>
> This is for virtual machine migration feature, especially under the 
> SR-IOV scenario.
>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Sent:* Wednesday, July 22, 2026 5:21 AM
> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Fan, Shikang 
> <Shikang.Fan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; 
> Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
> hibernation when MQD is in VRAM
>
> IIUC you need to go through these flows as part of guest migration 
> (which system goes into S4 to accomplish).
>
>
> On 7/21/26 16:20, Felix Kuehling wrote:
>
>     These are all server GPUs. Is system suspend really a requirement
>     here? Or is this for runtime suspend? But runtime suspend
>     shouldn't kick in while user mode queues exist.
>
>
>     Regards,
>       Felix
>
>
>     On 2026-07-21 03:20, Fan, Shikang wrote:
>
>         AMD General
>
>         +@Zhao, Victor <mailto:Victor.Zhao@amd.com>, @Zhang, Tiantian
>         (Celine) <mailto:Tiantian.Zhang@amd.com>.  And also
>         @Limonciello, Mario <mailto:Mario.Limonciello@amd.com> to help
>         with the review.
>
>         Regards,
>         Shikang
>
>         ------------------------------------------------------------------------
>         *From:* Fan, Shikang <Shikang.Fan@amd.com>
>         <mailto:Shikang.Fan@amd.com>
>         *Sent:* Tuesday, July 21, 2026 11:25 AM
>         *To:* Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         <amd-gfx@lists.freedesktop.org>
>         <mailto:amd-gfx@lists.freedesktop.org>; SHANMUGAM, SRINIVASAN
>         <SRINIVASAN.SHANMUGAM@amd.com>
>         <mailto:SRINIVASAN.SHANMUGAM@amd.com>; Kuehling, Felix
>         <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>
>         *Cc:* Yang, Philip <Philip.Yang@amd.com>
>         <mailto:Philip.Yang@amd.com>; Deucher, Alexander
>         <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>         *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across
>         hibernation when MQD is in VRAM
>
>         AMD General
>
>         +@SHANMUGAM, SRINIVASAN
>         <mailto:SRINIVASAN.SHANMUGAM@amd.com> and @Kuehling, Felix
>         <mailto:Felix.Kuehling@amd.com> to the review discussion as
>         Christian is currently OOO.
>
>         Regards,
>         Shikang
>
>         ------------------------------------------------------------------------
>         *From:* Fan, Shikang <Shikang.Fan@amd.com>
>         <mailto:Shikang.Fan@amd.com>
>         *Sent:* Friday, July 17, 2026 6:25 PM
>         *To:* Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         <amd-gfx@lists.freedesktop.org>
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Cc:* Yang, Philip <Philip.Yang@amd.com>
>         <mailto:Philip.Yang@amd.com>; Deucher, Alexander
>         <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>; Kuehling, Felix
>         <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>
>         *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across
>         hibernation when MQD is in VRAM
>
>         AMD General
>
>
>         I do have a few thoughts on the unpin-repin approach and
>         re-building the MQD from housekeeping information.
>
>         For unpin-repin: the MQD's GPU address may change after it's
>         moved back from GTT, and several places hold the original
>         address, so we'd need to update all of them and be careful not
>         to miss any — but overall it's doable.
>
>         For re-build: the one thing we can't reconstruct is the
>         control stack. It resides in the same BO as the MQD, and the
>         driver doesn't preserve its contents.
>
>         Separately, I'd like to raise a potential pre-existing issue I
>         noticed while writing the patch. mqd_on_vram() covers gfx942,
>         gfx943, gfx944 and gfx950. gfx943/944/950 are all registered
>         with the _v9_4_3 implementations, which call flush_hdp() in
>         init_mqd, update_mqd and restore_mqd. gfx942, however, uses
>         the base MQD functions, which lack the flush_hdp() call.
>
>         Regards,
>         Shikang
>
>         ------------------------------------------------------------------------
>         *From:* Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>
>         *Sent:* Friday, July 17, 2026 4:59 PM
>         *To:* Fan, Shikang <Shikang.Fan@amd.com>
>         <mailto:Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         <amd-gfx@lists.freedesktop.org>
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Cc:* Yang, Philip <Philip.Yang@amd.com>
>         <mailto:Philip.Yang@amd.com>; Deucher, Alexander
>         <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>; Kuehling, Felix
>         <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>
>         *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across
>         hibernation when MQD is in VRAM
>
>         On 7/17/26 10:53, Shikang Fan wrote:
>         > On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a
>         pinned VRAM
>         > BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction
>         and not saved
>         > across S4 hibernation, so the MQD is garbage on resume and
>         the first
>         > submission faults. Save it to a system-RAM shadow at suspend
>         and restore
>         > it on resume, reusing the CRIU checkpoint_mqd/restore_mqd
>         primitives.
>         >
>         > v2:
>         >  - Also snapshot the MQD when a process is already
>         runtime-evicted at
>         >    hibernation start. The qpd->evicted refcount early-return
>         previously
>         >    skipped the save loop, losing the MQD across the VRAM
>         wipe (both the
>         >    cpsch and nocpsch evict paths).
>         >
>         > Signed-off-by: Shikang Fan <shikang.fan@amd.com>
>         <mailto:shikang.fan@amd.com>
>         > ---
>         >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120
>         +++++++++++++++++-
>         >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>         >  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>         >  3 files changed, 129 insertions(+), 2 deletions(-)
>         >
>         > diff --git
>         a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>         b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>         > index 51ee9c39104b..d168686ee324 100644
>         > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>         > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>         > @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct
>         device_queue_manager *dqm);
>         >  static void deallocate_sdma_queue(struct
>         device_queue_manager *dqm,
>         >                                struct queue *q);
>         >
>         > +static int dqm_alloc_mqd_backup(struct device_queue_manager
>         *dqm, struct queue *q);
>         > +static void dqm_save_mqd_backup(struct device_queue_manager
>         *dqm, struct queue *q);
>         > +
>         >  static inline void deallocate_hqd(struct
>         device_queue_manager *dqm,
>         >                                struct queue *q);
>         >  static int allocate_hqd(struct device_queue_manager *dqm,
>         struct queue *q);
>         > @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct
>         device_queue_manager *dqm,
>         >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd,
>         q->mqd_mem_obj,
>         > &q->gart_mqd_addr, &q->properties);
>         >
>         > +     retval = dqm_alloc_mqd_backup(dqm, q);
>         > +     if (retval)
>         > +             goto out_free_mqd;
>         > +
>         >        if (q->properties.is_active) {
>         >                if (!dqm->sched_running) {
>         >                        WARN_ONCE(1, "Load non-HWS mqd while
>         stopped\n");
>         > @@ -1263,8 +1270,16 @@ static int
>         evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>         >        int retval, ret = 0;
>         >
>         >        dqm_lock(dqm);
>         > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
>         > +     if (qpd->evicted++ > 0) { /* already evicted, do
>         nothing */
>         > +             /* A process already runtime-evicted when
>         hibernation starts
>         > +              * skips the save loop below, so snapshot its
>         VRAM MQDs here
>         > +              * before the S4 image is taken.
>         dqm_save_mqd_backup() is a
>         > +              * no-op outside S4.
>         > +              */
>         > +             list_for_each_entry(q, &qpd->queues_list, list)
>         > +                     dqm_save_mqd_backup(dqm, q);
>         >                goto out;
>         > +     }
>         >
>         >        pdd = qpd_to_pdd(qpd);
>         >        pr_debug_ratelimited("Evicting process pid %d queues\n",
>         > @@ -1297,6 +1312,8 @@ static int
>         evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>         >                         * maintain a consistent eviction state
>         >                         */
>         >                        ret = retval;
>         > +
>         > +             dqm_save_mqd_backup(dqm, q);
>         >        }
>         >
>         >  out:
>         > @@ -1304,6 +1321,88 @@ static int
>         evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>         >        return ret;
>         >  }
>         >
>         > +/* MQD software-shadow save/restore across S4 hibernation,
>         reusing the CRIU
>         > + * checkpoint_mqd/restore_mqd primitives.
>         > + */
>         > +static int dqm_alloc_mqd_backup(struct device_queue_manager
>         *dqm, struct queue *q)
>         > +{
>         > +     struct mqd_manager *mqd_mgr;
>         > +     uint32_t mqd_size, ctl_stack_size = 0;
>         > +
>         > +     if (!mqd_on_vram(dqm->dev->adev))
>         > +             return 0;
>         > +     if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
>         > +             return 0;
>         > +     if (!q->mqd)
>         > +             return 0;
>         > +
>         > +     mqd_mgr =
>         dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>         > +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
>         > +             return 0;
>         > +
>         > +     mqd_size = AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
>         > +                NUM_XCC(dqm->dev->xcc_mask);
>         > +     if (mqd_mgr->get_checkpoint_info)
>         > +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd,
>         &ctl_stack_size);
>         > +
>         > +     if (!q->mqd_backup) {
>         > +             q->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
>
>         Please note that you need to be super careful when allocating
>         memory during suspend. The amount available is really limited
>         because both swap and OOM killer are already stopped.
>
>         Instead you should probably consider unpinning on suspend and
>         repinning on resume, for this we have memory put asside.
>
>         Additional to that it could be that backing up the MQD is
>         overkill, we should be able to re-create the MQD after resume
>         from the housekeeping information we still have around.
>
>         Regards,
>         Christian.
>
>
>         > +             if (!q->mqd_backup)
>         > +                     return -ENOMEM;
>         > +             q->mqd_backup_size = mqd_size;
>         > +     }
>         > +     if (ctl_stack_size && !q->ctl_stack_backup) {
>         > +             q->ctl_stack_backup = kzalloc(ctl_stack_size,
>         GFP_KERNEL);
>         > +             if (!q->ctl_stack_backup) {
>         > +                     kfree(q->mqd_backup);
>         > +                     q->mqd_backup = NULL;
>         > +                     q->mqd_backup_size = 0;
>         > +                     return -ENOMEM;
>         > +             }
>         > +             q->ctl_stack_backup_size = ctl_stack_size;
>         > +     }
>         > +
>         > +     return 0;
>         > +}
>         > +
>         > +static void dqm_save_mqd_backup(struct device_queue_manager
>         *dqm, struct queue *q)
>         > +{
>         > +     struct mqd_manager *mqd_mgr;
>         > +
>         > +     /* in_s4 is reliably set at evict/suspend time; skip
>         normal runtime eviction
>         > +      * (pinned VRAM MQD stays intact then).
>         > +      */
>         > +     if (!dqm->dev->adev->in_s4)
>         > +             return;
>         > +     if (!q->mqd_backup)
>         > +             return;
>         > +     if (!q->mqd || !q->mqd_mem_obj ||
>         !q->mqd_mem_obj->cpu_ptr)
>         > +             return;
>         > +
>         > +     mqd_mgr =
>         dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>         > +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd,
>         q->mqd_backup, q->ctl_stack_backup);
>         > +     q->mqd_backup_valid = true;
>         > +}
>         > +
>         > +static void dqm_restore_mqd_backup(struct
>         device_queue_manager *dqm, struct queue *q)
>         > +{
>         > +     struct mqd_manager *mqd_mgr;
>         > +
>         > +     if (!q->mqd_backup_valid || !q->mqd_backup)
>         > +             return;
>         > +     if (!q->mqd_mem_obj)
>         > +             return;
>         > +
>         > +     mqd_mgr =
>         dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>         > +     if (!mqd_mgr->restore_mqd)
>         > +             return;
>         > +
>         > +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>         &q->gart_mqd_addr,
>         > +                          &q->properties, q->mqd_backup,
>         q->ctl_stack_backup,
>         > + q->ctl_stack_backup_size);
>         > +     q->mqd_backup_valid = false;
>         > +}
>         > +
>         >  static int evict_process_queues_cpsch(struct
>         device_queue_manager *dqm,
>         >                                      struct
>         qcm_process_device *qpd)
>         >  {
>         > @@ -1313,8 +1412,16 @@ static int
>         evict_process_queues_cpsch(struct device_queue_manager *dqm,
>         >        int retval = 0;
>         >
>         >        dqm_lock(dqm);
>         > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
>         > +     if (qpd->evicted++ > 0) { /* already evicted, do
>         nothing */
>         > +             /* A process already runtime-evicted when
>         hibernation starts
>         > +              * skips the save loop below, so snapshot its
>         VRAM MQDs here
>         > +              * before the S4 image is taken.
>         dqm_save_mqd_backup() is a
>         > +              * no-op outside S4.
>         > +              */
>         > +             list_for_each_entry(q, &qpd->queues_list, list)
>         > +                     dqm_save_mqd_backup(dqm, q);
>         >                goto out;
>         > +     }
>         >
>         >        pdd = qpd_to_pdd(qpd);
>         >
>         > @@ -1350,6 +1457,8 @@ static int
>         evict_process_queues_cpsch(struct device_queue_manager *dqm,
>         >                                goto out;
>         >                        }
>         >                }
>         > +
>         > +             dqm_save_mqd_backup(dqm, q);
>         >        }
>         >
>         >        if (!dqm->dev->kfd->shared_resources.enable_mes) {
>         > @@ -1423,6 +1532,7 @@ static int
>         restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>         >
>         >                mqd_mgr =
>         dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>         >                                q->properties.type)];
>         > +             dqm_restore_mqd_backup(dqm, q);
>         >                q->properties.is_active = true;
>         >                increment_queue_count(dqm, qpd, q);
>         >
>         > @@ -1486,6 +1596,7 @@ static int
>         restore_process_queues_cpsch(struct device_queue_manager *dqm,
>         >                if (!QUEUE_IS_ACTIVE(q->properties))
>         >                        continue;
>         >
>         > +             dqm_restore_mqd_backup(dqm, q);
>
>         Those are the wrong point to call those functions if I'm not
>         completely mistaken.
>
>         Regards,
>         Christian.
>
>         >                q->properties.is_active = true;
>         >                increment_queue_count(dqm, &pdd->qpd, q);
>         >
>         > @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct
>         device_queue_manager *dqm, struct queue *q,
>         >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd,
>         q->mqd_mem_obj,
>         > &q->gart_mqd_addr, &q->properties);
>         >
>         > +     retval = dqm_alloc_mqd_backup(dqm, q);
>         > +     if (retval)
>         > +             goto out_free_mqd;
>         > +
>         >        list_add(&q->list, &qpd->queues_list);
>         >        qpd->queue_count++;
>         >
>         > @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct
>         device_queue_manager *dqm, struct queue *q,
>         >        list_del(&q->list);
>         >        if (q->properties.is_active)
>         >                decrement_queue_count(dqm, qpd, q);
>         > +out_free_mqd:
>         >        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>         >        dqm_unlock(dqm);
>         >  out_deallocate_doorbell:
>         > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>         > index 88191a4c1657..1f728f13813e 100644
>         > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>         > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>         > @@ -637,6 +637,15 @@ struct queue {
>         >        void *gang_ctx_cpu_ptr;
>         >
>         >        struct amdgpu_bo *wptr_bo_gart;
>         > +
>         > +     /* system-RAM shadow of a VRAM-resident MQD (+ control
>         stack)
>         > +      * for hibernation snapshot/restore
>         > +      */
>         > +     void *mqd_backup;
>         > +     void *ctl_stack_backup;
>         > +     uint32_t mqd_backup_size;
>         > +     uint32_t ctl_stack_backup_size;
>         > +     bool mqd_backup_valid;
>         >  };
>         >
>         >  enum KFD_MQD_TYPE {
>         > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>         b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>         > index 98a5512b701b..cbc90bf87792 100644
>         > --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>         > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>         > @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const
>         struct queue_properties *properties)
>         >
>         >  void uninit_queue(struct queue *q)
>         >  {
>         > +     kfree(q->mqd_backup);
>         > +     kfree(q->ctl_stack_backup);
>         >        kfree(q);
>         >  }
>         >
>
--------------78PGE3qLbQ0KfnXJNS0scqm0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-07-27 23:10, Fan, Shikang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB73434AC08F3012E7445E23CEEBCB2@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">@scope { P {margin-top:0;margin-bottom:0;} }</style>
      <div>
        <div style="font-family: Calibri; text-align: left; margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Hi <a href="mailto:Felix.Kuehling@amd.com" id="OWAAM448351" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">
          @Kuehling, Felix</a>, could you help take a look for other
        comments that you might have?</div>
    </blockquote>
    <p>I don't have other comments per se. Maybe another idea for saving
      and restoring MQD contents. If allocation during suspend is a
      problem, you could allocate the backup space in system memory
      during queue creation. But using the general eviction mechanism
      and dealing with changing MQD addresses is probably cleaner.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:SA1PR12MB73434AC08F3012E7445E23CEEBCB2@SA1PR12MB7343.namprd12.prod.outlook.com">
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Regards,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Shikang</div>
      <div><br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <hr style="display: inline-block; width: 98%;">
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <b>From:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
        <b>Sent:</b> Wednesday, July 22, 2026 11:22 AM<br>
        <b>To:</b> Limonciello, Mario <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>;
        Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Koenig,
        Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN
        <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a><br>
        <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Deucher,
        Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhao, Victor
        <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>; Zhang, Tiantian (Celine)
        <a class="moz-txt-link-rfc2396E" href="mailto:Tiantian.Zhang@amd.com">&lt;Tiantian.Zhang@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
        across hibernation when MQD is in VRAM
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt;">
        AMD General</div>
      <div style="direction: ltr;"><br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        This is for virtual machine migration feature, especially under
        the SR-IOV scenario.</div>
      <div style="direction: ltr;"><br>
      </div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        Regards,</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        Shikang</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <hr style="direction: ltr; display: inline-block; width: 98%;">
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <b>From:</b> Limonciello, Mario
        <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a><br>
        <b>Sent:</b> Wednesday, July 22, 2026 5:21 AM<br>
        <b>To:</b> Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Fan,
        Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>; Koenig, Christian
        <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN
        <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a><br>
        <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Deucher,
        Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhao, Victor
        <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>; Zhang, Tiantian (Celine)
        <a class="moz-txt-link-rfc2396E" href="mailto:Tiantian.Zhang@amd.com">&lt;Tiantian.Zhang@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
        across hibernation when MQD is in VRAM</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;">IIUC
        you need to go through these flows as part of guest migration
        (which system goes into S4 to accomplish).</p>
      <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
      </p>
      <div style="direction: ltr;">On 7/21/26 16:20, Felix Kuehling
        wrote:</div>
      <blockquote>
        <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;">These
          are all server GPUs. Is system suspend really a requirement
          here? Or is this for runtime suspend? But runtime suspend
          shouldn't kick in while user mode queues exist.</p>
        <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
        </p>
        <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;">Regards,<br>
          &nbsp; Felix</p>
        <p style="direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
        </p>
        <div style="direction: ltr;">On 2026-07-21 03:20, Fan, Shikang
          wrote:</div>
        <blockquote>
          <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt;">
            AMD General</div>
          <div style="direction: ltr;"><br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            +<a href="mailto:Victor.Zhao@amd.com" id="OWAAM420325" class="x_x_tWKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b" moz-do-not-send="true">@Zhao, Victor</a>,
            <a href="mailto:Tiantian.Zhang@amd.com" id="OWAAM394558" class="x_x_tWKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b" moz-do-not-send="true">
              @Zhang, Tiantian (Celine)</a>. &nbsp;And also <a href="mailto:Mario.Limonciello@amd.com" id="OWAAM671300" class="x_x_tWKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b" moz-do-not-send="true">
              @Limonciello, Mario</a>&nbsp;to help with the review.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Regards,</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Shikang</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <hr style="direction: ltr; display: inline-block; width: 98%;">
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <b>From:</b> Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" id="OWA02b22b33-39af-f641-8648-b333c5f75014" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Shikang.Fan@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
            <b>To:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" id="OWAe98c7c1f-11d8-1c6d-cfdf-72f2a1fa0716" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Christian.Koenig@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWA9f4b9188-3db2-6b12-083c-90441030da3c" class="x_x_moz-txt-link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink moz-txt-link-freetext" moz-do-not-send="true">
              amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWA9a64c66b-e05d-a83f-21de-2be9900f4c41" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM,
            SRINIVASAN <a href="mailto:SRINIVASAN.SHANMUGAM@amd.com" id="OWAcf7bb245-3281-1470-d92a-7a46272cb222" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>; Kuehling, Felix
            <a href="mailto:Felix.Kuehling@amd.com" id="OWAbe061beb-654e-04cf-047c-dd09e2f4d429" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Cc:</b> Yang, Philip <a href="mailto:Philip.Yang@amd.com" id="OWAde201da7-3c81-a9f6-9b50-47a59298822b" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" id="OWAecce1e0e-2f09-f717-632d-4a2801086d10" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
            across hibernation when MQD is in VRAM</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt;">
            AMD General</div>
          <div style="direction: ltr;"><br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            +<a href="mailto:SRINIVASAN.SHANMUGAM@amd.com" id="OWAAM517752" class="x_x_x_tWKOu x_x_x_mention x_x_x_ms-bgc-nlr x_x_x_ms-fcl-b" moz-do-not-send="true">@SHANMUGAM, SRINIVASAN</a>&nbsp;and
            <a href="mailto:Felix.Kuehling@amd.com" id="OWAAM431627" class="x_x_x_tWKOu x_x_x_mention x_x_x_ms-bgc-nlr x_x_x_ms-fcl-b" moz-do-not-send="true">
              @Kuehling, Felix</a>&nbsp;to the review discussion as Christian
            is currently OOO.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Regards,</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Shikang</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <hr style="direction: ltr; display: inline-block; width: 98%;">
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <b>From:</b> Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" id="OWAd1f60d95-10b2-018a-dd15-494d2468ebf1" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Shikang.Fan@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
            <b>To:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" id="OWA1a67261d-6af0-18f3-5ed4-f12fe5e5f0ef" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Christian.Koenig@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWAcdb990bf-abc1-3b1f-3394-9bbbba72aa80" class="x_x_moz-txt-link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink moz-txt-link-freetext" moz-do-not-send="true">
              amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWA74e78773-7123-ef66-ceda-b9f7411af9e5" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Yang, Philip <a href="mailto:Philip.Yang@amd.com" id="OWA124f7a4f-5760-12bb-9630-69bbb007e61f" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" id="OWAaa86e3bd-1596-914a-da56-488abec8020d" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" id="OWA37866c81-bcd9-9a8f-4154-12b69efbb4ac" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
            across hibernation when MQD is in VRAM</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt;">
            AMD General</div>
          <div style="direction: ltr;"><br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            I do have a few thoughts on the unpin-repin approach and
            re-building the MQD from housekeeping information.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            For unpin-repin: the MQD's GPU address may change after it's
            moved back from GTT, and several places hold the original
            address, so we'd need to update all of them and be careful
            not to miss any — but overall it's doable.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            For re-build: the one thing we can't reconstruct is the
            control stack. It resides in the same BO as the MQD, and the
            driver doesn't preserve its contents.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Separately, I'd like to raise a potential pre-existing issue
            I noticed while writing the patch. mqd_on_vram() covers
            gfx942, gfx943, gfx944 and gfx950. gfx943/944/950 are all
            registered with the _v9_4_3 implementations, which call
            flush_hdp() in init_mqd, update_mqd and restore_mqd. gfx942,
            however, uses the base MQD functions, which lack the
            flush_hdp() call.</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            <br>
          </div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Regards,</div>
          <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
            Shikang</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <hr style="direction: ltr; display: inline-block; width: 98%;">
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <b>From:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" id="OWA516eb1aa-2a55-b38f-6558-7c2ce3dac644" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
            <b>To:</b> Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" id="OWAe393f983-6307-ce41-1f62-3715da437c32" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Shikang.Fan@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWAd567c281-c89f-42a0-d202-aafa6bf0615c" class="x_x_moz-txt-link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink moz-txt-link-freetext" moz-do-not-send="true">
              amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" id="OWAeb0aabba-c230-7b6f-cb3e-0978ea3f3aa5" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Yang, Philip <a href="mailto:Philip.Yang@amd.com" id="OWAd77b7cd7-d81c-2b0b-cb9c-ae80bb48462e" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" id="OWA77fe07d2-2502-fec3-9953-3aacef051c44" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" id="OWA2becc8d5-ec55-bbfc-5fda-f8033ba48876" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
            across hibernation when MQD is in VRAM</div>
          <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <div style="direction: ltr; font-size: 11pt;">On 7/17/26
            10:53, Shikang Fan wrote:<br>
            &gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live
            in a pinned VRAM<br>
            &gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM
            eviction and not saved<br>
            &gt; across S4 hibernation, so the MQD is garbage on resume
            and the first<br>
            &gt; submission faults. Save it to a system-RAM shadow at
            suspend and restore<br>
            &gt; it on resume, reusing the CRIU
            checkpoint_mqd/restore_mqd primitives.<br>
            &gt;<br>
            &gt; v2:<br>
            &gt;&nbsp; - Also snapshot the MQD when a process is already
            runtime-evicted at<br>
            &gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount
            early-return previously<br>
            &gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the
            VRAM wipe (both the<br>
            &gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
            &gt;<br>
            &gt; Signed-off-by: Shikang Fan <a href="mailto:shikang.fan@amd.com" id="OWAb3f8330c-185c-df7d-bebb-b5e1016115ba" class="x_x_moz-txt-link-rfc2396E x_OWAAutoLink" moz-do-not-send="true">
              &lt;shikang.fan@amd.com&gt;</a><br>
            &gt; ---<br>
            &gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120
            +++++++++++++++++-<br>
            &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
            &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
            &gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
            &gt;<br>
            &gt; diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
            &gt; index 51ee9c39104b..d168686ee324 100644<br>
            &gt; ---
            a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
            &gt; +++
            b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
            &gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct
            device_queue_manager *dqm);<br>
            &gt;&nbsp; static void deallocate_sdma_queue(struct
            device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
            &gt;&nbsp;<br>
            &gt; +static int dqm_alloc_mqd_backup(struct
            device_queue_manager *dqm, struct queue *q);<br>
            &gt; +static void dqm_save_mqd_backup(struct
            device_queue_manager *dqm, struct queue *q);<br>
            &gt; +<br>
            &gt;&nbsp; static inline void deallocate_hqd(struct
            device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
            &gt;&nbsp; static int allocate_hqd(struct device_queue_manager
            *dqm, struct queue *q);<br>
            &gt; @@ -802,6 +805,10 @@ static int
            create_queue_nocpsch(struct device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
            &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
            &gt;&nbsp;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
            &gt; +<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active) {<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1, &quot;Load non-HWS mqd
            while stopped\n&quot;);<br>
            &gt; @@ -1263,8 +1270,16 @@ static int
            evict_process_queues_nocpsch(struct device_queue_manager
            *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret = 0;<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
            &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted,
            do nothing */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already
            evicted, do nothing */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
            hibernation starts<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot
            its VRAM MQDs here<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
            dqm_save_mqd_backup() is a<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
            &amp;qpd-&gt;queues_list, list)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;Evicting process pid %d
            queues\n&quot;,<br>
            &gt; @@ -1297,6 +1312,8 @@ static int
            evict_process_queues_nocpsch(struct device_queue_manager
            *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * maintain a consistent
            eviction state<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = retval;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;<br>
            &gt;&nbsp; out:<br>
            &gt; @@ -1304,6 +1321,88 @@ static int
            evict_process_queues_nocpsch(struct device_queue_manager
            *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
            &gt;&nbsp; }<br>
            &gt;&nbsp;<br>
            &gt; +/* MQD software-shadow save/restore across S4
            hibernation, reusing the CRIU<br>
            &gt; + * checkpoint_mqd/restore_mqd primitives.<br>
            &gt; + */<br>
            &gt; +static int dqm_alloc_mqd_backup(struct
            device_queue_manager *dqm, struct queue *q)<br>
            &gt; +{<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size = 0;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=
            KFD_QUEUE_TYPE_COMPUTE)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
            dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd ||
            !mqd_mgr-&gt;restore_mqd)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =
            AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&gt;mqd_size) *<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr,
            q-&gt;mqd, &amp;ctl_stack_size);<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = kzalloc(mqd_size,
            GFP_KERNEL);<br>
            <br>
            Please note that you need to be super careful when
            allocating memory during suspend. The amount available is
            really limited because both swap and OOM killer are already
            stopped.<br>
            <br>
            Instead you should probably consider unpinning on suspend
            and repinning on resume, for this we have memory put asside.<br>
            <br>
            Additional to that it could be that backing up the MQD is
            overkill, we should be able to re-create the MQD after
            resume from the housekeeping information we still have
            around.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = mqd_size;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp;
            !q-&gt;ctl_stack_backup) {<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup =
            kzalloc(ctl_stack_size, GFP_KERNEL);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;ctl_stack_backup) {<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = NULL;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = 0;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size =
            ctl_stack_size;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +static void dqm_save_mqd_backup(struct
            device_queue_manager *dqm, struct queue *q)<br>
            &gt; +{<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend time;
            skip normal runtime eviction<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj ||
            !q-&gt;mqd_mem_obj-&gt;cpu_ptr)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
            dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mqd,
            q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = true;<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +static void dqm_restore_mqd_backup(struct
            device_queue_manager *dqm, struct queue *q)<br>
            &gt; +{<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_backup)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
            dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;mqd,
            q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;properties,
            q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            q-&gt;ctl_stack_backup_size);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = false;<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;&nbsp; static int evict_process_queues_cpsch(struct
            device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            qcm_process_device *qpd)<br>
            &gt;&nbsp; {<br>
            &gt; @@ -1313,8 +1412,16 @@ static int
            evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval = 0;<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
            &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted,
            do nothing */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already
            evicted, do nothing */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
            hibernation starts<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot
            its VRAM MQDs here<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
            dqm_save_mqd_backup() is a<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
            &amp;qpd-&gt;queues_list, list)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
            &gt;&nbsp;<br>
            &gt; @@ -1350,6 +1457,8 @@ static int
            evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {<br>
            &gt; @@ -1423,6 +1532,7 @@ static int
            restore_process_queues_nocpsch(struct device_queue_manager
            *dqm,<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
            dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
            &gt;&nbsp;<br>
            &gt; @@ -1486,6 +1596,7 @@ static int
            restore_process_queues_cpsch(struct device_queue_manager
            *dqm,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
            &gt;&nbsp;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
            <br>
            Those are the wrong point to call those functions if I'm not
            completely mistaken.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm,
            &amp;pdd-&gt;qpd, q);<br>
            &gt;&nbsp;<br>
            &gt; @@ -2161,6 +2272,10 @@ static int
            create_queue_cpsch(struct device_queue_manager *dqm, struct
            queue *q,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
            &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
            &gt;&nbsp;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
            &gt; +<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list,
            &amp;qpd-&gt;queues_list);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
            &gt;&nbsp;<br>
            &gt; @@ -2193,6 +2308,7 @@ static int
            create_queue_cpsch(struct device_queue_manager *dqm, struct
            queue *q,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active)<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
            &gt; +out_free_mqd:<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd,
            q-&gt;mqd_mem_obj);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
            &gt;&nbsp; out_deallocate_doorbell:<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
            b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
            &gt; index 88191a4c1657..1f728f13813e 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
            &gt; @@ -637,6 +637,15 @@ struct queue {<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
            &gt;&nbsp;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_gart;<br>
            &gt; +<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD (+
            control stack)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
            &gt;&nbsp; };<br>
            &gt;&nbsp;<br>
            &gt;&nbsp; enum KFD_MQD_TYPE {<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
            &gt; index 98a5512b701b..cbc90bf87792 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
            &gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q,
            const struct queue_properties *properties)<br>
            &gt;&nbsp;<br>
            &gt;&nbsp; void uninit_queue(struct queue *q)<br>
            &gt;&nbsp; {<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
            &gt;&nbsp; }<br>
            &gt;&nbsp;<br>
            <br>
          </div>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------78PGE3qLbQ0KfnXJNS0scqm0--
