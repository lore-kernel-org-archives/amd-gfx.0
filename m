Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073F4C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 19:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7625910E1F3;
	Tue,  2 Jan 2024 19:45:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85D710E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 19:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ5IhUf2gUBOZZQS3L/+SJ4tGcNa/wL+fTZzBXYQXhUB0pahbUEs6cOnHOpN1vn9RH2Cvy4sPCelq61yU9PEzq+uGx732ixcL76cTNxfvMJBvpMrIaaYixoq3QEqm2FiMJxDEZwVhxnL8h6NWGPAe645HWeSqbSLSobCvFJgmHsPSmlagaRHPLSPGCubDndtfwmkhM+6KkWhosmEXiYVgguVc+vxTV7UFrvvkd++d40WDYNPtRsqN78GRC7Wy3UFESYpjDFViQcQWkkUIntpk1hYgyAbDDvdccw70nlfOwxFSqTAIzi6zUzTY098IB079KJ1yK6omDdVh1SpCAsDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eOZsVGEGNEGkdz/QK6ke/yQmXesTOZ+iPG0ZGeFWZA=;
 b=L4PBjEVQV1f4b6K7H+kTF9q2hMkv2NNofotgSl9ceWvygW1POOybdKTXPL3QHrNCJjWU8ubA4ljISRb/B7DlkaNeqSAcWFT2yhibuzO6j9eKsiALmZ3/0NpRSrjIPNf82+unFde2GaRIs+ZyjmdeFmSLbJUXsTTa1YfPJxImpQ//Zd+Hbrt65+4ajKPxFctK/LBwgOQ/djRrJIVvrCiwwBQuyVMbG4nuz0FUfgnUjYP6qJjlK6tNqNUJMEmzhquR5fsC1GTUeJ5Yf+uszY0ebT6Ckn4DypmRYd03Vj2Ex3uimXoLopyuO23eqSRffmxogvkQYfiTKXxqQE1pzDrZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eOZsVGEGNEGkdz/QK6ke/yQmXesTOZ+iPG0ZGeFWZA=;
 b=1+cR63Mvpnf6S+xVpwPeRtfurGx8qaKs97gZYbizDrskdgqnPOaJ7Sv1J1a92MvWAJJCNZlXmsgMMbbvkapQhW2Kn8DqGXzhImypIYiFUpfaW3r7w8YNZsDmO2JVW2mtldo+sD1jq+nRtw67BX8z6ac+dJrP0ZraPve/YcZHr7I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:45:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:45:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Topic: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Index: AQHaPS4Ad8VKl4N0a02rlc1K6T8rMLDG7cdz
Date: Tue, 2 Jan 2024 19:45:20 +0000
Message-ID: <BL1PR12MB5144EF091E264ACF1A5F7232F761A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-5-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034341.16321-5-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T19:45:20.186Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN6PR12MB8516:EE_
x-ms-office365-filtering-correlation-id: d5670788-0193-487c-0e60-08dc0bcb5a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZVInyc0hixD0c/e2jIECEeioVHDkCH0qmO0BlJ+yPHOCUxp6/a2CPihTEBJS7pHir5ysKSqHgF41vPvwxP+auTyFoSwUgfdYbNuD0s1skLG/WGlAj/dTULOCYeJXQi69gakBCkNQnOtqp8n0mRc3EpJbiwYVkWAmnWd2f/NvEiq5RUMxAT0fYwrSiGr08QEeyb/Xk3uW7Cs/ZwCyeCYbRM/agKJO0HFM9XBxVeCetEOM7ectFzWhVArVcjHJuyJKhauE33F+mDAo4DDvSO7CENuZKdhu5lP68ucZ2C8Y5izKtHRJNvplp9MDFlG0kQsCIMQQMZuT3XqoD9Q+6ljs/8NsrHc2E1llSOsUCOeRF+WJKLTADEbluxnJnaJYQqUS4Kr++P+NnX2mIPrFuYQHC64HVT9HyvBvIGxgZZ/88RMMKwbejn6eil56ep4KCkhumXLUCtZNcvJjDSnt2Lmh++XRyRPYMimQ52Gr9THR7ZGlql8PJDXkG3MUexjQVc6NL1OUSn9QDgQoiJgYAvoD4buVZVSGji4Yd397ropLFVwe9Q8jAbhO1kCwNDxtEjLqXhkJWKcReC0tvq9XogFHRTErOBWjL0ie9qV/mBNna/gY0hbUFisbk8sa8mRnHES
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(2906002)(41300700001)(38100700002)(71200400001)(316002)(7696005)(38070700009)(8936002)(478600001)(6506007)(122000001)(33656002)(86362001)(53546011)(26005)(9686003)(83380400001)(52536014)(4326008)(8676002)(64756008)(66476007)(66446008)(66946007)(110136005)(54906003)(6636002)(66556008)(76116006)(921011)(19627405001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CnAHkI5NqZPgci6E3D05WXvdbg665YqlMwC7Ud4Qv3WQeQ64FSkr/A18DYTo?=
 =?us-ascii?Q?gmRPBZag/pzdL9ty2QvOtfLhH+x8NBPNWHcmya957m1/huqeqbfDklC/AQfg?=
 =?us-ascii?Q?9ayky76k3iFc1INH5Jlnob18FPoL9VYWd1EmcpdrVKqUR3mosvvLaihg4Chj?=
 =?us-ascii?Q?ieWRb82LITKZAABdIw1BO5kn1AY0rn2mfzEj6fv1IG1EOQYFs52+bYiqqnZl?=
 =?us-ascii?Q?vizMkFCli5FCeSG2R3BP5YXomOw6zPLsMlTCr3SP+qTyKC0QkFj7Y08juhyP?=
 =?us-ascii?Q?+16IA4F1fpUBBw27Eq3KBus1Usu4xcQt44qzyRpqDV+x0ZlSfpkHDtBpEk1A?=
 =?us-ascii?Q?U6VEk+c5VYUM/PgYDqx3DxyjLq0EUF2EEaURmoDQQMRGzRbU3zH0ljsWcm3T?=
 =?us-ascii?Q?CP1H38K1lAOJksI9zVCmrNhAxcsPkJApXcn8lkEclV0DIw03NrKz4THF8q68?=
 =?us-ascii?Q?MYYffj9bHWAf9eb2beN5NKyxy+vEUcxy2QNtoIoS/xVHFYqHvCE3p3bnGggn?=
 =?us-ascii?Q?fH9S4KdnV5s+K7p2KawWJ+xAHNC6czkAPdWb7mpbwKO8pxLC1S4rJD48xNAb?=
 =?us-ascii?Q?6mcfEA28Y8d/upP3wBa3OtlifxQayTY/mnu+PZBRlU5y33aZSQhoBvkLLvNV?=
 =?us-ascii?Q?un2hNTa1b6UtfUEjFGarYdJozduGCrX2S/XqVPUHSZKIkAVH/9qbdkgYXPfz?=
 =?us-ascii?Q?NR7pldqYEFgLXbHHxgyu7IwD4FOyiw79UdUUKd0oz7IBh4dDucu0sXX0tWI5?=
 =?us-ascii?Q?YDmygHq/C7bJqQwy9WBM+2bGRL8DLfBc9xwR7NEJ9BOnC4N4SFS60RpqyrkU?=
 =?us-ascii?Q?5d2qF/Mwv99yNTdIEELP73HKKLIa2TRgGOCl6/3dp3bMZeVfRUDoaEBe61iX?=
 =?us-ascii?Q?5LyUuxSTe8bVRGww6IdXpjrLoowy6dBJFSGDED6ya3cZxxpF+cgee9pt0nMO?=
 =?us-ascii?Q?fWsmfh+Pub4eVt56/Lig94ydlVZKlHSWBogGhHO1omip3OSK59YwcKW1L6vM?=
 =?us-ascii?Q?7m14lSS5aF2vjOzyqD83XBki+38RFh7OjYJNvSeGtLGyi18yhVhgP/GwkK2k?=
 =?us-ascii?Q?KuxQJfrGr87GjBYALdqtSnwWfBC72O1LAwNoNitrvz4a0RpRDQ+/9yDa3Z5P?=
 =?us-ascii?Q?iilkpFBk+Doa8OIHtbx5XQ2ykXN707QWZ+Nh8ksQ+b8hmhK7a9V5xbqNx7MS?=
 =?us-ascii?Q?cSbmXwfBQEMt6gvFgHpi0xXnAmbdQXzhi/H6+j9DOHn6w//vKpoS40rQxTjl?=
 =?us-ascii?Q?XAB/Ft9T+la/R3Rv2PYyMSANPywwMEp8dfr6KqQp2IzCal2AkFV2TzNF/VIK?=
 =?us-ascii?Q?Ogj5bDFXgEJCEem2xkPSOkwNezZ7XmIErajr6t2i7oWJrk2cijzoi2dEplFY?=
 =?us-ascii?Q?mTrO1yH9aifP6Xx7iLNk3O7mypOuAlg6VPVhHc4c+00na9CWEN+3qxAmEkLJ?=
 =?us-ascii?Q?p7RwEgMqbS0nlfppWQeHELjqRurpH57l2ydNC89qi+b1xPHNByMBDGCZMtTm?=
 =?us-ascii?Q?4oVjnEoGZtmCplrsMucoV68Hb5PHqUw866T1ycN21pcDQwl5jFHggFxhZR8/?=
 =?us-ascii?Q?eP7yZu/YW61l4W2BvSU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EF091E264ACF1A5F7232F761ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5670788-0193-487c-0e60-08dc0bcb5a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 19:45:20.5585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Rb79mqawSuHjqUpxH8B11DVINOG5vf3evicF84XufcdRA135IgAUdtb5mRlB4g0o0gTZW77NqADhdoP6HcAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144EF091E264ACF1A5F7232F761ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Is mmIP_DISCOVERY_VERSION at the same offset across ASIC families?

Alex

________________________________
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Monday, January 1, 2024 10:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhou1, T=
ao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Wang, Yang(Ke=
vin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Cand=
ice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed

Check and report boot status if discovery failed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..302b71e9f1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -27,6 +27,7 @@
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
+#include "amdgpu_ras.h"

 #include "soc15.h"
 #include "gfx_v9_0.h"
@@ -98,6 +99,7 @@
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);

+#define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE    0xde3
 #define mmMP0_SMN_C2PMSG_33     0x16061
 #define mmMM_INDEX              0x0
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
 out:
         kfree(adev->mman.discovery_bin);
         adev->mman.discovery_bin =3D NULL;
-
+       if ((amdgpu_discovery !=3D 2) &&
+           (RREG32(mmIP_DISCOVERY_VERSION) =3D=3D 4))
+               amdgpu_ras_query_boot_status(adev, 4);
         return r;
 }

--
2.17.1


--_000_BL1PR12MB5144EF091E264ACF1A5F7232F761ABL1PR12MB5144namp_
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
Is&nbsp;<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI We=
b (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyste=
mFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px=
; display: inline !important; color: rgb(36, 36, 36); background-color: rgb=
(255, 255, 255);" class=3D"ContentPasted0">mmIP_DISCOVERY_VERSION
 at the same offset across ASIC families?</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(36, 36, 36); background-color: rgb(255, 25=
5, 255);" class=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(36, 36, 36); background-color: rgb(255, 25=
5, 255);" class=3D"ContentPasted0">Alex</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; displa=
y: inline !important; color: rgb(36, 36, 36); background-color: rgb(255, 25=
5, 255);" class=3D"ContentPasted0"><br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hawking Zhang &lt;Haw=
king.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, January 1, 2024 10:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@a=
md.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Chai, Thomas =
&lt;YiPeng.Chai@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/5] drm/amdgpu: Query boot status if discovery fail=
ed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Check and report boot status if discovery failed.<=
br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index b8fde08aec8e..302b71e9f1e2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -27,6 +27,7 @@<br>
&nbsp;#include &quot;amdgpu_discovery.h&quot;<br>
&nbsp;#include &quot;soc15_hw_ip.h&quot;<br>
&nbsp;#include &quot;discovery.h&quot;<br>
+#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;gfx_v9_0.h&quot;<br>
@@ -98,6 +99,7 @@<br>
&nbsp;#define FIRMWARE_IP_DISCOVERY &quot;amdgpu/ip_discovery.bin&quot;<br>
&nbsp;MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);<br>
&nbsp;<br>
+#define mmIP_DISCOVERY_VERSION&nbsp; 0x16A00<br>
&nbsp;#define mmRCC_CONFIG_MEMSIZE&nbsp;&nbsp;&nbsp; 0xde3<br>
&nbsp;#define mmMP0_SMN_C2PMSG_33&nbsp;&nbsp;&nbsp;&nbsp; 0x16061<br>
&nbsp;#define mmMM_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mman.discov=
ery_bin);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.discovery_bi=
n =3D NULL;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_discovery !=3D 2) &amp;&a=
mp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (RREG32(mmIP_=
DISCOVERY_VERSION) =3D=3D 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_query_boot_status(adev, 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
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

--_000_BL1PR12MB5144EF091E264ACF1A5F7232F761ABL1PR12MB5144namp_--
