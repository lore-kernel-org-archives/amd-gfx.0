Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B798C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 03:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA10510E2CB;
	Wed, 20 Apr 2022 03:39:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF7910E2CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 03:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL9od608KN0UgcwkkVEm6RPGBMvWfQijL1PdPWPauCUQN2Re5EqTF1pstBb5PYpB6xqycJN4nthsycvCmCvo310sxXKz6JNczcF9Y3CrlcnuAPCWr98kn8lpsfmeoiIJvwMboPGNMTPkv4CZNVnh37F81zFCFX/h2JG6uk1IFy3TBMdKYFLXPUiAjHWbkDPww54h1awJuyunXM3YL3bnhRSpFLz5k21U7JmLpxYdmvq3fAv00JQsH/bpkJeMdTmLpIU7LJd4XSA/o+pvyWxJLcxQeKqb+EVXiPtof7p2LflmaWXjEM8PDSzqjJbep1JBJ5k7Wkki+Vk8XKlMA2qbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PdHhVIDpUCd6L7XyFaWK72kAbhgizU9DpdZL+mlJww=;
 b=Mj2Jh11asedcEKrcqntbvs3rJFqe72g2ddrxnR+bkDNfkCsKt/xtjGnlZ2wmFcALxKi8siV0uFEsmUuNCd+1U60qamJEWPG96UbflyYnBatsYHJAjsPhFaLKq7AhOx6QTi+WCrw6UhDVlAOrCAOAmN+61+UCXO/Dq0k4M45YNCxyhYEACU2U3uBtG8MinoA44MvOW81AhgyZIZYeFX76tihixdi1+2ksJOBvzftRi+LGeTrSCQeM3kcvH82QXXZFVAGcGJ6iWvW9qYS1a58rrbU8f1qrOrxx24XTvQM+xexEI0/JOfIbjOpBWdhzCkZYri/IY5oRwcWkskrmXSomFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PdHhVIDpUCd6L7XyFaWK72kAbhgizU9DpdZL+mlJww=;
 b=XPgIMC9DiYtQenYfQaTOFY68Bhuc2PgeIVC+euL/YqlNdMKUnRutX0KPDZE7/KnTCLd3Dm3jN9itWQVUFiyLFF90QScrJd/TOyRlVds+ts7IBFqtCy8cWqe62Cp/iDLyQVTaihVuIigrXU/fiVisP70Za3Cl5nPhnE91+zdM2QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1634.namprd12.prod.outlook.com (2603:10b6:405:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:38:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 03:38:57 +0000
Message-ID: <04a8452e-ba8c-92f2-86a9-bee25c658ac7@amd.com>
Date: Wed, 20 Apr 2022 09:08:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1650420149-20872-1-git-send-email-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1650420149-20872-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c093be2-7c73-4a67-8663-08da227f4cec
X-MS-TrafficTypeDiagnostic: BN6PR12MB1634:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16345785F283C685CD3065AA97F59@BN6PR12MB1634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEmmeLYHbmk/O6gxEVd4Clq+LGSYHiRVEgjUhIJu+QDbAIFp1aFdCrENZCDKpI/t2e4fTRRl7pXt05VSBH/O++jYp+g0Mq164ETMvCB60KkWgxZy5GiVtMhowjU8DsvcXjUw1mjQm/3mkHhZgQKuaV+tqpV6Q4j1xoGix/V9EVy2kcuzGu00fn917hdqLZTWzCXJqqHl5RCgYcjPIazM9F5O5fUM+6rPWckpMHkDwei3vqWZfkL3+gHfoHNcYpsAMj9ZmgFA2tr4d7jXP2PcqSEn1msI+mjkPpkvF5y3CEPSLSqMlm3Mh82BFrhcH1LYG2246WAqr53f7KkUR/knjE4evSLUymW0KaWlhq0uLMzjdDBTiLqpWDaoFYMTN/JGiTa+rdRLYlC7ojtPs3iDOSOemIB8KdnXWxen/e/Zt1YfE1Dug2tG0FQcS5lYnbXJK7/5tEpfyu9HCeK8myZM7bd0QveDODD7dThCe/F9/V/mubM+gxmmHzE0ra7ZS4TEO/8u9X+bMeE2O0NlXsYxz4rtucA3so6/q//hc3PB2kre6/rH2Xp5Z1azMGuWr59SiYkoosuDE1wvzgwhKErdWFyiASx3PKprIg//kB3J8I5uL7BloScoqsCFJMlzhkHVFAbR9xF18U8HUFgUFgWybWgUNZGW0yATW3bZJqh8BJk9KjXoNAuXhUqvj/flN+B8/TTtP5s6X7S9AzUjIcp5u2NX3y/183ICIUk4BdNKVPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66556008)(66946007)(4326008)(8676002)(6486002)(26005)(6512007)(66476007)(6506007)(53546011)(508600001)(316002)(2616005)(186003)(36756003)(15650500001)(2906002)(31696002)(86362001)(31686004)(8936002)(38100700002)(5660300002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0YzTmdYTUZlNGdpOVBBYmV4ZW1kT0Z2ckkwSWhsMTF0UGVFbEdMYzB4M3or?=
 =?utf-8?B?V3NhZFZQd0ZNdFZkLzE4dGt1cmpxZndyaFZiWm95ZE9VRUpYR3JMbTFjNzQ2?=
 =?utf-8?B?aFJPWFBPL01UUHNkeDZEV3VZbDlPSU1uRDBZLzJmeVQxSEUrZVIwT1YzRW9z?=
 =?utf-8?B?N2ZzNnE3MnkwWTlzZWl0T3RweElobGtpeG1wUzZEbkRqSzRyZ0xHZXhka3gx?=
 =?utf-8?B?cWZWeVZlelBJdjYrUjFTNzlzMHFNZ0tuNDc5Ykg4UHRwbWdyN1JOVDRpNmhC?=
 =?utf-8?B?dDNYU0czeklVVkRZYTkyczgxVkIzWUE3aHRUa3JTdGIzak1EdjArenh6VU9i?=
 =?utf-8?B?d2VBR1NvTzZORGNhUWVHMVZEYnBXRTRiaVJmU3RjbUFpM2YrQnVSckgzc1Fk?=
 =?utf-8?B?TEVyOGVYN1h3ajVhRG9JdXlPZ2lhdTByWjBuTzVUZjZBdU5tOElLcFFYYWhB?=
 =?utf-8?B?NEpjQXB3enVWWGsrcXZkTFpkOEduSjdaWTZsRHUzRWNXTkFSSUw2RDZCTElK?=
 =?utf-8?B?OVRmR2Q0Y0hDQWYvYXc4Y0F3ZUxqbnJHT2w0Q2paY2NtQi92U3AzQjEwRkdJ?=
 =?utf-8?B?V2lSZ2RqczY0YlJxME1SbWxTZTg3VjVWZnNsUFBBWWxNTml2NVZmSTBkRERS?=
 =?utf-8?B?MUdZZzROR1pPM2VQd1h0S09qeGh2bWlIR1VYcWVwbUd4VU9qNGVManU2aGhT?=
 =?utf-8?B?bk5zMFhLSHJhZno0dHVLODRyZ2J4K0k1aXF0YnlmSVNHNHplRjV0Q2hvaW9B?=
 =?utf-8?B?WDdjWHhBV0NtOVgyK3RUTzNzbXBDUWpjM2lFdDc3cjEwZEFJdFZwV1F2R2M2?=
 =?utf-8?B?TGhiOUYweGx1T0Y0bDluSG8xeHJzZ0dmZHVFY0Q3NEYvSy9CVk5pUjhWRUhF?=
 =?utf-8?B?UEVsMkVZZHJLOFFtSC84WnVQSjBPTDhqUVE0eEtUdjl1Nk5iS0gzQnBMM2dv?=
 =?utf-8?B?U2VzM1FPb1BZMThGOWk3R3B1WGxFTm02Zld4VzdXNk92bjRQbnVRbUVYcTVy?=
 =?utf-8?B?a2QrRHdhVFNCVTJnbVNlVURScDROakM1bWdHdUFVbDc3S291Rkc1d252NG9u?=
 =?utf-8?B?NGhYQnpYNkpjMGllQUlrdTRvY0tPYXl1R2F3Y2JmZFhqMkFpTk5yTlZ4QWZZ?=
 =?utf-8?B?UVBzSUd3WWd3MytUVXJ0OGZmUDBwUkEwYVBTQ3RZSCtzRVFwdmpIeWM5c3VP?=
 =?utf-8?B?bkIwMjFZUGNCck9rcVdBOGlaTUlXNTYxaVJoTlp1dzRXY1l2cjVTREFPZElW?=
 =?utf-8?B?UjZsNDNqakk4d1cwTVFHZXlGMjNFbmRZYXpmQ0hHeDFGczhweGxsd3VKb2tR?=
 =?utf-8?B?TERIQWhYbWdtNnlLTXBmU3IrQzJld3Z3YVQrT1gyTW94TnpRVmFwQTlQQ1c5?=
 =?utf-8?B?TXp6ZzlqY1hJNVdxcUtZRmV6TG1WK0FjamlmYSsrTGI5cTl2WXdXeVNMd3li?=
 =?utf-8?B?bk5YaGx1SXJBalhqY3hDaG5HUkVWNThDUUk4NndpUVFtM0dXNkZQSmpzTlRY?=
 =?utf-8?B?UXRLYTZoYXBUTWVsdjNJWGFIajRyQVpTbTFuWjdaUTFhRFhWOVovamlRR0ZI?=
 =?utf-8?B?TlpFUmtPZmdZeXV6dzczaGJNekNjcEtHenFwT2U2Wk5GRVJvUTVDNHVMS1pW?=
 =?utf-8?B?cWVWR05hMmtxK3hCbkk1Umx6OGpTTm5PeVFnYjhzeEFWTWZXcThlYnlFSHZP?=
 =?utf-8?B?SjlHakg0cnF1M01GdU9IZzFaV0xyK2MxdDlRWTRzcjk3aVcvVG1RdHY4TFVR?=
 =?utf-8?B?Umg3Wnd0Qy9nM0Z2TUVQWG1Nem9pUHFFdFQybExDR3BlZXJLMEk0SGp2Tmxh?=
 =?utf-8?B?azJqdnJxWGlLSzJma2g5TkE5cHM4MlhIekI5TGE3Z0ZraHFOUFV3T0FCWXVV?=
 =?utf-8?B?djZxYVVISWUzcmIyLzFIc1U1RnREblYrOXVBVHlJbER1Y0Y4V1NpakdYaTdt?=
 =?utf-8?B?K0JSVnR2Y2xZOVVTTXpzNDNtQ1VYMW1MWkRGdisvSm11WE1Gd1dnY243YWE1?=
 =?utf-8?B?OGdRVGNXZUFWcFZxN25OdXdkdkNMTUlGOHFiTzQ0VXpuZ0VFdmUzUGVuTGFk?=
 =?utf-8?B?ZDNHOVZGMTJIdm8vMzE3TnVKeWtidi9WYUh0bGVXRmk2TUQ4cjNraG14YmFu?=
 =?utf-8?B?cFRaaXJjWGNUS2hZTXBTVmdrU3hSMUdlaTBBOXpZcVRSVXRKTDhKUVhHZDZz?=
 =?utf-8?B?VUZhZzU1OTZ1S1AxWm96aFNFODhDVFJ5bGJ3cjhRWE1tdk8rVStJanl3cTZY?=
 =?utf-8?B?QXFORWlnUHZuNis4Q0hVUEJDQ0lGYWQxNkxtY0lhMDl2aXVSS0tuMEptQ2gw?=
 =?utf-8?B?dG5tdkYxODg4OWtXS2dQcjdmQ01BRTArNTYrWmlRV2U0RTFjV3dEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c093be2-7c73-4a67-8663-08da227f4cec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:38:57.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blJi61EmC8LBxCiRC9UuOKCfw2LkYYPnY88z8iOFM05Fc3TrE4MXgCwHhK8lGvDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1634
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/20/2022 7:32 AM, Prike Liang wrote:
> Without MMHUB clock gating being enabled then MMHUB will not disconnect
> from DF and will result in DF C-state entry can't be accessed during S2idle
> suspend, and eventually s0ix entry will be blocked.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index 1957fb098c4d..cb3dca4834b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -568,6 +568,15 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
>   {
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> +	/*
> +	 * The issue mmhub can't disconnect from DF with clock gating being disabled
> +	 * seems only observed at DF 3.0.3, with the same suspend sequence not seen
> +	 * any issue on the DF 3.0.2 series platform.
> +	 */
> +	if (adev->in_s0ix) {
> +		dev_dbg(adev->dev, "keep mmhub clock gating being enabled for s0ix\n");
> +		return 0;
> +	}
>   

A better fix would be to explicitly enable mmhub clockgating during s0ix 
suspend of gmc for this IP version.

Thanks,
Lijo

>   	mmhub_v2_3_update_medium_grain_clock_gating(adev,
>   				state == AMD_CG_STATE_GATE);
> 
