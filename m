Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB872C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 07:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7901E10E4EA;
	Fri,  8 Aug 2025 07:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fy3p/O+I";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A3710E4EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 07:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSRCeqB7FQlmnIQxtnaIhSpUL0sNF5HlYg3VwNuDX4qBFQAQDX2wnDVC5+I+CmRWB5lwqCx6v7xYNUyEE8gA9hbOvQ4eGnNHPHWebIARoS8Q2vqERwX7MosUdkUPycmQQEJ84QslVkAmIiKVOPbG6+MPvRSUdoBuGmvEhrbcg1Stx4jmWAT0Zxl7Gzg1WyEjHH9Ifg8fZBu+9GkGTGQUBBYCukvv9ELP43FTqyzwfafYgmeJ/PZsDNeibHzy9RfhENVv9whjWHy1pAoGKgud903ABq9XFaiW6WwHSZayg3JdzbZUC8gJHf8uuv8F6Gv4eKN/axCsxye960yOuJg3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D/bfJUJDbXlMXXckOGKPEtl5rzFcOm/+lgoR4pQ+kc=;
 b=UTCKLTVoVRewWr7ceKeYfACllOl+jzaxnTB0ibfeHm2mAC4esogMIUHuVj2yL5f6cKFOuv7i5uTw2qDiAXwH7pHXLXHNbp6IwW8ZUPlxwU7DV+tnnBEZEwFPrE0oiW5RdbPPwR1vYBAqoqmu4X+Ztoo4LAh/4LPxUDvXJ89lAkAyLlU2TS8A3emt+SyDKFeU96lELJUi4WYlZX3aRhwnPn3yfgVlweNNx9Pv9pvwOymb8OViswCSVL4qhQqBC+/DRW1fagOOvaH0hbC7QcCJZ1KvSzN8r/gTyK3oFL/z0USoDX2cjiIbTBiikOUFUTKo1h36nZn8LjOPsEOMrDFUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D/bfJUJDbXlMXXckOGKPEtl5rzFcOm/+lgoR4pQ+kc=;
 b=fy3p/O+IeiZ4e1Zl1obqaWYha7QJ2NoW4dRlPzjo02iqgW0C7H17N3jAtMTxs1T96/yY8aqMNYMHUSXJl5M/edAvrAAx9HwJvc0W8ffvd3Z+Y//kbOXLIhF6cUCQvRasGNeezJN4ugH/Mi/v7VTSx5l2VBr/pH4PycgkRwxVAzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:48:32 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:48:32 +0000
Content-Type: multipart/alternative;
 boundary="------------SLtCd90Gb8j7RMqHjf8PlAoS"
Message-ID: <aa295f02-8afb-4290-8a0b-20c428bcfc0f@amd.com>
Date: Fri, 8 Aug 2025 15:48:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] amdkfd: process pointer of a HIQ should be set
 to NULL
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-11-lingshan.zhu@amd.com>
 <c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com>
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b022e5f-8067-478a-8f96-08ddd64ff8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGwzY2hMVGtFeU9SdlN2Nm9MelVVTFZUNXpYQVFROG5Od2dIMGtNNDdKZDBR?=
 =?utf-8?B?VnJKdi9aYzRMTEF6cHVtM2w2RGZyeEhLVGFkb2Z2Tk5Pb2dIbWMvcEJsQlh0?=
 =?utf-8?B?M3pUbm9XVzVsOVM5ejNadDV5bUdHK0FvZ1ZEem9XbjYxSDQxMGNadURtUVZD?=
 =?utf-8?B?N3gxM1hCZ04xU0tqeitFMkxCbzhIaE4vNElqaW5IQUtzWUJ6K3o3ay9nUGQ2?=
 =?utf-8?B?UGlDdGwvMzlNYXdEM2xkVFZ1UTUrZmFEakYwRm1NcEtvOTBWR3MvaGpucHhH?=
 =?utf-8?B?WmdWeFRxTHV1YTNuWW9KS1picnE0aE1qaC81djRkMElDcDBsc0hISVFPdkZD?=
 =?utf-8?B?Ylh5S05pTkpmek1LMG1pZFJCMzhRbng0T1BXZWVEbE05UXMrWVJhYmJtVVhy?=
 =?utf-8?B?cGdJbnkxNDZMdEorSjR0bWx2VlZCeExKKzNWcm1oM24ydlBRbHhQZnFHcUYy?=
 =?utf-8?B?Rnlpdy9yR0NCMEtsMDRNWFFNTDY0MWM5amNDSE84YUxQMzkvS21zYlB6UFVS?=
 =?utf-8?B?eElQSmcvWUNZUWpkLzJOQUZjQ08vMVhFV25KeGNMNHV1SFZlWFRYRjNNOWNk?=
 =?utf-8?B?b01YZERrQlEyYStmNWtYNm95OFNWaWM1NEFTVmtGOGh4UWQwWW8xVGFPSnZv?=
 =?utf-8?B?ZWh1TG9Fblo4NG9UbWtKT29IMkVhcXpJODdaQjZxY0tRbmhHYkY3Z0I5MVhp?=
 =?utf-8?B?NjVtdTBZU3JvNG90MUN0emFoV25PYjJMS3RncWR4cDkvQmVWcW1FTGhYSGFj?=
 =?utf-8?B?cW5xekkvUWN6bkxoOStlNjZIMjVRTzhvaFBWSHkrY21HKzNGT2R1L01QL3Bj?=
 =?utf-8?B?Yy91YU02K3FLVi85aDdqN1cvRzJBQk4zOXBZY05ucFZxejlLc0NSVUVJa29E?=
 =?utf-8?B?WktpNE14WWJlR2MxMVFCUS9lRHBDNkRqYVZmY2U0ZFVGTUFmWDBJdmUwZjNQ?=
 =?utf-8?B?WUErOGNIRENNbCtjc0JtdEM0aEV4RmRZWUZKQkJ4NEtZOERnTEp2akNEbTdl?=
 =?utf-8?B?WUdhc0NQZUZEazR6VlNDeTc0T21DNW9NNWFpRjRTeHF2bVJuUWR5eDF3MU85?=
 =?utf-8?B?b3VCSlQxWmgvdG1uKzBqR0xlenFUc0EyQWU4YWQ4Vlp3Zk1jd3lpVG92M2g5?=
 =?utf-8?B?dUtLTVpLc212Ykw5Y3E3TWFQM2Q2UUsybVN4TlVYcjZZanUzYVZFMVRhSXFB?=
 =?utf-8?B?WDE5eEN0MzFBSWRLWlJ3Vnh1LzZpRnVaU3o3Q2pkZEZUNE41dndPdGc0SkZ6?=
 =?utf-8?B?c0VGR1Q1V1JEbnpUUmR5UnJoeE9DckwrekZaYTNvcVVqY1hmRWVVYktkK3Qv?=
 =?utf-8?B?WE01WU9HVnA2Q3FuRktRUUxMUDl5N0dYbVBXem8wVlRTNUhRaExIem0rWDRL?=
 =?utf-8?B?RnJTbDRFd2hXYUE3S3prR1NpY2ZpcWh1ZDJHejhIVmhxT2JRMWpzaVVsZllH?=
 =?utf-8?B?U2tZWnJSZWhQV3QrT1RDWmtaa0VJNjRObFgwNW84SDF5cEdjY2lvYVV1QVZy?=
 =?utf-8?B?SHEwaFJEMVlFSHdWWTQ5ejJqeTcxVkxhQk5zWXVOS3lDcGtKOVpZWFFQdUxI?=
 =?utf-8?B?WTB0V3B5N1BLNW9Pb3FYbWlOejg5b2liYUE2ekhkZmFWWmI4TDlDVyszZmtN?=
 =?utf-8?B?VlFxTjNjZFVHNEtySFpVZGlvZFNjNzNKQnd6ZUFiYzhZaEZ0YnJNWThaSFdl?=
 =?utf-8?B?S1FiZjgrUVMvaEJQcWpWTDNzYjBMUTlaZmlxZ3Z3UmVIS2YzUlJoY1U3VS9T?=
 =?utf-8?B?aVo4M01IRGlBa0xIempsUytBdDltMThpNnl5RE1NN0kzV0l6c3VrN0trd1d3?=
 =?utf-8?B?RTVDNlZKZE5SNXRreHJHMkNjOWlxRzNaVVZXZEQzckJUR3JBRjA1Qkh4MFdK?=
 =?utf-8?B?UVMrUEcrMmJVRDltK1d4RHdibXhqRWUwd3cvcXAvTW45VGwxZzBwWlVXNUZi?=
 =?utf-8?Q?779kmnWNFBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU43MXFJZkVDK3lWb0dCSVFOc1FoQUszK2ozbmphNW1zYU5MeHo0aFEyb3dZ?=
 =?utf-8?B?UzcrcktyUk0vd21INDNtQU9rTEU4NkwvRGhBSW5saUF0RWZZdzFsSkVRN0Fl?=
 =?utf-8?B?UnQzNUQxejljSDB2QWxqRWREZmIvb1o0OFUvSUI1c3NIOEhEQklyaW03Uml6?=
 =?utf-8?B?MnZTenh0ZHVxM2grY3pvUkVkMDU4a2xrZjBCUXp6SEtvNGdWTzBRb3paM3Jk?=
 =?utf-8?B?clJjRzFWU0JMNGRUUThEcXRKK0dpK29jbXFScGF3UXg2eGFUUFJibnFVRnNH?=
 =?utf-8?B?dWw5VDdaY0lPSkp6V1RrQzRUUTdnREhjR0I5U1gvb3pMMFA1M0N2VERib01C?=
 =?utf-8?B?N3pSUGxOd3RHRnczNW12b1JPUWhyM2JUVVlPWk9GTUxxK1JVTnl0RGZ4dFNo?=
 =?utf-8?B?SXVjRU9DWW5YV3hMZ0hBNzUxbWNSLzRWWXpSa1U2cTNzYVE2SmNwNWdFODgx?=
 =?utf-8?B?MllnNURjQ1ZrdXhLeDZydElWRzk1M2pFV3dEWWRzRXFlOEJnRmdlNTM4NlBt?=
 =?utf-8?B?NVcxVEdHWjdoa3ZMMFZkTWZsRmZkeTd2UU5WWXo4cS9tTHlKTmpWRUNwRkZM?=
 =?utf-8?B?QjlBeTYzbFpaaTJTVnQ1Q1lEbWdpRGk1eEdQOXBJa3ZlMnpOR3FxU2EwRklD?=
 =?utf-8?B?MXpNdTQ5dFNXV1lyNXZUSG80YVd2ejVwNks2Mkc1VUl6anh6alp3T2RZTnBs?=
 =?utf-8?B?NGZjSkM0a1BCeGRtRzlyQWNMUHNaWU12QjNWdjJvdXhLdHNnS2VkL1JXL3I4?=
 =?utf-8?B?c0cvOGhNQ25OSldVTG91RDdSamlibzRBek0xZSsvckVhUExnMFdRQ3NwK0R3?=
 =?utf-8?B?dGpIWXBDOHZsZlhjc21xeDJrOThBQ0drTEMwWDY1dnY3RW02NWswMFF1VU1v?=
 =?utf-8?B?eUFLRlJ6TEZPcjFuaStWSmF4VUJFdGxpN0U4ZGQ4dEx0MDNNSkJZNDFaZitn?=
 =?utf-8?B?NkpmSk8xQm9GeVZub3VKd05ZZkZKbFVMMi9IcDBzWitUenhHd0luRWNYQnBh?=
 =?utf-8?B?cENRSUh0VjVtZmZFMHE5QzZQZmJvekZzTFowOGZZaUdQbldyZUcyOGJzV2pn?=
 =?utf-8?B?ZHBjcXpkUEhUdk1rNzh5Ym9RMmdoamxlOEhDb3ljdlZzUzI2UytPSDlGbTRy?=
 =?utf-8?B?UzhGOWFVemtkMlFEc2pkWnB5VitBRmQrR1RNN2JTa1krK3poWUhIR3FVenJm?=
 =?utf-8?B?YW9tL3JlZTZXRDQ3VW91RktOUTkyZ1Rld1MxZGNaN1Y1UVhHckZsbFpIOTNw?=
 =?utf-8?B?cDUzZXRHNk9KMVNHTWRqMzFmUTFpeXZKMmNVK0xRSThpUHc2QVZEVk5QMkhZ?=
 =?utf-8?B?Rmk4OVNnUVB6VkRrUlM3cGlLbmxEbmxpaUw0L1VFYXlvQTc4aGdOZ2hqclhi?=
 =?utf-8?B?R3E4Qy9XY1VnbmlhWVF6RmxyR0lENGlJaXBwY2plMmY1b0NPZkpzSGRrM05R?=
 =?utf-8?B?ckhHb2I1cG1qVFlTV1ZLWHl2bWNEeDlGYy95Y0ZaOEZkQUpTcXFSTTl2YUFt?=
 =?utf-8?B?U3hXZm00L1RlbnlHaE5jZ1VrcVdEZVdCeUhjclhjdnNQSHpPTmhGUExRenF0?=
 =?utf-8?B?elNHS1Q5K0VCbW9YT2J3QnB1UnNrQWxKa0UyOUM4R21TbkM0b2pCQjZuSEQv?=
 =?utf-8?B?ZWNSZmNJLzhXK2Fsc0JlV0lOanBXSDYraFNsdHBpRzY3WUkwZ0RVT3hhVlBy?=
 =?utf-8?B?eGFRWWc0bEIwb2txRWFpS3FDU0dZN2RpQnMyZ05KMUJxWkxYaU1sb1AxTzI3?=
 =?utf-8?B?WnUrTEh6b25zSE9pb3p6c3dpV3hRR2hYdDlOdVZjVmxQODd2MFc3bTNtdFZ6?=
 =?utf-8?B?Z1Zac2FJNWhhdythOXdNMlE0dVd3d29tTUJRenlXUGwvUjYwMmNPbE1mRjUw?=
 =?utf-8?B?dlA2Uk9ZYVhhSnFSQ2J2UkVFcjdMVHgwVUdEZHlRUTJERFI1dWdDcGk4M2Nz?=
 =?utf-8?B?TnA2TDhPY3g2QSttSE4vMXBSNHFmNDNYeURDZllBUzJ0ZHJkZE9CV3B4cVBv?=
 =?utf-8?B?a2hJbnRCRkh3RTAxWDdhMFpvWUgzMkZQb1RsanNnOVZWQ0o0eUlxRWl3bHpR?=
 =?utf-8?B?NFk0a2JxR3c0dlpJcDArTktjblg3T1ZzRkdQa3RybHYyNDhpN1hSMkZjOVZ1?=
 =?utf-8?Q?IpIy8AB59LPio0gJSGDqzPj/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b022e5f-8067-478a-8f96-08ddd64ff8d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:48:32.4587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWwZc0EruPwTdMaoccKArjAdk9m99MN0CaYpsSBnh9rdC0gm7JsZwzZRTeh65GsWY3RWGGZ8orHGj/ukyF5/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

--------------SLtCd90Gb8j7RMqHjf8PlAoS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/8/2025 4:55 AM, Felix Kuehling wrote:

> On 2025-08-04 7:05, Zhu Lingshan wrote:
>> In kq_initialize, queue->process of a HIQ should
>> be set to NULL because it does not belong to any kfd_process.
>>
>> This commit decommisions the function kfd_get_process() because
>> it can not locate a specific kfd_process among multiple
>> contexts and not any code path calls it after this commit.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
>>  3 files changed, 2 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> index 2b0a830f5b29..ebee37937783 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> @@ -144,7 +144,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  		goto err_init_queue;
>>  
>>  	kq->queue->device = dev;
>> -	kq->queue->process = kfd_get_process(current);
>> +	if (type == KFD_QUEUE_TYPE_HIQ)
>> +		kq->queue->process = NULL;
> I think this should either unconditionally set the process to NULL for kernel queues, or not touch it at all, because it's probably 0-initialized at allocation time.

I will leave it untouched.

>
> Either way, this commit should come after the one that removes the DIQ type, because DIQ did belong to a process.

Yes

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>  
>>  	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
>>  					&kq->queue->properties);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index d140463e221b..25534473c28f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1050,7 +1050,6 @@ void kfd_process_destroy_wq(void);
>>  void kfd_cleanup_processes(void);
>>  struct kfd_process *kfd_create_process(struct task_struct *thread);
>>  int kfd_create_process_sysfs(struct kfd_process *process);
>> -struct kfd_process *kfd_get_process(const struct task_struct *task);
>>  struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>>  						 struct kfd_process_device **pdd);
>>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 8e498fd35b8c..0c3f0cc16bf4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>  	return process;
>>  }
>>  
>> -struct kfd_process *kfd_get_process(const struct task_struct *thread)
>> -{
>> -	struct kfd_process *process;
>> -
>> -	if (!thread->mm)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	/* Only the pthreads threading model is supported. */
>> -	if (thread->group_leader->mm != thread->mm)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	process = find_process(thread, false);
>> -	if (!process)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	return process;
>> -}
>> -
>>  static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>>  {
>>  	struct kfd_process *process;
--------------SLtCd90Gb8j7RMqHjf8PlAoS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/8/2025 4:55 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 2025-08-04 7:05, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In kq_initialize, queue-&gt;process of a HIQ should
be set to NULL because it does not belong to any kfd_process.

This commit decommisions the function kfd_get_process() because
it can not locate a specific kfd_process among multiple
contexts and not any code path calls it after this commit.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..ebee37937783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -144,7 +144,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq-&gt;queue-&gt;device = dev;
-	kq-&gt;queue-&gt;process = kfd_get_process(current);
+	if (type == KFD_QUEUE_TYPE_HIQ)
+		kq-&gt;queue-&gt;process = NULL;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think this should either unconditionally set the process to NULL for kernel queues, or not touch it at all, because it's probably 0-initialized at allocation time.</pre>
    </blockquote>
    <pre>I will leave it untouched.</pre>
    <blockquote type="cite" cite="mid:c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com">
      <pre wrap="" class="moz-quote-pre">

Either way, this commit should come after the one that removes the DIQ type, because DIQ did belong to a process.</pre>
    </blockquote>
    <pre>Yes

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	kq-&gt;queue-&gt;mqd_mem_obj = kq-&gt;mqd_mgr-&gt;allocate_mqd(kq-&gt;mqd_mgr-&gt;dev,
 					&amp;kq-&gt;queue-&gt;properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d140463e221b..25534473c28f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1050,7 +1050,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8e498fd35b8c..0c3f0cc16bf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
-struct kfd_process *kfd_get_process(const struct task_struct *thread)
-{
-	struct kfd_process *process;
-
-	if (!thread-&gt;mm)
-		return ERR_PTR(-EINVAL);
-
-	/* Only the pthreads threading model is supported. */
-	if (thread-&gt;group_leader-&gt;mm != thread-&gt;mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread, false);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------SLtCd90Gb8j7RMqHjf8PlAoS--
