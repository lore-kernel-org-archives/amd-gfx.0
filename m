Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B67FC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8405F10E1FB;
	Fri,  2 Jun 2023 16:37:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC5C10E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 16:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNSSOZZ1A6PbdeZ+QulTzXQWtyN3LxsKSUVn/VrvbF+lOIqc6GY+ekF/0YAUMh5rj/YRRRATTZbfUcM7zr/F/T9QTtzYDb82KU2A77RboRITNLxMt0lj+QWomBgQQwV/oTMuJYmplTmvkSbFGkgGfdtoujDp0Dokx63uK4kpE4heCvLsWe2TYq8SLLxMUCNSPGBZZeRZNDrv1Huq0ZSWs/1y1V2vbKaACo4MR/m+cEjaP9EVd9dTFZsXlSDLkTU8zK2pOOikL1lM9iMWV9WEiyINrsm41Vzs6D16mMyg67FkGawFGOyxnE4NV1eJH5pv4mCXrbxtaVnsYsLO7F2OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ikmotmw622HQuMbDnr2SSZeE3hLmyzAi3HjXw9/jEM=;
 b=LRlhJ74TpJP5r2NgfAUhsYSUnw65zOjDmBAY2s996N5fPFBNXusrqlzDZM2i0F6FLwF/ePWEzVDDBkEbEbzpL5pelqLz9RZjzyEESc22nFzJ3eanW882eqW1U41hoIYXjfonuA9pDRl/Va/VCg77qlywM2ghAEpZa4tNTU5nV/MoxT+peODH0gY4EK07L82q04/FEbG24KeIs/w7ED4c9JbiLruVKRF6JnrUOBDsiEXqV9XTcVZQ21bzTXT5+awMptRsxfuqHUGVFrrVWvu2EU6rub/8Pjno6bbwZOO3GaApiQrptMNVcgD2eJI4qwZAIQ8DSusmhBfZlQBB2b0hUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ikmotmw622HQuMbDnr2SSZeE3hLmyzAi3HjXw9/jEM=;
 b=gfn8sF0FDdc5YtwWzRDBI+bzuRLHFY/kMrPukgNGi6D2f41MQs//6uDHRpeb5IXfwa1DNpTl8EQ0RM0nOR6V3+fOQ/7yl9KiZo6FMzy5ghrcbKmWtb/l8zhQjobvShXtR6ZDwP2vocmmN8OXikuD8KyY0QHTINytZP9/qp+BZwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 16:37:41 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 16:37:41 +0000
Message-ID: <911b646b-c1bd-f65b-be9e-0df32cd1dc12@amd.com>
Date: Fri, 2 Jun 2023 12:37:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: fix debug wait on idle for gfx9.4.1
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230602155801.1438646-1-jonathan.kim@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230602155801.1438646-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2314f33d-2668-4387-5902-08db6387aec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9ah/OMAIdSc8a4k8sVM+/PTEyqZF4F2P1utHIrxCqozwLB0Sd5Xzr//XPJHJwZNbgUOfp6wPL8gqMhuw+hT2SOiJqaaEr0siEn5xPDovc93pDLoYSpjltfNZSRi7/UWVdkBIV+koCvu2DLVwHdeOpn0b3firXSW+LNzmPtxScgWxkEhASCEvAyPDpwFYjsKfCd47hRMsuMWRawSqrH7JC/z50h5psIePKdlIFDn/Au1Bp7pp8vlzkRpYHNYeLpWwZXn4TYYW51ecUmV9u+xZSE6YU5vyO7kV2KDq0iOd0jv1D7+kpio/YbbttVMSxytW6PiR2fHWSpxsAtJ9RWTfwLg4XFAX5ooXzPq8X9MDeyhpudV0h47PbZVDY0nMjVBuiuOkMBXWQAAlxgYEEWUDGc9DCmO1ZFHkdFVFu4J2HlrdoEZWhTasES2wyiy1Y7rBwu4CocxGfyIte5+Z7sUh5LJQaUAlq0wFN99w0fLUsSFbcXDhvPyvM6qEQRH8ecvdHVzHGngJ2ppknqNVhDkMoZW9xEv+VyLDFyHnI2EkHCYBsht6eFJnEWLXs8LZXCCfGZaJi6eX1XJzKq3yPQTnnkpPtnPKSf6Cu8eyegZy9IbXJKBQt21MP2DgPrMq+W2rvHJ9RA9RGXdR8RpqPhUQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(478600001)(186003)(6506007)(2616005)(53546011)(6512007)(36756003)(26005)(83380400001)(6486002)(6666004)(41300700001)(38100700002)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(31696002)(86362001)(2906002)(4744005)(5660300002)(31686004)(8936002)(8676002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBiZGN0bE4xYkJKYS9SUlZsMEhqdlk3V3hoMmNLelJhdkVORWRMSjZUV3dF?=
 =?utf-8?B?b2MzSTE1aGN4L1piS0NoRm45a0F0RFlkbmFZbk8zTlY2SGtmbHVBbHFpeHcr?=
 =?utf-8?B?M1h2c25kNkZyaGxCZWxlOTJ4c1JGeExCUThHbGhPSGw2ak80T1NZbFE2WkFM?=
 =?utf-8?B?dEdEbjBkVFFhNmFGakRJTldGdmNJaXlNLzE1ZEppOTVMcTBONWJyV2hKQW9G?=
 =?utf-8?B?SDMwN09UZXdaU0lDMFhDQnR6TnZnblliMW5TNWZkMG4zNHN3RThGaE04Ym1x?=
 =?utf-8?B?WjZvQitIRTFQOFh5WjhXZFB4Y2FpanZSL3MyaUJmbTFSc0JCTDRRWG9NMUZq?=
 =?utf-8?B?ZlNVZGY5WWVJYVN3VFp2Ti83ZEc4MTR1M3RZb0ZyYU1EY3pMR0dQZGFsUFVp?=
 =?utf-8?B?N3dCcDFLcTVjNGpvOUxYbWNvcGU2Q3h2dG9QSks4WUhLV1BtMFJ3b0ZqeVpI?=
 =?utf-8?B?ZUFlaU0rZDQ4MXVzMWQ0bXRIY3k3cUF2Z2NXS0JOSVZsMXNHdnlaZDRDc3ZJ?=
 =?utf-8?B?MzZCSThqRWxLZHRYMW5vM1J6Uis0dkJHMjNaTm8zdlk4bytsQXBDVVAyc1ZT?=
 =?utf-8?B?TEdSQWszS21oWlhuckxlWmVMM3BmZkRncmxKdlZCL0dvMTlHZTNTL0xWN2tv?=
 =?utf-8?B?MVZTTFFVdXVDbk82R1UyL0lRYlhVd3kxQU5KcHVvNWpESWtHYjE1YUkvWXFG?=
 =?utf-8?B?MVRuN2Q3a21aYSs0djduRUkyV0EvUnd2b1VCVE1yWklydlVpT0p4QTEwODh1?=
 =?utf-8?B?YnZneWJySnBpckVkVkl3bDV6R25wTW9INStIN295eS8zbnRacTRDdWJQcFU2?=
 =?utf-8?B?Y25DK0RndDhoYnZzYlJ3Q1Q5ekNiK1V5K2doTkZjNlpBUCt6R015OEh5TTVi?=
 =?utf-8?B?S1lWUUdwZnFnc3RCY1IwQUE5Njg5d0QyYkx0UEVDYllrMEpndk1nK1JlNzdH?=
 =?utf-8?B?NHBIU3FTbjBSbi9EQ2tlVG1PTkEyU1BHWVk1U3FaeFkxclhWTzRmTkZHZkc4?=
 =?utf-8?B?WDdWWDFJeGhQMk1iaUtEZ3FFQkhFYkNtUS81MkdhYVFTK3JRQ2twNC9CMFBj?=
 =?utf-8?B?S1NoMTd1VVdWQnhwRDJyS0ZWT0prK1hRYVZJZVNRRmNlWkRtQVpIT0l1RUs4?=
 =?utf-8?B?cVFGMnc0MnBjWlJBQWc4N2UrZ2ZjUUpUR0JxOVcxOW1wV0FHOHkvcXNIaDRi?=
 =?utf-8?B?SFBmNEo0a3FaOEQrd1ZVZkZ5RzR1ME9CbktSUFdKeXhQSnJsWWM3emlYWC9C?=
 =?utf-8?B?UHB1WDdjaWlaQlhTUzlSY2xnV0NDVGxZaUoyZkpNUnMrY3kyZzZPeXppUVpz?=
 =?utf-8?B?ZGR6OUZFdFFVQkdsU2hnR1RMejY2V1N3eHRZZjFLRzk0SUhwSk9Nc0JHc1o1?=
 =?utf-8?B?QU4rejZNTlE0Q1o2MlM0REFXd2V1SHVQQ25peEcrVXRBT0tXOE5pZ2VXU0pD?=
 =?utf-8?B?VE9LMGptOVEzY2JZMys5Q2pjQmFtMzFuYm9YMEFRakZEWHBYYlRqYTg5eGt3?=
 =?utf-8?B?ZkNmdWd5S2lyZC81MnZOOU0zWlFVK2dpd2RZNzRYY1NhQzF1UC9rZHQwWU1r?=
 =?utf-8?B?bjMzTUJKeHpBT2xMYktqcEowaW9XVmVKY3BHT0pLeUk0bDJlVmdZZEJyVi9s?=
 =?utf-8?B?bzNJUTFXNmJkejRMbmZOazh6cXZUVURsVTFuMVNjWHFhY2FBRmFRbnR2Q0t1?=
 =?utf-8?B?Z21TbEU5U1JrMUcrcEwzVllnZk1ubWVQd0VicDNaZFBOdnRTVG5CK2xBakh0?=
 =?utf-8?B?VzIvZ2Fub2Q5eTNpTUxScmJYaVZjRHhlTmU1SnFlejR3RU4rcXV2eW8xS3lS?=
 =?utf-8?B?TTJzRytHVjhVMXRrNnNQbEo5WnBKb080bm02OTBLQ1FQSURXR1RoMHk5cWEw?=
 =?utf-8?B?V3JOWDJoOGN4dTB3VUt5TWlCK0ZadDE0dFh5NFR3UmVWOUh5RW5UWHA0VWZO?=
 =?utf-8?B?MytmdXdXL3A2ejdIZUVVMjh2UmhhaDYxZ1hwdWtpclNkRFp2RkVodUltYnlN?=
 =?utf-8?B?bTd6akN5NlVhNDRJd1lBK0szOStwWHZhZWlxODMwV1RWUk4yZ2NrYndHbXZS?=
 =?utf-8?B?c0pEZyticW1HWmtyaElRZkJJdVRZa0x4cVBsbTAzWWI5YS9qekFISzNDaEMw?=
 =?utf-8?Q?fvORDMUjtorfDGE6SS9mHAUyX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2314f33d-2668-4387-5902-08db6387aec4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:37:40.8764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDMQ/gWC3Jc8QNVpnQi3A+cyMQZg94jFYlNhWk/iLj4XDMbdSnqBi5DSys/qnSPefFZw/Ann/OTny7yrlHabpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Cc: Kenny.Ho@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ amd-gfx

On 6/2/23 11:58, Jonathan Kim wrote:
> Wait calls for amd_ip_block_type not amd_hw_ip_block_type.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 6df215aba4c4..625db444df1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -309,7 +309,7 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
>   	if (!suspend || r)
>   		return r;
>   
> -	return amdgpu_device_ip_wait_for_idle(adev, GC_HWIP);
> +	return amdgpu_device_ip_wait_for_idle(adev, AMD_IP_BLOCK_TYPE_GFX);
>   }
>   
>   static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_waitcnt)
-- 
Hamza

