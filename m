Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFEC33CAF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D5E2077C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 02:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YNJyjBPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3652E6F37E;
	Fri, 17 Jan 2020 02:55:22 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE416F37E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 02:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcnsQgH10//s1+XthLp7KDSwToWy7BolO36zH76Pf5webJHSFbVYntJ+YlNUAp2TqchgZ7ynoc859hj41D7bXQhhlOE/nsL2qKr5oU2yflJTxaYjFgQa+luG3/0yJM2qOr6/PU1940LlAODVTOmBjjcaSTA/8804gMU1+Yp09M3rcV/wiAX1wjOsgWHGeFMDvijXDRYvBdDfyQCwrwKVFFjL7znMNfWyVZn+IFH2VIGaPdG2nIJ/OjMIygIMy6jHBf5uIuvPC3Brt96q681YgCtOGYXRRwW5FA2lXcbwnf+g8b9C5mOvDSiiz7dmMplWnJ0LXvm3UfefzhNcYOP9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGY9kuuC3Zow+lz2YUM/mT4rx8zHaF1mC1y2g66KZnE=;
 b=OaD9xtk2PpmdgUJKoi5aMzv5xfnI1l9I6nrtkpkBURoiydXKmTTC/brB/Gfe4OU0R3h1GdVyXBa7tYOaK/7Oad8X0MCym/sZcWQbLVp0ykdn9fJcY/iKEBIWq2MgvNAzG94LmVatxlQGzCofVyQgd79IkH7Zqd1odfVE2ZFRq4lDhhpVfM/0cidv1jMzd14sTQwuJy4FbD0tqa4DvYgo54I6WFWQOZ1atY8YaYiP5oq6AQX/s4JNwswGr8yLDFA923zjH/P9u7xqX40OefLIQsRGPLzymCM3lCnYPLLVFdIilXpUFEQco8IHVnP/Lluo5U9Swz3SL7vKJZgY1hKs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGY9kuuC3Zow+lz2YUM/mT4rx8zHaF1mC1y2g66KZnE=;
 b=YNJyjBPC6TzpTbjBfix9Uj4td6H1jONv6Z4a6Sax+Dj0/c9BmWYjB7+JbvAK7fRRST6CPX+ZRof/ME/mkL3BUkKE8HcUBcm82j7Pz9/SjbRl+A16/KYjONsDERhUFT9s27lrdlzKivBEydof9ek0FiMc1WHo1T2fQEXDYzMqEcQ=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4111.namprd12.prod.outlook.com (52.135.51.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 17 Jan 2020 02:55:19 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 02:55:19 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region
 in pre-Navi
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region
 in pre-Navi
Thread-Index: AQHVzJ7PCtOEJJengkKo6ZtDTCeO16fuKcF2
Date: Fri, 17 Jan 2020 02:55:19 +0000
Message-ID: <MN2PR12MB3087DED7174CF1B8E966A0C389310@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>,
 <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T02:55:18.309Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89fbccb0-2d69-4f89-1a4e-08d79af8b022
x-ms-traffictypediagnostic: MN2PR12MB4111:|MN2PR12MB4111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB411116A7631A3279A0D5E41189310@MN2PR12MB4111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(81166006)(53546011)(110136005)(2906002)(81156014)(8676002)(7696005)(66476007)(66946007)(66556008)(55016002)(9686003)(91956017)(71200400001)(966005)(66446008)(76116006)(64756008)(316002)(5660300002)(6506007)(8936002)(52536014)(186003)(26005)(86362001)(33656002)(6636002)(478600001)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4111;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TBHV/p62BKNP6eR/kTfI8peQSlK6+3IEGfoGOAn8Dx0/MdnWmmBtkG/HDkLzi5+2g8Dhi4Qrv1IkbsgHm6x9jUDq3eoGMSQDydw1APIkfZ1gO8TlLDvvgS/iUyp7C1p1ckuQqR220Ip7vPFYypp0Fbgug9VQv6Vl9h3VPFDGRW7g0X/J/x2FIUG4nRk21c3Xq+hEOXid6uMrMNopLczEM1iZ8z4J/GPdSHHhVrFXl7ZcJF2nO4NDrp/Mk3QswVZsFurLe+zxzbUHvHyAHWIHIoi9ujMqxHQxnHLlX+cfaUPv/vOCKPTAtWmvc+n3e2XC94gUR5Hx7jDgLenEEgjpZ7Mm5H38MRsAsmy/QnaoxUSfxUJY3eKCwmGZB4kmqDtJScFyhPFgqI3+d4ccJDqC67sljo2HBX9Bvetgxdo84mop0JoEHMeRRMvm9C/DUsYgfjHC+WosAzy/LGFWdGDI9d57xiJhNucS2t6KwCmRLc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fbccb0-2d69-4f89-1a4e-08d79af8b022
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:55:19.1487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKHDbTpmyNvSi7ZjT1dKbSkIJM05pP4brp12dQ3Oodoc5CzB+qzYWDsXfVCB90OO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

[AMD Official Use Only - Internal Distribution Only]

Series is Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, January 17, 2020 2:57 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander; Gao, Likun
Cc: Zhang, Hawking
Subject: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region in pre-Navi

IP discovery is only supported in Navi series and onwards.
There is no need to reserve a portion of vram as discovery
tmr region for pre-Navi adapters.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 967f6d0..f21fd8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1822,14 +1822,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
         * reserve TMR memory at the top of VRAM which holds
         * IP Discovery data and is protected by PSP.
         */
-       r = amdgpu_bo_create_kernel_at(adev,
+       if (adev->discovery_tmr_size > 0) {
+               r = amdgpu_bo_create_kernel_at(adev,
                        adev->gmc.real_vram_size - adev->discovery_tmr_size,
                        adev->discovery_tmr_size,
                        AMDGPU_GEM_DOMAIN_VRAM,
                        &adev->discovery_memory,
                        NULL);
-       if (r)
-               return r;
+               if (r)
+                       return r;
+       }

        DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
                 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7C0e258a182b644b4bec7208d79ab5f009%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147978523723808&amp;sdata=xHiisP003oa9MFYoGfRTQfu0XR5XoieD1To9vlobOl0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
