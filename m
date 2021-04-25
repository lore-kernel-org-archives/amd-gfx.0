Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B7C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE2361425
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE2361425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742F6ECE5;
	Sun, 25 Apr 2021 07:37:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600BB6ECDE
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8W4SEdoj737AfylvS56d2DRwPkdby8BagzSfx/rLLW/y2zybvaCuH1298aL414LEWmutXwKB1helTHxhoZX+HOpzlX0ZzKssvX1LdtHBmWz9sl3GO6b84UlIjQ9KHhfmMYl+te7iwdbTXTrQpMWG73KAFFM0GgmeeDIgjwyTZ5oYIww4pRfYAa/yJxfcVKWfWikIsQd7Z2vUqQcsGSab+6bxPv8CVqa1DbzW85ZMiPAyCG7Mpz3iyR3KqeLQeJCqRcS7kXSVkeLwki2JSNBXSoeo229XXeLV4/o22AyM6lrEkY/TObFys2V8uASIOnZQ3sUkRR4vNxDdoica4i91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoOB2IkS+yCLRaIEWt1DVI405gutLkdQ5yCoPho5/Pk=;
 b=EaqYs5Bm0IiPzcx/Ku1a3oWnBZzRhBANT1RuwjGhubJUJgnbrgGbqQsHJWhG25fgR03jslEEbBYvXIX8n9mVYTyGbiaGwB+GFM80PXMWx3SoKszY483jhpF+Ri/uZA/8BY+C1kDh19pOMeT+A3uRJd2ap10cobT2vYQTgCTW54sffe5mgUP8Wd3dexWQlqe2YQQmW/47QE04r7Hvr4CVDBw5ebHDaLlIwTTMv302nyfySVyhJY2IIGmjFv1KHyuHOsmeuhlxHv23sOJQqDu0JcL0Uq8WHleEhjvgTXk4+1bMLjxkR2uyvc811qvz1REXaCO/N2wsW4Fy1NpvouHPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoOB2IkS+yCLRaIEWt1DVI405gutLkdQ5yCoPho5/Pk=;
 b=C52r0M0MB3G+1b+HDr86UtfAYcx5CHrPAi6Qe2ZcDYqijFp0tTNhN7S1WIj9sjPr9AY5Qq5Yg+hAuZNi06cJBX0SLIheU2FBNNulkZiGBy291Rb8U5wF3y7bIvGRIqTSOhu9+I4dgIZFPKKgn1dC890iCAzsjUUD1HPzrVFc8/I=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 07:37:08 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6%5]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:37:08 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Correct sdma 4.x irq.num_types
Thread-Topic: [PATCH 1/2] drm/amdgpu: Correct sdma 4.x irq.num_types
Thread-Index: AQHXOaTvijcE2F3upUCLmfdWFk+QjqrE2DBg
Date: Sun, 25 Apr 2021 07:37:08 +0000
Message-ID: <DM6PR12MB46032B5D03DD1BBA45D65754FE439@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210425073047.45484-1-Feifei.Xu@amd.com>
In-Reply-To: <20210425073047.45484-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=598e14e9-09b3-4bf0-acaa-6a5a40c80f40;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-25T07:36:43Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bf5e0d3-b6b3-47cc-c35f-08d907bcee39
x-ms-traffictypediagnostic: DM6PR12MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4337F8984B2579A23FA7BD08FE439@DM6PR12MB4337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9hVsCdiyYDEg6U/OG8T4kDKaiUDBlSAC3X+aqADoh8gk/SuRfNbpapBlaDusWbFhQwSNxuaoixIztPH/xkjWX+b5sH7E7sulP1YPJfAkZh9r2m8Y6NyiDMHmGgL52P1JRnZvFu6NBfoJA8Y3vlsWOq42OaITYG6GVEeYB/3NcMaaH7z6xATIHMjc8/vhAZzB7EfQRhc8e0lbB8Xbz5fxWhqyUYi/vooh5NYlEebjuPY6Bqw8EihQAHELKXPlF0aGuawZTzE8uBp5N/ExvfuWD9OwEdoXqNqwbwnmgrQXPlwXMpzyl9/2BwyPT8G64MJE8CEOtdsOSfHpb1AXti7U4tH2hvIAyYJWHCbT689663R60eyteCZbRTyS/ucqgM8+utfu4/QwHvOJma+4aZxgIStXGJ/MbAdP8J+JhpZ+h6KNI1l8i5gsWyn2t48xFT4jxn+NhzlAcJqVSW5WNyR/GBz9y4seQIhX1lk2O65Y7NgaeEDEdBlqsWQ7YKUsXMZaBN3Zsv3lLHZMj/Gw+b0tjD7HHqp1hxsZSgEepxk1p0f2r05jqOxZDGmn2NkJWHI5uBEvglHx94mi5fWn8fODa/Vut2F3mJX8k8EQBXldcM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(86362001)(53546011)(83380400001)(6506007)(110136005)(66476007)(66946007)(64756008)(66446008)(76116006)(66556008)(4326008)(316002)(8936002)(478600001)(8676002)(71200400001)(7696005)(33656002)(5660300002)(2906002)(38100700002)(186003)(9686003)(122000001)(55016002)(52536014)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2QCI3xbLFC9T9BkRhXG3hzqRcIEniUR0dZnVQb7WESmtLUxDO1wpJMuxuMUf?=
 =?us-ascii?Q?OpdfCnnx+3w0GIqSXoQu4WsQlpjwXdeN51ZwQZJ8VdFEmcDqmROywaRJiwZQ?=
 =?us-ascii?Q?+R4ORusoCAumnB2TMQv17CsCmwlx4aL7bk3LrqLSdFO3abpiKpZCXWpvUFqn?=
 =?us-ascii?Q?v5nYipTwvc60/J00B+W++kTJ89erybgWGJZTc2kfePFxJ3ZZqHXTe7r7HWJ5?=
 =?us-ascii?Q?HJxOSYI8FOsXoRD4bq0MHzpJGkQvPQbWue/SGYiefDI9JG5wY09sH5EMog3t?=
 =?us-ascii?Q?7WAkQwicWhfJYEFK9b1dw0H5fHQLox+cxELORa1OKwDuBboLJXet7V6Tl4BQ?=
 =?us-ascii?Q?BPe8c49wtBAtnwDGH4JlKMTkKO7zhl6YCip7GIh+tdfo0fwrLY/pLbdX6dqP?=
 =?us-ascii?Q?EQDVB4SnS62CdMJgB1LTbtrP8f0TvGrRT9+GZ88/7JWq4vR106OwzsSthzSn?=
 =?us-ascii?Q?8qhn6hLiIq7VW1XtG789BB35qz/5FOfc4N2wAGHE4+PBq9nVvVIYPsHlafLe?=
 =?us-ascii?Q?em9mxEYrhwfknmA9XiMfjoan427I3/Y55fjHloNOdcbcI6JNx5yB2HElnion?=
 =?us-ascii?Q?GogiK04A0wQk1qssLlo0RlJGD5memV4zXEkAZNOrVsS2ndow1HE1El92k99M?=
 =?us-ascii?Q?KEVDk2T4SaPxwIY7qBge2JJt1xzM6QPOJEkRZGtRDfuNcxe16EILD8feI/yS?=
 =?us-ascii?Q?+5cGrPbGM89OM+cJ5yRa+Fmkg0FrhYP7zGM6pc0XVFPNxvLDusIFmkh2Ltbi?=
 =?us-ascii?Q?JcvtHhX+mDzLT6DwYSVhrPH39Cg+Uz2ue3NRNV4LJbFusrkGZVqs3qj1yOrO?=
 =?us-ascii?Q?LfGxgrEjK4O0vAAVFRcCOv5xuQDkpLlniLLPfEz5vLRXB62oDK4d5vnb83co?=
 =?us-ascii?Q?B1tUCQEBCvx/8uoVFCH6tSY9LqwyJ7B0k298ZNQDbZke3jsRvv61W6ntYj5+?=
 =?us-ascii?Q?5PXCDE5UFCAU3pLg6i95PnEtw1cLoHPHSdat29q0fFy0TQghtRHb1GEgFcUQ?=
 =?us-ascii?Q?KThBg/ZaUe2Xbo6HUstZAmPLfQMvATp9wrzIF/Oi/eBUlH/GZUXgl9DpwaMx?=
 =?us-ascii?Q?Hf6VItEx7yPy3xISIJHP7heG47/vZmbXEV+jyeMeqWx79Pw9LNFzM6BdoG0P?=
 =?us-ascii?Q?Z1OkLpYp/NDTZcCjV5tB58r1pwJ4OFNUfUBXdywAj0QwkBHNSsKIo4Ri5t4E?=
 =?us-ascii?Q?s9ps5xR/HgKywbj7FBQ3J3WhiqS/cbqUiU2+Zl/EnuBdMsomOttFw6xznIfx?=
 =?us-ascii?Q?ISPomn07GxhsJ9vXFMLb6J3ARxjEsOBTW/W9JtY+Uw6KKClpnjMjE8LbPqOh?=
 =?us-ascii?Q?u+PHihYavy23gf1qyYFn7LoY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf5e0d3-b6b3-47cc-c35f-08d907bcee39
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:37:08.0315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kuaIHd9ew9Ni+zMVGu7BCxtJIcQ7sywx4JVeZkxavSTjX4+CrcM0iIz/r93HGcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Please ignore this one. I made mistake on the instance 8. Will re-send the patch.

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Sunday, April 25, 2021 3:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Correct sdma 4.x irq.num_types

correct and init the sdma4.x irq.num_types.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fbb701560ced..2800b1b1f2ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2609,14 +2609,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 case 5:
 adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 break;
 case 8:
-adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
 break;
 case 2:
 default:
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
