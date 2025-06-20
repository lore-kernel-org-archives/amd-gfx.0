Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A170DC7115A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 03:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2204C10E0EB;
	Fri, 20 Jun 2025 03:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsIrQS9r";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7899010E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 03:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq9eaAvnONrx9U4v8KdPDygHUAQjFkFIn42CC8+rocOCG2B4KQOtfVzsA3TsztWbaZ7PdfklXxuB8xIDCWY+yuMi9lZVNC8LJ4PsfR8NWujpM2Prwdk5zq+xxZ4eBQaIdec4A8BXggQN/BP6H6j8hM/QAlzjQOrFOWi3YzVjvt9p8gCvNNB4H2a+UonjthSG8v+YcdNwemkjR6A0v7TU81ZTgHL/mnTyLR2fvS9efRGJMvOwNwM3HGC1gmWQCC2l2FMankFmrpch7LyaXJoJh/GXCiDYF+sRzAaK7NHXEEdH2DySma2Rd9gVdq3Iaol1M9++/FxVRa35BUlSY40VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUUDu2EDuEKXnF2mIh5KsV2warUveMSL3wbD4XAv+2E=;
 b=LpNYgTXVsUdKG6U9f4loJm1KqY9HWKUCgQEwfWeXBD+V2qgK8A5QB9mXCZmgOvmOjE66DV5H7UQSMcnc8J5Wm14LXifxpeclJ2zDmnZ/b1IQsetImed4u3TRhTARtGzJktFQhn5jpJUKm5ppgto5c62n39/upca9haB63I4loZmdYRlilZPYJBh+Lxj+B/iy1xSePoetZPQvc94eoK1cVpc8f+yFkQzLoha54FUBvu+v2N1OnlLrc/8GNyGVYOtEDEIWvOVNCc23q83G/sylRBj8cXWU5d0t92BIQXew/OGGlSTxNphIJpC0QzTAStRzNhGsYkakDQ9Sc8QskyyRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUUDu2EDuEKXnF2mIh5KsV2warUveMSL3wbD4XAv+2E=;
 b=fsIrQS9r5SW7cgzDMwo8wz/CJtt7rGS6wCyE0OhFwkbeoWg7URM2WWtCxRImYFE435ie5myXKui6fiiJThsXF/0N5lQ0z09vxjoJAPhEToGLcl6YR5avrawYbD9RYFC4VcMHNfJ3E9gMurMGm693DXuxS7QkZth24+OfXcV3d7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 03:04:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 03:04:08 +0000
Message-ID: <143a1fbc-8f20-4f71-8417-e838b24c1693@amd.com>
Date: Thu, 19 Jun 2025 22:04:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add ISP Generic PM Domain (genpd) support
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, lijo.lazar@amd.com, xiaojian.du@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: ddde144d-10cf-46c5-4b42-08ddafa71f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3IvU0U1TVdOY1ltY3BKajQ3dVdJVGFIcHFDMW9pNnNRTEIwY2FISUF5Um93?=
 =?utf-8?B?M3lIemJJL1FxaDhIU2hQMFB4MjBWK1Y3Z0d0YTZZOERwNzRVL0s5ekNQdERz?=
 =?utf-8?B?MHR0bkFKTStPY3BHVjNaMkNZTVI4M3ROeFdwQng0UkljSGZSV2FZam55bGQ0?=
 =?utf-8?B?UGozblhHWnc1dFJkWmUyUVNzOG93VTM1eW54NG51SjFLUERlRDZ0MDY2dE5l?=
 =?utf-8?B?WnNDTlA2VUYzZ3Mzclh5dEhQZVROZ1FiV1JlTHdJcDVwUlJJcVptOWlPNVlG?=
 =?utf-8?B?aFpWcUl0VlpuTFFiTDhZVFZFQ0o2ZWxXWm9tNHZUQ1VOMDNZRVhoY3cxSnox?=
 =?utf-8?B?T2hJN3FtQ1piZk5xZVBZY2k1K2l2dTg0OWIyVmZjVUlLMXhCck1BeXhaUmV1?=
 =?utf-8?B?THpUUXVxbHJMQnErSExPV3pDdFZmSXFJV3d0aUxKZTUzTHNLUUZ1YVZjNXRa?=
 =?utf-8?B?USt1cTdNd2hYSTNVSjZBeW5KekQxd0dRd1lBOFVQVUg3WmtDVnZ4V25Zendl?=
 =?utf-8?B?R0piN2FCR2pzZVFLZzRDUHByMG55NTk3V29FVWNzU0crOEFtcy8vOEFLMFcz?=
 =?utf-8?B?STFwSXl3bndQcFVKVEFwWHRxN2taWVpxWVFvSlpKQ1VucnB1Y1VzdC9uOGta?=
 =?utf-8?B?NGNhZXlTeEdxWW9ZNyt0aS9hdVlGY0c5cXdaNWtzd1hTWURZeUlkOXdadXJ1?=
 =?utf-8?B?RzVmVmtTbTBaSnc1UXJGdW52Q1Jyblh4KzRIaE9ndXh5NG1Sb0ZMeFNlbDJu?=
 =?utf-8?B?QS9rN3lBTk5vczBRRU1md2FpWnlaMjhsSmdnSzlrYWtSOGVYemsyMW5IblFi?=
 =?utf-8?B?WHR6d2xZWjNpMkpCSXhiOFpNeFZqZEQ3bll1YlpyZkIvTmlGNkxzUk0xNXVy?=
 =?utf-8?B?RDhWQWM2Wi9TU1krb1h1MjAyVWZXNkFsOUxuRjJCcUZONjR6QzFFc0l3MnZj?=
 =?utf-8?B?ZU80dVdnUkRyblNrTzU4Ukl5dUd4azBoN1Z5am5wbHZxU0VTMUh6dFBSaHBB?=
 =?utf-8?B?MmVGZXFNK1Y3R3BQNGlSOTJTZEJHaG1uQ1ovbEJiaG9zelY4UW1yRnBhK0hP?=
 =?utf-8?B?NXVocVYxcXNwTWhkdUNHZGVsVlFhRFhKU2c4TUlnZWd6NXoyQkE0ZWNGRUNk?=
 =?utf-8?B?cXFraDE0OS9XKzRTTWw1SzdYR1Q5dUdYSW9CVFI2YkpaamNNWVpoTUJzQ1Y0?=
 =?utf-8?B?RUxCMG55dHFtdEhPdk00OVVhcDhTZitROExRaWFVRVpzaWRZRm5CZDhxWmNL?=
 =?utf-8?B?WXgxSzhVZ2JjblNFdzRWN2swZitWeTlPSXo2NFd6TmNaYy94Qi81dllNRHNo?=
 =?utf-8?B?SWo4azNUaHYxZExacndHYjlCODlOajV0NDJHaFJTUHNRZFZqT1B3ZWpRRGFD?=
 =?utf-8?B?OWtnQ1pIWlA2YmV3aWovcVAwU0VCUzk0WU1xSDNRSHFNcVFZejdjMEZHcTVO?=
 =?utf-8?B?QTIrUXdzRUsyZGlTRmhNcDhnTXdBVm1yU3FqcEZiVVczMWNnNzNzN1RSN0g2?=
 =?utf-8?B?U2hLcEJXRGx5b1VTNE9KQmp6MStEcFpFNjFTd01qOWlncjBLUUJWbWh2WkE3?=
 =?utf-8?B?RG0vNTZ5aWpLL2tCUzZEOEw0dzRyK3BlbUJERHlnc1JjUUpZQlZaZUUwZ2dU?=
 =?utf-8?B?K1MrazI3NHlGRkRHUjNpQ2NPRkdlamRtZDRUM2wvb0FNZGNpZTJocVJ2UlRG?=
 =?utf-8?B?TVdsQTQwaWtuallxRnlGWkNTaEllaUNlMVNIVzMxdVhzQ1hJM04xMDB3YXBj?=
 =?utf-8?B?SUxnaHArUGhKU3d3R3cycy91dnAwb3k4MzF1bDgxZk9WVWVIQ1pZckxRRXh0?=
 =?utf-8?B?MXQ5MU1YVFMzSzFScThYR09MNm9aOWhDeFlhNUJjdGZIK3RrTXZ4MEp6UFNO?=
 =?utf-8?B?QU80aU9ydVY3LytJeEc1QnhSU0VtT2dSSm1rU3NkZjJpenE2Q0FrWjFFakJk?=
 =?utf-8?Q?Rg9YbYbETU8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhEeWh6ZzJWRFdaTFpZbE1lbUlSalQrREc1RGtUbTFSNjZMakQrZmZhVWNp?=
 =?utf-8?B?bDRmcHhsL242VG9vZXlvZHhKb1oxQTFGcWg5a0J2bXRUamZxY1l5RmhwWkRu?=
 =?utf-8?B?WXlnZ3k1emkrdFluYTRWSGYyQUttR3ZVRmU2WmU3dU9CdU9mdnFvYXdXVjN3?=
 =?utf-8?B?SHRnZ2JsR1RkbEkvTjl4QndHR21kaGNXTzdPSmdPTGtKdENsWGNhVEFhNEtO?=
 =?utf-8?B?ejZNTFNjVmtadDI4SHJldCtncm1oNjU0ZmZHdHc3TDNKU1ZJQStGdTJraUQx?=
 =?utf-8?B?NHNyWWZtcnFLWk1USS90REc0TU9mN0pZdFBkSTlCMStuS0hlUW50azV0VG5m?=
 =?utf-8?B?ZWoyRC9lSUtEd3lSOEk3NFNHaGxwcmtOclYwczM5MnhlOENsaXd1VGcvbEM0?=
 =?utf-8?B?cmt5cE5rUjRmK2FlSUVianJFdTRxUW1KOHRFRUxtT0t5UHBvT1BKc0xxcC9J?=
 =?utf-8?B?UFpZSFpmckJVSjF1dTF0TXBJd1NscWpoOVdPUFZ2eXIydWlNSHpyUlRpK3Jw?=
 =?utf-8?B?VzVwTG1UTXRwTnZiV1RSY2dNOHlzQVB1cmd4U2Fja0ptbitwc3lUM0pJaHRE?=
 =?utf-8?B?WFFRMFRwb1NvUDAyWWFnMjlZcEN0dUxMNCttdGlnOFUrV2lGZ0hjZXhJU0c2?=
 =?utf-8?B?dXhzMkNXd0JQM3Z2cisvTzhBdlY2d0JJMEZMQU0wdVYzS3Y0bk9WaGVJckdC?=
 =?utf-8?B?bkN2TkcveFdQOUJaaVdMcXFGcVlRMHYremJhSlp6dmRpSktFM0t6THVGMjFZ?=
 =?utf-8?B?TFVvWCttQlZWNkZjN2U3eEVmRFBWb2FpeWJGZlB1QWNhcHc1YmE4aFRBYUxq?=
 =?utf-8?B?dkJ6R2VSSXp1UURxdUpnR2MwK1p1alRYcTRjZDhXRVVQLzU2UHBTWUwxbDhn?=
 =?utf-8?B?UTEvVmlPU3pRb1p5SlNlYkxXdm1oWEJSbXdpc3p4ZlY5bzRVRHRLVGFNck0r?=
 =?utf-8?B?QzFZZjRaNXZ5aitRRVliM3dCUGZYNFJ1d3lhT3AycHFnRnYvcTF5c0JneE5u?=
 =?utf-8?B?WnQ5Y1Z2MXI0RndtK0pVbU1sTG9zbE9lNmtkNE9jN2Vva3ZITTJBZEVxNVo3?=
 =?utf-8?B?RjlMQjJyNUJVK1RTTU5ZczdvaDZEM2E5NndQN1p2K0h0QWgrVDdXWW9wN0t5?=
 =?utf-8?B?b2k1eDBJTGhXNEk1U1VNbTZjTHo0RWJWN2Z5dDV4dWhwbi9xWnNGblg4UjFs?=
 =?utf-8?B?NmlUbHRsa2twVUY3WnlUL2swYWFhZEQ4dTBiN3lRaFNlZFU5SHcxTHc0MURC?=
 =?utf-8?B?ZDNMRGZsQTRwYXlkc1h4Umd2Tk51N0Z1TzM5Yk9pbmtEUDJXL1Y0dTBPVklS?=
 =?utf-8?B?ZTN2cnF5a3JjeHBBalQzenFFdFU3Mkpxd1NET05IMXlDLzNqbmk4V0VSMEJH?=
 =?utf-8?B?QnpTK2lBK085QlVRSEpITHJsOCtmejJqUDZjY2VTYVRCQXVGT1pGcUhqMTRq?=
 =?utf-8?B?YzNhK2RsVXp4WGV4SkFaQU5QclZkKzl2SVloQzNrRWc3ODIwdTJDZDNOejlT?=
 =?utf-8?B?enQ4bW9FbUZwNUZEWDBZejlPM0NMbllqdDlVUk1qL0xoMU42ZnM4NW9JUXgw?=
 =?utf-8?B?b3hUbWovUDNaWldhK252eVA1eEEyOHk5eThFYysrUUlPNUp1NnFOL2F5aGw0?=
 =?utf-8?B?YTk3SVAxNTNMcGFmcGxGblNDOWdyMzhBbUxXR1Z4UlJ2dmlvNmZZZS8rWW1x?=
 =?utf-8?B?NDMrTGlWWkpLM2ZPUllnQzkxelFHWms0V1VDbTMrZ084a1NhUmNmcWU0NlVu?=
 =?utf-8?B?YWhZTUZ3VFZhNjlKYmkrT3hNQmU2UDNxSmdkdFFIU01WL2RYZjhZMTZTMVlB?=
 =?utf-8?B?YjA5NXQrSUtsc0tLU1hxek1GNTJyNkhsL1ZsOVNhSXp6WVZHTHZZTHZjS0h3?=
 =?utf-8?B?MUtNb2hjYmFBNnltTWlxbHhlaTBiWmp2VnJxWlRDbWUybC9kUlBVZldHSmow?=
 =?utf-8?B?RXFmdzRFYnhPUDJRZE8rY1Uwam5aczBnY3FTcURVeEFRenArbzIvZ2dNa0NV?=
 =?utf-8?B?ZWlIQk9iWUpGU2VSY05EOG53bHJqSkg2T0YzZm0zT2R4ejFQU2M0VlkvdEdT?=
 =?utf-8?B?VkNDcVk5blJ2M2p3akh5cXdMaHc0UW81Q1N4cHF5cG1ucVRZWHZoazFjY2hl?=
 =?utf-8?Q?zfOPzvMP1v1DyEVFd337EMMKU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddde144d-10cf-46c5-4b42-08ddafa71f76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 03:04:08.0690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHEq6JxO5UiYPxwDY1abYzH2Bgm6a1CvEsufoxOCMAL/zedE4v7tBzhPaj94tTk5gRLpDDsR02pa1t8DevN7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9502
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

On 6/18/2025 5:17 PM, Pratap Nirujogi wrote:
> This patch series adds support to control ISP power and clocks using the
> Generic PM Domain (genpd). Its required to control the ISP HW power from
> external I2C driver to successfully probe the sensor device. Instead of
> using an exported symbols from ISP driver, enabling Generic PM Domain (genpd)
> support in amdgpu_isp device allows its child devices (amd_isp_capture,
> amd_isp_i2c_designware) to set power and clocks directly using PM method.
> 
> We need to add support in amdgpu_smu as well for amdgpu_isp device to set
> power / clocks when invoked from genpd. Though the below SMU messages are
> defined, the actual support to configure ISP is missing in SMU interface.
> 
> PPSMC_MSG_PowerDownIspByTile
> PPSMC_MSG_PowerUpIspByTile
> PPSMC_MSG_SetHardMinIspiclkByFreq
> PPSMC_MSG_SetHardMinIspxclkByFreq
> 
> Added support in SMU to control ISP power / clocks by updating the existing
> amdgpu_dpm_set_powergating_by_smu() and amdgpu_dpm_set_soft_freq_range(); and
> the underlying SOC specific SMU implementation for isp v4.1.
> 
> Pratap Nirujogi (4):
>    drm/amd/pm: Add support to set ISP Power
>    drm/amd/pm: Add support to set min ISP clocks
>    drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support
>    drm/amd/amdgpu: Refine isp_v4_1_1 logging
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |   3 +
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 173 ++++++++++++++++--
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  15 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  41 ++++-
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   9 +-
>   .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |   1 +
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   2 +
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  60 ++++--
>   9 files changed, 264 insertions(+), 42 deletions(-)
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
