Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DACC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EEB10E48E;
	Thu,  2 Jul 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1FcIluu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0654B10E48E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEPKH+3CLmhHeSgJkTxMpzGe2JZmnY29HsMkc+JoGoNbnOvZ/7THXH62QKM1igzdmorq9MdT82j0bOtwR2sLDSbD4y3Em5SDinTtwxqN0cv3E9INluJB0mX1spV+Z5knp2W0GsjWPmZUp8hZk9KEVQUr3/YlTw3wvcTLbaWgF2GYuos7+zptFTYP6LU2t/z5d+zz6EXJ4B4zmT0QezUJ3W8jDZecDkOgr03lIqgmaSK5UhExtAWv10mnirpAQnBze8LzJxAmnXK0h4q269ZwNzwK/q/v9n/x66ZDcqRkVKljDQNVwH9CIJyI9aKZrGjB3wFvFOin5x2WiQsDHZhhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9AqmP2TUWUTG3JWgixgGC5ykIFBbLEGQ4zAqwJ+MVU=;
 b=l+k6gH/FEIVJj5rTetHyZ/s6DmxdBrj8FiQzxmQSUi6QYXqUb/3UYC9fRL88q+IxzW0ij9DUeBve6pO80BX+D0xNyXYBprnnHOyzc/ofgUAvdY3LGzLAtP04BExUbYYDYCvMUcgaC8JjVFU+BpUwuTdxabMuupnxzPt6Yjd5kMXizYQzVieA2uf20g9DOUgNDEoEfEO1rEUeTR3wrHnmxjlC3py/0RVFYAzc05DOGOaQkpc2EnPfNsQzXjn3O9fzWXjT1eAo7qT20CxjtvK3gkCfe3HEeLWHGQvOedPDE+UEBlh31ktsquYCDBPRhiKsAS9OVAxjGTBs1O1XDHhKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9AqmP2TUWUTG3JWgixgGC5ykIFBbLEGQ4zAqwJ+MVU=;
 b=D1FcIluumVgWV/TQYJsdtaxaFx1jMaOOwKhlNfF1SH+0oZGjPV/5rHufMwmQ+ABb/+lXi//hvYNI2Epv0druN5GXi60oShRTYtAhZDfVtOB3uVLWxjyD85+73L9hBNiWjWpUn7Vx5hft4Mrl6knGgCcTrwkIArBokOiopr5pzKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:22:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:22:29 +0000
Message-ID: <44f84ba4-e91d-4cf0-bf82-635b03e668b6@amd.com>
Date: Thu, 2 Jul 2026 12:22:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu/vm: Use init PTE flags and NOALLOC in
 amdgpu_vm_handle_fault()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-11-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: d93ec704-f59a-4b99-f6b6-08ded823d1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: hZB0yey6Q59K3joCsA/AwdGsEEXsbUemGyh1+Ntyt3+ZZMEI9VVb0Et/gT7NxaW6lNI4rC8gXglrUcrfZoHXWTgQrseAZ0S6j3tPOhp1Cq90O4YnqNJzgv1qd4v2CpF9eHYzX4X1YT00q1C4VoSUvpTolh3r3s/Cx2Fo53IFdd4LNkTS47u7o3po4Tq+k92Q8Y5lAOOO1YOJtlW80ynGoXOBcZVQFedln7F5H/yULbpOYz32YC+5Dx6Ll8tK1cFuM+gxO2rTjTX5t6Af93skCXbvgfQ4hSep4JlAEcEEpFoDLidHgAdsLRSbLk/+ly5zwW+7MdSLbF8U7JyyTwVa7Oc8TJKTgo3LX4+WcGQHOqd+JjN1eqZyOgYXHNt9nwGuXwAaPYZZ90QNsU1sal8/sCIUMz8evVidbxeyfQ5NfVBMp3BAm9bvh7g6LVJDC13igoxYz7cifov2seeCzbavC5l2g9Yn5v8jFm7a78//Y7+6/EsqENWUGTRlI+lpvkGnXXC1Du/beqKg4VDEz41zVqx/NHbN8GvhNiyQ+5k1NyexFvA19SSm3cm2+Ys/5+zag9Bs8zTnf902rYk19Pow2/nJU19PWWf5a+MD6c4SvM7Xxnrd+U3fst1S42L5LId4GNZAKiNRF2wquK2NECEQShpfo6n41RiSj01wjB0Akd/1gStdgjdEXlQWcwfBYMmFvGiJQA9Ut1gqUxbZGxev8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdGZTJycmEwY0RqbG5TczJOZTlGUzdmTis4K00zVW9OYWlqdzZCbHJSM0RK?=
 =?utf-8?B?WFo4NytQd09mZlh5T1ljTldLK3o4dm94MWZVL3ZiYWpKTmFDdC9BTFdCbklH?=
 =?utf-8?B?WDhta3VKT3lsQmJWSStSU2VGM0U1R0xoRjZQTGpJRVpld0ZERWlLYVJhVGtT?=
 =?utf-8?B?K1VCT1N1WmRtbHFvUTdxRmM3c2NKSWluUUhVcVNJcjRONER6RW5tTS82OXZa?=
 =?utf-8?B?alZlVmplcVpNRzBCWW5ycFQ2V0xhOElJa3dPaEM0ZzcrdE5oR0hvMmFVUS9q?=
 =?utf-8?B?YzR0WGQvV1hjakJKTjV2Z2NPdDFWUWlaeENRZnREamhxRmUxM3BoMWJpdlpa?=
 =?utf-8?B?U2NROU5rakFwalhIdzBLNHRJWFN6OGFVR2EwdW9aQVQwcHVSU29RekZsZTlh?=
 =?utf-8?B?S0hZMkl2T0VXbVZ3TlVJK1h2cmNuWm5OcjNkVmhBai9YZEJBVm1FVkN0UmF1?=
 =?utf-8?B?QW9mNXpBWWtnSmFzajJnaFA0Y3YrcVFISVF1ZFhVM001cVdNZzVMV0hSL1FN?=
 =?utf-8?B?cnMwWEZGRW8walgweVl6dndlRnNKQVZMekE4MnNZM2swanNiT1U4ek1tb1Jv?=
 =?utf-8?B?aWdUVVFDa0lTbHpONnlaVkdxNnZBc0tkb1UyeFpXQWJEazVYb044TEQ5TXNs?=
 =?utf-8?B?M3N2V0JLK0ZnRDBpa3VaZnZLcmdRNy9YenF3aU1menZGN0JrVkY2VDRiTjNZ?=
 =?utf-8?B?N2huMXN6dkdjRElkVTVjQ0hNSk83QjMvVU1oVnkxNUUveEtyRjFWbW9KNmh1?=
 =?utf-8?B?UzZ5VHVveDk1bnVaK0FXWFZiTmtKdzlMRlkyVTVPN2I3UHdBemg0Y0xGeHBO?=
 =?utf-8?B?ZXI3RUtETk8wWTNwcWhrc2JsMm84TkllRkhBVFhTdVNGdUZXdkM2d09KSEVJ?=
 =?utf-8?B?Qm9menlrcnIzdVF5anpnRGhKLzJZaEZFTjZZa3FLbXJCLzFwT3FtOEZ5Q2Vy?=
 =?utf-8?B?d1ZRWjVCWmZlUEhtb0lwT2VqNlJJRGI0d2NpbUd0Si9uZllSdzBtL3dseEZK?=
 =?utf-8?B?Tm5lNGpLVkE3VGgxSjVUL0lpU0ZBS1pGL005TThhbGwvc3hrVlRsV25uMkJ6?=
 =?utf-8?B?N2FWMmxzV21Cd1FrN2FjUEwxVmtpSWI5VkdNL2hyWVlOdFVPYkd0Q3BpUzVi?=
 =?utf-8?B?bXFtOWF6cE9tUjRMeEFiNkFLaW1CS3FOUWxqbSsvNjdVcVJaRUVHY0ZYeGZ3?=
 =?utf-8?B?eWJzQ2VscTJmS09zeVQxQ1VER3lCazFwQUQ0V2pkV2NOT1FIRjRLaEp1QmNT?=
 =?utf-8?B?UEFCa0I2ZGNMWlUrOFBaOXVZODgzNVBLelY2cDExY04zZVNiZ1kzTk52dHdk?=
 =?utf-8?B?OHl4U2dSNFpidlpBWmlmZzl2emZsQUZSajh4V2RZeGZvTi9WZmpMZ29IaTZS?=
 =?utf-8?B?SWNNeXI3S1VCVjMzeTRZNVdiSWlNS1ZKK1lXUkQ0VHI3WUJndlE3SU1qOUh6?=
 =?utf-8?B?dU03RHBlQnUvYkZvL1MvdUdwS1owRkNJdUZ1RUdIVHJCR21HdFZUZmRNWENu?=
 =?utf-8?B?K2ZvczltbEZXWXN5YmpoaVR4RzhWSy9DZ1F0NVp4WHdKQnFidmdTbkcyalNn?=
 =?utf-8?B?bXR0dTZtaWJsTFhTalJpbDhWYWg0ajl4NVBidlNoUG9kdlBMSnRhbTI5RDdP?=
 =?utf-8?B?bys5Z3J2NVRBOHhwYlNabWhjRWVUa3lKa2o0T214VDdBRGtaZW5WdDZYd0Mx?=
 =?utf-8?B?VXJ4cVh6aUUxZyt0RWRrNXFRTGU5TEx2Wkc5MUNTWlFCeUdxNUdLYkJpQUpC?=
 =?utf-8?B?SnExK0pmdlZrSGxHQ2psYlBMZEpOblhHODRJb3M3WkRJSWdxVHJoMEVvMkpT?=
 =?utf-8?B?SGF6M2x4Y3lUUE53YVVIYUlUc0gzZ2pXVHhEQmxNS2dFNE5PaFVpUVZjbHZC?=
 =?utf-8?B?OE16eUFDemI1NHdFWVpkUnhRZnRYRTBjbHRqc3JGdmF0eUFDOVNMdmpVTHJ2?=
 =?utf-8?B?ejBTaXU0a0tkMFZOSnF0bEEyeDFaeWx0NnBYTmcwK05kVHJkTkNXZGYxcklV?=
 =?utf-8?B?VXRNTHBKYWp2UmVEUXlQd0ZFQ0R1T1AzQjZPLzRNNW1MM21oSEZOZnA5K1F0?=
 =?utf-8?B?Nm5oNitad1hyV01VQW9SV25zczdWaVNWR2p6NXFndHZIeTl6SlZYa25ERDdU?=
 =?utf-8?B?d1lWNENDeUZ1YmVDNTBQRVljS3dGZ25pT1NKZzFLNU1hRC9xTHpLMU1hbkg4?=
 =?utf-8?B?YW1aOURRVDkyN1lZd0w3ZWM0MFRLeWR1L0UrTnNLRWdyNnY3OS9DRldFOVIv?=
 =?utf-8?B?NHErQnN6WWp0d0dMYk53bTBGWFN6b0xkWUpDek5uMkNtTi9yVU13cC9GOENk?=
 =?utf-8?Q?/5KwfRtRc5qWIRVEz0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93ec704-f59a-4b99-f6b6-08ded823d1bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:22:28.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBIhMumHU6WkGw5quEdx29Up6HyejHT3leXeEQ534e+74okDtLr/PoFAPuBQm5rp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

On 7/1/26 18:17, Timur Kristóf wrote:
> PTE_IS_PTE seems necessary for handling retry faults on GFX12.
> 
> For reference see:
> amdgpu_vm_pte_update_flags() that explains the problem
> svm_range_get_pte_flags() that uses the flag on GFX12
> 
> Also add NOALLOC on GFX10.3+ as we don't need to allocate
> the fault handling PTE in the infinity cache (MALL).
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 32719f31b6c9..a915d061085f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3044,7 +3044,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	}
>  
>  	addr /= AMDGPU_GPU_PAGE_SIZE;
> -	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> +	flags = adev->gmc.init_pte_flags |
> +		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
>  		AMDGPU_PTE_SYSTEM;

That doesn't make sense the PTE flags should be adjusted to the device specific flags by the callbacks.

>  
>  	if (is_compute_context) {
> @@ -3054,11 +3055,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  		flags = AMDGPU_VM_NORETRY_FLAGS;
>  		value = 0;
>  	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
> +		/* Don't allocate this PTE in the MALL */
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
> +			flags |= AMDGPU_PTE_NOALLOC;
> +

This doesn't make sense either, mall allocation for the dummy page should be perfectly fine.

Regards,
Christian.

>  		/* Redirect the access to the dummy page */
>  		value = adev->dummy_page_addr;
>  		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
>  			AMDGPU_PTE_WRITEABLE;
> -
>  	} else {
>  		/* Let the hw retry silently on the PTE */
>  		value = 0;

