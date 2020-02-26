Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EACC4BA24
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1126B21D7E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GH6yGRkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1126B21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C460B89948;
	Wed, 26 Feb 2020 21:01:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0589A9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 21:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbZrxaoG7GS5b3aDBVyaYAYZ4fQ15mysm95tSRHdDknSRN+DkHaJODO3Xol366WoK76QQDKfqhEGgLHnDdkszZI6VsuxzRysBDPDgcSZYcNyHxnAjO6AmfCLe8KfvrZhDN2uM7/GB+thV3Lv2TNqRadOAD64E0CBOEB1rlR5WOxFgK4DzPkQ+rnz0xqgfAD4eSYypTAE7/mZ47K39Sr56WeKiH0oAlYmo47XyC2cwVckW9Qwvqpq84XYVfFa4wSjyeGOXV0bFo53DuI1gnvurYlRFUBfQrB/gQ1oxM+nDK5ht4QrBTJ1zu0Zkkw/XA8bFj/sNzr3wwTVf8MTwRL28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKrzjk75x8wXHDm0EcL6PSvlUbQiDv5M39m5g7j/ybQ=;
 b=WmWrQQD15L6Qew5jAw5FSu91gAWJVcmkpxEK8ogoTSjnbgPN7B4UY/9Fje7hi+gYunu5bh2qAwhVxF6R4DA2B/QFgFp3BRbPH6b3PZw5nM6j4tH03in2RKrRoFBP28VQFBQ2HYN76bRN0l+3XDA/xlGQjB1eehNbmC5wH3S011Jlx3UdymEtW8MOROPoNTzr8HfG4fzRSB+vN31HrSNekWpGN0evZj+ggBO1lz9vpCOyK6ceSagVNEvpUn7uu20vJV510ykW0wHB23i4iQssqRiyQgayuR6Tb0ambnJsPVj0vjKdicBW3WhZRpzGDGHWv+/UOYB24VpVhsntpiAeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKrzjk75x8wXHDm0EcL6PSvlUbQiDv5M39m5g7j/ybQ=;
 b=GH6yGRkULi1/2a5zIKlR0CCZbie9yLKqJ5ft9vxiFcw1dplDDeADMlur4hDQcbQpWtqNNUzRcbcheLpLpdD3IKRejeBYOCim+UZbhI72vfZPLKDc64jIBYNYdwDjQGSYkmXGvd+dgnqZG+77fUyW3+fk092EzlyMdEdpq4at/xs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 21:01:01 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 21:01:00 +0000
Subject: Re: [PATCH] drm/amdkfd: change SDMA MQD memory type
To: Eric Huang <JinhuiEric.Huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582745831-6902-1-git-send-email-JinhuiEric.Huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <53f26edc-de4d-c66b-e585-635424e3d290@amd.com>
Date: Wed, 26 Feb 2020 15:00:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <1582745831-6902-1-git-send-email-JinhuiEric.Huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: DM5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:3:23::29) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.189.239] (165.204.77.1) by
 DM5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:3:23::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.13 via Frontend Transport; Wed, 26 Feb 2020 21:01:00 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02e20ea8-a3c1-4cbb-2bde-08d7bafefbde
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:|DM5PR1201MB0234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02342493844B00E1F7CC9C8192EA0@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(2616005)(956004)(36756003)(81166006)(44832011)(8676002)(8936002)(81156014)(6486002)(86362001)(66476007)(66946007)(66556008)(316002)(16576012)(186003)(53546011)(52116002)(31686004)(26005)(16526019)(31696002)(478600001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0234;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMHQPq7vcsk0GMod9bfcGD/g5oitNlq6SPldE6HwqoG1wMQIa/dh7ld58sjdIiglN11hZY5EoBR2Gir75swGZ+qNJsO0x2kTV0WEfyCqHmVyNEk90Me5DxB8GdteQxZZeRnGB/74K/8xUmlloqJC0H7bydkB31PeL8xCZ5IO0+Z1KQrIC6SExVjcbgeKHg4eUr9OdT7fLuHPr9WfaIWdzpGSiRUDe7KWMoDFFU5R2fqFTAWK525GAucF5g+cinvNA3ZbXucTzp8JOxYJk4c5PKJe/vePLoMGAf5b1xqcI5GoePkjxb3GMNpkwKqDVds8+tL4pN2u1xJWSJyjKiKJGSyzOrRHPExsB4YUoWRG1yn8L5GnGA1YVDoiyJZDMbBdvDgujXWqLuVTGEIp5PsuHGdGITcg99rNEXEvjE9z/3SD+1mPajoZ55BY/XZ9bqXV
X-MS-Exchange-AntiSpam-MessageData: Y8F1mmqfRPneesEEN/uumcOY+mdJ+SKRf3swR47v1Vio02VXyD/VAifgUT7y32vqOT5ZKwUtXFjL47nHj+vCieNVBXZaq7hstc8JG6lw36kSqdXjexD3ovm5NnkAGZppgltsWtdqrEmONXoKf8eVrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e20ea8-a3c1-4cbb-2bde-08d7bafefbde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 21:01:00.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA0j7By76NrSVUPmhWmyVX1fZBSL3ThIWdSPXVGvl/ANiR5xMT8f10x1DzpqSNbZ8TOoMwH+IOdzC9Uja7k7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
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

On 2020-02-26 14:37, Eric Huang wrote:
> SDMA MQD memory type is NC that causes MQD data overwritten
> accidentally by an old stable cache line. Changing it to UC
> default for GART will fix the issue.

Maybe add a statement here, that the mqd_gfx9 parameter is meant for 
control stacks that are allocated together with user mode queue MQDs. 
Setting mqd_gfx9 to true maps the control stack pages as NC. Here it was 
accidentally applied to SDMA MQDs, which are allocated together with the 
HIQ MQD. Setting the mqd_gfx9 to false avoids that.


>
> Change-Id: If609f47c78cb97e2c8dc930df2ab5c10c29dfe56
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 692abfd..77ea0f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1734,7 +1734,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
>   
>   	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->kgd, size,
>   		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
> -		(void *)&(mem_obj->cpu_ptr), true);
> +		(void *)&(mem_obj->cpu_ptr), false);
>   
>   	return retval;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
