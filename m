Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C0E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632AB10E81A;
	Wed,  8 Jan 2025 09:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SRWlYyly";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53D110E81A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 09:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoA5tZGXfN9rEJXzsu6/valIXapy2Zrsl95k4ByXpeNXOjJGnEPyr8C/N0d92QxekVBlc+wWYPAIRLNUv7sPUispM0f2N33wF8ttH0eiFznhd5J16sb+o3ibXfkgd3YAlqNrz4Rn7ldpQXvqD7E5HeM1IGkau50/dB9JTAIT3FcDrn4vaK1EraTHHro9CEd8XUjz9evXpukLiZjE3Ti7iyWeQf7ZwT6lJyXGhFSGy56WfbD8+UHQ37L9exxFrV97md+e0u+bfQJENDAOgdbIXwpvpH//gtmeN5UHBp3gNgjQVnEBZ3XLKWsL/OrUcmA0JUh2E+oGwjDx/GM7pKxzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaoVinNIjdtspK87W6vLdcB7NzVx/6+2xQ63AT8c8ak=;
 b=o0OGrSN+/nYyYXUvD1FNJqueo2Sy+iekJTbLlj173Di+pJeDMJxeVFRTtGrfKYqCszxjq14YiXIuf4Ho9+cicA8Yp+EhWP2Tnnq9Lr1fohM1tqrJ6/xcRJOscx4iirn2yUXd8AxKAbKZKkkOY/3ZnPMBEoitP4C8PUM560xy0eY3vZ5ZNF+mOIvh7bTLEAVisSzXgAxFONQtRW/IVIPjSSnnzWAQA6R4AzqXpXecacv6XeMUCkLS6bVcny6TTpMAweS1Px1wd207jo72Vh9/XzzALoanM8bqPUUloBsVyton6uENDk8ymPxD6eBwsnd8xIv2IDiBS7nusO+xHOTibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaoVinNIjdtspK87W6vLdcB7NzVx/6+2xQ63AT8c8ak=;
 b=SRWlYylylYYmhmcvzbbPuK7GAybyHryuMclSKqEJBEil5LpW0Xqic5TR2X/yVnSmpdVTRJBsRbb1Y/FytIkF2ahltxr+X4nrm+XGAsOOiLi2Rrybv0CjMm6wgOqQ2ML3Y8aFL55P73Q12mueEPVanM+L1nsshUM3ZuSJX4epJUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Wed, 8 Jan
 2025 09:16:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:16:51 +0000
Message-ID: <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
Date: Wed, 8 Jan 2025 10:16:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 5/6] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <ab8e42d18be2d9555ccd3b03762d9a4b76e33a60.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ab8e42d18be2d9555ccd3b03762d9a4b76e33a60.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 16aebc12-48b7-4e7c-f635-08dd2fc52fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXh3ZmtJVVpJZFlIR2Q4R2l1dHA3WTZUMUZDcTdGUTF1YmhpZllFSG5pL0U3?=
 =?utf-8?B?dENpMW5GQmRyMHFpZG03bDczV0ZwVTNsYW1SY2phMTIvc01JRVJWVW5UOTFQ?=
 =?utf-8?B?MzhlVkNGQk90elpnVHFLM0l3RUpTaWFlU05CN29RS1E5NUJ4SVZSN1dIQVJG?=
 =?utf-8?B?VWdxRnlZT1J3eXJRa3lIWVljYjNZajcxRkZzWDRsT0t1cmZoVXpYSXRhL0V6?=
 =?utf-8?B?c0Q5N2JHVXBFcGZ1cWVLNmIyV3JCNDRSeFNuaC9nbEhZVmladUxOZFEybE42?=
 =?utf-8?B?WlpwZjZQSGpPYVNkY1VjVWpYV1Vua1pmYU1seXd1WENXaUtzUjFBTU1HblJj?=
 =?utf-8?B?ckhBK1Q3RU84azZlWmxIQkJNSDNiWStSc2pOVjM1Y1F5dVNpcTZ5N1grQ1dp?=
 =?utf-8?B?WUtCTWJqU3dFb3VZOCtkODFoRlhpbzhDQUszNjdoaVNKQThobmc5MGRaMzVl?=
 =?utf-8?B?bmNRMW03K3ppeHcwajFjbGtEY01RV1FIbVlQcUIwWlMxelpudUFPYTZ4UmZz?=
 =?utf-8?B?NUR3QVlpcmtPV09SRHJPTi8xMnRoY0s5U3ZkektVNzd2Z0ZHVTNndjZaRE16?=
 =?utf-8?B?MC9TL01LTkxQTFRRMHB4RG05TDJZUkRXZDBXaVJRc1BKOXdTc3Zhc1NTd3hJ?=
 =?utf-8?B?VlRZVzhFTmgzU3dNTHA4aWVBN2RJdHphSXBqek1rRjZyMFJaOERnc3ZqSGE5?=
 =?utf-8?B?T2U3VzRkUDFGWW41ZkpGeXdURjFsZDlERDBLL0pOSWt4UmVzdC9HeGpqRWNw?=
 =?utf-8?B?WlFIRDFKR0ZndGdDRnl5aUJLS3lsdFhnZ1Z0ZkFucjNPZTVlQmVIWDZvZzR0?=
 =?utf-8?B?QkpqelNOdXZzQUNWKzA2b0RRSEVqeHVxemsrMnlZNUJDcEdHNFlhQ3FoRFI3?=
 =?utf-8?B?ekRyUG05RWVIM1ZDZ0dBRFN5aUtzK2UrUkd5MTlYNlZ2MHhBWlFWcmw5d1R1?=
 =?utf-8?B?czdaajc1MW94Q2lNN3lHcGo1K3J2T3J6NVFFeGFXcE9wNmRUYjRlTjdqNkZr?=
 =?utf-8?B?d1ovbUYvdjF1RmxlVzgzeE13S2hMNnl5NmhHOUI3eUlOVW93a2FxWFh1RHh5?=
 =?utf-8?B?OWVXK0VrVWRQMlA3dWFtdTFlY1Jad1U5SXdMYXZlQzBjQnBKUWhObEF5WFpK?=
 =?utf-8?B?d0hveEp0NjJOd2xWZWttSlpvUTN6R3BOOEZDSTUxTWpEcitDb0pFTCtFVWcw?=
 =?utf-8?B?enVGazJMYVNpdXBCYmVSTkNjTlRTRkE2S1VhT2NaZUYzZ0pNczFBZDBlODMy?=
 =?utf-8?B?UWEvb1E2c2x6cnpmV1FxeE1ncTE3L2hGamtvWHBPbHArV1duTkd0cTRyY2xM?=
 =?utf-8?B?R1VLWGR0eDdwMUdhaUVrK21BSUtRWnNZQThFM09YZ0QyWmdEaWlMcmtleVB6?=
 =?utf-8?B?SEl0VEFBNzB5VjBkMTRsT1A0SkNPVk8zWWc1Ry9QNWNBVzdPb0RMdEY2ZUpj?=
 =?utf-8?B?OHVjQmlBbjNLVUZqTXVScktpQzdYb0hQQ3BaQW44Sy9lcW9xWlZJWVNDeUow?=
 =?utf-8?B?NFJqcldxeHRuWWxubTV4ZGJRMXVVOXR6YWpxbFFsVjFZYUhVY2VMQTZYVWRL?=
 =?utf-8?B?M2I4TDY1elA1UVBDZG5WMWJXcjBYdVdJQzdkSFFmTnBNVHlDRnpTUUo3ajJK?=
 =?utf-8?B?QWVDeDQzbTVuWHJxZVBBUHVIQkE5bEYzR2JNQ1dLemEvcjJROFhIZEtNcGtI?=
 =?utf-8?B?VkFibkh5TS9pWloyVnNoWjIreVhaaGI2RlZZNFU1SnNNUXZCeTEyUHpPTnpv?=
 =?utf-8?B?SFlMUFFMbjR6NHZscW9XRGw0cDhqUjU1azJ6MStrMzBaQWxPUU0yK1A1UFdu?=
 =?utf-8?B?cFBncE9JWmhYcnozZCtubHhrVnB1VnBvN1F2c1lRYm4xdWE0TEdtRlUrclZ0?=
 =?utf-8?B?M0dsNHk2Y1BpU20wdUJBbGI2ano4UmgrWnNFdnlJMktHK2ZJWUd2a05GTk4z?=
 =?utf-8?Q?KWUwu7y2xLw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1vcG51ZUlkZW1CTEkzRXBUTXRyV3NRaDg2Vmh2cXFvRjUzeUZ3akxjYjdp?=
 =?utf-8?B?NXFzVG5WUmJSWlh4ZnFVek8zYUNpR3ZFU2h1MVpzdE43bVRJM2h0ZUIwNndn?=
 =?utf-8?B?bGJkYlh4OTZJMlZFZzlmVlV4Q3RTTGZKZ0IrdWJPQmFuYWxXT0VyMVh6YUlX?=
 =?utf-8?B?WHVRTUlsaG5ody9VRDdGTFcvekx0ZHR4azVMd3hxV0ZiSXVHeDkrdXg4aldN?=
 =?utf-8?B?eVNjZmFRL1RSTW9zZERuVnplMCtmVUZNRW03ZENnYVRWaUlKYzFsdEhoUWNL?=
 =?utf-8?B?VDRPTjJuWFhVNmdMQldPVHp5RWxYWnlDcWNVVjQxVllNYjFSVGFacXF3M2xP?=
 =?utf-8?B?Zk0waDFTRGkrUHRaRm0xUHZoQmh5K1kxYjZWQ1dRWkhZSjlmaEZDRzMzMzRL?=
 =?utf-8?B?UHBMaFBWT0RlL0lRWVJiZ0lVSUROSEJhT1YxdnVpUWt2eWc2di8xYnQzNDU2?=
 =?utf-8?B?aVpjZUd2d1hvb3JkQ215ejZ2V2ZZL1JHODRLbngrenVHc0tqWHlZQ1c4ODdN?=
 =?utf-8?B?bldPTzA4dURzZnprWktCT2Ercm12M0JGT2tXMEYrM1J6TmM5d0JwRldJZWRt?=
 =?utf-8?B?bGh2ZlY4UEQxS0NPSWRjYnppQ2RhOHBWZ2hveW1HOEdaUFIrbmcyQThQMStu?=
 =?utf-8?B?aVFPcFB5QXdCc3VsNDJpd3pWU3BEMGtWZkdEckkwQnJsMmN1cHhlOVp6Y05H?=
 =?utf-8?B?bXppMVgzRWJDdTNHMFh2d1l1dWRnN2QvMWs4VHNRdDBINzNPWXVDUzNJZVRG?=
 =?utf-8?B?WXJQL0s4UUliR3hncGhQaC9sb3JtNDZlODE5QjBGUk0zaUVOSGJBYlJzWXBi?=
 =?utf-8?B?eVh1VjNjaTExaXkvcmpVcXlKZFlVaE81djJYNm1WUmVsejhXUG5uRUplZHdp?=
 =?utf-8?B?Z2VPenYwbVN1eG1qZWo5azZCN2RWQ3J3bzQxcFdIejgrMVBMclJ5eDAwVmpO?=
 =?utf-8?B?cEpEZVhRcTkzUXpTclFhRTl2Ym1kWm40Z1djZys0M2pnVUFTWVZiZlRINWhL?=
 =?utf-8?B?cTQyOVpIay9pK0UzUU1CQXdYOUw4SllNNXdrc1Z5YjZpNmcvdGJvTGNpUjZ4?=
 =?utf-8?B?aEM4Y2J6UnRJcjZObEhXNXNTWUlGR0lxSjlLTXdRbDdkYXRwaGd2N1VnbFRx?=
 =?utf-8?B?bVRwZGp6RzJaRXpUdk5BMUY5aU5IaTF5MVZGSExzVUtKdk8vRnFvVUR0WVZX?=
 =?utf-8?B?SWZjcjkrdEF3MUYxS0poOVh4Zmp5TlFpSWpGM2dPNWZ3aEx5cmpVOGZGMk5z?=
 =?utf-8?B?bEpsVGJHZm8rTXB0bGducklaZUhtUjNUVmp6NVB3Wkt1QjRKL0FFMnQxMld3?=
 =?utf-8?B?UjBCM1RkMndxNS9IVG5WM0tzanJLVGpRRUZkK005Q201TXNMR1Bnakc0bHR2?=
 =?utf-8?B?Q1pSY3BxZ1hsVzhXZDAzd3JQQ0M5eUZjRFZ2VWRlWHQzWm1WMzBtcStYZ1Np?=
 =?utf-8?B?TUgxMitPSDJwZWd2dzRub2hoRElHUEZONEhzR2cwZ2w0a0F4UDBQd1l5djJt?=
 =?utf-8?B?d2U1S0trRUFSMGc0aTg0ZEhKbiswV2FOR3ZoOGNxN2d4Y0JTRi9kTmMzcHJE?=
 =?utf-8?B?dVd6TkhHUHdobWZwVkZYNmRhVGpJQlVpUVhFb3l3TC9oOWQ1RGgxakRjd0hx?=
 =?utf-8?B?aG9IT0x6aUZnK1JIWGpjT3JDaEQzWlhHbHAvVDlqajVyeWpndE0wLytIK0Vk?=
 =?utf-8?B?bUQ3c3NyMEtMTVozOHlyY3c1RGltSDF0QlBFL1kxNmpzaW5vbWxRVU5TUFdz?=
 =?utf-8?B?eHI4OFRhM1l1dnFYd3ZzbVYxM204VnVRbkZ6WG1WVm1QeGxmM2Y0Mm9LY1FR?=
 =?utf-8?B?UkRTL3ltZGlPSElBblZ0TWw0c005RVoxZFpPQjc2OS8zK1hFR3N1bVpQY3Bw?=
 =?utf-8?B?RGlFcHNkS2R1STN0ZlhtbUNaQWg5aHJWNVNuZTdwbklRSEpaSG9xUHdEc2hk?=
 =?utf-8?B?Zk1Fbkw1aFdoZ1c5Z2hmRmRXdGE4dlNWYUpWa1A4Sm9hMTVEa21IbzR2Rkgv?=
 =?utf-8?B?TFVFVzYwT2Uyb2NFN3FsS2JJVXlPZWVjekhFYmFwY1pqMDRiUlNrdFArR3lL?=
 =?utf-8?B?dDZ4ajE0M0RYZWpHUGdRRURSTW9ZcHZkNjNqOEdCQXNUMVAxWHRtbjB1bEZZ?=
 =?utf-8?Q?g2D1ii32AUHSdrnm0eiT3fb6O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aebc12-48b7-4e7c-f635-08dd2fc52fcf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:16:51.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tApSrwLkUW6vRadJgzKtiJLqXz221NI1lq76FJSMQCyLprChc/96oyfRqdD5PvyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

Am 08.01.25 um 09:56 schrieb Jiang Liu:
> Function detects initialization status by checking sched->ops,

Where is that done? Inside the scheduler or inside amdgpu?

Regards,
Christian.

>   so set
> sched->ops to non-NULL just before return in function
> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
> to avoid possible invalid memory access on error recover path.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 510074a9074e..741807a1fd2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   		if (r) {
>   			DRM_ERROR("Failed to create scheduler on ring %s.\n",
>   				  ring->name);
> +			ring->sched.ops = NULL;
>   			return r;
>   		}
>   		r = amdgpu_uvd_entity_init(adev, ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..b5e87b515139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		 * The natural check would be sched.ready, which is
>   		 * set as drm_sched_init() finishes...
>   		 */
> -		if (ring->sched.ops)
> +		if (ring->sched.ops) {
>   			drm_sched_fini(&ring->sched);
> +			ring->sched.ops = NULL;
> +		}
>   
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);

