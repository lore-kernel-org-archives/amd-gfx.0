Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5EFCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 02:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA774112D0A;
	Mon,  1 Jun 2026 02:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlnCN+8E";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC85112D0A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 02:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeNz53hBzFONW5QekxWisltu+KaXNk/XPf3LDnB74BxZiQ3WmaMYkA895ovaYV1j+RVLKKW91zM0difEc3ntK1dfbx2mfgVOtKbaPkBmRTr5fZ3GD9d8JKpi/90MD+nbfu/imG1Mihj1uyFP33OOhKuxx9k3nm/JmFUl9BeZ5UrjRxvhaNq9PAnNuFwc/AsqKO816uw482zQjHT0CdQCH/BvM+pCwZQYePtmYt1aA4HDMLTYWT4K7i6VIcA5U9C2zYDbCAF/8xq8ka0mWK/t5ZUsm3z4mPW04Jzrcyinn/Xk6QNBxs6TXPB5fs0br/s93NXkdHHdd11HjLlw08oSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w5MCIFd+ATZRWYejNK3b1d2y0IvpawVR6vOruaXyhc=;
 b=EGVf4RKHolNynlyGQ9K6SwdcW9uCbAwC43auYa7S20I6jgOXf0CHYLygcWBdNGv1xGPH5zZCOA89xBDKXJirEm8tLmBqjYLcj5l5bUUQumpsPOZ75DX4WEpoSd7HTxC+zl60do6TRjA2K4tQwxi9jvPWLhQEYW3XqGbg93tNkFp0p+5MPp/KihvOd5wtobjtD/6gdorjDIebO1dEnac/bKl02LULiRCA755vbZXCvyPINF2vw3fMNZMJ+lZMGsIdeHqkU1sU9QVcCIUJgXq7MFupphId7gcrVvcdbcDLa+Vq9Rj3kErhOo7BJHqWz8pSHnp6CD1nvgy+yHpNrayUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w5MCIFd+ATZRWYejNK3b1d2y0IvpawVR6vOruaXyhc=;
 b=vlnCN+8ECBWYjBrGWQIVp/6MkcQooLCns8srh9eXL7/53VNisbAXI5QS500nRMnH1Hma8ALTSLR3Yo9zWPtrrnf+gle6BoXcUtm7qgM9bQ37+yHMzE2wSJX2Qap6wTREUdQoSWlbSGk6cx7iDSi1U4IpGGPb/0QO9eC5HpfnsoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 02:46:52 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 02:46:52 +0000
Message-ID: <b71a9b5d-31fc-4d7f-b5b8-7e2dadb65f39@amd.com>
Date: Mon, 1 Jun 2026 10:46:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re:
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, natalie.vock@gmx.de, Philip.Yang@amd.com,
 timur.kristof@gmail.com
References: <20260529114031.3714-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7527ed-0b02-41b8-68f0-08debf8808c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|5023799004|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: +uyWVfS8WFd7PRkO+m8DHop588tX/0hYTBKnbIB1JNBG+cMf0EZACeW0JcmvZR6RWmQ/5D/9bNpXivdC5XxHKLHtV5bRUoBg5BIhdJHK5f8eqFpvuCkAeyNLCjxj95ZFFYmAPOumqZIiT395FWCAxT1cdLSwBHGTJUQa/FWrPkvTojUolxGiAWUJWmYsTKxlL3Na/MVZcufnPu5aoEzsFqs6/imAYLR3b48lR7xZBaL4ZN0PqVzPyuCFAMIF9ZCFvoJSkBL5Ch1EjTPSGs4ps5+O3N7BSIh6vmmHkpVNmYNYiDzeG7E1xFARnVouW+Q7B7trLbl0UlT0xhIK029iovKPAvFFD9SQZxmSMDTsyasKjPxOiG0Uzyf9MsFP4fs7bDV1T9udCRc7C/kmHuBAvbBHuUU6Aa9bcmdOImKSk80Tt+Bs4Pv+/A/CVlqvIZsYTlG7HpKzhTJyMIwdppnSk18OMoVPcQmWC3OX9DWwVEDsWQpZE0DA2GvxElb50efF820iNVXJHzTfj7BvUovR0u1AtAUXnpfFGDosJ2ic3stMAiVlwR22dYJ46vg1wWX6HyIOre41bk7FyGs/UeFYxSQc1SRMev1XJy5O6uiEB/0da/9kmvzyaNhdOiqGcwDyRyYjeV3SO1WUwxocO0HPYl1ttiWSUSEI/ZERG+Q8vacaCaR36yseJAyUAykyUBHp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(5023799004)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERxdld3ZDFVUVhtTDM5SFc0NC94MHhPenBjbVJteFdmbmlCbXhSNkhHQWQ1?=
 =?utf-8?B?SXRuUTRGRHFVOTNvbWQvY0pFSGJvS3RsckhEUTIzMmNURjZIRVBvcFR4OWlP?=
 =?utf-8?B?TTZta0wybU9GRjlhNVhNTDNpVEtQaVI4eGFuYkRJZnBadGdhbW9uOXZIaXZZ?=
 =?utf-8?B?TEhzZnBIdnlKWENIOVVWWHgveXAvT3FGYXhaYmNzbkZLSG9FN200elhqOUV2?=
 =?utf-8?B?Mm82a1JqQ2NDNWlsbzRneFQrVnUybDNaelhtbmZwZm04VDZjQXhTaUtEV3No?=
 =?utf-8?B?UHdVa09NS0hiYkJ1VmdQZnVHelo0Qm4xcklpZ053K3d5VHVrNUU4Tnk5RjZy?=
 =?utf-8?B?cEpRUmVrcTRQOWh3M0VFQS9jbUJmbWgzS005b0VzdEFBdTVhRGY5b3QxUkU1?=
 =?utf-8?B?SnN4R3BoWUZOVG5YZ0FQQ1QyZ0J2UXRtWHJQTE1VV2kxZ01xUVJRR0hQRmcv?=
 =?utf-8?B?cVNUQUd4MzJIMTJQU2ppMWtNd0RXUXFiRTk1UStDenFoRHVhb2R3Z2FndGl6?=
 =?utf-8?B?ajhQR1JtRUlMeTNtL1F1Z2MvRWZySzdKUllGQWRPbWQxMk5NZERIL0VEY20w?=
 =?utf-8?B?dUZ1blN5cUZtZjFqVTZXSG5Fc055d3VxaW9raGVqQXFLcTIxbEgzTEhoZFpW?=
 =?utf-8?B?TXYwTm5ZTUMvSVFNQnBVcU1BUVg0REIrT2lsZG13U041UnlwanZISFY4NjVU?=
 =?utf-8?B?RTNnb2ttQUJuTWlJR2RLKzlLODk4MFBkM2FuNzZQcW10RVZVZmhDU3dxTVlF?=
 =?utf-8?B?VEpZQkZBTC9oQnN3R2FScFpvY05kZFkwcU9GSHRIWnRGSFA1ZmJoSHJLbkVm?=
 =?utf-8?B?RkVONUlMRU5JdEcwekptTGtCMC9hcFFvS3o1UG1pcDdnSHVURzhCNVlSazM1?=
 =?utf-8?B?aW42eU9RV1ZtbjFFR0wzRTkwQnMyT1NkOGJkdkFIc2p4SjBPdVNTL2kyODVr?=
 =?utf-8?B?WFJRT042d0tmMER4aG92YlVDTFQ2dTRwOVVhWWRJMmJ5dFNtRFNmOStCMUlj?=
 =?utf-8?B?Mkl3SG13MnpZMG1HbVRWZ3JPWitBNGwxZFZoYVQ5N0F4TFdPSGE1MGFrS3VL?=
 =?utf-8?B?eGNuOHNtU3FkMjg1V29jd29qT0p3Y3V0cW5hQUlqbXgzN2FCdHdLMDNGVUdN?=
 =?utf-8?B?VExlLzdSeXZDYWpweG5tSWREdGc3K3RmTFduZnlwamNtR3dpMWk4YS9wSDZv?=
 =?utf-8?B?d05ldjN0Z1hyWnNCdWlnRGpETzNXZkwvajI1bHh0Mk9FTzJyNkpmTTR3OHlX?=
 =?utf-8?B?UlJjVmRDZi9jaS9UcDM2b2FkeWpKamw5cnBRc0pTN1VzUFRmMFVaQ2xsWVRH?=
 =?utf-8?B?VllCUThUNGlTb2kzUnhGQk9RRWlRNVpYUStIQUZCNEo4V2RJWHRreUk3cnVH?=
 =?utf-8?B?SUdWVUtoc21HTUxqUDFPNmFVMHl2QkMxamU4bnN6VjF4b1docGpJUUVUOW9j?=
 =?utf-8?B?ZVpyejFFRWtQV1dYTEIvSm5MWWpmeHV1czdOVmdLSHZaY2hKQWhRTjJVVUY0?=
 =?utf-8?B?SVRrWFpVTjNGTnd1d1BLK2Y3emZ0dk5hRE1tSnVpY21qMmRXL1Vwc3lvcUp0?=
 =?utf-8?B?L2hjWEtxRmlDa3NJVWZOUWVlMWlDc3ByK1NsUC91OU9QOTh3K2Y0bWVsNXNn?=
 =?utf-8?B?bHA2RldlTU90MU9SWlMrb1Z2YUpSVmRZeVo4dDNEaHFiL1FjU3dGaFZmd3A5?=
 =?utf-8?B?VE5BUDM1djBORWZZYmJlOHRRUDFiVU5KUTU2UG5MaFBXVFhLNHVwMHc5YWFC?=
 =?utf-8?B?Tm1UWW5JcEpJUjlab0ZHdkdDbW45VEVvWkNJaXhkV21FdjhiK0RaTHluUnVs?=
 =?utf-8?B?T0gzdTgyZjh6SDQ5MFM5WUVEQ1kwV1dZaGNFMGc4RXp5YldHNm52NHhrT0dM?=
 =?utf-8?B?NkdPb2owc24yRVNDd0gyYnV3K0wxdDVzNWRPMHdlNDNXMThFQzhtWXQ0QU95?=
 =?utf-8?B?N1hpampPc2YrV1gzWmttYkI0S0dTdG5WaFE0TGdaM2lMVzdHZHRwdmhjNkE3?=
 =?utf-8?B?bXo0bHZOS2VXOUtYb05jczQvYmp3VHlwZkdqaXZWNjJIaEVHbzI5aWFlaXN6?=
 =?utf-8?B?WkZFK1Z3Nng3SkFGTjdqN2QwYW9HU25lQkNjb0N0MkYyZllvaVhKT1dFcWtK?=
 =?utf-8?B?UUxHRGlvc05DcHVybUM5TkRnTVlGVkQ4WVdRQjFhYUhWUVFLY044MzNJdmZX?=
 =?utf-8?B?Qi9SRXlNb05wTCtXVHlGMUxsVEQzdjB3ZkJibFl5YXZpQk8yRDRXWk16TEMy?=
 =?utf-8?B?NE1nSFRUeEt5dkxTakpIUFJCZndyL0RpYVFQOGp1SVVnWXRlalE2TUtoMGla?=
 =?utf-8?Q?0fcnwkDblwU1HwDrov?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7527ed-0b02-41b8-68f0-08debf8808c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 02:46:52.0176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70vpGxaaHXBMvVEdzOmimdtcWGcCqdb3BKditYMcTjmUAFyv7b7lwvc1eZVytIf445RXmTHmE/VRxfGg/RIF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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



On 5/29/2026 7:24 PM, Christian König wrote:
> Hi everyone,
> 
> this patch set aims to fix a couple of problems we still have with the VM, page fault and HMM/SVM handling.
> 
> First I rework a bit what we have on headers/defines for the suballocator, especially that the right GFP flags are now used for GPU reset and graphics page faults is important to avoid hangs.
> 
> Then I rework the VM handling, especially splitting up the amdgpu_vm_update_range() into an amdgpu_vm_map_range() and unmap_range(). The later is only meant to be used for MMU notifier/HMM/SVM use, but I couldn't come up with a better name.
> 
> And finally it fixes the problem with KFD SVM that we can't properly allocate page tables under the SVM lock. The missing piece here is to remove the SVM lock and rely on the eviction lock of the VM for that.
> 
> Timur & Natalie I've put you on the patch set because I know you have page fault patches in the pipeline, it would be nice if you could apply this set to amd-staging-drm-next and rebase your stuff on top of it.
> 
> Honglei and Philip this is basically the pre-requisite work I have been talking about. Please integrate that into the new SVM patches and re-test.
> 
> I've only did some very brief testing, so something more extensional testing is clearly a good idea.
> 

Got it, will integrate into new SVM and retest.

Regards,
Honglei

> Thanks,
> Christian.
> 

