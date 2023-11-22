Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C86C61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312A610E0A0;
	Wed, 22 Nov 2023 22:45:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053C510E0A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU6fS5nLaGf/Xc+D/n03aa8kLPGU9N313vaRV1SH86T3m8v9RrnrOCnV+/0kzRMFJsp74wgmKqJ7mtDaE9BNqLi0pnQ0Bi1xeSYyotHOz22pX4hekWSGnrljq3qLjpi/hNmPbyUTjkzTICtrXVcMNqcSfGlzoGQG9cJJhDw1QBuxW8KKGNQjJUa8MMf/Og9RcGaZxsdZDZo59IyT72gZSGnZQRifVWAoWYqqB97shckFEa79kbIxlgfqiyP96rNaAfo5kINZxXnun/aLRDLtC7kZlanlBJKTaAiVJ1khqEVNKy9FfK2uGXPWL1cGCUhN9qQxlGJlnEuSvZfkT9NvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVoQX4pD1/mbckFBSvprDkDxnPtfnfZysnT2obuWrPM=;
 b=UFpWSNgbmMXaVBNkbdJWkBWg1PMEcgrM2non+SnErstSOdjzL1I2ght/NwWjg2IEalLK3vd3LZkmb3nLKYkLbYxuTOYLB4yY5LyB+V+TyY9CrmEY4iTqYk1/uH5C2GoZDlQeXsnrck9GSYrV7iNpGDNFrLrPHArsytL0F+MYSoH5O/BK37GxXpDyaQcYe0s/9i+R65xe6xavn/IEPaTGnJjvJz9qG1J2K45GtdqmyV26Ev1rWJLJ1Y/mGJ1RdwVwS9nt0fLhSvsnLmYv1LaHRFE8wew6KbrYwVe9ONBPuHfq9ntMrr8vXTKdNnytI+RdVNm5yUytnffcoczCY0skIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVoQX4pD1/mbckFBSvprDkDxnPtfnfZysnT2obuWrPM=;
 b=jo6Y3KuZTvsW/NMowXeJjrAc4MB9naLSMUkUVwMLqG3vEH3bdF//8ODCMb4nMvctGqCBeDrC4ovB3FmjvR9/ZtK8e7fOkieUiec9rRufa49zbPKCV9GNhvw3JzJBmZei3B7LbQtUBLILeveTfeuDzqAsOwUqfVoZ1ujHpUP9cVM=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:45:10 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79%6]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 22:45:09 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: fix ABM disablement
Thread-Topic: [PATCH] drm/amd/display: fix ABM disablement
Thread-Index: AQHaHZKnPtA4XVMpIkiuOXs06doMU7CG7zDM
Date: Wed, 22 Nov 2023 22:45:09 +0000
Message-ID: <CH0PR12MB5284EF0EE7874354B444BC6C8BBAA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20231122222409.53901-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231122222409.53901-1-hamza.mahfooz@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-22T22:45:08.915Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|IA1PR12MB6387:EE_
x-ms-office365-filtering-correlation-id: e1a3d480-9f10-42aa-229e-08dbebacae39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wBCd+ratI4Z/0zPEsCGv3kWL8o36pXzaUcmYWO4dBfQ9eQL/sjWPW+TF3MC5gbTsLVvpwgLruWKX7BZ7ZZtBxtayNAQB2eJNQmnm3oIeKhK/1Eq+DdKV7yaaLdDa7sO31ROekpNinpcoJC/Dmq12nilcmgtLLpbgXXsGFcCWOYgo+rw3HaMx3j3cEr8dViwmgVrer1N98Qz57X7e3pgGwSeHq4QtN5sRBPZmO2Q/5IkI+D+csamumSZ8RHyY5pmm2ZelQaoolPk+0CpCh/PKVpZsWfZQ3C/zypFRC/i4uylhbNc8GA3pG2CSQ6kHB1b8hEqJZb/seWDADu3drE5vOmIcfHTSK8Lpiv0JPoiPP2FeILf4HJ6AhHlXjvDz6A5pzQESPSInbqbFxH4P42cg4iXhj3w28MQ5ytKAAfkAh+lb4irdF4XDVUf1K0K4nxCk+mSrBoWFUU7M8oLy/SY2v11sfSaf7CIas1XkDgSKPnQ29cfXteTVxV4EJjOgO5HMh1NwagfDSSn3Ug76Lbk0iVuRQh7hwQVcJeIxyMQ7EzQ67C1JZYejKQkXh7UcmOL9W/zw99KFb/MWSXTQf/82pVIE/TfzQD1ah4OYSuH4jkF9Eii2cG271dY2K0XfQ72
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(122000001)(38100700002)(86362001)(33656002)(38070700009)(83380400001)(316002)(54906003)(8676002)(8936002)(4326008)(64756008)(110136005)(66946007)(76116006)(66556008)(66476007)(66446008)(91956017)(55016003)(41300700001)(52536014)(5660300002)(19627405001)(2906002)(53546011)(71200400001)(6506007)(7696005)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nSm2EJTdoGn65SFk+jSx9WrSIG/ehcPnsCwtYGizeq5BN97gCQd5zaNP3aYg?=
 =?us-ascii?Q?7AVnn5s5sT9aXQCn62rTrI+J5PLOUZv2Jfpm5zMnz+yqTY3iNmOAE00mhIxK?=
 =?us-ascii?Q?2WdrzaNDG9XH+yr+Rx3hCafJZ0HIYwKS6kSEfsXU+G+BTPNaX65vMRsot+iO?=
 =?us-ascii?Q?UDwvff9Aa9xFvni5kEP0NMI+++7eFddFWF/DynI8sdX2xXdoAhsqf03r1yia?=
 =?us-ascii?Q?sbIZNe1AfyAb8g0K83Fh/A3SlrtNEEoSa+tmQfV9uLYd++xoFeC/XL/ZjAL/?=
 =?us-ascii?Q?PSBinczk37bqeM6fVit2KE3Mkx+bBzMogwwuMqVp9ypyNkUJzRkHhIFcbALx?=
 =?us-ascii?Q?vOsLyJXCoEhjsDxqYVoQUgkIotUMfW9H7pZD3FXMXJdYV59zHblUdk6WMlw3?=
 =?us-ascii?Q?WP4ZK4aPRwM6tnolqXhxfFtwZBMB5jta3zPHmRFGGBAWslDPwNbjsqpuMAA2?=
 =?us-ascii?Q?u6G29CQ7dOn7d6CG6WQ6XgDyiVduMi0YmD8aq7cJ+p9GBhuqJ5otGu41C4Vc?=
 =?us-ascii?Q?LueNrLrKBWxaLUa0tYTCdJeFoBxhya8rTdEWTUut9+1jd9PCxWE78VhCp1T7?=
 =?us-ascii?Q?eDAoKIhGrRcZWHVQj5t2iSByFQebP74kEn+cplZyWkWX3oYaomjVrkGaByQ8?=
 =?us-ascii?Q?HcoWGpNWShFS7DFL15CSZ1md+IfwfPUyVJslwdvRcunz1DvRDEZFgg814/bW?=
 =?us-ascii?Q?QvYEQWEPPJivYWKAzy0Qba3KAbSmcPY9mHuWr1Lvmble8R8evLWHnIe2k5L6?=
 =?us-ascii?Q?9ZIciMGi+FKnluUw6ZeV3Y0pHM6HDm8W+5CKPGul2uemINR4bqSofaIyk7aZ?=
 =?us-ascii?Q?0OpFvwBU0Dqa9bcBj1kESjHh6Qwkeayw0sais7RfOxSZChmchwfehiVcLh13?=
 =?us-ascii?Q?2RklBVjSylSWNP9f6Ntn3cfdo3+DIqQPmU9vxSP2PDFoqbNamFJrOldQBwAj?=
 =?us-ascii?Q?XUN3KDC/p27AKnYHE1xHXm9i632cmv6v5n340Gp0l6MCYLKHFhkq/Gznqcct?=
 =?us-ascii?Q?BC9llHZY6C/Kmbd99Q25nstQ4teXY1yl4whw2A1xsH9qNbfC6GmU3B2Ap3s8?=
 =?us-ascii?Q?nw+EBr6xwmhwYU21DNxIEK8sn0c7rThyZlmImh0fuaYM63kx3QjbekGqTRPO?=
 =?us-ascii?Q?vo7z1BW+joUZtKW37CJHuRFQkeGC+xY57s1B5LG6YDK39cRr0CYK1UJziNYD?=
 =?us-ascii?Q?rWBXR+1B83Ap+GwbS2BPOr8cB6bJ2juM3p2PPlwtvOV6sxBVl7FvlOl0CIWT?=
 =?us-ascii?Q?yRRrer/i79FTEavqWG/uHnVT7mf4Phq0qedTPkYcJmDte3W0J3FywIjNgNj1?=
 =?us-ascii?Q?7h8DNr/9mqIcRbLJvBLslw1uwqLCtJ2xbfau6Z7ZtCA8OCiTPEegyNdC5PdE?=
 =?us-ascii?Q?DmHacv78x4pFeLgF1skC27zaMta3H3Z9BCeXRa8pXPXDGYd6ve4xQZZuSocm?=
 =?us-ascii?Q?ZRtp1yr4q16f6oXbvwiAykhIXXNLdFZcvuShEE1r9ukZuaWQvsjAHBE/SJYY?=
 =?us-ascii?Q?NuiJD9zUNCgMxx0tQKvXhnr7LhR2B8wMOWm4iRdZ3UOBJGNkKZJBaUJ/QQB5?=
 =?us-ascii?Q?B6+AUBL3J1Ddm/FTeaY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284EF0EE7874354B444BC6C8BBAACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a3d480-9f10-42aa-229e-08dbebacae39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 22:45:09.2451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQXrseKkpkjVyt2p1zeKBscdvMZWR7HcesN0+O7OilcFHSBdJ264QS21dVCCD2TwEc23WVSOQKnvd9daUFXuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284EF0EE7874354B444BC6C8BBAACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Does amdgpu_dm_connector_funcs_reset() get called on wakeup from suspend ? =
 Users would want the system to have the same brightness level before suspe=
nding.


--

Regards,
Jay
________________________________
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Wednesday, November 22, 2023 5:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabi=
ndo <Aurabindo.Pillai@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Lin, Wayn=
e <Wayne.Lin@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: fix ABM disablement

On recent versions of DMUB firmware, if we want to completely disable
ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
level to DMUB. Otherwise, LCD eDP displays are unable to reach their
maximum brightness levels. So, to fix this whenever the user requests an
ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
to 0 when a user tries to read the requested ABM level.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d9496db0ecb..8cb92d941cd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct dr=
m_connector *connector,
                 dm_new_state->underscan_enable =3D val;
                 ret =3D 0;
         } else if (property =3D=3D adev->mode_info.abm_level_property) {
-               dm_new_state->abm_level =3D val;
+               dm_new_state->abm_level =3D val ?: ABM_LEVEL_IMMEDIATE_DISA=
BLE;
                 ret =3D 0;
         }

@@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct dr=
m_connector *connector,
                 *val =3D dm_state->underscan_enable;
                 ret =3D 0;
         } else if (property =3D=3D adev->mode_info.abm_level_property) {
-               *val =3D dm_state->abm_level;
+               *val =3D (dm_state->abm_level !=3D ABM_LEVEL_IMMEDIATE_DISA=
BLE) ?
+                       dm_state->abm_level : 0;
                 ret =3D 0;
         }

@@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_conne=
ctor *connector)
                 state->pbn =3D 0;

                 if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eD=
P)
-                       state->abm_level =3D amdgpu_dm_abm_level;
+                       state->abm_level =3D amdgpu_dm_abm_level ?:
+                               ABM_LEVEL_IMMEDIATE_DISABLE;

                 __drm_atomic_helper_connector_reset(connector, &state->bas=
e);
         }
--
2.42.1


--_000_CH0PR12MB5284EF0EE7874354B444BC6C8BBAACH0PR12MB5284namp_
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
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Does
</span><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontS=
ervice, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0=
);">amdgpu_dm_connector_funcs_reset</span><span style=3D"font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">()
 get called on wakeup from suspend ?&nbsp; Users would want the system to h=
ave the same brightness level before suspending.<br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mahfooz, Hamza &lt;Ha=
mza.Mahfooz@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 22, 2023 5:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.c=
om&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Hung, Alex &lt;=
Alex.Hung@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;;
 Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&g=
t;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: fix ABM disablement</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On recent versions of DMUB firmware, if we want to=
 completely disable<br>
ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM<br>
level to DMUB. Otherwise, LCD eDP displays are unable to reach their<br>
maximum brightness levels. So, to fix this whenever the user requests an<br=
>
ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,<br>
to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE<br=
>
to 0 when a user tries to read the requested ABM level.<br>
<br>
Signed-off-by: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---<br>
&nbsp;1 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 5d9496db0ecb..8cb92d941cd9 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct dr=
m_connector *connector,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_new_state-&gt;underscan_enable =3D val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (property =3D=3D=
 adev-&gt;mode_info.abm_level_property) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm_new_state-&gt;abm_level =3D val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm_new_state-&gt;abm_level =3D val ?: ABM_LEVEL_IMMEDIATE_DISABL=
E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct dr=
m_connector *connector,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *val =3D dm_state-&gt;underscan_enable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (property =3D=3D=
 adev-&gt;mode_info.abm_level_property) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *val =3D dm_state-&gt;abm_level;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *val =3D (dm_state-&gt;abm_level !=3D ABM_LEVEL_IMMEDIATE_DISABL=
E) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_state-&gt;abm=
_level : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_conne=
ctor *connector)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; state-&gt;pbn =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (connector-&gt;connector_type =3D=3D DRM_MODE_CONN=
ECTOR_eDP)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;abm_le=
vel =3D amdgpu_dm_abm_level;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;abm_le=
vel =3D amdgpu_dm_abm_level ?:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ABM_LEVEL_IMMEDIATE_DISABLE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __drm_atomic_helper_connector_reset(connector, &amp;s=
tate-&gt;base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.42.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284EF0EE7874354B444BC6C8BBAACH0PR12MB5284namp_--
