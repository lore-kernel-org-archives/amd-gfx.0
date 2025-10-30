Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6033CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 21:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D7710EA44;
	Thu, 30 Oct 2025 21:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rwg65YCL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4241B10EA35
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 21:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k20W6IgEJvPFJZpYJ+rDvjdWj9UCuSvL//oMH5xkdkzk9ohBHmY2WozfpTY+FdkKOXCHmWfDZ5aHo0UZOMntplqGU2QWEBoH5V/Kwo2fsNYyBHGL13hb0j6qJUt6nabJl3WdSJNoznE+SCs/kAo2oWBsG7z1NEfE9lAZLizSf9ao+wl9OR0mkx5DkKnFzlWTlvmpzLnM5ifd94ljO616tvdMelcIINPgtzJ82J79RmBjygE6XKpNaWiIgqUC5/XMwmIa+g720+oNvPbWN44TmqLkpNtypYU3U8dgtpvtZdysx9dvYpvyX7QwAeoBSu7A7RzJTL37lFioN4O/AbCL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8GOAVWk9jco8cZ7rHWsT2hZ5+d9HV2LhZHSN6IJlzc=;
 b=fubxKjtlsAYslYVaB3gV8jP4hNfnoI3Cg9FS+e4nhyrjjaiV/fXrcetC00OW/I60f04W3fQg6ikkle0pFfKdL8peg0+PteqUxP6BtTfm+aOG60F/Yx35PlHVuFDDDFhCSUTbb1Y6stgveOpAav8FOega81whIfI7RtwD3m5HAAZE6s/Lr9P+Zx/sfZrqUS5ypNStEEVtCK/YpPxMmEIFB/6u9SlJRJCNnhnrOwsCTASjuSQfQl+3esaWWwlBBHcGaP4qXWanroP3n6C9IfHIx6sPQa26WktdHm/D77br34uiha7rz6ZzSfzOcgZUbWskr1whiFh4QzdEYCIvFMZQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8GOAVWk9jco8cZ7rHWsT2hZ5+d9HV2LhZHSN6IJlzc=;
 b=Rwg65YCL61fMdQW/50K+bHNuHLxV0aGW1PsTmKeA1zQBSOBWL6EruoiczaWkBUikZABxkNxdOm0aYNW4Gg4reLJpaZgconFgpErSjuSIEHPR6IBV3LtOdlcrR1fiHfx7uUZ338Z+FPt8fJB3J0EOebmdpf2QC0YeVrdjMSCFjDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 21:17:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:17:29 +0000
Message-ID: <586f8feb-3d01-4143-a250-c0e70b247f75@amd.com>
Date: Thu, 30 Oct 2025 17:17:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 08/18] amdkfd: identify a secondary kfd process by its
 id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
 <20251022073043.13009-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251022073043.13009-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0344.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ab6a0c-2490-43f7-cda2-08de17f9bb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3kyZDVRNDljWmJDK25qd0dJc2NWM09mbERYQm4yU1BMWGdNWXpOUGZ6dXlY?=
 =?utf-8?B?dWJxZE9CVytNVjhFWkJTQnRZZE1JYk84aFZaRVlUY3dtcE1Vb3RoRXJycW9L?=
 =?utf-8?B?VElDMU5leFhwL1RKL1hOV3Z3aHBPbkpwOTU5dHZvS3pzK2kyY0x0YnhqanJw?=
 =?utf-8?B?TUFkTG1lMitCZzd5YW03Yit4U3VsQUt2K1d0SWxWZDZRd0pWY1pCeUV6TklY?=
 =?utf-8?B?WlZRd1BadE1Ea3NGekVCc2FmTHJJQTJoSGZVRG5mRGc4cHE2MnFqVHQwMWZB?=
 =?utf-8?B?alBZdmZFb0tVQ05SNUZWV1d3Zm5TSVNBMk0wUms0d3R0ZlRNazhFanJqME42?=
 =?utf-8?B?YVY5UTMvYUVhNE1GQU5iUEhmWmZJZFd2VExZb1IvUlZiQ1oxM1pDSDFGQzZS?=
 =?utf-8?B?blp0dThsckRvZ3NmOFdmRDh4aHdDanQrd3FFTnA3WXVyQ050bi9tTlU5N3Iw?=
 =?utf-8?B?WWpibVZVb2lRdGpFV2xrTjNxNjRiVXFRRzErWEVFYS9YOFFqTy9yd1o5bVRN?=
 =?utf-8?B?OHp5OWhTc0l4dm9ZdHUyWS8wcGpFM2ZJRmRvSWhxR3VLMkdoandNNTIzVnVL?=
 =?utf-8?B?eEpBK3VKUU5vRytVNXlOSU84MHFzeGorVitRUnc1SzFrZFRZanlMM2twaGho?=
 =?utf-8?B?V2hoVThpWjJOcG1EazlzWWdEaEhhT21DNFdiRjBpdTBpcWp0SkJpYzhhejJN?=
 =?utf-8?B?Q256ODcxY0VFcFVBUHZTY0JBbXVwZW9haytUMmdaUlY4Zlp2RkhmU1FIRllx?=
 =?utf-8?B?ZTZCR2VPdUNqanFPblowZjA1QWkxRmpXZjZzUDVpcHlya21CNnlSVkl5NDlw?=
 =?utf-8?B?MSs3OW1PYUljU3FYZmcrQW9rTVlTbCsycmYwQkRwOWhZODVwTzJsMS95c1Ni?=
 =?utf-8?B?d2ZzK0Z5RnRiVDZveUZoRlBYSTJvM2FTVmRXbExkaTF1VG5vS1VaOXhMMmJV?=
 =?utf-8?B?cXlYVDZjbUlSRkdrMUZqcGJsc3hZOEZBam4wZFpQMXhXRjBOWkpFdm14aHZR?=
 =?utf-8?B?Y3l4UHFzaHQxT2NJVVp0aCtBelN0bzJpS1pRYWxHbTAvc01ML1ZyWHdTK0Vr?=
 =?utf-8?B?SStWcGJZKy9QWDE3bERncVVpem1jY2w1RElhb0c2eUplSXVLeTV2Q1hySTdi?=
 =?utf-8?B?b1NGTkpVWGJiQWdVRHQwanFKMFl3Nk9FTkpjYmUycVUweGlzZDZUQkZGazA5?=
 =?utf-8?B?cHdmZkZWcFFlQWMxdXhjSUJlVDZmUXlrR29rS2FacHA1NjRqNDJNTnpKajU4?=
 =?utf-8?B?WVowT0hhMXgvT0ZVSDNGSjZqRmJERG1TcWVWaFNxQXBnQ2E0UDhLdEg1eXA3?=
 =?utf-8?B?ZE5meEJtcGtocGFkZXVSR2NWRjFtOUIyVHJFcDIyVkxDVkQ1OHBwbjhmT0Nx?=
 =?utf-8?B?UEZ0Q2JYUDVIOEJmU1RxK051d0JnLzBvT3RsbTZaaStRTnhzRWVzdmVtTG9y?=
 =?utf-8?B?TVY2ZXhnNm5yS3o3NHk1UllRVGpZUHAyaUxmYXRjUXpUbkhKQXN5Q1AwNW13?=
 =?utf-8?B?aW5sWUxFWEN4Sm5wY2FaRWNmMVUyNk5Db0hvQ1EzVEdkdlM1ZFlPeVVWa202?=
 =?utf-8?B?dFpzL0pRUnFSWkFwN094UHVzUjhhVm9jWGpySFlyTUtkQXVydTR3TUZDZzh6?=
 =?utf-8?B?aWd1YmRVbWFXS0FRQWczWElPVldZSkdsOEx3bWllUDVWSmtYVGZRSkxTYUtr?=
 =?utf-8?B?UkJZeFBPWUlKMHJuRlFncFVleTl1dXplcXZ1Q3RoSTA1bDF4MXh1MDI2REd0?=
 =?utf-8?B?RkloUTgzdDgvMXo5R01hL21FU3hKbXJvYnlNeDhWZGZyTmpCalRlaU9oMDE0?=
 =?utf-8?B?Z0V0cU9rMk05S0hPZDR4ZWN2WDlTR2s3SmhiUW9vZzhrZHdyOG9CSlhZNXRI?=
 =?utf-8?B?VFlHYnF5VEpETzRMRnl2QW9oU3RpYnZ3eXh2UWlub3ZOYkgyN3F5akZEMUFY?=
 =?utf-8?Q?8zgXBgCltwga2TE2wK3sWuv2DqBCmhYS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhUUVhPcTFobkFLVUxUUit0VkNEQTJhZmZKNWhrakZ1SkQrcEl1RUxJeFJr?=
 =?utf-8?B?RndoOHUvNjk0WjJqa0pPUFhzSGhpU2ZxeGJuKzFlVU5KZnU5M1VieUVtTzJK?=
 =?utf-8?B?dTFxTlFyNWZQaWlmK2NSZjBvdWEwRHEzWFczeFB0MUhicGNRRlI1UTdQeXZj?=
 =?utf-8?B?RnV5Rk1RK2VyWWRjaFg3M0N5amUyU09hWU13SWgvaVBlZnlOcWlOaWZqWUh0?=
 =?utf-8?B?MWhGbWpZWDE4QXJLN29jNTM4ZHNiZGlyVm5DejBRQkRDVHNRbG1ob0tucEQy?=
 =?utf-8?B?WnhHU1pqYWJROGh2ZzZycjIwd1FsVDZWV0tiUGVEL3FRSXpmQU5jU25keFpL?=
 =?utf-8?B?SjViSkJWbzhXN08vMmZ6cUwvNGtaem5VVlE1azZFd01iUTBCUWlacCtmZG9j?=
 =?utf-8?B?TVdpKzVUbm1UdzlmMTNQYnRYTmc2SWNqSHNqN3pQdnhna3R1VEVUNVN3amRE?=
 =?utf-8?B?UFlvQ3l4WklrcVhWczlVVjY3aHRmeEJTU29yT1Mvcmhac29JNlZmZFRMYmNV?=
 =?utf-8?B?REo2ZGhMeitnYkNNQTdaamlSbjA3QTJjaFlqdXI2NitaZmh2eEhsZGlSSGdm?=
 =?utf-8?B?ZENWRE04dk91K3JldUtUbE95VWo1MzRSbjRWT3FEaVFlZUlQMVRaMjFqQW5F?=
 =?utf-8?B?b05ocm5NTzZLUElIYS84ZUwrL1R6VWR2anNNZzJBRmluSEdSRFNiSVF4UUU4?=
 =?utf-8?B?K2JzMUtPRGI5bjlsb3Mvdy9wOVdpWTBHWWhtdnFhV2M1bDRtU09oZ2RtVWFS?=
 =?utf-8?B?NU5qTmZQalZjTi96bzlSbDFkcEgzM1Q1ZkpOOUxXaGJmRWw5YlhhRFpsU2xq?=
 =?utf-8?B?ZGhEcTNJeFpxWFNFbkprd2xZYmRiU3FMZXlkT3NZVnNpVkZFUW1ydXRDbTFu?=
 =?utf-8?B?Z29aQ0s5N1ZYd1ZlV09NWXFKWUNscFdYUFZqamIvYlRtaHhRR0tiMGNnd0Ur?=
 =?utf-8?B?ODdXSCtHSlprb2ZrOW5od2VCZ0QxYzRLaU5kWkF4dER6NlJwL0tKTTA2Q3kz?=
 =?utf-8?B?WHFROUUwMVdnYzFXQVFXdXhydnZ1eFh4S2dXUmNXUmhiMkdXb0M4THNWdUp4?=
 =?utf-8?B?L0UrKzd3RzV4WWJlSVZZWWlIMlpqZkRTZmFHQVArTW9RdGdSTW1UbnpWNGt4?=
 =?utf-8?B?OUNSNUFnaUxQd01ZWE9rSmpxbHcrbnlwYVhrbWF0a2tsb1FqT1RNWFZzSTBr?=
 =?utf-8?B?WXRvUHFRdzRYZ2JnTExXeGNrUEVWZVE0U2g3U05LakpkL3R2SjZtc3RNZDJ3?=
 =?utf-8?B?dHcrUGcrUUY0WkxNTmFoeXZYS3A3Wk5SR2FlWWx6VjlzalJ5ODBjNVVaRlhu?=
 =?utf-8?B?VmdEa2ZNdng0TUU2M1B3RWs5dGJZL2hoVmJjR0ZRRWNaakFqbUFjMU5TWWFF?=
 =?utf-8?B?YjhJRTlOSEwvcHNmbGJWYkhoMHVUd0prS1I2Y011bDdoN3poUHBDNWlsU3ZR?=
 =?utf-8?B?NEZLd1dzcjBXOVNzdWhLRTVBeG00Y0k0L1JUR1pFd3VjSWlZMUdFVm5ldVVr?=
 =?utf-8?B?VFZXNlVaWmlCTzlRakZwa3J5WFlkUEtLUUZFZUo4WEFrMGdpYkNFSGxQMnlq?=
 =?utf-8?B?RndFTllDRE9DUGpidGtrUmxRc2p1MnQzaFpRc3JkS3pWOUNrWTRxYjRDalk1?=
 =?utf-8?B?UHZwUWtwcDJXbGlxSGV4NkNDZ0pXRUorM29ybFFuK3plMGt5NWVuZ2UwZWgr?=
 =?utf-8?B?OWlweHp6S1dSZG1HaTV2OWJRYjFsSC9qRGlSTHpjalVDcXM4ZkE1OGN0NjYz?=
 =?utf-8?B?UzQ4ODBvdEVsTVZPZUhGNmZ2MVIyVnc1TkJhVHArRjB4aHlGSC9JNXFsSjJ1?=
 =?utf-8?B?NmxDKzZQT3BMaVZkb3E0ZVkwUTEwTnZWUDY0Yzg5RDRPN0ltdWNMcENuRng5?=
 =?utf-8?B?cGlhRVIvUHBDOFFiM1J1b0xxd0h0R3dDV2Z6WGV2aERvd1VYRTVaN3lKRVN3?=
 =?utf-8?B?TUtHWkdvNmZHZjZYTlV5cXJmOWNldGhmeTF5d2RZV3pCYVZrRHdvUGQ4OGVq?=
 =?utf-8?B?aWxMeFNoVUVMNkI5VXEzbzhMb2RxZ0szVWxjYzJ3ekJCS0oveXpycHg5MVhL?=
 =?utf-8?B?VUNwSXcrM29GWDBFRXIwQ3d0MUY2eGpvMmZLSVYrZHZUcnVWS3JYVkFXQmdV?=
 =?utf-8?Q?UDjr3gaKpVVepjDtCEoEN9OYG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ab6a0c-2490-43f7-cda2-08de17f9bb3d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:17:29.0467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR8csOuWJcFJCb1h8XMqgdstREzIz1J58Gc4WPmIxEYcl04tEaI6kuIRF7t/WNqzDIxUanJuvJRxEd8iTbWf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

On 2025-10-22 03:30, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
>   2 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 919510f18249..30b0b45bcc8d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1021,10 +1021,15 @@ struct kfd_process {
>   
>   	/*kfd context id */
>   	u16 context_id;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
> +
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>   #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
> +#define KFD_CONTEXT_ID_MIN 0
>   
>   extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>   extern struct srcu_struct kfd_processes_srcu;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 995d27be06e3..f1e8ce61290b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -827,6 +827,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>   
>   int kfd_create_process_sysfs(struct kfd_process *process)
>   {
> +	struct kfd_process *primary_process;
>   	int ret;
>   
>   	if (process->kobj) {
> @@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   		pr_warn("Creating procfs kobject failed");
>   		return -ENOMEM;
>   	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -ESRCH;
> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->context_id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>   	if (ret) {
>   		pr_warn("Creating procfs pid directory failed");
>   		kobject_put(process->kobj);
> @@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   	return 0;
>   }
>   
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	int ret;
> +	struct kfd_process *primary_process;
> +
> +	/* already assign 0xFFFF when create */
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
> +		return 0;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -ESRCH;
> +
> +	/* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_CONTEXT_ID_MIN,
> +	      KFD_CONTEXT_ID_PRIMARY - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		goto out;
> +
> +	process->context_id = ret;
> +	ret = 0;
> +
> +out:
> +	kfd_unref_process(primary_process);
> +
> +	return ret;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->context_id);
> +
> +	kfd_unref_process(primary_process);
> +}
> +
>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>   {
>   	struct kfd_process *process;
> @@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	if (ef)
>   		dma_fence_signal(ef);
>   
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_debugfs_remove_process(p);
>   
> @@ -1601,6 +1664,13 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   			goto err_register_notifier;
>   		}
>   		BUG_ON(mn != &process->mmu_notifier);
> +		ida_init(&process->id_table);
> +	}
> +
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_id;
>   	}
>   
>   	kfd_unref_process(process);
> @@ -1610,6 +1680,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   
>   	return process;
>   
> +err_alloc_id:
> +	kfd_process_free_id(process);
>   err_register_notifier:
>   	hash_del_rcu(&process->kfd_processes);
>   	svm_range_list_fini(process);
