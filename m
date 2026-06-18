Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D8DCD98F6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C2A10EBEE;
	Thu, 18 Jun 2026 04:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vbrC2xRj";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C42310EBD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5qch/ccqahMHiq00n+2zyUgWatSJm305pkE805b+o7ORjUzNBJzVI4T0AvRdDEs5Ml3V5GoK+nmy0rLKqyjDWDYYDUrSM9oQJD9UIoVRS6pWT4JIDuTOFvsBEt2fDb12WvarWvPRxgeZ4Ei5qjsGIpkuDTG00XxuAZ8LR+/9aCJ+Vb99f4Dkz8gTdGpoiltB77ChXdNrYMhJVmlJJgDHXB/mj9fAJz3be8T353EDBoZJeIwggwlXCbFXFrbgGIGYng/KHN6kOViOE6Ee128fgQPwKxZVpj2hiH1hglDahVxeMffD0agDFTuJvTobw+uKkHwnh1Kmlxm774c3q10Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJtxHzjYdzokft0wKdjQji3vQ3173Du1kLO7OdJBDkE=;
 b=fz3hYfATxZAqu4pKiHB8zUwqx1pySat6ZJazdpEPOXpm39mjZum/nlhTimANGNE7iOPpZzE8vxOgdvw6fB+pV+HMkf84WJdB3dY+P6fwHvq7R+UgMQR0gGxNQR2ySYSEJBHgwL7FvNVEQ8OqdAUhn7o2PGvHFjG1xLSMrazzR/zWCPlIG9LRF7VOQC0CL3EsUwDjc7Bm/2wQk+X+bFuiLi183LVExE4RLbI8OccqsWLoB1BzoDbyFIyP9ToTBIIS703J6mAZSOQl4mT7eZHsKG4N45O63gnGxe+jJyIloafB1GEQDV2oUt3FCteYWXakv9FvjfQs81EHztYmFOUvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJtxHzjYdzokft0wKdjQji3vQ3173Du1kLO7OdJBDkE=;
 b=vbrC2xRjIgDnfGSEBvElcQtLFMUgx86axVt0ETgtevJKSjOex9ERTGKDtgJYmVyXd0sV6fxbucKwJD1eyfFKo8/40GTZZPNtym7uUqZDgkkTAJ6/cGPZFrD2u/8psyRpkeE6C4CvtJ1UJz4BLTmCNNZUol8jyI6WHRcnApK6HTc=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 04:24:28 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%5]) with mapi id 15.21.0113.013; Thu, 18 Jun 2026
 04:24:28 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isolate
 scheduler state
Thread-Topic: [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isolate
 scheduler state
Thread-Index: AQHc/lgUpGyb4NXlr0GvrJkzQKGSyLZDt1vR
Date: Thu, 18 Jun 2026 04:24:27 +0000
Message-ID: <CY5PR12MB63451701C0B12F8AEF15CF08FAE32@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260617125121.1838486-1-xiang.liu@amd.com>
 <20260617125121.1838486-4-xiang.liu@amd.com>
In-Reply-To: <20260617125121.1838486-4-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T04:24:27.237Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|MW4PR12MB7440:EE_
x-ms-office365-filtering-correlation-id: f6636cec-2f36-4adb-b8ca-08deccf17c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: W0E/RNLZB6D/9pcu6OAx+P833m+Mr07Z1lWSw5Vz4mwYWi0jG21MKa2lkt99QQWRe/ZV7yBfZSOmKnlPf4VEj+vW8sHWOxnLVI9v1WwsluT4QbAyfAYP2EExTF2E5BtVU6qeO+WWsi5IcT/brtJ/2oXBQpE5MLfNy1Q9+dsa2mg9ACXet5DMScCoRxpY3xShz+NCuXZM9LNo029d3iU3J7gqudPmEnclyjABF5JQqcQn1/O73vcDl1DdHHNfImxXhYKyCHH74dWLoRionarKhyXp2CUzzmq05Kr7p+4uX0EwcpTPbXg/qFViBWToOfwAd+8U5UBmXks0CXNykGOpHonURY/nFrY1/g1RVmlWLN+8jV8Gqp3Nw1APKtQ3wJ3rkn7YbH82XUXcBzN9PzJlXBkB0yjeGmGDmof6FmKgODe4ovYz+OiDIhw3ttHqrZ59L9KqQARJQr6Ud5OVHFkstpwQ8jdnxMusvluWTTFlCRGeGbmc8gBwQnxg/tQT5N5vQjeGSWeIqsOv3Qe09BNSzJV9Qdn2YEzsXK+NFKoXijGOK6ndwjbsDINLanDEHoB4s8MxNU52Eg6xJKVYwuA0DWI5mh2KQVyW7D9oT3NdhKaw4R/iaLvcC7jBpSFqQKjCA6ICmaH5NsKpCaePkXGw2GyJVF3HZL5/RuoK1DuTr9ldGr43q9EqKxztOm14HHtuLfSempAp9xFWuOaLDejnuNaL4sU/Cz7aj5zsO+SNOJy8sBJpeS64OA5JnY+cWxb+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jL94zcXD1qkY1gs/XLAAEsGOyhsNrrznMucU5BRrMDh91hJ3bn6A7K6YpeCe?=
 =?us-ascii?Q?WyWILR6z6ePSxoqDkWMXaQugDjyRY+uTrYRSNtfnT4AE3Qtt18pDV0yYDPm5?=
 =?us-ascii?Q?4iZ0uS+0R+Ucz0FNpJMOrPSvTpVCQwjds23RbiquO09qgujYJoeM9ijYdaXM?=
 =?us-ascii?Q?BmxIFaQXLKSxNZHFmpz1UFObwysejvRcHgyNbPZzcoNgxFmmRcMpqhprVd78?=
 =?us-ascii?Q?hrdjfOv6Wh0xptW9IztY4ulKa3/Jn+cD+G29ZVjoas7Y896O7FzwoRfHGTng?=
 =?us-ascii?Q?ZWpsdkfiFmCQeznNwvjXGHKio5SUgFbhL6c3YtkjvD9XZCciZGdwq0UrG10f?=
 =?us-ascii?Q?93r7yw4FwKxieBp6VwFLrvVOkYGtEbDXxrJOHouHbO/LGyqjeP9CTTLsP8RJ?=
 =?us-ascii?Q?4CwKXC5IFI45+eFX0zXYnXhdhB5faPLk2DWLM77qvWpkwLOgAFZlpkGvQ63m?=
 =?us-ascii?Q?QjmxGzdD2/zKa85ca5TBqe9d/Tndjc1fWWK/WxQFEd/OIPjUDTV7xiocbZ2W?=
 =?us-ascii?Q?6VHCz2mNWIiDF7mHKf5YQ+7iB0B6Kh06BVYyNtuaJ+U/EsenYihrLxUFC3TV?=
 =?us-ascii?Q?A/kL7wZ4CJlK/HtjFWZMeZZoxwTWVYUI9vy8IuuWRslWuE7yLV5VCTc5FgwM?=
 =?us-ascii?Q?h4U2wiUa0KNVFr3hGTWmezWsMQ5IGtJRvA2vzXXzxGwYpBru8Td0p93nrbwU?=
 =?us-ascii?Q?dUl/uKy75cjSz93JEWOcFgntiiY+64cjOZ12zG4DUl9B5XOkrb5XhW8+px76?=
 =?us-ascii?Q?TrjRR2pNt6HB6BKIaTCiYT7DU7acOorsdTMF8+DvwCgkO4NfpcsZ6nFrND0L?=
 =?us-ascii?Q?ET/RQ7zplExQ9mg8u5vMvvXtlwOaRWeidR/dZpM7HxKxbUY1M6WtwzNJ7CTQ?=
 =?us-ascii?Q?Hb2IXHA6FwC3F0KWaFZ4J6dTH6oik+PPaPLNIwgYAW4IycRBKmadgTYvr/dn?=
 =?us-ascii?Q?KR+1JasnNKBTtjtKdyjy5bRBOnG5Y1ANjErY7p1hqLqYNbGuBPKDcd4qIs+x?=
 =?us-ascii?Q?8I2k9tHiMTQnrlxujwIAl4I3KmrkwWC6CSsgbn7wGXjYTHMXyBwqDR33FYj4?=
 =?us-ascii?Q?Ys6Fj3Z1y367CgtdzVzaerfsHGfvbpxQ8awumsZlAP1g5kdSMPf7cNjKW3xm?=
 =?us-ascii?Q?+eXsq8Swq7/g99wY5QboQuJOhWkyPtjdc6ANE0O2OautAzuG4Prp6xRWXx0r?=
 =?us-ascii?Q?t+hcMiI2qvpWRjRgBBigAUYG3kHMZf2xX8LRBrY4CbxW0Wbtb+HNTPGwoRWi?=
 =?us-ascii?Q?WOiFs6/z3yDl7kYqQlB4u3geLDQWq0SU0MOIbS7hHZB7bC37QzPE7Rtyy0oO?=
 =?us-ascii?Q?rs3FfCB9llYPaPNG8vGLGPa0LqvWqPZp58tkR6fVDzblh27j9cNR4aXwlH9M?=
 =?us-ascii?Q?MK08Po+6q7wOETdRYVgvPDPlJKprQRcyvSeeHPRiZMWnheMrGOeGeiC+Jjjj?=
 =?us-ascii?Q?O1Zmj8Rmp2cNmW4PrGPjdcsc6eQDw6kbar3rgbff8MIzL2OZux2KU5FatTlF?=
 =?us-ascii?Q?06ISBNVGKz6IGpqS8JpXDZ5rOe9Jkd/1prYga+SYqNY2SF8l7txqe6QcSqYs?=
 =?us-ascii?Q?Q3VP2rbZs2LHQ8f9fv0ftmL1B+y2BUbcQXa2C3Bl5+iFm/7ujnI2Kab34Xg8?=
 =?us-ascii?Q?pVF8Dn/hq31mLw7X8jqb2qFskhuYjIq/VEd5VzsGs9GMScXwim7emWvpSrU4?=
 =?us-ascii?Q?HPPH9EMKYc9NBfLHBvwDaJo1ByJU7CzT7+G/egCBUfYPDX2S?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63451701C0B12F8AEF15CF08FAE32CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6636cec-2f36-4adb-b8ca-08deccf17c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 04:24:27.9919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+EwVdeAU5OMaK20sCYB5+NgJfEaQ5PpF5XpxV+tV++At4LB2Jhu79D/EhupSaerzBHHyBzQhlH26EPMBTfuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

--_000_CY5PR12MB63451701C0B12F8AEF15CF08FAE32CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com>

Could you help take a look at this patch series, thanks.

Best Regards,

Liu, Xiang

________________________________
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, June 17, 2026 8:51 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isolate sche=
duler state

A single device-global CSA (adev->virt.csa_obj) was mapped into every
render client's GPUVM at the same fixed virtual address. The CSA is
GPU-writeable and holds CP preemption/resume (CE/DE) metadata that the
kernel and CP firmware consume to save and restore gfx queue state, so a
shared buffer lets one client overwrite the scheduler state relied upon
for another client's queue. Under SR-IOV this is a cross-tenant
scheduler-state integrity issue.

Allocate a private CSA per amdgpu_fpriv in amdgpu_driver_open_kms() and
map that into the process GPUVM instead of the global object, and free
it in amdgpu_driver_postclose_kms(). Publish its kernel mapping through
vm->csa_cpu_addr so the preemption resume path reads back this process's
own saved state. One client can no longer observe or corrupt another
client's CSA.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 59670aee0fd6f..50ac52f2e0565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -448,6 +448,8 @@ struct amdgpu_fpriv {
         struct amdgpu_vm        vm;
         struct amdgpu_bo_va     *prt_va;
         struct amdgpu_bo_va     *csa_va;
+       struct amdgpu_bo        *csa_obj;
+       void                    *csa_cpu_addr;
         struct amdgpu_bo_va     *seq64_va;
         struct mutex            bo_list_lock;
         struct idr              bo_list_handles;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 2e1284b7887c3..e0fc16bc7ef23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1529,10 +1529,28 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
         if (adev->gfx.mcbp) {
                 uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) & AMDGPU_GMC_=
HOLE_MASK;

-               r =3D amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.cs=
a_obj,
-                                               &fpriv->csa_va, csa_addr, A=
MDGPU_CSA_SIZE);
+               /* Allocate a per-process CSA. The CSA holds CP preemption/=
resume
+                * (CE/DE) metadata that the kernel and CP firmware rely on=
. A
+                * single device-global CSA mapped writable into every GPUV=
M would
+                * let one client corrupt another client's (or the kernel's=
) saved
+                * scheduler state, so give each process its own isolated c=
opy.
+                */
+               r =3D amdgpu_allocate_static_csa(adev, &fpriv->csa_obj,
+                                              AMDGPU_GEM_DOMAIN_VRAM |
+                                              AMDGPU_GEM_DOMAIN_GTT,
+                                              AMDGPU_CSA_SIZE,
+                                              &fpriv->csa_cpu_addr);
                 if (r)
                         goto error_vm;
+
+               r =3D amdgpu_map_static_csa(adev, &fpriv->vm, fpriv->csa_ob=
j,
+                                               &fpriv->csa_va, csa_addr, A=
MDGPU_CSA_SIZE);
+               if (r) {
+                       amdgpu_free_static_csa(&fpriv->csa_obj);
+                       fpriv->csa_cpu_addr =3D NULL;
+                       goto error_vm;
+               }
+               fpriv->vm.csa_cpu_addr =3D fpriv->csa_cpu_addr;
         }

         r =3D amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
@@ -1604,9 +1622,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,
         if (fpriv->csa_va) {
                 uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) & AMDGPU_GMC_=
HOLE_MASK;

-               WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->vir=
t.csa_obj,
+               WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, fpriv->cs=
a_obj,
                                                 fpriv->csa_va, csa_addr));
                 fpriv->csa_va =3D NULL;
+               fpriv->vm.csa_cpu_addr =3D NULL;
+               amdgpu_free_static_csa(&fpriv->csa_obj);
+               fpriv->csa_cpu_addr =3D NULL;
         }

         amdgpu_seq64_unmap(adev, fpriv);
--
2.34.1


--_000_CY5PR12MB63451701C0B12F8AEF15CF08FAE32CY5PR12MB6345namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Hi <a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM298959" class=3D"=
tWKOu mention ms-bgc-nlr ms-fcl-b">
@Koenig, Christian</a></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Could you help take a look at this patch series, thanks.</div>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin-top: 1em; margin-bottom: 1em;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: bl=
ack;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin-top: 1em; margin-bottom: 1em;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(36, 36, 36);">Liu, Xiang</span></p>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Xiang(Dean) &lt;=
Xiang.Liu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 17, 2026 8:51 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thoma=
s &lt;YiPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isola=
te scheduler state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A single device-global CSA (adev-&gt;virt.csa_obj)=
 was mapped into every<br>
render client's GPUVM at the same fixed virtual address. The CSA is<br>
GPU-writeable and holds CP preemption/resume (CE/DE) metadata that the<br>
kernel and CP firmware consume to save and restore gfx queue state, so a<br=
>
shared buffer lets one client overwrite the scheduler state relied upon<br>
for another client's queue. Under SR-IOV this is a cross-tenant<br>
scheduler-state integrity issue.<br>
<br>
Allocate a private CSA per amdgpu_fpriv in amdgpu_driver_open_kms() and<br>
map that into the process GPUVM instead of the global object, and free<br>
it in amdgpu_driver_postclose_kms(). Publish its kernel mapping through<br>
vm-&gt;csa_cpu_addr so the preemption resume path reads back this process's=
<br>
own saved state. One client can no longer observe or corrupt another<br>
client's CSA.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2=
 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++++--=
-<br>
&nbsp;2 files changed, 26 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 59670aee0fd6f..50ac52f2e0565 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -448,6 +448,8 @@ struct amdgpu_fpriv {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va&nbsp;&=
nbsp;&nbsp;&nbsp; *prt_va;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va&nbsp;&=
nbsp;&nbsp;&nbsp; *csa_va;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *csa_obj;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; *csa_cpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va&nbsp;&=
nbsp;&nbsp;&nbsp; *seq64_va;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_list_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idr&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_list_hand=
les;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 2e1284b7887c3..e0fc16bc7ef23 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1529,10 +1529,28 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.mcbp) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) &amp; AM=
DGPU_GMC_HOLE_MASK;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_map_static_csa(adev, &amp;fpriv-&gt;vm, adev-&gt;vi=
rt.csa_obj,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fpriv-&gt;csa_va,=
 csa_addr, AMDGPU_CSA_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Allocate a per-process CSA. The CSA holds CP preemption/resum=
e<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * (CE/DE) metadata that the kernel and CP firmware rely on=
. A<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * single device-global CSA mapped writable into every GPUV=
M would<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * let one client corrupt another client's (or the kernel's=
) saved<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * scheduler state, so give each process its own isolated c=
opy.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_allocate_static_csa(adev, &amp;fpriv-&gt;csa_obj,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_CSA_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fpriv-&gt;csa_cpu_addr)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error_vm;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_map_static_csa(adev, &amp;fpriv-&gt;vm, fpriv-&gt;c=
sa_obj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fpriv-&gt;csa_va,=
 csa_addr, AMDGPU_CSA_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_free_stat=
ic_csa(&amp;fpriv-&gt;csa_obj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv-&gt;csa_cp=
u_addr =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_vm;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fpriv-&gt;vm.csa_cpu_addr =3D fpriv-&gt;csa_cpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_seq64_map(ade=
v, &amp;fpriv-&gt;vm, &amp;fpriv-&gt;seq64_va);<br>
@@ -1604,9 +1622,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fpriv-&gt;csa_va) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) &amp; AM=
DGPU_GMC_HOLE_MASK;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(amdgpu_unmap_static_csa(adev, &amp;fpriv-&gt;vm, adev-&g=
t;virt.csa_obj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(amdgpu_unmap_static_csa(adev, &amp;fpriv-&gt;vm, fpriv-&=
gt;csa_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv-&gt;c=
sa_va, csa_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fpriv-&gt;csa_va =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fpriv-&gt;vm.csa_cpu_addr =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_free_static_csa(&amp;fpriv-&gt;csa_obj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fpriv-&gt;csa_cpu_addr =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_seq64_unmap(adev, f=
priv);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63451701C0B12F8AEF15CF08FAE32CY5PR12MB6345namp_--
