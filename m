Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9EBC7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 02:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01A610E0D1;
	Fri,  9 Jun 2023 02:47:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E2A10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 02:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7V93+J4aBch7FpGu08NkyA6V4Mm1EDoKKtQ2WiNAyLGbDZO4mYOvpWGyRYgjCW7HRIOu1/Bz4osPcVTk3BYeYc0+Ilzkt0weIj8Ybw0Agqgym7CR7mVWHaAPMAlGqwvNpDuLcgkI9B4h9FZyhHAO9aqtVhp+ysqj56OINOwKkVQcflVo2BIDR01sfTKZklrzH1kyzRqmcaHXMWkWYqBRcTOnePNYwYMFlAhFJby9Xlkx0jBt2Gi9Jr2gcNAcN5md3L/m3ltacU610kYd8opmX1tmvgJlZbgY1OFQnkyNDuNFjknP4HsFmRC4jg7ZaFSBCLnjqZ3atDSAMKjLo7rKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9Jayogu9//MKbkPSETBe5IrS3n4wUjn7yUeOeYDZDE=;
 b=W/QMIt25D7l44DCxSuWJDzMhWG9CHFvQcL4YW+w8TbmuVKdxdstzCJlkcwf+Ti8/E6wdKmTV3UX74hGsPsw8jZvSxGd5w5rK3EGO+C8E8gWTs1mJ85xAC1PCfNWGuQUhMftdqA4t9UNJV2V7MJaCEGtIuypHpD153m99HCJWQlbmvFAKo1+uPA5PWmWl3eLISZrRER65BqcLteJxyAhZigc+9grLCrnnfImODXpEmPPZiItZYeGQOachJRt7hv10woF+DhbyMiUct7/1Ipl4kWWBmUIhzmjvKsP1DTRgQq2TAwncb5xXsF8tR8hSN00a3SA+dDbXEjo2UjEnTDFbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9Jayogu9//MKbkPSETBe5IrS3n4wUjn7yUeOeYDZDE=;
 b=b+Yo2DwpgHLSbS3yJ08fz1Uc7Kc7VqE1MJPJf+ZjC4r7+csd57COg/WzpVLJ1t2MM89gw1s8IKCl411POMQg8TLaznNcLUrOGfiahSUy7sb5AayfWCYpEZlv6aym76FA/hVSYWCrBlKjK4XZRJCnYRI8eIJJA2o42MR4+QQ4oyE=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 02:47:30 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::1f2b:8491:96c8:26fa%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 02:47:28 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Topic: [PATCH v3] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Thread-Index: AQHZmfPby5/HHIeHa0WLD+X/y1S7RK+BwqiG
Date: Fri, 9 Jun 2023 02:47:28 +0000
Message-ID: <BY5PR12MB3873E69D46FDFBB0C8308CF3F651A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230608102700.1879369-1-shikai.guo@amd.com>
In-Reply-To: <20230608102700.1879369-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-09T02:47:26.890Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DS7PR12MB6214:EE_
x-ms-office365-filtering-correlation-id: 48f66428-b5e8-4ce5-514f-08db6893dd45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: us2/aC0eQk7Syv0LtOKVp8W4tkXDincjv3+vgHOBOn55j4a29PPi+9IOT4yvE+Pm3DjxCLoYVQ58nKljkRaR6U4yAiF0a/2JbFJYXrtn+hyn/oPGbUMz5bFM8LJVksKUROx8Q2fAAfDCrynp8+UMJcw4bGAxm0nnWDdB6AK1bXRl6lIgnmwsTiwnsPcHhXu93Piru+t5ghab5v1MOqzBQrMEy0641U+bndNPeaQavvDOLtwnyrlAiyrWYJ9eTHvpUhWfUJDOd1vN4diMJoimfAwxOWEhBDwsiTtq/4rkfQctjCG5tUbZGceQO3SdCdAOyE9S2GLQ2EoqYlrFZ6m6u7vKd46AoCfLl8MjRGeB/vFDMey+KrgL39jHwO+8i83V5Jz8o/K6bdSTW278+rxkMilOdKGDeJXMv+t13UFVJG11lxvybm2PJJHDWz7lPSyeeGjmUIBYjmpcE63dNr5g2gMSQLYsimdfdZDX0smM+llV32rJdmpk0FEmdDFYwlwsmOA1VO25UVqqY0jxYb08XsOMWMEWwgoYqx8Br2gYLYDjUL4L9cK0paSPkrK0Rn1D0JphZ5hS4fKk9wrlCWPcU4qku7nAR6XqlFjUX8HyzbxDNS2T4pkSlnOQKEZY/CBd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(41300700001)(8676002)(19627405001)(4326008)(66446008)(66556008)(66476007)(76116006)(91956017)(8936002)(66946007)(64756008)(110136005)(5660300002)(316002)(52536014)(54906003)(55016003)(2906002)(38100700002)(122000001)(53546011)(26005)(86362001)(9686003)(186003)(6506007)(71200400001)(478600001)(7696005)(33656002)(83380400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lC0S03q4o1Q9FQQOX99YiWc3ruZdDtF2OqN1wJODuNOSx1K387MhMPKU17?=
 =?iso-8859-1?Q?5sclN8PPqmmA1E3QxQwHyKzPgliL950r2L1zgerZujB8qh/jZvidJ9kjLZ?=
 =?iso-8859-1?Q?uMKtbuZs9OiXS1XJGK30c7UHT+zzfSiqAvCmy/o66+RBLsnfSQsBNw1T4m?=
 =?iso-8859-1?Q?cuHq4ifPqU1lrLeLxnWQe4Vo+qCjxQWN5rnSeRNF8HUL29JUooNXPfgqw0?=
 =?iso-8859-1?Q?3mCElq2LBY7U1JUjNXdys0l4r40t5qDtQNFYmIMRF4pXYMpQpcgrBQgQi5?=
 =?iso-8859-1?Q?XjbutcpRRCTRssN3oAkjrcFPO/isA6U5i+RXAZQyKkX3ltKtNnsnSEYsAn?=
 =?iso-8859-1?Q?2zsXAiHa4T8jAZiIEUGiQ1jYZUJi9GZ91V4iDwaHgZqp1/sJ6P2rjPkEbh?=
 =?iso-8859-1?Q?g4LdzmsjfnhxOqbXqIYUj0IahAVYpKRO6EvAtFWyfWqSLCPWCBsIw8/Bu0?=
 =?iso-8859-1?Q?pWQWONEOLNfCIXTKfpf1ctBY2AuLJRx4Av1DiFX/X6NWHerRI00wpQB3A8?=
 =?iso-8859-1?Q?U0CfxNgd3Q5YWiQTDqYGDSRYddZmS4bbCygvwujlgT+P//X2ApKVRyHN+6?=
 =?iso-8859-1?Q?y2Fm7AmFQK8Z8B6/hSkOP98HJ7NPC1N8t5sxPajStSW4Pf3UTWzlkhxjlZ?=
 =?iso-8859-1?Q?WpQ+sNsrb7v4MLuqfm5RGWWukV7QRu/K1GN67EAr63Y6TbuOgfaqSQLBV9?=
 =?iso-8859-1?Q?6rzqibscIdOw3f3NkZsyo7S0zSommW7GD1fxoV3yrus4cg/90fvfO/mcbc?=
 =?iso-8859-1?Q?NqUNMnjcjF760349D/1jMGEdffcr66lgdBW2wNXazEay4IztOLs/6PHRZO?=
 =?iso-8859-1?Q?XZtdgS1zBNgtL0IaiOgJIikAwuAe/TOhgsp/T8wqbW238wK0ERxx7C6TN4?=
 =?iso-8859-1?Q?kLLXaDeQTbQiW3laC0V1wD8Ws8AQi+tYXcH5vOXXbmoVTOyh4lyWtKQXVj?=
 =?iso-8859-1?Q?craFNY5vlB/2510WHlXZYzAwANgGPhRAVtgo9Ian20fysgszfRZVjJuXCU?=
 =?iso-8859-1?Q?OOPNzbNK4z533L+Oym9f+8lqfQHyAopsL3ikba3w9h3TW2aNcx4PN19q4R?=
 =?iso-8859-1?Q?zpcsw6oDE5yL0gDr0A8CBd9FDRtF7VsAzmWvDAHr4gQeYlUv/3DR5/lwdR?=
 =?iso-8859-1?Q?PzfJQB9XBiYX9YzjeTyqC2ja+WN3YVU7pL05e536n3TBgyuTKwWyjDVjcR?=
 =?iso-8859-1?Q?OoNHbL1xc5VKnOy2GD+XTabw5YYSOGQQ/NAUmCiYVmskIrmlkrj1HjaZJR?=
 =?iso-8859-1?Q?zDxOB4ed41gItXeTkbNxgNBri/rvdbCKtAVwPUzcfp80zrt+gdQ0VsCAv9?=
 =?iso-8859-1?Q?RHUgQeJeFls1pa3bNfIzy+IudA/YwLoEKsqMYe8YIBYSsHHbCfZrSX21JD?=
 =?iso-8859-1?Q?VX156Jwydyh7JeRe+XesSrONZTalJjINfCJLtmDvQASrTlsHzzW2a3laSM?=
 =?iso-8859-1?Q?quRWKv30N5mDk1an9ypkA+W2UwjOsum32iAN8waDu8vysut34d6Z3yRVTC?=
 =?iso-8859-1?Q?GTdT8XsImPbPXhJVAIBpadRT3CgSM1ntzM9shhQJmbVL6dxo4IqQ+69dsA?=
 =?iso-8859-1?Q?qxzYwgwwvN13KBT4RgQDmAuf6cregksLlKHwVhy4Pk+NglxjAnl7XAxUky?=
 =?iso-8859-1?Q?UDQTKwQ8sJ4Wo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB3873E69D46FDFBB0C8308CF3F651ABY5PR12MB3873namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f66428-b5e8-4ce5-514f-08db6893dd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 02:47:28.4353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hne4c2Enk9ALWmb1l0mix6rjPrQVfMJVovgsY1St9SG9DxMo/2PnJGglJINsvMj1QllY0FIQxmb1lHWKS9sSKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

--_000_BY5PR12MB3873E69D46FDFBB0C8308CF3F651ABY5PR12MB3873namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Shikai

________________________________
From: Guo, Shikai <Shikai.Guo@amd.com>
Sent: Thursday, June 8, 2023 6:27 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hua=
ng, Tim <Tim.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>=
; Guo, Shikai <Shikai.Guo@amd.com>
Subject: [PATCH v3] drm/amd/pm: enable more Pstates profile levels for yell=
ow_carp

This patch enables following UMD stable Pstates profile levels for power_dp=
m_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 140 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |   1 -
 2 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..71566c60372f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -47,6 +47,14 @@
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK             0x00000006=
L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1L

+#define SMU_13_0_8_UMD_PSTATE_GFXCLK                   533
+#define SMU_13_0_8_UMD_PSTATE_SOCCLK                   533
+#define SMU_13_0_8_UMD_PSTATE_FCLK                     800
+
+#define SMU_13_0_1_UMD_PSTATE_GFXCLK                              700
+#define SMU_13_0_1_UMD_PSTATE_SOCCLK                         678
+#define SMU_13_0_1_UMD_PSTATE_FCLK                               1800
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -957,6 +965,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                                         uint32_t max)
 {
         enum smu_message_type msg_set_min, msg_set_max;
+       uint32_t min_clk =3D min;
+       uint32_t max_clk =3D max;
+
         int ret =3D 0;

         if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +996,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
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

@@ -997,12 +1014,48 @@ static int yellow_carp_set_soft_freq_limited_range(s=
truct smu_context *smu,
         return ret;
 }

+static int yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,

It should return uint32_t for the default clk. With this fixed, this patch =
is

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


+                                       enum smu_clk_type clk_type)
+{
+       uint32_t clk_limit =3D 0;
+       struct amdgpu_device *adev =3D smu->adev;
+       switch (clk_type) {
+       case SMU_GFXCLK:
+       case SMU_SCLK:
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+                       clk_limit =3D SMU_13_0_8_UMD_PSTATE_GFXCLK;
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
+                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+                       clk_limit =3D SMU_13_0_1_UMD_PSTATE_GFXCLK;
+               break;
+       case SMU_SOCCLK:
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+                       clk_limit =3D SMU_13_0_8_UMD_PSTATE_SOCCLK;
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
+                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+                       clk_limit =3D SMU_13_0_1_UMD_PSTATE_SOCCLK;
+               break;
+       case SMU_FCLK:
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+                       clk_limit =3D SMU_13_0_8_UMD_PSTATE_FCLK;
+               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
+                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+                       clk_limit =3D SMU_13_0_1_UMD_PSTATE_FCLK;
+               break;
+       default:
+               break;
+       }
+
+       return clk_limit;
+}
+
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
                                 enum smu_clk_type clk_type, char *buf)
 {
         int i, idx, size =3D 0, ret =3D 0;
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
         uint32_t min, max;
+       uint32_t clk_limit =3D 0;

         smu_cmn_get_sysfs_buf(&buf, &size);

@@ -1044,6 +1097,7 @@ static int yellow_carp_print_clk_levels(struct smu_co=
ntext *smu,
                 break;
         case SMU_GFXCLK:
         case SMU_SCLK:
+               clk_limit =3D yellow_carp_get_umd_pstate_clk_default(smu, c=
lk_type);
                 ret =3D yellow_carp_get_current_clk_freq(smu, clk_type, &c=
ur_value);
                 if (ret)
                         goto print_clk_out;
@@ -1058,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct smu_co=
ntext *smu,
                 size +=3D sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
                                 i =3D=3D 0 ? "*" : "");
                 size +=3D sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-                               i =3D=3D 1 ? cur_value : YELLOW_CARP_UMD_PS=
TATE_GFXCLK,
+                               i =3D=3D 1 ? cur_value : clk_limit,
                                 i =3D=3D 1 ? "*" : "");
                 size +=3D sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
                                 i =3D=3D 2 ? "*" : "");
@@ -1107,6 +1161,49 @@ static int yellow_carp_force_clk_levels(struct smu_c=
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
+       clk_limit =3D yellow_carp_get_umd_pstate_clk_default(smu, clk_type)=
;
+
+       switch (clk_type) {
+       case SMU_GFXCLK:
+       case SMU_SCLK:
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NU=
LL, &clk_limit);
+               else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &c=
lk_limit, NULL);
+               break;
+       case SMU_SOCCLK:
+               if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, =
NULL, &clk_limit);
+               break;
+       case SMU_FCLK:
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
@@ -1114,6 +1211,9 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,
         uint32_t sclk_min =3D 0, sclk_max =3D 0;
         uint32_t fclk_min =3D 0, fclk_max =3D 0;
         uint32_t socclk_min =3D 0, socclk_max =3D 0;
+       uint32_t vclk_min =3D 0, vclk_max =3D 0;
+       uint32_t dclk_min =3D 0, dclk_max =3D 0;
+
         int ret =3D 0;

         switch (level) {
@@ -1121,28 +1221,42 @@ static int yellow_carp_set_performance_level(struct=
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
@@ -1182,6 +1296,24 @@ static int yellow_carp_set_performance_level(struct =
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
index a9205a8ea3ad..b3ad8352c68a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,5 @@
 #define __YELLOW_CARP_PPT_H__

 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100

 #endif
--
2.25.1


--_000_BY5PR12MB3873E69D46FDFBB0C8308CF3F651ABY5PR12MB3873namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Shikai</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> Guo, Shikai &lt;=
Shikai.Guo@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 8, 2023 6:27 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Liu, Aaron &lt;Aaron.L=
iu@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Guo, Shikai &lt;Shikai.Guo@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amd/pm: enable more Pstates profile levels f=
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
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; | 140 ++++++++++++=
+++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h&nbsp; |&nbsp;&nbsp; 1 -<=
br>
&nbsp;2 files changed, 136 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index a92da336ecec..71566c60372f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -47,6 +47,14 @@<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1L<br>
&nbsp;<br>
+#define SMU_13_0_8_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 533<=
br>
+#define SMU_13_0_8_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 533<=
br>
+#define SMU_13_0_8_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 800<br>
+<br>
+#define SMU_13_0_1_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 700<br>
+#define SMU_13_0_1_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 678<br>
+#define SMU_13_0_1_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1800<br>
+<br>
&nbsp;#define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&nbsp;#define SMC_DPM_FEATURE ( \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_CCLK_=
DPM_BIT) | \<br>
@@ -957,6 +965,9 @@ static int yellow_carp_set_soft_freq_limited_range(stru=
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
@@ -985,11 +996,17 @@ static int yellow_carp_set_soft_freq_limited_range(st=
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
@@ -997,12 +1014,48 @@ static int yellow_carp_set_soft_freq_limited_range(s=
truct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static int yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,=
</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">It should return&nbsp;<span style=
=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; display: inline !important; color: rgb(0, 0, 0); background-c=
olor: rgb(255, 255, 255);" class=3D"ContentPasted0">uint32_t<span class=3D"=
ContentPasted0">&nbsp;for
 the default clk. With this fixed, this patch is</span></span></div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; display: i=
nline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255)=
;" class=3D"ContentPasted0"><span class=3D"ContentPasted0 ContentPasted1">R=
eviewed-by:
 Tim Huang &lt;Tim.Huang@amd.com&gt;</span></span></div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; display: i=
nline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255)=
;" class=3D"ContentPasted0"><span class=3D"ContentPasted0 ContentPasted1"><=
br>
</span></span></div>
<div class=3D"PlainText elementToProof"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum smu_clk_type clk_type)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_limit =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_8_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_1_UMD_PSTATE_GFXCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_8_UMD_PSTATE_SOCCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_1_UMD_PSTATE_SOCCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_8_UMD_PSTATE_FCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D SM=
U_13_0_1_UMD_PSTATE_FCLK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clk_limit;<br>
+}<br>
+<br>
&nbsp;static int yellow_carp_print_clk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type, char=
 *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, idx, size =3D 0, re=
t =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min, max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_limit =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_get_sysfs_buf(&amp=
;buf, &amp;size);<br>
&nbsp;<br>
@@ -1044,6 +1097,7 @@ static int yellow_carp_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_limit =3D yellow_carp_get_umd_pstate_clk_default(smu, clk_ty=
pe);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D yellow_carp_get_current_clk_freq(smu, clk_typ=
e, &amp;cur_value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
print_clk_out;<br>
@@ -1058,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;0: %uMhz %s\=
n&quot;, min,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D 0 ? &quot;*&quot; : &qu=
ot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;1: %uMhz %s\=
n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D 1 ? cur_value : YELLOW_CARP_UMD_PS=
TATE_GFXCLK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D 1 ? cur_value : clk_limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D 1 ? &quot;*&quot; : &qu=
ot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;2: %uMhz %s\=
n&quot;, max,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D 2 ? &quot;*&quot; : &qu=
ot;&quot;);<br>
@@ -1107,6 +1161,49 @@ static int yellow_carp_force_clk_levels(struct smu_c=
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_limit =3D yellow_carp_get_umd_pst=
ate_clk_default(smu, clk_type);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
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
bsp;&nbsp; if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yellow_carp_get_=
dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &amp;clk_limit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
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
@@ -1114,6 +1211,9 @@ static int yellow_carp_set_performance_level(struct s=
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
@@ -1121,28 +1221,42 @@ static int yellow_carp_set_performance_level(struct=
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
@@ -1182,6 +1296,24 @@ static int yellow_carp_set_performance_level(struct =
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
index a9205a8ea3ad..b3ad8352c68a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h<br>
@@ -24,6 +24,5 @@<br>
&nbsp;#define __YELLOW_CARP_PPT_H__<br>
&nbsp;<br>
&nbsp;extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);<br>
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1100<br>
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

--_000_BY5PR12MB3873E69D46FDFBB0C8308CF3F651ABY5PR12MB3873namp_--
