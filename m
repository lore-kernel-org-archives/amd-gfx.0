Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39431C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE56310EA3E;
	Thu, 11 Jul 2024 11:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/p/DkQa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F1D10EA3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 11:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPe6EgniT6Q8z/beXAsxvvdVp6UE8h0lZ5ogy0+bSGVYPDqn2ooGmmDCf8S6YgfJLhhO2faRqi4VM1np60/7nyv39ouFDFHQ+3JHLsKnT3+GgLHlSHH/gSzxXR2JgQa1UD9unj6xgSjfwwC8WKP9AzvszVOPlLUvkcvgXYacfuic49KtCR7Xo6mCyHeIBj2Z/GWFlBmgUDOvq0rv+l/oWEAhkB2mA/MsbwDJ2uN/PD6U+1gIH9ED0Abqf2TRLjVPcUeBeIsiWDUjI4SnVNfiyGxlDoMX3cwE9nBE8v0BFtnswjImXSJtNhF9xS9MhvG5Dgikpvhx74vK/NiCLCtVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbdKT7Hm3EclF5q07p7KjmP5ZJLWuP7645adB7zTZzg=;
 b=czCd6IVbr0PEPUzV9FTcHKJazgXMhu/9BZQuosDjBurHHUidAyORo5QHZufFCOYE1EDuGZjgGkU+9aDhL9kszYZaSxFbw5LFsWFu26qvrwS3UBct/RYIYBhFLqF9P2ZHoHhhSKnOTwuH/jF9jVnh/mhvaHIjD6EPDRHVoEF23O8oDTjjpEymlkKcCIppbrfNjypznY7kNAs0O06KZxlIkpqwZCPlZXRb0FBn9SCEMmcXgiDEy0dDVuC1fZzxkLEUR279ER6XCX9z9XBKhRQd2bTj1qg8HAWmGwdVdHKa125E+aTHSGp3HOMMrcZUFTifJgO9zbKuWAHHhnwuVXQpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbdKT7Hm3EclF5q07p7KjmP5ZJLWuP7645adB7zTZzg=;
 b=y/p/DkQaCxbLvxtU8c3RauxwsaJMkUp8UOSyTbs7YmNO90HKXBqI9L5VJjnboFLqMm561S62U47lx3dT/DxgpWDL6GWZmxN2UlL64tjnjvs3F7doG/BcEFqCoO/I7mRnyjU/SlTiblJd0tHSGH/o7eNA7dCraAJTpbnve9ZQSIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 11:56:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:56:26 +0000
Message-ID: <71e27b90-a8e4-4724-95be-3c6e507d29db@amd.com>
Date: Thu, 11 Jul 2024 13:56:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: set start timestamp of fence in the right
 place
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20240711053734.1656977-1-jiadong.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240711053734.1656977-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8f83c8-6585-435b-5dad-08dca1a07df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjZPeFhNYzhHemRnUHhZbU9sKzExTUtqdndpRTdQaE9oWWoya2JmUWswdndI?=
 =?utf-8?B?anZSY1F6RDg3Qk9YMTRObU9aR2p5LzdHMDhJZ2FGNDFQNHlkMEpEeTh1Ty9r?=
 =?utf-8?B?RVVJdVFKT0k5cVN4VkNtVTVkNU9wWlIzYXp6OFk4L2dId3FCMjJPUkpFa29Z?=
 =?utf-8?B?M2VJWVhTNEt2cTk3bERZQzlieHFSd2IzMzRETUJwUlJZN0RldUJhYnZxMHJO?=
 =?utf-8?B?UytZSiswUW00eENadExmc1ZqTFdBaThXcUpKQUxTdkViZDRUZzB2QmN1bjRL?=
 =?utf-8?B?cXRtNDVDZmFPS1dBNVB4OFNiRVBtaWFWbGxQL3VSMVd3V3Jlczh4cERlSTll?=
 =?utf-8?B?TkpRK3pKelBLZFVJWnNMaHk0STlWWXlpV2VCTkpxeDNvb3QvQWV5OHJsai9P?=
 =?utf-8?B?ZEt2K1lKQmJOUkZJYjgxWlRpUTFnODd1YmV0ZUpLRUpJL3Fsb1FUZFJsWlVM?=
 =?utf-8?B?V0YxWjdaWEJpLzB6SC9YcmRGeUFMVm8zV09mQjdFeHBHNVJCVk5oblk1VXNM?=
 =?utf-8?B?TnE1UmwwREJ5ZE5sdWxPRlZ0YktOYWNpMU5SRWJzSFNKV3pSaHFSWEZ1KzdS?=
 =?utf-8?B?dFk3V2t6K1U1WDdpdmdJZ2VEaVFzSHFmTzVGNHhFcUdPa1FpS0xLeEJ4Sko4?=
 =?utf-8?B?Q1ZzZEhYVEZGaldWUTJialZ3ZWV3cHpEU2RKOW0yWGFPeHFybGlNTFErYmZh?=
 =?utf-8?B?MThCcE9xM05qQVh3ci9HUWZ5WEJrZU5jb3Bqb2pGQ1FtZGdYY3ZDVXJ1MUZD?=
 =?utf-8?B?aHVtSHQzclVaU0EyVzQxOXdON0FjTndpd1hmeGNHdzM0Z0pCODVta2NRTXJG?=
 =?utf-8?B?RnZRczdqWkVyU0hvcGNZa0tMbUhQOGdFQURoNExGMHU3TlJWU09taXdWUTlX?=
 =?utf-8?B?dWRneFVic09DU2xkS09mWlh1bHp4RUMrWXpjek9iYlZqYWt3K1l3aWNEVk5q?=
 =?utf-8?B?SHFuU1NVcm1LTS9sUmtIWUZPZTFpQUg1TXJNMUFQcnJCamJWY1hvSXQwNWxK?=
 =?utf-8?B?RjhZdlVybFVVbEhOS0hIUDRHc3Z2bm4wWC9FWmQwZU5RQ052S09hYVh6RStT?=
 =?utf-8?B?Zmc4ei9qaHFOUGRVcWQ5WTNZaE5PZEY4U2tYd1RJWm1Demd3U0V1ZjBCR1Jt?=
 =?utf-8?B?SjZ0QmRKMzFlWFVqaWdZVWxsY2lRSzhIYXZpcVdyUG9NcFA4SnBMa1lsTUxt?=
 =?utf-8?B?bG1kQXdjdHN4eWw2YjRSblYrN0tWaEtDSDluMTBCR1laNFJka1pVSW45Rlhu?=
 =?utf-8?B?N1E3d0hrMVd5K3N3LysvL3ZMY2gwcU5MRFA3MGdmc0d6VzNXMklRcll4TzZK?=
 =?utf-8?B?QXRQYlRjOFd6a2g4ZzF5V0FvT1BnOC9IYlQxd095clFTU0tRNmZ6bFU1dWZs?=
 =?utf-8?B?L05VUGlZVlRmQ2V0T3ZITnZSekgvS3VRcDZsdnFaZWJZSURjTkYwRjlReG4x?=
 =?utf-8?B?RlBTckxvd0xRQ1JhdmUxOTk3V2ExWm1hRjlHdm8rWHprak1QS05WUDN1UjB0?=
 =?utf-8?B?NjliNTJ3LzhvT1VVWEVEVGhLSXVwSGM5NDdNZ2F4L2ZVNW1oa1lienZKenk3?=
 =?utf-8?B?RFZKOHVBTm4wMWFQYVJ2OGFaWEV6SEg3SkozT3N0SkVpcm94c2NlMnZtYVls?=
 =?utf-8?B?QkY5UHc1UGNxa2g3S0NwM1RZLzMrcWZNSVlRWHZnbFppZUsvb2pVQ3FuMG1O?=
 =?utf-8?B?RHV2RSsxcVdQZ04zVUwvNTJ0SDZFMHF5dTc2Tmo0dXZjR284RVhzV1hGV2Y5?=
 =?utf-8?B?Q2MwbG1Lc0dtV3F6SFYxTWJsZ1QySWlSUTBZcU1iQ3RFazZZeGVrVXFrbXRD?=
 =?utf-8?B?c09ubklVbUsycW9LSzFHZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExZRzdoWlpNRCtCOXlLU1o3KzhxZy9HbEhDRE1RQUxGN3hkcVpIK1VzMjlT?=
 =?utf-8?B?UG4wSGFZQWlQMmhtdGl1SnVqaVhmaGZWNnU1VmRDckZpOGVWNWd2YjQrQVpM?=
 =?utf-8?B?a0RDVFdyaWQ0cENsYWJTWmR4R29DaWxCNmVxWXJlN3ZuMVArSWQ2MkF6cm4x?=
 =?utf-8?B?Q0VDMm1tc1RNd2F1Rkpma256L09ZelJyTlo1ek54Sm5XUkZhWVRZY3NUdDF6?=
 =?utf-8?B?SUdVbTNJUlphZmc0dVVxNTgzZk8yeU1ua0pqRFRvdEdBK3NZNTdZR2xkbGxN?=
 =?utf-8?B?TTlFNkpGUitBT3JjL1c0d2RmRU9jZUpxWDBqTUFVSU5IeDdBeWdVSmdUUmJ2?=
 =?utf-8?B?OGEzc085ZVVRUitUY3JTQU1Ub21ib2FSNGMyaXhWS1FOTmpFNGxzVzhxZ0Vn?=
 =?utf-8?B?WEFsSWF4Mk5GeWR2SFRieVRMTE5pVHcvbU9hU3FEOWhFNHdvaU9lQ28rNENx?=
 =?utf-8?B?eVBxS1pUUTdidHNMQUErdHdkc1FJa0hLQlFYckpxQitra2w4Ty82dmdIMjht?=
 =?utf-8?B?NWZSYmtkSStXcGFxS01OTjVESFFUaHBMYkM4a3RxSUVhOEdiKzBvSjNJRDlI?=
 =?utf-8?B?a1NjMTd0MzZMRndIc200V2MxbGpQOUFNRDhicFJqU2RuY1VpU0JYYlBHT3U0?=
 =?utf-8?B?bVFMOTVQdDA1SGtDR1RENk1LdVJnOU84VUg0bUh0b1FEdFFlY0w0RmtNWEl6?=
 =?utf-8?B?bjY4VnNuYlJPbkdyaXdmRldOQmdJS1BFUU9qdThzMGNTZi9PSVY2b0NySWRa?=
 =?utf-8?B?eThnNEY4MHEyNS9DZHc0d1k0L2tldDJ5OXA4QU9KZjlrQlFmbjZXMEd0d1Vm?=
 =?utf-8?B?NXh4aFkraHZoOW13RndUK2dRZTZBU3BsRDYrN1A4Z0tRbHlJQ2F3SVpVcXhQ?=
 =?utf-8?B?ZGQ4bmdJQXRyZmJxUTJDb2h4SWJiaUFJU0o3SUNoNWFJeDlFaHA1M0JuZFBt?=
 =?utf-8?B?T29GMkVONGZGMlY2dVFkaHRud1lZWlJ6ZHV1ZGlieVUxdHJFc0lZTXZ2M1Zz?=
 =?utf-8?B?VjB5ZlVwRVNrOXBZTWJJMzBJYW9GOVRONEZRbUV0K2N6TFVBY0NwYUlXUXNq?=
 =?utf-8?B?Z2s1SmVpY0RWL0NWMHNWRVhWeU5ncGtTQVppcnNmUmpvZXFoc2xVQW1hVzVo?=
 =?utf-8?B?YllCQVh3d2xTVHdHb0NuNmlCSlhtUGExQkxHQlhjbWt5cVVtT2ZWVXNtd0RQ?=
 =?utf-8?B?Uk9IYTJSZzNzaXZ0MzdaRGswbDhlVnNZQlZFM0dsSHBIV2RESTdKYnZReWM1?=
 =?utf-8?B?UG5HRFVOVjJaOU1xcStsclAyVGNlSDF0SkZCSVVCS0NZZGlJd0c2V3JJS05S?=
 =?utf-8?B?c09iUE9xTXV4SlkyYmZoOEJaZVczYnMwUnF0c0p1SkRXQXNSTlpianhseGJo?=
 =?utf-8?B?aHRCcjc3aVQzK2ZGNmJVeG03Rm8vOWsvM2lsd1BScnJob0w2M0NIRTVJMDJx?=
 =?utf-8?B?WmlNY1cwZzA2MHBvNlpqNnB4c2pERmhacDNkQ09IaDhkaGVvUjRaVE80Unph?=
 =?utf-8?B?c1FOak5PamVySHQ2V3p6Zlc4d2lSZi85QVp6MVZ6elNIR3FGVUl5NjdVRllz?=
 =?utf-8?B?UThEWFlmbUdXbXZ5cjN2dXI2c3VZTGpJZ25uSFhGSXJIK3AvczBmYlc4akZn?=
 =?utf-8?B?WEtLRDVVZ1JiK0dMQ3JPaVFEN0V5TVhRa2NSeVhXQWswaEUyaHBkbmg1SG14?=
 =?utf-8?B?QTd0WFFjMGdvbDFWQVlLdnlTdzRvTzQrQ2haWGZDMHNPSzVsdW16SUVmb1BS?=
 =?utf-8?B?TjFvUFE3VkhvckZNMVVGMTdaVnlaeTkybWoyRVVjcDdGZnEzSG9tNW9YR09D?=
 =?utf-8?B?MXJ1ekI1VnJCV0d6S3VHRHBhTDRCTGk5OVVwcEJ4bnZMRTE1eXE0R0JUcHFk?=
 =?utf-8?B?aW1ValJWcThuODUyVWRFeWVENVBHN284TDhudFNGMW1EelNhQURFM2lLTDdV?=
 =?utf-8?B?eGkrS3JXM2hIZVRLQW0wTnZLL2h5NjVZY29XQUFqQVlqTVZQTXg2dVJMbDd1?=
 =?utf-8?B?WEkvZFVxV0hVN1YzRGt4ZmZZd2UvRmlWbzB0SWZCclBZaGRFQ2V4Yk5UVFR5?=
 =?utf-8?B?VzF1N2VveS9nK1JmMUM1US9PUGNsUEh0TGR0R25aTHBhakJRMU5uZjRwN1Z0?=
 =?utf-8?Q?zRU7h1BmqE3UJ2zbjk9MOsMLO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8f83c8-6585-435b-5dad-08dca1a07df3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:56:26.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fosEHg39sp9I4RMntiYigHAa9mI/vGNWTzsARrBc/4BaLo3WKPcgyWx6ZN3TX6nF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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

Am 11.07.24 um 07:37 schrieb jiadong.zhu@amd.com:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The job's embedded fence is dma_fence which shall not be conversed
> to amdgpu_fence. The start timestamp shall be saved on job for
> hw_fence.

Again big NAK to adding the start time to the job.

Regards,
Christian.

>
> v2: optimize get_fence_start_time.
> v3: set start time only when mcbp enabled.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 32 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
>   2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..8a2fdf5a310c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -88,6 +88,31 @@ static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   	return NULL;
>   }
>   
> +static inline void set_fence_start_time(struct dma_fence *f, ktime_t start_timestamp)
> +{
> +	if (f->ops == &amdgpu_fence_ops) {
> +		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> +
> +		__f->start_timestamp = start_timestamp;
> +	} else if (f->ops == &amdgpu_job_fence_ops) {
> +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +		job->start_timestamp = start_timestamp;
> +	}
> +}
> +
> +static inline ktime_t get_fence_start_time(struct dma_fence *f)
> +{
> +	if (unlikely(f->ops == &amdgpu_fence_ops)) {
> +		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> +
> +		return __f->start_timestamp;
> +	}
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +	return job->start_timestamp;
> +}
> +
>   /**
>    * amdgpu_fence_write - write a fence value
>    *
> @@ -197,7 +222,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   		}
>   	}
>   
> -	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
> +	if (adev->gfx.mcbp)
> +		set_fence_start_time(fence, ktime_get());
>   
>   	/* This function can't be called concurrently anyway, otherwise
>   	 * emitting the fence would mess up the hardware ring buffer.
> @@ -428,7 +454,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>   		return 0;
>   
>   	return ktime_us_delta(ktime_get(),
> -		to_amdgpu_fence(fence)->start_timestamp);
> +		get_fence_start_time(fence));
>   }
>   
>   /**
> @@ -451,7 +477,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>   	if (!fence)
>   		return;
>   
> -	to_amdgpu_fence(fence)->start_timestamp = timestamp;
> +	set_fence_start_time(fence, timestamp);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index a963a25ddd62..3a73fe11a1ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -73,6 +73,9 @@ struct amdgpu_job {
>   	uint64_t		gds_va;
>   	bool			init_shadow;
>   
> +	/* start timestamp for hw_fence*/
> +	ktime_t			start_timestamp;
> +
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   

