Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 21:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A5610E205;
	Tue, 14 Dec 2021 21:35:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DDE10E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 21:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyJ5gdDhDZbi6aumZblkf83tACVjnCzeq4GUxWauPhRXBt5Kf551e9PXcJEB109patXEBEHILr8Gfwsv7dN3gAEoXq7FWWamYlW6FET5eQTaqFxnAzpygRUCtBy+sERadS7+Dqo/Fpyh3o+2RBjXBCt3fMuCQ8uv1UHtd5Ctzw0fzkGj6mO+wjEYSbWgX0hm3d3XOFmFpnCMsZzoZ53wb2PoriL2yPiMuVnEDX2NI+YnZ3ZtvObNB8CNsz2fKlAAE3U9TW7Gs4A5qKbL0Ilj2DmTtaybELnuWzBqANWqqNpMVcwkOgOqSu0jzXQ9zIuZmlocrnHBdHNjLIg6aykMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjL3MV3i177oj7fGISgg/5caSljMz4AaFdf2M/L8OpI=;
 b=bUr3i7hwqoe91jg+BbE369M+mcJx9rPyPLb5JmF0ISlFpKIbuI65owIyscqwUw1LGccHsFq4KI7ytfjdzZXvYjDDuU1bf6sOAQ5VFK9LUJ6HBKHQk+/S/5QzOJkdHcixTtsbJGlpZ/gz9G+jHxVipx87oYzbROSWQ287T0m39W6tkWxAJAqKwy6+OUYgxXCTtpkwTZ0p9JXtNZMeA9U4gQr0xRDkjD4nOdfoUuvTtn0l4Nm01pbl5HyWgfk6R0UrXTlhmWBTRoVH0QlhSJBvhEOO3eVIm42SMMPaev9C8iOxful2WgIQvMULQJ3ccHA2YeKELw+BedK/8VrsBciv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjL3MV3i177oj7fGISgg/5caSljMz4AaFdf2M/L8OpI=;
 b=vEMTzmI/SMFx2KCaobYNuhr2EA/zxPB9emSrs/kgvjbz2sh4kgbZv1Bl+m9gOEGFQfLBH4ENpP+H/fX3b1oTxA69/X03rreqbAuvYIX3DpBxjCdfkYW3U42KqVpMOnRuYfw5Vw1DMlxaar+AxSMkoB2W8uGVHMPvPpFMwhsvKB0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 21:35:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Tue, 14 Dec 2021
 21:35:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: restore SMU version print statement for dGPUs
Thread-Topic: [PATCH] drm/amd/pm: restore SMU version print statement for dGPUs
Thread-Index: AQHX8THapfmrW6SV0UyZQ0pwz5csnKwygoKo
Date: Tue, 14 Dec 2021 21:35:25 +0000
Message-ID: <BL1PR12MB51442BD84B4709CBC7DE5051F7759@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211214213024.17116-1-mario.limonciello@amd.com>
In-Reply-To: <20211214213024.17116-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T21:35:24.900Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 076b8f2d-2ad3-0a06-abc9-419a1a4b209e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccda2852-dcab-4b9c-b0e3-08d9bf49a411
x-ms-traffictypediagnostic: BL1PR12MB5110:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51107628C79B3CB61125896EF7759@BL1PR12MB5110.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnPbrfbjAvb4cNzvEXDe2d8vUR0HDDuHbCuuPXveJzMSNNTTBnsUgDyHIWMomZqerdRfoaFxQNDaQBLufSF0p8HKStdVFH9nQ84r7lnPr+bR/M7d45E4lQeOijlum2zlDCYMjOeGMT2edffzB+ISjW2T42yqkOgO75qX+lZiHX2ThpLFZoTeCg2IOw8Pr4uysnINWqo2IhZFSeqfkMCS2LG87QzIUu4+XOBDY09X1cYXgVcrS/fcI3sBh4D+E+WqETOlrSXVRYkzyZLAswQnOAfsBq5iBZ0fYUolqkQ1tebrO96hohhfDBpaMciQuAxB9bRvEoarqQ8Ilqtk6oB10QmGZrGtg9tMEAYpLAZ5Oiljwlw57frj9LmTTulAJm5AdPRYA2jsgGdgR4g3K1MOnolJgdOYmtWo+qDKYOk88m9N+PNV/HxggoEVznR6XeSkt2wmApPfY/tIPPB30YXpVdUCEUARHzHD3gDw4D2MajF3KEUmLrAmBpFe0A47tGrROTcyxCtF2R7A1NbNBFuqzHIhpxRWX3RcKfsIQkZNJbAWlruxv66NLSFIp0EMOuL7pVI+YtemmRbZJMSz0Js/87ivMbZZWnoHjC2zqC6Oh3oP0PnUH22RgN7N4fBMKQloFMPt6nRau0e9W8MrLhdmYJCNIuEzwclzF1rvSBUd5Yo8la23VnxHe5GqygEJwiFkZLy0vqOuXsIQ13oMxPQphw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(122000001)(52536014)(6506007)(33656002)(66476007)(86362001)(53546011)(71200400001)(38070700005)(4326008)(66556008)(5660300002)(110136005)(19627405001)(66446008)(66946007)(83380400001)(508600001)(55016003)(8936002)(76116006)(9686003)(38100700002)(2906002)(8676002)(26005)(186003)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yPxBhtryPmDkzwWfXg34gX7CgPd+ItjE06/OmG+PoZr8WhBpzKXE/WTGNl0I?=
 =?us-ascii?Q?UrX3WKa+Vumw1A+0Gl+QmcyBKJYJYJIK98WzYKfz/gCHAaTFHWsN4xcukwQ1?=
 =?us-ascii?Q?Sa2l1kGS8odh6e9X5llsxcw2iaO13Qyw//2JCeX1KF/pHPIAXdQmHj0cf53R?=
 =?us-ascii?Q?H2P2V61OsbCI+yx6xrUwwt5ZW8Yih5iI0yJCZsVnR3Ndns9JBgUdocnM9O6b?=
 =?us-ascii?Q?BYpJU7CsqlsYtWEV+6n4cnAKmTrfkjBH63dMzu8ovpOZEZu+3Vx8jG3s3QRv?=
 =?us-ascii?Q?wPeAnDDSCsNrh7uCpHbooTPO+dEcEBKPh7ZWMWkc+MBP22YVwol/GyuKrGAj?=
 =?us-ascii?Q?iEol4U1MJN8JBFAuHl7pt2boq6hLYvZZnYf6x6FqHCdmAQb3TnViQcorOD/b?=
 =?us-ascii?Q?OecCdPbXdvuhSyRdLp53HpmsNRFiYufFo+AzHQtNMKGhc0hWEnLYGv4tnONe?=
 =?us-ascii?Q?ysl2OXScQHdserU05POZhG3jVtY8Pg8rAeT0sjK4wuln8NXRTBqFknGHvPDe?=
 =?us-ascii?Q?BOCD7YLl0y6BRkCZ1HBXo/BnOoLn4jCwBoRZyTK1PNV8/5TQoscsA6iOXh7X?=
 =?us-ascii?Q?pkOIRjC1YJb5AMpjg6PU2zFNb/8kywuDqNeULS1/rfwHy0juPhWp/nph/EF3?=
 =?us-ascii?Q?nnxpB1GC3NEqwuehfwEGVHSIairTbeLOd2zCHAe219KnrmfHM/PeqfYqoXes?=
 =?us-ascii?Q?2RZR/x0xt2ng0jc/5lcMizJ9LtcDvgsPvsB6Wb9Ftonza3dFB6qgFRSgnxMH?=
 =?us-ascii?Q?6AcygHl+adk+5hRmnltSYKVHo60+YPS/xLSfms71mlbVP4tVHToVvWidPC2m?=
 =?us-ascii?Q?ylFlfpXDWssTSvFbvFXNg2eiI+vdN5tG4XNIgDt10VL/7ianiL92MQPGTv3b?=
 =?us-ascii?Q?Nu9LvBBjwB57tTe7Les6cSoKQSOKDMXvIGlkDNgaRnvN9xIl2etbmM+ol+rV?=
 =?us-ascii?Q?hG4ufQlG40ZSs0D+AEymP1ZX7SbQUvCnGSDDEmQYXJULIhz3gjC6CwsSW6Dn?=
 =?us-ascii?Q?8bNDvAMPOYkWStW+ogdK2uqrhz3N+Nt0U8/ebp7qaevF9sXcDmGDCUSQ+JRq?=
 =?us-ascii?Q?mCPP1vouJLB6nylsIIGBEijxJ3xOv/QkI0s14jAJY7HFWzg0jS1glOnt4qv1?=
 =?us-ascii?Q?nUtWecoV6IWQFCgAQpPtNEXQgDVhw9pJ/GRyVTAccHGbzSIx1wsMcQkBdPwq?=
 =?us-ascii?Q?4D16/RvasUforC6ph5K/qrysqM88kuA4b8Lxf91WNgpUnHHhT9Zhsa5w+1II?=
 =?us-ascii?Q?ILDI9EJr9qqUqwLhIFQ933L/9z9TPuipQGsjF+33KKMf7FZYG1pmsZ8CzhiE?=
 =?us-ascii?Q?v5vRCQchMi1PuPmmOVTGpg75sbd92EIhYav2FqS2SZqmRuIsrz0SQsGoNCHU?=
 =?us-ascii?Q?3nK/hIKVCStcEUt6gT90HpRyWbkhUKCTBUO4dONrNdX6OaAWglenTgCwqbtZ?=
 =?us-ascii?Q?vh4UXWlr704WxtkZeWY3g1uW9E3M740X083HgKGYAzNd9r2ww8hWYSbdM2zX?=
 =?us-ascii?Q?t0k0DLkSLvtGhx45wBSy3Hm3w6WJZXBpGny0roq5MfGYK/UFY2i+ujVQZ2xU?=
 =?us-ascii?Q?G2QnArRzZSqt76IxNitcuWgErsCJ8Am5eM6Sd1HhrqPdbm2R7UMK1nK98Llb?=
 =?us-ascii?Q?DY3esEYkpHNPAIVyuF5PFu4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442BD84B4709CBC7DE5051F7759BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccda2852-dcab-4b9c-b0e3-08d9bf49a411
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 21:35:25.4370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5s14PiD9LX5xDWLintCnQAS0/yAxhfOkXBn9dfQ9itA3weZO7Rk9BYwsQ7LLYUrapTBLNu8C3kWErYMl5GLUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51442BD84B4709CBC7DE5051F7759BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Tuesday, December 14, 2021 4:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>
Subject: [PATCH] drm/amd/pm: restore SMU version print statement for dGPUs

This is still needed for thoes in case the firmware fails to load
then the message is the only way to tell what firmware was on them

Suggested-by: Lijo Lazar <lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index bb3f6072ed30..b54790d3483e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -227,6 +227,11 @@ int smu_v13_0_check_fw_version(struct smu_context *smu=
)
                 break;
         }

+       /* only for dGPU w/ SMU13*/
+       if (adev->pm.fw)
+               dev_dbg(adev->dev, "smu fw reported version =3D 0x%08x (%d.=
%d.%d)\n",
+                        smu_version, smu_major, smu_minor, smu_debug);
+
         /*
          * 1. if_version mismatch is not critical as our fw is designed
          * to be backward compatible.
--
2.25.1


--_000_BL1PR12MB51442BD84B4709CBC7DE5051F7759BL1PR12MB5144namp_
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
<b>Sent:</b> Tuesday, December 14, 2021 4:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Limonciello, Mario &lt;M=
ario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: restore SMU version print statement for=
 dGPUs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is still needed for thoes in case the firmwar=
e fails to load<br>
then the message is the only way to tell what firmware was on them<br>
<br>
Suggested-by: Lijo Lazar &lt;lijo.Lazar@amd.com&gt;<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index bb3f6072ed30..b54790d3483e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -227,6 +227,11 @@ int smu_v13_0_check_fw_version(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only for dGPU w/ SMU13*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.fw)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;smu fw reported version =3D 0x%08x (=
%d.%d.%d)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_versio=
n, smu_major, smu_minor, smu_debug);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1. if_version mism=
atch is not critical as our fw is designed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward com=
patible.<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442BD84B4709CBC7DE5051F7759BL1PR12MB5144namp_--
