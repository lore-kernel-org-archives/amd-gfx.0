Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8959C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 10:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE6F10E712;
	Thu, 23 Nov 2023 10:08:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CF910E713
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 10:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7NKV1v/JK3L6BpHl+PdhiozDffftUoyJL/2WldoLCIeuusS/3JTfUsIqkB2ss/3BxfVP3GGK3VuPYlLXLyvGGCAACRL12DPFoPIP0Bn9J+xPTTHlr0G+4cLsF8mRU0SWx9TTOL6dsvwX98CujhDgBiwkvnW+OPN7pBImLPb4Vn2+7QZ6e5/dQV5/ggFEu3OnG/5YhZ73ZHeNcbRnyh/vugmp2UlBDe8aI4fe9ODdo20x5BEpRgZ2L/MNSsx3IE7FAi56WMj4ol9OxI1yTUqkMwPt56cXUVM1JMZb+F1ukybX6i2jt3x1U+UpMj/aDnchnH3dnjvTSaL0YLDD6Md7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxkzH0/rXtTNUPZQOk9xu9Fw9cIwaC7DFpKs5NMVfiQ=;
 b=R3mbxIeuVVDmHqJiVKzAqB74DRO1DzdrlPFulznR0alMk12PhxwE9pDw0uYvwTkacCPe4vAK0jskS/cnk7nFzOZ9bb2tAtCFRXWi3gMJK/jRTNd4ZXQKnK0/aj2vKowEnWQeT3Kq3u7gmgaeHQv1zATtrZ8BznZqfXRRiHDR8lZjCb6uIbOxzztZTLHgxT8wc+3ljMoF6kE1QISBh44A4t89/x69tMDNnm2T07y6bIJcjJrjCTO1LbdW0Zqbok4AqGfrjbkU5ydDRJiEGOt/1qaQe3loWE0QuX1DP7hWPVF6qKmaSMK7LvtYjalZD4DM9EWMq3/UT4L6VqH7aT1PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxkzH0/rXtTNUPZQOk9xu9Fw9cIwaC7DFpKs5NMVfiQ=;
 b=X9vRbOFN69RItKY4PMW9xxoaTCay/t6IeVne6PO/SG+NViX1NvasJTDN//mb46ZZjTkDxAFPZ4obH2hAPlroLahCcPNqRhSXe1EvVWGyTQ2adTcbBF7jIj7F+g3jHMWM+VpOQWdBQ3y4RkmdOcqLjkIc6rC407j5kNYGs3bMAsY=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:08:24 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:08:24 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Topic: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Index: AQHaHfTMrikEibTFC0yQSpbL/vjTK7CHrfww
Date: Thu, 23 Nov 2023 10:08:24 +0000
Message-ID: <CY5PR12MB63694E1D011F1A4376C11A9CC1B9A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231123100645.235821-1-li.ma@amd.com>
In-Reply-To: <20231123100645.235821-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f7d725f-8719-46fb-a489-7ede68aa50b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-23T10:08:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB6738:EE_
x-ms-office365-filtering-correlation-id: 8f5436f8-4403-4c82-e8dd-08dbec0c215f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txIcHm9OqXwVrQp6oXu2bKNk2ybArYPbCdKlYSWzSVW6A24RfRw9bNnd3W8k3Tj41dHbE8fAv9D+yBcG3OmRBLzk3gV5niPbUxVZuqBM3wobmkz0dBJ/F/jXWA0IPDFImLxzxEAQiI1kdDp/pEyu1wHpNn2WYFoHSLPnb/5YOTkwHWrvH+CtjOP2kLVmkE7+iFjir7HI4IFDDVOGp47DCDLEP0CMkI5qYdDfa0CrHkUfYkA7ZlsIfpmNbMdCaued6ZxwKPG4aQjSniH/TNMEOCxxC67qB1+hnsvDE24fqdnkNuZKmoUf6d0DiTzWLw9/3MCsPNGUSdw8A5jkBdb1p7BmbgM77qiqI6AsKRjtJtr9ALZI6n2xnejtdD/Ehx8OcCr/MsoE9guDj7wYAtEOP3AqyIFSh4IkGiQbZphOgNDOg4VyB+yxDpLxTAtI3oM0M/MihW5vwuQBYre+PC1XmR6rXdv7dEtP4zUwXLpXZaBuF2MpmDGD8GMOVj4AxwnD8Km46EE/Bnz4nY615nZuusDBdCsiOf5PCJ5tb0DT6zo88OucrHfyIzIe5Fulrs1qvXr5iNLLVbMV8qGWsj1O7/iSePUsLoWi0zOfz7rVvHkAJmed42XlVImbKw/l8fbE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(41300700001)(30864003)(5660300002)(15650500001)(8936002)(55016003)(8676002)(4326008)(52536014)(478600001)(7696005)(6506007)(53546011)(9686003)(26005)(71200400001)(33656002)(83380400001)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(110136005)(54906003)(316002)(76116006)(38070700009)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0jPE9fn5+aFvCvbrMt39Dc5fIsTkXHKKPA8rpvfsGFLgAsTrMrwmLip2FHu/?=
 =?us-ascii?Q?H5giZKJLZFc7s+z6UqZeQ1JmhhKVLHF2h42/d7PV3LTecLZ/mElEkXiPvswy?=
 =?us-ascii?Q?S9EbJ+EUqiOzlEJVBEFhxwlw74Q6GUez+rgjbun7cxy1m24W8/z1t/SsiYuY?=
 =?us-ascii?Q?6zS1pWQ10d43DPP1tCWw7o6ZSQYVPxkYvmKqK3lPOJCn0oM98XDW3G8LP2pE?=
 =?us-ascii?Q?2PSfDNsKBYhhMGtw+ZapDiHB9aLZjSxy1tN4NlYaD49CZYdi/67JeArTfwlY?=
 =?us-ascii?Q?nwjEMBW5Yi8o4k1kISfh5lA4vl+hudQqBpT3x7cgbEnqo7+ykcn0YMfP8uVK?=
 =?us-ascii?Q?9IN8FCUgaW7CaN92rTEvUJlHqOjisMrhYNDRNd2qXZvbVZ9Bymwq5iIZuSPN?=
 =?us-ascii?Q?2hmGrLnc6c4eAP+LylFqCzT/Sb0V8+YcEglHF4qXHlAgkS4HrRO0TzRdmCE1?=
 =?us-ascii?Q?qaFq6Kz2OkmsPqqnHHTS04Xo5k8SCrZR8ZzwDHbXRE++ex7ruMqnXKBipyhx?=
 =?us-ascii?Q?apn7Lxo7b9SkblrlI3iGoPpSyDIS/52+Q/5Y+OcN03DcBBvPHCMbkrO/UnpV?=
 =?us-ascii?Q?MN5Rkq4kfwBrqVa0l5jf6VFZtzGluYdSE+15Yjxqrgkl/cuHaLW6ZzZtuOgw?=
 =?us-ascii?Q?fdnbZUbvCZfUs3XjTwYpRL7AGtq+kRbByJwUqJSyU7EHbwGI7D+c+GJZJgPZ?=
 =?us-ascii?Q?8o1afRdT5Yp742GIfKr+5fhk5PwiHeFriDn05sUN4grw4BFxqxEEiifUURAh?=
 =?us-ascii?Q?xeLvoqJkIDKFQxqnGEMyASmcbeBT8BpSOCTmhpVs1nRg7aLMYtOgGitdWymJ?=
 =?us-ascii?Q?+6tdsW6XtOHMBHRaHUUCir5P2D3JzhkHR7GxAGF4/QUzkhvCQ8miYS+UeYsT?=
 =?us-ascii?Q?rUCjrxJ89F30r9hTzzJ4WdRc/aTZYPS1G+3R1W2lvdNcIXTYyB22YLKXon57?=
 =?us-ascii?Q?4Q6iEmNzr31sGm0pDKbUvDZB9xiTmF3LY1CbTJp3S2NpYTuuhnzQIK7r9RAU?=
 =?us-ascii?Q?d382ywTdXNZXUVhrUQjMW3JG5LxvNjQ7j/z2gsLRZDWGVpDTE7EphIS5q6xd?=
 =?us-ascii?Q?zLZE0wG3rYfenK5LXKCb9MT2bvWryQYF1IFal5T0hjlllPiTGt+MQL8SEFr8?=
 =?us-ascii?Q?XSSOOUM53ERnAzdd53jNPTRQrjG7b2GF/qas5r2Obs8cKnnpaDin/FbskdB3?=
 =?us-ascii?Q?faagT8RZZn/v4PhihnyFbZDefsEZwwT2K08FhVkrA9KAjDUro/BWBkmoqvHX?=
 =?us-ascii?Q?+EJgjNg4Jn6jL0Ho79p1d6cKS0WOXiVYDGbMPNxkXJZ+siLqQosW1EmSv7Qn?=
 =?us-ascii?Q?PpOnrmW3G+3/HR1Tj58ZObl7/m2Gc9oVnSpumUaEmbChoFQ4nXSQWpPb4G88?=
 =?us-ascii?Q?ZU6djU/cIfltsErFyL8AuMNqdRNLiaazlW8hI3JDPw/DHR12Uh0ErY7CaJjt?=
 =?us-ascii?Q?HWmJxQXKsyK9aY9vZpE6BYxY30m1cxpRILu7VZDbSI/NwrG8kwyJchoeGnyk?=
 =?us-ascii?Q?wHJSOScbqdXDr/0P4No6yx8U4zOMQtILZTfsXuEHRLRW4TW7sEhZRN9iN0ig?=
 =?us-ascii?Q?eLAPxYVsDIWY1cW1mUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5436f8-4403-4c82-e8dd-08dbec0c215f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 10:08:24.6331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spzrgGTUJOSL9Bx4zmTKy+u9QbHCzPbwS7/pOXzdr54gpKO1OkbqofuK5Y/urGtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Thursday, November 23, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.=
Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and me=
trics table

Increment the driver if version and add new mems to the mertics table.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 17 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 +++
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 77 +++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++-
 4 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 8ebba87f4289..eaea1c65e526 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1086,6 +1086,10 @@ struct gpu_metrics_v3_0 {
        uint16_t                        average_dram_reads;
        /* time filtered DRAM write bandwidth [MB/sec] */
        uint16_t                        average_dram_writes;
+       /* time filtered IPU read bandwidth [MB/sec] */
+       uint16_t                        average_ipu_reads;
+       /* time filtered IPU write bandwidth [MB/sec] */
+       uint16_t                        average_ipu_writes;

        /* Driver attached timestamp (in ns) */
        uint64_t                        system_clock_counter;
@@ -1105,6 +1109,8 @@ struct gpu_metrics_v3_0 {
        uint32_t                        average_all_core_power;
        /* calculated core power [mW] */
        uint16_t                        average_core_power[16];
+       /* time filtered total system power [mW] */
+       uint16_t                        average_sys_power;
        /* maximum IRM defined STAPM power limit [mW] */
        uint16_t                        stapm_power_limit;
        /* time filtered STAPM power limit [mW] */ @@ -1117,6 +1123,8 @@ st=
ruct gpu_metrics_v3_0 {
        uint16_t                        average_ipuclk_frequency;
        uint16_t                        average_fclk_frequency;
        uint16_t                        average_vclk_frequency;
+       uint16_t                        average_uclk_frequency;
+       uint16_t                        average_mpipu_frequency;

        /* Current clocks */
        /* target core frequency [MHz] */
@@ -1126,6 +1134,15 @@ struct gpu_metrics_v3_0 {
        /* GFXCLK frequency limit enforced on GFX [MHz] */
        uint16_t                        current_gfx_maxfreq;

+       /* Throttle Residency (ASIC dependent) */
+       uint32_t throttle_residency_prochot;
+       uint32_t throttle_residency_spl;
+       uint32_t throttle_residency_fppt;
+       uint32_t throttle_residency_sppt;
+       uint32_t throttle_residency_thm_core;
+       uint32_t throttle_residency_thm_gfx;
+       uint32_t throttle_residency_thm_soc;
+
        /* Metrics table alpha filter time constant [us] */
        uint32_t                        time_filter_alphavalue;
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index c125253df20b..c2265e027ca8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1418,6 +1418,16 @@ typedef enum {
        METRICS_PCIE_WIDTH,
        METRICS_CURR_FANPWM,
        METRICS_CURR_SOCKETPOWER,
+       METRICS_AVERAGE_VPECLK,
+       METRICS_AVERAGE_IPUCLK,
+       METRICS_AVERAGE_MPIPUCLK,
+       METRICS_THROTTLER_RESIDENCY_PROCHOT,
+       METRICS_THROTTLER_RESIDENCY_SPL,
+       METRICS_THROTTLER_RESIDENCY_FPPT,
+       METRICS_THROTTLER_RESIDENCY_SPPT,
+       METRICS_THROTTLER_RESIDENCY_THM_CORE,
+       METRICS_THROTTLER_RESIDENCY_THM_GFX,
+       METRICS_THROTTLER_RESIDENCY_THM_SOC,
 } MetricsMember_t;

 enum smu_cmn2asic_mapping_type {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 22f88842a7fd..8f42771e1f0a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure i=
s changed in this file -#define PMFW_DRIVER_IF_VERSION 6
+#define PMFW_DRIVER_IF_VERSION 7

 typedef struct {
   int32_t value;
@@ -150,37 +150,50 @@ typedef struct {
 } DpmClocks_t;

 typedef struct {
-  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
-  uint16_t CorePower[16];            //CAC calculated core power [mW]
-  uint16_t CoreTemperature[16];      //TSEN measured core temperature [cen=
ti-C]
-  uint16_t GfxTemperature;           //TSEN measured GFX temperature [cent=
i-C]
-  uint16_t SocTemperature;           //TSEN measured SOC temperature [cent=
i-C]
-  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power lim=
it [mW]
-  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [mW=
]
-  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced on cl=
assic cores [MHz]
-  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit enforced on =
GFX [MHz]
-  uint16_t SkinTemp;                 //Maximum skin temperature reported b=
y APU and HS2 chassis sensors [centi-C]
-  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequen=
cy [MHz]
-  uint16_t FclkFrequency;            //Time filtered target FCLK frequency=
 [MHz]
-  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
-  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequen=
cy [MHz]
-  uint16_t VclkFrequency;            //Time filtered target VCLK frequency=
 [MHz]
-  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
-  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequen=
cy [MHz]
-  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequen=
cy [MHz]
-  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy %=
 [0-100]
-  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth [=
MB/sec]
-  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidth =
[MB/sec]
-  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residency=
 % [0-100]
-  uint16_t IpuPower;                 //Time filtered IPU power [mW]
-  uint32_t ApuPower;                 //Time filtered APU power [mW]
-  uint32_t GfxPower;                 //Time filtered GFX power [mW]
-  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
-  uint32_t SocketPower;              //Time filtered power used for PPT/ST=
APM [APU+dGPU] [mW]
-  uint32_t AllCorePower;             //Time filtered sum of core power acr=
oss all cores in the socket [mW]
-  uint32_t FilterAlphaValue;         //Metrics table alpha filter time con=
stant [us]
-  uint32_t MetricsCounter;           //Counter that is incremented on ever=
y metrics table update [PM_TIMER cycles]
-  uint32_t spare[16];
+  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
+  uint16_t CorePower[16];              //CAC calculated core power [mW]
+  uint16_t CoreTemperature[16];        //TSEN measured core temperature [c=
enti-C]
+  uint16_t GfxTemperature;             //TSEN measured GFX temperature [ce=
nti-C]
+  uint16_t SocTemperature;             //TSEN measured SOC temperature [ce=
nti-C]
+  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power l=
imit [mW]
+  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit [=
mW]
+  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced on =
classic cores [MHz]
+  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced o=
n GFX [MHz]
+  uint16_t SkinTemp;                   //Maximum skin temperature reported=
 by APU and HS2 chassis sensors [centi-C]
+  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK frequ=
ency [MHz]
+  uint16_t FclkFrequency;              //Time filtered target FCLK frequen=
cy [MHz]
+  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100]
+  uint16_t SocclkFrequency;            //Time filtered target SOCCLK frequ=
ency [MHz]
+  uint16_t VclkFrequency;              //Time filtered target VCLK frequen=
cy [MHz]
+  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
+  uint16_t VpeclkFrequency;            //Time filtered target VPECLK frequ=
ency [MHz]
+  uint16_t IpuclkFrequency;            //Time filtered target IPUCLK frequ=
ency [MHz]
+  uint16_t IpuBusy[8];                 //Time filtered IPU per-column busy=
 % [0-100]
+  uint16_t DRAMReads;                  //Time filtered DRAM read bandwidth=
 [MB/sec]
+  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwidt=
h [MB/sec]
+  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 residen=
cy % [0-100]
+  uint16_t IpuPower;                   //Time filtered IPU power [mW]
+  uint32_t ApuPower;                   //Time filtered APU power [mW]
+  uint32_t GfxPower;                   //Time filtered GFX power [mW]
+  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
+  uint32_t SocketPower;                //Time filtered power used for PPT/=
STAPM [APU+dGPU] [mW]
+  uint32_t AllCorePower;               //Time filtered sum of core power a=
cross all cores in the socket [mW]
+  uint32_t FilterAlphaValue;           //Metrics table alpha filter time c=
onstant [us]
+  uint32_t MetricsCounter;             //Counter that is incremented on ev=
ery metrics table update [PM_TIMER cycles]
+  uint16_t MemclkFrequency;            //Time filtered target MEMCLK frequ=
ency [MHz]
+  uint16_t MpipuclkFrequency;          //Time filtered target MPIPUCLK fre=
quency [MHz]
+  uint16_t IpuReads;                   //Time filtered IPU read bandwidth =
[MB/sec]
+  uint16_t IpuWrites;                  //Time filtered IPU write bandwidth=
 [MB/sec]
+  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on ev=
ery metrics table update when PROCHOT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on ev=
ery metrics table update when SPL was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on ev=
ery metrics table update when fast PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on ev=
ery metrics table update when slow PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_CORE; //Counter that is incremented on
+ every metrics table update when CORE thermal throttling was engaged
+ [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_GFX;  //Counter that is=
 incremented on every metrics table update when GFX thermal throttling was =
engaged [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_SOC;  //Counter t=
hat is incremented on every metrics table update when SOC thermal throttlin=
g was engaged [PM_TIMER cycles]
+  uint16_t Psys;                       //Time filtered Psys power [mW]
+  uint16_t spare1;
+  uint32_t spare[6];
 } SmuMetrics_t;

 //ISP tile definitions
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 03b38c3a9968..94ccdbfd7090 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -246,11 +246,20 @@ static int smu_v14_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                *value =3D 0;
                break;
        case METRICS_AVERAGE_UCLK:
-               *value =3D 0;
+               *value =3D metrics->MemclkFrequency;
                break;
        case METRICS_AVERAGE_FCLK:
                *value =3D metrics->FclkFrequency;
                break;
+       case METRICS_AVERAGE_VPECLK:
+               *value =3D metrics->VpeclkFrequency;
+               break;
+       case METRICS_AVERAGE_IPUCLK:
+               *value =3D metrics->IpuclkFrequency;
+               break;
+       case METRICS_AVERAGE_MPIPUCLK:
+               *value =3D metrics->MpipuclkFrequency;
+               break;
        case METRICS_AVERAGE_GFXACTIVITY:
                *value =3D metrics->GfxActivity / 100;
                break;
@@ -270,8 +279,26 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu=
_context *smu,
                *value =3D metrics->SocTemperature / 100 *
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
-       case METRICS_THROTTLER_STATUS:
-               *value =3D 0;
+       case METRICS_THROTTLER_RESIDENCY_PROCHOT:
+               *value =3D metrics->ThrottleResidency_PROCHOT;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_SPL:
+               *value =3D metrics->ThrottleResidency_SPL;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_FPPT:
+               *value =3D metrics->ThrottleResidency_FPPT;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_SPPT:
+               *value =3D metrics->ThrottleResidency_SPPT;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_THM_CORE:
+               *value =3D metrics->ThrottleResidency_THM_CORE;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_THM_GFX:
+               *value =3D metrics->ThrottleResidency_THM_GFX;
+               break;
+       case METRICS_THROTTLER_RESIDENCY_THM_SOC:
+               *value =3D metrics->ThrottleResidency_THM_SOC;
                break;
        case METRICS_VOLTAGE_VDDGFX:
                *value =3D 0;
@@ -498,6 +525,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_c=
ontext *smu,
                sizeof(uint16_t) * 16);
        gpu_metrics->average_dram_reads =3D metrics.DRAMReads;
        gpu_metrics->average_dram_writes =3D metrics.DRAMWrites;
+       gpu_metrics->average_ipu_reads =3D metrics.IpuReads;
+       gpu_metrics->average_ipu_writes =3D metrics.IpuWrites;

        gpu_metrics->average_socket_power =3D metrics.SocketPower;
        gpu_metrics->average_ipu_power =3D metrics.IpuPower; @@ -505,6 +534=
,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
        gpu_metrics->average_gfx_power =3D metrics.GfxPower;
        gpu_metrics->average_dgpu_power =3D metrics.dGpuPower;
        gpu_metrics->average_all_core_power =3D metrics.AllCorePower;
+       gpu_metrics->average_sys_power =3D metrics.Psys;
        memcpy(&gpu_metrics->average_core_power[0],
                &metrics.CorePower[0],
                sizeof(uint16_t) * 16);
@@ -515,6 +545,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_c=
ontext *smu,
        gpu_metrics->average_fclk_frequency =3D metrics.FclkFrequency;
        gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
        gpu_metrics->average_ipuclk_frequency =3D metrics.IpuclkFrequency;
+       gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
+       gpu_metrics->average_mpipu_frequency =3D metrics.MpipuclkFrequency;

        memcpy(&gpu_metrics->current_coreclk[0],
                &metrics.CoreFrequency[0],
@@ -522,6 +554,14 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_=
context *smu,
        gpu_metrics->current_core_maxfreq =3D metrics.InfrastructureCpuMaxF=
req;
        gpu_metrics->current_gfx_maxfreq =3D metrics.InfrastructureGfxMaxFr=
eq;

+       gpu_metrics->throttle_residency_prochot =3D metrics.ThrottleResiden=
cy_PROCHOT;
+       gpu_metrics->throttle_residency_spl =3D metrics.ThrottleResidency_S=
PL;
+       gpu_metrics->throttle_residency_fppt =3D metrics.ThrottleResidency_=
FPPT;
+       gpu_metrics->throttle_residency_sppt =3D metrics.ThrottleResidency_=
SPPT;
+       gpu_metrics->throttle_residency_thm_core =3D metrics.ThrottleReside=
ncy_THM_CORE;
+       gpu_metrics->throttle_residency_thm_gfx =3D metrics.ThrottleResiden=
cy_THM_GFX;
+       gpu_metrics->throttle_residency_thm_soc =3D
+metrics.ThrottleResidency_THM_SOC;
+
        gpu_metrics->time_filter_alphavalue =3D metrics.FilterAlphaValue;
        gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

--
2.25.1

