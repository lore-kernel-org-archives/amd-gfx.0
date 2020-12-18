Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5A9C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 05:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD82222D01
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 05:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD82222D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CB289A0F;
	Fri, 18 Dec 2020 05:46:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90354899D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 05:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE0fBIkknl6xoVtNi/X4lEYtYTHKWPi/YZ4t1qgrmx2pHpsxH+kDMT6V4EcE7PkpD/cUfUuL6Uc4GbxIvGX+CrHQsWxQFAo0/s9eGwjNIxvuiSZX42cxwIUj4Pdx3kNqKhY1B3L25JhvMBm/tuJ/BRowOuRw9HL28F11veQz5tivD6OEK4Fr9pF1cXrABuj4jLBiffZY0r1AfSPKwZtDLfQDmfVW/4R/8Im7yQucG8kDlknilbP1/8Qt3uzLKhpGOfVwwFgWgbHqFfSiA6v0R6Dl9JrAhWVuKemZ4Ms2tYgcpPIRKjNF+1dYkTaRs7fBlnzaw/F59Y7i1SVOb6QovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABttEQRyAuFvYxtL9YHa60ftV9qRSx+7F5M3D4Ueg9s=;
 b=ZJ6p7u5HOV0GJxDXGEYVhgnJpcUQiL0eh1tyLbVQzqZlQFD+cwhXsFjfw2Ju4nKKG7G0WUMbNbBAA0GivDBoK61AUpEP9kS8U0xq2jyhEC6ChnQkpt7VIT/Ma5SjxOMmojE/MtVheO5jiKpvKOdJ0+DGBN3x4Vz1hdotdKqUt087Xje997TShqGWIXBW/J33Q4QauPLBgfkIOE35ErSv5vIemeaHs6/WFm8QLwIgOEsWY2bejWCh22OLDn4mluHeUa6RAs8tT4lOeOeDj9AN2jkJWVqsNUeNUpks82F6qpcXbpHmGaUvyLJ6a06o8156ESTGAcD28ICyXiZL711+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABttEQRyAuFvYxtL9YHa60ftV9qRSx+7F5M3D4Ueg9s=;
 b=zBYrMpULADJ5u6I3pGh0CiAmk7zD8VMgBhH3eKRasPitanDvCC/vsA0Yrh5R0wXAz3trgkrATlkofkSnE2oGXVV7dvCtsEq7aTQaMDe2NKTTo1+93N3uBGijmF8IYfvV9pASUojU+PP5z02RwE8bYOSbmmqNvsUpfbsFw2t14KU=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3013.namprd12.prod.outlook.com (2603:10b6:a03:a9::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 05:46:40 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49%7]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 05:46:40 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Topic: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Index: AQHW1JV/+p+zXRLLUkqLsWT8XQKmyan7hDGAgAAHzwCAAAKsgIAAydMA
Date: Fri, 18 Dec 2020 05:46:40 +0000
Message-ID: <BYAPR12MB36409B2596B0B06E0239D4038EC30@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>,
 <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>,
 <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <MW3PR12MB4554D9CAF479797E24D4108EF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
 <MW3PR12MB45540F913662D5CE5ABFC87BF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB45540F913662D5CE5ABFC87BF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-17T17:41:59.762Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD Public;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-18T05:46:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d6d92953-1c28-4ccc-a5ce-0000dddd5f3b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5fd9d88-52ed-46bb-cc82-08d8a3184adb
x-ms-traffictypediagnostic: BYAPR12MB3013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30130457D94B100716A7119B8EC30@BYAPR12MB3013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sdnga63vkb/yue/IBbcLGYX31Pt+vyS1P1OhIuM7fcadpwlf5WmkKHZGaBzP6YVItrRSnLvMZ7As2QuPyZTma3fy49o7CeIHNO1iqzazQLbC6qPBAqRnCblnL7dS4Nf8+yDayW1oGmo0VABIRd/dNVxkTu9/stXPWqfCOWXlR4tge5RjJKX5O4vCsfR4png84SzbHXCpTuljdvKfGzzTWPqeb82Ou59Rn9+Zq7liOo2DFnOt7++O0sh+xQNqkopgMDTvKyWM49KtrFei6K6f/zGmVux3zfy6Qm3H+x+9ZDMf9F7P4pxvR4qIlCvdpzFr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(53546011)(316002)(86362001)(110136005)(71200400001)(66946007)(478600001)(64756008)(26005)(55016002)(52536014)(5660300002)(8676002)(6636002)(7696005)(66446008)(186003)(8936002)(6506007)(66556008)(66476007)(2906002)(33656002)(76116006)(83380400001)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bq8+5geEVITuHs1FcHSBDZfjcx48R7ptdRNl6iPAOQ0YA8inHfhx0FoefGoi?=
 =?us-ascii?Q?CzGxwbwbQdQ95QEsQ+VZNt9YX2I9ZcLNHur4NSTGkS2RluO2ZBDkd2lCuw6M?=
 =?us-ascii?Q?fdsQ1v8Z4bwmE1m+DjrNZPLQxBgYwYh5bMFMV+MCENE5rv/js/7YcivPEvLO?=
 =?us-ascii?Q?dNcx8SRFgUF2OwpF/BNeACEUCHdYs+ZmTPBGjyX4xXyPtp/cZUDBhGBWBoT4?=
 =?us-ascii?Q?wtSkJ9E1m3bvd0NEGwdY8CtV1gtUh4ljWfM27Kg/m2yueX3QpoKVQATB8XNK?=
 =?us-ascii?Q?5lKfJPZDk0nCWSiO/x5zZiQSMg9DUdu+ntirIT14Pfb2vw6RBSadH7oMvcWW?=
 =?us-ascii?Q?0pzL5pHKCaKo9V9orBuVkh+mQS+v+39bSM4awpuKDhw/3yWc3zCud3o+q9gQ?=
 =?us-ascii?Q?zQzE6ziIEkMkvHRoPFmoiie+RB5XFrl6jrR1qzV8fA4360q04Go8xp9rAhcG?=
 =?us-ascii?Q?rMOLowlTbl3wAFa+6wjHTAdl3fdujYEtPFT+VleD358mGGBAEIei/1V2Et5Q?=
 =?us-ascii?Q?jBbMEq6Jt2DgzELu5P5f3JRR+PTF5gEgU3nXSYUVZjCNAEhVMDDyUx4EWEWi?=
 =?us-ascii?Q?JKff4XGKmbLmMOoMuvFFWQdUdaGYUkTm7gSBshIIbToFQqJ6fYJx22x0+XNW?=
 =?us-ascii?Q?Zytaw0sDm1xIrdo5i/pArznFIFDuv12kKSUZ4ceTIV+AT6Y7whXz4Lu08pHh?=
 =?us-ascii?Q?AmcmbJq+C1DMSBxFU7Rab2Ej6EtwfE61wcWS2bwCcLh52STzr1zED5qwIAyk?=
 =?us-ascii?Q?1dHFqlXLaxVbsoxoNMekMinlrOod9MddE5Pnl+WeTKm4CX35SA7n8/3aWn0l?=
 =?us-ascii?Q?m71c8d6WcY5uyP3aT7917cmOFuprW5L+TdwSs9/COFuOx3UewIV6V9DcnWt/?=
 =?us-ascii?Q?fe5wG7c16c74KlHjhwt9qz6GOuIGk/QyqXzys4xVQv3aD3pW3k1gSXhB1EdM?=
 =?us-ascii?Q?s9Bl9RK8Fb3twzJC3JJ2hNOAvbm6xzyR+qZVBsshyKM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fd9d88-52ed-46bb-cc82-08d8a3184adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 05:46:40.2706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKjD7WHxsswdcj/kIzdj+MFzCU5vh+eCkatWOHFVA+7NxT2Yz84gsheVkhmUiH3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3013
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0358692519=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0358692519==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB36409B2596B0B06E0239D4038EC30BYAPR12MB3640namp_"

--_000_BYAPR12MB36409B2596B0B06E0239D4038EC30BYAPR12MB3640namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

Hi Bhawanpreet,
With the two patches, I still can't see that dc_allow_idle_optimizations(st=
ruct dc *dc, bool allow) is called with allow =3D true after modprobe and s=
tartx.
Is there anything else missing?

Best Regards
Kenneth

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lakha, B=
hawanpreet
Sent: Friday, December 18, 2020 1:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)


[AMD Public Use]

[CAUTION: External Email]

[AMD Public Use]

Actually, I will drop the guards and if we see issues related to this, we c=
an block it.

Bhawan
________________________________
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakh=
a@amd.com>>
Sent: December 17, 2020 12:32 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nichola=
s.Kazlauskas@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)

I would but MALL is not fully validated so it might cause underflow issues =
if we keep it enabled by default. I can create a feature flag mask if that =
helps?

Bhawan
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: December 17, 2020 12:04 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@=
amd.com>>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nichola=
s.Kazlauskas@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)


[AMD Public Use]

Can we drop the Kconfig?  With that, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha=
@amd.com>>
Sent: Thursday, December 17, 2020 11:54 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.Kazla=
uskas@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexa=
nder.Deucher@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Lakha, =
Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>; =
Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.Kazlauska=
s@amd.com>>
Subject: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux (=
MALL stutter)

[Why]
We can only use this feature when the display is idle. When active vblank
irq count is 0 we know all the displays are idle.

[How]
-Add a active vblank irq counter
-Update the counter when we enable/disable vblank irq
-if vblank irq count is 0 we can consider mall stutter

Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpr=
eet.Lakha@amd.com>>
Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
Reviewed-by: Nick Kazlauskas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.K=
azlauskas@amd.com>>
---
 drivers/gpu/drm/amd/display/Kconfig           |  6 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig
index 797b5d4b43e5..2444e664c7ee 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP
         help
           Choose this option if you want to support HDCP authentication.

+config DRM_AMD_DC_MALL
+       bool "Enable MALL support"
+       depends on DRM_AMD_DC
+       help
+         Choose this option if you want to support MALL
+
 config DRM_AMD_DC_SI
         bool "AMD DC support for Southern Islands ASICs"
         default n
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a78ec16418b3..080f2a52cfed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)
         struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
         struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
         struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crtc->state=
);
+       struct amdgpu_display_manager *dm =3D &adev->dm;
         int rc =3D 0;

         if (enable) {
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)
                 return rc;

         irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+       if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+               return -EBUSY;
+
+       mutex_lock(&dm->dc_lock);
+
+       if (enable)
+               dm->active_vblank_irq_count++;
+       else
+               dm->active_vblank_irq_count--;
+
+       dc_allow_idle_optimizations(
+               adev->dm.dc, dm->active_vblank_irq_count =3D=3D 0 ? true : =
false);
+
+       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->activ=
e_vblank_irq_count =3D=3D 0);
+       mutex_unlock(&dm->dc_lock);
+
+       return 0;
+#else
         return dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EB=
USY;
+#endif
 }

 static int dm_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 251af783f6b1..cab44bbd2e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {
          */
         const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;

+#if defined(CONFIG_DRM_AMD_DC_MALL)
+       /**
+        * @active_vblank_irq_count
+        *
+        * number of currently active vblank irqs
+        */
+       uint32_t active_vblank_irq_count;
+#endif
+
 #ifdef CONFIG_DEBUG_FS
         /* set the crc calculation window*/
         struct drm_property *crc_win_x_start_property;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 33642566bcb2..9d245033eb3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -504,6 +504,9 @@ struct dc_debug_options {
         bool dmcub_emulation;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
         bool disable_idle_power_optimizations;
+#endif
+#ifdef CONFIG_DRM_AMD_DC_MALL
+       unsigned int mall_size_override;
 #endif
         bool dmub_command_table; /* for testing only */
         struct dc_bw_validation_profile bw_val_profile;
--
2.25.1

--_000_BYAPR12MB36409B2596B0B06E0239D4038EC30BYAPR12MB3640namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Hi Bhawanpreet,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">With the two patche=
s, I still can&#8217;t see that dc_allow_idle_optimizations(struct dc *dc, =
bool allow) is called with allow =3D true after modprobe and startx.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Is there anything e=
lse missing?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Best Regards<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Kenneth<o:p></o:p><=
/span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Lakha, Bhawanpreet<br>
<b>Sent:</b> Friday, December 18, 2020 1:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">[CAUTION: External Email] <o:p></o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Actuall=
y, I will drop the guards and if we see issues related to this, we can bloc=
k it.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Bhawan<=
o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpree=
t.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Sent:</b> December 17, 2020 12:32 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Kazlauskas, Nicholas &lt;<a href=3D"=
mailto:Nicholas.Kazlauskas@amd.com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I would=
 but MALL is not fully validated so it might cause underflow issues if we k=
eep it enabled by default. I can create a feature flag mask if that helps?<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Bhawan<=
o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> December 17, 2020 12:04 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.c=
om">Bhawanpreet.Lakha@amd.com</a>&gt;; Kazlauskas, Nicholas &lt;<a href=3D"=
mailto:Nicholas.Kazlauskas@amd.com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Can we =
drop the Kconfig?&nbsp; With that, the series is:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet=
.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, December 17, 2020 11:54 AM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@a=
md.com">Nicholas.Kazlauskas@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=
=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Lakha, Bhawanpreet &lt;<a href=3D"mailt=
o:Bhawanpreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;;
 Kazlauskas, Nicholas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.com">Ni=
cholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: enable idle optimizations for =
linux (MALL stutter)</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[Why]<br>
We can only use this feature when the display is idle. When active vblank<b=
r>
irq count is 0 we know all the displays are idle.<br>
<br>
[How]<br>
-Add a active vblank irq counter<br>
-Update the counter when we enable/disable vblank irq<br>
-if vblank irq count is 0 we can consider mall stutter<br>
<br>
Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584<br>
Signed-off-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@am=
d.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">ale=
xander.deucher@amd.com</a>&gt;<br>
Reviewed-by: Nick Kazlauskas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.=
com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++++<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++++=
+<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 9 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;4 files changed, 40 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig<br>
index 797b5d4b43e5..2444e664c7ee 100644<br>
--- a/drivers/gpu/drm/amd/display/Kconfig<br>
+++ b/drivers/gpu/drm/amd/display/Kconfig<br>
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this op=
tion if you want to support HDCP authentication.<br>
&nbsp;<br>
+config DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable MALL support&quot;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this option if you=
 want to support MALL<br>
+<br>
&nbsp;config DRM_AMD_DC_SI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;AMD DC support =
for Southern Islands ASICs&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a78ec16418b3..080f2a52cfed 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =
=3D to_amdgpu_crtc(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(crtc-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *acrt=
c_state =3D to_dm_crtc_state(crtc-&gt;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_display_manager *dm =3D=
 &amp;adev-&gt;dm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return rc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_source =3D IRQ_TYPE_VB=
LANK + acrtc-&gt;otg_inst;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev-&gt;dm.dc,=
 irq_source, enable))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EBUSY;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count--;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_allow_idle_optimizations(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;dm.dc, dm-&gt;active_vblank_irq_count =3D=3D 0 ? true :=
 false);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Allow idle opt=
imizations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=3D 0);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;dc_lock);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dc_interrupt_set(ad=
ev-&gt;dm.dc, irq_source, enable) ? 0 : -EBUSY;<br>
+#endif<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int dm_enable_vblank(struct drm_crtc *crtc)<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 251af783f6b1..cab44bbd2e35 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gpu_info_soc_=
bounding_box_v1_0 *soc_bounding_box;<br>
&nbsp;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @active_vblank_irq_count<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * number of currently active vb=
lank irqs<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_vblank_irq_count;<br>
+#endif<br>
+<br>
&nbsp;#ifdef CONFIG_DEBUG_FS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the crc calculation=
 window*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *crc_w=
in_x_start_property;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 33642566bcb2..9d245033eb3d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -504,6 +504,9 @@ struct dc_debug_options {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmcub_emulation;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_idle_power_op=
timizations;<br>
+#endif<br>
+#ifdef CONFIG_DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int mall_size_override;<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmub_command_table; /=
* for testing only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bw_validation_pr=
ofile bw_val_profile;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB36409B2596B0B06E0239D4038EC30BYAPR12MB3640namp_--

--===============0358692519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0358692519==--
