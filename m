Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE2BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533DF20702
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j74VgVHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533DF20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3B889C6C;
	Mon, 29 Jun 2020 22:29:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A65889C6C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 22:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0DzS0Ht2SKl9kthEWkWnjyZxwI4vVsiHsWu+783lCU7lxQRfM39crzY2OngdCB6UNXFZe2trKAfwtmSfMfoQAs7JzHLB5piTT1UCekN0uzN9sJ7Vykgr8cX54RcAFzo5NIeIMEpvp13G/n6TQXPQsStC4ExgtKO1AOY2pXDt8+uF1kg33UfBQAQdghfocKmo0b1qAyOO7pT1Ugenfaz2i1tGNux1e6cGC2/K3wRvB46DxPYSnfhZ7KQgSDfrait7Kf4mXa/6/NmBz7ImulUDAXC/oqUGd91C9b+rGWu6j9Zt1gLcXWzPaNw6sYbshYO8PfTfHEPXWUU7z3zYf7zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmml0n1oaL2JuJqfQmHe3DQAdc89517BsuBwpESK+sc=;
 b=SwGhQs8T40biQadHeFnfPN3p0MbmxEgH8QXGev7KW0dpH57kT+uLXhQN9aCXEo7YHdCWSf3Z7UoJEojFBF0+P0KA7v+8q3EyZnzg4frfIk1tP8GbDAC892cZHSHxRwJByHXQ0/Iq1Z86kE+lat5k7lZztGLk+9THrfaqDijhRVbsJspmB8CvDtzd8JkoeSzeBvS79W/gjgegjlW0SQ6Wtd/Coo/wO79ZtGvOplCSQQzE7scSy6AThRd0m9LlaxEE40cgf5eXE+qiaO+Q82GkdeMGDLnyz2A05XNM+77nVNcTb0K2O7PBQ00t143VZZLg6hk7oGC4YTcwvUe+U+/cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmml0n1oaL2JuJqfQmHe3DQAdc89517BsuBwpESK+sc=;
 b=j74VgVHdH6+N37rpeBR7LgbFG++tGi5jNo0GD6JQWR5PdI1hnochNiFCB9eJhq3gBycdxdZ4WrqkQmMVsyGI+cN5r5QVCNIqzOP0ayIlVJGzHzTnF8x2hsvD+9+bvcJUOswnodI+FoXPqtN9lkYNwLrnsg9e80lMolRyv5y30fU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 22:29:47 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 22:29:47 +0000
Subject: Re: [PATCH] drm/amdkfd: Update hardware scheduling time quanta
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200629220044.179230-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d945ffa4-3de2-102d-adaf-0cdc02489689@amd.com>
Date: Mon, 29 Jun 2020 18:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200629220044.179230-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 22:29:46 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c523c583-0ae5-4212-a1e1-08d81c7bedb4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27831815C23497E489B5548B926E0@SN6PR12MB2783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX0PaZLBzKbXuIvJ7Jv/qS9F6fdnpXsvHBy3i9UyMXbt3oA6IUR9m2HxKirhTtgZA94FTvY1U4hZMI5xq72ypWPrg6779UK5IisxsyQnycHPi7Xd98xEO2OdqkTyFrqSQEJc5/veujWxuWyRxJirjkSNanHrnFiGgiLBBLqsk5FPSoumrZKNcbGnm01/ONMP4RaRBOR7cMEaLNKFd/swZ91MK9hDy1PF4c8D06UqeSX8NP0fOrgPnWWljtHL5ePdst370Nl1SchG16mwIsolUgpXCt02WQUA8dT+LGM5heBe7rm4Mh3ufYMO+uLhsVWMIqXSKsGtAc8z2wtExVPdCCcYlZsWVLYpKaKyazltEn/qpd9lE86A3ZMCvI+Etkmn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(956004)(5660300002)(31696002)(2616005)(31686004)(44832011)(478600001)(36756003)(316002)(8936002)(66946007)(52116002)(83380400001)(66476007)(2906002)(15650500001)(6486002)(8676002)(66556008)(16576012)(16526019)(86362001)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ml3hYMjKDHcVAho4mrt9mdMp7P1/3atYhMQzc4T9qCgZuhVLeeb1Sy+hzWcNdrIiLl+xM+otgwBaYMJ9vxj+QkWink9+zggrRBH0n82pY0XkIzKUZRMX7Bnq9KniFIbYm24cuyXWYlnYuAUQ3ampHzgJeMYRlfkOFleGeRZjLuqPRI5++0QBl9HWkmRkbSXCVZaDY+cSVv0mMB/azbLoHlDiQGbTc2nYD+2Qsk+jKgMWrp7lIM/LfMC3wxAKOhD2jYeEHbo/VlnkoLr9jr9MKOABbSjCILc5JgqqR5e89Z23InSCQuzdgAlBQ2lrxrEyCdipeHTNxXzl9T3WB3xtwz/MVPxKzoz4Ln2syoaNa4DIvxeJSNj7CD4Ix5pOjLmfCABDiAse/TnPs4MYy21zfBUO8gnSVthHIB+M8tVqRXSuEuz16kQV5o0HMVoSVG6G1xwgCtCTVL56iRZhXwj5CJRISneqkmxhuGExQ8Hgt6JGqlQT+LTvnlt4W6ZB+7QS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c523c583-0ae5-4212-a1e1-08d81c7bedb4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 22:29:46.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDmJPuv+8ZU1RbNdxqAJAPSTtdWA8R28Hm/wLF2fEs35jGheqCE2GeVrDC3h5Ba9HW53/nYNNcUjElLuKh75eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-06-29 um 6:00 p.m. schrieb Joseph Greathouse:
> Update PROCESS_QUANTUM, the time the hardware scheduler allows
> processes to run before switching to other processes when it becomes
> over-subscribed. Increase this to 10ms, to allow processes to better
> amortize their task switch times.
>
> Update HQD Quantum, the amount of time that an active queue stays
> attached to the CP before we forcibly switch it for another active
> queue for fairness.
>
> Setting these so that HQD < PROCESS makes it easier to ensure that
> we get fairness when we have multiple active queues on the device.
> Otherwise we may start process-swapping before we get to all the
> queues in a CP.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Change-Id: I5f46d268a82eb08e75bfaf0aed5333c3341b64bd

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index d1d68a51bfb8..18e08d82d978 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -113,7 +113,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  
>  	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
>  			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
> -			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
> +			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>  
>  	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>  		m->cp_hqd_aql_control =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 48cda3073b70..3b6f5963180d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -160,7 +160,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  
>  	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
>  			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
> -			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
> +			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>  
>  	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>  		m->cp_hqd_aql_control =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index a5e8ff1e5945..31799e5f3b3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -117,7 +117,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  
>  	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
>  			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
> -			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
> +			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>  
>  	set_priority(m, q);
>  	m->cp_hqd_eop_rptr = 1 << CP_HQD_EOP_RPTR__INIT_FETCHER__SHIFT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index bdca9dc5f118..dfaf771a42e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -39,7 +39,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>  	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>  					sizeof(struct pm4_mes_map_process));
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
> -	packet->bitfields2.process_quantum = 1;
> +	packet->bitfields2.process_quantum = 10;
>  	packet->bitfields2.pasid = qpd->pqm->process->pasid;
>  	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>  	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index bed4d0ccb6b1..a852e0d7d804 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -50,7 +50,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>  	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>  					sizeof(struct pm4_mes_map_process));
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
> -	packet->bitfields2.process_quantum = 1;
> +	packet->bitfields2.process_quantum = 10;
>  	packet->bitfields2.pasid = qpd->pqm->process->pasid;
>  	packet->bitfields3.page_table_base = qpd->page_table_base;
>  	packet->bitfields10.gds_size = qpd->gds_size;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
