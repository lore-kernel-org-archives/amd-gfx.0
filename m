Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9DED33994
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 16:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4990210EB5D;
	Fri,  5 Dec 2025 16:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QALHcFpF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BF510EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 16:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUWmi3CdS3BXQA5g2zjcx2zoxtsWozrGTJIn+SE7mOzPPKKA/OII7lOHslcREaXcS2DZMN9tEyZlejMupNB30Qqvo2jQpGiniSVaJsZLSWM3kx7sdhPMQ6cxcM+Abb11LHLydyqND/i9jmmSn+SZkXVyrGwHJKqOAlSTWRhgG7fqIibxqZvS9Zrhc7wCsy2+c7hNCA/Yx/QAqV3tSivfktP4g0Fr9z6RgOklGvyA3LedjLWmODlcQu7KexR3dw+zwrmjT+A4pi9HHNsC/93aD/U3+rt5JtSpcgGutGwNif7m00BSvpdKCBiVVobKFRKZWSsAcMSv807CETFRZxnMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgw6CtVSYK0CGHhcqbP6dJjP/SdAfd/5rWP0TZxXuQE=;
 b=IGTEAm5LJ4/0j6jAV6jho2kpmlbcB0eAoTrU0ZqgTmyI+Tdig3C0Vt5fehaaKO2e66KnTjpLexcZZKSm422YV9r2LCFZL5A6sXoOKTgDfGl0nfiHAI0YRRosfz+tGTC6wUXXTQKFEvjS435dTWTz83YoG5tbwPCJ0sL3Ia6nfZe3cty6nlvQZs+djCaGSdetk7qkFFwfwoJxNgLL8eEWQ6Kj49RhRKVc3T0Y4CNzLzPP2sK0jKlkSsIrktgpnIqfsb4IU+wN9MwjBaWpajHK8VJYLYeQWOzCHqaYNI/Nki/sexF2XFz8TYspuREvsTYj/6NC5Un/s/XpThaMKEMYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgw6CtVSYK0CGHhcqbP6dJjP/SdAfd/5rWP0TZxXuQE=;
 b=QALHcFpFItmj735KvIWMqxqizI1qZu2qJMju2GfYDevuvGNfNoyacg/UzyxBfLm97UBwtsw7COt+mcnOOZ9XciUANoVMsEvQKutagcYxyUXPXIFbI2fm9FujuCtMVxyU9QyyRTco5WoT/CzFSbQ5WSuk5u0tm5JO95Cg9sSscuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 16:34:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 16:34:26 +0000
Message-ID: <29bd7365-2b39-44ae-89ce-48bfcb9ece9f@amd.com>
Date: Fri, 5 Dec 2025 11:34:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: FORWARD NULL
To: amd-gfx@lists.freedesktop.org, "Martin, Andrew" <Andrew.Martin@amd.com>
References: <20251203154145.63159-1-andrew.martin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251203154145.63159-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: e503e830-9c64-4901-d11f-08de341c27b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm4zMTcwc1J6TVArWlhHTzFILzV5eGpxWm10U3Q1VCtVSWdPNkowWngvZEov?=
 =?utf-8?B?L01pSk9rcy9IcFd5bENrWS83SExJMTU5Qzk1MHlVdm5CRmJ6VWdJQ1plSWxh?=
 =?utf-8?B?bTlraFM2a1Bxa2Fiby82eWEyQ1dhSjd5YTU1Y05ESzc4Vk5qSHpaZHFpRFR6?=
 =?utf-8?B?MTIwY1luSGxSZzk5R1lpQjRLSFhDU3NYSURUVy9taWR3amppUW8xaHM0Vnhz?=
 =?utf-8?B?ei9KTFQxM2FuSlNuWWJrdnc0NU92TUhHVnpnM3kyRmZ2RmVtUjJWdXhpOWhG?=
 =?utf-8?B?WGFkaENHZDRDd081b2ZDYmhpSy9McU1aVVV3bWJjeG1IWHVUWXorUFU4VzFu?=
 =?utf-8?B?b0gyQjRFU1NXY0pXVUM4SEpUTUlJbU5GS2M5d3RDU2YwNEpjdVVrVjI2ZXNW?=
 =?utf-8?B?Tk1OdWUwWjk5a1FtMzhjUGtxa1k0ampraE1WOVM4cTVPMFNuRnV2NU15OGNv?=
 =?utf-8?B?ODdlTE9LaVRjQjFIQ2ZFZU5IaWtwTURCQkRTYVc0MVQzNE5HdFd1aW42U216?=
 =?utf-8?B?UVUwamhQR2FSc2tubVNsUU8wc24xRC8xWTNvbXVHeXh1T1BncVJ0cVgwV0Mw?=
 =?utf-8?B?UkU0S1FmSjVsdkZCdTJsME9vcHVZdmpCYmlqc3kzTElJSklHbm5uT0lTMzN3?=
 =?utf-8?B?R3FMWFV6cFQ0MC82M21RMVhrYlRFTTkvMDBzcjNCRTR4L1IxRTFMRUxBVmZ1?=
 =?utf-8?B?cE9veTArSm5RaThYcDJtMlU0NmJwdzhQRmRYbE8zdzZOL1pzZG9IblBLUVB5?=
 =?utf-8?B?OC9HMVlpMVZ5Q1RmeVd0d21sMDUrRndTcUpRbXJaYVd2dHhzcGRLVDJmcGpN?=
 =?utf-8?B?emhlL1E1bzh1dU13Zjg4S3J3ZFYzK044L0V4WGtVKytQb1gwRmVVeFl2Y3Zy?=
 =?utf-8?B?N2Z1Q1lOK01XUGRaa05EWk05aTE2NUZ1YzJVSjJ1VnQzb241RjJyVHY1N2VF?=
 =?utf-8?B?YWJnWHBna0twZnN3eXFBL21TRjR6WCs4UlJJczluMHhCVGNVVllYeXVKTHdw?=
 =?utf-8?B?TmtSNENPRGNLdkNWNUVLTllScnhWMHlPdVZXY0JUdno1TnFONDlTTXVmYzBh?=
 =?utf-8?B?d1VMVDZZMmt6aUVOd214Q0xHQWVISytlbm16VWkwbVVIckQvZ1VOZlgxbFhz?=
 =?utf-8?B?MmwwSlErakZFU3dRSjdId3JmejI2Zi9QTDZnTUw3M2xmMVlVV3oycEhpdmdZ?=
 =?utf-8?B?cVJnQWRjV2FUQ3Y0Z1hIeTJ5M0dtakdJU1JQbTArQXk3cGlWYTNGTStjaVNn?=
 =?utf-8?B?eExjYjdrSlZPeXJMM3JCZlZvWUloa1FpVWNHYTA3eEFYM3owWTNkYWJuRkJ6?=
 =?utf-8?B?cmlzVWdJZnFIMEJHK0RjQ1YwVXh2bFY2SWhUUTBKdmlXd1pyUFA1Q0ZpZm1j?=
 =?utf-8?B?bjBianFkdWpEaXl4dGM1bmo3cjRCMDYrd0V5Z2NWUlRrUUZwNnM3OU1tNFBH?=
 =?utf-8?B?KzNJL09FT0d2T0I0R2k5K1dPL2VJdWhFUjlTOEJVK0l5T3NKSGMzUlJEWFZj?=
 =?utf-8?B?UE9mbWx6ZVB2R1NTZlFrMUk1am50dlVyeVZNTU9qUFJIZlEyRkk1d04xZVJw?=
 =?utf-8?B?K1pmSkNhWERYek4vNDd2QnNlUnNxL2tZNEw4bEszMXBKanFhRDZ2OVJ1QkVy?=
 =?utf-8?B?RWJCWUNhOERmWFE2aklXbC9sZVV3UTRrc3YxNXBEcVllVFZOTkF4MVRMQ0Zo?=
 =?utf-8?B?eTBpeTY3T2FRQUJMcUFORUVoV2dRc1ZudkwxQS84Qmo1djFoa2ZzUkZTazZO?=
 =?utf-8?B?c2x3RlI4RHM4dmxnRHh4ZnpjZWNZcEpQS2tKcU1hZXN2ekgvZWN1ZzZhNkN0?=
 =?utf-8?B?VVpwNEc5bmFuOVVCN0ZNVmdBMERvekloTmZtY0dVNnZ5RWh5MS9sUXM4VTZr?=
 =?utf-8?B?aCtiOWxlQnpiRHRjemV5QjU2d3B5M2tIRkNSeUxDK21nRk5IZ1NCbG93NjlN?=
 =?utf-8?Q?DwokElRPdo7aH2IYiOyWrwbgEGsN3zCt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEsyaDMxSXNlZlhuU0NuaGl3M0xsRnp1KzNxQ2hEOFord0cyMFcxQ0l3UCts?=
 =?utf-8?B?UFdZNlhEZWtTcEluS0RCcVl4RHBwSzM1QU42SGttendUNGs0THNua3o5bVpu?=
 =?utf-8?B?aEtTdW1OcnNsQXRNeEJWMlhnMklFNENsT2RaMzBMTlh3RGRJOTdPaS9rY0t1?=
 =?utf-8?B?Y2w3dGt5MHZYLzUzalhabXplYmt1RmpUY2JYeXF0K2lXQktROGFNb0xSSTI5?=
 =?utf-8?B?U0tBemlTeGFLTnh5aE9kckpVYmVQR1RxeXUyWTJ5SmNucnVLcGhxRllxdjVn?=
 =?utf-8?B?NTBrZk14N0xuZWdLbjNuN25aSjNiTXhSSWdFbmUyMFR4eThTcXMxWVNFS1dt?=
 =?utf-8?B?c09EUXZlTTBubzQyaEltQ2h5OGZZMTRLcWVaeHdyc1d6dmdiKzQ4RDdOem9a?=
 =?utf-8?B?cUVOM1g5SmVGbmtuWjVPTHdXNTEvSzJHNUpCaHlueXpxT2tCUFE2Z2owSWNa?=
 =?utf-8?B?bWJ5UVd0RkJpYjRRT2lBRm5mYi81UVNDN0FZaEswMGtHMDJnT0lWSFJXd1BN?=
 =?utf-8?B?OU5sUmxzQVo0MWRXc3RxeG96bkRDOTdrYWxPMjNEZlc2RmliRHN1YVJlQ1pQ?=
 =?utf-8?B?c2ZId2dRUGRBZVpJRmY4ekZNL0ZBZ0JUdmlhQnJwdkh1RjJYZ0Npd0ZwamlO?=
 =?utf-8?B?V3k1c3BQRGo4ZTh2eEhmSVhjNU1NSG9rNWZNS0UrclFKTHpFdkc2a2IyNEM5?=
 =?utf-8?B?VEV2bnkvaGdsVTA4NE1VR0toaVB1WDVjQSt4UjBqalJGK1ZNWU41cEdrd2hi?=
 =?utf-8?B?TzU0Z1hJdHVRNzRET1dFdVFCVThnMEd4MWJHNkQ2elpJZmFOV2JjekRHSjhu?=
 =?utf-8?B?Z3FUTjk2RE1ldDVXOGVJRTcrVFl4c1BtODhMTHZmYkh2QnhTRWZKeldRajZC?=
 =?utf-8?B?UllPRE1JM051dXhEREEwakFLWmVSYTYwT1g0RktYb3hIOS9jRVJaUUtiMWp4?=
 =?utf-8?B?MHBWckNBak5OUWNwbEc1Tkxtck5STEVZWEtzMEtXYVBicGozb29RUGtrNHdr?=
 =?utf-8?B?UDNBYzV1WGpYMVFTZWNUNzRxK21jQU4vNFFvNC9FNDFnd0tEb0Y2Nzk4S080?=
 =?utf-8?B?SlU2TzZ2V2x4VlIrQjVXeERHNHBBQWhPMFdsUGFCRWRScVpkeTlEVVRoTW5v?=
 =?utf-8?B?QldRdHo5ZlFnekt0NitUbkx1N3lEWWFpNUhmNjNodTN1bFJzUGc0QTJPMmpk?=
 =?utf-8?B?cnpsZFkycDI5a3lhTHg0SmZYakZpTC9JTGJsZUhTNGV3TjNrZEExUjZzZm1W?=
 =?utf-8?B?ZHprUG5KRWFJWFFscGxQMmx0SVNUN29vQWM0clJLbHo5QitDN0hNdk12OTkv?=
 =?utf-8?B?Q0VUUW9td3U5ZHBSNmZScnhuMDVub3M3QndUOW94SXZCZkp1dUZvQzdwektw?=
 =?utf-8?B?UkxsMmRNUklQT2NXM1VJTlEydXJCVFNOLy8rNW45NG9XSkpGSjRvU0Zvb2Vm?=
 =?utf-8?B?bkZyZDZxU0h4QjBBWFhQVjFCalhvcm1KT05hVTJMOERBOFQ5YVkzeXBobCtR?=
 =?utf-8?B?R1EyL2IyYXNER1MrRTVPTnJyMzM1T1JMUEdFc056YllNZlc2Yk9LTEV1Lzc0?=
 =?utf-8?B?cnp2YytaMk9lejB4NDE2UUlRdjJzcjYxNmUvVFV2WEhSL1hpNTE5VEJxQUJV?=
 =?utf-8?B?eHBvRlNidWMrY3ZnMVpINHJEYzhrdmRlRnBwcUdGWHRoSEdoTmJYUnpDVXFT?=
 =?utf-8?B?UVExa1l3REJZOUt3YXRFMDFwWGJUWGIrVmVBelRkc1IwcUFpaEdhWER2WjNG?=
 =?utf-8?B?VjhvOC9IUHFxM1BZQUhlRWZremdsQTRSbWFWdk1PdzRlcGJxWDFQOHlRSG1E?=
 =?utf-8?B?ZFBmQTZpdVArOUp0QUpjVmtFNi9yWEljRExzS21LZDJiOGNPcVBRRUk4YlZI?=
 =?utf-8?B?dXJZNzUyRlhROTBCQ0RlOXRUYUgxWU1YVUVlUklteFlubWVaanMxdksvaVJl?=
 =?utf-8?B?NHJGWUIrYXN3QlhWTitQK29DdHdTNTE4QnV4L1FTdDdXK0FWem12MEdYUkZT?=
 =?utf-8?B?VU1Gc3czK1ZpWDcwUS8ybG4vR05QdGlPVXk5T3VaMWI2K0xMVlAzRnc4ejg4?=
 =?utf-8?B?VWJyUVp4cml6QWErNGh1WXQrK1dreS9uY3BnRWEzOGFlZGtSejE4TXlTbWtJ?=
 =?utf-8?Q?7iCZ5Nw0EWAamUbzVlYjoCld7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e503e830-9c64-4901-d11f-08de341c27b8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:34:26.6206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dqANAA26tbbcS6mCvATcL/KFDGt6Oj45B2GMZvGCGbBhlNYeniqPHhFzP5dwSfvu8wHmWars8AhEHkDW5rEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

Please change the commit headline. Suggestion: "Check for NULL return 
values"

One more comment inline ...

On 2025-12-03 10:41, Andrew Martin wrote:
> This patch fixes issues when the code moves forward with a potential
> NULL pointer, without checking.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c            |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 12 ++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         |  3 ---
>   4 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 193ed8becab8..31b8fa52b42f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -107,7 +107,7 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>   {
>   	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>   
> -	return fence->timeline_name;
> +	return fence ? fence->timeline_name : NULL;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 5f2dd378936e..d1d72cd332fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2358,7 +2358,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	if (kdev->kfd->hive_id) {
>   		for (nid = 0; nid < proximity_domain; ++nid) {
>   			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
> -			if (!peer_dev->gpu)
> +			if (!peer_dev || !peer_dev->gpu)
>   				continue;
>   			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
>   				continue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ba9a09b6589a..1cb24092b17e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -516,9 +516,13 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   	int i, r = 0, rewind_count = 0;
>   
>   	for (i = 0; i < target->n_pdds; i++) {
> +		uint32_t caps;
>   		struct kfd_topology_device *topo_dev =
> -				kfd_topology_device_by_id(target->pdds[i]->dev->id);
> -		uint32_t caps = topo_dev->node_props.capability;
> +			kfd_topology_device_by_id(target->pdds[i]->dev->id);
> +		if (!topo_dev)
> +			return -EINVAL;
> +
> +		caps = topo_dev->node_props.capability;
>   
>   		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>   			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
> @@ -1071,6 +1075,10 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
>   	for (i = 0; i < tmp_num_devices; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +		if (!topo_dev) {
> +			r = -EINVAL;
> +			break;
> +		}
>   
>   		device_info.gpu_id = pdd->dev->id;
>   		device_info.exception_status = pdd->exception_status;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index aec7522407db..47783803f56f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1763,9 +1763,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	struct kfd_node *dev;
>   	int ret;
>   
> -	if (!drm_file)
> -		return -EINVAL;
> -

This is kind of the opposite of the rest of this patch. If you want to 
keep this in here, please call it out in the commit description with 
something like

     "Removed one redundant NULL check for a function parameter. This 
check is already done in the only caller."

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   	if (pdd->drm_priv)
>   		return -EBUSY;
>   
