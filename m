Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E375C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 14:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A687206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 14:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MSWld7/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A687206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BA36EAB7;
	Wed, 12 Feb 2020 14:30:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673496EAB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 14:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7iv+zZlK+Mzmzzg3N9EispDSo1j7oRFXm57t+fN4t1fhey58bU69hVi7rlub0qX3/SbtPemwIJ92RPZXvS+5zWSelJP/Rw2OIllKHUBbJbXgLMhGyYkAEiS3lM91htOmxneOhYChPeCW6sJHyo8J8f3pVu36AcLbRIyBqYaRDpb0nuA7qlKbvjmL5i/XvTgSkqcVN5OrTl9IcXm3xgT967lH0SU+Nx+c3wSmhey3VAgIuEraJPe/gYjTOJ+Q8gLOZao0i+ZqmWcI23RLPWZoKMEC2EOfvEu29okYu7AxEOzdrulzaoE2Q7MQfrzMfn4Vk1LkQcZQBsHCJlhqV/r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO1cjsDZE6Spx5XVapqhZrXttxbyeoyLWtlOHER5OQg=;
 b=iRY707sqyVFCBWWuAHGOWqd0NLTrp+cb/1DBqIpn9uEXBghQJkYdq8UPOnrOKwUVGQ3ZtE+uE96Wj+TfnwjlDpbsRQyBgu9fX5j51GwEzNUJknvgQFSm8o4goli+QCqcq68jsstpL5PH8jofWMUmpAmSlVe9xuV2MPP6EqQH4FXFSgh3Gexa24dsarNfI9kbY99tUJl4bzsUqhj/ciG5zPbcPU6ZF5z5rdl1KWkYlGiJvb9FzpigLVvkqJ1VRbvSedxBpE+gWKwkol1eg/YGYUUyO1p/mdoytbmHSks5Z4jbOsMnJ4ILOqru2L7JGIysHKsUADftAj2UrXp3gyyJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO1cjsDZE6Spx5XVapqhZrXttxbyeoyLWtlOHER5OQg=;
 b=MSWld7/9XHb98pFUSAcWlTJGiAEPcamaYGcijT5Ebprwa6GwqOvzxVjwRz4zvwGBbbxHxzNs6CqljPQzguzwstEotEZnW4Cp7Xy+0AmHI7r7wtGtVfff3Bj925Sl/MKEoaIsmSQvq71wKiFk89mFA1caKdfpw/bffVgixTzu1kU=
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3224.namprd12.prod.outlook.com (20.179.93.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 14:27:35 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:27:35 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start
Thread-Topic: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn
 start
Thread-Index: AQHV4DzlsX32TKlgQEWFDwveeeppLqgXoJoc
Date: Wed, 12 Feb 2020 14:27:35 +0000
Message-ID: <BYAPR12MB32852AA885154B9C31A3F268E41B0@BYAPR12MB3285.namprd12.prod.outlook.com>
References: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-12T14:27:34.615Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
x-originating-ip: [2607:9880:2480:14:b0bf:419:3b71:afd1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7707027d-b918-493d-51d9-08d7afc7b425
x-ms-traffictypediagnostic: BYAPR12MB3224:
x-microsoft-antispam-prvs: <BYAPR12MB322422F434E8749CB25CBCD7E41B0@BYAPR12MB3224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(53546011)(6916009)(316002)(6506007)(7696005)(86362001)(81156014)(8676002)(71200400001)(55016002)(186003)(8936002)(33656002)(81166006)(478600001)(66946007)(76116006)(9686003)(66476007)(66556008)(2906002)(52536014)(64756008)(5660300002)(19627405001)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3224;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XazeoCkdVShDD1az2dTNMqJOmhIYL6P2e9Dv648N1SRO1ei4u7eDqy3w0TKEL33dFs0faor+CLHgBdtyXXkB2SzZmFjyjrcXP6e5jLMvdZsceeYhgBdPeyDMIUWJFnRIV5azliTo8P5Lu+VhscNSb+CXDmnfoYZTRlgniQvIvueHsjZiGdtnJhv+SGwGNNHugF79RKvZ30R06Yw5CuE4qv+Pn9lNoL4V1FuR6LSOCh1Y/Z3RL7dpJ5Aq49S4g0skR5CX3Ke+XsrmYKjmDWJn01Hff0Yux7NGpJWGK02pJSfIN0A2Oa3RAsYRDqeAUNTxGibSwiLmKYhnhERQh3mmZ4IYOt7V6uM4CTHOVpA6/sN8zcU4TKfg130/TB4b8qwVfM70oCld3iZqyBeMKd6qAgyrr32CoODstoWp7Z+mOfG25NlrGkt6xzFY45L8aJT
x-ms-exchange-antispam-messagedata: b7Uumhd2c0yw6SqSPuTuA6zYfbTBVHnKNGRB7gX7ahIhrlgGqxTHff2NcGu+mZQP1h1hzxXxFTaE8aqLq8Prk4491RFsbEssTUpv4ymf6FFujW7l5dlTYJx+PJp2yiq6uv22Nnxg6cuUi9vmNemIdbjLpsebZmqQDVQX/hD2e6kp9CIInT17F7ZmaAtIceSSQKXdhXL9r0Ovl9Q6jI/Tew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7707027d-b918-493d-51d9-08d7afc7b425
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:27:35.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dn8IpbD2Z2n738D4Jdw3aAW4UmCj5/SBdfYkVNdEe51NmY5ljJGGT2ZozGoHWW/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
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
Content-Type: multipart/mixed; boundary="===============1398825514=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1398825514==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB32852AA885154B9C31A3F268E41B0BYAPR12MB3285namp_"

--_000_BYAPR12MB32852AA885154B9C31A3F268E41B0BYAPR12MB3285namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

ping

________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Monday, February 10, 2020 1:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start

Fix race condition issue when multiple vcn starts are called.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index f96464e..aa7663f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         int i, r;

         INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handl=
er);
+       mutex_init(&adev->vcn.vcn_pg_lock);

         switch (adev->asic_type) {
         case CHIP_RAVEN:
@@ -210,6 +211,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
         }

         release_firmware(adev->vcn.fw);
+       mutex_destroy(&adev->vcn.vcn_pg_lock);

         return 0;
 }
@@ -321,6 +323,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)
         struct amdgpu_device *adev =3D ring->adev;
         bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_work=
);

+       mutex_lock(&adev->vcn.vcn_pg_lock);
         if (set_clocks) {
                 amdgpu_gfx_off_ctrl(adev, false);
                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_=
TYPE_VCN,
@@ -345,6 +348,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)

                 adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
         }
+       mutex_unlock(&adev->vcn.vcn_pg_lock);
 }

 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 6fe0573..2ae110d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -200,6 +200,7 @@ struct amdgpu_vcn {
         struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
         uint32_t                 num_vcn_enc_sched;
         uint32_t                 num_vcn_dec_sched;
+       struct mutex             vcn_pg_lock;

         unsigned        harvest_config;
         int (*pause_dpg_mode)(struct amdgpu_device *adev,
--
2.7.4


--_000_BYAPR12MB32852AA885154B9C31A3F268E41B0BYAPR12MB3285namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
ping<br>
</div>
<div id=3D"Signature">
<div><br>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhu, James &lt;Jame=
s.Zhu@amd.com&gt;<br>
<b>Sent:</b> Monday, February 10, 2020 1:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vc=
n start</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Fix race condition issue when multiple vcn starts =
are called.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 &#43;<br>
&nbsp;2 files changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index f96464e..aa7663f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -63,6 &#43;63,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;ade=
v-&gt;vcn.idle_work, amdgpu_vcn_idle_work_handler);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;vcn.vcn_=
pg_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
@@ -210,6 &#43;211,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;=
vcn.fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;vcn.v=
cn_pg_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -321,6 &#43;323,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool set_clocks =3D !cance=
l_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;vcn.vcn_=
pg_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (set_clocks) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VCN,<br>
@@ -345,6 &#43;348,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.pause_dpg_mode(adev, ring-&gt;me, &amp;n=
ew_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;vcn.vc=
n_pg_lock);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index 6fe0573..2ae110d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -200,6 &#43;200,7 @@ struct amdgpu_vcn {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *=
vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_vcn_enc_sched;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_vcn_dec_sched;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_pg_lock;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; harvest_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*pause_dpg_mode)(stru=
ct amdgpu_device *adev,<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB32852AA885154B9C31A3F268E41B0BYAPR12MB3285namp_--

--===============1398825514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1398825514==--
