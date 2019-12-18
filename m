Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB295C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 16:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D2E2176D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M0piH+Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D2E2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C3589BF4;
	Wed, 18 Dec 2019 16:57:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3363F89BF4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 16:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAk2GdL4UB02flPmFzoF5+VCR+R3MSWkrTuY7zmn7Zj0w41LM8XeFdPFylM99T+BxEuXPNedA4R+h2RwWzfCc/iQAGwsNLDMR1IMlRCPz4IpiJtQCq08l8bpaD4fyOuE4YP9oPnkkkw8glV9gq65Cl/18pyo1Lwkdx7NdDjGpAR25JjQhJOFgaraXHFJMbZFy0zGvLmquPQvWlWRKAHwxpiOsRFnYtBtgdTw+HS7Z7DbhRKA8ks2q9buuJ9zXPeLQ4CKgYJfCqZT3Q8/4oPQScBLC5L9VmA4Jk40G5kwg+lr4WuWtEMgvnxXTqfSA54hZQqz6+Fpi2oN2ZytohcKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObyV3PU95lB1K2RCpvrCpihhTctqb7twQ25a54dOk2s=;
 b=ffKsb7h5q0aRc9uau8akn4k8iW73LgXPlHJwbPVpo6IHq494GXpA8umV22vDo17uypJI1K4/e3B54YV2lfVjJl9GFYyH/ljHqQK4rtiNIyqBWp4Y5Q++3Vb1ch93frVXS8aZbiwt46exBnVqL1ZoAjYNhUwCvS3M296gWdS9s/ksvy5gjsEFfl0wFSY0ayrAR2WjJ1jpl7kcLtFk87lL1HPObG3ywnFZgexH0gxZU+zPZ5kiK33lAyrDB40nEG0TnT1AwvssvgAMxKVH++UeNlXtQLcQy8tGZe/4GJAWNmlSsdP6FyXBZCyc7e8KDzhxaHea46aRXnOXOLWJnjBYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObyV3PU95lB1K2RCpvrCpihhTctqb7twQ25a54dOk2s=;
 b=M0piH+Kb9mJO2h4MQCwG9BoBlN9ZLKA24tyGDBlIweR5Cl447rhJClxTryYL1j1d7fMyN4SSev6Yap66zf4jK64k42qaONA47iQyoXvH+v90MihnhdpdP1k26jGN45HA1z3srDwUvaRZE7wdZ1Jyd9OJoyfR126s+SU2sV98m+o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3434.namprd12.prod.outlook.com (20.178.198.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 16:57:56 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 16:57:56 +0000
Subject: Re: [PATCH v2 2/2] drm/amdkfd: expose num_cp_queues data field to
 topology node (v2)
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Yong Zhao <Yong.Zhao@amd.com>
References: <1576658722-2651-1-git-send-email-ray.huang@amd.com>
 <1576658722-2651-2-git-send-email-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <541b7746-a5b2-916f-143c-15ee83a3e520@amd.com>
Date: Wed, 18 Dec 2019 11:57:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1576658722-2651-2-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec2b129c-66e3-44ed-5bf7-08d783db6ddf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3434:|DM6PR12MB3434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3434FE008B3964BCEC77C50792530@DM6PR12MB3434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6506007)(53546011)(81156014)(2616005)(8676002)(52116002)(36916002)(26005)(6636002)(31686004)(4326008)(81166006)(36756003)(31696002)(2906002)(5660300002)(110136005)(478600001)(86362001)(6512007)(44832011)(8936002)(186003)(66946007)(4001150100001)(66476007)(316002)(6486002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3434;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTPsaWYE8DZWDZC+RKe4IaUkzIvrQ/m3bmqp9IKYX7Dj0TbgPAg/JupCbiijd0osoukgEf5udtngy+JCUC6K+qEi30y6H2CFjROrlQO/Od6ZuDmQuNHtkYQJZldTWSE9iaM5adFF783/JMZX860SjABenCB0xYhW7UFpfzPMuvUIdjhga63BTtOhxu3IAwJ+xub3dgZzfFF3RXPMJyohWKeJEYrArjC7NaYjPxPoD4kvAFf2VspWShkWpp77HVOSvbv7bAJWUbjLddyTCUvevp7H3Y5Hs9leos7kxRD/i4Saw89jlmJXuP5BxFwkpNnw0HryCXFil0rUibaRQGWgGKRSB5JKZthgOTc6zzzJ8Zfh+HoZ4X+D6q6B9hHB1sSUWI6uhPw4nMGiXqYpdK04DRhNt199YozuflLlCTiVpDtH+/MyBFepoIXcCvCR1KD1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2b129c-66e3-44ed-5bf7-08d783db6ddf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 16:57:56.2414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIWw8T7U+MjkvMJqaiHEJ/OcBVYbkK6tYtuJaVqju691HyWC8Sirl1tvtJ0bb0iJtLlQZuE2zkKrb4FPjhPDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-18 3:45 a.m., Huang Rui wrote:
> Thunk driver would like to know the num_cp_queues data, however this data relied
> on different asic specific. So it's better to get it from kfd driver.
>
> v2: don't update name size.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index cc01ccd..203c823 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -488,6 +488,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   			dev->node_props.num_sdma_xgmi_engines);
>   	sysfs_show_32bit_prop(buffer, "num_sdma_queues_per_engine",
>   			dev->node_props.num_sdma_queues_per_engine);
> +	sysfs_show_32bit_prop(buffer, "num_cp_queues",
> +			dev->node_props.num_cp_queues);
>   
>   	if (dev->gpu) {
>   		log_max_watch_addr =
> @@ -1316,6 +1318,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	dev->node_props.num_gws = (hws_gws_support &&
>   		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
>   		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
> +	dev->node_props.num_cp_queues = get_queues_num(dev->gpu->dqm);
>   
>   	kfd_fill_mem_clk_max_info(dev);
>   	kfd_fill_iolink_non_crat_info(dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index e1c9719..74e9b16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -82,6 +82,7 @@ struct kfd_node_properties {
>   	uint32_t num_sdma_engines;
>   	uint32_t num_sdma_xgmi_engines;
>   	uint32_t num_sdma_queues_per_engine;
> +	uint32_t num_cp_queues;
>   	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
>   };
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
