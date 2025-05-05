Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18718C3ABB9
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 19:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A9710E327;
	Mon,  5 May 2025 19:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSkNNFeF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829B310E327
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 19:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZXgb6i42c5vp/By06H4fT0/WiKUyFH46u+JrlTzicPPN0EvS6qEWjNs53B7eiup74zS0P+GNC9IOUZac5qxlyMmLRb/K8WVt6l/2HVfYP+CfXA1fSOpG/5KU1biEssCPeKKaiHONe9HSu99+qF5lfHN5AHSpe6hl6MaylRGKvpm8YdoqZ4lKlbP588Pj9dFArT519AwZP5nVjQiBtMd2O0SBr0dF0gtp7mT2VVZ7uZibVHYpTOdjAmGa3MkIhfAgKS/8oRUlfAwHsQJGWRal/MDA/8nz+7h3H0LXW258jeGZXEbD6ofrvFs+8wddoc/z6H8nRjiSFpajykgLTxxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryVyqnNPe29/NEYVrWXAu5JxCimjhiFnZkUUAiRoaWQ=;
 b=wtkXCclwD5QnRfnCptMGA/6V+6oM225q+TpC9LTctsoZJoLld/8eiiFODqNKsWl9a52daTcBqfGdgV03H2lXBRWzpWJj/mj4VDl/ntHPV4Jm+iKKidLl78RmaUo0XAnj1aaQAgzX8hmO1wwT5ZkZg53jJsMFQmRyRAL2OAcUiV3dPoosXdeuyDyyff8npKC4HNlU6sWzDCGUZQ0kZYMLzYVk8I4+U8h9eLVt66pu0u2iaJwppKWCPtMt1+gxbTxergTJsloUzzf3IJYl+0paYM4tQeS5T+NKPDZ9r0HK+oE8kEhMaqEiGyV3ROk8SyT/VQtqiR2Vb5ceYjMHswK1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryVyqnNPe29/NEYVrWXAu5JxCimjhiFnZkUUAiRoaWQ=;
 b=uSkNNFeF55jkcK+8lm8xSUOcF9OgzuUy3I4Qg+QSVEKks6gP7OjsZ7Rod/xpdeOxKHrC47QTBpyuuyqp1ICJDtQPG759/qckQsYUttqhxWcMsRHDlyZsulJ4KM0zVYVVV2h2uYohBArzVNvgfXW56NU91Tzw7LbE15SZ/K46f4k=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 19:51:46 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 19:51:46 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Rehman, Ahmad"
 <Ahmad.Rehman@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: Implement Runtime Bad Page query for VFs
Thread-Topic: [PATCH 2/4] drm/amdgpu: Implement Runtime Bad Page query for VFs
Thread-Index: AQHbuU9de/fdDi0OHEKqEshVobLzR7PEe5iw
Date: Mon, 5 May 2025 19:51:46 +0000
Message-ID: <CY8PR12MB7657D40E7B0E698B1EF816198B8E2@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250429214024.93078-1-yunru.pan@amd.com>
In-Reply-To: <20250429214024.93078-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=74b5e40a-917e-4b73-a54c-fed232f484d1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-05T19:51:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|CH2PR12MB4056:EE_
x-ms-office365-filtering-correlation-id: 1190cb3a-d106-4dee-6a87-08dd8c0e448f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?C9CoFFzA3CFa0Xc1LYiwsg15roW8wN9lb47odGUUUsuMU3MaFmiBGea50oRH?=
 =?us-ascii?Q?6ph4nfcty+rkQDXipr6LdtUTc+I3rCgRUZGswPGrLInT3Meiu/3AWfWY9bJB?=
 =?us-ascii?Q?jBINyGPcK1nUnrhd4lgRXhKqJtepzm9NL4K6kmYxBW6IHVH+xHMKd9N59hjz?=
 =?us-ascii?Q?KNzTOKS1ZnC4Pek25A5i9spFqDHtxcjFTtEokJtkW9aMT1IJmKcLxw7XzD4n?=
 =?us-ascii?Q?fOLrdDEUWdve2yHEI4OBeKrLIr3eLNeQfGICRcl1PR9a+DgsbtqrO9bhX/Yr?=
 =?us-ascii?Q?3fFpbgJAPZVvJSkMEQmLlfRNVNc86+gxKyUBwf5mZH+YHye3mnxS7CeYM8Iq?=
 =?us-ascii?Q?PtFPR15pzIc43Yhc7EuhPHlCvf+E/pJp3TfreKJCcFJnQ8ww6B3i0SUiaYzU?=
 =?us-ascii?Q?EGOQ4cHRc4FLqgQ7cVrfDggk8t0ZNdNZCvYeaq/M64Oavin5606BmJBCDp3P?=
 =?us-ascii?Q?06zTAvBbujfBFDgUtjleYJomtmvm7c3CBbUQaiEzKIrsrveQnSyFqn4ANtyN?=
 =?us-ascii?Q?KKIIzt4gn28oOLiFnPX5JXmuYs4Ipe82x1LQ60VcG4b3PbT4fqGTmMwXhrMX?=
 =?us-ascii?Q?oStug8jlCCYWcJdlIfnlVWdQy9llJ0Rm2QFi4IQWXwQBbn1X03jL7Jd//wmI?=
 =?us-ascii?Q?rzXJt6aXY+cMxX8i+ePtkr942gRs+0tWgbgqbmsslHpFJyNaoHGFy6khZzWW?=
 =?us-ascii?Q?ARb4w7SWnHM3cKFH4N+BBLEVRUJAAu5JKm5okEJmBjxRzSJKf68uGjJPk2dS?=
 =?us-ascii?Q?WosCvdIpd6rH4ZmMmRBxRxUdvyEEodSN+fPsk5CI8i1fYnL5L0J+T7AFOfE9?=
 =?us-ascii?Q?WhRaXvbbk2nk5ywCxLSJDB4inapsaUJgLmWmt39dnwkZp3wsAQT6Q59xOnW7?=
 =?us-ascii?Q?hrcMxE+ZPrjmJbW3xutHPNBfLVZ1mR68AZHTJoMBtqtv/RvFazuEpqUPk65H?=
 =?us-ascii?Q?QD5HWGG8LmWNPOSQNj+onHHirH6Jxunadi369u7IdKqYw+mODxFHnF/+ar0a?=
 =?us-ascii?Q?nqOnHA5atyehGd73yR5Dv9eQ/7SJrQ3AXW4rsvtOsQDKH7IEzJoQHsi21M/l?=
 =?us-ascii?Q?qTJ9ZyLEl+qFAHY2vG/CDx2HCjaZBvP9gvtDBdgPJnMHuU096sY26NzbwVHK?=
 =?us-ascii?Q?LsUlyhYUuYkOFdRsEMYoS5RRkuMBc7jk7KM2IIndmd+JftZVAOjhY2AU4AMQ?=
 =?us-ascii?Q?z6ykA7YofiHB5kZrPEpsQUYrHx87URwYv1XWAmtQXuiY4IoxKa1KPzfwAqRB?=
 =?us-ascii?Q?m7HSty7dftNNTJ8gSIGhM4ldUGbv0bF5hKs1L6HJAviQ7sN4StqghYHvmc/9?=
 =?us-ascii?Q?Ne6v0Wxe8EaRm5qUUVkT90rj9JJzzKwqjwv8airEgr+PnY/rQtSizz5GO8Wb?=
 =?us-ascii?Q?kVieM/kUKa2mPxQp0y3l0F1CIinX7n0R8gLnNfCqncVlB94bDH5lJSmZvR5K?=
 =?us-ascii?Q?h29/MP0SJcveiYsa/cCW3zl0a2iQfwj5TCx2pOgaMSR4fmky9eIVVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UygIUocb3qYJu9Qmyi+FSDDxX9OsNXuJZOXeTHBboCjuCPAF02zvAkpBGpU3?=
 =?us-ascii?Q?cEFBVVBLxUikQHBDTLNH+miqWt1xjeOrqyjM9WALVZ6WSWSsWnZbtXhRHl28?=
 =?us-ascii?Q?kcMJgtLY+lCfsTmJ8hU+9MK9a4xXYCL8KlXgZQafbaEexoXdYKRL2W9ILTXF?=
 =?us-ascii?Q?lB+hwaePRN49AUvJCypb8SqyuwztroOYf/foOuhRQbaGcxI3IAOJFbzFY5wU?=
 =?us-ascii?Q?vzEOOAXFnogb9hMtr2RY5nvxXtAKIsI5MaodLP7E+Q1l1LoCjrqeYlg2dOfj?=
 =?us-ascii?Q?x3AmswgFzjDkpi5I/mg7fGVga1Birwzpx+chyHDXdd9Lh4QHQS7yD+hATLIf?=
 =?us-ascii?Q?MOQyK3fPtlZ4t4U6OzG8hrUCv0o3bthRaZt3V0tFQnpeevUKBKoKkM0Q88GG?=
 =?us-ascii?Q?6QkONQXsqCPyecfuGdshq2pI7SBOPu7D2kifXCQqu7ZiyQjRbUgkva6dFbPW?=
 =?us-ascii?Q?t1zbMgr8wRkrwfUP1JfXErGiboAjELjhQj36AaDsq64CaC8g5nHOL2yTp6y3?=
 =?us-ascii?Q?4NMxWMR9zp0GmD5Y0I2i2ex6K6Y6o0E9IhlMBsMK7uHAZpETugBZRxL6rWeq?=
 =?us-ascii?Q?SGlsDGPE019tQZoEmLjv3Fu1rmmWaRLe22CqjmeIOpGVpSnzby9N8wrteuOz?=
 =?us-ascii?Q?/d+7LRkIfYkmPSJYT5D1dChEXrtlLBQEUtyrbNLSxKU3u8ErF4AaxZDt9QAn?=
 =?us-ascii?Q?qynKntzp+mnjXZI67H5qLGwduhsrlZ7k8Am8KuLm9ok51lM5vPeDcYrb1+vV?=
 =?us-ascii?Q?qj/+JpEjxTzd7XWms811TQDWD5nkb7bVH0zjqVFBlcSlwmy1H6xRUOU07h6Y?=
 =?us-ascii?Q?ZpQ2Qs+wbQUATB4+SmtQ2tbnt3L5KNjOujxiDkj7RSwBxoyTbWYJaw/SWhhz?=
 =?us-ascii?Q?LLH258Mt8VJcVIZyFIhIcUr5x8otYlh2vY8WF2zMbrbzWWeUeSijnQq3HN44?=
 =?us-ascii?Q?MXeZiFRnVbID5hvf6tTgeynH1isa4mufVQj+6LutaS8Meq35+eH1cyZjlpc2?=
 =?us-ascii?Q?g7+SBxfVsoOTZ8sXkWI5gckAsfeFGMHRBClEvALiGFNqGcpv8JCFAFZYj2oT?=
 =?us-ascii?Q?t8DurN0SV8IW2YJs3uIjfdfBNi8L1NLaPMUJfOAHz9Z7VWrM1HHjWZV33Ler?=
 =?us-ascii?Q?mNjbD6RlHCoD9a1fPRYxO99J8/Zcp7M69Q5Mvpp1LTNdnvLVo5roXABkeEWe?=
 =?us-ascii?Q?x0N2YiX5MGIjz8UAT111JZhFOO9sdaF49YHX7FxwL1W6Wodyr+k7viTyqFHJ?=
 =?us-ascii?Q?R24MFVdMs1zljzcbQthN4KBq/7yJQWplnRpZ8vPCB+P5FEb1M/CTIXNGwCmj?=
 =?us-ascii?Q?2dmx22oPPxTcuO1HnXRcTjEC32YUfilx04P4tZpUkBfDEcOaC8yry4lR8GRH?=
 =?us-ascii?Q?IjUpmLb+ue1JNXy7vZ3HJRpDzkJskaG/lIay6+WY4am1kno55dOPkDdET5Fp?=
 =?us-ascii?Q?QYmol8fXWf0YdmgvADRXyKnSsYEPXxLnjg93FEBzHcZcftVzsg+aIYNDmZ24?=
 =?us-ascii?Q?n3TZTNmNTSr5+dR09pUGNN2Aqgzna35TgK1/0EKT//gchOw/BZnfCl9lXDFN?=
 =?us-ascii?Q?bOLNaGDgo58zzEz2tXE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1190cb3a-d106-4dee-6a87-08dd8c0e448f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 19:51:46.3533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPIzfZ2Dshlqe0ojo++yK8GPfZHopY3lD5j9A92Vi/+z4wtcf4TGQRBCYkg3lOkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

Looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Tuesday, April 29, 2025 5:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Gande, Shravan kumar <=
Shravankumar.Gande@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Pan, Ellen=
 <Yunru.Pan@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Implement Runtime Bad Page query for VFs

Host will send a notification when new bad pages are available.

Uopn guest request, the first 256 bad page addresses will be placed into th=
e PF2VF region.
Guest should pause the PF2VF worker thread while the copy is in progress.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 +++++++  drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h |  5 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 46 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 28 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  3 ++
 6 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 83f3334b3931..13f0cdeb59c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1488,3 +1488,16 @@ bool amdgpu_virt_ras_telemetry_block_en(struct amdgp=
u_device *adev,

        return true;
 }
+
+/*
+ * amdgpu_virt_request_bad_pages() - request bad pages
+ * @adev: amdgpu device.
+ * Send command to GPU hypervisor to write new bad pages into the
+shared PF2VF region  */ void amdgpu_virt_request_bad_pages(struct
+amdgpu_device *adev) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+
+       if (virt->ops && virt->ops->req_bad_pages)
+               virt->ops->req_bad_pages(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index b6ec6b7969f0..577c6194db78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -97,6 +97,7 @@ struct amdgpu_virt_ops {
        bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
        int (*req_ras_err_count)(struct amdgpu_device *adev);
        int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
+       int (*req_bad_pages)(struct amdgpu_device *adev);
 };

 /*
@@ -262,7 +263,10 @@ struct amdgpu_virt {
        uint32_t                        reg_val_offs;
        struct amdgpu_irq_src           ack_irq;
        struct amdgpu_irq_src           rcv_irq;
+
        struct work_struct              flr_work;
+       struct work_struct              bad_pages_work;
+
        struct amdgpu_mm_table          mm_table;
        const struct amdgpu_virt_ops    *ops;
        struct amdgpu_vf_error_buffer   vf_errors;
@@ -429,4 +433,5 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device =
*adev, bool force_update)  int amdgpu_virt_ras_telemetry_post_reset(struct =
amdgpu_device *adev);  bool amdgpu_virt_ras_telemetry_block_en(struct amdgp=
u_device *adev,
                                        enum amdgpu_ras_block block);
+void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index f5411b798e11..f2a74aa76b56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -274,6 +274,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct=
 *work)  {
        struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 flr_work);
        struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice, virt);
+       struct amdgpu_reset_context reset_context =3D { 0 };

        amdgpu_virt_fini_data_exchange(adev);

@@ -281,8 +282,6 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct=
 *work)
        if (amdgpu_device_should_recover_gpu(adev)
                && (!amdgpu_device_has_job_running(adev) ||
                        adev->sdma_timeout =3D=3D MAX_SCHEDULE_TIMEOUT)) {
-               struct amdgpu_reset_context reset_context;
-               memset(&reset_context, 0, sizeof(reset_context));

                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
@@ -293,6 +292,19 @@ static void xgpu_ai_mailbox_flr_work(struct work_struc=
t *work)
        }
 }

+static void xgpu_ai_mailbox_bad_pages_work(struct work_struct *work) {
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 bad_pages_work);
+       struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice,
+virt);
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               amdgpu_virt_fini_data_exchange(adev);
+               amdgpu_virt_request_bad_pages(adev);
+               amdgpu_virt_init_data_exchange(adev);
+               up_read(&adev->reset_domain->sem);
+       }
+}
+
 static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
                                       struct amdgpu_irq_src *src,
                                       unsigned type,
@@ -314,24 +326,29 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_devi=
ce *adev,
        enum idh_event event =3D xgpu_ai_mailbox_peek_msg(adev);

        switch (event) {
-               case IDH_FLR_NOTIFICATION:
+       case IDH_RAS_BAD_PAGES_NOTIFICATION:
+               xgpu_ai_mailbox_send_ack(adev);
+               if (amdgpu_sriov_runtime(adev))
+                       schedule_work(&adev->virt.bad_pages_work);
+               break;
+       case IDH_FLR_NOTIFICATION:
                if (amdgpu_sriov_runtime(adev))
                        WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
                                                                &adev->virt=
.flr_work),
                                  "Failed to queue work! at %s",
                                  __func__);
                break;
-               case IDH_QUERY_ALIVE:
-                       xgpu_ai_mailbox_send_ack(adev);
-                       break;
-               /* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ ca=
n ignore
-                * it byfar since that polling thread will handle it,
-                * other msg like flr complete is not handled here.
-                */
-               case IDH_CLR_MSG_BUF:
-               case IDH_FLR_NOTIFICATION_CMPL:
-               case IDH_READY_TO_ACCESS_GPU:
-               default:
+       case IDH_QUERY_ALIVE:
+               xgpu_ai_mailbox_send_ack(adev);
+               break;
+       /* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ can ignore
+        * it byfar since that polling thread will handle it,
+        * other msg like flr complete is not handled here.
+        */
+       case IDH_CLR_MSG_BUF:
+       case IDH_FLR_NOTIFICATION_CMPL:
+       case IDH_READY_TO_ACCESS_GPU:
+       default:
                break;
        }

@@ -387,6 +404,7 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
        }

        INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
+       INIT_WORK(&adev->virt.bad_pages_work, xgpu_ai_mailbox_bad_pages_wor=
k);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index ed57cbc150af..efb452ad1700 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -40,6 +40,7 @@ enum idh_request {
        IDH_LOG_VF_ERROR       =3D 200,
        IDH_READY_TO_RESET      =3D 201,
        IDH_RAS_POISON  =3D 202,
+       IDH_REQ_RAS_BAD_PAGES =3D 205,
 };

 enum idh_event {
@@ -54,6 +55,8 @@ enum idh_event {
        IDH_RAS_POISON_READY,
        IDH_PF_SOFT_FLR_NOTIFICATION,
        IDH_RAS_ERROR_DETECTED,
+       IDH_RAS_BAD_PAGES_READY =3D 15,
+       IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
        IDH_TEXT_MESSAGE =3D 255,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 5aadf24cb202..74a50c0036ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -187,6 +187,9 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
        case IDH_REQ_RAS_CPER_DUMP:
                event =3D IDH_RAS_CPER_DUMP_READY;
                break;
+       case IDH_REQ_RAS_BAD_PAGES:
+               event =3D IDH_RAS_BAD_PAGES_READY;
+               break;
        default:
                break;
        }
@@ -342,6 +345,19 @@ static void xgpu_nv_mailbox_flr_work(struct work_struc=
t *work)
        }
 }

+static void xgpu_nv_mailbox_bad_pages_work(struct work_struct *work) {
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 bad_pages_work);
+       struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice,
+virt);
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               amdgpu_virt_fini_data_exchange(adev);
+               amdgpu_virt_request_bad_pages(adev);
+               amdgpu_virt_init_data_exchange(adev);
+               up_read(&adev->reset_domain->sem);
+       }
+}
+
 static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
                                       struct amdgpu_irq_src *src,
                                       unsigned type,
@@ -366,6 +382,11 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_devic=
e *adev,
        enum idh_event event =3D xgpu_nv_mailbox_peek_msg(adev);

        switch (event) {
+       case IDH_RAS_BAD_PAGES_NOTIFICATION:
+               xgpu_nv_mailbox_send_ack(adev);
+               if (amdgpu_sriov_runtime(adev))
+                       schedule_work(&adev->virt.bad_pages_work);
+               break;
        case IDH_FLR_NOTIFICATION:
                if (amdgpu_sriov_runtime(adev))
                        WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
@@ -436,6 +457,7 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
        }

        INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
+       INIT_WORK(&adev->virt.bad_pages_work, xgpu_nv_mailbox_bad_pages_wor=
k);

        return 0;
 }
@@ -480,6 +502,11 @@ static int xgpu_nv_req_ras_cper_dump(struct amdgpu_dev=
ice *adev, u64 vf_rptr)
                adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0);  }

+static int xgpu_nv_req_ras_bad_pages(struct amdgpu_device *adev) {
+       return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_BAD_PAGES); }
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
        .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
@@ -492,4 +519,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
        .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
        .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
+       .req_bad_pages =3D xgpu_nv_req_ras_bad_pages,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.h
index 72c9fceb9d79..6d292a537c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -42,6 +42,7 @@ enum idh_request {
        IDH_RAS_POISON  =3D 202,
        IDH_REQ_RAS_ERROR_COUNT =3D 203,
        IDH_REQ_RAS_CPER_DUMP =3D 204,
+       IDH_REQ_RAS_BAD_PAGES =3D 205,
 };

 enum idh_event {
@@ -58,6 +59,8 @@ enum idh_event {
        IDH_RAS_ERROR_DETECTED,
        IDH_RAS_ERROR_COUNT_READY =3D 11,
        IDH_RAS_CPER_DUMP_READY =3D 14,
+       IDH_RAS_BAD_PAGES_READY =3D 15,
+       IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,

        IDH_TEXT_MESSAGE =3D 255,
 };
--
2.34.1

