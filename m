Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5E6C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 07:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E141110E61F;
	Fri, 12 May 2023 07:07:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDAA10E61F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 07:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bry9TokrQoEdKA+ic+YDJzOFrciewy2FJ/ziqzwsnNZD1V/jN6ZjpKN/YCrytUAG1XJzpMkH8co8l07n5e/BcH2tP4+WnBFJezWJ5TaIPaNx8Y2X5uHQe71ZRvTCHo5/MN/b81lLWXEXPmzGNQPEbxq/SHN8e3ASlOZFGsGVe3cKcHrzE37NnP3zyYUKiwNsKEkJ0u48rLgc/yusNVNWgHpw83gO6Ebgd3Pzd5fN66ZXb/7a7V/wQhep5sYAynGvVfnx4UK8xkgGur4lq1Cxg4Et9sipYPDjODf/cTnuaWEs8Rlayeoik6cYib/vSO875b5PWqRpXlNCX4a5rXT8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=151wCl6s3ByHblJ2nb3D8fi2Smi1nNXk2IKmtANtj7Y=;
 b=GSsQ7ljZO9p2r7zzREG4KKLRvda5ah5BBwyRF0Pvi2BnbOWBF8nDNthRfoTljAK2XSqM92QXmtXBtfpvgiYNhA7NqRf9co4/TXPuUV/tGDKqa9WDDzu23BVR2xQuCkA9kQvZdFfQ6lSzvC/Aygi6/Iu+xm9Z8ADGbg24m1XjbzEpsVo93riXXOekcz52U0QieLUqLA/2sGMBwPt8zLFs1RmFSECg0HdMb6H9ikSOmFLBex/ty6CAI1DglYp3KqD0eec7+S/cXbhK/N4zbFVd7qX0rOH0/G0hoSZmyeFNyZ6ken4NoAP1aMufupYXFhH12uVyVp7hW2uhHp89AvG2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=151wCl6s3ByHblJ2nb3D8fi2Smi1nNXk2IKmtANtj7Y=;
 b=Oi+CGFLQaZ+T+Nf5Jsb+pOPzofrIuPpIn17yhq2IbriSCbv3AfZU9DvlOpkw3S63O3aQ7cyXqcjV0WfnyTxLpM86iellR64tBcD/Xl9KpLxLylWh0TbJms4oIqN3w7LnhHW1jf9AOojclK/3R/nzYpC6OL7jH8XRTRA72ZySz/4=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 07:07:08 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::a9c3:2008:bf8:752b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::a9c3:2008:bf8:752b%3]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 07:07:07 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc11: implement get_vbios_fb_size()
Thread-Topic: [PATCH] drm/amdgpu/gmc11: implement get_vbios_fb_size()
Thread-Index: AQHZhBb/7aLPiNb8xEqdKMuhkaJjUq9WOEvw
Date: Fri, 12 May 2023 07:07:07 +0000
Message-ID: <PH7PR12MB559612810866A9ACE6AA697F93759@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20230511144324.500617-1-alexander.deucher@amd.com>
In-Reply-To: <20230511144324.500617-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-12T07:07:05Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=acbe90dc-dbdd-4535-86bb-6e315cd887d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|CO6PR12MB5457:EE_
x-ms-office365-filtering-correlation-id: cb114db5-8283-470c-0266-08db52b77fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 186sAQZjwUaZB3174M8x8iD3dzEY7YrWAy9XfzZgOSwdTOwPHXvaq7jP2TqSUMe+GdrXTWVzl3CGcrOXoya4E4nPhYGbnipzDRZhkwZpddeMorFgFfmPjXxIjeKsUTHsLxC3eIR8ODTWffG0If9/WNXdAlAclrMGEelWdFhWvRx0YwNKl+1aWtECJiR+ZnJxM4ZZdVmCI04hsTJ8X9se9VTGwNawPQ78QSM41Q8vXXlw9CZey0iAsPnS+kNc8Xc4Kz6FwuOazqBC3UIUqyuQjqLUPFcgApXz3Bmuv91EV/+Wmv0RnhUkEV6xWRQECQqpeZTpwCuEDHA7uu88lznXeoH8u/RBY0mYX7jCNvvOysr1uoLtie0ixWZL/0y9/rtqVEhFhMH6722AJK7bxKAAEkpi48QYyz1LMp//ZaNn3RswWBj2wI8Ns/YhYyDJmwkCAWt4d8z0096zTtAicCHMd2OKUO0pmArDLgIHSGtczIoakdfq28wGLmHaZB3LxllRlBHmtumV5cp7L6Ll25h7ncNclRyaDWfuFI+1pRx0c0OBqn9YxqHAOLelVo6J/xUAh8iJRY1aW5BtkRTAiaMgLJxpDrO/DWwtjRaOp6NaTesvb4XjcVJDxEKozT/ZPK08
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(5660300002)(52536014)(8676002)(8936002)(83380400001)(2906002)(33656002)(186003)(122000001)(38100700002)(38070700005)(86362001)(55016003)(53546011)(55236004)(26005)(6506007)(9686003)(316002)(4326008)(66476007)(76116006)(66556008)(66946007)(71200400001)(110136005)(64756008)(66446008)(478600001)(7696005)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+T3yn3dJHasUR0JV5uSakXNoa5kVI5CWOvzjns32cp/N8bVAwKGhKbuI6gcY?=
 =?us-ascii?Q?iHPuSdIkQdGi0On61xfvQMVVguQC4RnWZQdEXBgj72wzujzvZLorfe3nHX4B?=
 =?us-ascii?Q?DM6Rrhq54aOBQ8T0zcu6hIJO2d9EsNuTSHhbzVbiIyGnPnXukon/RLamDoub?=
 =?us-ascii?Q?fazRgXs4DJnehj7ZTaKitlnyjUMPg957GMX/82zIjlaCY3GrMKIoPDWg8y7W?=
 =?us-ascii?Q?vpcjdaThPTBAeMK6tHdd338GgPTnFEtQKqrw95wR4zL9V/Mn4XINPZQpcgeu?=
 =?us-ascii?Q?cFlr+oZyWDZS0ubZBD4z3BcBjprH5zegYrdPMydSYk5/nbjU5HQWsncUDdIU?=
 =?us-ascii?Q?mDruVrIP8qZa0U3glIS8/hKV9BcXcUW6BV/8M7M+/9bdCqgns7oWw4/YG1QR?=
 =?us-ascii?Q?tAIt1tC5CTmRQFDdfa1lUKJ0TUIU3O0/q27dVykWQ8NBISiJNPIBvOcP+YWu?=
 =?us-ascii?Q?OdPnx0jMwkWARi/B2aLvncnkobLOLNEPULS13BOq3gGCzdjlUKNEmQbM8k/N?=
 =?us-ascii?Q?aaHRinwrl/T5jJx0bhG7BjVZchjkX8k/RsXQ66qgfw0TovVdv8kuU6a1tcmJ?=
 =?us-ascii?Q?FdxYU73/IgZAc5d2dwrW+5mUH3YSC+NGAVO0+KWvu7mugt2AzlCMnz4F42SC?=
 =?us-ascii?Q?xw/+pW6WF1+vuBaKJQQmwdZ9HSjRMCQNDAUTAot+J0HVLgwXazrKt1+TWR2o?=
 =?us-ascii?Q?ah4UO1sPFMFfcoFU6TgUDynQSBUI1AJEoRUPkIjKeri0CUKuXyNBOpz9OJa5?=
 =?us-ascii?Q?GXzzm9bfiPMQoF8CsipQS+CeOSLo7PEQ8I2fB4/ItBPWffZE+1PxZ3Hotglv?=
 =?us-ascii?Q?Y/d0Dy+mDVLDOxWA/ivy1ogorT1cc5a7TjkB1G6yU8ZQ8zkOzXXz1TDpbARJ?=
 =?us-ascii?Q?080P0WBUIIjLLr2bX+irsYuXDKC3anjKKOM2N3+lpJWCImja/IQDG+up/chQ?=
 =?us-ascii?Q?3r0Zb/l7xT2nfLgqyqCZPshGyzgx2JnBuNCx4QjYjb25Wrh0KkQs4OkhwcYG?=
 =?us-ascii?Q?M+9ro7RdGTwyVjTL0zi0t6NkbEKW+kNR3Wk8MZ0gGXY4NxReYPoNQmYGU6qC?=
 =?us-ascii?Q?czyCqTwWhBu2qtXAIAwsucw+/Kb6DyiEkAPvT9hbXfxUqohNGPfM7LuvpfR0?=
 =?us-ascii?Q?/JbJpooqcA3ll4fe4V4c7V1/kZz4ivSQEyf59ma3YAdoqPwOxdjcNk+iLOTj?=
 =?us-ascii?Q?iUZkcD2pyh3Yv0xuJ40V+qf1pPZS+3aKV/QU65bu7iUIpMWJSvtIwwYdkGpX?=
 =?us-ascii?Q?HoSAKfrflaQ9VAwaHu6CNhzYRnhII+c5xikgdK8RzjP4H7zBUa1t1ptYq6Wh?=
 =?us-ascii?Q?47cQvBQa/wR5KG+4uSFkg95bA3MyP67BePBwaeC2/bKFTh8TE0BBsV2kirg6?=
 =?us-ascii?Q?ezd/P6XxPkp6A3sj7szYRW/P/6rVXtX2SEYTfhbnqF/LiBr93crwVPS47Opb?=
 =?us-ascii?Q?ss/tzlxjLfau8HGfbO0RjB+stRvX5FNxsmznI1zcUNncLRHjmFo4gJDQ14hv?=
 =?us-ascii?Q?cermPI9Ppon+2PsnOsm2CZQk/NTfBwdkPiE4pyJzetqjm12EO2/EnU8vbJwL?=
 =?us-ascii?Q?9Ps/bP4w6V6KteVOSZg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb114db5-8283-470c-0266-08db52b77fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:07:07.6948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGTMvrmqfkMexlrfD+ci+Of1Cr0J75PF11spFj17ga/LI7WBBwgM7qZ2m0cIWzry0UkYvarcfzD6mbj3KMXHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, May 11, 2023 8:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc11: implement get_vbios_fb_size()

Implement get_vbios_fb_size() so we can properly reserve the vbios splash s=
creen to avoid potential artifacts on the screen during the transition from=
 the pre-OS console to the OS console.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index f73c238f3145..2f570fb5febe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -31,6 +31,8 @@
 #include "umc_v8_10.h"
 #include "athub/athub_3_0_0_sh_mask.h"
 #include "athub/athub_3_0_0_offset.h"
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
 #include "oss/osssys_6_0_0_offset.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 #include "navi10_enum.h"
@@ -546,7 +548,24 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device =
*adev,
=20
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)  {
-	return 0;
+	u32 d1vga_control =3D RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size =3D AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport =3D RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION=
);
+		pitch =3D RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size =3D (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
 }
=20
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs =3D {
--
2.40.1
