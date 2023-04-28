Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF3C77B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1088A10EDBA;
	Fri, 28 Apr 2023 19:14:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E16410EDBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF/dd2B6CPlBlf5QM9+oI49CEq2gg9OG+TSW28cu+KgWgNd+VzJ4JKY6F+5D0OKFMBNyfO7/DCpt1u2l5XwdIgP7LyvdX9Pjf3srNYCvIT9h3c+jWBLPKsOmeNcc6e+dIEI15UJ7Z4u3P48hln7uCn/VH8PPqzF/6a8zuRzGUHxbSWa+6vM3+X3gpdONr8BMhOVrVF3TS6VN74+meGbkEL7BZpjXuSy/Txe2rtVjg7V5OaW0hS9VFQ3wt6OIDlhhvMRCtYYTd95xhqg0ilTML9kF1UPNrWNbMAR86DbMWwNuZb9nhF0r34LFKgXIkyzI98MP0q6i29TZumLqhyC3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKiuvSeVueAISFMrDrjLgDVGtyl0r47c4qEF86ZDoho=;
 b=IOJUU8/llmtkCnbl40lCIUue10lUT7E0TW764Gf6uS8PFujAb3vL2LUjM0eMS+dmm4OKwgxrzKwhA++R483GBQmuCZRvZG2iar+04fw3qLstupLm935LsgPuPVx0j589bVmQ/lDPKcOgmYBTpXmJv6swiGLRRbdPWhEFNaNCRQ2op+Mt+m9AaqLwrRWONe9RH/k6I/wBe+mCEgcANozjDP22Qo8yCBa5XlKwALV33HX9vtXfL59iRFaa77rWzYNmwgohpKME9bHexsLNNkvh3rdSEe49tUTFsXWmPDchaunxL0NMXKb4M5ION6mBauQ5c5yP4CYxkqMm1kUCbQRK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKiuvSeVueAISFMrDrjLgDVGtyl0r47c4qEF86ZDoho=;
 b=zos19coicrEBwwYkQtnhapG7I76azLi8BeoxlM84i6VNsqfjIP+ZeFNDj10x3Pj3WWGtpT6+qoFwpiOEuoIpUnMsbI/NzFos2Hu5D3EEPaxSzVDUYo92eZT+D2v5S5sCXSzmqoKd4oAulqS2JRAbBvR09phl+txb/P2C5VE26vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 19:14:24 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 19:14:23 +0000
Message-ID: <ff98061b-79be-f402-08b2-0f5e2984c062@amd.com>
Date: Fri, 28 Apr 2023 13:14:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amd/display: Add logging for eDP v1.4 supported sink
 rates
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Jerry Zuo <jerry.zuo@amd.com>
References: <20230425030417.1213167-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230425030417.1213167-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0057.namprd19.prod.outlook.com
 (2603:10b6:208:19b::34) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: e71c3d91-632a-44a1-4e6c-08db481cc6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXcAqqn1cYv2M/ZtNU/wDyxXivA/mI+plKltvAlHm03trqFimemu5d4EH0lOnXP5ZzzdNAAfb2VSa1GvQruymwS4vb/tuRWBS/lk+nyD/lM8QDcBiy4BLT1ecvk19ZsTHebcNyw2tj982phREFClLf7Gm116gIb1vOCIzqipMoBDvk9cvE05bzW3wb0EV0zPvPuk6KUCGwwdh3kV1U3F823DxkEfhV7EdFvX+/tNlknzA65I0x6O6FiKfqoosi0vkLMF9CNZeXWDSdWhHDVw6pBKJDEuo4QUcJ/Qpxen3oNAtyzXM9R8rTwT5YOI8buq3c/LmclsaZ1vH75+wvind1FOhY5ocZqtV8Bbt4v0vPquRPEE3PnMvEg1im64kx2LQlZcndDBEEAWc1gaBSJXd55XXsh7fiGr3tP4pY6MppU4NZzhl1Pwn/tQn8n0ZmM9M6hcZPlSYlxMvgX1bl5zZIH8Q7cqQ4yC9eSiVAVtlF0Oz7AvEhsQolUWihgFHytwZfz+GUYKpsUzjuNpWSm3fLPQfGywu5w6DpRpnNfFj9TDMTxZEWmGdG6RFi1u8Po+FvW/p9dXStLkMA5VmiOkmQnKiZE9/jCewiwerSAL6Jt1bZZ4vFt/hlUBTKU6X7+nVC7kVlfUSnJGXpzgbhNI1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(36756003)(6512007)(6506007)(186003)(53546011)(6636002)(66476007)(66946007)(66556008)(4326008)(316002)(478600001)(86362001)(31696002)(110136005)(8676002)(8936002)(5660300002)(38100700002)(83380400001)(41300700001)(2906002)(6486002)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnl0RWIrVTgrU1JHaERScWRnRVdhbVU3UFhGS2JZVXZ3R3ppckdtYmdVZTFQ?=
 =?utf-8?B?aWhUWll2aldSak5XVHJXR2tTeElORHU3TEc0QmdWcTVxVHpqNjIveVFtbGZB?=
 =?utf-8?B?d04zMTY3M2IzQnBGb2pWVWVvQi9GT3FHaGJpSEpQYjRGN1ZDNEdXUnV0Z0hY?=
 =?utf-8?B?aC9zM2dOWGhRVW0vdjJBa3lyNkRmZ0s3Y056WWZGaHYyQVJCRkd3RXd3cjVG?=
 =?utf-8?B?aVJiZGVCVUx4K2Uva3UxWDFuYjVOMUhBbXFjSGdGenRnWFdMK2xhVDVkU2xG?=
 =?utf-8?B?dU9GRkp6bEVURnVnUlZnRVVwTFFsMWVDYjRLRWZuV0p1SWc4RXZQL2hZNmRw?=
 =?utf-8?B?azNqSDdoQ0V6bkY4bXBNTS9SOWhIVUVSTW9WOWhnRHQvTWY0L2ltMjR3dVpz?=
 =?utf-8?B?NTBuYTd0cGd6M2pNcm5TdnptalR1MldraHptb1ZjSnI4NWJDL2R3TGpRZUVZ?=
 =?utf-8?B?bG9QcEpmbzE0elpFcUZHdFRZVjh1ZTVNeWthWElPaVlLaHdtSVNOMkFOOEpC?=
 =?utf-8?B?LzN2Z0IrejRLdUdtZG5ubnUwREIrdTJCbCt0RTlRVHZKWUZNZ0hjdldlNmJ5?=
 =?utf-8?B?bkhNRU9TTFhuM1IyeDZ6NDZVV1dKVmdMYlJlQ21sUnMxLzRzNDczNmk0b2Vy?=
 =?utf-8?B?REFEUSsxNitiaXh4OU1kZm1kODVyUmo1MzZ3bW5DWUdLdndKbTYzTzNwMG1H?=
 =?utf-8?B?dS9sL1lmay9EbUpmT0lqc2ZrdlcwZzdIMm96NW92a25tbW5VdmxxenZOeUQr?=
 =?utf-8?B?NEw5T2V3VndBRTFTc1FaaDFIeW5LRW5ldVdKeEZZT3JLN1JUQ1NaVUhyd2RS?=
 =?utf-8?B?M2tzRnF4OERCMUcwWUhwdE1kZlpBMkwxQzcxRXhUM3c1TTRtNzVxaDF4cFJ5?=
 =?utf-8?B?N21EenoyZ2Q0aDU2VG9MM29VTkUwRzZVNm80bTFNV2hEdVRYd1hoa1AvbUxC?=
 =?utf-8?B?QXZ1QTBldWJZeUtaNkFOVXg4MWIzWjBIUjQxemhtQnpGOUdZc0lDcmNGRm5V?=
 =?utf-8?B?RlF3d1BFS0RGaVBKMDlnQVBWN1F5SWpqaXNKWHlkb1Q0aEhtTU1ibklJQzhn?=
 =?utf-8?B?dzN5SWZCYWVqeVdaWGo4WGhkRkNCdEJ0S2tqWXk3Uk1ZMUlSNUtFSkRvdHRj?=
 =?utf-8?B?QlliS0JucSttZm01RWVkbWhYaUdZQnBBK2NTVVhBbEVHdVRXS3BXMWw5UENh?=
 =?utf-8?B?K2svZWlmczBJTEM2cE0zbFVEUFQxbjdnb1NGWC9HMjNvS09KbnB5N1NPaXhQ?=
 =?utf-8?B?dmdycnlQVU5MUzZzdExWbzgxVzFhRDhlMkRZc0NqSk5zMnRpYzRVOS9GZ1Fs?=
 =?utf-8?B?cW1aczRXbmhZTXZza1BDRWFjVlJUTnNYVTdWT0JOT2cybjB1WFlaRkxWSFZo?=
 =?utf-8?B?SVNrcWFpSEI5eFlUZGdCdkFJTEk0TXRJOWFRblBWNnVmN2U4UG5vVE1jYjNp?=
 =?utf-8?B?VW5OZWFSQjlWQlBWNmJHOXRLQVBtUHk5YnhLRDU1MHNWRXFWa3RkTTdBMksx?=
 =?utf-8?B?WUtkT0JiRUZVU2xTQmgrU0g4OUFtYnZxcE5aSzgrWk1kUDRDRXNUWEgwT3Az?=
 =?utf-8?B?aVgwaHRLV091K2xJUC90VlFSbHNlakpLVUVHMFRuTEFnN1VyNzJqeld2L0dh?=
 =?utf-8?B?RlMwRG80dHQwRDBhMVVKUytkTEMrVUJ2YjFEY1lPcEM3cFlLM2hSZEhwKzZM?=
 =?utf-8?B?VFNGdHdBdXM3T2JUSER5MkVYWTU2bGlRUzRMMUFYREhVUzBwZjhYblFqMHpL?=
 =?utf-8?B?TlpHMEI4cXN5clZObmJmSFRSMWdSbGc5NCt1djRKSWNkNEtvOEFPTkNxQ001?=
 =?utf-8?B?aGM0ZmhKSmQwOEY2Mm5vMzNkVFdVYXZhWDBHdU5HNEl5aDlrTjh5MWpIdi9Y?=
 =?utf-8?B?YVo0TjMvTHRGa0RFZlc1UG9oOE80VG9XVnVGeDZBM3Nva09nL2NOSzk0RDBU?=
 =?utf-8?B?WEs2UHJweE9OcG1CdDlMRzRuL1NKNVFEUXZ2UStYSERRaWFQYXdtUWRQS0Ir?=
 =?utf-8?B?WFZBdElDSzdkVzEwSXg0VWZKbHdYVW0zSFJkaG5NSjhFV2FtcUhKMHorTTlz?=
 =?utf-8?B?VjBxSkV5SzFUeUF2cUE0QUhVU0k3dHBoT3NLcU9Tc1daWmxGVkZBdFY4MVdw?=
 =?utf-8?B?Z1kvOTRkUG1vUFhSYWNndXhtRVBpMHhJQzdHb0lMN3MzbUtDL3hGMTBxNXE0?=
 =?utf-8?Q?Z/Sxpn08gfuLqKRoHCvwNHVBSydWqbsPm9v7TPwBtcPT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71c3d91-632a-44a1-4e6c-08db481cc6c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:14:23.6764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ3fN/uRqENzUS8ldP8prby39bbI3kR1HKO3K83WtOckK/MZfe230AZUvT+2T0HLNlqKpEApshZlwFiLPKsYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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



On 4/24/23 21:04, Srinivasan Shanmugam wrote:
> Include eDP v1.4 panels supported sink rates in debug output,
> useful info for knowing optimized link rates
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 84265dc66bba..b69187ce8adb 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1952,6 +1952,9 @@ void detect_edp_sink_caps(struct dc_link *link)
>   			link_rate_in_khz = (supported_link_rates[entry+1] * 0x100 +
>   										supported_link_rates[entry]) * 200;
>   
> +			DC_LOG_DC("%s: eDP v1.4 supported sink rates: [%d] %d kHz\n", __func__,
> +				  entry / 2, link_rate_in_khz);
> +
>   			if (link_rate_in_khz != 0) {
>   				link_rate = linkRateInKHzToLinkRateMultiplier(link_rate_in_khz);
>   				link->dpcd_caps.edp_supported_link_rates[link->dpcd_caps.edp_supported_link_rates_count] = link_rate;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

And applied to amd-staging-drm-next.

Thanks
Siqueira
