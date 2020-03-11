Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA0EC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 11:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E623020409
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EO3CfpAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E623020409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A026E57E;
	Wed, 11 Mar 2020 11:30:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1746E57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V75qbS1Uo7PYWgBdZfO67tSEnuQ9jMF7MvrH8ejOmrdTAeS4dTX35+4wSbH5jSUl1Lc4ym+L8iu0OHFhiJImWCk3Eb2DPqar3QvipYyfxAU9l1frvU8Xi+F5HzCAUNGTC64EoY6JFcpyJGg9TnK2ga5+zhhrU+P9r0vI5TDylT5GLfdrybksHrpFMkSau8Qt6+/fJ+cl9orxwr/nJD3adu6d8a/S+hj1iQkXen8KzSD3VeVaZMYzx9UAwAbYobHXtKPezsbehoyp2UMziVGENL3coSbHRSK389EDblXkdkTdt7RUUg7EMihRsSSn8U7Tq4+RA7k8bTL6mG9NsAM36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n2xEOoju/u5pWFM0KIrlFISe6+PpVv682A9fSn7HR8=;
 b=ZvXMvTSrEs9838Dce9rgaC2RKz1zh8rZf5sPRi2eCk8OtS/s2686nFF7oYJvSJj4qZzzc+3W8LOB2+WS96TzcQg98+t0Q8Wnd3BseaaavsM99UDUQYepurFkPoNorZ0+BmYhZ5r/eCe2NIDtRPiLh4o6ZQWO477tCoTNYdhFvN6zD36bcfeae0hhlU1cD4uDp+P+nWsBCgCL/Ps36mOhC165QzUz0hz9GYJa2hDPjt8xebpC26tDBJ/zCt4P7bIa5+a4wmW7Tjuv1HuyEg2D3O/A2p7CyWRJ+S3V56vOwbpDHYnqZzM+tUvEi7cAR/nBkOv5chiPQjU0Ih+j61kVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n2xEOoju/u5pWFM0KIrlFISe6+PpVv682A9fSn7HR8=;
 b=EO3CfpAze/6jGSdnAnVoxfsH2u/5YD9u0el7SHvIjHCy4e9o2NYfMgpqxweMo3Uvdfeyc79gS+uWUkxbEqITSmvqG7vJ8WDRWN0JJaI9UsDsKuUA99wOegU/sr/1SfM5bMkb7yMEE09ws3Jc+6+uHwk8J+2lHihZOVsrjL2nHH8=
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3397.namprd12.prod.outlook.com (2603:10b6:a03:db::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 11:30:56 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 11:30:56 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
Thread-Topic: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
Thread-Index: AQHV9jPHVuRnbJuhHEye8aVaV+Ekm6hDRJXO
Date: Wed, 11 Mar 2020 11:30:56 +0000
Message-ID: <BYAPR12MB32851E367C4D553AABB13BB7E4FC0@BYAPR12MB3285.namprd12.prod.outlook.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>,
 <1583773021-15957-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1583773021-15957-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T11:30:55.845Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
x-originating-ip: [72.137.28.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8653dc97-cef4-469f-e66d-08d7c5afaa66
x-ms-traffictypediagnostic: BYAPR12MB3397:|BYAPR12MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3397EE41A13E1516E493D780E4FC0@BYAPR12MB3397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(64756008)(6916009)(7696005)(76116006)(26005)(6506007)(33656002)(66476007)(19627405001)(8936002)(71200400001)(52536014)(316002)(53546011)(66556008)(66946007)(5660300002)(66446008)(81156014)(2906002)(55016002)(8676002)(9686003)(4326008)(81166006)(86362001)(186003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3397;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ThMkaYvq6vh62+LRVUqgX+8epMYipl7dUo86qpsoIdWo4H63F93rbd7kijuY4w4HFqkgYxijTydHxh8i3qSzJI9oxNaaLlX4cNU/yvZwrs9FV8LozoYBchC9KaiTjWKSw3JduyOA6AzveWwuP6ooXU2FucuXRf779LmTOTOHjKc+1erNRCYqtyW8CmjCYD+//PwhY9GxcdBUZRwHn15e70JzSZTlHdq/V0esIqXkZV/q81rV1wtOHovHyuDLQceH1rIyzPF350HxxfE6yS9AoCVl6hW9a1T147ltBZzDClfoLF0ZlEiw3utd7FBOGMzJroSK9zSxuHuQdJRxmPZMktfvbTgW23PMQiZAnEjPVvw7sLrFDBQzRHmEbRiVT9qI2/T2XjxoMjoUthsoDfI2WPQ2TPHpkJ+iGwCe2CZgkjb0DMc4VJIZlICEUSqGIb5
x-ms-exchange-antispam-messagedata: q/vgpdBhOZj5W/XYkaDjQKFVKP383pWC59y/R2tBZElql/kDikc2P4hSjMvJBrDFO1yC6aIMj1lYEJQLRhA+zUgiNP32EGqR539PET6SAAckOqhIXaCoGCNdwOPdMs7SrIutjefnjt1vy9/RikUHMg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653dc97-cef4-469f-e66d-08d7c5afaa66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 11:30:56.4463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9OEWqt+R4zgJzknFBbr+B30NoObuxGe08g0bO4QqX8zkw+yRD8xQjRRy7K5Nerj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1557656893=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1557656893==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB32851E367C4D553AABB13BB7E4FC0BYAPR12MB3285namp_"

--_000_BYAPR12MB32851E367C4D553AABB13BB7E4FC0BYAPR12MB3285namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

ping

________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Monday, March 9, 2020 12:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>
Subject: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn st=
art

Fix race condition issue when multiple vcn starts are called.

v2: Removed checking the return value of cancel_delayed_work_sync()
to prevent possible races here.

v3: Add total_submission_cnt to avoid gate power unexpectedly.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index a41272f..6aafda1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         int i, r;

         INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handl=
er);
+       mutex_init(&adev->vcn.vcn_pg_lock);
+       atomic_set(&adev->vcn.total_submission_cnt, 0);

         switch (adev->asic_type) {
         case CHIP_RAVEN:
@@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
         }

         release_firmware(adev->vcn.fw);
+       mutex_destroy(&adev->vcn.vcn_pg_lock);

         return 0;
 }
@@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)
                 fences +=3D fence[j];
         }

-       if (fences =3D=3D 0) {
+       if (fences =3D=3D 0 &&
+               likely(atomic_read(&adev->vcn.total_submission_cnt) =3D=3D =
0)) {
                 amdgpu_gfx_off_ctrl(adev, true);
                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_=
TYPE_VCN,
                        AMD_PG_STATE_GATE);
@@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_=
struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
         struct amdgpu_device *adev =3D ring->adev;
-       bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_work)=
;

-       if (set_clocks) {
-               amdgpu_gfx_off_ctrl(adev, false);
-               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_VCN,
-                      AMD_PG_STATE_UNGATE);
-       }
+       atomic_inc(&adev->vcn.total_submission_cnt);
+       cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+       mutex_lock(&adev->vcn.vcn_pg_lock);
+       amdgpu_gfx_off_ctrl(adev, false);
+       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+              AMD_PG_STATE_UNGATE);

         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
                 struct dpg_pause_state new_state;
@@ -345,11 +350,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ri=
ng)

                 adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
         }
+       mutex_unlock(&adev->vcn.vcn_pg_lock);
 }

 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
         schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT=
);
+       if (unlikely(atomic_dec_return(&ring->adev->vcn.total_submission_cn=
t) < 0))
+               atomic_set(&ring->adev->vcn.total_submission_cnt, 0);
 }

 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 6fe0573..111c4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -200,6 +200,8 @@ struct amdgpu_vcn {
         struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
         uint32_t                 num_vcn_enc_sched;
         uint32_t                 num_vcn_dec_sched;
+       struct mutex             vcn_pg_lock;
+       atomic_t                 total_submission_cnt;

         unsigned        harvest_config;
         int (*pause_dpg_mode)(struct amdgpu_device *adev,
--
2.7.4


--_000_BYAPR12MB32851E367C4D553AABB13BB7E4FC0BYAPR12MB3285namp_
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
<div>
<div id=3D"Signature"><br>
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhu, James &lt;Jame=
s.Zhu@amd.com&gt;<br>
<b>Sent:</b> Monday, March 9, 2020 12:57 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Koenig, Christian &lt;Chri=
stian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for=
 vcn start</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Fix race condition issue when multiple vcn starts =
are called.<br>
<br>
v2: Removed checking the return value of cancel_delayed_work_sync()<br>
to prevent possible races here.<br>
<br>
v3: Add total_submission_cnt to avoid gate power unexpectedly.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 2 &#43;&#43;<br>
&nbsp;2 files changed, 17 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index a41272f..6aafda1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -63,6 &#43;63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;ade=
v-&gt;vcn.idle_work, amdgpu_vcn_idle_work_handler);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;vcn.vcn_=
pg_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;adev-&gt;vcn.tota=
l_submission_cnt, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
@@ -210,6 &#43;212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)<=
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
@@ -307,7 &#43;310,8 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fences &#43;=3D fence[j];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fences =3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fences =3D=3D 0 &amp;&amp;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; likely(atomic_read(&amp;adev-&gt;vcn.total_submission_cnt) =
=3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STAT=
E_GATE);<br>
@@ -319,13 &#43;323,14 @@ static void amdgpu_vcn_idle_work_handler(struct w=
ork_struct *work)<br>
&nbsp;void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool set_clocks =3D !cancel_delayed_w=
ork_sync(&amp;adev-&gt;vcn.idle_work);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (set_clocks) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CN,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;adev-&gt;vcn.tota=
l_submission_cnt);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;ade=
v-&gt;vcn.idle_work);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;vcn.vcn_=
pg_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_=
state(adev, AMD_IP_BLOCK_TYPE_VCN,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_PG_STATE_UNGATE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp=
; AMD_PG_SUPPORT_VCN_DPG)&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state new_state;<br>
@@ -345,11 &#43;350,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring=
 *ring)<br>
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
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp=
;ring-&gt;adev-&gt;vcn.idle_work, VCN_IDLE_TIMEOUT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(atomic_dec_return(&a=
mp;ring-&gt;adev-&gt;vcn.total_submission_cnt) &lt; 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; atomic_set(&amp;ring-&gt;adev-&gt;vcn.total_submission_cnt, =
0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index 6fe0573..111c4cc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -200,6 &#43;200,8 @@ struct amdgpu_vcn {<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tot=
al_submission_cnt;<br>
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
</div>
</body>
</html>

--_000_BYAPR12MB32851E367C4D553AABB13BB7E4FC0BYAPR12MB3285namp_--

--===============1557656893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1557656893==--
