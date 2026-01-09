Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00EBD232FC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DE210E843;
	Fri,  9 Jan 2026 09:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQoRkIfd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACD210E848
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm4IhyU6p2VnSeU07EovEvWXaBVMTkhBbiWrUYoSwVSH1SssHV/NlOqN05n6zdtsLhNP4l6sXUcCEDDaM8r+4Cqv6U0Z86v5tBcXkMTWgaHuRAiw7rt/kg00W/756XpGgX6g8ucfD/qHvjGGttKoRuJmvHBHAv17ts8nA4EBGlQtRTjVQzyPhBZ2amxwafytT0vmAD2+1rUHMR33yCtg+G9INUJd+TWz/7gEo3HwT+/udXORxdD+2ILBzCN3iBncqMcy33Tw6JkCkMKUYV+Q7dap73DIPWDOFQ9w2JcyDxxl4RR9S+pGxu6xd5t7DqsGD9+8ygxHwUyzzPr4Qk83MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVeGv3Reh8uyHS9DcIzHquZIC6SK95waPyKqfqO8YvY=;
 b=ADDy3y8H1O4ln3dIK6lrn65zSV23u1j5NoVLLzDIJJc6TwvSf9eZCru+ywkF5cRwRM+lfZzbcYclIqdv0eLPqBk9Qd5rkmYTDcVFEp6VN6q4cVIfq2iyVKVoLqFsbS+YsrpO4ti5yvwXzRTqTlEFMQuIEt5fAX1qep+IcuZFvOWGeKz6JVz9JRmGnGQquJOP/MzsQmVJwZw6XrHX7qrlFnFuj9BvE6JCHHOaLHwZSEukm0Iq1C7LsslzSbxCtNozdusRDL6aBD+C7Dq73frgw1p+iskJdmKk684JwDzZb/lF6hmudQ5B2PfYSsmU1363PvTWcTDpoNJaqbX59MyV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVeGv3Reh8uyHS9DcIzHquZIC6SK95waPyKqfqO8YvY=;
 b=nQoRkIfdsPhovnl7da/qVhDy/TbDIvQn5aP4D90zKPaLt/E6FkOix9u/YC3y3tQ45VwAOphBekEDyCc99fxTa51g35ewQ3R3+39lK2X/hMoBRJXiufEXcxCCpCoXlwZi366DU5Ud2uFHThpETkRD4sdqEahR/Fq/ToZFRmmDEmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 09:09:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:09:26 +0000
Message-ID: <2e383ce6-9cbd-4fd3-97ff-75c5c8cd89e1@amd.com>
Date: Fri, 9 Jan 2026 10:09:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: validate the flush_gpu_tlb_pasid()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, phil@jpmr.org
References: <20260109082523.889564-1-Prike.Liang@amd.com>
 <20260109082523.889564-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109082523.889564-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8dc3c2-59c3-414e-36f8-08de4f5ec9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVVUOTVWZUMvSFN3VmpkdktNMlRhOStUL2lYU28wNnpvVVgyd1loWnJTWkNt?=
 =?utf-8?B?Y1huVHFRMjdKNHRiQnhHMXJoTlVtNlpVNW5wbWxLR2pGSWtEbDhUNGQrRGRL?=
 =?utf-8?B?a0hLWWp3OHFQSlNmVFBVNmh3aE9obmVEWWo4dHBMZG5PaWVnUktKS0txS0JU?=
 =?utf-8?B?VU8yYjNYT29uei9HUWhVdE9nem40RGo5TW5yYWoxV0x1Q2JvdVhWYi9lazdO?=
 =?utf-8?B?QjlRTmRXZnVlRE85QjRXMmluNHNpeG5oRGlka2tvRW9JY0JZd0o4VDAzdEl3?=
 =?utf-8?B?ZVRmUDdWMlRHZkYyVG00WThnY0FrVnZCczhlWml1SDNsbjFpMVd2WlNvUll3?=
 =?utf-8?B?NWFxTkZxa2hudHQxdXpjakNuWUZ1Ynkxd3JuZ3RodTlSbXo2SVR6R3VlNVho?=
 =?utf-8?B?akd0S095S0ZSMHZiVCt3UjZpZFMzVm9xMzhUOVhMbldjWGt2Ni9nbjJTVGVW?=
 =?utf-8?B?SlVCYkFXVHMyaVUzVWt2L3B0YUkxWWxjd1BxazlKa0xnWS9SbkhZempkV1Jy?=
 =?utf-8?B?REtkUFRxMVZDVWRDcGhVT3NneFlDRUlrcjV5aXZLcXZzb3FGMlRzOWxEZStp?=
 =?utf-8?B?eHY2QUdNVVVaUWhKZWtCVzR5UzBzTFlZaTNoTDRWYUJxVm1wNmJBNXBaZU5V?=
 =?utf-8?B?bHpBeHRaK3ZDdnN2TVFuNk03OXFIcXB2YlR0S3pCY2RUcm9Yd1dpYlY1NjVC?=
 =?utf-8?B?QUlWWmVOWURZTGsyM2lvc09rc3ZGNUtZSFhwSjl1Ym1yK3g1aWZwd2VkanY5?=
 =?utf-8?B?TjRUZUJRY1RtSTJOcDRhNkFJK0pzY3lMV1o0L2NDMUhxb3k5N1hMektsLzBr?=
 =?utf-8?B?WW5iL0c1aUcxUWdBRXkzdnlOelE1UENRZ1Jzd3VGQnp5ZjJiVEZXTEEwY2Mx?=
 =?utf-8?B?TXBveXNJTXpZdzhyMnNJbm9NQmQ2N2NETHY4YlNaQnRodFNmcDZDM2l4R2hD?=
 =?utf-8?B?dm1LbUQwbWhQZGJtR09CaURDbVFxVFVWc2t2UDE4SDNibkJGU3VvV0pMcWgr?=
 =?utf-8?B?K0RJenNwQ1ZreU15djZ1a1lQRHBPVHJteFJ4Z2thKzlGSURpOGlTMVNxdzRP?=
 =?utf-8?B?SzRhQ1JLdGVzby8vRC8rQklFamtmd0hNTUczdTBsNkNHdVFsVUp3bm0wOFVM?=
 =?utf-8?B?SDhHMjA2NXJxM2VYY2RPQ3A1SjlXR01NaXpUSTc2cEdrdGd0eTVabmJyOGM1?=
 =?utf-8?B?UU1JeHB1cEkwaVgwT0hBeVdMRTBxVWcrZ011NnEva2JlT3NRN1BCcEptOU9O?=
 =?utf-8?B?ZDlLcjR3RnRYTTROL1FJWHRlNGhCZ0hUSWsrdWE0ekNwK1lUb1Vxd1VLUGMx?=
 =?utf-8?B?RHZacTk5MnRNSG1TTklHTVIxZHYzdUQraGphMU9ZMDNBd1ZaelgvWVNZdEpF?=
 =?utf-8?B?UnVycW5GQ21JOGhYU3FQSVlLN00yNHJraDVpUG95cWVHTVgxNVh5MDNXbVlB?=
 =?utf-8?B?UDh4VDlDS0hPa2VWRjdIYmRZNkhGNzA4dHhFMUNCa251WGF3VUZjOHR2L2dM?=
 =?utf-8?B?NkVSVmlmaXRHeXdyemN0TkpYOTI3ME9aZUVzeUJvNitBOG8wem4xL0pDR1dI?=
 =?utf-8?B?N1YxR1plOW13eGNFVjZ6eDRJcUtzckJudWhidG1yVFBKUmpTSStHN01ZV1Nh?=
 =?utf-8?B?QlJrL3I1dTNvRzU5Z0orWjEyQkJaN3l0UzZhUnlPM2FUZjlCTUIyZWF1V1pC?=
 =?utf-8?B?ZXI4QTg4Y3dUYVV6RnpEQmIrWitRRGM4dExnR1ArYW5hT1BxRlFHVTR1djkz?=
 =?utf-8?B?d2paVmE0U0xqY0RGdEo3aU5SYTZSQ1MrLyt5elc0N2FodTJ0UmNCTGRBNjhO?=
 =?utf-8?B?Z2NSTlFzT08zREhkcENnMHJPYUJKRVNvVGROdVpYa052ZWlXZ3RpUTk5R3VE?=
 =?utf-8?B?SG44aWVJb0EzdFU5VGVMb0hUeGd2TzZad2VRVmlBNHg0WkZqZk9XSHRFUCtz?=
 =?utf-8?Q?Nt2THjeqvFInPEkDxswgTvJMUe/LrFsY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxBeVFYaUdqTzBvZTJ5Wktld2VSZ1VCRVR0N01Yd0ZadzBEcUc2TmhET3h4?=
 =?utf-8?B?L05waEtJVnVmZTU3YUExL05YSmgwRExuSlU2S3p3aHVFSjFLTEI0WE1LS2JG?=
 =?utf-8?B?NThuZlRJb2lnNnpDdnZEVHFVYnNWV2dvWXB2eXpaQ1M2ZTZGKzg4bG52aWFT?=
 =?utf-8?B?cEMrd1dja3NuWWlUK1l6czJkSFl4LzQyZG9ZYllZRTI2a2RNWlcwaUpyRjFk?=
 =?utf-8?B?b3NRYTNlTWpMRUwxVGNodXhyQTlHdG9yMkd0T28zemlEZVNsTFAvMWE4OEZH?=
 =?utf-8?B?UHhhaHlWYzExWmovcFlkTjE4Zm5jOGxSaFlnK2lYbFVEUEZJVW1COXdBVzkw?=
 =?utf-8?B?KzA4Y09udTl2VG9xdDB1LzQ4U2tRYWx0QlpiaFVxU2tPc09GYnRhKzZId3JJ?=
 =?utf-8?B?VXJmcGxnMVcyY1QzM1k4Ukh2QjArVHphLzBmSElLdzBZL29DSDBLTGFXQ3JO?=
 =?utf-8?B?c2hKeXpZWm5BaFRycnN0ck9iOFNNYUVhcHBUTW56WkRzTWhZZmZnTmdxQ0Zp?=
 =?utf-8?B?aHNGVVhRL2cvOUxwMU5haElWK2loRWkxL3Jkd0hYT2U0QXZ3ajhwSXI4R0N6?=
 =?utf-8?B?UkdFSG1IR0ZnNm1kRjAwUGR6ZStGZGNvSmlDR0ZKcjIxWmtUOUtmaHh4bjJt?=
 =?utf-8?B?eENYVnVvelVreFZ2Tk5XdDhpU1NweTJlcC9uazBWWXNURkFvMEFUaXR1MHJl?=
 =?utf-8?B?c3JYd3VFSitLb0tHRXFIVmYvS3Q5bDBOeW5LSkxGQTJGRWMzd3c1SXBTamc4?=
 =?utf-8?B?c1ZmZmpKUmhKVGg4YUdSR3JQanNyZ0tBY1JyRDd6ZkhCdlg0VVFYZFlpQjJR?=
 =?utf-8?B?cm8yaUJqOEp3cG5tVGRjRlNWd095VEV0MUxTcjNNYjVjMHJZZ05lYTBGVDdj?=
 =?utf-8?B?RjgrQUpmY0hZd2xOVDRLZzJzREJ6U1ppWlBLdjNWUVVEbkJZcW9JOUptU2pC?=
 =?utf-8?B?bW1aSERuZVFiOWllT0xhSXNWM0loTlhQZTR1VURlTTUyWEU0MzhoZmhmMlNF?=
 =?utf-8?B?RDBZZGlKd3hRWUgzSVpFSGRBRzNTUDVhd1dLU3MwM1RyWklQWU9nS1hDY2lj?=
 =?utf-8?B?bDZBOXI5UlU4ZWR1OS9mVFZnK2x0djNsWGVGRUFHQW1sYk5HMG9FQVQzclU0?=
 =?utf-8?B?YWNyVmNVM2F2dW10MEhEb3BTQ0xMVG5HcXYvQlJadVI0OFZJQjI2M1hkVFh4?=
 =?utf-8?B?dXJUWEJOVU1RV3N2M0dZV0ZrcUZPak5HM0Q2b0UzY24yM3p4RlNjaXlETzFm?=
 =?utf-8?B?WmNRWjFLWW1WKzlRZTF2dEZ6UXRNWEhDRFZKTGdZT1ZGQnNtZ2JOTFgzTDVC?=
 =?utf-8?B?Z3FPNEFhdTIwL1RLSTZNblNEYVFCTm5Ua3l2a3lwUkpocEJheENnRUJsTVI0?=
 =?utf-8?B?OWczSXBnMzlnRFZUaTBFRVpVZmFxRUx2UFBvZmZBSWUzVXFTd3Z1VEdoaDFh?=
 =?utf-8?B?WHh2aitOUm9aOXlTVGlqZ2FjbXQyRW9qZTVDN0J6aUJyZkM2c0gxaEhLZ2Yy?=
 =?utf-8?B?N0FFMm1HdGk1dHh2MThyalRhWW5yVVBkdklaYmZTMkFkNExVZnVMVFh6Vkd2?=
 =?utf-8?B?WXZiQVk0Nm5qWVdiMWdSWlQ2OExQbHRLVUROdGpWcmxsRXM0c2grb29MQStX?=
 =?utf-8?B?bmRlYVZPUHpCcnBUK2lXN253WlN0T2N0Z0dVeHp6K3BpRFA1YUFBVk1nZ000?=
 =?utf-8?B?blJ5S1dKSjBkU3FBRjRWZUJaSDB0Rm5vZ2ZLRnJ1d0o5Zi9nbmRxT0h0bFRS?=
 =?utf-8?B?Lzhvb1FzMjVVVXdmTXVhVFkweitrb1VLWnpOK3J0SGhPVTZjUXFXWGlZamtS?=
 =?utf-8?B?dEZ2alBnbUhDbjR0QlNUeHpTSnU4RjZRY09mcE53enB1aitDN25acEpDdjVk?=
 =?utf-8?B?R09ZRjFqTm9tK3FUSG5TMDJ2aHZHMFphWHoyNWRreUZyKzU2dCtySGlPR0hz?=
 =?utf-8?B?a05rSy9sZWxid2l5b0J6RnBPNjVXRFFNVEVDOU5MZm50TnlRWjFWL1NLeHBp?=
 =?utf-8?B?eFpjZVk0Yk95NnlySk1EdlZDZll4dmFralNRSmFtS3FUbFptakpuV25MbFl5?=
 =?utf-8?B?Z1RnSHNZZUJLam13L2tsMHpwWXFaZ2NsUTRENDlQOFVXMGVyRTdGdzhMRmdU?=
 =?utf-8?B?VHUvNGtmaEdTS0JJZ2xVTjVGYnYwMVRDVmNzSkFZZW9UTEU3UVJ1MlJlSmsz?=
 =?utf-8?B?Tk0xMnlhMnJsYjA5anlGMkorb0hGV1FZZWU4K2xjWHBlU05HdVFlTmE2ZVpD?=
 =?utf-8?B?NVpPYUJHa1B3US9SZmhXam93b204Q1k0L2dCK2FXTnRxSzJNMHNlNU1EKzV4?=
 =?utf-8?Q?p+QQZrZf/YWa6gEFWL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8dc3c2-59c3-414e-36f8-08de4f5ec9b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:09:26.6007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5lqDfNmzzzav2bWqr0YDXXVaXdAt3WtljuUJva7IqOaayYbNdwqpNvkNP3xnRba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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

On 1/9/26 09:25, Prike Liang wrote:
> Validate flush_gpu_tlb_pasid() availability before flushing tlb.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

This patch set needs to be re-ordered, e.g. this patch here first and then the other one.

Otherwise you have a state in between where it is broken again.

Apart from that looks good to me.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 6d7b8bb953ae..0e67fa4338ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  		return 0;
>  
>  	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +
> +		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> +			return 0;
> +
>  		if (adev->gmc.flush_tlb_needs_extra_type_2)
>  			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>  								 2, all_hub,

