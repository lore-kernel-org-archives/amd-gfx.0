Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91232C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285EF20658
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F9COOypB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285EF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28216E067;
	Wed, 12 Feb 2020 15:11:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1DF6E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC2rpjqJInHTUhnDmENXKKWm/KfJVrxbDLq9CD6SEVZ5yKYrXx7S7fMM61LoAsvBgQFE85iQLGAqqQXEuIPX/bhiY7K86uQ44u7EfRbft1N777wI+0Pu9cVTM4HWtNo6KAkbdM8P1xjh0IyewuZfTHJ+3riHmudHSQ3Vc6AcBxMl3HxDTpRNd5tyWtt94/3HmVbQ73W2Ksfz2qdZ1CUP+L+S5AoLJwd3Gu6nBufiVPKohN6NL+chk1OC3c7cxFHGdZU435yjlmePNRSfbOExu30NyoOQ05ujS4rlUqR5aZo+kuwhNH0Pi1G+C7BrY0VktIGNjF/hUoAvkuNSyp5AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxvfEByuDXNifYUGwClq1Mh74fsyeyS4yNm8t5PCBa8=;
 b=ezxF1n61OuJYRvEXwlmFQJCb0kql5aWFEpECPXddnUMzOTZ/d+ieuUhHBxqoSPJdGNAHT/TqhV6rYscqvmdb2BeEOpblNcocD4jhFhHOmzIBwzmAlzlcFbV7CJFaJLWHmK8mVeOqKLLOT72p8JJfCAH2tjWO1y2EJJBdPTPx5HxMaA+DWEHWB3ADM+f9Sue+HFZVYFe18PmBxOYMCxGfzsJqAbJVqv9IkrdjovDWrflZNKsI3fOaMNZ0/bav7i9yWoOc9zDGMO5Kh7Zf+C2rATPMwnqJaPxGozCMSmC9ZJrQxWupL3CP5oqPjwBr3gbkeyVTM5hXiu+4TYdrn5Tz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxvfEByuDXNifYUGwClq1Mh74fsyeyS4yNm8t5PCBa8=;
 b=F9COOypBqe0mK4nEMpGEnIzlH5jvpV42w1hJFGqkry1dFEiEDL70+oQkaEhFrmbXgqKvEwmSmWXatHpe3WYsJ6i70N2YbyY4O+94stqhxg6XStC0VVeVvi+UzKgkahBu0UAG5JYp1z9Ggjyz5LGXooLESx1ceAy+qJvstRRl+no=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2858.namprd12.prod.outlook.com (20.179.104.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 15:11:33 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 15:11:33 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start
Thread-Topic: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn
 start
Thread-Index: AQHV4Dzr+PMKT+8xT0OLmj2gEe1kzagXoKmAgAAKxgA=
Date: Wed, 12 Feb 2020 15:11:33 +0000
Message-ID: <DM6PR12MB391418ABECAABEC1722F8050E51B0@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
 <BYAPR12MB32852AA885154B9C31A3F268E41B0@BYAPR12MB3285.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB32852AA885154B9C31A3F268E41B0@BYAPR12MB3285.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-12T14:27:34.615Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bbf81c8-da5c-47f3-d390-08d7afcdd8f0
x-ms-traffictypediagnostic: DM6PR12MB2858:|DM6PR12MB2858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2858942680844BC2BCAE22D5E51B0@DM6PR12MB2858.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(26005)(186003)(52536014)(66446008)(86362001)(5660300002)(81166006)(8936002)(66556008)(66946007)(76116006)(478600001)(66476007)(8676002)(81156014)(64756008)(33656002)(2906002)(316002)(6506007)(53546011)(7696005)(110136005)(9686003)(55016002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2858;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKy3SHArzVIMvWPwWIWGa/oMoX2u1J8SOQJ+g0zchRuQoouawm1rMg0s6XRAfRboz1m5Qe6hS6J4wqepONFmR24Vcta2BWCFOVGciWoFb+GlE2lf4jZCP2ztHvhh6HbCXGhShKp+hB5BA+7ypeTiJ0htbjl3raOLEsdkpI0jNj+P9WkudZ6yBrKQ4k8+t5YT0QKfAv/+U6jj1TGbu/WSmM7q4YT2UJ/rb+ueMmUcHcPqiNwJln/WQ9Mm6HbUR//ZbQUdJHy2qU+NiFTvTB9v9qfWDJaf8rwV4zjciobgm8aYrzVsZf5xBv+9L6iiYH35Dvv7PY4Jmojwd0Se+j8ODWh8u9HK/Z2MbpdKwz6rFbXWhNrqhvTCoLPAsJJmkBGEhdQDThMRWF59l50L5rVUPLG5NuQXCqQj+QPfMvJ74NfmDtVjWgBSUw1ukFvLqpPY
x-ms-exchange-antispam-messagedata: YFHVewsQJ6GghucXHP8HuHgTnawX7ejaNiMzn3XRMfegVp7iSQco3rkRe3ffwJgyQAo+kOiwXQpAQ1u4BsWk/8cgNaJ673H/T6qdNRF9dlCtlCvudN8jK5ouTPK5LEJttzi42secy/flXv0aT7u7Rw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbf81c8-da5c-47f3-d390-08d7afcdd8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 15:11:33.8053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4/mHA6rEYlcRwtb99/UlKoCzI8zjSdS2S90qMsix2J2E4bGOX1O3yhlsPGH26Hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
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
Content-Type: multipart/mixed; boundary="===============0849333939=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0849333939==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB391418ABECAABEC1722F8050E51B0DM6PR12MB3914namp_"

--_000_DM6PR12MB391418ABECAABEC1722F8050E51B0DM6PR12MB3914namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_DM6PR12MB391418ABECAABEC1722F8050E51B0DM6PR12MB3914namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">With your patches, still seeing the hung with multip=
le processes of decode, encode, and transcode.<o:p></o:p></p>
<p class=3D"MsoNormal">I think we need find the root cause of that and give=
 a comprehensive fix either from driver side or firmware side or both.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Leo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhu, James<br>
<b>Sent:</b> Wednesday, February 12, 2020 9:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue fo=
r vcn start<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">ping<o:=
p></o:p></span></p>
</div>
<div id=3D"Signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com"=
>James.Zhu@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, February 10, 2020 1:06 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com">James.Zhu@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vc=
n start</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Fix race condition is=
sue when multiple vcn starts are called.<br>
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
2.7.4<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB391418ABECAABEC1722F8050E51B0DM6PR12MB3914namp_--

--===============0849333939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0849333939==--
