Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF365C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 08:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAD210E376;
	Tue, 28 May 2024 08:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yq0vZVUW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEC310E1F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 08:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6lfILLzulE35RhPUoCTZ7BL98eVvHxwWZS0sIc3OMdC5WD6YrdSqMFEcORM2UVTEaAw8X0+SDugUHEJ3P0PiHF2FvVd5zLBENIRdBnJIsVLOGs/WGgePV+TX1DsPTL7RNtUrwgVIWbE07+HIQu0qSD9g8+wWJ1eKQTxb3DMpf4Mtd871MKv13bQCPQa/gK33gnC0cwD4V9nHaaeKtT5GAx5HBecerHIgwdeXqlYiAmc59jaYk4PdCCh9wVgDOR27bsEH6TzyWA82K7uFlSkQiuigm00TqUYKNF1kLk+UNOvKwUQ+LnVMhIISwjvyyxniggHm6ZDyuMKEAymHu5/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwvn4Hp3zb1OW9hoZxTX9k5LQzHzancxQxhT7qOxfAY=;
 b=OYB7Bc/uDZmQpH7lBbf+LN1KUi2PWHENzpv89R8VN0MofkixSJEbuP3+ng8ak4x60nYNynyBOXTjiCUFyy46LZUSLOSAs9x5y1VM7gemwkVQ239n7zLRIMiiDf0/NK4acTJ/9nXfEK+S7q20K9JKRzfBW9Y3f5C5M6p/jxJ2a4dqmz2bo6VSzQ4XOtONGRwsC+W/UbyoKUrhDAGtL0eW182Hq5U4ekxKsOD9NevWMTjX+6gNDXDpq/eOtwwodwLoiEK8rXvkc+TO6dAC5KvMmmdoer3GMhhHE5v6yJfp6IKkRKVlMlTvDPz1bZZCT4mo9/ygzQqrivy7VANOqO/0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwvn4Hp3zb1OW9hoZxTX9k5LQzHzancxQxhT7qOxfAY=;
 b=yq0vZVUWb8OosvlYK4yCHH/oW3enRjAEdzSaGQmZ2M0f9qobgkZ03mXXpvKoVwsV43b0inZCMOv1g59Qxmrmfp6qLi1jCKcAKWnNZh46NWmsyBdE8gNO18pdEpr8qtCHvtT9ft46f1b+0lrPNJ8OtZVokj7DrbBk7+FDz936hjQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 08:01:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 08:01:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>,
 "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, Daniel"
 <Daniel.Oliveira@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>, "Liu,
 Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode
Thread-Topic: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode
Thread-Index: AQHasFL65csqzp6Sc06D18V7ayI8VLGsSaNg
Date: Tue, 28 May 2024 08:01:12 +0000
Message-ID: <BN9PR12MB5257302B15B14C2E7C764E97FCF12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240527162839.259865-1-asad.kamal@amd.com>
In-Reply-To: <20240527162839.259865-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=35120b49-57d0-46a0-baa5-13dbe953729a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T08:00:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8063:EE_
x-ms-office365-filtering-correlation-id: 14840b55-b4d7-487a-892c-08dc7eec578e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?C1DN4HJSCr/mCulRAGOBIdDVjeItDUOAENVMHR7f4C3e32dcGKnsRW7Oyq1u?=
 =?us-ascii?Q?0lC1logIu8crRHtouQX7S4bfJpJdLfyxWmSXHJ4KA3rFeUNwtRZo+649C02s?=
 =?us-ascii?Q?aWuN+62Hl8WkeoeH4EIDJdL3J4Cvmw0DCgETG/AYXVMwlg2qGRZyBP+lM2vL?=
 =?us-ascii?Q?gyR3nU3JQjwseWZdbw81azOwKcpveq+jsO5IIdUE7BUlpeYGjuZZYl+cCQJH?=
 =?us-ascii?Q?2pixqUSI/lQLyXeYKVu17jrpVjI4THJzzNaAdqVn2FqiJPLV2Mr2oiyZEqBg?=
 =?us-ascii?Q?2NQE3nEivxVx2hjSXxIdBd4t4rqeB4bRAO9XrcUqKgcrZOq5fCx4zbISSYE0?=
 =?us-ascii?Q?/5dOY6eb/8sXxGi506JB2GJNIwJ4JayOcyU6e4jyCgREoA6Ha/hHoC6mg5vD?=
 =?us-ascii?Q?ikFm3MbkXSa3N1r3Lgn+pMxbu4ISt1yjPLRY91opDmoCnRqddGRcCbAsaihJ?=
 =?us-ascii?Q?26zW8xf13Qd01YwVz/Z5GRPXa2Z7A/09RAWc0Ltm0GPsk0IQ5mHKNUhD9qw4?=
 =?us-ascii?Q?DXiTaDPHNQ7wT34QWGD5JGNQBoCi55yo7/FJZOWrkI8EuYcY9Cl5BapAVARq?=
 =?us-ascii?Q?3KGJ5jwrYv0escTleu4jIVoptYBlkpyRyaNmuEymjRaDSz+B5eN7GuhZL9tR?=
 =?us-ascii?Q?JSiejZ2LEQjg/+V7obPwykhJpAJI/NaVI7gLhtGpvYjdD/TOpGggRRqEcgNn?=
 =?us-ascii?Q?UyXrN8gplh0AnQHHdRc8OIEMZAMSRf2tO25/zyRWe9e0qYjf8Bt1aEsFNsoh?=
 =?us-ascii?Q?qmODR9uJK/HjHwK9QvI2sN4yAAIF8guJ2T1YAnWbE5uHgPdy7Fm1jChmtEB/?=
 =?us-ascii?Q?c1yeDP2oPMd0YgyXLnsGn4jtUvF+qLUuTGBVtki9Y2FOOsES0npxHsRZuj07?=
 =?us-ascii?Q?Rvq5nnQ0q0kHY7csBddld4qIaa+vcSK5/7s5iGY5azr9DGcu6MWGBu3e8h3e?=
 =?us-ascii?Q?/bKCvzsv7abLQpOLk2eG0La3Ox3EjVRb/UyKSucHW9BvoIlmVZd6rKcSWtlu?=
 =?us-ascii?Q?Odu2oQc1bq0QfXBFgvGtc0P2svYzB7GGNmMfoHHkNoHvNLlWsqQ4JPh5BBWV?=
 =?us-ascii?Q?5Bby82c9/yDwkqSqmbaXxwVqgnNEH89FqwXj9Ob6gXar+U4sz0gt/lW9L7cC?=
 =?us-ascii?Q?GLQx5YRX57hTi0EtKWHMZMWegL7BFpRNFpFJ/yfqcXFirk0SUrzP/5Vlm0+c?=
 =?us-ascii?Q?1km//bHSQXAqhzlZYQ1kFUk8/bmCm9nyp1m1eMOWtFAV6mneO3rnfR3S2OrO?=
 =?us-ascii?Q?EHLTFlIbiL6WRotgCWzoAQoXvLDjtm3b42CUKrduYdn0O1iohE/yB5q/AkvD?=
 =?us-ascii?Q?LEhWNK3C1VWbTKSCTN+/AyG3eF2FYCJPTwCcDsGqMgDTBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1tkvNJs1RdQpAlGPX6e1jI1u3X6x7nzOlgNaoJ/s/H3d29rqO0GDmjN2GgJJ?=
 =?us-ascii?Q?dyVs04k5C9ef9lRCaNIA6N3ZZ2QjfXwi9GUvyz3lIbp5ESm68wiD+Rt3Vs/r?=
 =?us-ascii?Q?Bk6zg0e5V5LVId3An5s7x9nt0/3RV/nUuKaaAh7X6I05B2zKDkSl5XZ4GMZm?=
 =?us-ascii?Q?CpJ+MtiuhOOmTs+aEiB0LaFlrtxA0IrHv+5k1dKL1KHa8kt2onKpSRzNJ0mv?=
 =?us-ascii?Q?TW32men87EhE8EEAXNKrQMB8b2jQtLRS4ubcGgcvnILG8yURPSFTDNmdx/HD?=
 =?us-ascii?Q?9LeeHmNNII2aNAfzJxuXUs7KVQmXliVtBQAfkob7vO9JseuEJUppRZnGvk8d?=
 =?us-ascii?Q?5e736yU8vzJf62+muCXP6XUlfKk+oUBnpHsoxEl5SeFdoZwC7RyySqN9mtw8?=
 =?us-ascii?Q?LleyEbt7vlxh5cfaHZINHYbF/A4qXqLj2QmRbQT0JIqIFlwBg12eCoQv2mDA?=
 =?us-ascii?Q?rxvg5wzgWS0QM12MCOFIOlyc4lol57AleK0DOPFUCj11AJAXSyxZRnCe5tU2?=
 =?us-ascii?Q?wYcVun5Dk48A/Rnq+eABwRBooKjNGOKcB3Pm/PgSEOD0NZ91EH4zwkgLCjvQ?=
 =?us-ascii?Q?Ko0ptGcfvvjMTP8fbtwVhw/EWse4RrXb12ZZ2PG5OWAtEqZ3jawbeDncFU44?=
 =?us-ascii?Q?3/3g6KbFT0U1QNpPBIVeOr0fqcgvKTLipJPHk08DyTYOjuTP2mQRxnBfMQUw?=
 =?us-ascii?Q?EQ87L1wImyy3FeBeDpLfC9SL8H+Luav80UXrOuhRFg93LmSUMZYZQ8PdDOjR?=
 =?us-ascii?Q?oCBChOeaRCTig9x5ZT6mhYWIPe8JBzLbHQBPF+SFgfiWgRjnMQrk5lHUCVIP?=
 =?us-ascii?Q?T19YaIBJqaGni0fguYyvhPO+GEJsVc19bfnRE5FkwZNVtrPVt+wplOINjp7w?=
 =?us-ascii?Q?MpzWbjfPGpDqxfONc0A2b2qDMS0IhXCfLiSRxY6ECoS9DNxtc2hEJfgHyi/M?=
 =?us-ascii?Q?u/vtx2hok2T/+gIPZXgZQaxZuNM7/YYaz8aXsDub/WZswKQ8IDWSX6qh/5oI?=
 =?us-ascii?Q?FrrFmS4eLjfNQrlXMaXWYZ5H4sRtgWWFAtik6F1i0O+H08Hy5JziXKMsvozF?=
 =?us-ascii?Q?aV0pzpB6Ey0zBMaXZVHtXiIiwvsIJ94C8opJP1e9sbu2Jl4rLSJ8PWEH+Db8?=
 =?us-ascii?Q?b9FrUmF3WIQ4FZK5jHZIhLNYmwEZ+3pl7WEWoCAucV8SqDBM5GGElYW66fy+?=
 =?us-ascii?Q?493Vz4ukGO4qmELVsifU+VuhdD5O8vCtGM539xIXH4H62GQ6apb1JLPE19/n?=
 =?us-ascii?Q?/e0dmOshYpbLtqdjlWxf4Z5I+AuyKENf94uNoB/SkVUyJUl5BQeNQAmlxooU?=
 =?us-ascii?Q?v3apu1g4Cv+l8Crb0Gq6FJBEzzC3XoAPMktiaiIEwNg4BMRBO4ieDwFwxZ7o?=
 =?us-ascii?Q?vB2JsSQiyn23chEHf9x2IrFAuGVYG/Tz6p4eSAXGILKnTwPPs+9oDMM5JZnk?=
 =?us-ascii?Q?4jN/mH+OONVSoskp1T1jjoipSM3/QyU5iarrvhRnaVoj53cr5CpaPgwzfKPs?=
 =?us-ascii?Q?1Pc6+Xa5YkFOqweoRBWABDkOmJKRfkUt9aVypsmu9uwBaGuEZuL28iWGRw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14840b55-b4d7-487a-892c-08dc7eec578e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 08:01:12.5815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+5mvAXGuTbrlLbmpOAW3nBAbWrqE/nS410N3HbalfpEgNVbAeevbbHIKK45flO9twOOUC28n7AqI7Z7bJUL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, May 28, 2024 00:29
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Kamal, Asad=
 <Asad.Kamal@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Sepe=
hr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>; Poa=
g, Charis <Charis.Poag@amd.com>; Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode

Add extra flag definition for ids_flag field to distinguish between vf/pf/p=
t modes

v2: Updated kms driver minor version & removed pf check as default is 0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-  drivers/gpu/drm/amd/amdg=
pu/amdgpu_kms.c |  9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 2da76fadf6ea..60d5758939ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -116,9 +116,10 @@
  * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
  * - 3.56.0 - Update IB start address and size alignment for decode and en=
code
  * - 3.57.0 - Compute tunneling on GFX10+
+ * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF &
+ AMDGPU_IDS_FLAGS_MODE_PT
  */
 #define KMS_DRIVER_MAJOR       3
-#define KMS_DRIVER_MINOR       57
+#define KMS_DRIVER_MINOR       58
 #define KMS_DRIVER_PATCHLEVEL  0

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 66782be5917b..260cd0ad286d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -869,6 +869,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)
                if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
                        dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_CONFORMAN=
T_TRUNC_COORD;

+               if (amdgpu_passthrough(adev))
+                       dev_info->ids_flags |=3D (AMDGPU_IDS_FLAGS_MODE_PT =
<<
+                                               AMDGPU_IDS_FLAGS_MODE_SHIFT=
) &
+                                               AMDGPU_IDS_FLAGS_MODE_MASK;
+               else if (amdgpu_sriov_vf(adev))
+                       dev_info->ids_flags |=3D (AMDGPU_IDS_FLAGS_MODE_VF =
<<
+                                               AMDGPU_IDS_FLAGS_MODE_SHIFT=
) &
+                                               AMDGPU_IDS_FLAGS_MODE_MASK;
+
                vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE=
;
                vm_size -=3D AMDGPU_VA_RESERVED_TOP;

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 5b6c0055cfcf..ae3f4e275f20 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -754,6 +754,16 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_IDS_FLAGS_TMZ            0x4
 #define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8

+/*
+ *  Query h/w info: Flag identifying VF/PF/PT mode
+ *
+ */
+#define AMDGPU_IDS_FLAGS_MODE_MASK      0x300
+#define AMDGPU_IDS_FLAGS_MODE_SHIFT     0x8
+#define AMDGPU_IDS_FLAGS_MODE_PF        0x0
+#define AMDGPU_IDS_FLAGS_MODE_VF        0x1
+#define AMDGPU_IDS_FLAGS_MODE_PT        0x2
+
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING              0x00
 /* get the crtc_id from the mode object id? */
--
2.42.0

