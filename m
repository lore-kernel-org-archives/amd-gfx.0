Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF09ACCD187
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Oct 2025 08:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038B210E010;
	Sun, 12 Oct 2025 08:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q73s3URs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8BF10E010
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 08:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwJlb2EwTCjhfjYmOZrhHGe2ca+CGKcPVRiStNJermy5u2x140Mx1ke6Hh/Q8CPQhjEO/LStR05x2r9XepsWnNUHnxYu0ZrExTgFmycNbSkzDiHqH6dhI0b7/YWon+3pEQo4sz/jpwUladn/1WxVzs470FB1/7AsQCgGx4onyLaYS/uq2LJ1JZb5DRDW+PQs/SBoT8oenPfb2bahtRStHxc3n/WzJsjObkvxyhmeJeb5d/w+ctoos2iP3LyWRGWQrIrIwYCH1zLqdVIxtUic//aoY7TKs+SnsS6JKK4i2wWVISeEpVMDL4+uKfdCdKqidPsIlRWczVYlm3goyFkE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YboOwisWKBY7vkkxMDGKdKN4q6xaDjoqb3tgqDyR4p8=;
 b=kpiFM6qhIcV4syaKnzafWii2xYyRme2PkN8Qtvppf6yOavPSmBqGkTcnCNGqsX6x4Ppgv34YvZB5sx9Vbya1SjRm0WHgX3DjSaKIZGDfO57SrY4uU0f6ypnGRwRwc1KD0dnRXCqHrNehSO/WKnBDDVQWRE6drkK4RHMiP2E+VKpV594Jwafl9LoA72Bru9dTaBBe2fvE58+6sw3TSwCdeJiiP+heNoPBIl5mZUd70MdllJXmNJOBbHge+GH5OtAeDFIxojiYsIVVTbx3fKhqgA2uBFzlzFE44gM9qnjAYh6rZ0jOuHaKMNxPu4tjFdP4wsNmnXuVqUPgOjr4mqw7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YboOwisWKBY7vkkxMDGKdKN4q6xaDjoqb3tgqDyR4p8=;
 b=q73s3URs13v1o/DgVgWuNfOm+DtW2+coqPEF1ymAjZP2T7+yzHWv6fC1OQczhOP3FXB1xz/pO/yJgyxcNC3h63tf8WSYY2lwz1qqpa4sEzjMmmUflasLtNhR0eQyNo1ScX3owO3e1rj4WL0wWoC4Tm4/saxCzdv69cAxjYreJM4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 08:34:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 08:34:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 9/9] drm/amdgpu: Add ras module eeprom safety watermark
 check
Thread-Topic: [PATCH 9/9] drm/amdgpu: Add ras module eeprom safety watermark
 check
Thread-Index: AQHcOoO4Qp7q3tGx1Ea4x/2z1C0y8rS+MOeQ
Date: Sun, 12 Oct 2025 08:34:23 +0000
Message-ID: <BN9PR12MB52576EA2827EE142CDBC740CFCEDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
 <20251011074811.533871-9-YiPeng.Chai@amd.com>
In-Reply-To: <20251011074811.533871-9-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-12T08:34:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8735:EE_
x-ms-office365-filtering-correlation-id: 530e4d06-ed5b-473d-72c3-08de096a2596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QVZm/51IGI2o7R7Fwu7MsKO98wAVJT3jrzgAtnzXefISx6rNy4INANwfXTpX?=
 =?us-ascii?Q?tWLOxQnt45JsEaVXX4Z0q0ZuIA46wjjGVJwrwl0OLcA6mdwm0PPj1fCe/rZk?=
 =?us-ascii?Q?Wb+CNiM7kH9q5z96SoDOkBjJN+j3UYh2GtKsChaRThMvELP8TYekj9yrTZJq?=
 =?us-ascii?Q?I32YeY5ut4Ma+9D1pkX3Y42PtDKrEJ+wdvLewckRQxEXD0hfEK+xPf+DYiNe?=
 =?us-ascii?Q?jpA+DINEZ9V5XrnekuAP42KE3f30r14xckrgoF7XvtSrBIvsCoeRVkLD7zIi?=
 =?us-ascii?Q?2B+aOk/uf4PsaClVAwrAb/82r1If24SHsXRhqY0zq0CMYB9Bf0lhy+AgOWbb?=
 =?us-ascii?Q?LgAtFUQ7V2Xqtey8CAxSZPrf4/qJrlxfzasCgZz9e2u2x2jaGU4A+l9b0zeL?=
 =?us-ascii?Q?OXb+WVYYLZZFA6mLCxhMjH9BKD0Vm6crOYOsPXllIi4hIbn/PI0dEcIr8qlk?=
 =?us-ascii?Q?0mLgxXNH8CsIax4j6QW4BIA2QrvhiPtq06h4lweBmZq6ZChHP63dzFRY513s?=
 =?us-ascii?Q?8/8t1arg/fGT17QU1sYjpCq8LpwK911ZVhS2q6c+Nb7wYI74CnK4iJDV9aja?=
 =?us-ascii?Q?U3apa9EGZ6AQWv3ZkYV9y2yWEmHBWfymCwH/lfNb7b5WzRTzj7QDZK6QXXlW?=
 =?us-ascii?Q?4z5xg3Mceugs0Kj4TR3e7HFLDIVlWOXxzXEE1S5XTFEqcI1RsVpGdKbGnCtW?=
 =?us-ascii?Q?6HSgkU2NM0gVqZy7vLYEOj5livQDDojD+XYE1nwGJCwxDA36ylyik72Y7x1Q?=
 =?us-ascii?Q?PuPBekME2dSLHWf8cNVlf3QEiZMr+dVMQvNSAAUWv+bMl2wGkG1mNeKdzD/c?=
 =?us-ascii?Q?KK6VAGq40a0AztQbwIL0egDRQRUhxvlGYOY6d50gMKSVLk1X732pVZ6UZuNB?=
 =?us-ascii?Q?IPEcAyZt3vvVOB73mnx9lP/4ZySRaDr7QVd6404McmSBTIaGb6H3tqmqRWnb?=
 =?us-ascii?Q?OCzHq+FlMZgmCvYT0fUIBZ1corRuAJmQ7NGUR2osshTE7V+J8fVZlZvdYbJr?=
 =?us-ascii?Q?ed+EXiMkqy9fkT+hB7AYNzOUMLRnPfT8JRtJKgHklgmjzk4YJ9SYZZJrIppL?=
 =?us-ascii?Q?gWHop1ot4UuWMk1knU8dfsFlZ2c4K+6JMPMUN5fMtNDhzEQS0RRhYxn9GnCv?=
 =?us-ascii?Q?f4HCr5riz7kNzA3FmZaJKcxhNKizIwY7I6S/DX38iBpTGysOa2svq0v74jaj?=
 =?us-ascii?Q?dX+xRRKyN2meV7LcwXiZCNPcAHNhaYiVH5+1RwSH6L/p744gmEG0QfG+S6pe?=
 =?us-ascii?Q?LiezWIhPUIryGjq9EUMM2Hfla9EsynbQQvlKOeeCmMoHio6GP5d+J8yp8+E1?=
 =?us-ascii?Q?5I96iFsAedhb5GIDiYpLvhJWec43yJszwDboX3CsWWj+qYpQ20vckHyRwYed?=
 =?us-ascii?Q?tr16zpze+Z4iAzY8VVg5Z1t0Wv0vwCQqtU8BPsWjMZD6Hspwa/ykl3XXdgvv?=
 =?us-ascii?Q?rWGxscxii3NIo4tibUFEoWUU1K9nMZ7VJ0O1ui91xRNgHONqU6W/OKG/Y6QT?=
 =?us-ascii?Q?yUO9tifaVJEfxmBhYiwNzsyERXdyo2rF2IYV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tKo3Y/VA9D/EhZ4K6Pn3jsC4s4/fXW5kmdjWF4BDkZ/7oeOKvYUlVOLnI1ZS?=
 =?us-ascii?Q?TDjzot2cS68QINKpLXcnhrmROgshTRzxhQg9BFy5XG8IUIIdzFMT9/yg/P/U?=
 =?us-ascii?Q?aXjURjJPpqqpHXs95nfwfgNU/kevLAddg0zgoUFD3GHTvmTIpxcHxJpZuj0s?=
 =?us-ascii?Q?u3GVGG0Cg3Z0J+gA+vOpdAH3eyvzRPHugPiO0FkPUqPgCdu/PUwoa/tz5VIl?=
 =?us-ascii?Q?uwwIysebz9sdvbGCgzmAHhbf781yryGrJWKmRZNFE28vK2zMVQ1DDWL64gNz?=
 =?us-ascii?Q?65TYm1LbOK9vjicmbtGeB9mvobK5rK6APuCwU4LnjTytQxa0sXzkWnCHs8JN?=
 =?us-ascii?Q?rLwUtBaNEGCOMvKv8EGYl3UYGKbuQNdwYwfhW0UmoaDNAR376vbZex7TEaKE?=
 =?us-ascii?Q?Xr7bEDG3XDa8W5YLx0Xs0MuhKQ5ksd4Kb/YNjYv/Fn9vAO8lCU7SBbD7kOUw?=
 =?us-ascii?Q?XMDxDx/rwKAjOuOT3FxrDQhEXY57Uf7w9h2iemMTUZhptB0TbYfcf90itYbe?=
 =?us-ascii?Q?I6F/Xpt8FDbHK5it9pF5Xp46CDM2CFHIVJaQT4bSjJ3AHvnn8l7ilXmNeFCe?=
 =?us-ascii?Q?ozPLXq1wKZJwvgBAJNNY1oY+/wU2XrbooTy4vMx+ZfHu3Ezx8Lmiyd6t4L78?=
 =?us-ascii?Q?qDXHtLrvPtVlXGWHzc9ybjWy15hh87tDizQZ3Mk8tUAOyRskb2M7CwRZUlfu?=
 =?us-ascii?Q?P4XV6V/7zyv84x9o0v2VEa8rT+1zWo5bd6EKIXMxrHg4HwH3M1AkTXY0i+i4?=
 =?us-ascii?Q?0O1Dv53cDTaUqrsKfYlJN3i5/dTIFbIsZzEhnD/nbFBOFY/V0V2ylGgnfnsy?=
 =?us-ascii?Q?aIXMD1E/ePMJimt5gBQmd3Dq/+Y5SwSwQddDe21bvbMuuqhSng9Sbt0wkE3M?=
 =?us-ascii?Q?BOaKyleUSM/NW8VLVDQZAwZX5t4TSTyG5zmm5wyfIIPaCy6MzvpSICWxgMnL?=
 =?us-ascii?Q?I5OpATWUB3pV58Y2nZ8qohu/a0NVAgYSYXWHd5pyxs91giYH5yu6DmLa6905?=
 =?us-ascii?Q?HxUvFDtaugFyiPm7E279CcLI/BPn2FPocYiJzCopwriQsNSbBqL18wVQyNAi?=
 =?us-ascii?Q?460VqvODtZGNJLlzfU5P+QigcnVgaztDipGeyAufkJNA1YZh4OyjXcbpBLMF?=
 =?us-ascii?Q?H6Y23VLp7YiyC409EfQU5npMI8tzqGI8EM4NThrlR/n66hh/bqmNohyFOLmZ?=
 =?us-ascii?Q?zchEhn3LQTew6Srg7TLDjbBoWa+BktYp66mtbJNCMvbAnZIBGtjAnE6q0BiA?=
 =?us-ascii?Q?c89W+0/yvRKi1vZRXwKZvNBjXzmO/gqwEQ43MwdRnSwSXTyJy/sHIULcTEjb?=
 =?us-ascii?Q?LJfwuAOhFIMzza79kRsTVEcEkchO1wVg+WOWT0B6kWKAK8Be412nraQLZv4p?=
 =?us-ascii?Q?wi1D9UvZKTw3iTPUSb5xw5dUbkWbfjDkV9PTvo/svrJymruMClP3QnrDT3TP?=
 =?us-ascii?Q?Tkgx5/tENUS05klIHORrMKmeVGleoCWfq0pZUcm/SWnZSTdMmkuovAxZtgNJ?=
 =?us-ascii?Q?kuCy97cDNYrTFSdxq6Ptf0z/1Oqws4ec7PbDW5CtWjvzMCFD32V3aO6IUi83?=
 =?us-ascii?Q?M0XgeVpHV/3igzOzlds=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e4d06-ed5b-473d-72c3-08de096a2596
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2025 08:34:23.4730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vhtYrb5nmYl0adkmGgIHncOvRiccaBe0hgTfunCjC/4wMMoIbibHAZxXVwLF4Ndl6mAylrz9uogJsEj4zREUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Saturday, October 11, 2025 15:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Add ras module eeprom safety watermark che=
ck

Add ras module eeprom safety watermark check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3eb3fb55ccb0..5a7bf0661dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>

 #include "amdgpu_reset.h"
+#include "amdgpu_ras_mgr.h"

 /* These are memory addresses as would be seen by one or more EEPROM
  * chips strung on the I2C bus, usually by manipulating pins 1-3 of a @@ -=
556,6 +557,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_de=
vice *adev)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);

+       if (amdgpu_uniras_enabled(adev))
+               return amdgpu_ras_mgr_check_eeprom_safety_watermark(adev);
+
        if (!__is_ras_eeprom_supported(adev) ||
            !amdgpu_bad_page_threshold)
                return false;
--
2.34.1

