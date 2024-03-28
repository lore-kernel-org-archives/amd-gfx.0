Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC34AC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 15:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1BF1124A2;
	Thu, 28 Mar 2024 15:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YtBnK/Ln";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359921124A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 15:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPeqeBiQwo037CW0XndtoHBqS5TRM3oABZcVTfyl3/8rFUQMji7YQvKzdKYMHiFYb42rhZHSluu8gI2slANi9hB4LDpeDpQC4BYcndDNxX8P2tmBHZyCsiwRQ8NtkE6koxeIp2MBdsBK3E8CKEf4JsHxJqtSziSXtUs6lveX0bAL5lA7/tSmhzDhi/3vjxGu1QtEw+mgZyzOfBFotJxcb8skNMDolT+mYnuaI6L3zoJJH+/ZwxeonHa8d2sD7BcY0qKHOUtxYVINxbS5vZEE7XLlcPT7isL24CahtnpRNTMxhFnLmTelqOrZ13zc+aNdVtf3CgxeXAtwhoAKahWICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llo42U3ApMu8LqdPLXKl4dvMdVC+AQm32GdNZDcbQ6I=;
 b=MprEzw7KV77tJwCghp37ihASSbE3Vwr12dQhaYZLE/NVPe3Y6tOPn+felqLxn9aMAmIVD3jRtGWjzDsnyPisXIPzsAW1Skl8LuxSNvwJ6txxFJ6PPvf1GlNss+00l+X7LVvNaXL9Wxho14qKWU6ikgFyr4ym3FA5EQEuT8IoB0jaOu+sKGRtqr3hrVH47vM9qQ1xYUpZp3Y1LJqU4HwTrPEyxOtZuzHukxcgboOnjaGQ9E21VD0wkUi9nywrsHmw6ROg4Ixm8ZCJJfw9jmMZkh4QLsRdeRX55BmVUQ1dplO+a9XQGJn576SJqS6etkpQ6oYALx7kHkKpgyM9XL2+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llo42U3ApMu8LqdPLXKl4dvMdVC+AQm32GdNZDcbQ6I=;
 b=YtBnK/LnH2Hri2LC0ZLdum9v992JVIXvksptffN4acXe9sooGg7LHlbR6hXOWflI9ozAMkBhfl7ONG5Gb5TX2UlALiGF+VW4RvvtGFLo2f87/xcLq/QyI1bmJugYCDFojHtF74jcMYrYZMu+IBGruNfPLvGjM/+8EwrX1cZ/Lfg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 15:41:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:41:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix VCN allocation in CPX partition
Thread-Topic: [PATCH] drm/amdgpu: Fix VCN allocation in CPX partition
Thread-Index: AQHagLSHAAfmOmzSeEqCG0L5qOAyUbFNS2PO
Date: Thu, 28 Mar 2024 15:41:46 +0000
Message-ID: <BL1PR12MB5144BB982A3A1DA60236C289F73B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240328020559.812603-1-lijo.lazar@amd.com>
In-Reply-To: <20240328020559.812603-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T15:41:46.217Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB8014:EE_
x-ms-office365-filtering-correlation-id: d97f499b-acbd-4a6d-8bfa-08dc4f3d9396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65Nepg8xHdOybGWgp/YW54924eM88/C93aHOOJjpDQoYI+ZWc5KzfUzD4Ivggf+VPWRZrY17uwR2DDmNVC52emJGkztVLvX+3/5Jaabqi2gB9j+mR/NA68Vp+e/2X9l7E1zthihjUVMlRFdOSYd87AfoOqho2QAJTHKgpYM5vkz8Fln1GociO8Mh7YozqiplmGXIHAbKGk2CH1zLgt0ucogapxoRhLzSQKA03xXHAO8Hr5ztH7w0HluWZ0w3WD71TMh+FlMj+WgvI/+iW2pNW3/VxLNQiSx23GtzoVZgG3YkkqNYTl6t5iJJFaJqeZSbzhNEcl35gz7T07KDnE6hPKnFblsGWqPzlqDJ66rqtvTQYy71c8YPCaD2B96VN9uYRHAnp4nXaHsD+64fVsBWuaKxs+N7JYmua1XGVe5tVILxX8BdY2km7e3yIHC5e2vxUmUjs48EelIA+fsTVAPJqJRJ0PXkMC1N+m89l9ZWv9UQ/whFBLSt4lDlqf8iDEG72+9nXdy10pI0ZE9rQiRvNZ9ps++mN6SoiJlK19MDM1HUtXV4FvrYIY+p9rsCXbBqYvXqS3XQ5WRBDuXg+e+LtO6mENPacpq5Fq5vv0N1GzoJy5uVv0iYZOMaM9REHVTH2C7qCHubH7LJA1448gl8wEp+4JnQONVl8ocXKKfABmoxu5ujoAD1KBdOyph14uKJjWLdD8UxC10ij9EBFfoLwHb8KGdprP27N+6V5i5npHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7w0RBS38+8IYzWgx8rQMZIvoMROu6sNMFtUaVYQHI6aJf6hy4GViOSIt/I+6?=
 =?us-ascii?Q?k3G20vJgYR6pc/wIoBp0KwsAvNX7xWXCcRYRH6DQfdR//wKVEzrECqFV59TE?=
 =?us-ascii?Q?nSJ0ECHC1Y2BMBBRS8PnR7xsE+SIFi8rt7rSTW35tT+6v9j6EPb/z3q9rmNi?=
 =?us-ascii?Q?dQI9+El5EiNQKfByGu4zVFzlhpaq4kOUeniGgPo93ZNo5hivuzaDeqZbtqnJ?=
 =?us-ascii?Q?Gwo49VZo56/z7UBbNPc4opb3paOEt45SegOSh1t5gV6CjJQvoQ3S46nOo8+a?=
 =?us-ascii?Q?wKTRCYDBgfC03T3bkB5rFAYGTnkIuUsz1MgwMoNbuRD10S15+SZRu0/WILZU?=
 =?us-ascii?Q?nlQbflX6uLFrxjxxcezWXOspO29nWZxNskZuoaatOB53bkSWt9R98jD/Z8mk?=
 =?us-ascii?Q?KjkylrijVHN2apQM7OA3XP8sPFKyUZRJd8lujxKFB7MtGbn+c2i2tZWQcTE2?=
 =?us-ascii?Q?4bB0WRez4E9ryj+Mo4I0NTKBbMQa0q+PwlmKxohDgIuzjZ5123ywQwmkn1jt?=
 =?us-ascii?Q?EHxNE/6IRXPAeS9TnBI0+Q9+GMygGT0LONgZziCX3USo9tl2hJPksKXrf2B3?=
 =?us-ascii?Q?jYVI2vzu6Vm1bBMhp8dJsRYHjpuCrKMlCxOFXGfL7dqVGdMjwnQ1+zjK6V4U?=
 =?us-ascii?Q?Wbp0VH4q8dkGSDMfPiKEd4N6Mye8AgdYvBUNFuGjrRFxjBqEnSlH/BdnconA?=
 =?us-ascii?Q?Pqx1djb69fp9ygcVidn4biHL7mTAogHTB2A0gs4BLc3cNmpfOSqMTIvxdAu1?=
 =?us-ascii?Q?86aOk3XYSelUydVyfpKJLuHBUK2R0LG8ch5rZH7d15+F6YQ50AX9adyUzETj?=
 =?us-ascii?Q?pZWsw1De2Y3SrlIhmp1fVOt1ZMdLRyELHPz3ezcmC/UHDe6QthQ8FxPntq4R?=
 =?us-ascii?Q?xXZF6yvn87XbERI4k7wh5sH5G6hN3z60KGqXbz2hKCeaUt2J2b0V9It7uhuK?=
 =?us-ascii?Q?GSOexLsGAmAbNpCxuxEcqMKbwL3nlUMErmfAW1H3yfvVYlRhjZIx8tbTHlIx?=
 =?us-ascii?Q?ZBM/MKqe12I3a2IKhW7tCaYzUwAdwFvBGXJnHnbNI7yGQIAawfY/8Fm4itMA?=
 =?us-ascii?Q?/5GRHIIcj0CHLhjlwPfo79YruidqH+Kx37H3l3sy4dvD0J4BXSWyxoj1LTck?=
 =?us-ascii?Q?eJwUNKmQ0ngJIO4lWY3Bj4bz24QSmxQeqYzMLhDOOFbruZB2Ex5aoog9/04y?=
 =?us-ascii?Q?AF5dX0HZDTobd8McRZQfSeHfoYK3oRPqk1+Le3agz4J6KiZIo1hJK7JGgyKk?=
 =?us-ascii?Q?Nil1OwoibfkwWNJ0B7AM0PZyYRS02JPtvzBQOjpgWIvsfU79SxvRAv+dRIP7?=
 =?us-ascii?Q?vX9lt00rKAp13BZF9zMHnsJtcggEYtUD5Ey7HVNtd/DoyvAQiMri07w0iFtu?=
 =?us-ascii?Q?5EAO9COFHhnMNI5gL1cbnRrJZLA4kuFP74gpU6cMCxdF4ijj2JAGSF9kYZ3g?=
 =?us-ascii?Q?5GejVdIG2zJvcgccyd1m1LqBDaofFm567BYfOBlWILFT+KYIij/eqlflRCWn?=
 =?us-ascii?Q?nPOGf+t+5hXUhVc87myzq/5IKdR3B2Qt78o0A0InbdLQvbmM6BOabR0O+ymU?=
 =?us-ascii?Q?xELAfKkZ+lchVA9H+2o=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144BB982A3A1DA60236C289F73B2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97f499b-acbd-4a6d-8bfa-08dc4f3d9396
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 15:41:46.6863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyV37H3WXg0qqIx1X9d2aDRST/HnAT6LCHFt+sOZOsgjiP9uCwatd12qqqPm2WIVbSVk+FQfBqYcV7oVxBA6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

--_000_BL1PR12MB5144BB982A3A1DA60236C289F73B2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, March 27, 2024 10:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhu, James <James.Zhu@amd.com>; Kamal, Asad <Asad.Kamal@am=
d.com>
Subject: [PATCH] drm/amdgpu: Fix VCN allocation in CPX partition

VCN need not be shared in CPX mode always for all GFX 9.4.3 SOC SKUs. In
certain configs, VCN instance can be exclusively allocated to a
partition even under CPX mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index d6f808acfb17..fbb43ae7624f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -62,6 +62,11 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_dev=
ice *adev)
         adev->doorbell_index.max_assignment =3D AMDGPU_DOORBELL_LAYOUT1_MA=
X_ASSIGNMENT << 1;
 }

+static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)
+{
+       return (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst);
+}
+
 static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
                              uint32_t inst_idx, struct amdgpu_ring *ring)
 {
@@ -87,7 +92,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device=
 *adev,
         case AMDGPU_RING_TYPE_VCN_ENC:
         case AMDGPU_RING_TYPE_VCN_JPEG:
                 ip_blk =3D AMDGPU_XCP_VCN;
-               if (adev->xcp_mgr->mode =3D=3D AMDGPU_CPX_PARTITION_MODE)
+               if (aqua_vanjaram_xcp_vcn_shared(adev))
                         inst_mask =3D 1 << (inst_idx * 2);
                 break;
         default:
@@ -140,10 +145,12 @@ static int aqua_vanjaram_xcp_sched_list_update(

                 aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_i=
d);

-               /* VCN is shared by two partitions under CPX MODE */
+               /* VCN may be shared by two partitions under CPX MODE in ce=
rtain
+                * configs.
+                */
                 if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC ||
-                       ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_JPEG)=
 &&
-                       adev->xcp_mgr->mode =3D=3D AMDGPU_CPX_PARTITION_MOD=
E)
+                    ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_JPEG) &&
+                   aqua_vanjaram_xcp_vcn_shared(adev))
                         aqua_vanjaram_xcp_gpu_sched_update(adev, ring, rin=
g->xcp_id + 1);
         }

--
2.25.1


--_000_BL1PR12MB5144BB982A3A1DA60236C289F73B2BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 27, 2024 10:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Zhu, James &lt;James.Zhu@amd.com&gt;; K=
amal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix VCN allocation in CPX partition</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">VCN need not be shared in CPX mode always for all =
GFX 9.4.3 SOC SKUs. In<br>
certain configs, VCN instance can be exclusively allocated to a<br>
partition even under CPX mode.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Reviewed-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
Reviewed-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 15 +++++++++++----<br>
&nbsp;1 file changed, 11 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c<br>
index d6f808acfb17..fbb43ae7624f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c<br>
@@ -62,6 +62,11 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ma=
x_assignment =3D AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&nbsp;}<br>
&nbsp;<br>
+static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (adev-&gt;xcp_mgr-&gt;num_xcps=
 &gt; adev-&gt;vcn.num_vcn_inst);<br>
+}<br>
+<br>
&nbsp;static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst_idx, struct amdgpu_ring *ring)<br>
&nbsp;{<br>
@@ -87,7 +92,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RING_TYPE_VCN_=
ENC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RING_TYPE_VCN_=
JPEG:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ip_blk =3D AMDGPU_XCP_VCN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;xcp_mgr-&gt;mode =3D=3D AMDGPU_CPX_PARTITION_MODE)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (aqua_vanjaram_xcp_vcn_shared(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inst_=
mask =3D 1 &lt;&lt; (inst_idx * 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -140,10 +145,12 @@ static int aqua_vanjaram_xcp_sched_list_update(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring-&=
gt;xcp_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* VCN is shared by two partitions under CPX MODE */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* VCN may be shared by two partitions under CPX MODE in certain=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * configs.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_=
VCN_ENC ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;funcs-&=
gt;type =3D=3D AMDGPU_RING_TYPE_VCN_JPEG) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;xcp_mgr=
-&gt;mode =3D=3D AMDGPU_CPX_PARTITION_MODE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;funcs-&gt;type =3D=3D AMD=
GPU_RING_TYPE_VCN_JPEG) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aqua_vanjaram_xcp_vcn_shared(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aqua_=
vanjaram_xcp_gpu_sched_update(adev, ring, ring-&gt;xcp_id + 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144BB982A3A1DA60236C289F73B2BL1PR12MB5144namp_--
