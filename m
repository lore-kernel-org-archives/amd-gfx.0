Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39B7C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 03:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DF610E1E6;
	Mon, 14 Jul 2025 03:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3lAZJiDo";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BA810E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 03:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ4vi607jPf5MgsQ6+tWF4b03t9ujH89t8SqFU3BKdnVVKzrhFt1cpSRb/w8EV+V1VQkeCz3fWEsnIgMX+l2DyOEThxis9Ev8L/P8hRVElvmO1XCqzF9xLno99AJQdjz7U2kmJOZXGv4gdy4/7J6pMG+wGneGR0boiI8jxTciBXgQigjZm1BFU+Gm5y9IqMOoAprDFDhFGXot7VjgIJyeQ/dZfaCVfgneDcSafoXw0QvmTYHNXwNAcV1ASjcXfrDddUiesBOqGgavYnxABabuOpA5B8jbvVFIwHbFAr2XPY/trbMMeLMExf5NjiILAAIGGSRYKBk6wHCGPFim1NoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOHGTVcQAL2mNo5psi0KgonZdN7sXuJ4L21F/DnE9O4=;
 b=lS+JcPyB9TL8mgZeH3k5/Sow5EiGXlSK/P1LPuumWB1+ynYphWHFLAiQ++W2CzJZCKR3Wfa80AxmyIGzy8aRn8ihV1VLVEZ6IRmy5kowRyvOtFAbo7r/z20ATqjW1b00lOzSenBEQvGeBBZdYO6Tij4eg56VsdqHZdUwmIcpTVlL/tMqGf4XJbCn6nZExv+mzk6KHgte42VZ94a2uk0jTzyDsZE20bmebffS/OpprICizq10Cvk7btE2DSIBat5hae8icj+pdh3GreGxB0Dfx90s8a0qUys+MDgcFjOXvjr7Ddp2kl+j8PsYs2//c6J7GqWGcXwSKakA0bxJGJQ+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOHGTVcQAL2mNo5psi0KgonZdN7sXuJ4L21F/DnE9O4=;
 b=3lAZJiDoYvrHR8GhXpmSNht1BXJ0WsJnNdszLVtYboV4KOURmHW7D65aYqccQmtiPbqY7qX5axJChmtx1fY0uatnUq+mte2xEgKjVgB/GjaYOgMLgBrOzWhWApUi5ZHMG1kTR987PK7NIScIBS/imlAv/MJbENhg4wlCZprIgeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 03:24:26 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 03:24:25 +0000
Message-ID: <ad5565b1-a803-aa49-4c24-779c70014361@amd.com>
Date: Mon, 14 Jul 2025 08:54:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 06/33] drm/amdgpu: clean up jpeg reset functions
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-7-alexander.deucher@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250711224024.410506-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e0e36f-0561-4d97-42d0-08ddc285eee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkJsa3hCelUremt1OXExOGluRkhoUHFqNm1FSTR3Z1hqb1NvRFcyWVo3TGl6?=
 =?utf-8?B?OWM2YXFWQ0JxVGVNUkdiQVdDSEd0K0UvM1k3dGFKU0Z0b1dveEd2MXJUUDE4?=
 =?utf-8?B?dklBbEFHN2tFZENFd1RpYlg4UXpSd0txWTMyTmFsY0lLaUxibFRJRWx3Sklo?=
 =?utf-8?B?enhEeklUa0UxaTBlQnRTSmZmYUtqRUcveDEvelpGZnBTdjZZT1ZRTkRqUUhB?=
 =?utf-8?B?TS9JUGM4SEhNdllpU3oxMGFVSU1CMTRrdUtNSTltdnVmSFBhQVd6bDhLclla?=
 =?utf-8?B?cVF1QjNCbWpiUWNjejFEMTRaeWFzTUlVQ0lzZ3lEYWlrN2lGOUluMkM1d1RY?=
 =?utf-8?B?M2JJOFUyT20wbkNTaVhWdEZ3M3F2UDhHbGRjWlhlNWpuclF4TzBBejV1a0g3?=
 =?utf-8?B?M09JMlNvbldXcWhGNktlL1Byd0UvQWEyOWlSQnp5T3RaMkpkSzlqbFdkNTRO?=
 =?utf-8?B?QXJwdHo2NGJtMmdHaUpEKzk4Tm5TR1g3cGxnNGpyY1Y1K1NmSlZlTG9mQU9Q?=
 =?utf-8?B?Q2R4c3dXWEhPMzVlQ0Rtb3liNUhqOGdiMExWN0l4NlpRMDIzTmsycTJ2SmRT?=
 =?utf-8?B?OGlwUG9ZVUtKMXZ6M3ZzcmhuZ3BtV0VOQWlHNXZjUjBiOXU2SU5VZEgvYjhP?=
 =?utf-8?B?SVFQV3dESWJZcHNQRHhRc05yYVFFc2ZzVWhqMjNNckx0bU9NajBuZHlvVUFH?=
 =?utf-8?B?R1RGQkpXU1ZrYXNRR0VoUVhVdEhhNDJOa0ljQU01bEkzazA4WERxNG9yc2Vr?=
 =?utf-8?B?MzB1YUVSdWpUK2xMbUZQMzdIQkxZOExjV1llalVhUU8vZHpJOUhVdXd2Smxs?=
 =?utf-8?B?eitkMG9zSjF2dFVkTi9ScVNqSXAvSHh4Tnk2QjMzOEZiWTJ3d09EQk5vZFZK?=
 =?utf-8?B?cjR4d0NxSTFEdmF0a056cmE1NnMxNlBmNVlCWkVtWnJOejNZUDMxMkJ6WFJI?=
 =?utf-8?B?U0hXUnV0SHdQVXF5R25TNGhSbCt1SW5iVmVOOVVXb0tFdmcxV2hCbUxVQUNJ?=
 =?utf-8?B?VGVmVkNSbEkyNmhPTWVsdi9iNnFjWk9ZRDZsNmg3R2pVandGeDFCa3hwamd3?=
 =?utf-8?B?RnBWV2t3OTBCVlJNR0xXY0c0SlljWnRRR2NuL1NGRzdTZmFSOGZqMlhWaGFr?=
 =?utf-8?B?Tjk2M3pnWFh1K21rQy9HY2QzcGZTL3Z1SlJzZXRqYzR2dVpycFFqZVE2TU8z?=
 =?utf-8?B?OGVVb0NPMFc1TjIvU1pDWHQxdmlIUGNJemxpMFZ4d3c1SFpkWlU2UTU3cjdW?=
 =?utf-8?B?UzY2dWtzZkxpNS9rYmRIM2cvN3EyT2FyU2o1ZXNIOUhRZVFxSnpsckJ4ZTlD?=
 =?utf-8?B?d3B5OThwUSs2K3FnMUVEMEZnN0Q1ZDZqZUhZSlp2OWhidzQ1S1RyS0ZKcVhX?=
 =?utf-8?B?VndoWHlaTStrQkdHNjNtS1FFRlRnTkJSTFdQUzBEenQySHBmTG9ha1NVcDFL?=
 =?utf-8?B?bFlIdm14MnpobGs2Q2FRUSt1R1NXcHpJR3Q1TzBlZHhrM084SEtQMGpQYklY?=
 =?utf-8?B?eElNOEpZM3FxUXhZdkN5b0lLY3R6TWl5LzBZSlBkSFJzZXhRYUZqZDUyZWUw?=
 =?utf-8?B?WkVqL1o1Q1NUS1dQcXFvNWJaUy9TaDc4Y1JYUlBiemEyS083MzNDcnJBR1lO?=
 =?utf-8?B?Si9VcHpFOWhNSDB0eWI5TDJ6OUNvM1pGQloxNkZnS0NZTVRibVFOTVVmT1lJ?=
 =?utf-8?B?bTJETk0vb0d3WVlKU2ZiZTFOdnVEWkpUN3g2cWVtS0VUTWgyRUV6V3hheFhT?=
 =?utf-8?B?UzVWdXhxQTR2clNSZGljVFpHMkNuV1FFUWZLVXdVMkg2cTJFQ2ZQcVZTczdD?=
 =?utf-8?B?VElxK2pSZHhaL1NHQnJzZk1TWjFyU0wrUzBmYjIwdmFJVmFlSnY3eW5MbDA3?=
 =?utf-8?B?YjQzclJOOEUxbnpZNEF0Y3F6VXNJYnFHN25EQXVJMC9MUjRwaitTWkpwUDlY?=
 =?utf-8?Q?fFRa/z7eojQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VpMHlIMVVaSUtkYkx6UmlRTnhHOE4yVExGbk5sdmVhbFFRMHJRT1d0ajRP?=
 =?utf-8?B?bkdEQW93Wm5Jc2MvN2hEMnhnZU1SaU83VE1wbHoxV3o4T29abERpUHVYamJy?=
 =?utf-8?B?Ukdrd2JqS3F3bE04aTIxd2gweG9LcDVCcThZZWIrQ3gwNWl3RTQvdGM5eDJt?=
 =?utf-8?B?NEhYemdaVG8rMzFuN3pkMmxMeWE1TWF4S1VQNlhsTTJYZFhYMlVoRG04bFhk?=
 =?utf-8?B?UXFhZEJFaVlOUWN2dnRGbjI0UENRN29YZmZMZW9OY1h0bXc4Wnp6bnF2Q05a?=
 =?utf-8?B?a3g3a2x6YndWdDRoK1krZ3pOR0I3M0lhQXd1SWJiSG1HaG96WjBEdENCVE4r?=
 =?utf-8?B?dzVndUFuUm1XV3I0VG5BTm5jNDRVenVaRlA1S0g3RTJvNXgyMjNCVGE0Q214?=
 =?utf-8?B?b0M0QVc1YjhHK1hobzFoSHBkcnRsbno4SUlIUWg3dm1rbUtZbFhKWU9ZTW1C?=
 =?utf-8?B?NDFqZ1lSQXpHVXRlVzNobm1NQmN2VVJGV3Fjd1R5MUJTR2tPS00rUitvZ0Iw?=
 =?utf-8?B?ZWN4eElMcmNINldmd0FIanpOOEFGeG8yNGZ4cE5SbmFHdTZzS3gvditlajJq?=
 =?utf-8?B?SVJvY1BRdyt2TDUzNWpIV0RLbVczNWZxRVF4ZEF4WEhlMmpxcTlvQlNrU2xy?=
 =?utf-8?B?M1gzZTJncmpMMkg1d1dsdjNSeHRtVGRXMWI1bGxnazU5eHV1MklvbWJkejRh?=
 =?utf-8?B?QkNKMzJjRWJyc1ZQT0dZRHp2U3VJZGhYdnd6R0U1VjA1Q1liODZJcWpkMVgy?=
 =?utf-8?B?Qnd1MTJWby95blpFcnV0c21tWFE1T0QycG0rRzRVLzJjcG1FMGovaXZ0bVk1?=
 =?utf-8?B?OCtFTUZiVENTVHMyYzJSYS9zOFBVMkF4SEpwL3grTDk5ZDFybldqdys3eVgy?=
 =?utf-8?B?OTE0RFFPejA1UTFyNkV6MHBrWjYwZEIyTGNmeG5NYVNFYk9EeTdGU3pJajlj?=
 =?utf-8?B?Rk1ETWpnTm9jTUlmTnh6T1NZRFBMOXRkR2hiVjc2c0ZpZzhZZ3lsL1VtQ1FO?=
 =?utf-8?B?cnFjOWhkNUZmOFR5dVM5Y2o1U3pNRS8wY0ljYnVCVFJIL05DZUZlK2FxS3lx?=
 =?utf-8?B?c01jcE1NUHFYTklVTTl0dDljY2l4c3M1dzdONWs0eXFiV0ZZVlJvbGw5UU82?=
 =?utf-8?B?emFsRGVsWTV6dm1BRzN6QkxoUW5GdTVBZW1wYUkvd2QxOXA1S0tsUVRwZGlS?=
 =?utf-8?B?d050Um1LVXpWZGtXejUwdXJLTi9LVWkvZ2xkZ1NGOXgyQklTVDVabjNUenFD?=
 =?utf-8?B?VWwrSlVwNG5sM0M5T2dUQjQ4MGdVWlRmY0FhL2hvRFBnMzdkempZbkYrZGUr?=
 =?utf-8?B?N0dLbUhySUZ1c2lMUURlKzRnQnE4UEJYSVNENEpIUjBUazM0V3VqRlNXY2tE?=
 =?utf-8?B?UURXNFd4eS9kMHVkbDVvZVJGTUJMN2tFbEVkamhEYjNiWGx5c1lEUEl3eXhE?=
 =?utf-8?B?Wm8yRFhsdUF2MGgrakpHbkxhU3l3bkV1d1BZMDBRNm10a0xJa2h1bXUrNEdu?=
 =?utf-8?B?dmltR21IaXpwY21yK1FJTG5aWWtYT3hRUC9ORmEvdS9IWGF2QlZPdFRVejlU?=
 =?utf-8?B?Rm1RQkNyWWlMMFRjOElhd29TWnFGVkVKekZZUk14RVJMM2dnTmQ3ZklHMkZu?=
 =?utf-8?B?ajJEbTJYUWJLZGg2enNKVzdYY3JTREdSeGJhQkNFVWRpaTNHRzI4M1d0Vit4?=
 =?utf-8?B?RkplWlk1clk0a0I5SzhoSjVEM0xPNmlQNkZTYWdBbEJ0aEVwRGlMVVF3a1Bk?=
 =?utf-8?B?TjZtK2VML3lEWTBzK0NBajYrRmd1aGlkc1V3ZVVxSlNVMHBIZFA2c09vNXpu?=
 =?utf-8?B?QnF6S1Z4UkpjZE1NQTZVV3hlMi82V1loT1ZNL3JwYlBxeWFvQXJETlJrTXcw?=
 =?utf-8?B?a3NCNUZwUU9sYnhKNWRXYi93VTlBUmw5Z2VIclR2dldOSnJaV3EzZ0U1UmNn?=
 =?utf-8?B?WkV2Z0NGcG8vVlZpRnl2ZGNvdGE0R043QUZVdGloaXBNaG5lUVZyOWtLbUhZ?=
 =?utf-8?B?SCtYcERTdCtQUVp2clp2VTBDaHVPYUtRMGlVNXdyOW9ZVU9LZjVESHY1TG9J?=
 =?utf-8?B?Unp1MWhkalJjV2V1c2t0Y3BYbzVFaFg5R1Q5YUlwd2V3YkJ0RVo3NTIzcTJK?=
 =?utf-8?Q?GWVo1Y687U57bObiVVIKEeXEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e0e36f-0561-4d97-42d0-08ddc285eee0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 03:24:25.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dpp/sLDhrk+xR5CubpsEFg/2eBt8dOPpUyX7/mZB3UUxDn8LChsQoU/tL4/WpmTFO5RC5nqw4R9zjo7mW70m0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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


This patch is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>


On 7/12/2025 4:09 AM, Alex Deucher wrote:
> Make them consistent and use the reset flags.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 7 ++++---
>   4 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 5ba1c5ad9a5e1..0b56cb67e8f1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -118,7 +118,8 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> @@ -770,6 +771,9 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>   {
>   	int r;
>   
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>   	drm_sched_wqueue_stop(&ring->sched);
>   	r = jpeg_v2_0_stop(ring->adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 5be9cdcae32c1..3d0e61f9f2854 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -167,7 +167,8 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> @@ -649,6 +650,9 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>   {
>   	int r;
>   
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>   	drm_sched_wqueue_stop(&ring->sched);
>   	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>   	jpeg_v2_5_start_inst(ring->adev, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 5428930eafa3e..5d54c882d889c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -132,7 +132,8 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> @@ -561,6 +562,9 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>   {
>   	int r;
>   
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>   	drm_sched_wqueue_stop(&ring->sched);
>   	r = jpeg_v3_0_stop(ring->adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 78fe1924f3cb7..5485e983a089f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -143,7 +143,8 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> @@ -726,8 +727,8 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>   {
>   	int r;
>   
> -	if (amdgpu_sriov_vf(ring->adev))
> -		return -EINVAL;
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
>   	r = jpeg_v4_0_stop(ring->adev);
