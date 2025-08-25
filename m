Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429ACCA0FE8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B8610E4E2;
	Mon, 25 Aug 2025 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HYrOJBF7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFD410E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0SsGEc5KlJQyzxBw5NuhYrfnNIzmJxccvMkJm52tL2mEcJi7GG2OMq6OnjiNfpjZvEPKTuFLJnhydnUplHr1IYBjfb+smK6mHs/ZFsqeYzwAOwPeof2SF2zLYKIx3mgC20i3ttNFcGBWsYUIPaytfaV7dk6NpXKfyWXbKPjqwuulkqFdJ9cFbA43QZZPdDc1WKPlafPESVwCEfcjKN3XvZTUMJ/CayNu7EXRRoO8UrQKNKduH/IfipNM1QHKYIU3Jc7jIH4H9CaajgHz+go4S4yDbl7E6T9WlMA7AZB08ngGJpp+EIwXRJfxT/R2IqmRvd0umLdhnSko7Karhaerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OqQdFGRH/sv0uzvzs++eMEGos6fryKOl1TK6OH8QYw=;
 b=tbS3602JSehhmdokVBIzLKd7LdtgqaRGZF2D9ByqJv1AGufw8QSKDG+JagSReaxBH2gyNsDXIM6PN8TFmrkclAJc8iPhH8Lqt4RFmgcBkkIAQCo2rRA1tGcUMprUaYdRwbSjFIu4TNk3Y0sFZ4V6BstKBEEjwV+4Av0V5xxYWWlP4utloaxhYK9MPkLwHp96OcP6LaCDWnOsezk7l+PacjQCQQEybYATXLqr2bds+QSnioM5ymWTex6caEllHdnBBT3wOu36+LEMH3Ze3CB2xOTBdgJOHuBd0bhLlhtwWN538QcjnAUf+A2gUNRUQS1+Qa3cCluv9CcfTiQmEeeJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OqQdFGRH/sv0uzvzs++eMEGos6fryKOl1TK6OH8QYw=;
 b=HYrOJBF7Igo1SWucVdxMDOnSq8vpWEqbhZ1dHOzUuYB43qs3ybNGemo89Kv/fcy7xjhV2Dn06ATBsnT6FplAY16fWft1enQurWU/2j5xybpzTVfXmZv12dlKpqx7OGWeSxFkT5Cop3SZ58kjkz+Wc5vr5dQnsWLIFUtuue4WsR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 25 Aug
 2025 14:58:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:58:01 +0000
Message-ID: <c5dbe328-7c5b-4f5b-be94-ee8f46fbd1c7@amd.com>
Date: Mon, 25 Aug 2025 16:57:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] drm/amdgpu: add MMIO-remap singleton BO for HDP
 flush
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:208:e8::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: df9048e4-ef5f-4124-9f0d-08dde3e7c9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZQeTNzVE80ZndvYWd4dWxBbjVxYnBQeWVpaHp5SzVKeUwxNnRYYVpkcjV2?=
 =?utf-8?B?QnhpVzBhM2JsN3NQR0hlWGdVeHRsTmoxM0lhekxubUVKTnFJa2M1Z29ybWJX?=
 =?utf-8?B?Lzc5RWRUaTBRWDAxbGpDdGFrSXJHK1lyVCtjQ2R1VENBbHZWaWV3dFpsK3BD?=
 =?utf-8?B?dkVUV1NXV28waXhuMW5UOEs3SHZ4N3QvWXlDcnorUGxqWmV3eHNIb1Ewend5?=
 =?utf-8?B?c3Z3UFpoVEZpMDlXYlBoQ3RHaEJVM2NsVHB3czdZMExwYldDR0thT1JtZWd0?=
 =?utf-8?B?S0hwK1lUVjFmcVlpQlYxZlJrSldsREVWbExxbkpyZ01KbER6SGhPbGlzcTZE?=
 =?utf-8?B?MzlnWkc1aGp4YUJ4QlkyQW1NUUc2OW1iU3FpUTFiMkMyQmd3OURkMkFjYkVh?=
 =?utf-8?B?TlFxc1VNU3ovaXFoUnlxMzMvSG1UcUlBbzFPeElVcHg3dGZpb0hSRlRzemZI?=
 =?utf-8?B?QlZsK1NxN2IxSWRzYnhoczJVbVREVmwxeDc2VFVuOVBEcDQrSVFycjM1T3lm?=
 =?utf-8?B?NEEzaXpwNE1iV21mK3p1SHhhNGdQUnRtU1BQaWxJZGVEVHVkbE1XN1EzMEg5?=
 =?utf-8?B?ZlNwMkdUWXhBeFdEM1JLaldFRVdWWFlXa2NsYno0eUVNQy9vV01hczBEQkpK?=
 =?utf-8?B?SXNQbjdyQ1F2M2xmN2tOb1NiTlE0bFJnSXpoNXRnZHNBaXg0NmdqS21MWjdE?=
 =?utf-8?B?L3hOZTFpOFFiMTE5UUYrT3F2OUxLUGtCcFVuTWFrU1VSQ2xmQzNkQ3lSZkJp?=
 =?utf-8?B?QzViRm5iUFN3YU5VYWhPNGxDYkNBTTVWUTFlYVVOZnVsdU12UXFOc1NabWZj?=
 =?utf-8?B?MFJTZzVzQkR6cDZCRWVFV0thS1NpTFVwSURwNWlxb3c3MG90U2FLN3Y4LzU0?=
 =?utf-8?B?V0o5QU5PZG54QmNCYVNQZnRFbE9COEl1UGFLbDVYTUZrb25xOTZteWRCWDJu?=
 =?utf-8?B?N1VxbnFkWHU5V3dLUk9WQWM0WGJRZytLZnkyM0JqV2FINC81ZmhORzRZWHhu?=
 =?utf-8?B?a0NTMmhmZGxCTlhuWHUvMDMrWUtwcWFmUXpBZ0xXNFFlZ3JXRlppVy9rdG0z?=
 =?utf-8?B?TU1kTHJwUTBMMnVFNUxpeFVRVTF0RFNLSkhLRy96V1BidWhyZDFkWXZGNXIx?=
 =?utf-8?B?djVHQ3F6MnBvSzJ5OHNDdXJYOENEYVR4ZGtTRlg3TUo1bEw3YjJYckxFbXdk?=
 =?utf-8?B?aFd1NDJqY1ptUW0zR0FEWDZEUFBwYmFBOUNkTmY0VGNWWmQ0ZjNQQklWd1dX?=
 =?utf-8?B?MStOL0NzZCtId1pUNW15aS9hbnl2ZW9DK2R6ZjlVallRaDg5ajhKeUhnOGVZ?=
 =?utf-8?B?WDlTNjlzUG1wZWllcmQrUDdYVGJxK21kQ3RIcUlFWnZwUUNiODRlWlJBVHdT?=
 =?utf-8?B?L3h4L3pHK05jT0JpM0FQS2VaL0pWWDB2dktJMWtXSTBCdjRuamRqSDl5RVNm?=
 =?utf-8?B?cUlQTUdYZTZRdzFKVEJOREUydTlhNVFRKzRoQXlNUlR2R0psVm1qd2RWdGF2?=
 =?utf-8?B?WXRHRmNnWGtWTUtLc2VIQXFQOWVUMW1qMXNUakgvREI4a0VncHhUVHFoUXNy?=
 =?utf-8?B?NmlCZlFicGIzdWNqam5INWpmWFNPTWdZa2c0T01lOHh5eUwvaldXVlNOR09o?=
 =?utf-8?B?WEdFNDF4RW9HSnhWMVRWS3FKQlU3WWtHdkJEM2YzWVIzNWg5ZXhlc0lkMVRB?=
 =?utf-8?B?RHViZC9yTUxWNDRDUUNRRnp2Z3lYbVRDNmhOQ3JqcEZpa0c1ZXpNb2ZUSWJl?=
 =?utf-8?B?WGkwUXRLbXE3eWg5bWZ0czJkajg0aXRCTTRycnRrNUlNelhCdVRJcXNCSDdJ?=
 =?utf-8?B?aUhCL2F6UnBYUnErTVZUeEZva2tDSXR1QzRhWFlGMGNwdWlxeTZKczQ5WVdP?=
 =?utf-8?B?MUU4WWFJWEhYcnlzbllYNEQvZHdHVFUrN3N1RXhOT1E3enF2TDUvWGczcW9V?=
 =?utf-8?Q?8+y79XVCglk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxKeHNUdDdYR2orOFZpdldjWFp1MzZEWGhKZ3hqYld5aTVBM0tvcWxIbjNo?=
 =?utf-8?B?dXQrRnpSdWgxdEtkcHRvZjd5eEZtWDNSK0JLSnFxUDRTVHM5RXlMRGZBSE9s?=
 =?utf-8?B?TjFOd2VpeVZVdFMwQkVUdzFmYXFUTzdnVGhRM2FUQkVmbmgvQ1QwaWpRY3I4?=
 =?utf-8?B?SEpzZnJoYWFNRXdBVTMyM2FsdnEwOStJem1WUEJvZUJOU1dKWXFBSDJ0cjBV?=
 =?utf-8?B?d3NXVi8rSTd2Z1krNEdSUGtQeW8zcFlHTExUZkFqQmczaXVQNTRra3JVKzhh?=
 =?utf-8?B?V0wyMVFhQmNTQmtyS0t1UnNoeEFsUHk0YWNiOUxXM3BkOXo5aGw2V1RHeHov?=
 =?utf-8?B?NEVnaDdWR2RHeXU4eHFzOWhGQlVIdmVrZklPYmNVQUtrNWRYRXdQbFFvS09u?=
 =?utf-8?B?NzJMOUE3ejJ0c294S1Y4dWJQSkpubmtTQnpoNEV5dU1UR0FsdkJmQUZ5TTNo?=
 =?utf-8?B?YWJ0dFYzM1BTY3oxcW9SWldiMk1kMktSdS9jdVVSWFBwOW5QRXlWU1h2eHZF?=
 =?utf-8?B?R2NjNDBwNitlQnh3NXZQTndTS2N6a3hSaUlZTUFURWJscVJnazdPZVROOU5J?=
 =?utf-8?B?c3dRZDJFKzIyTnJTSDk0ek1KSHA3S2IwU0xNR05uWnlYd2diZFB5Tnl1VFJ0?=
 =?utf-8?B?RmNHMXhxeG1TZS9ObWFLM3dMWkQ3T240b3JCVGFSK3V2K2swYkFLMW9KeXV5?=
 =?utf-8?B?dzZJVnJFcDlnV2YrelZDVThNaklRNUZ1M1FGUXBWMFBWQmtCMEQ3cHJtZW1H?=
 =?utf-8?B?UVFOb3ppNEhZZ0FsTHgyZEhZZ3JQckltbmtXL3NaOFpIcUZQMGFUbEJrTW8r?=
 =?utf-8?B?TjIvNEFrYWFaL05MUzFYSWRoUzAvbFpFczBOY3lwODVvbmlkZFpZaTNHcFJS?=
 =?utf-8?B?blpqUXc3VzVORVpENUlKcHg5WGZXVXNrN3QyeUNMRXJWaVFzUmhndkZXRUdD?=
 =?utf-8?B?aGMxZk1GQ2d6aEJIUkFBQ21XOG95YUlpcXV5Zkg3WWhWNW96S0hoY0RuUDUz?=
 =?utf-8?B?aHlhT24raEluaUlvTzRub3R5MnMrY3Yrck1hbHF0TEc5cFk3TVF2Q0UwS0Nh?=
 =?utf-8?B?RFBZQkZueHoyVE50Y1VXMVZIdmozajl4dWNpU3grVFZqcUtzVEpLcVR2Zi91?=
 =?utf-8?B?OTFkSGVWRzF5aE00dVc1eEhZRTZDQURUNnA1Ly9Tc09NekJ3Ym1DUjgyTzZD?=
 =?utf-8?B?cEF4dFpCV2V5L3JpRkV2YkFpbXBteGFsSkFRTGwraUtSaEFKWWovRURlNHhE?=
 =?utf-8?B?UmNseGliREtNNUYwTUZVckJ0YnptL1BGQnBIU0dmK0xvWUN6NWJIZ3FRM0Mr?=
 =?utf-8?B?ZE9WMXpweWc1Z2N0S210TS9pRkVFNGFUSmhmVE9qRnZCZElwMTBJSFZEUCtx?=
 =?utf-8?B?QnQrVm9YZXVpNTdSd0FMd1UyN1ErOVlyaVkrbmlWTVNENkgzNS85aTdTUms4?=
 =?utf-8?B?Um1jN2lLYlQ0eDJ3WlZVWUtkWEhUZlBPNzVQWEtNL1dYbHB1T0pzTng2NWxa?=
 =?utf-8?B?U1FHWE1Mekw0YlcrSVhyK1dCd3BPRzM0SFhOWjdXaXpMc29xa1lKVHlyaEhL?=
 =?utf-8?B?WWtQYlM4ejh1aVNpVHpGOHhEMGFEU29XcXhtZ3MzTEU2eG5QSHNSN3YxYXJw?=
 =?utf-8?B?a0FhRDVqSGVsMkhKN1gwcjhQSnFpcTdFMm1URTE2TkdWcFlpVHptbUo1QTNB?=
 =?utf-8?B?cjZtdThza2dkV2pmRkdHNTZUbmhKbmxBVVc1dHNHZjRPZGw1TDltaGJDQktB?=
 =?utf-8?B?dTduY3NqM2lNelNIRGlsWVpXUjJJMEZuMUVzWGdldFZURjBhLy9jUGRua05L?=
 =?utf-8?B?bG9kKzNiQlR3MExJWkF5RG52SGxLTU5Ya1J5bTk0SDBVVS9tNHl0OUhoNmx4?=
 =?utf-8?B?ODZhL01Qb2ZDRFFsVGQ3ZnlxTkR2empjdlVrdTQzdDA1Zzc4QnpmR2dRcjJw?=
 =?utf-8?B?VXhJMnI5My9VaVczUTRnbXdMcTcwUGs4TkRlYmVLQzhYNlFDNEdjZDl3cWxy?=
 =?utf-8?B?bVZJazRuL0J5WnBGUWk3WmNneC9aTGhzc0tlTEtiU0kxN20vYldBZ1lFUlJn?=
 =?utf-8?B?WG9CYytmd056VHhYUHBNeWVxV2NTWEtvRCtZWW11U21MTTdVelh1TlR3ZjFB?=
 =?utf-8?Q?/hSuFcWuRj3+1/2faZcs+57dR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9048e4-ef5f-4124-9f0d-08dde3e7c9a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:58:01.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fjk3/cfhvR1vfh4q0DBnFeJ2vNxFRG3erxp0SKCSC+X/rL+WBzZB2D90id5JZCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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

On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> This series introduces a kernel-managed singleton BO representing the
> MMIO-remap (HDP flush) page and exposes it to userspace through a new
> GEM domain.
> 
> Design ------
> - A tiny (1-page) TTM bucket is introduced for AMDGPU_PL_MMIO_REMAP
>   (mirroring doorbells).
> - A singleton BO is created during amdgpu_ttm_init() and freed at
>   fini().
> - The BO is kernel-owned and never evicted.
> - amdgpu_gem_create_ioctl() recognizes the new GEM domain bit
>   (AMDGPU_GEM_DOMAIN_MMIO_REMAP) and returns a handle to the pre-created
> singleton BO, enforcing size/alignment checks.
> - Userspace thus gets a stable GEM handle and can mmap it to issue HDP
>   flushes.
> 
> * Only compilation tested so far (x86_64, defconfig + amdgpu enabled).
> * No runtime validation yet.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Patch #1, #3 Reviewed-by: Christian König <christian.koenig@amd.com>

The rest needs some more work.

Regards,
Christian.

> Srinivasan Shanmugam (7):
>   drm/amdgpu/uapi: add AMDGPU_GEM_DOMAIN_MMIO_REMAP
>   drm/amdgpu: Add New TTM Placement - AMDGPU_PL_MMIO_REMAP and wire up
>     plumbing
>   drm/amdgpu: Plumbing for MMIO_REMAP memtype and user-visible strings
>   drm/amdgpu: Add mmio_remap fields to amdgpu_device
>   drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
>   drm/amdgpu: Create Singleton MMIO_REMAP BO and Initialize its pool
>   drm/amdgpu: Return Handle to MMIO_REMAP Singleton for GEM Create
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  56 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  13 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 112 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   3 +-
>  include/drm/ttm/ttm_resource.h                |   2 +-
>  include/uapi/drm/amdgpu_drm.h                 |   8 +-
>  10 files changed, 198 insertions(+), 8 deletions(-)
> 

