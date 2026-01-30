Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41FBD73EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7925E10E904;
	Fri, 30 Jan 2026 05:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EuAqNJJu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4183610E904
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4/qSPt1lJfNgdZnYDSfpJA/1RGub0rVBePEIYpNPBf4x0M/d1Rbt6LVjGA5h/oUORTY/MyBeO8LetYtZqEnyaqvWfT7rXCpMdwldNCgnkx5xxX9RGW1JM+xVYrCA6gt4cjcc5GB4rtJIWXwa1kcIM5tOh2DIt8zwWVGJmKjF9L2ce7tMeELe/ADKOWAdZKwW6Ts6lBT1kcQErnrpzdXRgpzhcGTkzZl7BFl2HnRm0nYi3thx3Giucw7cs29l+b+UQwG8S6DtivJt4NnJRZnlaKBwhGLvz5/tihNzyjCfb3xEpl1y29R25urXSwvYnDAs/91MWzOBgwqb12fvE+WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsyjqtcTvPMQOZFMiM19LBLgTl3PFF/h9CWs1zXD6is=;
 b=MEGLxC1EgZC+7WrYo9AAO6ElF6QbAOEEPEU36rJ/0o2rNPoKup5zClusmjgO826/t3Zo1Daa0BSNv/EGCzn9ezxvmN86CL2HeQ9kEv+s7zbW+uHM0+VCorq/MlI0vr+zGSB8hlUPSXwyQ/12nlcq53ncoJz9LzefaiZJRRYB0EHbhgS1aeh5t20ZlgQJFJfbdZsqpmcDvkaqml8vm3Ox32iAwK5HlnPVU3iF6KxgeCSgyhhYbXl9dk3D8XEzC8nR7n/GsX8rG5uyaa4DP4mAPxnk1Bl2iQs7SCccM6xHeMIrC4iUVuoql/PKyafjkmQ2gibHHCqj321Gd3pqUB7NeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsyjqtcTvPMQOZFMiM19LBLgTl3PFF/h9CWs1zXD6is=;
 b=EuAqNJJuN6siUuNrqZH4UNGpqbIAcC4nSyMPDbweZu6ilj7de7XDrbUh9FnkGOdkoeDWgZgIyUNkstDv5fihndRWE4aYuZrj/34ZOA14Yzs6foCKTX8Qm1OQhISQr2buKXVa/uTySXol2pPOyD0x6y1uAY1EDVjQh7A3hsIIekg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 05:57:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:57:13 +0000
Message-ID: <b055be7b-cb19-4b9b-a3eb-ee79dbbac740@amd.com>
Date: Fri, 30 Jan 2026 11:27:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-10-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-10-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0074.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a1f5cb-b486-47f1-505b-08de5fc46a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?andLR2FZSERNM3hUQldRVit2V2JkeEgrMGJmYjdVNmFISDZyNFRTMmJRQko2?=
 =?utf-8?B?Nk0xdjdQV1dHc1MrMVJxSEhJZERyVUZMSWt0dk9WK2NWYTQ5czdaWTFyczFr?=
 =?utf-8?B?ZVorZmtwZlBUZHROUUxKWmtYS2lETC8vcjVOOEllL3o3Q29xMGpKRU9SMndp?=
 =?utf-8?B?Rm5ZUllyR2ZBcHJ0ZXRjUkRWbVN0RkdvUFNtQndNenE2YzJnNitBR1lpRGNl?=
 =?utf-8?B?alg1b1pXcmI5REwybUdBWWxSZmthRlVyK3ZOKzNac1lUMkJjbG0zS2d4Slp4?=
 =?utf-8?B?UklFSTFpYTlTeGoweDQxNFFHZFpSZ0xDNUNzeTZiNkNyc2NMd0dJUWo0M3Jv?=
 =?utf-8?B?WWtGekZnMU9UK0tWQ05UWVJJOE1sMWhRZkNmaW1sWHNjTHEvRXlPemxZeWt0?=
 =?utf-8?B?dng4eUZ3YnRnZ0NwVFB6bzFvL2M1U1hkTXhxYWgybkVYcGV4WGFaSlJvc3ds?=
 =?utf-8?B?QUNpYXRURERIemNXYXdUMS9NYXllYjBBbmVkeVoybG01d2RIbXBwMnZTY0dq?=
 =?utf-8?B?YkFvZ2dhMzZSK0lucy83anFyU0wxZjB1eHYrVkdnYnhUQ3R5a0oxd1M3MTUy?=
 =?utf-8?B?VkNRcWJqY25jOWQ2bFFWN0xRNC9RUkV1NlFic0VINUwrT3c3MVFuTzR4T3Zo?=
 =?utf-8?B?VUdKZ2tQTzRDZjZNelZsNzM4a29uZTIrb002eEphL1U1eEdlamdIeXRoTlpF?=
 =?utf-8?B?M2h0dlQxbTU0TStEdi93Tnl0R2dZWmdMNW9IUldUQlBqcEZJUDNuNXBqL2Rj?=
 =?utf-8?B?TE01UlJnZUpUTWlpU2xET05icUF6UUdMU25oQlRDMUJhVHkyenUxakZvVGNl?=
 =?utf-8?B?QkhYaGIyV3A4MkxXSStrODhMN3lCd2l2TUVjS2p3M09DSklZbHZvbTM0ZW5w?=
 =?utf-8?B?TzY5QTJtd2szTDdrdERoRDFSblpaYU9YV0phUmJTc1I5aHlFMEtSNFdwRVNw?=
 =?utf-8?B?bS9YQlF1V3FmUUZLN1dmM3U3bFRkcDI0ZlZ5TFE1TTdZeW5LNGlkQW9WUE91?=
 =?utf-8?B?MTBuaWlWZTFjVkpGQWhQdUwwQWJLTGNZT1FCWDV2SHVabEZRcUs0ZFRxZWRU?=
 =?utf-8?B?bytqYXNDV2lzMnF2eHdGTjA3Ukc1QzJFTVlqV2x1eWhqZDRkbk5DYUFIaXZu?=
 =?utf-8?B?ODdvck1MRmNzemIveENETnlpbEZZaVNlaVU0N2xEWGNpV0I5Vytna09JNGs2?=
 =?utf-8?B?ckg1ZGJETG9FbTc2dVBpUFJ4ejU3NGFEMzdhMXpIV1dQLzZRa2VCbG9kRnRC?=
 =?utf-8?B?d0NKWmxRcnFScS9xdU5hcGl3dy9qYW0zOEkvd2s0VU5uSGFMZTVvRVA2c3g5?=
 =?utf-8?B?OUxvN3VXN2hJM0FKSi91VjBjeGV1TWc1NHdJRXluV1Y5RHZIUzVHMUNVcHov?=
 =?utf-8?B?YWIxNkRoSzVKZ1JZNkcrWlR6OU5wMVdsNGhhN2dGeVA0eWkzSktXaWM1ZXcz?=
 =?utf-8?B?RVJwcDFiMlBZaWQ2a1VSYUNZbHhFVk92MjNZYkJ4V1FiRkhpVzUvL1IzMVAz?=
 =?utf-8?B?Ymthc3F2akNrcHFUTnpQVmJMUkowOUQ0cVhHSisyQXNvYVNUU2FZWGt2UVRB?=
 =?utf-8?B?TER6WTBPaytsdVZEM3JXc1p2dEl2NGpBTmdxTkw0dW5uNm4xN2dVRytrSUoy?=
 =?utf-8?B?SlpBRHJld1VUSDdLTlBqVFpsVEtoaXlKc2hudkU3NVpURlFWWjhxNXk3OW9T?=
 =?utf-8?B?MGRPcUtlZjNNMFRRdWNiTlhsNTViYkliYVNCRGJYcFVIZ0dYTXdQZm5xYkx3?=
 =?utf-8?B?ekx5TEFZWHZwNXF3VUE0eEVDT01TK1c5REpwZVhCdUswS0ZQcmN5RjVBU0U3?=
 =?utf-8?B?Mk96ZjUyOUJCSFJjS0tsWVhpL0t3U29JamNmaXRReS85RXNCS2lwc1dwOVFw?=
 =?utf-8?B?WHViUnNacElwWnNTelhMRUFKSUlLWEQ5N2FSb2ZoT1NDNjhnZlZkVjQxMlN5?=
 =?utf-8?B?ZVRnMVN6MEpOL1ZHY3ZWamZSUFE2T1NXTzIvZ2JxOWxaeWNRL2QzNitIRjdS?=
 =?utf-8?B?c0llTGJ3YXlWZUhDL295S0RPYmNGbWsxNUhwY1NVcm1uMzdyL3RDcXdxbE9y?=
 =?utf-8?B?VXpQTm9IOWFFRUxMdEZPSkNlQ2JWRXEzOU0rcGlyWFNCTy9yK2dNZ3RlbkhL?=
 =?utf-8?Q?lKAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2gvY28xdW5BZ0J0MXdNT1gxVzlWME8vdWhMVEY3OFJiMXQ3Rzd4SHpYdDZr?=
 =?utf-8?B?YmlGZHFoZUVKUXFWV2F2aXZTZ01OTHR6QTJwMjhOVVVtMjBhanhVL1ppeGgx?=
 =?utf-8?B?NGl0MUh1enExQTYvck51NEwrMHZONkNmZEFRamJLNlZ6c3lHeXIxbDNQU09X?=
 =?utf-8?B?VWhnYUdFOTNlTFY3dGhkNXpLWkpRYlpZdllYM3U0RGZvQVZKUzZvVzBBQW9v?=
 =?utf-8?B?T3UvNlF5K0dXT1lhQkZyOXBnZ1Nxd29DdGtMcGtzcitocW5hSFAyYnN3eTAw?=
 =?utf-8?B?L1J4TC9zeTkxUzRvNHlRYjRFVkxxaVBZTDRRZnJTL0hMQUkraC9XWWEwQW95?=
 =?utf-8?B?ekQrUllTNW1zRXdseTMrRFR1TFZKTFcvUXkrenNWTS82Vk0wbXd4VjdBUTQy?=
 =?utf-8?B?dTBQenJnZVdTcU9jc0wyYjdGOFlTM2FYa0d3SngxaVRxbENzeWRkNk5oOFNw?=
 =?utf-8?B?algwWExPeGJSajJPYXlneUp6SXdwaTRJS3lpSHdLS21PenRKUFgyZHNwUXAx?=
 =?utf-8?B?VWIyZUlQSVhLN0NiSXRHMlRqcWc5dGswK2I4Q2g3Z1NhRWZPajA2ck1jTENq?=
 =?utf-8?B?MmZpSEhzTDJNZDdTQVd2R3gzVnJtNTd4R0grbEZ5bzZ2V3NxL2JVRjAzZE8r?=
 =?utf-8?B?TmJyaW9uOWNXMXZ4aUFUbW1Deno2aFlFY3VuQkZBZmUvUXY0RGhwWnFwZEo5?=
 =?utf-8?B?SEJNemhHMmdxUmVTaUdqam1CSGQvVEpGOWtEQUtkM3R3UCtkQ2hjYm14QVFU?=
 =?utf-8?B?NUl3S0VUNEtqbEVaK0dVKzIrTG9Pd0tFNW02U3dtZm1uS1pMc2M5WkdGMk9W?=
 =?utf-8?B?MU56YUQrOWhFS1dHRDNWZ0IyNERQQmh0VlV3SFUzT3poOWtsZkcyako0RjJ5?=
 =?utf-8?B?ZlVkZ3RndFRxRU5ubUdRUFMxN2NWaWRzTGM3U3QxRC9QZ0ltSWs1T3pnQVRG?=
 =?utf-8?B?VDQ1bUlueXpiWkRLbUMxTjhmL1VUS3k5VStMbUpIM3grV1NIcXF1S0NzVHQ2?=
 =?utf-8?B?UWxFQVFpL0kxTmxnRHo0SmU0NlBkYXNkSE9BVUhnS3B6K0QwMlo5djRUUEhU?=
 =?utf-8?B?ck13bmorZi80SEE4c0kyRVN6WldPUzBkWXlMbXN4ejBycGh0cnpSVWU0ZTcr?=
 =?utf-8?B?UWdLbFBnSnpwc3c0dGNFRGtLeGp0TWZVcXIvUHBLZnRYdTE3ZE91Q2NOZXBn?=
 =?utf-8?B?WWpFZE5UMWRTTitFbEc3STJua2pZUkg1d2s1L3RJbGNEampYdW5YZlZjSG5u?=
 =?utf-8?B?ZnB0ZDJGdzBOQ0NUU1huS1Y5TDdYZXk0aW5aRkQrN2pzanRRbVlQd01LNnR6?=
 =?utf-8?B?QVV2TnhLT0tIU1hQZWRCdzBLRWdjMUdZQ2lKbi9yNnZBRkFickNtTlEyTHVJ?=
 =?utf-8?B?N25xUWJkbHM5MVliRFpHTDF4RUZLOUFlb1p5MGgzanZCZXJTQ0ZZRktxRVRs?=
 =?utf-8?B?bCt1N1ptWk1UQlRTS3RHNndOeHlCb2VyK0tVc3pWci96Z2NiT0NYeGNlcGVD?=
 =?utf-8?B?Yll2VUZqOFdIc3hMUWtBWTBWaTlpRWFqRnUrQThPOVFqNWw3TVduUWVZbTBS?=
 =?utf-8?B?UUg0cHBtOVFEbWxTa3Z5d3lJQ08vUnVMZDhrU1VxcW5SRTVWRjkxMC9Nb0Rn?=
 =?utf-8?B?aUNobHVVZmF6eEhoakNUUFJhdmVnZVFxUG5scFd3WkdwdDljbzN5K0lMSnZD?=
 =?utf-8?B?WjNacy9pVXhybVNxakJreUt6aWQ0N3c3eWtMZDBVejNuZzJacFVCUkkyaXZx?=
 =?utf-8?B?TlFGVXl5RkV4R3ZLbGZ3cFB2ODc5Y3ZmQ0hGTFZRbVZ2NW93SFBXYmE1T2VY?=
 =?utf-8?B?THRjTk4vRHI3QlRYTW5Uc3kwZ3dQZHA1WW5ScTIyT3NGdlJKZWYvWGVzUlRJ?=
 =?utf-8?B?N0xHMWxOdWhVTGRCaURYdTFXMjhvZmVxb3BjN3dBaUxYQ2F3OFFpUVZoem51?=
 =?utf-8?B?TVV6QjBJbkZEakZOOENBZUd2bTRGWXhFUkVmc0oyRkhpOTAyc2N1UTBzL0tI?=
 =?utf-8?B?R3NjZTl5amF1TlhKTG1qV3dmM3MxcHhDRVM5ODk2cVlsZmwwOWhNcGFJa2dT?=
 =?utf-8?B?eStwdm85ZFdaazZGQUZmVzNLMS80SUdZTzR2ZWtoUzZCTlRvKzFZZlM4cjJE?=
 =?utf-8?B?RmxaRjFzT3Z6MVlvQ0llR1dIZkdjQXVIMVI3Y2FiUVdTaitXQmx3bHVaVWFw?=
 =?utf-8?B?WXVQVFZhYXNKSVhBRzlFWXZuQnA3TzJuN1FRQWNseG13RTRVenhGYmdqK0dr?=
 =?utf-8?B?UWhOQmdSZTg0QlBCRGRueGN6a2V4N0xkV3A5eUl4NjlUcm1neWtJTTh0Y1dH?=
 =?utf-8?B?Y2lGZmYzcS9GWVg4LzI3NlZZT1pGaEJLT0hJaVdQU0k4Wm4wVFV1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a1f5cb-b486-47f1-505b-08de5fc46a14
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:57:13.4815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylQTSPhWyEMAuawdTeC0j3cx4/yVwNxrT/KSfPynTBU7Aa/ulPEH/Dc69KeN+pxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add read func for pmfw eeprom, and adapt address converting
> for bad pages loaded from pmfw eeprom
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
>   drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 70 +++++++++++++++++++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  5 ++
>   drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 27 +++++--
>   .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  2 +-
>   6 files changed, 101 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index ae10d853c565..05c7923e8f0f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -241,6 +241,7 @@ struct ras_bank_ecc {
>   	uint64_t status;
>   	uint64_t ipid;
>   	uint64_t addr;
> +	uint64_t ts;
>   };
>   
>   struct ras_bank_ecc_node {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 1f2ce3749d43..fe188a5304d9 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -239,7 +239,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
>   	int count;
>   	int ret;
>   
> -	count = ras_eeprom_get_record_count(ras_core);
> +	if (ras_fw_eeprom_supported(ras_core))
> +		count = ras_fw_eeprom_get_record_count(ras_core);

As mentioned in earlier patches, suggestion is to keep just

ras_eeprom_get_record_count.

With ras_eeprom, you may decide the access mechanism and fork to 
different paths. That looks cleaner and all common variables can be kept 
inside ras_eeprom itself.


> +	else
> +		count = ras_eeprom_get_record_count(ras_core);
>   	if (!count)
>   		return 0;
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index 580dd7b09d00..79494ad16ee5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -259,3 +259,73 @@ int ras_fw_eeprom_append(struct ras_core_context *ras_core,
>   	mutex_unlock(&control->ras_tbl_mutex);
>   	return 0;
>   }
> +
> +int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
> +			 struct eeprom_umc_record *record_umc,
> +			 struct ras_bank_ecc *ras_ecc,
> +			 u32 rec_idx, const u32 num)
> +{
> +	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
> +	int i, ret, end_idx;
> +	u64 mca, ipid, ts;
> +
> +	if (!ras_core->ras_umc.ip_func ||
> +	    !ras_core->ras_umc.ip_func->mca_ipid_parse)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&control->ras_tbl_mutex);
> +
> +	end_idx = rec_idx + num;
> +	for (i = rec_idx; i < end_idx; i++) {
> +		ret = ras_fw_get_badpage_mca_addr(ras_core, i, &mca);
> +		if (ret)
> +			goto out;
> +
> +		ret = ras_fw_get_badpage_ipid(ras_core, i, &ipid);
> +		if (ret)
> +			goto out;
> +
> +		ret = ras_fw_get_timestamp(ras_core, i, &ts);
> +		if (ret)
> +			goto out;
> +
> +		if (record_umc) {
> +			record_umc[i - rec_idx].address = mca;
> +			/* retired_page (pa) is unused now */
> +			record_umc[i - rec_idx].retired_row_pfn = 0x1ULL;
> +			record_umc[i - rec_idx].ts = ts;
> +			record_umc[i - rec_idx].err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
> +
> +			ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core, ipid,
> +				(uint32_t *)&(record_umc[i - rec_idx].cu),
> +				(uint32_t *)&(record_umc[i - rec_idx].mem_channel),
> +				(uint32_t *)&(record_umc[i - rec_idx].mcumc_id), NULL);
> +
> +			/* update bad channel bitmap */
> +			if ((record_umc[i - rec_idx].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
> +				!(control->bad_channel_bitmap & (1 << record_umc[i - rec_idx].mem_channel))) {
> +				control->bad_channel_bitmap |= 1 << record_umc[i - rec_idx].mem_channel;
> +				control->update_channel_flag = true;
> +			}
> +		}
> +
> +		if (ras_ecc) {
> +			ras_ecc[i - rec_idx].addr = mca;
> +			ras_ecc[i - rec_idx].ipid = ipid;
> +			ras_ecc[i - rec_idx].ts = ts;
> +		}
> +
> +	}
> +
> +out:
> +	mutex_unlock(&control->ras_tbl_mutex);
> +	return ret;
> +}
> +
> +uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
> +{
> +	if (!ras_core)
> +		return 0;
> +
> +	return ras_core->ras_fw_eeprom.ras_num_recs;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index b94d3c9703e3..353977a2371e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -70,5 +70,10 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
>   bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
>   int ras_fw_eeprom_append(struct ras_core_context *ras_core,
>   			   struct eeprom_umc_record *record, const u32 num);
> +int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
> +			 struct eeprom_umc_record *record_umc,
> +			 struct ras_bank_ecc *ras_ecc,
> +			 u32 rec_idx, const u32 num);
> +uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index fd427fd59ecf..eb5bb6df18f5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -436,17 +436,27 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
>   	uint32_t ras_num_recs;
>   	int ret;
>   
> -	ras_num_recs = ras_eeprom_get_record_count(ras_core);
> -	/* no bad page record, skip eeprom access */
> -	if (!ras_num_recs ||
> -	    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
> -		return 0;
> +	if (ras_fw_eeprom_supported(ras_core)) {
> +		ras_num_recs = ras_fw_eeprom_get_record_count(ras_core);
> +		/* no bad page record, skip eeprom access */
> +		if (!ras_num_recs ||
> +		    ras_core->ras_fw_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
> +			return 0;
> +	} else {
> +		ras_num_recs = ras_eeprom_get_record_count(ras_core);
> +		if (!ras_num_recs ||
> +		    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)

This is an example where common variables/logic get repeated.

Thanks,
Lijo

> +			return 0;
> +	}
>   
>   	bps = kcalloc(ras_num_recs, sizeof(*bps), GFP_KERNEL);
>   	if (!bps)
>   		return -ENOMEM;
>   
> -	ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
> +	if (ras_fw_eeprom_supported(ras_core))
> +		ret = ras_fw_eeprom_read_idx(ras_core, bps, 0, 0, ras_num_recs);
> +	else
> +		ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
>   	if (ret) {
>   		RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table records!");
>   	} else {
> @@ -474,7 +484,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
>   	if (!data->bps)
>   		return 0;
>   
> -	eeprom_record_num = ras_eeprom_get_record_count(ras_core);
> +	if (ras_fw_eeprom_supported(ras_core))
> +		eeprom_record_num = ras_fw_eeprom_get_record_count(ras_core);
> +	else
> +		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
>   	mutex_lock(&ras_umc->umc_lock);
>   	save_count = data->count - eeprom_record_num;
>   	/* only new entries are saved */
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> index e2792b239bea..53dc59e4de0c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> @@ -413,7 +413,7 @@ static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_co
>   	uint64_t pa = 0;
>   	int ret = 0;
>   
> -	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
> +	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record) && !ras_fw_eeprom_supported(ras_core)) {
>   		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
>   	} else {
>   		ret = convert_eeprom_record_to_nps_addr(ras_core,

