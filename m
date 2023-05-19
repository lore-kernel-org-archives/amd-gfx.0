Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AF1C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 05:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A007A10E06C;
	Fri, 19 May 2023 05:59:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7AA10E06C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlqW0dCVCo5SbEazeqPDGvYMQG+PQX5UYJPzV18xZEXDd8P0OrKcSXyjL+n20uaYtEGrVU1f3J0T2sokKv56UHPdjVdDngo7V8SduBu/eL9gFCMDXq0y+hxGxw4pWDKpdlFGZoKMphOBbTo5zslqYNcWa8ncVcQZtOchHiAjhdqT4HKmcH97fOBzqziTUIvW5gGqRqJ9qaiFhK9f3fzA1fcrgfNeACjZDyPjkqzA6/4Ln9yZEPNq1L1wtur/UPCNsho7SUE+RufqG6fxh5qP2LXqeRUtLb3QmoIS1A4f5MbEBN9XETKajPUZEvssO73clGOHLJpBem10AyDF/9hB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdJPxpanFfot4d6hhhaJo2KKFc6+n6Bw8518ONt4uWY=;
 b=Kfn3VkA1AzNv1/gFock1NwDHnclvVupriTacrsVDeRpMC6wd51Z/IwGvQiiCZLuDjery0I+GkMdF6j6Ozk+YSCuIXCvKoqISFMJC+tCSuRM6bcoEsn9SYiHaBENQ6Xvu/lGigac95oma8t99Sy7XUUfiS6TAktuScaXj0CNipCgIE5zSxdNdmCciAwUZuKhr3qnmbNcYedWQnMbxwVV+UcRx9vp+iNMLBvruMDCN+z+Y82au25pUC3u1TryhRZ6BcBgXj5VSd7b97W+Zumntoc8FRVm0jdJXGBmd4amzT+rvtvZc08P62xjmthll5qFEkyLFc9A8vksTwzHs3WVTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdJPxpanFfot4d6hhhaJo2KKFc6+n6Bw8518ONt4uWY=;
 b=elclRGHklKHtoYqfDTWooi7ehTjA9eUQkLS1yjabW2b/7LdLKPLEAbGN5Gj5LBOMN5aT57FmgkOFN0oxH7yzfBXSW4mVbKqshU+lG/0DiSmdfyc8GzqmX5NQ9kzPsuod+svqZHSTO4KBLelu0O6vLMfh/1tGcjQKEqTsh8PUXU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 05:59:24 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 05:59:24 +0000
Message-ID: <40d024d2-f71f-9458-4d22-7391626aec43@amd.com>
Date: Fri, 19 May 2023 11:29:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized variable in
 gfx_v9_4_3_cp_resume
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
References: <20230519055116.96673-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230519055116.96673-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d940d2d-093d-46c5-4779-08db582e321c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YNlbaUwawwd3JE3XqerdovHoV+rZluJxAFUXHEkE7/HfA3pgQJ4wr4Of56wv3QlfjdLYLA+Jchfml0GKs5nZaew2JA1v1Rd7mcEDSQ2UfOUU/eoQSNXmOTdlsAgrwIGF4aErFlFZ/ACI91ioHw2Kfb7H7sMxL7UiIsQSN+Y92AX9pyFTO/n3KCw1ao8mWtv3mzxsZrcDG5N/a93V/8YbjQ0mrCikk/kNGfIR4/yoSrzkDwKOmOLx8tUqfTLOyjSIHQmxCWH9L98O8XZGNpw/CSp0ZKYkJUz71YyacMXxDZfwOH9w2BCW27quv0gtUzfBBDye6BMsL9Esv9aKOkZZ2rZ3NYx86DGSNu14cQhjuclHfQ2W3ZyBp1aXjrdW6SunGcyNunF97tHGnwOKP60fRI7MjjJ7AlbVCUNIivUL2+Sr7mW4wyLtLh7HiQCYU1XA3GCctuSsgT0nDqpXTxlEmQw1n3iIDqHgvdD32qaF5AUbPyBLjUOpBq6S6F5ZtmlsT4/acqWyN5vFW9/bdNko0WoSC1opc1lyQP4hVgBIEBjNIRcIztqA+NxiQ+TgrJ2oKVqfGIQxmcsRXfEw0j+Xg+4ieL2j6B/anAybNbV5/fjKOwz5CmiPUJGHOBmLZBYQomhT4h2Ffg5uPJK2virUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(6666004)(41300700001)(6486002)(6512007)(6506007)(26005)(53546011)(36756003)(38100700002)(5660300002)(2616005)(66574015)(83380400001)(186003)(2906002)(31696002)(86362001)(8936002)(8676002)(478600001)(6636002)(66946007)(66476007)(66556008)(4326008)(110136005)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZPUlFHV25XSUs0WEp5cnRSMUIzdk5PSlFBcjcvM1REYjg2OGdkMUtTSFFm?=
 =?utf-8?B?Vms1UXBXc2ZVTXo0R0lNMWRNMmFpdDZha1ZPRVk2VUdMdWUzLzdUZFhWYXl3?=
 =?utf-8?B?dC80NGZodUNIUEZRcktkZnNLeVUzNVRWWkplYi9lbk5RUWtySkVnZjdSTWRv?=
 =?utf-8?B?V1lHTy9PY2hYK1p4STNtZ3NRRmxUSnJxNC92UlV4bit6bFM4VTJyOEFsRWM3?=
 =?utf-8?B?cVNFdmhjSlh0M25VYTRqc0I0TzBub3p3clk4YlEvSXFUMURvOXpUcUdjMjZp?=
 =?utf-8?B?REYvb3I4QWdpSEtvUWQrRm02VGZvRytpaVczaTJBN1Evc2lRczBRajMxb3lJ?=
 =?utf-8?B?RGpFZ0VwTmpadjM2T01GMTZhN2hnL3kycXZLdk9DL2lyaityUlJ2elMxdVNU?=
 =?utf-8?B?b1AwK1ZRUU45MW5XZDE3TGs5QXQxY2l2VU9WTUJCN2RYS0FzR1FSckpwSklX?=
 =?utf-8?B?YXRpQ3JzTTJUS2pmc0xzM2VwSzNiOXduaVkrQXdETHpJSFc0aVFMamMwY0lB?=
 =?utf-8?B?WWtublM3U2JGRVpubGhma21iSGFLNSs3dlhZTE5Lajlod2lwY1lmS1BUbTla?=
 =?utf-8?B?N0t2dmJzTnoxT0pYMGVHekZnQUp5T012RDNzWWhHSmFyT2cvNmhscWF6Z0hI?=
 =?utf-8?B?LzliUDB5bVYvQ2Q1WCtxYkszZUNGUlExSytUMG5qKzlWaDdiZEthNzA4MW95?=
 =?utf-8?B?VCtrekF6ZGkzRHhDQmpkOWZRR2xXVkF5Zk14MGxTVGxqWEo1OHZtRG9QOHJy?=
 =?utf-8?B?R3dnTU9qVkVzVlA3UUNSdkZFSnUwYzI3WDVBVzF2THYycjNjbkVIRERRQXFa?=
 =?utf-8?B?NWEwYlJIcWkwekhHUzdxTGN2aFlIaHBmYkV3bFVXNHRsYXFJRDJ0ZnE0YUg3?=
 =?utf-8?B?N0NTMzBMOHV1U0xwT3dnQkV0S2RLSzRQVk9JTm5oWEQxMzh2M2JRdjEyNjNs?=
 =?utf-8?B?TTlXQnZyRG02akRpWVhWUlZ6Z09BTmFFM2RUdU95MmtpNytxaXpWemdZZDBQ?=
 =?utf-8?B?SlFQaStwY0hFYWpOTzhleE5xRzkxNTloU1plcjJjUm1Kelltd3phdXJ5bVIw?=
 =?utf-8?B?SjkwYWlyN3Nxd0JmNXE4V1JjRDdUa0Y0TTROVWs0YjgrUm8vS0pWV2FvU2JB?=
 =?utf-8?B?REVrYkVRSk1GSnhxTlA1TFpLWXlLWDhuUzl2UE1LWEh6M29OK0t6NGJSZDJ0?=
 =?utf-8?B?MGdtWGQrajYyLzk0TTQzZzRIWHZudW95S3FJZjZ5eDI5cXlpQ2xGMkNObkZJ?=
 =?utf-8?B?VzljQkhSb3RSS2FIclQvSEU4MjI5b0RmbnREc1NTNklBb3pSbnR4ZFdycGxr?=
 =?utf-8?B?ay9zTUNGRHdwbTlYOGl0VUJCczVRSjZETXVIQit4dnI0RU1tMW5UeE9PcE9H?=
 =?utf-8?B?UDNZN3dXSnJKVTlIek9Da2dVSlVjT1A4L2VtaFpkWkRzNjZnTTFYTHhEMzlu?=
 =?utf-8?B?TEtNMXFRT3RLVC9SaGtDSTlHUjFGRW9QK2tiRkpUQlF3azc4SEF5KzVEWEo4?=
 =?utf-8?B?MlUvMkFYMmNBQ0QxMS9yckxmSUtxSVVVdVJxV0hWU0Z0NiswV2VjUDI5TXRK?=
 =?utf-8?B?enUrckZPQmZqamwzTEJEWEd0ZXdUVHR4M09CUFhzYWpCM1JKT2pWUjVOOGtY?=
 =?utf-8?B?S0hWN0ZFeUJxKy9Qb2VJSEtzZFRXbEpmV0xZQ0VURTZBODl4aGdReGtqeEhT?=
 =?utf-8?B?VXNZd25BdG5MMGdiamUvK3lJK0FLTUVMME9qeG5qTlRiS2hHWlJUeHVkY0xj?=
 =?utf-8?B?OVNmcUdwRmhuaWw4UTJ4Rzg3Z0J2YjAyc3VYSUsxLzhxNXVRVHM0ejJnb3VG?=
 =?utf-8?B?bk4vZW83ajhIbTZhdUdXSzZrc0g5cTVzcUZwVjZPQ1U2YlBNTHZmYlhJSFR6?=
 =?utf-8?B?L2RlL3FWNmpIcGk5SHQvY21HRkgzc1hLUEl5dUhHc2d6NjNFTS9wQi81Si9W?=
 =?utf-8?B?MUU3ZFA3cVFiMVlEeXE0TSt0RXd5Y3lTcGR2OFhZRDFuY0J4ZVdTQU01MjRv?=
 =?utf-8?B?MHJsRHcvZDB3WnA1YUx3ZXZZZlJxYzRVdjd4bzRmaWh0ZTdTbDhxeGQxcGQ1?=
 =?utf-8?B?ZWlMRllrTmgzZ1BseHlDdnRqdnd1ZVRDRlZBVTZueDB3aDVjUHZOc1hLcmcw?=
 =?utf-8?Q?Me0hlBX//quY7Cfy1ANTeo9Wm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d940d2d-093d-46c5-4779-08db582e321c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:59:24.0018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoOZVHO9sBzYgj5P++oWiALl1tUo6u2AOGetDBq6/XLZWKQZ4OMPgB04+nKbrHB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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



On 5/19/2023 11:21 AM, Srinivasan Shanmugam wrote:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:6: error: variable 'r' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>          if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1931:6: note: uninitialized use occurs here
>          if (r)
>              ^
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:2: note: remove the 'if' if its condition is always true
>          if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1923:7: note: initialize the variable 'r' to silence this warning
>          int r, i, num_xcc;
>               ^
>                = 0
> 1 error generated.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index e5cfb3adb3b3..d4c9b156474e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1920,22 +1920,24 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
>   
>   static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
>   {
> -	int r, i, num_xcc;
> +	int i, num_xcc;
>   
>   	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
>   					    AMDGPU_XCP_FL_NONE) ==
>   	    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
> -		r = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
> -						     amdgpu_user_partt_mode);
> +		amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
> +						 amdgpu_user_partt_mode);
>   
> -	if (r)
> -		return r;
> +	if (amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
> +					     amdgpu_user_partt_mode))
> +		return amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
> +							amdgpu_user_partt_mode);
>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   	for (i = 0; i < num_xcc; i++) {
> -		r = gfx_v9_4_3_xcc_cp_resume(adev, i);
> -		if (r)
> -			return r;
> +		gfx_v9_4_3_xcc_cp_resume(adev, i);
> +		if (gfx_v9_4_3_xcc_cp_resume(adev, i))
> +			return gfx_v9_4_3_xcc_cp_resume(adev, i);
>   	}
>   

Are you realizing that you are calling the functions again which just 
failed?

Init r = 0  to solve this and please avoid this type of fixes.

Thanks,
Lijo

>   	return 0;
