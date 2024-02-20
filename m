Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38659C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 15:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB53D10E251;
	Tue, 20 Feb 2024 15:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+WisxTX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B8F10E251
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 15:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLUIuLpFKuXvLBGbKMJiA+dN7PJX/cb4/fkSE2S+xjQsKtywiHgScjWLoIm/I/ymr4mxkt3sHWeCRifRYaKVcq/oU6ilnurqB+hHM5yl8nITF8cUriW1PTCfuy12HzaTSiubynYb3E7i/+WKcK02PrO8yDFDBp+IdjOVFktwO2rTTyUoYWOcqIEjTNOwKbyiiwluEyhbMXFXkpl3Z/1XqPHGk12bTYf2P3u2gEoasGYANAp+rYBFmPWpJVrQ+Y8awp6asNmI0zuXV/RZeXGVoSYi+1MHZK1NTvYh/A/vThO9KNwXuEIHUPP4xaXA4kap7OdDrQldUV8sNgl7KEcjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96Tf5pM8rnBILqSy6wLZVvKy0xAQQ9auebR8euFceeg=;
 b=D2KtVUxUThNeVNZ0XhvxR/XcBm+0WhPZZ0UqI7lbvmwIcW16TgiTemTbh6+rdFsGiPf7+3SuU4LN/F8JG9J3gxG/uA5wrSTYOPYHXtB4uY220Ax3FhtLfC7DAvsuJPs83wYdzvnqhUPqum7Cn/NMz7TqGSFxG5j7MNsbD6Jex2e4H9IeWZZMT8gicn1yBAOBkLln3/PS74uKToQb2EUzrnciT3xAI+b9RDe5LczcDXNl4zW/5yk4rJWS+6SF94e5bDfYq6ISW5KAhY4Mz20YbBLWmB0eggK0Ghv+vhV/Dvn1Km+zYxNaDwNM4EdZ9O56q7I1QFaQgSymoiQ61scDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Tf5pM8rnBILqSy6wLZVvKy0xAQQ9auebR8euFceeg=;
 b=T+WisxTX0Or+pt82NU8G6gcskUophJUMbAvqwD0Uz+weJRonsoZda8BezV3YDiZlpsmJUJQMBXsCil3OcWRlyyZ+FdTHRMD9OaQqq7iTvufMcJ7fq1PM0NwEnEE0ao2nxHBJO+h17db8U0Y/FyBjtyAhyEHGlOazQ1k2b7SshS4=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 15:52:55 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::c339:e42f:5fd4:157b]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::c339:e42f:5fd4:157b%6]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 15:52:55 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chander, Vignesh" <Vignesh.Chander@amd.com>, "Lu, Victor Cheng Chi
 (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV
Thread-Topic: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV
Thread-Index: AQHaPaFr9EvNz3mZyUOh/HSrL8vI27ETrmkg
Date: Tue, 20 Feb 2024 15:52:55 +0000
Message-ID: <MW5PR12MB56002BE227EB95952E0E623BE6502@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240102173013.5543-4-victorchengchi.lu@amd.com>
In-Reply-To: <20240102173013.5543-4-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e7c52e4e-c0fe-4744-b5cc-ccf2525b874c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-20T15:52:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|DM3PR12MB9327:EE_
x-ms-office365-filtering-correlation-id: e0b4a264-8044-4db6-b838-08dc322c0114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Djr3da12rRs7D+j7D+H8onOqmOo+tLAQzuloaD4x4f3VJtdMn3f85N3RArNrzI5a2tIu4cXhBr/5ETMYF76NpWr56CwwcmyCeolcX4SwS7abvzHKFNppGMUCbr783xTpYrBEyIYnnxwfl0gpKwBdZWwbLpv1sQ0PcqvaM7XGd4PHHYH3zw7VIX/RzGoVe2r8fExYpNmfafsuHgL+7UjSAh3gbUvMGyvdGNDpK0+PLiThbS8Iz9fBBvnvO8aK2XBTLX+CBSLuB8H+p18RYDpBnz+OXKTmrK0R/r9ANoLYxGr09UgVOosPzd55AAHuSWSKYf/4g8XiwxEsbDe43ZkFJ5oHvgvFAB1CAFzKUHDQvxQUXuARwozsViDXqXZk/fWDlp6GYqORRw0fraek3xFxsUIZ9X6Pj3+Gz3M8Ed2KX4yjUJ/DKBDnuLaaNmAMyMA1t7pu5ZjHjPW8otELv13ZCH3+g4MYHaShyEHDfTpe5tMLfGgXNNkBhhuU8wBvSTruidnPl8uUs+16N2XbRHuijMzEU4yvnnoWbrSqDdeWaq2tUsXr0JcVYtRuKXDEYjf0irFwF5mKhfOV6TXKh1OksG4DuzZ8V9gvp21sxzcdyk+Mtxnuz5uZB7vZQ2N81kg8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/jpKoqvu0GNeND/1iJiPJGqCSaY1VuCeGSd5iHQ0ZMOSyzfeyZDfGG6RyTK?=
 =?us-ascii?Q?2zXhZig8oAZQEsnTPVSSVDPaHLCTSZ2lJsECqz+aGjkxHRGuDHDRDBiDED9K?=
 =?us-ascii?Q?aQ31I27ObEN6mXgJ2xcRoq9Elzr4RFq69P5ACXwJg0yMbijRVE5Yvc4PGRM7?=
 =?us-ascii?Q?ZJ2kjMXZiklPy1KKR5j/SydPgmi78vNW9P+X2wTeSgt9evvpN5xTc7M517Sq?=
 =?us-ascii?Q?lXaowx8+1eSilXbCypLvBeX51xpfQfUN6bVhsWiGfMz0l38kfR060eSlI1xN?=
 =?us-ascii?Q?/R2F2QNIae2xoPVQ3MpTGY4DmHVui0DUdpLqS0XAlR//YYYB6PCj0Q97b5ut?=
 =?us-ascii?Q?eT0zX4uKBWqSQsbaOgZbPZD4pz+h1/Jc5vp0sMW6lWFiniBu4YksGHkg5ROr?=
 =?us-ascii?Q?YQUJYF2aJ7TY29C1c0BVRrYdFJUiwrTFcH7uz+zub5BZ0EWVGmKom7JUEpRw?=
 =?us-ascii?Q?yy9v+wHP7VUjKODnQB2NZ9EQ7/NhZhFwnIAD+Ga8EM50Lfqyv248k+KLT9k9?=
 =?us-ascii?Q?gNDBycCnETmPay6sduYnfzHHMuoJSgD656h7J5XCkqSOcg1LR0apCB9WXO9u?=
 =?us-ascii?Q?O3QegMeIwyA9zrVY5Wb3SZUXP6lVjQWcEzZCaYDmJJu3YajrusGs3ZGdxHTB?=
 =?us-ascii?Q?0GoJocXRB3l9huA3G6LMxRLznjBHRuAnHdULp/p3ayTMxfXiZk5LMOPEs8x4?=
 =?us-ascii?Q?zBL3JFSsE82jOYz8U2ehDTIW/ANlLmoaK2UFCreGnV36dCXX57qR6NPVZVEM?=
 =?us-ascii?Q?A/+f3xXJZmHn/PbCm2+JJFg6FwjHafvgHr/Alj83xd0e47D8zT9uD0lQLw56?=
 =?us-ascii?Q?TNlBxW/acPk8n9ioLxIWjjVAe2e1VQigwfyBmky15Ufl9Uyb1DnCw13CxUyJ?=
 =?us-ascii?Q?gaSXu53zbLOojMZWy/iDKOaVNW9zA8SorvJn3FazeUaXFJfce34BrRkmp10o?=
 =?us-ascii?Q?saTk51ICxHocnYa6CzBEV/NdFGsUU3R+YJdvTnKXOgcflfqRSKRboofOmUpi?=
 =?us-ascii?Q?xW3rNPoPpZPejCBASk7IkF/7rxt1CE93QvXLt5sTETbPfFvXcHq0D+kT8LOG?=
 =?us-ascii?Q?5kKu8mLXcGxfVILb7vFxGHyNFoo87JHuCg9vQKJ9Y6YPZkaBrv7tiZzdQww0?=
 =?us-ascii?Q?Q+z3xwuip05PBzxCNlmKgjwuzaH5xQj5LI6Y0LzK7f4+PlAgjCkaon59+Fit?=
 =?us-ascii?Q?sRTazD76/qa6lUVsWlWDrC6AqcdDagc0q9MWdrChdnr6aYy6lG4fGNc2bHpm?=
 =?us-ascii?Q?MC4T9Q11fi5pOCwaNYUdemn57Xwstigr5+zmA7kOobLYuTLBRUFAt2AjxAqN?=
 =?us-ascii?Q?bPmk/rACvsO3V+2BmGzlCIkv5RiE5XE00HLtz1wiqFV2d6ndOMRw8A7Tf9qt?=
 =?us-ascii?Q?8x8xtBvh8dXZCxOZSnSyPAar/nkMmRXze2WKEfu7WMk4P9eqcKW22n08ddcB?=
 =?us-ascii?Q?P6SfxckXVqikgfHps8Kl0BGf2+gjZ/5goQCqlRAiEJSH0t/XsAcgktTt02hB?=
 =?us-ascii?Q?IPidnCoAnHrSi5OlalHLCkJZJ47CCnuzB4ouEol5pyTS2wvhpgrdgB2+Vqrl?=
 =?us-ascii?Q?OSc187Z/9y9kx+Wu5VE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b4a264-8044-4db6-b838-08dc322c0114
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 15:52:55.7761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUxktkJLjpRNz/XfnmXxYmeTPGt6FATQWibu+5TEBvNpzZgCyfLfsHNYjkscH4Pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

[AMD Official Use Only - General]

Reviewed-by: Samir Dhume <samir.dhume@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor L=
u
Sent: Tuesday, January 2, 2024 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chander, Vignesh <Vignesh.Chander@amd.com>; Lu, Victor Cheng Chi (Victo=
r) <VictorChengChi.Lu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV

VM_L2_CNTL* should not be programmed on driver unload under SRIOV.
These regs are skipped during SRIOV driver init.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..20e800bc0b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -454,10 +454,12 @@ static void gfxhub_v1_2_xcc_gart_disable(struct amdgp=
u_device *adev,
                WREG32_SOC15_RLC(GC, GET_INST(GC, j), regMC_VM_MX_L1_TLB_CN=
TL, tmp);

                /* Setup L2 cache */
-               tmp =3D RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL);
-               tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-               WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tmp);
-               WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0);
+               if (!amdgpu_sriov_vf(adev)) {
+                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_=
CNTL);
+                       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CA=
CHE, 0);
+                       WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tm=
p);
+                       WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0=
);
+               }
        }
 }

--
2.34.1

