Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1818C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF7410EA77;
	Fri, 14 Oct 2022 06:07:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816B310EA77
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERN1n6YgEHlZYMs4i+eifdEHkJAttByW56xcqhLpanp67g5Kf0ezRBEHZVi/4JMqpqlQXBXmlOoqh6wDzKCykxAdbJWinrb6rHPFFl/uZ+tVIQbgdq2WPgZVwKi5h66rOmVb3sikqlxJsw+yhQlteBM7iuSy0jB/6rqAZYCTGF6I/u+fYi9XN8fjr8nwZULQszBkQp7Wjtge2qoXxdTam117Y0Ytkmc7xPmtyTiAG7oy3Om71iq0sa1fCjeaMJDkRCsorNDsY0gIgHrclyXiZ50mndp6K8lthIgypV0e0vHGAP0wQTXmaYv0KLLINHCN8Bnj+jvMlbpHmBDSIuNy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB3WJpZVHd9eLmixjJXAL4dbElBfI8+2Jwys2Df8Xr4=;
 b=j2YA4Pmy5EPnkBtyQI90Oo4tPlCjZu7dcUoAsmvwvqs3MwFT1wfeFXV9/T8gLHyM3BtJbpJrhdqGx2RHTJFZOWPsA4ZjiPyOAhDHmj+5mr9u1l++/pFDHzhN4hly4LbfN8TDRWNFXbfjNBPDhKqccxzE2G/Xriyh8ZaI1IgF30jM8T/JuaMelEBlUX9RJBcZTzY5aFV+uvx0yWOm1kiB7EJHtgbrSXeR8SCr3gw7QmfMCly+71mLjNCGUIgVMK8Iv3A3Mr//ZuKGanhk54qt694m492Bpav/kUcSvGkuURBzjKD6ZIzLdkS+lwdiaFMAZydrXAGxagvDbPhFpH87ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB3WJpZVHd9eLmixjJXAL4dbElBfI8+2Jwys2Df8Xr4=;
 b=frjkngaQjcTjyhf6v09KKoUste0s8+E0a9szF2BlV5cQyEO3tRPwySzrVehlHH7mWJMLrVGj5xKq8GD3ZfHcTZiPni8NJVrJb8noDsNrdlhuvu3ZTCnddA6gndSicygbEiBXnYuaYA9So1OhuX+0l2AYFjRt90zvLhHgv8tNERY=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:07:41 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:07:41 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/amdgpu: enable gfx clock gating features on
 smu_v13_0_10
Thread-Topic: [PATCH 3/8] drm/amd/amdgpu: enable gfx clock gating features on
 smu_v13_0_10
Thread-Index: AQHY35GtuyDoW9s0SU6HS1R6xjb1/K4NZccA
Date: Fri, 14 Oct 2022 06:07:41 +0000
Message-ID: <DM4PR12MB5181A94A7AA02E326737183CEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055553.921523-1-Likun.Gao@amd.com>
 <20221014055553.921523-3-Likun.Gao@amd.com>
In-Reply-To: <20221014055553.921523-3-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:07:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dbfe565c-5d53-421c-9f1e-b46e0c5b2ea7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:07:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d32d88e9-9277-4c5e-9680-97e819c05e70
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 12c67ba7-3df6-4b64-0157-08daadaa6776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7/FWBJp/2SjAqSFWYCetI0VSafDNXZE1DKkKCRjqvx/2n6RsRrftsyjUNP8P7x4LqkRj71P+bqYfD81H0Pwp+yDzGJrxqm3jw7RDfmrptF+rKXPhKvEg8+subVc+PzlkyjC+HCIqzUNOeRdBtazpsAJraKilT2d83KLwR6WCEA7cqkzWSh1s5IluLplRXxClkAQkn0TuNx3AFhxhlqgeqUMvrQGjSo+si+bF2NeB3Y3kUxckTjjdysT2NzwCT/t06F5s1gwRgNiejDC0WJrc2xcPTt7dnqQtrGW8rhT86vqoxzLsns+ffvXCuagutKbW5T+gUSbXdFxYI9VOr2KsE/ugC2M2SAk6ZmW+DO/yu/vA5wwbbikCIPUsQ+n2bTgBN6fQzerYvJNPiX7bW0wUSqT6QU5CYsAzK3wSZlIsgdyyfymFI/4XjVc8Cfk4e2y4z+OA83x8AcBe1TGauw2QOsHuyooZWwhy0RuGC7GovBGHYzsJ+ZYzyopHpNgPpsDIk2cQjN3Srfi4wc+NzgKVbPGHjArwlRBqaQa8zCG3OYCqoTYuAP4LoqHjc4YpmECJruy0WZ48JbBZiklAz0IOjftI3Dkd2X7kM5fJ/jrkXzP7yN5X74hbnIlkV4vFZjAuU983s3YYTLSQv61vJSVeJLFiCS5SXHr5K8IOeoQyvd2uGfXLlocJt1o4QqczsWsU+Uf+VTzQQN+M0Qx+s1Wm4j4Wr540UjrfeecdoHecyR3QBEEkWcFT37TtWoGw0t/piQEcMIIakDd8gFfiJm+DQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OFgfYBAIWqS0Af+1jpKJQm31DBSmsYDuPxtuD378ap5rbhc1Qzvzna06dPg5?=
 =?us-ascii?Q?UmY5BGXIO7sdVR4V7cC6GFJg/tV4/wszg88+2d404PZ4ezB6kS4nlTSH1Eos?=
 =?us-ascii?Q?O5h0XeJ+swWRz2/xiZzp8/8tXagObGNyDl+zmYjnI3KVAw1pw+8hihFR5R22?=
 =?us-ascii?Q?JqvAfBWosjqkF0+SLazcf9x6xNWnZ4JbCcI0zb2wYn3gmOx7+ZT1YQedWnwZ?=
 =?us-ascii?Q?E2YQaXGI4tkoAr/Z62OWlMXft/j327u091qoVJi52r/ClSP/6AdAlMWiMs4O?=
 =?us-ascii?Q?JZd7hEBE+FhVD1cuHkpxXdUgDqtuayN9cO7e+nlqVupmRVj+3sOyttRETODL?=
 =?us-ascii?Q?XlnlPeRmetrrlr+zluynbdQE335+hCK3TnFDsrRA7sU87KUaVDf7sRgUyyK0?=
 =?us-ascii?Q?BSJFBP9++h/+bbpPCPXcSk8MTNur291qn1TziJZjOMqpr1Xh8idvPjfkEsMi?=
 =?us-ascii?Q?gsm84RD6ZdPg8If3StBnlZ1HWgAKuqekM+SG2LG9qelcl6H4txscarP3rB3n?=
 =?us-ascii?Q?jKn1qNVe97dIIZdJSZSJ7XT7QVkPqMvy3YhVcX2vmRF2ZkCL0EPdXRu3lqVJ?=
 =?us-ascii?Q?rAI/AaYxabm9CWTfRsykbQLgLeNPJHoAtiBuNlmCYZ7UVoSo8rDbSjz6IFrH?=
 =?us-ascii?Q?mM7knB3SmKmeO5ZF7pLrAjmwJT7yRasd4ATbOF07pICBukg3hF6yr5dXF51O?=
 =?us-ascii?Q?l+MxNSkMVDsyIHRT0iCiQ5x48eWd6X+ESDcDM23xzMT7dztDfFDmAsZLZDW+?=
 =?us-ascii?Q?RW8M4trGGvCtd2U2oduTIJyboSdYSlVahzH6IOz+oBdTC5VuhHFjeVy2SFRw?=
 =?us-ascii?Q?z7Av/mp0DWCGBBUHzca+xbtLSYKivBUZtm2cynD5A7eT8b7Qqg8TRfEJYDyu?=
 =?us-ascii?Q?uV540uL+v/qqnuKaBGEhclVL7h6m2ag3caBBlxTg50CLopKyf2n4cItWYppt?=
 =?us-ascii?Q?Qv3DdlKwIuVxd9pI4vcD4Cr6hdESNVDo/cfUcIiyE/AUIz+WsfYZqj03thFd?=
 =?us-ascii?Q?kEpSk3anZP345S1nWZnG4nll3WicaJOWY6SazS7VkvcPtKhAuH0oOxnvQtCa?=
 =?us-ascii?Q?+X219jLuXHS6n0qK62/cVvrVZiwbnQONjmu22Us94N+VDZ5Na48F03wjXh6A?=
 =?us-ascii?Q?Aa2VEpHEjxCGtlqmcF7ggJPJ1TAI4TYzfQ2QvToq20KwP7on1ag5zJcgeVz+?=
 =?us-ascii?Q?sbQPkDJvl9fG+Gh+mdmRI03waYMhX3ua0gu3lykkYOwMErD9wEdPDMcELYkW?=
 =?us-ascii?Q?btCKDJONvB9584EunqAB/ikLCHjZ1dPd6x9s2AAI/0KLZSuteBj/UpqUskZ7?=
 =?us-ascii?Q?jvGmlXIyY85nPpzrWSdVEIgnrYeZnCSrcYr+/Cyr3POiHu2/dN10S9cqUVtO?=
 =?us-ascii?Q?la47SORXfBk//4WHrkaqv6DxebvClfAT9mwb+HEiCgwJEAsY+WDZPDQz9N2n?=
 =?us-ascii?Q?n5cDsNuFK5k4/3o2c/JxyKu8x1dyHuA6tajv5GCSgSM20xYmlIYRBfYLHQOH?=
 =?us-ascii?Q?WCls64Q1lG7PoKqwTOkBQfZNPJXxcoWpZbv4OmGv1SwGbxPnJT+vfwxNcPeV?=
 =?us-ascii?Q?g1p03/D0P33ZcKCg+wA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c67ba7-3df6-4b64-0157-08daadaa6776
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:07:41.7709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fKrNa5H7j+pyqcETianEFVqpDf8u9t9NzIZWPZYdrrZY79eHggWGHr8KCg8MuJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

enable gfx clock gating features on smu_v13_0_10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 257b2e4de600..73106f53246d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5076,6 +5076,7 @@ static int gfx_v11_0_set_clockgating_state(void *hand=
le,
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state =3D=3D  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 27bb8d2daa7d..8e4ad723d7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -637,7 +637,11 @@ static int soc21_common_early_init(void *handle)
 		break;
 	case IP_VERSION(11, 0, 3):
 		adev->cg_flags =3D AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_MGCG;
 		adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
--=20
2.25.1
