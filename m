Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9018BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 19:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AF110E871;
	Mon, 24 Jan 2022 19:00:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E7410E871
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 19:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWFF1SRXAT2AOg6WG73/XckymoRyPSufoRtc1vBKGHLDhcjhKvvIGaunmaL2HJHPhziOCObMI/XLoUI0uZEuvfmUfdmg6LVZn9rY7q718oAnt3IhgX+J76PdFc2IxiGKyzdd4v91M94nEDGgzFSsxVXpgwhHRWSBYFC+ziI1znnEMz772t4WfsmgnKiZTxaKX4jxIAK9Zy8gXSJaFeOj+9IXBwJnfB8fD7Y23nhWf0lk2bslxFUamqZRX2sN2Q1JK+en5L5onx5lgDOM+6B7jVKOySiz0iIgfXFsd2nV+YuA63GklT6PsbzJ5OlS593+c7pTjbWcIw5vfgsrSjt88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCpk8EAdFQFgIPLD7Fc1LsQ/3NgmB+RlgIyy/9r77Fs=;
 b=n+q1g7Ua6Z3QWRakemBgSHQs/XIDEUynxpKhCGhZ7sOPHnaKwVYETwmr0eHN8dLV8tjUr6RuLumkRE8H2zmRXPkIf680vHKLTmQRweNSGEsxARCGsIfvvdqKyJLIr8zMcID8saBhkuDW8HQm/BQYLKkbyuwjT5Yu29U6Aix54LeoHwblF7HzYXCcOtbLKHMWMio8OjhXZmX/3cugQBieKf7EyRDCKhEA4fTZQh8xpPGtahCT7vTO8NzsxXwiVhTo0ob3SkgOX8NS4pbehivYmY/BAHgIUsCAEkzzw24nhoGsGwlaSCmFWHZOO2RaNodd0+gc1ok5C60ecIG0AF8wQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCpk8EAdFQFgIPLD7Fc1LsQ/3NgmB+RlgIyy/9r77Fs=;
 b=TmN3AoChj3PRLPuT+K+nmGklj/65onYJm7Eh1tdW6WWPSlzeytXHD0KdZhxOaB0qU1eHjF0Q31qFEl9Fs3qvKis5Q1HTu1Ow1AW78z7ghzASqyPLP1kzZZGX6TY1rlOttWq8gWFTrX+yjcI7z3BtJmMCIvgez6h7Gj0cmZkKUCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR1201MB0265.namprd12.prod.outlook.com (2603:10b6:4:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 19:00:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 19:00:23 +0000
Message-ID: <53d8c220-dd1b-cb07-4cdd-70dcaaa20f30@amd.com>
Date: Mon, 24 Jan 2022 14:00:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/display: Call dc_stream_release for remove link
 enc assignment
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220124185701.54981-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220124185701.54981-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0363ae3-a325-4317-a322-08d9df6bc645
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0265:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB026503FBAD50A00332FF7B168C5E9@DM5PR1201MB0265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1ww67dfQT9BEcpALd9+fkAki5qnWMWSfZtId4B/FqbwQqnm5awyZl6ioEwH8WotMgKdCR5/8W+SAJOfGpcSr8X6lTTZ65tNRz1N0O25ySTVy8n04pBveLkQq0gR2IQny8kQspgIBXz19t9se2G2AHYL+zuN9i5aQ+WhYtJ86Q9bHo0rlpd9Ge38d/AAdkk/ewECkJX8fSD88VOM0sSul4o7TFemPZ14BFYPTQaL0j9rs4ePD6t7/reKpCYTF+3qcq+2xxqtlG8PrMWr5oNz9Uy11BUPlvmtplD80aUs/qmcLW4O6M5FcRe/UFUV1qGHX5yiJyQvLozb71Ihm6dd16IFuWLy4aVdFApxXWm/Ic+SOW156YnOwS4REDbY9n2w5N6rZS4+a3TmOpZPNuxQAVSiwpjDmNd/7rnr7+yLO/ua974o7gGj03acxk2jgDIlfzhSrjtajWLiG0p5dl8YWMhuHtcAtIqTU0EHvSuY/y5UazXeBhDGsnOBnRSg65KTYpsGKi0yK1sWriULdPrvAupnsGDrtn69rRdFOcTHbDdeyNoJldK5BxBZivn7/QY6W+eqFV/ulxc1gJASgA9RIPQ+Qc+9q/00rcMfe9MW3j7niwjuw2afcLckBVMmP4/T2O0mf4jxZ7yTnJyWYZPaOOfsa33dKwQJPicbXYpIgR6Jb2Np85UXXbwxofnMNxPHPWTehj+GKndAY04wWQeg1QAIfLXVOrL5X4N03qBemRwXue7pzdpEBJnZXUmiM3Kb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(5660300002)(31696002)(53546011)(4326008)(54906003)(6512007)(316002)(31686004)(36756003)(8676002)(66556008)(66476007)(2616005)(6506007)(2906002)(508600001)(186003)(26005)(44832011)(6486002)(38100700002)(8936002)(6666004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhVS21tZWMvZVNZNm15UlAxVlBSbUtCSTZoNWZsbUYrK0x1ejlXUVdJVHoz?=
 =?utf-8?B?ZjFUa1RaRDcyVFYxL3BFUVhYR1h4Z09Nb2tDQ3JPYVpoT3duaE9lUzNiK1Fx?=
 =?utf-8?B?SUlMeVNpcTU2RlpPNlZMOS8rUXF2elJYaWhMYzNIb0xMSStNWW9ieStJM00r?=
 =?utf-8?B?MXZBQjF4UmhKSEhBUHFlUlpaN0tNSTV4L2x2Tzl6WnlXRU93eHFxZGRqR2M1?=
 =?utf-8?B?RldjUDJKRGZPcTY5bGtEeWdDWEZTeVFHR3RZcU9UQ3JNQzFrTGZSSkE0cno4?=
 =?utf-8?B?UzYvaXlxYjhPalgwTXlMRloreE90V2hhbVFORGN6eDdINHhKbE1JY2ovdHA5?=
 =?utf-8?B?YlFzVVJML3hPWWtHODhaT2UyOEZxc3F4N1dJbEZmUU1NUWJMR1dZUm1pVkda?=
 =?utf-8?B?V083N0hVQzFuYm9VR0JybWxLUTRuYmtpSXMxVUluUlFjTUhVVmpSTTZVRzNx?=
 =?utf-8?B?enhBQ1AzK083eDE5ZUtlU2o3bjNKOTBFQ25CRytOaWhWZG9XbUFTOW5janNX?=
 =?utf-8?B?dkVkYzlVUXJ5ODBDdlJodWpsNnZpWmhCUWl4TG1GTTg5S29PK0Z5ZERKanlm?=
 =?utf-8?B?eGtGejlIZm9RalpUS055MTFuQVFQY3RkWHRYbENnbkxkdzdtMjJhRlNnL0JC?=
 =?utf-8?B?VDdLcGFlVlhrbDJZS0R0R2VVRGdsNkp0RXBIL2s0bm13cnNlc284SW9FNVlF?=
 =?utf-8?B?UTFUb3pMZmRYVjJkclRLWFJJeWRhZ2xXSHd5S3ZKb0ZJL0xrb1BaRTdlOVVu?=
 =?utf-8?B?OVFmSTNRUThCckdVRFRoMmVlSitVVVNoaVZhdnM3MDhRV296T29ES0xlbE9r?=
 =?utf-8?B?cnBvejNvSGdNaEIzUnI1MzdpM21RRXdhd0tRU21CZndLT1llZmdjNFg3ajJ3?=
 =?utf-8?B?bERzUVBlTWRONzNRWGtocVJJLzdnVDA0Nk40c2FLZGpXcTM1YjI5eGpmRFM2?=
 =?utf-8?B?ZHF2bmVqOUpVWjEyN2pGWnVPNzExKzN4R3owS2xvV3c3aFhEc2o1RGw2RWFH?=
 =?utf-8?B?eDVqN2VKMlNsMVhseSsxdUk2dXZUcXpIamM5OEh1T095bC8xTlI4VWFJaWN2?=
 =?utf-8?B?ZThWaGxyVzMwL0RTVzBiMEduY0VOWm8vRmcxaFZONytiTEVURkNIMThqdzU5?=
 =?utf-8?B?T0JBbkVYTlRzeWREZ3F0ZS9IaGk3U2ZCaVlwOHNtMHZWNnpIR24zcGVNZTFw?=
 =?utf-8?B?Qmgvb3ZmeHBxbHlCcWJtZnBTMVREOXcxQ2FZTlprZktwZTNGUzNzYlhQYUxG?=
 =?utf-8?B?dWc5TkdocnUyTTd5VmQwam9YNm01NEJ3cW1EUitPWVF5Wm5WdE92b2xWUWZv?=
 =?utf-8?B?alhQZVhwc0M1SkFGTW9wMFFpZm1JOVRTdWt6TWROMVJ2RzhpWFZzUExycThl?=
 =?utf-8?B?UjJFYTJhRmpJSGU2RVJNVjE3UjJmakJqQjZXc1hNQ0p1OUQxTEtpVXNDOVVE?=
 =?utf-8?B?QXIyMkVabFM5ZzAvNXBwbDdGbURRcktBZ1Z6aHVQY0xIZjlZbWN4OVhOWXFa?=
 =?utf-8?B?cTB4bXIwMUZpV1lSQnVvdHJFSHlBUWxkQ3lSa1NONzN6THh0SjJZQlIwM204?=
 =?utf-8?B?N2pNNmJSN0h2eEliUkl2YTdDRzJ4dEdLT3BWTE9jMGxhRmpsTDQ3UmlBUkNE?=
 =?utf-8?B?VitUUjljVVZrUzF2b25WY2UwTnd6ZDlxcXFlOGdqTEI2QjRTNDVBdzZjNG5o?=
 =?utf-8?B?Q1M1c2hWRWVzUXdGNm04aWtqWXplMlZkVmlBRTFvWXdMTXhDYmJwd0tjQTg2?=
 =?utf-8?B?ZEdsSkcrbmtsRC8wNVVmTlFiMzdnUEJ2MkNDK01hV3pQUTBycEk5c1cySHAv?=
 =?utf-8?B?d0o4aVQ3R2I2KzZkSHVOek8xZUplc1VCc09TU2NrbkZkWmxLa1p5dnJDNXBy?=
 =?utf-8?B?UHQyVUhPWkV5MVN0Y2hvM29YTVk0OXNIM3IvKzFPMkhiOTR3V1RSZHMvLzh5?=
 =?utf-8?B?ZytZQm5SbE1Fa1MrMkYwTkpEZVZlYllpMi9qd1IvYVpMa0pvb1JhdXFIL3hh?=
 =?utf-8?B?bkFJalZYSEFOclA4cFhsMTBmUTY0aXR1Z2N5VjNVNUpIY3E3eDBJZ2psemNE?=
 =?utf-8?B?cGswRkRaenk1QUdlbWJTUFB2c1ZjYlIvY25NaS93OTUzR0ZUR2lMcDZYd3BE?=
 =?utf-8?B?OE5YdjgxaFIxc2lCZlZEM3lxNVdzTVlEL0tNakQrV3B2dDVTL1ZheG5zZ1Q3?=
 =?utf-8?Q?5FYFGdEWZDhQp8vWrCPgFRM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0363ae3-a325-4317-a322-08d9df6bc645
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 19:00:23.6207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+i2oqGCb3TEsGsVZn9RMmS9h20UOAJmr3xQtRa4Pqsmz8ZNOJYDEM9ymIUQwoACR6D78mV1YVt5w4GR39bmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0265
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-24 13:57, Nicholas Kazlauskas wrote:
> [Why]
> A porting error resulted in the stream assignment for the link
> being retained without being released - a memory leak.
> 
> [How]
> Fix the porting error by adding back the dc_stream_release() intended
> as part of the original patch.
> 
> Fixes: 2e45b19dd882 ("drm/amd/display: retain/release at proper places in link_enc assignment")
> 
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> index a55944da8d53..00f72f66a7ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> @@ -122,6 +122,7 @@ static void remove_link_enc_assignment(
>  				stream->link_enc = NULL;
>  				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
>  				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
> +				dc_stream_release(stream);
>  				break;
>  			}
>  		}

