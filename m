Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03481CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9829F10E66B;
	Tue, 26 Aug 2025 14:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bOTuMkYw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F9310E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3k1jF9nGGur40JzrsbQC/B14yi8mhbkq7ilBOvR6Pd6FsI2wJI5aIETD3jKrZayEr9sWmRr5SHlhDyZBz7wu80YZnkpbu5HIzmdj2kvYvJnCxh3zKq1/LuPYePIMS4q8BMEBRcxjhhI1ZKdVWvRsGIIixQVyLppRV3P+hBmr3xCfJeXbi4vrBLWrIymdG/VR/FgtzvRX5OAjMi4Sun5gtgU6qBdNWWPXiIYAV/BNjuy1KEeilE4AE/SyWlO03GfTfQpEOBjMOWQDSW2h+D5oykBlq/ydyRKSi+WR0A0w4+YqrbseFrgcwry9LYKUd2i4K8U8xAqMxpCdyAXdvzdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDioM+RVWpHAPOOb9tpoVRFwcVZtQvr/ByN8LRTNuUk=;
 b=NHqEnAj9acnn+cD+1qUhAR2UxzxH34/VRNkoKWi9VDZKi5j8q77gwcUyT5CYiKqZwVGkQDNUSr97Smj4dTp9Z/FiilKXuhkXyeEKfW9d/fKt3zuBVp+7m6+PrMscqPPz8s0p/LTmxf6bX38eiKVq7299hzmHIVea8tBroWuPpSzQH+naJNCep44usCXwlKHzZYQEr7xS7UJcv5iEl3NuhZB0Nl0DNRwxwToJasExUhsrgwfkF5BBiSNXgzMFW7QZlGpKNy+7+mkx3v7osRDmwU9pH9tpCWPLW3p+f16qCVnqib03pNGnC2+pCI/qy1mo1s/OPUQyLzLip0YS04HmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDioM+RVWpHAPOOb9tpoVRFwcVZtQvr/ByN8LRTNuUk=;
 b=bOTuMkYw/iYCM+VvSGkHTmNJotvk/g1KuMt6ZUfet8iVE1k8ML+pJTQ5Ko2C3v2E8n885h82bQld7WJkj9a1patu1eE1yM/UZqxXN6lf9pcmnME7psnOCnT7BA/rqF4mPV6ACTQBEBdOxOhySJ2fPkqimGbtlLzB1r/5y0Vmpgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 14:25:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:25:54 +0000
Message-ID: <27326edc-d9b5-4a3d-9c03-ce91603f2815@amd.com>
Date: Tue, 26 Aug 2025 16:25:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/4] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 simona@ffwll.ch, mripard@kernel.org, tzimmermann@suse.de
References: <20250825194936.899825-1-David.Francis@amd.com>
 <20250825194936.899825-4-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250825194936.899825-4-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1349ab-644a-4b53-1a6c-08dde4ac771c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1A4dlZCbTR2V0ZPSWwwMTkyUzdlRG9NVkpWRC80MEMrM21aVjJyTlVwQ3JS?=
 =?utf-8?B?dXNNRDgxSkFFQmh0Nno2S1BDMll3K3U1dW1TcGc3aktPVVFTZTNLVnRkUnJ1?=
 =?utf-8?B?bFZSWG1qSzhKMDhhT2lrTGpzOEV5S3pOczBVZWFDK0U2L3pGaDZ2VTRrUWNa?=
 =?utf-8?B?aDhISFVCektrOFdaRHBpdkUxQUFUMGlZdmxzSEJEc2hNL1FUWWZaRyttM2ZV?=
 =?utf-8?B?V25ndnlseXk3ZG9kQ2VKN2JrdWhCdm9ST2kzSXg4d1ZoenlwYW9zUlMxYjlt?=
 =?utf-8?B?NTd0K3FOaVFNZUJIUW9GNjVCZ2k2MG93TkduajZJNXJLandRNWU1WTl3eDZ1?=
 =?utf-8?B?RnNieVZocUtBY3dGZ3d4MGdHckFScnJuUktNaGdoQXhEYmJZMlczUWw5cXVL?=
 =?utf-8?B?Tnc4dHpqcnUyQSs1TjlzeC8xVjF4RkdJRVZ6Sk5CVzRyV205N2ZwUkF6YzhD?=
 =?utf-8?B?YkZNV3RoUUJHSHZpU2w4eGk4WUphNzJLUTVYWmVxbXpUOFZ3TlNodlV2a2dy?=
 =?utf-8?B?TzI0RkIxbjRjQTIvcSsxQldMZjU0c0ptdHplVURMcDluWHFESFlsNmI0OUcv?=
 =?utf-8?B?cmswV1NXZ3UrcjVlMUg1RzBGQkpDNzVSMXdJb3N6S1dHM3lnOEpkTE9yWTI2?=
 =?utf-8?B?eGltZVRCZmwzWnpuQitXdmdvemNFRW5GaU43bnYzUmlnQjlpY3JSeldoM0dG?=
 =?utf-8?B?WU1nQ1d6anBnYUNHY0pkYVloREJqNkRvaTI3algvRmN5TE9lcnlyV1BIWGJs?=
 =?utf-8?B?Qk1UV253OXIraGphT3N0Ulp3K3Z5RndyTURtRHl6SHVReVpwM1V6dlhXdVhD?=
 =?utf-8?B?Y3NoUXNjbk5ZRUx6NlVudERsOWZMSUxNdzR3Ui93aUFZOE5ZTi9xQ3lIZE1q?=
 =?utf-8?B?MUJ3WFR1RXdKNzRpY3NqZHoyNlIramgrdWVPTG5FUDV3cDBMaUltbEZCR1F5?=
 =?utf-8?B?dUxEdWVaMVFxVWhKeHJWUUR4TFQ0akx1YkxOMG5CaVlKRW1FZ3dMcXZyWTJM?=
 =?utf-8?B?OUgrWEY5VlBnN3BpU1BPOHExOWVCa0F0Wk0yMkxNYzByR1dHNWNwSDNPOTBw?=
 =?utf-8?B?WjNOMkdsd1FwK0ppMGNFNHVUL1ZvYXhIdWNFZTJwM2xpSXJ3YUtPbEZtaG5M?=
 =?utf-8?B?NmtXaFFYNVZUd29CWjZ5SVdXa1JKaGZ6dkhuSzJLc1VjY1JHNmdYUjZ2R0E3?=
 =?utf-8?B?ZEJYK1lqTFZCMFpaRXIzdTdpVmo5eDZ0MlhvaVNkblo1RThvVUREeGkxVFkr?=
 =?utf-8?B?Nk9RVnFYM1ZGd25obytBM3NXSVZ0SmxOL0FDVFFWazM1VHA0RDVOdmRGeVkz?=
 =?utf-8?B?dTErM1U4N091dkdUUzZjZDk3c0huUXlTSk9IejFzQlNKaXJhT0VNcDZMM0xn?=
 =?utf-8?B?WHI1eE1JTVpNR2lxcjM0TnpuMERRNGQrTVdLNkpYTHpmMElKUkhRMEtoY0hY?=
 =?utf-8?B?RC9JYlJaY1h6K2Z1N3o4TkovdGhidERkTUloSklHVE5vaGlBY0Ewa29IdW9P?=
 =?utf-8?B?U0NiVjEyV1Avam1HRkQzR3JOUEZ0R3p3dUd2SlVicUtXbVpMMkxycXZVUnNl?=
 =?utf-8?B?T3hOQysrb3BLdldaQmR3ZkVZMVBIZ0JlblFxUThOM0NkTE9idVZtQVZEejFV?=
 =?utf-8?B?WDJMMEhOSTcraGNDWUF0bzM2N0lBS2l6anlFK0lQZUxhaGtjUVUwRnhqeXVB?=
 =?utf-8?B?U1FTUS9uSGI5QjZSZmVQS21VMlFiYWtaLzA5a0lSM2pHNzkxbGNFWTJJMnZn?=
 =?utf-8?B?dytMMnVsU1RtbFdWa1FKT1NIbUNuZzVEcXR6dVB6RHFuWnFxQktiemZwVHh5?=
 =?utf-8?B?NXJRMStJMERCOHpzQjJKUGVLMmJXTDhTSlVRV0dOS3paamY0cEVPSjlxTXpK?=
 =?utf-8?B?NWE1T3ZGRXdQUkVVREdWa2R0QnRIcURUUDY2bFhNYTJndnZvQ0o1elpkL1gv?=
 =?utf-8?Q?oRipj+sxQiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9pNzU3U09ORGI0K2JnNXNpYWltLzNWVzVCNWRPUjdSdWdnNjc3bE00Q1kw?=
 =?utf-8?B?OGVnYVNsYVJtNkQ1YmRzVFllaGpEUEVPSkcvamNQOEVyTGtJdTRqN1VoVWZN?=
 =?utf-8?B?eWdVRG5abEZZcTNyaVRvQUo4bkZvZXpFVWNKWklQTEZONktGKzBMaTI3bHhz?=
 =?utf-8?B?TzlpSDlseDUzMzJYSCthS3BlYTg2ODQveE5tb2h5ZGJTT1k0NGlsMGpPZXJn?=
 =?utf-8?B?cWUxODl6bE5NS1NVU3QzYXY2NGIydHFEaDl1RXdSaXZaOENDNmJyQ3RCanlK?=
 =?utf-8?B?RjZtK3JjRFNRQzBncXZuL0gySDh3NU8wUFhWVCsvWnhMWXhDNHB2dTl3SUM1?=
 =?utf-8?B?VWtVakZJNkpNb28yYStsak91aFh1ZE5mUC9xZ0t5WTN3VlJhVjRibjYycldq?=
 =?utf-8?B?akJTeFFoUHhJcW94M2Ntb2lMWDlZakFTVkVvb0tPNHJDb1owV1ZVZmp5Lzlp?=
 =?utf-8?B?Q3V2ZUV0eFJTRWFOcGJLRUZNV3EvNzJMVHhOZGRWZ1l5aUlXMXlmTHgyK1RU?=
 =?utf-8?B?OUwwaWR3U1R2dkx4YlRnZlZxVVpkUnFPdHlPU0xjdi9kb1hGUUVkdEc1RkFy?=
 =?utf-8?B?YytDZUNXdHRkOGhzTUJNT2ZPZHdYQWcvL2N5RVBHZ0M1WTdoRzhEODAzRGkx?=
 =?utf-8?B?Mi9WUUF6ZFRVdXhMMXkybmxpQmxJQWNuY3VsdUlXUGZ3NGpTa0wvZzhQNjBS?=
 =?utf-8?B?dk4zVlpFQXpNWTluWkhnbGpHT3dDdG9TeGFJZ3g0Wis3NkdWNHhQcncvMDFu?=
 =?utf-8?B?djV2dlZCL0NhVTUwOTErS0lzZ3BoTkNUOHNYNEtuZWowcTZrZnZvT0wxb0RG?=
 =?utf-8?B?ZFN4cnd1Si9MWDhUeElFT2NTdkJxWGxIQlZvSmFqSnh4WUR0bE55Y3BkTzJk?=
 =?utf-8?B?Vk9HUUxmL2FrY0thOGV4em0zSlNRTlJhTHl2WE9TMHlMYlJxNVA0M0NJMnRz?=
 =?utf-8?B?eU9lRDhRVFgzMGNESzVBM2NDUTRLNEV0RjEvc0ZlVWxYSEVMNklmUUlMVHMz?=
 =?utf-8?B?YjBZa2pMaTVTZmk3NzVhc0NiYUpJSDJuakQxSGMvN1JWU1RhaVlnYVhzbHVG?=
 =?utf-8?B?cFdPRlhUZ08vWjZRRDczNEExbEx6dTF0dk51Z0xKaTU4Z0VkRllqcWI3VkVn?=
 =?utf-8?B?WTc2dXVNK25TZFV5ZWlLOXA2dGgrOVR3Nkp5alZIbEw0bUJiQThKb0tUR0dj?=
 =?utf-8?B?L0hPQTVzVk1qSXU3VVUrVXVUd3dsbDVzcERUSVV5MjhqdWF6dzNsWWQ5aEd3?=
 =?utf-8?B?RHFBb2hEYVVLRnUyY2pzV1lFTDNYeXNYWFR4aUxmaXE2N1ZrN0R0UzBoSVZR?=
 =?utf-8?B?QlRwTEFUOGd2WjBkSTBjMURxalg2NGRwWVE4dzZpZU1sY1ovUkRZa2orWGJ6?=
 =?utf-8?B?Z1VYMUNaTHBsMmhmVllIM1NWbGh4a1ZVb3F1U0hGQ0ZSWkR6YlhQeW9TbFRz?=
 =?utf-8?B?Zkh3T25WT2ZobFhxalBJNFJBa3ZjOHp3UFhKYlhKc1ZuQTNkRk01dzZ4RzRW?=
 =?utf-8?B?aGdYMGYxUEdXaHJWMmpKeWRJNzEyYkZIQzVFM01pZ1M5VlZEUm9CbEdOTE9N?=
 =?utf-8?B?cHNucXFsZ1NweExNUlRsTGRMSWZwQWQwNG9wbzZhV284Z3JEVmp1OFUrS1lX?=
 =?utf-8?B?Ykk2TFdRSjNCRXNYYnpEL3pYNk9BMm9TZFZKTW9TT3Zyb2lqRjRpVjlYNW5G?=
 =?utf-8?B?UHhTR2xORktQenZ4dUkxS2xUNzJUMWlRblZWWkdMMi8vb3JXL3IvaFZWTjFo?=
 =?utf-8?B?UWtjcHowalpSZ3J1MTdseXpKb3BSWGRmTkNuWEhpZWsvcFAzQzlkZGhYUTJn?=
 =?utf-8?B?Rk5BSE1TNHZhR05mYUpaMDVMSFgzV2RVU3lBbEdtcGF2VXJBMlhrTmc4YzlE?=
 =?utf-8?B?cytvV2k5REJkbFU4V3puWk1WTTFkS1dRVk5zaSttdEhIYnVnTitDMDc0K2dh?=
 =?utf-8?B?UzBrUmg1dDlQd1hxanl4QWx4Ui91ak5TNGpoV3ZzcnZiOFBZOVZlaWFVOU8r?=
 =?utf-8?B?NzRhZDNSdkhXaEVPUW1qajB4Mm5TMXZFNm1lVEZEeVpHMEUxaTI0V1NkNGRE?=
 =?utf-8?B?WVBxVUtyU0dTelgyYXpNVkZqaXYxQTUzVzFSOFB5MElGeUcycXFqY2QwWnA1?=
 =?utf-8?Q?Fu0o81yp2UWDiThWw2rOxwA6V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1349ab-644a-4b53-1a6c-08dde4ac771c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:25:54.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y13MxU/NUaISInxlEr6Omn/7RHg5+tG73cdYWi4uhedr0Q+4LxqHe+pHT00Z+r6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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



On 25.08.25 21:49, David Francis wrote:
> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
> returns a list of mappings associated with a given bo, along with
> their positions and offsets.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 84 ++++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>  include/uapi/drm/amdgpu_drm.h           | 21 ++++++-
>  3 files changed, 100 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e6741d6c9a55..86d14f3542e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -955,17 +955,34 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_vm_bo_base *base;
>  	struct amdgpu_bo *robj;
> +	struct drm_exec exec;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	int r;
>  
> +	if (args->padding)
> +		return -EINVAL;
> +
>  	gobj = drm_gem_object_lookup(filp, args->handle);
>  	if (!gobj)
>  		return -ENOENT;
>  
>  	robj = gem_to_amdgpu_bo(gobj);
>  
> -	r = amdgpu_bo_reserve(robj, false);
> -	if (unlikely(r))
> -		goto out;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +			  DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_lock_obj(&exec, gobj);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto out_exec;
> +
> +		if (args->op == AMDGPU_GEM_OP_GET_MAPPING_INFO) {
> +			r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> +			drm_exec_retry_on_contention(&exec);
> +			if (r)
> +				goto out_exec;
> +		}
> +	}
>  
>  	switch (args->op) {
>  	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
> @@ -976,7 +993,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  		info.alignment = robj->tbo.page_alignment << PAGE_SHIFT;
>  		info.domains = robj->preferred_domains;
>  		info.domain_flags = robj->flags;
> -		amdgpu_bo_unreserve(robj);
> +		drm_exec_fini(&exec);
>  		if (copy_to_user(out, &info, sizeof(info)))
>  			r = -EFAULT;
>  		break;
> @@ -985,19 +1002,19 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  		if (drm_gem_is_imported(&robj->tbo.base) &&
>  		    args->value & AMDGPU_GEM_DOMAIN_VRAM) {
>  			r = -EINVAL;

> -			amdgpu_bo_unreserve(robj);
> +			drm_exec_fini(&exec);
>  			break;

That should probably be replaced with a "goto out_exec;"


>  		}
>  		if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm)) {
>  			r = -EPERM;

> -			amdgpu_bo_unreserve(robj);
> +			drm_exec_fini(&exec);
>  			break;

Same here.

>  		}
>  		for (base = robj->vm_bo; base; base = base->next)
>  			if (amdgpu_xgmi_same_hive(amdgpu_ttm_adev(robj->tbo.bdev),
>  				amdgpu_ttm_adev(base->vm->root.bo->tbo.bdev))) {
>  				r = -EINVAL;

> -				amdgpu_bo_unreserve(robj);
> +				drm_exec_fini(&exec);
>  				goto out;

And here.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  			}
>  
> @@ -1011,17 +1028,66 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
>  			amdgpu_vm_bo_invalidate(robj, true);
> +		drm_exec_fini(&exec);
> +		break;
> +	case AMDGPU_GEM_OP_GET_MAPPING_INFO: {
> +		struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(&fpriv->vm, robj);
> +		struct drm_amdgpu_gem_vm_entry *vm_entries;
> +		struct amdgpu_bo_va_mapping *mapping;
> +		int num_mappings = 0;
> +		/*
> +		 * num_entries is set as an input to the size of the user-allocated array of
> +		 * drm_amdgpu_gem_vm_entry stored at args->value.
> +		 * num_entries is sent back as output as the number of mappings the bo has.
> +		 * If that number is larger than the size of the array, the ioctl must
> +		 * be retried.
> +		 */
> +		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
> +		if (!vm_entries)
> +			return -ENOMEM;
> +
> +		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
> +			if (num_mappings < args->num_entries) {
> +				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].offset = mapping->offset;
> +				vm_entries[num_mappings].flags = mapping->flags;
> +			}
> +			num_mappings += 1;
> +		}
> +
> +		amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
> +			if (num_mappings < args->num_entries) {
> +				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].offset = mapping->offset;
> +				vm_entries[num_mappings].flags = mapping->flags;
> +			}
> +			num_mappings += 1;
> +		}
>  
> -		amdgpu_bo_unreserve(robj);
> +		drm_exec_fini(&exec);
> +
> +		if (num_mappings > 0 && num_mappings <= args->num_entries)
> +			r = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
> +
> +		args->num_entries = num_mappings;
> +
> +		kvfree(vm_entries);
>  		break;
> +	}
>  	default:
> -		amdgpu_bo_unreserve(robj);
> +		drm_exec_fini(&exec);
>  		r = -EINVAL;
>  	}
>  
>  out:
>  	drm_gem_object_put(gobj);
>  	return r;
> +out_exec:
> +	drm_exec_fini(&exec);
> +	drm_gem_object_put(gobj);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..5a63ae490b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>  				 struct amdgpu_vm *vm,
>  				 struct dma_fence **fence);
>  
> +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->valids, list)
> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->invalids, list)
> +
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 902e30263fcc..9cebd072a042 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>  
>  #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>  #define AMDGPU_GEM_OP_SET_PLACEMENT		1
> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +
> +struct drm_amdgpu_gem_vm_entry {
> +	/* Start of mapping (in bytes) */
> +	__u64 addr;
> +
> +	/* Size of mapping (in bytes) */
> +	__u64 size;
> +
> +	/* Mapping offset */
> +	__u64 offset;
> +
> +	/* flags needed to recreate mapping */
> +	__u64 flags;
> +};
>  
>  /* Sets or returns a value associated with a buffer. */
>  struct drm_amdgpu_gem_op {
> @@ -809,8 +824,12 @@ struct drm_amdgpu_gem_op {
>  	__u32	handle;
>  	/** AMDGPU_GEM_OP_* */
>  	__u32	op;
> -	/** Input or return value */
> +	/** Input or return value. For MAPPING_INFO op: pointer to array of struct drm_amdgpu_gem_vm_entry */
>  	__u64	value;
> +	/** For MAPPING_INFO op: number of mappings (in/out) */
> +	__u32	num_entries;
> +
> +	__u32	padding;
>  };
>  
>  #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)

