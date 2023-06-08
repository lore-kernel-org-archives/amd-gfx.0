Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7417C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 03:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B20310E585;
	Thu,  8 Jun 2023 03:24:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCAF10E581
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 03:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laUQZxJCGZXonzaK/46czppA46m64jm/nATFtYeXVLlK87IAMhQ470SYVF9GvK2T1FKotW3AqGwm+WBfaFWD821YW2kWW9RGXollF4UWogHmfOQkwDcJ+pdL6ENKo8xxhY4ccfyZejaBszjJFXHu8snFYz84QbEar5aPPNp9Y92XM/jSEDmaSHrT9kUMs6qEa6bqjMJgEpVYg8SSMoPYOs42hzwFuyj4ZAteN44LoCfG59THm9blYE7MTVcvwIqdidFF0KAV7y+IeUPGmv4z6uVO3Ai8WLhIvUGLYbTrpiYkx/5+NiBcEgD88pf6KVPEnnhinxgjTUd47i7W6Fif2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Broc2zX4YPb19T5hgZQWeLBttv0xkntVLNk8XVav2Wc=;
 b=Ri2DTG8KnrHKnj2ZriXj2e6UgQpDT6Gx6bAG50KsgR/GVqb/xlD/jyDZPDWGs5/j2wBOtwg6eYg4wPDxpHSoawsfXmTHzmRbTe3985JHJFeipoIb4HCQ4M92cEcN2QAoD63bJfxcjUYdshbpq1Vo+VGlpDn0VcKPKqPdcPQZlZ/USagusWE/t0jfubXBa8WVMBBo9bf573Z1uEWlFSSEYFd8+zItB5FeMn1GENIjaoqOsGLS/ZwD66K6UW7AGq3KrW5d1HDGvSAokmynDp6pdssexEHnHwDKCQv1zJgVMGK0SV9Ofh7zlQr41stTsA42uYZ+6EcPRBwyXHAXEOH9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Broc2zX4YPb19T5hgZQWeLBttv0xkntVLNk8XVav2Wc=;
 b=YipaZ9n2bPa9p9NY15tbFziJnltNA6m5VobVUM/0TfobswnRpQnRR4CQ6QMz2GC25C8fMDoaEiJoHhK34uobfT4+dYplHt7EUeStbgZVPebX5qBdTESglSnAWXa3btiSehya6Oui0V7h9ep46ZEIqRp4jbhb24P6K/3mUbGSMa4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 03:24:27 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 03:24:27 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.4
Thread-Topic: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.4
Thread-Index: AQHZmRaUNtaJhR75PkqUcaMgG7jRzK+APvlc
Date: Thu, 8 Jun 2023 03:24:27 +0000
Message-ID: <CY5PR12MB636948B37CB9485CAC76EEBFC150A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230607080230.3867810-1-Tim.Huang@amd.com>
 <20230607080230.3867810-3-Tim.Huang@amd.com>
In-Reply-To: <20230607080230.3867810-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-08T03:24:25.817Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DS0PR12MB9039:EE_
x-ms-office365-filtering-correlation-id: eb059d4d-f3ca-4687-16b9-08db67cfdd8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWvmODVtl/XC6QpW/UVUjCd7qk2xWd9Zu+Q/T0V9ofCa3sJbVy9+/Ly9ssJU2s5QW6niMeNn6m4MyEP25ULI/IrXnjNyMN85WFl+9cSfasZ3jQ8WuCk+s6zGZYLcdz7KMGJ5J8kuTEYhMp6fUY176pWjuGr1YBO+WZQ9EyAGdh078m/xML0nOYyRSiqW42P1UoI6+ZWH2rZpNqb0nMkEjYKDUlKYN4X3sqolRtpltwPR64hbke03H1SouPmJXc23oDcdhnqxUj54HMFgYJ7Z6Va0vtr0k+TZn5nBOcoI5su+BsEvnb3KPjwE27f124laMcKSRsMzoD/04UfFjYQi89t0FQjrTHsZQSAve41LbQ27m5hNdTP/OxtzcoObiO6rzXdNp+hovnCJ6SD9uRs7t940deQx6wPVI609XyBV8rKaZlyewZNnjlTAqw59in8g8yUIarq9V4YMat8o7wgPDyJfO092p/1eMiB7uHK3a6xZkmj2eJPrtFw78Lb4U5OANNf8eTRnzc71dOFEU2M6Bu/r3DECpLZc6u6cQ15VPO4Pz5mbCAM37DhhCjOQqrHzFQH0zdUllwADUh+3lDzK5VZn0RwVVMrrE3XXgPYp5j60zMbUX//XqC3pUQtRtRws
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(8676002)(8936002)(54906003)(7696005)(110136005)(19627405001)(478600001)(55016003)(52536014)(5660300002)(41300700001)(316002)(26005)(186003)(76116006)(6506007)(64756008)(71200400001)(66556008)(91956017)(66946007)(66446008)(53546011)(9686003)(66476007)(4326008)(83380400001)(2906002)(38100700002)(122000001)(38070700005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OBRGsf5LUy9qlHJPHcIbpbwC5YqV1MxkRiSaDsrnBb4lX3pOAA9PDUCm2iKk?=
 =?us-ascii?Q?MIQxACbA+Z6v1UxA6z3tTm4Q88ZEJA9f7ap0qWQsCWsyMqkelq5JCfu/eoAA?=
 =?us-ascii?Q?Cdq0vhBAmVbE5aowpg8tbFnVrhf0itoD/7A77jnSLSB/md8X68VyFRCQEwpL?=
 =?us-ascii?Q?TYQgZISlntzfZf7fQCCo0J21MKI61b1K5y6/iXdDp/yK+aZPdWGItWJFeXZe?=
 =?us-ascii?Q?0XEfc//4HMe+o7LNR37uKVaBOf0AI8chWyRKkNRttpNu3gONsj56nH1UhtJD?=
 =?us-ascii?Q?5XHmpaZHw1n/oW74mN2GqOSyNk/c4//4yTI+05A/sTXadI1x8DZlrbsJV8Ao?=
 =?us-ascii?Q?vaLKKu4QaolcxXQQZ86PTw7OkZdxsKP7RGBKimWOLDmx8hCQJt1Pso2FesmJ?=
 =?us-ascii?Q?XIIX4of9yEPIFtQYgP/hTWfnN23VLwH43ujmhKo7gpJSreFZ4ejRHNQ8aDQw?=
 =?us-ascii?Q?YYq4rktDoB3WhgUiPqcRseMx2b1M4AQRaqWd29sKCqA9iYI6GyN4syOUrYxp?=
 =?us-ascii?Q?ksoR60AZ2Yeo0yKRVUDtMSYWYVFKvuMPUODpwS0WSfHQRcK46fxkqLbtE5UD?=
 =?us-ascii?Q?mB4Ab4WrHqfh/v2O2sGa16E6fYcqrMUXwygxiqT4+nSDSn7u8it4DskZ/KpM?=
 =?us-ascii?Q?ikqzCS90qiNOtG5iQOI5ZSm3wIb8D65jNXaB1nfcHvQIIFf95trrVoCRxNpr?=
 =?us-ascii?Q?68E97LkOkRZHospk3+re3lCxTJR/v64zZTFrfHKw7gKqspiyOscmmTnTT8Wo?=
 =?us-ascii?Q?80OP7jcnYyNRVgPNL+a3yRwmSTlPdqRCC/yXrXKD8Kc4wzCDef/cJBj/xMgR?=
 =?us-ascii?Q?rHX98po99g3VtYoRn4oO7mp6tmmwZiJ0cRlE6QWOtfNG3JGgbL+DBbMWmWf9?=
 =?us-ascii?Q?9FK3Q9B/zY9rYg99kjJ6b1YiWYlFjehDKOdJputMsbPmqx8G289k7BTWV4MG?=
 =?us-ascii?Q?A4tlkq6WpLluS/Gzaua2mPZ/8khKyYOEMpqzR/SxQgPUMf+6s2aBwU9lU4oO?=
 =?us-ascii?Q?x9LoRuw16L0zZxO6k6FZ5aT507f4LveRDzH4MhEohxB3f5KVk+weEkWqj0dA?=
 =?us-ascii?Q?RHR37dVmtxB3Os04Xk8YCGB0McBA73AhT6E8cKlahZPMqFzf81NQVbLiDGKB?=
 =?us-ascii?Q?34MrctWgBMeql+55sjVAgIyP76mJVSr2uDcvSZ87ql2us4NN0F9UzrO7+bwy?=
 =?us-ascii?Q?CIOH5O0cU0yr9Yw3eN078rTRo28VbHC4Ap3KIJvrNxp4TL9Fm5OlusNM1qkS?=
 =?us-ascii?Q?06uZX0hGkUVB1Flt+S4LTj2nH4uVmGegwPLSjCdvHlAuJVp7SJVVIP3Udv1I?=
 =?us-ascii?Q?3V1Mz3geK3oz81F2sZvWzWpngLYnjcuhlJblJ+rdUOsEeertdtV+/HcUKOKn?=
 =?us-ascii?Q?Go6zC1tJHcVHSKTUDh/EuutjjNf6Vw5E2hBCGLNtyzQOObA14Dt9h04Uqauw?=
 =?us-ascii?Q?fqSWF3dgBJT0/soLo9K3aaw1nd4P04PmGGa0AxxBV3qLANtnkNM4Io5owcRH?=
 =?us-ascii?Q?RxNsYv9J03IXpZoJLWI80ijs3L3h9/m6juYDgnP2m+Vo/phfydazSI4KWnxW?=
 =?us-ascii?Q?JxHfV8whl7OFyEzKmDI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB636948B37CB9485CAC76EEBFC150ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb059d4d-f3ca-4687-16b9-08db67cfdd8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:24:27.5476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYWSfBOrCUykAeWsY9Ryz93ZI2j9HhCKnspqmECqpdQyOSzplqT6ILVATjFL/ury
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB636948B37CB9485CAC76EEBFC150ACY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>



________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Wednesday, June 7, 2023 4:02 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Guo, Shikai <Shikai.Guo@amd.c=
om>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for SMU=
 v13.0.4

This patch enables following UMD stable Pstates profile
levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 315a6d8bde2e..ef37dda9908f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -54,6 +54,10 @@

 #define FEATURE_MASK(feature) (1ULL << feature)

+#define SMU_13_0_4_UMD_PSTATE_GFXCLK                   938
+#define SMU_13_0_4_UMD_PSTATE_SOCCLK                   938
+#define SMU_13_0_4_UMD_PSTATE_FCLK                     1875
+
 #define SMC_DPM_FEATURE ( \
         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
         FEATURE_MASK(FEATURE_VCN_DPM_BIT)        | \
@@ -908,6 +912,50 @@ static int smu_v13_0_4_force_clk_levels(struct smu_con=
text *smu,
         return ret;
 }

+static int smu_v13_0_4_get_dpm_profile_freq(struct smu_context *smu,
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
+               clk_limit =3D SMU_13_0_4_UMD_PSTATE_GFXCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
+                       smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_SOCCLK:
+               clk_limit =3D SMU_13_0_4_UMD_PSTATE_SOCCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SOCCLK, =
NULL, &clk_limit);
+               break;
+       case SMU_FCLK:
+               clk_limit =3D SMU_13_0_4_UMD_PSTATE_FCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK=
)
+                       smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_VCLK:
+               smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk=
_limit);
+               break;
+       case SMU_DCLK:
+               smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk=
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
 static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
                                              enum amd_dpm_forced_level lev=
el)
 {
@@ -955,7 +1003,11 @@ static int smu_v13_0_4_set_performance_level(struct s=
mu_context *smu,
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-               /* Temporarily do nothing since the optimal clocks haven't =
been provided yet */
+               smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SCLK, &scl=
k_min, &sclk_max);
+               smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_FCLK, &fcl=
k_min, &fclk_max);
+               smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &s=
occlk_min, &socclk_max);
+               smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_VCLK, &vcl=
k_min, &vclk_max);
+               smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_DCLK, &dcl=
k_min, &dclk_max);
                 break;
         case AMD_DPM_FORCED_LEVEL_MANUAL:
         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
--
2.34.1


--_000_CY5PR12MB636948B37CB9485CAC76EEBFC150ACY5PR12MB6369namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 Conten=
tPasted1">
Reviewed-by:&nbsp;Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div class=3D"WordSection1">
<p class=3D"MsoAutoSig"><br>
</p>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 7, 2023 4:02 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;; Guo,=
 Shikai &lt;Shikai.Guo@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels =
for SMU v13.0.4</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch enables following UMD stable Pstates pr=
ofile<br>
levels for power_dpm_force_performance_level interface.<br>
<br>
- profile_peak<br>
- profile_min_mclk<br>
- profile_min_sclk<br>
- profile_standard<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c&nbsp; | 54 +++++++++++++=
+++++-<br>
&nbsp;1 file changed, 53 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
index 315a6d8bde2e..ef37dda9908f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
@@ -54,6 +54,10 @@<br>
&nbsp;<br>
&nbsp;#define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&nbsp;<br>
+#define SMU_13_0_4_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 938<=
br>
+#define SMU_13_0_4_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 938<=
br>
+#define SMU_13_0_4_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 1875<br>
+<br>
&nbsp;#define SMC_DPM_FEATURE ( \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_CCLK_=
DPM_BIT) | \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_VCN_D=
PM_BIT)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | \<br>
@@ -908,6 +912,50 @@ static int smu_v13_0_4_force_clk_levels(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu_v13_0_4_get_dpm_profile_freq(struct smu_context *smu,<br>
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
bsp;&nbsp; clk_limit =3D SMU_13_0_4_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_get_=
dpm_ultimate_freq(smu, SMU_SCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_get_=
dpm_ultimate_freq(smu, SMU_SCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D SMU_13_0_4_UMD_PSTATE_SOCCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_get_=
dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D SMU_13_0_4_UMD_PSTATE_FCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_get_=
dpm_ultimate_freq(smu, SMU_FCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_get_=
dpm_ultimate_freq(smu, SMU_FCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;clk_=
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
&nbsp;static int smu_v13_0_4_set_performance_level(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level lev=
el)<br>
&nbsp;{<br>
@@ -955,7 +1003,11 @@ static int smu_v13_0_4_set_performance_level(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_SCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_MCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_PEAK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Temporarily do nothing since the optimal clocks haven't been =
provided yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SCLK, &amp;sclk=
_min, &amp;sclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_FCLK, &amp;fclk=
_min, &amp;fclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &amp;so=
cclk_min, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_VCLK, &amp;vclk=
_min, &amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_DCLK, &amp;dclk=
_min, &amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
MANUAL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_EXIT:<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB636948B37CB9485CAC76EEBFC150ACY5PR12MB6369namp_--
