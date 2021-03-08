Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ADC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1132651CC
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1132651CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8D489D57;
	Mon,  8 Mar 2021 13:17:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C1F892CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc7GNAdr3kAKEM+X/F8W9fEHN5PoDMZfpInFVx19LBPI3zTqhPPU5vNPCA0p4zJABaUcMkYT7m3bbaMBxyZceKGk8DYzOJJFCR86PJPBw2a8AAulCqZP1ok4Ob16Rb20cBhTgTzgZDDJDjHdiXUnMX5UlDXxmNMq9up+TAj+Sgf82NILAz06Z/5s7pikWh5e6cH7MRWy2mZifCnaX7lYEM6g/bsTCY+49Zlsox1DVZKsXeLvEozbJUn+fNZfalrQ9qmnKIDaJu0uRSz83cBayKIFmPvm6xJe4KU6DiP+R1B51V0T/Kxc/GE6i6zGerf/fRyrawmkQunaANmypRJuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQbPuDEFPZK0xTeIrxlJ5P0VrT5jSwWG1MtYJhOSaeM=;
 b=mvHbuTQOapH7LHCHda41ijlCKY0gKUa2GehArxHMFP4RRilprf1gIMA0TYWmGp180u7qwYuag+6/aqzrFZtAWYdC2u+nAhY1XJdv/zVGOtjo1fllsP7it247eFKV9LzFJ4yFrAl2d9puZDstlEgdcC0kXAcV5vrM9/wiEgDDzem+9tofOw9ItC0NlNMI4PlNalld/fotDyAMgrynndcExkxmxR1s8iROjViPG8IDZSOEwObPL3wrbE+LgpneOOpdpAWZ5n8ccVHih7tI4RCbXaEb10WZ5RyPOI1kfFbS0JWR4vWbpUyko5aW7XvT6VsShNKIxeg8HffvwoUcWg8Stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQbPuDEFPZK0xTeIrxlJ5P0VrT5jSwWG1MtYJhOSaeM=;
 b=Z8fSKewxRDwVV2NP8I2NXesYjSIdQ5etB1C4LOnzJS231HMF2vUOhFlroa4meALf4ApMy9056v3UULWn7UPmNPYMLO/TgOPGdn14jvkLe9V+sr24gPyvxZqNZoYykmZ0yt6ZopWat8D+a0kJNoBX81HnjDeydnkU0SqUxJSTPBg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1834.namprd12.prod.outlook.com (2603:10b6:3:10a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.26; Mon, 8 Mar 2021 13:17:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:17:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Topic: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Index: AdcP5nVD09suR7nBQdywlWsyhxQOWwENr39AAAAGzyA=
Date: Mon, 8 Mar 2021 13:17:14 +0000
Message-ID: <DM6PR12MB4075634EFE47786122804B20FC939@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4549C7304B2DABD3F79EC4F797989@MN2PR12MB4549.namprd12.prod.outlook.com>
 <MN2PR12MB45492AABD8B376AE9848601097939@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45492AABD8B376AE9848601097939@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-08T13:17:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=575272b1-45a7-4751-841a-8ae25924f542;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 601bf05c-21f0-4912-e2f6-08d8e2347ddd
x-ms-traffictypediagnostic: DM5PR12MB1834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18349963112920805129E5D1FC939@DM5PR12MB1834.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+nfzE3O+HtKi9tzjT9tPx8Ut3HCxhx+w+zdSfciTPBoGglCNAkrZvDr7cSeXlFqFJvuFKrkt9f/brqUR5YSN6g/TSmhSahP0n3ibuzDvx2OIMxrLR+pGAlM7c915mz0KsJUGehgAI9m1T64hhSHcOSPTq0yvFMFevUIQjQgzURMrww2dVldosd/Yauo9k4Y5g5KhGNUaycM4m166A7fUv5/tM0zmDTld3MJ+pkbQsFiWkP0EA24dshFU6/hlMy/ZBO/Vir97XSBH8JnkONLgqog6MiXd6ikxJcbfs+4tSA0IbimNG7zk/uNd1ds1G6i7pAfqyhEL6Way0k8iaFZzIr/FG/2bYm3znixb2uNZ7TyCuqxkQwDvl0atKJB53suL9+WjLeeTHozlbHIpIfuvfJFdvC81WLAp0dyv/ZWLuxn64ZgKe8oTApS5AGf7TWoQdXrjy0VABZgWPVV79fD+jzq8JD6FJlfzdjwmY/r1WJTeUioVfz+KhAzami5dQC24ZuUFrzvYzLBLh5VPhyVWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(26005)(2906002)(33656002)(66556008)(66446008)(76116006)(110136005)(316002)(6506007)(54906003)(8676002)(8936002)(186003)(5660300002)(86362001)(53546011)(9686003)(66946007)(7696005)(66476007)(55016002)(478600001)(4326008)(52536014)(64756008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0DCwVPGFOhHfvL9Qfb//Dg69bTl6n0fwktzim0E1AMBNfHTrxgUQyyWexvcw?=
 =?us-ascii?Q?4XTmwFFTlf5StdORL712ENA/iomA6TpIR8JNMghdrHT6nN3W/507Niso2X8E?=
 =?us-ascii?Q?/0au64awe+GqRfaQHyTko87ggE879UtvhS3e6RkW7n0Fjz74Cc5gEtk8rSTI?=
 =?us-ascii?Q?CzoZMQ/IYOMR78P2x5MfYF59xy/cQoLg2QbzgTityA6DMTaD/MP9m+xiMIXj?=
 =?us-ascii?Q?/W4cmwNZEebdllEQ/cQsHNcANcvfgzsm60QlkoEuS2ywfmj20KO2TkquhUfY?=
 =?us-ascii?Q?7LK+xXgtYncnsETNv5RNrK1EwaYyLBJHxJSGzjnDgOsmVzkIaJNN0oeARPD/?=
 =?us-ascii?Q?hZJFJ5Im7pFAnEEWwV8Npbd8v/b9ymDZnva+JMZnwB7zoSy97nngAo8z6sft?=
 =?us-ascii?Q?XHp+7vjytY3w4avx3asYOyPajRAx3iUSWCLQck7LhRNHrxDndpjNLkKS0ibl?=
 =?us-ascii?Q?DPfKvf1sl7sj8pmD1SLmDIi+YNjTjnk+eoZdLlC20MkzEgY5fffPzeyk4wTI?=
 =?us-ascii?Q?Vll1PEgeVaOfqq6kJTyWl6PHKqy9qeAc87UaPIpDhcs76JrjaVKXb6095qNu?=
 =?us-ascii?Q?+CCjSvoL4YJpCoVrTgwd60MmnIG/8oah0DH1EDTXEf/YgYAUfMyi4vAlAbuQ?=
 =?us-ascii?Q?TlEfkR6+BJgZ0hdAnB9OzhHRhWswxbgKKBN9hEo3mlwem3uLCzLJcKDjVyij?=
 =?us-ascii?Q?TQb9QUMDFY7NYJ0C2oc4I6QIFd8dMiRFUnUtsK4pvM/dYRlV7EnTyIkRsdfw?=
 =?us-ascii?Q?9IOIwrc3TjKq9jeJQ352vIx+dUUhwEG9Z3WgRDJBAXSvVQo5O7axJonePlqM?=
 =?us-ascii?Q?l35ubNdRPhwHqM3K9yZc8pAnnGKheLVdmp/ge2AiwympmKv4x3fJ3xdm6djw?=
 =?us-ascii?Q?+TY1MtQTjG2d8hRa5ApshSNa9uDSqS5N3dZEv7snZG3a9Dmz/6fcn5iCku44?=
 =?us-ascii?Q?FXcuPcooAZ/NsylBO6Su5JUJRRX/ywfHS3uOrH5O/E1ioV4M/vdlikA0q6Wy?=
 =?us-ascii?Q?Tu6Xj5M9j6QXJmOAnI2qriIzU0MM/Xr2DaOpZXrVt3BSKE4Xw0X7u6KC9Kej?=
 =?us-ascii?Q?qGHb3JgepwGiyJGihEEMV0ZjrrsbdxKkpxmLtfXinMy4T1XSWGzWL/8BzH+H?=
 =?us-ascii?Q?1QcODlS13QpeuKDJ8L6kiby14cpVd/3ftmQvU5EjRZDBOyupOeDZu9I75JGM?=
 =?us-ascii?Q?Rd9kivwLdIkKRKe6uITZPeE1IOa/QE+KL/zxRMxRrj+Oj0DSasLvCA845GY2?=
 =?us-ascii?Q?rBbAMtfQvcyxFoXRPo8245QJDWkC1+TaZfAFq6LwOUGfw+ugmqmO7Jf4z5jy?=
 =?us-ascii?Q?w74qkjKhoLkuKrCOyCjePOfM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601bf05c-21f0-4912-e2f6-08d8e2347ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:17:14.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaMoSc7BUciit56k5o88N19qnuSldJ1j4FefTVQ8jFnmblWzvN4erdR4ut1Twzb0g7fmnRGJBauI6PaEHwq2Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
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
 Feifei" <Feifei.Xu@amd.com>
Content-Type: multipart/mixed; boundary="===============1197995269=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1197995269==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075634EFE47786122804B20FC939DM6PR12MB4075namp_"

--_000_DM6PR12MB4075634EFE47786122804B20FC939DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 8, 2021 21:16
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read


[AMD Public Use]

<Ping>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Lazar, Lijo
Sent: Wednesday, March 3, 2021 10:15 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Xu, Feifei <Feifei.Xu@amd.com<mailto:Feifei.Xu@amd.com>>; Zhang,=
 Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
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

--_000_DM6PR12MB4075634EFE47786122804B20FC939DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Monday, March 8, 2021 21:16<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Xu, Feifei=
 &lt;Feifei.Xu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br=
>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM =
read<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&lt;Ping&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Lazar, Lijo<br>
<b>Sent:</b> Wednesday, March 3, 2021 10:15 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Xu, Feifei &lt;<a href=3D"mailto:Fei=
fei.Xu@amd.com">Feifei.Xu@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"ma=
ilto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
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

--_000_DM6PR12MB4075634EFE47786122804B20FC939DM6PR12MB4075namp_--

--===============1197995269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1197995269==--
