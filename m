Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C500C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 16:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F2410E0A1;
	Wed,  7 Jun 2023 16:30:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B8310E0A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 16:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzOixI+9tqu9mh6+FLdAnRQf+IFJ+0oDU+NBnAdpeA/WV2yXeZyap2gfMLHDV8A/ekq43wWhSH7D6cixrspYPi4zMuJEzgsofMLsS68mh9HspS4SMHjrDtnCzVFASKmXgAThxLlYtZbpU76DwR2DvuBH9Po2aSppDEKkpBZLPhalO+rSebQ/SMyuult7EJeZmMcpQp20TDQBwhdITZ/RNS6X8qXohtk5qVV2pJ5jmsPvGmzQlg+KhlwAmPiVhOxkSqkw/gCwg1b4/NQSS0svrJtZrWdsWl70PvALcNvT/kCw2nDDIHxLkc7W9T6I3jU+c8x27whmui9v1ZbrxuyL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3vmZrbGH+4JyX13x9uCUM2vTl+N39BFtt/krEnIKP0=;
 b=RvGJtSM2pGI5ZqF2n9f6PDOcTLBUZMlyKkXdxwrJvAAcaCO1WM/3x2L2swR7IwrGILuJh6P5lLNP5Qnr4pT1jHFh9uVdxBsVH5pUgNF4tZBWz//SAfuHis710NINS1ZUVDz2+p6+wwDJYt/47PHcKME4Oppc3UGQc4o5aMrbnEdwgB/FAsmpbMuE0TZ11ijDeOxxbJy+baOoDQZemufp/o/yKMnPF++fckUoF1DLnNRXoE7Vxql9/NRbYc9QDFCH9n8xvDUxtfcrc+Rf+NANHuDCWuv46JC9YrbUab6/iFEIfQyePJ/L5vgodcLCDbvaGal27rjuPP88pN+i7pu4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3vmZrbGH+4JyX13x9uCUM2vTl+N39BFtt/krEnIKP0=;
 b=xhn3D1E9m5vxT2s8QxzXJp9LtLBBfP4Oa3nCGJhFIUE6Me7h4Bbtjh7u5WQE2PlvpIS49WV0s8WX7huzy5DGmtDr8QrYAlHmVdEeaOSbZIuvW0bTmIIMmiJCQos9dGn1HVRmoVx1N96MjTNoz+L86mAy3LOFwTIKnOBp2kKWWiU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:30:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:30:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.4
Thread-Topic: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.4
Thread-Index: AQHZmRaUF+0T6eyAMUaDWRxF63bI069/iGjV
Date: Wed, 7 Jun 2023 16:30:14 +0000
Message-ID: <BL1PR12MB514455840FF2DD91355A3F29F753A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230607080230.3867810-1-Tim.Huang@amd.com>
 <20230607080230.3867810-3-Tim.Huang@amd.com>
In-Reply-To: <20230607080230.3867810-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T16:30:13.719Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: c919c635-44ef-49a0-f05f-08db6774790b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKV3Tf2OaTPJ2aVNfHEADD6iWfsEdnFKrzabNWzZmkA31I9HTdX/uZ7XAFkg53g4ToP2/dFcJfVzcwUfk+GtvuRt7fEvKO3ItzIpjGP3x67k43w9WdDVw/9XnnHDxii7VhbZYnQTT65B9W2HB7LsPwuxuSNcmLzfXMHsxdgS9hTEtOEFWZN+yp18NSYarwIpGCI4perTDTfPubLbjivmyCmG45vIw+JN4ZoCKWUI7PBpN8ablEn+5x6KNmYNkWp1ExJWX9tIP8oVoB5Mxs8lVZiknx4+pKOVVNkSnlsyz2+/Ym3la2fRQdDZ1fmUP8qL8MT3kpSDvIE832RLVNeIq0rhdMZc/OsT/bLStFlD5Y1CUie+Bnf0Dw1H1WbxbXf0kyHjYzpRbCr4urduXLfattOMwk0ErzMxvbO/ze77yBlNBWxvxIhkAmaiMzHzWMibckXpl/GaNSozw/WmEvw+rhKwLfvs08Ism5AuqKgNb1ZXp3rShXlVousafBsSGf+ym29CVrs5LNrqOtCitd6AqthbGZfgHwQ7RkE4/spUXjxIoYzlfKbNFm03QtwS72xPnZ0m/h3laLPx4QbAPdFJ46wMmYYi1D7H9LUT9axF0Eoa9mwMdYE+LGYEyVhI6Fcw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(86362001)(38070700005)(5660300002)(33656002)(83380400001)(8676002)(54906003)(8936002)(110136005)(38100700002)(122000001)(52536014)(55016003)(26005)(316002)(186003)(64756008)(66476007)(66556008)(76116006)(66946007)(4326008)(53546011)(6506007)(9686003)(66446008)(71200400001)(7696005)(2906002)(41300700001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hMJ0gXpSEmobO9gQEfJrMjKwpKw0PUWw9y0/9SSmGmpQYcV68CXJB99POG7N?=
 =?us-ascii?Q?YSpvWTLBC86RYpBzCh6G4Qnl2ux0nO59EAQNx4tiQKrh/x4zltnT53tQMw+E?=
 =?us-ascii?Q?1JEIsoEzd3Da9UjeHUce1UjdFacBWPYePwSdZqxTNo79MCt1As4pg1t0JSSs?=
 =?us-ascii?Q?mv5KyLf8dcL5xCQU2Hf9K7POBcsUb2jczUc5Qg9d10FsSM0ep8lxbseEZt51?=
 =?us-ascii?Q?7F5Mm7U52jpINEBrsLyWW2Ng+1+gj0PtpOjHmJWpu3xKeS+t7Igz3Cp+Z6B1?=
 =?us-ascii?Q?/2Y0uojrz/36j4G9LIc3Ykcy+j5TAhDBfcE3gQ5GCXgi6g5D2CYuzdTzTUym?=
 =?us-ascii?Q?FMy40ln3iQf/Ru9l70HBajnA/iAg1ljT/mqx4yxauHCPj/S65vkxS0b0LZPX?=
 =?us-ascii?Q?LGL3gzoZRpNLFB/8dUomu9kO9u5Jj+dqZWnS9UkqUyFbXydXs5LTULt3cSPL?=
 =?us-ascii?Q?mfwmk3NM5LGh6PdlCpXEbV7OniQaLfwlbxz2epKThjCiMxU59Ff1Y4TZPFqL?=
 =?us-ascii?Q?sfRWg3JnqEgr0sHYNXsTLa86Zelj1nuiSLh7AJr9eCOFfNn+Wopj6ZYz1IFC?=
 =?us-ascii?Q?Govh/T3x5xS+DMO9lq4XtxEfUVFwwa7SlHeGLc788hus01RaTtyma4qWWVGH?=
 =?us-ascii?Q?UcBj6b7caIEv2drvK9d7hf3DTTUZ94TG55UwMBWgunjn+fwrUNG42wPqK072?=
 =?us-ascii?Q?i3ZaIfL9OtDZT+rD4ZfD+DH4VC1rGIGPCHl39MSqNBl/0FmIQbGghHXt5TeY?=
 =?us-ascii?Q?mVsbEL/l0Ot2/GJmbRrkf7T1q+Ewd/MZKggECQARfKqkAJl51ktqTcTtjHZX?=
 =?us-ascii?Q?4nNp3tBoLYekThA6cjcxlh+ejmkF5fUqLojS7ZgIzPhcQLBbmSviH7T+W19K?=
 =?us-ascii?Q?PKhv/B9HkWh1xXJf1RTDwEWBRcdAfTnF62TFLaln4NYgB36syRqSNsMOEvEZ?=
 =?us-ascii?Q?UjiUa+NGYHbO3AfDO4+h3O+3oNOO8mzHmt1lNs2YZcyqncmTOJ5ft/QL8PZh?=
 =?us-ascii?Q?4Lrbz3flxWlpcbWf4Fmziexac93Y+eESjGzt7TX9U55Dy6gK0bBEdLH3vJWn?=
 =?us-ascii?Q?vd/8ez9Te8ZIIO9QYojJfN4TNiiy1ATE74tUZ4JxEJRGj8ZlGMb19VgF3hWZ?=
 =?us-ascii?Q?TovOaJWKeeJ7LSPNwcBUOiHjY9JLkpAReP0aCspHCgu1kRfaUZkDOvSMZQhQ?=
 =?us-ascii?Q?q1fB9qrPHlwP8csVT9rhcfjnBCf/OSHSs7Aamd/NITKv+LAS3AUTkd5WFIi+?=
 =?us-ascii?Q?YkbimtUanBqLv1zurq/9TDxz3iBnE2g3s4ZmimllbRbVi1cF3I/Oaby1W+iv?=
 =?us-ascii?Q?OofmT156tNRwQtqLgeaMMfBX5maPvVU83tCyjRW135uMiWGFrnfVCpoRtRCG?=
 =?us-ascii?Q?6EIHdPTQXKNSMShV+pNU8KxdPVEpEzxtYLD126X7rzIG2kAudajGL4gWMB63?=
 =?us-ascii?Q?C1S0//g5jK/uPLn8NMC0FKcSElaI8QWUjdqmLmU5TMaQ0B2U3BtQIvYnqpBJ?=
 =?us-ascii?Q?xcHBT2qAwj7JSFPIoNQH4zxeiAQ/AFRmK6EAPrUZH3l8YeA78cTr/UjCdyaQ?=
 =?us-ascii?Q?C+MS5h9F70wA83IrJic=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514455840FF2DD91355A3F29F753ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c919c635-44ef-49a0-f05f-08db6774790b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:30:14.7359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxZt70nhYjQFT/clMvmiKwkf66S7MFBDZ1+TZdwD38Gbz/q28e0at+eIo1IvIz+wfzFTtxO3Vo6zpOW5kSGb1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514455840FF2DD91355A3F29F753ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Wednesday, June 7, 2023 4:02 AM
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


--_000_BL1PR12MB514455840FF2DD91355A3F29F753ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
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
<b>Sent:</b> Wednesday, June 7, 2023 4:02 AM<br>
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

--_000_BL1PR12MB514455840FF2DD91355A3F29F753ABL1PR12MB5144namp_--
