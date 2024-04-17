Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7BDC04FF9
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 19:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9676910F7C4;
	Wed, 17 Apr 2024 19:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H57KB624";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DAE10F7C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 19:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns75SVmIUaI8P1BqpOlQS8HIFjLaTAU19dlatLGSCJ57fA4dCnqIdoOPzszvJArHmQ3+wj6FI8DrdzjtIQ9o0dpDtJFxFznmOsHTWkT8yWJ4ENJJT6D7U6vegtFO6+OGOszOf4RD39ukdud6wsK1kltQkINuCoydFbYYAConnYMdbd4/QRdH7+dllVNKy67phWEyOVPS+/1mX+Nu4ANP3tkcwku9Mpq2Nsvbejef8SXSAOFlPbsw6PujRdwj0L7eiO/I8GncsZMYJ2MryyWcN4gt2elcJSbk2Zlb7HmAaw5ar+j83NNMHMvZsiNJtEm9vXbSFcVsdCegL7o/t+w3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMPezSP+oZVTHuNG+fLWU12Z96rAeCxLk3kSOds8/us=;
 b=Zb7W16UjyBNuji8zwq6WVSieuo6MdMkamz0ocBL7PvWN2LXcYS/asArph/Iqsk+D0RF93LvO4w9kScpDF36TPVtm0JZrL44ELLzua968Sd7GiofbgL4U9dnXpjhBzDJE5nH73u5w0/ctlOZYtxKNutPkhagZ7l121wvEGXltQT+d911v3uYCKfU3+psmoeL/RIaay+oDrW+dqYT0BcJjGt/OjDVPPIPo7obbM0ZE0IenUtVCaZ3Igt4SJlhzSv0JfXz7k3hHRq9d4Qtb+Ey61TakBpvbY+wG3cp1y5GwTGMrolwwaqfRT/Swo3jWt0C2NvLBi08JbGmKSHK/jpap5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMPezSP+oZVTHuNG+fLWU12Z96rAeCxLk3kSOds8/us=;
 b=H57KB624QJE4LoN+MGqyn73MDP3xaxAFXeMoK6+GPaWgQHz2RCz7gYOSJv2HEiEErw2C3uibFssNhmVBoUY6xSJRqnxCMSGPpo7ajW/z8JQc2028KY8aK7sHoN8KBZCyKr2S3Zy4Ze35+oroXbbZrnzM8c4GNVDEfjtGysNCyoA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 18:59:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 18:59:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
 handling
Thread-Index: AQHaj8LNh4O91YQF7UCA4sadEL726rFs0zQQ
Date: Wed, 17 Apr 2024 18:59:53 +0000
Message-ID: <BL1PR12MB5144D2824491F797283EEE24F70F2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240416055602.2036-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240416055602.2036-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-17T18:59:52.715Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB7941:EE_
x-ms-office365-filtering-correlation-id: 7e6e4c1e-0fac-481c-39b7-08dc5f1090a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mw2WJffKKRjJmwAb2/KEkxL2QmTPwRwLE0uV7KTvuJVUMwA4mQemv0IQQR4MKXRrFjadmFl6lW4STzAWTFJW70gq4DBSTly8wFRgKP/9szmqiA2J+YOXU1Soydok3Ir+QMabIhEY+6NVSqFLNrtV4r2cI+I7/MA2RFXh8d5POfvzDZOoUv7ytSS5RIDFcv5wibWTv+j9tW9Q1fVrPiHZj3Z3E5WKR/yhyPCM+FgnPrTYzdYvqh9CsFmssBIqtPdOLvqbuCSNFxp5OKPM9rak6j/tFzU6zRlIVbreLV2/h3VTq5rKnMs3mHnHYZp0V0iUUsgE0+EaGAGhUTxQ470m4pKE9T4IRGa7JXsW6eOyomWNPk+m09FrvBEvCl2o0Q9c5DUm0kqC7UmS0SaNHd3Dp3ZtxzM1UQJEoViaEulK0AS199TjQkWJLkkOKzBGDW6c/a6kTStTunLkmd0ZJQCj/Ys3/0fDcScjQwAGauYEN3l9Rh6JOFMfVYhpRwe/Ci67pJ0YvB5Ch8E+UQMBy0iFKWG6ZLSj3EDx3F5CV0mPivNI330IS+SQ7rD/d0AUTTB3bDtNMdZgCd+0kWZW/gisYSuCXN0dMAJhwVTrsTDlPdxic3p/LlloCmpC69UmFMliTyZXzdU3exG0IW8ibyYVWdmvQCtuJ35mTGAyPcHP9kmhYlUB11vX9T7OcWrv18q5F8Q3VXAndCipZ/5cM1/QHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lM2s/unGl6lHO43EKwC7fVVIbt60DJI3eMy6JlpNfmUkds8I27SY/PyF+Ybk?=
 =?us-ascii?Q?MZrk8fSt69YYTVQnWUda0JhRz8+nWY+NMAq89Y4BSaHTizi7T7K9Fnm6iIa4?=
 =?us-ascii?Q?o8sEoDEjDZb3whNF0MK3jATnsXD3ZdmnWcfN5tk5zha8VLdOtgCXaUn3fqBu?=
 =?us-ascii?Q?UAXk1xPeu8afiAykK2mFUNHvEYS5MswmHNeMHqSKyD92828Zv6LGfNa+GoMC?=
 =?us-ascii?Q?tJ2ZpNVpbwsoWcTZZOKCQvZtG83VY17ZHeEQxUlEMfoMdkSeaYM0peACQ6Mh?=
 =?us-ascii?Q?rPQj/2O5uBdKO0f6gfV4q5pPGoXBXXepszorVPhH5HD6wYjAJMo2H7HqRVDH?=
 =?us-ascii?Q?89ztqbyw/u4cfLPWk2DTNNbwlIBNRFnCf17Aa9B2n+uGi5K+tFRnuUeEFu/x?=
 =?us-ascii?Q?VVAMmrFc3uCE8xUQtizv8nV/hosSj4E3Pic2tpL0PE+g49D4Qf7/zq2EziuY?=
 =?us-ascii?Q?uDwBb1Gfw7eDD+lQu2iH4sCw6QXZirUYD1/YIrWTN23zkQGaDzM7je3dowzG?=
 =?us-ascii?Q?M8UePzh/vPm2XNv43jWqhG5E3zZ9E3jLPj6S7DBkyEn+GM2OTWvldQ6yOrHP?=
 =?us-ascii?Q?TE1AzHngPQvBG7ZFWmzTROSpwFAj1AnvvdzdJlFtWQnl1MUgQw02E8vsGkze?=
 =?us-ascii?Q?yyg8TPDXaM/gfrbXbBnN5HwbppWoWbp3tzVij9I636QkhPyOw1I/1V7l3tTC?=
 =?us-ascii?Q?5nReQWc+XiPrlEO7WJixC8Adjc87S5yFJKS/qzZlAz8IC3Qkdb9RSBnvoY4F?=
 =?us-ascii?Q?r7jedXucIEOf3FYHzXqp88fdOf1M58wbKA7mLty4XF3aVn9J8UGrYKn57RZp?=
 =?us-ascii?Q?dZwMYFds3iSjHw2fCMW2FhgWq98vqZm9A+edrru+mWkB3mWJUOVM+hGe8VDM?=
 =?us-ascii?Q?ku2unKoGxdVcom6tL1F/uBBdRYFqWejEheeQeR6zk9BpsSOxxux7yx5YAWFQ?=
 =?us-ascii?Q?KXTIjQZFf01+k+49BroTqqFwfnCRJNPawGib1YUuhGwEv05zR9Q3TDf9qt/1?=
 =?us-ascii?Q?nDVAjob5/FpA+HgXXQFOq3rxt5OTWsucduQq6VPz+8UMYk8f+UK5XOBYTrVV?=
 =?us-ascii?Q?G9Y+Qqh3AnwLH6pnKadY9TxYdOsMe3GSvWywZhF7yLkU9D+rSvhV1JTrsMe4?=
 =?us-ascii?Q?HkvevgJocuY8mGga8Mvv0IMV8Cun9lg5qYTAO15eHJwpUJGyGpN94QhoEiJ9?=
 =?us-ascii?Q?2vkDYEBZHmXBuct0+ykkB44Y/Iqx31AeWkA8CQhKpHnwsDTjmn2mnJs3qAI8?=
 =?us-ascii?Q?pU9s/HADujot4OcWuTgdqaTqlsvQPPmJDWOPgG3T7lM1rQKSIyQn8WbUyQw/?=
 =?us-ascii?Q?fay9WZ7Gr6IE3x9vPnF+EOaDh2fwFxYArq6esN29uvHoe9vmFaRebG8rff8T?=
 =?us-ascii?Q?jE5I2dTY96Cq22SUh6lcHct2YwASCWcaBw8G37Zj7gUMUadf2dYaKjXnI0MO?=
 =?us-ascii?Q?b+OMAegZIKft0QN4QqfP4e0JOnsEEZ3hDIKf6nRcPvTFntJ7qKIWMvqYaw3e?=
 =?us-ascii?Q?M2CKf28vtPswAKHRJkdqQoj3hieXzaULDDqOfOraDkjQpalIT/MvqhQzOaWF?=
 =?us-ascii?Q?eh1uec5o/nYaRbQIenE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D2824491F797283EEE24F70F2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6e4c1e-0fac-481c-39b7-08dc5f1090a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:59:53.0875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5rl8yQf80KSeg0JIepY5m8918pwJn4OwNpbw9v1Jxiex6yLKXDCL3OjxKKP6cwttN8melybOdtw27V+3j9p7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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

--_000_BL1PR12MB5144D2824491F797283EEE24F70F2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, April 16, 2024 1:56 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhou1, T=
ao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling

mode-2 reset is the only reliable method that can get
GC/SDMA back when poison is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..94eb2493103ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                                 uint16_t pasid, uint16_t client_id)
 {
         enum amdgpu_ras_block block =3D 0;
-       int old_poison, ret =3D -EINVAL;
+       int old_poison;
         uint32_t reset =3D 0;
         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
         case SOC15_IH_CLIENTID_SE2SH:
         case SOC15_IH_CLIENTID_SE3SH:
         case SOC15_IH_CLIENTID_UTCL2:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                 block =3D AMDGPU_RAS_BLOCK__GFX;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                 break;
         case SOC15_IH_CLIENTID_VMC:
         case SOC15_IH_CLIENTID_VMC1:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                 block =3D AMDGPU_RAS_BLOCK__MMHUB;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                 break;
         case SOC15_IH_CLIENTID_SDMA0:
         case SOC15_IH_CLIENTID_SDMA1:
@@ -189,18 +185,6 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,

         kfd_signal_poison_consumed_event(dev, pasid);

-       /* resetting queue passes, do page retirement without gpu reset
-        * resetting queue fails, fallback to gpu reset solution
-        */
-       if (!ret)
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
-                       client_id);
-       else
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
-                       client_id);
-
         amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, res=
et);
 }

--
2.17.1


--_000_BL1PR12MB5144D2824491F797283EEE24F70F2BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 16, 2024 1:56 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Use driver mode reset for data poison h=
andling</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">mode-2 reset is the only reliable method that can =
get<br>
GC/SDMA back when poison is consumed. mmhub requires<br>
mode-1 reset.<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp; | 22 +++-----=
-----------<br>
&nbsp;1 file changed, 3 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c<br>
index c368c70df3f4a..94eb2493103ef 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint16_t client_=
id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block bloc=
k =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int old_poison, ret =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int old_poison;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reset =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D =
kfd_lookup_process_by_pasid(pasid);<br>
&nbsp;<br>
@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SE2=
SH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SE3=
SH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_UTC=
L2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D kfd_dqm_evict_pasid(dev-&gt;dqm, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; block =3D AMDGPU_RAS_BLOCK__GFX;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset =3D AMDGPU=
_RAS_GPU_RESET_MODE2_RESET;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_VMC=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_VMC=
1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D kfd_dqm_evict_pasid(dev-&gt;dqm, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; block =3D AMDGPU_RAS_BLOCK__MMHUB;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset =3D AMDGPU=
_RAS_GPU_RESET_MODE1_RESET;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDM=
A0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDM=
A1:<br>
@@ -189,18 +185,6 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_poison_consumed=
_event(dev, pasid);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* resetting queue passes, do page re=
tirement without gpu reset<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resetting queue fails, fallba=
ck to gpu reset solution<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS poison=
 consumption, unmap queue flow succeeded: client id %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS poison=
 consumption, fall back to gpu reset flow: client id %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_ras_poison_c=
onsumption_handler(dev-&gt;adev, block, reset);<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D2824491F797283EEE24F70F2BL1PR12MB5144namp_--
