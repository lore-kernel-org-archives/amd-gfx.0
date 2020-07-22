Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7CC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A0920714
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0DE7ExiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A0920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1DB6E5D3;
	Wed, 22 Jul 2020 07:21:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76AC6E5D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 07:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRRcamprtnaXvigxBdb6J7PWLg7lELKOws9TvAPHrWUDJQaa4HpKBBuGnB+qs7XX2wAlC3+G/Fjiwwy+MlxO4UlNmcjvIP/LGU3yHfRofROeGhvno1rVpqAkqmoH0s2h4GjNfJzJf3vW1/vFFjvWbMZD9n5DTN79ZWkFtWxon5b/2024Fkmlk8VN2QQMMf28c+FcDPgXbsrMRl2NlXS0tSF7EodPdrhUkvqFgJf0wwGmxmlzyTW2jwkYZIqyjbH7qHDKrntJIAzWKLlD4EkvqdXXF1peI2Bj82oeBMYLB6/2wz/k217ELeHF04CaL2YHYPkNTOXImNIqAtdW3H9+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3XkwWJdDKlwKm8r1WrqnrEP0ZvHic1GrLrjY4M+7HU=;
 b=V/urdUrIiaohNW8QhyzByAmffzXMy8rEmgkQeBb2e5tBr22D0aMrtksdb3AyeitOH+qxhWz2f0mD4DjtjBKOXlTKxfIsUy2J+FkK6q11QkmPmfILm1nltRbyPKZw5OxVIyihUfJvBbqBwSh8cDXN3ss+S7DpHhsRFVCRf2Y5i4zgkJatwx1jcLhiwtNv4pGBGlvh0SMO7Z09cItfW2IdutFzh6yUibqbPamUxleAA3fOLAJ979F43y2PNCERz1NbZ9TqTgT+u5BvavUSrfBdgu2MbyQ66uCTiENpEatfCUfOu/jPv75XwR3D+vwBOJxpCOBg+VZAZ+GtEG7PPAMx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3XkwWJdDKlwKm8r1WrqnrEP0ZvHic1GrLrjY4M+7HU=;
 b=0DE7ExiMkORrYyz2HuYzuydZfDAQNSO2Z8YcLw0IuYpdnQ5AFtNhn2LYRQiFm3WymgLZTFzcqa8bQrcyT8yiOQx3Zb+WVVl6Qw1h35dfOfSd6J0I+G6Le8XKTpZjlglHSUh0G7IFVHWruQeeMGzl1DkuEJ1e3MEwv3yo4ZmonGM=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 22 Jul
 2020 07:20:59 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 07:20:59 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Topic: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Index: AdZfReQyfeCz96ROS/qexdQQqwQahwACUXwAACpZvlA=
Date: Wed, 22 Jul 2020 07:20:59 +0000
Message-ID: <MN2PR12MB4032884B5B964E3055B5D45AFB790@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <MN2PR12MB4032998A82134DFD3D09739EFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
 <DM6PR12MB407565C7AF933B6B90687F93FC780@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407565C7AF933B6B90687F93FC780@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T10:01:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0ead8133-92be-4bec-a672-0000b76dc115;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-22T07:20:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c6548d2d-7b82-4318-b0d2-0000303f62eb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1441fdb-b92b-4489-7b27-08d82e0fc868
x-ms-traffictypediagnostic: BL0PR12MB2467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2467265AFC4EEC90248A573FFB790@BL0PR12MB2467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCIbNh0rgIgTbKHAeufivvqs8sSyicDUQZ9QNqtEYc0pqa1jIak/VvS8WzQCZcryDia3gJRpu6UenLd1csSI5m42qGaehoKoNa4iKbkqMOtsJIMiXx6/VbZVMP3jKGBmR42gfegogiPfkqdmBE7gKEhOj87ZQmJUlxP4R6qwOfIRLutJMVMxEkYznbYwQr8VJdmUxqXDKLkbaNIUEWtx/iU5FC9aN0L8+CWv3FwKlEZdvQ9NDhwxhzONjsQ3nRTxA2rtHqryJS986iFqyWakBIsLj+kKeQJBGVWDo4Ae6d8phP5D7ezQ10bnObyjHsKt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(26005)(33656002)(186003)(2906002)(7696005)(478600001)(110136005)(6636002)(6506007)(316002)(66946007)(66556008)(52536014)(66446008)(64756008)(66476007)(76116006)(53546011)(55016002)(9686003)(86362001)(8936002)(5660300002)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CUnjaG402V0MR8DjlOgQJY8cqtHMnNUYWI9IeaIJvT/dVsWTYhf7uU6Gj4dp1NyiGVCP1ajmEJA9fYTTqGWaSEFvJo8k2j7ACuUaR1TREwurKYsesdSpmu+EQHt6cRrzXN5zGa9IVTxtQq2xcbmugKXFq2sXkloWHb4xlykGPmpmcjc0Ol7P2IDgI6JomuppGQE8+Wt6f/JSsxxYwyA7oybJLTZ/ZMkwOHfVadG3PmILTnUMYLmQqiQtJCCXD+0PEKQl736JNWyK96iqLvg4lOD02YG5ZeIGho28wWCQapOkU18T6O9fkm+xu5kQlML1hcMYF/EZIskiB4cT+m6vP+GwZmLQbGB+NlD3ACLuOM//Vt+lThLTKoW87k0EBBU6M7JrYgxuB76uqFJblmjqnyG/sNzdMTD7NvLCiTJp2+GrwxPdHvZAsvtfxSwcF6Sqscgdq3DpbqV4MgCC8lWUwRj8wiEUzmyzcoQcEvWuDvoq/CZ/RaS4kgQ7ngNrzVDt
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1441fdb-b92b-4489-7b27-08d82e0fc868
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:20:59.3763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KkCdplYNibYCo2S6L+2h5amVavBhVwH0jvWL4nFLpJvCSuBAwwKDHffIBh2V38TNcJ5ztFvl9RDQhpawi5ZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
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
Content-Type: multipart/mixed; boundary="===============2127078228=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2127078228==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032884B5B964E3055B5D45AFB790MN2PR12MB4032namp_"

--_000_MN2PR12MB4032884B5B964E3055B5D45AFB790MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Good points, I'll reorganize and resubmit the patch after Guchuns changes a=
re in

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, July 21, 2020 7:11 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx list <amd-gfx@lists.fre=
edesktop.org>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid


[AMD Public Use]

-              if (adev->asic_type !=3D CHIP_VEGA20 && adev->asic_type !=3D=
 CHIP_ARCTURUS)
+             if (adev->asic_type !=3D CHIP_VEGA20           &&
+                 adev->asic_type !=3D CHIP_ARCTURUS         &&
+                 adev->asic_type !=3D CHIP_SIENNA_CICHLID)
                               return 0;

Does it make sense to check UMC RAS availability through amdgpu_ras_is_supp=
orted, instead of check specific ASIC type one by one?

Also, it would be good to merge the upcoming logic from Guchun where we hav=
e a gloal flag to mark the availability of bad page retirement.

Thoughts?

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, July 21, 2020 18:02
To: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>
Subject: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid


[AMD Public Use]

Submitting patch to enable RAS EEPROM support for sienna chichlid

--_000_MN2PR12MB4032884B5B964E3055B5D45AFB790MN2PR12MB4032namp_
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Good points, I&#8217;ll reorganize and resubmit the =
patch after Guchuns changes are in<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, July 21, 2020 7:11 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx list &lt;a=
md-gfx@lists.freedesktop.org&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna c=
hichlid<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_VEGA20 &amp;&a=
mp; adev-&gt;asic_type !=3D CHIP_ARCTURUS)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_VEGA20&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; adev-&gt;asic_type !=3D CHIP_A=
RCTURUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; adev-&gt;asic_type !=3D CHIP_S=
IENNA_CICHLID)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does it make sense to check UMC RAS availability thr=
ough amdgpu_ras_is_supported, instead of check specific ASIC type one by on=
e?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also, it would be good to merge the upcoming logic f=
rom Guchun where we have a gloal flag to mark the availability of bad page =
retirement.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thoughts?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, July 21, 2020 18:02<br>
<b>To:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mail=
to:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chich=
lid<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable RAS EEPROM support for si=
enna chichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032884B5B964E3055B5D45AFB790MN2PR12MB4032namp_--

--===============2127078228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2127078228==--
