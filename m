Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DCEC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8152720774
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LN/ScAJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152720774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B0289DF9;
	Tue, 29 Sep 2020 07:00:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B096C89DF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 07:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULZT2jrT5dzbL5ZYs/H/CJTVQ4bpUYffQ7yFBhan06zX94JDxLMUwM9QZYG0FNcuez4qy34AVv7Sh/oJUXcJKwRQPRM0NR7CyEMLd66o2qOnUZWUv60ruzEK5KqNeCRMIFMVHfAW3RpawhhKCX4qPQh57Ev2x04v6PbcwCjpE5FjQ5VoKG4U25S14EeAOMo78G6uRW91fohzNiGAQu26tgeKPSbWruZEKVz7+SLE3Auaa4r3gtVYDpwni2zBaW1XZZpYoSfjKTSFM5jJro5bvo/TmTVKi2/mWPhnkF0ZLa1SdB7XtOz/Meg74bnijpv7DJ81cqgnrMB19mQAy1bqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472jpKYXDS6NLErYJF1Kgib/H8j+aMLpCVGgtUpRX60=;
 b=h5M3m5lN6KQ/nudKuoHImbgGFGI/HroMwgmvewby9GA9bVf12RlSohEuQvFD8rMLquFJ9Shv3JHZPpMnxxnelucrOUZ8wqRTbljo5wqRv8OsFU0stxF5Hw1dOa7oHRbr/tJq8BfzbDxIM8FIAew2ufqxlAhQyJO9AgTGUCbuI/l2eYJskmlVY8GjgEiTRj+2qtx0EY/aXuOK+3xiifL50h+f/d4RPh0Hk6Z7xa+MRo4rFWQ80xfFBU3sinbeY6TXiFDAs+OEMBvj94hs7yKenw1/stuvxGLP5exrI+SwZst3mrmelk1tny6Q24i5jUaDHylBqnDIgJMekCKZA/55aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472jpKYXDS6NLErYJF1Kgib/H8j+aMLpCVGgtUpRX60=;
 b=LN/ScAJmjHjWrztUKnMwb+fx/ypsLWUUfsSy0/PBfq9PvruZ+jMEWr4CDVpAhj8gaYYQaCcp3KmtKhxCkLABhWe6d2mIZkxNiLprU9KC5eo8XZyRDKcC3pJ9yedsC2sBPYkROwcVtePOwT6N09wYc62tSn5xoOmFdstzmbABeaY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 07:00:43 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 07:00:43 +0000
Subject: Re: [PATCH v2] amd/amdgpu: Fix resv shared fence overflow
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>
References: <20200929055701.3120-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2b2813db-1253-e3c5-551d-ff94a01931ed@amd.com>
Date: Tue, 29 Sep 2020 09:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200929055701.3120-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.16 via Frontend Transport; Tue, 29 Sep 2020 07:00:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cf2b94e-681f-494a-13ae-08d864456121
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB419268BC1DF4C49144968C2783320@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIAnzavBHzhYR/DoEc5weft+sR82BStQaPLxipUQJdhboZmUycWJthPjxnFx+urv6vNlGJF/bSPLgrPtRBDuzs5zXDu8GApNXqSZ7abTT/zKroYttbESlUa8wM4fj+4Xm/+ouLtsVSqqMEaYcQOH2c67Gp2cTydOKEZekRJTeeJZfI+8iaGH2XTWEqbIIYgy8OWho6ZUM8jvgvdXk3F9bry0O+OzoGEPFy7mL4jftpSdm0ys1wBUMPU2qXcHpj6OJN270qf8sKButATVXfi0rkJXz9HpchBOMp8HX84sWBHjEZBUiqSJRHvV9pBd1Ln/omWOAglSmM/E6hN4kqXFSEks8QaInvYLQiqDFWD9wePOW7nyaEaUFpdWFUq1q1dK8wUAIybVDaTHkiAHMPFNRpAy+Sy5EOmcPIzaOZ7TUvb01+188AyjstelA56K9QsA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66946007)(6666004)(31696002)(5660300002)(8936002)(86362001)(66476007)(66556008)(8676002)(83380400001)(6486002)(2906002)(16526019)(186003)(110136005)(52116002)(2616005)(316002)(36756003)(31686004)(478600001)(6636002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nO0KOFQ8uAaQmS3zwzCyQPi6SATUQWo5OMuL422nwinLnlmsQ1Vhm14yJi4MteApgcvjoYYkhi+T4FXb/zJvUihVWfZW5QvfVhAjvRxoudXZrP4U8ABYIPnhdjka9RsdeNgRJQli19yYNyMzDUVV+Ij4qpdNkGPD7JC7pk7M7Dy5vKAKIq05Y0VF4dw11hnv26Mn3XsTQ9PzT7RS/LyVVeRLh9proNYPIHuJwc9jrtoJT9QG1/jzJhQjMLfNXrysh20kPfjYBwYLuunmc5XqPNxx6aH1XreSp9QBqvPb+LvCrEHrLNVTauC/oC5Fy9fokhgRD1Ql2kt9X5TDjnHJwzvPSt0yLNh8nfCtXOCawTa1VhK4MZ7JfUizZGY6ArMcT0emg2/55rjCezu5/e8/PcuNbv3EDeg1I3S+OeK5lrnUQALEx/xQUdU1C1rkDOtRXtCaZtUUrO7qHWxWuvXDFZdrQmG+O1I2EzKpbUDxFrF68lhV6kiqKsW0zmrWum/ImKeoXR38sh5xPwLSRX/KLJrsXJXzlg+PG/sbT0TpUgUaJaUePTmV657JCWoS+hWRLC8OpOyS5vWurF7yERZiujyJARIIhtuZBErtTW1JAZOUmchNRWAJbnqri8Av60DIZ8fUhxgZwX23KYy0KZunsCyPmxfH31g5DU/CKRzxatriqD9Z10rIXtkGaMOtb8W06YGIcHmZmZMSlcTDg5bvqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf2b94e-681f-494a-13ae-08d864456121
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 07:00:43.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxbjxhQ6S2L8Wop/E+D6xIsMqA8XqpCB+vav3lKYGLdp5Ahfu7xDwWhADu2QLt09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Philip already stumbled over this issue as well, but this is the wrong 
place to fix this.

dma_resv_reserve_shared() needs to be called after we reserved the page 
tables and before we do the update in amdgpu_vm_handle_fault().

Reserved slots are freed (in a debug build) as soon as we release the 
reservation.

Christian.

Am 29.09.20 um 07:57 schrieb xinhui pan:
> [  179.556745] kernel BUG at drivers/dma-buf/dma-resv.c:282!
> [snip]
> [  179.702910] Call Trace:
> [  179.705696]  amdgpu_bo_fence+0x21/0x50 [amdgpu]
> [  179.710707]  amdgpu_vm_sdma_commit+0x299/0x430 [amdgpu]
> [  179.716497]  amdgpu_vm_bo_update_mapping.constprop.0+0x29f/0x390 [amdgpu]
> [  179.723927]  ? find_held_lock+0x38/0x90
> [  179.728183]  amdgpu_vm_handle_fault+0x1af/0x420 [amdgpu]
> [  179.734063]  gmc_v9_0_process_interrupt+0x245/0x2e0 [amdgpu]
> [  179.740347]  ? kgd2kfd_interrupt+0xb8/0x1e0 [amdgpu]
> [  179.745808]  amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
> [  179.751380]  ? amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
> [  179.757159]  amdgpu_ih_process+0xbb/0x1a0 [amdgpu]
> [  179.762466]  amdgpu_irq_handle_ih1+0x27/0x40 [amdgpu]
> [  179.767997]  process_one_work+0x23c/0x580
> [  179.772371]  worker_thread+0x50/0x3b0
> [  179.776356]  ? process_one_work+0x580/0x580
> [  179.780939]  kthread+0x128/0x160
> [  179.784462]  ? kthread_park+0x90/0x90
> [  179.788466]  ret_from_fork+0x1f/0x30
>
> We have two scheduler entities, immediate and delayed.
> So there are two kinds of scheduler finished fences.
> We might add these two fences in root bo resv at same time while we
> only reserve one slot.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37221b99ca96..9e0116c7f8d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2869,7 +2869,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_free_root;
>   
> -	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
> +	r = dma_resv_reserve_shared(root->tbo.base.resv, 2);
>   	if (r)
>   		goto error_unreserve;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
