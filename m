Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2899D1D893
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 18:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5D410E09B;
	Tue, 15 Oct 2024 18:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnFmDdDJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB40510E09B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 18:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBf14qcp1bpcrb6BRGNpehAGJ22s7U1FmkAb3iMpSPQq3Ci+9PQRcv6WflzLFoXLU5DprZxEUzSeYhxwDlwVRhx2Bsgj6cDyWj59/A4R87TAM8i6zjba9JtJwuj2bviv3ZQNIIEywOW53sVhLHYgv2o+KFJfLUjEyFAu47/qyHrKWalqOPAc7+JrjkPiTzcGNdAj7m2l4SNrDbvxgHGupqYS2RLDkIznaYvbJJtVdD1op9ovI79tIWYxlhQCc037XP3vqw76lX72bt8ESFEzD4mmigEdisCPaCJR8wHcVVww/ilflOPzAuZH9tMzIXN0F3LvuJLCN1tuRm+0SJKuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fublxEgxi25pZRVEFR+eqv4qrdoePagQNQ+CSH4HErk=;
 b=s7N5hn37JSfolO/DesCk8BZRNd/YxZNVr5iIno73cMJld15EetoESNchzMzGWpSZ7+hinEEkf08RnE4XY790vZErlgnpFPBcmJ67JcMiARzo0xr2TxC5oS5M4SgiTky9nRRBDUixkoj74+HcSUK9fTUq7tiH5ITQJcVKpfiJZANH3TEhR1BpyDqipdbFfOKLnyejiHEzTFI+NmSNv5Oh5D3+nghzUzlNkpE6ozy3k3/qpqLr1eKvsUuaXX/r7oYmtb6RCWhe7wX/76WHpMKJkX+wglQGmcPXm/hKrQy+/2n9lHA/PeodaNvPUlyrxHRbz5zDh371c30ra1vgU/z5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fublxEgxi25pZRVEFR+eqv4qrdoePagQNQ+CSH4HErk=;
 b=SnFmDdDJAeV75uBP4P89A0j7cA0Hz7j/zOAhmsEjm3mTeOGDhuohThsS4c5fxp2lzzwV+KkHY9eiK9j9Dq8RXHhqgkgiJdNyfxJvfL8H9zxyOuLILGR+2R7+CdpbANnr0K7ubS4mQo9jrR/MwXVd4kVn2VDyFZP9y0mz0Pjlikw=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 18:09:36 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:09:35 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add/remove kfd queues through on stop/start
 KFD scheduling
Thread-Topic: [PATCH] drm/amdkfd: add/remove kfd queues through on stop/start
 KFD scheduling
Thread-Index: AQHbFneY5XwP0Ly4+0KsxIPcHtGw57KILaRg
Date: Tue, 15 Oct 2024 18:09:35 +0000
Message-ID: <CH0PR12MB5372514D3120F7EAC9BD90E4F4452@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20241004160745.5282-1-shaoyun.liu@amd.com>
In-Reply-To: <20241004160745.5282-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a3df4c71-7036-4050-bffa-385878a9be28;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-15T18:08:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA3PR12MB8023:EE_
x-ms-office365-filtering-correlation-id: e19e70e7-d27f-4474-b227-08dced44870c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2dfNKOwltkgAfx/FGSlQKDARAF5D8A79b7Iax7Adf280Xjgzn3875peggGu4?=
 =?us-ascii?Q?/CpeNNw8n7otzO+vTkh8LPtWJp0kBw3xYel/Llf888jbced1mLfuOBeK2n51?=
 =?us-ascii?Q?lvprribffYCBnZF+M1F4DLDwCBIBxN85ueDEjVugJ0Y/1Qbor3o/lv3SWtaL?=
 =?us-ascii?Q?U+ENcikn1pjiwrc39tjxMUUoWO64HdTRLMCaHcGSW1AGfJ3dNKDEn8BvSfS8?=
 =?us-ascii?Q?DYJWbCUbPeJhXhd+pNQ7Ck1WEUElUBNI52r8Q4PGnr3aBSx92WxsNvSVEBzK?=
 =?us-ascii?Q?c5FbzPZHgZn+iDFs6ou8SLtVMs1iGBHodUAn1Zax29D3OUku/VPEkZbip8Pn?=
 =?us-ascii?Q?k2BrwG1c/vrUFwsE7HJ8MrYbCYQZdE8xVrbwjSCATAMXb8mz6JOUJAqAxvZ/?=
 =?us-ascii?Q?Qmqij2mk0ck4njxq3Py0PSfKBOtNKzITje4nfNP7vZVPbD52gafWqU10zzvV?=
 =?us-ascii?Q?zDfpoZ6IM1tu2mSBycvvE9qL7ZZdP30l2uBn3/BaHj0EXhwcO3AnyCkFgWvt?=
 =?us-ascii?Q?ZrzP2YE2WnNlnY1Et9ey0RZ9tRjCGxzCOhfEe28L7w4M+d7Y7xjMc9m+XB/t?=
 =?us-ascii?Q?oUDbohuaJZdZxqY8qbERGP+hEU3d5RvvyVgWm/enhdbWJL4G4Z59GFG8vEux?=
 =?us-ascii?Q?WrMkLyoNtKG1lVivUF4MOZ6qpvwpY4sGxBPFqpgCpEA+XwYtbuJ5yK3z/BFf?=
 =?us-ascii?Q?0Y6l3R0QYt7zlVMOFsqESV8I/GZMjAxHy3WJd8dtFNRWeeIKBkuUWAI32Y8X?=
 =?us-ascii?Q?4IhNykXBkgj0FNjAiRc1XLrFD6F+cuPN2e2KL9vYoyFnnALGxjCcjANKOSRm?=
 =?us-ascii?Q?3011x1kjGWRVGwUd3HBW+Hf8Iw1c1fLAXvYRqy7De+vF9zgQ5qiVmg9Oz7YI?=
 =?us-ascii?Q?DZ9E81n9JPijiCCdzRzK9RWIfJ1OwQnW+E3Q7bV55y8clqZCo5mYntneGuEZ?=
 =?us-ascii?Q?0VzWExmE0edGrT71B8bVgQZrx7BOLh1rXuuBsvSGCbY3OZfZId4JB0CMD0/x?=
 =?us-ascii?Q?+X72SefsdHrc7Tb9Skj8M22N8X8kyBgJvKZPsX+leDNuureOZlzLyAd4M3Vj?=
 =?us-ascii?Q?44ZCkJMlWOiiiihCblty7Rtbf8gudCZAWyLMes74laIM7YAWhx1tou+LQJzX?=
 =?us-ascii?Q?t/KRRcbnWhKbj8qUpyzs+EX98AGcEEZT82TiJTvlUCKgT41iyibfFxOJnLi7?=
 =?us-ascii?Q?vuu6Xku1rvWU3C3248c7g3bpnk8C+064tE0s4gcHMO0vbuLNeSfAvx0GopIO?=
 =?us-ascii?Q?4wm4V8QTcltrJuG4tq2DG3XcCP4SmE/0cFP1Bg/6x9JYrJfQyMcWci/hd7tK?=
 =?us-ascii?Q?SfSIvaGV+isx99/4DUjNKj4MZNgNA74a7/mQNgrKCFQdaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QoEXh065lNOak7BxIJfGvA4FdqAG6HNA2IKXZhEFttdEhI7YuMCXApwye5/g?=
 =?us-ascii?Q?H86Bn1sJvXiS/JUdAVX0WXHpO/oDIgXk+m4g8zVuQGyxU7FCMv0NDnczfbGR?=
 =?us-ascii?Q?CJH90jtjDZMGPEpip1/E0vkR/YgJMHf9I6MX+fUTSWGnTxWJnvbY7SNdF5lV?=
 =?us-ascii?Q?Kx4Qkj8tWdSvqZXDjSYc2NvTAoV6rgsdjscGJ/dRHyMuJ/HbSF33q2GBZVQ7?=
 =?us-ascii?Q?lpyLxwKhlvzgI3qVOM+kmdxMNOZ8y7dCPSPQhigJbFDQF5iIDtAl2EISBYoK?=
 =?us-ascii?Q?Ilv27zXvX7DHnpoPKfBo6xsEzCm6r2fdUiciqvs8fLkhXjMHgKVUOP8k9StM?=
 =?us-ascii?Q?NW1xh0tp0Q9aQToZeU8if1SdUHL0r5HirIfDU/Uv3Zv2TlH20EFam/JUICHU?=
 =?us-ascii?Q?LlAjMqbo4/dlb7WasXrQ2VCSXtSYQoVz/2/0WN9YXNolJ5fZxYDWTzUKmCbX?=
 =?us-ascii?Q?FsSBA8/IWbU/xhb2r1GimdDnCF8ygjI+yDdkJY9sw7zJ0Q71QmLkpWx6kze+?=
 =?us-ascii?Q?BCDmbTRAZt/DoOGQGQv3t5DphRU+yjNRIbQLqxjjmVlqjR993/lgglPwuiCa?=
 =?us-ascii?Q?bQZ2wkyyXQbLKEEzyWEBUDSzx9Rvkb45YGegNEZXC0t5K9EjSGgIAXuE+x9J?=
 =?us-ascii?Q?18ELS+O7E0KRxsg98D4r5IqrcZXc+rC5Mhnv3wPJuetgxRuKkCJ+AMw/WRDm?=
 =?us-ascii?Q?zbBzGjSrrLotnZPYl0ECyqeEL1YwDPZvZhQGpT05cepnKyNTRIYPycfdr4ZT?=
 =?us-ascii?Q?xSUm8Rsirp2c5Mvgvwobanx/8uAz5DuIL8T6Mj7to9EW4mlsIDTTttcbgsXP?=
 =?us-ascii?Q?KTM1DoJDLpuhty1pOjn5MI4tZ43V/R1qVtVbF3avoWE4WV8E7ZdZ1rAfEhPI?=
 =?us-ascii?Q?ko3QK39eDXxyTDaJMwUo8OnNMrF3gvYs6JXRF/mMkCbzfD1D1k77jqglU8bT?=
 =?us-ascii?Q?BMJTduVSMJrbEf6sMofgvkOTQtWgdlBqjutveJ9DKWW6djaognbkSRiwPtnC?=
 =?us-ascii?Q?A8a0ka+xrc0YcL4xhyR+/3HvK+QgqAW99SZB7xETcAh0FpiMHMi1fBi2N8hQ?=
 =?us-ascii?Q?Ll3FOXZOwua/WX+wfWrPeho2lhTt4TMpmE2wRTycegUkWFaobEkgkG6uecvY?=
 =?us-ascii?Q?nLntE0Mx8xUHq/53OyFQRiJBefEy/Q/OlswPTvXaX2JeRSOlXGU9EBdrngz1?=
 =?us-ascii?Q?b1ZivKnYvTXMe5HB6As0iJqUkw3bc8n5+6CHrMxdCOLcyoaXGB/ISG0QFlK7?=
 =?us-ascii?Q?89vKwwmekt1cHndsP/PDEk9d6gaFX9dpGcAgNfrUDgcOqhoYAvIGRd+NFtiB?=
 =?us-ascii?Q?Lmjm//uxFc5EqXKD9Rk3wyeIe1lw6NnWnHCgQjZWQY8Lsw0LkEhxp/zfK3l0?=
 =?us-ascii?Q?UvKxMScKK/uvbpM/1fTjxxcOmPPhCu2rP1RBv58KR1BUjeCYZHqhwSyQOA2l?=
 =?us-ascii?Q?saaLQJpCzqunrGm3Kuyd6ikFW05YLDQ3xTL/OgI6dI0k6Wx2XBTcMmz8qnJM?=
 =?us-ascii?Q?WbdfQkATlbPGPgLUBHqWtpb6ukMDzt29/teXtRH7+zmZBDB8xUnmGEDvJ2B3?=
 =?us-ascii?Q?cQMrvAakS+/wBA1RHT4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19e70e7-d27f-4474-b227-08dced44870c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 18:09:35.8497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff55BvvgrTiyGliPO8trhvNT89lUDzE6U/sUNwWLG1ZzBLo4J5XEuRL2YUrOWLSuGZF9iMNzZGf7IzqSMgmG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, October 4, 2024 12:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: add/remove kfd queues through on stop/start KF=
D scheduling

Add back kfd queues in start scheduling that originally been removed on sto=
p scheduling.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 648f40091aa3..82a2404e8a7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -292,7 +292,7 @@ static int remove_queue_mes(struct device_queue_manager=
 *dqm, struct queue *q,
        return r;
 }

-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
        struct device_process_node *cur;
        struct device *dev =3D dqm->dev->adev->dev; @@ -319,6 +319,33 @@ st=
atic int remove_all_queues_mes(struct device_queue_manager *dqm)
        return retval;
 }

+static int add_all_kfd_queues_mes(struct device_queue_manager *dqm) {
+       struct device_process_node *cur;
+       struct device *dev =3D dqm->dev->adev->dev;
+       struct qcm_process_device *qpd;
+       struct queue *q;
+       int retval =3D 0;
+
+       list_for_each_entry(cur, &dqm->queues, list) {
+               qpd =3D cur->qpd;
+               list_for_each_entry(q, &qpd->queues_list, list) {
+                       if (q->properties.is_active) {
+                               retval =3D add_queue_mes(dqm, q, qpd);
+                               if (retval) {
+                                       dev_err(dev, "%s: Failed to add que=
ue %d for dev %d",
+                                               __func__,
+                                               q->properties.queue_id,
+                                               dqm->dev->id);
+                                       return retval;
+                               }
+                       }
+               }
+       }
+
+       return retval;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev; @@ -1742,7 +1769,7 @@ static int halt_cpsch(struct device_queue_manager=
 *dqm)
                                                 KFD_UNMAP_QUEUES_FILTER_AL=
L_QUEUES, 0,
                                USE_DEFAULT_GRACE_PERIOD, false);
                else
-                       ret =3D remove_all_queues_mes(dqm);
+                       ret =3D remove_all_kfd_queues_mes(dqm);
        }
        dqm->sched_halt =3D true;
        dqm_unlock(dqm);
@@ -1768,6 +1795,9 @@ static int unhalt_cpsch(struct device_queue_manager *=
dqm)
                ret =3D execute_queues_cpsch(dqm,
                                           KFD_UNMAP_QUEUES_FILTER_DYNAMIC_=
QUEUES,
                        0, USE_DEFAULT_GRACE_PERIOD);
+       else
+               ret =3D add_all_kfd_queues_mes(dqm);
+
        dqm_unlock(dqm);

        return ret;
@@ -1867,7 +1897,7 @@ static int stop_cpsch(struct device_queue_manager *dq=
m)
        if (!dqm->dev->kfd->shared_resources.enable_mes)
                unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,=
 0, USE_DEFAULT_GRACE_PERIOD, false);
        else
-               remove_all_queues_mes(dqm);
+               remove_all_kfd_queues_mes(dqm);

        dqm->sched_running =3D false;

--
2.34.1

