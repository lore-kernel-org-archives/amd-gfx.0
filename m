Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD26DC369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 11:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7FD10E8CE;
	Wed, 16 Apr 2025 11:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TOvY5bpw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D9410E8CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 11:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n23HU9tyTcmmE+CP2Rlbz/X5mkqEh1T37njW2OTNW4pUC7KgtNj9ZrWBxHVpWnifzekMfdt71Axa45JimQh1oqgxlCgUen4//nkxo3YZvuOKfo43eto4hlubJhsoWRarK61WhSNiPtlW4yIfyZIUEvYj2mEecj0pjOgjqBtFmlbNwQMqNRk6LpxUrFBRhmN61U1qokJQq//MtH4NpTz4/vXTwbRNlDTdOYsKTD5lhdtBU0Xlt4bUUblJyAHU1kYIeRALEYXjnWz9qL2ogSlVPz0wYsV1TMjFpp0dz9Y1iHG+9zDFYoy8uf5T/B8IgIwjz2p/Gl8F5kfIvR3InrzNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMzamZ31U1zyjbwUTrsqIVao4wjM7r0T3B0eTmLFOpQ=;
 b=mliA0wXLsqcIq8mbPtZ5xb67SB75tpUBYM+9fsUSWU6QRg0muXgzw4MTD0FQo/zb2BeyoLwIdtQtGXYbUfACwjRp/fCnC2ssLx7JJU7NpQKz07daeKLSyNNnpJSSPiyjn+LToGLGRs+sKqCi8qeSSn+xEms2z2cJFChBgZcQMjCXOagcL6CJmSVEMoko7UN+M1kP/F94xiU8nKHXHN68p2UHvnkeJcfUSN6i6vTdMIMG/s9pGM4AjBj27QW18gpjABci6jPvgsTlYrfNOPwxKKfQrxH+Q6jwX76kKSg2JlDOb/iRCmDR8I4Ch3/MiGKsa+tDqJ5rUFLMRW1bw0dyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMzamZ31U1zyjbwUTrsqIVao4wjM7r0T3B0eTmLFOpQ=;
 b=TOvY5bpwPkJvAQrqqAt8vsjoNexpz4sVw5WFuekNxEucEr2NWJ35AY2SGxdpJpPtEduspiL4AQ9e3h013ZcAXXL1mZPaudeztbp7fz7fN1sN+ucA6qE2O8gneoayPs2maHZqAjxeg2WxGA2Hj50PDiZDgXkIYsJUfluidF5+1uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:07:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 11:07:19 +0000
Message-ID: <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
Date: Wed, 16 Apr 2025 13:07:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250416085029.2278563-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af85f2-e1a4-4db7-6477-08dd7cd6dae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzBFQ0JVZFRDL255cUhPbW5KYklNV2RVMW5ySXEvelFjUnRUV0J5TWN5L2NM?=
 =?utf-8?B?T0V2V0RaMmZRYUFtbGo2MDFocFNicEJjeCtwWUZIVjI2ZDRJTkQvQzZaU3NE?=
 =?utf-8?B?cnpRY05KNVo3dWtpNXhJOVVJUEorVm1sQ2FZZFdKQ2Nqc0F1LzNNNE9JZ2gy?=
 =?utf-8?B?aVlReUpDRDYzSmZxRVhMRGZLclFOTzVUVVRULzVyMlBKZ3R1Mkh5VDBNTnY1?=
 =?utf-8?B?bnlydzM2Nk8vaFBodGFqekpOOS91UDVsZzVvdXBXeHNuVHh4YWt2MTQweGFp?=
 =?utf-8?B?eFdFMjMydi8wS0p3TWpvMWJxSVgzYzgwL29EaEZqWXczVDAyR3dyamE4T3BP?=
 =?utf-8?B?OHdra3BNcDJOSkVreXlaNEFDdU94VGRnaHB6ejhQdlhiM1NOKzJyc2dTMHNv?=
 =?utf-8?B?NklqbXRkUkhuSnhPdERML3p1ejZFYitKTFNsUk1tMU9wQkkxYysxL1hNb3Qr?=
 =?utf-8?B?V3EySUYreFdPblZMMUlRakNUaWY5KzF4TlRsdnpxZHV5UDU3eUJtdEY4bXdC?=
 =?utf-8?B?OG02Z1cvM3BnSEZLSmlxdjJwVDB5cUMrbWdLb3JqYU1hOXFDVWh1SW5GWUlZ?=
 =?utf-8?B?MDMxbHJPbHlUM29YT0MvTjNscUZWOGw2NUZEa0NYcENYdXJnSnRCekZTQTdk?=
 =?utf-8?B?RlVSd3NRN2tQVmxleC91T2VzbE5Qd1U4N2xBVk1nT2NhS2VQcFI4MmQwUWJE?=
 =?utf-8?B?MHl0dWdQdS9PbzZCY3JIRllLRjZVNFY5ZHZXMWVjeU9od0ErQWxKNUxtKzFp?=
 =?utf-8?B?T2dWNlNYeXV0UEhJd2laMkY1N0pXK3U2T08yQlVYN3dRWml6NmFEaGxsYjBi?=
 =?utf-8?B?UHowaTdmVzFEUTZObzNEVkpzWnJiQi9hWnZ0ZU9EVHVmTVZHNU01cmxNUTBQ?=
 =?utf-8?B?Y1BEY3FtOGp4YTdyRGVQbm5YYWNUVFY2MjNKa3h1a0h0dEJrKytNendyUnVK?=
 =?utf-8?B?cWJxNElnQTVNZWhxM0h2TDNwelB4NmQxbGY2MXF4WlJhcENvVkx2QnRRVzVl?=
 =?utf-8?B?VDlnOEY5MjJPdDFmbGVUMXpiOEVValpSUHdrMjFiOTVoMXZURmZnc1A3bmNx?=
 =?utf-8?B?Q1l5U0QrRTZlTkowaU9ybnMyWFFEN0lUdThycWI3RHZmZWtYMXV1NWNrNFVi?=
 =?utf-8?B?V2M2Rm5wQWNQUXNmd1BHcE5BaDI1THo1ODMxUlY4Ym9tdDVBUlpocXU3czJj?=
 =?utf-8?B?RThKZjNVeWNZcUNGZXQwbzM5SzFHVTVBdFd1ekJ2clE0eXpINEdlL2FBRitz?=
 =?utf-8?B?MWZsdU42bkU1cHliQlJTRDhlY3MwajV6ZGxBY3lhRjRYZnFqekFNV3FoQVVp?=
 =?utf-8?B?ejlOd0dieWd6ajBWNVU1RXhpSlNkaFI0SXo0Mmp6dGYwbm9lbTdsOFU1VUEv?=
 =?utf-8?B?RVNFaXRNc0RMY1V4aDkva0swa3g0TUhFV0FQZFdKSmRsWWV6SW9pSlExUGsz?=
 =?utf-8?B?SHluTkh2WVlwMzJtU0krTmwrY2plSUpMWUFOS2ViOGNwZVF0cEpuSkFyeXFz?=
 =?utf-8?B?SWEzY0ZkL05aWHVQWlREd1JRQ2ovQ1hDY3VNdC9XWlpnUVQ3a2duNi9sZlZL?=
 =?utf-8?B?aFpaK3A4MjdlUHBuNjFrK213NXBEWklFSVB5TnZ5bDBpRk90TElETEJYRlJW?=
 =?utf-8?B?OU9YcGFhM2N3NmYxeFYwT0w2bDhGczdFZGR0R2phd1ZXOGdvM1h6Q1dnTGhi?=
 =?utf-8?B?bFg0WE5KNVE0V0dodHd4cElqYVJxM0J6YkdKYW5MditFVllKQkJFTGZ6TTgw?=
 =?utf-8?B?WnlWN3JTUjRlUGxLaG1rSm83OGhGTjBVQ0VMakx3eHdIWmZLa01wUk92YWEy?=
 =?utf-8?B?YnlHcmVtbFVGUkxOeEZ5dGpTOWNyS3djVTNFS1ZUUjg3UFNvSHhZNGhWcTh6?=
 =?utf-8?B?NmdwRzcvZHhKbUFyRFVnSVNObFh2aWQvN1VnaFd1NDd6OVFrelVkSFRad09r?=
 =?utf-8?Q?cfyZks3U5QM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZ0RGhRdlBQNzZkOWtIemZ2Y2llb0VoNVpybDhOWWRMcUNOcU5tM1lqOXNl?=
 =?utf-8?B?R1RvenFPYngwUy8reXhSODRPTWxJd2FSYVRQbjZhV2hhdEptOGtlQXkvRG5Q?=
 =?utf-8?B?a0dGQzI2blh4amdTNGxMcU9OcUxZK0J6NHdQbzA0aE5EeFB3TzAyeGFEZTRq?=
 =?utf-8?B?Qiswa0t4c0Z4dWd2eHB1VEVZTmdkY25WTCthRHhwbVUzaTVVYXl5bkFaTzFM?=
 =?utf-8?B?dHgzSXIvTk1xdWhUUVFLZTBaa1JYMEdLS3pZb3JqSmw4Y0pmaHBvTTZyc3lM?=
 =?utf-8?B?REo4SFoxMnA4N3VqaHZ5WXcrVVJJWlhVQ01KSXhaZzBRNmx1NzZmY0xPNHRK?=
 =?utf-8?B?Y1BmaWZLSVFHaXlINlcwbi9EMjk5VEd2NC8xRW4yRGdjYWVVT21YaS9KaVdQ?=
 =?utf-8?B?b1RkcGlyMFViNUVJSEZsTmFiOVhzOVhsZWZyMEpkZEFkUHRnbDA3SCtTR0tQ?=
 =?utf-8?B?WHA5TVhHZ3QzUWtMa1N3OE9YQU1iaExzeHVYR3ptajdQKytxMFNwM1Z6Qks5?=
 =?utf-8?B?VjEwYjk5Nloyb0xBdFRhVUUvVlh5U3Z1VkZJNkNFY3lkWk5hYVAvQ0RsaFpq?=
 =?utf-8?B?MUpXRVlxeFVoelZBd1oxZWszOHdLTUtoMVNicjQ0d2RrRzJ2OHRpZUN3MGJr?=
 =?utf-8?B?bW9XaTYrNG4yUFBNTlRTVWF0Vnk5M2RtWXZWblR0ZkNnZzNYSkEwMmZTdXJM?=
 =?utf-8?B?U1A3bElmWEJRcE04UmRRN1h4UlRyRThaME5ENmxDQU1qTDk2M2FrbnlPbGRT?=
 =?utf-8?B?TlFpK0MzcUl2TDBQVFJtZDM3ai9Pdm9pVHBLVlRSNFdTYWxOeXp5QjR1QVFD?=
 =?utf-8?B?cS9kWHZpbElscit3Smk2STB1OUFDbjJ2Z1lOelIvUUprWUUxcmptQjBlVGJC?=
 =?utf-8?B?ZVBpYk5xVmdCZHNXWVhicStzMU9JZU84MUM2ekZ4ZlpvcFBuK3c0Q2hCM2RZ?=
 =?utf-8?B?WTFvUWlNQ3RNUUk2MHhaOUJzMzM0eURlYmtMQVF6aE1TTlZnVzA4eUVaNGU0?=
 =?utf-8?B?WDB4REM1RDZ0aGorZmVuVm90dTlaejg1VzhWWDZEV0hqL2duNnRUSnVHRWJk?=
 =?utf-8?B?cEtXd0ZkM2xLa0ZMQllFang1Q1Vya280V0JRU3R6NTlnNzJESTBpdUp3N1Fw?=
 =?utf-8?B?UGhxUjZjbUxpNmxadElHKzlyaERmOGxBZWRyeFJ3RnJnTVg4dldiemNPd2Fo?=
 =?utf-8?B?S203TE9qaXVTTVp4OVNidTVXc1pLUWFCbXhyMCsyQVVqS1Ntb21tV3V3OVpz?=
 =?utf-8?B?YzUvL2RsaitPZkoyOGw5a0xzYjFiSGlYSmMzMUlHVk1QMEpGbFJNanBZRW5L?=
 =?utf-8?B?TVBFY3F6MFlZS0dCemRBeGlVRXpKTG5mSEZjbjFzUkhwUjF0S1M0bjRjNSt3?=
 =?utf-8?B?RWVVZVBhcCtjVmhOcktlS1J5RWhwT3plTUMzOHVYQnNMSEtBYWtHT0RGS1J5?=
 =?utf-8?B?R0tZbCtvbjNzelNCUHlBc0RPcm5kRVJ4cFlpNnpQdFY2bWdlU2ZzMWlVUFdR?=
 =?utf-8?B?SVRiYitZRU1TWEZGYUhSUlJKS2JOOSt1NFhTRUo4V3R0cm1rTFFsbU00bW9m?=
 =?utf-8?B?RGZGOElmaE5SejBTU3dKMmx2VVpvYkkyUTdDUDFuS1U0SFR2V1FBMldEcS9K?=
 =?utf-8?B?K1EzMGROWjM2enlGUmRRZjhTaWgxZzc3aWRVRndTUzBCdVMxTm9JRjFNdktS?=
 =?utf-8?B?YVlGdzZvcEpTaU1PRG51a0FKeDN6RzZlREhRMXRMYUhpcG81UTViWVdqMmUr?=
 =?utf-8?B?TThaVzVhYklqbDJtWVphRWdaeGRlRUI3WVlKbFF1RmNDNEtUVkprbGFIa1ZC?=
 =?utf-8?B?eDZoanRaMndIdU1JTEpnY2t3d1VVNVUxRlBiV3lpVGNVR2FIUkd6cHFqK0Nn?=
 =?utf-8?B?SkREeWJTUU5CU0xsYUd4ZjRrN1ZMWTdFZEZnRmw2QmsyZ01RM0tjdkthVmVl?=
 =?utf-8?B?U3p3UGVhZDJYNjdFaDZjbURTOVo1ckZWQ2p5czBWL01Xc2dTN3g2ZU56NVlt?=
 =?utf-8?B?cGtxTFloMVJvcmM1RDRXRGdXQnRhclRVc3kyQUd1d0FmdWJyQklmMGZYSmMy?=
 =?utf-8?B?RlY0dS9VcTYrbFpMUU92Z0ZHb1Vtck43c2o3ckk5dkRoSGpSNnF3dzRNUFJ1?=
 =?utf-8?Q?+zCrgcez+l9fkgacdTo5q+Szu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af85f2-e1a4-4db7-6477-08dd7cd6dae6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:07:19.5344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzWVGi1l4vjL+oaG8WS7Cr+SnezXuZ8Gexr1Ezoe7+laW7xmNaP7mUMfsyvvZLm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
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

Am 16.04.25 um 10:50 schrieb Prike Liang:
> Free the evf when the attached bo released. The evf still
> be dependent on and referred to by the attached bo that is
> scheduled by the kernel queue SDMA or gfx after the evf signalled.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 31 ++++++++++++++++---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>  3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index b34225bbd85d..60be1ac5047d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -27,6 +27,7 @@
>  
>  #define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
>  #define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
> +#define fence_to_evf(f)  container_of(f, struct amdgpu_eviction_fence, base)
>  
>  static const char *
>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
> @@ -47,7 +48,7 @@ int
>  amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				    struct drm_exec *exec)
>  {
> -	struct amdgpu_eviction_fence *old_ef, *new_ef;
> +	struct amdgpu_eviction_fence *new_ef;
>  	struct drm_gem_object *obj;
>  	unsigned long index;
>  	int ret;
> @@ -72,7 +73,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  
>  	/* Update the eviction fence now */
>  	spin_lock(&evf_mgr->ev_fence_lock);
> -	old_ef = evf_mgr->ev_fence;
>  	evf_mgr->ev_fence = new_ef;
>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  
> @@ -102,9 +102,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  		}
>  	}
>  
> -	/* Free old fence */
> -	if (old_ef)
> -		dma_fence_put(&old_ef->base);

That change looks completely incorrect to me, you will now leak the old fence.

>  	return 0;
>  
>  free_err:
> @@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	dma_fence_put(stub);
>  }
>  
> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo)

Please name that amdgpu_eviction_fence_remove_all().

Regards,
Christian.

> +{
> +	struct dma_resv *resv = &bo->tbo.base._resv;
> +	struct dma_fence *fence, *stub;
> +	struct dma_resv_iter cursor;
> +
> +	dma_resv_assert_held(resv);
> +
> +	stub = dma_fence_get_stub();
> +	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, fence) {
> +		struct amdgpu_eviction_fence *ev_fence;
> +
> +		ev_fence = fence_to_evf(fence);
> +		if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
> +			continue;
> +
> +		dma_resv_replace_fences(resv, fence->context, stub,
> +				DMA_RESV_USAGE_BOOKKEEP);
> +
> +	}
> +
> +	dma_fence_put(stub);
> +}
> +
>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	/* This needs to be done one time per open */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..da99ac322a2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  int
>  amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				    struct drm_exec *exec);
> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1e73ce30d4d7..f001018a01eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	amdgpu_vram_mgr_set_cleared(bo->resource);
>  	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
>  	dma_fence_put(fence);
> +	amdgpu_userq_remove_all_eviction_fences(abo);
>  
>  out:
>  	dma_resv_unlock(&bo->base._resv);

