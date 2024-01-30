Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D9C48285
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 18:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84F7113444;
	Tue, 30 Jan 2024 18:55:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB8611344A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 18:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leMMm7uDcsUYFL8sPSJi2vZFQeLVkuKGPWxZMMIjrrRjlW5fSXmiDjr3En3QrWiiZwD98g198oJyVm9rKX7iQvx/m5K3wovDcbUxhA0pg/YggaLg0Zciu1NUgFMYlOErTXIi6XJWOuiQr+c+Mfmk//z2U4ApqB8nAvSxM6cXBugqmJxgXE1ZM/UDruqgQd+5fF6SXnL2RCbdWwPpFvtY12SkRygyWLDMXO9TWAEE347kkkH+PKo7GfIF3A2Vwxu6L13y0WbNHWmX7dm5CWCmEUz/ThCMEoUfxwK01y3O3T1r1AamtBm7uxWJWEI+R9eFBXL5eFoEAjFOgSk+r5S2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbzQJ/qpPiEsVU+njryIC9JTX8rsXo4D5eNaYca3LJw=;
 b=Va2c9QoAHx9yj2H1dfmW5xwBUxJGySxe5vyv1bzx09qBLh8TvTrNo6uxK7wv+UHL9/GCufMn1FIQ9I8HdumQclXCraebpcIhjOW+xSi9VqfkthM6bK+ONORfX6gofnTqCxTRD1VfQALx8ceseOo+GJ0+pb/KeYxJH7SRNpPNkwPTyAXqU6MwkzEMk/Q7XvFWILlh9SWS/kisbI4/z2IvUulx+7/3An4OlJTL2u5q01H/gR6djfK+QiGUX+P/awYH4EZMQotGPF9weA6RstxRj3PFNzelwMf2qo8LFnjaZUAcUQgvIAOOQpWTD+24NREBGtM2OOw3U9NF2ytL94nqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbzQJ/qpPiEsVU+njryIC9JTX8rsXo4D5eNaYca3LJw=;
 b=tDz6eIvuD8UakaseU1d1jRGZ0OOPyuqLabjIU+nuTwfyXw/romy3j/NP+c17QgTCYNa0uJ2g+UchYFUDyob6c008fFmlU6j/qNTusjXoaYJDHlS0dlJ8h6i1qwrjbPBAW4/GpEL/ujhO1o6yXlMMneYl7N+T1oYXwIcZozHKIQ0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:55:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:55:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Topic: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Index: AQHaUpKVpHM+BiWNf0W4BD6ZHImIx7DytoHJ
Date: Tue, 30 Jan 2024 18:55:19 +0000
Message-ID: <BL1PR12MB5144E7FAD020BDDE96F162CFF77D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240129090611.2716545-1-yifan1.zhang@amd.com>
In-Reply-To: <20240129090611.2716545-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-30T18:55:19.295Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8584:EE_
x-ms-office365-filtering-correlation-id: e1ab1ef0-9994-49d4-e6b2-08dc21c5017a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvWJN1lSjXmmXcwC0VoSD6YfN0/jj1UOKAVj9G/9atyr+eoHYQluvKHCXzi+m+Vt5LOvCMejZp14cJ1M0/PgS38YZFtloric6gR5+tL0H/5GrX7cqBqLSx+SggnwEOCDpXzMXZgnrHg+R28uek8ZdKT/quNda1b4yqPRLY8tgz06YOGYMBJEPn10k+4mjuX/edyMrCT/PVt9oJe3QyykG9ATX9Wgt95LC2SYChI9yHHI+dSnEKwF8qxVtyvXTOwIVdXUisQFdC0ooPfndczc/aRfUXWdPxh1MzLK4eI+1NOviNh0HjoeI/rN3MLLCy1CwhVqXFW1LjsVC6eooOFk7F7O8/sJ2I0WizvjkMsaQkJIiP/waKN3Mcqt+2/rfqhIeMD2bSt8cXarzRDa+czk7yCJdegFJ1V9Z9FBZtNJeePZL0/bIfIfgANiEYKy0E4NAh1XkM7LXQse1GVkMHPCsb4SCMgWSkRaveZbaqDDx/nLZ2xB+pioXZOr8A1FuRoNuherWFIeOpzyyfTlZFkC6xuygWZDbACaxgCzT7zxX15QhGJ9rB1VfKzZc5tlGXWkRU7pxXmLUMES4nJ9PV2ViBxdZwRy+s3fx31qUpYuTaJnlhexHkkZu2+3ztdmbJAF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(19627405001)(41300700001)(122000001)(38100700002)(55016003)(91956017)(54906003)(6506007)(8936002)(86362001)(7696005)(316002)(66556008)(8676002)(66476007)(110136005)(66446008)(53546011)(64756008)(66946007)(33656002)(5660300002)(9686003)(52536014)(4326008)(478600001)(2906002)(26005)(71200400001)(76116006)(83380400001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qv3rhdS4ANw2nRHWI0XtbCF0ZaK9pqqWoxfpAs4QzcY6qCGTTAE1rY+jsAsn?=
 =?us-ascii?Q?DaEZ2+f9RiMEQoXu+1u1n6EHqHx8QYTBjTY7cohGJEPKxi2K+YswnA6sgdcb?=
 =?us-ascii?Q?BISKyDlonXflTkdj0BOROZH21fM8Fp7dAoV6+QNdwT/vtjMl15oICUsa6fuH?=
 =?us-ascii?Q?/eOjvJ7RvC3iRRrbt4GmYCY97gX99LVHT4jULUbYZ0VbtqOguUJhhu120Ixt?=
 =?us-ascii?Q?e3bHO8Jq0fCgHHm4PzI2UR4DKVkFIGVkSGzOIDgroxMq3qr4+BrP4aQ6KBLG?=
 =?us-ascii?Q?OaIrXLoU0jeVS8ObqcyGFDPvQeExhH8CG9Xl1984ik+apN2TJA/wQT4yweEP?=
 =?us-ascii?Q?XiLBDbPE/D7qfA+3dfmFTVF44URFiq0nwIjQK2o9RTmVlkSTUxsSlwzhYkOS?=
 =?us-ascii?Q?LNREMHA7B8kIFPMGsDd/1p1y/taWCxqljy3YYNm0TV6DeSnROJ3Q3n2gp2AZ?=
 =?us-ascii?Q?P/VkBkWud7j8reKVR6o3xxFYQK4kBMrPBvT87FMPOc3BMCuAud0N8JXOeQHh?=
 =?us-ascii?Q?+53OH7A/6CK9kQbPltUPDitq07TNG9pY9cDft9UuzlGPRHj4prLIy6YWLNhU?=
 =?us-ascii?Q?UYClGrQJTvfYqlfdP7Oj68IiAy9stoaig34YJxlK3sZQyFUHfDdSjjOs4YWC?=
 =?us-ascii?Q?WF0fO8IwZj7qW7pkOW3cIeUlSxiCzPYw9LjZai2sqtbg1/84HHj7hK1MeITO?=
 =?us-ascii?Q?HBV0dTEWOhqjMM73HtVYeqgQBeSeJVOC2eVI8+mQ4cjgH1pPqSNT7Cq2GtSe?=
 =?us-ascii?Q?zPUhm+jhFGYHDbnlJZ9daZqxKABZLt9Cil2FBGzO6BOfs1FDlmnry7oOQhPf?=
 =?us-ascii?Q?PrYCg+eb87vPbtWxqZXBb/QfifV59jNcgavrL3b9y8DdsxSbrPB8Ecz6LZr1?=
 =?us-ascii?Q?K5r8mEAP2Htk0YNwh+E3z/rDf3Yskd1IGX+2u00dBHklHw9rz1roUVCrC9DU?=
 =?us-ascii?Q?/q9HnjdkwQ7GAIQfPTTm2xY8B5Su6V6/9zoMVFAXwhDoRwUqjmcL/XAmAg4f?=
 =?us-ascii?Q?Ek7pH+VNYI+LtW6mkuKG+2yZQfNRVcvpKnVCFYDphCMCDF0S5QRu3MQAVcLN?=
 =?us-ascii?Q?VqHQ6Crxs6NiPVosy0QL6891dp/Gskq7q8TSCk88Kl2OIk1e/L6nHQR0jn/D?=
 =?us-ascii?Q?ImACiOfguPfkSV3bz1lQnlJ7/n4M7xuUCb98ndIl55Y50fYcQivdpNGL0vgi?=
 =?us-ascii?Q?ObmIH87CnoQSsTlfGaRmFDdaJx7LC81Dqg7x8S20SoPlKI9VGq+F9kiIAJD8?=
 =?us-ascii?Q?meGFMaosNgipZbX/fRD7EFUHhgGpzzoDakRAj+ZDNLp+vPvDcJtMRanalC7B?=
 =?us-ascii?Q?TIQV4PUbZSvIqYt7L2PkZhEmVY9LM6UJL0U/MtUbMESJpZDXuAd6KFNAuGHW?=
 =?us-ascii?Q?9ck7ijKy2Sh0ThKkmhfg9JQ5DC/mwsJHqJTnhmaBAHdcGdcmj2XA7FJTjBCS?=
 =?us-ascii?Q?93VzZ7KP2LhMFeGVqpNQfQwGMyh6q/ZFwpNzutaqRJYXt1iacwdbAfduFiWW?=
 =?us-ascii?Q?n6rYD4NKBowOkEo7+MuI/SnIpafEDdIbRJ9uRkJwGXo/wD9jtNdGy0r6ScJ7?=
 =?us-ascii?Q?3MTvOv6nuavYYyLaawA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E7FAD020BDDE96F162CFF77D2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ab1ef0-9994-49d4-e6b2-08dc21c5017a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 18:55:19.6421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PjdgAhNJSJGVUkLVnGI67O//mbGTi/LHVCGtLx3c5/QljIRmC//QLtpduQSC5yLtBCGOxpYY3x71BX06tbDqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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
Cc: "Huang, Tim" <Tim.Huang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E7FAD020BDDE96F162CFF77D2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Monday, January 29, 2024 4:06 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang <Lang.Yu@am=
d.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0

No need to set golden settings in driver from gfx 11.5.0 onwards

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index c1e000010760..4e99af904e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -90,10 +90,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");

-static const struct soc15_reg_golden golden_settings_gc_11_0[] =3D {
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
-};
-
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =3D
 {
         SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff,=
 0x00000010),
@@ -104,24 +100,8 @@ static const struct soc15_reg_golden golden_settings_g=
c_11_0_1[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_ENHANCE_3, 0xfffffffd, 0x00=
000008),
         SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_VRS_SURFACE_CNTL_1, 0xfff89=
1ff, 0x55480100),
         SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x010300=
00),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)
-};
-
-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =3D {
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff, 0x00000800)=
,
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff, 0x0000=
0242),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00=
000500),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK, 0xffffffff, =
0xfffffff3),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, =
0xfffffff3),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f)=
,
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188=
),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007=
),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880=
007),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00=
010000),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x0103000=
0),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000, 0x00000000),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff, 0x0000200a)=
,
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff, 0x000004=
8f)
+       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)=
,
+       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
 };

 #define DEFAULT_SH_MEM_CONFIG \
@@ -304,17 +284,9 @@ static void gfx_v11_0_init_golden_registers(struct amd=
gpu_device *adev)
                                                 golden_settings_gc_11_0_1,
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_11_0_1));
                 break;
-       case IP_VERSION(11, 5, 0):
-               soc15_program_register_sequence(adev,
-                                               golden_settings_gc_11_5_0,
-                                               (const u32)ARRAY_SIZE(golde=
n_settings_gc_11_5_0));
-               break;
         default:
                 break;
         }
-       soc15_program_register_sequence(adev,
-                                       golden_settings_gc_11_0,
-                                       (const u32)ARRAY_SIZE(golden_settin=
gs_gc_11_0));

 }

--
2.37.3


--_000_BL1PR12MB5144E7FAD020BDDE96F162CFF77D2BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, January 29, 2024 4:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&=
gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">No need to set golden settings in driver from gfx =
11.5.0 onwards<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++-----------------------=
-<br>
&nbsp;1 file changed, 2 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index c1e000010760..4e99af904e04 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -90,10 +90,6 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_me.bin&quot;);<br=
>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_mec.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_rlc.bin&quot;);<br>
&nbsp;<br>
-static const struct soc15_reg_golden golden_settings_gc_11_0[] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_=
CNTL, 0x20000000, 0x20000000)<br>
-};<br>
-<br>
&nbsp;static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =3D<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),<br>
@@ -104,24 +100,8 @@ static const struct soc15_reg_golden golden_settings_g=
c_11_0_1[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, regPA_SC_ENHANCE_3, 0xfffffffd, 0x00000008),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, regPA_SC_VRS_SURFACE_CNTL_1, 0xfff891ff, 0x55480100),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_=
CNTL2, 0xfcffffff, 0x0000000a)<br>
-};<br>
-<br>
-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_D=
EBUG5, 0xffffffff, 0x00000800),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_A=
DDR_CONFIG, 0x0c1807ff, 0x00000242),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_=
GENERAL_CNTL, 0x1ff1ffff, 0x00000500),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A=
_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C=
_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C=
_CTRL, 0xffffffff, 0xf37fff3f),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C=
_CTRL3, 0xfffffffb, 0x00f40188),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C=
_CTRL4, 0xf0ffffff, 0x80009007),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_C=
L_ENHANCE, 0xf1ffffff, 0x00880007),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_C=
ONFIG_CNTL_1, 0xffffffff, 0x00010000),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_C=
NTL_AUX, 0xf7f7ffff, 0x01030000),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_C=
NTL2, 0x007f0000, 0x00000000),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_=
CNTL2, 0xffcfffff, 0x0000200a),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL=
1_CTRL_2, 0xffffffff, 0x0000048f)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_=
CNTL2, 0xfcffffff, 0x0000000a),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_=
CNTL, 0x20000000, 0x20000000)<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define DEFAULT_SH_MEM_CONFIG \<br>
@@ -304,17 +284,9 @@ static void gfx_v11_0_init_golden_registers(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_11_0_1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_11_0_1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc15_program_register_sequence(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_11_=
5_0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(=
golden_settings_gc_11_5_0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; golden_settings_gc_11_0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (const u32)ARRAY_SIZE(golden_settings_gc_11_0));<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E7FAD020BDDE96F162CFF77D2BL1PR12MB5144namp_--
