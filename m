Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E4BC7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAD610E243;
	Mon, 12 Jun 2023 13:23:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FC210E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 13:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur2DsYajbE7CQuIbNgPJlDx/H6dWLzASpcmYjvwINJYr9l/T7ysyHep7SGvCw9v/3BHGu0mu52x1W3vzjjDXSvuHF5PW2PlAto3A5W4fhG2vjePrvFT4pei4HCHqxSfPBmVjk5ZWOWjpAwQBkPFluiYyB3uCm+aBSxBh8eVTKm61XMvdqcJEjaw/LP4sLwCTL4zlqn4M3rJ7WgXdYEx7K6vZUaYv009lUTiL3zP9IoXZ3cZdECNsHov5OpQ7KPPQiisPPLnOGy/XC5W0hFPmpVHIgPxIyMixQGyah8D9yHA+DRruwzlFEt/shxMlUFLcrYt15z9GwQjxd6GoQIgZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5boK8cvkdmEJccFr9l2sQhu2vkc+K/DhIZfWKmjWBZ0=;
 b=brz0+IejyyjlwdPuoONo4KZZtuOfwmYUSe0FyFhibLCBcziiM6kYDXTqdMJ2btNLUXag87hzipkgTcb4nAlnA8pawNTFT3MJZLSw5Ab2/+K8QvwQ05Kn01Ub0D9YKw4ki29uYvDVSJ7yYYOL0M575as+vBrTJM93S1BS1VHztXcPUN5++/jaTTDTAnx3oIB3HtW6lauOu+hcq1QVZzbeuwXM9GUaERivzev9hBaw9h8gte2F5d3SIDbgTy3HwtNDhbpFlMAtqKgsFticjaXQ0LIPi3a/jwcOou9ECcfp8x5a6rtXnA7LhU+Q9Qh2q2ePx6qVzbsPkHtQhFScKV7sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5boK8cvkdmEJccFr9l2sQhu2vkc+K/DhIZfWKmjWBZ0=;
 b=MiUq3KAaqxJ52Ml0qZnrgA6CMY5lL83jJahF4mcVadi9wRt8an2eCSUIoarUKZf0AeJMqdvBXPWdiqdgSE6wGujd75uvcr6fbXSpxYxzgljZefUQdJtorOXxlRO0pzOgNebOsNHlUkcnIevgwRsuenM8s3UJmmmDFNoUpviIBoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:23:50 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:23:50 +0000
Message-ID: <3516bdfb-5e3b-bf07-39b4-2e3682327d87@amd.com>
Date: Mon, 12 Jun 2023 07:23:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Add missing function parameter 'optc' &
 'enable' to kdoc in optc3_set_timing_double_buffer()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230603145347.1940243-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230603145347.1940243-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0510.namprd03.prod.outlook.com
 (2603:10b6:408:130::35) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f39fb9-48b6-41fe-9094-08db6b4842a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsIjX7hyP0Ig+2W4xtJcbVG/mF9eL1/UbrceGOcetaymgjU54G9chyRgBQQsrfkfVny9aX88nC1hlZ759GHGMWt1ml4iTi+Bxbdmyem2YBHRLDAaop/nkxxKShHncZ70xQ/cFDVJ6F7ETf2sbbF79k+O9nP7mI6wTaaVrLbWI9kH8L8fhA/T1WGgGAnjb/l1A3BWrWt5oQg/93naPSqidqczZzHYrvoYzDge54u3waJXqF/+rG7YpZGGicaZ/AaoaDJzUGJdUEF46VsZUnC/mt4zYgd4tDPLIFSkzsXIkzb/pBm5l5NHITY6EgmJrmdqBohZXt88zcrXBdlyDD2X/utVlC9JuKwLKxJxdT6JnzZgtWuP5LmyDKv24sg8Fwnt+aaJzlz9gHvQ3m36DlhuJKbNIt493uC5BidKKssYidSd8UJTBcYkbakyZ6LrTreGqqP1gOWUsjzi81FSB+uF2lfkuHTBBBAz4IaoNxIo1Q+q6/UlxYDObO+/YLLK4od/syaINwLbc7CoMMexpPHe3fBK0DSs5Vkhx8o4ciYQ9mNl13DnDX4YnPMhpyMjSYAwXi7Xo8zCSsEU9uuOCfQLTX7vnRIGGEInVkWKJCh49Bn38hwXidDuklEu8b8+4myDW2y9cAYsNmtPqyiKPiJZ8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(6486002)(83380400001)(36756003)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(53546011)(186003)(2906002)(5660300002)(110136005)(8676002)(8936002)(316002)(41300700001)(31686004)(6636002)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlydmJFR3BQYVFPM2NTODBPOEVvYVVlazgxZDR0ZGRHSkZ6anU1SzVEWmVI?=
 =?utf-8?B?eFZTOXhkUVFmK042Z281SUdoZHhtamZmS29tNGdvTHhHd3V5Uk1nMHRlNnVG?=
 =?utf-8?B?U2JLNVM0VkVreldEQllhcGpsODNoSTZxZkZOcXpyd0VlU0d3eittUTJ5cEdm?=
 =?utf-8?B?U0hzL2cyYkVObGNLZzNDd015SjdOZFlTZGpGQ0NUaE1wV0wybWx3N3N2dE8r?=
 =?utf-8?B?UklGS0c1L2hDOEJWdEJoUEE4VUY1VE4yeUZ1RU1xNVMweHd2Z2wyanByMjhE?=
 =?utf-8?B?cWRPelNjUUtwcjRvZHhmeWF5L3JqaHl4Wkg5SUI3SE1ucG5TQlhvbVAxNHVv?=
 =?utf-8?B?ODkrbkVBcDFZSzdPSEZMcXF0TmhBTm9jQ1RydlVaRnBBL2lyZ0pNbGZFMVFJ?=
 =?utf-8?B?SjcvR1FTK3hhajQyaFI0MU1xYmN5VHhZMWQ1ZXY2Qk8wc3ZWYjUyNGYzeWFz?=
 =?utf-8?B?RHYvdlIzQ0Z0ZmduR3lzK3lRUGlvcS9ndFlZdXdLQ3VNLzkrcksyTFpKS2xj?=
 =?utf-8?B?cHZDUUJabW1oZHptVGxYM0pUQ0p2ME1OOTBjMUExRlY1TzlKalNaNUtOeTFx?=
 =?utf-8?B?MU1tMUFOQ0xnNG11YmlTaDdvWGYvQzAyc2gvS0dDZGdZbDYwKy8vSGxaV3pY?=
 =?utf-8?B?VEJHUjRVblZCVjhybGZQaGwzbzF4dnI3STczcWhHT0pBKzUvVklWNVZkN0p1?=
 =?utf-8?B?WHRSMGNqR1JZcFlmRlFzeXZWTitDYlhZdlhwNEFaMVZnUWFhdXFWaDJtU3Na?=
 =?utf-8?B?cmtMeWlXKy9CNGYwODlaSUNrVnVjS2lzVmc5MHRDU05xOEJHTFplU3U4OSt5?=
 =?utf-8?B?YndEZzhRcHZKV29XVlA5Ui85Wk9LMi9WN0txL0EyN2JxRHBhR1M4eEx1K2Np?=
 =?utf-8?B?aGJqbzZPWmE0Q201NndUMHRVb2RqTXRPRGs1ZFk3VnBSYkRPQWtwZmxGd25Z?=
 =?utf-8?B?ZXRTNEZxZ1BKb1VUaFlVMHlvYUMySkJ0eVBMem83emMzMkJBb1dOY2tsZzdi?=
 =?utf-8?B?ZTUzdWhvaGZydlFaV1pkOU9NTFJmTG9vRi9KNGNvdi8xU3A5amovSG4zTkVu?=
 =?utf-8?B?a3NCa2tDQ3lDRUgxQkw1UGpYaXl2SElmTzl4VDVlUlRnSE9QbnEwRFdRdVU0?=
 =?utf-8?B?T3k3R3dRUU5vVzI5TUphejVqdCsyTDJyako2eUdCMFV4NnlsZTY3S3g0a3h1?=
 =?utf-8?B?RU5qM3loTjVTZVBPNlNYanlvZFF1LzZVU3gxQ0NLcFp2OHJUMmZNRzlWekZl?=
 =?utf-8?B?VU1NRUlIbnFWOThTa0pjRHpkcGtKamdLOURoc1lrTzZZa0cya2djTFNXSnlt?=
 =?utf-8?B?cEoyYXo1aE1kVWRjOTlGOVdLa05ZckMxQ0x5MlZBdTdYdTNJMElYYnV6SlBx?=
 =?utf-8?B?a3MrSm1FUkhMWTBqbHdjSisvSit0VmdHY0pEczdweWg4Z3dkdmNUYklWcGRi?=
 =?utf-8?B?QUFqTGVqVngvV2hGWU1VM3o5SUIzOWlwYkdSckhFK0FNY0srdHo1UnJ6dWdt?=
 =?utf-8?B?VDVZMUptZ2NPNkkzM3pCb0V1QVRSdjY4NW95bHpKdWl3M0g4THA4ZlJRMTVq?=
 =?utf-8?B?VmhNb2tkQ3c0Y1dJRGRHeDVaU2VhbWRpY2g5VlJQSGVERkcwZ242blQ0c2Zy?=
 =?utf-8?B?OVUzUEpzN1phU3VLSUtMZGs3NmU4VHFidEw2WVUxWE5Wdjk4a3d0a29SVXFJ?=
 =?utf-8?B?ODFjdFpRaUpZZWxSU1VLUjJxZWpHUE9LTFhESW53ZkFUczUvWW1ib0pDWG5L?=
 =?utf-8?B?Mm5IQkc3bHVUQWNibm8xdDZTR0ExdFZwbGdpenZEMVl5R1hyQ25LQ1RDYnBk?=
 =?utf-8?B?bjVUeFc2NGZhM0JuclNIQmtENFAwQmkxVlZjR00rVnNaTy9waFMvcktxQjNp?=
 =?utf-8?B?aUZXUkdwT2VGNHBnRllEWlFYbHlSZlRodS90d0xPdkFuNjd3eTFicmxJS1lD?=
 =?utf-8?B?UHphMVVXYmtLd1FzYmRtOCtoQkZicWVRNDdxclVqT0QzUG5acXRPYVFZcWcx?=
 =?utf-8?B?NThDYWJyajdFMXlHRkJxTm5TWW5OQnVyVkFKUzgzZFFYbjR3VVU5NFAyWURZ?=
 =?utf-8?B?VU1xYzltaWlNblNod0dmZm54R2FuMTFremJLQitnUU5ReTFtMUVhYTR6QlZy?=
 =?utf-8?B?dncwbis0UVJzRWg5SmN5WWJMcGpzZG14OHlQK2taM3J3LzNQTXVmMFlhNnVK?=
 =?utf-8?Q?LT942B+mrnAKSbmaSs0qyOr6BgeXLpgzeSaifTM9eXw/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f39fb9-48b6-41fe-9094-08db6b4842a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:23:50.4323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeRnbqZLDEVC7Tg81ovkdcERotcxlH8BTHB6pGTPI1ORpY9vDvJsTr+WG4IzdVND4ruhJn1pBuwr5qnoiBCO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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



On 6/3/23 08:53, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:285: warning: Function parameter or member 'optc' not described in 'optc3_set_timing_double_buffer'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:285: warning: Function parameter or member 'enable' not described in 'optc3_set_timing_double_buffer'
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index c6f5f3df8061..dfb8f62765f2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -279,6 +279,9 @@ static void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, in
>    * Sets double buffer point for V_TOTAL, H_TOTAL, VTOTAL_MIN,
>    * VTOTAL_MAX, VTOTAL_MIN_SEL and VTOTAL_MAX_SEL registers.
>    *
> + * @optc: timing_generator instance.
> + * @enable: Enable DRR double buffering control if true, disable otherwise.
> + *
>    * Options: any time,  start of frame, dp start of frame (range timing)
>    */
>   static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool enable)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
