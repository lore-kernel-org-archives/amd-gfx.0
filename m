Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D2C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 14:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C79710E983;
	Fri, 24 Jan 2025 14:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnUnOERA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06ED510E983
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 14:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTKO33HkzKOdrjuhEafo9y71APH7jIcMTNmpr/MRWZYYMPIH0jAIrWaRNMa0LRMcmXPWhPrrdLiOltwR/A99awE6OP3W0CuMh5v7VtJpcu/6C9VUMJ3ljAbZjtctKvdYrvICwyey2Q/SpgD5sBm38GZn9kYBGV6WGVnw/FKzx2ik0FM6NSpSksRzFpbk5dMcawk+9JgU/MuIdP/+WT659QpATvHTEkq3cRteLe+o0e9gSsE/XT5aeC1Fb9p38HTY9tFp8Sx7Ud6VNbPoUzkn4a9ZJVviIfmtSP+5MQYzOnJLCK3YaUbPJE9iE1nSn+TqU8nK6ydiBA1HLmQzlRLWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKinQfNZj610V6AUwquzcdtChyZfwsV+v/KkDsHcKGs=;
 b=wiy7cPyFvXjeHLtqHVBxSvmeRtUOGwx2O3rX+OKx8vd3sebN3JGhysPm7iFvaKZJtIiWEACjkfdIkIc4YsvfDMw/h+S3LFpjsYcphXrW+pCB1Ca2xrzFoYBNPb8JL0V5GkrfjiuCHfiGXQohVmES1Lpc/xMnA7uFiFqDz4wmbQv4dpsHkqGvtz8msn2iX0oixLpZ6G4q/QOclW4dCX6ypf5re2F4QkG4/Yxz0jljkJe8GpMKolm0Uu1s5knpL8LD5/C0lemMV8zusLz8FrEnCqnKhJhqXm799cU8vPxMWElmVuO79RsefKvp9ufEW0Ccw9rn7dedx8ojadFTJPawnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKinQfNZj610V6AUwquzcdtChyZfwsV+v/KkDsHcKGs=;
 b=jnUnOERAvEQw2EEOoh7Fry/8/prh1rMaFCRyDQP0pqSpxRp6RgWx9eVUx6XhLYv4KJRI5VBqmvRW4j84HkY4MNwhEqoZi66f4EAF2dLuZz/df6XE8bs9ECKxNe/nD3Ani9B/k6Wbf1hLDGvgRYKgh0ZBcq9nuITr3TgkkCIfH3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 14:16:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:16:41 +0000
Message-ID: <32ef6675-3853-4f93-8015-0663b19329e0@amd.com>
Date: Fri, 24 Jan 2025 15:16:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1737695869.git.gerry@linux.alibaba.com>
 <7276c3a97155647d7a9e00c6e70e3ba21324352a.1737695869.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7276c3a97155647d7a9e00c6e70e3ba21324352a.1737695869.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc58173-5bd2-4086-2e09-08dd3c81b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qnl3U1ZRS1c2SENzOU1HZ2NWZDQ3NXFoMzREaHY1WDZCUGJObHRQQituRURG?=
 =?utf-8?B?R3JpbzltbHd2ZFlORFdaNXN0dmhPMWg2VEVSSnZDSHhaZDVaL1FxTEZTemNZ?=
 =?utf-8?B?OHJLVUxUT3F1WC9RUVAwNjltVzRCbWNINmJoaUhaVnE0L2FVaGY0V2dERzg2?=
 =?utf-8?B?K1ZDSmtIL3pBL21FTm9FcUNwdTVBbm4zUVQyR0pobTM0OVRzTlBGUzlmSFVv?=
 =?utf-8?B?a0p5YlJQV1hWeFdTaEc0ZjBiS3lEZUpLR3RIRGlibTJhSzg1VXowSk1CbkxD?=
 =?utf-8?B?TGJHSENLcmRmSlFiSTdzN0dheFRNQmZ2Ymx1R3hBWklnSW1XRmg0UUY1aTB6?=
 =?utf-8?B?aWV6T1Z0MGhzR2VyaHI2RDZOWng0TnB3cDl1NGNEZnorNXp3S3ZHZWkvWEVx?=
 =?utf-8?B?N1NMTDdsclRUeWxhY0g4eTlDTXZhYVNtYVRJNzJZL3AxREJ0NGd0RXlkd0FS?=
 =?utf-8?B?bnRrWG9WNXdOQ0htK3dsUHF3cjNwaHFYRlpCalhSRlpTTXNTeWhhamRaUHp3?=
 =?utf-8?B?SEgzR2NvZm52c0JTTEhBT3lkdk5SSlIweTBDWEwvbVcvd3JmYkpGeUFLdnNi?=
 =?utf-8?B?Um9Pdmo3RjgxU2k4aXNGeVVMc0lxUjVuUkgxelVBR0RrSXZ0aVhpNE4rM2hT?=
 =?utf-8?B?NGhIa2JLWnZIZlY3ZWs5dlJRVWlPTVYvZ1ZsZ0NIcDZFZjJaRDZPcXMvdjJP?=
 =?utf-8?B?YmxDeVFzYmU2MERwM1V5UEZHOU5yMzJsWE4rQmtGZHpreTVvbExWbVJzTll5?=
 =?utf-8?B?LzhreWpuSnkzYlo3Ni9nRHR1a3d5WCtRdkVDTlpwNC9lZzFtYmdmaytpaVRX?=
 =?utf-8?B?WDh3Mzk3aGd0U2FNdWxDaXFYM3JNZW0xb0p6UEZGdTVvbTJ2WDEycjJkQ0Jo?=
 =?utf-8?B?UDU3MHA4eTV3NVpLOXZ4L2xuYUxjbjVVdHpCQ1N5R1dVUkduNEROMjF3ZmtR?=
 =?utf-8?B?YkhBME9OOE9jZGlCbi9HL3pRUThRejYrdnMxM1JKQmR6TnUrdGRsVmkxOWdh?=
 =?utf-8?B?Tm5JNWpKdVp3aHhpTDl5TG9SY0E5ZmVHS1Azak52NkV4VzQwSHpOeWo3V0Zn?=
 =?utf-8?B?OTdDOGdxWTZRUmh5SEorekhIb25neG5sam52R2IyMldmMG1iWGh0MytvOFBN?=
 =?utf-8?B?YlN4d0RMMXZIbDRYZlF4VmFmZjFMMUpRMGFNTkVOSnQ0L09zeTgrS0xNeG9h?=
 =?utf-8?B?UWZJcmZQTjRHUzlJM2grd0RaYjJQWnFENFNrdDhyTW9JMk9IZVZtcVNJalBa?=
 =?utf-8?B?elJYNmZtc2hVVUl2cGY3UWpFRFFFaGZHcjU1K3RVR1czUm1Ec1E4aGM2akIr?=
 =?utf-8?B?bnpUN1JYNG8wcWxjV01MT2hUUy93ZHI3OTdtdnMvN1FGczRDcUhlcHlrSmpw?=
 =?utf-8?B?WnZ4M2NTM1VrQ2lHN2Ryd3A1ZzcwdUxnWUp4ZFlmQWF1K2xjWm4xMFlTVzFu?=
 =?utf-8?B?Y1V0WlN2L29GNXRkaHJwdGQ4U0FPcDg1SmNGMGxsV3dud3ZzbzVabm1jOEpl?=
 =?utf-8?B?bkJNV0pHRUlSZ2E0UVdLbVh4OW92WjlYZjE5Y0x6VEdvdjByWkRsandueTNk?=
 =?utf-8?B?dGxhc2ZYeGltZ0FSb2IxdlAvSGpYNDNwaGdsTUM1L1JESVhBZlc2Y1ZOUTVT?=
 =?utf-8?B?WVVTWWpTRC8rUzNOTERvdjJYc2cwRWtaWGZIYVpmRGc2ODc1ZUVPdDVwT1lT?=
 =?utf-8?B?U1BaOUtRTlJBQmloZ1I2YnNLcVJHRGRqQWduL0ZPUkk2MERYU0o3TlNEOWt4?=
 =?utf-8?B?Y2s0SmtrU1o4L1MxOEx6dDh1VCtuellaWEdtZFgwc2hCRUFVV0NscnY3YjFV?=
 =?utf-8?B?WGZwS2FSM3ErRDhJaVlWRVZQdFR4T2tFcUdrRXQyQVJSRnhPL3FYR1NYK0Rp?=
 =?utf-8?B?bFpjdDJtT29ka2x5ZFQ4d3ZTaDZJRDFqZi9SWkppTkJGVUFSZExoOCtDSmxR?=
 =?utf-8?Q?a4W27wzF8Eg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdjSVlMcGNlVTVheVlhVzFlaVgrYmJWUjJEQUpxVkFqWC9icVR3czNRSjcr?=
 =?utf-8?B?K3ZTQzJJNGJtY0NpQ1czdDR5WnRMZlFYL3JGK2tjaUVGekdBSXNVRVFsTlZp?=
 =?utf-8?B?NEU3L2VLVFVhRG1kYS8rSGJqdUphR0xJWDFlTWVqcENpemZiNklRUWlFRXZT?=
 =?utf-8?B?WCtLQ3Vod0xDendTV1dZZ1NCV01OZ2xNdHJleW9OWG93L1NKWG5JamMwcHRy?=
 =?utf-8?B?VnJ0YWtUWUg1U3R5YVBFa29tOHBYeWtxQWdBWDVQbkw4Z3VuMVp2bGlxS0Ir?=
 =?utf-8?B?eFdUV09YZit2SUhUZzJGK0MzSUVlVDBjT3BoWFJvUkdySVdWZ0RCQzlwN21C?=
 =?utf-8?B?b3VBT2VHQjB5aWFKNjVZSGRUTUhiK2JXUk5wb0t3S3JLSHJSWldvd1ZiUHZu?=
 =?utf-8?B?RlBQRjBJN1NFK2x5UGc1UE1YMHlEa1M0UWprRDJnVHNPVXI4YlBUZGhRbkJH?=
 =?utf-8?B?K0FsVUZoY2dEVE9ISzVpODZENlk1U2RBS2EzWm1xa2JZVjNjWVMzdXJuYnNn?=
 =?utf-8?B?ZjhDQzZORGZ0R0ZyaGZBekVoalJPOWVIRExscEZpWlVDRWFCMS9vSE1hQ2RT?=
 =?utf-8?B?YWY4cGVmYTVkd1dVRWFmajV1eDdyNnFreDhaR21aVW50aEVzZWpkNmhoSGxm?=
 =?utf-8?B?SWR3bEtRNFJXRzdTSFRlL1VWRDZBeC8wNGdyNWorck9NdkxuRTg0NExheHZ1?=
 =?utf-8?B?ZE5GT1E4Y2E0MGJ5UGpHZWZJK2VxRzVKSTRGeUIrWWF1a3cxOEpKSGdGQVNx?=
 =?utf-8?B?d1VqYnpDZit4SnYrZVZ6cDA0aFpXczRmQWhaZ0xyQmJoVFlHcDBhNEJPSkVT?=
 =?utf-8?B?VzJsbmptTnRGUkNoVlhyenJ3d2JtSFdKL0N5dGZLS3h1cTFHTkkyK25CU0dM?=
 =?utf-8?B?K0lNYmd6SURtcHVXUDkyTXppSkZDeGozOE1UZGhLNUNNZzZnNlE1QyttQUhD?=
 =?utf-8?B?ODVzY2lYWnB3Q1NCVC9DMVZjNk9McXRHenpVRHJvTUZYSGt5MldyOHBHakxh?=
 =?utf-8?B?UXJKVU9lc3FidFFHMnNJMEd6eXV2a2dUZGY4NC9iT0NZL0V4ZlFLMldrajJJ?=
 =?utf-8?B?MVN2b2VveElKVmQ2UTM1NHRDQWs5QTh4M21ENG9Gdk5rdVFiQmdyY0ZuQy95?=
 =?utf-8?B?VWpPbEcrUFIvL245ZU91cVlNdFVZYlRkdFZIQTBaWVpFcWV1SHhFUktueUh0?=
 =?utf-8?B?aGRINVlXcGR3MnBZeUI5VVdoeVd0S3ZUQkI5Qit3MzJaTjBRNTNhVDNTcWZa?=
 =?utf-8?B?cEs2a1lidTB5bGU2NmNTemI4RWNqOFZGdFRvUklzS25uajJKSzZwWlJ3ZUFt?=
 =?utf-8?B?SnRrbHhQN0hQcEI0QzdDUFJRUldsd2hUckxQWldydVc3TENUYk9WQ0VybnJt?=
 =?utf-8?B?SDNpNGhmTnVlN3lyWkY1WSt2TzRuSFY2MEVac01XVjRMbHR0VXEwNzRYVm1M?=
 =?utf-8?B?NzZWbHNYamZ6NHN3NUxjZUpqZXBmdWROUWFpQzRERVdSMjU5b3RwYmQ1VmFr?=
 =?utf-8?B?dW5hbHpiR3hiYjlSRDNwY3I4aUIxYTNhdS9CQVBkaUdXZDdKK1BrZm9SbnRm?=
 =?utf-8?B?dHlPM3h6RGlERTFyR0NUY1prTTc1R1Rjclk5Zm1Rd0RBNmJGRHc0YVp5SFlz?=
 =?utf-8?B?ZUwvQzk2ZzB5RlhVdDlwY3lCalBaVGNmZEFCUHhiemQ4cUx2Y3JZTXdHTS9j?=
 =?utf-8?B?RzA3c2dhZFBkdUc4dUppdXVYS0hDUVNuMzROUTJzb3J2aWZjL01CYm5NSmpR?=
 =?utf-8?B?b215Nyt0Q2dSQ2V4dnM5Mjgva1lwMCtMdzlvVmc2U0EwQUp2QlIvajFzMXA1?=
 =?utf-8?B?YlB3TDN1TEVHdXdjb0JOLzNDUEhTWHhPUlluSmoxNzF1T1J5ODVOYTRKajlx?=
 =?utf-8?B?aXhDcFNnUEVaQ2dyTTR6MlJhNk84MU80TjJVQ0kvT1NzeFhpWTlCSVdGdzFE?=
 =?utf-8?B?ODdWMlBUMnUwclhRWGwzMm4zc0hWNGtKOXphVlBrNTZLaXhpdklUdnhkb3ZJ?=
 =?utf-8?B?VkZOWkFOWjhVY1JaMnRaNnRVY2E1SGo2c3JicXdBcW1oUldiRnZ0VmpnRUU1?=
 =?utf-8?B?YWpPSzVPZ1RVWnBVS2xXR3RJOGZsWXhLSUlsY1hJSnA0aVlrM1l0ZEJOVG52?=
 =?utf-8?Q?McTBoa1xVxComHedhv/aH2TOB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc58173-5bd2-4086-2e09-08dd3c81b935
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 14:16:41.5333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OU700quttKG3BK0xtFGN1O7I5NM+JtefehYjKZ9b9lf9OS18LjOsm39iKm0Kc6G3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

Am 24.01.25 um 06:19 schrieb Jiang Liu:
> Introduce amdgpu_device_fini_schedulers() to clean scheduler related
> resources, and avoid possible invalid memory access.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

I can't say much about the RAS stuff but that patch here is Reviewed-by: 
Christian König <christian.koenig@amd.com>.

Alex will probably pick the patch up as soon as the series is fully 
reviewed, if not just ping me and I will push it.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  9 -------
>   2 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ee695e70fb4f..1619bd2473c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2857,27 +2857,48 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   		if (r) {
>   			DRM_ERROR("Failed to create scheduler on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_err;
>   		}
>   		r = amdgpu_uvd_entity_init(adev, ring);
>   		if (r) {
>   			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_sched_fini;
>   		}
>   		r = amdgpu_vce_entity_init(adev, ring);
>   		if (r) {
>   			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_sched_fini;
>   		}
>   	}
>   
>   	amdgpu_xcp_update_partition_sched_list(adev);
>   
>   	return 0;
> +
> +out_sched_fini:
> +	drm_sched_fini(&adev->rings[i]->sched);
> +out_err:
> +	while (i--)
> +		if (adev->rings[i] && !adev->rings[i]->no_scheduler)
> +			drm_sched_fini(&adev->rings[i]->sched);
> +	return r;
>   }
>   
> +static void amdgpu_device_fini_schedulers(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || ring->no_scheduler)
> +			continue;
> +
> +		drm_sched_fini(&ring->sched);
> +	}
> +}
>   
>   /**
>    * amdgpu_device_ip_init - run init for hardware IPs
> @@ -3424,6 +3445,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_device_fini_sw(adev);
>   
> +	amdgpu_device_fini_schedulers(adev);
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.sw)
>   			continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..c95895a7b888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -650,15 +650,6 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> -		/*
> -		 * Notice we check for sched.ops since there's some
> -		 * override on the meaning of sched.ready by amdgpu.
> -		 * The natural check would be sched.ready, which is
> -		 * set as drm_sched_init() finishes...
> -		 */
> -		if (ring->sched.ops)
> -			drm_sched_fini(&ring->sched);
> -
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
>   		kfree(ring->fence_drv.fences);

