Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16F6C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B88651C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B88651C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7E06E3CE;
	Mon,  8 Mar 2021 13:16:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E576E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebDPEoT7h8xNxDxpcog8alFZcnakKw6dPk0AI9PBbEX3wVFL6C0OwR+90tR/qqxtXNP5r48w64+4EfFsnlDEt70rZW5Ty51M9npaGuE5n+K+dVTNvva1plYa9x4c3S08xM2JohcVQeILEc9iJlYZ5hRBtpyUnhoTosoRsMUJrHmxzzuiBUl9qMgep3sCYa7mmGHzPfsYouh39r6E0/P8TCPgdbcP/rZR1LmO6VlOiY6nLvSpWf2/moBlMc4TmEucxRMedCcQP2uSkkPLpedBrWnG2jPZGQhHyiZBTXvEHu7ob16+J/b7qfbkjl1D6VXkv7HIanKjA4Tzw0bJcEMppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEcj4C/xOete7jF0ocpMj4aCnHbZxdALcXjU05s6kXs=;
 b=GFt2BLUW4Nchk0cV3A5y5lIH8r+/rRGK22AImGPHbfYgmSReFqlmnoSanRtCHedDcZYzp9MW3CRqncGOSisndcXFoTCiTFLemyVhYMUKeXCJZCa1rM5SD9eWW9edERGld0saol8X+2PwLnQqcBWah+1+0i8bgQKflqvT6FMBi/6S+EznnlJZnETdn3fB4Ak0bQhb3vgAd3aLmTnwnnGTVaWuBu9NXeFCPjvps4WbfdJLtrmfRS8UBE5wkDTy0+x6LbbQNe6r2dmcRN6WG4+MKM0s+1vSL8kRgHr08AaJVE4js+hyMcwqu90ltdGllVr2gW6FSlU1N7Fjjcv8QfMIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEcj4C/xOete7jF0ocpMj4aCnHbZxdALcXjU05s6kXs=;
 b=qaNzYrGteumgDlNx9NirKbZZMYhWS6Dt2dDcXzK6JQNwvmW4HbMHIgIhxqn7rdY7W0LE/GckZMk6T3zAbQ7vzNdxpwTFGDQJZynQLimGNTskjcemNKDmqC/v3rWaedF2C5f8KPhoc75g4AVuJDiS/zqxE9y5qeVIW4z21muWXyY=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 13:16:21 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:16:21 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Topic: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Index: AdcP5nVD09suR7nBQdywlWsyhxQOWwENr39A
Date: Mon, 8 Mar 2021 13:16:20 +0000
Message-ID: <MN2PR12MB45492AABD8B376AE9848601097939@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <MN2PR12MB4549C7304B2DABD3F79EC4F797989@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549C7304B2DABD3F79EC4F797989@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-08T13:16:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=575272b1-45a7-4751-841a-8ae25924f542;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e2f46df-22c4-4564-9b7e-08d8e2345da8
x-ms-traffictypediagnostic: MN2PR12MB4518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45188F0B42FCF02FEF4C11E997939@MN2PR12MB4518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMdI0ULfPw0N6iaFiP0H5E7Y9e1ix7oze+bwDDUGJobN6/9Meobt6U/UhG0DqIYL5+YwBnW4bYUnPVsUsokoklGzXojC02v2BlIyO4Zd/J2cL7T9QDfrsGpv2WR5qZ3sWIhf+HMcUKUazcn2GNQ/Uqbo2K/Vid4s+VSg4534/JqNJJ5Pn8nRCtVp+UYwl5ypPmcCHqKJ4/ry5JwqAq/c3dpemsEx/8khdZSC1AN9+OhRUYA2OekZRgw5xU2n6fNESNWOk4XIr/wFUfdg1EMcjroDcuqzD89PjOe8GfYwUnLVrJ5XKJTnU8Ypb1vpfCGaE7TL4W+lHMj9iaz3WhUiR5w79+aLUnEuk9BWbHtFLs3OOvCICMliJnw5wuEAlZL8v0z0dy9oaNDR/YpGBUU77a/dzh4NhmczkCoiznDRPhbhNJlNbUP+QQgJT4PzMcyoDCDMilFO3563Z5rkPf0KI0Ycg4RzOctjq+VX/ZCypmW0Y7hJA2lPT0ASEULdeSkoQgSdgzJthQ9Qnht+FMK1lA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(2906002)(316002)(8936002)(110136005)(9686003)(86362001)(33656002)(8676002)(76116006)(54906003)(66476007)(55016002)(5660300002)(66556008)(64756008)(4326008)(66446008)(26005)(52536014)(478600001)(186003)(53546011)(6506007)(71200400001)(7696005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cyrfhl86wHg0y5ze6GNHawWWMBEV5JYr/YTDrXKlOPIApUqa0qI4StofdOq6?=
 =?us-ascii?Q?SeUTVTxexssKWh+6wCAk6vfIEetMW7m+dGvYsg+T8vRWl5S0D+s+vcv3jQY0?=
 =?us-ascii?Q?nfPeMKKUWR8uK8OrnWH5u1VwJflah3pC6pqE8+UA0ccd3yzRLc2XlS+ezGs8?=
 =?us-ascii?Q?Ps1ZGlAcjqQ93fb8rZkn9/s45mc1WwBdh7aMLZbE4r9VOTY57JTAabg/qgM4?=
 =?us-ascii?Q?YbWugCuO25vBuVYWoRU/zIViXOjQQ3ERUTxBBUoaleULBEyPvNYLwFmWeeAJ?=
 =?us-ascii?Q?OHGwmuQIiL5pS3bYpxpt6/vqSZPdiLWrdikQgL7DcwJ5LqmrYiicU+LTeLtm?=
 =?us-ascii?Q?25xNXwWSsMqqrj1BN4FSG849Tb0AnyjzSyhELtpymLZK/pmI5p0IGU/n8MPA?=
 =?us-ascii?Q?zKe8iyK7iXA9Ugsp25eTupuSGxtviw/JrM4vARcsMETXp/N2O2+kWsHnQ602?=
 =?us-ascii?Q?z9zqgOPkaLaLli+lIWAQxs5jHpIEXZZZvuaIdCYsU6wBj396Xh8XGC6eE17q?=
 =?us-ascii?Q?mrOWTHrbeEud8Mf+u0th89ikHEdDWxVb58sXHBnCSsN2YawJTwFoD+g31CUS?=
 =?us-ascii?Q?huKoytd66YUG1bTuLH1wsacYgg4KrB9GrOe8ILvR2OEMiKj9rlmIoKUFNnk5?=
 =?us-ascii?Q?2xj2a8Ll5J7WSo3SrvWhof+KtLnFWy6lbzwJ3kNHRe8giR7gA6Okwcao3CAK?=
 =?us-ascii?Q?W40udYdmXQJPmibdAe68mIcn2Xsczvd92zR3CfpfRGVMhYVkPlZKYOCCApE1?=
 =?us-ascii?Q?cCTyQjoXa4YrWMSrvuZy9jEWeMsWcTsuOa9/58Khsc+3LWgSC2NFjsInlWD1?=
 =?us-ascii?Q?+6FxDfkG0ZuWdeIoaMB4DodvLPxu4Pws9J41OOeCUx7cR52PU41tIyRCUYM8?=
 =?us-ascii?Q?/2pASNjVJCCsURMJ74ohOsHJG8EERfZriI+OsGYU19aBqGuF9JGX3VnAF57T?=
 =?us-ascii?Q?XcpJanfgBfjPWhvP4YMjJPHKD44lmcz2rwIkgzlZoEGs/FkbJlTONmZ0e3yr?=
 =?us-ascii?Q?R1708tGnS5sA/QBhlAV5B0po61jTsYrNr99YqCoxCF4mS3FUhTsXoUDxcn//?=
 =?us-ascii?Q?WAnwzEV6VPdmfOXWEmh1+ew9XgR3VpB4/JM+mX5ZJHj67FhRWqqBm0tQAsjA?=
 =?us-ascii?Q?CFK0CmGS57qkqtBH9VtCN1GIlkkajT0+tXy/pgDqsn5SEct2ouOeHyB57MBV?=
 =?us-ascii?Q?MxmNWUNKM9/4+q4N46uI0rPhOsKKEiP8WahdDbDXD+5Pk2nbcf6O3/cbWJDw?=
 =?us-ascii?Q?2rJt8GEeRDPP5ZIX6IXT/0yD2WPtweObKgrclFPXG9lvAmngLhraK8eeTP86?=
 =?us-ascii?Q?GV3XAHE88+0iNfceIuqApJ9D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2f46df-22c4-4564-9b7e-08d8e2345da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:16:20.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFqXmwh+ZHWuIFR3Ow+ole+3Sjh3AyRi4gLt1+HEuewJUADRJDZ6C5lCfVr3BcMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1975842871=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1975842871==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45492AABD8B376AE9848601097939MN2PR12MB4549namp_"

--_000_MN2PR12MB45492AABD8B376AE9848601097939MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

<Ping>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Wednesday, March 3, 2021 10:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read


[AMD Public Use]

Some configurations don't have FB BAR enabled. Avoid reading ROM image
from FB BAR region in such cases.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com<mailto:Feifei.Xu@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 ++++
1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index efdf639f6593..f454a6bd0ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -97,6 +97,10 @@ static bool igp_read_bios_from_vram(struct amdgpu_device=
 *adev)
                if (amdgpu_device_need_post(adev))
                        return false;

+       /* FB BAR not enabled */
+       if (pci_resource_len(adev->pdev, 0) =3D=3D 0)
+               return false;
+
        adev->bios =3D NULL;
        vram_base =3D pci_resource_start(adev->pdev, 0);
        bios =3D ioremap_wc(vram_base, size);
--
2.29.2

--_000_MN2PR12MB45492AABD8B376AE9848601097939MN2PR12MB4549namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&lt;Ping&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Lazar, Lijo<br>
<b>Sent:</b> Wednesday, March 3, 2021 10:15 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Xu, Feifei=
 &lt;Feifei.Xu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Some configurations don't have FB BAR enabled. Avoid=
 reading ROM image<o:p></o:p></p>
<p class=3D"MsoNormal">from FB BAR region in such cases.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo=
.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;<a href=3D"mailto:Haw=
king.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Feifei Xu &lt;<a href=3D"mailto:Feifei.=
Xu@amd.com">Feifei.Xu@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 ++++<o:=
p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 4 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<o:p></o:p></p>
<p class=3D"MsoNormal">index efdf639f6593..f454a6bd0ed6 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -97,6 +97,10 @@ static bool igp_read_bios_from_vr=
am(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_need_post(adev))<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return false;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB BAR not =
enabled */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_resour=
ce_len(adev-&gt;pdev, 0) =3D=3D 0)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
bios =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base=
 =3D pci_resource_start(adev-&gt;pdev, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios =3D =
ioremap_wc(vram_base, size);<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.29.2<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45492AABD8B376AE9848601097939MN2PR12MB4549namp_--

--===============1975842871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1975842871==--
