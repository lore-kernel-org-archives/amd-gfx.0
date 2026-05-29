Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79667CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 05:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA82310F8BD;
	Fri, 29 May 2026 05:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUILBt3F";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC5110F8BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 05:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9UQAz0z1NhItLX09kk0qAhfS92xxOiC0ChmkFpRv/LO5D7X44obdltLgo4S4U+JTntO1ssFn0DMuGN6t4xceDUimYPVjIL+vFl5qvP5nZF9arff6FMU1L82WUYkUOFLmLVZGTjbtNh5buhEC06oAR4A1oflJWpCga/Ipk74h0/ZnkMNi+g4cNrAtM0+fHiwb4HpbbUsM4KZW4+FQZpDT6DwPfwpL1gdKd7irEA0wC8sA77O8pHxJ2Xy/HdeF2q4i+w27xjZLY0ii+cKQOXOzs6AWIQ1G16khObxkPmWeYGA2Ud8nL6LV89iC4eAEW9nZ62er/mbjylYMq8SjTWw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNl2sIiAzwaPASIc6ReKZgFRadA96OyLVYNPJk8QLVE=;
 b=HIL7ApUL1RbHw+ZF64mxogqruKGF7luVED1/w8E4GwMOhkeaPz7TEexHAS4m6XgsA+FslytWsxPjPWEiXO5nvkZwlBmmKoY12g/M+HvJ0vShGqLNUm2vXYSNkLipZCkBv49UhGPxsNzqturDK63AW7zlTVQwy/p6XDZqoB0o/AMZYHQAZtFo5MHYJOIT4lRfXJITASKovg+RgsQKNKKLOpYLlUtc9lGI3yhAVEbQXY0Syn31vx373y9loHxSXXLBHI8gXJHdoVWZtroQGSlMq1BG3JJ+U3EmNOmjDJJ6magvQ3puiP8mmsOcKouYDShC6kQ+or2lr7gzAulICLtCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNl2sIiAzwaPASIc6ReKZgFRadA96OyLVYNPJk8QLVE=;
 b=fUILBt3FhiwZVFlCU3uEY0oE355vfXjyZLAsY9RkZgxh4A7LztCaZmmUltGo3+pULI3AOOKmU7RELXowj0gMwYO6C6B9zi57sbJqU+vtpsJIwR/7PIR/BRIPqgP7KnbO5Ndcw6e/kg0l0w8mBBTCkRBAg+s2egNwKleWmaB0i1E=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:24:41 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 05:24:41 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Thread-Topic: [PATCH v2] drm/amd/pm: set energy_accumulator to UINT_MAX for
 smu 14.0.2
Thread-Index: AQHc7yp9RBxEAU5n5E2/up6sT6LHI7YkeIcg
Date: Fri, 29 May 2026 05:24:41 +0000
Message-ID: <DM4PR12MB5038CE85D4B328EEE334C5B98E162@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529051731.1398910-1-kevinyang.wang@amd.com>
In-Reply-To: <20260529051731.1398910-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T05:24:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|DS7PR12MB6333:EE_
x-ms-office365-filtering-correlation-id: c798367f-c572-4399-de19-08debd4295f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: xWXjPbs0Miy++Q3FpEvfKeu77TULCQen7BT7wu+v4a9SYU7hCJ+g/hxvcK07vH/PjFu0+pB323B481hNSiIz/iv369tJdh65luaAVTW/ly4m6Qbz+9GCV3oTNv2yQUJfNpTv0ERaSrB6UQbqluldiupkEHuMK76JHkE3swh6GEY8FHkKvOrBUtw4GNXDxlt22NrgCCsOz2nHtiPmv/fXfDJjBJd2cNFRJkxHJTJMIrEcWEtzYRIV/aLKAt5WoF87q66lMoAcdN/NhzBgKmY0IQOcZJRXg6R/+Hg8H7TbYcqVLrpK7xmnHuZZ4mAxNr0lgXaVqGcIJs2eCy+o1Q1H2e4vCkOZvFPtzl1ZdVVYZAvfNLNUCIi9FeLGRwVIBWEFhpYXkzcHuPniOCCqdf1J1ygLJrPCbD4Jhv1m11jITDSJsd6O8nN4eHaQvBUZLa2z3udiNLY2KhOV+/o6I1wrMsI78zimLXiGUJsd7Sq63KTPftlNmj40Da8SSY0ZnQNFm+QlN9WBBeQYr1HDu4/QU0MBsKg0Mvx/7FD13MOy7zea4xhvUWpJzMaq8jC+jqbrennI5aEhIIyywo+oJ0zDu8JDCvNtWdy1mFBvexS/HbBz3gVVG59IdvKcY9DTYxPfzPGRMIg0OSpiz6+jbsH27pwsvTA1bUzUfB9zXtqMC5/zcVEU/0J9L8GaqNKdCi8W8eI9ilBMEoT9i3vGZvwSi561kWvbuh0er1L3+FMDspHXM0HyqaZs40reY+uyzlsD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?URTIt7sUazxrOHUi+4QLp+ozEPTD5djKE5oSM3pvwHakqVyxqzNxtZKiK1CD?=
 =?us-ascii?Q?eA1mEMPYPGiaIbXCUolq3yhtgY7T/pIoYkC0vAFkqoU4egBY3I8gmbaGoPKM?=
 =?us-ascii?Q?3+SVPnS0eSfKsgEJFCgcac2FEfon1kISHuh3gD+/rIMkgZIIe25rfEY09dmY?=
 =?us-ascii?Q?J7EWjzRGv/wb0lDH+Rh+sdcW3YKY4bDMwxP8fRE/UeY+ABUBnsvg0mPxQ5tF?=
 =?us-ascii?Q?+XOsh4gMgpWFeprWPNgmGD+E6z52yJWjYcB42uiRnjD4/b3wr5kIe17LYO55?=
 =?us-ascii?Q?tqySzI3f/hJsPGs1u62xtK4ElnZmWKXGA20pSwuWENQUhCI6d/Gcq3uwUt2v?=
 =?us-ascii?Q?cGW7ppkZZ2FCt5YFckBviNk8+MSQvmAVL4eGkvGRPHRNRXdfW0SaRo8TPu7J?=
 =?us-ascii?Q?iPDqwwylxNT4v10FKwcSxj/YdGFgY9BkA1Tf4nKZoq89xRpSbYIQInZxTrjk?=
 =?us-ascii?Q?TTKBp8fg6zuOL+fN+kBiX1H2Egi1z8RQ/plpbBozKqfkc18lcKzdEVWygzoO?=
 =?us-ascii?Q?ZAJN6ZAMyn0Ucasq0SJrnSxKJ00mbWG6s93wmVZtjOmnvYdSC2O1iMIAcJjm?=
 =?us-ascii?Q?/pPTg2DAheoa+sgKsmazYpfvwFhaAmp/t1K1sXOOE7FAEqDpFWcUz0JMYxmA?=
 =?us-ascii?Q?GA6wqH7hZ9wgUPyIwklSV3BVuR5HlpkWtmwMfAigGXB+HRrgaVPH5e1n/v+V?=
 =?us-ascii?Q?GwNwuYpNj+fp+caqx5nX5dUSgzp941VdQ+r6w9Ce6QuxnCp0NixL20zIEs98?=
 =?us-ascii?Q?3P7IdkPxtdqcXzQSTl0l61dPSTwlhf5SGLzV24HUr2Kpfj9Ybs1oZ8h+0eLP?=
 =?us-ascii?Q?lmnqNve8T2TkUNBVlUEhQ3Iqq4kjmsbLuTICOdLyV//aCej+87dS9XJRO5R3?=
 =?us-ascii?Q?vr+gu/hFTVkwiB0W4YJhL2AFFkpPHTrqthYyUDgCTyhK+dBxn4UipQXbssNp?=
 =?us-ascii?Q?yHo2xhwwbrEoUZo/ruK2rsnG8FjtTgLQQsfr2ee+kUUKghBAlAQ+soy+FeqQ?=
 =?us-ascii?Q?a+fyqibC1oO2X1GKvbABym5TwGEC+yX74l/+3S9cnUjPpSu2x+OkpDSJpulg?=
 =?us-ascii?Q?Vrpox3y4e2feiMVf0+w2A/dGwt6fKB/5fWAERuVJCI4viJQZhEGZhr1kGAiv?=
 =?us-ascii?Q?KupwLwlDVIssLQTN67YtzRWlGJ5QDgcV7UfDNG587SBse+7ZBHUL8+G2f4At?=
 =?us-ascii?Q?1wW/hkUlAtyefFogsiwfYbkNfAp1CPWjK4/CRNMwyezFl/zb3k/CQHRtS47a?=
 =?us-ascii?Q?P/GheTEb4KtFbofwUIQNDHHvMBKcg1ROoh0FztFJtN4KeMFyuCR4GngRxk8O?=
 =?us-ascii?Q?xVy2ul6WJTwndRRnMgNd8FHS2UGHaRNcNWuvH6tDQalMxq+kbWJvZoXb2qKV?=
 =?us-ascii?Q?ZN82QK8fDzJW6boxyI1h8XqV51okgro8Gd+xVs5wxKH5CZMILBJuB5z16LsJ?=
 =?us-ascii?Q?qZieF8hN051zUeF6DJ68HTpHQcSpCkM3u32jXxeovsUoKvYFqDKX95ecpYxX?=
 =?us-ascii?Q?8pBwN67OGvyIAzreGmnSGIPZ8AsmK4EGH1vLHsiTIEkhf/DasshB+PRY8OsH?=
 =?us-ascii?Q?TMfXFfanAg4q1aNWH31kXUDPQANWKQ+af1XQhXuS9asrvVqPvB/gHscrMgvE?=
 =?us-ascii?Q?CljHqm3YNUc2nNhtgePGnkNvQmiq+a+xw2V8JjkCddWA8IN8FS+G4Jgojrej?=
 =?us-ascii?Q?xfI1AkNJ6jvF0XE9JPv6xPpKvgCXQx2nSPdbm78SE5FgHYFq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c798367f-c572-4399-de19-08debd4295f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 05:24:41.3815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4arOeXMtHCU3pzQVmKpJpfyZ0HFx+Ayc48tARw6HkiX/zgDG3j5yreZGJSDg8JrsfeYkLMbaqsmE8o+VZweGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, May 29, 2026 10:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Kamal, Asad <Asad.Ka=
mal@amd.com>
Subject: [PATCH v2] drm/amd/pm: set energy_accumulator to UINT_MAX for smu =
14.0.2

EnergyAccumulator is unsupported on SMU 14.0.2, mark it invalid.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..e8c6bed781b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2153,7 +2153,6 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
-       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;

        if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
--
2.47.3

