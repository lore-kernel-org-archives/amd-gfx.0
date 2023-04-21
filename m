Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA2AC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 05:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D41C10E28F;
	Fri, 21 Apr 2023 05:38:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1447810E28F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 05:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3O8xJr8prE0OeqM84j1aKnggRt8rTFbbnkBAn1vB1JQPKC6QVautKMybcSBX92B6gHP9Mae+gMD7+0mspsoMXyEBszv/hCmRNoeT2e4lZOyXvAx22wIf++jnT4cM7rS2sfuV4dWDES509hswGgsbEaSQp5rS0tdCvK7o5OzLCYqA3ungB0zA4kzfLtsTJRol50CLVY0vSJVMEn2Vf7JaQbS3qvz6DurhXfAdbSveIbjuWN9b4tKuRgGGjE1BTqkXz4GHvrPCUsg+K1T1TGF38Cr9nvsWAwNrhwv+cWE4IRjvXotLZfbVgKrR0kiOV1SdZUiyetiYJbe0PZnlsVNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhoreMp2wsnrisT2GFzZ+ZP0TOY5q3G5rqeD3xhkJ+M=;
 b=jQIV8hU3LCzGVs1dkeBbWC3Sp2eGwLR9IsrWgu3pZg6KOV9eOLhQ/GfjFiWjrjwbhC/FVregGhSkBy9xjDluRioG+k07iAo9Ttqr7qxYYa3J+dwHDq67HUal7u8821wreEcuq82c+ymMuQmgm3mXWaTUQqtwMuQUQSvwxr+lBT9BVcQb0ZP9e7nXwqa7J4+5aY26ULdkdqVmlpoLblrdePNYmnLHDOIrdxOr7g1SpSRBsVMgHaz3w2wC2Coi6rb3q2+yyl2v/nIRNWPt0vHC8vY3M7OKKkZ9LyFcpEpVVjs+kzSFxHoo9l2SeWSP4GUpot1DS59JiqWr01WbC7dPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhoreMp2wsnrisT2GFzZ+ZP0TOY5q3G5rqeD3xhkJ+M=;
 b=ILybIFIevP1j0cVM5FLgOjVeBj7z0FSjaqw+TssUWZaujmrN7pCo2b/pIh/HUuVwKKs3petUJpqsOclLqDW0MYg0Xft0hpzTGav4C6YuoVscz078/ukXtU5+LCW9R0MZTLKkK4KrzVhPp88c7oWLvCCppc/fTN7YkgXzrS6DEuc=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 05:38:08 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:38:08 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: support psp vbflash sysfs for MP0 13_0_10
Thread-Topic: [PATCH] drm/amdgpu: support psp vbflash sysfs for MP0 13_0_10
Thread-Index: AQHZdBLx/nm/gVb2G0asrDk8MZNrra81PgRA
Date: Fri, 21 Apr 2023 05:38:08 +0000
Message-ID: <DM4PR12MB5181508563FD7EB3B9EC54B9EF609@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230421053405.1075529-1-likun.gao@amd.com>
In-Reply-To: <20230421053405.1075529-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T05:38:06Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4ca823c2-a21c-4bb6-a2f4-28610d36cf89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-21T05:38:06Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: cd935e9d-032d-4beb-b2fe-7dd327768a79
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|PH7PR12MB5951:EE_
x-ms-office365-filtering-correlation-id: 576c8739-12e6-4ff0-d1d0-08db422a9678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3dQYtpzm3ysZL0RqQ8bN9mbIpGgqw4HyAjwdcPO2kFJOV5TFpdc/Fqg3mbVw6s+2MAu+lsSYtF9PFQc9Co88Ep/MOhPybGt77zAoGbpzaH7wcAX0yPmKD0l2ejph+2T5uTutzOoZMMt5yt5Ak2+g9oinGoqy4RcVt4AwC6Xq5GOmrHBnpt2QvItgVTLg8JG9tAa2fnxA2keQ2ge2ZaJoxT0xmEfuK/KjJzWwiIYQxFez8x2L5O5NdhsCQmd4N/Zmj/b+vErMU3DgCLT2Ccv4tjPXF6GBT0n+rC3wafdK4yHjfcMhocXrfbwGdQRIEB4y8St6BwVA2OTLeGakp+5hyvnAsxs3P1/PR83JcmrPTGt6EnCMpwOTov/Rz8+kjzGOn71wPtG3szRu+anEM3jEV3mFLwgcAfrhRIvIkhQghCtYnWyLZKrVR+mH3S5YjSQkjWZX2NF0RpcBY5nXBjNL0PJC1SEPJ675VARMumMum/Xwh+t0WnVWLc3+/x2D5q70Lwb7/IS6es6OOkXqoeOgbCkkBNWvQumDmjJ2fFkcdhiLgHH1tnzXZKr700MNw9W8094Kw8U6ohwsznk6wWLd9sIiPbtYvMKe0qaqRpEscU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(55016003)(186003)(26005)(9686003)(6506007)(8936002)(8676002)(54906003)(5660300002)(52536014)(86362001)(33656002)(41300700001)(38070700005)(316002)(38100700002)(4326008)(66556008)(122000001)(66946007)(66476007)(76116006)(66446008)(6916009)(64756008)(71200400001)(7696005)(478600001)(2906002)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W7VKl4slpMLZMi+6UvNmPlhmA7dg46+1A6rbOWkPzu4UZL0emK5NYOGYNsmw?=
 =?us-ascii?Q?NU/YVtz94spgvUt03gArdaZafkZmXdVRmteAmTmHCfwZG24xT8Q7l9OQcMVW?=
 =?us-ascii?Q?6ehWSUcu/SMrUiBRql7WmamBdGk07Q7FGw7BDffZq9fx9MH/OQNEAAGRiByz?=
 =?us-ascii?Q?lF/3IHxgkNm4Ah5VMncAv9ic9irMAuopxOVuEZsCVkxpwx+5T4EdTNZt7bTt?=
 =?us-ascii?Q?Ox6fJTE+spft6k/ZcHkpIPyC1xaqvwmz+fh0QCw2ifYaAdDISGFtbpsZ3yHk?=
 =?us-ascii?Q?6BeFzcUwhJRI9AIvwE84T7kyA1kOJZL2c2EF+MGR9h/wsevF2pblW8hH0C6x?=
 =?us-ascii?Q?5kF5aNUlgsXIVGCSFT6c5Ke8MA3g/QdF5SXdYnZAXzaRwWtjoTL1CiLcNMHf?=
 =?us-ascii?Q?7BIfr2CmMgqFdYSaDTzWNo2NdUDI15CTJDTDzxklcmjVtKfbiuHA0ILSqeLJ?=
 =?us-ascii?Q?Vo8ADSjGPk+EebKhV14/BJRqOMwaXkkBiFrMlOa6QmB2d2+rul0SQ7K4urVl?=
 =?us-ascii?Q?W18whTp4lmD5lZZCBf1sP9wVoqcnBCkdBPmF2kBGGplFzAIoK7ZZdgky8iYj?=
 =?us-ascii?Q?yAIxMuH2aqVEyREc7CQuVdauwcPUonVvIzi3oYKR4NTp/Kkqss9FRQh2z8wv?=
 =?us-ascii?Q?XHNCCKnjkZcxQQmGHISnprz3ecYkdxu26uOGv+VdSpr+B62SeHiwtJn6gsJJ?=
 =?us-ascii?Q?w9L9QjOw3Tg2mboomkWliCNV+NohURUw1GRPagf+qc+EF/Z3DjqwBZOEAen+?=
 =?us-ascii?Q?lzt5JO692c+pQCOoZl1JUr+Zjla6lbEFWrJpXGF+KYZUKTtXaXQky/0rAyzM?=
 =?us-ascii?Q?eR8sqwofjF1b24lVrEzVAOsvyQUR2o+bQJeYTrJvZ+AvZ+Px4cvuGfY6oC42?=
 =?us-ascii?Q?BfRkYlbN6nqeDaSykzwA3Skiy2wYFg4RJJFARkVDRkj6fFsj4lUW4U5Ip3IC?=
 =?us-ascii?Q?zXMo2WA0WF1sCj/yJc2ombem0AbOVwn/ULHeSsfV3CcXgHnDfG/0M3NKnBBv?=
 =?us-ascii?Q?NlyvfWePxaG230JkNOMeO2ztSNLcqICpx+SjgbBsNQfswADjthtw4RsgaKy8?=
 =?us-ascii?Q?ORJHOBYlhtzAVNcibb6FmH/otma1Z/NhY7mYtmEqbTqGuC4yg1ha0xWFaKQS?=
 =?us-ascii?Q?yftynVvO+98DFyY7G1tO3Hbe+2TyMfAgudoaHXEAPiGZrEF0ZQabev/y2XyH?=
 =?us-ascii?Q?l6tlxTd16/KPvcvXqMCsGmBsodM4J+W6RpbkelrnO/9tCQ2DZEXeIcSJafjz?=
 =?us-ascii?Q?DcuWcXENjhIPcmKEcIV32y5z5AXG4YaAB1gqL2t7jfMbedYhR9Dd3qJgUFW8?=
 =?us-ascii?Q?XymxqZ3Df4rEAamKRmuvABryfJZGbuuAryUkwfGrdIMmGOxYKHpJ2fUQOrQ0?=
 =?us-ascii?Q?kGJFcs9Iwc3zwUwk6vWwG+VgroRw5WlkpKpnYz6CqK1h5J7XITFbBb8bR7DX?=
 =?us-ascii?Q?8bCl49Rfc2X05V4A3lbJASC5xeLfVb8sdc1fFEbWLOjXjQK8Q0AMWzPtU3zO?=
 =?us-ascii?Q?QeGsxVqlMCFuqRDezOCHiJz2DsKAnSOrjrQPE8SpzvbZ0mAY7KVn7cevOUiN?=
 =?us-ascii?Q?8rC6Newm6yNBMVNzD34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576c8739-12e6-4ff0-d1d0-08db422a9678
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 05:38:08.3162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOTV883yzT7QpZL3FBlCUpG3AeWkZcMb61BAoyowP5JCgq9jiLciXE/hN2SFqHTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Add support for PSP vbflash sysfs interface with MP0 version v13.0.10.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a39d4ddf7743..3e900af06c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3619,6 +3619,7 @@ int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		if (!psp->adev) {
 			psp->adev =3D adev;
 			psp_v13_0_set_psp_funcs(psp);
--=20
2.34.1
