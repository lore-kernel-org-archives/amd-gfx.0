Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA27C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 17:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2E310E532;
	Tue,  4 Jan 2022 17:15:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E924810E50A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 17:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4UqBCumc49iU0PkSMUL+hvlbajimwi9o3ll4pRVbjyw27ZJAOQPNWfrPsEhqRkmYtUyF5h//gul/p8UyGcIGiCn0aaTYLTCVC6ZiqWYhYYyzvfykrJrrBu6fiz2AHrGbgjdbPiBYIFi84mAhOt8eelj/cOq0zDTLw45QRjQZYU7ifHsidcb5Sh8QkyQOFKX1gM30olbB1utCpLDnLSZyctN4BHsGhrNq1JhG7TopCVC1yqMV+tlbFFqGB0fp7uzXh7QfsIOZcb+EL9ly3728qwsnb2t0fdFvaFE0pAlr6OYtB3zlG7wnNPUdkFDmJJoD5Y39acF+D3ccy2GH39nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIxt107iizLP0VBfL/c9gD9xG2FpbOCdqhRk3s3q29g=;
 b=aOvEW8H9DI+QjbG6OQgdht61mwJCHDBDjtdknSK7hlO8y+s0/cWebc7iVw0qHjyaQ1tctHkCjaVLzRtNuQgReIj5NuL/JQJP75x8dOJC3zhuparqsdGSvoNjQ/fEsCVI8zg1KP5IXAGHzbW6bMS8vc+ErSD6R0WOCbmBSTPAf77X1XDqq3mLLb7fPMz6pc3iCpTVUhnz4olyapuTxlJuEDKCrX6oLLIlnyxQwIoY5F4WqxyJAlvceB8zgKUBWF1Mt6VW22ToucS9sIl7dDat6f6JLdT7ycZkh45lb79XdaWb2oCxjD/kMq1cmHv+ga8HO9nBSb3a2eGRAKbQoB0rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIxt107iizLP0VBfL/c9gD9xG2FpbOCdqhRk3s3q29g=;
 b=Plcwp6aHmFbSNUbHJ/T9W33I8tdGcZAnsGB5Bk9/H9ggROg/0yLM3L90663kAXh3Y4bdJyzaJFS7jzhQrGOD+k3KAd3bjeBlOeyqur6Gt1itd0xRiZP2Ryn+RhFyEhESw9kzjb45xYxyIEdfJUP/ZOId2I6AVo1CV9kd9gtR01w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 17:14:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%8]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 17:14:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: explicitly check for s0ix when evicting
 resources
Thread-Topic: [PATCH 1/2] drm/amdgpu: explicitly check for s0ix when evicting
 resources
Thread-Index: AQHYALX3kuNQsjfi6UO72WLKGcDqAqxTG6HE
Date: Tue, 4 Jan 2022 17:14:58 +0000
Message-ID: <BL1PR12MB5144B867DC2BC2F8203E4268F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220103152311.1453-1-mario.limonciello@amd.com>
In-Reply-To: <20220103152311.1453-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-04T17:14:57.944Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 05f5fb91-44a6-313b-8023-b322494e4c90
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4c3fa1a-93dc-45f4-fc95-08d9cfa5bc6a
x-ms-traffictypediagnostic: BL1PR12MB5157:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5157DEFD63AD5AC0D0B54026F74A9@BL1PR12MB5157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5knXMutwTAzbAAoSkzJ39dPBL6qtcF+r1qrOLkTpyBn/4dOo7GxkrVXydToxzzs/xIwtd8mP1P5ke02GjkOZ6CCetxMv3GPqnJwaqbX+bZv7uhdSdmdMhlxqgHAqMX1E2Gdmk2CQW3+EspZHnYhHAzPsG4MZS/jdg8T5Oeiryk8AKlhj771AkIsswbxo+KuGfwSMLctU7Ht99Jfg3W6jbphTAIA4xW1bUmqIWZAYPmmBZsufD4YyZ3KSgNjHTRsLinezKmIkRFZ/yBbYZ+zd6aWccCYmP8MtHCb4h4VqLolaYo6j5BRh5V+hNFqMnbtw5fRGxQZ866FPORCLcKB4/Ls6XfNZ3TLHn1gaamWohVsAkT2muFyL5cPMy45FX2oRctpJJZSntis0iCFUvNtmdjkfOMunSQJ8UsPAVy9Pde6xw46JArffqJTDxHH9WwioED7MmTwte5myhnKppJcprDRWhvugRVQLI/hMdeCg/n8LyGe47Ckroapl5DHdv6H07462ThhT4NYDTtrjAIebd8EmBKmSMvWOI9x38RyhvaVFgadglO4ZJO5xqIYdb3OfjU+oF/dBJLUjSMDBz8HYsGkUobqP8k1G/ensyKa/W84AI+B46Mz29wX+D3xGy9QSXoaf6SHF4QkUeENfGnkopwHGciBg0rfWY3BRqQt4C5RfkPJORbkloUcu8kAwHVWdgXn0q0ziEYGfF8oJtooHreKqq0KxR0lFlnxmFQUHDtg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(64756008)(76116006)(186003)(66446008)(33656002)(86362001)(9686003)(55016003)(7696005)(26005)(2906002)(8936002)(19627405001)(66556008)(83380400001)(66946007)(110136005)(71200400001)(66476007)(316002)(5660300002)(6506007)(52536014)(8676002)(122000001)(38070700005)(38100700002)(53546011)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IQkh8rtdSeCQn9Py1/U89jhb+a3SjkLF+pmUrJpleOi4kbwQYIwRay2DhmYV?=
 =?us-ascii?Q?84LGx2Gb7EQaG2fqwm35HT2kQ/fsp08AUcb3LCUuM7lPWNTNYLE4INDdXW9O?=
 =?us-ascii?Q?nYEI+Ck3pv9JLP/CQnK9orV/JwVopbdfD0wtbixtMtk4IwkJKNzixRcS7HDe?=
 =?us-ascii?Q?2pw4AAOCdJ/TSnheszv7c1y3c067VtlwlWLtOmdva8Kqd4Cmcc64TBNHo7Lm?=
 =?us-ascii?Q?iHeU5eeVBbJKQTmRJpFFdj4npZeBStjPDSEARFEZZskkgkrh5q715v62oiVV?=
 =?us-ascii?Q?qIDGmuwyZWpK+OTAXfGUpbrTDtrAXhyThwQqwdj0vdSENRXvPxqlhJY6EdX1?=
 =?us-ascii?Q?gR2SgE7iVWYyPAJtF+6GXW8Wp1zyXbTvbm4sRhrPRQhrfcIwKC7xDlH8vWMc?=
 =?us-ascii?Q?Vrq6VGIVSKLxpAKs6BzfnShb735q5LmjU10wyNgHgqDqO7gvShw1TMmoDwfD?=
 =?us-ascii?Q?y9raotwr3Qs1FLte84jmc/AuGGwODmoEav3FCJj6gjm0rpfFKK49ZQ4JJ3Fd?=
 =?us-ascii?Q?T3KSTpkXxm0FHxA49/0H/2n8L18O0X0QwmLkFRY5u6sVwme8J/hga+EEtcme?=
 =?us-ascii?Q?+UDQUjpoSFgj+LUHnDSXlCC2nbzK/K9oK7VrW4E3QMV5q44rRT9dkQtn4e8v?=
 =?us-ascii?Q?fGZjIw8katCJmYWCETtXZzAw1qjw2TPV6V+OcG0Byur2IJi655WHeMBIcRIC?=
 =?us-ascii?Q?LWTZrlsCXCuvrz1TWnYAjYd4kPz4DvL/1wwEQQgCoCRU8a945Q6SP6cNjx95?=
 =?us-ascii?Q?lS+4s3czEPj2uYuEEA9vutbrz8ygHI7EEzU808Ic3PfqNIdqnscpkY0ReOla?=
 =?us-ascii?Q?FDNMEFKnLfaVtcsXdeNROHTOokkLBz/G3j/sQFo3GA1lLjlO3cieiA3fs8B4?=
 =?us-ascii?Q?2luqBzvu5ekBnt2kHwH7CmYc8YmjDgNGZlTRmQ5ua+pA7Fb9uUZbrLKwZyTC?=
 =?us-ascii?Q?go9BvO2B8H38hmIaln/Af3pFQz+KmdbxYARkm5Jkdun++GG+r/ZquTjoH9qk?=
 =?us-ascii?Q?uavvK7MFrIWZqLlEdDn9qXkvbu/anaEvB+tXHv2QXMuBT7kTRQ7G8uDMJ3CY?=
 =?us-ascii?Q?94PLMhazw5hlvmyFAjXEe90F6az3Ud5r+j13pRiTOAX2Jsswx+bxXEu0MweO?=
 =?us-ascii?Q?7yt9vfrWvtfc2vF/+NXvbLWG8XQOB8nM4pg8TLzZ8HdM8lIMxnCZUQqN8iVq?=
 =?us-ascii?Q?GsQx60W5VNipRteIoRq5X2n682n9pYAUa00HFm07VxKB7km9HtAWvcyi0n/0?=
 =?us-ascii?Q?OMoktkr6wbGEmH9HYW5UDAIkz259Llx4FI3+EjxB24Mb8ugFmGuxnpxSE23C?=
 =?us-ascii?Q?KaQdXod+/qKizBt5ILQgRuJ47p7wI3BBDSWXlOAsure9dktdGTjWAeVqZtqW?=
 =?us-ascii?Q?98EcbC9StYGmoiv/wTS1lVzIk9GlxCoaKyp2kLifzgYu3gHpIaCJPOtockey?=
 =?us-ascii?Q?HUlhf9UyUzdPuai6XwLmyhgbs/iqmw4DA6QMzuMOVjHeOadyNYv/XfjMopPy?=
 =?us-ascii?Q?RZVmPPJm6g5SNDahCOglVriYANWp8e7xmuqXyUArwEPFnK+lPiBypuxD6E29?=
 =?us-ascii?Q?gmUmZZWSC+a3Z9WLCD4VhozY7hCn/GUPCTFI4o+XHhABdigDkkC+VqKqjeOs?=
 =?us-ascii?Q?TT6+zdyqN1V5EAqSEEok5y0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B867DC2BC2F8203E4268F74A9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c3fa1a-93dc-45f4-fc95-08d9cfa5bc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 17:14:58.5911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EducVSJyNLsIDCwX5YX2WTZp+3AYk/NETbbx+KZjK9XRBkOw+PmIE2bAQ6eK8JELOA9lC6Skb9W+bU6op8eIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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

--_000_BL1PR12MB5144B867DC2BC2F8203E4268F74A9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Monday, January 3, 2022 10:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: explicitly check for s0ix when evicting re=
sources

This codepath should be running in both s0ix and s3, but only does
currently because s3 and s0ix are both set in the s0ix case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ce93a304292c..412f377f80b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3956,8 +3956,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)
  */
 static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
-       /* No need to evict vram on APUs for suspend to ram */
-       if (adev->in_s3 && (adev->flags & AMD_IS_APU))
+       /* No need to evict vram on APUs for suspend to ram or s2idle */
+       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
                 return;

         if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
--
2.25.1


--_000_BL1PR12MB5144B867DC2BC2F8203E4268F74A9BL1PR12MB5144namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, January 3, 2022 10:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: explicitly check for s0ix when evic=
ting resources</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This codepath should be running in both s0ix and s=
3, but only does<br>
currently because s3 and s0ix are both set in the s0ix case.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index ce93a304292c..412f377f80b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3956,8 +3956,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)<br>
&nbsp; */<br>
&nbsp;static void amdgpu_device_evict_resources(struct amdgpu_device *adev)=
<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No need to evict vram on APUs for =
suspend to ram */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s3 &amp;&amp; (adev-&=
gt;flags &amp; AMD_IS_APU))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No need to evict vram on APUs for =
suspend to ram or s2idle */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;in_s3 || adev-&gt;in_s0=
ix) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ttm_evict_resou=
rces(adev, TTM_PL_VRAM))<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B867DC2BC2F8203E4268F74A9BL1PR12MB5144namp_--
