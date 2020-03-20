Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D56C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2C32072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ti804nQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2C32072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDE289CD9;
	Fri, 20 Mar 2020 14:06:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CBB89CD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDCfT0mzK4+phQ8FXZ0/ErNH31pkcO1KF7kVrvJ1oXdlNj1bFQ69+RtVIMTQV4dBiOPURv+F+1DiY8bZ4ieOyGVKraGsT4/le/Wpn9MAHSeSjmXV3/Dde8qx0EWb8VZaCT347DaIESclmd+m92tMa5bL6873F9CPSv79qLKTWz+G4P+1LzFSToOeOfugkRkCeNAdIU4GTFsiHEm5KDOx3lg2gjCHYl/DjRPZwiOb58CHViWiVurWDUOsBwfDcWiJ+eF94bSeU6fKPpu9Q672kzH/h9zp9ILc5IIzb+eDSbHxePzsUJThyGvFUdBzgmOh44KmYT3Lq9vmXGjG1PcqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWTJfsddPC5AeSnAGpiGm8dlbqvoqO2jv62+UyKvmE0=;
 b=UsrU/SsyJZlsRJ0bopi177mE5eP1Uae6mT+D060Vph5lR8SeGP2WChPPEbxjUPIuuD1qmgaQXnZ2NFAtExH6stZyNXzRDFxbIKjN1WrNTk0mFbi0fw1hRTu0Kvy1PmyqypdDmL4eTxp27b4DtejVrJF5hMJQNabp8V5DFGWygPI7e/KFB9Bri06X3aLwKDEAOlKMnbi5/nar0pBnArbiog1ekFCDjWbebKndrNH3cWunZ5xStCdW8OtmDkj4uu4v1ENEBbK+gadFfY2ZW+ITUkV9q9tK6X58+Du6efnDkYdOmYmF1GhwpOSfTDtY6RNpxXrlI3mSVb+IJDCKp64cLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWTJfsddPC5AeSnAGpiGm8dlbqvoqO2jv62+UyKvmE0=;
 b=ti804nQKloanYu2tjiaJUJhEVDTB1X02heZGvL+Dh5JOKik2WxbcdGjDke/LqGr6rlpsIcOSIuOxsMQQso4X2RhQJAFMkyjF6WAy8XwMel/IY3NjhUPAhQpEPyO+r+aM9xlTLC1Gwlqmg+47+cDdHSL2EhjXHg7bobHVZ5J5dRI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Fri, 20 Mar
 2020 14:06:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 14:06:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
Thread-Topic: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
Thread-Index: AQHV/k3z2pZ1DR+fSEu6Or1lSxdfvahRgtic
Date: Fri, 20 Mar 2020 14:06:30 +0000
Message-ID: <MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
In-Reply-To: <20200320002245.14932-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-20T14:06:29.984Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2447e2df-b44b-49d7-9e70-08d7ccd7e3b6
x-ms-traffictypediagnostic: MN2PR12MB4221:|MN2PR12MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42211AC6F418E0A57C0EF7A1F7F50@MN2PR12MB4221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(478600001)(8936002)(966005)(81156014)(110136005)(8676002)(86362001)(81166006)(9686003)(66476007)(2906002)(64756008)(45080400002)(66446008)(66556008)(52536014)(66946007)(55016002)(71200400001)(76116006)(5660300002)(316002)(19627405001)(186003)(53546011)(26005)(6506007)(7696005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CK826g3mwuz2+cjQqqDrGDKGGMTu3FDIl7tMR59qdVgOBLZOMMfeCycipUFnye93KFtlgX2E4DbfxukogIdxGs//g18u0GK30F9uzSb/MPFrYbAssH0WmfSKxJ8CKm3xzFQtubY1CyW5YfD+UjCGGR6X4ANAm95FpLoiIIWFztPt3maKL91VdleXDkILgRiQQEZDapxMlhk2PHA+t/AQpv227tJR04wFuqLHk9JFrBHM+aO3tuknaxOTgWxbgu0yIMr7CA6qBnRmGOhPoiGswFoXzkgP5CkuPKncDucVAN+bmWzFZ9pAPNVwOCCBbJpTecvLF9SWa2k3f2TerjP/4Cm7Doe62Mv5B0mAyYQNjRGFyT3JXMjQPRZiw8BzT+9DKC7kR4AFzVJUZc2pTLrZLFy7L9jILGkErYYRB8lddpFF5JGX4WSgrOSnRh4HGzpR39Yczp1Sdi+GG+HhAta2F19u0PNxUrdOUuK+hALC7VI=
x-ms-exchange-antispam-messagedata: xsC40LGvFokQFJLLDwDWQ/hDF8eiXYCXKodx29/6HF+kAstpkgOSgdjXemrB4CVUNPpXe+6mHUaWF+exkvlNEkB9opcbKfvUU7Az+ZhANJ5uziK5RuTxzLNUDEvIBS1AbnCxVSkj3bq1r7ESzgO5Fg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2447e2df-b44b-49d7-9e70-08d7ccd7e3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 14:06:30.4674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /04j0653vPfzn9EKv2l9DCNKd1Vn7BvLjpfVTQPzww9L2M7kzrewB05fDBvM7Lj6sNlAAzOEt5sStMLz7cJ/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Content-Type: multipart/mixed; boundary="===============0354589618=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0354589618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488EFB20868482AC55D3C14F7F50MN2PR12MB4488namp_"

--_000_MN2PR12MB4488EFB20868482AC55D3C14F7F50MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

This seems kind of complicated and error prone.  I didn't realize the exten=
t to the changes required.  I think it would be better to either add arctur=
us specific versions of these functions or just go with your original appro=
ach and add a new arcturus_ih.c.  If you go with the second route however, =
no need to show all your intermediate steps, just add the new files in one =
commit.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Sie=
rra <alex.sierra@amd.com>
Sent: Thursday, March 19, 2020 8:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets

Arcturus and vega10 share the same vega10_ih, however both
have different register offsets at the ih ring section.
This variable is used to help calculate ih ring register addresses
from the osssys, that corresponds to the current asic type.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c
index 5ed4227f304b..fa384ae9a9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -279,6 +279,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
                                 amdgpu_hotplug_work_func);
         }

+       if (adev->asic_type =3D=3D CHIP_ARCTURUS)
+               adev->irq.ring_stride =3D 1;
+       else
+               adev->irq.ring_stride =3D 0;
         INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
         INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.h
index c718e94a55c9..1ec5b735cd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -97,6 +97,7 @@ struct amdgpu_irq {
         struct irq_domain               *domain; /* GPU irq controller dom=
ain */
         unsigned                        virq[AMDGPU_MAX_IRQ_SRC_ID];
         uint32_t                        srbm_soft_reset;
+       unsigned                        ring_stride;
 };

 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637202606831789803&amp;sdata=3DB%2BbtLEKN5A65OEp8s=
e5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;reserved=3D0

--_000_MN2PR12MB4488EFB20868482AC55D3C14F7F50MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This seems kind of complicated and error prone.&nbsp; I didn't realize the =
extent to the changes required.&nbsp; I think it would be better to either =
add arcturus specific versions of these functions or just go with your orig=
inal approach and add a new arcturus_ih.c.&nbsp;
 If you go with the second route however, no need to show all your intermed=
iate steps, just add the new files in one commit.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp; <br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Sierra &lt;alex.sierra@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, March 19, 2020 8:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring of=
fsets</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Arcturus and vega10 share the same vega10_ih, howe=
ver both<br>
have different register offsets at the ih ring section.<br>
This variable is used to help calculate ih ring register addresses<br>
from the osssys, that corresponds to the current asic type.<br>
<br>
Signed-off-by: Alex Sierra &lt;alex.sierra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 &#43;<br>
&nbsp;2 files changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c<br>
index 5ed4227f304b..fa384ae9a9bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
@@ -279,6 &#43;279,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_hotplug_work_func);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_ARCTURUS)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;irq.ring_stride =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;irq.ring_stride =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;ir=
q.ih1_work, amdgpu_irq_handle_ih1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;ir=
q.ih2_work, amdgpu_irq_handle_ih2);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.h<br>
index c718e94a55c9..1ec5b735cd9e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
@@ -97,6 &#43;97,7 @@ struct amdgpu_irq {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_domain&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 *domain; /* GPU irq controller domain */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virq[AMDGPU_MAX_IRQ_SRC_ID];<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srbm_soft_reset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stride;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void amdgpu_irq_disable_all(struct amdgpu_device *adev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp;amp;sdata=3D=
B%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637202606831789803&amp;amp;sdata=3DB%2BbtLEKN5A65O=
Ep8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488EFB20868482AC55D3C14F7F50MN2PR12MB4488namp_--

--===============0354589618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0354589618==--
