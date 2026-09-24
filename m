Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1753CC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A901810E544;
	Thu, 24 Sep 2026 07:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiMS1xET";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230F410F37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awerfKz2tB2GZ6IpQJ4Ra8FqUQ1aQQNWVyMALz2O27bph8h+ynlN2GiejbwniTBgjO4ceJq5MftTeKnlzu1MSkU+4p8Nk/RXTkGHvJwFyWNjVPo3XlzRCp/nIjaBhTdEK7xgdgU0SBkzFFK+PCTaOxRDk9GOA+6PsMyfafisfFT869BTPrGyGNuYIUdP3WwiXL3OxXAAas43VBbIwIrLGKdpPpEh904D/mFBWR6dePckoawQkJDnDfdp63YVUiykQ9V0Hw22eMq3GEgpNSaH05M+gvfcuR+Kq3mGyvSRQt1GCcdonm661P5q2iBX239XAUR0/Y5V8qy+hedk3ApWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMxCYwhwNurCpmvDp4zq8Aai7qQhDavcPtF49n0alYo=;
 b=HjGqtchwZ7Zu0BR5puAaQv2NiVbHdPUtvE+NX6BfrS3r+Cw24/qwNTYLJ7/4cwfxESTUziP+r766NS96iZPMUWzbjV4n0bLzMCvTsSZxmrwSLkFo144d8n41N4TSmHs2UiTEIoQV0mqVv/W86OxuNvY/07Ye6GoTgdUxmeu1bPwOv9go2gD6LMjxA4ADomi4fZEdlYeDQElYTItSzA57T843qwu28rYL1IZFsmFImbBwWEPP9OmcVTlkH3XfQIRQVBXw9FcJKbcfJFqrmFK8ikLBkV9Cy3EWuZWVYNoKwyJyAGuMC+pSCx5YiihRLzWITgiw1ZbwIQ9ZYbmh3djSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMxCYwhwNurCpmvDp4zq8Aai7qQhDavcPtF49n0alYo=;
 b=GiMS1xETeWmDH+knbN48pDRUsIOCalkiD/XtBH38+nFDpr2i26F+NfbGvnuBpxPl33hVjGTzoT93VkicpoXDfFlP0PYd0WsBiTXZIeTDr6EXrRpFfbQiRH7a0561EWJxGVRPvr2yKyAL6/hlYulPy+l3xBlGDM9VlxfOb4gnEys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 07:48:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:48:25 +0000
Message-ID: <de02552f-3d93-4632-be20-b55e553038b9@amd.com>
Date: Thu, 24 Sep 2026 09:48:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] drm/amdgpu: rework runtime pm management for cs
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-4-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-4-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc72b67-47d2-4e58-5cdf-08df1a1036f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 0G/25C/+SoQ5yyHqzaUDBlxqMswm6pGHl3+7lcpDjU7e+JjY2NcFxuKrghFhXwZ4x8bLpfSDUGjLG8l1UFNGQ3UUGOCdwZZiApNCDD2dNJ+G5N0qv2MGRpdM8LZwISPjM+XdV1UUZTmwb3YFIBuFZJ74hHUlYAZWp/s1kYDZz9t52PdybPdP1RP/MS43G322lHUOyVsCqtzgTmNLLiQF53s6Xpj7UP4j8g/+hKvBOJDLbl8m807gVd/mse9/I5eVunSh9XCwmGuqNChvbfhrYa3curRFMG3MGMRuTkbsjtTLcnjs5Fm/egvIk+p1wswKBCj09TVTNCV04buGSLWBhU385z7kq9FvJiy2B0QIokJz1oESiw1Sg4e4R8YmwGPxag2PiQk03dwJnK2gQroXhe/dVcOJ3gZGhFi4GGyXkJcc6s8WfHQljKvFnZ23fJXyD2Or1v4712vaMb2EO9QnfXN3VfNFk43cXAOtR8/zyeJyn7zmhswZcc0eKj/N7FakQxcqOIDMpPXPz+m9b2uqEW8DhQPxR47hjrvxEpfkV4lgo5/cl9hChE6kdWaRoZMk/FrqBmM5CXRCyXuJeU+GEPYIIEOfE5+HE+tgYs4kIlAH+eFLNzX0UYx+ha4l3lZh90SeN3BwiwYwWTyJM+jc/xfZqaTNhUcm/O6Mle9QaRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklWdFhucCtaTHI0NmM3cTJaTE10SzAxRGtvaGMzL2s3QUtmSklnU1NuUTNP?=
 =?utf-8?B?aVBYemFKU0piNWlJNG40UURTODVWSkZ0RnZxcDl0bFBncjJsUDFxUElCd0JW?=
 =?utf-8?B?anB0ZER6SUtONlF0c2huN2RENnEwQXFPQktzVFJLTmFOb3hxdW12WU1rNEZv?=
 =?utf-8?B?ZWxyZUY5eFUxTEVNNC9FYnlhMGZtdURiT1g5VE5uU3FpOEQ3OEJuTThCSy9M?=
 =?utf-8?B?NnFuNzBvWVpPWi91ZHFseTA5Zm0vUnFIMll2MTNWeWxpQmtVWUFmWCs3dUh6?=
 =?utf-8?B?ZmppWkhpRmpKRHBGWlE2OHBaSHNZM2Zud09qdmpNaytrV2l4OWhUOVlUVGs4?=
 =?utf-8?B?QWNrR3NaTUZ3UEM2UEw5NXl1QlIraElPMWpYQ016emp4Yzg3UGVrMWh0Z3Z6?=
 =?utf-8?B?bU5uYkpmWUV5ZGVHbFFuajc4SEloS1FTTWNUdWVXN1Zzd21BZlhtbnhEa0Zv?=
 =?utf-8?B?OS9HL1p4NGhxdzdMQzZhMjJvK3dNcFJUallac1EzL3ErMEJEYStXQlArZkpV?=
 =?utf-8?B?cVlITTJqL2RUWmRVcnBpeE93YkhnWDVWV0h2ZjZFRG51OHV1MDJaV1FyRGEv?=
 =?utf-8?B?a2F5cWFmS1ZsbEt0RjhnTC9WYjhGQlRkMW42VU9sSmU3QnVpUWJDNklmcDBj?=
 =?utf-8?B?QndiTVZvZTR3am0yRHRsQ3ArQStmMDdUQTlMbG5GWmRoVWVZb3JPTTRId1I4?=
 =?utf-8?B?OHBnZG5lWnhOZjRVU2o4ZGQ0SlowaG0xOFlkZVV5OUJkenJTdHJiU05xbGxi?=
 =?utf-8?B?SFRVczFpNmE2amVJdXM0UEJNM3BDZ0NVZXl3bnBwZlozV2VOT0NJczZncUgv?=
 =?utf-8?B?Y3d1TW02WEpCVHJBdmc5UFMxVGFlb3pJS3FlV0h3V3ljQk9kMHhDMXhRRU83?=
 =?utf-8?B?M0ROV20vNmxiZ2t0RVJnbHJyelNSeE9aZCtYNWFnM2cvNEpSYlBvUkZRUUtN?=
 =?utf-8?B?eHNxWklXUTJmMnVqK2VsQUZCSldHdTdhdytrRnoreDBHYXVLK1dOazBXL0pC?=
 =?utf-8?B?WGI3NCtMVFdvL0tyWlNKemF1ejlEeHFJbHFDanRSeTF0S2twbHV4NjZKVDNh?=
 =?utf-8?B?RjlYTVZFUGxDYnVyMytlSjRYaGJZdDNkSHVrUHVnUjVoUmNJeVR3em15MGo2?=
 =?utf-8?B?KzdIa09DNkxZQ0FidXNkOUVIZzR1R29iNHRHaUpTV2ZsaDhIUHhvbGpYaUds?=
 =?utf-8?B?ck9iTVFpWkQrZmtxaGVIS3lIbU56MzdNVlFqVFRMemRpdEwxLzQ2WWZPeUQx?=
 =?utf-8?B?TEhZeFZCenh2aGp3eXNBSjBGOHRQK2laSCtTdmdwdVVGK2NtZWJtTjFUNE9M?=
 =?utf-8?B?UmR4ekFFL2o1bCtPSE40RWJ5UlY5OG4zalBsZ1B5L2ZvZlRTTVF6WXl6R3kv?=
 =?utf-8?B?M3VpR0tiM3VQMXV3MUJ6L2tKcWZ2Y05TZmVaVHdmRkdPT2tsNkZ6eDN3elgy?=
 =?utf-8?B?S2dPQ2o2bUdZZGJZQ2xUZkdwQWVHMjFCM0YxRExPbjJ5RUpZdTN0eDNJMytJ?=
 =?utf-8?B?bGxlTXVvR2lQVEp3alJteS9kVngyTmpWOWw1cnk0V21VdmcxNFJSZTZUcVE0?=
 =?utf-8?B?eWtEUE5QSDc5aE5TSFIrdllieUJUbXk1bElqa1E5VVZ4MVhjc3ZmbW03a1BV?=
 =?utf-8?B?TmRMQ2lXMkRLQlIzbEI5cmVaZ3RMMFRFVE84RDdFMkIyUm16OTNnTzQxZ01a?=
 =?utf-8?B?THJyaGl4R0g3K3pVbmtGaTBXMnJ2QVp4bE1JU1FsM1pUUWhZMiszbVRnelhp?=
 =?utf-8?B?TXF5RzU0bllIV0dkSjdPVEoyQm9Zd3RIVDdlaGhkc0E3U3dXOEdEdEVHQ2o5?=
 =?utf-8?B?R1krNGlCVTRrZlVFQUlHVmtBcEhOR0EvRzRUck15SjZ4aHQ1SE9POTdLOW51?=
 =?utf-8?B?UUJRc1VPUFpxZnB2NTkvNnJJL29CNWNIbjZtRGhYMFdtREYwOStjNnNsRmV1?=
 =?utf-8?B?R1VCT2FXeVBYTm05azd2UmZqWTQzQmUxUzhVb0k3SThJRnp1OWdRY0ZIMjhk?=
 =?utf-8?B?bXJlektuNE9CUkNFU1RtY2JpZ25rYUs4ZlAvbXRFdFgzQ3g2Z1BkY1U1MjVI?=
 =?utf-8?B?SE15NFFhR3BrRUh2NE91amRqOEpHWTFqa2pDeEhHRStXMGptL1RPT1dzQVlC?=
 =?utf-8?B?bXlSb1o4TENxQzJvWGxrN1NOTVd0YURSNm9ybVdhOHl2T0V6ZndCV2xJdXlq?=
 =?utf-8?B?QUIraXpoR3BjV3MrcVU1SXNodVBUaVptNzhxaitYOTFJY0dhL1ovTzArMXVy?=
 =?utf-8?B?bzloM1RwSlg5cGhjTXFIRWRUQUMrV09TSXI0Sit5QS9qRm9JMTJRZzc3SFR2?=
 =?utf-8?Q?AkXZGYibFzP1W8Nbse?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc72b67-47d2-4e58-5cdf-08df1a1036f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:48:25.5292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zorWgNlzASF5xlmT2de5aJ+DPj/8N6C2sgRkW8uqQGYwXb31RUQi6mdeKmbXs+XS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Submitting a cs ioctl will now wake up the GPU. The guard will
> automatically drop the rpm ref when the cs ioctl goes out of scope.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 87ccef153073..e2a715c04208 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,6 +29,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/sync_file.h>
>  #include <linux/dma-buf.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_syncobj.h>
> @@ -1445,6 +1446,12 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	if (!adev->accel_working)
>  		return -EBUSY;
>  
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> +
> +	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> +	if (r)
> +		return r;
> +
>  	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
>  	if (r) {
>  		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);

