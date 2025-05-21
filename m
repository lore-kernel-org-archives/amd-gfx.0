Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D08C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 11:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B988611ACFD;
	Wed, 21 May 2025 11:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hvUyaezL";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50AF11ACE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 11:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7ZkZBIui9lSfUvvUPY1hqvC6oA9Od5gDUnzeioYOogz9tf5NjF0PPhFnQlSfbUqUvIZSFC1eTeXXA0K2mxAkzwTwoGvhjUgi/B4qVQO+OYd/rwshNgL2S+9QVP+e74OjkHDr+2I7UtFAoQbMOgRm5ftS0OC4SxxrRTgDtZhidxU8WAcBGptfUNZAy5a2a2Gm4SEx04SR8nPrGFRy/ty5XJHR7ARtHh9xCZ6qWKF56ONkPBJqQwJYiF6vYagycqIeJ/5jEQLV6A6RCV4fCWF+0mYN/N8O0tqQyKukgNi+Zfkbo+08QoWfw6Sz+0cVQxz5dAgSQGISB6284VDiUZVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI5BEpoWDeIsxy8fqoBVVFPww+zMErsgEjF/PD7/O64=;
 b=Zxu7lg7d3RTmONe5uwRNl0Y+aYsRxYCw4VcjIHRY+pNB3yk77f5+qY/C6HzUrml7jhwXj52EjD6TGxwynaE1NtgNipNnKf1nIBwcTVDE3flfH+6vCqYRD21ay4uRAt3Uyqe3YlGJxALlIQ3w0im/cOGuACAxT1ARDkLBK/yQ8PnwCptDehKJHAJvEzkM77ejlzBQ49EsLK/Llg2cPLs9Ej1Ujts4T6FWgMdqL4iR2lEpJlMGn8QWMKhldfOol5nWHgTOU16EGO3xAmbz4osw4I76ij9Wy6QSqoz9muMDI8r682yyot/oUKQs++08p9p65Dgad7VPeWIQ8+WQWtaQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI5BEpoWDeIsxy8fqoBVVFPww+zMErsgEjF/PD7/O64=;
 b=hvUyaezLjsU5iQtrYFykLX41SL6gbzD+8XecNfFrSfppxsWe0D2RwBFQ1mVCz9Ghxt48RZqoUBOt8mk1mWl3HJbTRXcjgVSEJTyKsU1Hs84OPm84zbvvuCyOoKRWBpH6jObArvHs7wpsBIH4bwNvCutezlU+Cbonois7hoGlHkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 11:44:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 11:44:52 +0000
Message-ID: <1ad1b3ea-e825-45d1-ae4d-914f1623d5e2@amd.com>
Date: Wed, 21 May 2025 13:44:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] drm/amdgpu: don't report stale vm_fault info in
 devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
 <20250521094912.6714-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250521094912.6714-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d76e9d5-7684-42c1-02d4-08dd985ce63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkQ0Zzc2WjNXMEo1VHRpR0R6MHNnSFRUdmVuby9aRHVxakhrOUViWnZpU2FU?=
 =?utf-8?B?K0dlLzYya29LbERyNGV6eDkybjNGeEU2bkNZa2NYLzBVZGNTbTRlWDFzY1F5?=
 =?utf-8?B?alRScTJDc1NMc2xCc0NJU2JMV0lIWDRwcGtJeHdoeGM3Q2lldFpXbkZpK08w?=
 =?utf-8?B?Rlc5YlpES2N0TUFZNGhxRklQVUliNnp3dkRuQjdjU0tMcytRMFdEdHBFalZ0?=
 =?utf-8?B?cjlRWW1VWkR5K2JxbVVSMmxDYXB1NTZERWlDVHlDUkNwWEtIQ2ZkU29RdVdV?=
 =?utf-8?B?WFVXZ1dKdEVYY3kzTWpPKzZpU0VCRzdXMjZMOU4waFByOUhrMzE5ZVNGMUVy?=
 =?utf-8?B?SW8wQzlmWXhhcmt4TEljTEROdjdia0FKRTFuZU5OOEVhQklHcG1GZmZGR281?=
 =?utf-8?B?S2FQM2lBRzhENk9Kc1o3MVZVV00vaDNoTkExRFJaYUp5L2V1dXhnL05JcGJ2?=
 =?utf-8?B?OFRBMmdiTkdHbEMxRGxZSmNhYzFpWnFqMTdqOU1OVEI2b05YYkQzS1gzam93?=
 =?utf-8?B?ZklkdVdZcDNrY0ZwK3ZCTHAxeUcrelZkcmJwaXNPRkxaN2I0b2E5U01SZUdt?=
 =?utf-8?B?MTA2SmJ0bHp5dW9BZ2V2VHgwODJabjRTa3lIME94ZjJRYjBtdWtuRVEzVGFP?=
 =?utf-8?B?MGZ0Um5pVnpBWTdzL3BUcEtFWGNPQndtQXJHbXo1c2tSTGczb3RxSUJtUC9E?=
 =?utf-8?B?M3RobkU0ejdBa3FZa2ZyZEdlbDlaQUZlNFBjSis1Q3Q3dWRqQVJlYnJDKy9B?=
 =?utf-8?B?WWtDaDZ6RWE5QUI5Zlc2dEJtalFBWVBZUW94QnpldVFTVHpwVW01UDh5YUYw?=
 =?utf-8?B?eFFXUUNmdlpWYWF1cHdHRlF4N0lFWGpZQmpmN1JRUmdLcDlqYkJ6bWhCRFEy?=
 =?utf-8?B?cDFKOFYyanhWY1hkOGVCb2tLSzFuRllkMmg5YVIwbDdYYWd6ZTAza3RuaDJy?=
 =?utf-8?B?WmpCK09rOGFNdzFySmxWczRmTnlYVlZQblRvZDd4V1kzTlUyYXZqS1lXTk51?=
 =?utf-8?B?MjN5MnhiYkcxWnFBNksvcWZxMjNMSWJadmVnaFhtUWJnOEFuWklNUGJSVjd6?=
 =?utf-8?B?Z1FDeGdueDlwcHBQV3dQYWZxendCMVFtTWlpWU1FcC9sT1ZidlFJSG95cHRW?=
 =?utf-8?B?cVhxWUIxMWQ3eVFxQ0hqLzdFS3hteUE0MUxBR1B5cjFkOC9icHVXNmdMMHk5?=
 =?utf-8?B?Y245cDNCN05IU1ZuWjlsMVlyZTFtQnp3RnRKSDhmdGJPdlQxYy9iR2R5TmQ1?=
 =?utf-8?B?T1A4MENTSGs1eWpQVy83K1g2Y2c4M244QldZdG5ROWRMbm9qZ0VIUEZ6Z0FF?=
 =?utf-8?B?ODFOY2RNSmQwTzZQQW9QNmJuRkV6bGNaMHdZbTZDVUxJbXF2REF2VU1oMW56?=
 =?utf-8?B?K3lBWk1UM01HR2c3RnFSTElHS05MYW1tMGgvNGVVRjBDM2xjcnhiSHdNWUN6?=
 =?utf-8?B?cG9kSDdFN3ZBQUpQaWJheG9EUkt2ZzdkUytodWpyRVhSVXIrd3YxTWFodHYv?=
 =?utf-8?B?NXRNNGRzNGlUQWczajUvS0xUbjc2Q2V4Vk80OFpkcHFxUEtxR0o2OVFrV0cz?=
 =?utf-8?B?WXpCZWdkNTVMN2NpQU0ySWRyYjVaZytYcXZ3MG9oajNPczM3UWJvRlpDWEs3?=
 =?utf-8?B?ajdTN2FGOWcrYStoT3MvYUxJNTk4OU43STdzc2NoZDhsUm9RMUtadkhnVGhw?=
 =?utf-8?B?cGtwaUkraGNvYjBnNXRiSUhSQWdXbFRudUFiWnpYd2FvNVZNMmllbVQ1NnJs?=
 =?utf-8?B?WTRtSUQ5YlBoV05vTUhRbEpBSHpnZmd3MkRNZEVadmw0eVMwUUE3bSszMTRq?=
 =?utf-8?B?SXV3ejlzNzFCN1RoSUFlTTNQamFHNFFJZm1wQ0FESU14VFdXRjA4VElEQUpI?=
 =?utf-8?B?eDJqdEh0RW53T0I4K0xxMGN3VUZLSWlac2NjZVh4SmlHZnpzOURqMzVZSFBy?=
 =?utf-8?Q?58UfwwZf4yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXc1Y3N4T1VXdjdSbzBRRSt3alVEMk4rRVBNQWJ1M1hMRjh2OFZIUFFrRmpt?=
 =?utf-8?B?eXF4TzkvczZWZktoYkVxdUV6ZUtxZGd1M3BaNVM2ellPMnJmVFBsdWNJbEwy?=
 =?utf-8?B?dHpUMW5KNCtaeUJrZW16RklXeGRaVlJyNEVKRWd1aVRNR3N6QzJUYTl0ZUU5?=
 =?utf-8?B?ODhNMVR3enJhL1VuTnNPUGJkSWhQa0hEcWVRUW42eUFNd3N6Mm9FVk4wdlZS?=
 =?utf-8?B?c1oxY3UwRmVod1lNZGh2ekxVVWUrbUxSL2daZXh3cCtiVzhrZ2hqTHBRVGdH?=
 =?utf-8?B?VkNtVlM4bWZiTDVScDhtOUdwOFN3Q3FKWkJyQXl1T0V2TGlBRHhFbHZIakF3?=
 =?utf-8?B?SGZob1JGUkZOU0J1SXJCd0tucGFySVM2YUZUM2g2TllyckFwdGpwNkFtcnVH?=
 =?utf-8?B?UlpjRFU0S05oTjI2Z0tvZUY1bnBPRVBpcTVsSDluVnlicjEzblEzSXpGZzZR?=
 =?utf-8?B?R3pVd1hBRzNId3ZHSUpmZVlZbGtoQ0IxQXVLcU5WQUlmOVFML3dtQnRNYTVJ?=
 =?utf-8?B?NW1UMmFKdXFDaTFrTHczcVJjRUpKZDZxRCtaTDc4MEd6Tnl0Wkprei9pb1Nx?=
 =?utf-8?B?dGZpWkRFZjF2WmJvLy9ZZDZiTFZzeW5oQ09sVEo1cDVSVW5XUmdOYlc4WENX?=
 =?utf-8?B?SlNuanBkTXo1M0ZjOHpJR1lSR3NUVWhRUm5XS3NwTDkvRXYvckRvSVZmTUhG?=
 =?utf-8?B?V1IwKzZVSVEyci9Fa3czcWVkbDBwcDlXVEc2QThLUWxET05mcTB6ZmZYTmY1?=
 =?utf-8?B?TUJtaEFBR3ptT0JtM2RXNUhVTi9GbDVUWk1vVEY4WTRWMGY1NmpKZCtRZWdy?=
 =?utf-8?B?UzM0ZFpuZkx2d2FHaWc5QUx3dTJCdGUyVjIxL1hncXhjRWd4RzBGdmZxalpH?=
 =?utf-8?B?SlFEak9oc1VqUEJJaFpjdGlQaXg2WFhpdW5yZTlxaVcwUG0vcXdOZmt6Z1hG?=
 =?utf-8?B?ZUNYaDgybElzK0ZseDhMRkxWK3VOOTl3b0I5bVFYRDA3Yy9HNTkvaFptdzRv?=
 =?utf-8?B?KzJWNHNVamc5VmR3bGZ3UU9NMGZFSTJaUkZkNWlqRmdYK3RBdUdVMnhBS2pG?=
 =?utf-8?B?NEdWS1RHZ243c2xzVU9QWUk5emVHY1JJeWhVS2Q3SWU3UEt1SlZja2FMdTdZ?=
 =?utf-8?B?QUlaL2Fqc0E3YkNSWU5YNmpWOFNmSGR5WE9kbnlKWUliYjRZQ0JHWVRyKzN6?=
 =?utf-8?B?U0RRaGFObU40aWpXeUppcFlnTGdiMHNjUGREdlkweENQNmRhVmRnNE9udDlj?=
 =?utf-8?B?SXF6RmZDOHpudmY4N00yVklyRGM0cHgvVkFObWhFd0RwRFF6b1RNTWRDNWRZ?=
 =?utf-8?B?M3pMbFFuMVZLWHZ4b2tCc1NxOTFMd1VoVnNQaVNJUnE5TVcxVUR5RG9rcmM3?=
 =?utf-8?B?RzdGN0pPVi9nZ2hhZUM2Wk1OV2dVRFVIMW0wQkhmR0RWajh6R0daZEhmVW5R?=
 =?utf-8?B?aGRVbURUb2Qzbk91YjFHejZCd1hXZVNEY21Wc1FqQjFFTlAzN0RYRU1sM1NY?=
 =?utf-8?B?Sml4bmNLSDFsTmhYOWsxU0Z5Wk9zRkE2VVBjVVFHdmhsRkVzMnVqbHo1NkFY?=
 =?utf-8?B?b3Z4emJiU3NXb3FMMHBzdEE4T1VndldQNXNBUVNMenpReFhXZ2R3NzZLeW9o?=
 =?utf-8?B?YTRUQjFncldoT1ZZOFB1VE1mQ2s5Q0hVaDA4dlJDVDdHNEVSU3J1ekhDOXJE?=
 =?utf-8?B?c0hONmlYRWVyR2lENGZPdG5CK0cxbVo0ajJRQzJ1SUpMMXVuSUErVlhSdTFn?=
 =?utf-8?B?OVh4Nk4vOGh2YWpJTWhxZjFBOGcxakU3Y0lUNmsySk5mT3Y2SWkwRGdwbXJI?=
 =?utf-8?B?UE9XQXVJSjJkMjlRZEZaOEdBUUgxZ3pxenREQkRRejJsMlFXYmUvQk9STGdD?=
 =?utf-8?B?aDdIRnptUm1ybzVBQXhrSE1uUFUrWEttZlRJRHpkc2EzeTBQT2FLR3pucll2?=
 =?utf-8?B?YmVwNlBZUU9Id2hFYWxzS2psM2dtOFJKZ3JQY3FJcjRIc0x5M0tmejN3SHp1?=
 =?utf-8?B?bFV4eHpmVllyenorUHZsdnQyZXpHT1QwRUZ1UE81TTdsMVg0dUhienh5clNs?=
 =?utf-8?B?Qm0wdHZxUjVxQkc2SXg4clQxZFM0a0hKcjdTdDA2Nm9DdTJkeVhKcXN0Ukw1?=
 =?utf-8?Q?eQuLxW+3Noh35D0x/u+ANHze8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d76e9d5-7684-42c1-02d4-08dd985ce63f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:44:52.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRHEbjMp6RFslnch7fC3NS9r+Nsyjc4WKTJ+6McJm0pseiesVdAKoHiIiwqNu+bm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

On 5/21/25 11:49, Pierre-Eric Pelloux-Prayer wrote:
> The coredump needs to contain accurate data and reporting a page
> fault from a previous issue is incorrect.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 13 ++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          |  5 +++++
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index de70747a099d..6fa53e070b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -273,11 +273,13 @@ __amdgpu_devcoredump_read(char *buffer, size_t count, struct amdgpu_coredump_inf
>  	}
>  
>  	/* Add page fault information */
> -	fault_info = &coredump->adev->vm_manager.fault_info;
> -	drm_printf(&p, "\n[%s] Page fault observed\n",
> -		   fault_info->vmhub ? "mmhub" : "gfxhub");
> -	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
> -	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
> +	fault_info = &coredump->fault_info;
> +	if (fault_info->status != 0) {
> +		drm_printf(&p, "\n[%s] Page fault observed\n",
> +			   fault_info->vmhub ? "mmhub" : "gfxhub");
> +		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
> +		drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
> +	}
>  
>  	/* dump the ip state for each ip */
>  	drm_printf(&p, "IP Dump\n");
> @@ -377,6 +379,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  
>  	coredump->skip_vram_check = skip_vram_check;
>  	coredump->reset_vram_lost = vram_lost;
> +	coredump->fault_info = adev->vm_manager.fault_info;
>  
>  	if (job && job->pasid) {
>  		struct amdgpu_task_info *ti;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 33f2f6fdfcf7..38ccdd3d6213 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -37,6 +37,7 @@ struct amdgpu_coredump_info {
>  	struct timespec64               reset_time;
>  	bool                            skip_vram_check;
>  	bool                            reset_vram_lost;
> +	struct amdgpu_vm_fault_info	fault_info;
>  	struct amdgpu_ring              *ring;
>  	/* Readable form of coredevdump, generate once to speed up
>  	 * reading it (see drm_coredump_printer's documentation).
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce..5ee9d2cd74e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -199,6 +199,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  exit:
>  	drm_dev_exit(idx);
> +
> +	/* Clear fault info to avoid reporting the same fault. */
> +	adev->vm_manager.fault_info.status = 0;
> +	adev->vm_manager.fault_info.addr = 0;
> +

That needs to come much earlier and prefereable while holding a lock.

Apart from that looks good to me.

Christian.

>  	return DRM_GPU_SCHED_STAT_NOMINAL;
>  }
>  

