Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDEAC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D7C222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qeqy1U0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D7C222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08A6E072;
	Thu, 19 Dec 2019 03:02:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3786E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiPtFPt6cv3Sak19o3OmA/7E4C+lvQJUvT0aRTxDDfOoQ0iK8IPLP9++dzR0QoKtiOTMK6nFo0OQAczJc+wrNuVB6OwP24c/x3xkNyacGdoWJlgBrol4Stl+spiCgXqcSnGoE5Wqv5+CeFupPWUPJ37u8xeJjzOMhynvP8ipFTTwgpltdoWEhXqyIdb3FfRdW40KruD9bW/53FIl3RQaody+M3yHoJV6tRdpFNDibWoxX9fsPpCuQIlrm12XL+purzbpdzMEyYSNScVu8YFoWQ7ztfebUwkjPsJ2u+2WWmU6TkABomLdHC89Wjb6DASFcR0MVRw7TT2WEJn7UVcfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqZ2xmL0EhWwrl9gAMecg3FR567JOX5pA7Yw/ttFOew=;
 b=W+bjdm9DMBzr0v1c+qOhSQpMnYlopiR3lyrPtMqpRQ9ksGdxgpuTWH/W2Z/iplTmJyfNN/IV4B96oJZviqQSoFDqzYRGLvzRQXMLqD+qKBHDwVQWQyR04VdTUzO8H8TwOrhePjNYh/nfGvvqj9iP1WaN1/lLqSmm2vk7QJ+06xJbdbqC3iGWVH9gviG0XXwlFyhUV3udW0FdiDR7KIYIm7asVVkvNa2id2QXl5sBdtdOQfybjBmOO1jsVOpuMt1gMMFprRFSgqv0+5gmyJtoap244jajhULFMG4WH7cGyZAPBmL+Q+gpcl3KxbprGtl9Gf5VmymOSymJQ/zvYXr6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqZ2xmL0EhWwrl9gAMecg3FR567JOX5pA7Yw/ttFOew=;
 b=qeqy1U0+ZYOmpH3B0l4PgwOp9t0kgScpXbhOeN09pLWbJgwDle9aChEWNE2W3gsZZX9cRneYs2vo2WlfRL6JVo26adU5QLqdsYWz7zyLJ98I+JjEoLimR/wjkPQRztlKcQe1wSH0t0Tb2legqORwmTgcUwv4szzSzq3yfp3w6qg=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3152.namprd12.prod.outlook.com (20.178.242.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 03:02:28 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 03:02:28 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Index: AQHVthY/izIwnIR8mEWlk4lTbMg2zqfAxT9Q
Date: Thu, 19 Dec 2019 03:02:28 +0000
Message-ID: <MN2PR12MB308711E4D03C5C2750D2CD2789520@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20191219024416.32321-1-tianci.yin@amd.com>,
 <20191219024416.32321-2-tianci.yin@amd.com>
In-Reply-To: <20191219024416.32321-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T03:02:27.653Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91dd99e8-0958-43d4-6e2e-08d7842fe1cc
x-ms-traffictypediagnostic: MN2PR12MB3152:|MN2PR12MB3152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3152EACDE24E115A3362D03989520@MN2PR12MB3152.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(8936002)(81166006)(81156014)(8676002)(66946007)(64756008)(316002)(91956017)(76116006)(66446008)(66556008)(66476007)(52536014)(4326008)(7696005)(478600001)(5660300002)(33656002)(86362001)(9686003)(55016002)(2906002)(26005)(54906003)(71200400001)(186003)(110136005)(6506007)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3152;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dL14II+vAdZx5es+KcZU9hUCvtqPlad3mqLaGoUOahy6hUE45Po8RoDK4sk8bp36OHW9s5uST2lWn008mfZBBvyBzYJ2SPC1mfVvmPKyw7trRrlkHTiP85ZBX6HpDpCEsY7n8FSYnFO2FbW5JrzVXzYO4BBvTpFdixs2IXpNG6iqZmchZXYjP7W6qK5vW8xmgkqLgRFJvp4X0pLtjoiKC4HOMhp9F/o2VrffrMEnCazjwheDBQRYoSdS6WJbJSxCZ08cOYfz732//+SHyebCqO2Dli/OEZJevFL9dodKkYos3VDtZqxozK2DXFFs+ew2tr/NQZQG+mbI6W/yhbOsDq4Th4Shjnv/A8B5/V4E97r9PM1aFG2CulY/G7oul1wZwcIkcaRjwzd/wkA7vF5A+WMZHDZWGXUfe2kwrNPYZ2sI9dvXdDzqwn2Azz3inlGc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dd99e8-0958-43d4-6e2e-08d7842fe1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 03:02:28.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXqQogmojG/wHz1Zjlh5zjzVkEK7tQQ/9yFWkk8fBao6hxmYVk+Q3F+2eYSNIV9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3152
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

BR,
Xiaojie

________________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Thursday, December 19, 2019 10:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Koenig, Christian; Deucher, Alexander; Zhang, Hawking; Xu, Feifei; Yuan, Xiaojie; Long, Gang; Wang, Kevin(Yang); Yin, Tianci (Rico)
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservation(V2)

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)
has been reserved, and the p2c buffer is in the range of this TMR, so
the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..3265487b859f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -202,7 +202,6 @@ struct psp_memory_training_context {

        /*vram offset of the p2c training data*/
        u64 p2c_train_data_offset;
-       struct amdgpu_bo *p2c_bo;

        /*vram offset of the c2p training data*/
        u64 c2p_train_data_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ec84acdd43a2..60f17e989014 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1681,9 +1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
        amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
        ctx->c2p_bo = NULL;

-       amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
-       ctx->p2c_bo = NULL;
-
        return 0;
 }

@@ -1725,17 +1722,6 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
                  ctx->p2c_train_data_offset,
                  ctx->c2p_train_data_offset);

-       ret = amdgpu_bo_create_kernel_at(adev,
-                                        ctx->p2c_train_data_offset,
-                                        ctx->train_data_size,
-                                        AMDGPU_GEM_DOMAIN_VRAM,
-                                        &ctx->p2c_bo,
-                                        NULL);
-       if (ret) {
-               DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
-               goto Err_out;
-       }
-
        ret = amdgpu_bo_create_kernel_at(adev,
                                         ctx->c2p_train_data_offset,
                                         ctx->train_data_size,
@@ -1744,15 +1730,12 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
                                         NULL);
        if (ret) {
                DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-               goto Err_out;
+               amdgpu_ttm_training_reserve_vram_fini(adev);
+               return ret;
        }

        ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
        return 0;
-
-Err_out:
-       amdgpu_ttm_training_reserve_vram_fini(adev);
-       return ret;
 }

 /**
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
