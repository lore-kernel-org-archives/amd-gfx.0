Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F78FC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1041C10EC3F;
	Fri, 11 Apr 2025 17:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLl3PTB4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B0910EC3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyBTXaaKWqnUbDmbJSCA0GaP2LS1cEQ4ZjyESwx2LkV+vbAwTVyEvsB+c2LBj7AV7yWSFjbWXHdjzce+ihP6qi6zsMBzas5mEyGxKZU+tSupTy7MZ8WCBuG6bdXuAoh5NBNHbQXh+o+3VmWpURDsPLp+J30gWtssIPRgFOz3h8JPgHcTA5HvI5n7JAVwCV4AQPRPvLHfXMk8vNX2Ceqnfj+dwzilKbR5+5qypsFDnzkDvUnejvicV0brMUacwdidD2y9ioy8U4pbUQvA3+aCY68bwRqcJCduxsDTD9/QQqQdb207DUSe3EnQ2UbzdEYtUF4nHnYBXH8a4E+y5W5XfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mADaWFtU6RRflB7EEKDy/vwcg+Q7HpcvgS/b1GWRCp0=;
 b=MZsAtvGjUN6r1JzrnbekcWwWyKo1NNVEl0QSTY5R14lKGumc6kw5GjIB9zEsNQNTLAD9l+2qbrm5O1r//GghcSsQilgU2VopNdagHRMFitOC2+duWAu92YnJ9cSGUCZzFuOU2q4jKXzhYn3IDhHVWyl0n78e+27zBw9PsScjvX4HzLrZQ3E3i2cDTiVFH3nN9wvBooOCRCMrI+rs3rogWg7z508iZHToxsz6GjqJLQIR2udVTaSmJE4rwp3HpyLWNxtkZC5TB6vB99H1fE0QHX/kDO2qw1Fm8j3UlI2UGrd77YBawEY0QbWJ8r4afsGOhR0pb9ynanoDBV8z+Tacnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mADaWFtU6RRflB7EEKDy/vwcg+Q7HpcvgS/b1GWRCp0=;
 b=HLl3PTB49tllHFxk4W8pspJ4BSkR/2pw5PzOhMB9BaRuPpwfOcVboEgCv18+VoNh0hvRXIahjwccbcZflCE+ArlN3nUiAE3cnxDdB7RBo0d9Zl+sovk8yLmErKubJU4EJ2h2XB+rEHly7vbnUIiQy7s/KBDJcPwiUS/UooKATXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:17:05 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:17:05 +0000
Message-ID: <4853054a-520b-4413-baf7-ac4c61fb8bae@amd.com>
Date: Fri, 11 Apr 2025 22:46:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/amdgpu/userq/mes: pass the secure flag to mqd
 init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-12-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-12-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: a844bed4-c39d-4642-5a07-08dd791ca28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU1EeHRQUkJUQ1oyWTliK1NYK2xRYU9nTjF6TjU1RlR1ZVJLL1NNMUdHNnNI?=
 =?utf-8?B?QkRwVHJaTmlrOC9sbWYzbU13SFZNL2tuQmJhWlFYNVUzcDVYNFN6NmtDNDRq?=
 =?utf-8?B?NUpmUjhqbm5IZVVidEtYdjNKZ05xL1pPNTJBNUlRSEo1STNRdGFNZDFrNTNQ?=
 =?utf-8?B?TnRqVndDOFN4UHphamM3RFpzV2wrdUJPUTBZOGtYTFdKQVMwNlJOTllINDNL?=
 =?utf-8?B?ZGwrb3hNL0dMZGJnb1NDeThrNU94T3JsbGtiUFlWVVM4emVYODhncmdQZG9Z?=
 =?utf-8?B?ZHVieFk3cEJsbVN3QjgyaE9JeTBVZGw2NXlYcE85UDltVHZKOXowUGh1eVRn?=
 =?utf-8?B?MElpaHJqZWh2SUQvblBRL1o2b2cxaEdXQzFTYXZxL0UzbWdmU05CWi9nMTRz?=
 =?utf-8?B?SmVXaDJUNmdHcERTdWpUdCtmTytCdnRBQzRvNDJsVisrRjU4VTI0WWU4ZG5R?=
 =?utf-8?B?TFNCS01UbGhaVWlYMlFpV3N5c3ZHNnNobEg5WjBVa0pKb0V1RTYrbklKMmpN?=
 =?utf-8?B?WkJvYlIzR1RTNnZaaWZlMUovaHN3bjFUbHNTcjk5b1hZL2VpczBObHlwN0Q1?=
 =?utf-8?B?MDJ6NHhXdGFDNldqNTI4Y1ZHeUQxaklDUUorNkR2eEhvOHNyNVFVZmZuc0d6?=
 =?utf-8?B?WGQ0ZndaNUJDd0ZkRmV2cFZPNHhnd1ErMndwTUh6K3RGem9Pdm84VE12bDlE?=
 =?utf-8?B?QnA5WjJYcWx3VG9DM1lsSzJrc3dKOFloYi9qZFRTS21sOTl4VmtxemF5bGNT?=
 =?utf-8?B?UFI0SkhtU2EwbzJlcG1lN29JZ3RHZ25MYXJUdjV5Q0tFTmxUT1BXRlhhR0Iy?=
 =?utf-8?B?NVcxYUF4dzNPVER1VjVJYlpoc2dMOEloNHRJZjNhS0Rpc0k3VU9CSTcyeHB6?=
 =?utf-8?B?bTh5WU5kMFpWaGxtRmN3OENhZWZPTW9aalJMMW44bDNQMHFkWDJkUm5DNGpj?=
 =?utf-8?B?VVFSV1dIT3VnVzVKSWZId2Jnc1V2eGxOZ3ZvVEt4SGlweGxZcFVXMUMxTWJr?=
 =?utf-8?B?THNYU2hiYllyc0lQUktCYXlBeityQVQ5VnRqZGdESUdCcXZ0RmdQNTBYTG1o?=
 =?utf-8?B?MXdGa3hIcStjRnVWaS9oYS85dXpJUlB5REQ2VURSZXF1S2p0OGFrRC9DTmIv?=
 =?utf-8?B?N1IreHhudkt5VzNPZ2UvalRKZ2ZhTHRXek9aOWZmY0Q1TFdXWURaanRQcmUw?=
 =?utf-8?B?ZGYwM3B2MHA3WGdkK2NJbDltWWhqZ1dTUUpyQWtMb0NqQmR1QjVVanc1ZmFY?=
 =?utf-8?B?dUpaaTNJQUc0cFJpTGloQ1lram80VEtZODB0OURqSDBNTVp6R3NBWmZQWjdy?=
 =?utf-8?B?RGc3elhOaEU2aCtOVnlUSE9HeStyOUFSQmo4UmFBR0JZT01qbjJSRkcvSnhI?=
 =?utf-8?B?NFNnZlVUaFplNXhUN3Y0RmRYVWs3WndCWDRtdmRwUFF6U3AxUlBFNXp0SUlG?=
 =?utf-8?B?ZTE3R0t6VEIxM1VwTmhKbzFDOUUwWlczVmV0MHdXN1FWN1dxVDhNbGFBaStm?=
 =?utf-8?B?UXV4ajEvT2R6dVk2TkdUS0xqbWFMVzArRFRsN2tRMnoveHErSUYyS3p0YjIv?=
 =?utf-8?B?ZVA0WERvUVNJd0hrZ3Q3dkduNkNIT3ArTVBTbklEeHpRSmtZMXBpd3U4anl1?=
 =?utf-8?B?THlrTTdScjZBT2FvTHlXSEFoeW1sMXdqbWQ1aklFakJMejZBQndSUlBTK3dW?=
 =?utf-8?B?TTBlMm1Ra2I4LzhYbVNDVy9CaXFSaFVoUWx2M1RpSEtoSFNRT1hFM2I3MkIy?=
 =?utf-8?B?V0l1VU1Eb2IxWmlnRm9PbkFJL3MxaFEvbUVrbzZnSEtVV2RFaFhEVzA5ZTFQ?=
 =?utf-8?B?a1dVWGg5NXZxVWhUR3h6aUZQVXVva3FWdmx0UzJJV05neTB1dU5ZNStYZHMv?=
 =?utf-8?B?SURZOXBHTisyOWJqZUVKa0p3RGVkL3FnSUlpNUw0U1lpK2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXl4TGxNOXJHK0JQZEE1aktrL1phVXQ5VWZ5ejlYbWRvQVlXOHlaSW1DeExB?=
 =?utf-8?B?eWZNa3c5RHVFVGxaYlk2TEVISC9rR1BHSzB0L2E4RDVJVXUyRDVtWW9KTXZl?=
 =?utf-8?B?NUdTZVpYZ2RUeGEyMFRUQWUwWElWci9ZWW5Xcm1hek9iNm0vcHVJRnJXU09v?=
 =?utf-8?B?REhkUlVENnZyMVFMKy9icW1GUk0rcWFaQWZ3cFlPS090OHBta0JRbWZGNGc4?=
 =?utf-8?B?VjlCd1B2Z2xJaVVhc0VJRVhPZFVGRHZ5anA2ajRxMjVZRmpudFR0dFlaZFkx?=
 =?utf-8?B?VFZtU0RvUVE0czBvbzhJYzhFK3dWN2tTS3h3b1lsWWtMS2dFcDhJeHEreVNP?=
 =?utf-8?B?WGZ0YURoOTNIYUdZY2NkU0NLaDJYMDcrQXFlVFZGcnovWXdsQUx0QVdnaFdt?=
 =?utf-8?B?b2JjRG5HSW1IU0J6VDBBVEpwMTRNRjVhY1BWTzVsVjkzejArRDQ4WkZRQ0hC?=
 =?utf-8?B?bWE3R3gvUk9uRXZseGswYUg3N0RtOU1PSUdOWVpuMTVEaDcvOXpZb3NlOWFj?=
 =?utf-8?B?aDViSTJ0K0F1dzlpZ1FUd0E0aXppd0VLb2d3VENQbndTZUtIZGhLeThTUEpQ?=
 =?utf-8?B?K0QrVE0xWldVa0RkNmhOWXBJWm01YWd2aWsrYWlhSHVvb0cwSGhmampCSEFX?=
 =?utf-8?B?VEJnVXkzZ1AxaEprcUFBWXA2TDZOSGhmZTFlcVp2VElVQnZHaDdRcVlObkw2?=
 =?utf-8?B?c2RpeWFXQmpMMFM1eEpBZTM2YW5XVFEyYTNweUFvZnJuelVzME1KNG5CV25V?=
 =?utf-8?B?QkNOOER0amV0dVcrUDJWbG5GWTZQNndVdU5aVThmb1RodVRRMU91YmEzTDY1?=
 =?utf-8?B?aURhczM4UWFPS0NDazcyeWIzR08wcUQ3WlpIVkdNeDl1bGYzcVBQZDluK3B0?=
 =?utf-8?B?MFFrNUVUVlNTNlUxV2lVNExQcUw1K0l4cWprSVJ4K1h3eW9tR0MwSjZKNW4x?=
 =?utf-8?B?ZVNGNnEwZTEveElDdk11bDE1RW44aGxPUE5OWWZZcndFS1hIY2FQRFBXbjVK?=
 =?utf-8?B?QWFTRk5BVWQwSGt3bXVVNmZqTUk3TDJxd0hLZmJwZXNUQTQxMHJxTisyb3Jt?=
 =?utf-8?B?b3ZjaVIrSG9qeVEvM3MxcEJqVE5Ua0xTeityTDk4MU9FbFJqdFBIaW1GU1g4?=
 =?utf-8?B?SEpxcWR2bW55S0JMdHRIMmY4Szh1L0FHNFJvNG50aDRBMVd3M0FaalVqamp1?=
 =?utf-8?B?Q0Z1WE53VmNKY051cjJ5anpqenF2SGRRaSs3aGd6K3lOZ094ekZTNWpTcmpv?=
 =?utf-8?B?Y2RUZDdjaGdmSytjRUc4OXdsYmdtZmpFR3c1TnppdHluSEdYdkVmQ1lobk83?=
 =?utf-8?B?dmtsaFlaSzJQUWs5NHhsMHUyWEVjUE01WGdiN1Z1SUxSZHlja0NucTI1RXk4?=
 =?utf-8?B?cGg2Y0h5MEhBbnJ2Y2xZTk4yVlVENk0zMkF0VDVaSWNWOU1hWGM5cFVTT1BI?=
 =?utf-8?B?Q1dKc1ZJUWl0YytiR3NIS2dJSUdEc2psRTY5MG9ZTUJwMnJ3THQyUFRwNVVj?=
 =?utf-8?B?aHNzMmJVSlVzMzFPcDRuYXkyakNYSXo1eWtCckF1RVNRTU14UHZPK3NDM2hV?=
 =?utf-8?B?cTZiUi9hWWR2SjF6T0pNT1RIN1RZb0IwTUdVT0pQM2pLL0hIUlNNZ0drYll1?=
 =?utf-8?B?UDlOd253Tmc5SmJ6QUU5cks4dWkxWkkxaFJBWGFqZE11SUZtM09waVdkUDVI?=
 =?utf-8?B?RVppRXdvOEg0Q3VBQ0dUd0htbGdnY0pnQUV3Vk4vb1FCaVExTElWOXBXclRq?=
 =?utf-8?B?a1d5ZFZ3T05ETWNpTlozS0F4cmk4UWl1cm40M3N4WEZaVnVLN1NIbW55WHps?=
 =?utf-8?B?RlZtY1pZTHdnZnJ4RXF2eVkxY2dGMjhhR29kdEZBVUhtK1pMQTZSRkxUYmdH?=
 =?utf-8?B?bU9tR2s4anJVa21uNXZuVCtaUDBTNEphNCsrajJybkxERkcxVVFDUEFxdTBR?=
 =?utf-8?B?MFJCN1cxdnJwdFVZeFBZRFJCTDZFcWVaRkRvMXFreEhwRytBWVJ5UHRuNlJ3?=
 =?utf-8?B?aTM0K2dCL25sUlJPQlh0alNwQWh0akV0bTFoOTJTeWJhckxHOHhHREo2eWdM?=
 =?utf-8?B?blk3QWZOc0REUmE3STVJcGM1b1VPL3JSREg3cDdPYk9nUVpSeUMvUkJManZO?=
 =?utf-8?Q?IN4WzFU2g9RHqx7NWH+buXkID?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a844bed4-c39d-4642-5a07-08dd791ca28e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:17:04.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtyEVLdWZzwPWbnU9fEmstC8op7oHM9dK0xuJeLH0LtzRvuF+zlhF+8tmC3mTt9Owaq5k9e7hwmGp9czokzrCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:24 AM, Alex Deucher wrote:
> So that we initialize the MQD as a secure queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index f406a9a29bda5..e175f05bba6a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -267,6 +267,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>   		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>   		userq_props->hqd_active = false;
> +		userq_props->tmz_queue =
> +			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>   		kfree(compute_mqd);
>   	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
>   		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> @@ -286,6 +288,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   
>   		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
>   		userq_props->csa_addr = mqd_gfx_v11->csa_va;
> +		userq_props->tmz_queue =
> +			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>   		kfree(mqd_gfx_v11);
>   	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>   		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
