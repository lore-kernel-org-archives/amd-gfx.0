Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822DEC77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 03:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B802710E07E;
	Mon, 12 Jun 2023 03:12:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE5610E14C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 03:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQefXSUAmHCqxByYnvmfICMcbFk5dEr4RZq1L57dwlmBmZdzpfH9Zoj7VPnQp+Ixpns3zEJV47Z2saiGIET27BMxLYERNdHXKRss0f89I+djoEsFOl/fhIowoiV4fcTocy4KG9J1RtNr1v3D/vgctpvjgqyAGAlFZf2KYMcqfF0Zt8WATHe+vlPvVcIw9yzdPyytWZWA8ouxt0zDGGM94UdhGHRO0HeDAL6HkgC2KJTnnFysVtFtH8czAdl+mOwle6UuzAMijZNN4EFOWM4f3iEnTHuoJZjiGKnz8EMk72hyu9XfVFRswiu/obixQOC6o7CvDkstOITceFBXErpDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6bBIiEnr4u2xbPLOqs/fGFesdTIkaFHTVC8V1iU9sI=;
 b=Vh6dCDISB08G70tvx1689Aaduyty2ztkOfjD3B+2LlbaDw0uBClLiT7wMNl6rqTvpoxYm4KwZBfYBia66+lhqq0GMf8rsOShu/euNVuvJJKtRS8ezc4T/9ESFoBKPrPgulYOmckFVneymu9QHmxLG44hEM6mFubL+/wLQqO2x2YdC8O6FqOj7cFTHvno0O3W+gIv3zfGBywK76jw/qjQEOLaGUu7YFianL3hy6dp/h6sTzpJLJ213+ffIt6aK+intUzhTYp+9E3uYkHAce6fjDLAdjCrQy8dYsEExYfTDu7aS+l3jQ+f+yOTor/yIWvN9/QjALkwRN0hddF/ZPyyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6bBIiEnr4u2xbPLOqs/fGFesdTIkaFHTVC8V1iU9sI=;
 b=ocUOR00iq5Qmwo0r1abMdRM4ePSIl46YLFkCJ/gq1kZQFwFWSIrcxwjkV8Q2WNbsjFIUndKUgg/E0oAaSJjYqW6edu3mZgW7TdH9qsr3h7TwWkkDJHwhvoao0g/ZVE/WhzWUluH2ohUrJ9VcGqdWyigPRjnjMSNj7zX/YUJlZas=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 03:12:35 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a%5]) with mapi id 15.20.6455.034; Mon, 12 Jun 2023
 03:12:35 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.5
Thread-Topic: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for
 SMU v13.0.5
Thread-Index: AQHZmr+HMncr7wI94kGisKQskyH0d6+GgbT9
Date: Mon, 12 Jun 2023 03:12:35 +0000
Message-ID: <CY5PR12MB6369E4E59160C7B3BBE252EFC154A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230609104427.636097-1-Tim.Huang@amd.com>
 <20230609104427.636097-3-Tim.Huang@amd.com>
In-Reply-To: <20230609104427.636097-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T03:12:34.155Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MN2PR12MB4112:EE_
x-ms-office365-filtering-correlation-id: 37fd37ce-9002-4664-c503-08db6af2def3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3XvvYkPj2szG611Nnk364lUrIl0Dd/apZTaqVi3Gxbs22qsBNjdb+8AY97JF0h0QSIcusPH2UB68YJvigZwQMI+1TD5be9+f+EnRQG2SibmI4JwU1/RUhlX0cpR3mr3s5s3Undafx/Id66ksgLZh+VsL7dltzn7w1G/htznqO8MmbF2thLkmGFJ5nz+vMJxSTzKo0Mv/cRMBLlo3RWnIyRZgQaPhyNZA5UNz+W/FkVuGZ2hy6cQpciCRZ4r37+/hkViJxeMtrkps9zJTlp/qpzB694AyJ001qXtNeM8GJPPoOtexp9tVh5CSqhOAIVWS21ufYAY36456iAZ9+YZi4iHkt5hZGQcATS4GMTBbR9gqnRZ+O210K4gVZRNcBaXz37Fx9WmTptEr1a3mKSVCQyXLBlz08D8T2DLGFTiZrE4+bMQNapSei9tZR1wvqmIIdkd2wEGf7IhtHw3MVte+pzyIASBZ8qcSkdgH5Jsx34uSGgK96sPthKFvO/nLHbQBcn0vXH4UUly8scxzyENF6fEgzNcW95ZeLXagiGZCJweX3hJnAMXuCdQEU0Tuba/JcUx2VTCR0NRUcAVDNvqvJlpgB9sZ/nUWfNScBqyZ4urF9n12AlHpb814CbVgE9eI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(41300700001)(19627405001)(71200400001)(8936002)(8676002)(5660300002)(52536014)(54906003)(64756008)(66476007)(91956017)(76116006)(66556008)(316002)(4326008)(66946007)(66446008)(110136005)(478600001)(2906002)(38100700002)(7696005)(55016003)(83380400001)(6506007)(33656002)(26005)(9686003)(186003)(38070700005)(122000001)(53546011)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j4RyTKanutBpq4JI3tLI5hGmj/Fe4k38s2ixDIkMq9IK++ARmsWul3HyNJb6?=
 =?us-ascii?Q?bxIbNXLLoBg0ht0oaIfmgMZI+0JItriLbOWfUsMcCxoraItP0RwI3Tg1hyX4?=
 =?us-ascii?Q?7XRLKetkRL4zTiambRQlfkukdmQIcbEudj0nSVC92TqW8u3h97nBqTZi+DkX?=
 =?us-ascii?Q?ElLsGv2PH46FZ8hPhzEWdV1i82v5sSWpnv0mxaggGK/ZdT4Tl2/2fYtevxYm?=
 =?us-ascii?Q?zXHijagXxGrH7Km9+V49CpVd1zprWMJqAUXN6UJZsQ6bznCA/FOWVC/ergbW?=
 =?us-ascii?Q?/Oid6IiZl7geSXyPOlu95ekQ7etJijhmFPcsPV/mCpsrEm5fJWaX/y2pQX+1?=
 =?us-ascii?Q?sL0KoCuRdn3onpIXdT8OFs5jS6FlwnS1lZRDxSW+s9b9JIQMYWjVugsGNAqR?=
 =?us-ascii?Q?hZ2mIjDlGJrWjngoTSRRBQgCTe5ZzG3VjA3HRZbbdamPeDv2FCijOOtuYbpy?=
 =?us-ascii?Q?o1AOmanJkBJLY5XBxo9OKKo7b3dH2nmgETwuPXsWGrenWFBDIH18zrGvW0e3?=
 =?us-ascii?Q?QJ7Cirq11uM98VLTOGWEiSKbOt7YURHW+V7O/gyi9Qyz1KYHmlCUaYZEUC0K?=
 =?us-ascii?Q?mY4iVuTQog54q3+m7Nr3geZBJK9heH5t8lNTVVrbJ0XywFBbZR4OCSQyw42j?=
 =?us-ascii?Q?KYBbBjEBXB37qXuRG8s7Tyaio7GsdpQqtMMpz55ATf5BGjni4QA5lu/vL/9P?=
 =?us-ascii?Q?3CT3147NfziscuvHG5w83Bi/SpOdOpe+LaH0vLf4mTRMNXg4n5N55nB+3NTm?=
 =?us-ascii?Q?nP/8anMZxteVUoHt5/69MNH7cptjZreIqdQ3j+WHQ8OJerSj3/ReIdbG9XbM?=
 =?us-ascii?Q?JSofOndX4DhIIdLECOH6e7Df02Hy7xrmSeMCPivSnPldegARVNY7ZCggN1CQ?=
 =?us-ascii?Q?+1x2yysqc8fq9JAUrikWC40g58EGmsmzZpJcGHQpaCpn6EHDeDHgvxXAmSKr?=
 =?us-ascii?Q?kqQMd0AMxafmvQGnfO0G+k3J+HgcZvwsjPjCtAxJS9mTGhI0eb/DtnCmZc8b?=
 =?us-ascii?Q?Geg1PdAm1rn9mKypumCmX0V+oXW22pXHnM6fAEdwVh7dMozzR67otXsIkYVX?=
 =?us-ascii?Q?iXAZElqZX9zsYBmoM3a/uwuGgtsx08bUT92O97feiVyDW59sI1XlbJ0By3f1?=
 =?us-ascii?Q?rTNL9GD14fkau2S+bEBnQI7w6DAElzWn6aMRLwHGHIE6jvxNNa1qz16SblH3?=
 =?us-ascii?Q?jyXbHLc4MIMY0unVRQFQJ4ENY2Oc/cN4P7Hx6Ddg8oUc1xMUzIS/+FtFJxPt?=
 =?us-ascii?Q?blB/gCO2CJXjmCujs5NzF59xKs+Ps15Y3irb7m+HiiNPkZqdK2F55cHT92Wm?=
 =?us-ascii?Q?oYcoFtwp+e0xKkiAGZQZOsb22QYyn/rARIG5Fz+547CN/M/1sIXDfQQ9NM74?=
 =?us-ascii?Q?J4Kkz/lrEERtKfeMcMC4iY72IPPjLdwwXE3ulA/e1W7q8rTNeGtC/wAFdj1X?=
 =?us-ascii?Q?a9PIvByXlOBNDOR7teC31rIjNsMtAWk0MjTR+ucTna0kdoXb9jpFChYQbll6?=
 =?us-ascii?Q?D/hYmkrPRqbkl/1scSwemHFL3XqDP7Ol3HigPOJaM5DPanbCxNKdI8wftatW?=
 =?us-ascii?Q?Xq7q40hVYQgYpIUEavQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369E4E59160C7B3BBE252EFC154ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fd37ce-9002-4664-c503-08db6af2def3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 03:12:35.7902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNJNbTTNW8wWwK2kcBOKOqNQrvReyhx5K7w1xtGwwKPwgSSBlK7AyrQ6czTYcemu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369E4E59160C7B3BBE252EFC154ACY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


Best Regards,

Yifan



________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, June 9, 2023 6:44 PM
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


--_000_CY5PR12MB6369E4E59160C7B3BBE252EFC154ACY5PR12MB6369namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div class=3D"WordSection1">
<p class=3D"MsoAutoSig">Best Regards,</p>
<p class=3D"MsoAutoSig">Yifan</p>
<p class=3D"MsoAutoSig"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Friday, June 9, 2023 6:44 PM<br>
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

--_000_CY5PR12MB6369E4E59160C7B3BBE252EFC154ACY5PR12MB6369namp_--
