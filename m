Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E93CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 07:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5760E10E415;
	Wed,  3 Sep 2025 07:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7bvBSg9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5BA10E415
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 07:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og84+f5aMNI2X1+sDTHk1SGhOJyBvPRG5SmJOQ1LPx03pieKjYn/i1SLHTUEk2ru//0RRgsDepGrTbPokhaIxACVWCSsqZ66+YhsTYJ5nxf/WQ2+f8x3pjZsta9WLgdFQRDj9CJ2zReSjnogo9EnnaGWyA1TA4nZiFsDAwl0LbsUUT6rG24R5yNqknrgDqbSyUzb8C7K9qCixJyy8gCl0yFT1nfquvuUaLyEzruaDFInKA0w0D7u4BCIM2XsOzLf8Wbrvy3r1vMxOyY+HAXcOJztP3bvmM+Hdu4Lskfbde14r25NXxitpBZrAxH9osMkO72fGIE5jzhnEpai8L350w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8O+q0HvthozsFXHyYhU9moilNjbQl1Yv5zXAYkBF5M=;
 b=LHIc8Ikt7UOqQUVKofcBT5eXc/J51yHpQUwJEJuVUpNXrweizd7NFGz+dNOFVd8fI95urmkqgO1qtrzu62snT35KSQ82pZ6iFI7CxjyvqlnAhpJkpXhfA24F47+KJdpnhupHb7JqVNEkXW+IGkSg/mKbus6x8oQGM/U0IziGQXLsfO3upLOy9byTAlkmMxqV5LsYyaElVZh9RbYy0Jvjze1MZ3smjQrUJPYU6H8hpD/p5HhNTeTQO4Rwmks4x4WmKcD+F1wvaA9khKUkLiFfkgeDEAzFvtohwJ1riQAl9NEab/nJX8jHN2fArfwXadMNBGV6O6Ogf6qu7jdDxU8jQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8O+q0HvthozsFXHyYhU9moilNjbQl1Yv5zXAYkBF5M=;
 b=O7bvBSg9mvwHtf4TD6AdRSaW6zGqTm13YMSWn0FsJYYTgzn/oJMra5BDuN/N/1UN479BsrUxoAMYVG5fswHw0dKvETtHdq2BwCM7cnFasKpMRXmIAFm25ddE8t5yPkoNU4X+g6nCLy4n2ZBYFuQUHffGW9LjQMVnAtptRvUNOHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 07:40:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:40:09 +0000
Message-ID: <f8348e72-dfd0-4bf3-88c7-c50aba1c95dd@amd.com>
Date: Wed, 3 Sep 2025 09:40:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
 <20250902145213.486199-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250902145213.486199-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da5e346-94ae-4b3b-5c63-08ddeabd1c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWJsdVJ0dW5RVUtPRjE3NXo5QktHenlVcEdsSlFsbUZYZXExMnVFWTBod0Za?=
 =?utf-8?B?Y1hpL3dxLzZob05Vb3NJTXg4L0JqbEplSWlJd2pWZ3QvWlZHOUZjWXdCd1Fa?=
 =?utf-8?B?UGIwcnlwU1NuRVA0WmJrTVFHMkZxeThqa1oyK3BzbngwelhKczF4MVVxd1cy?=
 =?utf-8?B?TWhSemVCR00yRHpqRUJGQnhLekRXeHRKYkdZZ1hDaHMvVFp1dWo2d0gzNER2?=
 =?utf-8?B?WlFwSDFjOXJ4VjRaSCt3cUtoZkVTMHg0T3F4ZlBSd21Ib09RdkcrRFdZSktO?=
 =?utf-8?B?eVJNZUw3MExhRkxXb3JMUG5DeU1HYngrQkZmeUY3SDlIcGRybWx3bk9vdzhw?=
 =?utf-8?B?NWJ3aGN0ZDhkLzNyc2hoU3E1ajBlSW5PVGNwaW1jcHJvV1VDeVNRYnNzdWNp?=
 =?utf-8?B?bWVUMDRkeHZGOVYySlFHYkZ1OVhGMzBtMmt2RHdORFdXMm9OZ0ZJbGlKdTIr?=
 =?utf-8?B?a0FGWTYyY0ltVWZBOVpQS0grclg4aXNpRDZqNTNQNlZqNDRUZGNwUXczQ2hX?=
 =?utf-8?B?eFJKeU9Gb1Zub3hWZHc1aXlVczJxbHd5WFFMSUVmc0ttR0pkb3Z4ZTVSeVda?=
 =?utf-8?B?amFDRVplY1IyZVl5bGRWZWNjYk9kTUVNRG1hbCs0dDFVY1VscWhFSjlKK0tJ?=
 =?utf-8?B?dFh1N2VQY24zRnBEeEtzTEk1R2x1bUp1L0JDWDVSMTVCanFZU3Z1bko1SUhG?=
 =?utf-8?B?QVVYbCt4RmZTVUtWVXFudXNiRUw2Vi9wMHl3YU5zeGVzT0lyYUJpYW5mR2Fs?=
 =?utf-8?B?eFZBOWp0SFFsK3d4cUFOc3BWL0RROVY0QUdlaUF4M01xQWE2QWJoaE1HTTFU?=
 =?utf-8?B?QmVsNmZSM3pSQk90bEVMMFNWN2o5R296UTd1ZzdSV3I3SDZ0ZVlpdjRnc0Uv?=
 =?utf-8?B?RUh1Z1hoUkFPbUVIKzMxOXJCRlc5YXR5ZXU0TXFwQ0d3MFpoc0JoUEo1QW9m?=
 =?utf-8?B?UU5aaG1hTWhlRzZVTzhWOXQzUzdKZnAreDdtSlBVRndWS1QzenU4WG9zWW1i?=
 =?utf-8?B?UzVlQVBTU3E1VlpLLzBSS2w0VndjdjhXZTVScGpGdFlCL3ZxK0hiN3VTOTdJ?=
 =?utf-8?B?bDdQSGYwc1FnRG40R0ZUZ0pOTDg3Vm9wNk1vN3VOM3VYbmM0d2VveEJqRXVX?=
 =?utf-8?B?c3JYT0E4aXJvZW1WMzB4bXBsUE1SNms5bkxpUG9QSjRJUi93NDJ1enNTYklm?=
 =?utf-8?B?cUdhN1p4QWQycUcxU3BGWlUxRlZOSXp0TG9qSktCYmVFKzdyMG1OK2grQ016?=
 =?utf-8?B?MHRER2ZYbmlJb3lvcDZ4QXFjL3QzTjVHcFl0bXBmVXJoSGVxK3kvU0xvcXcz?=
 =?utf-8?B?d1RZQUZRUUpUZDVLQTY5bXFZWmxVMExJd1Y2L2J4OVgvSXpIa2kyN2NGdjg4?=
 =?utf-8?B?YjlsUjRIOU1PT0xlMHdZdTVPUVdGaHFtVjc3WlhoU29IRE95L3QzeWxFUnJz?=
 =?utf-8?B?c21xOFZsbERQSlFHTzd1KzNya0pEb2ZJWHYxT1JPb2dFOGkwMDhEVkZyeHI2?=
 =?utf-8?B?S1N3cnBSS0FJdzNWYVZYQ2RyTEltTjNlOXRkdjQxWnVrNFVaNm5KLzVqTFBG?=
 =?utf-8?B?dllsb3RjdnZraVptS0F2QlN2WVZIOS9TZlIvaUVXSHhvRXowcjVwSEJrVnNx?=
 =?utf-8?B?Y0tiWld0cmprN2l3KzMxaGg4WkVVR1ZSTmh3ZUFUSE5RMThacExPTlYxTWdp?=
 =?utf-8?B?N1RpNzZuNVFTck1ES2lhWW4xMXJ3bTJXdmpJVktqVDFWbUdveXYzQ2I5N3Fi?=
 =?utf-8?B?c1c0SDBrNk84SnhOeGtkY0l5STV1cDBBSUx0ZFdwTGs4TWh2K0Y3Y2QvWDgw?=
 =?utf-8?B?SFk4cDZNaE9OWWlaRjk4aVdLamNnWnN0cGFJVXlGWXMwZHVueU5UalluODNB?=
 =?utf-8?B?NHBNWkNkV3ZjTVpaY0gxRDlYSzVISEQ5Z1EvUUthM0t3RUdXd1dXb3l5Rm1L?=
 =?utf-8?Q?jrac+DWcrnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V202TmUyaUczSEx4Q1MzMGhkMlJQKzV6bnRjR05qSzZjODJ0a2RabWhBL3Nq?=
 =?utf-8?B?L0orR2taQmJHUkt4Ti83TWo3a1JRMVloZ1ZTMFY4UlJobEliVXczNWJlczRn?=
 =?utf-8?B?c3Q5M0xKemZHR1B0UFB0UmVvM3pudWQyeXVPUXRIRWVNTVRMbjNmSXpIcG14?=
 =?utf-8?B?VjY3K0JxV2dhMUtyN1ZZUjUyUWtEa3JScDFuM3lhMG5jcWhTcmpUOHlyR1A3?=
 =?utf-8?B?ZXJ5NjdwVVlZS2FjaVMyN2FoeXF6dTVDdVVUOFRCN3hWNndGNUdqc0tXSUNK?=
 =?utf-8?B?R3Z6NWNPUE0vTzVqOWhmMzhxZ2FZU083MGFMbUNjeVBQdnVkQ3lXWWdNeGZK?=
 =?utf-8?B?K2FSREVpVFVQaGM0aURqU0F6bnZXQlFIU2Zrc2dDclJkVEh5djBBTFAwOTZk?=
 =?utf-8?B?Zk9UV2UyNEl3Z0tnOGNuS2Y3YVJydHh1VmczQ0xWa0ljTnFQK3cyc2pqRE5M?=
 =?utf-8?B?OFJMNXhWcHFKdFlqQlFLSTJoZmF6ajNPNTFPMGc3M3orT1pndjBRT0tKa0JT?=
 =?utf-8?B?QVgxeXZOMkJlN1kvZGhwdWlZKzU3aTJFRVFDWjdvSDBlc3FuYnlKUXNlYjJL?=
 =?utf-8?B?VEo4SXpZUXkxVlpMY2FnUDdWdXdsenhQa2R4SUpJNjh0aVZyOUYyUEkwbm5N?=
 =?utf-8?B?Sm9za0hGc3dtemF5MGMxaUlSUWxZQWRQWnk4RlUxWUlxbC9rZE9WcmpPd0pi?=
 =?utf-8?B?Zmd4SHJaeGJ1NklTbXZUOHV6UUJIeURXVDFtU0doOWFDa1ppSjBhYU10cFpM?=
 =?utf-8?B?eFIrUFoveEJWcnBqSTZOQWJ4d3JPdi8rVXFpZFhFckY4RjZFKzdZUnczdlRD?=
 =?utf-8?B?ZE4wNWtTQWxoZVNHVmZiaHU3Zjk2WURLc3dvQ3ZEUUVXVXlTbUlZMlEvYUI2?=
 =?utf-8?B?Tm1ObkVQeFNjWEI1a0JTNm9vb2s1d1JQQlR2aDd3ODNPeTZRVXI3SXNDREpw?=
 =?utf-8?B?dktVNXFYdnhGRThVdzZlbzlJNkxaZjkyUGRCNDNxbG9ibEFxRTlEcGlCdG5X?=
 =?utf-8?B?amhSWkxsczNVNjQycXk0dlByZUZTS3A5dCt6SEJHQTBDT2xENm1CN285Ny9M?=
 =?utf-8?B?MzVyd0c4L1huK09TUGdiQ1U2NnFSdWNKTmU0aFJEOU13YnlQSmt2WjdqQmtM?=
 =?utf-8?B?MTNlVUR3QWRITm1WbisvMVk5R2F6WFdUQTNFMllLcENrV01FOVFtaG5LeXdM?=
 =?utf-8?B?bUp3ZmVGeTRuTmdkNmRqRDJGb1cxeVJWZGtxVjBveTRKWDB4Qmt1VVoyRDhZ?=
 =?utf-8?B?OWlXNjFvRFVlTWxuRzNGektVb0R6UWp0RTlZajRoeWx1YjBzU24yYUxSbFgv?=
 =?utf-8?B?WmRQMHRZVlYxbGZ3d09Fa29iWllyRWNNRno4K0pYUlEyQ1dXTGRFY2RPbWZY?=
 =?utf-8?B?SGlaN2s1Q2F2RUtsU0lHRlJTbUwzQ2d5OXc4MDkrTnRkODFCbFl3Sm5NVE9t?=
 =?utf-8?B?cmVxMEZjc0hMZndTVS8yeTJILzdoeGZJb1FScHg2bllCdHowZ1lGd0RZSDl6?=
 =?utf-8?B?REw5MkJzdU9oZkxmVk5ETm16V0tXY1FUQjhnMVdia1JSc01kZjkxRi95VFpR?=
 =?utf-8?B?REZFek0rSjBGZWE3cTAxOUV5RkZlVW03SVVQWW16Tlc3encxN0dVR0s4SHRk?=
 =?utf-8?B?S0l3SlV5WCszOGxSODdZblNsazJoa1RaTHVoSG51NjlPN2dEdXVhNWovSU4y?=
 =?utf-8?B?cTFDVTE3MFpsYmlCM2t0VmUrVGlQeTJQRS8wNlg1d3B1dVREZ1dLVVN0Mjhs?=
 =?utf-8?B?b3lRSWJhekFBVXgvU0k5ZExUQ0pHTEg0NURCSTNSMTN5KytIeHQ1TW9FZU1Q?=
 =?utf-8?B?RzNXdnF1TTJhZWNWUytRV3ZCbTZKTXdLSXRibitZamV0eitTSnB6VlZUazcy?=
 =?utf-8?B?Z3poUi9uTkYwMzVkTjFwMXVqUStaQzI1NEFCZkgyUWRad3VyN3ZKc0N2YW9i?=
 =?utf-8?B?NGgxNnd3a2dyL25MQVRaa1JuVUpYT3poMjhSWXVRUmh0dWZ5cFFKb1FSY1hF?=
 =?utf-8?B?dU1mclBLc1Nsb2VvSVpyQ1prS2lIL2NOVnVvQXl4N1ZuTkpIeU9xVVlZZ0hk?=
 =?utf-8?B?MFdyU2NyY0hBN0dCT09jcXBha2VBeXFJUHJNclJpZmM4WmNWUjNKWk5VUVJH?=
 =?utf-8?Q?Bx5rEFSbHGxL6z61401eQug8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da5e346-94ae-4b3b-5c63-08ddeabd1c04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:40:09.7589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsunHEuXPgyRl21+eXONbYRX/USE3etIDwIZu3u94Junku75ydYlpGld8KPAA/cp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

On 02.09.25 16:52, Srinivasan Shanmugam wrote:
> Add mmio_remap bookkeeping to amdgpu_device and introduce
> amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
> one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.
> 
> Bookkeeping:
>   - adev->rmmio_remap.bo : kernel-owned singleton BO
> 
> The BO is allocated during TTM init when a remap bus address is available
> (adev->rmmio_remap.bus_addr) and PAGE_SIZE <= AMDGPU_GPU_PAGE_SIZE (4K),
> and freed during TTM fini.
> 
> v2:
>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>    rmmio_base. (Alex)
>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>    (no warn). (Alex)
>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>    is stored in adev->mmio_remap.bo and will later be exposed to
>    userspace via a GEM handle. (Christian)
> 
> v3:
>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
>    (Alex)
> 
> v4:
>  - Squash bookkeeping into this patch (Christian)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 59 +++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..24501d3fbefe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
>  struct amdgpu_mmio_remap {
>  	u32 reg_offset;
>  	resource_size_t bus_addr;
> +	struct amdgpu_bo *bo;
>  };
>  
>  /* Define the HW IP blocks will be used in driver , add more if necessary */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 1a68ba17a62d..f38bc9542cd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1854,6 +1854,59 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>  	adev->mman.ttm_pools = NULL;
>  }
>  
> +/**
> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
> + * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
> + * GEM object (amdgpu_bo_create).
> + *
> + * Return:
> + *  * 0 on success or intentional skip (feature not present/unsupported)
> + *  * negative errno on allocation failure
> + */
> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_bo_param bp;
> +	int r;
> +
> +	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
> +	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +		return 0;
> +
> +	memset(&bp, 0, sizeof(bp));
> +
> +	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
> +	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
> +	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> +	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
> +	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +	bp.flags       = 0;
> +	bp.resv        = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> + * amdgpu_ttm_mmio_remap_bo_init().
> + */
> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +	adev->rmmio_remap.bo = NULL;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2028,6 +2081,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> +	r = amdgpu_ttm_mmio_remap_bo_init(adev);
> +	if (r)
> +		return r;
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {
> @@ -2091,6 +2149,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>  					&adev->mman.sdma_access_ptr);
>  
> +	amdgpu_ttm_mmio_remap_bo_fini(adev);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
>  

