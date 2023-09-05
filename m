Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFBBCA0FFA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE54510E443;
	Tue,  5 Sep 2023 18:49:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8428D10E443
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJoreIc4mK0IqjmlqzJ8X6U3FqW+zThIBrL+/JJ0J9gxSLedDhIofjtl0+FEjp0NsxjRxtwZwpQm/3IDsLxX8ExaI/Z6xq29VDCIEO29sP8CyHHp24hcO/HXImR28kStjXhkF9Z9TsoD4J9d+QhNQw0a32MMow35aXrvCKOIAZzoQFQm4aTpAEyHuWykPM6HsoeRvveRqgZiHwyapeE+bMP2c3RfA1xOcYJta79IkGNRF8Yej62xoCQbm7U3KSl3F23qDinAt8K5WLYrLxHZn2gWEmT0bN7E+345W51iVf0VM72Vakc/AZ3Ab1/ySDsaRp4wTEeQSnI3WxP9mXUAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDrnEoMV3Ij7jaND1xx4PBukpFuTqWAlcGa3wPg78K4=;
 b=DfnSfRDYIowJysNolROEwR4S3Ay6pd+oABluo0pi4gHumqwpoj7fxz/ctzxlwVibdvi22nOVUkSGi2n2USKUt1appO/urPAqe/kd8s+8K1DxSBzTdEjtH3cJ6ynBvRv8BewTonQ5L7yvqpGi5/j/fHXM3AyMf2Zhnch4Bprw/dcV8I6aFoDHoxYPrzGGwdEegKgs60SkUnPBETPohx+210EruEhus1Mya9cgRQJfrQwnJ5wFfHzTxO7wZhnJcCKeGIQZaNvsjVWCMRtdoJ6bh9PyaPIwDC2APV9JXaZ+vg6uYGwkP1KXqBgI9KsPalt8lI4tTuzavVSGIsQz3WvIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDrnEoMV3Ij7jaND1xx4PBukpFuTqWAlcGa3wPg78K4=;
 b=coyUWSXFF2CtSCtKJY9WdtH6IWz7n/QOpxV6KSLVNq/WA+X1XdQ1SgW2i17PvmiBndEX1YPuYhO0FQ15fVH7tfmNZiETQy2WRCGF7wrSLvVtlGZUKXWZDV9pGA1/vZK3JXK9FpbPWIF4xbM+tbwGbzhvAxI7PQfiqW++G+4V1f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:49:01 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:49:01 +0000
Message-ID: <f5728a6d-bceb-d27e-6421-7bce004d14ac@amd.com>
Date: Tue, 5 Sep 2023 12:48:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/18] drm/amd/display: Create fake sink and stream for
 writeback connector
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-10-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-10-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: b66f3c71-65f8-4b86-655f-08dbae40c500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqTOeeZ/jObNqcKBr0eqZpWw/7XOaxhtnDxczXcAI7fOPNap3zBSVXN7KjRZg8jhZ65snoOgF+XWBZRpd2TjeyndZHwk9WrNqjFDgxZFfKRmoPKq1oif0aAdEKQ0gnPyInjmq3eh9RZ2VGv4hETompNQKZE/81KUnoVXX/Xe+ZueBxL0m7jslCTcC7Kk0gzWzl2OwG6xU3UdrHcNP+w876A+laX526e4hqkVRsED9/iUYO6qT/qMk/fzMkHynb6vLcftnSI/VaVeWfVRVWG0m1gDAdfWDQyZbtWRxvcqH3/CxK4t18Khn5AJPXdq7pTLLO0vwas3t/syyp/Ekyf4pQHDoPC20D9mJKse+xb1YZCXba96DoD81bQAulntJFL9uC/B9NuLBAYkjXTjStnCfdlMC/WrbZvu/oUExw1LmvqXD8rat4AJXLPfAM2gfn+6jzlQH4x7vdFEY8S1exPKkNdrBFikdakDSKFqF46eYHzh2I9PiQWUQKjq9DJ5GnWD0kJr49kgz2JLnjVOZK0WRheOvcAk8X4cMYqfE8vCbXUuDG9qlUMkt2TArNPJaDP4b1nIjVEQ0TtNiW2ON6fJO52sTECNac9nvQbsN3YxbSMtz1yTQ5VpInekodHaZVJiAPaDEnrEPcOg1J2vddkKlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(38100700002)(83380400001)(86362001)(478600001)(31696002)(6916009)(26005)(316002)(6666004)(36756003)(6506007)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(6486002)(53546011)(31686004)(44832011)(41300700001)(6512007)(5660300002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFCUzBSeEh3Yk9leWJCdXhFME1ZeFl6N2g5bnZvZUdTbkQxMG1TaVFyNEpr?=
 =?utf-8?B?VnJqejc3WHJJNkE2TjU4SStBeTEyRk9uNUNyazkrN1Bid1J5M2I3Q1JmN2ll?=
 =?utf-8?B?Qk1WMC9zbjNRdk1DbzAyQlFhTXVEdUNkT3JBRWh5YUsrblM3OWk5ZXJqWDRD?=
 =?utf-8?B?R2JQVkEyR0tzRGlLUHpFK2FJT3o0ZURSVUR3eWtTc3g1QmwwT0FUb3BhQ05w?=
 =?utf-8?B?eW0rOEgzbWlSZ3lRM3NCK3VIek85aFl4dmx1akJlYUE2ZWZkTlFRblV5SzZI?=
 =?utf-8?B?QU1vTERoWTlQa1REWTlOM3NkQUJtOFVKTmJUNkJyd0czZlRrQTZjdDNQdnUr?=
 =?utf-8?B?QWgrWFZxQzJEUXA0TDZrR1dlZ2ZHaVlIQXlBZUpRQ1BaenMweG4xeXlhQm1y?=
 =?utf-8?B?RERHZEY1SGxPc1hRcldGck9OZ251SHVaVmdTekpLYmFvS3AxYnVQRThRaHR0?=
 =?utf-8?B?MEhoWHZhUVR0aEhrY0V2OUw1NW1lREMxaVEwRjB5VXNtVmEzYTJhOTZQd1FQ?=
 =?utf-8?B?dkNHYUU2aGdKTFpXSWlwT1FJdWEzTTVYMHl1aDJmQWkwaU1hTnJOYTRHSlp3?=
 =?utf-8?B?UUxXditPOHhTZjhvVXp4NVVoY2hhdHcrQlNjdm1QVjNQcU1QOWZPRmxqM2c2?=
 =?utf-8?B?V3V4ZThkUVdtSzQyUU9XV3o1R1FPWURvY3V2V2kvV1JmcmxtVU4vVGp0RDhM?=
 =?utf-8?B?bDkwY0ZBVXFKY0p3OWdmMno5a2R5K2pOVWJFeDIxYVFHMXdSUW9TRzc5Rms0?=
 =?utf-8?B?bG5hakxMMHkvMVhXS0hGRG1Za3BmcmZwUTVzdC94TTk1Z2FVaWhYYklnOFor?=
 =?utf-8?B?T0UxcGY1M3kwOHRQcTJtd1V1SjJOYVkwVURrbkU0alFXWnpOTmE3Y1crVU1Q?=
 =?utf-8?B?RnFONkhXdGIzTDE5ZGQ0UWFDdnZlM0szOTk4N0wwN0RxaUJ3MHVqMEl3Zjgz?=
 =?utf-8?B?TDVuUG5MdjNXbHh6WTJnUHVnWXJ6QnloTkxzc3Rna29tVEEzQjJLWmN6WSt5?=
 =?utf-8?B?bklIdFplWDdKbjJmTHBHWkJ2aElyTlNxMENERW5PMjJqc1JvODBUWUUwMUZi?=
 =?utf-8?B?N1pkN3IxUUs0RDc1a2s3NWRJZ0hGdGZERFkzN2x2NWd1MDQ5c3QzM1AxeEdO?=
 =?utf-8?B?aEZSZ0JsMW5LSCtqbG1YSGpsOUo0Sk5XaG1BdHpEb1ZkRFVGWTV4b3gvNktp?=
 =?utf-8?B?ZDJQSExvUWRNazVlTm52aE9xbncycHZ1VzBZamkrMGw0aW55enBQa1dwSTVw?=
 =?utf-8?B?NGMzTW1Ld3FtVjlJS2IxbURMbnlFSEU3RnlZMVVtQU50Vy96QUY2MzNIRlZn?=
 =?utf-8?B?Z2lqVXYzdjdiVWtWRFU5emdwUkVhRHB5cXd2cVp6ZnJzaSsrUlF3VDdMWGlw?=
 =?utf-8?B?dDJKRjZUbmRsK255T0RjakVkVGFZUEd1MkgwU2x3YzhZbWUzUk9RWnJGT3d4?=
 =?utf-8?B?dUg5cEQyNGhYQVYzeWFBWGRzdXRHNlFKekxlS3NCOTFQSDJRZ1VJRk01TFF0?=
 =?utf-8?B?L2dwaE9oR2JNcjgwTk5hMDhWVmJ3cHpSdEJtOGRvU29nZ041aDdWcE9pQmNZ?=
 =?utf-8?B?alo0WVdyWU1peUF0aUVZaE5SbElWMFpGS2RjZk5RVFVBMW5Ea3c3NjU1ZGhI?=
 =?utf-8?B?bVY4WStyZ1ZWM2YzeU5PQVBUL2hVdUZ1UnRXUXJnUFhSYi9GSU1pUTR1SzdF?=
 =?utf-8?B?MW0vQUEzN0kvYWVrZnp1NWZNUFpTUGlmWGxYQTFYZzlIRnlQcm9WN3FoSXRB?=
 =?utf-8?B?RERKWDByUTAwazhtVmhUUkhLSHh5eFBBdTJ0amtUQ2M1U2w2Q0JXTmJVOURJ?=
 =?utf-8?B?QVZnc3UxSHNRNzNWeDU5QVhmSUhmZlUrck83OE5lYU50RVdMU2dvenM4WTln?=
 =?utf-8?B?Z3lDSVR3K2srVThjL0FscXZMSVRYYjUvZ3lFZG5kbndaWG5tRVJCQjRDSUYy?=
 =?utf-8?B?aUlWM2YzV3Q0YXl1RUNhaVdwdUNjVHBTVllmSmRKL2gxbjkxb2tzeGlJRmZ2?=
 =?utf-8?B?TTFQbjFueEFCY1NBNDR0dUxzNEpzZUdqN3BOVlVrN3hVT1RFNjNHajJtdWI5?=
 =?utf-8?B?SEZwL1V3djIvZUN4Z0dERTdKVzNjS1pvVmo5SGlja01uTnVBeDJJVDJOQjBr?=
 =?utf-8?Q?Mmv936mcYavFOVzseQ8Xlg3mG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66f3c71-65f8-4b86-655f-08dbae40c500
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:49:01.1207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjD2noqnjIEXklB+bzFVxe9YXbN6ol7rSQwTJRL5MzAwByy+YBpCL9ug+hFmaVhjqUzz1eHeNC8IbMFl3O2vOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHAT]
> Writeback connectors don't have a physical sink but DC still
> needs a sink to function. Create a fake sink and stream for
> writeback connectors
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++-------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b12e8393fef3..82f00af14ada 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5611,13 +5611,13 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
>   }
>   
>   static struct dc_sink *
> -create_fake_sink(struct amdgpu_dm_connector *aconnector)
> +create_fake_sink(struct dc_link *link)
>   {
>   	struct dc_sink_init_data sink_init_data = { 0 };
>   	struct dc_sink *sink = NULL;
>   
> -	sink_init_data.link = aconnector->dc_link;
> -	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
> +	sink_init_data.link = link;
> +	sink_init_data.sink_signal = link->connector_signal;
>   
>   	sink = dc_sink_create(&sink_init_data);
>   	if (!sink) {
> @@ -5988,6 +5988,7 @@ create_stream_for_sink(struct drm_connector *connector,
>   	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
>   	struct dsc_dec_dpcd_caps dsc_caps;
>   
> +	struct dc_link *link = NULL;
>   	struct dc_sink *sink = NULL;
>   
>   	drm_mode_init(&mode, drm_mode);
> @@ -6001,14 +6002,24 @@ create_stream_for_sink(struct drm_connector *connector,
>   	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
>   		aconnector = NULL;
>   		aconnector = to_amdgpu_dm_connector(connector);
> -		if (!aconnector->dc_sink) {
> -			sink = create_fake_sink(aconnector);
> -			if (!sink)
> -				return stream;
> -		} else {
> -			sink = aconnector->dc_sink;
> -			dc_sink_retain(sink);
> -		}
> +		link = aconnector->dc_link;
> +	} else {
> +		struct drm_writeback_connector *wbcon = NULL;
> +		struct amdgpu_dm_wb_connector *dm_wbcon = NULL;
> +
> +		wbcon = drm_connector_to_writeback(connector);
> +		dm_wbcon = to_amdgpu_dm_wb_connector(wbcon);
> +		link = dm_wbcon->link;
> +	}
> +
> +	if (!aconnector || !aconnector->dc_sink) {
> +		sink = create_fake_sink(link);
> +		if (!sink)
> +			return stream;
> +
> +	} else {
> +		sink = aconnector->dc_sink;
> +		dc_sink_retain(sink);
>   	}
>   
>   	stream = dc_create_stream_for_sink(sink);
