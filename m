Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4472AD2E01B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 07:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E296210E763;
	Wed, 23 Oct 2024 07:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gyKcay+0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B98610E763
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 07:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8EKDCThuUkSz6e9qIOWKNohZOY4x9L/fMEry6IeqGMJ1OSzemUVcZ8bzO/fEIUObDzTSPMZ2EQwyxn/lSRuYzkZySgBmnX7UrvD8AFAL645ZWwajeCRpNJ3nvK3R27lZfM6HArdwn8t5dWEftbijxZpHcRKLg4O1oq8HXY86srCw3zSC10N/fIexYCsXpg6+cySh2OFi+klY9GkbJ8cn8KJK7AFy7naKztLI+hdy75e6iKvqPYKZSaBMM8qwcWIl5LTnkadV4bLikuoYMsqyw6bjOFtla+O+d7ZpvssX2mQpNh4PfsTFZW7LX3Vn5ikAiktpIlbhZXqIWHTIj8GgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBtA8XJx+f4zu65maurIPI6ZxDr+m6MyI/JVRavrhj0=;
 b=oqSIbjk5sSjmUg/lUtwXaHjZoY3ClUgRJYbO0u8TfLXGHFQCEdh6AMj4hDuH+4KQKnMWZmvcidh7K+oyM8yMaYk4Z7/x9XonFwwD1mc75fY9k+JmNlJgjDvL+QyrbW92q1iglIofho/vNK9+bbV43XHU7ySj2Ra4ogX5deOttF8iAQCoPvPo3IszJu71ub1s7A2Ldwn8uBMznqUGyvcexbLRNT0IjcCaF5E6RZiET2EbycLrh9ejESk5wcpDDikw7z/umsO1BU0ssFtuxGyC7EG47gmlBnj4i139x6zLNFohHT0/7jlkVhxrIzIK3WgVUCVa8QKypxyvyV0BcMlzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBtA8XJx+f4zu65maurIPI6ZxDr+m6MyI/JVRavrhj0=;
 b=gyKcay+0vhbVB3+4XCYMkrU6Vgd7S59GKJxpMRvbsfBN7JHWouKw824UhlI29QkEXKsNQKGt+/bt3Js0Kp7aG/atqd93IMQ5neKy6mF/TA/jpoVsLpEeDQXnObVXZjNH99bAuPqq1EtFMuAENZBAkk1AwZG/1HugcFu4wFzdW/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:30:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 07:30:09 +0000
Message-ID: <8d378b3f-559a-4f4a-b479-812175246c70@amd.com>
Date: Wed, 23 Oct 2024 12:59:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5 V2] drm/amdgpu: Add sysfs interface for gc reset mask
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20241023024311.2578441-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241023024311.2578441-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d6a58d-f821-492c-db00-08dcf3348647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk82TGlqTWFuMmRqSm1RN2ZuTDVURURsNk50ZFhvUFJycnJwK0VrV3pIbEdw?=
 =?utf-8?B?TzNzZjB4ZG9SUXVsR3dGbHplTTB6Rk1HVWpDZDgwOXh4QmtaM3ZHTGVFUXQv?=
 =?utf-8?B?SzduRENNZlpKejdySDQzUVpFYVY3K09XZWdtL3JhZTV6UE1POTB0ZUlRbHRj?=
 =?utf-8?B?QnJXSUR0UTI2a0lRYll5dWx4UEcvVnFLUGZjSCtVTzU0dnlCVE4zODRSV2tV?=
 =?utf-8?B?NmtWanhWdVo2b3hNMXcxaldVcy8vUTVMam5yRnZSeHA2WXUxUzZJNHNjZmhF?=
 =?utf-8?B?YVVRMHFnM3VQZHVSZHhuQUdrWFBUOUxPTitvRUhJNTlLa2t6TklaNjFEb3V5?=
 =?utf-8?B?VDk0ZU84T2cwbVlnaDU0OEsxNzBDakVkZkZXK2FoYVhjcVJyTXhxcHpRTGQz?=
 =?utf-8?B?cmR2bUxXQVVMRVJkaERXTDJtajJXRGg1YytHSmQyOWlsWEtMN3BGdWtRd3lH?=
 =?utf-8?B?UC9LN05sWlU2aDBGZnpNYnFwQUpERWJPYmRrRlp6eEVQYkU4RFMxbXAvY3J4?=
 =?utf-8?B?MGNIODJOQ1F4YSsxMjlXbWJCMDk2ZSthRHcycWg1aG1yZDhwYWtuYjJzKzlz?=
 =?utf-8?B?bDE5dG04MTV1aFpZZUJBWWIrNmUzWDFXdW1zby9jL2hMVXZVbVYzWGlvR0dy?=
 =?utf-8?B?dEFGZkZTbHhTMkZid2YwTFFVd0dEY084cDZPei9kSTQxY29IdDBla3ZyR3RI?=
 =?utf-8?B?b1QvTVdEb2pMY0VNd2FjSi9JM0JCaitJVkNEN1lReUZIU2NTeDN1dXNxbHAr?=
 =?utf-8?B?Q3ZDZE9mUzlkb0ZjRHRxT1NtRkZVd3JGZ0xKOUgxR1pNTDQ1WWZPbDNaTS9r?=
 =?utf-8?B?V0pkQ3Fwb2U0VHFiOFRsd04xbzRVZVkrYkNkbFQwUmpJNEtYRW90ZDd0MWVR?=
 =?utf-8?B?ZzhVWWpPUTdoMFQ1QnJEQTN6TnNJNmtxL0s0c3ROUlZ2R0ZFb3VRMHVkYnht?=
 =?utf-8?B?WHU3LytBQWV0S1B0b1dCbEppMDFGN0ZRYU1sZHlFbFJ0NzdkelVEYTFmOFpV?=
 =?utf-8?B?OEcwOGgrMVQycWEyM0lNVC9GVUxCNkxTUDl1Qzk1YUNHaFhFbCtZVnhjKzc2?=
 =?utf-8?B?MklxRTRqdDVPSUtvL21kMVFXK0xHbFc3MFVDTjhPeElER004S3FxeFBGOUds?=
 =?utf-8?B?YWRLMkZUN0ZJZzhOVGVWM2dWMmZXUkpHVlJOYTFUaTJyQUJEbHF2TWdCOTRQ?=
 =?utf-8?B?WHNpMjM1azMvY0g4UXpYQ0tqMUxyM0ZmV1h3bUNpc2czTEdET29DYkhDNlA4?=
 =?utf-8?B?N3d5M3B3V3RpdHloQUtTTXlYd2NNNUVMNlVzeEU1NTBEemdGaUpiYWVhaVdi?=
 =?utf-8?B?VGg4RVorSVJVTXFIMGZORjB1NzVaMnlaN25sS0JHQmk2RGxNcm5OcTRLUmFj?=
 =?utf-8?B?L25NS3JIOUtEZy9QMUlGeUl4Y3hsUlV4bGFLZ3g3S0pmU3NQNjJZYWxML2JS?=
 =?utf-8?B?L3kxMzFHdmNLYnN5cUUyNU5qTkNDUUYxQk9oUGxrQ20xcCtjbjIvQjJKSFNq?=
 =?utf-8?B?bmt2aWhLUGZmYUY2dVFxRWtTTUpvQWVCV3pUMm5qTWpaeFdTbGRhOWh6eG9Z?=
 =?utf-8?B?ZlpMUE9lNHl0dS8rU1dqOWVtbmlGU2FidWwwbjhNNG1OR0tzQnNtK3JQTmNp?=
 =?utf-8?B?dTNrMHVMNE9vWEFOSGpBYk1JVDFEbGhHUStwY29FTm1wMjExOUc1bkhSYUJT?=
 =?utf-8?B?NnBDT1I1cGFSZ3NOS0ZLVVJKc0F2ODRmcEVkcVNHLzVnRUNrSzFkQit3Q2ZV?=
 =?utf-8?Q?Y1NGssLKQmi55sbwnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmkyQzhZZzNoYTgvUkFNZDVvRlNGV1l2N1ZsRVc2djJxdGFhb1dyK3FFQUN5?=
 =?utf-8?B?NXo3VFNXZHdjcWdnbzF0WU8vZGYvejJ2N01QeUJvUkViTFMzdUE3VUUvMWp3?=
 =?utf-8?B?aEsvSDNWN0M5RXdBN3R0N3loNTdxcCt2UGt2a3REM2tlYWRoZGZTOS9oc0tq?=
 =?utf-8?B?ck5ZVk1zUitrQVZ0RkZRaHFMTnFpNFA1d1pkQ1Ztc2FuTitFQTlzUGpMQTlY?=
 =?utf-8?B?OGtIaGZUM240Vm05OTh3Z0xReXpiRG43NDFPZ2JJRkROUXZxNEwvRTFoTk5Y?=
 =?utf-8?B?OWdRellJOGdYcThoQy8xbjlLTllXRS9MSHF1anRVekZ2dGZJelFuYUdydTBX?=
 =?utf-8?B?TTg1TDQ1dDBZakVCNnVNUjNPdVRQNmE1ZWFvTmFtMXJFaGNZVlVZOVczMkRD?=
 =?utf-8?B?UFBPSzJIQTMrM3YvYnNVeHdzU2dIL2ZVUk1MbEdyaVBCUzdER0g2eUpnOUM4?=
 =?utf-8?B?b2cxS2pGK3JnQ29kM3lMVWFKbmVWc3F6cHNGMVd0V1FVT0h5aUxGSk9DSEFi?=
 =?utf-8?B?VEFTeTN3R2s3V2xFcDFZRFZHZ25sY0txc2lhZDF1UHRQYzUyZ2FKeHRKa0Vn?=
 =?utf-8?B?cXMxQWI4SGtIL3dLdUd0ZG9HRCs2WEhkUXVJNDFWUTdGRkd2ZXY4b1V1QVRk?=
 =?utf-8?B?YklldUF0aE84WkRQeXZaZCtMYXY1UXRiVUZwdlVNVGpiVEZURDFnbW8rWjEr?=
 =?utf-8?B?REt3QlBTTStJV2lQcEtuMExDQmo5cHowLzB2SUtoQ3RtUkRpa0ZZdnBVQjNH?=
 =?utf-8?B?RDRoME1mTXBFVmJHQTg5YkVtUEk5aDB3Mit6MzA4N3MrNFBydzh6TCtFSXpX?=
 =?utf-8?B?WWtZZW5hbzZkMWQ4SExvbUIva09FZHh1UE5SaXh4K2EvRzdEWElKWjhiZFhn?=
 =?utf-8?B?TGsyRWV6ZEZlZk5mcHJ3Vm5GM05ydDJEZWpzck5LRDEzRnNqUjZOWi9mTnJQ?=
 =?utf-8?B?UkE2Vk1TWEN0T1gxZXQ5Q2Qwd29lN2d2NTc2VVhhS0JNbkljdWUrZHpsRjFq?=
 =?utf-8?B?S211VDRGUC9mY1h1Q1lRZ3duT2ZlRmViTWZsbGNIVkxsQ1pKbERFeWlhU2dK?=
 =?utf-8?B?aDJsZldSd3VVSmRKVXVSa0ppU3BVc1VQOU9EUXFuTEtoTkJER29mNUR6VndF?=
 =?utf-8?B?cjJiMmlsdldyZE5kN0N3MHU5aXpFVkZpc3R0anNPdk1SMitrL0tRb0pZUzFX?=
 =?utf-8?B?SW5jNEtoOTdKOUR1a0FqU25ET2Y2UEhBaEM4cUdmYWxKRUZUU04rdjlsYUVG?=
 =?utf-8?B?Z1UvbE8za09CUHRYQWxrcUtiTXQ5VG9vSnFnZkM4VTJsS0tCaHhFYWJmY0lk?=
 =?utf-8?B?MmtjYmlwK3Z4bzlQWmp0NVJodHVFODMyb2NOZUxnU1g1YTQ4ZndSaGtmb1c1?=
 =?utf-8?B?YmJLSDhqRDJtemkxSHNHOVFRaUh1dEppV1dRRkN3QlRpYTEwdzBoL1lCV0l2?=
 =?utf-8?B?dHhRWFV5RTdtZ1lYNjlHc3Y5Q0dCdm9sK05tajNZMWZOS050VzdveUhiR0tU?=
 =?utf-8?B?MlowVEV6KzBzTzN1Zk9sRGYzQVhXMHpaQ0Fpc1VodGlETkkzMGRURGJSNWRa?=
 =?utf-8?B?dXJNRkpueWNXb1RuVmVWeHpBVFR3LzczMlZiWmh0S09Bb1JMTWNIZ1R1Wlgx?=
 =?utf-8?B?NzRzZUVmNGlnQmFmb05zc09jVEFpOFk5OGprZzRHa3l3NlEyT3l6eDRLUWVV?=
 =?utf-8?B?eUlmNjk5TUlCSlNOdllHc3RBU2FvVTk4ZnlZRDNCRjdJT1ovMnZFUlVqa1Nt?=
 =?utf-8?B?aWc5dm5iWjZVRUtqTGhMaHpMUlQ2SS9DM29CYlRIWUQ0SFlEcVBlUWhJa2cr?=
 =?utf-8?B?ankrbG1EemQrRnViVUNzS2NBMWl3c1pxV3dPdjZtTHB1TUkwczhPMmkybmta?=
 =?utf-8?B?eGxjOUNtbUFvT3ptRDdPQmRmRWQxM2Q4V0FZSXNIQUlaUmxtalQ2Nzl0ZTBn?=
 =?utf-8?B?cTVJQ0ZmSmo0eUdSWjh5U1A4YW51eCt6TTVsWWFyTTI4cmNMZzBabmg3amNV?=
 =?utf-8?B?RHlKSmZ4ZVdvRDB0aWQ5YzhScVRtTGRkUnZDVmhxb0xLeFA5aVBsKzRpVEZ5?=
 =?utf-8?B?T1F4cStmZ0VtY2k5ZTluRFhIUk5vZFFDREgxaERHZ0NJRWJhOWJzK1A1TGpO?=
 =?utf-8?Q?DdS4BhELZm1vAYMcUWYUvvA3g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6a58d-f821-492c-db00-08dcf3348647
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:30:09.8926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt7uR7Bs1Opw0fp/sO1/nDjk1wWqFcCXsZ8bbhh34eDWnp7MnUUqOHeSm8tf0lhL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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



On 10/23/2024 8:13 AM, Jesse.zhang@amd.com wrote:
> Add two sysfs interfaces for gfx and compute:
> gfx_reset_mask
> compute_reset_mask
> 
> These interfaces are read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc),
> soft reset, queue reset, and pipe reset.
> 
> V2: the sysfs node returns a text string instead of some flags (Christian)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by:Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 122 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |   6 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |   5 +
>  7 files changed, 150 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..10d55755ee88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1588,6 +1588,94 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
> +
> +	if (!adev || !ring)
> +		return -ENODEV;
> +
> +	if (amdgpu_device_should_recover_gpu(adev))
> +		size += sysfs_emit_at(buf, size, "full ");
> +
> +	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
> +			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
> +		size += sysfs_emit_at(buf, size, "soft ");
> +

If amdgpu_gpu_recovery is disabled, then that check may be made before
creating the sysfs file itself.  It doesn't have to be here.

> +	if (amdgpu_gpu_recovery && ring->funcs->reset) {
> +                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +                case IP_VERSION(9, 2, 2): //reven2
> +                case IP_VERSION(9, 3, 0): //renior
> +                case IP_VERSION(9, 4, 0): //vega20
> +                case IP_VERSION(10, 1, 0): //navi10
> +                case IP_VERSION(10, 1, 1): //navi12
> +                case IP_VERSION(10, 1, 2): //navi13
> +                        /* Skip flag setting because some cases
> +                         * are not supported by current firmware.
> +                         */
> +                        break;
> +
> +                default:
> +			size += sysfs_emit_at(buf, size, "queue ");
> +                        break;
> +		}
> +        }

This kind of version check is not good. Instead initialize
supported_reset_types in IP version files. As in the compute example
below, sometimes it requires FW support/other checks also, not just the
existence of callback implementation.

This function may just iterate over the type mask to print the text version.

Thanks,
Lijo

> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +	return size;
> +}
> +
> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
> +
> +	if (!adev || !ring)
> +		return -ENODEV;
> +
> +	if (amdgpu_device_should_recover_gpu(adev))
> +		size += sysfs_emit_at(buf, size, "full ");
> +
> +	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
> +			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
> +		size += sysfs_emit_at(buf, size, "soft ");
> +
> +	if (amdgpu_gpu_recovery && ring->funcs->reset) {
> +                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +                case IP_VERSION(9, 2, 2): //reven2
> +                case IP_VERSION(9, 3, 0): //renior
> +                case IP_VERSION(9, 4, 0): //vega20
> +                case IP_VERSION(10, 1, 0): //navi10
> +                case IP_VERSION(10, 1, 1): //navi12
> +                case IP_VERSION(10, 1, 2): //navi13
> +                        /* Skip flag setting because some test cases
> +                         * are not supported by current firmware.
> +                         */
> +                        break;
> +
> +                default:
> +			size += sysfs_emit_at(buf, size, "queue ");
> +                        break;
> +		}
> +        }
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			adev->gfx.mec_fw_version >= 0x0000009b)
> +			size += sysfs_emit_at(buf, size, "pipe ");
> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +	return size;
> +}
> +
>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>  		   NULL, amdgpu_gfx_set_run_cleaner_shader);
>  
> @@ -1602,6 +1690,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>  static DEVICE_ATTR(available_compute_partition, 0444,
>  		   amdgpu_gfx_get_available_compute_partition, NULL);
>  
> +static DEVICE_ATTR(gfx_reset_mask, 0444,
> +		   amdgpu_gfx_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_reset_mask, 0444,
> +		   amdgpu_gfx_get_compute_reset_mask, NULL);
> +
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1702,6 +1796,34 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>  			    cleaner_shader_size);
>  }
>  
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	if (adev->gfx.num_gfx_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	if (adev->gfx.num_compute_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +{
> +	if (adev->gfx.num_gfx_rings)
> +		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> +
> +	if (adev->gfx.num_compute_rings)
> +		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
> +}
> +
>  /**
>   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..0cf2151b3cf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>  
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..2baa76095232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4856,6 +4856,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>  	if (r)
>  		return r;
> +
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -4908,6 +4913,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  
>  	gfx_v10_0_free_microcode(adev);
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..32d14b9cc6e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1721,6 +1721,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -1783,6 +1787,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v11_0_free_microcode(adev);
>  
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..925b7ca49b2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1470,6 +1470,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -1530,6 +1534,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v12_0_free_microcode(adev);
>  
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..0de199c1cfdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2394,6 +2394,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -2432,6 +2436,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v9_0_free_microcode(adev);
>  
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..87cfd77e2fb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1175,6 +1175,10 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -1200,6 +1204,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v9_4_3_free_microcode(adev);
>  	amdgpu_gfx_sysfs_fini(adev);
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
