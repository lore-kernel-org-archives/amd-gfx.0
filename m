Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A940C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B1061245
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1B1061245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E0989AC3;
	Tue, 24 Aug 2021 11:01:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0296889AC3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 11:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwe6LhNx0Kyj80dsbE2J0qGgdYe53hv0wzYCIV8tG7B2vjXQDpGoWS4u8/DoGZiTI0W2StA0zOhIUhy8A6tXsv5Q2f8SF7+yBXqXHJvgKdtiecNYk2YJF6Y7nBPW/R0v5TZ4jYK9SLzhz1pMknND1bszWPfZvPzkq+zYvmQvFENZGYVUh2jPkuDm0OIv3LYITrFfGI4j2B6FVZX/wCu6qZ+8KJnlgFeTGdttFgSFXjYy7N5ruoGp9fSUzX3S/YEO43PaJxbER/MAWhai1jeCyBSu3Ub6ZOK6ru8Ksi5VMYbfoHhxljgZN8i1OvlKXjhnFLE5pX2dyh4f5yfIbsrNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkQQFKfhwqRsQkE1cVJm6C8GmEkZ5m3yvKOq7JUO3YY=;
 b=XwxTvDpmWcXmslYyqCBUVWmc+jUavNXYh7RXrZzPTREw8D9KAlxJaaaK/+dSMEVmPozuXIEwuwTqt9Ek9DMHBLeb408NICrUqlEI48OZMMd45L62JfJmbjZhrQHV8IwETeoD9pFVgctYAAZctCdFVTTYm4eIL3HJt3fBO9DQMAjZqZy0MwOU2FLB77DFLIqGFdbcrQThsmQYovqgETZx0aArXcQucAOMd8kCRsx9VMjgldqEFX3hO1D2LTosyu7Oxo/vaHtR0SYZ3WdjIKa/PINfGemQkV95FJwki+Z3GaBdyNDR/lvzUcqHquVyLgmQyBgFqMVi0EbYmPDhVGho3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkQQFKfhwqRsQkE1cVJm6C8GmEkZ5m3yvKOq7JUO3YY=;
 b=b28ngtsgDm800HcFHbreftu2snHAZQ/YtTKx/H1fHla9NrSDOlvucUPPMjB0v1qHDVDtMeBXNikaV1AzX2ksO/ODTUoxox5vXyY/SVQH5MxvG5VsY8+pvWBWAhUvAMbKz0A2/5Tc4ux9Eub/ZVOz2gbCdoImbD33BoO9GxBTtqI=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 09:28:19 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:28:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Index: AQHXmMQZg9uCY6WnrkatUp0AvyJq8KuCXGaAgAAB5wCAAACUMA==
Date: Tue, 24 Aug 2021 09:28:19 +0000
Message-ID: <DM6PR12MB46501F31458824AF3BA8E755B0C59@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210824084300.1882-1-tao.zhou1@amd.com>
 <BN9PR12MB525742BD6BAF9328D89044C2FCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB5257DFF7E7F9F2E13C494F6AFCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257DFF7E7F9F2E13C494F6AFCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T09:28:32.075Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7da2ff8-e243-4c70-3ecd-08d966e182c2
x-ms-traffictypediagnostic: DM6PR12MB4251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4251F817E0FA4BF9018A1647B0C59@DM6PR12MB4251.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3gu77Y1tSltUQ+JHp9XGdXi9Y0rHqdETKrCnxbC7X9kO7FWz55H4W4aPvNTZGdW5ivaFBUAQio4EcGZ+c/E7fbE44/lcoGk5RbI8DtPHs1LnzbHU9ufSudnFtriDsGlHaHGurp3+E6DkT4rXLNKjA+Uhl5eXGiIN/vF6COCR32AimFFicvIzl9TOlkNFZXk7tfr4VE8YmLldP/iIMeNgfJuyLcxK8tjHe33raHJ+I1h/x8TPj0inTVhkpSBIz69ja2WGr+MTydkUu09bLRoIYZAddd9IHqL+htu6m7yJhHMskkwTtizxyigJXK7Hj1nY2IFJzIaPGFM7H+1/UQ7CGJ4+BGOyGVhq8x84099gDNQ4530/rUCVYzVN/ec+5mX/QUUdTCf2e3IPeTrQlOG9draFhnIEpONYWPZXojAzFSszL5EgrJ+82fuNlNyVN9rObjQ31HAWg0zJixx2deR76UheahhYboeTYsba/1pWBmhdO6Mb++XiFXBj0ViIcqAGtUVSIkIv55TWt6bUr1V0HfkldmMA5mLBQhu/A4SSOMw1ZnDLGxy8PLouqjX3ijHtdo267kOS3B18zFThpC4OppipEMtIUaMhjOdKzAIiqxz6kcDe8Z4NCTLjybqSj7uYH8eRCApJ+blpYTaw0AiE6Mx7zoWYG1G26al9x08/dACJtnsPHh5e0g736B5sWCjg/HYaJjLKknFpEOqlxZXQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(6636002)(66556008)(122000001)(38100700002)(55016002)(76116006)(26005)(66476007)(5660300002)(71200400001)(9686003)(83380400001)(8676002)(86362001)(66446008)(64756008)(38070700005)(53546011)(8936002)(91956017)(7696005)(52536014)(19627405001)(2906002)(478600001)(186003)(6506007)(66946007)(316002)(33656002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?94VYKY94VXHFWWwvOuwc9XZqUwi0eF7ctQuAiXUiTqmsHcEjqaTgo1V8xX5E?=
 =?us-ascii?Q?hQyewXU0RyEVILpAcJJFjrZtU3aAD9sb86/AnoX72QIOcwpPCjo+iZ0+6Wc7?=
 =?us-ascii?Q?/AOQ/pzsloDjmu+FeE5gCfkZpwFGT00KId7Wh2K2X+5iFgN9in6eBAdjoTVo?=
 =?us-ascii?Q?z9J/k+52AyXjFNLZc/rTioB0cyKHJa8qKY5XLr0N9QJ0lK8EhWBhUT4XlgBW?=
 =?us-ascii?Q?7gjynFRNoP2w1FF079DYChY4/ceaEJGmls7MskofwWb9zQT+VEl5FBV8gvZD?=
 =?us-ascii?Q?baKifXc/V4WF9v7uGdoCReZlgGjhQYEZLM4/YbtajVe/41pIrJ7dnDMKDgz+?=
 =?us-ascii?Q?WzQFwAOF6MyGz0RVNGcvd3frT/ykAL8KhuGhNsPJe2dj3JzS8Fj4N/vRoJCS?=
 =?us-ascii?Q?RBb+mN1ooWMi/uIlPyfUvugrojQEBCzptsuYceyfq4PKVnSxRmrr4E8luOD3?=
 =?us-ascii?Q?mE3hhOy5SoyHirzj8BX0qxUjcqheSWQEtgRtKN0uN6nMYZEH7QFKv1upJv29?=
 =?us-ascii?Q?GREYPhopBt+5w2H79I0GlmdZiMMv215R/nn9l1oMvnkBQr7y5Q2R4YJkyrnK?=
 =?us-ascii?Q?DEIY0TrsJDYG4lravce3cqWNMD9VtvSYl8u4xsmTdYmoGR274Qpx6XmprXlm?=
 =?us-ascii?Q?YOLKWCov+4tX2WYaIx2rPYho1dF+ktLFRSx+0jb+uAUa0A8bjPbpQ3SNAElH?=
 =?us-ascii?Q?80VvQdPSjy4xXML4ulSYZ6QRCR7kCTJ/wvvGSrGIT/1Wm2xRQJ/aYy1Oy23K?=
 =?us-ascii?Q?ehbIuPv8kOGYGt0m8EUScXsNLZ/DqjA2mZxkwgeO7dGZi7705m4r1TujW9zb?=
 =?us-ascii?Q?CVndd0kKuxfe2HGMLTyn8cfabIJi7Sr7rZW8+6KZnDm0HDukoPD0BfRptYqM?=
 =?us-ascii?Q?W/9mPg6hieRKN9iG7NYpmwZPoLYSv8yScc6WuWIKWG5eodCUqvmVV+9efcKy?=
 =?us-ascii?Q?kdOprHrhtEebj4WRxpodBeqQcInzfFWUcGEc0vxyp5PkMnkxpEJcpOKT4L+I?=
 =?us-ascii?Q?wdXJrqzypeYIx8K3/8GZjb0tsLtnA0soDzLR4o/4UCpNgp8I/wZumfmao+8G?=
 =?us-ascii?Q?uVOKl2EcQbVXHnpFzQpOEqJIfwhImj9/82cL/vG5/AjiRTIWJN6UnA4WcFep?=
 =?us-ascii?Q?CgTyjZuU5VLBSWTkJaGYaOikvn+8/N7beDBLUC1TJHYltrMfZBoQHjhvw8Gn?=
 =?us-ascii?Q?Uy/9HPi4zD5vZse3w7MrH7ge6oOatHfmXRQruwVrjDZnNrCx8h+bem9hBXaK?=
 =?us-ascii?Q?6es93tMZ/rkvBydY9wv6F87ARBxt3lp0V2QkYjRjdEmlu5Tsoge+GT6DPd0x?=
 =?us-ascii?Q?7b8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB46501F31458824AF3BA8E755B0C59DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7da2ff8-e243-4c70-3ecd-08d966e182c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 09:28:19.5219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJNfvh8gMLZ+ZhpvPFH7Eua6HQRx3ABPZtS9QSWHs9k7S9q9tQIQB+GLo+pev/cm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB46501F31458824AF3BA8E755B0C59DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Hawking,

GPU reset will also be called in dev->kfd2kgd->ras_process_cb, this patch i=
s to add page retirement handling before gpu reset.
unmap_queue mode (reset or preemption) is another story, I'll write a new p=
atch after unmap_queue reset mode becomes functional.

I have another patch which adds poison mode flag in amdgpu_ras, page retire=
ment will be skipped in DF irq handler if poison mode is ture. The patch wi=
ll be sent out after RAS TA supports query of poison status.

Regards,
Tao
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, August 24, 2021 5:10 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Yang, Stanl=
ey <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com>; Kuehling=
, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sd=
ma interrupt

[AMD Official Use Only]

How about we add a new member in ras context (amdgpu_ras) to indicate the p=
oison consumption handling mode/approach? In such way, we can initialize th=
at member per ASIC.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Tuesday, August 24, 2021 17:04
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang, St=
anley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com>; Kuehl=
ing, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sd=
ma interrupt

[AMD Official Use Only]

Hi Tao,

This will break mode 2 reset solution, right? But we have to keep mode 2 re=
set solution as the default one for now. I think we need a new interface to=
 allow KFD switch between unmap_queue and mode 2 reset solution

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, August 24, 2021 16:43
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma i=
nterrupt

In ras poison mode, page retirement will be handled by the irq handler of t=
he module which consumes corrupted data.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c     | 10 ++++++++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 46cd4ee6bafb..eb5e9c1b1073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,16 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+
+int kgd_aldebaran_ras_process_cb(struct kgd_dev *kgd) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+
+       return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL); }

 const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
         .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
@@ -44,5 +54,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
         .get_atc_vmid_pasid_mapping_info =3D
                                 kgd_gfx_v9_get_atc_vmid_pasid_mapping_info=
,
         .set_vm_context_page_table_base =3D kgd_gfx_v9_set_vm_context_page=
_table_base,
-       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handler_=
settings
+       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handler_=
settings,
+       .ras_process_cb =3D kgd_aldebaran_ras_process_cb
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..851b5120927a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                                 if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TY=
PE_ILLEGAL_INST &&
                                         sq_intr_err !=3D SQ_INTERRUPT_ERRO=
R_TYPE_MEMVIOL) {
                                         kfd_signal_poison_consumed_event(d=
ev, pasid);
-                                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                                       if (dev->kfd2kgd->ras_process_cb)
+                                               dev->kfd2kgd->ras_process_c=
b(dev->kgd);
+                                       else
+                                               amdgpu_amdkfd_gpu_reset(dev=
->kgd);
                                         return;
                                 }
                                 break;
@@ -253,7 +256,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                         kfd_signal_event_interrupt(pasid, context_id0 & 0x=
fffffff, 28);
                 } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
                         kfd_signal_poison_consumed_event(dev, pasid);
-                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                       if (dev->kfd2kgd->ras_process_cb)
+                               dev->kfd2kgd->ras_process_cb(dev->kgd);
+                       else
+                               amdgpu_amdkfd_gpu_reset(dev->kgd);
                         return;
                 }
         } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC || diff --git a/=
drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/inclu=
de/kgd_kfd_interface.h
index c84bd7b2cf59..9e6525871ad4 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -301,6 +301,7 @@ struct kfd2kgd_calls {
                         int *max_waves_per_cu);
         void (*program_trap_handler_settings)(struct kgd_dev *kgd,
                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_add=
r);
+       int (*ras_process_cb)(struct kgd_dev *kgd);
 };

 #endif  /* KGD_KFD_INTERFACE_H_INCLUDED */
--
2.17.1

--_000_DM6PR12MB46501F31458824AF3BA8E755B0C59DM6PR12MB4650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Hawking,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
GPU reset will also be called in&nbsp;<span style=3D"color:rgb(32, 31, 30);=
font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,=
 &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255,=
 255, 255);display:inline !important">dev-&gt;kfd2kgd-&gt;ras_process_cb,
 this patch is to add page retirement handling before gpu reset.</span></di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
unmap_queue
 mode (reset or preemption) is another story, I'll write a new patch after =
unmap_queue reset mode becomes functional.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
I
 have another patch which adds poison mode flag in amdgpu_ras, page retirem=
ent will be skipped in DF irq handler if poison mode is ture. The patch wil=
l be sent out after RAS TA supports query of poison status.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
Regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
Tao</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 24, 2021 5:10 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedes=
ktop.org&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Clements, John &l=
t;John.Clements@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;=
<br>
<b>Subject:</b> RE: [PATCH] amd/amdkfd: add ras page retirement handling fo=
r sq/sdma interrupt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
How about we add a new member in ras context (amdgpu_ras) to indicate the p=
oison consumption handling mode/approach? In such way, we can initialize th=
at member per ASIC.<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Zh=
ang, Hawking<br>
Sent: Tuesday, August 24, 2021 17:04<br>
To: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.org; Ya=
ng, Stanley &lt;Stanley.Yang@amd.com&gt;; Clements, John &lt;John.Clements@=
amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sd=
ma interrupt<br>
<br>
[AMD Official Use Only]<br>
<br>
Hi Tao,<br>
<br>
This will break mode 2 reset solution, right? But we have to keep mode 2 re=
set solution as the default one for now. I think we need a new interface to=
 allow KFD switch between unmap_queue and mode 2 reset solution<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <br>
Sent: Tuesday, August 24, 2021 16:43<br>
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Clements, John &lt;John.C=
lements@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma i=
nterrupt<br>
<br>
In ras poison mode, page retirement will be handled by the irq handler of t=
he module which consumes corrupted data.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c&nbsp;&nbsp;&nbsp; | =
13 ++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp;&nbsp;&nbs=
p; | 10 ++++++++--<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 1 +<br>
&nbsp;3 files changed, 21 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
index 46cd4ee6bafb..eb5e9c1b1073 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
@@ -23,6 +23,16 @@<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd_arcturus.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd_gfx_v9.h&quot;<br>
+#include &quot;amdgpu_ras.h&quot;<br>
+#include &quot;amdgpu_umc.h&quot;<br>
+<br>
+int kgd_aldebaran_ras_process_cb(struct kgd_dev *kgd) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_data =3D {0, =
0, 0, NULL};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_umc_process_ras_data_cb=
(adev, &amp;err_data, NULL); }<br>
&nbsp;<br>
&nbsp;const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =
=3D kgd_gfx_v9_program_sh_mem_settings,<br>
@@ -44,5 +54,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_get_atc_vmid_pasid_ma=
pping_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D kgd_gfx_v9_set_vm_context_page_table_base,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_trap_handler_settings =3D kg=
d_gfx_v9_program_trap_handler_settings<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_trap_handler_settings =3D kg=
d_gfx_v9_program_trap_handler_settings,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_process_cb =3D kgd_aldebaran_ras=
_process_cb<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c<br>
index 12d91e53556c..851b5120927a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
@@ -231,7 +231,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sq_intr_err !=3D SQ_INTERRUP=
T_ERROR_TYPE_ILLEGAL_INST &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfd_signal_poison_consumed_event(dev, pasid);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_amdkfd_gpu_reset(dev-&gt;kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (dev-&gt;kfd2kgd-&gt;ras_process_cb)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;kfd2kgd-&gt;ra=
s_process_cb(dev-&gt;kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpu_rese=
t(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -253,7 +256,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_s=
ignal_event_interrupt(pasid, context_id0 &amp; 0xfffffff, 28);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_s=
ignal_poison_consumed_event(dev, pasid);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gp=
u_reset(dev-&gt;kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd2=
kgd-&gt;ras_process_cb)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;kfd2kgd-&gt;ras_process_cb(dev-&gt;=
kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpu_reset(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (client_id =3D=
=3D SOC15_IH_CLIENTID_VMC || diff --git a/drivers/gpu/drm/amd/include/kgd_k=
fd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
index c84bd7b2cf59..9e6525871ad4 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -301,6 +301,7 @@ struct kfd2kgd_calls {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *=
max_waves_per_cu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*program_trap_handle=
r_settings)(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t vmid, uint64_t tba_addr, uint64_t tma_addr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ras_process_cb)(struct kgd_dev =
*kgd);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif&nbsp; /* KGD_KFD_INTERFACE_H_INCLUDED */<br>
--<br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46501F31458824AF3BA8E755B0C59DM6PR12MB4650namp_--
