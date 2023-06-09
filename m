Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7526C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 17:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E5A10E177;
	Fri,  9 Jun 2023 17:57:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DB310E177
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 17:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpfosnwe+vA76RHyhvVE+YMyT2kWXDuubkPYC2UczdT2hGsQLCZKkUUBXx5emL2pVVCr/1Qb/6XN4Iam1EGLy1OU6IhEtw3zOjU+g7ycAyL7i353t5r9W/B5LHDx5Zx6P2OZ1+pASGpWbaDUZc0DdEX+RCZqashxHLzpg0zPT93O6HE2vh9kGo203gpu/X/Icbw2jp3mxvIhn1b2bGD1kxmhXzARtiDO+Xe8iQAwjq9hcg63Mqze9CEv9qezczmn+ee1Z7J0eBCy4ZfPH3ETh4fdqV4zBSRY5caHzCTfuW00bfMy5ukv592SVKDfGABQ9QMtsjJ+iURMbELbfwaUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTXlm3rY0S95c4omfRv1O6wmtsZooZ021f411orlr1Y=;
 b=AtX/LLR4D8VzA6enPufLW2D6mvspFEe7NM1703OSyiVZNNNNf5cJ4qQTY1GJBc/VvrnkToHP21Y+b1BmDyNvuWf/JBb580IXzOYuNoMt9vrFj/SF7IfFkHW/CQE3Cv9+3v7mRuNiW29HNHW5haaPrAkaFvcflOIgQ6o6Cqdo7PeWA9j15VL6F03cOcKb6qkFu8TzZ1qHBTF0ligHtYtpoxw9VFkoMgz15+EjnI1ShahXBiZ7e9IIEbtbhfRtq80FLY13OI+eBlC8IT0ltOuU2XqfKA03SzR5x7pKCjB99zRJRCakbcNtvclJpUDDCa5XePJ2haGo6Plh7ciPi/2yaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTXlm3rY0S95c4omfRv1O6wmtsZooZ021f411orlr1Y=;
 b=nTP6kC3kGbEGgevDCU3FKq/O2UM7CfNL2klsrMLrom9gi18ajYb8za1pccGwzq7Yv/xRtXkZNfL0cd6r5AcZ7HfTPccGFVx/ONLBHpQnou69QF5LRSo9U/SiginotA9bPaQqHrmfSQRzJ7WMUIA+ffzK/z2h9SFuAo0cnut3YEY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 17:57:29 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:57:29 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.5
Thread-Topic: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.5
Thread-Index: AQHZmr+HXcmfDzkss0m4QG2R8Fu9W6+CwiPb
Date: Fri, 9 Jun 2023 17:57:29 +0000
Message-ID: <BL1PR12MB51440A47EF3F3AA16C153AB3F751A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230609104427.636097-1-Tim.Huang@amd.com>
 <20230609104427.636097-3-Tim.Huang@amd.com>
In-Reply-To: <20230609104427.636097-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-09T17:57:28.475Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8017:EE_
x-ms-office365-filtering-correlation-id: 55dbe364-c1f6-4397-848d-08db6912fdfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhXUp5w1CerkoPilEQnimkOk60tTnvXL7ctewhlxAFBhN6OogKXhLUR6l7nju2UCfRlG2wM7SCje5jgKYkyGgpE2d+EybnE5oFO87r5y9L2uI6uRc0Xn9fLrsF+suTWuHuWeHw4sCRKn8jd7S/Xhgt+Lxj/ZZYfOt2Ufq/TCsLKAbqR4iF9mtLPiCKhf47a7CC68/dirk7T6EXVzvVRdaOAIlFAaxD+voI71/rlM7uEd034JG4dsi+r7WA6bQ1Al2bWDLJ5XlYJ51i+lo0Uwztl2XhwXwHyi4o8x7l/SSxcPabjIZSoEWf1+wGl1EcgJRC+cA9PQJp0DNSYiizvKcEUyxCRQ9dKUTlrhpMmVup6IFLGwqBeeaGouSbOLH0OD93TyQCfTYf8Ce0eTT3IuTVuW4xjbDZPsCEY3kRU6B/s6Qofe/yYwRO12kTAoVr9OM1oFl3oTe+ednnSihBaGL2aGljaj8V9zWiWy4emn9gw5Dkn7FYulhXOa8iTAr37ZmC7cMeHIThHO0XzejZmXloDrVGhcFGJEBEgZXlIF1Ldo5NxhEtsgse7271SpkxyNr7HnBqLRpvcN4D+VQyBcgJ2a/Mn/K5Frh1dAlCZcYmDdt+DCcc/WqS3aYhrAoMH7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(26005)(9686003)(53546011)(186003)(38100700002)(83380400001)(122000001)(33656002)(86362001)(38070700005)(6506007)(55016003)(8676002)(41300700001)(4326008)(110136005)(54906003)(66446008)(478600001)(66946007)(76116006)(66476007)(2906002)(64756008)(8936002)(19627405001)(316002)(52536014)(5660300002)(71200400001)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVAn6UgH7UBjx8HUdIHyVKzb7UDXUB+RfSON1H7p+fZrGLtojYCk6651yls+?=
 =?us-ascii?Q?aIz08HSc19Bk0FPBkixnodF2q5LudT67/q8Kui4N/dk+13Mc38LEbZCO/cpu?=
 =?us-ascii?Q?z3/Hf+k0l1eSyExxL52mnqC6IiC83lCfzeDsmmOneb52dJoXU41WimlKKfy7?=
 =?us-ascii?Q?NYakkirP4/qlh0J5X564MD1Y1bDDCR5H5DyqpSVEbCfmApBAjGQ3ATv83qpC?=
 =?us-ascii?Q?wdC986DaDszzChfXhwu/glaUop34YcTmpbKcBRaPQGTYkAgGRisS4idIb9nU?=
 =?us-ascii?Q?9RrzLXyykMVDDAaARfPBh9ezTKvb6MuEZdy1Go/artKtqdbNrpgb6bfo6B5T?=
 =?us-ascii?Q?JHJmS4sKFx4ZmjbP2idnT9t03KKEj2AE5qrWeIU3F0bxT2uS9bS3Q1V1vRho?=
 =?us-ascii?Q?oWX2NIqm/BRDZO446nWXhoTWZAqagstVZlLud3mJp3BbyHehJoCpLQaLdK/x?=
 =?us-ascii?Q?kQKvIAi/eUL8mj2tr5AFVfgmb4eZ+xBiveJo3y65qq/f0su7prFw6ZhDMt1g?=
 =?us-ascii?Q?GSZHqdqfB29fNbqL6TSwT2ZV2WB/FLHXgbVr4rb9iFpC8rfr9nEQ7J76ii4n?=
 =?us-ascii?Q?qwrsTdfSjBhec9bmUVvN70gfN+QNfG2JckHZX0VUNzVWMbJYi6mDBa5HRDga?=
 =?us-ascii?Q?CSl5rsCOAmjYIaTeZZDxeUN0k8rgXZ7b6x2wgU/u/67pnJLTxYv9w/h8rPyn?=
 =?us-ascii?Q?HjV9+hm5yskMV2IX3MrcbkVsWFZEFPSWvo+s/HoLSCG1cAinYE99oMiPfohF?=
 =?us-ascii?Q?FKUoQCIm8wLjcRZg21op3OntctwkxcYADnz7Y4R1Cp6ZcslTigBp/Fq1lspi?=
 =?us-ascii?Q?dRmLr4e5wDnvkr7qfQHUWfm+aF2ztZTkbv3AAwp7Xs3ODW3HL4ouRhqADMSU?=
 =?us-ascii?Q?PGbxdrRqo5LAYK4hjo85F3UTWnPhGuEJLEa9iIpObgIciPFEZVdsMCPHbwxH?=
 =?us-ascii?Q?lIong1nAhOrl/kISpW05TZCsuvMF/TwKfrMccoDDFW4r1Pgv+F/dhsl1XEUi?=
 =?us-ascii?Q?nhO7ZLYehh7qpn8WO7MwbCdutl0nbesMiamYG0Wv+08QMG1fw3ccVgiibqiY?=
 =?us-ascii?Q?0rpg/C0O2daW4zHmUDu56SU/7Kt/t0nrL5gz7wnRQtNNPlh058FKo7FRzNH1?=
 =?us-ascii?Q?2wDXhCL+MZzjrWJWkbVrBn4bRKUVGdrmj13Dek9ronIo0u8HB+B1raDvHC2f?=
 =?us-ascii?Q?B3TY91VkvWTpFuWPTMMa39F8ASt7WcxZ6ZUr2dgxvaHdbsV2ztvyi+/Ukt3U?=
 =?us-ascii?Q?6GaLL6igFTOXVAzuvVgjxGe7aXhxMlCY6AucH1zCm5j8tCAhke4101yCboqo?=
 =?us-ascii?Q?VXC5Lj0LTcHks274rXEdiKnphCsWMD6EZmtwK8jcFuViMtAgJUmOb745to1Z?=
 =?us-ascii?Q?VFRIOt/BG8siaJGFsGtLwdee4OldWyEVsJAoBnVTcPyA9Ffu4JG0hvYSW09O?=
 =?us-ascii?Q?wqxadxC2wROnF5ajZN2rtk0ud+wpNQtlcq2RHCLMlGzx1ke34OBzLq01MDld?=
 =?us-ascii?Q?jLx7LNz6Nn6z+rL/0Zww6BjjNGl9IWiMxhQrPNLN4N0Jbt3N7AEnWmoL4a0S?=
 =?us-ascii?Q?EpC9qfk2EI1D7G0+0SU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440A47EF3F3AA16C153AB3F751ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dbe364-c1f6-4397-848d-08db6912fdfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:57:29.4494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiT157e3l0S0fLSX1WYmM84WZ9N2xEfDRrGVn40yyUL37xD9DhGgyNSCHMySPbPUPSukBO1Cqc4V0U9Ae+dBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440A47EF3F3AA16C153AB3F751ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, June 9, 2023 6:44 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Huang, Tim <Tim.Huan=
g@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for SMU=
 v13.0.5

This patch enables following UMD stable Pstates profile
levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_sclk
- profile_standard

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 40 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |  2 +-
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 53c508acf895..42f110602eb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -978,6 +978,38 @@ static int smu_v13_0_5_force_clk_levels(struct smu_con=
text *smu,
         return ret;
 }

+static int smu_v13_0_5_get_dpm_profile_freq(struct smu_context *smu,
+                                       enum amd_dpm_forced_level level,
+                                       enum smu_clk_type clk_type,
+                                       uint32_t *min_clk,
+                                       uint32_t *max_clk)
+{
+       int ret =3D 0;
+       uint32_t clk_limit =3D 0;
+
+       switch (clk_type) {
+       case SMU_GFXCLK:
+       case SMU_SCLK:
+               clk_limit =3D SMU_13_0_5_UMD_PSTATE_GFXCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
+                       smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_VCLK:
+               smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk=
_limit);
+               break;
+       case SMU_DCLK:
+               smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk=
_limit);
+               break;
+       default:
+               ret =3D -EINVAL;
+               break;
+       }
+       *min_clk =3D *max_clk =3D clk_limit;
+       return ret;
+}
+
 static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
                                                 enum amd_dpm_forced_level =
level)
 {
@@ -1011,10 +1043,14 @@ static int smu_v13_0_5_set_performance_level(struct=
 smu_context *smu,
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
-       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-               /* Temporarily do nothing since the optimal clocks haven't =
been provided yet */
+               smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_SCLK, &scl=
k_min, &sclk_max);
+               smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_VCLK, &vcl=
k_min, &vclk_max);
+               smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_DCLK, &dcl=
k_min, &dclk_max);
                 break;
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+               dev_err(adev->dev, "The performance level profile_min_mclk =
is not supported.");
+               return -EOPNOTSUPP;
         case AMD_DPM_FORCED_LEVEL_MANUAL:
         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
                 return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
index 40bc0f8e6d61..263cd651855e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
@@ -24,6 +24,6 @@
 #define __SMU_V13_0_5_PPT_H__

 extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);
-#define SMU_13_0_5_UMD_PSTATE_GFXCLK   1100
+#define SMU_13_0_5_UMD_PSTATE_GFXCLK   700

 #endif
--
2.34.1


--_000_BL1PR12MB51440A47EF3F3AA16C153AB3F751ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Friday, June 9, 2023 6:44 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&=
gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels =
for SMU v13.0.5</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch enables following UMD stable Pstates pr=
ofile<br>
levels for power_dpm_force_performance_level interface.<br>
<br>
- profile_peak<br>
- profile_min_sclk<br>
- profile_standard<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c&nbsp; | 40 +++++++++++++=
+++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h&nbsp; |&nbsp; 2 +-<br>
&nbsp;2 files changed, 39 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
index 53c508acf895..42f110602eb1 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
@@ -978,6 +978,38 @@ static int smu_v13_0_5_force_clk_levels(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu_v13_0_5_get_dpm_profile_freq(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum amd_dpm_forced_level level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum smu_clk_type clk_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *min_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *max_clk)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_limit =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D SMU_13_0_5_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_5_get_=
dpm_ultimate_freq(smu, SMU_SCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_5_get_=
dpm_ultimate_freq(smu, SMU_SCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_clk =3D *max_clk =3D clk_limit;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static int smu_v13_0_5_set_performance_level(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dp=
m_forced_level level)<br>
&nbsp;{<br>
@@ -1011,10 +1043,14 @@ static int smu_v13_0_5_set_performance_level(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_STANDARD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE_MIN=
_MCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_PEAK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Temporarily do nothing since the optimal clocks haven't been =
provided yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_SCLK, &amp;sclk=
_min, &amp;sclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_VCLK, &amp;vclk=
_min, &amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_DCLK, &amp;dclk=
_min, &amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE_MIN=
_MCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;The performance level profile_min_mc=
lk is not supported.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
MANUAL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_EXIT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h<br>
index 40bc0f8e6d61..263cd651855e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h<br>
@@ -24,6 +24,6 @@<br>
&nbsp;#define __SMU_V13_0_5_PPT_H__<br>
&nbsp;<br>
&nbsp;extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);<br>
-#define SMU_13_0_5_UMD_PSTATE_GFXCLK&nbsp;&nbsp; 1100<br>
+#define SMU_13_0_5_UMD_PSTATE_GFXCLK&nbsp;&nbsp; 700<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440A47EF3F3AA16C153AB3F751ABL1PR12MB5144namp_--
