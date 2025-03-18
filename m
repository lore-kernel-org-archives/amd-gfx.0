Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A0C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6916110E3F8;
	Tue, 18 Mar 2025 09:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2hkLOWi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F9F10E3F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 09:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+ujlHCNFBLFP9/uUF2abq2P7XHPnvse4W4CUSZEKB3e9eFXSa0nPlKD56P9ELQEEPzwk9mjlxYL0kbsNqWOmEB17uJ388wqTC5apTnlQppTOW+l0wCBR4vfCaPBiw5uqflBaeupt7ffCBBei3Er/3y2A2Gxi7O3g8hSB8d51QJscrG58AGGUpd/i1SNh4/IGEXwG9vgMf8i5JKc38CgeLN9YODe4awNU3KYUpjfrioYNFI2sIbmsJZm1l16q6SlvhcbDaLzh6prrsj9FzDYFWeEkyJRtKyT2mqp6yUF0w74+tk5dlsUkHAYJSbr/iAwGOwQhAkHU17L9Msilki6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ywE4HYa3KLsTsQEGY2l8w7BDfdbGIafPOqylgvrbpA=;
 b=dl2vJSSoOuNeR1xn91ijhKwKBu+r69E+/k3DLqOWx8oblXU53vG5n0qyRQrePyBI/EiTEhUzPv5A3T9Anxe+yfWg8V6RDUgy7FJ00Mg40xFSYRISrHH3/eMJ3xkJaDsm8HRLHXSUyr+56itNd4uvoOiOLuXlYGNJvk7Iadb0/OPV9lTuaa9cKnfnwzRKqISTX4VLLswLCsexemV64g1ahkGTSrV+GlyXD6slm9bDck1KxhQeGyMsbyrzoYnaWRWmkPSe9KewmBA99e/33ImWiGpvPbunYUTsW9KUinWulZntE96eQ16+uit54eE0KKZEZxUcDKwp8jeCxRZ4BtiYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ywE4HYa3KLsTsQEGY2l8w7BDfdbGIafPOqylgvrbpA=;
 b=N2hkLOWi3Lu10YsX3wa/22HOxaT5kJ9Gy7yaCVjEgEOJVCSPEKDNLgFJrnsfreIzSainOzL9psjoYp4wlkcbda1vq1akAoZ3dxtHDL0JkIObD9QAscPjX4f8mcxMhZw1wBAXPi61WnY7WtjMcZqeK/aVqdDnGnZgQI2pMdwztOA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:18:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:18:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank
Thread-Topic: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank
Thread-Index: AQHbl+ZRxX1VMoG8Q0S4zECrpRkIqbN4nXkw
Date: Tue, 18 Mar 2025 09:18:30 +0000
Message-ID: <BN9PR12MB52570445292CD2DE422630B0FCDE2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250318091513.544679-1-xiang.liu@amd.com>
In-Reply-To: <20250318091513.544679-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: KevinYang.Wang@amd.com,Tao.Zhou1@amd.com,YiPeng.Chai@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4143f49f-a47f-4dcc-a30f-42c88b41bd39;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-18T09:17:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6037:EE_
x-ms-office365-filtering-correlation-id: 6afb1402-d818-452c-f189-08dd65fdd99b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YsDF94VL6h1e3cBuS3ij5rZAmB8ORxQGdA0req+y/8zI8zlJ9E8RHlzxwnk6?=
 =?us-ascii?Q?+mB3CVq43GdQz5yKeyaG3n6fzDyKU3ZnsGpepzCsZv2E5Dd0nemKnesfLeWz?=
 =?us-ascii?Q?IoPzbXrBvhPDlrJJ0s4HxX4roCO9SZLbol7FmpFFrRg6icDUbp2vaZbyWFjt?=
 =?us-ascii?Q?CWk6UsIEn6SjBU2rGurx9JOGPuD85sgeXdhjTJ4dfROdid04wZEmEVc/AcED?=
 =?us-ascii?Q?ZbJNgd+ysdzjeEerJ9eR0WmsRLpyl1LEELhg+jiajsxF9j57xRqUFcDJ2rZd?=
 =?us-ascii?Q?WuibZSxmTfFk+gQ3q4d3VDClIbwSTE+8JXLTh9rkNNdOHo7XBK1zHYYidQzX?=
 =?us-ascii?Q?D84CCXAPInaELYkbAPyOLGA2kbksg3U1mFtB2OY6GaDPvxkQpG8D3i8UoCdi?=
 =?us-ascii?Q?cwWZG1sPB1o/TiLcyEuyqXuT1/gYuQlbhXgjVHsPhgjKZjmg8dxcufoVwrQj?=
 =?us-ascii?Q?KJOP06axPtTGb80xgbJHmEXWeICH6GznnR/1B3CHLiSItV/m4upN/AddbS1e?=
 =?us-ascii?Q?XNexrzhdn1qreJXNKiPpJz2qZtunDd7nHdeYASu1MdcXOyFYZuQjhr8S5YCj?=
 =?us-ascii?Q?3gCyMdEBBpre17ALqbNCEJFJTq0lkihl7HfyRHtQifZwWtTz3RJg9jJ6Z7c5?=
 =?us-ascii?Q?uBNBaNIz5DtWQi1coyHeS92q/LsnxPAJ6UxyPX0lwT6GLzubFkhRWKRLaXLm?=
 =?us-ascii?Q?CB7KtPQvua1wcEPPNyIErwYgxfj7kDRyTqDXq2Rwl9tV0PTAIiDZcSGWBqnt?=
 =?us-ascii?Q?Svzl2ZnwEkHv86FCPkmW7ZY14h74Z2hyx8i2KBlIHOyqKqzIj06PkDuxfQHr?=
 =?us-ascii?Q?JZWrUFa4K8zadobxOWx0Au5VXF/X1AklFgmlUmn++Zv0uZAcjK+3ftJzSTxk?=
 =?us-ascii?Q?w+YLLew+3rbLTbbmOC0dlW0jJ2GNhbNYVllWLiuNY+lY3eTy7w+uymFnbV4U?=
 =?us-ascii?Q?4tg/F+qiF9I+TPOsDRoC2XZZhVrzFwZoTDPpxDg+1pjdNC0wMdeutxF8RodM?=
 =?us-ascii?Q?SCMWXf47EJcWLLBbxnyS4hIoNtdvRwx7wJVvji/qFLzZJA09IFZde09dbYFO?=
 =?us-ascii?Q?wvDfPktwVY5+GaJd/XqXyI/glILGCTFr5A7Pl5psLM7gChll/8N1rzrC3Tbr?=
 =?us-ascii?Q?H5wwp06JbnuD1znNYvr5t8y/cWebZgS+bDIWUgr2lln1QwdA6pRslq9XNjO9?=
 =?us-ascii?Q?zpZvQQavCJqiBYVs0tp4cEDtT05MSXrI0kpv2wp/vS27xCYf94YZgXGcwS+P?=
 =?us-ascii?Q?W5vL788ZfHBI2VzASYIg+TzEZbrZEu7ARi8jrPLJR6pKmSJRHoMOgYkqx7M0?=
 =?us-ascii?Q?IYNNLA+RSKKmV1oFUJrPafUIGMBGNPvnbzuzUrTs4LC0cfx+cf8xlH/qGpOY?=
 =?us-ascii?Q?/DoMHUkdLUusVkX0IK+2daUHMgTEoDu/KwJ9yfLmFxGDUH+0X90uK8kXEQ4w?=
 =?us-ascii?Q?YPtwzVI8pJNV7HcodkIamIhxkGOii90s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fpR1b2id6KCjlUhqavz58j0eKe4kaW84IYGYo1EAlHl9dZpXtZZyT7fFiaM?=
 =?us-ascii?Q?zrlHvSLfjDW7FLkR+lAnDuZ37onYiwp5L87HptTj3prSspz13zUR6fbcdom/?=
 =?us-ascii?Q?A4TGOxvnaDdyB2Nw7EMi3DK4TO+CX9dv1fnXA/ue0jpXFLuG/MC9a/A7n6p+?=
 =?us-ascii?Q?7CGeS7oTngl5arhKLW7cvEtW/NL/UWXlyfebtx4SJ+zz/5ZFOSDQ34T9GxOj?=
 =?us-ascii?Q?0vluPwRD61NU1c/SrQWNM8ZpunZiYO3ReQWAGGRI2JcQ+kOEScf3FGbxeoJ5?=
 =?us-ascii?Q?nDL5aUfh6OFnmBwrjN0ioifnQqVAMTd5/R4Sn5/JlmhCcaKaYLZrDb/xOF5h?=
 =?us-ascii?Q?No6cLyo7mm8+fGX1lP8P9INkrFFFC6veBiX+EPI4tBbIorsy1uaGWAkCVy5B?=
 =?us-ascii?Q?gTTF86R7IFDmzBLu22V0ynTOr+gFbhPykyIU5ModSY3V8V5MLlGOriyRb8Cu?=
 =?us-ascii?Q?i7XMzk3T7+OdFYjiFGy6TWVH/NIqIukWGIBvTMKdgmC2xZ94xYosRnHb231t?=
 =?us-ascii?Q?T/1SLISpQatVHNG+t0hyOkAd7/Ch/gUO1CRki80EZN/WaTLkHlEx8fpYbaKS?=
 =?us-ascii?Q?Rni3YqUyNAJo7KiCrthrEQoYaakPOzZraJGZEk56i1n3WT3PHAhRw4BNZ9SI?=
 =?us-ascii?Q?xIGZ5OShQ9Zg79ftt0ycQwn5udG5hIsL2MK73lqpU80+NGCTqRUJgpvBpSmC?=
 =?us-ascii?Q?aY9aBQ5/JZPYpIv5e38KVkk5x/QR/1GQKBoxFgDuJi7HVgVB6mvG2PU0Rr6x?=
 =?us-ascii?Q?YNMbbi6WMHdSCbwZF+T8U+Ga3fksLXu0T79rVPmEi+2YbToLTfZGNpxAOok5?=
 =?us-ascii?Q?uYvj9ajXbwv9/cfnZQnresooJsoQv3T1MdGtDpq+OWv2GhxvBF+kmY2wQnA0?=
 =?us-ascii?Q?KbDZZHebcWCb6/kX4n//MCoEOSbzR0dRaGXDD2YuCxRp7NIarRYAuvx5zD88?=
 =?us-ascii?Q?4p5n6FXsmqx9TvTrrOu6fCwuvxK5yAibxaH+L9uChYp1q5BZnZs0ln7ji4yY?=
 =?us-ascii?Q?8FoYrhJF/6A9dzPnCZaxkZ0kB7NjLjKloAaeWKPsU6V48GVil/T+dsUe6Bi0?=
 =?us-ascii?Q?iuSVyLAd8B5ZbeqapYuLUILJPSLsAV3UzriBsjCgm/gGCJ7zH2fx4NyxU+17?=
 =?us-ascii?Q?bK6N5DYfVam6IgLo2DpYv68WfvqMzJwDnXguvqitAeYITlDO3/WmJyT018y5?=
 =?us-ascii?Q?RJ4fKNBIbMy2Za7T8n5WHF39BrcL38vhWDWChxOLZjUYyQNQ8rLUbki5ZtCa?=
 =?us-ascii?Q?ZKofxVvNd12lkkTIquk/zMWlhkIpg665dwIlsHSr+8d9G0aI7xXcrvmWIf86?=
 =?us-ascii?Q?T2dFC8MVRqhQlk44vwG4cLyXUVD0e4ZKdX9i6C/l9B26i7Qmyuux3xSH0KHA?=
 =?us-ascii?Q?y49GwwXO0hwZUZMyH2CFuWybkbCKhGHg1hSAOzRrjryU9iQmH2WqeB4VgNHI?=
 =?us-ascii?Q?blKwQd9vSchzyC4kXF4iTTJ7bzr1VtoTWZfTQigHOL81pJxtbFi3Dkx0TnEe?=
 =?us-ascii?Q?4NpQ1nW6iGq6zzkFmBneqb8nfA+pa9cu7S67gv2b5VueFJvcPgmN32SQg+hC?=
 =?us-ascii?Q?805uCnfkhQvSEw/HO2k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52570445292CD2DE422630B0FCDE2BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afb1402-d818-452c-f189-08dd65fdd99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 09:18:30.7924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnOjUmKd5ZEHVvZ3muuTxVU/G6GPfuI2pymEVi9jiqZg9+ya/bTwKE1y03G/M4LS3sS85eDDGZGAGCQRIHdX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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

--_000_BN9PR12MB52570445292CD2DE422630B0FCDE2BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


+ @Wang, Yang(Kevin)<mailto:KevinYang.Wang@amd.com>/@Zhou1, Tao<mailto:Tao.=
Zhou1@amd.com>/@Chai, Thomas<mailto:YiPeng.Chai@amd.com> for the review.

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, March 18, 2025 17:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank

The aca handle is introduced by upper caller, it's inappropriate to poll ac=
a handle to match and validate aca bank, which will cause unexcepted ras er=
ror report.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 122 ++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  10 +-
 3 files changed, 58 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..b07e101c545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -122,6 +122,25 @@ static void aca_smu_bank_dump(struct amdgpu_device *ad=
ev, int idx, int total, st
                              idx + 1, total, aca_regs[i].name, bank->regs[=
aca_regs[i].reg_idx]);  }

+static bool aca_bank_should_dump(struct amdgpu_device *adev, enum
+aca_smu_type type) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       bool ret =3D true;
+
+       /*
+        * Because the UE Valid MCA count will only be cleared after reset,
+        * the aca bank is only dumped once during the gpu recovery stage.
+        */
+       if (type =3D=3D ACA_SMU_TYPE_UE) {
+               if (amdgpu_ras_intr_triggered())
+                       ret =3D atomic_cmpxchg(&aca->ue_dump_flag, 0, 1) =
=3D=3D 0;
+               else
+                       atomic_set(&aca->ue_dump_flag, 0);
+       }
+
+       return ret;
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_smu_type type,
                                       int start, int count,
                                       struct aca_banks *banks, struct ras_=
query_context *qctx) @@ -130,6 +149,7 @@ static int aca_smu_get_valid_aca_b=
anks(struct amdgpu_device *adev, enum aca_smu_
        const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
        struct aca_bank bank;
        int i, max_count, ret;
+       struct aca_bank_node *node;

        if (!count)
                return 0;
@@ -159,14 +179,16 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_=
device *adev, enum aca_smu_
                        return ret;

                bank.smu_err_type =3D type;
-
-               aca_smu_bank_dump(adev, i, count, &bank, qctx);
-
                ret =3D aca_banks_add_bank(banks, &bank);
                if (ret)
                        return ret;
        }

+       i =3D 0;
+       if (aca_bank_should_dump(adev, type))
+               list_for_each_entry(node, &banks->list, node)
+                       aca_smu_bank_dump(adev, i++, count, &bank, qctx);
+
        return 0;
 }

@@ -318,72 +340,29 @@ static int handler_aca_log_bank_error(struct aca_hand=
le *handle, struct aca_bank
        return 0;
 }

-static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_ba=
nk *bank,
-                            enum aca_smu_type type, bank_handler_t handler=
, void *data)
-{
-       struct aca_handle *handle;
-       int ret;
-
-       if (list_empty(&mgr->list))
-               return 0;
-
-       list_for_each_entry(handle, &mgr->list, node) {
-               if (!aca_bank_is_valid(handle, bank, type))
-                       continue;
-
-               ret =3D handler(handle, bank, type, data);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
-}
-
-static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_b=
anks *banks,
+static int aca_dispatch_banks(struct aca_handle *handle, struct
+aca_banks *banks,
                              enum aca_smu_type type, bank_handler_t handle=
r, void *data)  {
        struct aca_bank_node *node;
        struct aca_bank *bank;
-       int ret;

-       if (!mgr || !banks)
+       if (!handle || !banks)
                return -EINVAL;

        /* pre check to avoid unnecessary operations */
-       if (list_empty(&mgr->list) || list_empty(&banks->list))
+       if (list_empty(&banks->list))
                return 0;

        list_for_each_entry(node, &banks->list, node) {
                bank =3D &node->bank;

-               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
-               if (ret)
-                       return ret;
+               if (aca_bank_is_valid(handle, bank, type))
+                       handler(handle, bank, type, data);
        }

        return 0;
 }

-static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_sm=
u_type type) -{
-       struct amdgpu_aca *aca =3D &adev->aca;
-       bool ret =3D true;
-
-       /*
-        * Because the UE Valid MCA count will only be cleared after reset,
-        * in order to avoid repeated counting of the error count,
-        * the aca bank is only updated once during the gpu recovery stage.
-        */
-       if (type =3D=3D ACA_SMU_TYPE_UE) {
-               if (amdgpu_ras_intr_triggered())
-                       ret =3D atomic_cmpxchg(&aca->ue_update_flag, 0, 1) =
=3D=3D 0;
-               else
-                       atomic_set(&aca->ue_update_flag, 0);
-       }
-
-       return ret;
-}
-
 static void aca_banks_generate_cper(struct amdgpu_device *adev,
                                    enum aca_smu_type type,
                                    struct aca_banks *banks,
@@ -417,20 +396,14 @@ static void aca_banks_generate_cper(struct amdgpu_dev=
ice *adev,
        }
 }

-static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type =
type,
-                           bank_handler_t handler, struct ras_query_contex=
t *qctx, void *data)
+static int aca_banks_update(struct amdgpu_device *adev, struct aca_handle =
*handle,
+                           enum aca_smu_type type, bank_handler_t handler,
+                           struct ras_query_context *qctx, void *data)
 {
-       struct amdgpu_aca *aca =3D &adev->aca;
        struct aca_banks banks;
        u32 count =3D 0;
        int ret;

-       if (list_empty(&aca->mgr.list))
-               return 0;
-
-       if (!aca_bank_should_update(adev, type))
-               return 0;
-
        ret =3D aca_smu_get_valid_aca_count(adev, type, &count);
        if (ret)
                return ret;
@@ -442,15 +415,12 @@ static int aca_banks_update(struct amdgpu_device *ade=
v, enum aca_smu_type type,

        ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, q=
ctx);
        if (ret)
-               goto err_release_banks;
+               return ret;

-       if (list_empty(&banks.list)) {
-               ret =3D 0;
-               goto err_release_banks;
-       }
+       if (list_empty(&banks.list))
+               return 0;

-       ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
-                                handler, data);
+       ret =3D aca_dispatch_banks(handle, &banks, type, handler, data);
        if (ret)
                goto err_release_banks;

@@ -537,7 +507,7 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        }

        /* update aca bank to aca source error_cache first */
-       ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
, qctx, NULL);
+       ret =3D aca_banks_update(adev, handle, smu_type,
+handler_aca_log_bank_error, qctx, NULL);
        if (ret)
                return ret;

@@ -730,7 +700,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
        struct amdgpu_aca *aca =3D &adev->aca;
        int ret;

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);

        ret =3D aca_manager_init(&aca->mgr);
        if (ret)
@@ -745,14 +715,14 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)

        aca_manager_fini(&aca->mgr);

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);
 }

 int amdgpu_aca_reset(struct amdgpu_device *adev)  {
        struct amdgpu_aca *aca =3D &adev->aca;

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);

        return 0;
 }
@@ -880,12 +850,20 @@ static int handler_aca_bank_dump(struct aca_handle *h=
andle, struct aca_bank *ban  static int aca_dump_show(struct seq_file *m, e=
num aca_smu_type type)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)m->private;
+       struct aca_handle_manager *mgr =3D &adev->aca.mgr;
+       struct aca_handle *handle;
        struct aca_dump_context context =3D {
                .m =3D m,
                .idx =3D 0,
        };

-       return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (v=
oid *)&context);
+       if (list_empty(&mgr->list))
+               return 0;
+
+       list_for_each_entry(handle, &mgr->list, node)
+               aca_banks_update(adev, handle, type, handler_aca_bank_dump,=
 NULL,
+(void *)&context);
+
+       return 0;
 }

 static int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_aca.h
index 6f62e5d80ed6..e71d6f5afaec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,7 +202,7 @@ struct aca_smu_funcs {  struct amdgpu_aca {
        struct aca_handle_manager mgr;
        const struct aca_smu_funcs *smu_funcs;
-       atomic_t ue_update_flag;
+       atomic_t ue_dump_flag;
        bool is_enabled;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..a4038e92c59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

+       status =3D bank->regs[ACA_REG_IDX_STATUS];
+       if (!ACA_REG__STATUS__VAL(status))
+               return 0;
+
        ret =3D aca_bank_info_decode(bank, &info);
        if (ret)
                return ret;
@@ -894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
        switch (type) {
        case ACA_SMU_TYPE_UE:
                bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               if (ACA_REG__STATUS__UC(status) && ACA_REG__STATUS__PCC(sta=
tus))
+                       ret =3D aca_error_cache_log_bank_error(handle, &inf=
o,
+ACA_ERROR_TYPE_UE, 1);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1


--_000_BN9PR12MB52570445292CD2DE422630B0FCDE2BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ <a=
 href=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#2B579A"><span style=
=3D"background-color:#E1DFDD;">@Wang, Yang(Kevin)</span></font></a>/<a href=
=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#2B579A"><span style=3D"backgr=
ound-color:#E1DFDD;">@Zhou1,
Tao</span></font></a>/<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D=
"#2B579A"><span style=3D"background-color:#E1DFDD;">@Chai, Thomas</span></f=
ont></a> for the review.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt; <br>

Sent: Tuesday, March 18, 2025 17:15<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Xiang(Dean) &lt;Xian=
g.Liu@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
aca handle is introduced by upper caller, it's inappropriate to poll aca ha=
ndle to match and validate aca bank, which will cause unexcepted ras error =
report.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 122 ++++++++++--------------</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.h |&nbsp;&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |&nbsp; 10 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 3 f=
iles changed, 58 insertions(+), 76 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x ffd4c64e123c..b07e101c545d 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
122,6 +122,25 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, =
int idx, int total, st</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total, aca_regs[i].name, bank-&gt;regs[=
aca_regs[i].reg_idx]);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool aca_bank_should_dump(struct amdgpu_device *adev, enum </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_smu_type type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because the UE Valid MCA count wi=
ll only be cleared after reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the aca bank is only dumped once =
during the gpu recovery stage.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_SMU_TYPE_UE) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_ras_intr_triggered())</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D atomic_cmpxc=
hg(&amp;aca-&gt;ue_dump_flag, 0, 1) =3D=3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-=
&gt;ue_dump_flag, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_sm=
u_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int start, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct aca_banks *banks, struct ras_query_context *qctx) @@ -130,6 +1=
49,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, =
enum aca_smu_</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *sm=
u_funcs =3D aca-&gt;smu_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank bank;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, max_count, ret;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
159,14 +179,16 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_devi=
ce *adev, enum aca_smu_</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank.smu_err_type =3D type;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank, qctx);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aca_bank_should_dump(adev, type))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; list_for_each_entry(node, &amp;banks-&gt;list, node)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_smu_bank_dump(ad=
ev, i++, count, &amp;bank, qctx);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
318,72 +340,29 @@ static int handler_aca_log_bank_error(struct aca_handle *=
handle, struct aca_bank</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *=
bank,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum aca_smu_type type, bank_handler_t handler, void *data)</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handle, &amp;mgr-&gt;=
list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D handler(handle, bank, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks=
 *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_dispatch_banks(struct aca_handle *handle, struct </span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_banks *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_smu_type type, bank_handler_t handler, =
void *data)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank *bank;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mgr || !banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle || !banks)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pre check to avoid unnecess=
ary operations */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list) || list=
_empty(&amp;banks-&gt;list))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks-&gt;list))</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(node, &amp=
;banks-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank =3D &amp;node-&gt;bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler(handle, bank=
, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_ty=
pe type) -{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because the UE Valid MCA count wi=
ll only be cleared after reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in order to avoid repeated counti=
ng of the error count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the aca bank is only updated once=
 during the gpu recovery stage.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_SMU_TYPE_UE) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_ras_intr_triggered())</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D atomic_cmpxc=
hg(&amp;aca-&gt;ue_update_flag, 0, 1) =3D=3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-=
&gt;ue_update_flag, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic void aca_banks_generate_cper(struct amdgpu_device *adev,</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_smu=
_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_b=
anks *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
417,20 +396,14 @@ static void aca_banks_generate_cper(struct amdgpu_device =
*adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type=
,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bank_handler_t handler, struct ras_query_context *qctx, void *data)</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_banks_update(struct amdgpu_device *adev, struct aca_handle *han=
dle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum aca_smu_type type, bank_handler_t handler,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct ras_query_context *qctx, void *data)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_banks banks;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 count =3D 0;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;aca-&gt;mgr.list))</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aca_bank_should_update(adev, type))<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_=
count(adev, type, &amp;count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
442,15 +415,12 @@ static int aca_banks_update(struct amdgpu_device *adev, e=
num aca_smu_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_=
banks(adev, type, 0, count, &amp;banks, qctx);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks.list)) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks.list))</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_banks(&amp;aca-&gt;m=
gr, &amp;banks, type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_banks(handle, &amp;b=
anks, type, handler, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
537,7 +507,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev,=
 struct aca_handle *h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update aca bank to aca sour=
ce error_cache first */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_banks_update(adev, smu_type, =
handler_aca_log_bank_error, qctx, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_banks_update(adev, handle, sm=
u_type, </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+han=
dler_aca_log_bank_error, qctx, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
730,7 +700,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &am=
p;adev-&gt;aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_manager_init(&amp;=
aca-&gt;mgr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
745,14 +715,14 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_manager_fini(&amp;aca-&gt;=
mgr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_aca_reset(struct amdgpu_device *adev)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &am=
p;adev-&gt;aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
880,12 +850,20 @@ static int handler_aca_bank_dump(struct aca_handle *handl=
e, struct aca_bank *ban&nbsp; static int aca_dump_show(struct seq_file *m, =
enum aca_smu_type type)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 (struct amdgpu_device *)m-&gt;private;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager *mgr =3D &amp;a=
dev-&gt;aca.mgr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_dump_context contex=
t =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .m =3D m,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .idx =3D 0,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_banks_update(adev, type, handl=
er_aca_bank_dump, NULL, (void *)&amp;context);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handle, &amp;mgr-&gt;=
list, node)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_banks_update(adev, handle, type, handler_aca_bank_dump, NULL, </=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+(vo=
id *)&amp;context);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git a/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ac=
a.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6f62e5d80ed6..e71d6f5afaec 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
202,7 +202,7 @@ struct aca_smu_funcs {&nbsp; struct amdgpu_aca {</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager mgr;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *sm=
u_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ue_update_flag;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ue_dump_flag;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_enabled;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x c0de682b7774..a4038e92c59e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *=
handle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void *data)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0, status;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instlo;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D bank-&gt;regs[ACA_REG_IDX_STAT=
US];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ACA_REG__STATUS__VAL(status))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_bank_info_decode(b=
ank, &amp;info);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *ha=
ndle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_UE:</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_ERROR_TYPE_UE;</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ACA_ERROR_TYPE_UE, 1ULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ACA_REG__STATUS__UC(status) &amp;&amp; ACA_REG__STATUS__PCC(stat=
us))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_error_ca=
che_log_bank_error(handle, &amp;info, </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ACA=
_ERROR_TYPE_UE, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_CE:</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB52570445292CD2DE422630B0FCDE2BN9PR12MB5257namp_--
