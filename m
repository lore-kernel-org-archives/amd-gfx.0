Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB36C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 15:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C743010EA25;
	Fri, 27 Jun 2025 15:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBDOEhcA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A8510EA5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 15:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlzbSo2TuRAYhB0Aq7mK7grGCcUCIOhn3nGB0Nc7oyUdgJbUOhmXwjQS9eOCLEZNKHmKPhIrChiZ38KpUh2H1cPKYN13bkZTnWjkF8C6tubRGTu0R2o2K24awvkqjC1Bf9N5VtoSR8uu7z2XhF8Oai4GRJhEaVA0FeVIce0UXrI6ciYOufuhmob4jlgySYI8UWhM+JnRGxPcB1B955GqwNEctLWCcGni1injKT+881VEW1cQS99mTUf4/GGFnKuJZq9hRW1YIPyCrCCoek+AyIOOXP8ltCGslpdwHa6GGpoU5rJMR1GpcqI/pL6Uxhry3EwTPERrsfe+QF7jJaH3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+RBtKRk/utb7pO7B1ZpdxdVFuLrjfFF+stPo8wn654=;
 b=L3NsZW0mqRAkGemyEleVC15oRu/bcfgOco4q5B6gpykuNnrDY/8SWwgwV3XbL9e91+tFsvuqwsUFMV5i0sn32L22d30LLWZYgS84q5Gk9g3nnNGUyRFoAqUqhD5YRJfq2LQzj1FNNTm6tGh56EpQKbQv0b1okxy8hGw25fXh8/HYvhe/+Eo07HrNFtJmwxDiD7xMHoFXUPQLu7dfWwEp1cmwIpE0h+bluUv8qHyTdMkpZMao4TcY+Wz1x8NhJFJmWksja0TD2C4nTxy8Q1odq3y2ULIPgliQ7vjXv2KMhDBbc7TJy1wifsVl5Rp/fGsOkfQ//iCBhYUnzJfgoi4x6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+RBtKRk/utb7pO7B1ZpdxdVFuLrjfFF+stPo8wn654=;
 b=XBDOEhcA0FRzEnGv/E4xF4xGI80ZI0924LTDAgynllHxVPyN8L1oUkPw7dLXfhUfOht7gibdAv7JapLiRTcBRlOo3LDmnmt4hZl+8Wwt0z5gscXOdd6m4Z9ddE7zamPqaou6fYE3py2fxB2GgeeuoRqU1FxNpz2X6Yf8THzZnQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 15:55:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 15:55:45 +0000
Message-ID: <eeef533c-f0b6-42da-b34b-26eb05aa2bb7@amd.com>
Date: Fri, 27 Jun 2025 10:55:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Initialize swnode for ISP MFD device
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250625220949.116574-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250625220949.116574-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: f6218f50-bc5a-4168-1b41-08ddb59313d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmRCaFkvRHZzcHVuRlZVVStZajNHdjgvQXBwZmJFMTUzZ0Z6Q2Z6VmdmaGRD?=
 =?utf-8?B?NXdBdThlM3BCUHRzcCtEZHVUVTBrZkl4bGVnczFEb2NVNGJIVzVRUUlTZGpZ?=
 =?utf-8?B?Y1Jkbi8reDZ5NFVkYUc0ZjZuZ1lkdzFpSTl2bGEyU2xwUW93TUM4M1gxZVZP?=
 =?utf-8?B?NHpBbTZ1NG80Y1ZkL29FS1AyN0JtRUY2VDFPSEtUclM3WTNoNGdwbDZaaGxG?=
 =?utf-8?B?TEEyV3NRZUdYQXBad2ovYXozR3kyQzBpQjNPRzZjSkc2azB6QUgzQ3E1MEkw?=
 =?utf-8?B?enZaQy9aMExzK29mdWVyOE9YNVdidmlkMHZXdERnTC9QbCtqazFaTnE5VkZW?=
 =?utf-8?B?b2dpcG5KVWhmUWUrS1dSTDFhM2h5QzRHU0pFNXZYcGtYZVhQaWYvMWFUR0Zo?=
 =?utf-8?B?ZXFFeTZ2QnowdWt4REUxT2FUemhyR1h5UmtLME11NElSaHRVUkhsMTVkbWlS?=
 =?utf-8?B?V0lxLzl4RnExTE9xak5xTk1XUnFjbGU1d2I4UWFza0lnajd6NGRzazRyWkl3?=
 =?utf-8?B?RkRCUm9KK1BQWUpmd0JOSkhjZmRHaXdHYm5lMXFsclM4NVhYRWdCNnAvcjAz?=
 =?utf-8?B?MHRHU1hrQi9icGNhVkJ6RnRVV0xrbmI0bk9CdzFsbmV1Qmt1U3Z0eFlhbExV?=
 =?utf-8?B?WGhTZmJyRjB1N25iZ094RE8rdWcwYlJmWDZqZmZXRHhZZlZucXdUbW5LcUVT?=
 =?utf-8?B?WmlTWitQZW05czRIN3N2bTRPYW15Tm90Q0greFg0ZFA0M1pBYlMzWkJFUkVV?=
 =?utf-8?B?cVBsbitrWEhsRVNXMmhPL1hQanJxWC9uNVVPeGdGNjFjT3dpclVnNzczV3NU?=
 =?utf-8?B?dHJmMGNmVC93a0dPYXgxQ2hrenJld3hBYkgvZlRoNFhzM0NzWVZIMFhCQWY3?=
 =?utf-8?B?MmpVRHh2NC80ckZ5Q05RTGY1d1dkZHoxSWYyR2wwS0tlWTBOOHQwNWNJR0ZD?=
 =?utf-8?B?T2xybzJ5Y2JmMHMzbGYxbnpjRDUvNkdZNUhNeGdsVGZ0Z3NhUVRIWEJXS1ZJ?=
 =?utf-8?B?OXF3b0hHMUlaeUFDcHc5QmJFc0Q3NSt3d25HR1dLSFNvdHdVdURJWXo3VTJp?=
 =?utf-8?B?M2xBZHcxRGZYT3ZyWUhnMG1JeWJ5SHFMamNvRFBOeEtXbU5LR2k4Z2lLS0Zm?=
 =?utf-8?B?L3NxcVJCY1ZzOVdMVUFYcWpGTUEvT2s2VjdmVUsvS2wxd01CZUlDVVZIbm1y?=
 =?utf-8?B?QmxZS1JESlFQUTVlYm5KMm55Wm5qQ1NrSVVEczFzOXNTajg2VlpuSUhybGYz?=
 =?utf-8?B?Q24xUFVrbDJKUzRLRzFiNU9NQkduaW01cVFpczZlRjlZc2RGSmUyRTVKbHZV?=
 =?utf-8?B?R3VCWXFoNG5takMxbkoydWJEK3M3blEzaUh5a3NNOWN3VGt4cWZldWZyQk1l?=
 =?utf-8?B?NnNqSEo3ZkxQREg2NkJGdktQS3gwRTBlWURPSUVXcmlTZkNFV2hnZlBDWElK?=
 =?utf-8?B?MnJoL2Q1UHdnc0xLUkI1NmRmZDduVENkVEliR1FoQnlKU1cySUpXMktSYjNh?=
 =?utf-8?B?RnRaenhBK2lUbG9VbVdBUWlubDRjNTBwNXFkNFdMaTRMbmlRTmo5UGNmUmhs?=
 =?utf-8?B?YllLT1RZRkJ0TkxLQWpRRmwzVUFEUVMxSHE0b0dkQnptVUdHQ1N3SG1lMmQv?=
 =?utf-8?B?WXdkMHB5Wkp0a3FmMlUzSzVHcDh1VGErSi9TVkRmWWo3c3ZmNm1BSzk2OE1Y?=
 =?utf-8?B?VGY3bWFJS3hqeEwvMVY5TysrVkRPUFJ4Z3YrNDdyNngrZVR0MU5CeEpXOXMx?=
 =?utf-8?B?KzRqSFQzZXZXMVA1K29GVmFVcDZJM0IwMEM2OWhUQUlFcCtESm9mTy9ocSs0?=
 =?utf-8?B?VUVHbmtMSExBSWh6dENDWS9hRzlLMDV3aHU1NWZwQzY4NEFHUEJOL3ZMZXFB?=
 =?utf-8?B?eFlUNXo0SndiMjhqbllLNXFPZXF2bko0RTVuQzJpbmZ5WW9wL0wrcTFXS2dl?=
 =?utf-8?Q?zZR19M+2QKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRMa0xVZjN4YmFocVk4azc4clNwRUdwdHFWT05uZlZjbjVRdU1VU1FOMENV?=
 =?utf-8?B?Y29KOG9sYkV1aWQ5dXppckdEUHlvZ1l4UUdqclpzOGxHYW1QNW5vM2Mrelcy?=
 =?utf-8?B?NWd0SDhGT1c4UVdRcDVvTXM0eTczZzVBcVlob0x3MmEwNXRIMU1qQ0c4b0pR?=
 =?utf-8?B?Yng0NzNxRVFhLzJXUm0yZjBKaEFkUkxZL2QwcHNDbzV2OUg5QVByNEdGQnhF?=
 =?utf-8?B?azBjempRUm5xY0J6V0pKczZhQWUra1FkMERvTERHc0xiK2JBQXVheExXM0pI?=
 =?utf-8?B?R0grWXVzcWZJRzF6NUdUYkNoWStxS3BSUjRWaW8weXJjVENORVpWYno5b1lW?=
 =?utf-8?B?aXgzQm5YcFM5ZkgyNGF5aHdsMU5XVkpZMEozVmZ2ZjJqOCtEVG9qdC9OMjUw?=
 =?utf-8?B?dElLZkpDVzgrUEFGNXVFNDFhSnY3SkE0dEJCY0ZJRFVSZFh6NkFaT2FIdzZY?=
 =?utf-8?B?Vy9DRFlxdDRYbDJaZW91Lzc3Mmlqa0VjUE8zMXBxcFQrNXRuR0NhN29aY3NO?=
 =?utf-8?B?SWMzVFordncxVWlxdFlaaUNlNGxEUkxQNHpaSVhoMTFodDRtUGZaVytiTytl?=
 =?utf-8?B?RVNaN1FINjhRMzhxK2hDY0NBVHZ3dWZrMFN0STllcjFIWm40dDl1U1hEb1p3?=
 =?utf-8?B?c0xrTUYzMXdSWHZOUnlHLzlMSnlXMFBaL05GbS9qN2VOSWRHMlVtRkVNYTNh?=
 =?utf-8?B?bCs2SVM3WVZ0UmhXM0xoWHFLNHhEV2Q5VWYxemtNODM1VmR5cUM2dng2MFNr?=
 =?utf-8?B?cGxVeHVseFh2bUhGcHk2bXB1MHRvbUhOcmdPYUtlNG1zOFc2QWYxUkJUR3VX?=
 =?utf-8?B?NzZLRjZjM0tqaVJtTVpyblJTeS91L05ad081UE56bElBUTJ0V0crd3lJbmtm?=
 =?utf-8?B?VzFPbTE3Lys5bnRqS0pjNGR0N2JEbUo0L2pEV1RJOHNQa0l0c2lWWmlQZVBY?=
 =?utf-8?B?Y0VUZm1jZVlTWEpkSS9TNVNnQU8xb2RnNmtDZWZNencxVUdZT0xCcTNnd3N4?=
 =?utf-8?B?Z1NlcjBFWmJia3NWWFN1dWNEMVQ0d0JtTCtvZVBzZ1YvSzg0RFd1dk5ZYVhE?=
 =?utf-8?B?dERwcCtjZFduUUFPOHN4Kzh3Q01rY3hDOUN4YTNSU2h6VkxFSnh5KzlYOWM5?=
 =?utf-8?B?Z0s1aklvVlVlQjM3S2hPcjBvTXRnQlU3RE9idXVFcUpyS2tUUVBpY3FtV3VC?=
 =?utf-8?B?RVBqWE9OK1YyaExmODRxY3JpOFVnbFRnNGZzMlh6QWF4ZzFqV1ZDRnEyVHpi?=
 =?utf-8?B?NnlPTEdpSGU0cW8wZHJGSmxMY0FVMlNQZnE5WUNVWWQ5WkFoeFVpN0hLNGdM?=
 =?utf-8?B?WmFyUjY3T0xGWFZLc2xmZUFUNTc3Ujd6N2NKNVN4dVZnbFE4UFAwa2UzV2x2?=
 =?utf-8?B?bEpDbHIwbk42MW0rWHcyd3BDSkJlUjExN1NVWDF4V2krRkpKYlJjNkhJK1VN?=
 =?utf-8?B?R1R4aXZPOUtuN0JwU3ptQktrZXhmeFUrbUYycTM1ZHg5aFNhTWI1bDBaSEJT?=
 =?utf-8?B?d3l1UmRSeGtFdUo0MGU1bkpuemlIZ3JMOGdFNnlsOGdnTzJEZHl3dFJiQ01l?=
 =?utf-8?B?TlBXMUJua3pWSFNWKzhxQ1pHZVV5cURqU3FFMDIwMDB1L1g3UStvelJ6MWwv?=
 =?utf-8?B?N2owUWZ5d3dCZzNJSVcyZmxTOTdzTVhrakZ3MDNWZ3NXMWdsVnZuVDZwNEhp?=
 =?utf-8?B?MjhoMmpxQ1cwMEYyWnVWaVYrbjRPd1VuUlIvSUl6RVMzQ0k4U0dHM05iWHlk?=
 =?utf-8?B?M0xmOFdtMnVmSHhTT0toSHVUcW5EbXdHVFR0YWlxUTArYnJRVUwvY2hHOHps?=
 =?utf-8?B?b1VSU3BOT3NyWjFNeXJEdHRYTXpsQ0cySk45Nmw2aEU3QWJJakNwcXZLcEw0?=
 =?utf-8?B?d3hzWFlFVkZxOFRZNUVOWDZJQmtnK2NJQytXS1RIOEZTSlBmTzF1QW1aVXRD?=
 =?utf-8?B?RE83d1ozL2U5SjUxcGNOZ000b0pFQ29VQW8zVVVWbk4rS3k4VlAwbmxBUzc2?=
 =?utf-8?B?VXFkQ3EyYythUUFQcHFaTWh5Y3AzUVdWeWYxMkVXbUNDSCtCenU5UGllZms2?=
 =?utf-8?B?c2lJMTZWWVVCMTNXQ3YzTnllcmkyNHFlUHNVOEJOclgwblAzbmFLRVRxTThZ?=
 =?utf-8?Q?ptu/NE0rRECRPW7RVZrDU7Lqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6218f50-bc5a-4168-1b41-08ddb59313d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 15:55:45.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEDacF/3WfXx+2s7bQEdieg6XuSyG5sXAAqKRDp+bvoZ+W/5F1D1y7vpPc6LboLxxFizoUXXhD38F0Zz4gPVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

On 6/25/2025 5:09 PM, Pratap Nirujogi wrote:
> Create amd_isp_capture MFD device with swnode initialized to
> isp specific software_node part of fwnode graph in amd_isp4
> x86/platform driver. The isp driver use this swnode handle
> to retrieve the critical properties (data-lanes, mipi phyid,
> link-frequencies etc.) required for camera to work on AMD ISP4
> based targets.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 11 ++++++++---
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3f0b1fa590c6..7427986992d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1718,7 +1718,7 @@ static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return
>   #endif
>   
>   #if defined(CONFIG_DRM_AMD_ISP)
> -int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
> +int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
>   #endif
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index f5466c592d94..ae2d08cf027e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1545,7 +1545,7 @@ static int isp_match_acpi_device_ids(struct device *dev, const void *data)
>   	return acpi_match_device(data, dev) ? 1 : 0;
>   }
>   
> -int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
> +int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev)
>   {
>   	struct device *pdev __free(put_device) = NULL;
>   	struct acpi_device *acpi_pdev;
> @@ -1559,7 +1559,7 @@ int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>   	if (!acpi_pdev)
>   		return -ENODEV;
>   
> -	strscpy(*hid, acpi_device_hid(acpi_pdev));
> +	*dev = acpi_pdev;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index f857796f0297..a887df520414 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -183,15 +183,16 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
> +	const struct software_node *amd_camera_node, *isp4_node;
>   	struct amdgpu_device *adev = isp->adev;
> +	struct acpi_device *acpi_dev;
>   	int idx, int_idx, num_res, r;
> -	u8 isp_dev_hid[ACPI_ID_LEN];
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> -	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
> +	r = amdgpu_acpi_get_isp4_dev(&acpi_dev);
>   	if (r) {
>   		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>   		/* allow GPU init to progress */
> @@ -199,7 +200,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   	}
>   
>   	/* add GPIO resources required for OMNI5C10 sensor */
> -	if (!strcmp("OMNI5C10", isp_dev_hid)) {
> +	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_dev))) {
>   		gpiod_add_lookup_table(&isp_gpio_table);
>   		gpiod_add_lookup_table(&isp_sensor_gpio_table);
>   	}
> @@ -241,6 +242,9 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   		goto failure;
>   	}
>   
> +	amd_camera_node = (const struct software_node *)acpi_dev->driver_data;
> +	isp4_node = software_node_find_by_name(amd_camera_node, "isp4");
> +
>   	/* initialize isp platform data */
>   	isp->isp_pdata->adev = (void *)adev;
>   	isp->isp_pdata->asic_type = adev->asic_type;
> @@ -269,6 +273,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   	isp->isp_cell[0].num_resources = num_res;
>   	isp->isp_cell[0].resources = &isp->isp_res[0];
>   	isp->isp_cell[0].platform_data = isp->isp_pdata;
> +	isp->isp_cell[0].swnode = isp4_node;
>   	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
>   
>   	/* initialize isp i2c platform data */

