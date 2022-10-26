Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852FCC38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 18:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95A710E6BA;
	Wed, 26 Oct 2022 18:04:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A66410E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 18:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzqNHWE5waZp7hyWEoNU1NpwWILayfap7jMck04NXXVIH8H+pAt8R7mNwt3lVBjtlD8D1fbSydNnlelrO1exp+kVh/MN4UB/ApmYbVcY6JvX0A5F2ZCm7U+ig/aRHd6DZhvo4cVYp+c2r20kC89w+BNMgN9J3NjrFL0ymREmbEBnlmWt/PPvhqbfXSgPXX2nF7afsXuIqnD2ilQWY3KLLG/k3t+OWTm/ZwpUIPDHx01BH42GxFwQOgli8olkkol50gLLr6fZ5+bNj8RdwSey2FNPuNVnMvSVZWiPiVkQDJNbz6xMqFPiRwssj74N3ZYSvJBgj2SwwY/E2g6sfF1q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVykG0tr1W9yhjE7+4DTgsjCmdkXQkY6rJl3S+Bm1N0=;
 b=gKw3s2BhAkBpyMCSnVJCBe+HbHqpim+Qtxa/AHpHuV8V4O6IstHTNDpbd3Jtr185loBVHGu1XkMiU0XfBBMgasbAhHMxXlDXOStMH820HIl3zDpnNGT8qvfDkCmTAXbHciOYZCZIH+kUaCJ3/K7PPg53vVNCyGGsFPPuST1BO5wPdWdHeN57nV/KQJfewPRqJCgol+Hk92ZlRajAhthAWacclZ2XgysndzfegY+f1FQLJ9S4h/zvVICxqLK+D81CCJiV4hDCdnXvisxfz9ETpX0A0Mmxw/QSTwDIDSSQT6jZjQp3kTY7qusni1Vz3tEe4cOZovhsf+4wM6QOJjMtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVykG0tr1W9yhjE7+4DTgsjCmdkXQkY6rJl3S+Bm1N0=;
 b=rtq7qYK2uf3TkyhgD/i48qf/Is5i2ecylB1lMWApv/tIaYXxuPW2qaz66F8oWt7ou2HTqx5UxTw44rnGYrD1X1/ZhblkcVUTYE4GFzJZ6QRSEqNVD+BTQOC5+WU2Pqj2PSBHVz62rjZ9G5lKauBtYeaLdYi/b1gD3bcGiIF8tRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 26 Oct
 2022 18:04:10 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 18:04:10 +0000
Message-ID: <34301b46-b222-14a6-dba2-4b47cfed7398@amd.com>
Date: Wed, 26 Oct 2022 14:04:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH] drm/amd/display: prevent memory leak
To: gehao618@163.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, alex.hung@amd.com, HaoPing.Liu@amd.com,
 aurabindo.pillai@amd.com, amd-gfx@lists.freedesktop.org
References: <20221026100105.52156-1-gehao618@163.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221026100105.52156-1-gehao618@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe94d74-eea6-4c27-a0f7-08dab77c7b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4p9eMnAhK7eIpj3x3O9eeNeZE9ZGou/QXLlRJjHnfOfHoYE3eHiPQCQSyjNIgBt0mhcpSUUEIIRrf/J6R+8A8AcBq+hOoz/KkYYAddGJY7jIXQVJZ/ojf7gRfYW2TcAeoGk3WbTlTmeiBTwMVLknYLlOp0j2maawMuBvgd8Kn7fCa8DTdYW6HEBfi+VnLFV3gSA+yu5VoykphpvGrufHuym//dTePoA7+MJVklyynteEDnXFc373/WRN5jHl5X1YW9deo4YBCIVasHQKzWvCflYQJ0ZiXX3MV37fkqvJ1JtAsTdQpG/LQkb72KozTMyOyA3GKcjsOTfNv3hPEJapVQhDfzRJgwr7BVNvg/DrnplAtxzEz2dwOEznZ/JlItiTIm8SNxD2V9Efx77Ka8BNbalQsy5VKS2KtJDz3q5rLznkekyVihMjIkIVRpUbhOFIpLvo7CNpU5A6HcfkDOZOWRFF6J8woK0PYuaqkpFClqrzek1wvaCTQCsv2h5jM9Du80hF522BD8dQE2/jStKDrtXxrwNyP6TFtqsoNuld+sB5pgJTpGIB+7c2+MdNhBO5pLfKTG1AeBc14ySwsUIJw7+V0A3b1iMzl3pWYeFuwM8WA9c/cFO6nsuyy40zopg6sLT/Rba/QWljAcH6dt9lx8LsU/5bFcW7UWvurJHLJcnhxikEfniL/6VoBN+OvYXPERRwOdDA6bHLtdM/t13WQF0mWEsBMwY7UgVQAC0a2FanY4ZsrFvjqGQlv63wGl+X/P/KI9rpi+ILA8qkh9Y//C9xZkzzFl1P1LR/8VViBgupzYF5XEcAK11MivhzQ1dG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(66946007)(31686004)(66476007)(66556008)(38100700002)(6512007)(316002)(6506007)(2616005)(8676002)(31696002)(921005)(86362001)(36756003)(478600001)(53546011)(6666004)(186003)(4326008)(6486002)(8936002)(2906002)(5660300002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BUSVRIMGI4cWpCMnRSa1VjZWUwa3RKaXBSelJneEVhMUMwUEVIb0JKaCtv?=
 =?utf-8?B?cGNLcktianJDMGFmWHp6Ulc4NHcwejJnL1oySVRNamFvM2VLR2phaW9TN0lj?=
 =?utf-8?B?K1NnQnl4d0ZHNy9nVUpnVEZ3azE3Nk1rR0U3bFhac2pNT0xmeVZhUmRUeEdP?=
 =?utf-8?B?QXN5SXdianhPSmthRksxMXlQdnVZQ3JuZytWL3ByOGFnOHd5aVZZaXVXYlFY?=
 =?utf-8?B?ejR3am9VaHQ4R0hWRXBLbVBCMWI3RFZvT0tjWGxtWGZIVjhiemtJejEyUm5k?=
 =?utf-8?B?aU9KT1h4WXg1T29NbHN5R3V2RVR4WWMyZ3dBS0w0cjlEYjU5bWx5NjlTamxX?=
 =?utf-8?B?ZWRnSWZVc0JtRW1oZ250dW9HYllvVGhCbzBLMWUyLzV4dDJrZ1BkSnNSWW9O?=
 =?utf-8?B?ZjVyanZxUEFZV3owT0FydW90T2I3ZFZ2Vzh6K21yNTQxRnhkaDlEQVptWkNZ?=
 =?utf-8?B?UHpGMjRUSVhnTVlEU1lnYStObUlZb0ljN0h6WUJqdkdYVWIzcHBFUnlZWkMz?=
 =?utf-8?B?dDVHYmZURTNLeUl3Q0hzd3hjVWJjRjhLRFd6UCtyOWhCcVh2K2t5aWVCYXhU?=
 =?utf-8?B?VG1iUkdybjl3K2hPcWpMZ2ZxZnc2NUFzRGxHWWNJS1dnZFUvRFlWR1gweTg1?=
 =?utf-8?B?NEJGVWVoRnlBeUJTZGpRZXUyT3VnS2xBSXB3MjBqek51c0ZyTVQ1STl1b3hC?=
 =?utf-8?B?VDgxWmM0RHI0OFBXc0tyRkpKRytVWm5BVmxma3hjYjVwR3FzZ0x2V01aZzJ0?=
 =?utf-8?B?YUU0TVdDcU9SYklxcTZ1aEd0VXJvbGFiQzVnV1pxVWdaYWYyelBuSjM5UDhV?=
 =?utf-8?B?OGVhOXVsVGxqTDQ2S2FJUDJtZWxqSktvVXNYNlovek1kamZnc2Z6aFFyZVhC?=
 =?utf-8?B?aUtna0kxeGR4ZmlNSkpheXN6Ym13NUJ3eHN6bW94R1dPaFprY1FETnd2a04z?=
 =?utf-8?B?ZTRvYzd1U1hESUJ4NVZhMm92RThPTXZKcUkzZkFiYmdTenZyb015dGVlMDJ0?=
 =?utf-8?B?b2svSWdidWVraGZjSG5Dcng0aW1DdWlia1NVWk1CSzd6NFZmWll5aGQ1RklF?=
 =?utf-8?B?NXZWYktYeEkyTWk4NWd5cVhOYzFQT1ZGNWZ2TDhxMVNBMk9hcVdFcGw1NmNS?=
 =?utf-8?B?WFpETWNkbWQ0UmNLd3FENE4ySHpCY1pDTVBOUm5TdlNhb3h6Qm9qd09ITnRs?=
 =?utf-8?B?M1RIbjNRUXpGdlByN2pMcGh2M0h4UmpSZUhXdkZNTlJLTmN6cnNNUnBua3d6?=
 =?utf-8?B?RlBybEN3eEpTRHdJalpuMHBTWG1OUlhaNEx5RFo1L2hUME5yMDRsOFc0RGZV?=
 =?utf-8?B?dUxFcC9uNWFWMWZMQkFMTWNmOUZySVVKL2wvd21VN2FXbDQrUHBMc1Z4VytU?=
 =?utf-8?B?OEVBSmZFcS9MN2pwTUl4RllHNk5vK2lwUnMrVWpuUnVYYzhvWDdwUjJVNy9k?=
 =?utf-8?B?aGd3NnRYM09XMjBsM25ENlZ1Z2VNZTFoUHNxVUl5LzI5WSs1UXQyWDEzaDJ3?=
 =?utf-8?B?alB1cWhNZFR5OHNpT043a09Dd09Bdmlnb1RVTy90NW9EYUcxRldESFMrZlZh?=
 =?utf-8?B?anBtdEZMbjNFbzVITlQ2ZkpiMytpYXpkSWZ6NDBXT2lZS01jdUQ2SC9pRDZj?=
 =?utf-8?B?SGx0ZWViNHNpcHdSZCtIZm1wbUcxZ09GOTR1WlJhWnppZ2tnMUx1NHVJcXlr?=
 =?utf-8?B?ZXB2MFRHU3FSY2lyaUZaN3RLTFZQcklGMGM1SUkzd3h3ZXU4MjVCNlF6MnhU?=
 =?utf-8?B?MmtWWkNWdFRWOG1FVlFrQ2E5SDA0Z0daWklKU0c5SjlvVDhsRmFlNDhReDFL?=
 =?utf-8?B?SmdOMFU1YnpOWlMzNFNuVmV0ZDdXQUZ1dU5IM1VxZzF5aHFMY0tXV0dXcDQw?=
 =?utf-8?B?RC9ZQTljZHNtbHhVMEoxN2t4cmxPRGlZcmdRSWNVcU9vSEhsNnU2UWswM0J2?=
 =?utf-8?B?TkRFM2NiZFREcHlIaWEyNnlsc0I4RlRNdmtqZ1JQUEdRK0FHemQ5L1F4SVhs?=
 =?utf-8?B?OXZqVTJ6amtvUzdTL0Z2NmpIVmtjOHVueW4rcjY2VEdON0g2TXBHa3haS1Rl?=
 =?utf-8?B?ZmF1bUYvbWVBNlptQWU0VFBiRy8zYm9EYzBid0taVHA0QjFUSkRqdE16YUd3?=
 =?utf-8?B?Z3F0d1IvTlJpaTJqc3ZSRk9JTUprUjREdmQwcnRFRXFiZWdrcllPZGIxKzRF?=
 =?utf-8?Q?IzM4dIcBhg+z+dAtWIBXw3Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe94d74-eea6-4c27-a0f7-08dab77c7b7d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 18:04:10.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVlBSrv0oDAvUDHKyE8mB0McXi2FplbNUPf/bapHHRiP1A7fd2Jn79zWiGL1yn5CGWKNE3mevCwTDb1DQM/y2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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
Cc: gehao <gehao@kylinos.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/26/22 06:01, gehao618@163.com wrote:
> From: gehao <gehao@kylinos.cn>
> 
> In dce6(0,1,4)_create_resource_pool and dce8(0,1)_create_resource_pool
> the allocated memory should be released if construct pool fails.
> 
> Signed-off-by: gehao <gehao@kylinos.cn>
> ---
>   drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 3 +++
>   drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> index fc6aa098bda0..8db9f7514466 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> @@ -1128,6 +1128,7 @@ struct resource_pool *dce60_create_resource_pool(
>   	if (dce60_construct(num_virtual_links, dc, pool))
>   		return &pool->base;
>   
> +	kfree(pool);
>   	BREAK_TO_DEBUGGER();
>   	return NULL;
>   }
> @@ -1325,6 +1326,7 @@ struct resource_pool *dce61_create_resource_pool(
>   	if (dce61_construct(num_virtual_links, dc, pool))
>   		return &pool->base;
>   
> +	kfree(pool);
>   	BREAK_TO_DEBUGGER();
>   	return NULL;
>   }
> @@ -1518,6 +1520,7 @@ struct resource_pool *dce64_create_resource_pool(
>   	if (dce64_construct(num_virtual_links, dc, pool))
>   		return &pool->base;
>   
> +	kfree(pool);
>   	BREAK_TO_DEBUGGER();
>   	return NULL;
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index b28025960050..5825e6f412bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -1137,6 +1137,7 @@ struct resource_pool *dce80_create_resource_pool(
>   	if (dce80_construct(num_virtual_links, dc, pool))
>   		return &pool->base;
>   
> +	kfree(pool);
>   	BREAK_TO_DEBUGGER();
>   	return NULL;
>   }
> @@ -1336,6 +1337,7 @@ struct resource_pool *dce81_create_resource_pool(
>   	if (dce81_construct(num_virtual_links, dc, pool))
>   		return &pool->base;
>   
> +	kfree(pool);
>   	BREAK_TO_DEBUGGER();
>   	return NULL;
>   }

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Applied to amd-staging-drm-next.

Thanks
Siqueira
