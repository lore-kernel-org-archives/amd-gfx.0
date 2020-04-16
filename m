Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BBC2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 17:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07242078E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 17:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PYIqC9iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07242078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E526E4E3;
	Thu, 16 Apr 2020 17:10:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BF06E4E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 17:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+/+l6FTyjGl0XzqUp5H77053twDAM+pakvsJ1XR2ZeVmTVUwp+gGH8LXrmdFAMliNEd7A0F1TPaekEhlHLunR0UEOwt5dS/xapZmSvHrVM1W1VTmr4xGT7sstkT+WXNoa0XUBIoTmoZgDjxWzomVnAZFU6Tcp8zzuwmdcpDyItVBKZxbXkvF2MrvuBkHeQV+7i01B0EJgmBURQ9cPY0yZM6Y6S1xuRpYtLvOKeF9EU1kxPVGEC75YxwW8MMNbFOfdnKqwzZgu5p0aKtFX6aIaFOFeIhYzrMgmAHUIY0qgOgSPgEyjh0OV5EDVXzd+4Rq9XHbWRdqGrdLHD0m0KlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM4gKOTX4GL8DPCwVf8AcNVze6AHugB62jKdQN5SJ5I=;
 b=oFLD9NMTXAde0WKha/SPkO6glXZItx4CQ8RRd/CgexkSIX3e1B3mA1St0YhCnAp0oy7SREnBXRVEUqmrcCvJ09Q56Gova7ALh9plOdYb3cTbKbwIsHo9AS+H3d2sAjZHPBEIKH+me+qlEB5sajPCPb7ALm0N/4VG42Wihhm6K1Apo3O+z05XkgvksOtyDJeLxkeY1FR9lyHVvPGO2IF5l3TXT10m+sr9t/J1qjeJDz9S0011U306Mz3SCvfqBjn6LurE8rrtNh4tQ2Uvz9PkXjsVXAd/yXZfOCb4m0ATcd4OVEcvk5aZk+EQcohsuGG/FzhrgPE22qjEG7sdgoB2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM4gKOTX4GL8DPCwVf8AcNVze6AHugB62jKdQN5SJ5I=;
 b=PYIqC9iqXwdMYRCConfMybtsuVRprCbWwDGA9v2tXbIGVBN+miexf+EI6B8GnHojISeQbbYWmVGV/MprewxMAnF1RIH/DoxzeyHnkthabJpvpKDeI2ZLYMytEblB+d3MLhmUl+TWIlXrkcWz4Nimp8+mul0tvKe9/2/jOz7qvMw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 17:10:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 17:10:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: Disable gfx off if VCN is busy"
Thread-Topic: [PATCH] Revert "drm/amdgpu: Disable gfx off if VCN is busy"
Thread-Index: AQHWFAu9Ibg2qGE5AUOhsAcBjqh34Kh7+6dB
Date: Thu, 16 Apr 2020 17:10:42 +0000
Message-ID: <MN2PR12MB4488D6567A8CE6E120470657F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1587054298-8076-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1587054298-8076-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-16T17:10:41.302Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.190.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bec3f00-35cd-473d-c496-08d7e229181f
x-ms-traffictypediagnostic: MN2PR12MB4389:|MN2PR12MB4389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4389EE1D223116C0633F97ECF7D80@MN2PR12MB4389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(19627405001)(9686003)(4326008)(81156014)(8676002)(5660300002)(86362001)(55016002)(966005)(478600001)(71200400001)(76116006)(26005)(7696005)(66946007)(6506007)(53546011)(110136005)(316002)(2906002)(8936002)(52536014)(45080400002)(66476007)(33656002)(66556008)(64756008)(66446008)(186003)(357404004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEM1Fe6gwsY194bG3iL3VaRhCRpbiRFvwGeuXz1t5KeZpgaFNFOS7TsGByR1toHhL2MlvjK7+c056OKwv3hVK0x4HkMvI/N7PVHVS5A5X4qqJELkaahjuXthVXc/4F/gg2ZVOP45K8SIwp2fIauXIBBUNwFFnxEEauXprtNcmarGnMp5cE0PKu724yOjXTBAXegAKdICJX8IFq1MrpG+r/AkwtvgPC9pyZRKMq5jZHaqczdk4tVMmqWutw1V5o1V+S44wZy6ou565FuhecVcNtiQYMC266TYLP+jpHYX8mj/gJKKQ0nTzYB/KLUcLEvfMFIY7esKHVblFmcNclb8ohJEbp9QzVRUcdfO6nSCEX8nHdqBVCVwHuXscRWqRKUmKOH9HMtjeb70p2E0f2kIR8ddJL9LMduI1G6dfa2Oa50q/iPzk73htyo2rvSWJrMYzokRVLgm7JGUg3Ff5qu/gmZqsf2zcgnqwysudHZoqf9je6SGq6TjphC3s4UnrncdzZZ8OmQsa7paVSWd6fMHeQ==
x-ms-exchange-antispam-messagedata: 2XNhe+2+KCrCJQ79jurLGJr8NcsXiZLVt37P/8VyLvW9OvHRiTuhq1qIAAOYG7+6xMGEi0hvxoNflxw5caNuVUkXuegbw4YdllGZ7dykRYKKTbgiqu/I3hFdzDgljHLWf5/QTTldRbpCQVPLDk9ssw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bec3f00-35cd-473d-c496-08d7e229181f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 17:10:42.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMw6In0byWGiWIytddOIdIygyLvML984QswHgk60BqKxFf/TEER974+QGAwdldg6jh2NonGSV66X0Hicd2If8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: multipart/mixed; boundary="===============1965748026=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1965748026==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D6567A8CE6E120470657F7D80MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D6567A8CE6E120470657F7D80MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Is this ok for navi1x gfxoff?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zh=
u <James.Zhu@amd.com>
Sent: Thursday, April 16, 2020 12:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Disable gfx off if VCN is busy"

This reverts commit 3fded222f4bf7f4c56ef4854872a39a4de08f7a8
This is work around for vcn1 only. Currently vcn1 has separate
begin_use and idle work handle.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Tested-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index dab34f6..2de99b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -353,7 +353,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)
         }

         if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
-               amdgpu_gfx_off_ctrl(adev, true);
                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_=
TYPE_VCN,
                        AMD_PG_STATE_GATE);
         } else {
@@ -369,7 +368,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)
         cancel_delayed_work_sync(&adev->vcn.idle_work);

         mutex_lock(&adev->vcn.vcn_pg_lock);
-       amdgpu_gfx_off_ctrl(adev, false);
         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN=
,
                AMD_PG_STATE_UNGATE);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C99bd3d804c734285dd8808d7e222baac%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637226511714024768&amp;sdata=3DGfKFgfaeHLzyDZk00Cv=
V8SvLum3KC4xzYUsBxNVeabI%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D6567A8CE6E120470657F7D80MN2PR12MB4488namp_
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
Is this ok for navi1x gfxoff?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of James Zhu &lt;James.Zhu@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, April 16, 2020 12:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Zhu, Changfeng &lt;Changfe=
ng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amdgpu: Disable gfx off if VCN is =
busy&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit 3fded222f4bf7f4c56ef4854872a39=
a4de08f7a8<br>
This is work around for vcn1 only. Currently vcn1 has separate<br>
begin_use and idle work handle.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
Tested-by: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --<br>
&nbsp;1 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index dab34f6..2de99b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -353,7 &#43;353,6 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fences &amp;&amp; !at=
omic_read(&amp;adev-&gt;vcn.total_submission_cnt)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STAT=
E_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -369,7 &#43;368,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&=
amp;adev-&gt;vcn.idle_work);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;v=
cn.vcn_pg_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_power=
gating_state(adev, AMD_IP_BLOCK_TYPE_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMD_PG_STATE_UNGATE);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C99bd3d804c734285dd8808d7e222baac%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226511714024768&amp;amp;sdata=3D=
GfKFgfaeHLzyDZk00CvV8SvLum3KC4xzYUsBxNVeabI%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C99bd3d804c734285dd8808d7e222baac%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637226511714024768&amp;amp;sdata=3DGfKFgfaeHLzyDZk00=
CvV8SvLum3KC4xzYUsBxNVeabI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D6567A8CE6E120470657F7D80MN2PR12MB4488namp_--

--===============1965748026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1965748026==--
