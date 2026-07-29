Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524CC54F52
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 02:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8061610E36F;
	Wed, 29 Jul 2026 02:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovypUbZH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B960E10E36F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 02:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba2Cs+uxqJtBGXFO4WnmMEbaZNdfgf4/Ms7waPHUtrlPUob/MIY7T0JM2d//yIltJ+omELuLHzNHP7zFrjO/y31AlqRo12U5VxNuh+/KQwmVdFkcqiBb8RkggHRpuQQ7CK6yxl5+HiZaUicwcO+oK8HJDm5jmBDiwaWfkk3tvylpWmzSepdjNJml7WNsHH76tTakw8mSWsSUzlYp0qt2iiOSsrQ6ije+8M1QeRJ+bXOgMyAFJbzqaMzXR+XtSsky3w4KiDTDwCP3KigI4LxxfXsuyJiyR2H2pfySILT1rCNxdk73/OaKEerSRb9pgIc0B1hU8H0hroezXtXRGLlyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFUUQIK6N+Yoshsal8e5CeOGaGH7uAqvHhGqEd7Vf30=;
 b=JjnYX8RXLyZE2zdoLpI9wwp64VSZJuQl1Voi1yuurqk23lTeWdpojB3JRxbRL6/ExjrbP6x5OsKgJgc/Am5i6qSqleNldrhXLAUMqzZTPphVdtNMKRuF3d71J2YasCMragUoM2dRwh1CV2Cj4lbwNDTO6fddW13u7tsJ9dp90Zve9xd5HL+bDrOMHe4xgQKLnPaOi363vsuYK2EULjZoBH1ELEbKlfWKbvGpwqkBX0bflrsiO0kN4njvy8xeWAHLIgwnMjHYxttrFuvfoskM4vtmB254BaszynO3i6YQrPtObHZPiRVBeVhn4kMdgQzqEArMtPy+K6CA2gW4wTNuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFUUQIK6N+Yoshsal8e5CeOGaGH7uAqvHhGqEd7Vf30=;
 b=ovypUbZHHHdpTk8xZrOJo997C/mjnM8/TZA9sf+xqSuKSPAFID0WktGoIrrSM3OzTQB9BxucPCn3ty5De0hN9EICv+6Ak7xV9nuLFTvOUMP8QtRGP8RVTVGHev6wCyS1iTJLk50xVmxurGGABycPKf/60foy9LKdFuHmd5l5fvU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 02:34:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 02:34:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Chen, Michael" <Michael.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Topic: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Index: AQHdHpAkm1vAjyhV90GNpD0zwU7817aDQoMAgACEEJA=
Date: Wed, 29 Jul 2026 02:34:04 +0000
Message-ID: <DS7PR12MB6005DEB6B9C095E51FAFEF19FBCA2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260728125336.213531-1-Prike.Liang@amd.com>
 <20260728125336.213531-2-Prike.Liang@amd.com>
 <DM6PR12MB3611D6DB60E8B19897243C3D94CB2@DM6PR12MB3611.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3611D6DB60E8B19897243C3D94CB2@DM6PR12MB3611.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T18:35:09.2840000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB7677:EE_
x-ms-office365-filtering-correlation-id: 0a28ec5b-4464-4de4-7435-08deed19db8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|8096899003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: HLVn0z2fqXApqdULowVGLZ1iOgZtwPq0QsiHUn6gFIoXMRqyZU4+vbiSTXSz9e9Nz37AzbQuQnLyL+J+4hrHvYhLUPeTJyjbgApCYIqscSDRrX6dM+ApNpUeb9TWwDbyqhMSvIOFvcCqbF3v4Ke0JCMsC0vL0fNOVPn2LsV+XMartr58LbWSPf8gCwVfBPGw4noANSr6rrzmsi5lTmqOvDXswFZKXBUdtT0sL0TvvHw5QH9JcP4azwyyZvjmmTWgnQt5Wd7mHLBe7yXfcTbqPgJfRmfmvu9cM6pXB/zUwSK5O4nbZ0SFdGY3KGsIM9MdzFTJ1fjf1y+Hefxq1glxoxiJFrFUtVHj0e4iwpCmt/VdAkzdrtGdgnxt5/+Q7PB1yR/TyA93FlNG77vK6IGpRbtjxwclSALWxkirbdnLIbXorK3W/4BgT7YC5yoKm9oNnO6YzytGTp6xr2qQQ4xjhQUHnU70JvcWuEFOtrFOseAcwbovjwrUl8Xp7OIHqkS1rMje9Vb9cwAKvJ23raoQX2PPzi1qWvUkEEcvpNWMf8u8dy+Cd/ZdiqFikrBI5HnubCkM48697TQc2baO59ZxfvIiIV4SzGykp1GJaWGc8NaPq5K7VWOHDlhdJWjJrx0WvJrQe/wmBxhBNUoeJbSB8H+y+edRURsOYRAnm0JNyOA79Z/JxdhFBydlKV2zmrTdFtLyjM6D0LXG6ojlFhVVce6AxrkadhKIha070bkBBf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(8096899003)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NVPCCsBpeVL3L59pKx5n+bAZZRpFEo905vO1srryZD9H9ErKI2AbNohmb8XN?=
 =?us-ascii?Q?J1GpZUj3Fu5mHVU112fyAL/sx57tfWz9JcI1ZcepYKMdnV/VnQaAOBbIwtyA?=
 =?us-ascii?Q?O+d7ryjwTKUNbBuKTYUmBPrhvZYApnnmhJbvqbDD6LMxFaEiBYAsjHzYUT8C?=
 =?us-ascii?Q?ZCzPpozeZLHYVfcW53VK0aoiOyvjgrUoQ4jBbfDakp9LY9WhtZfX6p8Yflaz?=
 =?us-ascii?Q?BQie7lzfs6CHF88QE1/yQoPaqmXSk8nMQP2C05WixrJ9s1eytya7owD3btE6?=
 =?us-ascii?Q?z2ZZjYEaLK0ixcfyrx/XOplLDPb2DpujBigFmwX9aL6hbE5MwjyC2rHrA27d?=
 =?us-ascii?Q?JiI44BK9oK6EDLP23kr/SowbA0XMIoNMcpecNhzMNfmS/u8nVYCvVP90whDT?=
 =?us-ascii?Q?xTScjCTmc0x3GpxoRRnfEEQBg8uefzkPbnC3vkkImODBGbnUM1a0Iga+hy2k?=
 =?us-ascii?Q?x9ZxhJ0DUUYJvX3lJzdIruk3AiiGY+0O/YapwrwFAc33H/RPklw5Jhib3xGd?=
 =?us-ascii?Q?oiTi2nUqHZBXVWoXsro4IktfjboWD/+HHCkDyZn4RvW8gflCN/W4L22SPMD/?=
 =?us-ascii?Q?Jd6/YCFi6pTZ3ynahzrzENXyi+aJ7y+NQUYRjL6ZZGD4gA65GHICGANav1FC?=
 =?us-ascii?Q?+nIcexVqm1tbIBV/7JlKAYnAJY9ZfM1WIJZRldi6zK6jJPLciatO1WfOfW1m?=
 =?us-ascii?Q?zgEn4ME+6A0y2awJLIhw7MZz5wD8HU/hIkqukWfcbUhY2n7lW7B1XAfDOGzI?=
 =?us-ascii?Q?5Cj7GzFRspcUlTVFBX300x5twN0oiy+iKD7rTF0gMV3euTvAkCU1hoxlIFT/?=
 =?us-ascii?Q?vFEaurpn4yICY+Fwe0YBdwIcksBgmzZc/swWXUl4AyjXTzmDB6lRtne7n7p3?=
 =?us-ascii?Q?D7bEtcDFBTToPUPMt5Ec6K4pF8A6DLvSmH68CCeq/HWFucp1pCE5HfAuxM7j?=
 =?us-ascii?Q?cjXAaM7G6aWoi0YQxN+QOoY5W7QcM06klAWmFOI6QOR2b52kLhlLAyDZoOHE?=
 =?us-ascii?Q?2TZEGYpxL/qLc67lNdgczseayMGN6xRqiKvPMN/99l60D8/sK0rj2LNleaja?=
 =?us-ascii?Q?GT2nVwx3sdN4dTTT7ef7pA38F9aJP0gdOG9WoecZOPM4jxBhsDWKPISwCdnj?=
 =?us-ascii?Q?Cq/qHkGTLA+LrrpEZEldC6gIFgp3M27dNf13l3crcFu/ClZO1fQtWdO24bn3?=
 =?us-ascii?Q?hJQReyPDQjAQsCUe2zF9oUjkQ3YxLOfDL60GirsJpt6KZsTG01bqYiiGSNWt?=
 =?us-ascii?Q?dyRoxr0pF7Q6V/xN8lK9Fn2DmRyGDoXLa4O8pIXL7+2djiqbZYgaZqyJVDVG?=
 =?us-ascii?Q?vi9xI2Ctk5Dt/HHk270jrHwuBXmJH7+Sj+uTgkP8ZgUlt3QcP9FEK669XgHp?=
 =?us-ascii?Q?rsxSR2NwAJiz3OrB6RQ1dRqMESULYWAtRebr/75h1Lc1XwAz4J52/OlCOcEp?=
 =?us-ascii?Q?0qzuz6KAj0CD9jpVB+/l1DrGtZi9e4XbgZ0MRgx3UmXlclnagLAkEKrhST/e?=
 =?us-ascii?Q?6DB8aJGcTabpI+X/j5Cb3z4GMvZnRJGOSSvQ8es0Ori9NVM4wkEK/Q6z2i+q?=
 =?us-ascii?Q?7dlgH2BfII0AgRJJ8NqBRLPtSXYZPVPi5K34eWmtpy7GugXo9sVJUDzbUEkz?=
 =?us-ascii?Q?KL9poAhyqSvQ+JDwC7wS79kPzn0wzAU3+7FbL1IpKjAQzV2c9/SOs2A3KKbP?=
 =?us-ascii?Q?tAs6/ZwyqSNVepGIIes4LxH6iz73xHQgD2mha1NUYUl+U606?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6005DEB6B9C095E51FAFEF19FBCA2DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a28ec5b-4464-4de4-7435-08deed19db8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 02:34:04.5902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9aXF5Pc0kEKMJQvpdN1Rq6zhPCXu2sYRQAXmbkWeLgrlWBaMOa3ugAbhL0tH14+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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

--_000_DS7PR12MB6005DEB6B9C095E51FAFEF19FBCA2DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General



Regards,
      Prike

From: Chen, Michael <Michael.Chen@amd.com>
Sent: Wednesday, July 29, 2026 2:35 AM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue

AMD General



________________________________
From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Sent: Tuesday, July 28, 2026 8:53 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koe=
nig@amd.com>>; Chen, Michael <Michael.Chen@amd.com<mailto:Michael.Chen@amd.=
com>>; Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; Lian=
g, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Subject: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>=
>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ce0ca3445ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -210,8 +210,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
         struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->a=
dev;
         struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
         struct mes_add_queue_input queue_input;
+       struct amdgpu_mes *mes =3D &adev->mes;
         int r, queue_type;
         uint64_t wptr_addr_off;
+       uint32_t index;

         if (!dqm->sched_running || dqm->sched_halt)
                 return 0;
@@ -265,9 +267,18 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
         queue_input.vm_cntx_cntl =3D qpd->vm_cntx_cntl;
         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;

-       amdgpu_mes_lock(&adev->mes);
-       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-       amdgpu_mes_unlock(&adev->mes);
+       if (mes->use_rs64mem) {
+               amdgpu_mes_alloc_proc_ctx_index(mes, &index);
+               pdd->proc_ctx_array_index =3D index;
+               queue_input.process_context_array_index =3D index;
+               amdgpu_mes_alloc_gang_ctx_index(mes, &index);
+               pdd->gang_ctx_array_index =3D index;
+               queue_input.gang_context_array_index =3D index;
+       }

Looks like you allocate one unique proc_ctx_array_index for each queue, but=
 shouldn't all queues of the same process share one index?

Thanks for pointing it out, it's more reasonable and efficient to bind the =
process/gang index to per process/gang, and I will update it in the next ve=
rsion.

+
+       amdgpu_mes_lock(mes);
+       r =3D adev->mes.funcs->add_hw_queue(mes, &queue_input);
+       amdgpu_mes_unlock(mes);
         up_read(&adev->reset_domain->sem);
         if (r) {
                 dev_err(adev->dev, "failed to add hardware queue to MES, d=
oorbell=3D0x%x\n",
@@ -287,6 +298,8 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st
         struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->a=
dev;
         int r;
         struct mes_remove_queue_input queue_input;
+       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
+       struct amdgpu_mes *mes =3D &adev->mes;

         /* queue was already removed during reset */
         if (q->properties.is_reset)
@@ -303,10 +316,16 @@ static int remove_queue_mes_on_reset_option(struct de=
vice_queue_manager *dqm, st
         queue_input.queue_type =3D convert_to_amdgpu_ring_type(q->properti=
es.type);
         queue_input.remove_queue_after_reset =3D flush_mes_queue;
         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
+       queue_input.gang_context_array_index =3D pdd->gang_ctx_array_index;

         amdgpu_mes_lock(&adev->mes);
         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
         amdgpu_mes_unlock(&adev->mes);
+       if (mes->use_rs64mem) {
+               amdgpu_mes_free_proc_ctx_index(mes, pdd->proc_ctx_array_ind=
ex);
+               amdgpu_mes_free_gang_ctx_index(mes, pdd->gang_ctx_array_ind=
ex);
+       }
+
         up_read(&adev->reset_domain->sem);

         /* If is_for_reset set, it is a mes internal cleanup */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 88191a4c1657..c1bbae9e6e82 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -871,6 +871,9 @@ struct kfd_process_device {
         uint64_t proc_ctx_gpu_addr;
         void *proc_ctx_cpu_ptr;

+       uint32_t        proc_ctx_array_index;
+       uint32_t        gang_ctx_array_index;
+
         /* Tracks queue reset status */
         bool has_reset_queue;

--
2.34.1

--_000_DS7PR12MB6005DEB6B9C095E51FAFEF19FBCA2DS7PR12MB6005namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prike<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Chen, Michael &lt;Michael.Chen=
@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, July 29, 2026 2:35 AM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.=
com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue<o:=
p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liang,=
 Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a>&g=
t;<br>
<b>Sent:</b> Tuesday, July 28, 2026 8:53 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mai=
lto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;; Chen, Micha=
el &lt;<a href=3D"mailto:Michael.Chen@amd.com">Michael.Chen@amd.com</a>&gt;=
;
 Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.co=
m</a>&gt;; Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue<o:p></=
o:p></span></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Enabled RS64mem for=
 KFD queues by integrating<br>
process and gang context index allocation.<br>
<br>
Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike=
.Liang@amd.com</a>&gt;<br>
---<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++++++++++++--=
-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;2 files changed, 25 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 51ee9c39104b..ce0ca3445ccd 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -210,8 +210,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device =
*pdd =3D qpd_to_pdd(qpd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mes_add_queue_input=
 queue_input;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mes *mes =3D &amp;adev-=
&gt;mes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, queue_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t wptr_addr_off;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running=
 || dqm-&gt;sched_halt)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -265,9 +267,18 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.vm_cntx_cntl =
=3D qpd-&gt;vm_cntx_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.xcc_id =3D ffs=
(dqm-&gt;dev-&gt;xcc_mask) - 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-&gt;mes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&gt;add_hw_q=
ueue(&amp;adev-&gt;mes, &amp;queue_input);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(&amp;adev-&gt;mes);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_proc_ctx_index(mes, &amp;index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd-&gt;proc_ctx_array_index =3D index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.process_context_array_index =3D index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(mes, &amp;index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd-&gt;gang_ctx_array_index =3D index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.gang_context_array_index =3D index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Looks like you allo=
cate one unique proc_ctx_array_index for each queue, but shouldn't all queu=
es of the same process share one index?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><i><span style=3D"=
font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p=
></span></i></b></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><i><span style=3D"=
font-size:11.0pt">Thanks for pointing it out, it&#8217;s more reasonable an=
d efficient to bind the process/gang index to per process/gang, and I will =
update it in the next version.</span></i></b><span style=3D"font-size:11.0p=
t"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(mes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&gt;add_hw_q=
ueue(mes, &amp;queue_input);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;rese=
t_domain-&gt;sem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;failed to add hardware qu=
eue to MES, doorbell=3D0x%x\n&quot;,<br>
@@ -287,6 +298,8 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mes_remove_queue_in=
put queue_input;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd =3D qp=
d_to_pdd(qpd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mes *mes =3D &amp;adev-=
&gt;mes;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* queue was already remov=
ed during reset */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_re=
set)<br>
@@ -303,10 +316,16 @@ static int remove_queue_mes_on_reset_option(struct de=
vice_queue_manager *dqm, st<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_type =3D=
 convert_to_amdgpu_ring_type(q-&gt;properties.type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.remove_queue_a=
fter_reset =3D flush_mes_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.xcc_id =3D ffs=
(dqm-&gt;dev-&gt;xcc_mask) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =
=3D pdd-&gt;gang_ctx_array_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(&amp;ade=
v-&gt;mes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_proc_ctx_index(mes, pdd-&gt;proc_ctx_array_index=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(mes, pdd-&gt;gang_ctx_array_index=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;rese=
t_domain-&gt;sem);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If is_for_reset set, it=
 is a mes internal cleanup */<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 88191a4c1657..c1bbae9e6e82 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -871,6 +871,9 @@ struct kfd_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t proc_ctx_gpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *proc_ctx_cpu_ptr;<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; proc_ctx_array_index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; gang_ctx_array_index;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tracks queue reset stat=
us */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;<br>
&nbsp;<br>
--<br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6005DEB6B9C095E51FAFEF19FBCA2DS7PR12MB6005namp_--
