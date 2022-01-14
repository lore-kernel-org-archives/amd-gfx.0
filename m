Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954FCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 16:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D82110EDF6;
	Fri, 14 Jan 2022 16:12:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE2D10EDEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 16:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaDzBe7MoAtAR1ehFZZI22hr8D5jho7F2i5MtOXtkPbEAEuC5M1mw8COcYc8r053zLbyPZi3VWQJ7godp1J04QC1uwNkfmZrN7ekYBGf+hChWI8IgtUNza6j6Bt6/YnXABBo9DP1nm4sZopSdi14C4MN2BhXzhXC8y+gEI00nMKJN/Pz032P1a3KlaOSgPsqgYuuQwvRY5+RuvQdmOvGCkHbXrez4pyBFPecH0+MGyUHN0V/4K92WEIlOZ47PBUtYy8RBtzAOdzw7d/GCLsCb/cchrZ1V6Gyytd/jQjXAPpAS92I3eTqBH2Nrf9PKKXx5VusC2wYveJ/8yDQad46hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DotnItXy4NOAH8O/vPAnq56ArPSxd3f42Zn4BZAHN60=;
 b=bX7ABuNL5wdcEKozmUUd7yV03eqAZUMeCcGxUy9rSFcSmHX8wfLbssoKjG6Sn4lQ2AeQ+jYCzY6GWhiVxJi+VndW+WUogMMLlMCHwJIQoT5bI7tBrqahBifXmysRG3vVGBa+Y7lOHuLSUN3cDKSnwSDNNZDbdh70228qh524I15nE3+i+DbUxMaGpc7Tdb4qRJYBx2Nl46ebgqa9lF2SvYsm/rsrDGYzlI/38Y/9ZhPWMq20WTDS698fr0BMsNd7WlyDEOPXouua400kfp07CuUdNRp4Q05DddfFcXaIaD5Z/9HAI+9CF52PBZlV/RpaV8pQeMUoV6g8z+eQ79G7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DotnItXy4NOAH8O/vPAnq56ArPSxd3f42Zn4BZAHN60=;
 b=MUwxywooSiejcZbfZMW/ZXdzeJjzKtzv7a1Im8EbVvfUnsx+X0r+rjKuopjSP2vSxzOoaA4XbbHPGGJExplNihe3Tlbo3FQ/CZMZoeX3MulZwGF35sc7Wxznl6XBw+zSWHsIKxB5J6SWH5Y2+/B+htBH2/MbkwuGxvayRiMhPd4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 16:12:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 16:12:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: drop redundant check of ip discovery_bin
Thread-Topic: [PATCH 1/2] drm/amdgpu: drop redundant check of ip discovery_bin
Thread-Index: AQHYCQvcKGTtAZK6rkakDLX8pCvKLKxisLv0
Date: Fri, 14 Jan 2022 16:12:01 +0000
Message-ID: <BL1PR12MB51448FE8DB06DD496E58160EF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220114055840.12734-1-guchun.chen@amd.com>
In-Reply-To: <20220114055840.12734-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-14T16:12:01.301Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 5991ae92-7286-8d47-3795-46ca7da06b95
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7eedf515-6039-4277-68f5-08d9d7789983
x-ms-traffictypediagnostic: DM6PR12MB4730:EE_
x-microsoft-antispam-prvs: <DM6PR12MB473051A77BCA01E5FF5C2963F7549@DM6PR12MB4730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKu9rNFxrkKjenPqwsriuvtBrXzYD16lwsQBZ9DSQZYI4RA/RqRTJ/VgHPOLDf8MoVhdIejAhJkZ6t/e2qt5Hi6h30a92PWk6qm8Hrgqz1S6Nw8ps0Au3rswP/t9mR/luPzlvYW9D0GJIriFFVAL5FADGICpHjUxffXeAjyNUoXkfmtveNgvE8Hu3MrY4sRGT1dlD5MeW9BeIZsNTehdnNgeg6FJKTfokCl13ZBYC29tzrF8SuQrMYCVyY+3WQ5I/xCJXOOMeR0fhjML0MIN4CzzMJOWxmoih82ffl/aCx6GfdSGUcT7yEKSqFKHA6iTaG+0wzW/AzWLaR9nX9uDmiMeW2g0YhvYmy0TdKADIcf+wrSaFzGMa1x3rk1GjjwI/hdVbdgzE1mnV/qAv/SWhj1mRAxcERC+CBL00bqse9rfH7//HjiBzoW6EbtujA1qHqADFNSPWR539BkOYueQ1uA/D9uuWFZpdvSdzM9P6q7LvUUC9ZFuSf/l8+ZLwLOLp3DKuYLiWLAMdU7lEOHyCZ2FQOklSNYipCKepXqdsGcc8l0rVWZbGckGWmmC7bHInpVeiPNiVfXMrgHzxCJeN6s08wLkuHNhyMq9eXmnxabn9LuQrs7NkrZPewDgY0tTLRHWv0ylP64si33r6XayKHDSPr7GYUaYgH20e/Puqu91G10U747PpC7ECKBAJ158B8pqVRvvLfRp2yyGCKpsAWLgK3XJCN1vL2cAIjGCtC4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(5660300002)(508600001)(83380400001)(33656002)(71200400001)(7696005)(9686003)(316002)(921005)(110136005)(76116006)(19627405001)(66556008)(66446008)(64756008)(66476007)(52536014)(66946007)(55016003)(2906002)(38070700005)(26005)(8936002)(186003)(86362001)(53546011)(122000001)(6506007)(38100700002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hsxxefgizlDAdUdwYkCFEjiZfIhHpKny2ZFcdwdnfauxEkBUyE7DRSeGEPIi?=
 =?us-ascii?Q?MIoacuUfrzQpxJ1y9SF4zgt8GGMjNn2MD4S7VlnVctOEGTedwjcwUuyO4tYt?=
 =?us-ascii?Q?ALFU4RFzLdFBQOLaiVfuFw98KM+n6dyYTc6Fq+E9E/dlVjgJkLSXKZkKYNG5?=
 =?us-ascii?Q?NEI6FHiO4oZ+jLoqKLLnCRgLfrNL8gyyNczEyoNjjKGiLS+FApcKQ25RR2Kq?=
 =?us-ascii?Q?BCKvv+WFnJKaFt/qtw0Zq1MPTB/WJUBjF6aqXh4Po27I9Auk1NKGipZ8qT2p?=
 =?us-ascii?Q?+H50s+g91yvO3/fD2+uYOP6z/eD5AX3Cz211/vZPHtiTTToCVmXSEaU63ESn?=
 =?us-ascii?Q?L/iHYEljpx+nJJTp80zXqC4NnKN7SRrUYGLrIGeVIcPAuDytk8QwgIbZMHiH?=
 =?us-ascii?Q?odeOBe4PntO2ocoorAhFrhXtp5L5zfzFLm4H/Xwfu1ZzpIIbNiqRZ+Jz3+a6?=
 =?us-ascii?Q?CYOhsweRDCsJHcLjyIO9uh7w5HeRTalGmCtGgg1jiBfu7G0ihM5L+Tnw5mOe?=
 =?us-ascii?Q?zOQZd3/21o41nzyL4jObk1aN0tNlufDd44buz8jnjXu0yA1PGFH5rIagoOZk?=
 =?us-ascii?Q?Wy3AdFYMhYy7kc9YHNtp7+AQ9FC6qFK9XZjG3ZG77iGsiVNJq8+r+r+7rWuE?=
 =?us-ascii?Q?cRXzXpjp6XMjjJdbMcVmn6ycTBZYBHgITGX7T9YzI90UTYI8+kCeEx8FqHIo?=
 =?us-ascii?Q?mWFrj5TYaMtGdtJ8mZjSt3epmh8MC0XAAhM3MLu7fDiwktKLJ58j2KVSRekJ?=
 =?us-ascii?Q?MJoMRTKooeFcZ9LTpYf61xyLCl1GV+/twQd2w/3EmamHcDcby4DCoz/sJHbd?=
 =?us-ascii?Q?TKmzoMlwpzsJjRsged/RGJz2vSz1CJ/sJlhK5fVcAw8c1Y7gIlSM1+HJDFxx?=
 =?us-ascii?Q?OIjrxvjYpywmQpn9MBHCDK2HxAWcPArAFIIoguS4RPZdEDqCX1pMg80ii1Dk?=
 =?us-ascii?Q?71Tc/P5zhfpJTiDBIQYRgt8WMKeONiQcZ3I3moHicrlOlYwyOcEKclppVN1S?=
 =?us-ascii?Q?9lVhs6p03qwmzZh7jyqJlYXZV/IcZ2Xh/t3FT9R+ZCwthTAGZBivjAgr9/PI?=
 =?us-ascii?Q?66k2i6Ggqz/Tko6QKX5hkSUmUbUElnoYKBCoCYko6+3jLSeLrw1GmIzRW78e?=
 =?us-ascii?Q?pzLssCrFO8Pkx3EfaRZJD4oAZnItZlCkqlWbGYP4zUSgPsw8roB+BnPqZj7n?=
 =?us-ascii?Q?PNmu1y5tZ8/UMDWyofqm6m+4ZRYot58WhJxwetFqYsdKT8He2bG6V7Kl8gF+?=
 =?us-ascii?Q?wTLDqGsYZlaaMDSldcL5/FwweolDQ5Z301Sqy2NPOC+5QPH/hrSJr7mB4iyE?=
 =?us-ascii?Q?Fp7QKWrvZBarwv125hObhb0Vweoh3VxII7tHOyR+R89nnPTtaAYxTAZkOY/t?=
 =?us-ascii?Q?5FZn2D0aDjxoC/uEkakWGgsxyt1rd7xb+pz8mSFpZFQkh58oUQd3/Sp+xG4e?=
 =?us-ascii?Q?C6dJAHPyoZaJidi4A/b1YBWQ772bwbxYjojQ9/Y3kxYhl4NapVQ+BQqGQpXc?=
 =?us-ascii?Q?oSgsYAYbJZy5GdUQOFpgipcriVqRqQweXKbZLLxb91UuW6OFsM/iGagUzeyh?=
 =?us-ascii?Q?XqvUK9N7uo5t8AyCw5Z2JIkHfXKSASnuhTzDWtz7EQV1XDdI949EC3Ffzot/?=
 =?us-ascii?Q?DKDgVpcsPhafD2YDo6gn1Nc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448FE8DB06DD496E58160EF7549BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eedf515-6039-4277-68f5-08d9d7789983
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 16:12:02.0115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TX7sx/iL2slpnEwav7TxrINL50I7ClduxWQvy1rdv1XPry4px1Pw7+5UAMUNkLfDGs0YNvyTJKPGKeOWtG8s7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
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

--_000_BL1PR12MB51448FE8DB06DD496E58160EF7549BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 14, 2022 12:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: drop redundant check of ip discovery_bin

Early check in amdgpu_discovery_reg_base_init promises this.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 57e001d73ec9..2f891ae90bad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1194,11 +1194,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                         return -EINVAL;

                 amdgpu_discovery_harvest_ip(adev);
-
-               if (!adev->mman.discovery_bin) {
-                       DRM_ERROR("ip discovery uninitialized\n");
-                       return -EINVAL;
-               }
                 break;
         }

--
2.17.1


--_000_BL1PR12MB51448FE8DB06DD496E58160EF7549BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, January 14, 2022 12:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;;=
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zho=
u@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: drop redundant check of ip discover=
y_bin</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Early check in amdgpu_discovery_reg_base_init prom=
ises this.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 57e001d73ec9..2f891ae90bad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1194,11 +1194,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_harvest_ip(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;mman.discovery_bin) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
ip discovery uninitialized\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448FE8DB06DD496E58160EF7549BL1PR12MB5144namp_--
