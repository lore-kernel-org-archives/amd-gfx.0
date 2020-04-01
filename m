Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA265C2BA12
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DB72071A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2++fzoSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DB72071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F326E9B0;
	Wed,  1 Apr 2020 22:14:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2946E9B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTt5Vc054flXvHrZ3fI2bvo+3d0ldkLTbzpiJLm40PPcjuxnMxS7aIuvvy+2DF4U3Ka+ZmKQ7Fd+h8Nkf8HlKaaKZs8uhIJa9wcXC8fvaakOQ52fhv20Qa47WD/t9jW3xpy2desB+5/x/xEk0kxwTSHApxOJ1ShKu7zyF0DTUmHqY46t0ySF9Yfo8CAnmrIVlameuxWZzCtuKYQr7HN5kObXVWbrBFf1RuR3TM9CE/RbfgtwGfVLF1aGhiIL66aIGKSTJwG67m1/sWNj48pkIyr6JowlU7tQesI959Kmn0G/yGrynSsaFoGdbG8Br5ui6fgDW0ngdKpUrKp6fGptiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfhgQhYwB0SD5iB582P7+dgSnE/5iGYRVN9ukbSYulE=;
 b=JnCGgXzu8zSAGoFQmGs01ItZsMARI7cJRQ0ZkX0sLItqkWxbk4EGsRwi/qzEK8VDNrmeIhZPBSrlzrjAySWo7iw5oTvLD3NoPA3fGibY++YVw8Ttf2mk154Gf37X2MdoR+O9zIpVg2itAy8NzrJRk2kSwnDrXb31kI6BJ1UtTI4Q77kCM8Q6mIeXIeZsl5CFI3cMJgcaVYg/h+FZqhLX99hQVSOOMVQt49mFjKEByi/4qg/8hGEL029I+sFHbXkzOWQSpfFQVp7llVvyFhQBnOtE1P9f9Mj06KdJ5xY+T5961VSAFs4SELGRmm9y1S2lL+J/malUpHWqRs1KqOnXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfhgQhYwB0SD5iB582P7+dgSnE/5iGYRVN9ukbSYulE=;
 b=2++fzoSzP/DOkYYt5mBTApqoHu7I0G8tOyuksMzbcxq1GXAHKfms6knwx6rnOJ14BqKpMRyJondFQ+D+hvjlvOuTBIenZeef0fNyZzPxb7h+2uoAelKNrKi59ZfGLkzCYlXPSMJMMYJpzFNcLP/fs/S7SwzWVVzhR2M1JFat554=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 22:14:46 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 22:14:46 +0000
Subject: Re: [PATCH] amdgpu/drm: remove psp access on navi10 for sriov
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200401220013.11048-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <213bd59c-85a7-c099-eb48-25697085f87c@amd.com>
Date: Wed, 1 Apr 2020 18:14:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200401220013.11048-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 22:14:46 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de3b09cf-9bfb-49d2-0fc8-08d7d68a1647
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:|SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448C599B2287293B1A6A4BB92C90@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(52116002)(26005)(66946007)(5660300002)(186003)(44832011)(16526019)(956004)(66556008)(2616005)(8936002)(66476007)(316002)(6486002)(81166006)(8676002)(478600001)(2906002)(31696002)(86362001)(16576012)(31686004)(36756003)(81156014)(309714004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+e7dNUH52ZscPfB+8lHBmaO/GVzZAsX/5o11+2S1DxC3CkYmNNxwuW4tyVkRnzta0cPsfhe396vJOvNBFn4qqao7QzT7S6jcfg5OW4e5Vkdu/9c/ZL34XMTTFhd1xCb9YEPX+zaDCain+f9IIH3mP2n/Yd6Hrg00ZBehPL3lfrfm7K+4/zYIJgwSJFf7dagqYvho7UnBhsCRUgUZDdqna2BaXneQOL197OXR6TrRZtGsipLcJhqPKsphstoaVXHsp4cbxnvToWe3oMliWyjahLU6cPkQqULh3waLiB/DDedKUhFHuW6KPT/xTRJz6iLhv+Ze6jFsynphtF34e47M+BTe+6ZjsJP9Yd4kcF7U3paKTMJWhHLiXUvKKQCGPRn6YlN7Bggz/NRoZVM6vjepkgLUA0SC+uSLAv2ts4pJk/qHlsGNCJdWHDWVO6FQmJrVom4B0i3Ve2mndFM+RPvxxA7Z/lO31xu3QVO0ciAZ/I9iY4cgq/yiBf0tv5j8GYF
X-MS-Exchange-AntiSpam-MessageData: g+/NaM8VQjXUoOXGZ4FYdvl5pUkavNCbWGQWTVh0JfwvHuUe/oLvnZ9tlv+bYhCDghaCSEboLANe+PZ4D9h+jk3oxbjuRfCIzknS6qSg0aw4DvHv8zBVEcciv/kzjtx54O4UHse2BtmyRHAqyKJMEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3b09cf-9bfb-49d2-0fc8-08d7d68a1647
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 22:14:46.5380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0NT+UymBH3hrcj0lsbjhMxd0UNE/wZ8LiiDv8Tevi6dr+DE2m92YeBPblimmZspEPB5N9VHzZW8NKUAr6H69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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

Am 2020-04-01 um 6:00 p.m. schrieb Alex Sierra:
> Navi ASICs don't require to access through PSP to osssys registers.
> This on SR-IOV configuration.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 6fca5206833d..f97857ed3c7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -49,7 +49,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
>  
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
> -	if (amdgpu_sriov_vf(adev)) {
> +	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
>  			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>  			return;
> @@ -64,7 +64,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>  					   RB_ENABLE, 1);
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
> @@ -80,7 +80,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>  					   RB_ENABLE, 1);
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
> @@ -106,7 +106,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
>  
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
> -	if (amdgpu_sriov_vf(adev)) {
> +	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
>  			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>  			return;
> @@ -125,7 +125,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>  					   RB_ENABLE, 0);
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
> @@ -145,7 +145,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>  					   RB_ENABLE, 0);
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
> @@ -253,7 +253,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
>  				   !!adev->irq.msi_enabled);
> -	if (amdgpu_sriov_vf(adev)) {
> +	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
>  			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>  			return -ETIMEDOUT;
> @@ -300,7 +300,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  					   WPTR_OVERFLOW_ENABLE, 0);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
>  					   RB_FULL_DRAIN_ENABLE, 1);
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
> @@ -326,7 +326,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>  		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
>  
> -		if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
>  						ih_rb_cntl)) {
>  				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
