Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209FFC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 02:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8D7206E0
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 02:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GH/22CHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8D7206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6DF6E56D;
	Tue, 10 Dec 2019 02:45:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D19D6E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 02:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiSlbVI0C5kEw2bEGWTk2axA7gH7tO6OdmkL1BJtdVWcTX5Oz4DEN9THo0M+hteGbbhS5vtWvTJPICW5iI2urhfmdX58oAtSqaLpZkOK+ItEoYp7V92C2C5fwyfxxOdlmAE955DCyvVZ8Lux5swpDMjkiQito6QicwFIFWeddw5xyS53BAUG5GYNULSXI/cOCnuFpywnA2Iox2r53M/TP+SZafCam/dlHVdIWr03z4EZXX5+TfcvzryMOGJDoBjLSTpuNhqeaTW9jJgt5OxFmutytfSO6qo6OO0ZJ3bV0PBt5P98XQVdASX7nm8pScaIg/jh6lvwZMVYrQXaHIdNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M7ZN6Jp7b+3GSaHMOjrZ9mhhv9wmmIWMgVMUNI+lNI=;
 b=oR7oIX1dB1lXdaLn+2XtAS7gsWr2w9a9+EkXUIOTxnNCnBmLZbVKSIuLWrsgQMS7U2QZ5fpBAur82RlwNcQf0sKEpBWWxu765tdWHTZhwkiu5MIW6zHYnCT9osBoe4PwgKL1B4fNyyWiOVer1fejAvDqPk4W4IdLI1ds/0lVsh0esF9ux4iwPjgFyaElMMSuirU6vcncvzKxUtVWGs3Eu/i3bJ+gf/hJZfqZ4E6SSlrJfEjjXqMz2+S/PAnudzjvDoVUwB1pQctQ4e+hC1WuHPxA6UrfD/t1hXOMhUq6y41LaSFjPCNou0M548NwJf4qs+gN0XhYaoXn2ItVTps7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M7ZN6Jp7b+3GSaHMOjrZ9mhhv9wmmIWMgVMUNI+lNI=;
 b=GH/22CHqXAJg/SU1DS3Wzf6tQWNZGi/koFs/nh3fQ+/nqOGvwCA6bWl/WN6MOVHo7QPk126xilgfIFy0f1dgyMZ/LtkKTC6I1IxBZu8KdXyTRtNWYDKaRJA8k9GWceU/UjGUwi2S5GaTVeITbdV+cs9/H1bauCQGOwj77c0JxAI=
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 10 Dec 2019 02:45:34 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 02:45:33 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Topic: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Index: AQHVpQNJI33CWgVjAUaqRB+BX0VW26efKZkAgAETysCAAhrWgIAEZr3QgACwIQCAAMiIcIAAkXkAgACckSCAAMmfAIAAsiLwgALS/QCAA/l1oIAAWV0AgACwm6A=
Date: Tue, 10 Dec 2019 02:45:33 +0000
Message-ID: <MN2PR12MB4285B04000E228E467F8004BF65B0@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
 <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
 <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
 <a38e95ac-ca7e-20fd-0c2a-4d4310e8599a@amd.com>
 <MN2PR12MB428581A895E0C2B26542CC1DF6580@MN2PR12MB4285.namprd12.prod.outlook.com>
 <b44fcb10-d1ed-c93a-8010-5b62aae74545@amd.com>
In-Reply-To: <b44fcb10-d1ed-c93a-8010-5b62aae74545@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-10T02:45:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ba116132-b01e-4cc6-ac6f-000055be3a88;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-10T02:45:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 630723b1-4ad8-4f6e-a90c-0000cd4d0a34
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Le.Ma@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da8db881-b79e-4bf5-9f3b-08d77d1b0781
x-ms-traffictypediagnostic: MN2PR12MB3743:|MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37435B5D65B67AE2341C5E02F65B0@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(52314003)(7696005)(316002)(86362001)(55016002)(6636002)(71200400001)(71190400001)(2906002)(53546011)(478600001)(110136005)(9686003)(76116006)(26005)(5660300002)(4326008)(66946007)(186003)(66476007)(229853002)(6506007)(33656002)(81156014)(81166006)(790700001)(66556008)(8936002)(8676002)(64756008)(66446008)(52536014)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3743;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0WQ/lGA53lts0qY1s2WiLSPKkhmxlzyZblWuWk4iMOKz9+suvW+YEFjPVMglN3pVM2A5s/MF/p5LFhSK1CwetghZ1uPr5MlcqPQ1WOL8TgdHIPnLvqtmissnKdMFXi2Pa9VN0sv+b4a0JON6b5EePIj5ldBdooFEHlRg1uBpDTWQVKEmEpijQDZ+JMJNzi8Q1o5HSHU/XFjKS32gWn++i75TSRg4CkWnYJC0nSeCSXe2+DKDy3+V+OrIOp7rrsZrjwxFpuuCXRW+ulUXg+tFTG5jXDH2su9R2n4E6BRGnNCCoJy4NIlnk55KTgwcyxLvusqPrCeZ2pPPj8mUbRh9XRyok/TTO5zU2vtn8xeRFqPxgieIKyyi2Wohu0JwaPlMp2VSYEEla7uB+/FG5sQ1WLJ9I2iJrRShTw0AJBrhpbQLbxX6t20I8QaTPgHRc0G35U4w1nVFXHNHTvb8vJkf5sEwK1DYxgei37s2fyvpHLgpkinAuBcETW0NOoHFcfmDfsLWb499QSX2qOh17t72g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8db881-b79e-4bf5-9f3b-08d77d1b0781
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 02:45:33.7498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cRQp6v+qHQertS0GH5KylnMAhWq3odQmhjt7/HhTHmBdfCIIHnZhfCGx3jJW2WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============0174592505=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0174592505==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4285B04000E228E467F8004BF65B0MN2PR12MB4285namp_"

--_000_MN2PR12MB4285B04000E228E467F8004BF65B0MN2PR12MB4285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I'm fine with your solution if synchronization time interval satisfies BACO=
 requirements and loop test can pass on XGMI system.

Regards,
Ma Le

From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Monday, December 9, 2019 11:52 PM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.=
Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis =
<Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI


Thanks a lot Ma for trying - I think I have to have my own system to debug =
this so I will keep trying enabling XGMI - i still think the is the right a=
nd the generic solution for multiple nodes reset synchronization and in fac=
t the barrier should also be used for synchronizing PSP mode 1 XGMI reset t=
oo.

Andrey
On 12/9/19 6:34 AM, Ma, Le wrote:

[AMD Official Use Only - Internal Distribution Only]

Hi Andrey,

I tried your patches on my 2P XGMI platform. The baco can work at most time=
, and randomly got following error:
[ 1701.542298] amdgpu: [powerplay] Failed to send message 0x25, response 0x=
0

This error usually means some sync issue exist for xgmi baco case. Feel fre=
e to debug your patches on my XGMI platform.

Regards,
Ma Le

From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com><mailto:Andrey.Grodzovs=
ky@amd.com>
Sent: Saturday, December 7, 2019 5:51 AM
To: Ma, Le <Le.Ma@amd.com><mailto:Le.Ma@amd.com>; amd-gfx@lists.freedesktop=
.org<mailto:amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com><=
mailto:Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><m=
ailto:Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com><mailto:Den=
nis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com><mailto:Hawking.Zhan=
g@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com><mailto:Guchun.Chen@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI


Hey Ma, attached a solution - it's just compiled as I still can't make my X=
GMI setup work (with bridge connected only one device is visible to the sys=
tem while the other is not). Please try it on your system if you have a cha=
nce.

Andrey
On 12/4/19 10:14 PM, Ma, Le wrote:

AFAIK it's enough for even single one node in the hive to to fail the enter=
 the BACO state on time to fail the entire hive reset procedure, no ?
[Le]: Yeah, agree that. I've been thinking that make all nodes entering bac=
o simultaneously can reduce the possibility of node failure to enter/exit B=
ACO risk. For example, in an XGMI hive with 8 nodes, the total time interva=
l of 8 nodes enter/exit BACO on 8 CPUs is less than the interval that 8 nod=
es enter BACO serially and exit BACO serially depending on one CPU with yie=
ld capability. This interval is usually strict for BACO feature itself. Any=
way, we need more looping test later on any method we will choose.

Any way - I see our discussion blocks your entire patch set - I think you c=
an go ahead and commit yours way (I think you got an RB from Hawking) and I=
 will look then and see if I can implement my method and if it works will j=
ust revert your patch.

[Le]: OK, fine.

Andrey

--_000_MN2PR12MB4285B04000E228E467F8004BF65B0MN2PR12MB4285namp_
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
	font-family:"Calibri",sans-serif;
	color:black;}
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
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">I&=
#8217;m fine with your solution if synchronization time interval satisfies =
BACO requirements and loop test can pass on XGMI system.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Re=
gards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Ma=
 Le<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@=
amd.com&gt;
<br>
<b>Sent:</b> Monday, December 9, 2019 11:52 PM<br>
<b>To:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zho=
u1, Tao &lt;Tao.Zhou1@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher=
@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhang, Hawking &lt;Hawk=
ing.Zhang@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>Thanks a lot Ma for trying - I think I have to have my own system to deb=
ug this so I will keep trying enabling XGMI - i still think the is the righ=
t and the generic solution for multiple nodes reset synchronization and in =
fact the barrier should also be
 used for synchronizing PSP mode 1 XGMI reset too.<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 12/9/19 6:34 AM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Hi=
 Andrey,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">I =
tried your patches on my 2P XGMI platform. The baco can work at most time, =
and randomly got following error:</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
12.0pt;color:windowtext">[ 1701.542298] amdgpu: [powerplay] Failed to send =
message 0x25, response 0x0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Th=
is error usually means some sync issue exist for xgmi baco case. Feel free =
to debug your patches on my XGMI platform.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Re=
gards,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">Ma=
 Le</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext">&n=
bsp;</span><o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey
</span><a href=3D"mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@a=
md.com&gt;</a><span style=3D"color:windowtext">
<br>
<b>Sent:</b> Saturday, December 7, 2019 5:51 AM<br>
<b>To:</b> Ma, Le </span><a href=3D"mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com=
&gt;</a><span style=3D"color:windowtext">;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:windowtext">; Zhou1, Tao
</span><a href=3D"mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a><s=
pan style=3D"color:windowtext">; Deucher, Alexander
</span><a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@a=
md.com&gt;</a><span style=3D"color:windowtext">; Li, Dennis
</span><a href=3D"mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><s=
pan style=3D"color:windowtext">; Zhang, Hawking
</span><a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&g=
t;</a><span style=3D"color:windowtext"><br>
<b>Cc:</b> Chen, Guchun </span><a href=3D"mailto:Guchun.Chen@amd.com">&lt;G=
uchun.Chen@amd.com&gt;</a><span style=3D"color:windowtext"><br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p>Hey Ma, attached a solution - it's just compiled as I still can't make m=
y XGMI setup work (with bridge connected only one device is visible to the =
system while the other is not). Please try it on your system if you have a =
chance.
<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 12/4/19 10:14 PM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p>AFAIK it's enough for even single one node in the hive to to fail the en=
ter the BACO state on time to fail the entire hive reset procedure, no ?<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:12.0pt;color:#203864">[Le]: Yeah, agree t=
hat. I&#8217;ve been thinking that make all nodes entering baco simultaneou=
sly can reduce the possibility of node failure
 to enter/exit BACO risk. For example, in an XGMI hive with 8 nodes, the to=
tal time interval of 8 nodes enter/exit BACO on 8 CPUs is less than the int=
erval that 8 nodes enter BACO serially and exit BACO serially depending on =
one CPU with yield capability. This
 interval is usually strict for BACO feature itself. Anyway, we need more l=
ooping test later on any method we will choose.</span><o:p></o:p></p>
<p>Any way - I see our discussion blocks your entire patch set - I think yo=
u can go ahead and commit yours way (I think you got an RB from Hawking) an=
d I will look then and see if I can implement my method and if it works wil=
l just revert your patch.<o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:#203864">[Le]: OK, fine.</span><o:=
p></o:p></p>
<p>Andrey<o:p></o:p></p>
</blockquote>
</blockquote>
</div>
</body>
</html>

--_000_MN2PR12MB4285B04000E228E467F8004BF65B0MN2PR12MB4285namp_--

--===============0174592505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0174592505==--
