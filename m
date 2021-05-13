Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18377C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49346108D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49346108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD5F6ECFA;
	Thu, 13 May 2021 11:36:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581F96ECF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 11:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTJDinK1gW0OJJ3u5uPhXrKUD560O7Gt/Lu3fBCdOXOTTwwcsBrMW4BlnuKYgy8Ne573Y1O+k5+x/k0i9yTo3ge+Z8zzLvWPasxCiU1FNlYiAwZv+3bt6lC+u2gsz8TYLOa6rFY0306WyICEHaLe0DIlalTX+KxPfpksVhVnoFqQqcGRPbvOaHl+RD+wr/OB61SrnOXYfQsT6k5zVAovFYUhYeZ22suooG567SCpDMR12HUHEDNSAVZvCodB9lmYvpQZKidVLMDjQl6TFVIfUOa+64culBmd+lo2UL9IaNtG8SejvKUhKQWh/8YvjW5/LDSNhAvvNQ+S6bc9/M40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDshRZyBZH3CHi3Fa05bUVFm02O7QkNECzzbgN368zc=;
 b=cU/L4DrAkh7KQuBf1Y1pJxzjFt9ccMJBNzclNULsA7ML8YR5spG6z+pDcEBBBbplelL0sikw3WJVOPVO8ktlO0K1mm3is7UdmTxzwWP8K5rzjW/O6zDeDlTPCjL7ratfffZ6+b15BfB3FXJ+1drkWerlaRQeYKKRTYQL+iKLjBx5Iynekrbeo2H6zOEo8IVqfZtMbyXyzGGBN2fhjYs4rERpPJthcoshO3vjTgfe+dEicsrfs0dHit5PqW+PtEIqN1Jo+N4mr04E+79mO3nwGmKtB6dS1sos69QMs4u3BzrW4e7gzxhgiF8kkrubdhBs5vn6apuwuNokT/RVc3NlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDshRZyBZH3CHi3Fa05bUVFm02O7QkNECzzbgN368zc=;
 b=BC0vHB+h4/E9i/ydXikchuWsX8a0g0stcrxHUjyDmNqjaJg+qfhwSpFtb9Qhr9u5PXHS54AAcZGiKmmaQiWFXPX+RAUKVqGZ5292U9MuBXQpy7M1xxjlB/EzU/1WV1aeRRMgb+o1HhkF6h2xPNHgnxycd8QF5VafdA5DndYkldA=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 11:36:00 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 11:36:00 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Topic: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Index: AQHXR90HFHI2wRchNkOhkbu3B9ikV6rhR/Or
Date: Thu, 13 May 2021 11:36:00 +0000
Message-ID: <CO6PR12MB547345F347D296F9D5715B8FA2519@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
In-Reply-To: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T11:36:02.228Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a600d49b-7962-4745-4bed-08d91603487c
x-ms-traffictypediagnostic: CO6PR12MB5457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB545751C5EB1BADA06767DD98A2519@CO6PR12MB5457.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsSpXvhiC2yWgdigt1IT5ofmN+b/uOOI3ItRzk5UkgKrqCMiPbF2WlgVa4gqQzRrTsX14czzFA2yCgZ6tUgjS2zJ8TrfWnXZaRsip0F9kmHPs4rovm2HMOjkbkR7uQxOiZtnMHf/RbNCig1fSqEbKOFKwCMoNQX/cLkSmrst3i8Y4TSgSTUirT1YJEkoYZU1vxTJ+rpBdNrB96seimSX/Dd53faA+3dZFHFOheTQrADd+rELt6i/rvS5B0LTFKD090G4lRbgGQunX808ZPagcTCmTHwP+ilM4xXOsDW7cxbygHqFVsphBDMbid4EXf2raQv8EvREGFY+3M1gTZjQZ4Fkxx8eRsrXCv45Il1tnKCQg+o04+/29a3tIsE1uFw8DGdpfCgW5jSJo44HPB6VA8SL+hxOCxZytVyjjQbFsQkkxm6O6xXCvCxv2oVNY+GLlIcxRKHX/m2PmXtJjjKkxLsZxEHIRTrzDahobzlS8SMsgLrlFvdz6F11vxiQLNdVClKMmmEgo3wCtJ+NJqv5gSEwwYnpVXmV0rM3Gd3SnXo0AIOcjgKhqp2bfbA/RDWkjYHBZdGtkhyx2LLz0jbY5eZb4o+r7rmrz+nUXN7pieY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(71200400001)(86362001)(7696005)(83380400001)(54906003)(26005)(6506007)(53546011)(66946007)(122000001)(4326008)(19627405001)(9686003)(55016002)(478600001)(33656002)(8936002)(8676002)(66476007)(52536014)(5660300002)(66446008)(64756008)(2906002)(66556008)(110136005)(316002)(186003)(91956017)(76116006)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?CwkE1Dh1rwontn/dQR4RDIjWFprwmiT5yWxXVVxYMgk09Q+CVtrz+ppmTF?=
 =?iso-8859-1?Q?ezyJu7BOczmqoVo/mXnv+AsB0HdA0j7Gc417lYlpboMroAYNLruWuM8VaA?=
 =?iso-8859-1?Q?9GIdjPfNkr+F+UCKthcbg+z8vxFC6JvN8kmS56BeCHwLVrjKOKtDTFZENM?=
 =?iso-8859-1?Q?ZguIcsHO3vnH9orkhmbJKzGV/NGnT+3ibVJcZybriLZ/Qemr3xC4IxwqiY?=
 =?iso-8859-1?Q?UJsORngGPZbyAh6EwdiGEgCw35GrgZnoZFtA8CSfRKa+igKRcNAcwCnXZP?=
 =?iso-8859-1?Q?NSs7QsM/m+Q9h508d3ymmuZm09DXFsm6Og038HrLJNwVjErw8kCpsluqux?=
 =?iso-8859-1?Q?GvIFcaMS19QG+uvQLMrPOQ8oiKMnAyM8N6pVKKrmg+uMcThtUjG0823zNw?=
 =?iso-8859-1?Q?YRZ+DYTvtJGF1/d7lxLzfw84GiSUSYId/T/WI5NftjhAPJ1FVEK9Efqxe3?=
 =?iso-8859-1?Q?s286ED5TrUhYozlpGygctt1GazOcdT7cfS1u392zXEVbLRivwdW/zhtvpg?=
 =?iso-8859-1?Q?LZ0hGQuBzDLkupvObSS4GyS96tRXOS1mCYJ+OIzHcIjodtxVQVwknDaWfb?=
 =?iso-8859-1?Q?5PtkUbCuxRvaqmKmo/ouC9zra1r9St4QYE3iRgeXb0Q8C3jZ/KWrtinWJR?=
 =?iso-8859-1?Q?ucn7LGey1FGZnjLy2Vnsojm1yxNLVZKk/qGm5YT1PKedBbb0SfgxiONeZH?=
 =?iso-8859-1?Q?1uaPdfljH7cfB83rRGxgz6yNzHCLieMp0xeQcZKca+01/umyanZAe+SRyl?=
 =?iso-8859-1?Q?OxVr0joQfIxemykq2HfUFqTi06nn80Q8Ps51Iz+t4AfXrKWvgD5/2/9R+W?=
 =?iso-8859-1?Q?Dz7SG3CPAeDAg6b5fTgT3Y/U9OtbhuyjJzc0yzGaT15jAZDE2lsGN4gedu?=
 =?iso-8859-1?Q?vWzzp+7xBa8mMbFbf2Wn15FPLCeWP/ibrsMtHSZ5htr8st36mF/+dqAQ9H?=
 =?iso-8859-1?Q?w4JJ+Kl1QMrVpv4F4vkYWpaYmFEQuVJY7qe185RWiEM0VbP2n6/vJ0YzTp?=
 =?iso-8859-1?Q?RbZSL/KGKjuLbkK4r9u9SgutNafGggZohWfCcdznMGtxS6eNmh5gYDrEn/?=
 =?iso-8859-1?Q?EvZYbVAUEGpRAKlcz/BevNs2wqnJeLImSWFZVse+RvFlCPxnq36NSKQsFR?=
 =?iso-8859-1?Q?eRLTdt7f4rpLKJTz7HxZVByTorDEzUQL5sWnfETfWnO+lfNeL/oYfyA4Wm?=
 =?iso-8859-1?Q?NxizYH70LA1PI4g2IN4thJB7v1e8cOZF4vqB7Af6wzP7QWCAJYeydbpAEs?=
 =?iso-8859-1?Q?Wb3gAc1fFEkEIzOmS23O6mac3nhqb6EIXtuD6+pFhXXkmgiY4txOo79IFZ?=
 =?iso-8859-1?Q?A780Sev+42MlJRnXvVgQ0apsuhkWmtr9UOFiEeB9s59W37o=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a600d49b-7962-4745-4bed-08d91603487c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 11:36:00.0112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLwHxF6/cEyW6CyxrEmNMVnV0KzrGPvcZWpvYOa5/IleUlaL4Z7xmGDi8i/iATEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1162862351=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1162862351==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB547345F347D296F9D5715B8FA2519CO6PR12MB5473namp_"

--_000_CO6PR12MB547345F347D296F9D5715B8FA2519CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 13, 2021 5:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd=
.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on aldeb=
aran


Use the current and custom pstate frequencies to track the current and
user-set min/max values in manual and determinism mode. Previously, only
actual_* value was used to track the currrent and user requested value.
The value will get reassigned whenever user requests a new value with
pp_od_clk_voltage node. Hence it will show incorrect values when user
requests an invalid value or tries a partial request without committing
the values. Separating out to custom and current variable fixes such
issues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------
  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 18 ++++-
  2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5d04a1dfdfd8..d27ed2954705 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,8 +78,6 @@

  #define smnPCIE_ESM_CTRL                      0x111003D0

-#define CLOCK_VALID (1 << 31)
-
  static const struct cmn2asic_msg_mapping
aldebaran_message_map[SMU_MSG_MAX_COUNT] =3D {
         MSG_MAP(TestMessage,                         PPSMC_MSG_TestMessage=
,                      0),
         MSG_MAP(GetSmuVersion,                       PPSMC_MSG_GetSmuVersi=
on,                    1),
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct
smu_context *smu)

         pstate_table->gfxclk_pstate.min =3D gfx_table->min;
         pstate_table->gfxclk_pstate.peak =3D gfx_table->max;
+       pstate_table->gfxclk_pstate.curr.min =3D gfx_table->min;
+       pstate_table->gfxclk_pstate.curr.max =3D gfx_table->max;

         pstate_table->uclk_pstate.min =3D mem_table->min;
         pstate_table->uclk_pstate.peak =3D mem_table->max;
+       pstate_table->uclk_pstate.curr.min =3D mem_table->min;
+       pstate_table->uclk_pstate.curr.max =3D mem_table->max;

         pstate_table->socclk_pstate.min =3D soc_table->min;
         pstate_table->socclk_pstate.peak =3D soc_table->max;
+       pstate_table->socclk_pstate.curr.min =3D soc_table->min;
+       pstate_table->socclk_pstate.curr.max =3D soc_table->max;

         if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&
             mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&
@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct
smu_context *smu,
  {
         int i, now, size =3D 0;
         int ret =3D 0;
+       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
         struct pp_clock_levels_with_latency clocks;
         struct smu_13_0_dpm_table *single_dpm_table;
         struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct
smu_context *smu,

                 display_levels =3D clocks.num_levels;

-               min_clk =3D smu->gfx_actual_hard_min_freq & CLOCK_VALID ?
-                                 smu->gfx_actual_hard_min_freq & ~CLOCK_VA=
LID :
-                                 single_dpm_table->dpm_levels[0].value;
-               max_clk =3D smu->gfx_actual_soft_max_freq & CLOCK_VALID ?
-                                 smu->gfx_actual_soft_max_freq & ~CLOCK_VA=
LID :
-                                 single_dpm_table->dpm_levels[1].value;
+               min_clk =3D pstate_table->gfxclk_pstate.curr.min;
+               max_clk =3D pstate_table->gfxclk_pstate.curr.max;

                 freq_values[0] =3D min_clk;
                 freq_values[1] =3D max_clk;
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct
smu_context *smu,
                         && (level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM))
                 smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL=
);

-       /* Reset user min/max gfx clock */
-       smu->gfx_actual_hard_min_freq =3D 0;
-       smu->gfx_actual_soft_max_freq =3D 0;

         switch (level) {

@@ -1163,6 +1161,7 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  {
         struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
         struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_context;
+       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t min_clk;
         uint32_t max_clk;
@@ -1176,14 +1175,20 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
                 return -EINVAL;

         if (smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
-               min_clk =3D max(min, dpm_context->dpm_tables.gfx_table.min)=
;
-               max_clk =3D min(max, dpm_context->dpm_tables.gfx_table.max)=
;
-               ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK,
-                                                           min_clk, max_cl=
k);
+               if (min >=3D max) {
+                       dev_err(smu->adev->dev,
+                               "Minimum GFX clk should be less than the ma=
ximum allowed clock\n");
+                       return -EINVAL;
+               }

[kevin]:
why can these value not be equal in manual mode?

+               if ((min =3D=3D pstate_table->gfxclk_pstate.curr.min) &&
+                   (max =3D=3D pstate_table->gfxclk_pstate.curr.max))
+                       return 0;
+               ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK,
+                                                           min, max);
                 if (!ret) {
-                       smu->gfx_actual_hard_min_freq =3D min_clk | CLOCK_V=
ALID;
-                       smu->gfx_actual_soft_max_freq =3D max_clk | CLOCK_V=
ALID;
+                       pstate_table->gfxclk_pstate.curr.min =3D min;
+                       pstate_table->gfxclk_pstate.curr.max =3D max;
                 }
                 return ret;
         }
@@ -1209,10 +1214,8 @@ static int
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
                                 dev_err(adev->dev,
                                                 "Failed to enable determin=
ism at GFX clock %d MHz\n", max);
                         } else {
-                               smu->gfx_actual_hard_min_freq =3D
-                                       min_clk | CLOCK_VALID;
-                               smu->gfx_actual_soft_max_freq =3D
-                                       max | CLOCK_VALID;
+                               pstate_table->gfxclk_pstate.curr.min =3D mi=
n_clk;
+                               pstate_table->gfxclk_pstate.curr.max =3D ma=
x;
                         }
                 }
         }
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
  {
         struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
         struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_context;
+       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
         uint32_t min_clk;
         uint32_t max_clk;
         int ret =3D 0;
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
                         if (input[1] < dpm_context->dpm_tables.gfx_table.m=
in) {
                                 dev_warn(smu->adev->dev, "Minimum GFX clk =
(%ld) MHz specified is
less than the minimum allowed (%d) MHz\n",
                                         input[1], dpm_context->dpm_tables.=
gfx_table.min);
+                               pstate_table->gfxclk_pstate.custom.min =3D
+                                       pstate_table->gfxclk_pstate.curr.mi=
n;
                                 return -EINVAL;
                         }
-                       smu->gfx_actual_hard_min_freq =3D input[1];
+                       pstate_table->gfxclk_pstate.custom.min =3D input[1]=
;
                 } else if (input[0] =3D=3D 1) {
                         if (input[1] > dpm_context->dpm_tables.gfx_table.m=
ax) {
                                 dev_warn(smu->adev->dev, "Maximum GFX clk =
(%ld) MHz specified is
greater than the maximum allowed (%d) MHz\n",
                                         input[1], dpm_context->dpm_tables.=
gfx_table.max);
+                               pstate_table->gfxclk_pstate.custom.max =3D
+                                       pstate_table->gfxclk_pstate.curr.ma=
x;
                                 return -EINVAL;
                         }
-                       smu->gfx_actual_soft_max_freq =3D input[1];
+                       pstate_table->gfxclk_pstate.custom.max =3D input[1]=
;
                 } else {
                         return -EINVAL;
                 }
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct
smu_context *smu, enum PP_OD_DPM_
                         dev_err(smu->adev->dev, "Input parameter number no=
t correct\n");
                         return -EINVAL;
                 } else {
-                       min_clk =3D smu->gfx_actual_hard_min_freq;
-                       max_clk =3D smu->gfx_actual_soft_max_freq;
+                       if (!pstate_table->gfxclk_pstate.custom.min)
+                               pstate_table->gfxclk_pstate.custom.min =3D
+                                       pstate_table->gfxclk_pstate.curr.mi=
n;
+                       if (!pstate_table->gfxclk_pstate.custom.max)
+                               pstate_table->gfxclk_pstate.custom.max =3D
+                                       pstate_table->gfxclk_pstate.curr.ma=
x;
+                       min_clk =3D pstate_table->gfxclk_pstate.custom.min;
+                       max_clk =3D pstate_table->gfxclk_pstate.custom.max;
+
                         return aldebaran_set_soft_freq_limited_range(smu, =
SMU_GFXCLK,
min_clk, max_clk);
                 }
                 break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0864083e7435..755bddaf6c4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
                                                             SMU_GFXCLK,
                                                             sclk_min,
                                                             sclk_max);
-               if (ret)
+               if (ret) {
                         return ret;
+               } else {
+                       pstate_table->gfxclk_pstate.curr.min =3D sclk_min;
+                       pstate_table->gfxclk_pstate.curr.max =3D sclk_max;
+               }
         }

         if (mclk_min && mclk_max) {
@@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
                                                             SMU_MCLK,
                                                             mclk_min,
                                                             mclk_max);
-               if (ret)
+               if (ret) {
                         return ret;
+               } else {
+                       pstate_table->uclk_pstate.curr.min =3D mclk_min;
+                       pstate_table->uclk_pstate.curr.max =3D mclk_max;
+               }
         }

         if (socclk_min && socclk_max) {
@@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct
smu_context *smu,
                                                             SMU_SOCCLK,
                                                             socclk_min,
                                                             socclk_max);
-               if (ret)
+               if (ret) {
                         return ret;
+               } else {
+                       pstate_table->socclk_pstate.curr.min =3D socclk_min=
;
+                       pstate_table->socclk_pstate.curr.max =3D socclk_max=
;
+               }
         }

         return ret;
--
2.17.1


--_000_CO6PR12MB547345F347D296F9D5715B8FA2519CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 5:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;=
Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies o=
n aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
Use the current and custom pstate frequencies to track the current and<br>
user-set min/max values in manual and determinism mode. Previously, only<br=
>
actual_* value was used to track the currrent and user requested value.<br>
The value will get reassigned whenever user requests a new value with<br>
pp_od_clk_voltage node. Hence it will show incorrect values when user<br>
requests an invalid value or tries a partial request without committing<br>
the values. Separating out to custom and current variable fixes such<br>
issues.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp; .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 65 ++=
++++++++++-------<br>
&nbsp; .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 18 ++=
++-<br>
&nbsp; 2 files changed, 55 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c <br>
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 5d04a1dfdfd8..d27ed2954705 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -78,8 +78,6 @@<br>
<br>
&nbsp; #define smnPCIE_ESM_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x111003D0<br>
<br>
-#define CLOCK_VALID (1 &lt;&lt; 31)<br>
-<br>
&nbsp; static const struct cmn2asic_msg_mapping <br>
aldebaran_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_T=
estMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersi=
on,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct <b=
r>
smu_context *smu)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_ps=
tate.min =3D gfx_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_ps=
tate.peak =3D gfx_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.m=
in =3D gfx_table-&gt;min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.m=
ax =3D gfx_table-&gt;max;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_psta=
te.min =3D mem_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_psta=
te.peak =3D mem_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.min=
 =3D mem_table-&gt;min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.max=
 =3D mem_table-&gt;max;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.min =3D soc_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.peak =3D soc_table-&gt;max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.m=
in =3D soc_table-&gt;min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.m=
ax =3D soc_table-&gt;max;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_table-&gt;count &g=
t; ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
m_table-&gt;count &gt; ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &amp;&amp;<br>
@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct <br>
smu_context *smu,<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, now, size =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pstate_t=
able =3D &amp;smu-&gt;pstate_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_levels_wit=
h_latency clocks;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_table =
*single_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm =3D &amp;smu-&gt;smu_dpm;<br>
@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct <br>
smu_context *smu,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; display_levels =3D clocks.num_levels;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_clk =3D smu-&gt;gfx_actual_hard_min_freq &amp; CLOCK_VALID ?=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_fre=
q &amp; ~CLOCK_VALID :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_dpm_table-&gt;dpm_levels=
[0].value;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_clk =3D smu-&gt;gfx_actual_soft_max_freq &amp; CLOCK_VALID ?=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_fre=
q &amp; ~CLOCK_VALID :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_dpm_table-&gt;dpm_levels=
[1].value;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_clk =3D pstate_table-&gt;gfxclk_pstate.curr.min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_clk =3D pstate_table-&gt;gfxclk_pstate.curr.max;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; freq_values[0] =3D min_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D max_clk;<br>
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct <br=
>
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; (level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism,=
 NULL);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset user min/max gfx clock */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D =
0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D =
0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
<br>
@@ -1163,6 +1161,7 @@ static int <br>
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_contex=
t *dpm_context =3D smu_dpm-&gt;dpm_context;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pstate_t=
able =3D &amp;smu-&gt;pstate_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_clk;<br>
@@ -1176,14 +1175,20 @@ static int <br>
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_dpm-&gt;dpm_level =
=3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; min_clk =3D max(min, dpm_context-&gt;dpm_tables.gfx_table.min);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_clk =3D min(max, dpm_context-&gt;dpm_tables.gfx_table.max);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk, max_clk);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (min &gt;=3D max) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;=
adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Minimum GFX clk should be less than t=
he maximum allowed clock\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">why can these value not be equal in manual mode?</=
div>
<div class=3D"PlainText"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((min =3D=3D pstate_table-&gt;gfxclk_pstate.curr.min) &amp;&a=
mp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (max =3D=3D pstate_table-&gt;gfxclk_psta=
te.curr.max))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min, max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actu=
al_hard_min_freq =3D min_clk | CLOCK_VALID;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actu=
al_soft_max_freq =3D max_clk | CLOCK_VALID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.curr.min =3D min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.curr.max =3D max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1209,10 +1214,8 @@ static int <br>
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Faile=
d to enable determinism at GFX clock %d MHz\n&quot;, max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; min_clk | CLOCK_VALID;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; max | CLOCK_VALID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min =3D=
 min_clk;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max =3D=
 max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct <br>
smu_context *smu, enum PP_OD_DPM_<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_contex=
t *dpm_context =3D smu_dpm-&gt;dpm_context;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pstate_t=
able =3D &amp;smu-&gt;pstate_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_clk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct <br>
smu_context *smu, enum PP_OD_DPM_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
nput[1] &lt; dpm_context-&gt;dpm_tables.gfx_table.min) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &=
quot;Minimum GFX clk (%ld) MHz specified is
<br>
less than the minimum allowed (%d) MHz\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.min);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.min =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pstate_table-&gt;gfxclk_pstate.curr.min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actu=
al_hard_min_freq =3D input[1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.custom.min =3D input[1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (input[0] =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
nput[1] &gt; dpm_context-&gt;dpm_tables.gfx_table.max) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &=
quot;Maximum GFX clk (%ld) MHz specified is
<br>
greater than the maximum allowed (%d) MHz\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.max =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pstate_table-&gt;gfxclk_pstate.curr.max;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actu=
al_soft_max_freq =3D input[1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.custom.max =3D input[1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct <br>
smu_context *smu, enum PP_OD_DPM_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(smu-&gt;adev-&gt;dev, &quot;Input parameter number not correct\n&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D smu-=
&gt;gfx_actual_hard_min_freq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D smu-=
&gt;gfx_actual_soft_max_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_tabl=
e-&gt;gfxclk_pstate.custom.min)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.min =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pstate_table-&gt;gfxclk_pstate.curr.min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_tabl=
e-&gt;gfxclk_pstate.custom.max)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.max =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pstate_table-&gt;gfxclk_pstate.curr.max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D psta=
te_table-&gt;gfxclk_pstate.custom.min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D psta=
te_table-&gt;gfxclk_pstate.custom.max;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK,
<br>
min_clk, max_clk);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c <br>
b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 0864083e7435..755bddaf6c4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct <br>
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_GFXCLK,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_min,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_max);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.curr.min =3D sclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;gfxclk_pstate.curr.max =3D sclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_min &amp;&amp; mc=
lk_max) {<br>
@@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct <br>
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MCLK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_min,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_max);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;uclk_pstate.curr.min =3D mclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;uclk_pstate.curr.max =3D mclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (socclk_min &amp;&amp; =
socclk_max) {<br>
@@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct <br>
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_SOCCLK,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socclk_min,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socclk_max);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;socclk_pstate.curr.min =3D socclk_min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt=
;socclk_pstate.curr.max =3D socclk_max;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547345F347D296F9D5715B8FA2519CO6PR12MB5473namp_--

--===============1162862351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1162862351==--
