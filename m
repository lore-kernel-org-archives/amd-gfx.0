Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93927C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 19:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F1210EB88;
	Tue,  4 Aug 2026 19:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EgLNh6+i";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB7910EB8D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 19:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvzEbjkxtIbWZKIDulRpN12TlByrjjOczSjuOmfnXgK6BeF7T2iVLmg48fXjHUqdPn0+IWJPXoBscTx0ifk/msF/lRnr/bvnmsD9dJOgOVPdSZH2jWM74YDKaTgEQ5lHTDDavG7EwnrKcixO8mVXdJfBR+t521D26xUvpmP3YOhpFMTHI9YGwIlhRR65YvF56uqhgJJ9FzEEx9tAQTFGMlcGVEAPxwBI8dJWz8pNMYr2BLs5SJufXUvtQtDLQ42LRarfZTdf//8J+RCyZM7TizhKyeMjblRv/Bz5cuWg6gcW+w0gaoT1oQCK7MzrpyF6L53ZPhcZp18KBmsXq57HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q90eN2JMj3nIby29oM74KaCfnVjehEdTHrqYb3e6CBE=;
 b=VWeGfpk6mOT2a+ikR+ItQABvoyUQMQs8EUsKllFZ+ZtOUgeLJvXf/E0OJ8vBCGaTpOmkWHOPDe46d1tRcokM01khpQ938+u7lLBZ9PDdwOU1X+C4Ns8Sq+2TMdabMergMiY/CClghdYWNm0kTvzzKq68gspB9kpbw/DJGPLJRiDi/E5LQCVTlcyhU6xFcM8IBHvZUpwkcpKvqlK2w15FXFemmQUIPTN4RGM+lOKssuv1r369ZxNLd+Wo74Qt6KWLC422SlfSyCCcTRWU7pjIszPbUy57tAv4FyuovmtHbwwdaYYRmeqgevTQPGEYcIAe1XWrKA0ouBqojAS01ZsUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q90eN2JMj3nIby29oM74KaCfnVjehEdTHrqYb3e6CBE=;
 b=EgLNh6+iDxrF6BxT5vF2PisQnELgMzKC0EHGGTEzKKfEp3GAFPjfXjp4cVAMY4S4Br3XBTcygwWlzMp6IZ+udgDlhQ5STCNqsnmlsyqqsreJF3xnN5QgyzC99dWQuElqnZ/gV/VfPd0PNBeaxPadij6BjBbLOhfzfNUlTW7lkHQ=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by PH0PR12MB999088.namprd12.prod.outlook.com (2603:10b6:510:38d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 19:14:18 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 19:14:18 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix NULL pointer dereference in GFX12 CRIU queue
 restore
Thread-Topic: [PATCH] drm/amdkfd: fix NULL pointer dereference in GFX12 CRIU
 queue restore
Thread-Index: Ad0kRS5LcXzqpLnbSDGUkR09yDpgVg==
Date: Tue, 4 Aug 2026 19:14:18 +0000
Message-ID: <SA1PR12MB8600E8B1821FA7D76923FC259FD42@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T19:11:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|PH0PR12MB999088:EE_
x-ms-office365-filtering-correlation-id: c52d48f8-507e-4626-cc02-08def25c9508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|10067099003|6133799003|56012099006|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: 9RNKNbgi51z71vi8gjnwtjjProTI8CTGbS88GVlXFXScD++XcOWOBpHDxNEAXS6iy1i1TO2TEhvZzk6CFZlOdTBHzisb7Ghy5gylsiefbNzRDvGDu+BQDHbhUB8IQjIJAPIP+zfVuZBrzU+9C03WxWEkvptktQPCPMemfkd6+PqGqwv40rEc6dGU4J8sn6aSGNQ+OAegSW20MLehoKEHrXQRD4+W+MkmmS+HH2y4V/MnjctvF3YQrd59F/GSus6VOKgul2RRP7hyK5Oqc1s1ywsnH+ECAhO+LRhP4Pv0T6oQAUIfS1qdXm0Od/m6Eu4FjYWz5oatutTBy7ho0N4Le9mAEPH6wx8j7XJDDxylwOhi3AREoMM8Dd9sqEc//FZ9rjyV+bcJShA/RBkEw0UIML9O1+tW3SNAG6vS2IfXLO6b6xcjHomVborhk//sVM8sJsC0LCNdtX6u3z3KP9Dsc/QBEo86uakvbXD1Kb0BnCl/KS0s1DppZ57+kdKED8HPRPT8kXI9B+YOGi69N0qYbnWDy8mSMYsIzDfAbn63ufgi4LWHk24Ybe+M+as7ospTez6WbhxKQXJgaDkob5cMT0EWKh9Iatd+M+eJXKE0fU5OYSI2S8V2pN2kQI1WJv6tQbxA1ZWhQ8qSHznEN59Xxqo9hJ4f0+msjMp2XRrgiUsuM3SsWhqF76ld0NTSPCMCQ0AtfQJSZPy/fHCCnUq6tKc0togE5GyHRBZb1pCL5Mo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1sXRvH/B5esOsGOPSDcpHA5chGj8kySs7CnA39+0xjUcz7+iaCzAbm0e4I3e?=
 =?us-ascii?Q?ssqCl+2XH71G5qo4NCG3kPAXriMxAtnmg/H/RlRSMbrM5tEqbw+Bl+bMAP4n?=
 =?us-ascii?Q?D3bw3ZN7o96xOO7iAd7TKx/WjROltX5rCdjgyKfpD53ZKCpDkgBZtrwrmOhN?=
 =?us-ascii?Q?fSe5koaiEgbLkW0PxNDAzLBkcbm3WProcJbgVvGfGCEz7LcPZEXvBZjYH/Kx?=
 =?us-ascii?Q?/umZZG+9RKhZe3W5ryj3LtSUWoSpw0gJ/mXFlHcNUhRONov+SUcZu74A/JVg?=
 =?us-ascii?Q?8dTDLB59b5kp86k30m8ltk1jA/lX4xamYivDnKeWFYLMtiJg4lFNvFaxv8UC?=
 =?us-ascii?Q?CoCZnFi9T8+PGXSi7SHpaUxPV+pNGDDv3t04rs2vnv8FHw7sxLc5gCPwQufv?=
 =?us-ascii?Q?UB2VzyK5pUd7yxNHZhnDZF0IgRlqse8YipCFW93YSTi3ZIoSYNpALL8v4gSw?=
 =?us-ascii?Q?30Dq/Tp3aUqD04SlzfVEgVcTY9HIV/VKAfgQ6w8mCcrLbLt3n7smtPjyDoin?=
 =?us-ascii?Q?ISCQsjw0vuOO3BexBNUToyxzuuZoWzndXQQe6mdNnlfMszgJW9LxyXKCXk4V?=
 =?us-ascii?Q?2GwXwjYnYAtfDm26o8KPIMPI9q3E2WWFOxLzPYTMKvGTj3J8+em3Aj51k6OR?=
 =?us-ascii?Q?mwIFkffedm9k6gulfqWri0I7ryx0tmWhdFmniMFvf5YO0GZPv9DlN7ec4ZmB?=
 =?us-ascii?Q?npkWW40UTt/v1oQb7H3XZqLAL7NNnf9sE58faoGW1QCfv4q2BW8JPtplPH48?=
 =?us-ascii?Q?ndniiezO7hgPG+xOQw/Q4Xa01xhQItyvJrMyeRxBZYRvif92CiNybf1ixqQy?=
 =?us-ascii?Q?UhZa6DdbWdIdyVkc1+X3X9WpuBxLpWn5mWXS1sIjD8J0L1YBzzWDo+/p8ivO?=
 =?us-ascii?Q?MSqZviUT+EYH+nZ5TsCTiafl0E184t/7sQBcsxw3yydL7CBXOjmUcoZCm80z?=
 =?us-ascii?Q?ktWSZl6euOVb7HRN/kJ5pk3Pxfr6KlUp3zUI6x499XHUuku3kaFvqPE9ETAr?=
 =?us-ascii?Q?nZ3qmw4r+LG+1fTX1lmoi+XERAGpKrNakfXht8qcxL2FRXNt4ZYbg3swfclY?=
 =?us-ascii?Q?o0wOWus+csU3lVueyqzeRWTYph1DgmUXSAjGx3Ii7MS0OQmQVZWAovEkvNVI?=
 =?us-ascii?Q?31gQk3IlSkDHNUdr9VYAPJchdg2Hwjpd880jqUAUa1dOXb0aVOhbZScIkp1H?=
 =?us-ascii?Q?QHayF+tUhv5+XaKaKhQ/VYrh6OVZt+ASA3ktkEQFjnaZzFSEPjdqcjbDbuIp?=
 =?us-ascii?Q?COQS78g0b8ODemC7YsNJxfLPsBuU2UnlPUzuzfP8CeHrMDGZeza4S4MwWHS6?=
 =?us-ascii?Q?kmVHeH7gH7dSINm96Rtv5wgF3143j7kN1ny/6+u0ZNshSJqjoTFJo44PmxSQ?=
 =?us-ascii?Q?7IOalHhC/u5j6KxIk7ZaJdABreRMQOVSR2ob5UlGU2PTjxUZQGxb2z7wYNkI?=
 =?us-ascii?Q?BkjDHfBZQE3etph93JUL3bgJwkRMgsAWjLeuIT+TJZGHafvrJc1c1yRrfuZA?=
 =?us-ascii?Q?eNRuz3uEYQGZftgYq9jypGCG/xIzJHphUnpGhgBMJMm97YK65MggL93hnDow?=
 =?us-ascii?Q?dNpsr3NzKn/R0MSLZPGiNIQsmbSgpSA+Y6evSMj25nzG+WOrkVMR1sROLc+1?=
 =?us-ascii?Q?jnE7xcyVypOjTMXllwz4OibR6f7xPTrcS4KY2bivYp54/a7pbRzqiW4jMmlw?=
 =?us-ascii?Q?lCrrhTx61KDbBI3HEYHBDNPP3OSEtIRPpNpGajeSbHzYheSQ?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600E8B1821FA7D76923FC259FD42SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d48f8-507e-4626-cc02-08def25c9508
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 19:14:18.4426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcuaZi7JbtodNhtHY2tFrNrHOSqTml+pRrfYjA6DsSUYfR+Qbspe1WhCYJ+ScobqkLuFulrW37ms0lM3NyROoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999088
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

--_000_SA1PR12MB8600E8B1821FA7D76923FC259FD42SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager_v12_1.c (GFX 12.1)
initialize their MQD managers without assigning restore_mqd or checkpoint_m=
qd
callbacks, leaving both function pointers NULL.

Both create_queue_cpsch() and create_queue_nocpsch() in
kfd_device_queue_manager.c unconditionally call mqd_mgr->restore_mqd() when
a CRIU restore is in progress (qd !=3D NULL), with no NULL guard. On any sy=
stem
with a GFX 12.x GPU, a user holding CAP_CHECKPOINT_RESTORE can trigger a
kernel NULL pointer dereference and panic the machine by issuing
KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore object.

Fix this by:
1. Implementing restore_mqd and checkpoint_mqd callbacks for both compute
   and SDMA queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_v12_1.c,
   modeled after the GFX 11 implementation.
2. Adding a NULL guard at both call sites in kfd_device_queue_manager.c
   as a defensive measure against future regressions.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
---
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++--
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c      | 69 ++++++++++++++++=
+++++++++++++++++++++++
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 69 ++++++++++++++++=
++++++++++++++++++++++
3 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..31bf479212e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -794,11 +794,16 @@ static int create_queue_nocpsch(struct device_queue_m=
anager *dqm,
                goto out_deallocate_doorbell;
        }

-       if (qd)
+       if (qd) {
+               if (!mqd_mgr->restore_mqd) {
+                       pr_err("amdkfd: restore_mqd not implemented for thi=
s GPU\n");
+                       retval =3D -EINVAL;
+                       goto out_deallocate_doorbell;
+                }
                mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->=
gart_mqd_addr,
                                     &q->properties, restore_mqd, restore_c=
tl_stack,
                                     qd->ctl_stack_size);
-       else
+       } else
                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
                                        &q->gart_mqd_addr, &q->properties);

@@ -2153,11 +2158,16 @@ static int create_queue_cpsch(struct device_queue_m=
anager *dqm, struct queue *q,
        q->properties.is_dbg_wa =3D qpd->pqm->process->debug_trap_enabled &=
&
                                  kfd_dbg_has_cwsr_workaround(q->device);

-       if (qd)
+       if (qd) {
+               if (!mqd_mgr->restore_mqd) {
+                       pr_err("amdkfd: restore_mqd not implemented for thi=
s GPU\n");
+                       retval =3D -EINVAL;
+                       goto out;
+                }
                mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->=
gart_mqd_addr,
                                     &q->properties, restore_mqd, restore_c=
tl_stack,
                                     qd->ctl_stack_size);
-       else
+       } else
                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
                                        &q->gart_mqd_addr, &q->properties);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 7c387fa90076..c6a8e99ad069 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -380,6 +380,75 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)

#endif

+static void checkpoint_mqd(struct mqd_manager *mm, void *mqd,
+                           void *mqd_dst, void *ctl_stack_dst)
+{
+       struct v12_compute_mqd *m;
+
+       m =3D get_mqd(mqd);
+
+       memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+                        struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_ad=
dr,
+                        struct queue_properties *qp, const void *mqd_src,
+                        const void *ctl_stack_src, const u32 ctl_stack_siz=
e)
+{
+       uint64_t addr;
+       struct v12_compute_mqd *m;
+
+       m =3D (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
+       addr =3D mqd_mem_obj->gpu_addr;
+
+       memcpy(m, mqd_src, sizeof(*m));
+
+       *mqd =3D m;
+       if (gart_addr)
+               *gart_addr =3D addr;
+
+       m->cp_hqd_pq_doorbell_control =3D
+               qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OF=
FSET__SHIFT;
+       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doorbell=
_control);
+
+       qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma(struct mqd_manager *mm, void *mqd,
+                                void *mqd_dst, void *ctl_stack_dst)
+{
+       struct v12_sdma_mqd *m;
+
+       m =3D get_sdma_mqd(mqd);
+
+       memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+                             struct kfd_mem_obj *mqd_mem_obj, uint64_t *ga=
rt_addr,
+                             struct queue_properties *qp,
+                             const void *mqd_src,
+                             const void *ctl_stack_src,
+                             const u32 ctl_stack_size)
+{
+       uint64_t addr;
+       struct v12_sdma_mqd *m;
+
+       m =3D (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+       addr =3D mqd_mem_obj->gpu_addr;
+
+       memcpy(m, mqd_src, sizeof(*m));
+
+       m->sdmax_rlcx_doorbell_offset =3D
+               qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__S=
HIFT;
+
+       *mqd =3D m;
+       if (gart_addr)
+               *gart_addr =3D addr;
+
+       qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
                struct kfd_node *dev)
{
@@ -407,6 +476,8 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                mqd->mqd_size =3D sizeof(struct v12_compute_mqd);
                mqd->get_wave_state =3D get_wave_state;
                mqd->mqd_stride =3D kfd_mqd_stride;
+               mqd->checkpoint_mqd =3D checkpoint_mqd;
+               mqd->restore_mqd =3D restore_mqd;
#if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -453,6 +524,8 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                mqd->is_occupied =3D kfd_is_occupied_sdma;
                mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                mqd->mqd_stride =3D kfd_mqd_stride;
+               mqd->checkpoint_mqd =3D checkpoint_mqd_sdma;
+               mqd->restore_mqd =3D restore_mqd_sdma;
#if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 431a940f91f3..7ee98ef084ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -641,6 +641,75 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)

#endif

+static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+                                 void *mqd_dst, void *ctl_stack_dst)
+{
+       struct v12_1_compute_mqd *m;
+
+       m =3D get_mqd(mqd);
+
+       memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
+}
+
+static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
+                              struct kfd_mem_obj *mqd_mem_obj, uint64_t *g=
art_addr,
+                              struct queue_properties *qp, const void *mqd=
_src,
+                              const void *ctl_stack_src, const u32 ctl_sta=
ck_size)
+{
+       uint64_t addr;
+       struct v12_1_compute_mqd *m;
+
+       m =3D (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
+       addr =3D mqd_mem_obj->gpu_addr;
+
+       memcpy(m, mqd_src, sizeof(*m));
+
+       *mqd =3D m;
+       if (gart_addr)
+               *gart_addr =3D addr;
+
+       m->cp_hqd_pq_doorbell_control =3D
+               qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OF=
FSET__SHIFT;
+       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doorbell=
_control);
+
+       qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma_v12_1(struct mqd_manager *mm, void *mqd,
+                                      void *mqd_dst, void *ctl_stack_dst)
+{
+       struct v12_sdma_mqd *m;
+
+       m =3D get_sdma_mqd(mqd);
+
+       memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma_v12_1(struct mqd_manager *mm, void **mqd,
+                                   struct kfd_mem_obj *mqd_mem_obj, uint64=
_t *gart_addr,
+                                   struct queue_properties *qp,
+                                   const void *mqd_src,
+                                   const void *ctl_stack_src,
+                                   const u32 ctl_stack_size)
+{
+       uint64_t addr;
+       struct v12_sdma_mqd *m;
+
+       m =3D (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+       addr =3D mqd_mem_obj->gpu_addr;
+
+       memcpy(m, mqd_src, sizeof(*m));
+
+       m->sdmax_rlcx_doorbell_offset =3D
+               qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__S=
HIFT;
+
+       *mqd =3D m;
+       if (gart_addr)
+               *gart_addr =3D addr;
+
+       qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
                struct kfd_node *dev)
{
@@ -668,6 +737,8 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                mqd->mqd_size =3D sizeof(struct v12_1_compute_mqd);
                mqd->get_wave_state =3D get_wave_state_v12_1;
                mqd->mqd_stride =3D kfd_mqd_stride;
+               mqd->checkpoint_mqd =3D checkpoint_mqd_v12_1;
+               mqd->restore_mqd =3D restore_mqd_v12_1;
#if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -714,6 +785,8 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                mqd->is_occupied =3D kfd_is_occupied_sdma;
                mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                mqd->mqd_stride =3D kfd_mqd_stride;
+               mqd->checkpoint_mqd =3D checkpoint_mqd_sdma_v12_1;
+               mqd->restore_mqd =3D restore_mqd_sdma_v12_1;
#if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
#endif

--_000_SA1PR12MB8600E8B1821FA7D76923FC259FD42SA1PR12MB8600namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager=
_v12_1.c (GFX 12.1)<o:p></o:p></p>
<p class=3D"MsoNormal">initialize their MQD managers without assigning rest=
ore_mqd or checkpoint_mqd<o:p></o:p></p>
<p class=3D"MsoNormal">callbacks, leaving both function pointers NULL.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Both create_queue_cpsch() and create_queue_nocpsch()=
 in<o:p></o:p></p>
<p class=3D"MsoNormal">kfd_device_queue_manager.c unconditionally call mqd_=
mgr-&gt;restore_mqd() when<o:p></o:p></p>
<p class=3D"MsoNormal">a CRIU restore is in progress (qd !=3D NULL), with n=
o NULL guard. On any system<o:p></o:p></p>
<p class=3D"MsoNormal">with a GFX 12.x GPU, a user holding CAP_CHECKPOINT_R=
ESTORE can trigger a<o:p></o:p></p>
<p class=3D"MsoNormal">kernel NULL pointer dereference and panic the machin=
e by issuing<o:p></o:p></p>
<p class=3D"MsoNormal">KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore=
 object.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix this by:<o:p></o:p></p>
<p class=3D"MsoNormal">1. Implementing restore_mqd and checkpoint_mqd callb=
acks for both compute<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; and SDMA queues in kfd_mqd_manager_v12.=
c and kfd_mqd_manager_v12_1.c,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; modeled after the GFX 11 implementation=
.<o:p></o:p></p>
<p class=3D"MsoNormal">2. Adding a NULL guard at both call sites in kfd_dev=
ice_queue_manager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; as a defensive measure against future r=
egressions.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: 48f0bdf4e38e (&quot;drm/amdkfd: Added MQD man=
ager files for GFX12.&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Fixes: 01bbc4a4b947 (&quot;drm/amdkfd: Add MQD manag=
er for GFX 12.1.0&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;Vladimir.Mar=
ioukhine@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c | 10 ++++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 69 +++++++++++++++++++++++++++++++++++++++<o:p=
></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c&n=
bsp;&nbsp;&nbsp; | 69 ++++++++++++++++++++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 146 insertions(+), 2 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_q=
ueue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">index 51ee9c39104b..31bf479212e5 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -794,11 +794,16 @@ static int create_queue_nocpsc=
h(struct device_queue_manager *dqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_deallocate_doorbell;<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qd)<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qd) {<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd) {<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pr_err(&quot;amdkfd: restore_mqd not implemented for this GPU\n&quot=
;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; retval =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out_deallocate_doorbell;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &am=
p;q-&gt;mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;q-&gt;properties, restore_mqd, restore_ctl_stack,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; qd-&gt;ctl_stack_size);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q=
-&gt;mqd, q-&gt;mqd_mem_obj,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;prope=
rties);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -2153,11 +2158,16 @@ static int create_queue_cpsc=
h(struct device_queue_manager *dqm, struct queue *q,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;pro=
perties.is_dbg_wa =3D qpd-&gt;pqm-&gt;process-&gt;debug_trap_enabled &amp;&=
amp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd=
_dbg_has_cwsr_workaround(q-&gt;device);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qd)<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qd) {<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd) {<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pr_err(&quot;amdkfd: restore_mqd not implemented for this GPU\n&quot=
;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; retval =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &am=
p;q-&gt;mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;q-&gt;properties, restore_mqd, restore_ctl_stack,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; qd-&gt;ctl_stack_size);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q=
-&gt;mqd, q-&gt;mqd_mem_obj,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;q-&gt;gart_mqd_addr, &amp;q-&gt;prope=
rties);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7c387fa90076..c6a8e99ad069 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -380,6 +380,75 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd(struct mqd_manager *mm, =
void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst, void *ctl_stack_dst)<o:p></o:=
p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_com=
pute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_mqd(=
mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(mqd_dst=
, m, sizeof(struct v12_compute_mqd));<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd(struct mqd_manager *mm, voi=
d **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct queue_properties *qp, const void *mqd_src,<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const void *ctl_stack_src, const u32 ctl_stack_size)<o:p></o:p=
></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_com=
pute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D (struct =
v12_compute_mqd *) mqd_mem_obj-&gt;cpu_ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D mqd_m=
em_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(m, mqd_=
src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mqd =3D m;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gart_addr)=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_p=
q_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DO=
ORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot=
;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&gt;cp_hqd_pq_doorbell_control)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_acti=
ve =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma(struct mqd_manager =
*mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst,=
 void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_sdm=
a_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma=
_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(mqd_dst=
, m, sizeof(struct v12_sdma_mqd));<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma(struct mqd_manager *mm=
, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj,=
 uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *qp,<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *mqd_src,<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *ctl_stack_src,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 ctl_stack_size)<o:p></=
o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_sdm=
a_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D (struct =
v12_sdma_mqd *) mqd_mem_obj-&gt;cpu_ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D mqd_m=
em_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(m, mqd_=
src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rl=
cx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0=
_DOORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mqd =3D m;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gart_addr)=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;*gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_acti=
ve =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12(enum KFD_MQ=
D_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -407,6 +476,8 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v=
12_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wave_=
state;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_strid=
e;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =3D checkpoint_mqd=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs=
_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -453,6 +524,8 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_occup=
ied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v=
12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_strid=
e;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =3D checkpoint_mqd=
_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma;=
<o:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs=
_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 431a940f91f3..7ee98ef084ea 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -641,6 +641,75 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_v12_1(struct mqd_manager=
 *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mq=
d_dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_1_c=
ompute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_mqd(=
mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(mqd_dst=
, m, sizeof(struct v12_1_compute_mqd));<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_v12_1(struct mqd_manager *m=
m, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_me=
m_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *q=
p, const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const void *ctl_stack_src,=
 const u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_1_c=
ompute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D (struct =
v12_1_compute_mqd *) mqd_mem_obj-&gt;cpu_ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D mqd_m=
em_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(m, mqd_=
src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mqd =3D m;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gart_addr)=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_p=
q_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DO=
ORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot=
;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&gt;cp_hqd_pq_doorbell_control)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_acti=
ve =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma_v12_1(struct mqd_ma=
nager *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *mqd_dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_sdm=
a_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D get_sdma=
_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(mqd_dst=
, m, sizeof(struct v12_sdma_mqd));<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma_v12_1(struct mqd_manag=
er *mm, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct queue_properties *qp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const void *ctl_stack_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v12_sdm=
a_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D (struct =
v12_sdma_mqd *) mqd_mem_obj-&gt;cpu_ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D mqd_m=
em_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(m, mqd_=
src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rl=
cx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0=
_DOORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mqd =3D m;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gart_addr)=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_acti=
ve =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12_1(enum KFD_=
MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -668,6 +737,8 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v=
12_1_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wave_=
state_v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_strid=
e;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =3D checkpoint_mqd=
_v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_v12_1=
;<o:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs=
_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -714,6 +785,8 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_occup=
ied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v=
12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mqd-&gt;mqd_stride =3D kfd_mqd_strid=
e;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =3D checkpoint_mqd=
_sdma_v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma_=
v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs=
_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB8600E8B1821FA7D76923FC259FD42SA1PR12MB8600namp_--
