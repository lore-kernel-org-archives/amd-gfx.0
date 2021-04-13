Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F16C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 06:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6F4611F2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 06:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6F4611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529E789A88;
	Tue, 13 Apr 2021 06:43:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7F489A88
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 06:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nls5VfyR0l6HfLeYQyqzidYCAkBGA4GVlq9gL3mVYFjyS7RVNRIm+AjPC8HWN9TjGt4hTUQp06FZbkV5yhdeSptslRxXXMm1VqN/bZ6nJlfn/CTw9GtMUu7wSx8yCKXgqc0PQObxXIpbUD8rkZbVugubRwXVOir/KCPMd0pWPfmYsJAyXmdLnovfqZW1U17QkfeDMVn22RTTtttRr90B6CITfIpfpFNIwaapDcvOF6qKH94dEAy33fBZY00YFVv2mxlrVRf4jZQqgVYu+Z14QMKRohTiAJrJly4LC0/zD6QFtDUFwRANcS9BEvB1zeUw4joLzXZDBzYFKGG3UX2C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N473qZQ0VbSZvVa6RQqlfGaBE88gDlwj+d1F7FZOsQY=;
 b=FQ8i/xxJq+qbK9rEwemtMd+bWWqOvr/BWZBv/mTyw4YZz7JzXxu2WbIgUQG9ZtUa+Pd+3q3wQvukwwBU+QJ7GMp65ohyuwxXBrxwzYPEHYR1xvY69XSuisGTIoEpBc51Z9z1K41NcDGtBxhfGNQL+LAvRDclJUGqTL8ivpF3Ailm3DAMw2WSlBLr+JTRYu6cZqmG5h2iSkYs0pCZAlDJmqAsylpttWtOPrGWosWhU4fFzCQsc4K+6vsU88HVXMmeNT9zB0/92+Idc2HNNEzMYXwnuvj1r+AVwRLNjwKudqsin05nU2zwsKqY7YaQeGn4sbXjV6Om7pByO49FlOyCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N473qZQ0VbSZvVa6RQqlfGaBE88gDlwj+d1F7FZOsQY=;
 b=UcKh5s0ldUtOkLKczlGwEQPRPYePu2eNEA4vBmAQYx+vVgwTefAsDH4UytcJuOIxGqr7whCYA2jmanxET0RgfurbLbtplcgnCMesPbHOaQlz75eYLPZljAu6jZVk6nv9zWDf5hbgpuW9aoe3wL5vh7ogRcop/CMoJPzSM7gaa+k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0030.namprd12.prod.outlook.com (2603:10b6:301:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 06:43:04 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 06:43:04 +0000
Date: Tue, 13 Apr 2021 14:41:57 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma
Message-ID: <20210413064157.GA80097@hr-amd>
References: <20210413062300.12558-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210413062300.12558-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK0PR01CA0057.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 13 Apr 2021 06:43:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 915668ad-6d7f-47ab-a3ef-08d8fe476399
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0030E77B707964E3FD700170EC4F9@MWHPR1201MB0030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92jSSrfx20GUqZtz5i2qSodFYQrAhwl3+OVGPdcid3yDVY1eOl6DOL1qraMZvkujVJRvgPQG1oJ0e67VXsbYXuWNxTLMsdXbP7i+VdcHXwF6zGH9HgqlHraTv02XpeYkBOhbV+DgWvMRVGnAWkbCHGHddolnzmtQhHozVK/VwLPjQ6Pdr1JFHWk/oVDTCXYpLJjifrPxooab1E7cBmmjdISnw1bp4QCpCKqLjJIi8L/hdNrn3po/F4WdbvFIijgUMPnisJ1MwDybHKG3QNdLXvL5HwY7OT7BOXE9mn2FHUWa1KsLhVGOIcW9n7VE/I0vf7QDuEaCIa69Xnk2SMuySCnY5gvTdc1UCeiD88flfBpNj28CNxA/qJwvd89FRXl/Ss0RwJZMdpCUpjmm1nM4bRiDXyxr7gOa8zFLIl6M6boKoyMD6bzwZPMhPEz4vc1aHz/ohUmLjlzTssaoKJ63D3E4tMIlq6j6/IWIygBZo0GBDYegulmLn0MVSbx4kw3UnbOukelEx98mQ6YvAoHa4JMa4tqmhnWFsCYH4S/gDTfZxEreDD8fLIGvnvmbHyTZINhV/mwlIZdK2Moxd83nEDKzW8KsP3T5EnA25BN0lwX15Gm07tRpdRyPLO5Dw0bhxxQ73GreH4K2aHjiNTaJyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(1076003)(52116002)(8676002)(956004)(6496006)(38350700002)(6636002)(38100700002)(2906002)(8936002)(54906003)(316002)(33656002)(4326008)(66946007)(5660300002)(83380400001)(186003)(6862004)(86362001)(33716001)(26005)(66476007)(9686003)(6666004)(55016002)(66556008)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w0d3++UH0pBtl4EajETM/WXMPg/CTGMGVlB7vUEIusowoVC9WStRv0TPsS02?=
 =?us-ascii?Q?YeMXaUo0zwg0nB5E/N+fBzH5cjDoZnYOdQNdkoIw62bAHSPoSBmt9lGJC2hN?=
 =?us-ascii?Q?rVzjw/9SP4DL++8Ml3eh7HbAX0Zo5sJhRqKsYS6QLx5W3cNAJ11tXr2XIMEZ?=
 =?us-ascii?Q?i05TFhV57+uGMKnMmsN325pLLRx6ZxA9v6LDLCqebkK/hAc8ZPvwILQ7+jg0?=
 =?us-ascii?Q?1EGhi0JOH5afVKyc8WYk3u8geqbRbucJKtsBLeaLbPP1qUUcI4kg8g6cXlhR?=
 =?us-ascii?Q?xCBM9mtGOWKfPpD6xthdoktgWx/TiiXXJEBAgcZVhNEErXQZx0mhpuF9bFDU?=
 =?us-ascii?Q?hYRJuoGAr2H0XmD/hz9hTzQy2mlgX3PSQo437WNy7QQQ5RD+5OpiOkWJ/M5U?=
 =?us-ascii?Q?wlcOOT0fW92jvC1jt0//DphvzjW4/+SMDQgaj1/wxtZPQVoIA08S9LCJHTXT?=
 =?us-ascii?Q?MtqnLbyG9RY1LxsVbDMC7BDt7UgdTGP7lXR3XV/gVR5TH4aIXJUsrEWY7ZTZ?=
 =?us-ascii?Q?ezz4Nct6bO73wELsIPQQ9G1GkBAXMxoM/F2c2LCPUVWnL9GkP4EtCW3/Q/WS?=
 =?us-ascii?Q?GQz1ahjFmZIIPIc3Vlqzpz8VFJWtfRWk0UoB1CqSI+vz+JCLqzgHYkB+1bQ0?=
 =?us-ascii?Q?awt3RjDVbJMwJ/13ukIrP4MUK1Q2X8C6KFYAZSQCRCPkRSpkxh+QQB6/TKPQ?=
 =?us-ascii?Q?88ZbYrKYjIJR72AKN0qP+YNKiYfDjYJIDwWijT0ug2Rb2a7+mzsndOAX1MNY?=
 =?us-ascii?Q?KjgxfeaFNxpUUZjSt+fCJjDKCpFHlzsR4d882G5whjlwtyCttDYh67HYGvax?=
 =?us-ascii?Q?vlp1fZ1hmj/xRQqk/Cx4kW6ZUIMc618A/HxQcigsfZfpu0W2HZ8sqldz81ra?=
 =?us-ascii?Q?HKALZg3BzjdHBgliaJKGzghHJutGEhNhCba2qBDQK4+jPMZIjcxdyX0xo4+O?=
 =?us-ascii?Q?LaUH+vRQstNQGqytn567bwSfBTfhsAXwKDLhnkh0uijiC2YZW6kuzfvdS2da?=
 =?us-ascii?Q?tmAKjmnd4A/l03wAeKyc1oF7eYBn8EhFyReS+7vt4gwLPC1yjZ5IbtW1160U?=
 =?us-ascii?Q?WhyebwISa/6CIyvNWSHv4WV7z4xi5c2jRekEHrQS4yrwAcxcgEFtWXDXmyj+?=
 =?us-ascii?Q?tv21IKa8r4K4G+wyC3MJI+gZ/C3cARbtLZgQ7qJMZQGBDatujbZYpkO6gBk8?=
 =?us-ascii?Q?sPlBAnCX0EcIvESo0zHcQu8/x3MN520DYQwFmLTGMJPW8fz7BHrHiL5H+ncw?=
 =?us-ascii?Q?1mbEJm88fyQTheQpdkI2r7VUe+gPtrFsC+sx6q3a7wgCqrJJ+nOVBKp1CdUc?=
 =?us-ascii?Q?cRxyC+EnxuXb+w+K2/uK4Qjh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915668ad-6d7f-47ab-a3ef-08d8fe476399
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 06:43:04.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YO/6qB2RWsXLZS3isffslG/NSQPxi7yPHrNPHDSVGHAN9obB5spTYlKwPMiDbhz3hHa8+BIQsELebtsQoo0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0030
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 13, 2021 at 02:23:00PM +0800, Su, Jinzhou (Joe) wrote:
>   Add emit mem sync callback for sdma_v5_2

I suggest to describe the problem you encountered for this change, most of
persons would like to know how.

With that fixed, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 93f826a7d3f0..b1ad9e52b234 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -369,6 +369,33 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
>  	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
>  }
>  
> +/**
> + * sdma_v5_2_ring_emit_mem_sync - flush the IB by graphics cache rinse
> + *
> + * @ring: amdgpu ring pointer
> + * @job: job to retrieve vmid from
> + * @ib: IB object to schedule
> + *
> + * flush the IB by graphics cache rinse.
> + */
> +static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
> +{
> +    uint32_t gcr_cntl =
> +		    SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
> +			SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> +			SDMA_GCR_GLI_INV(1);
> +
> +	/* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
> +	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
> +	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
> +	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
> +			SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
> +	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
> +			SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
> +	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
> +			SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
> +}
> +
>  /**
>   * sdma_v5_2_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
>   *
> @@ -1663,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>  		10 + 10 + 10, /* sdma_v5_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v5_2_ring_emit_ib */
>  	.emit_ib = sdma_v5_2_ring_emit_ib,
> +	.emit_mem_sync = sdma_v5_2_ring_emit_mem_sync,
>  	.emit_fence = sdma_v5_2_ring_emit_fence,
>  	.emit_pipeline_sync = sdma_v5_2_ring_emit_pipeline_sync,
>  	.emit_vm_flush = sdma_v5_2_ring_emit_vm_flush,
> -- 
> 2.27.0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
