Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568FC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5704220714
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YL1CeEln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5704220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC5289E9E;
	Wed, 12 Feb 2020 16:13:38 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B8689E9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 16:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIuY6PjWRhOKxbDuKv0SxMDiM1A4zIh+lDHi9U8RLAl2Ww6FfmcljhybDsHiTVGfphM8YkSr/jz/wiYC4VwSHoB3T3EciPJCl0t8XKPQCX7PzOEX05+nWT/dsfgRbr0ATt69JBHwBIdGfJi9UbOdbFAIctNVFVer+HoLGNfHEaR1WIolCLk8vrCk21HXU1ler7VjDzMJ/LW/Jeuz+Rrcrr9sZKk/5WaDuGCaKBoaUtJmXkY8OXidTVwh8u414o7qB5zLqFc+hFQnNJ/Wur9TzflI0JANUKbcpJ2L4/BDvi4KKJU/7so9BSavupNQ6dJVsP9WJNh2W/Tmh/F7XrUgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G6qwn+EzvaQVwHcGruCPFFzfeFak+/zOuJRKOBsXeA=;
 b=j2lMBCvr+mNzKX1zCPljsODwAFSr9u3WihvHzXk3NJYTfqNnzXyo/b4/r84DUfZgPtPVtLCBJOhU8WFx8iL7wpxAmM02bH2zB1xm4bthSWdRchZ0dZ02+vGG6t4BSxxzczMPC78DxCiYKAxCx3+AGdQexrn/wYohRiEF/L7b15HERVLYLjuniuQsQywDzUdOWQnKsw8RVUzG+t3r8sk3fLJsBnvrqnItfat6Rg92qpHcIW32AzUPM0pVXRv3JN4HwLlWnXyaDLlVrNrhy+c3g3b1zTZO8LRaD95EyeK3ZkU56pxZNFNMXvNp33eFvEcgyB95AkHDQRrgvBFYq3iv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G6qwn+EzvaQVwHcGruCPFFzfeFak+/zOuJRKOBsXeA=;
 b=YL1CeElnoX7wzCjXKNdyMh75YYonjmlVrGRSBIhWKjv20qJPF7fqJ/LsRxYuYU6UlMOmAaQ9KVhIuAqYYJ9GDQmjH+adZzS0xPrELgyH1dRRHdzLQz42fLUjBAfl8lobhb2xotMrAmr2w4ogdmle/V1Sz7MzU6WJE6ThMGF/k3s=
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3383.namprd12.prod.outlook.com (20.178.54.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 16:13:35 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 16:13:35 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start
Thread-Topic: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn
 start
Thread-Index: AQHV4DzlsX32TKlgQEWFDwveeeppLqgXoJocgAAMWICAABB8BQ==
Date: Wed, 12 Feb 2020 16:13:35 +0000
Message-ID: <BYAPR12MB32855E5911D964335EC728ACE41B0@BYAPR12MB3285.namprd12.prod.outlook.com>
References: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
 <BYAPR12MB32852AA885154B9C31A3F268E41B0@BYAPR12MB3285.namprd12.prod.outlook.com>,
 <DM6PR12MB391418ABECAABEC1722F8050E51B0@DM6PR12MB3914.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB391418ABECAABEC1722F8050E51B0@DM6PR12MB3914.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-12T16:13:34.765Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
x-originating-ip: [2607:9880:2480:14:b90c:f8ff:18c8:542e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0288da0c-9a44-437f-c338-08d7afd6832e
x-ms-traffictypediagnostic: BYAPR12MB3383:|BYAPR12MB3383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB338323F3C28A20AA4E9159F2E41B0@BYAPR12MB3383.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:143;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(478600001)(86362001)(19627235002)(6506007)(53546011)(64756008)(66476007)(66946007)(76116006)(66446008)(66556008)(2906002)(186003)(71200400001)(110136005)(52536014)(7696005)(81166006)(81156014)(8676002)(8936002)(33656002)(19627405001)(9686003)(55016002)(316002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3383;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C/3xt3WOadeZjBMIGOGzKNE2eqZ8rUC/Moh9QYuJoxpIGfDlarbnkj6nrEIJsswjc6EKsRtx3PZQ+gJCU3MmM4X4OLNWToN2y6h3IHja7tAg22gRhJ0Ur37ntCLI7L6OqS8r8x1WMDO+6IHev8ZI4N/kAm97iOKHE5WBZgQZt9KU3yHS3kIhLu4ZSy2Hm4gDe+KYFinM4XfMYRq3AJNtYxZy+bAgTfpw40bADdNepcSlSyHIkp8EyHAvE6P85YLuAT4kg9kMNorvD4LhUgVhY5rUR3DnOLQQjsWNOn6u7YhbLpr1oVbpbsCVVoFq6Oj0bCjrBhJkspN1qAF2af2uUtShdcPCD6vVlJ+jHPK52TELeErvfqagQUcLdtN0rzN3X8T7bnxtioIKEj7FdP9bLri7kVYzQBQB8TEabtckdyIj1cinEVEl0NEqet69d6Lf
x-ms-exchange-antispam-messagedata: oO3a8f1EIqWrGNCYNdurM2fi3XCugqczH5oN+PMRgsLSAdpANEshQnQ2KMhKg4KyzYbeCefYhpZyM7VMYEDG6NpD1WkGZlEflU5BM4UFYSVpXSYqUlgX+kSE1btRoUnGtIPFyK+1ngyETYrx6OIUywfFgcsdzPpHWZBhPYS7DibTxuGt7I8/eKsSFP5zOFY7L2HYjsf8Mm6Ae/ik++1IwA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0288da0c-9a44-437f-c338-08d7afd6832e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 16:13:35.3567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFDt4cRB5SM1wnKs/INSUAg3OJu/9mfzPKMZYxcI0j61Z8v0w9WKMEsk3g6lefPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3383
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
Content-Type: multipart/mixed; boundary="===============1171787928=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1171787928==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB32855E5911D964335EC728ACE41B0BYAPR12MB3285namp_"

--_000_BYAPR12MB32855E5911D964335EC728ACE41B0BYAPR12MB3285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Timeout issue are complicated. These patched can fix driver side issue. Act=
urus SPG timeout issue can be fixed with these patches. For other type of t=
imeout issues are still under investigation.


Thanks & Best Regards!


James Zhu

________________________________
From: Liu, Leo <Leo.Liu@amd.com>
Sent: Wednesday, February 12, 2020 10:11 AM
To: Zhu, James <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn s=
tart


With your patches, still seeing the hung with multiple processes of decode,=
 encode, and transcode.

I think we need find the root cause of that and give a comprehensive fix ei=
ther from driver side or firmware side or both.



Regards,

Leo



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhu, Jam=
es
Sent: Wednesday, February 12, 2020 9:28 AM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn s=
tart



[AMD Official Use Only - Internal Distribution Only]



ping



________________________________

From: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
Sent: Monday, February 10, 2020 1:06 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
Subject: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start



Fix race condition issue when multiple vcn starts are called.

Signed-off-by: James Zhu <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
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

--_000_BYAPR12MB32855E5911D964335EC728ACE41B0BYAPR12MB3285namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Timeout issue are complicated. These patched can fix driver side issue. Act=
urus SPG timeout issue can be fixed with these patches. For other type of t=
imeout issues are still under investigation.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Leo &lt;Leo.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 12, 2020 10:11 AM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue fo=
r vcn start</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">With your patches, still seeing the hung with mult=
iple processes of decode, encode, and transcode.</p>
<p class=3D"x_MsoNormal">I think we need find the root cause of that and gi=
ve a comprehensive fix either from driver side or firmware side or both.</p=
>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Leo</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.fre=
edesktop.org&gt;
<b>On Behalf Of </b>Zhu, James<br>
<b>Sent:</b> Wednesday, February 12, 2020 9:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue fo=
r vcn start</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">ping=
</span></p>
</div>
<div id=3D"x_Signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.co=
m">James.Zhu@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, February 10, 2020 1:06 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com">James.Zhu@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vc=
n start</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">Fix race condition =
issue when multiple vcn starts are called.<br>
<br>
Signed-off-by: James Zhu &lt;<a href=3D"mailto:James.Zhu@amd.com">James.Zhu=
@amd.com</a>&gt;<br>
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
2.7.4</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB32855E5911D964335EC728ACE41B0BYAPR12MB3285namp_--

--===============1171787928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1171787928==--
