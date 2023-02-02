Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C4C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 11:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7070810E163;
	Thu,  2 Feb 2023 11:43:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B0910E163
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 11:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoplEbjlxYD62bS9J9tSFD7EpNK6uB1CtRivZO57F1iZwsl+I7U1cMNOyTFJ1yhM51EjA5Kx0NNxjrAL4va1H4MVKJVy8YA8qkKZ+xiW5mGfBgHHNf/fMlPk4Z76NL6WiA7/dhgqdmoATpddjRZ7/s4W8F1g4HpI3rcZ3fx214YUGUj/duN5LKBPfPoriE7s820/e0m4sq86MCVx/TjyXLZMCKBheredrjv5kUHcIgamy4juj5guWm1txDTjP7ENn2MjnVcQzokYDg//uMS3qE8kGk01E3Y+b+JhjqG/3dwC5DxKMTn5+9SlnU4Ll3DUwaLsQUABiaG9c847Kg+XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmrHhCJxoByFMpqUI0RMrYRYtKbWlwuiAyzpJNJswhw=;
 b=CO5mj+HGQZGybDsumFRkK6N6gVANBZMLdtkTgnwkRX8fYXWFUZPsc4CZETxEylFsFMvwxsQ0fH1kKj3Traz9c3OBOsMfNkq953ySLm+K6eArtid4wP+3ShWyXkAAJrWsEb0qYXW1CbkMnC5vemvgCyE+P7Zhc41s3DS+iqdZ4F5zvVfCy6NOVcQ5hM9jyqb5RmG9jofHUI1oFco8yg9q7JDuR1r6larbXkkSozKOeDIpjYjRUlErhVvFWGud3k1vp6EsvzRZrqu4jCid8g2vyh8TKkUc5eGUtunRzLHJXvAp/hppBasuFOvHBZjBWKF8f+8Ocb3E6b0V7Z4ia+1Ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmrHhCJxoByFMpqUI0RMrYRYtKbWlwuiAyzpJNJswhw=;
 b=1X5u6NKpql81esDVgpBm1ZzKrNXHUDb+TWELYImAwvRfichQntaa8b30AdU50qddlwrYFln7dPgtjmQ0xIZE1B86vUKmv5U6O3jmvtS8nmMU6HxK10nrEglVJX78w1187Nzm3m0GhfU9BLaGBgjBSg7NSn8mvILCZCNUqywyxTY=
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 11:43:28 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::500a:d02f:5ceb:4221]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::500a:d02f:5ceb:4221%7]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 11:43:28 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Index: AQHZNuxfM4airT3AskKWHuymsm9hN667iOcr
Date: Thu, 2 Feb 2023 11:43:27 +0000
Message-ID: <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
In-Reply-To: <20230202095416.4039818-1-Jack.Xiao@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3589:EE_|SN7PR12MB8146:EE_
x-ms-office365-filtering-correlation-id: 36532fda-9e5b-42af-b38c-08db0512b350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJaaE51bE5s/ZKTwTqQvr8DXiSx0oemHw11h0IDoTovTaW+FYLJaJfnml4PQv2LgmUHiM76a+YGqNAkZisKskTiupw6z72/1c0wP5rPhVUFbOfmdNdJcue4WESQolXsuajU8h+MNy1UCswfHNB/AvH1xkE/HTmDu7r14nxSMvnfLV4WRHtjBvpyAwj9Kxk4hc4EZV+VY7kM5XeibSFLeECIfgixK3vwIDGSi+HiZCRKVG43UKybwmJY+U4z/mUeoM48PVfA2/qAr664W3HNavouAlltr7dXNtb6KrXkhrbxQB6JRJ9RcgAcPvszswoSD6J9RRHHU4yrrEDxrfjMI3jVvsFsRJgupFewWu7JsG9IFZ5GCx4gDkjrdwsCWUy0fRxhmDDb/RVOcfJWEB296NqtsR0YKwIB2DeYR70Wgx03d9RPOFFBi1w1TBv1rrP4s22iTMwbVwoTtdVjsVFjt9l0VSbSUngw0db6d8mGtxTT9BLo1S6Wwpluo0M42znox7KE13npPKxBzimBxrIk9AMZimMa2TBZNFmRQ5XiuHaDX9TsulZcoEwE6RohbmQO7MRFb4wBNwEzRIp5NpsiB1fJxKlLtanPnwLSEuavKIH198jZb+E3AXxxzvAnCu04+0pqN2FxHsT7dIvaiq6lWpe503naZcJQVcR+nSwx1YX9SDkcns7HZRXqzKbTbBdKhKJvhOb/ZMDBEhOZKss4q5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(8936002)(52536014)(316002)(6506007)(71200400001)(478600001)(122000001)(86362001)(38070700005)(7696005)(38100700002)(186003)(6636002)(33656002)(55016003)(26005)(5660300002)(9686003)(110136005)(2906002)(64756008)(8676002)(66556008)(66446008)(66476007)(66946007)(41300700001)(83380400001)(76116006)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Glc14GwjWot+9OI90QjVaolg9CpN3IScX3SL0KKAta4NC7onh2Z7fuOm7oEp?=
 =?us-ascii?Q?WJXPZ4PNSknjV7kKjI4aOQD7UGnoSuTy94ZzthXzh7EMwDVFoSlz/D2mileB?=
 =?us-ascii?Q?2zNeVKeDwwNr010eR4GSRaubKzdeLbdmh7buMcm+B2N0LLaYuw7/ZhTWe0qY?=
 =?us-ascii?Q?c1Lf/46s4vjrd81RfddHN5aHFwq5WXpalYkkcdr1dvT9NK6nWtIuF+FlclIr?=
 =?us-ascii?Q?hYa3QbPstapbWgBqiTPYeh8suamXvwsZn4adoWtDgdIqdw+70ox51HBv+ztf?=
 =?us-ascii?Q?GY4aVCB2f3cpjijbCe0KK3W9qDqfP03s4cVvwFvTgNduwxTzRSSSbSsLSsIY?=
 =?us-ascii?Q?egOW4lwqu0lCT4afBfsfAXP7Gzfr+N2zvdRO7P7TfI+U8nNlOD4zs9vhWKgH?=
 =?us-ascii?Q?uv25UZEabUpwwE1INA0YB0J1Zf88+Yuo9uDAGgB3l6g/7f/4PGwwAorbV/AK?=
 =?us-ascii?Q?OOzNDneI/bsOQBYFSrC8qoS3zmH0HsiwUyb1DunukX98ci4nAP9aV8iRpzIk?=
 =?us-ascii?Q?sEuAVwtuTstE6b8BfjBOXx9bn8Y5E5N+mpYPpXCkrrNf24HEtBU1ry/v7Hfk?=
 =?us-ascii?Q?ztfO0+WpJ8yqwtX2dYUn9wXBawnp2QKCCrgURaIfGe1ZNjoxDMUMvFQ5l82W?=
 =?us-ascii?Q?CHsKzY8b6bPx2vCpGkSvcN/YuGXOMfWaJJ7IDke5nT0xv2iGcuAfhiUr+Id7?=
 =?us-ascii?Q?OCFN4pYi1vQLv2Oofnjc+d10k+YLTTr8NwfuiOQ2oZsb5GdXPp5StM5QLQ2V?=
 =?us-ascii?Q?otjQV3EFNO3g3MynGab8TPm3lvhKuVvVqwIxoYfcQr3E9Stogsx4xKL9wsLp?=
 =?us-ascii?Q?gHdCdyMhnawk5VQ0Y28E5U26R0pILcGQ1FF1Cu3bsueNDCE9Yb8lPdqhQarG?=
 =?us-ascii?Q?S3zBmQJLK7bBKUBfir2mKB5dx9inFA9xgcsihtPjY3yrb5UcH2uVRjO/71Ly?=
 =?us-ascii?Q?eRZNgTtK+N1dqP1DrdtGg7RDKmZ/VKnhAAOLubBPW/bYBIUDwtkmjkHhqbeq?=
 =?us-ascii?Q?UoyToqHrTYzktF9RvFi8xqm6pWyWqMnk+aM5nh+Uh1LR86fhQzGeQk9mhPtX?=
 =?us-ascii?Q?oNKYXa+hSPB6+YiObF2BcsMrBQycmvfvR85tWKZ6onWOSLGownX91lj1v3RF?=
 =?us-ascii?Q?CoGQkPw/nP29fu7eF24JAQ2lw5PxkZTgqxlafzXc+aHhSsHLXO6CsY+1/d7Y?=
 =?us-ascii?Q?4WnxC4AhPftRw+nA2QIJww+ySqYGS4e3b/o4fHeS6h3HY7mUFnIqh+6FSUZh?=
 =?us-ascii?Q?IvzPBMnJwoYJ3q68O7hIpKkwEfgIClkl7CCw/BihgCN35J52LcdvtzsnerHD?=
 =?us-ascii?Q?eOIpEwkR6FXVx97bBWhMoC3Dy94iioPVBbGRDOuF7hrJI92E+ra/G6tnpAOm?=
 =?us-ascii?Q?PI1ZDWHFm2uVclmNUV/w1JJHARKp01/d606zsMWoD1eElB3JML+Kh64rY82M?=
 =?us-ascii?Q?VrIx7V++wFZHLX8gSkxwj3GLY8zY1P+kgwKx+DyLTTlvhTDYypiWJDz3Cfih?=
 =?us-ascii?Q?2dHImfVC6+ek2LeqZmG6klas8uC4PYagxHbP8e3gbnXMvq0t7EgTh7E4DzOQ?=
 =?us-ascii?Q?hReY6sDKMGcMCH7V1Y0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB35899E39061894E55AC07FE383D69BYAPR12MB3589namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36532fda-9e5b-42af-b38c-08db0512b350
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 11:43:27.8549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEb25tNMQbsms7dEvMtEflml/zSNxAuHoxU2idB8luHHckrdqETsEIkEPLcoT2F/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

--_000_BYAPR12MB35899E39061894E55AC07FE383D69BYAPR12MB3589namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Big NAK to this! This warning is not related in any way to the hw state.

It's simply illegal to free up memory during suspend.

Regards,
Christian.

________________________________
Von: Xiao, Jack <Jack.Xiao@amd.com>
Gesendet: Donnerstag, 2. Februar 2023 10:54
An: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Betreff: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavaila=
ble

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,
         if (*bo =3D=3D NULL)
                 return;

-       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+               !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_T=
YPE_SDMA].status.hw);

         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
                 if (cpu_addr)
--
2.37.3


--_000_BYAPR12MB35899E39061894E55AC07FE383D69BYAPR12MB3589namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Big NAK to this! This warning is not related in any way to the hw stat=
e.</div>
<div><br>
</div>
<div>It's simply illegal to free up memory during suspend.</div>
<div><br>
</div>
<div>Regards,</div>
<div>Christian.</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Xiao, Jack &lt;Jack.Xi=
ao@amd.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
<b>An:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is u=
navailable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reduce waringings, only warn when DMA is unavailab=
le.<br>
<br>
Signed-off-by: Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 2d237f3d3a2e..e3e3764ea697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_=
TYPE_SDMA].status.hw);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reser=
ve(*bo, true) =3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BYAPR12MB35899E39061894E55AC07FE383D69BYAPR12MB3589namp_--
