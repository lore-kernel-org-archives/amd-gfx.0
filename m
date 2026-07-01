Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70193C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 13:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D706D10E277;
	Wed,  1 Jul 2026 13:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mn6j2U2l";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C3C10E277
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 13:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGheJg3JIogZDG87c8NGQHPF+DnpKkFYwrEc7aUz8wXetl0U1ZMXtMEGZdZooQ/fJ3IN8WEazoLz1y2bcw5L862E4UPwj4wkbYGCF2z5Cdtk9iB0pk3vZMaHXbJWihGycxjYKnYcbE6yhIMfkm0RwVU6SGfeTbkjdWzDSgP8SgJBnR4e1RlKeiyvbzdIuwYjpS9HlMVfSfJ4ctfb7o9RKgHkBPpHK/dGJmoaIrbiyBC7d+Ps8hshxhSrVNR/+7c+hGTvNfy8U203wL5Qu82Xnkt9Nb4H7att3tQZZoI37DVMmK6v5W91+cIJFN//ond3HFfWBvD1ueXutp4OG5QpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ipXwwOb763RFyKY0kTQg6Xy+OfmUWEHx9xIhcbSg40=;
 b=I5YlS1vNWXAEfWUFKOFcPBqMyJjyBAR4oJYtmzh+ggIJZUxrQc4m3q2B99EHgfPKBkyttbrYE8aMTSfEMYd+9JQGGOTlCZP+CBvUsbAyJCOkmXwZ18dRt1PgBvshvD/hLF20zbqifdChqHSxphLxzLMwy6qGTfxu+2wqOEIh0AAQ6zq7/FgcZtGQR7NGc8tPhcaxsr3w3icIgpYfmYqybL53dbOECbcclN51/ZFgyGFO44L7AJs56CjqHD5yfAT01bGf9DQITbxXZQjlL1kt5nexq1YNLNqxAuNBsrvmacky+GYd9UmHcyZpQM/CbUthkLGD534IsT7ggQ2abJcIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ipXwwOb763RFyKY0kTQg6Xy+OfmUWEHx9xIhcbSg40=;
 b=Mn6j2U2lBVj1F7hH08kGIFnFAiZHZhdbWF4g+iqfP2HT/zFJhFJ9PqYroSI7HP9VBu5ap3M/2mQFlb8NmC8eFAnS7RPe9KOjTc23rwWEfszHXXaEgY0JnnxnxB9zyootjysrSuFLOuaSq+Q3vfZ1CSHbTzC/oypAgNQYuBQ3r2M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 13:37:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:37:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu/ras: only check bad page for address-based
 UMC injection
Thread-Topic: [PATCH 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Index: AQHdCVJSbJ+yDSscdkylEbJNDfpq67ZYqcgQ
Date: Wed, 1 Jul 2026 13:37:02 +0000
Message-ID: <BN9PR12MB525799E4692E89A1783B103BFCF62@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260701120752.289190-1-Stanley.Yang@amd.com>
In-Reply-To: <20260701120752.289190-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-01T13:33:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8663:EE_
x-ms-office365-filtering-correlation-id: 52657eb0-3bf6-452b-b480-08ded775d53b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|11063799006|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: Qy09oOgw/IJAxVXLZpmuFv8C2VEwmAMdGaGW86k0IqdS+J/JjNXdS6NjUlzq0+TGxfERJFWjF46Hqg6+yERqLTQzb7e8WPg23AoPBycxSqm2cggIpTZdUFLYPfKruKIRBiXoUtxPx8mALSVeDXuSJ98yIGZ+MsPqHNIE7XccF805Y0fTZb3Wc5WsAogF8QiLyN9kmsR30SxQyBqtBSbY0CvBil8juG0FTFac3Plk3C2vY94GeuAbeuOlmUEGi9F8Z4DbvMDEWZZ3akcu3Ty9IJVp3q0Tnk9hCV/5D7AzjkCBPFgVradUlviEqGcZxSSxkufAsJIrewhQkvJpxn7ZVMeuEfZjPuTUre01/6LAqXEb76vtkeXL4GhOI54uHmw3xBwlYAme1VayPDGi0aAth1z6yHYgKrdnFi0ICMlLdzvC+sKLnhTfEPQ28//nQr+zmIM5RqEVhP61fHDIckLObYpncrGvF9Id2lJduYlLUzTmE3YhJuBlenFPHEam6Aekt1OTCsk33OQ+20E9LAwdW4vBd0DOkkjfjWqkGHCFaQ5OuvPnV7in4xS0/IFstgCjfg99oPzowptOXUXRVYvedmykVXxLaWQZNImI04X/erm3WC3QVRbRYkGK2i22FqIVFibpPUwYTTW7ZQFVzlPOF3wiaXq4QQPpBQbY1tEmv1/iKjQxPQd1F67XuohhOaPnzew/ZM+Jp7T2Q243edz6xbP28bcKKI2eTCUayX/4lYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h2iP+qIXFID7SV+CxDVqhAFZGb4x/eplqAl7DPK5xA6oKYyzqBwPLkEv8NYF?=
 =?us-ascii?Q?dVEKFAU4PCebyFkz02CeWaogFmjGsISnTcYHYDT6bRKl3L7Z9OWuN3uFKJeK?=
 =?us-ascii?Q?V9xrrWJ8ovM0hV6YK4bVisvM4tppKFBEbxH5vd4Ode1Pbki/EiIiw1ID1V+R?=
 =?us-ascii?Q?G4ij0ftuimWYVKEMZB4rhclrfijCnSQJmp2+NRbobOFSg3pvizaDisJkyjxD?=
 =?us-ascii?Q?pAaROGtUeEFPUGNcOe5et+7ndhboo3VSVK25rdRGeEe/Fxf7sWNtoMjK6w0o?=
 =?us-ascii?Q?JdxD/a+1JuXh4qrsP4yekhFAilUIYKpy0WC/cn6afAMtwd8GYe8KfDJYkQoY?=
 =?us-ascii?Q?JMvAweniv0fd0eHTUueu08gEIVa6vq2Db0vUyu+wuZDZjyGIzLZRpKVraDcM?=
 =?us-ascii?Q?TDFzJfFjQlMgQiqDw0U4swXKfpVopqAMU18puA+NC3inTjhxw6hUcPy+yJIk?=
 =?us-ascii?Q?mWdWJSaFdo3GO1oU9cfwV1D3JcFa12xtPOFj2LbVij3/wPZUfyUE/d96Ah3l?=
 =?us-ascii?Q?xA4gGHH+DcUy8iUFzVaMo0dy/Bu0bB0/BA1K18RRUddzq27Q68fF/vTVyVPT?=
 =?us-ascii?Q?Zw42vZll89WcB/kkrFHAejnt8D4cEdGNxyxtlo9IhZlaA+f/MT0k3h4/knD4?=
 =?us-ascii?Q?EYD0RrF6GHxBR7lPWFznYkmetrPu5oMaYJOMm0DxB4EjtYfUJ5Ekk1UtWGeb?=
 =?us-ascii?Q?nTqaRj25jHCnELM45zEtJyBxRY6gjeAThX2oiYQkJmoGvEoBiJJUdzE0ODtl?=
 =?us-ascii?Q?YVjOpP4rXY3UaLmX+5Zdg6wY2F/SONPTSua/jx0yRriYa8Z0DEu+N0zij1fO?=
 =?us-ascii?Q?MVGxgLNsgiWOSU1iIB4QF+7yeTk2SBuX2b2/B4E4wRbOQv/ruK3x0LT6eXwa?=
 =?us-ascii?Q?PL+zJnopeLN+xnFjb6ep062f+ekWafU8MkAiknGEvxxyozPHVX762yQWE1X3?=
 =?us-ascii?Q?M3ztp4gy2TGxJZnD2gJwMj37xakb5Agk1r4fTBBX++jgK/vEIwO+zpAvYPlu?=
 =?us-ascii?Q?t6hod7tF4LANm6FObBVcKMBzUk6hddsjE/+zCUt1wbGRPQ+VZ3hXjWPsrWSL?=
 =?us-ascii?Q?zb0eTRGGQxKfV1Xyy7USQrIwfWdS4mErhHaqYdGslarVn/MHj/hdFmhZXQge?=
 =?us-ascii?Q?b7S/92+jT+2kErLVO96PHDBZtnL79TYnw9UU/lr5JK9AxOxRwaqvJsv3gbZv?=
 =?us-ascii?Q?PZTuLlLub4QO/PRFbkkrU9QxKvry3483wXBeuuuPvtJYetGLiU7+PXkrBY9X?=
 =?us-ascii?Q?Jw5fVwhJ79WK0jAiPFxnM36OmO1bVQMYQTat79mkO4SlqvT3SB3fxf7bbmTM?=
 =?us-ascii?Q?kKyTPNKXAVypkGwZse+IZ1SslcPs6Dph2YG4M1aoT7YldQWwfF1YLm5p7Hw8?=
 =?us-ascii?Q?9DK2xpEJX8aHRrLsfTGRhEakl4w/Njsm4GCA/KrbDZwJnem3sDpYJqS1rEJt?=
 =?us-ascii?Q?Tc8sjngZJahBQ1PhimcWqOh5uKdLNut1KfOJxeiF9lxKjxK6oe6k8YfmJuuu?=
 =?us-ascii?Q?8hETIWiyr/cnbtQ1RBk8WlUFxKatvSXAJx9V9hkE8hqwjvrO+iPeJMg9C58V?=
 =?us-ascii?Q?Q94ASYrDSf4qNaGMhs7xMHjJMEBiVeixkiXI3yH3UyuUJO7rATX3QDkBBKvy?=
 =?us-ascii?Q?hRuU4GZ7tW1/t6gVlEY5+OBN3b7/7vIV0XJUM/SuPZPOOtwOUgn07ppG0I4P?=
 =?us-ascii?Q?AscSEYc95PtICiYPi1E8C7dZkJN7I5T1c1vUm9xvWE9pRGrC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52657eb0-3bf6-452b-b480-08ded775d53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 13:37:02.1302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N3WopmVkYjum+ajxLR63FxA7WU45pZPMqFbHDQJIBgFzv7bQw9HedOi2hfB7sJowa7b0XVy5yyXWPRR/F5FZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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

Should we add a new API in amdgpu ras_mgr layer for this check? I think we =
should stop adding RAS functionality for SMU v13 and later products in the =
legacy ras layer.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, July 1, 2026 8:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/ras: only check bad page for address-based =
UMC injection

UMC error injection on MI300 series is dispatched by the RAS TA via the (su=
b-block, method) pair; only the "coherent" methods are address based, the s=
ingle-shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the bad pa=
ge list for every UMC injection. Restrict that check to address-based injec=
tions and warn when a non address-based one is given a non-zero address. Ot=
her ASICs keep injecting by address.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 94 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 +-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index af48dd2ebd16..c563e2d96809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -485,6 +485,91 @@ static void amdgpu_ras_instance_mask_check(struct amdg=
pu_device *adev,
                        inst_mask, data->inject.instance_mask);  }

+/*
+ * UMC error injection on MI300-class ASICs is dispatched by the RAS TA
+using
+ * the (sub-block, method) pair passed in struct
+ta_ras_trigger_error_input as
+ * sub_block_index (enum error_sub_block_umc) and value (enum inject_metho=
d_umc).
+ * Only the "coherent" methods program an explicit injection address.
+ *
+ * Keep the values below in sync with the RAS TA.
+ */
+enum umc_error_sub_block {
+       UMC_ERROR_CRC                   =3D 0,
+       UMC_ERROR_SRAM                  =3D 1,
+       UMC_ERROR_ODECC                 =3D 2,
+       UMC_ERROR_PARITY_DATA           =3D 3,
+       UMC_ERROR_PARITY_CMD            =3D 4,
+};
+
+enum umc_inject_method {
+       UMC_METH_COHERENT               =3D 0,
+       UMC_METH_SINGLE_SHOT            =3D 1,
+       UMC_METH_PERSISTENT             =3D 2,
+       UMC_METH_PERSISTENT_DISABLE     =3D 3,
+       UMC_METH_COHERENT_NO_DETECTION  =3D 4,
+       UMC_METH_COHERENT_WR            =3D 5,
+       UMC_METH_SINGLE_SHOT_WR         =3D 6,
+       UMC_METH_PERSISTENT_WR          =3D 7,
+       UMC_METH_SINGLE_SHOT_CLEAN      =3D 8,
+};
+
+/*
+ * Return true if a UMC error injection using @sub_block (enum
+error_sub_block_umc)
+ * and @method (enum inject_method_umc) is address-based, i.e. it
+programs an
+ * explicit injection address. On MI300 series the non address-based
+methods
+ * ignore the address; other ASICs always inject by the given address,
+so return
+ * true there to keep validating it.
+ */
+bool amdgpu_ras_umc_is_address_based(struct amdgpu_device *adev,
+                                    u32 sub_block, u64 method)
+{
+       /*
+        * The (sub-block, method) classification below follows the MI300 R=
AS
+        * TA injection ABI and does not apply to other ASICs.
+        */
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+       case IP_VERSION(13, 0, 12):
+       case IP_VERSION(13, 0, 14):
+               break;
+       default:
+               return true;
+       }
+
+       switch (sub_block) {
+       case UMC_ERROR_CRC:
+               return method =3D=3D UMC_METH_COHERENT ||
+                      method =3D=3D UMC_METH_COHERENT_NO_DETECTION ||
+                      method =3D=3D UMC_METH_COHERENT_WR;
+       case UMC_ERROR_ODECC:
+               return method =3D=3D UMC_METH_COHERENT;
+       case UMC_ERROR_PARITY_DATA:
+               return method =3D=3D UMC_METH_COHERENT ||
+                      method =3D=3D UMC_METH_COHERENT_WR;
+       default:
+               return false;
+       }
+}
+
+/*
+ * Wrapper for the legacy debugfs inject path: classify @data and warn
+when a
+ * non address-based injection was given a non-zero address (which is igno=
red).
+ */
+static bool amdgpu_ras_umc_inject_is_address_based(struct amdgpu_device *a=
dev,
+                                                  struct ras_debug_if *dat=
a)
+{
+       bool address_based =3D amdgpu_ras_umc_is_address_based(adev,
+                                       data->head.sub_block_index,
+                                       data->inject.value);
+
+       if (!address_based && data->inject.address)
+               dev_warn(adev->dev,
+                        "RAS WARN: non address based injection, ignore the=
 injection address 0x%llx\n",
+                        data->inject.address);
+
+       return address_based;
+}
+
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
@@ -606,8 +691,13 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
                ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
                break;
        case 2:
-               /* umc ce/ue error injection for a bad page is not allowed =
*/
-               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+               /*
+                * UMC ce/ue error injection for a bad page is not allowed,=
 but
+                * only address-based injections actually use the address, =
so
+                * limit the bad page check to those.
+                */
+               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC &&
+                   amdgpu_ras_umc_inject_is_address_based(adev, &data))
                        ret =3D amdgpu_ras_check_bad_page(adev, data.inject=
.address);
                if (ret =3D=3D -EINVAL) {
                        dev_warn(adev->dev, "RAS WARN: input address 0x%llx=
 is invalid.", diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ad24c7cf8936..69a1600ad1a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -917,6 +917,9 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device =
*adev,  int amdgpu_ras_error_inject(struct amdgpu_device *adev,
                struct ras_inject_if *info);

+bool amdgpu_ras_umc_is_address_based(struct amdgpu_device *adev,
+               u32 sub_block, u64 method);
+
 int amdgpu_ras_interrupt_add_handler(struct amdgpu_device *adev,
                struct ras_common_if *head);

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index bfbfdffbfbe6..31486ceecc72 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -90,7 +90,8 @@ static int amdgpu_ras_inject_error(struct ras_core_contex=
t *ras_core,
                (struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
        int ret =3D RAS_CMD__ERROR_GENERIC;

-       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC) {
+       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC &&
+               amdgpu_ras_umc_is_address_based(adev, req->subblock_id, req=
->method))
+{
                if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) =
{
                        RAS_DEV_WARN(ras_core->dev,
                                "RAS WARN: inject: 0x%llx has already been =
marked as bad!\n",
--
2.43.0

