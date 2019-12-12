Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1CC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A516B206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ds/3mVzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A516B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394ED6E17E;
	Thu, 12 Dec 2019 15:07:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D3E6E184
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 15:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gipfcCYn3K2Fzc3adzTeU7YYx4DQdryN2o9HlibUvRBroNdCBFLB5l6D/ltwfNoWspvq55/ObCO03PRHRsAbfl9M+uM/9rTve/zo1f2PT+stwvN1wkPQt3xqf5Ajrovq4kOoxyT8Jl/jKyUQPEeVsIbNVSMyItq2nNvxnE2Ec2gwLCEk2V0sZDkARoyTkCsCDwa01a4ukF8Z4R2tm30LS/2fQYeKD+DbTiR1+oIw7Os4ivlnv6S5I4w33sFEhEaoZDatMv+e5TycButyhR/9HPrardZQh+SGqnmsTNgjOrq2on2SJXJiHqhZSPlBID3nw8TuqxWkd3hJarll1xp9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVkDSyHPpzDmwhOZQk7p/xZkRgvRWJq2chlFX8c658U=;
 b=lf5Z1YQX0Xwb6dQzlnvljy86ZtUI3wQOpAC8Sc8rtxB//hVoeCwZr0tviggMqYPrHJR8C57ITNFUQznD7UovWlS7kbo2Hxo+eyEjsOLMP6Jkhi7LpU5+CrdH1M3Hwie3AEje9pJQz7rRzE/c+wCFb06B3jm+9XkZiuQ6QA+lOoKOKYb3CPpqqeVEhgDOhYAKZjbN6GfdcXryunyzTj7qYV/prWSxmiDjfZRkR837mWrgWmhiX0+bRYiQoOqk/af+OgOugrdaf4HuRMB3A8+rSIIRNxHHrAA3ZtuGBmvWWTZZm3gUFRi9hB0Qd3hCS8pzWyB2pb2bUUZ1drK334Q3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVkDSyHPpzDmwhOZQk7p/xZkRgvRWJq2chlFX8c658U=;
 b=ds/3mVzL8IUh/MdQTfXkOkuXe1SeaTvnw3aqVhqggCBlM1cl6k5uaJ8d2kMq8tc3XrW0SH/MdJNCHVIrS+1iNS7UipVwUpDFx+h9B32wIOs3JjxQSI00FjJRG6vHrHoTTsrcMDjJJ0Rh19i/Xcx7xm8C7ruyobBruzp8LyfVikY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
Received: from MWHPR12MB1167.namprd12.prod.outlook.com (10.169.201.15) by
 MWHPR12MB1822.namprd12.prod.outlook.com (10.175.56.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 15:07:38 +0000
Received: from MWHPR12MB1167.namprd12.prod.outlook.com
 ([fe80::f099:7d57:dcae:776]) by MWHPR12MB1167.namprd12.prod.outlook.com
 ([fe80::f099:7d57:dcae:776%7]) with mapi id 15.20.2516.020; Thu, 12 Dec 2019
 15:07:38 +0000
Subject: Re: [PATCH] drm/amdkfd: queue kfd interrupt work to different CPU
To: amd-gfx@lists.freedesktop.org
References: <20191212145142.14831-1-Philip.Yang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <63aaa89d-e890-fc92-cd5b-e73d1661bf35@amd.com>
Date: Thu, 12 Dec 2019 10:07:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191212145142.14831-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To MWHPR12MB1167.namprd12.prod.outlook.com
 (2603:10b6:300:8::15)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2c54a7e-dd8c-4db8-22ec-08d77f150676
X-MS-TrafficTypeDiagnostic: MWHPR12MB1822:
X-Microsoft-Antispam-PRVS: <MWHPR12MB182201A49575C5BEE598BB4682550@MWHPR12MB1822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(6916009)(66946007)(8676002)(81166006)(36756003)(31696002)(478600001)(66556008)(86362001)(66476007)(81156014)(316002)(186003)(2906002)(5660300002)(31686004)(6486002)(8936002)(6666004)(2616005)(53546011)(6506007)(4001150100001)(52116002)(6512007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1822;
 H:MWHPR12MB1167.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABNO/K/blqL98cCU32S7GsLP+EHQKXxqQVIaVpST6zxVPJfMHiktCrQ6IC/IjskkDsL4cJ6/MQr3Mjrqofd84wRy0uNA6TySFJh9yHWQ+iNnZIRBdjEaZ2QJ+YLCb9dF6IkDP8yJsu0ksBQywCv+GraiiR+h3EppR/p1iOZhyP7Ds4L1IZfu74ClJ/iGc9jY3XzqIffTS6GwUFBl2F5HgAccr1X455LykcduS9ZUP4GthitU93vzU80XGXHL3Yid97vIkZcSqDS93UBchzEQRi1UYk2nZ1xcc0D5yuT1vwWgtIdVX20msLjYYPa0jGomCxMBiUnDZBosO61kYgIdT6jpp8CTm+QSV6OxDKznnkCeIFDMEa2OR577txHjv6H4fwipCVHwEbjACjoXkjWyExzW3Q9sI/foSzNZ2YHyjgiV8pcBd5R4RGru+s/0fwgA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c54a7e-dd8c-4db8-22ec-08d77f150676
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:07:37.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbyLjqVK2V+xzNM/TCPkuek8HpY9LdcTwjxQXtStS5ufeVJVu1dsxzkPFhHPbKrmJz8vttxjHb2NY2FZF/5PYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1822
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

It fixes cpu stuck issue in some extreme test cases.

Reviewed-by: Eric Huang <JinhuiEric.Huang@amd.com>

On 2019-12-12 9:51 a.m., Philip Yang wrote:
> Because queue_work schedule the work on the same CPU the interrupt
> handler is running, if there are many interrupts pending, it takes
> longer time for work queue to start, or even worse system will hang.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 209bfc849352..ee2a9bb1cb07 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -844,7 +844,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   				   patched_ihre, &is_patched)
>   	    && enqueue_ih_ring_entry(kfd,
>   				     is_patched ? patched_ihre : ih_ring_entry))
> -		queue_work(kfd->ih_wq, &kfd->interrupt_work);
> +		queue_work_on((smp_processor_id() + 1) % num_online_cpus(),
> +			       kfd->ih_wq, &kfd->interrupt_work);
>   
>   	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
