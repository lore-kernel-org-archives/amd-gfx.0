Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D0ACA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 10:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E65310E751;
	Wed,  4 Sep 2024 10:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvCYjEYo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8B510E751
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 10:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJtOoMRo8uEgrt0hLMgt1qdowUydJZScF3yY90Iwydfu1mTNHEmIIkRlel7DeWJFXkKhlQMEN48MoMCdcbI6CN80XxL0Rb7eSuYaIJLdufov6f3BTQf95g6qaf0CpaEMT1YKHwl/DMR7hQerKfhTKsKmjj0CMeU+MXkZe53vp7jny1BWQteFXVqckbExPBx+y3v6WkSa8uyJ4wxWLn5Mt5IR7knm/Fc0DWxo/3UKHH2mRjObR2Kwdj1EAhO+6R+lxwNpjPju/zKq/RvraGcNs8T6YHqusUMseZw0DCBXl4nJvrtOpS6ItsBofTtOUyvr0hfgGvZTRTuf71Ok3/5kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja1+7v86cgciCGbXR8PUvRPKlYGVqyTuwTIPQaM6MJI=;
 b=EDVv3jBkBIJeNqw9cyKcRM6RFL0BOkV+WIZPViwKbrXuxhAw1MV4uNMu2xd0eXR1oFmT1lnCf7wpRdSDynaV1ajnXiCAgBXlN9KkFK31TQavSE55Zz2s0+gU0CQ3V3fy7/UoaDtwdusi9NNN5J2RIKtqzJAmW/DjZqCKOiUm5Vrox4cmjCxnFoZam5EQpDVOcDbuLytnYX786lmGaR2X7cvaRZxmhlsYdsJIkb3RIwspVd7a59jHPdrfHzMfoUuLaBTWA4eWDD9LOwlC4RmfLOftJ7zm8JRB+VelehjEvF4YEIxyfySNagOycRH8qd4A8Ah2RqihVh+4P1vcQ4oaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja1+7v86cgciCGbXR8PUvRPKlYGVqyTuwTIPQaM6MJI=;
 b=IvCYjEYoMmsOgZy6a0Q3/AV76LAH+jNuypAhK5Fllu2rnKuLiOnAHOS1dKavKpU+LiO3L4LZ833Q3QpC5BrVwrXcoXk5PyC+yFogxlXb1nISBnEORbERn7A+yDEShfhlXMuAxBbu4vPSlJj776ycTs3efTI1szHQG4ec6zTkIaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 10:50:55 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:50:55 +0000
Message-ID: <11267e0c-b036-460c-908b-e7113858f096@amd.com>
Date: Wed, 4 Sep 2024 12:50:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in cleaner
 shader code
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240904093317.1802226-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240904093317.1802226-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b2cdbc-e90d-46fa-fab4-08dccccf73d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW5zQUtKL0tMdGVxa3RjWFlsUkEwOHZEckl6WmhFVFNQdnJ6SU81M09wakR4?=
 =?utf-8?B?bGROQ1V6b25YZmF2ZmRMem16R1p4NjlPM1daT3JxYUJmS01LMGgva25TWWla?=
 =?utf-8?B?QmIxMGRVM1VzNlo2bVE5RUJmNFVsRWN2WWNhQVZlbkZMSGJjcS9GaVFubmtF?=
 =?utf-8?B?MlY3YUxVbTJJa3hnSVJZYSt4YVZEWWJnTWMwQWxZdlNFbzZZb0k5NWNMTUZC?=
 =?utf-8?B?M1FNNERCbUtwN2VqeGV4UUsyK1U5UUhXREdtL0U5eXZjZUpROHR4QkdlaHpt?=
 =?utf-8?B?OEdMN0h1azhDL1N0cXpqRHREU3NTdUEybTBnYXliT0NNS2lETmJLVnhORWEz?=
 =?utf-8?B?M3AzMUEwYXQwbDg5RzV1L2tBRTNhKzA1anZVT3I0czBXazhGMW56enRVUjZK?=
 =?utf-8?B?QWlZVEdyY0RzcXkvMkdGVmJycGdKd2dPMEIzSElWU1FkdEdVUEVsZUhjYzVv?=
 =?utf-8?B?NkhzTm1DTVAxbytWSk9xYzBJQXZzSE9WMTU1d2F6elJ3cHIxU2hXUk5PUGxr?=
 =?utf-8?B?eVNqdHYwVTJZWERlRlA2cnlIZ3liUXAwbUV2YytaMWgwY29HNFErclRMY0cy?=
 =?utf-8?B?MSt1TDZBSmlzemdNOUsyci9uMlpPdnN1c21tS3BZSWcvbFRNbE1YdnV3YmRT?=
 =?utf-8?B?NHRQVTdxTTI5cVlyS0NKMnRmMmRoa0huUDlLNS9nK3F6V3ZHNWc4cVAyK0NH?=
 =?utf-8?B?dmcrR21MblZLUkFhTklPTzQ3SnRGV0ZRQzYrNkZqVWZXeFJGd0RNWEtab0Mr?=
 =?utf-8?B?TXAzY1RDZTlRL1RJNk9JNHZXTUo4VS9WK3BKOGdHTHA5VnhNTklDYnMzR1pR?=
 =?utf-8?B?TzdpUkNnMWQwQmNqQ1VoWXgxZFVwY1lxbnV5RlcyYmpqcWM5TUZWNHBBSC8y?=
 =?utf-8?B?WGpyZDNFb0ovMC9VWUZxVklJcEFDVEpvN3ZTeHNWUmlvdFNRL3pSZ0FKT3Jo?=
 =?utf-8?B?WjZHQ2duNkV6MFd5Rk1WaG1zNjVOcm96cHdIdjFDR0xNck95UEpnMXc5ay9U?=
 =?utf-8?B?VHAwcElkcm1aMlU4N2lSREpXQVl0UHpOeWVFL0o5djh5cUpCUlpxMkNGVDR4?=
 =?utf-8?B?R2ZvZ2JtZDBYQ2IweTVCOXFjMjNqd3QxSmQ1TGc0N2pQVk10MVpLTHMvbGZ1?=
 =?utf-8?B?bFp6UGJEZDM0MW54a2pQb1VWNTVXSUlxbFdkTndBTERJdXR1Rjcrd2ZLK3hy?=
 =?utf-8?B?K0pOeVh6MnVubStOMkx2d3gxQ0t3Nk5MYmVWc0YyV3ZRSWE3YUNndzJpd1ZY?=
 =?utf-8?B?cDYzRitGSSthUE1vUVVZTFBweGY4ZlhtNnBGa1BpSTAxeEJTdUJSanNvM3RB?=
 =?utf-8?B?anpjQ1ZUUjh1dmRLNDdPR3EyemNGRnlkY2RrSEs0OUFWUGpNMFFWTEEwdUx2?=
 =?utf-8?B?ckZXRG5objh3NkI3Y2s0VmtRRnZXUHZ5b1dsVmRLVCtOUkZTQzVINjlxK3k2?=
 =?utf-8?B?a2J4VW8xVnpOSlphVSt5YmFtR2VjSFJmVWpndHI0b1k2VHNsSlM1bGp5RWJY?=
 =?utf-8?B?RDEvWkJzYjlSZkNHRmorV1BaaTVtVGxzbzdTdWxGc2Y3Y3F4Um9vRlp0UDd1?=
 =?utf-8?B?RTJXVjRWbms2NDYrc3RQMFc3ZDBSS0Q5RXR5bmVLeFNiNmhlcndOWkI1d253?=
 =?utf-8?B?NHYxN1VJWnQ4aHp6R2FFTW1ORW52a3JMYXFPUUxzaWh4bGFwdTBTdkRURlBu?=
 =?utf-8?B?SzBtbm1Uc2QvSDBrMGFrYmNRRDRmNVIyTmEyb1NZYTA4cjFWYUFkd0sraktY?=
 =?utf-8?B?SHE3YVhQRlAzWEk5T1JISldJMjFEZHRycGY2WG5JZHhmZTl4c1dnUkRxSkRG?=
 =?utf-8?B?eGdiYk9sVExXUUhIUmlnZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWcrd2N0SmNhRURjRmJqMHJlbndsZzFYSU9JTTE2cXpTK2pwa0t6MGZwNDQ1?=
 =?utf-8?B?Vjh6NmZqcGowRklVN1RycGxSK01wTjY5a1kwSU5Ea0lUNW1vazJkYXFrOVFo?=
 =?utf-8?B?QUEvbWxDdFlIZDlWQnFpWlQ2cVRpckNRci92aDROQkRFL0J6c0IvZmpaUXRa?=
 =?utf-8?B?a3hEYUZpOGpkcElVR0lDUTdXWEJFQUpURFlMMDZCakFISmdXMTlBdUZlYTlQ?=
 =?utf-8?B?K2lqVWtPMFJ0UHJCdTk3VzNlbW5ZeEJSRElQREZXUE9DUzlwSDU4Y3VTT3Iw?=
 =?utf-8?B?YmZCQkhkU2pobmtHeVlFNXZFMjVWcmhWeksyTnJLeTJBaFc2ZFJBNS9PbzQ5?=
 =?utf-8?B?TE1GWng5Y2l0b3phN3IwczlpekN1elQ5SEJGelU1ODR5d1JLTU40RWkxRnAr?=
 =?utf-8?B?QjBwK1FLNkdxU2FlVGY5Y0VPZThqN1FjVXU5V0s5ZmFVNUEwQXF0dVIxVU5x?=
 =?utf-8?B?NUFzaWg3NW15aWt0MlJEVXpQTHVsQ3VNVStQRE9NY2JRdFl6MXJuVzIvYUkx?=
 =?utf-8?B?ZjJ6TXJ4RkN0cG1uZjJJSWlYL2RFd0xTUDFveVJsalN2UVUzd0lCSG51MnhI?=
 =?utf-8?B?WEVIeGFERW1XbjhtZG0ydzVxemNDZDAwa0NLdERRYUFFUmM4R2Vrc2tCTGl6?=
 =?utf-8?B?NVpTWjlUc2tXY1ZkM3l6dC8rZnVpZ3pJVHBzMjBKMU00dFlSUmJMODNtNDZG?=
 =?utf-8?B?TVFXS0dBNm1GdDVmc05LbGMwam11bUJWbHcxREJwYTlyMjVKRzZ3d2dGMHd0?=
 =?utf-8?B?RjU2SzRDWmg5Mll2WVMwS3pYZ043V090bHdaN3RhREdXY2h1UFdCS1lLTGxx?=
 =?utf-8?B?Nmd6dGxCak9LL2t4ZThaY200cm5uSUhseGRYdHMzMllSOWc4c3BTbExrRlU4?=
 =?utf-8?B?dThOQWRmSmhsdHhrMG1tQjN3SkJqR29rMkpYRFJRVGVOVGRhUGZwUWNLU0g5?=
 =?utf-8?B?NHlVVlhTU29VMjU3NTQyQm91RmZRTEo5YzZoUEg2d21ML3NqQVJndVRTRnJZ?=
 =?utf-8?B?MDN4c1VMZGtUQ1VxL3RDKzE4V2FCOExIWWNxQ1FVZ1RCUGtEcGgrY0grbmwx?=
 =?utf-8?B?RHVkVHpMeW1TZ0tXdXAxckNpbXp3Q0EyV1gzU3NsMmU1V3RTWHE0d3BUQzQ1?=
 =?utf-8?B?MW1jZFBONlZ3b0hWNTB0cUR1Z3k3dXVMdVFsM2JQYWZaWnhLSzNHMElrQTIx?=
 =?utf-8?B?bVo2VGRiaE9UdXQ3WlJ0SFNuck9hVU0xT0xlZ1VISXlNSmp5NFpLeURORjRu?=
 =?utf-8?B?b0tUdUhHUExORDk1emk1UGZqL2dUN08vcXJOTmZZWnZTRGppbmJCdHdELzcz?=
 =?utf-8?B?SHlFRkJBTkRIdVlpQUsyMGdjeHUxRmY0RFNkRHpnK2FhWlMrbEVTcitMYXIz?=
 =?utf-8?B?eldGWUoycGFtdDkvbnR6d2ZWTi9sT3E5dldQbGtHVmdEZnRyVzhSNk1abEdM?=
 =?utf-8?B?Z3FyVkxjeVdSQUo2Mlg3V01INDB4TmcvOERXem1sVjFoM25QQjd1RU1XWUta?=
 =?utf-8?B?OWpnSkhKQytzZGtZUk0xRG9paE5aK0xiQUxBa3kxT3gvZzRkYXduemtkTUQv?=
 =?utf-8?B?US9jcXN0N2hhU2liaDVqc1g2a3NHT1IwTmgvalFkbmxSRkZPYzFGSXBWM2Js?=
 =?utf-8?B?enAxQW4zWHhKaDhoMm16VGQzOVkxMThWVTZKMmJZUUlZaENQVUNkelltc0hh?=
 =?utf-8?B?ZFdSbkJyRnRSbStKdjY1eFQzUVUySTlBRVY0SmI3M1lkU1ppMk5qQ2ZKWFN6?=
 =?utf-8?B?dWtpMk5yU2s0b2tNUng2Z0ZORWF1MXJnMkFUWVhtRHpLQlhrTExndEcyZGdZ?=
 =?utf-8?B?a3pyV1J3L01QTlBrRHJPY2c5YlRUQjdkbTNVM2ZGcUJCcHVaTXZvanFlbUZs?=
 =?utf-8?B?citFR1lGTHh0YXo2a2RxdW1YN2c1a29nUHppOTVhT3VmRnFwazMzNUtyLzdy?=
 =?utf-8?B?YllxTVRyQnJUS0dHc1UyaE8xZjdkak5DY29SbU9OcVY5R3FXcmdBK3VuaEdW?=
 =?utf-8?B?ODFGWEUzblFYdTBrek9CN3JFRkpZekg1dGZrOWgxZlZFSjA5Ny9Rb040NkJG?=
 =?utf-8?B?b29ibFllMURJUTJzZkJvSEI2eUg5TDF2MlNHTTZNTGE3QkkwWG1sVUpRT3cy?=
 =?utf-8?Q?eGzoRG+KjzKouTcPgEIK9sH1V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b2cdbc-e90d-46fa-fab4-08dccccf73d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:50:55.5881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeBOLpN0Hud5dmk29xai8maCiWYsFWUFP30JHGNTm4R2iZ3dombf2q1DOjKy8wFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

Am 04.09.24 um 11:33 schrieb Srinivasan Shanmugam:
> This commit updates the comment style in the cleaner shader code from
> `//` to `/* ... */` to adhere to the Linux kernel coding style.
>
> The comments describe the operation of the cleaner shader, which is used
> to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
> separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
> SGPRs.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
>   1 file changed, 72 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> index d5325ef80ab0..4a61562b9bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> @@ -21,47 +21,52 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> -// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
> -//To turn this shader program on for complitaion change this to main and lower shader main to main_1
> -
> -// MI300 : Clear SGPRs, VGPRs and LDS
> -//   Uses two kernels launched separately:
> -//   1. Clean VGPRs, LDS, and lower SGPRs
> -//        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
> -//        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
> -//        Waves in the workgroup share the 64KB of LDS
> -//        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
> -//        Each wave clears 128 VGPRs, so all 512 in the SIMD
> -//        The first wave of the workgroup clears its 64KB of LDS
> -//        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
> -//          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
> -//    2. Clean remaining SGPRs
> -//        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
> -//        Waves are allocating 96 SGPRs
> -//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
> -//          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
> -//        Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
> -//          Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
> -//        The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
> +/*
> + * This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
> + * To turn this shader program on for complitaion change this to main and lower shader main to main_1
> + *
> + * MI300 : Clear SGPRs, VGPRs and LDS
> + *   Uses two kernels launched separately:
> + *   1. Clean VGPRs, LDS, and lower SGPRs
> + *        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
> + *        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
> + *        Waves in the workgroup share the 64KB of LDS
> + *        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
> + *        Each wave clears 128 VGPRs, so all 512 in the SIMD
> + *        The first wave of the workgroup clears its 64KB of LDS
> + *        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
> + *          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
> + *    2. Clean remaining SGPRs
> + *        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
> + *        Waves are allocating 96 SGPRs
> + *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
> + *          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
> + *       Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
> + *       Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
> + *       The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
> + */
>    
>   shader main
>     asic(MI300)
>     type(CS)
>     wave_size(64)
> -// Note: original source code from SQ team
>   
> -//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
> +/*
> + * Note: original source code from SQ team
> + *
> + * (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
> + */
>   
> -  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
> -  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1)
> +  s_cmp_eq_u32 s0, 1                                /* Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3 */
> +  s_cbranch_scc0  label_0023                        /* Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1) */
>     S_BARRIER
>   
>     s_movk_i32    m0, 0x0000
> -  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop unrolled for performance)
> -  //
> -  // CLEAR VGPRs
> -  //
> -  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
> +  s_mov_b32     s2, 0x00000078  /* Loop 128/8=16 times  (loop unrolled for performance) */
> +/*
> + * CLEAR VGPRs
> + */
> +  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
>   label_0005:
>     v_mov_b32     v0, 0
>     v_mov_b32     v1, 0
> @@ -75,24 +80,24 @@ label_0005:
>     s_set_gpr_idx_idx  s2
>     s_cbranch_scc0  label_0005
>     s_set_gpr_idx_off
> -
> -  //
> -  //
> -
> -  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
> -  s_and_b32     s2, s2, s1                          // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
> -  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if its first wave of ThreadGroup/WorkGroup
> -  // CLEAR LDS
> -  //
> +
> +  s_mov_b32     s2, 0x80000000                      /* Bit31 is first_wave */
> +  s_and_b32     s2, s2, s1                          /* sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */
> +  s_cbranch_scc0  label_clean_sgpr_1                /* Clean LDS if its first wave of ThreadGroup/WorkGroup */
> +/*
> + * CLEAR LDS
> + */
>     s_mov_b32 exec_lo, 0xffffffff
>     s_mov_b32 exec_hi, 0xffffffff
> -  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
> -  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID (0..63)
> -  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread is a double-dword address (8byte)
> -  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
> +  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to thread-ID (0..63) */
> +  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to thread-ID (0..63) */
> +  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each thread is a double-dword address (8byte) */
> +  s_mov_b32     s2, 0x00000003f               /* 64 loop iteraions */
>     s_mov_b32     m0, 0xffffffff
> -  // Clear all of LDS space
> -  // Each FirstWave of WorkGroup clears 64kbyte block
> +/*
> + * Clear all of LDS space
> + * Each FirstWave of WorkGroup clears 64kbyte block
> + */
>    
>   label_001F:
>     ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
> @@ -100,11 +105,11 @@ label_001F:
>     v_add_co_u32     v1, vcc, 0x00000400, v1
>     s_sub_u32     s2, s2, 1
>     s_cbranch_scc0  label_001F
> -  //
> -  // CLEAR SGPRs
> -  //
> +/*
> + * CLEAR SGPRs
> + */
>   label_clean_sgpr_1:
> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
> +  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=24 times  (loop unrolled for performance) */
>     s_nop 0
>   label_sgpr_loop:
>     s_movreld_b32     s0, 0
> @@ -114,25 +119,25 @@ label_sgpr_loop:
>     s_sub_u32         m0, m0, 4
>     s_cbranch_scc0  label_sgpr_loop
>    
> -  //clear vcc, flat scratch
> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
> -  s_mov_b64 vcc, 0               //clear vcc
> -  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1
> -  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3
> -  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5
> -  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7
> -  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9
> -  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11
> -  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13
> -  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15
> +  /* clear vcc, flat scratch */
> +  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
> +  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
> +  s_mov_b64 vcc, 0               /* clear vcc */
> +  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
> +  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
> +  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
> +  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
> +  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
> +  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
> +  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
> +  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
>   s_endpgm
>   
>   label_0023:
>   
>     s_sethalt 1
>   
> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
> +  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=16 times  (loop unrolled for performance) */
>     s_nop 0
>   label_sgpr_loop1:
>   
> @@ -143,10 +148,10 @@ label_sgpr_loop1:
>     s_sub_u32         m0, m0, 4
>     s_cbranch_scc0  label_sgpr_loop1
>    
> -  //clear vcc, flat scratch
> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
> -  s_mov_b64 vcc, 0xee            //clear vcc
> +  /* clear vcc, flat scratch */
> +  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
> +  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
> +  s_mov_b64 vcc, 0xee            /* clear vcc */
>   
>   s_endpgm
>   end

