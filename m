Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7559C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 16:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E1A10ED0D;
	Fri, 14 Feb 2025 16:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ml1uu4cq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD6910ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 16:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g41A0CyMyO1FBhrTFaECHC/Ctq/yxgqjX4Je3OCYnv4xmBjYEJI8hTc+xxAtEdrhO/HLqMLBSXbgh81DR3JIe+QpXQ/ZKwHe3xEuxeUYiAParrgbLVqp+MtUZ+OGgFgfPxXuD2CwtmGOJbXI/jjxySYQ1V9eGKF/BnkQ61QQ02cypcOZ8XMfkVGlQZMJdxk7o5KjV4rDpDFJmQ2PLzhSCCtZi0G8gPFrY2V1JLJvPvs4JRmKifY9NEB8WJnS4jsS5ZzL6IBteywp81aXRv8CyZBr8zm1telm0AVsh7lbzl8VRv6AghWBsGxQ+BrZEXih7cVj006qvXq1PPXPr2xYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Lsp0QkorIjecbp3RtUZ9Fev34V4X13XuDsHgTIIT8=;
 b=mHQ+PUvLOeqNRx6EoOLJyfxXInJclbfnPBqhABi/d6qp4VHGZKRR03Y0HZAtvkZRabGbMbVRf7El7r+GX8lldZHQcxMu/WPMz4UQHNagLKukyRgKDUZpN/tmPDkgB06LGjtKpbsZusszzkAOPlCa9PQiO8WlsCeb7Gx9qV7XuHFwkBFcs1gwsX8dEiC/bHqBcJ0R0qP54Msb5mnDj4u0Bbwx69UQEoxfSFyMBiEmEPUVFT99bXTpANkWMXHqhnM8Y/SAwrHumi1K+XT9SWGnNrtMQXZeiI9E5+RuKoVDhOxG7PVmxvjDgW3T3LlmR01nl5aQkDTtNkAiOyBlLuSRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Lsp0QkorIjecbp3RtUZ9Fev34V4X13XuDsHgTIIT8=;
 b=Ml1uu4cqC73137VcbA2zeH9PRPhRVV7+UNWrzyUZgU6DgWEuQ2cQodqEV9HYXSIQg+DKYsd/HLWbLmGjanEhfQKavIq0XKJHO/4RuhjAbivTs7sNFtSXJNmksGxcLorB6leRB9Ql3BsqckenK8csHShRba8E7ijcy1yL3lgqbFg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 16:42:40 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 16:42:39 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPWIgUzoaWcYEuJkf8k/aQzD7NHANlQ
Date: Fri, 14 Feb 2025 16:42:39 +0000
Message-ID: <CH0PR12MB5372736A7B3F87297694A1BBF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
In-Reply-To: <20250214151901.2071738-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a9c3bf95-2a55-4ce4-978a-3a49253ca566;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T16:42:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM4PR12MB8558:EE_
x-ms-office365-filtering-correlation-id: fcfa3779-9ca4-414e-1370-08dd4d169839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7rk8LMsRm7mwvC7TtT5yKguxwDGqcdm1ziliuPr+/kuOD485Lx6tpM7IdtdW?=
 =?us-ascii?Q?HbY3tOtjbMxBNpdIKm1w5Pve3E4+Uqmm7J94eQ07ndHgy4O5elgOkE+bNk3/?=
 =?us-ascii?Q?cI3qUgtDJbV1/0XYhDQIVzQIfM2H4R6/ptRkuQqSextnr+LKozF7T/RxQUn8?=
 =?us-ascii?Q?AarehvyTmLJ3Fi1FBdUp1ls5tCY2AG0V5XlzCfgQ+j5eIh6QKC6uK6PwaZwY?=
 =?us-ascii?Q?X6ZbxBl3o8MwKlAzIG3PZsauS3cZVNyAoZ5RE9wnrbf/wGfN0vaHUFn4J2BE?=
 =?us-ascii?Q?AvsTGCTG7ZbqfxhAxzIGvTsA3ScRTb1YhaOLTR+cUkNJrzvwh0OJCTgykVON?=
 =?us-ascii?Q?Gx3BcvocyCm1fbb8aAk7tPtGPhqPhxRxBxIjAZhbOVtfKud3XUroSL8MyL3x?=
 =?us-ascii?Q?qfwfaYY6cjtMCLc6aKi2uey7dGw8wsnXSAC2TK84PXLct3LFL8TKaz+yDv/a?=
 =?us-ascii?Q?z6SLP2qtnxR9b/Xi7Dex/dml5PrkF3rbk1VG1ht1QM3ooX119fZM9bs1YgH/?=
 =?us-ascii?Q?Y5GzKQQIcEH8fT635YL8Scvy73uwtUCOQT+RhA8jkzRsZ4wMtd/3HBvWYvM7?=
 =?us-ascii?Q?n9wounxK7Jg3So1tFvnRDzkk+RqCf4jX5RpPCqHcW3YCeddoYqVs+dA8oC77?=
 =?us-ascii?Q?AGaYBW6/A1tn+kI9ijc7PAUR8Dbi5jEkIVECJHdT3esdps1CiOekftgIirCp?=
 =?us-ascii?Q?W/pubEHLIoZxGWH1HTFhmvr7gNK5j0+H7bWsZWt8mED89+LmezD0JQ/xW3Ow?=
 =?us-ascii?Q?iZSwaxP+h7JivBibZ/MvIU5EGATvNY7VWELKmgM5Z2stCAYOeWsy1SdRuH+R?=
 =?us-ascii?Q?AWERcEK4xz8Ewql4UR0prBeufZtiOD4kS1zEtVISqNaS3kM+vVgLTksNxoLi?=
 =?us-ascii?Q?GQwoogXZUIl/OP65+Z4FlzIKO8tqBbSOjs+/Ev6wv7ojwKX7mq6eWI7lAk1i?=
 =?us-ascii?Q?fMPOeri+7i2MbLpTKiIft2soYk6a+BCvKgu6qyE0+ZLAA1YODdrK7JwlscHH?=
 =?us-ascii?Q?ARzxHImceWKMttdctttitrBiNbhDC8bfPcyH/bMzQahiInn0M75R3aLUTefK?=
 =?us-ascii?Q?8UxEd/ln2bP7GpGlsdBj9OYZPg20gYfHnJGkEh+39ILVUiKBOTKwj1ZQlQGc?=
 =?us-ascii?Q?kbriWR2y9lnrh5nOS708kQKmIT1pfvccLfPleZ62fVENpKRr0RCNyqekR64i?=
 =?us-ascii?Q?FF1Ydzpr7xmpwzyIuwz2S4Ei+m4uRJqk0BdaOVcT3kxa7zbw+8j2gKhIvFl7?=
 =?us-ascii?Q?zB63LU2rYi40kGzFzHz24yMU4ONLr6rOaaMmZXwvQTZ9Faa4Trnd1PciWu9f?=
 =?us-ascii?Q?KjbDqQd8it+EJAB8GW0xU+onv3Zhz+Zdx6da/Z8dDnqo68ZOtSBzFRY9aKNX?=
 =?us-ascii?Q?Ue60J3HgMnx8eJB/ZJlbnPKnvHyroblSMpSbB+D44i1URzo4f39Sj8Imbe3b?=
 =?us-ascii?Q?26yeXYHHZreGWaQcorkfuKAq428bron4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xyUSwquabYWvOWvSVSJ24Ow3qZvedCHzlZt6K5GjQo4m+SaeBTQtmWZFjEC+?=
 =?us-ascii?Q?ZZ/iXKCAacIrzbOhJWgvVtIIf9ghr2lTl/A9VKxM8Jjzzbewb1R7SOWEdMNY?=
 =?us-ascii?Q?Ktjek5n3kkfMN6sNa0V6vXlDaXjIvS9n1Ld151p5FAPlqu6DdoYRW59Kqb4s?=
 =?us-ascii?Q?n5I/AwzaVnNoO8/LUyQtlunbHekMS1zVRH/BTe/nHIgLNl9D99bBkxOalOBl?=
 =?us-ascii?Q?nvrQTxrWhEN7HciJlRvNIxXwjeqbrXgs5PebQxuKdZK1Xb1JuCLIn7NfvAhc?=
 =?us-ascii?Q?WJJPYnt7P6iLyB9WSRTg43vtv7XJZPNdH4s4K+9XMQqTdh0Hg5TZCz+3Zl08?=
 =?us-ascii?Q?TRSVOG23ewXggUyINoByAhmCPVHR3ZRnWq9U5xAIuYWNupRDzarwFy55BhTD?=
 =?us-ascii?Q?IdbQXODdxed1hEbvVsHMBAwoblW8PAfqzTmy9ChbJxtauUD3fHquV3Fs8LdT?=
 =?us-ascii?Q?3UchJ3JyfJgdY2D/gepuYu11sxZt2Q6eeeA/69xgwf4cUqy2/ywSTnkQ0jYK?=
 =?us-ascii?Q?K5Bp7bs0wq9utLcjVr4zb3NexKyQ+0A5bVbsVAX12l8Sq+SN4Rm9tulZmAdx?=
 =?us-ascii?Q?M1HzH2XjnBCxK6IAfdc5AXP8ZTXoGelBm+TNwY22dMGn65SNkO0jpoVtuveg?=
 =?us-ascii?Q?EU1wsGkqNSd0WdLK+NUoGFYuYjUO4EBY2H27N85/oq15ZmSoRYCWyH7S4wbl?=
 =?us-ascii?Q?di5JczBfCIcER27csvpphMl3278qrpbdcVGnP7vFSWTyUgsMujt6jqJoWu+O?=
 =?us-ascii?Q?zb4KZp9DBHGXO0rPWzF4o08Gn6FNJSrWiDp/UdWLNIE7u2R79U/Og4d0JFHk?=
 =?us-ascii?Q?42hW7G9eqFqqvHL2BPlgGE54k1K3fh3qtZEzbH8KlUkYylEK0Xz1lWhyU6zU?=
 =?us-ascii?Q?GubTVs1ESg+kY7NK/RcYORA9PMl5rqbDn7YhuR1JLcvmaY9lx13q/kiHVUT5?=
 =?us-ascii?Q?rr/vAgP1ThJ/rKut79W0dkfmNiviFVPyf6IXj4j/ds130411ciXGvI//7Wmy?=
 =?us-ascii?Q?jzwmaPs4HIrmBRj8IZiMqw4i3JEjRTYRkiTLrJBPk58WmvGIFA77Ac1TGxqS?=
 =?us-ascii?Q?aepGacpDYtq0lDr+DR93WanooHYqw+RGLTHG128umdV88jxsrmECMOryzGTU?=
 =?us-ascii?Q?qxTjU644NUSrmXHSrjnKVP8R1WMBI6OFMhXHJBJqZ0f1Adjwug+8r3JFvw5A?=
 =?us-ascii?Q?cPEk8R2zs+wEHQfRjLzxicWe59xpse6tI1jU44oPK9qzu/H2jQIsH+M0GsVV?=
 =?us-ascii?Q?+XHtEKncA4R20equwMj6URfBP+cS3Wx894l66Hh4oe2+tILZga3HrL12wtvS?=
 =?us-ascii?Q?DSm6jogUsK6T7pRTcx4vKriuHVQyFGtJfeAMoDVMqnNrQP74OE0eudu/OCRP?=
 =?us-ascii?Q?t7C1IyTW2ias5CHI0zDXmQUeumpWN7FxWh5kOFDdMPEzDH2l0nfkJp/IiRix?=
 =?us-ascii?Q?cGQiHeo07f0zMII2uD9KUvXcNOIsWNIHrXrLU3msE9FSHuv9fNIqt0Qub9PH?=
 =?us-ascii?Q?Gwl9EBijtwidQvxohuT0h/gMyu5+kEYMoQuk18oBiTByxTbJSxGB3gOBAeQF?=
 =?us-ascii?Q?uhdyuoHxiv/hGk8lZDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa3779-9ca4-414e-1370-08dd4d169839
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:42:39.4730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhMy41CoKXjG98m/5/4UQ3LaBy1ssDmQhMg/LV4He1LVlS6l93ZfD4dfl2DfYJhvpRiIQ4hDBldUmT2aC/q7fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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

Looks good to me .
Reviewed-by: Shaoyun.liu < shaouyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 52 +++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 26af0af718b5e..530371e6a7aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -64,6 +64,7 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *ad=
ev);

 #define MES_EOP_SIZE   2048
 #define GFX_MES_DRAM_SIZE      0x80000
+#define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)

 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)  { @@ -743,1=
1 +744,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)

 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)  {
-       unsigned int hw_rsrc_size =3D 128 * AMDGPU_GPU_PAGE_SIZE;
-       /* add a page for the cleaner shader fence */
-       unsigned int alloc_size =3D hw_rsrc_size + AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
        memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));

@@ -755,21 +751,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu=
_mes *mes)
        mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_add=
r;
-       mes_set_hw_res_pkt.mes_info_ctx_size =3D hw_rsrc_size;
+       mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURCE_1_SIZE;
        mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D
-               mes->resource_1_gpu_addr + hw_rsrc_size;
+               mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;

        return mes_v11_0_submit_pkt_and_poll_completion(mes,
                        &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt), @@=
 -1442,6 +1427,23 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *i=
p_block)
        if (r)
                return r;

+       if (amdgpu_sriov_is_mes_info_enable(adev) ||
+           adev->gfx.enable_cleaner_shader) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev,
+                                             MES11_HW_RESOURCE_1_SIZE + AM=
DGPU_GPU_PAGE_SIZE,
+                                             PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1450,6 +1452,12 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (amdgpu_sriov_is_mes_info_enable(adev) ||
+           adev->gfx.enable_cleaner_shader) {
+               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.res=
ource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+       }
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1670,14 +1678,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (amdgpu_sriov_is_mes_info_enable(adev) ||
-           adev->gfx.enable_cleaner_shader) {
-               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.res=
ource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
-       }
-
        return 0;
 }

--
2.48.1

