Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8633C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 15:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679602339D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 15:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679602339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4776E32F;
	Wed, 20 Jan 2021 15:58:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1DC6E321
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 15:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNH6+KxWUQDserRmvZRfGyULVQWbYSJlZt+lDTQ7jazWZQXUxU95S5B8vWGv+pnx7ipf2AT0g5zUQvVVO8wxzd9FKzAaPv3ddk+v3whgygLd35r//15O8YCSYERW8At5PpY/I1rz2K6ZNNVuqv2HWiKlfXM57p59bKMsuDMItyhJRrJ6IOMc624MNPvRBAvV62D0IbTBchyoLEDX6dqE7ekKxNf/yGcXc/tb0tOjWb4OPG8HoPy6hp0Fq5XIbfMwL9X/l+xqT935DDfSq5KloQyPwg96DgEEmBvYtzn7UY0l9Chdn/ONu2sq7+clRkPqpyAI1MW6iKDXtRwa7Qz5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNDh3V7J9o8hCwZiMj+FWhTXTLjgzDJbmWcFJTcZnPo=;
 b=JqiIz5bFDjrQkDuczk97vcdLvUdad+fh09SS9ljamCIucBg+/Z7I6L/mG7u5eLGUVY4WIoLHUEPbDw6M98zpiZwMQEL/Df8/bLz5caafRfaOO10rNn9u8odG2fZfR3xWBZth7DGrHYo6sNLWcv3+ckuNM8d4oleupm83DlbJugN6gf3kpZynIAeMZbb0c0G08YJO2LWoc2Tqq3W/XJJ0yONsmObAwNk1hMzyLhDEPHYJc2yOcxSr+AmEmchHuSSEg56/89imRPR5hmTbEGtrqUfvLF1o9GWt+jZSf406rBJFWbO5TcCL1XpFKMyHfnkJvwMm+Nw85HqWEjG9b1befQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNDh3V7J9o8hCwZiMj+FWhTXTLjgzDJbmWcFJTcZnPo=;
 b=XlNyLdyTb4YdU8rl+PVLsOOw7YJDNI77hSyYOknfz1VSSpPwWbcpbmZRYtwnZpt1lFGRF9IHoTc1Q44LoqfhgJfrhVbT1HopR/xZj+N+Obeirs63lk1pyse/8ejHdR/TW9tBmh2evRnqgwg6og9ORX3hFB9TXuwzfcVvYKkNETs=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Wed, 20 Jan 2021 15:58:34 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8059:4b52:4ba5:94b7]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8059:4b52:4ba5:94b7%2]) with mapi id 15.20.3742.014; Wed, 20 Jan 2021
 15:58:34 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable VCN PG and CG for yellow carp
Thread-Topic: [PATCH] drm/amdgpu: enable VCN PG and CG for yellow carp
Thread-Index: AQHW7wENcHzFsR4MIUGo3QKOJrgldqowrBDQ
Date: Wed, 20 Jan 2021 15:58:34 +0000
Message-ID: <DM5PR12MB25174F3DF3A018A0A1132E5BE4A20@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20210120075102.4004746-1-aaron.liu@amd.com>
In-Reply-To: <20210120075102.4004746-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-20T15:58:34.095Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c297d49d-a3e1-472a-612b-08d8bd5c3e1d
x-ms-traffictypediagnostic: DM6PR12MB3354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3354B26AFFE96309B18D5DD0E4A29@DM6PR12MB3354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWzypLu9s90xMiCYZG1Dt4ywhzQ2yB37wp53sSeM7e/uK4Hvn6kv2hfW+6lzBn4bivZ7pWPvXkQQrNaZUp4/YxXsFwbFtelHchDrcYrTNPdknJlsKh1DbwZ+0YIpyUgXbfnm6cqcMCtVaoOI3C/3cyNesGBlFpQzw96yE9Gnw+9/z8qtIndr41pSYohCPEdl46sg3e7A85HJt6l3hBCShl0yVyZlwH2gGex1/iPVeWNh9vz5Fawb5QaqrOp9F6tG9y66kKtrjm+imw1bBjDQ1SrboOFqQ/zrN1XFWFEsFycG7UJxKAa8jTLjcYsggbM6O4V+v6HGMcxJYTf1ebChdxgWRGMdgihaLjcFS8mrz/w7iEW8b79f4bNKAq/hfM7AJ/hNHPc1jN6efbM2ZJN7KQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(19627405001)(186003)(71200400001)(316002)(76116006)(26005)(8936002)(55016002)(9686003)(7696005)(6506007)(53546011)(4326008)(8676002)(83380400001)(91956017)(478600001)(66476007)(33656002)(66946007)(66446008)(5660300002)(66556008)(52536014)(64756008)(86362001)(110136005)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cVF20FwspqtWIM8n8Kb6PG9aTycjRiQGvpuxV9afLeynt2/DeZgPwAC6U5FHMYI/+aYUvO0E5d589y12oVcdb1+VFE3XC4qlYn3QI49lvFCNjVy0XnAoz8P5Pt+mTo5prhbUhMN6jOmBphr8QnErb4WftTdgOBZHHB7iHzk6RnRZ653rEpDbIBUFZUXmPD5IJgcI6Nk/izpv+NKzfCBBXfEOGWQ+U1SsGBqtW+4hrYgsqZzyMwaFUm38zKRp5VbDEo/oCIObKy2XqdHTzuL1pMVM4PUvpPAuOrtl8JkCqRemFG0r4+N0y3b99fC5SRa6yJ/Z5eS10YjH12errSoPgOYb9GfAvja6ZnHq9ydL7F48z+jSk+NfrwZtGL0zvXrMTPG9xXosWouFsxJy4Hq9sXId3N4NlqIFk8memdbeElOQM4nyz0vHJr2UQ1FETKJCn2NKfbFj58JgoJP/S7Km4VnOjgoZ5mXKgq28/ylhDKeRZU81dg+1Ia9RCpb64XctcvrdbzJZFIWbglyaWQHLzeetN92VYLyG3Kr/6W6YnNnhiQNuljFZJ6oCIgmDClvtwBcjLa8HetHOd/uMZghRqusebtgahfu+do6T16FCt/llo7GYq8t5v1K/+NQCaXVQyyaxmRvg2WZVZI1gwOrNZ3z80tFdwO+6z0mKVH9KITPf3A4H4Ngpd7aPfEQrdj7zqwKeN9McVpoM5ZzlKsRG+TwuaV6yA2aMPc/IKX6ZHEQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c297d49d-a3e1-472a-612b-08d8bd5c3e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 15:58:34.8379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: at3Drjhkgp+tEZL1QOCWTwyco4QmN8BKclLgelv0iGUmrDZt68Or6omfGioNTUMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Boyuan" <Boyuan.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0824795229=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0824795229==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB25174F3DF3A018A0A1132E5BE4A20DM5PR12MB2517namp_"

--_000_DM5PR12MB25174F3DF3A018A0A1132E5BE4A20DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: James Zhu <James.Zhu@amd.com>


Thanks & Best Regards!


James Zhu

________________________________
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Wednesday, January 20, 2021 2:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Boyuan <Boyuan.Zhang@amd.com>; Zhu, James <James.Zhu@amd.co=
m>; Liu, Leo <Leo.Liu@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: enable VCN PG and CG for yellow carp

Enable VCN 3.0 PG and CG for Yellow Carp by setting up flags.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 801cf79353dd..903e1ae166c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1020,9 +1020,13 @@ static int nv_common_early_init(void *handle)
                         AMD_CG_SUPPORT_HDP_LS |
                         AMD_CG_SUPPORT_ATHUB_MGCG |
                         AMD_CG_SUPPORT_ATHUB_LS |
-                       AMD_CG_SUPPORT_IH_CG;
+                       AMD_CG_SUPPORT_IH_CG |
+                       AMD_CG_SUPPORT_VCN_MGCG |
+                       AMD_CG_SUPPORT_JPEG_MGCG;
                 adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
-                       AMD_PG_SUPPORT_VCN_DPG;
+                       AMD_PG_SUPPORT_VCN |
+                       AMD_PG_SUPPORT_VCN_DPG |
+                       AMD_PG_SUPPORT_JPEG;
                 adev->external_rev_id =3D adev->rev_id + 0x01;
                 break;
         default:
--
2.25.1


--_000_DM5PR12MB25174F3DF3A018A0A1132E5BE4A20DM5PR12MB2517namp_
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
Reviewed-by:<span style=3D"color:#c0c0c0"> </span>James<span style=3D"color=
:#c0c0c0">
</span>Zhu<span style=3D"color:#c0c0c0"> </span>&lt;James.Zhu@amd.com&gt;<b=
r>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Aaron &lt;Aaron.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 20, 2021 2:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Zhang, Boyuan &lt;Boyuan.Zhang@amd.com&gt;; Zhu=
, James &lt;James.Zhu@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Liu, A=
aron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable VCN PG and CG for yellow carp</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable VCN 3.0 PG and CG for Yellow Carp by settin=
g up flags.<br>
<br>
Signed-off-by: Aaron Liu &lt;aaron.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++--<br>
&nbsp;1 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 801cf79353dd..903e1ae166c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -1020,9 +1020,13 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_HDP_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_ATHUB_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_ATHUB_LS |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_I=
H_CG;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_I=
H_CG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_V=
CN_MGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_J=
PEG_MGCG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_V=
CN_DPG;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_V=
CN |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_V=
CN_DPG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_J=
PEG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB25174F3DF3A018A0A1132E5BE4A20DM5PR12MB2517namp_--

--===============0824795229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0824795229==--
