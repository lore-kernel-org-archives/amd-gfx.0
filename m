Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B34CCFA1B
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 17:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1612110E988;
	Thu,  6 Nov 2025 17:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTtYFHNC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AF10E98B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 17:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnsWP6ury4L0pMhWZ7HeC3pGQvTqFnHCNEkeP1D40U8sYg+5JkBDmOXa0T2HWMe+sG9ru5Qqcl4Q3juYKX4M7DK7dJRdzXs0CKYBgIjmuD0SdTVZmITTrTJtEjm+FivFPNOuk+8OtZ0RyD6WuXHp/Vi7BmFCmgiTPhXFHjv56xcfFk0bhy+2QbN6kHF4mA63FruKI1KXwE6PkLtdZSjTP4DxdU7qyOZyZQ+r+dTwS3B9FCStQCq3kk2DXOFzFcAI3BliLv72IiyS1YZpY4dmnqI8s5TTAxoRlfbYOSFLMUiCUDm/b4KxzX4W5Iu39Lu6wIdI70hgJyTeWiG2JgMVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s00IxX2tvileDWrBBvhcjpoNGQzKHUWjTRPT1r8d8o=;
 b=ZwSrcQQKt7TUvW3VhS3Sa2IF6c8HO1CT/8YkYHxXHeRmyo5n3ZJwsc7ISdDtxRDJTKpa4PnsX8GC5jSjI3u25Md7JD1+paQSpwIN1+vfpkwlBF0o2i1uyFzYUaKRFOdr1txyDpSy6c1QvkVnHfSvR4cXRjbjda72Tsx7Mi2ScAwkjPaJGJ3o5jKIQ9WoSwTFSwCvNk95t3q88ukBcpTviHoG/rUga8X1qxrE2ldnRhVtvP9FUFUL24omZ1JkHYIfi3wfyqiVW9dMtWNB02Vy/t9iT/3Pe88vLJPl2KQbv1XvATqI5PdahuTWMFli2O4A6E74pmOq6O+UGBI6g8F2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s00IxX2tvileDWrBBvhcjpoNGQzKHUWjTRPT1r8d8o=;
 b=PTtYFHNCbjIL07BAJ2WwCIn9QwRW0l5zBmvfH4FBBGHYeiQ4G2638MNuCOjjrwuGF39bbj/pIr3kRf7CrXqENDLvVb2e1q9LQzuYfwDBJDxgUs8Ak4iwBvgZkglkHZdF46Duy4YHFh8GRuK8W4IH9axvaTVj7ujJWJs4wNLwacw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 17:07:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 17:07:39 +0000
Message-ID: <e8dfe7ad-8a71-4772-ba6e-872ff9f04982@amd.com>
Date: Thu, 6 Nov 2025 18:07:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable peer-to-peer access for DCC-enabled
 GC12 VRAM surfaces
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
References: <20251106170356.47238-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251106170356.47238-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 960582a5-2540-4e7d-82f8-08de1d56fda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1htZGdaQjhkTjZIRFo1NXdQd1JLMGQ4a2FLQnFZbUNoSXdRUEwyOE1vOXk2?=
 =?utf-8?B?bm1ZK1FURFNlanpHSitGZDF1c21TYTdJYVZsK1BTR0wxdXpJSmlMTXk3Y3Bl?=
 =?utf-8?B?aEVjNjMyQUJ5SFdrbUpVTmdVb0ZKK2w1OXp4UHdXazQ1aW1mTXprUStiUTVD?=
 =?utf-8?B?WjhHSnRqb2dadVFaNm9OY0pSME9jUGhDQ1kyNGlXZGlnU2hNZVVKZUZQS1pw?=
 =?utf-8?B?c0pQelFhUEtFaGJPZDY4bjloWDdxb1Q0Q3Qzd0tZOVNjd2cvaXExNnA0b0RO?=
 =?utf-8?B?Q0ZCWEVlVm5uWDFZZ0JPamNPamU0S3pFMHhXT01TYkNMRWFJRkk0ZU1ISll0?=
 =?utf-8?B?Vk9CcWxqajRKaVBvZlBMZk90aW5SbjNpdXI3VHZVTFlWU0NmUERTN0NzeWJ2?=
 =?utf-8?B?ZUw2bDdldnp0bk9TYjBJQ3NvTlhSUGx1YXBkMllaUnA2enkrRFFGQjkvWWFs?=
 =?utf-8?B?VHNabURmcFF6a2o4aFdzaVF3VU4rVFA1TmYzY1pVVkJCTVZQWDMxVXdjWE8r?=
 =?utf-8?B?RXI4MnRQVVB6L1I5TTFzcHVXNC9HK0t3Y3E5VUhQK0lobC84WldmNENkT0Zq?=
 =?utf-8?B?bzZHdzVjL25UZ0hNMUZ2NHprS0RJVnFRcXRUN0JMZU5mQ1ZJWTRubmZVT2k0?=
 =?utf-8?B?UXI2YzQvazNMQzRMVXdPZDZwVWdjZDh4UWdIV1VPNVViK084bng3TlJEN1Bs?=
 =?utf-8?B?dGlrRmlnanNHcGthcVpwNDVGZVB0S2RCZVBoWDZnbWZOdCtyM0xKWnNLT2Mz?=
 =?utf-8?B?Z010LzcxZFFwRTYwU2RWWlVzaG5SNjQycTBoKy9kaE1GTm1XWUIvZWF1ei92?=
 =?utf-8?B?KzNvTTZYSmRjczR2bGtqN2JKT1F5ZkZwV0dmaTNkbGFUY25wY0ErWDdkMndJ?=
 =?utf-8?B?ZjN2eHBEUnFtdEhBbDA1NU8wZmIrT1o4ZG5hR1lKeVdXRHFPQ0pMOGZncHBK?=
 =?utf-8?B?TEFMZEgrMWhCNGxVUmhwV0RQcVFoVzQvU1JRNGtjT2RBQ0Rnb0xEaUZQWlFs?=
 =?utf-8?B?cGk1a3lUaDRoSDljMmRrRU45Ti9mRjFhNXVEdFpITFZCZkw4czB4aDVpaTNO?=
 =?utf-8?B?bUVBRXVCaDJjN012RGZ3MUNKYzZSaFVQZFlXdU80SzJsOFU1TGl0UFZZckZD?=
 =?utf-8?B?MFNLTzJuSk1DZGg2VW1CNkN6WHcwRU53UzlYRmVMNFBqVUhRVXlMbEF1U1Bs?=
 =?utf-8?B?aWo2RlNZNGJ0a1p0aDVSWlcrenpDRzJwL3B4K3p4VFZqNFhBcHNIbnA4RU1W?=
 =?utf-8?B?czQ2cHVXQkV4U1ZOY09Ccnk1ZGlLSGZDRzN3bERYRVEyMVlpamRjRVYrVGVF?=
 =?utf-8?B?UjdUQzVOczI0SHVnU1k4U2VsTlNWcTEzUnQrdzN6U0RvOVVwWG1uSGJURTZr?=
 =?utf-8?B?c1M2b3U3cGtEWEF6dFBsZmpiV280ZHA4L3BBVkJ6aWxpYW1ZQUlrY29laWRF?=
 =?utf-8?B?K3VXbXh3dE9Qak96d0hhQU50aVRQQllEZ0FhRSt0dW5tamJsMHF5SlVzSW5Y?=
 =?utf-8?B?T2JxcHZPWXRUdi9JVElFeXFWWTUzSEpUZEkvMEZsQ3RCN0dYUklyeHJFNUxw?=
 =?utf-8?B?R0pKSURQSmJuQS9pU0FtWkJja0FXTHJiZXJuaXZPOG8zK2dheVk4YjNpenN4?=
 =?utf-8?B?akNadEtGZ3A4KzFWNXN2SzhrRnF2cGZGYzF3MFZ5cmtSVnhady9YZnp3bm41?=
 =?utf-8?B?QklCSlBlSnNDeEYyUFRycUpNaDBKbjhPbWRleFl6MURnNHlZQllMRnZuaXlS?=
 =?utf-8?B?YlNBZnQxYUIvcDZsT2xEWWpwU0JoQnFmOVQ3c25IY2JwZWp6dmZJMHF3VG8z?=
 =?utf-8?B?TlpKTHpORmtnSm0xb0RHZC9iRzkwY1M1eUE1dTg4Qk9OSE9laStYa0ltcTJ2?=
 =?utf-8?B?QjVaaVNXUkdaNmxTckNwNy9iOFBZdFNnendobFRtWEFGMElHYm5nNVBwRzVs?=
 =?utf-8?Q?UxaVTZImSjmcSRw/hn3jLQDTDpp95rtY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekh3eHJMSXZqYStNZFlyUzZBWE1ZZStHN2Q3L1NNS2xqVUdGVmR6QkZ5d0FV?=
 =?utf-8?B?akN3K1o5QzJyWS85QlpHbGxZaVEwZmtRWW01OWtidTJTSWVtTVFoZnRGeWxL?=
 =?utf-8?B?VmZqd1NQcHp3eVduUC9Od1Yxa1JJbVUyc2FDejluL1NyVWd2NFpxN0FveEZp?=
 =?utf-8?B?Y3Rlbml4eHN6MEs1S09PN2NPa1NLTittM2EzbnF3NlVCWGh5Q2N2UTljRXhQ?=
 =?utf-8?B?aVRObTZtOEsyVFErVFg0eG1EYUNsbDZ3cXBpR0VXUDRRTmxGSFdsbG5JZU83?=
 =?utf-8?B?eWhLeHhPUnMxYmpJM2J2UUVBT0tzV2ZKVzZOWmhaT2hCTjU3Mk03THhCY1pT?=
 =?utf-8?B?M2FUQjZIZWwvVFBKeDYzSnV2MW5QZGhXRTN1UzB2K1ZrcUhwVUkxUktPdWIx?=
 =?utf-8?B?OUcyZUpNNDJ1OEhhNzRXdTBpQUZaRTJQSUE2QVJ1R2FRSlBSeEg2dSt3c1Qv?=
 =?utf-8?B?ajhRWlVHZFVyVG1oWHJKYWp4UkFXbmxkaUU5Y2Vxa2VyQ0RMR3R5dTdpYjNN?=
 =?utf-8?B?bEVGSU1ST2EzSEhkeEdCMmxTY1YzZkdQcWIvUWtHMDV0T0FDNGhIUGJTU1l2?=
 =?utf-8?B?ekFpZS8xQ1JhU0ZFWHF5ZEoyTmZaUjRDWjdZTDUzOTFnNTFjMzFYK2xsOEg3?=
 =?utf-8?B?UWh3bDIxN3NWZENPNjY1cCtOdG53V2xzZjRFTWJiRmx2WDdSVkVmSjJXNHBW?=
 =?utf-8?B?T2xFblYrbkZFa09YZGhpcGtJTVJhMUZuREttWW5vK3R5dUNGUEdtamVIZHZD?=
 =?utf-8?B?Y0pIMllzT3RXODNxZ2dvMW5ja2tyMEJFWTBUSERzM0hacFQ0SmRvTnRmb1dT?=
 =?utf-8?B?VFkyL09GQmlYc1ZPL1RpTDdZQmJXNXV0WCswb3ZkTktHdmR1M3VselRGcnd5?=
 =?utf-8?B?bVdnTlFaQzBqWGt3SmcvSjJmQnVmMlkwNzBPZU1RT1VZT3lvblJBV21RQ2Rz?=
 =?utf-8?B?WDFaMmdlQTYvVWFJZGhZendPUFR6cDFFQ2JBZVdFK2k0Y3VvV2pMK2hyR0hM?=
 =?utf-8?B?YzZzVWZCUlZsT0ZoQUVYM0JmYmZvS05PSGc4TjBqeHRObFh2eXIycEc5ZzY2?=
 =?utf-8?B?eEM1ZXNPU2RsWS9TU2RyU01ERDlxbGZvYldFYUFacWRZVm1NK3RrT3lRcXgz?=
 =?utf-8?B?VWlacmhCSXpkZjI4S0JyMWNlbStLdTUyWHliRWphZ1E1Um5lT0hscWhDZnhB?=
 =?utf-8?B?STYzYWZZTGU4RWFTRmhldDdBU0c3WUJBZnpCV3FsekxXOUwxTGZmNGZoUTAy?=
 =?utf-8?B?Z2dSTHd3Q0h3OGZ5VGxnbFVmYVJxTEFMUDRZWktBOGZVM2xvSkFTbFJaZTNr?=
 =?utf-8?B?SlN6TDBOZHRGV2hHMnJuV2FOQ091WUZiUnplelNOeHNaR1NycmJHSEhUUC9v?=
 =?utf-8?B?dG95K2JOZmtQMkRrMmJiaDBXYXVZRi9La0ljU1VUUDJQTjJmOG9zYThsZFpY?=
 =?utf-8?B?NEZnVHJ6clBoclJiaVltNXA0bDFRbXV4TldiOUZLbWUyMTBhRXJCQ1h1MVlx?=
 =?utf-8?B?d0p5bE95VFhEbmp2cTUzc3kxdUU2RTI5K3R6ZnZXZWlzRlNEZ25sOHdXVkwv?=
 =?utf-8?B?QmdZZFIrWnh5bGpzTFN1MmNRMHpCK1RZNWczRTlDWWZjZXlZRjdrd1FJbzhR?=
 =?utf-8?B?VWJVbjJ5NVp3WFlKSVJLcHJQVi8xeC82WXlWTitaZGxpL2FyTnJMdGVhQU4x?=
 =?utf-8?B?TFlCRFpCOFAvOE5EdjZYNVdkOXFtdytFbE9UdGxmQXh0Y05SV29RZXQyVE1F?=
 =?utf-8?B?bXlhaFRZajNxSzVkNEprenNlazZ5NEpkMXlkdVBpYk5BVHR3dm5VNXRHVjN2?=
 =?utf-8?B?L3pJbWhuMGNtTndmL05EbzBBbWRQK0Y3eDlseFUxN1RTUVhiMUJjdERtbElx?=
 =?utf-8?B?NFRmaU8wYXIyNS9Db0FWcUZGdEgyaU1mRFBTZjFqZnVSRWgybE4wMFRpMlht?=
 =?utf-8?B?djZzZGlpdWtid3VWSDd0Zll2Vkh0bWpqNUc4WDQzVk8yS0RZbDJXQlZKL09Q?=
 =?utf-8?B?dURDNW9VM1YzbFVIVWNOOWNkWlFwSnF1Vm5TVVBVdVVZcEpFbkJpV0tQU2p3?=
 =?utf-8?B?aTNoeUVsTEhyT2pKRkx4ZUVPQW52NjFxbnhhblJJODNQOTNuSC9SVWF1cmxi?=
 =?utf-8?Q?PmzFrpOxELkF0Ylr4tuQPzKLp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960582a5-2540-4e7d-82f8-08de1d56fda4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:07:39.4251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+qu2cZ7xpchH43RqhBcMQJg5018AkPojzF0npriFl3oM/KveEtdNiB19JHCBaJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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



On 11/6/25 18:03, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Certain multi-GPU configurations (especially GFX12) may hit
> data corruption when a DCC-compressed VRAM surface is shared across GPUs
> using peer-to-peer (P2P) DMA transfers.
> 
> Such surfaces rely on device-local metadata and cannot be safely accessed
> through a remote GPU’s page tables. Attempting to import a DCC-enabled
> surface through P2P leads to incorrect rendering or GPU faults.
> 
> This change disables P2P for DCC-enabled VRAM buffers that are contiguous
> and allocated on GFX12+ hardware.  In these cases, the importer falls back
> to the standard system-memory path, avoiding invalid access to compressed
> surfaces.
> 
> Future work could consider optional migration (VRAM→System→VRAM) if a
> performance regression is observed when `attach->peer2peer = false`.
> 
> Tested on:
>  - Dual RX 9700 XT (Navi4x) setup
>  - GNOME and Wayland compositor scenarios
>  - Confirmed no corruption after disabling P2P under these conditions
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 9a0bce3ba24c..d2d31031f672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -260,11 +260,24 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  
>  #ifdef HAVE_STRUCT_DMA_BUF_ATTACH_OPS_ALLOW_PEER2PEER
> +	/*
> +	 * Disable peer-to-peer access for DCC-enabled VRAM surfaces on GFX12+.
> +	 * Such buffers cannot be safely accessed over P2P due to device-local
> +	 * compression metadata. Fallback to system-memory path instead.
> +	 * Device supports GFX12 (GC 12.x or newer)
> +	 * BO was created with the AMDGPU_GEM_CREATE_GFX12_DCC flag
> +	 *
> +	 */
> +	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(12, 0, 0)) &&
> +		bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC) {
> +		attach->peer2peer = false;
> +		goto update_vm;
> +	}
>  	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
>  	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>  		attach->peer2peer = false;
>  #endif
> -
> +update_vm:
>  	amdgpu_vm_bo_update_shared(bo);
>  
>  	return 0;

