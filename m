Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D0C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C841010E076;
	Tue, 28 Jul 2026 18:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4VhPh/dj";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE8A10E076
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrNFBxl37jo2ekRWQNxRYZmsoFPOBviL/aWOWhRful7cUtDaYqe3pbSKUXOt/04kCcrBuz9qTW9dwtV4uJC8H92xx1loXkNQaQHxt976yEGEeAmAUUL3frObH+5MWxhLHNUu/k4eIL4Q73HOi8S3zc1yxhzat0TgNZADSnxbAsLRmwKIMTXdNtujsJ3AAeMY+DwuaYN3yH2Lkzu84eVcTNBW4oi4jILVjnLqpP+a8HHoqFZYSREOqoA17u49ACTrlCIn/CT0dvCQ6vc4EoyfpJTmYOjX1ueMHVOj4XhTi4mjbX4WI++J/vKhu/B+CIpaBoUGd7uOcbAfojCY7dIWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr857PqQPjRA6mWxrxnlWC7jNZKcymJ6G0VO0/hfVsY=;
 b=c/wKtbCisG31YUdh5S8AU5aaptYVQQI9X/aJgebE7EBywuGAzzfdHb5yugAeWMV2Ky3cP/BOsBXbqLif0cLkKLn/OgYiOGEzL1RCwcEgSbJNpDm7mQL6e2mOcXjZVA3MWtzfvp0YafmVMgLSR0xd7ZsE7vv69Y3142gJuu8qojpntnBUHJkd3J+P3BqO05NUhfcYbA9cOrxQ6xZLUC3PT0lNKRxbKhbXfWpWZkJjer89sI4hMJjEDPTjHvcvjh2cyGaZK4sNkGMra5Yq5VEO3dc99w7eOD4RpmK/IPIQo4UZlqtjtnY747dyIRkVbCrWBwQ5RB+etA/dIA2X75iRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr857PqQPjRA6mWxrxnlWC7jNZKcymJ6G0VO0/hfVsY=;
 b=4VhPh/dja88jmWsH0NmpPJz6Vs0XJTi9bYt0ZJnHlyUEUmwok+vf9cwO4OBF2IirIOzg5r5W5ORR366F5j38Vfp6wSeZqirhi7U/vo3jLdKu9/+f7i4Ip8eyJOEHHl8azJx4rk1NfRJ8eU0pHVQBPU8vc6KzG6skwbIGL9xcVmM=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 CH1PPFDAD84AB72.namprd12.prod.outlook.com (2603:10b6:61f:fc00::627)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 18:35:10 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 18:35:10 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Topic: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Index: AQHdHpAkozNht/uLYEmSbSsjEOdeLLaDQZ+G
Date: Tue, 28 Jul 2026 18:35:10 +0000
Message-ID: <DM6PR12MB3611D6DB60E8B19897243C3D94CB2@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260728125336.213531-1-Prike.Liang@amd.com>
 <20260728125336.213531-2-Prike.Liang@amd.com>
In-Reply-To: <20260728125336.213531-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T18:35:09.284Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|CH1PPFDAD84AB72:EE_
x-ms-office365-filtering-correlation-id: 21613f50-1549-4280-1d98-08deecd6f489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|8096899003|22082099003|18002099003;
x-microsoft-antispam-message-info: x2m91sdJ/5Gw6hZ+eW7u10KLAICp6CWf56EVYDywx5EMiqL3Fx92OfdDwsxrYPhBdwOnVGxpj+CRqIPoRPmo4GoMXeV2uEdVXSrofxZfIfnmReMnYepwVB7MOa+0ou93ILCTOcpK7UMicoqD2tRdjRtRbqekcYbEPDOMnfKL/0jvskO8OSyR2QMKz0HnjyMji+EXhx2d+Ey9aWWa1qQ5H3hloTR3Xullfv6DXU58k7LRihPR+1PXdgGwgjJe0oYBzuQBGyIrg6n2yHqfxt7Zj2veAS4AkSrN0RxJh9aqi0Llbz+v5IOi6ZIV7m2R8XTUre0ojuSd+RLF+M13+gvxYipMjUYI/n9/XbBbvw8TTjEekDNiWqUc8iOLlMr+KCMP7GsKucuhr6cpCTKsGHO7NiXrm73BiRmZkABO0tNYmCzRC9nF8AOniKj/p5SfEcjzz4ebQxY+Jzeh4OGGCg035mM6F8E2/GfvYBQmjcym/1n1Knl2lG1VIiTsehF7KCYcehLtastMsrBUansAGHjdC7M10v4oIfO9ulhAsUyrkT7bk9iLqHXwmfaSAJsFlYsbqy0CdrcCXg4e7RHFCIZLYZt9IqCkCaaC6fjPjdWVIe61ZbyD/j6DxPz3S7dZcia23SDow+cmuXmzq2fOaVYC6IzXgFxQdzXQpugjGtmkIZnD4fHxoiShd+XKaKK/5H+uR4lBHl0QTVF819/ExYRdfPN2+zgI0uS4Cb87byJt6QA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M5DeU3VqsW8Q0JT5GJYITUpW3lkRUSp2VSO6YWmaASBiTkxkfRVvODbpoS?=
 =?iso-8859-1?Q?rC51LIDesUbh0yebkMLcx90/dbw6PfvsskttIbEKp/m+YejJhbST78RPH9?=
 =?iso-8859-1?Q?JFQp7wyPoZ0HNUc9GgP+vOFKQJa5Nj/otvOZsPKifSpmjsaIzXgAc6bsOS?=
 =?iso-8859-1?Q?scaFDURsxH2hZICSy/uzLnQxzZsSMWCMuZm3W88uRgoGhA9GYHBZP6cyD9?=
 =?iso-8859-1?Q?LhZLuLfqnBCb7bzAbRs2uBL59eM0uHI7wkJzR+EbuWNeA8mD1JAnVZQI5r?=
 =?iso-8859-1?Q?UvdQCpcDu1Z8Mbnq24aLTayS9M11syI6vkaes113bc5MrDMV161+YCcgD7?=
 =?iso-8859-1?Q?bK2CRwa18Fx10g/fIwExt+eHIrNNpNIzzcA8BPBrFUDaCbaCLRyfhln12j?=
 =?iso-8859-1?Q?k9ZYqTM7U8seIiT1idkcx6YP2AWH00T8J0mOWmpx99g9MMzY5nkvViHnzG?=
 =?iso-8859-1?Q?a5qP09+4Wr+Htm4GahJsX3XwUAr022eoK24mMXvFBj6F9dCwxtdwYVJYPD?=
 =?iso-8859-1?Q?JJXLxFDnDAjCgkGrzpe/onaqYshU+oNUFskrwC5DKxSuh1aEhRLbe3f+rN?=
 =?iso-8859-1?Q?6w5ee7l5La8D4v0ttnbbg7N3xhn4Xk4YW2SwGaBxztHYeoy0YWbVWvmJsi?=
 =?iso-8859-1?Q?KUa6X49LM9wt+WaiqFkFBkRv2IljS1993txOaTjHtB5nMzPBErHmfHe3OS?=
 =?iso-8859-1?Q?XqBJX2vuwuNkEq4u1xCXGFQBv0CUZK64fYwuYdszwcxskLqe72IemERDZ7?=
 =?iso-8859-1?Q?k6ye/Zjp1k49dBlGgkzHDxBS0sM0Fyp/qQqiqyQbXkXNx4/Co3LZ4LTAyu?=
 =?iso-8859-1?Q?l3kHVT1ijLZ7sInSO9VbiOgcPKILHcsdhpnisJ1gsX2kwY/9Js4KOOMyts?=
 =?iso-8859-1?Q?eAXYQ1j1/ZscwSDLZRFLct7o51bpviqHk9fv08T2OtFQRvrlUrO0mOVPG+?=
 =?iso-8859-1?Q?vRn/KEaa1w4tjGYEQ8CT7W7Sl6cgxbOozFomwvweCdDi8/ZJ1XKnVRsSKs?=
 =?iso-8859-1?Q?1tMxa+yOjKpRqE2e16QeQD+/0jEXPZs34UpZ+unUBMLfUB1Db5Aqp75Hv9?=
 =?iso-8859-1?Q?wSW7lcVMiBqfq4msdcoB1gPswxa5tDS6mmq4eRmQAN/dpxyl6v/91sqhVy?=
 =?iso-8859-1?Q?ti4AtUoYSvsjH0te1NHmC8n/mvyq6vj17l5faUgPD98sq5kire4YK77Rd2?=
 =?iso-8859-1?Q?GqCfXYPKhlsmJFHzZg8QIlPakP7oBmXdQo477oR6mbD+QrE5cRUATfK0aq?=
 =?iso-8859-1?Q?EKERMxN6swtgSrmxINyFVK0kwTCGvijsrtdl+dRI+I2vGiyTo1ypSzVYis?=
 =?iso-8859-1?Q?KmdQnajCoeT6ujPpGIf7yUM6+lx4GdfLcztAlajf35MR/AwzULRfk3mncn?=
 =?iso-8859-1?Q?TUefd3F1ujQr6KM1baIBvYp3v5uIrC3TblJZUcuAwwh6CfggCBqPh7uqgK?=
 =?iso-8859-1?Q?E5Zc8/vsN6xzgwo8/LgRGa1ga7H07SNBA5ZaH5ZL4//Lc3p7wfNWOhscIb?=
 =?iso-8859-1?Q?/MRD+oCVPrhY4nGF2SrjaSIdyBDD1QQVb51XDRiHCwaplIm57BEjmW+g5C?=
 =?iso-8859-1?Q?DyW7ihmc7onJlPAb75AK8EEBKR5EUI+YrYIOwdhUByPRzFIK3auJAsSQW/?=
 =?iso-8859-1?Q?/OMq77wFbQH4V9UmYqfWli5e6bIzfOd7zR111ksNFTWxSaQeFNKvd/owe4?=
 =?iso-8859-1?Q?eDITFN1UNjxw8+XJAReDizW5CGUxXkYUz6fWM+LWPNIWf+cLCNlVpQnRcQ?=
 =?iso-8859-1?Q?XJD66G5yPIS3EeAZmyIecnH8BXNq1e7mRjzSCxjLE7jhSS?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3611D6DB60E8B19897243C3D94CB2DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21613f50-1549-4280-1d98-08deecd6f489
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 18:35:10.2663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwQ06Vc0QGoFuZ/4X8rkOm58uBrW8mX1ZFZeHrTnT5MznwyEX4r06UQGgw8kco2XLGZFcHqGHT6+rD/p5bqRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDAD84AB72
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

--_000_DM6PR12MB3611D6DB60E8B19897243C3D94CB2DM6PR12MB3611namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, July 28, 2026 8:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
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


--_000_DM6PR12MB3611D6DB60E8B19897243C3D94CB2DM6PR12MB3611namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 28, 2026 8:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Liang, Prike &lt;Prike=
.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: enable rs64mem for kfd queue</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Enabled RS64mem for KFD queues by integrati=
ng<br>
process and gang context index allocation.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
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
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Looks like you all=
ocate one unique proc_ctx_array_index for each queue, but shouldn't all que=
ues of the same process share one index?</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
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
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DM6PR12MB3611D6DB60E8B19897243C3D94CB2DM6PR12MB3611namp_--
