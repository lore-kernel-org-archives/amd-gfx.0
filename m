Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F11C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 03:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36AD10E1B9;
	Fri, 10 Feb 2023 03:18:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D4E10E185
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 03:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVPn6QAMAX1s9hsXDaJ9eADflnyyIv45PoC7tsgSJzZlKvqVZA3waZvPtqiLdqN0C0D1Ot6I3U9IVI0ixarSmggwq/SBxHxDuyfTXQJJDjQIRb3dnLVdCfo7gHZPum/gRSCOHUxRCBuUt8pgvxkv8B1nXZ5NXNCu312mMvILgHygw3HRVBXI1cND83t2KquTh3dc4c71zZ/38zQphrABKmXkkC1rXpitqPOTPFPtytWaKRJLduFMYhCLrIlwDzRy1ZY6zZ3Ssd3rB0+vWAf6sgThJ2kmE8ZBfVFjTfOzEI6uOauvalI36pQZVeH5zdxONoB3mTB3jKLWQLp8s6Kq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkXrs+By6q6HKyYSKgw6vYCQ83TRq8TtvMvoJJ1hhaA=;
 b=VhGAHwAyiEwNL7oBs6KESl13FmUYCYlnF4RYpSJVFY1lE9ruZcFp6pIHfKDATJM+e3QYijI16AmtPJxXrbbquUTVnYj9J1mAA02I3UOdjz5P6aZYJA9azZUxlGY0ZjogoGjFsyq84CfiZrHl7PO2pIF9XqrqxdF3p+fV0NYDZAFXgniLNv9iKAb73QMbqVACguJXz7pD3Gqbd2zeZrCYEdYNm/NWrOcM6PD6biANtZt31oCbqgEfXpN60FiXpZvu3aaUTQoXwAAsOrlrbCvaUgFb+CA3ppAs3lYbnAPcKzPrNm/C5Ao/eTBQnpUvLfJ0flgkbDx5JAJJUDonut32yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkXrs+By6q6HKyYSKgw6vYCQ83TRq8TtvMvoJJ1hhaA=;
 b=Ls9kCXKTos6acmQ/b6IYXX2S0vEY4C/ocUaK24BXO7bwZG19Q1EUpzbNTPMrk7GbSPPTHuDiZho2Rd+WkZMwUBsUuKxG3Ae32ng6LLm16l3Iqh8tW2hJcvbtNw5TmykiwWz2VGmXUXjm+IEsRfWnFI/QGLKPmMH7jOn6ltjQw0g=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 03:18:02 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece%9]) with mapi id 15.20.6064.031; Fri, 10 Feb 2023
 03:18:02 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Thread-Topic: [PATCH v2] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Thread-Index: AQHZPE5HD560lNuH8kuMth8tvDb+dK7Hg8Hg
Date: Fri, 10 Feb 2023 03:18:02 +0000
Message-ID: <CY5PR12MB63691FF7633EE23D5CBFD245C1DE9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230209061732.1718695-1-ruili.ji@amd.com>
In-Reply-To: <20230209061732.1718695-1-ruili.ji@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-10T03:18:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=46bb321a-8087-4fae-87cb-b46776e09ad7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-10T03:18:00Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e77f671b-558f-477d-92e7-59cae3d38164
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH2PR12MB4309:EE_
x-ms-office365-filtering-correlation-id: f11b8f4e-b7f8-4cbe-e11f-08db0b156b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iS73IiznU/a6zbtI1+8xk7WHs63zPVnV00cxETSh+zUC5NgwoOHOfCyQ6T1zuVMbxNGNogI8nu8rRihaupAe9W0vs+EMU8Pnf2e+4OstsR+hdjRo0hTSWwoZQGG8371mri5Az+IGd6JRR08WYmotzSSLVLOa+CVxgo2yF0wq1fxRdtW9lV8c+nTjGXWbSmYMwcGdxLC7uWyLgMwN49TZmei3CA6qp94q4Pv+ruQjo86+Tc80HtNE0rvnMQ39t/YLHy6eAl21bnHMlN64KZcQETYaZcjL2LYLjZCCSDH0qZs16+nkR26TrULyAWXcIPqLIfZEJRtO1aoxsl/vp6OtlgErKWjmS8TNRgMQxvtJl35LwBXqCHE3ElAHkwFXa7lYbEOxKsHC82M35o/uBBBf5EFYOtDJGSsQykPvzxE1BPgQf2bfpt4ESjfA8F7HocvRSaElpxLfUrAGtFB00B2t4x2qpC/BBb7lTJmBA2ivTmBm0a7wCQ9a7UQoVz5HDCJfZ83ojkBvMsZrWJ5V+EnN8GPien62bddWkN4SO4e/uNCY/GRMEKdv7ZdLKTKuEGTxNPAlAuDObvF27RLJunnWRay3tQNF8o+MgEvDK/j4JUieG5+vD4nP8gm/jgCNnUg6V0LdJ9BsXX1ulNqceNhm+ugnD6gcoJTiePZ0YlcplxTuerGb0La0UPwNnkq2OZblreNiHaYRKPBYwKXa/H0KzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(54906003)(110136005)(8936002)(4326008)(76116006)(316002)(8676002)(41300700001)(52536014)(66946007)(66476007)(64756008)(66446008)(66556008)(38070700005)(86362001)(33656002)(122000001)(38100700002)(186003)(9686003)(26005)(53546011)(6506007)(66899018)(71200400001)(478600001)(7696005)(5660300002)(2906002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92uyJVn2M3VZKU9O2oKlUaCs0qnKebJbJAZGoiaCTzlJWN077P4yR970AC3v?=
 =?us-ascii?Q?MVpaCU+05g9IrUSmsIF1vNEFTvtN3IdXPIoyoqU6uhcLQYCJBfKIXYNwNItp?=
 =?us-ascii?Q?HraAZMDhCZ5vR+BS6Eth5Jyz2AlZ8am5lJlFRxykVpB16PdVUEdnicn4Vi46?=
 =?us-ascii?Q?Jnrpy5dgnZW3Mk9sC515ggrkPFViJx/sa6tJQGa+sjapQWFeI2LLvYKQyDUY?=
 =?us-ascii?Q?Dl4pI7IT71lLr7jasQ2tuhNqpvSPI2iYmANYXJnjMiAMxn3xcQBgVkS6a/XJ?=
 =?us-ascii?Q?y/9qlLez2TH/mDvJW39n+mt3S06/Rdchh+bBC69HidUHWNYMXQw5qjzv12R8?=
 =?us-ascii?Q?66zI3tqJaHXjhyHFKQGJbB7gVEJk/jnWOZ0Vgav+kg7aSQzinz27qMFNjUn7?=
 =?us-ascii?Q?RArnE668HhyLY7l6Ekp9vGb/5+enUjtspegXe/6XDLRs7g1B5oxRkJpBAXvD?=
 =?us-ascii?Q?7/nGEr4Umio4A6e4qUq6OUCNdK2woH9tCrYMHbZlHEey7/5qmL+39UHpVUSG?=
 =?us-ascii?Q?XuHebLtxvbBzU4dAH4WjzjO1vsovMyaOuyXK4AUrM1PjUAT18x1c9DPVd4z9?=
 =?us-ascii?Q?dO4up//Y9CEuxJ1dlJXvxMAJ2PeyU/fgBELBbC/BETeh6Reyn7r/sdBxV/B0?=
 =?us-ascii?Q?1xLHnP0D6PhtAuIV/d1zWM8CVZ4rvIJCPe7YrwbGO5IsVXYRPaXLgYf49f0q?=
 =?us-ascii?Q?I4xMUpF8siY4U1gf7xucKbIJnJlkEYVD2RY3deQ7pDIx66FVfOPG4OgQQ4CV?=
 =?us-ascii?Q?EpGJh0d2WjLDOG/Gkl1lxZLODIVFZOozcUlPbF0QC/Z1yrnI6+/dI+4e6jEh?=
 =?us-ascii?Q?GjchlzlIcdwHKDp61oazby61arddzXSFiexQQ7r/+PAG2h+Brov4jWFBA4yT?=
 =?us-ascii?Q?PMioFxqY+sMtYxPrCEYlQhmHmcahTdGgonJWL4AR/bIQS+7cWA7Nt9uCBk9t?=
 =?us-ascii?Q?V0RnVyvI0H3sdEAsRC32n+pc+F/lA1bWRFHKuRcjApCXXOYOAtehwcRl1xCY?=
 =?us-ascii?Q?8Up5QQ7hojvlRYG/J/JK7N+YS3G4Sl8cb0WDZzBSLc4brr1Klm7y8VJgTui5?=
 =?us-ascii?Q?Nc236LUc5WVoZd5U7W2OAbunWU3mP6C7xGrcRbYPjndkJPnvOn6Xlaxi72IN?=
 =?us-ascii?Q?rWgmhzrnaIM+gQIlIGNPt6pZSi9BsOVKj0Q/JxzgGT9F3WrV4yg5Ubg2RxXD?=
 =?us-ascii?Q?2FWlQkkUUWQRBvxknX//DpwHdUpF+Ss/UakPzgPr79Wjsr2ot8o+uFG/cS2S?=
 =?us-ascii?Q?9HI9KmnFjWUqXXddJJOaooBzeWuY1Yw44fa/urG21TasCEc2wwcdDQxcS5YV?=
 =?us-ascii?Q?0gHYb+6OJ+q1mbRuGWh9iAO008O1D2m5kH/PK56lxKGWnNuQfGogKrVqg7Vd?=
 =?us-ascii?Q?O8ChZhqX7AClsHmlNDpDXzyP52d5LgAlhtM26RO0JwZKl0mQQ6XEhAFT7UEk?=
 =?us-ascii?Q?655xTNOai7nzWr+HrxEtULzV91/cO6G3GGDQAYxjagSljdQez+Chae1p5QpG?=
 =?us-ascii?Q?ECFQYDMgsaGKvB6bARoAFQ3CIFx2bmaz2FYEcVxfTb4oNEWVxVlRxZendD55?=
 =?us-ascii?Q?S1sgutvW0qMVLsNnVE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b8f4e-b7f8-4cbe-e11f-08db0b156b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 03:18:02.3787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aOTJElIcSFTF961fg8rMhOWXdXTfFfUmUZVbopnDo4ZIr4AyrfDZjwo89oylCoo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ji, Ruili <Ruili.Ji@amd.com>=20
Sent: Thursday, February 9, 2023 2:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan <Yifan1.Zha=
ng@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
Subject: [PATCH v2] drm/amdkfd: To fix sdma page fault issue for GC 11.x

From: Ruili Ji <ruiliji2@amd.com>

For the MQD memory, KMD would always allocate 4K memory, and mes scheduler =
would write to the end of MQD for unmap flag.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  5 +++--  drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c06ada0844ba..7a95698d83f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2373,7 +2373,7 @@ struct device_queue_manager *device_queue_manager_ini=
t(struct kfd_dev *dev)
 	if (init_mqd_managers(dqm))
 		goto out_free;
=20
-	if (allocate_hiq_sdma_mqd(dqm)) {
+	if (!dev->shared_resources.enable_mes && allocate_hiq_sdma_mqd(dqm)) {
 		pr_err("Failed to allocate hiq sdma mqd trunk buffer\n");
 		goto out_free;
 	}
@@ -2397,7 +2397,8 @@ static void deallocate_hiq_sdma_mqd(struct kfd_dev *d=
ev,  void device_queue_manager_uninit(struct device_queue_manager *dqm)  {
 	dqm->ops.uninitialize(dqm);
-	deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
+	if (!dqm->dev->shared_resources.enable_mes)
+		deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
 	kfree(dqm);
 }
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4f6390f3236e..4a9af800b1f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -308,11 +308,16 @@ static void init_mqd_sdma(struct mqd_manager *mm, voi=
d **mqd,
 		struct queue_properties *q)
 {
 	struct v11_sdma_mqd *m;
+	int size;
=20
 	m =3D (struct v11_sdma_mqd *) mqd_mem_obj->cpu_ptr;
=20
-	memset(m, 0, sizeof(struct v11_sdma_mqd));
+	if (mm->dev->shared_resources.enable_mes)
+		size =3D PAGE_SIZE;
+	else
+		size =3D sizeof(struct v11_sdma_mqd);
=20
+	memset(m, 0, size);
 	*mqd =3D m;
 	if (gart_addr)
 		*gart_addr =3D mqd_mem_obj->gpu_addr;
@@ -443,6 +448,14 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_=
TYPE type,  #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;  #endif
+		/*
+		 * To allocate SDMA MQDs by generic functions
+		 * when MES is enabled.
+		 */
+		if (dev->shared_resources.enable_mes) {
+			mqd->allocate_mqd =3D allocate_mqd;
+			mqd->free_mqd =3D kfd_free_mqd_cp;
+		}
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		break;
 	default:
--
2.25.1
