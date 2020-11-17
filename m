Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CCC6369E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0100C24697
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g9znfQ1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0100C24697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF7B6E0DD;
	Tue, 17 Nov 2020 03:33:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682BC6E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 03:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG6dOTxir8it6YGSUNqZlnDIAqEFsabpax3/2biRChWVh8UKce8oW7jM4Ivk2k9ZCW1RGNCPOWBmTuGA77WhEFgqo5mQf+lHfsyZ4FuZZY1CKRilyFdckAJNeywAXjCk+c9+dKrxTLVHZI6fqqVkc6aR27aiyyAwImP0mJ8hiYxhhLoX5ac3TLQveugt0bjGXAYsYvkMLCZNbJXuVVJY9LoJWnycuTvBsnopLASq2+fyoXf8jqzOBXs5gbmaBif2DJGK8mwlVh8X8PDNKYKVxChaLuZXcq6VY5znaZHLAeRz3V7R/Z9ZHtLOaVCDh09FHuM1n6hinQx/iFX1cYFVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAWua3Zr3yCuZIFj1U8DC2JqVUWt2Gxm8laWxcMY11w=;
 b=de2FVV+xoJTGS5cDEcoF1g2X+9eUqsCFG+CSPAR2sCpKIBO5fEyIuHmgIiuwWmnRdM44Qqlfd5CuTIUo0Qtt2+eKm29TWxrOI8igux/byoJss70vuwMSLszl8U20bOwkzqJI2sQa91kUEJ5kZ10DEja7z6serRAZqbSZBdcEWrYmAO3pNKsBSnh2dvNl9uD0WFhx9PCnoicg6qFIfttT9kx5VAGS9lBRCqUe+y43KDed3oNj5DJOkgoc38/K7Zc97Y/JGnP2XyvvFP7HKZ085WBXH7Bq0lHDpt5GyHGs/lD9z7T3/tBUP3P7h9BiYS/XT14d/D1SBzh1C50C+e87Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAWua3Zr3yCuZIFj1U8DC2JqVUWt2Gxm8laWxcMY11w=;
 b=g9znfQ1LUs16cCd3lGCO1TKwmzqBr/m0vsoFI+f/a9Anrq6x4nUivxOlhjJ1FHI5jKgpMIWFKnBQ82/qM73NiHA+hjKK24p7ORd26dfEfCdw18jwIfOY891+xUMvXSbSgyRmfIB5WFiyQLgH+tqHv5hiCk6RDVI0HQ5kepzGKgY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 03:33:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3564.030; Tue, 17 Nov 2020
 03:33:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use
 of soft PTable
Thread-Topic: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use
 of soft PTable
Thread-Index: AQHWvJI+81tWKU05nkq76l82AfJtJKnLq6r/
Date: Tue, 17 Nov 2020 03:33:46 +0000
Message-ID: <MN2PR12MB4488AEDD21CCD8CA0DBEF84DF7E20@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201117033152.19568-1-tao.zhou1@amd.com>
In-Reply-To: <20201117033152.19568-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-17T03:33:45.594Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e73c2904-d985-4132-739a-08d88aa99737
x-ms-traffictypediagnostic: BL0PR12MB4692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB46929E27B1B62C76BFE6F612F7E20@BL0PR12MB4692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9YVbunhJWUh6peLIeh2L8LuAasMx2aJVoZqRDXh25vK8gH2p6yO5gcSZh1t6eLKKjbSY47H3ZaTwRYV3Z6kotkjvcM4N6rShj2xz3qLZjgcsxZuE1TWWF63cRx+wk5yFrBPO4PQ4gWz6mnYXTYCdunvnvP0U42mo3ovXfD1yJVfoZJgbkKep2MbCDnpp4dUsMlIgnWj36vgS+wfr4V5UekCXJssqtfpGMyrj8Se0Vt0f0TGe2Qci1o9f+E90C9l2E6EwCXsqJhv0it2Es4lzoDhIn7Q/JfLfR2jV+j10r13xP4hWEypdgapctPW2djf+GmIsdPMLkvWWsjjLyOFt5Q6CWyJ1gTZiGyGuqUX1Ew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(83380400001)(8936002)(110136005)(8676002)(86362001)(71200400001)(2906002)(52536014)(9686003)(55016002)(166002)(33656002)(6506007)(53546011)(66556008)(66446008)(64756008)(66946007)(7696005)(76116006)(19627405001)(316002)(5660300002)(966005)(66476007)(478600001)(186003)(26005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ICHyAN+o5dTt70gBCsjWoKC4OhpQAlXyBlKeG8X2icWsJ19ZhNyro5+g0cTIrmS/D5SD7I4fXpf7y09N+pEMqQ2/V1DEcx0JxlKgOoUOXeqDjzySuk2QqtBODZ9st82VNyqwgcvHKDlcJthuTUsV/Aje9A9BUal20pNu/gRH7agWd/2/ZpGsRgeZjYvQ/FXN6i33WJ84nbvXTZHkpKg5Hcu0VCRTw2j4bbHBftFvB/aN5vcadSS34cYEMNXdRnQ2uxQ7xkpR/A6GJx5cy+i36uHFqKotN5Bj8USM2ybXvDquzoxh4vDMmlab8PldpsuZ3VGiu1oSHAa0pC0I5R8GhigLeh+W9AyPjI/l9ORCJgeNhVejsxo6ykOTmdiFHgPrrDzQqlmvy1IgHFqlxcrip1BQsu+KMeq+g7JDhIt6tABW6fSh2P3KWMRn7j+1846LExEEwq8ejS53ZB0ulJZnio+gbU1BUwYUk+5EidUpwQeTlBHHgQvjo3UZPbDoKBJfI+QfCiEEg7x7vwr2oH3/acxMaqVePsP6hxsqQeA2EMomocMAntUE8cw9iPrBHMjyh8A+zPtEn1uP4t6P+MnwpRFevdvN3Usjpgs1bPoZHJQHeFvZJNzzHBOF+ZS7/n8Jv4Q4EfziGHVrE9qVkab6E3DZOLYwSJtrQUAp5Si1KDd+XeNQL6Jk7ggxblPQpwWd1yhIWFsHoaDRyWW1fDnxQq+JT9B+ROk8CL9iScDVeGSPGOZ/+1oLtaJ+QoJ5r3cxpidxGXYeSPy6vxkxczdgoZvrvjhG07Mnm3jb9Jwia673r6j2Xox7oZzYIiTZY1+DnPuu1oNkWevXXtu2ni94d/zCZXoJvwVObwNySqWNd1nAVlcq42+ju9OMpXZdyyj8G9Wa8GDWAQK04tCneq59MA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73c2904-d985-4132-739a-08d88aa99737
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 03:33:46.2511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Y249KZDdaOspRNvQYhKN9THNgbTm9oVMmMxdHFBxKJXSskFQChpwITvzxrI8IfnSlaiqCrUDxAviNhG8QAhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
Content-Type: multipart/mixed; boundary="===============1051881039=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1051881039==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488AEDD21CCD8CA0DBEF84DF7E20MN2PR12MB4488namp_"

--_000_MN2PR12MB4488AEDD21CCD8CA0DBEF84DF7E20MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Monday, November 16, 2020 10:31 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use o=
f soft PTable

The PPTable provided by VBIOS can be used.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index b23311096467..d5fa0d9dd7eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -339,8 +339,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
                 hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm=
.fw->data;
                 version_major =3D le16_to_cpu(hdr->header.header_version_m=
ajor);
                 version_minor =3D le16_to_cpu(hdr->header.header_version_m=
inor);
-               if ((version_major =3D=3D 2 && smu->smu_table.boot_values.p=
p_table_id > 0) ||
-                   adev->asic_type =3D=3D CHIP_DIMGREY_CAVEFISH) {
+               if (version_major =3D=3D 2 && smu->smu_table.boot_values.pp=
_table_id > 0) {
                         dev_info(adev->dev, "use driver provided pptable %=
d\n", smu->smu_table.boot_values.pp_table_id);
                         switch (version_minor) {
                         case 0:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cccfce44c5e5843177c7a08d88aa95ec3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637411807349472302%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D8bUpARFZbEDD9hF2ksu32HtFV6BdQTkPcYxMlFR33rM%3D&amp;reserved=3D0

--_000_MN2PR12MB4488AEDD21CCD8CA0DBEF84DF7E20MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Monday, November 16, 2020 10:31 PM<br>
<b>To:</b> Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Gui, Jack =
&lt;Jack.Gui@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd=
-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for th=
e use of soft PTable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The PPTable provided by VBIOS can be used.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index b23311096467..d5fa0d9dd7eb 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -339,8 +339,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct smc_firmware_header_v1_0 *) ade=
v-&gt;pm.fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cpu(hdr-&gt;header.header_v=
ersion_major);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cpu(hdr-&gt;header.header_v=
ersion_minor);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((version_major =3D=3D 2 &amp;&amp; smu-&gt;smu_table.boot_va=
lues.pp_table_id &gt; 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =3D=3D CHIP_DIMGREY_C=
AVEFISH) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (version_major =3D=3D 2 &amp;&amp; smu-&gt;smu_table.boot_val=
ues.pp_table_id &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(adev-&gt;dev, &quot;use driver provided pptable %d\n&quot;, smu-&gt;smu=
_table.boot_values.pp_table_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switc=
h (version_minor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0:<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cccfce44c5e5843177c7a08d88aa95ec3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411807349472302%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D8bUpARFZbEDD9hF2ksu32HtFV6BdQTkPcYxMlFR33rM%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Cccfce44c5e5843177c7a08d88aa95ec3=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411807349472302%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3D8bUpARFZbEDD9hF2ksu32HtFV6BdQTkPcYxMlFR33rM%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488AEDD21CCD8CA0DBEF84DF7E20MN2PR12MB4488namp_--

--===============1051881039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1051881039==--
