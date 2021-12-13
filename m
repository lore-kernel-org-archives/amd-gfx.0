Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0B8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8B110E79D;
	Mon, 13 Dec 2021 15:32:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B091C10E7AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maUSNjRCU6VOS4FN3QZ1YwSFVyt3NsiFKAa79HLRphLI0DsTRw6ZxNyofyiNY9DzmjN/ZGYfjjDDOJbnfOZH4iBYQe71PS3hD+F5/qKdrPg2sFYn8gdoQBLD9XXgbxt7/le8pEZgMH3FGns3cZQBUHgsAAKpK1v5+cI3jjg4x0Ti0u7dJDq5gsn+7gt2byLpTSrvUgUk8nq5IFitfAp2Qmkj605HWPbgcCKSYThRzuvAn3T2/i9Y5p+aVtL/EUOUrb2UwoDI9P+oH6z5tAYs+VuC/aSvqXZW722rbkviIMy1Ve5dyTTI1F6ymzMYJ3BQ8GSy5fmdlVELpQ8AmOFvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojkyYKTD2luzRSXyMe1ykxYH53K2Ub5XbiiOOk38IA=;
 b=TWowU1rhe6qW2BX5DMSojGJttKtNiqO3Sr5w7rloM4qFhisrobWodEHUL1IU3g+Qpvr1VQs6gHP4aReq28VCfFXz6TPc4NljrN5MWq9m08wxbjvZtCz2kG+LxfNnAlFCWxc8/WH6PE5qb6CaHaI1hZmvZA+dKzoKG8KqlHX1XPtqvSR8EN8/DoodGCJQLPjVA64qAnlo81fslnn/14Adqri0o7qqi+kpX4jPtmtjajo10vpl6lWe5/4NnfFpNEuWAvWBLqnfa/mL5xHJRQOPpuV3aqjoqjnlByWBLRr7aQZX6WJKuHnxJZn8/OJxAxGMBmaB21CA6XY1S9WM3Tw1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojkyYKTD2luzRSXyMe1ykxYH53K2Ub5XbiiOOk38IA=;
 b=wPF1mlpZMPWkS7DJzJIFed0JbCyLvUVa98jkyVcEUjSq+JBWb2FVP4PwamxAYpXds1kod8Dq0WqaB466NuJv8h3OJPcvKHAfBeD4MA/Jh2ZIgoOvNiGWErTDZFLl9c8JevUXCdG6nMMhcSnUQe+4ohZsYzjqjni/3Bd7ywvcp5s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:32:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%6]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 15:32:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Index: AQHX8DNcoGXlJE8HHk+q5f/ZMXhUmKwwjN6d
Date: Mon, 13 Dec 2021 15:32:50 +0000
Message-ID: <BL1PR12MB5144BFEB203C0D57D5C4C623F7749@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211213150842.21141-1-mario.limonciello@amd.com>
In-Reply-To: <20211213150842.21141-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T15:32:50.364Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: c49591fb-e737-148b-33bc-9b5dad548673
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebe7b69b-5af4-4428-beec-08d9be4dd2f7
x-ms-traffictypediagnostic: BL1PR12MB5029:EE_
x-microsoft-antispam-prvs: <BL1PR12MB50297F2917F333F70456DA67F7749@BL1PR12MB5029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ao6vXQEXaL7CfilchwgkhPMrIgvaUrINcof3iCtryOWWap+Z4UxulTEC8qyzu0lM+6gZOwQRgn863bCdNzz6NLq7tIEBp69rqROK/1a32/sDELfGe6ztZyNewJP6rwBc3f4hWQsS61j9A+FerFh18d78dDYoQ4TLdZYXS64yn1248TErRro31tfv8psjGdGu7kJnTV1j4kPQO9HEB5S3JZJ5vGtiUhjfENw1gG7ydB0yVxQ01BOgG0ZNmdoh6ocOJ5iqX0IZ4+M/AmSFcITubg+3FrANlfYW8iOaKwXVoSPpCAneG9Ll7Tp7xyQkchBZEHP8hYrRysMpdEKg2rk4BaGbdOdcJIRhEHXirTflTg+b8qAXVcXyy3meOFT1F0AgZZs7K8gagqb0x2BddwznQL0BLNgkhsi0t/ekf/AX1VFWB0SNtDw29X67WSzSo5D7t71BTOdfCn8g6Phulc3cOEfx1KVTe4vt9pt3s4UK6QoASF07kcFtDkAK0nk/FRaqcup2e/fURfj/Z+cs291a83MKRjD++9gnhXGZD0Kh5/t31xomhcJRa7qu5ZWZ5IJnp7FLs4hHAyVFg7WMr3GJo9R8BDp1cdl1q0sX0FEUyJzV7M7Xuqu1PBBjByvsYLY2p4cvA+UMmIJMv6YW9fMULEiGneolFUJdMdgC7vQpBP7Q06GZwLBtGyf2slV0XyI9PPWw1SKERgXmKiC0MxxV4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(316002)(2906002)(8676002)(52536014)(66446008)(19627405001)(66476007)(71200400001)(76116006)(110136005)(5660300002)(55016003)(9686003)(33656002)(38070700005)(86362001)(66556008)(186003)(38100700002)(122000001)(508600001)(53546011)(7696005)(6506007)(64756008)(26005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rvn2RDjkEtLYfFK6xLa6qN+MV8EtjHls03dc4Psa1/con+3P8kb5gW10Ssba?=
 =?us-ascii?Q?fAQNTiWc7bcV3TnlcoPm/f5jGEcCWrVgy80MlClGqZ30D/oUkTp6JZ8wUrek?=
 =?us-ascii?Q?nYNEb7QNsisMrVEcr/qo/0EpyoUtpj0PM1tsY/kjc4xfbS7Ay6QwM2iKOKad?=
 =?us-ascii?Q?c1jhg5pvHKU+7fPrd5q8TPuFbJulDLozBJV/1r8V7zheVSy2FD5aUEU8iZDX?=
 =?us-ascii?Q?YXEEl8igmUSvTPc7U6bycWOf3X7ZVZCy1zzruIKQyQrIbk7RGsx7v9Ye5Ufd?=
 =?us-ascii?Q?zUGX+dEtKxqjg6PVKj3X2XPqGKN1x/PuEUJUIGZO8wAtTx9AgS7JGSFn8uL0?=
 =?us-ascii?Q?DTqCTlbI8494Z8zpuH6K5MEzSGpwkdbKd2nvXYpAShDpKU7FrfftiGZEeaHj?=
 =?us-ascii?Q?HbkBa/IqI6x8sTa/09SM7B1y3UE5j1erZV6cdBlKzKgJPScY1KPvY/pIhFAd?=
 =?us-ascii?Q?k+J7GMmO+4q3mYLal/6KAORWN7DKQayrGsoxMAnFmXDQXpRF9JZF4PuqsqTR?=
 =?us-ascii?Q?affJdulyAZFdnTk11I/XNtMb4KruFRDHhJqB2BXZKGrbTkFzqxcVStBzEKWK?=
 =?us-ascii?Q?mchfyDIt/dHw8M2/jPEVdbEpINKjmI4OOiYtUnup2E3J+ZEvKBFAmpNVs3RE?=
 =?us-ascii?Q?dKQJ1dFeOPjEoWghZO6QrjeZfDLS9W9waaskB5CT+rJf6iQ2kuPqg+UGmFG/?=
 =?us-ascii?Q?tBJKL8QquewkOCNjmYbHYzWC2O4fTK2bjOa/GdWcxyqFJ4LqghEaXAr8niNI?=
 =?us-ascii?Q?IGVTln2KJe2vojqglUgA7Kl9bV18xFlwfIv1xODfOInI/ZAlI/BrrjAp28PK?=
 =?us-ascii?Q?KxTXIZiT3tPnFSkyXNA38Otw1EumwX/yvM6/ZIh2tYnLs/a7yNDka/E+aDQ3?=
 =?us-ascii?Q?Ydf9DGWZwEHduOdaLacwi5O9Pzpjr8tS0rA0nBfcoMTzNiu7cagtG5KMLxNK?=
 =?us-ascii?Q?mCUwd6DOlB1aH6+XWkW3iwCtWiPsKvuVYLnyOSegD4XsI7TTr5WsPFckno6q?=
 =?us-ascii?Q?Nxtyf/T6Cy+KYBM7+HfT5pXwrSkdznDHEy3R6l3eU1+l25PsHkmceACwSjZ8?=
 =?us-ascii?Q?MTybEC0FDvXzhVqUNGLZP3PBqH34gEj711diN21OQXa4HwEVOISdJLCwUq14?=
 =?us-ascii?Q?MkdRIjllE39BXLUK+1+VTIrEEkqQUP3tWzct76Lm1QvVVvvwjDfp44Sx6mJ6?=
 =?us-ascii?Q?qEiTPiRfDNxvW+3hr0HRrEYO8BB/BLdxvueLzdwual675WknWB9t+mI5cXJB?=
 =?us-ascii?Q?5rJbL/rpvCPFhmQrc8hAvBqN6/pvZTphczc5vvw0K4MqYuCV3D65w1nTVFSM?=
 =?us-ascii?Q?nHhGzfUGdoYfYcvfLkjZiFQrmDfnrUSmY4Se/oSj6fWflwtIbLAcOPg6jwoM?=
 =?us-ascii?Q?3CcUG0iee049oIREr74jHGaDIVDgwOQ8BN4ZyECI9WxDmcGp/4e/r9+YgiZx?=
 =?us-ascii?Q?SqsBzEryN8YYM+ld7lsdT34XuFqCjgwxzjHA8v9133h6VbdNZWEmkG8iDyFL?=
 =?us-ascii?Q?sfUWUUQicpFean200w4tZYTXx3sSsLu0+8Vc1KkvKy5vRatt3BEn5IB2GKME?=
 =?us-ascii?Q?E68kJcu4QGHTpqlhcOpVJeZjrW5M7uz4dFfo9aiZJijzIkUaHw5HvvhdlwAN?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144BFEB203C0D57D5C4C623F7749BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe7b69b-5af4-4428-beec-08d9be4dd2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 15:32:50.8815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eshM6XfLSsOJgEeiViIwbpoNJl/8PHnXGFnfeeGlGmK4QdoJl/P4eAtY3Z1StbA/sllQWj5WnXPQ4of1FYjtGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
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

--_000_BL1PR12MB5144BFEB203C0D57D5C4C623F7749BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Monday, December 13, 2021 10:08 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from amdgpu_=
firmware_info on YC

This value does not get cached into adev->pm.fw_version during
startup for smu13 like it does for other SMU like smu12.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
* Run on all v13 APU to match v12 behavior
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..7fdb63da1316 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)

 int smu_v13_0_check_fw_version(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
         uint32_t if_version =3D 0xff, smu_version =3D 0xff;
         uint16_t smu_major;
         uint8_t smu_minor, smu_debug;
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         smu_major =3D (smu_version >> 16) & 0xffff;
         smu_minor =3D (smu_version >> 8) & 0xff;
         smu_debug =3D (smu_version >> 0) & 0xff;
+       if (smu->is_apu)
+               adev->pm.fw_version =3D smu_version;

         switch (smu->adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 2):
--
2.25.1


--_000_BL1PR12MB5144BFEB203C0D57D5C4C623F7749BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, December 13, 2021 10:08 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from =
amdgpu_firmware_info on YC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This value does not get cached into adev-&gt;pm.fw=
_version during<br>
startup for smu13 like it does for other SMU like smu12.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
v1-&gt;v2:<br>
* Run on all v13 APU to match v12 behavior<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 55421ea622fb..7fdb63da1316 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)<=
br>
&nbsp;<br>
&nbsp;int smu_v13_0_check_fw_version(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t if_version =3D 0x=
ff, smu_version =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t smu_major;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t smu_minor, smu_deb=
ug;<br>
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_major =3D (smu_version=
 &gt;&gt; 16) &amp; 0xffff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_minor =3D (smu_version=
 &gt;&gt; 8) &amp; 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_debug =3D (smu_version=
 &gt;&gt; 0) &amp; 0xff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.fw_version =3D smu_version;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;i=
p_versions[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144BFEB203C0D57D5C4C623F7749BL1PR12MB5144namp_--
