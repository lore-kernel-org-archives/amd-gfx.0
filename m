Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A33C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 07:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9AA10E060;
	Thu,  8 Jun 2023 07:51:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20C310E038
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 07:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU61+4jSRv5H0k5cYY5RFZY/ZdaOZN4NpOiC1qPD7Q5Xi/zkhNlfnkhU9UYuDW9zdWa9FnCZlEHDI5A2hLy5Aqf1XAICEqVFPbLft3m78b4fmR7EMO0oHdIUXxrr8rDuNh3g4C5eeq7XLpNH936ik8II5b5DyLmuZdGjsXXwCGosYSsIRsJ2sXml3gBRQGLfDiAklkDutUfjpW2JRSlcztjPagzE3WADckuXOw7sFyOwFTEmGNMXfCLyJoA1XK1LgA901fkHJTMZEEMOHefZjaChS+a3iKLegxKx8X1DrCZP/uG9xhKnb2giVAZr3qIWL8nEEaNsOpiFm3krwO9ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBiXdBd8ACga4qLutrrBDyaFBqDjYYwZtxsXN4jvwfA=;
 b=TdVZeec5EljeTCM6guiS41MpxQ/EBqeCO2O275QUfq6v6Z7/gw6DYogetvbU4SmYnaYVytUDvO7719UH52rcrh8Jv1EXNg9+10MiLOCmy6KWUJIzaIfYJeWDgVb8Bp8zH0Tavk4UDobgrd8pXjRpDmC28DJ/npTYlieKjTWlGRAGZ5WYTDUQ3sdpsvG+rzGegdPiNGQtM//wVfEmL8b7whbc0PZOLv5eqt74fQI0uV958Vsv6qhi+7arK+uRo11EHddQpnMuKCFwZG/mQfEM4kCf6AKUkOtnHhu6siNiBEC1ydsMFV7xnEdzGnjtInCuAydHI9SxGU6ORPIzLGTydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBiXdBd8ACga4qLutrrBDyaFBqDjYYwZtxsXN4jvwfA=;
 b=yWQ3tQWtWdoB/3lsiXa02WRGzpPCgzrD9pi44dSMdS+pcuErsxiP6DXXv1lxH4fDUr3B6rUSDYCAJXgn5ApWDZjDZCTDt0OdKmuFAp9jwveEGi30m+c7Hkj8lNfKwTPStXsGPS0azGeny8KWKlK+CgStWt4imOcNuV/O/sMeqGc=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 07:51:29 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:51:29 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Topic: [PATCH v2] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Index: AQHZmblQB+mX26GB5EClivTlCNDNB6+AhQOc
Date: Thu, 8 Jun 2023 07:51:29 +0000
Message-ID: <BY5PR12MB3873092BDCEB9EB64CB7EC81F650A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230608032747.1782194-1-shikai.guo@amd.com>
In-Reply-To: <20230608032747.1782194-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-08T07:51:27.456Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SJ0PR12MB6830:EE_
x-ms-office365-filtering-correlation-id: 0ea7b935-1090-4538-0238-08db67f52b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bas6wygSvvy7Ei9wHqrEZetFrgRkpozWVS/+4zHLmnB3G5akZZujgC68vzkl8BIOSyGTbxKvGsSSbYyVweDtS0GLdAWfA02RC60L2O9j54zEh3kwwlmTJZ9R2n9Bier2eAfo6jjqMoAFYdC2PtWNULF/pEDc12YPZoQW1NFU8C4BvkAT1joXfSIfWVNqmoGI8Bz+2Q3uiiOazKkUQsiK7pcH5tPIO2Ht6gsNvp3SM0BREz71dIbBTTtYlxleLtoghoLl3myjV6LvGKgdOrknlhEbpKt1Nm+FuGK4n38tkbwhc9q+wYQYjdcEEjnpjfpx54vUGDFOoLs1EQRVrGsYyb+YgUgzMBMUY8FFQDSjOPkkVr/TDcrry+ObQiXKRjFwD8miwEHj0+owK76YLtepLYrLM1lEfXFzR2d9AtBoePdu1eaA3FOwTWdFsDyOIXm7YpfH9omopwX1hWCmlsYrngtMiTuci63cKgc+/J0aJtwuqcGN3D3Uh9Fg4bOl/WNppO3NfGxM1pQo22IfvBDBnDHgjwp8kFXVUjEvhrcmqXu38Wt+0uyITqZw7XLvPQ2dynZLBVXzAx9huOpG2VHiOXONzPFxzDIMXPhsoY0AH/cMn9HPBPwdUKKkzzN6z+F2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(19627405001)(6506007)(53546011)(9686003)(26005)(52536014)(83380400001)(122000001)(86362001)(33656002)(186003)(316002)(55016003)(2906002)(5660300002)(8676002)(38070700005)(8936002)(41300700001)(38100700002)(91956017)(76116006)(66446008)(110136005)(66556008)(66476007)(66946007)(4326008)(54906003)(64756008)(478600001)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cTdp6etHmt0s284GKCxJ3LbpJT56WB5im9gYusim/5Qywc9oe+B5WBa1k7?=
 =?iso-8859-1?Q?W4i3L/qrwuiiRezN4olX0Zmo2xLR+ADjtLZVvw2yqYpXrMsUocjf9JBOhV?=
 =?iso-8859-1?Q?bQHueCOxuNHX8VCdAXqXAX4/twTNGO3I2jfpdG+JYXNRHXRZvcneTvIuHb?=
 =?iso-8859-1?Q?Tqw1YKHULxph25Kpl2Zf/csdIngkFiVhC2M/OLad+wa91LZmF2tY+OorUS?=
 =?iso-8859-1?Q?A9xn1iuxYQx8+DLTDBDJpbraiPMtSzJtNNDSPvSgqb3mhwzBwnJeMbcvCP?=
 =?iso-8859-1?Q?QX3cDdcf8DaGnm6/UhddwYiKrRGTeCl+Kjz0AhPhS65AdhyaoOyeFRUfHd?=
 =?iso-8859-1?Q?rZeBMhmdSE4OSBvf4P8KEsjprk+auxThQTuHUa9QdL5O5QCPo6WhTs8wLa?=
 =?iso-8859-1?Q?8qAeZjZTENSV/Z6SV7iQ8yL4k0rMKbw/anEaEYWMxR1fbVgH0qTWS5Xu8t?=
 =?iso-8859-1?Q?02UlYkmb7nztvV4Hdh32EetdTpCqJljpEYCKOEf8DOOJ1yvWfh3Vf/8Qeb?=
 =?iso-8859-1?Q?MiSdp6KnrnBrC5rO5jNC5qDNGc8zGVe0RBOOK64OXqV3rVg2JD/Nx4Xlv/?=
 =?iso-8859-1?Q?KwnFxQS1R26+H+GGOnAxAvCjIUezQdAJfqj9TNU+sPEo99p9SbY3G5w1JI?=
 =?iso-8859-1?Q?g/hzRlLVYs3baII6HVD64BoIr7s1VyVt428p5nnu5PZt9USdLL8406AbJj?=
 =?iso-8859-1?Q?oHvherOt4W2rx8hM+/zrpo2ZDB73BV+QmKU512IZZn3A1YPyEaMrbyN0xg?=
 =?iso-8859-1?Q?94i3zBhfV0znZDRvmFZAXFL1lnQXT6Q3WybcxrNpP9zmOmly86PfgiZCVW?=
 =?iso-8859-1?Q?yw67K4oONHNlu3OA4/kUNoPL+QqJe5IBV1oeUlkGtcRY2E1NDqspdJC28z?=
 =?iso-8859-1?Q?W4Ju3mRONkBCNUkB4xuduv3SLFSRYWxTVaS7Ku/lUStKRWpF04DmWfRFrG?=
 =?iso-8859-1?Q?8HEac1suC5IoQVhMag+gtMzyBtVfnyb1IdvRxW2F6X9HGyTNXM1k+VpsqY?=
 =?iso-8859-1?Q?/eg0P8ZD0oOlLebBIH17h2hameGPvcfjjkysDIr7WCLA/h8OKf3ZNiYQEs?=
 =?iso-8859-1?Q?aYhenxOkj0GowyXkALoqUKqclDcl6sRc44isRm8E8DPNctMRzTCZgFy173?=
 =?iso-8859-1?Q?QY72sZ8dn64VNTaIFFD8nJp8hiy8hrjq9imQtm2d96kpL9rUC5GOVPFYpb?=
 =?iso-8859-1?Q?0CtXLEgWyGj385wznRQMDKuo+St+4JNYaXwCp7rQtiwLWVgOnNnKTU4+nG?=
 =?iso-8859-1?Q?z7w8cag0BFXHmksC90CHhy9vbL2OK5pWaHLTtKgDVuMmhRlUX8rxXZC2Iw?=
 =?iso-8859-1?Q?tF/Z5q1dSkpeoHdqDz8Uxjm9c7V19zd6GEPsydv5IMEyYf+dWhJf1+u9b0?=
 =?iso-8859-1?Q?pBjVDQEVXsll/cv5N/nqVquJbCawkE0BAQw5SLSvISMiOEesgQ3kVV4FzI?=
 =?iso-8859-1?Q?rb3MitHFugiVbUZy9Mb9NTBqlA1ynh1dODn3UlOyePXFl0mf7wokuebXZR?=
 =?iso-8859-1?Q?p0nA/aISXo5IZQK1lyI1miF/bssu1G86wdR8fSBatQL+CKhESfwx5RtjKS?=
 =?iso-8859-1?Q?tBcd5Si7flsr5U+rF6bojw1CGoKkowytpSZvf74GKh+ZrmY8UDfi4lbEPW?=
 =?iso-8859-1?Q?C56LL2KV1XEnA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB3873092BDCEB9EB64CB7EC81F650ABY5PR12MB3873namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea7b935-1090-4538-0238-08db67f52b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:51:29.2939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiWKalb2jXtHYvh9+NHjfEC66vBHwHsWXcAua087a0nrQE8ujBXAPCXDMC2JDSSulPQ820GBeN60+oWQ3I+Kvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB3873092BDCEB9EB64CB7EC81F650ABY5PR12MB3873namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Shikai,

________________________________
From: Guo, Shikai <Shikai.Guo@amd.com>
Sent: Thursday, June 8, 2023 11:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hua=
ng, Tim <Tim.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>=
; Guo, Shikai <Shikai.Guo@amd.com>
Subject: [PATCH v2] drm/amd/pm: enable more Pstates profile levels for yell=
ow_carp

This patch enables following UMD stable Pstates profile levels for power_dp=
m_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 94 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  5 +-
 2 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..5c968ab2ea8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                                         uint32_t max)
 {
         enum smu_message_type msg_set_min, msg_set_max;
+       uint32_t min_clk =3D min;
+       uint32_t max_clk =3D max;
+
         int ret =3D 0;

         if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
ruct smu_context *smu,
                 return -EINVAL;
         }

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL=
);
+       if (clk_type =3D=3D SMU_VCLK) {
+               min_clk =3D min << SMU_13_VCLK_SHIFT;
+               max_clk =3D max << SMU_13_VCLK_SHIFT;
+       }
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, =
NULL);
+
         if (ret)
                 goto out;

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL=
);
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, =
NULL);
         if (ret)
                 goto out;

@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_c=
ontext *smu,
         return ret;
 }

+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,
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
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_GFXCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_SOCCLK:
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_SOCCLK;
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, =
NULL, &clk_limit);
+               break;
+       case SMU_FCLK:
+               clk_limit =3D YELLOW_CARP_UMD_PSTATE_FCLK;

This is shared by other APU ASICs, like the SMU v13.0.8. We should need to =
apply the different profiling standard clocks for sclk/fclk/socclk accordin=
g to
the IP version checking.  Thanks.

Tim


+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK=
)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_VCLK:
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk=
_limit);
+               break;
+       case SMU_DCLK:
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk=
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
 static int yellow_carp_set_performance_level(struct smu_context *smu,
                                                 enum amd_dpm_forced_level =
level)
 {
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,
         uint32_t sclk_min =3D 0, sclk_max =3D 0;
         uint32_t fclk_min =3D 0, fclk_max =3D 0;
         uint32_t socclk_min =3D 0, socclk_max =3D 0;
+       uint32_t vclk_min =3D 0, vclk_max =3D 0;
+       uint32_t dclk_min =3D 0, dclk_max =3D 0;
+
         int ret =3D 0;

         switch (level) {
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sc=
lk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fc=
lk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &=
socclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vcl=
k_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dcl=
k_max);
                 sclk_min =3D sclk_max;
                 fclk_min =3D fclk_max;
                 socclk_min =3D socclk_max;
+               vclk_min =3D vclk_max;
+               dclk_min =3D dclk_max;
                 break;
         case AMD_DPM_FORCED_LEVEL_LOW:
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min=
, NULL);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min=
, NULL);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk=
_min, NULL);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min,=
 NULL);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min,=
 NULL);
                 sclk_max =3D sclk_min;
                 fclk_max =3D fclk_min;
                 socclk_max =3D socclk_min;
+               vclk_max =3D vclk_min;
+               dclk_max =3D dclk_min;
                 break;
         case AMD_DPM_FORCED_LEVEL_AUTO:
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min=
, &sclk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min=
, &fclk_max);
                 yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk=
_min, &socclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min,=
 &vclk_max);
+               yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min,=
 &dclk_max);
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-               /* Temporarily do nothing since the optimal clocks haven't =
been provided yet */
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &scl=
k_min, &sclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &fcl=
k_min, &fclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &s=
occlk_min, &socclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &vcl=
k_min, &vclk_max);
+               yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &dcl=
k_min, &dclk_max);
                 break;
         case AMD_DPM_FORCED_LEVEL_MANUAL:
         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct =
smu_context *smu,
                         return ret;
         }

+       if (vclk_min && vclk_max) {
+               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
+                                                             SMU_VCLK,
+                                                             vclk_min,
+                                                             vclk_max);
+               if (ret)
+                       return ret;
+       }
+
+       if (dclk_min && dclk_max) {
+               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
+                                                             SMU_DCLK,
+                                                             dclk_min,
+                                                             dclk_max);
+               if (ret)
+                       return ret;
+       }
+
         return ret;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
index a9205a8ea3ad..5ad4058b5e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,9 @@
 #define __YELLOW_CARP_PPT_H__

 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
+
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK       700
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK          678
+#define YELLOW_CARP_UMD_PSTATE_FCLK                    1800

 #endif
--
2.25.1


--_000_BY5PR12MB3873092BDCEB9EB64CB7EC81F650ABY5PR12MB3873namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Shikai,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> Guo, Shikai &lt;=
Shikai.Guo@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 8, 2023 11:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Liu, Aaron &lt;Aaron.L=
iu@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Guo, Shikai &lt;Shikai.Guo@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: enable more Pstates profile levels f=
or yellow_carp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">This patch enables following UMD st=
able Pstates profile levels for power_dpm_force_performance_level interface=
.<br>
<br>
- profile_peak<br>
- profile_min_mclk<br>
- profile_min_sclk<br>
- profile_standard<br>
<br>
Signed-off-by: shikaguo &lt;shikai.guo@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; | 94 +++++++++++++=
+++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h&nbsp; |&nbsp; 5 +-<br>
&nbsp;2 files changed, 95 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index a92da336ecec..5c968ab2ea8d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
ct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_message_type msg_=
set_min, msg_set_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk =3D min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_clk =3D max;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!yellow_carp_clk_dpm_i=
s_enabled(smu, clk_type))<br>
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
ruct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_min, min, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_type =3D=3D SMU_VCLK) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_clk =3D min &lt;&lt; SMU_13_VCLK_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_clk =3D max &lt;&lt; SMU_13_VCLK_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_min, min_clk, NULL);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_max, max, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, msg_set_max, max_clk, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,<br>
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
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_SOCCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D YELLOW_CARP_UMD_PSTATE_FCLK;</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">This is shared by other APU ASICs, =
like the SMU v13.0.8. We should need to apply the different profiling stand=
ard clocks&nbsp;for sclk/fclk/socclk according to</div>
<div class=3D"PlainText elementToProof">the IP version checking.&nbsp; Than=
ks.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">Tim&nbsp;</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_FCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_FCLK, &amp;clk_limit, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;clk_=
limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;clk_=
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
&nbsp;static int yellow_carp_set_performance_level(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dp=
m_forced_level level)<br>
&nbsp;{<br>
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_min =3D 0, s=
clk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fclk_min =3D 0, f=
clk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t socclk_min =3D 0,=
 socclk_max =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vclk_min =3D 0, vclk_max =3D=
 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dclk_min =3D 0, dclk_max =3D=
 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL=
, &amp;sclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL=
, &amp;fclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NU=
LL, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &amp;vclk=
_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &amp;dclk=
_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sclk_min =3D sclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclk_min =3D fclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_min =3D socclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vclk_min =3D vclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dclk_min =3D dclk_max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
LOW:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &amp=
;sclk_min, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &amp=
;fclk_min, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &a=
mp;socclk_min, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &amp;vclk_min, =
NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &amp;dclk_min, =
NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sclk_max =3D sclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclk_max =3D fclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_max =3D socclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vclk_max =3D vclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dclk_max =3D dclk_min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
AUTO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &amp=
;sclk_min, &amp;sclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &amp=
;fclk_min, &amp;fclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &a=
mp;socclk_min, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &amp;vclk_min, =
&amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &amp;dclk_min, =
&amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_STANDARD:<br>
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
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &amp;sclk=
_min, &amp;sclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &amp;fclk=
_min, &amp;fclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &amp;so=
cclk_min, &amp;socclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &amp;vclk=
_min, &amp;vclk_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &amp;dclk=
_min, &amp;dclk_max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
MANUAL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_EXIT:<br>
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vclk_min &amp;&amp; vclk_max) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D yellow_carp_set_soft_freq_limited_range(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_VCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk_min,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk_max);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dclk_min &amp;&amp; dclk_max) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D yellow_carp_set_soft_freq_limited_range(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_DCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk_min,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk_max);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
index a9205a8ea3ad..5ad4058b5e45 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
@@ -24,6 +24,9 @@<br>
&nbsp;#define __YELLOW_CARP_PPT_H__<br>
&nbsp;<br>
&nbsp;extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);<br>
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1100<br>
+<br>
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
700<br>
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 678<br>
+#define YELLOW_CARP_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 1800<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3873092BDCEB9EB64CB7EC81F650ABY5PR12MB3873namp_--
