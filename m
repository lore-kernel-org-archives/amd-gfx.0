Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697C6CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B3510E775;
	Wed, 29 Oct 2025 10:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Acs5OhDJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA9710E775
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDYgPXq2TQiUwArrqUzbK1rhpHD0M7pOlWTkG6MKC2CauUIFWFa5iMOFvmRqb65rfiBPpPki/rG+OEimJ1/9mTVIhpeERrQ2AP4l2eJ5IPvIBK483BLlruPFLZHIhxcaT4xgPkz1NBrP4zhR6+0yIIhToTvSp+crl5dS+lq/UMF051ICqCjuTFG6ZUgWSvK+eOCs0rL5ai07wPBG+nhuk9/6w7ejo7uLqjwj/I6mcsVtEd8aATsIWh6C7ZcdSjecEnJgulihHKkRnQ8fCe0IYGa9eX24ZN+7ioGcWmfNaHACqSgPRwHhm2ni3ICLjSgY2kE5BFdyXCapqkCEytEOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sL3P1B59080Ua7Xd9hDdgBj9TSEjGKxXhCD7bkKFY8=;
 b=TtXOF+IQk2SrTtXzTj3mQKZVRVMvAPIzmJ1gho7HBxex/RkTG7BGpxqN9Kb7C3+7HSwkdlBJMCchuSUhYMlSNLhK0/8TBElf9HAgYAww4zQ0QPlLcCzziCgpzPXHyMc1qOq8vYIogOSj0F325/yMphhuqUiYkiw8q4J3DRXU+S1d002Slz8e6VGtFxLRPS3xN/m6OIKkVhB8uIcfQ1CllihyhhIDUw+mdvAzoa4B2Zi0nLifkDMk6kcoY93ydv3W0SMTDSQwwIsnVKFVw+6yuyMzVJ8FxmLTVK9rpVlCZg8YELnGk413qfWnEV4FN0H8eMjmC76Dx/eJ3thXC/cJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sL3P1B59080Ua7Xd9hDdgBj9TSEjGKxXhCD7bkKFY8=;
 b=Acs5OhDJYHIQtM4ioA/eNATRzkSNmmByi3mWXOwOmhsPAJolVoz2xaInIlw7X4O1KIWJe989sMmRTGP3FRJKzQW9kawKb1kD4oOLOWf9CtBriEGpVsRpUwoGUDq/s7b0V8DCkTxVcU8vkQqTfy2B2JK5eaqHFsRlo4jJ2CAhTjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:01:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:01:12 +0000
Message-ID: <135ff09b-5231-46d5-83df-5fd81055b792@amd.com>
Date: Wed, 29 Oct 2025 11:00:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amdgpu/gmc6: Place gart at low address range
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 898ed896-a78c-420b-a704-08de16d21702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFlFQWJKSHJpMmZ3d3VYZVVqR0MzSURMaFByOXllcFdlRElVYjJJMnpoNHE1?=
 =?utf-8?B?ZjVXSXJYMUsxeFVjak9UblI4WEYyRGNUazUveTQvQVNiOWZxSUR5N3R2WHlM?=
 =?utf-8?B?TmdlVHg0RE8yVXV5NkJ2Y0oxbDhhYlUwQzA0RFZXSmhmTHptM2t0Y2JKdEtp?=
 =?utf-8?B?RWhIRi85RXBrTHJzempmcWNwZUl0ZisvUHZONVNVQmxSaWNJQWJtdXJ2bXNE?=
 =?utf-8?B?YzltTWV6bFNqQStzd2Y4dThtYnA5V3krOVNVaU9GOUhzVGhqMU9LR1ZidjZJ?=
 =?utf-8?B?MzJ0ZUQvM3U4ZDR1UDMvaDZ2WXpkK0l4K1RHeUN4VC9TanQ4NDI0eFdvUW5J?=
 =?utf-8?B?V3NuVjk0Wm1kYlQvQnVkeEhaSmNZdFVFbEZ2ZjBjaWNTbmNwZ1Y3cnlTZHZh?=
 =?utf-8?B?K1M3Y3UxSTJHY0RSbUJIYkxDWDlOUWZvNzAxVEtLMHpDbmV1ejdVd2FVOThj?=
 =?utf-8?B?Nms1cFlvMC8vMStxYldEL0xvenphVkp4U3hxdmtJc25HQjRnbVk5OFMzaDVE?=
 =?utf-8?B?YVhacmkwa3RvbXlOVi9DSm9vMzV6ZVVoa0tGTVBwMGd5bXhmQldZOUtQQVkx?=
 =?utf-8?B?c3Bpc05YdHQrUkNheFRiNElYanVNbmxyOWtET1RJY29RL2NHNk5iMkJoQVBW?=
 =?utf-8?B?eXdXc3ZkRlgyc0NGd0t1YVRhTkk2MWZ6K2l5QjAvczlpSUVRQUpHUi9zeXhH?=
 =?utf-8?B?M3NBREd5Z3I3ZUYzRUxIVVBNY2xnSUJpK2t6QXNjN05WVnZ4WjMwYmZOY1Ux?=
 =?utf-8?B?ak84RWU5d1lOWVNDMy9tUjQ2MmtyNWxrVXNLVjJwcFV5UlN3dGNDek1JZWpL?=
 =?utf-8?B?RG40N3RHdG55M1E5eG9NcUVWaDZnU0pPc05rbTdsTENPVjV4UmZKWHhHN292?=
 =?utf-8?B?OGV6aGlaTE5WczE5NEFGWVNUS3J6THhSMUxNMEpKc2Riamk0RTZxMC9sK3A2?=
 =?utf-8?B?UU5ISGRHdUM4R1Mrd3F1ZTFEZHJZNGNlQldleURCbmxwajN2WmI4YjlraG9n?=
 =?utf-8?B?WjUyMTcxTkx5eHBDeGpsbko5cFRVUjJSYVo2SktXMVdlK3NCc1B5Y2ZjdHRN?=
 =?utf-8?B?OWxCWHo0VUM4bmZCSC82ZHdFa2pNK1dJaFI4YVowVzRJN3hVbHkzZzFyNkVX?=
 =?utf-8?B?MkVBWU9BMXZjcXRwMlpPcVhnWTZlUTUwRWdwcHJBelYwSmRpSFBVcDU1WXlO?=
 =?utf-8?B?NGpBbElHTEdQS0w4MWxjQzk0VS91Z2VsTFNWekJhS2hIL1hDa2lZcWlnKzlq?=
 =?utf-8?B?a1lCNnFIU1hpbklJTkdkbm1EYTdDeVdoempsdERtVVRwQysyT0ZmcmlaT2FJ?=
 =?utf-8?B?aU5seGtRMWwvM1ZsVzB2TkMzQm5XUFl1SjdBZXV1eWluMEtDbU9XcjMvT3Ft?=
 =?utf-8?B?Z3MvTCtMSjZtV1lDd2dTa1pqVk1pcVJWR0UveGlMcVJCWVJSQ013ZFlUeldx?=
 =?utf-8?B?MG4rUEJnNjljeWg1dWtweWxtSUoxTHZGV0diZW9sK1dYUTVGRHVHd1BUeTNS?=
 =?utf-8?B?bm12eXQ4QXp1UVVWRlJvR0REbzFqWkRvQ29TMkRmVGhnb2FWa0N1R3NhaVNv?=
 =?utf-8?B?K2R0WTdNU1ZVcnFFNmREY0dOdkFpUVMzNkFwdW12cERRc24xQUJ3MTd1Y2Zh?=
 =?utf-8?B?NWdLSExzWFNkRDRGYkRvVW8xd3hkbWRmU05MQ1ZEL3Z2RVJOcEFRbE1PN2Jl?=
 =?utf-8?B?Q2hybTl2Zk54ZG5WZ3gwWDdRb2xnc2dWcnU5UENXcWVMajc4WHVlWkJPZDlz?=
 =?utf-8?B?OWQvUGpRL0l2dkNQZGF2VTVBdERRYlZOSW1yMVZmTHBWRzV5eWFoRWhkVFJP?=
 =?utf-8?B?dHJsc1NHUTF0VVVVM3NETU9hdE4yV0k3VzN5ZEtFcE1vaDRhcmh2aHhkZEtX?=
 =?utf-8?B?MTByZFVERlhiSTNnU2xhOVlMZC95c253UXYxZ2RMNzl4WjM4QklXRysrYk00?=
 =?utf-8?Q?TUh/zdQgN3HqrWAX9uIYZBXuM4O91Mya?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5XTlljY1hpeGVMYks1QnlzZUYvZ3NnaW9Qamg3RWNseGZybjNaV25PT0JV?=
 =?utf-8?B?UEZCdmpRQXoyOENra3dwNDA0Y2JQVWR1RFJxa29iaVBIeGlHbzliazZGa2Iv?=
 =?utf-8?B?TVgrbDg2d0dpekVFbHNDOFBWa2JrN1hqR1hDalg5RGx6WUpvellOMnZSbXVN?=
 =?utf-8?B?MDEzWXZPMjlRdnAxMFVyS1B3eHhYdFFDWjRnRDg5dXZBN21IQ3dVUmhDOFND?=
 =?utf-8?B?MThLWVp3TnEvMnErR2h1dUIvTWpYZ0NoM3FoQ0pyaFZxL21mK2tXeDh5YnVx?=
 =?utf-8?B?NVh5ck9rS2RDZWFYK3RUbzlLKzhSNFBwSlJQNXRBeExaTW9qdUN5akV0Qks1?=
 =?utf-8?B?cVM3emJ1cVdtbFI1N1N0cE1YbEhrQ0ZoelRVa3lIYW5nZFU1YThlV1hIejBm?=
 =?utf-8?B?NXdUOEVFeTZmY2JNVzNKNjhHZ2hsSWkwVXA5bWxmTXlOZ1kyWWp3TXg5WXdW?=
 =?utf-8?B?eEFWL1g2ZzVIVTZQNXE1T1RhcXBNWjU3VE9zcjI3NWtVQWdqMjMrZE96Z1NT?=
 =?utf-8?B?YjcyOXNzRm1mc2oxUFlCWkF6bFZ4N0RQUjBTMVZPWENmeExpaDcyMkpCeith?=
 =?utf-8?B?TVl4RlRuWW80UzB0Tm5MOFFGcHE1SEhhMkttRDhBOXlVdVgrdzEwMXNQdExF?=
 =?utf-8?B?NUptc2NKOFdnQWdYc1pmaERnR1ZMNmF6ZW1OZnBadnc1VnlvRjJySktIWVdh?=
 =?utf-8?B?bmsvemRkR0wvTE5ZcDRZeTE4V01KemFQR1UvRTYzaTVoTnlDcTZKTE9GSDYv?=
 =?utf-8?B?WFVTdWhRTVhkTXpqanpRdFZQU1hEMzg5M2IyWU5PVkh4VUlwRW5hc1ZzSDUx?=
 =?utf-8?B?d2NLak9nNVNzQWJuWjg0OWpTejJ4bS83dXVoMkMyWGhOZWNSYXRNVnh2UEVS?=
 =?utf-8?B?dzFwYlY2SzJVQSt0VW5HV2ZFUzBaemtOZDdyY3V4MHNsSWl4Q2pmdzFQaUpZ?=
 =?utf-8?B?dm81YUkrY2pnNjFpRExXMFdQNnZIcFFLTUJ4UTJIVkc3SU4wVk83RzRsbVdJ?=
 =?utf-8?B?OEQrbDVSOU1keWM0emhCSkdTeGJJK2ZiL1ZpbnVMby81MFB0Z3dPSTRBTENa?=
 =?utf-8?B?N0lDRTYyY2hHSEhKSXp4cWhaOUJ2UTVYdFMzZE1mNnVpTjVOeGQ3c0FTQ1Z0?=
 =?utf-8?B?cU1NRW9aVkN4SVNjSk5mVGlZTkJySlFVWW5XTVZqdTVxeDB1UHhqNDRNRzdp?=
 =?utf-8?B?bVZwR1RwZUVWWWV3RmNFcmNaUzhlQytrNVdPV2l3VXA1dGJjMmtwWVQ0MVEy?=
 =?utf-8?B?U0FOZVI5NzYwQzBFb0RPbU5QUFFjZWRKNHNWMkxnYjRqQm5WaHNOUXU5OVQw?=
 =?utf-8?B?eDhzSHRUcHpJMmhwWkc2eFdjbHFaemEvRHlKcHhTSVRZM3dwcEE5U3d0YVM0?=
 =?utf-8?B?YjlqR2xpbHRUeml4YldMQ0h2dWtnaGdHVEtTNTVnQkQyMkhUcFRnTHV6clJL?=
 =?utf-8?B?MnF3RDBDK0x6cnJ3NnQ5SlQvbDZVc3V6NFE1ZjZkaTJySzI3bWkwTFBJYWNp?=
 =?utf-8?B?YXRBZWlxSDlPSkxSUGdkNTNMUWRQRTNNMlRDckVoTE92STV6VlZwVTgrTFZu?=
 =?utf-8?B?T3R5TTIxY0dYaGlxWDk3ZzdWUWVBNW1qbUFvY0R3akJaaHNsQ1pHNVNwZC9s?=
 =?utf-8?B?aXF1SE5FcVdaZlFDc1V5M0tub3BMU0RzSHdGRzh6VzliTTA2UFBPSnVXdm1a?=
 =?utf-8?B?NTlsa3BxZGZ5KzhKUkdLQ0ZjbHJwZXhrcHY2dkRaYm1va2RYL0drbmplSjdN?=
 =?utf-8?B?TDFuSTBVb2F3UUFBb25pMDg4M21sQkVaN0ZmcmRVMXB2c2FxcnR2YWJjY0VT?=
 =?utf-8?B?bE5yRk1ObVJmSlhJZHFEdnMxNWk0VUlNb0lVanJzNEdkS0orWDYybnZzWDVt?=
 =?utf-8?B?T1h0UHNwMytZVzhQaytnMmh0SE8rdVRzeGd5R0lISlZZVTAxSDREVlEwTWtB?=
 =?utf-8?B?eXRESnlCWTlveSttUGhtNjg4MGFtbUdnZEV5ZVR4Nk82azNRRHNKQkpKNlBX?=
 =?utf-8?B?eFhWeGMrMWYxRStjVFZBZXVtU2lzeC9paFltSVpXSWI4MWVOeDRoQ2hpUndp?=
 =?utf-8?B?UzBEZGlXNDFEY0xLbXlTSHBvSkhTQUtGRnk3Y2picVNPdVg2a3NLclFWVjhM?=
 =?utf-8?Q?S9X8VbyFIDQxCN1GhN0iFgOKb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898ed896-a78c-420b-a704-08de16d21702
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:01:12.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8CViEBYMLSdA4zo9cB7pCtR36RVezXCD6FP5MxOg9OgFeY07wlOIB+xWagDy4M4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Instead of using a best-fit algorithm to determine which part
> of the VMID 0 address space to use for GART, always use the low
> address range.
> 
> A subsequent commit will use this to map the VCPU BO in GART
> for the VCE1 IP block.
> 
> Split this into	a separate patch to make it easier to bisect,
> in case	there are any errors in	the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index f6ad7911f1e6..499dfd78092d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -213,7 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	amdgpu_gmc_set_agp_default(adev, mc);
>  	amdgpu_gmc_vram_location(adev, mc, base);
> -	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
> +	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
>  }
>  
>  static void gmc_v6_0_mc_program(struct amdgpu_device *adev)

