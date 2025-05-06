Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5FC3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC34F10E1FC;
	Tue,  6 May 2025 09:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rEW44F8F";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6086A10E1FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbyVpmsleCU2Vw91FTDezQwVuV0pZMq3E2dFKMJ8MdMWfBg+AJ3QlJvHnvd7dxUhPjF786eL6F8KFYmb9GteAk8Po1jemtb6hGX7RQMLj4II3H/wPAWmBgL2iydsvb9PNf7ENklBBjaNFg2sf3U3vzNn/aoD3g2MzRHQMBW/JHch6q5gQI7aKtfEtZbRxM6lnn1So+w56y1MRKxx6uxv29I3dkaHBQrl6aFx01PastGP5TkrjlqUApJufSkKG/fpNPoXV3RgXdDXsmUO5xAkx/PIjskjd3om1982wUvU7b/PckNGNGsB3ZZhOKpZvdbwERxQfXpBFUHVWlSM+y8Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ThTAcuoim/HMbTbrZr4b4Sj+8zV2IAcat/brLY62q8=;
 b=TWiadC2PQzAW3UuSjQD+KTNyZqXHWCCpEKIwggtgy8miosRfk4GfRN+z5GRYzqFGUJDKuKRqOD2wwWKP5vUsJkxuqqhVD/bUDrVx20nicI4qUjQhrTtRPcbalSHWMVhDKAFU26UcKew5vVak9UA3F5+3xmBtnrMcHes9g/adqge9j06nvPfF/eIMKTjvBj2mfie0trr5bO/ak7dFAForgbid4XUhmC7wpdI/WNuBrz2WKsCbrpwOSfCrbCqhnwQam8IMjIVg46xG6TO1HixsElM1BC+8sg+KBPLY9xPP4RnbVvl7DbOl1xEHOkmV7Og3OBpxFAo4A06GuUtVDAbh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ThTAcuoim/HMbTbrZr4b4Sj+8zV2IAcat/brLY62q8=;
 b=rEW44F8FRVzGSUKsqKumdxGtIDCHB4FkCmZbcjxRPnoMk5Za8nrSD7qrtTLKEz8JGmTKWHLgPFH+0VlyYB6a7iyZkSImbAd7Qk04SsB76bsl02cO9Z4S0seyVxy772xdzriW4RCG6vkOFWUSzNVXTEwdtX2TMeNIYBFp2CfjYWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 09:12:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:12:42 +0000
Message-ID: <18d5e791-b35f-4bc8-bb36-78ba2aa14f0e@amd.com>
Date: Tue, 6 May 2025 11:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu: add user queue reset source
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e041ca-b05b-4c22-58b3-08dd8c7e27c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHRwaTJEOTl2enBvWnNIdlNtR0gwcnJrNUY2N0MyQlZyNWg4M2dWZVlXbXpK?=
 =?utf-8?B?cklWdllOQVF6dGduN3hvY2VGY2dhS3NvVk9DZ0c4N2JjbkpEZDlIdnJ4M0Ey?=
 =?utf-8?B?REUySWl5NjhiMlEzM08vY1VnL2pVNTNMZUJuRVZQdllWajZXY2xpbE9EQ0Q1?=
 =?utf-8?B?UFZuTVVRcXJNZ1dyem54VzhjK0U5YUdPWE53WVlhYUpKOGhOditnZGl4ZnRQ?=
 =?utf-8?B?bEtobTBIU2hxSHdLZ0pHdEJ5cnVkeXQ3K05acVVpS1BuamxyT2lCcytCSktL?=
 =?utf-8?B?Q0E0RGNsS0YwMDZMQ0lYYk1qbi9WWTBDSTBCemhWM1hmZ1FGcTRESktDblUr?=
 =?utf-8?B?MHZLYnJKTUt2YTdTMDJ5R3VoK2NrR2xjYmtzb0NRbXBEcGNsTGdlc1ppQlgw?=
 =?utf-8?B?dE55TVkrbmtCSFNOdFQxcnpreFhtemZ0WWdpcVdyVXJ3VGFldG51WHBzUlNL?=
 =?utf-8?B?QjR4ajJtVE1hU21peHN6UWtxUy9talZRaDRMZWdPU2g4TXU2ZUpOQWhMQzlB?=
 =?utf-8?B?N01GbThSY2VaRjhVNVpoVEl1dGZjWGc5WUV0MHp4UXE3Y1g4d01oZ3F2V3dK?=
 =?utf-8?B?OW9adXZiZWJ1MnY0OEVPMFBiVFVBTFI5SGREVnZGM2tKT1JTa1pnSmdCNmgr?=
 =?utf-8?B?TUhNdmJuSTFpRDFYUURPSGdnS0VvYVJHRUZQangvOHNJL0ZYb3gvTU1Ca2E1?=
 =?utf-8?B?TU5zazRVNG5KNjhZZ0xrMzg3WVh6WW00VUdvdUJ0eGVBbW94cjJIa01uQjhE?=
 =?utf-8?B?ZkN5dHlEck1LZC9EQitwd3ZqakhyVGROZTVsTTFuVGphci9QUGplUkVpUk1D?=
 =?utf-8?B?SXNwemJuNnRjMVhncU5qL051cVJlRzhaQkFMY1lqWk9jVk1ML25hdStZd0Jo?=
 =?utf-8?B?U2xJTnIxcHFqMExBenM2VzRQME5SL1BKMlVyR0YrcW5BQVVWSHVsbmxhajFr?=
 =?utf-8?B?UnlvZ1NHeW1JN0FpdlE2M2VjWTBlN2ZHdDdTSnFQeVo2aWluSWpXQmlFbERW?=
 =?utf-8?B?TWZZRUZmQ09NRS9FdlF4QWhyN0lmdGQ3NjVXdjZPb3NhT3BMejgvdUVhU0Fm?=
 =?utf-8?B?ZWIwdHVCcFpoNUlOMzRBbUlYMGtpZklzb2xXV3BOTkkxV0V1QjdOVWRLbmJD?=
 =?utf-8?B?a3Z3c0xia2lIK0g4YStpWEQvZzIyZmVHMEd0dFFyZ090NE9DZ1ZFR1dyWkFQ?=
 =?utf-8?B?YW9YczF4ZG1jUWxnaHpJUk5IQTE4TThrbG1TeTcyS0hReWhieVdXelh4Y1Fj?=
 =?utf-8?B?b3d5b0dMVkpEVWk3YkkzSVR3c0xpZ2dIZ1RqNk1PYTlESWgyZnpHM3g1aDMr?=
 =?utf-8?B?NVdxa2t2KzFnSlorWURlTFBEN0lMbzByWGhTR1llOXRhcVJ5c1NvZ3lMM2gv?=
 =?utf-8?B?UGNRVVUyZW1Dd1lKVFRVcVVHOUNucjlDRzZ6V0h6Y3MrbHB0Z1pGMWpYZjhz?=
 =?utf-8?B?VHE4b25oVEdOeU1nR3V4THU3ZjdKcXlaRHJ1dXk2LzZPNUErblJ5Q3dMVk5S?=
 =?utf-8?B?bVBLTGdpZ1lMbFdZUCt6VTMvNzQ1aTdPN1ZFU2FhQTA4UG5aMm5pOTRicGxt?=
 =?utf-8?B?VTI1OFIzSEIyNk9kUWlrd2l3YWp6Wkx6eVM4Q0VVZVYweTNHZ2VmeksxVmNz?=
 =?utf-8?B?QkxVKzZXSTM1WXd0NzF5aENiZllnem1tY1hyOU9YOVNCSnk4OE0vQ0Z3Wmxj?=
 =?utf-8?B?aGw5ZUZCemRuYzFJaStqZFY5SGVYYVY0dHFWa3NMRDNYaUxzTUZwYisyUStU?=
 =?utf-8?B?Ym1LNG5vY21jdXI2ZzZvRUxtYllNRzFyN0xWcndtVFo4QmxYMUhUVDhyV3lp?=
 =?utf-8?B?cHJQR2l6SmsyeXJsMnF0WUppR01INTJaUFkrNWRVRUl4amQzdDdLZC9ITmxk?=
 =?utf-8?B?SDgyelk2dlIzcWdVamNDbHZxWjIzYzNXcFZNZkJPaHUwNml3OXdmSGN6dnM4?=
 =?utf-8?Q?MW/7GrWcj+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJqZEI3SXU2L3Zqa1k4ZVFGQ2c3bmxnRkZGdjZUaVN3dTF1cGg0N2ZzSHZq?=
 =?utf-8?B?ZUxDclVyMGlpalphbTllSVNCUWdCZ3l2LzZiYXNSREdUcmxWNFFvOXJVYk8w?=
 =?utf-8?B?aHlXRTh6UUxyVjdhYWY3UDBpRWJXNjR3Ny9sb1lvMlpJdHllR00zaVRBRzJ3?=
 =?utf-8?B?UHJ4cDZBcWR2UE50Z0FmTVE0M040TW1yY2taM05QWk1SNTBwUDFEUVFEam9l?=
 =?utf-8?B?aVZCWkxyei9RWktnTUlJSnQycFQyZVk2V0xOOE5ZSnZSL1VYYUdyMTh2TE83?=
 =?utf-8?B?aHl1WDl4NGpQUW82QUFoNHRwck96OTZxK0hQSkd3MEU1Z0E4R3dlTnhERGE2?=
 =?utf-8?B?SWVkSDZMcnZVdk8xRjFZSElsVjJMNTFpS2R4MkxtSFkvQW94bTAzLzl3d3BD?=
 =?utf-8?B?Y1RLWWlHc3BLVGUyQjM1SXp6MURQVXBsaDcvYzluK2p4dUxBR2d2NjRMQnk5?=
 =?utf-8?B?MWdPRmtVdVk2T3Iyby9nVUswRkFMT0VPOStLZXRYMTI0U0k5MDZNVTQrb0to?=
 =?utf-8?B?ZHhzcld3VzlsUGd1UDkwcjhKcUtPaS9GM2gxc1BZaEhwQmJiVEtKdVUwR1hG?=
 =?utf-8?B?anErc0ZMWkFOT2lpRE1NK0dSQldBWlkzMm5aWHI1a0gxc1I0d1FIVVpELzhV?=
 =?utf-8?B?anVMQ3FHSGtnS1l2NTBiazYxTHY1ZXdZaitoZU5WaHhtaE9MeU1VR2N5RzN2?=
 =?utf-8?B?NFkvbDJWMFUvWXJEbHpsS20xRkpUL0s1bzlpOW9sYVVEWDJScEZudTZZcE9S?=
 =?utf-8?B?c05HaTh2eUZKdnZiZ0pwM2laRVBYMTNtdWt0ODlEWU5ud1UwcDdJbVduSlRn?=
 =?utf-8?B?ckE3OG1uV0FHSElSYktEOW1HU1c1dmFvR1dqTUp0djlrNHgrbnVwcUVRVzE5?=
 =?utf-8?B?UlpjN3dvTWlRWXFLWlFRTHNEUUVpSmduUUhDKytSY1dRL2tVNDNlSFdGUXlr?=
 =?utf-8?B?aCtWbVR2QVNjbHo3T1JHVElMcEVyV1VzVjl6T3Blb2ppRUZza0JLaFN0RFk0?=
 =?utf-8?B?YWtSTkpXWDdPYThEMHBCT3BBem9LWVVoSWk0RitxTGd0NWE3bHZjdlNhVHhZ?=
 =?utf-8?B?VlExbjhqVEtWbDhFeEp3aWtCTDZLT21pdW5TVThQMG5LL2Z1NGU4UFVmK2pw?=
 =?utf-8?B?cFExYjQveitJOXJLY0xpcEFickxTSVdIeUdUOUxuMlk2SjN4Mk52SkZPcld4?=
 =?utf-8?B?VnNNWURlc256cmhFQ2h1ZDd3MWlGVVpRNG1hWEZLczhWV1F6OENvMDVtNFVM?=
 =?utf-8?B?SnNlQWJ5NjJiMTZpQ1VzdzVkbHFyZm4rTlJFRFhOVlQ4cUN4dTVYQ1AwM3ZV?=
 =?utf-8?B?WW1rMTBEajJiek9EdWs0enNlUjMzZGY3TEkxYXVZcmh2dGJvQi9TRjNuVXF4?=
 =?utf-8?B?dll4R1VaeU9TcVFOTmRZV0NESXFNOVFZZWlDZ2ZmNW1EanlDekZPdFBBWEJi?=
 =?utf-8?B?enlrbldBb3FMZTQ3b0Y5NFk3SkxJaGwrbDVKOTRYK3BNWVFucElSVXRnUDla?=
 =?utf-8?B?YllON0RabWcydlVSS25leHFaTzNhMVVXSm84aWgzQStHbTlHY2x6d3NrTW1j?=
 =?utf-8?B?SkYwZXhBOTRFeTBRZm1yUmdYUGh6OTFEem5HZHpsN1NES1dlQzlIVkNxc0Rk?=
 =?utf-8?B?TVpPQzExd0NOUFRWOHJDQVFHSVBGQnhiZmV6YSs3UVk4U05YYzB5N0JtUW8r?=
 =?utf-8?B?VVluQy8zVExqRE9vaGdUaXRsU09FRTlwcnJkV1pmYUxNSG9CM2xIMkVKL2xF?=
 =?utf-8?B?WGxsUU5oazc3cUpsb3NTcnRxWkZyQkF1NnRpVWlJQlZSTUM1eEFqVDN6UUgy?=
 =?utf-8?B?YWRVaFhUSXRKTHBFUHVubG9XeTVZVnk2QVFjY056SWNUNHplakUzRXljUUJq?=
 =?utf-8?B?MnhKbkl1U21QcDQ1SnBaWWhBTm1HamRzR3JNK3k3OHRSb0szQlU2bUQzZS9a?=
 =?utf-8?B?UGRRYzVYaHRvczJQOE1INUZ0SkhMV2lPejlHS2RiRGd2N2lodWRRalFKUFBl?=
 =?utf-8?B?S2MwZ2w5Ymd2TW92UU1WTWFsbXZhdzNpdWUraWRaMkJyTWY2OFplZkNQaTRD?=
 =?utf-8?B?bUZQYnhmVm42M211ekVLQ2M2enAzMWVzUWRrZkpHTndQUVhta2ptMlVmUzRM?=
 =?utf-8?Q?XwAZbIXd1mvnmPOfayhq/YvpU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e041ca-b05b-4c22-58b3-08dd8c7e27c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:12:42.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLYWFb8JGFhNOVaEVdaYjrJhBn4YH4TUGNPbHU83lyEjSRFVcFeQZap+k23X6o4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

On 4/30/25 17:48, Alex Deucher wrote:
> Track resets from user queues.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index dabfbdf6f1ce6..28c4ad62f50e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
>  	case AMDGPU_RESET_SRC_USER:
>  		strscpy(buf, "user trigger", len);
>  		break;
> +	case AMDGPU_RESET_SRC_USERQ:
> +		strscpy(buf, "user queue trigger", len);
> +		break;
>  	default:
>  		strscpy(buf, "unknown", len);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139be..ebcea44dd7437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_MES,
>  	AMDGPU_RESET_SRC_HWS,
>  	AMDGPU_RESET_SRC_USER,
> +	AMDGPU_RESET_SRC_USERQ,
>  };
>  
>  struct amdgpu_reset_context {

