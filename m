Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB74C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 14:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D164F14
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 14:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D164F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91ED46E02E;
	Sat, 13 Mar 2021 14:50:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F6B6E02E
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 14:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGpEeLS9QV4ZPSHyxCqN+LZiHI86asyhAJhtWdJItNvznWAGaNLeywg9sAEkR4BRAHr7MVJaaOApLNfMGPEWP9811cX95pwo8Hr2HeaGzyoUNANfSwj14+NTOg3HIiuNYLDwEqUKZJBOhHaiUZzvn5bit1DgIDCNo2a0fxIFw068dTIsP8noNoDgNrHUbB35IRKGT8jOV5J3Yt9ERFwmInXTQkMygM2EtBCHvboBoV4J/9w4REm1m40lSzM+4cV66dRYRYLUJwDVp45o/CiH/5DgiymwT2hMh9hkhvpka3EU8xqUdPiVbRu28SmYbQqcATh90GTgHJfkJutOYYyKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoxDGv+dOKnRsyfCZELcBYPaJzqPTEQYEpzFPsIK5iw=;
 b=gFzfAplSyakFjWBJj+uNns868AlxBWyj0PrH/Sa4qgozplWTca0ORkFb4NDTT5XCxR890O37k7+0i2ygLZd51GGrrP+Bw+MO4lNk740ZqCfqeb00oa8EPSwfIrLnUnFdq/ZqNwywV05QsmwcRTLz20tVVI5RbgGZxAEIYGh2veGVT8X8Ug0EkB4XcW7HYTgTAenwcIj9aDg59wcieeoivGlRE/gZblHgsk+HuUKatnz+0JMlHapBmH0vc+9Ie0YasD0nvrwGx0z4TT3bfjUdhk8ywsUqWRn4GWPAaVWhYr9xIEl3sbjYtoOovneZJ3CbaNcnWXQwnHF/9EZ40lR+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoxDGv+dOKnRsyfCZELcBYPaJzqPTEQYEpzFPsIK5iw=;
 b=JIpQuU219Vafyomr/5dZ7nOoOhHoJfl9QMgoNlJ0ltBfrb0lxH8hS5vHv46tfo8QTcLT8LLUNsoufveTxqv/yq7dN04SGgSTrf0VKtc9+klby8F17KmM1MJJh1DOYsIVmBfxg6NlnaLOtvM4O2+96OftnjSAFbNF9Z1Y3hrW/To=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4779.namprd12.prod.outlook.com (2603:10b6:5:172::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 14:50:10 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 14:50:10 +0000
Subject: Re: [PATCH 2/2] drm/amd/pm: fix incorrect default power limit in
 powerplay
To: amd-gfx@lists.freedesktop.org
References: <20210312210304.23049-1-jinhuieric.huang@amd.com>
 <20210312210304.23049-2-jinhuieric.huang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <caa6be97-179f-d20b-04a6-1ebff74484e0@amd.com>
Date: Sat, 13 Mar 2021 09:50:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210312210304.23049-2-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:94cc:f8dc:e7db:eaee]
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:94cc:f8dc:e7db:eaee]
 (2607:9880:2048:122:94cc:f8dc:e7db:eaee) by
 YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Sat, 13 Mar 2021 14:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a5b84c2-6500-4326-f072-08d8e62f4cee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB477930DE97E3F4FB50EC2602826E9@DM6PR12MB4779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgK47qGCI4hfa520VP0+lXotbhp+0EHHwueAiQIlz4Xb6px5h4I5StBGSCLdNqmdTbBpSJJhmVKMPAOP4AiuA9R92hrqGSpHM5icwwaAm4Qm0FPJMR7I6wHize0pQ5LXRVdbGl7PkdA68PM8+vrAvLcMDofGBFA3x4mSIrtVvK97Y2daZeRloMszCIjGGF6u60hKA6KVu4DvI6yZBja0eXDMlY5k1fw+vFaVKAxeHuKDCLySl+VtlzMX2EJ7hcHsXAvf+G7RoTGjHTdAGVdgxel8WU8G/1MPkWY5nij3rp0ms8X1SwwnF5n44nJYddz9aGA7mhypgT+/ErqpkvFIfvTYnxonA1UKFt6hSIpu4QQz/jbSU9BgQWOSVfNSYZJdeAg1gSkZmVjaJUw8MqWxzw980NUi/anmsiJwym6IHlLLQwX4+fMm6e28dQ2rj32cxmJzCUrIcEdI9nhkHekoE/+nDzac09mU6Wu92g+4EmR2XtA4lHQq/cfs9DySggYV+Gq6PRdCWLxgmFrPfw5DvTg7VvTLhhtsrYvyeD6cw4KMu7Ks7RsAz8NR+o8Eh4cDioK6VRp85rrrYC5XrhwmJ/jf6QNb4PiFeTb14YR1vBvULHCE/znBP08hv51L0TKI+lCTfT65SDr65g6Qs6SsVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(86362001)(478600001)(16526019)(31696002)(2906002)(186003)(4326008)(66476007)(83380400001)(2616005)(8676002)(66946007)(66556008)(6486002)(6916009)(36756003)(52116002)(8936002)(5660300002)(31686004)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?US9JdVozTUtzbE5oSC9QWVE3ZlAwV1lvN2RCcGwyeENGYUVvL1Y5TG1lcGl5?=
 =?utf-8?B?dzdFeTZqTGtJN3JvZENHSmJ5OGRsaUpGWjRqMjg2QVpReFVHZHN2ZlNHeWxJ?=
 =?utf-8?B?VlVwQjRMdmxBcUkySjZ6TFRaaWw0U2VPaWhOOVVDeXV1c1dBMmZNVXcreE85?=
 =?utf-8?B?bEd6VjhkbTRYQ25vZzJ3aSsydWthSmFtbHpxOVd3eFZpY0F2WGg0MEpQL2xS?=
 =?utf-8?B?YURxbnZwdEREeDNQTFNBLzEzRTdqVy83NHNrekRyME1pMGxESjVkWURpcVJl?=
 =?utf-8?B?OGJoNm80ZWZLejFMTkdIR0lqN3h0UWEzY1hLcjNLbjNxYUhUQlJRR2Q2RExJ?=
 =?utf-8?B?OEtOOXk5ZjNsUjlBV29YNzN6NXZIWFpaaXhIT3hUcjhGTndTelVYaldzSW15?=
 =?utf-8?B?UWJaeFVoYnpyd2syRFh3S3ZLYUNQZ2Vlc3NtcEM4T3FVTmh3ak5PWTBJOGJj?=
 =?utf-8?B?RmwxVDc5ZCsrNmdFV2NRRUc5WFUreXhncGhMeVFKUDd1N3hoWTFzSXgrT2Mw?=
 =?utf-8?B?Y3B5ZUg1cHJPSGNIc1Y5eFhTQkpMRFJNa3ltZTEwdm5vU3FQVkZMemZnOThn?=
 =?utf-8?B?Tk5nU1pkT0VKdlo5ZWxRUk03cDYzMGUveHhlc0pZZmxkc0tNdFdpcVdiWGRi?=
 =?utf-8?B?K3k0TURyYXgwTmJUOXhUeUJSSjgrL3lMd05oZWluRmpweURUUzBSNzVPMFZS?=
 =?utf-8?B?eGQ2VEFkbFVYWWpvNFNNWitHKzFoZEtkOFVjWDNmdVlWWHlGY0xCM3d3Ykk3?=
 =?utf-8?B?UVZIaWF5NVdxeVE3c0NVUm5raE0zUmtjRmFtZExxZTFxM3ZXNUdLTnBtTTdn?=
 =?utf-8?B?SmRPOW55YTIzVWd2MlU1ZHY0bHpaNmh4UmVCdW9XWklnK0xBWE8xRFRkSWdE?=
 =?utf-8?B?SFNWb3huL2Ywa3VleDA5NHhXWC9TemVodzFGSTJ2REdra1FVWXdoV3BRT1hV?=
 =?utf-8?B?Yk9kTUkwMWlQaE5XM2JYd0UraWtCRDBRWnFSUFJoR2NyUmdGS1hZY0trQkRt?=
 =?utf-8?B?MHRRQ2c3WDd5RUkrWktreDJQajE3K1BYd09rNnBjaEw1YWVlZ1V0ZlpSdWts?=
 =?utf-8?B?TDg2cmtFZ0ZtUU0vQ3VRUk44SXJTMjdwYzdXOStZNG0vMUlic2thcEVsMzM2?=
 =?utf-8?B?ZEhJZGxkZ1JNaUdPalRCc210REdsRlhkK2J2OGFNZEVISEpyVGxidkhBR2U3?=
 =?utf-8?B?a1d1KzRBNDhDS0lKY09qcWNnNmd5Vk9sRXNhclhVRE1BU21SM0NWM1R6aFFN?=
 =?utf-8?B?djVBVmRBbXJxNGo1bStvOWRRUU8vbnJDdHRKZDFySHNISzFrc0sxa0tCdUNZ?=
 =?utf-8?B?ck1qSThQVnlwSlhzbVUyQ0M0VXBuQ2JiQnRCaTM3MnFYZUFEWDdUQzNsOE5R?=
 =?utf-8?B?aEswNDUvOTQ0N3hhTWtoVThCaEFRTUFTU0FsN0hlU2ZRL0NIZHZQRW5rTS9h?=
 =?utf-8?B?b2w0QWRBOS8zdUVTWUk2SjdBQjJvSzVOb2VjY0ZxSUZyTm1qR0ttM1NURkl5?=
 =?utf-8?B?eXI4T2VtbFJmTTRYbkJMcnVaR055VTRzQXlMTWRyVzNBVEJValhHeWhDdDNt?=
 =?utf-8?B?Vnl0c1loR3RZNmppdjIwT0tRZzF6UU96MzJML2hZejA2Y3RIc3VyTG5RQmtx?=
 =?utf-8?B?dERQcTd4OUl5WnFVSU9oZXA2Zzliejd3Y1pJdTRSaG0wOHlMUUZuZGZQTllG?=
 =?utf-8?B?clJHTk1nOElQdFVSTG91U3JYZXpFYS9rcWttSkk0ZVRWdzlQMXhLRlVyN0hh?=
 =?utf-8?B?YnZvdXNlTnJKQUdwTFZtUUxmMUc4a0JZZTZOWE4wVHhCenFZUXRVdThnTWJW?=
 =?utf-8?B?NGgvWDFGU3JiR2w4V3laYjdIM0hqalQwUS96a1p0YTFkemxtbHBXbWt5cHNy?=
 =?utf-8?Q?8H2mOTCnNJbqn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5b84c2-6500-4326-f072-08d8e62f4cee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 14:50:10.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8p3r1UuZOC9hUwXxXTYP0XaJHK7hwePDIx832VZ0PdC2FYvL6cCXuuf1GJhvpd/7gRyB7/MyLxJbEehGqrliTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4779
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
Cc: Evan.Quan@amd.com, Joseph.Greathouse@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore those two patches. I found a mistake and will send new 
ones for review.

Regards,
Eric

On 2021-03-12 4:03 p.m., Eric Huang wrote:
> There is no difference betweeen max and default to get
> power limit in powerplay, adding a new parameter in the
> funciton fixes it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 12 ++++++++----
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 11 ++++++-----
>   3 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 79e309a789f3..a0bdb0ac25fa 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -288,7 +288,8 @@ struct amd_pm_funcs {
>   				uint32_t block_type, bool gate);
>   	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
>   	int (*set_power_limit)(void *handle, uint32_t n);
> -	int (*get_power_limit)(void *handle, uint32_t *limit, bool default_limit);
> +	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *limit_max,
> +			bool default_limit);
>   	int (*get_power_profile_mode)(void *handle, char *buf);
>   	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
>   	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 8ab6e7eaf6a1..23b6cc1746c1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2613,6 +2613,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int limit_type = to_sensor_dev_attr(attr)->index;
>   	uint32_t limit = limit_type << 24;
> +	uint32_t limit_max = 0;
>   	ssize_t size;
>   	int r;
>   
> @@ -2629,8 +2630,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>   		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
> -		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
> -		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
> +		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +				&limit, &limit_max, true);
> +		size = snprintf(buf, PAGE_SIZE, "%u\n", limit_max * 1000000);
>   	} else {
>   		size = snprintf(buf, PAGE_SIZE, "\n");
>   	}
> @@ -2665,7 +2667,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>   		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
> -		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
> +		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +				&limit, NULL, false);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else {
>   		size = snprintf(buf, PAGE_SIZE, "\n");
> @@ -2701,7 +2704,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
>   		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
> -		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
> +		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +				&limit, NULL, true);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else {
>   		size = snprintf(buf, PAGE_SIZE, "\n");
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index e0d288208220..b60f46b80ccd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1034,7 +1034,8 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
>   	return 0;
>   }
>   
> -static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
> +static int pp_get_power_limit(void *handle, uint32_t *limit,
> +		uint32_t *limit_max, bool default_limit)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   
> @@ -1045,10 +1046,10 @@ static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
>   
>   	if (default_limit) {
>   		*limit = hwmgr->default_power_limit;
> -		if (hwmgr->od_enabled) {
> -			*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
> -			*limit /= 100;
> -		}
> +		if (limit_max && hwmgr->od_enabled)
> +			*limit_max = *limit *
> +				(100 + hwmgr->platform_descriptor.TDPODLimit) /
> +				100;
>   	}
>   	else
>   		*limit = hwmgr->power_limit;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
