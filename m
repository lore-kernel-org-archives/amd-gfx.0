Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409BF11A930;
	Thu, 19 May 2022 20:53:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3723611A930
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 20:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdFQ4OTDssb87w6AtAByPtg25dDq+ttWQobfNqLviWOhh07/HnGC5Tus+iyXd4YkHJdTUwXz9tgvjdSeCEtyLxWhKXOJC1pHlhDLWEAbgdr3Jj+eTg9W7azpqK21K5mCuUb6AvKIzwP4HdYR3lZjDGSjNljBXBrlpDf1LLpTLIGDAknpOHKs0M402QaAwPEEGIw5RA6tsOtxj+guAKSQvc68hR6d0ZmzNskMVooG9HPVwnN2GGTASY3rv9jgJWZIhMVVWUgMsjzKSp+WTTi7DyD7fkH5couLqOfrgb6OFPpKGBvg/y0r1iSQqJ4EQ51Bg/ZeufcMyPjO5oa00dm/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re1sWFCwyr+GNyN3AyvV46Uqd1dxHq8Uodr3V8YQMDk=;
 b=KA++wfWR2OqEJpHrZ0WBZklLTjWU4rlDFxOk/qpyX5tkAjwkjXFeLOX9dvIEtMAYPJ6zSPOk/+F1AY8xDDmhEkAvVE8W9WMxljGrLZl5UsiahYIQLXNsakAVJz4SoU2uL3x/RvcLOBkNhd2XTIqY9MYGnF8uLpN0j8EXGzlnylcElq7OxYlJsXJpTGORQMQ8ZQ6iCOP6+DpwBVRc7RPaHetBaRzHIrb+VUjx7ZP1EzW8eQr6rvzDy+Fcugt2Vmq8j86SvD9I+qODiCLj74RrHtNZ+HwzlHrJLq8aQSZqPaPPMb6KbTkuSoc3oyCVX6CAm5ZbFYSXQKIUfDjSDU1qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re1sWFCwyr+GNyN3AyvV46Uqd1dxHq8Uodr3V8YQMDk=;
 b=vznF7Gy+A1Y3NVEW30QWaMwizZldI1cAS3NE+fo9pdTQC+SBW9ZiGYPh8Uu/D0r+J+UAE0EZXPzrr74ZnuBX87en5QODFqxG4rAhDYiXC9Ld4praX+rseRQ+6ecZQFr84i+ad3lbZMxx1AZZF7v0D3Pi2tlOhvwNgK1UK8TkYis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 20:53:00 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 20:53:00 +0000
Message-ID: <b54971f1-e0d2-35a2-f3cf-0486569b63f5@amd.com>
Date: Thu, 19 May 2022 16:52:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amdgpu: Off by one in dm_dmub_outbox1_low_irq()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>, Jude Shih <shenshih@amd.com>
References: <YoH3zD7umruSyPms@kili>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <YoH3zD7umruSyPms@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a280b73f-63f6-4a00-c372-08da39d98f32
X-MS-TrafficTypeDiagnostic: MN2PR12MB3710:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37104B6624512A8AD00FDBCE8CD09@MN2PR12MB3710.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvFTsr+WRS5uLAHFIiAKCXTkZrF0URkZsQLtzrpoajTcsJeSvJm8Jn17GUdP2JHvyQO18fMZkiIPRE5ZA//CknbGnlq1Awp03IaeEXNHazOjyUkqxWHuh+wIo+zl9CWfn4OQAC6Twa/UmVXmob64Ycrjhi4FOChaGwKJzd37qSB0I4uOxbJBxAEw9YMcMpcqutWcp0HGKOmWMYrQKj+vWDtsrqTcllanQcpBRqeX30B9Uu1FtvqeTA1X+TvO5IQHEpzSGTEovvuJGjYj9pcrDYShM3Si0ALlkoq7PPLKXF/n8ekBWnWFE6uxuj3FKjd2PLU42lymR3AwTyt/1UP5Mv4UWaIl9Hy+wyil9qJwhbj9Op59QDtl2etC5HS6lOiYpjz6VcObVR1KLsRhmXchGudaJ7RF5fdK3OLlDHYQ3D3fRIbkNKCPA7yzgNc4z9qAMkmt9Bdg3W63JnM2NDMQYNkaISi3gPCz25AisMv1Aq2PJRd6XlikPvDHTe0I3e1cCBW7wxV8xSGMEXECqfhqLGsqqgg+Yh5NS9cYUovPznK2T933lmF4dMrVbc3xr0E2CtERvmZ+49aoZRAsi2D3mrWy9KITmLTlKXIUltk6IC0OPyf6jVug35Ifxrgqqrc39Y/hop3tMD82jQLvqtXClEOuRoR7dO7ehASGXtQEpcKYv4HlTo9BDwkrzYd9LBmAUm5oPEj7heVCqHtPzqLQgHdm9XPkGHe+E3EkIA55c0CtzGc0TUAk8bqSrfMrJz4n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(53546011)(66946007)(5660300002)(508600001)(66476007)(66556008)(36756003)(6486002)(2616005)(8676002)(8936002)(31696002)(4326008)(54906003)(26005)(6506007)(83380400001)(110136005)(6512007)(86362001)(38100700002)(2906002)(186003)(6666004)(31686004)(6636002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWcrVmJreXROOVMyOGxjekNwTVh1SDFGc1RhSmxZQ2F3OXVpNlBybUtvRWFv?=
 =?utf-8?B?Rng3dGpkTmsyUnVucnlqZ1daR0trdEVnc29LdGEwV1Q1MWVtWVZXNStmdmxC?=
 =?utf-8?B?ZjV3VnVKVDZCSXdPSGxyUWlISDlWV1d0THoySVhmeEFoMmEwbURFMGQvR3B0?=
 =?utf-8?B?R21USUR3M1hoUWZQUHYyWUhnbm1tRTFaN0ZxTk53UHlmRTJ3U3hlZHNSOEND?=
 =?utf-8?B?T1JiNTFCeW5naUNVSmZWRUw4ckM3TzRvKys0dWl0QXQvbHlTNTNKUDYyT0t0?=
 =?utf-8?B?eVJBaTB3bjM2ZzMvVGFJQktBSE1GYU12TVpNbldVTUdFNG14SHNsdndlY0Fi?=
 =?utf-8?B?M0llQk9pRHFVL25ZdW8vMjJEYnpaUnEzZUZKRUpPNjRWNHFzODR2bis5RCtQ?=
 =?utf-8?B?cWExcXA1dmNRT0xhK2VWWVlFY2lmM3Fvd0F3Z2tlVVBaOVUvUXZjWHZiOW9z?=
 =?utf-8?B?bndLNW4xbDczZ1hKY0Z2aGlOQTBpaUZLb1VUSklOZG81ZG9KcUlmNVd0a2ta?=
 =?utf-8?B?eWtjdGdkNlFnaDZqVytsRmdWTUQ2LzZ1WjJuc0Nkc0VwTU9VZTFvbHpxVDlS?=
 =?utf-8?B?b0wrQUthZEtJR3Q2dGlVVXVteW83WjZTU3o2L2orZ3JyT3F2d00zSWVXMm1I?=
 =?utf-8?B?N0pSb1ZVVjBhUXJJc3RUNENzOEZwcERXVGFmR2o3Qm1SMm12cW9Cc2lPUWQx?=
 =?utf-8?B?aFJnUUkrekpQL1ZFNElaWk11aFoyOCtpTlJJT1hPMGVqMkZvTWY3a1NlRDBR?=
 =?utf-8?B?SEY4WWVDZlcvcGsxeE8yME0wdlk5ekxDcEJOcFo0Z3BBV2Y1N3F2WCtoblB0?=
 =?utf-8?B?TkxJWHhuamkxTmtWQTFZbU8yYjN6dTEvTnpNbGdyNElvWHBaclVaKzhaeGpM?=
 =?utf-8?B?MUhEbXdUVCtMU3VaSVBpNlFvdmJJVVArVG5nSHQ5Sm1vc3FuaXkzT2lpejl1?=
 =?utf-8?B?aEp3WndLM0owU1lsRmx4Ri9mT21ZS2t0aTFkK1QyUkNVaEZOZ3RqT09NRXg0?=
 =?utf-8?B?VG5Ca05pMllxaldjTXVJa2xtdVg4SmxIQmpzZWpwN2J6UHRnSElkUWphWDlp?=
 =?utf-8?B?cW83c2JxVmthaVhnaE5Ocmh1ZW9tcVNEYnVnZFA2NWhxcUtPN25IbG1adW1Z?=
 =?utf-8?B?Mk9TY2JMaXRWWDk1czA5NEZnNGkxWlFqbVcvQ05zcWFLRWk5dU03WUpkZFJZ?=
 =?utf-8?B?WW5CcnFRRldqYzBlUXhwRkpqNDBMaTNNUXYvbFh6WWF2ZVdZeldjUGRLZGkx?=
 =?utf-8?B?VGMxanRQNmZ3QUtyTUJIQ0JrdXQ5bXhmSnZSZkNUeGlsSHFnWUUwWGV5bEZP?=
 =?utf-8?B?bGsxQUJVQjhpYVRYR3FnclkvOXpuSmtJSEVHWWh0V1pGbHRaRlIwbGl4cmhL?=
 =?utf-8?B?NFlwY3NCdjJmb2E3N3pMNy8wTVFPejVaNzJsS0ZHNkJYdHBWeGxneTR3RGQ2?=
 =?utf-8?B?UTB3dVJCQUVPMG9jbWw3VzNUUDRNc0UvZjR4cjFiMWJ2OG8xMTAwK1pPYmhL?=
 =?utf-8?B?TnpESlFBb2R0RjZsRTFSdTRqN0FzYXcyYXRsU1RaOXBicjE4TFpZektXSURT?=
 =?utf-8?B?aW44ZUFiWXFvVyt5bXJBb3ViQVdVV0ViTnhSL0ZPcCthM21FQ1VsMmJpbWVV?=
 =?utf-8?B?MmRqVGFvVXJ2bjJhREJSNlZ1endPdU9vT3BxTXlhSy82RlRidXN5UnhhVW9L?=
 =?utf-8?B?ekhTejUwZ05UM1NLSUFrSzN5M1UrcWx6U1JZZXhTUlBBVE5XbGtoSG1xOGUw?=
 =?utf-8?B?QWhJWE1yTHJ3YzNhb1ZrNEhaUndZcHlaOUtnQjB2dTgvM1VtQkJmaGJRTmNL?=
 =?utf-8?B?SlJrN1F1WW52KzBzOHFmM01ycEEvMGU2OVV6UldKaDA4M21aS2VKa212dU5m?=
 =?utf-8?B?MThyNGQ1ZzA3K3ArdmxmcEhxZVN0V1A1aEY5dC80dmwzbnRSa2ZSY1pETWRj?=
 =?utf-8?B?cG14Z1pwdCtwLzE0dnJleHNCdGw0R1RYS21nVy9pZFcvcHp5Ty9qdzV3bUwy?=
 =?utf-8?B?TFRmSVV2MVdGRllSK2I4TmZnWmFMMVJQcHEvN2NsQmNENXZpTHhtODdPSUox?=
 =?utf-8?B?UHVWNGZ4NDJXV2VlU28xblVyenpKUXoxeVBWakZMSURNNTNnWHlDU2VXYSth?=
 =?utf-8?B?NWNGaEVrVzV0WGxGNnBOdTlaWWdWRU95SUkrNnQ2YXg0MHlldmZMbGpLck0v?=
 =?utf-8?B?M1Jhbis2NW9VVW9HdUNWekhRcXRPR0dwMnpiMjZQU1JCMUt0M2ZOc1lncWN5?=
 =?utf-8?B?dTBKRXpXTGtRaXJPNFdsUTV2cmMwc3Y0b0xzTGVhaTNEQ3NEK0h2N25QWVBm?=
 =?utf-8?B?MzU3TnRYSkZod1NxUW1LNUtnVkxPZWM1YkIyYWFMMjBnakpDeWVNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a280b73f-63f6-4a00-c372-08da39d98f32
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 20:53:00.2171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zC1ekaWtHAsRGuUJKBKk1Qa74Dmwb/n4OFmF7np7qkqnCH+JCFdP8lYZeLol5NdizsPdnUfyZxNXdEeLKJHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
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
Cc: kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Simon Ser <contact@emersion.fr>, Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-16 03:05, Dan Carpenter wrote:
> The > ARRAY_SIZE() should be >= ARRAY_SIZE() to prevent an out of bounds
> access.
> 
> Fixes: e27c41d5b068 ("drm/amd/display: Support for DMUB HPD interrupt handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6edfc0963dab..c4f122c6faec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -770,7 +770,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  
>  		do {
>  			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
> -			if (notify.type > ARRAY_SIZE(dm->dmub_thread_offload)) {
> +			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
>  				DRM_ERROR("DM: notify type %d invalid!", notify.type);
>  				continue;
>  			}

