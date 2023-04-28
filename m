Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3ECC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E50B10EDC8;
	Fri, 28 Apr 2023 19:16:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADEF10EDC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vrx1qbdHWgKBc1X6PISs7/qLO/nymRzwRnALyZ8hWh0tAAsN3sv2OQq+8sS5VTni7uHNjIyDGoykTm+FgvZW7lPhcdhivnN0PQWAKk4FaS2gj/h1XiO1ZWycBrZQQg6WuhdSZVO5Q+A7vE989NyL+7113wMrK9wBZXOWkpsR/soKnlK/cQb8IINJLCGjovz/p5HRF587YDHhBkZtR3j9vdVXBC5e9J8uv32ZPjxA5bbqYkM9sFhvnt9nrKk21tbIl5UKypQToqE4jl1x4n3oSCr0xYYs4zhCg9/lbqSNQi58d9EPy+HjQItcnBLQOmPRtZS1XYMt9SRwhChXKmNmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUyeTPAdN9boHyHWVqQLaNjemLz9Lqh2lzS/xGMkv28=;
 b=IJd/YJygz8NolrkimPOQMav4tV2iCSZxIoBMe5MlKlUdUm0Knq16BwXc5cKGjrykL3UQE2nyMh5n/d0U/XfZTwOPbBFRQ02uppqk+WPHLXL6xLlZvPHu6WV10Bdi0zyJAqh60tlQEYZA8B5pAvpPqMAVuXB1KhxfrJMzmSgDHSYeYRP3zzKr43jS9l2EXOg2OUNTcdsAnulGqlXvPRV4xGcsZpfhg90WsSrCrnfz2KdXaTDTiGfHNITdO/OcCZxI/cwVOzv+I3grXx3y3f8AQZQy8ZyAcMmD7WdocWlKpJJXSUZI6xvU+YGnbOA0CLywMn4QXMPQc3tnHPjX7r9aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUyeTPAdN9boHyHWVqQLaNjemLz9Lqh2lzS/xGMkv28=;
 b=AFwzEssynVf5lX6IqZyCWFPilTHhT7DhMX3y5aFG94KA1zK96UQhytMwQkOXf7p3lovSxOflj4G+fa6/HMbpEg700EpKR0n3SWEgEOCjRDtcg9gBfBqyMB7kOQpbu9kMB7yBEcoezsVMRgU4PoHJF86CimGVsmto1ODtcWpVzuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Fri, 28 Apr
 2023 19:16:34 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 19:16:34 +0000
Message-ID: <674dd9f2-0605-a162-ed77-15cfd8ac0abd@amd.com>
Date: Fri, 28 Apr 2023 13:16:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] drm/amd/display: Add logging when DP link training
 Channel EQ is Successful
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230419120039.162313-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230419120039.162313-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:610:4c::16) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f460086-c747-4b6e-3d32-08db481d14cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMlQlilS8NYnGnh4m+JtsTELGs1esAMesJJVbTJXFt/hmnPUpzifREfn72RPMH2qSqua7w0SUpcghHx7Gmyzr7gzfNoZG6jcihl4tgojHgOtZ/s1jSGlnPjkZfNs2B45HgkVgTvBWcCxgVZUzH3N40FxeYU66wCsE3pZ6lDUyJVv4+dQgLW1oOY9vx+krcbkosbovtUvsU30zZ/MxvV83IDECQM64FHdG8R8ejGyZQGPKWRwFvQrhyFcfry2RvPUoVRtAejNrRa4ZAmrQFZBQB3NmZ+k2zlYI5w2LxwWyaDn441GfHenTrO+do+zO/UjNpgWs1/97/ZFJVllfWQ22r3tx9P9z0dus/pQuC1DQSY9KgUFB4QxlkR8T2njelOsZmC2v9wAt6RGD+ILrmK0IEWWb2RZkePxnar9J4r7nOLk/EfPSXCvYJ/IkxhpR96qsScKEkNW1iT1f859JvqFdbcutDEJ3ex0L6nrf7yLOB0655WQxKJdg2o5M0D62rbYrAypcyHHDGse3WJrOmFrOVBTeF5oAckrZlskpMy0n2R+wrJ9Z7ul9o8NF592sG+PdhiuknS6mMpwuEZlRwdrN9nPRTjMgTyc4IaCJSXw1zRhz45eRUJVpycELubUUr2IJ0WU21o26rO72AzzPZXDtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6636002)(66556008)(4326008)(6512007)(66946007)(66476007)(316002)(5660300002)(8676002)(38100700002)(8936002)(41300700001)(478600001)(110136005)(53546011)(6666004)(6486002)(83380400001)(2616005)(6506007)(186003)(31696002)(2906002)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NiszckMyRDc4ZzZPZ2VUSWFJN3p0THhsemxwVkNpZCs5WGFWaGpuTlk5UE9B?=
 =?utf-8?B?eVk3ajVXOHBOd3RkekFQZ1M4UG9JL2lsdFY2eHVXVWJvcW1VUzQyYVJtZXZv?=
 =?utf-8?B?OHFCcGF3VEJKUU1LS291VTh1OThJZStyaXhjUHF4bWFjaGNzV0pReFcwa0tL?=
 =?utf-8?B?RFFEWTgzdVpsZ1AvOXBRSFpjbmpTMlNwM3BRV1VVbTM0cFVyNUlHalRldkhR?=
 =?utf-8?B?cjVwSmFXZnp6dFBlZ25mVHhQMVpJVDdxZ0FNVUNjc0VTbld1S3RVdXJSenVJ?=
 =?utf-8?B?MHh5NWRaUEhFSmxUaTRyMVB2aWVvNnEwNXo5ZnlCM0xVc05NNE5yN29WSWtv?=
 =?utf-8?B?U1BnSmhBWS8rREpaWW5JbzNJZ21Xei8zWjdEM211WmsrUTZ0YzZyRXdoNmFs?=
 =?utf-8?B?czJLYUdEUXRLUXM2Vzd4d2txUjc1RTU1ZExPQzBweHN4bHZtZ1ZCMGFKNlFQ?=
 =?utf-8?B?QlJZTVIwdnIrTCsvZ0o4c2IyUWtXRFJZMjZSMnVNKzQxMFZhU3E3NUt6enZp?=
 =?utf-8?B?OWZSN21ieGpNV0pOYmcrd3QvUFVrK2taMGFoMEE4VExMQUtaQjJyUTJ1QUVx?=
 =?utf-8?B?R3A1Y3BoWDN0VDF2NjFRc2s0WEV0T0NpdnJTQ0VNc3YrTjJUWkt0NFg3NHV3?=
 =?utf-8?B?SGVkZW84QTlUSVdWUjBUVWVmOTJOYXBSSGVVZHRwd0puZDJGUWFyOThBY1Vr?=
 =?utf-8?B?TmRvMjYzVnc1TkhXd2tjaDVXeTNENmQ0ZkN5US8xL3ZDamZzUWIwVW01MFZo?=
 =?utf-8?B?ZXBVbG1iNmFVWWFPZTRyM2lwMk1BRkZrT3AvSGJKd01VdmsvMHJHQmg3am5S?=
 =?utf-8?B?MmRpOGRocUZ3K0dsenNwM1BHUFVvUDV4TTZEcEZsZ1ZRUC9mWm0rOUZqb2t1?=
 =?utf-8?B?dUt5SHRvWS9RVTg1TFJNNVY4UXpkNWduOW1WZi9Kbzlsem1nMUpTUllsTlhM?=
 =?utf-8?B?OTRWSVlMTWkraFcrUklzTHA0UVpDS0pVRGZUU21YSU1JRHFoa0tWK0JhWm9v?=
 =?utf-8?B?Y1BVV3VrYnErVnJEUE9iNU9odUYyTGc3a09EcUNiUGg2ZHhFdE5DS0RRMmc2?=
 =?utf-8?B?bFllYkZraUliVFVpOVl6MGNrNDMyYmZIWGVEZTlOV1lrMXlnMWRBeTZvOXpv?=
 =?utf-8?B?K3U0K1NjVnZRQTVsdG81SGtTWVhQcVVJZUxUOGNKRTZXK1NySURGYlI5MHlF?=
 =?utf-8?B?eXJFS3hFUmJtTEZzYjhRNDJEZEZ5S1dySGVYSUI4ZzM5MXQra0ZaSlgrU3JT?=
 =?utf-8?B?SWI2UGNUMDBMTnBlUG0xcFk2bmJ6Yk1Jb3JOalVBckRtb1JjMXcxSVp0OTZq?=
 =?utf-8?B?ejlaMVBpRUFtQ1o5Z2N2NEZNMzNXbEJmTVZHQy9LN0J5Z28zak0zVlVTeDZI?=
 =?utf-8?B?Q3R0eWx0Y3BrOFJPRmxLVFNmZ1c2bzAwNDlCbElZa3hzZC9pcm1SSGN5N2l5?=
 =?utf-8?B?Yk5sWi8rK3A3eTRHTEM1LzBsTWczL2pNTHpVZVhlNjczdzhZc0p2c2JCTEhi?=
 =?utf-8?B?cUNkR2VxSjZtQ1JvcC9OZXhzS3Nrck8yMFJnbFBteS9YL21hZnlLM1BZQmxD?=
 =?utf-8?B?MTJ4MXdqcDBZZWM4VEIrZUMzK0F6ckp1L3YwMVBJd1Ara2FHQlNBc1ZZSmcr?=
 =?utf-8?B?R1g2ZncrR3RJNm5zRy9UN3RmeFRjOTFEa0ZqMTVpSHFFWFllMmxOQUsxMFky?=
 =?utf-8?B?ZWlUUGxIclJMdXlxbXN1QkJTTzlJOW9RVitSaUhYT0Y5Slh2K2d5UUlra0pn?=
 =?utf-8?B?M1JSZktvaGxlVi8xcGRqWVcyNGRRaGZqMHlwTEVPaFAvSHFnUmlaVWRYWDFq?=
 =?utf-8?B?UmNZd1ZFdGZScXRjb3EvQnVTdk9xakhxSWIvcnA4aW9GVllZMHVjVjcrR2lk?=
 =?utf-8?B?L3gzSFN6bjZBeHVSVllLVnBpSVc3QWt2ZzVtZjkydE5EMktrRzdxUE5VaDVF?=
 =?utf-8?B?S3pYSHA0VmFSS0ZpMVRoWUpDbFlvMlR3UCtOV28zMGJSUzB0RmhDMHltSVho?=
 =?utf-8?B?TE5md1FJVnQxcHZiS2tBTWUxMFFLcFRubFNQSEIyenhZeVhPcXFOODRYZ1hn?=
 =?utf-8?B?cE5GOXR0cjF5YWJMU2hKYi84OVlFTFRTcU1BS0t6Nmd2MHRxQ3psbi96OWE3?=
 =?utf-8?B?OHdWd1JJcGV2WFFRbkhTQ2FrM3RoaVlGV0E0NFIxeHlUaFVUaTYxNGpwQTNG?=
 =?utf-8?Q?YBFi3gj2Ksr6RH64/0R7IshCOVbEtLPdJU9GLA/ajLwr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f460086-c747-4b6e-3d32-08db481d14cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:16:34.5396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzHYQT48Hs3Z9g3OkUn7rKrqAcokscvxlX/aubg5u4Zl4KMPf+60wGGbOpd/e2YxxQJDLaTB+KCD6FdIQzzJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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



On 4/19/23 06:00, Srinivasan Shanmugam wrote:
> Log when Channel Equalization is successful.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
>   - For consistency of the printed messages, either drop or keep  %s for both the
>     lines - it is dropped (Aurabindo)
>   - For 128b/132b, moved the statements after EQ interlane alignment
>     is done.
> 
> v3:
>   - retained %s for both the lines, useful for better debugging
> 
> v4:
>   - move eq/cds messages after dp_perform_128b_132b_channel_eq_done_sequence
>     dp_perform_128b_132b_cds_done_sequence (Jerry)
>     
> 
>   .../dc/link/protocols/link_dp_training_128b_132b.c     | 10 ++++++++--
>   .../dc/link/protocols/link_dp_training_8b_10b.c        |  4 ++++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> index 23d380f09a21..db87cfe37b5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> @@ -211,11 +211,17 @@ enum link_training_result dp_perform_128b_132b_link_training(
>   
>   	dpcd_set_link_settings(link, lt_settings);
>   
> -	if (result == LINK_TRAINING_SUCCESS)
> +	if (result == LINK_TRAINING_SUCCESS) {
>   		result = dp_perform_128b_132b_channel_eq_done_sequence(link, link_res, lt_settings);
> +		if (result == LINK_TRAINING_SUCCESS)
> +			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
> +	}
>   
> -	if (result == LINK_TRAINING_SUCCESS)
> +	if (result == LINK_TRAINING_SUCCESS) {
>   		result = dp_perform_128b_132b_cds_done_sequence(link, link_res, lt_settings);
> +		if (result == LINK_TRAINING_SUCCESS)
> +			DC_LOG_HW_LINK_TRAINING("%s: CDS done.\n", __func__);
> +	}
>   
>   	return result;
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> index 3889ebb2256b..2b4c15b0b407 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> @@ -388,6 +388,8 @@ enum link_training_result dp_perform_8b_10b_link_training(
>   					link_res,
>   					lt_settings,
>   					repeater_id);
> +			if (status == LINK_TRAINING_SUCCESS)
> +				DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
>   
>   			repeater_training_done(link, repeater_id);
>   
> @@ -409,6 +411,8 @@ enum link_training_result dp_perform_8b_10b_link_training(
>   					link_res,
>   					lt_settings,
>   					DPRX);
> +			if (status == LINK_TRAINING_SUCCESS)
> +				DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
>   		}
>   	}
>   

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

And applied to amd-staging-drm-next.
