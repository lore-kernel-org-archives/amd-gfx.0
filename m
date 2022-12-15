Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 14:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8864910E0AE;
	Thu, 15 Dec 2022 14:19:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD5810E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 14:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz1SVA6SlcshPryBT3R/cmooS49rWhT8umsZq0jt537+TqAEsjjlOZegeLV/QMuU48El6hxccBYJMO6oDYj4ZfRZRx5kCAlMa9uIO2gThnIiAAJW69snoU5HP+GdvxhOmDenxtpiTwofV7WiKAwjR9+PTg1Q/wqOJD4zSppcsZV6x5P2azntCuSxTowgYL2ctyhmGNtw5m7IBsYDzvpfzHG7ONdUy3/xdH4e8rNMcVwlmWipr6K/ZqeEH6zBJkNpGC5+L1/yzuhuWgH+eMlCnEXXs4gVZYXUgn8xl7QB+LeVCO/xvRXkHJmBuGM1B9tNgQvin+hn+M5PDHjIK/zjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ud+NPtVDMCYKIwbd0bskcP/GQ8h6Cvop7Br5i8LfbQ=;
 b=T5fvN9oqJSSRb9IpwkNsSBKtkjMmMVn7egN2S9fH6aaYQF6MLVMWDpmg6G+JuMLOJnwil9+pIhnmnTklnKaHYTyd3CKg1RiRknjfYUb4N/M2yZwgwXYVCOltDpQu4iCuTbDuGD/pCxZf6aLeaYgLNUUo+8Z65K+O1ezKZ0JANJQT7s4wLWw21gtpHr3EfA3byb4keNUzsxUHWHAL7k6BsungFY7rFP57fvWA/4ssBPA/FBz2G9UAgtKcX2QP+VJG9KRh3NCz5SUBMKfGzriftDiwOr4RloqKVD2SzGWNnR21Ks6DdgQRRSzK14z698EkcjoXR4qqWw6u1Q5j3KDoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ud+NPtVDMCYKIwbd0bskcP/GQ8h6Cvop7Br5i8LfbQ=;
 b=SbXJsG+/QXGem9JXxdTOujSIF4B2zMDBU9edXxGSedljvDh0cYTxipKP+DahLUP9y3Ix4gcd0x73+0Ni33sJiWGyk/IkRayYEalWqhosuFcwWdMktTDAfTRcoJAipIHvL2FtcLhYleQmxpPbNyeF8LpWlDEH2G/hP1w4Qh1UXqg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.12; Thu, 15 Dec 2022 14:19:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::35aa:857a:d89d:c06a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::35aa:857a:d89d:c06a%9]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 14:19:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: bump SMU13.0.0 driver_if header to
 version 0x34
Thread-Topic: [PATCH 2/2] drm/amd/pm: bump SMU13.0.0 driver_if header to
 version 0x34
Thread-Index: AQHZEEzs7W+vM5T9H0Sn/8FgHbxaRa5u/952
Date: Thu, 15 Dec 2022 14:19:46 +0000
Message-ID: <BL1PR12MB5144042E7D3AE1853EFE31E7F7E19@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221215061658.3894208-1-evan.quan@amd.com>
 <20221215061658.3894208-2-evan.quan@amd.com>
In-Reply-To: <20221215061658.3894208-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-15T14:19:45.779Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB5936:EE_
x-ms-office365-filtering-correlation-id: d7cc3635-8dba-4f11-4f14-08dadea76b18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EydWPGUDj60QvKpIV3DnyqD/3PiK68CYdg44uzvjAJ1srZjaAep0pCKHccV5m7Wi7hzwRCwt6c2mF+Bh/hmm3rUDoD5di3h8rNMwYdlEajsSpGEr12nlDcnPQNq/xqtRzDjmDhbqFHiDQwkoEGkEtDYeZsrd7PpiuYcsl3TBWNvP/FCs4Rue3qlUjmbqC8uw4NS0W7IHFFUvnDKW4kEYD7io1KdMzuL2+jx2YYqCQsw0IFhasWyoe4RIxSqG4P/x/0hvAm9mLne/lA9nPruOyC5/lX+gfzOobux9iB8dMOWdbw9EDsEuLEsmTjYXuhzlHVAKZgAN4x5h2v3UtvlYZ+bUh00gg/a37wuf7wQyvR8bBXHy214In49uMmYpgESjU/Q2J4UKKYNw2KrkExv79P0mWccsAwN3fatIADRxPuJPYo1AkZZ055xn+8YE0SAZ+4GT2cWmXOd0HzvCOFbTaNY8iefJwWtPtvqJk7kxYRUMzSF2q70LxiyUA1o45aCbXxn4FmKsuooo9Z+PPZJEY1dNdI9KCY8kj2dnTbTwHyxynKb95hc7HHJuSEXWtj3ns9LZkdfL0Cuw3n5CV8RXo+P1jkik1exIWD9Ij6mcF9tc8wHtLg54XucXpO+2u9AMYCgAr3Jw47O8hHL190BVkxMqmWumB4WZldgs8wDSfgFrhc3uEc0UmnHvKUZ512pfD/R4v+HioxJ2Tq6/djeGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(66946007)(76116006)(64756008)(66476007)(19627405001)(66556008)(66446008)(33656002)(86362001)(110136005)(83380400001)(2906002)(38070700005)(52536014)(5660300002)(8936002)(41300700001)(122000001)(55016003)(38100700002)(8676002)(316002)(71200400001)(478600001)(6506007)(186003)(53546011)(7696005)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3LT9rL8FOMUQxn1rGUzzf/Dba0wm3055VGVGiiGHkxw4V40dLhq+Z0cQSwgO?=
 =?us-ascii?Q?v7XK2kzGocrd9ooCxfV/1pL+aGgsdPp8ZBH28DpLBYatQzLXgoxe5vSx7Pvv?=
 =?us-ascii?Q?TM5qkFgQKiVy0tP9ghfwlLchX1KDAeVQHgxD/k7zioBRn9f92VXsPlpRZyhv?=
 =?us-ascii?Q?D0JF3RKQDxsJUztOhTW61UUgI+iCpGe6+HQDMjz6OLNOUJoyTFneLN9Z4nFE?=
 =?us-ascii?Q?8uwNSXOFXBwwvCzD97lsfuU8YFGxfAKsClaAS6rINE6LQZmZjC3TaW4CNj2n?=
 =?us-ascii?Q?sF2D4NHu4d79syFBiY9bnYAZyQECGa4JhbWW36UsdubBvEmF7kA2YjVnF5EP?=
 =?us-ascii?Q?YwtY5GdQfpE5eL5H0Xx42Y5H8ukv3KJ/TuJRgsd6BjBdbiIhiuolf+JsD64j?=
 =?us-ascii?Q?/D/JKVyq4VXyCxS6c5rjM4dkynwAAtZztIZE3w0ghaMAppwnTVdIU7whPwY4?=
 =?us-ascii?Q?V1JNCo/kZtE6vHZ9lbjfX/p1NYgUpohcrT3KvZGOoa1gSk1nWcv/pFJljE3N?=
 =?us-ascii?Q?BiTLDj90wrPVFSNTmk0zOBOy7WDri1YKAJ/yGUWb59Zfiv3aTmMyADWOA8th?=
 =?us-ascii?Q?fm6Sm+VQhUqQnGjNt39mUUh8toC2plsmwTrhdB2Ph06RatuQYXCQ/8m4y7Pi?=
 =?us-ascii?Q?imueLAK2ft53kALdATGLZ14uRCFSYGEFICyFeXdyvr6T1s0Cv9V475vcgOCc?=
 =?us-ascii?Q?ZIEniFDSj0I9H30FpesqTm7W1cARiUNC2SP5a6acqCWtabo0ogNM+8X7CIV7?=
 =?us-ascii?Q?irtRjvTO/Ajn8EqGkfpSR8lQjy5RyC03Cs3P01lDO/etK5Qy9bUlRX0CK+Ti?=
 =?us-ascii?Q?GMfWrSafMa1rykBaOzaWzIsAf7oQdCdhIJaVT6GCk29bCPkwpqiQFnEPoy6d?=
 =?us-ascii?Q?so/CFMJozN64H6GUpfqEfhCCB8iAwHpHZXpCy+bmUe3SMAi+zpmp/a0wVWfR?=
 =?us-ascii?Q?CBIecmNVkBE1emSxVXzw7mQ8r9J5R4q6H7IAqbOJcWJqjELKfxzoxe8BMEfr?=
 =?us-ascii?Q?O+BBJYz1gDjqJdVTJkEFBI+2Zf+MN9VG5hfTDEI9UdOEVUdlahgkpe+CD7kw?=
 =?us-ascii?Q?DP4ng3xe6VIZnoIvIKlczYwhDpt5ePFbArqfoFJmXwdpyhT47KGMqljHMoGL?=
 =?us-ascii?Q?VP90nepRktpNsqUNTcnbrH19wOplMsxRlpJmGg+fnqYH1iMSMXqbtkSp2efC?=
 =?us-ascii?Q?LqRRsX5Cgq7P9jUQzyWpLwV8FsUSXvrU3etnY6YGoHHbsmX1w7HguL7/JelD?=
 =?us-ascii?Q?of3XpMw+eGL4ryh4/Qb6tKBbFB3nsAwOU7QxDOkkHDo6Xmwxjwg4ZVk/OAhl?=
 =?us-ascii?Q?EEPowHdCpwVo+pzzrmlFNukGPIHwVLDZp55k6Izly9H1xNZ5XOvI5i91GZNk?=
 =?us-ascii?Q?x1QaSCQMjfGmDL6AoW6sjlQ4JgGZylVWUshIBsFAl4zotApw96LB3XOcVTme?=
 =?us-ascii?Q?TpQXS7xYRZKPLqF1KIBp9pRzl7oRYms4Ys128zB634nepSPXhLhFsjqEpDPK?=
 =?us-ascii?Q?2jQaRPtqKDUPNQellogT35LhkHDcP8Etk3OEIf/OtUnmP9Wr/R3boz0g8riM?=
 =?us-ascii?Q?XPKzZt08S/kJ4S6QzJo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144042E7D3AE1853EFE31E7F7E19BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cc3635-8dba-4f11-4f14-08dadea76b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 14:19:46.3850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAY1oHttv5FXIMn3OBv/1xhccOsQBSq5NQpID0E7MgsX/OExrZBJk6wkuhttkY8QvX6CF8v5dIJ8kaKijqT+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

--_000_BL1PR12MB5144042E7D3AE1853EFE31E7F7E19BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, December 15, 2022 1:16 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 2/2] drm/amd/pm: bump SMU13.0.0 driver_if header to version=
 0x34

To fit the latest PMFW and suppress the warning emerged on driver loading.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia81ffdc8969a3b667454aa35c6d05d9de238ebcd
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                    | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b76f0f7e4299..d6b964cf73bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -522,9 +522,9 @@ typedef enum  {
   TEMP_HOTSPOT_M,
   TEMP_MEM,
   TEMP_VR_GFX,
+  TEMP_VR_SOC,
   TEMP_VR_MEM0,
   TEMP_VR_MEM1,
-  TEMP_VR_SOC,
   TEMP_VR_U,
   TEMP_LIQUID0,
   TEMP_LIQUID1,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 8d4ab1da17e9..913d3a8d7e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,6 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x34
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4db5f2630054..0ac9cac805f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -290,6 +290,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
                 smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_ALD=
E;
                 break;
         case IP_VERSION(13, 0, 0):
+               smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_SMU_=
V13_0_0_0;
+               break;
         case IP_VERSION(13, 0, 10):
                 smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_SMU=
_V13_0_0_10;
                 break;
--
2.34.1


--_000_BL1PR12MB5144042E7D3AE1853EFE31E7F7E19BL1PR12MB5144namp_
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
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Series is:</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Acked-by: Alex Deucher &lt=
;alexander.deucher@amd.com&gt;<br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 15, 2022 1:16 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: bump SMU13.0.0 driver_if header to =
version 0x34</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To fit the latest PMFW and suppress the warning em=
erged on driver loading.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: Ia81ffdc8969a3b667454aa35c6d05d9de238ebcd<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h&nbsp; =
| 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 2 ++<br>
&nbsp;3 files changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<b=
r>
index b76f0f7e4299..d6b964cf73bd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<br=
>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h<br=
>
@@ -522,9 +522,9 @@ typedef enum&nbsp; {<br>
&nbsp;&nbsp; TEMP_HOTSPOT_M,<br>
&nbsp;&nbsp; TEMP_MEM,<br>
&nbsp;&nbsp; TEMP_VR_GFX,<br>
+&nbsp; TEMP_VR_SOC,<br>
&nbsp;&nbsp; TEMP_VR_MEM0,<br>
&nbsp;&nbsp; TEMP_VR_MEM1,<br>
-&nbsp; TEMP_VR_SOC,<br>
&nbsp;&nbsp; TEMP_VR_U,<br>
&nbsp;&nbsp; TEMP_LIQUID0,<br>
&nbsp;&nbsp; TEMP_LIQUID1,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h<br>
index 8d4ab1da17e9..913d3a8d7e2f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
@@ -28,6 +28,7 @@<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_ALDE 0x08<br>
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x34<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 4db5f2630054..0ac9cac805f9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -290,6 +290,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VER=
SION_ALDE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_SMU_V1=
3_0_0_0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VER=
SION_SMU_V13_0_0_10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144042E7D3AE1853EFE31E7F7E19BL1PR12MB5144namp_--
