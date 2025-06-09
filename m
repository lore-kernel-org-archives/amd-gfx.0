Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F322C61CE8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 11:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12B810E052;
	Mon,  9 Jun 2025 11:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmoEuRz1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BE310E052
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 11:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjJXVExJXMSOGJWySnWT6/ix0Q5w5zJQyuBw5PsSEhVGCRxBT/dT4XnNSh6YCXMgkoataGcETtA42i7MKVlgcvLeOEkM/ifEA1S4VFwPCjbF0DCTj4wLCIrpNllnfrP+h1zZ6X7zvfPNju8yesUhHkwaj54ZFbXmJ47ZHWZRcNCaKnWRIJFFg5C7yXZvO4LCgg68znPD3HSF49BF6Smc3Nsvw0S4/hkl4uhSVjGY8eVzg5tIIMIrvfzNqS+jugCZjd2zYxgakBqugZw8bw1AyJxcasopeyYwroVvUBoI1w8+ZL9u7RePi/5IVWI8N7WhgeCnwdcUWjcYQP3DuA6dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g71rTeIg86AbFMBjH6ATm0yLCC+pe9w4mRrouwW/yrg=;
 b=Lj7yWFlU2hYMqiX1hhY7elmeLGM7qP/EU5gCxVRbU+NtkKWbadOY0Auhi/FnYRS1cEgTR4iIIP7weNQVy5006WqY6187dp7pK2iWBpl0c5KGSfENgo0EjaQvEmqW2+dMshAszCNQeYoRE4Y+fvClnKt7JeBdJnnYy+/rygO5YEGTdwBcfNg/l4SF3bp5eBHgIA+whRu+Xhr6Oa5AklvxevH4AaRTXfRQUwcgbiDNGBARukWPumcbA5k4ISrvAcfn8ZK0Hoalbk3qcuGvYAfkB+tHN9H1Lq6h7RuFF5GwzibKPGWA7sgKDwXHgWfxppmG0SxV4Gbgcl7tYCHYlu5Ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g71rTeIg86AbFMBjH6ATm0yLCC+pe9w4mRrouwW/yrg=;
 b=YmoEuRz1yElPeSFelEQp7lWmRH4edExCU1aFNfdFoMvBr1IQ5OwL3dz+zhuqqvPZ0vy/OgZK7nJUtwO51aTiJibT0MN3xuvPNZJLj2cJd5Som/jFXCl+dxu9+CGlqb7Tars/drNc++gmRdzfs+PEkWmqQCV26ZqbMepz9n8yobY=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Mon, 9 Jun 2025 11:48:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8769.029; Mon, 9 Jun 2025
 11:48:56 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Suspend IH during mode-2 reset
Thread-Topic: [PATCH] drm/amdgpu: Suspend IH during mode-2 reset
Thread-Index: AQHb2PjVWNwdfThKcUi507E2Sj/bN7P6tv2Q
Date: Mon, 9 Jun 2025 11:48:56 +0000
Message-ID: <DS7PR12MB6071F1A8CB61E999747D672F8E6BA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250609044127.700014-1-lijo.lazar@amd.com>
In-Reply-To: <20250609044127.700014-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=baaa78a7-38e0-4791-99b4-6e11fdfc06df;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-09T11:48:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB6543:EE_
x-ms-office365-filtering-correlation-id: 7fa1b6c6-8f34-4326-1641-08dda74b9dc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FuX11RI8s0oR5Edrxp3oQEr0vk9BQ1ayja5MM76bdNfNK9svDaR+YhauAQfq?=
 =?us-ascii?Q?Rwgw5UmtwUihjX+HnRS/QrlYmHOKpGFwai0vKSxNnG+fjRH7UMYxMNUZFX4L?=
 =?us-ascii?Q?4DNdBgIM+RBgOWwd1JD2FfF/mnFfJ5ASnv+gYEdV3BVbbJ2E6BsBiYCNC8gi?=
 =?us-ascii?Q?Lx+nU1aABJB0PK+cKkbgF7+Wz2iL/Wvkvk+2Zr6BtZrttXqstg391WG/GxfH?=
 =?us-ascii?Q?wRYDacWXL/ZWNXVta17hdtfhPnBybRepFvpuhWyozcEA5XjSMKpiJIbCCz0P?=
 =?us-ascii?Q?93JboumuKXhNluk+2iMyKJSNAfJ8S0gfUfSekumd8+lKp5jh5yLsRToaOhIU?=
 =?us-ascii?Q?p49G/hkGeUnkjYshHreeNK5qsIAbR6h7m/fqeWYMcboyEs0Rw6c9fmeNXnb+?=
 =?us-ascii?Q?cOPQc5DuJ16Mh6C7gVZEjdi+j8lwXKj0R/5CEo3wPS6MA6EJEBbMnAN51uLS?=
 =?us-ascii?Q?vHqwgrno12chPH+2/rRBlDAWFaLU/xoLosHw+nRKABiTshDs3ezsrdvI2ADh?=
 =?us-ascii?Q?j6aa1SC5twUSXeczGGy0tgTuY2FUwEaaLJfXl7ANqQ5U3mV7b67pl8/MXSwW?=
 =?us-ascii?Q?PSC20DXUjZRurDRVdpGbNQDOng0zD0/HfNBxNjMKxfBES1p7otVutC5lkvCl?=
 =?us-ascii?Q?AI0sCW+cL1nc27V4ZzCUlFf0OiXbU0Y+iDRhtbXgFyf57xkrmetw5ofpv0tv?=
 =?us-ascii?Q?BGjSoUYd5hjVhFvE8JPRKKalGUFdn8TIAw/cLum8Bo97Ku6hAyG9ZxhdCTNk?=
 =?us-ascii?Q?4bxXk+vewfuBpZiBDT2TmRYxnUbO+Geo4IHqDp7ReZYIoj6wlCTxnlrIcCoi?=
 =?us-ascii?Q?0jY5lHWfOz/uBLKnFI9b7he0rEW6R3aOKqE7kCs+O8y+kU9Lcyy89T61udUR?=
 =?us-ascii?Q?jMZcwCsriDQt2WDTyZCdkd6bIMbV2+N+QLhHfgIpMHVsfqafKaAEHhogKjAr?=
 =?us-ascii?Q?Mnk0qOJQlj4LIGhqYdpQ6eWPKmiTWP8QslEMQB0OfS/KeQgDQ1Aj0NNT4efg?=
 =?us-ascii?Q?bHjj+dLk4Frg1BWUJs/QKKeWMLlDd9butccwckUm6dI4Z5QzyKvhpPNAEVjT?=
 =?us-ascii?Q?j5b6Moous1/FECfGb0owj68QcqgQogB5BSRNZsNw6nNO7Bz904rld14QL6Mg?=
 =?us-ascii?Q?+mdP9afVBtoJupGxcqX1Bz7pnABiXrshZPIf3aldvZGVNl2fd6gD4GSS6B4a?=
 =?us-ascii?Q?cVOPTfuf9uM++GmnKi8/W4mMhA+AareXhMD1CNw2/hy5j3pd0zDcwNqArWbm?=
 =?us-ascii?Q?5Bi0Ou9KS6Ju9K1Iz919KglUfHYkR7DoYhFb7gLBYj7/RKfvpUs4MXpKfz+i?=
 =?us-ascii?Q?AZeRD7iCdVVh7y0+hwIToACcOmEH8qRzks1PsBdSoFdvCSfqYAoySk34Z8qz?=
 =?us-ascii?Q?n/mYAcnQyiXuv2/VYpxiRWMFH1epm1lJgA1lydS6qvZ/UgUpFvXGr64PJLMm?=
 =?us-ascii?Q?b/vcUV0r5PFxrswAcP0fkJXBuoIxCZHYjfSWohFrsQ//RiuRfKFjxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STupi0wxg7SM6nTDW+2jNqJdBK2z/QWfog4JRRqw06FZ5aHUB/HJ9VbamP2c?=
 =?us-ascii?Q?D571NQqPN1z4lc9qX7yBZBCQ4ThTI1FZZrdeAn9RE2AsXBRT5gPDluAef1YO?=
 =?us-ascii?Q?buawSifX3HpxzPsGPCrDk4FD1E291tGHAgYdEnmbJ+6v/CXX0rJsRZqzOtxG?=
 =?us-ascii?Q?BT8DdYpPakou1VcJMJe7iIpeVeKQ4wjnZp4XjQXrkQ3neAOHUlPod5M1YJlp?=
 =?us-ascii?Q?lZ5h9abB5I1VvSMVwqrDdWbz3ZfXDawljOnXoR88vjAImVnts38tBepHWZCA?=
 =?us-ascii?Q?jxLpCS/zzO10nrmc3/m9Mk0r40vLTAvoHi34bFXNnk0Tq5iLk5U3YFkMY5ii?=
 =?us-ascii?Q?cIP5moRoUhmpCdiI4T7N0CyGGvJug2S2CQi/xIcCXMgxtsd8yvSs7L2JgnXe?=
 =?us-ascii?Q?tpNDZaBmyy1FujadtwxcRpqdWz6Ap7BdJfH/6xEaXwUYmkfOkoqxdayFzWzH?=
 =?us-ascii?Q?vHS9rs6XnYLoXkKatBYsFHuFCKZGJ/0UlrIGoIIZ1FV/XWFEkhk8NY6UmVMl?=
 =?us-ascii?Q?kGYI3FOTN2May3ZR423Zd455UX7EfzTZVmu/ascponFkmgqlwNbANf0h1AT5?=
 =?us-ascii?Q?LsulNz83VTKRm1/2cIQ50KNbT7vaDYeTZOpKnAvB4MqeQz3fWZnQ9akUBGdp?=
 =?us-ascii?Q?dBpzklJvDiiLHGyR6IL0SnUW4ZigMlw/ZL5xSKB1QxQXO0slXyN3HQCKu+VV?=
 =?us-ascii?Q?urh1tUMKyndQC+V7eQqNfVdBSmdudcH+f/bokd8yX5LaL36CX2GetnAcdV3Z?=
 =?us-ascii?Q?K/vdlv4e1vEBkbMrEdb0Lec5wGnZwQOEvgzw5WTrRCAyvqLTdcUshJ1uFg+I?=
 =?us-ascii?Q?qYjiQXYcw0250dNFy9n0qFFvyMBPeufIJIbTIbR6yFBtFnX0lInPTCwGF/fA?=
 =?us-ascii?Q?VbtHdBwkkDp4skx/mEp1ZvXgMvbdmgEmYrHA7zUqg0ilVUnwoobGRw8gKJTb?=
 =?us-ascii?Q?fGPJm2lHmeWKGnccItKsuCyKPkr+sxPsbFTkM0PILvs4AVg5CpBwYBzbEaSC?=
 =?us-ascii?Q?PHxGQmMPI6L9kRO8pOd9sD+azwX8TYI63eWQTuj/FJqZeQh+awxOATRZzwsE?=
 =?us-ascii?Q?LonKzE7NpJoqu7inXC7ZxXPtufOWPEsHNfwsvEIRw8ro+MPECklzei7JiiE7?=
 =?us-ascii?Q?CFB5AFBdLyb0mMdqlJ9y99qO+70g4V4mIHFRKz4aJNUnSOSjQoCqK1tGSyZB?=
 =?us-ascii?Q?ChpcktxVnPUpdy7S5yAGBQTd+28MJbsjfOeqiik9JMCEjEUUnEzQ3e2SU6Nr?=
 =?us-ascii?Q?KhPbhqpOHADcF/2FFDvNRfDcQ14y9LXF2zhWy6iIH1BDMGFIgYMGYK7VaS30?=
 =?us-ascii?Q?nOhIaSdlMA0XKhwfjuhdN7XF9k7jevpXMqeeOqxkvC+H7irOIjdPIn1V82vO?=
 =?us-ascii?Q?41ftDq6ohy7yrKUh1L5OAV+3/Dk+Ccd1hUPK51Q4NPwo0/4eCkIKrvmK0ZT6?=
 =?us-ascii?Q?wghhonZcMr1Gp/FfiQy5Fa5EPBpdQE9AJ/JGyuLGkaeOttrHdts7CxA1jQ+i?=
 =?us-ascii?Q?NvqIJb4sP5M5c92rA8SHuvT+mZh2E0kVQEVoU4xpkxywi1tgVpzXdXTWHoqX?=
 =?us-ascii?Q?1Cob8p+TnaC645REEmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa1b6c6-8f34-4326-1641-08dda74b9dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 11:48:56.7527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMWmjKGXb2XuQsgHxUJwTFpSnaO+73MLnpIk8C7QloFm0CKJG1soR/oDndXmLfzkGJ+nXCt+P/SM4yXIxg6eTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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
Sent: Monday, June 9, 2025 10:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Suspend IH during mode-2 reset

On multi-aid SOCs, there could be a continuous stream of interrupts from GC=
 after poison consumption. Suspend IH to disable them before doing
mode-2 reset. This avoids conflicts in hardware accesses during interrupt h=
andlers while a reset is ongoing.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 49bf8f3a748f..48c09addb29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -71,18 +71,29 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control=
 *reset_ctl,
        return NULL;
 }

+static inline uint32_t aldebaran_get_ip_block_mask(struct amdgpu_device
+*adev) {
+       uint32_t ip_block_mask =3D BIT(AMD_IP_BLOCK_TYPE_GFX) |
+                                BIT(AMD_IP_BLOCK_TYPE_SDMA);
+
+       if (adev->aid_mask)
+               ip_block_mask |=3D BIT(AMD_IP_BLOCK_TYPE_IH);
+
+       return ip_block_mask;
+}
+
 static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)  {
+       uint32_t ip_block_mask =3D aldebaran_get_ip_block_mask(adev);
+       uint32_t ip_block;
        int r, i;

        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

        for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
-               if (!(adev->ip_blocks[i].version->type =3D=3D
-                             AMD_IP_BLOCK_TYPE_GFX ||
-                     adev->ip_blocks[i].version->type =3D=3D
-                             AMD_IP_BLOCK_TYPE_SDMA))
+               ip_block =3D BIT(adev->ip_blocks[i].version->type);
+               if (!(ip_block_mask & ip_block))
                        continue;

                r =3D amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
@@ -200,8 +211,10 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_cont=
rol *reset_ctl,  static int aldebaran_mode2_restore_ip(struct amdgpu_device=
 *adev)  {
        struct amdgpu_firmware_info *ucode_list[AMDGPU_UCODE_ID_MAXIMUM];
+       uint32_t ip_block_mask =3D aldebaran_get_ip_block_mask(adev);
        struct amdgpu_firmware_info *ucode;
        struct amdgpu_ip_block *cmn_block;
+       struct amdgpu_ip_block *ih_block;
        int ucode_count =3D 0;
        int i, r;

@@ -243,6 +256,18 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_de=
vice *adev)
        if (r)
                return r;

+       if (ip_block_mask & BIT(AMD_IP_BLOCK_TYPE_IH)) {
+               ih_block =3D amdgpu_device_ip_get_ip_block(adev,
+                                                        AMD_IP_BLOCK_TYPE_=
IH);
+               if (unlikely(!ih_block)) {
+                       dev_err(adev->dev, "Failed to get IH handle\n");
+                       return -EINVAL;
+               }
+               r =3D amdgpu_ip_block_resume(ih_block);
+               if (r)
+                       return r;
+       }
+
        /* Reinit GFXHUB */
        adev->gfxhub.funcs->init(adev);
        r =3D adev->gfxhub.funcs->gart_enable(adev);
--
2.25.1

