Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C9EC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFE310EE6E;
	Wed,  5 Aug 2026 13:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWpLS0lQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232DC10EE6E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt+uaB8Gn4kAArvwo7qx2WvTCt2aiTFf7mGx+ErGr+jiHKDh/rq+nQNJbysw3cDdgLShBnTnGPqtkfAc+IqHmaiuidWCORVrkadK/5PDb2hppX14VIXMBsvkBI+a9wd/FP8xoUDkR0CYu6IH5VynxGwnH7V0sY+PIKbm9+iDgJ3O2tsjffP8nJbJwqMYAlVaEHDWo8Jph2khZtmyHrL2ZclkgCwt1nH+mcGkIEhS+zuredDtcgxfUU2kmAp8UutObMUifePx3dvCfvPvAbq+B3YEtbUh/niCkccmTjFteUJJcdqH+Q62iKi+jQuiss+4IIlGiSRKRjcwwg0TGgsIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2H1Tk+nlCcqixCxhbXKSrhEQ0bEsC0dLp6sV4mTMU0=;
 b=Qou3I6pcF+hoctUwdMfuWt1IM0Y0L06Zt+bN1nXi38wx3SxRtWemOi3rXCw+hJfmY3zWU3BcnT1Ta6YfzBgyY0Pe5n+LkwM27Pm426rX3OetsfNGd9R0ZzRBjKkGJnCc1ItUwQt+NXjm1f6BPhvXDZEoZMDGJqRiJh9Wdc91I2AXgG572KESR8FQkc9GKRxGwowOz4UimQMTOX6Ijb8uk6dwTiOL+wAL2rwQXBxXGq3LsaJHfwyO4rE14hMtISQbmOWq0fIu6cEVu9uzkN32Xa3SaW/ghI4jELPyRezbF+gwTiTpptZbv6yVKUw9P7We13Qbe6xm+A99LH0cL/xciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2H1Tk+nlCcqixCxhbXKSrhEQ0bEsC0dLp6sV4mTMU0=;
 b=oWpLS0lQTEFJ9Yrlqu6Rgf1cxbGKpFN5v3n1zoxxLha24Bj+QRHRpPLfjeEHcIDOuqjL6Ij8jWW5rMIkFOBM750ExBvbP9ADPFkr0E7l1fpwMMIPnXtmQ/Vbo3gn7r7vjdhKftAX9fGpf77Fm4QsyizQ6JyGsGQO+UwwjNaWS3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 13:41:29 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 13:41:28 +0000
Message-ID: <9074a5ad-1199-4d32-a909-eabc933dea8d@amd.com>
Date: Wed, 5 Aug 2026 19:11:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0205.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: f67dfa97-3fee-4803-f719-08def2f7408d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Lq/rvh1vbba3zoV0iCcsFbIWKbdw0b4nU03yx2FyTv7Sj4oVcilPX202MsCKcu7M8KYswbnThSuAnswmfsqmFa0Auj11eDXk1lA754bZFIB4OFTbKk8kAKcfGv/tE9pVblWxS0ecryDtSi39NlKJpnIGZ1kdtm/vb6wF63tU4rC648isclJlNCHvDBrO27Zs/sSdcGTQKbsh4hblwzOOQoYa2AKrVf07MmVND4Q3DvlJl9Jzog7wgqARWzBhTc95y8BSGGuHmcpt+AvBJ2ujhh8nnyXuNZI7pDQltgRgRdCCzOe9E4jT0v+xxIqPeqvzEW12CP2wsO5aRouIxrd1X4uhB69OGAdvrpmuIfzZKrips5JX/fir8yPkg6wDctpj5OdiZPhRpzUoNk0V6X5j4Q98W3dydadC0ObRWw+Ki3/No76bMkGph0ZxZdrG907KVEjwi351qOdiUymMYCosHwWZhv0K6ai4pxQp3Hl9aU9Tt9sUp2ioAR50r93etfC8tHiv/31/Q3oHaTa6O38WIsOXcvGZjkzYix31D3vmTxChNlMFsqtPN9MvTk4vWZXmaKcBKPzSywfd7SEMt+Wiub86rZzqSYhmLdRo5sc6VtsyAtZky/i7uL9wdRpEkNnMILeT3kJ4OGI9BEUUIT0AsUl8OK3RSczJ1h4qZB51Dzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y21vODhRcUFCblFGd2E4R1lPelhlbUNncjNrM0xZdEdOTjhBZE9sdFNmeXB1?=
 =?utf-8?B?VU9CbmhaUmE4aGJ5dm5lUkU3VFdJY25HVjg1cVIwUnE3cmRyc040eWgxVDNS?=
 =?utf-8?B?elYzSHIxZ3ArYlUvQmVWME5OMjl3OEp0Vktnbm5GSlU2OVJSeXpPSkI2VTNy?=
 =?utf-8?B?UnhSNElXMHFmQm1BWEFyS1dUWG9kS0hEQUQxUmhZQUlBM3ppcHFQYjJ1ZUZu?=
 =?utf-8?B?RS91MEhhN2RML0t3VFErdm1pT1lqZDNBM1JjOHp1eEhsRXNhTU9GSzc3b1pk?=
 =?utf-8?B?Z2pLZFVIaDYzMUxzbkdmZWFQczNleVNCNFlHdzcwSXlPMW5UTW9pVWJDNlZY?=
 =?utf-8?B?TkdDVmhxT2x1MEQxOEhSOWE1cnZmRXVuazE0U213L2phbGpTT1REOHFKNHZP?=
 =?utf-8?B?a0M2NnZvc1VsUU54L0pPZ1RvaGFmRXk4aU9LcFk0OFUwZUxlc1kzMlMvald1?=
 =?utf-8?B?TWxMK1BNRGl4MmhUVFZVRThYdnFVa1NTWStzSFZkSHBZeDczY3lqSUc0dHky?=
 =?utf-8?B?NG55NUw5ZDVhejAxT2s2WTBpZ1BsdjlUU2RUREVXbm1UMXdScGlHWEg3R3dB?=
 =?utf-8?B?UXlsMytlUTNXVXhUdzNjVGkrb0dsS3JIU3lJeWVCSGF4c01LbUtLWGp0aVpX?=
 =?utf-8?B?RkJHS2lrV0xHZk9ocThwQ042cll1R003UU5mdU5ZWUtOYVIrU01nOUJtNGhs?=
 =?utf-8?B?bnp2YnA0ZGNEcEY5SjV6MDcrblZjRUhXM0F3ZVZYOVAvaExJWVlTbEhZeWZW?=
 =?utf-8?B?dzYxNU9zb2psMEN4WHVDc08rV0RNQnFKUTUzN21aT2tZWmJRdE5pZ0Q0Nmpy?=
 =?utf-8?B?VGg3UTZOVzlBZ25reU9jQjVqRXZ1L3hkSWVVc1ZGOGdYeFhIOWlzSHJLYWhE?=
 =?utf-8?B?VlB5TVFmSlo4N0c1YktiYzNGTm5zWDVZUU5DVmg2enVna3NGc1hya0p5cTMv?=
 =?utf-8?B?U0xNbWdJRlNuUUQ0UkI5Q1NIYmh6dTdCMFA2bWczdENPcnpCSDJUZjE2L1hE?=
 =?utf-8?B?eVIzZUFGTG5NOVVGRzhXUVNFWjlncVhyM0JqMTlJdEI2K20zaG95MXlpSXVZ?=
 =?utf-8?B?bFJpU2dGMVRRN01yMzQ1NlJ6M1dCTTJPQTFseUZPa1NNbmlQY2NPY1MweEdI?=
 =?utf-8?B?Qi9hOVZ5RHZuKzE3NGZ4UU1UbUdCOHBLT2lDLzM5bVZCb25DQlBka2JUQUtE?=
 =?utf-8?B?ZzhWbElpOVJqc09ray9LSXhDeE1OU2l1Z0xDZUVzc0k4OVE5aWtwbW45OHVl?=
 =?utf-8?B?eDdmM1hOVlpnajI0Zlo0SldacUhVY2NmM08wTnhZcVNpSGRaK2JEMU92OWhO?=
 =?utf-8?B?ZitIMHBkamJoRmxWRDA0a3NMcW9aRkVXT20xL3BGeWNSWG9rL3kvbHl0UGs2?=
 =?utf-8?B?UnJ3UFU1OUJ2QllwRU43b1c2Q25qeWgwTXhtNkdFRTI0djJUamF5QVpGaXZt?=
 =?utf-8?B?Q0Fvb2wxV1I1bHBNQkxVWVQ5WitrVU81SSthS1Q4T3BIWGUvMmx2ZXBSRTND?=
 =?utf-8?B?Y2FXWVdRcG1SZEcyN3Y5K1lpallPbGVHclovSUxPRjJ5cUR5Z0dWeHNOVUFu?=
 =?utf-8?B?NDl4emhuVWoyMWZKQXovSHRNZ0dGanR6elYyQWZxaU9vZGdKNDhGSmFsb1BT?=
 =?utf-8?B?Q0VTRFU5MVZ0UVgxSzQyTlViSjkxQTNkbVhaWVV6S0U2NFhqRkxJWFF1VExt?=
 =?utf-8?B?dkszNnFVamJRTzJ6eWdqeVVwUEVSeW9MUUxyS0VnRkpWbFhtNlV4clhkQ1A2?=
 =?utf-8?B?UGVuaTl5U084a2tPaVI4M3FZVk05d1R3S1NvQVZWVzQ3QmRlT1ZVUkRGOGlK?=
 =?utf-8?B?MnV2Y212KzZSc0JvYU5SNVdzQnlEQkcyeEdRZGJDUkJhWFo4S1hUdkNGM2xC?=
 =?utf-8?B?T0ZiSmdFY3N1WTF5OVV5K3lHZFNWaCtxM255YTE3TjRHekVCVm53Q3ExemF5?=
 =?utf-8?B?QjNDMmdKc09mV2IxenJqTlovWGZGbFZUU0lxSDgvSUxsbDlsQ3ZpNG8xT3ly?=
 =?utf-8?B?ZE9YWDlHdVlmSGJTOHZVeW1BWWZOUEQ5cHFCdVZhS3BBeVdET21LV2h2R1VT?=
 =?utf-8?B?eXR4WC9GdXJMMnVRYXEzS0srQU1Ka3I0K1pLSTNiRCtldXczeklpZWlGUHBX?=
 =?utf-8?B?bVNVeVhQVGdJeDI4bmpnMHJuL0lvSENYQzl4cXVPbXdGUzRrYlhnMjhVYkVG?=
 =?utf-8?B?dGJqMzBNd3oyZVJtRlJBMEY1YVc0bkdDQjlQNDUvRVkzOWJnN0tmUlZUY0pY?=
 =?utf-8?B?MnRVQm1ncWtRMFVwQkNpT2RXSmJPc245Y2tKUmRNcEE3eWQvTUVSMFZVSnll?=
 =?utf-8?Q?NchcH6cKwkIkIfu1Jq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67dfa97-3fee-4803-f719-08def2f7408d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:41:28.8807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+IKF3eLynKpZN0i4g1B6BteYCsVq2IN8mkeqaEjZqvq/N3Hhq7YE8ilHcbM5Ckb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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



On 03-Aug-26 3:05 PM, Jesse Zhang wrote:
> Creating a user queue can race with a GPU reset. While recovery holds
> reset_domain->sem for write, MES is unresponsive, so the ADD_QUEUE from
> amdgpu_userq_map_helper() times out (-110) and an otherwise valid queue
> create fails:
> 
>    amdgpu: MES(0) failed to respond to msg=ADD_QUEUE
>    [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-110)
>    amdgpu: [drm] *ERROR* ... Failed to map Queue
>    amdgpu: [drm] *ERROR* ... Failed to create usermode queue
> 
> Take reset_domain->sem for read around the map so it runs only once MES
> is back up. This mirrors amdgpu_userq_cleanup() and honors the
> userq_mutex -> reset_domain->sem order; the reset path never takes
> userq_mutex, so there is no deadlock.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 652599f08990..770635ab5298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -745,7 +745,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (!adev->userq_halt_for_enforce_isolation ||
>   	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>   	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
> +		/* Serialize the map against an in-progress GPU reset (MES is
> +		 * unresponsive during recovery), matching amdgpu_userq_cleanup().
> +		 */
> +		down_read(&adev->reset_domain->sem);

If a reset is ongoing and a userq operation comes in the middle, there 
is no need to wait till reset semaphore is available. The ongoing 
process i going to terminate sooner or later after the reset.

This should only try to acquire the lock and return an error if not able to.

Thanks,
Lijo

>   		r = amdgpu_userq_map_helper(queue);
> +		up_read(&adev->reset_domain->sem);
>   		if (r) {
>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>   			trace_amdgpu_userq_create_end(queue, r);

