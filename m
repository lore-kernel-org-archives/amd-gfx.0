Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29740CD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 13:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F9410F16C;
	Tue,  2 Jun 2026 13:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OTcrIFWk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3CD10F16B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 13:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs5wXZGaW57m9cAKO8Fkp769PQShBpuKyJ5JsS9I9K4hAIkd+NwioHo/W7ZVBewHmCOp7g25qqYoIiaatsaik4k3n5WAkG140M2nbzGkVc/uDMK5Ra6u5Gjn22Y5V7w3Vt30KbvFf6xox12oMIHc5/gflKoBdbIcoLcvXt2885hvNxZv0UCQ/6Y8VLLTuZQhNaLJDUs4flMKOu45CYRGipGlcs2QcTF05YShRwyn2FhFu5Vpb0zOLMRmf8Zfy+Th2yDdCpyKs+kxpwFypU8iH+oTi5EVdsdyWgmJnR1rEzcB0LNFuCSx+I1yOeZaWOo7nULhAwXpoSOOC0ucmiQIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICqGsJlDZ/iJbQmOhGLkZcbSHjC78/XbKmaqnjag+bw=;
 b=tbiy0lTrB3VtB4tN5NMG6BzVSBZRX3TGDS3WLdMBsGSwuseuMTa9PHTsQHLR06wmq2iQJjkIBE69evWizLPNKYYeM5NBxh8hw7VXGaLB6uZ/CNKG/yhsFiUU4W/JBvSwtej9gVdUqvFMNeZlmKRk8m5JnrScKGE0ULXn2tDKVlBIP2fDdIAUbBFolhMDCxUWXwyndP+GaWXBm5HkWN1FBFE1ym6sPG6/nhAgUooNl5BxAB741jFsJAj3DnoRSQtiuVL3sxgaIZQRzFm6SpCTvwkPbPqDBN4g43Kl65EXuQDNaqGiRBzk5jcPBYuSYj5lOtgv/nI/MsdgEwIWM3GeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICqGsJlDZ/iJbQmOhGLkZcbSHjC78/XbKmaqnjag+bw=;
 b=OTcrIFWkqGWM53KBE5A7P9zAXd9ZhnbcpYIrpBdgr3l1uzlSLrdhLR31v6HSHYPXD64w+tXkdCiwSRgcFbYTLSvuKHU2q6oPEbCSFJ+z8lN+qWZ9zqUtlJuMJHQ7xNfPu+YEAQCB8WrDtWcg56DT9B4OEYGWzyvnzBKqKHLQqMU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 13:54:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:54:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set sub_block_index for mca ras sub-blocks
Thread-Topic: [PATCH] drm/amdgpu: set sub_block_index for mca ras sub-blocks
Thread-Index: AQHc8gopu0ukMd16C0ak75q6nza7GLYrSpfA
Date: Tue, 2 Jun 2026 13:54:52 +0000
Message-ID: <BN9PR12MB5257C44D039084428363D213FC122@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260601210323.493076-1-Yunxiang.Li@amd.com>
In-Reply-To: <20260601210323.493076-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T13:54:30.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8237:EE_
x-ms-office365-filtering-correlation-id: 73f7d77f-77e5-4648-e462-08dec0ae857a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099006|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: p8SSfsrxg29wq3ru+e/aE59mFy0v8c5WeyKNYhtwY9YIHChnjsJxSmRrCPQsFngC9BAKcljCtAUrx7KTW4jXivfJexeDhfczk36E0UhVIkrdmEax4hu/6mwJ2sOURefZ+JcuWBCdZXMGCfYgjmBOQZSCxi886OvpbrucDaZCoFeglFZTu2gcovlC3c3RqCLVHy6/yPzJNsO3AnS5lgI+O3nKEHqz6s/NRCh3iGQRIseoXH4KkRb4wmpmqb0da17XVXKnxl5gV62lz/mEzne1c+MJ3uvNIhbI0f4C2BjZCvbleVGVRJo7bEQYHBNikPAFvHm+aNFKAAqVqn22eEN0luu5BDmmHFA5mwBnsbVhxgb6cC73o9PTBCjQbpp8QjwEqOxa28t3Fvp6/1C3ONZmGiG4+EjrODouDK4i/3wZFahF17ybxI6+JjA8JOFy9GrZbu7CjqlgXVGKHGYQ3DzGPSolSGrSqnJAHYL/21fzK2mfuTaf0YhJbvVJRmIRFyx8ijepfup5beDHslvqsZzVvN7UuQZ4qpAkYg86TxunOqSkWDt8sw+tx7yIHBPLK0MR11aGB6z1u8Qt/1tiloEQLJmUCSLAvOGe5rUwRINu2Y898fsEZgrWqvg2PnUIGRLWp66IvP3728/uxzaPbTbfZQMEOpWTZeUemaKuouYXO/i+fbLvOhBqEvCjwHENNJi6BAIGc7QAGsVroqZWmFyaZxRbDBV14GA9Hs2OAbwkR5sB3hSMr/CpkVTo+y9i0Zkd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgE8c5v1TLUR8dNKnl7hTsY3y/ko35wQL4M/HHuUaFVzIjK3He5AcXFxzFWd?=
 =?us-ascii?Q?P9dE5IC2JtHEJqbJ4K7Wv89vW0y3K7OcRRuasYCUtTi8iv3hBVoE3BITK+89?=
 =?us-ascii?Q?IXNl7Ocs20th4QaZesYwGEa/vmmBcF9sU1PRGjW+U+8APeniRtqYUuOvSduH?=
 =?us-ascii?Q?k1SCYgcKBrr09Pmd3pugv57SeTnI9M6UHzj/Ml7uEqmyI+mxx2CBmBmPzOoF?=
 =?us-ascii?Q?TPuoEHOR9A8Uyk7OxQOzj4KLk6xDzCctsiOdMIpakbEFlVKPt1Hxkv6QdfZl?=
 =?us-ascii?Q?IrQnVlOi7O6jzeoEaR1QY1GdP+ToYnUogaZgG7nNuiE2HshNE9l7nTDGc0b5?=
 =?us-ascii?Q?ejE1+RB+vVSO96M95JsiHsPNrIxOf2rfad4uXzMPY6Nc3GFbDzS71fEFPlZQ?=
 =?us-ascii?Q?830poHi7jLIBAIdgKagzmlGtaKjwvOYa7xAMniK6Hf7q5TfH7aAfqU2fr56c?=
 =?us-ascii?Q?BC0v4vEEn1TAfoceyaXXDh9GuSfNsYoPgKd/F06j8i7ze7U1vkmhQO8z2Cg9?=
 =?us-ascii?Q?vOfLHQCGGPBGJ1MPeIbjXfxP/4j0oaQ1TNvymxVEvkXIEbqyVBn+V06XEZF9?=
 =?us-ascii?Q?LvcUe4zk3+GtHWclOXyAC7OX8jsnGFyaEVSrwaQqRf/KCjIgGbGvNjDcRnsk?=
 =?us-ascii?Q?LRYManF/zMk808rWG7a22yI1XSyM04tDXqWsClEwbKR4ygVbyxwaf1gQK6j4?=
 =?us-ascii?Q?U54SiaOH8aPJ1B+jkc3ic1+I65/M9JEQmXdcbCN9FDFjEYu8ti8pGg1jv5EB?=
 =?us-ascii?Q?k+F78q8ZVYKZ+ZK8gSdnBypbZQHQuQ+DNXDNq638cFex41K5eq12JMpzsOhi?=
 =?us-ascii?Q?x2SYAt3morP1cfzP4AGWNf2gS/IiYyGJJWvsUzq+7WMJ347C4Pn9D9AoW9m9?=
 =?us-ascii?Q?JCayYd4eWwtmXYSh4AUNioc4CGIzrWUfWVINVVXkUNU162OSMwL7GzTGDmGk?=
 =?us-ascii?Q?tQoEAkw9q9wae9mTctPP6y+IiiemRH+kWz9kvK0z7MYYY2Sol6GipWtwQaER?=
 =?us-ascii?Q?X7TevTv1vJSuY0BqBAshMd82xbZnLyBpzzZIUX5CWu365qr8UTlrzYMlROxC?=
 =?us-ascii?Q?Er+5sJm5TVWXIrpZ1m8Wsg/o8OKpEOzuaBX69Z3lbpMvjF8Lwxwbj5Jyvpa2?=
 =?us-ascii?Q?kehERSVIOvdXJeiH9IP8nr8d0vDFvayCC+yt6LuDh5Mi1HTxRYNAr/Gs+d2b?=
 =?us-ascii?Q?QZ5c7vytNGzWU+5POvYqpgZY6RYvpxzRpteo4gOak/5pVFkvvQAg71w2VCfH?=
 =?us-ascii?Q?24UmPaDZrgeVoPdSqRugovBvdj8n+tk+YUe1S9SQq3wAoekNKEF+EaWJyl+p?=
 =?us-ascii?Q?GcfIh2rGAkCawZTE2kcsHeIxZJnmD8I9IN9Ap8eyRYR4a73hkLzaHc89RlFy?=
 =?us-ascii?Q?HLTQiSgpwKiLqea26unfwthh3nxGdWZ5A7JYPb4+y8HEh/AUJc5nH54EErA6?=
 =?us-ascii?Q?97uS3GdmB1Q3VAalhBbjK4tYCCE5sxqi/M0BNT3UhVHjPPPfTtxani+Xd60P?=
 =?us-ascii?Q?JtoAzWReTjHmFV0fLz5SIOX2YUyWpTLMxdkrZ2dt2FnzHUu0ZvqBiHaHW58Z?=
 =?us-ascii?Q?GM8sQg+T7wTL5cIjKU29mME1auyl4s9TJ1S3d6+ws+5n9nzlLtProEeADkIO?=
 =?us-ascii?Q?pTIrtNVLSEWuQoD/78QWz6atB1jRTa2qwe3hi5nmXgttrCFBu85xTSsSeNhk?=
 =?us-ascii?Q?rlFeO+wXBQqDgI6oNd4VTzkAB6Rmun57qLlYk50DXMHAjhe1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f7d77f-77e5-4648-e462-08dec0ae857a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 13:54:52.9294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjQN+oyBx7wemVqj3yrfn3U6qUVcP6lPudn74y0cgRlcKtF6xB1tBNZb6J9SXfbU6h4FSV2Es/fep2UnZcuePg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxiang=
 Li
Sent: Tuesday, June 2, 2026 5:03 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.co=
m>
Subject: [PATCH] drm/amdgpu: set sub_block_index for mca ras sub-blocks

The mca ras sub-blocks (mp0, mp1, mpio) all share the AMDGPU_RAS_BLOCK__MCA=
 block id and are distinguished only by sub_block_index. The ras manager ob=
ject for an mca block is selected
with:

        con->objs[AMDGPU_RAS_BLOCK__LAST + head->sub_block_index]

Since the rework in commit 7f544c5488cf ("drm/amdgpu: Rework mca ras
sw_init") moved the ras_comm setup into amdgpu_mca_mp*_ras_sw_init() but le=
ft sub_block_index unset, mp0/mp1/mpio all default to index 0 and collide o=
n the same object slot. mp0 grabs the slot and creates its sysfs node first=
; mp1 (and mpio) then find the slot already in use, so
amdgpu_ras_block_late_init() -> amdgpu_ras_sysfs_create() returns
-EINVAL:

  amdgpu: mca.mp1 failed to execute ras_block_late_init_default! ret:-22
  amdgpu: amdgpu_ras_late_init failed -22
  amdgpu: amdgpu_device_ip_late_init failed
  amdgpu: Fatal error during GPU init

The error is currently masked because amdgpu_ras_late_init() does not check=
 the return value of amdgpu_ras_block_late_init_default(), but it already l=
eaves mp1/mpio without their sysfs nodes and becomes a fatal init failure a=
s soon as that return value is honored.

Restore the per-sub-block sub_block_index assignment so each mca sub-block =
maps to its own object slot.

Fixes: 7f544c5488cf ("drm/amdgpu: Rework mca ras sw_init")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 3ca03b5e0f913..e1e4a61b1301c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -99,6 +99,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev=
)

        strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
        ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
+       ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__M=
P0;
        ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTA=
BLE;
        adev->mca.mp0.ras_if =3D &ras->ras_block.ras_comm;

@@ -123,6 +124,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *ad=
ev)

        strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
        ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
+       ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__M=
P1;
        ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTA=
BLE;
        adev->mca.mp1.ras_if =3D &ras->ras_block.ras_comm;

@@ -147,6 +149,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *a=
dev)

        strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
        ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
+       ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__M=
PIO;
        ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTA=
BLE;
        adev->mca.mpio.ras_if =3D &ras->ras_block.ras_comm;

--
2.51.2

