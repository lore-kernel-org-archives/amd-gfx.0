Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067A3C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 07:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5E410E2EE;
	Wed, 16 Aug 2023 07:04:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F58410E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 07:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0Xq1HuT8UIBhmgXlYQSuZ4IBvn/VU9QWxQa/qUgp5p0pp/j7x9r6hAacvt3hfRVzF1sqNvOfs/DRxr1pmmMsY6TvP6ip92C/wiz9DKCbaw1YmIcQFRpWceU3O12reoCMd0l15mu4VAR3RuFCEDGRBXAlyFAZCePLnjgJhx3jKHhBiWYJr7dghtsJARyqIWobzZKBMc81xgvEp7sTj3ZxyTjEhRGoj+jyZipoq24ne3dfunLQb+s4p5Q+qqtgKwiWU6My8Zs/z1IrEKXVvE71imUFv+PGXJjGi5hsGg9IDP16z8JHLqwrt464fqWUpDCkxGI9zQvi9zne8wB4kudrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Q+Cif0Ckh7520cHjhTA2w1+9xKvi+OESxc+YPZIso=;
 b=dMNJFHyZ+DKRk37bnBJzFlJZ1YGyQtTVh3s1V7bRDUGe23rB9x9kO/osG6zAboFMShKkU+bfghnvEX9HYH0oAMhbqjn2mVT2zkluVNfee8KudBdJWbU7bWb3X9EMdWA/jcV2B312HXBr98IdFlWAMXhPbKNhvnoL4GnQNUkenFW4dXP0oMRyiQdNHocRUda8xCkI5rpVKBJEkxyHGno62ZKfzpIHruIzFJqv7zhkh0Rjz+Y3gcLAnV/pFyhbxXbDWD5UKsqG+bbiRkho+fph+GYQtwtEKnFtjIYcYllxUk7R4by1QsNIi8R6s0tWPvRJfLTVgqE+10bUQ59Nnbc7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Q+Cif0Ckh7520cHjhTA2w1+9xKvi+OESxc+YPZIso=;
 b=JNfottqvddOye+74BwcOUKgiw7HvTG8Jzpcz8w+9/XhH6S2UR3BCkF1fdp01oGfY4ieQTfF+Oy6ZAy7R7BypymAIBZJP41nj+X9U1K+7YfaT1WYMwbA4zO5HuIsckNM3Iewz3XrI1rhK25d/xJOuR5yjRwfAncbGIJdJJ8RDAwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:04:55 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 07:04:54 +0000
Message-ID: <cbc1459a-d710-8690-21a0-1fda894eb656@amd.com>
Date: Wed, 16 Aug 2023 09:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Update ternary operator with max() in
 'amdgpu_fence_wait_polling'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
 <20230816061855.695281-3-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230816061855.695281-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 428b71c2-f6a8-4513-5d1d-08db9e2717cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usVtgOjUdrLYzcAh1RRCaKi2c+lvxrFAkVU4YkgKAE1L4ojXzaGNfoiBMHtIn6ijxyX5JJvIv93T022urXBY8hz+fbI0rLcGcX6x+7WMiqnKBaTIvVX05eMC1/1Gy7ipqo6GNur3aWPUUJgADvKr9mxak7hSUGFctjgyvUKIWuJu0VKjhMlOV57KcQoDbHUkS5eSMrtzpicQjBB2UWd2i837NyNG0/m9wy0uqa8Vqwrr8Vihnp84q2CLrxujPYuC/j3XQCILX/As0+qfWV0zYQ9RrYvXMY3IHBx+cPCZ8H8jpY9x20Yz9kqfryhR7p3UqrIJQg766LJDLBBszHTZkDGjJS4+f15V8p5aDy8IqfyicUOoRk0PnPWr+9BEKeClUDRTxI8e4487TwO2NevpElLcOFgoetdyZ522+OLDO5vSY08iNaQrGjCCehDpsfzNNJXFGVjEIkGJ+JC5Z+1qV3Gn7ehAm9Q3IjGKr25GCGPzNv5SJm9DbmXVb+8RqDAo/INyvsLkcrMcY3rrIYyQWV/0PcMRE6bB8pj6BC1Bk7B1xHmf/DIVoKncVt7dJobupkif+4dfce5nUvUipnqvKZc0K0ueq4WApBWcp1paLaIcwgKw5436MJ8+pjbRIwczNCYjLRjNafkyd/xoYsvlUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(66574015)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVTdjlpd2IvZ1VQZUNvaWJ3RUJjdUpHbGllNi9NUFpmWDFwR1NFbGV6RU45?=
 =?utf-8?B?SXNuSzE4T1l5SUxXdUhDS211bldONEFNeE5waEZoR01GZWpMdHhpL1VxdFM2?=
 =?utf-8?B?d2xmbDQvMWZEUVI0VVBEODU5bFVudmkwMEFtdjBZU29aVnhSVmgySGhHMURj?=
 =?utf-8?B?TlU5YXdBeWRNNG1xcCtVSGpNRHFIRk9sSmxiWHRqMjFwVkFwczVMK0N2c3g4?=
 =?utf-8?B?OFB6MlR0VTFKbXA5RkVFbEM3ZElWY1ZSQVFUNk9TWjQ2Nk93Ymh0UVFGOVdm?=
 =?utf-8?B?cnBxWEJoaVRkUVgwQlJrVk4rNEJkSG9xSDhOdHBxZFpieFhJWTAvWDNHalFG?=
 =?utf-8?B?VUNJUmRjNmw0TjRNbTRjWFZFdzdReE8va0JQUFZOWllYTmFwR09UcGtOVUNh?=
 =?utf-8?B?RkNDZGNWL3U5NEI1ZnlYRkFOSjA0aW9SN211TnJRK0M5VGFreGtrSGVLYWhP?=
 =?utf-8?B?ZFNoRzlUcGlYck1LV3dzN1VJWUwvdFc2QVVQNGVYVm81cWxPd0dKRVk5Wnlp?=
 =?utf-8?B?NzFLK2JyU0JSejNqbnFVeVRDR2QrY3FtaUYwZVhkcXFueVdTUm1uSEtJM1ly?=
 =?utf-8?B?NVU0Y0ZINktZYWZRY1JGaVJmRUdDYWZLTm5vWElVNTIweFR6UC8vaFpIVC9D?=
 =?utf-8?B?MlZXNS8wQUJ4Tklwdlo3elZXZWV5VVJrMnI4NVZRelFaNjB0WmI3dDRCSktz?=
 =?utf-8?B?T2x4alRMRit3SEt1Vzk4ZXd6ZS9JY3ZPRjhXZTdxUU91ZTlkalZ2cW5qeURH?=
 =?utf-8?B?THNDYkNmbDNnRXVpYnQvU21oN1B5cHVNWjYzd0hpYi8yNGMwbnVSYmNwbTF0?=
 =?utf-8?B?R09BUk1JcFlZRHJsVFd3MmRSSW5QVFcrRDBuSitBY1lDbG9sUXI0azloU0tl?=
 =?utf-8?B?VWM5TkcycmduUUh6U1ViSlA2ZXhtNi9YYlNha0xyVFdpdTl1aWJ6cmJxZjFq?=
 =?utf-8?B?akIxZFFUWDBvdGZycmJGTEZpckp3ZktSd3N0ZkpYbzJqcWE0MUhUaUVJYkRH?=
 =?utf-8?B?L3VzK3pNVkJPRWJreWJKUWRxUG9CYnU2QW1LSW56SDQ0MnF0ZEVMNGpNLzFm?=
 =?utf-8?B?Q2RMalBxRkRpSGp1MlNVUCtuQUNuQlg4c3I0NjA1RWtLYjR4VTBpRzdhQ3gv?=
 =?utf-8?B?KzNHLzVjak9Sc1hDejJQSC9TM2VibXY4NmVBWnhGeEVWUFJCc09FbmMrRUJL?=
 =?utf-8?B?N09aS2hUalp4bzE1WGxHbFZBa1IrektvOGkyaEd1aFRUbkYvUTgvY1dFUE5O?=
 =?utf-8?B?aXU0TzBJMkN4dkd2dlFOMVhzb3crSXF6WUUxV2FEZWJ3elJrQ2tOb1R1N2xB?=
 =?utf-8?B?Sm8xWW5PRnA2SUFMaW9uZFQ4ZnBRZ1ZoSFRoYU9Wd2FySG9TSEhaMjhJWmgr?=
 =?utf-8?B?eWhKOVc4ZDBhUXVYZlVDdGNQalZGemlzSXJBbXdibzlqRkVZVDB1b2M2YVR2?=
 =?utf-8?B?YWFuZzQvdXFVc2JwYVJPSm1uL3JJOHZkMXYrNUlWaHVVaWNYZEtjSUFmNHNN?=
 =?utf-8?B?NzA5ZjBjT2srcnV4WWJJM0s3R3BrOWpoOG5SNmpUeDJyQ1ZjVFROSGgzVXF4?=
 =?utf-8?B?MWlIdnZkR1BrdEFPOFRGZTR2c0dTT3NWQm92b2hKdUVOcnAyMEVmSFVIN1NT?=
 =?utf-8?B?S0xrNXJsbDVLaHQrTjhmSXlnanp0MHhPdnFWRW53cktKbDJSM1hIRC9GOHQy?=
 =?utf-8?B?bTdMdS85UTk3cjB4YkUreU1vN1lGSENPTU5COWJDZmJVUStvTi85cVR2NGcw?=
 =?utf-8?B?a3RkY0JheVhvTXRTMG9LT1p1RnZ5bWFnNFg5M3JVZDdZNWNnaW5mWk5wZnZD?=
 =?utf-8?B?L0dGTWtZY0IycnVFSVpIaHZXQUFmdi9pWWk0T0Z4YzVPY1J5WktUQzh2UjR3?=
 =?utf-8?B?N2FML1Q4Y284dWJ4TmliZkFFeWhPbVZOYkxLY3RyVTVqMkpGdXpWYVp4QU9E?=
 =?utf-8?B?NU5lK21nejhzUFpnV2xuUTdHL3N3alI3MnFjWUEzMG1mNlZDRHduUDZ0dUZs?=
 =?utf-8?B?dnFHRUwyWGVTRzAybzc4UDhDczVKVmN3VzB1cmxBUEpjcFlwcjhQMlpMZDh5?=
 =?utf-8?B?TW9BeFlQSTdSVTdSdEpoWmxES0FYd0wrYzhtaHdQTEx0ZllFU3JCOEFUYnhC?=
 =?utf-8?B?dkZITDJKYjM0aHNreXYvQnBzbnFrZWFNdVI3eVJMbHRjbFdHeVBqRXlHRFly?=
 =?utf-8?Q?9SWhRIM+xWoLSmJ1BZ4D2nJT0k914ldWQ5bILttsX+wJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428b71c2-f6a8-4513-5d1d-08db9e2717cf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 07:04:54.6015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmdRRBtiPPmOufbLodo3J3ma4ZfedjkiIO9uAR+fqihvZFn/viV8UdaGiGlT/Gi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
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



Am 16.08.23 um 08:18 schrieb Srinivasan Shanmugam:
> Fixes the following coccicheck:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:384:16-17: WARNING opportunity for max()
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c694b41f6461..cb0cb354208b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -381,7 +381,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>   		udelay(2);
>   		timeout -= 2;
>   	}
> -	return timeout > 0 ? timeout : 0;
> +	return max(timeout, (signed long)0);

This change will trigger a warning that you should use max_t here.

So either use max_t() or make the 0 a 0l (IIRC).

Regards,
Christian.

>   }
>   /**
>    * amdgpu_fence_count_emitted - get the count of emitted fences

