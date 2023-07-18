Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B877EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 14:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E5189B12;
	Tue, 18 Jul 2023 14:00:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FF4899E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 14:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRhLQUP/6mky1kMNpYM6caI+8bcJ9otUE7GSPPPHYR/rbD4FBg/p/KPkj8JIMEDJHrVARYjBm25RatqWXwHAqqEG8QhUcO0muo3kop2WEnsoqgJchn5wjayRvZPZ/iAGUCc2Y/G8Oad6iNfR0EhTebqV9nUC6yxtf6fIel2hY/BWaScvKqRwvUsWPA/p+gwKdRNhUq8T5lvCYPAHQ6EfcR68GuhKBH7j7/RCC8Ijs4gCXnLX9R35AaUxuwtAFlk+zPJlGFSRIDqYctDbi/3IqQJt7yZD8fdlFmVeGvYn22E1iuSRfDa+UiQtGrXpn56h7glMI8PgvoHq2ItP5pOpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obEBI2NCRH37ZsQ/YGGOpsvlknuIEWQKe3/cIrAsjuo=;
 b=gVBvqCwO2gVJBB4iiEK78ERQe7aJNzZzEHpXaNc+AFBv5XcL3tvgf/eNLVlioEyhDnUaOhXcR+PRZVo1fvpxHVIdmlXgvM5pv0og+K77eNo9l7l/z7AOIl2Ln+76C9bPstCezuO4A8IRpDkuJSlcGfLbqzzbyud6HESGmcmos0wpQUwyYC/DJK+I/DzqoDPLP1pmYVwQzfbqEBOFh2E579d5dAjGSfVSLxSlAgoOTa7yoJlNyjHTDbbOdjsz5etcTHhPQrGzJxn7cpwE2mWnPJ2U8q8fah7EctaKAJtZn3N0XqUdmebkQjF0QaCBpq3HVDJp10JTttRfCPMmaYh2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obEBI2NCRH37ZsQ/YGGOpsvlknuIEWQKe3/cIrAsjuo=;
 b=a0atoBnA7trXY/KJ+SudG+2PMG0pexwPBXFWbi9gISnfLkvNCfOZB5VqvsoGDeyA/9qQWzmb/jXYn4AJQkn7uOeU67/I8v9+ohQyO8SnbhshSJ0xrnOKjhulIklr/kQ5/DB5N28BRmhPc7QSORkj2EVK1Q5Ae7wopU6aRTccjLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:00:11 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::bfee:712c:bc2f:8844%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:00:10 +0000
Message-ID: <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
Date: Tue, 18 Jul 2023 10:00:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20230718122120.2938177-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::21) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3828a46c-0005-4a4b-adef-08db87974d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyInjB6+klGHvAFye97ebrfxmlWnZVfHv/W1kSKbuv77wPMrECV4+cMuicnUHPgrjzMxqNwEjYoUjux23xgAYQeKaPAT98jYZYfCOMPpE1y7wh0vieuBtakk6KjoKFDEGeKuILXZ94OJqQeGfYEiMeagagmlN1DVYyvF3cDq8JyYEctItwurIcYiarvbYovcfdDprR7P45amNCuSKlDVJxu9voSdFQ+ae5whxBd6YP6rNQHSyp8Le8P0+aXrZhANg4y0wjRo7OKbxNFevOfIehwpMPotLXBtQ/Va7MAhVAWDIUuFjAiS/Ge+rKo7wcTZUR7jvOExgXwor85ccEiGc6iUAxA7owm0FTQXk0YqfOvFSfFGkBaxz92wHXRAHDMUtbXsj/QpN1jw1cJSukO32s8cNW0kSWNZPxF/MRNYlGp17Y0tODE1ODnufT8g0o+XLQLwEvkidtlYBTwhBgT6jEG6/DzzshE5ltvw2gKIcTjFuS+HWcL1rJjqNV+S73b0YjArnMLlmEj2fak5c9GVgZsfOZbWJ2qSO5ftKAipkKexAxbrOVIADUFi5CQjJ3wS3hUf5zqKg9Wo1ElzvyAwuBlIVnhFTXRtOlZ3XcywRQ5ZVq7Zjq+rakUTp+tDeldSLO3cjKpk1ejgdYMSIYhZ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(31686004)(36916002)(6486002)(6666004)(478600001)(2616005)(83380400001)(15650500001)(31696002)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(38100700002)(66476007)(66556008)(41300700001)(66946007)(4326008)(316002)(8676002)(5660300002)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0xDWWNNZ1RoeVNWYjhYYnhIZ1FOK2d3RjRWcUd4TVUwZjFIWElUSWpJZWVm?=
 =?utf-8?B?ZGRIVDdlUWhqb1FCZkdjODhLRm9TaVBYZkhMam9YVGhkR0JySUhMa0doUFhO?=
 =?utf-8?B?RTd3Qy9SN0ZneVprR2RWTDQrOForTmJ5UlA5VEhVVW94WVhJRWovR1ZmL2k3?=
 =?utf-8?B?cEh2NW5ScWxWWmwxdk1nTlc3aHkzaHAxV3ozSHN6R2k4S3ZuRHo2VW1CamlE?=
 =?utf-8?B?S2xUYVgrOEZDS1BKbGtTSmdHNC82TTA3R1k5U280azBEWG11UTVoamF6U0pR?=
 =?utf-8?B?eCt1VzJ4cVUzMmlURmNPNXcwalQwRUxlYTRBclcySEU0YlZRY2gwd3gvK205?=
 =?utf-8?B?K25hUDY4QzdIcVBmUDVib3pYajdRVDNpSW5qbDRORlc2dVNycEttSEJjKzdP?=
 =?utf-8?B?bmhkaTdOMFJWMVZZejFyYnloOW1WYTBhVDlQNkl2S2Rmb1F5a2Z6a296YnlH?=
 =?utf-8?B?eGJCckIvNXBib2pWRXhTZ2FMditKcGRLNjg2MGJ1aGY4ekdxczIyaFU1RVc1?=
 =?utf-8?B?bUo3NzBCMnFUaXlnVm41QVZ2ak82NEFpT3JJUGhBVytEQXZDVCtNd2ZKMW1a?=
 =?utf-8?B?YzVKb3hRTmQ2TUxmRldhMitKZHAyN3ZVM2pLSENlYnhGdFJ2R3RlSTBUNUxp?=
 =?utf-8?B?V2J2ZFF6c0pBaXNSK1NUKzh5aS82M3VZTlBkdWJRRWtOaC9sYndnSkMyQlA0?=
 =?utf-8?B?bzEzZ0xMVnNrL1pTdnBtcHJvK3JkRE11dklSQkpqNThNRzcybjRZTm51Nllt?=
 =?utf-8?B?azdKR0o2NHNDOEdwc3hydUhDVnFaSk5KSnVhUHV4L2d4a2NoZUpiYysrbVlp?=
 =?utf-8?B?aHN1WHN3eFJySGd2T25TaC84UjlHdDRzT3VHc081QjFOV2c1QUNkUTIvRTRR?=
 =?utf-8?B?NjZoa1ZNNjEvRUp1d3hRb2twQlRQKzl1NktrdjB2MWZ0NWpjY05CSkhTQ083?=
 =?utf-8?B?U0lnMy9oNTZxWFY5cGxhNUppOFJtMjRkME5GV0ZORFhJZXgwYmo5M2hFaGVG?=
 =?utf-8?B?b1d2MDdJUWxTNkRUZGh2SVkzVUJzcWhCQWxRNmF0YjdWeEVEZTlmc1lNQ2k2?=
 =?utf-8?B?cE5NOVZwNmJQSUttVWppWkRHY0dHcFJNbXlGRUhDUWlRaFJGZk05d3IrOXVI?=
 =?utf-8?B?ZkpPZThQZEF4NDlnT2FKY3A4L2xtbmJlMjZId1JKSVhZUHZmYktINjg1eGJi?=
 =?utf-8?B?NHhkcTFyMVA0a0FOcUx0ekYzTUFYcGF3SndsRXdNeGV5MTQ4ZVBFTWh5NkVD?=
 =?utf-8?B?YS9tWmYvTHB4UjNDNDM3emNHYWZGdTlkZUJUdVFseFJaWWlTK1lnSlpwbS9S?=
 =?utf-8?B?Y1k2Q3lOTlZmUTBDa0JNZmJEYWlDZFc1cHBudEFMK09EK1dZV1ZsbHE2T1FD?=
 =?utf-8?B?emxqSVU4a3JNWFpIWU5qYWhMR1NybFVuS29vMjlIQURvUzNOUGpPeXZyYzVs?=
 =?utf-8?B?SGIxY0JTWWt2YnNCM3NLUEozUERHYjBzc1RsVGplKzJKdENwMENsSXA1WFdK?=
 =?utf-8?B?WUYyd290SzlKRUdMVUFKVk5Kek1ENDM1clVpNXQyUUREVENwYjdrTzJIS0Yr?=
 =?utf-8?B?ZWVnU3RwR1ByVlZXb29NUFA0TTdBV2ZKRFdhOG1RM2VmdWIwb0g5aTdlUnRh?=
 =?utf-8?B?aVRGTzJxeUluczVzVEduZnpVVFB1eko4MkVIL0NJU0NxdjNDY0lhVzk1M1ZN?=
 =?utf-8?B?eU1NZjgxbEE0MEJmOFNBeWdXazZlZDF6WFJKTlRseEFIQ1ZZcjZROUZQT2R0?=
 =?utf-8?B?MXVOTWJVOWVxL3hJQXozc1d0UnFKQVBZa1g4Z3htc2VzblFuMVU2cFkyc0dW?=
 =?utf-8?B?WG04VUpmOHJCVGlkcXNnaXBxN3o0d2VIS0wwZ3I2WXFEb2M3Y3VOWTg4UWFl?=
 =?utf-8?B?MlMvZkZFTkNNYjBFcG14TFc0NThXeEdLSWhkQXpFWjVsdGpWdkNJeXNqajRq?=
 =?utf-8?B?R1RtQnBaKzVnb3lUb0JMaEYxckdTMnRLaHJXK21JZk0zc0ZZY3ZEYlpBTUta?=
 =?utf-8?B?Ly82cFZ3eVhEMlBNN1VSKzAwRjhhWksrWFRlTDVyYjRUV2ZxcmxJWFFMdHY1?=
 =?utf-8?B?Lzc0WTkyakdqa0Z4bUdDTEJsNUJUTGg5dHpBOXcrQ2t0Y0Nkc0VHZi9lR1Fh?=
 =?utf-8?Q?YeeLEex9PIkQHSwMMHMVhyTig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828a46c-0005-4a4b-adef-08db87974d16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:00:10.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kyvb8Vz2XRHIAMZSg+YwGY0llSHa5IeZnFcjmJP1gVCVUGgbVy1v4ybKthq7M5Bu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-18 08:21, Lijo Lazar wrote:
> Not all rings have scheduler associated. Only update scheduler data for
> rings with scheduler. It could result in out of bound access as total
> rings are more than those associated with particular IPs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 72b629a78c62..d0fc62784e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		ring = adev->rings[i];
> -		if (!ring || !ring->sched.ready)
> +		if (!ring || !ring->sched.ready || ring->no_scheduler)
[JZ] any case for ring->no_scheduler = true, but ring->sched.ready = true?
>   			continue;
>   
>   		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
