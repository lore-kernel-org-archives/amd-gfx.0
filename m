Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104E6D5B164
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E2210E1A8;
	Tue, 29 Oct 2024 08:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYNPxsd7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AD510E1A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 08:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhSujuG7YzSAgFzK13JmLehIbL/BfVP3WjXPBet8McYucTtccYCVxM1/Yue/JTh0hAoBehVJrGwuQ/DYW/Kc/LwSLuz23dzOqOpxsj3gK1W20Ygr0U5s0/8zWNZAL3jXucsREtxBkdAZariaK0lKD9lvPVzCaM2V5awbjkNjerKHukvQG8aVcLwvgDrx94RM9OQDPCrjwdTiw5BXGwA8N1qjwe1uPjI5taI6EjluYtiZIcx2B0DwhVJ1VErVyyfUe8YmIWu9Da0uNf6Nars0oP1svH1pnZziRa0YxLxXCNn3OSI1soEK0c3HycMwhNTGhP4W9mBE9zdz4aNVuMzfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQT1c359WfukTOSTj5X/F66AHdTbcOCq5FH+bv5xWys=;
 b=v5/q8voLgecF+ZTMBB9IfMikFuGS3sERWQs0XTGEDHTJADeO2zs5Or8VJMCLTRK4WTsuekKJ69RqbZ7SbHnihIr3I7euMGm06J6U6ng0/JnvMw4KMMXWdaaVDospDJFyiusLkHqow8bUSXOMh9ZNc6aA9sPzUFdevXg0cCQT3CHXn7WJXCesipFr+/RHnXU9SaqqvtKpEGMxnA3t2lEyK2shKRHXI4hN3Rlt+XcLF8Sm2Xd1H5+JCcMWYvkWhOgLDLc+VbdJinpznXAFlPHpfeJT5ncc/CJV8uXPcWGE4HnubqJUOOZ94UklGBRT+ASPeXwY+NATmjymPDPCxZMucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQT1c359WfukTOSTj5X/F66AHdTbcOCq5FH+bv5xWys=;
 b=vYNPxsd7dwzvXLYbkcCuHJ9lzKS7d0hlwRio9Hg40kFKjtagclnD8dGbBETPN4UneHZwY7IC+8poYNJlZt0ZjDQhjpfxC998DYRjpxIjqo9j+AwX5m/3PiW70VGpUuIkuvUCUMiQSdgVA2uYPbxTaO4k3UXevhQXSM+3LavNjMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Tue, 29 Oct
 2024 08:45:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 08:45:06 +0000
Message-ID: <a69eaf4c-0fe1-4eea-a433-cf009655c3c7@amd.com>
Date: Tue, 29 Oct 2024 09:45:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Add gpu_addr support to seq64 allocation
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
 <20241024121027.3397-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241024121027.3397-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 425a2885-f8b8-445d-1b03-08dcf7f5fcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUt6WjBwY2JZV0p3bGRDYk5jdWM3REtrR0MyemtWQ0IwdThNc0wyTVRuNkNE?=
 =?utf-8?B?SHZrdkhUQkZtWDZxWnNuQjYwUGVrSXlhNnc4NjNmZFhnSlQ5OTdQZGcvVjhD?=
 =?utf-8?B?L1krbUdmVTN1dERReXNHbWF1b2IwOWplTGhZYm1HcHhmS1Y5WDkvRk9hSkVM?=
 =?utf-8?B?T3EyVlRybTZnbzQzS2d0dnJEMEdLcHdxZVB3NGxHTGM4WVdOcFAxNllSMjhq?=
 =?utf-8?B?MEI5UXY4NHh0K01tajlDUzE4a3ppVGh3eTFjcHliTk1hajQ1Sk1VQ21BbENY?=
 =?utf-8?B?YVQzRDlCclREbUVGbE5aa3hJUzJWK053K0FUVGxuclI1cXc2aUZhMzBpZzNh?=
 =?utf-8?B?RUlYZzN0UUdZWkpBaWh1YWF1OWc0UjVtUk1Pc2dzbGh5WEVPc3FRWkRWYnhC?=
 =?utf-8?B?M2cyQ09MS0toU0dVQVFrbzdaVXpmNDdlcng5WVdTc3V5anNNNFRwOXNsQnRo?=
 =?utf-8?B?VE5CVEZTdklCMmFpZVlLdVJ5YjY4ZEJsL3NoZ1RhUFQrREdDR2VFZXh4aVB1?=
 =?utf-8?B?eXJGUTJtNVUxOXJTL3N4SlhJU0RNb0laSEhMLzBENlVuZFN4NEk4cHJtQkhX?=
 =?utf-8?B?TkVENmY3UXdtVGVQdEFrbjZLeHp1ek1YcXgrdGJLU2ZNdU9kdHhXWWtNM2VV?=
 =?utf-8?B?R25iZG95NWgrcFUwT3E4a2E4NVNESFViOVpnMDJkTk1TaEtkSWJXaWRQUUlx?=
 =?utf-8?B?ODlIOStzU2xJNW9Sam9XVzdGSU9hU3RDWHZjeFVQMG1jQkxNbTczcjVhNk90?=
 =?utf-8?B?YVZWS2hwUWkvbTJCS1lsNXJwTmRKcTRWbFdoR1REZjN4d05ZY0J1Q2EzRmtF?=
 =?utf-8?B?bndWYWl5TGRjOVd4b1ZMWUV3VXpYMHY4bHN6Ym1pVGYyb2hLalpvMEpQUjQx?=
 =?utf-8?B?bkpkQWZPbzZHYW41Wm1vMU9wQUxIRkpGd2FQWEViMTBSVTA3R3FGYXJ3SGsz?=
 =?utf-8?B?b041OXFYVDdXWlk0VjI2NnZobHhxL3FRanFNUElDcGp1WTR3by8xWVFLWEQv?=
 =?utf-8?B?S09SQlVDRCs0cXM5WFlLem9kQzcwQVZsU1liV3ZqakwzRFZPVG5qZmNRaTY0?=
 =?utf-8?B?N2MzUW4xVzhtUWFueksxWSsvVW8vZmNUWU01R0tGYkdaU2NPbmpCTytLY1Q4?=
 =?utf-8?B?UE8xbkdxNWx1MVJPTDRscnhCZXdoZ0tCTGlhbkFXbVAvMFYwVGdkaHdPMVA4?=
 =?utf-8?B?RDFFQmFJQWtxczRWOERnZnlBa3RjUVIxdjhjRjZzby8wcHBTVnp2dXVza0xR?=
 =?utf-8?B?OGc3c2J2SFpLY0VPQWxwSU90VzI1RTVEQll4YjlaM0ZwZHNFTEVZdW9WSDMv?=
 =?utf-8?B?SkRROEtpVU5OK20yUERFc0czM3BockdNSkUzZkFIOU5PMzhQNEN1WkpwOC9S?=
 =?utf-8?B?UHhpZVRSSGxUQ25BamRtT01HclhBYW44MlpqWStQR1cvYm9GSi9McXBxc2dU?=
 =?utf-8?B?UC9KWnArOEtlc1BkTEVXelAxRVA5VUhEeTJoRFJPNTB4VHFXUnNDYlY5M0Na?=
 =?utf-8?B?S1pISXVzMUd6OGpUUHQvZWxjOHIrRUtScndSNEV0RTN6YW93RmxEOFprVk4v?=
 =?utf-8?B?R3pKRDFZbGZKdS9kZEpTQW9ldk9oR2FTQjdQWkVobjNjLzdtQ1Y3S1BLQVlj?=
 =?utf-8?B?c2MwcUxtb1VMdGkzZDE5YlIybmQ0dldJQ3FGNFFMZWhIeW10MUJ0TnJWNjBm?=
 =?utf-8?B?ZWJBZnJTbFFhUVdVRTB1Qkx5WW9wM2pWZUNrZDduYi9RYnQ4ZVBOY2x4d0Zs?=
 =?utf-8?Q?aD2N9weT0FmgcLiab1BZjdyp4qio6ViVZfbG+mD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hwMWk4eHh4UFNiZVpJaUVNaTlJZTRscFlhTUN1SWduS0xHK0NBNEthN1Iv?=
 =?utf-8?B?T2NNNFVCT01OcXEzTGNpQXM1dTYxaW44K3dOWWJoSG11eXcyUUczVU1CVmFy?=
 =?utf-8?B?SjVEY0dGSHRGUVpBNnFwa05NRTcraDRraGFUcXJOSnhPMFpjSjE4NHllNUNt?=
 =?utf-8?B?VWptUVRzdFBLK25XaUhyNCt3bU45czg2aXlDT1FGK1V6N1ZjYWZsVGhTbWVv?=
 =?utf-8?B?RU80OGxjT1pRRG9qTUtUL05INTBUbFFHakc1ZnN6c3JaUU5xSm92MEFtbDVO?=
 =?utf-8?B?LzBkZ2FyVnBMbW40bnduYXB4cDZrcys4OVhRMGR1TlNOQkticVd5VjZ2YTQ5?=
 =?utf-8?B?ZlVKTHJSWkhZc2RXeHp0d2ExTDJEUXZKemg4clViL2JScjRqUlVGVkh4bHpU?=
 =?utf-8?B?Tk84NTQvQnpJNzIzYXpZSitub0xIUU1mSGpoNEwzMkdGQVFzZDdEQmx6RUNa?=
 =?utf-8?B?c3oxcDczYzI1cGYrZVlwK0IzelFhdFRwMUNMZEtIb203dlc0RVB5bkZ4czA0?=
 =?utf-8?B?M1JteS9PeXAvbkZMemdhbE12Mmwxbkw5K2xVMkRDL1F6eHBHb2NadGlySDU0?=
 =?utf-8?B?Uy9HdWI4WE5ZcTJjOVFxOU9SZmdJa2x4WFhJVGJCYXF0OEhCNlJvdExFV1Yv?=
 =?utf-8?B?cTR2VDVRRU9mV1dlbGx1cjRma1RRdFFxMktNQVBrRlcvQ3Y5dmxSdVo1Q3RR?=
 =?utf-8?B?a2NJZnlLOVc5SG1SVVU0WFBrMFhKVmlBSHNjcTFjVGU4eUwwamR0UU5NbHZL?=
 =?utf-8?B?c2lSTithODZNVXZhallHN2djL3p1VFhWK29FYzNuRXhCanovQ0locmU4ZUp2?=
 =?utf-8?B?VktHekRUQ2RncDVBQkdRV3NFUklIQXhxcUlXLzFwTFpuV1d1Z2RvQ0MrMVpq?=
 =?utf-8?B?bVZzcGVhSVBCODBGdlJBVWNiZ2N4YVp5djhoRkFUcWR1QVVKYm91Y1BJNFRl?=
 =?utf-8?B?MyswbmVGa1RjYjVqdEE0RCtDcmVyQTBkYy8ycUlodm1SQW0zM053MytPNmJu?=
 =?utf-8?B?ek5YN1hqQnAxNVVWelZlZThKN2lIaU1wQXNmODhkTUxHM1FLSXpwM1NOUlpl?=
 =?utf-8?B?dzhSZ21tNjBhcDRJbkpMK21DM0FLRjFrUDhwWXZnNERkTzJGdU5ZdnlOZEF3?=
 =?utf-8?B?dy9peHJGeEppYjFtaC9xVnVmR1FZc1NTWXpKY3VZd2pHRFRpWEVmangyMHU2?=
 =?utf-8?B?Vmc3Qmt4WFRucGpUamRSTWFQMWFuV2xRb2ZwZzZpWmNlZTVIOEtYZWhrZnJT?=
 =?utf-8?B?dGlLd0hKMjU1UkhGYk0wRC81Y25nMmNHODV3SHhOZllRTXBWNFJPUE9kR21s?=
 =?utf-8?B?RzFpbXk3ZDg1SzM2WUF6MFFRNThxSWFxS3QwNlRzYm9weExLSUhUT0FzUGM3?=
 =?utf-8?B?eGdpcSs2bmdBSWF2azFMZ3RyWnVwdG5xYjNpbXZ5MUhMdTFKcE5McHNMUUEz?=
 =?utf-8?B?UnJHcU5vRVlMNXJZaks4bDNmY3BIcTRpRkc2RkNQSlM5aC8xS21mOFZ4Z2w3?=
 =?utf-8?B?Q1RhYzNJM2dDeTBONXgvTzFITUtUZllwY283bXB0VlhFS1pOT3dMQjZ6YmJJ?=
 =?utf-8?B?WTQ0NUUwbHFjZDI1WmlpTEdXYmpJcnVrZUFGdkc1SHhmZm0zT2JwRC9YQVpG?=
 =?utf-8?B?QTYwTWZuRUNDNnJaZm10aVFjczdiVkVrZGpDbzgxcUhRVlVZUlY5SUoweHpk?=
 =?utf-8?B?U0lRVWRzY1lLbm1WcERhemRyVWZLa2EyenBualY1QVh1SkszSXFtTDArN1RY?=
 =?utf-8?B?MWEyb3NQZXBnZ0dFN1pQMmNVZVlxMmE5dHJtOW9adm1OK1diS0U3a0hYN2Rn?=
 =?utf-8?B?TGpidWdtQjBQZ1hZbWtKY09haEJ4WDU0VFdxS1ZUa3hFZjFhYU43ZmVEZ09x?=
 =?utf-8?B?RTFNaWpGWUdlaXc0RW9DNFo5NTg2RGxDYlFhbjJaZzJqd0RQS1dUc2lPekF3?=
 =?utf-8?B?OTROcG9lQnFpNkFMVHFhQzIyYTRVTXZoeGVVN3lvOUh6eVZlZWtvV01DRmIw?=
 =?utf-8?B?R2xocjEzQTd6empzSzhPM3RJakRMdlg4a1VkVVEvR0VvVXFhVGdsUWp4U21u?=
 =?utf-8?B?K3FFNFlYZ0cvRXJNcU5xdE0zcVRCVXRQSVh0TnZTVXlWWGZNbVEzSW1yNVhB?=
 =?utf-8?Q?pjRagWQTUBQvFx+sLfvLk5Tj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425a2885-f8b8-445d-1b03-08dcf7f5fcdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:45:06.4113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1WNnsu5g5xrqdbHFvbE/p6tfKfKy+b1qYxcrQAL1/3pQ/0r7FxzqInEON6BRzf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Am 24.10.24 um 14:10 schrieb Arunpravin Paneer Selvam:
> Add gpu address support to seq64 alloc function.
>
> v1:(Christian)
>    - Add the user of this new interface change to the same
>      patch.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c       | 10 ++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h       |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  1 +
>   4 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 12cad4424fc0..2f01a209ec3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -166,7 +166,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    * Returns:
>    * 0 on success or a negative error code on failure
>    */
> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
> +		       u64 *gpu_addr, u64 **cpu_addr)
>   {
>   	unsigned long bit_pos;
>   
> @@ -175,7 +176,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
>   		return -ENOSPC;
>   
>   	__set_bit(bit_pos, adev->seq64.used);
> +
>   	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
> +
> +	if (gpu_addr)
> +		*gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
> +
>   	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>   
>   	return 0;
> @@ -236,7 +242,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>   	 */
>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>   				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> -				    &adev->seq64.sbo, NULL,
> +				    &adev->seq64.sbo, &adev->seq64.gpu_addr,
>   				    (void **)&adev->seq64.cpu_base_addr);
>   	if (r) {
>   		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> index 4203b2ab318d..26a249aaaee1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -32,13 +32,14 @@
>   struct amdgpu_seq64 {
>   	struct amdgpu_bo *sbo;
>   	u32 num_sem;
> +	u64 gpu_addr;
>   	u64 *cpu_base_addr;
>   	DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
>   };
>   
>   void amdgpu_seq64_fini(struct amdgpu_device *adev);
>   int amdgpu_seq64_init(struct amdgpu_device *adev);
> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 *gpu_addr, u64 **cpu_addr);
>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index bec53776fe5f..8cf169e7e893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -82,7 +82,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	}
>   
>   	/* Acquire seq64 memory */
> -	r = amdgpu_seq64_alloc(adev, &fence_drv->gpu_addr,
> +	r = amdgpu_seq64_alloc(adev, &fence_drv->va, &fence_drv->gpu_addr,
>   			       &fence_drv->cpu_addr);
>   	if (r) {
>   		kfree(fence_drv);
> @@ -113,7 +113,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	return 0;
>   
>   free_seq64:
> -	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +	amdgpu_seq64_free(adev, fence_drv->va);
>   free_fence_drv:
>   	kfree(fence_drv);
>   
> @@ -183,7 +183,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	xa_unlock_irqrestore(xa, flags);
>   
>   	/* Free seq64 memory */
> -	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +	amdgpu_seq64_free(adev, fence_drv->va);
>   	kfree(fence_drv);
>   }
>   
> @@ -751,7 +751,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			}
>   
>   			/* Store drm syncobj's gpu va address and value */
> -			fence_info[cnt].va = fence_drv->gpu_addr;
> +			fence_info[cnt].va = fence_drv->va;
>   			fence_info[cnt].value = fences[i]->seqno;
>   
>   			dma_fence_put(fences[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 89c82ba38b50..f1a90840ac1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -44,6 +44,7 @@ struct amdgpu_userq_fence {
>   
>   struct amdgpu_userq_fence_driver {
>   	struct kref refcount;
> +	u64 va;
>   	u64 gpu_addr;
>   	u64 *cpu_addr;
>   	u64 context;

