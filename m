Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7D9CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 14:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB2A10EAAE;
	Fri, 24 Oct 2025 14:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dEeyL/I";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36BE10EAAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 14:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVSCiHuBHjAV7s0mrtYtJacL9n4CBUnJstlgzwKmXBEpGRassW2getgre9hr8ZJtthugkvmKsOOtjrvmCHo9MCy9zH5pRFUbZoPwxfT8eBO0uoHZDxuiiBT+VQtk7a3m5I3Pa5PER7CbbnH36nY8d4wC/VEU9e9f4CvNLAk8gS5GFWyOEFWcO0HwGJTr2RuZ7+eNOoJRukWrw7pAYLD55WVT+Kx/JjIm5zwXHgo1gLmx/1kmIgZqn64XY8ewxDAiNhKCGb67+sUcs0YplrrQOQy0vj9Kq7g9XtSgVkjsk16aiMZcaD8QeYvBPZUcOPk0PoXfQRCVPOZuHkAZXNuDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJYtt6uWVeaC1IMMIi/cwLAuluh6lIQH76+B3Ekyd5I=;
 b=slOuuQwoD4+upHzg2uA9EGDhpqsaHyhLi2a7wvV2yrurv4eDvmLoMcbIgFLY8Pp+tiA/YyXIT/26dH5CO+iQjfUgQ0WHTuz5wzdJwdar09b9Gz8YMW3NE/8CEbvB1w++0vkWqHxjfJZUvRJ0uqkd7IqMXhwBhiK6FfZ3UqnenS/ZeU5T+O8zxaMEHBT7E3GL17dNKXMxTK42J5KjWWCOriR4KbdRd8lKIPu9LK3uvwDhL0QGrgC+Rs0HYjiJPUPqZj7+zvF0tGemVr739xt7websiMMtGy1Hxm7wcjc8hBt+uStd3hFbSxDVbURkvuud7xNAfTKKSHv8yU0pFUmnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJYtt6uWVeaC1IMMIi/cwLAuluh6lIQH76+B3Ekyd5I=;
 b=1dEeyL/IZtH4v9sgC1z4oE6nJGiNtg0VarcCopVhorWVE3rigR+qQ8grIdU3ci5Mae/J2acR7Cw1uyS8wfzWvYfgHGS0WuLhO1/KTwqy36hYUmHokXhgjl/AHSd06/m2TJueMEHr4b0g8GmIvoXXg+SdueKPm/KeDDiyzZPJWew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:49:53 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:49:53 +0000
Message-ID: <3638b609-ed39-d19d-f7a9-05c85972d0e6@amd.com>
Date: Fri, 24 Oct 2025 10:49:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Content-Language: en-US
To: "Khatri, Sunil" <sukhatri@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
 <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
 <IA0PR12MB8208E2BBBA8D41F85A86BDA990F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <06bbce9c-f5c2-41bb-b949-4ee89c945cfd@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <06bbce9c-f5c2-41bb-b949-4ee89c945cfd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: f6981026-b20b-461e-7e76-08de130c9748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGxsNDJOUnJkREc2OXJka0M2ekNYZHVPNk92S3NRZ05NRVllSkR0V2Q5OUpq?=
 =?utf-8?B?dUErMDFxSW55SmM0QTFJOVNVVjZzOUErcThuTm5xVVBUWjRZN2EwMlNEOEwr?=
 =?utf-8?B?d0Flb3dyWGY1SStBZmFRZmtDRkthQWFtMWljT0hxL05PbGM4ZFVUZ242NE9I?=
 =?utf-8?B?bGVmcEg1bUFRd1FaK1ZNS0oxUUhMU2tHNXVIcStHNVRvN0tSTlYwaWdMSnlL?=
 =?utf-8?B?b1VpdHZHTHZENXJwd0N6eG0yWStZNVpZYjg1RE1VWlFWRTVyakllWTVqTTV0?=
 =?utf-8?B?Tld3T1ZVMEsyUUFJYUNwanBqSjlWcmlIWXA3VFhJazhVRjA3czJ4a1pLdnR3?=
 =?utf-8?B?U1lEN0tHVk5rZmcxODNDRnZVRGRwZSthbmdadVhtS2pRSUV5L1pzU3lvd1oz?=
 =?utf-8?B?MHNIZ2pRL1dBUmJiQU9pZ21qQmpQTDM2OUtWTFJwNFRqTWlGQmhxWm9mWTJp?=
 =?utf-8?B?RkFtM2IxQlMwbGh4K3BRL3diUjFYcWhob2EzOWNBUVlQR1VPK2pqZS81eGJJ?=
 =?utf-8?B?N3FWN2ZuRmxMOTBYYmY0QUowRmtrSWNNcEFtUmFHa01vaklXSEwzaTcyYXlq?=
 =?utf-8?B?Wms2dzk0c0pJb2lVTVd5cWU5OVAwT0IzbmJXVWkwZXZBWXh0cWw5RWRYOXNh?=
 =?utf-8?B?RjRJVGhuZ3ZVTmRVaWcxOG5IUS91c2JNcmtRdFdDa1NHdm44Z2Y2ejZxa1Fs?=
 =?utf-8?B?QTUveXRaVDFPeGdyVUVIWEdsSDJwM1JJL09RZkx3dXk3ZTRLUDUxQ2xzS0tW?=
 =?utf-8?B?TktGTWkrSmFNZ3dTZno4ZXp1UnRTdThCMVF6K3plSnprUVZ3bUV0bnlQWGpV?=
 =?utf-8?B?b1RNNWNDd2kvUjJXYWkxVXlndE9EWGUrVmI1NUZ1WDBEU2lsQ1R2cWNHQVBl?=
 =?utf-8?B?Q0JsalJ1S3hBcFFha0U1alZ1dk1sUDFjMUxXWlZQNzkySjFWNjAwR1lYNDFZ?=
 =?utf-8?B?dy8yZVJKWWxONXlNTXlDaG0vQUpqTmd4SXpLY0hqWmRjbCsvb2ZtQ3lNQ3RF?=
 =?utf-8?B?S0tDOFBzMk5Xa293Smhiamd6eGlpNk9BSmdDRDZiWjdidUtWalFFM3JpVmYy?=
 =?utf-8?B?OXdQZ2dxUW5YcG1sRmFFaGZuODBUUUkvQXBZbjk1eFVlK3hBK1FWUGI3TkFF?=
 =?utf-8?B?cTNhdnZsaFJPUnVBenJpL3NjNE91elVSUStJYU5peFd3ZFlEY0VucVpQYzVH?=
 =?utf-8?B?MU1ZWndWOU5MNFZ3b1p6UnpCRGE4VkNEVGRxVzBOUE52alphaWxYalNjR25y?=
 =?utf-8?B?TllxYXl4M29GdmUzTE1IUzdETnNEdktYODZLUWV1MWo0dFpSYk5laERKNTFw?=
 =?utf-8?B?cUY3YmFHZkFPWmtweU1lYTUyVjFTV1N6MEQrR01oRDM2UFk0RG1TK0JYcjdK?=
 =?utf-8?B?OExCaEI5d1Z3Y01FaGtSbWZmOG5sM2RNMEhHU0ZCMUJuVkMwQlArUmRJMmdW?=
 =?utf-8?B?alJwaGt6NnNwT0JXbXJUMkhuR2lHOUwzcXhXZTZSR0llK1BCREhONEpCZlY5?=
 =?utf-8?B?RDBLOHBMZXlKWWtJMmtNM1lSeEpjQlVnenUwVDlYS2ZJT1Q5UVRCb3M2N0lU?=
 =?utf-8?B?WEZ3WndmMnI3aHN4MnowYkJ4UXBwNUR2dkVLL2tBNFkrVnpHbVAxdXB4Z0pJ?=
 =?utf-8?B?WUw5UzBwZWU0NlFjTkdvTlhVSkdGUzBpSXFaQmJhaDRUT0xnb2ozb2JUaHkr?=
 =?utf-8?B?ZXd0alRFYVkxQ0hydmFGYzNHWk1PUXFuajVoVjErUXBxSitrVlpRYzdYRUwr?=
 =?utf-8?B?TFBTOWdLOGtscTBlMlVmRjdGRnlWKzc1OW0rQzM4VE1QT2h0YktPMW90Wnk0?=
 =?utf-8?B?OFQ0UHF5UkRSYXg4WmRseDlFZ1FiMkxORWFlRkt0d0xGUHdJSXNUTXFrNzlt?=
 =?utf-8?B?b0pITzRRK0htUFRuK2hmaUhJa0YyU2ZyUXF3dVh0MURVczhvbGNZTzNpNWgz?=
 =?utf-8?B?ZWpicklWc3o0NFY4Q1JvZzE1U2hTQi9kdlN0ZnRoRFdZK2htN04rNDl0KzVE?=
 =?utf-8?B?UnVKekNEanpOVkdQVDRsMjhKdUY3U2xFTFRnSklUUHZuNWhWWWhtV25QS1ZR?=
 =?utf-8?Q?m6sHLN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRPcE1uQUVKYlZRRVVqUzBIMllTN1VyZFVGOEdSTy9hcFZ5em1yTEN1VHJr?=
 =?utf-8?B?dEdpNzE2TTRKZE51UFVaM0RuV2MrUTJyazkxcDJTL01zcjE3RzBLSDNSa2Nk?=
 =?utf-8?B?SVVrR2VzK2tvdGZYdU80dlozVmVDS3U5YTJsYWR0bGE4c05LVG9jbUxoRGNl?=
 =?utf-8?B?YkdhZjJzb1duSzV5UHppdGRLVXBqRWJBeWlOQyt2TC9jQjAwVjd5SWtUN1BV?=
 =?utf-8?B?ak54NXBmOHhUWXQ5RXFjMkdXL3l4a2J3ZzVjU1M0YW9GN3FHbUpXQVlIa2ZR?=
 =?utf-8?B?Y1loTjhROW1MRVRoTjZLa2FEbHdTWXdOTm8yU0dGY1o5TWgzbS9DMnVEM1l0?=
 =?utf-8?B?S01PZ1RzaHYzcUowcy82WlhncW41Tm1ZVmkvalBOWGNHSURUR0NUcmFHNk83?=
 =?utf-8?B?SldyZVoxcGxtU1NIWTgxZFNtYkFJd20xZUdKcCtxWm5yTXNDcVRlTSt5ZlpJ?=
 =?utf-8?B?MEJORzRGLzF5OHFrM3IxNEIrYktoNmRJd2ozdjEzamFtbktCUml2Ym03ZDBp?=
 =?utf-8?B?MWVxS1RjaFUzZjRNU24rU1FtYVVsckxzY1NKYmthaEdnaSs3djl1U3lyMEhD?=
 =?utf-8?B?K3JBNG5HSGZiSC8xL1BYa29LbE5CQ2RZT1F6VHh5OGFaSTc1QUgwU2I2Ulhr?=
 =?utf-8?B?VkNUQXhBOWRFdm1ZSjFwY1o3TWE5cmFiRW1DdWw3SVBvZHhyczlzajJOcW1t?=
 =?utf-8?B?czhRaFdlbVBkVzJWZlBKdy82T0F6cVdLcVo1eXIzM1JWU1ptb3Fxc2NzUnp5?=
 =?utf-8?B?bDFaYUt5TS9wMGpScE5pOHRrd0poVlJ2aXYvNW5jRm40M0VSRVlZZGRadith?=
 =?utf-8?B?YUNzdGk4Snc4L01ESFVlWTdGdWtEbmxvSEFDRU43Rm5KdVlRcHlIbHlnRGkv?=
 =?utf-8?B?dk1ZVVVGaWtza29FU25jT0pKRWFZSE9Lc25HWlBaR2ViRFZOeTlDTHpvdHdU?=
 =?utf-8?B?RTlndFFRWDJlTlFqWXdXL1JhS2xHeGNUY1U1WW9INE9IVWtzdm1GdmRpVjBx?=
 =?utf-8?B?ZHlIVnFmZHNraTVydnppaDlFK1M0RHY0TWlSWGVrTEd1K0pXYlJsQjZnMHBi?=
 =?utf-8?B?dUM1Yk8rL0NTejk3d2NuQVV6ZkJqb3pxOS9kcmxUMWo4cTFmMFZ5WVRVZ2pF?=
 =?utf-8?B?SUJOWDlvcTVjc1Z5UlNnR1FUaGZhNkNvTEMrdjZCNlZtK0Z4TFhlQVA2TFJ1?=
 =?utf-8?B?Tm1SZlduTnZRV3poYm9JVFE1MUt1bnJUVFdrMk5wUGVmNHY0N0tBTUFUUFpw?=
 =?utf-8?B?L3gyQ3BwYzFpRW4xUjkzNXRDR2xIb1RTVEQwWXFzb1BhbXZETTMzTDM4elRS?=
 =?utf-8?B?ZWtBQ3lNOXRGQVJRNXo0cG5OVGhlaEVjRFlBMUNGNXBUK3FKdG1aRFRCSks0?=
 =?utf-8?B?MVptWDY5dmlkSFpZc1BuTE5MY2JqeGRNVW9UcmhWQ3VQeEhNSDk0WXRnRldj?=
 =?utf-8?B?Qm1NeHZqM3EwTG8xS0VHMXA1QTl4bmowMW80TTd4WDlrdlZtajg4UzBiT0xa?=
 =?utf-8?B?RzNrN3hUdXBkYjhLZ2tHZmFXbjRwdEUvVXVqT29zK0h5RHhhM1RBNlplUFFO?=
 =?utf-8?B?eU1YZWFWQkFveTlXbWY5OXIrOHRmRFVkQlIwVUdNOGE3eXAzekVOSDFFdjh3?=
 =?utf-8?B?LzYzSXRhanNBSEx6MWRwS0Fsc0NyMG91andHQ3RsV3dXTkN4VmtlZmp1WFlo?=
 =?utf-8?B?UVV5T1pGM0FKQmRxWkxLYlhzdGdQVGs3ZDFTRHprTHQ3VFJFamMzY2F2QTR2?=
 =?utf-8?B?bEEvSjJHMVdRK3U3eG9BYlBTZUlwV1dnMnNQNzh0WHE3MWlUdjdMRm50RkhC?=
 =?utf-8?B?VlpYK3BXZU04RGJuLzFkWFZ0M3BqMzZuRU9zR2Z5RXo2aVRLN0p0VWY4WDRL?=
 =?utf-8?B?RzdmMVg4NlJPVnIycjdpd2ppMU52dmRQSC9RSGsxT1BrTXlPNE8wSzdRd3ZB?=
 =?utf-8?B?QjFBcVI0MVRycEE1TDhsamZqUmRudWN1S0UvR3p0VDRWayt2VnhlamJoV1lJ?=
 =?utf-8?B?KzE1NDNpSXpmV2lQMCt5R01udTlEMVBCNCs5b2NCVnNITW5rVUxQdXJVaHJI?=
 =?utf-8?B?c3Jja2MxUVF3ZUxyYWVFVlZSczdoR1RhYTBiM2JtbElCR0QxOUJHZU1uZDJU?=
 =?utf-8?Q?wdgI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6981026-b20b-461e-7e76-08de130c9748
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 14:49:53.3521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65CPkUmjd9zUAZdI5ZZuavPcS9A3bf+PU1FPWuNJR93DEfPzxFQStB5lzfAOCbHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
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


On 2025-10-24 03:24, Khatri, Sunil wrote:
>
> On 24-10-2025 11:44 am, SHANMUGAM, SRINIVASAN wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>>> Sent: Friday, October 24, 2025 10:10 AM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Chen, Xiaogang <Xiaogang.Chen@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip 
>>> <Philip.Yang@amd.com>; Khatri,
>>> Sunil <Sunil.Khatri@amd.com>
>>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
>>> svm_range_validate_and_map()
>>>
>>>
>>> On 24-10-2025 09:20 am, SHANMUGAM, SRINIVASAN wrote:
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>> Sent: Friday, October 24, 2025 3:15 AM
>>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Koenig,
>>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>>> <Philip.Yang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>>>>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range
>>>>> in
>>>>> svm_range_validate_and_map()
>>>>>
>>>>>
>>>>> On 10/23/2025 9:34 AM, Srinivasan Shanmugam wrote:
>>>>>> The function svm_range_validate_and_map() was freeing `range` when
>>>>>> amdgpu_hmm_range_get_pages() failed. But later, the code still used
>>>>>> the same `range` pointer and freed it again. This could cause a
>>>>>> use-after-free and double-free issue.
>>>>>>
>>>>>> The fix sets `range = NULL` right after it is freed and checks for
>>>>>> `range` before using or freeing it again.
>>>>>>
>>>>>> v2: Removed duplicate !r check in the condition for clarity.
>>>>>>
>>>>>> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails,
>>>>>> we
>>>>>> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still
>>>>>> pointing to freed memory. The caller (or
>>>>>> amdgpu_hmm_range_free(range)) may try to free
>>>>>> range->hmm_range.hmm_pfns again, causing a double free, Setting
>>>>>> hmm_range->hmm_pfns = NULL immediately after
>>>>>> kvfree(pfns) prevents both double free. (Philip)
>>>>> what you fix is not "use-after-free", it is preventing double 
>>>>> free, right?
>>>>>> In svm_range_validate_and_map(), When r == 0, it means success →
>>>>>> range is not NULL.  When r != 0, it means failure → already made 
>>>>>> range =
>>> NULL.
>>>>>> So checking both (!r && range) is unnecessary because the moment r
>>>>>> == 0, we automatically know range exists and is safe to use.
>>>>>> (Philip)
>>>>>>
>>>>>> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu
>>>>>> version of hmm") Reported by: Dan Carpenter
>>>>>> <dan.carpenter@linaro.org>
>>>>>> Cc: Philip Yang <Philip.Yang@amd.com>
>>>>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>>>>>>     2 files changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> index d6f903a2d573..90d26d820bac 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct
>>>>>> mmu_interval_notifier *notifier,
>>>>>>
>>>>>>     out_free_pfns:
>>>>>>       kvfree(pfns);
>>>>>> +   hmm_range->hmm_pfns = NULL;
>>> hmm_range->hmm_pfns isnt set till a goto out_free_pfns is called, 
>>> hence not
>>> needed.
>> Why?
>>
>> pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>> hmm_range->hmm_pfns = pfns;
>
> Sorry i missed it being set in beginning as i see it being set in the 
> end . Not sure if we need to set it two times, check that once if its 
> needed again, i guess the second time setting it isnt needed.

hmm_range->hmm_pfns is increased for each MAX_WALK_BYTE loop, and the 
last assignment after loop is needed to set it to the original value to 
pass back to caller.

Regards,

Philip

>
> Regards
> Sunil Khatri
>
>>
>> for example, hmm_range_fault() fails), the code goes to the error path:
>>
>> out_free_pfns:
>>      kvfree(pfns);   // free the buffer
>>
>> But after freeing, the pointer hmm_range->hmm_pfns is still pointing 
>> to the same (now freed) memory.
>> It’s a “dangling pointer” — it points to memory that no longer 
>> belongs to us.
>>
>> Best,
>> Srini
>>
>>>>>>     out_free_range:
>>>>>>       if (r == -EBUSY)
>>>>>>               r = -EAGAIN;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> index f041643308ca..103acb925c2b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct
>>>>> mm_struct *mm,
>>>>>> WRITE_ONCE(p->svms.faulting_task, NULL);
>>>>>>                       if (r) {
>>>>>> amdgpu_hmm_range_free(range);
>>>>>> +                           range = NULL;
>>> Range is a local pointer and if it has been freed it should not be 
>>> used again in same
>>> function. The error condition should handle that.
>>>>>> pr_debug("failed %d to get svm range pages\n", r);
>>>>>>                       }
>>>>>>               } else {
>>>>>> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct
>>>>> mm_struct *mm,
>>>>>> svm_range_lock(prange);
>>>>>>
>>>>>>               /* Free backing memory of hmm_range if it was 
>>>>>> initialized
>>>>>> -            * Overrride return value to TRY AGAIN only if prior 
>>>>>> returns
>>>>>> +            * Override return value to TRY AGAIN only if prior
>>>>>> + returns
>>>>>>                * were successful
>>>>>>                */
>>>>>>               if (range && !amdgpu_hmm_range_valid(range) && !r) 
>>>>>> { @@
>>>>>> -1769,7
>>>>>> +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct
>>>>>> +*mm,
>>>>>>                       r = -EAGAIN;
>>>>>>               }
>>>>>>               /* Free the hmm range */
>>>>>> -           amdgpu_hmm_range_free(range);
>>> I guess we are setting up the error and that should be the criterion 
>>> to call this
>>> function. If there is already an error condition before we should 
>>> not be calling this
>>> again.
>>>
>>> regards
>>> Sunil khatri
>>>
>>>>>> +           if (range)
>>>>> Can just check if(!r) here and remove "range=NULL" above? if r is not
>>>>> 0 range has been freed, if r is 0 free range here.
>>>> But there are later spots where r becomes non-zero after 
>>>> get_pages() succeeded
>>> and range is valid:
>>>> svm_range_dma_map(...) can fail → sets r != 0.
>>>> !amdgpu_hmm_range_valid(range) → you set r = -EAGAIN.
>>>> !list_empty(&prange->child_list) → you set r = -EAGAIN.
>>>> In all three cases, your new tail logic if (!r) 
>>>> amdgpu_hmm_range_free(range);
>>> skips freeing because r != 0 now. Since you also removed range = 
>>> NULL; after the
>>> early free, nothing else frees it → memory leak.
>>>> Regards,
>>>> Srini
>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>> + amdgpu_hmm_range_free(range);
>>>>>>
>>>>>>
>>>>>>               if (!r && !list_empty(&prange->child_list)) {
