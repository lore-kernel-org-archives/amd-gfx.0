Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36154C54FD3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3DE20772
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UGz6lCUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3DE20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F0A89F45;
	Wed, 25 Mar 2020 15:22:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF206E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKpF9RKoMuThAVOZ4jDRx0hSyxeXcSCR1T9kIR3CY+2Pg0qDYZzKh+4oER/RylgTYTFo7rozb7ZyWdOlHTIDLMc2prTdiMnJYqmFrfl9mvyVNul5W2qUpM55HnwtCpVMnDVE4Lgk/IrVYa4eY03vBGx9cMJmNszzPMzSMUNWDcFUQfqMzLKCkvmF5SbMehbQA6JkxlZXFYMDAbLLvm4HjoLgDfo+B3OXLpcr6XIYiov17F2wCnRqoRsyAmO0fewX+tHNdVezR7MqhezYg4Yl2bVGnmHA8LiPJ+CAcdZ9/AxfzK/4SW5CRY2QfgWzrmiMgYksYTbRnPt5//J4nvNzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKHT5aoUoW9DBbko6Kpw7ZEB9H324vD/QkfMBc26SQY=;
 b=d6KWo3sMgyO9KBrDc+Ie+8plOmfHZTsBtNjKJK2JlmtfR2cR7VGWlkHjB9REIgKkhvHlhnL7ZzfOzElJzVY3ms6ewDpDIKBa/VgMwy0gwRAJkttjaeaWDTo0rhj9DXoVvvBJeQ+Pdvq9+bOvgJrEAh/RHl0+x5ZKC9JBb/PZEa9DRZLkjBE0oZHMjspAuxLK8ONt8roOw61XsXViZ2cWFX/ym3MAATNTFj8+qBgb5fbwzkgjHq+rJ8kzmC5Dp8sBd/Mu+DNeoTWeabj6SPzxSym3PRflyFCGoxxWGCAIF9pdrLUkFt2/EIKrC05ZQi8znq0NqBgDHDRMrZ5wKukNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKHT5aoUoW9DBbko6Kpw7ZEB9H324vD/QkfMBc26SQY=;
 b=UGz6lCUBqytZ4qbidHyMi508Nr9owcLFnhUdgQsgcJ21fP1WIVaCJn4AnGr2zLIf0MbazqW310ut14C+QQXFqviWUCaLRCKlrZuKKFIWK1bZfPbVRbfH2RerqOmca+1yWULCZ32oj47IX3c5J1/SZTjtgjsB655NYSrA38GxppM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Wed, 25 Mar
 2020 15:22:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 15:22:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: add missing if clause guard
Thread-Topic: [PATCH 1/1] drm/amdgpu: add missing if clause guard
Thread-Index: AQHWArjoELyDngXCpEqZ0x9zx9MmsahZbNgL
Date: Wed, 25 Mar 2020 15:22:28 +0000
Message-ID: <MN2PR12MB44887719B1FA99655886B08CF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200325152425.43179-1-nirmoy.das@amd.com>
In-Reply-To: <20200325152425.43179-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-25T15:22:27.753Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f51386d3-687c-4e2a-46fc-08d7d0d0546f
x-ms-traffictypediagnostic: MN2PR12MB4288:|MN2PR12MB4288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4288D97A1D0DE97B9822B0B9F7CE0@MN2PR12MB4288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(81166006)(478600001)(81156014)(52536014)(110136005)(7696005)(53546011)(6506007)(66946007)(66446008)(66556008)(66476007)(86362001)(76116006)(8676002)(33656002)(64756008)(26005)(54906003)(8936002)(5660300002)(186003)(55016002)(316002)(19627405001)(4326008)(71200400001)(9686003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4288;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJBA4/Y/iiOAjsrV2SDydQmnOkZQtgzcn24QpjDreT/XYKhu5pd9LrBWEaVWIFg6B4rkesLdBxFdS0nMvjAf6ZtwTamfZh4+QK/qIGiKdA7cP37ZwcePa7gSKxeEANMqOvLJMWkgVjAQ4todLNEA2fYg69FlB44m4Of+amN3MLOyF7sm7QkCjEM4PRRUwH//MEd4Zn/JjybOM6IYgDjxz+dSewrzKV+uqEsjHD3YeqBkOxI9JD/vV0PcJ241167MQQeBXFZGibbBS9oawpX8NK5vJYfeXYPPWvKEpdvtaofRqHtRamdZ5MwnUHE34ED8aVx3O6Q5L0YveuVmheYHbeXBRC4tMdHdgBDAT9d2tQq5KHc7iuI9KaVxDjioY6l+kThABOB4FgCzP9qBThpFaEzc4FovZFQTAzdDPuuzp+gPWvI/phAAI/Rn2FxR/Vzz
x-ms-exchange-antispam-messagedata: ToUR2pE8rd8SK0sHE0RsK3VXkckPCaQ+CBoYZck272RAopUVtl6tOLtCEb/dTVxeG8ZM5tF9AQI8Pq+L7zmxamCFWs2VSCVtn5jqMzaMUT27FYdl6RwKvdfLDqB7NvIXJEAW9xcBqFF9ew37+mJilQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51386d3-687c-4e2a-46fc-08d7d0d0546f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 15:22:28.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0LO2xI2DS/EuuDjZEFHuu6b1mb7BKGgiNwRjsZL+kSjoS6ZsBZvgASmkikSO5af6NJFYXf34Z7jxqhx/uhM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0346046962=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0346046962==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887719B1FA99655886B08CF7CE0MN2PR12MB4488namp_"

--_000_MN2PR12MB44887719B1FA99655886B08CF7CE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
Sent: Wednesday, March 25, 2020 11:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Da=
s@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add missing if clause guard

Fixes: 635f3790ac964 (drm/amdgpu: don't try to reserve training bo for srio=
v)

compilation warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function =91amdgpu_ttm_init=92:
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1862:2: warning: this =91if=92 clau=
se does not guard... [-Wmisleading-indentation]
 1862 |  if (!amdgpu_sriov_vf(adev))

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 54cfa3a12135..e192557db421 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1859,10 +1859,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
          *The reserved vram for memory training must be pinned to the spec=
ified
          *place on the VRAM, so reserve it early.
          */
-       if (!amdgpu_sriov_vf(adev))
+       if (!amdgpu_sriov_vf(adev)) {
                 r =3D amdgpu_ttm_training_reserve_vram_init(adev);
                 if (r)
                         return r;
+       }

         /* allocate memory as required for VGA
          * This is used for VGA emulation and pre-OS scanout buffers to
--
2.25.1


--_000_MN2PR12MB44887719B1FA99655886B08CF7CE0MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nirmoy Das &lt;nirmoy=
.aiemd@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 11:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Monk &lt;Monk.Liu@amd.com&gt;; Koenig, Christian &lt;Christ=
ian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: add missing if clause guard</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: 635f3790ac964 (drm/amdgpu: don't try to res=
erve training bo for sriov)<br>
<br>
compilation warning:<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function =91amdgpu_ttm_init=92:=
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1862:2: warning: this =91if=92 clau=
se does not guard... [-Wmisleading-indentation]<br>
&nbsp;1862 |&nbsp; if (!amdgpu_sriov_vf(adev))<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 54cfa3a12135..e192557db421 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1859,10 &#43;1859,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *The reserved vram f=
or memory training must be pinned to the specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *place on the VRAM, =
so reserve it early.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ttm_training_reserve_vram_init(adev);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate memory as requ=
ired for VGA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This is used for V=
GA emulation and pre-OS scanout buffers to<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887719B1FA99655886B08CF7CE0MN2PR12MB4488namp_--

--===============0346046962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0346046962==--
