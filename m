Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B02C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 22:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6C010E3E1;
	Thu, 24 Mar 2022 22:46:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFD710E3E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 22:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7J4v7no2EEeTmNpHWeVGo3NdnFviu+mzFFfHNZvB3As2WVMagT0fNd5RMTyZr7YWHh+bbpO6kbgXEtdniZC9mc6SrI5WSEjfYSeiOQuf9b1kWHBvUlCnAamXoN84WfeQzWvAinWP/2Pub4C/3mbycWduuj+0BnORZ49GgDyIlwLw9KG+YOpDZ1tA8nqtTMYIX6fSaRFjo7jhKpfXghoqIGxFxTPm/K88KWhzhknUS1B/04XnxcyjIi5x7bWt62lDtWRF9pW5vDIqWP6uz54Y1F3Kq/0p6nQgZ4Upn958b3GA4eeRCk6QlPthCyluTlOKVgyQSCY1RTlHOouSsTQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDS8E5b8bEDWwt2IG7JFdh1mBNxlHgwTrg7TffQG8dQ=;
 b=HDiLuNRzdFYacl8ufQv6SLpwB7qAc0CpRjrYBY5k7J07RS/J4Lss2qUsa0PZovPfgv0eTtXt8Gh0AmxSlMQr+eOCxMIP9B7SJzEw+kztHILRLCYw2bUQ43R4w7gBIZjkgzJR9W++fQbBktcKTcMLptDWbOs/38vWkxy49AQyQtUFBAc5TLej3EJB1NM2oyF2oR9wV5SPsNiN/5UVTxOaPVLBV5xbG2AwfHHXiWxY6O99iA64s1ZXIrpoqDLozmdim6FVa6RFxlyKn5MQq81UnPkykJGCrJx8J7wovg7TNUTQnpM48Tlu5bcIEuDajqjIdnRZcDNoFE/zWIC8UiLwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDS8E5b8bEDWwt2IG7JFdh1mBNxlHgwTrg7TffQG8dQ=;
 b=ojgLB7uK1KMg1FqVmHfy8ME+iVEAtipVhmyfX0GJvMcIIeN61snwHsmJUuf0uLIVATqu0JxrLcCnm9HTnerJcvYnagqZ1x/LfCFFItXrIybf6PwLGbkS7JZJpIL8rcOlccjIvFhEhnYKq6MpfQ1y4ABLExVDuLlCyy2KtnhQ1do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 22:46:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 22:46:46 +0000
Message-ID: <4d0a443b-6cd8-72e4-5f12-f6443d97888f@amd.com>
Date: Thu, 24 Mar 2022 18:46:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: fix comparison warning with min() macro
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220324213156.574719-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220324213156.574719-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf34a7ac-f7e4-4837-5e40-08da0de82cf2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4527:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4527B4E9BFD9BDB17634BC4592199@SA0PR12MB4527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lUIfTE96QFr3C2B583KQegQitm4jyoGEaYKPqrfUt0wpc8uGlSC/SDUJ5W67iqVxdec42c2prysy9MMCMIpHtlYNUigIMiaejhy4gyenSIwoovbdg0VltEqgaqUjJ8XOZ9TVdtO+qfm4JCl2qO7i2/FV70XlNoYnMLbh2ymLngCfwYF+VLsn3K660Z+v75e4C1IffH6Cj5XNFF/nsbr+WYuEz+egi3yRybRLx6yUdrNolfCpNbEYQKxp4Ie7x0cqgcGzonS52IvMPXOPJP5AcYolMjvYG3vxw5/WX9qhyk/RavgMpv2QzmKEPzjikrXHRly71mg3EZ0/8C3XwO7IW1lI+oF4oBsn6O7AizHcnPZ0Nll4lzxKc222MBuR7rzguDvLr0XGAZu1kUFtH4T1ofipi/VtTiBNjuxkNjAC8qALAL0o4V8DJeMnOUnR14TzNuYPYvnf6Y5N4pDFKQkzGZN/oTmgea7srSu4kamc5Y6+y8HmOKi5yKwNnJWBTWPpUY+btqbUsWP2GHBaAprORcyY18kWNIkP+OEhYtCMqGJ4hrX8XFyMZLnnEh1wBLRWaSxclGaEfRpJAXCrgt8ZsqMt14YgHnbOfy1WtuaVeaA/gxUkJUqz79m6wNl/kE1yj1II5S+hdy5/4k5lQPR+dRdiyyANyxtInTXEUy9WH8+X7Xrgq8DcggxT2qaun1KjeMEbxUTBAJ9PhYDALJuprVbxw++3i6Wm9saIO/N0gD9QFSZVABf629Kk0Tts0ri
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6486002)(508600001)(2616005)(31686004)(8676002)(66476007)(86362001)(6512007)(83380400001)(66946007)(66556008)(2906002)(6506007)(5660300002)(186003)(38100700002)(26005)(44832011)(36756003)(316002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJKL25ZeUhmS2wwZno3UHdaSktGbllyT2s5V0c1MC9CZTU2ZXZITmNXWG5M?=
 =?utf-8?B?elNGeUZrVTUyZERkVHB3aTcvckpyT2hlSldYWmtWZytyWE1oTi9FMXlpWi9v?=
 =?utf-8?B?YVVYdlVNZzhhRkoxU1NLbE9rdW0rOElHV3RITmtyc2orRGw5YVFCUU9GNE1P?=
 =?utf-8?B?eTkzb2VqdzNsTUhOaTl2VFBsMFpEWFZXT0ZuWHBBR0VmeU9KNDNXTHczNnpF?=
 =?utf-8?B?YWI2Nmp3Q1RGQzJWWEFRbzlxbHNoa09hNkRaSUQ3c2hkRE4rNFBXaGcycWxQ?=
 =?utf-8?B?bVZFWTdsSDN0bTc1b2NIckUrcVdzbUM2aVFxcUxEVkZMU3JWK0pTdHRMM0Mr?=
 =?utf-8?B?MnZ2RmhuRkJBbVhEd1Q1NGtvQ0dOUUQxUFQzS3ZnL0N3T09BRndXb3dWQzEy?=
 =?utf-8?B?VVcrR2JkVGFrVzVRd3FqdzJkaDg4U1k4WklkNEFNTGlJalMvWUExNSs2TTBh?=
 =?utf-8?B?dWtDZHB0U3FGc082cUVJTzBidS9VQ2o5UXFvT0dTTm1SMGl4QWFTWTV0anFv?=
 =?utf-8?B?TTRMMUpYbXpuc3MrQ045KzA4UlQzMkhXNlRQSmluR2RvY2VDeEF5NERmbjFs?=
 =?utf-8?B?dy9NaGJDamtzTktyY1dIaUJNZU51SGFGSHN3aEE0VVlrNmRQNGZ4V0QxVzQy?=
 =?utf-8?B?LzBYWHlURitRY2dDajNTdnY4QnRhOTlrbkFxcnNmWXp1U0lXa1ZmMFRtbkN5?=
 =?utf-8?B?UjNzdVMrRUlhRGprcnkzYmJTVXBDMkdQUGpRNE9uMWlEcjQ5UllUQUUxUzlQ?=
 =?utf-8?B?TVVzaFppVGtyOFpsWDdxY2tVVU40YUxUeTdVeEpQQStiU0JxSmxmNmVoMlF3?=
 =?utf-8?B?NXhER3N2UEVRQ1F6NzMzZmZYbjBLc0pyUFFmVlJWcXBuUHlPb3crYWtHSWds?=
 =?utf-8?B?SVR6U0twWDBHZ0kyM0Nja2k5TzFvcWlGcmlTQzFySzZ6aEdldjFKeGMzNFRY?=
 =?utf-8?B?eENBaEVVK1JjWWEwbWU0Vk0xL1p3a3NWK0xVajI1SWxXUWpIVi91aG11MWhu?=
 =?utf-8?B?U04xdEdNd050c29RSUpjclk3WnMxSEw3V0tnSGwvVFJpUi9yOXV2NjhPT2Nr?=
 =?utf-8?B?Q0J1Ni9yT29kaHVrRkFhV0psVE9Mc2FDVnFUUzdjVzA4RTRRMnJXb1A1OHJ5?=
 =?utf-8?B?bjdIQlhNa1lielFGUVlkSzB5azdHVHZMbWZYNlBud2xiekFROTF1MStmZVNo?=
 =?utf-8?B?Tnp1aHZEanhCMk1KWW83ckhpRFNKT01qVlowYkRPZHZBTU10RDVSRkNBbS9a?=
 =?utf-8?B?blU3ZDBzNnBWcTMybDJ0d3F0S21MMThBWEdkaXA4YS8xSUloVTZoS2tDQVpq?=
 =?utf-8?B?QjhQaGJYUXh2RkIyczdQVDVHWGV4c3pRc0hFVjFWaEorbFVqZkJMbDZlVE9z?=
 =?utf-8?B?ei8zRWlSZDd2NEI1S2N1bW1JWjhtUldGQW9oTXNtMzdhODRSSTMrVkpLZFV1?=
 =?utf-8?B?WHBmZ2pORmtCU0pYcVNTYTlNSHV6M08zWkVIQ1YxN0tqSHltcU9OdGowQzFv?=
 =?utf-8?B?d2hUT1hoR0o3MnlJdkI0VEFsYm1WZEFQS0Nyc1RQaGs1OXlNNVFtT21nbUhm?=
 =?utf-8?B?V096U242bmtvNjI4R1Z2SnpzZEd1Nnpsc2JvWTJTaWV4Tlh1SkdLbWNMRlZo?=
 =?utf-8?B?Y29VWnVoRnJRSStqdFoyaS9CZUlMeXp3VnRuSjE0dlBaNFFpdDh5VkZRNXhi?=
 =?utf-8?B?TmJLLzArOXg1djBBa1Z5OHk1NHF4RWZISFVVVjFxRDJiMHp6bDFsM0sxdDh3?=
 =?utf-8?B?RXFpNmE5RXdiMEwxSFdLWnRNVXFMditRT3h4cFdHemN3RGwrSks0S0EzV2xy?=
 =?utf-8?B?MERnc3hucUJEQWhSTTJlRS9ZeVFiTGlkTGlEc045OGtxUEZlTlZqdmp1NXY0?=
 =?utf-8?B?SXFOcnBjRlRsR3JoTnNzRVFtd2thSmpmMHdNQ2FOOEVmUkpaeEdHU1F0Y01W?=
 =?utf-8?B?WU84UHFCcTVnMm9tWk9KSlowV0NUbFdyaDRMaFNmV2NCcnRxam1RanY1ZE9N?=
 =?utf-8?B?c0k4T0IyQk9kWVZ6MVJKTllMNVBnd0MraGJCQ3lQK2pwdEx1c08zNXVuQ0hT?=
 =?utf-8?B?WjI3UU1BWkhpRnI4c1lPRENiQ2JHS3hxYVlHV0tHMHBnQ3NCMy82a0JiOHBQ?=
 =?utf-8?B?cDRod3FYZE1lNG92b2F5VkdxVTFmT3lUN2NnM0d6UkNsU2ljMFd0UHVXWkgr?=
 =?utf-8?B?aU96WlVhV3RWZkU5ZXpJSUQ4YXpkVjcwQ0NMazNCSFhxaEo0ZkY1YUkvdGF3?=
 =?utf-8?B?SWRYbVZBNU5aQ2FUMnZBZ3lOZmFXTVdJSDZIZWZoRzN4cXE1R1MxVXhES0xL?=
 =?utf-8?B?VVpMUWF2RjhVMGJEWVA0dTduRTB0RjVZQzBOUmVxQzhtM0gwSkZiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf34a7ac-f7e4-4837-5e40-08da0de82cf2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 22:46:46.4782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8I6Rts9geEr+nm17p0xz5rimlG/cKrM+JIvPeM9iVjvcqB4pv2qAIYBYiNse4lwzlQw8hf9tDxfcqj/j0EniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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

Am 2022-03-24 um 17:31 schrieb Alex Deucher:
> Properly case to u32 to fix the warning.
>
> Fixes: 83f1287c57228f ("drm/amdkfd: Fix Incorrect VMIDs passed to HWS")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index d70f787369a0..62aa6c9d5123 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -484,7 +484,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	/* Verify module parameters regarding mapped process number*/
>   	if (hws_max_conc_proc >= 0)
> -		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
> +		kfd->max_proc_per_quantum = min((u32)hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
>   	else
>   		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
>   
