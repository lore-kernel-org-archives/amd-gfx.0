Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73519D7495D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E794810E647;
	Fri, 19 Dec 2025 08:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLzqAilw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2636E10E647
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izmpBW4HkNb87JGqSvZNdzwFWwlhN/H02fjQ6OGCg/kJX6JoVt/rptHSUTpn6sfyQoFBN1NKoxkNubNTDIH/YtABS7SEO9XxXI4WZzmgDpHQDuzhfmR9KF4XFnXPSyra3uSAjbc2/3L7DIKlGgHxXsNSovfFFz6MUbt6QZP8lmi9cXPrrlY8dWYSrCe8n8Lwe3+6y3j5Zh2hSm1PrFHDZFh7n4gLCryM1U8LDR3uQhYMbQ5Q/6PHg8ZKwMCC9qr3hUJXS05er8IyJkXHYmqyrXsHTKKpjw1ln0siSKDiaa28JMs+kptLdajsOYGzBwgDArxOJUI/afVkXmJmdubpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oYgHqs2HvyPcVNOlQB/KVjpIBMJKvWBQuoRj4bs/iQ=;
 b=QTJym8p45NSrEkSfF4ySlKPOTNLHaEU0ZMONSBON9DxluEguTbqsUQm1du2xicN0WgPyvqaSCd2tNhIeNiYDDdZs1LuFLrKGULBr55EuctCIuzZGxU7c11rZBz47fDIRZBAiM8HpYVJbqNpeL0oWol3RRNwUV7NwJjAHqgjrI3Yl41Q73TjSrwdfIGqd1aF5muQkeMxmBc2W3rgl5PF9AM/IUHsJc3gXArqn4jBCZYM3r1c2zN23OFx2vXAj/y8j4TbrjCzfFqD1KxGIG2TjBryBznLQbAusNXTi57voQrmpl+/jJ1He8kusQdo6W4F089V2SFfurjnKocDRWSfR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oYgHqs2HvyPcVNOlQB/KVjpIBMJKvWBQuoRj4bs/iQ=;
 b=qLzqAilws6/1/BMRGq0H7CFZyDuPnEZLbkzZj5zgHFQ0UKZvmjNQ1XmE97WFH3rVhvEHTt8fvfRDKJVCgC0nfYky/rV7LuTzi9GiTMuE2hdKyskqQNOqgu5SJx6impbQt3YpK/Wab114RJHdsxREUZkEuYEFVNtFP1UydDxMU2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 08:28:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:28:48 +0000
Message-ID: <831aea45-f75c-4432-9045-cf44d8f7fc17@amd.com>
Date: Fri, 19 Dec 2025 09:28:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] drm/amdgpu: Convert context manager to xarray
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-5-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0421.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba1e0f5-7d05-4e93-66f6-08de3ed8a1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE4vMFpCdXNXTm9sM3hPQ2tGRzJwV1l6SmNTMmQ5YUFyWHNKYUVIL052SDJv?=
 =?utf-8?B?cVFUWTRNcytsMWRPUFJJbEVocytqSGlvZTcyZm11OGg5YThpS2N1ZUlzVFFC?=
 =?utf-8?B?czkrZ3JOL1N2YlhSV0h5cU9vV0RBWlJiRVdNMHlqbjZLUVFzdGRldW54R1ZD?=
 =?utf-8?B?b2thdldwY2tZQ0RPODh2eGtsRjMwcXkxejd2ZWI5L0ZZanI5aklFZDhQbGtI?=
 =?utf-8?B?OWUxQmJvWXdwNVQ3NGhNa29lYmRCK2pzM1JIT2lVWVFXNm5saEd1ZzM4L1VI?=
 =?utf-8?B?SkhIT21vc3pySXRRNWl3QU1JMXhnZWcva05jYVpzdThobHZmdCtSQTUvV1dn?=
 =?utf-8?B?V0MrdWZRbkpVZDA3MHV1SWhYN3VIU3UwTk01V0xleUJBYXpvVGd2T0dsWWNO?=
 =?utf-8?B?ZHVuU0RYeCs5am9aMXhsV0FaWDV4S2o0eE8rV3JFQmVCdUZINTJ2QWs3RC83?=
 =?utf-8?B?TURDV2pZdzJQbEhiWGJRRUZrODQ1aXcrL1gwdUZ3bWs2cTdBM3F1SlRCSVZi?=
 =?utf-8?B?M2g3Q0ZiRHZ5cjZRUHh1aElwMWsreUlzRklsVUtLa1JUSGtvUWc1SVh1NFdS?=
 =?utf-8?B?VEFFS090eDBoM0FpcnRZclBiUFFjSkdpQ1lIZVlEcVM5eFhnYjAvQjBLVkl0?=
 =?utf-8?B?VXQrUFdUYnNJK21mN1JxN3JNeHZRM1o3aGExRkVVMWI0ZXRXMXJqNitqSXBF?=
 =?utf-8?B?akZUWW5tN1dhMGJ2NUdPTjJ3ZndSU1VDWEw3RXpZcDFkTFlBc29KcHc3Q2V4?=
 =?utf-8?B?dFc0QVBFVlVYSEluRktmZDd6ZW9hMWcySFF5NnpJSVZubzJ0YXlMZS8yOC9m?=
 =?utf-8?B?NHhQd3hqTjR4OU8zbitXUmFDKzNOY0doUWZrWkI1enB0akdJN29TTklNTTYw?=
 =?utf-8?B?b3AzMTZZOXRHYWYzbE1HaWVVUWZpb2VhbHlWR3BXcXZiTzViYmRXQmV1Wk1W?=
 =?utf-8?B?QTlXWlRXWEtKQkdRVm9OYWFpUVUyQm0rdjJDUjNvSmFjTlU3YVJnSGh4QnF5?=
 =?utf-8?B?cHhnMTcxeEMxQ3VqVERIUi9RMnFJbUNCeWRMTHl3UDgrWkhsRWt1TC8vdDMr?=
 =?utf-8?B?c3UrUmlGZHMyM3kvVXRyQzR0UkJibFhtNFMvT3JWa2hERWlOVmFGT3hXc2xr?=
 =?utf-8?B?ckNBTVFXU0krYnB3KzFwVmUrdTY4Rnd2VnBucFk1bDQySVNWZ3d6aWJSUWdL?=
 =?utf-8?B?L29kVSt4VHlXS3JDSndSZzhKUEtITUxVQlNXRE5yMzZGbmZ5Ui90NVZMdGZK?=
 =?utf-8?B?Yk5lYTljaklGMFVKRTRXQnZ0em9obnJGVkkzaFhxK2xMSjY3REJzZlZaclJT?=
 =?utf-8?B?Y1ZQa3RqYlgyNitkaEpDU1RvVUk3b01DTFg5aFVUZGFpSWUyY3hjZ3ptZUVH?=
 =?utf-8?B?K0YzVWV4NzVNNjZlMjhFbThoM0J0UmpqYW1PaUpyQlVtR0RVUllacW1Edlo3?=
 =?utf-8?B?dXAxZkl0dGZoRVlIK2V5bjBXZnhYN3Z4SVhxaEN4M0lhQVJRNkJtNFZDVGFQ?=
 =?utf-8?B?OGxhNkg1RksrOEh2WHRNWm1qakhaQnZqZTlReUYySXN5YmFvbDdRV1lseFZI?=
 =?utf-8?B?RUFnTG5QTzR3S0gyV09vczkrWk5PVmlLdFFYVkpoOCthdW54WnBuUkVHUDd1?=
 =?utf-8?B?ZkNybkg4UjVGSCswN010bFEyUEtONGJDMEduMHVaVFRodlBuTFh0UFFMQlZh?=
 =?utf-8?B?YXBFWFJVYXpPQUlGV0MxS3JteEVBMUlSSzJOejNxQnRBNEIyeHBjWFFwR3ZR?=
 =?utf-8?B?WUVmK2s3cGxKeE93MDNVUEZQU0ZXVnNaem44L3lBYmRoOTBTOEczNWFsaERW?=
 =?utf-8?B?WWZjODJJZkVIbHBwOFBvOE10a3pyUHVVQlhuWjFKeEx2dU5vNXArV3dkclhw?=
 =?utf-8?B?VFd4TnZTd05ONmxSWlBrbDE4UlFTSUVNa1NlTlNCN0IyRW5OS2JGb1AwTEJu?=
 =?utf-8?Q?/ev/qochZShTTaUPwOwLZKpC7TJ1Lez7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklmRG1lSzRQMEV1eWVCWldZQjc4dkJ5NG15K3JMYWliYkdWaFI5YUEvWG1a?=
 =?utf-8?B?dndjK2w3T054eFhOcUJKeVR0RTUwZGptWlpPM2Y1dU1FK0dENTh0Qyt3TGhT?=
 =?utf-8?B?NjN5NnBucExNWlVURGVRd1I1cUwrMlVJckh4aDVQcDY5SEdYU2dFdzlYZGJm?=
 =?utf-8?B?ZlliYWQvV0J3eVFFTTY1RDJpeE53aUZBSENyWUF5cmR2SjlxdFZONTJnSXZh?=
 =?utf-8?B?YmVlcXRWdG9kMGY0dngvdzBZVTRXNWVEL2ptSlRyeDIwNDMra2FuS0puTUNp?=
 =?utf-8?B?MkVRNVF1dWhPSVNCbVppZ1NPM2pQS3J0a2w4RDNJOVJDNUw1dEFSNExBa1JV?=
 =?utf-8?B?bkdpcEZZMlVSN0tKM1BZYmUxRjY2dFA2dVBhS2w4QWJFcDVUNk11a0xaUzZl?=
 =?utf-8?B?ZitZa3dNMUZXUFRkQy83QnRDeUJqc1oxakM5MmJ1T2VwSVNaSGtyNVEyYXpq?=
 =?utf-8?B?ak44SnBWM1VNSFlTT2FEUUVuQ3VIL1BxdThGdGZERmZPZnc3UExZbzdSUDFC?=
 =?utf-8?B?S0pNTzhJUDVqUnRDSWdIeThTWTdJSXdWeGprUk90QUZDamdMenNodmtBTEFF?=
 =?utf-8?B?ODdDM3grcjBiYzVMYUFndnJTcDNHNzBlM25Tb2sxUFY4LzNNMHYvVmw3QWZD?=
 =?utf-8?B?blVaRU1XNXJqbTFXeXRSeWlKdWlrUTNJTWlOY1FtRDZXUzlCcXBHWTY3UGlO?=
 =?utf-8?B?ZDRxa2VNWkV6L3h3V1Z1VlpWazFTdkZHM1BwSldRQUo1N3ZYR0t5a1hDRnZO?=
 =?utf-8?B?L2gybXQwbUUrTFFHMmdkd2RSck82dGNYcWRYdEtkVWFwN1hCVm9oaDEycStJ?=
 =?utf-8?B?NUsvMXJwcGlNMFlySGg0bm9DM3pzdVFVcVFtMFV5QUdiWEdocTY2anF0L0tF?=
 =?utf-8?B?Q0xXQkwra0ZHTnB5YVVRWGExK1lvdmZkQ05sOFlNdmltNjFralNjRFFibTVM?=
 =?utf-8?B?dFh1V21hK2FkZnhEVnk5YUJjT2l2K1MyVmlIZENjMHZydHNzRUkxWjZJSjBY?=
 =?utf-8?B?Qk51Y2laODhWbHVRQ0V1blQxaVhtOTZOOHcrVGlGaVFqTWtJT0t1aGExWHhU?=
 =?utf-8?B?Q0xWRlhBbkVkaEJwWVhQSzFpTlp3MEhKOVVMbmgxeUR4UnBBRHlrblp6WWEx?=
 =?utf-8?B?akdDRW11anFQeWZ5MSswV1hULzZ1VlJvaU45Lzg1cVJyRXovK0V1MWdMSmhT?=
 =?utf-8?B?RXhRK1pVdkJORzM5NHRpOGlhNUY0NzBnYXpTMGl5RVR1OUxRTmcxWXI0RTJw?=
 =?utf-8?B?V3Y5TFFoY1QzcTJYQ0ZaZGk5VklqQmdSZno0dGcvMGtaeG1xVFpHdysxdEJm?=
 =?utf-8?B?NmFmMmkycDBweEJIaDNKWVdFMXVXZGpNcEhlNHl3eE5nbXpiUnFFNDJDZ3hW?=
 =?utf-8?B?Mng2bkJzNzYxQllUNk5kcEl6c2tQRmlYcUZudGRIaVB5ei9rMmhrZzE1Vlhh?=
 =?utf-8?B?UjI5aEdTQUFWR09wRmlIS1JLVDdqWTEwczZtdnRJOWNkRkN5Szl1R2x1cjUz?=
 =?utf-8?B?RW1OTlZnWUlEWm1Sb0R1cWhCOUZNdFFxZFVETFNuem83d1FOMEpHK3lVRFE2?=
 =?utf-8?B?Z254cTVicTE3S1AwdVlVLytTdkNIVm5ySzVjdi9HQWo1SzFxMVgvaEdwVXBQ?=
 =?utf-8?B?UEpRTlRjaE9CUUNRcDBHK1JNTFlBeWVCbGJSK2pPWE91VWpTWG9Cam5uaHlw?=
 =?utf-8?B?bnZySzJBZnBwd05GTnNTL0xEMVdGeU9sNXR0NWZZUDJoOXl2VDhjTkFvTlM1?=
 =?utf-8?B?M3lhS2dsTnJUQlZPTkdyczBYcjlhYUlUckszM09MRkdOaTlKcVNVaWxDcWhQ?=
 =?utf-8?B?Q2wzNDkwS004SkRDemZxekk3YjdyTFJVZ2xHSlI2bWZGS0tEVkZURGtqTlZr?=
 =?utf-8?B?MmpPS1U3V2hrKzNEc0tWUUMvaXhoUCt2S0RISmxUZVh4RkNIQkl3eFFiOHIw?=
 =?utf-8?B?dGh2M0hIRmlLRnVLM1JSRlgvcDkrVk9SSDFMZFFPbENwTHR2dmVOc1RXUVcr?=
 =?utf-8?B?TTZCN3dPZzJlSVJRT0Y2dW1aZE55VlhFYVE4YmZ4VW8zTG9sSHU4OGRjNmxB?=
 =?utf-8?B?NkVvSkVrUGpMVWVaZVZKMUxiRVU2amY5QU55RTNleEI1azU4Uy9qbzJnWmts?=
 =?utf-8?Q?e0MDlaiQEcV66RZI0v4U9qLwe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba1e0f5-7d05-4e93-66f6-08de3ed8a1e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:28:48.4388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuXlBOdH0TOfQ4bh6ym3C/pe2RwNn6NLtfxS3qbyIPa+redG3zEL7K/xF2Bhl9pZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

On 12/18/25 16:04, Tvrtko Ursulin wrote:
> IDR is deprecated so let's convert the context manager to xarray.
> 
> In doing so we remove the context manager mutex and switch call sites
> which required the guarantee context cannot go away while they walk the
> list of context, or otherwise operate on them, to use reference counting.
> 
> This allows us to use the built in xarray spinlock for all operations and
> just temporarily drop it when we need to call sleeping functions.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 117 ++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
>  3 files changed, 49 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index afedea02188d..ee1464f8751a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -484,22 +484,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	mutex_lock(&mgr->lock);
> -	r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
> -	if (r < 0) {
> -		mutex_unlock(&mgr->lock);
> -		kfree(ctx);
> -		return r;
> -	}
> -
> -	*id = (uint32_t)r;
>  	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>  	if (r) {
> -		idr_remove(&mgr->ctx_handles, *id);
> -		*id = 0;
>  		kfree(ctx);
> +		return r;
>  	}
> -	mutex_unlock(&mgr->lock);
> +
> +	r = xa_alloc(&mgr->ctx_handles, id, ctx,
> +		     XA_LIMIT(1, AMDGPU_VM_MAX_NUM_CTX - 1), GFP_KERNEL);

Please drop the AMDGPU_VM_MAX_NUM_CTX define as well. That is just a totally pointless limitation.

> +	if (r)
> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +

While at it you should probably clean up the unecessary differenciation between amdgpu_ctx_fini and amdgpu_ctx__do_release as well.

>  	return r;
>  }
>  
> @@ -523,14 +518,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>  
>  static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
> -	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>  	struct amdgpu_ctx *ctx;
>  
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_remove(&mgr->ctx_handles, id);
> -	if (ctx)
> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> -	mutex_unlock(&mgr->lock);
> +	ctx = xa_erase(&fpriv->ctx_mgr.ctx_handles, id);
> +	amdgpu_ctx_put(ctx);
> +
>  	return ctx ? 0 : -EINVAL;
>  }
>  
> @@ -539,20 +531,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  			    union drm_amdgpu_ctx_out *out)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  	unsigned reset_counter;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	/* TODO: these two are always zero */
>  	out->state.flags = 0x0;
>  	out->state.hangs = 0x0;
> @@ -566,7 +550,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
>  	ctx->reset_counter_query = reset_counter;
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
> +
>  	return 0;
>  }
>  
> @@ -578,19 +563,11 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	out->state.flags = 0x0;
>  	out->state.hangs = 0x0;
>  
> @@ -630,7 +607,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  				      msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
>  	}
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
> +
>  	return 0;
>  }
>  
> @@ -639,26 +617,18 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>  				    bool set, u32 *stable_pstate)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  	int r;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	if (set)
>  		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
>  	else
>  		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
>  	return r;
>  }
>  
> @@ -737,11 +707,11 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  
>  	mgr = &fpriv->ctx_mgr;
>  
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> +	xa_lock(&mgr->ctx_handles);
> +	ctx = xa_load(&mgr->ctx_handles, id);
>  	if (ctx)
>  		kref_get(&ctx->refcount);
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  	return ctx;
>  }
>  
> @@ -886,8 +856,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  	unsigned int i;
>  
>  	mgr->adev = adev;
> -	mutex_init(&mgr->lock);
> -	idr_init_base(&mgr->ctx_handles, 1);
> +	xa_init_flags(&mgr->ctx_handles, XA_FLAGS_ALLOC1);
>  
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
>  		atomic64_set(&mgr->time_spend[i], 0);
> @@ -896,13 +865,14 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	unsigned long id;
> +	uint32_t i, j;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(idp, ctx, id) {
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
> +		if (!kref_get_unless_zero(&ctx->refcount))

This should be pointless, why not use kfre_get instead?

> +			continue;
> +		xa_unlock(&mgr->ctx_handles);
>  		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  				struct drm_sched_entity *entity;
> @@ -914,20 +884,20 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  				timeout = drm_sched_entity_flush(entity, timeout);
>  			}
>  		}
> +		amdgpu_ctx_put(ctx);
> +		xa_lock(&mgr->ctx_handles);
>  	}
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  	return timeout;
>  }
>  
>  static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	unsigned long id;
> +	uint32_t i, j;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	idr_for_each_entry(idp, ctx, id) {
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {

>  		if (kref_read(&ctx->refcount) != 1) {
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
>  			continue;

Please drop that check as well. It just leads to memory leaks and errors should anything go wrong and so only make things worse.

We can have something like WARN_ON_ONCE(kref_read(&ctx->refcount) != 1) here, but I think that is superflous as well.

Regards,
Christian.

> @@ -951,8 +921,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	amdgpu_ctx_mgr_entity_fini(mgr);
> -	idr_destroy(&mgr->ctx_handles);
> -	mutex_destroy(&mgr->lock);
> +	xa_destroy(&mgr->ctx_handles);
>  }
>  
>  void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
> @@ -960,21 +929,21 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>  {
>  	struct amdgpu_ctx *ctx;
>  	unsigned int hw_ip, i;
> -	uint32_t id;
> +	unsigned long id;
>  
>  	/*
>  	 * This is a little bit racy because it can be that a ctx or a fence are
>  	 * destroyed just in the moment we try to account them. But that is ok
>  	 * since exactly that case is explicitely allowed by the interface.
>  	 */
> -	mutex_lock(&mgr->lock);
>  	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>  		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
>  
>  		usage[hw_ip] = ns_to_ktime(ns);
>  	}
>  
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
>  		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>  			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
>  				struct amdgpu_ctx_entity *centity;
> @@ -988,5 +957,5 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>  			}
>  		}
>  	}
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..d073cffa455d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -25,6 +25,7 @@
>  
>  #include <linux/ktime.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>  
>  #include "amdgpu_ring.h"
>  
> @@ -62,9 +63,7 @@ struct amdgpu_ctx {
>  
>  struct amdgpu_ctx_mgr {
>  	struct amdgpu_device	*adev;
> -	struct mutex		lock;
> -	/* protected by lock */
> -	struct idr		ctx_handles;
> +	struct xarray		ctx_handles;
>  	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index 341beec59537..471d27b2db01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -39,7 +39,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_ctx_mgr *mgr;
>  	struct amdgpu_ctx *ctx;
> -	uint32_t id;
> +	unsigned long id;
>  	int r;
>  
>  	if (fd_empty(f))
> @@ -50,10 +50,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  		return r;
>  
>  	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx)
>  		amdgpu_ctx_priority_override(ctx, priority);
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  
>  	return 0;
>  }

