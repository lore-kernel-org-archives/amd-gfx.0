Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC04CD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 11:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1629C10EFCD;
	Tue,  2 Jun 2026 11:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J9O1mENV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F1010EFCD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 11:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOIiMxZPCmCrEclBlplFbDSLz1BoYExn1cddiOA988mq86SvYVR3W+7Kx7ijJ7QvIm4/3UtFQdCdwm1OvBhaTuYZuVZHbvjRRegXGP5cGIIR4NG61GCSWYE6IEOGAj1ca+33CaEnEU2oONiErqL2LybRrMmNw7jWpBKINzdoWCUkI75Wmn/8boAJteCQSUU1rZFrS5MlDysO/dW1LLjN/mueyST0+ffJUBPSZ8ZB0nI64UL0xDNJfr38Mc8U35D4EOrbM6X+V8TUCTnnVkQgWQyyjO3XTqrWcFr5dcjYDX97WnRr53YYa4hS3LMExq3c7K1JdAq/JLs+7F7YEMlVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ+fuqyudzHARX3e06sLro9ww9i7Y1i2Q3GMlV2k2qg=;
 b=Oi8vR6ComhOCKAe8h0hbuauFZ5e44SEvPf71RNVnbfPvVLm2SK74izWm862aputd9Wu2X20UyNzgqPoLpMiYKJiHSMNpDENSMJtydv7Tdpje+pYO/c1yLZoCnH63YwzaIPJ6REV4Opvk9Z7dgC/1oVEO00J/m1bLo7FhYehYo3g5V49+R9Ui2+aUu0qyCP+o1/KxRBpV1rioAjgeXZyQPQcHQ8PvaWN671ZOVvpHUEuy+HXLPLJbSqBQI4FirPRyB+WLXvH1ahhuxnQAnQU5BKvK/tQxnEuT3x3fEf/jC6V3sqBvn5DKNePcL6czaDwc5YKA3qfHxDzf8NNxmSvCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ+fuqyudzHARX3e06sLro9ww9i7Y1i2Q3GMlV2k2qg=;
 b=J9O1mENV1wE4bDbXbYHd+8ViS+/PFvawQAfabBjjfrP5vBCKLGSzNSjU7bDSY4vjurF4MzXiiE2T8/hbVSbCvqjqiLJX+WY5FKLMoW30sgRIWy82Lp8luF3iucsripvkNAGJKfHNvTWUE2ZugZqXU9JCdbwp8zFPs0o2cKx1WDc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 11:47:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:47:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v1 2/3] drm/amdgpu/ras: Add IPID filtering for bad page
 recording
Thread-Topic: [PATCH v1 2/3] drm/amdgpu/ras: Add IPID filtering for bad page
 recording
Thread-Index: AQHc8mvX674S/X6LqEigQNrDnZ0/wbYrJf2w
Date: Tue, 2 Jun 2026 11:47:27 +0000
Message-ID: <BN9PR12MB525717144E03F76335E9A648FC122@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <cover.1780389586.git.cesun102@amd.com>
 <76f8d336fe220b3a4dca7f0bb2da09c61233c802.1780389586.git.cesun102@amd.com>
In-Reply-To: <76f8d336fe220b3a4dca7f0bb2da09c61233c802.1780389586.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T11:46:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB8602:EE_
x-ms-office365-filtering-correlation-id: 313f347a-2fa2-4145-111f-08dec09cb8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: mgUi2i8G1Db7zgso8biQeMkcJJGczRKA7SwPSffJzB2gDOfYa/ghFQWtIA+QniFkNzH3OakaxHOCRkrtlsTaa36eh/YcVMy6YKrh3gFCKAW0LFdThQgqury/itQyL5b9P1ThtFu07hSC2GnMgkc8ZMa26haLIW2gURSHIzMyQdsXszbBD2a+74SteDfHBKTveFZjYcB38qedyFRnajxI+a7j6FSp2u7PhRoGWMUQE0VPWHjdOB5B4QsjvZUfFHjUS3+OQBcm5+5v9ksHxaO4AXN6VWxW6cPVwSO67D6Ht1NZDYMURmhkzP70yA/DBgByDM8kvwCdyeReFYZicmlgHBnOifgsfWxWSz82Xwmj7vrc8aMmGSuOCT6EqP7gSOOxSPytrWogpMgOdlKZfgWbE2w6f5JzBmc+KnDpuFIpY/zJ9U7j8amUzdTM1LMnvt3NM6qezQMRW3QCvW1/dsDiFSwftY4oGY5meazswcdZyOGeXCW8Mq//f52fM6UctgBvocKwcIHVBfs5kG0KG28c6czeBAPe31xusvvz1hOmEfmPjmPY65UMcpaqxzwd+RF4ragUZhRYLp4oTHa3fzAUVOBGTl0HqDM3gkQFdKlYfXCZFVkO/i29jslRnRNuc6t+BsQqefZVMY8cKEIGYZ2AFpAD+2NSmElQZrtV/xX97XvLu1jbrMtGGPA9QA5mkcX5WeDKcdmbVyHPG/Q++KYAChZJ5vqVzyG9vufoutGgjp7cNc2ts5H8wI1ZfAY8vmP4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wpq6ITGfhPEdBjshNwmVeAggN+3x535HO8JDZQcs+5KcKF8FzPoQcsAAhN4h?=
 =?us-ascii?Q?dnk/GXknQchbC9TRnfVtjV9aP+vtXF+KbtQ67cK2WRfK7tlsdqtQeSx1fhWR?=
 =?us-ascii?Q?INS/OKhq1pr7x6LbisIEVB1OEEc/22URudr8qylwl6rJoBm/7PDgAFNRlHrP?=
 =?us-ascii?Q?m3nZibUg669EM3S8/krbaG3q6PUxXpnpJPODM19mpiUZtLzzKibKHj5pcXMX?=
 =?us-ascii?Q?tYRxFm/87s1jSu4iXPHh6huU2rRjWBGEPdE+3fxFodx73/KFTTu0TUaeeUs7?=
 =?us-ascii?Q?2y2mSJQx5q1pCvi/GDytOQ/9bM1eZQPJa+zk/ZwAdRw4wqDtrWimBBtJM+/s?=
 =?us-ascii?Q?+HIOU90mWnuo+FFDmEjgqhV+e/a97qvOm/tXLAO3/CSGa9pNFCYy3z8I51Ge?=
 =?us-ascii?Q?zwCYA1myj7NPfNpfPvRqcxm9CkBxEaagSJar9AE2ATV1GJ0cLn/1azuzRNwh?=
 =?us-ascii?Q?GYoRXyqFdzpUEHL8i/aEB+DXZvBcStIXmuPbG245s+UzfJKcsTA2qxMhlnIj?=
 =?us-ascii?Q?Enon7RwHrBZH3MmZ8NHUoevzpFuVhuQ8iU12akJXEr7s1LTXteA1MZSYWBSs?=
 =?us-ascii?Q?V6MAURAIzHOZWOnggPxRRoh+kKhifcaXtUftc8NHGpFAXtZCgyXF9F57I6hm?=
 =?us-ascii?Q?JQxi3DM1BkxWjDJurGLbgE9vgfQYyKH/kyq1na70hX0KvXRJKjbpTh4AM4Ly?=
 =?us-ascii?Q?4eImSReAOxatHs3BUMgcAoF5fKOAdEsTwdNLZB4YILb4dDWw1X3mj5NgpH1c?=
 =?us-ascii?Q?a4s0x5LoPY7nI2xVRt6LtMWnZZa94KFq69Xe9QPIpUMhqqQC+iK1jkLnoFD5?=
 =?us-ascii?Q?nB16zQP3T2lVF1qPwdAldvaEm+1KyOU8f9OS9av4s7ZcazU5LOWUrxUKiJ2C?=
 =?us-ascii?Q?hjcvUym193hWiAhAP/HuoY16eL2aS3IlAYNTcP8B+6tlZEjW/gRi2RcsAUfd?=
 =?us-ascii?Q?GGYXyajk9KOTd3WuNo4zPea+s4EWAJ/Cqc5l8SzgrhmJlKXvwWevuWsWvctM?=
 =?us-ascii?Q?fdV7lOzZG50lNdnRcJtwxuH+0B4l0INUgwO4vLVyR8rrk4KdDRLbIHZgtun/?=
 =?us-ascii?Q?JIEeLIsMahzYvSbafK3HKebtcmcPXqGoXcYwDPh6UHicV3jUO//7jh0gUvMF?=
 =?us-ascii?Q?GgXjY8PnnbC5zRtuv6l9RTxJFEuR5D4bBVT26PrAg7FzMVScSmdkxIBePtxq?=
 =?us-ascii?Q?e67+5eqiRsifainnUal1WOmylGeS+lbt31c8Jg7fcqswYH3HpKvubFVpKBO/?=
 =?us-ascii?Q?tE6UhXQrviU+sUtjLgNavyBFAC0i5gfDOqZ4+bpHTbJarIs/Pw1Gc/pF1B+U?=
 =?us-ascii?Q?S/UzflqCo+MdAccEhnSsv1PFJjiweXDJkSy+bKN1ua3Pfyj3j8oZG97D1do2?=
 =?us-ascii?Q?SxM4z8LQg6Z0gPEfZmbbNcR0nFjOCP2E13wMps1nJidAexhZuYkGYXixVkDs?=
 =?us-ascii?Q?Xcfnj5ioTXrc6RyGda5w0A8E3sqy36SdbYJtjqmIaDpP3jE2sNsrdyH23Eg4?=
 =?us-ascii?Q?boZwRcqzFTiq3MeNYhyUdvn5aNov1uR991A1CrLKoPmK13nTQcP4E59JBZPC?=
 =?us-ascii?Q?OWfFbesPNXZEra6tSRwZwI0aYacw57otC157wNNwCjw/aIO1cSTB7Zlf4l/Y?=
 =?us-ascii?Q?Rqaux3Wk++J/gUBP/LYt9otsbkz42aIcYh0M/kzJDYysfCkoLLkx6+k9X2rI?=
 =?us-ascii?Q?9PeoBkFUGVQ/hAC0eVveyvjABxsnZQzfDdPaQ7X95VGmWa2S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313f347a-2fa2-4145-111f-08dec09cb8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:47:27.8665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0qNE06EGrWK7dlDda2KfVMb636zx9lUHCr4C63vr53rNuuKuvXfQUeDJ3q++GWgnVtUJx/1fE6czQ3bbe5Y1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
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

+       /* The IP block decode of consumption is SMU */
+       if (hwid !=3D UMC_HWID_V12_0 || mcatype !=3D UMC_MCATYPE_V12_0)
+               return false;
+       else
+               return true;

Alternatively, you can use return (hwid !=3D UMC_HWID_V12_0 || mcatype !=3D=
 UMC_MCATYPE_V12_0) ? false : true;

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, June 2, 2026 4:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v1 2/3] drm/amdgpu/ras: Add IPID filtering for bad page rec=
ording

Add IPID decoding macros and filter out SMU decoded IP blocks

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     |  5 ++++-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 20 ++++++++++++++++++-
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.h   |  9 +++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.c
index e5971c3dd7da..cff6245d8add 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -270,7 +270,10 @@ int ras_umc_log_bad_bank(struct ras_core_context *ras_=
core, struct ras_bank_ecc
        struct ras_umc *ras_umc =3D &ras_core->ras_umc;
        struct eeprom_umc_record umc_rec;
        struct eeprom_umc_record *err_rec;
-       int ret;
+       int ret =3D 0;
+
+       if (!ras_umc->ip_func->mca_ipid_check(bank))
+               return ret;

        memset(&umc_rec, 0, sizeof(umc_rec));

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.h
index 237525b46b9b..4a693865a9be 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -110,6 +110,7 @@ struct ras_umc_ip_func {
                        uint64_t soc_pa, struct umc_bank_addr *bank_addr);
        void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t =
ipid,
                        uint32_t *did, uint32_t *ch, uint32_t *umc_inst, ui=
nt32_t *sid);
+       bool (*mca_ipid_check)(struct ras_bank_ecc *bank);
 };

 struct eeprom_store_record {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..a272e0d80cdb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -356,11 +356,28 @@ static int convert_bank_to_nps_addr(struct ras_core_c=
ontext *ras_core,
        return ret;
 }

+static bool umc_v12_0_mca_ipid_check(struct ras_bank_ecc *bank) {
+       uint16_t hwid, mcatype;
+
+       hwid =3D ACA_IPID_2_HWID(bank->ipid);
+       mcatype =3D ACA_IPID_2_MCATYPE(bank->ipid);
+
+       /* The IP block decode of consumption is SMU */
+       if (hwid !=3D UMC_HWID_V12_0 || mcatype !=3D UMC_MCATYPE_V12_0)
+               return false;
+       else
+               return true;
+}
+
 static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_co=
re,
                struct ras_bank_ecc *bank, struct eeprom_umc_record *record=
)  {
        struct umc_phy_addr nps_addr;
-       int ret;
+       int ret =3D 0;
+
+       if (!umc_v12_0_mca_ipid_check(bank))
+               return ret;

        memset(&nps_addr, 0, sizeof(nps_addr));

@@ -524,5 +541,6 @@ const struct ras_umc_ip_func ras_umc_func_v12_0 =3D {
        .bank_to_soc_pa =3D umc_12_0_bank_to_soc_pa,
        .soc_pa_to_bank =3D umc_12_0_soc_pa_to_bank,
        .mca_ipid_parse =3D umc_v12_0_mca_ipid_parse,
+       .mca_ipid_check =3D umc_v12_0_mca_ipid_check,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.h
index 8a35ad856165..51459b5ec06e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
@@ -287,6 +287,12 @@
 #define ACA_ADDR_2_ERR_ADDR(addr) \
        REG_GET_FIELD(addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr)

+#define ACA_IPID_2_HWID(ipid) \
+       REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID)
+
+#define ACA_IPID_2_MCATYPE(ipid) \
+       REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType)
+
 /* R13 bit shift should be considered, double the number */  #define UMC_V=
12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)

@@ -306,6 +312,9 @@
 /* one device has 192GB HBM */
 #define SOCKET_LFB_SIZE   0x3000000000ULL

+#define UMC_HWID_V12_0     0x96
+#define UMC_MCATYPE_V12_0  0x0
+
 extern const struct ras_umc_ip_func ras_umc_func_v12_0;

 int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
--
2.34.1

