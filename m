Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4A2C001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 11:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918D410E1AE;
	Mon, 14 Aug 2023 11:51:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255B310E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 11:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfZomiiPfZeW7ySgs29bhbA+jbcwkgUbxQF2WvBh+iTN+H7KRBI7MvnLRMFF+yJs0Ij6+FvEj/BDNA5AKPfLZb2BPadgAk/OrCPVxlsF5Z9oq9xIu8YHNdGjt9/WTGCZ+fn+uK3tX9PNxlZjmvrbBQuDLcb5HLr2Aa8WWglIHajxL9ZSVmlQU5X36HahO/s1RWmk8ic3J9WGjPok+0E62tE4QeqtpZOiu+Hjq1SBHvG//8DBvAT3ZdbCWeoA4kiYGbJ+GeeUY9ImeL0ZSupbT4m6tfHSddO77C96H1Pvqql5OCKwtrpg3bWJiTjWx5FFCFnfJ0FeT4IdY24+zBfWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTgUbvRWsnZwaq2KkTFF5Bfoo4JpDZBcuSAcCxh3IqQ=;
 b=mif45bw5+kZYl88joMpiv6rP5lr56Z0rOc9CwbKLEYaE8mUCpXvNQWhCofSMn8ic7vB+9l0hAM4EbDhLoo9hillPvwTFnAObkCiB7G+GYOmf4RjRQ4bzZft9BiWgXbNnC/AjDAvUPvCLDGU1spLS9j51xSnrx/S+f3Qr6azyjMPwsrjiCRQ1SozoBShDr+3axRaAEYanZhjuXvI+qQUvGrY6KVHHTYnJ2gzQdytkPx0FrDMncz0lCs59/LxJlg2zSjSn6RQmEhtvqfET3na77WeRbhSWbCKEwC+Htgn/5Td/WXLuSdNk/LcsRxLLBCoOhJYxZ78Zl9545iJqogvUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTgUbvRWsnZwaq2KkTFF5Bfoo4JpDZBcuSAcCxh3IqQ=;
 b=juTWFcTHs93LK/G+TbjvFE7G7ZrC0EtlmMeI1lPy9XttBBv3DPgEZ1jTWKxOXcpNXkDRS3KT1G87Hz9QMkDlaOhzlQtjB8kzYiD450AGKY9n3VWqu5mztKKd1MEg/uW3RFK9jmMgq3gl2w1+OX6tZ5dcXmu7Ur60GC7WanAoE3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 11:50:59 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 11:50:59 +0000
Message-ID: <8912dcca-cc80-49a5-a5ac-eaa10d9ae9db@amd.com>
Date: Mon, 14 Aug 2023 07:50:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Replace ternary operator with min() in
 'dm_helpers_parse_edid_caps'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230813084611.541381-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230813084611.541381-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7543c429-e815-4a43-c773-08db9cbcb9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BS8k86fw3KFtAtSq77qqHERw0m1gRUEHPyYxlbLdgbJVBo2HIW/2T5NhJxLrAeMXG9O84MIzbxYbW9RtaY2DX3WEL6aSr7fG0VJoXz9HaIWQHMoA4Y1xP3gyQz365ZRTrTRt8elTcRyZNUCQwCUNBsMwItF9gAmhaHDHOzgTzx6bkw4qgSJsfFxIAHkcC1gqSfNjsXeTxk9zQ2I9YBGbPUORt4j4CcJBmhc5ZXQbBt1/yLeV2Yq2EVoNecHigHFrA9DD5QE8ddg9eK7SAG2du7WsMBBROxJxwFlP4BhkZkyF9Jhe16NdEQRh1LLR61+0Xdo4yo4QkoRZdrpWWU1d17MQOZaVx31e2v0L9029/jsY41B+W40ia2Ayf030v80m5NMbaV+r1pWMAqePtBpp21PGovlaEc9cjtK1wuyZNRQRawhHTgbmGVE6EccWdynNySJmfiIiSVDCCCx3RWG84OhBJGXTEu3/eib8ytg4cn/bf6vOoeYnlGtVX6q3T1E5MJ9eI5lFmYJn6vs85biK8iS9qXwoqpflx5ejB5An99ukUMBYAboRx/yVcIuocECxHMonSisuxYpL9PfNGbCHQyKfJ0l/xy/4U0sQP6kSLZNCfukxfqmRyKSa7W+ry6FDT8AYGImeiCUyiS1EIlUzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(110136005)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(31696002)(44832011)(6636002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(83380400001)(2616005)(53546011)(26005)(6506007)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlyUTkvL0dFOTdNcW1TcjIyMWFVRjBOd0NVQkt2UW81azZOcjUvdHJFc2F4?=
 =?utf-8?B?QlgzM1JjQkphQlVSRzlvMUNmZFZ5Sk5LSTBHeE1hVmp6U2xSemZqWlo0TkZF?=
 =?utf-8?B?aUVKT3owM0FVajJzakVTNEZSb0picVhMN0twSTBpdFRLeEpRWExldkYzWFEx?=
 =?utf-8?B?YlpXMkcwN2phTFFZcXRiRE56TlZheVZSNG93SXUyYXgvZWc5VnhNbTI0Ym1R?=
 =?utf-8?B?WCtHbWtZWk52dGVMa2ltMHRScmlRbGtjQSs3U0hHY1o5cnBFM2Z0TmRIZ2Ur?=
 =?utf-8?B?c0hZQWllN2wwcVFEdk5aM3NKS21oaDZjTmI4dXZNVGNyLzlZZnY2Q1VFWXYr?=
 =?utf-8?B?bTFacFBibmhPK3JoWlFJUitRZ1phbUJUQjgxNkJGank2YXo3ZGpjT280cDl3?=
 =?utf-8?B?NmFrNStIR0xPbWRFUk83YmRxb2VIQzB0M25hRFRPbVNOUW1SZGgybG85NDJu?=
 =?utf-8?B?bzB3MFhQTjhibTBhRExWWEFXNXNJdk9SVE1jN25YekVoYUZBVnZvUiswQy9Q?=
 =?utf-8?B?OFdGbENMOEIzTFN4Q1BDcUtGNkJjb1lFenQ0OXJsRzJ6bUJaNi9XWndZUzdh?=
 =?utf-8?B?ZlZKTjhiTGJrUzc5OFpzU2JHWlZ3MmNQOVQyUndhdndqRXhhTjBHaGFIVTF6?=
 =?utf-8?B?MjJLSFhPVXQxQzRTUmVSZjZGWGt0Ny9MSmNrY2NKdytvTXVWMlZwZ2F1L1Ns?=
 =?utf-8?B?a21ad2k3U09DdVNlMDZ2MVk3dUxKVG9zdHlTVDVrMlhxQVA5ZllGc2NjZmc1?=
 =?utf-8?B?Z09zV0hQQjU3VGVUelpnR1YrVFM4NWZvUXd1WjQ0UldWRXlJS2JDV00xMTNO?=
 =?utf-8?B?ZHhEZ2pNcm9nUEhRRnFSZGl2YyszNzhMVThNaE1HMFVRVDdPRWx2cGFxc3hH?=
 =?utf-8?B?anlDbThJbzJHYnVod1ZGR1NZeTJnUFdweTdRcGkwWjVnQk45eUVRbEJ1cDlM?=
 =?utf-8?B?QVdLV3ZpMEFjZHNhem01UFBXWGdkTkswcHBkVzZJTHVQQ2ZPUEZGTzN6WWRn?=
 =?utf-8?B?dXZzdzVESVBOakZTNjkwZUxzUU1xMW9ETVRKSHdrdzdtTHRoS01sZGRTTWx4?=
 =?utf-8?B?ajVqM0JhaDJ5cERsNHBPSDg0TzZRTFBiR0RVczJJbTlMeGdzQ0VMUlgzV04v?=
 =?utf-8?B?ZzJCTDJER28rcU5ETlB6MlY2Y2VUS1RPSG1UN0NuQ29HdHVENFFwZW1rU3ow?=
 =?utf-8?B?WDZ6dkpOSHNOWUVJb0xaRHJsUW1uNVFDd3NsZmhETkh1N2pYZklKbTJJZXRk?=
 =?utf-8?B?ZzVFQitYU1pzRWw5LzhLaEV1ZEpWNHdwU2RsZi9QOTl1UVRZa0svNjFXczlE?=
 =?utf-8?B?NnZwcVVUZ2JRUnVWeUZPcnhYdU1oUUJxT0xwYTFZKzFqYXAwWEwzYTNCRktW?=
 =?utf-8?B?UGtZNkpXYWpVWHNyMmEyWFhtdDFNZnljNDlUZU5iTkVUSFJZaUZDTnZ3OXkx?=
 =?utf-8?B?YU9zb05rakdZbXB6a2poZnVYWkc0eTRyUnJOUEN0WndIbUJ5dzRPRmVabDdp?=
 =?utf-8?B?eFUwVE1XdWliNmNCQnppb1ZIZk1wZGd2Y3dnUUI2bXlsUFhwRnlaZzl6cGVY?=
 =?utf-8?B?dmVYZWxGMGNzUjVLdFJSZ0dlTmJCSG1oVDZlcEFaZGxoYVlHTy9MUndmVlU5?=
 =?utf-8?B?NURyYVF6eFNTZlBCSEhlcHlBT3M0K2Y4T3l5WGZWWkQyUXFHckk4M2YvMDQr?=
 =?utf-8?B?MU1HN2RCSEJmUEZSVE52R2RxVXJBblYxVER2dGlZbzU1SFNqTnJ4aHpxSFp5?=
 =?utf-8?B?ZEJaS2FUcXlENVY2cE5zL1lJSnpLYWFJSE9vMk5zeElndDQzYjJURXNxYkFM?=
 =?utf-8?B?Nm9ISlczZGNJazlTdjlTNDh2QndxMEx2ZGVvbWFadXZJa09wWWJkNWlNYjY3?=
 =?utf-8?B?bmFoMHRjTDR1VGxnL3ZQemFXd29jNXJ3enNYcnAwOUNwakNudExlVS8wN005?=
 =?utf-8?B?VjJHeGdoME9IWEdRL0I3MXR0KzIzb2NEQWg5cEZMcXhNUjZGUmxTbGJYSXJK?=
 =?utf-8?B?aDZoU2FHTUlwN2MyOVl0TWZYZ0dTaE5aano3SnFnZm1qQUp4c3hZbTdseGtQ?=
 =?utf-8?B?cDJ0RXk2cW1jR21qT2ZnTkd5VVFrUGN2akpwckxJNloweVJmQzIxd2I3ejJw?=
 =?utf-8?Q?YGfNjwyZXI3OJpWrP3nYLeEL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7543c429-e815-4a43-c773-08db9cbcb9bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:50:58.8653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btKjzPrJdSKNIJBUc1V0QRCyU8Q8vfKsKCmG05IrNb6lOzWeU0AADm6bZAiOcHnXO3OfrJjPdvohcj+5XAjKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

On 8/13/23 04:46, Srinivasan Shanmugam wrote:
> Fixes the following coccicheck:
> 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:120:41-42: WARNING opportunity for min()
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index e94eeeb97688..4b230933b28e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -117,7 +117,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   	if (sad_count <= 0)
>   		return result;
>   
> -	edid_caps->audio_mode_count = sad_count < DC_MAX_AUDIO_DESC_COUNT ? sad_count : DC_MAX_AUDIO_DESC_COUNT;
> +	edid_caps->audio_mode_count = min(sad_count, DC_MAX_AUDIO_DESC_COUNT);
>   	for (i = 0; i < edid_caps->audio_mode_count; ++i) {
>   		struct cea_sad *sad = &sads[i];
>   
-- 
Hamza

