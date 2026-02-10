Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963D4EA8128
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0887A10E5B7;
	Tue, 10 Feb 2026 15:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YxqgmD/p";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E106D10E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 15:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsDa+nEGYevO6wuJiYJijnzgPpNcHXtKXmWLJ6hB0lJxYRN6407Mzqn2ITENFtx9AkCmClFym1cNxLz+fDbZBSVIVhRILfWSvtevC/yWHfdk9GC69hgP9TzFKfEQUIOxFFjr117MrfbYmWlFZ+H583rY6hQsf6atIK8ZEJCkh3SzLdc9B3hg13Ayxelb+Ap8BMHpVq7zkP0903TY7+Es+rzAct06zcOqx30Gux3h6qgM2U2z+jRh9f79YhoASkE7NrGNCpX4QgLZM/LUMG1QVyadeD7xFgUNvVY9t/JqCEJrJTLlQsdGMRm9CkufW+wk79YLqzRGk+BLmE+8Rcc8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLXe/I3Ewf0+gbF7oh4MPt4Rm3XJSJeUoMp5VZg/vy4=;
 b=lK76wYSdaDq7EB1eh+Qf+55Xqs2tkfLDdMNfilWUTLhQSnv/g5T9hCoqPfHfT3EY0pDj+qaUM5aPjUfinAqkkUTCTyJJefOerNI32gw66n946cT0hDkf74Puf2HT57km2uRhmCHHSDISNI1V6c8VAu5Qj9rrlbKBa6wgPMgMSfattj/ziomYbsZr84vAIjW4N8Ovq3qCeAfeR8YQ+Aj9W9g83axyineBqYPP+PZc6b6iGGMOpw3d5qaP5fWa1VqNEKx478WXlWtyFDxi8W/FKUrhq/+Om2fhocVv5TKk91Fg4A4k1LPR93nZxRpO4C/1lk5AATgSeniOqxxfFuV5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLXe/I3Ewf0+gbF7oh4MPt4Rm3XJSJeUoMp5VZg/vy4=;
 b=YxqgmD/pD3kZfll/dmriBhgccgT6XHQGUbm5c+atDul9WAvim8KAmFs8xAKGjmAAswLFOCdeHu6ct1Z1272i/oDRzaXufiFIR96HyoeczND+F+/M/rL1ZsphIGLPIt0feDe+W/epcCQ1jMKOWBi8ZpW1SNDYZUkCP7f9V8lQamA=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH0PR12MB999114.namprd12.prod.outlook.com (2603:10b6:510:390::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:15:34 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:15:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Aitken, Will" <Will.Aitken@amd.com>, "Louis, Simon" <Simon.Louis@amd.com>,
 "Louis, Simon" <Simon.Louis@amd.com>, "Louis, Simon" <Simon.Louis@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add xgmi link status for VFs
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add xgmi link status for VFs
Thread-Index: AQHcl3BfQqTnbCgBuUCEYWgMb1tZWLV8EUxg
Date: Tue, 10 Feb 2026 15:15:34 +0000
Message-ID: <DS7PR12MB60713745E67C07183B094FB18E62A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260206135539.3843805-1-lijo.lazar@amd.com>
 <20260206135539.3843805-2-lijo.lazar@amd.com>
In-Reply-To: <20260206135539.3843805-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T15:15:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH0PR12MB999114:EE_
x-ms-office365-filtering-correlation-id: 6fe6980c-9ad5-4e93-3ad6-08de68b73cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Pp1giIIDwgvSsFvSEVRihMotlz1+fJukz6MzV0VqzRwOU3Av7CPu9cUityDN?=
 =?us-ascii?Q?wvpFZ2rzudTrRJs96fwzgUKLhQjwYbZEfl/76QDemT0Ukof51RJNh2FqJjBG?=
 =?us-ascii?Q?H92Vf2f8byah8IXtJLAAUko+GcQCkJ4ih1QAtZGwSx5cngWAgmhBjnmkL/KF?=
 =?us-ascii?Q?5aubemWFguNzfm62OMaMp0CfMN1w5bzEHmgUODpCpQQAile+9UIkgwCxwg5x?=
 =?us-ascii?Q?45mrcsaR9d2Z1gygVWk006SymSIYh0qjkjqZVifV49HagwfuSFOAwD9Z85cf?=
 =?us-ascii?Q?Z43TRJItXrIuwd8/WH3g4zQUimND+Np/GGKM9Y8tUON2FvIF5ln5TRSRV9Mx?=
 =?us-ascii?Q?9by4rKToNqXGCLLQnSWecrvmRkaBKgHNXx7XP1qPvNXmp1pgfvSqk5hc2VjK?=
 =?us-ascii?Q?og/DAzMZnsth7CR3flM/jkME4rKbMjtcTHii0On6E4HNYHtX+oE4FA9+TOjz?=
 =?us-ascii?Q?CysMM+KwFyu7WZbpuaGbnIMJavPlX+T1RN0gTafKDJfo0xMB17eN4ak1aks4?=
 =?us-ascii?Q?dpT1AFXjTiUDQvoQGo5b0OhVKTlvzlsRN50SvXtcAK8ZlJ39T2MgnPqMetPa?=
 =?us-ascii?Q?mNhNS9MbdL+gqshcszqY+Iq0O6TAmm1RNt2weh2rWuR03tIyGfiuRpx0dvPJ?=
 =?us-ascii?Q?qsS9unpAEgg02093iUTXJw358turHdeUnl9LeWxB07pNrBSe3KKqijvXJB/k?=
 =?us-ascii?Q?YV7KNFAA17D9K+eJUPB04K3psHkAioPZ3cYoz/ZQnOX5c6DgWXjaPf88tH4S?=
 =?us-ascii?Q?DyoMBEXIhbfMkS3QeTnLe4TleudNNP6qS1H7yJfEY/5N41m8Q15lVRZnG9n5?=
 =?us-ascii?Q?T0GnkqsUL0p5NeFG+VZTdQxP2oFpgz6p6u8aPCORYn8FG/NXTFzOfAglqkUJ?=
 =?us-ascii?Q?OzZFz+qVX/BX5hC2/+0KeQzThGTGPszDPCSJ8HyMrJFmNbphYEk8LyKPfnyk?=
 =?us-ascii?Q?4yYT2zXYu522V80FvNc84H/lDN9daZpccLxP5hYj8PjSPwYIykIPxdNHfnQJ?=
 =?us-ascii?Q?Mv+Wja4e7XbdRF2q69RV7WOo9mXkd3bFpGmt117805DuxGXux49I/2wLaYog?=
 =?us-ascii?Q?q+jIA4Lmb7MwZ9fR+bU3jeHbJyINJYl2+gQyMJwg63ekMICR86Cd2uTDU9QM?=
 =?us-ascii?Q?3Sye7VcKo3f/4kyFrjeJ/urDtz8nPizeHB7sknsk7Wti54y3bix/pzhfwfMC?=
 =?us-ascii?Q?CLf0E34OgcT2dR6qnM/mgpO2hswJMrQXywxNUNrWrXDJMql2Xsd5mffzwa3S?=
 =?us-ascii?Q?eUuDM4yB/7XWToT75cuGzd31jfYtFDKKHwNWl2vKGZN3dybAJq+HxAjt8Fkf?=
 =?us-ascii?Q?WhD1/RUw/stnwYZEkcvvtr8+lqF6h975gzgI4bvpW4oG7YP/0uUy5zXvMj99?=
 =?us-ascii?Q?AdRuBsy1Lg0OtKQ3sc7HET4cL03gvdXQwPwfOsKaYWzJQjGUsedvBrZ8lB3M?=
 =?us-ascii?Q?96mOUwCEH376p1PG/o33M/3TLpZAUm57At9hHHiMCo76NxA8DtljvD1AnEFe?=
 =?us-ascii?Q?oiVHFDasuMVwRfNXDUMUNTFyAeHg4kcscPeLrcsWv48cZNoS0Bioljc0Tdwo?=
 =?us-ascii?Q?QUATsO68CdZqhR4UtxWHuzieXv7rQm5N1seESy1B2gd9WIbrueI3NV3BFW3i?=
 =?us-ascii?Q?1PYpjX/ogHmJT/3VatL8DWo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YSt90YUbjOaavbh0koSEr74XLhy1H2XbOaAwo0lqLmXN1nxXyEdfK2KRSU5I?=
 =?us-ascii?Q?DR85znfqwZ/B6/lBacLhtr4cVluGfYJ17X8ejFjpNt5mL/gz6HKvUYL+J3jB?=
 =?us-ascii?Q?ar4Rvt2FCz+SKp0z0ZpmgR8z54L3IzFrjiKqN1kVFXaApR8A6np3nKK9ZLKd?=
 =?us-ascii?Q?jWkyvC3AIG0PQvcA5hodFLBlxcReZjG2LCZl6CGCiyjskNRrCVUqDP6CqLPT?=
 =?us-ascii?Q?NIs/Ln+EejzMI4bNYZ+xvnUa9CfZ8wiyHng16sqGBLEsFhGPB46uxxv9vCNK?=
 =?us-ascii?Q?yC/s729K0tsOZRYQJ+fCbGQIr6eoJyAZywNmWNSlmswKA6EgUBxvNAA1UJRf?=
 =?us-ascii?Q?gP1Z/bJ/mM1P/b7S+18UaiEFSXIaIKOFdnURehD/+/fak3Rn57XHHAwo0zoM?=
 =?us-ascii?Q?ri7J6nv/+7FqG3GT1v+Os85Se6NUHfuN1cJoLrrb6YN4XDUAUcn4h/qW6/J0?=
 =?us-ascii?Q?H5jaQGyE8vYYZaxggF02mLOcbBxZ8u7xPXwU/q+WTati44nSD2PVzfhaqrTt?=
 =?us-ascii?Q?7aJzyqz808Co7CegJoikje9QKZor4b4DxJDLslWBlbNLqTv96i8s/m8i6rea?=
 =?us-ascii?Q?zgch+eCs7JuGQF0/br4f5vif0sdbXitqsTiz5R2jnRH85NJ2N1qYtUwJAjRt?=
 =?us-ascii?Q?ozkBJ3qQDRwLiZnz9gGJDGnhmChO/iM12WrtP7pJM50+SZSFjmidPpypWgJm?=
 =?us-ascii?Q?GNCscFLCW/gSl+w3n2n+BjYUFkoZ7vLmZ48c+3wHaFpEF7tru5/e4R35FwN2?=
 =?us-ascii?Q?Lou5eq2Ukob1rC0RYK0nxpnAJMD0IMyegKFw+f1GFzslt5z6l2rcZXMyYIT5?=
 =?us-ascii?Q?9+LpvN97Q6llqmKDVP9FgEMEtSsT1x8NO5IrLq9x8MMxN/ASEb4V1yPgszet?=
 =?us-ascii?Q?KeLKDYuNS3u5TMcs1PhUniSBfyTBCC6Mzn+n0S1hwGfFS0u/5s9/3qPYTeV8?=
 =?us-ascii?Q?ee14uYMNQOcyNph9aQOEeQo6PVW83gCvj+3OqyRpbpmHND+VLq9zedlZo3oi?=
 =?us-ascii?Q?3g6s9hA5MaFL5WZspwqz9+4eMHsrzATdj3LFsDRPJXCB8AMW4DcUyFd047J9?=
 =?us-ascii?Q?x+2zclOhZngxTD+Bqosf7xftQjdHjIHlZ/ptCKK30gcRYSDWQ0eblQxxahV2?=
 =?us-ascii?Q?aYDEiH2mIbub1QXJk0FcRel9NK+cdNUQCcep1GlTFfiKSRb9TVqH6cnRDxSf?=
 =?us-ascii?Q?K9agSESFTcpRcyuVbsNwfO7Srtt9rLsEuVK5J2rQFSbgcrkiYuLK8UYiHu5R?=
 =?us-ascii?Q?c/F2CVZAewZt6hhTRMVWM/civ/M8c+9COOuBgjg+e0GFqnumlzVahI78yUiu?=
 =?us-ascii?Q?FdGwTSkVKG2ZuiSIsagVhB9dW8bym5JF6tgeLZ9PdlwMk7Pz9RhXvbp7zlZS?=
 =?us-ascii?Q?XonIsMPXWd1AYauvleAFnI71SbfBnLIanJ2sdtMbdA0BDBhvl8s9lhzPtTln?=
 =?us-ascii?Q?RKRRILC2vuUNeygGpeMlvHfKi3Qsz3x4Nt2fdtZs+rAs42gGP9Fmb6q6UF7J?=
 =?us-ascii?Q?VDA1iKG/7ieBWiW6RPEZw+zu54e9Co0pRs7eoNbpOCTjuBZ6rmfAf+ctQD5q?=
 =?us-ascii?Q?8Mzm9pUDqz0jZZY7A1PjAVCyBJuAUSZlEmGvBQmx0fIASkeZPQh2PXEGrSSm?=
 =?us-ascii?Q?YHFZEi5Py8V8pGlubFo/VijPtk2ZqmXH3JJIPvky1kos3kbAM8qoCKptP46Q?=
 =?us-ascii?Q?v8LRMKRtKPOxnn1kG7kkByuUZe6Iyc3WI7fFvTFQCwSaTk+u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe6980c-9ad5-4e93-3ad6-08de68b73cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:15:34.1546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ol5deDVzMqJp38fQvdyTd69TX2d60G4p6+wlxQIEBBPU2rJv78DPWFKpXi4u66qD1S3mCjc9rRoBLzVrmHViUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999114
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
Sent: Friday, February 6, 2026 7:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Skvortsov, Victor <Victo=
r.Skvortsov@amd.com>; Aitken, Will <Will.Aitken@amd.com>; Louis, Simon <Sim=
on.Louis@amd.com>; Louis, Simon <Simon.Louis@amd.com>; Louis, Simon <Simon.=
Louis@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add xgmi link status for VFs

From: Simon Louis <silouis@amd.com>

Xgmi link status is unavailable in guest. This patch returns AMDGPU_XGMI_LI=
NK_NA for VFs.

Signed-off-by: Simon Louis <simon.louis@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c       | 3 +++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 0ca6fa40a87c..08731d4be177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -347,6 +347,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *a=
dev, int global_link_num)  {
        u32 xgmi_state_reg_val;

+       if (amdgpu_sriov_vf(adev))
+               return AMDGPU_XGMI_LINK_NA;
+
        if (adev->gmc.xgmi.num_physical_nodes <=3D 1)
                return -EINVAL;

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 6683ffd6aa68..bdf8e6ff556c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1832,6 +1832,8 @@ struct amdgpu_partition_metrics_v1_1 {  enum amdgpu_x=
gmi_link_status {
        AMDGPU_XGMI_LINK_INACTIVE =3D 0,
        AMDGPU_XGMI_LINK_ACTIVE =3D 1,
+       /* Status not available */
+       AMDGPU_XGMI_LINK_NA =3D 2,
 };

 #endif
--
2.49.0

