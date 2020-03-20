Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825AC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDF720724
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NOiDsVbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDF720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB6C6EB53;
	Fri, 20 Mar 2020 14:39:25 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214276EB53
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N15p4DdGZjI2ZPfbprYs6pnlNBDYcntizCAxCm/ylIKbnTUb1CR4bsEhEwNpuHb0A9gJWPqPEE+aYKe8FZRJ2nEVdDCU98Ds8moOwQneXyB2XUNpCi/oBUeyz8XlmV8tWDeqsjtQv/S8hecdB8nwnUQIstOqeaDBOQlfHSvPDKg9aH7P1WfeRu6b4/W/R+9UJJ/qwIgjzmpccUN4bYgimYGQfrdNCbm2871SWYRZy7GhB9CG/tZpmMQVOMh+RWI+gPmeciiY3WAdFjIEYOFrkErvHDmf4eHoSCApxNFFkMRycY9OP6jJMuNsd11264/BsMoQNxQOl+suMvbWpnjyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgU7gSrLbzo6OgqxUj36ZA1pmG0t7YfdGXeB+CnygVQ=;
 b=UCYDj+v6BSVhHM1ezAR7gFxC52+pvHe4Ucb57E5C+dVidMSQILhNJQysNn28EYv9YP9Ro4awwmFFTcOu+NvpmbaAdFXj96ScfkYpL4oJ3PJBbxRIGCKL70q1dft1oDAeb9xYghOb7zmSQ/y28CRAwwY+eIS4wxseSr2u5TzDavTcjdf1akS6IjSuuN2Kspp85a2R4kC3qxA2FGMukkO7krVe/P5IvUuPdExEy/C8iBvUVW76GN5KfonZkI+yIXcAmIC8Vywv6DXQaxusG686JElJj2aMoBZjZmgn/iES8SLDIAckjIzekQEsYqZ04NNi9rvurXbIiQQAYmKkhtv99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgU7gSrLbzo6OgqxUj36ZA1pmG0t7YfdGXeB+CnygVQ=;
 b=NOiDsVbQIbk83oIQ9jcVH3/Ve/o3Wm6gvVoss+Bh0wkL109f/z8MUILj+voVz7q1/qkU/3V2/Q4i96bGw5bbwnHMVMAlfOljDGBWWsNR7Loa6shcu0Ycqt0oJhHbWz2fbxfRDEAv2ERTXYyspsUfcgzMP/bMD/x4Nj+0W7s8DMk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Fri, 20 Mar
 2020 14:39:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 14:39:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Sierra Guiza, Alejandro
 (Alex)" <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
Thread-Topic: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
Thread-Index: AQHV/k3z2pZ1DR+fSEu6Or1lSxdfvahRgticgAAF+ICAAAOhsw==
Date: Fri, 20 Mar 2020 14:39:23 +0000
Message-ID: <MN2PR12MB4488D6A91C88D614166D13A1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
 <MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <50a79ebd-ab45-927b-a44d-dba313a72953@amd.com>
In-Reply-To: <50a79ebd-ab45-927b-a44d-dba313a72953@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-20T14:39:22.601Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c5a6e47-8eb5-4aa4-929d-08d7ccdc7b92
x-ms-traffictypediagnostic: MN2PR12MB3792:|MN2PR12MB3792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3792DD17A7249226FE88834DF7F50@MN2PR12MB3792.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(66946007)(966005)(53546011)(66476007)(64756008)(66556008)(52536014)(76116006)(86362001)(6506007)(2906002)(8676002)(33656002)(7696005)(8936002)(81156014)(81166006)(66446008)(55016002)(45080400002)(71200400001)(186003)(478600001)(110136005)(5660300002)(26005)(19627405001)(316002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3792;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mIXnCU+eD82WFJGGyK3eIp7qJsLAt6KEiSyKDqVgpIb2oK7k6QjVTRI2J2oxnko6+9wB7Vd1cWrEjVnClgEyAFknlyr7D1H+JZ4U7TwC443pp18ElDfTw9UXyoQLq9E1ZmicXDYXdHDsEjcR6870q1aULkKnpNcLc+b30K/IsarIGwfVlo3PlYTWtHYhZbCdzfm7tnyfZ4+f5oxe7L1D8oUtA2DszLFQ99cpsGmLeKI5nwghq/g7rcFNFb5byD/zq2IkoSwKfELSMCUtnkr/q4AdcpyS4Ae9G9t1hcofHICYywkNvQ85f15odUmZjq2JpELvgKEiKhevAXp96vvvq8zkmACsK3o1VPVsHDjhHHd5wZbYqsOly8C0bvo5Du3ODyhvz5OJOIlMuCtem0VDDjCJUb4osFxQHc6VjpMJE/0KuTP7AXEeP2EpMLPk7b17tdAPn14gG4ZqngeqN0WjK3XDB+1CIUIEvW3GQFwliI=
x-ms-exchange-antispam-messagedata: 4j8xlzc/+90E/9Dr1GjX3Hl+po4FwyiZdf6gOvab4E7OguiVtnXTvFkdMjU7Of6fX2xwbvFG6WvskFR5+dNWkJnV4lJM4rhW52Ea/xGo8S3p1ge+jyKFosGukVBoD5oqVrEzFrat4I62ac6vgMNfQw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5a6e47-8eb5-4aa4-929d-08d7ccdc7b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 14:39:23.2059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ot9mDRDucxreA2u0JrtaVKyv5c5AuwEwoAlIUSKhCF8U5gcnHD0nxAuokUIo4oi/HVvgs/8HjDZg3HLxsD70Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Content-Type: multipart/mixed; boundary="===============1987419743=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1987419743==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D6A91C88D614166D13A1F7F50MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D6A91C88D614166D13A1F7F50MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I'm worried we'll miss a register by accident.  We went with per IP sub dri=
vers to avoid handling complexities around IP differences if possible.  Als=
o the scheme seems like kind of a one off compared to what we do for other =
IPs.  Can we structure it more like how we handle SDMA instancing since it =
seems to mainly affect IH RB instances?

Alex

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, March 20, 2020 10:20 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, Alejandro=
 (Alex) <Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists=
.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offse=
ts

On 2020-03-20 10:06, Deucher, Alexander wrote:

[AMD Public Use]

This seems kind of complicated and error prone.  I didn't realize the exten=
t to the changes required.  I think it would be better to either add arctur=
us specific versions of these functions or just go with your original appro=
ach and add a new arcturus_ih.c.  If you go with the second route however, =
no need to show all your intermediate steps, just add the new files in one =
commit.

Hi Alex,


I suggested the approach in this patch series since to minimize code duplic=
ation and maintain readability of the code. I don't think it's very error p=
rone. I believe this is more maintainable than a separate arcturus_ih.c. I'=
ll have some more specific comments on Alejandro's patches.


Regards,
  Felix


Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Alex Sierra <alex.sierra@amd.com><mai=
lto:alex.sierra@amd.com>
Sent: Thursday, March 19, 2020 8:22 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com><mailto:Alex.Sierra=
@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets

Arcturus and vega10 share the same vega10_ih, however both
have different register offsets at the ih ring section.
This variable is used to help calculate ih ring register addresses
from the osssys, that corresponds to the current asic type.

Signed-off-by: Alex Sierra <alex.sierra@amd.com><mailto:alex.sierra@amd.com=
>
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
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637202606831789803&amp;sdata=3DB%2BbtLEKN5A65OEp8s=
e5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;reserved=3D0<https://nam11.safelinks.prot=
ection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Fl=
istinfo%2Famd-gfx&data=3D02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d4=
9c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6372031000=
32276037&sdata=3Dbs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=
=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cfelix.ku=
ehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637203100032296023&amp;sdata=3Dbil9pUebulcGpl5YhTi9k6=
yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;reserved=3D0


--_000_MN2PR12MB4488D6A91C88D614166D13A1F7F50MN2PR12MB4488namp_
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
I'm worried we'll miss a register by accident.&nbsp; We went with per IP su=
b drivers to avoid handling complexities around IP differences if possible.=
&nbsp; Also the scheme seems like kind of a one off compared to what we do =
for other IPs.&nbsp; Can we structure it more like
 how we handle SDMA instancing since it seems to mainly affect IH RB instan=
ces?&nbsp; <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, March 20, 2020 10:20 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Sierra Gui=
za, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;; amd-gfx@lists.freedesktop=
.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss rin=
g offsets</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"x_moz-cite-prefix">On 2020-03-20 10:06, Deucher, Alexander wr=
ote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This seems kind of complicated and error prone.&nbsp; I didn't realize the =
extent to the changes required.&nbsp; I think it would be better to either =
add arcturus specific versions of these functions or just go with your orig=
inal approach and add a new arcturus_ih.c.&nbsp;
 If you go with the second route however, no need to show all your intermed=
iate steps, just add the new files in one commit.</div>
</div>
</blockquote>
<p>Hi Alex,</p>
<p><br>
</p>
<p>I suggested the approach in this patch series since to minimize code dup=
lication and maintain readability of the code. I don't think it's very erro=
r prone. I believe this is more maintainable than a separate arcturus_ih.c.=
 I'll have some more specific comments
 on Alejandro's patches.</p>
<p><br>
</p>
<p>Regards,<br>
&nbsp; Felix<br>
</p>
<p><br>
</p>
<blockquote type=3D"cite">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
&nbsp; <br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Alex Sierra =
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:alex.sierra@amd.com">
&lt;alex.sierra@amd.com&gt;</a><br>
<b>Sent:</b> Thursday, March 19, 2020 8:22 PM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Sierra Guiza, Alejandro (Alex) <a class=3D"x_moz-txt-link-rfc239=
6E" href=3D"mailto:Alex.Sierra@amd.com">
&lt;Alex.Sierra@amd.com&gt;</a><br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring of=
fsets</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Arcturus and vega10 share the same vega10_ih, ho=
wever both<br>
have different register offsets at the ih ring section.<br>
This variable is used to help calculate ih ring register addresses<br>
from the osssys, that corresponds to the current asic type.<br>
<br>
Signed-off-by: Alex Sierra <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mai=
lto:alex.sierra@amd.com">
&lt;alex.sierra@amd.com&gt;</a><br>
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
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=3Dbs%2F33P5fe=
C0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=3D0" originalsrc=3D"http=
s://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"RpptISRMfKBBZP=
2h2HOxGfxgMoH70rCb&#43;ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUm=
DwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr&#43;uSoF6bz83ifpZaF1KhW4RGW4V=
&#43;rHlh2VDoaZ45h4=3D">https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D02%7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7c=
c64f056%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp=
;amp;sdata=3DB%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;amp;reser=
ved=3D0</a><br>
</div>
</span></font></div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179=
e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6372=
03100032296023&amp;amp;sdata=3Dbil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR4=
4%3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&am=
p;amp;data=3D02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7c=
cd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp=
;amp;sdata=3Dbil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;amp;reser=
ved=3D0</a>
</pre>
</blockquote>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D6A91C88D614166D13A1F7F50MN2PR12MB4488namp_--

--===============1987419743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1987419743==--
