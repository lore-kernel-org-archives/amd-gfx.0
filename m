Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D009C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 15:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EDB10E4CA;
	Tue, 20 Feb 2024 15:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2pD9PWE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C205710E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 15:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJY8NpWj0wpgmjHfhSbQDWlPNLcfkJyW+AikF20nQQoPBpc3Ev/rzun2vseJl2Y73DfZtF12ce8MAFr2Zd27xjZL9uj11+VvUfIzXKk1itsKZhAbt+lGD9zbeh8euMVoCxt3GR5tog0FfC8Nf69QQZRoaoZBRQkENWspW1ustXc8PEURybMb+AJLc93dk4hhhCXR6m5bfUKRg8rx7DMUcw+5caLfEKPgnVzqndcWAjHXlxPAXL+2gPHQeVqE84A1twHEFV4n841gJJq3o1SxQEeX/nnKOmyhD/9xxNl1L5KPWgmdFkPQmIGq6wxQmYOUuiKi4lqIq5CZat1XEDrCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAoGczs1uz0BfyoWQutVOv23kBO7fIIMUmEyXvrX9GA=;
 b=IbO8Fzvk4Hi2vljmO3XhEEAHU3mHwaCMkUK9/KYGUMb/3RkCXXeJkri8UjrlFmh0sqc9AClTdJzpK+ahqiYQItZ+cYLvTY3Wg5c92J4vPTZgelGPS/v7Up/iCGh9tIM1rZURHKHnISmAJ9lmvdPe/zuSkguRiO+lKsWm7Uj5z7VvpJ4v3R6sOQAVbanlemHziKYLqH69cgOvx5GtklBHkIQnIJrZNBEBr9cZIp1lU1PDEyHPcIxu/ggaGaKOPC9P2SmnPtkD1OdIesgrRdmgqs8f7MzF2UACVR7ycrBaDbBT/nqfB8Aak+8tYX/jHq/oOCqcXD8Bw39C5LJsiQ9dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAoGczs1uz0BfyoWQutVOv23kBO7fIIMUmEyXvrX9GA=;
 b=E2pD9PWEuL28JC+qPwIu+2Me0PNMN4rB6GCpKqKgOI++tGLQVS1s/ykpCBS1qatrjB2IfpENpbiDyO4GnDlD8G6lxiAItnF98u1R/6/fMPtl7t5vSzLWSx472I4UCPA3WREPXVx16MxML3hB/LjeJLu+cUOj7xutF8EeBGykxFU=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 15:51:08 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::c339:e42f:5fd4:157b]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::c339:e42f:5fd4:157b%6]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 15:51:08 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chander, Vignesh" <Vignesh.Chander@amd.com>, "Lu, Victor Cheng Chi
 (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV
Thread-Topic: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV
Thread-Index: AQHaPaFqyR5U9JGI306VTzEJl3Y7SrETrb5A
Date: Tue, 20 Feb 2024 15:51:08 +0000
Message-ID: <MW5PR12MB56009126E57FC3B919B6394FE6502@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240102173013.5543-2-victorchengchi.lu@amd.com>
In-Reply-To: <20240102173013.5543-2-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae79a003-987d-4a7e-a93a-a20088256c35;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-20T15:50:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|CH0PR12MB5332:EE_
x-ms-office365-filtering-correlation-id: d87be0d1-0dfd-449c-51fd-08dc322bc0fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTz6bGp8cxPi+mif4JVpI3iwYarZHHwC1yT2W6u2e0iDUlNz/Ny4SH8bI7vvqAnKCENHR64RscA4+HPUSBF6vyVMFFoBHNJ63N+DPQezk3v7HEw2CGkQWAg6NtkZEv/hXfp3V4eoj7B59lESnGiLuywtmjtwWua2txTwmMjWIuydWGIU69xTAcib2ta8udtfglAtLSHd3vsIOVb4Zs7MomGMz5+uup1PGdxCjVrMX2Oo/3CgD4NTnYJO7Hje0yuMiEMpk25nVtnxYaduxbFhh6tphTwLyLUNcOfvi3vXhTnKtgUSyU+rw3Q38hZDYgaHz4ZFVa73x29WkjXXqu0so+QSm3asJi3Vex0nLmx/aiK8oTRyKoFcz5Uhe+yfruhlfOMBrPy78W4ek3bupPgPR5uqmUZx08YK5rLB2PbWaYREHB6i2dfhvkDxvpFo0ATBnqYfJ2bw36i3EtElAAv3Ta5Hk+odIDItyIiNyuN7jueWvL24WFxrj2FKsn56GGUHRbjTSTUZcS6zMLJGfkS9t4zYJFy/2PqiTgMHKfTz7t5FO1Sg387JanBWhVqDV3LCuRf16Fpf4XvMtGU/KZmkTnQT5smikTOPrxJwhHyFIcy/vyDPkOR1TUgKpJAt0Ti1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rmovbrYqRaOBGvhUNEpr5e6CQzkdJyHWhGCZ6utt3QmFiArDmNmUMieLKY2m?=
 =?us-ascii?Q?LLTrdvUf4cZBvBk73cGg5c6nn6P03eyPRROYs/dCE2VFug9JYqvAB5wTBIBI?=
 =?us-ascii?Q?mhRaep0F8KunccGkF4DQhk2vSUOCcCXwd8wLbrqhLmlgXGD2FnMsBndUpwWK?=
 =?us-ascii?Q?MedVIwk56gkLE0pH0yDgda78kLU9CmS0pQxv24lt5DVDD0qPHOO87v+BV65k?=
 =?us-ascii?Q?RPbsc6WmDEDUqmcI65SWBpBqPu2JLVDDaAwKyCJv70xP9JN1uQycJN4PkPhv?=
 =?us-ascii?Q?kKyxezkgHzem8DQUWleJ9pVGgHAbffnjgx9pkE1c74Zu5ZqjOHPpvhEN9J17?=
 =?us-ascii?Q?YguU6Efc/AnM1sPzM8uN3P+wxazCtp2IKKeZ2yTgy8BP3Ba97nHNXvkQWSbw?=
 =?us-ascii?Q?sHgyrlXFjP+XoPpwLHemBPTgj3izbzwbbBcAjW/+neWrymqC9RlVNaq7WHrS?=
 =?us-ascii?Q?mp6ZwNgiqwUffIS6PaQXCGZYIn3t8jqJPQh6L5+ZzhoSOWlL0bHuLd1H6LD/?=
 =?us-ascii?Q?uQyUbdI3hTodp30QDJin9kt1rssSQHs8/I3/amQsgLlqZF5kBlsu8OalxujD?=
 =?us-ascii?Q?XMKSeFjhf8oLDU4X+ht48Z+qgLKxynXYRNcjLlfdYy0xpQAyI4zh3AdACTt9?=
 =?us-ascii?Q?w7Uu6XJfeoAoexXvD+Yx+3xVA66gDIj7NvE1igOkpGDI2UVZg16nSJEvnjqz?=
 =?us-ascii?Q?VJB4a4fdHSuWVqH0TDoC6+6+j46oKu+sWtJAXjWQH395iONBdG7aWl0iJbS5?=
 =?us-ascii?Q?/kuymRHZtENR6MuBb43ctP3yWNQnfBtYncs2x8/cJcZLDZQEjtG5jWhNh4LA?=
 =?us-ascii?Q?OddhgWA7ajHW3IckoCXF7YLJzNrRhdGyTjvCoEogAm400IU6GHS44IzyHWFI?=
 =?us-ascii?Q?0R7V9p840d0dBM/OvXfHuW6Tjxqusv05+cYyR2MtBKUl0hp4yOPXq0MVCFVb?=
 =?us-ascii?Q?IibjKyEWBI6yRXUJuS011PpBgWcCrvQdZYx7+4T2vAy9H1Dts+ifcpKVuNER?=
 =?us-ascii?Q?m47UtihL2Qpl28zddH2htN33JdpbhhsOcGPsQBzBqC4I6XanKadvhv5mzQUz?=
 =?us-ascii?Q?AKiI0KuYKiE+0UUCTjzaFHqPu7Bw6rp02hLmlui9kvXigeorcIl9uHI+RNKY?=
 =?us-ascii?Q?9OI41I8VW9rZfGYyzWJy6TrTY3bvxyoEqa4d/ftSNmH+Fi/QlezJdLOcySMI?=
 =?us-ascii?Q?C3ZHFsFFVxiHq/KB1YjNDRwyObCSmKmSgja0G+Qt+9ia/EZXeBrTbPqt7DV0?=
 =?us-ascii?Q?fSYjp/Vzb31pWrbHRsejKAB8kvqT4gdcDL1OKK+mxwW9bcNdVipfvgYoZC9I?=
 =?us-ascii?Q?jXv9wjDcm++YmpVwbL8WuGbE5J/ES9alY74rdeL5ygWW8AN/28clvg8oGUCq?=
 =?us-ascii?Q?s4EmCDuVfJIDakoTiuaZ9W6kWjyPRH9N257UzKoy3msfvctaYV3rY9+8x9kz?=
 =?us-ascii?Q?Oj4FqNobbFFgG7J3Xo68WcQN92ILzACs+lJl6klMmh6xAhdHT04LAlzG3kiz?=
 =?us-ascii?Q?VjGqxNULgG3AYtxdbdliz6PuaXl33FFgFpQ3ETY47Yz2KHP/hO6xzoRn02N6?=
 =?us-ascii?Q?GL17bJYRwLsERmNHI3E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87be0d1-0dfd-449c-51fd-08dc322bc0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 15:51:08.2002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGL0ydzgfg0Tsp0wtOp1KMaB/EsCtgBjaH+CQsB09f2fpyA/s+X/apIJhvQZsglB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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

[AMD Official Use Only - General]

Reviewed-by: Samir Dhume <samir.dhume@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor L=
u
Sent: Tuesday, January 2, 2024 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chander, Vignesh <Vignesh.Chander@amd.com>; Lu, Victor Cheng Chi (Victo=
r) <VictorChengChi.Lu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV

VF should not program this register.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 00b21ece081f..30cc155f20d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3888,6 +3888,9 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(str=
uct amdgpu_device *adev,
        uint32_t i;
        uint32_t data;

+       if (amdgpu_sriov_vf(adev))
+               return;
+
        data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);
        data =3D REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISAB=
LE,
                             amdgpu_watchdog_timer.timeout_fatal_disable ? =
1 : 0);
--
2.34.1

