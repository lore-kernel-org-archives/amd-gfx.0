Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97CCF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 15:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DEB10E2BF;
	Tue, 24 Sep 2024 15:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JoIuMLQ4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8DF10E2BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 15:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvMkNspLCOUJXfnKBVsJVaWuqABxFmC3Np3c7WADaSUZVMCCjYhL174GZeaAzHOskX26NjS/UvNKFTjsvBY848V51spj/xClK9QxBIozwRpof7LgTVxmW2EmIZSEJX2r65zcUn55Ou+KR6BhbedDKVCHUI7DY399ZoQFQ/qa9ocs6dSSbbxXsBeayL15q2k6vj4LGrGT0jf+pWf52ZgwB5U4oJWE5gpwlYmKu31u79gP+1OnjuMeUd935hcBgQ3q9NwguxR2BFjRuEYjgpTlPE7vjmVKhVMOIKO7BPz4KNohYglIAwfFaj/rLmjWvJh4asfTuVs7PTAjRgX5rWTsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk8iD7j23tWVNR4yezFhvQGtsJwjSmi7DOx+51bUh6g=;
 b=i61iphgETk6a5O5m4u4f/uhEX7xPsaRzcsHjI+odFPVExVsJhGzPXbV4Y4QP1eW4I5J98yCrLiyCF3Dc86oqUGbyvBCbsvrJ85TXICcuTfv0QpaPa1Ft+pRMuNrut3TyGHJT54nK3p7V3nXKKc4loqRh4ndmOKTFpE/Xd7lnzF5A417YpGo4hdPgxcrs2Slg1GA6qskWGU2R1KN8Q4gwQHX+Gme67PEUDUP6vGS8awnO1bXzreZ7jk4irxIUmmQd1FmmK+0LGv2Ns3sTN8ONxjzOzUia3ehN5FPSyD3NWvQII/2d/H3p1w+iFF1Zmc+fmRM4xPlrGP7z0tOo+eF5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk8iD7j23tWVNR4yezFhvQGtsJwjSmi7DOx+51bUh6g=;
 b=JoIuMLQ4ftoUNzlM//B/aR0n0Ax7ikRPfSgR/bCMGJ4lbzfmGC4JNAcpgfcNo0Ia6j/PANxe/fZlbPjEZzWkCXMX4ZXKSDPwObOQFMpD7gh4MH3ypX06lwuYQL2MjntRYAtLHlKHIsX88Gt+V+w94GP293G2uCcBIrfwV0kzOng=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 15:15:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:15:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Poag,
 Charis" <Charis.Poag@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>,
 "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, Daniel"
 <Daniel.Oliveira@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amdgpu: Add supported partition mode node
Thread-Topic: [PATCH v2 4/4] drm/amdgpu: Add supported partition mode node
Thread-Index: AQHbDoxU5AEvP+A4+EyCHXYOR/+b5bJnC/mQ
Date: Tue, 24 Sep 2024 15:15:25 +0000
Message-ID: <BN9PR12MB5257EC2465AC90D8989CFE15FC682@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240924141549.244754-1-asad.kamal@amd.com>
 <20240924141549.244754-4-asad.kamal@amd.com>
In-Reply-To: <20240924141549.244754-4-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ae18acac-d37f-4876-a80a-3d51b17831df;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-24T15:15:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6088:EE_
x-ms-office365-filtering-correlation-id: 05cad2da-2178-47f6-06f0-08dcdcabb781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f6vWIGZt8fE+/Xc2zLsQCSaHDfeiqj4Hjv4ODm39rTtHWscARWk1coeNXh2z?=
 =?us-ascii?Q?Nx6UxZrH0IEEsaHwVvPpIUqdSEekWwk0ePKkT5cUQm8UKBAP+l1/BFDy20xV?=
 =?us-ascii?Q?UdPt53S9l8SWc1FNoAlMgiqjyR0irB9kTYn6Ac0TCMEnTT+c4YLUFakHaoUf?=
 =?us-ascii?Q?Z0r/X6yKxvTeHEHtMRd9TyLJ/hzKNn7BeHqPH/nlYGAcjLbdGL7uBj/J7oyb?=
 =?us-ascii?Q?69UQK65ioJRIWMJMhq3AqRF+p8xLYjH2vSKpmTP9gch2H6nlQHlFSkF1jkSx?=
 =?us-ascii?Q?agqmTkhUy0Y5rrHgtv7IgDUPep9mIcPWxoiiE3nO1UVXyjfawoPs1hvRhP5D?=
 =?us-ascii?Q?vPD2V2gwKoROQzU48PMDHEuGLm+oEfvJ2EHh+BRmBCNESxxptGdqW6yH0sA+?=
 =?us-ascii?Q?AYtY+nTlhuG+BqgvQrfiC6bTYSHVdJEGgtxPTSuYf1N1pflHWQpVocoxM/+L?=
 =?us-ascii?Q?QdF/J5LdY2rXnXGssF/ZxvODtSoF1DuCOAyOVd4mP9sjSUJ3LXz72azjqQ+5?=
 =?us-ascii?Q?ajtq/Kzcv5nVIY8cAUxhGxO3l+7FxnmXxOOi1zmzEVy/uOk8bCpqJuc5LWom?=
 =?us-ascii?Q?aYsTj2hZlMAqHptjayby/4L9sTjRe2q/Ix3tsLtA8NV4EOli20vD5NTqiPTp?=
 =?us-ascii?Q?AOzAfAVETv5mK9fgA1RCQ5GLNZvTEgJEWMhoE/SM3w7b7fl2JDDNj8cIB4jD?=
 =?us-ascii?Q?a+lyXvObejShjaipXjM56Tjnl2/CRfVYWB4Zykeh4wpom6sXcdoq/vYLAPko?=
 =?us-ascii?Q?W+dZC0if5zjgyyXoRgbU+fyXMkyniCMo+POGVQZuTB1nqi+yEiuczR1gC7n6?=
 =?us-ascii?Q?bh13rNwSTn6A+8TT+bBB+rBPXUv1FzNj+nxvLtHAI7rlP4U9pLxfjShHnzem?=
 =?us-ascii?Q?7kYQ21NeJMn+TQ9D/WIcTSpoDeEK3/tIns3PNrTqtJEHzTTQjkI9XLH0QYHa?=
 =?us-ascii?Q?hJ+ZfbzCoA2YQtyJuddbjEykav3T77m3LLMWArvWUVXVJtuX4bMeuospaRzs?=
 =?us-ascii?Q?n7J3k8aVhefozV5N8nOG5oW0U3K/GFDelkU2bYtpjl0dChnzl/MO1pVpUn0c?=
 =?us-ascii?Q?T+C3K9tQ+HiBpDZ0hxA1NdKbLIXsY3pk1Q0tz0NaXHXTLoroTGefllIqUOTC?=
 =?us-ascii?Q?O6stXB9Pf+qC3vxAqRAa8ese/dW8Hcp/BxucmggDl907fHVeEOovQvjaDqaJ?=
 =?us-ascii?Q?VRoJF97vlcwyLk0NbDvDULk+ghgNugd4OAQGen9LtlqiEt2pJcxKQQvhawGx?=
 =?us-ascii?Q?7cmaZ+gS/n/4t999u7qDX2+J1umnes8CW5cnKL1/sJGCilXzAR4PDZyoK1Dh?=
 =?us-ascii?Q?95pcqjNl3CvhelNTvdkBcE4fgFdty40YLSU4qS5z2iVfICYgVPsDNVct1U4d?=
 =?us-ascii?Q?A35j8gu2oaYM+JzzamJAwajjTeteb9jG5vr/5il7pEb5KvhcgA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1nJwNMXSSZZ9+PJmyJZVPb1IraDysmEmZJtokLKpvBy1PKqEKzaennELOfp?=
 =?us-ascii?Q?MTTeXjxdCWe473KlqNg4BDa1/Hk+FOmaulqJ2eLIENTUlghfkq1E/NC88wUT?=
 =?us-ascii?Q?FHfonInptpGx54fJeAUxD2ETp5xR1cmBuL/4sN0gdhNnCUaklY2wBRjHbyxB?=
 =?us-ascii?Q?R4NKaoqr6OhB3IO6DUeVHvjhIHunR/3dTC3ANTkwCLH/M3ecqMNSOGDnSHk+?=
 =?us-ascii?Q?BSbhCUz6rkoicAnnvjV1mAHC9b4dmRLxh/k1sC7dPdMEMp2hwegJyF8PC6WD?=
 =?us-ascii?Q?FCTeFW4VnFX/ehKnNg1Y5EVBpW7mz3+MhueRW/sdhAe7BN+qELWtpgNsu8d0?=
 =?us-ascii?Q?85TfvNZO2vq/ed33xIu7Mjom/1/86iFjPUavhCmVUo5ve9ju8nBg/76a0g9g?=
 =?us-ascii?Q?MyP/h0DSiavMvyFpM62Joh9gKIxDGrAd/hdDkfDwoPF6X4Jg3mIWYCEFx0s4?=
 =?us-ascii?Q?T9uaL0IPW1kYFjBN+DV4zaHJInQaTyc7Ccn5fSxmC0Q5lhqlWE7nuc9ybFl4?=
 =?us-ascii?Q?AEriSBwV/jhtgLPF+EhHsRIS4Ar/UX1nci4N4cR2HOARmdKA3jf6XshWgapJ?=
 =?us-ascii?Q?BhFBuO0YDd7PV4rPTgzLAvT//BAQeKw4k3cfO/+A/mZlD67g547sU6IetYdL?=
 =?us-ascii?Q?Fsp97kj8U/sTTjFZwZ6bX89RKvhcizLiBBuqugI4di574tiuW8qaghR3VF11?=
 =?us-ascii?Q?vtLYEl/sYRF+q8rH6G6Xffrimh0hklIlEmHp6VgccUwwcYi5Ln4gKgT5ymAi?=
 =?us-ascii?Q?g7QM2fQMsWTRvI6jpmpJvg2fGWv7uzd1Ycrm0ij4RTC24ZKKmFYbY6hUKmQ/?=
 =?us-ascii?Q?64cJ8ifHRMG7RT+OCx30BNwTYAlE5TsVMpmQ12xXg2lvEbcjcPKksf8NS3AP?=
 =?us-ascii?Q?TH95NfTDW5d0GbCLP6HjKs9Pf2p7H8nhVQoY0L4hD3sx9FmqKc3mQTxS/Pol?=
 =?us-ascii?Q?gbwNOMLuxX3OFrgHX3gcvYyD2SlqHlpZKEdIpMoBEwCeq9ovW/7JrknC6jTR?=
 =?us-ascii?Q?BEYQY22vYZaF4KRgQ6CMzdEI/k/M8zF3g/L//ilb1gXKlOgVC8/Yuw68Nba0?=
 =?us-ascii?Q?AUZYkfZ83BpeNlBzJSWvKmQ87yQgaxcX0OBtON6S0y+k7a53H7hoH6/dmP2E?=
 =?us-ascii?Q?1YSVEZWXDsj6yFFKUaTvM8mGJdiIhJyM3g/FAXdvs6KMCekqFVbxcskzNfy1?=
 =?us-ascii?Q?c0lrqW60ybaS7zbXnrCw1Jsi3snNtx3AwmPXbHuFH1H8DoJebxY/E/5944hD?=
 =?us-ascii?Q?RQuRgE9JJONARdSYSX3A4dYyyK9Sqlu/ajPtK2m4/ks/Liw1wqv8pR6Aw6bK?=
 =?us-ascii?Q?Qh+hSi/6+YDyKT/tU1m8TkrB6XT/SxxM3QiAz4jU4AAVYBexj9LvqFyvOqaN?=
 =?us-ascii?Q?L3oJxtpNHBqFB/HsdswS4iqaHxN8nioIsvL//yoSQQV2+Q+H/labeh+q1+5n?=
 =?us-ascii?Q?IHgvFqDkBw5P6u5iPPYkowBHkV1JZzWeHHDEHjGssJpRA2sxHRxN3Zgem36z?=
 =?us-ascii?Q?immjbT4+m3tpQVrXoDvgvs2xJ0Xo1Mz/wirduwsYWvaZVmogJvysBOC67eJ8?=
 =?us-ascii?Q?bwF5x6R8NryDWGFO9V2LvHzEPyBC6CTgKW6So2tO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cad2da-2178-47f6-06f0-08dcdcabb781
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 15:15:25.5587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zy0lju/hYSZgqsMG91A4k0MI8SqgVy0JmW7ZP1LTzbl9SVLqwc0ngppX3qyAbsnWEQFv+1M9aVPyfd6Uv9jy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, September 24, 2024 22:16
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Poag, Chari=
s <Charis.Poag@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Se=
pehr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Add supported partition mode node

Add sysfs node to show supoorted partition modes across all NPS modes

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index fc4ab1d8c7c9..10daa6a15e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -463,6 +463,14 @@ static struct attribute *xcp_cfg_res_sysfs_attrs[] =3D=
 {
        &XCP_CFG_SYSFS_RES_ATTR_PTR(num_shared), NULL  };

+static const char *xcp_desc[] =3D {
+       [AMDGPU_SPX_PARTITION_MODE] =3D "SPX",
+       [AMDGPU_DPX_PARTITION_MODE] =3D "DPX",
+       [AMDGPU_TPX_PARTITION_MODE] =3D "TPX",
+       [AMDGPU_QPX_PARTITION_MODE] =3D "QPX",
+       [AMDGPU_CPX_PARTITION_MODE] =3D "CPX",
+};
+
 ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);

 #define to_xcp_attr(x) \
@@ -511,6 +519,27 @@ static int amdgpu_xcp_get_res_info(struct amdgpu_xcp_m=
gr *xcp_mgr,  }

 #define to_xcp_cfg(x) container_of(x, struct amdgpu_xcp_cfg, kobj)
+static ssize_t supported_xcp_configs_show(struct kobject *kobj,
+                                         struct kobj_attribute *attr, char=
 *buf) {
+       struct amdgpu_xcp_cfg *xcp_cfg =3D to_xcp_cfg(kobj);
+       struct amdgpu_xcp_mgr *xcp_mgr =3D xcp_cfg->xcp_mgr;
+       int size =3D 0, mode;
+       char *sep =3D "";
+
+       if (!xcp_mgr || !xcp_mgr->supp_xcp_modes)
+               return sysfs_emit(buf, "Not supported\n");
+
+       for_each_inst(mode, xcp_mgr->supp_xcp_modes) {
+               size +=3D sysfs_emit_at(buf, size, "%s%s", sep, xcp_desc[mo=
de]);
+               sep =3D ", ";
+       }
+
+       size +=3D sysfs_emit_at(buf, size, "\n");
+
+       return size;
+}
+
 static ssize_t xcp_config_show(struct kobject *kobj,
                               struct kobj_attribute *attr, char *buf)  { @=
@ -564,6 +593,19 @@ static const struct kobj_type xcp_cfg_sysfs_ktype =3D {
        .sysfs_ops =3D &kobj_sysfs_ops,
 };

+static struct kobj_attribute supp_part_sysfs_mode =3D
+       __ATTR_RO(supported_xcp_configs);
+
+static const struct kobj_type supp_part_sysfs_ktype =3D {
+       .sysfs_ops =3D &kobj_sysfs_ops,
+};
+
+static const struct attribute *xcp_attrs[] =3D {
+       &supp_part_sysfs_mode.attr,
+       &xcp_cfg_sysfs_mode.attr,
+       NULL,
+};
+
 void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)  {
        struct amdgpu_xcp_res_details *xcp_res; @@ -583,7 +625,7 @@ void am=
dgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
        if (r)
                goto err1;

-       r =3D sysfs_create_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+       r =3D sysfs_create_files(&xcp_cfg->kobj, xcp_attrs);
        if (r)
                goto err1;

@@ -611,7 +653,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *ad=
ev)
                kobject_put(&xcp_res->kobj);
        }

-       sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+       sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 err1:
        kobject_put(&xcp_cfg->kobj);
 }
@@ -631,6 +673,6 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *ad=
ev)
                kobject_put(&xcp_res->kobj);
        }

-       sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+       sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
        kobject_put(&xcp_cfg->kobj);
 }
--
2.46.0

