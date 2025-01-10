Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2796E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 06:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AEB10EFDE;
	Fri, 10 Jan 2025 06:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QXdPd9Pd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CD710EFDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 06:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeXNIErdCTAdVyi6Q6KquYwhopym2BQbvRiKLo8JjDPWBmAMaqmweexeSMJunZxbBermJU/XwT7FtHtfLRqw4Oztl83Fo/fAedZToRP1LkPX5Tpdcm4H2oC+tG2cFZR7JsDFnFv2TmvnA/lxNAdyMq+lo4lHjyk8nd6OUhbmfSKFcF+PMU4ImkV1SiKOXWX8rDxLyncKNeB5UasP3IBOSLqFLr4kA8FpL1485+RhpdHWWr3jU2jij/ry04dDReUaJPAwD7ojNStJGDg5U6UycXD7qYhXrvQMuqST1zBQrWkrYiSADQoI8EcP0Gbi3RQfbtsCEA5gT3t6BMCD0Q2Xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBqxsolQcQzfHKJFTwqF7p746tQUkMz/OXOa2KWrUKQ=;
 b=qzII6puv+QO0KFNddDhZWB0RYIb1/Xmc53sw9zaa1N2YKvs4zSh9HawazKsZcLQNJtRhY8iMdHOrtyLoViMRaXSw7otAXjXfqCV+EwXm6CRpBtuIJyx1sw4fX/DCnNmI5Wo3cjv0OgbOyHqxXx5MJkEAaM6OD4xQkzs7qLo5LFvO+Se0pACC69UskbYLRqU2Gcjjd6xhoMe5Z8Q2LS/0e0NTPeArLLGhEpQ2qlUznUYShQzK/yCnLmiep06ISRK486LPSJ9x8rWqaHMg8zxaObzQRpPjC2SKDq1Up/lS3t+surC5prWLUY3ijTtxxf9nHp0nmWLK6XNlYi/bjJLWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBqxsolQcQzfHKJFTwqF7p746tQUkMz/OXOa2KWrUKQ=;
 b=QXdPd9PdlKoF3ehG2VmkgSv/MiZl8y2vt42pA2bQOlpY5YakKnkdRymqtUCiJgFJPBJhgnFA7CL8ty2UTcb287scBXzFuMVC6g2ebdwgG5Shyb+Up1QTWN9ArrUlQGbo5HgqI1SzJJh9p6GG9GbQvIJKzuM/9WgzM7Mv4s4Ulj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:51:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 06:51:57 +0000
Message-ID: <098f1b68-4772-481b-9b50-864d9cd2ad8a@amd.com>
Date: Fri, 10 Jan 2025 07:51:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <b824d12a9636ac43066d731c514de8abbf1d115e.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b824d12a9636ac43066d731c514de8abbf1d115e.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: c859dfb2-5fd7-417a-17f4-08dd31434698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkZ4M2FzN2I0MzBUQUNFRWFTZ1NYQTBVNVdXSE1NM05TVnFYT3llOVlPdTRj?=
 =?utf-8?B?M08vWlA0UXVSUzVtdTMzeCtZU3YyNVVTbFAwYTBPYjlUTW5WdmdOcWp1Y0VX?=
 =?utf-8?B?V1Y4cFdRVHFtY1h2ZldSWWEwZWRjcUF1b04zSFhoSFNUMUNqUlFiU2JzMVlJ?=
 =?utf-8?B?azZ1Z2FpSE9GZW1wcThUSi9WaUl2SnF4Y3F2TVFqanJtN0FZREltdFhhNTlh?=
 =?utf-8?B?Q3UyVUczSG9uL081b0J1VEtzUVhGM1BuNStRYjBlUk0yNVhabFNqbHNYSVR2?=
 =?utf-8?B?ekVZRE9FNEg2QkU2enViczVQZENGZGFITm01YlR1NjBTY08yeWJjZUE0Ujly?=
 =?utf-8?B?aTg5SDAvS0lYRVk0Z2p2SmdwSENTUGZQRGloU0pDV3VudjZKQzBaNWJvRUtl?=
 =?utf-8?B?VytCTERtbGUxQ2U5dlVQdDlGbU9JcWNnZXkwRmhjYlJXZU8vcDI0NXZNdTJZ?=
 =?utf-8?B?UDNXNGZNTWpsQVFVNnlqVDA5RmlrQVBiT0wwRmRpZjlyMStvOWV1L1JLd2tH?=
 =?utf-8?B?ZXVQUDVjTmtvbytGb0RUZ1FtNzdlM2RYSDZPaitpVUlrTitJV0JRMVRIUHp4?=
 =?utf-8?B?T285aVA3R3MySzBsUm9iYmwzbzNLU1hlbmJOeSs5NElKcHVBRXFnUmlaVjN2?=
 =?utf-8?B?UnZnMndvL1NnRklGak9TenRUQmxEc1BRZzNld0g2OGZzWVU3T0FYcEd0SWJV?=
 =?utf-8?B?aTdPTjFWTGd6S3lyUWtNWEc3Y3d5aVdCTW13enYvRkhCaVJ0SUJobTd4WEdW?=
 =?utf-8?B?OVVvbmw5TjNxU0ozc3RMMHczakdEV2lOWlkzUHZVRGFJYUVVTWo2eC9aUktY?=
 =?utf-8?B?c2JSa08xa0ZmWmJHSlFuK3Q3NzdoNVhBK0lqc1Rocy9WOFA2Z1RTTC9QTEVz?=
 =?utf-8?B?RDRZZ2Foa1BxdE1PU0ZiS0hFbnU1RFVTTEpITHkrM2xJenU5czlBWlpnbVR4?=
 =?utf-8?B?MklZWmxMK3ZFNk1SN3A2ZWRweDNsbXNKYTA5bmQ5YmlWOWFlb1dJS3FWR3JY?=
 =?utf-8?B?elQ2TTZYdGJlUWhWaVEzWFdvOUcySTJZTFoyTjJJb3RvTmcwODlFY1VrQkpR?=
 =?utf-8?B?NE5OS0NEVEQvSUE0L2wxOUpxTHpid1k5UnVSQm1vWThTMk0wYkp6WkxVQi9U?=
 =?utf-8?B?MXBCQXRZK1dTb3cyMm5IZElzbmgvbFd2bC84Y2UxTWJ6OW5EUFNkU3M5dk9R?=
 =?utf-8?B?WUlXZnBvNEs1L1JHS0dNS25POXFaVmVLQ2REbkVuOWlSWnlSWHNrT3BsWStx?=
 =?utf-8?B?Y0p2UjM4OHFzWWsxQ0htWUZLQ1RVbEZxWHJMbzBGSnB3c1BDV3kvOHltTFJu?=
 =?utf-8?B?UlE5QVRPdDB5cm5JUE1zZEpNaUttbStib2FBSW9FRGhTM0Z6SkU2V1pDZk1t?=
 =?utf-8?B?TmhQeUJ6STFEcW5iVTBsNnBuOUlSK1UxU0xPdEJkRUFlNTEzUDgxSVR0dUVa?=
 =?utf-8?B?cTJWMlRKdVlhSUp0WHcwUnI3ZmV4Z2tucFFiRzVGMVY0cno0UXk4Nm95cE51?=
 =?utf-8?B?aEFDVHZmYllKNDJmK3J2elBjUXFDUmdFdGErSWVJclYvbjZEUkw1T2N1TXB1?=
 =?utf-8?B?VHVTRkR1Y1lyRWUwZXZZRytBdEI0K0dpeEdLaDRObkN5T2tROGZoT3g2YmZj?=
 =?utf-8?B?aDNrbkFsM3NhdzBzZXpqamdiY084bUtUSUoreHFYSjE0ejNBc2RJQUlna1NJ?=
 =?utf-8?B?QU1hRmhXd2h6UjI0UFVob3pIS3QwZ2RXVnNNZk1NV3JGN1pOUXNDRElJcjZO?=
 =?utf-8?B?TTN1NkxoS3JhMHdnbWRyK1o2MkFiNDE4b1cySG91UjFVZk9OZE5hTWJJU3FQ?=
 =?utf-8?B?VUVOQm5nNG4xSVpMUFZZTjFlT2M5cGVrWXRCdGNPV2IzUDZMZnJnTCtvdk5U?=
 =?utf-8?B?Mit4WkMvNWFBaDVnTXArbmViVE9oSk1FdWwxcDFNVW9Nb00rN3lOUXJJc1Q0?=
 =?utf-8?Q?HcUhvCH407M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdWWGE1S3ZBZlFqdlhVdzVSZ3QrUGM0UW9pMU81OHhUdFprRjMzTnl1MWhQ?=
 =?utf-8?B?SlRUQjJNOG5yTDFWbnZqakF2b3ZFNk5IYnVQdGdDeXBKNXRTR0tJR1paZDhs?=
 =?utf-8?B?ckpUMFBHc1VDV2VTQTdJT0prL0NhdzhYL2lVcURobXVKZkRmU3dwTytxME4y?=
 =?utf-8?B?R0pSa2V4dy9YS1FkOXJ2ZTlBYUxZUFVFWTRQZ2Jncit3Ry9tWUc5bUxGdEl3?=
 =?utf-8?B?Y0N2b2RNRkhkSTQ3NnE1SU4vbE9ScSs1NTUrcE9LRnAwM1lsUDljWVBkTHNC?=
 =?utf-8?B?Z1g4cG50RVVWemlaYnZncVErSzVjait4a0h6enQ2eGl0dEtuZ3hoUlMwQ3Nq?=
 =?utf-8?B?U3FqRjZFMFZYTERDazRwMy9PZ2N2VWRsbm9aYTFKcUhuaXdlcndRdjZMbE5R?=
 =?utf-8?B?ZTkyQktpR1VvS2dKazlEaWxQNjZ3RXFSc0hONGZTWlhKVXdyMVhWenE0aHF4?=
 =?utf-8?B?MGRDUFVka3YxYU9XZE92OTI4SG9JN3hrbThERXRZdURzVDEwOUFJc2ZkejJI?=
 =?utf-8?B?Q3NwV04xM1MyNUlWb0RQaDdUVFVTNCt4S1F6bUVMbUFPK0MrTWQyVk02Wjdl?=
 =?utf-8?B?OXhBbWVPUDFzQ2xXTXdRR0RhMUZUOHZ2dFJlSkRyN1pJL0tUaXVUWTBpTUJm?=
 =?utf-8?B?Z0t0ajNiNTlBMHZWcExhUHBMQzZsb041WVR4d2ZNUm8yK2xTdE1LUjc3VlVj?=
 =?utf-8?B?SmZOdVc4MkRiOS96bXRQbGoyU2NuM3hncXVENUl3UDk3Tm4zQ2N4elpOVWNW?=
 =?utf-8?B?M3k2YXEzYnpqZlZsZXltNG5XclJIVldxcEVlWHVBOW5iK0UwNjdETWR1d3NB?=
 =?utf-8?B?WS9YbklVdVluSWJ6bU1CTUtCVWFTZUU3dXIzb254djdrSm9HV0NsSnB3OFdJ?=
 =?utf-8?B?YXhla2lMNTVJdW1GcWtUMmhxb3YrbjVUTE5LNUpTdDdaZlMrVk1YZnBsM3B2?=
 =?utf-8?B?cnJWVEhYNFM4bG5aVHBvWUpsM1RGR296NW82dHAwN3BzM0ljeVF4a3hKQ0Zo?=
 =?utf-8?B?REVBTFBIcEtIR3ZHMGVUcTRMVUdzV1ZSektGZmQ1ZklicjlmaWFFNkx6Mlcr?=
 =?utf-8?B?UmExdkxUQ29ueUozblNPbDhqQUZoV2VKMWpGY3RoMjM4T3lXdHExSlZDN1RT?=
 =?utf-8?B?RmQ0WjR1TVhCU2x6em5XU0VXUjQxUnJqRkhpa0hPL3RYU1BWSlhXR1E4NkRr?=
 =?utf-8?B?STZlTGs4SkhEYU5mdXdKV0dualpvNmIxc1pGRnhMcDgraXRoc2RiR0owSGtH?=
 =?utf-8?B?VWNYTWxSblo3dDRyVE1xbGh5ZjJnZEJlQ2ovZ25sdVBaMzJPRDZEVkw0Lzh6?=
 =?utf-8?B?K21VeWpobzROWG9DVEtGNWQ0ZWh6bnlMYWFjTXZBTER0SWZwVzhZMDJLaFNB?=
 =?utf-8?B?ZkxyS0o2SEZDdy9sVFcrdSt3S1JKVVNuWldhRENsZkJZQ3FiT1FMRjBlVnYr?=
 =?utf-8?B?TStaK25TMmRONTR2dkVRTEJVUFVtU0VZNFV6bVJGa0w1dlRXTXVsanB2bHB2?=
 =?utf-8?B?Z3ZXS1BPU1dkWXQvYXlRMTFRaWxGYlRteUdlbk9EMXViY1pCL0dMRUI4UHRK?=
 =?utf-8?B?UFF6ckZkbE9kdWJHTEo4d2w3THBhT0NRTkZVeXZkZ1dFbEdjNEtYQUVVVHB6?=
 =?utf-8?B?ampLUkkzNzVPaWV1V1RpRzJlaHlVQUd2a1loelhaUjRNUkRvSDRzU3k3NXBO?=
 =?utf-8?B?Qml2cHpNbFJqcmlvUDdjaVFoNm5nRTJUYVdoR1hWODY2Vi95Mkw0K0tJczY0?=
 =?utf-8?B?a3ZvdXpTTHRyRTNzelJnT01WM2VsckF5RVRkYnZYUmVlRDBXQXpRTDl3UXRq?=
 =?utf-8?B?d1dCS0tyWVIxQnlRT0FVT2FvTXE5RHRNdDNvRUk0cStjcE1LOS96WXRPdlQr?=
 =?utf-8?B?SjRXeEJRUk1zOHl2Nk5ha1l1YWxqejdIY0s5S2xmWTM5N2xCMDdnOUxGd1hO?=
 =?utf-8?B?VU12b0RYb3lIeFF1eTloUTQyV1hKcmMwNDRTZnArKzRpSmc1a29Wakw3YU9W?=
 =?utf-8?B?SmhqSVBoYUZSRTdOa1g0UnVWTmdsRGdKeEVIYWFyOTZjQkhQTVpCUnFpdWR1?=
 =?utf-8?B?THhnbGhpVG1sTGhucTB1MHljdlh5OUZObjRmZGgrczNHaFRtSXZteEZHQjQz?=
 =?utf-8?Q?kajfBftLleZ/y4tK7ktzCAp2w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c859dfb2-5fd7-417a-17f4-08dd31434698
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:51:57.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLGet+NIAqB5yb2NsuElyr9Q7ZB6VOZRchJb1vFYcOCz9eWgtZ+CNRh/w9IksaLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

Am 10.01.25 um 03:08 schrieb Jiang Liu:
> Function detects initialization status by checking sched->ops, so set
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
> index f29a4ad3c6d0..3688e9eb949b 100644
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

As said in my previous reply we should really stop checking sched.ops here.

The scheduler should not be cleaned up by this function in the first place.

Regards,
Christian.

>   
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);

