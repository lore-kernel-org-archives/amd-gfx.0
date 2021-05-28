Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F2FC2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 13:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC936139A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 13:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC936139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D3F6F5B9;
	Fri, 28 May 2021 13:03:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CD56F5B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 13:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btJpE7o46FOXggXWO6JzqRyBje0QM52r/Z0Hl8s6T3z3AwqF8PpPCakAsrv6oQhNwNUKNi207WPbInt3ZW4waQjNmRjt5+naV+xyue8Tw3liPMNh+iHewVCw71HArzPfJUvePs4y1zh5ff1MVXyVD2sxCLFbZq9+xsGSGqM5cOQ6Kvska/ihkS1T3Oz+N5XG3SjoWm1Ew74XpxiEZpNymecWqTabOBO53bre2jEqo6W+AM5I6ScHVqOwMYfObDTG8hKZfGI0+H6aWj72pld29yhDT8zQIUnvOVFwSmoWeITMarM+M0bI3fC4BOv42UdVTK+TYZ6yxGmQ8kNeALsL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/ELXWcEHLLBTsog5WIbAl7G2rme3eNayVo69VUCYIg=;
 b=VCdBylV30cqyaMBW1KD60WVTfyalBfhutWjMMFPCKWDxMCJf0vZeNfbstACnipSsz8zowkXNAMSOYaqTHQ6SRMpPpiZ77UyI2DaYJBFtIv8IH905OyIcgnaNVculGv8azpULuHx+Upmb4d6SSGNp4lKWh6z0OL5am0XPN8g+WZZ9RSpfDY66zMCSkVFSXHacnJPNqigpdyeRQLg09d7KCVLA7FX5pLPJOilS946IYyu3WQklEAjHXuC5jLdrPdt/AooNqN0GxV251Zuf+vdfBrxVQnw2Nh8JywqNHm5GPdQR7Epib6MJud5wta0zOEoVm0YI8XDS4N1jtowFL7y2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/ELXWcEHLLBTsog5WIbAl7G2rme3eNayVo69VUCYIg=;
 b=BEJVkpvp33r/F0kqHxVJfjqsmORR1G0Bpya/L62V8yZH6A5GWYKZC0AB2o81uxCRma6SxBY9ysSPAcevXHiVE5KWpVU0DwIWKcr/2D+wkQGJR8o6c4HTF7HsuW7eKapcrpop67UYJ69c0sFD2zU/9xa1iV6guDTAuAwo4mmqZF8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 28 May
 2021 13:03:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 13:03:40 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: flush gpu tlb after a gart allocation
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210528125428.3862-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ee3dbc5b-5046-ed6b-da73-2bb299b2fa41@amd.com>
Date: Fri, 28 May 2021 15:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210528125428.3862-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb]
X-ClientProxiedBy: PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb]
 (2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb) by
 PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6506e90-186e-4af6-5ce2-08d921d9038b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4317E99F0F7E25D2461F45BE83229@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie+tJbR10ssvN5/HtpGQZWCvAtTRdbkhH6EmV/m3pMNkkBV8SnV7sM01asyuHvFVJajvIFj0dgWBgEt4oZgewEdXXreYSbFZJmnRMkw5Ioo5HwRT7yrsKPH1HXZzyDEm0RAjF4StDmcj4gnU8ZbqOC++gR04HJSnydBGi+nEvXGWO/58atx7osmZk987mBhUJZqbIYL/rqAG/DXOI8elVuWq4NnoquH6+AxDNLcc6ussnoQVZVrcKkZynHkyTqd9R1jlXQkeKh2m9LL8uRjb1RzLf3hVe9yNeRNbJuvgNjdJ62ziwm1f4sW+dE8njwbnnF54INABQnxGOnjo6c7LgDL2qE1gDjzfzSfCYfVoDsdwvj3RmjURaatryfVTgNBKjLHMMaCs148GLMQUtrCcf8sPqlTt7X+IMWxK5LTBwbjWBEPUmCNfmHtltDsZE4xsTp6QubkvX5Fid3WLtDS/mI9ZrxQpp8nVWlM1OATgR+M2dMHIK6xs6agWtzllVuj0jLaP6KkSyH1uYTXfR2o4CCVrn0nbpRXNrE/zGIvMoauNNgLQr3t66ckxHtAzCmJa9xU8WKRuw6N9/S4ByZ8EiRo3hmcFEWk6l5+p6117xCjsmVd28oBIY2Odg4vDYBQMqZo0yyC+qaxEGVgr0wPXQvfE8Ltcy+veFxL2ETdsA56N+OYZNAHiKai0qEPjRaf6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(8936002)(83380400001)(31696002)(478600001)(31686004)(36756003)(86362001)(6486002)(6666004)(8676002)(5660300002)(316002)(16526019)(186003)(66476007)(66556008)(66946007)(2616005)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDR3SzdjZ0NrQ1B1amttWjZUbFlEUXM2a1JTRG1Bc2NWSXUwZmZwUDdldzg4?=
 =?utf-8?B?ZWdzK0ZpaFVMc2pQYk1TaVM4VGxad3pLM2JUOGo1S3p1Qm1aZXlJaXJrOGVE?=
 =?utf-8?B?YmlWSmM0NUFxdkFsNkZHQ3RyOXVreklQUmRaUnUwYXlqK2htOTRDRDJOUzkx?=
 =?utf-8?B?WVJyTXUxK2NOQnlrTzdVbmdBdVVleTdDbGQ3OWJNdXNzdE5pQWhPd3RWdUhP?=
 =?utf-8?B?YUE5UEpnWnhkaUFGY01yM0hHM1M2MUxMQTR5QSs4Qm85MFRKYUt5VkdCRklT?=
 =?utf-8?B?eE9XZlZFclhzT2RLMWZXVUVOSVpycEdPNFNNMnhqVk5VK2I0NDBjaUtiL05G?=
 =?utf-8?B?cThiS0lzTVNvcDN5WVJDTitlWkVEUUl1Zm45Q2NkMXZwVGxwbUdhc3d4dzVq?=
 =?utf-8?B?MmQ2czhLM1l3TXVNRFpYeXBOdkZ1ZEFRVGx5Q29GaUFwYVFVakFuMmFFQmI2?=
 =?utf-8?B?L1JHN2QwNTY0RlM3RWErL0ZRY3pFZisxL08wYmsyVCs0TmY2MnNkdEU1RHFj?=
 =?utf-8?B?OG9qdGhmWThjc2poWXR4SHJCRS9zMUNqOW9vaWVaQnpLWC90b09LVHVqTk0w?=
 =?utf-8?B?RmhtZitUWURnYTRpaWRyQnMwWnVaUHZndEZvSnNIbnk3YUNpMTM1K3ppc1pq?=
 =?utf-8?B?QTBmaWYreHZIOHBiSERCcWZoSytsRFEycEV5YWhUcHJxbjJ6bmx2TDhybk1P?=
 =?utf-8?B?RFoyci9UYXJxNXVoYnp0VUJMOVZjRDkzMVp5V0FPTCs0b2UwUGxoSWRFTWtB?=
 =?utf-8?B?N1VlU3pkREtzOWFyVXhCK3NycU04WnBhZ1JCQlU5RXR6QTRUOUdvcHlXa3Vn?=
 =?utf-8?B?eXUyWnZKM1psMjRpVitSZmJFQm93Y01SRXBkZFg4QW9xRHFxdStqYm12Z29J?=
 =?utf-8?B?QlJ3SEdwajR4eXNWYmQ2Qjh3ajZyOXdrbVFuZG9LZjJoclR6enUwNEFRM1pz?=
 =?utf-8?B?QUF3ZlpFcWNKeTFqeG91dG9BQ3YzUmxtWWczZVhwY2hFSjFaRkhwcHZETzcr?=
 =?utf-8?B?WWZMY1A4Z0xvayt6dWJhZWU4N3pqV0tlazZZNWFnT09aOE9pQmlvTGNBSzdP?=
 =?utf-8?B?bHdYemdGQTdic1E0M0Z4ai8vQ0V6UjcrelZtZUEwb1FWOWY3emU1dVFQTkh6?=
 =?utf-8?B?M1BNSlI5QlVVRFdSZ0FOcUJCS0FkN0RhVW9OMzN0clJQeGUzbGVCYWp3dmI2?=
 =?utf-8?B?em5vZnpOSWhZSmlWa3AxMGl4ZHNCN0lnZ1ZRZ2gzQWlMV3hjdVZIL2prV2Va?=
 =?utf-8?B?QXAvVU51bE4xdHlLQ1dJVEs5MDBtbnhmbVBrQ1cxSjhYMldJWmYrZzBsckJi?=
 =?utf-8?B?a0ZmczJwMWxrVWgwbTd0dDFHR1pPVjVTUmJGTFhuVE82d3dIODJMOE9NV1NE?=
 =?utf-8?B?WGNCMVBNVFVpZi9DL3F3cUJsRWJ0VjZSOEFuanJGSnBJRk81ODhBckJQT2FW?=
 =?utf-8?B?NFJCejVkM044cUdBY1FKdk1OOFVOTkdOdG1jZDFjdXVjTXpJWUMwNkp6eXZm?=
 =?utf-8?B?cHhvdnhGVzg1TVdyY0I3YTJ2SWRiOHFJRGpyV2J3WTN0cE9jZC83U2M3UFow?=
 =?utf-8?B?L2kvU01PMFdBZm1JNGN0aDhPTVl2elN1aGF6V0NsYjB5OUlTYU5ra0lBUWNo?=
 =?utf-8?B?Y1JFKzVyelErR095VWRlMHZKa1FSNVNDR3ovM0I3SUU1M3pmcEd4TTVPbGox?=
 =?utf-8?B?dldjeGlmRTB0TG1ibjNzSlJHZG9ZR0VldnFHTTV6YzJVTkVpWDJ2WnNsamU4?=
 =?utf-8?B?cW4zMW9mTU90ZzhwR3BwNThwQktOL1dJY1RrTkNoM1VVKzkxTXIyR1VLK3ZL?=
 =?utf-8?B?ZlNoUFFBV2Y0K2w0b0lOL1p4OXVzUFpPaXJmMWdjTExlRkVjbGtENk5nbFRi?=
 =?utf-8?Q?C4aXpTqdRb1i7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6506e90-186e-4af6-5ce2-08d921d9038b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:03:40.2929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sElTl4gU2VSZvIAyVGgfzCo9uQ9w6csixH+5pXoDVWJkjyoAigLNLlRAR1gLV08Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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



Am 28.05.21 um 14:54 schrieb Nirmoy Das:
> Flush gpu tlb in amdgpu_ttm_alloc_gart(). Also
> don't flush gpu tlb after recovering each BO.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 5 ++++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 5562b5c90c03..68d41063e120 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -329,8 +329,6 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   
>   	mb();
>   	amdgpu_asic_flush_hdp(adev, NULL);

The memory barrier and HDP flush can be moved as well.

> -	for (i = 0; i < adev->num_vmhubs; i++)
> -		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c0aef327292a..e68b5dab84a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -977,7 +977,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   	struct ttm_placement placement;
>   	struct ttm_place placements;
>   	uint64_t addr, flags;
> -	int r;
> +	int r, i;
>   
>   	if (bo->mem.start != AMDGPU_BO_INVALID_OFFSET)
>   		return 0;
> @@ -1014,6 +1014,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   			return r;
>   		}
>   
> +		for (i = 0; i < adev->num_vmhubs; i++)
> +			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +

Probably best to make that a function in amdgpu_gart.c to keep the GART 
functionality properly abstracted.

This can then be called from both amdgpu_gtt_mgr_recover() after 
dropping the lock and here.

Regards,
Christian.

>   		ttm_resource_free(bo, &bo->mem);
>   		bo->mem = tmp;
>   	}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
