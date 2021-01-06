Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC77C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 14:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBBA22CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 14:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBBA22CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C2B89F69;
	Wed,  6 Jan 2021 14:15:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA1689F69
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 14:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCBKtYGOooWUDGEKn2TcnaKsOSMBuY331WoIDOdCNPteDs2TcIVUdiLWbURF0mbCaqA4Wa70cbppvVTSupXePyMAIcTXdWJcmpDt/LlEfda1aXuJmGxwrHxDrguUkWdnfyou/KH1xv7LE58O5f7o/A0JU7IHVbbblVdRsS2tVV6Ad0gHKwuRezCcJ9YULoqdZ5Fs+8FsvaerACvJkZJQkH2sCf2XoAQ1RqOj8zg0oYo3b+NdjA8+/+gxYTGeAqvYXGDV7ZIvAsKID9jJIxKZBuR7YQAvX/ZJjaZq+GK7n5D2USb/+i7MhmXfD/1Yv6n29Vr1e1muW0bc4CFB/74ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTB8u1D+PtkQ1gTo7NHv7/xoiApOn5HYYrWa3Q75dFY=;
 b=gvz3PoK80JsRCRWM64d0JclkpWWJMsJbXvu93IFyRC5npU+Eq2tLKHscLFGFg+boa4YwXVPjEqElLZVwL92uUY/5bv/ji3zDl0v2aUYLrogIJQNNRoUv2N3vIFcJAvCvPqZRptk65rTFBf7uP57awhgxPjyVv8LoPOPYeb5IPOUAscFrp60GqkJo73fcVepCNdPHRYpB5Uwt3x9co5Uh7wYeZ7vLeEc57DuSW7RzPx/xZNU4/uTmrQPZ89WmMRRYRdU5EiVRdgvJMbp0ytgYcwhjx79ADG2q4ifR3VD7ouqhnCU/c9R+yAXZZzbbclyjyA9yQofjNPPYolfeuMobGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTB8u1D+PtkQ1gTo7NHv7/xoiApOn5HYYrWa3Q75dFY=;
 b=Aox7zDoRbQzGYiSGuzchGo7RdBdPIFd72G+vTpCFhkpJ7uwLlL7wSfXM2EdCnfeaDLu5Elnuo4nJA8wy6M9qOFqXL+mYSlGv3JfahNezUluo4YLGje3mC76HT0zvkOvcZiv3Sqfivj25bWof2Ov9OSpH0tXh6hRVvacf3HG6Gdg=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 14:15:27 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::5c12:3aed:288:11f0]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::5c12:3aed:288:11f0%7]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 14:15:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: check more client ids in interrupt handler
Thread-Topic: [PATCH] drm/amdkfd: check more client ids in interrupt handler
Thread-Index: AQHW4/MWl6o2TRyg9063zzqEqzwy26oapKnZ
Date: Wed, 6 Jan 2021 14:15:26 +0000
Message-ID: <MW3PR12MB4491ADD3B37568138F45A732F7D00@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20210106061313.4521-1-tao.zhou1@amd.com>
In-Reply-To: <20210106061313.4521-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-06T14:15:25.526Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92048677-c2ea-41f2-1c48-08d8b24d8453
x-ms-traffictypediagnostic: MWHPR12MB1677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB167752146B9E9AA8A097CA73F7D00@MWHPR12MB1677.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RSyBhIP/CjG7FKZ1HfSR8HqCZinHNd9oyr0C5em+FoHQ5LleAHWmiih2ekcQ4AwrOh4STLRGA9gTNlsXO4LQAN8mvcCiB7qfEor5sNMp26Q2j45hP1pUeIKlKuoh4QrsL/PAAmhl/SI4s1Egr1Ef3jgJcUDpJCN2SBiWgUMFhCq/8sggvtSr/aK++KZfmLs85I5CjOTBUnVx1F64v8ccppwT89cc9fy4/PoTdrzWsb6DtqzlGUMfKNauNwM6FepaavF+2U4lxuJGmy0F93x0lJ1PBtms/nZVOIYCER3Ytc8JVrvq0BkYJQiyqJjrHQUPgFAwujhJlXD6c6iwojLSSx9FWmoBlFUpXTLi0ZbAXwoMB0PF02TaLByT3UAvMSiW5VPJ2cIMU08WRN+CMaMBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(33656002)(52536014)(55016002)(9686003)(19627405001)(7696005)(71200400001)(478600001)(64756008)(83380400001)(66946007)(66476007)(8936002)(66556008)(66446008)(76116006)(8676002)(110136005)(186003)(6506007)(53546011)(86362001)(26005)(316002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5RwNem/NgqcSxU1Z3ltbrH7KGsUhLDP/EFIHmY+ZjaOYYiXFYfqMiOR7btkG?=
 =?us-ascii?Q?dzBdsfcfcDq6Qcw/yfrRaK+ChAfe8ZqwRhBl/03bZwSXxi19OmyS2g/XT/EC?=
 =?us-ascii?Q?c+iNrsjbCGpX4N0NKlnC07GbZOoBwcLZw+UG+aY6DF4JnwKctj4NlefuQ0ky?=
 =?us-ascii?Q?PurBlFF8s2gWkf1TJWpWPz7xrPR3mejYqzD0QmQg1j9LEhg89tul9L5/zYgA?=
 =?us-ascii?Q?pX8mKjofZ9yLEBjb9MTD1A5ELOr5OkQkzBt4op6g9GnN8MhUojrXFlq85Qm8?=
 =?us-ascii?Q?8K1sS68KoVfvhuJi+Qka4D9spk3HcZcQ3gjrQJEXEkZ1Z/S07e2+UWOyF69e?=
 =?us-ascii?Q?739CYccbgt50g9s06fsTBxRSU9VjeMO29Frs6UDK62oypqKnbiQ3cdBdtY5d?=
 =?us-ascii?Q?CY27MlCoCnkSFdLAeXkNW9KCFqj8GXFGRrZGFNAconucElO38xLUconMPJ8U?=
 =?us-ascii?Q?JtrfQbOWcPzYZIzvO+5ZD5Diq2CgbBZGikVs7/+O7QIhPJRxAxIXsB8gEV0o?=
 =?us-ascii?Q?0rqexLyDjA34LprBIDxAoMFvYoXcw63L2C88baYcEvNV4HPy1pVCmZC5cboM?=
 =?us-ascii?Q?rXcD0k7w7PjZ/RKTcXTcZdRs8pP65ETdSXy/Kdt7OkOMn6I/cSeuSCX6c/l2?=
 =?us-ascii?Q?WN3Ca2f6QHv3KPam9uWFU1SnOpCncnn/1pFONBWcARRU2BSPXhrpXYQ5eBS0?=
 =?us-ascii?Q?UjPEzxDN71OJEto4RA+CaH3ZFUfgKnL6s2N7v38N/C7U7H3ZamtoPeqBNcWG?=
 =?us-ascii?Q?9PPnJI4nxtD+krGg58fDFeWuvAvQhMWCF5LNVQHjIT4v8kKDKpX7i4F+5ve1?=
 =?us-ascii?Q?gWdEka+aHWkeK6G2kTrtH5g3MtJMevJWPpb6T4DZtzUVD1ugn/BRP0z6lyr1?=
 =?us-ascii?Q?NO5hLh8p/QJqU+ZdQrlWt21BBw9QubUkUrYgGUgv/CL7kZaLB/+EAzQWRRfU?=
 =?us-ascii?Q?cqyuSvSjYrfxE8DRouoAfG3mqZi3ZalxkzFV3xwUIjo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92048677-c2ea-41f2-1c48-08d8b24d8453
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 14:15:27.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4a8NsNr6X6MQ6diQRhx1tRTiagC7wsLqffQJ20tRAsblGtJtIGv51PkxEo3TbhH5wRzegl1WHi4TlA8txbFoyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
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
Content-Type: multipart/mixed; boundary="===============1042705845=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1042705845==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491ADD3B37568138F45A732F7D00MW3PR12MB4491namp_"

--_000_MW3PR12MB4491ADD3B37568138F45A732F7D00MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, January 6, 2021 1:13 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop=
.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: check more client ids in interrupt handler

Add check for SExSH clients in kfd interrupt handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 0ca0327a39e5..74a460be077b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -56,7 +56,11 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
             client_id !=3D SOC15_IH_CLIENTID_SDMA7 &&
             client_id !=3D SOC15_IH_CLIENTID_VMC &&
             client_id !=3D SOC15_IH_CLIENTID_VMC1 &&
-           client_id !=3D SOC15_IH_CLIENTID_UTCL2)
+           client_id !=3D SOC15_IH_CLIENTID_UTCL2 &&
+           client_id !=3D SOC15_IH_CLIENTID_SE0SH &&
+           client_id !=3D SOC15_IH_CLIENTID_SE1SH &&
+           client_id !=3D SOC15_IH_CLIENTID_SE2SH &&
+           client_id !=3D SOC15_IH_CLIENTID_SE3SH)
                 return false;

         /* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -111,7 +115,11 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
         vmid =3D SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
         context_id =3D SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);

-       if (client_id =3D=3D SOC15_IH_CLIENTID_GRBM_CP) {
+       if (client_id =3D=3D SOC15_IH_CLIENTID_GRBM_CP ||
+           client_id =3D=3D SOC15_IH_CLIENTID_SE0SH ||
+           client_id =3D=3D SOC15_IH_CLIENTID_SE1SH ||
+           client_id =3D=3D SOC15_IH_CLIENTID_SE2SH ||
+           client_id =3D=3D SOC15_IH_CLIENTID_SE3SH) {
                 if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)
                         kfd_signal_event_interrupt(pasid, context_id, 32);
                 else if (source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_MSG)
--
2.17.1


--_000_MW3PR12MB4491ADD3B37568138F45A732F7D00MW3PR12MB4491namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 6, 2021 1:13 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd=
-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: check more client ids in interrupt hand=
ler</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add check for SExSH clients in kfd interrupt handl=
er.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 12 ++++++++++--<br>
&nbsp;1 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c<br>
index 0ca0327a39e5..74a460be077b 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
@@ -56,7 +56,11 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cl=
ient_id !=3D SOC15_IH_CLIENTID_SDMA7 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cl=
ient_id !=3D SOC15_IH_CLIENTID_VMC &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cl=
ient_id !=3D SOC15_IH_CLIENTID_VMC1 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_UTCL2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_UTCL2 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_SE0SH &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_SE1SH &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_SE2SH &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id !=
=3D SOC15_IH_CLIENTID_SE3SH)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is a known issue f=
or gfx9. Under non HWS, pasid is not set<br>
@@ -111,7 +115,11 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D SOC15_VMID_FROM_I=
H_ENTRY(ih_ring_entry);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context_id =3D SOC15_CONTE=
XT_ID0_FROM_IH_ENTRY(ih_ring_entry);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client_id =3D=3D SOC15_IH_CLIENTI=
D_GRBM_CP) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client_id =3D=3D SOC15_IH_CLIENTI=
D_GRBM_CP ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D=
=3D SOC15_IH_CLIENTID_SE0SH ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D=
=3D SOC15_IH_CLIENTID_SE1SH ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D=
=3D SOC15_IH_CLIENTID_SE2SH ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D=
=3D SOC15_IH_CLIENTID_SE3SH) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_s=
ignal_event_interrupt(pasid, context_id, 32);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else if (source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_M=
SG)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491ADD3B37568138F45A732F7D00MW3PR12MB4491namp_--

--===============1042705845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1042705845==--
