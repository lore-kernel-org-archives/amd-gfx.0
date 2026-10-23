Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469DC606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wftyx5dd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80B110E4FE;
	Fri, 23 Oct 2026 02:31:23 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CCC10E4FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 02:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM9OHzSjsJkbULPu6h/XonrPdA/9e5Q3/ahqz0Pq33gYbTcH9qI312sc/jTLJWxik63nvCI6OAniBClwH1DiR423KPcojvJa+yWBrodfOydzJlIJrm8dK6TBHweQ5hX/z9HpbQwZ4MShaqw3OOKRKwp6p2nv76Hf2B1w7tkraXrTKUksBD5vMRxTsTGw0eRYkEUC9UzEjplRv+x/OgC88GrrjhylyilnRtsX9M9Cff72AkXDubC7BLdpdHuxZ8MYOX4QUm+psPaIZOYjA2Wib7n5ZlWM262mMRnzBSgepWjTiB534XIPioAO3jlEK1RhWkC1Z5Tv+Z6BoAUj0d57dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma5Fa4up0QkmcGeIsq2z3MVyBvtlccLV53+p+nTm0oM=;
 b=EMIX+toSwbwuTko0qbx12tepN+0pRS0g9JqFgacromc6oGJCyvRO4nxT60RyMbUb7oMo6fmmTbuXNPV48WaR8GT8Ew7mdKFiWA/U9yWYvCMHnP2uRoIImD5+cJJx5RCVHWFt8oc53LrsPUAHnSrIX6G/Xwa61i15b4UwL618j1z12FPs6rk8UdW0NU0bpYpU2WwlpycJ+OGPkMogrJb2tzaBPe7XZRYdfitKyIZ4OGDh6TkaS24tpz38gDdSsrWbCb/DpHG0D4GcrTE3y9oiPmeaskNgTboug/yR12mQQHfR0IJPf5Zgf6Qv7EXAqABuSiRWdBJVAA05glJh+zaJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma5Fa4up0QkmcGeIsq2z3MVyBvtlccLV53+p+nTm0oM=;
 b=Wftyx5ddeHeamvHLJs3wQPAiWyvB/FZ2i9ILKW51N7w4N2iEYtnbNR0oMITihD0tznaoWLIM+FWdkLt+6ggDNGTANMDx8H3jJQcWTSETKZs1a/4t629Y66wzTUz9IE39G7a23hy9YWI2XlKm3nSZ6LyQ3jCMaht9kt0Fg7crOgk=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 23 Oct
 2026 02:31:12 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 02:31:12 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK
 (VRAM overclock)
Thread-Topic: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK
 (VRAM overclock)
Thread-Index: AQHdYfzpmp0Gc44YuUyNtTXcW7wugbcKZ+Dg
Date: Fri, 23 Oct 2026 02:31:11 +0000
Message-ID: <MW4PR12MB6803EF32D2E8C32E163BCB638E642@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
In-Reply-To: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T02:26:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: 4214a7d1-a8fa-4cf0-5415-08df30adb427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021121427099003|10067099003|11063799006|261009223027099003|56012099006|261021123027099003|261022105027099003|261022075727099003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: cb/kp7G7Im7Wif/MC1p03Y+MPmKEm0WEb87r7ADLOIW2nCExZOqTbl1K/LUd2ZbUq5gXIhRHypIAgMpXFbzXslim6OJpAMqDz56A3xpEXYspkTTSSFSxTdhANUiOz9Gvwu3L+vHGOmqCu92bcYJHTC/4jP8O64/5EBWlM51d6MHi+R420ZuFSpthndavGzttB8+jvdMbYqeRa87CaFyCAhA43wJLwfK7DPgmhw2sljmMTcRR50TWEWX/+qx3AZkmC+3hbbRxzgcFaoB7/UWDWLVvwKpKoyk5gB7vjsSYZYojiv4PD86vm/MWtebMv4UUfVgf389DB3oStaqmIW6pvZztQoM3xIO38jTjznLlviCXS/e3v05Z0HtJGMsMourFoiSnWZEJUNBqefs1FWZvtixqn6oZDZsw4ixfCvqYI5BMSRXvsAKDcSsEd2SrHDYEZ1xeMcsM6X1Tz/zwu7n8KQxtuLR/B2u+SYoM2XWFvFi6HTKOM/XGJG1i531o/Fpnw2F0UMtMrav+V1qsh2F9RS5nglFa4AWUE/E/8xxC2FRAqPHAAEE68cLjoYE74mm2EnEH9oKZV7yxULblmn6Saknnfan5OywC3tEhwd9ABDrV3jgBll18cofYzTHwe0Vh26FhKoGQvqBags7wnX9ErW/OdS0yvm0JFG6IvTngk1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(10067099003)(11063799006)(261009223027099003)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6wL+lym132WOW+sc7H2j7fsHwEhS1nRNTQIilQ1aOF7vlRmr/YfHF8zqU8l?=
 =?us-ascii?Q?PtWBg7X7ypCizUgH42a5sSmv770J7i60t/LPxmX2jhcPQ3cg131ZmVr+LxLD?=
 =?us-ascii?Q?75G2TprF6iEqhHybcPF1tuQJAgdN1XK2S0z9jF4sRkagUgVUhw5QGNuyYoVB?=
 =?us-ascii?Q?/clvheNppm7cIPdvjPRnk1aDlpeNaYVfvdesP7isECe/MKcShaviu67i51/n?=
 =?us-ascii?Q?P8Amn/O0QNT8vs5MfBXgR+3JHI5/8K/Mfuk6D99K0WrSUlKDR7BbnI0LMe/A?=
 =?us-ascii?Q?jrQNKVpqRMGIxprT6aCoynVVbt6KYsbIvL+0W06xd9iUchtSpmVt26FE9dEP?=
 =?us-ascii?Q?37dk7RLK8Tna37+TAX91lemG9bemyenSzcyre8JVQhW+xlPbpkCqThn9nU4Z?=
 =?us-ascii?Q?FD8oq9a51gD7BBnSeaMts/S8ujGvyhxe90PZ+meJWvKyGvzRg3UJrR8ZAFVN?=
 =?us-ascii?Q?tquqiOQa4WpMTHtsK6Ak0XFnbTIaFq0I1Yfg9byagMTfzCOhRxTWR5mAwRqm?=
 =?us-ascii?Q?47TlkP0hZiZKHPUndW+UnoXYKCCiVtdNw4IInW0zGwBqsEcbFt/LSO/P93J+?=
 =?us-ascii?Q?pG4R4cfav2lf3HBrKNdQ6plZFXmfJF50rOSapbOfAPWJuQN9a7WB9fgiOo3c?=
 =?us-ascii?Q?Q5wPg8cfmmW6u7AWp4a5e16uwxvjGB99MQgHuvSnz3gI3j96t8biXMJh0HRZ?=
 =?us-ascii?Q?zsiehJ+WLsOAWAzdHO19bVCAVydi4zrb8WfjcnFygyNlAMNiUOOSyd6GqLTB?=
 =?us-ascii?Q?iXdVKWylvRskco9fzyqabP4FMPvqWmb3rSdsM/e0k5AgT7KEiAWB0nXfj5XI?=
 =?us-ascii?Q?1OvNRzb9M0c+d2rF5NMFMuMc0s81CuTIcxG32/WwLPpGJ/p3JJXgMUK+ix22?=
 =?us-ascii?Q?QxfqESxpx+5Pcx96WJ5ykS8+t7RkpfBZdp1WXQix1zN4vZRjMr0y0OIqP1Vz?=
 =?us-ascii?Q?iMLSM1CEdX+YhFQTi2dBJdU1aOi2iPc+SbIqmAzfrXyTHJBDOzh1QhWbzuao?=
 =?us-ascii?Q?i+jCZDYODHLGTLXqvQi3bzeypWYwef9UGEQk9agq/I5LHK6D+zcmaFA6tKtX?=
 =?us-ascii?Q?K5ifbBElR/NIraRT2muwXYcjlfRqx48/ljnBgrWbI1JuKb9O01O8W60JjXqL?=
 =?us-ascii?Q?OQ8CZUgE39q/J5CU9GPda6a7sH8mhjuN46BG7ptlHS62xiqQ9ss6Ce8Y//Rv?=
 =?us-ascii?Q?FvIUKMDftIUhlUR6EY5yxomsoYVMghkoZKsJk7Zfb5s7dlzeCO8ihdXCs1t3?=
 =?us-ascii?Q?cHW00mFwdxoTVfYj2gleP6RzKcVZ54xFrb1g6Y5YaPpgovuA44cKnrkjCr4A?=
 =?us-ascii?Q?QTphlcyMjvrnrM9GtFcx0tUOxvTZwudDyJJd7tPSJ0XJdj1/ggTWhiOcEjiM?=
 =?us-ascii?Q?5waFpmhOWOCjwbmKQJ0S/DAq5RYL0HQIWq6+5FWyPqlRnYk4N5kmvqkO8l4M?=
 =?us-ascii?Q?GOxyYWb9+QU88zlvAk8oknx8vUv9tA45ZobrjqFgSUbzebk1TmtRv9qoJJEk?=
 =?us-ascii?Q?7lfthU0ry8bFWwIxqPfzYtedqc/YAt+Vd/cnVgOWMxaETYH7NAst1j0DFr2V?=
 =?us-ascii?Q?VLJ/rgVkysVcdU0pITkeoZ1+XKgeBTqD5YBBi3Kiq6QbRMeB8zxYgJtDWJWT?=
 =?us-ascii?Q?LMAqyrN6qVS0R/ZIFrV/SlppSwd7Wane6DOjQC3bdpmjz+hrJQPMrMbRht4s?=
 =?us-ascii?Q?VhwgYCJk2XscXJFRA9UNN7QO0xD2GqR5qAp1esD8OK+eVWYE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4214a7d1-a8fa-4cf0-5415-08df30adb427
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:31:11.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX8PJIflf5dJhgX+vkGVfSmhrda+H63s5uRbQCdLztFqTId0UdXqsRLgjZ5ctxDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Could you also please confirm this series is rebased on the below two commi=
ts?
commit 5cd40ce699014025614140294b8e3b7a847e6472
Author: Kevin Wang <kevin.wang@amd.com>
Date:   Thu Oct 15 14:02:09 2026 +0800
    drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7

commit 5a3833e7dd532ac02b4747d1b0d717dd49e87aa6
Author: Kevin Wang <kevin.wang@amd.com>
Date:   Thu Oct 15 14:02:31 2026 +0800
    drm/amd/pm: preserve committed OD features for SMU 14.0.2

These two commits have the related code modified for another issue.

With this confirmed, Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.=
com>

Thanks.


-----Original Message-----
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
Sent: Thursday, October 22, 2026 4:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>; Feng, Kenneth <Kenneth.Fe=
ng@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <A=
lexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK (VR=
AM overclock)

[You don't often get email from shidlovskiyilya@gmail.com. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]

On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through OD_MCLK =
makes the display flicker (full-width stripes) and eventually hang the whol=
e system, if the current mode does not allow memory P-state switching. DC r=
eads the UCLK DPM levels from PMFW only in init_hw, so after the OD commit =
it keeps asking for the old top level as UCLK hard min ("set UCLK min =3D m=
ax"). That is no longer the top level, so PMFW switches UCLK outside of vbl=
ank.

The series makes DC re-read the UCLK levels (bounding box and WM ranges
included) after an OD commit/restore that changed UCLK, and on resume after=
 the user OD settings are restored. It also refreshes the SMU driver's UCLK=
 DPM table, so pp_dpm_mclk shows the real levels.

Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/issue=
s/6009
(v1 was posted there as a comment, not to the list.)

Changes in v2:
- Only act when the user has customized UCLK (user_od_feature_mask &
  PP_OD_FEATURE_UCLK_BIT), instead of on every OD commit (Kenneth).
  PP_OD_FEATURE_UCLK_BIT is ASIC specific, so the check is done in the
  smu13.0.0 code, which sets a flag that the generic code reads.
- The SMU patch now comes before the DC patch, which depends on it.
- Rebased on amd-staging-drm-next.
- Added Leo's ack for the display parts.

Testing:
v2 is build-tested against amd-staging-drm-next. The hardware test is on an=
 equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a small =
local backport of the user_od_feature_mask tracking, which Ubuntu
7.3 does not have yet).

Hardware: RX 7900 GRE (Navi31, SMU 13.0.0), 5120x1440@144 (DSC, ODM 4:1)
+ 2560x1440@100, UCLK OD max 1124 -> 1300 MHz, toggled via LACT.

v1 results:
- On OD commit, DC logs the new max UCLK (1300 MHz). pp_dpm_mclk shows
  1300 as the top level, and the current level stays at 1300 (20/20
  samples, no drops to 772).
- About 4 minutes of heavy window switching on the 5120x1440@144 output:
  no stripes, no hang, no amdgpu errors.
- 3 OC on/off toggles: one short flash exactly at the switch (memory
  retraining during scanout, expected), then clean.
- Same scenario with the stock module: stripes, then a full system hang.

v2 results:
v2 hardware test (same RX 7900 GRE, 5120x1440@144 + 2560x1440@100; v2 backp=
orted to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage offse=
t at boot):
- boot and login with stock VRAM: no "DC memclk states refreshed" at all, s=
o
  non-UCLK OD commits (power cap, voltage offset) no longer touch DC; the
  short login flash seen with v1 is gone;
- VRAM OC on (OD_MCLK 1300): exactly one refresh, "max UCLK 1300 MHz";
  pp_dpm_mclk top level 1300 and current level 1300 (12/12 samples);
- VRAM OC off: exactly one refresh, "max UCLK 1124 MHz";
- desktop stays clean, no stripes, no hangs.

Known limitations (unchanged from v1):
- The OD commit itself still happens during scanout, hence the single
  flash at the switch.
- Only DCN3.2/SMU 13.0.0 is handled. Other ASICs with OD_MCLK probably
  need the same hook in their ppt code.

Ilya Shidlovskiy (3):
  drm/amd/display: dcn32: rebuild WM range table when memclk states
    change
  drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK
    change
  drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++  .../display/dc/clk_m=
gr/dcn32/dcn32_clk_mgr.c  |  8 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
 9 files changed, 127 insertions(+), 5 deletions(-)


base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
--
2.55.0

