Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B84C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 21:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C258310E29C;
	Mon,  5 Dec 2022 21:11:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F055E10E2AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 21:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqrewTSvWNVUh5vWop+ZzV12p2M/ct+JwrnNn6p14Wsb+K0uYFaQXVYKNIvdjUHfiQsS2/KHEAUvCCltn2MwUSYN7BooldDo7YS7UKZsxumzQ5ETCqN4oct+83IxdVkliDezUwaz7yq8X33ILyKVAvgk2Wg7kdni0Y+PRItCYvSSPMgc0kpSCJX4JF3c1XUXmveRT6PT/dtCicSUbAoafP53S1kfHhlV9DhYeKtdrLtoD0uhm6mGbsX6OS/nuRE/a8O+9zuYq3gAMsde+LuD7vYPxrTuTTTnqsphcOZtQzFlLBORCQ6AxGdpr3ZLX44D3P1W9U5Ci41QnSfIV0XLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xROyvObBLZRVN+eDUNoVqGkQscagP+x30OO6At3tQOw=;
 b=mpBeuPFLiZJ3qMnLTcxNiwKN1NTZbZBuIOU/zO2IlMLuxYQ/Ruj5e8abdWFy1n7PXxm2LsQpEFdTwp2rCXCW1E6qeiVe7qEyt9Zx0Rcc8/BvEt1oconMHhVg0GrBBGFm3oSXML2eHrGyDYtja6RyRqazIkCcMbctqbRTfKbZMSah6qUCPIvw6ob5y03eA9vE6Dq6Ksmo+2/mhqzTzLRSEJTT2Vkto2QNZBRqxeH2YPSf26M9qn8rXCBz+LCJLK8yKVIiD/2N1TY303iphGpybIwN+gFOg49B/dteO/t3q8XutBqoj1PEx5tx1FIMZMLHs4+bAL/g8Cr24aWIwelv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xROyvObBLZRVN+eDUNoVqGkQscagP+x30OO6At3tQOw=;
 b=SCfZLZC92aljgOmPCfJZzwz/gg9hesluPa7r0d9xE50qQ9hjrHRPFV8z4+9TLo5ux+YgHT6fPIrAM/sL+TEfXTO/7nC0CGsY3VsjwVp+1O1jvZd0rgHvebkvfHFzBplvUu4MxNYfw0sE14y9Gx8dtq7s//6MFdfCqAlASNnOgtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:10:59 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::756d:ff13:d7bd:d590]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::756d:ff13:d7bd:d590%5]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:10:59 +0000
Message-ID: <ad4ab77e-0361-c0cd-fbd9-871e5c182ff2@amd.com>
Date: Mon, 5 Dec 2022 16:10:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amd/display: fix array index out of bound error in
 DCN32 DML
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221205210858.3666753-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221205210858.3666753-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 992bae02-8c3f-4f75-64e2-08dad70534f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO3xaka9/4QhlzjeLY/54Q9Z3wMgn2lpww8OVbiHf1SGUq43bK55kST1r0OooUbxHKAStUPPovdd+6I0ADIYq4T/GndrdO5DIo1yE4diSyAJdN0B5PQNGrcYEitiJDPJmp+lfb9MRybqWoRJ8G7AvhVyC6J1i78MaaapaWiVuwM8LdkS7rQEUNYg0m9HACzRfjn5Exc498RL4qIca450A3uRUDMKbGab4C5JvaesKX+UCPc5JFNHaBu03wpXgDXxZ0jUwEbWb4lwVcZ2T4u2NvHH6LViIy6jhTEVMLM5xV4vwPQZiaMuaahP8MEl0Y9MGKolD3V64o/CZQ1nwKQBGY1gw3mH+Zd8FmN5/oH3RVvIlfP9KaesEVaPpy0RBD4/dqhlEyaESBlPbYx50/r7hwQGdvr74eGeDVf4INmAt38ajnBp0xnpKhzylRaVRBQV1WYTjBYPKmIz5YeQR6OCM9uhjgKSIzDFulmyuxruHiPV6zOqwVyXeKufTH+gJSmXVe1lNutFYpJLB+tdY6cPuev75iwLjiaELpsn65+OR2SxXxzxQAIV0nnb0N62faewNBHU81OR08WjIVfsxiZNO/+ogIKuyGz9GTDcRerXQ4yd1jAwsXm6BTW279k/0njda+oVshGzNawCE/EDfUQ+S6IiQKlu0C9larXDUfJrDOcEbrvxefPr+ifjf3Pff7qCJJr8goHE2+uieKfX3A5mqXHf6Jdl1Ckv3AJvCMwpy/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(36756003)(38100700002)(31696002)(86362001)(41300700001)(8936002)(4326008)(2906002)(5660300002)(83380400001)(6486002)(66946007)(66476007)(478600001)(66556008)(316002)(2616005)(31686004)(8676002)(53546011)(186003)(6506007)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWQ1L1pYV3dtQjJ0djNJcVA0MzJaQzhRNG9yVlBUOXhTNGUwYUc2RGs2K0Vm?=
 =?utf-8?B?ZzlIL002bmJET2VaRlROL01BY1hrT3A4SlNwbG02R3BoOHNybTJka3FScXU1?=
 =?utf-8?B?TGtFendtQmp1OGtJQVQzUnd5cWxPa0srM3lmR1BiMjNqa0lFRGlia0ltVHNy?=
 =?utf-8?B?QmFrZUtYbytsNTVLbzd1bTFUclM2enJDYkNXbUJIR2FnR21uRVVHcHYwQ1Zp?=
 =?utf-8?B?NXVmUUpHMlhFUmdyMU9JaDNxbmNsTE9CYWY0MkVweTVJdzBhbDl1bVRaNXVi?=
 =?utf-8?B?RmJDLzBCZ1FaZVBaYXRVUjNCR3V1WHowZittL0xBNExuRERvcnNuNlg0b1JM?=
 =?utf-8?B?ODhxNEVwUHlzZzdXajNGNEl5SjdUcjkxYkdMV0w3NDNLTWFQRXhxZFRZeDdo?=
 =?utf-8?B?cnp5TlIxQzBlTW1ERWtuSkRtdXN6R1BXMVhDbTV4ZE4vUDRjYnJRVmM1R2Rw?=
 =?utf-8?B?bkdvS3ppQTNPNmFmWnYzeDlzdFFOaUZoOVU0WlFHUFJzSThlVVpjWjRlRHNZ?=
 =?utf-8?B?NXQwTEdtbGZVVmxYVjdoSDN1WmdZUnpmNWJqMWxvaCtoSjhESlhma1BMNVQy?=
 =?utf-8?B?S3BRd0duV0g4Y2MzMVpFRFBlTWU5RTR5UEN6RVlHdmdSTzVVdksvU3BWK3N2?=
 =?utf-8?B?NUU3WU9xS0ZJSDcwOUlTUENYZFh3WjFZYVg5T093V0YxRVBUTkIwRDFxSDdn?=
 =?utf-8?B?TGttWUVvNGE3WUZObzFiS1dBRUwyblZldHRUNkVzdTBvRjZ4eVZ0amtQcjRB?=
 =?utf-8?B?MERlQ0pabktFQVBUQUc1ZGtQczVqWmZtRStxeFZYZ1o0a3NvN3FJQnlmVGg1?=
 =?utf-8?B?VkZjM0t5S1FRS0lYY2tXTDBSclNKMVBzd3ZJZTdQN0NsQmw4YWpZcC92SkZj?=
 =?utf-8?B?Vi9xa0JyRWk0ekpnNmF3Y1ZLK2hSdnNubE16cVQxRU9EZ2dWa2VoM1RXWHVz?=
 =?utf-8?B?eEk0VWJtdkRaMUw1VUVLZ1BZYUJQWXFGb1htcHcrSmRKK1crMWg5OW92Tkdo?=
 =?utf-8?B?TUNvcTVRdWo0MjlUR3llWU5NUWh4SVFzeVFnN0JJWm9lM2Nxa3FORjVzQUJu?=
 =?utf-8?B?SXVXd1hIWFRCSjNUZExscUg4bzdzaGd1KzJDR1pnbGtWN08ybmZabENhUSta?=
 =?utf-8?B?bHVYUTlWTUFjbm9aWk9BSUxldE9PeTNzT1BHb3IvMGVZaFJoM1N3UmhscDJ1?=
 =?utf-8?B?QVFpNmNGLzY5TGF2MmQ4Q0plYUtLMU9uWFFIbXM1OWMwWUV0anFFcURRWDlv?=
 =?utf-8?B?N0tldFFqdUU1bmd2dXVKUUE4bXdaOWhRQ2E2RENMUzlUakJYM1p6VFQweFJU?=
 =?utf-8?B?SjQxODkrbVpCRWRqY0ZYYWN6dTdhSi9pYU44NWRxWkd1dHhxd2s2VEpoa0lY?=
 =?utf-8?B?RzFSbkFsU2VodUpXWnQ0ZkNUMUwwd0JhUlJQckJsT2V1TjRxSVZINTBGQVYx?=
 =?utf-8?B?YTlwQmtjcStGcXV4UWFMS29KWkdGdjRUWmp6L0tJWGpQNm0rMVEwREhDZVpW?=
 =?utf-8?B?OXRaTjUrcytBSTBLcS8za2ppYXp5MWNlMHFaK2xrVk9WQjZmMWx6bW1KVE1Z?=
 =?utf-8?B?WnZhc3g3TEE1QlpxUC94Y1hZY3o5ekxZZjYySjVzN1RUVWIrNmEwSmIwcGVW?=
 =?utf-8?B?TENjeWhkTktDZ21TQ1RxdUZaMkpwZmFSL3Bibkh0c3gyaGNzQkxDZWVSN2pv?=
 =?utf-8?B?bzRWc3pYZ1NjR1ZrRUI5alM1QWhVemVJRUhVdTF2WWJHZHEzakdHWEZoV3hB?=
 =?utf-8?B?NnY3TUtCK0Rtd2tub2czZ1ZRWlJFN3lVTFoyOUhCSDhhemhqM3VNYko2MDdM?=
 =?utf-8?B?Tzc4NFRWRk1XdmVJQnMrTldDT0M5a3pjQmlWeCtxWFN4VVZnOGlaSW5xellJ?=
 =?utf-8?B?dXEwcVJFYUhnRVdYQ1lGQ3NzVTMvV0NmSWt2Yk04QmlzS3BUM2JYS0wyTld6?=
 =?utf-8?B?YURxK1U2Znh1N2JHTnRrMW0vSWRsckZvSEhnT0hTNEpuUzFPd1ludVQxRUNU?=
 =?utf-8?B?NXRSNlcyckN1UDBWYVI3ZTBpUzlVY3RvTTR2UG5ROXEvZWo3TDdhdmxjbjVZ?=
 =?utf-8?B?Z1Ivc2dOYitKVjNTL3RXTlR1azJIN2dKUy9HNkkxTENlM3VwRW83L044ZzAr?=
 =?utf-8?Q?P5kg+lwD6D8Y+TSHF5CVn/+0t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992bae02-8c3f-4f75-64e2-08dad70534f2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:10:59.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxmACJcBAXkJr4aFR4Zx9POYopSOHv8gwHntUOB9OBuMnfZlHuZjTd1qhhFfm0J2XyixsbinaULKgk3pEh43tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/5/22 16:08, Aurabindo Pillai wrote:
> [Why&How]
> LinkCapacitySupport array is indexed with the number of voltage states and
> not the number of max DPPs. Fix the error by changing the array
> declaration to use the correct (larger) array size of total number of
> voltage states.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index d46aa4817e70..8a67f4d65d82 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -1162,7 +1162,7 @@ struct vba_vars_st {
>   	double UrgBurstFactorLumaPre[DC__NUM_DPP__MAX];
>   	double UrgBurstFactorChromaPre[DC__NUM_DPP__MAX];
>   	bool NotUrgentLatencyHidingPre[DC__NUM_DPP__MAX];
> -	bool LinkCapacitySupport[DC__NUM_DPP__MAX];
> +	bool LinkCapacitySupport[DC__VOLTAGE_STATES];
>   	bool VREADY_AT_OR_AFTER_VSYNC[DC__NUM_DPP__MAX];
>   	unsigned int MIN_DST_Y_NEXT_START[DC__NUM_DPP__MAX];
>   	unsigned int VFrontPorch[DC__NUM_DPP__MAX];

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
