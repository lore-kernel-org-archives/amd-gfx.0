Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A228CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4252921532
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pF2mq46m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4252921532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6706E177;
	Wed, 17 Jun 2020 20:16:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB146E177
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 20:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUNhZWLE5QY5x+U+8pxwyf1db3Y3YBvytS7quRoRDwnAVCv8YFg4+BZjwjR/WCGPuHgSBIIzvyT9mpeFmAa2nd+luMwyLcHguRY8Kb0/9yr2m8MjbGSSu2rzwZymSoGFEoUB8ho4lNJyKnzTLFDhMMlL085lO+fDv7wfVHLYMoRqb8u7c5Rud7Klzmkc0LWSjrFHtYs4Bxda2HHx9sDZwXX178WJAd67yGA0HX9ooWTy1Okyx5oWQgNrlj1EJ8eWAWLOr6objVJucDG97oe3AHiHHVANhvJnZ9/sr86wTezBaNkSdu0an4eZleg323l3qtR2tbA81Ic4Y69Dss1hSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkRUvTz3gJPzj+vGC/fyN1Pij/nzyBUKDNaz4fFgWdE=;
 b=J/9mJQbXB0YI91/nBgefDM1/fKhuDGXOJAUzOYkPxFJ5X62ztaZQ+euxSXhe9tEhGcnlEgmCPQA97Xfbsze1nVKRlqriMfHmwpdLClkb+fti0A2ce402LGY/qyPamUqIEyJJiViNuFMlMGXjMZdc7yC0dUlQZYNK4J8oncOXRmIhuPIUYaRiX+jRW6lrdgdj6NzYTNe6hzVIdC4NZCrWo/GFpx6u99vBQ5uGoh2oHpAe6sBiGsNUfXvOlRvVE9fhQb3Z0D0i4kDujzibfWsmsPIo+QYkeSNXYUrkTWHg7CairKD2t5KLYQAADfC4+x+ycegpJ5u4k/EwfB46f/wuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkRUvTz3gJPzj+vGC/fyN1Pij/nzyBUKDNaz4fFgWdE=;
 b=pF2mq46m6uaDX2uDxlWBBwDy9XeYDC0eAKI6mZP0thmmmtP6xCCpazq869KpfeRGjKvrGOz94aUT2wqsO/nSmPkncB/53bBJ3A+KjIVb0L+vdg/1G+T0Qf0feY7hh6v3A+59gM+MV4iecyAn9ZBSxW3pZzOjTyRWOm1gcrnuqoc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 20:16:38 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 20:16:38 +0000
Subject: Re: [PATCH 4/4] drm/amdkfd: fix ref count leak when
 pm_runtime_get_sync fails
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
 <20200617190212.3519907-4-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <68e00259-d3dc-2ed8-cb66-faee4cb17716@amd.com>
Date: Wed, 17 Jun 2020 16:16:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200617190212.3519907-4-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Wed, 17 Jun 2020 20:16:37 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe0186d3-0b10-467e-dc24-08d812fb56eb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2367170A6B14C7516626E66D929A0@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/1Pl8tEiTMk1RvUHFJzhXnudywZLM7BAVW57KwTQ3DAZBoIZz+LrzLW6/XLQE36oz72uREjfTr8C4y5tqNP5GRutVmo/v5CmjM3YO5fTwq6C8PUT3mLW+Z1gVLADRHyDV6bTJDwdYW16HHHM8qnnppF3baMypKmDPaBAWp94AJdG43ih68IDQWOTDKR/6FhElcIJHUiiw3fqdeGEdzM18WNJgw4erbVYHOkP45XcaHFH5oZJMJjmaIRNi3ziwbk8ilqCNL/Ss/NUonLpwPBXMWvEOMAaFSeRsBfJBlR5VBWyafxEsLjh9+HW7Geb/M/DH19wkXdrPt4QjzlnZDvGLWRQStevs2AGLzfouthqV+JXNdGfaZjoCLbzS0QJ4b3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(83380400001)(36756003)(66476007)(2616005)(86362001)(8936002)(8676002)(31696002)(66556008)(44832011)(66946007)(2906002)(6486002)(5660300002)(6636002)(478600001)(956004)(52116002)(4326008)(31686004)(186003)(26005)(16526019)(316002)(16576012)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qAZuCUyMK0MUvd1g4nknZAiZmGKHZVYYOdoEAOUDqc68kdw0paL5e+OgnvC/F9i2Pcd8/j3Oqy9xe0OD9VUFC64+6bQz8+iIWQxsOtwHQ0q1iUeh7a/UnvIV9m4ZJezCyV20iOfvbwPs80wOCdiVkkuEigGJhbZqu5haRONvuStht/ysrJygKzxqo8US9Nw+b96pA/jaFbRrGDFEPXebl56jil0IiNgeKBzcAjSQartiyDhZqCKMglXSRJJpHcNjhatrO33VN7JCfTMRiR+sdsF62eobIcVuW0c+fAUr2cWnRWoN8/ztichUUJsNv+eO7ScUVuV6esozEAAAVSkYeVIODhMTHYks8IRovsyhrKCzpQgZ9QbSrP17rwEj330wnG/NttnoDWxTmS/ruqKMF1hE/OWYBbxcPZlyoKfmj2+cij9ZcNUHXDWwQyrHC77VTBPWkF3osC6QCXHuBbj1EkeQuiaM/hMteg8cC9PTMsTMQYRYtsj3wJo1aV4WYG5W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0186d3-0b10-467e-dc24-08d812fb56eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 20:16:37.9732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU5Pu8TjBKURQ4pYJAhZC6ohQZStcqQXXlhKHdN50HLqHrf+Uf+UXPNs2MQkNOLZTyjYzsphJboc1UOCafK5AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+Rajneesh]

Am 2020-06-17 um 3:02 p.m. schrieb Alex Deucher:
> The call to pm_runtime_get_sync increments the counter even in case of
> failure, leading to incorrect ref count.
> In case of failure, decrement the ref count before returning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a9a7f5aa2710..0b4f40905f55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1116,8 +1116,10 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>  	 */
>  	if (!pdd->runtime_inuse) {
>  		err = pm_runtime_get_sync(dev->ddev->dev);
> -		if (err < 0)
> +		if (err < 0) {
> +			pm_runtime_put_autosuspend(dev->ddev->dev);
>  			return ERR_PTR(err);
> +		}
>  	}
>  
>  	err = kfd_iommu_bind_process_to_device(pdd);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
