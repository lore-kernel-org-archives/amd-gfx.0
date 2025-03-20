Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5CEC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 11:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370C510E5EA;
	Thu, 20 Mar 2025 11:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/ImBVOY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50A610E5EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 11:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNElAcNU+agUxukco5c9faJPIiPulszpdV6oIkJPZgsG9KCqQ2p6gYfnSDSRraYBjeEta6JC4OQWzwBdX+xXP9ARI0EZZr4JsjIXxVddNceF6GSWz0XsMWQNDwRUVhqFxnFfuDj68aRTelSuwcSvQmEYn0ZsE/Y2c2NUEj9K121O+ybv+YCRD8qdd0YU3FxUdZ29VMIPGQwr9ptKVzVtpWlzpk9cnyXZfVm279BMQG7/mSCw1BiUyK4qlkAE3vj4IIfNt/QILEKVb+XO7cKhZDssze9zP/RCz1hIyqBc3jMOqlgPRm3ZK4VW2X8CXFgi9wKrydvCmp9FOrcBVr2/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPnPXC1saWybCMOcw+IjUgiQ1wWPffElKjjQiq+ovRA=;
 b=U7SLpYjcdcNR4CITRh652fTAPZYOAV/oay114cXIIWyZjP+8zPpEuJkICtCj8xkDdZjqGOtg1z6PAnHLSo5noRB4YN1DEjKj4nc7d5yBxgMjnaE6q66+8l/yqQj5Fwfw6d4IOvg9Bl3Lb/vKNaegweciypl9ZqOfa9KIIXBchdc4hfW4vcsHZ3qJtJn8j3TYdT6qho5I99dMx4FHA3fRypFpvatTnsXWu8ft2hv2AVXdpM8qDtvBXmi8966IfaolCLZ/073VvKTirZERYYAc1QR7N2S0wFBIOYLYcwwONPkNHQB9aUVylQpnLr+mkjB+/wzZepA0oF9+ld2p3WD9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPnPXC1saWybCMOcw+IjUgiQ1wWPffElKjjQiq+ovRA=;
 b=V/ImBVOYGNJYbw353MAOkt7BcssRPVBCGgvG5s0TnAlv4zI4hOOoktj174aGdukDo/ZSQcto9unXxCtGZnMCxUpIkcaEfCgbOX6YJqu2NEXwFXSDuSuPPNGv55JcB1a0YPpaq7ISYrxkAd+2xO+DuE3BDCnsx7cWgWDZwnwY414=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.35; Thu, 20 Mar 2025 11:14:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:14:58 +0000
Message-ID: <1ca6101f-e746-4909-885b-071a995b4bee@amd.com>
Date: Thu, 20 Mar 2025 16:44:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <20250319190850.3899718-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250319190850.3899718-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc978e2-31f4-4138-7275-08dd67a072cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDBFRUxleTZzNGhHRC84YVI5WFZiUlJwMkxwelNpdGVGUHMzajJENkxCVVhu?=
 =?utf-8?B?TjhicEUrVWJ4NkRXaytCdHdpaEN0MytFb3BXdlBtem9KcHF4bitINTdnNk0x?=
 =?utf-8?B?cTU4VGFybVRuQmpPZitQbE9QdmFJTEQvd1Y4Qm5lQmRiUFgxZjlwUGRMVDRq?=
 =?utf-8?B?Vzh1U3IzWituSEl5eGEzTXVLOHgvRW9iN200M1V5MGVTendHUEZ2eE9ocEsx?=
 =?utf-8?B?YVJmR0VicnBIb3g3dDR0cHkzZjEzbjI4Vm8vUjFWVk82ZmVGM3h3YWtiU2hJ?=
 =?utf-8?B?UHIrWkFQMXYyam9GN2VzaG9VQVhvcmg2QWlhdUplRUVPeW5zeTcybzlnbDN4?=
 =?utf-8?B?a0VQYU4zQ1Qwa21uMUFDdGxUK0Rldk4xMEZvOUZ1K255SS9tMk13QW94ay8v?=
 =?utf-8?B?Y1pqdUdtcEFUQzNuVmp0Y212aUVnc0IrOHpOckFHNXE4dmZSNWs2dkNZWld3?=
 =?utf-8?B?MWYxZHlXNEpVamtEd0ptcHp2UlZrZjV4V3A4TVBmSm5BNEw1YStqdEtYbzBr?=
 =?utf-8?B?eTA2UnhXZUM2YVc1cnlvNXF0aHN5alRlNzR1WTRTa1NkVlZZN295U0prdjJ3?=
 =?utf-8?B?bWlzNjZZbW1oUnFMSGJYc09STE9ML21BQ3VTWktmdm92T3FsWG9pNzRTTC8r?=
 =?utf-8?B?L0l2c3Q1UE84L3ZNL0hhVi9IdGlKZWpGTG5USklkRjJYck1NTkVxQ1pEMENF?=
 =?utf-8?B?REI5T2xTWG9NYlJOemlGRnNIeXF4QzVhUVRFQmFHcGwvOUp4YWhaV1FScWln?=
 =?utf-8?B?SmJ5YVIzYm9DRnI4SGY3bjJ1Snl3WkU0L3c2emwzWWhjV1BCZFJiWDJOYjVN?=
 =?utf-8?B?d1FpeEJvZFFxcm1CUUJ1ZXNqN2sxZm1teUlEYU5pekNQVzVxU2t2eE1HSUY0?=
 =?utf-8?B?MGcrd2V0Nkw4ekUxRE1hWW85SzdwNGo3ZmQ5ekdlNWxadTdjWll6SmhGNEtN?=
 =?utf-8?B?SGZMcnZzdHlYMTV1OS9Nb1Vid3hkRmlCWU0zVUhoWTgzRE4zaWNxSExVYWlS?=
 =?utf-8?B?cVNNVFIrMWVERlFPL0JNV0RWenFWSzkrVWxXODRFeGhQUUl2M0p1T1pRMytE?=
 =?utf-8?B?eS9yR3JBUjFCdmhmRE9DOTN2RS9zYnpBQW9BeU9ETDdJUkxXdlZJaWhiRFlS?=
 =?utf-8?B?cm5HaS9WdHdjeEdoSE96VVE1UFM1NDJ4dy9ENXJEUmtoRjJiQW5Wb092c2Rx?=
 =?utf-8?B?TmxHR1NzRU9IZFFWZ2lMZUdxVjNJaGRhRUwwSThhS3BBem9vY29Wbm5jNktq?=
 =?utf-8?B?NUxXTHowU3dRSS9aM3M4Tys3QnNkV0lvTzZpYlFwSzhuaHFRbUx2bHhPcE90?=
 =?utf-8?B?SEYvbFEyeHFZcWgxSjRDMWd5QUxYcTBUbXV2QTlORm5qbjZ1WWtsMXNGSFQ2?=
 =?utf-8?B?QUdiUVpES3d2TkMrTm9VbUNNbFdvcmtJdHI3bUxMQVp6Q0VIV2hqclpuNlFo?=
 =?utf-8?B?ME10TlZaVGZvZ3A2RDJRNmtTMURSN0N4SkNpY3oxMU5nQXZ6NWVmMk0vZlRN?=
 =?utf-8?B?b2c5Sll6WDBGcmxTM0x0Qjl3KzhtckxTTUY3eUltTEl6MHNMSW1aWWlRclNH?=
 =?utf-8?B?S3dnOVZDNXhtQVIrTCtuNDlqRFM0WmlBQ0xwcVBUbHN2dTBmN2ROandLcDR0?=
 =?utf-8?B?a3ZwMHRMVXVNZDQwWXd5MUtvcXhZek9zK1VzU0hDMVhpNTlmU2JEUEc4OTFa?=
 =?utf-8?B?ZDRmNW9MeDVDbFFuWDlocDFHQkV2U3JUL0lGNXZqYVlYNm1XZE9JVDNldnZB?=
 =?utf-8?B?WEtxV0UwVEhEcGlhSHdzd2N2eVNFRXREN3llTkwwWXF4dXNRK0pwRzRaRnVu?=
 =?utf-8?B?UFF4RysxRkJyczJkUnJleEVOR2sxZitwTC9sVjFUeU9hMzBCK05mME9kVVZ5?=
 =?utf-8?Q?Inovs+VsuGPrT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhvWWVJaTlpNnJLL2lHM0E2cmwxdFhHZTZSeEVYQWsyTmdCV3RMV2VSRW5M?=
 =?utf-8?B?VnlURU9yYmw4YVJpR0ZaaURHU250L01jb3NkWmt4aWhpd2RjM1d0aDl5YUdp?=
 =?utf-8?B?aGRIdjBJSE5lNCtGc0dvQ0Q1cUVTTXF5V1pYaXZ5OXQyM05WQnZKRTU3bGRh?=
 =?utf-8?B?VjM3RzV6clBmTVk2b0JaRFdBLzhzTVZkZUE3dUphemZtc1VweGQ5c3hMbEIz?=
 =?utf-8?B?T2lRUmxFOHViS3pRRElUNXFYdjdmbXl6RXlHdzNoMWNGbTkrdDRoUU55aDd2?=
 =?utf-8?B?b3c4REtOUCtqQ01yd2FzK0QvY1Z0RThaREYvL3ZMblZEWFErSnd6MjI4bUZY?=
 =?utf-8?B?bG4vaVdsbUp1R2tocC9YK2l6Z3dNRUttSGpGdFovNk8wSG1vZ2hySGpvaVk5?=
 =?utf-8?B?ZG1TRHBUcjQvVzMvaTlzQk43NUpqTDRxaWY1V0hTK1Z3M2UzKzV4cTFza3hG?=
 =?utf-8?B?OVBuekxXU0RnTVZTUU5VcmFaL25DNlBQWVRRYkpBUGdZWXhxWXdlTVIxdEJr?=
 =?utf-8?B?bDJtMWhKZmpZZ3JnZnlJbGFMaFBROGpiME1Ha3k2V0xBWFhITG5ZdFUvZmFn?=
 =?utf-8?B?MlVPK0N2NlQ4bE1kL0t6N1dHeCtGTVJ3Q0xobUpKdzd1L1FWQ29GWHNQY3Az?=
 =?utf-8?B?aEtZRnl4clZQcmhzM3VXOXZiVEFhNGJ6b3FxNU9RandoT3lmY2lRZS80dXU2?=
 =?utf-8?B?N1lnWnVoYU9aQnl6Ymw4VjhFdEhUQWE5NEpMMmtvU3BadUtVU2VwaXFHamF0?=
 =?utf-8?B?OEI1VkpJRTJ3L0ZyL21za0dkcXYrb1hVQmRWUkR5UnRMU1Y3TCtFLzc5cFBP?=
 =?utf-8?B?Z3pNeURJZ3lFR2hsWWh3MnFzSmdBakEycXZWZzZveE9MVWFkQnR4elRBNlgy?=
 =?utf-8?B?M3NOTWJPaXhSS1FydXMrcjI0RmlBKzQ3Z3FpTWRWZEVUWlpEQmFWMUE1dzF1?=
 =?utf-8?B?OGhCdWdsMk51N0FuVlFIMm9USU5BbG9YcUQ4MW1SSm0yOHlBRGx5UDNGVlMv?=
 =?utf-8?B?WGFBb0Q3bk92TEg5NmNTRjg5eU4xdXdtZHNrc01iejdVOHdFcXRXZm1BK2dI?=
 =?utf-8?B?OUlCN29nYVUydzBNa2txN3kyTDZYWHRpbjU4MVY0UU9nakNoK1lQWTg5dFVa?=
 =?utf-8?B?M0ltS0dYQnhoV2kyWGtQUE80bG9lcHlqYzN2Q2pDQi84SVZIcmpvRHZ1OEpN?=
 =?utf-8?B?dWJsRjFGYTM5ck0yMXhMZ0VZUU4vNXQzdWFLZDRISVhxTUpqWG90OGNTalFr?=
 =?utf-8?B?Mk0vMUtPSEJFWFBCeE9CcEY2QlN6L05GVUVzNzVOOUY1QkZHeDY2Y3NzQUlD?=
 =?utf-8?B?OHVDTXUzZHB1TmZRdnZpVlNjaFd4TzhXcEZkQXl0U2NzQVpTdDdHcjAvanJY?=
 =?utf-8?B?Y0pEZUJ1MU5UT2hCN3NCU3VPMGNzV2FuTmhnNTFScXdCaW90V00vekd5cWpJ?=
 =?utf-8?B?UHVqckxsWmplL2Q4Tk80YVh4NW9OUkJQbmVJbU5DS1N5RE5MeXhnMWZnRjV5?=
 =?utf-8?B?eVN0MUhzMnJWR3EvZ0dtMGFobmZnMVVRaUMyUXRjWEhYbWx5WHRjZEpJcktm?=
 =?utf-8?B?TklHTjZ4ZHptMFpZQlJiaVQ3T1FqSjh5N29GYTcvNVNIajd4blFZVlo4cVRK?=
 =?utf-8?B?ckdsNktVZlJ5cjRBTGxLU0RCT05nZytRcVY1Y3lEK1NQak1TeXN0Rnl1VXFU?=
 =?utf-8?B?RnQweThUMnZadUMwWUEzdENLd3RQNjJTNTFZNVh6RGRXam9pVkpjQnprLzNn?=
 =?utf-8?B?L1BZa0xjQTFvZEc4TWQ2dkIweHZBTjl6dFgrMCtKNWtLT2hSZkNOS1pxWGhN?=
 =?utf-8?B?RTNkL1ZxeVlKVFZoRTRKZ3ZsY3ZOWW96bEFOY3hIeEhuYytna1BXcUkvSXBr?=
 =?utf-8?B?YzF3dG01U0hoMDRzb3lQVWY3N3ZTbGFhZ3FJNFV2bi9RYzc2WllranprbjdM?=
 =?utf-8?B?NStnM0JhSXpYL1c2dUMxWW9NT0U3NzZ4TWJkS29GdHpoU0toWVlPS2xtU3NX?=
 =?utf-8?B?dENWUHFJRGViYlBldXRuMk55RTd0WnVzOCsyRmY0eTE2TjBJK0VnT2JSOWtm?=
 =?utf-8?B?clYvM2RsUGtIelIzdHJxSW44L1Q5MnBONldZWEsvWXo0MG5RRk5SN2xTUkhm?=
 =?utf-8?Q?vwnGGjSf7ChKNgkD3mHQoIJ06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc978e2-31f4-4138-7275-08dd67a072cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:14:57.9036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH8RRfWdet4c5hOhIToYdjrlMNWwNnUSamPsXdNQ5ApHD86PMa3ioUSN/RoamafW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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



On 3/20/2025 12:38 AM, Alex Deucher wrote:
> Enable pipes on both MECs for MES.
> 
> Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 10f14bf925778..ac9b1708e20d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -130,8 +130,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	}
>  
>  	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> -		/* use only 1st MEC pipes */
> -		if (i >= adev->gfx.mec.num_pipe_per_mec)
> +		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))

Same comment as in patch 1.

Thanks,
Lijo

>  			break;
>  		adev->mes.compute_hqd_mask[i] = 0xc;
>  	}

