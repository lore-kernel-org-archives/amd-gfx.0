Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A8FC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 17:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BB410E66D;
	Wed, 21 Aug 2024 17:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SFx1ffXB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7234310E66D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 17:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLIKsMyuMjdT/p8cYS+e9RNuGDuIGe7gp7LUHr+Id98ASkuEAYJLw/WOMeZADInK4jS9pB80fspuskedh529VCDEEMRA8mi+63BT5eIQfMPfASLsTkZ9HpSC/VS5980u4iifVzcC3v4505C24dNOc8uPqoeAMqcwi+86FUBEqgI+Xjn17SqG5y9j/dPIyB0fWQMN9uxtWip41PhdMGSJI+NDLNsJKj+Q0OaU27agK+pckHpUWeGsGp1pvb5atcMFTn3+fuLOLaDwYmcMlmztT8hVN5mu4i2YISiFegKSldLDiBxbq1pW1n4e/s6KRmlTak986TmXLbPCj0qRQ3F/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCxexZoh7deuLko6Ao5yzA9Jo6FxO6VTPJt8bOybkO0=;
 b=ujmydiqp7enJCwgRRDdgJcX0j1nxJeV5ieJkr75y9PtY2r4Ch2waAnLZzLiFUH6rvmi8kc6tPeYqag8oEb+EFOJroJIxvoolhkyXIHC4C/fRBssnpdVkstrZRtCtrMrVunzKBg7FMFMCSrey2CiwHd6dT5qp65FTeQaiGI3Mb/FTvnKifgK65zZ0Dfr+7YBP9PjSWDeRuxjKHTDd/JEcbeFLY+snVoIFAwinAo+mfh42kZThsu6UfdAzQNip7Wt/BIUDSE4RE8tmeV7em5UthD9JtrJLN7EFCEtI9qWxCm8RnTx6lRdO5KGQ3qI3JmyY/eK4S5iTvdZjddYyOrZaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCxexZoh7deuLko6Ao5yzA9Jo6FxO6VTPJt8bOybkO0=;
 b=SFx1ffXB0fEsCXJrY3O1I+mxRasRPn3vMw7BbgH9GSTEcHD4TTYJYpRRswRbYBqfLaB+MNQObYISI7W+gHqD0LjvY39ue8KHn+hCN/BKbXvPk8QLoU3k/Xg47gMXiqruAflFa4OMfVzkCWogUicwWXOWXpXNP9xTN2iImcZh3L4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Wed, 21 Aug 2024 17:01:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:01:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Trigger" <Trigger.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when job tmo
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when job tmo
Thread-Index: AQHa86Ww+oe0WomqkkWjxRDrVbeL4rIx8Dh/
Date: Wed, 21 Aug 2024 17:01:49 +0000
Message-ID: <BL1PR12MB51443647E7CBE13F603C2DA0F78E2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240821083841.477392-1-Trigger.Huang@amd.com>
 <20240821083841.477392-3-Trigger.Huang@amd.com>
In-Reply-To: <20240821083841.477392-3-Trigger.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-21T17:01:48.876Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM3PR12MB9392:EE_
x-ms-office365-filtering-correlation-id: a83f3080-0c82-46d9-0835-08dcc202f274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9U9jEsqwUvzs3XI5O1CG6mWuv1mVXPvZ+mgo86i09mX7mr7Ei41kXGHoBKwt?=
 =?us-ascii?Q?/m/5n6Ckt7qeSD+vwLtdih5RDWTHKspx5/vOzdaXXLH0Ac4otKJy1B7K8lBh?=
 =?us-ascii?Q?BLP0Z8LCvRhzffJTHBhkHyLKV0pyRlIATPQnk7pIBgGjKMhl0sylKSyMsSct?=
 =?us-ascii?Q?Ox+mo8C2XslDvyhutR/VDp6cXtUoi+Y/reL2iDf/kP9/FwN0j/QyM7QwtNhv?=
 =?us-ascii?Q?+2k3wN2khKaB7czez+sb3ybcKtraxILJbz9GgDAxEOv8iP8zbeUiiq/HunAj?=
 =?us-ascii?Q?eo4oNil0segrPSTrJuDTh3jVw10b+uGMff9zzAbifh3uq/cFUADWbp8aVJuU?=
 =?us-ascii?Q?A4K5FlxcnvA7M7NCpyjAyCUXOSvIFzzaObfMUC6o1W+JX6ehafrqnjBvXQxN?=
 =?us-ascii?Q?uPuClSFGlQS4FbuzUCOo6jS7HX4Ll3oDlKa7jPxm6SxI8dmq5xlM4fLCxCng?=
 =?us-ascii?Q?TpXJtD42Wthevy2tQIS4qH9MMiCXmdczvWQ0EIGrO3ptHn7FMSMiOsit5qEz?=
 =?us-ascii?Q?NFQT/A0sdivqvIjcCtuICEhr5PUN1OsB8jMPhaB+eEumFZuM7yfGrn8wXHKz?=
 =?us-ascii?Q?+wNHkorbeLIvTa0jkWr/0j+C+pbpHlqLo6x3qhhEwYDg1+yu+r2uyeRFizTP?=
 =?us-ascii?Q?zUBJea0BbwQxl98H/nVyzgYRrArQGoHs0OK6DyC7zLWmoIjh6kuO1TYEW1T0?=
 =?us-ascii?Q?IzjUepfSszHG1aAd7i8c6ZPuk+hhYY1SHjwuNKjJuEIPWnSfJ5SvY72xp+tX?=
 =?us-ascii?Q?XuYUV4G4UFkxH8fdZtDT3xbDUJU/KyoqHBkuCsrHurb7a2+xu94W8nBNvusW?=
 =?us-ascii?Q?mMIwxjoNO9WhlzVzLXYWt6lO0ggYUhb14Gt1wpFK/jEQCrmH4PPCyCZ1A4yi?=
 =?us-ascii?Q?fKoXWZkKQqVf8qzmt6+ohwtmbr/uZ0M0pcmisgSEJCr3UHi7xuz5CX1FDydp?=
 =?us-ascii?Q?mbnqMadLoHeAGBZJWANSR+JB7fn1DF8di9a2v7wkTkpvRTCIJ3aoODWUkrz7?=
 =?us-ascii?Q?mEesdeYhYu7Aa2v2Xf516FD+UHeAW5o15WXqHmi/9Ap1zAMMU85KXE6aNeuh?=
 =?us-ascii?Q?34IxN0xu5pyw7ax2lm1aJvWLevQ49URo7eSt9V90XpAHo/kA/RE8cFmARTQx?=
 =?us-ascii?Q?B2S0Nu24tanIGJjbLDTqf7ig/vpLD7EH1qtt49LGp50iQG4IFES6/lKcQikx?=
 =?us-ascii?Q?+tlCpARL/QG+76ARnOPaaNJiFV/bxuOJEYrQZi3Jjxx5/FlsGCjYoAwpL6j3?=
 =?us-ascii?Q?VvppUWKDbZ//g3c+HrnsRwMNL/WnIF/yOtfBaoX3okD4b6dH432CDrPIPZ6o?=
 =?us-ascii?Q?72NLvx50Z3vXmUEGbPtcOigpfe3tXqt0fVdrAXvmHzRZYSADhmg6Dyv9iOZ6?=
 =?us-ascii?Q?z+WLlAb8NCtvT9hNulbtUeSgZUGMg8W2gGoslIhSn6OupMmHeg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vp8hGI0/GMRcjNxfoGWXgvhKUkk+KaMoaeLiKhFd4x8w5LeNWKcJFgbdU5uC?=
 =?us-ascii?Q?UGu1fr3A0mTZ9PE7h53Xyqkgsd55xniCg0btXJ0C5a8tykV9bPwTete8v6Tl?=
 =?us-ascii?Q?qoqWJCRqX7EFDyEd/t/rJ03C9IakPX8daHB8sZSrUPI8761SH8BblfsAEoRL?=
 =?us-ascii?Q?NJz5SVEYnA8Q2HPbiMv/6E24LDxwhi04b5LOfHmJsPLRHkcBqfh0YMNVub/Y?=
 =?us-ascii?Q?sYcbS5vqQ1fc4NFcZL6jprSiHEP+Vr+6T/8+Kq6yeFfMgeAlpuZxNIn6I3Av?=
 =?us-ascii?Q?U1cp50iHN72g4wsWq1w7B2HFHuNLpp4YigJdk8S6M9sS+4DfcgvOOOHrsNX1?=
 =?us-ascii?Q?/3qBrLQ2jFnwbIgV5K5Jk7CEkMMKzEG8yAeYwF4BU8I3PIhzAl8hmCgtzh93?=
 =?us-ascii?Q?wLTPSiAcJZdfanQu1inXER9G+lX6I1ItRdPwy0iEWLdfK/JDDQd7zGKxp/CN?=
 =?us-ascii?Q?85MJUeHjvT50XluZQtEVPgeEOJnQebYTv2lA3YE4WFawsbDanOOGc+SQlHrF?=
 =?us-ascii?Q?xd1vzwlxoDMO40a1+ZqhIMv6Y3PVbtLhkcjwMKEGnBhCF0dbwwvl/pgJuFzq?=
 =?us-ascii?Q?Sf8nPf4y7Jsr72pggl0K5DtoHXkQivnQfATIBsb5LG4H2+Yy5ZKnK17H2Mw+?=
 =?us-ascii?Q?gfhXf5LmBomHoJ9ewgvtE2i9Thti2W1AejoeRAIIzdxoUJ7FGNzHOQo7puHQ?=
 =?us-ascii?Q?Ok5yUFw8wSQNqytyZxQumuO3rtjdMMqBZt1zMIWemZc2+iN2f7ebMP4xEfWo?=
 =?us-ascii?Q?Br27j3MyAf5o6p4C6ATdg4LEETjFkWyu2+2k8i9xWMYEwgcnWy0aFZGREdQm?=
 =?us-ascii?Q?rSfotJKL1CPfud4goyfzAjpTMT0cOxxq3QAKkFBYiRyVLHIRCTLgpVwCfS7P?=
 =?us-ascii?Q?dGKEw/4rMgtK9yZuubBvwx7DB+pCA+JkiEfnMU7GDVp0tG+GH4CfmOz2EpO9?=
 =?us-ascii?Q?djh2DNrl0dMgNOiGj2U5SV/cn/zciFfwRc37OemBGGGtCSFYvUvaCK88/vv6?=
 =?us-ascii?Q?IQxxU8/fs84up7tzkhVgJ2GgdRWw8ivTaJoxrztLJ0zrRgxTxCv5+YJ1Hc17?=
 =?us-ascii?Q?FRESO3SQkGFeGPiVeggVoKo0EGw4q/WdfQPkUG6R3bT1sJdbkKzETw9FQ5GC?=
 =?us-ascii?Q?F6olPzElHIqc4ZW0O4+p02OC8OlGjUhpojUpw1co2w1jJJA7nE3xwfI+PPsW?=
 =?us-ascii?Q?Hxj9oUBEgZWKJR6HIgtfSnK3F6ji1TJzWxKJkniIPiLTVk3e5XVFIMaMqJcI?=
 =?us-ascii?Q?qFCqNko6p3RShnBD70o7OAZDv4n3Pr735/NUf8LcqTJgaoUutYNroXE2mtgt?=
 =?us-ascii?Q?ZM285TGqohIdJL6fU11wOc7qXEycQyv5zVzdAQpxJP7LojfKJgFcbEF7xmOi?=
 =?us-ascii?Q?I+PGnwtNJWu9mKjfto+gAZtuOEqVrZdX2ltUtp/x1jEKb83I8PrXBapIdROD?=
 =?us-ascii?Q?VQgoHvB+osrmVA+8HOv+hgYgsHveBmYLVTmMe89eunJaKw0eenUvLpb67n/x?=
 =?us-ascii?Q?I0eiNxYsCJ2hjqXVHl2yg8abNrtSWqjDsvPrF3Qm8+iyWD4YnGQrMDdfz57b?=
 =?us-ascii?Q?B8xRcElX5cBySWKPNtY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443647E7CBE13F603C2DA0F78E2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83f3080-0c82-46d9-0835-08dcc202f274
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 17:01:49.2659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teN9K8HqbW90C0PYNTkTPRXTYOCCZ/J9iW7TK6c3NCqlm+neHi2VCUUifqM6wEAb6HadyWGKCpMTUFRTdNqKrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

--_000_BL1PR12MB51443647E7CBE13F603C2DA0F78E2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Trigger <Trigger.Huang@amd.com>
Sent: Wednesday, August 21, 2024 4:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Khatri, Sunil <Sunil.Khatri@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Huang, Trigger <Trigger.Huang@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when job tmo

From: Trigger Huang <Trigger.Huang@amd.com>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status.

V2: This will skip printing vram_lost as the GPU reset is not
happened yet (Alex)

V3: Unconditionally call the core dump as we care about all the reset
functions(soft-recovery and queue reset and full adapter reset, Alex)

V4: Do the dump after adev->job_hang =3D true (Sunil)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 68 ++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index c6a1783fc9ef..3000a49b3e5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,61 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_dev_coredump.h"
+#include "amdgpu_xgmi.h"
+
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+                                   struct amdgpu_job *job)
+{
+       int i;
+
+       dev_info(adev->dev, "Dumping IP State\n");
+       for (i =3D 0; i < adev->num_ip_blocks; i++) {
+               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+                       adev->ip_blocks[i].version->funcs
+                               ->dump_ip_state((void *)adev);
+               dev_info(adev->dev, "Dumping IP State Completed\n");
+       }
+
+       amdgpu_coredump(adev, true, false, job);
+}
+
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,
+                                struct amdgpu_job *job)
+{
+       struct list_head device_list, *device_list_handle =3D  NULL;
+       struct amdgpu_device *tmp_adev =3D NULL;
+       struct amdgpu_hive_info *hive =3D NULL;
+
+       if (!amdgpu_sriov_vf(adev))
+               hive =3D amdgpu_get_xgmi_hive(adev);
+       if (hive)
+               mutex_lock(&hive->hive_lock);
+       /*
+        * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+        * devices for code dump
+        */
+       INIT_LIST_HEAD(&device_list);
+       if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > =
1) && hive) {
+               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
+                       list_add_tail(&tmp_adev->reset_list, &device_list);
+               if (!list_is_first(&adev->reset_list, &device_list))
+                       list_rotate_to_front(&adev->reset_list, &device_lis=
t);
+               device_list_handle =3D &device_list;
+       } else {
+               list_add_tail(&adev->reset_list, &device_list);
+               device_list_handle =3D &device_list;
+       }
+
+       /* Do the coredump for each device */
+       list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+               amdgpu_job_do_core_dump(tmp_adev, job);
+
+       if (hive) {
+               mutex_unlock(&hive->hive_lock);
+               amdgpu_put_xgmi_hive(hive);
+       }
+}

 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s=
_job)
 {
@@ -48,9 +103,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)
                 return DRM_GPU_SCHED_STAT_ENODEV;
         }

-
         adev->job_hang =3D true;

+       /*
+        * Do the coredump immediately after a job timeout to get a very
+        * close dump/snapshot/representation of GPU's current error status
+        */
+       amdgpu_job_core_dump(adev, job);
+
         if (amdgpu_gpu_recovery &&
             amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->par=
ent)) {
                 dev_err(adev->dev, "ring %s timeout, but soft recovered\n"=
,
@@ -101,6 +161,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(str=
uct drm_sched_job *s_job)
                 reset_context.src =3D AMDGPU_RESET_SRC_JOB;
                 clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);

+               /*
+                * To avoid an unnecessary extra coredump, as we have alrea=
dy
+                * got the very close representation of GPU's error status
+                */
+               set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
                 r =3D amdgpu_device_gpu_recover(ring->adev, job, &reset_co=
ntext);
                 if (r)
                         dev_err(adev->dev, "GPU Recovery Failed: %d\n", r)=
;
--
2.34.1


--_000_BL1PR12MB51443647E7CBE13F603C2DA0F78E2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Trigger &lt;Tr=
igger.Huang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 21, 2024 4:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Huang, Trigger &lt;Trigger.Huang@amd.com&=
gt;<br>
<b>Subject:</b> [PATCH v4 2/2] drm/amdgpu: Do core dump immediately when jo=
b tmo</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Trigger Huang &lt;Trigger.Huang@amd.com&gt;<=
br>
<br>
Do the coredump immediately after a job timeout to get a closer<br>
representation of GPU's error status.<br>
<br>
V2: This will skip printing vram_lost as the GPU reset is not<br>
happened yet (Alex)<br>
<br>
V3: Unconditionally call the core dump as we care about all the reset<br>
functions(soft-recovery and queue reset and full adapter reset, Alex)<br>
<br>
V4: Do the dump after adev-&gt;job_hang =3D true (Sunil)<br>
<br>
Signed-off-by: Trigger Huang &lt;Trigger.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 68 ++++++++++++++++++++++++=
-<br>
&nbsp;1 file changed, 67 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index c6a1783fc9ef..3000a49b3e5c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -30,6 +30,61 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_trace.h&quot;<br>
&nbsp;#include &quot;amdgpu_reset.h&quot;<br>
+#include &quot;amdgpu_dev_coredump.h&quot;<br>
+#include &quot;amdgpu_xgmi.h&quot;<br>
+<br>
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *=
job)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Dumping =
IP State\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_=
blocks; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_bloc=
ks[i].version-&gt;funcs<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dump_ip_state((void *)adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;Dumping IP State Completed\n&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_coredump(adev, true, false, jo=
b);<br>
+}<br>
+<br>
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_list, *device=
_list_handle =3D&nbsp; NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NU=
LL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D NUL=
L;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hive =3D amdgpu_get_xgmi_hive(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;hive-&gt;hive_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reuse the logic in amdgpu_dev=
ice_gpu_recover() to build list of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * devices for code dump<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp;=
 (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) &amp;&amp; hive) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&a=
mp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!list_is_first(&amp;adev-&gt;reset_list, &amp;device_list))<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_rotate_to_f=
ront(&amp;adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_list_handle =3D &amp;device_list;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_list_handle =3D &amp;device_list;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do the coredump for each device */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, device_=
list_handle, reset_list)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_job_do_core_dump(tmp_adev, job);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_put_xgmi_hive(hive);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
&nbsp;<br>
&nbsp;static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_j=
ob *s_job)<br>
&nbsp;{<br>
@@ -48,9 +103,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return DRM_GPU_SCHED_STAT_ENODEV;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;job_hang =3D true=
;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Do the coredump immediately a=
fter a job timeout to get a very<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * close dump/snapshot/represent=
ation of GPU's current error status<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_core_dump(adev, job);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery &a=
mp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_ring_soft_recovery(ring, job-&gt;vmid, s_job-&gt;s_fence-&gt;parent)) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ring %s timeout, but soft=
 recovered\n&quot;,<br>
@@ -101,6 +161,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(str=
uct drm_sched_job *s_job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_context.src =3D AMDGPU_RESET_SRC_JOB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.=
flags);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * To avoid an unnecessary extra coredump, as we have alrea=
dy<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * got the very close representation of GPU's error status<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_gpu_recover(ring-&gt;adev, job, &=
amp;reset_context);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev, &quot;GPU Recovery Failed: %d\n&quot;, r);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51443647E7CBE13F603C2DA0F78E2BL1PR12MB5144namp_--
