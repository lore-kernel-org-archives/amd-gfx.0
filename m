Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F87FC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Dec 2022 10:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0547010E09C;
	Sun, 25 Dec 2022 10:07:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03D110E09C
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Dec 2022 10:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILzMT2YO25qOM6vYkm57VAGC6zYY3y159WJRDiZzFXZrkjUEV5K27/hMHL/cpq5n/VgCBYdCvABJHnz4+fFlgo7M0WVjxEfo1vgvEr5xqmc+4b7RjM3mbyywWMYiLfjyMy8ygackDlvszsH1yH1iQa8+9OOY3GPSA94sSxDu3/ad+rT2G4HBsEN3k8E1D2eupNVwBUz+KAwQ/Hxgpg+G1C0ZZia8gmosSpEy52lMwzIoMbfLeBqVaEqcNA6bkTYkQSy7emNRk+8e/dA6QTxJhtgM1b80YzV7cBVv7roNvpfhHt02d8/C4HugGKKiVl1lz2JD5sa0yYIH7Ann8czINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAwUWQT82Z091zswMdL4C0VwT+aq9HhyF/GNCBJvzm4=;
 b=Yd1BOFEVogcWEgyLfWZsLyREeEpYgpo8n8aIFktgwiREgMLTm4+XaACW0I4e0DJKdtOZFYSSsg9CcU1qyKcsx1HnNH25a1IkbDuv/ebf+D9PdrBlyewWxZIGxZefB4QShblfSg6dHSJUrCPIRezk7uwaWhQ+/9cbV6RXQjONZOPgIyBA5snlvNGJVKshGNIOgElDU1dmG2/1uUj3Z1WNIjuYv3og2jcwKO+q/bkRtCt4u5gEP9X3dlzFN33k+b/jRll2B3jUCb5q/VRmBCoGfTrkeaP5wbYEQZ5BgEk7/XQYusnpvinnW0xWpwDSViVsM1400dAbNUTEWlrpdaRcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAwUWQT82Z091zswMdL4C0VwT+aq9HhyF/GNCBJvzm4=;
 b=5M6rrLSkZ988X8LO9S0+6lWPFKFaKPUeAxek3ZaNoRoftRSEWcgWp42vSww0ZPselBmw6je7IoAWyG0lFzf23KwmfZLjNrG8j0Ruy7RnExMoJXrkkq0kSm3xm+yNjC0V5yIDoGqckaDOQ0Jmgd9NC4EYHGkKutQF8rF6UDNIYuU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 10:07:07 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%9]) with mapi id 15.20.5944.014; Sun, 25 Dec 2022
 10:07:07 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 7/7] drm/amdgpu: Secure semaphore for usermode queue
Thread-Topic: [RFC 7/7] drm/amdgpu: Secure semaphore for usermode queue
Thread-Index: AQHZFwYIEr/J49F5sESpv+mrhyLW1a5+YWMA
Date: Sun, 25 Dec 2022 10:07:07 +0000
Message-ID: <CY5PR12MB63697DDDABCFB60476254AA6C1EF9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-8-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-8-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-25T10:00:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2c68c4dc-d51a-4a19-9b60-b97062e4cc2b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-25T10:07:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5044e8e7-9a07-4ba6-87e8-52d6b9924ae7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MN0PR12MB6367:EE_
x-ms-office365-filtering-correlation-id: d68f165f-0806-4317-a9c2-08dae65fc7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfmHUxT70yXSKiBZK4HXfpkrVcfg0iKbpcosx2y/Fbr6qo08cGBH+8R0IxXrJv304OAlP/DCZd7ztsWvemaZfDzVRHU+M6OtZgb12zWB9ESebiaa6m3hvW55iOhmIazwm5mf5GIRSz2EAqhmKqY9bV0Y8mVZtX+FQoFITJjGFEvR0mAxFd1Wj9ScOsy+ofSftQimpkOw3lwRg6G+jCUvJEeIIWYMHeaFbb195Ke7GJwZqK4+u/k2+fLzWcTHgOXMIUpUUNQ2ATF+IEhO9ZXVE0sMJx6CIH17FuMITu+Po7x9i+VoixkZsr+yWjEZqiD4wKFT8Ia9XrQSbws1WVhi/1yEZq/V3ScoMIr71y4UfyjciaWuKcQR1zSudpnjnb+L0vn2mkenWJL97TC9yfXF5IYnETlKUvAMYUzAqh3XzcjY01AjCTHd3gxZRAOGW0VhDS6m+WmLXuQUsVj/ZAs24kK9+PYOoOZsR18lzWPr05PiRcCk94PehuRtaGwD+be4eQ78Z9c/62zQZe7sc2D2QoxlGDawVFLbQXgeRVXBfPX64H7fbOyiFmT0U+QvEdOBL9TFfh+BIl1IAGiRR/Rx6ve1/5lKDV3shDBjMqJxrONlDzkneEJOGxw22jqa4qkEYEy5GD+1lm4fpWoLaRxNG+2b476SPQ3JnFboJ7dQ8TQqYazALAjT6vm2YRQ71Ogi0X4Xg2nSFrL+M/UUnJBHlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(55016003)(7696005)(71200400001)(478600001)(8936002)(52536014)(5660300002)(30864003)(2906002)(38070700005)(122000001)(38100700002)(83380400001)(33656002)(110136005)(316002)(86362001)(41300700001)(54906003)(66476007)(64756008)(66556008)(66446008)(8676002)(76116006)(4326008)(66899015)(66946007)(9686003)(26005)(6506007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UGkRplxWRTbeYVLKUNr4rb2vchwUCv4cM7n8n11IGWOlcn9xOCd69j+gjiCL?=
 =?us-ascii?Q?/T3YBGL8CoW1I8RJ+LtMWh1NCKqCBq5CjhgN+hzY291hxIslbrcFnOAA1DB8?=
 =?us-ascii?Q?aTqA9WgcLoQbVGlxlvlos2EwbHaNCwYDp9NugvU38dUoJ2uNBjOFqUi+/6ay?=
 =?us-ascii?Q?/atCtpmgYU2EalXog0LaGgQJT7RInr/P2nuw4hym0KzD8pMBpvHZVhwJSP7p?=
 =?us-ascii?Q?9RQ5n3lB58yyPJONZTMotyIvz7uDzyQUI2fB6zxlCr9CYvYYsN8oAImWTaEe?=
 =?us-ascii?Q?3021ta0Yg/MaWMuypN4G5c+ugcMDpLCATXRQ7thipW/0ue0OnYOs+RDmdbGL?=
 =?us-ascii?Q?O/1H75Ov27PVv59t3nvqfMi/k0T4PRhA+F5Ot9KiYvbpoaPMMMX+GXD69I1o?=
 =?us-ascii?Q?vjhhxS+CcX+VnCMcmwJ+dDHJjOghO7JYhmzVvcoyZszXRmQ6GUA7fpMXHUcc?=
 =?us-ascii?Q?ZW6EjHdF2aAWJT/aBDRCWcSHDawsYSdUBVciiqWJ+m7RqvwoqNXxZjT03IPg?=
 =?us-ascii?Q?e1iMZlColPR3qAXZzW6cETu+gITz4OJO9CdHhTqjWaJ5dU/nZrPZfUe6YEqJ?=
 =?us-ascii?Q?wIh/b5H1WX5Dc6B2sRed3uEuaC3ewG9kc7TBEaJ0lUGhHwwDYMZooyWXgT1e?=
 =?us-ascii?Q?spNerhTotl77x7r3Gn7ZQ040A1c9gvaMssZzS3RXyhLZReBEpAfjeMtsx2DQ?=
 =?us-ascii?Q?0DVTo9bpWhVYx75NEGlde0cJDNSfwmtMXv15WqCTWhehNznGyiWDD0hw8ZW7?=
 =?us-ascii?Q?I636DyF8D0jum1B5EeJ4oSSPuhFkU3eHiLw3T7L5e8dRS/dRHMUblK+mbe6r?=
 =?us-ascii?Q?ZDCQSDh4qIuKW4zRAo1ai+V9e04jJT9k8VDqAY/9h7aFyl0wRnwnbj90C86/?=
 =?us-ascii?Q?5YYz/h4Ih03kWLCYFAxbqFRXTAEWP+we/9FaB9XN9fWgdebbEWRrv0wgg8Ez?=
 =?us-ascii?Q?PDbCv+FX/D7JMZtxeliZ5H76Q4zDccoUdP+etSfYBDX2wbvG6wLiZ6bKqBgI?=
 =?us-ascii?Q?UoVpaoGZA80jZ03KZTsvWJCRrusEq47OX50rKf1vgNin3HBGt5zG1qs6YkmQ?=
 =?us-ascii?Q?+LB/erQn4SroSgFMGMXdCx7XNcn2nA5Cd73wms4PkzAkBcG6tgsAURtzzd79?=
 =?us-ascii?Q?v5acZYeSBflKbODFC4eQxqh73WIQ/1l6CsBiZ96OGq7td+Kw/sikKJTxueti?=
 =?us-ascii?Q?dWs77O36ELpsUpPz6OVbdhkTxh2WlzN/zKqKNfGb+sWX6iLPtQ8sAFwJTegy?=
 =?us-ascii?Q?sLuy7IiytC4DCUt9nmlznUJE9LRJExQANBT5VTW1i+HnZp5rCjE+JIthwnJi?=
 =?us-ascii?Q?PcO4vZhO+wb8XIlQlX9bUuPqkVWhiLEUOYLSVP1PNaT3Z8oiNIa5tI2I5Upp?=
 =?us-ascii?Q?SnBVa7OpFZHILzJX0N1NK5Ed6VJnvPMB4oAOK9Yh+wUD3AlGg1BGHf4dYILR?=
 =?us-ascii?Q?3NRs2V4cIguOdRUTWLH/jXfQNbK7CGPsiLUHFCEqw8DT9vR9InSeo8bHvWn8?=
 =?us-ascii?Q?LZrhjKck/Ve8IyjgX2RWKhOAl+L3yBc15WBFlx8Iv4nyJD9UhpmFeWF6yDyM?=
 =?us-ascii?Q?Ih8kiNrRbQAHT7ebHmI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68f165f-0806-4317-a9c2-08dae65fc7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2022 10:07:07.4934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clIr4aeYXmYSiFYkrYoc9gWCnXVLck6gqi90Lh7qu8Ps0jhotmWVJNwm3KLRBldJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>

This is a WIP patch, which adds an kernel implementation of secure semaphor=
e for the usermode queues. The UAPI for the same is yet to be implemented.

The idea is to create a RO page and map it to each process requesting a use=
r mode queue, and give them a qnique offset in the page, which can be polle=
d (like wait_mem) for sync.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Shamra <shashank.sharma@amd.com>

Signed-off-by: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   7 +-
 .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++++++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  10 +
 .../amd/include/amdgpu_usermode_queue_mqd.h   |   4 +-
 6 files changed, 272 insertions(+), 3 deletions(-)  create mode 100644 dri=
vers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index e2a34ee57bfb..daec7bb9ab3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -211,6 +211,7 @@ amdgpu-y +=3D amdgpu_amdkfd.o
=20
 # add usermode queue
 amdgpu-y +=3D amdgpu_userqueue.o
+amdgpu-y +=3D amdgpu_userqueue_secure_sem.o
=20
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH :=3D ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 4b566fcfca18..7325c01efc90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -749,9 +749,17 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
=20
+struct amdgpu_userq_sec_sem {
+	struct amdgpu_bo *sem_obj;
+	u64 gpu_addr;
+	u32 num_sem;
+	unsigned long used[DIV_ROUND_UP(64, BITS_PER_LONG)]; };
+
 struct amdgpu_userq_globals {
 	struct ida ida;
 	struct mutex userq_mutex;
+	struct amdgpu_userq_sec_sem sem;
 };
=20
 #define AMDGPU_RESET_MAGIC_NUM 64
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userqueue.c
index b164e24247ca..2af634bbe3dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -261,6 +261,10 @@ amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev,=
 struct amdgpu_usermode_qu
     /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
     mqd->cp_gfx_hqd_rptr =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
=20
+    /* Setup semaphore fence address */
+    mqd->fenceaddress_lo =3D queue->sem_data.sem_gpu_addr & 0xFFFFFFFC;
+    mqd->fenceaddress_lo =3D upper_32_bits(queue->sem_data.sem_gpu_addr)=20
+ & 0xFFFF;
+

It should be mqd-> fenceaddress_high =3D upper_32_bits(queue->sem_data.sem_=
gpu_addr)  & 0xFFFF

     /* activate the queue */
     mqd->cp_gfx_hqd_active =3D 1;
 }
@@ -472,10 +476,11 @@ int amdgpu_userqueue_init(struct amdgpu_device *adev)
     struct amdgpu_userq_globals *uqg =3D &adev->userq;
=20
     mutex_init(&uqg->userq_mutex);
+    amdgpu_userqueue_sec_sem_init(adev);
     return 0;
 }
=20
 void amdgpu_userqueue_fini(struct amdgpu_device *adev)  {
-
+    amdgpu_userqueue_sec_sem_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
new file mode 100644
index 000000000000..6e6a7d62a300
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
@@ -0,0 +1,245 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person=20
+obtaining a
+ * copy of this software and associated documentation files (the=20
+"Software"),
+ * to deal in the Software without restriction, including without=20
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,=20
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom=20
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be=20
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,=20
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF=20
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=20
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,=20
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR=20
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=20
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_mes.h"
+#include "amdgpu_usermode_queue.h"
+#include "amdgpu_usermode_queue_mqd.h"
+
+static int amdgpu_userqueue_sem_addr_unmap(struct amdgpu_device *adev,
+					   struct amdgpu_usermode_queue *q) {
+    struct amdgpu_userq_sec_sem_data *sem_bo_data =3D &q->sem_data;
+    struct amdgpu_bo_va *bo_va =3D sem_bo_data->sem_data_va;
+    struct amdgpu_vm *vm =3D bo_va->base.vm;
+    struct amdgpu_bo *bo =3D adev->userq.sem.sem_obj;
+    struct amdgpu_bo_list_entry vm_pd;
+    struct list_head list, duplicates;
+    struct dma_fence *fence =3D NULL;
+    struct ttm_validate_buffer tv;
+    struct ww_acquire_ctx ticket;
+    long r =3D 0;
+
+    INIT_LIST_HEAD(&list);
+    INIT_LIST_HEAD(&duplicates);
+
+    tv.bo =3D &bo->tbo;
+    tv.num_shared =3D 2;
+    list_add(&tv.head, &list);
+
+    amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
+
+    r =3D ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
+    if (r) {
+        DRM_ERROR("leaking bo va because we fail to reserve bo (%ld)\n", r=
);
+        return r;
+    }
+
+    amdgpu_vm_bo_del(adev, bo_va);
+    if (!amdgpu_vm_ready(vm))
+        goto out_unlock;
+
+    r =3D dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEE=
P, &fence);
+    if (r)
+        goto out_unlock;
+    if (fence) {
+        amdgpu_bo_fence(bo, fence, true);
+        fence =3D NULL;
+    }
+
+    r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
+    if (r || !fence)
+        goto out_unlock;
+
+    dma_fence_wait(fence, false);
+    amdgpu_bo_fence(bo, fence, true);
+    dma_fence_put(fence);
+
+out_unlock:
+    if (unlikely(r < 0))
+        DRM_ERROR("failed to clear page tables (%ld)\n", r);
+    ttm_eu_backoff_reservation(&ticket, &list);
+
+    return r;
+}
+
+static u64 amdgpu_sem_bo_vaddr(struct amdgpu_device *adev) {
+       u64 addr =3D AMDGPU_VA_RESERVED_SIZE;
+
+       /* TODO:Find va address for sem bo mapping */
+       return addr;
+}
+
+static int amdgpu_userqueue_sem_addr_map(struct amdgpu_device *adev,
+                                        struct amdgpu_usermode_queue=20
+*q) {
+    struct amdgpu_userq_sec_sem_data *sem_bo_data;
+    struct amdgpu_bo *sem_obj =3D adev->userq.sem.sem_obj;
+    struct ttm_validate_buffer csa_tv;
+    struct amdgpu_bo_list_entry pd;
+    struct ww_acquire_ctx ticket;
+    struct amdgpu_vm *vm =3D q->vm;
+    struct amdgpu_bo_va *bo_va;
+    struct amdgpu_sync sync;
+    struct list_head list;
+    int r;
+
+    amdgpu_sync_create(&sync);
+    INIT_LIST_HEAD(&list);
+    INIT_LIST_HEAD(&csa_tv.head);
+
+    sem_bo_data =3D &q->sem_data;
+
+    csa_tv.bo =3D &sem_obj->tbo;
+    csa_tv.num_shared =3D 1;
+
+    list_add(&csa_tv.head, &list);
+    amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+    r =3D ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+    if (r) {
+        DRM_ERROR("failed to reserve userqueue sec sem object BO: err=3D%d=
\n", r);
+        return r;
+    }
+
+    bo_va =3D amdgpu_vm_bo_add(adev, vm, sem_obj);
+    if (!bo_va) {
+        ttm_eu_backoff_reservation(&ticket, &list);
+        DRM_ERROR("failed to create bo_va for userqueue sec sem object BO\=
n");
+        return -ENOMEM;
+    }
+
+    sem_bo_data->sem_gpu_addr =3D amdgpu_sem_bo_vaddr(adev);
+    r =3D amdgpu_vm_bo_map(adev, bo_va, sem_bo_data->sem_gpu_addr, 0,
+                        AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64),
+                        AMDGPU_PTE_READABLE | AMDGPU_PTE_READABLE);
+
+    if (r) {
+        DRM_ERROR("failed to do bo_map on sec sem object BO, err=3D%d\n", =
r);
+        goto error;
+    }
+
+    r =3D amdgpu_vm_bo_update(adev, bo_va, false);
+    if (r) {
+        DRM_ERROR("failed to do vm_bo_update on sec sem object BO\n");
+        goto error;
+    }
+    amdgpu_sync_fence(&sync, bo_va->last_pt_update);
+
+    r =3D amdgpu_vm_update_pdes(adev, vm, false);
+    if (r) {
+        DRM_ERROR("failed to update pdes on sec sem object BO\n");
+        goto error;
+    }
+    amdgpu_sync_fence(&sync, vm->last_update);
+
+    amdgpu_sync_wait(&sync, false);
+    ttm_eu_backoff_reservation(&ticket, &list);
+
+    amdgpu_sync_free(&sync);
+    sem_bo_data->sem_data_va =3D bo_va;
+    return 0;
+
+error:
+    amdgpu_vm_bo_del(adev, bo_va);
+    ttm_eu_backoff_reservation(&ticket, &list);
+    amdgpu_sync_free(&sync);
+    return r;
+}
+
+int amdgpu_userqueue_sec_sem_get(struct amdgpu_device *adev,
+                            struct amdgpu_usermode_queue *q,
+                            u64 *gpu_addr) {
+    unsigned long offset =3D find_first_zero_bit(adev->userq.sem.used, ade=
v->userq.sem.num_sem);
+    u32 sem_offset;
+    int r;
+
+    if (offset < adev->userq.sem.num_sem) {
+        __set_bit(offset, adev->userq.sem.used);
+        sem_offset =3D offset << 6; /* convert to qw offset */
+    } else {
+        return -EINVAL;
+    }
+
+    r =3D amdgpu_userqueue_sem_addr_map(adev, q);
+    if (r) {
+        DRM_ERROR("failed to map sec sem object BO");
+        amdgpu_userqueue_sem_addr_unmap(adev, q);
+        return r;
+    }
+
+    *gpu_addr =3D sem_offset + q->sem_data.sem_gpu_addr;
+
+    return 0;
+}
+
+void amdgpu_userqueue_sec_sem_free(struct amdgpu_device *adev,
+                                struct amdgpu_usermode_queue *q,
+                                u32 sem) {
+    int r;
+
+    r =3D amdgpu_userqueue_sem_addr_unmap(adev, q);
+    if (r)
+        DRM_ERROR("failed to unmap sec sem object BO");
+
+    sem >>=3D 6;
+    if (sem < adev->userq.sem.num_sem)
+        __clear_bit(sem, adev->userq.sem.used); }
+
+int
+amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev) {
+    int r;
+
+    if (adev->userq.sem.sem_obj =3D=3D NULL) {
+        /*
+        * AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64) =3D AMDGPU_MAX_USERQU=
EUE_SEC_SEM
+        * 64bit slots
+        */
+        r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MAX_USERQUEUE_SEC_SEM *=
 sizeof(u64),
+                                    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT, &ade=
v->userq.sem.sem_obj,
+                                    &adev->userq.sem.gpu_addr, NULL);
+        if (r) {
+            DRM_ERROR("Create userqueue SEM bo failed, err %d\n", r);
+            return r;
+        }
+
+        adev->userq.sem.num_sem =3D AMDGPU_MAX_USERQUEUE_SEC_SEM;
+        memset(&adev->userq.sem.used, 0, sizeof(adev->userq.sem.used));
+    }
+
+    return 0;
+}
+
+void
+amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev) {
+    if (adev->userq.sem.sem_obj) {
+        amdgpu_bo_free_kernel(&adev->userq.sem.sem_obj,
+                &adev->userq.sem.gpu_addr,
+                NULL);
+        adev->userq.sem.sem_obj =3D NULL;
+    }
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/=
gpu/drm/amd/include/amdgpu_usermode_queue.h
index 8bf3c0be6937..630d9b5d2423 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
@@ -25,6 +25,12 @@
 #define AMDGPU_USERMODE_QUEUE_H_
=20
 #define AMDGPU_MAX_USERQ 512
+#define AMDGPU_MAX_USERQUEUE_SEC_SEM 64
+
+struct amdgpu_userq_sec_sem_data {
+	u64 sem_gpu_addr;
+	struct amdgpu_bo_va *sem_data_va;
+};
=20
 struct amdgpu_userq_ctx {
 	struct amdgpu_bo *obj;
@@ -52,7 +58,11 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm    	*vm;
 	struct amdgpu_userq_ctx proc_ctx;
 	struct amdgpu_userq_ctx gang_ctx;
+
+	struct amdgpu_userq_sec_sem_data sem_data;
 	struct list_head 	list;
 };
=20
+int amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev); void=20
+amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h b/driv=
ers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
index d0a285708ba5..e0bfb67d91f4 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
@@ -35,8 +35,8 @@ struct amdgpu_usermode_queue_mqd
 	uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
 	uint32_t shadow_initialized; // offset: 6  (0x6)
 	uint32_t ib_vmid; // offset: 7  (0x7)
-	uint32_t reserved_8; // offset: 8  (0x8)
-	uint32_t reserved_9; // offset: 9  (0x9)
+	uint32_t fenceaddress_lo; // offset: 8  (0x8)
+	uint32_t fenceaddress_high; // offset: 9  (0x9)
 	uint32_t reserved_10; // offset: 10  (0xA)
 	uint32_t reserved_11; // offset: 11  (0xB)
 	uint32_t reserved_12; // offset: 12  (0xC)
--
2.34.1
