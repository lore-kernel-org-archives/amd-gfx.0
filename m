Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ADAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFDD221F8
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zL12YHEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFDD221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512C96E03B;
	Tue, 17 Nov 2020 16:12:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA66B6E03B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 16:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGY/jLJOSKnrbwUHRwTPBFA51uAQ1sNxYbaMAt24zf+QIhbEYqKAC/ws6e1iJD/9fAEkw970tfb/W5iAAP9JbLG/HpbPXjZGc16Mk2v49xDgPc7LwdDo7m7CZIbOVVC7tPuZQ9WZ5B5ykrhNgpvPIsBHrJKfiABwovRsh8Zr20x2iF+Ao5CvrLG5blBsjTDS+KSg5b456fTLD1dVQwemjGolTgsk7PSeUDm4N3R0iLK29kE/Bl140AnR523FA828ouNPAh187dMB7MzaWSJRXuwojGJe++zJ/6E/ocj+9x586uKIvl7G5/nIzlc4bD7n/4kcZ1gei0QvmZXCiwdoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67UOXBcibBP7FhEUmHI6otGi4oZj7tO2tWKh6611BkE=;
 b=iYXF2u9+OSmBg3A2BULXV7YKBToOt+DwMyGzIr07xCUDk3c5kqFmvmUoxOcqzrU3w6uzP4BThSIKFE+7JjeniN3JyqAkidWrwn4a8T0/1xXa/SM1M0bbnzMz5/vchxK1Rgno0NLfgIuc+GL8uRNoefdxyqASJBkLADP25cOJY33p19L0LP5qzPhGcLkiNsoaijrskyE+lEvEiBdoABpLTP49rSLWXRAXMbuM5iDygsGv7RdkCof2rzczExDd5InbS9d0pH8lxsAAneykUMNMtp4AonAvYt1e0eBoFnLZ32w7/BPKisIsJBrUQGXbLIn/D1q/AL6lkh5q3qu8nZPsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67UOXBcibBP7FhEUmHI6otGi4oZj7tO2tWKh6611BkE=;
 b=zL12YHEJRJS7aeRvMUxlTIZZlTuZ0/7/p/eXXqdiMsPI0o1OwSoG1KA87y0QPe+k3EZj4FAn0ijCBsvB/NSFyw106hc1mbifH8c2PmXV+2MHRaWo9EOYdDlLDuuBfu1vUn+vlwwsVnqauVfWVzJCGWFH95V+2oIFY9SXTgCpTks=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 16:12:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3564.030; Tue, 17 Nov 2020
 16:12:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: support runtime PPTable update for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amd/pm: support runtime PPTable update for
 dimgrey_cavefish
Thread-Index: AQHWvLPobbNB1982dEadky5EInuMOqnMf3XM
Date: Tue, 17 Nov 2020 16:12:35 +0000
Message-ID: <MN2PR12MB448886EE910280B85FD7ECFEF7E20@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201117073240.10777-1-tao.zhou1@amd.com>
In-Reply-To: <20201117073240.10777-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-17T16:12:34.832Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adb37e6d-b281-4b95-e117-08d88b1398ab
x-ms-traffictypediagnostic: MN2PR12MB4174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB417434A24FDF24E368C61E4DF7E20@MN2PR12MB4174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkf88HJKGE/TzcCBlRgNVJ6l13Saw5UurYSYliiIq7a5aSUtxpA2QmFgIwEI6XXXE5aaZQIOYXgmp7tzqjXuqkJDHJOV6rdmk9pzd7iqw7W+dV4LtNKt1CcqmSAOKnyfY3C4spAfZvM4ZdPXusIvCp9aC9aV3ELWZqhzYACyRQRqfDFeQ43lGPJt6sK5iNy92zA8K+2rxxiCZtE/TALZHjtCKQxN49xNpy5m+weXCi8qh9sm9L9HKd5xLmPl0dQYDRxoqNULX9fx3H50DY4geHdVEYWSvD8/Kw+snMOiA01hShVhcgyN1LehxoleDCTwfnm/EjRZhv+PzKKNjMuFXvaFGn7Lv+Y/2NvKowNlmZc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8676002)(86362001)(15650500001)(2906002)(110136005)(166002)(316002)(55016002)(19627405001)(9686003)(186003)(52536014)(966005)(26005)(83380400001)(66946007)(76116006)(478600001)(64756008)(66446008)(66556008)(66476007)(53546011)(45080400002)(8936002)(33656002)(6506007)(71200400001)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +mXN0oSh1k28QQ+o/5JOp1b3ZQQEL+G6MrUO9pn8f/V0UySnh1aujRGpXWOeCem42sKmntrsbZu+UpFvgxwQqF/HWS3QHsZqETwEaPq1dxmRaUCMe/OGrnAh7o/yQ5ard7AJop/izIGaUJ+s95YBOy/ghMq+As2YUb13eKE/9cRdjMiBrPpKGRYzdGi5TMKJapD8rEH0A/660N8NXjrjMjfctOrD4n1UGVNSf6fSf2tgwCjGycS7kRrGtGQeFvV0awNFhI4NhAfH1D1Fpf0g77b/O7fRt4Ctnn65TrIFjn3rdOQnZ7Un8vDRi4z0GT+Z+MDtl7Ng12sO9ZQA0G6m7rCFnx8U1HSxxhjYPy4JjaZ5NxJKo6xc7qwmyvaW40V5pRCNr3x2vR+oqLYBghv4x8aM2JAb6V0QjYNLqdpcjcviBj/EjklgZEESelVPokZp/jCFTAIgllMHZTfTtmztnUynMdEbh6iLZ9fFm2QxnyIF8RX+Lk0OXzcgTD9k/Q3Qd1mgMFV7wPP6C/ITkr8wzR6+QOfLs6DGwXW12bgLfrQhoszrXcgaPNUBiBfsC4TPjvH1c1ygs+lwVydZjaCnBF07u1yMFKJPfxxLAwHCGApRYrdoU5YtsrYW7lVeHZ1wZhpBe7LLvfhMGoIltUQe4j1F9P/RQtK0ktYjun7PBsumf/32gTKnx3X8EZJNQbQaCMpgKIgH7WH0XgZ1ClTpJlk4bhCAXEDxt0qv25Z/i26c4eAdD5ROpfgGP5nSWr6Ot3y7Nk+tP1z2l8ggpaJ5PxGYJRA3885dx9IXL7p1gX1QR3ZqxyagRJIi6xtU8HGNrjw6csgD/GrydxfzCNYiDfi/aC6mWCptWMcQTg2lsS76k6eH830wzz/OvVH5GQ5oI5qGZkyagUYjERtO8aC0Dw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb37e6d-b281-4b95-e117-08d88b1398ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 16:12:35.3213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/1HIohpYF988JrV5humrSMwjr35fDVxbh0XHm0of72JW+0eJksciQun7OaRjFClvaz+JQNgCj5qD5z0JlOUfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Content-Type: multipart/mixed; boundary="===============0618390358=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0618390358==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448886EE910280B85FD7ECFEF7E20MN2PR12MB4488namp_"

--_000_MN2PR12MB448886EE910280B85FD7ECFEF7E20MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Tuesday, November 17, 2020 2:32 AM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime PPTable update for dimgrey_cav=
efish

There is no need to reset DPM for PPTable uploading on
dimgrey_cavefish and PMFW can handle it, same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..8e3e7a5bbffe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1183,7 +1183,7 @@ static int smu_disable_dpms(struct smu_context *smu)
          */
         if (smu->uploading_custom_pp_table &&
             (adev->asic_type >=3D CHIP_NAVI10) &&
-           (adev->asic_type <=3D CHIP_NAVY_FLOUNDER))
+           (adev->asic_type <=3D CHIP_DIMGREY_CAVEFISH))
                 return 0;

         /*
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C8cf0d1af536d4d6349bc08d88acb08f2%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637411951942273028%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DUuQ66twRM2QL%2FTXOhEmkjfHH28p96lfLfL5qxJeQG9s%3D&amp;reserved=3D0

--_000_MN2PR12MB448886EE910280B85FD7ECFEF7E20MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Tuesday, November 17, 2020 2:32 AM<br>
<b>To:</b> Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Gui, Jack =
&lt;Jack.Gui@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd=
-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: support runtime PPTable update for dimg=
rey_cavefish</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There is no need to reset DPM for PPTable uploadin=
g on<br>
dimgrey_cavefish and PMFW can handle it, same as navy_flounder.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 1904df5a3e20..8e3e7a5bbffe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1183,7 +1183,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;uploading_cust=
om_pp_table &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;asic_type &gt;=3D CHIP_NAVI10) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asi=
c_type &lt;=3D CHIP_NAVY_FLOUNDER))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asi=
c_type &lt;=3D CHIP_DIMGREY_CAVEFISH))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C8cf0d1af536d4d6349bc08d88acb08f2%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411951942273028%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DUuQ66twRM2QL%2FTXOhEmkjfHH28p96lfLfL5qxJeQG9s%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C8cf0d1af536d4d6349bc08d88acb08=
f2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411951942273028%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DUuQ66twRM2QL%2FTXOhEmkjfHH28p96lfLfL5qxJeQG9=
s%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448886EE910280B85FD7ECFEF7E20MN2PR12MB4488namp_--

--===============0618390358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0618390358==--
