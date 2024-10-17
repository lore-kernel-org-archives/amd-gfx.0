Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE8FD3C526
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 18:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC7C10E894;
	Thu, 17 Oct 2024 18:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DIDtrTvB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180DC10E20E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 18:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCnFTuVAd4RKr7zLJjoaHEZT3LlHQeMx0ugKUwosYKBhmJ/7EsnLk9kRQptmNanZdEnqLUymNTHdD+5Mk4q+uEsx67aFXV/d9hEJnFWDdsP/xPhbWgTUg/jJ6KY5ddQuDv5dePB89cFdwtRkzvwl1I9B1Nsh0U1PgnM7yeYN2jOgUABddfpFmn3q4WIM8vlm3nK4FVj+5RL/Vm1XV0u88PkEkoOVtMlwqYk4vQp+7NGvH9BnQCCgW5k7tAgHxjY7c3uNNtWRJjdIpEz/1i07CyDAaV7R++QM4xghhMaxvcn09Ba57zkmFLmhOL91Q96+vrll073r9RU5dAJA5hMYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlBfmSqlBh9NmINIwqSfpQLHcQ/r58lXxksd1UX3v6k=;
 b=T/SqWu8qOvdkO7P/a8L5YqS69j13WhzrcIWXEMKXPkP52rBoXgUuqjcV62MQGtBlyKxokG9rga8KlGxAeF9yQiCpS7gbxjp5jFbV7FRHBTYgVdco92Q2Z99IsBE+/aZlh5Km/kkubaMW2v/0Gr2Nx3fuZY1nfHeMipxDF4NMj6c7GjaYcsMTywriJ9Xrto9whiHSZLkDsnHmOyuqfaw2DakaVj7wJrAD/jlX9ItqGWf+W5o9EG7e/poKFD7rNso38b5xRJu8nV8Wwv4LNXAwVkqokQreCjDg/pjFZy1lpvryOwVxfBSZA0wlLdANyUP1kD1YGcFzk35ckuidGAy+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlBfmSqlBh9NmINIwqSfpQLHcQ/r58lXxksd1UX3v6k=;
 b=DIDtrTvBlFnVw+RUwhsPivS/elbo/VnfbhMo9UWEN9iNcBIYYsQM31EWrkmlH5FglFx7ApPNx0oJMwJ3uRhwbaU/MpPtLkhLoTD/gYuhIIEX4K6FAdJvc2zfgoXEoGJVKU8hdMK/3aFmhxXIcU4g0kdlzW+nH/paxQoc/14L8oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 18:35:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 18:35:07 +0000
Message-ID: <6e1ac30b-1e69-4faf-8f6a-85c80e15528c@amd.com>
Date: Thu, 17 Oct 2024 14:35:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
To: Shaoyun Liu <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241017161216.739111-1-shaoyun.liu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241017161216.739111-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: f79f4b85-cc4f-44c6-ea92-08dceeda6ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJWUDd0TENrUDhMRlpPSXVTbmNIZkJBSjR4N21ucVRMeDloMjVkaUVNRTc2?=
 =?utf-8?B?aGo2cTFXdExTaWxmdVFxblZ3YTJwNWlUSDdTY25PaTZoNU5qWk5pZzNQOFlz?=
 =?utf-8?B?Uk5Kc2FpS0xEQ0x3OFd1anpIWnRQVkd1bEZ1b2t1YVFUWnYwaUpCN3VmMWx4?=
 =?utf-8?B?NEJIejIyL3FsaC82ei9WbWwzM2JpMGdoaGpSN3h6NnNlRkRoTUxjcFZ0Z1Zz?=
 =?utf-8?B?aEVFYW8xRE9uTkFZTW5vS3ZFMnU3MlF2dFJyaGNObm8xd2MycFFSdUZ6RHJh?=
 =?utf-8?B?NGlrV2c5ZWdPMDdlbnVQZDdsWGFlWGpDTG12U3hHOTcxS2U4dU5nYzlTcFJG?=
 =?utf-8?B?dUZlTnNROUN0bk1kTlBZZzFiSk94UmdxMlpaTW9ha1MrUFhZa1lxL2hxWDNv?=
 =?utf-8?B?a3ozR1d3THcxRmQ0dWhNWm5zMFd2UEhSdmFjRE40cHZNdDE3TUlQMm9vTXgr?=
 =?utf-8?B?WW15c3RBOFJadFllcWhSNE9YWVRYcnFLRjlUckRBYkc1SnVaWFVpR3hPS2pS?=
 =?utf-8?B?MnZJSDdwVUtSQVgrLyt1ZjNnRDlNRGlPM041NkVvOTVYSHJ6emtxRnNVSUl4?=
 =?utf-8?B?NHhnd29kOWtLY3E5M1l6SHV6TnYwTkt5cHFkb1EwM2RQZWJvV0d6ZXcvOW5y?=
 =?utf-8?B?cFo1andSeGRCRzZEcmxWdjR5US8wdE02UWFuOHlpSU0ydk8yRzBPblRLU085?=
 =?utf-8?B?LytNZnRHVThFMEdmcHlhK1EzVjlLL09EejJxZHBSMzV1RmZsTCtiT2NZZFdQ?=
 =?utf-8?B?SnZXMFFNN0xXN1Q1VVozNVI0NkJNOTJBRHRiTG1jSW5sU0xjYjNhdjRBenRE?=
 =?utf-8?B?T1BLMzk3VkNOazFBOVc1ck1LQnlJYzZkaW5rSkVwUW5tNmRiWUtJVFdJZXFm?=
 =?utf-8?B?b2p6OVBiRVpRR1ppaSs5aFl0bURSQ0kzNEthM2E5aUZrcGx6LytPTEt0TnN3?=
 =?utf-8?B?aUZaVkhCRTN2VFhTRXdxTm1ORzdSVTZQOFh4TG1NQlpXbVlLZENRSUtsR0Qv?=
 =?utf-8?B?TDdTcm5UWUNsajNmRGJTVzgxK1ZaWnZ0T1U4aVZiRmdHcDJFeFYzcmVYdUFi?=
 =?utf-8?B?Mm1OQUxlbTRSUXgzY0toZUVGbFhlQkM4VENvUDdwUEpMQ1ArRDlOK1pKd3F5?=
 =?utf-8?B?TGQyRDk5dEg4MmVTM3Awa09Tc21pOXhVM21xaHNKK2lsTDRuUkFBNk5FNlk0?=
 =?utf-8?B?UjdBSjNEZWpPVjYzd3JzV0dPMGdHSWlzYUI5WkJwaHFJMG5ScnJhNGNVOXUw?=
 =?utf-8?B?QkUwd0NXNk4xNjluUzBaK1g2MWltZi8rYlVoeENTM3JvRzkwSFF4N0M2NlpS?=
 =?utf-8?B?VXV4bDJzdCtiSGlOYTNMcXN3L1YwSG1mRE9vT2ZvbXJuYU9IWHMwTFZDM0Yy?=
 =?utf-8?B?Z0pVN3NTQTJKYklVYWVRZTZ5amZMZEg0OGdRTmd4QW9PY2NuYWQ5dERwWG5u?=
 =?utf-8?B?TGJHM3ZHZW9Qb3JCd2c1bHplTVVtOUxaVGxvVjlMVEdpNGZhcEg5OERZbi81?=
 =?utf-8?B?NGhqbkF2V3JpbkZMZUVMZzNHbnJuY1g1TDR5NEFSaWgxKzdaZVZVZHJFYXJw?=
 =?utf-8?B?VFNWNVZrRHdoTUZXQ2lyMm1FTmdUOWt5OHh2NTJydlArWmJTbmxoc25ZckhZ?=
 =?utf-8?B?ODJQR3g1a0hKT2lQd3NnUFphaWtraXVXaHN0L2FMUXRoOVBKdHJ5RTg2WnJy?=
 =?utf-8?B?amRnc0pLanBIK0VxSjVmUFcvMjJ6NTNKSXdxNjhEQ2pZdlBXUncvaXAyZ1lr?=
 =?utf-8?Q?qsSS5MnJ7lOeRVOZL42H1U8lomQzCTmutCynztA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXMyMW50M1VRcHlGL1RTQmJPVU9lRVJMZFZ4UlY0cG1HTkVxWC9WRjdhQkVJ?=
 =?utf-8?B?RnFrbng1TWNBdjFxcGJPR3Q3dHpLSGJDUUJLZlJHcHp2VzlUUW16Y1R3RG8x?=
 =?utf-8?B?dFI0NkhUdnIrMUdacnNHb1Uwd2lNL3NaeG9ISFRFaStpUDNuTVN1N09xUDlE?=
 =?utf-8?B?TFRLcWJiTWZSRDYwa05UZ2JHcWdKT1YrL25NVUVqSEloUTBmSFhWOWZON0dk?=
 =?utf-8?B?SVdxQlBWWmFRVGtLSTdVNVdocHA2UmNoWTFvVkxCbUdSUnNrQWJQMk9FZWh2?=
 =?utf-8?B?dkZkNlA1b3RLUWhlaWJycGFsNUdHeGpYTVo2aGY1VjU4azFiMDdkU0NxZzVz?=
 =?utf-8?B?RWhjdCs5WDRHNy9OWGtGUURyOFdENk1jSDhQL0I0WGdsTVZtTkxwL25BQ0lq?=
 =?utf-8?B?dldsbkZmNGQzMFFtWHJKMkxReXhOTmFlbVNCQm5vLytBQzk4bkRNOExoVHV4?=
 =?utf-8?B?N3hTaTYzUVVUazdHbDJLNlBGRGNXa3JQRzNaMVgzWWtUYXM5N1hPQmhrdnFa?=
 =?utf-8?B?TzVrYlpWemx5OE9iTm85M0VtMk9jUm5rVXVEaXpqbGR4VEtoWlk1dDJIbDlk?=
 =?utf-8?B?akE4TUFFUDNpT1FlSm53QzBndC9HMEJjZXhXQVhQZjlidktsdWRwWERHSVQw?=
 =?utf-8?B?RFpZOGZWMDVzMnI4dkFGT2lzQ3lZK0VEcExmMlZiYmFxTVVMaFliYkhYeDBM?=
 =?utf-8?B?LzJzTk5CSjF1QzJ3UGEwWVN0aDZJbklnbnpyVHl1eVdDUnR1OHE2WklQdWVE?=
 =?utf-8?B?MXdUZDVVVXdxeGNZeXByOW54OUE3dmlTZThtQmVZQnRUTjh5NWhqY3hYUnpM?=
 =?utf-8?B?bHVESUhMbE5adFAwNmdjMDJHdWdBWmF3UXpyaE9oSnkwd1J2a280OWNOdkg5?=
 =?utf-8?B?ZDJoVXNkOGtqdG5YVDdWUEVCU0RjdlMxL1puNTM1MjNWdEtkdTYrZzhjQjBU?=
 =?utf-8?B?aW95dk80dkh4dzcxYVJ6MTdsTVlnczM2eDVzQUFLVDVnOW16b1pMY1l2QVlK?=
 =?utf-8?B?NVpQK0ZqUlBTY1VOTHhWQmFXTnlYRURZb3oveHk4VldTMTFHSUlmbnNsbTVS?=
 =?utf-8?B?M0ZHSTlzNU9sajBxaTAxRTZSZmxUWHp1MVJ3NUdsN3Y5TE5uL1dNUjBXUnNC?=
 =?utf-8?B?R3JENjdvSWNmckkvL0dUOTA2Z3RZN1Q2SFVZaUxDajlWUzFpNS9RM0h1Mk96?=
 =?utf-8?B?Y0dtV1VmUkl3MFJKc2Z5NE5ZazdVOTVHUTl0Y3FibTgxbGxiZTlCZFROSUdv?=
 =?utf-8?B?R1cvNEpRbDZreEYxdGpTRmh1Q01IOCtZdWJNVHloTW9BTTEzVXFyMlU4blY4?=
 =?utf-8?B?NFR4S2psWTFlMVJmcWR2M1N3YmI5aDhkTUltL3BtL1ZRS2ZiNHhkVzhwUmZi?=
 =?utf-8?B?ckZDbWRBOFl4cVg2VE5xeDhrbDk2WXFlTWphdzlwZk9NS1NoMFdhT0ZMSVZR?=
 =?utf-8?B?VXF2Y3VNckRiTGJwL3dKZzh2NHRzTmJyc29lUENCY2luQVV3UmVGK3QvejJE?=
 =?utf-8?B?cWFlK2hLQVJ3R0ZHRW4vd0p1eVZibUNCZElER3Bsb21MTVhucDUvckkrcFhv?=
 =?utf-8?B?RGNHSnNjWVkzQlk3SlJ5M0tSTFBvbmljRzUrUTRIUlpYeFlQVkxydkdvN2pP?=
 =?utf-8?B?VlNQb0VqMmx4bVRldUQ3NHRSbVQzaWlOTkc3djhjcmdYY2FoNFFBNFY2c0Rk?=
 =?utf-8?B?V1lEV1RJQmYzVjFOTUtIRkhEOU9iVTN6amJGa0pzQkIzZHJoc3QxWmJicFdv?=
 =?utf-8?B?bVl4LzNvYVNKZ2paclNnNGZSY2xnM3pvTzdoTDQxdzdTYzhSSHBsU0NCR1FO?=
 =?utf-8?B?azRMZUNFbktVMS9HcThibC9NeWdpbnZ1cEFiZFMxTm1mYTI0TThObm9XK0Ni?=
 =?utf-8?B?aHhhbzE3ZWFOM2YvOXllbjJMK2hKalVPM24yNk1qYWRhV083eFg2YnpYMTlD?=
 =?utf-8?B?bDY0MWZhQUhkQWpmQTIwdXVicjBSQ1R3ckgrODlyTDBKZTZXU0NEQXRYb3dK?=
 =?utf-8?B?MWloZFA5UFlhRkFqbmRRVFBtWm9CeGZVajB6SDhFSzNpb3NqVFBNbXc4dTRM?=
 =?utf-8?B?b2JhOGxKblpDUXc4WDBpQlBRSmN0QTIxaHRsYnF0cFRybm5HSW5aQVlyOE1U?=
 =?utf-8?Q?0HSMW9Qwg7PRJSlHROzJPSSKk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79f4b85-cc4f-44c6-ea92-08dceeda6ce8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:35:07.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1jFspv6XXOt+j5rDKCOXJlTIHaimrOJXFGKzQooMg+L3n4W6/6Y7kRcNH/Wgmcg4Wnzv47jewx/TbfMn9F2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

On 2024-10-17 12:12, Shaoyun Liu wrote:
> From: shaoyunl <shaoyun.liu@amd.com>
>
> Add back kfd queues in start scheduling that originally been
> removed on stop scheduling.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
>   1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b2b16a812e73..542363b4712e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return 0;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>   	queue_input.process_id = qpd->pqm->process->pasid;
> @@ -272,6 +274,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return 0;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
> @@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return r;
>   }
>   
> -static int remove_all_queues_mes(struct device_queue_manager *dqm)
> +static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct device_process_node *cur;
>   	struct device *dev = dqm->dev->adev->dev;
> @@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct device_process_node *cur;
> +	struct device *dev = dqm->dev->adev->dev;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +	int retval = 0;
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (!q->properties.is_active)
> +				continue;
> +			retval = add_queue_mes(dqm, q, qpd);
> +			if (retval) {
> +				dev_err(dev, "%s: Failed to add queue %d for dev %d",
> +					__func__,
> +					q->properties.queue_id,
> +					dqm->dev->id);
> +				return retval;
> +			}
> +		}
> +	}
> +
> +	return retval;
> +}
> +
>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> @@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
>   						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
>   				USE_DEFAULT_GRACE_PERIOD, false);
>   		else
> -			ret = remove_all_queues_mes(dqm);
> +			ret = remove_all_kfd_queues_mes(dqm);
>   	}
>   	dqm->sched_halt = true;
>   	dqm_unlock(dqm);
> @@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
>   		ret = execute_queues_cpsch(dqm,
>   					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
>   			0, USE_DEFAULT_GRACE_PERIOD);
> +	else
> +		ret = add_all_kfd_queues_mes(dqm);
> +
>   	dqm_unlock(dqm);
>   
>   	return ret;
> @@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
>   		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
>   	else
> -		remove_all_queues_mes(dqm);
> +		remove_all_kfd_queues_mes(dqm);
>   
>   	dqm->sched_running = false;
>   
