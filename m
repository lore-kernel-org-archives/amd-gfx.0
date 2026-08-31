Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE0CC624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 08:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BF910E6E8;
	Mon, 31 Aug 2026 08:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4F8uaVm";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C481310E6E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 08:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlUpP0uy7KPaMHAmO5jmXFNqvWYEkxyQjniPMblGw+yQJaRxoqhOhXN/WmqOQ+h/SXulS7ErxXOuUjVBVZG59GJeQJ3vn1OLzGjLq3t66MomOHPzZGcGaCoCMxnKd2xVThWk3iMp1cs+e0biiraDM3mUnonP6b5gc41ZnOdaEtGHgwUxaAZ1znFiRljgFFVo8JKIXVJiMCYKsLhRW+8yyzUdPj85MuTdWuohGkzHPTkJtJbmHGKAOf1pBVoeXKoXw7P6w7tHSLU4FfyffvT1gY+h+N0U7GdjWrxOr0+EIQeUDUnDV2t6u2sMUbU0kpFuVOvtbPf8wTDVLnt4mUTYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X49lqwnh4o2S8xDfCSgnOQzWQxGGtvzxhTSrvQyloho=;
 b=zVt2GZyBBZlLUt8+Abck7kkg4uppXGXSPK5Ir8o3eZMhLLwNTIna3fXWWwoJCcgzcQQinmsndLZINuwBTa69wBUuz7axuwJULF2g3cwyLipMedwagfMtoZubthjXj3R9rsmNq76bTQ0QDmxukM3uD1zKKHwzG/EK7Et8CdQVAmKFvOiOyHjWp7M40KwTJUiy676KUp3b+fkPjsq+bGkFtRbk8u4qsdWYlZJVX1rk8uhJtJEe+OrGvozMZtIYk9D+yWi6y7EoYVqeCqHsXmd7VWRLOPdL3/tRtGvtbjdA/g/7+XO94rcuN1fH/RGtp9jAiGGQvIgpr2ecA9HNr1ZADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X49lqwnh4o2S8xDfCSgnOQzWQxGGtvzxhTSrvQyloho=;
 b=H4F8uaVmsONC6d3DP006k0hXKHtVXwZ4leop2/cGmsQOConKWbsSxMwY9Bcib6lnY68aCqz3K4AxLotIzho8TrIYBAAUnLis4UV/XNLNjzHO0DiFDXL/+uMChAxhmXkO9bbwtlgT+34UBXRxQW/8kpmof/bcsnv4TaWx8ATaoao=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:09:51 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:09:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Topic: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Index: AQHdOQIkJ9AjL5zwL0KzN17mKPT+NLa3zbjg
Date: Mon, 31 Aug 2026 08:09:51 +0000
Message-ID: <MW4PR12MB680329990EAECAA7EF692FF78EA92@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T08:08:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SA1PR12MB7101:EE_
x-ms-office365-filtering-correlation-id: 1c7fc4f9-1683-483f-f954-08df07373b9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: gL2O11tb/CnmOzmLEZX5SiGUknVzSo1t12MmiaRa6g7epKZDXBxXvMMzvTUVMmo94g63HLGiZ9ql95Dt69ZynpSlsGidxda4CMn4lqCZxb7uwyimEPgovuzXEzQe0MLQDZLu6ksSvW7PZPZ6WD7uFJO7jAj1i7zbckbhiVrxT86lMD73Mr0qZS+Pj/fTPCXk441tpMuWRYNkumQXfqLy5bkoESKkPQ1RH/+O58Y4cjNRrngVzb0Spe2xqVQFLHY3ZeHUWvePwpwquFrN/8OGxco9OxgU8WNCzKLn/OD0x0nyg7cV1loW0utFRo6psmq07WlEePqiU9OPY/1Exw0PwERb3Ba1VNrc6hVZj18NiqQQ3TE+RaEBi5VN+/jASYji0SwTjX/hqxl3w1KrL8uINVdd66UEUIKvaFlSyQFkMr9BmFlD97dmBKVfVfl5e6DpQTLtVY0LhlQrsbKnkEd6s8DlzayLgsiHNKv5WMvBIb94XY204GhE0Dl8N9FFNTgB0o3UCLjmniPX1yUjNAPp1LoDOm7kdj1/GroOR7kiSjUniONXwHw/vpIoRWL8ueaDK0DJuZfufK7fDK+7Un9lHmH8Mtcmia2HXqXsQAWKs42WQl5Imq7JH2JaQgUVnAx6WaiDVEFc8GDlfoiy6msOaALLK7QiPV2euRvlqqKJ8Mk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O8Ym5FiGTttig4U1zcCeQ68zic22hw4JeYQI1VDd0j1gTiIl9kC0hO1o28Ed?=
 =?us-ascii?Q?r/MDXQPMX4d7jiknow7Erd0jSQMD6JOHYaOxK7ijQX2rKeCx1XjB0wUfcfxW?=
 =?us-ascii?Q?B/r7iGd+RYLlqxYsX9NENtU1JF3JMwkVZ23r+VwKVVC0PPrMIFQSGSbxT6H+?=
 =?us-ascii?Q?meVBdYYs4VDb0JnSrmUvgEnJfAyQ+ci9vDEtPK2K98idwkxHjkU9vyO2LbC/?=
 =?us-ascii?Q?WxV3UK0rSfcUrJm5NcKMU6Md183q/ZQ8AVGPvoftlMQ7qNw/tLMqk0NdYu9F?=
 =?us-ascii?Q?Q8tGe/tE6ACkoczIESeN1CZW+JCkBVypy6Mv3oAnec1ryv9jH3cxQBOLtkii?=
 =?us-ascii?Q?8HVLd7N1mB9JKO43MqahH+sCfzQuD/Hot96ACRlcCAEn+UQ0aEVZWitAwoH/?=
 =?us-ascii?Q?33Lz/LeDLWXr8UEAnVF4M3s2I8he3moVQNOYr7UvAe5NSrwDmvcUAvkz+ugU?=
 =?us-ascii?Q?ERO8gId0auoV9Bpo2HvJfIxMkwBsNzXryh2k1Lb00VaKCA+pth3bFemmI9FK?=
 =?us-ascii?Q?ffu8SH5LakNKja36njlDwwfgKA8BFRYiPefZeayLo2hgBkx+y1xzvKJXtzIR?=
 =?us-ascii?Q?JR+uHJ2PMpvjJP1Zl15LiNs4ckbJDnk3mZeMu/cq5foYVCJAl1aMBvyN1tm9?=
 =?us-ascii?Q?MA6zHEnW18e/2gDzNWI6IXTn3Bv+nrmSRZDmTrzFUAAd2hGYQ8j999H9gyth?=
 =?us-ascii?Q?mGt7eMuYWbEr2uY3eZ7mUnjoObbXyzUS9n/Psc2JJU71Whvi1XlGaPKGP+AY?=
 =?us-ascii?Q?s5e2hv3KQ9zBFDQ0tRdEUKohexxgGVWt2uDvXzfzJ0ckgjiXPTyW6gC8xvUI?=
 =?us-ascii?Q?aDjNpHMhedtyUx0dZNNX27bluYF9XhU4+/T51VOCqB53QpuRCVFX0yxkrkdH?=
 =?us-ascii?Q?tmYBw/ZLQecNV/b5TQI58ATxEy0XTp/BmiW4GCPWRDOQO1jxspO12tk8ex5c?=
 =?us-ascii?Q?OIdMC9vNIgN0cr6DD99Hi540m5dsk5j/PGhdSzgndMTDPuq0fVZL2bbdBLm8?=
 =?us-ascii?Q?cgrdzTkHCoiAc9YQk3R+jwd5RkjfDW2nbC86au7qL9PB8oYT2bBc3hdirNBK?=
 =?us-ascii?Q?7QetielD8ZpbIRKYw+d4SvbFuueumuS1FbmVZ69QfcGJdIVIL/kH3MBDofeb?=
 =?us-ascii?Q?s8SBIMyWRmjyCjSvheGOCDeJOdpKCf7AIlXUsOXvLL55A5w0TFLVK9YIpGdr?=
 =?us-ascii?Q?Vi7HiPYnpJi2dcWeFQcpl1Y2V00tUVvroKUSDPR+49fzYWuxqCht+XTkKNce?=
 =?us-ascii?Q?hX2Nyo5uT0Saqup0lEBxrNK21VSkxL0eyNbTC29IHRfg4gNMgJG7uuYjm5/8?=
 =?us-ascii?Q?1TGrK4gNlIqXiCcPVTNCrchPD6wFbWYlsnkV3xrC+61Jydv4gUaGRTErIzNP?=
 =?us-ascii?Q?gy7khvXP98Y+ykJfwo2iURNdLEROMDjhXUInbY+co2E4toRMIPNtJ0HWuRzw?=
 =?us-ascii?Q?xukaAmHZrCI5KEKeVjjJBQ32uQx0ZcqBJskeDy6zMVFn1J2o6ubqppw1L3Sm?=
 =?us-ascii?Q?43bQzOOIdzT6yS3EnV9iVB5368TwQz2jYsCA9db9MwoP6333bI3cS278K4Rs?=
 =?us-ascii?Q?OX7znsvCAkJUG7maA1/c2wCg/rcROdEQuL+1Nh5Ua7yMd9lGwN2/cr5cSsW4?=
 =?us-ascii?Q?iFyV1Gnzysc3o4k5OUJ6gDQC98UfcTQ4h1I8wKHnvOCOp44qKO3A29ZFzRsv?=
 =?us-ascii?Q?fdxefIYVEVQzfB6Y6CvXin5qurKxZjID6eF6dizqy+idu1ds?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7fc4f9-1683-483f-f954-08df07373b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 08:09:51.4324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfYighWuMP2j8gobL3UxPa4CgyoP1dxL9ZpdvAzXrEVfbh4qBnY/KFzyqUuDGAXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

The uclk setting when uclk dpm is disabled looks redundant, other than that=
,
Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Monday, August 31, 2026 12:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 0/7] drm/amd/pm: stage OD reset until commit

The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
users edit clock, voltage, and power settings, then write "c" to commit the=
m to the SMU.

However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow on every=
 SMU version. Some backends restore their cached settings and wait for "c",=
 while others upload the reset table or send frequency-limit commands direc=
tly from "r". As a result, the same userspace sequence has different hardwa=
re effects across ASICs.

For example:

- SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
- SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
- Navi10 stages the boot OD table, while Vega20 reads the current SMU
  table instead of restoring the saved defaults.

This series makes "r" restore default values only in driver-side staging st=
ate. "c" remains the sole operation that uploads an OD table or sends frequ=
ency-limit commands to PMFW.

This gives pp_od_clk_voltage one consistent transaction model:

  edit/reset -> staged driver state -> commit
                                                                           =
                                                                           =
                                                                           =
               It also permits userspace to reset a staged configuration, a=
djust one or more settings, and submit the final configuration with one com=
mit, without temporarily applying an intermediate default configuration.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690

Kevin Wang (7):
  drm/amd/pm: stage od reset for smu 11.0.7
  drm/amd/pm: stage od reset for smu 13.0.2
  drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
  drm/amd/pm: stage od reset for smu 13.0.6
  drm/amd/pm: stage od reset for smu 14.0.2
  drm/amd/pm: stage od reset for smu 15.0.8
  drm/amd/pm: stage od reset for smu vega20

 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------  .../drm/amd/pm/swsmu/s=
mu13/smu_v13_0_7_ppt.c  |  2 +-  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt=
.c  |  2 +-  .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
 8 files changed, 145 insertions(+), 88 deletions(-)

--
2.55.0

