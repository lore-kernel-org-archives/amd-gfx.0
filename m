Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B2EC25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024A010E92F;
	Thu,  6 Jun 2024 12:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiDy/cBf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E164110E92F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 12:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRjiVIX/5dSMy7jZ15xiC1c3lRS78REOnKbb0IVODbxO14JD+AT/MPU/z1IPlJeE5K06gk2m3bIbPnkUa3NbEXB+U1KznH2cxXct2xQrcZVtsvfVT5miJpRxA94dj9YztwQCkN4Jh6OMeboIx4queSpuYbu+8WBcE60zVjrHIAhIiQc9vVWU0hHeMynM4xILB+ey9YxzagUjkP0BqovwH0HDFuBFoJAgWzxk5iwioo+5ssAQyoXQy9EG0jCnlHlaYukjTPn8LqqQ8b+6LilfJFD8Ote/PccP/kMURml08Ibk4g6/QEBkoWZ7VJEhekRcUx00r3krQEXo54tnG/LzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONKuyS81Vdq7K5r6rOs3Zp4VwJfe+83U7s01j7kKf6E=;
 b=dDC3wloVkQQNER0Fl6mzy7/TDW+EKx433545szl5j6RT5ePoQ8zMWkT4uK9UtfATaBKwiJBtdu4KjT2cwHBEvNNQihboaIRERV3ZdR4ToKjplKWxZLLmamH0w0AcqDF1zAY7KnsEFmI2zBJvff0He7tRfHM3zLkM2tD1QGJvNPmJhpP0GpEfcepYK0ngmdQ/KNY6MUNzA2ozJzhw3D2up/oVwzBmvFA95dccriiHOg8hzexwJTo55BBDcAL8uP/3oI6j8sEsLKQNIdQeyEOXpZU91KZwTydggzK3dMIr4/UkE1zwztHj+g4ZpAG7A/5xCDNnedpG4fLvYr1WUiqPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONKuyS81Vdq7K5r6rOs3Zp4VwJfe+83U7s01j7kKf6E=;
 b=jiDy/cBfNqwxSjm+weLpUzN3oCez3o7Z2VXTwLaEpJdfFccRtwVepxIeblBdkTflz1PqPnCZ6jhqE7kzQ+L6vCT0xQTxCJzG/MVZH06YQ8prJ2Zizu1MsAehVL1sfHnmNFAxBYehM7bEiwuiQVpMCVboEzDIEG1Wnd1yNjGgC3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 12:47:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 12:47:19 +0000
Message-ID: <b17e7cf1-5184-4937-bf5c-44e674d4f307@amd.com>
Date: Thu, 6 Jun 2024 14:47:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: bb72b2d1-b3f0-41ae-5f5b-08dc8626cd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkFvdjcrV2tQRFVERDVYVkxYTzBlWTZUdzN3MHdTN3Q0aEpWQ0xLY3hvVmlF?=
 =?utf-8?B?SmFTcUlIbDdQYXZWUkhpWG5pSVFtczJpaUY0WUI1ZklCZHI5ZUQxK1RVUmlQ?=
 =?utf-8?B?MGRGWTE1Szc5WVRHRXM0RmZ3SjF4MUNrQU11SnJndWdEZ3pqa3lEVUsxOC9E?=
 =?utf-8?B?Wk1jVGhReXlkeVBOZnZoSzlMMWZGSkJFTEo3ZTVpRktBUXZqM1UrRGZDYkd0?=
 =?utf-8?B?UDlzdzVXV2ZLNUhZVGk3aVhVZkhnUklyQ0ZjWjQ0NXVFQkhTeXpCUTZyaXcv?=
 =?utf-8?B?bXNHWDZzZFN4cUVMT05JSjU2bVFwUWNidHA5eEN4U3VCTGF5RVE2elJLejJU?=
 =?utf-8?B?RzVsNVNVUzVvUGpYZkhTejZlNTRwQ0g1UitnK3lSc08wNzNDSzVYU0dCQ1JZ?=
 =?utf-8?B?MGpkTTdtVkg5K0d0TXQ5Z0xpL1c5Vmcva2RaU0VRUk1OOWpHUUl1WEFpbG1Z?=
 =?utf-8?B?Y3lvTXVLYnhpQ1dxSlVVWW1mczRUVk5PeFFTYitIV2dhZmNUQXhyZDdpemJy?=
 =?utf-8?B?QTY3b0xJbmQ1eVBJTG95ZUFkUDhvZks4Q05ycmFXS056ZkVhTXlWT1c0bzJW?=
 =?utf-8?B?aDF4Ymc4d1NNV0taTTZUN1VUTW5BYWhLRTg4L1MxS1NNSG9BQ0NUSWJvN2RG?=
 =?utf-8?B?QVVPOXJ2NER3aW00eHNlU3FnbllHcDhyQUo0SE91bFZiNXd1UWlFZjN5Yms0?=
 =?utf-8?B?dTBVVnlSaU1TL2s5U1kwTVR0cFNjVDdHeE43eW56TFJUMTBITllLbWxPTTR3?=
 =?utf-8?B?ekJOc3M0MTNhTHdxbXhPazVHUEF3VFZtQUFCdURBc3dKWStqNGtCZlJvQ3Av?=
 =?utf-8?B?aW9zMEJ2cXdQYm9DL3dRVW1DU3FGeE0xNlRENjZtb2E4MFFVWDBNMk9CRHpG?=
 =?utf-8?B?UTVDM3BSM2xTRVA1cEtNQXFSV2VpbWNwMERhZXBlQmJDMjVSNXd4RERZVVBF?=
 =?utf-8?B?VU5JR1lSbGVabDlZb0I1S2hDKzI1RDBLdWg2NlVqNmEwOE1nUVdvUzRSMTBG?=
 =?utf-8?B?d3VTUlJUK2JyNHh5dHNRN2oyYmpiVmdJWERxTk1Ga0JGcDM5MUlQQTdXMTZi?=
 =?utf-8?B?QlNkMHRvUXZ2QyswNXBpRkF6ek9yTlB5THZ1VGFZK09nUTJybnBZV0RMMEFR?=
 =?utf-8?B?VUxveUJadzhHL2szNENzd3UyenV0a3luL05UYTVaZUl2WGkzczFHdHkvSXQ5?=
 =?utf-8?B?THJ0NjhpVHd1YlVOYitoTDM4NldpMk1KZWp2VnZESW1NNi9QQWZqTUVMbjRH?=
 =?utf-8?B?KzRYampjQ1ZXNGZDYUJyVnpjbXVJS1djQXFUYmRvSUwzbU51SkRldzhWUlE5?=
 =?utf-8?B?MFRZTFFJbnBtSE82VkVGQStNM0FxV1FIc2ZqNGhLMHBTVkg4ckd6WmdpTERi?=
 =?utf-8?B?a1k4RmlvVmI1bG5SYVFudlRIUXZCeXludDRXalkrbWExZ252YXVuY1EzS0Iw?=
 =?utf-8?B?UDRGY2VucGluZ1NETy9aNzZCczVYSWVuLzc4OHEyb1BvWUVjY2hGQ2hwNkww?=
 =?utf-8?B?ZVMvYU5kbUkyMnhVMTFEbE8xN2ZDelhxdFprZitKZVRzNjVMdWEvMHd2WElr?=
 =?utf-8?B?OVhMcW5QTkpCMHdlWjYvUU9SMTlpZTloNUdJK2M0OFdGa0lrcWowUlVid3Vl?=
 =?utf-8?B?VU5qbXhvdzVDZmZIQU5ZL2dNWFJkS3pjbDRORm9kaGhnY3ZHUEhEUGhGcGs2?=
 =?utf-8?B?N2JwK2xGK0NtWnJ5TTE1RGlDVkRpcDE4MkZLVW1kUTV4MmMweW5nSnJmQTQ1?=
 =?utf-8?Q?IUNklEsvPKfr5Asgq+q3ns7bx8vC5mA1DySUVnA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJ6TURpSFlpZTFaQ0pBUG1oalllVUFSYlJkR0VUZFBaMDZKbGhqdmowWjRG?=
 =?utf-8?B?aE45SWtsOWw3RzI3L09jb3RlTS9rOUUyVGFhRFRoZkNpa0FEU3BnVjBROFpk?=
 =?utf-8?B?Z2g2dWhrRVJwb2VFcnZwcUQwOFZlMUhVd3Q1ZHFDN2tpdEVncmtoaWoxUG1O?=
 =?utf-8?B?SkZVZWxzLy9UN0srbWZrUkwrSkJuMlZnS0VMdUxMN2VlVFJqRVl3RjU3VHpw?=
 =?utf-8?B?UW9lL3lZRFV6cDZJYnpGZGdtczBReGZBSllRZ1E3YXo4SjN1eC9CTUp4VU80?=
 =?utf-8?B?dDFZZVBvSU5SWjNFT0xRMnhremM4M2lUa2VqaVQxNW41bVR4YjQ3Qkh2NjVV?=
 =?utf-8?B?Vjk5SFo1WTlZZWpZS1V6Vm1pVm9WbXRNZjVaSW5rK3FMeHk1UGFLYStpZm1L?=
 =?utf-8?B?U3N0ODYyd3pOMEMreXF0U3FmNlR6L2NueVJudmQyazkwU1l0NTNZRFl6Y3lN?=
 =?utf-8?B?QTZTNlVnN2RxMitBRXV4aHVucU5oSWp5YjRXMjM5VlRHNEZnNTVVbWg2QUVK?=
 =?utf-8?B?emZtelp6NkpNSWJzOGt1Z2M5SjZOQkhGMGsyQXozR3BaY3B1UE9IZHRmSENN?=
 =?utf-8?B?ZW5tejhNeS81NGxJVmZvQ0hXdkZuYzlrajJoTjU4VWdLVVUvVml4bjhTYVZ3?=
 =?utf-8?B?TzROUTNFb3NyeHh0UFVwSHJHNU5YS3d5bVFXQTJzTU9xcTd0ck9BWlZwSC9O?=
 =?utf-8?B?c3RJdXpFZ285anBxdEZPSjZ0V05pTEJyYWFSSkd2MGdIb04yM21LdmlDVU5I?=
 =?utf-8?B?U3BkRTNtK3dJdXV4enZwdkE3SmNxRlhUNkR2ODFrdHZhK1FKN3NOVDA0Y3RM?=
 =?utf-8?B?OHkrQ1hrVXNmQURQdGl3UUVkNjZvUFJnRHJ2RHZkQ3p5WWtqNVV0bW10emV6?=
 =?utf-8?B?YUVnRTZHOTNuRVRYR3orZzlENGtnMWFpLzhmbnZFTWZtcXlZQUdoTUdjNU9U?=
 =?utf-8?B?UHpCRStXMUJybUxZZVJtemg0MUpXQ0VzN2Rmb1RJZHlMa2o4VlFhekJQeEZL?=
 =?utf-8?B?NS9sQzBCUVRHVmtGUWo2ZGhXS3dqTU5CR2YzdzNHVXdOd3V6QzJ2STdJblV4?=
 =?utf-8?B?cE5VSzM3N0dmbmNRZmZWeWFzYWpNSlVpRi95OEY4VmlFczhWM0FNM01DajND?=
 =?utf-8?B?STNpcTVvZHMyTFhyS01VT1ZBdkhxbGdoL2h6WHgwSGcvbVppWVNaejBjeU5O?=
 =?utf-8?B?aGxTelVQQk1IbnNhNXY4TkRFMDdZazQxUHJsTnJWM0tpSWUvUUZwdnkyMVlB?=
 =?utf-8?B?aHh1aFN2WHliMVFnbzlOK2EzTDN4UFhMOXM2bVVRem1LNmsvZTgyVTdCRWNB?=
 =?utf-8?B?K2cvSGVQZXRuOElTY3lhRjFPdlpSNDFwbmIrWmtrTkIxRitEU1JjampwSlo0?=
 =?utf-8?B?b1AzUGJpTyttZDk1cHNEbGtCeTYwbnl4a2t0REhXaVlKZHBoRTRmVFllN3Iy?=
 =?utf-8?B?dklaamlwZFpDM3NSbVNFZzZIMW9wR1VPSms2U3NyTU4rb28yM1UvMHBzVE5B?=
 =?utf-8?B?ZHN6Z1NzK1NKWlpkWno3c0tybXhyc0ZuR1ZCQXhJZ3ZWR1paVnR2Mjl0dFpz?=
 =?utf-8?B?MjhFK0VJZHRqbEhleHJRUmV0UVovcFp1N3hzclFReWVONUVXbjUrT0NiQWll?=
 =?utf-8?B?K1c1UTVaVVZXc1lTbWNGOWJJOWVocnBUamo5MnlEMGhheEpTWEcyUENxdjMw?=
 =?utf-8?B?QjUySG1NZk8rVWd1S0gzaFBqRnFrZHFlNDkyc1FqZHJwSERnTGpCdklMeUIz?=
 =?utf-8?B?d0QrbHBEOUROa2cxeVdySVVBNEV1UU5ObnNXUzY5cmJ5M21TN0ZRTmxwYjV1?=
 =?utf-8?B?NDMwOWNBby9NWEJER2VOZXBvRmZhUzB0WEtqWlFGWW13dXpKOXdnT1VUanJ2?=
 =?utf-8?B?U3hrM0VNcGVhUldjSVlxaFdpeG0vVjZ3Qm5zOXRHdU0rb1gzeEFqL2FEWGd1?=
 =?utf-8?B?NUQ1SkdPTjV2aHJoOGIycENKdWRxTGptUHBmaWIyZEM1b1ZMWkUwYm54eVB1?=
 =?utf-8?B?K05nWnNKOHhBL1I3OVlCelg1b1pwMDkvcTRBVnpGNGc5SkNPMjRTa3pTOEFt?=
 =?utf-8?B?VjB3K1ZSRm5ZY3ZxNnpRTnhOQnBWNXJuUGNnZTBPYXgyRzV0bllIeEVWNEdw?=
 =?utf-8?Q?4azVBQwU04n6rDfPW62Bf+4qc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb72b2d1-b3f0-41ae-5f5b-08dc8626cd89
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:47:19.7789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgdXJqNZExs031FMc+jctT5Yx9VB2OzzfEKvRkMXgPv1ayl49gi55x19YLPzNWWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

Am 06.06.24 um 14:05 schrieb Srinivasan Shanmugam:
> Previously, this check was performed in the gfx_v9_4_3_sw_init function,
> and the amdgpu_gfx_sysfs_compute_init function was only called if the
> GPU was not a VF in SR-IOV mode. This is because the sysfs entries
> created by amdgpu_gfx_sysfs_compute_init are specific to compute
> partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
> mode.
>
> By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
> function responsible for deciding whether or not to create the compute
> partition sysfs entries.
>
> This change improves the code organization and maintainability. If in
> the future the  conditions for creating the compute partition sysfs
> entries change, we  would only need to update the
> amdgpu_gfx_sysfs_compute_init function.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
>   3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 19b1817b55d7..72477a5aedca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>   static DEVICE_ATTR(available_compute_partition, 0444,
>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>   
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
> -	if (r)
> -		return r;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
> +		if (r)
> +			return r;
>   
> -	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
> +		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
> +		if (r)
> +			return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
>   {
> -	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
> -	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
> +		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
> +	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6b0416777c5b..b65c459b3aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
>   						struct amdgpu_iv_entry *entry);
>   
>   bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
>   void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>   		void *ras_error_status,
>   		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index aecc2bcea145..07ce614ef282 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_gfx_sysfs_compute_init(adev);
> +	if (r)
> +		return r;
>   
> -	if (!amdgpu_sriov_vf(adev))
> -		r = amdgpu_gfx_sysfs_init(adev);
> -
> -	return r;
> +	return 0;
>   }
>   
>   static int gfx_v9_4_3_sw_fini(void *handle)
> @@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>   	gfx_v9_4_3_mec_fini(adev);
>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>   	gfx_v9_4_3_free_microcode(adev);
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_gfx_sysfs_fini(adev);
> +	amdgpu_gfx_sysfs_compute_fini(adev);
>   
>   	return 0;
>   }

