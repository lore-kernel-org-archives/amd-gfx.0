Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA9C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 11:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A74A10E4F8;
	Tue, 30 Jul 2024 11:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kuTzXRgS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E00D10E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 11:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyYOENNXDIToHnaQOgeXiEN0+V0eU53QzKlp6zFTB0fQh+KhKQyGBAUIT1FlCQkxr8vBV1jX2dl/fu5K04QRbGQd7kxO8sdRzWTnyK0+iJzpBNLmsMDFj6ToN88OBNNkGsnA8RkwbEX+N0nFwAYirSwjjCfU8QfT6Y/PCMPrhxIf6C3dU/8HtOBBKIcqr/PZgxVlum9fpsNV+o3rpTTacADJcNqoiXMYYJN5FLkxKZI5TLRbH19V3hHp92FICGPKkYzEFMWYhXHvbU+Enlhc7Z5LSFWIt0Qn7ZWem/cLi2xayQmVKif1+6rGI4MNs7Fb0baBkUrfAzV86/wqWQuvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRSWR91YVdTjPTVpU5IKvg+n73UHC53biogtcXZAC4o=;
 b=wsyOb0srVlRDvbJLLIOMTm1WQ+W+edPAiV+PRG++g3BdhWu/FqjHJWlUYjVmkcCRxiCl1fZo53okuK3ENeJCzGs4TBs6uwb0VwZV+k7+fMpYopfHsNFyEy/hXJf8vlnCktI0iqP8JG07S5Bin67tIKyeMfXrAYNgAPsGD7Wx2iFkdkKWwGm/E0BrRlDuTFqUz+wgtQ9fZpSUxfynNo7vGvjjzB8a/Clge0uoqLwu+gAYzqCqoTxUgdxvqaBnmt/sYUw4Qw8n0E6xKetRYXrmZSTceNt6o/mdPtpuagxUu35fHVTu5JqPccsKt1hgKq1E/3Eeft8FLagl3mwbdNnL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRSWR91YVdTjPTVpU5IKvg+n73UHC53biogtcXZAC4o=;
 b=kuTzXRgS9sX3wf1l2dUPuSyJ7nIP0t1NWzLRHb9hFPWp4Tmfsr1HxAtLyQAj8v5r1z38loA8/uI8Pd0g5yFe6dXzRSPjbo/QdxnvaEArNMUvz0g9+i9kWY6hJaB9xDDYc1jOIumfa85NVL2TNDf/j3bp4Viv7D7DYiT3kScZFC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 11:25:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 11:25:01 +0000
Message-ID: <7bd92962-ecea-4539-a307-da54d022450b@amd.com>
Date: Tue, 30 Jul 2024 16:54:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Remove debugfs
 amdgpu_reset_dump_register_list
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240730064448.4187459-1-sunil.khatri@amd.com>
 <20240730064448.4187459-2-sunil.khatri@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240730064448.4187459-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cf46e4-4022-4195-5080-08dcb08a403c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjZOYmFDZ3R3Uk9WWU5zZVlERFRTVmxzdXdtNzA2QTU3aFIvTVdXNXBRWFhM?=
 =?utf-8?B?b0c4cTR2VTQ0Y1JjL24yU3B0YzJaR2g1Qk5ldWdxY2U3UkVMelpxdnFqZUx3?=
 =?utf-8?B?MFkvZkFSOG9pSExHYWI1SjdCdnZzTE9LekNQUnFxMWJnVjVHWkVTaTRXZmcr?=
 =?utf-8?B?aTlmUWduZG9ORVhBb1ZqWHF5NE1RRitJazJCZmpYWFlsZ2hHNFlROFlzb3VS?=
 =?utf-8?B?U2RuQ2lKUU11amVtV1Y0MmVFOWpDc1lEOXZvWklVMW9aaktidEY2cXlYR0h4?=
 =?utf-8?B?R2pJSUlRMG1ZQkEvL2ltZUtpSUc3SG0wb3g3a3RkYWhxS0o2czFTM3gzQitl?=
 =?utf-8?B?NTJMTWltN2c4WGcvaFprTU4waXhWVlRRckZBTnVlOUs4RjFjc1RaalZ0Q2ZM?=
 =?utf-8?B?YzFFSlN1ZGVjVFA1cXREdmRxS2Z0NlVJdEdWeWRtWU1IdzQ2emdyVXlFUW1j?=
 =?utf-8?B?aVJmLzMwb09ndVg5azhmUm9oZHBJYzB6d3J3d3c3amZsQ2MxaEpWcWtqMTBa?=
 =?utf-8?B?N0Z3bGJnTzB4bEJyZVNMRWRoa2l6UG8vSjhMQzRZdVozbGVNNHFWZkNKb0No?=
 =?utf-8?B?WEhqbW1jeEVmenBIYTRSM2o1YmRNemsweUI4U3B1VjJyeUdiWUVNbnVPb0o0?=
 =?utf-8?B?THdrOEdCY3cxbWVRaml6STJZTGg0VkYxN2Q5V2ordldGWUs4MjA1bVJNbjVy?=
 =?utf-8?B?L3M0OE0weUpqRnZkSFQ4NldBVGhLejdtUG51Z0ZPK1IxcW81UlhKQUhDbHk2?=
 =?utf-8?B?MU5RSmo1c3p5d3hGamFPQ1EzMHJlempjT0tvVjFXOEpsU0NBTkZyYmxsUDY3?=
 =?utf-8?B?SWZick16bFRLUm9NbCtHSkliRUp1RWgveEFrelIrcEx3dEhIUnVXeHBuRllq?=
 =?utf-8?B?WnE5SVhuQmJ4aWhVQ0ExdW1iMW5TcDJLb3FWTDFjSHZCNENFRmdLdVUxN3dx?=
 =?utf-8?B?bXdaUnVmVVplTUFxMjJtWUtPcjl2Q3ZPcXByWUxwMGxWOTVqT3FmcnhjanBQ?=
 =?utf-8?B?MTEyQ1l2SEJSSmxETm9KMUdiUk1GcDBqcWVvMmV5Vy9Pc3YzYS93TUlBaWpt?=
 =?utf-8?B?MnNRRXg5R3VKZGgyTUJ2U3JaRXJLYVh2d2xMTVk1Rm5odGdrZkRxaDdTb0FT?=
 =?utf-8?B?Vmc1eUUrc2l5ZndSdWtrdXl5cEk2eHNRVy8raFhoSCthbEZic0tub1JXdzVn?=
 =?utf-8?B?alFhQkxib2NJSmFRN3FVd3FFZnpxQ2NyNXEzN292czEzTmxmNFFVRzdJaDB2?=
 =?utf-8?B?ekV4RFZMNlM4TGtRNWQ5MVlQTkIrTWtjQytxeXFMcldqWnZNeGt2VFJvMTcr?=
 =?utf-8?B?a1VBejNhdnlVMTdyMm9FWWRsb2ZUZjVxV2RUYzc5RWFZK3U5Umx5Wkl4a3Bt?=
 =?utf-8?B?WDJOZ2lJVGZGOUk1YXMyb3dKQkgvWGRacmFxYm9yNUo5TU45R3Fmdkw3YXFv?=
 =?utf-8?B?WXByb2pHU0VvQTNlTlNEMXBtVjNSdXVHcEtGa1A3NDdld3o2U0ZZKzU3U0ht?=
 =?utf-8?B?UmYwMjJFd25ERlRuYkVtZ1d4d09BR1h2dVlFZ0RXcXJLNi90c1RFMTgyVjZW?=
 =?utf-8?B?UHkva1BsSFpvVUZuV29zZEkzU1BOMjJCSW93MU94bitpdStpbDZXNGZzUG5R?=
 =?utf-8?B?TUlGNS8vdWp6WVRMM0NEME54ZXFPU3JMRXlQTE5DT1VsTlF1N1ozZ1pJK2hJ?=
 =?utf-8?B?dnJQSmZsM1dIcXNRTXUwYWFXdjc4cmpybnIzT256aXhkQ3N0YXdCeWlraFNJ?=
 =?utf-8?B?MlNJTWR3eWJLRVV5V1NKbXVVK0RjaVpoWWUwdGdKRlk3a3NCNTczM1JRQTJT?=
 =?utf-8?B?VDEzS2htd09qTnpVRlNXUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWN1YzVEOGh3WjJLazg4d3dFT3Rya1R0WllGTFZHcmFaOTRIZStZY3NnWVQ4?=
 =?utf-8?B?K21rbGlsMi92TGIwTFdFcnAyeFMwbWQweWJmQ0FxaVhlOHl3SFBMa1dqMnVo?=
 =?utf-8?B?U1pzRnc1Q0g5OURJbFFFN24xenM0WjBvcGlnNHl4S2kwSENlbk1YUnRLYms3?=
 =?utf-8?B?UmUyZnQrYkdsSHJTRk5IOE4zOExSQXZJUHdJRFI0Y3NxQ3c2VG0yZXVtc0Jt?=
 =?utf-8?B?RE03T0JjVVd6MEE0L0FFUkhMcjFOWFlpSHhwTTFOQUxTNTgyajFWTzZTc3Q4?=
 =?utf-8?B?S2twYU1HWW9lRGlJSzdNL3p0azd3TjRJK0d4S1VjVUVWU2tUOUhMSU93MUNG?=
 =?utf-8?B?YXhWK211L0tjeHROTzIzRU9SQWJhV0tvSUJFVTJhcTU0WFNpZUkySDh6eVMy?=
 =?utf-8?B?SGt1czhRN0tDS2IxUkI5Q2U1US96RXZQL29KL2NrZUV2cFFPc3gzR05Wb05E?=
 =?utf-8?B?WGtzTThIREREZ2thMURXKzdPYUNiQ1drV3FaMlBpcmZkMGxTYUxJNzNxdW9j?=
 =?utf-8?B?OS9Qc2tBcXBZTWtQVDduUlA1MDcrVFgvVGFsUXVtcmVWRWRzTGt1TXlwVU42?=
 =?utf-8?B?azhVeWdNemtxM016Vm4wbzZQZEFTcXduZ2VrUHZvVXEzWklNZ2U0d1d1ZDZU?=
 =?utf-8?B?WlljZWpaa3QwaFRJS0o0em84eFlnb1c4SXUvRm12WHliNmF3eXFWS0Zrc2FN?=
 =?utf-8?B?QUJIakZxSDhvVVdBSU05a3dzQ0EvNEtjcExsRWlEWWdSTmp6KzlUWUI2YjA5?=
 =?utf-8?B?bnZhQ1N2ZXRpTDVJeW5KeitzUWJhcm9zUnpXTGdnaVBYdENWSVQwSmt4RjM4?=
 =?utf-8?B?UHBMeWNMWHVLVHNzRWp5eUorOEk5amlGdmp6WTdrVnI5WDl1RXBVK3hBV1Bz?=
 =?utf-8?B?MTAxY2IyeHRpRU1RR1E4ZkU3U0drajFha2RndTZhU0QzbERCTWxBK29Zc3dk?=
 =?utf-8?B?MTdxU2NkM293WEVMVlhyNC9QT2Y1cjRCODJOM2JKSE1IaXZqQ2V4TS81K1NZ?=
 =?utf-8?B?ZmIxY0ZLdnFZajBQdm82N3liMHVOUDFhNjU5SDltak0vYStFVVFWUG5PTGpS?=
 =?utf-8?B?NFMxQW1Ca2NYc2tKZTJSQ2c4RTAyR1lXTHE4bElPbUhBMW5IdklEc0dhQVdC?=
 =?utf-8?B?eFM4YndkNVY2K2szcTJVc1JSd0Z3ZEFPWDhHcy9hcGhvRDJwSklJZ3hhbnJm?=
 =?utf-8?B?ZUVVeE1BRHdSais1aDM3NVpEcVR1K1l2YXYzdk1OcnlUSzVGeWcwcHE4d09S?=
 =?utf-8?B?SjA1eVg5Y29nNy85MnZWYW1qNk10dXBUV3k2OTdleHI5ZGFBai82WjJqY3Bt?=
 =?utf-8?B?WUlxYUhXbmV5V1VQWFJLZlppWFVNeUt5U2xxdWgySXlJNnhVOWpVbHBTTG9C?=
 =?utf-8?B?WEVpTTFzL2pUeEk2cVBoL0R0NGYxRk9pOFd2Y1IvWW12d05Ha3hXQ2ZFdm4v?=
 =?utf-8?B?SG1JdXdtbFZNYTZ1Ym5DWjJFMDR4U3BmdFVSWFdDMVNQNGpHTm1RNUV1V0NJ?=
 =?utf-8?B?VU41bmN5L1FSMXFsTm53eWRESU43Rnhoa0hmMzYyQk1KRTdWakh0Zm9GbTdp?=
 =?utf-8?B?Rk1tdkY1R3RGWHBpUlhQSkdmQWcvTmQ5dXl4L0p5WGprdWxIb0VzbUQrbTZP?=
 =?utf-8?B?Q2M1NW9yZTFvTG1ua1kzc1BCWEpqZ2VkdFRTa25vMDJVQ3BQbi9BM0R2Nkh1?=
 =?utf-8?B?Mi94ekVrWGZKNWlOQ2FBSlkyZ0hSaHJDUUNKcVI5dEpCN21yUEJCM2o1QU93?=
 =?utf-8?B?ODlwb3NWaEhkK2s1SXFJN1VVKzMvMzdiUWFvWWY1dTJPZFFGQi9CbHdHWTdu?=
 =?utf-8?B?WGlFQmxjb1Y3ZEhxOEZzbW5mMG9hR1FtUEk4VGhHazd1TGpjZmxwRmRzNFl1?=
 =?utf-8?B?eDJLUXlPZ2xCeGs0cjVUN0RuVW9uN3cyalFvemw4dy8rdDVoT2UwRUIzWmYy?=
 =?utf-8?B?L1EwdE81U3BoazUyZXFaRTMraFEzdDQ1T0xicjRXemRJY09tN3Q0OUxQb3lr?=
 =?utf-8?B?TnhXM2xyV091Q1IrT1RSY3lxMkk1ZmRDbmhiTnVMZE9RYzJqbHUxUmduQTBP?=
 =?utf-8?B?L0dYUXI0RXNRSEFHazZEZmNBRmtncGtvNlBWeEQrUHJvbFlvZFYyMzY5bDJ6?=
 =?utf-8?Q?KIVrxCCHLQWMGqcPasSmGQ9L/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cf46e4-4022-4195-5080-08dcb08a403c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 11:25:01.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBVv2CHhGfYN1RTNejlXyRQmRTZsEOtBVCEle8U/AFU6s1JA1tWHP1pqxmdDvVLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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



On 7/30/2024 12:14 PM, Sunil Khatri wrote:
> There are some problem with existing amdgpu_reset_dump_register_list
> debugfs node. It is supposed to read a list of registers but there
> could be cases when the IP is not in correct power state. Register
> read in such cases could lead to more problems.
> 
> We are taking care of all such power states in devcoredump and
> dumping the registers of need for debugging. So cleaning this code
> and we dont need this functionality via debugfs anymore.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 ---------------------
>  1 file changed, 96 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0e1a11b6b989..cbef720de779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2026,100 +2026,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>  			amdgpu_debugfs_sclk_set, "%llu\n");
>  
> -static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> -				char __user *buf, size_t size, loff_t *pos)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> -	char reg_offset[12];
> -	int i, ret, len = 0;
> -
> -	if (*pos)
> -		return 0;
> -
> -	memset(reg_offset, 0, 12);
> -	ret = down_read_killable(&adev->reset_domain->sem);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < adev->reset_info.num_regs; i++) {
> -		sprintf(reg_offset, "0x%x\n", adev->reset_info.reset_dump_reg_list[i]);
> -		up_read(&adev->reset_domain->sem);
> -		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
> -			return -EFAULT;
> -
> -		len += strlen(reg_offset);
> -		ret = down_read_killable(&adev->reset_domain->sem);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	up_read(&adev->reset_domain->sem);
> -	*pos += len;
> -
> -	return len;
> -}
> -
> -static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> -			const char __user *buf, size_t size, loff_t *pos)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> -	char reg_offset[11];
> -	uint32_t *new = NULL, *tmp = NULL;
> -	unsigned int len = 0;
> -	int ret, i = 0;
> -
> -	do {
> -		memset(reg_offset, 0, 11);
> -		if (copy_from_user(reg_offset, buf + len,
> -					min(10, (size-len)))) {
> -			ret = -EFAULT;
> -			goto error_free;
> -		}
> -
> -		new = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> -		if (!new) {
> -			ret = -ENOMEM;
> -			goto error_free;
> -		}
> -		tmp = new;
> -		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
> -			ret = -EINVAL;
> -			goto error_free;
> -		}
> -
> -		len += ret;
> -		i++;
> -	} while (len < size);
> -
> -	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
> -	if (!new) {
> -		ret = -ENOMEM;
> -		goto error_free;
> -	}
> -	ret = down_write_killable(&adev->reset_domain->sem);
> -	if (ret)
> -		goto error_free;
> -
> -	swap(adev->reset_info.reset_dump_reg_list, tmp);
> -	swap(adev->reset_info.reset_dump_reg_value, new);
> -	adev->reset_info.num_regs = i;
> -	up_write(&adev->reset_domain->sem);
> -	ret = size;
> -
> -error_free:
> -	if (tmp != new)
> -		kfree(tmp);
> -	kfree(new);
> -	return ret;
> -}
> -
> -static const struct file_operations amdgpu_reset_dump_register_list = {
> -	.owner = THIS_MODULE,
> -	.read = amdgpu_reset_dump_register_list_read,
> -	.write = amdgpu_reset_dump_register_list_write,
> -	.llseek = default_llseek
> -};
> -
>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
>  	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -2204,8 +2110,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  			    &amdgpu_debugfs_vm_info_fops);
>  	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
>  			    &amdgpu_benchmark_fops);
> -	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> -			    &amdgpu_reset_dump_register_list);
>  
>  	adev->debugfs_vbios_blob.data = adev->bios;
>  	adev->debugfs_vbios_blob.size = adev->bios_size;
