Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3D4C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 16:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6780010E219;
	Mon,  3 Mar 2025 16:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yx0W9fgq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8215F10E219
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 16:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfliboTbPdxIcWcqhcMup+Sy2wKnpUAZq9wJMk68CNy915DF3Z3vH/DkHpnG5N3IOHNwrvxVDIhSRtn3cjqVEd8kIUYTRP5isdGkgEuSsIHM/dsXixUcQb18meKM/++Uk8469Fa7cuCKyHXjLRL3lBq+VKMjm8MM3jnaLyObY1Lrj5aayfSpeP4RbwQRlWjw5crlZ6WyZ8xnDwBRMjaXnOgJ/mhViMt5GnhbM7BHTX/51Ruka2OZE9oqmlinVXMfAnUtMVMsPjNS3XEgv56RBzUvpPn3DC3F7uN5mvaMW97DlPy2kZTyBTISz20GnS5FdYl0RQtZgE7UAZJrH8BlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMfKnUrwAMJJf0OvVSK7SaxE69OrcSK6Iucv7k/qofo=;
 b=agavOJEWKGFhxghXVz2AJEjBGY3djkNhdjpoyJBGlHS+wny2Ib28A4gqYBIgTvs4Z0KUdgDXSjNmjmuGxRaflkQv4Lu6wW/VqtC8NThNDUWNkAEe45e6DIFkC3MmcxrJdChoP3Z9nicBFf/qwYyOEvgD+mDIifVFtgjgw9thgUd29+XhFFvkrQUv1SmkregdSTbMsBzbQPVcCGuQraGaU+JTNkhknEEIEfqh/CXXbLgT2E3UYWOnFceSTmd5L1jxXN72T5DK4afD/xU4n1ZG+1hFsh8KL3CbcYqL0W4E0LcaD2RT93GKNOzTvmnDKABIHnKlpqIVSvaYuuf2pnwhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMfKnUrwAMJJf0OvVSK7SaxE69OrcSK6Iucv7k/qofo=;
 b=Yx0W9fgq0gGjNMdDEhbmxyK/6FcyXlX3oWC9rCwZlEl/c6iAlzM7rHXW3MurM9I/uR634cioTb/MD/TFqPg8taR7n1o0ErIdwUChZs/umKYpnwQaJVPwPrr398AX7MttrzrGXjkwYRakfkI+N6JHFjqB+ufTZTcvze6Nr2Ht/b8=
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Mon, 3 Mar 2025 16:54:28 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8489.021; Mon, 3 Mar 2025
 16:54:28 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
Thread-Topic: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
Thread-Index: AQHbdAChtZ+99Qh1yUO+WgBT2fMl27Nh0PGQ
Date: Mon, 3 Mar 2025 16:54:28 +0000
Message-ID: <DM4PR12MB65669B7E34149B37C771964DE3C92@DM4PR12MB6566.namprd12.prod.outlook.com>
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
In-Reply-To: <20250131165839.8433-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d18bc042-7140-477c-b798-5763e5729f1c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T16:51:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6566:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: ff93586d-738d-4067-0eca-08dd5a740fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?c7aLNcy3ewKgalC2sFA+xVuSpzDOO5/h/uma8kZUjnpJCf0UgttoNCOWsHtR?=
 =?us-ascii?Q?NmSngqNbRSTcRwsorrmM7EgGpBUA4GOvBpUn4VmbXKR6p8Glkg/ZH2+GZM/y?=
 =?us-ascii?Q?HzPJiwx8pSkrsG5/rNpuxCIP78x6CayvduZIwTUkS53wtvL3zlqAhg5+s8/G?=
 =?us-ascii?Q?wtpascSUAOsrK5nWd/qERlWSZFvwi97kvC7MzN4r8UuSC+lz6MhFSmHp3PeC?=
 =?us-ascii?Q?mJ2Ff5gSp+Rpj5N4VD+JOTgHIWnN+WcHYGOXGBoLowu9mDnazwVIHICpeTNT?=
 =?us-ascii?Q?Xo3xK4Zmcn8u0ngv2pZCUI9VaHuvWC2r4hUU3UrI3E2/rh/BHyahvAgPy8/0?=
 =?us-ascii?Q?PyfxhJEaEQppIT4P7fWfykrQuw773DN+B9e6hp/BOaYSQTBQxFMmM2DJqJVB?=
 =?us-ascii?Q?/tGKSaNq2iMvj59nZEoppjiSod5h+D9wrrbILmX1Pw7H5D6we8qC1KSFFbWH?=
 =?us-ascii?Q?GM0hwlgJ6sCAri3zke492DnJ1d/7dsB1OBQZJ0C0XQONkH9ix7tWkQtK5Vzk?=
 =?us-ascii?Q?FeHmwjbdfvSriIghGDxp+WoZZCiLzZ7rmnFpvghYQMemglJUoCh7ZZfVcnS3?=
 =?us-ascii?Q?xy7em1W3uhVUMZjTEr/Jrgj1b/XwTZahg84CTODGdBdvgCf9N0Gqt+mMYA/q?=
 =?us-ascii?Q?VabqWb9YhckCRDKB+b2MSAQm6OGCTxHAIrZOFHR7kZ+r6nXa+3EOVQXSpLqd?=
 =?us-ascii?Q?yph+vx9DwI4E/cbhyafvTHfB17FfR+2adzhRi3wWEJsxC+0OUlLPFpV6p6FO?=
 =?us-ascii?Q?WEI1fLYMf4+UbFJKdw+JowaJzYoWAjPI0odR1fGS3YSNoIG79rTQJmceAo5c?=
 =?us-ascii?Q?TOvWeuLgHO9vcGph8Nzt/004RX5dmx3DcFiFxFNDngMYwdHHEQu72nYUv8ch?=
 =?us-ascii?Q?VonZLClVVKLKwoldtxiMmAQOboBLk8ZhIBRE7mUgyVAT0IFJekZ0QuYv2Qdy?=
 =?us-ascii?Q?8emIWGh2RmPoeAXKh6HNVvJeL4prhgRMLmOpwbl6WU6VErdUx6ekXFAarRDP?=
 =?us-ascii?Q?bkIrNFo3pX2ayS7r3nCpQZ3bVAYzqfNCfZmvsZEGXCZZnYS2YOvvhp1D58fe?=
 =?us-ascii?Q?iOBA6XlQfjhAf4t6mhXHiBDbJpjMgnJMJh8Uc5pcSyAYIXfwqx8KsSQuHNgd?=
 =?us-ascii?Q?xuncdneePqDPZOEJdVAUvS3pIZguWVSfw+2LlNqDtF4dTZv/d0MtlKnfL4mK?=
 =?us-ascii?Q?bM9/mSxUn+JqJCVHSaLnuRWFh0/t/c4W6fAbeCIVIfD83C/UbkdvuNR5v5xl?=
 =?us-ascii?Q?6eW6APljVoV1MgXlY68ujIEFXtd+ho2qFGmX8U4L+S6EY0tSeKc2a5emWRgO?=
 =?us-ascii?Q?f7C9KM+axeQWZSiJlSAmWxTx1uHhZn59cVrh0ym0aq6/2YdKvJ0GWYmi9wTr?=
 =?us-ascii?Q?Bu825l2ZQxLm/tnl1+hvBtW0A9TEu+4H/JJTJeBDbQkoo3Du8JQUWUgFgepG?=
 =?us-ascii?Q?uVMTw5/cYyGhB9c+tL4KJO9vbnaJUIYV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FPAK5CPtYRUAb7fjZJfFngCiqE1GK5OIs9Z/2cVfZepVX8W8X/HCwFklJyJe?=
 =?us-ascii?Q?UXDD44uFkpjHw02mObsDXKQFqObzwgeYquo1kdzblOhgrHWbpRy6e+rhvxI+?=
 =?us-ascii?Q?dT+H2w0dmHTlIuQO+Hukp3vPnseqYCBtsIaP9cCIY5LHMEArPM/D9XAsFgxy?=
 =?us-ascii?Q?9jBQpuTmJmkRKOGTr+XbiVfgcbFh1prEgy9hCPXopzcAzSkU2wL64aEWB3px?=
 =?us-ascii?Q?QBAzPpmIkQt4q4Sdq/5aCcwd1ExOlWpyh+Yvve1n6ZnmoozYt42e5NmSoQ/k?=
 =?us-ascii?Q?Lo6aje4Wkcutgj4kRYkNY3WghiCe9wjc31Pk6JJhEvZQcdMUvyobUN1fzlOC?=
 =?us-ascii?Q?htcE61eRX/FabZcE508G/bp+y44BTsWLAlHBvaRMmm7FAs/1scatb7l3iRmo?=
 =?us-ascii?Q?f7LKZQviEJTE0VT42E4XNlYRNY6HZBcU0zS4LhKdyTzaE829v1wfW1hadu8t?=
 =?us-ascii?Q?RPRVVcaPozomi+bPq2j4ItvT36BSQcIQescm/fFZTyfx5++plOL5eaXn3+sE?=
 =?us-ascii?Q?fBGqusOr19mKrhoGk8L0XHumln4uB/VJvB/Z6UWeAce9/7vkiK3DVX8goGAE?=
 =?us-ascii?Q?qxwg29UTOspDqCiU9knuEj1oXtKqIPNbKkUIZGNZqlHa04UDuC2sZKxSq5el?=
 =?us-ascii?Q?3/IG5m0jrZbjBJHBidKsqnuyQ/XAwPQ5OG5CVSIUr8nPnGeDjLB0MiyOFYWs?=
 =?us-ascii?Q?NUFIHjzR/yMWsiX+yOliyTd4hxbiPheBTlkKL4Q7teqQdrcMNIEVX/xaeTUU?=
 =?us-ascii?Q?fsr9/pXaBidpJDpbxutBr/t+/1AOWa1Ynd9Af50mGVLre+7esXgHUSvEZP2x?=
 =?us-ascii?Q?B5C9IlE/kWEfecrVCT9y/EqTVdtLzRPf4acentN365fzUFJp8Myxt5n/H6Vh?=
 =?us-ascii?Q?4P5X9qB4eFk/ijRHSHi/X29gOzkKSteczHxEbVzoD//q6/Gh+Xee30PqL3xB?=
 =?us-ascii?Q?WHgMXZqzp3eAGVjYiYPOeiTSZpg4GZ93n2HCUMgVB+ED0WK3YMSMHHY+2mv5?=
 =?us-ascii?Q?o7mYEJn/i6zOckjAr6a8kWOktsGzS2FEUbAO1bdggs7G4pMgK/pHUWTWJus8?=
 =?us-ascii?Q?Wh3IHfKAvFHo1+PALkfy4qWWQCxSd3pw11vRbNmCzqBE/pvHqjSn++hXsptM?=
 =?us-ascii?Q?Z0qg1/bsgL+/j531TnqSdgi6iCwuyNido2zmoUsG6OW1+hTjpeEEPRAIpU9O?=
 =?us-ascii?Q?t2wcK4FRYx0WNxR+xPXZfVIepOCCK0K4TGdhOSUGnO1ASX+avC0IjIZT9Vp0?=
 =?us-ascii?Q?ot/MPfhiNLU7O9i7YVUOpFpTgbaNAIcRKfLrz0YzCKBxVkfngRRvTCtoYQ+3?=
 =?us-ascii?Q?SlKtXENc9A8V5WvEsQmMxaXfzz6WUKSolXtMNNAmiJh13Lv0smx/rieue6S/?=
 =?us-ascii?Q?nhLqPio/AInUQciJBqj+FgR+v/ie9V1FKWhZMOfH71Vpf3ab+aYUyC3IQdQj?=
 =?us-ascii?Q?HIJVWoDXlJAamW6dO4sQX5y9KzMvdT1npQ8MSnVlws+vtwN2wpjrQ0ykgeIC?=
 =?us-ascii?Q?ge5GvL2Tp1Si3ztPCKSN05LcgoModaaMz6YAwrl/JREE/YhcS708Z5eIjV/T?=
 =?us-ascii?Q?c3PQ+0a2XFFGC2uORxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff93586d-738d-4067-0eca-08dd5a740fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 16:54:28.4462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 233lQQKl8mnVt7G5l2URj0ZBsMahpp8ZlNUTIoo2JcjgkG63hbnS0TauG030HZuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

Ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Friday, January 31, 2025 10:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Change error handling at prange update in svm_=
range_set_attr

From: Xiaogang Chen <xiaogang.chen@amd.com>

When register a vm range at svm the added vm range may be split into multip=
le subranges and/or existing pranges got spitted. The new pranges need vali=
dated and mapped. This patch changes error handling for pranges that fail u=
pdating:

1: free prange resources and remove it from svms if its updating fails as i=
t will not be used.
2: return -EAGAIN when all pranges at update_list need redo valid/map, othe=
rwise return no -EAGAIN error to user space to indicate failure. That remov=
es unnecessary retries.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index e32e19196f6b..455cb98bf16a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_=
struct *mm,

 out_unlock_range:
                mutex_unlock(&prange->migrate_mutex);
-               if (r)
-                       ret =3D r;
+               /* this prange cannot be migraed, valid or map */
+               if (r) {
+                       /* free this prange resources, remove it from svms =
*/
+                       svm_range_unlink(prange);
+                       svm_range_remove_notifier(prange);
+                       svm_range_free(prange, false);
+
+                       /* ret got update when any r !=3D -EAGAIN;
+                        * return -EAGAIN when all pranges at update_list
+                        * need redo valid/map */
+                       if (r !=3D -EAGAIN || !ret)
+                               ret =3D r;
+               }
        }

        list_for_each_entry(prange, &remap_list, update_list) { @@ -3729,8 =
+3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
                if (r)
                        pr_debug("failed %d on remap svm range\n", r);
                mutex_unlock(&prange->migrate_mutex);
-               if (r)
-                       ret =3D r;
+
+               if (r) {
+                       /* remove this prange */
+                       svm_range_unlink(prange);
+                       svm_range_remove_notifier(prange);
+                       svm_range_free(prange, false);
+
+                       if (r !=3D -EAGAIN || !ret)
+                               ret =3D r;
+               }
        }

        dynamic_svm_range_dump(svms);
--
2.25.1

