Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B300C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 16:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7590611AD28;
	Fri,  7 Jan 2022 16:25:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C2911AD28
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 16:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOqgU3cmstM0zAHpfKKFdQVEJj5y2ay8WQT+ICb6lkoWV3VkFpQltlHjLIcCcZXK9FUMEYaJqov3PL1Zs4JZie8fAwry8nRYjpNe7hCftX/bxwHExSzvDJIvJHT9QmmdQHC97C/71weoFhLPsKz/CvudHl1UQbLTc/+t2xpbeSIWIm2KTBqfO+NgFsBJvjDom8UJ192hC/hEKB6Rnp2t49d3h6oZqmux45mc1jE6xJWS+0B6xqnG1FjWkNZJEupp0CKX+pOLedJLk2dOUnMFAK594ul1Ruvl+Zz5QXoRnknbaui+KKnv6+PnbW6okbr2lThte1XwZqEEqUrq9xkGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unHm+Fpfis7sjh8+RnpJTIbBXVs7TaSQOc0HkdCdlfk=;
 b=LaAgCxP52wzOJXIC2TPVJ7+iA9N6YYImtakm6v8MLKWB0au4FXAeHDJteE9Na+swakr2gT8QB9Thp3JLv032HtSai5XEUWrLkKQZ/zGujklglvQSdDtS+3MzdQxl1hzs2YPdgtPaxUEmKdur5gIjnoy0Jdtl3Q2SBy1BepzCbPcVx1t0v1Uo/qlvpisPEfaDKrWSBgG1IWGp3QY0JP0nNkkGN6kpI4WzLBMKo4ZCKSKMhQRtrGybnV1Sg4q+tmZpOtqRqcmDYlU8C+Wko/hHrH3XZBy3ot5Pt2JOpamQW9ePpzJPpuKvbiI56G1aKNxe1Xus5/1vmuVLp07dcAisFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unHm+Fpfis7sjh8+RnpJTIbBXVs7TaSQOc0HkdCdlfk=;
 b=gg9nAVaq2YXT5Wln6mR9Q18SJtmtKwdXZ8hN2HdYe2dco8tO+4xfnLBBEFYI+IponQHyw9gK+021wuETyADAKw9LeuNhtNUELe6HM1waIYHqOF7SKWwno4RJUEPEDhy2dFAPE+ALJ3vXz5CwBT9Qbtmdp6sMsIagOJSMZ6hdLv4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 16:25:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 16:25:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Topic: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Index: AQHYA7815QWvLB3JAkeEsRpFsDigDaxXvsnt
Date: Fri, 7 Jan 2022 16:25:43 +0000
Message-ID: <BL1PR12MB5144EC3B65AC6F8D056A9873F74D9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220107120740.1041489-1-tom.stdenis@amd.com>
In-Reply-To: <20220107120740.1041489-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-07T16:25:43.429Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: abbe208e-06d4-7ed5-9b37-b673cce42220
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c1edcf-88d3-408c-4aea-08d9d1fa5a84
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5158DAD3F7E54FBE2A0F1A81F74D9@BL1PR12MB5158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7TQp21cS4lqmomrYb1tW7OgChQUSX5x2PNH0bzydWIY/VSMisefsUgajqZCWGI06OR3RBGzRi0IV92uJN3nhH9PM32nn1K9CqL/agmdnhquTyN3FGku9HDMuWU6nAlUhxCZ/GUj3GOuzyxNh87bdvS5Antz4UvHECAvZHXyqx5khR7RFk3NHxqil+wjUsBhl2eYmWO92+zPxBktLhPNaus2zN5+qwukq4BrUNxy726x1AwgCCi8PLn+psJZ+wpOpAhn+lhQYTQrmLUlTK6XKMO3dcG7TIqja/pU07eJ/kAF2QMGsOV5DEBsJjtcW+sr4qhyNYzQ33aN3Djlk1UensWNVG+zFtYCh/VX3fMcuABTLt7fVjXMg4aWVu9Ohk/lcgbWmOPDbkC3suNq9jtwOqoV83c2F4aKbAuZz6N5PUmZeNUCvYRkbnJ1QKLrp/84wC4CKyIf5Zw17ykSLCdUVTDe/95C+ESy1rn5KwvO1vJxmTg2bW/oSQoks+SU9njsdaNsBJoJOCgBF86/sMTKsNkK6TJx4pX606u4moG4nBwztCAEdWznHgohyAfBg+JcPwKUT08DXnRPAlsVbmsjPP1fJ57/BRqhw9Z+pVIMT3JBy6oBAgPDLrDCihWIUExg9XYbCO8dCBtse/k6CPk2/upy5O1E/3MOqGI5wFupUW37szs8EFTn9D29EZZel63pujOwi6OXIz70VGDkzcKyouw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(38100700002)(7696005)(5660300002)(33656002)(64756008)(52536014)(53546011)(122000001)(83380400001)(316002)(186003)(508600001)(19627405001)(6506007)(26005)(86362001)(2906002)(76116006)(55016003)(38070700005)(9686003)(8676002)(71200400001)(8936002)(66476007)(66446008)(66946007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dd5qf5QVAVT9ooWVJrdiWfhN33p1Tws0Lh1eDco+R6WUvPVN7S91JMiLCvGq?=
 =?us-ascii?Q?t0KaYKFlRNTSiQEhnEsl/DRDvjlh20ltnY5BvCIQdG/mR9NZO/shd2K/AO5P?=
 =?us-ascii?Q?l2rkq8wWw/hSrJjWABc+PKt5B93jvh2VmB3lBom/mzb81oLU36oc4TmPKdnq?=
 =?us-ascii?Q?7oL2u13JOCkgaKyMRltVSiPjgKByuFVXsCbyeYHuSOOjL/RTPg1sGIC8+Od6?=
 =?us-ascii?Q?jYkTPmsvLGatV1hXOcVEuZL3toKYi5IPFIagcodF3JBNafTb2PGeExUbBd0/?=
 =?us-ascii?Q?P6SP7v+PzA6XmabMTKsL9tvZPqsprgP1y5Btra96mrRjAHmkqNxG31x1TnWd?=
 =?us-ascii?Q?8TbVdSUwHAteN2Q+Fth0Quf4MonGTlLeMtHLJNtCt6uiu6nhsGyutWu44KFh?=
 =?us-ascii?Q?t/dxjoAnH0pz0HymLXoyod8pYCE8RQJUDyv9QULImZ+/9DAlGb7R0zwEvpMH?=
 =?us-ascii?Q?vOcNnrn/KkveCqSRrw7J/1j30WnyHFQtJt7JqLQL3wc1AowoO7bdi8+A/MSL?=
 =?us-ascii?Q?tFLD6XZZmCkjh4V5bGtYlUteFKhSeu5zxzS4sAlfe91cK499/ehaWom1WIt3?=
 =?us-ascii?Q?7Q17Me+QrAqIoW6vatoHEVqisFBs6FHg0cqaAztLIbN8naMHagG9bawIDWL+?=
 =?us-ascii?Q?UQSyXF/yaF7SsTfGUdl9PrppHD7kpjho8i1ob4aDpHVx3PrlnKSrEMZCVmSY?=
 =?us-ascii?Q?6usnUYDHe2zS6abpBc2p+wFi/vtIngZyMxPdECNApUuvJiBBYEGOZQALKMRE?=
 =?us-ascii?Q?iO0iRVKMVbiZXxiw8L5HL3ddiKUxzF0Gjx5k5GF4fhVzHZdHFjI7EXjo7c9I?=
 =?us-ascii?Q?4VoWx4xkyCTFV9UKm5SdEKhtorpLGXsePDjjBIVsyiGx0s0klCrJL9KYUZCX?=
 =?us-ascii?Q?KMSbeGOWrBMhOfoxsUyXpZXr8qrED7QDRicmTDdJpPkYvBqHMSjfQavqQ7OP?=
 =?us-ascii?Q?8JU7CdZ/Y7llnhCX9WMYs8xrTIX1DcqtXre3DpTKGp2UOxHkcgev95niTKg4?=
 =?us-ascii?Q?zOqQq6wsxXF+aqZGOHsruGqcf5aI2O27s0NZR/rREDRQZW36tedYBaTaZ8RT?=
 =?us-ascii?Q?cjFN52hp5ost9MAMJqEnjqJTXqbi+MeWGNmc2mEJ8+Geo5a/x1wVux/g25Sq?=
 =?us-ascii?Q?3KVg+Uqv0Jl9Cw9dL9BNFS3u1X6MD6B1VspEqmus4X0v6h8dEC5kwvX1PUYM?=
 =?us-ascii?Q?+kVbc1ImG1zsG4U/aIsBvu2Q8qrg8k0hUU9j0Yw2oB7+7YjIylUcA0WIYxMA?=
 =?us-ascii?Q?IvQtoezDDjsT97+cPDpOpReXKNN/5St+OsyPkHBiky6rvnLLTuI5S7I+Iy+T?=
 =?us-ascii?Q?NwetsaNyzvCcKG5JMx/EfdOxPZdC1eApX9MT4r5LfEKcfO0GGk4MsD5wj4ZS?=
 =?us-ascii?Q?HK0bSxbcexmqDd5SlFNHfkzCSIUSKz5WMj4ov713zsMaN8cynIhyK9w3vdUa?=
 =?us-ascii?Q?Pea9s3uDYgXbmxx4/NY05dlT2i/2lQ7MgTE7RAj5W4+mBiFG7RzA+nn9FgGz?=
 =?us-ascii?Q?BAxTs93B+se0tXhtfMNeQy78X42RQHUAVeVTm5kuq2FhK2CxKqN3Qz+LL0jY?=
 =?us-ascii?Q?8h/FCAneTWx54Aqte0RYC9tKE1vKIox+d5AkH/qfiUM/UoysokVtDLD0DBIF?=
 =?us-ascii?Q?dHAzIOv/8WWiV03zKuALeU4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EC3B65AC6F8D056A9873F74D9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c1edcf-88d3-408c-4aea-08d9d1fa5a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 16:25:43.9502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnivKBJtHQHNI3bEOE2yZNx3WuLn/Ctv8rKdbERFsHeMZRZBuuRguDzx01b1Xx0Kd0iLzhOlDTY54jTGMlkpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
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

--_000_BL1PR12MB5144EC3B65AC6F8D056A9873F74D9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Friday, January 7, 2022 7:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add pcie indirect support to amdgpu_mm_wre=
g_mmio_rlc()

The function amdgpu_mm_wreg_mmio_rlc() is used by debugfs to write to
MMIO registers.  It didn't support registers beyond the BAR mapped MMIO
space.  This adds pcie indirect write support.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c38e0e87090b..53a04095a6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 }

 /**
- * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC =
path if in range
+ * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect m=
mio or with RLC path if in range
  *
  * this function is invoked only the debugfs register access
  */
@@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev=
,
             adev->gfx.rlc.funcs->is_rlcg_access_range) {
                 if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
                         return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, =
v, 0, 0);
+       } else if ((reg * 4) >=3D adev->rmmio_size) {
+               adev->pcie_wreg(adev, reg * 4, v);
         } else {
                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
         }
--
2.32.0


--_000_BL1PR12MB5144EC3B65AC6F8D056A9873F74D9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Friday, January 7, 2022 7:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Add pcie indirect support to amdgpu=
_mm_wreg_mmio_rlc()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The function amdgpu_mm_wreg_mmio_rlc() is used by =
debugfs to write to<br>
MMIO registers.&nbsp; It didn't support registers beyond the BAR mapped MMI=
O<br>
space.&nbsp; This adds pcie indirect write support.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c38e0e87090b..53a04095a6db 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_mm_wreg_mmio_rlc -&nbsp; write register either with mmio or with=
 RLC path if in range<br>
+ * amdgpu_mm_wreg_mmio_rlc -&nbsp; write register either with direct/indir=
ect mmio or with RLC path if in range<br>
&nbsp; *<br>
&nbsp; * this function is invoked only the debugfs register access<br>
&nbsp; */<br>
@@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.rlc.funcs-&gt;is_rlcg_access_range) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;is_rlcg_access_range(a=
dev, reg))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n adev-&gt;gfx.rlc.funcs-&gt;sriov_wreg(adev, reg, v, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((reg * 4) &gt;=3D adev-&gt=
;rmmio_size) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pcie_wreg(adev, reg * 4, v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) + (reg * 4=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144EC3B65AC6F8D056A9873F74D9BL1PR12MB5144namp_--
