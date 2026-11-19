Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CB606A32F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lGFzdfx/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1D3112431;
	Thu, 19 Nov 2026 13:59:08 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C26D112431
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwGg2t8YIb8cWGe0UAtJ86XeOCeHfPQLIonb1MaHjAsRq1tmrXVXMNvCPE1+XbYzjhDofOec0+qaW+CBMWdXmGtu5i7IZafypWlxHW4wCA9GmkG0maZrsKtyrOFceyHQBGPlRo3uoIAcevt0lF4Xhqn2++98YYc//lnDZURxeaOy9gesxeIu3wYKp0BUAcNbG1chuyaVkQnUWeLSLyfk9GIXyxk4OxdUdtWkKCy3CFWzHslqjg/5bJ3rrZ/l/mNeiDWVx3ezwCnq/rQIJTChc6jWpc/XEvGAJtDXX9tBAqVwjug4ErsEnpvAoreEJRVD1XsB2OULQFySznCMF8iZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEs7UpSAvAAvQJta5onG86PhRB0vl7v26h2uopDDrTY=;
 b=q2aaCi6ewHMamzvvuOhd2K+c/YDAYvkUWjzMNXHODRg2sJXh3IliQijW57Lg63m0cIyoZyqf1m51S6ZpsFg+btfabUMg9UQB0PdaNd52XM61Q2OoAIAUzRzB+FluXRjh1/w2BIsJKtqedpel716YJkMUyQtHYIDNWTEICwgcwCoPg8/ACsUpfI1LTwQtgo07msbtyqafvDcRdyEoPeHX/W0bONkaIKVHz6YbnbxiDgkiJUPEfskRo03KRdI5+lmWk/ez8LcSjrmZV4jfHA+9uu3BL/vGupqQSdMtR2EYhtxo8Z2+qpVZ1JpytWtWNG7d3VwX+coeuNfboU+iUjYR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEs7UpSAvAAvQJta5onG86PhRB0vl7v26h2uopDDrTY=;
 b=lGFzdfx/KcuGT6ogZ9VDSmVg3wdxCEfheIZe8rE0Ikl4yVQFui8q51f/PTTPgeTuZYgp2tf/aZ6yz5xo6tLf7NX3r8AshgNX73GeTBZ+BRH+VGkzWqRiRBFlLDyQu3X0uhQ2zpYQ1/UHWAUoX8lJetRVvpvapJcReX0GuUvasOc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 13:58:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:58:57 +0000
Message-ID: <bd1ecff9-7356-4159-a736-143e32f34a00@amd.com>
Date: Thu, 19 Nov 2026 14:58:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] drm/amdgpu/gem: reserve fences on the VM root PD
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261118190735.1863676-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118190735.1863676-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5e9860-e629-460a-9cb5-08df4645413d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|10067099003|4143699003|261026121527099003|11063799006|56012099006|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TlUrAXrwaOiXKJqmxtZuX/7+vP6Jzo7as1YqSLSQpb8/qSmKjW8kutF92Lzu8ejdZYnlmTo2Er1CSuVFPVbVU78lLQGC0nLbmNfoiYm2xFk6MApc2xuq5ShWuegBlpfHlWPwr2h2pREEkM7Xg00Vc116uHebbIEjhXcS3qPxPU0gS77bLba1fcvhP0ouBHT/7RDwuKEJ2b0x0mWxldB7Maw7RdvkDwxk/TlnTYQUAtpFnaIuY9wKTv/HY+WX0HeNVJYJ/oLmAirO4QuoUwd37cLd2nJKeNSgDglE/58hk+3aAelg8bP0K+Rnb9litb260hix1bh6g1jcOg3or3QUDTZKcqxDuDFHe/yzc8poSBvEW4VDFDkg7v72h+PjcG4B/WedsaMMwXt8h/1ATWINMY33Iq9dxci8hv81s7LATIsv1eBvz7QeC8AJG2PiFGhTeb3/9TswdeDOPHwpu7gLUXhSFXzgq+AJLiw51ZKVwsfeJrtJw0r0UKQVzP7dXcyVXnacPFkUs4u787eBO7GH4dbO7CrBU3SkJGXX3MN6PAEloQ4Xv8k7GyV3kQf9afjO+p8/lw5/XVWixHPywvcOgijEE3yg3lwfa9MHYx2ND2Gf8EpxsIvQNw2TGguMLcxJLRKFCUAR0GvfZZoZJ0cXn75fID0M8bsS9qAOIhozQAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(10067099003)(4143699003)(261026121527099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERnYWFSR2NvV2FRY3ZrYlVjWVNScDJRbVpTVkxmd0FnZkVMUzNSNGR4K3hj?=
 =?utf-8?B?L3JtNHNDdTFiMzhneVBBNTVabDVFcEg3eWFVZ2lNU1RCMVBOVWNkU1QweWNK?=
 =?utf-8?B?WkZXL3NCZGZFblV0NTRmQVBoODY4TENKQTU5RTJBT21xYnQ4d0Q2WURzcFBo?=
 =?utf-8?B?TFZ2Z0hFNDczMjJVTU5DU3JRc09QRFVKNnVBQm5ZYUhxUFJsaFZzdTgvdFJG?=
 =?utf-8?B?S25lVDEvZHZFQUN4ZnVuU1BRSWsyVmNPTkxyR3h4VktDeU4zS1ZabVlsZW1T?=
 =?utf-8?B?S0tHbHh5cFF6RHVGbVNLN0lqaFdQeXJnMWIrdWxSdjN5cjZuNHhVaXJ5VFcv?=
 =?utf-8?B?SXo1T0s1b3hYTmxUT1NCNzBIUGJwSGFYMVdJQ0NYS3BsdHhLUkZUcnIxaklQ?=
 =?utf-8?B?MVJCdU5MOUxUSWR4QkFrWGdtUU1lVjFRdmVEWVNPN2ZRZVhZSzN5aThueEx0?=
 =?utf-8?B?M3NhN0hKd1NKaEtqQ1plcWc3ZWpFdG5LaGErYThnaGE0WXFaWkR0akpmVHpN?=
 =?utf-8?B?S1Vqb01oTTlmc2k2VXV0N09Idkx4NzJsVVdNWmJsSCtaY0FOS2NhMU9tSlpL?=
 =?utf-8?B?UlFqZnRyZmhnempUTlpjazRDbm9JY01mWE5lemxPbnl3RVlsQ2tqYmQwZng4?=
 =?utf-8?B?bGNUSkUraHNUNGJIWFVHREVLYTdGNzJPVXZET08veSt0cDZINnJ4NTlzdEJy?=
 =?utf-8?B?OE9NMDVub2l1M3NudzZORStLei9OdjFzMjBieEdQRlVmVHNOUTM0TkZHdDNV?=
 =?utf-8?B?aDJLcFV3YkNKaDlzaGdGRVlkVC9mM2R6L1JqcVVmWjN5V09ROThHZlQzTVl1?=
 =?utf-8?B?ZzBBckR3ODRWbkFGcTNVWk5ITTRvVzgydUVxT2x0U0RvSi8xYWpDREhrdWZ0?=
 =?utf-8?B?cktCdlBZUGVUVkFmb2g2RkN1dWxqNTd2REU5c1R1TzV6emdPTjNvNXdPbGZB?=
 =?utf-8?B?WVVwaStNV3VsL3Mxc2FIMmhzdXFFZVQ0NVVGd3FrZmxheFdYTE1HZGZpSEZK?=
 =?utf-8?B?OGxvVVF0QU9laWZZbE80ZmpqdUp2MFhYLy9ROGd4T0FkZzYrakk4ZXhIVkJq?=
 =?utf-8?B?SFR3OEhQWVh0Mk5UcGxvRy9tOWVlYkVBRjVjejh5MkM3ZjJnaGhpZVZrbXpw?=
 =?utf-8?B?SnUrc1krTW5QY2JSR2Zvd0htMjZBelR0Z05YblYxNk05RC9ZMlplSUFlOGFR?=
 =?utf-8?B?SU5PR0V4MG5KZEFBeXNDQVZsSy9UeUhIZFN4N3M1RlYzTkVZY2R2T0xpajJ0?=
 =?utf-8?B?OEx0SUlOaWo1anRoaVFORHVVdkpoMEFNM1B1aXkwME12OUk5b1VCblRpKzF4?=
 =?utf-8?B?aDluU0NrRWlDbVQ1ZmZwWUpvUERpTFVjYzhTWWRUVGlFdWVWNU5SdCtrcjBB?=
 =?utf-8?B?SDVjME9VbCt5eDQ3TUJRdlRkNVppNk50NnZyRWFjVktrcUEwMSt3WUNsSk9D?=
 =?utf-8?B?THhRd2EybjZCMTBlc2lDcjdnamJpT2R5UWp5blVUWG9vZTJDVC9QL282NnpV?=
 =?utf-8?B?MlhBcTNiS1BoRFhobjMrOHVFQkhMOVlZYlovTFlVd25pdVBjYjlyc2RlZE1X?=
 =?utf-8?B?a0dsMHpZb1MyeFVrYldpSHd2aGZpRktjWmZpckJIeCtCanVEdm1NWVRDQVVV?=
 =?utf-8?B?VVNaUmczV1NFZlpFVTdPRTcwaFBKeFoyTUtjdDlwbCtMNUFiM29ncTdOWFFm?=
 =?utf-8?B?VkVCOEM0WnFHWnZQemZKVTdJNDJiZ3JwRU5Cb0ZqQURZT3l1UE1YVmZ5Rm4v?=
 =?utf-8?B?bmVHMjA3ckJOT3FPckMvUDdvS1JzU0lDTnNFVkcyTi82bS9NM1RCMjVCVG5i?=
 =?utf-8?B?MnNTOGV2Mk9VeU1yeVA4Z0xnQTBqVXgrc1RuWXdxNHU4WmxxdkVhelIrOWU3?=
 =?utf-8?B?S0lSek0rY0tzUytrS1QyNjVmRjlNZ1lYMC9NZlBmTGhLNmxrSitnS2toSUgv?=
 =?utf-8?B?WDdoVHE4dlNOOGhMcFlDdXZrazN3dlk3bHlEOE1wa3grb2xwNmVrZlcvM3Y4?=
 =?utf-8?B?N0Q3WVRQZUFmQ2ZDdzZnWkpSY0NWQWUwRDRtMFFrUnltYnMvZWZGOWU5MmVZ?=
 =?utf-8?B?TGVuSjA0QmR3R3pZUG1RbjFEWGRtcDZSZS9aTktCb1gwZHcvRDl5TTVKZ2Uw?=
 =?utf-8?B?czk5TlFlTmNwK3l2NUJUQUpYdWJHVFdkQWdoeEFpVUJYN3hIOWxhRUsxY0Jo?=
 =?utf-8?B?STlDNFFzcXIyNEN1cmxQcEVFYTJYSmNEck94UStPUk1iQUY3bmxBVDFCK0F2?=
 =?utf-8?B?SW43Q2wrcVQyK2FMZHpJQUtoaUtDSjhrSXAzalZ1WFRSOHNKbWlrVmhYYkFO?=
 =?utf-8?Q?vY+mNXJOjPtMKSUseQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5e9860-e629-460a-9cb5-08df4645413d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:58:57.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgWR6Lqf67cM+LLgSMK7cBLXgE5FuFvv94JRNnBbPXpw81oecfZQypoRXVqd8tYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

On 11/18/26 20:07, Benjamin Cheng wrote:
> When creating a BO that shares the VM root PD's resv, TTM eviction
> fences are added to the resv, and there is another fence added for the
> BO clear job.

Good catch.

> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")

Yeah that is most likely incorrect. The bug existed for as long as the driver was upstream.

It's just that nobody ever noticed because it doesn't matter in practice (the VM root PD should always have enough free slots).

It's just that the automated checkers could complain if we start to run them together with lockdep enablement.

> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9da7ae6b9ef3..eb7473ed9e0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -504,6 +504,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			return r;
>  
> +		/* ttm_bo_init_reserved() + clear fence */
> +		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv,
> +					    TTM_NUM_MOVE_FENCES + 1);
> +		if (r) {
> +			amdgpu_bo_unreserve(vm->root.bo);
> +			return r;
> +		}
> +
>  		resv = vm->root.bo->tbo.base.resv;
>  	}
>  

