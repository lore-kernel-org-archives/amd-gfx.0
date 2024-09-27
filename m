Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFBECEBF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 10:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846710E19F;
	Fri, 27 Sep 2024 10:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x46OqpxV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFFA10E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 10:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBLPfJ5EjVLwH08dLUisLcIMLvMBs9yCwbHH0M/C3jlWh+N9WX/L+zdnvg+6bDXwqZk6mtehHdXDGzEJ92CQYNBqkq/4YyxTVLH3jyTWama+L2ngxrauR2cmt0A1z01ONsh3rv8BEdALxTcA08uxP7p97sLMxM0zeBHkWNtSjZHMIspaHaCUpxUgb45h7suKch9byvUEEgDLZxtaMDhFc/qfViH9yh4D1n5PH+RxjWOR59vR+mjgG0KMNHvi4bA5gOU/ia9uaXNyCgC5fBWV637MCRAWDSyvJY+3flaJ9pdNlPWHtAOtUEIYZ+5+F//f/BinzBoI6bXZ3EkI44B4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voAw7U9/rfD3nK97lPwolVKcNlqn+k5Hskjk4lSpSgY=;
 b=yuZmVACuYXy5997Cl9IOVTE9BYxnxGQq+80CbJyhy+RevaWHbiDL380KKBU6bYWlPK/92QKy9Sn5C6avPmejDsKI/nR0DDIazhJXDagjQcneFORyITE5w28bW79E1oGYWl7Jos8XovVSqxqjDQjkwCduNVDDtWInjBqgvaHPENEQeiBXpZoac9xNba3fFRhQNcqHPTUJ27CpNLwjc9X4WseaMrwd4hauvhSJZ2t+r4y3y9iduKBPJEeq0qZNZw/JAp9kLPO//caIw6VqI7RAVocgC2jrfyNTCRMhFuuFR100eE9/sx0fD0da+6ESDqS6P6aEve4bnVp58/ZC55TJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voAw7U9/rfD3nK97lPwolVKcNlqn+k5Hskjk4lSpSgY=;
 b=x46OqpxVHvHu8jb//+o+gR2BGqgkc+YaIgga7fFGT8TVzMvwahbuLudDJbuSsIJVO+WFUKMW1IavRmOD7H3RRBOzxOfQW66NUw0vtHtRhx5za8BEqqlfFqN7ySaMKfuId7gWdd3rr6wrSUoK3U1DCcS0h2wa/mHA3+G2q/APgYk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.22; Fri, 27 Sep 2024 10:15:36 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%6]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 10:15:36 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v1 0/9] drm/amd/pm runtime pm changes
Thread-Topic: [PATCH v1 0/9] drm/amd/pm runtime pm changes
Thread-Index: AQHbDyBxaudjMcLT70yn2UJBumxyM7JrbdDw
Date: Fri, 27 Sep 2024 10:15:36 +0000
Message-ID: <DM4PR12MB5165D23A00278D5B836FE2078E6B2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bd0536af-ace6-4014-a07b-bf155e0ed26b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-27T10:14:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: c5655b05-2d52-4651-6c15-08dcdedd5493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oSfW71Q0OsCSxjZ3sInWjK4rbKJVWhZfc98U7wsnVk/b0J0wGJcEe8h9boIG?=
 =?us-ascii?Q?21t56KaqyBKFoSqn4Z/tHpSHk9wlThHLDfirilMtt7VAbXovELTTaRcX24W9?=
 =?us-ascii?Q?aNKhv4i5UaUBwmzDG23NC3F844pU0SKye+3WHwt0mFqTGtLztNYVkfk9ZJfo?=
 =?us-ascii?Q?8dduOKN+lWArHE3bLOJXKvmtVJz7H0vBnKEG18quXoo1uPc0sAzgOq7aHrkF?=
 =?us-ascii?Q?bcAnPlM0rLvHuiErKVIi/CVYXxGujXdhQkrYdXQAxkQ5gTeMee8mZrsS8S6I?=
 =?us-ascii?Q?8RhikD5RFGv42l5AqYMKLsgz9+nwt8UvL7NJMxergZBbAOoCwGvqUFXxm3M6?=
 =?us-ascii?Q?LODNzrg4c/UZRkLr31gcrKlCkEp4N4oDzl8WWlcSAVp0zjb+cohchreara2S?=
 =?us-ascii?Q?/DvlFTq5Ek5XjjP8/6TlWx8hlZoBwAKD57B/vxZV0Ls4N00qf7nOTiuIAc7x?=
 =?us-ascii?Q?t/cxJr/txgKpRp5QWQzLw5K+geflwey9ii/K511QKaa9lrWJubOPBnK5XmuJ?=
 =?us-ascii?Q?xEfZNn4V2TobsUJ+Pgb1jVKzLSUG5i+I0JekFAVgGzm0uLH3+0Q465d5gRJS?=
 =?us-ascii?Q?nHVR/+OHDdF2RpjuG02Ly0TLGo06gYQapPlF5thEGr3ylXcpNQAI3vLrexZr?=
 =?us-ascii?Q?/x1wCLeB/1L22N0IH06U9ld7iZ1wGvmJCTZVBuAgyHbNJmaD0ye5EFe48Ok1?=
 =?us-ascii?Q?KF8Q/lIHvsyy3sgI4oPY3X/TanFD/tpE2uWg1nmDFPO0FGEONMZoEP6TRI1X?=
 =?us-ascii?Q?zEwUWMGjR+abksxC6gJarIASuUWMk5x2PVj9ve6lvBZs3+N3lqOMKNzXglsk?=
 =?us-ascii?Q?mZudMrPatDzZuuIIrM3o5EQA/Y2e+z706CGSoALv7rwfeWQagI85pmgqQLS0?=
 =?us-ascii?Q?TGl+6GbBhRUygDnUq/ry184zGY2yVOKxM99wcNDNBWRzxKdnI2RIw30V5uDP?=
 =?us-ascii?Q?SRWVCLXPf5HWXEtZHnrlEjuzl2dHVXwSiZRPSn+vneS2WqPL+VQB99Wzkf+z?=
 =?us-ascii?Q?VEPyhGmPPwWUr2FBdSJFQCInVYr52idzXER8BrycyHOafRWEL3DWae1DEItG?=
 =?us-ascii?Q?kowarH6N1NkxV9BaG1b7Klaj8aaxQeiRa1SJ9BsyIGtUYwgpm8ZjgRAHyg8d?=
 =?us-ascii?Q?XRtJOxIyv3ANPi1L+OEikhW+mXQSbq4Z4FUcj9jIOkj+eC+t3Y4N53IUmc/C?=
 =?us-ascii?Q?AOh7kF9+wlY31xL8TSsfTIG5LFaAPnMETsJAtdPVbbpT0xZPORrQ1QxSxDed?=
 =?us-ascii?Q?8oGeBHCQysv7jwEEgRKnJ52yJG3Sq9Ux6CMqFc77FQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+ANK/pBYHjPuui8/Ci42W6nq/eae/GKdEqlvrTcBoHFeaBVky6m/7Q6pyeB?=
 =?us-ascii?Q?nmRu4GGv1++k+sicJlk7pNyDhHDHgWOTQetbnHtpAPISvOr4yWcu5WrSgsKU?=
 =?us-ascii?Q?SAfTCq5M3f9bbdovefE6w0N51rM60qWo3rLi5uLvYnR823xw1YCDIMs4J/ZS?=
 =?us-ascii?Q?qTdKKpCnydCjcx6kRhv1EdmKEfyeceaLcDkhxRfHNkEbEZJWqe7qfEgPaGSJ?=
 =?us-ascii?Q?iZJPTbA4my++kaXtMYU20XW6L82QneyJbLnlf7a8aozvwqOY/UzNTJtN67eF?=
 =?us-ascii?Q?aUTJ/uOubeIdJm+Fm9KihdmDXg3zmxKl5SIoqsGigCuCYEUg8AsrapoWH+5N?=
 =?us-ascii?Q?eQBYYTeEbZr2aYKK7blopXl89IlFTafYstV1jV4eNVqa9JGMtBDFTV2+7NUT?=
 =?us-ascii?Q?oktkhQWsY9W85VxHhL9+PY3FkIUJDKoeDbPWtFifPgk+lFOyFovZdtzBRtT3?=
 =?us-ascii?Q?VJa0okpuKkMN0LfWIY1699X/X/HH3A5TmcDR3JONJYIj7KPiWmA39wO4zfks?=
 =?us-ascii?Q?gxBdKbLGOkhnYACEvnYqKHsGHBD/X5Iefa1l4f2jgsftjixTg7MF2vNmwhwl?=
 =?us-ascii?Q?VB+15VCoou9h04AGMtD+ziwtoPEEyf0EF73rdC9vWfGRdNrGySKtPSqP47kr?=
 =?us-ascii?Q?mDbJpEIna+Ymo6YusQ6O++SSYAcD4waHuV8E/DCZSEtqioqXRguNduWIrS6p?=
 =?us-ascii?Q?nLW3MDZvywX1PnIJvbZhTgM7MMJAYmtuNYTW4HW46ykbW3G2M/nv5tHHL2xF?=
 =?us-ascii?Q?VpBFqowYrW/0Mzb154QqFViMWdQeE3Al4wR1F+uVMWhPlLxSmToftZ8xyNdj?=
 =?us-ascii?Q?+VBCqYGUc3QY6ZC1ioGTnHlmZMpqcbF/64XBVrDA7tVg5Kd52PfKrxTDUiJk?=
 =?us-ascii?Q?GE0p4ow7LFoW6bzjOfLPrVHjSlgwAOV3mS7d5Gkakphe/yXO40fev/JESXys?=
 =?us-ascii?Q?qhnIhSA3ke8dwFgxQ/UXQOTLToDvHa2WDDg11IziJxrjPZtQ2BDm5Yt95Qe0?=
 =?us-ascii?Q?O9hHhoNGGOwzBPGdSscXDuzOlBeERptzPtPus09iKbr/6MCKvarNsKnJOn0V?=
 =?us-ascii?Q?hrNcHfB2/CafNTfdxkUdgE2Im/42iWvXyUA0imrs+Ai2Hk6ZJJU7C3O9gT4y?=
 =?us-ascii?Q?BauAhYqnVXhIav/1MdD//4pXySp42piUiUwNj5YhXu8qURx8Z5G2Y/HWBThC?=
 =?us-ascii?Q?YtG4i44QXN/CBOE3M1so6vfIE10ma8G/aDwarHA+x+Hyw2WuEdbjMkZO4PJR?=
 =?us-ascii?Q?/ZFWdnqqGvhzyqHIud26Wq9Uc47GNm8juJOAuUzvTGitSqdSfGK6Ov9C1olk?=
 =?us-ascii?Q?F5iL3M4dwinxvPZrZyVwRorXidhF6erRom/BXYciaOWldxF7veseUvL7Dz60?=
 =?us-ascii?Q?hivxRO1Kb8cYXJJN5UfmTvX9lVIRX/pGvCKUzsnA789PFGyHIU28gm/u6/fd?=
 =?us-ascii?Q?uVg/mtMePzdFNPDbga78/B4N1IAjHQHv4lgyWN+QBddr3e37RzGWElD1/KYr?=
 =?us-ascii?Q?27nSlKtpmkWbRp4lnMi1et0bMROgdNGVB1d62lhQ81ipC3ct0ZOp/dGa9bS3?=
 =?us-ascii?Q?63NJ6iwD4T6rB0Y2X98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5655b05-2d52-4651-6c15-08dcdedd5493
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 10:15:36.7694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbS3APYwPtOkaN4inUbmH0B7jAoev/jbAgoYnpV0TNyQlT6Bn3iyzzD39035cODf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Sent: Wednesday, September 25, 2024 3:54 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Limonciello, Mario <Mario.Lim=
onciello@amd.com>
Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH v1 0/9] drm/amd/pm runtime pm changes

This series rework how runtime power management is handled in drm/amd/pm.

The main ideas are:
* simplify code and reduce copy-pate of runtimepm calls
* avoid waking up suspended GPU when reading debugfs files.

It is similar to Mario's earlier series:
   https://lists.freedesktop.org/archives/amd-gfx/2024-August/113213.html
It's not a direct successor of it, hence v1.
Instead, this is part of a larger series that applies the same ideas to the=
 whole amdgpu module.


Pierre-Eric Pelloux-Prayer (9):
  drm/amd/pm: remove dump_pptable functions
  drm/amd/pm: fix rpm refcount handling on error
  drm/amd/pm: use pm_runtime_resume_and_get
  drm/amd/pm: don't update runpm last_usage on debugfs getter
  drm/amd/pm: use pm_runtime_get_if_active for debugfs getters
  drm/amd/pm: stop extra checks for runtime pm state
  drm/amd/pm: add sysfs attribute access wrappers
  drm/amd/pm: move private definitions to the .c file
  drm/amd/pm: use pm_runtime_get_if_active in amdgpu_debugfs_sensor_read

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |    9 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  734 +++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   96 --
 .../powerplay/hwmgr/vega20_processpptables.c  |  574 --------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    5 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  433 ------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 1269 -----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   14 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   14 -
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |   14 -
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |    1 -
 11 files changed, 208 insertions(+), 2955 deletions(-)

--
2.40.1

