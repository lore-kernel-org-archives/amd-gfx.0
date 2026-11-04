Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33A6070B17
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IKqzbv/Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CE810E5C3;
	Wed,  4 Nov 2026 17:57:44 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC98710E5C3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 17:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhB+m5CmabrQ4nz0STVEE4TXSsD/g0TXHpdo9nYKTbCRW8wx4cXIvj+keXyouJdz1VkjQX5Ji0Nl5vSoKm+ET1Y/Zjy9iPdTvtakiX0Svg4YZAOcv/xCjjfJzavCcp4KFKTr8qJK3FqY1JNUr0OxJ0mo59gbqHVkH1vxhpjkviu7j12j5xfNWR7m/gdZpNpGavBUv74yF8AXnrfRmLPULnNITt3WKGAogT+3wWN9d3fo+3ezx2phB98gLVNP0bO/WyApFhMzlYYW5brDREyz8n+vrCcL0l8DHOTnTtZTE7lokmjzH8ZSCioso3bZI+u3lxs4A5l6GWcOW4yN6780aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/muHFaff8eTy51zoYj9+LZPYdGZiUnOn2uespUC9Jc=;
 b=iPqEJGZs09G87FvnqtHs2FaLLdcR3D7kVAL2xWTRSI/689uwfGk+gIl0WKW+N9614A7o6ywgzhAtmKTrenvjB1zVLplhnBlAMG074b3zLCs7s5wFLzbxvVUqPayNbEX9hgDpuGe2ELSZa4NRh6C0ugTTOCDAhHeqbG2Dp/rBuGMe/xqGDOcB2qr1Ys7hZdUNMXf26yvxdQAmQBO339WRK7jy/V3JIAJt9jF7Dtw7CbIFXWD5xBVzdKzTIG7W+c8LDVI+BKHtDOETJ1im0bUSOcgqQ8xdORaOTgG4a7peRsWK8QqrvZH5ERB4AHXkUwlMvS9w+rE/6YI8EoUlBlTiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/muHFaff8eTy51zoYj9+LZPYdGZiUnOn2uespUC9Jc=;
 b=IKqzbv/ZTChHw+pKrZfn2MigaW+7GvU/+GBD4xMWujNpUV0ymIumirr9HaAMK4VNEZxa0ALp3NXRU03mfE/k2VwQS9XqdOxsLSOO3PhBXZjIIa7MOdXbWW8PzRIjjKUkdmw8ZYQou/KQfHE5Oy4J0dJqxtJSz2ZmUE7HonFUdmw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:57:32 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:57:32 +0000
Content-Type: multipart/alternative;
 boundary="------------zW0lcRTPwVd1N5lj9vvRAxkH"
Message-ID: <add0b216-7697-47ea-80aa-5216334292e0@amd.com>
Date: Wed, 4 Nov 2026 12:57:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
To: Apurv Mishra <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Bing.Ma@amd.com, Benjamin.Welton@amd.com,
 James.Zhu@amd.com, Jason.Tang@amd.com
References: <20261103023145.61021-1-Apurv.Mishra@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20261103023145.61021-1-Apurv.Mishra@amd.com>
X-ClientProxiedBy: YT4PR01CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::23) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: c60c981c-e15d-4330-4db2-08df3a9d1974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022115727099003|261009223027099003|261021123027099003|11063799006|261022105027099003|5023799004|56012099006|261028144727099003|261021121427099003|261022075727099003|261026121527099003|261026140227099003|261102123227099003|10067099003|3023799007|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: nib7++jjSNlaJHv6ILiudi3LAegGAlyl3jVd6ne1brrt+mPQQ8/uTLffSWZTebItiNG+F6lAbu2+8mFjqMw22eVe07ymy7nNR2w8UQceLj1B7Qxjp4whsjB42xhfisPVspl0ECM/5PlgaJie6RnOf+YBb7c13ynsTD6qGtW62gpPKuvardGwKXit3M27QoWhaFry62EiYDZ/f5cy7sN2gGDZqRYCSWwcrWe72WVl2m/FqeF/+/KQ01J6CYtBheo09O4sfFO22kHzEY25ulqIlrCKzy5p2l7yVmDprbnBpZejXRqn2FG4pfdmTgYm+pjI0RF9YJV4OUFfwH/ET3nKtKxmZdrl6nmkIFWex/BcmU4FIi/MiMnUcpJA2a2KDDKY9mueB97bSAG/OK3rLSbw8vd2ZxwBPjdOimtBvG2tzGVlwtHCHHXTF5jwNTRYZDx/0F3AvhuA8+sQWnK6LicFJm/xKstsDNA6mY9IwDTRomCwOMEtYIlhNHZGhMVQms9QaljirmqSic+7VdkwON7Odo09ANGv9MC6hgAIHdf9bCn9ZPzsR/9QBmbsWBXD8s1L6SQPhCGTs+W7mHBCqlQL7e11RbiympJABUSbLvaWM34mGiVQJw/oRpCBOktOsJmP3NISUEbOvp0zx8+6z1H4LXO3uqbJOjNkzGuk3+30Dzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022115727099003)(261009223027099003)(261021123027099003)(11063799006)(261022105027099003)(5023799004)(56012099006)(261028144727099003)(261021121427099003)(261022075727099003)(261026121527099003)(261026140227099003)(261102123227099003)(10067099003)(3023799007)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2U4T3crc3ZOY3lMeXN0ZUJoTEdPQXd1MG9xdGU1dXFkMG9sTi9lTjIwQnNX?=
 =?utf-8?B?b1VGRWQ3ais1d2ptSDVmWTB4ZytwU2pSVzlEaS9YcHg4bGplODFWSlJERW9F?=
 =?utf-8?B?SWFnblpCeG9TTVNhUXppdXpPRVlUcUwxdTJManBiRnlkcDhLb3ArTlVHNjlX?=
 =?utf-8?B?MGFqM3dnOTBhQklFVmNteUo3MldIRCtNT25ZR2VqdW1zUXZmWFpiN1hlU2Q2?=
 =?utf-8?B?d3ZqT3NKa1JJVndOTlZ0VUdBWXdsYlo1Zmcvd1VMd3ZJTmdiOEF6L1ExejIx?=
 =?utf-8?B?eGdsODVXUWpRcTZ3K2J1WVlPRllpN1BUNUlkMDFaVHpEMTJtVUlKbFIwaTZE?=
 =?utf-8?B?V2Z4RkhVRjNFQ2g0RTROQUxUTFFQZ3g1K2dvUEpqTERhNXRBaG1OZm5YNE9m?=
 =?utf-8?B?MTgxZFNOU2UyamN4NlNFN3BzYWo2ejQyeUhZNEVKaWpPT2RPQ0FCUG1IYlA3?=
 =?utf-8?B?WlNWZEI2QVNSeDdneHYyU2xKZjBzN2gyc0g1L3JHeXpER1ZWc1JCblJuVWJu?=
 =?utf-8?B?aDJxTmM5dXZKZWd0enpobnc1eFZWcmJvY1lNeGJBelJ1Y09jTWlveFlEN0xU?=
 =?utf-8?B?enB5V1JwV2JXUXVOallyaW1IVlFGT3J2c3hIN3dDcFhvOUVnTlA0MW00YlJH?=
 =?utf-8?B?UWRlblJoMVNsS0F1NlBXZlg1TU44VDZEMVJtODRyV1QyRkIyL2ltOXNRU1FD?=
 =?utf-8?B?VlROR3I2Q2xxRUMvQ0l6ZHJaRERWclhrVSt0WWFGajQ0VXM1Z2FLc1RtbmZk?=
 =?utf-8?B?Q1dxOW9FR2FlTFhadlhuMENSR3U2eWFVdno3VFZhdG5pckIxMEJ1dTUxbDR2?=
 =?utf-8?B?SktvalBMYVl3cFpIb1gzNHcreE1xYWdpTjQvRmdYZ3dwYkZicW9jcG9ONTNx?=
 =?utf-8?B?bFVLOWNMTzl5L3hKVDRydXFUSlc2K2JUKzROUHR4TW0yaGQ5VlB0WXBNdU9F?=
 =?utf-8?B?dUFUK1QwK29zby9QYzh5NC9yS3NEK1ZXUDBRb2p1TlFXZitxSW5IbFhmNVFk?=
 =?utf-8?B?cENVVDVjZ3ErdXcrQzUrNGRtdEhlcTdCV3dob1dHbitEeUdOS2ZQZFdHSTlK?=
 =?utf-8?B?MWJIU2kvRmpHaysxRUxqY1h4V2hvQkJDZ2NvZmlSMUlrNUVRTGQ1VHIwT1Yr?=
 =?utf-8?B?RitleTBXZWFJSEc3cXpkeVhUMXQvaCtXZHhPTzVwVWlOOWc1aXViby9Qc0JD?=
 =?utf-8?B?T0xMSjZoNENxS0tsWGY3YmhDYTFCNG5rQUtPZEVFbGxtZml3TTAzUEVsY2FB?=
 =?utf-8?B?Q1JFVmp5a0JNSHdMdHlmb3BkZDRiS1FhVFp4alpJSGVWY3VITUsxQmtvbzZN?=
 =?utf-8?B?RUd2cjkvNjBGb2hvSUVLMFRPVEt2OHg1dmRBdzVvRTJEbU5TQWw5WnNlVDJH?=
 =?utf-8?B?ZkRvQnVxMmV5R1FSZzdKblRLcWhhK0krQXhRdnlHd3IyYzZTTmE5b3lCMVdV?=
 =?utf-8?B?Y3RDQzg3ZkZlUzdTTGJ4YTJmZHR1TFlOeThqcjJLK3h5b0Q0Zm1ySkZMLzlp?=
 =?utf-8?B?bVJZODRkSnRMOWZVMEhNZUFKaUtFVlRnL2c5NDdJbnp6M0RyN0pwWms5aHVL?=
 =?utf-8?B?LzJXN0hkdEplUThqM1lGYU10aURqRFg4MTFCZ1hDTlAxMnJITW84QmdZTjk4?=
 =?utf-8?B?LzN0OXpvdktEQjFaajlITnV4alUyOW5Xc0R5WjlYRGI4SURpZTBtTXFTTWZw?=
 =?utf-8?B?bDFSL2JNTk0rR0xFVzZBQThMYVBTOGJ6K1FQaW44ZVFaejBLK3lCbWlwZ2cv?=
 =?utf-8?B?bzh6MlVWSUZVL1p0dWN6Y0FFZlpRYmZiQnYyYTdQaUYvTTJpaEJCdThEbFpX?=
 =?utf-8?B?LzU1M0VKTWMxanJjMWw2Ri9VVXJ2c1I3dktXNktDeFNMelpHTDFrRVhQdHNC?=
 =?utf-8?B?d3B3alBURDVJKzRwaUhVYWF5UFVEVXJvUHBmUjh4YmlQbm4wd1k1MHRuSXhu?=
 =?utf-8?B?NEFIa1lJYyt0c1RzKytYYk9DUGJTS0xFVGhIRmVVY1M1RG9BUmlSRjNBRlBX?=
 =?utf-8?B?d0xJMFlCbFdFOEVZT3NlazMzVnBTSElrSTJEYjF6eUE1eUovTFFjYzdZWFZI?=
 =?utf-8?B?Tnl4YW9MVk9rS2tDU1pRdFJFY0xyTHh1eWlGQlp0U3NPaFN1Mjlxb1VQb00v?=
 =?utf-8?B?NmpwWkNJdjQzM29PV2x2NUZqNzR5QmNxclcxN0RRTy93NHgvRGx2anpVdUlr?=
 =?utf-8?B?MkRUSGtNS3FhUWxjdmMwN09RcDF5Um0ySTJYcUtIRmZxSmp1N1JVM0ZnR1hQ?=
 =?utf-8?B?Z1hCbUxxZEduWklmQ2JLQUV3N3JySGpXanpGWEI5c1pUZVZ6UlpKZ3A5VlVW?=
 =?utf-8?Q?KywS+nEbjbn3UFz4cu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60c981c-e15d-4330-4db2-08df3a9d1974
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:57:32.4629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd1qFJNranbWPXROpQZAIXBr4OuCmNxxk5scd/lBY/kmyKvkpsiTCsYK07BFx4Z0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------zW0lcRTPwVd1N5lj9vvRAxkH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-02 21:31, Apurv Mishra wrote:
> Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
> RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
> workaround (STABLE_STD) needs root and pins clocks.
>
> Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
> perfmon clock on per XCC, keeps GFXOFF disallowed while held, and
> restores the previous state on last release, resume and reset.
> perfmon_clk_mutex serializes it with the GFX clock gating sequences
> and the soc21/soc24 stable pstate hook.
>
> Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU
> and under reset_domain->sem:
> - lock=1 (device mode, CAP_PERFMON): held until unlock or exit.
> - lock=0, perfcount_enable=1 (dispatch mode): no CAP_PERFMON needed,
>    held until lock=0, perfcount_enable=0 or process exit.
>
> No DPM change, no new ioctl, no struct change. Bump
> KFD_IOC_PROFILER_VERSION_NUM to 2.
>
> v2:
> - Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle
> - Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold
>    perfmon_clk_mutex across the GFX clock gating sequences
> - Bind the process to the GPU before forcing the perfmon clock on
> - Take reset_domain->sem before profiler_lock
> - Release a dispatch-mode hold with lock=0, perfcount_enable=0
>
> Signed-off-by: Apurv Mishra<Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 89 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++--
>   drivers/gpu/drm/amd/amdgpu/soc21.c         |  2 +
>   drivers/gpu/drm/amd/amdgpu/soc24.c         |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 63 +++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 20 +++++
>   include/uapi/linux/kfd_ioctl.h             | 11 ++-
>   12 files changed, 261 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 44091ac12fa9..04422c1e1f86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +	amdgpu_gfx_perfmon_clk_restore(adev);
>   
>   	amdgpu_device_fill_reset_magic(adev);
>   
> @@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->srbm_mutex);
>   	mutex_init(&adev->gfx.pipe_reserve_mutex);
>   	mutex_init(&adev->gfx.gfx_off_mutex);
> +	mutex_init(&adev->gfx.perfmon_clk_mutex);
>   	mutex_init(&adev->gfx.partition_mutex);
>   	mutex_init(&adev->grbm_idx_mutex);
>   	mutex_init(&adev->mn_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a6f95ff47d24..c9c4c3d4e88d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
>   	amdgpu_gfx_do_off_ctrl(adev, enable, true);
>   }
>   
> +/*
> + * Force the perfmon clock on, or restore the saved state; @save records the old
> + * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.
> + */
> +static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
> +					   bool force_on, bool save)
> +{
> +	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> [JZ] Nit: lockdep_assert_held(&adev->gfx.perfmon_clk_mutex) here, as amdgpu_gfx_perfmon_clk_update() does.
> With this update,

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

> +	for (i = 0; i < num_xcc; i++) {
> +		bool on = force_on || test_bit(i, &adev->gfx.perfmon_clk_restore_mask);
> +		bool in_safe_mode = adev->gfx.rlc.in_safe_mode[i];
> +		bool was_on;
> +
> +		if (!in_safe_mode)
> +			amdgpu_gfx_rlc_enter_safe_mode(adev, i);
> +		was_on = adev->gfx.funcs->set_perfmon_clk_override(adev, i, on);
> +		if (!in_safe_mode)
> +			amdgpu_gfx_rlc_exit_safe_mode(adev, i);
> +
> +		if (save)
> +			assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, was_on);
> +	}
> +}
> +
> +/*
> + * Refcounted override that keeps the perfmon clock on for profilers. The last
> + * put restores the previous state. Each hold keeps GFXOFF disallowed, as a
> + * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it.
> + *
> + * GFXOFF control takes pm.mutex, which clock gating holds around
> + * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.
> + */
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable)
> +{
> +	int r = 0;
> +
> +	if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->set_perfmon_clk_override)
> +		return -EOPNOTSUPP;
> +
> +	if (enable)
> +		amdgpu_gfx_off_ctrl(adev, false);
> +
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +	if (enable) {
> +		if (!adev->gfx.perfmon_clk_override_count++)
> +			amdgpu_gfx_perfmon_clk_program(adev, true, true);
> +	} else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
> +		r = -EINVAL;
> +	} else if (!--adev->gfx.perfmon_clk_override_count) {
> +		amdgpu_gfx_perfmon_clk_program(adev, false, false);
> +	}
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +
> +	if (!enable && !r)
> +		amdgpu_gfx_off_ctrl(adev, true);
> +
> +	return r;
> +}
> +
> +/*
> + * Program the perfmon clock for clock gating. While overridden, only record
> + * the state for the final restore. Called with perfmon_clk_mutex held.
> + */
> +void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on)
> +{
> +	lockdep_assert_held(&adev->gfx.perfmon_clk_mutex);
> +
> +	if (adev->gfx.perfmon_clk_override_count)
> +		assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
> +	else
> +		adev->gfx.funcs->set_perfmon_clk_override(adev, xcc_id, on);
> +}
> +
> +/* Re-apply the override after resume/reset reprogrammed clock gating. */
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
> +{
> +	if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
> +		return;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +	if (adev->gfx.perfmon_clk_override_count)
> +		amdgpu_gfx_perfmon_clk_program(adev, true, false);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
>   {
>   	int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f5fb2e585e8a..1bfd12dd3956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
>   				 u32 queue, u32 vmid, u32 xcc_id);
>   	void (*init_spm_golden)(struct amdgpu_device *adev);
>   	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
> +	/* set the perfmon clock, returns its previous state */
> +	bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xcc_id,
> +					 bool on);
>   	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
>   				   struct amdgpu_gfx_shadow_info *shadow_info,
>   				   bool skip_check);
> @@ -500,6 +503,11 @@ struct amdgpu_gfx {
>   	uint32_t                        gfx_off_residency;  /* last logged residency */
>   	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
>   
> +	/* perfmon clock override for profilers */
> +	struct mutex			perfmon_clk_mutex;
> +	uint32_t			perfmon_clk_override_count;
> +	unsigned long			perfmon_clk_restore_mask; /* per XCC */
> +
>   	/* pipe reservation */
>   	struct mutex			pipe_reserve_mutex;
>   	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> @@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
>   					u8 me_id, u8 pipe_id, u8 queue_id);
>   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>   void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable);
> +void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on);
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
>   int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
>   int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
>   void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a7ed4923857b..a01244621fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   
>   static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>   {
> @@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v11_0_set_perfmon_clk_override,
>   	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>   	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
>   };
> @@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
>   	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>   
> -static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> -				      bool enable)
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> +				      bool enable)
> +{
> +	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
> +		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
>   }
>   
>   static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
> @@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>   static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   					    bool enable)
>   {
> +	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
>   	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>   
>   	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
> @@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	        gfx_v11_0_enable_gui_idle_interrupt(adev, enable);
>   
>   	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index ec1e142549c5..9e754c25b15c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   
>   static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>   					uint64_t queue_mask)
> @@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v12_0_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v12_0_set_perfmon_clk_override,
>   	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
>   	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
>   };
> @@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
>   	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>   
> -static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> -				      bool enable)
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> +				      bool enable)
> +{
> +	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
> +		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
>   }
>   
>   static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
> @@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
>   static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   					    bool enable)
>   {
> +	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
>   	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>   
>   	gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);
> @@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   		gfx_v12_0_enable_gui_idle_interrupt(adev, enable);
>   
>   	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index f812d6d81e9c..958b4ad39d9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
>   				      bool enable);
>   static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
>   					 bool enable, int xcc_id);
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on);
>   static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>   static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>   	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
> @@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v12_1_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v12_1_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
> +	.set_perfmon_clk_override = &gfx_v12_1_set_perfmon_clk_override,
>   	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
>   	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
>   };
> @@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_device *adev,
>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
>   }
>   
> -static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> -					  bool enable, int xcc_id)
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
> +					       int xcc_id, bool on)
>   {
>   	uint32_t def, data;
>   
> -	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -		return;
> -
>   	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
>   
> -	if (enable)
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> -	else
> +	if (on)
>   		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
> +	else
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
>   
>   	if (def != data)
>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> +					  bool enable, int xcc_id)
> +{
> +	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
> +		amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);
>   }
>   
>   static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
>   					     bool enable, int xcc_id)
>   {
> +	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
>   	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
>   
>   	gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id);
> @@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
>   		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_id);
>   
>   	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 599d47e1d38b..ed10c258703c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
>   static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
>   					  bool enter)
>   {
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
>   	if (enter)
>   		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>   	else
> @@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
>   
>   	if (adev->gfx.funcs->update_perfmon_mgcg)
>   		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 6c8b8ed4a44d..46d746dd37b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_device *adev)
>   static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
>   					  bool enter)
>   {
> +	mutex_lock(&adev->gfx.perfmon_clk_mutex);
>   	if (enter)
>   		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>   	else
> @@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
>   
>   	if (adev->gfx.funcs->update_perfmon_mgcg)
>   		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
> +	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7fcfc150a7fc..e4fb9f5aa3b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_process *p,
>   
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, gpu_id);
> +	/* Bind for the runtime PM reference before programming the perfmon clock */
> +	if (pdd && op == 1)
> +		pdd = kfd_bind_process_to_device(pdd->dev, p);
>   	mutex_unlock(&p->mutex);
>   
> +	if (IS_ERR(pdd))
> +		return PTR_ERR(pdd);
>   	if (!pdd || !pdd->dev || !pdd->dev->kfd)
>   		return -EINVAL;
>   
>   	kfd = pdd->dev->kfd;
>   	ptl = &pdd->dev->adev->psp.ptl;
>   
> +	/* Before profiler_lock, which reset takes in kfd_resume() */
> +	down_read(&kfd->adev->reset_domain->sem);
>   	mutex_lock(&kfd->profiler_lock);
>   	if (op == 1) {
>   		if (!kfd->profiler_process) {
>   			kfd->profiler_process = p;
> +			amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
>   			status = 0;
>   			mutex_unlock(&kfd->profiler_lock);
> +			up_read(&kfd->adev->reset_domain->sem);
>   			if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
>   				status = kfd_ptl_disable_request(pdd, p);
>   				if (status != 0)
> @@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_process *p,
>   		}
>   	} else if (op == 0 && kfd->profiler_process == p) {
>   		kfd->profiler_process = NULL;
> +		amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
>   		status = 0;
>   		mutex_unlock(&kfd->profiler_lock);
> +		up_read(&kfd->adev->reset_domain->sem);
>   
>   		if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
>   			status = kfd_ptl_disable_release(pdd, p);
> @@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_process *p,
>   		return status;
>   	}
>   	mutex_unlock(&kfd->profiler_lock);
> +	up_read(&kfd->adev->reset_domain->sem);
>   
>   	return status;
>   }
>   
> +/*
> + * Take or drop this process's dispatch-mode perfmon clock hold. Taking it again
> + * is a no-op. Dropping returns -ENOENT without a hold, and for the device lock
> + * holder, whose lock == 0 must still unlock.
> + */
> +static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
> +				    bool enable)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_dev *kfd;
> +	int r = 0;
> +
> +	mutex_lock(&p->mutex);
> +	pdd = kfd_process_device_data_by_id(p, gpu_id);
> +	/* Bind for the runtime PM reference before programming the perfmon clock */
> +	if (pdd && enable)
> +		pdd = kfd_bind_process_to_device(pdd->dev, p);
> +	mutex_unlock(&p->mutex);
> +
> +	if (IS_ERR(pdd))
> +		return PTR_ERR(pdd);
> +	if (!pdd || !pdd->dev || !pdd->dev->kfd)
> +		return -EINVAL;
> +
> +	kfd = pdd->dev->kfd;
> +
> +	/* Before profiler_lock, which reset takes in kfd_resume() */
> +	down_read(&kfd->adev->reset_domain->sem);
> +	mutex_lock(&kfd->profiler_lock);
> +	if (!enable && (!pdd->perfmon_clk_req || kfd->profiler_process == p))
> +		r = -ENOENT;
> +	else if (pdd->perfmon_clk_req != enable)
> +		r = amdgpu_gfx_perfmon_clk_override(kfd->adev, enable);
> +	if (!r)
> +		pdd->perfmon_clk_req = enable;
> +	mutex_unlock(&kfd->profiler_lock);
> +	up_read(&kfd->adev->reset_domain->sem);
> +
> +	return r;
> +}
> +
>   static inline int kfd_profiler_pmc(struct kfd_process *p,
>   				   struct kfd_ioctl_pmc_settings *args)
>   {
> @@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
>   	struct device_queue_manager *dqm;
>   	int status;
>   
> +	if (!args->lock) {
> +		/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
> +		if (args->perfcount_enable)
> +			return kfd_profiler_perfmon_clk(p, args->gpu_id, true);
> +
> +		/* Drop a dispatch-mode hold if there is one, else unlock as before */
> +		if (!kfd_profiler_perfmon_clk(p, args->gpu_id, false))
> +			return 0;
> +	}
> +
>   	/* Check if we have the correct permissions. */
>   	if (!perfmon_capable())
>   		return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d8631847f0eb..32c3c23d6d14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -886,6 +886,8 @@ struct kfd_process_device {
>   	u32 pasid;
>   	/* Indicates this process has requested PTL stay disabled */
>   	bool ptl_disable_req;
> +	/* Holds a dispatch-mode perfmon clock override until released or exit */
> +	bool perfmon_clk_req;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index dd938788bdd9..7ba1c4ab283b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
>   
>   static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
>   {
> +	struct amdgpu_device *adev = pdd->dev->adev;
> +	int puts = 0;
> +
>   	mutex_lock(&pdd->dev->kfd->profiler_lock);
>   	if (pdd->dev->kfd->profiler_process == p) {
>   		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>   		pdd->dev->kfd->profiler_process = NULL;
> +		puts++;
> +	}
> +	if (pdd->perfmon_clk_req) {
> +		pdd->perfmon_clk_req = false;
> +		puts++;
>   	}
>   	mutex_unlock(&pdd->dev->kfd->profiler_lock);
> +
> +	/*
> +	 * Nothing is held on the kfd_create_process() error path, which holds
> +	 * kfd_processes_mutex and so must not wait for a reset.
> +	 */
> +	if (!puts)
> +		return;
> +
> +	down_read(&adev->reset_domain->sem);
> +	while (puts--)
> +		amdgpu_gfx_perfmon_clk_override(adev, false);
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   static void kfd_process_destroy_pdds(struct kfd_process *p)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 749d196e2114..34f3ffaf1c66 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {
>   	};
>   };
>   
> -#define KFD_IOC_PROFILER_VERSION_NUM 1
> +/*
> + * KFD_IOC_PROFILER_VERSION_NUM history:
> + * - 1 - initial version
> + * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until the
> + *       lock is released or the process exits. lock == 0 with
> + *       perfcount_enable == 1 forces it on without CAP_PERFMON and without
> + *       locking, until lock == 0 with perfcount_enable == 0 or the process
> + *       exits
> + */
> +#define KFD_IOC_PROFILER_VERSION_NUM 2
>   enum kfd_profiler_ops {
>   	KFD_IOC_PROFILER_PMC = 0,
>   	KFD_IOC_PROFILER_VERSION = 2,
--------------zW0lcRTPwVd1N5lj9vvRAxkH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-11-02 21:31, Apurv Mishra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261103023145.61021-1-Apurv.Mishra@amd.com">
      <pre wrap="" class="moz-quote-pre">Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
workaround (STABLE_STD) needs root and pins clocks.

Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
perfmon clock on per XCC, keeps GFXOFF disallowed while held, and
restores the previous state on last release, resume and reset.
perfmon_clk_mutex serializes it with the GFX clock gating sequences
and the soc21/soc24 stable pstate hook.

Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU
and under reset_domain-&gt;sem:
- lock=1 (device mode, CAP_PERFMON): held until unlock or exit.
- lock=0, perfcount_enable=1 (dispatch mode): no CAP_PERFMON needed,
  held until lock=0, perfcount_enable=0 or process exit.

No DPM change, no new ioctl, no struct change. Bump
KFD_IOC_PROFILER_VERSION_NUM to 2.

v2:
- Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle
- Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold
  perfmon_clk_mutex across the GFX clock gating sequences
- Bind the process to the GPU before forcing the perfmon clock on
- Take reset_domain-&gt;sem before profiler_lock
- Release a dispatch-mode hold with lock=0, perfcount_enable=0

Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 89 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/soc24.c         |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 63 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 20 +++++
 include/uapi/linux/kfd_ioctl.h             | 11 ++-
 12 files changed, 261 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9..04422c1e1f86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+	amdgpu_gfx_perfmon_clk_restore(adev);
 
 	amdgpu_device_fill_reset_magic(adev);
 
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&amp;adev-&gt;srbm_mutex);
 	mutex_init(&amp;adev-&gt;gfx.pipe_reserve_mutex);
 	mutex_init(&amp;adev-&gt;gfx.gfx_off_mutex);
+	mutex_init(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	mutex_init(&amp;adev-&gt;gfx.partition_mutex);
 	mutex_init(&amp;adev-&gt;grbm_idx_mutex);
 	mutex_init(&amp;adev-&gt;mn_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..c9c4c3d4e88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_do_off_ctrl(adev, enable, true);
 }
 
+/*
+ * Force the perfmon clock on, or restore the saved state; @save records the old
+ * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.
+ */
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
+					   bool force_on, bool save)
+{
+	int i, num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
[JZ] Nit: lockdep_assert_held(&amp;adev-&gt;gfx.perfmon_clk_mutex) here, as amdgpu_gfx_perfmon_clk_update() does.
With this update, </pre>
    </blockquote>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20261103023145.61021-1-Apurv.Mishra@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	for (i = 0; i &lt; num_xcc; i++) {
+		bool on = force_on || test_bit(i, &amp;adev-&gt;gfx.perfmon_clk_restore_mask);
+		bool in_safe_mode = adev-&gt;gfx.rlc.in_safe_mode[i];
+		bool was_on;
+
+		if (!in_safe_mode)
+			amdgpu_gfx_rlc_enter_safe_mode(adev, i);
+		was_on = adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, i, on);
+		if (!in_safe_mode)
+			amdgpu_gfx_rlc_exit_safe_mode(adev, i);
+
+		if (save)
+			assign_bit(i, &amp;adev-&gt;gfx.perfmon_clk_restore_mask, was_on);
+	}
+}
+
+/*
+ * Refcounted override that keeps the perfmon clock on for profilers. The last
+ * put restores the previous state. Each hold keeps GFXOFF disallowed, as a
+ * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it.
+ *
+ * GFXOFF control takes pm.mutex, which clock gating holds around
+ * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.
+ */
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable)
+{
+	int r = 0;
+
+	if (amdgpu_sriov_vf(adev) || !adev-&gt;gfx.funcs ||
+	    !adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override)
+		return -EOPNOTSUPP;
+
+	if (enable)
+		amdgpu_gfx_off_ctrl(adev, false);
+
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
+	if (enable) {
+		if (!adev-&gt;gfx.perfmon_clk_override_count++)
+			amdgpu_gfx_perfmon_clk_program(adev, true, true);
+	} else if (WARN_ON_ONCE(!adev-&gt;gfx.perfmon_clk_override_count)) {
+		r = -EINVAL;
+	} else if (!--adev-&gt;gfx.perfmon_clk_override_count) {
+		amdgpu_gfx_perfmon_clk_program(adev, false, false);
+	}
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
+
+	if (!enable &amp;&amp; !r)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	return r;
+}
+
+/*
+ * Program the perfmon clock for clock gating. While overridden, only record
+ * the state for the final restore. Called with perfmon_clk_mutex held.
+ */
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on)
+{
+	lockdep_assert_held(&amp;adev-&gt;gfx.perfmon_clk_mutex);
+
+	if (adev-&gt;gfx.perfmon_clk_override_count)
+		assign_bit(xcc_id, &amp;adev-&gt;gfx.perfmon_clk_restore_mask, on);
+	else
+		adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, xcc_id, on);
+}
+
+/* Re-apply the override after resume/reset reprogrammed clock gating. */
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;gfx.funcs || !adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
+	if (adev-&gt;gfx.perfmon_clk_override_count)
+		amdgpu_gfx_perfmon_clk_program(adev, true, false);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f5fb2e585e8a..1bfd12dd3956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid, u32 xcc_id);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	/* set the perfmon clock, returns its previous state */
+	bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xcc_id,
+					 bool on);
 	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
 				   struct amdgpu_gfx_shadow_info *shadow_info,
 				   bool skip_check);
@@ -500,6 +503,11 @@ struct amdgpu_gfx {
 	uint32_t                        gfx_off_residency;  /* last logged residency */
 	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
 
+	/* perfmon clock override for profilers */
+	struct mutex			perfmon_clk_mutex;
+	uint32_t			perfmon_clk_override_count;
+	unsigned long			perfmon_clk_restore_mask; /* per XCC */
+
 	/* pipe reservation */
 	struct mutex			pipe_reserve_mutex;
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable);
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on);
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a7ed4923857b..a01244621fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &amp;gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &amp;gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &amp;gfx_v11_0_update_perf_clk,
+	.set_perfmon_clk_override = &amp;gfx_v11_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &amp;gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amp;amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
 
-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
-				      bool enable)
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }
 
 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
@@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
@@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	        gfx_v11_0_enable_gui_idle_interrupt(adev, enable);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..9e754c25b15c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 
 static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 					uint64_t queue_mask)
@@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.read_wave_vgprs = &amp;gfx_v12_0_read_wave_vgprs,
 	.select_me_pipe_q = &amp;gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &amp;gfx_v12_0_update_perf_clk,
+	.set_perfmon_clk_override = &amp;gfx_v12_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &amp;gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amp;amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
 
-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
-				      bool enable)
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
@@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
 static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);
@@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v12_0_enable_gui_idle_interrupt(adev, enable);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f812d6d81e9c..958b4ad39d9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 					 bool enable, int xcc_id);
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
@@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.read_wave_vgprs = &amp;gfx_v12_1_read_wave_vgprs,
 	.select_me_pipe_q = &amp;gfx_v12_1_select_me_pipe_q,
 	.update_perfmon_mgcg = &amp;gfx_v12_1_update_perf_clk,
+	.set_perfmon_clk_override = &amp;gfx_v12_1_set_perfmon_clk_override,
 	.get_xccs_per_xcp = &amp;gfx_v12_1_get_xccs_per_xcp,
 	.ih_node_to_logical_xcc = &amp;gfx_v12_1_ih_to_xcc_inst,
 };
@@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
-					  bool enable, int xcc_id)
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &amp;= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
+					  bool enable, int xcc_id)
+{
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);
 }
 
 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 					     bool enable, int xcc_id)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 
 	gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id);
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_id);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 599d47e1d38b..ed10c258703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	if (enter)
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
@@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 
 	if (adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg)
 		adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !enter);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 6c8b8ed4a44d..46d746dd37b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_device *adev)
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
+	mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 	if (enter)
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
@@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 
 	if (adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg)
 		adev-&gt;gfx.funcs-&gt;update_perfmon_mgcg(adev, !enter);
+	mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..e4fb9f5aa3b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_process *p,
 
 	mutex_lock(&amp;p-&gt;mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	/* Bind for the runtime PM reference before programming the perfmon clock */
+	if (pdd &amp;&amp; op == 1)
+		pdd = kfd_bind_process_to_device(pdd-&gt;dev, p);
 	mutex_unlock(&amp;p-&gt;mutex);
 
+	if (IS_ERR(pdd))
+		return PTR_ERR(pdd);
 	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)
 		return -EINVAL;
 
 	kfd = pdd-&gt;dev-&gt;kfd;
 	ptl = &amp;pdd-&gt;dev-&gt;adev-&gt;psp.ptl;
 
+	/* Before profiler_lock, which reset takes in kfd_resume() */
+	down_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
 	mutex_lock(&amp;kfd-&gt;profiler_lock);
 	if (op == 1) {
 		if (!kfd-&gt;profiler_process) {
 			kfd-&gt;profiler_process = p;
+			amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, true);
 			status = 0;
 			mutex_unlock(&amp;kfd-&gt;profiler_lock);
+			up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
 			if (ptl-&gt;hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
 				status = kfd_ptl_disable_request(pdd, p);
 				if (status != 0)
@@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_process *p,
 		}
 	} else if (op == 0 &amp;&amp; kfd-&gt;profiler_process == p) {
 		kfd-&gt;profiler_process = NULL;
+		amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, false);
 		status = 0;
 		mutex_unlock(&amp;kfd-&gt;profiler_lock);
+		up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
 
 		if (ptl-&gt;hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
 			status = kfd_ptl_disable_release(pdd, p);
@@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_process *p,
 		return status;
 	}
 	mutex_unlock(&amp;kfd-&gt;profiler_lock);
+	up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
 
 	return status;
 }
 
+/*
+ * Take or drop this process's dispatch-mode perfmon clock hold. Taking it again
+ * is a no-op. Dropping returns -ENOENT without a hold, and for the device lock
+ * holder, whose lock == 0 must still unlock.
+ */
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
+				    bool enable)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_dev *kfd;
+	int r = 0;
+
+	mutex_lock(&amp;p-&gt;mutex);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	/* Bind for the runtime PM reference before programming the perfmon clock */
+	if (pdd &amp;&amp; enable)
+		pdd = kfd_bind_process_to_device(pdd-&gt;dev, p);
+	mutex_unlock(&amp;p-&gt;mutex);
+
+	if (IS_ERR(pdd))
+		return PTR_ERR(pdd);
+	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)
+		return -EINVAL;
+
+	kfd = pdd-&gt;dev-&gt;kfd;
+
+	/* Before profiler_lock, which reset takes in kfd_resume() */
+	down_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
+	mutex_lock(&amp;kfd-&gt;profiler_lock);
+	if (!enable &amp;&amp; (!pdd-&gt;perfmon_clk_req || kfd-&gt;profiler_process == p))
+		r = -ENOENT;
+	else if (pdd-&gt;perfmon_clk_req != enable)
+		r = amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, enable);
+	if (!r)
+		pdd-&gt;perfmon_clk_req = enable;
+	mutex_unlock(&amp;kfd-&gt;profiler_lock);
+	up_read(&amp;kfd-&gt;adev-&gt;reset_domain-&gt;sem);
+
+	return r;
+}
+
 static inline int kfd_profiler_pmc(struct kfd_process *p,
 				   struct kfd_ioctl_pmc_settings *args)
 {
@@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
 	struct device_queue_manager *dqm;
 	int status;
 
+	if (!args-&gt;lock) {
+		/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
+		if (args-&gt;perfcount_enable)
+			return kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, true);
+
+		/* Drop a dispatch-mode hold if there is one, else unlock as before */
+		if (!kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, false))
+			return 0;
+	}
+
 	/* Check if we have the correct permissions. */
 	if (!perfmon_capable())
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..32c3c23d6d14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -886,6 +886,8 @@ struct kfd_process_device {
 	u32 pasid;
 	/* Indicates this process has requested PTL stay disabled */
 	bool ptl_disable_req;
+	/* Holds a dispatch-mode perfmon clock override until released or exit */
+	bool perfmon_clk_req;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index dd938788bdd9..7ba1c4ab283b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 
 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
 {
+	struct amdgpu_device *adev = pdd-&gt;dev-&gt;adev;
+	int puts = 0;
+
 	mutex_lock(&amp;pdd-&gt;dev-&gt;kfd-&gt;profiler_lock);
 	if (pdd-&gt;dev-&gt;kfd-&gt;profiler_process == p) {
 		pdd-&gt;qpd.dqm-&gt;ops.set_perfcount(pdd-&gt;qpd.dqm, 0);
 		pdd-&gt;dev-&gt;kfd-&gt;profiler_process = NULL;
+		puts++;
+	}
+	if (pdd-&gt;perfmon_clk_req) {
+		pdd-&gt;perfmon_clk_req = false;
+		puts++;
 	}
 	mutex_unlock(&amp;pdd-&gt;dev-&gt;kfd-&gt;profiler_lock);
+
+	/*
+	 * Nothing is held on the kfd_create_process() error path, which holds
+	 * kfd_processes_mutex and so must not wait for a reset.
+	 */
+	if (!puts)
+		return;
+
+	down_read(&amp;adev-&gt;reset_domain-&gt;sem);
+	while (puts--)
+		amdgpu_gfx_perfmon_clk_override(adev, false);
+	up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 }
 
 static void kfd_process_destroy_pdds(struct kfd_process *p)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 749d196e2114..34f3ffaf1c66 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*
+ * KFD_IOC_PROFILER_VERSION_NUM history:
+ * - 1 - initial version
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until the
+ *       lock is released or the process exits. lock == 0 with
+ *       perfcount_enable == 1 forces it on without CAP_PERFMON and without
+ *       locking, until lock == 0 with perfcount_enable == 0 or the process
+ *       exits
+ */
+#define KFD_IOC_PROFILER_VERSION_NUM 2
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
 	KFD_IOC_PROFILER_VERSION = 2,
</pre>
    </blockquote>
  </body>
</html>

--------------zW0lcRTPwVd1N5lj9vvRAxkH--
