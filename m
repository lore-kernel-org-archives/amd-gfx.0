Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE53C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6637B10E2DF;
	Mon, 29 May 2023 19:50:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45F410E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtFezQ0F3qvr76EY3pdiNLbZ3787yw1+jlPuxghKOjy1kxxBwcCiJBnD27M+YK2+JgvtTz8Kqb1UD8lMNOPKbzvRTp3WWHn1jnF32x2yLIwEav0jKxwU7PGFIoLzFiO+2A7yoGFkL39+br+PznVefdnpb12/AH7GqFRktuOzo/Bm27qZSOqCrImGJPHttjIxF8mZGIox9SxoXyumiKx9Kzeu6cvQXLlNM8Q0t9qYXt0H4cu4FXLHEi8MjZqeUfz8UCz9SgVubIb4SbTcoWMdxmPcXYued2PZSouhaMpZWP2fzaIrqjFYP7JMXSNkbC47tqABW1P1WAiXCMvs4gr1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY7sy6rpdFSfJYhzinyBUEk7sLmIk8wCVNRNw0m9X6M=;
 b=ngPBztxNkUFxSkybP01gswv0DV2PKy/8BE/vd2Wg2SZpFwb0dK6W0YOr3TIbCnIfPAYQdU19itiYE8ON22SZeif5N9gl0BNftVhfJteWtZspUwHyh48olsI+Z+504icZo1gL4N7GYgbr4J4pWEOonLq9RzEdzI3jczym/V0NQg14E/2yYvvY5fTt6jS/G2zXxxnOfcUq83R3Zrf1fjVOBs29TOMYUeNt0HG+bvw9X4LY713+A1QFWPMM5CzeNSUGtGOvLF04MuRDmGtsmhB8TPbsYp2Twg234Y4wRQmdMQqnUBrr5uuXPtWNcffGVZ8IyjD4fzCTWAYll9oJfMRkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY7sy6rpdFSfJYhzinyBUEk7sLmIk8wCVNRNw0m9X6M=;
 b=DkLNF0lHS1ZzT+gmJU3hoAn9NxkVJG+28UoRkJhybgP7BPST+z4Fb00zsWHp/BsHZVOac98GGI3z8Midm4QVl+eORKCfYahyEZcF/5TdCuVyrvcZaMY/J8l638PO4t10PwU8m3uaHtx64n2aX4Mce4dgqf/Nyjzqb/eS43ywKR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 19:50:13 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:50:13 +0000
Message-ID: <a1139c82-9664-216c-0815-d8f1b0cdf491@amd.com>
Date: Mon, 29 May 2023 15:50:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Add missing kdoc entries in
 update_planes_and_stream_adapter
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20230527142503.1465145-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230527142503.1465145-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::18) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7922cbbf-16f6-48e0-9e6e-08db607deb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxmbzRvimOqWw6qT7DxBmruWDQn+vptnSSeYnakbphmmaZe04BpEEnCe+Yy6Sxyfbar7QAEvahes26ANg47uEKYwzxaYmi7iK1T7Ze9ODRJzxPY+ktY4RhWpA6CFOY6W8eKsSRdU8+JkAVsUxxZ5BWRf1iQqg8PIOQ3xvz1km4/5Gih8KfRvZXoIPibz3eOp+fUKayupL/nI7+ehyGjTTlVHe97KNGFIOAv/kKlfokHWJdnOnCbCAN4BZ+KDpkMHmxQpUoqS89mqQROXSbCfElXTcMfroXrQgnUL9+LEZ5NNIi1ztZBk424mCVd4XoDuhmZNE4pQ4uXNsXQq5YzjwipOf69k/TtEzWiDdkSZdhi+y7hxT8XE4sNO8IkxWcZ9FqV7/wq+XMEghJWGfr0doFWxgn+OPmJWg2qjhtkNgKRLEfIqi6u8Z/AT2pPEM70IBpphj+T/AqYjuV1dlb5XMyZWbbQSl0TXcEBS/5DFSkIfaVE1RXNTZFXkXrAH9JNkodYkcUAWm4KxfqWZb+PkjaO4YZYMxwPLeyIDjhyj5pjUWzqsUEvfYHOU5bQaCWuwuUpYbiYpz85zKCK4mJfoWXSvncTRGqXqB+BxrIAj+fa42FUh/vt5hQfPgdduVjBQZiB4ujcVzWavZmmO7oY5zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6486002)(2906002)(31686004)(41300700001)(38100700002)(15650500001)(186003)(86362001)(31696002)(8936002)(8676002)(2616005)(110136005)(478600001)(26005)(53546011)(6512007)(316002)(6506007)(66556008)(83380400001)(6636002)(4326008)(66946007)(66476007)(36756003)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5QL3pnNk56aEJLWVdILzdPSXhUNGhDUWowRVRxSEgyM2tGcVVjbUluT2JS?=
 =?utf-8?B?dU1Qa3dydUZueGh3QmcrcHlmeHYzZFVZL1R1aEpXdXFpakNpa3FMQk03cmdY?=
 =?utf-8?B?RW9CbTd3MUlCM2tqSGRaQ0M2NVhrLzdyRlB3bVRJZzhSS01BNmdXdyt4SlZU?=
 =?utf-8?B?NVhvM3NlREs2SEdxRlBsZnVLSXZlRGZobHVQbFlidGxCc0dJWnI5SGN6TzM0?=
 =?utf-8?B?TTgvY3M5d2lYSkRhWWh0VEtEMCt4bFBjek03UFF2cUk0Um1iZFF3SXBIOFlu?=
 =?utf-8?B?aFE5WENQcXErYXFSYTdETFkyNlVxaDU2ZWJjMTBoLzVMYkFjUWVMSTMrK1lW?=
 =?utf-8?B?MmQwVGk1cGpZdUQ3TU5FOFVhMC91VzJUL0JENWZCbUpHMVpadVV1QStvRUR3?=
 =?utf-8?B?Tzg5NlJQdEwveFcrSEJHVWcvL1VScmJUaG45cXpwOUpycTZOeS94K1NrT1g5?=
 =?utf-8?B?YzNvNHZweSt3Y09zVk1ETzhBZkdrNnZRVzRMK2FQTzFUekR5T0lacVRSV2pM?=
 =?utf-8?B?U3RFaUVDVjVZZiswTVpGOWcwNk0zWHZCNXptOEFacVZ4TEZUanM1NXBxbWR2?=
 =?utf-8?B?M3RYYmkvS1lCWmRNS1JKSmRtL2NFZ2VvQStQTThsY1BxN3ZXa3ZBek9kVzlV?=
 =?utf-8?B?T0VsTzZjS1NFYkhrMUY3Yi96bnBhVjQvRXdVNmxUVk02aTh0UHpSZm9MUzhD?=
 =?utf-8?B?MzBOTzZxOFZoNW1OOFhnT2U1T25NbE5nbW5QVVJqZExWS3ZjNk9Nai9YUmsx?=
 =?utf-8?B?OUdXaGRPOXJOTStpWFdtb3FRWUdCVStHNHhvWUJndjY1M0hsb21OTFdmZTR0?=
 =?utf-8?B?K2l5MTBDWGFFTXJpUjRtTWdZcnl0QlNVTXlYS0hzSmdTQmo4L3RjZjd4VkdV?=
 =?utf-8?B?QkxyWHlwbVZDejlOOUE0TnI4TWQrSlorV01TbHlvS2svTHlrZUd3dGN3N1hq?=
 =?utf-8?B?NkY2cmpURHQzcDFmV0NNTVhaV3N3MnVReEJnZWNoWEpidE4vRDdQbnMxMzZo?=
 =?utf-8?B?YU1xSGZtWU85bjdJOVRkZ0FYK0NxV1BwckdRbURpL0JSQzNQRjZvcHQ0SGxh?=
 =?utf-8?B?TG81eWY2aklVNFRSa3EyWllhREUyZjRMU1Z2VVFkTGdoY2xlZ1llVTlrRmpq?=
 =?utf-8?B?TGJaQjdSN3dqSUR2dXRHL3dOWCtlZlVBbjRjYlhTUmJHRU5KYkIwVFlMTElr?=
 =?utf-8?B?a2taSFMvT01KL3Vub1Jyamdab21UV2xrOXU1K2IzYUF3V2p6ZXJEdEVKTXBk?=
 =?utf-8?B?RTQ4ZlBNeThWVGVrM0RROWMvUDVaV0NLaEwxbXZIRy9PNGlrc0YzV1BWeDUw?=
 =?utf-8?B?aHBuQnp0YWVmZy9od1NJa3lQWURQMlAyaTZLRHFQRzR1aG82NndMMytkSkpD?=
 =?utf-8?B?OCtYNk05RHN3VFdCSFFWZFBZQU55NHNIMG5VOXJQN3V4d3Ara3dzOW04TFpF?=
 =?utf-8?B?c0hWVVFnZ1h2bWc5UTRYMFFGQi9VWlFJSW5lYStWSnA4ekIyNjRHYlU4aXFz?=
 =?utf-8?B?cVJpblQ4cTN3Z0hMdndaNDU5d1NOcVArdGpsZ1YwMU5KQnlVU2ExekpkKzVZ?=
 =?utf-8?B?Ym5XaENHQjhCQmQweUNiSTlVZXZDamFUN29tREFDaW8vSFVzNFJzMW40S0Qz?=
 =?utf-8?B?UVZjcmFJRFR6eU1RRFpvZjFUdVhnZnUzdmN4WWFhczFhYlFkSW1lYWJaRFEy?=
 =?utf-8?B?dTBTRDFjS1NESkdhME5seEZyOVl6dmZ6djlmTFlmaHBCbm90UHVoRjJCbGE4?=
 =?utf-8?B?dmV4c0VqT2V4eE1kN1lyRXZ0ajNtVDNwRkhvaEZMQ2p4azlTU1pLbVhiYXYr?=
 =?utf-8?B?V0dKRDhpQlhEN1RmNGhuUHdOWjk1WHVIS3c2Yk5CbEFmZ2s0dTlwUjlZckFz?=
 =?utf-8?B?T3NtVUFHMHN5QnZIckxRV2w2UTNUa1ArQWxpS0IyMkVaT3QxK2lHbWd1bVpq?=
 =?utf-8?B?d1A4WU4yLytNVDJLVFN4S3cxMittVlFDUENhT2drbG1uSkgrQjkvWldadnRV?=
 =?utf-8?B?QWdscEZkc3dRQmpRaW5ia0lnRFRScWxLdEgwN01tdmZSMzBYMWxsRENsNlZ2?=
 =?utf-8?B?NHc5MGlqdmdpVnpObUczWDZybWR6RmdIU2hncFlpeDhtekJnUHVHZkYraUJx?=
 =?utf-8?Q?vwHzpnlh/FQxnxxzZUyUeujMp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7922cbbf-16f6-48e0-9e6e-08db607deb13
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:50:13.6302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pDnBBXYWUGp2ZJMMpyFYxpsOy19+IOi7FGh+vvq494/9aFtu3q0DCaj4VQcbVu15c+oVP55titmL6RXZuOXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

This patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/27/23 10:25, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'dc' not described in 'update_planes_and_stream_adapter'
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'update_type' not described in 'update_planes_and_stream_adapter'
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'planes_count' not described in 'update_planes_and_stream_adapter'
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'stream' not described in 'update_planes_and_stream_adapter'
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'stream_update' not described in 'update_planes_and_stream_adapter'
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'array_of_surface_update' not described in 'update_planes_and_stream_adapter'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a69f4a39d92a..90de0d37f1d2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -364,6 +364,14 @@ static inline void reverse_planes_order(struct dc_surface_update *array_of_surfa
>   * adjustments and preparation before calling it. This function is a wrapper
>   * for the dc_update_planes_and_stream that does any required configuration
>   * before passing control to DC.
> + *
> + * @dc: Display Core control structure
> + * @update_type: specify whether it is FULL/MEDIUM/FAST update
> + * @planes_count: planes count to update
> + * @stream: stream state
> + * @stream_update: stream update
> + * @array_of_surface_update: dc surface update pointer
> + *
>   */
>  static inline bool update_planes_and_stream_adapter(struct dc *dc,
>  						    int update_type,
