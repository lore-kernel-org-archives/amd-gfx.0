Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF78C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 07:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7496B10EB74;
	Fri,  7 Jun 2024 07:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJtu9nJL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA8E10EB74
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 07:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybjp1mWANR7jebtfTsvQ3P3xq4eSFQjTE8dMbqU5/Y3zcniuMuK7EFwj6tWctjXxgFJP0Qu1DSzM3EbaByv5C2bEP71s0Izo79gtTNP6xiT43BNsOP9qDLp74x1hLVUvnRpfEFZaVu6rY5dXbYfg2iOW1BOhG3j2WYKmOZGMzVlrC2xWGWZf1sjRqdhQH1c9tzNZDgK8BryKtqObjiZfF504neRS5RBp4SA2yKUjjlTSoODTE+Blef+QtLOB6b/nVmOJUOZPXiRA41BAgpnrvic2gameN4U4GqPpzHqqF1p61er3lDVpG8BXlQStkrmdxp8kHcHuCfN7d3SQbxTPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hMhmlWZZfVnNU5svtj84Mwa0D71kZJckV5txFd+NTo=;
 b=nXQwtjCFi3C7LQrgDaqihBOs5tcQzlwEZyiX/Ak4WH/Gh3E87o3QKVoGBEXSQDypz3Kx6fRhrTFvyT6wjbSbALefnvPwPs//sx62x6KxuB/VeQOcDaYAtjR3VwAEdrW+izipuwhAMeYsWUEvdJrL6qbMwmV/bM1b8E4JmTj97b9Ir7J24axQNNUSNjJWB1sZfO0X6EzWUtf9oHyhYMcFyNecUb+RZ36KL97AmamstDNJ4XMSJEJuFL3ZUCiHdzdoRvIMDLa9Qm9aWrAJNBh8CGSZApNsg05rcEhxb+DzpPiwdsHDRF5M84+V61MSOIxi/dog3LisKYgre7J6oucKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hMhmlWZZfVnNU5svtj84Mwa0D71kZJckV5txFd+NTo=;
 b=ZJtu9nJL/B7U/4XyszjKaYHMgo2q7eWUDB+iKb1lO9Gfs7yPlCWnhGcX0fSh+jYtlOUAQ688m5trD0gWH0rKwGtLiXeBE38wRwsTQ+f+/Upua+sL/ojQpPopYHLMZ/jOjpk6DJa3uPQRimhTinsTRNBTgjlRuf1/A6Sb6Y3XnHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:26:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 07:26:15 +0000
Message-ID: <c2ce5317-a817-48d8-9fa7-ae6dcfbdaf3b@amd.com>
Date: Fri, 7 Jun 2024 09:26:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Add cgroup memory accounting for GTT memory
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, rajneesh.bhardwaj@amd.com,
 Philip Yang <philip.yang@amd.com>
References: <20240606192233.2836986-1-mukul.joshi@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240606192233.2836986-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d430aa9-b504-414a-c777-08dc86c31d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REY3ZUl3engzTFRBbWxTREMza3VBSVVDVnovSnhjR2JmVXVQTVA1Uzg1YUx0?=
 =?utf-8?B?ZHhpMFFhT04yQnBJSWNRQnRJUGdLMVhpZnN5SXU3S0VBMk9RNU1rV3Axd3Q0?=
 =?utf-8?B?eHdmT1dzaXlIZmJkUE9ZRzEyc3RuYjZXbmd6OGE4MTFWTTlVSXFXL28yQkEw?=
 =?utf-8?B?aW1PdmIrRE9KMlBDVGJ0MW4zdTZFOWhoZ1FrWDgwUGNmcnBDaEVQRFBTRmov?=
 =?utf-8?B?UkRKN05aODltQmlmcWpmWjc2UUh5MVBPSDhTQ0NOZWtKRUtWZWRjVUVmNWI2?=
 =?utf-8?B?YUthUnVSWnVYd2QzZ1VKYko0RGpIei9hWmd1bGhDWFVOb3lvU1kvdzB5bFVr?=
 =?utf-8?B?VlY2bEhZZlVkWUxIaUs3UTBoTXo1dEhBaGdDM2FjVjhXbzBxRW9iUHdNdFpv?=
 =?utf-8?B?NnVQUWhLUjFYNmVuNFJEcU5FamtOcDNTMzFaSDdSS3p4TG9KMGUydFZCaHZp?=
 =?utf-8?B?MytmeThtNEZNSXpTZkJLRHg0WC9CQjNzeklXc0VVbUIzQno3d1pnNUNvbXF6?=
 =?utf-8?B?amJySXJkVk1pNjFOMUN6VmNNd1UrdXlMV2VlUW16ZTkyL1ExanlQRkJIMlJP?=
 =?utf-8?B?MlZjVDJWODd5SEIyajUzQ25Ga29FdjRzdmYvbS9zVElydVlOMzFTQ2xlUkZP?=
 =?utf-8?B?aEkrdWZyQlRGazJMMFB2Y2J5eHowaUpHWFNTMlpsVDQrS1NLTTA3cXMrQ1Nl?=
 =?utf-8?B?RXN5NGFMWk5wa05ETlRhOEpqTExOcFAzTWk2UXVYUmpZUDZhaHZVd09VS0Jh?=
 =?utf-8?B?RE9NMko5eExhWmhyb3poRHdjckJjWElpT005cjdZMGx1cSt1UG5Hajd0dXc3?=
 =?utf-8?B?SVJNZVRuOFdFYWFUait6VE1WWXRHWWVyMEx4SlVkcWRsSVYvS2N1ODNVODda?=
 =?utf-8?B?M2dkYjhXendxcnhGQ0JnZnZoSThaMSs4WlBjcGVTQjhEN01qQXc3NUpDNGFX?=
 =?utf-8?B?TzhGL09RSVFleXBSWVdoMUFqU2FvcnorZFU2QWJ2SmhKNzA4VEZKTFdBOWVz?=
 =?utf-8?B?Z0Z1OHVwME9RbDJmTFZmMWlOZGRoOWJSTXExMGo1UXNPMHhLWE1JSXI2U25I?=
 =?utf-8?B?SDJxR1pBeHhpaFlKOUpRMmxtKzNFTUpQOThKaGpLQkorYzVvMk1nbTVMWFVa?=
 =?utf-8?B?Y1pXcnZyekxwaWM3Y2wvVTN3Z1JnZGFSQkJYM1E5bDJ1N2JuMW1OODVjR090?=
 =?utf-8?B?R3QwNDBzZWExNlBtbkViLy8yMGFDWm41U3gyQ2pxTVRCTEVHdFVBRkFpYyty?=
 =?utf-8?B?dTRxdUtGNThnUGlSa1lzWmhFRFZsWkxPbnRFOFg1Y1R4cHQzN2Z2SkhPbG9a?=
 =?utf-8?B?SzBTSXVLNS9TNTl5eklpbHVxNDQvM0lWcUhxR21MQWRYRmNBbGVYcFFDNHFF?=
 =?utf-8?B?Rm5jSHJRVFd1VnkwMTFvUzhWTHlzL2VDeWpIb2FXOERQMGFzcjRnT1N4akY0?=
 =?utf-8?B?dUdOK3d4RjZYNU5Uc245cmkyMkJzanZCRkkvYmFDMFlXVUpqSnZCL3JpM1B3?=
 =?utf-8?B?ejE5aUtoaktydWV3TStTWVZ5Y1VtcGJxR050eXJnWENSbmlxWkVPdTd1UGFh?=
 =?utf-8?B?bEY0SHhOWUplUVQrUkhFTVM4Vnl6QlI2ZzU2VkJDcFNWayt4YUQ4MmxUWXhK?=
 =?utf-8?B?TlJqaUozeG4zTmVoL0MwMXorMWoyYy9FVXg1b3BGVElrQnhBb1diWjI0ckRp?=
 =?utf-8?B?Qjc5OEgzVzk0TC92cy8wM0JLSGVvOXBnOVlmQmNDOEpxVUNpS3NOeXZXdGR1?=
 =?utf-8?Q?Rj7Zj0gtIlg+dLl7mcbx1J26grjKQRv6TCOKsSw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5LSmRpR0NDMGxMOGNxdVk3ZjM4b0xqdFl2ZTkrL1NpTTJrRTFMZ0dScnhU?=
 =?utf-8?B?NTNtVUpXVHRiTDRjUEthYTBGRjJQYitMbW5DSUcvUy9IbEpWdWpPclo5L3hH?=
 =?utf-8?B?SFFHTjJBZFpWTGdCbmUzVGhjMjFaN0JXcS9BTU9yb00xOTJWQUdwOWR1UVJ6?=
 =?utf-8?B?aklUbW9DSG5sczFJVzhONDZtNmNaaGZubjh0aWgxbFVzbHJRQzBKcVRoc0Ni?=
 =?utf-8?B?a1VxdVl5NG5pSllpTnlSWXVWVExNa0NwdnZ2TmVGRHBvdVhhdDYyWG8yakZF?=
 =?utf-8?B?VUh0TDdlN0tsUFU5STJWMzFzMVVmd1dCK3JiNURkQmI1UlNDMCtzaVRmdzRt?=
 =?utf-8?B?SjB3RmlwSDI5UE5zTTFvVmRoL1FBcWxhWWgyb3Q4WDlib3pqVmNJckIrRzVE?=
 =?utf-8?B?SzZMSVVZL0NocjRtbGU0Rk0vMWp6S2RiQnZoU3VaNHEyQjFya1RzK3VqMlNq?=
 =?utf-8?B?MVRKenJYaEsrOG1DMStsSGJJdk9HMkNsMGlsejlHeER4UkRlQUo4ZzhKaWhG?=
 =?utf-8?B?emY0V3NoYU9zajBiR0pUdFhzaHV6ckZGa1gxaERrOFJzR0JwUW44aXpTNmpZ?=
 =?utf-8?B?cnYyb2dKcGl1YVpOS0xVaXgySkhuSkQ4ME5kQzZIWjhXUUM2ZDRXUThlaXZo?=
 =?utf-8?B?S0dMNkd2ckVkalh4S2VKU2hLeGJYaU81OVV4QnozcjlsazkraEhaM3RuVU1F?=
 =?utf-8?B?cUlJWGlSU3FrWmFVTmx0M2x3V0dEUkxQMkM3OXZjcUg1NWQyVzQycDExM3Vy?=
 =?utf-8?B?RXpqeEZmaE5oL2kyQkxFV25BbFhwYnI4RTRGM0pabEo0NU44WklpS2lQWk8v?=
 =?utf-8?B?YmpYc2tEOEx0K1hPMFNqNlZYREt4WkRIdHVVL04vY3Njckt6M0liVFFkcWZx?=
 =?utf-8?B?MjczSnZwY3BGMWZOZFloa0JjQ3ZGaW5tR2RpMW9ScHlCMnFJaVlWRnkvUmox?=
 =?utf-8?B?RXQ5dGZzUHBYYmJuTjF6MjI1NUNXM2NDRWhma3RHUEZ4Rk5wUlB3dm4vU29Y?=
 =?utf-8?B?SWVPWW9sWCtscko4b3EzZitRbnFOVGdDMzgvdVhjVVNjbG03M0dSQllOOTNH?=
 =?utf-8?B?Tk1Va0RZNXNBeGZCNU1ha2lNdUVLeTRYSHdDYnh3Mk9paFpHcllyNmRWV21h?=
 =?utf-8?B?STgwUGVyVEVzcFJvS1JJL0JmYjBIa2FwUjNVSG43YmUwajZyd1plKzhXK3Zk?=
 =?utf-8?B?T2RHSDdaZ1BKWTNwUTVNNHBTdTcwLzJWaHo2VTR3S1AveUltQmhCSHVzWElQ?=
 =?utf-8?B?ZldiTENsR2pNbEVUeG9JeklEbGJ1d0doQ2ttQmZUbVJ0TUE5RXhwZC9JR0Nr?=
 =?utf-8?B?TW1QbGZ0R1dQd3JGeXlQNmJPcWlrMkRMN0FyK0Z5REZZcEg2ZkxkUm80bWlu?=
 =?utf-8?B?RWxTTGhISHN0ZWlmZGZldWE0VFFneUdQY3BoTHZKbVdIQWJ5VGZTYWVsN0NK?=
 =?utf-8?B?KzEyQ29sUk1DUFpBUnNkN2F4Zzc4SFNFUllWdUFkU0VSQ0lzQVczSE1KL0hY?=
 =?utf-8?B?ZEdUQ2xZbkF6dFhoeTV3djJRM0N3OGkwUWUzZWM0RmhXcVJlZTNtUm5jMFg4?=
 =?utf-8?B?UWh5RXFNZks0emVKMUk0ZElha2dTdmtsTHV5SXdwQWE4YmxaQ01tZFdON2dQ?=
 =?utf-8?B?SVQxb3FWT2VjVEFQN2ZKY0F1dSt4a2pqMkNobVAvL0dlcFBsU1NreG1lN3NN?=
 =?utf-8?B?NEI4MWwwQk9ibUlBeHlodDY2MzIvSUF0M3gyL1RyVklPQ0pOZWxtK2tsd1o0?=
 =?utf-8?B?aHRuYThKU1hMcXJnSVRZMTVicm9GRGt1ODNFc3N5MXlsajZPVHBsNDE0dVVp?=
 =?utf-8?B?UjVSUXMwQW1IOUVEWWpWOTRyUzhMc0JrYUpra0t3cUxuSVFqdzdtcE9zSE9v?=
 =?utf-8?B?cUJ5Z1NHc24rOWsrYUFTRTdVZFdsWEx3aUwzV2NNVEhXV2JJY2xDRFoxV2M2?=
 =?utf-8?B?aG5JZGhQR3lyaCtzY2VtTWpTZDRoK1hiZmxycDNnRnc4V0tSUXlnMVc0L3Ra?=
 =?utf-8?B?MmdQeERHWElweVlhdTNWQnVSN0xROGYrSGlVbWZFZEZRK2ZPRTVGY0d2blpV?=
 =?utf-8?B?bXVQQmxKQlkrOXVNbW4rb2c2TjUrWU9JN1poVGpaWmJ3azV2bjA4aUcweEJI?=
 =?utf-8?Q?/9MwmcnbKvmnx8G7kTGLgJA/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d430aa9-b504-414a-c777-08dc86c31d98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:26:15.7112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxQZ1G/2To0UUny/tP/eKHn0iB0KJ3SF2JJGqQgFvybzd/zvAutI/33hdFEbiOXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

Am 06.06.24 um 21:22 schrieb Mukul Joshi:
> Make sure we do not overflow the memory limits set for a cgroup when doing
> GTT memory allocations.

NAK, That's intentionally not done like that.

Please see the cgroup discussion on memory management on the public 
mailing list.

Regards,
Christian.

>
> Suggested-by: Philip Yang <philip.yang@amd.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 6e1fd6985ffc..59e1accdef08 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -91,7 +91,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>   	 */
>   	if (order)
>   		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
> -			__GFP_KSWAPD_RECLAIM;
> +			__GFP_KSWAPD_RECLAIM | __GFP_ACCOUNT;
>   
>   	if (!pool->use_dma_alloc) {
>   		p = alloc_pages_node(pool->nid, gfp_flags, order);

