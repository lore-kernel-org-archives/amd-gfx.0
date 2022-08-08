Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303C3C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 19:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDFB10ECBA;
	Mon,  8 Aug 2022 19:50:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF497112637
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 19:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODLfrBffXWkThCtxTbgmkdqy4UiwAX7J8N59EMUPwKxx/3PNmATTSWX9qICaGATekrM92iSnMWn0pNPb4qERVv8ibkNqoLYpdkcuQtQm75nWRAsFXkTQkQMXpRBvEt7504+Rt4y+PrkkU+4fZ/vZtRkaT92hpySIYm5oLXAjS7Xsq0uTFyZMu9WYFuUU0JZe6yJFse/TUoKxNBw/OQ7BA0G3LcxVU7cfYqrGPfzwj8t3mgRA5ErTui/RwL17nn8eNpJM2T3jB2fNUjPwzeSaQg1mQzBbUxZVExP+Zfuz6KXmbOceLsNheA1444kVdiST/EhE3xe3fU+7Hl8jk2pYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxgsIslDVV5Iq2XBINAh9mth+W7KXdjGnJ61mJCKb08=;
 b=jVmQuWbd+Hnkc5NdHu8I80iOhsjMEOVbrIh5WPuwVYfGGdoQg5Pb0x1TCgGXpC8X/mrcIsUny87P9imZxa6M3qKBkPXC56bvhOeZHkGV+xI+BgVd5oMHEbgzZrkYp9pDlhsXCHmpLgm6h/wUb07xDHGRuZcA+GkL1tDPVcpseNh9c9apUana5ycaMgdJc7jq5SBkNK8k6xxOVd49JdVrrL3guN/IfBXBFZlvhNlK8nvbKKio6oXW468PBHpyVRYkqDOFUTJwL2uNQ1ZFU+q6YosDFRSzcqyVbuaOrGXWPM/MCV0yqgQrj/VRzucm7r5UTfa8zV5hO9OGryzLpD8dxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxgsIslDVV5Iq2XBINAh9mth+W7KXdjGnJ61mJCKb08=;
 b=M9RCn/YlQ5miUUCeZ9crMjlS2tyAkOj6B/o5179TKvt0Lmp9dmBI/1LOhRwsCqitf5mEw2/BLCayavOP6MWEWKF+QNizzfVdc/cSADmjRvr7aMxHz1iseNRCxjotDTFUecO/w83l1Q+HnqB10Pr4ETlAnMpexUdr+6+I+bpXMmk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 19:50:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f832:8c21:41ee:5876]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f832:8c21:41ee:5876%9]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 19:50:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach
Thread-Topic: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2
 reach
Thread-Index: AQHYqBvnZHyrMtiwR0ajBkpUgnEHa62lb8lg
Date: Mon, 8 Aug 2022 19:50:17 +0000
Message-ID: <BL1PR12MB5144281F53477A921C5BCD95F7639@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-08T19:50:17.329Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f6e46f-b620-491c-7a00-08da7977385d
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dziC8mhmTZTv4vWesH52kP4zR1tR3gPPCSZYebOJAc2LlTAGAEV71utMIxkvw2aGZ/Uq9cvtoVnr6hFLW7z/zXUS0TbGBR2We2WEeNIVfBt9JdfpihVD01rP/rMjV8OU/RyXK9IxhM9xp58PRai/Wq345T6jNr259gLEXf2TW/8BgzU2EoVyvcpeT0FQ6P9IiFKhOqLALBSfsbbXOveVY/XfsEEvT7VDH9rXy++N+nIdXEcT6UtsA9jvIt6ryYD4dD8iDMiguF9tS5Xj6ryYC/8H3FACoXcmMPoO/80st+VlgGbA06qSmkHoTVWy//rksYKq79yY2doEvM4MitdZ6sBs2pJ9ddCnU8CsfZWVMRt+CsYysu1tR79Z80q6Mt6A6bsivJqvL56SCnVgr9AyIFM3gfkxpZk+HiYTRHRNBhk93WeOUL3li4kJgpUuy5SOFjZ1RiIGUOXMwZYw+QqCuiK5cbe1diga6U5qpxWd1j6MNz7yAKAqvtnYIreLwgYL0dseMUN8+ZOuwv04X98U0H9sxjuXr1K9L/PSi669Y2kAYxRDXwtKRHZ7ZPZ1zaNXQOuoHKfBssN/mmO+R9Z62867AO6fT7N3CYdu8KOQ7Y1HF1PrsYO+ZeeaiHPvBbu7yEwrFlTHa2qNao4nfu1nZtc0vJlV7zbqdq7AdeRLyGgZuVOTfQuJAxtbwWAWaYP3Z0IVQAHvdc2ipPnMu91nFx8mrWCL7tksOyweEgadDPg5Z3phoVi3vOT8F0TH/hN89g62Tvnf33kqJYxGGpWUB9oTNxpacFMT2vedYS7TmfZPBeUH+IY0NAtchor2w8c8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(33656002)(19627405001)(122000001)(9686003)(26005)(83380400001)(53546011)(38070700005)(186003)(6506007)(86362001)(7696005)(54906003)(110136005)(71200400001)(478600001)(316002)(41300700001)(4326008)(8676002)(76116006)(38100700002)(8936002)(5660300002)(52536014)(66476007)(66946007)(66556008)(66446008)(64756008)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCcE/I9sAx3vAcKsbwfleu51ck6huZfqpBAv22FzyaPL5Qlq4AHI54TrdTby?=
 =?us-ascii?Q?0rkhLdQl1WCRvdPlbV7tb05ggGZ5gMgD8jfyFx29c8QkrRBttZ3TYLEDHR2h?=
 =?us-ascii?Q?S1zxwx4vLgeNwXSZ4kRaYtMT6zVaKoccJ3j/PrzBiEXUJT4nc5iA5NK51Nzb?=
 =?us-ascii?Q?GyY8cWZHCu+BT9ibhQrBSyghA2CkhWOAm7D0A7qxrxJ1GdkCjKgXu+bK860g?=
 =?us-ascii?Q?vZ89S4xy4GxZj9u2xWUlNjLaJoN8tj97j0AabqchcP7KLEQ0DOLzZ8Vuuq2q?=
 =?us-ascii?Q?Cf+YfP1+tzTAHvvwpS1EniA3eV6fegHx7qeBZD7XPawTqcyhXHEkeFEqiCVT?=
 =?us-ascii?Q?6eu7W8t3dFjm9QVEMj7ddedARjDUqWWCJUUOzleePauG9Ad3cd8wktRCJ0pV?=
 =?us-ascii?Q?11Pj0rlPpsq4SwmUv2O68JJOTIjwW4wmquY+Lgh4ti52tpGiZzTVnxKN/ekX?=
 =?us-ascii?Q?4EvlGcSx6TfYHGPTRp2X0kf1oBCIDVzgAA6l/81x3N7kVZPt8nmBXxYOngpg?=
 =?us-ascii?Q?TVdTs/djKll2RAPOUqFV3Vv0F8Ae0aYpKF2JR9CVc1wu3ZJpQAB0uT0gqtdo?=
 =?us-ascii?Q?UE4AObG52V6PkfWVCK0RAQ54625YeaOaQXae0Ifetc2pWqc3fVtto1bzIN54?=
 =?us-ascii?Q?TizHHPszxnoxbQ8sbPpUCjFb8sVZnRIin+/OLq/vEl/6fXRhJ1scFuWNDB6t?=
 =?us-ascii?Q?GK7jHWGb9pALW0eoaZh0x68gOCEFRQbPHuLeLEmfnZ6t72WYtiNy/6SlrM8h?=
 =?us-ascii?Q?XBVl4xkJjLyqMSKUOrBcO159p72vBx1YvDmE+4ax/2UArOfKdOc+uhYPhO9v?=
 =?us-ascii?Q?pWqF2f1W/CgyDhXdXabDXkHQqvM3xcsLIBIESI5bMVVHOXOAXREQDyWJXtGg?=
 =?us-ascii?Q?IrRlkxCtldSJJwUWRSU60Gl43oqrEb0rcii/GvOzuSw8lt3rm1DuVYTT2t98?=
 =?us-ascii?Q?0wD1zAbrSDKkxdUyXPraBI9F5wUOdt+CM0iu+aeucw1eeSnWov5zceBhClUv?=
 =?us-ascii?Q?u8tFjhetywTeDcgcRQwtyWAZazjI0hX+JbO4/HQ2b0WJd6o9MLE7sJp7DC1B?=
 =?us-ascii?Q?3oSs83Wm8pNZD8pPaGjm9/qzQy9sCguHdBR6XKP8/cjw0AGaHtsaSC8nLaTo?=
 =?us-ascii?Q?Mf738r0lsdTHeZV5jxdqtJvvRfrxbnj4/3HrCieaxAyaFiX0cJOu1OmKWuzl?=
 =?us-ascii?Q?vh0BffKundP4l57Rsj/gKWP2t3o971Cdu8Fvpe+PkmPc2VqMn29TY7PCeZ6q?=
 =?us-ascii?Q?UGfWqWVKDTZQjBY+EEoi1Y3oGUMKzyBSzO7IrdooOcxOWnsMGRrGMC8Xxx4I?=
 =?us-ascii?Q?nymrN9rFjtPAIqxARxPGVgFbxUIrumBf+arHKFPs4hfMAhvZ+15eDL7EZn3D?=
 =?us-ascii?Q?SrTmIHOkQwLsoVgUoApWjT5MowWpZUDO4PqRCbK3U0lNidiZrf7L7PFHgJrU?=
 =?us-ascii?Q?IOSKONfkfeyL4R9nORxlsbz7vFN3UbG9fRglrYYzLiNZVkJd2V/NJm20jnfY?=
 =?us-ascii?Q?dQveA0IU39pdVw9x6/NYS+hW8/UUkqcfe8/ENbRsIaiT/Zzcv58OHqH1hn9G?=
 =?us-ascii?Q?lrnQ6Ve0fgNMRt/5db8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144281F53477A921C5BCD95F7639BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f6e46f-b620-491c-7a00-08da7977385d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 19:50:17.9909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MxODH93emJf7FebyeYy7PqeSy+E74T/pf1gvZ5WVMRENJx9QOHLC0CwpU0DW3V16y/PuvKJ2wcLaEmxVDgGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144281F53477A921C5BCD95F7639BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Joseph G=
reathouse <Joseph.Greathouse@amd.com>
Sent: Thursday, August 4, 2022 12:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>; Greathouse, Joseph <Joseph.Greath=
ouse@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach

Enable translate_further on Arcturus and Aldebaran server chips
in order to increase the UTCL2 reach from 8 GiB to 64 GiB,
which is more in line with the amount of framebuffer DRAM in
the devices.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 22761a3bb818..ab89d91975ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1624,12 +1624,15 @@ static int gmc_v9_0_sw_init(void *handle)
                         amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
                 else
                         amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2=
))
+                       adev->gmc.translate_further =3D adev->vm_manager.nu=
m_level > 1;
                 break;
         case IP_VERSION(9, 4, 1):
                 adev->num_vmhubs =3D 3;

                 /* Keep the vm size same with Vega20 */
                 amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+               adev->gmc.translate_further =3D adev->vm_manager.num_level =
> 1;
                 break;
         default:
                 break;
--
2.20.1


--_000_BL1PR12MB5144281F53477A921C5BCD95F7639BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Joseph Greathouse &lt;Joseph.=
Greathouse@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 4, 2022 12:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; Greathouse, Joseph &=
lt;Joseph.Greathouse@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@am=
d.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable translate_further to extend UTCL=
2 reach</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable translate_further on Arcturus and Aldebaran=
 server chips<br>
in order to increase the UTCL2 reach from 8 GiB to 64 GiB,<br>
which is more in line with the amount of framebuffer DRAM in<br>
the devices.<br>
<br>
Signed-off-by: Joseph Greathouse &lt;Joseph.Greathouse@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 22761a3bb818..ab89d91975ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1624,12 +1624,15 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.tra=
nslate_further =3D adev-&gt;vm_manager.num_level &gt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;num_vmhubs =3D 3;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Keep the vm size same with Vega20 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.translate_further =3D adev-&gt;vm_manager.num_level=
 &gt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144281F53477A921C5BCD95F7639BL1PR12MB5144namp_--
