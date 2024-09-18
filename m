Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FACCD19A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 11:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C8210E132;
	Wed, 18 Sep 2024 11:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmvC0wII";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D3110E132
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 11:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gocvSTdYNeNWO7SkP8LXL8UcMWdvvtHCWsl/484c+qyHFE4SbMrZvtOpHeq9WU3EY4iGBl/vYM2oswQ8D2V/G7DsKaFz9znoUV/oS8sibdnc5mt8RyTe4zrfvydaQhB53CS9H9lc/f3AsJ1AmOV5Mt3UfQMtuACLqXrji4ERxtpHdMTd7P8WSKlh4HhiMyPR9oQze5+qOjhSEnZNQhbXmYMniu7/KEG65OrrHFklYaXQr8MXpR11v7Daj9zXBMKr9M9aQBjwXlRb6vsmtRoYlMXkJA531ZU6x5ILn/pdQMsECLpHIDfzDXmYSQYIBBirX2P78/BhqHMnDhE5K6o3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HelYXV01NUIQVpd0WwpQoiyBFqfCojqbh8aqUlWSbc=;
 b=om7kHOp4WOwqE0EE3xvVmZei5u6amVSoJsmCoMfPIPFq2EeK/53CRFiif7y4PYJKmRuii24tAS5rjjzn2L81Re66yOLd+2BM7r/4ZhqgPLDefA9A3P4aPKbeP07S6vTdSK7azsbYQLPmWq5igX1iXKESNhq9lgM91QqkhVB+NPTYFOUSgqcs3DnD8gB5Gc+ItP3aSbKZwjQDaVMtHfI6n318E8pqXgtZF5egWwapC8EN2KYeG90pqBPm8Esh9JDatxWmspXrwruDQkQ3j2tT4Pb2koLPxnTuzOHJYygT1Q2HVQLYI6/43SGvQvKt6KWTBtSknPPWlx1pOOlYQgDWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HelYXV01NUIQVpd0WwpQoiyBFqfCojqbh8aqUlWSbc=;
 b=lmvC0wIIsLnALnIxOJrkqqDYpgY8fyjI78cbEH+FinM2+BxFiDpDaidc70ORDX7dEwKG1iDIM/W/TRrQyuUZ6KJ5FYFVrNxl5m9+nI2DpriAa4i7fU5viyN9A6I9Z28BuhVj65TViU3Wp+yNfUNHXrVEpTlzGHl2a2oTV67lU3Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Wed, 18 Sep 2024 11:06:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 11:06:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
CC: "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes12: set enable_level_process_quantum_check
Thread-Topic: [PATCH] drm/amdgpu/mes12: set enable_level_process_quantum_check
Thread-Index: AQHbCa34CgifozrH1kOOrOp3bHjGc7JdYjBQ
Date: Wed, 18 Sep 2024 11:06:34 +0000
Message-ID: <BN9PR12MB52578851C3135B9E9AA1C340FC622@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240918093106.825708-1-Jack.Xiao@amd.com>
In-Reply-To: <20240918093106.825708-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e8443171-d60c-461a-82bd-bf8b01502898;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-18T11:06:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 267e8db7-2148-4567-9758-08dcd7d1f599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B0Ya6RpK5cL8VZJXxBiTjAQAsVlgGhDZXkxdvZgYjcCUwNi2761yGqvFrDai?=
 =?us-ascii?Q?RZ/tPchFsnEO2XePLaYopQK6niEWNTtQ4FnsmeXJz11ThhGzyuCq52ERrDnq?=
 =?us-ascii?Q?b+bDRd62xp5CFBVd78T0Z2TKPe5Nt8VcDuyMTlAPClODEJiNrfstOMqKWl8M?=
 =?us-ascii?Q?UHciohqkaaccfUyBsO1nxKypdXa7EE9l4ud0wtI679HW6Oxn8zHGIiqmV2sy?=
 =?us-ascii?Q?f2zqfgZC4pxpqJQZV0hGRd1Cbx9+ADmjNg3uGNhwz4XBxPuP/kNPg4abnCVX?=
 =?us-ascii?Q?J4akkDkU2S+2H9gPfZ92EjEMGCMwfl3PQkpyW9e2YDX7Yo81qIzNYO2zTtP3?=
 =?us-ascii?Q?9UkWsEqM8wAt3yWKc03z1WpGTTKeGXYh5gz5Cze5e7pj1xLI7PU8QqbZNSXZ?=
 =?us-ascii?Q?qRtsx2yIhmpRCUJRG2iB9eKMKv8Qy6ptKdoul0+FrwrEgd9kU/pqezQZsVWN?=
 =?us-ascii?Q?AUZQ6jy+OeUU02d2fG9YZo7KyhmthbAGyZ5uaSaNffxydPewfGG7O9HIVf/p?=
 =?us-ascii?Q?BDYuFEwunl7YT/lNoylL8xBvwgaK2nC+6O/J1lKO/dDS5Hl6qKUUKA7V0omY?=
 =?us-ascii?Q?dfJTLAPtdYthQ9htfSrwxFj+x5Q1crI87k3VtzMScilj4euweoLnzDw+ip5G?=
 =?us-ascii?Q?ajYBf/zjXmdG55G3/puK1McIS8BHbLmFw5SJB7WKuqcTzgsHFab/ADtWl2ZE?=
 =?us-ascii?Q?/dNw8tCVlCb0XvFGzFY5TEUOUXl/09F6Hl7o7asm9odQcXgqQy5AwVcytkVP?=
 =?us-ascii?Q?gt3Nw0p++ZBo4NwXLw95JUQHYINYnDjPOMMdOCZbrne0fU3gWOMO6bMm8+v6?=
 =?us-ascii?Q?gbBiU1DUmr+5MiA+uBofCIusFgGARxGNUXeDm7/wCSTmhtRc1WbR8sYcpsul?=
 =?us-ascii?Q?4G+0JDSq4jzyFfRIuaj+TkzW9dKTuJMl/7cNQM/DrxC3mAcyxNvd/T/78Ymp?=
 =?us-ascii?Q?VAoZQ0WecTs6XgXkusbDNpmdesrufHYRZWlBr0skVUGESkJ+7BrSz6IPrbI4?=
 =?us-ascii?Q?tCV4+GWhPj1hVG673CBpCiTk8nbqfjsAcgHoEqVwsLNvRyWQkA/qxi6yybVH?=
 =?us-ascii?Q?kHMl0ORkwmRWxBbIUlu0tOeTHV6RbOXsKF79JfG3mNOKJ9S22Rk2r5UuU2hK?=
 =?us-ascii?Q?Dx5nbF5avP45Tv7HpqW/JXbyqjN9UESedKPVNiBeyds4xgy/VA8Pc5HI3gZL?=
 =?us-ascii?Q?PcuNOeCjtFVutYEXrdmE0alKGgXuKPB2romzB4D+Uym8gOuB00L2XogDGMWE?=
 =?us-ascii?Q?nwiNWuhfJXqvFqBbpARWvo2FYPnygzd63CFkeQ5iaQVFdUKL4vBiH7JASNZD?=
 =?us-ascii?Q?poCqsj94MhFawVcoN/IvmvK9RqzgCDqH4mup7COjUFIfw9kqkoJiswnV3fbI?=
 =?us-ascii?Q?MdofvHH49wTJ3DSi2elzYSAgHd3y9kQuUttRtqZdc14/hOgExw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nam8xuPCvcuKn+2e9iglNQN/xJZb5rQG4TiVFwjEJNeWKyWwykgKDrW9aPHe?=
 =?us-ascii?Q?0Ow3wElNIX7vbjugDYCsD9ElH1fmaYQs8IjTme/fhg8OwgIf+ii6sf6fUcS9?=
 =?us-ascii?Q?7ToLnVHKm6YfQPMt0qBaWYBxSBPFJ56//x+8EyZpArOPXW8L3QZEjT+mjFq5?=
 =?us-ascii?Q?xRHTRT59X4l9FlxmS83CMhKuc6GeZcnL18Mhx4ITvD0iOtxLH1r/pDPMy9Tr?=
 =?us-ascii?Q?vDZjIw7db9plW/1p/DQ8sICPPrHtHgkhE3me2Gp1xTJSJzlfdeKsuSunRtit?=
 =?us-ascii?Q?GTaFc7F5yfz3d3sI93wRN4B+FYqqMUNpawDdAtUc/E4jyZdBKUVsNP2srdsn?=
 =?us-ascii?Q?wRB7DFcUitg91i2AX7DUsIvHANZy8aPtQeeEpB8A3Br+gQFW1/IAoUQzqM/Q?=
 =?us-ascii?Q?iVa/7cpkWg395pKJRwe1751NZetsoZszGv3uAgN79Di1sa6lOeJC9ryu6f9Z?=
 =?us-ascii?Q?NcIOdP5g5gtBeQA3klC00AQY62ITTjV5QznP0vVhbD4qW6qje2Og2WmZP69N?=
 =?us-ascii?Q?DDAl/C6Qw2hXGIqBpjb6d9qDAOI/70UKoUSKf1/Xz4IptoJlQPstL2bWP0bY?=
 =?us-ascii?Q?JII364SEzpYRNvuNn88wNQXyixK/flMb6WRY/DcKQKz/aKXmUI3CvGlsuy7L?=
 =?us-ascii?Q?F25XHC9naLhLoQ3J4B1bIRiJpYoJXA/E49Tdp3DffDyfM1bLIgnmAs/tv6ok?=
 =?us-ascii?Q?53RUX38HU9mcwmGfTbYb98/n+OcHYkVnabpt7D52x6DFgtNDWxK+zcA5HM5k?=
 =?us-ascii?Q?Pxd90bGzrfyUdA6pkWQ5W4gS+Bzra/K35v50pBD0VrPYJmtKp/B/8kZGIGOf?=
 =?us-ascii?Q?RSohmSE1QcriR2X6iROaDAkxNpGT61M6xBIWJLv3ZSfsApNIVgrKG6oLIZCN?=
 =?us-ascii?Q?dLC/mKgLwPTzMRe6WsscZjR2eyworPjZGNCl2Ca25N02+RJCkiBr0KbEaNyK?=
 =?us-ascii?Q?v+L58ytxEoWFIKNXWZtKZZLAnstxaPmz3GgWrh9nzdKXRaATa9V68Ri2Uwoy?=
 =?us-ascii?Q?sLuV10zg7jxarhXyPwmcXTqTVBenTIqYR+pm6S7mtSuPomxF9W45Q8f3L4Oo?=
 =?us-ascii?Q?Gvok0qNt50qz2lNZkYUfHLc+9eAfx45TxRBEeYzt6DslWnYORgbiBvFiPqyV?=
 =?us-ascii?Q?ShP0OEejy2Wbq/ZIHZZNGrosQjlkqadqaZ5VgkeDAKfHtku5P0SDII8BvX9M?=
 =?us-ascii?Q?Bd+Zn8njnq33T9iK7Qacz+o9xPBsmI0l5wv+KPiaJ8wvNNeF9iivLWgzh0kd?=
 =?us-ascii?Q?3H/q4HmPKlIc37VvDSyiWGkUQGRwNxIOTh+G3qJoLtg3p+6orHfMwjemjJJ6?=
 =?us-ascii?Q?jxNP+FTzwOmErIzd9mPyN7EWkHB/lWISJa+PtItZUyRz/DvDCXdyQvn/GGKY?=
 =?us-ascii?Q?9bc+LoqQWDlsb57q28EfocIVcL56VG8nzCrACoQBI02xhloMQOozF2t1hZjF?=
 =?us-ascii?Q?aVRI0ODqZ96Anj08o16SDLg7IgnFF0mYZRTPFb26WjfIXhe2GB4te9JNxLZr?=
 =?us-ascii?Q?hon9aAnJ1q2d1xSaKBeuZ7F+nBFXfFaaTgAp3gmKIt7uEAtTQh6pvdKbFpr0?=
 =?us-ascii?Q?ZsK4DM993OZ44ZLKF4WNmwsorPCAchDZdnOcWijb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267e8db7-2148-4567-9758-08dcd7d1f599
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 11:06:34.8244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd5dKc6BtUi87nNFP5wOQTBcGfYEYCFV7pEIVtMnzG4YV0yXiSIjHAE23qiFzrUSmbLA+cvL9F4SfLxISdG1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Wednesday, September 18, 2024 17:31
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Huang, JinHuiEric <JinHuiEr=
ic.Huang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: set enable_level_process_quantum_check

enable_level_process_quantum_check is requried to enable process quantum ba=
sed scheduling.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index ef05a4116230..ad87621f91b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -609,6 +609,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_pkt.disable_mes_log =3D 1;
        mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
        mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
+       mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;

        /*
         * Keep oversubscribe timer for sdma . When we have unmapped doorbe=
ll
--
2.41.0

