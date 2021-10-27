Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D98AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E156B60F6F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E156B60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889EA88F93;
	Wed, 27 Oct 2021 14:29:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C5388F93
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUMvJGgH6dS8jvk213+U1vTonFbPU4RhheITApFOmmSKE5WkacMtso8aCvfdHW0a1cm6ebtAnfpTXndNu5bdwLaxvVTKDxue0tEvVLXXTmsaHd7FkdxEGaHnm4bElIEMmLOIbW1PdKPNnHVRDh+L/wiTRkX7qwXpX9RLSvB71hkY/ffUbQ83/GEmHK1QSXk+TQxxbb38syW6KD195GGCZ3zFZ0xcYZXZYlMfK2FqIjt0OOMhlNKv4FsfZx09dh4eZRDlH/FMjZApq+WUez/JKXPHzk1ZDClwxt2bPqW7zddcbNPzguBoaxk0OCOQURCSg1GGEMUL9K/k7UFlF2Hp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk8znvjMPkSXLJUvr+lEeZWPTE2BCCI/7goDjjnt9fQ=;
 b=HRrhZkI1pcSdExHY9SHAeMWuz2Xx4oOKbQnOcYMC0dsoFVUl8hmCT4o3L6p0OjEmZuThDMxGMyUfKYu54ptQbmnqFdojlzLq+tL+z1ruAur8WSCaQ3Y4knDUk7SpixeOJXeWiJv8F/iRt+A8VCvJVH72bJWgaDb6FXk0yl5528ZOCibuBsEZ6yV1w7ASAMEvHtOREuh3aue/CNQxhnkJhLAx3Kbo+qDwNv+yIYAug5OX2G7WJu7IFwTpS/+SDSqTasUaPCR9exoUE8iClK+HVV8noWRwGSAmQu5zMguAZe4fbV9qH7uvT7GIovY1lwtUdiF4IxCkRYc7WXI+KrwEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk8znvjMPkSXLJUvr+lEeZWPTE2BCCI/7goDjjnt9fQ=;
 b=FMIAO6+VC/DlMcGmGru/O7bTC9vk7ZqEOakBKEQa0xjspsJB3MRA4QFeprUKGBKVEahgkD9mifZN4hLczvUwssjkk4eG9m/+hoo1qLMGIE5xn6PgrHOYV4+sZ70Bcewzn3bQ7fyfgLS1AE1qVPR9fnhpV6DN2HeHEHcdpjDgA+0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 14:29:51 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 14:29:51 +0000
Message-ID: <a550d734-0a2c-c1eb-f73e-056a144369f2@amd.com>
Date: Wed, 27 Oct 2021 10:29:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix even more out of bound writes from
 debugfs
Content-Language: en-US
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: tdwilliamsiv@gmail.com, alexdeucher@gmail.com,
 Patrik Jakobsson <pjakobsson@suse.de>
References: <20211027142730.1962-1-patrik.r.jakobsson@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211027142730.1962-1-patrik.r.jakobsson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:408:fe::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.37.48] (165.204.84.11) by
 BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 14:29:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74b78ccd-f5cc-4a3c-12cb-08d999563cb1
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475A93B063F5EE2A2BFE8BE8C859@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9aEyOQAbAvLQk411EIarQE08+evt3ipuJLK3CHBdlKg7Mg83x6vA5iIYd1lipwkbjI3u7XeJ+fzfUoUw+mwLwkAJm9wHfv8zZWy8FnjU40rjKmm5T9R8WnE38OoKQWP9avtCtoiPvDNHIfWbT6Q6Lpbdm2OidjeKRlo26fBpR5LAb3H1if/ekpSM3M+7SdBYyGRWC0ttOc0sjD4WjcWctwUUFaVAYJ6DV6istMvTWmIpIsCG03Dz44/0pFNKGusVU1+msl37zILeIjmYESBI6xkXuE8QE0Rkc4QvX0mSXMkf1fkXnEZYxaGTZtQbasCmKmVXHkmnz++4Lm/fNFyApqGMISG1/hThEeRF9b/HRkSStBvUdVVlzIxcLoWtbZSSJrwTI9ITbC54SZBw2HyR+WqK4u/LUrKmTj89+2xtqRAbewHu7zv8lnhzab1glzaPKXisOhF3PBxCXAo9g3FQQrm/bDdFbNNNVmYnhqez5BeBv1bIQPYZzX97LZzj9uDbTasX6AeTP4U2TbJQCShRN+G+94eY7qWbXTZDrIE+Nx0bMdoUnmCVIBhWybzfpA4u+OPBtTEqj/HCd1o4DZRlP9bU4l7aNhTareidtf6mxFh+j3UmXPRV3Y5RsJ38jfq333Lb371HnCGJicqZvjBJuE4LomhPy4s+8cZIoBRnGJJr1hqjHYwR6+xj+KTgz07jTLfDbtzGvO2iZoDojrJMjcWqegwqqvkqKJrvdmohPFTJPzV7u7/86RhXhJ+lkmP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(316002)(186003)(26005)(31696002)(6486002)(4001150100001)(86362001)(2906002)(44832011)(5660300002)(36756003)(31686004)(8936002)(4326008)(53546011)(83380400001)(66946007)(2616005)(6666004)(8676002)(956004)(66476007)(38100700002)(66556008)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R083OGU2ajVjcFNDNTQ5S2htS1dUd0Q5OEQ3cmN4bXh0YklzcnE3UU9yLzVT?=
 =?utf-8?B?ZXBRK2c5U0kxVmY1b284eVBuRHpsaEtQWUhSblJLR0RCZHJUTUJFdm9HYkhC?=
 =?utf-8?B?bno5eG9ROXQ3ZUVQcVF5S1c3MU1ZRDFPOVhjVm5mbVBXeXdRZnJocldyeW9M?=
 =?utf-8?B?Z2taNjZHMEI2ZitYeDQzcGJPQzNnVkJCVEFRY3RrQ2J2YVRWOUZrTlRYZi9u?=
 =?utf-8?B?MFowcDYrdnBOUXZEUHo4cWlGZUJ0YkR0ZUo2N0FGbDZyRXRGSzRnVi9WS0t0?=
 =?utf-8?B?ZnBoRVlrNFV4VlVGakh6YnMyS0JUSWhUMmhlaGJiVmYwUE92dU1jalkwWmFD?=
 =?utf-8?B?cit0TFJsako4UzNyRE5PeHZMcm4yYlQwNTFmYVc2KzJVUk5tWTE0SUkwQjZB?=
 =?utf-8?B?d0ovaTBNODhyRytBM3U1U3FPU25qdWJKazY4T0lacEZBanB4Z0l1cXZQRlhT?=
 =?utf-8?B?cGloQjN5d2JUU1RUek1yM3pqZThNaHdNYTZrYzJWR1lJemFtU0NLajEvSjA4?=
 =?utf-8?B?cUl0bFY2YUNBOHZ3VGhVRnROMkVmQjkrcytGc3RyWnpoRk5lRWhMWmt6dlFS?=
 =?utf-8?B?MmZ1aDNXL1hTbDV0bkZhMVRLYzQ4OGlIbk81cjVXZmxTRDcxOTRnbUhDallq?=
 =?utf-8?B?ZC91TWFZMzQyTHdWOWx6ZFc0c2hnL3c5NnNDM1ZvK01DdGdVcW02OGFQM21o?=
 =?utf-8?B?MjdBVTRQcy93VUlKS1p5YVdnYkhkYm5BTFdrKzUwQ0o5aGVVdmY5WU42dUs0?=
 =?utf-8?B?KzJQVWRZdGhFNkh6MGF3bytUK3V2dEt3M0xYVTZRUmlzZ1MydkNvM2FHTFRW?=
 =?utf-8?B?cUNsdjRTdWY0Y3pFa3pZSHBMcXBlV3I2YnVFMjJOTW9ETFUwL0hVU0dVRXpq?=
 =?utf-8?B?RVI5S2JnODBzYnlyeXZGREFVNVYrWTNRRDhnaDI2UERmQTdIM2k5MzlTTXdD?=
 =?utf-8?B?ZXhGTHlEd3BaMkZ1azVIdTBPdG9OOHZDUWNuaE4zaStySE9YU3ZESmVYTWow?=
 =?utf-8?B?aWJEQ1ZHNENiYTRtNWpnZjBPRlRkZFY2b0x0REY3bk5Bbk9rSS9Vc2cwUXRz?=
 =?utf-8?B?VzI5VGRJWHlBMWZ1VlFKOWhKcWQwWVNJcFpneXUrOU03NW1BWi8xa2hMTFcz?=
 =?utf-8?B?bHY4OUhHaVd3RmppdGpLRVNCa0ZhMHFlOHdLVjZ3VzEzMC9UMjN1MitGL1I5?=
 =?utf-8?B?WHZ3c0xDdGtSVlN2V0VWN1ExZ3Q5YmlWNUtxck9xS1NuNlh2M0tlR1RkUlRi?=
 =?utf-8?B?ZkJ5VklRaXZMYmduWlZ1MUQxUkRLTG13NFZpZmN3MU9ZanBGTGdVVWphcmI2?=
 =?utf-8?B?SlEyeHpGK290dHdSZU1sTUdoajZqNjlvK3dvUFE5UlF4UEd3c0E4d0JrczZL?=
 =?utf-8?B?NndWK0tIWTJGTHl2Q0p0OGdIdHlCNXN1OHFodGVtcGprc2JQekFTOWNVTlVt?=
 =?utf-8?B?Um1RYmtSUndvMEowOWN2WklHRTMwelNFb0F1NnJSR3B0ZURzZnlzLzkxR3lx?=
 =?utf-8?B?SmhTcVNSaDRaZDVjTWJ5NUpvN3lBTFEvT2QzTVJlc1FHc1V4L2QzY0NOQm1r?=
 =?utf-8?B?cldXU3JIM2hIcFRZMCtrRUJkbVU5eE9OSGwxbFc3RUNiSjVLMDNMaEJkUEtj?=
 =?utf-8?B?Tmp4ME1PcS9IaHJoMlh1NUVRVmdER0VYWFVlSW9yaldzck1MUU1oaTJYdC83?=
 =?utf-8?B?QVRUVUlzT3FMeVpyU25nanpZK01NSjI4VHo3eGtUZjZxTWMwKzRXd3hTZjRn?=
 =?utf-8?B?YUNic3VOWHBKWmlaWk5uZXVDK3BkSkNLTjk1ZE1LZ29sMmVNWFZDeWFEWHls?=
 =?utf-8?B?VFRPOHJYZjVEMXNEU3pyOEkrWGk5aTlUVkgzMU5MOU9LdVNIT1hmaFF4OHlZ?=
 =?utf-8?B?RE9CUzVabms2RkFvZTFvNDN2eXVmbDVtYVNjTmoxK3B2anorSlhQMDBET1Np?=
 =?utf-8?B?TFRQR3BJaGl4amtzaGRUWkowaldhemVYQUtqNzVTUUdua0NTbnkvVDZ1VnZJ?=
 =?utf-8?B?Q1J0MmxMd3VabE5RYnIvYlJEdzRuWnlWM3llOVQzRlZuWWNsVUVnZWFlUHU0?=
 =?utf-8?B?ZGdSdGFKTkp1cjNSd3Y5VldyOTBEVkFDb20rZ0dXWkhCRXF5MUpJS3ZaU1hz?=
 =?utf-8?B?VEZoSStabXNVNjRIc0JRN2h4alpmdUpPWmhpS3lSSS9MREZKdVkvR3Y2Smlv?=
 =?utf-8?Q?5qCETqSTMlAPiz/oAiJRplM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b78ccd-f5cc-4a3c-12cb-08d999563cb1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:29:51.5972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GGDXgh/YB1FSqF/ZMA8VhLO4H4p+Cmfy7AYlKJUfuAnmui7I5HI6UeIzZiYbd+sE4wX2UT61Q2WqUUGu8Z+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-10-27 10:27, Patrik Jakobsson wrote:
> CVE-2021-42327 was fixed by:
> 
> commit f23750b5b3d98653b31d4469592935ef6364ad67
> Author: Thelford Williams <tdwilliamsiv@gmail.com>
> Date:   Wed Oct 13 16:04:13 2021 -0400
> 
>     drm/amdgpu: fix out of bounds write
> 
> but amdgpu_dm_debugfs.c contains more of the same issue so fix the
> remaining ones.
> 
> v2:
> 	* Add missing fix in dp_max_bpc_write (Harry Wentland)
> 
> Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
> Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>

Thanks.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1a68a674913c..3655663e079b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -491,7 +491,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -643,7 +643,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -918,7 +918,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   &param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -1215,7 +1215,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  						(long *)param, buf,
>  						max_param_num,
>  						&param_nums)) {
> @@ -1400,7 +1400,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1585,7 +1585,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1770,7 +1770,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1948,7 +1948,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -2386,7 +2386,7 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> 

