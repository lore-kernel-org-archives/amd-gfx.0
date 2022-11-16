Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D050C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 21:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A3B10E506;
	Wed, 16 Nov 2022 21:19:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296B610E506
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 21:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8CTZIZuk0znHcPC6dYqV1C/QIp7/ypa9bHI+yAWT6C1tGoVnNGZUHmFd2utYuHebn79KQBuleENMgXiM7MUiYrOft/ripPemQfJptgChmHz7goSgY8svV64yQMUOBZQAIO2WYWKpo0ZbVYIyYCx0VYUW0v68eJdfR1Mb7iVUxwvbNU1VdWJ28hegaDgcgI70qK9+n5kYlBKs60BxwtFctOZVCQibYDdX8vUdqtk8ijoyFtbcJH5tfF26nZAIVluFer+OAdM0RWT7Egp5y1rgY7HnWBShTTf28K/zE0a29Bk07GtBMYazRg0PDdf3y1+RCOJjhn+/JBIAss9m9awbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eM7BsDp2DHWPaw2U4nSYBeyRLetAAE9tgXLQDTe9I0=;
 b=M4dHRUQtDancpq52NrEocGEleGvDAAmZag1i9Zfenc5j6oQir5Tk7melwSBiH6AESuqvyGLQU2p7t2H6zd83bguxaKFsMY2qQZtbRn8mvi4tX41wdNPxZzAxiqgtejrmEJ5uuEVLGwwo1oJQYYKAQSJLnbzUzBhvZJ+nod1SbV0uQma/EplZUg8jeom36tzDEkCgyztgDFUrKevAcCQNElDAnqDuDtx7UXrroqzAm9YIRd+EDLG1pZpgegucD/nxReUh/q9rVAXVic/hcdrqwJ2VTWywu3E/mAvo0gkauTunG0p42qLnyJX60Akq6Xj0O4FfWCt56tiZJ8E45P7IUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eM7BsDp2DHWPaw2U4nSYBeyRLetAAE9tgXLQDTe9I0=;
 b=PJVDljlPH0Zz5smm59tj9GBalV2365/WeDmxJs6IQcl/nyfpWBFhohbkzg4EFfszrEBvXPAKL38Udkxdb+vvH2pdrDUSCF6fePFWKgSDnmDPU684b2SPI0atcvv+CMZ/QHFjH1JJ4tD1VFGNuoEzqC5TZG981Vmc+eTbN4xe83M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 21:19:13 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca%8]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:19:12 +0000
Message-ID: <359260ca-f319-0449-81e1-f24e9dc8a7d3@amd.com>
Date: Wed, 16 Nov 2022 16:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amd/display: fix the build when DRM_AMD_DC_DCN is not
 set
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221116165810.2876610-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221116165810.2876610-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c651e-52f4-49bf-d035-08dac818351f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgzgJrWeSmIoCGYidwGyZOEGKPapPrEDxeU1JxcGsxo61qyaMRI5u1td0YfModjDToW+TSoEDT8XtMDm9iNuO6DX4YAxIJK0Ikh5ZGIgtAQs8GzSSgQyfRHeC5v8EqYbNwu3kuK321gj9CGTC30JUWul0NMADqFLUTatgfSF2aAIr9BkaVO/rT4saOcDTGKA8ytHbC14lS+7KOhMPpGQBl1wt2UOZ27kNMOF5wvFb4eY1CAvt4emR9LFRSCjX/nECpoEOFpsTn0ijHwSBLuwX6IuzJ0wIs1fUmPjUL0ODHPYvcEaThC0PS1E0rEa4nHVsK4KSguQ/26NtSPeohezdm1Q4d6RUbJzmbY7GTaFBod5oeK5uYO3vAShzWd+SwscXvV34DzA+E9aZSd6wlQwPNLp6hdXOMzSOvnZs/lCnlc7ZfKeGE707Cte1dfW1j4aBPnBurZbUjv+oZkNF+i+c4PI60zQIGtmQLSqneBaFoSvxYJIrxRVF+Lou5DRqALDuLTWqTJ7zmj1tYpPdvCZVHO6ySsFBpnj1FhIAOyofhgVM2bYQ8yyHe8m4MTCsJRnQZC5S8yfVRgvea6njaCk+AZr6l6Opck09k1/Zf5++RFKIG2H7tVDIEoaZlzMvjZOm1ZiKRW37U+6l6KeDNpfXalIibnYwIdk4Rmc2ufM4gszaV30Q3nejgSIxlj9ZVV0IQgI5g1epidgTYo1Olg8S7GrieNTeMJ4aBVDk2J1ZmI6oFgBJ0M4HtjGaCF9XZ5NafAx1Mcd6MYZEPlAgXHQY2fkoQmXYTYEuW07j1rX4yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(26005)(86362001)(31696002)(6512007)(53546011)(316002)(44832011)(83380400001)(2906002)(41300700001)(4326008)(8676002)(66476007)(66556008)(2616005)(36756003)(8936002)(66946007)(5660300002)(38100700002)(186003)(478600001)(6506007)(31686004)(6486002)(54906003)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDIzYmlWRE1RZFhmdkt3ODZMckJvalQ0aWRnZWlPZ3RkUXVySlJPYnFacHlS?=
 =?utf-8?B?OWJmOWZCb3BzSE5lSE9pNU1GdWJqVURRUWlyNDBuWWdEVS8zMCs2aDZFMlow?=
 =?utf-8?B?aTNiVVZhYmp3RXUydzFzU2xzdVFhRXRsUHp3SVNDUnh3UGlHdXNyK0hORWpS?=
 =?utf-8?B?MnZReW1LUmYvNDBBN01zTG1SSEIyZExWbTV0T3VLYzIxcStJMWQ2QzU1TUxW?=
 =?utf-8?B?ZzFiOXpmRzBKY3lsQVI4cFRjTDNnb3ZPdHdWNFlwNE5mUzNJVkFNTmJSR3Fq?=
 =?utf-8?B?QXhDWE5yeVV1a2p2YjNlMUdLRjhnSDNNLzBJNjY4SG9mdFc3TlowaDcvNlQw?=
 =?utf-8?B?eVZUR0pUM21rMU41S2dqaGhEdjVWNW1hYkY2YU9yd1ZLM0RTRzNaTkRUZEdD?=
 =?utf-8?B?bkxxZUErTkJYaWF2aTZndFM3M0FJZ3JZUkhhMzFINTdLR2o3cTd0WXhXRmRO?=
 =?utf-8?B?RGhwMGVVY0l6UzIvRnFJT2kxQWtFeE9zRmJaanNBR0NQYXBKSHpUcEJ1Uy9F?=
 =?utf-8?B?aXlObDg1R0toVmtRcDJZZ1lZRG9JSmRobjNia3FDTk1Bd3k3ZnZrVGxjV1pt?=
 =?utf-8?B?VU9abFhVTWtnSVV6WnhTTXFicm1tUlNIOGdZMkM2RDc4UVp1TkNxK1RNT1lK?=
 =?utf-8?B?dVErYTQwT0VoTFZxUzJTWlZ4cnZlSmdjTU42SHJpWkVnb3dPZHE0TTZXTW1l?=
 =?utf-8?B?czdkNGh4ejd1NmxhdjduZmVueUNsWFgyRkY5NXkwbEZETDlIOHF2MEpZblQz?=
 =?utf-8?B?V0ZrR0wzMWNjdE9KV1E1bDkwa2FOYTYvN2dRcVo2cGNDTDNTRjUvK0xoUXpl?=
 =?utf-8?B?ZDV3aVpNcXRidXBoOWFqeklZUnJEa3NoU3hSR3NzeVNlc0lQVHhFZzVJb1ZY?=
 =?utf-8?B?K1pMQVh1ZTY2TW5FUFdaQU5vc0tjWHFBajhLVFppYjE3R1ZwNUxaQ0hRaVJL?=
 =?utf-8?B?aDFRcmlTVHlMVysrckJpMm5JRU1vZHJGY0dXWWRwQUVrZUFMVzloMFNYWVN4?=
 =?utf-8?B?SCtVam1ROFFvMUNPeTJSWm1lWHJYeWN0ZGVUTkpGOEQ2aDRCNk9iRTgrTThu?=
 =?utf-8?B?b2F6TE5Wbm1JMUpLWG9vNXRXU1hka3loZlhrTmxsSTVMYnlzVlhYWndCQzdV?=
 =?utf-8?B?OHlkaGtVaWRreHZWY2VMeFNmRkw0TXFyRGZHandKZVByaVExTHI5WGsrekQv?=
 =?utf-8?B?Z0I4aUJZK0FuVndKV1laTlJjRU04dzViQ0FxTHNmd05DaURtWEJRSWNtb2VB?=
 =?utf-8?B?cm5VMVpVVys5Y2tMdldUbE4wd0M4blNjWXFCNTBCVFhwT1BsbGtYVnVaaUIv?=
 =?utf-8?B?Q3R4WERNNzZ5Mm5BY3UySi9iMXlEcEtiZ0tkRWNJc2tpL20yVCs4NkorNjJ0?=
 =?utf-8?B?YjhENUZYa0FMY1BQVVNGRE9jL3doV3BzQXA5RzQxQzZiL0N1Ti9wNlN1Q0lG?=
 =?utf-8?B?eDM5TWFGTitHa05Mcm1ucXJqZHNUWFA2d2tGVllZZlowV3IwTGpZVXAvTTAv?=
 =?utf-8?B?SXhOMmhnYmtBdzhwcG9MRm03dXBPejNuNXJrSmhYWk0yMTd6NW5PR05scERU?=
 =?utf-8?B?UlFHVU9IUWdkSWozUjRxNkhTVFdGTWNkcktzeFdtaFlhNlpJSzNGRFVZNUpK?=
 =?utf-8?B?a01Pb1lqNndXd2ZGMHAzVEp3MWpBYUFSM0xyY3RpTm1JaWt4Z2dDV1ZLajhZ?=
 =?utf-8?B?MC9NdVczZWtnenp5TkE3SXhsUWhEQUY1Q2NoTThMZEpOV1NnMGg3Nkc1cElZ?=
 =?utf-8?B?V1BtRnhqKzJYaWpKZ2NZOUVwWFlSZERvMExEcE9aZTZ4K1oxRDlmZTkvdnlx?=
 =?utf-8?B?Q05iQ1hrdlZjeHV1ZDUvazBQYUhrVjBuNXo2NVpnK3hTajBKejdneFVxcUVy?=
 =?utf-8?B?VEFUczhweEVMK3FGYzFjclZMQzJIaHhBMTk1aFVYL3BOVzRzVmhDZkNEZGZy?=
 =?utf-8?B?M00ybk5hSG1ObUFCdjByb1RLS2RWQzJPTXMxUXlMYVNVOXdkWDJpQWxyZDJU?=
 =?utf-8?B?c1BUOFlYVStrc0oweVYva1ArNDRWSmRzWmt2NWNqdjhSWFd1dzJZYXFCMkx3?=
 =?utf-8?B?ck9zdFJ2ZFJ5RkRvRmJyMStzdDY4QzdwaGlQdXdGNjZmWW81WEQrZ1ZFSDdw?=
 =?utf-8?Q?WHv3Zhhlh+LRcRaYgI2Smdmrc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c651e-52f4-49bf-d035-08dac818351f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:19:12.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JXJujQB6WAoNiIZUMU28D/CdfHQuaiSvAW3PtWxxYa9jKqNFu4ByYxduU2I6MUmlUs99tFwc8yvt2s8UvP6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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
Cc: Alan Liu <HaoPing.Liu@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/16/22 11:58, Alex Deucher wrote:
> Move the new callback outside of the guard.
> 
> Fixes: dc55b106ad47 ("drm/amd/display: Disable phantom OTG after enable for plane disable")
> CC: Alvin Lee <Alvin.Lee2@amd.com>
> CC: Alan Liu <HaoPing.Liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 43eb61961e0f..0e42e721dd15 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -184,8 +184,8 @@ struct timing_generator_funcs {
>  	bool (*disable_crtc)(struct timing_generator *tg);
>  #ifdef CONFIG_DRM_AMD_DC_DCN
>  	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
> -	void (*disable_phantom_crtc)(struct timing_generator *tg);
>  #endif
> +	void (*disable_phantom_crtc)(struct timing_generator *tg);
>  	bool (*immediate_disable_crtc)(struct timing_generator *tg);
>  	bool (*is_counter_moving)(struct timing_generator *tg);
>  	void (*get_position)(struct timing_generator *tg,

