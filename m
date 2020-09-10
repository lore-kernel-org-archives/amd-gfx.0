Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D49C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 22:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96AB208FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NpZG9hie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96AB208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD496E252;
	Thu, 10 Sep 2020 22:32:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A9B6E252
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 22:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIxynYa9DWHKeMEgyijT5BW64oxHParqDOYloBmCDraDXsjDXGnWKQvVn4t8FnxMOoV1VHD6R7tQS0/PjgFe/EymGaooHx4xyHpH86CFjwwADzsWrlF+7+kinEGj8Jy7a+q1fMUi23WOf6cl1QbkGVkSLTU5G1hX7O2YSfjj1sjSzJ87I0e5Zqxjn63eLrG7g/+wtRUTqHAsH3PC8Vz3BS/ZDEcsYlzD86OlyZyGfZ+jRWYfr3x3uA3BUADi2XSvMRpvM6nANGn+Skok06xzyOZneDqzr+m3JZuPUyF1oY6kUqS7BBTlWPRGSSKjMz07x3e88Lml9u8Fa5TEeVMcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzVnnMLPV84TPpDJvxkxah7YLmdpQ4F0dXMDQdX7iQ=;
 b=B6PbJXEX+Zv2uHlidde9mUtJCPG4X388WxTyf/pMrF2OaW1tE+4AhsOR/eQuYdmy2AZtRywyMCmC6iJhLJl0CYulk69rHMd2EcxOrsB6WlPmjVryrjuOps7wJof1FwgOR/DGdfKAUe711peT2py3O27SsjuoI2+ZvEJiadjBPsvbOi8XSGMaqaljVBgnFHsl3+oV+bfFkJ2j/qHuG57MXlrN3q534CWzZZ8eiUJV+ZGFG2kk3zaiPZItVs33BExb5vK8yS05e7KIL6FDnvssVuqjVvPAo85QJKo0nfjMzamW4jcnx1oq4RT5VA+BBfsnZNTyV2YM98IzB/Z8xCd6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzVnnMLPV84TPpDJvxkxah7YLmdpQ4F0dXMDQdX7iQ=;
 b=NpZG9hie9AGL9qzb8owOSwE7xXp65edbPfLtj9TXLFRYNHWWFRYw4Lez0I7ZbZKZkdfUuJthf2aD+3g8M0QiD97gU2N5BAXM8dFy14Lpdx2NTvzBSObQdscGrLfk+Fwrb5PWeohrI8cPm1hBbws3Ww+GqQEm8M+jXZ11ST4HpJQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 22:32:00 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 22:32:00 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Add some eveiction debugging code
To: Philip Cox <Philip.Cox@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200910185429.14011-1-Philip.Cox@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <eb3d115d-02ec-9f45-c54c-c4ef189c0670@amd.com>
Date: Thu, 10 Sep 2020 18:31:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200910185429.14011-1-Philip.Cox@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::27) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 22:31:59 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2640dba6-af62-44d0-34c9-08d855d95542
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2413CC963E56187459220FB992270@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KDR+H1pHwtbXBRt/evAIT5yWl4qUlIeaulbzI88KHafJ0AggNunA+agU6PFA9AG+MDri3ge0nmQ2QBWnRjAZkhekIvm8Cx0VncivPD7jKP0ONENLiiguyVGXqLokgLymabhAFLpkDVpXOuW+csFjypT8G3vywKYcdx3KionE2olu0mjIqED2enaLkxmX/daofyfvwWpYXW3ksv+Lisd2qDWy6sUrJKJglGArjiZfm9X5PhaxbGg7cMCOqqzsO9kHKXcTqsQ6m2f+n/cK3kcxJ1m5/I+tfbIOnlGnhyyp2FLzvxa3Pr/g15RJYE+7F5C/auqH+hrHMSLjV9ILMw6WMEE2c07kh+5BZbVaFFIt9S2vUsQo6b+2046GNBVaTtC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(8936002)(44832011)(31686004)(5660300002)(186003)(66946007)(16526019)(36756003)(2616005)(86362001)(83380400001)(478600001)(16576012)(2906002)(6486002)(52116002)(8676002)(26005)(31696002)(4326008)(956004)(66476007)(316002)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gEnLrt8/0gYgAHGXDewD4+B4TuJ7sappU3fDWLRI0sHKUu3LZfh6rFDGsKICHuX1NwkU0VyzxvgkDTDqA+gJe7tJpRxAiL4WPpupu2vobTDq4z5MXX27szIbTWUGJw3CHrHLGQFSDuYEwjJkYJjm0M+NC6UQhV0mwWawUCs3FWqwdEMg23VQ45gPo3ShDKF5a+HknNR5fr0ZIKUb4Ac7XtAFCsICfioTDiH6rlNM32N5v4HST+VZSBafJo5yjQ544dVTq12qdzAEw1JSD1riuAxbBtNUDPndgshIudaHAJOSMdn+lRfDL9adr/YzIbVae1mBL1Dfl2UIPhuQ2eDBQL3Sp/81O+AsumyIaZoGCLnGTeDNTa1rON6reUe5I0GSBPoo/kAMVbPc9FfJvWYTnl38LuREZpFyDLLsUYUC+Lx2zqTCC82VWs5zLSBPEjc6M6ARQ1zbYpEskd8dH8be2imVtmLrxYe5lgumj7jZ45AtOw5co9nZLjuNHuVVru8YM9+AdRyni4UFD3/C7nKYb6ozBYsvYfc52EYK0LQgzHzsYzDvIJjV6a0oUz14bzglWSasf6dHph/zOI3YDOWovRgiMx+Gx591G3umquhTC9k2RXufqgYr+anDaJ1ujKmnjB7rYXcfw16onAQZlfo4aQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2640dba6-af62-44d0-34c9-08d855d95542
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 22:32:00.2340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlGLyBvt4b+F4MkFDHTWzMLTDPFQ1cejPHVTVaINx46xbLZfQFJHhrVEOoIFja/u6rCEkh/HFRjiej0ZcNQI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
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
Cc: Tony.Tye@amd.com, Laurent.Morichetti@amd.com, Jonathan.Kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-09-10 um 2:54 p.m. schrieb Philip Cox:
> Extending the module parameter debug_evictions to also print a stack
> trace when the eviction code path is called.
>
> Signed-off-by: Philip Cox <Philip.Cox@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 20ef048d6a03..cafbc3aa980a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1966,6 +1966,7 @@ int kfd_process_vm_fault(struct device_queue_manager *dqm,
>  
>  	if (!p)
>  		return -EINVAL;
> +	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>  	pdd = kfd_get_process_device_data(dqm->dev, p);
>  	if (pdd)
>  		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a0e12a79ab7d..1e15aa7d8ae8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1488,6 +1488,7 @@ void kfd_suspend_all_processes(void)
>  	unsigned int temp;
>  	int idx = srcu_read_lock(&kfd_processes_srcu);
>  
> +	WARN(debug_evictions, "Evicting all processes");
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>  		cancel_delayed_work_sync(&p->eviction_work);
>  		cancel_delayed_work_sync(&p->restore_work);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
