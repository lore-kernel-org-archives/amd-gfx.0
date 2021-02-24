Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0165C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 08:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE0D64EC9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 08:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE0D64EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1576E8A8;
	Wed, 24 Feb 2021 08:07:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEE66E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 08:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzAriC1YthMEmWiqAHkM7hzv3+QYVQrKQwLyDjT/+21AmvPUUmx0JT4Z67YHBJPyKUIWL0hMiUcJs75ETTye5PoaAwHkkwB/yaq+LfNM4xCAC7r8WURkHVTsU/sa8lLFalkLKtawxKmU/IEx3F1lRDJfyL5p+KII08ic+NGD/+sWdVDE07xSp+AAIEZJMnxtrrLLaZ7UqIH/PPRuiQBMGoHElzuY8r/2BuDQ3cAicC8A85KBpEo46e3QBRm9vtfcO6gZrCYkgSVwXVZHrjN0iSmhgFv/MjvO55kGWsA8473lzlUdawlY38hQwb2S7VoUfcJ0/AsNEQ0ATOOrDMqFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o+MTYYjAw6ilZV/sqfe8HOkCpfKPkhYo6XLvXC5MvM=;
 b=SM0/+mfpoC2ZkZ2V57bgw+cIagFMzNQukjeRPy6I4cWdXaEVgl+RGDKu1LXQnz9EXUl7kMfeq0isYipplVDrryrE0lz6vGgPx00Uj626qFOZXrU7w1qvKAyeYPuK0rVrs+Nh65iFjWU9+YYu0xKZx46suH0daLNwQt8QZw3so5kfQuTaQ1R8S9YVRKYnWYhF3qlukO8ErQGiocly1zto8FoR6/QQl+Zih5CuqwN6ccxOm97wCiwgdHlty96s7Rkkamw0fRMRJAjYpX/1dLuPIesTq9Farujac+kozr1SEWmCwSn4uZ44yG7k5dlBsHOiq/mZmlnQHawyY004OIUPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o+MTYYjAw6ilZV/sqfe8HOkCpfKPkhYo6XLvXC5MvM=;
 b=sBXuU9OAOcrZgTIOkYe4xwHvFiS+WmIjo3aM5onfB481jB81YEogA9bGylOQ0++1dMeF5YYVuvMkd/gO0S1nESqB5/w3QQz5+YQC9sWxh8uM9dRlB0q8DcyAg2NF8LunXDoux4NXSfjkkb6Ss1zv4kjp2AXqDJwQtQ9ge7HuI7k=
Received: from BL0PR12MB2419.namprd12.prod.outlook.com (2603:10b6:207:44::27)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 08:07:24 +0000
Received: from BL0PR12MB2419.namprd12.prod.outlook.com
 ([fe80::ed25:c5e0:108e:837b]) by BL0PR12MB2419.namprd12.prod.outlook.com
 ([fe80::ed25:c5e0:108e:837b%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 08:07:23 +0000
From: "Song, Asher" <Asher.Song@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable VCN for Navi12 SKU
Thread-Topic: [PATCH] drm/amdgpu: disable VCN for Navi12 SKU
Thread-Index: AdcJxZksqQqLaqKPRnGLRvt1na6Hdg==
Date: Wed, 24 Feb 2021 08:07:23 +0000
Message-ID: <BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9@BL0PR12MB2419.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-24T08:05:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=909525e2-c35a-4105-bd94-6f3df0322b36;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: the patch is send out  for public review.
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87d6824d-8700-4015-4895-08d8d89b37a4
x-ms-traffictypediagnostic: MN2PR12MB4239:
x-microsoft-antispam-prvs: <MN2PR12MB4239497E698D4D8696A6DAB88B9F9@MN2PR12MB4239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATcouFJVOl0LqP0LRtQQ50GKQzmAyUM/gclP0SQk9HGJtR6dmg3QUwT21aNsLHv1UUGTouMJEw2JuDKtz//OdMIWQEzAHFbTvftSOhdh3qFXwzv2KBPV72wjt0av7AnyRQJ0nAhcy76shuInXo93AkGhyf46qDJp6SOEC/dcs9ud9IwDenIz8fWF3GfV3TddCShTyE54TXL5ob4Ti6FbetwXFYHzZqMS9lQdl+1rQ7x0G1fhpJ6cxzTmTDENRPA36K+R/Ny2+aVZEqc09dhA+ZlYKxQtLZ8hlF7DGO/Cj7maBIXD7hKNSoz+sUlkzlloBu67dfgFXNsk/y2pxWznl4CJ9X74Bags6wGNjpXpVshahaegmf+mF4DHZkIiDvtR3mnRKsihlOjtfB6DUUW2XoEk4Kbpk0uJ7D3zBF4pEJiCs0F+0glh3j1jPvA8vyJpSjK1k8ZsYOMG08007zjXGY0kV0JdycvqFS+0e5VjE9g5PrnI52YMclv19OpayK+CdGPKUoRfEbL9h+LUXrE6JA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2419.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(66446008)(64756008)(66476007)(55016002)(6916009)(186003)(52536014)(66556008)(9686003)(316002)(86362001)(5660300002)(26005)(6506007)(71200400001)(7696005)(33656002)(478600001)(8676002)(2906002)(83380400001)(8936002)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lAodkZDGkgxfGAy6yrwyWkAV5KJDy58U3wFfwoJ5TVtnkBRm6Qp2OGi/uMV5?=
 =?us-ascii?Q?O2pCwZOcgZpXjbc2fZeoVXBrYk3yA1WL6h3IuwfDFQYIyllaZB2CvLNQjFiB?=
 =?us-ascii?Q?Z81W8gY9WW03/LzR1k0hFn5BU0WUBl45eFRzJGqtya1WBifpxtYreL8qNfZ8?=
 =?us-ascii?Q?8Y3MhiOA5bO4/Y/b6KB1iY6HywhPyQ6PKg7FGKP4/Z3JpiEQmIMShnqb68/A?=
 =?us-ascii?Q?PYMMZ3B1lKrNvm050Dr76NMHiAYBkVFYvLcLz6apBQ50m4JwZSC4K6aC5YJX?=
 =?us-ascii?Q?Kr/ZuN3AHW17rckhTK5DJhj3Bv99Qlr6XBlDSTdF5eMkgBSXpwdI1ZHdqnsZ?=
 =?us-ascii?Q?xeM7YOwX0+MbI4W7MVxFio3TU1GxbuaQKllCvpnvFxM6qF5F0AN905l86BT1?=
 =?us-ascii?Q?YkH8+tC50fL3WPsia59aVks1Cwc3bn8jQ1lNmd6h7W7Zam1MCsvN//lKehit?=
 =?us-ascii?Q?AQVYHlRwEIRflu3V1eRPupXrzQ2wubLAf3sKvsR53A3MViaNrMlCyHGih+P+?=
 =?us-ascii?Q?rXP/Fr9fkQ2GHJzaBEHPkTaYU/NoDiS7pUeTsfwqwrMOu8JU3fkTTUD0Jv97?=
 =?us-ascii?Q?qhQrpm9WZFepxceCn0L1V6a20qNawEioyjpefDGgmgzgYCnoPy2X7XastBWv?=
 =?us-ascii?Q?oNuuXeWOXajGatFws/AYZZxRAgFLUU10PHCKHHai4Ru73KA4Otvzuo9INqvQ?=
 =?us-ascii?Q?RFiWjvG3qFNgF9eZ5Sn1zY3h0sDN8JGc5s3urj97pPg4wsNvTToxBAjzMV7N?=
 =?us-ascii?Q?g0oHpgXqtmrdBjD6/LlM9fp7v1zowW80wJpDlxclnFT1u/bR7CAi+ypjpUal?=
 =?us-ascii?Q?oNIocpIqCJjwhHd6TQy7facqIPafB7oRX3MPEKSKw1Yze/zqx30BHItQ4hoY?=
 =?us-ascii?Q?R/ecZrUe4c6pVA+GXnH0TRihrjqqd0B+Q4VvBYT/TM8c/ySgYL3bDwPtvH6M?=
 =?us-ascii?Q?KU7hEU4eVKyfEpk86FWMBLsbZcN7T4x9gJPCgVX4Ww+Vii/ECqidmjDaPLAa?=
 =?us-ascii?Q?QPGUs1nVQAjvMGWT3HotnQIMaGDeGzX9+3vbUF0GEJ0oDIIcAAsakwaUmS04?=
 =?us-ascii?Q?vli5JEU9gqyhSXYdWD9Ol2eMaIeaqsIAfiw+kj1Qf0N6/seH55dwOhnDmY/u?=
 =?us-ascii?Q?yp/laL/aOU15nRKxPm+le2vFEaMJtoxNKKLytW5x+a1vWim0D3izvEEcuvIX?=
 =?us-ascii?Q?ZQ+NyWz0k1ZfCCno62k1sJR9AEjbsX0GQBpIcDrXZu6qpdfS2Kzn6WLbl0S0?=
 =?us-ascii?Q?vtWFVbApRYf2ZlbVwbAx5KMsIyMbj2OrjPwY66vkLHGo5z6iID0NSGi9k2yG?=
 =?us-ascii?Q?k986Veqrtng4USeEqTULzKJs?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2419.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6824d-8700-4015-4895-08d8d89b37a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 08:07:23.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKmTLPQPs6LnoG/QsOXhdgQyA8hXjikYpmGpYb/Y3guaq7HXen/dKddsvnaOzx6Q1fLvI3Mqd8BaBX3LpntSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Content-Type: multipart/mixed; boundary="===============0104903754=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0104903754==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9BL0PR12MB2419namp_"

--_000_BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9BL0PR12MB2419namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9BL0PR12MB2419namp_
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
	{font-family:DengXian;
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
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
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

--_000_BL0PR12MB2419771F3AC40BCC5E3D94DC8B9F9BL0PR12MB2419namp_--

--===============0104903754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0104903754==--
