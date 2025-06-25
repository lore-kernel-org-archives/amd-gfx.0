Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F7AC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CE310E05A;
	Wed, 25 Jun 2025 07:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDCqF3rs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237E010E05A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk+l2WNwzYGkdI3vNxkBDltSJZ3MDR+U0xEUoytq1QqG6XArxtg7SSDifowQ5Mw/ScW9bzhgkqijCxBZmrktmUqSJx1D7Pugkgi+laz80X8Imxgc0tQcj61oybqBhMgusYnK3NtXRSqCw4mUMr1GE4h9tc+Ehvjcl5N6NXDBcmkVyqWDWg1GdJ4VFKxraAJ5JqcztP6gPjmkIfspbLgTn1y6mhVUTmiTF1+mtqIiwucyior2mjKXfv1P0ZACrdLlX42+iv0yh5FHoRYFGT4v/8WoVSvTlZ3V4n1O4cygtxEil5drQMyHVd1IISFm0u+oDDlqQy8RbqPsYAKT+GwNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owFjY85F1lAprU5Fw5ORKpzDDj1c9BVOX9370L5hVe8=;
 b=LNMS61UBldEAHtAPYy7doXkQATN/+RVKEhMtaZoTJFqbzvqxz6Bi5ND1Ok/yMbNAOLB303WwaO6rTfoe/L9b4OEaH7gwT+LpAADI5I2TcHeL6bIEP7bhgve15bZeFpW3T7ZBrfAaYGLiJTITnsuUpyNx3nAM8843a9SGtfIspC0dvS0KEMuyenfQdrsBWt4IpK2DM1drROdoDLHj3nh5W1t/9XUOPnkGK4nMIYEeow2bQCtIDwsa5+PF/fFFB8KO3lYwRL1Xbqh8p68hBD6F7PKVpgJ9YHb3+ePUH7+1Yr2lizLc4H/NmKiKgEOXEBcOP5JcAFSN3bQ+psj0mN+TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owFjY85F1lAprU5Fw5ORKpzDDj1c9BVOX9370L5hVe8=;
 b=QDCqF3rszNjLA8wn8weg6EMeAJRzhwH8C2OR/lJhFfbUiomRpHU2No/HihzD3FSsLvUVFBnR4nTBn9ko/gOAT+alb0Rdh9zmsIJlhS8iGVgCCt8HEglqtvz2UtHXId4xHphzeRurBd7f9hnudIcTJxdEVup5Q+390GmO7ArlrGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 07:55:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:55:44 +0000
Message-ID: <eeed45e4-3b24-4f53-883a-cffc70914570@amd.com>
Date: Wed, 25 Jun 2025 09:55:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-4-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: d16b4c9a-4c14-4ea5-0a02-08ddb3bdb061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTdrQi9TSFh3UXRCN0gvMElPRkRnSmdXV1FicVBvclhSNTZHRXhwSkx6V3FZ?=
 =?utf-8?B?TnA1WFJ6QzFhTnovTm5TVTBrTDJ0MjVISmNkTkJPM2FrdGdWZjJLTDgvaDRP?=
 =?utf-8?B?S3krZGpwZ0RHUVRMWXVMVkYvbnNMeFFkQzBjUUdmQ1ZjTnh2OC9lSzRqSE9Q?=
 =?utf-8?B?Q2NCYm5DdTFVaUlDc0tTMFF2VlJxME9pQUdoTlZ4aGl0dk1wNk9qN1RKTmVh?=
 =?utf-8?B?QW0zRFVDUE9UcTB2NHkvbTFLZ2UvcjJPMXNpQzY0V1ZsTytsZHUrV25pZVFo?=
 =?utf-8?B?Nm1LTHZGR0xGOXc0TURra0txdjNPd2V1bWNSdjh2bmN5VEdiWElvRytXL1ZZ?=
 =?utf-8?B?dmp3My9Ca0ViZUluWFNHVm5mekYrV0RkTzBvUGdSR3ArbG9oaHVyWDNaOUhh?=
 =?utf-8?B?VGgvTmpadXlzQUY1RnNRNUQ2b0hSVHFjZ3BoaFNia0xKenIxc0JkZEV4TkFp?=
 =?utf-8?B?bVNCcDE2U1ZWbzZZdEFSb1NIN0FBcFkzMWdXZGk3TXpybUZacFowSkVWYmMz?=
 =?utf-8?B?cndTaHYxYkZHaFdCdDJTZXYxMmdOQU5UOFlucUNVY3JHbHhmWU5qTEc3MEkr?=
 =?utf-8?B?dFQ0WmZJSEVBZkFUOS9VWk1aRE9HY3RHZ3F0TkNDYk5jZTEwOWZERHJBWlpG?=
 =?utf-8?B?MnNvTElXT09FQUJicEpxaUkxSHQ4Yzdna3dxWDBiTk5uWTRPNDlNbERDOWNl?=
 =?utf-8?B?Tmk3WmJnL2w3NmE0ZmFqZzgreGhSdkdpVW1GYTY2UFBjZlQ5UE13d3FxVUdV?=
 =?utf-8?B?WlQrTXJBQUpNRlNHbldrYnBBU0p5TDVVcnVVZHA5MkR2RzNJaU5sa2E1NmNz?=
 =?utf-8?B?VzY2UWlZcWg4M3NnbXIreldVbUFBbkE3VFlOQTFKTjM3VUY0dUhHVUNJTDFy?=
 =?utf-8?B?bXJmMVhCcG01Y3dCTmZyQy9CbE5sUFhhNzBDMDFZVFAwOGtiSmh0ZE9LV1Qr?=
 =?utf-8?B?NnpPd2hhQTFGUkpHZlplQ1hnT2dKcUVjYnd6TEtLaHBKaXVnNVY0dTV0c3hY?=
 =?utf-8?B?TG82cTJoNDExWkJGU1ZUTWZ4VGYrSnRiRkQwMGdUbmV1K0ZVVEJ3T1NoM0RU?=
 =?utf-8?B?bWxmL2pETjhhUUhIM3FjcWlpSnpURUhOVVVlRWFzd3l1Zk1Ta1JjS2hqcks3?=
 =?utf-8?B?RlpCZ2FRbk03YmZKbXY1YlRLdVJnQkRSTkFBUUFmRWtrQUpBWjZ1ZWtTRnpP?=
 =?utf-8?B?UnRLeFFKTklRYWxVNWN5N0c4V2J0RWh1aitWQW5XQ0xqMlJqMnJ0enl4dlRV?=
 =?utf-8?B?L1NhdXdrV01KdUdnV09kVVIvNnVVOWJzWStFaHFnWVN4RE9hWFJ6R2RibW12?=
 =?utf-8?B?NytrZ0Z1NlV2bURVeVZVVHBYMFdCRUxlVmdaRE5CcGNHM2xzekovdWRaRmVs?=
 =?utf-8?B?T0tUV0h6TTJ4dUo3WVRKYURYSUpORUl2SzQxbE9YMGFQcjZMZmpIUDZMc2dn?=
 =?utf-8?B?UFJObWVhempVT1BsT05vczFuSndWQWg5RWlKMzkyL1o3a29FNlhJUm0ybzRm?=
 =?utf-8?B?ZStqOFM1dEJJSFowejVVaGdxTEZBeEpWK0UwQVo0OG0vQ3JaWkdvQjBSdHI3?=
 =?utf-8?B?MlRQaElHYTNrRkJOcVlmTHRDRHVwaElZUFp2QzFDSGlZNDEwMVN0RVp6cFlU?=
 =?utf-8?B?a2R2RHdiNm93MHkzSjhZTDhRQk1mQkJVa0R1c3B2WjVpb3p2TVJGRkJkWGU3?=
 =?utf-8?B?UE1vdERqMTdZZ0pNTGVER2tIMDUxTnQyY2FFbzFURFkvVXgza29hNFdRUlU1?=
 =?utf-8?B?ZWZwenh3bkc3NERpZjQ0Ky9SMG1wQjFpMjA2ZWlldGE4Mm1PNWk1RlVUZTZG?=
 =?utf-8?B?YVFwcFVJbkpNbFRTSkg5Wk92cldSTDBzTGUxMmdIYVFVMWxoLzdibkcxMlly?=
 =?utf-8?B?dHZadlZzVkI1MGNxUmREOHE1MnlNY3BXeFZCTkRaMnR3ZkZzMmhKYkNHL0xK?=
 =?utf-8?Q?L4FMQd/rag0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXA5ejJqOVJHSzBpWlpOc2ttTC9nVEdFQy9admRNQWh3V1hsSEY4dXZpZy9r?=
 =?utf-8?B?T3owam53eE5oVGZlRVFDekd1RGhGM05zQ0U3ZTZlMUsrcXhveEFwZDB5OEo0?=
 =?utf-8?B?c3VmRXR0RU1ENFd5WDVUZHE5N3o5eFB1MjY1dExDR1ZlUGNFOFozb2Q5bm5Y?=
 =?utf-8?B?WXhBdXN4WHhUbzZIQTlHbWhML2M5T3NieEJ3dzRZWFNsM2RBVGRqSDBUUDBQ?=
 =?utf-8?B?UVlQV292cW9GRmVKQWh0Rm0vcGxZWUFYb1FJQW9nS0hoTWNNejJmZ0VKc2Zw?=
 =?utf-8?B?VHd4K0JoYi8vNVJ2dmxxUjAyUFhLMjF5SlJnTVZlYU1scGE1Z1Fud3Q5V0ZO?=
 =?utf-8?B?N0M1Nlg1SXgxNkE4UXNYd1QvUk5WYTM3QldnN3JGTGdjOVNsSFVRaFdTVUgw?=
 =?utf-8?B?a2Y0ZDdBdGt5OXRiMXZBY1I1QnViQ2dNVVZDUUhpVUhFMjdNeGRBTWVNbURX?=
 =?utf-8?B?dTBBNmRyMHcyNnVTMkFLUnNDcFhDWERQUGtUU3EwSTFydkxQWjZLb2Vhc1Fs?=
 =?utf-8?B?dU1nY0hqUlhER2NLWXc2NXJtekFCRk9NM25HTEJFNWZpSGIrYXBCWElNc0s1?=
 =?utf-8?B?c1lMeEQ0YndZU2hYdCtzeUtFNTNSaUhudEJsQnZUd0ozT3dEL0NMbTlGNXlw?=
 =?utf-8?B?NEQyQmIrTmhyZ1BoMjFXd1FLYk4xR2RtRHl6Y252aTA3SnRJRzVCTldPQVhM?=
 =?utf-8?B?NldPVzMvejBoYXU3RFROODVuZFhRajdRcE4xdkhiSytGcWlOajNaMVhoQWVT?=
 =?utf-8?B?KzlKRTZXVW1qVVhPRWRPT0tzUnJJNU5jSDZoMjIyK2pVMXJYclRJaVdVRW1l?=
 =?utf-8?B?dUJKWXRFYXZCcllVbW5wZElCMXYzL0hVWVhlcGEyZXFYZ0kyVnVmbThPSUs3?=
 =?utf-8?B?cWR5cjhLTGpRR1FHbW1RWCs0ZU1GR0VWc2pqRVdVQ01DWXhac25HbTVDRTg0?=
 =?utf-8?B?di9vQjRnZjR1a05RTnFqVWhyUzdLL0c1Si9jREIyczZpRU9GdnlQVjArYWEv?=
 =?utf-8?B?aWlPNXdhUnlXUE0vaDFUelFicmNoaVozM1hnRFVyT1BUSm9HZGx1WWlhd2dN?=
 =?utf-8?B?RWFvL0I1QnNlREcvdEczRCtTT2xDczl1Y1pPQ1dGSlFBbTRxUkhyZWpwWXZ6?=
 =?utf-8?B?SUl3MkdkOFA5QTNITDh4L1NmcTJZTlUzYXcxRG41K1FySVd1LzNOWDJUN2xi?=
 =?utf-8?B?SDhRUkdXb1dSZzFZZExweXROSnNId0lqRTFwN2tJc1J0dmgvWVVvOVlKaStm?=
 =?utf-8?B?RkVocHU1Sk1ZRDd1emVCL0Z0amJLdXRoUWw4Y3FJcHptN3NYMmRqTnJPdXlX?=
 =?utf-8?B?WnJBa25QakE3cFlwSWkyVDVIT0JpenVieXhsNUx6eVVJeFFPOHRHczVVYkVQ?=
 =?utf-8?B?UjZIaStxbU9DNUNtWDRqZnZDT0c0cW54QnVTbDBNQUs3bWl3RThaa3dUSXZk?=
 =?utf-8?B?Y1hRdTZOSzI4b0RUL05JM2s4dXpseUtnTXh5Zmg3SXN3Rk9QbDRPbnpYVXdY?=
 =?utf-8?B?eVBMYXpJWWl2bGNkY25TUFhqVkVFT052dm5iZkNpWWFhZnlYVHlCTlZiZHlt?=
 =?utf-8?B?WkhCSW1seXdtVDNITDZWOGZuYVg4bXpid1VlemY2S2k0MzJLT2l3WGpWKzk1?=
 =?utf-8?B?bHZBMXFtMFB4eWxnb1NDZTRrZXNjcllYREhyNURpajhkWGVJcHhRQUlMOEV6?=
 =?utf-8?B?RHFVeGlMR3p6VG5lQnZkMkt0dmkxUkZSYi9OVnh6b2ViMEoxcTZpVDY0ZDhB?=
 =?utf-8?B?SGxnVFBxTWR4N08xMkpkOGtpT0FtaFpHSkpLaG1qQ3JTVCtoNWQvK292UnNG?=
 =?utf-8?B?bHVNN2lMSG96c1ZsQnNBT2FMT3EvQmh0WEVtTzZLWW1ha2ZSbHNVUTF1Z2Fj?=
 =?utf-8?B?eW9rUEk2T3EyNXZWdUJ3bUt3Sk5iM0pEaTdsVkUzV1E5MUltdUNSMWQvSVJF?=
 =?utf-8?B?ZnVYTm1oVm5ObHB4cFp6RHV4K3FZdFJldnEwL1V3QjgyK3oyT2Jadml0V0Js?=
 =?utf-8?B?NzNJT0R0bENvQWhpcmRDekhYQ2I1ZmRObE9PMERZWWsyMEhVazd0ZFU5RVdu?=
 =?utf-8?B?aTl2ZDYxVmdXSFNqZFhHR0ViUWRiVXFVT2x0M3RuSnhlVnhMVEdVUzNSRWpC?=
 =?utf-8?Q?kY912msVjDZcHxYJpRI6t0Nvy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16b4c9a-4c14-4ea5-0a02-08ddb3bdb061
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:55:44.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQng3Bu8kEpaChcoysxoU2NPYkPH1OGzZoioA2smryjTgUy4lcemamFVWLe5vIWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

On 24.06.25 10:45, Prike Liang wrote:
> It needs to validate the userq object virtual address whether
> it is validated in vm mapping.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index acaea4416ed2..a20f7ccbe98e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -31,6 +31,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>  
> +#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT

That doesn't seem to make sense to me. Why is that needed?

Christian

> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>  	int i;
> @@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +				u64 expected_size)
> +{
> +	struct amdgpu_bo_va_mapping *va_map;
> +	u64 user_addr;
> +	u64 size;
> +	int r;
> +
> +	user_addr = amdgpu_userq_va_align(addr);
> +	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!va_map)
> +		goto out_err;
> +	/* Only validate the userq whether resident in the VM mapping range */
> +	if (user_addr >= va_map->start &&
> +	    (size != 0 && user_addr + size - 1 <= va_map->last)) {
> +		amdgpu_bo_unreserve(vm->root.bo);
> +		return 0;
> +	}
> +
> +out_err:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = -EINVAL;
>  		goto unlock;
>  	}
> +	/* Validate the userq virtual address.*/
> +	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
> +	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
> +	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
> +		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalid\n");
> +		r = -EINVAL;
> +		goto unlock;
> +	}
>  
>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>  	if (!queue) {
> @@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>  			return -EINVAL;
>  		}
>  
> +		/* As the queue_va and wptr_va etc are the useq cpu access address and they
> +		 * are also come from the user space IOCTL request, so they may need a access_ok()
> +		 * check before trying accessing them.
> +		 */
>  		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
>  		    args->in.queue_va == 0 ||
>  		    args->in.queue_size == 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..704935ca0c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +			u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index dbacdfcb6f7b..4615d3fba530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
>  	struct drm_amdgpu_userq_in *mqd_user = args_in;
>  	struct amdgpu_mqd_prop *userq_props;
> +	struct amdgpu_gfx_shadow_info shadow_info;
>  	int r;
>  
>  	/* Structure to initialize MQD for userqueue using generic MQD init function */
> @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  	userq_props->doorbell_index = queue->doorbell_index;
>  	userq_props->fence_address = queue->fence_drv->gpu_addr;
>  
> +	if (adev->gfx.funcs->get_gfx_shadow_info)
> +		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>  
> @@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			goto free_mqd;
>  		}
>  
> +		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
> +					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
> +			drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>  		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> @@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  		userq_props->csa_addr = mqd_gfx_v11->csa_va;
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
> +					shadow_info.shadow_size)) {
> +			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		kfree(mqd_gfx_v11);
>  	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>  		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -291,6 +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			goto free_mqd;
>  		}
>  
> +		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
> +					shadow_info.csa_size)) {
> +			drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		userq_props->csa_addr = mqd_sdma_v11->csa_va;
>  		kfree(mqd_sdma_v11);
>  	}

