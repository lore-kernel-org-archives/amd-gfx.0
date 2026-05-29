Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C1CCD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 04:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB5D10F883;
	Fri, 29 May 2026 04:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgLdAUrp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CAE10F883
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBb2KDT64H9sR8O9GDFvN85m3wOGWcYIcqWOHuHENrZankNiGLCmZx2qT4uzj4TtC2fsrflhz5Aepequzo8M4ZKZD/7SC+TplEOUPpKA+D4LZXYbECygE2AHSji1g1ejw4csWjWvdrUoQkugsJbN5TGzk+OXz+qJLpRatrM4BacOvYbSBwigF4+6BC0fnKolEAoNGWnv79o/j1V84OcZn2mLHO0jf2MEpVvRLvS4Z4W74Ph6Lz0u751mWrUly3Jx1He95KGO5lvtFXp/c0rYLAIrZsCoXv55X+gEvOS6Wm6eS88diupv6Hi8siWzxwUOS1WmbApUftdap+psAg2lsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCle7BFDBrgicQTK7182Oz4jdyCK3itrOKP+V1iQpTU=;
 b=HHOulVmgzuDkrWIrliFCkBnO7kOdjSyJ6DCCwbhslzEdKlvPWOou0QSKhqzmIaofKduaq7tWeO+Lp+ALspkoJ7Pq385KxBCE0g3a/MAv1fQlp/ExNfIY1Zo16OZ0z8ZVCNN0x28BFpTry3QGWZy04iQP7dApy+EKu3n9yCHAWMOFmQW4BuVjhIYrcuNdjg8YQCA4Tb5D9FO09LYWl7JhcBqJX1+fGuBDz7oJpkWyWCkkGulmLxhKIDcsLroRghFFy/n0PWZgDDavQEHNg/b7TSA5iUaLuiJW+ciLTrS0OERd6R6u0jO9eEtx6xIV5ZIY7uzvWzzzV6VY/EoqbNJc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCle7BFDBrgicQTK7182Oz4jdyCK3itrOKP+V1iQpTU=;
 b=fgLdAUrpV5Vol15FSsTFef3bTQpucp9vLCaV8FZnoeKacF4KN299lqnSFK+m/sQrp9D2zgZqQ5lJ3IQHGpwyFz6mkynCjpnnbHjzkuUYxPBRZ1lmMykP0sJpgnZmR8WtytMpEBZAHZDMBsQ1qIAvxaGQ8P1dfk7bIhRpyMrBiG0=
Received: from CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 04:47:22 +0000
Received: from CH0PR12MB5027.namprd12.prod.outlook.com
 ([fe80::2d54:5b5e:5c8d:17d1]) by CH0PR12MB5027.namprd12.prod.outlook.com
 ([fe80::2d54:5b5e:5c8d:17d1%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 04:47:21 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Thread-Topic: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Thread-Index: AQHc7x5TaLlzUDzyRkuqz9F3r+HalrYkbfLQ
Date: Fri, 29 May 2026 04:47:21 +0000
Message-ID: <CH0PR12MB502707D73150EA4BB19851A98E162@CH0PR12MB5027.namprd12.prod.outlook.com>
References: <20260529035013.1389055-1-kevinyang.wang@amd.com>
In-Reply-To: <20260529035013.1389055-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T04:46:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5027:EE_|CY8PR12MB7172:EE_
x-ms-office365-filtering-correlation-id: 313af710-4aa2-45e4-7905-08debd3d5f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: zj/1HvDbqYRwr7m+BXR7xRGc9DYJh5LwHgxtkzoeyi8TSk3BYs+H/4JBvNIMiCobGkQ/mh1Lvw5bIv/E8wdtzjUfci7iRtpRzdE1iScxRBDsws1mujmCoPtIvJ53iar5RknZMy30rS9lm229Z3oOZwD2+f1+hBHYgMpg7YwbuO+6k6bUbScR5EyMFQoI1nV+NadQDerTxsZQ/+QB0+axQf3T1z30IaSSQF0auw+3fNuj1gu6cHV/0MwQi4kwfNhEBfKVW9Kkuvvven/jGsRPFGIeu7ocAKptq85fviPGphGACMwCs6idMA/ShXrMlTnu9lgwa3aPTJzZcGzwQ3ohf+pT1meudVCXD+GR8eTq1D/iuxaWqk6R1QyUKy+bpSBvNRG8l3G6KoenF22y7XxipSQLsmc5yE7c6eqXPbHaFoonHM0VzMsISHKrtdJUisr6rVXCTWj8+PZZrF2e0ho0vQV3KNC5k6jTfODyLe4NzDfI2vuOlCD84FCvVq5hwcd1Vdhtz0j2O7Y02SYaxMUPHar6oPwPIJ4pQRtfXQbDLf/8DSk5gVcxC9aeaXSp7B3CYktIlq9/lGoI8R8eBk29wbTuB6GxJoorWkYSioSWBxlzUFB3xlZfqxw3J5ojJFCKZYS4t2KWEY54TYYb4zk08jbizcLq9exI+KPfuphg3jeympfXk+DGF7WG8dfW2QJTVH6PDOj5q2T39sNRsJERv3jpqUJahHLl0t4zS7TRxVqrBuCRTqS4BVy3ibTXUBxx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5027.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddGMduDNAHrZfjjEygoGWe1h3l5eZgwAV1ZmrkK+m5n2qKPMTYTEEKuRjbzR?=
 =?us-ascii?Q?2O/ebN3do/FhaH0jz9Ie7nZZAiau30xdaCXpVZVbtOkxTVwuWI+wOoEsw1Jr?=
 =?us-ascii?Q?fC3XL76maxve6uluDt4UNPigmyl6X9r1+MZFzFnOH/MLictEQPSlCtQvoFC3?=
 =?us-ascii?Q?Nnr6jKbkRV5X4Ni3oVsXo7yJFdngH6i2Rg2jEXFymv1jFgBHESVAsYBXHiSi?=
 =?us-ascii?Q?K62Bjr3jE4SDo3y2GS20tuQdqXrQRqryK9oZ/Tn+/j3rbZFrgrdf5uUMKJ1v?=
 =?us-ascii?Q?lnLD3FDRri9yWLjOA3EwzP6LwxJ6P2vXemAi9vqBVcX5uTv0/tjCVAzxLejt?=
 =?us-ascii?Q?48Y+Td1vdtxiDHcHyFJwXgcF944r2sL3Vn0rqP35ykj3uk4N7u1Ot+3+gBlL?=
 =?us-ascii?Q?3PhFi1wpPBFwOHShejqdAEgTqSO/iHsLrJYY1FAM9OdYqTv+GVJF/dYO6IB5?=
 =?us-ascii?Q?qp/GXKv4pVXsPtsoLomg2UkOruTgCuB0WcH4eGpjaJ6V2F0dtjwMttsnhtML?=
 =?us-ascii?Q?uCKXXmcpt1a45JuHCnKLBqyk/AUXt+NID1p8YG9VcBWdfAynxs7UdG4pmv90?=
 =?us-ascii?Q?5wVxkDPosjVs/SMYd38vdAA7u4XUBz1vutKqVoajFEQzghEirjjjL0+o9hB2?=
 =?us-ascii?Q?SXE4R/V4/zno1Zyi1ziSZd59aSAZTlTsi+7R55lmoYTTwMuVailx+gKJVHN4?=
 =?us-ascii?Q?9B7HIevHEjXN5doqRxgz+QuAUIaZax33cFhnJaeH9qu02PHmv4DgBZHKaYjH?=
 =?us-ascii?Q?2dH2+wqrxzcTzAAewmm7Mf51iypMk8J0+YGA1cCt+vDh7U9icbU/ByzNzNkM?=
 =?us-ascii?Q?DbU5R3cMKu2T3aPF5bH8GCgXvMHzhMSWic57rlEMbBUeT3/e7UahGxLcaSNj?=
 =?us-ascii?Q?EJ9agA0C5FedsTZMRfWBWu+CLZvR79CKk2kS6v8D2vbWAdKDe7lJGn+1gljO?=
 =?us-ascii?Q?bVNgsyBiUaJfj0170pepShNnP09p4rhKoyWyevrd0m+6T4CGUwAMnks0Ahnu?=
 =?us-ascii?Q?SePEuNha3kWfd1JAX1HqFxAkI9F1IqGgWK6xtnEzlcozIYw99xFvNt6P6tI+?=
 =?us-ascii?Q?D1Pa+SrYyYYUMNq8JTRjEFaU/aEQHYC3KKW+v+4Y3/gVZoqQPAPKogRJc6XG?=
 =?us-ascii?Q?KpHymQel6FoaxAG527B2sC7IuTy9kYTROEJCy8CcnmU7m7Cc/CinA4uMF6sp?=
 =?us-ascii?Q?NG/UMC+DdK5TBbCi5fj+tEZ8IYnrf4rIHq9nFQICUTinOp+ZW67oxPYtY/vA?=
 =?us-ascii?Q?KkLxEMKjthQvLD6ic5kEGgAgJTb2IFlNIQnroJO0ruHCaebIxjd953RFGseo?=
 =?us-ascii?Q?mIFd7/b93K3Q1qMT76ULDyX2UiffB3OnXGWWA76EEQ7jfgeyoO7ddHpxGJ77?=
 =?us-ascii?Q?cvtSv7sSJ2VZnX/4AupEgEGflE1F1PtkwZoKok0TrO5uSmZlAZBu3ZIWTDiT?=
 =?us-ascii?Q?JK3R40Yo5vLSM8YmaY8PfrZqCvQPF2DjW09snMz4ZdtXlPRXis2SJjWdPNRT?=
 =?us-ascii?Q?OWKORZzEjTJREa5FN1Fu0BnVjFAKjC1NNAfYT0eEBc/3+KUXir2Wcr50itp4?=
 =?us-ascii?Q?jNQev4lcFSl7Z3oPj5tRbyLA6tviMY1Q5ZFsA6plvClUoM1UtMx68kLEu4bf?=
 =?us-ascii?Q?P9ikiHFvsxwMXpun6o2TeWZfvKejJi/u/3D0oZh6ns875ss0mD8BA2VVCT7C?=
 =?us-ascii?Q?XQ1dtDre65uNOK8kzGEn2LD+cFdvb58Uq96H/qqPkmK3Xcye?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5027.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313af710-4aa2-45e4-7905-08debd3d5f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 04:47:21.7923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3A2GTk2Wp5Fs4V9gu3Ber07BAHfAvb2HZkgDskyWUB9udc3TOhRN2RvVE9ST9t88afAYeIDCEcIHM42il/L18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, May 29, 2026 9:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu 14.=
0.2

EnergyAccumulator is unsupported on SMU 14.0.2, mark it invalid.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..f98b8e045db2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2153,7 +2153,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
-       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
+       gpu_metrics->energy_accumulator =3D UINT_MAX;
 If we just skip the assignment, it will be already assigned to 0xFF .

Thanks
Asad
        if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
--
2.47.3

