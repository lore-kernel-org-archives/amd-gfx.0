Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC30D41C1B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3143110E373;
	Wed, 13 Nov 2024 09:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLZrMNvD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C54110E373
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7nfEOjzQKWuo59zVHG9mzSEJFlVNElRnJlALKF3d6VRJ6V0rsdERLhZeiSm/tR8FVu8sLRKad7HgQAA3Y9/BaZAtyfBmdi9ZIwf2dKwE1RcWnPFSnosQeIaQ04kJ5fLyK+/iVrlouBir1mVHS0Ownk8ccDldjuVG03LyzgMVjawG5YknPVXUEQ/U2grK9wpE2IE9+a6po679dj+ezVbh0rlodGjF4MlkvfLxXIRn4sACbt6DSdSWfXnjwro3UqY6LL7PFVbkv41iYri0KzG48AIR0dS+GhZI4eL/eLzIB9508NaxTPnPLmIDRt4UrD6lYdPBfMk3M4llARHqGg7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx1iE77XqQdeHHw3AP+oa21Yvrs+W9HjsbFBNFJ1wTI=;
 b=L2Z7fPV01eCBZZf7D64b2IgdxDSgdwYnswnBUJlJberylnb5CmYHQBWT+227t58REg6iEOY2OFXkA7Uy3+9HFvL8FfMTeBRViXY76FegmOarmW91pY4G4nasRsoF73OHDJjXZ2K3MBM8J/uQIVD4s8w6JvS8zI5CTXS9H+wBZqiNCGHzM4ItE6GG7EwkTGCyi784xBqZeCESQxzgNpXq74S1IezFh9Sh8y5hU6jq2rzipiLON8FjKEHFQPtvvRJT5kUpaH0kVOqX40ARstGaSPpGRsmKAC9uUcOyxjUTeV1x1PRn1KZbJwA324FAAzJJKBpzNOgfxR9NcOU0aRm6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx1iE77XqQdeHHw3AP+oa21Yvrs+W9HjsbFBNFJ1wTI=;
 b=hLZrMNvDpv2iKEOsC5zisV337EGJyZ5Zd4VOTQRjB2jKkdBzZYYU42Z4SyNMlL0zbA30xNMqCiMv6YdgAOh8mlwFXA93NAQ7dgnkxgnBDrLdiTdFceYXt+DVZehwinbGlQ9AEP1rGQWGJ2ApLgV/DPff/estaSQk+6OQo5EfB/o=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Wed, 13 Nov
 2024 09:03:51 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 09:03:51 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode
Thread-Topic: [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode
Thread-Index: AQHbNar1JTeENI6hmkCthPoCkql7Mw==
Date: Wed, 13 Nov 2024 09:03:51 +0000
Message-ID: <MW5PR12MB56849C04636798AAE6B34719E55A2@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <mailman.6967.1731064483.1132.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.6967.1731064483.1132.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c09dcd9e-f70e-471a-b19d-f23a77c0a092;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T08:58:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: 2913ae07-5e46-4513-5bbd-08dd03c217cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|4022899009|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JN4gl0BheN69+5lWcMdWl7+D6gY6Z4prUfkBT+6PHKXWyYU00j3+At/EfOI5?=
 =?us-ascii?Q?Adp6f0Gb2MjTCqgWYaqMWFtq6hClYlmRogh6eCZYJFHnJe1mAhhFOAaK0VIC?=
 =?us-ascii?Q?L1ghcwA2CyXe1192OIM2ldPfuGlL7tY/hcemPiK5pPFjZa3U9HbxSLhR/5VI?=
 =?us-ascii?Q?h7ZJfni8A/M3/KUTT4pYqRgjhiIuRPr9VryWk0w546Ov2kmOw3B6vLEJJn2l?=
 =?us-ascii?Q?2uL7LqDs8na6Nw3mphRjkP/f6+ySHT/EtSPYfm8O2pzwlTSfAXJzBEn2pa3n?=
 =?us-ascii?Q?jXMxjoa3wg73Z3QB/JNkPnmDk4+mq6L/I4KlPZCab9EbIYU0qpseDnitVuo9?=
 =?us-ascii?Q?EnAz7wt/8hiceMOu/NwyJZS/+aaX1CSxcvOnZc4/NLdHB0VuzG6bWw85t/RJ?=
 =?us-ascii?Q?y0yiYJqOm+87gzOgLdmoKsJ+LdwhRlEs0+LOXF69KLSzxhOYmPP1I07zDyPZ?=
 =?us-ascii?Q?C5uWN7vRoXyGrN/yIY4KH78XQhcWfis3+PirNj8cTsdRA44/9D19jPIjWU9s?=
 =?us-ascii?Q?NqyvHwBqp4YcMmmUtl6t0l99gFxh0OUW2miRjYz4jPjQYSJKKZGFLQRSsSNF?=
 =?us-ascii?Q?Dq69AKEfvwXa3QP7Qg0B2RaKCj0m2TKLHedJ+tjnXauLAtPivVO5mYJ8ChZg?=
 =?us-ascii?Q?vC2HFiubzMh3pxlxSlo0BBB3jzmTvs4nWpQ7rgg4D97Qx2bnXcz/KnozS9Bu?=
 =?us-ascii?Q?BCzw6yg9cezEOZJl1nTxUmKZV2lwyzkfTeu10gwOFJ4rXYe4OMAprHqveqbD?=
 =?us-ascii?Q?4HV9/JV8qgbd9ayPLTVTw6Zy6/bw4RX2H6/q3byuLVvgMHC9/AoDK+hqqC29?=
 =?us-ascii?Q?pclpIe91JGVZV1GS4G1d83nIGRdKVB8jbZpqr9F7DJ9WyqqY4/4ZgG3wzVUg?=
 =?us-ascii?Q?HC0eWtkhz84b3Vc672CC9xqv+fEbdNR58ViW8bgJheWIKPFOyO6Rutqvkfra?=
 =?us-ascii?Q?RrcczB6k8wKTs9bQWRvWVm+/viesamLoQ1pw0Ap4ybK6tn7+5BkeZvKZg5cV?=
 =?us-ascii?Q?GMrfKoCkqerD7791ztGm5uzSDIYdOnJ5vP96g+QTKnwpClzU51nn127mVvxo?=
 =?us-ascii?Q?kPzi01kXvHEL3x4bJncZmUzPlt8h6k1JTTKqsJUseUCIvlRr0WIygxDpo5Tg?=
 =?us-ascii?Q?nDCNYVwgLtpc8B60RZN5H1rKtSF5V9eLizITrQ8qauW2j5acq+tEF1q54D5F?=
 =?us-ascii?Q?F+ye+VWj/0oQpfSYllr4CXUoqFA1vi+N+nwqhWkKLgXp+kLEoRrbYiYdKm0X?=
 =?us-ascii?Q?ubK+SSLvRbQo+8FpmFq3XN/kmcvSoVBDj7nzf6wS6jobCfPlgQ4ONpu4Gzve?=
 =?us-ascii?Q?WAH2tnlKl+h+iP6fSYQ3yXWK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(4022899009)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ajx8JZ6m3FeplWSPga8TpzF8ExwKWSvKgAwUssGmrTUlDQFntlL0kg5RE8Vc?=
 =?us-ascii?Q?2+EHJTBDR/b/MVmXsW1aFcly5He8nPly/PiLtacSdW4V3BZkJtcC4RV4A4fD?=
 =?us-ascii?Q?CaKO3xb5MqSAqzNf9hWLCIgHxtoTCY67gMO/yL3dG8MtaOnfZVXPinkodzxL?=
 =?us-ascii?Q?fkxpSjlkBgGGb04JjQ/7GjbWRaQulJMwlY/x5tXclwnZmTN8EfO+eOfvmwiL?=
 =?us-ascii?Q?07NseNpSaI4tzs0lGSo2o4kNDlwDgTdSaPTXYs/J4LeSy/7Tg1a1iVD2bWqx?=
 =?us-ascii?Q?PYvA1qyT1wgksNYJlzbga2WtxXh2n4v1+NnX6Kd+vMSsEpNzIrlzILmApEt6?=
 =?us-ascii?Q?kWBWQkHYYb3FkEV+qoEJNNhBc8l7bY7b2h81zqaMVSqBC2NYMyxMP4/hYj2y?=
 =?us-ascii?Q?quRUy2NbAySpsKt/0erOxXoaeBuJcm3mgMu+XJk9Yw6Fr4UggbBWGhlD64UL?=
 =?us-ascii?Q?zgxzpFSJkLvro4K5XDCRPxGjfbJRgnsck4gptOstFamIKOXS5Yxukc6N3/a8?=
 =?us-ascii?Q?bjGAgoJT5FMkU0IhJYsGXfmFViD7iQcG4Mou8iIbP6xM4os/mTMh86cS3pU6?=
 =?us-ascii?Q?yIys8qZh/XqmFFTIZZZJE0F9bMXeYV+7Ln8fSXJ239wcMMrHcmIEzJfkivkl?=
 =?us-ascii?Q?+1hicE1mTeCa7HXnZ3spv56PnpjtUlfMFpS1G/RL25UBIku8BpRAPcLybVFL?=
 =?us-ascii?Q?457PIfHDzeWmLS7HatWkMw/u9PqgaEGTWbK/vcD/jtQFQGpilkz4aw2oYEU3?=
 =?us-ascii?Q?jexyfNXQQqWEYvxdBzs/Qj80q6SqV0u5k8I+j8FJtqjUcycmrhmwX5fTJmUk?=
 =?us-ascii?Q?dZHNQg0fs+Q5pefoM5aKXUNOww+0DYJ/qJK9n6p6HMhN/HqEuBvBIebGRKGI?=
 =?us-ascii?Q?G6cPzb09uURDrmkUh1l01W3UVSqfoMeR2auuSbdCT/tjI6r/U0Je3vx6hbvn?=
 =?us-ascii?Q?vw/3AdSzEMSyv2mdmDEuNObkxoOx11oIAgehQnaZmKb42eIrDVG251v1Cat5?=
 =?us-ascii?Q?vzr28KKDTEaKf2WjUg6H79n4L8Yf1dU1xAZxWHuKksjF6T5xlXnX4PpHsKO1?=
 =?us-ascii?Q?vbQynmzSGUbaUGaWedh+0USx1mgI1AKcOoN1i7LM+0YS0pfZqpZaqP1go7Ok?=
 =?us-ascii?Q?MD/WPy3iCCFe74NEsCynbl72dE7i7T/baADig9GiTm8gXJvaDtCT7fqkAv49?=
 =?us-ascii?Q?ZKBRWoKSWNMnh1Y5SC24OrYr7JUJDyJau2Y8FrsJWZQDL/LABDGgro4g9Fxx?=
 =?us-ascii?Q?EELFTvXq43H/MKOtpxSzS8MQSV2wLeS45bOe9zana6Zw0JiBD3Bde05sRwi7?=
 =?us-ascii?Q?dPW+OwueeW6N/ZoKz3AnRSHF/rmJ87E7IV5DCwLiPw+0155kEqaESCZmNs30?=
 =?us-ascii?Q?+DDqaWMBatJIAAvGXh4rRltC3bGMzsE5L8YXv6j8jNmcSVkdXV5zpz/SBTr/?=
 =?us-ascii?Q?Xj/V4LLHxqJK5VtN0WtVjEc4OG2kqgB+urKPdnrIyB687N0YUDpwbDTmo95C?=
 =?us-ascii?Q?eSCIZi6sZpbDt+9NCmtFYiCiobMsWQb+6nN5ITvommk8BblpDLy5P/xHCxJA?=
 =?us-ascii?Q?xEUs7Gl7OoaeoCw//sM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2913ae07-5e46-4513-5bbd-08dd03c217cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 09:03:51.3938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpIUuG93tXI1e4aP1P0RxfbJ0xYjtorPYwhpvRb1iQFBZ0zQQBTKq1bXq0zCeNbSSAnHFr23wBeM0DshohU3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gfx-=
request@lists.freedesktop.org
Sent: Friday, November 8, 2024 7:15 PM
To: amd-gfx@lists.freedesktop.org
Subject: amd-gfx Digest, Vol 102, Issue 101

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific than "R=
e: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode
      switch (Tao Zhou)
   2. [PATCH 03/23] drm/amdgpu: simplify RAS page retirement in one
      memory row (Tao Zhou)
   3. [PATCH 05/23] drm/amdgpu: store PA with column bits cleared
      for RAS bad page (Tao Zhou)


----------------------------------------------------------------------

Message: 1
Date: Fri, 8 Nov 2024 19:14:01 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode
        switch
Message-ID: <20241108111423.60169-1-tao.zhou1@amd.com>
Content-Type: text/plain

There are two types of gpu reset, nps mode switch and normal gpu reset, add=
 a flag to distigush them.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++++++--  drivers/gpu/drm=
/amd/amdgpu/amdgpu_reset.c  | 13 ++++++++++++-  drivers/gpu/drm/amd/amdgpu/=
amdgpu_reset.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9365b43c0055..ba9b0d322b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1681,6 +1681,7 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device=
 *adev)  }

 int amdgpu_in_reset(struct amdgpu_device *adev);
+int amdgpu_in_nps_switch(struct amdgpu_device *adev);

 extern const struct attribute_group amdgpu_vram_mgr_attr_group;  extern co=
nst struct attribute_group amdgpu_gtt_mgr_attr_group; diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_devi=
ce.c
index 286f0fdfcb50..d69fcbb28b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5862,7 +5862,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
        /* We need to lock reset domain only once both for XGMI and single =
device */
        tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_dev=
ice,
                                    reset_list);
-       amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+       amdgpu_device_lock_reset_domain(tmp_adev);

        /* block all schedulers and reset given job's ring */
        list_for_each_entry(tmp_adev, device_list_handle, reset_list) { @@ =
-6343,7 +6343,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_de=
v *pdev, pci_channel_sta
                 * Locking adev->reset_domain->sem will prevent any externa=
l access
                 * to GPU during PCI error recovery
                 */
-               amdgpu_device_lock_reset_domain(adev->reset_domain);
+               amdgpu_device_lock_reset_domain(adev);
                amdgpu_device_set_mp1_state(adev);

                /*
@@ -6579,6 +6579,11 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
        return atomic_read(&adev->reset_domain->in_gpu_reset);
 }

+int amdgpu_in_nps_switch(struct amdgpu_device *adev) {
+       return atomic_read(&adev->reset_domain->in_nps_switch);
+}
+
 /**
  * amdgpu_device_halt() - bring hardware to some kind of halt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index f4c08fa83756..1becf8fbbc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -301,15 +301,25 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset=
_domain(enum amdgpu_reset_d

        INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work=
);
        atomic_set(&reset_domain->in_gpu_reset, 0);
+       atomic_set(&reset_domain->in_nps_switch, 0);
        atomic_set(&reset_domain->reset_res, 0);
        init_rwsem(&reset_domain->sem);

        return reset_domain;
 }

-void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_dom=
ain)
+void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev)
 {
+       struct amdgpu_reset_domain *reset_domain =3D adev->reset_domain;
+
        atomic_set(&reset_domain->in_gpu_reset, 1);
+       /* The life time of in_nps_switch is longer than
+        * amdgpu_device_nps_switch_needed
+        */
+       if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &=
&
+           adev->nbio.funcs->is_nps_switch_requested(adev))
+               atomic_set(&reset_domain->in_nps_switch, 1);
+
        down_write(&reset_domain->sem);
 }

@@ -317,6 +327,7 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_rese=
t_domain *reset_domain)  void amdgpu_device_unlock_reset_domain(struct amdg=
pu_reset_domain *reset_domain)  {
        atomic_set(&reset_domain->in_gpu_reset, 0);
+       atomic_set(&reset_domain->in_nps_switch, 0);
        up_write(&reset_domain->sem);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index 977b2dd2205a..c74a1f88f0ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -97,6 +97,7 @@ struct amdgpu_reset_domain {
        enum amdgpu_reset_domain_type type;
        struct rw_semaphore sem;
        atomic_t in_gpu_reset;
+       atomic_t in_nps_switch;
        atomic_t reset_res;
        struct work_struct clear;
        bool drain;
@@ -158,7 +159,7 @@ static inline bool amdgpu_reset_pending(struct amdgpu_r=
eset_domain *domain)
        return rwsem_is_contended(&domain->sem);  }

-void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_dom=
ain);
+void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev);

 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_d=
omain);
[Patrick] Why not change " amdgpu_device_unlock_reset_domain(struct amdgpu_=
reset_domain *reset_domain)" to " amdgpu_device_unlock_reset_domain(struct =
amdgpu_device *adev)", to maintain the same style.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index daa69dfb4dca..8387e075c385 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1540,7 +1540,7 @@ static void amdgpu_xgmi_reset_on_init_work(struct wor=
k_struct *work)

        tmp_adev =3D list_first_entry(&device_list, struct amdgpu_device,
                                    reset_list);
-       amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+       amdgpu_device_lock_reset_domain(tmp_adev);

        reset_context.method =3D AMD_RESET_METHOD_ON_INIT;
        reset_context.reset_req_dev =3D tmp_adev;
--
2.34.1



------------------------------

Message: 2
Date: Fri, 8 Nov 2024 19:14:03 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 03/23] drm/amdgpu: simplify RAS page retirement in one
        memory row
Message-ID: <20241108111423.60169-3-tao.zhou1@amd.com>
Content-Type: text/plain

Take R13 and column bits as a whole for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 +++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  1 +
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 1a8ea834efa6..8939b4f1fb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -177,7 +177,7 @@ static void umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,
                                        struct ras_err_data *err_data,
                                        struct ta_ras_query_address_input *=
addr_in)
 {
-       uint32_t col, row, row_xor, bank, channel_index;
+       uint32_t col, row, bank, channel_index;
        uint64_t soc_pa, retired_page, column, err_addr;
        struct ta_ras_query_address_output addr_out;

@@ -195,31 +195,27 @@ static void umc_v12_0_convert_error_address(struct am=
dgpu_device *adev,
        channel_index =3D addr_out.pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
-       row =3D (err_addr >> 10) & 0x3fffULL;
-       row_xor =3D row ^ (0x1ULL << 13);
        /* clear [C3 C2] in soc physical address */
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

-       /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       /* loop for all possibilities of [R13 C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; col=
umn++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);
+
                /* include column bit 0 and 1 */
                col &=3D 0x3;
                col |=3D (column << 2);
-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row, col, bank, channel_index);
-               amdgpu_umc_fill_error_record(err_data, err_addr,
-                       retired_page, channel_index, addr_in->ma.umc_inst);
+               row =3D (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;

-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
                dev_info(adev->dev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
+                       retired_page, row, col, bank, channel_index);
                amdgpu_umc_fill_error_record(err_data, err_addr,
                        retired_page, channel_index, addr_in->ma.umc_inst);
        }
@@ -229,7 +225,7 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_devi=
ce *adev,
                                struct ta_ras_query_address_output *addr_ou=
t,
                                uint64_t err_addr)
 {
-       uint32_t col, row, row_xor, bank, channel_index;
+       uint32_t col, row, bank, channel_index;
        uint64_t soc_pa, retired_page, column;

        soc_pa =3D addr_out->pa.pa;
@@ -237,29 +233,27 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_de=
vice *adev,
        channel_index =3D addr_out->pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
-       row =3D (err_addr >> 10) & 0x3fffULL;
-       row_xor =3D row ^ (0x1ULL << 13);
        /* clear [C3 C2] in soc physical address */
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

-       /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       /* loop for all possibilities of [R13 C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; col=
umn++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);
+
                /* include column bit 0 and 1 */
                col &=3D 0x3;
-               col |=3D (column << 2);
-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row, col, bank, channel_index);
+               col |=3D ((column & 0x7) << 2);
+               row =3D (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;

-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
                dev_info(adev->dev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
+                       retired_page, row, col, bank, channel_index);
        }
 }

@@ -274,23 +268,18 @@ static int umc_v12_0_lookup_bad_pages_in_a_row(struct=
 amdgpu_device *adev,
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

        /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; col=
umn++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);

                if (pos >=3D len)
                        return 0;
                pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
-
-               if (pos >=3D len)
-                       return 0;
-               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
        }

        return pos;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index be5598d76c1d..dea42810fc53 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -60,6 +60,7 @@
 #define UMC_V12_0_PA_C2_BIT 15
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
+#define UMC_V12_0_PA_R0_BIT 22
 #define UMC_V12_0_PA_R13_BIT 35

 #define MCA_UMC_HWID_V12_0     0x96
--
2.34.1



------------------------------

Message: 3
Date: Fri, 8 Nov 2024 19:14:05 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 05/23] drm/amdgpu: store PA with column bits cleared
        for RAS bad page
Message-ID: <20241108111423.60169-5-tao.zhou1@amd.com>
Content-Type: text/plain

So the code can be simplified, and no need to expose the detail of PA
format outside address conversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index a030fed16c5a..65336ae12585 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -219,6 +219,8 @@ static void umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,
        /* clear [R13] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

+       paddr_out->pa.pa =3D soc_pa;
+
        /* loop for all possibilities of [R13 C4 C3 C2] */
        for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; col=
umn++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
@@ -537,7 +539,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
        ecc_err->status =3D status;
        ecc_err->ipid =3D ipid;
        ecc_err->addr =3D addr;
-       ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >> AMDGPU_G=
PU_PAGE_SHIFT;
+       ecc_err->pa_pfn =3D pa_addr >> AMDGPU_GPU_PAGE_SHIFT;

        /* If converted pa_pfn is 0, use pa C4 pfn. */
        if (!ecc_err->pa_pfn)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index dea42810fc53..f0074abb5381 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -82,11 +82,6 @@
        (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
         (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))

-#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
-       ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
-                       (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
-                       (0x1ULL << UMC_V12_0_PA_R13_BIT)))
-
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t m=
c_umc_status);
--
2.34.1



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 102, Issue 101
*****************************************
