Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57AEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 15:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D34B10E846;
	Tue, 11 Oct 2022 15:21:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A520310E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 15:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH3nPjN4tHGGX5CmpUnRl2TQ21hPTESfF6fJ9YN0kI7/Pm2YrS6YebXUeQmSyedHbFlycEEMh7IfO11D/IkTN5jvtGUpAt+PPT8z+8YbVQxNlm3yp+/SgaGgZg5VJ1jlga7qTZMPuOlTW0ZY8ZkGkwYmt1Pzm3jl+GmCNDULDeke+ULEckYNvqrT27Iw70C++zeRk+BcI2+HaWUBNJFMcl10MNBG5oE8GAi7+dhAV0XGo+Yz26JfBaJS7vS7jhd0cHQTm7R8dE1iI1wuffFjU0jM4HzXd/KO/1lSFQ7DjDiIu5DV+TVgWRS3SQ98ckUitQBQLaYHXnNIK/DSY+ciVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb2SxMAK+KMbBf8DBuoz9BUIVnpyhUNQ4f6A2t1E7v4=;
 b=eHQhvUHMDFt04Sh2Ah0n5zigrsp53cLvcSj7Kuo1lHZCFGoCEIqtJBK6GwkWD31vUKG7CLOek/y4c/5jP+meRt2BL7K0tPNbw7XAqwQH0mA7bIbG5Bhainip+MyaHA7xmua9UioTXV5Oe0tqWRNsHOIY8+dcCLF0C8FFeBh2WUa2gPr5m6PutacCdEgOp1icc+K71COXJbPij23+NAi87PwMUP8CWO2loTx+b4kCWHcdzb48vh3hLJz5lMrDd8+oQJY45N3yqcgLqlAdpmpt+ENo98s/VSug8+ZFaxgqqnHgjDnx65mB6yCc112cGFRuF/Mq1zcPJjQ36dHRI+MjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb2SxMAK+KMbBf8DBuoz9BUIVnpyhUNQ4f6A2t1E7v4=;
 b=GIpk/+0pUCJ6wZuhH/XHdu1zWAFRkcIskUK6fJyFwDVcwspUhwMPFpIgZWvtfeQGo+iBH57qTGnNl2fz4jvI5yBTmVE13WY/3U4uStvqSjdSZUsSPVl6okFHIxcqn5M2Cq0Op0XKa3nWNJC9xE55jLGdzFCGxUaWFl118C39PC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Tue, 11 Oct 2022 15:21:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 15:21:22 +0000
Message-ID: <617e7996-86fa-9d53-ac82-0db7090ad2c0@amd.com>
Date: Tue, 11 Oct 2022 11:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amd/display: fix transfer function passed to
 build_coefficients()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919164334.1579973-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220919164334.1579973-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 330c2c6a-f790-41e8-305e-08daab9c413f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poZ1QdH0bO2dwhe+NU2DBPDFgi2RxQwFd3zbVXmPKDWRJ/z0JTZo8YZjxLu55WuKD2juskpxJUPLUduVJkAoCjC1ew4Wa04IzKdJhqK6uCf7ZF/m6iOgokmsvuzY17gAfNU/59N9hOcfIU845Jn1tO88MBzG8QQEDW1n78srsvLEcBZwt+oUA4xgsuH7q3RgTguftGiAONVy/NeLNZOmbEUNd2ePfEjGWOwLFryuIsLg0fBIUZ6wEYjkwl6OpNlBrh77IPUtbwzug6+Oe8A8GMs5yeaijJQXncB5Za0KeNR3dE78/kFgQccdLBU583LnuuzHKAiVnou5PjwvxzTfIyWpeJVw8pYDUA27dv5cWkE6peIuJn3s43PqY5fRB0buags7CHAyN5K9DN+VKNt69vjdtdBDjV/jqKFFl0S9ezOOh7aMygoLjvYEw4HcdUx6rkaSkdMvaMjSi1dxgWO0ajVFzmMoY3WQfbxZytHoNSFBlpeK0L1rhakzYNa3QiT6BiJxw82aP6X4fD+UUl4+G30JV+cAxWRN/3pXWUiPz9bUjdIlq1bULfIjUCT7sS9MFul4Kgg0lTD2Me60X5Mf/gYPkJJN2CpjsxgOHgFHVvBVakH1NvnuDZpLO2nOciF6ETFmw+HG+ho4TbFXNkCw9EqlK/qeLn3c/yROOHN7kO/p5IPJQ0vsespgBjf7Y+Xw2S8ZHmvENU5Wzkl2qwsQKhoxvxvN8BWZoy1aYzZdfKBKR3YqQsDXLhot+au8W7v6QFz0l5J2PnLI6MRmB8nR+7OSunsZ2hC++aLe5+sq7vY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(38100700002)(86362001)(31696002)(6512007)(6506007)(53546011)(26005)(41300700001)(2616005)(66476007)(66556008)(66946007)(4326008)(8676002)(478600001)(6486002)(316002)(6666004)(54906003)(2906002)(5660300002)(8936002)(186003)(44832011)(83380400001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2c2K3l2MmNNYUR5d3JkMlE4UEcvZ0dYSytjb0tzcG9EZElwTFU1NFQyQlZu?=
 =?utf-8?B?cm5lZVY0NjlqSDdJSHJZRS9FVmhVRVdPUFA4akI5a0cyL1hGendOSXBqSHNx?=
 =?utf-8?B?UG1mWXhKME5zS01laUJwcjBYd2F5NGlZRyt5UHpUajJBOENtKzFReUdhV0Zt?=
 =?utf-8?B?V25tVVd4RGtsNnN0d0FKOTJFOE1kN2ZGT0dXd0hEa1crMVgreWhNRWxkKytJ?=
 =?utf-8?B?dG0rN0ZMN3phcDM5MVhFeFlaWk5aQkFPeVVBcXJnSmZCR3pUU1RvTUNmYWJ2?=
 =?utf-8?B?ZGdKTGhDeUd2ekd6NkVjSzh4NklwMEFzTUg4cXhUa3pEVm05QVhSbG4xSHNZ?=
 =?utf-8?B?QndqMkZ1d1oxZFJkUk5Xa01abGtqSTVzN0w1djFwaSs1OFVheHZnNnNqVDI0?=
 =?utf-8?B?SmhzSlRTY0JQczgxQWdERVhhUFJxNDhvMzdtWlJESFlBSWJjdlEwMXlaZEcv?=
 =?utf-8?B?WGtZWnpQei9sbGoydHBKSDVSVlIzZ0ZWSzlYeUdaN1VSUVh6ZmlRQ3g2OGkw?=
 =?utf-8?B?T2JWOGJOZmlmTk1MRjh3cG1nYkJTNzVPU012ZnlVVWZRUWFMOGhsL1dhZlhD?=
 =?utf-8?B?WG5iSWl1SWJGL0ZmU2s1UDZGWmZoRHFxNDI0QjNBNVNJZDRIaTViK3lJY0Fk?=
 =?utf-8?B?eVpmRlBRTUhJai9SNGFxanVveFAwL0VtUGJ5b2xSWlVRdEtVZzAwN2FSMVhs?=
 =?utf-8?B?aThCZnloZFhoKzhKOSt2alNQR2V0RktjVTdWN2lhMk1vN1dxbHVRdU54RS9v?=
 =?utf-8?B?WUoxYVIyejYrS2pjOCs1YWtDc1ZMYkh5ZnZXU0hzN1ljMlozaDYwQ2tSZk1V?=
 =?utf-8?B?OSsyejVuYkZkREt4aGw5QVJ5aFpZUUFrRVBERDhDa1VqU3RlalZ1eEVXSXhD?=
 =?utf-8?B?M3AyMm16VFhsSmNMTnZ1eUVvWDFIblJuWlZubTIyL3RzVytFSTQxb00zN0h2?=
 =?utf-8?B?VGl3cTc1NnAwU2cxSVZmNVlMb1dzWnQ1dGg5SzJXekFJTmR4R2tQamY1RC93?=
 =?utf-8?B?NmV4MWZwYW5GYkNtUGRhdC9ua3hRN2h3bzNvQm1KRXQwSEZXOUJDK1pUYmw4?=
 =?utf-8?B?Mjg2Q3FOWE1acXZraU9nZEdORm5pSEdaY1V3V3E5RGJzSkVJczMwc0tEejdn?=
 =?utf-8?B?SEtGdjJQcDFHbm1mUFNhV0xiNmIrSWQweU5OaUZ0L3JkT0lWUGc2K2lWSkF0?=
 =?utf-8?B?aWovY3dtU05kL3pGb0pEdjFKRlBudFdUWG9CUlM1WnJET2ptbzRQR09HaDBz?=
 =?utf-8?B?QnA1dlhYMWszQkQ4RlZTbmprc2M5b3o3OE41SUJQeTFrQ1R0eHBmSHZGSFhm?=
 =?utf-8?B?MXpCOUthdzJzWE1PM21zelBlaHZIQUxqRlMzYUhSQnNSbFppNU16WG1UUnlh?=
 =?utf-8?B?azhsbXZXdm9SbVBpRGVpU1BqQ1VuMFFJcVB0VDgrL3daQ0JiS2Q5bGlibFh4?=
 =?utf-8?B?bDNHY1pPVS9FS2VPMzRTdVlYVGRvajhZR3d6b2JIMG5hRC9NSVJYeVpvVk5a?=
 =?utf-8?B?TkdLQjUrTGN5MmJHU3BHWkFVRTJyN3VtbnRESjRrOTJ5aXJMZUZLUlZhNnE5?=
 =?utf-8?B?aWtFRE9vdkU0ZXRqOXJnNXVqUGkra2lDK01sOUJzSzk1cEF2M3dxaVdvcW95?=
 =?utf-8?B?VHNUU1graGJCWlhzWjcxV1V0UGZJRStLc0lTb0JXSncvWnRuYjVoS1k0SWRY?=
 =?utf-8?B?eEYvVTlBVkQrUU9YL284TGtkQ1lkL0c1TWZZSWN1OTU4ZHJUNnpYV0dtRS9K?=
 =?utf-8?B?aFJVU2NtV1p2dWx4em5tcU9HcXd3cytzSGRHNEFUbFJLTmpkaGErNlZHTmdJ?=
 =?utf-8?B?VjI4RlUrVG5EM2s2K244YWhOYUllVEZYR3VrVzV4V1lUbjkwK0dJbWc2YkZN?=
 =?utf-8?B?TUZ4aWtaTTZ6bjB2MklnTFNIeFBET2tDemhDdzE4S1h0bjRBYkFibm9YMGZR?=
 =?utf-8?B?YzFMR1JtZkFML1NsazlpYUhHd01za1YrK0paakNDNDNITEF0ajQySnFtTUph?=
 =?utf-8?B?ZDArK3laMUluZ21JUFVVZHhvdlozWjY2L25kaHJNb29FbyttSUsxRnhiTE5z?=
 =?utf-8?B?S01teWpURUlQenBGVmlacHZ0YWFXYXRJdVpVTXZ3ZVQyZG5XVjlwSUZFZGxT?=
 =?utf-8?Q?xrSKvTmVIdQd9QgI0SrysNhJ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330c2c6a-f790-41e8-305e-08daab9c413f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:21:22.6910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcYPQM8EECCCGMctVO9t9Ch9ZTkTZS3KGC/4+W/3KXBnLSqIpwjPzZslp0XMZwXWyvRaVhQuxZsf6DUaGDfsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Zeng Heng <zengheng4@huawei.com>,
 Jaehyun Chung <jaehyun.chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-19 12:43, Alex Deucher wrote:
> The default argument should be enum TRANSFER_FUNCTION_SRGB rather than
> the current boolean value which improperly maps to
> TRANSFER_FUNCTION_BT709.
> 
> Commit 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
> looks to have improperly reverted
> commit d02097095916 ("drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF is BT709")
> replacing the enum value with a boolean value.
> 
> Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
> Cc: Jaehyun Chung <jaehyun.chung@amd.com>
> Cc: Zeng Heng <zengheng4@huawei.com>
> Fixes: 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 04f7656906ca..447a0ec9cbe2 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1692,7 +1692,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
>  	struct pwl_float_data_ex *rgb = rgb_regamma;
>  	const struct hw_x_point *coord_x = coordinates_x;
>  
> -	build_coefficients(&coeff, true);
> +	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
>  
>  	i = 0;
>  	while (i != hw_points_num + 1) {

