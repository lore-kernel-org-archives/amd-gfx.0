Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F557C4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 08:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55C364ED4
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 08:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55C364ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC8989C51;
	Wed, 24 Feb 2021 08:12:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3100089C51
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 08:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbGgk7n6V7WDV9t9dE0AxHtiY2PhKeYk+SbGAlUpx3VHG0TaxeFsCDi3KrmVrqPV3CZEbYmwNDq3T79vC1yUniDC8hcU4V2+X3CKYRexvCnJNWFDAzV8dxHl/rmSKpMQuTnXSHao86v3mRi6YRrHZtaf+9oKItjcqMsr5HIDjProLMogTAq2kswD+Qj4AvBLnODjjHe4lRX1pv5KXP0XiS+9EwUft3V4hqRqBaEv+8HeTfnsUA4B0cDVYMh2j5Cws+Uml8OwPIGRR9z1RittW/0tkScST39nzWJPPEGcAow2mQ2hCVEOYbioyuKX9GGsZ46hvIo0VsPOKzVBrV6J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw0+OyVGJSe4yQa4W4ZpOtGW8ZKwZHgZ2JgQgS762lg=;
 b=OpQkHzkOoovJPPcCEwFLfkdiQUQOq8UWmjCWmT+mT0nt51p7nX7CkLQ0qP7D21vHlJ9TpRt16m2TdeaQ0EZ2dPdxs6gALE/cBvDlCjRBo09bPQ6UuHhiry3d5JZxHDkXUM8u7x5tEmMMbstzSIAL1eTWMmR+i/Q8arbeik9CllsUFpoe/W4TNxcPvEVyeMeAZKYA1143A751YSwpxXo+t481x1MwcPfGfDSBEqiAqWd3MLqa5oAFt1Yu2V1WLDD0R9NvZQx3xGaJjAO0pi3LFSq9XBNSsMe3VQSPeR2IpdSVnWt31B/K01Ahbf+I+JmogA+3We4XzumItdipDwfKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw0+OyVGJSe4yQa4W4ZpOtGW8ZKwZHgZ2JgQgS762lg=;
 b=By1/TiHFPxK5V5dEfSfAOpkg4IQLgpI9Clt+UVti0aSkTeHAUB8N0jpoyqhuue8wY5dF6avqPw4AAWANrSJI+VWZbPkNDYyDFIVniyyC1uflp1xNAMY9GwrF5XP75enKQuyAHx8POd37ZYK1wVM00ObLEQ0kjVXGhh0RapdR3wQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 08:12:15 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25%2]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 08:12:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable VCN for Navi12 SKU
Thread-Topic: [PATCH] drm/amdgpu: disable VCN for Navi12 SKU
Thread-Index: AdcJxZksqQqLaqKPRnGLRvt1na6HdgAvxg4Q
Date: Wed, 24 Feb 2021 08:12:15 +0000
Message-ID: <CY4PR12MB1287A1692DB349C91E4CA7A6F19F9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9@BL0PR12MB2419.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9@BL0PR12MB2419.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-24T08:12:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e3e0e1bd-2a96-40af-a03a-f63539990ce3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c1e2a9e-16e2-44d4-aeff-08d8d89be576
x-ms-traffictypediagnostic: CY4PR12MB1909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1909FDB76CDA8365AB2A919AF19F9@CY4PR12MB1909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPJSL1iTYpbLEAmRM920ysawQWGEIkipiiUGDbqETgdDlWOOaakaFiD4eOlZvl05lIbNfWPOR8ixKz3mLdgVfUmpsD/pMku985vep+SuKqX0VHsmezl5kjSUoJSYxljitTY6qF3xUVCoIK4fdvZxiU8h2IDjz6OpkLsprA9ZtK9fl5dQLc4L8HPIaerMce+prAXoRI4gdN0oXPkiZYdQyaP8I52CHopCdi3oH2HYm1Opvc+15k+LC+m1Fv8qr0Pxx8EzeU4uyoay2GBdDcxgfxqqH9VoDy+SWbPoUJUvZUTmoGwGKNXcB0mt95RBDjFyQeUgP8ipCx20ILJCyQ2vq5jMXK77TUkTYjrDvnpls1x/vQx9cHsZEBQUx6ydUn0VlOD/ISbG81c+ZH33tHah3YPGnMIb63ZQAb42BUJXm0Ic515U2C5TJdGYU8eapwI7FK9UZT7MU1Mrlvv74BFOp6u2kGHqRbvXqLmNOW2tQGD8AZjcK+Uz+nYp0ohm/9FoXw27K7APbPR98ogHqjKs1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(33656002)(52536014)(66476007)(66556008)(186003)(8936002)(71200400001)(26005)(110136005)(316002)(55016002)(5660300002)(2906002)(83380400001)(66446008)(66946007)(64756008)(76116006)(478600001)(6506007)(8676002)(53546011)(9686003)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/lSSzMpAqFiALUSBFAg1wZpoL8B0adXwU4P8bHkZVpuGixGc2zmSbKNeNbnF?=
 =?us-ascii?Q?29iBGkuN+7tvZXXxlU5Ybt+AppYMdo8EOOWOc4dGe9JOwKCv5sXukf08YQtn?=
 =?us-ascii?Q?pjk5fdjNJfMtywsPE9CopdIkXeYHPYhGt+7rTNXuGOIfRbqe6AcMe4Z3q30H?=
 =?us-ascii?Q?OgEdPZn5oDS8dmWYw3xPJyzUfTLZaRtT9mk349tFURAzDkjCNhySxNsmqckz?=
 =?us-ascii?Q?aYLTVM++WDWPSTx94LOf2cPeblUaKNEVOu9LBekBZfwYm678L0PoSnrKb11R?=
 =?us-ascii?Q?IwuA06cpQ5Qw55yOU72T1o3UFyZvw9SRHz8ZEhhEK7Djdf2tpy8lEbt9+9Hz?=
 =?us-ascii?Q?ZrMwIPrcjAHWxj5TVMrmI6+B0XJin4gF3KdN6vt7EMyCUEAucWxPxBFRa/UZ?=
 =?us-ascii?Q?tcyVtr8p9wzr4F7Bw1S9EUF9iIk2Ov03jrcHUuELnOHBZ3Q3Jsi4OmIw8d9a?=
 =?us-ascii?Q?YtwTXIPLMDXPFXVK7OugJotoHahsjilYy9ZAEMHPld95cMQT+mW/Il2t/ZSe?=
 =?us-ascii?Q?OI+yL3jzfY2wjKmBlMEysY7w2gSWERubgbPZtccGs5Qic2kNKJAjIOD78Oap?=
 =?us-ascii?Q?S12U8zJ2kXX2Rm37oCsHNYPRPGJ7W3Qljo0eLxn1Z4qUfBgUHHMIdwhIVz4G?=
 =?us-ascii?Q?bViz9O+ouM23954qG0oKLa4uc9AAj9rVlq0Znw4u5iW3J0D1x9/OdZnUKOy5?=
 =?us-ascii?Q?bkz0EJRX8vX+87z6zCfOEn5niw1GCU9FBoJpPQwVOMMe5byGMzhDUkUk8zaD?=
 =?us-ascii?Q?VH8U717uRB05DOKJuXe5EF6eS+8KG4QF6nVBBWLGvDiIVk1RvcjjiW1foiKA?=
 =?us-ascii?Q?P3SUtLlW3rk79k4W0DbgBqzTWF3WNNTapPSWPoCAvDul6nV4ctPv8e3APV06?=
 =?us-ascii?Q?IWi1e+rdAhK9wJC5ABs+s4vmFZeg/oNh/LMSTlKj0v0t1Xdw0Av5A1tK1xsb?=
 =?us-ascii?Q?v7T3IsHmVxdHbVvUFLHQhZxzIvvlkja/tyU7n0MNYV+UEaIk5TR5T1E7qN1u?=
 =?us-ascii?Q?bxbMR6xPXkNi9H6ZDaMSNySsdF3HhsRKHRlp9kv/nGcEk4zS1e2OrxLdZNmd?=
 =?us-ascii?Q?wu09iVmuH8Oeo1Vt/QWAm/5mtSeXz7M0UBCyNADhXpkAXhF8TMiD/I5YwkEt?=
 =?us-ascii?Q?EOASSXs3tM2+t8h0g6R/uq1FRo8t64nunX2POAiq/lTgmAcTl+lktvFe+ihg?=
 =?us-ascii?Q?bDQk9DI7MtHOF0p9/DZjg6Eei8eG5Bn/K4Vu2d1SC0pOhjB2WTTCkV+7FXbS?=
 =?us-ascii?Q?EMjuRAk6uYG7fXoHiy5mbkhHjukczHp5sVlPLVBlujcdmIUZMcCd9ttZyFsd?=
 =?us-ascii?Q?vIhBY2ofeuKVKgAEglbQzDJJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1e2a9e-16e2-44d4-aeff-08d8d89be576
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 08:12:15.2906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90NynDpugxJEhPvLzr1WyhKMLcwXJ9HEnxEc3LCHNXNs87g5xZp0vrxlnPiBHMxtGbVnAO+yU88c+ogO+tSHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Content-Type: multipart/mixed; boundary="===============0283892153=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0283892153==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1287A1692DB349C91E4CA7A6F19F9CY4PR12MB1287namp_"

--_000_CY4PR12MB1287A1692DB349C91E4CA7A6F19F9CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>>

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Song, As=
her
Sent: Wednesday, February 24, 2021 4:07 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable VCN for Navi12 SKU


[AMD Official Use Only - Internal Distribution Only]

From: Dechun Song <Dechun.Song@amd.com<mailto:Dechun.Song@amd.com>>

Navi12 0x7360/C7 SKU has no video support, so remove it.

Signed-off-by: Dechun Song <Dechun.Song@amd.com<mailto:Dechun.Song@amd.com>=
>
---
drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++--
1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 160fa5f59805..c625c5d8ed89 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -558,7 +558,8 @@ static bool nv_is_headless_sku(struct pci_dev *pdev)
{
        if ((pdev->device =3D=3D 0x731E &&
            (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7)) ||
-           (pdev->device =3D=3D 0x7340 && pdev->revision =3D=3D 0xC9))
+           (pdev->device =3D=3D 0x7340 && pdev->revision =3D=3D 0xC9)  ||
+           (pdev->device =3D=3D 0x7360 && pdev->revision =3D=3D 0xC7))
                return true;
        return false;
}
@@ -634,7 +635,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT &=
&
                    !amdgpu_sriov_vf(adev))
                        amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_bloc=
k);
-               amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+               if (!nv_is_headless_sku(adev->pdev))
+                       amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block=
);
                if (!amdgpu_sriov_vf(adev))
                        amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_bloc=
k);
                break;
--
2.25.1

--_000_CY4PR12MB1287A1692DB349C91E4CA7A6F19F9CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;<a href=3D"mailto:guchu=
n.chen@amd.com">guchun.chen@amd.com</a>&gt;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Song, Asher<br>
<b>Sent:</b> Wednesday, February 24, 2021 4:07 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable VCN for Navi12 SKU<o:p></o:p></=
p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From: Dechun Song &lt;<a href=3D"mailto:Dechun.Song@=
amd.com">Dechun.Song@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Navi12 0x7360/C7 SKU has no video support, so remove=
 it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Dechun Song &lt;<a href=3D"mailto:Dec=
hun.Song@amd.com">Dechun.Song@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++--<o:p></o:p=
></p>
<p class=3D"MsoNormal">1 file changed, 4 insertions(+), 2 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drive=
rs/gpu/drm/amd/amdgpu/nv.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 160fa5f59805..c625c5d8ed89 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/nv.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -558,7 +558,8 @@ static bool nv_is_headless_sku(s=
truct pci_dev *pdev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((pdev=
-&gt;device =3D=3D 0x731E &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (pdev-&gt;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0=
xC7)) ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (pdev-&gt;device =3D=3D 0x7340 &amp;&amp; pdev-&gt;revision =3D=
=3D 0xC9))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (pdev-&gt;device =3D=3D 0x7340 &amp;&amp; pdev-&gt;revision =3D=
=3D 0xC9)&nbsp; ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (pdev-&gt;device =3D=3D 0x7360 &amp;&amp; pdev-&gt;revision =3D=
=3D 0xC7))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fa=
lse;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -634,7 +635,8 @@ int nv_set_ip_blocks(struct amdg=
pu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=
=3D AMDGPU_FW_LOAD_DIRECT &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_srio=
v_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;smu_v11_0_ip_block);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vcn=
_v2_0_ip_block);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!nv_is_headless_sku(adev-&gt;pdev))<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_device_ip_block_add(adev, &amp;vcn_v2_0_ip_block);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;jpeg_v2_0_ip_block);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB1287A1692DB349C91E4CA7A6F19F9CY4PR12MB1287namp_--

--===============0283892153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0283892153==--
