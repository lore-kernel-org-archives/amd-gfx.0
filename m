Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9C2C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 355DA112D1E;
	Mon, 29 Apr 2024 15:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8GmBVgl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDF7112D1E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+wS64gWP2HOcLHKEyBtpnQEomdK50Y9WndB6PjPkyxcuQw4aDen2hG5QsulXgjxeJtOHsoPD/i9DKZetR68nDxjMPk+weaT+IGVJm/Mr+QQxqR7hS7OjXLqg9D+zxgMG/j8DAXwzDj2bBwE1V88TRG5ezpFNap6IpvfA/eBa7zydTKtQJESE7kC6e0yw4kQwqDUnQWus5uOxJRFXzYrbLRYlQbvDn3L54O72Vmn5XpcVWoAniF32oi+H4T7i6o8bMCo5W9lrRZyZ2z/CG1jvCFU4nbicdBGlCSiWiBStF9OM8+0fcaqOh2LXx8zeoh1Iu+16nRSx65Hwa8QmXmPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVaVBHPw+wiL+GuckDNUCZlM4hIYwsoUifbF19dS0mA=;
 b=Q98+ME4as9Flcpuggre8DUinfSJSWPVgCpxUTJmDfc7VA+ZIR5z8BDfzjEGPJbWQryFE/kEktSRGU9JsI3GCIArKQuPNtYw31xkrvjsZAB47X6/S7NY9VoPvUWITUKnZq7bDkf9ZJgt7q7kye61r3OJ0LGOBmoR6BIZDxlXtgcaGtvYUGaXv/UQAvtRj96hXcTtD55mI86LHmdQ8hshhEySPkol+OG0t0cMsszvGutMZwbHE57H/9J4vhMqdAlNlfzSe7H+u2/84zMGNnghtSkXPyx59uZ2EsFUyGHfTHiN2gmcX2XwVwLm6qWLkoIssAsk7VEehJfUDBZ3lrtE2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVaVBHPw+wiL+GuckDNUCZlM4hIYwsoUifbF19dS0mA=;
 b=V8GmBVglNRygtmUf8XibfuK9oEezOi/gTDs3GF4inWDuoAFh97gs0F2r0WPNN80xTQ6SlhzmdedG4KfyEFgTnW7U0Zss1dDh9ZntC30WQy4GRiTvYXEAdSnm6pu6tg4E/mhj4qQlvg1eaTtkBtK4f/2oYHWor3iTXOJxdGrZTMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 15:15:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:15:42 +0000
Message-ID: <58d51d39-8bf5-44b9-b95b-920d5d95ebb1@amd.com>
Date: Mon, 29 Apr 2024 10:15:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/pm: fixes a random hang in S4 for SMU
 v13.0.4/11"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tim Huang <Tim.Huang@amd.com>
References: <20240429133814.3427671-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240429133814.3427671-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:806:d0::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6b524b-b22d-4721-eaae-08dc685f3c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVFIRVdPQzBwUU14ZWV3dXgyZ3R0a0pERWtmNDNQeEpzZnlFZXB6NkFaQ2RG?=
 =?utf-8?B?VmVvV1FoODhvV1g2cDE0b0VCalZNY2o2RE4vYjBQREZoMS9ZQXdneExqb2FL?=
 =?utf-8?B?YVNFb2t6VTlMd3Z5aWhJMjN5ekVRRTYxbWVqNjhkWVR2NkdLZVA3aFVWVWJB?=
 =?utf-8?B?RkM3N3NJTE50eVFUaWZyWTdubVZUZXR4LzRjNlptZHYvaWYrRlBaLy9JQk8v?=
 =?utf-8?B?OVoyd2Yva0FZaDdPWE5vWHhPUHZCaGVPREptclhzcldXT1VmY2xzTFdxcldO?=
 =?utf-8?B?cGU1ai91ZHo4djZZL1Ztd1dRZExSQ08vVW5keU5NdjNPYURsTWg5N05DbmZY?=
 =?utf-8?B?Y1lleWhONDFUM3ZBcUdxOENlUHBtamNkeGF2eGx5ZjBWUWdINnZpSmtKZ1R2?=
 =?utf-8?B?emZPZFltVnowZzF1ZW1nQ3VUKzEzV3RrQzd0Um5pVlV1VDY5eTkvdTc1TEY1?=
 =?utf-8?B?NDg2N0R1QWRadVptcVFoL0JwQ05MQzdjM1lFMFpPVWNtK1FZTlpSUVo3MGhO?=
 =?utf-8?B?Ukg5OEFFdW1hREZ1VjAwL1B1QzJFd3F0T1dOZ0Z3dUZUY1ZFUWlUbnFkcFJV?=
 =?utf-8?B?bVNEQmhVejJwVHNXdW9JQWlHM01PTlZPcnpEY2pPdC9jZzZGRk1SdGRIRjc0?=
 =?utf-8?B?WDNyS1FUNzNqZ3RhTUdneXljU1hMSUNKWDB5QnRRVStDZms5MzhmaXE0dWZu?=
 =?utf-8?B?V3pFdkVWWXJST0J5Vy9weGhMdStKdVpvbk5WQXhZQkFnYUVxRmlmc3NrRnZ5?=
 =?utf-8?B?NVJ1VUc5QWRpMzBzZXdVdDJFRGhKY1pDZktlc0hrZ1dtNDA0RjdkYnNQUXRn?=
 =?utf-8?B?MFBVdFIveXJKWThhM01oeXFYL2I2Y2VPV3licENKNFJmTW1wZ2FDVVh0a3lB?=
 =?utf-8?B?Z2NpdUU1UGIwU1FQcDhPZmVpSldTcXoySzcycjJSeTB0Ny9FTjU3YzVhcEUz?=
 =?utf-8?B?ajFxeVVRZlAvUy8yalZ5TE80RFFaK0MzdzNVZDliZGZlUTVFaElXMW14VXZW?=
 =?utf-8?B?V2ZBZEttcHBoN0pQVEhsV3ZtdzZZS3VjM0JubFVqckpQTDBNRDdyRGRqemE0?=
 =?utf-8?B?TmNzalZIaElGb1BXZzV4SFhOR05NRUM4bDBlUWhLdTNZbFBnd0ZESmJPRUZN?=
 =?utf-8?B?RXQvbnoyYisvUkw5TktoSUtNbDcrR2hRYURoQjk3bk9QNm40alFadjNtL2pD?=
 =?utf-8?B?aTJ3WFdEYWtiOCtIK01zK1lRRCt1NnZVNTZVZWRxL2lGMGtVbnlGMmxlT2Zh?=
 =?utf-8?B?ZkNNMkJpdkpvRTUrMFJrZ2EzbkgzdDRRaCtqNU4vWE5ydTQ4Y3VyWlEvUjJm?=
 =?utf-8?B?V1JqQzBzWktVUElMVTNtM2tCb01MWnlNWXFxaU5GK1ZmZkpxUmZITUZiZ0xF?=
 =?utf-8?B?WVpvamtVWFpiTkQ0aXI1Yk0rQ0dBWUYyQWVzNWkvZk1OYm9YS0Y5UmY4T1VU?=
 =?utf-8?B?c0E2djJhajhTNEUralB2a0JBQU1PRnZSU242OEpJcnB0T2tpUU0veXNHb0Zo?=
 =?utf-8?B?TjZGZVdwZ1lBMlRacm01UEFTcVFveEVZdkpuQnFEL0RsQi9SZzF1dElrZk5N?=
 =?utf-8?B?Q255MEJpazdFc2VUaUxvWjFXdXRTK0twWlpwN1dyeXBFZkM1Ymh1OUZtT0lP?=
 =?utf-8?Q?2FSb2DkYipGprgId5dK1cgdXIPXVtqpb1xXozbeipdkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29uTDFFdTFyQjlqc2lRL3R0NVl1bEF4TzhZZ2hvSCs5N3JRNTErSlB5OEJ4?=
 =?utf-8?B?Wk94U1RFVXoxejlNMEtKbndaN282U2FaRFErZW42WUhLQ3FiM3I1TXlkRUhl?=
 =?utf-8?B?L21yd2FqZ3N4dFNSbFNsMDYrZ3Z1RmF3SmI2UW5BRWd0K3NHZERyK2QvcEQ3?=
 =?utf-8?B?ZXp5aWVRNXFkZEttY1dmZkV2OUhDZzN1MHpxMzdadTd6MnJZQ210QkdzZXlH?=
 =?utf-8?B?em15dzRXRU9oSk9XUVpJd0M2eHdFVi9uMXczVzVIYktIM0xEWElZL3VLSit6?=
 =?utf-8?B?QXNDeGxnOWNNREJwMTQwQ3V4bkJJWTdqb2YxOXEzUlE1Vk5yaG5YQU1LUzR5?=
 =?utf-8?B?S0NjQThDSDVTSTl4L1FjYWpzbjhNTEtWQ3FJeWgrbHptUXB1a2FjMVdwK2dY?=
 =?utf-8?B?RlNxQW1ISzRPOW4xcnQwNHVvYWU3MFViSjZSRGtkNm5uUXVBaWFGKzUzNUxC?=
 =?utf-8?B?NzRGdHVMbHZlWExTTlYxRisybjBoN080VGpJb2hsRDIraWdlaGJickhwR3dO?=
 =?utf-8?B?TkhiN3d4SG5XWk9yWVZlMzdQbjZMTU10bHBzZmJaR3gwYmZES3lrVkNrL28w?=
 =?utf-8?B?NWhZb1NWb0t6VG5NbFhTN3NkUDd2WThPU1BuK3pOQmhFbXZvWUd3c0xOd0tz?=
 =?utf-8?B?SHlkakNJNXUzTGZLSFY3a0EwUnRYaXBUVTA4R2szWFgwV01NMURQL0c2NDZ5?=
 =?utf-8?B?dlBOaE0xQnl3cTROZ1Z0aG50a3A5NVQ4ZWg0YVozVGRNVWY3OVloUm1BZ1Ry?=
 =?utf-8?B?VHQrUlZQd0tkMmhUTWlvWGpMMDJEZ2wvWDlUSmxWTllqVDRoRjJoQVJkSmhn?=
 =?utf-8?B?aE52S2hsOUREVFZmbjh1M3Q3Y3NxTTZvQng5bldrQ1BHUUNTbUlNRXltakU3?=
 =?utf-8?B?SkIrS0lEcmhHQTBoWnFOWGRVQUlFa3VOMTd5NEt5SWJuWmZ2WWpESUp4RHpu?=
 =?utf-8?B?ZjJhaTg5Y0lmU2FEY1crVTIxQUZ2ZkkrblZibVVNRklUZEt6TGNOOEx1czJX?=
 =?utf-8?B?ak5wZjMxN3FscGM4RHNzVjYyUEpFMjA2ZUJqZ3V3Z1lNWHUxNk9kRmJTbWVh?=
 =?utf-8?B?ZGc2QnRwN253M1NHelh0T0w2V1NlTFdOdm5GaHFGdGtEUjZNQkN2RjRWSXhq?=
 =?utf-8?B?VDhyQWJYcUNOak5qaHZrMjdNdmFHVndZZ0Z4MHppaXM5VFMyYm9GUG00M0pU?=
 =?utf-8?B?UGR6NldPMkcxMlJONXBMTkc2UHNMRDNYblhRS0tnNlhuQlhHYTVHb2I5V21q?=
 =?utf-8?B?Ym10MkVNK0dIV2dTU3RvM2NUUTNBS0tzLzlycE1ab2hJYUxvZEY1MEZSN0hP?=
 =?utf-8?B?SzR1NnlJdFFlalFLSmRRdnlaOUhrSy9RRGhJeTg4c1ZESkl5RTZtNFN5UkdB?=
 =?utf-8?B?SVZGWjBZcW50WmUzczlJblphZmlWNEFtdHU5Y3c3ZWpFbEhwUDd5QUpFNUZ0?=
 =?utf-8?B?MXhlY0cvMk4wb2ZtSjloU1VNSzJVTExOa2J6bmJjNUJQS0FDU3B4Y2ZwQWcv?=
 =?utf-8?B?aGh3dEMrdU4vSnIxaFhFMTY2clpiRTJvZ2lxeWErWFhxZytmb0VEU3JBYThn?=
 =?utf-8?B?ekNVSWZhUlZmMS8zRkdJcGsrWTEyNWZ5TTlVdVJzN3VSL2htc2VZWkxQVHhU?=
 =?utf-8?B?NWZ1RnVyekZ6UTZIenZNZ2d6TWIrYUhock5xOUFYUzJoTVJUaEhGN3p2UnRz?=
 =?utf-8?B?UzB2M1U3VmhLRURPMVBENTdsZkxDNHFVdkFFY3IzZ3dtZGhJQWx1V3FsRGF4?=
 =?utf-8?B?czZIcWM1Q1pwbGdLbXBaQ2FOdnY2YS82R1F5Rlk1SEdpenJLRkZBNTFGT0ZR?=
 =?utf-8?B?eW43Rk5SdmY0cUEwSGUrVndacEZEdGVzVU1XRW1JNDdkbExkWm1WZi9wTjNO?=
 =?utf-8?B?MlJSaHpjRW5pUkxOK0ZpNmVUUlkwYkt6cURFWFZucTRwdm11dXZoaVZYYWF5?=
 =?utf-8?B?VWd4THRTYzNNbWpyNklkMVBub2Ezb2NGcWpzYXROYVR0QXI4bjhrUGVCQVVY?=
 =?utf-8?B?bzJvTW9YSnVvUUtZclptVi8yR1ZaV3R2ZG8wUnA5WmhNWkJXOGRzSzRSZHF4?=
 =?utf-8?B?RXJZeGs1Q2tRaGdBVnhGTDY3MEN3TkVZcmlJbU1nU01CV1UwYzdnZXY1NnpB?=
 =?utf-8?Q?Gr7CTUfOWpLL+bMlyAqV9sTQ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6b524b-b22d-4721-eaae-08dc685f3c70
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:15:42.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tixXhJmpppYzHRSERhdmJYem5+vUMvaPu+gDFqL05VuYD4IFpmE9S3jJNgQx0zl/DFlpvpK9A4t534yxI6AQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

On 4/29/2024 08:38, Alex Deucher wrote:
> This reverts commit 31729e8c21ecfd671458e02b6511eb68c2225113.
> 
> This causes problems with reboots/shutdowns for some users.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3351
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Tim Huang <Tim.Huang@amd.com>

It would be unfortunate to drop as it did fix S4 for a number of users 
too.  Rather than dropping could the check be made for adev->in_s4?

In any case; whichever solution happens should also CC stable because 
the problematic commit did go to stable eventually.

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 88f1a0d878f33..e8119918ef6b1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -226,18 +226,8 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
>   
> -	if (!en && !adev->in_s0ix) {
> -		/* Adds a GFX reset as workaround just before sending the
> -		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
> -		 * an invalid state.
> -		 */
> -		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
> -						      SMU_RESET_MODE_2, NULL);
> -		if (ret)
> -			return ret;
> -
> +	if (!en && !adev->in_s0ix)
>   		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
> -	}
>   
>   	return ret;
>   }

