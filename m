Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFA4C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 00:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E11A10E6EB;
	Tue, 30 Apr 2024 00:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nh/3jeZ+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C35F10E6EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 00:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4b89lv6d4L4YLlYSFWPwTdQNzz2aXt4h3IpaBOyItGNsFlycS/8NqdBayft+ttJ4H/vJ3mgMNhQshULqWLVCJ4x+uFRGTkI8sYBvzQyqUkni9TXxv4rgX2Iez0ZssL5HN0wu3PVlb4nx87OB+ONpJgPTc1E0ZoAGwxYHhCNr/FL/VK53SHf0hwNp7RGpQQAOq1t7EOL9A2sVMhOukllnKy1lDfRHmu9uzIHqdk56W4U0Y0ucp4P1Q/AmfLA9deCj+crZIEpnVuf6xSW7J1FJ975SWOEvaqHwfSqIXoqj3KgOtki9rtJ1DE30PqKXenvhgeoi6/jlPS27iC9XGMvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WykWQTAMWXxk5JDi8sb94fOGkaImzATkxY+/XErqfVE=;
 b=ErIcuSmDW2SxMV3zmgyXfKPMWqIk6FF9I+FHvTIAN193Gfz7bCSH2L0Xmy93hsYaZ6DrKd0KmV9Gva7Lt9YNj7HlFxViBZGgKph7A/0oePHgv4Yhlqw+jbTbH7NTeyF7J4Fb0noA0OzySg1W6fEcIKhTqHM0GtRdq7WWHNfV6k+XR9/AWfmIIY97ETTpA4iSkGkSMIhbJl3DQ/rI7HXwX9vHmqYoq7vKl9MYFYUAhXb2XIV5okFBvVSVKw50fOdEaOYN9Ofn+MBkZ1l6V7voRQ8N5ZOmFdzqFfRj1GzvmMguZveVwfMjxNrMKGwn3WsdBVY8Scv5JeqcmE0RwLq1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WykWQTAMWXxk5JDi8sb94fOGkaImzATkxY+/XErqfVE=;
 b=nh/3jeZ+MjXWjaMHIza6YYs/EArDWXL9dP/zbIDcaVjN9in6/Udu5PLANknEfN4/D6OCHxsAAoXYanIyXOCRY9C7guNxlXCAb34iglDhPWdpaj5NrR6Y8i5SMc0vAInN1gZcNpb50BQHgEhOlk/+/8PNjcbKnqrIWy4Qk+Ju+U8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 00:31:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:31:18 +0000
Message-ID: <08145e84-ab41-428f-bf0b-406c61aab33c@amd.com>
Date: Mon, 29 Apr 2024 20:31:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240429164707.49196-1-tursulin@igalia.com>
 <20240429164707.49196-2-tursulin@igalia.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240429164707.49196-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abdb382-0892-4cbb-3a22-08dc68acd9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXFNSzN3RnROcEdRQlRXODB2SGJOUFpxalg1UDcyaythTC9vKzdTNGlqZzRE?=
 =?utf-8?B?U3VxaGZOWU5zUTM0bERJb2oxMEt5ekhWRjFEenBaZmtGczNaMW1aMHBTY1Fv?=
 =?utf-8?B?Z2gySHl1REp4eEt0aUprQi9HcEhzdTZyR3AyQnRIeXlpeW1Sc3FqOFNkT1lL?=
 =?utf-8?B?Vml0L0R3V04xRmU2VVpZQ3dwdEE4d2tVTjFGZ0Erd1QwWXZQUkNwLzUxZXcy?=
 =?utf-8?B?UllDeDNCU0x3S1o5YllaQVI3OVo4QkVQcHdNczByS1E3S1ZVbDFMNmRqN2k4?=
 =?utf-8?B?VVMvMGtNVmxJbzBwWFRaekpQRU1WRVdFb2srcGhoQ0M3TmdyLzl3V3BoZHB3?=
 =?utf-8?B?UUo4d2o1OVdUYldrd2MyVzlDQUJKUGNrdUI3V2RtaDNLNEFjZGJTWm9UbFlH?=
 =?utf-8?B?TURwU2hCMENtLytkVU9EOEVaTlZIb0Y2T0JXeHFQT2tPSXJaU00yRGZLZ1NE?=
 =?utf-8?B?Q3ltbGlhajhmVFJRRDdVaEt2QXV2MFVxS28vR3drUk1IY05tN0tJMFA1Y0Vi?=
 =?utf-8?B?TzBGSHlzWXJLd3IvWC9IUStCQWJqRXRwMGdJR3IwQUxUUCtSeFZaem5Tb0l0?=
 =?utf-8?B?azVjTDJMYlZJc0ltMm02dUtDbEJHbC9BNjZiTUtwREZNTEFDbEpCaE0vNTR1?=
 =?utf-8?B?NUN2Z0RrZHR3NWNKbVQzM04yZHNKV1M3VzF6WjRaQ29YM1pxcUkvdzZseU81?=
 =?utf-8?B?VHZoSUZnemhPOEpTMDV5UVo3TUFxa21hVFFkZDh1dHVNUytHeFB6dVd6ZEU3?=
 =?utf-8?B?aFBzK1FMMTE5MVZ5alJwaE9mWVU3RVAzdHV3VVhwQVlDNW1qRGNNbExNT0pS?=
 =?utf-8?B?K01jMGJJYWpPTGtGRFdXV0QrWk16TFFSUG9sVkVBYTA2dHZsbCtwMXkxbXhT?=
 =?utf-8?B?UFFCdjdsQ0N0MncwUVFGTngzK3l6cVQxREpKdHZuSWRsUTluQmUrZVpnRnQz?=
 =?utf-8?B?QW83Q2YzSHJReDZZZC9mTE9Qa0p5dWdHNDc5RkhvR0RHN28rbTZoVkcxeldY?=
 =?utf-8?B?VXI1SmxXczN2ZmlYTHdMbGlpYkVLVldGOHMzYk4vQlpiRmxZZWtqcXozM3Rq?=
 =?utf-8?B?VGptZGp5eWNKS21HaUNzYVBITDdzcHVkMDN3V1pKVnhrRWcvSm4xVzdYeXZm?=
 =?utf-8?B?YkVFY0JGL1dNRnBtYzBzUjZNMWRXcDBkRStBNjRqOFVRUWRlcE1FenRnbFI1?=
 =?utf-8?B?ak5EaGoyaE1rU29kaS9Udk8xcldHNVN3SGx4RDA2SHdFYmRTN21rY01FdEV3?=
 =?utf-8?B?b2l1aFd5MGpRczBnMXU2MFB5ek9XWlVxV3FlTGpqOUJZUXJGRlEvTmIvTkEw?=
 =?utf-8?B?VGxPYWt4eEdrVXN4K2dwd2JHUXNvSmFxcFBXRktuOHVsWGdNK3JQR1RCMGs5?=
 =?utf-8?B?MEVRaVhKS1BkQXg3aGgvYUsvNmc4TlYreTY5K0ttd05FZlRabUsxK0ZTS0dr?=
 =?utf-8?B?M1U5dVk3cHJXVm9OL0I0cHg2Vno3UlU5UG0vc1AzYkp2WS9oeXgzbmRod2tT?=
 =?utf-8?B?bTdWUEwwWVZYajlmZjhoRnNDQ0FPVUs3emZVQTkrRjk1cEljMENaS2p0WDRj?=
 =?utf-8?B?cEtkVjUwQWo1WU5PVE9zdXJuRGU0S3NhY2VOTWpCUXFxQVdDNjlNVUxCVHcy?=
 =?utf-8?B?VElwTEVZWUxKR0JLa0lWb29JMXA5N0RoZ0pIdHplcGFSQkM1R01HL0N6T1F1?=
 =?utf-8?B?Z2kxcmxnalZDOHoveWwxcE5mUXFidVlzUnJUcEpZRkFTUUU5aGtWb0dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elY4anZVNUlqQlV4OEVqRFVEVzBBc3JXMWVJZ3FCM3JaRVlSUmxkL2VRb2dD?=
 =?utf-8?B?Yk1VVVdRK1Y2QVRlZnpNemtKT2R4c01SN0xIaGZEV21UU2Q4OE5DcHVCckxF?=
 =?utf-8?B?WnNrelZjaFh3OElaMU1wSzZUQTMvZWxmanpqREhDWXhrckpua05PQ2MwL1FH?=
 =?utf-8?B?VU82ZkcxZU5CcEp5cFRjL0dNNDk2ZUlya3kvQldwd3JibUdoMENaRFI3ZGdw?=
 =?utf-8?B?Z205WDFUbmxOZVVnY1AwbUJ2M000QWpyRWI4V3laZXVDdEtMUjhaNWQ5YnlM?=
 =?utf-8?B?cStZK1gwL0ZNN1QwWHhlNjd1OVVuckZtdDFlNjB2N2JDaEpqU1JLazdKUWRC?=
 =?utf-8?B?eWplOWVMQzZLNnFzdGZsMzFkamVoZXc3QVhzNEJLaGs3NmUxT1dZaXhkczRp?=
 =?utf-8?B?NlVQSWdwelNtOFdieG5raE1TSjhnNlZYM2FicHErZy82dUhNT3c4cWxrYXEz?=
 =?utf-8?B?TGxsVkpUcE9lQUFSTk52cHZEeFVTYjZNOVd3UE95bUN3dy9YQU5Qc3ZNTWk2?=
 =?utf-8?B?VGJtNkYzYnJlNGZzbEpXOHdSSTNDNFoxSGhESlVWQ1QzbElrMmV3VG1YakVG?=
 =?utf-8?B?cC9HK2lDYjN1dS9UZXJzVURCT3MvMGhWakFYeE5uUVRmNWp3Mk9od21JUTh1?=
 =?utf-8?B?UG5WYVMyREtCejFxcmhSdWxpNllSRHpMWkpZejlsUU1qelNTTkpKSVBvdGsz?=
 =?utf-8?B?dUZ5VFF1Tm1MZEJQblFMTFNXZjVBUHhxSmFzWWwweEo3WnNkSk02TTZsYXYy?=
 =?utf-8?B?Q3crSWpwZ2lkTWFNOG1HWmZXWjVHTGZ2MzVFQURRc2Z6eUpOOTV1UjNQY0V5?=
 =?utf-8?B?YlZoZWhiVFhNZldmcTR2VjRmMnNoMGdqQ2FpSmwvaUNDTnpMM2tteHpWa09a?=
 =?utf-8?B?d3MrWjNqVnNINTVhNWJBeTkvYXhuWDVmMkEwYnczWkl4Y2hPZlFVam9qSmRq?=
 =?utf-8?B?aXZ1L0lTTUx1cWFtSHRZaE56VEo5NVRpS0x3d0NaY0o2RGFURTFwTExvL1NM?=
 =?utf-8?B?T2pvWjZQNlNpOHpiRys2bU9Jcjd2Zko3eDlOTzgrSXAvK1IvbUlRRmhpZmNJ?=
 =?utf-8?B?Q0E1bXlFcUxucFlDNG9UQUhTMjB5MzZaYjJJcjFGRTVoNlMzRUlwbHFtays4?=
 =?utf-8?B?RWJkRU4xK1hXMUMreWdtVU43TngzTFdQUnp5KzVzOUFMRGRDUVdwVFBzL3VU?=
 =?utf-8?B?ZjVJdm9UWVJIcC9rTk51Z1FvTmNQeThXMjQ4MXB1QiswWko0R3JwVkt3OGVY?=
 =?utf-8?B?T0kyVGozUnZiSDZPWGw0eTEzNS9Lam80T21GakJqU2N4M0cyZjZJd2dpcytU?=
 =?utf-8?B?T04rVDExakVLSU5qVWR6SDhTNmhKZG1hSlFsUXNnT0UvNm9tRXhheEZYMTh6?=
 =?utf-8?B?SGo1Vm5xeXpmUkk3NThsNnhTdkNJQWM2ZW9Va3FoWDBvc3hzUTc4VWc3dEt1?=
 =?utf-8?B?MStHd1Jla0JSanBoZ083Rzdya0phZ3ozWkZnbWRXbDYvZTFZVmZJVkpNQzJ4?=
 =?utf-8?B?RHFPSVBlVVlIMXVXcG1KcUVKN3J2WEZ6TTc1SElmODBhS0E4Z1Z2anZvaHF4?=
 =?utf-8?B?MG1kYjJ3T3J5MXFNMERDejA2aHZWUlVCNGxlVzJGODNTYWZNQVhHTTU0TnlK?=
 =?utf-8?B?cVAwbFlQUE9CUEN6eWdXWW1LRnRtald0VzhjRElmSEFudS9zQ09lY08xMktY?=
 =?utf-8?B?U1F0MEgvektwNXdySEhZOCsvYmloamN3UUFQOGxFTGtVN1ladTdmVmsvQUZm?=
 =?utf-8?B?RDV0UWsxWHhJVWJnMzBYTEQzeUZVN2JxRTg2eVYyS3dETzZKN2Z3eUthWUF3?=
 =?utf-8?B?cVh4OEkyYzIyTFk5QS9qMUpkMzVtVmIvNFhWSTRRM1BwQ0dSbGU1R1RFM3R2?=
 =?utf-8?B?NVpyY2hxNmRmMUNoZll2c2hZUVhkTWhadnltQ0djNVVSWnVUcDlSalQ3R3Zz?=
 =?utf-8?B?QzcvNmlOOEZPOFRCZlIwbk1Ob2F3dUU0MzZ6RWhuN2tHTHJOem1aaFVSSXMx?=
 =?utf-8?B?M3h6SE9xYWRrbGo4SHVwNVdFMGtMR1kwUHpmczR0YWVlZkFkSmx1bUdUWHoz?=
 =?utf-8?B?dFdHdDJNVGRBVzV6U0FNckFrR1RVTERQV3NaTXBzZEs3aTM4WHIxVjZRYStu?=
 =?utf-8?Q?SUsW5bywffWOSvflgDGQOWI5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abdb382-0892-4cbb-3a22-08dc68acd9dd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:31:17.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJE9kINj6jn1Ji8r1UcF3iSeRHur2Rpa3zmtfRQU4psel/GBoqTwUCCloczy8U0oHFO2A6Q3Vp7TizPKBTVH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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


On 2024-04-29 12:47, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>
> Simplify a few places in the code which convert the TTM placement into
> a domain by checking against the current placement directly.
>
> In the conversion AMDGPU_PL_PREEMPT either does not have to be handled
> because amdgpu_mem_type_to_domain() cannot return that value anyway.
>
> v2:
>   * Remove AMDGPU_PL_PREEMPT handling.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reviewed-by: Christian König <christian.koenig@amd.com> # v1
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I also ran kfdtest on a multi-GPU system just to make sure this didn't 
break our multi-GPU support. BTW, I had to fix up some things when I 
tried to apply your patch to the current amd-staging-drm-next branch. 
That branch was just rebased on Linux 6.8, so maybe that's part of the 
reason.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 27 +++++++++------------
>   2 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 055ba2ea4c12..0b3b10d21952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -165,8 +165,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (r)
>   			return ERR_PTR(r);
>   
> -	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
> -		     AMDGPU_GEM_DOMAIN_GTT)) {
> +	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8bc79924d171..eb5bd6962560 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -976,12 +976,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   
>   	ttm_bo_pin(&bo->tbo);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1280,7 +1279,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   {
>   	uint64_t size = amdgpu_bo_size(bo);
>   	struct drm_gem_object *obj;
> -	unsigned int domain;
>   	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
> @@ -1290,21 +1288,20 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	obj = &bo->tbo.base;
>   	shared = drm_gem_object_is_shared_for_memory_stats(obj);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> +	switch (bo->tbo.resource->mem_type) {
> +	case TTM_PL_VRAM:
>   		stats->vram += size;
>   		if (amdgpu_bo_in_cpu_visible_vram(bo))
>   			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> +	case TTM_PL_TT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> +	case TTM_PL_SYSTEM:
>   	default:
>   		stats->cpu += size;
>   		if (shared)
> @@ -1317,7 +1314,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			stats->requested_visible_vram += size;
>   
> -		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
> +		if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
>   			stats->evicted_vram += size;
>   			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   				stats->evicted_visible_vram += size;
> @@ -1592,19 +1589,17 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	u64 size;
>   
>   	if (dma_resv_trylock(bo->tbo.base.resv)) {
> -		unsigned int domain;
> -		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -		switch (domain) {
> -		case AMDGPU_GEM_DOMAIN_VRAM:
> +		switch (bo->tbo.resource->mem_type) {
> +		case TTM_PL_VRAM:
>   			if (amdgpu_bo_in_cpu_visible_vram(bo))
>   				placement = "VRAM VISIBLE";
>   			else
>   				placement = "VRAM";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_GTT:
> +		case TTM_PL_TT:
>   			placement = "GTT";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_CPU:
> +		case TTM_PL_SYSTEM:
>   		default:
>   			placement = "CPU";
>   			break;
