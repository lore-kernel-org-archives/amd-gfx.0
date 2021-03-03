Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD5EC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 04:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1723D64E86
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 04:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1723D64E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C866E0B6;
	Wed,  3 Mar 2021 04:45:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECCA6E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 04:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BldVtsvDTaMVCAN21nsqbDZi+TTyOnxlEfMbFW7mThNaf+SqOrC5M9bBcDLY4bx5I5/v/otzkAyUewKzaUhw2rZaLoQ5LSo0cfDiAAzZ+yLID1Pc5FPVOYsolFV4jud+e46z6KapyP8JDtyRPT6k0BIN3HOaz3q8EmJVDeLcWjQAdoxD5czgY/on4R8nwZdb7COBJHaC4JFZpCPQg0Uz9rO51UfXDSRgmWu20sim7EHX3v8+YhfKoBvimHJzVsEdxCn2SjVsBCFhE0O57PqWitkiY1umT9MiUABRK05mw7A1Hb/fJcvOk/xnxX6dwGmAiR4o5InSyNzVZgHL5GwhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAKrPu3mFtcg/VjT9A+qMkLQHrBLSPLF8Qod8UTRjz0=;
 b=XpIFxt1ZFz6Bq4Q0tp8PhDBrYp/wQcYhcalMB86pRNKOMX+U2QrsbWkzqx8ZHmDHIENY4QH5kMMQBLVJkP/EtsuEy/opddMeq1o2aEPahuTWpLzCIjcV1WhRumvFUfJyndQNt8jfEjAMEocaR6ci8MpFRZq/S0k3ChetY+7vRF4PeXbgTZCruxJVMLEbqW8JQwf9kaVkJ730nZXjB2oGfdvZ+xh0tmxtZXu34Dca90DpfgP8KEzAPiSjY2RJMOgsXpMZbxW2gs/DXMCulKaPKw7d6LsVow3xsG1R+3FF5iKFBAMMvchn+KfDeErehhpV+KuNAcpHi27XCV54eh9uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAKrPu3mFtcg/VjT9A+qMkLQHrBLSPLF8Qod8UTRjz0=;
 b=JF2ZAd7koh7X+yUpwvLYb6T6D1I5Ia1ehAkJqL5hTARrkKNxXbqHsLsByRI1+fBXG+KPCSs8UnaY9SFH0uBYvGO41HyJdKUUYoiQiXkK1iOvrwsQcQDzZOZiKB8vknjHMe9BUp0apPluCt+Jp/WMXuGKGCAsdKOrogoEITxWdhg=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 04:45:01 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 04:45:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Topic: [PATCH] drm/amdgpu: Check if FB BAR is enabled for ROM read
Thread-Index: AdcP5nVD09suR7nBQdywlWsyhxQOWw==
Date: Wed, 3 Mar 2021 04:45:00 +0000
Message-ID: <MN2PR12MB4549C7304B2DABD3F79EC4F797989@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-03T04:44:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=575272b1-45a7-4751-841a-8ae25924f542;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.193.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a5474c7-9ad9-4f25-57a3-08d8ddff1ae9
x-ms-traffictypediagnostic: MN2PR12MB3694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB369468304C9397F43BEE5C9097989@MN2PR12MB3694.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1H+pC/FzErX166nBYX87g3t+5LRfqprfaCE0Q1Qp2ZasxC/P1eyHfWtPq014ISkP3w4z+MLyNI00c9ZsaveVCRTm/634xub6iIOTm8M4WLvzzypuGVDDQMEHST+hljjdLUjl7BdXmwcSVY6jrQxiwspaC+4r+McBpA1bjBXEH5tRMggO5gfUYVYXKaX1eBAOB2T8fHzlRivxb7JeSDKx3sJP1qYUCmNWKluEe4ECa+MQw+w51upd01ZWhs77J9CyCxQYNpjJvVEpgb/CqvGT12L6Bo5hYvNae2gGkITQ6rFV8941frRhN7eJ8rWldXJL6e54LO9wS8lZLJG0FNPmNiWTIilQxxbwxR+sac0DOVpGLkkJb9s34t3tTr7iZom+soQuxWK2WqI1w4Mygah1C/fBxjiiE1651oIRlms3Y14+6M+oKmGSb6u+fRs0pGFvOqOyVgeuFlkccvgrTsMnvL1Z08dy8Ca23FQOSECKp9yXbsx5Y4PxOx+OeiqMsJ8uYOUwvVbleY7n8dXIPTztA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(71200400001)(7696005)(2906002)(64756008)(8676002)(8936002)(55016002)(66446008)(6506007)(26005)(4744005)(33656002)(86362001)(66946007)(478600001)(5660300002)(55236004)(66556008)(66476007)(316002)(76116006)(4326008)(6916009)(54906003)(186003)(9686003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jRSlLLumCwNzMAjYmJfbf9gDrvjKBFNY2PFHETSYjhDIr6dAwm4zrOlKxyvx?=
 =?us-ascii?Q?VFPAe8M5HiuFN47AVSQXYHGyqEiKT/d5c7KpwWJPxNEdYNeDrLiqDUHTsfgN?=
 =?us-ascii?Q?GMCPTx4uc3SXoMTuUF/2RL+RJUSerb015XuNBTJxxsk1BeQ78AezI6b4MN9H?=
 =?us-ascii?Q?s7XpLptB5JKQU8EtGzzhHYrB+YcNj6E8lx+j7XnkTp3zj+tXKJYR3pJgzjFc?=
 =?us-ascii?Q?syJGWpDUZEW+aS0tBewATJM3f3y6SXorQEi6B1dNOS4MRMkJRHfuAM+RXlCe?=
 =?us-ascii?Q?8ZlNQQ8PQi9kZdmtIGOSASm4ZRw1Rg4I1XH6kxMQZz5xasK8SKf9VfvEe01p?=
 =?us-ascii?Q?hhy45rgSvKDzUBUbBGcQql9pd37MFpnJA1u6uPR5Iq1mrsTcZRT6UieaIBai?=
 =?us-ascii?Q?osgfE6P7i9frn93n13PlI0RF70M2gQc30R1HA0hQefQkp5GP7X7Ol5rhZohs?=
 =?us-ascii?Q?bB/eKm+DCyKDnyQ6vsSpk8DfbrFu4/vtdCZM8yi9ojdI11QG1h+eAUzzW71I?=
 =?us-ascii?Q?VS2mcppd19ttvKDSmoH1/Ucbktha2l8hTN1bq2yGjnhZ9mGwS50I8HX/uw1C?=
 =?us-ascii?Q?+9Nz8vurHLImBEo6cmdqr4+6mrOsSkOJvVtWWTXtGIR7Bi1D7FMO2yhZiLRU?=
 =?us-ascii?Q?nRzFSBfejC/fHgtx/DgnUFv3SYD/HIo7x42E4TZoJYjvoF/gSA4CyVvkLP3q?=
 =?us-ascii?Q?1AQFkJROm0eWzThPP1KQEOSYO9KLjX/KloWHJqvWiLYit0k3I75O26nbWUU0?=
 =?us-ascii?Q?phCROed5K/9ofEqKkEAnzHy1E59P/Pra2qfK7IJnL26H8VDWLExzOqig6VGx?=
 =?us-ascii?Q?HjFf5RyIyYNB22NFE4KRgwByudHyyAiqoMuO9KkPBBPRPJtCxxGpnmNHmbGx?=
 =?us-ascii?Q?4GUN2Qm5Qqbi9b1XIQ8eoqZYkwYV3vcIdgUXMbB4zXHD6KEYtBVhl3R41mub?=
 =?us-ascii?Q?fcW+smek5KqwEDgGX9KEbEtazDgD9M/eXW1FCsDPbEorRQ13dxghzaYKdXz1?=
 =?us-ascii?Q?gsrIdbIadAYtFXai3SsWYEIKl1RmTjzVE9GcyZDwLFdu4ZFuC3b2Ct8hcmNp?=
 =?us-ascii?Q?WYIOZqGoX3/r4UN0ijvXwc5mUMrUCMpzhdxQAZxAnMxFcbUNt28BxPgsy/qC?=
 =?us-ascii?Q?+s6SvEwZSesXZ3iIKLD0xqb9CJK+N8D3fskE5GARAb3jywhsBQRRTe/Q5dgy?=
 =?us-ascii?Q?Sq2513WOnmKeOPqsUCBjPs1blvafIsdisxOBuRiQZbMphdpXDgLrWqPOgGIa?=
 =?us-ascii?Q?d7wkHUkXqYvN929r8pFLyiOrimfXsvYx9fV7vdYUhsB6G5pUO+NtcsSOI1l2?=
 =?us-ascii?Q?hb1NbKMJG4ToHVWiSA/xPzxJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5474c7-9ad9-4f25-57a3-08d8ddff1ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 04:45:00.9659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sRn7gm7OWZziocC9b4+iy6c1OV+BqN0AcbBTMbxCxo5hGAjDHAcsa/4PP5QzK4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
Content-Type: multipart/mixed; boundary="===============0637075519=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0637075519==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549C7304B2DABD3F79EC4F797989MN2PR12MB4549namp_"

--_000_MN2PR12MB4549C7304B2DABD3F79EC4F797989MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_MN2PR12MB4549C7304B2DABD3F79EC4F797989MN2PR12MB4549namp_
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

--_000_MN2PR12MB4549C7304B2DABD3F79EC4F797989MN2PR12MB4549namp_--

--===============0637075519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0637075519==--
