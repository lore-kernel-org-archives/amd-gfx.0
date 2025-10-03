Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6934ACCA470
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 08:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B0D10E0D5;
	Fri,  3 Oct 2025 08:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdFVKJuR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4D710E0D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 08:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCC482JNWpxyAM64Drvo1d3ApyzLVny4aZ5MbmY7XgXA1KAT4SjRVz2GvfAzQS2CzVNdiZkZKzGWT453M2Kp5II8Jtg76twvQSzVNmJ6PU/Xvs+vLvK75zqjflIKQfKBGTnvlD9KVcD8n/4/hqXw/mNSsIHWti+Q0dpK/Ft7vj+fDXSzOrLYClyQFfWWzI9HaYu1ANr4dmAm78Ee7XNVlAmlN7NvD+30Im9c22RasEZv6GoCeV317uMymhkVX7ijQC0e0+qQpOEpCfFkPSK8tVL5fLfx/gamJxfWRsQg3f/MI0V81NGyEaejO33f9dy/4itMNzILTIDzTIihu0F2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ea6lBmRkfmSOObpwpO/6KOO+GKBHGCuYvzFOVm3iA9c=;
 b=CEiPmHFVoociG35/c5Y2zwIuBZouRkxK6BbDA+7w3yPmbXP4uMh3EBO+b7VAzk/GvoQ5NZyY4eMz/jhtiw511f6y3tyJOIdaA6o/BrLxs1KmIOxwz96QJpyqEz9blKx6SirkiA+zm77caN36qa2wg+3i6r33279FsXKlA4pOp+uAqgyhX2zP2/81sn7yMvcLBFsOQQ/9x+oXFyPe2GTRxaGbUGKAyCSGLuJNvald9bWRyDymtvTuI78p5kNPMyyJFmrKPYSOWwIiFd2d2sfn8ZoF5s8YDbiuvSgNiOFcEUAPJfY91Lsanr5jhBwSEdCgFXm9L6vinIZa91W9dZUVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea6lBmRkfmSOObpwpO/6KOO+GKBHGCuYvzFOVm3iA9c=;
 b=IdFVKJuRt/a2GCd0zEEq+LcFWx5Xh1m1GdKXKpWsS8xLkF3Qv51YCihO7rU1PPU6Nf5fOisNl35mAQUfGR793AgB0UyhW95gIQSG4JbQmo/zsVJT53r2frJndWg/VR32ye3vR8Hcf8Vc5k2uvRO+iBzDZXrw+JoRbzjfZvcOo9w=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 3 Oct
 2025 08:32:32 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 08:32:32 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd: Stop overloading power limit with limit type
Thread-Topic: [PATCH 2/3] drm/amd: Stop overloading power limit with limit type
Thread-Index: AQHcMv3CIEvByNhlKk6S1w2urYs4FbSwGEjw
Date: Fri, 3 Oct 2025 08:32:31 +0000
Message-ID: <DS0PR12MB7804F48C1276F7B6A77CEF4F97E4A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251001180335.625453-1-mario.limonciello@amd.com>
 <20251001180335.625453-3-mario.limonciello@amd.com>
In-Reply-To: <20251001180335.625453-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-03T08:31:48.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|PH7PR12MB6489:EE_
x-ms-office365-filtering-correlation-id: fe044b09-7e3d-4106-019e-08de02576574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?po7T8riorozNfK7nqZTPfqB03OwsOX7DgFdG8dsuMYmh2Jk4+scBSS3aj3iU?=
 =?us-ascii?Q?DqupA0RYDk2lmJzN9vWBT0NlD89jGByxqKkIIo0wVq57OxQygPEBBjapVNUZ?=
 =?us-ascii?Q?MaWAFo0sKOdh8XSgdDxEhgq/RbGCbGwT5/D/yKRrREBuOX5zudfHDTczZ6a2?=
 =?us-ascii?Q?e+BoVYtbDbSXP3RBhwnwB2CZKMJ31wiGhxO1Q4KNUWBj4D4ixAru31d3wa8n?=
 =?us-ascii?Q?AkiguIcvWf1/GnY1gxo7l1KPTZ8arDl1QHPRlci6uFCsv1I6A/6iaHBF9DT0?=
 =?us-ascii?Q?8ZO4ru5vsNhn5BdLWAdwMOHEvw44+e+Geph0DWka7BKuBwKBfqGE2R/Fjgsq?=
 =?us-ascii?Q?DtHFIp+vhrwId9zPw5R/WolgBYeDPRShd646cPS7UeNgkqkQkpkAXm6krdJz?=
 =?us-ascii?Q?shnl24v2uL+kaZNdpxjjJu8JzJoCzOpsY3RwftbakCziUUf60KQZc+lyeD4X?=
 =?us-ascii?Q?rtpxmbdJ0Fqhxl9PzrH4DB6/v2CIMmLtFM4Lt78Ums0gmKM3Bdl6g45n+H6g?=
 =?us-ascii?Q?9jcP41IYU0cdJapzLArrhTjm//4W2OFBnXZFOmKfLguFV/t3hKx5daILsZZ5?=
 =?us-ascii?Q?ua+HwbgxqXC4O/c34nWPkb5wFEiODShDRX4Y+ZPbWOFNJlWWFzUgrbH3nOHf?=
 =?us-ascii?Q?hWtFRqwS9gottefVyMRb7NPMgbgHEc44mju0lQ1o5weZiBBnibwixq4vyAjh?=
 =?us-ascii?Q?toj4nH0hlj1CMO2TJTH4UZliVWwXaDAc39CpAOuqC6mJsGg/jL9cOZRRTnyi?=
 =?us-ascii?Q?OoZWIWlZr18PfG/XL3ZOYJYoZjbrYpgRI+SAuLPsei797SXQxpPJNCf4Huef?=
 =?us-ascii?Q?l8OPpJ6wqQsgNZGdav9y/45rurAlycv+/tDh7IsIawm/I5hj6s3qsyoqn4U2?=
 =?us-ascii?Q?Ix1jMz5cYDUISYMTAFtjBfgOP9ZqYtTreByVCsRmRoZhjCrm1b+NUP1rDhG3?=
 =?us-ascii?Q?PqFUCDVsxcCubgv9z90KM3e7g3KEGJuGSDwh3j+auN69d78BiLyHbCImStui?=
 =?us-ascii?Q?mPCF204PQwWWYIoNXxHGN2FUk+MBE6n1R7VKcwHLETFvzy2JYBTcSowAt9LB?=
 =?us-ascii?Q?d2+VVrTlJqmDggPiLlWzjRzqF5dn4/YOyN5V3bf/rRpdrEKfUyJ0XwvIRF7l?=
 =?us-ascii?Q?sLy4ivrQlckA80nsFNzO2sYLf6YAPLwQYm+Dcj7MtMA4JryZ9yCU+/JIsr+R?=
 =?us-ascii?Q?2CJliFVPnrY6Pa5dMB7df86IbHb9Hz2uGG/02TItdV6baUXEdiUZ7PijDHZp?=
 =?us-ascii?Q?ga3JU5yhQvU1VAPlwVebVzaFqO64p1cr1P3tR3H5HxKLs/0kcvFkKY9NnOjP?=
 =?us-ascii?Q?PkI9moQ+ySzt2ohEemy7LR6SPibdGAWHUSzJwCGNgexPLRyZOJdn6PuSDs2o?=
 =?us-ascii?Q?AlPCobYub5DFPECdYgpUJKAQ6836/TDWRERLXiBEflS2S6t4vy9pYtOXLcEc?=
 =?us-ascii?Q?jGqIEwe+xDTm6dccS9CnvhsdU/XU0kM7eiT1LO3Er9tO4CQddB7Y+lrDiBe+?=
 =?us-ascii?Q?z+gXMoz6G5C974nKRyHwbGZUA/0OLHiA0EZ1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Wr3LVMlXqZd7usEI+X/qF7TApCzSoWAKuRtiwWnFNT6U3KaSRSdKAi2xQF7?=
 =?us-ascii?Q?+wm7mFe6+jbzux+a9GjIt4oWg4PDYIL4PUs1CHDRHvr8UmJVWPVahigfcTZb?=
 =?us-ascii?Q?ZYHqg0rd+i67Bq0bvXNOBLM0btYrHtKnSMA4XCVcC3p3UIlBYll/yaYOARnX?=
 =?us-ascii?Q?YDvAQiZONgtm7wHBqq4d7OgqMHh91SU8KMvaoR+ztfyFVmw9lx8EJRH9CL/T?=
 =?us-ascii?Q?fjJUqyrwUkS6wD5MkKshGfLXvpmeGw2VeUpJnE5NoRweBX3MWDfv3U+SMi/y?=
 =?us-ascii?Q?PNdKZcYnBRtVKiOd9DvjJY/mTT99318vt2KDGYm8cUU4Cu2qDBOww04TzjZI?=
 =?us-ascii?Q?B5MBTSSFVt53S2YqjsR2Y4xOfMRWXTgOxsXawfxwV1475/Uggwf9yN1eSYNc?=
 =?us-ascii?Q?oKP/j8ZtTYS0IN4bFYIPVCf/q+U3Dg6zb2vy6klXDmHtVY30tM5GNpmCDjCf?=
 =?us-ascii?Q?SoKtOvLp9R16nm/zIEX0L1kRqKTNeR+YBiAQVcufwwDOGARUJ6I6JwOIMH30?=
 =?us-ascii?Q?bRt5Lpf0Gz4SeD4peRJuP+W4GiMFqpMEYTY8juqiFiAb7Q1PkV3tAQLUnAZp?=
 =?us-ascii?Q?c4KCZ7P3TQHE4RgvbgNPgmLdIJv0p2L73CKdL4s7yEly8o6Hev8pL9o0O9+g?=
 =?us-ascii?Q?i7vcR8wY8QFj/3DvQO/1vNrzmlmQwOE+ZzNhjVSev/6PhDp6ryf+wJ/EYZ+i?=
 =?us-ascii?Q?8E83Ff2vNoz6VvB+/qLQH4VfqsvRR4YzVhJf1LdZHer0k3jtjcKWhIfRMMzy?=
 =?us-ascii?Q?ZzUGxtCcjZWHIEVlt8hc74oiQVKgK30RItDnhAghtsqCodDMeuLY7qu6O1MX?=
 =?us-ascii?Q?0v0orzkHCZe4iMUz/oGlHynCBPoUkaSsXdvQIFwXfqVAvzYX2wH8YocrfTxG?=
 =?us-ascii?Q?mws4P5wJDzAFaNSpeqYhOuza1C4kVfw4CI8NGuFxDK75uoVGSVviqiCrA1wg?=
 =?us-ascii?Q?KfnoMHQ1BtFQcicQ/TA6t1Hc7uKgDkKXcl2I77RYgRugFmAMQfPZoC1aK8WZ?=
 =?us-ascii?Q?JV4kCfdFVK8XNx/fDCNYY6JmhsHYRL+jlgGVZfRNyHgz/H1P1RpGzfBxSliR?=
 =?us-ascii?Q?yDb3/k5o5TvwTkxvvbH8GiLY7i31/kO74d2aaZArRtqhxqK4Xc5kYahUqe0h?=
 =?us-ascii?Q?pbdj5TD002Z9HAufyVZDH3bxB0vGV1fCZLb/qSgVmU6c5LwYr0NSc4UHYnvZ?=
 =?us-ascii?Q?covE/fk6dGHcYCnAz94E/1OOJLn5kMTI2QkdSlFBAePyKRfegYilxazZSbJD?=
 =?us-ascii?Q?9UOEU0wzLXv6bnK4bik1Q/HVnifOWo0tjLVdPZ/xFlc0NSBLZBRZ155spEm3?=
 =?us-ascii?Q?gtHZwlzRqcoth/oYKDns+cZAv3nY34j8Id1P3Pi5hjgsGxq+F9A2uRJ2L0f4?=
 =?us-ascii?Q?58akQO4kyc9OyXHODoILSKQ44UfxFIhRMLMSaQoeCEsIhlkXAHexUibqV7va?=
 =?us-ascii?Q?XBXWG+FGWQML94r64eTIQnW3zMK86H1CvD7elhuGEhvtB2gg2ZKnTqJmZQei?=
 =?us-ascii?Q?Ni2zQmTa+4OwYh33Va/i4E7C4v7k/vqmkCEHsMuHDoKHUumLi67jsFOMvUYB?=
 =?us-ascii?Q?FclSPASTprnPIsyCafk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe044b09-7e3d-4106-019e-08de02576574
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 08:32:32.0481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tjyKzEycWLZR2PjL89T8eAdCqgz03KjfE2xVWVkansF+qYiQqp14lIAr0/pn90D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

[Public]

Patches 1 and 3 are

        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

For this one, suggest splitting to two patches - one to pass the limit type=
 and the other to save/restore fast ppt limit. Could add LIMIT_TYPE_COUNT t=
o enum smu_ppt_limit_type and keep an array in smu_user_dpm_profile. Howeve=
r, this fast ppt limit is only there for Vangogh now.

Thanks,
Lijo
-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Wednesday, October 1, 2025 11:34 PM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH 2/3] drm/amd: Stop overloading power limit with limit type

When passed around internally the upper 8 bits of power limit include the l=
imit type.  This is non-obvious without digging into the nuances of each fu=
nction.  Instead pass the limit type as an argument to all applicable layer=
s.

When the limit type is passed around it is apparent that the user settings =
for power limits are only being restored for default limit not fast limit. =
 Save and restore both.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 7 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 20e11997437f..21a83ee87d84 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -445,7 +445,7 @@ struct amd_pm_funcs {
                                bool gate,
                                int inst);
        int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
-       int (*set_power_limit)(void *handle, uint32_t n);
+       int (*set_power_limit)(void *handle, uint32_t limit_type, uint32_t =
n);
        int (*get_power_limit)(void *handle, uint32_t *limit,
                        enum pp_power_limit_level pp_limit_level,
                        enum pp_power_type power_type);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 71d986dd7a6e..3458a7d4892f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1605,6 +1605,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *=
adev,  }

 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
+                              uint32_t limit_type,
                               uint32_t limit)
 {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs; @=
@ -1615,7 +1616,7 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *a=
dev,

        mutex_lock(&adev->pm.mutex);
        ret =3D pp_funcs->set_power_limit(adev->powerplay.pp_handle,
-                                       limit);
+                                       limit_type, limit);
        mutex_unlock(&adev->pm.mutex);

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 08cd324515ad..37428eadfd09 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3172,13 +3172,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct de=
vice *dev,
                return err;

        value =3D value / 1000000; /* convert to Watt */
-       value |=3D limit_type << 24;

        err =3D amdgpu_pm_get_access(adev);
        if (err < 0)
                return err;

-       err =3D amdgpu_dpm_set_power_limit(adev, value);
+       err =3D amdgpu_dpm_set_power_limit(adev, limit_type, value);

        amdgpu_pm_put_access(adev);

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 768317ee1486..4291471187f6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -555,7 +555,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *ad=
ev,
                               enum pp_power_limit_level pp_limit_level,
                               enum pp_power_type power_type);  int amdgpu_=
dpm_set_power_limit(struct amdgpu_device *adev,
-                              uint32_t limit);
+                              uint32_t limit_type, uint32_t limit);
 int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);  int amd=
gpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
                                                       struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index 9041002dea6a..ba72b08a0edc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -952,7 +952,7 @@ static int pp_dpm_switch_power_profile(void *handle,
        return 0;
 }

-static int pp_set_power_limit(void *handle, uint32_t limit)
+static int pp_set_power_limit(void *handle, uint32_t limit_type,
+uint32_t limit)
 {
        struct pp_hwmgr *hwmgr =3D handle;
        uint32_t max_power_limit;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 431333060b72..a5f40503b0b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -68,7 +68,7 @@ static int smu_handle_task(struct smu_context *smu,  stat=
ic int smu_reset(struct smu_context *smu);  static int smu_set_fan_speed_pw=
m(void *handle, u32 speed);  static int smu_set_fan_control_mode(void *hand=
le, u32 value); -static int smu_set_power_limit(void *handle, uint32_t limi=
t);
+static int smu_set_power_limit(void *handle, uint32_t limit_type,
+uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);  static in=
t smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);  static int smu_=
set_mp1_state(void *handle, enum pp_mp1_state mp1_state); @@ -508,11 +508,1=
8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
        /* Enable restore flag */
        smu->user_dpm_profile.flags |=3D SMU_DPM_USER_PROFILE_RESTORE;

-       /* set the user dpm power limit */
-       if (smu->user_dpm_profile.power_limit) {
-               ret =3D smu_set_power_limit(smu, smu->user_dpm_profile.powe=
r_limit);
+       /* set the user dpm power limits */
+       if (smu->user_dpm_profile.power_limit_default) {
+               ret =3D smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT,
+                                         smu->user_dpm_profile.power_limit=
_default);
                if (ret)
-                       dev_err(smu->adev->dev, "Failed to set power limit =
value\n");
+                       dev_err(smu->adev->dev, "Failed to set default powe=
r limit value\n");
+       }
+       if (smu->user_dpm_profile.power_limit_fast) {
+               ret =3D smu_set_power_limit(smu, SMU_FAST_PPT_LIMIT,
+                                         smu->user_dpm_profile.power_limit=
_fast);
+               if (ret)
+                       dev_err(smu->adev->dev, "Failed to set fast power l=
imit value\n");
        }

        /* set the user dpm clock configurations */ @@ -2229,7 +2236,7 @@ s=
tatic int smu_resume(struct amdgpu_ip_block *ip_block)
        adev->pm.dpm_enabled =3D true;

        if (smu->current_power_limit) {
-               ret =3D smu_set_power_limit(smu, smu->current_power_limit);
+               ret =3D smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT,
+smu->current_power_limit);
                if (ret && ret !=3D -EOPNOTSUPP)
                        return ret;
        }
@@ -2929,16 +2936,14 @@ int smu_get_power_limit(void *handle,
        return ret;
 }

-static int smu_set_power_limit(void *handle, uint32_t limit)
+static int smu_set_power_limit(void *handle, uint32_t limit_type,
+uint32_t limit)
 {
        struct smu_context *smu =3D handle;
-       uint32_t limit_type =3D limit >> 24;
        int ret =3D 0;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                return -EOPNOTSUPP;

-       limit &=3D (1<<24)-1;
        if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit=
)) {
                dev_err(smu->adev->dev,
                        "New power limit (%d) is out of range [%d,%d]\n", @=
@ -2951,11 +2956,21 @@ static int smu_set_power_limit(void *handle, uint32_=
t limit)

        if (smu->ppt_funcs->set_power_limit) {
                ret =3D smu->ppt_funcs->set_power_limit(smu, limit_type, li=
mit);
-               if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PR=
OFILE_RESTORE))
-                       smu->user_dpm_profile.power_limit =3D limit;
+               if (ret)
+                       return ret;
+               if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RE=
STORE)) {
+                       switch (limit_type) {
+                       case SMU_DEFAULT_PPT_LIMIT:
+                               smu->user_dpm_profile.power_limit_default =
=3D limit;
+                               break;
+                       case SMU_FAST_PPT_LIMIT:
+                               smu->user_dpm_profile.power_limit_fast =3D =
limit;
+                               break;
+                       };
+               }
        }

-       return ret;
+       return 0;
 }

 static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_t=
ype clk_type, char *buf) diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdg=
pu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b52e194397e2..19689ef1db99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -231,7 +231,8 @@ enum smu_memory_pool_size {

 struct smu_user_dpm_profile {
        uint32_t fan_mode;
-       uint32_t power_limit;
+       uint32_t power_limit_default;
+       uint32_t power_limit_fast;
        uint32_t fan_speed_pwm;
        uint32_t fan_speed_rpm;
        uint32_t flags;
--
2.51.0

