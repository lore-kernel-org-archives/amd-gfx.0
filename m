Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D9CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 14:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C7010E255;
	Mon, 27 Jun 2022 14:39:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE9110E255
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 14:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKpEymeasBPD6k7uCB4VppRyIFePHj4O895Q7mz8ofeqqal7lVilE4cogjY2u9sTjIK2c1P7w1uJGKqU6XdSDuzirTFU4077lKf1iPbZ0v0dztqDx0YWQOQqL5xkNUXecmH5v1KlJJYmK83xABa02WjKpRFTcqZDUAJKOhjvg1Xj3Qvf7f4mreu9p/U2J0+V/3NQJ/AEFwAGXrtYNndTNSDCMJBkYHESzuhczy1B3WBWwWkAWW2HPC09WSoY+GZngqkyKhmh4Unq/+/XIhcidI0M8C/exXLspb6E4P+W2qdQYfGvPeJVOIfsh33EaFXYpUO98i8LhAuZL6mHj+ssMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoi1D76tmc2zCFHoYW2BWZrVJvjNNU57rqqsAGJpN9Y=;
 b=AyKvg9VCw9b0pxTn+YAxqExHwZMncTIiwFfUbXSe90Fj2XPAoqNUXxoWnuUp2oiL6CXcj3WtYCoBatqTPijQ4wXRqCp4HnCodn0pSrqj3ylX7AFrCrtXx89XEvUN41lFaQVJHXz3z3CgLrGqSCi8tIvJbGtih5fZR37y+WQxAV9i2K4YmRwWbArchMo7Y86dfJBwr030Jr4DEoA1sdjWOmipsFFHMkKRaM3qbMltEAS8W2SZ/aJ3aZInRGw0i27anrt3T0+pLl8pJRtzAwOi/3EtZLizcdIS/QWgw/XS99poswvkPY4B485jB5poNTKrF7TwRTJgNl8BtvTglTme5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoi1D76tmc2zCFHoYW2BWZrVJvjNNU57rqqsAGJpN9Y=;
 b=r8kLmHGG7h197/JXQmu01Fpaahu3YMbPT8Aym4+OalTEMg+NAMnkFDWOZhy8njDN8Bf5Z612qCDRy0nRhavmmYK2YNfeP7y2QwyUfGvYkcab2FGEWlSQHqVBJ6dE9YvUGfBBf12rw1WQSgm4CNKw9EGlVm7glkjZVJYZhldtPLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BN7PR12MB2785.namprd12.prod.outlook.com (2603:10b6:408:2d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Mon, 27 Jun 2022 14:39:28 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::2d53:42b5:4803:8703]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::2d53:42b5:4803:8703%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 14:39:28 +0000
Message-ID: <278862d2-6387-c0c6-4f0f-608815cb5c76@amd.com>
Date: Mon, 27 Jun 2022 10:39:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: Re-org and cleanup the redundant code
Content-Language: en-US
To: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220626101537.3317253-1-chandan.vurdigerenataraj@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20220626101537.3317253-1-chandan.vurdigerenataraj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f20522-d8f5-418b-1388-08da584ad697
X-MS-TrafficTypeDiagnostic: BN7PR12MB2785:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1f+Rt49PYtqvGK1w6iBzCoJ0zjxNlP4gtlp8pqgkr0/Y9KL9svY6yrz+vgW70OszXEAxDEreRwPL+yvntxSkXzerqvADPBSeXOrFDq90xrCDPuO9lz+CWOgAZZbJNCGg4ZEBVaW8Z2sUsefmdxk7UWCdISH1KXMjeWV6mmqKFFeb/8CsIKjoFvqaqJ6bnBnyJPpQt4cBU+EYCOCJI1Juuwh6cThsU4A+stODRabuTl8ZY2foPFKgXUbDi6xKsu55qsS43+wbKZCMSsnU6adqWAws2X0/JyUbPd+t2wHWIepk5WaGarXMJcy3SCFF7gg2q5tIQbF+9LGZ16N/61nhOx8JZYl6qVRkISj2k35zo9UylW8Igau6/roo8awjgFcqAh+flGmesTzqqQqwM03qhB85suudDbo4BXl4fCBUgn3mHUytMYxPwn8feueIqLrmMpn53QNRq8c8MPAHwLxSmP55EQgjGLQx0TBE+DuJDRN0IXrxR7YAvNh7f3pu4TbEUYJ/omXfkPLcN1FemAwIIQ9ntIl/OfFuYbUMKHuHXfD0N6XN9ggoSTQNJjgMH/DLuhdu7vixSh7yOv0fIjgm/O1CjIVEr345AbcUyO9Q9KLc/c6SGsSVfS+xb07Esofok/e2tTS8ksZCzU7xYv6cVrNb72KrH4vWO9SUap26R8+W9E6V1AwQOpMHmiqgqXe5Elrytl/PX1bNbX2k9hAwhzaJS9yXdyct/7SrQzNWi2ltuSf1ZtsB0zJeFtPggcCUf+EEA0uPIX/WNpLqWDNTrePuDpH3mnyh+4Byti0R/il7qLS2WQGXAgdTkrVk3WbP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(2906002)(19627235002)(6666004)(6636002)(53546011)(31686004)(5660300002)(86362001)(36756003)(38100700002)(316002)(110136005)(41300700001)(83380400001)(66476007)(4326008)(66946007)(66556008)(8676002)(6506007)(6512007)(2616005)(186003)(31696002)(8936002)(6486002)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFBZ1IzbVFsZUFNY1lsNHZMblJWVS95MjlvZG1RNHhOYjBLd3VzTHQ2S1lI?=
 =?utf-8?B?NXNPSHp3N01JQ0pDRHhlSVFNUFI3eHp6R3dzOXBTWmRUVlhjQ1B0VDhPQlAx?=
 =?utf-8?B?d2oxYUw0RlFIWTFGQzUyendUMlVtWU9oVFEzaHhqQ21CQlF4VjhEOGplNFM5?=
 =?utf-8?B?QTdrWkUzYzZhYmtMeXhXZE80YVVKb1l3QWV3NmFtZ2JFaGhOczlmdjF1ZXFw?=
 =?utf-8?B?clRRRmVzSW1xRURwK1hlMmh3Vk14YXlNZndGZmMxVGpQb3dpa0tEOTRnZkxC?=
 =?utf-8?B?a21WbHZkZnJLY3pJcm4wbFl2eXE4WXB5QlJtaFpXQ0dkQkdJV3RFNTlWQ3Jn?=
 =?utf-8?B?RjEzV0tHQ2xTMklsTHJTYUQ1RGFEYnRlRExuTlpjUFZTZHd6NXdxTWJ2OCsr?=
 =?utf-8?B?Mjg4d1czT01hc0pZbUptckFGbytTUWNFTTJGc3M2RndnTUVwVmYvdWFYMHpa?=
 =?utf-8?B?NkpORWszWVhIekZZTDNkQk9Fc29wbWFQUnVyYnV5UnlnTUQrQnM2VG1WQjdC?=
 =?utf-8?B?UlNDK1BOWHhzVTRhUk9kNC9SMG5sTmpvdWJzQVJickhuSjhGb21TSnJldk9S?=
 =?utf-8?B?NkJXRTdOV2d2azFDL2dvYlpoSUpHZzM0dG15cWE1UEJhNmZaZVdpaEpkL1pm?=
 =?utf-8?B?VHEvelhXeDhhbmpoeTB5Y1FOZ0RESjU1d21LMmNSOXFscEJEdDFUWDB0ZEZ4?=
 =?utf-8?B?bEZrOXg5R1Frc2hyWTd0aTlEd3BjYzVrcnJWR1duZzh0SzBLMmVtaUhPUHNu?=
 =?utf-8?B?Vm4xd2ZwL0R6d0NneGtFYWRlN044c2ticUtIdnNlUW5vRGFkaGFGdUQ1eEpB?=
 =?utf-8?B?VTI3QURuOWd0SDFqdGxlNFVOK1Fsa3RiRDI3M1Y1QUVzSDRTdWZJZjhzRHd6?=
 =?utf-8?B?QnBwdGhkNDNjbS9lc1hyOUxhcWQ0UE1iSTZpOGQ5MXRVeHlDTDhBd1ppMWhn?=
 =?utf-8?B?M1RRV1FIQjJnR2lQSGkzS0cyWEhaZDU5L2RBenR2RDU4b016TldFL1hHTVpF?=
 =?utf-8?B?M1FSS2RXOG5KZmMwMzU2NktiTDBIQnBaN1Z6WElLb1VLVXd5amR6bHFXcCt5?=
 =?utf-8?B?Z3dtMEttK0lXWkUyWTNHUXhEV2Z5cGplLzJkQkxZZFlrWTF3eEFETFdITjJF?=
 =?utf-8?B?a0FhTkEyMEs1SW41czRjTGZkQkpSYlhZTDN4RVpNZjRxamh1OFhWVjMvT1BO?=
 =?utf-8?B?QkM4SDRlMWltZ0ZFMmtkSm5CWG5WN1lxT0JEMk1ZRTJUaUxOTWlIVnFxaEd1?=
 =?utf-8?B?bTlkUE0yOXFSVWhRd0ZLVmpabHU2OUJUV3I1QUpzcm5XL1cwcXR3bjRkaTJy?=
 =?utf-8?B?eCtXcm1HL3BmNG1ST05XbUpVNWFYT3pETTNJSjI4STBYN2F2ZG8vN04xWlRG?=
 =?utf-8?B?K0JRMW1kMm83RzF6Nmk2bzhENEkwZDlZZDF2d3Z4V1E1bXlrS1crRUYxeUtw?=
 =?utf-8?B?eGcrRjdVZmowRWs4Z1RNQXZPVU1XWVBRc0JKdnZGN2NtT3JxUlltQzY2bjhp?=
 =?utf-8?B?OXdxemFZcDF2V3lZTU1yWkp3d2c3WjE5OGplQytPWitNTWdrRnUzcW5xNnls?=
 =?utf-8?B?aE5TVmw3cFR3Tm52bkVMandlbE9kUlFKZEcxZHdUZTNrdDhxQkJjNnkyNnBn?=
 =?utf-8?B?Y1Mvc05Uam9WdTdVdEtEeGxRcW1PWVQ2WW5WZTByUzhhTk9Pa1pVbzJVVTZt?=
 =?utf-8?B?UFYwaU1rNjZ4R0pGRmxGZHVMMXJGSjVYOHVaSDd4QldtVjc4ZmMzSW5zb2Iz?=
 =?utf-8?B?YVVvdHQ4eFdGNmg1SkVvMzBHNnkwdHVYd1NkTHNzRDR2Vnh5Sjdlcy94WnBz?=
 =?utf-8?B?YmRLRkEvR1dqM2k5WVdSamcxbWFwMnUyWi93RWZXcnBWZVFxVlFlK2dGUENj?=
 =?utf-8?B?Z0YwREhJSWY5cmNpYytYckVxaFc0MEZmQkpka2hrYWUyRU44SWlHNmU1OVNO?=
 =?utf-8?B?ZElic3FuL0RHdy9JdVRORkFsQ21SWW5iRU9kRTFOTjU3OFVGc29Wb1hSUUZ4?=
 =?utf-8?B?YnQraXIxa3U4cWRhc3pkT1FVbEI5TWNjU3ppMnhkdHZMeGozSzhCdmxJVCtL?=
 =?utf-8?B?TDlKdnRXdHg5WU9DeXMrK2JORHc2UklGWEdjdzhkNWxuMXRoQ1EvSkl1Q1Nj?=
 =?utf-8?Q?CMnE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f20522-d8f5-418b-1388-08da584ad697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:39:27.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk/xPodAe03dnpDkKyd6d/vpHYUQef9qSWzGs0xsFLsygiOBqW8n0hnygRYYjkyY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2785
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-26 06:15, Chandan Vurdigere Nataraj wrote:
> [Why]
> Redundant if-else cases for repeater and non-repeater checks
> 
> [How]
> Without changing the core logic, rearranged the code by removing
> redundant checks
> 
> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 4027f439a5a4..e3254ac05191 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -907,25 +907,17 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
>   	ln_align->raw = dpcd_buf[2];
>   
>   	if (is_repeater(link, offset)) {
> +

With this extra newline dropped,
Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

>   		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
>   				" 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
>   			__func__,
>   			offset,
>   			lane01_status_address, dpcd_buf[0],
>   			lane01_status_address + 1, dpcd_buf[1]);
> -	} else {
> -		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
> -			__func__,
> -			lane01_status_address, dpcd_buf[0],
> -			lane01_status_address + 1, dpcd_buf[1]);
> -	}
> -	lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1;
>   
> -	if (is_repeater(link, offset))
>   		lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1 +
>   				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
>   
> -	if (is_repeater(link, offset)) {
>   		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
>   				" 0x%X Lane01AdjustRequest = %x\n 0x%X Lane23AdjustRequest = %x\n",
>   					__func__,
> @@ -935,6 +927,14 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
>   					lane01_adjust_address + 1,
>   					dpcd_buf[lane_adjust_offset + 1]);
>   	} else {
> +
> +		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
> +			__func__,
> +			lane01_status_address, dpcd_buf[0],
> +			lane01_status_address + 1, dpcd_buf[1]);
> +
> +		lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1;
> +
>   		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01AdjustRequest = %x\n 0x%X Lane23AdjustRequest = %x\n",
>   			__func__,
>   			lane01_adjust_address,
