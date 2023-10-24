Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB2C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 17:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA4110E439;
	Tue, 24 Oct 2023 17:32:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CED10E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 17:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvmWCTobmFjkcP9ix/47Ye2yupGVy5WIXW5NjeghZ+xYEjhdEzi4Edd8WwRgvxeTTDbOYQTMKeAsyQi6vwKhA3wfqZeqIpvPYqTK2LGycUJsZqy1jNAeIMb3/EfLiRpDAaNflZsVMLfX4+0+FeyDtY+bIfey/8XJQ7tch7xrta7EtUHHK7PB8omrUCMTPnIenL/v9EKMdjDGgv4l0FXMVbtLubA2Non1yLKKMcJq3SVAveSVf0ibtmJqN0mUs2bDaHPg3CLc6LcWDtwZHkH58mHtCfL5nAXwQAoyaNwPyG5E+9KFet3IvVmsxdj2oxi+tMxBn17G0eI2o02HGCEkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8y0lFg3xK00XB2X02+5Isih9ivpX2pf7BTmqnDgM9E=;
 b=ZDh69uWoAGPHhLhOZRZy9zWm8aDm0YcOmFi/TVwzVrxbzF/FJzztPl5X/wmCT64pfsuCHX/+HYR4sPTNcTj6BfHYW8RhcV1m2zmGxD1Vh+f5VR6MoQ6KkuVs7BC/gqts95HQx9tE9kMy16/tdLyzObrsWnVBOtl4qGeyfPwcZ207hfQtkpXtmiKkYdXk7hoidjk07hLqPzryM7IL+ERAgb42wbaqI3KCFk5DfCcnvHnOEBz3drw5gLpbAHnnSxMAwBMJ+atC5bIJkf1Z/s+Aw2XYnDY9G4ttZmkI66+i2+yI2ljr9zTRUNG/E+7lfPR+Hdsq7ApLrtXjt717R8Be4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8y0lFg3xK00XB2X02+5Isih9ivpX2pf7BTmqnDgM9E=;
 b=BYW0eJbSoC3OKF7Xv+7fM/VriAK8Er01j0zCIgvaCmiRLUvg3wiuCctkvXtm0bGwQf3NeG4D1c0OOZpfvkWd7+bGSWY0h14YMK6gwLz7HvCDX4BclDRXOEmyHJ1gNY/jzyGHFzSWe6fOdOc5xYoHX9fM1Z/0S4KoQ/fzkONeAXU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 17:32:33 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 17:32:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: avoid to disable gfxhub interrupt when
 driver is unloaded
Thread-Topic: [PATCH] drm/amd/amdgpu: avoid to disable gfxhub interrupt when
 driver is unloaded
Thread-Index: AQHaBirN/w4umrizzEm4EoNg5VRGv7BZM5Wx
Date: Tue, 24 Oct 2023 17:32:33 +0000
Message-ID: <BL1PR12MB5144E040D7D2905A1829D5FFF7DFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231024033247.760912-1-kenneth.feng@amd.com>
In-Reply-To: <20231024033247.760912-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-24T17:32:31.458Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4514:EE_
x-ms-office365-filtering-correlation-id: cf288fbc-4149-4a37-0963-08dbd4b734c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vx7KDYdI8nBkh4gi5bCfVFpfqjs3Jq6i7bWJnLWBUt/qFppsW1cpuK7X5xbCcalW99NIinMljBcovNu+lC5tenvt4LonAioKVHu2eL6wHJZMMIe5lcLM10BbQltCc2yxDl6Bwor9C8Ko3+QguDuYRhnCnyLcenf5cjZ2AFmn/dgIs3KXMmiFT1FCdLIu2tdhs1VoQVeHNVpD1MbwIJSgnod9pfOuvpgTzf6423/khqDfOs8F1vPELa21O+Je4vBvtIV1EBCv4lQYs6JT52AsIPBqTan8Okqdrv6M3JBb6DQ2x1dEjeHayN2o5QpZtGnHXB6Xp5R8tej9sKPY4nv6XyIA+ABNKWdrxc5ZNvKekFyq84UlsTYvDvIm+uGjjhMaGF4tmt16OM119/g8Ycqt1aMjl5I/7ttMbI1s2zfaJIqocJMnK1O0vFaVrw6EL734dVj1t0P5Lm4CaNKohFU82iQzIYjCQBy2eqdMB0cL3jraYjlW/8GecpjSAPDOeZjsP0C7mU9zmTkS3jN+bttyAKm9968z37YhBr+BSYqpaqQUeTsPlb6edbcLmvgJGz2MCNDE7yyUtT/jL1esDlBRZyF4QPvJI4TUre8Jp+kvREymmOMC+k4m5CUcCRJO4Fyr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(7696005)(86362001)(6506007)(316002)(64756008)(76116006)(38100700002)(66476007)(66556008)(66446008)(66946007)(38070700009)(33656002)(19627405001)(2906002)(71200400001)(122000001)(83380400001)(8936002)(8676002)(52536014)(5660300002)(41300700001)(55016003)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBEL8u9nWhy1xgdzG2TUId18Z3rLdow8rS65OXF/gg4an9hZel+d5U8/5Pil?=
 =?us-ascii?Q?QXhzuTAl7eb1EqhOB7gki4xpOELMJairl09Pcoq5CgW8MJmvXnoBG19+nHeJ?=
 =?us-ascii?Q?eIFNu+TFbiWHbmJ7P8RuseFRqNUMUE08kf8Wzqb/7M1njatkc275e41R50Ac?=
 =?us-ascii?Q?RkjpNFePK7g7YsZqgDJoS/Zd7zWYyW544EhSW9xElXakJV2qsSdBwk06MELg?=
 =?us-ascii?Q?fK04UHjzgStIuTDVAVkbFdvktsPE4gHs3gYt/VBKBkSOf0YfiMySJbnFgyyt?=
 =?us-ascii?Q?ayOfaa6nskUimS7Ue5JkPVWT4GpBcfOK0h47jc/EMwlidsjfZnWCQ3QEsrO2?=
 =?us-ascii?Q?1y71XCDGvNrn7eyRSjB/30p/iy0KbbLL4uDMGSoChAMawSusN/Z25CSoTvqv?=
 =?us-ascii?Q?FD3gaQaRXql0a4f2D03wka1fZsk9E7n9EiOdJPr07PqhTwdEnExt1HB2Yw3e?=
 =?us-ascii?Q?6S2n/oK7tIwV7JQv/cs5gwqY7T0AhQHBh7h4iezEwyXN1qtnCjhrmzgOaQvn?=
 =?us-ascii?Q?cU4zDAAF9sHyzAe6RuG48kaAFhMLU1cLA8MR48hBgjG7o0yL6eSNJ4unXtXa?=
 =?us-ascii?Q?8PPjHoR7SGHYwa1er5QgWfrZfwQuvZUJ/FqWhya+ONrOkOCDifI5eGkvhjBc?=
 =?us-ascii?Q?r0te3lL18qDrApt5INzC8J6+LE41e66Ak4Uv5oscD5kXpb9G3WAx/FfT/BIF?=
 =?us-ascii?Q?6yCo6+0NxH3y/hu74lGPApnc1CcExC6a8YaECpNVAVcRRcTttttEyn+co2kg?=
 =?us-ascii?Q?2tC4fGmOm9Vp2Rf65o1KPPoey98ttp71mh2OmHCJKjjlbon+tdXrhL+G3dKO?=
 =?us-ascii?Q?KhzRFzdqoRdYwQ7eNyFSL+nAo79NunZLAix/MhcTnG8jOk4C89Ie6IDHRAlW?=
 =?us-ascii?Q?5oYVF0gEreqDkwy6k3kMCAF7+5FSjJ0w6UeBRCV/PxFRh+iKmEgBTeXTbqj0?=
 =?us-ascii?Q?rnr7oikDsEYDuPVmdoiZozxOnc5masFdvVv4nIkOoewMOdffbhhBHpLJbcYP?=
 =?us-ascii?Q?iMRUvvZR5lZWhUuXn+FlSmoEwP4ysPABdwdLc+IhFPQTby0MlstCG/KeeJBB?=
 =?us-ascii?Q?LUW3Boyz6Wylqs1sXlIzhKfr19yYvX99cVfSJSi9NUVLpqzvjHDhYV1eZLb0?=
 =?us-ascii?Q?eTmLKkw067V4ytKuL+7RzC9o4aFCJlDmSXZJPUmHSZGylYGSGvpzudL5DL2f?=
 =?us-ascii?Q?neLvLU3jZRrKLflI8KosmprukE3ZhZlFmZgOqqgsBLMaZlVeLoJSX+/Lk5fK?=
 =?us-ascii?Q?qBuEvHvFunAG8tC07B+bXy+JBFKao3n8s28SfBMCvNrsIe/LiSaLns0etu4E?=
 =?us-ascii?Q?xWbmEcfw19pnovF9eV/uh+ZT1Qt7wQkhry7LAVcSYFImJrFdP0vZGmVzKGFs?=
 =?us-ascii?Q?A+Ycov5sPECnulrjroCf/y+LtKYENsdYmKhp78EGZWTKrbPr2RF5gaWFIw/0?=
 =?us-ascii?Q?s249xQPIIb6bT/xHwXy0fisN3gT9LZ8p0YwFNUfSY6nFfJYhl5TH7bd9qvLi?=
 =?us-ascii?Q?4QVyXt74h/DyjwyTDh11RU6rBKYvFe8j6YAaF2Lp+BKpp61vsXZ6K5FoDQo8?=
 =?us-ascii?Q?ObZIsV1tUTzHNPQ3Ps8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E040D7D2905A1829D5FFF7DFABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf288fbc-4149-4a37-0963-08dbd4b734c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 17:32:33.2335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsaF7ZSJuAbpoKP3IMxepfSPSuhUYXvKpd7wnCAsE/R/VVH1KF0a0eGoEfOfuJgtSqvxJSdqDOvnzRuOxGgFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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

--_000_BL1PR12MB5144E040D7D2905A1829D5FFF7DFABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, October 23, 2023 11:32 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: avoid to disable gfxhub interrupt when dri=
ver is unloaded

avoid to disable gfxhub interrupt when driver is unloaded on gmc 11

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 80ca2c05b0b8..8e36a8395464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -73,7 +73,8 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *=
adev,
                  * fini/suspend, so the overall state doesn't
                  * change over the course of suspend/resume.
                  */
-               if (!adev->in_s0ix)
+               if (!adev->in_s0ix && (adev->in_runpm || adev->in_suspend |=
|
+                                                          amdgpu_in_reset(=
adev)))
                         amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(=
0), false);
                 break;
         case AMDGPU_IRQ_STATE_ENABLE:
--
2.34.1


--_000_BL1PR12MB5144E040D7D2905A1829D5FFF7DFABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kenneth Feng &lt;kenn=
eth.feng@amd.com&gt;<br>
<b>Sent:</b> Monday, October 23, 2023 11:32 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Feng, Kenn=
eth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: avoid to disable gfxhub interrupt w=
hen driver is unloaded</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">avoid to disable gfxhub interrupt when driver is u=
nloaded on gmc 11<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c<br>
index 80ca2c05b0b8..8e36a8395464 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
@@ -73,7 +73,8 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * fini/suspend, so the overall state doesn't<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * change over the course of suspend/resume.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;in_s0ix)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;in_s0ix &amp;&amp; (adev-&gt;in_runpm || adev-&gt;=
in_suspend ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_in_reset(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENAB=
LE:<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E040D7D2905A1829D5FFF7DFABL1PR12MB5144namp_--
