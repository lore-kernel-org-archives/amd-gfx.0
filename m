Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB61C369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 06:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17BE10E395;
	Tue, 29 Apr 2025 06:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CloHy68E";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E2D10E2CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 06:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruvnPGwTpLcsI/5ZbkaShGPRW7Y0zOIdALVZxvPFDZ+CBp6DPzfoioWSdEdvwoqDwkJJR/RBDSqqmTCaoXPZ2UJHkNFBp1rNt3jQU26RF8CKC88htN3lr+NGc+dWr5U6nnv3uSN433lfUIDzoMOaiIuvsbsVzSxzY6nuZBb3n0ENGsNjWIdoCo2c0wZdJ/Oq8RihMwwPKuy+qrA0+tNsNC5kp/AwQ23RkvBreFr//e0Gaovi+2+mvvhm2UFKFHUDfLpkZ2nUoXKBCwmSQ/qMXJ/XtGOQTilfb7ecN4EwJ8zyVV6mKqFpdexLEfDD0RfEgiMu3bMkGPqLHk7EkeE5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eExLQMvZv6DXebNYngl81qLVxRqABw/NlZUp8ThntQ=;
 b=WxPlUcMjhf3VcKZGCSQ2TOeHVcpeVhZCKkxXWlbrAXZVCp5EdWbYtQYwzoJgr1m5POspBFkAzzjrhGV4vvNEPoUt755wG51CoX8wX508gDjOz+J4x6LWLbJCNnAsNZ/Vap6H8G7MuP/s7A7kzZUuU85MrssgBb8kvukqbd111bSEVeOyYXLrn81jfq7+SMfII2BVJ0i0all3FG/qBU3TLkIZYEzmI8OjMSVioc3AU1D3JoRr5GAPgzo0zFsEE0egrXR2SdrAm8ipXl2O1+wJMm14mLs2OiRnE2E4ox+F09pMjWYBoCTerKTA6EXgfek/uQT9PZFsUTVE9bFsRo7b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eExLQMvZv6DXebNYngl81qLVxRqABw/NlZUp8ThntQ=;
 b=CloHy68EtTcoCu45evJk0jJrZ+mv9PXr05EsVxfdAGfsb06eKT3G+MXte7MSh8xxqCLmRhE8pF3VRBpXz3IMN6RS+TZPgp0s4ZgYLNtMfr1C4RiYB/iKq/XDmHKEai/Ii1yiN9I2Rx+TOLR+bt2qVSXDxnn8TX6habhJQcCdyaM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Tue, 29 Apr 2025 06:22:36 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 06:22:35 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Topic: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Index: AQHbuLT4z39U/+I5t0yuzk7u65JWqbO6LLvA
Date: Tue, 29 Apr 2025 06:22:35 +0000
Message-ID: <DS7PR12MB60715790DE953AED6C7AC5688E802@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250429031512.974183-1-lijo.lazar@amd.com>
In-Reply-To: <20250429031512.974183-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2d1b0b5d-243b-4ff4-adde-33bac9e7e41f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T06:22:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB9321:EE_
x-ms-office365-filtering-correlation-id: 34547879-88bb-448f-35ef-08dd86e63b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lCfvqwTOBpSxJyeuh72jpbLXdVNTtxvLLmCWATsY2ybyUV/9to29tR/DDMNR?=
 =?us-ascii?Q?NTQw8MOugV0dlzmreSl0FjlSRuoruOJ77adLcDXAI5O5wmfY0GTu98T8iKKs?=
 =?us-ascii?Q?07OLaoawrRNFzuKqibVzmEYTZhdtSLLsv9ItvImc3v1+UAM0F0sRLz+wrNHH?=
 =?us-ascii?Q?vYSbQGgtUIq6GajxEiU/PrWUbOiUlvlqOdsLT1nBujx9WCfulJkdLOm8dj7J?=
 =?us-ascii?Q?791VrWnHINBQtTSlYHXvSIx5IhuizJAy9OrbRT7KG9efTzyrhO3EIudpaIda?=
 =?us-ascii?Q?foTj5X1Nb9qgPlFlsCHqwkG36G/uYubURNrK3YJmKec1DCyBzIlMvLW4jLwx?=
 =?us-ascii?Q?XsDWeSMyd0E5EZX5QbSWeZWBIixx3l1nckC08KJRA/uT+GNQzQzf2jSvvq7x?=
 =?us-ascii?Q?foFEggOqNSmlDZ8/Q2KFTcfznVR3DspK2mfoTNvfNrR0lQTM+AAdSGcGNOA1?=
 =?us-ascii?Q?aWr/eYYTADCRjSd0uxelGjaMdjOtFkMmNdCGmD9McCYo0o+1Bci+pD+lWTTE?=
 =?us-ascii?Q?NcS7cefcwZb9nHNXL7GCjcmVrWlWTnLWBTWLF/txxbqCPbjFByskUrABI1Tr?=
 =?us-ascii?Q?IQfpev/4NHgTqSpbN9kYjEOqtG9iEwOJP3CslN7C6clVptUgSuiJ1Pxzh5XR?=
 =?us-ascii?Q?iGXqpQOex5szVo06SYRwDZhXbQqPvOjZdvLNaO2vv58ljY+wc6yU2K7Z3P3X?=
 =?us-ascii?Q?pxLQKUi6kosxhNWB2RDO9GVGSIMSB6Epzdjhg9D53tQNLGXMoq7ILPOuhRYg?=
 =?us-ascii?Q?F/YAoFVdARU67z45NyX5uXwKQlTDojaxBdXhkCBvn/jTInnoXjtdokTe91Yi?=
 =?us-ascii?Q?1OJIOh2RuMkT9CthEdfvbNAluKf8+NGkLJZ91GenvMooto9dDtelgX6d3d7V?=
 =?us-ascii?Q?ElV9xomQfCMsoSG6NszO4jo8OqgoOqyrpbT2q3y2fsw024CO0FtbcyWRjaHh?=
 =?us-ascii?Q?z76i7j8zTp4y8W2OeetyZVEG53SyKTKofVzHWzQqCtSvoVsjK+3CgIdiQEeZ?=
 =?us-ascii?Q?g4WZq0Q7HEI0B2aEGQm2gH53fLLMBYVGUEL6KP90gqU8xrj2L0PwE9rUR/bi?=
 =?us-ascii?Q?um+UJeaAti865iFoaLgj5d8Hx0yq06Ga0638s+Y+ru5tQtTTSNUYbq8KYPCa?=
 =?us-ascii?Q?BqtrDHMBDWN3pI6Runsfim64KMC9duUoC0gFCkrcim2ZuqmoB1g8W7V7JBrQ?=
 =?us-ascii?Q?rSatnUt1Vhpd2ZRacsbn/dFsTAd7eMNZMB1JJ9wE3Vy6ldwCMLXUxBuwXiXt?=
 =?us-ascii?Q?Tqzzm26Q0H2Zk1vHeNPmX46h2GLhXrdYloW3cHU7H2+gLKN7MrkYFcz4OUAF?=
 =?us-ascii?Q?9624w3UWyydG7tNlZDxTBM/H7xuuqid0FrhV2sK6mJrsrmInZrOLsyZNhGPb?=
 =?us-ascii?Q?a6PxA3IWNWD6yfS+6TrRvrxtulzJJgB9FiXuRhs05VyRiYVwLlzBqgnVylzY?=
 =?us-ascii?Q?RaIkS/m5SwURyPhVHGwhKkELBkyHk1fl3Sfd3+Zm6EewVBXf6FxkeQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gV41j/utWapkMKGtl60voYtKlOL4VGPloNbXn+PsQ61a0+U0/Op9/UtYZOdB?=
 =?us-ascii?Q?jHjcqJcZWhRtSFQ/GbrwNnk7aKG1z+Lv1JZQKd5dNzj4AuH31nyf1ryVe33+?=
 =?us-ascii?Q?LI4MZUSolI7fOPNJ73/CDoSDtAuoPQcwkF38pl2TxNvQbFrgNppBgBi2ud9d?=
 =?us-ascii?Q?86cBJ42p16pWuZ4f60cSxUJHJGRxA6JJYtqIsqOi5+5nM4ysKVZDHUZsgwiO?=
 =?us-ascii?Q?tQHdBYAKSD0nM2djO7f/BOu7/xC8D9J7Yag+OItsVVL6dKomw42pvva95qnP?=
 =?us-ascii?Q?f4a95f5c0WQWSja4I7CMsa12j0wz8VBz3/qIhuzguWx9vS0261IPFVmq3SNR?=
 =?us-ascii?Q?S45eRyKinr+ZgJR699q0TrBW7xR8x1TioW33FWTMAZWis1XeCNfk0Qc6KAyR?=
 =?us-ascii?Q?KAyf+cRbcFrFG4A2VZtloKjxALhqqMcZLBI5rAN1Hr/pSUbJykiNTDwtnSCa?=
 =?us-ascii?Q?iN6ISpor1DVDgpNETf4Khgf/o7kFbscs0JX52HXZLqmuLGBT5iunQPPBgXEl?=
 =?us-ascii?Q?zWEL9nZ1/gUuxC60m/BgSi6qsJD3ZaLeZFM5VWM4G+92JcF0EsDv02VSdfvk?=
 =?us-ascii?Q?CvIRGahm3bDTVa/5NGud+qLCLUNKMdhDwJfxiLcoyNBHDqiBDQN8wVaPhUro?=
 =?us-ascii?Q?eBVUORvDg0O9eUi/nWUNiKPi4wPlnfQw/LzjadzLD75pS5HZhU4XOi3/UXZH?=
 =?us-ascii?Q?K7PyLho0C3AtE9Z0Ao3abXX+BiW/+H5tb14g9izj0eQytYSLtNgg7m+mR+y4?=
 =?us-ascii?Q?hP6UyfgptaNk8Of+3gQAPvVYQ7tWRXBAREui2DTJIgQllZMl8hDcDNNoFdVB?=
 =?us-ascii?Q?3liwhYrGDxkeR9aFSyM83hTDZxhHD2mLY6WReVsCau9vfv8559TkuN+P0F1z?=
 =?us-ascii?Q?CxRWiPG+AC6Oh93489FMB3KUQ6c4kk4Opnq/LrYibHW/B6vvrLZvPkFJ6M/9?=
 =?us-ascii?Q?RLYAF4gLzPEREvrXdzNXjW2q6SS/QWVSWxRBLEcqILePPwq/s5/9GkwjC+8k?=
 =?us-ascii?Q?NkTfRAa7Nr2TR37/l4Cz8ljOSOUEr9gIL1CD+qWxhkaCgo+APxdvWDgUwsLe?=
 =?us-ascii?Q?Wkc132RtcNjtMrjUM6oYKAK9yR15pUFiqz30omADbVMOGHVR7N+SdqSRpGO1?=
 =?us-ascii?Q?TaXrmd45fm6ZQW5gggnrE8Ol0oLPMeSU2LrsHMjTdW4HmxiTjcpM2w6h9IsY?=
 =?us-ascii?Q?Q7OGEdS/Zeabpyp1Xm7TRLGgTPs4AjMSq7V0gnsnuaP/NVtWqCYGMGWxAPO7?=
 =?us-ascii?Q?CoOV3HuvhV84TotrbySWrNv1bpw3y/UnAEQ/K2tVpkWJP+cGvMAegmiRrGYh?=
 =?us-ascii?Q?NIShqG/s332haVVsTmORG69gFJYDd7AQAhPVjdDYYFewoCyOpB/+UY8Sjarx?=
 =?us-ascii?Q?e3IyXcyWv/BuzjMbqXwGqzjIqXKalailTD4ttotHO9xD88/5/BLYFm3mz7A1?=
 =?us-ascii?Q?2J7lRcc/gcvYKugYKG/p1tF75N9ZlMooN9/h30T6AMHF7LoSZEFicudZqcX6?=
 =?us-ascii?Q?TKFLK0CnSEhpBxlKCZMNZTqY4GVjV3FGQX9NwvqxF9O4f/QOitmJodipd6Yv?=
 =?us-ascii?Q?8GERDCAvfgyW3AhaHak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34547879-88bb-448f-35ef-08dd86e63b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 06:22:35.4870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjhRezmQnCbWjD+Rv5P1n4XBGvc29pDokXFDole6oFIEH2WVwHttPXh/TEh1cKoLx0UkKvCrR7Bw7/IUgNwnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, April 29, 2025 8:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use macro to initialize metrics table

Helps to keep a build time check about usage of right datatype and avoids m=
aintainence as new versions get added.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 67 --------------------------  dr=
ivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 13 ++++-
 2 files changed, 11 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 80eb1a03b3ca..7eaf58fd7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1051,73 +1051,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *sm=
u)
                                    false);
 }

-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
) -{
-       struct metrics_table_header *header =3D (struct metrics_table_heade=
r *)table;
-       uint16_t structure_size;
-
-#define METRICS_VERSION(a, b)  ((a << 16) | b)
-
-       switch (METRICS_VERSION(frev, crev)) {
-       case METRICS_VERSION(1, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v1_0);
-               break;
-       case METRICS_VERSION(1, 1):
-               structure_size =3D sizeof(struct gpu_metrics_v1_1);
-               break;
-       case METRICS_VERSION(1, 2):
-               structure_size =3D sizeof(struct gpu_metrics_v1_2);
-               break;
-       case METRICS_VERSION(1, 3):
-               structure_size =3D sizeof(struct gpu_metrics_v1_3);
-               break;
-       case METRICS_VERSION(1, 4):
-               structure_size =3D sizeof(struct gpu_metrics_v1_4);
-               break;
-       case METRICS_VERSION(1, 5):
-               structure_size =3D sizeof(struct gpu_metrics_v1_5);
-               break;
-       case METRICS_VERSION(1, 6):
-               structure_size =3D sizeof(struct gpu_metrics_v1_6);
-               break;
-       case METRICS_VERSION(1, 7):
-               structure_size =3D sizeof(struct gpu_metrics_v1_7);
-               break;
-       case METRICS_VERSION(1, 8):
-               structure_size =3D sizeof(struct gpu_metrics_v1_8);
-               break;
-       case METRICS_VERSION(2, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v2_0);
-               break;
-       case METRICS_VERSION(2, 1):
-               structure_size =3D sizeof(struct gpu_metrics_v2_1);
-               break;
-       case METRICS_VERSION(2, 2):
-               structure_size =3D sizeof(struct gpu_metrics_v2_2);
-               break;
-       case METRICS_VERSION(2, 3):
-               structure_size =3D sizeof(struct gpu_metrics_v2_3);
-               break;
-       case METRICS_VERSION(2, 4):
-               structure_size =3D sizeof(struct gpu_metrics_v2_4);
-               break;
-       case METRICS_VERSION(3, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v3_0);
-               break;
-       default:
-               return;
-       }
-
-#undef METRICS_VERSION
-
-       memset(header, 0xFF, structure_size);
-
-       header->format_revision =3D frev;
-       header->content_revision =3D crev;
-       header->structure_size =3D structure_size;
-
-}
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index a020277dec3e..cd75fdfd6b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,17 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define smu_cmn_init_soft_gpu_metrics(ptr, a, b)                          =
\
+       do {                                                              \
+               typecheck(struct gpu_metrics_v##a##_##b, typeof(*(ptr))); \
+               struct metrics_table_header *header =3D                    =
 \
+                       (struct metrics_table_header *)table;             \
+               memset(header, 0xFF, sizeof(*(ptr)));                     \
+               header->format_revision =3D a;                             =
 \
+               header->content_revision =3D b;                            =
 \
+               header->structure_size =3D sizeof(*(ptr));                 =
 \
+       } while (0)
+
 extern const int link_speed[];

 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */ =
@@ -125,8 +136,6 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,

 int smu_cmn_get_combo_pptable(struct smu_context *smu);

-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
);
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state);

--
2.25.1

