Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2038CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 09:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D17610E3E8;
	Mon,  1 Sep 2025 09:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pu1Mp9jf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D69E10E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAp1fytLoA3Mka2zc9Ym+Bw3KSoSR5+gGV0mVBk36YsWukYRlvYtHIUjoSg3lUwHw230zrHEALgo7WoomJjjGzyiJgZ2qUhlDDC6//dqtqE6MIKYE9A8gm5ryWsxQXa/38a1Fq+EzzbmjDRqhicvHLwcpVnNZZlbo3+/UgpDbtG/o5E1hL/aYw46AKa/gZgrhD5eCYU90L+yyl8QldvPON8mo5A2i6fUaynWc4eiTV6hfN6zmgnxyRCLzvLJZKp5adTkodRmFY5JXCoqH64M/GdkhaVIYY402Dba51bpKTeUGNSERYSp1Fstw+rVFtmOREi3lzTUYL+21HUFj/Dgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnMGH0FXqyhDRE18xqzH4fCoSrOIyOgaJAJd14GUXAk=;
 b=W6DLBmfkeqVI/s6SzUD5C9fAsrbz3NvhJUkT+g0jUV78N7jdEi/8JhGxBnOo4U7XhwPc6X8bzmM7HmztsAG6DvjPN5p7Vvl3PNdLuCXZT5gy3uUg7s3BYlfHcq/6pbq2jhQ8ktumrus3tZOEVyrIANDOvzbpi3P4X7i7oppklyEt04k0WO5xYP4TT+4V5+VFnGbxB9GVtmQe0LQSXtijJ6FB5qT5EMng6WiGlYvXCoAw52RW+EV1k9pENVnh0byrZPz4G8LzxkwySdGBFB4tfKxaPuOpLOZnDd1PlmpgwBUYLcN65tKt35JGXZaBRRcAjPmE1TLwVqwbW34H50wfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnMGH0FXqyhDRE18xqzH4fCoSrOIyOgaJAJd14GUXAk=;
 b=Pu1Mp9jf97LWX/czs43/OXDpvTerEXSxN93RGBWiTY08dlSyS22UyJN1YiRUSvSWhCJXJEU9BXdlrJsUmfe3xfTpq2ONsOqt3Ob23iJxf6JMNT/W2p7X6QyDlRwA4XoLomD5Cao9AaCA2cIsJUj/8m2ERK53rEDfWuXRZsa00a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 09:20:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:20:32 +0000
Message-ID: <d1a01197-6c80-478d-9bae-1904a612a1c6@amd.com>
Date: Mon, 1 Sep 2025 11:20:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-9-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-9-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3760dd-cf92-4415-8f35-08dde938cccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejRIQzJzVDZBNVdVeHprc3Q0OXVPYmxzQnByNW1sdmRObVY4eE0wQ1d2QW9B?=
 =?utf-8?B?eGFRTTdjSGhRcnMwaG5Qa1IrKzNLY3pFKzNTREpNaGJtTXV3SjYvbjlLQzB0?=
 =?utf-8?B?TjhDbTBDWXFUdXZjTWVzeU43L3NTKzZPTnJ2VFZkRDlHZFdKV1JqNUZseVRQ?=
 =?utf-8?B?cGVIclBteTZkUDJMZWJQcExwa1pJYTRVSU4rbGxDckZadnRaV1owZTJoR3VO?=
 =?utf-8?B?N29YS2lpUkN6T0NORFlaSFpGQTRLdWY5ZzRQRHZCeDNUcmRnMFEycWkrQWpz?=
 =?utf-8?B?a0UxZWpTUkJiUjQ3dDNJQUdlRTRLVjdrSWp1UkFlWVUzUSsvTGhIbzZiWkdt?=
 =?utf-8?B?bHpRN2dNd25iNDIwZEprdGU1RjB4OTU5MFRWRG5rM0tYRVhhM1NybTdJYS8w?=
 =?utf-8?B?SGk4RlE5VTVaVWpBaHMyS0xjcnNLa1BjTXFGUzBQUkd2bnR0MUZkTy92R3pR?=
 =?utf-8?B?cllqOFZ4T1lwaVJ3UWp6eG8rL2kyT0hySmlCOTNlb05MTkFQM0tGd3p5TCtq?=
 =?utf-8?B?TWdsQXFNQThHL0NxS3duaUs4OXNpOWVYZkl3YS9QSzNJN3Nhb29EVTBuNlp0?=
 =?utf-8?B?QytEQzB6cExSQ2cxZ24vc1grR0hxdG00VlpaM0VHWVNIamdSb20rOHM3cVB0?=
 =?utf-8?B?Y0wvWm5FRHN0SG1UWXAzazl6UHU2SVE5VWdBdUU4c2Q5VFFoQ3ZsWlM3UDRR?=
 =?utf-8?B?eHRSa2pNdmZLRWg2ZFprNG1zcGR6Q0xaakxkR3BFY3AveWJOOWo4VDR0UnU5?=
 =?utf-8?B?SjZwTm5RdGVOZ05qQi9pUU5OZXZCNmY5MEFpWktKck1BNWFLS2pqVlRkeGti?=
 =?utf-8?B?bU5LUGtNWGcvemFtRmtaeTg3b2VJWVVKYUFzUzFvNmxzM1dlOTFoMk9mNTI0?=
 =?utf-8?B?RUJXVHFKaWtoTkJ2K3hJTjdYUzRHSEh4NVRkQU5lZlNsbldNSUxIVEpsZDlB?=
 =?utf-8?B?SFJ4ZWtwSFNFazJLTXlIWjdRM1dDQUZmenMrNUpFdyt1WlVCY1lWanhJeEtD?=
 =?utf-8?B?RGtUKzRrdloxNVRwSnZVR0JOQ0xIK3pBR2QzRlNxZ3lpOE9XYjRNSzRkQ0U5?=
 =?utf-8?B?SkNFWXI2ZWt0em14UlM4cmI4Y2szZU1qVCtvT3FURUFUamVXVHJXYU43VmlL?=
 =?utf-8?B?NERyU3lOc2RYSkpiV1lqNjAyNVJIeHlaT1ZwSmtsL2ErN3JxZGVQUGtJdHF4?=
 =?utf-8?B?Wit5eU9ibk1yTzhoL0FzdTNlcXh4WG4wNDAzRDBpZGFKbXNVZ2gwSjBNNTZn?=
 =?utf-8?B?TVA3bHNONS9PYjNESFcvc0pJdi8yQmwrVnZiUEZNZU55OG1XOXFPTDVxamNS?=
 =?utf-8?B?TktkTHVFN2lkeHEyTmVpMjY0cTVub0htcURsbFdhYUhyS2VoeWxmNUJudDV5?=
 =?utf-8?B?bWtRRWtud3lsbVplUzR3S2gxNEJXQmpOOWRyNGlFMmdvaDgyVkVKUjNGUm9i?=
 =?utf-8?B?bFdkZUlRZ2MzZzFGV3NXaFA5bzFJQmg4K0VXSTBRbHBBZEs0Mk9qOHZxMTRm?=
 =?utf-8?B?Ymx0VkRPV08wSkNreGZta0lVY3IwdG52T0tzbUxKWjBrOVo4dnFLOVB3ZU9H?=
 =?utf-8?B?TG5aN2pqdGdySXNCTk5vbEQ5eFB2ZWhBdzkyd2E3bjNKdjEyOGIrRWgyemxl?=
 =?utf-8?B?NzJXK2k5SlZJNVpTeWZ1R3VYaFNPUkhMMjJXSGtSMVVHVWNQd3Rlb3VRSTlm?=
 =?utf-8?B?WjlUbXprMmZ4am5jOWxsU1VPZ1lpd3g0UXo2eXhDWGgzYnVIYXMvUDk3QXpH?=
 =?utf-8?B?eDFBY3h6U0cwaEFVSTI1alhzMnVPSnFnRndaL2xOTjh1OVcrdHlqbkpQaEho?=
 =?utf-8?B?TWNZQUhXcWdNcVZRQkU2aGlFd01IanFZMyt2RzFIc3BzUWU3cyttSS8vMjVV?=
 =?utf-8?B?YUM4bUpQUFFJZVJXdnQ2NGs5T1FENlV6eVdiSW9qRllPbjIzN0Fjcmh3VlFr?=
 =?utf-8?Q?jMv931htH8Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW10NkpBT2dndGpwVmd1L1d2Sm5ncG5ZclJEOGFUS3ZDTDVkR1QremdIMUo0?=
 =?utf-8?B?WFEwNVJsSHYyKzZnY1RGNFR5NXM2SmhWaUVuekUyakNMNnBzaHdhdkkzaFpI?=
 =?utf-8?B?MDNWTzNRMFpZS0JNaXBZTExrY01jbVRjbnUvQm5kWGRlTWtyTWs1NjBSbnZa?=
 =?utf-8?B?ZEhoa3lBZHJIenMvSjJaM3V1OC9qRlNOWHlNbWFRVkNLZEhwZWlWdCt0dmNP?=
 =?utf-8?B?bmdxQmlYUFQycGJIa3RNMkhXWW1CbCtyenVnOTdGbWlrK1U3QmwrSGhPYnpB?=
 =?utf-8?B?N1ordE5EZFlBMHFaYnc3eDZINHJiMDIwRGdVdjg0ZElYOEZWZkFYT0pjS05k?=
 =?utf-8?B?amZJQXlob0RCRkQ5SW1GL0ZnSnVDSnU3V1JvWmt3Wld2WDJ1eDBlS1pNMU1k?=
 =?utf-8?B?cW9Xd0cySnJBSnZMcXIrYVUwazd0VlRrTnkyTlYybVNPajVWaUM2Tk0vYk9V?=
 =?utf-8?B?aHZqbmtSYXVPbktOanREU1Jzb05ueEF2c2U3K28wWWxvMHFtWGloUFFHRVBr?=
 =?utf-8?B?MXlWUkR6ZHpOWkFLRmdVSDA5SUhEV3YyQ0IwQXF5aHVQUEg4Nlh6azZXR05K?=
 =?utf-8?B?bmRqdlhZM251TVdDY2FLQ3NmY3pITWRCY1htYkZjbWFkMTBBSUJ6ZUVmMGZy?=
 =?utf-8?B?c1hUNWludzNuMWVNQ0JUNmpLYmdDSHhVL3FFNjV3amZZR0tFVHp2MVVvUkpp?=
 =?utf-8?B?RTd0VytmNGZ5eXZXeTFDWlFGa3BOaFUrOTE4UGhMb1F5UmNjdkFGVFoyYjZJ?=
 =?utf-8?B?NjRDSnBHcm5CbGdZOEJvSFBsTjQzU3FiTGZlanRJck5BWFc5cnRYL01UVEE2?=
 =?utf-8?B?a1RzRXBHdkRXbzhoc3RnWlJsNitYSU9PeU14RjFCdHJiTmRGaThiN2NGNStS?=
 =?utf-8?B?ZHdCalMvM2ZZaWpMNHBldWpXQ0xFYjhCWml1Ri9RMGdRK004WnJjVmZUSXg4?=
 =?utf-8?B?Q3FuUVNENC9SMjh1SkRJaUN3V0NQdnZ6U3ZLNDE4MU94U2R6Tk5veUlxVnha?=
 =?utf-8?B?TnJZd2lRRVE2emY3WFZhVGoyVkR3SFAzbU82dmE1VlZFVyt6RitCcis0Wk1G?=
 =?utf-8?B?YTNNQmRYY0VLVndxbEpKdXdJOHNTR2RSNkl6ZFdZOU5VVGFPcWpEdUI1WWJ6?=
 =?utf-8?B?TlNYY0h5dHNpL1RoR3Rmc3pxbktORUFYajJYYWxYMi82RC85dnQzOVFpNE1I?=
 =?utf-8?B?ODQ1YW9hUUtqcUF2S1F6SUtlcjdVTEVQQWo3U2psNVZSQko3ejJiOC9YdmJp?=
 =?utf-8?B?VkdZdjA1Q1F1ampEQlJUWXFOMlhtd3ViSUlISVdjMzV6QnkvRDFSMkdNSG9z?=
 =?utf-8?B?eC91MmFYQjJLUVE3QytDSXNaQzRRZm5WZlV2eEt2QVBXU01NR3hhMkxZOTkr?=
 =?utf-8?B?enRiaWVDWWhCbkVWeHhZZmZaVlpSVENHdXR0S3JZRHVzNU9wTHhXMlpQNnV0?=
 =?utf-8?B?MWlmelBiV0dxSHh4NGdaZE9mcUM5WEx3NFcxWS9VM2cxRTlIVmNYclo2N2tr?=
 =?utf-8?B?clNSQzJkd0NPTTZmSktuMDNocDRQalFwQi9aTE13UUFxZi85Qkl1L0lDbDU4?=
 =?utf-8?B?d1lPVWkvZUpEWjhGRkJNR1NhbmlTZWVCOHg1a0NsaEJrWlVDQkdaeWtOeEhq?=
 =?utf-8?B?eWRhbmpwQ0pFMEhkeDFYdXhDLzBnTTkwQjdVMmZWTUNzd2NkRFhBKytScTFP?=
 =?utf-8?B?ZlJ1OXJEZ2hxSC90N3JVWFhaUmdpOW4wNnNYZjZxWUxpd0l0dDdHRXNNWXNp?=
 =?utf-8?B?bXBGMU93ZmJjQ2h4bFVDQ1J6K2V4RDBHYVRkOGl1VVJ2S0dkSzlTMFVpNHpL?=
 =?utf-8?B?WTBqSDNaaTM1UEx2bTArSTkrenJ1ZzhrNnNTbm9EUFI5dUNoSWxhMTlJVjVr?=
 =?utf-8?B?QkcyK2llSmppNGFHZ2JjM2IrakN0SnRxYzNHTUtodllRNUQ1b0p3VUlTUG1m?=
 =?utf-8?B?SUxLRkNxcW5KeFRibzhDTFZvVGFLK0o4a0t6OWMyUVdQQ05CdEVSSWFjRDRH?=
 =?utf-8?B?RVBMTXN1MUVhdEd2azNza084dUJzV3J5VUc3M1A2ZGdwaHZyclNXNUFidmwx?=
 =?utf-8?B?WDJzU0dXc3RpUTQyVDJYL0pNTU1Mc2NNSTY4NUhZdTlOSkdncmdBbGtybkVx?=
 =?utf-8?Q?bAOW9iN5OiLRkX0bhppVMJg9H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3760dd-cf92-4415-8f35-08dde938cccb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:20:32.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnNZxoUncSjKj/P8U9z33uJ+daOvdnp0EmIpd5pU521JtKlkqGzJpwVsa/J3H0uv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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

On 29.08.25 15:55, Srinivasan Shanmugam wrote:
> Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
> one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
> hardware exposes a remap base (adev->rmmio_base) and the host PAGE_SIZE
> is <= AMDGPU_GPU_PAGE_SIZE (4K).
> 
> The helper is idempotent (returns 0 if already allocated) and only
> returns an error when the actual allocation fails.
> 
> This keeps MMIO_REMAP lifetime handling localized and prepares for the
> subsequent patch that exposes a userspace handle.
> 
> v2:
>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>    rmmio_base. (Alex)
>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>    (no warn). (Alex)
>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>    is stored in adev->mmio_remap.bo and will later be exposed to
> userspace via a GEM handle. (Christian)
> 
> v3:
>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
>    (Alex)

You should probably sqash patch #5 into that one here now.

> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 57 +++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7305d40a62e7..23510aeb4a1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1853,6 +1853,57 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>  	adev->mman.ttm_pools = NULL;
>  }
>  
> +/**
> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
> + * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
> + * GEM object (amdgpu_bo_create).
> + *
> + * Return:
> + *  * 0 on success or intentional skip (feature not present/unsupported)
> + *  * negative errno on allocation failure
> + */
> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +	int r;
> +	struct amdgpu_bo_param bp = { 0 };

Longer line first and please don't initialize bp (you could memset it).

> +
> +	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
> +	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +		return 0;
> +
> +	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
> +	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
> +	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> +	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
> +	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +	bp.flags       = 0;
> +	bp.resv        = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);

We need to pin and kmap the BO here.

Regards,
Christian.

> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> + * amdgpu_ttm_mmio_remap_bo_init().
> + */
> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +	adev->rmmio_remap.bo = NULL;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2027,6 +2078,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> +	r = amdgpu_ttm_mmio_remap_bo_init(adev);
> +	if (r)
> +		return r;
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {
> @@ -2090,6 +2146,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>  					&adev->mman.sdma_access_ptr);
>  
> +	amdgpu_ttm_mmio_remap_bo_fini(adev);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
>  

