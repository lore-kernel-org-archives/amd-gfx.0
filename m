Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF3CE79DC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C8410E4BB;
	Wed, 20 Sep 2023 14:47:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B2410E4BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMrpVXWbjb/dZN9ytX5HVJ6S3fVpfb7NmyppFcy4a3L8iLw0+Pkez9/Bl9QEPZAOHjG8zG9N5FjuaNdIgsqRHArpRYtesLRRCDlKAlWgSyqvGoQ+kfp/S0llmrnkvZNzYg2q8i8//ME2sm7bSf8+QBO+pkpexP2sNbxzxnbQCaN60XJl1bHTbMcQEoHXP/0mzCaK9AxWIsGoR9bIaoCmU5T4vmWb0ZJzyslZnqkZmujcPI7M+a639dJ8orrs1dN0vaG7g11+AN0M7CdE+N2g+eUCWQwW+dAoQtUlMuzv5tPw2JW2jFIlbZcEirdJlQzk68UTjwIDH1kB8PO8UCZYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YfrJ145CjDBge4d75dGk0JRgUEr3IL/E89HRRMmdC4=;
 b=edYSU2518nm67MoFJmfuw/F99KS2js+7ic/HkMpbIM3CUpfdoommAt/j027WYkLoydan3YNfHM9KDNaB824xSzK4j98hSB6cV0hqKe8X91OZxUNbE0q4i1CdUJpMKyW5TwGI0Pe0cTyoIa76DMyPjmW90/9KeMzoF4hqHENmwkkyumHM396VIYrPhPPJQoaUyj04iXmeK2g9UxdanuE7ZoyOCQABNzYK1yWmug/Lx+RVT3rOaxCX/ZpXWIrTOZVMdSKWXzBEQC6wE+IRnCOmYf8KPjcEWalLD5B57i1y6RhTNAURalNVcHqL7LU0kqAQEEh7DIFbci6KbZZgGuW3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YfrJ145CjDBge4d75dGk0JRgUEr3IL/E89HRRMmdC4=;
 b=SpeDQFNNMdbj6UaDJNRu66Z5p1VK3X1oTj9VKXQ8E4mPAKIWlu6Id0N7nHiIYNhdfC03mCS1J+G1Rh3zAuOeSLj00hoWBpcIXAkIwOH407DrK2VAJ7YXtc/jm8xVsAFvonFfgbWzPzLgx3WPftn4i0ICfnpg/Q0MOTuH5jQp4OE=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:47:39 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:47:39 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue
Thread-Topic: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue
Thread-Index: AQHZ4m5nn3DiJ53on0u/TwQpmU9PZrAj2WEw
Date: Wed, 20 Sep 2023 14:47:39 +0000
Message-ID: <CY5PR12MB636955AB9DCEEC4F934AB935C1F9A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-4-shashank.sharma@amd.com>
In-Reply-To: <20230908160446.2188-4-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33982da7-8922-4990-b309-0096fc5ee3dd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-20T14:31:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW6PR12MB7069:EE_
x-ms-office365-filtering-correlation-id: 37d3a329-de04-4b35-0051-08dbb9e88982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2lRq2mamT+iRMCAfIk/4MtHX11O+dAIKFXm7nhRz03u9g3rh2pFv7TjB5c/8EhqaQZ217Fv/QKWW0/C3KZdk3l6WAD6XKkHlWiRgtJ+1jJYLuYJ2oNjt5cyiIQaLt8ux1c9ftIqCtnW+pAmUficMdkbtI1PfXnq7JVi+0eM+n4KGA7gyST39nupoDEjlGVlzoLOChzNUKnqOVd6BB8Vp9Q62u4eJOEj/r2xXMgLWzeJAgCQJBCH7lP/ujUoWfJMlzU5IdlVpeXQrisw8rLofiW1P8LRGpObbpK74cgTudAjdFhlgKkmrFbv4XWiQWG5KkZVsS7K1fEGpAy/qjBu6XHYdpjC59qi59jnn7kypXz+UKFBRbtBO36YWR5Zebg/swxtEwNyrkI/GrbIX3zbLHpumiNBcs31rEZ8lkmrH/oMcOdKli9ymxdpHvrEIlEi5VX8z5cEpWlpSuU8BFlL2eaHP3kKka+t5GLRgrHGZZXd/xhWyhKbMk1Yicx+8wAg0m9KWbxsGjf4Bdlvvbzvffogey+Qso9RqlP+HYbkBxGndUA0FQIkRK26jzD13gXygjydYtTorPWzJmIKoc538KFSSdZUeR6GBaDMl0ENvYQp32fx1Jfdh9KGrZ1BTcys
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(1800799009)(186009)(451199024)(64756008)(54906003)(316002)(66946007)(110136005)(66476007)(66556008)(66446008)(26005)(76116006)(83380400001)(122000001)(55016003)(7696005)(71200400001)(6506007)(38070700005)(38100700002)(86362001)(53546011)(33656002)(9686003)(478600001)(2906002)(8676002)(4326008)(8936002)(41300700001)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XONsY86iVhJKyHO9m76OXTOpCiZqUGM0b5S8mO0KLMhvZhrf9aCTl0ExAN5m?=
 =?us-ascii?Q?q1bdGdsLfeVIr4vDgkVh9PDlcO+qKwL4GFRGjeLNZQmOm+KJxRx8sNAzGsdp?=
 =?us-ascii?Q?2VHW/PVAEw0YDSE3sAFBjSJkZx+Q+NqWxHdF72HadTreJ5cGbAjH8mZr5BLc?=
 =?us-ascii?Q?5BV4mMxCgnPnzIx32j3I+yCNfUuyIwIA1v3PUoxpSs+k2A89Rw2mYQJWZ1eR?=
 =?us-ascii?Q?e4yGFjO6Ww7AYDwJWvNKmdGtJ6HvR585cSBoTcHOAaK0ibN9RmratEa8J6H+?=
 =?us-ascii?Q?d5XNnibB2Lqzz0vXr8ndewA3dpXmiDbx8uB97G1bR3AiZROeHLH6VOfoJlDT?=
 =?us-ascii?Q?V8dzkmeTmOPfiTG9YYeDcipyIS/tQqxyJhYsPnneOQdI0tR0h0UeoirxOc7Y?=
 =?us-ascii?Q?Lc+TaogEBeyilbwJehFZyIqrjQYL0FTI/lNAPXHcukBMmCm367WnC1eb+gAU?=
 =?us-ascii?Q?XfbBnPHVEri2yeAO12hHJOLeOhuTAR3yn4PXFhrovbc4LRJHffXjAtAimQFP?=
 =?us-ascii?Q?3Ag3I8FIVY30KapbmQSMTLzBMcGDd9hLrqxIrGXeFXy/ZF8nsHdXHCDrNRH0?=
 =?us-ascii?Q?A+qFNgPTH9/6RRB9Yhf+jtzftoMPywcGzQOQBKZipBWY1+moAlX6A6iyoLXD?=
 =?us-ascii?Q?pPT7o+OSc6XgcduVeGos+1qOyuTCXV4DctkO/mPNA7gZ4B1OnKFHOZ78xvQs?=
 =?us-ascii?Q?9NZXb5DCOPAm1djOMLGBCIB58Un6NNbfPZZJCBge0b0ayOkvTXH79MWK63I5?=
 =?us-ascii?Q?Q+o7aXA6cpULZqCME62DIDgjkTsZjCb3EMorv2d2fpbNdlJPNoznrtOPXKFP?=
 =?us-ascii?Q?rj0gqjIIeyHNbwbj73i/EWPUsR4ImQfJcRf4HKsvK6avuETEHwgEIkCXo5rj?=
 =?us-ascii?Q?Ckgcf0b/GqpAFxG8Uy67doi2a04ngV7N+AJl5yImAzEe7W7W/6ZRm/R3Bv5X?=
 =?us-ascii?Q?WAk6TZ3kpxGPCzLoFwh8XVJms+tQpbXry1n5xLUbw4qcAdsKLK2f6nF6lpNY?=
 =?us-ascii?Q?bWMF+apCtPp0mb7DKUxgvsNLCZkXsnwx2qAx8uqY9+T3TBjeEtzIhrJZhzsC?=
 =?us-ascii?Q?LgVQZzbEIIzyT9wyxYjE9v5lxYnN3b9UAXahrBSYJE2Br0QaqngpfsiPah8J?=
 =?us-ascii?Q?HgF7Hm/4A6dgspV/YRhk1+5bqBYGtr+JE62WWuSf2ssRKO9j6ISgsccKSWAA?=
 =?us-ascii?Q?iN8k9XtyRsO7D0/ICrVur0mywMlbDJ49cDqrFAxjv3Re7LuBapILz1yySCYO?=
 =?us-ascii?Q?im5KbWeugtczXnAXqBuX6UIGHwu3DqdqQG9ONw6dZMhtMr/QJJPis3wCDSvd?=
 =?us-ascii?Q?3BnJ7XlTM/NpD+sJpRV4VSFa6GbL+QNSVWYy+BJtN/Ts3TbBEEZ+AAWhNh8/?=
 =?us-ascii?Q?CO4hfCHPoTWTrpDngZ12MfpeTo/U5QoWoFutpKEwDlZgM+3RQ3zrq6rvg2cw?=
 =?us-ascii?Q?kElJdC6K+VIrtVhZgLMKFndUWEnEBkAs7tQPDrIIOiAH7a0YkkzvXDjkXiLz?=
 =?us-ascii?Q?ej5s/nrs/+oWkKGKcbcJsgBPIqQlOjjyILHmkd48bHbaG3FaA7cQHKJ/Py6l?=
 =?us-ascii?Q?qD2xd4rKO1bQWP+xms4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3a329-de04-4b35-0051-08dbb9e88982
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 14:47:39.3398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPHPJZXt/BS7W6YAPZjQAQGRNJNHv3AGKS+oxB+3qIpsYTL4h/exZtJeTMrp1tDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shashank=
 Sharma
Sent: Saturday, September 9, 2023 12:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Sharma, Shasha=
nk <Shashank.Sharma@amd.com>
Subject: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue

This patch adds:
- A new IOCTL function to create and destroy
- A new structure to keep all the user queue data in one place.
- A function to generate unique index for the queue.

V1: Worked on review comments from RFC patch series:
  - Alex: Keep a list of queues, instead of single queue per process.
  - Christian: Use the queue manager instead of global ptrs,
           Don't keep the queue structure in amdgpu_ctx

V2: Worked on review comments:
 - Christian:
   - Formatting of text
   - There is no need for queuing of userqueues, with idr in place
 - Alex:
   - Remove use_doorbell, its unnecessary
   - Reuse amdgpu_mqd_props for saving mqd fields

 - Code formatting and re-arrangement

V3:
 - Integration with doorbell manager

V4:
 - Accommodate MQD union related changes in UAPI (Alex)
 - Do not set the queue size twice (Bas)

V5:
- Remove wrapper functions for queue indexing (Christian)
- Do not save the queue id/idr in queue itself (Christian)
- Move the idr allocation in the IP independent generic space
  (Christian)

V6:
- Check the validity of input IP type (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 116 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 2a89e303c3db..214a66b33dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2830,6 +2830,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D {
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_=
RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_=
RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
+       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl,
+DRM_AUTH|DRM_RENDER_ALLOW),
 };

 static const struct drm_driver amdgpu_kms_driver =3D { diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu=
_userqueue.c
index effc0c7c02cf..44769423ba30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,122 @@
  */

 #include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_userqueue.h"
+
+static struct amdgpu_usermode_queue *
+amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid) {
+       return idr_find(&uq_mgr->userq_idr, qid); }
+
+static int
+amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id) {
+       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
+       const struct amdgpu_userq_funcs *uq_funcs;
+       struct amdgpu_usermode_queue *queue;
+
+       mutex_lock(&uq_mgr->userq_mutex);
+
+       queue =3D amdgpu_userqueue_find(uq_mgr, queue_id);
+       if (!queue) {
+               DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
+               mutex_unlock(&uq_mgr->userq_mutex);
+               return -EINVAL;
+       }
+       uq_funcs =3D uq_mgr->userq_funcs[queue->queue_type];
+       uq_funcs->mqd_destroy(uq_mgr, queue);
+       idr_remove(&uq_mgr->userq_idr, queue_id);
+       kfree(queue);
+
+       mutex_unlock(&uq_mgr->userq_mutex);
+       return 0;
+}
+
+static int
+amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
+*args) {
+       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
+       const struct amdgpu_userq_funcs *uq_funcs;
+       struct amdgpu_usermode_queue *queue;
+       int qid, r =3D 0;
+
+       /* Usermode queues are only supported for GFX/SDMA engines as of no=
w */
+       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type !=3D=
 AMDGPU_HW_IP_DMA) {
+               DRM_ERROR("Usermode queue doesn't support IP type %u\n", ar=
gs->in.ip_type);
+               return -EINVAL;
+       }
+
+       mutex_lock(&uq_mgr->userq_mutex);
+
+       uq_funcs =3D uq_mgr->userq_funcs[args->in.ip_type];
+       if (!uq_funcs) {
+               DRM_ERROR("Usermode queue is not supported for this IP (%u)=
\n", args->in.ip_type);
+               r =3D -EINVAL;
+               goto unlock;
+       }
+
+       queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL)=
;
+       if (!queue) {
+               DRM_ERROR("Failed to allocate memory for queue\n");
+               r =3D -ENOMEM;
+               goto unlock;
+       }
+       queue->doorbell_handle =3D args->in.doorbell_handle;
+       queue->doorbell_index =3D args->in.doorbell_offset;
+       queue->queue_type =3D args->in.ip_type;
+       queue->flags =3D args->in.flags;
+       queue->vm =3D &fpriv->vm;
+
+       r =3D uq_funcs->mqd_create(uq_mgr, &args->in, queue);
+       if (r) {
+               DRM_ERROR("Failed to create Queue\n");
+               goto unlock;

Should kfree(queue) in this path to avoid memory leak

+       }
+
+       qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_CO=
UNT, GFP_KERNEL);
+       if (qid < 0) {
+               DRM_ERROR("Failed to allocate a queue id\n");
+               uq_funcs->mqd_destroy(uq_mgr, queue);
+               r =3D -ENOMEM;
+               goto unlock;

Should kfree(queue)  in this path to avoid memory leak

+       }
+       args->out.queue_id =3D qid;
+

Should add
free_queue:
        kfree(queue) ;
to avoid memory leak

+unlock:
+       mutex_unlock(&uq_mgr->userq_mutex);
+       return r;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+                      struct drm_file *filp)
+{
+       union drm_amdgpu_userq *args =3D data;
+       int r =3D 0;
+
+       switch (args->in.op) {
+       case AMDGPU_USERQ_OP_CREATE:
+               r =3D amdgpu_userqueue_create(filp, args);
+               if (r)
+                       DRM_ERROR("Failed to create usermode queue\n");
+               break;
+
+       case AMDGPU_USERQ_OP_FREE:
+               r =3D amdgpu_userqueue_destroy(filp, args->in.queue_id);
+               if (r)
+                       DRM_ERROR("Failed to destroy usermode queue\n");
+               break;
+
+       default:
+               DRM_ERROR("Invalid user queue op specified: %d\n", args->in=
.op);
+               return -EINVAL;
+       }
+
+       return r;
+}

 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgp=
u_device *adev)  { diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueu=
e.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 79ffa131a514..55ed6512a565 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -55,6 +55,8 @@ struct amdgpu_userq_mgr {
        const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];  };

+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct
+drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgp=
u_device *adev);

 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
--
2.42.0

