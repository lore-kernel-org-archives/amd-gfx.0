Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3936EC02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 11:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B989010E4F3;
	Wed, 15 Jan 2025 11:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oz4tKiiR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BE410E600
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 11:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7pjC2sogDEId7H+3sa8WYiVbZSv+uaF0y7gNhPGPALXIf7tTYEYCnsggSIXEPl1t3hxNgVv/sdT3KQNl1H1uB4fbEMEY/WzGQXozo7RAOD9qORNivlnuZ0AEE6g/baK1yiuc6OO+RNd+mwLSeXru4O3mbEJCehfODjyxUMw7mP25P78A+ieQ+DlLyE4MB6jZ5B8vW+uHKOTefL/9404cvu5DKVRYMZ6JNOlIME/5si1TZuLpjePye8lypvE/rIeCmT9tpRVur+DtpiODrsFb0YF5Ke1hK2wASzZlcwbwAMPJowMcqDAl01+YPoo9p6h7kaYgupIsG/KRJYLGtOq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpX0t0w+ln4z5dbUjdRzaT8NQNJ0fzMB1EMBEYPU61Q=;
 b=u/Z4EskHH9f9pJESGy6jQZTXiIS2sRpvkawujaafEWI1hWuiZ8bNkFkROZ93XGmHbWdQeBZmlmWy5ZLFAVIpDIueL6j5IurJ0rPfKmS6ksOEWjtIggHzHE4pOIfP7LuyLnvG8GYHYxMiWv8wysIWiGj86DsASKGrw5c5IVlF6ahcdUUxnws4N6K942f3lVtFXAWfqGqx7gNJoe8cbpnGzJLx7w9Uq/nDOAmZCbFPl7lOFIT00sKtla77rk9GglyqHgw/EcEBgBAj3pe7oIYL/XOq3GtzAhyn3NH8TK45NpIGx70VVbCIw5Pugjbg1+ZHbKCfE4o7BnHsLMtHGf+cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpX0t0w+ln4z5dbUjdRzaT8NQNJ0fzMB1EMBEYPU61Q=;
 b=oz4tKiiR+1SJTO4SbgcJXyZ7ayGXEvhYfAw23Hngm+bZw4kWBfV2SWKKXjIC2UM8xTKLMtthxHaXGXGqgnPvNFtwOTCyZJsb1P64lhQVr3hbObZb+IlCxHrS09ypi4D7j5esinazHnVFt0CVNJGZ0FN2vxEfw/jnL4wmxa8PFZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.21; Wed, 15 Jan
 2025 11:56:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 11:56:28 +0000
Message-ID: <446b0bac-b860-4a04-b150-d29fe7edede1@amd.com>
Date: Wed, 15 Jan 2025 12:56:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use -ENODATA for GPU job timeout queue
 recovery
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250115065214.3698126-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250115065214.3698126-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a46541-33f7-4068-127d-08dd355ba519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVRzN2pVY3FuUFZxbmgzdS9BSkJBRXBZajhOeHRGN0doVFhQNVFDaWlkS2dQ?=
 =?utf-8?B?UFpQSjUvdTlQaUh1RUc1MEQyUzRZOU93OXIwbTVXSEVYQWx2cHpUSmZLZS9D?=
 =?utf-8?B?VE44OEtBdEl6TzdGNXN2N2h4QVVLUTZjM3hJSUh6bFBrcnpQbHRkeDVhU0F6?=
 =?utf-8?B?Q0NPNEZucnNMSGhOU2lQSUxIOHBDWEpFUHdkYWZwbm0xOHFNVTR1YmxNNUZk?=
 =?utf-8?B?QWRGWW1yQ3pNV3lRalhrM216VnBUUmNUa2FXVzk1dUJ2dC9xYVUvSFdtRG9G?=
 =?utf-8?B?KzYrT0JGaW9TdjBGVDhJSlMwOTZZWE9ZUWlUaHkzUnppYmN3Zi9rYjRpZjZh?=
 =?utf-8?B?NDVlcnpNbWZ2RFpBU29HQzBaNU5Xa2FuUTVKdm5zM0xPUzRBeW1GaWd5YWt3?=
 =?utf-8?B?bWpNTXJwM1pNTUE3V0NDaUV5RmRRTkhQTDdpZW1GZFU1TE1hWm9GN0FmKzI2?=
 =?utf-8?B?eVJidmw1ampOUTRBS3lvODZTVlVONmwyT1J4SkpvK2swVzV0NFI2MUdjelA4?=
 =?utf-8?B?d1BLcG45WW9NWTJWeHdzc3EwN2xTSVhIS1JTVFlDbEhXa3VmVEswUWxvOGM2?=
 =?utf-8?B?SUpHTEhtOGQyWGVHd2tteVY5OHZSa2FENjFkTDF6SUIyZmhFS1c5dGxEUWFU?=
 =?utf-8?B?UlNDTE04VTlKMUViamIwcy9nMWI3YzUzMnJWdGdkVEZPNjRHZ1QzUzZJQlZ6?=
 =?utf-8?B?dElJQkVqMGZqdldudkhWazJUa3lTU3V4cXZldjlWS1dRK3JZQXVzTzUvaFFv?=
 =?utf-8?B?Y2Y3WVdXMmx0WVY3UUloQTdld2xjaWEwYi9zbG40L2JXVzZnSi8xekhDU2lG?=
 =?utf-8?B?T1ZjblkvMEJMaXRjSnhxTlRRU2MwQXBrQ2dKZnJKdW9CdVNKRGlCZDhvV1RG?=
 =?utf-8?B?amFnbGErbkZMcDR5V2dMVWEzYzdqWWh6YmpBYWJOWEUwTTlubU5MWFdXNTVn?=
 =?utf-8?B?QTVJcEM3ZmxVejhJYjBBRUV2Vm16emxCZDlCT1NENmllQmVIWERxUmR3V0Zp?=
 =?utf-8?B?OHdxdktDZ3dsQi84Q0tsK2JsOXBUN2wxK2I0S2VNWlcwOU16d2xRNGI1ZEJl?=
 =?utf-8?B?UExXVjFpSGl4eUZLYmpjOVdxalZnMDhjL2p0aDNNQStPY3pQUlZhR2dLTjd4?=
 =?utf-8?B?dTNOTFFEZEt5TGVZUTBuTXhZeW13dWhFcUwySk0wZUhxTGJCcVBKR3l0ZWJ6?=
 =?utf-8?B?NlRkSWtkcVpKZ2Z0UXF1aXVKMjZCQVpGcXBRL01UTnBzcWZtemRPdnVaRkwx?=
 =?utf-8?B?RFB5QVNpejgvQ3ZmcXgzdU81Rm9lUzdEb3pOQk90d0pXZWZUV1lrQjVyOG91?=
 =?utf-8?B?Q0dkRWRmdmVIN21oVnJzakVUeHhMMzUyVkdkcDk3MDk5d1h1MUNQVnhhNUFx?=
 =?utf-8?B?TklZajNVdWpBSkwvUTlHOWJWNkQ4RlZPOFNVOFRpOS9ldEVEVFNPenhEUzlU?=
 =?utf-8?B?dmtXbGtGczFrZXd4NFp5SjY2ZGRLNTVjbDZJZzQ5Vk1QYlBYL0c1Z3dBZVRj?=
 =?utf-8?B?dDhnazBPL1BsTzVOU21nbm5LeW5ISEcyQkJKbHpiRDY2ZC8yQlVGSTJ6cjJO?=
 =?utf-8?B?NXY5TndMcFJXYUpPd3JsbGN1VFRsWW85QVdFSU9udzFsMi8vMWZqbzRqMDNo?=
 =?utf-8?B?bkFpekNEaVdwMGtyN2NMbHM4TjJGTzFEWDczckNXZmUwbjZBRXNYUXhNVHlo?=
 =?utf-8?B?NVEyOG5jdmpKZmJqdVFMOUtuWURTTTg0QzdQZEV6aGl5WEtoY29nTDdHdVhL?=
 =?utf-8?B?L2FiUHR3TGQzaWFjdlZVNkQ4RGFGNGZyNEEvOVBQR015ZXA0YVI4NkNGelVo?=
 =?utf-8?B?S1k0YXpCcm5xemRBVWhaa25vbnZJY2puemtWRGJrbWlkeitYSnhYbTJxYnBK?=
 =?utf-8?Q?4IbroHoJEKc/l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RmSEdzeEdqdEFnaS9vaUdHd0VLNzRTWmFPckhzcXkzUmUvOGlOMmE2K2x6?=
 =?utf-8?B?Tm1FTlBMdk4rbVgyOG5LSFZibm5lOEJ6dEErZmxyblh4Z2dvZHVjY2xGZm5C?=
 =?utf-8?B?cFdQcjZQeXVnT1BzajQrYU5kQVpEUHBMZWUvSkg3NkpiMW5VdmppT1lwNVRh?=
 =?utf-8?B?ZkJHN21rU1ZGaHFWV0JGa0UyOXV5a1V4TzhWMmZLZ0pjb3h5N21SdEdMUDVr?=
 =?utf-8?B?ZmZ0bDdldXdDSkMwS2hNQ0xDQ0YrM0srM3BiREFJTHIwd0F5ZXBjYXRQN2ta?=
 =?utf-8?B?aGxtMkRZazM2R2NpN1ZJQU5KVjZocy9pZTRlOEpLczJONnR1b1d6eTYvNm5V?=
 =?utf-8?B?TEV5MDdpaEpUNjl5Z1I4azY5SWZOcGNBQjdscU1pZWNMNkx0WmNxUUoyV3FH?=
 =?utf-8?B?cE5oOThZanU0cU1Vb210OWFXVXFCZlkyRHEySTFvYVFBUmlsa3c2Wlcyb2J2?=
 =?utf-8?B?SDhBYzgyeUoxMnhNZlhoTUZKTGE4NE5ycDVsUWh2cHlJZ0E5Y1gyVG1FVVRM?=
 =?utf-8?B?cyt5RUNvVWRqWERGNzJ0QzUrbWZPN0t6RVNLdTR1NkpDdTJhNnRkTThmQkxu?=
 =?utf-8?B?Z3F0bFY3Zm1vMHJnY2Nja0QzWDlSODV3MVFvZEdRRlZUd2JjR0EwQnNidmhN?=
 =?utf-8?B?dmZqVnRGZ3JDUmppNk1rOXcvd2prOFYwR3duSGJXWmxjQnFaQTlBcDJHS0Yx?=
 =?utf-8?B?Z3N6VmlsVDdaYjFNTHhJeUhid0ZuWXBxejdoUXJ3NzR2eXJnYzFNMkZtZDZw?=
 =?utf-8?B?cW90K3U0RGlrdlpsVVVmcE56Wjh1bDU3V3pQVXF1Qjc2bU1ISVI0ekIwYnZB?=
 =?utf-8?B?VVVBMGRsZjZFSklHUFFCVFNvMmMrWDNOUWFMbDZVSXFaZS9zZlJZSml2TWZ4?=
 =?utf-8?B?dmlNNTg0ZWdiWXZMN3d3NnA1YjJRaTRxMTNFa0Z5eGk5c2FnR21NSGtPaDAz?=
 =?utf-8?B?S2wybldHUWtjVmxmdjI1eFBqN1lPWWFhUjlpcVFnSFl2UStQQUZuSUtsWFVv?=
 =?utf-8?B?MmdTMHk3V3ZUQzFIMEV0cWxQOHFVTjUvaXlKUmVVNDNFMFp5WnlkT2FTb0hU?=
 =?utf-8?B?SUZNMUtxMTVvWXI1ZlJVOGxCVXlsbm5kcUhNc3pkUkExRWJCNSt5N3N4ZUNz?=
 =?utf-8?B?TEYrbjFkQ2hwL1dXOWFpTVVFS2xmRm0yM0l5L21LbUxTL2tkeERiZTMxZk52?=
 =?utf-8?B?MzRrM0FtSHlOaThucEg2NlNyc1NRWlZEY3BjUkd1eGR5K1pTdzFNc1Rvc1FH?=
 =?utf-8?B?cU9NZU9Manl6Smp3bnR3aFkwVWsxa2xnd29BOThIYys4MVBJcTVNRHhjRTFO?=
 =?utf-8?B?WTl4ekxrTnRQeGlpcnBBVFNycnFpUCtwcERXQTFzQXBFUzhLZHFDdnJPeDBI?=
 =?utf-8?B?akJoSDJsalNqa0YzR1R6MzBHVk54TzM1cSs1Nm5FclZnZVJQSmdYOXVwbkRm?=
 =?utf-8?B?OWZqazNnb0tscEFMaVFxa25yYTl0NS8ycTBJNTF2bFltMzk5Z1JvWHhMM2xG?=
 =?utf-8?B?bmVpYlRhQTBrbDgyb0RsYlN4YnVFc00zenpkRzNGTjN2YzBSQWRNODlhY2Zk?=
 =?utf-8?B?dDZrbnp2VXdEVFpQWC9EWjNPSjdWSjN1YTNxRHJOay9kYjVsWkE1b2hiYU5o?=
 =?utf-8?B?dFlOOGp2YUgyMythTFkySncvcDFnWTU5ZUc3MHc4cnNWOVNKcVRzNjIwb2t0?=
 =?utf-8?B?NHdqdEtuQW5XNE5IY3VyVEJIbzdiRFNQUzNVaGZQTUdudU1aN3RrVjNqajky?=
 =?utf-8?B?aGRDbG9BOCtmMERlTU0zeHRjQlRaOGNrTnlyU1djaGVKYjFsTklvRzVPc2xp?=
 =?utf-8?B?Y2hKSHBoMzZEUkFoNytnZm9PZzBVVUdUaGZQc2NGVGhXakozbXRzbk4yeGZO?=
 =?utf-8?B?R2l4d0hJall0Ti9LV2dJOS9oOG5rOGRaVWFFRDZNNnlZTWNETnlFQWgvYUc5?=
 =?utf-8?B?cC9kd1pGVHFqRCtqRlhUUG8zVEVnVlFsRUhURGhNSkk4QnZrRVB4cXdIdmdB?=
 =?utf-8?B?eG5OS0NmRXE5Q3BsVGlNMWNXa3hFS21tVWNjVFM3UWZoVTE3aTk3NlIyMVNq?=
 =?utf-8?B?M3RKZElLOWFhNVFiVzM4TlRvTDcxV1VQSUdSaFZ6THFIVG52RnlVbHdZTFdj?=
 =?utf-8?Q?QZUTqp6eJbE5f2PFVrtyReMy2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a46541-33f7-4068-127d-08dd355ba519
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:56:28.7027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjgxtViSP2kx+HgIzQnoOhEBT0IfoPzIAxvgh4tQjmBB2b3zelPpRekp6hj00Vb2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
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

Am 15.01.25 um 07:52 schrieb Jesse.zhang@amd.com:
> When a GPU job times out, the driver attempts to recover by restarting
> the scheduler. Previously, the scheduler was restarted with an error
> code of 0, which does not distinguish between a full GPU reset and a
> queue reset. This patch changes the error code to -ENODATA for queue
> resets, while -ECANCELED or -ETIME is used for full GPU resets.
>
> This change improves error handling by:
> 1. Clearly differentiating between queue resets and full GPU resets.
> 2. Providing more specific error codes for better debugging and recovery.
> 3. Aligning with kernel best practices for error reporting.
>
> The related commit "b2ef808786d93df3658" (drm/sched: add optional errno
> to drm_sched_start())
> introduced support for passing an error code to
> drm_sched_start(), enabling this improvement.

I'm about to remove the scheduler stop/start for queue resets which 
would make this here superfluous.

On the other hand I'm not sure when I will be done with that work. So 
could be that this will take a while and we should commit this in the 
meantime.

Regards,
Christian.

>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f04475943..b18b316872a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -148,7 +148,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   			atomic_inc(&ring->adev->gpu_reset_counter);
>   			amdgpu_fence_driver_force_completion(ring);
>   			if (amdgpu_ring_sched_ready(ring))
> -				drm_sched_start(&ring->sched, 0);
> +				drm_sched_start(&ring->sched, -ENODATA);
>   			goto exit;
>   		}
>   		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);

