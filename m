Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8355DC28B28
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 01:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974F710E38C;
	Mon, 10 Mar 2025 01:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6SXQTiO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246510E38C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 01:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo9cEbxp2tpp+oIiDlkpxOBADbRcUr2qdGWXCYSk3h1smvV1AiRimmeAfWfW5yvbH9kVZod43FrzRniEekGG5ZXK6EaltM1WknoPG2gsl6/sTBZpJzS3TBiAIzOSnyHa71vOyz9IuJTSAPMxScS9cthCbE0Yit7mbw367o2Q+tV32Dyt/laOzPiOvoDPDg+5IVq3NcY+cxK0MNN2s0NK0KegPB1ezVk05h5uMxsdzxq7UxA5tw7TDTg2OIysNlRE1/L8CcIGhPld1wpBCrWx/TWPQD0yedWni0NMA8h9birn7wzmFFfxsvm9UmDIsN7+m/DpAYwd9l99a2dnN0HVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3v/yg8qge5e4gMCLu0HdpOLoJ4aB/VImErzPFntSZk=;
 b=L85vVJveX3pGjFuJAo19y+wcyUjr09RxLx+/qGR7kP9T9z7Al5XeUtYXYu9r1gAD/wnL/8DjrF502OffxX0g5SlMik2svhO+0Gd8q7JxP8VPVMYGJAtP5AAz5o09gv0bKCxW7ZDm6Kma+Wb/zGVsoMKrnG1oEcWTV/OEFxTTTFwXYf5SpvWSUrD1NC0lBVcCmEDoF5XohZ/47mDH6pkdXJkVQITGyw2TH2CMC3LXNc6BUxBm61pzFoy7LL+BYoEFA8GQn0NOx1Zk9/Fe8xywgl90zdzOFAavcX2gW7ZPX2mZv4dtE/v1tAEcg0ZcpFwGxsJbd+mBXUvvxF2tTc781g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3v/yg8qge5e4gMCLu0HdpOLoJ4aB/VImErzPFntSZk=;
 b=P6SXQTiOqZ36LJVnTTe4A38YyYtk6hjxAE75xQ1DRZ6fjK9eDsELtFnNdHyOEwufygMK7zQYnA47PW7mLEshk9yy+CZKqZ1kYpuZxx3/qDnaWDQdgxF0nfYLPfWpREPzZoYXNymEX/mqfgLdASSdK8+F+UBvdQDgpFkVMppWGj0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:28:02 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 01:28:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
Thread-Topic: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
Thread-Index: AQHbjX5KAtbVH6bvfk+pccgEIQBEmbNrnErQ
Date: Mon, 10 Mar 2025 01:28:01 +0000
Message-ID: <DM4PR12MB5152094937D6C89280B2542FE3D62@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
 <20250305032520.1745117-3-jesse.zhang@amd.com>
In-Reply-To: <20250305032520.1745117-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=201755f4-7766-420e-a896-86f6400fb7c9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-10T01:27:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CYYPR12MB8871:EE_
x-ms-office365-filtering-correlation-id: a72542d3-1449-470b-aa83-08dd5f72cc94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wRtxRyAuw/qrRQ9JS/TEIifzYkiw3GJTO923BKqxPA147ZZ8MJ+9A0/+D5FO?=
 =?us-ascii?Q?dn9IdQg6vZQqtvAtQPcN9bmBH3DNCT3pvQZbcnerf7CL4/vh12s9aDpPZc7h?=
 =?us-ascii?Q?Fz+N9Vd2j2rSm1xUOID5qj6hOdtd5cqE3HffycoPGPHikHFizwvWPfzx63+D?=
 =?us-ascii?Q?I2+SSAEFPwPLGLwnyz4sL18dmaMNDefPenTbJ1PwyBBExns33x4FPkYV4POh?=
 =?us-ascii?Q?8qpWmIOAjqY+zMkna8gFOLkwnybGhp06rM8a3HqIUAJ57sObbhYRzOvuDsF4?=
 =?us-ascii?Q?2+QgDE3Qd4/OmNe99H+xFe42Xb33x7wFFwjlGe5079hgB/rnCPIKLqI7raWw?=
 =?us-ascii?Q?10nSH6pezBottDZ8B/yTlwGrV97t2Kfi29g0vJduSC/x1XhKh3D4ezIZPtKK?=
 =?us-ascii?Q?pwv3eAYXX61XR4SpNlUkcMUaxFeeFXgB4vGBmyzrz7YvzKHqtHBQJg8qh1pJ?=
 =?us-ascii?Q?WxZHHwhaOX5Ea64yPtQ9EtfyLmEhQn+8xRE5nQqS+mui3d6lXzsznDZzmVzP?=
 =?us-ascii?Q?iM0mMOGJ3lL1BAJsDL7a/G87roKDRkYvI8PIhaNCV9yNthvBv257bFBlP5oM?=
 =?us-ascii?Q?W1OeksZWOEhRrletJKAKZkpqRZm48Qp5pisqYmCeZZt1e6ocO4t/fOTgjsI3?=
 =?us-ascii?Q?h1vBDASKudo5EyOV4xl2DNl24cBpLXTRwdtC4xPr54J0noZdjLTjO0Yf6tAI?=
 =?us-ascii?Q?MqBw/QT/MqzEVMJ9NOoQ+UlOIjhjJg+UwUAQ3H5AjFnjEneSnNCQtvkpzoPN?=
 =?us-ascii?Q?SIymblRVz+PHz9KpUfRsPmvutPuF6487pwLaWkpRrBW6FObFsj9f4WQE7fM7?=
 =?us-ascii?Q?jhj3ZcHUIIolE3PyEeZ8Kp8KegA617mNGD8YfCCbaMcfcCrNu51wLhZ6NYTA?=
 =?us-ascii?Q?pZc+jovkyebYegRQd7f0jrp3VdHE6AdbMnb7cXaiUzJv0oio5goBYApOFYDc?=
 =?us-ascii?Q?gSR06B/+mRDN6YuQMgnLYIyG9VLFle3xR1NvpVUIrHPFZ+5lH96D+kThiyRB?=
 =?us-ascii?Q?0P1jdav+Ho/DS7nYJYQxWJGuYQcOxN6B7DeNFxhBsCQZXTirReAJSPO34Ky+?=
 =?us-ascii?Q?ZT62CYOFYN6PM4t5S5oiLDB7Zfk0KzDc8zeA6DjL4oYLS2EcgSsW8t+bIwqa?=
 =?us-ascii?Q?KSy7kroIS3yIm+H4zGqd3DQ471G53BQIIZrKJABEoLD0N87YH1UfgCLHVicW?=
 =?us-ascii?Q?8doF5AJRlaK6zsLL0b0qDM4e8wM2XkgVcy1KxKShBcucyRrRjzXdNOc25oZq?=
 =?us-ascii?Q?VdW7rXKpGFXHLv0yFJpcXZuRfKCj3P/A6HPL2P4VLL853MJsTwvftx8xUVGS?=
 =?us-ascii?Q?lg9RpM4c+DQ0vK15H+jZeBsFOkr6F98vXa7PdDcsnSnZ35QkZlqjmheQxeiD?=
 =?us-ascii?Q?c3XxBOFFWXfr2b/b34Uz/1kBB9yRWB8YZxr/OzDSwK+FOBTDaf+mAeUvBHF4?=
 =?us-ascii?Q?taiqVQCsVKp375VUG0Py/VNUR5nxttPx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zcNSEFUO2ucveJjj9ooEKSPoQZTSdpQLtXza6XoPmzvDifK0ykPmelXzoTP3?=
 =?us-ascii?Q?tEnBHf2VfIQe6+u68zqYEZMZXoW3T5c7hjypdmd9fq+g1H7w5pUXUCCyfzAe?=
 =?us-ascii?Q?rRV3wz+jToKAm7oMrrlXVMQIEvAdLQIA+Y2J9tGUA4ep/aJFEqNSUqleZy3o?=
 =?us-ascii?Q?OMfa8pHVSldr+ZPLFtIVtsTOM7C6U31kZna3MyFAAK9lqysqTrtpWBOKrPBY?=
 =?us-ascii?Q?g8WNjZVLJ+nF+ur0l1M0bHG0eTJ1nCzCipzBDUdk914q26ITGrJTqCRMMJge?=
 =?us-ascii?Q?ekECtpZlwdPV6/fxF9SRNx+hrp5DZABPP3f3A/vFZqsEFYMyV5hiMYYYLPgO?=
 =?us-ascii?Q?Q1/QXauzqw/XqCLMBXMKr0207rt71V5+m1PFC4qLiJoSt3qqYHxbVdrBs11H?=
 =?us-ascii?Q?2wxi0pdFEIOBivF6LZbH8jZqXoNPTyteJgIDHDlon0L4P78AZAKO167flVSG?=
 =?us-ascii?Q?xxtEnUBr3cFCzbI5oNhoxR1KSQ5o9G7wkQWS4obGKmJeR720XmdYTMxdv/21?=
 =?us-ascii?Q?q9YP+fDbQmVEqJng1TiKIbPcgYhWyZV9WSMzIHdJBn6PRwrFNH6PgADyBmSA?=
 =?us-ascii?Q?lUnO7yrtl4FzLn3/4vxe05kiJTM21EofOl6XxpwY6d4kAs6D2VQv07V+G+Vl?=
 =?us-ascii?Q?Gc0Cpg08/kUCngKpoOARyhzEZpK7UJEiQAMFgdFNVN2kiQDhX/BEcCkO86We?=
 =?us-ascii?Q?F5IDGk586pX7zJu32FqAvyJptlMok4Yhui4KEa9/lf8Mwq1Fs3uGw05G4JbR?=
 =?us-ascii?Q?65Ykac5wMjfmVtE0PJKh64c2AeI7T/XQy/7eSTqyCUkexRdGQ2AuPlBb7fy4?=
 =?us-ascii?Q?k3d8AOOGfUy0NVB4jksdWJrt2c/JZlStNHczYtCk4Q0VSZUIHgaEN2U2Qdzh?=
 =?us-ascii?Q?EaDn45f8dFCIUmGWH08dnt6jg5ixPs2HoZTvA+s0inmpkRF8lpEVLntSRIVh?=
 =?us-ascii?Q?7C4xHF9I1CFRZ9PU0vkJiSY7AFZSQpaf31i8tthc4rI+E81xHnWVTX3QG4HR?=
 =?us-ascii?Q?JQhalpOAWIpwc+gd+CMGqNmDIZUT7DN6BTem/mkey+NGpaZiiWAveh1L27nm?=
 =?us-ascii?Q?FlTY1FcU0wgPI5DSOUO7zIIx6EipBWfrcUh5CgPZ/SEecngY44dn+yQyPwzu?=
 =?us-ascii?Q?3oidrPtQOCXYrQVutSADNZ9yxCVl4mS3Kb/HeS2wFoN1zMpIYmXERe6H8Pky?=
 =?us-ascii?Q?f+cbG3o3/F1214RDljTv22nOa7dulpsCgcxCoKadHXFCX6LLnpaKUoRVwEJU?=
 =?us-ascii?Q?vthZN6TFY9z1NdbC4f0DI5UVG4bat2iZB0XW99TytOYHGE6+J9oc1cWvDmvr?=
 =?us-ascii?Q?tcUrikhQ7TKPIe8tgSzM2IKcfVut9lRHz+eI7oKNhNserSqUImLK9DHRfH4w?=
 =?us-ascii?Q?cGEQ29/f2WaC+lgj0R1fOTVGZA19B0qyEJVUvjnhpxs3dyJcNZVb6DO9eXtU?=
 =?us-ascii?Q?oiGmr5vM/iOQVLqH2z/a/7yVGRnW5L43iOVgQHCvADMRvZADvpuZG7uFpa5G?=
 =?us-ascii?Q?N+sAPC8sjfg+/e5SPiPpddAv4XEwVVmTDREY9fXC4oHIdkKT+skzHfh5n/Ye?=
 =?us-ascii?Q?+MyLj0sAKMFItrrBt/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72542d3-1449-470b-aa83-08dd5f72cc94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 01:28:01.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/BxbqmBFHQ4D9uqdgDyweNbOu2sPGO0aRp87bkiProjPJGltC709whBCbzH7LfMP1DN7Rv7tzGY3ZAyL1zIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

Ping on this series?

-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Wednesday, March 5, 2025 11:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, Jiadong <Jiad=
ong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
Subject: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementat=
ion for SDMA

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This commit updates the VM flush implementation for the SDMA engine.

- Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM=
_INVALIDATE_ENG0_REQ
  register value for the specified VMID and flush type. This function ensur=
es that all relevant
  page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.

- Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sd=
ma_v4_4_2_get_invalidate_req`
  function. The updated function emits the necessary register writes and wa=
its to perform a VM flush
  for the specified VMID. It updates the PTB address registers and issues a=
 VM invalidation request
  using the specified VM invalidation engine.

- Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide acces=
s to the required register
  definitions.

v2: vm flush by the vm inalidation packet (Lijo)
v3: code stle and define thh macro for the vm invalidation packet (Christia=
n)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 55 +++++++++++++
 2 files changed, 118 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fd34dc138081..554e14b56c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_9_0_sh_mask.h"

 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1292,21 +1293,71 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(str=
uct amdgpu_ring *ring)
                               seq, 0xffffffff, 4);
 }

-
-/**
- * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
+/*
+ * sdma_v4_4_2_get_invalidate_req - Construct the
+VM_INVALIDATE_ENG0_REQ register value
+ * @vmid: The VMID to invalidate
+ * @flush_type: The type of flush (0 =3D legacy, 1 =3D lightweight, 2 =3D
+heavyweight)
  *
- * @ring: amdgpu_ring pointer
- * @vmid: vmid number to use
- * @pd_addr: address
+ * This function constructs the VM_INVALIDATE_ENG0_REQ register value
+for the specified VMID
+ * and flush type. It ensures that all relevant page table cache levels
+(L1 PTEs, L2 PTEs, and
+ * L2 PDEs) are invalidated.
+ */
+static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
+                                       uint32_t flush_type)
+{
+       u32 req =3D 0;
+
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+                           PER_VMID_INVALIDATE_REQ, 1 << vmid);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flus=
h_type);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PT=
ES, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E0, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E1, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PD=
E2, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PT=
ES, 1);
+       req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+                           CLEAR_PROTECTION_FAULT_STATUS_ADDR, 0);
+
+       return req;
+}
+
+/*
+ * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
+ * @ring: The SDMA ring
+ * @vmid: The VMID to flush
+ * @pd_addr: The page directory address
  *
- * Update the page table base and flush the VM TLB
- * using sDMA.
+ * This function emits the necessary register writes and waits to
+ perform a VM flush for the
+ * specified VMID. It updates the PTB address registers and issues a VM
+ invalidation request
+ * using the specified VM invalidation engine.
  */
 static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
-                                        unsigned vmid, uint64_t pd_addr)
+                                           unsigned int vmid, uint64_t pd_=
addr)
 {
-       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+       struct amdgpu_device *adev =3D ring->adev;
+       uint32_t req =3D sdma_v4_4_2_get_invalidate_req(vmid, 0);
+       unsigned int eng =3D ring->vm_inv_eng;
+       struct amdgpu_vmhub *hub =3D &adev->vmhub[ring->vm_hub];
+
+       amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+                              (hub->ctx_addr_distance * vmid),
+                              lower_32_bits(pd_addr));
+
+        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+                              (hub->ctx_addr_distance * vmid),
+                              upper_32_bits(pd_addr));
+       /*
+        * Construct and emit the VM invalidation packet
+        */
+       amdgpu_ring_write(ring,
+               SDMA_PKT_VM_INVALIDATE_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDA=
TE) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(0x1f) |
+               SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(0x1f |
+               SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(eng)));
+       amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATEREQ(req));
+       amdgpu_ring_write(ring, 0);
+       amdgpu_ring_write(ring,
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(BIT(vmid)));
 }

 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring, @@ -2115,=
8 +2166,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs =
=3D {
                3 + /* hdp invalidate */
                6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
                /* sdma_v4_4_2_ring_emit_vm_flush */
-               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+               4 + 2 * 3 +
                10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fe=
nce, vm fence */
        .emit_ib_size =3D 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
        .emit_ib =3D sdma_v4_4_2_ring_emit_ib,
@@ -2148,8 +2198,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_pag=
e_ring_funcs =3D {
                3 + /* hdp invalidate */
                6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
                /* sdma_v4_4_2_ring_emit_vm_flush */
-               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+               4 + 2 * 3 +
                10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fe=
nce, vm fence */
        .emit_ib_size =3D 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
        .emit_ib =3D sdma_v4_4_2_ring_emit_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gp=
u/drm/amd/amdgpu/vega10_sdma_pkt_open.h
index 8de4ccce5e38..d3a72ffac04b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
@@ -64,6 +64,9 @@
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
 #define SDMA_OP_AQL_BARRIER_OR  0
+/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
+#define SDMA_OP_VM_INVALIDATE 8 #define SDMA_SUBOP_VM_INVALIDATE 4

 /*define for op field*/
 #define SDMA_PKT_HEADER_op_offset 0
@@ -3331,5 +3334,57 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_=
32_shift  0  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETIO=
N_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_comp=
letion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_c=
ompletion_signal_63_32_shift)

+/*
+** Definitions for SDMA_VM_INVALIDATION packet */
+
+/* Define for HEADER word (DW0) */
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_OFFSET 0 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK 0x000000FF #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT 0 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_OFFSET 8 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK 0x000000FF #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT 8 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_OFFSET 16 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK 0x0000001F #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT 16 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_OFFSET 21 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK 0x0000003E #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT 21 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_OFFSET 26 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK 0x0000007C #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT 26 #define
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK) <<
+SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT)
+
+/* Define for INVALIDATEREQ word (DW1) */ #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_OFFSET 0 #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_MASK 0xFFFFFFFF #define
+VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT 0 #define
+VM_INVALIDATE_REQ_INVALIDATEREQ(x) (((x) &
+VM_INVALIDATE_REQ_INVALIDATEREQ_MASK) <<
+VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT)
+
+/* Define for ADDRESSRANGELO word (DW2) */ #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_OFFSET 0 #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK 0xFFFFFFFF #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT 0 #define
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT)
+
+/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */ #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_OFFSET 0 #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK 0x0000FFFF #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT 0 #define
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT)
+
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_OFFSET 16 #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK 0x0000001F #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT 16 #define
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI(x) (((x) &
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK) <<
+VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT)

 #endif /* __SDMA_PKT_OPEN_H_ */
--
2.25.1

