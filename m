Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84ECCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 14:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C8710E43A;
	Mon, 15 Jun 2026 14:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CnmZD8c";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D4410E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 14:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEnRaXZXSzErJ9MAr79brdq5WGySwnRuMXaMWve02NuP7ueym6UyeR1KoBxa4YBcrxXr3sUHXr684k+DgOrylUhjiq2AK3ryEvLrkQDSind4OKxyYjh2Xo8FC+rAfDPi+36RVy8kQIbjShBLQmb1EkyNzNQb7VVY7xE67W0OiBUZCtBaAZjXBSFYQtc8th9sHxmkdfKqHpS2W6H0YxMh0FG4uYXw6khjzwS2uAA8Kq6gGmHeXFTPzXm2hPHlFPcvZDkaSobNwB/nJfC/cdIKnGWIJrwYnIOx+HScIsWB1B+nfYkAoQXfdvMIOcHBzhcvI07Ou7EsGuy1rJqcssVDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XZq+d46PBdxJHrbu7aZv4U+yJbqz+eNkGcXdR1nzoU=;
 b=WUh0Adv01FfPtGoa2LxD1oSKroCZMNRcB4Kc9D0zfd8F2vEiOgsP6bPzB9XcV0hMyrTdZfswM7w9+zhX2u+9UMkRe8ClfSICmI52mjBlFuZE3jUiQImAfybhApWTi6whwk8DHIAfxr8m1NN2wNBuDdF3BL0QynQ5ZwtqYxWn2dcFKK5iajd4Mimw32/0fOBbiknvFRphJl0ctJ4rAn/NSVxR+pSqM9+5PvNUEX3cDEW8lxyExF48hzLNxRpzSYmfZc5Cb1pmqfJvOPx4wZQUaWzzcosZFQunKy7jRorrClHvo05Mrg6v2JMH881eKWEhOCrEh2tiYPrmncBQP3ItyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XZq+d46PBdxJHrbu7aZv4U+yJbqz+eNkGcXdR1nzoU=;
 b=0CnmZD8c6nDkjV3pZVTJJG+uCjv6QPdJPurKHcOrkyZq2S9C5XPvim2fgTl7aCZnRkKJvVi+tA60c+/m9bI+hsMC8H1nB84IZcF2REAme+c+va8s5goZ9GK+wa/rB03lolbjHpmX/A1IwAE1oMgLxBeH3Ohgu0asIjmd0OUZhWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 14:02:04 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:02:03 +0000
Message-ID: <1d841be0-708c-4c41-bb2d-1332742ddfda@amd.com>
Date: Mon, 15 Jun 2026 10:01:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix SDMA queue counter read on non-gfx9.4.3
 ASICs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20260615111755.3597404-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260615111755.3597404-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:610:51::22) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 442f5366-dad9-4557-8d54-08decae6ad66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9TO4d2kiaZ0qzzP5/RZzjzp0rf3AE6hALJw6SlgDuVUF08seV4N6Btgav6WAtiXdbYN4nb1XsTAKz1DAoEIf4NwWI6XziNlhi5vA/ZuPGv8rKFgLNnqBIPWP/aPTl+8qU2BuRUY/yz1b0pZnau3xpGBFDBHOCqMCcM3cfhWpFmDbdQdxq26SBOcf9dkzoIXaYUdOBXrm/bKZL/7amqKPhioWA5SSyRBcsQ/SRXZ1RSaOnCOCg8h6C/mF/eoHaidQLk3iBthBrCuejJL2OqPAA2HsgwCns1frBZ8ynu7fwknPnafuhcxEhmWJ3Pfj/3cTyJ+wz25gg1kR0OM4+p9D9UZO3dbGzBkBLn7HV4TXsSHci2MfERXNBDW9CFK/UOuLAbuytXh5v6TKoxOI1IiO+Xu7dHESJBIFreCy1LLN5jYU5nicCILUZWSQIGX/MhdA7S1c2vh1LgyBgWdiS5pOvqRZ01JGAVJpel1L/tCfdKMWmQU68Qw7sbO79Reveyn7mgfRLGcQ9kV1eWaxBnY6kM9+G68IpLKz7RNDwufuFSXr850XqaXF1ybe6Ie37XVii8nu0a4Mv6wJjEucX7AphLajC5X/ScVn1K3lp6/OytRlmkjxpn4zmBsD7HgFvfHZZ4oG5+uX3iVG5IrKQbnuLyjdl0py0VWAln7VLXXNO4nQk/sf20DD8r4LzXkdroVc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzAyVktUZ3R2a0lPaHVJQlhEMlpKbnI5TmhNOCtybVBFVmtPek9wYW1md3Nm?=
 =?utf-8?B?Y1NBaUx2czR4a3UvVm5WTkFpQ0JZYTdkK0t4WDNpU2d6M212eG4vcXNiZlNZ?=
 =?utf-8?B?b1c1SmZ3Ty9la1hZN2xPRkMwUW9PUlZCQVp1OTFjTUtieTFVc28rWlNqbnhB?=
 =?utf-8?B?OGRaMUN0ekQ4c0dSU0VhYUZDUTZjTUVWMjF3KytqSFBneEl4emJmS2hIOG9z?=
 =?utf-8?B?dHBkR3JaMWpZMmp4NmlGWnNEWk5WTExNdUMvR2ttdG9pdmJ4aVVvWnBGeWtx?=
 =?utf-8?B?a3doVncrWDBiV3k3cUhmekJRTlRobWVGdEI3TWozY0YrWEs4bmFqTE90UUdH?=
 =?utf-8?B?M2JMbGtQZ3h4WGQzOEx6OGwvN3Y0K2QwazJTekdRbjlDYXFVUzdRcDV4ZnNN?=
 =?utf-8?B?eUJhMW1SWmJpYkREdDUyS3NqWXhQazRBUkkxSTlLM0NobHdQTlRaTEJQNU1H?=
 =?utf-8?B?TDA5Z050VHVnaFJkUU4xN1JjQmsvVzc4dTJ3bU1ISVlyQzd4OWt0Nnlma1Rs?=
 =?utf-8?B?UEhtVGI5WXZXdXp5K21xR29UNHpUeE52RWdvMXpabE5Kbko5MjZjSTJpVmh4?=
 =?utf-8?B?bzNYVDlIN3FJaFY4OVV6MGg0N0t6T1IyaEhMTGE3LzFXMXcyWnNhMU9tUFdo?=
 =?utf-8?B?UUI4WTNlRndUaGptZ0xtb3BjSVppekRCMXFVYWl3c0ZUMUdFaXM4SGNOODFw?=
 =?utf-8?B?SmxVREVYMTcrTDVvOFd6ckhlQkIzK2lBOW1vM0R5cUJzVzlnNDgzYXRVK09L?=
 =?utf-8?B?ZlBNc0psdW15S1UzTDN1bVREVmFGQUo1SmRFNTBRTVVqY1cxUGExaXRYSFdu?=
 =?utf-8?B?eXg4NG9reHNtSktYd0s0b0kyNW1wZnpZbGxZbXFJZUJSTlYvM0l1cmxBdTJq?=
 =?utf-8?B?aXNMZGYxb1VzSkNFTmZLTzhlTEVkTTZtSDUyMnd4b3Y1WVNpSTBoYyt0OGVM?=
 =?utf-8?B?RnU1SDRGS3BKclVSMFJGRnNvZGZkQjlBS0JWMUVXK0Q2ZU8rOXpYQ3MrMzRY?=
 =?utf-8?B?R2ZmR1lpbEdtM2RMdGloc3hySklKNC9RcTYxeTJwWjVORjNGWTVHT3BVc2wv?=
 =?utf-8?B?MTB3RWlQQjArN3FaMlFKRStJNnJ3SUVjWFhKaWlVNnFTakR3VHVqOTcxL2Rm?=
 =?utf-8?B?SFlVdmVyZGxlaTV5QnpZelRGSENjRU1pQXNYbUdzVjVWajhqekVTa1pTNVF0?=
 =?utf-8?B?UHFkaFJEcDFuR2ZOQmpCQmdCT2NhZ2JqRjBLQWxkeXQzY0xGeXd2dWI0aDVJ?=
 =?utf-8?B?V0tIL0hJR1Z4dVdXTDYvUU1IdlNDTTZjZCtwUS9SSWZUNjJlUUpwK0lNUEdt?=
 =?utf-8?B?VTA1dUVOM1RUWmUrWFpZTDNIMloyQUNHdytxSnZyMHJyUVJnMHljMk4rc0hj?=
 =?utf-8?B?RWdxTTdCVHRPUlYxc2ZYdk1sL0ZpZjV6U2x0VnBPTWlLM3FxSkRyZTFlSDhN?=
 =?utf-8?B?SmVsTi9wbjhraC9UaGUvbVlzaTdHRnBIYjY1eUNvTVVpRStReXpEanpmZmZv?=
 =?utf-8?B?bG1MVXIrOFc0NGovSTVtUkFFdlJsQ1lmSkh4Uk1GRFAyT0FHZkFXZGVpZ1Q2?=
 =?utf-8?B?VTJHVGVEcUttNXRSa1RPQllZbHB4bjJXRmtrcmpna1dYaDdVYXhYd2QzbS8r?=
 =?utf-8?B?ODJFS1IxTU5tSTI0QllOQmgrOCtZZjF6Umx3dFU4L0xpMFI0VWtjZzdHb3Bs?=
 =?utf-8?B?U0dLMlNJYkZNemRMUWJ2Z21BZ25EU0Npdy9uNXVFcXJXcUcvNWQrVGZkZXJV?=
 =?utf-8?B?OG4yTmNvT2VkcXNNeTFFaUNiNnBMWlBoT2p4a0pCWWtyY3VtcGZ5RC9Ib21l?=
 =?utf-8?B?bkRHVG5IZ25RNnlhd2FNL3MxTkhFK3lSMEdvZGZXaEMxME94cnJ5Ni82cFR5?=
 =?utf-8?B?RnIvcisvSmk5Q1lKWHZWRW5HY3FiRjRpaU00dkIyM2JKaWdQNzBEV3pIWng5?=
 =?utf-8?B?RU5tT1l0QU5SSTZYUHF5UEthT3VaY013ZnczQU1nUitBYjdSQUVWbVYrdzgr?=
 =?utf-8?B?VDRmWm1tUk1NVHhZYzBVOGNtRVZXT2pNRnlzSk1ocTkzcnUvUzJ0U2drUXMx?=
 =?utf-8?B?amlvRk05UUhGQytGam9vOUU4WWFwM1VKVEF6MG1GMXF1RVdBYW5NL3haTERs?=
 =?utf-8?B?aXFDWUZKMDBaSEZGOWQyaHRPcEZMQUg2WHNzZ21qZmhzU0pWS2hRaVB5YU93?=
 =?utf-8?B?L3JCU1NxMmxVVGhVWXVpS2JVOEtyd2hkNWw1aW8rWHdCU2dZaDlCdkdEMXhU?=
 =?utf-8?B?Q0RURHlPNXJqcmFMZUdsTGpQdzB5U2puaDFDWHVzRGhoN1ZwZktaK2ZETVR3?=
 =?utf-8?Q?uqDGrgYi7UO+nwb+8f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442f5366-dad9-4557-8d54-08decae6ad66
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:02:03.7020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlLb/zkTgEROQNEGkyBrBXLvjNCjfWejpUGSwv1m+6jPI5u07YCOJ8xDXwsrA+jraCfkMOL8Q9jYeL6G8yTTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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


Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

On 2026-06-15 07:17, Jesse Zhang wrote:
> The SDMA queue counter read was dispatched by GC version: anything newer
> than gfx 9.4.2 was routed to the kfd2kgd->hqd_sdma_get_counter hook.
> However that hook is only implemented for gfx 9.4.3, so gfx 10.3, gfx 11
> and gfx 12 fell into the else branch with a NULL hook and got
> -EOPNOTSUPP. This spammed "Failed to read SDMA queue counter" on every
> SDMA queue teardown and left sdma_val at 0, so the per-process SDMA
> activity accounting stopped working on those ASICs.
>
> Dispatch based on whether the hook is implemented instead of the GC
> version, so ASICs without the hook keep using read_sdma_queue_counter()
> as before.
>
> Fixes: 0ee24cad5b35 ("drm/amdkfd: add sdma queue counter for gfxv9.4.3")
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++++++-----------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++----
>   2 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 53415317ad63..7ee10fb0a8fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1027,17 +1027,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val);
> +		else
>   			retval = read_sdma_queue_counter(
>   					(uint64_t __user *)q->properties.read_ptr,
>   					&sdma_val);
> -		else
> -			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> -				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> -					dqm->dev->adev, q->mqd,
> -					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> -					&sdma_val) :
> -				 -EOPNOTSUPP;
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> @@ -2675,17 +2673,15 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val);
> +		else
>   			retval = read_sdma_queue_counter(
>   					(uint64_t __user *)q->properties.read_ptr,
>   					&sdma_val);
> -		else
> -			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> -				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> -					dqm->dev->adev, q->mqd,
> -					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> -					&sdma_val) :
> -				 -EOPNOTSUPP;
>   
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e0b885b2395a..f280c3e41ea6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -192,15 +192,13 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>   		val = 0;
>   
> -		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> -			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> -		else
> -			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> -			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
> +			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>   					dqm->dev->adev, sdma_q->mqd,
>   					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> -					&val) :
> -			      -EOPNOTSUPP;
> +					&val);
> +		else
> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>   
>   		if (ret) {
>   			pr_debug("Failed to read SDMA queue active counter for queue id: %d",

