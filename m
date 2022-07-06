Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC25C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 14:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A13010E2E5;
	Wed,  6 Jul 2022 14:54:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D7610E2E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 14:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOKyLsk9XMkG2BETlAuakoHd+XTrc94FOq4ansTl8P1yUrt5vgGeG/gYh8FYf3TlWNvozMyX/y8ReRH6tjxcNA96U0CINIUJ95Gt7FEp7WN6m/WlBmSERl6gDK0um5vB3A7i9SnYe1Gq5WYOn/QQlVGuG30j0qepAMr9GARB2FDbMwYMWyIG2NWEbFE6LMwac5TvrD4fpMpYi0DrOvhMjh3jd9I0tNWiWeXnI9ljIVDkqGgE/K0XXGA3tKjdV+V8QW3KwXH0tYrW1xorfcAvfc0D0RKLzfXJMWMhSvVm5XMMDCb49KJ+62SBGzPJLM8cQw68rQ7EBzNCYpfw75Koqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgqJYauGDSQb4qwZbGLm7RwISXkKy1RttcgaQN7KSgk=;
 b=UqOhBqtsJanIwg45LLmdN4KWH/A0RuPurGtacor4r8mbJ+7pVb7W0ZKdMY8o7cXvtVzs0HFipxK8bLeAddLs5ok3zA6UX6W+68H52PZ2wC32CSYGWEFvERQh/IkErtYsnTWtiVuxpDN+omo+XzD6ZTndKFJWK9ue40q+/BNbZ7+dCxWOK9hJMAYMssax9r6uufoNsvQ/bxFddflbaxRw9ZcxYk6LS6IdsKJ0kjl6qPx5hwrHfWE1Whc7+moTGtfGigwHfxlFCqC0NgwPHOrA0G+etAs3fPqKFL1FbTwb+a3bQX8NzOqY5XsTnN47Xhyzp7xuL9MnCLoZdIZ0DwnRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgqJYauGDSQb4qwZbGLm7RwISXkKy1RttcgaQN7KSgk=;
 b=sXn0eXVfLyZJJVt0/y96WCzglOdsxCl2BQLsb/TI+ZshOB3HPA7cpr6ILVXOopOrPPdYgVpA25mduwGmESFcwqPDkuMlDNnR4fTE3xTEFLsZo6y/rcDS9cuANM9x3sbsSQFGupU8MUw3Sut+dyXZ18YRkmqozVqHjRP7vmc9QUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY4PR1201MB0264.namprd12.prod.outlook.com (2603:10b6:910:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 14:54:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 14:54:25 +0000
Message-ID: <3087ce62-d28f-caef-898c-85ae02279c50@amd.com>
Date: Wed, 6 Jul 2022 10:54:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] drm/amd/display: make get_refresh_rate() static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220706140842.116064-1-alexander.deucher@amd.com>
 <20220706140842.116064-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220706140842.116064-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98db2e60-51be-4a8e-be70-08da5f5f6b41
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0264:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC36c7OOA7FsSKSLei+iCok5mWHVtOQCJR+tpzbaZtOSeCw2oBn/CQJKTCOfH/leBW42jiRen//8NPWFL1PmvK1zHjGQN0yJ95VVNXKfe9V1Actz1UrSL3TViKShw2PRbzQPWKM/pYDv731SV6BUooDX2cbXebuLQf1QRV1lSOuN/Wp03kXYqYTLFgHjZUjPkr2/NEuT8Krhml0oyfizt9BpLGzbGkMiz3nCq+DkG9IgS6f8J3OTkCL6yDXn3UKN+hscvw/GnCZ2cgOH7+KoYMzb1BZh9S1xOQqFA0HhYtVufeqpM6hfSIaHS9uu6Gu76KXFg+xQ0rHmGVlRKWdUSsnAFr2cAlvGTbYlB1yh4n6Z1rM/9aISmIt3b77ry8rMd67Jwki19MB3YSvYUKI+bYtP3wuGxHJ2jSrtEEIoYzH9nXeAWz270vSHgAu0hQt6rmrrN8T2YpeqXYIqBANYcUvyrhMcqjYF5YKubFaTfYRdAFbENGVppOziA8vnvsmLlAb/+WmOYq91Wq5O5MPTTeFkXXBRjiufP71X8xqNu6DQxygbK+WmuvcClBX7Q2Jnizb5CC0cfdiChHoxVtmtUm7tlax+/DU5sllgojPQWL05hzpukZr1N9h0zOtQkDMq2eOd5B+HwQ4b9FcrBy9z+lankV5RGCsudS3hmo9ZLO8j1N7dih4vYXJCDVY8+bq/XwDmCdDCtwAgiYA5qhKpjy2nS4BQWEEG57D6u3LQMpatmZ8rpN5s1/7+d4nQirpVYTvvzfhH7OZXQibOpuD1dR8rpRIHMfl4uL9LsgBqKq0E35NuK+GPzcx3C5DpmT6aJ8MdTY3p1/CEK10/NpuHVhxq6hsvl2BUFbhsS84lL6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(8936002)(8676002)(38100700002)(186003)(478600001)(6506007)(4326008)(6486002)(2616005)(53546011)(316002)(6666004)(41300700001)(6512007)(26005)(4744005)(83380400001)(31696002)(5660300002)(31686004)(2906002)(86362001)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXEvNVlHaExIMnFJaXpBWVA0Z0o4d1M3cUFnY1hBZHhONThJY2gwaURjaDRR?=
 =?utf-8?B?bHkxNTBRalIxN1hRcHpEbi9XcGVzTVlENWJIWnR3YnNjVDhEUEIwUkxUZkJP?=
 =?utf-8?B?K2hvamF0ZXlQcWtYTFR3RktZMXJTQkdaaVJWRVowOHdjdm9WeHMvdzN3RnRW?=
 =?utf-8?B?cTlKYzA2eTFUZ1ZkMHlCVXdRRGxqNFh0MEszTjdZTGQxblgzckVqZXozaVNK?=
 =?utf-8?B?cVlYbkk4VHVBYzg0L04vU1ZkcDl6cTUzdm1WWVRIOWFrTnFub2J4R2VSM2J3?=
 =?utf-8?B?Y1cvY083eGZueTFST2VldVhYbEQ3WjJYbytmcWQ3SGM1SmhuNlN0VEVZN2Nh?=
 =?utf-8?B?TGpHTFBGV1NNUU5NNFU4MWJDbXpDNFNxdGc3ejZSdEJ4eERwMkNXcHRrRDRz?=
 =?utf-8?B?aDltVHp1cUNjUi93NFdVSXRSdG5RVXgzdnFVQkdCYlkweUYzU1BVT01xOWls?=
 =?utf-8?B?SXVhU1ZYTmpaTmlLdHhuSkFJbkllUGozTUJPNG5NR0ZHOE5wNnJrS3hkZGE2?=
 =?utf-8?B?cFNkRjFpTWFVUVBvbjduZXRFSzQvOERBOUtKVnUzaTQ1cHBsOXorRll0Um9H?=
 =?utf-8?B?bVlpYWY5OCtxTEd0MmlITW9BOUJCMU9GV0xPMWticHdxcFhtVVRjRkxNQXY2?=
 =?utf-8?B?aENzKy9PY2psRUFlM1hnOHFDMWdBM295VzNOYnBGcjVGaDk1eVdMRHhvRXl3?=
 =?utf-8?B?OWtaelA0OHhHVThNYmFuL3I0dUpDK1pYUmVnMjd2cUZSTE14N0J4MVFEQlZk?=
 =?utf-8?B?TlZxSW1QaXZOdTAveVh6SHp5c3Nna1BiS3VLUERxVFdoSWQrUXJrUVBWOVZD?=
 =?utf-8?B?Nnc4d0w3cS9vK3NXRzNJMzRBVWF4U09CekZoT3ZxbDFsOGNMMjNSQWlxcXhR?=
 =?utf-8?B?Z1B6aEVtaWRHMjhVOGdIUVI0NFk0UGNLTmk1ZUthcHpQaWpLVjRkZVAxaUVp?=
 =?utf-8?B?aDVLL2VLVFR6STBEaGVqQWFVWjZjbDNML3VuZTVrMkEyeGRJa08xWHF2dklJ?=
 =?utf-8?B?UjNuNG9DYkR3aHdFeGVDT3hVclZhZ2owTE1kRTlGRjJiV3hKSGNPZlUzR1BV?=
 =?utf-8?B?NXdPKzlLYUNKL1dEcDRkQXcvUmhKNVVtR1FLcGcrY25JdUFoSDcxTzBLRUlS?=
 =?utf-8?B?VWgyT0tSSTlxMGdYelgrWWlaaHg5ek9HanplYTFkV2JaOGo5K2pJM3lLdWZo?=
 =?utf-8?B?SHNzZzdWMm9ld3liTkh5a3EvNXFuZnR4eHE3TDJsZ2ZLdGl4Q0Vza0g2QlVu?=
 =?utf-8?B?aHR3VGlGUHZPV0tIVXZTZFozT0M5ZDFSRnppL3VacWhYNlNXZjFyUENNbWh1?=
 =?utf-8?B?cWFzQnNoZllVZ1hkaGlnN3pVSC9Ba0JmaTkreVJRclYzdE5RblMzZUo4WDVZ?=
 =?utf-8?B?VFdYQTRscVU1bVBPeFk1Nk94R0diY3NJcjM3c253RXluazd3ZGM4NE1OTFpB?=
 =?utf-8?B?dkJyV1lDS1cxTURLMGw5Tno2dE8xMzFkZE1ZSHljRTUweFN5Yk55ZHVHZ05E?=
 =?utf-8?B?clJ0MUdnVlhjVldVeFhwcFVtbW04cThrekVFWmxYbmxjZGNMbWZHdFNMTTZo?=
 =?utf-8?B?V2hWOFNSeCtRdDA4R0h2bzdPcWRDS09nU0RuOStBVlRKcCs2dG5lcDZyUklY?=
 =?utf-8?B?NnVqV1NjQ2xNSGp4NkhQSGJEb2kvOFNPRWdid1IvTE16b25NN2x5K2Fjd3N4?=
 =?utf-8?B?UTA0eVl6OWhSNFd5S3VYRksxM3NIdzRRaitUbTFxTU5rc1J2UGZFcmtOenhR?=
 =?utf-8?B?Zmg2akM3a0J0QllPd2ZDVXJVS1J5MkNibUM2dyt5TThSNGZrSmpXMEQxczFO?=
 =?utf-8?B?em9IZjU3SFd5dnN4WjNva1JWbzhxTUg4NGlvUnNrZWdTVkkrWjYyMEE5anFL?=
 =?utf-8?B?eDE1dys2WTdxSWlHZEh4MkdpcmpMRytCRlZvTWhHR2JvdnlRUlpUM2VXVXJI?=
 =?utf-8?B?ckJOZ2lORkRzQ3hsK2ZkRStrYm9UQ0NCNzJPOUQvVGlNSEtNTDVqRTlncExH?=
 =?utf-8?B?eWsvOHppd0xQR1ZzMDVoZGlhdXkzTDAwQWhEYUtUTmJLRERZN1JTTTBpT3dG?=
 =?utf-8?B?aXRtelZnTTdnaVFBNy8yNE4wWkIxSlMvQUpIUlE4amYyWkRoYytSdy96aTN4?=
 =?utf-8?Q?eo1oRtFVKUoUo3QZ3Q38Pa4m/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db2e60-51be-4a8e-be70-08da5f5f6b41
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:54:25.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0kIx4+bz3KWumkyWD+07wSUEnDRdsGePBjXBfb6tVWIwHnv0ecGQmEZU51XrpjScngd0u5Xwcgu8kRZhnRJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0264
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-06 10:08, Alex Deucher wrote:
> It's not used outside of dcn30_resource.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Both patches are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 4f684235a413..7f01463942fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1899,7 +1899,7 @@ noinline bool dcn30_internal_validate_bw(
>  	return out;
>  }
>  
> -int get_refresh_rate(struct dc_state *context)
> +static int get_refresh_rate(struct dc_state *context)
>  {
>  	int refresh_rate = 0;
>  	int h_v_total = 0;

