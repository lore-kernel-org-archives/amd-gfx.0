Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE11C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47535221FC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0o1Cqfq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47535221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A8D6E880;
	Wed, 21 Oct 2020 07:19:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301616E880
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 07:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0WcKbriXrMg2fi5V0nlUPx9clE6XWrlIvnRYMPRCgiDUcNB05n6v1kevNUP+muEdRpbmk7PjruSxTwIObUO8Pl9Kt22Tdf0/jNu5+rSKc5TDySyNu7wkNAOkiBjK3TX48/V+B9EhQ1eIo7ZmoFHg2Gl8sISvMkXVyjSn3vWplCAsbzqh6KdOd5S5NTiYdNvRrxxbq3G5J7wW3gdezDBx9nUbi420VGoFhfq4bI/ZdTUOsa417vGylBC+1JqjlgQOZRbQ3N4LvCkeD+dvOenQg3m5TgdwXeuWHXuueJ0/xLypZa7dST9UHC0raGEQ4+lfRlJJdxj+oCB6xI7trfCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhlbLDBciq1oJW3DHalaXdXg0S0muRajheIfw4wY5Ok=;
 b=Yuy6PHedcZVL1g1Ms+LTU+ugKH/KlGo4PdIEBrJ67H8NusFOkiPyTlltHPp7gbfVYbcEtlCpvDjC5ryvjSImz/klkvwFq5LBv565pRk2SqstO8B8PidIlkzAfLhY8hzEpxGGjKlF96H/kh2IKlobSy3dASeII4khGeYB6iCGkrOKdA68YGAsIHu2sO9vU17NSs4OWBwLwwUc1BB5fiV5Y1o5IhJ1FPDurh2vSL9IuNSRFs/zPv0mREF4FWyuZ5VdDekS88EAaljSBbo+oqljFeuE3NsplSMJBrv1fSh5OgzX6GMZmJhhXHlDatvbdxXfpKjguV+vVTZgtF6wQgCP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhlbLDBciq1oJW3DHalaXdXg0S0muRajheIfw4wY5Ok=;
 b=0o1Cqfq1YvBSmQONZz9NI+aUkjw0TBSk+UgSrHvMa+5jKz0bvzy9YyaZgSpJPoiaj7JTSm98Fly3c7PXuTTsJIA/dsntElQ7WAebHln0lxHyOOvK15zY+e8gSMMVcN0GssiABaVd/FcW+rk0O1vZpUC3zwxeKkpvLJX6hJOUdqY=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 07:19:52 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63%6]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 07:19:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: disable sienna chichlid UMC RAS"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable sienna chichlid UMC RAS"
Thread-Index: Adanemidh5YoVxbJQ6i2phnmijiWag==
Date: Wed, 21 Oct 2020 07:19:51 +0000
Message-ID: <MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-21T07:19:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=462d84f9-47df-4b50-b24d-0000f95587dc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-21T07:19:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3e4da0bd-90b4-4bea-8651-00007ea65258
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-21T07:19:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0651902b-99d5-40b0-a1ac-00000b7e14d5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c448466-cdfd-4b50-0c5e-08d87591b3c3
x-ms-traffictypediagnostic: MN2PR12MB3855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38550CC9877718BB57B17758FB1C0@MN2PR12MB3855.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXiv19hCvGUcZWLByydagHUB8UWtrHwZE/je0V0lsnB3IS3tLY8kfC1lC9sykdFVe+aMcS1AQ0WJvf0h+IAG7SBJKa81E7D8OzF+HFnfSm2HllGDKTF7fNupl3lCZPEZp4mI1bCsDYkbZQA7UODWcXk9qar03D5b9bxvUBlwRp5eHCeODQULQASRvkSMKu/HaEs/6Iyt1/B8uxVPbHgqC//xCF22XmdQfrt7PypHgQPNOL11aQfnPziZgmJjYzhkGtKjmlj6ug4s9DiiuObmI9ZRTHpgCpKgBJjEAMFTMNvmICf273w2n89gRcNVovN0d7V6I1/LWoglkYJHDcTRcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(5660300002)(9686003)(6506007)(478600001)(558084003)(8936002)(66446008)(66476007)(66946007)(64756008)(66556008)(76116006)(26005)(110136005)(71200400001)(33656002)(52536014)(186003)(2906002)(316002)(86362001)(8676002)(7696005)(55016002)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dYTQXAA6vp0JFNwaF1XC4UPQik3PBABCOsPO5QeLxbI8fGreVHzemxPKdrGYAeG5xYwH6ywgT9uILmdlMQ7zpODr0XA1zVRfPcq+V2Pe/wvdiJ1QeRESuqaLDokVecJD2AM9NczWV440OlndqgwcP3aCXWqJVcPhXINB/hWqLXp0v3nPH7UG9yBDcwvyOd/MwJT1ljPb0dpNeQAYB3/3uW84SsFvL1QSm0p7VBW412hbfGAj+GlGoloefb2ww6quaDpVXY2ofboeAa7yYc2g6DS91RigHTVa62UhKduulG+MMnjb24qJmtBLGufhNgbxqQC4alvcG+SrmqFsBgizD0zpjzgAAgLlW3nIfeK1RwAUfHvWYvJpUy6pdpei3y/eLemQd2SRp+U+0suU0rwuEYy5SiKZOuXsLW4Wfrbnql9sktmgr15MK6O21K8TPvZoBY73EvKM1DjOKUJkqu6BKUlGmYLGffbH5N79DfQE0CZyD7JvM75tSUBN+qKMJZ7k7Our2E3kF11x8Dg+py0WgDGRUmmgtubTymTFZJGzN7U9UkgHidgCtVLGVqE6E41fZEukcvSKf5QumuN6S37E5xb99lNF05u+YQYYPkSjX6sU5Wj7/JYQEtu+YTp/9v0xl7ZTq5v2LnkuEuWDn/Nxsg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c448466-cdfd-4b50-0c5e-08d87591b3c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 07:19:51.8218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id/h5TAVR/OJAFqXd2Y0PuNCa2W943VWxzmBmdegO1qHW8IXWDJmrdTNgwt2lZkIjcZxLfVVXz47STIIscFLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
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
Content-Type: multipart/mixed; boundary="===============1084709692=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1084709692==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Revert change to disable UMC RAS for sienna chichlid

Thank you,
John Clements

--_000_MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0MN2PR12MB4032namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Revert change to disable UMC RAS for sienna chichlid=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0MN2PR12MB4032namp_--

--===============1084709692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1084709692==--
