Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9982FCE79DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128CA10E4FF;
	Wed, 20 Sep 2023 14:54:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B2910E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMmdSJjqynvkxz54i+7rsHuH3UE1y9BgIQazWh1b8PLI0x15HNHU/aOPMj/o5XaR3csf6dM5z/JneJWknkyqkFgQIWKNrVlAAgfITU2EO+khqvprgofXW/FN6VfrZ8P0WjDHRkvCSdS9Kurn0xKGJc9KW9uJX62FOORs3OFkcGMNR/iySHlfwHwxMSjbsYDjW9YVAaFDDXQeP09BgGpCtt9LE5kGfxlxJJ2TvnOgCNlJ2UzhtFi2ewwU1q54CzFiuiUTp2nMX+Z4YQSiPGwupKcH2WgqufUbhp7jJWyYT6aEAGZWsBdpRv+9Ea2P6vKR8YpoNcqG1ck6dimh070S6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPBMKFxpK2KdjdhE9F7Jz0N5xd3fgnkb6hz2mJnGr1U=;
 b=kjrUXmC24U7WuGkz2MNQbTTw/bUpDNmPpkpM+9rj5lUFjJFFxciI4sFRKbAfAZI7yFLreEeNdXOZcxQHnD8NMmPE1YYYmpJm763SXJJZwX2cH4r1fNvbP9ngFIaq4cMPLKQbwnRDtD524sAaOSUbLd7RWPrfPaIEPgWyigS4YbJ6yKRBn+Tc4dT7Yrq0ldZF1WAQJr5QC6q1i7k9uqa9I7HhFxWMqlx+tfGQrLbi01VhYj8q5a2A8Q8rxuy9deWc1cZlSQgwukUPHtlWnXSo1fqpPuoDrhsRHYLFLhaKwGxD7rFvMVn+YTVHwcf+S5DXLqk/WGjOqdS43s+Q5KI57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPBMKFxpK2KdjdhE9F7Jz0N5xd3fgnkb6hz2mJnGr1U=;
 b=PCKCDX8XzsiihfTzEX2rk/F5hnY8FVZzMyIO9qsoKVR+APQkeQxkxixVYhbZkUtQ1iQMEUVusYQnaZ0LKgddHWE/Ut4+toJbwRkjMLr/IhEKvsfCvXtLN5uBPhk+jbFHPr+Y/aa9uwBbk/m+I39fPzHVV9vHFKLWyWlslIlPxXA=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:53:54 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 14:53:54 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue
Thread-Topic: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue
Thread-Index: AQHZ4m5jwnxOTtUK+US0U6W9TwB+LbAj3fCAgAABjuA=
Date: Wed, 20 Sep 2023 14:53:54 +0000
Message-ID: <MW4PR12MB5667DED8535D55E3E5CEB840F2F9A@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-4-shashank.sharma@amd.com>
 <CY5PR12MB636955AB9DCEEC4F934AB935C1F9A@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB636955AB9DCEEC4F934AB935C1F9A@CY5PR12MB6369.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|CH3PR12MB8849:EE_
x-ms-office365-filtering-correlation-id: fd9d412e-69ed-4b75-695b-08dbb9e9693a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57slQI2O7LlO/5Tbb4hLr2jWY+TVoHRDqU/N/otgbHFHdDdmXj/RQzB1YSRIIT/QFk79peQy8Bcn8DsZn+wjB6+4LcgNXltII/49Y61Vd9OuYuyWyOn3WQHUHRN2KpRLgmVMxDEW2UnpSE42q6yQqA4ZzQrk5xVJzb7oocANejS0Qx3VofwjbInXA4b6sbk0APwpjy+AIneAZPjm1T6OE85ltgLg3KEJo3S6vWffKhG+23xFfey3vJ2wxNcIbBHReTMpFzvAxPopGQ0PxCHoCQp1Uf8J8B8emLqvc1jXckjLTpXQtiTlyeLrCNVB/Oi4lEnMhu73HTIU75NSNRtbMv2opzKB/hc9pl892tsxm/9vWZlJnOkzsRIY1/kGqT+nD8AmhLOZHIEMBNR9Egbu+fBUhmEq7aMrott+9ZK0MZ7M++zM3uUaOoDSDjOrOAieyJ9vKpVDReyQqVTKJsrWKr32PJANGwCZFMglFQhK+6Gm36dyrEhch/uZgny4F4wat2Yac24kN8b3OmK5YZHrT4tovQrR7oS94RPZ7bRY3+Z9mKoYxr9IYSvYSGUu22hW7AfHZlccWcyTK8amz7uPMMQ1R8AnPry8P9CoJjiXjwQHpyluayV0wt5M5bEngXAw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(316002)(54906003)(4326008)(8676002)(8936002)(41300700001)(55016003)(9686003)(83380400001)(7696005)(478600001)(53546011)(71200400001)(6506007)(86362001)(122000001)(38070700005)(33656002)(38100700002)(110136005)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008)(2906002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKoaPsh++DEE657GBC4AFsD61gxwycm4Nc2cPBradNB7Ck5SXVgyqlIGEp6B?=
 =?us-ascii?Q?Vekv8yO4S/EL5cMOjdY/dm7U0295brjI4F/2Rk+fax8WU0bhhRBOPy/MF/UA?=
 =?us-ascii?Q?5q+rUi+ZtPLJi+ecOOlXYYPNxLtLi8XSkgThGUiyCaSf7RgFclnQ5VV9SOE7?=
 =?us-ascii?Q?ozlvg9OjDrqEE4a2KgqImjqYKeonrw1c3KFRlE3gvnY263E6s9FyGMLD5V4V?=
 =?us-ascii?Q?94vSADHKGBcbt0r2KtWsa7mDjhd7fsEQDWXQI4SvI6SwVet3Z7sHm6kP63L2?=
 =?us-ascii?Q?M0tlOCmxA2WdFn3Ft07DSLhkw/pBbXzLTgMKPtigBcoZD81OCBoYdHFtVLe4?=
 =?us-ascii?Q?fx8SEHO4iqqcD6MtngtFjT60LsC36zhu2M5SUj5K8Ik3qCwIiWzykFkKdkv4?=
 =?us-ascii?Q?q0VnFsl0j1CJP5B9KoVuDna3ZHrJT3Z3JP1odCaPRPdJcQGt4a4DfDRWr+y0?=
 =?us-ascii?Q?WMr/RlgcdTlxgG+XYpNGwfeIC5jMx8cMoRMDTj7VPK7zKRK36ZFmd6AAs2qd?=
 =?us-ascii?Q?+f+AK1SUWsJzxQr0Lr2HuDNEX4wMWvzoBZqazl4dk6t/02MqjuTOIiu5HtuK?=
 =?us-ascii?Q?Zf3jO9YSLCMp8io/IHUnFxB2PRfLfoCj5GtKIMBMfVNlcQvlau9XXgy0keIB?=
 =?us-ascii?Q?UJFcaXRIu4GH+0Jvt6lCjh2Eg2c+OqaxVQW4L5maIZcXDdvIlVcVgOk99piY?=
 =?us-ascii?Q?x2H1C+X5F10nC7QIatTssnbkyJUnVNcfksO0zUIzCK6PWcNQyZ1NeZ97oabw?=
 =?us-ascii?Q?NRtMi0Lc4io4oGK7dlVmzT2QX/kRWeydQlsAZ+d1nJR1vxVVLhjIBupmUFdO?=
 =?us-ascii?Q?cfHtrJwNXZT+kcvQxiBlEZ3Pzr3C9OZt6mkc3HxkBMtrVYyuiFvvc7TxHK9V?=
 =?us-ascii?Q?XzPEUaCWlcs79p+CxISyKtSV2iur87ddvcMAoLQdfUjUBN7uIOdFBoKmmHz9?=
 =?us-ascii?Q?O96VCZIHQhErqWdZVcME2DE4YHqPZaMZ6f/62ae0yvOmf8qAwC1gaLvDM9a9?=
 =?us-ascii?Q?PWIOtwiPtZYGEEPQb4n5akFGlY5Cx1Jhyo7moXDZTkDA9ePkHh8w6NzVil/I?=
 =?us-ascii?Q?1UmdVbC6gj21gyqaE6pO2qjBymRlO1ItN/7qrY5wnOQJ49EcWGeY502Plx5l?=
 =?us-ascii?Q?0U78E5JeLbMsGaAvgX37gjW2LujO858rb8Iz5clOQjcljudSOinJnkQqkEbw?=
 =?us-ascii?Q?SREYHGlSI9n7D4LSok7PeAN082bV9Rw56V5LTy4+svCe31INyo/ZZyD1b1Cz?=
 =?us-ascii?Q?+wL1wEysi1gMqBnL4IXtTRwNa+Gn0V7fkYk/CTWDiOnKAPegf/VWBHPUju3T?=
 =?us-ascii?Q?nPpvxuxmzO7lMALrby8l9odXcNtTtTz6I/Iercux9wkL6k3aJbj4iocgJwwW?=
 =?us-ascii?Q?ghV3rIAGmWC2erLgkt8BhDsfb7VxHJKvXSGlKN3d5qVcBz9u0fvnRp/xims1?=
 =?us-ascii?Q?Q6aXb+oWfOzGxiv/S7NKSONPJIT9C+HjvVbzmt6Gi8n8Vz8+EMMdxi7MGSRI?=
 =?us-ascii?Q?RuhOXUpttqwPMWg3I7bLqASzoA3bFsTssA0ZaIaqFqp3/0xGWO+hXaqk0w?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9d412e-69ed-4b75-695b-08dbb9e9693a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 14:53:54.6959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3bvMQnwvlglNcc5t3K2t+PAhZu9HCQbzwJC4gS0XqBDwMmjupbFUk+u8bFKiTzk04tZHqzAaBm17JuFPFbvHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
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
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, September 20, 2023 4:48 PM
To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Sharma, Shasha=
nk <Shashank.Sharma@amd.com>
Subject: RE: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue

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



That's correct, looks like it got removed when I moved the code shift to ac=
commodate the cleanup patch.

Thank you for pointing that.

- Shashank




+unlock:
+       mutex_unlock(&uq_mgr->userq_mutex);
+       return r;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+                      struct drm_file *filp) {
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


