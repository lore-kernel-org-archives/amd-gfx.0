Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282A1E81E10
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 15:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B7A10E531;
	Fri,  6 Oct 2023 15:46:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B9110E530
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 15:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtfBuUY+6RNc3RJ4EuAXQ2DGjyaZBLulNbFf7p8QZNdvc4VVXJg2DJIcSUwFqSK2HviaDMN/SxP1ne9pfWfInNt1YLeuDybV2VKGWbGAWMqnR++cZePMYA5SU+9yvU1QZfeOH6+DFUjssifTlMKxu0wWyWg1N7+FLv7gkkogA4fSL6w0J1ykJh6KZHcsXAmVWQIyW6lkWsZn0c7Zw4oaAeGcOrDU7Mqx7pbH6InrkRqeFImxLELC2KfgDtbeChGzHeyvT7yHUk5qPpOKWADNJh4JODJ+IZ69mSGQorkWOLjnvN7LsE9S/vF+M2Xr15gmigHzjcryxzITRzGnnxk2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsKgA+YXlnqTdeqSHvXjcpf5LDyhHUXcnpkrRrAxtYU=;
 b=h5IZm9dJDYvjWoPHSwsuu0S2UZtqfrE6aaVaiJKX0njjUww2qn3x85pIYcS0ltC5DdV8IiJ2mPi+uQPLhvSLoAfrVyfvBekEelg8gZTVZL4pwrYbTh55PIFEre7wkt2hxLiVtg7u+oHGmGKHQuCiHeKLGn5fzsq0q0cIVlqkR2qimK/A64haNoeaiNrC5w5QszftDTh8fChRcoaPapaP+2Tt86lKMQgMwrC2kuucCSWSi8NdOya0pWCfv4dNcdEkfbTCK/1Z9AHCLpwh34picXAyBN68mikuyuJkrjE/fmEEIelhj8QZyhiX/ukgmpmd2MQdoMOAsS04KzkbsXah/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsKgA+YXlnqTdeqSHvXjcpf5LDyhHUXcnpkrRrAxtYU=;
 b=06jpPrxRpjjf3jXJ+w1WQQGABMmaBWI1U9zJE6Yxr2m2woK9iLkVNVX26OLCjjQna6TChbSVKWvZAtLW3zjKPtSpoExripCjSrYZeTXikJAMeS3sQBrsRQsckF9Tb4xpeYmPtPzuBOPzeETxgjIcoTP7JDNPF1Spr9TwpsA3USw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 15:46:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 15:46:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Increase IP discovery region size
Thread-Topic: [PATCH] drm/amdgpu: Increase IP discovery region size
Thread-Index: AQHZ+BIQ12KpadegWkKP+Sfmiu5Tz7A86Fxa
Date: Fri, 6 Oct 2023 15:46:32 +0000
Message-ID: <BL1PR12MB5144924396C427498B2716D0F7C9A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231006050004.1556697-1-lijo.lazar@amd.com>
In-Reply-To: <20231006050004.1556697-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-06T15:46:31.749Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: bad31685-ae9b-4d7e-233a-08dbc6836a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vj16fOir/UOx1NPwrRG5nUeo+J0SoDXwX2mX4ZW+NkvvB0+RTNGkUisagPrTu2Kl7bw1W/3xk6yf0t45nGAx7HhpDo4FRlXA+8ttygE2XOjeXsLHHT0Itt9UzaTRvQglajje1yRb2+6kjKCxvZUx8k9I6QSIHIR7JNxK4529ep+87mJZYhBjE5DXL7I+1LUCpD5XE0yE5o0Kl20rCvO7BTgpBInqtqcxaCOHHojlfksWlbgzLNfRt4mWvIcbdmjD1GpWJcsPuP1bWCxI0MFEDvX0uGiwhHMFDX/HtpyEFMktBlZFtU6xCT7aKNybrAcBKo0A2LtFmlVUs921BuFxA5ef6fR0up9XEwXokOBT+PXzwzHy2JCszpHtr+RRWu90DqRfRWzCeiyH6XZkmFwPcdk0FmDZBUMY8k0JHZw2lK8s5iuT8HR1LodpfTWL7lI+ELcrmlh4OvWRVrfdFKJo9kQNHsGoSqGVLYr2dYoH2nVJzlEjVXa+q/lX4gRxIAFHTAxHeiQFQBFkANWL/zm975teAOo/46JMEOg8KFnMb2FLbTcw8wWBj7WlPo1ZKCPbswyxvQtOCbVPMndy8pBYmNsw2JNr6UxD+ArbwA+ABJ/mTwUHCfEp1Qzgc0JczgJy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6506007)(9686003)(7696005)(53546011)(83380400001)(316002)(71200400001)(26005)(2906002)(110136005)(64756008)(66446008)(8936002)(66556008)(66476007)(5660300002)(8676002)(41300700001)(76116006)(66946007)(4326008)(52536014)(86362001)(38100700002)(33656002)(122000001)(38070700005)(19627405001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fiUVGdmgDIKJ5nEKSlbm7u0uouz3rCeSwWTgiRU1qjiNARHxLe+BO+WAHV7?=
 =?us-ascii?Q?860ZJ5PKi7YC9jPF5QP9tBBFHfp+hZhq9gxsAPkxEbmDGzYc/OhYtIDZCa9r?=
 =?us-ascii?Q?w5P6Rspbyz6/junS/GFm+d5I0B9ZJNO5wR7huCvJ9kDPBlPgycIP+Ls7Srfd?=
 =?us-ascii?Q?GCqnh8/ExsofKk2A4CRlWYzYLlogVNnW6omOFM8LPRTv2JgBilDmx+PKRh4D?=
 =?us-ascii?Q?7hssz25ru7889wYECOHPLK6FRAIw7HMTW4k7ZZkYAyJTf4yChzDqNLyeN/LV?=
 =?us-ascii?Q?/qwQBFxkXSAhGNz6uU50OcZ2t9hGNWV+jrjvQQGZkpCXq2HvEIT4atKeNC3R?=
 =?us-ascii?Q?F+SHJiir5n3QwOUIAQh4BPtHSs+mQmjwy3G012k4z3muxVORyFDSbaIeT0ze?=
 =?us-ascii?Q?GmtGgiu4WUGhjado1FOfgQkVrJv6WP0ITRoXhGhhss+HmKxZA0GUxvb1/mtc?=
 =?us-ascii?Q?n8g8IB4Y6e6WptI7gKaX9kXp5lKE5bNPnrBWhwJMPUr6axxLllnGHtFC+XiH?=
 =?us-ascii?Q?KOzbVAQbsPgI3bctyY3idz0FGhCrUx6hoNT0j5Zmnbdf6rR+xDUjt79ToqpE?=
 =?us-ascii?Q?L1Qx+zgJT3Vhwe7DNSS2ucTKfshLwuN5z3gQ0UwgiKwmnZwdO17EYT8nX3Bq?=
 =?us-ascii?Q?Y4EVT6I5SsUcHLuoT6PaMinI3kBMRxirgsap2AgzBQMI29Z63Z5O6JR3AaEO?=
 =?us-ascii?Q?QYyAW06sdNf3OjnpShzsGdcm7R6j3z1mQoTCp5UutZsWJHNFOtoixeDux6e2?=
 =?us-ascii?Q?5Mm8xyYTxsV07OEvaSuUVQcxF3UkHBJcaDLoO82osStRo4WInuDSujnX2GGE?=
 =?us-ascii?Q?ZB9sBhSwe1TPe/JsAGFVzFyGaD6WgDFgPOmcqynf0tle+bZEtLX92k39fCKj?=
 =?us-ascii?Q?g3h+ZgL26BjhfrsrP0Y77q1F6ySYLQNKdAtoZ6kVE4fwGOzzxR2efDtp4Mfv?=
 =?us-ascii?Q?I/H4IGS2ZMrY/f0eXmNWdo7X4xYUHVEFrjhCvQ9ABXBCEXI6tSrJDndf9gZX?=
 =?us-ascii?Q?ftMfg8SLYAtqaOpb3rHBFfNm4r1IWMZuDgOMNrD5BHglqVfjSF/D8j5eA7RA?=
 =?us-ascii?Q?5KlOdRQa9sj65mH0rt6XuqhNNsjMbT8rdAYwVtHbntSTISX8r6VZcHrdRh+s?=
 =?us-ascii?Q?yFnSxdCwnQ0t34HDTI+3FA7G/mD4emnwTCpaW0UtpIEsx44GiyY6jrhRPZ1W?=
 =?us-ascii?Q?wb8mvcA+scUu8P01q19IuHqefwBjKUQgQB/baiVcPtKfEZTz8RtNtSVV2A6o?=
 =?us-ascii?Q?s9NjTlHexcORWGCBdM35ArIAG/UjLcvL692vRtmlb48RLIQ9OYas1x6a58O2?=
 =?us-ascii?Q?e9O199UCgyv0zeAFcK8V0b+OCl638S+1Bw1aEO3w4VgUS/UxwrTH9cIi8+Iy?=
 =?us-ascii?Q?5UBJbOYxfnyQrDSjTTjVwsJ3Q/cSj7ttF+0aXTQ0IyN4OHiHs4/TMHFPriQ/?=
 =?us-ascii?Q?toWCva9YVsofDFoCg2OHtdPloC5AKLKa8e1EAQl1W/gvy2Lm+D2zYbXy1mde?=
 =?us-ascii?Q?Q3yOfvDPU9FMrLQ6GjW0zd1s41IZaRxMUObtzi69uyoM40RxTbUWJCwK8hHC?=
 =?us-ascii?Q?L/m96fv5m7UYRss5YxI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144924396C427498B2716D0F7C9ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad31685-ae9b-4d7e-233a-08dbc6836a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 15:46:32.7078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUZW2/da1/DgE/FLHoF2ljDmKaYqugeLxXwlCDajdHgdKDfx7oCUiAFuQ6N2zPA7mDSiIkJ0anm1WDLQpvB//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144924396C427498B2716D0F7C9ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, October 6, 2023 1:00 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Increase IP discovery region size

IP discovery region has increased to > 8K on some SOCs.Maximum reserve
size is upto 12K, but not used. For now increase to 10K.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.h
index 3a2f347bd50d..4d03cd5b3410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,7 +24,7 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__

-#define DISCOVERY_TMR_SIZE      (8 << 10)
+#define DISCOVERY_TMR_SIZE      (10 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)

 void amdgpu_discovery_fini(struct amdgpu_device *adev);
--
2.25.1


--_000_BL1PR12MB5144924396C427498B2716D0F7C9ABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Friday, October 6, 2023 1:00 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Increase IP discovery region size</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">IP discovery region has increased to &gt; 8K on so=
me SOCs.Maximum reserve<br>
size is upto 12K, but not used. For now increase to 10K.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.h<br>
index 3a2f347bd50d..4d03cd5b3410 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
@@ -24,7 +24,7 @@<br>
&nbsp;#ifndef __AMDGPU_DISCOVERY__<br>
&nbsp;#define __AMDGPU_DISCOVERY__<br>
&nbsp;<br>
-#define DISCOVERY_TMR_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (8 &lt;&lt; 10)<b=
r>
+#define DISCOVERY_TMR_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (10 &lt;&lt; 10)<=
br>
&nbsp;#define DISCOVERY_TMR_OFFSET&nbsp;&nbsp;&nbsp; (64 &lt;&lt; 10)<br>
&nbsp;<br>
&nbsp;void amdgpu_discovery_fini(struct amdgpu_device *adev);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144924396C427498B2716D0F7C9ABL1PR12MB5144namp_--
