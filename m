Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63673C43458
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 05:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061BF10E27B;
	Thu, 16 Jul 2026 05:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gici5ZPw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751B010E27B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 05:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YF4lyebpR2LVetyW5YyH15k0PVmAKr80NRVzONUmcH/823mauW8qUx0J4+KIwXqCmC+jpA0E2zMp25BDW/QJ7R9M+Y8aN2JihUuFQ15DfCUqyCtoXQb/6EuGJFvwdmSI9JeetGXmkWwpWikOJoRKG5R+YWM+u+FhICwKpDwQrbEeJGaIG1bU7zonOwKvneWzvyLqPcL3/x6WiBkUNQd2Av0MYHPjPIDJA5u+NzJ13ldh66Xee26LeZ3NP5lWyUI5GDxclnuIZvqDBUNT4zZxbfWdkXKmdyyXqQksIYuXLHBiSHe/Ae/OeyHYeR/OrZncgAFueb3Zf0fh6mXLpHQkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEiXrHzNmQ31m56Blu8Eo4vnM0qBQ+LR2efL8yMOeNs=;
 b=NrlqMab01cxTF9MGR0C+YwMSBRNN3CiiVv+jfO8GnMmdzDUX6Rp22EpqIaIu0lQ/AU5IvVhxOq9Doq+VKPiEKhfJAuCe+y+/ds9nXqq2j595pd8/wgPWzpgHGjpWnRlc5y9DVhpZz3Hm2oVQve4suqwgKnhnoJsAdGCLkQhRx3oCg3WeUkKxnQHPyPNiU4grNMlZJ93efjjsHXYnf1FPttNz8o0OrivU+46RHsOYYlLscuUlEPzZJLqHznseIr6Nw3By44/QOrb+bvt5Pl4jVxdUF6CesBKP7dz+iWgt/dK0F765xqhy8EXkg7yKiESvKageEm30NsazGT3q2Dyv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEiXrHzNmQ31m56Blu8Eo4vnM0qBQ+LR2efL8yMOeNs=;
 b=gici5ZPwm1Tou4fTpfZKA6IyZVYa6UdgF5kNTvLi4TQzxGKqAnyep78nTkXWbL01jc72oOtXa8I0Ir8h800SGVw7YLr0zpi/2EUdOw3lOWXZG+DA6RCn5OOh5jHEREeJO9SK38aaUGONacK4A3rbn6mqyCVDdGbB67yGEpioCU4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:25:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 05:25:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/5] drm/amd/ras: update flip bit setting for uniras
Thread-Topic: [PATCH 2/5] drm/amd/ras: update flip bit setting for uniras
Thread-Index: AQHdFC5ELAFlTBoApU+2tWflI03Lf7ZvnrMw
Date: Thu, 16 Jul 2026 05:25:54 +0000
Message-ID: <BN9PR12MB52570B62A62B809F04DA8858FCC72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-2-tao.zhou1@amd.com>
In-Reply-To: <20260715074734.2668631-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-16T05:25:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: 1aa62df2-8a85-44b3-1303-08dee2fab524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: ffgbnfENs7YRCIFZj9B11yCjOI7+f55ACxVLOuwhkSXx5IbEpWK4PRWkjEZIYAmcI/AWfCpovNlhgH1N+qex4p9t1w16kdFVlo5m287EhflupV8Fg1MyX59nH0GEyJDbkiybGc/Cph+NEfbo8ELnTtCZg1b5oGNR92nMueHj6+tLu6NRpf8ZSVhaZpMv08UVqtoElf4an6ZFN5WAH+fXNuOaaA4wbVO68Cw4BjwYImhSyHG+CNraIGORkStsRIGltwXmw4D48aUUg7rT9PdsFOx49SopdpC/vVOCjVlRkoR1QO5JY2VuutABwIoZBmIwiTe8sVrl6wOheeTBbng1eftWvFp9vuvswwjvdvYt2pgol31JM1jVVRrBBlcks9+VzDry7GY9uIpEaXT6bSQWuSlOklJOrs7u7RnKTw+wSMQMAKY2lpWNqKVm8riRKsrl6jW6MFmDaB0jRfJ2+r/MYtUDxk1o5wyLUScpAdG6goTYBaKkkGryRUW1+dqVHYc8mBKZzD/tLP1M42qZvumWe9ikntuN12dluVgQh/VCZiAM0L/UCSeugpa1Ri2rF+Ugp3QxG0CjhDxI7sM+rh18anRKbcqvTekiQdUWJ2wiDi+VayNtdcuwi20zicvHUwNL3y2I/HcG/fPKnPK+zgA0OM7K0yXAhxqacuXMw+7OIzUMCfZxIRqOUGU/wOY4A3nsCAv1+cW1c0i6bJT0Kntysuuw67Vx575v/4Bo5AMwPA8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cK5MhmlHWAuPlhDUp4anSziZCuV+TUqaGqAQLP+pS+OXC3ILPa+V07LUKcVg?=
 =?us-ascii?Q?jE+KcINmReteCk0uNvuwoMLi3WNiFhFtfVky+hJ4ecKvmOPvVd+bqyszAS2Y?=
 =?us-ascii?Q?lITEsEOlSOL5wvbcCz+4WrEhkDVDlYorjx1YNvTQ1uyoE0Eci5Nsip7lFySO?=
 =?us-ascii?Q?idC6IXv8Kv4V3/O2XFVSB+BnvbUJ/uvhO8JL1CrP5pjefEs6uGSuEYaNpdbT?=
 =?us-ascii?Q?lWgMg4lsqS7CNf+1eBvdoWWnfF4aOjry4/sJXsenmrz5RYq60BUkiYXOp6pZ?=
 =?us-ascii?Q?AvKRI82y4wvTKjoEQtwlN+zGSsdejcDiA1j7qykXH4LxtvUlB74L9dzHSffl?=
 =?us-ascii?Q?fHo6vqpbh56qe1ccFc+seRtA+XBHxh7VAq9A9tILApuR8/jQkJt9vc35HG8E?=
 =?us-ascii?Q?/4YfZI9qZ97maq9rQapuoyfH1ts2vcvXIfxWIexq8OvOad/QOlnPQVnnE0u3?=
 =?us-ascii?Q?h8by91v+Vg0k95MG0bo+/qSkTGCTCLZWryn8haA9wMCgnotu4oBJYx0asdZd?=
 =?us-ascii?Q?0km93Ow/QD1/AYEsWTVhrNvcPm47A4va84hSHaIQIQ2S85Ni6pst+hxv9+HP?=
 =?us-ascii?Q?JJ1B4YT7kWfwipurW+aXgc1l9eZTCmle7f3MMdc2d3cmeFsZg14gPrulGani?=
 =?us-ascii?Q?fYVUPygKGVSS+efWAvQWT/7oZ3EEsQZo01nRazdXIIYiTW+LQdMEPqB+1UNQ?=
 =?us-ascii?Q?3DR59i8wkm3iDQnHIO1s/CRc+sJ/TQ7V7UDq9dibPS4Zi8zxM+ItgcX/j/Mj?=
 =?us-ascii?Q?0vQC9z5WBOeH+MA1wAFq15twUwP8xBLLFVrgZqt/txAVkCMlfgjS/+qfE64L?=
 =?us-ascii?Q?eKp7uhY/dq+krqRWphn++TKpIsORue6UdH8/qRXqzZn/DQeUvO3dnFZkaRtU?=
 =?us-ascii?Q?AuyyGtYT8cqyQq0jr66CPe7TvAdCdXAtM7GtEfYTK51kErzZ7Y2yN30zO116?=
 =?us-ascii?Q?3n0hNKlkRaZABIfEosDezlX5JEvrlZfqnlfGZzqbpIvDESPFi4qWpMAau8+3?=
 =?us-ascii?Q?r3k8fj+WpuHMemf35irMBkH1yj873J2oMDWZNc0CFvLsqrsTdp9LqITMWTjw?=
 =?us-ascii?Q?9T1aoFxz6MGAT66jTIQQr9jqc5Pa/9Lp2Lo8rEMZEBEcUCl/ltRPe0eRc046?=
 =?us-ascii?Q?su6v4nk7Z1fvcCpmp8ubuzoM4QiMnSZjhtUAaiDsbkeJ67JuIEVcPJCSPErZ?=
 =?us-ascii?Q?HG5Xv/Lsqk/8NdtFd1rew294tH+8DqwyVyfO3G12lV/Vv1yagEPak9fgeQje?=
 =?us-ascii?Q?jY8xyr7117Zwpi/eXNAfn6tataEaNRwPKsRZ26pMVXnRajMslTAOuUvJ/K+N?=
 =?us-ascii?Q?ySOsHWiWDFEqg5CXV0JICF7X4WzxM7cK2owwl46jXdtWWde/iHOeiVa/Ooqj?=
 =?us-ascii?Q?1JLHeNkkTO1T1KypbucQbzJmDljL4rlrQ/65yzZOiIJkTaBxpNqyHlheiaM/?=
 =?us-ascii?Q?nh2CvUxSKra36uRxYkPJvtaCbgTIrcPguX2PrYtU2WwkDJhG258HyxT983QV?=
 =?us-ascii?Q?CV5VDoU26o6++Sq7eoV49Gi5i7WwODpzucI4m6aZzKRxGagzjyL0vKWptpNG?=
 =?us-ascii?Q?kVzYmhy/bl1SqZrLUOXqsBteH+IW3UbgcjyqY832v10VAkg9gV191ig30sp1?=
 =?us-ascii?Q?3NcAXDMDaRwWrQRO65r9/UNkoe3nJUdJRLgZGXJA46jWFtYDVNBOCpKBxrG0?=
 =?us-ascii?Q?0AblNfwlk2c9pPJ9tKX24bPH7ZXdocLqRkTxTpLpWqyIX+no?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa62df2-8a85-44b3-1303-08dee2fab524
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 05:25:54.1654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os7vh/CQVzDKYNdB0CXHGAEuX+4MXSLR888TVBVsAj+/vmspev/KnV8viKrmnNUcRkNdFc4xTMh92DQsK9lTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

AMD General

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, July 15, 2026 3:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/5] drm/amd/ras: update flip bit setting for uniras

The flip bit setting is different if umc number is half of original configu=
ration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h         |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |   1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 114 ++++++++++++------
 5 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 60412da69b2b..c55288c2df9a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -284,6 +284,7 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu=
_device *adev,
        struct ras_umc_config *umc_cfg =3D &config->umc_cfg;

        umc_cfg->umc_vram_type =3D adev->gmc.vram_type;
+       umc_cfg->num_umc =3D adev->gmc.num_umc;

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 5869bad978b0..5719bc1b6167 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -277,6 +277,7 @@ struct ras_psp_config {

 struct ras_umc_config {
        uint32_t umc_vram_type;
+       uint32_t num_umc;
 };

 struct ras_eeprom_config {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.c
index e366fb97293e..dd7a37163110 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -691,6 +691,7 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
        ras_umc->umc_err_data.umc_nps_mode =3D nps;

        ras_umc->umc_vram_type =3D ras_core->config->umc_cfg.umc_vram_type;
+       ras_umc->num_umc =3D ras_core->config->umc_cfg.num_umc;
        if (!ras_umc->umc_vram_type) {
                RAS_DEV_ERR(ras_core->dev, "Invalid UMC VRAM Type: %u!\n",
                        ras_umc->umc_vram_type);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.h
index ee7100f25f51..71b6703193f5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -137,6 +137,7 @@ struct ras_umc_err_data {  struct ras_umc {
        u32 umc_ip_version;
        u32 umc_vram_type;
+       u32 num_umc;
        const struct ras_umc_ip_func *ip_func;
        struct radix_tree_root root;
        struct mutex  tree_lock;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..809cbd846883 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -64,51 +64,97 @@ static void __get_nps_pa_flip_bits(struct ras_core_cont=
ext *ras_core,
                        struct umc_flip_bits *flip_bits)
 {
        uint32_t vram_type =3D ras_core->ras_umc.umc_vram_type;
-
-       /* default setting */
-       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
-       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
-       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
-       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
-       flip_bits->flip_row_bit =3D 13;
-       flip_bits->bit_num =3D 4;
-       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
-
-       if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2) {
+       uint32_t num_umc =3D ras_core->ras_umc.num_umc;
+
+       if (num_umc =3D=3D 16) {
+               /* default setting */
+               flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
+               flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
+               flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
+               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
+               flip_bits->flip_row_bit =3D 13;
+               flip_bits->bit_num =3D 4;
+               flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
+
+               if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_B=
IT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
+               } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
+               }
+
+               switch (vram_type) {
+               case UMC_VRAM_TYPE_HBM:
+                       /* other nps modes are taken as nps1 */
+                       if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R12_BIT;
+                       else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;
+
+                       break;
+               case UMC_VRAM_TYPE_HBM3E:
+                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
+                       flip_bits->flip_row_bit =3D 12;
+
+                       if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;
+                       else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R10_BIT;
+
+                       break;
+               default:
+                       RAS_DEV_WARN(ras_core->dev,
+                               "Unknown HBM type, set RAS retire flip bits=
 to the value in NPS1 mode.\n");
+                       break;
+               }
+       } else if (num_umc =3D=3D 8) {
+               /* default setting */
                flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_BIT;
                flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_BIT;
                flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_BIT;
+               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_BIT;
+               flip_bits->flip_row_bit =3D 12;
+               flip_bits->bit_num =3D 4;
                flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
-       } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4) {
-               flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_BIT;
-               flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_BIT;
-               flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_BIT;
-               flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
-       }

-       switch (vram_type) {
-       case UMC_VRAM_TYPE_HBM:
-               /* other nps modes are taken as nps1 */
-               if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2)
+               if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2) {
+                       flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
+                       flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
+                       flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
+                       flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
+               }
+
+               switch (vram_type) {
+               case UMC_VRAM_TYPE_HBM:
                        flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
-               else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4)
-                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;

-               break;
-       case UMC_VRAM_TYPE_HBM3E:
-               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_BIT;
-               flip_bits->flip_row_bit =3D 12;
+                       /* other nps modes are taken as nps1 */
+                       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R11_BIT;

-               if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2)
+                       break;
+               case UMC_VRAM_TYPE_HBM3E:
                        flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;
-               else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4)
-                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R10_=
BIT;
+                       flip_bits->flip_row_bit =3D 12;
+
+                       if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2)
+                               flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0=
_PA_R10_BIT;

-               break;
-       default:
+                       break;
+               default:
+                       RAS_DEV_WARN(ras_core->dev,
+                               "Unknown HBM type, set RAS retire flip bits=
 to the value in NPS1 mode.\n");
+                               break;
+               }
+       } else {
                RAS_DEV_WARN(ras_core->dev,
-                       "Unknown HBM type, set RAS retire flip bits to the =
value in NPS1 mode.\n");
-               break;
+                       "Unsupported UMC number(%d), failed to set RAS flip=
 bits.\n",
+                       num_umc);
        }
 }

--
2.34.1

