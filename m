Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9425D41D56
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 05:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C99C10E049;
	Tue, 12 Nov 2024 05:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQEMV4p/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D97210E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 05:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlXWU3ZBMkkugtco90KrqzYDqcdcLTdn4ktuXTv+wObaULBmlpAsXFshlY78WcaeBiBe2YlNb9AdHjRrYlHLOV3zWdvwX0wR5i+N3dCCRy5Xzf41aMYhT6sw4GlOxOa9KwUJYxpSINIvCjs2dheRwzzwo7/VXrOIWyOzZNqP+PgZV+mn1wDt0j6mrrHXbWwGQR7YGnpqEnb64FRBgF9WCj+YAYQ3bE+JFBiGnJeRmBUJ7E1Y4jzL68oMR8UPe2fzFQxYPmt3kQAN6JqikshasMZrwkb/lBW0emyvsa11r0vynw5cuXHbwjXKHo/eQ/n2FBjL+py0JbNF+QDF2WgGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAlf1vuyhqXTlK/YC85O8vWN8AY4st9WRaUNufBweX4=;
 b=cLPWnCTD+6JpYbR+P04Myh1Iv9E2CpnNvuPlfCnCSlXDdAXFwCdfUBYrvIK8qxuK+9lzUpRFaVVrQnumCDmmm/YL0DNWRrUyS7tyFlFQfOt4WDvSt7p/yg3SEgvRbaV0Ry+kQG9JXQASCLb6lmE72HJI4H35VVmR8tqeJXnrMgzisSbZbYwobFTNlu5hAd8sAtpxkRb0FXRoKA9IxEnMJ7W2dNakIuXaCfoMmH4lLCxpdeTQek+NhgxSSsccZMeoK7O2KPu1su05121VS6g+5fXSYydg7OhHS6CLT8mfoq2Xr9TZ1xUEdfCuduZgrLA9t+iV1qIwbAWrQawdE95XsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAlf1vuyhqXTlK/YC85O8vWN8AY4st9WRaUNufBweX4=;
 b=AQEMV4p/DqOXVnjKuOF24gM/PFFQKqZv3+HPXdr3TEmtxpxzuLFwNLK9O5RVDzK160fRcvMKwpLQHTkgEXzcOFSrtAWHPO/yRDvFHqGmv/OW7CLBqn9Sn9CUWnsmYi699uuIIRNZZjbzwMA5KpQFWMdCfq09LwxCWeOx14ZGwPA=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 05:44:24 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 05:44:23 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix and simplify workload handling
Thread-Topic: [PATCH] drm/amd/pm: fix and simplify workload handling
Thread-Index: AQHbMmjFsKs67HGWDkWoClywhRvWLrKzIgfA
Date: Tue, 12 Nov 2024 05:44:23 +0000
Message-ID: <DM4PR12MB516517D96A1EE5E39D96DB4E8E592@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241109053148.13617-1-alexander.deucher@amd.com>
In-Reply-To: <20241109053148.13617-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=170b2dcf-bbf4-4841-a7e4-248d5a81cb38;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-12T05:26:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB6009:EE_
x-ms-office365-filtering-correlation-id: 97de7a96-ed9a-40e6-f9cd-08dd02dd0ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mYLKq/QqUStX1XMI8tk1O7mUtVYExXNmKOMK08pFBdYPTP4uW5QepeZtPDDW?=
 =?us-ascii?Q?7nyzHR9IxOSAT+7O4MbGJey1Zbo2G4ix186QUNjsqslDOKBl8nxllUXzTStn?=
 =?us-ascii?Q?Mu1Yy573W8lW+z/BYQHHT982OJwU1csjgSSUfgOFmY3vMqInixcpWc59grXf?=
 =?us-ascii?Q?N1DIimj8hy36ZoJrImMezzmJB7Nx9/BBeilUTxgTiE6tKnykL+nj0U3I9k+V?=
 =?us-ascii?Q?QC3/Re6n/22IQyPNR/rRDSnbXb9RTLs6Q4Fh1ZagOSXnb/xWglcuGHp1gZXe?=
 =?us-ascii?Q?D13VuXNhJhkMKU7AY5w7+Ebhc2Y+yygEMyO3l0ly6tswBOwo4Vh/S5G23seL?=
 =?us-ascii?Q?rrfXWH9YbFm3GeSdo03NcnKDVxKy4UNNyzuc0YEaLUMO+zlOkHQ1DRMdwfmO?=
 =?us-ascii?Q?JLK78rGM/RK5YdZyFL255d9n0oXVBWBn8y5CkM3HxnMc587hbCfAiFpJnAr8?=
 =?us-ascii?Q?aA93UvWiulpc3xCyUvU2ihX2ZATdTiEEV8M7o/YOLEdOZYOXRf1REGEMsJc8?=
 =?us-ascii?Q?FiDe9gvHSSe+WA+phGhGRl0toaJRWzFfMMRzaQ6hZcXWd1svQhqScgWjh2tP?=
 =?us-ascii?Q?gZIMqclP1v+aXOJfnhBxuN5rXSaz38m72HxVNN+ZKNldrsXqtyDAGKvaHODI?=
 =?us-ascii?Q?abdLqsyFrI9ajED0zxdTG+UmyX2t7rytNYKLC+jEaU8dkhflciwgzP8aux6R?=
 =?us-ascii?Q?IHcrhv6zduX178+SsfbjqOXZGLmPCpEoxbwv0Tre/enqAGlAW6KZQjzxviAQ?=
 =?us-ascii?Q?/AvnvTuxkwtOn7NEy/GULVQpNCJpcNT8ExuzCIxHBWGn6uuqkVzXlxXAkrNi?=
 =?us-ascii?Q?BG0rEqrcBvLjmR7UDxieaK2uB7Eq8pCNTgszAJllqZ37uB33Sn3fIae2Ps2f?=
 =?us-ascii?Q?aEVRzlGbyybz4OSe962kPgH85UaJ6wS53uHgvnCUf9rAkaEoQEHVJ4/+cA68?=
 =?us-ascii?Q?CYeBbqDwOkEOw+vMHL1phYe+LaZx912NFrRk6DB67LKM/7L7fJXKf+sjkchT?=
 =?us-ascii?Q?eBWgGxpfwZapE7NI58pv26NYmu+qWY0awipBmL5FOH7+LbSiZTRtNgP00Uc/?=
 =?us-ascii?Q?2zPcyJpje8hTeps8b2DtLGX9iHvzg8/QQFC2PHBIRCO2JvpObxx8kqh+yo5u?=
 =?us-ascii?Q?n4CAokDvO9f5QLfUpQwDH3YtUbcI6iAPUhTVlJRGWZqXkmaOGPJiRoh4G5qt?=
 =?us-ascii?Q?Zd02QH9oppyCTk7zB5gq4oF6thHuHUrRzxPnGsQ8D3cUdJ5ZI6sFJ7W5vL/h?=
 =?us-ascii?Q?dKp9aBuona6boL3YWVn4JJughar9/bA/dUVHXXgQXVMFUY0WynmjqGybM8T/?=
 =?us-ascii?Q?nbEHplVehauxLW2CF3eYGHNk0wUTgHOYrXWsgEz1VBlzZSJ4AQbm94F7E5ew?=
 =?us-ascii?Q?IiTuqeE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fId0vaojY66482HL+w5Tt3HjKh21hkX+hxIQPA1+i6v+UuXtp1/KD55/nEF8?=
 =?us-ascii?Q?Yqdp2HbBuueNO9n/HFEJHR5FXrzAn56RV+S7S/kuyDhzKLtEtqhRRaHsEnoi?=
 =?us-ascii?Q?Stqqu8CmCEanXmv7yO9OtY7/Umq8n1CdUZwVt+KdGP1jCzPPIGQ5T8CckXZk?=
 =?us-ascii?Q?zKL2d3V/14GwLoNaMcdAJTziDaWMbDEjta5Cb+n2ioh4SPRvEWVV2QvNo8+H?=
 =?us-ascii?Q?H+5kxhcd4C9atVqcHP8lktWcHeeVPZswGTgTQf+TEyr3lNzNREtnQgLPONbm?=
 =?us-ascii?Q?kQUCCfKfU/04Tg/+KZevedcWeHXZ+yPvg8iSEDvpgzqyFb6823QFwfp6+B8a?=
 =?us-ascii?Q?Z8fHGMhm/wAfe9X+Lw/dcRoWqST5z2i9ZZbFEK2gLe4seIyBfuVay1LF1DEF?=
 =?us-ascii?Q?LKqG6SCI9scoPFeIQ7Jnt+em/WGq0wz5RU93y/BfI+hk8ljd2HyRWP6XVmfi?=
 =?us-ascii?Q?ycwGc5Pl6F7/Mdjkn0c6zbePVB5oOJzrETMVc5qN/oSdei+dmQSJlcFS7Z3d?=
 =?us-ascii?Q?JORwb7Cdt5v59X162cy6XfooVvcEUu5b3ZKWQjUFo6b7wA0elkSsCRdwmCDu?=
 =?us-ascii?Q?EyJBkpuIOrS9LFjBynpg+If4Xn8WyDiTp5rQD9arT6W1WO/iD7Oc9TIQTEHP?=
 =?us-ascii?Q?UB6kqqAUDQC/0Dh5OcoJDGq0Ev8f078GRyZCFKriHkKE+di+qMTfPcAhKKY1?=
 =?us-ascii?Q?Nous835k+W9w6izA1eWcVNk+EJtadMmgslnOJyjPOL4wJUMXSqfc8vdAt6ql?=
 =?us-ascii?Q?7AffHhArpLSVuQEeMHX7hd+k+9ZNb13lI4MH0xGpTR+4dUnXVrpWVLxTTZJB?=
 =?us-ascii?Q?B60VSGGbCrb1y++1Qmog4eeGaM1gso7PQLKYF6YmZzKYAATphSWIgQfRDoC0?=
 =?us-ascii?Q?Of8WeTOLpLqejQDpJYL3ZH7VVBvbg/kpI4d0+aInl2pkn4V07H/UI9cBsE0S?=
 =?us-ascii?Q?CBlo+ljG4oI5NIQxyJBr8UGC1pK7nUL3W/PyqOR4NYs8JnIl0xuMask96hCl?=
 =?us-ascii?Q?3cOvh5A8vy/Ljyxq4n2ooSTOjerptsYaA4Fx+ArcCfomgZBmTDDkwvsSRQRJ?=
 =?us-ascii?Q?gS86CFNk1fQiRwjwrPVPQgfC1cdFRAV+/4dAqShThTti3koVovbTAcf3psPa?=
 =?us-ascii?Q?l6fL6tFfNBr2ZkW8S2tOL2q4xWHHr3l/225/3rOY/zEAfdCi3ONm1g4RU9Se?=
 =?us-ascii?Q?6zglTLQwGkkXr4Y55iwLLJvmPz8duENgArq0XHtLdbLBgK5ADpr2VW0ip5AX?=
 =?us-ascii?Q?P3Oy3cpuXgi1uZ9VfeZJl1w/IF3W8RYuMB8ruJlZEkHQ9tV8ntO4N7I/qi1m?=
 =?us-ascii?Q?N+NVUJ0XZL8CKJGzGXKtiQ5lN2b5ckaGuMP9R64EF8gB9MXYf2uTEsB3BiDs?=
 =?us-ascii?Q?nYVGjyAjONUrhDSmE2kK41eXig8SPtxgaIDRb0mtVzSVUqSL1+oOqbkf/Vor?=
 =?us-ascii?Q?iornFYKBYtB9/oWRus8BwY6GPQpRjRZDftgg5UF4YasllFMDQzkX2MtQGytM?=
 =?us-ascii?Q?+uxqYzSA3mbF4lnrGPJ+Hycs3+a7mwmmeI96wZV7kTNqKAHGKmTdo2UMGeIE?=
 =?us-ascii?Q?zV3w7qSpX/0ouoc6MvU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97de7a96-ed9a-40e6-f9cd-08dd02dd0ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 05:44:23.4635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPNpqtCl2+W8EuTGUpPfrEOq3CUKegCmqceW0z5CaWcxhl8WV9NuZ+jEya5wp68D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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

Hi Alex,
If I understand this patch correctly, the sysfs end user will only see his/=
her settings to the power profile since the smu->power_profile_mode is refl=
ecting the end user's settings.
Then if the other components set the workload mask then smu->power_profile_=
mode can't reflect the real prioritized workload. If the end user doesn't n=
eed to know this information,
then it's ok. In addition, there might be one problem, please see comments =
inline.
Thanks.

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Saturday, November 9, 2024 1:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and simplify the=
 code.  Store the user's preference in smu->power_profile_mode which will b=
e reflected in sysfs.  For internal driver profile switches for KFD or VCN,=
 just update the workload mask so that the user's preference is retained.  =
Remove all of the extra now unused workload related elements in the smu str=
ucture.

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-  .../gpu/drm/amd/pm=
/swsmu/smu11/arcturus_ppt.c |  20 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---  .../drm/amd/pm=
/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--  .../drm/amd/pm/swsmu/smu14/smu_=
v14_0_2_ppt.c  |  24 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
 12 files changed, 132 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..162a3289855c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
        INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
        atomic64_set(&smu->throttle_int_counter, 0);
        smu->watermarks_bitmap =3D 0;
-       smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-       smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
-       smu->user_dpm_profile.user_workload_mask =3D 0;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1); @@ =
-1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_bloc=
k)
        atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
        atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);

-       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
-
        if (smu->is_apu ||
-           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D)) {
-               smu->driver_workload_mask =3D
-                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT];
-       } else {
-               smu->driver_workload_mask =3D
-                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D];
-               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D;
-       }
-
-       smu->workload_mask =3D smu->driver_workload_mask |
-                                                       smu->user_dpm_profi=
le.user_workload_mask;
-       smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-       smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-       smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
-       smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
-       smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
-       smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
-       smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
+           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D))
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
+       else
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN=
3D;
+
        smu->display_config =3D &adev->pm.pm_display_cfg;

        smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO; @@ -2252,24 +=
2228,23 @@ static int smu_enable_umd_pstate(void *handle,  }

 static int smu_bump_power_profile_mode(struct smu_context *smu,
-                                          long *param,
-                                          uint32_t param_size)
+                                      long *param,
+                                      uint32_t param_size,
+                                      bool enable)
 {
        int ret =3D 0;

        if (smu->ppt_funcs->set_power_profile_mode)
-               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param, =
param_size);
+               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param, =
param_size,
+enable);

        return ret;
 }

 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
                                          enum amd_dpm_forced_level level,
-                                         bool skip_display_settings,
-                                         bool init)
+                                         bool skip_display_settings)
 {
        int ret =3D 0;
-       int index =3D 0;
        long workload[1];
        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

@@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct sm=
u_context *smu,
        }

        if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
-               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM) {
-               index =3D fls(smu->workload_mask);
-               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? ind=
ex - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
+           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM) {
+               workload[0] =3D smu->power_profile_mode;

-               if (init || smu->power_profile_mode !=3D workload[0])
-                       smu_bump_power_profile_mode(smu, workload, 0);
+               smu_bump_power_profile_mode(smu, workload, 0, true);
        }
#[Kenneth Feng]
#After some OD settings, the workload will go back to the user's setting du=
e to wokload[0] =3D smu->power_profile_mode.
#is there a scenario that the compute workload is set by kfd before the OD =
setting, then the compute workload setting is missing
#after the OD setting?

        return ret;
@@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *smu,
                ret =3D smu_pre_display_config_changed(smu);
                if (ret)
                        return ret;
-               ret =3D smu_adjust_power_state_dynamic(smu, level, false, f=
alse);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, false);
                break;
        case AMD_PP_TASK_COMPLETE_INIT:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true, tr=
ue);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
                break;
        case AMD_PP_TASK_READJUST_POWER_STATE:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true, fa=
lse);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
                break;
        default:
                break;
@@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,

 static int smu_switch_power_profile(void *handle,
                                    enum PP_SMC_POWER_PROFILE type,
-                                   bool en)
+                                   bool enable)
 {
        struct smu_context *smu =3D handle;
        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
        long workload[1];
-       uint32_t index;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                return -EOPNOTSUPP;
@@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handle,
        if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
                return -EINVAL;

-       if (!en) {
-               smu->driver_workload_mask &=3D ~(1 << smu->workload_priorit=
y[type]);
-               index =3D fls(smu->workload_mask);
-               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? ind=
ex - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
-       } else {
-               smu->driver_workload_mask |=3D (1 << smu->workload_priority=
[type]);
-               index =3D fls(smu->workload_mask);
-               index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
-       }
+       /* don't disable the user's preference */
+       if (!enable && type =3D=3D smu->power_profile_mode)
+               return 0;

-       smu->workload_mask =3D smu->driver_workload_mask |
-                                                smu->user_dpm_profile.user=
_workload_mask;
+       workload[0] =3D type;

        if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
-               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM)
-               smu_bump_power_profile_mode(smu, workload, 0);
+           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM)
+               smu_bump_power_profile_mode(smu, workload, 0, enable);

        return 0;
 }
@@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *handle,
                                      uint32_t param_size)
 {
        struct smu_context *smu =3D handle;
-       int ret;
+       long workload[1];
+       int ret =3D 0;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
            !smu->ppt_funcs->set_power_profile_mode)
                return -EOPNOTSUPP;

-       if (smu->user_dpm_profile.user_workload_mask &
-          (1 << smu->workload_priority[param[param_size]]))
-          return 0;
-
-       smu->user_dpm_profile.user_workload_mask =3D
-               (1 << smu->workload_priority[param[param_size]]);
-       smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
-               smu->driver_workload_mask;
-       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
+       if (param[param_size] !=3D smu->power_profile_mode) {
+               /* clear the old user preference */
+               workload[0] =3D smu->power_profile_mode;
+               ret =3D smu_bump_power_profile_mode(smu, workload, 0, false=
);
+               if (ret)
+                       return ret;
+               /* set the new user preference */
+               ret =3D smu_bump_power_profile_mode(smu, param, param_size,=
 true);
+               if (!ret)
+                       /* store the user's preference */
+                       smu->power_profile_mode =3D param[param_size];
+       }

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..cd2db06d752b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
        /* user clock state information */
        uint32_t clk_mask[SMU_CLK_COUNT];
        uint32_t clk_dependency;
-       uint32_t user_workload_mask;
 };

 #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
@@ -557,12 +556,10 @@ struct smu_context {
        uint32_t hard_min_uclk_req_from_dal;
        bool disable_uclk_switch;

+       /* backend specific workload mask */
        uint32_t workload_mask;
-       uint32_t driver_workload_mask;
-       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
-       uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+       /* default/user workload preference */
        uint32_t power_profile_mode;
-       uint32_t default_power_profile_mode;
        bool pm_enabled;
        bool is_apu;

@@ -734,8 +731,10 @@ struct pptable_funcs {
         *                          create/set custom power profile modes.
         * &input: Power profile mode parameters.
         * &size: Size of &input.
+        * &enable: enable/disable the profile
         */
-       int (*set_power_profile_mode)(struct smu_context *smu, long *input,=
 uint32_t size);
+       int (*set_power_profile_mode)(struct smu_context *smu, long *input,
+                                     uint32_t size, bool enable);

        /**
         * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..1e44cf6fec4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu=
_context *smu,

 static int arcturus_set_power_profile_mode(struct smu_context *smu,
                                           long *input,
-                                          uint32_t size)
+                                          uint32_t size,
+                                          bool enable)
 {
        DpmActivityMonitorCoeffInt_t activity_monitor;
        int workload_type =3D 0;
@@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu=
_context *smu,
                return -EINVAL;
        }

-       if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
-            (smu->smc_fw_version >=3D 0x360d00)) {
+       if (enable &&
+           (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
+           (smu->smc_fw_version >=3D 0x360d00)) {
                if (size !=3D 10)
                        return -EINVAL;

@@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct s=
mu_context *smu,
                return -EINVAL;
        }

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                          SMU_MSG_SetWorkloadMask,
                                          smu->workload_mask,
                                          NULL);
-       if (ret) {
+       if (ret)
                dev_err(smu->adev->dev, "Fail to set workload type %d\n", w=
orkload_type);
-               return ret;
-       }
-
-       smu_cmn_assign_power_profile(smu);

-       return 0;
+       return ret;
 }

 static int arcturus_set_performance_level(struct smu_context *smu, diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu11/navi10_ppt.c
index 211635dabed8..d944a9f954d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu=
_context *smu, char *buf)
        return size;
 }

-static int navi10_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)
+static int navi10_set_power_profile_mode(struct smu_context *smu, long *in=
put,
+                                        uint32_t size, bool enable)
 {
        DpmActivityMonitorCoeffInt_t activity_monitor;
        int workload_type, ret =3D 0;
+       uint32_t profile_mode =3D input[size];

-       smu->power_profile_mode =3D input[size];
-
-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+               dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
+profile_mode);
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 10)
                        return -EINVAL;

@@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu=
_context *smu, long *input, u
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+                                                      profile_mode);
        if (workload_type < 0)
                return -EINVAL;

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
                                    smu->workload_mask, NULL);
        if (ret)
                dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 844532a9b641..4967e087088b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(st=
ruct smu_context *smu, char *
        return size;
 }

-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, =
long *input, uint32_t size)
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+                                                long *input, uint32_t size=
,
+                                                bool enable)
 {

        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
+       uint32_t profile_mode =3D input[size];
        int workload_type, ret =3D 0;

-       smu->power_profile_mode =3D input[size];
-
-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+               dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
+profile_mode);
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 10)
                        return -EINVAL;

@@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(st=
ruct smu_context *smu, long *
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+                                                      profile_mode);
        if (workload_type < 0)
                return -EINVAL;

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
                                    smu->workload_mask, NULL);
        if (ret)
                dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f89c487dce72..b5dba4826f81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_=
context *smu,
        return size;
 }

-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *i=
nput, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu, long *i=
nput,
+                                         uint32_t size, bool enable)
 {
        int workload_type, ret;
        uint32_t profile_mode =3D input[size];
@@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_=
context *smu, long *input,
        }

        if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVIN=
G)
+           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
                return 0;

        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@ -1080,1=
8 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_context =
*smu, long *input,
                return -EINVAL;
        }

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessN=
otify,
                                    smu->workload_mask,
                                    NULL);
-       if (ret) {
+       if (ret)
                dev_err_once(smu->adev->dev, "Fail to set workload type %d\=
n",
                                        workload_type);
-               return ret;
-       }
-
-       smu_cmn_assign_power_profile(smu);

-       return 0;
+       return ret;
 }

 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu, di=
ff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu12/renoir_ppt.c
index 75a9ea87f419..2d1eae79ab9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *=
smu,
        return ret;
 }

-static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put,
+                                        uint32_t size, bool enable)
 {
        int workload_type, ret;
        uint32_t profile_mode =3D input[size];
@@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_con=
text *smu, long *input, u
        }

        if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVIN=
G)
+           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
                return 0;

        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@ -891,17=
 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *sm=
u, long *input, u
                return -EINVAL;
        }

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessN=
otify,
                                    smu->workload_mask,
                                    NULL);
-       if (ret) {
+       if (ret)
                dev_err_once(smu->adev->dev, "Fail to set workload type %d\=
n", workload_type);
-               return ret;
-       }

-       smu_cmn_assign_power_profile(smu);
-
-       return 0;
+       return ret;
 }

 static int renoir_set_peak_clock_by_device(struct smu_context *smu) diff -=
-git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80c6b1e523aa..3cc734331891 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struc=
t smu_context *smu,

 static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
                                              long *input,
-                                             uint32_t size)
+                                             uint32_t size,
+                                             bool enable)
 {
        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
+       uint32_t profile_mode =3D input[size];
        int workload_type, ret =3D 0;
        u32 workload_mask;

-       smu->power_profile_mode =3D input[size];
-
-       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
+               dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
+profile_mode);
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 9)
                        return -EINVAL;

@@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+                                                      profile_mode);

        if (workload_type < 0)
                return -EINVAL;

        workload_mask =3D 1 << workload_type;

+       if (enable)
+               smu->workload_mask |=3D workload_mask;
+       else
+               smu->workload_mask &=3D ~workload_mask;
+
        /* Add optimizations for SMU13.0.0/10.  Reuse the power saving prof=
ile */
        if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0) &&
             ((smu->adev->pm.fw_version =3D=3D 0x004e6601) || @@ -2658,25 +=
2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context=
 *smu,
                                                               CMN2ASIC_MAP=
PING_WORKLOAD,
                                                               PP_SMC_POWER=
_PROFILE_POWERSAVING);
                if (workload_type >=3D 0)
-                       workload_mask |=3D 1 << workload_type;
+                       smu->workload_mask |=3D 1 << workload_type;
        }

-       smu->workload_mask |=3D workload_mask;
        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                               SMU_MSG_SetWorkloadMask,
                                               smu->workload_mask,
                                               NULL);
-       if (!ret) {
-               smu_cmn_assign_power_profile(smu);
-               if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_POW=
ERSAVING) {
-                       workload_type =3D smu_cmn_to_asic_specific_index(sm=
u,
-                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
-                                                              PP_SMC_POWER=
_PROFILE_FULLSCREEN3D);
-                       smu->power_profile_mode =3D smu->workload_mask & (1=
 << workload_type)
-                                                                          =
     ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-                                                                          =
     : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-               }
-       }

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c5d3e25cc967..1aafd23857f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2528,22 +2528,23 @@ do {                                               =
                                                     \
        return result;
 }

-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+                                             long *input, uint32_t size,
+                                             bool enable)
 {

        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
+       uint32_t profile_mode =3D input[size];
        int workload_type, ret =3D 0;

-       smu->power_profile_mode =3D input[size];
-
-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
+               dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
+profile_mode);
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 8)
                        return -EINVAL;

@@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struc=
t smu_context *smu, long *inp
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+                                                      profile_mode);
        if (workload_type < 0)
                return -EINVAL;

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
                                    smu->workload_mask, NULL);

        if (ret)
                dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..695480833603 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(struc=
t smu_context *smu,

 static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
                                              long *input,
-                                             uint32_t size)
+                                             uint32_t size,
+                                             bool enable)
 {
        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
+       uint32_t profile_mode =3D input[size];
        int workload_type, ret =3D 0;
        uint32_t current_profile_mode =3D smu->power_profile_mode;
-       smu->power_profile_mode =3D input[size];

-       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
+               dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
+profile_mode);
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 9)
                        return -EINVAL;

@@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct =
smu_context *smu,
                }
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
+       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
                smu_v14_0_deep_sleep_control(smu, false);
        else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
                smu_v14_0_deep_sleep_control(smu, true); @@ -1791,15 +1792,=
16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu=
,
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+                                                      profile_mode);
        if (workload_type < 0)
                return -EINVAL;

+       if (enable)
+               smu->workload_mask |=3D (1 << workload_type);
+       else
+               smu->workload_mask &=3D ~(1 << workload_type);
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
-                                                                          =
       smu->workload_mask, NULL);
-
-       if (!ret)
-               smu_cmn_assign_power_profile(smu);
+                                             smu->workload_mask, NULL);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index fd2aa949538e..63c4f75fa118 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
        return ret;
 }

-void smu_cmn_assign_power_profile(struct smu_context *smu) -{
-       uint32_t index;
-       index =3D fls(smu->workload_mask);
-       index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? index - 1 :=
 0;
-       smu->power_profile_mode =3D smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)  {
        struct pci_dev *p =3D NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 8a801e389659..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t=
 frev, uint8_t crev);  int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state);

-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
--
2.47.0

