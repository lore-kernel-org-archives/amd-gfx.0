Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53CACCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 04:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D32410E13A;
	Fri, 24 Oct 2025 04:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZ+nsPS5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A4C10E13A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 04:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgCijVtzYPR7v3nHddNxk9BOvwQjKiphO1zZxs+umMwJsOAi4FQDBe2YmFcNL4f1P/PgWR6eto+XhbAGQwdyD9ziKiBcppco19P+Mz1wqzQ/kgwAGGbwSKdJqjWE/ueFgVLNJFWdaD6TXcJvRhiAg7BmdFu2pykNV3XLq88nOHZNPdRbB46o5mkwMShZ4VW8HbGYT5OfgzrQLpIvyG5RE6Vqgi2/JRy/Q4yXcaOygUkqWlTwikdYQPEJBX/oyxIWJDqo4kFxigB1k8RmP3WGWAT+x1ct9YwKVa1WKJmVveNcvzStw8eQRK1DTPOkfO4LwofSVWX/R9JNoWbVhJk0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpeeww3yNCMMC+qOwjqmT5er9Crv6hzLmGHYxgZzcCw=;
 b=rrCzarRfMd4GHl6fYtBCXL5McNACbxq9RAbC5I03q/iocupbQz4ZLt0daryPjO63Oxl9QutG24rBHVpkcPMr6yiMByjBc5VB0y9FRUUdosscJi0S8jOPfAX8LJ1lPHlRUqZR3sC176A2odqD3RtAr/mPZ9VaYPnWH/AKYoqhma9CVpaDMa/hDOcJmvaYCwI+cUfVwLxLrBQ7lBbJoXK0B1O9nT0053g/sSvt35rG9LauTV3GEnECYEBUoDpugSWZkPB3qej6wXwMP/hVYOF6UftacrJ3IG35TcIuuywFtNwDiwpJv4mrKIt4pQ/vNHFfmNDMHQ+jFEV60hlFd6i6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpeeww3yNCMMC+qOwjqmT5er9Crv6hzLmGHYxgZzcCw=;
 b=hZ+nsPS5pGK8dOIVU3uyJAsBX/4iQ2ce8RYhb+EkZSvr2SMoCHwPuPO+X5pQ4wk7YGY83seKyUrX8cI0rXThSkHfPqghybkNx8bQuIERoqSohDVKZy1ivfiwkQ2nKV5WHXOG0ZFvqoErN9mafX5A9XgIYFCGcYrvDKZqNKAYlb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 04:40:18 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 04:40:18 +0000
Message-ID: <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
Date: Fri, 24 Oct 2025 10:10:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
 <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ac5070-5ed6-4091-cd8f-08de12b76ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVhiQWdXcWRUUDIxRTA2TTVuYzZDTmVjSVBpZm1ablJ3cW9vSFlTdzFxSU9P?=
 =?utf-8?B?djVLOUhJQWNUSGlzT1FXWWNLSFFxOHlFSXdGeE5GSkFQVGlFY1N0RDNZYnlR?=
 =?utf-8?B?ME9LWHhTTjFhODArRlVlOHVPeUI1TnZ4clVucDJycFhNa2YwRFBVT2NLL2li?=
 =?utf-8?B?RG14Wit0MzhTOVBuWmhqcWhqRGY1Mk44QXNjbzVKbWpRYmVUcTFoY3Iyc0Ju?=
 =?utf-8?B?a0pONThzODUwL0xuNjBqTmhmNzZiZG4vcEVTeW83ZWgyd0hoOTNKSTBHMEc4?=
 =?utf-8?B?NGsybGQ1Q0Q0WmdoWFlUemdYcXNnWGx0UzRzc2pFdUJ3bWRFZGtCRk0vQ0xU?=
 =?utf-8?B?Ym9SaHVLYlZLcENBdU5RYStlZlV3RzVZMXl6a29zYWd4dzl5cWdvaGRrVTlu?=
 =?utf-8?B?YVZhdXN2T0h1NmZWcUdHVlFDeEtqa2h0UGhXTzllZ2trUWgxa1VEZktORUs3?=
 =?utf-8?B?MjAzTjNEQThUSnBHZFJUTS9KZGJZRXBzbVFjRFc4YUtFbDNQcW1PR3N5QXE2?=
 =?utf-8?B?K0pEVnl3N0VaOHVGaDZDVFJKb2Ivc2Z2UzlPSGdtay9sUzhpOVlOeXNRL2Nh?=
 =?utf-8?B?bk4vemQ3bWd0NHlKVGppc1Q2azk1TlQ1OUo5N1g3ME1UK2kwY3FxL3Axckhl?=
 =?utf-8?B?WmhpUzkrYy9OSnRHR0FrMkdKQlgwRUtmR0d4UUJmY0VzdHRXaVZoREovYjJK?=
 =?utf-8?B?Q05hOHZnUEpIdGFrd29KcUVyNXZUc08xUVNjWm1wbklrMUZUcTdneUM2aWVC?=
 =?utf-8?B?cGY3T2NTQnlvanFLM1gwSENLY2JiU2ZmdjRReWxhL3gyNHROR014aXhZb2hL?=
 =?utf-8?B?blRLTlJiOVhyd0hWS2QxZXFwM1JpQ0VsWjVsbmViclpPMzVuUXBQdjJyWmxG?=
 =?utf-8?B?TlRMbUJaVi9UV3lqMGZ6VlpzQVpwUDQxdG8xSDVXYXMzZG9EN2JWMFpwM0tI?=
 =?utf-8?B?Tklyd2tYVEtlbUV1MXBFRGFyVU9lK0JrK2V6Z3FOUlhVZkl2bW1CVTVYTlFL?=
 =?utf-8?B?Vjd6YURHSFhVYVBXOEFqMTl4S29pb0xFMENYRDJoNi9iT21rbzJkTERsSWVH?=
 =?utf-8?B?QWUrLzNYVnB0UDhiV0x1cVRIWUREVmxzK1BNVWhvbkFzV3lMbldIdHYwNlVS?=
 =?utf-8?B?WGMrUWk3N0pQeW90ZWJDZmNIYzdEcFJ5cHAwa0xRRWpkM0h0TWhXOS94ZjNM?=
 =?utf-8?B?WjFtZnFvYlBkek9CYUM0a0EyU1EwcnJDV3NUNDZlMW9ZcFgwOWgzdFN2ZHg2?=
 =?utf-8?B?OTNBK2Z0QXRSQitLUzA5RVo2S1ZEQk5TMk0wNzVRNkNnMThqbzh2RXRpY09y?=
 =?utf-8?B?bWozMFoyUTl5cXlJVm9KRU1xamdnUEhLRlZxck5ibjkvS09wb1NVRWd2VzVO?=
 =?utf-8?B?Zlh2ay9DeGM0b0QrTkZZN0pFcHpackVVcHZFK3N5ekFsSnFkbkowQ05sVzVW?=
 =?utf-8?B?SkZkOWdYVVZhNVB0RW9HVlp5eWd2VXJpbTRTc2tRN3ZkZFo2eUJCL3lkZXRt?=
 =?utf-8?B?TlUzQU9GdHdiNS9vbHJ4NDJqRXE3czVsUXNMSlBZVDRiWGxoWXVLai9ZZzBk?=
 =?utf-8?B?aklFQ1YyVGRVVjRTUU9lMDdBbU1wRW85ZCt0dXExQVNyQ2F1WUV6R1hUSFJY?=
 =?utf-8?B?SFlGRnVpNjY5Z3VkZ25YenFPYjZqRFBWK2dkSXZqUjdRb0tpQzZjcjg4YlFF?=
 =?utf-8?B?ZUdSMzFOMDZzd2owdVJscFFSM1Z0dW9YM0VqSnJTUFk5OUV6TmIrMUd5b3Mx?=
 =?utf-8?B?elVzZ1RhNFhlaG1SRWxVSndLbnF5M1hZeWdjK3RzM1FrTjZaeVdDYjJMc0Q0?=
 =?utf-8?B?b1BzWHhtNHdyUSt2L1BoM3dSYXNBTlgyRUlHU0txQlpLbTBoc1dvTGc0MlhY?=
 =?utf-8?B?M00vc1Q3QkhCaEo5MjNQdVdpMmlDNk0zbUVncXdxNUVwVWtmWXNBdVBSM0Yv?=
 =?utf-8?Q?44ypLL1K6W8eGsF3FOqgm2LbNjek4HPo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWo4WFlESjhaWEVsMzh3eVpkZzIwOVAxekl1QnpLcHZiM21DVnVPaVFrWkdC?=
 =?utf-8?B?ckFrY05SZVkvemp2QlFKYmdqN1pmb2NIOVR4dXgwUTVDMDF4NFRKL3A3L0F6?=
 =?utf-8?B?WDVIREJJVkw4UGJtbkVrZEw2OTR1YXlnNzB4UmtnWERqcmc0NzVTUVM0RjRq?=
 =?utf-8?B?WDRFTGhFazZDakw0SFpvaUVtd0g2cGlvdGhHNCtHK0tzcTU2SW11b0Z5anh2?=
 =?utf-8?B?ZDdtb2cvd1pIN0xjY3NUMW9ZVG5yQk94Q29Mc3NETTlESThhQnVTTk5zNGxN?=
 =?utf-8?B?bGY1TFptTVFRK3dNNEVOYTNBU0NITW1IZ0Y1cGMxd25sdCs5OGRSbjEvaWNR?=
 =?utf-8?B?bm93UGRGMkx3TkpLMHBxcEF4bjEyWTJtcUNiOUZ0dUtYQnhCbXMwM29wNE4x?=
 =?utf-8?B?NVo3Q2l6S2t3MTU0RGoxbFQ4TTNLK2RvWWpJSm9Qa0sxempic1pidU5FVytj?=
 =?utf-8?B?ejZtc1RRd3FVVXJCZzE0Mnk4M1BlNnJ3SDhZaXRiQUw1VXEwVTVFY0g4dHB5?=
 =?utf-8?B?UzdNMi82K1Y4bXZxYUJHVVpRVlRRbUVZRnZRMU11RERDdEFLeFF0TWcyZmdB?=
 =?utf-8?B?NWlDR1BlL1Z4QnhXbGt4Rndzdmc1dFNkRkxYUlVHSmdZVXRRRmdpbEhtNnFy?=
 =?utf-8?B?OW9mdWhqOWdDL0lNOFpBRklEbzBadDZocGEwMzNMeSt3MUd4S3RzTzZqMDVP?=
 =?utf-8?B?aUJWeis5QjR6SUgwc0hiY01kOXRGTXljbmUwNVhjbFlBQWVWbCsxK1Q1anJG?=
 =?utf-8?B?UDAvOG5XN0d1YytoT09CTVdSMnh2Q20xSHlxa2tlQnpBR3BYTDJLOWNuQkc5?=
 =?utf-8?B?ZGdSL1pxZFQ1dGhNd1VWdnRkcE1keGMwNW1VblQxRHlTY2R4N1VYR2JGSTI5?=
 =?utf-8?B?S2R2VTVmak83OWVzbVZCR082MjZEbEUramdqSXVybzNSUEp4eEZvalBqOE9n?=
 =?utf-8?B?NThSd2c0cVRBb1RiU1NJQWJKRUpadjQrckJvbWozbzlFbERISGRqUURoZXVm?=
 =?utf-8?B?VlVHZFYvZURjMWFLbmQzUmJoTm9SUkFyb0dhVUh0Q1BDemRTM2pHanM4UDl3?=
 =?utf-8?B?WGVtSGhZYVM0MkNkS1dFZEladkdyUWY0REUwMEtXQTAwQjJjbzJwZldZd1VZ?=
 =?utf-8?B?N09qN1FkYXhWWWFoUjRvTXZaUG5GUFZhekcvTDZMQ2JVNlMxZWlHVmxGdWEr?=
 =?utf-8?B?Y1VidnVCSWJqRmJsTUhtRUplZTZwUkthVWdaUEhPcUFaazk1a1B4L0FSMngy?=
 =?utf-8?B?RFdzWGNpbUgvZFVjRVJRdGl6S0pnRlMxOXg2amhXZkVEWlIwU0xrNDE1b2dk?=
 =?utf-8?B?L25hR3VGalo3ODJmdjVieHdqMEtjY3hyRkg2azdvRFB1TGRlZi9sWUhWcWJk?=
 =?utf-8?B?cTJNOEVpOTQ4bTdteTR6WVhRYzU1MUp1bzRLMkhzUzM1bFliNk9hZ01oZ2pW?=
 =?utf-8?B?dm1TN3dDNVE4TVYvK2trQzFEZzVrdkZZV3hpT2RPd3pPUityc09YS2VkZktB?=
 =?utf-8?B?bWptVVozdTg1Mjlzb0dwd0hrdU9OZklDcmlZbDM3RnBmcitSSWZxSHBpSGFP?=
 =?utf-8?B?SW1uNjgwZkZScXFma25VOXQ1M1R3Z2pqZWdpMTA2czNvYmh4TUt4V2dIcm10?=
 =?utf-8?B?NGNUclVFWGx2NW5HNjBGa0UrUHVRbXA0eUM4QlZpSVA1Ky9OcDQxRGZEWmQy?=
 =?utf-8?B?aVpRNzFrWXBwbDIzOHhjQ0w0emVZQ0Q0TmVrWXA3NmxWZU4zejJqd1hpQ0ww?=
 =?utf-8?B?QkIvcThYZGZIZHVPclRNcjFjSmh0VHFsWStXNVFWcFRXSzJLaU53MCtTbmdR?=
 =?utf-8?B?MTkzSFFUS1U1MCtLdnRmZkFkek1JS3BnaW9keUJxb2VaZW9BSGxEeGRMTFp4?=
 =?utf-8?B?S1JHMmxBSGlxb1RBcXE0a1pFOUhXQUFFbVB4MmxvaURCWkpRdzJFdk9oVEZT?=
 =?utf-8?B?QjhuZ0N2MnhVZk9TRFA2TlJFZWZPN3ljQ3VuUnlKN3k2TWJPM1NuRHdmOUow?=
 =?utf-8?B?ZjNYS09LWXgvcWtnbnU4MU04R3JiR2NnMGNVQk9zcWJvS242T1l4VEJiUCtT?=
 =?utf-8?B?OHRJc3dlbEM1Q21tVWI2V0ZZNHRWb2l0Rld5RHFZT1VWV1pSbSttUmhnd29L?=
 =?utf-8?Q?FR6QYFJFLFZ1zgeWms4Wyk5JM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ac5070-5ed6-4091-cd8f-08de12b76ef9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 04:40:18.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MBrml2jwGBJ4dHpgz2duH3WMhBZj/rTE6h9YqoqNecrosFd1dpGFp4Fu+4MFrHLyVukMtMbbDSS9kWNs2gQ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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


On 24-10-2025 09:20 am, SHANMUGAM, SRINIVASAN wrote:
> [Public]
>
>> -----Original Message-----
>> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
>> Sent: Friday, October 24, 2025 3:15 AM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Khatri,
>> Sunil <Sunil.Khatri@amd.com>
>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
>> svm_range_validate_and_map()
>>
>>
>> On 10/23/2025 9:34 AM, Srinivasan Shanmugam wrote:
>>> The function svm_range_validate_and_map() was freeing `range` when
>>> amdgpu_hmm_range_get_pages() failed. But later, the code still used
>>> the same `range` pointer and freed it again. This could cause a
>>> use-after-free and double-free issue.
>>>
>>> The fix sets `range = NULL` right after it is freed and checks for
>>> `range` before using or freeing it again.
>>>
>>> v2: Removed duplicate !r check in the condition for clarity.
>>>
>>> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails, we
>>> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still
>>> pointing to freed memory. The caller (or amdgpu_hmm_range_free(range))
>>> may try to free range->hmm_range.hmm_pfns again, causing a double
>>> free, Setting hmm_range->hmm_pfns = NULL immediately after
>>> kvfree(pfns) prevents both double free. (Philip)
>> what you fix is not "use-after-free", it is preventing double free, right?
>>> In svm_range_validate_and_map(), When r == 0, it means success → range
>>> is not NULL.  When r != 0, it means failure → already made range = NULL.
>>> So checking both (!r && range) is unnecessary because the moment r ==
>>> 0, we automatically know range exists and is safe to use. (Philip)
>>>
>>> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu
>>> version of hmm") Reported by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Cc: Philip Yang <Philip.Yang@amd.com>
>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index d6f903a2d573..90d26d820bac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct
>>> mmu_interval_notifier *notifier,
>>>
>>>    out_free_pfns:
>>>      kvfree(pfns);
>>> +   hmm_range->hmm_pfns = NULL;
hmm_range->hmm_pfns isnt set till a goto out_free_pfns is called, hence 
not needed.
>>>    out_free_range:
>>>      if (r == -EBUSY)
>>>              r = -EAGAIN;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index f041643308ca..103acb925c2b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct
>> mm_struct *mm,
>>>                      WRITE_ONCE(p->svms.faulting_task, NULL);
>>>                      if (r) {
>>>                              amdgpu_hmm_range_free(range);
>>> +                           range = NULL;
Range is a local pointer and if it has been freed it should not be used 
again in same function. The error condition should handle that.
>>>                              pr_debug("failed %d to get svm range pages\n", r);
>>>                      }
>>>              } else {
>>> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct
>> mm_struct *mm,
>>>              svm_range_lock(prange);
>>>
>>>              /* Free backing memory of hmm_range if it was initialized
>>> -            * Overrride return value to TRY AGAIN only if prior returns
>>> +            * Override return value to TRY AGAIN only if prior returns
>>>               * were successful
>>>               */
>>>              if (range && !amdgpu_hmm_range_valid(range) && !r) { @@ -1769,7
>>> +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>                      r = -EAGAIN;
>>>              }
>>>              /* Free the hmm range */
>>> -           amdgpu_hmm_range_free(range);

I guess we are setting up the error and that should be the criterion to 
call this function. If there is already an error condition before we 
should not be calling this again.

regards
Sunil khatri

>>> +           if (range)
>> Can just check if(!r) here and remove "range=NULL" above? if r is not 0 range has
>> been freed, if r is 0 free range here.
>
> But there are later spots where r becomes non-zero after get_pages() succeeded and range is valid:
> svm_range_dma_map(...) can fail → sets r != 0.
> !amdgpu_hmm_range_valid(range) → you set r = -EAGAIN.
> !list_empty(&prange->child_list) → you set r = -EAGAIN.
> In all three cases, your new tail logic if (!r) amdgpu_hmm_range_free(range); skips freeing because r != 0 now. Since you also removed range = NULL; after the early free, nothing else frees it → memory leak.
>
> Regards,
> Srini
>
>> Regards
>>
>> Xiaogang
>>
>>> +                   amdgpu_hmm_range_free(range);
>>>
>>>
>>>              if (!r && !list_empty(&prange->child_list)) {
