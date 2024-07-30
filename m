Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF43C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 22:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10CD110E2F7;
	Tue, 30 Jul 2024 22:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IEvV+Xde";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBD110E2F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 22:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbqY4Y3VQKmXJxbe9yTgkr+k/aOzHKvVguILPCbKD7AzEfRElYjPla5vkVMNPIrnn4HaYTN0bREvWN0OvjDSGfRhLwKO7dR5PcW+6wXpX5KKbMy4sy3P2c3znJrErSS274A1o04YdsI/eX4/8PA37AwYrBX5HIh42FtitPByRCx/SgjmavnT6d1I82EGAv1spE1FVqBcAfCDOpTch+BC2+RBzCmqCc0BZJSE4fdLVivMjqhzIJF2EP+MFJLVuTICYKjC7a0E30MyL3TSB1mFTFDs47NID/f2DEDAXKFBrmkKo3f9orHzpD7pjTOyjR9JM8whH9U7gFd2iDgoiAoavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxnmwfZP1lQcV0B9gYRk08hEueJGAv/oCJ6u9H8fYZA=;
 b=NaWYgtAYwkpxoi+K3FDqFooXFUaHVJK7d8dD8KsvJRRh4atO8Xn9Ir9sv4DyWNwPQn/W7bbfdJL7Z5lBd8d0r5FQUYi/Q6ZMf1dQaR3HZrjDbzZcYNoL0LW/bia6QlS4qV8Ka3meut8RyCWJ7gAWlyu8SNV6MTNnxa0/2hj2By2AC1+qnegwhuqE4u0ZiG+2Pt+SCjanxod/ElIPRvKEz/K56412N0miW8ghuq5gWgXeN8EdQc4iELEWR4/ffkJvm0NeGO+caRTGoTjM5CTUr9nRnpEqBpsjsVNt70NiEyucniR4trC2SkKhjR+aodf/TyZG7rd31uglo7ZDwDQCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnmwfZP1lQcV0B9gYRk08hEueJGAv/oCJ6u9H8fYZA=;
 b=IEvV+Xden34b2rYgr74JOlC/23aPl7IyTzn6zVl3NEkwJHsGCxsilhd8HVRLaOMbvfyglld/FfCfqvGD47xAmukSmOuYDBeOFlwJAq1w3OYre1a+nS7EJy/DuVeuYaIerBIaMH2t2YMLDcxcFG+BNIjH0ExDXAJc6wkMSMDy6/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 22:16:42 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 22:16:42 +0000
Message-ID: <7b44cabe-2571-479a-9d44-1b44d1ea5a4e@amd.com>
Date: Tue, 30 Jul 2024 18:16:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: support the debugger during per-queue
 reset
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
 <20240726153049.1296575-2-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240726153049.1296575-2-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cc6530-2424-4973-68bf-08dcb0e547a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2lQbVdnUW9rRmN1MElFT0NVb2laWENVT2pxOW1XVkQ4YlJXZEpDOWI1Zmhz?=
 =?utf-8?B?TXpDT0QzS0taWDNJUllBT3VoWmd6c25KYWZMZVFwTm1FZWo0eVdoSjlnSFYw?=
 =?utf-8?B?bk1VeHliZVowbExXUlRQMEhhN2NrSXJMcXkvcS9UWFlON3pOOTRncUdWdTdG?=
 =?utf-8?B?MGlMYS9DamcvYjdOVk5mQ2FVK2lmcWRCZUZvVVJYTXprWWtoWEdMa3ZlUWlM?=
 =?utf-8?B?TUV5QlRYMXF3VGg4aXhsTE9YYSt6YjEvdVhDc3dmYXpEckdmY3dpS2pnSDZT?=
 =?utf-8?B?TTlLaUp0Q0QrMEJpOVFCQlhNdmZ6elk2Mm01elgvRXdVSUVTVHpKZXVoeXFZ?=
 =?utf-8?B?L2tFb01BUUxHMU9TTklSTTY1S2lacjdGV0RIclVtWG9IWjJ1M21Qb1ZVeWZj?=
 =?utf-8?B?QjVycWl5akV2UVQyUVkxVlU2ZFdBUGpCMGFDejVxLzRaK3VWV1dZRVZuNmN0?=
 =?utf-8?B?c1J4b3RsYmQwaDM3MVlENTBIZXp6S1QyUVNoRStOVVpnZVpZazdlSnZuWmY0?=
 =?utf-8?B?bFYrakpLM3hxTTJBY28ycXJFVkNpQk05S0FxVTM0SDhDd1llMTd6QlFwYTJI?=
 =?utf-8?B?aFI1eHVVdVdrUDhuT2RoZjlTbXpmTW1DbFZGTytQcGdsRHJQOWVlbFlqdDZK?=
 =?utf-8?B?VUdIc0UvOUFsdll6S1lnWitldmM5QXlFbG9iUk1aOThjYVNSSzB6aHM4VXZE?=
 =?utf-8?B?cTduVmZnRmJrNDRjMlZMNmdEQXRxcFliaXJ0bk4rYnIyaGpxaHQ2V2hLOGhQ?=
 =?utf-8?B?OWtRU0NhZm5kZi9oUUE0OTBPT2xWOWl3YVZQL0pHL2NVNWFBSVpxeDMwUkps?=
 =?utf-8?B?YUJzTVZJalRuZnhBbWJTb0xHbTk1RUh2aGRBWU96dU55Qmd0SW82Z1J6Q3dY?=
 =?utf-8?B?VnZRTk91VGwxMHB2am82TUJFY284Qno4TGtWOUcxV0djVnBqc1U4R0djL0FB?=
 =?utf-8?B?c2VUTjQ2R3F0YTlheHpqeGFhblAxckRpaDJDY2JINnhJbk9LaGVoN3FEQ1lp?=
 =?utf-8?B?djNKNmtrVTZYYWVXcGxVK2pWdUVYZHFmRHNUQVMvK0RSSnVuSHpEazRlUjJM?=
 =?utf-8?B?YUtCUXlXRnFrVjE4Yk1UOG50dE8yUVJ3eERiVzlCZlg1RDBJVldTTVZmaDNo?=
 =?utf-8?B?YkJRZ1F2dHYwT09jR1V6eFJBTnVVOVZWRThSWDRCOHNEeHl2QkdXaEFPU0RH?=
 =?utf-8?B?NVlmamN5OGRUbWM1N3dZN2ROaDg4UlN5dmR0VmQzQVNYL056dG1nM1hWeDZr?=
 =?utf-8?B?K2IwRG5FdUlrSTR6MVM3a3FDUkhIby96Q1AzdEpyRDZCeU4raXFqcUZpb2RQ?=
 =?utf-8?B?N1BSWnE4ZHJvc0x2UWs4WjdwOTBiNGZXNCtzTnR0ZjUwalZTY3ZyRUtkM3RX?=
 =?utf-8?B?b200dWxvMThtQWh4VHlBOW5lMjlYUUlGMWpFaHFIZ0lKQTBjeG5qUFBkZ21x?=
 =?utf-8?B?b1l5OFNCN2Yvblg5TlRvSGhNelFadlpmQjRKQUkxZzNwRTZIbXVja0ZQM2FK?=
 =?utf-8?B?YkNXeDNGZTliRWJxNTB5OVVwbHcwUUM4cjBsK0x6Yi9lVEpPd3VTY0N6V2Zt?=
 =?utf-8?B?YmRPcjYrNkR4RENCZjNxbWxiVGllN3F5RmxXNytYUFNkWnI4ZWhYQktDbWtp?=
 =?utf-8?B?SWx0OGluM3hOMDBWbWVlRHdCb0RkbmhhR2R0ckFhVEtXRFhET2tUaWNTMVJq?=
 =?utf-8?B?NXN0MzA0V3pZVVI2eFE3SDNsMXhBRGExSVhYR2JROHdicnFqaGI4TE1aenlp?=
 =?utf-8?B?S2lPUXdyS1BSY09XT2xOMnphWElmU0xSZENTOGpMSDk2dVpEMnN1elJSVG03?=
 =?utf-8?B?dEZHRzNOK0VkVXNGbXZYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9DbjJyZ1RMVDBVN2lqMHNKU3lYUnJJdjNReGZwTWN2RVA0Q0diUktPR3U0?=
 =?utf-8?B?Vys1VXNQNDdqUEcvTDExNjdHcWwrVFovSE1MYk53RjVVc09sck15U084U0Fn?=
 =?utf-8?B?Y0l4RVBQbGVzL3VFb2h1YnU3a2FJV3JobG9XVmJneGFiWTVYYXlwMGxBbE5F?=
 =?utf-8?B?K3c1R2ZDcEFFdFFZcCtSZmtuZ3hkMHNTeXY1RTBhaTJ4S29qekJpMGZOWnBE?=
 =?utf-8?B?Qk1OTXRQcDlFOGs3MFJKM3BSZFp0ZG9xR2Y0Qm02K3I4R012QmloMXRFTVlI?=
 =?utf-8?B?YkpoVmZYQzVKTUtZK3RIbGlLcVdjbC8xVUlXaDQ1UkVhZDVXRUhubStxVkFl?=
 =?utf-8?B?K3h6ZEowSzYwSnhoalMxRUZ4ejdoVFJXdVBWcnN0ZmFRZ1l4VzB5d3JXR0Nu?=
 =?utf-8?B?Q1dOL3dFZlVxMStaTHJ0SHdYRjlCelc2c2RoNFRHMkFZZk1yR2pkNW9oSWw2?=
 =?utf-8?B?K0g5Qk04V2hKamh6YnRBcDNpQjNLYVNHM0lXT29BZTZ6ZGJKZWZtTEs0VFlX?=
 =?utf-8?B?VXFBa1pMMGtpU3dlTUd3V05FVFpGZWhrdUxYeXJic082QUd1cEVOd1RPd1hh?=
 =?utf-8?B?VUhPM2haYkhFc3lsRnNwZkpCbElBTU9TdjI0U014R3VVNSswUWRpVVNCbkpT?=
 =?utf-8?B?ajhVSmR1Zy8wV1pld0JiaXRVeWVneVJpSjBlS01YNVVlUDV3S0kzSzB4RSsy?=
 =?utf-8?B?cGl3Y28yV250NUVxWnVqbTFxaEJBdWE4ZXoweEF2RTNwQlFiOHFKQmhZZVhQ?=
 =?utf-8?B?b1JQaE9hRWZTR3BncFNUdnBOTEJlSkxCN09OUEE2V0ZrTEdxTzlvWEFsR0pE?=
 =?utf-8?B?cXRvbyttaUpKUmtMZkRGZG5iYlpkWWhiSzhpaDd5NjFqMCtzKzlIVlpDOGFp?=
 =?utf-8?B?dTcza29wQmJLbStVZnd4NnlSL1FsWmFQUS9FL0dhc2tSY29jc2E3NkdpVFky?=
 =?utf-8?B?Qy9CSGI2UGFxTnp3c0VQTUJBUUY1RHcybjllaWFFT0JBVU5TcHRWRkY1TFdL?=
 =?utf-8?B?SG5NME5ZZEg5cHkzVk16NDdNTjdwTmg2N0tKN3ZjdnBhYktCanZnVXkvcHRy?=
 =?utf-8?B?RFZ0WmRlY2NEdGY2b0hUanUvK01ITDZZTGRGYjE1R2Z1MFFVMFVScWFSUk5i?=
 =?utf-8?B?ZGVzMFVUaWtqNWdPNlg4SEhTN252NFJhVHhHdU5XakwrbldRYndIZDZsZFlN?=
 =?utf-8?B?U1Y4c3FJSnNKelJrOXc2WVdOdGM0L3FoeXdzZjN2TThvN0Fmc0NoK3E3VmNZ?=
 =?utf-8?B?dHV5SFRRUDN0ai9LcTd0KzQraE1JOHk2dG1nWHpiWHVKV3M1WldJeGpJSFhQ?=
 =?utf-8?B?c253Y1NkSDh5ZmIvdnR5VTJWb1gzcVBVWEV1TE5hczNiVzVoQlI1dlBMajVn?=
 =?utf-8?B?RlVyRHluRXBtclJZaldqTmlEMUpwb21uU2c1VUdGU09pZ2pMWnVvaE5aOFNk?=
 =?utf-8?B?VTNuZ1FzQ0tXeGtDY1lnSHB3VFgvNTRRSEtpUWlzc0ZHdmhwVHpTMUxTR3lj?=
 =?utf-8?B?U1BKL09QUm5PR1NLRHJCQmFlRWV2RW9GeVJ5MzZWK2xTcW9pTmVTSzRnZHNG?=
 =?utf-8?B?THJpNmtXOG5CdTZ3MTYyVmwvejVSMlg0UExhWSs0NnB2UHFnYXFYaGlCUGpS?=
 =?utf-8?B?SmYwSEV1M1VzUHVVbTkxdlplUHVDcE1tWXBpTFg1VUYvY25rOXJLWW5FTmI2?=
 =?utf-8?B?QzNmRWt0dzgrUzlHY05CdFVybDJ3ZzBxZUVwTVgzcExDR2RJOGR6eEV5SkxO?=
 =?utf-8?B?N3dWUGdaWWxMeXVsQWlUT2Vjd2hLQnduNThzT2VGMU5DZm1ibEVtUTFkYlVO?=
 =?utf-8?B?dHp3cnI2NWkxbEhOWjNPbzluNTRIcGs1RHZoUDZxODVEN2V0OStZVjNBMk5K?=
 =?utf-8?B?aWZ2akhOdThSZUY2RkFWeDBVdER6cFR4N21wajFjbnF4Y2lCeW1vb2pXTG9Y?=
 =?utf-8?B?Yk9ZaVQrY0JFQmN2RHEyNU5TZWVFYnZVQlAyOG9LSmFIVTg5NGU0SFRMdlE3?=
 =?utf-8?B?K21WdExTQ3owN1VSNzRMeEI3QUpNbTFkYVRrNDIzTEhDckd6RzZFVEVyeWN1?=
 =?utf-8?B?aVdqbm0vTS90OEtyTFZEdDQyclZQbjQyV3lLZ2g5SkhhREFrUTRTdUdXUjRw?=
 =?utf-8?Q?uH6bBIZLajRH0ae9xKPOzSm+f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cc6530-2424-4973-68bf-08dcb0e547a6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 22:16:42.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ceoUGCEjcdN+HZAy/ks+IfBGeCPBO9zVk+KvigxqeQXc5lMiLnrOZnJaIPe9Kl8jEhEu5GqunVIOGigSVH35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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



On 2024-07-26 11:30, Jonathan Kim wrote:
> In order to allow ROCm GDB to handle reset queues, raise an
> EC_QUEUE_RESET exception so that the debugger can subscribe and
> query this exception.
> 
> Reset queues should still be considered suspendable with a status
> flag of KFD_DBG_QUEUE_RESET_MASK.
> However they should not be resumable since user space will no longer
> be able to access reset queues.
> 
> v2: move per-queue reset flag to this patch
> rebase based on patch 1 changes
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 31 ++++++++++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  include/uapi/linux/kfd_ioctl.h                |  4 +++
>  3 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e335703eff84..cb7b5bbf5c40 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -164,6 +164,10 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
>  			struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>  
>  			pdd->has_reset_queue = true;
> +			q->properties.is_reset = true;
> +			kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET),
> +					 q->process, q->device, q->doorbell_id,
> +					 false, NULL, 0);
>  		}
>  	}
>  
> @@ -986,7 +990,7 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>  {
>  	bool is_new;
>  
> -	if (q->properties.is_suspended)
> +	if (q->properties.is_suspended || q->properties.is_reset)
>  		return 0;
>  
>  	pr_debug("Suspending PASID %u queue [%i]\n",
> @@ -1007,6 +1011,9 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>  		if (dqm->dev->kfd->shared_resources.enable_mes) {
>  			int r = remove_queue_mes(dqm, q, &pdd->qpd);
>  
> +			if (q->properties.is_reset)
> +				return 0;
> +
>  			if (r)
>  				return r;
>  		}
> @@ -1967,10 +1974,14 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>  	       q->properties.queue_id, q->process->pasid);
>  
>  	pdd->has_reset_queue = true;
> +	q->properties.is_reset = true;
>  	if (q->properties.is_active) {
>  		q->properties.is_active = false;
>  		decrement_queue_count(dqm, qpd, q);
>  	}
> +
> +	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET), q->process, q->device,
> +			 q->doorbell_id, false, NULL, 0);
>  }
>  
>  static int detect_queue_hang(struct device_queue_manager *dqm)
> @@ -3037,7 +3048,8 @@ int resume_queues(struct kfd_process *p,
>  						queue_ids[q_idx] &=
>  							~KFD_DBG_QUEUE_INVALID_MASK;
>  					} else {
> -						queue_ids[q_idx] |=
> +						queue_ids[q_idx] |= q->properties.is_reset ?
> +							KFD_DBG_QUEUE_RESET_MASK :
>  							KFD_DBG_QUEUE_ERROR_MASK;
>  						break;
>  					}
> @@ -3072,7 +3084,7 @@ int resume_queues(struct kfd_process *p,
>  							queue_ids);
>  
>  					/* mask queue as error on resume fail */
> -					if (q_idx != QUEUE_NOT_FOUND)
> +					if (q_idx != QUEUE_NOT_FOUND && !q->properties.is_reset)
>  						queue_ids[q_idx] |=
>  							KFD_DBG_QUEUE_ERROR_MASK;
>  				}
> @@ -3119,6 +3131,7 @@ int suspend_queues(struct kfd_process *p,
>  		struct qcm_process_device *qpd = &pdd->qpd;
>  		struct queue *q;
>  		int r, per_device_suspended = 0;
> +		bool has_queue_reset_fail = false;
>  
>  		mutex_lock(&p->event_mutex);
>  		dqm_lock(dqm);
> @@ -3135,6 +3148,9 @@ int suspend_queues(struct kfd_process *p,
>  
>  				if (!err) {
>  					queue_ids[q_idx] &= ~KFD_DBG_QUEUE_INVALID_MASK;
> +					if (q->properties.is_reset)
> +						queue_ids[q_idx] |= KFD_DBG_QUEUE_RESET_MASK;
> +
>  					if (exception_clear_mask && is_mes)
>  						q->properties.exception_status &=
>  							~exception_clear_mask;
> @@ -3176,13 +3192,18 @@ int suspend_queues(struct kfd_process *p,
>  				continue;
>  
>  			/* mask queue as error on suspend fail */
> -			if (r)
> +			if (r && !q->properties.is_reset) {
> +				has_queue_reset_fail = true;
>  				queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
> -			else if (exception_clear_mask)
> +			} else if (exception_clear_mask) {
>  				q->properties.exception_status &=
>  							~exception_clear_mask;
> +			}
>  		}
>  
> +		if (!has_queue_reset_fail)
> +			total_suspended += per_device_suspended;
> +
>  		dqm_unlock(dqm);
>  		mutex_unlock(&p->event_mutex);
>  		amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 892a85408c09..192e3102c152 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -504,6 +504,7 @@ struct queue_properties {
>  	bool is_being_destroyed;
>  	bool is_active;
>  	bool is_gws;
> +	bool is_reset;
>  	uint32_t pm4_target_xcc;
>  	bool is_dbg_wa;
>  	bool is_user_cu_masked;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..4713f9a6796e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -875,6 +875,7 @@ enum kfd_dbg_trap_exception_code {
>  	EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID = 21,
>  	EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID = 22,
>  	EC_QUEUE_PACKET_VENDOR_UNSUPPORTED = 23,
> +	EC_QUEUE_RESET = 29,
>  	EC_QUEUE_PREEMPTION_ERROR = 30,

Do we really need to distinguish between preemption errors and resets? I mean, both are caused by preemption errors. The only difference is, that in the "reset" case we succeeded in resetting only the affected queues.

>  	EC_QUEUE_NEW = 31,
>  	/* per device */
> @@ -907,6 +908,7 @@ enum kfd_dbg_trap_exception_code {
>  				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
>  				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
>  				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED)	|	\
> +				 KFD_EC_MASK(EC_QUEUE_RESET)	|	\
>  				 KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR)	|	\
>  				 KFD_EC_MASK(EC_QUEUE_NEW))
>  #define KFD_EC_MASK_DEVICE	(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) |		\
> @@ -997,8 +999,10 @@ struct kfd_queue_snapshot_entry {
>  };
>  
>  /* Queue status return for suspend/resume */
> +#define KFD_DBG_QUEUE_RESET_BIT		29
>  #define KFD_DBG_QUEUE_ERROR_BIT		30
>  #define KFD_DBG_QUEUE_INVALID_BIT	31
> +#define KFD_DBG_QUEUE_RESET_MASK	(1 << KFD_DBG_QUEUE_RESET_BIT)

Same as above. If the distinction is not necessary, we don't need to change the user mode API. Just report queue resets as generic preemption errors.

Regards,
  Felix

>  #define KFD_DBG_QUEUE_ERROR_MASK	(1 << KFD_DBG_QUEUE_ERROR_BIT)
>  #define KFD_DBG_QUEUE_INVALID_MASK	(1 << KFD_DBG_QUEUE_INVALID_BIT)
>  
