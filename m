Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8ECC02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAA410EAB9;
	Fri,  7 Feb 2025 10:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2thawCI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A9F10EAB7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5FJ/A9V/STgERER/pj6T1gAfVvN0q836cYz05iN335VLEWlqHU47rCpy+77gTkEjBhzD3lDFym0GYHbgqykW2TLH14Lg6VNlNf4h/90MtpOT+xRyIfS3B5YL21+MHG6Yb8xtbXXWn3Hf/bFjwc7MwNE88hj28kTltNfL6ktQDxzu01YrIA+k2P708pt7mmi7Al6mIOR+4156aweNKcHrOHXZa5XQPs4x+gbD6utmZgYAWJBhlF/ughNE/A7jCNN14sQFpQgiGXyJmA/z8J+9+Yi5WKi6BWIMMIXEPoGkPB0zxtm1EZFYYYSAA1g3bgXZN/h5sjC117vHO9xIAfmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddsovz2xPMVrRKeoqGIV1CPr9egQwZosO9h6hdWH+08=;
 b=VcHgV/zF32eYKEJak3a+22l5NMkA3CT80uziNJaaQHBs3LFyZWZ7M/A016gcHg0Klc1kuax5e7DUHacPNO+ZV/PRf6mbi2fN9/YHk87xCBBIk1CG9FHjgjXT9llS67ZaTO/UUEtXcY8r373k2abv/XfXO1qfUjYFS/UsU5ise+k6InsJqLiIADkP9cbE/lcfIQVVrkiWb1tXTBy4A4HiAFLFb1bJefEHWofEuN8BH0984cR2Ys/9BqXcL5mCF1lwGUciHkd643m0ftuHMReIJOBELt0h6/TkRO+cod1eETm+NGJSAT08HBPwgPT2AeKHaNJjoTUheAkre+/A5Dzn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddsovz2xPMVrRKeoqGIV1CPr9egQwZosO9h6hdWH+08=;
 b=c2thawCIKRDLZ9AWF/O2M2yyLLz00TJNMkE6leIfJQnvhkGXygLySjjTcjuuIsMwMFnwnWYp1al1wjR8jUNSwD7QIXGAqtXiKIkIpmFFUW0ZOYiQIVYFhB25kJ5rJrrN/3xCm7obGiNB1a2OhGsTZtLPz6H0Y7dgrLXzR8TbclM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 10:50:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 10:50:57 +0000
Message-ID: <62d4ff4e-e07b-4c46-845c-27e9ac25f38e@amd.com>
Date: Fri, 7 Feb 2025 16:20:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/4] drm/amdgpu: enhance error handling of psp_sw_init()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1738909308.git.gerry@linux.alibaba.com>
 <c09fde05278ef6d8344194247ec536347ceb583f.1738909308.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c09fde05278ef6d8344194247ec536347ceb583f.1738909308.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 582b3f66-0fe9-4e1f-d833-08dd47654d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEJic1NyZno3aStCK0ZLam9pMnU1WDlEbHBsU1IvZTR1bmhkZEk2VG5TNkNW?=
 =?utf-8?B?c2VQNlZ0RzFpOFVTOFNHcTBROHFsa0NtYVVTNUxWL21tM01Qd0k0WkI0K1Rp?=
 =?utf-8?B?SDFoanNiY1RrVzNmT0VFUVAvNFp1WE0xdlZSR0tFRzhIZDNYRVp6dmNXOFo0?=
 =?utf-8?B?aytoQ1h6N0tQZGpSdnVxZXBpdG4vaGppSnhvWll0V1RjaDIvblA4ZUh3QmFT?=
 =?utf-8?B?bThWOEMwS1QvRkp3N0trUzdrcGV1aEY2TjVOSDNTNGhtQ0NDY0tHV1Z4S0VG?=
 =?utf-8?B?MWM5UGxMK3hVQnV0M0NrN3QzbnlyMjVxTUY5V1lyN0MxWSt1MnJxWG5VMDFQ?=
 =?utf-8?B?UzZqbTJYVWJHTjVTb2FyNjZ4OHgxUUMzNWplakFNU0VFbXJmVEp2dFBFamFV?=
 =?utf-8?B?ZExwS3RnQndCU0NBSjlyUVRQZ0J5Y3BNdUJjMUQ2dnE3L1dURUhicmh3bXNq?=
 =?utf-8?B?a3VTQlRkMlVRN0dNcityOGNhNEVqOSs4T3kyd1N0c1VaYXYyYzhtbGh4MCtm?=
 =?utf-8?B?czRDZGlMMll0bHBPcU9PcFZQYk4zR3I3OUlMekZVdzdaUk03Z0xxOGNqNWhF?=
 =?utf-8?B?T25ORHFTM08xOGVJNklOTWVEWHBqYjErZHE5a2hya1h2MnRJVTlyWmxWMmkx?=
 =?utf-8?B?MnY3VTdwelYzT0hBUnhKUTZ2cTNjOERFVEJKK0xJNzRDUTJXSGpHbTZkRFQw?=
 =?utf-8?B?c0RnSW02emtXallRVVVJd0l3ZGRSV2JUWWF4WDlId3R1cjFsY0hvKzBnTjlU?=
 =?utf-8?B?bmtFQWNNL3dOdDBqNEZVZVVvUXM5UllWZjNaTVBwUlVFTUxHT1Jwc3dhem1V?=
 =?utf-8?B?S0U2YUk5OXUvSVpQUnluVUc3WURRZkQvWFdyRnFEa1Arcmd4RVg0QVh4YjJV?=
 =?utf-8?B?bkZwNlFRb283Z1VaZmdNdzl3c1QrOEZxQmlLSmQ2V3ZuRFVnSloxbU42UkxO?=
 =?utf-8?B?YW1yNXNoQnZoUDdaVkdjVFdDZHkwM3RGb05Rc25yNHdyZ0IvMytEWGlGL2hh?=
 =?utf-8?B?OEs4QnltMUZuMy83MHJWTXZYY3c0OFJQS1NaVlN6WG1xOXJNUVJMRGFXT2VN?=
 =?utf-8?B?cTZtaG15aGZNemdNd2Y2VHBZcGlQZ1Jsa0tEZHVOZnlseVZuVGd2ZUFnOWNm?=
 =?utf-8?B?eTVFNUNGN2g3RU5zWjg1WGczQVhXZU5HVTFsa1A2Zk02Tm1vbm12WnRtbU1q?=
 =?utf-8?B?ZFZMQWllcThITE9uY3pLL1A2dHJJK2E2ZEdxRHFIcTdGOXdlNm4yek45dGdi?=
 =?utf-8?B?MzdVbXJqSVBzbUtvRlNKT09aUkZGYU9ZckMwT0lCWjl1bkhzWllYYk5xTE5s?=
 =?utf-8?B?d2ZxMFRLcXFTaE9BNWRGd0dqU2Q0clVoWnV0TGFwbjdVWUZsc2lHc2VKa3hS?=
 =?utf-8?B?RmJyRW5Lb3pKSlVMbDlrWEZLem5XNFQyVk5taGFtdUR5SHQ5d3ZQSmpwSml0?=
 =?utf-8?B?WDNPcms1RGs1b0hHRlhibmRQTElCRS9XVjlOU29yQ0M3NUd5bHk2dWNoaE1Z?=
 =?utf-8?B?bTU1b2NXZWVmVEVnVE9BcWFPNGVheUhRUzFCMlZzazR3L2ovNGhZbW1FdHhN?=
 =?utf-8?B?YnlHMUltejNFaE9FQmRHcW1GODlnbGx4b3hZcTBtMzJjYUpkakVOWU1JK2lW?=
 =?utf-8?B?OGlZTUdUVDhSU1lTTFNRd1lCeUNiSkdlYUM0Ylh6OFV2YXV2OVpaclRrZkZJ?=
 =?utf-8?B?V3VhdklwdXE3Z01MakQya29jcThUZkZyU21QN0FlazJBU1JZNEd4cG9ZVmxy?=
 =?utf-8?B?RUdhK3RZbUJieTdiT0VCTDNWR1VXM2pDY1o2djg1VjBJNGRZQmVoSXJ6VHVR?=
 =?utf-8?B?RHN2SFNnWUJzbWFVWFhlanJRTEZteHpoL2NVblhSUnZzMUZYMnYyb2gwSHNi?=
 =?utf-8?B?cTRRVTZlTFlrUFFaT2lMNkF2WGdDS1BSeVV3Zk9FbG9qZFhZUHlwWm9uOTEv?=
 =?utf-8?Q?oBeOf5cUZOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y204MGJ6OTEwUkw0UFc3MFBhTjl2WHhaS3lpRXFETWtHZDl2dHkvWmpLQUVp?=
 =?utf-8?B?TU1OWTVPeFIwRy9Ka0owTUpkTFJUMXhlaTd4N29GQjFCLzhNVm9WbS8vTkRi?=
 =?utf-8?B?QVQ3R0dqNHVwcjBGcWcxNm9ndEdyVDBSQ1pvMXd6eHh4alJKQTA4UktnV3Qw?=
 =?utf-8?B?TGNaKzRYYXhLUlBIU1hYVUloUlN5VHQzN281emJRRkh3d1BabjJnb2VXenh3?=
 =?utf-8?B?U2NYQmZieEs4NXhGYkJDSDVwRXQvenBXQXN0aURVNkVPV2JwOXJRVmxPQytu?=
 =?utf-8?B?M2ljNWo0bm80VS8wQkJlRjk4QkZ1NTcveGozYjdCNE1sM3FEWEhwSm9vczBQ?=
 =?utf-8?B?SXRtVytsNnEvU0lidHlmUlJqb1BOTlZjV3dPZGR6Vms0N3NaVEhRRkhWTEFS?=
 =?utf-8?B?Rk1GejJzekdJZStaU21ZUk1wa0c5U3NBcmJoSDNNNnRFT2FSTUZjNlpUOHJz?=
 =?utf-8?B?TjJranNJb2d6OWtMdlUxQ2MrUjgwdFIwWTNQMkpabnhyUG82TkFxS1h4MWJi?=
 =?utf-8?B?b3dnanEreFZFbWFIcy9EK05udUR5Y0Y0bkVtQmwwVFJzOXBZZU1UOXdOK1Rt?=
 =?utf-8?B?YWQ5ckFTSUExWHBzK3FHakIra01Oak4xRTN5YTVGMmhHeml3S29ISml1Rnp2?=
 =?utf-8?B?RFo2WmZVR1cvdGx4UzkxOGphbjk5cjhnQk9rNmJZbmc0aUVoT0tTOTVLWCsr?=
 =?utf-8?B?UXlUeFdyQTJmMC9mNG5NcWhsWUhFSHUwTXp0MWwwN2lDM1lCUHRiWHNRbWFZ?=
 =?utf-8?B?aXN3ZEs5U2xkZFNMQjhsUW5kbUdTazZDNHowSnArbTNNSVRRY05HcGlLY2tZ?=
 =?utf-8?B?T1ZqUHBYRzNNaGdQeFNxM3RDMW1GZU9KUEhUdThTT290bHlSOXBYUDBPTFd2?=
 =?utf-8?B?eWZWN3RvVHhwWjRuVWFUNjlBU1IxZ3VoT2R0OEQ4UDJvVTQ1SjJzZDArQ2xo?=
 =?utf-8?B?b25RcDNHUm1yMUU1bEZSUzIwTU1veWpEZENsaXMwSDhUNGFuUnhkODNNRFZT?=
 =?utf-8?B?NjVrR2lCaWRBeS9KZlQ2RG5aaUR3WVE1TlBMY1lFY2JSNGZsaFhJVlVPRGVS?=
 =?utf-8?B?U0hlRHh1Z3pWNVo2bnJEYW11bkw4bUtVWDNtK1puMlY4cE9BOGRwdkpkYW1j?=
 =?utf-8?B?VTlvRlN1ZzhoeVkyVkR5d2ErTjNPbHdzZ0NlQ1ZNcldhS2FSZnZKRmFKbC94?=
 =?utf-8?B?UVNIdmp3UHZ5K3d4THArSlZMbHBaZldHclQ3aDJnbzVTeGhhVkx5S0tZYTln?=
 =?utf-8?B?SzBxYnpwQWVnSHZaRHo4enpKcHlLdkxCc2t3N0Rab0JnNjVIVlBaK05zODUw?=
 =?utf-8?B?SmMvU0xHK0w5OVprSFdZQ2lDRWFaN3BkS3c3d1V1bysySGhZZmYxeTg2c1pK?=
 =?utf-8?B?Nkp6SHdUelJNVlpjRGp0SGgvT25HN01wek53M1RvS0JSMGRodnNaR0dQMGY4?=
 =?utf-8?B?a0VCeFV0RUpQNXpvK1l1b2huZlRDZkw3Q2t6WS9aNEk0Q0d6d2VWQ29DSElO?=
 =?utf-8?B?SDRJVU1CUUlmc2p1R0VrNkJqWHJwMkZYRUlUbDFRdndUMnhiaU0zWEZuZjBV?=
 =?utf-8?B?QWthWHVRUWJLSG5JdldPcmt1czR4a2h1V2V6d1hxeitrZmYxSGZzWU5xbisw?=
 =?utf-8?B?L0NUOWlVajdaSGtyYkRLQmc4RHh6cmQ1S2NpSmFmRmp1SzlYOUErTDJYWTho?=
 =?utf-8?B?WXhqdzNPbkJNeTlpYjA0a2FENFpPUStYT0Y5LzBiK0tWOVBEOE1OMkFPQXJC?=
 =?utf-8?B?aWQwQXBVcFQxSS92Q2pDQ1hjZlkvNm1qd3FmSGhSL0t4QmoxNlZmQ2orbXNw?=
 =?utf-8?B?OTFWQWhiNG9tM3BBOTBDQWc2L09JOTgrSFpIaDI3VlpDY3AwaGxRdm5PSGZr?=
 =?utf-8?B?cE1ZUHBwZGFQdzRXQWlmUkpGaENjL3BhQUtzWHlkQkZob0E4Sjd4VFRWQmYx?=
 =?utf-8?B?RnNORHpEWEVILzdWQXFxMXJqZHAvNEFERzViZUJHUjk0c1E1NTFhc1NpbTNG?=
 =?utf-8?B?cVorMDNjVmM5ZXh2MGl4ZGJ3ZkJXSGo4ajFXa2xDOGowRXQ5ZG5JWGNMRmUz?=
 =?utf-8?B?Z2ZJZ05TSmhMK3ROQXZpaWt2eFppZlFOOWdPNHhSaytMYk41cyt2YXk4cG00?=
 =?utf-8?Q?XeMySGoPalz8k9yJYUobHOy6x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582b3f66-0fe9-4e1f-d833-08dd47654d6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:50:57.5944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIBIuqB4NpLNkht+oM+N9NBbMRUsIUcmwXatR/xu76x46zuk7528jQJuHslgM5MM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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
> Enhance error handling in function psp_sw_init() by:
> 1) bail out when failed to allocate memory
> 2) release allocated resource on error
> 3) introduce helper function psp_bo_init()
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 84 ++++++++++++++++---------
>  1 file changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4e9766a1d421..0d1eb7b8e59b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -423,6 +423,50 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> +static int psp_bo_init(struct amdgpu_device *adev, struct psp_context *psp)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> +				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
> +				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> +				      &psp->fw_pri_bo,
> +				      &psp->fw_pri_mc_addr,
> +				      &psp->fw_pri_buf);
> +	if (ret)
> +		goto failed1;

Better keep it as return ret, will avoid another label.

> +
> +	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
> +				      AMDGPU_GEM_DOMAIN_VRAM |
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      &psp->fence_buf_bo,
> +				      &psp->fence_buf_mc_addr,
> +				      &psp->fence_buf);
> +	if (ret)
> +		goto failed2;
> +
> +	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
> +				      AMDGPU_GEM_DOMAIN_VRAM |
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> +				      (void **)&psp->cmd_buf_mem);
> +	if (ret)
> +		goto failed3;
> +
> +	return 0;
> +
> +failed3:
> +	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> +			      &psp->fence_buf_mc_addr, &psp->fence_buf);
> +	psp->fence_buf_bo = NULL;

This NULL assignment is not required, same below as well.

> +failed2:
> +	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> +			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> +	psp->fw_pri_bo = NULL;
> +failed1:
> +	return ret;
> +}
> +
>  static int psp_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -435,7 +479,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
>  	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
>  	if (!psp->cmd) {
>  		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
> -		ret = -ENOMEM;
> +		return -ENOMEM;
>  	}
>  
>  	adev->psp.xgmi_context.supports_extended_data =
> @@ -482,50 +526,27 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
>  		ret = psp_memory_training_init(psp);
>  		if (ret) {
>  			dev_err(adev->dev, "Failed to initialize memory training!\n");
> -			return ret;
> +			goto failed1;
>  		}
>  
>  		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
>  		if (ret) {
>  			dev_err(adev->dev, "Failed to process memory training!\n");
> -			return ret;
> +			goto failed2;
>  		}
>  	}
>  
> -	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
> -				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> -				      &psp->fw_pri_bo,
> -				      &psp->fw_pri_mc_addr,
> -				      &psp->fw_pri_buf);
> -	if (ret)
> -		return ret;
> -
> -	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM |
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &psp->fence_buf_bo,
> -				      &psp->fence_buf_mc_addr,
> -				      &psp->fence_buf);
> -	if (ret)
> -		goto failed1;
> -
> -	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM |
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> -				      (void **)&psp->cmd_buf_mem);
> +	ret = psp_bo_init(adev, psp);
>  	if (ret)
>  		goto failed2;
>  
>  	return 0;
>  
>  failed2:
> -	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> -			      &psp->fence_buf_mc_addr, &psp->fence_buf);
> +	psp_memory_training_fini(psp);
>  failed1:
> -	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> -			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> +	kfree(psp->cmd);
> +	psp->cmd = NULL;
>  	return ret;
>  }
>  
> @@ -554,10 +575,13 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
>  			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> +	psp->fw_pri_bo = NULL;
>  	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
>  			      &psp->fence_buf_mc_addr, &psp->fence_buf);
> +	psp->fence_buf_bo = NULL;
>  	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
>  			      (void **)&psp->cmd_buf_mem);
> +	psp->cmd_buf_bo = NULL;

This is already taken care by amdgpu_bo_free_kernel

Thanks,
Lijo

>  
>  	return 0;
>  }

