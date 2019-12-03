Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256BC432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 15:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D086206EC
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 15:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D086206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F2B6E835;
	Tue,  3 Dec 2019 15:09:09 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800048.outbound.protection.outlook.com [40.107.80.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBDD6E835
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 15:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT7x9XK0FyfBtaA2PSdw20jo4FaC/VCVwS92dydKFJYJaZrYZIVZSQAAJFbiHRsjD4SEewUvRxKgBSwXDA8hxM3PonjxVYMuHravxtFvlhoI32IonmhqyRaACnfQrwXLAJLfry8nQC5K7uJfushXNYQYUA6uCOSGj++Wz+7vpD4n0udATrWMYeM+GFZWnCuQB+rnGgvRxJEl2ltcsvWCE6CTKnbAnsxGNT8hWkQ9B8n6FGHZLY/QgK5hnNJsnyBwyy3sC0NJ4zZo9i1KJ54uXhT6Ibsw70kp7eOAxc+5W3sxOL9fZpw+kZGEpxDf/60iVAqM1tEV1C85KQdQF8ufiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/BOZ7u0RbBAO4NKrU0yEaik4yHq4ByCfZEJ3xJMbqA=;
 b=dGDIawqo6XMPNvT5ER8zlYsHnS042UBuGRWd4DLS+0wxbdTlnyGejbGqp9Omf5Igk7UYsCe6/bWwQjZ50ukfXHz9PohNQJizs7QhYhTqXYrXK4Q1lvO+hDe/THdVBYMT4IZ8saPKlYBU6BbR06S4EPAzUzGuj6iYM+jYZ03ZEZa+ZvwZoaRDp/jhw14MVL55jktDxMoucQgpB1Ny+i2dr33syw+jDHcFCURIhMe2Z96+yN3PTGuEqv0spozKdvaMrzyfl3xeQeZZGD6vwIHvkz025EV60CN8IKWoipg5cJK5IG6qMPKZ1ub2lnFnSnrPyNpRTst7P5nA/ip7lXY49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1951.namprd12.prod.outlook.com (10.175.55.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 15:09:06 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 15:09:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Contain MMHUB number in
 mmhub_v9_4_setup_vm_pt_regs()
Thread-Topic: [PATCH] drm/amdkfd: Contain MMHUB number in
 mmhub_v9_4_setup_vm_pt_regs()
Thread-Index: AQHVqerHioen5ZEgZE+XYzyxTxoixaeog1Au
Date: Tue, 3 Dec 2019 15:09:06 +0000
Message-ID: <MWHPR12MB1358A8CAFE1A7FA4DA43FD70F7420@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191203150233.10228-1-Yong.Zhao@amd.com>
In-Reply-To: <20191203150233.10228-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-03T15:09:05.928Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95bed184-814e-419c-b912-08d77802bde6
x-ms-traffictypediagnostic: MWHPR12MB1951:|MWHPR12MB1951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB195189FAE8CA60B344C7F4B2F7420@MWHPR12MB1951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(66446008)(86362001)(6116002)(66476007)(76116006)(66556008)(2501003)(66946007)(64756008)(52536014)(3846002)(74316002)(316002)(256004)(966005)(99286004)(14444005)(19627405001)(606006)(110136005)(229853002)(14454004)(8936002)(6246003)(71190400001)(186003)(81156014)(26005)(81166006)(25786009)(7696005)(2906002)(102836004)(6506007)(76176011)(11346002)(105004)(45080400002)(478600001)(6436002)(7736002)(55016002)(5660300002)(446003)(54896002)(71200400001)(33656002)(8676002)(53546011)(6306002)(236005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1951;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WhsUBNUwH7RK6vrfQKX2Zp9smNPLalX+wFw/1TJ1HTjWvweNPn39hdZSGEa1R5UUd0TIMSAemIdcS/kftPsA3iLbRY9BEBaJ+pOi33GMUU0MvGX9nQqqAmSpIsO7ZnBoCdvH4MTcwX+UtNReQuFXHaaf8l9/ghgDEEkr01ZoK2rLJjXr9xwxMzcDkBP6BYuP3Am/w29XHmPNo0OlAVgxtUeKtg6HQ9atsFHi5sm9iZrxGBbxXaA1/3nALcOv1srRYq8FH1MAu4vptw8F1eWt7QbuexWpeVklBnMaaDIrqpEKS09JraEyo1K3dcXEFWq0JnhDSPXXSn9MU65kQ3SRm/YogG+aemVW9SKIlXTIR13Mh/RHMJ3J3jx+I6KmU2a1cgmBhiPlpKzY1nKCBQPpZ4cemq/jCJxdYalO0nCMJueH65CkPZnpgNaDQkeD7TUhxBSiqNaNyXdArKd1+gk8d9VY5VM7yRkmN2/uJvL+nQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bed184-814e-419c-b912-08d77802bde6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 15:09:06.5577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6nREA98KmM3KpofBj9BRlNFR0Yu7okY3c61clwZXrpqZpW13Z28HlquXRT/uIJjcFLNT3+UCaheEoIlidn/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/BOZ7u0RbBAO4NKrU0yEaik4yHq4ByCfZEJ3xJMbqA=;
 b=A/YU4FmL4Mm4WeE4VNUZWPx040fRNim3O/hytkQfU2aPO4e8k8BysaiXBH5n3+mnsIxnKocuLGiW2PMkSvczXbY1/v3dzUa/ZGgkKECBm5XdtkqgY6c47ZB7LADnTzH+qxYWbHJRKHxGWC9JqAfnyWieU9keoE+JPWb2rT0KgZc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1557188595=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1557188595==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1358A8CAFE1A7FA4DA43FD70F7420MWHPR12MB1358namp_"

--_000_MWHPR12MB1358A8CAFE1A7FA4DA43FD70F7420MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Tuesday, December 3, 2019 10:02 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: Contain MMHUB number in mmhub_v9_4_setup_vm_pt=
_regs()

Adjust the exposed function prototype so that the caller does not need
to know the MMHUB number.

Change-Id: I4420d1715984f703954f074682b075fc59e2a330
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h             |  8 --------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c           | 14 ++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h           |  2 ++
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 47c853ef1051..6f1a4676ddde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -40,7 +40,7 @@
 #include "soc15d.h"
 #include "mmhub_v1_0.h"
 #include "gfxhub_v1_0.h"
-#include "gmc_v9_0.h"
+#include "mmhub_v9_4.h"


 enum hqd_dequeue_request_type {
@@ -774,9 +774,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct k=
gd_dev *kgd, uint32_t vmi
          * on GFX8 and older.
          */
         if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
-               /* Two MMHUBs */
-               mmhub_v9_4_setup_vm_pt_regs(adev, 0, vmid, page_table_base)=
;
-               mmhub_v9_4_setup_vm_pt_regs(adev, 1, vmid, page_table_base)=
;
+               mmhub_v9_4_setup_vm_pt_regs(adev, vmid, page_table_base);
         } else
                 mmhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.h
index 971c0840358f..49e8be761214 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
@@ -36,12 +36,4 @@

 extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;
 extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;
-
-/* amdgpu_amdkfd*.c */
-void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,
-                               uint64_t value);
-void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,
-                               uint64_t value);
-void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, int hubid,
-                               uint32_t vmid, uint64_t value);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c
index 8599bfdb9a9e..d9301e80522a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -54,7 +54,7 @@ u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev=
)
         return base;
 }

-void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, int hubid,
+static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *adev, =
int hubid,
                                 uint32_t vmid, uint64_t value)
 {
         /* two registers distance between mmVML2VC0_VM_CONTEXT0_* to
@@ -80,7 +80,7 @@ static void mmhub_v9_4_init_gart_aperture_regs(struct amd=
gpu_device *adev,
 {
         uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);

-       mmhub_v9_4_setup_vm_pt_regs(adev, hubid, 0, pt_base);
+       mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);

         WREG32_SOC15_OFFSET(MMHUB, 0,
                             mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO=
32,
@@ -101,6 +101,16 @@ static void mmhub_v9_4_init_gart_aperture_regs(struct =
amdgpu_device *adev,
                             (u32)(adev->gmc.gart_end >> 44));
 }

+void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,
+                               uint64_t page_table_base)
+{
+       int i;
+
+       for (i =3D 0; i < MMHUB_NUM_INSTANCES; i++)
+               mmhub_v9_4_setup_hubid_vm_pt_regs(adev, i, vmid,
+                               page_table_base);
+}
+
 static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *ade=
v,
                                                  int hubid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.h
index 354a4b7e875b..1b979773776c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
@@ -34,5 +34,7 @@ void mmhub_v9_4_init(struct amdgpu_device *adev);
 int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
                                enum amd_clockgating_state state);
 void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,
+                               uint64_t page_table_base);

 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9608263c072740ab896f08d77801dda7%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637109821901425333&amp;sdata=3DrGrPTRkX%2BPpKangWP=
jP9b3ku11Wn9Ehf8ugGzlt0vN4%3D&amp;reserved=3D0

--_000_MWHPR12MB1358A8CAFE1A7FA4DA43FD70F7420MWHPR12MB1358namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, December 3, 2019 10:02 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Contain MMHUB number in mmhub_v9_4_setu=
p_vm_pt_regs()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Adjust the exposed function prototype so that the =
caller does not need<br>
to know the MMHUB number.<br>
<br>
Change-Id: I4420d1715984f703954f074682b075fc59e2a330<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp; 6 &#43;&#43=
;----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 --------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;&#43;<br>
&nbsp;4 files changed, 16 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 47c853ef1051..6f1a4676ddde 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -40,7 &#43;40,7 @@<br>
&nbsp;#include &quot;soc15d.h&quot;<br>
&nbsp;#include &quot;mmhub_v1_0.h&quot;<br>
&nbsp;#include &quot;gfxhub_v1_0.h&quot;<br>
-#include &quot;gmc_v9_0.h&quot;<br>
&#43;#include &quot;mmhub_v9_4.h&quot;<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;enum hqd_dequeue_request_type {<br>
@@ -774,9 &#43;774,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(stru=
ct kgd_dev *kgd, uint32_t vmi<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on GFX8 and older.=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_ARCTURUS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Two MMHUBs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mmhub_v9_4_setup_vm_pt_regs(adev, 0, vmid, page_table_base);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mmhub_v9_4_setup_vm_pt_regs(adev, 1, vmid, page_table_base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mmhub_v9_4_setup_vm_pt_regs(adev, vmid, page_table_base);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_ba=
se);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.h<br>
index 971c0840358f..49e8be761214 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h<br>
@@ -36,12 &#43;36,4 @@<br>
&nbsp;<br>
&nbsp;extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;<br>
&nbsp;extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;<br>
-<br>
-/* amdgpu_amdkfd*.c */<br>
-void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi=
d,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value);<br>
-void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value);<br>
-void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, int hubid,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint64_t value);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c<br>
index 8599bfdb9a9e..d9301e80522a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
@@ -54,7 &#43;54,7 @@ u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&nbsp;}<br>
&nbsp;<br>
-void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, int hubid,<br=
>
&#43;static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *ad=
ev, int hubid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint64_t value)<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* two registers distance =
between mmVML2VC0_VM_CONTEXT0_* to<br>
@@ -80,7 &#43;80,7 @@ static void mmhub_v9_4_init_gart_aperture_regs(struct=
 amdgpu_device *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgp=
u_gmc_pd_addr(adev-&gt;gart.bo);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_vm_pt_regs(adev, hub=
id, 0, pt_base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_hubid_vm_pt_regs=
(adev, hubid, 0, pt_base);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB,=
 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
@@ -101,6 &#43;101,16 @@ static void mmhub_v9_4_init_gart_aperture_regs(str=
uct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));<br>
&nbsp;}<br>
&nbsp;<br>
&#43;void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t =
vmid,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MMHUB_NUM_IN=
STANCES; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mmhub_v9_4_setup_hubid_vm_pt_regs(adev, i, vmid,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_table_base);<br>
&#43;}<br>
&#43;<br>
&nbsp;static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int h=
ubid)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.h<br>
index 354a4b7e875b..1b979773776c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h<br>
@@ -34,5 &#43;34,7 @@ void mmhub_v9_4_init(struct amdgpu_device *adev);<br>
&nbsp;int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state);<br>
&nbsp;void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flag=
s);<br>
&#43;void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t =
vmid,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base);<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C9608263c072740ab896f08d77801dda7%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109821901425333&amp;amp;sdata=3D=
rGrPTRkX%2BPpKangWPjP9b3ku11Wn9Ehf8ugGzlt0vN4%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9608263c072740ab896f08d77801dda7%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637109821901425333&amp;amp;sdata=3DrGrPTRkX%2BPpKa=
ngWPjP9b3ku11Wn9Ehf8ugGzlt0vN4%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1358A8CAFE1A7FA4DA43FD70F7420MWHPR12MB1358namp_--

--===============1557188595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1557188595==--
