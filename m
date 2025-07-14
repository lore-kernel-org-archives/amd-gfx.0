Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E2C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 11:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AEA10E0D9;
	Mon, 14 Jul 2025 11:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0+9XGzH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCFA10E0D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 11:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGV8f6Uc6d5kAK7Wb9xlZ6gZ89Gun49tvuz+rg7yk+6E8HdvhBwC+P9G3rkd0bPDPB2nXk962iks+/g1t1jGTqPhBPHPyFXEjXNDjn45JmIWOfwpezujqxgusmJsoHNwxSmfQOsdD9PJXvDKlW/m2+F36r/lD07VtMaLTrYRT5pv2bRaQKWi9DCBONEufbg4HbCkqAjIu/HRM7Go8ADywdmHEfix1E/cqeH7PSeX32yBUM9TSb/5aHDmlbFHMBym0x1A5y7R3hd9dD18gdeCMZWJizn9KkT0F7p+yPr0AWsm/K9jKrHPtRuT0R1pIsR2Exa0hzhnKhxj0PIl9w7viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8hY8VxysZJIpfnwnc2KCi1xcSDmzR+8Mmgltuhq0+I=;
 b=HnP03stH/87cp5lZwZTfZ2COwaGkKJ2SczZntjZhwD8VMHnwZUMPJ3kwdPmpSAO9SFTvXr/zLXz0s/mt+psopAmsOAkTpAoHqvVB4BnB687AgD0HAtCh6a5Cd9/7DhzXqWj45JGwz0Sc76EK46j/s+/V4na3m9b8gSvK7OM06voYMMtnRUO8OY8Ckj8KLuxa6ax1nZSfFwd7yJ1dWzsGyRFsbPVdVWiein98uGqUnK5hDAXAYhSM9zqMI4nOL9BNN3GwnyUVhae23ZDJMuGGRkMTk6fM/IyRsLLxJdHBwt+yTjdcpi7Vzp9mlxnrnQFzcyWuWksIHYoEdWEQW+7DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8hY8VxysZJIpfnwnc2KCi1xcSDmzR+8Mmgltuhq0+I=;
 b=V0+9XGzHTYX74bYK3k24jpRbxCNQfoM5PBxihb1Z3uKw6WAuz6XHOWxXF88ATEpqoKPfhUoiXwZ/XPaYjzkIJ165+2ogP6+DFNPI4OGkYaHhmROXAg97xl23fBTJuktcbaR6HGAGz6s2NaIOsS9QwyDZc69Lmsv+mB22XR4uphQ=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Mon, 14 Jul 2025 11:05:52 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8922.025; Mon, 14 Jul 2025
 11:05:52 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Use cached data for min/max clocks
Thread-Topic: [PATCH v2] drm/amd/pm: Use cached data for min/max clocks
Thread-Index: AQHb9G9njqj273d8vkSIaj5ZG+6OWLQxdZ9Q
Date: Mon, 14 Jul 2025 11:05:51 +0000
Message-ID: <DS7PR12MB6071F9E673DDAD7C8FBA956D8E54A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250714032825.1512229-1-lijo.lazar@amd.com>
In-Reply-To: <20250714032825.1512229-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T11:05:45.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS2PR12MB9710:EE_
x-ms-office365-filtering-correlation-id: c2e62df0-526e-49f9-6be0-08ddc2c66596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GrXx1Kl0n5IeWXz8vsFgBJdjtiDHtvolDOpl0l3lNPwnzhKcDa5a/ZkdInl7?=
 =?us-ascii?Q?M/EMgoLXn9+LDp/iPJZbVfCaPf9S61ZTj0pqr9Nbo1xkgUv7GqAVhaKcnFPD?=
 =?us-ascii?Q?6qjsPjNQKF/8AQoppebuHo0/1EowiRuUH3IfOFSVK/nn4SRG3iYB42gYngoG?=
 =?us-ascii?Q?6z0x/U7QL4YGCUgrUK3wsiw3Y+Czh6QT++eVHUxBmmT1tA1t9Uk0W3g1syeC?=
 =?us-ascii?Q?LocNs1TJqK1fShnQq17h0//dlt2LdKLVCZVJqb0mfl4AXlQ8e5MfPeiMWiBk?=
 =?us-ascii?Q?DVTpwmYIdpRRN/9Iid54J2iaibw4IF1Ry477i90u+qY8rsFB9VEKNC8NVyLs?=
 =?us-ascii?Q?RfnAf7t0hljS9hH/e9DqkW/zdbeq3w1SaDMBtkYXwPQ6pmXI5nqA7WRP9FBr?=
 =?us-ascii?Q?0F6HfPfLiYSVzHMWqMJr9Lz3VnqLG2wHeEh78AINjxdWUEQVWdolsBvOQFac?=
 =?us-ascii?Q?fQEMJPUOdbLOd8XLdgoPOG8uuMDANMyiKOG2TTD9bFwtXxBMUeGc4a+Pbl55?=
 =?us-ascii?Q?JEdqJv7X+1JMiYimxqw4wPzT4Rq69ZSAscOxZRnlaFT5KHD8ZF5apAzg88cJ?=
 =?us-ascii?Q?mSDi0TBhULEFlMtrSNZjtdDYGEucVUy82FCaggMHAwKwyJSeb1aBJSTuJNJq?=
 =?us-ascii?Q?HHWBNF/dnBxpPUdFk56ULdkKMwkQVuPJRLCxo7Zk5irSNaOsIT4i1hXrBudo?=
 =?us-ascii?Q?1MR6dthGOINzvqejX4a/d2PHCw0/G3vYB+FV9eK3Kin/RCYSLFvNdkXOxq7g?=
 =?us-ascii?Q?d9fGy3cEI/chwm9018va7o5rVizp+Rz1CGsoFDNkfMd9qu3hKRmsJ2p3kOQh?=
 =?us-ascii?Q?mehfMqcoHtdXnudKC/t1KPgfz25fBIn/nsV8UGXo+kipPU2gwU93hq8dl6t3?=
 =?us-ascii?Q?D8OplaCYwlULaBMlC3HE9Z/kNro0vkhZkneWzeTKW0XE6nWoddi4eQ/OLu1r?=
 =?us-ascii?Q?My4bzbXdl1KEpaWgwAkjNLN9I5E1gfXgQ4CBsHc0cGBKeZ/zj7ERWUG6hA3z?=
 =?us-ascii?Q?jHUrifQi217kqrNdpsgv8KRtiVem+pVqeqmwOsNRPEmPm0HVXxlmfILlVbXp?=
 =?us-ascii?Q?ROP8c7qxC0z8o/oLLy5PXmeVYMEOH1Sy13IvpxsbVfJ6A8YhtEzwaWHKMbK+?=
 =?us-ascii?Q?w5XI5owCd+atMief9i16BQTJJflq0n8jkULDIgIHHN+CJSiNPnxVH7409tAe?=
 =?us-ascii?Q?b6eqnmuuOb7ChSEnc4IvwC06MA61NlWP50m09pLrvKyAnAtRLNeBk9hoB6Sb?=
 =?us-ascii?Q?zwgR3SbT2vJHqhmhilmgV4y2ez7tQ/T8faPPVrP0TT5Vslf7INTwiFqIqIAs?=
 =?us-ascii?Q?h3nyVyAVvkrap9hesVI0NZk7AmFenunYx0N4DIyeEQRIvJKZOh6e7/PVXfJ2?=
 =?us-ascii?Q?ilY/Jg5CIWAO6mL2mvCLNSeSEXcpF1ierBFsBCrJbE004xDtvV6MIycVnXPq?=
 =?us-ascii?Q?gqRUIGrJ6za27RoQ6R96YbOAa1GZYETCpDK68y+89L/LAt1qQGPr+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I+j5mULT2bCYB6Gd/dqwe0z8JWrjDuixGfiXAqpTNH4JrnwoVYOjtRE3DRoO?=
 =?us-ascii?Q?FqODfm7OKkPnb7W37j+oIrA6my59/W5Jjlk3OSG996v+F0Yng4yeZGXNbhtx?=
 =?us-ascii?Q?hhsHdG5MUmi2wIGtDgDMqWynYNCeXWhjVhFuXyrYxlgzaSOUqUdLVtVv6qpM?=
 =?us-ascii?Q?5MD20Tlxzpjz88nGbmnd1KixEjAhBAC4hkwf5B/r9dsAroqRJ5K7oex5QrQo?=
 =?us-ascii?Q?ZmUjyVb9/AFxvvROqS9PNp25IMEQJIv72WCBXZVsynyvAhSZlHFgrq2bioIc?=
 =?us-ascii?Q?K9TVc1+hOjGqkOrGb97mYemozZ1fEGVaJ9PP0NEiJLIkH+h+aXsGZVWeClGK?=
 =?us-ascii?Q?pR//ARXS72PaA75YLh8/vNLG+RiTqNIoDye6BMt3BS1lo/sG5ottwd/yuA1g?=
 =?us-ascii?Q?t7NStv/qSrc9bZXqIKiSDLqg43ZbAXUb5uhPLY5RlWsNeLLLh5BpQgbYFGHF?=
 =?us-ascii?Q?M5sUNX/LmGbbhyTELGDSKsdb/tXNs5inT3/A0/UibKPEBvlgWRAq6FDk7yqw?=
 =?us-ascii?Q?CUKt0JW0tXju9CScSDekaYjdkj9YADOtfZBr4DuvPVc3zcPVuJ+3HuS6Fl0V?=
 =?us-ascii?Q?tmcSRxBt6JCs9+mALI9YEmUTgdmwnEB1QbXNvX6Sjbl4U2MJipHac1HyKaqF?=
 =?us-ascii?Q?PWGhTlZ/xYyXZnWF0GX/ti3BsE2zvJ6QIj/VdFQ9rsmY8w/A5uPIJRrAratK?=
 =?us-ascii?Q?7Ve7ROzgf3Df4ngJ9fhCp6u9DqvQm2DWl6abIHO+A776bcDtjKg1mH3wgxN0?=
 =?us-ascii?Q?6+rtwIC35kacc6nleVKS1hrQBIx6Uwtq1xUpgo7pbo+N17tmv2/pmzxkwDtE?=
 =?us-ascii?Q?AlFGhFkdap7DwQFnfgwRBj9QykIztMNGE7AyQqUOevoNsMoCMEUPFtbEIZAF?=
 =?us-ascii?Q?QmgQ1C2NR+Zx1HHYcAmcTFKenBkjk8KWM2OAQ6JfWipYJCQklOz8uvOSCd6I?=
 =?us-ascii?Q?XRP8bo+g1+16VPFZ6GwJdjHQeUiD9dJ0MlFRzWAe6hWVlcAVpc0ZYg0n0HF0?=
 =?us-ascii?Q?z2tH3K3PxYfuRKu532xwtFLD38yhx8EUkAUhX1sNp1/mKAj9AMWHOP+0nG7/?=
 =?us-ascii?Q?KS2mvhGuW9mkW0+kZAPfM60IY0Qd2i8RE4XA/UEIdHmMjf/rOMwNcw7Ed0CY?=
 =?us-ascii?Q?8Dt+YGHmMnTUBJwrabh2ZomZ3p4DN/cbNObVAFrJvJ09PovXOqxbcGRdJQrW?=
 =?us-ascii?Q?3qqSbUaoZmWFIEAxOzKoxhuMKptyMhUNLKE6GIpnIETtL5JyNIsVffhf9xr4?=
 =?us-ascii?Q?hr1sRE2IZdXX3xJ6TJ84BM3e0s0R/jeyv4phmyXfhAL53bLA55kdOj9tJ52e?=
 =?us-ascii?Q?jobm6J8ujG5lo4UD3IrSkq8k5F2jPlGC7ibTAQnt2i9t80f4YT9NLRUoerPF?=
 =?us-ascii?Q?vQrxTNxZ2uRHHVF794LOW06lKZ3EvgV5egLnlqf0AtWyCGk50vurwVq12YII?=
 =?us-ascii?Q?kjYUHJfVYJA8siuCUn8EWrZ5bUbAipgxWJBKuhuRLdC5BjlaG2Fq2vZQ2p7l?=
 =?us-ascii?Q?wZ9aCksQt67h3RwpFbVYD/RVaN2OCw34MkcmODjZoG/3nCi3bzMKav+glnky?=
 =?us-ascii?Q?pi2xxtd+FMhJp90PxIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e62df0-526e-49f9-6be0-08ddc2c66596
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 11:05:52.0006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wPjk4VAhpAVhIG1DF9Gsh6khMrFj9bBGqaqapFAZaRdd37Wd52xAJSGTjwPK6KyFewcIo7FBIO7pXi5YUTkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, July 14, 2025 8:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Use cached data for min/max clocks

If dpm tables are already populated on SMU v13.0.6 SOCs, use the cached dat=
a. Otherwise, fetch values from firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Coding style - reorder declarations and remove unwanted initializations

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 68624afe7d83..f2cf333b2e40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -881,51 +881,51 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct s=
mu_context *smu,
                                             enum smu_clk_type clk_type,
                                             uint32_t *min, uint32_t *max) =
 {
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct PPTable_t *pptable =3D
                (struct PPTable_t *)smu_table->driver_pptable;
-       uint32_t clock_limit =3D 0, param;
+       struct smu_13_0_dpm_table *dpm_table;
+       uint32_t min_clk, max_clk, param;
        int ret =3D 0, clk_id =3D 0;

-       if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
+       /* Use dpm tables, if data is already fetched */
+       if (pptable->Init) {
                switch (clk_type) {
                case SMU_MCLK:
                case SMU_UCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->UclkFrequencyTable=
[0];
+                       dpm_table =3D &dpm_context->dpm_tables.uclk_table;
                        break;
                case SMU_GFXCLK:
                case SMU_SCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->MinGfxclkFrequency=
;
+                       dpm_table =3D &dpm_context->dpm_tables.gfx_table;
                        break;
                case SMU_SOCCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->SocclkFrequencyTab=
le[0];
+                       dpm_table =3D &dpm_context->dpm_tables.soc_table;
                        break;
                case SMU_FCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->FclkFrequencyTable=
[0];
+                       dpm_table =3D &dpm_context->dpm_tables.fclk_table;
                        break;
                case SMU_VCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->VclkFrequencyTable=
[0];
+                       dpm_table =3D &dpm_context->dpm_tables.vclk_table;
                        break;
                case SMU_DCLK:
-                       if (pptable->Init)
-                               clock_limit =3D pptable->DclkFrequencyTable=
[0];
+                       dpm_table =3D &dpm_context->dpm_tables.dclk_table;
                        break;
                default:
-                       break;
+                       return -EINVAL;
                }

-               if (min)
-                       *min =3D clock_limit;
+               min_clk =3D dpm_table->min;
+               max_clk =3D dpm_table->max;

+               if (min)
+                       *min =3D min_clk;
                if (max)
-                       *max =3D clock_limit;
+                       *max =3D max_clk;

-               return 0;
+               if (min_clk && max_clk)
+                       return 0;
        }

        if (!(clk_type =3D=3D SMU_GFXCLK || clk_type =3D=3D SMU_SCLK)) {
--
2.49.0

