Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33851606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=00D7FhC1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B5A10F963;
	Tue, 17 Nov 2026 20:29:05 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AFC10E158
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 20:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTlSSZZ1P+YrBAFK/Wv6/2HRu27eYbNRNvTBkPjeU1HgpjbDE9I9HfcXzFEbiUlC+Q0AOqi3pe3qm8CD94id/O4Ga3obnLAh2pn8vr54LEQ1b+bciOEfR4BGFHF6oqHI+BaUSYuuLR9e/CKbnMjDZ2Vp2DtXwVbxT5pjXRawu1TRzWyaOS0emZ5/kboX1N4LFOq8wvPSjIOZN1wcOZmFgyV6Xm095CSkaSSW1vUTu5mqe8IcJIw/tUUMaAfwFOIXhsiEO8OgDhLcsvjlpla2DnEqgtfhbL58IEV4l2uUWaB8xgrB0JY1UjnTXPGbySXq2o8N2zvYdip+GIByV/lsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nhkVUGGUr2RY9XmeP6nYAqia8pjKi6O6yZ8e0PVJZ8=;
 b=QWfJfW17Hop4i0vls6/TfH8SANACEI5Psz4eLJn9A52H9zR39SDHbmpR12JsLmDgZFbYCq5RfR/wkprzJLq25uJHs1FXm7lrn/l2UnsbAGGf3HF2Wx2uTOsavJNoiv0/j/u7VHqtos9LpiC81TpPO2xLoqIzR5shmZrh/0BmKsi8W6ShJYK1tR87B4IQgwMhKyt1zckE0cAIA3JOl6mbB5N9NzfRoiZ92i95bqEYEzNRPYgbk/jD9qBG2QFgvtI4PQtagefoCOMqJhNgvEaZQkmz4lE8eDcOI1/tMJV8k9lQyE6f4fH86186bJiujN75UyrrbsNGkJ3wyLJvadVojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nhkVUGGUr2RY9XmeP6nYAqia8pjKi6O6yZ8e0PVJZ8=;
 b=00D7FhC1lleWjgGIdAHHCz6k2Tvw169hm23qBBaTPNEcoKtJ8kH/4SX5BvBH89QAna4wZKlPbG/iCIDmVBYf3y23ydLfWAnXTSQ3U0W0bPZqbwHQqhdh9uSZnAJFjfjlQX7SnfeAh0J2RokrBAYbEbK+RnqtDPzvHa4Jw7mK3qU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) by DS4PR12MB9609.namprd12.prod.outlook.com
 (2603:10b6:8:278::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 20:28:55 +0000
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b]) by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b%4]) with mapi id 15.21.0615.007; Tue, 17 Nov 2026
 20:28:55 +0000
Message-ID: <ba2faa20-95de-43b2-8665-a1ea41662a9f@amd.com>
Date: Tue, 17 Nov 2026 15:28:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reserve fence slot within
 amdgpu_vm_validation()
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Language: en-US
In-Reply-To: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::23) To SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF7B9E98CB6:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be15144-0dfc-4a0b-b67e-08df44e96644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|261022075727099003|10067099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ZcdIvFDIne7S2usr9zQYdOdycLEuDi0/xTo4O2hOU7scpqrmCo+5YDcpJbHGeNDGtOHXq1Y0jB6J8cS5A60SMomBUuwhbfJkbNJXoa+IXHsDFXeEGNcPUD1BQLIlxkoFFQBxuXzraiPdKOutSVsSsuDI6NeAYrIDRwBI0+yXoU9aZuKDgercjzaZFbhjv4v1GKtwvS/ONfMjSMyO0u83AG85cQ3L/jLi3ve4k7oIRX/b7nsHQ/erY8pwH2yA1LieL0K541KDb2WJ7M/dPwip389X3lwQKvnVRCqaGDu6Ts2Uh8MHAHI6AzNfpnxe6yeOCm5Uap0lqFZpc9cvKcNK6tJ1hgNIQUKdTO+HFhimAsBfIKtRQGlIIR5SlZ2U7icELMRcAAAVHKvNsjOw3wp+jy3+upwEaX8Jmwb2A0WWKieBI219eFVyDkVuawNpkcOQ1BnKzP4xNztaLeT/MyeWRTgyb1/2RS97tlTSCbLu7vBtgSUjJt2i1vWIZsBXRzWlHvdEyNdidFSBDHlcu5DatmDDQoaZEFPNgrC87cxXt2wD26NqXgRZzQ02H9SfhBtcYE9uqfw2Lfc6g7ehE3Z+iIOBasysSgYkfVXjyJbNw3r/xo+hrtRhpBo19PVLDIQSDRWfJZ3G54/ALXGsk3/h86yQkAYmYKzLNH9PAA5rp5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF7B9E98CB6.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(261022075727099003)(10067099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNOTWpwa2NCRExtR09kdDNqeXB2a0oyK1FmUHJiazVHSm1mNm5iM0Fad0Rp?=
 =?utf-8?B?NVhUVmlaWEVteDgxUFV0aTVaR1ViT3dLYlFhZ3RLamJrdVcrUmhZMUU2cTRi?=
 =?utf-8?B?VnJ1QXFSd1BkTU5FSmdaSXp4VkM4b0JuOE8ydlZuNkVLN1ZOaDhOTDVKWlhv?=
 =?utf-8?B?N1hJamRHVFhKdE9jcWdlS0RhYUV6M2srdjJCekY3UWVKT1NLanRWenV6REpl?=
 =?utf-8?B?ZDhVY3BPaVBzS3dWNXpqbkswUDI1VUhWeTBSZ1U4SXRyaXBscUFNK1VRWXhi?=
 =?utf-8?B?RWNrUUovb0tyVEVlamh6amFFT1h6M2FuQ2ppMytDTDlMT0dkdXVlRURiditJ?=
 =?utf-8?B?bjVseXJ5MkVjUmRhaUhLWTJLc3J1ODhDTm9XYnA5UEZ5UTJ1WWFMY3VIL3dT?=
 =?utf-8?B?ZStTZlUvYW9JZEo2SS9aQkhlam91dnR4dFJkVG5yVkhUdHplN1Z0Kyt6OXNV?=
 =?utf-8?B?TDVydWtYbTBQMEEvOU02RStxdjJ3T1o2OVBnTlkwOWNZRTB5M09vc1RMbVVi?=
 =?utf-8?B?d0VwS295akJSRHZTTWJ5bTdXZlliQ2NpZm5yWjd3T2JXdHF3eFZZS0NjUFhL?=
 =?utf-8?B?Z2ZPc05pTGdOeXNzN2prN0dzbGpLS2hLb3ZabkhSZ0F3YWYzM01rOXBpNzVu?=
 =?utf-8?B?MDgxVmZFV2NPSzFwcStEbE95RGI0L1ZBQTlBRUk1TURuZkNGRmw3bzBBRDdZ?=
 =?utf-8?B?L1JkRVkybXlBTzFUSm1FT2hQM3hZOEFvZVJSZUg0M3N5YUFOVFZOZ1Z4bG9Q?=
 =?utf-8?B?Q0R1eFBVQnJQTWk3MFd6c1dxeVdyYXJTZCt4bGc3dXMvdFZ3VFZsSmV4bG5a?=
 =?utf-8?B?WWFQQWJRMjR1NGR3WFNhdHp0YWpoOVR3aHZnZVBRZnNVSnM3bzJ5Q1gwdGs4?=
 =?utf-8?B?SURqeVVTMFpsSitmc09UMGY4R3RKc0ZCZ3NJL05McUVNU0hiRWF6bmNsOWJi?=
 =?utf-8?B?VFgvbG5UbnQzRjg0anU3QU1ZenIrNUpseS9zdDFxTGRiaXpHbTJScHY5eGpL?=
 =?utf-8?B?aU1URTQvY3U1ejU2aXdJdGpyR1ZzbkxkdityWnYyLzNveUR2SmJZVE9ZY2do?=
 =?utf-8?B?TVd5Y3FYUFJyWmVFbU92OHNjRTRSc0tvVGhnbFdQN3dpUU1ZSFA5eUYwTi9C?=
 =?utf-8?B?d3d2TGlIUEFvNmN3VVNOaUNpUkVZSUt5aWRZMnp4MjFtRkZpeWJVY2NIVk14?=
 =?utf-8?B?bVd5bWY3TGZvdW5PTGI3NWlTRDhodGIycGdvSWpoQnZIMDB3U1JOM0N3RnFT?=
 =?utf-8?B?bk5zRGxZRjFrK0R3YVhuWnJCUllieHZrRStWT1RraWpYK1dleEs2VWN3bkNB?=
 =?utf-8?B?cGNEZkJvaDNza1dOcHFFR0xzRFBDTjVlTkxacWtPTHpDdm1tdVBGY0NMZ3hp?=
 =?utf-8?B?QWl4KzhPTktQYVA2Y1BTVjVhbzhQWTJlSklDK2NERVE2R1NJWmtmMVhLOGJS?=
 =?utf-8?B?Y1M5eWdobFA1alU3TkFxajV5Z1dFZmpuWlN5TkhmU1p3ZEgrMHk4UUN0OTBI?=
 =?utf-8?B?NVNRenBlVFVma2hSWEJDMjFRblVyUi81YytaZWxYN204ZG5oV3hKeWdwZWNz?=
 =?utf-8?B?aCtQalZJNHZLLzhCMGpRMjdrbVdHYkRqQkVJVXpvbW9YR3gzaERMWUo2WFdR?=
 =?utf-8?B?YmVxNy9aRUxsUno2dm14MmZiWDBlUHlNekdyWDZBTWtNc0F6Zi9UQk9IVWNM?=
 =?utf-8?B?cVJ4MU5ZMXpRYkZwS0tsd0hHM2hXY2ZFcFpid3BMMk5qYk0wUnRsWmpIeG5D?=
 =?utf-8?B?RXpOOEtpcjJxL3g2VHlGb0xSeCtGelJ2M2cyUUZHVmxSTzA0SUdZMTVrVVdw?=
 =?utf-8?B?Qlk2dkkyWGVvbitQd0dJUWkwQzJrbXBtK3lHbVBGVkZCM08rd1Y0Tko3b3kx?=
 =?utf-8?B?ckEvL1c3ZEJyb1phNzRIeVI2VmxSdlNDK2w3MThpT3JPeTI1NXVIMUcvaWVM?=
 =?utf-8?B?Y0RSMTVtV05abnE5SkxlS1FYcmtMZzhvdUxkZkJWQTBnMXZna2NFd1VYUW5D?=
 =?utf-8?B?ZDhyTGt2dGNwSytuT3h4VklBSHpTbi9MZzlWQTBzMHJKL2ozSm5ZbVFjU21J?=
 =?utf-8?B?Qlh3R0pJREgxWTc5VmsreGFFbUdOVjhXd0dMY0RWUUMwNjB6cHZPeXVFZFQr?=
 =?utf-8?B?NnhrQWpXdFZtbWdxMk1Dd2tabEhPOWhiUVIyblpqc1dPc1B2MnVhMnR1enFO?=
 =?utf-8?B?NlY0K255ZW5HYlBSZ29HSXJDYVlUWVZIZGx0NkpNOFY5d1FaNXQ0RGJadTlM?=
 =?utf-8?B?UFNoNTBaNTdDSXVuNzFxR3lHS1pZODBHV3c1emtTMTVNMzY3MGNqM1VVNjlp?=
 =?utf-8?B?Zk9EUVZaSHljN2NZb0MwZW5yYW16WXBCUDByODZhNngvdFFGbHJUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be15144-0dfc-4a0b-b67e-08df44e96644
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 20:28:54.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Sr6RLBoWyP8qP3XDl1GTQM3ZxqogakB5UWZnYlMLyPR03PdSi6+xsuCni49nwjRtTP92Q6S2hh2WNMuN0LeHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 2:54 PM, Shahyan Soltani wrote:
> Anytime amdgpu_vm_pt_clear() is called, a job is committed through
> vm->update_funcs->commit(). If the GPU is currently using SDMA, this
> triggers the function amdgpu_vm_sdma_commit(), which requires a fence
> slot due to it utilizing dma_resv_add_fence(). Since this slot is not
> provided in amdgpu_vm_validate() a kernel crash can occur.
> 
> Reserve a fence slot with dma_resv_reserve_fences() before
> amdgpu_vm_pt_clear() is called.
> 
> Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3bcfe0f3b35a..d5b758b5eb82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -658,6 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		bo_base->moved = true;
>   
>   		if (vm->generation != new_vm_generation) {
> +			r = dma_resv_reserve_fences(bo_base->bo->tbo.base.resv, 1);
> +			if (r)
> +				return r;
>   			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
>   			if (r)
>   				return r;

Just noticed the patch subject line typo.
Should be: "drm/amdgpu: reserve fence slot within amdgpu_vm_validate()"

Thanks,
Shahyan
