Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267AA60F11
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 267AA60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B09C6E483;
	Thu,  9 Sep 2021 08:00:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFD36E47B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKgyL46AzL4NRBnDr4WJLPnoK+6B1enosYYBlHo+1M7ft7ArNY07ihjLgWvqceSpY8SQY5sZ3OWADxwt3N2c1MAQdpdkMDrohnF4yexGbHbkFrbzazyCa6IWID1UuoNy/QRF29xF0BNQ3khAF4ogdgWJAU9SQ2UuWQeZb76hNw7alCwrWZHhARVlX3RGku1GdqfD4ZFgOgZ5iH5o7aFGfZRfyGk0fU1WzPaLxfQ3ngsyXJ+s41llCCvhGgQ68Skizos3jqve6TPT8fU/OdlQAqezFAwsgeHTsoozrDrxSxMij4kFnahyMxAiV7nQanPjWD9TBeLeDJ9kLQdq/c9YDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mHzyzV6LfL/oezZ2ixcP2qTE8oaXIJWHVFeVKV/b/Zs=;
 b=Hyyxhfc3QkFsa5s+tXXVoW0LfH/SafsO697thXipu3tFz1+IMkq5G6yS3mNJGZQkNWca82/gjo3rD9JXKdrnY76w79QOd18BdMQ46qg1Df6bFSCcila2MzQsDIo+lN5H5uk0bsRMGilw7EyIg+B+QurlSLvJXeSe8e2AREulhJkQ5sN6LpDeQotnGUZNkzpa2HNZI8PDnmXcC2RemSjCCAgRFweYve1DFpwcnM5YkZHWqsMGNs3Vmh/wRgew2P/2vPHWmwJyJmE+iGw7rLJJEAGnMm09lQSJMRE+VnBd37YSO4w23lki3kk1wdqWUh5lI/Bd28fFDD1yIdPGy7OZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHzyzV6LfL/oezZ2ixcP2qTE8oaXIJWHVFeVKV/b/Zs=;
 b=j+9w9jt0TrF9yUK+9ft48z5kftE3GLMh0CJyCo7Dv7hl30UvP/Z7v1L3bj4srBehS35aeWpGtsIVz6Z95wkSAhDVCNW6gf9yg1u/epV/XkFzObhQDAqZ2r5dXg8GRMgBbBtK+nTfKHVi8vUGxtboDTei+dyNVHHFsmUQ+9AuUew=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 08:00:22 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 08:00:22 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS status print
Thread-Topic: [PATCH] drm/amdgpu: Update RAS status print
Thread-Index: AdelUJap8DAcxsdeTDeWqt+zSdYfWA==
Date: Thu, 9 Sep 2021 08:00:22 +0000
Message-ID: <BN9PR12MB5226452C055807353DEA5D3FFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T08:00:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9fec9d80-16c5-40ba-b591-864cf1d49e56;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3a95e5-357e-4b17-30af-08d97367e021
x-ms-traffictypediagnostic: BN9PR12MB5051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5051DF8843ED5ACE29A1FB91FBD59@BN9PR12MB5051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttwQYrQ5sviLWuDvKWkUxyzr+VR5JR3q0diX8MdAK1E2YGuU6QeeNOLspqd9DMEoLi5X1v7Thsy/wn11K8LHIc59/OMkDTcNdb2RZdnteXCYSBoqrUoj/IvR0luXd/YONeBbaaXUiahQ3k76JYdOvUv7rXl4IXEOlGBjDS6HNe8OBSfucrkWJok5Ia6MSP3xztpxMRd99lny9ZiyU/HQ6FGpzTkBNfj4yK1mkoQoFMSR7yw2P7nFB9OuxVB730OFbSh3XcmORPvDpsGB7uZ8+S7TVDNaqdZns0MHTc3Katmk60qbKCdCZwXmOeoUSxSrrN+csCdpNI6bZcMjdgHGGc5N54ktCMVbYIysJfqoHOHMhXqDnFWnc/fz4RTHid99Ab+szXuLFqPCL3dPgmjAXYOpsth4Hh4vrU2kSL6Clbk9AtQGp06+dCY21kqUq2M0IlOparYZKi/yj28xHVNauURlMjbaGOl5wpyJ9ax9Utk+1+ACdv/gDquSqOZwpKw2rZGwkjdLU3RlMRVz/tQ3qxzOpyhDxwm2T2+vBFlw6U5vI67TO+w3rVkdJeMHMDiJFaC382yxQNZz4BHXCNtfY9bUjYQKusABWut925fvbOXDL9djNMNjJxPbme8MXJ9Lbiio6ZKL5afP5tE/Kvjb0p4GDKI3gcPfsJSFPDoj2KGo9y3s/j5Ey1wDE/1VhZUgj5l5yAgBNLV38Tbdc1m7nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(66616009)(66556008)(71200400001)(5660300002)(76116006)(186003)(38070700005)(6636002)(99936003)(66946007)(86362001)(508600001)(8936002)(55016002)(7696005)(64756008)(8676002)(2906002)(6506007)(110136005)(33656002)(66446008)(38100700002)(52536014)(122000001)(316002)(558084003)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uWQJeU6YlkkcHb/dyihsC3jHLYRXIgkfDmmMWr5igE5jsQFg7iPKYv/IJY3X?=
 =?us-ascii?Q?QPvSzPIiANXrnEvhCUrNilPlh0GDfeFesXfjMwekQ5nIWmYS620kfrMTrQJS?=
 =?us-ascii?Q?Amj49W+Fk2Gs8zGIKzu3ayglWrsP+pLZDkb9/LOAI9XkTU8PvKWd3Sjf3JqX?=
 =?us-ascii?Q?6SoUcc6QV34YuLF5hDEQqqRswZPXB61EUf1NDe6AUJutu+Ey7zFA/h+7BeQb?=
 =?us-ascii?Q?VExlv0VJl0Ntakbn28uLsM7fYs5oWp6SF3mM+qoAMXpRc4IAi1BOZhhuQdRU?=
 =?us-ascii?Q?suAwpeJkkCuChxYVWEHJovJnUBCf95GU3BPJNjxr1sGWSlsCm/A4i4GTXdSW?=
 =?us-ascii?Q?lPE+nP6DcxDBZi0M0nFtRJfguLcQ4DDGt0x+z6UWrWXchgT3ltH3Z1m79yfS?=
 =?us-ascii?Q?MsY9TFacIfet06rlm7aV2DssSKILehL4cVuRAyYDHphHa82GCCGdMlYqGqQH?=
 =?us-ascii?Q?y9XLKF4pAbftJxtclJEzUa4NNnRDHXsQ55yMLIHcIlLaqaT8AppQceBT40un?=
 =?us-ascii?Q?DhoOgl/JTx8f5NvWqevr4gLuTQla72Xh/x9gF/sLSw9bcnWsUVukLAL445F2?=
 =?us-ascii?Q?qVaN1pos88jfYhmphsSbMWABkewBoDtBvMRpBUSSQ55zITXZbd60KV/a0U3C?=
 =?us-ascii?Q?HoHymwg7/LnzMqWLJGLyYLBNajSMxEbCy4IMOBE19nnBVJXY27N3LA9icaPj?=
 =?us-ascii?Q?wObormu/HadBj8q0SZ2Wov0cjWniX6bwyQ04e0gtH4ZF2ZRx9NY7vIu9iXeH?=
 =?us-ascii?Q?dmAVDIesDOWjkeouH+8znzi6A5Abem+xhMZ9nDnWQoREAESMe6znLn71G2Bg?=
 =?us-ascii?Q?XZed4N16x7LVJpeE2W1kfHOt8VGtH4vm7mD8HS+lWUfYmzGoGAfBaWeybjyX?=
 =?us-ascii?Q?LXWgGqSqVybWbtWl1RFM+FqQ9V/aFFh4zelfq7hbFRod39iad/rzoENJEkRs?=
 =?us-ascii?Q?eewV+4yN5P7+VPLrsbBGoy1Qg3jCx2zJRCVBoMtsRp7Ps/WKEQgSlbaMqUNY?=
 =?us-ascii?Q?yvwHqQakEKBtyKFnXFPH0cd2Mc9N/JolZtn5rWKjf1QBN8OCtvIPq89kPpeu?=
 =?us-ascii?Q?No99AI2loToWsSX5stt9bTgneABz/3KafTc6HSp3M25rOVgFOH2q8Pu/2dDE?=
 =?us-ascii?Q?B0yXPKIzeWDYx/AedxmhG2m5xIG7iWxBA29XMlslBkq/gbB5atPHuInE2/et?=
 =?us-ascii?Q?TPtIm8GgI05a2waPrNzmfsk9NQKfS5BZ+ahA8YhwfRmciLvsmxWGBRHZzbO+?=
 =?us-ascii?Q?bxL7+ocfzPvprbzPeU290fdNxUq1HbC4pbh5CfJBLvONUY4RGgI771TUfw1m?=
 =?us-ascii?Q?xdyycY9yXvS3oLbqXrrOWo6f?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3a95e5-357e-4b17-30af-08d97367e021
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 08:00:22.7498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YFv7kUZTGswm19a/6YTP/6MHc9qJhTAsgsPfxhrB9HcnHcGIf6zl4M+tn2Ur6StvTJNbgte5MuIBT8WnqspLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_"

--_000_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to remove parser for RAS status response codes and just pr=
int RAS status value on non-zero value

--_000_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to remove parser for RAS status res=
ponse codes and just print RAS status value on non-zero value<o:p></o:p></p=
>
</div>
</body>
</html>

--_000_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_--

--_004_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Update-RAS-status-print.patch"
Content-Description: 0001-drm-amdgpu-Update-RAS-status-print.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Update-RAS-status-print.patch"; size=2267;
	creation-date="Thu, 09 Sep 2021 07:59:00 GMT";
	modification-date="Thu, 09 Sep 2021 07:59:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZTAzNWUyNDdkMzc1ODE3ZTYxNDU2ZjcyMWExZjY1OGM5ZjM2ODk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgOSBTZXAgMjAyMSAxNTo1MDo0OSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBVcGRhdGUgUkFTIHN0YXR1cyBwcmludAoKUmVtb3ZlIHVuY2Vzc2FyeSBS
QVMgc3RhdHVzIHByaW50cwoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVt
ZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkyNTI0MWMwYWI2ZTg3Mzk0YTg5MGQyYjkzMTZkODg0
NWY0ZWY2YmFmCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwg
MzggKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYwppbmRleCA3NWVlZDE4MzcwZWIuLjlmYTUwNDQ2NjI2OSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTMzNCwzMSArMTMzNCw2IEBAIGludCBwc3BfcmFz
X2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKQogCXJl
dHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgcHNwX3Jhc19zdGF0dXNfdG9fZXJybm8oc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0JCQkJCSBlbnVtIHRhX3Jhc19zdGF0dXMgcmFzX3N0YXR1
cykKLXsKLQlpbnQgcmV0ID0gLUVJTlZBTDsKLQotCXN3aXRjaCAocmFzX3N0YXR1cykgewotCWNh
c2UgVEFfUkFTX1NUQVRVU19fU1VDQ0VTUzoKLQkJcmV0ID0gMDsKLQkJYnJlYWs7Ci0JY2FzZSBU
QV9SQVNfU1RBVFVTX19SRVNFVF9ORUVERUQ6Ci0JCXJldCA9IC1FQUdBSU47Ci0JCWJyZWFrOwot
CWNhc2UgVEFfUkFTX1NUQVRVU19fRVJST1JfUkFTX05PVF9BVkFJTEFCTEU6Ci0JCWRldl93YXJu
KGFkZXYtPmRldiwgIlJBUyBXQVJOOiByYXMgZnVuY3Rpb24gdW5hdmFpbGFibGVcbiIpOwotCQli
cmVhazsKLQljYXNlIFRBX1JBU19TVEFUVVNfX0VSUk9SX0FTRF9SRUFEX1dSSVRFOgotCQlkZXZf
d2FybihhZGV2LT5kZXYsICJSQVMgV0FSTjogYXNkIHJlYWQgb3Igd3JpdGUgZmFpbGVkXG4iKTsK
LQkJYnJlYWs7Ci0JZGVmYXVsdDoKLQkJZGV2X2VycihhZGV2LT5kZXYsICJSQVMgRVJST1I6IHJh
cyBmdW5jdGlvbiBmYWlsZWQgcmV0IDB4JVhcbiIsIHJldCk7Ci0JfQotCi0JcmV0dXJuIHJldDsK
LX0KLQogaW50IHBzcF9yYXNfZW5hYmxlX2ZlYXR1cmVzKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
LAogCQl1bmlvbiB0YV9yYXNfY21kX2lucHV0ICppbmZvLCBib29sIGVuYWJsZSkKIHsKQEAgLTEz
ODIsNyArMTM1NywxMCBAQCBpbnQgcHNwX3Jhc19lbmFibGVfZmVhdHVyZXMoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3AsCiAJaWYgKHJldCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLQlyZXR1cm4gcHNw
X3Jhc19zdGF0dXNfdG9fZXJybm8ocHNwLT5hZGV2LCByYXNfY21kLT5yYXNfc3RhdHVzKTsKKwlp
ZiAocmFzX2NtZC0+cmFzX3N0YXR1cykKKwkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJSQVMg
V0FSTklORzogcmFzIHN0YXR1cyA9IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0dXMpOworCisJ
cmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX3Jhc190ZXJtaW5hdGUoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3ApCkBAIC0xNTIzLDcgKzE1MDEsMTMgQEAgaW50IHBzcF9yYXNfdHJpZ2dlcl9l
cnJvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdn
ZXJlZCgpKQogCQlyZXR1cm4gMDsKIAotCXJldHVybiBwc3BfcmFzX3N0YXR1c190b19lcnJubyhw
c3AtPmFkZXYsIHJhc19jbWQtPnJhc19zdGF0dXMpOworCWlmIChyYXNfY21kLT5yYXNfc3RhdHVz
KQorCXsKKwkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJSQVMgV0FSTklORzogcmFzIHN0YXR1
cyA9IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0dXMpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9
CisKKwlyZXR1cm4gMDsKIH0KIC8vIHJhcyBlbmQKIAotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB5226452C055807353DEA5D3FFBD59BN9PR12MB5226namp_--
