Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478FAC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 23:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3313310E340;
	Mon, 21 Nov 2022 23:12:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDDA10E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 23:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzA5f9gEsOcLEMsnuO3SBfgsw17MHHr5DaErzFJ/ckBc71tqZt1Y+eXlOTRUOJULpxS+oJPyLY5HPXUDisjBwPfF7arWB6xC8DkVZasP02oFwxDGzLZVzkYvQHiJ77YVnHr5lF+7V0XnHX63Bk9+7mGLCjsR/oqtf97JdZFFvc9Jx5WUE6KUVtvIPc7zNOctn2X8FfPtOpT9H3pKvlGejHYmNoT4IfwpdlX2FlK7DuFBHdVRa5MT3D9hyoom2vt/1iuS9Pu4Sl714zibEpdutZ/NgJTiO16DUvajEnZ6TJsHA0atkNdBelHRcAz1WtzSB68SiTFm/x2CsC9osEpTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEKu3Wzet2ytPeXBlMKDNGIEuPjPsQapd/QAGeaWj8c=;
 b=eYzaGfkkD58dX3VXfoXpEnAhX02Wll9kU2aRIEjOR383amQ5Jx/8RUy8JQSX5cdIWcfFoGhSGRRUMuQfOO6zYf4fPbqLTlZzihcZlzPBmdIjt7tppAt7qch4Bf6JUxE20Y18pxuPeQyB84o2QMbowDE6s8Htp5uZLiPhbo08WlZslsaO4dJ3U0JtskPkLAE+rccqTo8Uw9ExfJw+0nJIf67razPAPw58n358qz8wlKgf7NsnyeX3T8PNdsNQ6upARyUg9IyXGZC5jvb1gH8lHjzNaE1Sa27hxnfdEgPNK6h7Svlz5o4SosfGiXsL+F3FYksqt5t2pUb1KJc/5JvW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEKu3Wzet2ytPeXBlMKDNGIEuPjPsQapd/QAGeaWj8c=;
 b=ZNPAQluKQdm22BYYaOwnSq3HsSUUoEqFZiYOQK/7QdFG23QTd++OiiX/QNy+U655b1A94eCJPbva+TVYUfgP/l9Mjb0zqZILpOwAg10eACpxdiPNi8doID6rFjfW9J675FCPA5NGcA0OoBflplJW1P4h7jaylZAotdrlcYFQguc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 23:12:09 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 23:12:09 +0000
Message-ID: <cc41415b-1df2-2ca2-d060-693791cb50c5@amd.com>
Date: Mon, 21 Nov 2022 18:12:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amd/display: trigger timing sync only if TG is running
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221121221429.4040398-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221121221429.4040398-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:610:74::22) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 367679d4-b750-47f7-d698-08dacc15d086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyMQE6AE7tu8Mcrdsu01vNwuYSXuqufMgeFaRjkpWv9ET2isuuzVvEito0+lJznjlFLXTOURTFj8ODAHC+SW8f+NQXsnLkBEVIDPC2eTIrXU4khSiIpMy2ny19pjG0ErqDDvwIhzZui97NOB3Je1q0tD0u977trWB1r5rWXrdJZ9Lrv56Skuv9d5YKuKLe5YBjxWJrcGVjqtnqXa5DDs07XmZXVKOqKP10TVifCVOqNc6o5r24tlolNdwMBOrjrpEzLA+hEesivs7C1ouAxXAMLPOae6hfy4X4bMtKWf7oS2947galVAbMNeOrdI57R5w4x+bDabH6u5mNpXtP5dg8D8YTqOT1pFkDf9kx9LRWEptVQTdfZtOlkrBTZe2eGmXCVZdWVAS1ZpbKulOAX7l0VuwuY8Rp7Q2afEru4/hulrwm8meDZKhF1aZmtR1N0KUvmo0MhGZWF0r8V/W9WF1RECu6++9dQzFWdCfCJO3iDGcatRZch57TjDFm12qLkk6EgNA7o3U8WCIzVJLBG41GPXV0UFVw9FzzmxnmEZ0dAafVhFhO6+BD9n/PS/ZzFTcZIY0X9EQie5iQBmH8J5+H4u6BnDfgrfeUp4HWFFc4rfpSxywT4Mb2hWoL3HHPtJjnob3pFG/dKIpuWngZy2UqTxRH63uSeijB90toB6DlU0FaSx65MNqRa0vDLokYs72W2mfkHqfT4US6K4i2Jg5yrKqzW366jwpfXquf9/OR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(5660300002)(316002)(6512007)(53546011)(41300700001)(2616005)(6506007)(186003)(8936002)(66946007)(66476007)(36756003)(66556008)(4326008)(8676002)(38100700002)(26005)(83380400001)(2906002)(31696002)(86362001)(478600001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVybDVxd1QxZXloVUdUL2FLYWJrOHpTaEk3U0Mrdy90TWM5SzdGSHVJa0dm?=
 =?utf-8?B?T1RUb05JK1I4VC9hbUlBb3pDSkJkbzdYdGhFYXhlR3NFSXYwdHZFWTZsOUc4?=
 =?utf-8?B?NUFpd3NjVWMvK1h0SnUveWZDdHN1eVZySFl0SjNUSWhUYzFQaVk1Mk5uZVBK?=
 =?utf-8?B?LzUvbzZOTUFySjFxL3krZFFtVy9PNU1tWjU0QTloWVNONWZWV3grWElzeng3?=
 =?utf-8?B?blprLzB0a3JIekVQam1FMlNhMGxHaU5zam9LTURPU2ltYThuNVkya05jblNx?=
 =?utf-8?B?ZkFHSHJMSUpnQTRjZXZrdFdxeHNZTlhiZ3hRVEg2cGVVTmMzVlhjUllzYmpi?=
 =?utf-8?B?MHRnWTdUcUtnM2w3Tit6WG8ycjJocDdFczRYYzBxOUEzNGhJam5qWUhxUXpi?=
 =?utf-8?B?dHdpYXJldjhGZ2Ftek9LcWxzb2tnZkIxRm93Qm9FRXg1ZEtXL05ZbjlhVjdC?=
 =?utf-8?B?TFJrTXlGQXB3TWhwYkxpcEhqckpBTUJVaFM4SUUyRG94a1FqNUJidlBVODdW?=
 =?utf-8?B?OFlSQ3pIeDJMV0I1MUxpNWZlMW9UWHVWOHZheUYzK01QQWdyNmszUTBuNzgw?=
 =?utf-8?B?aVd0ZTZZSlNlWHlHY0FkeVBzZGl4cWNrZzljRThDL2JHZ1paWldZZVlVS0pz?=
 =?utf-8?B?RDNYTGNLWE5La2ViYzRBbTQvT2t5RjZDcURVaDVVdStUc2o5byt0aSt6U2ZG?=
 =?utf-8?B?NGR3OTR4cnZRMllkbHFya1JWbStpVVFpaVYrZ0ZrTVpQQ3RkNVdOejIvdDFh?=
 =?utf-8?B?WWhNK3loRXFsckpUbVFFRGNSQUcrSFVwcTM4MUFXQ1FNOGFtMG4zZUxFTTBh?=
 =?utf-8?B?L3BVVGlvcjlpOFgybWx5MHVnWGtJRHVDWko4bFQ4Snk4QkZETHMyei9XNm9M?=
 =?utf-8?B?ejJsZG0vWk9UNGQvTHlSa0hIaUlhNmpJOFFMSFQ1c0JQbUJDTHB0SzN2SUZl?=
 =?utf-8?B?b2tJTXg2Z0x4VUtOUU1VdDNkdHdxbkZvdXNCb05zWVhEM3ZhUE1obGlxb0hO?=
 =?utf-8?B?SytWK3ZtbGpVZHR0WkJjTXh6MFlWbERickdFYWlxNzcyZTZ3WDBmellLcmMr?=
 =?utf-8?B?V280TC91NHRPNFllRnZQUGJrcUZLRnlOWkZSTXNQZFVkU3pndzdOVVVacGFV?=
 =?utf-8?B?LzllZ0F6V0tocStkc2dJczNkM21WdC9UVEFXeUNWcVI3dm9oSXZ2VE5MblJE?=
 =?utf-8?B?VmlGVll0blVqaDV6djN3cUZqV3pNdWxpUXUzL3FMaWRTZ1UrYjhkbm9RTkxx?=
 =?utf-8?B?azdIRUhGNEx1YTlSVTFHYkVWdGREWHp4R1E5MHBERWNka0hmU1RlUTVSbFB4?=
 =?utf-8?B?MFBsWEFhYjQxUUVYaUV4b0szNW85RnVDOTVscUJTbmJ4Y0xWTEJRZHQreExR?=
 =?utf-8?B?WlY5TUtja25tRlZOdFp2RG56RnIrbm5EWlRvSGZFd3RJSUFZRkw5RzRIUUh5?=
 =?utf-8?B?U0lzakpwNDZMZFlycXpwWnNFdE1mMEE2dmEwS0lyNEtPdDZEcUlPdVM5UEdK?=
 =?utf-8?B?RE5RcmtWNDFvbVZsUDh1MjVsNUNYS2dlUHRxdkI5RXBlNHZYVnQrOHVvL2Y3?=
 =?utf-8?B?YkRPdEVrOU04M0hjR25heVVNOTZpcmRQM2o2ck5jejlmUEsxczdBcDdvMWM3?=
 =?utf-8?B?OWM1L3BVUEsyeDVkaUV4OWpQTmZ3YWRxQUUyQXA0UVlyc2kwbHlTeWFIWTVp?=
 =?utf-8?B?YTNSVHFXSHRHRnZYZ0ozVkFnMUx5bVI4Z2tGTnY5bE1ybzc1ZW5kZFM0YXdl?=
 =?utf-8?B?SG0vYWc0U3g1TStNdGozVSszSjUyR0x1ZEJFV3pPY0ZyY3duNVUvSjNMN2Nk?=
 =?utf-8?B?YzFPa24yNCsvOFQzWGc5TlYrcDVFNHdmc1JLSEczVTdqRzh3N0VNTTErM3RE?=
 =?utf-8?B?UDZNUHErSkFtUFpsMFNEZHpBRUZpUmZyRmR4UWxpVXA4RTNhaU45Y1R4bkU4?=
 =?utf-8?B?cUk1WUhRUlZVSyszbkQydlEwMnh5WEp3NVVyMlhnb2hjOEZiNm94c1BkTGor?=
 =?utf-8?B?YzB3VlgyNDJaTXdPTWpSQWM0alpvaGE4ZmdRcVpkTnVsUTR6a0t4RFNDMDFm?=
 =?utf-8?B?WEVvWmlxVmZUUDFhaHBLR1U4QlFMNkZwU1hKS3VBV2p2RXY5UGxvaUNGU21s?=
 =?utf-8?Q?YKJisQj2dtYNgQS4ilCRicKoZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367679d4-b750-47f7-d698-08dacc15d086
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 23:12:09.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAtOyyxr6LFYgzltw3zGv4biI6ZMbmUKD+AEdpdwxKDWN0GMywZ43bJVw0vpygAX1xK3qj8WSJnGWt1jdUmIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/21/22 17:14, Aurabindo Pillai wrote:
> [Why&How]
> If the timing generator isnt running, it does not make sense to trigger
> a sync on the corresponding OTG. Check this condition before starting.
> Otherwise, this will cause error like:
> 
> *ERROR* GSL: Timeout on reset trigger!
> 
> Fixes: 8c7924bdb0fe ("drm/amd/display: Disable phantom OTG after enable for plane disable")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 587b04b8712d..0db02e76dcc5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2252,6 +2252,12 @@ void dcn10_enable_timing_synchronization(
>   		opp = grouped_pipes[i]->stream_res.opp;
>   		tg = grouped_pipes[i]->stream_res.tg;
>   		tg->funcs->get_otg_active_size(tg, &width, &height);
> +
> +		if (!tg->funcs->is_tg_enabled(tg)) {
> +			DC_SYNC_INFO("Skipping timing sync on disabled OTG\n");
> +			return;
> +		}
> +
>   		if (opp->funcs->opp_program_dpg_dimensions)
>   			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
>   	}

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
