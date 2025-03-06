Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE21C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 11:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A448510E941;
	Thu,  6 Mar 2025 11:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDfazEc2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E16810E941
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 11:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBOsbVRYGhdblzZA11qJdwBf11aHo11amyPUKNtBV7ARUuqjna1Q4GcNysVk3Tm+RSLR6zt0iyGVLgIjauVh+ZnEeWQ+0omVdZyQfYHbB4iNpRLood4FLI14ZWe6XqfNMc0j6I0/sl69WSKnnTkt/2ELFEb1BplMy12tBhqeK3d4BbqZjvGkCwO+pz5PaVh5vcohFwNEf7lQpATI/saztInPgIfdoDRwKOx+dDr2bab0XRbsSa0xtENe+raRSOgwXKjWVyrwujhqFnT5boFIz0w2zcNkz3LIrx7YSV1pCd3v8QWGRNP2b37TeWgW75TzdplG7p6sxbbxf3pfsUyiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDiHlStv6zD5W/TstqQybU/eHupee1w5nhotbp6oYW0=;
 b=mYMkgy7HYMVrzdJjx3lLwnWCvW9jRVfJJLu4SvORPjvD43ek0p1xPgFKo9EK2SKG98cBDYPCU/t4yk1nrsCk2wQtL5x8msKTlhsc3OLk2s/gzNZT02tlnvI2/m+TPl6dhmuohSEF4yhyE+a8aYrdvOzyChw3ia9JY44KWXZlEpV4YlFTTECXDyjvM7fItIske/WJoH8Dl2FHbAoscDH5HL2Zaov/ZIHjv9qrjHqksfrXStv4P3VtF6ugM3TBv3L1BFJWj4MgDvDZuCkiU7L9s6fZkeZZsusebgTkKxwjFZUtAobxcy4ZXCV9mMsdFhsg3cI2SLAzX7MDHRVkFfqUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDiHlStv6zD5W/TstqQybU/eHupee1w5nhotbp6oYW0=;
 b=dDfazEc2wEuDJBwvKHykNVptb7WRZeN9lyYanFu7cKqcW5YUk0KMvYzZrf2jpP3K55oUwy7InA+ACo0e8X87gPalz/olIjHMZYEACT4YzMRSCfp7c2Qq+EgzbnBQJ+nZPnO/pgQdXbKHETtlMzLtFIvG4Ns9XJEG0RxC0kSuQbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 11:20:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 11:20:06 +0000
Message-ID: <8b7a002d-ebc0-43fb-850d-c98ba79bca2f@amd.com>
Date: Thu, 6 Mar 2025 16:50:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-12-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-12-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afa2b30-a161-4e06-e284-08dd5ca0d8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1aVWJ0R09xenI3SUVxaXRmRnFrUXRGa3VOZXFHZjViQm1xaG95d2dCcHZW?=
 =?utf-8?B?Z1NKZDFYZDVrZ01tazV4TjFnQ1EremJ0TjhQcVJwdG1EZGoyNzgzQUIycHd3?=
 =?utf-8?B?Y0hpRC9mK1ozK0NiSTJIMTRubjI3MTFDTDE0Ti9PTjRtTVRWMXZHTFhmOUt5?=
 =?utf-8?B?MWVHTWdtR0h4NCtGcDcrYnJoNzdSamNvam1kMmhYTDNOTGFFRWdFeHhuWmdZ?=
 =?utf-8?B?bmpCd29lay9IUGxSckoyM0Fnbld3ZmZzQkJQS1RySVV1dDMzS3ZLSmlGblpa?=
 =?utf-8?B?eFBVUFdYUzVpU1hvMUZqQWMwNS9DZDJ4WTQ5T1BPUTBzYWtCa0U1QUkxbFBv?=
 =?utf-8?B?dStFK3RpVkdkWkdzUzM0YUdwSHJiR3JLQ2E2aE1kUXdCNFZLc2JLNXFocXpS?=
 =?utf-8?B?dUlnQ2JUTmgvcE5ZWHE5NFA4Y2N2WnJEa294QVFueGt0OGFqTWlTU3YzcVpB?=
 =?utf-8?B?V3VSSmgvaDZ2TE9FYjJEazcrT2N0R25HVHVHOUhma2pidG00N3VFQ2VHSWdZ?=
 =?utf-8?B?S2UrTUJoYmdtTHhaMXRsOWpuc0tJcms2QVl2a0JIWXlxYk1RazEzSG80Y3RU?=
 =?utf-8?B?dmZOYU9zZnphdFE3SytPaVhKb0EvaVFnWFAxMHNEYTV6Z2UrbEtXeWdsTXdS?=
 =?utf-8?B?RkIrRTF6L2lTd0tIYWNkMVlib3VzelRoajdzdHNCN09YUy9HbnphdDNzOW1a?=
 =?utf-8?B?THRhR2pPelJMVTR4WTRzWERhZjRDT2xqNmc4N3JjNG1ucDRWWkczNmdZWHYz?=
 =?utf-8?B?czQ4cERUc0JtdkpoUGxlbjNDbndjdEQ4SWQ1K1BlcElaRU80MjV3enJZMU1q?=
 =?utf-8?B?Wjdib0ZIdUp6L2FHU3dzSWZMZTZXYkVTRzlwdEZpVW1CNDZOSU5Pc1JIR3Mx?=
 =?utf-8?B?WitFOGZ0MHRseG9sMGNNZGtJbXpGcVZMV2s2UUt1VUJKVWlrc3JRNGd2R2Ux?=
 =?utf-8?B?elpUZVVEYjZ4MHF5bzZRTXV5N0Zsa25EWVBtK1RDRzZaTVRaM3BuQjVtU2ps?=
 =?utf-8?B?NFBiNnBwVzZWTjZNQXI2dFJKRU1ZVCtMV3MrdytPNzFBdXBHWG5wbnNPUmRZ?=
 =?utf-8?B?bGJXQWhDU2RpNGY5dmx0dlVQcUw4dzhEQUZReHdGdGg5dmVwYWpaaDNReEZr?=
 =?utf-8?B?Ym9RN2hFTVkvNXJ4Z2FhNGFHL0hyaXRTT0VjVmFaR0w0UzhYVmdsZVA4QS9N?=
 =?utf-8?B?M09xYU9NekxWMXV4aW80QVU4eXd6MUVTMUFhVWVKM2JzRlNOY3orb2NSVW1m?=
 =?utf-8?B?SFd1K1hkOUcwUisyVWtwZUdFNXpBbU9BWWJvRXRSMHdVOTBIeWFKd3ludVgr?=
 =?utf-8?B?Mkx6VjE2NklrczA0bkhzWXFEZmdUeVYvZVM3NmU2K1k0U3kyMjU4VWdINjNY?=
 =?utf-8?B?UUlES3dqN2NKSUFkQ29OQmxaYndyZ2NucjVqZXRUbjRmUGVyMDFrbHBzVDdC?=
 =?utf-8?B?OEc2WkVHOWNXVkQxdDFHNWRZZEJmZWVDbmJhWTNlUnFCbWpCNGk0ZU5NTEtD?=
 =?utf-8?B?WnIwcmovTWMrTzJEMW5BMmJxOXNTTXdHOFhZQmtzVXlkVlhCKzNrTFNWOTlR?=
 =?utf-8?B?NGV3Q3Bod2dNMmJYb3FIdlRhVnVZV3hMVkQyUE5RU2RQSk5tUmlyQzVsRlZC?=
 =?utf-8?B?S0JnZDI5dXRXSmxBZDFmalNpTFJwalVZZ2ZUSlZtUUtmTzdicTAwNjk4WXk1?=
 =?utf-8?B?NHE5SlhGL0VQdmxod3Q2ZkNtQlZjaUt4VFJYR0FoOFZYelVLV1RldGtyb2ls?=
 =?utf-8?B?V1pDRC9TTjZtcGRQdmJ6RkNrZnkxSTdJSmJhamxOREpKZnk5TmkyQnBRVVBV?=
 =?utf-8?B?cDZaWVg2Uk1SLzE1d0hhVStxeTB5ak13ZTRMTnhIVVRjOU5ja1hGNEsxTmoy?=
 =?utf-8?Q?V+pYMoDTVNOxF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUx1VlFYSTdsbGpBMDJ4MG80OWhKOXh3K0dML0V6QkJXSStVc0tjdlR1QXRL?=
 =?utf-8?B?MHdITDJoMFArRlRaK2w1dFVGTGNpenJ3ZTJpNXg4N203WDQ0M21MUjd3Snp5?=
 =?utf-8?B?bWo3WUJuajJ4RDMzdStiR081Yy9IV09lWE5td2RnMldxZ0Y5c1o3RzZ2STU3?=
 =?utf-8?B?amROUTBIN1JNUktGRktTeXFscWtiYVhWbndoWnU0OXFZcFR3T1NSVFBHNVZt?=
 =?utf-8?B?dGgyUlNpUlJBcHpsd1FaRi9ZSUtvdktQbFQwOXhIVkNWV3plYUNwWFFVR3hj?=
 =?utf-8?B?dFVsb21KQXp0ZjRMSnRHU2hZSDdENE5KbFNJNjFnL0RZUllscnBYQTNYNWNx?=
 =?utf-8?B?WnBoU0RDME5DcFd5dk5rSlZxKzhxR09PSlZPd1JBdzJ6YzVvWXNUeG54aDdz?=
 =?utf-8?B?WTcrMEhCb3B2MU40cG84NytMVkFSUEltOUVjZENnUmtkdUpSQ1pRRXhjQlBV?=
 =?utf-8?B?NWFnWUdiMVpwZjFBam0rN3NhYjlvWnBHY2VzeVJWRTBlT0gyTjFWY0NPa1VN?=
 =?utf-8?B?Q3UrTWl0Z3VHUFYvZE5YNElaaUJSOUpSYzNFMVh3RmV1OFFKRHkySzhWbmpu?=
 =?utf-8?B?TWdQcEhMdFRIL2F0cytiaDlaNENRcXJ2RjhXaXlBMmp3Vm5qQklRdDd5Mzdv?=
 =?utf-8?B?cG14S0JEQld6R0R2ZDNqTnZNRDYzTnRGeWpoL0hIdnhGZWZsbXQrdkFSWE1Q?=
 =?utf-8?B?MUdkdWJsdnd0aG8xQzZQZ0pINGx6NGJxaUZrN0dqcWtaK1pUOHFDZU55WC9l?=
 =?utf-8?B?NSsranZPOHJ6ZzRGeU9lSGwrMk1NL2k5eWNkem1oRXVMbFFPdlU1WmNOa0ZT?=
 =?utf-8?B?Q3NSOGhuRE4rSC9XdmhiR0ppUmcrRUdYRnBCdURqSnhhOEh1TmJOSCtUdjM2?=
 =?utf-8?B?S2tQYWpNeDc3ZGZFUVV5Y2MxNEx0Q0p1RVFsUEtrVUM3Q0pReFVmeEl0eTEv?=
 =?utf-8?B?UmptUnV6OVVCNElpU2tuaUZURGFiRm1yQzB3V2g0Q3RYTGFqWHJLL1FSK2Nv?=
 =?utf-8?B?VTUrdnp6SG1xa0xIakprZmhPNjFleGJtTHZEVTZDUFFLZ1hJRk9LYmVlK2RP?=
 =?utf-8?B?Vm42QWZNS1BjeDBibmZSL3AySWpvWWZkeis2U2FoTVlqRUl5TjQvaC9SeFR5?=
 =?utf-8?B?TmdDcUdLRDF3QWRnZTRBSmYvWkpYKzl3SjhDVWIyUlpGcU40VWNtVURYN3Uy?=
 =?utf-8?B?a1V5eGN3aU1IRTQzY2pvVzVpZUVzaUIyaUM1VVRXMUJuRkJ4cGtzVU5ZK04v?=
 =?utf-8?B?ay9WNGpQS1RpQStsOTNjOHkxaU1PUmd1empXUklicG9EeVpiaWQ3bi9TMDBp?=
 =?utf-8?B?NGxQUGw5dHlobGRxaTZXS0tCdHZKMkRUWmU0bGIwZFBDajNaV2xlZDV3MFhP?=
 =?utf-8?B?elhxQ1ZWbTFzNUdrODR4eFY4Yk5PZ3pRNHpkblBNU0k1MVVzRjF3OEFsMmpM?=
 =?utf-8?B?MGkwNXNnbnA0dGJFZTlHdDZlU2xvaElaTm83WEhiRXpDN0haQVFjMHNRbm9t?=
 =?utf-8?B?TGhEL2Z2WUREeklqVE9icy9wNEwxeWZhdTlFb0gxK2o5OWVXOW9kWGtldmcr?=
 =?utf-8?B?d3ZRcTVOemQrUUlLSXowZVo5WUU3NnFmZUc5QnZlT0NFYy9qTjBPTVBrUHBC?=
 =?utf-8?B?aU1SVjE3SkZ4dlFrSWNlbDYxZUVqaGhFWnlDMERjZml6OVAwL25ZY1FEOWpL?=
 =?utf-8?B?czhQVGMvMGE4OFlSRDMxWU9wczAvbUtMQlk2Q09vUEZwQWhqL04wNUdsbTRG?=
 =?utf-8?B?R3ZuclNPT2UxSVBDanZtb2F6dUZCTElEVi9RcFhqTnRJMXZvM3NTMWFHeTB5?=
 =?utf-8?B?d3RTczg5MlkwdEFBZU12eU9EdTVKVmUvWU5pV2U1dUFXTytMRDA3a241Mk5P?=
 =?utf-8?B?aXk4aVJYeGFWeVpmK1BqOEt3YmFJSjhyUDhRc3RNd0w5aEJNbzRHRGlNMFBM?=
 =?utf-8?B?YlovYlUybTIxQklHcXA5SERoeGNUekxvNU4vRDJFOFp0aGRjV3BBc3lmQWJT?=
 =?utf-8?B?RmE2QUdkeTh2SHVSVWxhYmtKQnJIQzZZTzl2ZDNEcmF6c3M1OTVqMFh1YTJ5?=
 =?utf-8?B?bUtXaStnc2d1OUZnSmJRSWEyK3lWWmQyRFo1U3k3TGJBV3F0UG8zd3g2MHlL?=
 =?utf-8?Q?cYqi+nuQmW9b2rJxK/rMsHykh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afa2b30-a161-4e06-e284-08dd5ca0d8fc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:20:06.4395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oU1PcKUvddtsYjOzZ/AsTVKxCy22bo+VJtplq17IkbUMATOuZ23e9y3/qaD22EvgM2C2SbyEp7oPDjlESC0UYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> When the parameter is set, disable user submissions
> to kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 92a79296708ae..40d45f738c0a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->sdma.no_user_submission = true;
> +
>   	r = amdgpu_sdma_init_microcode(adev, 0, true);
>   	if (r) {
>   		DRM_ERROR("Failed to init sdma firmware!\n");
> @@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		ring->ring_obj = NULL;
>   		ring->use_doorbell = true;
>   		ring->me = i;
> +		ring->no_user_submission = adev->sdma.no_user_submission;
>   
>   		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
>   				ring->use_doorbell?"true":"false");
