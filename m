Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D5DC369D5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 01:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3370A10E171;
	Tue, 29 Apr 2025 01:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3vm++y8";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75AB10E171
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 01:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7/8cvCNOZ41zCwMk6+k6GeHSrNNyjGlLlWBCbN0zNX9g8fh/LLdCQCovZIgcVowk2WFZCN3tcprS5GNXKhR4sBOX6BmmhDuz1NiBIMxQxOry1rmMdpWtze+euzu/YP6cwdgFwrLykatCbZkuAMiHS8SwlqV4YG6uxukTZpukg5TCfO7cOwvxyaRmCc7YGY0AXlUV4frCJ04HvVE0PcgJEgN91egFJfajopK99QxyY+4QQMARiG/5QbrA2Y4LEezrjC3TTrcs9ODKwtLVRfrqKvYTqoPW+WThFltOOv9+n5ERhthsLMoRdBVUY+nHBcdfpj8Y4dcObIOkGolefHAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5fe05uiu+CwsCqCGQTd80JYNJYU6TuFxS9opWP4z/g=;
 b=ARni+WcWMrx09aDjx1FF7uIW2K4rsmg5ThYrjM6N7rez/czXMYVNExDTgCLISN+YkF7nrJ6T4lX9eW3lEf9Imaf2sZF9IZcoO1qBbEi3xqdazmvHx19h1HLvBVfEDt54Qrft2aJqSGMe4mNP6mTLSmaie7T38zQo8SLxFaOWh+slyAOSZ9bLqiIhNMBe9jcLSW6AZ8v6uF1ZsRYqX6zLj7+xAFs1vO/DxTe5VPVZNc/U1YFV/ISPjkmLBLgogauOy/3W35Ffq9cqR6tAYC1gqkaTPVAagiDcGMUQMrZ5oXy97nRaN4TPQKNJKuDOLdvjHgi8/qAZyfOiRPUgGwmbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5fe05uiu+CwsCqCGQTd80JYNJYU6TuFxS9opWP4z/g=;
 b=l3vm++y8Dphz82y1eYBSsbrHQVgSTn2ZZ/4xX9K0wWpPU8Hd4NqwL3hDW320odtxo/MoEpInTmDwxBthXF/XDxlM+VWQL6z6WgAPqx7k8a/yYTe8NenQYKhiyksT39Pzbfa1UzY2JwH9NIf2CHoy2sZhSlVtFtrQR0NcKm7UjSc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 01:38:39 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 01:38:38 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
Thread-Topic: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
Thread-Index: AQHbthFf32dGZ1an4EO5VFpExB1OvrO54XGw
Date: Tue, 29 Apr 2025 01:38:38 +0000
Message-ID: <DM4PR12MB5152A0CA5EFC61285E4E6DA9E3802@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f3d5270a-7db1-47be-8927-31b8e781919d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T01:34:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB5983:EE_
x-ms-office365-filtering-correlation-id: 79b21ecf-94eb-4593-d870-08dd86be90cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6/xCak4l4jpSFcPCar65nBM8xMmVIg3loLkidxg959cDiwYB1MC62VIezg8R?=
 =?us-ascii?Q?GK1N1ChDtuvWIrg9X518zqC2TaUdVA97dvuC805jtR5OUOnN19xIvxYLDWF5?=
 =?us-ascii?Q?IUVev31PmDZG9LvGQnj7Z/ZbyNq5oSThANBA4xWhY206lvBVKdz+OZXD6kqi?=
 =?us-ascii?Q?D+wuwOgS4NZerZSQ80w41ock9XX+JkxzgvlNSBwLB0mTjtnpqoqO9V5umQG7?=
 =?us-ascii?Q?GzUE0AHA1j3Ll/vnGxT/ONo67DxBzZcGKYGG2onOxvasfdw7tPPqTvEjgDeB?=
 =?us-ascii?Q?g9fYLc3qAT5Sj8MEVchSGVQ8xvl69aYuz+heA24K7+t+XHxfmIMT6lwZZMZ9?=
 =?us-ascii?Q?WJNzUEuS/j9KtAhRgEpsn8F6N13ccvCS0BU+1MQ5ChNL5l/4fr9KuyhxV8Ie?=
 =?us-ascii?Q?B3Mw4BVKpD9Ay6Ap/Frwo7KZxVsMa9Fk51UaVj8QW2ggo4ugzO2nyXMx3ORL?=
 =?us-ascii?Q?YrMAzF6BmVOYEwTIEeeZZOtR8ODUvmq1WE1RvVAwQzHOR3VQNTZyJ0m3J5AF?=
 =?us-ascii?Q?GsjC+YVkzyjOrXsvUteUKwIGFQDxoSuVSynPoBtp7JK2z/285Yd6apbSo0lP?=
 =?us-ascii?Q?Q79r3ZcxUbiFanhKGY8lUCPvPpPNTnp+LFgnVCnrglnlD4rxp92vf/mjGmU9?=
 =?us-ascii?Q?PDcx5me/vN/O03CnAuMF51zIwip6u7ym0sdkon/E0HXTPq4nVQy83F7lVtOQ?=
 =?us-ascii?Q?8GxJaxwSc2y2xm9f++b9rPSEkAcahA0gm9njzkzxtHaSE2yNrtz+7JiQorcZ?=
 =?us-ascii?Q?OXlBHkzX9g9T1mAhGboflHvcFQIJqFVRlf7TqqcfGllS0ujBZSqJB0N+trOK?=
 =?us-ascii?Q?WsUpllKPcVXeA6WlgiEP+r8DgKhnemvGuuqu9n2LsyuPqsnHoDN2eve9yaoE?=
 =?us-ascii?Q?xfvZdZKSa938AYkfn4A/LcUQspCFHziklKRZQ37cw8vTLoQvCQjNvjizw8Ts?=
 =?us-ascii?Q?K8/JYy9onNmwSBGNIhOK0t+b9zLozyLfq1nd8VkmlzUCbNkllsAyTBFrEMBU?=
 =?us-ascii?Q?PT0cdJlUx3j/dTxZnJ0Ot09x9IC8CwpiNhEIrrkGtCOnq6Ue8VD6VmY7Wb4k?=
 =?us-ascii?Q?bTNmUBmNXV+LWeuBPKxWTf+TbJWUFf8CqiHxsnmJNJRQtaFnPsf9vZ8iYbmK?=
 =?us-ascii?Q?YfXv/1yvAdh98/1V/XC/IvP6f7E+vFLzDB6odEiLe1LM060S0Z1teaAjxNh+?=
 =?us-ascii?Q?w9q/d1bG2KzmitEbi3fB8nZOJrN7rNbyD+3mMMREubxIE8RJMsCN4S8kBJx/?=
 =?us-ascii?Q?RLnaZdXEl73ultm7khIhqKzMVowUa0n5zSJPnTiTxksT1/Wf9UmVg0g6hlFu?=
 =?us-ascii?Q?iOKEr0fxNtQxMbUhhwXeUB8HrwpF59OjjNWRMavN6pm878/oswUc6rh9t7hQ?=
 =?us-ascii?Q?i5MLe8MBf9fncJGQbHd/gmBBnBqrpIPbt6tZvmG3d0U1glT0YSSJeQyFORTf?=
 =?us-ascii?Q?ZDglOuYMt6UTdNhCd3S3pNr+fqD0JmEjX24wE/JZvQWGhCxwvBkwvoOhc1U0?=
 =?us-ascii?Q?ygy/lUgHKqnwdt8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KyXY8BO/R+O/uMggLCZJBb6xRn4RhuURScZPYtb+ug2UFo9GsFwhq+bduR9C?=
 =?us-ascii?Q?ZqQgFt9kwBupxCkyP0DTMVUiAWV0NiOBWTYtHR1FrpwSghOLDciemPGNFQ/Q?=
 =?us-ascii?Q?5BJvXTyrQbBHBBvUNd5vOx3dnVpZcvK5E5Ei8XFjFCfeb4p38Zq7XIw3jbJX?=
 =?us-ascii?Q?sckpENUzSTkRoQaQ0LcHJmgpSnfHheGZiNt7shXgvF/0DLrAehlbmUXGstb0?=
 =?us-ascii?Q?6Bsp0sXNxRPp20uiBsWizP5worQLz7Q3V6gfSNpHnoR0jPK4AZ9rc5z7IWPr?=
 =?us-ascii?Q?qIFS6fL3Vwxl9MNv0HqGDuLHWPr/jTq5D6ZFKddrZnIjsuF45pFL7lDUY6YL?=
 =?us-ascii?Q?sZoVzRCPHJcM5cp744salSivkxoVCXKQ4ZnevsWKb9sIff1Y/vkUxejL3xEr?=
 =?us-ascii?Q?Bs2OMJpoAhacQZmz4gv3BV7M1SbxiMWLSGWeu5LEAfkW/xeWOgPf92rGim0M?=
 =?us-ascii?Q?fSa021KcQc5R7GfcAAom8U/evlr3PqsLPl15n7+fss0KvqKk72qzTkOr0LXw?=
 =?us-ascii?Q?6uxJXKCKXyKqJY0Z+1ec3GNHAEshIVGJ2KW6LF6VpFKsyrSjx9sFoNmOrPpU?=
 =?us-ascii?Q?aHlqdXAtPN4AEd4YV6Tkvd3poeDZQxErDswaqGUmxVBI+I3nEbR/UVhI4UiO?=
 =?us-ascii?Q?cL398mpIWOsZu/1RkG//Udq7Nur+ZGbH5/xMeDeHQF+wxTIPDzDfu7fCzXIm?=
 =?us-ascii?Q?g8YxBTboa/NMMBWL1KZ12lznQpvEHLObXOnDzhLlA9yBKEaGbUhryuw5DfU4?=
 =?us-ascii?Q?B59Si7uWQmXWULWz0khLwR4hR6vg0R4fm0FBrb6SQ0udPLxxnXNlMmn/zrS3?=
 =?us-ascii?Q?EWLvmt8fx4L5dBA+bS8fbTB+ASLgZ8dalFhTKMSRYHcsVdbIZLJkJHhBkC9k?=
 =?us-ascii?Q?FrQ33HFA6QzO3y8R+E4z7je6cb5Melxf3Atw3DbpPNFa9AvIhHfboZQcLz9S?=
 =?us-ascii?Q?YUE7KbzKAK6oZ8JR7FIeQPyHDCZGyw1yXNZ78vWI9NlxmcXRp+wleb/PkJtg?=
 =?us-ascii?Q?z9JQn/OhyQ+sj95oG8Qxzjlu9g2nCuTGGnZFghqj1RBIyiucperjNPKWDxor?=
 =?us-ascii?Q?Wr3DfjdKBeEstCSyToeptDWMgxNv1R5ZdwcynN8RjqV9ecStCMoqDUnJnZpv?=
 =?us-ascii?Q?inBcrT0iFIJU6hvXcWMK2xMS2kpCsBSnsUutSVfRJ3p9AjaTNSrrUD9nBO1c?=
 =?us-ascii?Q?Q+62s7jf5bFuBUgkdFXMoEU+Cr9U03vKFszg6EFWdCvIOqa5Cd/gjxUS+AdK?=
 =?us-ascii?Q?eLSy56rOJfV59pDhbvoCF3MbuA9lwzUTtHuDP8u5AJ882U5kjnA/2sKFoHal?=
 =?us-ascii?Q?A7lq+xbbh0Z/vF/sfzWZ0PUGcx46u72QdNM3pzoxGfLJN8IRKjA8Fm9b4jGi?=
 =?us-ascii?Q?jVU4XdiKuj7rKWwpUkkY2BmaEykbC3xfFIW1MEiqN57oO/T2JdMSCCEMPYrf?=
 =?us-ascii?Q?ck/4/766G3fhUqeZhiFiL5bjqbo9i3meponkyNJvM836rgXq3G7b0J2KA1E3?=
 =?us-ascii?Q?jJkP2RZeLysEQLnheZAosJRCJY1Nh56ZxK3/2YZ4dv6OrOfaPR1moQi0SMOS?=
 =?us-ascii?Q?6iKxlcjCTDuSeZPbCRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b21ecf-94eb-4593-d870-08dd86be90cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 01:38:38.7553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9MX/0+NaAPwXxoi9gH3den2/e6xLcsE+TPkbvOniy9tV1lnb74Ke/Rim5eCNrKSda7pSCaRcnvwjKLx3Z3SVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Hi Alex,

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, April 26, 2025 2:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions

These were leftover from mes bring up and are unused.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 -------------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 --------  drivers/gpu/drm/amd/am=
dgpu/mes_v11_0.c  | 26 -----------  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c =
 | 27 -----------
 4 files changed, 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 38ea64d87a0ac..b5a7e2ae72aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -285,68 +285,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
        return r;
 }

-int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id) -{
-       unsigned long flags;
-       struct amdgpu_mes_queue *queue;
-       struct amdgpu_mes_gang *gang;
-       struct mes_reset_queue_input queue_input;
-       int r;
-
-       /*
-        * Avoid taking any other locks under MES lock to avoid circular
-        * lock dependencies.
-        */
-       amdgpu_mes_lock(&adev->mes);
-
-       /* remove the mes gang from idr list */
-       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-
-       queue =3D idr_find(&adev->mes.queue_id_idr, queue_id);
-       if (!queue) {
-               spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-               amdgpu_mes_unlock(&adev->mes);
-               DRM_ERROR("queue id %d doesn't exist\n", queue_id);
-               return -EINVAL;
-       }
-       spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-
-       DRM_DEBUG("try to reset queue, doorbell off =3D 0x%llx\n",
-                 queue->doorbell_off);
-
-       gang =3D queue->gang;
-       queue_input.doorbell_offset =3D queue->doorbell_off;
-       queue_input.gang_context_addr =3D gang->gang_ctx_gpu_addr;
-
-       r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
-       if (r)
-               DRM_ERROR("failed to reset hardware queue, queue id =3D %d\=
n",
-                         queue_id);
-
-       amdgpu_mes_unlock(&adev->mes);
-
-       return 0;
-}
-
-int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_t=
ype,
-                                  int me_id, int pipe_id, int queue_id, in=
t vmid)
-{
-       struct mes_reset_queue_input queue_input;
-       int r;
-
-       queue_input.queue_type =3D queue_type;
-       queue_input.use_mmio =3D true;
-       queue_input.me_id =3D me_id;
-       queue_input.pipe_id =3D pipe_id;
-       queue_input.queue_id =3D queue_id;
-       queue_input.vmid =3D vmid;
-       r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
-       if (r)
-               DRM_ERROR("failed to reset hardware queue by mmio, queue id=
 =3D %d\n",
-                         queue_id);
-       return r;
-}
-
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
                                struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index be3390d263012..af6e341f6411e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -235,18 +235,6 @@ struct mes_remove_queue_input {
        uint64_t        gang_context_addr;
 };

-struct mes_reset_queue_input {
-       uint32_t        doorbell_offset;
-       uint64_t        gang_context_addr;
-       bool            use_mmio;
-       uint32_t        queue_type;
-       uint32_t        me_id;
-       uint32_t        pipe_id;
-       uint32_t        queue_id;
-       uint32_t        xcc_id;
-       uint32_t        vmid;
-};
-
 struct mes_map_legacy_queue_input {
        uint32_t                           queue_type;
        uint32_t                           doorbell_offset;
@@ -377,9 +365,6 @@ struct amdgpu_mes_funcs {

        int (*reset_legacy_queue)(struct amdgpu_mes *mes,
                                  struct mes_reset_legacy_queue_input *inpu=
t);
-
-       int (*reset_hw_queue)(struct amdgpu_mes *mes,
-                             struct mes_reset_queue_input *input);
 };

 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev)) @@ -3=
94,10 +379,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev);  int amdg=
pu_mes_suspend(struct amdgpu_device *adev);  int amdgpu_mes_resume(struct a=
mdgpu_device *adev);

-int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id); -=
int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_ty=
pe,
-                                  int me_id, int pipe_id, int queue_id, in=
t vmid);
-
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
                                struct amdgpu_ring *ring);
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev, diff --git a=
/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v1=
1_0.c
index 0a5b7a296f08d..5ce62a3f01e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -475,31 +475,6 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_me=
s *mes, uint32_t queue_typ
        return r;
 }


mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue are used for user que=
ue reset on your topic branch.
Do we really want to remove these two functions?


Thanks
Jesse
-static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
-                                   struct mes_reset_queue_input *input)
-{
-       if (input->use_mmio)
-               return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
-                                                 input->me_id, input->pipe=
_id,
-                                                 input->queue_id, input->v=
mid);
-
-       union MESAPI__RESET mes_reset_queue_pkt;
-
-       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
-
-       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
-       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
-       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
-
-       mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_offset;
-       mes_reset_queue_pkt.gang_context_addr =3D input->gang_context_addr;
-       /*mes_reset_queue_pkt.reset_queue_only =3D 1;*/
-
-       return mes_v11_0_submit_pkt_and_poll_completion(mes,
-                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-                       offsetof(union MESAPI__REMOVE_QUEUE, api_status));
-}
-
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
                                      struct mes_map_legacy_queue_input *in=
put)  { @@ -817,7 +792,6 @@ static const struct amdgpu_mes_funcs mes_v11_0_=
funcs =3D {
        .resume_gang =3D mes_v11_0_resume_gang,
        .misc_op =3D mes_v11_0_misc_op,
        .reset_legacy_queue =3D mes_v11_0_reset_legacy_queue,
-       .reset_hw_queue =3D mes_v11_0_reset_hw_queue,
 };

 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev, dif=
f --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdg=
pu/mes_v12_0.c
index 1f7614dccb005..a3391810c897c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -494,32 +494,6 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_me=
s *mes, uint32_t queue_typ
        return r;
 }

-static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
-                                   struct mes_reset_queue_input *input)
-{
-       union MESAPI__RESET mes_reset_queue_pkt;
-       int pipe;
-
-       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
-
-       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
-       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
-       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
-
-       mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_offset;
-       mes_reset_queue_pkt.gang_context_addr =3D input->gang_context_addr;
-       /*mes_reset_queue_pkt.reset_queue_only =3D 1;*/
-
-       if (mes->adev->enable_uni_mes)
-               pipe =3D AMDGPU_MES_KIQ_PIPE;
-       else
-               pipe =3D AMDGPU_MES_SCHED_PIPE;
-
-       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
-                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-                       offsetof(union MESAPI__REMOVE_QUEUE, api_status));
-}
-
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
                                      struct mes_map_legacy_queue_input *in=
put)  { @@ -914,7 +888,6 @@ static const struct amdgpu_mes_funcs mes_v12_0_=
funcs =3D {
        .resume_gang =3D mes_v12_0_resume_gang,
        .misc_op =3D mes_v12_0_misc_op,
        .reset_legacy_queue =3D mes_v12_0_reset_legacy_queue,
-       .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
 };

 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
--
2.49.0

