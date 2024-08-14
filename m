Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740EAC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 15:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1D010E4D1;
	Wed, 14 Aug 2024 15:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r0vipslc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E254710E4D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 15:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCq8HfCJ8177jivVbSZc2pYQRqxUpK4MBMIwvbhKf2MgwWVBQQkrUtbIWZmTAVmJGehuUTgAJpz3NY0t0kQt601XZybLWuawcyw+95teYdBC8SP1LUY54dopo1aUv0Px07nJML6JFMthE/t9ZhpJ0wBQLnZy3ctYrMVTR16L8A/5Q+J4GMzR/wyFHs7onQzb1gplF48GAgVNrnU+rIOL3bU0ltN+NHPD9FEMpthcVqoyrbJMr3GKFps1WKrSoTBbZyccF/OgvjusuFhy2j+DoAUyofQ6neDJ+rY8JPJiVmimHn4bqIDkVMDwMeHXjxjr167RmsXf5O1llJLixQaQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OQ7mI37prPpGJaA8Gy7g6iuR6OsIv1JLQdnBSJQOpg=;
 b=v04tW1JW5mXa1SgBfbLS6Clb++9KrtV0xr5z+9cODFpyk9osBGBFbkW8Hjli+SSE63v0HlI/tSGw0bFjDFEAwGQvSQH/xvr5Gg9pj80lpPz6qF+jVdDeeGOHdfdEJxTAJPJqrqs60Lc1m7pbJC/Crks8lIsuBQ/UMOD3l6BDkFHHajhOjeZG+3rPZo8ae3UeJVSbiDvM3OoyiZXgf91kW5Z4LfVEXAB/cnVXO1CTKN8o5k1v1ZkH/Zg1MWeHr+kcitHrH2UdJWo/uffZsaCtw7VTS1tHaHHmolFR1/MTGVrlUwJ9crFYZkBlz7B4qyEL5ZOI/X0hNRnW9yeJxG9upA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OQ7mI37prPpGJaA8Gy7g6iuR6OsIv1JLQdnBSJQOpg=;
 b=r0vipslcn5APRQ9i3WSf2DEXsO1nyGRyOfs25ZQWB4vK1q3eg4XRuSJ4l2AnUV4S+9FYTKSZrRTNSbWZcLt6kr60VEJwzEu8WL8bjR1R7vfjFmt5Rhln8lF9/SF4+C7w6UJVrp+/jjeioHP7qei8J6+RONXY2EXg6zaTbS7DtTI=
Received: from PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 15:36:23 +0000
Received: from PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4]) by PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4%5]) with mapi id 15.20.7849.013; Wed, 14 Aug 2024
 15:36:22 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with
 MES
Thread-Topic: [PATCH 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with
 MES
Thread-Index: AQHa7bKqZ3qd+rba4U2sZByxdbpat7Im4/OA
Date: Wed, 14 Aug 2024 15:36:22 +0000
Message-ID: <PH8PR12MB71120BEF9A5B09758366B21F8C872@PH8PR12MB7112.namprd12.prod.outlook.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
 <20240813185713.942012-3-mukul.joshi@amd.com>
In-Reply-To: <20240813185713.942012-3-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a4247303-c487-4dcf-bdc3-9e39e9aa2fa8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T15:36:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7112:EE_|CY8PR12MB8065:EE_
x-ms-office365-filtering-correlation-id: 3849a697-e153-4c58-034f-08dcbc76d9ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MlaM+1x8pR0G/Cw+iDpW1vJKdFHuNwFJ6Xt6WGh8EMAMzz2cxGYrBtfFkIZr?=
 =?us-ascii?Q?clnyOboAygraGxH7/yGxWRoIUeruSUCwLwkwakGlN7Bql1ml7eCYjjZSdv+3?=
 =?us-ascii?Q?f4mAxOVrlbVqCWB1J86lE3vfZxGln/MFDTn3c7dMldQ/JNAAJvqxnjmQYMB9?=
 =?us-ascii?Q?sqVWemiBLcQFNJZCL3P5JDpXucCTqr/xnjXv/ZzAb+/n6sSWGq4IArVXlZlb?=
 =?us-ascii?Q?aVbnbDUNqpDEhYcMhOrDbiBuWPUSrW2CKC7Y7dRavUtVl8s2ygTDdoeXZVAo?=
 =?us-ascii?Q?ZkI+rWx10VToc0RYanM++3RaNs/7SK0jQcPLVhJE/XjCkALA3fngNoetx5s6?=
 =?us-ascii?Q?m95gx63Ugv6/CEr4q0pwixyq8TJcEYkvhdEi3AFhKDV/Bn6Q4tQbZszlm79e?=
 =?us-ascii?Q?EeprF7JWIbG+UQ00PL6nkp+siPJKnpBg5wKA0xkJBoeOUzrWvQsG0fqKDuVj?=
 =?us-ascii?Q?4AaxZ3vF8Kce9QfBy35x/XQ9J3cfZAEeVxFkNVmAAT0zFb+gD6muOGxxKy42?=
 =?us-ascii?Q?8z5rYEhQ/ESpY7W8oImSD8mUrzG7mkZcjCkdtpTR33ym268JeRDw9q/t3zbv?=
 =?us-ascii?Q?IxDgvrg/Rt7axhcHJrc7V8K+ledJJMWlX2cRbcwO/cig5swGFFXY2ZHQK14I?=
 =?us-ascii?Q?slJAUg1NGGp1byixaM3URerI97GlElZW5Rr1degausSXGj/n4V8FYh6C77ta?=
 =?us-ascii?Q?uyfCDeKAp+WbzVHyCCzKBnRo7ugjA9srPet2Z710+HL/cXgKEAUAhLLOceEo?=
 =?us-ascii?Q?Q2J+lTkTIAgwCHNCH0jgDVu/9pyXoXIlViHJN92SfZdVDm7O21gIrgNJurK7?=
 =?us-ascii?Q?0CpitTt3boKZJ1U7GmoMmQVcoa1VSaeryM7SzFN3F6b/cZNSuanStpAjMH9P?=
 =?us-ascii?Q?6t7cUC97w7MMyOw3lGEvHz1grx4xtipO+9InI1tVTcYQE0loMTGlNiD7gUqw?=
 =?us-ascii?Q?r0xC66MkbCq1JS7/LposRQSNN28wYED2XzIKXCgrPoUeT6jU5tbtfN7isUwS?=
 =?us-ascii?Q?b8uM1WlUKU5ZqBOZn04OB/+6EjuY2bdOwWa6PtsjgIyM3zi+t8tWv43FYfD8?=
 =?us-ascii?Q?bs4UWB+MB+QvpgQL5jlKveVbP6Crd4lOdyur0kDIpHuApTqyi5GC9GB4eDy6?=
 =?us-ascii?Q?I4c63drLn6wLHWBDt6FE+oBHXVYMTJonwM2WfmbXnJJx1YaRL55V7CANXKb8?=
 =?us-ascii?Q?KOVeImzxkRqeem/nfCBdieI7auRspQ6KrZleCBl4P6VtVNmHG4DFtaem5+fU?=
 =?us-ascii?Q?yZ2dDXzHO8uufCwF7cd7U3u5BWHZUcrZ4n2ns2hCIxUDqz1pbGP/h/E4Z4QO?=
 =?us-ascii?Q?Zot5AyJ0SseM4csPi74siEc00MfVnOFb0lHm27YRuudZjILfoXnycAheAT6a?=
 =?us-ascii?Q?Rl+gdw/UI/B6ykp3McZ1xxQ+iO9vlFKOKC65qHcZxRXR6T+FLw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ns/mw6cSVB+8/2feAlXeoM4z12T9rKAqyVLS3OVEg7eQCk8ga0NXCgbAHJ6P?=
 =?us-ascii?Q?NxfRF7loKWVIMxgSUYFksubvoOIWzJvYtmLGUQ5ksyEsG7lJNMJyVU6E5IuE?=
 =?us-ascii?Q?Q38ycQ+3eesJyTM9+XZNZwhLnVUMIEJphdMUg+NMsHhx8S3pqsuatNaG1pD3?=
 =?us-ascii?Q?0AYUNJ/6mpmVy7V4wxrGPOYb8aRRwSS1zTZQ7Gnjez+XbNTMjQYCS+SVkD7d?=
 =?us-ascii?Q?g4z8qlCaIwBj5M9K55x89lpegwn9vrxjnb+QJM0WMvzkwNP9kFmSDhXKcYEZ?=
 =?us-ascii?Q?UvE/H9UvhgPGyx0XZTkPQ44QhB3vihT0Q2clZ32Zcwg2ME6maNWi8OB97l/7?=
 =?us-ascii?Q?l36gPXAoPHzsMqP5dRIurn1wt4pCudWYGZhP03J6LwIUXGvu/DdPHtsNkKtO?=
 =?us-ascii?Q?pLCsfGV+skBmOFqrU/nVfroTxc400aQ9udTHoHbWcM8ipXsFQy6bt8tnDeiP?=
 =?us-ascii?Q?Gvb0iaoLcgWlMfEyXVnDNOw7nr2NLWa08FAQe+00wv5yRW+B7QhwHrXxTe3h?=
 =?us-ascii?Q?WWAUDifLMIdAbipNgUqvOWecpED3YPGNR/AI5V1efrjbZXHZsP8LFrSp5Vgu?=
 =?us-ascii?Q?DgT2CBAtdhhUnsrK3qmzCetxCZZnHiSXvqDYblyExtksgAcB7Zup3DZCuZIy?=
 =?us-ascii?Q?O2n4+HSUNhEm1AVbQ9ztR9/0eztWBEGzFUxFtaGHB4/R7/TesvN9jP2hEvlA?=
 =?us-ascii?Q?EgBMtk8g/rHixn7NB4zrqrfvSP0dNZDoRw5mNe/kcJInuLNmpS6/lD1taIN5?=
 =?us-ascii?Q?j28Xdmya0Bhmp/rx3JfDhdQQdDnCjjAiqpH5/89i/o+m1+ysAMsMGNY9JcZz?=
 =?us-ascii?Q?G/5YSjgVf4LlbPq4mpJHQn0BbC2ic8ZYGYsa96JSxIkNcW9fI8R9oLRQcXpd?=
 =?us-ascii?Q?3+W8yVLVq67CXlDK7jcKJz1LRFzTjmpltyZ0I80eBP0pIHNVfemY/ErLMvra?=
 =?us-ascii?Q?gO/bbgQSxzEnh8EHo9AHQ+DgwqbMcDBeqYYzrZc7YF0/nNxMtP/bWse9vs0O?=
 =?us-ascii?Q?tayW4xLRXvYOL3J+jZEo3PIV5zTCSRaqy+T0564U+Wv7FZ5jYnXOdmv4SMvy?=
 =?us-ascii?Q?la4FaCax1Vpip/HT3JBAFwG7zrW9GuVFWTWwppKQMaKn3W3Va0XDsvEJB+0L?=
 =?us-ascii?Q?UUuvZ13ppsZfpv/MDv4oGpCCbyceqEUCsxcn79ULoOhtfv+s2XYXniKtrice?=
 =?us-ascii?Q?mEI0+7KRSBB2lfDy3wbC2r2xEINOAAqwHG0csbTSHP4objDqipd+DoVDxwkK?=
 =?us-ascii?Q?vkUhWATHodu6PgBySC8FTskYKIAZ1C5Krte0b943zyGOXxJEpJWAUJVy9+C3?=
 =?us-ascii?Q?E5L4M8DWk06p/QDvLETh7rr3bPgOGs4hvvdhIbjCrZqR3O+2mIarZTOgJwRm?=
 =?us-ascii?Q?txp+EW+/iEbP3Jd+bnOTUuF6sjuPyz2DQhk7HPZi3MT1WSJ6+BEVtR45VwBB?=
 =?us-ascii?Q?kTfdWDhJlvg/4TJfJlWzJCm5O2oHj7ptxBsDfUVNoftikuXVfOD7qv5t2jPY?=
 =?us-ascii?Q?XPn0elAAzmqD14UZMSs1QIDz9PeGt62ApAlWst1pI464XHxUJ5xfF7pbx7nt?=
 =?us-ascii?Q?c6/65lAjt6MaO8fhXf8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3849a697-e153-4c58-034f-08dcbc76d9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 15:36:22.7898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJic/MdYHebEr4wlVwz5LoA4jc2OXC2NJD86xQy0Ya3vIcILi5dvVv5d3qT6zVFOf7//RcIpHn4o4+N8OqKIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Tuesday, August 13, 2024 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with M=
ES

Based on the recommendation of MEC FW, update BadOpcode interrupt
handling by unmapping all queues, removing the queue that got the
interrupt from scheduling and remapping rest of the queues back when
using MES scheduler. This is done to prevent the case where unmapping
of the bad queue can fail thereby causing a GPU reset.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e16b17e301d9..dbbd836d0b9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2885,6 +2885,57 @@ void device_queue_manager_uninit(struct device_queue=
_manager *dqm)
        kfree(dqm);
 }

+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 d=
oorbell_id)
+{
+       struct kfd_process_device *pdd;
+       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+       struct device_queue_manager *dqm =3D knode->dqm;
+       struct device *dev =3D dqm->dev->adev->dev;
+       struct qcm_process_device *qpd;
+       struct queue *q =3D NULL;
+       int ret =3D 0;
+
+       if (!p)
+               return -EINVAL;
+
+       dqm_lock(dqm);
+
+       pdd =3D kfd_get_process_device_data(dqm->dev, p);
+       if (pdd) {
+               qpd =3D &pdd->qpd;
+
+               list_for_each_entry(q, &qpd->queues_list, list) {
+                       if (q->doorbell_id =3D=3D doorbell_id && q->propert=
ies.is_active) {
+                               ret =3D suspend_all_queues_mes(dqm);
+                               if (ret) {
+                                       dev_err(dev, "Suspending all queues=
 failed");
+                                       goto out;
+                               }
+
+                               q->properties.is_evicted =3D true;
+                               q->properties.is_active =3D false;
+                               decrement_queue_count(dqm, qpd, q);
+
+                               ret =3D remove_queue_mes(dqm, q, qpd);
+                               if (ret) {
+                                       dev_err(dev, "Removing bad queue fa=
iled");
+                                       goto out;
+                               }
+
+                               ret =3D resume_all_queues_mes(dqm);
+                               if (ret)
+                                       dev_err(dev, "Resuming all queues f=
ailed");
+
+                               break;
+                       }
+               }
+       }
+
+out:
+       dqm_unlock(dqm);
+       return ret;
+}
+
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
        struct kfd_process_device *pdd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v11.c
index f524a55eee11..b3f988b275a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -330,11 +330,14 @@ static void event_interrupt_wq_v11(struct kfd_node *d=
ev,
                if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)
                        kfd_signal_event_interrupt(pasid, context_id0, 32);
                else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE &&
-                        KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECO=
DE(context_id0)))
-                       kfd_set_dbg_ev_from_interrupt(dev, pasid,
-                               KFD_CTXID0_DOORBELL_ID(context_id0),
+                        KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECO=
DE(context_id0))) {
+                       u32 doorbell_id =3D KFD_CTXID0_DOORBELL_ID(context_=
id0);
+
+                       kfd_set_dbg_ev_from_interrupt(dev, pasid, doorbell_=
id,
                                KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(cont=
ext_id0)),
                                NULL, 0);
+                       kfd_dqm_suspend_bad_queue_mes(dev, pasid, doorbell_=
id);
+               }

                /* SDMA */
                else if (source_id =3D=3D SOC21_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index f7c12d4f0abb..7bba6bed2f48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1324,6 +1324,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_nod=
e *dev,
                                        enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq);
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 d=
oorbell_id);

 /* Process Queue Manager */
 struct process_queue_node {
--
2.35.1

