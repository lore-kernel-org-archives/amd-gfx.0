Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A60EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE62F10E33F;
	Thu, 17 Feb 2022 14:42:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D8810E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z42+3UceLDMCdUYzEYSKsWQuKc3nJfBS4AbUrNcsuEQGkK5vaDSookU+r6RmuZtNeVde1CaLWBmixqnIhv1aOHezw6i++SxOgE8wIZAwM9X1aWg2I/uWjvdDVG+g8ocDOJQTsAtj7gpgMP2dWogZQBOkWuq9WPFOCXrkelYzXA0A6dcdQVMK52zJEPn/n2LZ95nYEvaRvcj/uqmu1qv9lzXAUcfVONN0qW83GouI/ymy5XBT5LbTSXT4d/zgTwu+Gzd41MO2EjkbdNEN519BVDjK9OvVkXVkEXhgcLjpmPq48/AS8PpBcoVe0K8mt0Lk5uij2DZxXF+jRFB6lhG8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qblylL6NNjs8cH6fTwZeJxvtCwZuGQQeCrqVn6FN/Ag=;
 b=IK3Ds8hFREV7XC/O9+RVXvYQopEbjXDoHx6dwRTw+Hg47o1QvMnj79IBXR2Tuxt2D7WxcSIxG0iDxHlg2FWiYGeQVnJoWpOMEJcf9TVAgKdJk2QMloe0Jkft+4jpVifaBpImcqarFlc9yL/WoqX8VRKD6miOrCJdbKk/iEj0JB2R6eZTAl6sOzJV8uklpGMVewhY1yi0esuVXrFUzwcxaWliOVtl7exYN/SjhSRfKXjs+/oWko+CYI4o34scbLGmn+AzBe7IfERZXnydloawn+ILYUw++vo3U3UGSo2NkU1nOpFDjgS6h2sW8V4mAliWWlX4EMfKl580ncfx3E2oJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qblylL6NNjs8cH6fTwZeJxvtCwZuGQQeCrqVn6FN/Ag=;
 b=0nA14nE/WOL1/C9DErqB47ujjt+GqVKYJ16PgfV3If5o+Yc6iRPtx+VlA5DolMtnWfL5gZaA9Xv05LANDMxcHGPIAmrYZ8EaOzlU7BYtb9/AfXNFxD9Yj165v5/uCNKORg3/w1kgkd4LwiU5EdBy34gu/1vYDTUMW8/huxA02vE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 14:42:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%5]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 14:42:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data
 (v3)
Thread-Topic: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data
 (v3)
Thread-Index: AQHYJAyL6D9pvrN17UqoAGzIB0jXnKyX0Rah
Date: Thu, 17 Feb 2022 14:42:55 +0000
Message-ID: <BL1PR12MB51449CCC3A0E996CAF2724B3F7369@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220217144148.1735978-1-tom.stdenis@amd.com>
In-Reply-To: <20220217144148.1735978-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-17T14:42:55.030Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 31bdd54d-a6b5-db21-e100-12afee95258e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 271f2ec4-5250-4153-7071-08d9f223c8ee
x-ms-traffictypediagnostic: CO6PR12MB5443:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5443C65DB46C09CB6A0E88ADF7369@CO6PR12MB5443.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MXbsvs9BhCt5mdlhbuyU9TCT3IQKFIMreJZPbb76wokEyBkEGH1ixcqhVdJk8YwLxvOv6KRwCBixtmGSVpEJIui0tXH7jODrCEZiicAnu3lOCyrR2z7D3vCoEuOCoBCq2AVrkS7LKy2FqgNdWsV4i4DMz8Uh7cC09UPQ3m6gGQrXfi9v/tloS0mUpja3+TQIvsFpOr8t8uZkzNFTAGOwfu9eJk/vRRgtCZtaKTm065A9uUvEvQrlIQWs0efhxdrdVRqyqR2kiBZU0P2TJ/7VSrLcgZljZu/gdRYT0J+dnYAVTETz5c86KIzY67f8LmdeFu0JIvCnIlPy5Y2j5PhLfbJrB4CiA06mV8t1IfHd+8tNyOD0MK2fB3nQ2cSW5xFEsyY1hWITwaYdwxl4W2DhWR/v4Df2XxkrrBxtFe3YBS94nh0fpHJBSucVBmkC7EAcjm/knQKNUMFtObUSSNo5lUkTBq1O/Oj0J3/0ZhjAdte1Arw0OMDcR5+LF4fwcIRIy5thuH42e7p/0y/OoFVvyR2X5+kfXtv0JHmfqGfD01bwNdgSPhDIlAnsYKQqZUcqR4xG2QQwicxzdaydzE2/wbHcJMFCwe43yCVNDdinxSpWTyFTHzCL84zuooVtzHxj3Vz5kvkvzcm1W1akpzy7edsnvtfntypXKqB4H+Vf6a9sQdHSW0AgwK7qTrLLGHVRbbqBhEKhOkEWmyw+SkIxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(8936002)(83380400001)(66446008)(38100700002)(38070700005)(7696005)(33656002)(76116006)(66476007)(86362001)(66556008)(66946007)(110136005)(55016003)(8676002)(316002)(2906002)(64756008)(52536014)(5660300002)(186003)(19627405001)(6506007)(508600001)(26005)(71200400001)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ETOP0sT59VXBkTllRxTE1KvtJytLudVnfOdMgIcgcpl3ZGvOgHjX5jizdw6?=
 =?us-ascii?Q?WYRUVYsPUfPQlgAZY7T9Wy738pJxm4UzfvFEoAoxmvWj6Pom2JcdnRWSkRLF?=
 =?us-ascii?Q?s6iD6kxEC6gRGvx/hGl6b3e2P3TUpSeEM0C7ey+cUjcz14lzAP8wiiTbhCv5?=
 =?us-ascii?Q?1gu1hspqaf6m2oJwurxfyEdp74DA6y/Kb7rCql43xVaen6SKrTRB5fbRKqMh?=
 =?us-ascii?Q?yJ7UeiYH+zQhpNmKukk8Nfl3s5X9mUCkrdmhw9/fIkrRcVp4Gvp8EtxhEIJk?=
 =?us-ascii?Q?PFAzphrEJhjHh2wVQuaJvx8U/75863P0CH7T847KV+mOW5f3joZFxB3fWWWz?=
 =?us-ascii?Q?24VTRci9p6w9lrNEdVYGUo1FflI+O049nFtfzFxWvxy0Y90lXukFcV7+PPcU?=
 =?us-ascii?Q?ePzy4iLn7C+uTru9t0J2vUoiPffDFG2QxKZM/7WAN6S2nAtl5OBSRtXM5EjK?=
 =?us-ascii?Q?Gw2pT2vm97K35gZxumzdaJEgn/hG6aoH/XHMcoL+OrcoFJL5u5AdkimQXpLJ?=
 =?us-ascii?Q?UeAPYu4xHx80XR7jIAkaXQgAlAybCnaFoRHbscTHBvE32nR4uKICjei4IPls?=
 =?us-ascii?Q?5V9XGjAVQzOtP4dktS9DrfXggj+WyGhUo9W+lkiUv3/H87d6wLdp+UFZWC2Y?=
 =?us-ascii?Q?bFO4k1d9XzQwZyr1gaKR2k4MtFaLAQEb5jb3PrJIqy0fs4KyEyFpSac1ZmGw?=
 =?us-ascii?Q?u5Dzl46etYQxIx8FRM5nz7Ea+n6m/a93WnsqjDnFLiXi5Zm/nSGxDLJJ7t8I?=
 =?us-ascii?Q?/PS3oz1ALyweVh5zzkznN3CXKWfNuldJ+1kdPCAS/y4or9GkBYRzcXgTYTss?=
 =?us-ascii?Q?yimgJK5wvzHsQDfNJDryrh3g0pnqBJKtQk2ZC5FebFEpTL1JWwPLWhrf90Lg?=
 =?us-ascii?Q?iHOX7MwfKbWzqKRkrDijFdlUC+5+0aPulBEL+CefxZUIQJPyKXGJzuOgdq5w?=
 =?us-ascii?Q?y4PP6wfmEWXqyHuA7UyyGAJV5lHzydYYmI0q+ftP03qK1aA+kyl6yTP9pcrh?=
 =?us-ascii?Q?KvBPbeuih1x7t1/M7g7YaiduObPNPTz9wT21HCtYyz+OYLUIRizc23Re14Mv?=
 =?us-ascii?Q?nG4uZZst81K2NSW0fg8V/La2ycYxKoIDLH6mGLrtfYHIEv0J16xcmZBhXNag?=
 =?us-ascii?Q?RraYN4aPdv3yCf82xdLrhqKcj2Tb4lMZKEGvzMiki2Yp33Te+6WwGx79pUAd?=
 =?us-ascii?Q?xKXeDrSW+9YiiOYnYRoRXiR5St2gZIhUClg1B/pW7yMwq3uwbgtzDTQJu5ho?=
 =?us-ascii?Q?XSzmd4ls32Meot4m/ZIntV5/1o9es7ZTqbhN3TsFc7aQrduwUao8uwy3heNR?=
 =?us-ascii?Q?qPTE6CyTR/bgIw/E1dbPom1Is3RAhlhzZ50i9Iv5vg9MBKleMZQdyVj1vbww?=
 =?us-ascii?Q?/qOQljVWqnbt/SapoG7vwNSFqdnP/ttAKUZy66q2QchMkoMiHAjX0mmnis6+?=
 =?us-ascii?Q?Ahfr+KP/NKN0lI2tf/cykXBIVK0layn1cbB6sqYMGLA9YD3iexlvY4YAoc/Q?=
 =?us-ascii?Q?ZBWlzx02Ae/I5W7i4Uy1nsHkOL90U0VTXv9a8BZjVFjhTAWjNJ6MXx28y2t4?=
 =?us-ascii?Q?w7Tvt36dnzilBTbEOfw64qZetwFezCqE8vAnCtMVQYs6gTfOF+Nvr0Lyix9f?=
 =?us-ascii?Q?f32zYE4GUx0M880q55+uI3k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449CCC3A0E996CAF2724B3F7369BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271f2ec4-5250-4153-7071-08d9f223c8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:42:55.7232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZIPOcO2Mrhn5WQuUsaccZUlB+WH2G7sOHhZE5Pu8ARXqHlVwoL7yojeiNf4YV9PQO6dKhvJKmdd5v2Zz6jM3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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

--_000_BL1PR12MB51449CCC3A0E996CAF2724B3F7369BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Thursday, February 17, 2022 9:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data (v=
3)

Needed by umr to detect if ip discovered ASIC is an APU or not.

(v2): Remove asic type from packet it's not strictly needed
(v3): Correct comment

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 4b950de9bf66..db8a8710333e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,
                 return -ENOMEM;

         /* version, increment each time something is added */
-       config[no_regs++] =3D 3;
+       config[no_regs++] =3D 4;
         config[no_regs++] =3D adev->gfx.config.max_shader_engines;
         config[no_regs++] =3D adev->gfx.config.max_tile_pipes;
         config[no_regs++] =3D adev->gfx.config.max_cu_per_sh;
@@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,
         config[no_regs++] =3D adev->pdev->subsystem_device;
         config[no_regs++] =3D adev->pdev->subsystem_vendor;

+       /* rev=3D=3D4 APU flag */
+       config[no_regs++] =3D adev->flags & AMD_IS_APU ? 1 : 0;
+
         while (size && (*pos < no_regs * 4)) {
                 uint32_t value;

--
2.32.0


--_000_BL1PR12MB51449CCC3A0E996CAF2724B3F7369BL1PR12MB5144namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, February 17, 2022 9:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs =
data (v3)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Needed by umr to detect if ip discovered ASIC is a=
n APU or not.<br>
<br>
(v2): Remove asic type from packet it's not strictly needed<br>
(v3): Correct comment<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 4b950de9bf66..db8a8710333e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* version, increment each=
 time something is added */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D 3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;gfx.config.max_shader_engines;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;gfx.config.max_tile_pipes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;gfx.config.max_cu_per_sh;<br>
@@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;pdev-&gt;subsystem_device;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;pdev-&gt;subsystem_vendor;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D4 APU flag */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev-&gt;flags =
&amp; AMD_IS_APU ? 1 : 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size &amp;&amp; (*p=
os &lt; no_regs * 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;<br>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449CCC3A0E996CAF2724B3F7369BL1PR12MB5144namp_--
