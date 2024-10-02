Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818DECF6D2C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 14:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF9210E735;
	Wed,  2 Oct 2024 14:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P0E7NDyJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C49A10E735
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 14:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2xuWcNDzr+03r0aHvk0VOPxqjNw1ztuKp+ymdvW9HP2UljMC2YUaAKHYdMM6wmmBqNZlscfKnVNnE6WhqnjJOJUatNs86lyCk0yal4uTgFU9QRK3hDIMQhwnEkj8Tenpm4eU1fy58dpWwt5Xui8azDhFY5o4gMX+hr2vC8m5jIhn5agKHE4IRObvkJo0DSz1OyscCmzEutqT6Wn0tDwryBUZ7Zg9i2BLhtrgJootiAQt3lSZSJZsbjkgP8JSCG2t2jb2QGgRBL+WpdrNveqnjXC08iAp4lhPXDDdCp2w+96vqYuMMvepfHmOUSJRi5TGo+v0yhAAuxKNyYvZ5IUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPq9Fv0FMcAq9d2V+ZDOJS9Je7u5mP4RpQFPCUd5ltI=;
 b=DadyweITX0ny1LdH5yhbgTPGUxjKZdwraCyvBNmeNj8GX0nVa4QrXHW9/heh2esk8U/sImGBBX5DDsnIU6NDft/mTkmB0zIsIw1BFylBj6av+S1J6qnWk3fWADrnZnSNAE0iDHdlnrNulUBBrsF/3kvjs/tY+itlB8FCLD8owjAxOacYoMnPMMgankbzDcs3dz76jfEtcsfdqe0VvCmri99Ru0nQVMJkdZ/mDWwnzJH8IEcFvAcB02U2z/uwTzeVYmyLM3wPl374O1QQ2BZqdDHZsgShMSu+15f1ZkFRKFwW69PZiE6zOxZ+7wMdyr9MXZnNvGV8xiMdnvu/05UWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPq9Fv0FMcAq9d2V+ZDOJS9Je7u5mP4RpQFPCUd5ltI=;
 b=P0E7NDyJL48CPvADSS6yZNExJNur9eeCoKeYSfRktCLmc/bR9I8/jXl/zVbLrBxHHOAPVWtLRAFPsXOJ1pph2BkeU3e1L0TDaAIeQoYw57/fkTTwV5+brJK8J4BrSjENCJBXTIvCfDOgDapffvmLI2NtOVUEam+wF9CZLKKS7Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 14:03:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 14:03:29 +0000
Message-ID: <c1a098b9-8f2d-4b1d-a34a-6a98d9e4629e@amd.com>
Date: Wed, 2 Oct 2024 16:03:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: change the comment from handle to ip_block
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>
References: <20241002140013.162323-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241002140013.162323-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: b7474073-9f31-4b89-a34e-08dce2eafe15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXRNRmEzY3c0ZnRJanZ4Q1B5SkMzdkQwdUNzSnJoMlIyZjNkdU9OSng3c1JL?=
 =?utf-8?B?c0dNSkV1SU1SUkNmSXhTYnB2azVBbEZmaVZlRWxzcXUzSlpoby83QTRjLzNV?=
 =?utf-8?B?VkxBR3pzcWlDS213b2JxTkNZVWVRU2RTaWZWVTYxUlVaSSs2TEhieFcrcFRt?=
 =?utf-8?B?MFo1SkxmM0hvVFZOWEpBeFUwUVpJbVQ2SFVhbGRZQ2RNQlNhTkV6QUllTnFw?=
 =?utf-8?B?azcxK2pJaGthYXRpd0FZQldFMTE3N2d0YVQvdHpWVjViMkhuQTlLS0RLVXY1?=
 =?utf-8?B?cHVHL1J6MVVqYS9VcUZkTzZYd3AzSHRMaXpRMnF3aHp6eXE1TlF2cHJZNlNr?=
 =?utf-8?B?WG40UFJYd2ZKaTRiNUowbVlBVUc0UVBRWXJiWk1lSDJzcFBMMjdubHJNQzdC?=
 =?utf-8?B?cnNJQWNJYUNOOFdWMHV2L0pmL3dsVnlCaldHaGJRbFp4aE55RVY4Q2I4OTdQ?=
 =?utf-8?B?QjM3cWNscVpwdFpqd0t0UHpmbysvVVF6Z1YzZVhacTV1b0pxM2JPazBrdWVQ?=
 =?utf-8?B?bmp0cmk2R3k2UXg0cEJTL2VyTitmMHFvZnVTWWJtcGRYSEF5aUxjejF2S0JC?=
 =?utf-8?B?bjF4R2N5SldFSGZzYzR1Q24zSHJUcXFPU3cyQ0NQeU50Tm45azFYQ0tDTElJ?=
 =?utf-8?B?L1A5REg1TnFPaFp2aytsd0dXWDNQa0VOc3VOWHhFei9QY1RtOTZsekV2MXV5?=
 =?utf-8?B?aUcvWkFoTEoxNnFCK2g4UUd2ZWU1NUF3aWJZRHVWQ1FGUVhGczNYVEtvNXMz?=
 =?utf-8?B?eXFUaW1tZUtac3FIdS94RzVKQ0JVaXhYeTRPWGxRdHBoOEY1SnRJVUo1RzND?=
 =?utf-8?B?OGhrTTdNNS9NSXVLUFBTRlcyc1hTSFVvWjVQQkdXOVVNcWNXWGt5WHh1RFh0?=
 =?utf-8?B?S3p4SXZuVld2RVMrR1h2L1JPMVNlaWcwa3ZQNTkwSWhObUJpZTY2eVVFZTYz?=
 =?utf-8?B?cGR0Q3pzb3NuQ1VXK2Mxc1g2U29QMU5IbzVhNXM0bXhUKzhZWmtReTB1Yzk0?=
 =?utf-8?B?V1VTR1RSUzAya1YxQjJ3NFA5djZ0VnRRbDVtUXJHcmc5SGF6SmxvMFdacTRB?=
 =?utf-8?B?c2F3ZXV0SDZDbkZCeFVXOXZ2SVN6YmkvZjhvNnRuWlIweWhram9JZFRHQ28y?=
 =?utf-8?B?R3JKV2syNmNrZEpsOFl6VStCQTJiclpNSzV6ZUtxbEl0SzdxRTE5SVZLalR3?=
 =?utf-8?B?UG45QzRCaDZuRG9EZk5qSlNNYzA0d3UzaWFSbi8wbXpib3JHUS9LUlpOc3Vz?=
 =?utf-8?B?OEQ4cGwrczJuejIzY01RVm5YZVNBejJCaWc0KzUyczVEemRPaHR5Z0VISjZT?=
 =?utf-8?B?b1JENHRNSlBCcEMrdVpUaGNuYjFQQWJKYi9uT2taQzFoL0xNQ3d6dE1GbVlq?=
 =?utf-8?B?VGw0ZHRzSlBGU25Ka1ZuYmMvcTJPMU9TM2ZEVHFCdFNuUG9HMkpFL1FEN0k3?=
 =?utf-8?B?VVpxQ1pnNDZDK0FraFJjaE55QTZZQm1mRDErOExxWFBVaHdaYkY5dkVTa0Vq?=
 =?utf-8?B?ZTNTaGRzTFZwTTFoVmpvRG9rZG9relpWdWxlODQ4aXFmR29GWUlEMHZVMWV0?=
 =?utf-8?B?dkhCdTVjVGVqL2pLdXoxaXh3dFVlRkdlemQvUi9rNkc0WlBmdmxIMURJYkZH?=
 =?utf-8?B?T1FvaWUwSm0xL25FUmRiS1IzREdBeE90UThMeWxydXZDY28wd24rVm9EdVFy?=
 =?utf-8?B?SjJuV0JpOXg1cTJNR3hFbm52RTMyZzg1OVBhL1h1SndzOEt4dm9xamdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkp0U1U4VHZiVHpoaTNhdGdRRnFHcjFNTDY2U0Q0bHpHMCs1eEVBQ1R1aFIw?=
 =?utf-8?B?ck13Vlh0a21kZ3loZjJUcHVPUWhBTk1SWWUwSys5QW96dnd5RmFnMzNKVDlQ?=
 =?utf-8?B?dFNabkhpdlRvVFBLQmlMWWNsdVRKUzgrNG1hWS9WR0hLcGMxSXB1cWZvOUdk?=
 =?utf-8?B?dGFxeHBZd0JYd0RTZ3B5eUlYM1FzNjJuOHl0OU1HS1lGMEIzWE1HWHhoSUJy?=
 =?utf-8?B?SnkzKytheFNIc050ZjQ5RXhHZGN6aTJSNEQyaEhQNit0NG1sK0dKYnczb2x3?=
 =?utf-8?B?c1Y2VXhxUVNIUzhxb25XRkczOTMvN2NNMEdwTWZXNnV5aUtpSmxuMmRITi9B?=
 =?utf-8?B?Z2g4ZUJHS2xFT21EUnlSZ293cnVOSFdzNnlWdytTbXRxNUxkeGJBdkhNNUFU?=
 =?utf-8?B?elpFN0JrRXVpY05UMUxhV3AxZlFaWCtyY2lhaGdMRm13enNoa2lvMGpCbTN5?=
 =?utf-8?B?bEZaMGcxdWkrQWp4Sjc0cXE2OFJjcmhZWUxqMEVZZ2RNaEluSEppanJxbWpS?=
 =?utf-8?B?QjhzYUZ1dmxmTXg0QkcvUzhOZ2ovSDZGMVNDSVd3QUFEdzVyVGhFUHZGMld6?=
 =?utf-8?B?azdMVWZielFvRVNnai8vQ3AyMHpOWklNZ0haMUg5amo3T2NhSWZLTFZBM0NV?=
 =?utf-8?B?aXlXOEpvelFnYnhJUGNNSEx5UFYvdEY3RGhiQUdFYTNrRCtwZWNnbWkzaWJt?=
 =?utf-8?B?a1MyU042aldtSGc5VTB1cHBSWFhWNk5uQnJoV1FIdWtaYWplc3lKemNKUytL?=
 =?utf-8?B?UldYaEtSYXRiZ0ZGeVVlTmQrZXM0L29HWWVTWHRuMnA1UlNTZGhKSmtpSS9G?=
 =?utf-8?B?OUJReUh3R2lvazY2QlNhV1BrcHl2K1c5am1IUFdJQ3lUOFMyYmg5TXloaEtL?=
 =?utf-8?B?QzlXU3AvRjFuR3QzaExyR1pETCtJL2N6ZWc1eUpHTlV5cTBPTi9YS0NyM2h3?=
 =?utf-8?B?ZVlzRXZuUUFXTkl5VmhhWXkvTkovZVJaY21zeHM3a1U4Vk53SldISWxlQXdE?=
 =?utf-8?B?WVJMVTRNN3g4QlZDS3YveU15eVRsUDBYY2drZ2ZYRFp3WGtBaVM1d2VCYXk3?=
 =?utf-8?B?QkkvY29uMGQ0M2w2bEdPQzQ1RnhLL3Q1TDhLWUZMR2gwTjBlRGdOWGh5bDMy?=
 =?utf-8?B?TktoWng2MElkVERKL25QZERKS3cyN241T2kwMzUzNFVGWDFIZDFtSzhPN2xR?=
 =?utf-8?B?dWc5TDhXbHZSbi9DN3pXVEdvdmFtZC9KdmJocmpydWxFRDNBMXAyZ3Vhd2ho?=
 =?utf-8?B?ZGlLWW4zSUgrY3QzVnF6MHd1cWRhU1MwTWgrTXZxUnd3WmYvL2dONkQ2b1J2?=
 =?utf-8?B?cC9DT3UvVkZNOER1OUJGZFlLaDAxNGNyRHJEMEJtOXZ5WHV2OVNMcnV2OG9C?=
 =?utf-8?B?MkZOQXBKbjRLT1dRWkNtTm5LR3pPS3ArQVYrdHdOZHozbUdVaHluaFAwdUpC?=
 =?utf-8?B?REI1Z1B6WlIxTkZEQ24vb2lHMW45Y1V4NFJUc2hONndQeFJuZDkwMVNBd0ZF?=
 =?utf-8?B?ZzJscUxodHpQc0t3TGJ2WFh1YnphU0w5RThWVWl3dVBWQ3dwdEUvd1RKb2J2?=
 =?utf-8?B?cEE0TFFDZFdLUGozN3UvUlhZQzFVZGRqampjTkJxNHVPWFpQbXZqQXNpN3ZV?=
 =?utf-8?B?MDlDNGFLSWJwVWtwUkVaV3V0bng3MlFEUlpmOFdURjFUOU44RHhhY0ZKVW9z?=
 =?utf-8?B?VGQzdFJSa3BNNWpBV1lEMXk4VjVHdmxoUGRqRVY2RXNNeEVZQXlRYUlLRFIy?=
 =?utf-8?B?MXVkOVphUlFTZEZYSlF0cU5PMU1vNzZZWTFOeUdHcExzTkpGODRQN0phei9W?=
 =?utf-8?B?cmZiOGY2UlVpZDR4RU5DdUlZOHo2OFNtOXI4UHNWcmoyMGk4VDNtU3U5cjBF?=
 =?utf-8?B?cndYNXM2UHJrT1BBMWE4eXRFV044N1M1Nkp3cUkyL2VSNjdUVG51bXZNM09U?=
 =?utf-8?B?VmhpTWZkQjEyUmYwN1U2bjdHdnlhUXhSMXpIR3g2aWtacDR6QVlrMDJlY0ZO?=
 =?utf-8?B?NnVLSmFBWnFtNndneVJiVnp1eXdUVSsxWGlMZUVwNWpGa0dnSGc5bUVBci94?=
 =?utf-8?B?WVFBRDVYQkcydE1QTDd2MnZuVWxUb2k3OVVjOGN0TXdTVkhwM2NHbkdoMkRM?=
 =?utf-8?Q?eiGseeLvT07cfuEsbUw1LAJxT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7474073-9f31-4b89-a34e-08dce2eafe15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:03:29.5450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtiZFwggjyEYpLrFUbi7+qquKA9G9rUPS29XevUdZuMeM9kT/vUi7FWqmpq1VQjm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
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

Am 02.10.24 um 16:00 schrieb Sunil Khatri:
> htmldoc geenration depend upon the input arguments etc
> to generate the document. After update of handle to
> ip_block then update needs in comments too to fix the
> warnings.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410021904.YyGjlpk9-lkp@intel.com
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c          |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c          |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c           |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c           | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c           | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c           | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c           | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c         | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c         | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c         | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c            | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c            | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c            | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c            | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c            | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c          | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c          | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c          | 16 ++++++++--------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++--
>   24 files changed, 128 insertions(+), 128 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index cf2d55c2fd98..8e0725198dae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -219,7 +219,7 @@ static const struct dmi_system_id acp_quirk_table[] = {
>   /**
>    * acp_hw_init - start and test ACP block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int acp_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -497,7 +497,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * acp_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 5a919dae8d8e..416e8b3fad79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -46,7 +46,7 @@ static int isp_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * isp_hw_init - start and test isp block
>    *
> - * @handle: handle for amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int isp_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -69,7 +69,7 @@ static int isp_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * isp_hw_fini - stop the hardware block
>    *
> - * @handle: handle for amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int isp_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 33da094f1a7d..03b8b7cd5229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -458,7 +458,7 @@ static int jpeg_v1_0_process_interrupt(struct amdgpu_device *adev,
>   /**
>    * jpeg_v1_0_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -478,7 +478,7 @@ int jpeg_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v1_0_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
> @@ -509,7 +509,7 @@ int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v1_0_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG free up sw allocation
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index ec3d341fef61..6762b5c64ccb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -41,7 +41,7 @@ static int jpeg_v2_0_set_powergating_state(void *handle,
>   /**
>    * jpeg_v2_0_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -61,7 +61,7 @@ static int jpeg_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -104,7 +104,7 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -125,7 +125,7 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -142,7 +142,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -162,7 +162,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -182,7 +182,7 @@ static int jpeg_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_0_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 37cf415b6b41..4b8c801f204d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -50,7 +50,7 @@ static int amdgpu_ih_clientid_jpeg[] = {
>   /**
>    * jpeg_v2_5_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -81,7 +81,7 @@ static int jpeg_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -153,7 +153,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -174,7 +174,7 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -202,7 +202,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -231,7 +231,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -251,7 +251,7 @@ static int jpeg_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v2_5_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 2fa866a3e39d..7996209818b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -42,7 +42,7 @@ static int jpeg_v3_0_set_powergating_state(void *handle,
>   /**
>    * jpeg_v3_0_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -75,7 +75,7 @@ static int jpeg_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -118,7 +118,7 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -139,7 +139,7 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -156,7 +156,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -176,7 +176,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -196,7 +196,7 @@ static int jpeg_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v3_0_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 3cef4124b171..20e1fe89c463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -48,7 +48,7 @@ static void jpeg_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>   /**
>    * jpeg_v4_0_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -70,7 +70,7 @@ static int jpeg_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -130,7 +130,7 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -151,7 +151,7 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -187,7 +187,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -210,7 +210,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -230,7 +230,7 @@ static int jpeg_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index cf6efe6db8b2..2a53537db135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -68,7 +68,7 @@ static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>   /**
>    * jpeg_v4_0_3_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -88,7 +88,7 @@ static int jpeg_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_3_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -165,7 +165,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_3_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -299,7 +299,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
>   /**
>    * jpeg_v4_0_3_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -358,7 +358,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_3_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -380,7 +380,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_3_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -400,7 +400,7 @@ static int jpeg_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_3_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 2f9749b00eaf..ef2d4237925b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -61,7 +61,7 @@ static int amdgpu_ih_clientid_jpeg[] = {
>   /**
>    * jpeg_v4_0_5_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -94,7 +94,7 @@ static int jpeg_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -159,7 +159,7 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -180,7 +180,7 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -210,7 +210,7 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -237,7 +237,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -257,7 +257,7 @@ static int jpeg_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v4_0_5_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index a9a0b3f250de..7954a6fae464 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -42,7 +42,7 @@ static int jpeg_v5_0_0_set_powergating_state(void *handle,
>   /**
>    * jpeg_v5_0_0_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -62,7 +62,7 @@ static int jpeg_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_sw_init - sw init for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -106,7 +106,7 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_sw_fini - sw fini for JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * JPEG suspend and free up sw allocation
>    */
> @@ -127,7 +127,7 @@ static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_hw_init - start and test JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    */
>   static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
> @@ -153,7 +153,7 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the JPEG block, mark ring as not ready any more
>    */
> @@ -173,7 +173,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_suspend - suspend JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend JPEG block
>    */
> @@ -193,7 +193,7 @@ static int jpeg_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * jpeg_v5_0_0_resume - resume JPEG block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init JPEG block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index c5540c30d1bb..3011b5853fb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -621,7 +621,7 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
>   /**
>    * uvd_v3_1_hw_init - start and test UVD block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -688,7 +688,7 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v3_1_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the UVD block, mark ring as not ready any more
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 02e2dda63828..4852a2ab128f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -147,7 +147,7 @@ static void uvd_v4_2_enable_mgcg(struct amdgpu_device *adev,
>   /**
>    * uvd_v4_2_hw_init - start and test UVD block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -202,7 +202,7 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v4_2_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the UVD block, mark ring as not ready any more
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index d84b49064138..a24b210c79ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -143,7 +143,7 @@ static int uvd_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v5_0_hw_init - start and test UVD block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -200,7 +200,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v5_0_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the UVD block, mark ring as not ready any more
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index d14b1769f74c..b4eeeebfe095 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -455,7 +455,7 @@ static int uvd_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v6_0_hw_init - start and test UVD block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -524,7 +524,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v6_0_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the UVD block, mark ring as not ready any more
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 52ce3ac38215..55fa858328f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -510,7 +510,7 @@ static int uvd_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v7_0_hw_init - start and test UVD block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -588,7 +588,7 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * uvd_v7_0_hw_fini - stop the hardware block
>    *
> - * @handle: handle used to pass amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the UVD block, mark ring as not ready any more
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index c069c6d89e38..129c759772c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -95,7 +95,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
>   /**
>    * vcn_v1_0_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -118,7 +118,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -213,7 +213,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -238,7 +238,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -268,7 +268,7 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -290,7 +290,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -318,7 +318,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c104c47301c7..19bbd49f760e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -100,7 +100,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
>   /**
>    * vcn_v2_0_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -124,7 +124,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -237,7 +237,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -268,7 +268,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -305,7 +305,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -326,7 +326,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -346,7 +346,7 @@ static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_0_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e76e1168d6f8..30420ead7fc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -110,7 +110,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   /**
>    * vcn_v2_5_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -151,7 +151,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -295,7 +295,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -333,7 +333,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -381,7 +381,7 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -411,7 +411,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -431,7 +431,7 @@ static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v2_5_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 51ea9a83204f..13632c22d2f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -116,7 +116,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   /**
>    * vcn_v3_0_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -153,7 +153,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -299,7 +299,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -338,7 +338,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -413,7 +413,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -443,7 +443,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -463,7 +463,7 @@ static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index e33cc611f215..e7b7a8150ea7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -106,7 +106,7 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   /**
>    * vcn_v4_0_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -164,7 +164,7 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v4_0_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -253,7 +253,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -294,7 +294,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -341,7 +341,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -372,7 +372,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -392,7 +392,7 @@ static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> @@ -1973,7 +1973,7 @@ static bool vcn_v4_0_is_idle(void *handle)
>   /**
>    * vcn_v4_0_wait_for_idle - wait for VCN block idle
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Wait for VCN block idle
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index f02699a92e50..6dcae398b2dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -98,7 +98,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
>   /**
>    * vcn_v4_0_3_early_init - set function pointers
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    */
> @@ -119,7 +119,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -212,7 +212,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -249,7 +249,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -308,7 +308,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -327,7 +327,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -347,7 +347,7 @@ static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> @@ -1565,7 +1565,7 @@ static bool vcn_v4_0_3_is_idle(void *handle)
>   /**
>    * vcn_v4_0_3_wait_for_idle - wait for VCN block idle
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Wait for VCN block idle
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 6d277ee27f46..edb9cd8390b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -104,7 +104,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   /**
>    * vcn_v4_0_5_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -124,7 +124,7 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -220,7 +220,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -261,7 +261,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -291,7 +291,7 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -320,7 +320,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -340,7 +340,7 @@ static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> @@ -1467,7 +1467,7 @@ static bool vcn_v4_0_5_is_idle(void *handle)
>   /**
>    * vcn_v4_0_5_wait_for_idle - wait for VCN block idle
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Wait for VCN block idle
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 89e813b7ba5d..89bf29fa6f8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -87,7 +87,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   /**
>    * vcn_v5_0_0_early_init - set function pointers and load microcode
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Set ring and irq function pointers
>    * Load microcode from filesystem
> @@ -108,7 +108,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_sw_init - sw init for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Load firmware and sw initialization
>    */
> @@ -187,7 +187,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_sw_fini - sw fini for VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * VCN suspend and free up sw allocation
>    */
> @@ -225,7 +225,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_hw_init - start and test VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the hardware, boot up the VCPU and do some testing
>    */
> @@ -255,7 +255,7 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_hw_fini - stop the hardware block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Stop the VCN block, mark ring as not ready any more
>    */
> @@ -284,7 +284,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_suspend - suspend VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * HW fini and suspend VCN block
>    */
> @@ -304,7 +304,7 @@ static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_resume - resume VCN block
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Resume firmware and hw init VCN block
>    */
> @@ -1194,7 +1194,7 @@ static bool vcn_v5_0_0_is_idle(void *handle)
>   /**
>    * vcn_v5_0_0_wait_for_idle - wait for VCN block idle
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Wait for VCN block idle
>    */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 576a7404cf10..7616d7a509b9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2790,7 +2790,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
>   
>   /**
>    * dm_hw_init() - Initialize DC device
> - * @handle: The base driver device containing the amdgpu_dm device.
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Initialize the &struct amdgpu_display_manager device. This involves calling
>    * the initializers of each DM component, then populating the struct with them.
> @@ -2824,7 +2824,7 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   /**
>    * dm_hw_fini() - Teardown DC device
> - * @handle: The base driver device containing the amdgpu_dm device.
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>    *
>    * Teardown components within &struct amdgpu_display_manager that require
>    * cleanup. This involves cleaning up the DRM device, DC, and any modules that

