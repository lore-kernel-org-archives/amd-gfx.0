Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE5C79FA1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 03:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9127510EE5E;
	Wed,  9 Sep 2026 03:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOns/f4i";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42A810EE5E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 03:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho3e1dWL65SBUhuC8jfvnymW3Dhd3TcfXTKGShL+zJYujVZewon1KfJQywrB+tc3AunCxwCXSDKXFo8XmO793pWFU1CBjeWA7sNRJYhUT3hzknsWFSvMU1XvdVoF3QZ7p3QQIJfuTEX+4QgWuNj3DOoiQujR4Ye96SnW9b6+lTzItP9rimmk7MqgLd6bl6zQIyss9hOZCdgbPHohlDxD7LGwRTC4edz3XY1Nx78Zioc6UuzmE8NA4SbwRaVcLhKgVpa63nFdMdPKJZyEeYyay0V85Jo6IzpzoAdpH6TdtYsqmeC+3JnXE3YdnNsxn+pT9kSAfsp80/dkgOolF9YOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81X7WioG871Kuff7FvBSUlBUMWFq2kiS0mWc8ODzsbQ=;
 b=ljS1r8K5sF2gtoUsfZX9jNRXjtSPnMqpZfDWjFEKnM09fPTmddpvbWXKzJSoWJlTjFc0IJEsxD62QSKSlrEyePsU2kQCRdnNfq8hfVyu8heRCZFS+NEDlfrwncncL5El9SAr6+mdkDT8OL0FLO0VMU2taztyfX2oYzv9gGbSUDjR/q2oiY8gPOzGCK/RWHwZFAsterKpPxJIYtxF65jpBCgq9Z+ccR1kSQgTK6bgifMxf8b9hH6esTrf2AFfPih3S8zXdSvBoDJd/Ixb4K3ogbO7ph4DL1JIhj8z5IJ9zzbDim5EXbJ+4irzJj6EVURzZbM5aFDUV1t7kkeOQY6Y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81X7WioG871Kuff7FvBSUlBUMWFq2kiS0mWc8ODzsbQ=;
 b=VOns/f4iNb16ZTTLcXioQQyvJ4brcXtsAzuCc/aJplMkQ/n2hKtUYwGUY3wrkKMnrEPjgcPFLtkMc9799kAwUo8GMl7yfm441nF/F0e+OvxXS2SsYOw/cEvj69qJaS+ovU3EoW+PnhEn/tttj4GGn1b7Kw+35i8V2cmLQCjgcvo=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 03:17:15 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 03:17:15 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: report energy accumulator for smu 14.0.3
Thread-Topic: [PATCH 1/2] drm/amd/pm: report energy accumulator for smu 14.0.3
Thread-Index: AQHdQATU1aPStZeaY02iv2WKMLvP07bFkyuQ
Date: Wed, 9 Sep 2026 03:17:14 +0000
Message-ID: <MW4PR12MB6803E43B21E830C0DB0841EC8EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260909024150.590580-1-kevin.wang@amd.com>
In-Reply-To: <20260909024150.590580-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T03:16:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|BN5PR12MB9538:EE_
x-ms-office365-filtering-correlation-id: 84105743-6f6e-4070-0ac2-08df0e20d8ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 6xtUpoivt3N/qxiQrQE+tmWG/8GBhQarhSO48jMKxlZYXwQa9rdLMiqyITtKY2/OhS8hbzm09E87XvfF/VFlx2Rdfv7FalkN5nOCMikjhOE9yvVDw5MimS9gu+ueJK6mTTJVzU1fgRWitAibkw8fITdu8tsphBi58jx5OqHOYfiTkgrIJP5ufQTsaxQ/thAqnj41ZdkuFeVyu1htVEh9vatXQXShBZwJJbwOs7pPQKZ9w3hZD7FC7+HGRF/pW0AU9Ka3TXdQZfoBA4EwwxeBa/ZF9QYfxhR4JMxzFeHSbeOT3ZhZb3Qk6M8Yg5JyhMosbctGal2bARUtL3W4apcneuj0yP+z8QkECuyoT2LnQEvBsuBvyY1rnlJCY8Knf3N/ElyPpm0Bx6tYZYoSZ1eVxi/4XxfkRknBgfB2gFdZwCLfPEtskgAOoNXntIbVdrj+nd/oSvFNRWBufI2u61Ypyct5/HFuAyKAT10qAOoPcQE42qYa3cTPOYTmTBkPcHWnkieBz/AcwM3jDWS2esBBA89ubnMxUmmNYFprQ94XSgu4fAo2TZATD2NB3QVNyufHDhvm0VCxZ+xuCKbCxhwGQwBMgARcjoe8cPPrOUz/cIVgqmg5LIikyDvLKE5nt0Ey0SmZhrsLwsLdIyxghwdv3LsfEItTDM0k+v7wZE82CoUqw7yOXgkvL2wT46QqmK33pv0V7jHsOYWDFz/qk4PKfK74gQnKY8fb3Cz09z3WsX8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4vDAXZyQQuJD7ukfTVjnb4jVq9YkPfjvImDKvL9EiCPk8e0qxhFOATeQoSf4?=
 =?us-ascii?Q?v5PPDVvQ2QiWkSLBf3Kuw+GXzfyv/uNey7v6DvUHGxeyCxPDbC5Pl8jKeDbx?=
 =?us-ascii?Q?E62MPU7mFfg0yaCvtnjGUd0Dxu895ssshhbGZKgaxNXiplBCJotEOAtKG1mR?=
 =?us-ascii?Q?6SSkvqCgXmtlGTVMu8LR6/E9vtvKMdwP29YM/bDJx8z02u88xH/61MBvGwec?=
 =?us-ascii?Q?XUYPEJgvDSfiQxei/HCQKzvM13KkboJeDbFwLiTw5D6uM3+g1as+GQArudzA?=
 =?us-ascii?Q?vgSZyR7xoLZVE4I4Jd2ckVfmz6r41/PlXCknLhIBAFJDEwguC71FTviY/gOU?=
 =?us-ascii?Q?rfJtKUZ9+Y4U01XmxW/MaCdoU4rLRhYiiL111XQALf0W3+2c8fNdU2zn2sov?=
 =?us-ascii?Q?JqAJpvrRnEpOtxBlJU937vZF4YWIzgYYjER9uDAW1P+CeO+cuZLW2DGxzrYD?=
 =?us-ascii?Q?z5sBqN1Sbk644c634YfpnG8qmhASvrOxHpWDJuHvdMbewlDmysAC1Jr3jA3w?=
 =?us-ascii?Q?ll+N3ypLE6801aiAL4sEtnMi5LE2PpsyOhXoNtmuP7BLR5Bu2zbiJ6bDU7c6?=
 =?us-ascii?Q?1ZhR0HgWgmlv2b6ae0FtrJccye0FNTm62DZtYAyx1iZfa8Y2mbO7gMdITzRD?=
 =?us-ascii?Q?ROvjbkFSP0EQgXURW4FMR+m+XoF/FUqTKUQm07GxzPRii9YkZiJ0yqAU1Ug6?=
 =?us-ascii?Q?Pe/2diaiycWwoBOx7pHBYlYs6vWYm2GJwpHlnz2Zhn4CoB4+TYSjz7s+Rqtp?=
 =?us-ascii?Q?Ftflm/bzeza6YHhglcrOGVD27xe9Xxb9ZQfLIMfesBZY9rSw3Ep+jVbLKVVj?=
 =?us-ascii?Q?1bCVwcSICZS8EgxI8TVxq6AnwatKaFzTqzkApSyPR9KDgSjGZAyAw6XD4qZ4?=
 =?us-ascii?Q?jiaACaYAQchs9T7CFVtWgs7K114J01JSKm5V88i9lHZE+MNGatn7fAmaVJQh?=
 =?us-ascii?Q?P7juVjw7BmLPB8Dz3YW8FM7eAwCbn9AIY0jK/h5+dc62tsaloxlYA6bc7N6f?=
 =?us-ascii?Q?7yYukkBSpXEjCoguCWdlT+RHdBN6gguqN6/Opal0eBIR4k0tHGzed/o0XRUe?=
 =?us-ascii?Q?5NnSZZ+CaeuM9jArhIueIkvPXmjmHqO1rFcIDMRmXxqcrvv9mvIL7NzfuajE?=
 =?us-ascii?Q?WU+rdf07VuwjD5HnUGdNCdtoIBQGJNBQE+xWlbgYoj1xS03dRoWSPg+sppve?=
 =?us-ascii?Q?ZWb5LvN8OeW1yfpRVC0cteQGTIDVb7TQsqnCpwPuHpmxOW/iEfhMULdsKQk3?=
 =?us-ascii?Q?PDTgKoq9gVYbCAHvmzR32VoYVWaZI8H2uizBxOsX5ECyBagTfXn6Fe2APaTg?=
 =?us-ascii?Q?arukIgsOFk2mvgufcdwpK9BdVw1mz+UU1Dq1N8X3nnAk3Em0OqL396AfgF5r?=
 =?us-ascii?Q?dPXBNbeZJ1En97ZRBuc0FWx/Q3C/ICQxvAUFzC3hoQ3ypf+Xul3pxfgr/Mgq?=
 =?us-ascii?Q?2q8okwxpyONLu56Vkcl1+60AW6OzL6+ArAmPIJeOJhtOKVMs+krH8HBjQKyf?=
 =?us-ascii?Q?yoAA1ZTx3ea2imhbIkFhbZwDHOujxrbsJUnazPDwlgrsgd38zYi963gB5l0B?=
 =?us-ascii?Q?6CT0tU8wI23rPP1ybmrJEYfNNXAwTllqOFFABGHHg79ELvtTu6FJXgfKRJEe?=
 =?us-ascii?Q?PzxRBIQm+mWHNwbbS9sDGNdBfWSrZnM3UOngi30490+SCsTI5nHvZCTU72Mv?=
 =?us-ascii?Q?geDQrfGTtL8b/Y0Hlzyy2+N1Ibd6nR+m47t0wQ2lEPcfxrtB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84105743-6f6e-4070-0ac2-08df0e20d8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 03:17:14.8628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1SchT8SfEWor1xrRGFLFGvInxC/D2DV97LBXAFcq2aJoYKF16ERPi9B+b+gkxmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wa=
ng
Sent: Wednesday, September 9, 2026 10:42 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: report energy accumulator for smu 14.0.3

add energy accumulator on pmfw 0x00685000 and above version.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ed5796a985b2..76a606095ae3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2157,6 +2157,7 @@ static void smu_v14_0_2_init_msg_ctl(struct smu_conte=
xt *smu)  static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *sm=
u,
                                           void **table)
 {
+       uint32_t mp1_ver =3D amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
        struct gpu_metrics_v1_3 *gpu_metrics =3D
                (struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
                        smu, SMU_DRIVER_TABLE_GPU_METRICS);
@@ -2186,6 +2187,8 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
+       if (mp1_ver =3D=3D IP_VERSION(14, 0, 3) && smu->smc_fw_version >=3D=
 0x00685000)
+           gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;

        if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
--
2.55.0

