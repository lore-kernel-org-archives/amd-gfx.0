Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E79C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFE910E2D2;
	Tue, 27 Sep 2022 09:34:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C736710E2D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHA+Kr35nuXHiLndgVSR8FxyYjpYjoe9KNjhsy6KsCwiurrPyzhhDwdmfmtDEDf/fhGfUEnHvKDiCOFBcJoaCpInd/CAPEGo5SFtlEjQyzTv7JxKADfhHq2pxNforvgasdcoBb9Z1n7mUeuLyao3GfyJgmX0xYIv02cZA65Wy+H1yytjc0sIWFy8Arj7RoYKrrz7fMDwTG/4KHWnKVrkWgC85sg5jeHV6QOkFtwWK0HZDOwv0S65Cvm7mR8dNYm/+xaBzEoMIuXeeso3BqZuPQ11d/g5upERRt20N1buTHfJ84oNxWcCc0GFzs3acaB6hcIiWMP6y3c4LLdi0Xq0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Pwh1LWfO7FAc7EPmvvGbSqcx6/OpM8Vho2eFFHQoQ=;
 b=FS8wogwO1M6+L3ZfioDUFVRzv0ObbCI2PHV7IAyKTE+8Kf1lUN8HNiz++i8YSNRmBrhm4MxbBC3BlBhBOZwH9WKliMntHG8WW3AOhZ/pqjuRZ7+bg0v3r8USO1+ZFw7vCsR/8EFwR7+Dx1Z4vZhBYXfZ0nQ0CD7Phas3cs+kYCvkR4raZ1HOgypM6JoI8E8hY2RSwogb8cnErk0k+K3g9/bZC07RsSJUOxT7D+/CQ0++qhYxExJYa1vsDCkH6dQBMS/6SZXvi5doijaSoTtKTdMwgzqfZ/Ja/AhbTfd4iE9PyiwGEKM7z83mtMLRo1U9rnbbqvcXmMfn5dxdc3sq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0Pwh1LWfO7FAc7EPmvvGbSqcx6/OpM8Vho2eFFHQoQ=;
 b=XkbXZ4Rk4ILfesTAoDuAVWVGhbrDpTjuTFfFYX+5IaZH/J2qs7vkscoUsM1z3BZ1gtXjgx0MdXKauhY1CeXkacFoFkqJg4cyZVI8BoZ7es/6OLdf0amm805mfL8AocMl4YJM62M6AR6/aVUNSkv2PgA5jijLc86yuPKUuua81b8=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:34:04 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af%4]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 09:34:04 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix compiler warning for
 amdgpu_gfx_cp_init_microcode
Thread-Topic: [PATCH] drm/amdgpu: fix compiler warning for
 amdgpu_gfx_cp_init_microcode
Thread-Index: AQHY0lOUTMP8enxCu0yDjGInIjUW4q3zAz+Q
Date: Tue, 27 Sep 2022 09:34:04 +0000
Message-ID: <DM4PR12MB51819408B6DFFFAF9AFABDE4EF559@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220927092841.3135548-1-likun.gao@amd.com>
In-Reply-To: <20220927092841.3135548-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-27T09:32:43Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a27adcda-daec-4139-8a1b-0e041d7a60fb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-27T09:34:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c276a698-6342-49c8-9873-a25b67389937
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MN2PR12MB4303:EE_
x-ms-office365-filtering-correlation-id: b5ca461a-76df-4201-0aac-08daa06b6adb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irvaPWZDAPc0D3wgNdmEJog3EkxduDwcaqcJQUYJPIFKCx16PTA5vRsiG8JExbodYLgncmpkf+SewFj2zs8RYAcbm9vGiorItju54Gm9Yiq1GhJ5QndxxztxslECWH5cDO4Q5fWWc7NPSJ0PqlYrAR4h5/vTAzqRN5nt7OHHmgb1/g1Jb81g6Q97Yps0sPfcieuJjYAJSe60JAHmq0DcF/bys/Hf8xR8ecFw0DlNHoctlQmLYh4fPmXk/fQ+CPZPir7T5BOgDBkxIbKi+u//4zlO7nw5hWFkoTJFLWtqh4JtseFTk9a3mBtVeOiQvHt8rmtfVA858gAodog4VltboE0YKUPqAcvdASIo++CzpaKJ8UpqByhNgC+HE9zK/JEBLCG6WqfvrF+IvCMIL5GGkrE4cdL+Mh59za3BcFjlmAroTDjibP90hcMTHqLWixf58p7eGa/UtXFTDXuTwHjvuTL4wuaKg0Fpvpua4DXEdhAQjl0hRDpqkNCCWj92+anwHYy5Xm4Az6qNkuxTCAqDfpRndVdgzDyEboUUdiWkBJcpjl7x7MWirh50rfCAIqsqJv14BCOUce7LrzhWDJpZQIsx7Wh808wQMRyyDM4EQFH7CyxdfdUmfwkrC7RZ1CFiSliHRZdWmDymqTOY8OqpWmKIJqIYPWIPVxgZUX9Eqr3d9y0tqR97++oBcBVuy526jfif3gMe8APFoIxV63NT1pnxjfSN5mXNggT2GjcQBF5djS9yg15PpazkYoq3hfKHFPALPc3QARvTFtIdmoqUkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(33656002)(478600001)(38070700005)(76116006)(2906002)(86362001)(38100700002)(122000001)(55016003)(5660300002)(71200400001)(8936002)(66476007)(64756008)(66446008)(4326008)(66946007)(54906003)(6916009)(52536014)(8676002)(7696005)(316002)(66556008)(186003)(83380400001)(41300700001)(9686003)(26005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WDTelDfy4F6lRgCtQJ82asImPBr5F+0wEtAS529aAVyIBPR18Q6AQus0Xq7p?=
 =?us-ascii?Q?k8LKwRjqFxJYg0Cd6JomUHxdJSTXDaqY/NqPOQkq/d/GR/TfsX9ZC3IiOVNl?=
 =?us-ascii?Q?wfuidAMdRwcbaLWnR5Fcuok3hOfwIAKGaszMAkW8WRKIGFoa7a8sR/9tZmg9?=
 =?us-ascii?Q?0zZ/YrYYCSD4kOUmrsbWF1aLr6+6uNFTD/v9WoL5lh7dkjQAuaOVEuEW2YAw?=
 =?us-ascii?Q?KeVVgpW+RNsdKS+Psr1Ya6UybOiaS+rz2h/HuCg1eQasXvsg9DxCVyRh20uI?=
 =?us-ascii?Q?tTFVlvP/3eh/6+7hNizEeGOPa4TRaZei4vEBWkfXNm6u09bV5eahDLe90qbN?=
 =?us-ascii?Q?Hv6wP+ubw9RFJMsNIclQkANsNFyu3DgmRgpY7epMecJrvXym0IehEAtx30rp?=
 =?us-ascii?Q?R1F+hZduOOMbUIOoZczDmqqDS+wYDM3W3kfCfknMRQknIvsYo6UloIzH8/iN?=
 =?us-ascii?Q?i0plEViLSchXbI9fU6DOoPDIwe1Q3oCuheynbxIyWEWOWmlnfPrXEujO3ycw?=
 =?us-ascii?Q?HDFt/girTvq/KoISlW5orR8BP7NEZQU36LqXMceO4OVRJ2K4FltzM9sQ+luw?=
 =?us-ascii?Q?v7hs7+iBn6Er8xq/CQXGL434XJZ+R+oKODjnoe//KgnBvk/9mtU5d1kl/3Ea?=
 =?us-ascii?Q?9M16Pd8ODF0GQNPRit0Pmt4CRFqcCqnVaIBAum65TkAjx2Sr4JfKqBa//giX?=
 =?us-ascii?Q?gxXESltaVJ/bkLyLt02tuvCfOLmXNSWnp0n1QjFeInPy4sMM3Bh8cKzmgYxw?=
 =?us-ascii?Q?iwuGzT6fNkhyVfAA7ITlxLFPI4mG8697z27AIrA4Ybqvt18LuLt7wSt41y6P?=
 =?us-ascii?Q?05FFF8n4w30ScBswkOBRBWHvJgcy4wSJM0V7hYP6SZbuY7MowjHB5WKKfCv9?=
 =?us-ascii?Q?VC97s8zxK/vkAMcALXrv5wZcgyMnKmFrIRMf2BKuKgB+dxcHiQ82W9vy13Al?=
 =?us-ascii?Q?yWMPeiMER/dLGe1fK+SsBS9j7L2ksT4LedzQDZKESEsoQnugbU/GyCYCLHHn?=
 =?us-ascii?Q?MQM+vvdu571BIv2Kb6yFDLM9SpDByu+75noozdCDBxPz9c+gHr+/1q6KaRRw?=
 =?us-ascii?Q?lLtJH2820RjxzZGIAs05S5C1A+URemLiIsfCtHUNyvRRSAr0KQJPrxwZ5e4a?=
 =?us-ascii?Q?zTg4LrLrkRbauEWDUgqqFK3Mqm7pJrK2W96FoL4vOAy9nmSUXaa/rDmfXlxG?=
 =?us-ascii?Q?zMXkbZuXEjdIevXvApUBQNRG49PXtW4S6bwctxUPzUi80A3C9Rtq//ZyjA5D?=
 =?us-ascii?Q?ve9MIJWaE/1wNyyowMDYSPxN2mg0e0KkY7OSiLGPRLTghpJ/p0FLKTzSYuQ6?=
 =?us-ascii?Q?mONzCvja4yk8o82fE6BiJPr3O+tXVoFARIFc9FHE5WuTfx+Bm9PBXPAXgJdG?=
 =?us-ascii?Q?9iUo4KYYgLK029CSKN46kT17xExAVRsmeTzONGvmjSCcVlSS6P9xljrJAx4N?=
 =?us-ascii?Q?PDtSq5CRGec1fIHc7G5uu+AVA8fgE9h7a+s95vI/+wf/6ur9Me2qqtL1Ehmb?=
 =?us-ascii?Q?1K6Nb/LETIoXIYdFT0NThP3v07gnQREay1ZSde9IBaUMEMCzfZrakj9Fj6yD?=
 =?us-ascii?Q?LW7aH9I2hDZvjO7q76Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ca461a-76df-4201-0aac-08daa06b6adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:34:04.0562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFikDVey8XJzo+csqZ+QUmMgST2hita95VIrh4yqhJiXVpEvPBlAsb5coB4+czEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Change the type of parameter on amdgpu_gfx_cp_init_microcode to fix compile=
r warning.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_gfx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index e3535a963c5a..9546adc8a76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -868,7 +868,7 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev) =
 }
=20
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
-				  enum AMDGPU_UCODE_ID ucode_id)
+				  uint32_t ucode_id)
 {
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0; diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e9087f83d764..832b3807f1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -426,6 +426,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *a=
dev,  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);  =
void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);=
  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev); -void amdgpu_gfx_=
cp_init_microcode(struct amdgpu_device *adev, enum AMDGPU_UCODE_ID ucode_id=
);
+void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t=20
+ucode_id);
=20
 #endif
--
2.25.1
