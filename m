Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87750C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 17:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1388510E529;
	Mon, 17 Apr 2023 17:14:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C8010E529
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 17:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX9HGuGN8EeemeVxS51uOquEMfzXRcWcnM4fldH5ovwe69PqcfVe9yAEdcaACjhPudUk9YvRNspN9fir6JZSgoShmlb3DNEGZVl9P8e9PepJ4BTeGbPE7sFmdqhF0V6Z6hRzxXCq3HXF7y8pkib5uBdjBg5EsTPmj5ZZRZ2+CMb10jRsFmDvhFVUhLPIQEi+wBuJokVFNrZCpVJDWvb0uOfMWrkQdZRFS/4P52fy/Nh9UBjOZOnQ6XKBqpf3SYgrT/WzPdsEHQDjw30DBgc7yUhnGDds49prCsRzeyyyfQ3+dWa9w3gA4SRLxtVn19z4219nqe6KidzeuXNnmOSoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfubXil4PhStJZxAb7G/7sEgxExiyORBhI1MtlAzG1I=;
 b=YKVbRkX7BQtAzA9HVh1m3uqKc1Ef1KKmgIFL0S0U9zvOV6D0G2xlBmjVB2GXuiDCVcZGrsiD7sZS5QbgFROM8gmuj0jYbfWolSCOPDIgGRPMRO0Q7x25mCSCs2c9fVJPrJ+meqeTrU8X6hzzrkvJwEHY/Nox8V37JvOKlHBumdOOIFucB3laoYgIFtmT3nZ7Ped/Hr56lrgVS7E6VkshdXhvlNlHRfvcMrmauVVLSq0xoDyEiXEv3yab9FDD8haxAO3D65gpI7IvOLwBr0o/dHmQOsB+T3/caVdE6Lha0DpbCJXYHTAQKjzgmDz1jyoVRy5ZXkce4Ruki9JU1e1S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfubXil4PhStJZxAb7G/7sEgxExiyORBhI1MtlAzG1I=;
 b=EbNcPiNrnHfxe+xryefN4a6MyPQopgM5yklYAJrJv3tDEHeA2z4HAcBZyepxm4tdFVDxz6EwoJ4EAzZRdEm2256TgfrmNTy2dj2wGzAPy0gZUys1NWwsFtEsL61dSDTxpkuVFDfQXBXg9zuodaus43pNb6LsuES8yF/U2n+P3f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Mon, 17 Apr
 2023 17:14:51 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 17:14:51 +0000
Message-ID: <3ec3a183-979e-5fa1-7431-4edba05ff8f1@amd.com>
Date: Mon, 17 Apr 2023 13:14:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amd/display: Unconditionally print when DP sink power
 state fails
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230417170844.3836427-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230417170844.3836427-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0381.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::14) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d357af8-3320-4549-71ae-08db3f67417f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXkx1qqQpu22NnuGh8ty/qP+W9wSLOXkpeLBgflGziEkGFIKFk9EPj3gYnLdOiPhJquJh0ox783rhP3aTgFh5EyFgFEqxsOITmonBclTKMATSrNSgkcCgL/ydNCkQUsKGyzz110ThoL0zd0JFbzRrohnJru7exVPgreULTUsTYM7nGBGvvJb7buS3TVnsiXHOW+J6OmR62GtrjjsWFccCWG7cMu/g+9O7YVx6OsmQ5MO+e8yrMq6t/D/vlmrAvdKSX/7awK/Bq+ZcAwacHtpCGGh5zqJQPz2eYG62K/5qgPZ9r/FIx/v+VQffSCvG1Y9HVM53uH81eIiffzEwLQobjJE3gatmmDbpAGhh6xPWJAW68pvgmvOy+RuZ1A+MaYBK63CxvQmS8tumT7DsbynyMkqtzPbYJkLtyJ8p1TSATBGqIm9OGTS5BhQ0QbSMNQ4ZzAf5Df7LxypuTFvlaMzVwueCfnS+TJKQBO0ylr7XTxB0azDy/fDdlaYDs1pXSKZTLRpZOOW/Rw7tbEcdSRxrTmcoUwyUVVOe2xD3eeINFEanyJBR0P3OlziazBZjXnXqxuKjA+Du1unEhcLmgjudUXRvbtL2D5nDV2UTrfzZAbQ27nGxYuLH3yIPOjO9AUqBKW5wgCNGfepXHVr1K8mgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(53546011)(36756003)(66556008)(66476007)(4326008)(316002)(66946007)(6636002)(110136005)(6486002)(478600001)(8936002)(5660300002)(41300700001)(8676002)(86362001)(44832011)(2906002)(6506007)(186003)(26005)(6512007)(38100700002)(83380400001)(2616005)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFOWXROdWpuSS94NWtXYUIxVGM5aklwc0NLZVhsd2o0cDFjQi96UnJxZXEz?=
 =?utf-8?B?OXRla1AzOW1EUk4vOVlteFlmaisxNEZNdU94TnA1c2xoSXNyUTdjcG5CZE04?=
 =?utf-8?B?SzZsd0xwTENWUHM5SklsRWVJSzlNWDcwdlBwR2Z3N2M2WTVUZEw5NExxbitD?=
 =?utf-8?B?YXhuZG9EZ1JpaVhFUFFUWVU1WmdOTlhJSklGbjN0L05KY2xaOWl6Y3JCaDQ4?=
 =?utf-8?B?eFhQcmhmRkhYWHZINGM4QlYxSEY4V3NzejRRb1ljQmFHRmlPU1NiWFZjN29i?=
 =?utf-8?B?bCtqQlhTSVZGOGVDM2czeXQvUzZnR1oyN0lRdmNOZmp4T0pDZ05EKzNhNm9a?=
 =?utf-8?B?NVNObDg5dk8zdVU4bTRzenFaK3dJNTN3VGJxQlRZVVVUamlZV2NBOGg4aExE?=
 =?utf-8?B?b1lDVk9LbkZHT0xOclV1L1Ezc1MvTHU1cXIxOTRRMXpRREtzV0JTbWdCQy8x?=
 =?utf-8?B?SkJhSVpxOEtBcWRrRHhjbVpBci9nOTVZSTF0amMwc09QbkFDOGNVOTk5Zjcw?=
 =?utf-8?B?MjAwRmZGaXVaY0xraFdFQ2NJSG5ZbTY3S3RmdithV080TWp6OSs2NGRHdjhI?=
 =?utf-8?B?Wm5TYURoQU9xcTk5blUvS25Dd2x2NkpvM05yQjJPbllmTk1FdUEvcllMS3Y5?=
 =?utf-8?B?eHg1dVRvYjRVdGFWWDhwWWNwamJmWVhnSHFvbW1RV2E2Q1pBVzY2Y3drUWJu?=
 =?utf-8?B?U1pJc1JQa1RoUEF5MjZ0N0ZUbllpZmE2cFFRRUxaOEpoVzhWeUE3bTc5dWdv?=
 =?utf-8?B?MVFoN1ZpZDBRYjBwMXF0cVBSTUZNTUt0b2orQ2djM3pnaHVOSWgycXo5d3U2?=
 =?utf-8?B?RW4zNVpYQXpiS2cwKzNlNDdwSnJrLzUvOTdBQnlIa2lUVWR6OUxndGRTRFFq?=
 =?utf-8?B?VUl6WTk5aGMvSkNLM3J6RHd1eE1reU1CQWx0b0FaWEJ6N09hYVQ1cHJFUWh3?=
 =?utf-8?B?SVJiNnRhRURYZFhPOVdyajRpUVRIMjcwb3psS1UrclRHZENsem5pT0JBK2ZJ?=
 =?utf-8?B?cDl5Sjk1aHVHaWdKUFZYVnV4dXdaWjk0UjJVbVIwOGZiQkhBN3hldElLN1ln?=
 =?utf-8?B?dkJLWFA5OFFGaWdnNkRWZG9QSG1mVncrSjFtUThTdzB5d2ZJVWFjaGwvNW9H?=
 =?utf-8?B?VHl0RE9iQjYrdkpFZHE0QUpXMTZrWnJkV0p0OXdlMW5YMXFxV3FhNGZKQUlF?=
 =?utf-8?B?T2Vpcy9BaW9MYjNHalpUVkhiV0dyRkZkMk56dmk1dm5STnlEeU1MVDloTFA2?=
 =?utf-8?B?aXhKem1kQWlUYndad1dtVVFOYXdEUFpSbW1yVEowbzA0cVdqTlJpSnhlY2xR?=
 =?utf-8?B?OHBBVjZNdk1OZG5ER205YzhmbnZucG9pWGYzbXVNOXRqVHNhalFNaUNMMDkz?=
 =?utf-8?B?Tkk3NGMrbVFyZTluVkRxSTNscm44OWxXNW9OKzNnZ1NCaFZOd3Zmb1RTSE5k?=
 =?utf-8?B?dExZemdaZTFYKzlZeDRFemRDc0FpbGNBcHdaRU90SGViSDBONFJ6WWdIQVlp?=
 =?utf-8?B?c25MSHNXWUQ3eW1pSnI5TGkwZ2pBaC9rZmYrY1RvTk1VZ0JrSmpHRDZoMnZC?=
 =?utf-8?B?b2Z5Tlh6d1ErN1hXM3AySlhqem00Y3ozQ0hBNzdxanNkaXdaQ1VhcXVBdCtv?=
 =?utf-8?B?VjZ0TWVDdTk5MjJXU3I5NjNITVNLbG83ckdWRVVHSHRFdU9Bc1ZqUmFwS3NH?=
 =?utf-8?B?bzF3Sld2WUJtNUtrOEZ6bXBFcEM3VUJjV1FydGdBRnlobnlpc2ttT2JReU1O?=
 =?utf-8?B?SG9rQ1IxcGdXcjN3MlN4YUtYc1NKSUlQd1BjYUxxL202dStzZTNrb09MSkx6?=
 =?utf-8?B?N3dYcEdVZFJaelp5MFA3YTUzVTViZGFZWXU0MXpGTER6cGNFK3RyUmQ0QTZS?=
 =?utf-8?B?N3Q3am95N1psMzZQbDFvZ2xETjUxazVIeFdIOHRoby9jSnZwejN0Uk9EVjBu?=
 =?utf-8?B?a0lZM1FjNUt1RG45RnY3TjZQcTlMVjdqWWlEeW1mdlJybXpYYURpSnBSWnk0?=
 =?utf-8?B?QXhFUC9SUkRNaVQza1hwSkx5ZS9WQmprODdzMUxKVDE4Q0t1cXZRZXNUenZa?=
 =?utf-8?B?LytoYm5hYkQvTUUyZmVtM1d3M3p4QVRTc3VLL1NiTUdaZ3dOTDB3d1hCQjFo?=
 =?utf-8?Q?MeXMUhq/Y2/FbNvKvHZX1n6gF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d357af8-3320-4549-71ae-08db3f67417f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 17:14:51.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86nS5yA19ARmiZRr1tAFzXOfvp7jZaOTUzvEew00klX7eDp375dcK+JNomF3kQclkyewmYS56MDD9xvXXX37dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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



On 4/17/23 13:08, Srinivasan Shanmugam wrote:
> The previous 'commit 9360c01646d4e ("drm/amd/display: Add logging when
> setting DP sink power state fails")', it is better to unconditionally
> print "failed to power up sink", because we are returning
> DC_ERROR_UNEXPECTED.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/link/protocols/link_dp_capability.c    | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 59adc61156cb..2914fca7dab3 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1043,9 +1043,7 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
>   				DP_SET_POWER,
>   				&dpcd_power_state,
>   				sizeof(dpcd_power_state));
> -		if (status < 0)
> -			DC_LOG_DC("%s: Failed to power up sink: %s\n", __func__,
> -				  dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");
> +		DC_LOG_DC("%s: Failed to power up sink\n", __func__);
>   		return DC_ERROR_UNEXPECTED;
>   	}
>   


With the following tag added to the commit message:

Fixes: 9360c01646d4e ("drm/amd/display: Add logging when setting DP sink 
power state fails")

The patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
