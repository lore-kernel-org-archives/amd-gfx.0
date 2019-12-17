Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9757C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 18:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BD6206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B7wtPijU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BD6206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F4F6E0D2;
	Tue, 17 Dec 2019 18:57:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B0A6E0D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 18:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5CDivsxZ3Y7fqce3Yy4naMSQ8gETnjtP8Bsrf8vPeuuTrAdickw3WJ7HcriA9Yxc8PNp7ZzIsqagMwht9MGk68Jrl6i5dDLt6gki+nTvI1xpaETPFWKCHZ+5aGYDuW1fkdAAhfyEJv4ph7DroqaycuScozf3geAWERUUhJDJjzDQ1J0xn64y7aiyBL6ZTAYeUqjqA9q6a1huGdqZihyyhtNIOk0XLzNq27AQmaszOU5QGaH3gzt5p6hCoYdGnruwR70oLsbKxNdrNGUlcUoZZFHOk0W2i+Zrnx4GkQ+xIDUx8BKpXRYKZz2jKHgPctTrFrBvFNsXSEscMHJEmXmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GAjmWlfyLzTY1T2X3AdowaCRkXTMQX47hd9xpGrR1Y=;
 b=CQ2l2cJYKBM+TdcKD7qTG6sjtoLcmb7UUEfeVG6H6xmaOlTL9KUhQ1iNZdCd+sIDcud74pSXvSEFhoE144CPJFWH+74Y7B3GYKLdM9tSu1S9USvHTXfOz8oP9gLEzcyW4pnX+GltPm8zfvagP+Q9s3o8zLGNyzlrzNjnzM2pyG4gpvQAybta9Z82KuxX19OE2zVsJEvFP7OqCDEShIh9Kv4qXFRlhm0h4P71g9+AbpXZAMawLP8lu1f/K8oQ5Nbbl+wDD3UUQHwvOvwDVe0KzPKsJAo6/6bvPrFkR1TDApWz5mYpOakVFHYJrpuaGysgBirOSywvAOmVb3rZK/OfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GAjmWlfyLzTY1T2X3AdowaCRkXTMQX47hd9xpGrR1Y=;
 b=B7wtPijUfTOH0WEB/3o/5cp6Syf5eW80g7FK5owley+vdSNOI03mpEYLM7JISxVRGKGGsMikFKHeb+9CVdUFB/Rg64kXAgTSDiEvTc47kvGnxnZ9ZZEDAoHC/3d5fNkbK9FrDztPkJ3lPbL/eAqUZZaqyXxeVIfmq4oYskz/ziA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from DM5PR12MB2424.namprd12.prod.outlook.com (52.132.142.162) by
 DM5PR12MB1914.namprd12.prod.outlook.com (10.175.86.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 17 Dec 2019 18:57:36 +0000
Received: from DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::982d:8634:66c6:a09c]) by DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::982d:8634:66c6:a09c%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:57:36 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/smu: add metrics table lock for navi
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191217145505.1319348-1-alexander.deucher@amd.com>
 <20191217145505.1319348-3-alexander.deucher@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <7ba97448-11fc-c506-1750-18b6440ff971@amd.com>
Date: Tue, 17 Dec 2019 19:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191217145505.1319348-3-alexander.deucher@amd.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::15) To DM5PR12MB2424.namprd12.prod.outlook.com
 (2603:10b6:4:b7::34)
MIME-Version: 1.0
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b8f1921-8f3b-4db6-c9c1-08d78322fb38
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:|DM5PR12MB1914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB191459E211B0E28710D241A18D500@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(478600001)(5660300002)(31696002)(6486002)(66946007)(55236004)(81166006)(81156014)(4326008)(186003)(6666004)(52116002)(36756003)(6512007)(31686004)(86362001)(8676002)(66476007)(8936002)(66556008)(2616005)(316002)(966005)(53546011)(2906002)(6506007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1914;
 H:DM5PR12MB2424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4tW4sFlEaCJ67r5g2zjn1/43ev/CY3Ozd90fXSXuloJrzVGT3aS9XjYc4hOCnEujnVWQNZ+KhKOaUTRmGFVnlkCvwTn5DE+8UQHJqhdJsSWMYahpjf/kioEZNqsozfKFripGr/W00eXVZVLgNXEJ9ZCBwc/04w2Zcze/qX35dfSzfFrYfPqK+aNAt7dTA01Pe4czH+m8EYAPKdEHK/RU6yIElaZ76j62oMD2h/cswWXgwxw5AGCUVrDRafQke+ZuFdRYJx3+hw60HJTHCjn02P7mVNMHqm0Zdf+DGnG7T7ejY3oLD7LlEQwzP3cJncjowXUyw6/vlW/GMrR6bnaFS0XkFxAqbvD9MUTlztCcrmQC4i7EdHuhhWvuDJenyxEHDPLXAW1v8El1sZuIi1ozRrCjEGpi1A0VkkcREeCbfCtRDQkH0YQju2SaQevwTIwTElNj6l7+OmYW7kq/Deikez+QM7OSDjHjKeksWkWCfE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8f1921-8f3b-4db6-c9c1-08d78322fb38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 18:57:36.4613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbXyUyxhlv+abpgHrawdJBFRZBgxx/zbRKECUMyHnjiYzj4l1Y35XTvW2VdtFz/l2aGLduwAW/wvFlLdsyIhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
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

Hi Alex,

Isn't this patch missing something like this:

    pr_info("Failed to export SMU metrics table!\n");
+   mutex_unlock(&smu->metrics_lock);
    return ret;

to release the lock in case of error?

Regards,
Pierre-Eric 


On 17/12/2019 15:55, Alex Deucher wrote:
> To protect access to the metrics table.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 15403b7979d6..102fddda925b 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -564,6 +564,7 @@ static int navi10_get_metrics_table(struct smu_context *smu,
>  	struct smu_table_context *smu_table= &smu->smu_table;
>  	int ret = 0;
>  
> +	mutex_lock(&smu->metrics_lock);
>  	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
>  		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
>  				(void *)smu_table->metrics_table, false);
> @@ -575,6 +576,7 @@ static int navi10_get_metrics_table(struct smu_context *smu,
>  	}
>  
>  	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
> +	mutex_unlock(&smu->metrics_lock);
>  
>  	return ret;
>  }
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
