Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA441C38142
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Feb 2023 05:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A4310E15A;
	Wed,  1 Feb 2023 05:30:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361B810E15A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Feb 2023 05:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egn3U2Pn5l59hFokTKEVvP9t2A7nfSWjvtIHnt3dQ6BNfSgp7+INLfCVPUNn1T6Ass+lX0r8+FC159BQzFrAJ6JKPBccQW0+6aQjn1kZ9IqTK+U524T2ReGFj2OtZ4+2vfwqgd2Mc27kwgTcbMO0UHrTPGcHSLKczfpVPGl6i/d8/pssXFbwQgosrZMkzF5Bbsf61DPRbk+isBrKwq605EVWK5uLqnKogJZtoWW3grf6nncu1DQE0fS0igtlF9CoIkT2KO5GedLhff/I0MRLxkH61mrxQsoUCZddMOqqJ4lZXAykF18RKi2jQ5dchD8YFE1lVwiwmmWDqKY9X5xRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qeqfd+/U9IprBcgfL5ooHnK5xLk27Mfl4J3yCVDkcrs=;
 b=i3KiuKcbRMSwuQufMRyWVK/WS9f13k0m/OD8u0OQ40Bn2qfBol7D3UZYBSYHJxU27BpGlsICifVABR4HYx5BWolH369m2FVBlFF3d8zK9wbbXyg45JVO0f8zk6dhPXSmVDFIbeGYYdMcbQWrA32BBEwQWdOOfjk5+I7Eos7iYJI4jnMMtwNDOsr93cS5aFWMLS+kO8iTiBt/s+0E0/4dbKok2l1H3TqyZ7FG4yIeHhvH6UbMALD+WYhFGgVTIgOBf7Yh15Y3mlzO1t5gepN9c73p6op2zgrdET4aMfFhNqnxnTpcsI3hgYckdvw560ivXJsCS0dr0CLSJrdvLMNFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qeqfd+/U9IprBcgfL5ooHnK5xLk27Mfl4J3yCVDkcrs=;
 b=SF2GG6ZR5CeO9cuASchrZhy/CmQScO3VOXD4+kweNR02UWlWWd6c4l2v5sRPzkrXaSAHTk3jHFRFG9IRuIXBbOFvneko0rI7KMlo5uD00Eba95GnmL+g/z2UiLaOr6X3jKdgI8kJ4mxbCrEtBdViNdkpigGfziXCT4A4OSfYClk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 05:30:47 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 05:30:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG
 interface under SRIOV
Thread-Topic: [PATCH v2] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG
 interface under SRIOV
Thread-Index: AQHZNfw+u8P6DTF6b0eohBN88QLNfK65kJsN
Date: Wed, 1 Feb 2023 05:30:46 +0000
Message-ID: <BN9PR12MB52570603778A1A311E0FFAC0FCD19@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230201051356.823546-1-Yifan.Zha@amd.com>
In-Reply-To: <20230201051356.823546-1-Yifan.Zha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-01T05:30:26.1604364Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6378:EE_
x-ms-office365-filtering-correlation-id: 7afe0049-88a1-4047-06cb-08db041578ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YiH5JUgHPZ061MeBXOy+jlaq8FulmTPMqjcSoKwtgGKKsxkSt6ELXKlze/fV75wEiWPeye/WQPdSVuWbY34dT074CzzVEgnVWPIQx7LLutHdcux2nflc/z0i5Rg78npxC25je6rPmJyYJo30txTZEle5fFmE5jfgTVk1YEcQew1fEDSh5+BceiOoUtaMuHCaqriMh2EuAHw2Fd1lB412iK2LnjymGxAqMCeWFLxnP3rak00TwDUAEYWZOuBBc7BoQ4fBqAA0YXkfSedMtrFyZvM0CRQUaCH2K6H6qLTsXDzx25pvH2Vz+XV3kPqHXvlRNeS1nJTgbPECGQk5mMLeatj87364UAifEx/SQ4UFbl3GpRBlYF+0x9cK1Lgw5OYxQrPUjV5MlOiPVCcWI1HQm93Ac3OhTk08seVdJyVfJsLMGSo3O7tEchqJQ7HdmfGAH+DunPv0OzhUA35Cxd7l6+1JrXZ9roGATZhpLIAAlW8sT6wJNCmdXvsgnjjdsBU3BvKqN/YewUP+DsbrY7rxT34bWgUxUBG0CN7/Cy9XL+AdMz/xbpNxC2Kb1rf4Xpf24SbJAI5phgqs0v4Je8n3kLoAguWt2yuTa5IL0fgMw1RaqpeK2TSMU/Qblj58YUPth3/QP8a3iHv/MP8PVvyNZBXT95IZ6JXrY6X4wwgYAvQZ7T/LACN8ZniJb7E07ZzJ2pGMb4Q5IuSxgPL45/U9aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(91956017)(76116006)(4326008)(66946007)(41300700001)(8676002)(66556008)(66446008)(66476007)(64756008)(52536014)(8936002)(110136005)(316002)(55016003)(5660300002)(54906003)(6636002)(33656002)(83380400001)(71200400001)(186003)(7696005)(2906002)(9686003)(478600001)(26005)(53546011)(6506007)(38070700005)(86362001)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ERCgkwXNOa2ZFb/pIDRGL7FySX480rkl4wXiRQeO4/WL2CrVkH/Yt9csPouS?=
 =?us-ascii?Q?YzsOJvzOQp+0fj1QTZzMozpo3Wsdg3Fjab4A1532rGJJw8z3u2ocnYlqs7++?=
 =?us-ascii?Q?1sln5gjhTpPwyxWK74X9Hfez/qOKXZUkXHlo3/QKo4y53yI2VJhQX4rsgmkg?=
 =?us-ascii?Q?aCv+NV4FN3mm3zy1TV0jPmp8j6nzDmdeFuzgnzsdUhs2RePHpDHffmkVl520?=
 =?us-ascii?Q?MywioP7t31Er1i46io8yIHiGo6Dq2Xcj3XS+E5pd7//9NHHy54gMcSwwZYHZ?=
 =?us-ascii?Q?wyHUma9iJ9RbgahmkAFEP376U9P3Oh76lY/JqiLB5l4Ml1RFMbw3Eo1lXDXc?=
 =?us-ascii?Q?UjQvCh37aTcVqnSfnRymo1uw8Ra0YuUAM3UVPjMwCQBwvvokIfpoEMFMb+Yr?=
 =?us-ascii?Q?GhiCH30bYqsV4JsPR8Wm1zNILGog6JfXFSYOvXmU4hGo1LTBgTdY6Q8mmBX+?=
 =?us-ascii?Q?ct7mjW8XYxnqOUsmcDaLkkgoMDZ0c9cNKmUnZ34wOkRIeM179zDEVWpRMLvX?=
 =?us-ascii?Q?ZNV2eYsunrXZGRCtUgdMnQlBECFp/tkFSgJNL4EYkatuv3pR5RLee7UKgBTv?=
 =?us-ascii?Q?sI4FJF3n9ZDR3KZyTBnhjH3CS0WAS77V76nPdGkeNSXBJAATnAJ1sFtgpRom?=
 =?us-ascii?Q?qZsNwfYOI1uVXoa5I6kN/fSqmTdEuz9GqyeVvsH184gLn+UAY6dPZcMQRI4C?=
 =?us-ascii?Q?IGJ79DTbwTK627bBbDjVboy1ilNC6uY36MM2KV0g1gCUw5cUhsrO6k5Binf4?=
 =?us-ascii?Q?pvbMCj6YEWATsKyKg0Kxexk20Ba5mZ81j9M1ibXol4Kjl7DiZj9fSkbE6Vor?=
 =?us-ascii?Q?z2rXkN/VsMlTnoaOKI2TRMgZyoSsoxyN5iNMmts72cgFh4XSmlKBItcKXIKS?=
 =?us-ascii?Q?dnQND+CRKVvAt6rurobYqB0EME/gXHUvk1ujX9V5rax12ZSyp/161eIiJYB8?=
 =?us-ascii?Q?zrSvFqkXCAc74417O0t9WT3s7c++RPqmi2td8gYn1KyLqWa8+zPSkStPjqOe?=
 =?us-ascii?Q?avWFyDSUZwP/Y7V9aS2h6YbeH4GbouEqcNYn4cUz1yt/0Tn319MmjnoUMTyD?=
 =?us-ascii?Q?gqy8CYVcq24ogqubRJVNG/8ACR8lHt8c4V0i8SgJi5WifGIoeiDZSOxdfYG1?=
 =?us-ascii?Q?LvImwCyZiA0wfEroIWa0QzXT+bO3/O3igrc6iVn+wZKTlzgwRsFkqvDSJ6sG?=
 =?us-ascii?Q?tjSklRC5Odp1vk0i8+9rAuAEFLkv8VakaISbODMeyp8dlWz/l+nNrzFn+1qd?=
 =?us-ascii?Q?ZqeWOtzLNgaaATbjFcKwgoO74/KzNUTKfy3gmqQMHuDPbcU4v4egkVMn7sSj?=
 =?us-ascii?Q?ieZLJXdzo4H03tSVY/mTer51PDHbMNMY6NJNUpPaRLWTr4VvhAHpidfOp4PU?=
 =?us-ascii?Q?JwW9xXD8mmIWI/Vduv5E90IGmAZN1n9hTtt0PZNt65v2N1GjNZVsuXJXlSEV?=
 =?us-ascii?Q?UvOZC2OUQSUjIUIthT+P8RAd0ED2cI4bLmu97m511sX1MqlfMpupon3MUxNP?=
 =?us-ascii?Q?zBbATZ9xMt/FCZTZ/rcSIk2XE11fkVu4ti77J2qbvLcckve43xFixDBQWlA5?=
 =?us-ascii?Q?t0jzdKYUj+SW7ZrLkL50QnLr+ayxmXyC6I2L8805c7OIzqZeNxhdzeMOSkTa?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52570603778A1A311E0FFAC0FCD19BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afe0049-88a1-4047-06cb-08db041578ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 05:30:46.7861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqJwD6wXkGQd5mI1JcAhMRMteYug1Ss4Vv6+LS8oSzcOLlX8zf5rs4yGxiPzI2wDh2DtdWq9zc9GydsAWZXozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Zha,
 YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52570603778A1A311E0FFAC0FCD19BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Yifan Zha <Yifan.Zha@amd.com>
Date: Wednesday, February 1, 2023 at 13:15
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Deucher,=
 Alexander <Alexander.Deucher@amd.com>, Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Cc: Chen, Horace <Horace.Chen@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH v2] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG interf=
ace under SRIOV
[Why]
Accessing GRBM_GFX_CNTL in full access time has risk when VF is doing MMIO =
attacking.
Therefore, VF writing GRBM_GFX_CNTL are blocked by L1 Policy.
For RLCG interface, RLCG use SCRATCH_REG2 which is copied from GRBM_GFX_CNT=
L.

[How]
Remove writing GRBM_GFX_CNTL in amdgpu_virt_rlcg_reg_rw.

v2:
Remove directly writing GRBM_GFX_INDEX in amdgpu_virt_rlcg_reg_rw
as RLCG interface no need to use it.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f39391e03d46..ca5a1d026f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -983,11 +983,9 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_devic=
e *adev, u32 offset, u32 v
         if (offset =3D=3D reg_access_ctrl->grbm_cntl) {
                 /* if the target reg offset is grbm_cntl, write to scratch=
_reg2 */
                 writel(v, scratch_reg2);
-               writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
         } else if (offset =3D=3D reg_access_ctrl->grbm_idx) {
                 /* if the target reg offset is grbm_idx, write to scratch_=
reg3 */
                 writel(v, scratch_reg3);
-               writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
         } else {
                 /*
                  * SCRATCH_REG0   =3D read/write value
--
2.25.1

--_000_BN9PR12MB52570603778A1A311E0FFAC0FCD19BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rega=
rds,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Yifan Zha &lt;Yifan=
.Zha@amd.com&gt;<br>
<b>Date: </b>Wednesday, February 1, 2023 at 13:15<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;, Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;, Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;<br>
<b>Cc: </b>Chen, Horace &lt;Horace.Chen@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;<br>
<b>Subject: </b>[PATCH v2] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG=
 interface under SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">[Why]<br>
Accessing GRBM_GFX_CNTL in full access time has risk when VF is doing MMIO =
attacking.<br>
Therefore, VF writing GRBM_GFX_CNTL are blocked by L1 Policy.<br>
For RLCG interface, RLCG use SCRATCH_REG2 which is copied from GRBM_GFX_CNT=
L.<br>
<br>
[How]<br>
Remove writing GRBM_GFX_CNTL in amdgpu_virt_rlcg_reg_rw.<br>
<br>
v2:<br>
Remove directly writing GRBM_GFX_INDEX in amdgpu_virt_rlcg_reg_rw<br>
as RLCG interface no need to use it.<br>
<br>
Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 --<br>
&nbsp;1 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index f39391e03d46..ca5a1d026f5a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -983,11 +983,9 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_devic=
e *adev, u32 offset, u32 v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset =3D=3D reg_acce=
ss_ctrl-&gt;grbm_cntl) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* if the target reg offset is grbm_cntl, write to sc=
ratch_reg2 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, scratch_reg2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) + (offset * 4));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (offset =3D=3D r=
eg_access_ctrl-&gt;grbm_idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* if the target reg offset is grbm_idx, write to scr=
atch_reg3 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, scratch_reg3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) + (offset * 4));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * SCRATCH_REG0&nbsp;&nbsp; =3D read/write value=
<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52570603778A1A311E0FFAC0FCD19BN9PR12MB5257namp_--
