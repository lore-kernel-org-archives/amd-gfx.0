Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91146C77B6C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 21:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B10410E997;
	Wed, 12 Apr 2023 21:32:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC04310E997
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 21:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKMO2Hbg3QZx+rkkBMYCYEKoWn9SIFmGcYkc6kNc1WhqXHc9FA7uJ3q9sHMQBQNbqCRmwCRTveyIYCot90widCJbXLukD1lBpLjhKqtNAS3cIzx90c6Ga6Z2hulxGovii28ApUPllXJ89KSdVreIXrwCdM8bvApwAVlBxrQC+v+YvqeYjUbBTB3Giwgkr4UOa34dOk+ISmE3nFpCJOHurSBs9YMS3UGYOg9CzV6GqQO3Qpmmfhv+f7h46tTxLhkHTRN77SVa054YTxu0c4LQvxL1nbQFJjhcbv4c18toS2dtFo4fc5l98pgeXBpFh7AbMfhJOa8LofCvOw7lPkYhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExRqznh6rOTPBVjlC8wuR114JUFvNKY0rAAs0jZSohE=;
 b=SlkvAzgM5b/M6ZgXeFYI5tZ0ACj7XgREoFDist/UWG6D9St4pPLji04qXUUOCXxe7zt9f/xuEP/MVY0RR+AIVIXlQyo/X4/iSVptIwh+kZ2V9WTG7zfSJoUdZN2nPXxZ1uS9k+HffHDjmT2p4IeoY6j09ErPXcuu4zA2szDVLGupDHpA1IcHD/7iq43WqtvTDF03EwNhoNq/zMqrng+bz5t9XA+IWi4O8UT5bOiNNpgwUWd2GXPzPQGrQwKpT5vzgPsIse8e5UYo5DMqDb04Ojsqsz8RvydfBwRrzEwvc4BjwYOKPvLpVsvO0joXZBS4RF0E6CVFbz+WrP+62pBPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExRqznh6rOTPBVjlC8wuR114JUFvNKY0rAAs0jZSohE=;
 b=1EufczRwSusjD1sDwmPe9KZBjLRDXrHgxU2eLB09CMO6QVxGlHir298KWmizOcUX+1TqFf5CSrGEE8BO0XohCMhy4+Mva99YIevMjYsElya/83vByf3GE38SdyXBcx+ZOfGVaBxnzHiHflgEp7yU7fHtw8jnq7gp2ABeLAfcqn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 21:32:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 21:32:34 +0000
Message-ID: <f2355433-2585-ab05-653c-480120dd2145@amd.com>
Date: Wed, 12 Apr 2023 17:32:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: only wait GTT bo's fence in amdgpu_bo_move
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412184954.147852-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230412184954.147852-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1d1583-73f9-4143-b349-08db3b9d6e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYU5Cp83E9Q93vu80dHy4/ib6PS7cmqugaHUSiSsYH6nhn43UJQmiCRXQu1ZhgP3iif64+PIAeiN7UASPWXjIpNnp2UftnRvRzzmJTDlANNJoBSQzLcM6Ahs3Lhukc/PKLDroj8fDbONJY4EHCIxUlscnhCKMGWx5eOwtMzMiOZL68FsorlxXww3V6WLwfyxfKQ963WTjTBa4MOl3sHjIw+enRQDwfU8kpFS42CcDFYMfc1NbA3Ov6BEXe1sbGYK49aVHwX2B5jxIscGRH4S7l9tGrfVO3GecH/nDYfOr16e7ySOhmdpQdC57ce/8hta/BM4qVQ6NlNw/z9SCnZGEOv8oogLgQXOikCl4kNeRRUwtJ/0BtwY/HXHB1/Hp+VwDIUojDahK0XGzMlLB7DVbcBgPVXkZfT2Tn3R4kqSCLvklf2MP6MI9TL2UF8LiY7iqJ7dlVyjDwxmxGmuIwMSRXGn/vor18jamMTOTtExzSZVLvkCHoM0MssDKONgW+ML7ss2ntdwDpDuNvZHkOTjorZqENilojdtuTZyH0ggjk4ayi4ZS+pENR5faS6aOeKpvavHClKzcLJs464WAu47XqvrxVW+iuyYvePXlWzjD9ZooNCxtblMCgo59CJMZg9MSLKRh+ZgfxtJpHFyaVa7Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(478600001)(6506007)(44832011)(66476007)(26005)(186003)(316002)(6512007)(2906002)(66946007)(66556008)(41300700001)(6486002)(5660300002)(8936002)(8676002)(38100700002)(31696002)(83380400001)(86362001)(36756003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjEwNk12NDBFbVBVeG5GLzN1L1FndW5FdE50U0g2ZXVEa2NLdlRlQVJsTHhn?=
 =?utf-8?B?SWQyMjczZUJZdmplVGw0VHUzc1Z0Y0tZRnk5N3ZzemJobXplYmozT0QzRGxW?=
 =?utf-8?B?Z0UyYkJIK0RPblM5TU9BdGxqa2hqVGJLaEE0Y2kzeFpNMkdmSENXZDhob0FG?=
 =?utf-8?B?M2twYUNBTFE2dDdJRk9LSzJNQW5EbCtBMDhpV2dTU1Z6L0s0NFVJTXkwZGlj?=
 =?utf-8?B?ZGZ4OFdsVVN5WkxUSWZOTXhOa01NZ1BIa3M5V3BPTm5hcTRtZHJmMzN1NFRF?=
 =?utf-8?B?aWZrdkNZK05DLzhRUVc1aHdLb2U2aXpLelBHQ2ZIZkVzN3ByUzg4c0NjWEty?=
 =?utf-8?B?anlwUTFSYjdReUtqSlpWVk9pMTVhVU5qV3lvUGEybG5OaXpTVHBYK0V3Q2tq?=
 =?utf-8?B?L3pTU3dHd0w5RXlQQ3dmOGJBekw1enk1RStwTDNyZkhyR2pPMzFTenhZdk9R?=
 =?utf-8?B?Qko3MGt5dHJwNVlKVk5QNUtUSi9nekxzemtBc0xlK294UWJNVU9zVTVwTjhh?=
 =?utf-8?B?ckpOSDlGV29SV3J2VUd6TDdoNktRaEs0TnpkbVpnUjh5QTVKTmx0ME8wYkRG?=
 =?utf-8?B?NTJ2RmdTc1U5WWgrbUFwMCtNVEZnRXhJTWF5MXFIbFlVN282K2ROTXRRN29h?=
 =?utf-8?B?YmY0YmRGZXFMMWxxV25ndWx2S1VxNFJMNFMxK0Q0RnpNSll4LzRieTlCcnM0?=
 =?utf-8?B?YS9wUEdYWVI2SzBRR1RRbXEySGI2bzc5Uk51c3VXM0FtRTZkaXVCMEQvNWx6?=
 =?utf-8?B?SG9GakdKVGRwRjRiRWRjbmxrR0ZUR0hQbGQwYlRiSmc4Tll3RnFBY0RNUVhr?=
 =?utf-8?B?MUh4S2Z4U2M1QU54T0UxcUVVY0wvcVh3dE5OdDBrUHFYaXhvQjFMdi9vQnpo?=
 =?utf-8?B?ejAxeXRzVXEzekNWWnVNYkVBSTRXRE1VakN5Z1JobWo1QmRuVUF3ZmE2ODR3?=
 =?utf-8?B?U21SWGZRQTNXU0dtam9tM3BTMjdobnJuSmMyZTVZWFYvdHVTRzdyWWdGQlRk?=
 =?utf-8?B?cHNvOGh6RnQ1VWpGTCtNL09DSHd3eHdncGVodnoxZTB1V2NIT1crdm9YeWVL?=
 =?utf-8?B?V1JndHhPU3NvSE4xeWs4dGprZHpINVQzL05kbWxOZWVNcWNwTjJOQTU4L2t2?=
 =?utf-8?B?WEZHMldLZ1JYbFpBNlIvZHE4SmFSRkFLU0wzMWswN3NhTHMwdDQ1Q2FhdWY0?=
 =?utf-8?B?Z1doWmxqYXRyQmNtQmsvemZJQ1BxUFF2cmFOc25UdEhWNjBkVmtNQWRTOVdn?=
 =?utf-8?B?V0dza2ZYMmFyRzcrdmtJaGxkZmJ0SEtDL2NwbEl1MDdTNU5JMHdxS2cwdlVT?=
 =?utf-8?B?TGJGU3o4RkpNU1hhSDRQTitKcXF4NmxwQU5QcWdtVU8xRnNuVE5tMFFOODBp?=
 =?utf-8?B?MGw2Y0FVaXpkdVNIRGN0cjFBSGc3Mk13d055NWhyK2VURVEyQkZyazZmaC9x?=
 =?utf-8?B?RUxFWUdqQkg5d3dPMjg2MlBDMlhPQ2t4bHVJdERNUS9aUVEyeDljdys2elpN?=
 =?utf-8?B?bG54NlVEbUpjdW1YWmhxdjNTNlk5LzA5V0hCQWZ3VlJyNFJHZVJrWWVTdEEy?=
 =?utf-8?B?TVQwSTFrMlZUUVFLVGlZWEpDM0RsUmNzQWdURWdTWUJ1aE1lQ2JZM3BKRkFv?=
 =?utf-8?B?d1lEMG11dFpDdW10Z0ZFTTJESTNlQklMRURuQWQ3dndwMGNPaUZqNml6Qkdp?=
 =?utf-8?B?SzVIT2l4RFpjcXdjdXJDN2NoMDErb2pWajlqTGJST3lGdis0S21qQk5yeWox?=
 =?utf-8?B?dWpNenhFRGNBM29QZVFISFB2aDdyQTVEcjNVWGlZT1E2THhOQTdQd1Vwa0Uw?=
 =?utf-8?B?amsrcVFteFpRUXdxaU5WdW1EN2pjVXJGZ2RCMDFXcyt4Z3FkZjFNNURIUEk4?=
 =?utf-8?B?WHlTeks5VXRTeHRBQ0J1RFNVYWlMdG1EbEdZNkJqY2VjZkVGTkI1emN5WWZp?=
 =?utf-8?B?M21zSFZMUkF1N1BjUkx2YWlMcTV0U1c4aWtkbzA2UHFQTjJ6aTRqV2JkK1I4?=
 =?utf-8?B?SlU0ZnVaaWRFY043STBPVDZqa2syYTJJUzFFK0c1R0djVUFXRVcyMmQ0dVpD?=
 =?utf-8?B?TEZNS2RiTWRveVZ5TElqbkF1ZldzZHNCdXJWcVlqeldFUlByRks1d2ZPa01L?=
 =?utf-8?Q?oTmQy4Ss9SqF13RN3TSNcMPWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d1583-73f9-4143-b349-08db3b9d6e20
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 21:32:34.8007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBxYMQsdgbN3FxoIr3dRqqVl2/dVS+qFKENawzKdTy4ugnjcC06ZVd3swmxko9ZYbb/WXzELYVaNi2Y4Oihy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

Am 2023-04-12 um 14:49 schrieb Eric Huang:
> It is to avoid redundant eviction for KFD's DMAbuf import
> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

The headline is a bit inaccurate. The shortest description I can come up 
with is "Ignore KFD eviction fences invalidating preemptible DMABuf 
imports".


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2430f3e9f3a7..a0828f6d9fbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -526,7 +526,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if ((old_mem->mem_type == TTM_PL_TT ||
>   	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>   	    new_mem->mem_type == TTM_PL_SYSTEM) {
> -		r = ttm_bo_wait_ctx(bo, ctx);
> +		if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
> +			r = amdgpu_bo_sync_wait(abo, AMDGPU_FENCE_OWNER_KFD, false);

The interruptible flag (3rd parameter) should come from ctx->interruptible.

Regards,
   Felix


> +		else
> +			r = ttm_bo_wait_ctx(bo, ctx);
>   		if (r)
>   			return r;
>   
