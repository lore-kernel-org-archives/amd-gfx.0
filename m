Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EEC5321E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 02:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA33010EBFF;
	Fri, 23 Aug 2024 02:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLwKq3b/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6081510EBFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 02:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO1UHaAEfkmHjguTIr6VPmjL93b432I76u1gJj6WM+eRx16AKBMXdCxXqGrH++smeL+RUU6SVtEv6pxl1IAz1A5JKaDGDR7cyQAj+uiok3E/McTYAQWqL30OvkM3TkzoVlQ5yk4i0Vmq4rm8rT2xFPNBzwjxFx5jZuGaP5U/FHK4+RUv7ExQjA5luXzbqfMfyb0j1Yq3dsM/WalNc/MLp7G9zXwPrOZYj4AlFu4P5H7VM1vZApU542Q6VLIoBvafZJNm/whGiVXAKvWwbBLlvm53rfb9hSSjR5EWBp+UNGgFYeHociZV2Kd7O9JjlPXMLxs6bK9n/7sSOMf3JvTfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARVDTFe5TahSW1dHoNvnOxWz0t7GmlI+apbT/7kdPMU=;
 b=SUxTrjT7bHc0jIDNy+2MfymkvaHVgqs7lRMwuWlwR8WFlYC+d0X7udjsKXHS/YcxUx2I08CAQvDGVY4kQ3c5GM2DWjfU2XF6eYNwUEWMRJypl+GMiQ9Hg6R7LNF9ZBkte/D02AD9QzHbKq77ovEbU7mWplaej3cc1sT7TWJv1z3lqPkBTKraY3HjRseV3IW0H7vIthKtsR7b9nbPtGTOFVJql00DQ8HJZXRnt+5Y9UTrXpiFoQe73usafhf+9PiaDdOUZCmsbBcPIAhOuJOPYyVi+VZ6Tekpt2uHxXMGQcuKCnQUIkUiE8hgdLUFwG+N2wiZe4Yxx0uIl90mih4New==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARVDTFe5TahSW1dHoNvnOxWz0t7GmlI+apbT/7kdPMU=;
 b=uLwKq3b/wbot3DHZXPmhYZcr7LR1FEDC1drejpkQniw/yvufMA0dA/Llb2vIrI0OTx2jOLStdBereVvCVSC/ig4zAAc55XmVlzbWkJeuLOJ8KjHGXS+daD3g8POKpMldF/1I+OzgSBO5py/Ka1r94vFTWFdJrOmz/MwibBIzYaI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Fri, 23 Aug 2024 02:38:59 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:38:59 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/smu13.0.7: print index for profiles
Thread-Topic: [PATCH] drm/amdgpu/smu13.0.7: print index for profiles
Thread-Index: AQHa9N4J8nJ2fdUQnEu4t5hA9QcQlrI0IV5g
Date: Fri, 23 Aug 2024 02:38:58 +0000
Message-ID: <DM4PR12MB5165C00EB7E87A3DC9E2359B8E882@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240822215513.8637-1-alexander.deucher@amd.com>
In-Reply-To: <20240822215513.8637-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=232a789e-a482-4783-9a19-3438986debc8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-23T02:38:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: b23b654e-7844-488f-3612-08dcc31cbdc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SPqV1poHcIof0GKNpt8bjsMDrrqU3oDb2ZVusiW3IlDNoS8O0NCdeu5wjqip?=
 =?us-ascii?Q?4XMEhQ+C0Mk82GSDBRanvWwdvjKowlrq9gO3T3kiH7IbSSxuLZRCqVcw6En0?=
 =?us-ascii?Q?gzS3GmJhnY7nZQxg1vT8BNNVCk6FxPrTdzpTqpGZRcKhTAyuMnd5yUgbpxgg?=
 =?us-ascii?Q?a2OwOEZbG5t1RmMoJBTrkRqz9aroQBiasm5kONmI6sksolV43SsFTQ8sDqbD?=
 =?us-ascii?Q?y6euiLahpEABy05zrZZHc0beXoUUMnoqpX7xDevzrF08t6GiMK2nSXekCKOe?=
 =?us-ascii?Q?9Vzazeh57URXoMvgaGtadcZvOQbE9BujMykG3qbQYn3z5yySpk9Y/ebtf7Bm?=
 =?us-ascii?Q?fGBurqawbe+PmQ3kfOA8j7MmV6PEB6LtANckSSwNB4zLq6NfwbocrhRwOZ3+?=
 =?us-ascii?Q?PFoR07xmhmdNy/z+s8I14y/xATY8SECCwtPtCmJ+vXKm/mkRRRm8w+bDSjNc?=
 =?us-ascii?Q?k1dChmcv8kNRgNcEuf33NiHeDYSILQE0dqG9IrPYXhlZmkfEF+qbrmH/o2O0?=
 =?us-ascii?Q?CMZAKi4KsWj9sYDJLGgQuIiH13WXRZHDfm0DjoBjc0K7iZvqM5gg4bTplxl3?=
 =?us-ascii?Q?aYN4xduKDCvCg0tsos5GG/sqLHgLgxCWqwmjEfNW/UFfwUZzUtw2MipOD9Kt?=
 =?us-ascii?Q?pMmLJYqcqrwzynbx6KwroDJ1GCAz42JklT+nXhjtgahppFO18MT3JSk0wBkA?=
 =?us-ascii?Q?ItZAUDOWt7Aq52p7+jDOcr8fH9S5t0OXtXi/6R4vt43IzvDoBYrkLQodl1Y8?=
 =?us-ascii?Q?IdYhSw+HBVqkqC04dML5mRuDDZBeawnEzYsP3NienIsjbk04gcqe3A1SBh1p?=
 =?us-ascii?Q?rP6+lKXHTsrEjwm09KDhATkAvIzEtISYyE8nBxwjyUkqSyoUYz8BWT/EzyQ7?=
 =?us-ascii?Q?+ysE/HJosOpXKtSeapmZR0OlPcLLbKXoPdaxuOKt+sv0Bb6J1FibuiMXrHgr?=
 =?us-ascii?Q?KclGZJaOPVdHJDUha/Jj7O4QzY+KskDdsIYu3oo9ojuSuSE1FI9JPEFMrazO?=
 =?us-ascii?Q?WMlHIY2PyKEAKK/4uzlKQB5Pd8oUaKy+sqHtsN0lieBMAhSRYhcPKTeL0UVH?=
 =?us-ascii?Q?ZVwiryS8hjiWPXK9DAoSsll297Cpnw4ryVoYV+owm6vfQEOoSY1OejVmZQNx?=
 =?us-ascii?Q?ox5PDvhi65/ChFrJGw6bXmEkTNCXkYWkJzdKQnSmVZKhN4gqHw4hdKsUR2GK?=
 =?us-ascii?Q?gipEEIRJ4GagO7iHeTm+BWjAJ2c96ZERedP6v/+OQVj+PfE7SjEKzy2pmuFP?=
 =?us-ascii?Q?YK7erOx6GJQwfAz5IQ72gebfzdmui57OS/BB2iM7MUhkwKM8G4WpLmTMZbib?=
 =?us-ascii?Q?FOdzKft7nU8d6Vt7xXEbfx6eP5AvhLZV5EUihpeiK/tFvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TjPBPgggYLWP2FVJ3uraLXOGJ0R1EOTcYVo8YMhLNX8hpfFMy5k4/LOwEfJU?=
 =?us-ascii?Q?SjdWLzqHJVxr1FPTs4DLx+p03oxNR45y/sG1plTM/gZTJwktHmRqkbFHi6GJ?=
 =?us-ascii?Q?6PmtRF3f5IZ63zcvycQTPgJx7YlTzFUEPmOvCV5pGEKnuJWN029eOpC1AYra?=
 =?us-ascii?Q?N5W61WX7Drhwq8goK3jSQZsNZczsPGxPL6b5LL+5UPUcr/n+alWN+rJl5sVr?=
 =?us-ascii?Q?fUHEyeRNuGFd2lsm5fzlZ8XkxtPR2PmfSX7YO7P9T+PoWlfaqDjVV2M6rFqi?=
 =?us-ascii?Q?KgGUA4iG6xW8+LhapS8TL/PhS5ryj/G6LCJh0dIQ+3a16D5weqwqIdUBwVQX?=
 =?us-ascii?Q?W0pLIyEMe5t/Kq2xKhHEzz6EjT8XOqfEtb4MXiFAx4bnzzFKvEYZynATmt3i?=
 =?us-ascii?Q?vZlDL3EL85rLnr7rDI/tajKOfGgMUjPaptR7kjWgjaoXlSMM0GVT/3fpJSil?=
 =?us-ascii?Q?z+BbTKlZokIui5PaeOaS+IhPoqmNryFHouFzDjqt4zZ96d62tE8wLOZ8crQt?=
 =?us-ascii?Q?nj79yZiDAUzOQE/K2Ud3yHldpnoeRVY3kUzvp7wDCpzBJCRizbIrqy25KVKt?=
 =?us-ascii?Q?GQZRAJ7WpAEC8xQ9oEApLy/UHsa+bDUtLIV5B4zaUP1ZaR7XBOcCm5nYfxmw?=
 =?us-ascii?Q?tjilFPUNxatcMbHCSV+oLvxDi51mKXlPmxXHl1+0rvTD49CSKEN0XAK2c3jb?=
 =?us-ascii?Q?qaKx9Kjc5OqlxpkxnnN9vvFOv4y2+dAoY8nJujCsnt2sMcPT/WIFoZCYmI0P?=
 =?us-ascii?Q?uWEH/uIcq/ZZVsTVqcFbQUeozirtHTmxYo+Df5nWRhGBDumcavMR0yDCf3O/?=
 =?us-ascii?Q?G5NLYq8/42MOjq5XZpVGi0Hiy8HRCICKBkDjMLmf/Wi1iqAED8+fJmg4A4y4?=
 =?us-ascii?Q?GaMSMaFYIGFzcBGkrRL5vkXRbO56CGZCnmhzF+XtsDjbxMF1+98QjObMSR/w?=
 =?us-ascii?Q?kzbCAPoV5XtoZY5HPeEMsQATpxlkSG5Uc0k3exiWrTwLl/1xqrAfkWMS3m93?=
 =?us-ascii?Q?9SG91UZu5TJY1dMh6cLexXDxaVHnhfwdA9Pj6jRSlwwNLTsHPEMJk1PDXStN?=
 =?us-ascii?Q?12EZB+ouAnecOeIAzxU5xpuCJOy9mrm7qCOoXPt9D0YUSb5JPa9sEIO8qJju?=
 =?us-ascii?Q?bGdNBI4syis3aZTSLAtkJoJq951UKiBHzkzhLF2Y46+43duxFu6jwIG3To83?=
 =?us-ascii?Q?ro8J23d7SyZCIGzJPhoeLkUP7DABTtAkNXoYN8y2QJTpa3iV1W1p/j6ETYao?=
 =?us-ascii?Q?5vh2A8wxmMC6DQYmiVHOUX5Y46/F8ymQurFmmFcAJ8DCxOrqGUctms8U1Op1?=
 =?us-ascii?Q?GoxWaTqLJ9SIZO4B+lVnbAcdTwzeoJprmH3ALzNq0dr78tVpgIISASrVb6l0?=
 =?us-ascii?Q?ZIgaXagQQSpAOOoZEENw+R1yTRHhmWRUwLMVN8U9XUb8hRbqLpQK8EEdSLwq?=
 =?us-ascii?Q?nrY1onfkHIEO448xW4BglTSiYhquLUWkFMg7eXIvQCmy+Jssr1fyuPYPcye3?=
 =?us-ascii?Q?nGuPYGA5Noii3+GIqzIp/xqocfdXClROFmcYJqdgtVgfLYA4wkP2bSQoekdt?=
 =?us-ascii?Q?VjJYjR3Mj+FN5Wwiwv4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23b654e-7844-488f-3612-08dcc31cbdc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 02:38:59.0056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjvdDQRM9I5/o3jzqft5XiKZ3wONi0/AiKo9wff8ZKyt10qykFYSsDk/H/Vb3ki1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, August 23, 2024 5:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13.0.7: print index for profiles

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Print the index for the profiles.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3543
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a7d0231727e8..7bc95c404377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2378,7 +2378,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct =
smu_context *smu, char *buf

        size +=3D sysfs_emit_at(buf, size, "                              "=
);
        for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_WINDOW3D; i++)
-               size +=3D sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_pro=
file_name[i],
+               size +=3D sysfs_emit_at(buf, size, "%d %-14s%s", i,
+ amdgpu_pp_profile_name[i],
                        (i =3D=3D smu->power_profile_mode) ? "* " : "  ");

        size +=3D sysfs_emit_at(buf, size, "\n"); @@ -2408,7 +2408,7 @@ sta=
tic int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *b=
uf
 do {                                                                      =
                             \
        size +=3D sysfs_emit_at(buf, size, "%-30s", #field);               =
                               \
        for (j =3D 0; j <=3D PP_SMC_POWER_PROFILE_WINDOW3D; j++)           =
                                 \
-               size +=3D sysfs_emit_at(buf, size, "%-16d", activity_monito=
r_external[j].DpmActivityMonitorCoeffInt.field);               \
+               size +=3D sysfs_emit_at(buf, size, "%-18d", activity_monito=
r_external[j].DpmActivityMonitorCoeffInt.field);               \
        size +=3D sysfs_emit_at(buf, size, "\n");                          =
                               \
 } while (0)

--
2.46.0

