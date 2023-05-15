Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA3DC7EE22
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 07:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25A110E156;
	Mon, 15 May 2023 07:20:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA53C10E156
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGdrocusph+9GimCwirTlEvBc1Ipo670uwoS+wgDjAPp7Uar9eq4ygD59s7i/tiykSsDf5qDw+tuG1efmaW6O/MaK4Qpv6t9hd1aQzfL0xOwRuAiWYslUxcVrLHZcVxY2mwjsuiyZsHCIki5AFmtFTzJN3yIcg/iw36iVCZNDHPmpnO5fIR8nBtwPJ3LKz2TspZMMCTgdy/3DKOZ2EVk67aJKdvQQ4fcdoJkXgTljhdE1SE3jxMiTbC00NdgVsNnaVVWIiMok0xROjvOOrwjOSMrMR7SvhE/rXex4anNDpQrF0CAM2nBGW0qmxwIFBJ4VZaVuT4K42tvQn3RZMgdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH3n+ShdcGRsMXd8d8vnwwM5Lu1te0shgGPnW6/bebY=;
 b=cnAWL2MIJG4rdAuINHJ4DOlE1MYxRvT/gpymEzmojOMjz1BWv6ha1VG2kc+q7qMUgtBdF27vUmaJ4JtbOsx6q2fIp7CFVP3zuWMzXzVnSKx8UMCfACjdVT9sXSWdyaO8DAktPO4luIuiR5Skx6hs+/mXoanPTipr4uZpzm8ZHt6q9hl1F2TdA8SPgVbf5z+NF594rY/J4Qm+x+80qDTgbD4Y/uKyoef0zAK/HqV5ylqN2LGXVOoXsB8GHg64ObppkZoLl2hA8AT2lHMsSlxTnWohJlM+Aly/tPexqpfLZYhVt4vB4GFXQy36wCQinOAmqhdoahTHK+Ln7ayut1PXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH3n+ShdcGRsMXd8d8vnwwM5Lu1te0shgGPnW6/bebY=;
 b=B5SHlp29Zfu+uW8CK+RLyAjvcr9Ynnavz2xGdjXc82QvQoH/skf3MqEudMibS2XNsueZSVaeHAFXMwtQfnAcsVrzua7n4T+H8roPOmO6HG97eqt2K5PUhaAmdWUUQySqgdt0WdWcUbj6zL04xFVOdW4/tpqHEQ5hT6XJfg1ZuAA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:20:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:20:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] amd/amdgpu: perform soft reset for sdma fed error
Thread-Topic: [PATCH V2] amd/amdgpu: perform soft reset for sdma fed error
Thread-Index: AQHZhv17FNDHeTQBnUydG/qO5Vat2K9a7WLQ
Date: Mon, 15 May 2023 07:20:27 +0000
Message-ID: <BN9PR12MB525723D97F8FCC17F34A052DFC789@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230515071658.1911808-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230515071658.1911808-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-15T07:20:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d001cb0c-c8d1-47a4-96a8-4292e58ca7ab;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6255:EE_
x-ms-office365-filtering-correlation-id: 761f156f-0551-429f-38cf-08db5514dbe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yY5zcPwwZ/sigjySxFGYsvRqSlScfehKpqzIHmBigy141xltaT4oLsz93OOdHjNK+QiwrX1ZzqVCTUlsTnVv4Jl9xr4c9nWwLeXiArBG9ZEqrJJsuBhaBUwG93E714yqALPsB1A+7ORH5ae1GRlYnhxaU6kUdwmuIFgMg9AQuXJcxqAq7h1eksZ53p1xAwpTamk7tCCUYA59xqj98LmGnimfWc6BCTtiyzDMUB/dcJ8bLUlKz3eAv/5e+IPFzntVN8DwwYM2PLE/L6iTKHEixu/73A0bnNI5KB4giWSsZx7noYeqHyoDf0Y94jIjm5M30uvdQBkcGr8SHYlmJZr8t8W+Rwxy6zMhc3meq4/NN4lJetEHAcxZa6HVjE1YBCJj7f32N7qLrbOaH/CFPnPzzQjJEtnQvMLbgSefORPdoX8fdxQ+KpVx6VvGPAXrChqC1jIa6se9/sySu/0YFrJT501XhRfVaGwc/KoleF8wMe+t3EHL7HDq7YglsfIxxOIcnKEtkdTn7igMpLk5EOa102MUec2HfEXa1xvjFJXvgDyfSakeZWm+kru+WwfjF05Vgf0I3rSP9t2WAHqtvjYBEX5ZAj5Q3jGJ6+L9d7P0mnklkj7i/qEs17+Yq6b7Pl0L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(33656002)(86362001)(110136005)(54906003)(316002)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(478600001)(7696005)(71200400001)(55016003)(8936002)(8676002)(5660300002)(52536014)(41300700001)(2906002)(38070700005)(38100700002)(122000001)(26005)(186003)(53546011)(9686003)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7AhAVBsYT0DietIFBAyDeMJZaGmOBbeO+MUAVTgokfX0swpM1LdwMGd+Oji?=
 =?us-ascii?Q?675FxziZhvroADSpXJ66K81TwTWKTX8BAOIrjagLYdQ7rLfnj/6Uw6icAJIx?=
 =?us-ascii?Q?i/4csQ9wcLNKUUZZOcfsXFNqkjJllFa/RYb6hSm1P2quXSXzklg/+RJsQUyo?=
 =?us-ascii?Q?ybq39G6N9yJdN93FzjtpPMeHOM/4alU21JtgMbX62a2UOCXHgWoXXa+XYFrA?=
 =?us-ascii?Q?9jhgXYPU32WrsAzetTXfe8Ni1tDRfhnhEdNqb7+JAdxcfXSoYGlFY3BSIJB1?=
 =?us-ascii?Q?V4aOe0ZqVmPkTYFxF0kPhyc/hF6LTMXNuoEYNa/iB9HOe8JUSFaKOvk5No9u?=
 =?us-ascii?Q?0B20nKLSKjrByizfJZlUUwliYHqmINd66N6z2O/vXV48vhs1bwF8l+LSMbtt?=
 =?us-ascii?Q?MDOh/rgjk4aF2tYUSpHmiXHGeS3AeVTUythfNefg5fYeDBgigzJTjEFBBUAk?=
 =?us-ascii?Q?x8c16ZUJjfStbXTK4PXJkRqPe9Zi1iWRU7rIoHkmhflGuVaTycmQzHbrzwT5?=
 =?us-ascii?Q?CeEiJdfFCw6Ew/oPatJsUV3wam4+5bwfpGOoM8N5I5eQfEnsH2/h2f0uDyt9?=
 =?us-ascii?Q?f/rM6mGOhQCNMF5fpAcOsGP1Xmm/yjLHG5XuDXw+XIydQhOz8HRbXQK1rxoy?=
 =?us-ascii?Q?a1rHLM5DJzpLjKDtihSag89bKzDwojRrMToiOcbgVC++PIRmWfDPiNSh7l2e?=
 =?us-ascii?Q?vy7YPp5fyzL2wVUoEu2Dk9tPiVmPR7No42qoSsM2f4csg1S/6g5O0GrH7oK/?=
 =?us-ascii?Q?c0kqYHNMRawQgYWUQeoX5/A+WsyZHFGS+W+PKzaMkoJB9tEzkUHrPTys1Ric?=
 =?us-ascii?Q?/Z5D8RweDSSF0vsbbYNbo+usJ1LkGQsiioUFyM/diNIbFMsdA6a1YBRspgHu?=
 =?us-ascii?Q?O088b2d9QozUiYKyddLS7RODhhooctgTzhRZiCKGtHLscy4LKyymU9Ljb23v?=
 =?us-ascii?Q?AmOtxxc/omrVvINsZAL0aOf/Pcl1Ox1nJL7qEIaea0CL9YEwMc25ys3DAFjv?=
 =?us-ascii?Q?dT2elGTOXxlJ24hRZG46reztU+CF0Sca+7hcNbZ5KDc7S6C3K0iPWk5puu6F?=
 =?us-ascii?Q?3WrHGeq0tb7TO/0xtQg8wS+U14DBlmhGIkH9Dl+JnaEYhsfsZwjztZfMzQHi?=
 =?us-ascii?Q?6QuxN7vkh2UAg0++LXhH5hTfbnN6BL8hFm3FIJHEkEYcQbs4nIlHXnK/T7+0?=
 =?us-ascii?Q?EWAFSPs3X+Um5Yu3mjm8oz+JZyPS6gtZneX9UI7Tg9DRxjkiR3Hlfj0LG3qG?=
 =?us-ascii?Q?aUK773zlfZuC/dbE4YULBY6mnA4xc8J9y/NSaz96HxpbuNRN5EtLNWgg2iPJ?=
 =?us-ascii?Q?IxN6u3elwQlWH+nPMbypu9Pnzce79bkU3wD65WGuNDjXAKy2HkPTMpqKBgLm?=
 =?us-ascii?Q?QLQslninIQ4D90r7Kig/bXtaHpx7C1BpRo5jsZ6j1nQ9goT5ionsIqqSO7LT?=
 =?us-ascii?Q?N7NpWfw6cAkwgIQFJJQGjz/rOd1sxLqIB/GXWKWU4cOF5c0EfLjLEtzZLn3v?=
 =?us-ascii?Q?Q7cE8+/YxmVjIis4Wz7YMMsmyNc/OPSifSkyq2BPrrbtIuGI+p+mQNFIBuT0?=
 =?us-ascii?Q?5x8ooZ/pUPQf0oXhAMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f156f-0551-429f-38cf-08db5514dbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 07:20:27.9722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7+sZ54D6jyqaiobWPuJJROcs2DmzN3UTQBvd6XnTMQ6Ixl5j+E0TzEWOr8TwQtJlLSe1UlBsucNhxkg4iu1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Monday, May 15, 2023 15:17
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] amd/amdgpu: perform soft reset for sdma fed error

When testing sdma ib ring fails to detect sdma hang for sdma fed error, for=
ce to perform soft reset.

V2:
  Add poison mode support check for special code
  path.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 3d9a80511a45..94b1364d743e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -53,6 +53,12 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 #define SDMA0_HYP_DEC_REG_START 0x5880
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
+#define regRLC_RLCS_FED_STATUS_0                     0x4eff
+#define regRLC_RLCS_FED_STATUS_0_BASE_IDX            1
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR_MASK    0x00000040L
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR_MASK    0x00000080L
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR__SHIFT  0x6 #define=20
+RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR__SHIFT  0x7
=20
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev);  static =
void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev); @@ -768,6 +774=
,19 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
 			return true;
 	}
=20
+	/* Soft reset should be performed for sdma fed error to
+	 * recover sdma engine, so when testing sdma ib ring fails
+	 * to detect sdma hang, force to perform soft reset.
+	 */
+	if (amdgpu_ras_is_poison_mode_supported(adev)) {
+		uint32_t rlc_status0 =3D 0;
+
+		rlc_status0 =3D RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
+		if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+		    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR))
+			return true;
+	}
+
 	return false;
 }
=20
--
2.34.1
