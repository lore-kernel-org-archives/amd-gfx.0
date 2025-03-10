Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BB9C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 18:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542FC10E439;
	Mon, 10 Mar 2025 18:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O1SlBGHf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB86210E439
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 18:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWY8vdQ/4V2DnTP1EAa4BB2IjJmPD3Z+Hrkd8B6QO7iuoNntrd97+OdGrgHTEPX+bfeQCW9UWyH/s1WedFeSTHU0ZXUgvO45gTqiygv0A58VwScIIZpbRMWSOXWqlBo0V+53WH6KEL1siOsVlf3RjL4HSKUJrwmJaV1KyRPXGBKU5D6SuZOnBQ6oHmClB+XmrEqXIlhCShSExZrDKecGz8K77FjXRUcPEqn6xGzG6ss9qClp5wHCX/L2vbwubogmZudW6r4FJ3jPyWQpG2TgRgYsELVtAz6OqZzI+6rh/RXSnUSfZN5Y9TMnm/ZCj+Mnci4rHWa/9dUpUj2LtKWpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIL4rOeDDPY+T3/I2G0Lb5Uu79NeT5+CXiySfRV4TqE=;
 b=jmt6KnjPj2kgaujp8yuxS7fhtdRouP8e02uRJ5lyJsx2qlUc5Q3oOo2wFZTCpgSykMtT+KuN+U2uS+8GuEl0qMlWzKHQiurWHsGVX8gUkT7JqnD3x2aGij2JyvgiojgoHZ4jvLeOA9y0UAxGkKQFP6cOHf/FwbXrOaP88VvX1uLB+1HihIIbpHvibXflpKzVQTOtBHZD2x4yudMJIeK7j6ZkYz+OGaRtkOQndd2kxO8vVDnWd7Q4T6ULG/C9pYF7CBD3Wh/baxhA6qKP9u9ynYcPQUe1sjqYJPvxa9LuY1TkA12WeQcbQ1DsDI52559t2zhj8G/X+hsvItYe1gRx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIL4rOeDDPY+T3/I2G0Lb5Uu79NeT5+CXiySfRV4TqE=;
 b=O1SlBGHfCKc1OZ7W/S12HsC5QHQBnsO1oT4NIuCBIBre2jiDjQG1hwC9yXFKRLefaAcVepAE3JmxzHNJE52Qum7mNhQQoZBtNZKgX7RgT4pPpaetAUq5Mr3Fg/04yQyemz85yIxUIbvt7ZOl2FKep0eEJ0SEmygmEGo0l1uDKxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:04:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 18:04:24 +0000
Message-ID: <c855325f-0e9b-4e6e-8d4e-8f9c56f593c5@amd.com>
Date: Mon, 10 Mar 2025 19:04:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow buffers that don't fit GTT into VRAM
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Ivan Avdeev <1@provod.gl>
References: <20250306170118.40238-1-natalie.vock@gmx.de>
 <43becf25-ad3b-4aae-9919-a74feede06a3@amd.com>
 <ae4084f2-a34e-44db-936f-be4f8204e7ea@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ae4084f2-a34e-44db-936f-be4f8204e7ea@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2f96ea-dcb8-4a99-5b49-08dd5ffdfda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjVpcU15LzZwSWhpcHo5Nnk2RDN6bld1cmJoQjk3UUxkajFZUm9KU1NRQ3Er?=
 =?utf-8?B?dWN5clN6RlE0bXplMnduWnFha3VrWWtRbEdPeVp0RW5XbmVuK2hXSHhhTjlp?=
 =?utf-8?B?VjFqOTVya3ptMmEvaE45MEc1clVTUDVSS2ZnazR2a2xDY04zMVk2RjFHK0Fz?=
 =?utf-8?B?NC8wclNRVlhUU3V0enVsUHRqaTh4YkVzRWhBNjUzNEgvRjFrQXgyTUp6ZVRR?=
 =?utf-8?B?Rld0SnY0UFRwYmprWStSVnY3RlVBSnI2d092T01HMWRCZldrR2JOSTYrSmhV?=
 =?utf-8?B?RkhDaldlWEp4a0NJZ0JLblovY2RwOUtWelhIalFqVmFnZ2lxZUlQdVg3NDZZ?=
 =?utf-8?B?bFVkbFRHZFhWV0k4eXpMTkpSQXJUa1RZR1ZOV2ppV25rcGZpR3Jlb2VLSFYv?=
 =?utf-8?B?cEZDaVdxOUhEMWkxVXo2Vm5OMHVUakl0M1RnNjRxOENDSEFWS1hrUmVCUWR4?=
 =?utf-8?B?Zi81RzJuSXdscXBSZ3JtNThGNHhlVHJoN2ViWjBKcU1BKzd6THRhbkR4RktY?=
 =?utf-8?B?eWNrZDY1UVM3M24yRGJDZVRIR2JoY2EyemFEOEUxVGVoaUlmdjRwTVk2RGlQ?=
 =?utf-8?B?SHFSdHFTOENSeTlzeGxaYk4zZXNjM1A2aTVhZGJWL3IxVzhzVGNCT2xrbUhD?=
 =?utf-8?B?UWhNbXp0TDRSdytKcGdEd3ptQ3c4RldKY2pTcHpmZ2RsZGlDRFkzc2ZydWVn?=
 =?utf-8?B?dVFiTzBUQ24xZkdnOFFZdzh3NTFWSkJMVlRyUjdCU3BEZExVb3FKV2tac0R6?=
 =?utf-8?B?dGc4MnVmQXNQM0MyNm5tNnNpZmhSWkQzTCtDeDV0bDU2T3g5SHliUUVOL1A5?=
 =?utf-8?B?K1BtNnkvZ2tTMDJQTUFrSVJHOVZBeThLb0hrRTNqWURiRGJiTHMrQzRYdm83?=
 =?utf-8?B?aWNBanZBR29wc2haZHQ2ZkpSVE1QWGlSZHZOQjlEU3FpSUh2b2pmK1BqZGdI?=
 =?utf-8?B?OG5iZ3dOcXlqWk0rWHFxMVl5R0VXdWp1UEx4aVJhMGMvWW1zdTBtekFqSzNZ?=
 =?utf-8?B?YjhCci9PL2JmaDlpY3JxMmw4cnpMYnhZRVVzaDVMZngvdERtd2FwNkU3QVA1?=
 =?utf-8?B?YW81eE5rNlE2dUdSZVQ1MTJOUDY2eGRtWmY3RC9FUXhZQzRmOThnaExDcjEw?=
 =?utf-8?B?UlFFMjZHRFNVWWlJbmpKYXBveWVzMGZjZGpNd09UY3cweHBIalVkb2xDUVVT?=
 =?utf-8?B?ckJKZWZRVCtVMFlCUXBObEVrQlZRaCtWN2hYdnNRWUh4SFZkdG5vSlJlVEox?=
 =?utf-8?B?SlFmSjR0R1ZCa3ljaTdHMlUrSVpNaXk4bmMzcHM3Rm1hVGUvOEUxMG5PMlE4?=
 =?utf-8?B?Vk1Vd3lmVTdJaU5xY0ljbFkyYzlycE53blVKRWkrSE44Y1dWTWNVdVVSekhq?=
 =?utf-8?B?MHh3QmJUeCtKL1dHTC9qN2JiT0ZPMjVhTzBicFlKMkdHZkZ4Y2lKblIvaU5J?=
 =?utf-8?B?QVl6a2I3YkNNUnhYSnFma0ZlSXd2M2dDNTRsTjVCSTF4ZXM4dDAwK0JtaGFQ?=
 =?utf-8?B?TjZ0amw2YzBmUGRDZVE4VWNCd1RPNFMrSGgwS0IrcitmWU10U0FvZUg1Y3pz?=
 =?utf-8?B?YkM1RmtHR0hRcU16R05nQ1VqcmZaOFhMVlQwWHUvM3JFZG9sanJNS0NOWGVr?=
 =?utf-8?B?Q3RnRzVoRGJYYkRrVlF0R0RIbW9wSzE2SVpwdVRJdy9HVFg1SDk5U01Da2ti?=
 =?utf-8?B?czBid1pZaDdXNUdwWGtzQ2Z1SHg5WXFjc01wVk1zaG00alVieUdQMXZWcGtn?=
 =?utf-8?B?RCtNZEt4eFM3aG84ditGTGhwaHdwNFFrSjJ1aXRtc3dxb2JFa0h3TVZyK1Bz?=
 =?utf-8?B?cHBOMlBPaCtQYzBWQlhrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9BZE0ySnU2M0dFVkwxei9aZ0kzQWV1dUJJNUJBUzZpc29sNUZoZ01uRlBu?=
 =?utf-8?B?L0lzdWVuWTU0SWt0Z2NaMEFzZmVIeis4cTZCTmkwL0lwelYxcjdWVXJ6S2t0?=
 =?utf-8?B?NVN5V3IzU0dHbmVER3FVWHNEUGdwVWtVNHRsS0I4NXdYYUx5bUYzR0NkY2sv?=
 =?utf-8?B?ZUhYK2dXMjVwTnI0bklHTmFvbWVXRjYyWitsSEk3akV3alJML0dhdG9SWmJx?=
 =?utf-8?B?cUJBUXhMTVRGOFZBcXprYVZDdk15WUN3c3NPQ2hYcHQvU2FXM3E2M2Eybkli?=
 =?utf-8?B?VkJtNTRXcHZicGVuMVU5SitPZEthbkxZdGdFRXZMQ0ZHVmFVdkxTSHFCcVlq?=
 =?utf-8?B?NG1aeTU2T085L3dmOGYrRzhYOElDTTA1a0VNb3FrSWRMSjJFSCtRSVNtR2tU?=
 =?utf-8?B?THl3d3R6NVhRSm9HZSt1SWNHZ0l1NnRSRHBaTFRlQnNtNnhFUDc4NjBneG0w?=
 =?utf-8?B?VjhqcnNURkttT043Q2ZuZklVemZ5RTg4U2E2MDcza2VRUlVLSUFtaGtoT3hB?=
 =?utf-8?B?NXhrZkJjNnRGM0J4UTFKbGtkUUpoWUFzWjFpMWZuQnh6Q0VaTURIS1AwVS9x?=
 =?utf-8?B?dGpWM0p3aTlWM0RFQUtjKzg3QVBmQXp4OEZ5N3pPYW5NNlBMaDE4dWpGM3dG?=
 =?utf-8?B?UFlDUjVzci93a0JPblFQeHNpSWhTTDZIeXZKOE12VHp6VzhvVlpYeEZSelpp?=
 =?utf-8?B?dWRMVUNleXFvVG1qSHQ5OCtSOXRnZDVUUm5EQjlhQ0w0S1ZkL2h1MVdJYXN0?=
 =?utf-8?B?VkUwZStaMUo5SkhTOVQzelZ2QStZemRsMVpRM1NUcXBxSWpLR1ZzWkZDQlBs?=
 =?utf-8?B?TUVvK0NLNWgwdS9JVUh3RXNRaGFqd2RQazdsSGFydVhXekRyQXJZM0k2SGdp?=
 =?utf-8?B?MnlQNzc0MU1mc1lvbHR4aEJRZzdvb0NwMjhraXFLdUM5WGd3S2lHMW0zY1Bq?=
 =?utf-8?B?bnJOU0VTV1M2VFc0ZElzblZqVldRN1NScENNZFdvUVhGVWlscTNLWnI2R3RC?=
 =?utf-8?B?R3c4UzFaczNZdnEvYTA4UEV4bTJUY1daNzJBZ281NVh0eGlORFVwVXBPak1N?=
 =?utf-8?B?dWRZVW9WckZIbWx2TXEwRms4MlZ0WS9haW1CVUFKWCtXd09odEFIQU9WRzlS?=
 =?utf-8?B?R1YwTWgrS0tVbitpeVRmZlpmWmwvMWhZeEljQUVud0p4UkJ3QXFqbVZFNVNJ?=
 =?utf-8?B?OEFmelo4TS8zS2hiYldDTmxOZlg3RGhRekNLUWpFVFc5QWNTRHJsUlFyV0lu?=
 =?utf-8?B?bGgrM0dnbkpPcTQ4RFI1WVF2Q0dMS0hHOURWVm5meURkWm9tanIxWG16TDZG?=
 =?utf-8?B?RTBuT2JvbXNWOElONHkvMHFaV2lNckpvc0N0OWtLb3JxNEw2SUlZNzltODVj?=
 =?utf-8?B?Y2dITlJVZ0I0NFFMeEVyL3NhMFRteDVoVWo3T1ZrZFRBWS9KTmJHb2R3bnVZ?=
 =?utf-8?B?L3AxZkUrVUNsMm9QVFJ3ZklNV0pvZDFkNHNNOHpOMFFFT211RDlnUlh1NjFj?=
 =?utf-8?B?eHIrVTJQY0U0TG1iaEJGbUhFdVRCYUp0UGgydjBhU0EyN3dvWmcrMCt2USs5?=
 =?utf-8?B?b2t2NThrLzdnUFNERzBjZ01lZy9RQ013WnhCT1N1VDlONUY3QUhVQXQyUGJo?=
 =?utf-8?B?YWtqbFc1NEQ5aEJ4NHVqU1RCRC9nczc2MENCVHJURzFkTjhFam5ZZlZLcVJj?=
 =?utf-8?B?enJ0ckJGWU1HQkhMdWo1R1FBM2o5NHorellnbENrdTFnS0dJdWNxRjltVDVN?=
 =?utf-8?B?TjJ5REpGbzIxaXBBN3d2enVWVTVsdUE5a0o3WGZFV0ZLbytYYzdlM0Y4Vitj?=
 =?utf-8?B?Q2ZHVEJkd3FXK1BObDdtRmNUVEZlRkhPQ0lzdmZZdVdGMER1ZEpSTDFGTG8v?=
 =?utf-8?B?MHRNeXNkSFQ3MVQ3NzlTL3o1cEJOOWNXT3NYS0pZUkg5Zkh2ekFzcitOV3RC?=
 =?utf-8?B?VVZTVWZVQ0hJeFYwV21uSWNCbXhlTGxNQi9jV0tzdXAwZlA3YkJIcDF5SlRK?=
 =?utf-8?B?VWN1NnFpK1o4K1VxK3NTSDlEbUtMZkJWTUp1V1ZRTG1QQWR5LzBMRm1nYnZu?=
 =?utf-8?B?dWhFSy9sekNmSjJqZExRcTZLT0IzK2RDOGgvc1Z1aUdYSnhHd0hWWGM5b3Iw?=
 =?utf-8?Q?KeMJeRMM0IHuyd3/CpU5wHK2t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f96ea-dcb8-4a99-5b49-08dd5ffdfda8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:04:24.4961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyA8KCTojOUPNpFGabQJyCxLvCUsWyHXF2pR1oJQXUxO2gRhg7LOrSHVHIfsK35y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

Am 10.03.25 um 18:29 schrieb Natalie Vock:
> On 07.03.25 09:39, Christian König wrote:
>> Am 06.03.25 um 18:01 schrieb Natalie Vock:
>>> When userspace requests buffers to be placed into GTT | VRAM, it is
>>> requesting the buffer to be placed into either of these domains. If the
>>> buffer fits into VRAM but does not fit into GTT, then let the buffer
>>> reside in VRAM instead of failing allocation entirely.
>>
>> That will completely break suspend/resume on laptops.
>>
>> we essentially need to always check if a BO can fit into GTT.
>
> Good point, I forgot about suspend. But as you say, we always need to do
> this, even for VRAM-only BOs. I'll send a v2 for that in a minute.

IIRC we used to have that at some point, but removed it for reasons I don't fully remember any more.

We also support over-committing GTT on suspend. In other words the GTT limit is not relevant any more and we rather just try to allocate from system memory directly.

But at least current we still absolutely need to fit a BOs into the available system memory on suspend, but as soon as that is done the BO can go to swap immediately.

Regards,
Christian.

>
> Thanks, Natalie
>
>>
>>>
>>> Reported-by: Ivan Avdeev <1@provod.gl>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>> This originally came up in https://gitlab.freedesktop.org/mesa/mesa/-/issues/12713:
>>> The crux of the issue is that some applications expect they can allocate
>>> buffers up to the size of VRAM - however, some setups have a
>>> smaller-than-VRAM GTT region. RADV always sets VRAM | GTT for all buffer
>>> allocations, so this causes amdgpu to reject the allocation entirely
>>> because it cannot fit into GTT, even though it could fit into VRAM.
>>>
>>> In my opinion, this check doesn't make sense: It is completely valid
>>> behavior for the kernel to always keep a VRAM | GTT buffer in VRAM.
>>
>> No it isn't. On suspend the power to VRAM is turned off and so we always need to be able to evacuate buffers into GTT.
>>
>> Regards,
>> Christian.
>>
>>> The only case where buffers larger than the GTT size are special is that
>>> they cannot be evicted to GTT (or swapped out), but the kernel already
>>> allows VRAM-only buffers to be larger than GTT, and those cannot be
>>> swapped out either. With the check removed, VRAM | GTT buffers larger
>>> than GTT behave exactly like VRAM-only buffers larger than GTT.
>>>
>>> The patch adding this check seems to have added it in a v2 - however I
>>> was unable to find any public discussion around the patch with reasoning
>>> in favor of this check.
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++------------
>>>   1 file changed, 14 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index d09db052e282d..b5e5fea091bf1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -555,27 +555,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>   {
>>>       struct ttm_resource_manager *man = NULL;
>>>
>>> -    /*
>>> -     * If GTT is part of requested domains the check must succeed to
>>> -     * allow fall back to GTT.
>>> -     */
>>> -    if (domain & AMDGPU_GEM_DOMAIN_GTT)
>>> -        man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> -    else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>>> -        man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>>> -    else
>>> +    /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
>>> +    if (!(domain & (AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM)))
>>>           return true;
>>>
>>> -    if (!man) {
>>> -        if (domain & AMDGPU_GEM_DOMAIN_GTT)
>>> +    if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>>> +        man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>>> +        if (size < man->size)
>>> +            return true;
>>> +    }
>>> +    if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>> +        man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +        if (!man) {
>>>               WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
>>> -        return false;
>>> +            return false;
>>> +        }
>>> +        if (size < man->size)
>>> +            return true;
>>>       }
>>>
>>> -    /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
>>> -    if (size < man->size)
>>> -        return true;
>>> -
>>>       DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>>>       return false;
>>>   }
>>> -- 
>>> 2.48.1
>>>
>>
>

