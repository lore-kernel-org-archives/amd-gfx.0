Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71627C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 15:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37F6E3E3;
	Wed,  8 Dec 2021 15:17:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B186E3E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 15:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx8IKxiDSQBYAybreDdYP92aSFxqpOn/xikaeq1YfTrF4gaYrH5JFSBLgqTYgKasZElOdR9OAYN1so+h8kQOeFsE+Ad9+c9GC10BD23bqeLrvRsCznpfRHQe1xJ4OY1XodfHH4dX0MPv7m+G0bhRFMS/XfqzypcRaf5q1+qdouTSx3Fs65RpgvGXBDtLbcXYOLA8GuzNLXp+NHLyrQO1BrSn591Z8/PZeEeyrMP2bDMvrM6pwJwOQNxWlFxsmnjck0zm+2Npzf05d5MkKXG8NNiFDJPjSKjIPF6bQ8cbNOYIniNd9UtsLmKD5oo52yIn8KxmAN4CNvVXe0rGZdGDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy1ON9qcLObQLKFuxnx548c+lVoRjeg7mpzzWkiaM18=;
 b=J02S7ecqaiPfOcg5WWYXvkdwUNgsRXXpVMRr4MUjyww6ArualLZJws77KNV9o5pSGxPA1siqQoxhmMnwI1cNKJLdNQgTN3Tt9gLBFk6MC4XZRDm8nmAiOHtduO0rUhhayOQLeATvYtncbB/B581YvnRoQwM6X7gESn6xOaWGAX3u//GRWecmrpmbCZw1jyIZjz8DoBgLzbeyG4dLXanNivs9oKnonswfH1RA/CIYVOjKyjQbcbm/4F5Rk8aGBWY679mT/K6qLOhtFMX8HT5Po/9KTxUnc5H2O8ahLA3x5efRa/Ga4f+m21dhxtOJcu7wBUia9gI6mtNozasYo9FTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy1ON9qcLObQLKFuxnx548c+lVoRjeg7mpzzWkiaM18=;
 b=WL893imaLcW78xcULFITFFbJdqLf7JbZcnOAQ9f5FOvkSR2pJ0bUxooH/5ZlK+XOORJlikKQYST4RUZokRiAccBFoa7Y3iuHrofzlN2Z9yXK0/WUmm3X6lVzXQDk6myqR7EkEBy3Ft/yB/rApxcAfqFEejeFQl2wKiQlkn0wKN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3183.namprd12.prod.outlook.com (2603:10b6:208:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 15:17:46 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.011; Wed, 8 Dec 2021
 15:17:46 +0000
Subject: Re: [PATCH] drm/amd/display: fix a missing prototype warning in DCN303
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, Isabella Basso <isabbasso@riseup.net>
References: <20211207191825.2463733-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <8e27923b-bc18-09fe-c7a6-82f70f33f57b@amd.com>
Date: Wed, 8 Dec 2021 10:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211207191825.2463733-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:610:b2::22) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18b0562c-7319-4152-649a-08d9ba5de334
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31839C65E0AF005E4239D4E8986F9@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4V51gujkcZmJnFgIawNVaCo08hhVcsLFgfrWYk8S/M8qmV44MYmQ6zWRAZ7G6UP9oNMwg3cSUWZyTojuTqDnKq3E7nrPCcbVYWNvwajFzxvgio4ICMjSHN9EX2MHQajUjmFXaeceqKyXVw75KeuH2dpxJEK6dCkgOSpAtQjWfFX9nyxIfSoQcNjQ1mJgrNBePlsTGtc6gxdL5xlgu5wWb2RsrdCDveTl5HrJIiW4MGZGSswaXPkWm2gk9hHrULGNKdPphcGF5E2P1Aa+NvgCEZ6ApnAxSKlZkaCWvjc0nCfhUOeHK07asoZ7cStBRXTUhLb6u6UxXWL/lW8e3iJUEbaSFldJFZ2xB7v4BzI9VMW8ccLc62LJWlu3rXKJ+C2Y8o1XNVFzHFPo9xfw96Q+lVs6mKQzUpBTcipH3tuSf74KhETxxgijhz0LPXt72WuFx1fiXKkxgC3n2HZ46f/uYprHsdmiIqtShAMh8BMxvonURmHGwl/Ksn+ez/f9rYNSzzqAQhs5X6GuIcIsaOFlQIlcZCK8XldLRAEs5adEG50J73YHPW+1sDd3o8oPOuXy4DejkdQd667dhmmmZJsQX82TMmMm3KetoI4ERXc89ge9nCofVEY9gFw643CT3y1pdb/Zp+wKL25L2w8qopieJeNipws9eu2ZBV00KfL+lZRYQIAsFmJwVl8Vqv7CKP+bxuc4/p2VUkabTVnIgOozPGCXJcqWKOsA79QsPiYwKftmtelI2UI1kwa2Zv+v4cDE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66946007)(8676002)(2906002)(38100700002)(110136005)(508600001)(66476007)(31686004)(5660300002)(4326008)(83380400001)(966005)(6666004)(31696002)(316002)(6486002)(8936002)(186003)(2616005)(53546011)(6506007)(6512007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJrQVJPZkNyR1hoV0NKVzAxaHU5TzZkb1ZkZEYzQ2dKUHI5UXZ0VE9nWUhv?=
 =?utf-8?B?cUs0cko0aVBnWWEydkZlVkJYaXdjV2FmM1pFYWlraXd1ei8rMnRjL3dJeVox?=
 =?utf-8?B?VDAwc1F1SFU2VXIzY1JGeXdqa2JWUE5PM0d5ejRmKy9KNlVOUXA3RmR4Q2ZN?=
 =?utf-8?B?RklqWlg0aGlFYUNuTExtQ3o1WkE5RkN0WFhqWGFnUVAzRTJ6WW84Y2lRelVv?=
 =?utf-8?B?bUdYVTl3T2IxVnM2Y3pXNXFwSjAyaVc4ZFBmREVUVmtodE02dHlZTHhqNC9W?=
 =?utf-8?B?a0gvYndzUkN1Ky9Qamc2aUFDK1RncmZRRG9IRGN2anZydFRvWnRzRVhlOElj?=
 =?utf-8?B?MXFkZWdDMnJlQ1VyWDBTU3RVTU5mYmNyeGVmckFWaDlmNThkc0FlcnBJaVpx?=
 =?utf-8?B?eXZEL2JJUWlLS01sMjVDcm5oNGx1dW45UU04TXEvclBpaWRXNTR2NCsvOUE1?=
 =?utf-8?B?clFGbm5aZ0doMmY5N0UwQXVxVVZTUUZtTmxLQUdCT0ZLOWNjZWwrdUhuRnBj?=
 =?utf-8?B?aFY0Y0MxUkNFUzRHdm53aGxpTFBOWU01WUh2RHQzK1JzNVkyM2k1aDdYRFZG?=
 =?utf-8?B?ZGFrUy9OUW55dS9EVFlHbUtrY3AvZlJCQkF3ZVd1OE1rZHdPYmZDRkpjek4r?=
 =?utf-8?B?TlROc3cyVzlvM0pldi80em1CYTBXbWF5Vjc1cWhZdzB1STRrYmRNUTlsTUll?=
 =?utf-8?B?OVdIa21LK3FnSXpLbUY0YU5oSW1vY2x0SmtZUlU0a2xRdEFscmZ2cWZPbXda?=
 =?utf-8?B?UlZUV0dFQkpQUWV2eHAyOGRXVTBnOHlZeHNzd2daSUdNejVnRTRFck1pVUhT?=
 =?utf-8?B?WkJ0K0xzYWxjcUFXMkxRa0loY1hsbzBiL3FqYWpkWU5kV2owUE1wYy9ZdkFO?=
 =?utf-8?B?d2xUSWZTUVFQM0ZMbXZYdk83Q0plT0lFa0pJdkRBMWdDTHBocW1iZHBoNHZk?=
 =?utf-8?B?WFYwcnJOR2lJZzlxcHliVFRLbW0rWEljc0RJUktvZmtHY01pSW9ocHVKNHlN?=
 =?utf-8?B?TWwzS1pCYm9rRDdhM0VxSWZTemIvZUQxNTNybDRkNHVXdmsyaGloZWVWbFBX?=
 =?utf-8?B?VmZHRFM0Wmg3a1pzZ2Jkek5OOU1TQno5NnZmbzZJdWtCbGJmNWtIOE1zMEJW?=
 =?utf-8?B?WTM3S2FFYmdzT21pVUZLRDJ5SHdXTGoxcmJrSVZ2eEVhSDJ6bFAxM1g4akM4?=
 =?utf-8?B?cFFtdXRYZUw0aXdQdTdTNkFGZ0wxQ0R5UEtBU0pWMlc5dWEzVlVuOXZySGhq?=
 =?utf-8?B?eUUveG1Pbm5sMmhJRCtIWEl5QVFFOWVQUDZPZDB1VkpPMzYrYmJORE1zM1NX?=
 =?utf-8?B?RW9LZktCR1B0c0YwYkpqNUwwSWp1SjI2cCtNMUM5UmdhSDgwdUZTeHpNVWlo?=
 =?utf-8?B?ZW9tV3pKWTk1L3dKd2ZXZXZlVFR0eEQrdmQwSzgzdjBoWWNsbWllQzRuYm11?=
 =?utf-8?B?WS9lOGRiVmtSbzhydFFsOVRHR0psdTg0STVUVzk1ZnNpbEJRRmdWSVRrZWtz?=
 =?utf-8?B?TDd5WUNOdFZzSURrM3h5K2VZMXhaSy9sOFdlWEFsU0JNdEhEWUUrTzFOSXcx?=
 =?utf-8?B?a2lINzZiZVBoTEJCMlVWdDNSam12cmtES2NhRG5QcnpmandpamZveTdMRjlm?=
 =?utf-8?B?a29Gdlc5Zy9zaFlEMW9SLzIzeTZHSWFCTmU4UzBDNm9RVW5PTWdhZFFLRGFz?=
 =?utf-8?B?SzBTUE04NmNyQk5DZnJFNEJ6MmY3ZXIraE4zNVFicWhWS01WZ1hxWDh5M3ZO?=
 =?utf-8?B?ZndldmdRdHJ5UHFycXdyUDcyQTExTC9BVitub1lZOHpLT0ExOWVuSU9XYlZ6?=
 =?utf-8?B?TzB0bCtBazc5TWxLZ0Z6VERnZnYxZzRGOWtJaVVWdFJhbnNZVnl6ZFY2VzNQ?=
 =?utf-8?B?a1gzcTNta3dHL3lUVHlzb2c0aVFsZTZVQkpuem9lZWdSS0RIMTFFRjRmMVZh?=
 =?utf-8?B?VkpsRU9EczNaRGJ0TWJ4eGd4SjBpQTUycWdQZ1JGY2oxdVRkU3RmZ3RXQmNo?=
 =?utf-8?B?bHlNbUoxWVZVT3lha1g5VHNoWUozUG9WMWFPaDM4WjdlN0Q5bi8rallRYnd6?=
 =?utf-8?B?VHpjR2NnbXRmRlphdGJwOXVqM0VZdjltWFFmb0FRVnlDL2JmRXE3U0s1aW1G?=
 =?utf-8?B?Y21QOXFWaFVnUEYvdkFCd2ZjMmdQMVlsU1dWc3V5RWI5QXhlZVNhT1ZzM3NW?=
 =?utf-8?B?blNWR3prOXF6ZlJtdno0VUxjWkVkYmFJRGI4WmZpSW0vVWZtRWxlQlc3K0h0?=
 =?utf-8?Q?HConKC0vtIytRFcGldR61Y6j4UzaJlRIlAmShALJu4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b0562c-7319-4152-649a-08d9ba5de334
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:17:45.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC04YEqx9q11Y78gY4H1hCYo6PIM9zQGOhZff+/RZhKQWfcuFr67BtpDVPaTsxB8FYGVq0c0fEIDq0K+z+TWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
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
Cc: rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-07 2:18 p.m., Aurabindo Pillai wrote:
> [Why&How]
> A missing include statement triggered a warning when running
> a build with W=1:
> 
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:30:6: warning: no previous prototype for 'dcn303_hw_sequencer_construct' [-Wmissing-prototypes]
>        30 | void dcn303_hw_sequencer_construct(struct dc *dc)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: cd6d421e3d1a (drm/amd/display: Initial DC support for Beige Goby)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> index aa5dbbade2bd..d59b24a972bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> @@ -7,6 +7,7 @@
>   
>   #include "dcn303_hwseq.h"
>   #include "dcn30/dcn30_init.h"
> +#include "dcn303_init.h"
>   #include "dc.h"
>   
>   void dcn303_hw_sequencer_construct(struct dc *dc)
> 

Hi Jay,

Isabella made the below patch that fixes this issue in multiple files:

  https://patchwork.freedesktop.org/patch/465821/?series=97701&rev=1

Maybe we can go ahead with Isabella's patch?

Thanks
Siqueira
