Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6C5C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 14:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E43F10E0CC;
	Tue, 25 Feb 2025 14:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGjZKy7U";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E4A10E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 14:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO2LcJMg5oASVFHafSnU35EdGB6fW51HOld9TLfXlFWUtRhjrodeETqitEC92cUQKYYc7gMQxt4meaBsQVbmzR+Mk8Kjpct3IjR+dBFkemNuOc5UBCpvsb0BofiuhlmTXMKXbZRsouHW/idn7cQWiJzKmy7Rdx7e2Q00mnAJ409QRZfJipxzVEcRbdAF2Yqee792yaHQ17FR4o6+8Nz7UlHPlEHO4PZtJEJT1ATBbNa0eiDdB4GOJOe0HSQfn9vXJW4B8c49RP+E/Y/SyGumtNnUqTW1SA0VeuVqRygJJy0PQIZCEC0IFw9EtBM0LpRRjvybUYhLvJX0t5bC3JDCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLcT9lrWvT1MJnUUpmwkRwZRsQhTBN2zr9pOExfmW4I=;
 b=zTql4GSmIvTa/0W48nddCS+hGxXol3cTxcGWLvV7jPjT/ZHDtZHQq8OTGYB59iy5nfBxxd25DqmtolbUMdJEe9hnPVUy1jPmHgzmKxdnEgEf/UMapKxcOAy9zvZ8CZg+TEOj2zqlHBzyRDgVPDRPUCExBYMDFZfBn88esy5OIk0lfqRjg4sxI3SgjD4cwW+Py7wWFzoQYL/lUhzz2+0EvNu7PJS4hOG+5ARjG1o95nP5hWmP1xeDyAwEawxr1L15hknsOXzf2/iW08VrqggR644BvKWFBV5wnDcOPGy0S+kUFMojPLuolebBmMjbGkQH/3NKPFpdhIr/RyOiJ9useQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLcT9lrWvT1MJnUUpmwkRwZRsQhTBN2zr9pOExfmW4I=;
 b=GGjZKy7Uj6SXqIpWCpJhVuO3274ZYTFOGbycQGo5e7YHIMY5KAdp/pJL3zWFlejbGSER6CKo9+V9h3xFvsDeodR/Vnvs/PQO9lZt0PJXIXVLQbeGilD1FzPzhBhu1wHAcnvdF3FVXdsYviQ4nbGRRRCdxiGX7eI8K2BFWO7qeHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 14:15:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 14:15:45 +0000
Message-ID: <2c79746d-570c-4c46-a8dd-f14ae62fcd02@amd.com>
Date: Tue, 25 Feb 2025 19:45:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on JPEG v5.0.1
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, leo.liu@amd.com,
 sathishkumar.sundararaju@amd.com
References: <20250221152234.67294-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250221152234.67294-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c039e2-e96d-4399-68cb-08dd55a6e4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG1hekxRME1PcnFZenRUYUhMQ09MbFo4bVJTZElsckI0SFp2Mk1IR1lMQzVn?=
 =?utf-8?B?a2JZMEhObFptOHAvSjRxY21TcUt0eTBLNmc4Sjd2a1NvYWI4dFJ4THFSMmN1?=
 =?utf-8?B?OVpqL2dFUXZMaVR2cU5LWUFITFMwYmpxYXNBbHRtaWVacVFWWnNYd1pNS2Fk?=
 =?utf-8?B?Zmw1UzAra2g1Wld2MGJJd0NPamhmMmZjZ2Q0ajNQeDl5R2IzNWxJY2ROMmln?=
 =?utf-8?B?bWNxR3NjUnNjYkduMWtyUEgvR1hBKytyajFYUmY5T3lQN2U4bjI5dm9zVHB3?=
 =?utf-8?B?ekRwNm43NHNtSzFNUnZId2JRSmN6bDhPaGdvbVZTemRlRGx3bGRkMW10NzF1?=
 =?utf-8?B?R1UrNGhEK2plMTYyczdWZnY4cTBYaElZQ3l3NVFOL3k2eHkxV0FVU3BSN0pQ?=
 =?utf-8?B?cnVGd09OSE51Z3c3UXlJL0p4Z2ZFL0dsTnBnK2hmV3ZQZWxvT050V3hqdzVa?=
 =?utf-8?B?TXJ5QzQxLzVyeXROTGE4NjBHZ01OMlF2L2MrVHJ6MkhoL1h0Q2djZjhWelJN?=
 =?utf-8?B?Y0t1NHZPMXptaTY1QWwyNkdzb0hMZEtuWm1oNVpIb0NZelIxU05uVjNsV1BZ?=
 =?utf-8?B?WFFXZmtGZTBYRHY4ME9NY2owUTVtVVkxaXcxNWRpZU5VQVJyTjAxcUR5MURW?=
 =?utf-8?B?ZEk0V0c0Z3VCWndtMlBtUmFzdjlxM2I0enJoUllDY0VCSkdvRHpYQkVmQ1BN?=
 =?utf-8?B?alR6ak5OZEllMHZqamhPTDllTkZVNXVmTHNhR2ZsWDgvNXdhSEp1SHE3aEhB?=
 =?utf-8?B?dEl6eVhLMDE4aE5naTZSTW5lQ29RMXEyNkd2QkU2a0hLSlhJWS9XQU9VQWpE?=
 =?utf-8?B?R1JzTkk0aXQ4Z0kvV1IxS2loTWNmYmxURFNoeGpzR1dpa1Z4eWJ2NE95d0pz?=
 =?utf-8?B?Y0tlS0s1STJoTC9makUyQVRETyt4TS9FdTFwMUdNcVlud0xUNndKYWliU1Jz?=
 =?utf-8?B?b0ViZ29waHNaNkxvRnB1di96RVlXVlNjdFBTdi9LaVhpSFhYd016UXRSY1Nh?=
 =?utf-8?B?c2Vqd2R5U3l2d08yK0dQSTloOS9qbzVwNDBUTnVwa0RpK29ERVI3QzFBbzJm?=
 =?utf-8?B?eENUYkFBWWI2b0Q1Y0hyd2wwVDJqeTBKcXNPSjh0b2x4dGx6M1JLdHFSYlJT?=
 =?utf-8?B?dGFhUlM0THp0QWZ4R01lOHlhTVgvZGlWZ2lBc1BDNDhXUXZkVlh5dlNqdEMy?=
 =?utf-8?B?M0dGNzgrMXhvM3BObyswRTQwM3NZN0thRkp2U2hHWEc3UzRpUVJzQ1lwMVpO?=
 =?utf-8?B?U1pyK1lReDBJakJFS0dSYkczZVN3MHJ6N2ZlRWwyM0tvSDZzenR6YktLRjFZ?=
 =?utf-8?B?N3JLSG9SUkdlSkZWRkJwT0t1amhNaHRhajduNk1sSHZ3M1F6Q3owVms1Mmh1?=
 =?utf-8?B?S2JYcGMvbWRRaVM0SjZPK0R4K00rWHBHVHErT05ZeE9VNkp5TjZZRWt1MlFi?=
 =?utf-8?B?dlZZOXpxRDJ1YTFDelBTWnhzRnI0WER2QkRTRjgzU0s1dHRuSVFkQTYvY2pz?=
 =?utf-8?B?VmJadHhwVXNUUmx6SUlOSXpTQUdQazdvRWk5U1g4MXlTN0xpSDFHeW5MT2dT?=
 =?utf-8?B?aEQ3UnNsdXUrejdncmg3Y1RzeXgzTmxDalJzSGVIa1M0b2FJZFd4ckY0TVk1?=
 =?utf-8?B?YWFXRE1iZzM2V1ZncDdqRnBhQkc4NzFtZVlQSFI5bUhXV2tNRzZ0c1ZaalBR?=
 =?utf-8?B?UEVBNTdMKzJiWDJrRUM5Rk9RWmgzeGJXbi9NUUNkMEJTcDNhaWxhTnpoVGcr?=
 =?utf-8?B?OCtGNE1uM1A1Y1FsVHowbjk5VzFaWFRWb2hTby9MWFhkei9VZ1U4MVBMTjl1?=
 =?utf-8?B?aWtCbkRoS0RSWlI3c2M4ckZnYlpZd0orVldZdENpTTVJZWR2aGxJL21NNW5P?=
 =?utf-8?Q?IsBkiSRG/0HZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURpYm5RNmgvYVE2OHpiYzRpdk1UeUdTaUc0RmJNb094L3lUWDBlb2Npb08y?=
 =?utf-8?B?UXQzc0ZMYjRNZE9sYUk1NHA3VHg5S1F6TEhnSExIejVERmp6b21RVVAyMFFQ?=
 =?utf-8?B?ZjBNQ1RFODZueTdyLzB0SXRGbnplQ0NFcDR6dGt6L0dRRTV1bTN1NGlycFhi?=
 =?utf-8?B?ZXplUzJTWEF0RmpPVlAvaUs1MmNqTzB1ODZEZE8yaFM1eWpxbEdhckRiVm9p?=
 =?utf-8?B?dnRudHZRdm8zN01WUGdlUUs0S3NHWDRIZ2lySlRyWXpSeFdTWXBLK3RQNG5U?=
 =?utf-8?B?QW8zMTdYdTJicWRtVTZiSGRsbjNiSFhqYjkybU1qbi9hdW8zNEJ2U1RrSFhR?=
 =?utf-8?B?Z3ArKzZQOVRTeHQ5OGFWWEI4L09XejdiUDhCdzVFU29UUVZlMkIrenlObWFZ?=
 =?utf-8?B?WmFYVnhZZ3Q3WUkxaXplU3NWLzNQclR5Z2J1d0ZGamJTMnQ0a2V2MUF6aXhG?=
 =?utf-8?B?cHJjK2tMWWZWRkN0RUZsbkovSGJuaFlNWmlWUmpmd01lSG5PL1g4Tm5tNnI1?=
 =?utf-8?B?UWtqRXp0WEdCODNGaCttL1dOSnZiSndQbnJaMWlWS01LamZpYVJOODE2WHhV?=
 =?utf-8?B?RGhBeHJhVWZhUjdvRHZIWFllVlZZY1ZsNjc1bnpVLzdTWDhBaTBxZG5kcFo4?=
 =?utf-8?B?SWV3VEtxZUV4ZGVFcVRYSjllTnJRb1NuT2NMNWJEV3NJL09qbUZ4SUZBeTVL?=
 =?utf-8?B?WDlqcmNmUXJ4a2VGcy90NUVYVzNQdU95TTBxUFFXWkJrSm1NTU1Ba3h2WDBQ?=
 =?utf-8?B?OUZ0NTJaRG03Si9tSnN3TWdFUlBHWmdrSExwcUg0bEpRN0cra1RQc3Q2d09G?=
 =?utf-8?B?NjhrdCtNN01aZmhRMVg1R3VYeUZ0Vnl5TDc3ak90SU9DOFdTSEFDMDdoTlBP?=
 =?utf-8?B?QnhWbXY5ZENNbVdjcVNPTWNXdWZQRFMzcElJaU9vbVUxZFRjYm10cFJXWlFD?=
 =?utf-8?B?dWZCVS9qS3pjQVVTQzFweVBUZ0p1RUlnQWlGV2tDWVRQYVZkdWFjVFFFVUJp?=
 =?utf-8?B?MGo0OHZrZmZqdVVVWS9FaXFWY3VwbG9NcnVHREtteUcyZFlza05QK3dWTkJk?=
 =?utf-8?B?aFFuTGFaMnBVQ1VTcTBMMGhUbXhwQ3YyZGVzc2w0THRxMXArbmQ0ZlBFbVNY?=
 =?utf-8?B?c1k2YWxwVCtLTXYwUFBobzlzQzdNQlJIK2poS1N2Vld5Vmk3RzdGeG5xRUFS?=
 =?utf-8?B?SU1OdVkwYS82UzRXQ1dnako4SkpzSlZxcTVYcmd5RllISWx0MytyeU5EZEgr?=
 =?utf-8?B?WFpUZDU4Vk80WmZCRk9EbzJmWTNmaWxSSGdudmFDMnhxS3p2UWlNRXNsbG5F?=
 =?utf-8?B?YWo5M3Frc1ExZ3R1OGNoRDlGVTNtVEg5Um1Dc1VVaU1ZelZ3VjRSMk03eTNI?=
 =?utf-8?B?dHA1NmIxcUtZUDV5a01oSzF3YXlZSExDVEVXSWp3d0RDMlZzLzFGMlE1TnB2?=
 =?utf-8?B?YnpYQVg0M1RVb1JJVWU3Z3hhWnJ1TGVlTDFBd2xncDgwZ2g4b3BvU2RDRmdS?=
 =?utf-8?B?UXJ2d3paUm1XK0Y2RU1yTytKdU1CblVSd1ZIVHJKUlRFVHF6RG0xYy9rTGRl?=
 =?utf-8?B?M2k2M2k4WHltSUVsZEdhRjJId2x2cStlM1hxaTVCOUNzVDVDN2lOVnNaN1hP?=
 =?utf-8?B?TXhoYTNaVHl3OGlpaCsrMC9zOXdJQWxSckFpRERSWkNBR1hwSTFOVlpheXFx?=
 =?utf-8?B?MGtlRitXQ1RrMFRDM29tTUlDOFo5NmhNdzA3clhkQkZ0Mi9zMlFpc1BVcEJt?=
 =?utf-8?B?YzJqZjhnczlGSkR4cGtEL2c2QkozSTZOVndPdVFtbk1xeTNkdURyNzdsZFcv?=
 =?utf-8?B?UDFtRXpGWkZZKyt0MTlSK2l0T3dGUTcvcjBFRisyMm5QL0hTSnZ3U0dPV2pk?=
 =?utf-8?B?bWw3bENUZWJ3bzhsUWZCVytzWUlKZG9jTmh0dEt5d0hqSEFuUGRQaTJLVVFQ?=
 =?utf-8?B?d1FWd09xNnBFbi9pVWtNL0xYYXJkUm1nbEM3OW8va3JacjdSemdIbDR1L0xX?=
 =?utf-8?B?ZVRrMXJ4NDM1a29Xa3phK3dQUXBaK1lHZWc3T05RbmNSTElDL0tpYks0eWha?=
 =?utf-8?B?SitFRlpzWm1ET2htMjhLMHNxY050RXRQRnc3dE1yV2t2d0J0bFpCTUllT3lI?=
 =?utf-8?Q?mkzBq4q04y8O40JE817zlnlZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c039e2-e96d-4399-68cb-08dd55a6e4f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:15:45.4492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35gsuyH5ziQFf+XRH0OPK3RAjVkbUQhkdkCozS92/5OX2tKetBL21oKdrab9o6UD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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

<Ping>

On 2/21/2025 8:52 PM, Lijo Lazar wrote:
> Initialize RRMT enablement status from register.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 5d4e2a09acca..0d63af6ac68e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -239,6 +239,9 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  		return 0;
>  	}
> +	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
> +		adev->jpeg.caps |= AMDGPU_JPEG_CAPS(RRMT_ENABLED);
> +
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		jpeg_inst = GET_INST(JPEG, i);
>  		ring = adev->jpeg.inst[i].ring_dec;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> index 9de3272ef47f..ea1105b11705 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> @@ -87,4 +87,7 @@ extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
>  #define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
>  #define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
>  
> -#endif /* __JPEG_V5_0_0_H__ */
> +#define regVCN_RRMT_CNTL                          0x0940
> +#define regVCN_RRMT_CNTL_BASE_IDX                 1
> +
> +#endif /* __JPEG_V5_0_1_H__ */

