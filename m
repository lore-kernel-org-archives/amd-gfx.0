Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A520DC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 14:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3294A10E0DB;
	Mon, 13 May 2024 14:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SERceT9d";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2AF10E0DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 14:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afoYn6vlmMqydt8BQRV/jFdG4DchENz6loqTjw0C8jqdXGp7wIxJnYtTxsy7/PiRx+xa05q1yJgdgJ1xlTk2TFQ4/nkKMCoBsY3VfPSt/3LZvb+tpALkq7cCZrkxrig/BYcdSVfL6Ugekc3bfvOUq5fYHL3p+KR4MQDewcYWxbPW4emhzI2zgFrLiWbEE1IBGYCy0Dj9cOCYdAqdlqhs27TPt/haLfHX7Ky88dKjXOTs5Y2O0TSAHKgE/Y6mG55HfV/BKBY5ceFE42TYvzXZnwen+Wtcz6QjGbZX/uP++fRaipUHNwVpmc6z2FyUTWGerchqZcKm3Fh6JRRe8zhaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT7H4UwbOP1CDshxJmSOcAy1eow+393yJGCUGhKBiGo=;
 b=DRgYHBRXl9FhTBL/dHSG3Y2pQSgNtd8XErZ2nUxO9V5gf+Ht5c16N1/5Vlng6xV9UohDP4q3/NCiNzKvTVFxUmNk9aAAYYVFG2LFnR4xk/MxipIBTgYBuaB0cVzXB863xyX2vHIejAMXqclgTKVkFa1sENm4uCx/w5uPWaig1wOUhGXQuNRfdPzHqAtXFB1Lf8w+jaLTgC6kAgQqvW5xGg7pBxObrpi4KE9PdgY76JlHpyam6CZ5ZmNeVRTNCT1OzN7qkuZO5JNJTd23OfjJ9LAXXtzHC5NryDnDHZfynPkAYNn8oqtJgUC7su2M8WEnAk4jG2AbDnTfzQHka9a+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT7H4UwbOP1CDshxJmSOcAy1eow+393yJGCUGhKBiGo=;
 b=SERceT9dhU0LiuLFEjpwVtEhZBWNRyfNA1yVQvM2DdCzDfPPJDLQ7T360GrJw1zL5vQofTwQXeINdS/YGAtVlaS+g8NCeOmF/czCqgjpcmRqJI7XHlweJc66cSh63I+Gg7P5d+cgaSonrf2nxj5x/Ww12ciwMo0GXJTROvccZ+0=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:55:09 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:55:09 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: fix getting vram info for gfx12
Thread-Topic: [PATCH] drm/amdgpu: fix getting vram info for gfx12
Thread-Index: AQHapRzVu7vLtMPqVkqeDj13HivRCLGU8smwgABNwjA=
Date: Mon, 13 May 2024 14:55:09 +0000
Message-ID: <SA1PR12MB5659E02A7542DEEB521F1BC6E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240513100131.113631-1-Frank.Min@amd.com>
 <SA1PR12MB565944EEE174445FB2084490E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB565944EEE174445FB2084490E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8d10c751-348c-4833-b3be-08310eefde33;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T10:15:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|SJ1PR12MB6073:EE_
x-ms-office365-filtering-correlation-id: dd37fc02-f530-41c0-6894-08dc735caf29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1FxNJ2AMYRYjMv3NBxVLBbBwl3ozKq9H01QDXJu0a4CCwuDfAifQsR687BEz?=
 =?us-ascii?Q?nruElUcenBGYXgRNoBZOyDmVx5LHQaBK7owHg+lavVH7SWR/79iwzoEKgVvv?=
 =?us-ascii?Q?/0YxxUlwuhk1bn66OKS6AWJeyIxX6MYPKi2DKGEhZp+V4qd4OgQ5UR7/ni0E?=
 =?us-ascii?Q?C6lzcezYcP/GB9mXb73mVzWD6JIK9dUFtgkozvmWDbA2apbAyLulyxKUrlFl?=
 =?us-ascii?Q?+5weh318VkJNCCd2t3S28gFHHqyNBZSzveQwfnVkShqYQ29qeondqmx/ZMry?=
 =?us-ascii?Q?A0Gk8Xe6iDLZ/llfpoNYO/VMQliVOuQqsYk69Ya9GpfCfEz8DPbK/epQkOO4?=
 =?us-ascii?Q?B9LYhOS3IhCE8f6hBo0AYj8pYw2c1tYQx+AdFP56KVLoB9+eHvAaFxUr6rLF?=
 =?us-ascii?Q?8BtL26Lpb6KGtI8lL9heu7jB+JaaCy3Qmi4h2hV2GsyMSjjzk7/YL/jCsBwW?=
 =?us-ascii?Q?A+cC3l1DTVXRIDSo9XrrHmsIhCp1XhD2WE9i4cFRoOh5haLcFng0LkIlV8rD?=
 =?us-ascii?Q?vWZDQy7c1hq/+DGX2uZN4A0tzuZKuMuFgf3Gf+4oRP5zLVnSU7d0n49LOpUa?=
 =?us-ascii?Q?2MGfrueZ8y9N7ojbspz3K5BPs999/vG7w3kLRariB0f7fAgMR0Qii1jJpW54?=
 =?us-ascii?Q?Zz0UlH4lNHuqCdXlfBpjqa2MUAQ1FDKalezwfvKdAv6DiusGFNd27Rqg3EAl?=
 =?us-ascii?Q?NLO4p5ANMb68JE7z6pPhB8jzc1Yf8yAEkgqACu8uhkUhrqMjvbx93Mmmcj0Y?=
 =?us-ascii?Q?Qezau5bkGrkgEXoDNMoTg+xW7i3FIYAp9pUXgzuzGpKaLDkpaXQ4xNChUXfU?=
 =?us-ascii?Q?sSqCj9GZhelue2UQNqQBTvTlQ+abSnm85K3pHxI946Bq8lNcnl7WszaUZCsL?=
 =?us-ascii?Q?KP7qHsbfAWAzZoHr7urbQ1kQlZ3DUZY/KkXtgVxrraGBmJoqaLNcilavzxIW?=
 =?us-ascii?Q?oUCoyaeGP9Xr9Xdskl2Sp6z+fT5SJICVIbmLJ9k1i2I22ddb8/bUibfjfpiG?=
 =?us-ascii?Q?gcNQX/NY07R2x7r6eigpgppIqgFzLrgpzKaa9EUloTPpznSslvyhdQayLpYN?=
 =?us-ascii?Q?aVJASfsyncGD6DaTfie6aChCLl0Leuga/+QZoF2xLYcMCqoqm03s0TpHG5W/?=
 =?us-ascii?Q?fdRPkKuamfUmQmRQoYRLqIdWA9jYiYrR7uFbutnk9EuIF2g9eUS53lYah403?=
 =?us-ascii?Q?sZ7gyVMI4LS1bh1QVhktDDdqB1tOhdQxVj5WAc4t98U3A/ri8VaGwhtiQIOt?=
 =?us-ascii?Q?tAZo6VckMQRSR/JXgHBjeHzcNxflWXwuSbthOlfhMX/V7O//zEfT70QqZLcU?=
 =?us-ascii?Q?UfSBfLClv0z21kNIPr//pmNCOtVNCMDbn3sK4fXbLhSxZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYOIC0f8SpKy9dKM2n/J0heNs2WBGLcjhTanzD0/GReF8t82JcH7JqnAeLHD?=
 =?us-ascii?Q?JdSaKL85QGk0sNk51fU+JmnjPwYbPbORbbPX3y75fb/RacfMp/8N5HcTnApL?=
 =?us-ascii?Q?4fqNMu00jfzxxTGDtlc0dHVgPUKhMHP2UeLTQlK/cyU7T48PvDZu71yG2ylu?=
 =?us-ascii?Q?am9vsdDrx+rOPbmrqH9AvQxoTjmuwJ7mmJXmPlbt0L3wwZWt4J+pVL//9hUt?=
 =?us-ascii?Q?NabsQ+2d0I57twQW2F5DdJEJeA5SLgsyG0Xmlper2ihv+sy0mfnXuMVQ4oNZ?=
 =?us-ascii?Q?Muh/mvbDng7TteBfQla/6Sex6q73UbWLSpfthDJTysDTMMDld2SBttMSVDY1?=
 =?us-ascii?Q?6uVCfPM2ehp7eomrY9yGPc0XgcyeD69R7fvJvjJpjJTnx9xfmG0cWqGAh/PS?=
 =?us-ascii?Q?bIudZZzoaUosTavrvMEgaq7Ig/LWyuJ36YqNYm5hdwkqRAL2twVVFDJfUYlu?=
 =?us-ascii?Q?hJoe3WLweLgC4ThLE7iyeYxZ2LynJeR7VERzGyb5FUrzBouKF2gPUG7Q2Ghb?=
 =?us-ascii?Q?P42ijq6jQS3gM/k2NmqL1F3MTSqTGc4ZjsbcaNCr9hgpSJMt7v6X9LRMZyNq?=
 =?us-ascii?Q?87HLltFqf3Gbeqlec3Z9gATvSrolljPNEI8hFRiZtLxTjGve0NDn2H/eD1ZD?=
 =?us-ascii?Q?K7jm8FHgQQ8XAoNYBdZapmlNJHyd9XjnW5uGx3Q8Jj3qC51OTUw/rT6b1X2L?=
 =?us-ascii?Q?i08+tezd2kc3JjYgej0NpGcmL2Z1HqF0k0ozLyk74U7mr8iExMu1bUkZeSnD?=
 =?us-ascii?Q?CKEwU9A9VpXuzB5cV26AtqjPCCevl8UgQfdxxe0N4iZDlvoWpMJwNeWRY3Sw?=
 =?us-ascii?Q?xUWE2Dh/uqXpxqqWHl1bP49XiXfW7ak2nSJO7ePiFoLig896SvDB+/LgMCGl?=
 =?us-ascii?Q?+hsOvUCz6d2/3801g4AS7jEGVNmm+0LL670Nu1utAswpv/JWzc2W1Mdfq1Pi?=
 =?us-ascii?Q?lc3Oi4EZeWrOabi4/wz+QazbbNasybT0fHKzeiMwWuKZzU7eY7obPAiVATt6?=
 =?us-ascii?Q?OU6lmCH/zpIez8/T2h0LvoTmP4tKQB024ZgDXnlDb3rDFq5qggjlahPF+AC5?=
 =?us-ascii?Q?ygwBuj6pVScAHlaHWe/d4Fnzv7uIdcHQJEkc8ZD2FUMi99eFaYFETXT7AqwZ?=
 =?us-ascii?Q?hYCiB0rYyyBIViJAlzEovuIZ4uzondnX79ZDwRSpjERCIM91L0p4MOouICHB?=
 =?us-ascii?Q?67U89MEDjYBhvUdKXzsviJwDF4CjVNUcvNzkBZ3GGbrQjw3k3WJTOYh7p+W+?=
 =?us-ascii?Q?65ZiJdNr9Eva9XKr48KN6A6RdQPKojQ9Pymd6hvw6vuthQfv0LxsJYw8Wj1/?=
 =?us-ascii?Q?R7eED/8VxP86HQw89PvyvcjYruBCknZ0+W9uZ3F3klAC5vWqiu/JI1HmTkiW?=
 =?us-ascii?Q?7wsA7LQriWTmb2GricnMpCk8phbrlTjo5aCnuBlmaHCu1KuAXFl22hURB+18?=
 =?us-ascii?Q?nigXqgOqXYXML9xbs8OEiQKy0wUx/blg56iTbxN5Qm6Zl75hyAvp0kK6c7EK?=
 =?us-ascii?Q?xEzMkAwbVFHrslffuonpgUhdD3uIF719ptxGCiE8+NYee3Am7Z8Nqpdx/ycB?=
 =?us-ascii?Q?79ZTfHsm8SC9wTAIGIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd37fc02-f530-41c0-6894-08dc735caf29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:55:09.2296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET5jD5DwRHYgnRmdls+KqsWJrpCQrOcmqzlvKoJVyXhtBuPUGe+kgtgHqwZoTweb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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

From: Frank Min <Frank.Min@amd.com>

gfx12 query video mem channel/type/width from umc_info of atom list, so fix=
 it accordingly.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 263 ++++++++++--------
 1 file changed, 148 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a6d64bdbbb14..6fe84151332e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -289,7 +289,6 @@ static int convert_atom_mem_type_to_vram_type(struct am=
dgpu_device *adev,
        return vram_type;
 }

-
 int
 amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
                                  int *vram_width, int *vram_type,
@@ -300,6 +299,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device =
*adev,
        u16 data_offset, size;
        union igp_info *igp_info;
        union vram_info *vram_info;
+       union umc_info *umc_info;
        union vram_module *vram_module;
        u8 frev, crev;
        u8 mem_type;
@@ -311,10 +311,16 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
        if (adev->flags & AMD_IS_APU)
                index =3D get_index_into_master_table(atom_master_list_of_d=
ata_tables_v2_1,
                                                    integratedsysteminfo);
-       else
-               index =3D get_index_into_master_table(atom_master_list_of_d=
ata_tables_v2_1,
-                                                   vram_info);
-
+       else {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+               case IP_VERSION(12, 0, 0):
+               case IP_VERSION(12, 0, 1):
+                       index =3D get_index_into_master_table(atom_master_l=
ist_of_data_tables_v2_1, umc_info);
+                       break;
+               default:
+                       index =3D get_index_into_master_table(atom_master_l=
ist_of_data_tables_v2_1, vram_info);
+               }
+       }
        if (amdgpu_atom_parse_data_header(mode_info->atom_context,
                                          index, &size,
                                          &frev, &crev, &data_offset)) {
@@ -368,123 +374,150 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_dev=
ice *adev,
                                return -EINVAL;
                        }
                } else {
-                       vram_info =3D (union vram_info *)
-                               (mode_info->atom_context->bios + data_offse=
t);
-                       module_id =3D (RREG32(adev->bios_scratch_reg_offset=
 + 4) & 0x00ff0000) >> 16;
-                       if (frev =3D=3D 3) {
-                               switch (crev) {
-                               /* v30 */
-                               case 0:
-                                       vram_module =3D (union vram_module =
*)vram_info->v30.vram_module;
-                                       mem_vendor =3D (vram_module->v30.dr=
am_vendor_id) & 0xF;
-                                       if (vram_vendor)
-                                               *vram_vendor =3D mem_vendor=
;
-                                       mem_type =3D vram_info->v30.memory_=
type;
-                                       if (vram_type)
-                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
-                                       mem_channel_number =3D vram_info->v=
30.channel_num;
-                                       mem_channel_width =3D vram_info->v3=
0.channel_width;
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * (1 << mem_channel_width);
-                                       break;
-                               default:
-                                       return -EINVAL;
-                               }
-                       } else if (frev =3D=3D 2) {
-                               switch (crev) {
-                               /* v23 */
-                               case 3:
-                                       if (module_id > vram_info->v23.vram=
_module_num)
-                                               module_id =3D 0;
-                                       vram_module =3D (union vram_module =
*)vram_info->v23.vram_module;
-                                       while (i < module_id) {
-                                               vram_module =3D (union vram=
_module *)
-                                                       ((u8 *)vram_module =
+ vram_module->v9.vram_module_size);
-                                               i++;
-                                       }
-                                       mem_type =3D vram_module->v9.memory=
_type;
-                                       if (vram_type)
-                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
-                                       mem_channel_number =3D vram_module-=
>v9.channel_num;
-                                       mem_channel_width =3D vram_module->=
v9.channel_width;
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * (1 << mem_channel_width);
-                                       mem_vendor =3D (vram_module->v9.ven=
der_rev_id) & 0xF;
-                                       if (vram_vendor)
-                                               *vram_vendor =3D mem_vendor=
;
-                                       break;
-                               /* v24 */
-                               case 4:
-                                       if (module_id > vram_info->v24.vram=
_module_num)
-                                               module_id =3D 0;
-                                       vram_module =3D (union vram_module =
*)vram_info->v24.vram_module;
-                                       while (i < module_id) {
-                                               vram_module =3D (union vram=
_module *)
-                                                       ((u8 *)vram_module =
+ vram_module->v10.vram_module_size);
-                                               i++;
+                       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+                       case IP_VERSION(12, 0, 0):
+                       case IP_VERSION(12, 0, 1):
+                               umc_info =3D (union umc_info *)(mode_info->=
atom_context->bios +
+data_offset);
+
+                               if (frev =3D=3D 4) {
+                                       switch (crev) {
+                                       case 0:
+                                               mem_channel_number =3D le32=
_to_cpu(umc_info->v40.channel_num);
+                                               mem_type =3D le32_to_cpu(um=
c_info->v40.vram_type);
+                                               mem_channel_width =3D le32_=
to_cpu(umc_info->v40.channel_width);
+                                               mem_vendor =3D RREG32(adev-=
>bios_scratch_reg_offset + 4) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               break;
+                                       default:
+                                               return -EINVAL;
                                        }
-                                       mem_type =3D vram_module->v10.memor=
y_type;
-                                       if (vram_type)
-                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
-                                       mem_channel_number =3D vram_module-=
>v10.channel_num;
-                                       mem_channel_width =3D vram_module->=
v10.channel_width;
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * (1 << mem_channel_width);
-                                       mem_vendor =3D (vram_module->v10.ve=
nder_rev_id) & 0xF;
-                                       if (vram_vendor)
-                                               *vram_vendor =3D mem_vendor=
;
-                                       break;
-                               /* v25 */
-                               case 5:
-                                       if (module_id > vram_info->v25.vram=
_module_num)
-                                               module_id =3D 0;
-                                       vram_module =3D (union vram_module =
*)vram_info->v25.vram_module;
-                                       while (i < module_id) {
-                                               vram_module =3D (union vram=
_module *)
-                                                       ((u8 *)vram_module =
+ vram_module->v11.vram_module_size);
-                                               i++;
+                               } else
+                                       return -EINVAL;
+                               break;
+                       default:
+                               vram_info =3D (union vram_info *)
+                                       (mode_info->atom_context->bios + da=
ta_offset);
+
+                               module_id =3D (RREG32(adev->bios_scratch_re=
g_offset + 4) & 0x00ff0000) >> 16;
+                               if (frev =3D=3D 3) {
+                                       switch (crev) {
+                                       /* v30 */
+                                       case 0:
+                                               vram_module =3D (union vram=
_module *)vram_info->v30.vram_module;
+                                               mem_vendor =3D (vram_module=
->v30.dram_vendor_id) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               mem_type =3D vram_info->v30=
.memory_type;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               mem_channel_number =3D vram=
_info->v30.channel_num;
+                                               mem_channel_width =3D vram_=
info->v30.channel_width;
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               break;
+                                       default:
+                                               return -EINVAL;
                                        }
-                                       mem_type =3D vram_module->v11.memor=
y_type;
-                                       if (vram_type)
-                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
-                                       mem_channel_number =3D vram_module-=
>v11.channel_num;
-                                       mem_channel_width =3D vram_module->=
v11.channel_width;
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * (1 << mem_channel_width);
-                                       mem_vendor =3D (vram_module->v11.ve=
nder_rev_id) & 0xF;
-                                       if (vram_vendor)
-                                               *vram_vendor =3D mem_vendor=
;
-                                       break;
-                               /* v26 */
-                               case 6:
-                                       if (module_id > vram_info->v26.vram=
_module_num)
-                                               module_id =3D 0;
-                                       vram_module =3D (union vram_module =
*)vram_info->v26.vram_module;
-                                       while (i < module_id) {
-                                               vram_module =3D (union vram=
_module *)
-                                                       ((u8 *)vram_module =
+ vram_module->v9.vram_module_size);
-                                               i++;
+                               } else if (frev =3D=3D 2) {
+                                       switch (crev) {
+                                       /* v23 */
+                                       case 3:
+                                               if (module_id > vram_info->=
v23.vram_module_num)
+                                                       module_id =3D 0;
+                                               vram_module =3D (union vram=
_module *)vram_info->v23.vram_module;
+                                               while (i < module_id) {
+                                                       vram_module =3D (un=
ion vram_module *)
+                                                               ((u8 *)vram=
_module + vram_module->v9.vram_module_size);
+                                                       i++;
+                                               }
+                                               mem_type =3D vram_module->v=
9.memory_type;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               mem_channel_number =3D vram=
_module->v9.channel_num;
+                                               mem_channel_width =3D vram_=
module->v9.channel_width;
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               mem_vendor =3D (vram_module=
->v9.vender_rev_id) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               break;
+                                       /* v24 */
+                                       case 4:
+                                               if (module_id > vram_info->=
v24.vram_module_num)
+                                                       module_id =3D 0;
+                                               vram_module =3D (union vram=
_module *)vram_info->v24.vram_module;
+                                               while (i < module_id) {
+                                                       vram_module =3D (un=
ion vram_module *)
+                                                               ((u8 *)vram=
_module + vram_module->v10.vram_module_size);
+                                                       i++;
+                                               }
+                                               mem_type =3D vram_module->v=
10.memory_type;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               mem_channel_number =3D vram=
_module->v10.channel_num;
+                                               mem_channel_width =3D vram_=
module->v10.channel_width;
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               mem_vendor =3D (vram_module=
->v10.vender_rev_id) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               break;
+                                       /* v25 */
+                                       case 5:
+                                               if (module_id > vram_info->=
v25.vram_module_num)
+                                                       module_id =3D 0;
+                                               vram_module =3D (union vram=
_module *)vram_info->v25.vram_module;
+                                               while (i < module_id) {
+                                                       vram_module =3D (un=
ion vram_module *)
+                                                               ((u8 *)vram=
_module + vram_module->v11.vram_module_size);
+                                                       i++;
+                                               }
+                                               mem_type =3D vram_module->v=
11.memory_type;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               mem_channel_number =3D vram=
_module->v11.channel_num;
+                                               mem_channel_width =3D vram_=
module->v11.channel_width;
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               mem_vendor =3D (vram_module=
->v11.vender_rev_id) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               break;
+                                       /* v26 */
+                                       case 6:
+                                               if (module_id > vram_info->=
v26.vram_module_num)
+                                                       module_id =3D 0;
+                                               vram_module =3D (union vram=
_module *)vram_info->v26.vram_module;
+                                               while (i < module_id) {
+                                                       vram_module =3D (un=
ion vram_module *)
+                                                               ((u8 *)vram=
_module + vram_module->v9.vram_module_size);
+                                                       i++;
+                                               }
+                                               mem_type =3D vram_module->v=
9.memory_type;
+                                               if (vram_type)
+                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
+                                               mem_channel_number =3D vram=
_module->v9.channel_num;
+                                               mem_channel_width =3D vram_=
module->v9.channel_width;
+                                               if (vram_width)
+                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
+                                               mem_vendor =3D (vram_module=
->v9.vender_rev_id) & 0xF;
+                                               if (vram_vendor)
+                                                       *vram_vendor =3D me=
m_vendor;
+                                               break;
+                                       default:
+                                               return -EINVAL;
                                        }
-                                       mem_type =3D vram_module->v9.memory=
_type;
-                                       if (vram_type)
-                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
-                                       mem_channel_number =3D vram_module-=
>v9.channel_num;
-                                       mem_channel_width =3D vram_module->=
v9.channel_width;
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * (1 << mem_channel_width);
-                                       mem_vendor =3D (vram_module->v9.ven=
der_rev_id) & 0xF;
-                                       if (vram_vendor)
-                                               *vram_vendor =3D mem_vendor=
;
-                                       break;
-                               default:
+                               } else {
+                                       /* invalid frev */
                                        return -EINVAL;
                                }
-                       } else {
-                               /* invalid frev */
-                               return -EINVAL;
                        }
                }
-
        }

        return 0;
--
2.34.1

