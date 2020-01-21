Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89EC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD2E206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sbyVwsXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD2E206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD916EDE9;
	Tue, 21 Jan 2020 17:25:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0816EDEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDyP0YCRbt6QJ2gyGd0c444Z/WaYXP1wQorNtgSaPdnWtCx733LU7pnKzTtz/Jj3F+MuGJvQQnNjtg8JvEnOkpclxWLwqCxMTV8VdtMOAS5KXH91LiNbql/oWYs1zdA51jWlhA7mIAORe9My/Qj+qlU7WnsE3fWjQC/+3AhCF9/K8TJZl0POOFK8736Bo+xaOfHFuHOiwEFUq9n8NFx9OFikcO1gq1ZAoTzyRWQD4crIxItj45REqtMwmt9guqYN+7+Bz9jxiMwILa6NSk22ECLYUOzhBbd0LNyxc8H6qg4OAx1Y0MLzKvYWhrOgTl28ygzR9Yk78qeWsB2TV5R7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiCaf9qQ4ptMJMh2+wmALCEtxQgw0JNheHgwEUlGaZQ=;
 b=k29cglL9XXRO66YyHH5ShEG86yMpw0kHDlny2g82sYF5UFuGQmrlMjxYZHjG4i6cqieIXPK9h2XgMk2+a/EcGOl9StJhZpsi11COnSuFNrmApynEX2UmAavUiCX6HeLYt8h/RN/1TN68kUnelJ5ddjZv8EFEcAB4dvypchrgvzAX8HurFUQWYRCiHawQlk5Yd+cXfX1df7CFwaLC2ZtWmlnQ4YtOUthIdZnE3KrHwBUt0Nc+CWJ/mj82XeOUPUNXx3eUneDtkEwsZcAaO2i24XQadJNWhOvqZb7SZdPc5s75unkXg+0FBL6G0LnDnnVbuMAsI1upFvgtTUD8g0NUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiCaf9qQ4ptMJMh2+wmALCEtxQgw0JNheHgwEUlGaZQ=;
 b=sbyVwsXGGNAQIOB+hPleAxSkGbg7xHvHSsynh/ggUWP4hTVQ/YldpvxQfmMY6H47So3+Tii4cvmcJZfSh8KcHI6ipnxlsqwtNv54zL2X+JcQcYICo9IYt1g+byzriJCmPwNkb0cVDOSpa+nMKO75rMwdehgDJugzmPmTLpEdgLo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3129.namprd12.prod.outlook.com (20.178.198.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 17:25:38 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:25:38 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: Share vcn_v2_0_dec_ring_test_ring to
 vcn2.5
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <bebf3381-87ca-fe2b-3532-630f8e2381ca@amd.com>
Date: Tue, 21 Jan 2020 12:25:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 17:25:37 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4576ce3b-e68d-4ed6-ebfd-08d79e96ee51
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:|DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129F078131439679ABF8AD2E50D0@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(31686004)(66946007)(5660300002)(2616005)(53546011)(6486002)(8676002)(52116002)(36916002)(4326008)(498600001)(16576012)(66476007)(66556008)(956004)(44832011)(186003)(16526019)(31696002)(2906002)(36756003)(26005)(86362001)(81156014)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3129;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 537/Bj1swVAB/Ucv2Mbt2mHWFMtCCh+ejo/Mxzx5u/mUCHAPuJ59fy1YV6MHd/sKrenLpdIxxMmkiOo2Z561+gwCzhxTGgloLCD20dLEEN0+OsVnDX5bJL8lWS2ErpsxwvDaRR/MhoRBA+4BPgB780bn3glUgPUzvQHpvbp3GwB3OnPKws3c9ksxeoe3685ZlXEHrt9ELhaQzHuYXUsHFHe0HFQo7IeFYdrrAH9aOdnBEYPculliXfVRHeWUJkdmNxcf2CVkNIj/O2OVe94GMvWT6OrEh7AIedyANiDPEK6EvDpKej+ybI5+4g0lirgWA1OMzsCjGbzwkDBwDDpzf5/zsrRZE58/cGFQBeUObfIhp9Skx9LNiQDYsbOOkJ80rddpv2cvZ492CWc7C275L13VxwZA2kkNpVMcwyQq2yZSE6Ka9VpaerqEhctwjLUm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4576ce3b-e68d-4ed6-ebfd-08d79e96ee51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:25:37.9232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9PvcBixrycJCjzKr2edwLCAnWrxlnoFcvFvXjyXlkFz9B3XO96VVlO4BLKi1Hqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-01-21 11:19 a.m., James Zhu wrote:
> Share vcn_v2_0_dec_ring_test_ring to vcn2.5 to support
> vcn software ring.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f4db8af6..e2ad5afe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1624,7 +1624,7 @@ static int vcn_v2_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
> +int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t tmp = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
> index ef749b0..6c9de18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
> @@ -37,6 +37,7 @@ extern void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   				unsigned vmid, uint64_t pd_addr);
>   extern void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
>   				uint32_t reg, uint32_t val);
> +extern int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring);
>   
>   extern void vcn_v2_0_enc_ring_insert_end(struct amdgpu_ring *ring);
>   extern void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index c8b63d5..c351d1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1488,7 +1488,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.emit_ib = vcn_v2_0_dec_ring_emit_ib,
>   	.emit_fence = vcn_v2_0_dec_ring_emit_fence,
>   	.emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,
> -	.test_ring = amdgpu_vcn_dec_ring_test_ring,
> +	.test_ring = vcn_v2_0_dec_ring_test_ring,
>   	.test_ib = amdgpu_vcn_dec_ring_test_ib,
>   	.insert_nop = vcn_v2_0_dec_ring_insert_nop,
>   	.insert_start = vcn_v2_0_dec_ring_insert_start,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
