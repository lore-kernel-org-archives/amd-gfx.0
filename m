Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7E6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8F023437
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8F023437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F0989A83;
	Wed, 20 Jan 2021 22:34:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD9E89A83
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 22:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs5wJ59+E0Gub/s3YF/BaWRDgZOE7glkMMlBLEMSA0Eo1QgnI2GCIz1YAI2npIrzZCTzb30ot3MQB6s3ed4EnJdQrct0xDH0iN/fK2/AKzGs62vpOsyFkvhlDF9KRLdkvXnaJWy4tcQP9iLXNAgAEvwraXTWLNwC6Tc5vKnru42/IJGui1JMS8QQR8t3CA+PWrOlAX+G47u2eyzpHLJQcKjE/lRqXiTXFVnOqwWKOr5p9eWsizDzVRRonJt+gt2IkyEUD8Qax4r4NtblL9oWA+2nWNhpJAUk5soMUhJocWdGYwNdtPDies4OLZaUUNBmO/SlII0hC/cek8roVMfUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r1pFBGAjLvc4mSGp8hmbMpnkbZjfoyho/7LSYTWGBo=;
 b=jKJ+ef8gkxykrK3LNc6VDEzTAWYF8Rn6WxiMb0O6aAmi7vyYn6JGC99M+aJQOyy8zap2PO1zAnB51cz2WTYOl6mIWLLnSUVUQn6NgAT3Afn7ntaxcr2ZBYYitgumqLZO6Y2nhwPGneKhT2oSEqT09Huc44CTsV6EpTHRATfW/2bEljtDJjzF92vicswEUWCMoBHPS+/jwIRZ39nz30uE03Qh8XfWURtsj5gMoXcQgLIwWv0Ynv+q7EpUeVcgr3X9rsIqv4NpIOHspQag4xZCeIL/M37HiaDaqNaa8MrTVMejyc8cOp7PlZgYqDfS7P82xPIAg2dthYcyMYnC+dZtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r1pFBGAjLvc4mSGp8hmbMpnkbZjfoyho/7LSYTWGBo=;
 b=mwBCia7s+O4Tkk0La+Gpd/hzCPFisx7WUIwifvbFoogfphnbKIqsYbhW1DO6mR+QR8yaLufD0IhdK3haZEi4HmNlFLw6NlnDHrJ+v5rZMZ0CGh8pxzhaoJ7o0FVZVB6eErwkWNMwaEL6hVtTRY+adxut3bfU+UZ8zHzsRDjWDBc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1229.namprd12.prod.outlook.com (2603:10b6:300:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 22:34:11 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 22:34:11 +0000
Subject: Re: [PATCH] drm/amd/display: Fix unused variable warning
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20210120172306.276209-1-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <e1b030a6-36f9-b1cf-3920-69976722dec0@amd.com>
Date: Wed, 20 Jan 2021 17:34:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210120172306.276209-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:404:8e::15) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.171] (165.204.84.11) by
 BN6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:404:8e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1 via Frontend Transport; Wed, 20 Jan 2021 22:34:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b60e7db-1343-4c6a-edf3-08d8bd938216
X-MS-TrafficTypeDiagnostic: MWHPR12MB1229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1229BA62E3036DFD5FE31A278CA29@MWHPR12MB1229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSn9wgbfvjd5SzZggHm2sXSR+LxLotQ9ONW7BAIiplAIEkQ9w1knZdLIOzgXUqYbJQtjOuXaltF7Mh0Hm99ri0oKk7bHD3u1G0jRYLrrYnYxfp5hSsxTvxKM0AifKpDlPCkYE6hIIkCDs4of02/jsi9ovrDLZNsH5n+wtNYtmvOziuTQreHuUujzPhTMvb13uvln2Nr2nfBCe56M7NmlWYR7bXMLqJhyzbL9egq/0fLIweel11zmPgSMmKjjO4ZNKyoJ3/MI46C3mIEJAjjXGhAatarVzdtDtbypXhTL0k0sYO0NTIlwLbUroIk0qKS02PwdOThIKFfoNZuIvD+aszx7I3kmAyDSiiyQCfNdM9OYFQgw8v4HFpT62wtUqq/rPaxYXm+TnA9MO1R1LlF61+XZpwFR6IMfLGKJ/0KjxDwU6vBLFaD1cs9WzUVejSp006xXjef3/Ef8ObX/FlKlPyOVugKxPeMfBEuCyw9vXHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66556008)(44832011)(2906002)(6666004)(83380400001)(5660300002)(6636002)(956004)(2616005)(16526019)(31686004)(26005)(186003)(316002)(53546011)(36756003)(6486002)(16576012)(8936002)(4326008)(8676002)(31696002)(52116002)(66946007)(478600001)(86362001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rm41a09FYWVOQitGL1hJSjBLampxd1FnQnNMYWkxZ2lVQjFEK2NWQkRxZ081?=
 =?utf-8?B?NkpiU3U0MzJoUTJMZEg2WG1NTGxFOFpqa2lkZmtXT2VPVmFlaUJ3SjhQZEZH?=
 =?utf-8?B?MEdwR2pyL2VFZDlndTljMm4vTk8ySkpGcGlySlBOVk8yN09xMDZqVmRmalor?=
 =?utf-8?B?M2lJejBUUEwzcFNrcG1hRVdhQ0pYZ0s2ck5hKy80RzNZRVpWeWZoREZMcTFW?=
 =?utf-8?B?ek53SHdHSHorTzNhMVhjdUhaWWE5UGt3YmtmUmN2TzBHalJmTnRUTkRWK25o?=
 =?utf-8?B?QVlxeVREYURFQW9TMVdPSU50R2FFZWhVTzcyYzFybElJZUdWb0FyVnBpTmRM?=
 =?utf-8?B?Y3l5ZytvWW1vaDBYRVJjNXduQnlaR1NUMGRTaGNrWW9QYlBMdUlmQnprRzFS?=
 =?utf-8?B?Zng2UGtIcGIxZnl1VUhZTDdtRllsejJKSWJXYWM3RmNjYkZJdDZNcHV2ZW9k?=
 =?utf-8?B?MHRsRmZ3c2hJZUtEWFVTcW1HU2Vya2dSR0VtZHE3eXRrUENPOWpZR2VaQmkw?=
 =?utf-8?B?djlySUhPQkErSmZyd0diRHdac2JkTmlUNXRvakkzTzR5MzFraXkzK24xdCtv?=
 =?utf-8?B?c05OZ2NTZnJ2dmFySUlQL2lzQUtsbWZBc3VPVGc4eXBSZVEvK1k4Wlp3Yk5u?=
 =?utf-8?B?UG9KNlFEV2l4RE5MZk9ocWlKclp4VGYwYzVYQm1oNkVBaDR3c29rS1R4K2lU?=
 =?utf-8?B?NzhSbnFqT0wrZmRrVzVJa0hndDdmd0tLL3dYS2JzQkpvZ0czOHlSTUZuNHRB?=
 =?utf-8?B?SkxNZGlwajJWN3ErWEF4bWdYZE5hbk9sQkpoWjlMYlQwQzMxZFJtNW1BSlhS?=
 =?utf-8?B?alhsL2c3enpNNUZrRW5Xa3gzbTBXY3NwOThWY0JZcEtYZmwxV285YzdpSGhy?=
 =?utf-8?B?elRRQ3Vjc2lmRE4rMmRIKzl2TUhteitjTXhOSGppRldTWkNzeVhTdEhCWlFV?=
 =?utf-8?B?TzVWQXZjYlFDcFRMbTBBdXpwVG03MGl2dkxWT0FuOW10R3NDTEhwV3FqaDM4?=
 =?utf-8?B?dDBEVWJKcEsrTDhZSFpwdkhxRnhsaXM1WVAzcXNwRDBqQnBtL3VQTnExRllu?=
 =?utf-8?B?cStrdy83ekY5eTQyWW5PRWh5V2ZYblZRL0ZPZWl4UjkrelRZUXVpL3BHZ3hh?=
 =?utf-8?B?OU56QlhCdk5HNVZFcXRPU0lEdVFYb1RPcENhVWsybnFFcGNNWnovd3l5U2dJ?=
 =?utf-8?B?OXd5Z2pQUGdiaEhTd2toMjJsVENYVlpzQTRqTjFNTXd0YVQ1cEZjNkZzOHF6?=
 =?utf-8?B?aWIzeTB5aHdnOWdjNHAxR2htUytOeWI4YUl3TWdQZjZvZlJLQzVhQ21aWmox?=
 =?utf-8?Q?9uZeMgwj5g/9d/Yq+kHKwQVWI0ewjNiNCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b60e7db-1343-4c6a-edf3-08d8bd938216
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 22:34:11.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqlaPkviYw4ZfnZgDbb47wh+MYx3lLcTsJUwipUMzAl9syQv1BOyTnPLGEH4IdxIQ2unG7Jp41TbTmNoFqqa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1229
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
Cc: sfr@canb.auug.org.au, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-01-20 12:23 p.m., Bhawanpreet Lakha wrote:
> [Why]
> The dm struct is only being used if DCN config is defined and this
> causes a unused variable warning if DCN option is not set.
> 
> [How]
> Remove the compile flag so the variable is used (there also seems to be
> a duplicate guard due to a bad rebase) so remove the outer guard to fix
> the warning.
> 
> Fixes this warning
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: In function 'dm_set_vblank':
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5380:33: warning: unused variable 'dm' [-Wunused-variable]
> 
> Fixes: e177af8a43da ("drm/amd/display: Fix deadlock during gpu reset v3")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 83ec92a69cba..7c188c8eaeb1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5472,7 +5472,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>   		return -EBUSY;
>   
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>   	if (amdgpu_in_reset(adev))
>   		return 0;
>   
> @@ -5492,7 +5491,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   
>   	mutex_unlock(&dm->dc_lock);
>   
> -#endif
>   	return 0;
>   }
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
