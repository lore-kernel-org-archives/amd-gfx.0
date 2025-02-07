Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD409C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8CD10EA9F;
	Fri,  7 Feb 2025 10:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AXMJn90w";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EAD10EA9F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2r6oehmVfyS6Xh5minO8o1+kx86i39gB1s5zrU6+Im8uPm15St1wB4uxJn6Ti/gF4JmGN2D3gxdsmxM87/Crqg+BOTcQb0v7GwPCAgXApFqxncceN2HAM1sEzd2nVQqITR9gYwPRKTqOIQ0i17mEM5S/LBoc5QPU/8s4kgxyPTzWhqi0Rh601/fNczRcQJiQ986PTj19DA17Ji9rNnl+GCytXOi0fVqzRzzOJFmkFfq2NTy0VYsCi7mN8Tt8n4ouQshj5Mo4KJpeWv87Zs2HN1UzVsLuY0NxJMzAoO8x0+x8z0I4r4PtxoLXJJL/CjVKeAv0tm7SQrQxWSPTLZhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWUmDJj9nitbV2BBzcDb0lt1D1vRh0Z2Cdm2RXjDyF4=;
 b=DPWzTcCRC/3B2j1bQO1Y8kX4GG6XbFO/8xfOYQGKPO3il8FYGRM+vkx2oQF6Yf8HoszLdl4IZfZhI2bErYMU8ZVltRkk8RGWv5DO8s9gsg3yyPoTktMn4UGIkQ3lGOrHr1na5p9MKQVqJFn02Prwxj3QzZLyEM4NZI0Pz48QRAtSROMvrXS4ua2MidGLRa2Ma8X3gyc1X8WQ4WA+aivmKajUY/fNOnPOPM/XcGpoestC2WbfbCOQ9hqHGIdfFiGa8gAoa9qj75jCn4pFOKdSP9jC+pLKwpvDfdgOQqWaX0KFLpc3YZyTbaikNVoWr5xb5NrhGz6MRF1Juk4olUv3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWUmDJj9nitbV2BBzcDb0lt1D1vRh0Z2Cdm2RXjDyF4=;
 b=AXMJn90wTy+I2nkBrOGQbn9eIZQ8t1n+r+KLW9Uh4yH6p12Nf3RIiyIfVps+4JC0jObbEJe9koPOjF4wo4DDSPLHwlEEGiBZHY/rUwAAG6o35Yd92tCnVGK+cbRc2VKoBHZ95XKx7Pb5MCHCDKSzgJA182cy4tb6Y7T5m65xNww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Fri, 7 Feb 2025 10:38:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 10:38:59 +0000
Message-ID: <aad42783-d677-4031-bb86-5d02757e9493@amd.com>
Date: Fri, 7 Feb 2025 16:08:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 1/4] drm/amdgpu: reset psp->cmd to NULL after releasing the
 buffer
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1738909308.git.gerry@linux.alibaba.com>
 <6bc04a402ec50c6b9d95c160d9bd74bb3b419e70.1738909308.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <6bc04a402ec50c6b9d95c160d9bd74bb3b419e70.1738909308.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fdb730-7ff2-4311-dc93-08dd4763a13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG1nVHk4RFE1bmdqbjd4VVRmeTU0S1RWTzVUTXNQTzJjV0oxcU9uMnJGT0N5?=
 =?utf-8?B?N0hkQjA1R1JCNzBud1ZVai91R1RWQXJuVkFUekVpOXJhZnZXWkJNUzBrT2Jr?=
 =?utf-8?B?bFcvOWo3YWg2SG9BVzVYY0xmeGo0R0cxbUg3bk02cGwwZjA1UlB2anUvNEZx?=
 =?utf-8?B?ZHN2aXhrWTFLajhWYkl4NDFhMUo0Q3hKeUI5Z0pvbnRRRmhuUjl0R0ZyM0Uv?=
 =?utf-8?B?VUdMK2hFNk1EY1l6dFZ4NjI3dVZNSnh1QjMzZG9HTklPampTaHJBeURyU25G?=
 =?utf-8?B?WTBDd1E4ZDh3QUFvZGphT0RGRmQ5MDJxSGwzdjBxYWozcy9PRE1vWGxsVkFz?=
 =?utf-8?B?MW4raEFQMko1aVVyNmpmQU1VeTBuUjNidVpqeTRVV211Y0ZpeDJtSnBQK3ZR?=
 =?utf-8?B?Tk1ZbWJUZDNvUFA2ZzlqMlVobUNubWo2WVB4ODV0MWNOa1NDOVZVWERCK2h0?=
 =?utf-8?B?emt3VEt4ZmRsd3MzUE93bFVFSGpiMEtMZGhwM0FkVnNJQVIzMVl6QWNWZkxl?=
 =?utf-8?B?eDFma0xiQkdwS2ZuZE5TUCtvSXhoRXpiSXJuU05qeGlvNHhYQ3FlOERocXc0?=
 =?utf-8?B?bm40RkhqWEpDZHE4YlpHSmJoUDk2YkVvTE1obysvUk9BZnlvZWc0UkJ3M1ZF?=
 =?utf-8?B?NUE3b2VQWk9jeGZwRTJtc0drdmFZSmpZLzZXNzBrUi9kSEJnaEN5MWVPS3RL?=
 =?utf-8?B?dUdyOUVyMmNpRnF0R0xNVld1WGpvUzJESWIxRzNGZ2NGNUo2Kyt0QUhxVzFT?=
 =?utf-8?B?VzF2TmdNREEybVFtR1NMcWxESDFSeEQwZE55SkVrWmN1RUQwa1ZxQ2txT1JZ?=
 =?utf-8?B?bG9UZXUwVzkrelZ2Z05SWWlHaUhYUG5ESzB2SmVaWW92RmdqbXZheVlCOEk4?=
 =?utf-8?B?b2tnbnNkYU9HZU1kOHNHeXJmS05TdnZPMUFyMWlGTmpST1Z0U0ZOTnIxOFlx?=
 =?utf-8?B?Nmg4UnZZWVhSVU14akRNNi9WTENkWi8waHJaQjVyVERzMjFNcVJ5bWc2NWtQ?=
 =?utf-8?B?akw1TkRmenJqTWpBblU0ZHdzdTFlelg1c2VCS0NNV200Mm95bGhmZFdCSG55?=
 =?utf-8?B?OWZ5Qmt0cTBGTk5VTk1QZDVmZEFGdVVjcitQYmpLUnNFZ3ozNDhMa3BFV1NJ?=
 =?utf-8?B?ZFQwZDZUZEd0Ui82TGtueVhhVEk1bmpVaENuaHNGeFQzV3lJRDN4RFpVTTRk?=
 =?utf-8?B?YWxPY2g1UEN6SS9FemZnc2R1VlgwS1Z3TEdpb3pFbDZWeVB2bmlDSzNQdlls?=
 =?utf-8?B?WGVLV0xESHhJdm1hT0c5SEM3UC9KNjBwMDRtcURVUVdWejNWalpEOW5ienY2?=
 =?utf-8?B?c0VPcTUxMWk5STNCWlluMXFTblYycEpwZmlsTThwRkFYYzhwaUFzUFR4b2NY?=
 =?utf-8?B?U08vSkpiVThncEtrcmxMU1JlWTU2WXU2cXdla2lobnE4eWwxV2lDUVdZOUdN?=
 =?utf-8?B?SWVtWGc4Tk02SG54U2NIOFlEbGtIbzVMdENRUWlxTXVyREtBUU9hZVVYM0lQ?=
 =?utf-8?B?RURlTFBLRzJIWjFkcEFwQjl4WEp2cnpiSFdoUGdlaFFtRFZpZkptU1FTSlVv?=
 =?utf-8?B?R1ZmZ3lLMUVtQ0dwWjZsRG1lZ3duWjZIMjUrUmhXUW0wUVhEVkYwcmVuajBv?=
 =?utf-8?B?cHlNcUVaQlVKMVZ4RDdpQ05iTkVuKzFYR1ZmR1pYbGgwL3ROcHBCcGczRzhV?=
 =?utf-8?B?TmpYVVo2TlFzQzFrSE5JbXJjVGttN1BQY0FtNTBZLytoVEsxKzZDVTlWN2R5?=
 =?utf-8?B?bWhNbDJSTmJxVXRQVWF6eGtlWE5JR2hySThYUG05TGRlcUNDcERtK0tsMGJ3?=
 =?utf-8?B?UkwwMlFnTHVmM0RmbkJCSEUwS1oxT0ZwRXlkc0tTUVdrb0owNUxoZXUvR1Yy?=
 =?utf-8?B?VDFjUXIzYjFQcGs0Q21EUWVTSlFnODhXSTA4QTZjWkdFb0E5OTlKT1dodHRO?=
 =?utf-8?Q?jWR5f2u24HY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1U2VVJ6TW1NS2pyR25WRnI2OFVHRVZ3Z0J1WnNhU2xDd21vR1ZpdSswZjdC?=
 =?utf-8?B?UmdzTjl2UUcxcEVINU5HSFJmSEQvblBPQkxwRndZeklIUTljUGJuRUx5Ymw0?=
 =?utf-8?B?YjV2Wk1oNTlVVVNmM3QzYjVxb3QxRzc0ZHNFQkk4ZDdaNjZTdFNLaXdWSlRx?=
 =?utf-8?B?bG9xNFliTjRhSFBDblpGOUw4dHFVa2tUU0J1bzRSZ1UvM1lOcHNoSTVuL1Ey?=
 =?utf-8?B?c3NubGc2YjFxMDRSK01xR0plSndqVVlxWEVCNDN5dnZMYlJwTUlIRFRzS29G?=
 =?utf-8?B?ZFAzTWNwWGRtcC9Db0M5TjFRZDhiVm1uK09iaGRIQ0Y1ZmNTaXRRaHNyRnR1?=
 =?utf-8?B?NDlTMnFFa2ErQkIzRmxDdzNCOXdFSGJXcnI1b3g5c1pabENtTHY3WGQySGhh?=
 =?utf-8?B?R2xKMlhhdVBVZEVOano4Q0ZjQXkra3gvUkVxRUJVbThPbjIyMjZRUWF1ZUg2?=
 =?utf-8?B?Zkw0U2g1VU9Bd0Z6UFFQS0VqRVZKR1lGVmJhUDdmSm90WFRSZlVtclhuMzJE?=
 =?utf-8?B?UEs5RTR3UXFQNDgwbW1PaC8rN0xBMDZiMzh4eGdjS0l6MXFYckdPRzJGWGVY?=
 =?utf-8?B?Umc0ZG5XbTBhWnEwMlB5a3ZlWWF5L1Q0QzFiSDVNRzhWMWtsRkR6eDhqTGl5?=
 =?utf-8?B?dHVudVF1V1YveWd3MmliTzc0RGM1bFdqMFM5UlZQeXFGejd3U0o4VHRidG4z?=
 =?utf-8?B?RmNWandac1dxNkZoMkc2M0E1SkdmNzFzV1dBTEIzZHdpZ2xGdkFxSEtOQlR4?=
 =?utf-8?B?dVBrTnlQNnovbUI3ZmZLNW8zYmRmbTNGZWhVNUFBUElhV3V2SEdwS25aNWNl?=
 =?utf-8?B?VXFRMnFQM2lkZm5mc2NQckd4SXNlbno3d1BNd0dkK3JFeGpLUmg5aXp5TS9G?=
 =?utf-8?B?MG52Z3JaazJoUVEvUEFGT29GTitYby9menlQVndIOEFUanAvV1RMWm9iZW1l?=
 =?utf-8?B?VUhSaFRadXE3b085bUN5c2prbTBsQkZ2bk5wRnhaeUJuRFFvS0kxU2ZubU5C?=
 =?utf-8?B?RDBjRE44Ri9mbTU5cEpaNTVScTdYNFVma0VBYU9FSWh0NSsxMm55WlJ3WVhH?=
 =?utf-8?B?V0lMZHVxRHM5bmkrWXZidUVHaGRlZTkvcXpWKzNnQ0RvWlArWWlCZ3R3N2dZ?=
 =?utf-8?B?N1JjV0RKbXJNOHl3QkVINk9PYkNCaG1EcndQQmd3b2RKYmQyUEtwZHZ6VFNr?=
 =?utf-8?B?UzByVjlKLzBBSzZvaUk3N3BtajFvZTExQXk4YkhkRS91UlFvNjV0ZENYbkF6?=
 =?utf-8?B?M3hGZlFXdUNISEJuWisrQWx2N1N1aUFpcnZHaThvMDBtdmlGMEZhTlJpTFpj?=
 =?utf-8?B?eXZiKzB2SnVoS3hqemlLUW9pN1E5bmVmUDBPd3JycERvQVcyamM0Rm9oTVAy?=
 =?utf-8?B?SzJ0Uy91Vy9WYTdrK25DNGwzMC9Db2hjaXBlRFNXTUJWenVkMWRRVHo1RHBG?=
 =?utf-8?B?Ni9xbFhLcVRIZlhSaFFCeDRsa3d6eHhFa0hoZ2cxZjdlVVk5WE50OGQ4Z2Iz?=
 =?utf-8?B?dXpJNHpJdnppRHJzNkw0YmFQVEtTNDZQMnBqNTRIMUVMV3RPNE1DWElKM2lz?=
 =?utf-8?B?MXdEMFV3TE5zcXo3bE9HRGVzVzFrNkVYSi90R3VyTS9ad1VlRnU0Z0wydW56?=
 =?utf-8?B?WXIySFdEVERuMmNSb05pS1hEWlNXWlZadWczQzB4ZFVWblFLSGp1MnVoK2Ri?=
 =?utf-8?B?WXBUWDlvMEQ2MlBlUnVXRi8wYmxWSGpac1ZRMUJRaTFuemZJbEZkNzdnTXNo?=
 =?utf-8?B?RTVnYk1JOUJiMkpkRGtZVVlxc3VYOU4zVm02U0VwZzFnQVNkNW93MjFDdVE3?=
 =?utf-8?B?YnQ3TW5LTHJJVU9NQlpmK0JNUVpEc3JuSUhQQS91czE5OG9ib0VPeU5BTUNh?=
 =?utf-8?B?SHMwMmJnbXliNUFoL1d1YzdHMXhEand5ZXM4YUZ0ZFNqVmlGczFYY1p4RjB3?=
 =?utf-8?B?MGdMdncyanBCMVFWcUl3eW41aTVYSE9FdE9WeHB6aC9YUHZpSWFTZ0NhUVNX?=
 =?utf-8?B?Snl5b0VmdWJjNTN2SXUwRHVDeVlHKzRBRTAyVi9rcGl3eVdCN1BHSFR3cDho?=
 =?utf-8?B?YVY2dmg2ek1jbURDR3pvNGtrRG1kUGZlTm1PelZxaEpZd0dBcEdLY1docFY3?=
 =?utf-8?Q?Xzdna+x31iMKLo8vzT2rtXCBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fdb730-7ff2-4311-dc93-08dd4763a13b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:38:59.3071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG+bGXsQC4H92Q0vR4N2vazFM51oHIU037tSA5YsnZ8HnBBDA4uClGKUBM6m+nZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
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



On 2/7/2025 11:58 AM, Jiang Liu wrote:
> Reset psp->cmd to NULL after releasing the buffer in function psp_sw_fini().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index babe94ade247..4e9766a1d421 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -533,7 +533,6 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct psp_context *psp = &adev->psp;
> -	struct psp_gfx_cmd_resp *cmd = psp->cmd;
>  
>  	psp_memory_training_fini(psp);
>  
> @@ -543,8 +542,8 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
>  	amdgpu_ucode_release(&psp->cap_fw);
>  	amdgpu_ucode_release(&psp->toc_fw);
>  
> -	kfree(cmd);
> -	cmd = NULL;
> +	kfree(psp->cmd);
> +	psp->cmd = NULL;
>  
>  	psp_free_shared_bufs(psp);
>  

