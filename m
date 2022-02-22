Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129A9C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F3C10E544;
	Tue, 22 Feb 2022 13:54:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250CD10E604
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgE66ct9NqP/DHf5yldfJaJEXXUfgJKED/dxh7zPSJo/E9H3pw/JWUumOG0hUrIz7sF6ZT/bzQhJ0Dn4lUuP3pjnha1mB16cS1lrSNvLZ8m3Kt7V9wa8EhtUyNFdmbdYHWPjUBs/VZJWdAKy+R69ZUkUPBF+MvZ734QSVx8vOgu5quLPDZuoRC+c6RuPmWlYEQLYAp6qgIAB3QcB2b+TgqDvnHr+qdlFvNxd5Q7fRhYYj1J08aWM7pol6wIVAn3do2ELlhxxmXACVBBCFjAWfeL40CPq6XDgF7XHD5oJdUze4DTOO7mr7hImGmWQ66gYdfaXnrsdAKTIR4IrgXPv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KajEfGrpGeMTeIjf+FjIkmaE/SooLMRo34x2EUvclz4=;
 b=kaIzWnnXS9WjHNv5Ug6LzHWs3nqyYycSbfmd9f8Y25YM+7gkU88xGDuBwLv3w2PGngzVE5EEWPSlDeSCdRY0wbT+3tBOy5H/cCJDBHZjvf2fezfxbf9CDavVvy7Jtg88pCoqDEFcT5116KBNDoKUrnjKxWlSHCanYqLxO2UUropampWtn6uZgfuv3jjhrIBpxglEFNm+XPW0o5c0sICTojnTlTsKw/bC/YiaCjPPvhiyVbVcHHXqQB10nRJMub94oE4D+5qDG53aSO5zkstfDRGneSPVvJxecW571CK8lUyM9NePNdXHSoXkh8WnQ4O6dHdig57XIQBaVNEfk11BxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KajEfGrpGeMTeIjf+FjIkmaE/SooLMRo34x2EUvclz4=;
 b=fUTIDbzubSemVR/eq1rfalZ2gC0DT/P/UHzIy+ISELtwiMrujh5Jb9SvaGoeunD2DL+SbzgS/pb14HhQ+dfrhRDYvLYQasB0ygEDrd6yiM1VyhHwMz8ht5f4BAnkqfBMoo6UK8fW/NNGhfbtJaoq3eUdTtojkUz5TVaBAeMWZAQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 13:54:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 13:54:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to
 fix applications running across multiple GPU config hang.
Thread-Topic: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK
 to fix applications running across multiple GPU config hang.
Thread-Index: AQHYJ3ej16uTKbhBaUSvOgBQuckBHKyfmFCy
Date: Tue, 22 Feb 2022 13:54:41 +0000
Message-ID: <BL1PR12MB5144EC79690EEC4A9CF258C5F73B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220221230531.1246382-1-xiaogang.chen@amd.com>
In-Reply-To: <20220221230531.1246382-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-22T13:54:40.650Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 2868bd04-d088-9eb2-cf66-be043d0df858
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1deae6e-76f7-4d91-6bbe-08d9f60adfaf
x-ms-traffictypediagnostic: DS7PR12MB5813:EE_
x-microsoft-antispam-prvs: <DS7PR12MB5813B7DB5E78857A76244CD6F73B9@DS7PR12MB5813.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oktFYk/fTyTsfZ8bJZ9PABAAQBUKeOwMjxy1iRQ4dWpqpOUPEhsOw9di08A0Lay7jxxWV0zmYMOE2DaAn/HtNohqNDz0M7cYmmrEanSmWp50gIWuYjWVL56aKtPDIg+KiOzPh9C5lEzvwnQpj436tnPppcAdZT4mMkhOAAs5nTBLNWY6f2XLbNl1G4JexAVb0bVTh6sB3/JK2J0zLpMAOxpJTOTWxGlrQkbCOrGsa/TuTbRabtXjCK9pGUmLP65E/SMCADMWo1uZUDL4nL3HAKe1f0MwR260E4ucpCgmEovRpuZAMamrSij8hfgNna7DJLNH6RpguK3GYH4f7nu+1m/hqrlcJKAyXYZxHUo6VWsTFIvUUN/vhMIeehY+XarjoArEpwPRZ27ywN1IRU/Nip5gKLn+qx6dMAuAYzjPeUm2Fdg+b4tmTVGujC5RRu08AFUUY7Cd0Ln/uC0lHLjfuizE01ITe76e0RgOvNST18seEXAUamc+iV8Og9O3/ZhHSYOernL/5mC+foAGpS2PnPnuetLm+a9pTNjETWR9qyAp3Hc5EQtUEz0p2UgRAnE5k00xDT3vsESz7av9tHo9hn/1vw68VoPWzTlDjISnbuZUjE4+0K3Gx+aGKEl6OmeUwuda3iVhj8X3znKwsp3wxU480PT+izKzpRQB6nDWnoKruXrsVb3nxdMu/gv7pSmDtZ5lnJYwUn+KCHV6/nAk2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(2906002)(8936002)(7696005)(6506007)(5660300002)(38100700002)(122000001)(508600001)(33656002)(55016003)(26005)(52536014)(71200400001)(53546011)(186003)(19627405001)(83380400001)(76116006)(316002)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQMnWEWiXthPgNrF63/iHOKdPlU+iKXdON67FHNGdkjfMRsLcFQSR5xtxX6w?=
 =?us-ascii?Q?yl3CiAFfwR7GrvpcrQHwrEiszTqMQRs9HrjGAffDvUnfK8k15fk7EAbCfjY9?=
 =?us-ascii?Q?7a7ek+3m9d227Fn+w1pBgsDcKoxqj0tsLI2I9z//rKfmaxDvW28iB1OKFV7F?=
 =?us-ascii?Q?/A7XNBQPipaOf7HzI6lMdTvydK5msoZR60J8lDW+rZ7LTmkTyQMrYJkegK8N?=
 =?us-ascii?Q?ApLJtJL4w0OXaCt52P3S/4bC2HZkxtN/s5CdcIYsgKkMeDZgXrQ6KQwhACBA?=
 =?us-ascii?Q?qDPoMXEpRsWyR3LMhMQPvX3MnuCpplx59tSUXQWzkXIrgrmEWBqZ2gr4sa/g?=
 =?us-ascii?Q?kbMq1WsW5/BheeTvs3qjUAQrEYRooKtn8QqwdnMOxtt8sdBFkMJQbAB0w3W4?=
 =?us-ascii?Q?fF7bABSsCm/EVbH+w/jSEEN7aKIwbueiDVkQ5eSUyC31VvBcmpHz4h/8u5U1?=
 =?us-ascii?Q?vRB8dk3Qy+ZD6T0hMmZ2k849OFyaMY/Vviqemfm+6kcG4bWVZNbBioMbZKRj?=
 =?us-ascii?Q?goVg1E6xuyiSd1KVfoXlaq8tGbLmlhlFbf59bmHZqeL+mDOAkW0WwRQtXS+v?=
 =?us-ascii?Q?FvKe2Jpdl4EChef3ep6DLdhhJTVlzUgTekvhvjLoF77x01NjGAMoAJ6cpX2V?=
 =?us-ascii?Q?VzeYCfcoYgCGmE0fyFMJpHhTsvoZh6dtZtNcpQPdtoKjQqlQhAM7yJ0v7mXb?=
 =?us-ascii?Q?2JXZVZTEYfwlTf44ok7xCLc7dsLRWBiB0lkU1hIypy/Q6ffyhMc879r/sfEd?=
 =?us-ascii?Q?Wb+QwgkUNikq89nTZI1mmGFA3j48/G8tjqkpq78ggz8G/je6RkUNwwFRFWOq?=
 =?us-ascii?Q?hWsObyczLiwpATd3fUTkKMhyKSetjP2g8sYVEHRXjrWsbepALjmvgNCYFPBV?=
 =?us-ascii?Q?V0xe9ch//LiS8F+SFi8v9a3xRXxbtle3FPeVNR7quQ1YbuH3HVKdcz2Fofdc?=
 =?us-ascii?Q?QNcbf8WBJi34F5zqtrFh6wYVOhWhfSuiZAZB5zGHnEt5uaYKoRDqWWnjqKP0?=
 =?us-ascii?Q?KwB4lx05AzYIfY0VJ5Eh86EuBxSSH3IUjP2X98ENF3cvR8T7hVHrcnRNXEjg?=
 =?us-ascii?Q?k6wlCRUCh3uRFLf1xVcIM1vlA9CzD+mrZqyoyL+m3ZwGsLsd8ZnpSyhp4G6o?=
 =?us-ascii?Q?pZNKG2PHArBwIqhoEvCVnL870Q1PRL1CPXKWsG35fs0fvoOi91esR+L4uyOu?=
 =?us-ascii?Q?ZXlx/geIVZojr7aghsL0GHIagk+krH0Oh2bC2CQeGblnOJZmb4UT8rDAniV0?=
 =?us-ascii?Q?vq3azReO/EW1HPxcMOhEum0tBkJbQwyicLqOJDZCtHM3Tw2nC0p9NLYHFIaM?=
 =?us-ascii?Q?vv8qI7kj42dpe8AYcCCcvk3HDwYn3Msuy9i7/ouFRaTcEzhkb6qClgqd5KwX?=
 =?us-ascii?Q?UoYWWSWA+jZeRcxg+MAVVXaTMfgL1zgImtCT4pxsDESkxa4ikjGeYisLymWl?=
 =?us-ascii?Q?5RzqqN8YiWTeSopmacZ3dH8GN0L5s3svKk3g/mRmlGf24gnFzYDDgv/w0rXz?=
 =?us-ascii?Q?VvZsclJGAUBd4RB9vWfTxHD5KlUGj2AbgwLMkKoG/VFIPuD70mhabILQnfWz?=
 =?us-ascii?Q?4V09dEssxPlB45pj66zUZFK3iKS6N6wVhejXNqMbdqts2hHktXB8nMdSwCg8?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EC79690EEC4A9CF258C5F73B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1deae6e-76f7-4d91-6bbe-08d9f60adfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:54:41.1307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4egy2YOVRuD4+3DCu5+z3Dv2msyixn8tDEhpNC9RelfV/MXKZQDg6mmZ/IoOQCWF9sPNFJOD01Okr9Hj9AT+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

--_000_BL1PR12MB5144EC79690EEC4A9CF258C5F73B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Please be sure to test this on other asics which use the HDP 4.0 code.  I d=
on't think this field exists for all of them.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaogang=
.Chen <xiaogang.chen@amd.com>
Sent: Monday, February 21, 2022 6:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to =
fix applications running across multiple GPU config hang.

From: Xiaogang Chen <xiaogang.chen@amd.com>

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                      | 1 +
 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index d7811e0327cb..aa2c7c3f721f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)
         }

         WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+       WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK, 2);

         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start =
>> 8));
         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_sta=
rt >> 40));
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
index 25e28691d62d..65c91b0102e4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
@@ -104,6 +104,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT      0x5
 #define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT    0x6
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe
 #define HDP_MISC_CNTL__FED_ENABLE__SHIFT        0x15
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT   0x17
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT      0x18
@@ -118,6 +119,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK        0x00000020=
L
 #define HDP_MISC_CNTL__MULTIPLE_READS_MASK      0x00000040L
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK   0x00000800L
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK       0x0000c000L
 #define HDP_MISC_CNTL__FED_ENABLE_MASK  0x00200000L
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK     0x00800000L
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK        0x01000000L
--
2.25.1


--_000_BL1PR12MB5144EC79690EEC4A9CF258C5F73B9BL1PR12MB5144namp_
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
Please be sure to test this on other asics which use the HDP 4.0 code.&nbsp=
; I don't think this field exists for all of them.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaogang.Chen &lt;xiaogang.ch=
en@amd.com&gt;<br>
<b>Sent:</b> Monday, February 21, 2022 6:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chen, Xiaogang &lt;Xiaogang.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERM=
ARK to fix applications running across multiple GPU config hang.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Xiaogang Chen &lt;xiaogang.chen@amd.com&gt;<=
br>
<br>
Signed-off-by: Xiaogang Chen &lt;xiaogang.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++<br>
&nbsp;2 files changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index d7811e0327cb..aa2c7c3f721f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -145,6 +145,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP=
_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL,=
 READ_BUFFER_WATERMARK, 2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE, (adev-&gt;gmc.vram_start &gt;&gt; 8));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE_HI, (adev-&gt;gmc.vram_start &gt;&gt; 40));<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
index 25e28691d62d..65c91b0102e4 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
@@ -104,6 +104,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x5<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT&nbsp;&nbsp;&nbsp; 0x6<br=
>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x15<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT&nbsp;&nbsp; 0x1=
7<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x18<br>
@@ -118,6 +119,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000020L<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00000040L<br>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK&nbsp;&nbsp; 0x0=
0000800L<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x0000c000L<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE_MASK&nbsp; 0x00200000L<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK&nbsp;&nbsp;&nbsp;=
&nbsp; 0x00800000L<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x01000000L<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144EC79690EEC4A9CF258C5F73B9BL1PR12MB5144namp_--
