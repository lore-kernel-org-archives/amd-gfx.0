Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CDAC5320E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 10:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9321910E096;
	Mon, 19 Aug 2024 10:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IPtrxxJk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8499510E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 10:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIT9PfgbLbACiNQonq4/qzPhgx37w9vKPBvcw8QYotV+INxNotc+pgGD+qfUGoUYMcwmm8FCC4xr2FrHEVHV4xkWWEbF5nDnmnCm3+imHb/9e5ViT7ulmPXBt+4Gi3gU1X9M2PteswjRVwapcx5wt83dEAkS/EYTGZrxpe8pSecTMUKBQ3ntFG7eTLVae3kAkBOoO1HHLDnK0CCRv3GRmB/Y89ZkmVEjbyI3f+MQ2KeSJI2r9FPnyGWJBEGb2JDkFQikDDqD7oj6HQoJoA0lelUK6ur4MMVnYrzrFmNxHFklRAqDHtldBmB8hnCTUDAKOmcbZwBNHIqWJDsm2Xsd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIIldiF9cXuMtY0oJ/GKYfbpcg6oWQvgmkwUu9laRvc=;
 b=t0GCz1wB5YcovtUmlxmTvOsLnUnyTZ6JamCFEHgf26Ttgv605LrTmIP5qY0XA16WIMErThcrVxZnVmBZj4kd1vL/5OGFi+dVP/1ZEXNQKtolaf7hbOkxOtBmubMoM9LEMFcpixnGTKWg1W+s7VMfvAVYPTbKuIYfigIq1SAhp5XB18cRrdoRukD4Ig/fgfOxLryY9uoEJiyEPHi5GyGiG2lZpe9hVaSrjATOPMrjt9F6vF9olqtVQfSdAalD4Nuv2e/vZCFWlSL3EpVbhMhShoH7hpkX648mVPajFJPvZWfQthvo5Fr0FGcyrf/d3/xZX0aqqxnt+fed5nqhYXmYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIIldiF9cXuMtY0oJ/GKYfbpcg6oWQvgmkwUu9laRvc=;
 b=IPtrxxJkKB/UYF5R7P0sBnKjLLd3arDf6lF6gBHO4VzYK5gOJGKMu8ytojXggXeNAvhH6UcN+XO2kq+/NbiCTpqQmUgcYn6dVaSefg3wOzRki9zMm5bb/fXn4ny0zczdEIwkPD27g9ybnMNoDKYOzTth4IVUN/JBMoo3/lLvhzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:30:54 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:30:53 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: Trigger.Huang@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
Date: Mon, 19 Aug 2024 16:00:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240819095331.460721-3-Trigger.Huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcdaedb-2104-4e93-c075-08dcc03a007e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJnNWZpNzdsMkdleGx2UlkzcnhFUHVGYUhWclRXWUZ5NnFmdkIwblkraVUy?=
 =?utf-8?B?SEwrNGNuN2RydmFBQkNIRmhiL0JESk1mSVlRbk53NDlLUWk2VGVkL0pzMjJv?=
 =?utf-8?B?WG4xU29yOWRvY1E5b3YrbVRXZDd4ZnB3UUgranB4R2NtN3YvWmVSWGF1Unls?=
 =?utf-8?B?cWZqK0lDWFg4R210U0wrN2YvdS9PaVZWUTk3STdsWFkwdUZndWFUNWtEVjB4?=
 =?utf-8?B?RmFjYnkwamphTnlBNzRSTUxWYXdKTWZjWGVSdElybXVKUTBxRktKanlKRXRF?=
 =?utf-8?B?MytTS1VxYXVmTnY5QnZseTFSNW50WjdRb2h0SytxSUZwM0JmakpWdG8xSm9i?=
 =?utf-8?B?cFRpaUlZdURLMlB1QzR1RlJXa1Z1SWFYWnFIaklpWVFKcE4wVmlOajZGR1NJ?=
 =?utf-8?B?SGVRQXVQNUl6cmdPZm5IQXBoNElrbmZLY2RaVy9DbFp1eTJEeTVENzhmbDJy?=
 =?utf-8?B?R21rNTJZZmFudDVPU3YrV25IbzdKMmFsYWV2alNSdGVDMkgwLys4SmRKaHRs?=
 =?utf-8?B?SlNtb3NXdEtNNjVqUUsrL1F4N0FhZnVWQnFacmJFV3laWXA2Y3VQaWwvNkhV?=
 =?utf-8?B?aGFZVWNUcWFFQ2QvNkJOZ3FBaXQxTW1lUVVKa2ZBS0VIdWdtMzlXMTc1MGtR?=
 =?utf-8?B?OHd0TFMxL0xvWDd0d0NRNW9CdWU5VTN0TFdZdDREMzEyMG1pSVl0MnpPL0c5?=
 =?utf-8?B?c1dxTWdPL2JweDJtZFRaRGtoVWxmNzJQZHJqalNGc3ZPUXo3YjdicWo1NW1u?=
 =?utf-8?B?ZitRYzFDSDFoelZqVG5yNnRGZndEQmN1SFhISzc2cnNDZWVZK2x0a2RmMjcx?=
 =?utf-8?B?bGxxVGd5K3RQZ2Z3WW5ZQWJsZlVQL3RXOGp6SVhmSWdhN1VsakMwc0h0aDNo?=
 =?utf-8?B?WTArWHhzOVFVZyticWo4cDAvQjRkdDYvQnhzV0wxemhvNVpUQXdVbExtRkxs?=
 =?utf-8?B?dW81N2NjWElZMFZGTWtVZkJrSVhIU2pnaFhhLzFBOXE0M1FrUVhWSGIyblN3?=
 =?utf-8?B?SUNFTlFvQ2xYZEdqOGVqSDJUSXlMdUt3ckJSWTBKS0FzOUcrSmxrdzZUc3hn?=
 =?utf-8?B?RzJuS1FEWU8xa3RwZFU5MkhIaGVmOEMyTkUxTnA3UkJORFFIdWRhNkF2QjF2?=
 =?utf-8?B?OEpxNnJyQTkrb0VZTHY0WDJmbzZTOUozMmY5ckxTT1BITm55T1d6cVFtUFFu?=
 =?utf-8?B?TjEzWDBuLzJNejUxMzcwbVVuTW1mbUpwWENOdXh4Smx5ZXF4VnBKZUZTSVFx?=
 =?utf-8?B?c2R0S0FoU1VQTnM2ak5mRHI3ZjBvNHhxUjBkQTV5Rk1ibW9LZzVDdVY3SStn?=
 =?utf-8?B?WHFVd3FuNExYR0FnS2ZnTnN0S2V3K3EzaFUzTEEwUVJzekYvS2l5aUU4R1pD?=
 =?utf-8?B?SGJ5YU1palJOaWpPRVlmNERKMEFUL3Q0NU0wV0pwcHBmUFJ3enZBaUtHcU1j?=
 =?utf-8?B?V3g1TXZGWU92VkVRSlk5RG5MSGxya3N6YlAvS1IzU0dpSTJBa0xDcmNyb3pj?=
 =?utf-8?B?WFVnV3RIdStSdUpxNzc2TWpUWE5MbURmeWw5TmNtOGRPT2NaeU4zL1R1bGl5?=
 =?utf-8?B?U2pYVEx5MEUrT3BIUUVOOFNRQ0liVmZtU0daOVlGeDVLam5xR2RvUW43SVBD?=
 =?utf-8?B?cmhUOENBczNpMCtiemRiWG4yRnIweitoNlFGQWliTHFkaEVPS25WZ1p3WUFO?=
 =?utf-8?B?eFhhREFkU05JWlBTRldsbWcvdUJTclVHUHpxb2llWVhTaXdibGNuSDJycTZy?=
 =?utf-8?B?Qm5WTUFhNG1ULzBqcThqU0l4VmZXK0htYjJ5YUpUREd2UDM4YnZIWURZSnVM?=
 =?utf-8?B?Y0pnd25EazEydzU4M3V3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRhQkVJaFQrT3F5OFdwbjB2bmJ2bnhuM1pnQTIrVVl6T05nSmpXNHBMSXo2?=
 =?utf-8?B?YXJjTkR2bXBYaFFJSkkzU00yYkQ0c056OHNGRE1hQU9oak8vMkNmellEQ0JI?=
 =?utf-8?B?OFdkZ0tabnpOOUVJUHkxaDJMbmg1alJoZHptWHU2Y0svVmxEN2RzME15UU5n?=
 =?utf-8?B?N1FoUVArdWd2dUdxYjVyOWgvUFo4TWZSTTEvS1k2V2x1U3BjcDQzaEZ6SDRT?=
 =?utf-8?B?dHA5RnByLzd1VU9oNVA1aElwZHNBeGxuWTcxdmFmQ01MVkkzT0ZBQ3lPcGJJ?=
 =?utf-8?B?OW91TkJ5YnhyTTk3SnNpVEU2dTlCOVR2LzdFWG5XSXI1RjJSR2x0ZnhRVmIw?=
 =?utf-8?B?VUtiMkN5Zy9aREt0Zy90T3ZhRHpaek5aQXE0a21qRUN1Z2tMaW5XTjZjS1hB?=
 =?utf-8?B?TnV2QjlETlpUa05DVkQxMGZBeTJlWFQ5a3pHMEFhR2VHL2dXR3krR3dXQnJp?=
 =?utf-8?B?a21HUE4rYi81UXVpc2puL0NZeUFhWFJRd2g0RXdBbVNuNytFdWpkdjh4TXRh?=
 =?utf-8?B?SmNkMlZOOG9UNjRIT0RMdDdMdGQ1MkdpMTJaLzB2dURaSWs2YTUzNXNIYlcv?=
 =?utf-8?B?Ujl1emViNjl0WlYrcS9hQWRwRXo0VkI1L3RBZ3ZYMkM3WmFpRXlyT1hKZWJi?=
 =?utf-8?B?ZndsMW8vcnJ0c0kwQ1F2L1RCY245ZXVBa05IN2tCRVhIOG9kQlcvWjMrcUoz?=
 =?utf-8?B?WnBaenBIU05PTWI1eDR4ODR1cnlyRCs4dVhJc0hUa2RJck5DSlh2d2NybDdu?=
 =?utf-8?B?em42S1dLS282TGVhVk9WWjlydE5FWUxvb29CeTQxYzVkd3djdVRRSStTelhj?=
 =?utf-8?B?K2JVMVZTa3Mxd1FGU1ZhaGdYVkNYMGQ4R0hlRjJpVE1vTXd5aytPQlV2Mm9K?=
 =?utf-8?B?N21YVWszbmlhUFFZVERxOUQ2ZXd2ZlFxaGFVdzBrYTU3TTRlVE5EckFSSjcw?=
 =?utf-8?B?bkdLNHlNTWxSbGdsalRRZTdDMzFTWWxxNWk5dEorQXAvUmlXcEwwaTFiTEsw?=
 =?utf-8?B?alFUZWR6QjM4clcxbjdLTWlaN3pSM0N5UFVGdDVxSG8rVDZqSDFnRUFWbDdm?=
 =?utf-8?B?RDVXTnV6cFJtNllFRnd2UEtwelhrcWV1ZGo3YTQ5aEdWY0xsdmtoT09QbWth?=
 =?utf-8?B?eEwzUkViZkI1UjMxUlM4cndYVGhyTWMvRGovQUkwRFVOS08vRUlQYkJvdU9T?=
 =?utf-8?B?bkZTMzN4TzBxSmMxUTJZV21pUmp1MEgvaStYVTZkSW9MUjhmWGthMVZhTWQ4?=
 =?utf-8?B?Ty9PRjZTdTk3RGtUcVhqMzFOVXlMaFZxUUh0dEkrN2EvVEpBbjBFYzc5VDgz?=
 =?utf-8?B?M3dSVVcvYWdaNkowYjl1c0VDTUhGQUJOaDJPVjFrY3lTemxldHFrSzhEMVBa?=
 =?utf-8?B?NzlpanRvQ2RROFp0MkYzMXEyV2NlMWlibFg2dXVPVUhyT2FUTWVEcE5hOCs4?=
 =?utf-8?B?bkFob2lqdDVlckkwZUxuTlRVSnF0cmkvT3J6TjVEK2FOL09DYm45TkZxb1Iw?=
 =?utf-8?B?UzFmU1JYNTNCZnhTS1lnK0VRNlhhTWkwNzJMNzNYZTBHTmZMYU5lejZtYXBF?=
 =?utf-8?B?MVZNOXZoUkJib2tPTFZLTEkyZ2xlTWlvVWczNWpVbjJTbldVM2F6M3dUeGE5?=
 =?utf-8?B?dTc4TlRlUklJMFBDb2xnRThMM3JhKy80SlIzU3hNcnJDcHQrMGNrb3FPSmJw?=
 =?utf-8?B?b3FTaUoyVy9iZHAvTWlUTEx4NEpRMVhjcDdlT1ZYZlJGRHB3R3FHbTZLR2Yr?=
 =?utf-8?B?RkJhekhURU5XV2tVdDAyWmxOcmREYlpMMU9VWjB1Ti8wUzgraktVQ29NT2Nw?=
 =?utf-8?B?RkRnM0VIQ0FxL0tjVXdIVnJ2NVc5bWJ0b3BTL1h6SW1vSVBmcE5HemVoQ081?=
 =?utf-8?B?VkVYQjZJMGhrcUJFdnRqRzNpbU43YUJ5QXljRTlTbXJDanFuRXZ2WSswNVlD?=
 =?utf-8?B?ekJNcEJaaUlCMk00UHFSeVAwZDJpTC9MeE96aURGWlBQeWNVNWtJUkcySEJX?=
 =?utf-8?B?ZUpsaFJMRGNOenNlRDF0NXRnVTgrcHFOZXB3NktZWm1XdnZJMFVycnduZWJB?=
 =?utf-8?B?OVBGTkh4cGpVcVJoWWtVbUZtYVJKWkNlaXVtQ2MzVkYyUmI5NTRaNEcrTXRs?=
 =?utf-8?Q?5rgzkIN5FlkQxbzv+xf9nlRQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcdaedb-2104-4e93-c075-08dcc03a007e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:30:53.2014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfuD77UjQNDfvyf0UJnWFrYidnKmTDscwLcSSBJqYiKjJOsLqKuO9XVwReNlXQSQoac+5IH4xngM+QR5DDwhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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


On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Do the coredump immediately after a job timeout to get a closer
> representation of GPU's error status.
>
> V2: This will skip printing vram_lost as the GPU reset is not
> happened yet (Alex)
>
> V3: Unconditionally call the core dump as we care about all the reset
> functions(soft-recovery and queue reset and full adapter reset, Alex)
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62 +++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c6a1783fc9ef..ebbb1434073e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -30,6 +30,61 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_dev_coredump.h"
> +#include "amdgpu_xgmi.h"
> +
> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> +				    struct amdgpu_job *job)
> +{
> +	int i;
> +
> +	dev_info(adev->dev, "Dumping IP State\n");
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> +			adev->ip_blocks[i].version->funcs
> +				->dump_ip_state((void *)adev);
> +		dev_info(adev->dev, "Dumping IP State Completed\n");
> +	}
> +
> +	amdgpu_coredump(adev, true, false, job);
> +}
> +
> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
> +				 struct amdgpu_job *job)
> +{
> +	struct list_head device_list, *device_list_handle =  NULL;
> +	struct amdgpu_device *tmp_adev = NULL;
> +	struct amdgpu_hive_info *hive = NULL;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive)
> +		mutex_lock(&hive->hive_lock);
> +	/*
> +	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
> +	 * devices for code dump
> +	 */
> +	INIT_LIST_HEAD(&device_list);
> +	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
> +			list_add_tail(&tmp_adev->reset_list, &device_list);
> +		if (!list_is_first(&adev->reset_list, &device_list))
> +			list_rotate_to_front(&adev->reset_list, &device_list);
> +		device_list_handle = &device_list;
> +	} else {
> +		list_add_tail(&adev->reset_list, &device_list);
> +		device_list_handle = &device_list;
> +	}
> +
> +	/* Do the coredump for each device */
> +	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> +		amdgpu_job_do_core_dump(tmp_adev, job);
> +
> +	if (hive) {
> +		mutex_unlock(&hive->hive_lock);
> +		amdgpu_put_xgmi_hive(hive);
> +	}
> +}
>   
>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		return DRM_GPU_SCHED_STAT_ENODEV;
>   	}
>   
> +	amdgpu_job_core_dump(adev, job);
The philosophy is hang and recovery is to let the HW and software try to 
recover. Here we try to do a soft recovery first and i think we should 
wait for seft recovery and if fails then we do dump and thats exactly we 
are doing here.

Also we need to make sure that the tasks which are already in queue are 
put on hold and the their sync points are signalled before we dump. 
check once what all steps are taken before we dump in the current 
implementation.

Regards

Sunil khatri

>   
>   	adev->job_hang = true;
>   
> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		reset_context.src = AMDGPU_RESET_SRC_JOB;
>   		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
> +		/*
> +		 * To avoid an unnecessary extra coredump, as we have already
> +		 * got the very close representation of GPU's error status
> +		 */
> +		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> +
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
>   		if (r)
>   			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
