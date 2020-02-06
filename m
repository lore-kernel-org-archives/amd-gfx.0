Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E743C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A389321927
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zPGrbnEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A389321927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669D96E34B;
	Thu,  6 Feb 2020 20:08:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340126E34B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 20:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d75FLtLnAXEDdX94YuwmkubYmyKoBGwroU46niJIQOa7Jzgg5S7Y73+vwN4u8NBZLqkWx+6+i2d8vqLN3k4IZdiS5QpcRWJmJIdqI9cqiezt9VbS9jWNBDzEoT+TpmLUl+IebazRsy1jP3q6nhZqAemGxEyFWn1ICxR5g/phzPvSZcGJaEOacKvqEZzxi2icXK8CZbmcHCzPXArGK3ZGCL5eVkOARsYLtnyBOVjrv8TWjPpvfFAJGH13vFkQXSlh5DU1jED7ECqT6iaHQLVWx/F6FBthkoUwNV8AUjcn9rGL/pryipUf5I792U+/TLF10RE25y0NdnUNkiDoevUonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNnmJ5313xXvI7d1GNhAsh2EzsN951HWP1qFHfv8UYo=;
 b=PznjuhBU3uPjM7w8f4hppFhYDTG4kzaJIT+/BC8kNLNZwr9/7c4+Eb69qLW58c7IWAf0OzEV2FXUwTsvsg74q0zxKX5ubh0YNbFRzAZL23P6FfyaaikMDrLj32gWOSuGWqhZF4OO7MpDmqrCkQzhtqGRRt5+/1f7B8Lftq5hIDhQVOXw/s5++SFX4g20xSeZUuzSG1D2oEmBIiP0eHIZMnoB/Gyqp9wB8wxq++XI1yp9Nx8KkkpawPS6kVf2CKnYJGsESjmX+SKZ5e6lkhwP72e8aNojVTP0dCWhM8sbfVh34oPfr9qhmFB38t/DI15tc2QU7VP2Klf7KFAUhw3Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNnmJ5313xXvI7d1GNhAsh2EzsN951HWP1qFHfv8UYo=;
 b=zPGrbnEFg//ulj4xX9dKMHKoymOxBMpGbslwJpl3qZLT1yfSnOiUcBqzGgWVmBftMVTQNXSAcl1nvOQRjkmGZibQSb41ZZ2va0ZqOmW4z7u5cROFnYmh4Pyp3XTfmJOYsr1vIn7ds8uVpT6inasq/+/1/VcXyCrnzcAMolwqVuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2491.namprd12.prod.outlook.com (10.172.91.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 20:08:05 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 20:08:05 +0000
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu pmu to use hwc->config instead of
 hwc->conf
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200206170847.39102-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d8b406a2-f920-6634-f382-58387894bf93@amd.com>
Date: Thu, 6 Feb 2020 15:08:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200206170847.39102-1-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 20:08:04 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70143de0-d72d-48e6-6f43-08d7ab4046b9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:|DM5PR1201MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24919122C2BAA19B341D3EF5921D0@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(36756003)(16526019)(31686004)(186003)(53546011)(16576012)(26005)(316002)(5660300002)(8676002)(81166006)(81156014)(8936002)(31696002)(86362001)(2906002)(66556008)(66476007)(66946007)(6486002)(44832011)(478600001)(2616005)(956004)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2491;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NbA4ETWqwGs/2/i/TavtLi1dRC3YJ4q3ViA+k/7d92DZnrmvQLrU0Ngy5gWP9Ts2IFBw3H2BFBriHPUNYrVVLhuD6vYNGjVpiVgBJo4MgrUqNUkpwlQuKFkv4W4qdfGhqVRYVU0JG6Xiu6d91qKvinbSlwV1xVs3nAsmJ/jHpOROrdB9gFWTgzke9AUHBvANNDHKaKvs9DgybfjJrXoUdipgOf8sVNc9oPae2eA8nFqWCrD0xJT5dWga44BCOPK1F+HFpU4RtX94jgbljj1ld+KkIjqppeuNQaFPE/WggReNrq1g2vLIVYe9OT+azaPxFfeOnBaK/qZt1ThU6rT9H6I12VWlgpqQCWGWzaOhSTUCwubgzDikUNSVXljiOAv4OnfnTkTVqtX9rv5hnB0ul3Oxxca9+v0UOkWO0A/7R8cjJm7v/CxfiNoOgLhAXjL
X-MS-Exchange-AntiSpam-MessageData: SG+9DuIaVhkfG+tqO165EVuYyaTjzFixuHbV/MOnwTI/eVPcHFTUB/JONSZZhQxNrbCkboT1+hUnu2szi6zp3zXeQch7uXBrfvPqTQLPe5f7L/L9fFt6IpKga6/0RH6wqQEK0sqJP9odq5F1Z/YMhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70143de0-d72d-48e6-6f43-08d7ab4046b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 20:08:05.1168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm3mDX5SJVICFfAma0a972VWBu5zJZPtTU7l2D6zXYWcVPM1x90aUvYKvzP8HNOfiC+UzE7X8LO00+0O3fii+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-06 12:08, Jonathan Kim wrote:
> hwc->conf was designated specifically for AMD APU IOMMU purposes.  This
> could cause problems in performance and/or function since APU IOMMU
> implementation is elsewhere.

It's actually worse than that. hwc is a union of anonymous structures. 
hwc->conf and hwc->config are in different members of that union. So 
hwc->conf aliases some other variable in the structure that hwc->config 
is in. If I did the math right, hwc->conf aliases hwc->last_tag.

Anyway, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 07914e34bc25..1311d6aec5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -52,7 +52,7 @@ static int amdgpu_perf_event_init(struct perf_event *event)
>   		return -ENOENT;
>   
>   	/* update the hw_perf_event struct with config data */
> -	hwc->conf = event->attr.config;
> +	hwc->config = event->attr.config;
>   
>   	return 0;
>   }
> @@ -74,9 +74,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
>   		if (!(flags & PERF_EF_RELOAD))
> -			pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
> +			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
>   
> -		pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 0);
> +		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
>   		break;
>   	default:
>   		break;
> @@ -101,7 +101,7 @@ static void amdgpu_perf_read(struct perf_event *event)
>   
>   		switch (pe->pmu_perf_type) {
>   		case PERF_TYPE_AMDGPU_DF:
> -			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->conf,
> +			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
>   							  &count);
>   			break;
>   		default:
> @@ -126,7 +126,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 0);
> +		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
>   		break;
>   	default:
>   		break;
> @@ -156,7 +156,8 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		retval = pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
> +		retval = pe->adev->df.funcs->pmc_start(pe->adev,
> +						       hwc->config, 1);
>   		break;
>   	default:
>   		return 0;
> @@ -184,7 +185,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 1);
> +		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
>   		break;
>   	default:
>   		break;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
