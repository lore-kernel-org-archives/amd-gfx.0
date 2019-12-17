Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB141C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E39220733
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QqSQT6QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39220733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679236E057;
	Tue, 17 Dec 2019 18:43:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEFE6E057
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 18:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyw+Y27EuNo3Ya+Ax8mXUG2Z/BvBW22oA45TjTej7HPL/DmhCEJqhYyFEpXNKZRP9VgmI3k8P7f+e7ApltZTuWqCupaYfnldtQLRgt7o8DvWILoQ5jp7RdWvgI+4y0HfiYLxBHT/Lnuxa1rdmzPNve+agk3QMtrFLgazebpWOtBgHY04+ZBS5mCW3rnhrM03nsm1b5hQC70/6fuG3N5lciecFPIc9FaPPg8V/uKOz6lMg2e4Ozd1HTU988/EvINXUMy/1z0K9cbuhB/Ihq+fO7Zvm04vLl8EUkMiPKisTUkPDhfH/QNRosHBFVjGdNkcRHXrGKpx9C8e8Yj/k4yo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVVscKM5HIoSiF2dOAvOUoDCOErh41+k6NV4ic+0I9Q=;
 b=kCKgszO7NWexjS5ylAOz7IZ3UdwMjI6hcT3LczZThGAt3cqHd8o74wIW3O1Hbj7Wi8yP6k2YrQEWvwkI9oBTnntSBwp2dbI1aRstB08CscfTpoPq9TkPmb0Y8NMjQfu9YbuNnvug85rwXtgf1SewDQGlHIcGjLHB5GUk9VX0JljUJweDjErzXpZ938tVUJhkprQSVFOQnRxyJzme8uQfhl3oddSVz9PPkANykq8S/HtAWwIIdwYIuLZzZzCcrtM4CaseydWecQ9LAecGaoy0jD5Mw3Abk3UeduJ84xLkQ/b3cqM5yLdzY+eFFRGeznia64ityPEAhfXejkH44/0mIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVVscKM5HIoSiF2dOAvOUoDCOErh41+k6NV4ic+0I9Q=;
 b=QqSQT6QV6pFAfgj5/3oH/f4cHS/6qyTUmkNNUPphAwevx+7pJin7XEuexDGdc8d20fXeg3NN1SAzPo/mOCMVhGo73d0E6dsGOGHGbweM8ya5EU/LC0xgQ5HvRlaxwVhdZBq7OX5N4KRysC8A7cBF2RbA+DoOK+ZNw5A9Rn1pwl4=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3742.namprd12.prod.outlook.com (10.255.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 17 Dec 2019 18:43:26 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:43:26 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/smu: add metrics table lock
Thread-Topic: [PATCH 1/5] drm/amdgpu/smu: add metrics table lock
Thread-Index: AQHVtOoJoUxkdkilPEWmd8WV4gM6aae+qHdb
Date: Tue, 17 Dec 2019 18:43:26 +0000
Message-ID: <MN2PR12MB3296CF1DBFCBBDC58A733CEFA2500@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191217145505.1319348-1-alexander.deucher@amd.com>
In-Reply-To: <20191217145505.1319348-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T18:43:25.654Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [58.246.140.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a968f1e0-bdf1-4d27-fe00-08d7832100a1
x-ms-traffictypediagnostic: MN2PR12MB3742:|MN2PR12MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB374220F9B63012028A295E7CA2500@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(71200400001)(55016002)(8936002)(110136005)(45080400002)(66446008)(186003)(19627405001)(4326008)(81156014)(7696005)(26005)(81166006)(53546011)(8676002)(9686003)(33656002)(5660300002)(2906002)(66946007)(76116006)(91956017)(66556008)(64756008)(66476007)(6506007)(478600001)(52536014)(86362001)(966005)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3742;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZpGHzZfSf81rNXk4e622CO47/jvKOTyWrdEgPgYSJur7RyyRV9NVG6/K0nrHj9F9NPVaJWi5A4BNHg6UUdWOZkRVcz62bX4Y17WSy3v69PUdEM62aHj3Wd2f6lnkn+g2Gk6wZHXBj2+pMNcJka7mwpuSABEw7176OYZ0/gu3bwqfnuqs7fi8jPs8r/w+8jNqkZ5S/1bvsxQw0Po3TGAXaWfzQNFquvFIc8G5LkIqUtzEhviiP/W2vefbQMlGyn0/EhE3KQP1sx2cvJpb3eakLYpYvupWDapXPkdJToPRazsBpVDqSFS8jgWf6LS/udKHxGVWsGcHjKkf163OTe/JXIH6c95+VNXq76o+5OTqqcJ0JwgtNixeonsgC9nocPNOhEDixX6Chhd3NxCS8F3C7Gdi7U9mnNR7ZYCyDMMtChJhzPLtV9SIb0g7GvM+BwBS8CsN+gOkfNBOo3BmJYLIIWyTrgxc3P2cCAsBXmHalM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a968f1e0-bdf1-4d27-fe00-08d7832100a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 18:43:26.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwnPKwoe3hfzDkTSEYP7xc+MSon82Dew1F77mgc7/PC7aHzR4BFFM45uDkNFda+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1052926282=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1052926282==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296CF1DBFCBBDC58A733CEFA2500MN2PR12MB3296namp_"

--_000_MN2PR12MB3296CF1DBFCBBDC58A733CEFA2500MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

the swSMU should be add metrics lock to protect the maintenance data of the=
 metrics table.

The series patches are
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Tuesday, December 17, 2019 10:55 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/smu: add metrics table lock

This table is used for lots of things, add it's own lock.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;data=3D02%7C01%7CKevin1=
.Wang%40amd.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637121913347060555&amp;sdata=3DAz1dOiYWPr%2FJIvTgo35a7=
a9oTnnpCVvtSnA85mgExf8%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 6dddd7818558..6177a6664737 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -872,6 +872,7 @@ static int smu_sw_init(void *handle)
         smu->smu_baco.platform_support =3D false;

         mutex_init(&smu->sensor_lock);
+       mutex_init(&smu->metrics_lock);

         smu->watermarks_bitmap =3D 0;
         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index ca3fdc6777cf..503099f254c1 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -350,6 +350,7 @@ struct smu_context
         const struct pptable_funcs      *ppt_funcs;
         struct mutex                    mutex;
         struct mutex                    sensor_lock;
+       struct mutex                    metrics_lock;
         uint64_t pool_size;

         struct smu_table_context        smu_table;
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637121913347070548&amp;sdata=3DEwWmrrJWWxG14kfkuXeM4YPA9=
odQI2gWyq0iT4pOXCQ%3D&amp;reserved=3D0

--_000_MN2PR12MB3296CF1DBFCBBDC58A733CEFA2500MN2PR12MB3296namp_
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
the swSMU should be add metrics lock to <span>protect the maintenance data =
of the metrics table.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The series patches are&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Tuesday, December 17, 2019 10:55 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amdgpu/smu: add metrics table lock</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This table is used for lots of things, add it's ow=
n lock.<br>
<br>
Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;amp;data=3D0=
2%7C01%7CKevin1.Wang%40amd.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637121913347060555&amp;amp;sdata=3DAz1d=
OiYWPr%2FJIvTgo35a7a9oTnnpCVvtSnA85mgExf8%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;amp;data=3D02%7C01%7CKevin1.=
Wang%40amd.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637121913347060555&amp;amp;sdata=3DAz1dOiYWPr%2FJIvTgo3=
5a7a9oTnnpCVvtSnA85mgExf8%3D&amp;amp;reserved=3D0</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 &#43;<br>
&nbsp;2 files changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 6dddd7818558..6177a6664737 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -872,6 &#43;872,7 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_=
support =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;se=
nsor_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;metrics_l=
ock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode=
 =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index ca3fdc6777cf..503099f254c1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -350,6 &#43;350,7 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pptable_funcs=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sensor_lock;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; metrics_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pool_size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table;<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637121913347070548&amp;amp;sdata=3DEwWmrr=
JWWxG14kfkuXeM4YPA9odQI2gWyq0iT4pOXCQ%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7C4ea0cd2cfad44f285ffb08d7830121d7%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637121913347070548&amp;amp;sdata=3DEwWmrrJWWxG14kfkuXeM4YPA9odQI=
2gWyq0iT4pOXCQ%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296CF1DBFCBBDC58A733CEFA2500MN2PR12MB3296namp_--

--===============1052926282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1052926282==--
