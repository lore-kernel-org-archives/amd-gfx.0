Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06651C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 08:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8804B10F0F6;
	Mon, 23 May 2022 08:48:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A73010F0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 08:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMcQuPCgtvRa/QbI5kdOsOMOF3DumyDhAYztiQ7g3R7CheQtbb9LPjB8tKjENiajNho5Hz6d7yLND93pR5CZSEREvBtpFVk5RpZB9GXxWLsPnRWTIsGLaYGEcR5cHGDnPKyuugxpFtbtM8hOoNoBaSh6W+Gm5J9xaKPi+PTsJkD2c8ql8OqWOOnVeJbSrnFrzFfNaz5go3QnodBwtg2eyB7VOQzyteOpRPujDR9/UJ2DDMZww2o+d4KkkGqcazSzHOn5EbkDKdf2c6p20B4Tb1LgS3IU3ueGLpo3bg9Xb4161S2+pWDAxlg8QeNLSzGOP71GqR8f2lDCLtQeU8grFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGW1LQJh+csVHKb+lAfFtO+QfJMCM2jheLRhDcUyDFw=;
 b=Xcv3ovYVwtB7T4/q6BPVKxabluCvzIv0yibQkBdxkamx1hap6oTrW77YivBlCOfpAoP/MIgvb0rWhaLHhVJtdUy3cdX6s85CuxtPRd/02VU6wY/wYUayH54NTRBX2gnRSWL17UA2u8TEUP2REY80mIwUPnp/Zghppir3tugMy2RGVkZMzcQ9QLr2HWpr5q2swuY9G/gB0TY0mf3/OLnnDGUlVvfEFvvEvOzffWFhP3+BuFGi6jrmSpmc6MtmWMpiN+wrwFbusjVsRHCWoJM8Jvd/lXc6BDXunza2cWHcUBDyvqVKqsEEl7ergsjbn+KXFxfqpeTN2j8rjHnDgEpK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGW1LQJh+csVHKb+lAfFtO+QfJMCM2jheLRhDcUyDFw=;
 b=tkwLkDWuyKeEfn8ya7kRTfTehw/4Z3iNeKIQx0pAgI9JFLJosMHAkYkBY0ynD5cP1e9O5UqyUNSk08ly/mSVE84E7ELftrPmlhpsQcx+W4pgCptrPKchrmbhur3fReNS/5wsHlR2zbMfer20CwQTVIhMpgGi61zv40Yr1431E/k=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BY5PR12MB3747.namprd12.prod.outlook.com (2603:10b6:a03:1ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 08:48:48 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:48:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Thread-Topic: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Thread-Index: AQHYbn2CQB4E/8+3uUmRgKW4jfrfVa0sJL8k
Date: Mon, 23 May 2022 08:48:48 +0000
Message-ID: <CO6PR12MB5473FC663AE752AB2C3C284D82D49@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220523081701.32456-1-Stanley.Yang@amd.com>
In-Reply-To: <20220523081701.32456-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T08:48:47.729Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e116fa8-95ff-4f88-bcc9-08da3c990da5
x-ms-traffictypediagnostic: BY5PR12MB3747:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3747AF446637FAF8492F00A082D49@BY5PR12MB3747.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf7eTltDLORWZWEQGs+5e6Ox+RD2rnffbxPj3qM4eB/NA5Zx8JF8gwxTemzsV/m86gSvf2lJUsvQVuVX1uRZ2stM2hPhwWBiKDm7TeO6qdGdymB43GYzUp+4rqTK1pZUnzKlQo1tlovFbbMcdwtbJX4Vv9uof8eq5HV8yOPvaeVTkIb4EsUZ/57PpMQd6ZE/muAc630JxyiRM9UY15utAmdGCNF9DhYswTdMjJClr4joh9M9+Ya1AkJFlLNuLMSioa4R/u9OpccZXuEcgCy7IvNc4+EIQRNBMrxa2Gfrn9BRjvNBga9pJfojGxoQpt/N4oLKi7NaaHJsm2TNFAd9g1q/ZKvlf/fAbJqP90NeOkOLH/CGLlP/gqHSdgC1c4cwSTkw0dUS2P558OubMncLzCKtOGaGsd075/jclthWmLwHEqOE/piu8ADibCtsHaPeUZGnL17RfE+W2NxSLWsiN9X8LEOuVv6i2p/RJDSMOyObJbYDKIMIQeBvWpqYoBbJvjsdrAp76q3BXkKYR6eeR0g0LsDOkjqpyLdrUYCJ2qWAhufRQVw6vHs+kkdihsTWKYTU6Ank9ldrmMbmSt6EZG57EM3pU6nNi3quNgIUTP6O9gumJlcni+ljr7l+aPFsoW6CXXvtMgubmslQJ+RcyEFSc4ETeu2KOVXoRu9ZOdNpKIMZEjgq4X7npbMdNhcaOMYXKi+4CsxeJS0evlrsbA7h6T0222nihiqVwRLe2JY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(186003)(6636002)(55016003)(110136005)(19627405001)(2906002)(33656002)(38100700002)(508600001)(71200400001)(83380400001)(52536014)(66446008)(53546011)(6506007)(76116006)(91956017)(66946007)(66476007)(64756008)(66556008)(38070700005)(122000001)(921005)(8936002)(5660300002)(9686003)(26005)(8676002)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jGx1eZAqbntklmlYTdNNW6iXH2ioJsCUhPJ514nzl/ivW4geawvl2TOi/3?=
 =?iso-8859-1?Q?anGGRFybDtqL6XvugsLD/GCtAkO9M2bon8XQ3CUAdEFTYTME4x9/QlgZ5W?=
 =?iso-8859-1?Q?F/zbQFJSEoxcJYizJE0e3CtpuTdh2e8OBHp8iImnxxlhIqkoFar+eDpn3D?=
 =?iso-8859-1?Q?7aqa476QYInKnRiGRyLux4s7CIk10RLuZ07FOrNCTXvDOI67HR5YDRDS0u?=
 =?iso-8859-1?Q?eTMRflJpjkV2SIptcNDgt+KrXaMG8SxaMOtkwBha94sdfYrcdbV3DMZu1g?=
 =?iso-8859-1?Q?OYd/MHizI2gBeJKbEMNW4uA2JDAwJ35J9VNWx5jU07sRKfqXxmW5lLdJAR?=
 =?iso-8859-1?Q?vejNN1tIU8iVQHsyNm3EyuUPTqCQZVemN252kyn5z2MRIRru8+HdOu3git?=
 =?iso-8859-1?Q?HC1Hc6kdSArrwqmcQUbW0e2gfIM7Pb+JX0KIuZh/n9GI+0G3x7IfazfgtG?=
 =?iso-8859-1?Q?dELlvbBcHfy9O1XiV2gECWEJSlt571172TPmwL0Y1JyVnxwTkjIBxnCBfb?=
 =?iso-8859-1?Q?bW+M1SuEuZ97l7eWIBZn6il1fuyUfAwY1CWUeZf9PyobpqcQZXqDguqZRd?=
 =?iso-8859-1?Q?M3eOx6RXJpVV9EuyRD2WaXLC8zLLGWAIDAzCYEXe2RCavzncAK42BPGokm?=
 =?iso-8859-1?Q?wfWFbVwiQVl2Q5j62EhAK0o0d88RhjMJx5dxuT5p9kvBaUZKAdsJnyPJe4?=
 =?iso-8859-1?Q?PeTXpzd0l6akl1Uitk7dex73MIkrdI8vCZDLUlm5DnbUil1Q/t6EdbZxeX?=
 =?iso-8859-1?Q?NrRLbxdsldsepf+EufOfsPFS7gdgZelQJXjFaBtF5kX+m1NwD7OO4hf+E9?=
 =?iso-8859-1?Q?nnqd2SwYXltGBNpPcfPais/IyEAMqWUptQmhjCwsety5SV4AVzqciPep9c?=
 =?iso-8859-1?Q?re/sx7D3KCGa8SIhwb0S9myoL0C3+lb7jR3UYnqnXSVFcZEdVZNMdqEwFK?=
 =?iso-8859-1?Q?HYbmWXEPprZfJk499Jm/sd9ilnbBZDYJv8pi5wl7xs/FtRyTcqDIBKmbKE?=
 =?iso-8859-1?Q?IANwyVsJdD++PfHvfFnGWUR96tGZ7ALzZOpHb2XZuT6Nl9g2XN2V+MSmK7?=
 =?iso-8859-1?Q?cx7yXN9FZvDMXVY2snLt9IM1zmIFDkXM56abjN/naOxjJSpyjFkhhwS2nc?=
 =?iso-8859-1?Q?gwvO8RnyRcG4r6aBAGGfjXTSMTt3s2GDjoXJul2leO+/355XSF8/hwnebr?=
 =?iso-8859-1?Q?53qkEV+KXxPzQsbVMUDRvZmE+8JhaqplU+zPlUapvI9SiM+Z/UlSgKqR3E?=
 =?iso-8859-1?Q?HazbVMBjy0V32Ojpr92FcN0SPKQ3OfwfuRg8cj5PJd2TEOLCSvm9/HE8RF?=
 =?iso-8859-1?Q?4SaWRtMYljUZM1Ef/BpORq963nhpsGUSycT3ZSyPv5fR1UNca8qHfwipFD?=
 =?iso-8859-1?Q?hiIP0jFNjnAHSmHi4NeZFHyS0wqfYaVGnjbnlwiMb5pG1lHvW+KF/PLql2?=
 =?iso-8859-1?Q?+CblXRamfA9clJ4mgpPPPUps3vCoVTV7VM5tXpNZNyh+PauN5sKVI/2Qr/?=
 =?iso-8859-1?Q?JwSk+WmAZ9f/O6+npeqpymveKVhOQh7f51wfmqqR2al3e/AtrvPstXjPR2?=
 =?iso-8859-1?Q?jn2J/oF6dxM0ccNi6del9f5vJmTVUtoWnqtzWs3KkH82AZZwpSco+7l7+h?=
 =?iso-8859-1?Q?tk45SBUpVGJ3Tz0pGsLvxcUVxG54EFzFSMpyNWC9iotAE2wx6dCKPf9CaB?=
 =?iso-8859-1?Q?2I88nhQpWA6JEIEOLXc37x2IkdRoqUkUPrMu1YRFBMJFYnVbH64vakUskB?=
 =?iso-8859-1?Q?JuVwCupya6tewIY08xDd7/jHq0dvKSh/B7dDOuQZ/xLJYz?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473FC663AE752AB2C3C284D82D49CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e116fa8-95ff-4f88-bcc9-08da3c990da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:48:48.2506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82iJRbcQb9Ys+L4/KldYEIJlz9PMA+ij7ZtZdYTE2N6Eie/8gCFnnJr7yzL5+cuJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3747
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473FC663AE752AB2C3C284D82D49CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Stanley.=
Yang <Stanley.Yang@amd.com>
Sent: Monday, May 23, 2022 4:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan =
<Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in ecctab=
le

SMU add a new variable mca_ceumc_addr to record
umc correctable error address in EccInfo table,
driver side add ecctable_v2 to support this feature

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
 .../inc/pmfw_if/smu13_driver_if_aldebaran.h   |  15 +++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 101 ++++++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 5 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index b9a6fac2b8b2..28e603243b67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -328,6 +328,7 @@ struct ecc_info_per_ch {
         uint16_t ce_count_hi_chip;
         uint64_t mca_umc_status;
         uint64_t mca_umc_addr;
+       uint64_t mca_ceumc_addr;
 };

 struct umc_ecc_info {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a6a7b6c33683..9f7257ada437 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -322,6 +322,7 @@ enum smu_table_id
         SMU_TABLE_PACE,
         SMU_TABLE_ECCINFO,
         SMU_TABLE_COMBO_PPTABLE,
+       SMU_TABLE_ECCINFO_V2,
         SMU_TABLE_COUNT,
 };

@@ -340,6 +341,7 @@ struct smu_table_context
         void                            *driver_pptable;
         void                            *combo_pptable;
         void                            *ecc_table;
+       void                            *ecc_table_v2;  // adapt to smu sup=
port record mca_ceumc_addr
         void                            *driver_smu_config_table;
         struct smu_table                tables[SMU_TABLE_COUNT];
         /*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldeb=
aran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran=
.h
index 0f67c56c2863..2868604eff49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
@@ -522,6 +522,21 @@ typedef struct {
         EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
 } EccInfoTable_t;

+typedef struct {
+       uint64_t mca_umc_status;
+       uint64_t mca_umc_addr;
+       uint64_t mca_ceumc_addr;
+
+       uint16_t ce_count_lo_chip;
+       uint16_t ce_count_hi_chip;
+
+       uint32_t eccPadding;
+} EccInfo_t_v2;
+
+typedef struct {
+       EccInfo_t_v2  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
+} EccInfoTable_t_v2;
+
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
 // SMC_MSG_TransferTableSmu2Dram
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..e58df9490cec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -82,6 +82,12 @@
  */
 #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00

+/*
+ * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,
+ * use this to check mca_ceumc_addr record whether support
+ */
+#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700
+
 /*
  * SMU support BAD CHENNEL info MSG since version 68.51.00,
  * use this to check ECCTALE feature whether support
@@ -239,6 +245,9 @@ static int aldebaran_tables_init(struct smu_context *sm=
u)
         SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

+       SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO_V2, sizeof(EccInfoTable_t_=
v2),
+                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
[kevin]:
this table mapping is not needed, the reason as below.

         smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), GFP_KER=
NEL);
         if (!smu_table->metrics_table)
                 return -ENOMEM;
@@ -255,6 +264,10 @@ static int aldebaran_tables_init(struct smu_context *s=
mu)
         if (!smu_table->ecc_table)
                 return -ENOMEM;

+       smu_table->ecc_table_v2 =3D kzalloc(tables[SMU_TABLE_ECCINFO_V2].si=
ze, GFP_KERNEL);
+       if (!smu_table->ecc_table_v2)
+               return -ENOMEM;;
+

[kevin]:

add eccinfo table v2 is not needed for this case, this table is only used s=
tore table data from pmfw to driver,
you can create a large enough table which can save ecc table data directly.

e.g:
size =3D max(sizeof(EccInfoTable_t_v2), sizeof(EccInfoTable_t));
smu_table->ecc_table =3D kzalloc(size, GFP_KERNEL);

Best Regards,
Kevin

         return 0;
 }

@@ -1802,7 +1815,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,
         return sizeof(struct gpu_metrics_v1_3);
 }

-static int aldebaran_check_ecc_table_support(struct smu_context *smu)
+static int aldebaran_check_ecc_table_support(struct smu_context *smu,
+               int *ecctable_version)
 {
         uint32_t if_version =3D 0xff, smu_version =3D 0xff;
         int ret =3D 0;
@@ -1815,6 +1829,11 @@ static int aldebaran_check_ecc_table_support(struct =
smu_context *smu)

         if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
                 ret =3D -EOPNOTSUPP;
+       else if (smu_version >=3D SUPPORT_ECCTABLE_SMU_VERSION &&
+                       smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
+               *ecctable_version =3D 1;
+       else
+               *ecctable_version =3D 2;

         return ret;
 }
@@ -1824,36 +1843,72 @@ static ssize_t aldebaran_get_ecc_info(struct smu_co=
ntext *smu,
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
         EccInfoTable_t *ecc_table =3D NULL;
+       EccInfoTable_t_v2 *ecc_table_v2 =3D NULL;
         struct ecc_info_per_ch *ecc_info_per_channel =3D NULL;
         int i, ret =3D 0;
+       int table_version =3D 0;
         struct umc_ecc_info *eccinfo =3D (struct umc_ecc_info *)table;

-       ret =3D aldebaran_check_ecc_table_support(smu);
+       ret =3D aldebaran_check_ecc_table_support(smu, &table_version);
         if (ret)
                 return ret;

-       ret =3D smu_cmn_update_table(smu,
-                              SMU_TABLE_ECCINFO,
-                              0,
-                              smu_table->ecc_table,
-                              false);
-       if (ret) {
-               dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n=
");
-               return ret;
-       }
+       if (table_version =3D=3D 1) {
+               ret =3D smu_cmn_update_table(smu,
+                                      SMU_TABLE_ECCINFO,
+                                      0,
+                                      smu_table->ecc_table,
+                                      false);
+               if (ret) {
+                       dev_info(smu->adev->dev, "Failed to export SMU ecc =
table!\n");
+                       return ret;
+               }
+
+               ecc_table =3D (EccInfoTable_t *)smu_table->ecc_table;
+
+               for (i =3D 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+                       ecc_info_per_channel =3D &(eccinfo->ecc[i]);
+                       ecc_info_per_channel->ce_count_lo_chip =3D
+                               ecc_table->EccInfo[i].ce_count_lo_chip;
+                       ecc_info_per_channel->ce_count_hi_chip =3D
+                               ecc_table->EccInfo[i].ce_count_hi_chip;
+                       ecc_info_per_channel->mca_umc_status =3D
+                               ecc_table->EccInfo[i].mca_umc_status;
+                       ecc_info_per_channel->mca_umc_addr =3D
+                               ecc_table->EccInfo[i].mca_umc_addr;
+               }
+       } else if (table_version =3D=3D 2) {
+               /* still use SMU_TABLE_ECC_INFO index,
+                * smu 68.55.0 add mca_ceumc_addr variable
+                * in EccInfo_t struct to report correctable
+                * error address and the table_id is not changed
+                */
+               ret =3D smu_cmn_update_table(smu,
+                                      SMU_TABLE_ECCINFO,
+                                      0,
+                                      smu_table->ecc_table_v2,
+                                          false);

-       ecc_table =3D (EccInfoTable_t *)smu_table->ecc_table;
-
-       for (i =3D 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
-               ecc_info_per_channel =3D &(eccinfo->ecc[i]);
-               ecc_info_per_channel->ce_count_lo_chip =3D
-                       ecc_table->EccInfo[i].ce_count_lo_chip;
-               ecc_info_per_channel->ce_count_hi_chip =3D
-                       ecc_table->EccInfo[i].ce_count_hi_chip;
-               ecc_info_per_channel->mca_umc_status =3D
-                       ecc_table->EccInfo[i].mca_umc_status;
-               ecc_info_per_channel->mca_umc_addr =3D
-                       ecc_table->EccInfo[i].mca_umc_addr;
+               if (ret) {
+                       dev_info(smu->adev->dev, "Failed to export SMU ecc =
table_v2!\n");
+                       return ret;
+               }
+
+               ecc_table_v2 =3D (EccInfoTable_t_v2 *)smu_table->ecc_table_=
v2;
+
+               for (i =3D 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+                       ecc_info_per_channel =3D &(eccinfo->ecc[i]);
+                       ecc_info_per_channel->ce_count_lo_chip =3D
+                               ecc_table_v2->EccInfo[i].ce_count_lo_chip;
+                       ecc_info_per_channel->ce_count_hi_chip =3D
+                               ecc_table_v2->EccInfo[i].ce_count_hi_chip;
+                       ecc_info_per_channel->mca_umc_status =3D
+                               ecc_table_v2->EccInfo[i].mca_umc_status;
+                       ecc_info_per_channel->mca_umc_addr =3D
+                               ecc_table_v2->EccInfo[i].mca_umc_addr;
+                       ecc_info_per_channel->mca_ceumc_addr =3D
+                               ecc_table_v2->EccInfo[i].mca_ceumc_addr;
+               }
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index ae6321af9d88..af2d84a16f3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -552,9 +552,11 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
         kfree(smu_table->hardcode_pptable);
         smu_table->hardcode_pptable =3D NULL;

+       kfree(smu_table->ecc_table_v2);
         kfree(smu_table->ecc_table);
         kfree(smu_table->metrics_table);
         kfree(smu_table->watermarks_table);
+       smu_table->ecc_table_v2 =3D NULL;
         smu_table->ecc_table =3D NULL;
         smu_table->metrics_table =3D NULL;
         smu_table->watermarks_table =3D NULL;
--
2.17.1


--_000_CO6PR12MB5473FC663AE752AB2C3C284D82D49CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Stanley.Yang &lt;Stanley.Yang=
@amd.com&gt;<br>
<b>Sent:</b> Monday, May 23, 2022 4:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.La=
zar@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in=
 ecctable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">SMU add a new variable mca_ceumc_ad=
dr to record<br>
umc correctable error address in EccInfo table,<br>
driver side add ecctable_v2 to support this feature<br>
<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp;&nbsp; 2 +<br>
&nbsp;.../inc/pmfw_if/smu13_driver_if_aldebaran.h&nbsp;&nbsp; |&nbsp; 15 ++=
+<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 101 ++=
++++++++++++----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 2 +<br>
&nbsp;5 files changed, 98 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index b9a6fac2b8b2..28e603243b67 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -328,6 +328,7 @@ struct ecc_info_per_ch {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_hi_chip;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_status;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_ceumc_addr;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct umc_ecc_info {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index a6a7b6c33683..9f7257ada437 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -322,6 +322,7 @@ enum smu_table_id<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_PACE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_COMBO_PPTABLE,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO_V2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_COUNT,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -340,6 +341,7 @@ struct smu_table_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_p=
ptable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *combo_pp=
table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ecc_tabl=
e;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ecc_table_v2;&nbsp;=
 // adapt to smu support record mca_ceumc_addr<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_s=
mu_config_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tables[SMU_TABLE_COUNT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldeb=
aran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran=
.h<br>
index 0f67c56c2863..2868604eff49 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h<=
br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h<=
br>
@@ -522,6 +522,21 @@ typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfo_t&nbsp; EccInfo[AL=
DEBARAN_UMC_CHANNEL_NUM];<br>
&nbsp;} EccInfoTable_t;<br>
&nbsp;<br>
+typedef struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_ceumc_addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_lo_chip;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_hi_chip;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t eccPadding;<br>
+} EccInfo_t_v2;<br>
+<br>
+typedef struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfo_t_v2&nbsp; EccInfo[ALDEBARAN_=
UMC_CHANNEL_NUM];<br>
+} EccInfoTable_t_v2;<br>
+<br>
&nbsp;// These defines are used with the following messages:<br>
&nbsp;// SMC_MSG_TransferTableDram2Smu<br>
&nbsp;// SMC_MSG_TransferTableSmu2Dram<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 38af648cb857..e58df9490cec 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -82,6 +82,12 @@<br>
&nbsp; */<br>
&nbsp;#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00<br>
&nbsp;<br>
+/*<br>
+ * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,<br>
+ * use this to check mca_ceumc_addr record whether support<br>
+ */<br>
+#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700<br>
+<br>
&nbsp;/*<br>
&nbsp; * SMU support BAD CHENNEL info MSG since version 68.51.00,<br>
&nbsp; * use this to check ECCTALE feature whether support<br>
@@ -239,6 +245,9 @@ static int aldebaran_tables_init(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU=
_TABLE_ECCINFO, sizeof(EccInfoTable_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_TABLE_ECCI=
NFO_V2, sizeof(EccInfoTable_t_v2),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AMDGP=
U_GEM_DOMAIN_VRAM);<br>
+</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof">this table mapping is not needed, t=
he reason as below.<br>
</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D kzalloc(sizeof(SmuMetrics_t),=
 GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics=
_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
@@ -255,6 +264,10 @@ static int aldebaran_tables_init(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;ecc_tab=
le)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table_v2 =3D kzallo=
c(tables[SMU_TABLE_ECCINFO_V2].size, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;ecc_table_v2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;;<br>
+</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">add eccinfo table v2 is not needed =
for this case, this table is only used store table data from pmfw to driver=
,</div>
<div class=3D"PlainText elementToProof">you can create a large enough table=
 which can save ecc table data directly.</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">e.g:</div>
<div class=3D"PlainText elementToProof">size =3D max(sizeof(<span style=3D"=
background-color:rgb(255, 255, 255);display:inline !important">EccInfoTable=
_t_v2), sizeof(EccInfoTable_t));</span><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"background-color:rgb=
(255, 255, 255);display:inline !important"><span style=3D"background-color:=
rgb(255, 255, 255);display:inline !important">smu_table-&gt;ecc_table =3D k=
zalloc(size, GFP_KERNEL);</span><br style=3D"background-color:rgb(255, 255,=
 255)">
</span></div>
<div class=3D"PlainText elementToProof"><span style=3D"background-color:rgb=
(255, 255, 255);display:inline !important"><span style=3D"background-color:=
rgb(255, 255, 255);display:inline !important"><br>
</span></span></div>
<div class=3D"PlainText elementToProof"><span style=3D"background-color:rgb=
(255, 255, 255);display:inline !important"><span style=3D"background-color:=
rgb(255, 255, 255);display:inline !important">Best Regards,</span></span></=
div>
<div class=3D"PlainText elementToProof">Kevin</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1802,7 +1815,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v1_3);<br>
&nbsp;}<br>
&nbsp;<br>
-static int aldebaran_check_ecc_table_support(struct smu_context *smu)<br>
+static int aldebaran_check_ecc_table_support(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int *ecctable_version)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t if_version =3D 0x=
ff, smu_version =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1815,6 +1829,11 @@ static int aldebaran_check_ecc_table_support(struct =
smu_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &lt; SUPPO=
RT_ECCTABLE_SMU_VERSION)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (smu_version &gt;=3D SUPPORT_=
ECCTABLE_SMU_VERSION &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &lt;=
 SUPPORT_ECCTABLE_V2_SMU_VERSION)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *ecctable_version =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *ecctable_version =3D 2;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -1824,36 +1843,72 @@ static ssize_t aldebaran_get_ecc_info(struct smu_co=
ntext *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfoTable_t *ecc_table =
=3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfoTable_t_v2 *ecc_table_v2 =3D N=
ULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecc_info_per_ch *ec=
c_info_per_channel =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_version =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct umc_ecc_info *eccin=
fo =3D (struct umc_ecc_info *)table;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_check_ecc_table_sup=
port(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_check_ecc_table_sup=
port(smu, &amp;table_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;Failed to export SMU ecc ta=
ble!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_version =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TABLE_ECCINFO,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
mu_table-&gt;ecc_table,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt=
;adev-&gt;dev, &quot;Failed to export SMU ecc table!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_table =3D (EccInfoTable_t *)smu_table-&gt;ecc_table;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CHANNEL_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_lo_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].ce_count_lo_chip;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_hi_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].ce_count_hi_chip;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_status =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].mca_umc_status;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (table_version =3D=3D 2) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* still use SMU_TABLE_ECC_INFO index,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * smu 68.55.0 add mca_ceumc_addr variable<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * in EccInfo_t struct to report correctable<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * error address and the table_id is not changed<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TABLE_ECCINFO,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
mu_table-&gt;ecc_table_v2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; false);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table =3D (EccInfoTable_t *)smu_t=
able-&gt;ecc_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CH=
ANNEL_NUM; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;ce_count_lo_chip =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].ce_count_lo_chip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;ce_count_hi_chip =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].ce_count_hi_chip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;mca_umc_status =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].mca_umc_status;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;mca_umc_addr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt=
;adev-&gt;dev, &quot;Failed to export SMU ecc table_v2!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_table_v2 =3D (EccInfoTable_t_v2 *)smu_table-&gt;ecc_table_v2=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CHANNEL_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_lo_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].ce_count_lo_chi=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_hi_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].ce_count_hi_chi=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_status =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_umc_status;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_umc_addr;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_ceumc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_ceumc_addr;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index ae6321af9d88..af2d84a16f3e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -552,9 +552,11 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;hardco=
de_pptable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;hardcode_ppt=
able =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;ecc_table_v2);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;ecc_ta=
ble);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metric=
s_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;waterm=
arks_table);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table_v2 =3D NULL;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_tabl=
e =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;watermarks_t=
able =3D NULL;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473FC663AE752AB2C3C284D82D49CO6PR12MB5473namp_--
