Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC109C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7466A61966
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7466A61966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBB789FE6;
	Mon, 22 Mar 2021 05:58:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCBF89FE6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNn+zkT0LtFVvGB+mffxd3UFkgjsX6k7jIV1/a2xhupoA4MRQhKC47MaVOCQQWvDRokG9yYCux0j5cOCseItL5NgCin4N8qfk6CsrOFvNObMGxT6Q15bXDzm0wqZQJ7P9X+tJfZzsvXXbA/KjyXTJgSWOrR+XDCGX49zpXIJT7O+VOl8NIqM+8hmngB/0/FQI/R/856fvxl6RjQ4xb/Oruk8ewLmFjEkBj69aODZfJG/6ZNFy2gdOHKwWs7AxsD6NOPQ6lPo0Ch0yHqMVToAwVX0eyFb9sZkLuDKX9n1Ui3UsJ5GUMRzikCLJ6KLsJGFr2N59RIv1a0WkIckkl08ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq5tQsI0aus1NQUmLoK/p2gHgu7CE+Y+mwpyqydd1xQ=;
 b=ASJpyF8+TFL3G8q8Nk4v2+VpS41azzNY+zmkbnLdw7QVelPfY/ZOKyfgv14aiEfO1k++CxD0RneDhOQX/puxCS6lBmp4bVK2ZHoaAeOUGdVHFHqHXfAtGNDT4y6tssZR3WwXy344oG5gewGjJPKO8YBMAxa0ouJO7I2F45Ea1O9kS0SgkwLaMK5sc8GUALhUS3Go/ItI7mpimc7JfXNZ0mDzHD0CPeoCfITVxIStItkl8fEEKCGXULmfMaz+ZiO2xiHthGG6y9H11qCILJrwdYr58eBcd6W+62maZfWcx0+CMeNSUrdc5HbOTJipVqC+K08Nh9xmEu2q76V0AqoUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq5tQsI0aus1NQUmLoK/p2gHgu7CE+Y+mwpyqydd1xQ=;
 b=1Okv33h/hA0lR6G7GGl/YGhmbjS39Nriqi9GKgvFIypDx6d6c0KFuF6Zt0grv5va8PUvtU5jm+ET92LC/K+VhPNX15HnAENiiPjy6h6OW2RJvBSDvptZ4PBARLFugPR8GcWh6ayvzsiytkiMVMPbn9+VBt+dCpiW9c9A/pThmto=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:58:00 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:58:00 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/8] drm/amdgpu: Make set PG/CG state functions public
Thread-Topic: [PATCH v2 7/8] drm/amdgpu: Make set PG/CG state functions public
Thread-Index: Adce3pqJZ2otZFy1R1WWEoOAKYvdcQ==
Date: Mon, 22 Mar 2021 05:57:59 +0000
Message-ID: <MN2PR12MB4549F260966A3B226974019997659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2e4dba6e-8949-491e-a324-043ff137f506;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ccc825b-3f20-484c-e6ca-08d8ecf772d9
x-ms-traffictypediagnostic: MN2PR12MB3967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39675DD9FDDB41D89BC0325597659@MN2PR12MB3967.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvJKOXtbk0Dx0MEyFW1AYkdpp2juCqmBrRnqmhroM4lQwvSi2x4aY+Tdhl69hAjzICBhS/mLomTAJn4jMcEifsKamBaw2iEfRk94IWTEPnH3pODxIVp9huoJA7IVvdlqASC0oWTriCjS+g9yJXDyRFiY1QLxiFbgiEy2wiG+mZHUPURVo3HwBkVAdejpEh8n20ZegQD+rSD8sZ6ohhwdrwxZ2MgJPaTSz3Gqe2ZQ6EsZFC24H6EYJ89aRn69aukwUDgMIuRpRsizsBjC4A66TiKVL04pbKTOmGffwl7Cd+hP2Qa23L30IXhCAGAGR88B3mEyZF+BfxebQg/iW2TVtRcTBLW/nZTaB5EaX2U8X6AcnegCxm9uoV2vB6kPaUcqUCrOh+oV/d2OH2TwEnOjwd1sJAxjSixXmXQhzB3AIkzlm0eyAl31q5teho1N2VucvzRnUfIO1drbE0ThYQlXpu4uuTpuXzVb+Pw5oh0n6gnOTYsMo77tW+MXBtQwblzCmqMzeXajz1u0DwZmyrfRrvt7FsGMTCKGACU7GUKpHRVk/0rs2tRVneWlfL0/4BFACTF62EerM8jOjQq4cWisnQt/eadOQ2CFnvrGmQSHlcjFYngPxEtIpJHOrddFH7wx4PNLH8EwUih6ivN2IHdulw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(478600001)(8936002)(5660300002)(52536014)(86362001)(83380400001)(4326008)(76116006)(316002)(33656002)(9686003)(2906002)(6916009)(7696005)(54906003)(26005)(55236004)(186003)(38100700001)(66476007)(66946007)(55016002)(6506007)(71200400001)(66556008)(64756008)(66446008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VZYkX2WHP3OMbJ5zr4t1kAWkVNjcpWx3pGIbik36wDtfLP25FRqZtIZVImNo?=
 =?us-ascii?Q?WTyPoV52xYzf6CFh83NulUwKfkASP4WSHaCg5HM1zlxnmIm7TDw8CpPCqRBY?=
 =?us-ascii?Q?h0Uq+cliH2syNSKB/neyYKuXBfQa0mOelJIWSxixPdcKWNJvWs+5uzWGn4Ro?=
 =?us-ascii?Q?VeYZCxeu4VatcudLiqx9wE4QEd6hcF6vnTKGxt3goEiSyZrakScpzKLMP5FT?=
 =?us-ascii?Q?dJT9ofC4DAOViNK6N37iQoGTblqGoctJDCJNe1KI4/M4kIeKwncpOqzd6WUg?=
 =?us-ascii?Q?edZcRPmaUSYKEzYwYqeeOwoXh7aNGy4ShAAngHvnDCQKTLKQHEE73a6d2IPN?=
 =?us-ascii?Q?/tFZJunVa9NYN77Is+9drdtc+gilZZA1DwUKmLvOGQkvEDeuHGbFKjoiJLzT?=
 =?us-ascii?Q?6O9Fg+bRQ+vP8Awwu/ntw1aPJf06gy+3G+cuQbVluAgZzM/dJvX3cLCoyeHe?=
 =?us-ascii?Q?kSJBPwiN7D8ei3ORZferpU67Nt7+BGAIdBEO9095CpCZ059mouhNnGMh8BgV?=
 =?us-ascii?Q?LC5QxwsxgM7MRxihwRvgUlAMqzLemUekZIVLkQrKd4hRjoKfPCacIGpq7gtU?=
 =?us-ascii?Q?0tMBfZ8RHODTc6Hl1ew7G/jSkrJvBF3/OerePlSvMfWirCN3g7cYBXSxZP/d?=
 =?us-ascii?Q?sgpYc0sezka5yCH3hJh4OA+MQIHx/yfgJCxDN4DkIsq/fv4B4qjNpPZagfFx?=
 =?us-ascii?Q?H51AY2QyKhw1+NhiwiK2xv/aYCNLWTRvG3EOP5Nk+9QQTeuhi/6fLwMSCDSd?=
 =?us-ascii?Q?m7QyR7NyYGGcmbTR3+NnhISLuGltLgLQy66aT6FgCW3W8gqyJas6xlOjw1cz?=
 =?us-ascii?Q?KgvY98idVsQYX242m3504yEfBXBKAqUGFJkxDs+Bza83I1dXqnC4ok+2L97N?=
 =?us-ascii?Q?8AJCI+ts0BDKN8Nk6E5bNkUu+T10A2XTVbYO6f7llZX9Lnq35deCLhUmduQO?=
 =?us-ascii?Q?vuZx/tQx7ZHWBClByvQix+3tetgZncdfhk9qHHHKrwz3fZw13v643WlBdwaw?=
 =?us-ascii?Q?ITfmViyMJovWsk3F6oLKvyCHH3nHv2fUuosaDI4YXZ+O46qoI0RA+MOL/NJR?=
 =?us-ascii?Q?sQwBNpAV9ig4vja2np3zk0MQreb1gqNFh0+jYwDXj8pKjTMnkyxrv60yFtdr?=
 =?us-ascii?Q?xbO07xFTM5BRrBJ3T9ImThCYGTDuvnh8Enn9Ah+zkqgi6yipiuIIaGxsgKIi?=
 =?us-ascii?Q?8lQgDlTxXp7rRSTgdtkKkHzZ0K9po0od/MK3b1oQQGM6wgiQW3j3Tjv17rbM?=
 =?us-ascii?Q?fIY5VYDOAQSCO780mRI3pmgfX0VgGx7y8SyOVXpr7fAB4+5MIV1KzJm5LVeT?=
 =?us-ascii?Q?Q8XjHQsLIo3erm42txdaNZzn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc825b-3f20-484c-e6ca-08d8ecf772d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:59.9302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RLd6g4P5mxE3owkjB/f0mTKb/4Xk+Cd/fIc7RbXdn2acbT15JPA717YNMtF9NRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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
Content-Type: multipart/mixed; boundary="===============1195570612=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1195570612==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549F260966A3B226974019997659MN2PR12MB4549namp_"

--_000_MN2PR12MB4549F260966A3B226974019997659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Expose PG/CG set states functions for other clients

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 5 +++++
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index af8680727800..dea99f0e5703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1394,6 +1394,11 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pd=
ev);
 bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
+int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
+                                                    enum amd_clockgating_s=
tate state);
+int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
+                                                    enum amd_powergating_s=
tate state);
+
#include "amdgpu_object.h"
 static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6d6da1b504aa..b1b83d282090 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2362,8 +2362,8 @@ static bool amdgpu_device_check_vram_lost(struct amdg=
pu_device *adev)
  * Returns 0 on success, negative error code on failure.
  */
-static int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
-                                                                          =
                    enum amd_clockgating_state state)
+int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
+                                                    enum amd_clockgating_s=
tate state)
{
               int i, j, r;
@@ -2398,7 +2398,8 @@ static int amdgpu_device_set_cg_state(struct amdgpu_d=
evice *adev,
               return 0;
}
-static int amdgpu_device_set_pg_state(struct amdgpu_device *adev, enum amd=
_powergating_state state)
+int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
+                                                    enum amd_powergating_s=
tate state)
{
               int i, j, r;
--
2.17.1


--_000_MN2PR12MB4549F260966A3B226974019997659MN2PR12MB4549namp_
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
<p class=3D"MsoNormal">Expose PG/CG set states functions for other clients<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++-=
--<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 9 insertions(+), 3 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
<p class=3D"MsoNormal">index af8680727800..dea99f0e5703 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p>=
</p>
<p class=3D"MsoNormal">@@ -1394,6 +1394,11 @@ bool amdgpu_device_load_pci_s=
tate(struct pci_dev *pdev);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;bool amdgpu_device_skip_hw_access(struct amdgp=
u_device *adev);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_device_set_cg_state(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state);<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_device_set_pg_state(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_powergating_state state);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu_object.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static inline bool amdgpu_is_tmz(struct amdgpu=
_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 6d6da1b504aa..b1b83d282090 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -2362,8 +2362,8 @@ static bool amdgpu_device_chec=
k_vram_lost(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * Returns 0 on success, negative error code o=
n failure.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int amdgpu_device_set_cg_state(struct amdgpu=
_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgat=
ing_state state)<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_device_set_cg_state(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, r;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2398,7 +2398,8 @@ static int amdgpu_device_set_c=
g_state(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int amdgpu_device_set_pg_state(struct amdgpu=
_device *adev, enum amd_powergating_state state)<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_device_set_pg_state(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_powergating_state state)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, r;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549F260966A3B226974019997659MN2PR12MB4549namp_--

--===============1195570612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1195570612==--
