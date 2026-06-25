Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18642CDE008
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 10:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CD810F241;
	Thu, 25 Jun 2026 10:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxICyDSr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BC410F241
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 10:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEXzf2Rt1bRaH11ZrPVbE1WXSMszartdSbst9GWtGEzIeKeIVoHEtVUOu6rYj+4SnaDjAp2vgCPXoYIDMjIXENlBDzF1xyfq81E5GldiVxnAfeHy1i9eNM0Pk2QA0zdhA4ss9AIKBgZexM6BxCCSSNHeE+DqMfLSa+JFsg17QQPDDLbv9M+n0UGVMiUzzJLAfwiA8DUcnCoN8GqyA02YUT+sKo0LY4qLFXJY349Rb1NkMmWz11t5H7mcNC1oP7KrupjQCvstjz1iPcw3qHyTI2vY7LDXjz05hVdQwVs+ktfraJ6eALh2lSfMgftjJR2DRGLRxYRh6amGR8NEIfdT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6k5fP4VSs3bs/6FjuL/RKRoOiaYMMPhmrjx/R0EIIw=;
 b=y8GmgxcOHzKwbRF14QVxEAHZQP+cvI06OrK7/jSMmbx7bGth0UFpmFcRwRJygiUjEguoJlNmsUqj+b90Ecckg2sNZ8s9cZK+5/DfgVJ8ooVvBCsoTaCgYJ7HVzR87unBLBO6k9uNHI6Y4N7GJwJtgwSX1pLlojEfMds9pBKrGWYqXB5OYGMtUYUReteGvLZBFc+FSXarkS9THA3M7ryFRLnZ0GnE8E16LGOEb8bitMCSXygiPyxAYxqSRoKU/zd01tLALpE5mexyJarT4SBxnc1RNMYfdr8kvZbNtVF6l9ZmtuZl164/SvQrBgnRZ9pQ4PpG8LJEV227iBuMVwuQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6k5fP4VSs3bs/6FjuL/RKRoOiaYMMPhmrjx/R0EIIw=;
 b=NxICyDSrPYaHvR8OPNQ3/NiFasF2IOPOiQEoQQID4Uc0ZV2dCSkoIZilUrLiX9t1VQNY75lLBUE7jcnCgrIvUJsw5uXVSWM8NWkYkAKGWRfyGMInZc25VlyfNi2qqd4N/9bQOsU4nbdmipuiRLTn0RC1EbRbAGyDLaYGkXfhvhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:40:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:40:11 +0000
Message-ID: <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
Date: Thu, 25 Jun 2026 12:40:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260625031252.298647-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:408:e2::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e0569b-cdda-4d1e-5410-08ded2a621e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: W7YVo/qbGYhRepTvp7RUnumU2vd3j2PhMf6IQvqdWaUPxRRJWvDVRkuUIJfc7yOm+4xBQi+tXQEC9W6oXt3RatRnCY9ESosS2FwKHqpqwG4aRI0USP00Eb2q8NXu8jJVn3JDIRk7wVo9yGAPWDteqPpkLieHGlGqltAvhfa2LYZQgO+JAngSYujVK9yVrGa12Yf0bw4Yuyv1YqMGWR4xEQl9ecpDBhQbN+oIDyqUtMnWyJt8TW5u7B8CA+kTvzbOkI8+nKJXYexl+WDEhnfBpG7QMiCjuTMriOPT1JGXCiHZaZ1Mo2fVuepJ0wCoB+/PXFOhAv0RKmJV8F95cTCldGe/YjSvsRakkdibOc91JNguHV8z3AI+UZn3kmEFy+x9+PreYzTZqd1SqMUfMM2nwfP+Yew6s3EUMLMA/PNQCmn9z58X75Lq5f7cCaOAhrKRNRIy1YQpNZKkstt5rDOmnfk68l2pMm3lI9y8YkOYhYH8Eqq7AkjhFWbh64IhUCl9t+10m8acQMZxcQfuZVOPXRlsEeBKytkdSRj2+GxohkTCOd+q0tBji6EtcNqkpuIqG34mIMD9wiISeKo875T0AXeDR9CK0IV5fNYtmpxsZkYp3TtBstXLU/A7zXphXZnRgse/G4yzgwu0SYZ9SfVIPkczpcUUTYGbMzw5zPJ8XN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2QrVDdobFNzVTlQMWZpbEx6WmZkbWd5dmhCLzNJd3pzb01YVmxXNTFSL1pR?=
 =?utf-8?B?VzFvcDZZeDZvd0NDNFA5K3NZUXkwcGdUREhjSlFEWDlhZk12cFc2ME1ONENy?=
 =?utf-8?B?SGRpUFprUXgvWTVINHFSdk5ocUZsS2YxVkNIV2ZyQ3NjOURWVXVwUVAxT04x?=
 =?utf-8?B?Q2dBai83M2IwTlgzMk43VWs4QWlwa1RXbXJ5MHdPVzFoOUxqVUZLR3owTE5K?=
 =?utf-8?B?YkVFd3cvcHpYb1djWmtCaVY2TFBrQ2NlRE4zUjA3VDNGUDJvYVdOaHg2U1E0?=
 =?utf-8?B?UVVTeVhWZ1lVZ1dUT2hLVDMxcjZwUDQzYURSUDdwR21MWHpWN0NCcjRia21O?=
 =?utf-8?B?V0FwdUtubW5CMkpucUVObEVQVkJzM0tmcmlWQkkzbEYrU3NyVFBxcmxwQXpB?=
 =?utf-8?B?Y09YeWZwZDV3SEhWbnAyVFNGWE00Nmc5Z1BKSzlPZmsyeEpRcWFZcEo4aFRE?=
 =?utf-8?B?UVBNQU1oUzBUbE83MU93TUNQYVpLTDVaVGhkSVpUUVVhTGZ3MGNWUVhLaEdU?=
 =?utf-8?B?OE9TNUdhRlZWQ2NtVDRsVW1MNjRGUzlkTDVGUERRazU1ZDJseTNXSEtPWElr?=
 =?utf-8?B?NHRoWWJMaDZaeGZxaWJZVUhRWkJBdEh3QlVTMHFyNUlvQTZQTlhnekUwRkNX?=
 =?utf-8?B?Tm5NVWFuanFpTFhhZm12YlIzTnBzSDA3OEpMdTdlWDhZV1RmOFBtRU4zU0lJ?=
 =?utf-8?B?UnRXdTJHMkMzczVUVUY4Vy9UUlk0U3JOK1FVRW91RXk4YTFJYm13LzErK2c1?=
 =?utf-8?B?TFFUUDRYdkxMSllLV2VRQmt6WTB0dGlQdWxxNXlXdUNSOVliemhzVnFxVXVZ?=
 =?utf-8?B?Vlc2SjR4ZjNoV1JzaWNXU29OTmJ4MDRNdTFaNWd3NUVlb1c4OXZTNUJEYnF5?=
 =?utf-8?B?RGZwV1hZTnJYMWtIVXNCTHZkcmxFMmpTRlBmL0VCV0w1enYwSWtna3hYeXFP?=
 =?utf-8?B?aUxlSHJiTUtYMHFWM0ZhSk40Sjc1NWp4RGRQZ2QvZHNpendNT25TQmR5LzlE?=
 =?utf-8?B?c3h0YVNrclVJMW8yVzhEbzFWaitVaG9ZWjFMK2h0Sm5XY2RMN0UzL29lRVhN?=
 =?utf-8?B?KzdyVDdqSmxuaVgvSmFFRUt0V3g1NjEweHNncm9WYnVsaW5NZm9ab2ZYdXhU?=
 =?utf-8?B?dm1hRWVmaWkxalhialpuRmJqaE9PTGxhT0d3NU8yOWtYMjBDUzhqMk56ZDBZ?=
 =?utf-8?B?OEZyMlFGMkFibHZtOHJDRTFIVnZQU2xHcmQxa1N5TU8yZlgzajBRbVduRGJR?=
 =?utf-8?B?aWZjeWhkK002YlhEZUtSdWhxalpla1d5RDI3dnU5ZE93T3FzQTZDRWcwVlRW?=
 =?utf-8?B?dVRJZnV0QUhvRElJMzNKbkpLK2RieVN0bHBBelBBcEJZSVl5cVZDNXpHZzhp?=
 =?utf-8?B?K0J5N0dmOEZMV1o3M2FZZDkyM3ZVd3JlOTVnbHVXNlAxUlQ1TTJPZE9DWkwr?=
 =?utf-8?B?eWFvTFpYMENZc0tpd0VhWTYrQnNBcWtqTTZ5T0lDY2l4Nnh4aE5VNE9BTy9u?=
 =?utf-8?B?ZmkyVnRQUGdmNjVZZjdwT2hFbUJ6cjlYSXBWV0ZHODFVUG1nUi92WmdBeE0v?=
 =?utf-8?B?ME93aHltVTlsNGhvbmptVDU3d3l5S0ZaWHppanpUTHJpcm5weGhXWmJBKzlL?=
 =?utf-8?B?UUZsZTBLOWI5NTRvVXQrYXRUVEdPT2Z3ZXV0VTRaRmkzRk0ra3F3Q2VCWFo3?=
 =?utf-8?B?Z2RBSmNYOURiVFBrZ1E1V0h3RUpHTlNDMnhBbWNzSW40bFA1cnMva3NWS0c4?=
 =?utf-8?B?bndWeUUrV1UrdElDNC9JQ2tlSFZnSHErVEJ0NmZLQVlKQzBZQVhCUFVvWnV2?=
 =?utf-8?B?Y2o1UUN4dk16L2ZCQmhFVWx2WHk5ZzZQMG0zc3dhTjFQcG5nTHd3VjZnczQw?=
 =?utf-8?B?MkdpeTF1R2RrcmV1bmEzaFU4T3BKbU1PVytHNHBSTzdEV3VRVzdwOHdMeWsz?=
 =?utf-8?B?N0xBbHlGVi92YnRYTWphclVibEZFN0tLeVlRWUxneDRkeVkrWHRqQmgwTU0w?=
 =?utf-8?B?RmRKc3lQbFdLbE85RTR6TFBBMXFlSHNBK2dOanVDVndpTFQxNHp6L0kySDdX?=
 =?utf-8?B?N243Y0JENFlhdjJNQjVmdEo3OXJ2YS9KL3ZTK2lTelFDWWI0UXBhRzQzRURJ?=
 =?utf-8?B?eDJsdGxDSVBFQWlaNEhvTFFNZVhMMVlGTU5paVVYL2tOM0xzZFc5YktFRnNW?=
 =?utf-8?B?SHFzZ2IralErODlyNmJmTmdxRjhCNitjSHpLU3BpejdMTmp0TkJod3V6U3Qw?=
 =?utf-8?B?cm1aMmE2WEFFRk4zSUxyd1BkTUFMNlIwS1VQQmZMcXJ0eXNrZHlUdHdmdFBp?=
 =?utf-8?Q?PgfA3tt4pWeo+mXW5M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e0569b-cdda-4d1e-5410-08ded2a621e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:40:11.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGEAYyBTy7dSW9ercF16t094WS44TSE4aZzj/eitP5zrOaxWwr7gkZtz6nYgIEku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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



On 6/25/26 05:12, Prike Liang wrote:
> Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to
> add the doorbell offset for suspending userq.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9e27d01cbfa3..ab0de6d04ff8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -783,6 +783,7 @@ static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
>  	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
>  	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
>  	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
> +	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
>  
>  	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>  			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
> @@ -802,6 +803,7 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>  
>  	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
>  	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
> +	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
>  
>  	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>  			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 6644fabeb0b7..b06412ac8583 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -428,6 +428,7 @@ union MESAPI__SUSPEND {
>  		uint32_t		suspend_fence_value;
>  
>  		struct MES_API_STATUS	api_status;
> +		uint32_t		doorbell_offset;
>  	};
>  
>  	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> @@ -445,6 +446,7 @@ union MESAPI__RESUME {
>  		uint64_t		gang_context_addr;
>  
>  		struct MES_API_STATUS	api_status;
> +		uint32_t		doorbell_offset;

Is this backward compatible?

Keep in mind that we can't break the FW interface.

Regards,
Christian.

>  	};
>  
>  	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];

