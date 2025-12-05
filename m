Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFAFD32D8A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 14:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBE210E9AB;
	Fri,  5 Dec 2025 14:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="utSY+BXa";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5958B10E9AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 14:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNYzpUKEAbwlcG0148IrbHEMeJ1cAUyho4uIhep3CdQ0OSLAAB3re5XHJ5lVwBuRDIAEPXazRoQsBL++PqTsHewMMrGq9BdbEI9q4FjWnuuIe9noednyP1YUD0UCebQvjQ2yuzjDjxGJLyOSeEEdbAx8dPyyGCXo+OSCFJRueUXB+PTCIUZGzRBF1H1pX68NRRbGmkhDuPcB2Tdd6jT3IsVf3EWQaQpE7uD2d3VR8g/Unl1zLQ2kGwkzVWbjKf7QdUqOGDf+7HHkJiUPp9hSwgauoe9pAa5FqIj+y4Gncime15MDUl6rGnlmMvZkNGjBm+obm7xR4euytNZttHtFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G80LdXnbPvi+xYmU+vIRzoh88kLOnM6POlJrbSJ05Zg=;
 b=h2kGL6faThQoNFfdYS/1FnWzeHNB5V2nAu4NN0jfzR372YJtENNtG/nYMU4DKIkQlqBMIHoaMkrqCSlmoKVNx1GxVX34jw5oXFpotPWheVDk8f/e2EjK73ny1L1iUoXXro4RbhhSW6NR+tP6yFjADxCNShRukkZNx72o0PdH/emCf4ciPtE64VbMYwjjR+TsROjL6J4CDFnPaUDsLuqgTn6idxORl3gFMK2MpTXjUDqHwuyLa7suWdw6Vs9xBPjehBtkVM64384bZJFgaFnah0dQ75ZbkJ+uj5cLQvuGQhKgUYSawKaOEzGzyTnQRhX9RPdDcPU+InVq02EjM3z3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G80LdXnbPvi+xYmU+vIRzoh88kLOnM6POlJrbSJ05Zg=;
 b=utSY+BXa39lbdKIgjsRiqONkXzhIE1YrNSy0azBcWDzzM/ciw/Ijq97/FEnCXCRNfIxnmiZnJj/e6TZoYn/64Vt8rnVl5A3LT0MyMwDhPaKrQb5MnnTQtDf7P2S/aSjxP4hsDIKXDd6QpubY4qzLhGhCJ3KN+SYFhaB8eCWH9MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 14:45:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 14:45:24 +0000
Message-ID: <326f4793-58c3-48a6-a19d-4ed4a3ca2f4f@amd.com>
Date: Fri, 5 Dec 2025 15:45:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] drm/amdgpu/userq: Do not allow userspace to
 trivially triger kernel warnings
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205134035.91551-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fad693-836f-4039-ee17-08de340cec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2J4c21VREg5NHlCVFB5aDhNam4wQTZ4bERnZm80M0RZUldhS3J4bGowOG8y?=
 =?utf-8?B?M1Z6OWRRbFF6RDBkeWFUeWRJMVZkOEliVzhXdHIxQ0gxRzdGY0J1K1JPRllm?=
 =?utf-8?B?cWFjejN3YXNaQWF4Qkxqc1lMaGRZazdMQ3V2ZnUvL3pwUGtXcnNkWlg5VFVS?=
 =?utf-8?B?ajhmSXhHdGxuNTg3L3dRdDdpV1RPUUM0QWkxNEZmOGVUV09KKy81VmtteG1T?=
 =?utf-8?B?dkpWZ0tGbGFBaXVVQXlqdVF1MldVVXA2ajFERVEwU3phSiticzc4eTFiR3hl?=
 =?utf-8?B?eFJwRGMwbzVoMjlJc2JscUVMWndMVUhkalMyQ0RhdTdIdUsyUkFxUHp5Tlk3?=
 =?utf-8?B?bHBjZnRLNVNnUE9XQlNabktlb3Y2cFFpT3BiNTFVOG5naEw0UWw2NmN1UTJC?=
 =?utf-8?B?QXFZMUdyQiswY2VYaDUwaU9kZm1tYUIrRzZNYnVVZit0Z2MrSitLQU5FaVFm?=
 =?utf-8?B?azNaejRhSXZSYVNKZ2I1bnZBV1JGNzYwQmxXR0EyNHdsdm1nU2FCY28rRDFj?=
 =?utf-8?B?c3VhL29BMnREQjdGS1Y0N3lZZEFQclBaVzl2Kzc5NGVOblJtdm5tV3o3ZDlo?=
 =?utf-8?B?akVCeERWcWhMSWJ1bXV5bU9HNG9EL0NId2JIdWVIb1c5OWdob3dtUVM4UFhJ?=
 =?utf-8?B?WVVTYTNNcGFoTHRISkNuUEVMWGpwd1VmeXNYSlZSRFA4Rys1UmVydTUyQUdS?=
 =?utf-8?B?VG11dkZ0akcxWjlPS0F3VTMyZlUzanBCc3UyemwxbDVzRnVONWlCQzhrY3lM?=
 =?utf-8?B?dHVzcHVlTENpdG5Bd1dPTFUzZ242M3YxRkRuTU1SSGtqaUFvZzZOOCswaVFr?=
 =?utf-8?B?WXFJb1V1WE9sQzRLNXByVTJoQUN3NDJLcjF3b2J4TS9ZSy9qTEdQK1BkR0tE?=
 =?utf-8?B?RTJadlVYb2pSNGVKVmJWZ25ucERVUGRaUEFBSEtVdjBWNWRZS2hlWi8wem9O?=
 =?utf-8?B?RWt0MUFDbG9vUVR5aklHTGhFRmhSWjlZcHphRHRUL1FmemdjSXVndzZrODly?=
 =?utf-8?B?TmxPc09hTmxPdDQrejFraWszaStaUDNtY2pTNU1lNDZ2bm52N3dxaVVyWEJO?=
 =?utf-8?B?WGxxUW5QbzJ2MEtpWmVkdTd6ODVpMkNCaHZPZjF2ckNrY1YyYTBsMk5rTm1u?=
 =?utf-8?B?KzFWeWM1bFZ3aTRsdDlyK1RCaHp5NXk4L1ZMMkh0OXMwYlZIbHRERnl5dUVM?=
 =?utf-8?B?SXBLN1RRQnZ3YmRYTlJWT1pvcGR1YkVTcUVXY2lsakc4MCtleisxK2pZaUJ2?=
 =?utf-8?B?ZVhYK0t2a25ESGdpbmJnVm1leEpjSThVS25lOGV6ek43UmFmVm1UcVdTOGR4?=
 =?utf-8?B?VGo0SXRYZE9wa2tSNlRWRSs4cEpwV3NoVXZsWWc2Vk5DeDlwK0NMRStMNU5j?=
 =?utf-8?B?U09ma1gwdUxlY2M3UDRTZ05TUU53WTNycU5DM2E3T0haeEpLcm5VTXMvUzl3?=
 =?utf-8?B?VmRkRU00dmZ2VUJkd3BMQWEzeGtBZjJabDZvQ2tNeVB4eTdQU3FlQUJZb1ND?=
 =?utf-8?B?QVRiR2JJeFJmaUErNVJkbjRhQzhzUjhFRWdJZm9nZ3MvUCtwUDlnSE5vZ2NN?=
 =?utf-8?B?MjZrUHZGcDlPNGhWR2NrcUhPYmk1a0VuZmkyaTR1NXlrVThxY3M1em5FNlpQ?=
 =?utf-8?B?R09jTTA1QW44clJkeU9OM01wSUlueGlZOGYrYXByN3FSOGRJMUhYYWFVNmw1?=
 =?utf-8?B?eUxuT0ovTUEvTVVLZmhiMFZoajVMRmg1aDd1czBURU8waExFc2xHR3BTM3NN?=
 =?utf-8?B?RjlkVUlrbjFYSFNYUlVXSUtlUHNPelBZMENON0YzbVhkRkxveS9ieFJ5MW55?=
 =?utf-8?B?R1JueGhWbk1OYlk5QjdWaGRTQ2hRcTNWRWZBUkI0dmFyUTlkY3lvaG1MNXRE?=
 =?utf-8?B?YVhmTkxBVTE2TE9xS3piVjNXWStTZ0trdWRkZ0NaZ3lzS3ZFMkFNUExhYmRl?=
 =?utf-8?Q?j62eY7ayhw4AkyiUmw4god2RIWcuxfBD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9pYWFuWDk2cENjOW9UV2FjSm1LclVkQ3p4aFkxZFkvUWw0OVpPT0xPNzQw?=
 =?utf-8?B?T0FlbndQNFNIVnFjUnBXNkYxVUVoSmw2VnJIZjZhcm5YNnNqc3JRa0YralVa?=
 =?utf-8?B?cXZ2dXlVWjI3U2g2TC9PUWF6akExTGpSa3BRbi9ialRKQk5FbUVuQ0N2MWhL?=
 =?utf-8?B?c2Q1UWg1cVBwZXFoZE5nU0gvR2ZONTFWYmlpRkZXUGF6SWl3NytkZVI1OThv?=
 =?utf-8?B?NXlsOVlZdmpHa3VDdlV3dnBhRVdleFRQL0NveGZwMTNFTm0wVVpPZWF6Q0F3?=
 =?utf-8?B?Rmg5dG95MnUwdzNLMXJtN1Rnbkg3alg5RmlvMlFLdDJ6WHJwSjdmcXlEWGEy?=
 =?utf-8?B?SC8wQUxwVGhrdUo1YmJqSUdHcm9oVmdjUGpwcW54N242QVpINUpZY3M4NXZY?=
 =?utf-8?B?Q3V0NCs5N3ltZG9EMmJoZm5EbG9oak9VRGdGS0ZzODZVWWdWZGlFSHNmYldU?=
 =?utf-8?B?cjRQYU5iRklLM0lMcEdHaXdTU1IyMERxY21ycytyckJmbCtvRTJwK042OUJn?=
 =?utf-8?B?TmdML1k1UXhnNFlQU2Z6OVhnb3JMZjZvQWJUeW5JSG5qZzJwWnVTYlZDR005?=
 =?utf-8?B?Y3p5cjJqdTFqTWxNZmF1VktmQnRwaUhPNU9IVjVubFNHZDBMU0FWVjJzajRk?=
 =?utf-8?B?VjdLVklyVVU4OWYrU2hxbDB0UnlYWmdCK0RuRUx0SGhUU1l2MTRBeHFqbXRj?=
 =?utf-8?B?RWlqY2I5S291YUpGMnpEMko0bnc1aXNzbG1Ydi9peTZwaWJ3TnVVUEFoUER2?=
 =?utf-8?B?MjkvYktwT1psdjdBR1JZM3FZY2k3UFNTakF2VG5pdGl1eG9oMnhmWmx1Rnkw?=
 =?utf-8?B?Y2krQytoUzJ2aEptL0dJa3VIMUlOZ1IrWjR3d1ZTWGsxa3R0Y3RrRFJyb3NH?=
 =?utf-8?B?NkhCRTIzUVNtU0hRd2Y1Y2luZFcrTXFiQkRSODYxU2JvV3FNWmdyUVczUDhH?=
 =?utf-8?B?Y3FZdHRFWE8yVFp6NlloWStNV295NlFCQTlyTTMvU1pMUjRVMUFKbUhxL0dZ?=
 =?utf-8?B?TmE0R0ROenFBK1kxbXlTTGI0U3NBZ1FnTit3UFFDOHFZZmV5R2M4b2pXQ3h2?=
 =?utf-8?B?NWV0NnFIbi9GN0dhbHdOcFBJcFh0TDZSdXNVaWc5UUF6TTE0aDlXQWhQOE81?=
 =?utf-8?B?VGxKbkNHdkxFdFB1TGp6M0lrYi95dm0xZHh0MDQ2T3FuZ2pLbHlkYmx3K24r?=
 =?utf-8?B?U1FvTUxMQWRZcTRUK2RoV1RYVHRmdnVjcC81M3llcHZ5TXlIVFdibnNYV1Av?=
 =?utf-8?B?Um9sK0ZRQ1hSVEFOaFhMdDhiczN6MjJnME1FaEF1RzlPbDFSaGxlaFFZT1Vq?=
 =?utf-8?B?SzVCTmh6YW8yZWNWdFJWMFNwSjF3bDlOOW5EdGJVUHRaUm5xYWxqeTE0OVdL?=
 =?utf-8?B?T3lIQkNPeVRmQ0hXM0l1c2x5ZlZ5K2g2WjFIMzRCQTB6R2plZk5uQW9CZFRD?=
 =?utf-8?B?dUFNNXZzd2ZpWlRFTm11cE9uMkRvVVRlYTU5cmYzb0ZsOXpvWkVkOG1JeHpH?=
 =?utf-8?B?dm03bStkU3pBbTc1eGR4WGhscWcxM05kYTAzd2duUkdGUmpNTlUySG1PZDNh?=
 =?utf-8?B?Q1V6eHA3ODcyVktEZGJOVGdHZ0grUitWb1hkMGFsWjltMjBwcmg4b0gzRTRv?=
 =?utf-8?B?azRJWUxUQzJOWHJ6RTBlODBhOFEybmdScUdBSXFiNXUyVWQ5MVdSYjdUWFRK?=
 =?utf-8?B?elJwYWRUTkkrdHRMdVRFejdkb2hjSXBSVGZ1eXZyM3h6NFBoVHJ2TzF4YTNs?=
 =?utf-8?B?a3o2L29FSDVsRlVBYTNCZUkrOVRmR0xYWGZDcWI2NzZGWTk2bVUxMC9QV2t0?=
 =?utf-8?B?dE1nVmdDUEFwNC9Jb3ZTNnpydmFsUXdmK3pCK20zZEV1Lzl0Q0U1OCtpSzlm?=
 =?utf-8?B?WHRGbU1vUjc4VXFQdjBYWEJPWmdyc25HamhKRGpSVVBLbUFDKzdOREhVOW1n?=
 =?utf-8?B?ZkgzSGZGRnFtV25sblRVMitKa05BaTJRYTBxeXlpTTkxM3QzcjR3bXlEaXNp?=
 =?utf-8?B?OU1mYktUdzlaWkRIY0MxRU1TTjNxMTZjS1lESnFZeENqdWRVLzZXK1RFYzUv?=
 =?utf-8?B?VW1vS3pzVzZ0TGh5MWlIdStTUlc0ZkN4Vy9IQTE2cUNMcDNrbHMrWUs1Nk43?=
 =?utf-8?Q?G+EMmEhrAxSwp10WF/3z2Xz6z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fad693-836f-4039-ee17-08de340cec31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 14:45:24.1629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIpXofhnZ3spJMEuR4y3FEZjES4y1vl6d1NZk7pYpBBpY+pq8hJkElP+8Z7NFokz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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

On 12/5/25 14:40, Tvrtko Ursulin wrote:
> Userspace can either deliberately pass in the too small num_fences, or the
> required number can legitimately grow between the two calls to the userq
> wait ioctl. In both cases we do not want the emit the kernel warning
> backtrace since nothing is wrong with the kernel and userspace will simply
> get an errno reported back. So lets simply drop the WARN_ONs.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 13c5d4462be6..9bec744127d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -822,7 +822,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  
>  			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>  						DMA_RESV_USAGE_READ, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +				if (num_fences >= wait_info->num_fences) {
>  					r = -EINVAL;
>  					goto free_fences;
>  				}
> @@ -839,7 +839,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  
>  			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>  						DMA_RESV_USAGE_WRITE, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +				if (num_fences >= wait_info->num_fences) {
>  					r = -EINVAL;
>  					goto free_fences;
>  				}
> @@ -863,7 +863,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  					goto free_fences;
>  
>  				dma_fence_unwrap_for_each(f, &iter, fence) {
> -					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					if (num_fences >= wait_info->num_fences) {
>  						r = -EINVAL;
>  						dma_fence_put(fence);
>  						goto free_fences;
> @@ -888,7 +888,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			if (r)
>  				goto free_fences;
>  
> -			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +			if (num_fences >= wait_info->num_fences) {
>  				r = -EINVAL;
>  				dma_fence_put(fence);
>  				goto free_fences;

