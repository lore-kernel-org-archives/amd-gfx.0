Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F6FC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 11:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2885410E2F2;
	Wed,  6 Aug 2025 11:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r4SgLFkh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DD010E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 11:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhIxKQnlmUv2kfZedKKDoAglNE0pLw0xgrEW87BtiLAJTqISPfZ02+XmIUDjwZvT4jayhoyBRwPU0FYG+clFBruge+k+83lWR9fp/xqxlH8hFW/H627GFMhVsx2SuYVxIR9drm/eTQW0AhUQRpwIM7D35TLtzZhiV5KC3FH2T0dPr/yfMKy/I/mUJ/KNuBs9VBqhuWixBPT7oPfU6oeaKDnI1Um4UCr2M6Bv8xe5of98KLxO/aM5TQFc4Gy+v9yH0oAO+mHxH1OOfocU6BcvtZtFg1ETTSeVndSs0TmzKPKHxfQ95TNz74pepoGPgOIqPz7wJ2zN095OefvWwAvHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0We39QZdv/FQppf6XLpN5x88GpwkJoidF/nxpmYQZqA=;
 b=aux6NyukI0jeoKcCpiV7HE7i2JDyMS2OnI6cEBX336mI2Y1vO8vIghH1N47FGzjXuEm6oVPNM1k5OszfrvP7Xd5tNgTCEDS9mO4DfLByiaahZ5Kf44lSsniHDSRCyKGGIzg0ZvPXhTBnrtqD9mD9N7ZOJjFeRo3bKLulZ7w7aLVVvITUssStHMAu1eaQNRvhRdDyGER+ZfulHvkbaJ9mlGh9xE7kY81wRrXW6d+NR3UVHAMdkAVHtnc+KJJ99Z757H8OEZd3gqxgXbZtSckkSZZb4bN120BbYiXJypX3vOF9xn61WbATIy4xG/odDd1KCkvUZM7gJatbwzplQ1jFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0We39QZdv/FQppf6XLpN5x88GpwkJoidF/nxpmYQZqA=;
 b=r4SgLFkhUH43eBSty1p+Bx4Laxpv0mkbMDFeqPKoGXxN22LVKSj57PUOsA7+CfqRSWF7351e+ohXSIt5sMGIc5FN4uugMpZYMZ6pbpAh0ouucdOVMTgVQPWFhpARUE4XgpjC2N7yuP5mrtssofx9F3pttJW7kjcs/UzkwwCcwqw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 11:31:22 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:31:21 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: Add caching to SMUv13.0.12 temp metric
Thread-Topic: [PATCH 3/3] drm/amd/pm: Add caching to SMUv13.0.12 temp metric
Thread-Index: AQHcBsRsB/9mVO6PCkG99hIYlV5ugrRVfYvQ
Date: Wed, 6 Aug 2025 11:31:21 +0000
Message-ID: <DS7PR12MB60718AEAA99EC26656A649218E2DA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250806112214.1804907-1-lijo.lazar@amd.com>
 <20250806112214.1804907-3-lijo.lazar@amd.com>
In-Reply-To: <20250806112214.1804907-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T11:30:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: 0e9564d9-f7d4-40f9-a88c-08ddd4dcc4f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MZdhRm7/QhhJ3i/mWAGkck6v5pfrtOpu+66CvFhok/dR92L4Orn7/vhYg+Sn?=
 =?us-ascii?Q?8O6FMwN9kLuNEkyL/1G9yCKCNAzq0oPkEY+AeHYflOm8E5QUtaST49+K7lzA?=
 =?us-ascii?Q?YM2cbBt0E25gNutxY96Ng8SaABuJ3D1MiAaXwK0a8BraRcRqBXjuLaAArCCr?=
 =?us-ascii?Q?47vsokbwkZPYUlcxD3c5TSk2J7t7CzDG6ceaGZTChlZzlArpD0S2IqG0W/rp?=
 =?us-ascii?Q?DsCAC0459+CECntam95D5g8Q6b66Eo74INkur9kkpBLQzYSLmHYH6tnZPbjY?=
 =?us-ascii?Q?x4IEAZozzgSWffsrNVu8p2zcLurdYZ3089PnMazgphwa0DWPQ02f6T+H2Ogn?=
 =?us-ascii?Q?J4y1eIP+VqzYNYDV1pClArbZI84zRVvlkaivIb0I0C17EpGzWe/dCHAjANI6?=
 =?us-ascii?Q?C5QMDMEpHYRgKCN1GqhuGzkhqZhgik2BEBhOfe4B4vgVgUGo2oLuI1DLyp+w?=
 =?us-ascii?Q?iU80RCbIigE7kLsuJbotwDCzl6D2GpaNGOQOwKFvkIBcoG2IiDkg2K1MhGS6?=
 =?us-ascii?Q?px8sqPlepAivh1dqD9VpFlHyHSgKFHUToG6I7wbQCfHl8tMpEypr914aaWlK?=
 =?us-ascii?Q?lqwJ8crV/VghnhyNE5bg2gVMVKIcqWyl70m1IC07i4ViEdsp4VREvlF9OZjN?=
 =?us-ascii?Q?QLRuDl8sVJnAH4Kj5xg1Z7XaMeU3Zt24OLC9zpNoAdiGzwpyjkJm5AhGIfMx?=
 =?us-ascii?Q?BurhgCMmdy1Em9EejdxNLDkYYZFxK2cezzE26sgggRxUHz259GSX5SXZOhQV?=
 =?us-ascii?Q?5Ss2OW88vphFGXlc1tWRXxHjPxW6UK10d6PZFHQjlk5cjrVzuMr5Aji7ZzaS?=
 =?us-ascii?Q?ah0o+XAiyFnUrEaZpn9PcCDLqJbtHtZhKnycYs9AlPxSiXfTKfdWOLpG+iRD?=
 =?us-ascii?Q?Zi0ZDKUSicJRTf1BMi4ng9iZGz1UPXes/Y8wvJDCODWCSlD+IzQofhZ1NFI0?=
 =?us-ascii?Q?GeHcCCA0aaQOuU0s+KL7SJrUnxUUWpcvcBQMuRA1DEcUdlSHiSBsrknei1S2?=
 =?us-ascii?Q?MHww3GMFUsDLM8k4zBWFzq4EoOKG3YueO6sB7u3Qh4GcUGCY2D9Etvo7TmG4?=
 =?us-ascii?Q?3LshQvBUPwelDzPhsZV/RHMcJmVFs8tx6wSFUwQByBzJUX2nnObfL4aCM9hZ?=
 =?us-ascii?Q?pb0mqkTYPcTPGdzyOlVFvLdAV0LoZ/iiCzC6wQW8wwIRwa06xSMZOSHnzAxj?=
 =?us-ascii?Q?ywXrFcnM/icvJ0jpVhK7/5MXarmr0Pns/lG2wG7SuF6NuIYHdeNebzYz55QD?=
 =?us-ascii?Q?5weXg+e5RIFsujHypIUfPSAI6Lbp8wGhUAlHat4/tfdUBJHPKJBoHKEMTE8N?=
 =?us-ascii?Q?h57DHNtzGO8U0iMy9qASqqiByNoBSwRIlkL1KAlXdhRypvvJYL/6JnBoX370?=
 =?us-ascii?Q?J9jD7GpPwpn3zg2rlSYVTtR3dClxLy3pI07I35yoy9k4eEabb8EeVEmDNkI0?=
 =?us-ascii?Q?31vENX6yZxQGd9S1mLoXPaHenxXjltAi+cmu8PIUQ6UZzGDIsBZ350PrpWxz?=
 =?us-ascii?Q?ApPPPWzbIDhDQfc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tlEPdZBlhkMwqFy6JBMLVoOguHeskosdexlDo2YZ5BoZXHOYnoqFd8ckFeEq?=
 =?us-ascii?Q?zyFuxEEIG/VYTpc6Mpwxsj1DX0YAxWpUy/RXsRCaq6T90SuwSVsMBHaS3zyB?=
 =?us-ascii?Q?sNKmR5BQ6q8pvoQQbY6hFc8v312Rv1QYz+Bhb81gTY011vvSB4Sz3l8rHfCp?=
 =?us-ascii?Q?YQKl9TAsF5f3aQmlDc3I0EWoXOCqyu+2np1eHahj36rlcQNauKw5WtVKboHk?=
 =?us-ascii?Q?RQ6FALW/c3qvOMsUSHz8iGLT+UDlV3HllP9omKQNKj+x5RGu8g+/ZxYNlT9t?=
 =?us-ascii?Q?3b30NOnkk65/u9Rmo7NKv5zPymPNOkEzT9kGvn+bI2oy4gi1QEcsP58F0XTB?=
 =?us-ascii?Q?9Uicba3ydoqg7ztgt+4TIioVZ2Qnk6gkJxVWqXpdStCE9v2iJa4IXMbWPxjN?=
 =?us-ascii?Q?CieCr55iPiJpVsowQWzbNYCudpmGYOCu61PC+2HuFW4vO8SipRkwoqu44nw6?=
 =?us-ascii?Q?lWRcQFJyGyh9ZdnbbD4dE55DBgV1vox1No9kAGsqV7YDj53+8zSLg51UMsUj?=
 =?us-ascii?Q?cK2DMHu+iH6al0OO6PHBsrLX0k0B/8sJ5zzOKVbNCHCq/cuLDgDnUowtXwgN?=
 =?us-ascii?Q?22gxzHnId0hyHUw35Xtk8P7OFgB+K9TYLvyKYrUthUOabPOprl89nDF+pHzd?=
 =?us-ascii?Q?QVf49u6TMqplPjM3le+9ZBOB9lVkoVUA5lVbT617oZMHYhErbwm6elyScpTg?=
 =?us-ascii?Q?RrBN59weighI+IB/NOPtq6bTsFf7o9yNGx7CzpHM/5Z/aFK5bGsvKeu4R1sb?=
 =?us-ascii?Q?UvtUtNu51gK6Cs2lrGfzLwchOAdEdQoh8akN/+JF4dgf0tT/a/0UAzDYrRT0?=
 =?us-ascii?Q?+7LoffNwNCwV/WsuLrJ7R9a/829hrvy8yH8whabZn8671aKgMX/HQmcF7wMW?=
 =?us-ascii?Q?g7vUvu+stJ3OVnCs5MUbLWtLtfGl6YMVbZdZwweHPqhSO4onj3W2TPnYJihJ?=
 =?us-ascii?Q?Z0WBqLm/4r7iSLmq65R9v6x7LFqVWPgzz/VCWHoMMpn0YzAf8d4E0XVQy19E?=
 =?us-ascii?Q?iSXoASUqBDsQWid/K4TEJmv8hBP9vIX7b1jx+mSIf3OpGr7Ad8kE5XziTlbm?=
 =?us-ascii?Q?ueOGeL2jA198qWp6McmFR4Qz7fTVKMs+SmYjUPnqdDCNQ79zbUVesIfOHSk4?=
 =?us-ascii?Q?LR5IKSeXPmkm0uFy2N/l3W16FnYAyZNcO0d3wleVbeSuxt87LfbzEE2WMSbj?=
 =?us-ascii?Q?/pdtLb4x/vQ5WEjFiG0mY2iNHt2YD9LWXvUJ0w+bLwIxjvh5DdPFhdvu0Tyo?=
 =?us-ascii?Q?sTKQkXga/3IUVU8KzPgwzqtlSaTApkBm239nqHqUacn3X98U1/lvCzCxWGHq?=
 =?us-ascii?Q?nk2O3p7LEWCHRBsy/c8oBF4XHLJWPgzxk7rfJo/vXf/GZJ+L4uUlACrFuefK?=
 =?us-ascii?Q?2LMhoRCGXrfb8MJR6iECWFxsShchCOS8Pk4yW6yLZbeRydvq2rTx2nNvHZs0?=
 =?us-ascii?Q?BtE400XxnG0BwMg1x1Vm+Fn0cxEALoTm+kot4Y51yoU5CmmJi+GFGhB9MQxi?=
 =?us-ascii?Q?JEoUUe15T1GxYmhSJ2edWjk16IsJ8a+46FObaqRN2NOkatj9dgZMTk4GDGNl?=
 =?us-ascii?Q?WFW1061fxMHv2OyKyPk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9564d9-f7d4-40f9-a88c-08ddd4dcc4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 11:31:21.8715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPwDmHj/ULXrA1j/5HiJJPM6K+x/NbzhYTFBMd8H1DrViWyCd7zR9fOtNu/MSGTMiYZsBdqsfGDaydd2u8ZINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

Series is
Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, August 6, 2025 4:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Add caching to SMUv13.0.12 temp metric

Add table caching logic to temperature metrics tables in SMUv13.0.12

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 87 ++++++++++++++-----  ..=
./drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 14 ++-  .../drm/amd/pm/swsmu/=
smu13/smu_v13_0_6_ppt.h  |  2 +
 3 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index aa427fa8ddd2..fd06dcc2b81d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -140,6 +140,42 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message=
_map[SMU_MSG_MAX_COUNT] =3D
        MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMet=
ricsTable,           0),
 };

+int smu_v13_0_12_tables_init(struct smu_context *smu) {
+       struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
+       struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct smu_table *tables =3D smu_table->tables;
+       struct smu_table_cache *cache;
+       int ret;
+
+       ret =3D smu_table_cache_init(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS,
+                                  sizeof(*baseboard_temp_metrics), 50);
+       if (ret)
+               return ret;
+       /* Initialize base board temperature metrics */
+       cache =3D &(tables[SMU_TABLE_BASEBOARD_TEMP_METRICS].cache);
+       baseboard_temp_metrics =3D
+               (struct amdgpu_baseboard_temp_metrics_v1_0 *) cache->buffer=
;
+       smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
+       /* Initialize GPU board temperature metrics */
+       ret =3D smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
+                                  sizeof(*gpuboard_temp_metrics), 50);
+       if (ret)
+               return ret;
+       cache =3D &(tables[SMU_TABLE_GPUBOARD_TEMP_METRICS].cache);
+       gpuboard_temp_metrics =3D (struct amdgpu_gpuboard_temp_metrics_v1_0=
 *)cache->buffer;
+       smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
+
+       return 0;
+}
+
+void smu_v13_0_12_tables_fini(struct smu_context *smu) {
+       smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
+       smu_table_cache_fini(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS); }
+
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
                                         uint64_t *feature_mask)
 {
@@ -514,34 +550,40 @@ static bool smu_v13_0_12_is_temp_metrics_supported(st=
ruct smu_context *smu,  static ssize_t smu_v13_0_12_get_temp_metrics(struct=
 smu_context *smu,
                                             enum smu_temp_metric_type type=
, void *table)  {
-       struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
        struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
-       SystemMetricsTable_t *metrics;
+       struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       SystemMetricsTable_t *metrics =3D
+               (SystemMetricsTable_t *)smu_table->metrics_table;
+
+       struct smu_table *data_table;
        int ret, sensor_type;
        u32 idx, sensors;
        ssize_t size;

-       size =3D (type =3D=3D SMU_TEMP_METRIC_GPUBOARD) ?
-               sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_met=
rics);
-
-       if (!table)
-               goto out;
-       metrics =3D kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
-       if (!metrics)
-               return -ENOMEM;
-       gpuboard_temp_metrics =3D (struct amdgpu_gpuboard_temp_metrics_v1_0=
 *)table;
-       baseboard_temp_metrics =3D (struct amdgpu_baseboard_temp_metrics_v1=
_0 *)table;
-       if (type  =3D=3D SMU_TEMP_METRIC_GPUBOARD)
-               smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1=
, 0);
-       else if (type  =3D=3D SMU_TEMP_METRIC_BASEBOARD)
-               smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics,=
 1, 0);
-
-       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics);
-       if (ret) {
-               kfree(metrics);
-               return ret;
+       if (type =3D=3D SMU_TEMP_METRIC_BASEBOARD) {
+               /* Initialize base board temperature metrics */
+               data_table =3D
+                       &smu->smu_table.tables[SMU_TABLE_BASEBOARD_TEMP_MET=
RICS];
+               baseboard_temp_metrics =3D
+                       (struct amdgpu_baseboard_temp_metrics_v1_0 *)
+                               data_table->cache.buffer;
+               size =3D sizeof(*baseboard_temp_metrics);
+       } else {
+               data_table =3D
+                       &smu->smu_table.tables[SMU_TABLE_GPUBOARD_TEMP_METR=
ICS];
+               gpuboard_temp_metrics =3D
+                       (struct amdgpu_gpuboard_temp_metrics_v1_0 *)
+                               data_table->cache.buffer;
+               size =3D sizeof(*baseboard_temp_metrics);
        }

+       ret =3D smu_v13_0_12_get_system_metrics_table(smu, NULL);
+       if (ret)
+               return ret;
+
+       smu_table_cache_update_time(data_table, jiffies);
+
        if (type =3D=3D SMU_TEMP_METRIC_GPUBOARD) {
                gpuboard_temp_metrics->accumulation_counter =3D metrics->Ac=
cumulationCounter;
                gpuboard_temp_metrics->label_version =3D metrics->LabelVers=
ion; @@ -586,9 +628,8 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struc=
t smu_context *smu,
                }
        }

-       kfree(metrics);
+       memcpy(table, data_table->cache.buffer, size);

-out:
        return size;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 90e66c8f2f82..b80c4d5931c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -354,6 +354,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *=
smu)
        if (fw_ver >=3D 0x04560700) {
                if (!amdgpu_sriov_vf(smu->adev))
                        smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+       } else {
+               smu_v13_0_12_tables_fini(smu);
        }
 }

@@ -568,6 +570,9 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)
                return -ENOMEM;
        }

+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12))
+               return smu_v13_0_12_tables_init(smu);
+
        return 0;
 }

@@ -696,6 +701,13 @@ static int smu_v13_0_6_init_smc_tables(struct smu_cont=
ext *smu)
        return ret;
 }

+static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu) {
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12))
+               smu_v13_0_12_tables_fini(smu);
+       return smu_v13_0_fini_smc_tables(smu); }
+
 static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
                                                uint32_t *feature_mask,
                                                uint32_t num)
@@ -3816,7 +3828,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .init_microcode =3D smu_v13_0_6_init_microcode,
        .fini_microcode =3D smu_v13_0_fini_microcode,
        .init_smc_tables =3D smu_v13_0_6_init_smc_tables,
-       .fini_smc_tables =3D smu_v13_0_fini_smc_tables,
+       .fini_smc_tables =3D smu_v13_0_6_fini_smc_tables,
        .init_power =3D smu_v13_0_init_power,
        .fini_power =3D smu_v13_0_fini_power,
        .check_fw_status =3D smu_v13_0_6_check_fw_status, diff --git a/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/s=
wsmu/smu13/smu_v13_0_6_ppt.h
index ece04ad724fb..f39dbfdd7a2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -88,6 +88,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *=
smu, void **table, void  ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_co=
ntext *smu,
                                     struct amdgpu_xcp *xcp, void *table,
                                     void *smu_metrics);
+int smu_v13_0_12_tables_init(struct smu_context *smu); void
+smu_v13_0_12_tables_fini(struct smu_context *smu);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];  ext=
ern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];  extern c=
onst struct smu_temp_funcs smu_v13_0_12_temp_funcs;
--
2.49.0

