Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F8C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 17:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3824110E606;
	Fri, 16 Dec 2022 17:12:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC8810E602
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 17:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx52mzI7fNZXJZlBSvTQknQZ9dhjbAMtw4LdCNzhdt7FJcVRDP7Bqo3eMWGid4eTR0fmYeiY9kkX3x7bvz+CyJtMDtWHC++ipCL/gDSUHY/S/W+jPjOkr5cYcn85uLuDcKgfxYE/8M3X8v4Ykv/fmuuH8uMhX7sJkNB/oQ54PMhYKK4eOAlARZuFRuYieoII0c0DSmXbHlzKBtYD8WZa9+Wa/53d2UeuazDXSW74nKXFpjagTIP4xJkxDLuzM5F0xIXuwykNb/jlsAMKlji3REV1Nxh13qcGQ+hkCm2nGBaIiRVbdXp7Oakg/5ff+klZPjXDY+bSC3h7ZDNq+kByew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sew1cvWr0lTY/yjwjN3KRanLFA/euyC+VWVtBMYymDM=;
 b=njjvVmg5sM0BjEMDwPVQ18jHK4siBUQ7wDbKYt+xCBH9SjVK7HcP1xM54JCDrtP7L2G4BIVwJjmZuPl++YO6nFK0s8hHW0QoshXPnV5bBVxLy4U/9WhDW/rIRqjXLO33djpYEcefWywizcU+Io+rrZtoeiyQscZfQx+GtIA7lg+/2NK0z0hSTLgjBHZ9iuiVCow/54Lwhg1rzIoZoqbFxgalJLN6HDN2pbdIzGOyVq0Tr1GU1t1BiEBWrATcExGNce6sZYe4NFGexhF3d0pdJEGNkF4TS5y3vlG6IFpdFuuQXJXKfRl0EW7Du44zfDXge6EL9pJvc7YZNUmoScj4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sew1cvWr0lTY/yjwjN3KRanLFA/euyC+VWVtBMYymDM=;
 b=ozz2TfJxmLAAwaLwaX3CzIFV+8UY8jl3YfpB2EbPoiQTxykxtgppVJbQYzpX8tF7i59S0IuFKnP4e7e7084qh3ZtB3Cp1ITGXrh7tM98jMxZFrtQ8eRX5oxYo60efHOvudvjaoQVFyovmN+V8Ei7NwbPgxZEhaZ7aHx5P1+bdbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 17:12:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 17:12:01 +0000
Message-ID: <5e9376e1-7605-c165-9d0d-79d6879f3974@amd.com>
Date: Fri, 16 Dec 2022 11:11:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: drm/amdgpu: skip MES for S0ix as well since it's part of GFX
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Huang, Tim" <Tim.Huang@amd.com>
References: <20221216164430.42642-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221216164430.42642-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3a8487-897c-4141-322c-08dadf88a544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piHB0mQ4NnCubslFVSqLtiqieLLwRApoENadTvBtApQNEKvETO0dRH7IpUd1RBkx5dEWIyzTCqxgVWu4HNucc379kesCWqSy/qzTLqcv2WFxQh/elTncbPiMJHLRLpVnUMba80ZDczKnmaN/Y6eKiF9kxK7F7nHbd0XFiWW/rPEP8I4xD4vBds1tP39LjFUwWFYd/LrHsJW9ED0iD0L+RQnNNHjy62+uvMxvUISSM6dpFvxXAePltxBIHD7JAnt339b6BzPrIWCmn3u9TvssdWg0X9lIAWUwZMMzJw0ldQxXyU+nBjh/9BGcQYOH+snpYdXgkcHOOUCzTTxQJLQcGZU2tyoj6bVwHnV1GiIX/ywUfW5rItcxR0EqTNWo6+1DrDM8BUJOJ9IVWpGyh/fRfmEE83Gl9QnTjPtsk/nVVZkj4l6MM5EIaHMziY3Y0tpP581Sfkit4thAuJyYIVRuoFUes6pmE3ei8Ln2WNg3YwBbCf+CylpXEWl5eCiFX5JQ7LxyYNSzYNf5nknPWjgZzoCu4jFuxaGUQWSdA1s9lEuh2U7XgSWtIBnTFgMvV1mPpDXPopB5XWu5bhFimGENZbjJM3loxl0RQkmANu8LWyZyz/N8kdzgJkIm6Q87sVPJmrBwqbYI5YKbla75dC+0BSxUQ2W+muKcKtOQ0VUfpQM86O0R47Si9JnhR7hAL1ph+ECNo2xViylWXJ+NdQvnY8t6J+dNulZR398qU765xKHboR4L11RZzJugFDOtGjR5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(36756003)(41300700001)(2616005)(66946007)(66556008)(8676002)(8936002)(5660300002)(83380400001)(478600001)(53546011)(6506007)(6486002)(6666004)(110136005)(66476007)(6636002)(316002)(6512007)(186003)(26005)(31696002)(86362001)(2906002)(38100700002)(31686004)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxLWjl6aVFaSGtjY3g4emI4aW5zV1ZST216eG1YVWI2aEl4dVhyRzFyK1Nt?=
 =?utf-8?B?NVpXcGx1aHZVTi9EMk9Ta1JGTURpWC9DMFNkeHFKTWc0cDJKNGtWdWZ5VkhO?=
 =?utf-8?B?aHBxSWUySFNqU0l0cnJHc0JyekNuWGR4a01GK2Y2VnZycjY5OGVwTkYzb2hU?=
 =?utf-8?B?MjlvRWFVQWpYUkl6cXQ3VFdtRkJRWENqNExZMWZ0V0hhVWFLcldoUjVlY3N2?=
 =?utf-8?B?dlRES1FMYnZGU3lmVEZBcUVaL3pONnkybnJ0aldrQ3RybFlHMHdYcEFjQzB2?=
 =?utf-8?B?UU5SbFFZWjE4a2tuUks4U0dGVFpVV1IzcXVXWHFDZ0dnR1lMZWZZZ1cyaGV5?=
 =?utf-8?B?N2xtMlJoTzJMWlRvVUVBTWFObDFrZkxnY0ltMDVEbklFWkFZYm9BaklIUTRY?=
 =?utf-8?B?M3ZuN3JveFJiRmtLb3ByNDhIWndrSm9IaWdWZkd5UWhMbVhCNkwwTENwdi82?=
 =?utf-8?B?MVZQOStVNDZWNTVuZE00SWZPOFh3Umh6N0pibU9CZXBmUTJZS3ZJM0Z2NCtW?=
 =?utf-8?B?WjEwck4yVm4xcTVUSEdnL3pZWEk2OW1wVGJUYnloQ0loSUxUaDFhc3BXWklK?=
 =?utf-8?B?NldIQnVvYmNEaWZhMUhsR0dEdTdGa1NOWHByUSsxeGxzMzVHVk4ycHdXNE9K?=
 =?utf-8?B?dnRMRnVjeFh4aFlQL2RPVmw3ZGdJQk84M2VNaTd5TW1OQ2dlYm44UXdJMS9J?=
 =?utf-8?B?aVhNQURrc0IzZGYwcGtITStrdkZyeE5RdDAvR3dJaTZ4L2FmVDNlVkZlY3dQ?=
 =?utf-8?B?Z2RLYVZKME9YbWhUQVdvQWtGMkNXeGhVSjR0MGxDdHoyczJrUnZrUjJOR2NS?=
 =?utf-8?B?WE0vWkFXV2E1ZjFJOTlJYXBxQTNjcXVScmNUQy9jWk9nVENkZGVUNUJjVzlx?=
 =?utf-8?B?WUNlUTJLSzdjTGdSV3g0THppZ3paK2tteUYvYXNudzN0Ky9xNFhkU3A2bW5w?=
 =?utf-8?B?YVZ2cjBjK2dvdE9jK2NvY0pkOFhXVmlVT3JMcVFrajZjbU5IRG9YQUx5dWtr?=
 =?utf-8?B?TjhrNmo5L2VlbWc0V1VlYUNGQ2VGS1VxTmdWU1JXS290RnlHdW95SVVSbERO?=
 =?utf-8?B?Wml3NlMwWWxCcDNEWldlb0xMbUFkZzJDSjk2NzRkSFRlOUk5eG9qekFvamYw?=
 =?utf-8?B?TXg4MldVWmJFMkhnMnBieVlQclArRUhacmoyTStsMnM5YyttSUsvUWxjTVAw?=
 =?utf-8?B?WHBsMTBJMEJKOEY1cXFWNlhJYk40MUxGc1k0c3hNazNFc2lBemdmQmxIY21I?=
 =?utf-8?B?ZkVSb2MxQzJKRG4xZnUwVGVuMHI0ZloyOE9LZStDVzUrVlZEclNxSzZqb2s4?=
 =?utf-8?B?Y1AvZFdXVjZkOXVtdjRmbklMYStYaEdhTzIreE1Tbzkxd3RCUnVOdWN2ZUNj?=
 =?utf-8?B?V3NMVStCcEJPbldpY3dlV2JMYWJkaHFSUW5oUHBhMm9vY2VOUWREOWlDY05j?=
 =?utf-8?B?bDdMTWxjanpXSkpNWGVzUWgrM1V1dDZUQklSdXJLWnptUDBVWGtvWnlTQ2pa?=
 =?utf-8?B?SEUyODhIWkFPcXhWUU5XbjJMQTdlRHk0ZzZhL29yWE5sVFlScWh5dElYM1Yr?=
 =?utf-8?B?K0ZWbmZaeWo1ejF3clRxRFprS01PV0czL1NSNXlvTTNqVWJSVE1YcnpISHN6?=
 =?utf-8?B?YXhqYXZqb2lCZEd2NjNjZkh1YUd1TzRDa2ZPVUVObUxxVnJXT21sNFJ6Y0Zh?=
 =?utf-8?B?TTRrY0doQzNpTjZJVmRUZk1aekZIamRIM2ZpeCtHenExUEJxOVFYejRMVTNn?=
 =?utf-8?B?ZCtOOFFJQXRrMjhIbWpxaTlaZHFPcG1PMlVtaGJscE9tM05wQXhweG9kRzdy?=
 =?utf-8?B?SXZ0ODdxaThtdFpJVnN4RHY3eGVwY2NwV3dzZ2x4Wmg3b0ZQMjVkWEwxblJh?=
 =?utf-8?B?Mng3bUR5YTRMa3ZUQWREeGJoaHNLYWxOMDZlTVhkSHE2NkNwbGJZcE9SRGZI?=
 =?utf-8?B?RjBlMFJTR09aS0E1UGNoSXJMbzM2Q2RLeTJIdWFoVXMwT04zMzUwN0kxczhV?=
 =?utf-8?B?a1doQzZjUnRBdHJlYWJ5UGJMT2ZaY3Zlc3Q1aC9GaDM3YVJRWlFDM0ZndlNq?=
 =?utf-8?B?bVhmWk5LT0h4SFFiV3d6NEZCY0gxTENIS3R0dHAzeFp1dlUzc0p2QnkvQVZp?=
 =?utf-8?Q?NyMXaGoOJVb1fnZw3SkPhHsWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3a8487-897c-4141-322c-08dadf88a544
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 17:12:00.9946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeGoJplNlGS/rw/UfGh+ZEPaxhy8JeVQHSYrQwpgwjTB9AM7GTvpS1PWthY5G8mDS0RP22GhujwwZcD+sGY7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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

On 12/16/2022 10:44, Alex Deucher wrote:
> It's also part of gfxoff.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Even without the other series this alone has been shown
to improve things for the affected ASIC, so it should
probably go to stable.

Cc: stable@vger.kernel.org # 6.0, 6.1

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 582a80a9850e..e4609b8d574c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3018,14 +3018,15 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			continue;
>   		}
>   
> -		/* skip suspend of gfx and psp for S0ix
> +		/* skip suspend of gfx/mes and psp for S0ix
>   		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
>   		 * like at runtime. PSP is also part of the always on hardware
>   		 * so no need to suspend it.
>   		 */
>   		if (adev->in_s0ix &&
>   		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
> -		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
> +		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
> +		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_MES))
>   			continue;
>   
>   		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */

