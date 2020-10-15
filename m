Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700D4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 21:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0D02076A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="St0DmwLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0D02076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295CC6E02D;
	Thu, 15 Oct 2020 21:45:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD33B6E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 21:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np/Xt0Gxi6gHTQeXXlahO0bZ67/J/b8O/W10Cd8PeEQdQwYNvm62hJfL1KnDkfuoPJR23ry6Xgj3Ri9pwKcZRdOEZD9X8OoSRz9epx5HIxrRhdCCcFHALl/x84ySjjO7dGIX1LVy6q3AbgXn6U8V4S2IWrFAVoyP1CVbybT3gUh/JtYyo0wHD1VfAUkJAwhgNqfuUdb8Yp3O9k+rsHSV9P0s/QMv2mdGiNFrUfiYHDOQlEYPrHvGqG14HroSQUPXMxzG8GxkzQvKcZ4MMYXvwGAgPUaQ5jR0j1+VZEyFenhAxJF2d2j0J4IVNnmMb4kgPo0sI3/y8Q1ImYxgGEwrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj86g7qwe98BoZcN/3v0IyXgLnULMD+TPbFGu/EXIxs=;
 b=gsI331puWpQOFhe/rUChwDLCOUU0RqUChikbIKb9wu8iz46R21euhpQijmOYFx96QdPOr9kZqBxpUKippMkMytdhNBfVDN8xZQ2JTl/qU4/cJg8vwor6jGMYD6k3RDKg6Snpl0DK28TjT24kv7MRDCFXXmDPN+MQSDSnWbvD6UmQ4ucMmQEQKndDMeXpVVqHEHmw6kQRBumF44kSrrqpN6DZEIZbjohvImEpLa8Sd8epbxlOBjdVvKp0+hW7MH4nzAzIABSZNVJqYG40Hk0GraeDBVZTmbDdTDey5cHFNjqrKg6/s9EPCTWkZeDoaMx1X8olPG6+Ch2zx0TH363GNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj86g7qwe98BoZcN/3v0IyXgLnULMD+TPbFGu/EXIxs=;
 b=St0DmwLQzWhFpxD2gUvx+g0x9rn6z+fUcTd8o5CoYlRS3oNLqyOGDbgJi0HwTCGqNPjji8SeXYdRmlULaH+VFxpyg4AclHZ5LWbSw7iEX1mVx1r/dkGtscN6rxYDvfJzXGl2wdCkurdSNr1EmvA3VpE6vzrugug7SRprQzBQ52E=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Thu, 15 Oct 2020 21:45:22 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%4]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 21:45:22 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Avoid MST manager resource leak.
Thread-Topic: [PATCH 2/2] drm/amd/display: Avoid MST manager resource leak.
Thread-Index: AQHWok7yp+ZO3G9PSkOsX1bBagRZ5qmZND6U
Date: Thu, 15 Oct 2020 21:45:22 +0000
Message-ID: <DM6PR12MB4340272E881337D296BA1D6FEA020@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <1602696294-5611-1-git-send-email-andrey.grodzovsky@amd.com>,
 <1602696294-5611-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1602696294-5611-2-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.228.232.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87c993ae-842d-4707-3d6f-08d871539e1c
x-ms-traffictypediagnostic: DM5PR1201MB0107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB010792EB5996DE5649D7C0D8EA020@DM5PR1201MB0107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNd/G9IWcmkxVrqcIT6c68cZSKXaC5rTh8Jex37U4sVy+uDgRB7V+KXi3KLWrX3dDkC1/+m86wM4XBa2lzUAaYt71N0HrIVYBsmCUae4NOxOe99FksxLwsC3cOAD3KqJRer/Z8iSP5RTGhZU0Vxt6/Olz1+9Yzk+zq57L8v0Ruvs1fapj9h4hM1tle5K8/nzzDrkjc4X5m4QGq9rQuetl8HEXgN/TBjKzTnCFulZCDr32blICOBuuQXl4bAFOuq1S0hq3DaW2DlbNIgdGtGuzkqY6mI7+MzMIRO3qenQ2/7LOCF00FtlDRwMK52d3V2m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(71200400001)(66476007)(64756008)(2906002)(66556008)(66946007)(66446008)(8936002)(55016002)(478600001)(52536014)(5660300002)(33656002)(86362001)(54906003)(8676002)(4326008)(7696005)(53546011)(6506007)(6916009)(76116006)(9686003)(186003)(91956017)(26005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aGjOfZge03UquyBHV0dau9S665+ZRF/sw6H5Q9iN5ruJVUtUVQg+ICIyxpum0ZImqLPNYzYDE4FKVRKSo30JXjyEIa+JPSWZtRdAiVyA5Fw9QunYvcgzUnFwaODZ2h4qnIH8brOLBo3nGNseqHUcsGluDfQdWHxqQmk3No0Mi8/6gno+vmiC8ALPmc79HjOvaQSyBAr25ffEVBlyLgvKTdla+gpnCC75Q44xvanCx1bw8OKonKm0R0SMpczhBUhTJPrGHJS+fU6RwRxjJweLpEzGtXGl046o3mrkWZHXQ4uj+/CuKxJTtI3GKBEGwljfsIsmYihNIOnDdlLISXMKmwdyT9JS29gqfxdP48CePnl4DxxzDazJK7uO99NVADhrT+aByqSpp9oDSPsCmfutqOiZ232e/lg0KL8cKpxDNG+d12NDOlXlqO2ARt4vIfxiG4SSK/YQtUhKnwdMoXPogR3bKmaZPeVNGxmukoC+wdQ7DbGJOMWHI7bRCkeapzqb+h8LNY5VivCguXbSnNuJS4S3Q4Fk2Vj+QT6Pm3yK7JgA6DJbGmLNE7rgaueahKdRdmVpF2xfOjU5HKcFRImayxYW8Ofp4KxpZGNuFIcWfW/7fYebJhB8RjPUYy++yssq6rGmBo8PYdaBtbT6W1rlOw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c993ae-842d-4707-3d6f-08d871539e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 21:45:22.0147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGiE4f4OLmFZH0SoC4daAobRgQSb/ZlXHegPmYC4kublkj3gqbuBQ70c/th1LJBbWXnoaYHjJ17DrkgSZVb+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============0013761014=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0013761014==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4340272E881337D296BA1D6FEA020DM6PR12MB4340namp_"

--_000_DM6PR12MB4340272E881337D296BA1D6FEA020DM6PR12MB4340namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping for both patches.

Andrey
________________________________
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Sent: 14 October 2020 13:24
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wentland, Harry <Ha=
rry.Wentland@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Grodzovsky, Andrey=
 <Andrey.Grodzovsky@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Avoid MST manager resource leak.

On connector destruction call drm_dp_mst_topology_mgr_destroy
to release resources allocated in drm_dp_mst_topology_mgr_init.
Do it only if MST manager was initialized before otherwsie a crash
is seen on driver unload/device unplug.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a72447d..64799c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5170,6 +5170,13 @@ static void amdgpu_dm_connector_destroy(struct drm_c=
onnector *connector)
         struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
         struct amdgpu_display_manager *dm =3D &adev->dm;

+       /*
+        * Call only if mst_mgr was initialized before since it's not done
+        * for all connector types.
+        */
+       if (aconnector->mst_mgr.dev)
+               drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
+
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
         defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

--
2.7.4


--_000_DM6PR12MB4340272E881337D296BA1D6FEA020DM6PR12MB4340namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Ping for both patches.</div>
<div><br>
</div>
<div>Andrey</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andrey Grodzovsky &lt=
;andrey.grodzovsky@amd.com&gt;<br>
<b>Sent:</b> 14 October 2020 13:24<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Wentla=
nd, Harry &lt;Harry.Wentland@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.co=
m&gt;; Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: Avoid MST manager resource lea=
k.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On connector destruction call drm_dp_mst_topology_=
mgr_destroy<br>
to release resources allocated in drm_dp_mst_topology_mgr_init.<br>
Do it only if MST manager was initialized before otherwsie a crash<br>
is seen on driver unload/device unplug.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a72447d..64799c4 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5170,6 +5170,13 @@ static void amdgpu_dm_connector_destroy(struct drm_c=
onnector *connector)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(connector-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_display_mana=
ger *dm =3D &amp;adev-&gt;dm;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Call only if mst_mgr was init=
ialized before since it's not done<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for all connector types.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;mst_mgr.dev)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_dp_mst_topology_mgr_destroy(&amp;aconnector-&gt;mst_mgr);<br=
>
+<br>
&nbsp;#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defined(CONFIG_BACKLIGHT_C=
LASS_DEVICE_MODULE)<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB4340272E881337D296BA1D6FEA020DM6PR12MB4340namp_--

--===============0013761014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0013761014==--
