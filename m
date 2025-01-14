Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB713C02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 01:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACF210E81F;
	Tue, 14 Jan 2025 01:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ij4STPrs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A773C10E81F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 01:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBattXev1aGTB5Ul6v4SroGA2mHr1m7tLaGDp3ps1zUm9J/gVwo0N5EdOR/GStTWeaqGCRWAd10895ZOdUWc/YzSxh7+tGy/4lGtvPXPv2BbSkvDnvK5SvfugLa2vA6MybXAllH+iFeerMu/I5P5PMFkJ89LqYWrg9cYH1TEpppXhmrCoUnLK7EPyPL/kW+Da+Dc3cDHy6vm3YLN46iYEX+UTPXmRqKSL9bgol+En9EyePy0aaok8dHNwz85vrJQFRiOEcGEqaFwZg2b2eUe9P+jDJ7mARSoC5R3ZhT2046nNjm5HEKNge/IxV77OWrm7ieNJEtGGtk4Nz1ZfsUh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TJXHIOfg/MYJI3tpwwwuKWTIh89EGo3D/u2aAdjCL0=;
 b=urqpCaliGItxM2DoW+/LeoPJ00SDkkhZsBPXnWVgEoi09xyTMtnlW1h9NPZ73/oMahc1Vuviqb1GgKqcTqHa7FNmcCwDkRBub1PBuE3lGLZzDUJw41WflHpjGfmfHVhH8YU8xNfSLNobBATsl/8JPls3x8RgHXVygJ2l/jQlAB88jDX/PZLsrFnCiOyVksLKfcDEf/a/SJrING4xVarraftOxPe9/kJb6p3oAgrka8+JR9+Z2Rw1Og1iIIkzrJpKhECTnbXyvkMZxrTNrueBQuf8E9gwgZl+WHPBDblXu2QRQOdDshrmCkH9UaAo4VY9lEvXmoelUnPUuzLuJppHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TJXHIOfg/MYJI3tpwwwuKWTIh89EGo3D/u2aAdjCL0=;
 b=ij4STPrsamBFo63bvD2HKm95xyLiGqDLqxgxIBwnXz8L0z9jeSWB5Hzi1lAwOapfmcwzQNtm7Lionk4fadB+PUJT+oyJazze7Y+gluC3QG3D1eMVbMFouhZfQtnozyLk9UihJGppl5Q9l1F8drFXzvN+6EClYp1ns9JhGE+4Utg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 01:18:15 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 01:18:14 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO
Thread-Topic: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO
Thread-Index: AQHbYx+ZDfkKhmOZ8E2XlJI/9/JzRrMVfdrw
Date: Tue, 14 Jan 2025 01:18:14 +0000
Message-ID: <DM4PR12MB51529B4159FB4FEEFEC4D845E3182@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250110052150.3295085-1-jesse.zhang@amd.com>
In-Reply-To: <20250110052150.3295085-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9fc6c53d-318b-40a4-854a-2c08456a4bea;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-14T01:17:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB7066:EE_
x-ms-office365-filtering-correlation-id: 14bf86b2-2393-4314-c775-08dd343951d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?K3sWu0Q/DAiUzYPBVNn89T5WvPc9qe17VzoE2KWgmKi7H0LIO438pJllBNLq?=
 =?us-ascii?Q?w848VRTzgjy9SDdqfwNsKO6ndluaLgMaMK/dC3eFUIpzUcAek2kA0iRhK7uj?=
 =?us-ascii?Q?5ClN+qzgatbrIf/8se7BoQd/CixWRmANjV0jpPpvx5FFM2nOGgmRls1htaL/?=
 =?us-ascii?Q?SZGtRTNpDSy9BUKQS+d6gg3FhEmD2v80bYwLi7yfc/Ov57QkwmkMzfCKbBXT?=
 =?us-ascii?Q?cboxjkKGg7K6NIZpmvzRMdTVTK/AfeWKCB5o09tJubbj4Y58FSQi3dj0+VkC?=
 =?us-ascii?Q?1NGcfw1LN2tReGagOCw3jF2XFzwMUq+ykHLl/yoPqVSD+XZvjd3I8FxjPzW4?=
 =?us-ascii?Q?ospYzFPDAhsg8xeUNKInAhRnIvkW3q1boT+z8Q2VR8+m2O2tRZbYfLUVzsQN?=
 =?us-ascii?Q?/jP/C0J2GM6UfEP8PM7BO6vMWEdXI1ZHnf1Rx3VacTaNntwuVcWqKfEEzwtT?=
 =?us-ascii?Q?WVrVG9JUUKXo6cErtGr45IemkNAr/Mei6ebnf5dRZkUfdsHSpQn7MNSaruVC?=
 =?us-ascii?Q?Q3KvoypJfcCoEzuLwNy/Tgit68QZI1qQpCZ4P1HQT1zMqnwCwS6jmdZB7Izm?=
 =?us-ascii?Q?pxmEoetFGrYlI6AC6qEVTCuzJZ5pk1SfK5zpHJMA9nqCZ+J/mEMJ+EMpVWES?=
 =?us-ascii?Q?eEEhi3XV+txPZelTdVyvGhQJATuQn0EKAdPaE4V+jf4Z9KjBMQh+LYLRXnPV?=
 =?us-ascii?Q?JIOGR91qJr8CydDyQMFgYSolNg8/yg/AmkwjqbXD7Y7yebhipK30iHcE2tv4?=
 =?us-ascii?Q?W5kuPlwDRrtyr5fxxAE8Mf5ZbjEFhGwvsC6PILI84sl4NEBu4SysW66rtx16?=
 =?us-ascii?Q?Zm2piHtQdVZs0O9yza9suiaIJYKTxetgUi8WTQOsYiCCTh1DSata5EpyiYAx?=
 =?us-ascii?Q?RLn+w7Qz+QivgT23i/fipbK9XqRgi+WEnWWRqiJiEXHhYa6Wny/vPzwZ27TF?=
 =?us-ascii?Q?MqQ9YLvq7W5/vtV03qb9oK7m3HgNTmbwiJ4whdfYiyefIgUNA3N2FlxUy1bb?=
 =?us-ascii?Q?SBk8ToazGfmp7tTSBaBl6vyLnym0G65KR/H+7SFbDDlcLMC6lNrIUQR/Dw3c?=
 =?us-ascii?Q?Soh3BSmIx/e8wTwbjWJn+rf1/z40YnQ/7UnWmVLSSWcxq70RNaXRjsFyJJZ2?=
 =?us-ascii?Q?TFWhmU1P4rt9l2xoEik0fCOajDyM4TyBwtcXs9vKcTZNL+XxUgf7xKjlNKhI?=
 =?us-ascii?Q?QpjFUP5VWpx2e0JjLeiD4/4W9logC55GrUYbCm5Mxo8+ZbYlnLrNgX74jBTD?=
 =?us-ascii?Q?+cen5iwwMGQ7pDgEy5hozpkONe/pMhLX4XteoXOoilPBBtQ6CdfkXtT/Ha3G?=
 =?us-ascii?Q?niDDK0UcHAKIwns447mPzLR+K2+Fqb7pXAFf/eh4PxayvL9ve/AtdNfXBsq9?=
 =?us-ascii?Q?RSNVO5kRAhIdN/y6BBHkzajCMqUoz7DpJ7yZcMFxq99QoZ3o8pGEyknNaPs/?=
 =?us-ascii?Q?fiDqWEnNNLLX7hqoQi+pKWcU71qMZkuv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jpIA1FsyrpsbTeRuswQTRqzSufIC12Bjb3QZ3ZTcOBrsrGbRMmJsm5y6tETf?=
 =?us-ascii?Q?AZYT+ALCHsv5YWZUx3Kw7tiL627Brpq578pD6AIGne0/Kh3gpSLeWD4fWy4U?=
 =?us-ascii?Q?tpHPV4k09RB7rbSBkNfw6IOg+0E8NZrzURm3NRoQxGLRS7M06JfHx0pzmP/r?=
 =?us-ascii?Q?d7LfdZ/MPr8LY8Tv2aE2sl9C3n6h8yFrbZRd8nfMcBnLn3MN97r7gwjJaAyD?=
 =?us-ascii?Q?88IDAWW1jK2vJcjdQSZhguArPlid5Oza5M35S4utm4rlcmfmL2or7NGB9ewe?=
 =?us-ascii?Q?ZG7IKsRcmJkEz1pNC1XR00Q2YTR0T/QkWMet8QCriEACBPQycyqZ19pW9a/k?=
 =?us-ascii?Q?6dQiNDf8AppzvXeYftqClGCRt9EiFjrsAhgIy7WcbMWfF5ewyHgNyIFr8Qx6?=
 =?us-ascii?Q?lTv+0uSpb83tr1RdtBtWG9PuwPOVUiaoFhOPz/0WyBowpyAHNMW4FFsWEWg7?=
 =?us-ascii?Q?qsJLEbJmSjbuS39M0dSv93V0i05q07jEvt5LL13Ic/0lakE0v6CJFkpi/j8/?=
 =?us-ascii?Q?x9ed3qtqq4vYk8Tv/qgpTdxUNK25uVC61bJ6G/rga4pmb4eZf5v/4aNKPQCj?=
 =?us-ascii?Q?Ls00eFkj6gASd5fl2xlkAN0ClZiwrFxyPdU6v2IKkLB+VciPQf5CEtdgsvSS?=
 =?us-ascii?Q?l+twzGPoGZ591pSqcOM3tSSdu/zknEr58aJOYl4smn4D8JFDzQWrMm9xXr71?=
 =?us-ascii?Q?YXUX+7uakSZq+6MUeFqtqQWSj1FGpH7ZY/GmrQDKbRm1eOyQSEIp5tY9JrH3?=
 =?us-ascii?Q?qKcS7SQ3t2Ghu+AqG2cti0sd5yl9WGfPMm/MCvamVWgKW47FJ4tSr8kWr7Je?=
 =?us-ascii?Q?Tcdx1TQJc56LZM2iCBR6aKkRAWQQn5pefQPebQUn6jI9mVIJX+sfAvwrngCe?=
 =?us-ascii?Q?lZGKAW3NqI0JqvP4IiR8hJ4K60Kl00qbFSsr45dG4oqo6yoqpECILPSNoWvO?=
 =?us-ascii?Q?ktVaNtYNK8MPgRWr/Bj/Tlf6p1yK60kbi35wmu8K6uy2vKeIDPiJRgtT1fxS?=
 =?us-ascii?Q?lUIUeUrCPeBRTs5THxNyB7jDIVFvfxUdR2iw33fJlclpY8SlDtSH71iAOzVZ?=
 =?us-ascii?Q?+S6eUIX8Pvgeu2xkwJiXgL7IPKFDnv2lMHBLnqACfaAYVd6htULvZQDj4YIm?=
 =?us-ascii?Q?PZGdtAebnUmYsI1/04cnC8ymDjrBOVIs+bc0Hd1gHOghyUaKnia5xigwxb9T?=
 =?us-ascii?Q?QgBXF8Zxd1RwlBQlLJVozFMKl+1u0PLALsHtiz72c9iVfF0p19lHxtWi5syL?=
 =?us-ascii?Q?4/CrFknBHyqO6nf/+YuuA8UK/FdvxkXPBEh0DkeQVoISXyCRZp2mOCJx8qfM?=
 =?us-ascii?Q?eJmZKqKzgrSK7ED3qmgXR/mbppvwSmW02duYQ+atujIEwvtGr7zq8kcOj3+D?=
 =?us-ascii?Q?PRGVPR2VED7m5LjvFSpaNWLWdpHtx2YqVyIcK/fGLlCW5aRtJ0FSSa96+Wpu?=
 =?us-ascii?Q?euiV3wqtKkghDg/VQIa7lDNdQ6RbAcJnwwueZ5PBuB9vAlX3+iFc8RXlJ2Z1?=
 =?us-ascii?Q?aEkmW2T9Cz1QtQ+vFdOTRNgKWB1Dm5ypTjo808OtgTLRLJ7wZXDIKtw3FbDd?=
 =?us-ascii?Q?lX1KVGXT8O5bSFsnuMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bf86b2-2393-4314-c775-08dd343951d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 01:18:14.7048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wk7IhfTtOgolgjiBkWqGZTcY0CVMVyaiPNuFJ8l4J0j3HfQ5Q+tg7UMSXrzOTXvw1L2ZYZIWqIR7cVwuk0wR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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

Ping ...

-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Friday, January 10, 2025 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu, Jiadong <Jiadon=
g.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) =
<Jesse.Zhang@amd.com>
Subject: [PATCH 1/2 V2] drm/amdgpu/gfx10: implement iqueue reset via MMIO

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Using mmio to do queue reset.

v2: Alignment this function with gfx9/gfx9.4.3.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 5ba263fe5512..6157e1126030 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3790,12 +3790,46 @@ static void gfx10_kiq_invalidate_tlbs(struct amdgpu=
_ring *kiq_ring,
        gfx_v10_0_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_hub=
, 1);  }

+static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uin=
t32_t queue_type,
+                                       uint32_t me_id, uint32_t pipe_id, u=
int32_t queue_id,
+                                       uint32_t xcc_id, uint32_t vmid)
+{
+       struct amdgpu_device *adev =3D kiq_ring->adev;
+       unsigned i;
+
+       /* enter save mode */
+       amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+       mutex_lock(&adev->srbm_mutex);
+       nv_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+       if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
+               WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
+               WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+               /* wait till dequeue take effects */
+               for (i =3D 0; i < adev->usec_timeout; i++) {
+                       if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+                               break;
+                       udelay(1);
+               }
+               if (i >=3D adev->usec_timeout)
+                       dev_err(adev->dev, "fail to wait on hqd deactive\n"=
);
+       } else {
+               dev_err(adev->dev, "reset queue_type(%d) not supported\n", =
queue_type);
+       }
+
+       nv_grbm_select(adev, 0, 0, 0, 0);
+       mutex_unlock(&adev->srbm_mutex);
+       /* exit safe mode */
+       amdgpu_gfx_rlc_exit_safe_mode(adev, 0); }
+
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs =3D {
        .kiq_set_resources =3D gfx10_kiq_set_resources,
        .kiq_map_queues =3D gfx10_kiq_map_queues,
        .kiq_unmap_queues =3D gfx10_kiq_unmap_queues,
        .kiq_query_status =3D gfx10_kiq_query_status,
        .kiq_invalidate_tlbs =3D gfx10_kiq_invalidate_tlbs,
+       .kiq_reset_hw_queue =3D gfx_v10_0_kiq_reset_hw_queue,
        .set_resources_size =3D 8,
        .map_queues_size =3D 7,
        .unmap_queues_size =3D 6,
--
2.25.1

