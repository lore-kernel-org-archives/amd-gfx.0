Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84758C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 11:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F053210E210;
	Fri, 21 Aug 2026 11:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5BwlXPR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD2910E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 11:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPjUa5YK8b8VOaZga/f6SefvQvDM6HoYBA4MxaBs14+Pi6jdg61Ckl1QztCKkUEjjlWxBtJWHYKgfoPP7Ry2YF9a/JNiSXgXGmhXXt5shKyoahV/eRiodEwOhjZuiD4pU0HxKYD/rS64xAkvsft8v/mKbReRngjhQs5kbA31qkC1DCqTdywUUUgOBAWkusp10jHtuXgK76xZyn/yPRSBmQtfR+qGMzhgyhrRyu9BdQ90RpGXtFen0dYukPrFnErlLXEtYdeVhxl/uV4xi2u1PT3pejpxel/HTyDybRYsTcS0PMVjvJIb5DRE8vmcK22NCZlRzo5n8t9/nER0o9obqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKr4zI63lWrO1P5SbGmNR7wZ0uX3jVfjE0ZOCOOdOSQ=;
 b=Ne1kFHQvaGktmt/h3Z7q9/wRqf4qb3cvE4H7EE9+Qy9YP275MOSXYjh4iTwfErwpRpX7/dcfAGxO2eKqwpJIp+R1KOEuROK8YqlcY3Zt4qpJ9b+ROcCp9fMlzasznpync/0hJrF0Gwj9/fN8/tdAdIPT6SmM4N6cwTZ3f5JlXNVQa1wjFp7yyJg572TAKOHHtzGNXzpCYeetTQvT0SNn97ZpOtPLdlR3YV2V/kCe96dKHeQcGCXQDqNH1mSFV/yalxWyyCr0m+7s/qXI0O6zFgtqshi7zWhWCBbbAzUYdS+rkd2901c+MiQPXb8y3IZrDAZjbEG6DrXuPm4QdKYpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKr4zI63lWrO1P5SbGmNR7wZ0uX3jVfjE0ZOCOOdOSQ=;
 b=Q5BwlXPRrA0MU5ni0QuDXOsXUhqgd8JLRRFJ+ws6KmHRyz8toirQZA3i+2FYO78cyZTHsvy5qm/JlcmXstJa14rIP+HvGuuoWCV5S6EEpiH3foYApBGVEpyD62b+0tnxrhoGj0PYoPrMjgHzhGK7A8Skg3fwq0BVrFQwX0ptuR4=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:40:22 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0315.016; Fri, 21 Aug 2026
 11:40:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: clamp the isolation index for rings outside a
 partition
Thread-Topic: [PATCH] drm/amdgpu: clamp the isolation index for rings outside
 a partition
Thread-Index: AQHdMVVMZ5wasIeg0U2A5IWJDHeMbLaoYPLA
Date: Fri, 21 Aug 2026 11:40:21 +0000
Message-ID: <BYAPR12MB31928FEACB84173B2B3C2029FCA32@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260821100906.1652542-1-xiang.liu@amd.com>
In-Reply-To: <20260821100906.1652542-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-21T11:40:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|IA0PPF8FC6E1236:EE_
x-ms-office365-filtering-correlation-id: 060a74b3-46fb-4cdc-78ea-08deff78fbac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|6133799003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: IWpytqw4RNOdfLVqn8WXzP7qt2n7YSkvqotXn5DZgTFPE833evydVIiBRrcF1hQmgRsfhM9qvh3Kt88IvNR2hOrWFH3D9p3ZqjUxHBWzLdN1erCPlqj5BhK2d0FE+yAS2ncpeYYuwgw9ybRvtqrJt/lUDcZvJqtkJ32QvkyzJk/8vC9e1vTpuZZH4nruOa4CnpzyuweXYbhqDj8lrIeU8PFtf04jS2yjpztt4YBXOK4MgUHvKj833JRnO6+kj0Z2ymC8yek+kqwFIW89auJ6Iz/PExc74ywGM/GoccLDm05rYxlzTkVRmDUboDqs4QoPdQyusF3+XoxnHexOXd0lPMONecFl+66iO96UBORrZj07a/u63rqokh4xH0JvUgIqcJry9GOgUPZMq6XbRwUHAVZieQuGt7XRYm+IooWunHfRXk9TtZZQldoNfHhZcIIXdlYDK1S6QMhmCRYAOClHQSFEljVoYAgfA7vC8Py9UYjzp3mJiNXNeQJQkVUAHMYj71Dj4apoaTmasaMaq16doRno3cLcf4Cj8p8Nr/oGMTspjzfpF8czQH07WPnTBT6BE6zUEDkoUQImzIWrX3uozkE/nvsqzLtjdvS8yf3R0tYYGO7M5AuJpjeZ0OhHHkD2+40tFrSO2bJd+27zk7xd3yPzCNwWA/19GXbvoraVc8lIlJHpH19dIVU7TcStBGo/5adR5VzitoYqzSe9klh19LYvtnohGaAhlbEnXY1wqWI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WoEoY0yQgliVTQ6Ygp3XfCVc8lwqH+5opmmYjuEqvaKiZXv/Xrr2+QlAUy4A?=
 =?us-ascii?Q?ZN4NqsNz3QyG8DPTKaoV3aDj8oIukqT1UjLVrzN6+UdE5qJ/snmZQUJrUGRL?=
 =?us-ascii?Q?7yWwlGXpUW1hFzT05gjBgiRB689PiJZF981YZOBu7BbsAzDYUIv16VNHLEGS?=
 =?us-ascii?Q?gG8/vne4XDIrwu6znbppYqk+r6dWCDtu2ivcU2hgyHJk3jnm5QrzA1igtNqS?=
 =?us-ascii?Q?NuUuevwg1M6WO3REYJyeGo/YQEVmXsokk9bAZ0sIEtol7iLeJ/G8uXcYRm0s?=
 =?us-ascii?Q?tTnufF4YaGS+xa9G9ivUxiVOeYdDe3mOUoEgcYZA7QgxSqR7IxiVh8stxgMD?=
 =?us-ascii?Q?icvDoMQlKEDszLmZnI1ufRi0yKnct/V3l+OMskK+C/aDIGOo3BfUTO247jE4?=
 =?us-ascii?Q?07ORJADd+dyJV1OS5DAyoIDDxY/C1mhLEvgjOM/x7l8JpAFEv/4A0Dy9LF1C?=
 =?us-ascii?Q?3EBDKYjGaY8QjvI8PEE4wEDjZLjIFe0HmkhaE8qJOQBk3UibfbmTkmVM+nq9?=
 =?us-ascii?Q?nCXmNHr8c+qsxUBJK4/WmzB0EcrERQfLbtJ6lLq4B+BVu+OpGfj2azpsuyYh?=
 =?us-ascii?Q?HS9+t6mOgfDXW/kgVFDwWjj1Z82hXQcljPW+eZryP38MhNN31HnUgGGgwTP7?=
 =?us-ascii?Q?bdNr+aBvpwfR4BJEaCPrz+0NO6GdtcNXnt2w4tC5cyExmuoDUlRtxipogAwv?=
 =?us-ascii?Q?3/EfwPbOP38TrS26KiNvAY+yXoqs+yAmXi4jsUZKTFYXW/T5FkTaem1Avr7X?=
 =?us-ascii?Q?OaXjuHuulUQchP53sEfanzNz7HB///cpnkR99HK62gWpVU2NywdyHu3KZmtb?=
 =?us-ascii?Q?udOMi1vt2W+lvQVfR9tARcQ2qoFB82NcvOdXsNdVSh2c5SOzWEpwk4aMyxDw?=
 =?us-ascii?Q?8S+2RTSw0f5mBH0LSb4eTkpCGaNzmad6uk+GGCxUwnev/zx7EG0uRZcLMBvt?=
 =?us-ascii?Q?3a8OAG4qUR1/FirxY97qoPVf3DQGVEq4FtINREWZ944XCKrHNu2TNtCo8XUJ?=
 =?us-ascii?Q?muZgybCYDGZnRGz07fifEWyKr5qWr5OiLF6A6orZ2xTCtTKtxzpm4Af0oqWZ?=
 =?us-ascii?Q?a2FsvFSb04iV/sgcxKFx4tJOsijWwAoH4KKuZsELhffrgkbZIuFVGyvBmODU?=
 =?us-ascii?Q?zKTg3yf8XR/2uixhWnMd6GyBte06kGnI//h4EQ+O+x0c9ixyswRYxzFGe8g5?=
 =?us-ascii?Q?69V6sztpHZapxfjSHXDzsqjGRKyuF0LJ7ifOfz7Ke8F5oBt+mQHKz7H0b/II?=
 =?us-ascii?Q?hxODHftXNuCEieBGDU6/4qtIKJO23kefB42q/j2PebOmj7Rw9vVwQtflRKzX?=
 =?us-ascii?Q?wXNAdq9l/3GSEyB4xBV8GRwAJP0j8akEg6RNFt+A+wRFD46xYyw5Eze4L4mZ?=
 =?us-ascii?Q?wdH1knsTsHxs3pZZG9Fk6o5aq5R6qzIvYBKaJKCvW/qhWMqF5To8HLY3dbCC?=
 =?us-ascii?Q?7iu3G3XEvlxjBl+HUlLRzsdURMSOFQMlFaInLtzTKKPbd0GjjXkBbB/K6psw?=
 =?us-ascii?Q?DAqoty23q2zHrIUh/Ll79YTnZg77vNZoWTQ3r/k6ddTigRYTcA220kEsvJQt?=
 =?us-ascii?Q?v/91M3/Qh841jRbsjV/2aji6T85OPd4ovCoX14h+fBtlokf1WFaJVIzqgLEV?=
 =?us-ascii?Q?Y1k7IJcx7muwlviQcyz+7lKkg6Mg3pyU9CGy/XOI/08MY/PL0aKtlLXtheoc?=
 =?us-ascii?Q?+5W0l9h65jgWXImuFTRf6w+4B9c1MitAxJ6nHylRpACFgMd5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060a74b3-46fb-4cdc-78ea-08deff78fbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 11:40:21.6259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksRT6fzzI7sEwzLQbbFdRULozAj0xk0uWOYImSXLLvDSWzdn19S+WJWw68iu16U2WViqCwslfFYOf8RLLqgzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Friday, August 21, 2026 6:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: clamp the isolation index for rings outside a =
partition

adev->isolation[] has one slot per partition, but a ring that is not
assigned to one keeps AMDGPU_XCP_NO_PARTITION, which is ~0, so indexing the=
 array with it is out of bounds. SDMA submissions hit this on both the isol=
ation enforcement and the VM flush path and trip UBSAN.

Fall back to the first slot the way the cleaner shader path already does, a=
nd stop taking the address before the ring type check that makes it relevan=
t.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index baadb676f76b..d8d182599fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6756,8 +6756,8 @@ struct dma_fence *amdgpu_device_enforce_isolation(str=
uct amdgpu_device *adev,
                                                  struct amdgpu_ring *ring,
                                                  struct amdgpu_job *job)
 {
-       struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp_i=
d];
        struct drm_sched_fence *f =3D job->base.s_fence;
+       struct amdgpu_isolation *isolation;
        struct dma_fence *dep;
        void *owner;
        int r;
@@ -6770,6 +6770,9 @@ struct dma_fence *amdgpu_device_enforce_isolation(str=
uct amdgpu_device *adev,
            ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
                return NULL;

+       isolation =3D &adev->isolation[ring->xcp_id =3D=3D AMDGPU_XCP_NO_PA=
RTITION ?
+                                    0 : ring->xcp_id];
+
        /*
         * All submissions where enforce isolation is false are handled as =
if
         * they come from a single client. Use ~0l as the owner to distinct=
 it diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
index 5a6f5151c3ca..743d307c71fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -774,7 +774,9 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct a=
mdgpu_job *job,
                     bool *emit_gds_needed)
 {
        struct amdgpu_device *adev =3D ring->adev;
-       struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp_i=
d];
+       struct amdgpu_isolation *isolation =3D
+               &adev->isolation[ring->xcp_id =3D=3D AMDGPU_XCP_NO_PARTITIO=
N ?
+                                0 : ring->xcp_id];
        unsigned vmhub =3D ring->vm_hub;
        struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub];
        struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
--
2.34.1

