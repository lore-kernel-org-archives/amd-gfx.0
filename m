Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26E0C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 14:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DBD10F4ED;
	Thu, 14 Mar 2024 14:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2LyShoAu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E610F4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 14:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSBz4o5TXNJEKyEp3Kta0QmotHn6P7oeX6kXxykvyC7CHsuTPc4zk1jPMEoFpWfawHBYx8NsIQnmyulodPBW7UIO1V/YUBEkLZ6uKJ4VdfSSiIW/yEiykJZD/1kkmmKuHU8i/qD0RUL1RCvr/fCXq45Q9kwz5/EnLJBfOkuzXrkGrZYFJOCjvWBfXXsRrjyImI0enyes7wdIbaDN3oqXKXNtV2k+Ez/V1fokePDAQq2LIwdFJwIi+QhdjI8Zx6rmLWlXyZClmio42/Elj9SYyKMPyN9V6cHHi3mlMip0ah05ZV+Hiry3Gavf4+rQ3DP/s9FcDOl3iwNymN7f61m7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP55sZLSavRJcgVkSzjvwaDwA6eTlffMWwhBI6G0ND4=;
 b=mKGntT6xfX2rY53eyQaICRMbtjwRmZ7aVgv51jcy5VeKHSp0vDK1JZ8v/Tpzg1dpdmmgGcczlihRViRJRw/YFDzQibTXTtzejDnBnhVV0XUyyXqYq5FFd1GWcne74pHZKCFDXdVL5trYYB8dhrnohJrT9FnfLVGRr5RXq4oi/kabSaYzmJ/N+Bj7kz56nDMPhLWv2+EXWmrLGWI9rnwpnZzgyYR6yv3XuiwrfDrwBk2nq4V2e2eDp9C9BIIubUxhilkSfM0RwUt8cREAogIeAjrmJLzCgZm7wakHP5R7MHNl7dxqVfD+9A5j9sFADXvpXSRTuqLFWuimBkaJMAu8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP55sZLSavRJcgVkSzjvwaDwA6eTlffMWwhBI6G0ND4=;
 b=2LyShoAuORTm8DRnoXSUGoUFzh/mWktebToPPVTLstQSRhCUWq27wlctDGwq9woqc4mQWBwaLNY8WaZes8cTxcdVTRMCPn+AB+YjVizFlf6XvG6lNyDpgOkAKs/Ydb8QG327LAD0+OZNFm2Sb79Pm6cNtg5YG7C51kvMS4gY/v4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 14:50:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 14:50:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: correct the KGQ fallback message
Thread-Topic: [PATCH] drm/amdgpu: correct the KGQ fallback message
Thread-Index: AQHadSj/mOMTe4M9dUOwAkuY7NN937E3U3Gq
Date: Thu, 14 Mar 2024 14:50:14 +0000
Message-ID: <BL1PR12MB51442714D6C96B5F4487F84BF7292@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240313092936.1274265-1-Prike.Liang@amd.com>
In-Reply-To: <20240313092936.1274265-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-14T14:50:14.637Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4094:EE_
x-ms-office365-filtering-correlation-id: a1c760da-aff8-49dc-aeb0-08dc44360ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6AV+ILzLSxeYGliBXEQFXjgSOrgRy2n7dEiiYG3g6VeO4ooHx6BGKdtltuB661/qVBiTlb4gQl9+/6GCnCt5XEJ+4Lq4OIOHv+MXsZ8KQEHOYhNPX3BpGC/kLqr0PMHaQxICYXfBIhrrDIglAPx4QMYIe92n4VnzLSbi+gWIQGrEn6xWNxy0lgMT5f/4Ttvue3+JjVidJdQs1lM3APRJw8qnAv3HWWe/pKC30l57CUpC4jiVLzF/H1b1QdEW/foQObf5OXNej2y+aHbmjxh0SP5J0x4fyzJdxAe1oh5umQshZ2yrmMldUV3TENDLkSvkVjNE88z7yIbppr9g82+cn7fSd2nef6k5CG5Tzr/WCmMBvrfaZeUtVYyPJQvAq8CmGva4l1x4/6y2TvnYcJGyrRnZ2/ltFRlvpvf9ofcK3nq/2lyqPFgrNkA0sKPUqXfvvGzNAFWhenbVaQPURmrw6ySfmfQ2RI4ug5Lz4qtzItUxtqaqyTu85Vl0ttvC2g56qWgxfTY3c2tk1N/iJzPBTvYReYl/D21/MNG8FnJKpVBSqxLHsvvH+x+7aAuubRWk5GjSUwoCYaiYiUKLZY3hlQjUGCq2y1EJWaoHGZWYyUO+T9p0OSulYVeg103XnSfrg9XObF4qyUTXAhD3J8vXE7EL1Bs6FGi5d2tj6N0EL+N20ZmoT63gfc+liw7yOxr6a/TwhQhCiljBzgzyEfXvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m4Yg58qXQVMyt/NLNK58EB75W9qBulLPJ6sqoP9Vhg7dg0jPOX0TW/9kKawU?=
 =?us-ascii?Q?wIz2ayHkas/fQCTuXA+fAe7Fs76XJAb2Xd8j5I/x896RR+wlpvKXQVRdZvwg?=
 =?us-ascii?Q?hrEyru11ihLTvFQTEUhTLqIyrnX5KhquIKcv5Ndv3J4NJVzf88oiCAeddp8G?=
 =?us-ascii?Q?aIQZnzI0na3cx610EKLZ7yZfUwc0cZTtsChdxLxFWitEFM4sRRH7QRbzwINl?=
 =?us-ascii?Q?6M6uzKUcj1o6vuicnCCb7C242w1Sv1/lj+D+vNz87aFj9dNJcaQXL/bn1Jsc?=
 =?us-ascii?Q?YS6NiFE1fhY1jA4L5hHjrrQli1PWzvieg15YwdVTJrNzEDtdbIXYYwrKjs+O?=
 =?us-ascii?Q?rqkS1tQObyFNpx0F5m6FkV5UfVuwCCfS7dHaQc+hLA5IjiwE/50ypvrYt2y4?=
 =?us-ascii?Q?JVUunT7oTYNKIzl0NvlmagFFFWbcwl6ltRfq6MBjJwkPVzJ8fF4UgHbvUmQb?=
 =?us-ascii?Q?El/0p+KzPSlv9x4B+eh0CoOZxnry/0VvDjQNqEGoBrIqa4x1OxUpKvCk9lfD?=
 =?us-ascii?Q?ImSDjdpGRIWK1wRQoQE4avRxVQMi/+MYjC5UQXgD2Nui7R43a3QmpuyQgQBW?=
 =?us-ascii?Q?PsRh8Tjoqx65zL6S/wZyLY+ebK8MyZfrD3IX0bj+lDoUiwweLsBSYCp2AII8?=
 =?us-ascii?Q?hrSxDNfB42hfsBbdEi7juc4BYFw7x2KgD0V/eX2L/7W466Zj2eEESOulDSTR?=
 =?us-ascii?Q?a1aDk0E2cU56WdhiOg7QkfuMILwgU0wWnRqvhkqmlvDwOzM+8T+TuH1iWvXP?=
 =?us-ascii?Q?B83SCNZ9hyWHj6SsmFreyqM0CRlaQ2wXc4lNtfMFZwJBcEHoGqPwy1om9S++?=
 =?us-ascii?Q?ZtrtYp4pEsjyWDADQvYH0uzvI5Kg/qGC/OKgRfhscuKL8auOfvRJrW2Uxs+7?=
 =?us-ascii?Q?cb6cupTw8f81lsQvF5tk4l0+YEMl9bfbesPZV/VtQkiBfjdCnST44xnNXDlI?=
 =?us-ascii?Q?7SpDU/F5UH2AP4rlOg6TqF57BMTCknsdqD2dXztYJj7tj6qSQs0RdgclYHpD?=
 =?us-ascii?Q?R9hLvg5tZz8kOlnjLzpejPqN8TqDefWXIGetBwR5sKmc0/V4RMz+tMjp7exS?=
 =?us-ascii?Q?VatFkkrXeWyyHctFnuUPXAlPYSKiRUDqkLStnuRinNIMGpM41/ooRZM3PipN?=
 =?us-ascii?Q?IgAF5x39TE+3ipYRSz2YvtxJIiOpwkIvecQ+69t19zN6zNHG7TmqQ2HY02je?=
 =?us-ascii?Q?64mDNxVtt6y8A+FxQC8yuahq0gGcrTLCkyTQGCWnZD0gh3MOQXWyARkVjRU0?=
 =?us-ascii?Q?ErxAj1SKlHyU0hvI+qW1ciPlZAUEC/E13NoVG5kpayCHibSN3ZqDEJI6VwOj?=
 =?us-ascii?Q?7jF4IKqiiTloDIEab/pSWliLzMG9hY0TG5gX1k3MbB7hKPNmUwUsl9gj3avv?=
 =?us-ascii?Q?PppohYcB+lvyQhhgS15rbYAgWVchwgO+Pcaz7PhhUTyzfwLzHo5Isq4mgdcI?=
 =?us-ascii?Q?Y07MlvZTIWd32xdgjwvqXWuaa+mUSecECllLVG9EWlohyS8IhA4bcJkxs4Vo?=
 =?us-ascii?Q?Glo/tYoUqav9d9g1LTEsR1rIgTKQbOdVhdll5XMpGrNmWKvvl6I3CUxlTQ1z?=
 =?us-ascii?Q?K5ZR0zebs4PfYLEsWDY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442714D6C96B5F4487F84BF7292BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c760da-aff8-49dc-aeb0-08dc44360ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 14:50:14.9433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBq73YyyvOSdg3iLu691FKW/ynCm6Xgvlus3aezqXToX93RgHwledJ5OFAQQO/n3GA++vIZ4HImgy2uek70BrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

--_000_BL1PR12MB51442714D6C96B5F4487F84BF7292BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, March 13, 2024 5:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: correct the KGQ fallback message

Fix the KGQ fallback function name, as this will
help differentiate the failure in the KCQ enablement.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 4835d6d899e7..d95555dc5485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -686,7 +686,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)
         r =3D amdgpu_ring_test_helper(kiq_ring);
         spin_unlock(&kiq->ring_lock);
         if (r)
-               DRM_ERROR("KCQ enable failed\n");
+               DRM_ERROR("KGQ enable failed\n");

         return r;
 }
--
2.34.1


--_000_BL1PR12MB51442714D6C96B5F4487F84BF7292BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 13, 2024 5:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liang, Pri=
ke &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: correct the KGQ fallback message</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the KGQ fallback function name, as this will<b=
r>
help differentiate the failure in the KCQ enablement.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 4835d6d899e7..d95555dc5485 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -686,7 +686,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_hel=
per(kiq_ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;kiq-&gt;r=
ing_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;KCQ enable failed\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;KGQ enable failed\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442714D6C96B5F4487F84BF7292BL1PR12MB5144namp_--
