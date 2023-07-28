Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34061C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 05:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7943410E64A;
	Fri, 28 Jul 2023 05:36:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1131610E64A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 05:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib4DPjDfFkE64RcTY7Eg6ur2oiYBs11LjOHNBaAU1Ls4DWRflX8490DD0KLcLC0k1pcDQFwdTY2S7ekR40ifgM+2KkjZMascZDf/kcbTZRhCTWWipBH09KI2HVE4gyOWEpEGD6w4Tp606ZM8krXAI8xmUIiTtYPYWRPi6afx5/tMVSS6TMyNywyldAO1ma6kjcWyNeOgobWBwSO8q53xNdfui8Yjz4FSEdoW35AGlnTsC+WWiv3Nyy+hnqajAUX0Gkh7mAwNKfIziDcXUU/4ok5jvtuyzucpGKdA7b/gRMNyMw/G+djN2M6WWT9WsTvjr667MBuvOwtVg8Om0VJYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN6PBj9TkV1Z5RsMa5ycnHfSKRKHWP2IlM5Q6WjeNhE=;
 b=JDqmYkaGWUNgjQ6Hd5A6wDH8QlUQ+q37rs23AnK57DY7Fl+RMiNWa2dovHaTRm1PkeXvCEHGgbqJwN2EThBZ0Sv0XRvE+rxVTj6Ji90y+IDGZxPNfVaK4urmC7Om/Q2yb+iXgGzwtc+4y+WVy9OlKAHBNpjD5a4nGuU5dsTsR7FPz3zmp07qP4vqPkK2HAKzAXI3EzI8CxIRsbYb3Ajaz5j1oK3NoT6nRB5AyeMSf5kS3yhJFq2l3g6AURZyn/Ln7zAuKR0hFwnQARYPrFzFvuPiMou8TBm7JHH2MIF7Je6YNJ8ThtF0mVBKqPeUFfrkXD9Az5t7t1BX0Hy2ryrdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN6PBj9TkV1Z5RsMa5ycnHfSKRKHWP2IlM5Q6WjeNhE=;
 b=QvZYPL2uFLejGMcEI+MJ0ytuTG/XV4HPgbzDk9oZJ1uU33L2p192R+NZTwA942fcZ3rGRj5CQiG67OzsbZGyyXEmCVkliqNv7PgOrQJaAX0ut6jLAOziYxIckt5s0s3n31Vpt0yDGb9URFLPOCHT2CkxfToZjpphr2hAfnlkLig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:36:42 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:36:42 +0000
Message-ID: <f16d7cc1-3896-21bf-a3b1-82e26553f670@amd.com>
Date: Fri, 28 Jul 2023 11:06:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 8/8] amdgpu/pm: Optimize emit_clock_levels for aldebaran -
 part 3
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <20230427062718.1172269-9-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230427062718.1172269-9-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1c8b90-b7cc-4a43-cf5c-08db8f2c9f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0uoX6qUurVL7zoadtzGSlM/kZKvnf71CWPt5fWD/Q1onI3zGFV8Fhk5rINrfMoZuPTQQZFBWKmoST5M15TsXaDZjHE1FXca0PtKmONc4+NoxN6VJyLNXvCx/d8VezPFxBNaZyZM1eGkpWkkG1xLd6F3RBHb3X4JnHMeK4LWznhYLkp5qL9RDFAncvSaz9bFwo1/CQH4XLsKlIFM88Ai8Y8zFnWlskF82+0lAXHXV7EDAjB1UL5Qsh1eW6C+yYsRznRD2HCIos744vAee6ybmQiVDsd1VyJUG9MqWrIESnt6WkmHxyipPKaYeR55dCN8mXBmD1Opoia7YYwZws9QvuOIwI/xwXf2Fwql9lgNv5ASZb3BKj/Z1JaWxsQ7V+r9bsCNTz238/HDQ1A1bbWiAjxPR7OoSKxIBGJaT3KeCodDme0G5FWgcoI4GMEJN+61Ao5Nu2G+We4aX+JD40StYXmZShby4LdSaSTz7ZGKmhFRopqzrrnwZw9QWUxoDVHn0CnrHtoUt4DC7L+tWHwQlUcS4YGLD8jrpKNGLsv2aaEgRCel2pYLV6DT3OdpoyVQxN5u0q+7c/ylyVmG2j+1RiqlaELiLI59lGdeqt9ASbFu8qM5Now//EiK52S1RblNIvxnacmtT2d6A9ennFvySQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(31686004)(83380400001)(31696002)(478600001)(316002)(8676002)(8936002)(36756003)(41300700001)(2616005)(2906002)(86362001)(66556008)(38100700002)(66476007)(66946007)(5660300002)(4326008)(26005)(53546011)(6506007)(186003)(6512007)(6666004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdvSFlRb3A3ZEFQZFFjdkx1U2tObUhuWDFVTXp5bGp5ZlhNc3VJNHVJQkk0?=
 =?utf-8?B?SDNGdVlzRG9pWldFVnR5aWVIUzV6ZjVRaVIzclhLZVkxQy9BMHpWUFlRVWEv?=
 =?utf-8?B?d21LbTRPUURGZkJpY2tCSzVPLzBybWhMdmpkeWVzUG1NWkZkQnorT0FhR1lL?=
 =?utf-8?B?SzlPQ1M3TjZDcnhaSkx3Z2s3YkFlcDRNdFBDVzV5eGdTNW9adDJUdElZbDV3?=
 =?utf-8?B?OG1sWVd1U3lpYWdWd29Fb0NONzhnQTFvWU5VMUlNaDYwVmVkcFo0bHQ4aDg1?=
 =?utf-8?B?d2RNdFNDN3ZDQTB3SWh6b3lYcE9LYzNTa084cWt4OVdoVHY0NlJYVllWTi9v?=
 =?utf-8?B?S1YrR0txQkkxM2MwblZ5TEZ6aS9rWVBTN0lIT1BDMXNQV1hHQzBVbklsekFz?=
 =?utf-8?B?VTZzKzRvSXVGQ3VZUWRTa05CdnI2RUhaN2JMTEMvT1ZGOXF2dlJ0aDkxVW1O?=
 =?utf-8?B?YjVGUjdVQXZiZS9wYzY5dFRFVjN1M3pVSGdYYmxzVWZHV2RISkN4U0dSQ21i?=
 =?utf-8?B?akFGQlM2VDlMckl2V00vYXBvMVBldk5PRjJDT1VwYUtsWmlReXN0dXJraFk5?=
 =?utf-8?B?MHI5NGc5eGQrRktUWS9tTjVJdHNxT1NMakVDN2xkNmQ3QWpzeGdXQ1duODhH?=
 =?utf-8?B?R0l3L3ZrQ3dkLy96TWpPYUVuM1lyYXhUM2thcXY2TWlMVzRFUzY2V2pZZHhY?=
 =?utf-8?B?Ti92U1RDVUVWclVMV0N5NFBxZVVkaEt1ZkE1SW8rNjBDanQxdmMzallIdUU5?=
 =?utf-8?B?ZXovUER2dHNOdzVKa1JvdzgrNm1NNC91OUM4ZTEvZUJMZGdEK0tHV0trTUUv?=
 =?utf-8?B?MERBajhuOEsvUDY5c3hYNHVtNHMrRVAvbElGSFhpNHhtZ0NmcVVNaGszYVhV?=
 =?utf-8?B?UU9UZzM5S2ROamZvU2lpcjBzS0NmZ3ZtSlh6KzY2VFMxOTdsV1hWSUJjWko5?=
 =?utf-8?B?d0tXYVVXSGFYQm5Rb0ovTjloSzlvL3pvTFU1SkJaNEx4OGRNcTVWTVVhMjE4?=
 =?utf-8?B?MnhtVmVNTXhOa21IYWVaTDhUSnBUTGY2MkhSVlJPcGdoQ2hBdHZueWZWNmtm?=
 =?utf-8?B?bHRObk53V2dkdjRwc3NXNE9Bb013Z0Y2NDdSTjZWWkptWGQ4RXZTSkwxdmF1?=
 =?utf-8?B?cWhZdFJ3cGIvODAvUmIyY1kxcVpWaXdUUVdpYmtON0RMdTExMXZuNG1LZEQ5?=
 =?utf-8?B?Q1RFL3VUOXJhWnF4U2hGWWxOaG8zNU5ScHIvN0ZFazNQcGdjREUyY0pMcTdz?=
 =?utf-8?B?d3J3RmNuZ2tPNVN2M09QYkcza1RSdk1HVUR2bTFaZ2RQVVNVMHA1VURIbk8r?=
 =?utf-8?B?NHZra0xGb1hlWlFiVGpOcGxDaFU2TWZqVEQ0ZndVY1MzdUZGbDlmNkVSSE5B?=
 =?utf-8?B?WVZiMC9qTkdvejJ0Zlh1QjVaUWRmSmFHTXBQMEJYTG9hK2pMaW5Za0lKZE9T?=
 =?utf-8?B?YnVnVlpOTUJHN2k5eFliZ3JqVDM0cVI1OStJQS9sWE5NVnZpZERZQ0lkZEpn?=
 =?utf-8?B?VittbCtpaVZSYlphNFVMZ1plMkpjSTFxd3E0S0NSVTRKejdQaGFaa2F2bUF4?=
 =?utf-8?B?a2E5TnlMOXVLVlRxSjBQZkVzM1JyUEZQYlZLUDg5LytEbXVhK0FPeHZlU0xm?=
 =?utf-8?B?dnQrQ0xZQ2w3QlRYZ0EwY1BsM2VrcVphMk9LOXorNXlQeFVJeGdIZjZHcFpV?=
 =?utf-8?B?dGc5eUNMVm5RVll0T1d5bTN0MitZNUJGZmtTQmlRTkxDeVJyR3VZVWR2N05j?=
 =?utf-8?B?ZnBldEJkR1RCQm1aZFNkYWhQV2FSTnBHU0dmckl6VGEyai9CdE0yaEtXNlQ2?=
 =?utf-8?B?aXVkeFdsZmY3N3RpbzZ0YlVtUUh3V3lNTERFSVRKYWYzNjV0MUxpQ2hjTVBB?=
 =?utf-8?B?WFFsK1phNmxtWjVHeXVvYnNjL0trenBMbDh3RXVGRHVlUFV0cFcybWlmYkJW?=
 =?utf-8?B?bENTVjUwUWJCSHZBcGxyYmo3bklkai9teUpCTnlSZStUZmtBNWExRFV1RzlS?=
 =?utf-8?B?SElVTkJlMUhrQW5BRmhvdkFrUmhXR2ZVRDlnUVdUUzl1RFFtRG9uRmUxT0V4?=
 =?utf-8?B?RVhIdXBQVnNmTThiVmJCZHNCMnU5Wm1BbmxSc05PMFdWNTN1VXhHNHc5QWNQ?=
 =?utf-8?Q?RgZQxaqm+VdfwLXtu7UNp6CmO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1c8b90-b7cc-4a43-cf5c-08db8f2c9f23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:36:42.2198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HBIWm12L6AIZU//Ye2EyISKp41kRimaZZHDgHTsVDIqJ3NNQVW4TD8kzmcjIyNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: ray.huang@amd.com, evan.quan@amd.com, lang.yu@amd.com, david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2023 11:57 AM, Darren Powell wrote:
>     split switch statement into two and consolidate the common
>     code for printing most of the types of clock speeds
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 82 ++++++-------------
>   1 file changed, 27 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index b315353adfdf..9d37800bfae9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -788,17 +788,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   			freq_values[2] = max_clk;
>   			freq_values[1] = cur_value;
>   		}
> -
> -		for (i = 0; i < display_levels; i++) {
> -			clock_mhz = freq_values[i];
> -			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (display_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
> -				clock_mhz,
> -				(freq_match) ? "*" : "");
> -		}
> -
>   		break;
>   
>   	case SMU_OD_MCLK:
> @@ -813,16 +802,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>   		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> -
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -					i, clock_mhz,
> -					(freq_match) ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_SOCCLK:
> @@ -834,16 +813,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>   		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> -
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -					i, clock_mhz,
> -					(freq_match) ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_FCLK:
> @@ -855,16 +824,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> -
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -					i, clock_mhz,
> -					(freq_match) ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_VCLK:
> @@ -876,16 +835,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> -
> -		for (i = 0; i < clocks.num_levels; i++) {
> -			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
> -			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> -			freq_match |= (clocks.num_levels == 1);
> -
> -			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -					i, clock_mhz,
> -					(freq_match) ? "*" : "");
> -		}
>   		break;
>   
>   	case SMU_DCLK:
> @@ -897,21 +846,44 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
>   
> +	switch (type) {
> +	case SMU_OD_SCLK:
> +	case SMU_SCLK:
> +		for (i = 0; i < display_levels; i++) {
> +			clock_mhz = freq_values[i];
> +			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |= (display_levels == 1);
> +
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
> +				clock_mhz,
> +				(freq_match) ? "*" : "");
> +		}
> +		break;
> +

Similar nits as in arcturus patches. Keep this as part of original 
switch and below ones as some inline func or goto.

Thanks,
Lijo

> +	case SMU_OD_MCLK:
> +	case SMU_MCLK:
> +	case SMU_SOCCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
>   		for (i = 0; i < clocks.num_levels; i++) {
>   			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
>   			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
>   			freq_match |= (clocks.num_levels == 1);
>   
>   			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
> -					i, clock_mhz,
> -					(freq_match) ? "*" : "");
> +				i, clock_mhz,
> +				(freq_match) ? "*" : "");
>   		}
>   		break;
> -
>   	default:
>   		return -EINVAL;
> -		break;
>   	}
>   
>   	return 0;
