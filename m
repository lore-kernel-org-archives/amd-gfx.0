Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83133C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E00D11B233;
	Thu, 30 Jun 2022 14:07:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8F011B229
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHXgRREkvf2+1nO72DhqJumr0R60OYu+sRvdp912qgcG7unnIBflsf2zpjYnAM6VDzvVL0A9bayIL/hGPlXudPps+sS/K7KWRKpb5q0BZk+mpc34XhiDWBqCweUdQEN+Gn9dTG38KCqpUr2SgCjbnBQvY9++XYiFQJnLMQitiy1cd7OLkqiwPp9kbXnDeFIIMfiQQmdMsuwI5kqGRp0TiPUDca3nWkufYqLEf3UL5v3ewFQ5kq3dyHYSzHmiNPqfnbTQfrdAIkF+e1vjNB8bxcS3lMxk1QEGfRmfQaBRrGjRpiDkMEuAHcfR32DrInwFcuAux3rMUbHBWRlK0N2R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/0KbL4yUKkLtSsekJKeZ05wel13SctTIYcAxafbFNo=;
 b=RLFO2wrWqouF+a+klNXk+lPbpK4/Hla8QpNCo3X06RyX0SBQSwfvx7PhNxkLZvfChL7+yvf2vHPDu06JF+IzWBwDUWuxkdV2tafV+mkm6v076bpW/n0VZXorf61dMefj5qlOs9O4++mvZlkry3+oQS0OTpE247mvzG90KgKrQJqBs57QJHOYkbC6yWyZNXCeIsw5TMdn1r5W7lciBHc3n1pl5mdg7pTdO0GnlIKsTe4U4unBo3AqA4+qUqPJKpDxrk5xlTuXtPOPZ2FuEvUPfOHqhzxr0AgnjXOic+i25ccGY8kDUoZZPMl34gk/kJtFIXQf5x14WIXQS5YzFKaJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/0KbL4yUKkLtSsekJKeZ05wel13SctTIYcAxafbFNo=;
 b=v+o6bCAsRXJW0EWEg6+w9b2QZw23UE9M7Kof2ddWtX8Xy2RYj8rZqea5nJE1XlMuujSHh5ACvcMhxPUFaA9tfsi7Pfp0U6R0SdhwVuTCVyMrnl4VHFjFxFTS6rdctkYX6k8HWS1EX2v8fjB+cWmorJlUnhXyFZOmDpAvRoz0J0c=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 14:07:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 14:07:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Thread-Topic: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Thread-Index: AQHYjFshD5kX50uFMU+GyPxNd0cErq1n/LO+
Date: Thu, 30 Jun 2022 14:07:34 +0000
Message-ID: <BL1PR12MB5144380C89598EF37FBF286CF7BA9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220630082623.28276-1-evan.quan@amd.com>
In-Reply-To: <20220630082623.28276-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-30T14:07:33.778Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192af304-77d3-43db-29fb-08da5aa1e141
x-ms-traffictypediagnostic: DM5PR12MB2567:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/oRK4CJM1jGt5ZlIqu/FTM4dBcgamg0pyZuC/53RSdOKq2veYf2F2z3y44lw6bcJwI4evfERTXyYMFBSBeqfmfvCtJy3w4Qg4euob9dsfe629iLqfT4qZflMOpcnvnOXifGMVEWAux+g1t7jpnuI0pHpvlefBUvEn/p1D1dtDU7g0FKURDJeDNZjfu5o7y/J2+deBa3qrmgmQNaWuBFoqQD+xA9HMHffkoG2jgKeZChuuzl88D7IsdfCuVK3EB/Ev8GNjVsFJ2Uk4y1ipXNgrVlALZbReD0XQ+Z0cNLeIaTJZ/kaJc7VMUGwXalVwu1A55ty6/zwFOuBrlCMavE2z6DVJEOnq1KopXGZENDkXoUseDG7hVv6CfGgmk+U/jkLjbQtL7txo6q/TYmx/hvspe+TarLJA0GOHETaiO8LoiD8s2ZgnGGJ/C8KmnbVFi3L7ygF4KfP1dydRe/MXORpxOJVoe+lv++UBqgPyTvWXhkxnqPqr5vu5j6aAFL09q98xYQvymetMBZCw9XH4ty9FEobvkizQaU9jgK9qkaJ000brFHKQLizNACvRJC5RhNJ11nc+SzrVNEy3tvrRog1/JstVXDhTNOhhbBwJWjNCfeRy0O2RjfqKTXvN5Cs+70KYA/jwdihjA4kGMqwlmSgMx5mWXJQlJgvwdD0imS5O/IRAOEZw/OPDZ5bjRDShjOnmbvyDqK9VkzPtpbjKiTna4sT7WCQWjN4rVx5XH+ntG/qRrKIo2YEYaNm3TE3+1lGdfkBFraMee533NfEP2kNIBl37vrgTQH6JV8VgumTT4rrva/+z45jKV0J2TzDOILjH4XMNK2PUz3vNo9lo4gzSaRXNfgbcTqN8cUlpt+SLY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(38100700002)(110136005)(66476007)(41300700001)(54906003)(316002)(33656002)(186003)(2906002)(478600001)(19627405001)(5660300002)(53546011)(83380400001)(7696005)(6506007)(38070700005)(86362001)(66556008)(26005)(122000001)(64756008)(15650500001)(55016003)(8676002)(8936002)(52536014)(66946007)(66446008)(9686003)(4326008)(71200400001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ur1G/b8HgrnrHFhUTUeebxLxm0Tz0LmNw7aOPrRP8pI3eadUpcjN1qtTmzqz?=
 =?us-ascii?Q?2fKoUIi190zfdWL2jRFxfEfq2T7bRjQXLVYcosPHS8FzpPULvJYpNijC+Lsr?=
 =?us-ascii?Q?WhMMkZ8zLozuvXDdHyQrDLD1ODUCev/KktUV/kTwp1g8Hena/fK9/a0IiseP?=
 =?us-ascii?Q?e6wyyTdrdZT9N3bVMM5lqtn8nRpdQz4djJ4Nijr3/kd/uTUTqOIizwXB60Ob?=
 =?us-ascii?Q?pfunb+sEaMYFvkHlH3SjlV2B1W55+ivrlIZd3z6PiSdw6lV183EvXu7MteH0?=
 =?us-ascii?Q?iPrMvJ76+H0MVBTlM+K0R50tjdT2XxKEKDE7pV5fMF/t3bDRG9sMq8GvPu5R?=
 =?us-ascii?Q?j7VG8HaBKKsbjj6CvZtFTgXvzfgpm1lWqo3RmfRTtGlLFsYnaixXIzkTeqdx?=
 =?us-ascii?Q?KgsHHbXsR63qJ3TrVPsIcbAcB1HM+AznXRBju+GZu9VRpZLu55Oosrv2IVZk?=
 =?us-ascii?Q?BnPJsfNB+Cqk/vkFcGkZDgMwMpcgdsTvvyqepqf4LaMjuZPCyd2HuO0KTgpz?=
 =?us-ascii?Q?jnHXlTgZ+/JJUONy9ux5c7sN5qBTl+aL/bG/+L5X2WfC272FvjGQq6qvrR9o?=
 =?us-ascii?Q?xxac7CqlkhoSzaycmzv5O79rQ6z3WmVdZJX9bkJ8oNVetVHRIkZ3osvIpvOQ?=
 =?us-ascii?Q?2nBldt8PnXE4jXZG5GNCT8k9H2oECSeF8NAw2vsMnXBwhgrMxOwW1KvfEZcv?=
 =?us-ascii?Q?dhUVI2DKQfN7Ig1HT7Xoj/tYwoxU9iEoY8licNOPfpFEhky3glu+SDUIEzPm?=
 =?us-ascii?Q?Uj/R6OGd9NVKeO2pnXCE2E7NZ/jmNiyk8/kYOC16NYI+4dYdhxxs7TG+kU7Q?=
 =?us-ascii?Q?mX9SBkNiGoLoTnJSr4DvE8hWBI03IMxBRLP+oUjDqkLuhzIqJ46koofKXP4H?=
 =?us-ascii?Q?wY56J5wWbexIoFS0gHHuGyk1IttFCIHC/ywPtUSAEfXIpvMWuthO9Mk7lszO?=
 =?us-ascii?Q?LjsSkFd9uVOVYtLc9W3l7/V782Lnuf9X8yOEMF5piHhsWCxfj/H5tpXGL5G8?=
 =?us-ascii?Q?Uj7zZbxPQGvnJpsbPEfr8+IwDb8qkjiODchHXbWjGmDeoTJ6EUrExVXASGLQ?=
 =?us-ascii?Q?Ydna8p5exs6haFKz6qOMaIn4x/Bkm+mhIelGd1EkRS/avSr4X06fv5q8vFoA?=
 =?us-ascii?Q?jK+2XnodL0+1x9XSGSyhHinUSlcrfrbTufn+SBmpwgawwiRZqxOhSA+t25G7?=
 =?us-ascii?Q?Pqg7NRh8XnEcZ+xEMPjlA3YFy67vx9mpYjXNZ8nIwox7lvuoUBb9JPx2fYDS?=
 =?us-ascii?Q?sd5DV5VYTuK+myfYpxA7qXeV784cDBdVVJzh1buMoD9kDWjrA6IbUAoATf0C?=
 =?us-ascii?Q?Mw5vkK/PaY6etpBnW2Sspq7urhVSZZOympF2tC72nGxqS5OgQRCq8WdETTCv?=
 =?us-ascii?Q?lLlKCjH2PRBFecm9kLkruBp5Hg4YnFbnX+RQZSXc5J848JW0HJTFErrcMnnp?=
 =?us-ascii?Q?cmOQ8GUaKeAtPGa6d35EC6yxE9JsLa5DNy8CL6oQUSfuwcdNzpVDn3gowXIm?=
 =?us-ascii?Q?VFr/ELD5lwI+Vf6R5UJWj2UroizGn6n+Jy2pFPopJzme4OECw+Cn0rXZLyKn?=
 =?us-ascii?Q?Ds3T6RL7zg2BZHpYCIE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144380C89598EF37FBF286CF7BA9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192af304-77d3-43db-29fb-08da5aa1e141
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 14:07:34.1412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDRcIx/BYWZoG38u7ZPMgXMg4FdTeYu3pLYTivNOJuBhfA6UHEypLY3wFvr2X2dV+G8w9gJx4xPV6nArxVwzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144380C89598EF37FBF286CF7BA9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, June 30, 2022 4:26 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.=
com>
Subject: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header

And bump the version to 0x2A.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2b66b9a289177a979201fca2056ff11e0b81f2bb
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 6a817c7ce110..5becfc1bb2ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1041,7 +1041,8 @@ typedef struct {
   uint16_t        GfxclkFreqGfxUlv; // in MHz
   uint8_t         GfxIdlePadding2[2];

-  uint32_t        GfxoffSpare[16];
+  uint32_t        GfxOffEntryHysteresis;
+  uint32_t        GfxoffSpare[15];

   // GFX GPO
   uint32_t        GfxGpoSpare[16];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 7c0ca962cf28..3f12127f9c24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x29
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2A
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A

 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
--
2.29.0


--_000_BL1PR12MB5144380C89598EF37FBF286CF7BA9BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 30, 2022 4:26 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Gao, Likun &lt;Lik=
un.Gao@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Q=
uan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">And bump the version to 0x2A.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I2b66b9a289177a979201fca2056ff11e0b81f2bb<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 3 ++=
-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 2 +-<br>
&nbsp;2 files changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<b=
r>
index 6a817c7ce110..5becfc1bb2ec 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<br=
>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<br=
>
@@ -1041,7 +1041,8 @@ typedef struct {<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxclkFreqG=
fxUlv; // in MHz<br>
&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxIdl=
ePadding2[2];<br>
&nbsp;<br>
-&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxoffSpare[16];=
<br>
+&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxOffEntryHyste=
resis;<br>
+&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxoffSpare[15];=
<br>
&nbsp;<br>
&nbsp;&nbsp; // GFX GPO<br>
&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GfxGpoSpare=
[16];<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h<br>
index 7c0ca962cf28..3f12127f9c24 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
@@ -30,7 +30,7 @@<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_ALDE 0x08<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04<br>
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x29<br>
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2A<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A<br>
&nbsp;<br>
&nbsp;#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500&nbsp; //500ms<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144380C89598EF37FBF286CF7BA9BL1PR12MB5144namp_--
