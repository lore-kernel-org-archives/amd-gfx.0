Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE6C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 07:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B47010E063;
	Thu,  9 May 2024 07:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaX7rxm0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1191810E063
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 07:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dneGjt47v8RWryuXqQGIU1bF1OkpNQxKuZaNbgvkNVmYI8ryoExqQOJHMSt33oqdt6hZGZgEv9n0WxcKvGjO4n9WVqEVMZbQ3+OXuLSLDbq+CSQGj/PGIyTneHMbAYmUfTlM46m/PnxEy1OaiMtyC0QENXoo/+RfG4tY2sIYdLsG56kFtRBP9RD6L9V5O0bSBnPKluPZFzx2gUoOhsYs+1rsUmmeX6Wq2cnRGasdY3hcnaRrUS1XYgVKCXIESbmzLlZOod1HYZJdNCke2RqOPFrFfSvqJ+tJc/xiBpa5o0PIWFMRMTNhrwhT3zZbTUtQ5AHjMLkGPSgN3RcyGKL59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PNN/L63HgcFzX6oHGIh+ZB7036nBrvBGTpNjjJVRe0=;
 b=K2VlPfM2nmOrCgyCU9slmV5vbinU1qVWEIQ0PcLqravTidOczFv25ZVpWMy4iSExOQ8U8w1XiDFll74XdbYDjGnb5mYtdvvlDavXSChfcIz8PcqVjNkESE/cOXiCHnYOO7BOTaR/PX9KAbFBQA7MIcPdzuRrEIf9tNXiqj5t/KrbcM7hBgc1Fqkars1M/gAUfHvQkCrwNYaHlc6ep/z9CZQx6zIIpvOAQLzRzKevbSWRzJVkXyloy7l8ZAWbQqziR1scdO344yKPnCHDjybXTGxdk3fWZM2cHOLpP+aMsAoiKybtpUPTnMiaJW39agZjA8gkutqGEha5EVas9wtfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PNN/L63HgcFzX6oHGIh+ZB7036nBrvBGTpNjjJVRe0=;
 b=UaX7rxm0deF2oBlvAjbWwpClZlOQinRq5CtMWuqpNCDJz8Rq85QhfhzYbfoZBDzBeeS1XY4LgJ0JibZLBX416ysuv6k8OuNCPYizlIaNCr556zkme8rVnru3pfQT7Z07ijjLEdjd7dAjMYZOZzi8KF2RYLtWp6RD4yFR1y8thIg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 07:20:59 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 07:20:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: fix mes12 to map legacy queue
Thread-Topic: [PATCH] drm/amdgpu/mes: fix mes12 to map legacy queue
Thread-Index: AQHaodzTHut21URU0EuxywSLLJ9FdLGOfACA
Date: Thu, 9 May 2024 07:20:58 +0000
Message-ID: <BN9PR12MB5257DF77B910E4E172D946B0FCE62@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240509064701.965399-1-Jack.Xiao@amd.com>
In-Reply-To: <20240509064701.965399-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9faec5b6-3f15-4518-9c6f-63b8ca1d670f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T07:09:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: c7417ef8-8cb8-4fe3-457a-08dc6ff89303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nZtAXptdqJlB8g0ahkI97fNyJzVYbFLye9RufPv8tfA+3/3NSAzDouGt3GIs?=
 =?us-ascii?Q?2FJ3YTegfKSCopZOmSXFj8pkXHx7QmTAH48vvVtKej100TYjVmRygXe2C0QE?=
 =?us-ascii?Q?CZAqbN6CiON/lE0y16M/xzs8m4bbuC2zTVebAW50ui+BS5c1wgHnRjskAIgK?=
 =?us-ascii?Q?OE9cJw/oR12ADDgfyAvzThPEcrEP4yR3Xao6+02H3esfeg8dHGa3+D9tMZ8z?=
 =?us-ascii?Q?aR86XFNOjXpcUb8jukjRYNGaF5q4CleTbHawjfB8ClwHV0nrXsac8lRdDofM?=
 =?us-ascii?Q?oHBY2SURVCWlx6bOGFZDzNo2IXSaB4nZyTxw+uGk71JxLOr9xPmrMekL4L1j?=
 =?us-ascii?Q?z34uKXCIxuv6XFR1mrDPVwlQKZWAB7KI8fH8wd6x53vmkhYMprY1hcgEfuN8?=
 =?us-ascii?Q?ie3m6F6hTv33m0igFwhY1BfkwC7i8vCsBjK/UkMJuCmMltWSsO6LL2x2gTtq?=
 =?us-ascii?Q?/Er0iGRNuem80l4qKIm5KDki5PctSJCcVsyJDIqjVSR55mVpiZUVMiy1gIs4?=
 =?us-ascii?Q?I65BvodBnkm7enZAAC7yKQuCVcvgWma18B+VMekShBUjVVQRj7rpozRZE4l1?=
 =?us-ascii?Q?YMuwgw2+jLvQ/3Gd08Albt+RJ6MroZ1GAAMzP0Oqkfa6uG1PSO/JmGMJswwT?=
 =?us-ascii?Q?Yk4BOOdGiYDhtnPnok0OP82XeR9XLpXbpMPzmXdor3XKHYBmXBhXvEYdQZGD?=
 =?us-ascii?Q?KP3AOi7d24Rlh2oSGz2uti/63pnp0sEFiFPAQRcLQDTAvVIK0fXfy09H7pZG?=
 =?us-ascii?Q?LovkAxz1g1yXJuUJukcB8Yob9nuw2ZE1kr1ADfgIVd5uKvLdwkGC15tgyF1S?=
 =?us-ascii?Q?I/3uRVLD3ac5Vm1lL7vcq6AJTXMiWIW8FsX/xbYEjdK6mHeV5HC38QvcG8Zd?=
 =?us-ascii?Q?WT+rkeHrsTXKsphk86d+U7ZzHOS24zsO2NfReHwjYeVvCGo5mLAAgyecgeiY?=
 =?us-ascii?Q?4Nu9zV/YgnFTUk9ba207yrMOrqd+ou8DliXqZqI/CRSoIbFP8n/X/cMqO3mY?=
 =?us-ascii?Q?l38utoSCWDByFm7WellE0I65MhUo7LV0xD+r6lYugspahK9j/tcF0Q9b7SZx?=
 =?us-ascii?Q?odmbl8jVkde+U1TSNMC8znsemrsXj90kHWB/X8EWIrT5GyIZxKARivEyXHlm?=
 =?us-ascii?Q?TIF4R7cjQiHgODo6m5K4NDLY3h8zDm2J9fBQFt5hMGDQET6Ia2QeE6xT5Npc?=
 =?us-ascii?Q?U+B6gavAsw3UYOWrMfOkllgKz5QGpgRWGn/iHlBuBLx+I8DlpoAYRRKc5PAo?=
 =?us-ascii?Q?E56hgk/PYm/N8N053vja7QrxMST2kEz4y/2K8ohk125GmGAUSIT0XvvRQ2W7?=
 =?us-ascii?Q?YskTne6r2hXxXrH8Ff+KBKO+rOzvh0JNov9VE4D6hiALWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+5u2P0qYHwSAmLgo6LQmKfsLogDzJbo8i+mTvLeP+ZnEk2zIrWvsC1DQAqJ?=
 =?us-ascii?Q?QHGUEPy69GY/TO5ZTroXTmY+HuaUvn+YLb3BBBcBMwjy5NoFEn6e2sjB73tG?=
 =?us-ascii?Q?hawC8XWhTS6joEWqETxHHkp3JWHmfwKWqb54PsusfFYq6MDwPh0sgBpsEv9G?=
 =?us-ascii?Q?3xvaVG2BhSgIZHwptp4SfZKgGY5M9roApywtyz6Qywayh/6F9F611Gx/Uh/T?=
 =?us-ascii?Q?WAVluKNcoMXsXPNu6EwZzorG5N3x8VDI0H6X9sG0Vx54KXYINm/wxhxUmrJa?=
 =?us-ascii?Q?EZVarKm6IKhBg/uj2yzsPOBON3kJqKPV0Zm8pUEz4IGf/mtGWC1bDOef5fAW?=
 =?us-ascii?Q?YcXXlc3sPU/szEWyXxpNZixBTIVPd2ag1PB1+jUaZ0UjQqYtFCoGtLVBVYUN?=
 =?us-ascii?Q?fdBypeozx2raJrHkgDKn6jZq+AXgnw2uEfDqNH8kGbhHbSuYp+orLJcH3S2d?=
 =?us-ascii?Q?fxyQdeeauffSYZPZEJkNKOBMg7bOmGIlMXWcPeWAJbFVrdtZfSo2tqjCA6ts?=
 =?us-ascii?Q?C3+n02YyQT+77tzOlkizipgLZnfXV5hxzWUu66EtKn2tKEKu+4nJt6IDk57t?=
 =?us-ascii?Q?YV3nIveq6G41XYzkNSkVU7NCPZip1bwO4/hyZ8QdpBK76Eq2dT86nsDMXQJO?=
 =?us-ascii?Q?MbOVT+vRnWwBa/r7yqdp+zKCbpbKYHSfpfbvILW5dxHgcgrgPYUWaX5IEype?=
 =?us-ascii?Q?KfIeOdarT3HCjQcjXx3yCDqp6OoCOk8/RFiA7n0ROkums1uLkFWchwrKS4wM?=
 =?us-ascii?Q?KnvFH+hN9cUNov/5vZ/EkowMbzDBaS1P9AXEM09tQpcmYmZAwkhLqxBAEhZ8?=
 =?us-ascii?Q?cL8BPyp3tQI1eBlQlUc1whPBLyU7LND5fWgGTyk3bV9QRpAdRIZ2jB1eYbbo?=
 =?us-ascii?Q?rJbGrDVYPnsuUtf2+5G8um/E8hgHFm5pvpQxub/5tsmt7arZyiE+z9rRH+HC?=
 =?us-ascii?Q?hUcG4mjH+9WK5x2xUJg5MH2ryR5sLsc+qr8EebjavhnPogWaeiSdSw11srKV?=
 =?us-ascii?Q?ksFkHE+Vblje5SwaI1g4mCE4F93c4sc12iRkEpHCY3zY2PABiLjNiUV/RRae?=
 =?us-ascii?Q?hUJOZs0AVc0dpOpepdD3+hUAFa7kSbpL7mR6XtsI3q3Ny/xA31NcnLCCY9U2?=
 =?us-ascii?Q?r9tYFrEM2GLDgw3P2ot4fHXKjXdlggza7K94ADt1vZAhy8wPOsUkGcMRfdBA?=
 =?us-ascii?Q?9M/gaNh8mB2H6UkCV+0GqPdWoRFuT4Et1LGeV5vewWnz0Db+VoDFc2RJgD0s?=
 =?us-ascii?Q?zc34hY9Rjrn0H0fSMDZoNhpK2uLFdZsQ30NHXaN9vgtGmar9V43CtJJaCXye?=
 =?us-ascii?Q?78e80Hbz7ngYR+BldoBAidrfKyG4SLJbTFYyYMPkevR7EEHMXOgKMrK737Sl?=
 =?us-ascii?Q?eiF28VDfhmyM1QyRyqC2GcgrWU7kUqi6jFSRs55WwPupkIAJsZfw4BaGhnjB?=
 =?us-ascii?Q?caKS3a4+2bTdwkDeexFyXekA1LvBpzaDnKFBKfI/NVXhjbzOWSwS/As0oR3f?=
 =?us-ascii?Q?LsVnjXTUw0/kACbDY3ICRFEQh5qZWa28Nh+d8VmiRRt3tHxCIZ65FpOFlZdh?=
 =?us-ascii?Q?VS8esTg1NW4bv/ty0kDXsJotgLsbZ1QH8ozcHAtZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7417ef8-8cb8-4fe3-457a-08dc6ff89303
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 07:20:58.8213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jV5V3yrlU7tgc1QWAw1tbNUesyeNVa8seTVBmH32WsYsmw4GMLRUaVcISYfYsrU2VCn5whjWYygdmq5lw2bk2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

[AMD Official Use Only - General]

Let's use dev_err that is more helpful in multiple-GPU use scenario when th=
ere are errors. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Thursday, May 9, 2024 14:47
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.c=
om>; Gao, Likun <Likun.Gao@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix mes12 to map legacy queue

Adjust mes12 initialization sequence to fix mapping legacy queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 71 ++++++++++++++++---------  dr=
ivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 10 ++--
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index ca90d6b577c8..a2696c215899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -599,6 +599,44 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct a=
mdgpu_device *adev,
        return set_resource_bit;
 }

+static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int
+xcc_id) {
+       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
+       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       uint64_t queue_mask =3D ~0ULL;
+       int r, i, j;
+
+       amdgpu_device_flush_hdp(adev, NULL);
+
+       if (!adev->enable_uni_mes) {
+               spin_lock(&kiq->ring_lock);
+               r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->set_resources_s=
ize);
+               if (r) {
+                       DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+                       spin_unlock(&kiq->ring_lock);
+                       return r;
+               }
+
+               kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
+               r =3D amdgpu_ring_test_helper(kiq_ring);
+               spin_unlock(&kiq->ring_lock);
+               if (r)
+                       DRM_ERROR("KIQ failed to set resources\n");
+       }
+
+       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
+               j =3D i + xcc_id * adev->gfx.num_compute_rings;
+               r =3D amdgpu_mes_map_legacy_queue(adev,
+                                               &adev->gfx.compute_ring[j])=
;
+               if (r) {
+                       DRM_ERROR("failed to map compute queue\n");
+                       return r;
+               }
+       }
+
+       return 0;
+}
+
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)  {
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id]; @@ -606,6 +644,9=
 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
        uint64_t queue_mask =3D 0;
        int r, i, j;

+       if (adev->enable_mes)
+               return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
+
        if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_re=
sources)
                return -EINVAL;

@@ -626,9 +667,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, i=
nt xcc_id)

        amdgpu_device_flush_hdp(adev, NULL);

-       if (adev->enable_mes)
-               queue_mask =3D ~0ULL;
-
        DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->=
pipe,
                 kiq_ring->queue);

@@ -643,13 +681,10 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
        }

        kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-
-       if (!adev->enable_mes) {
-               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
-                       j =3D i + xcc_id * adev->gfx.num_compute_rings;
-                       kiq->pmf->kiq_map_queues(kiq_ring,
-                                                &adev->gfx.compute_ring[j]=
);
-               }
+       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
+               j =3D i + xcc_id * adev->gfx.num_compute_rings;
+               kiq->pmf->kiq_map_queues(kiq_ring,
+                                        &adev->gfx.compute_ring[j]);
        }

        r =3D amdgpu_ring_test_helper(kiq_ring);
@@ -657,20 +692,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, =
int xcc_id)
        if (r)
                DRM_ERROR("KCQ enable failed\n");

-       if (adev->enable_mes || adev->enable_uni_mes) {
-               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
-                       j =3D i + xcc_id * adev->gfx.num_compute_rings;
-                       r =3D amdgpu_mes_map_legacy_queue(adev,
-                                              &adev->gfx.compute_ring[j]);
-                       if (r) {
-                               DRM_ERROR("failed to map compute queue\n");
-                               return r;
-                       }
-               }
-
-               return 0;
-       }
-
        return r;
 }

@@ -685,7 +706,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)

        amdgpu_device_flush_hdp(adev, NULL);

-       if (adev->enable_mes || adev->enable_uni_mes) {
+       if (adev->enable_mes) {
                for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
                        j =3D i + xcc_id * adev->gfx.num_gfx_rings;
                        r =3D amdgpu_mes_map_legacy_queue(adev, diff --git =
a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v=
12_0.c
index 76db85157bf9..5519655fd70a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1357,6 +1357,10 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_devic=
e *adev)
        if (r)
                goto failure;

+       r =3D mes_v12_0_hw_init(adev);
+       if (r)
+               goto failure;
+
        return r;

 failure:
@@ -1381,7 +1385,7 @@ static int mes_v12_0_hw_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        if (adev->mes.ring.sched.ready)
-               return 0;
+               goto out;

        if (!adev->enable_mes_kiq || adev->enable_uni_mes) {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{ @@ -1425,6 +1429,7 @@ static int mes_v12_0_hw_init(void *handle)
                goto failure;
        }

+out:
        /*
         * Disable KIQ ring usage from the driver once MES is enabled.
         * MES uses KIQ ring exclusively so driver cannot access KIQ ring @=
@ -1498,8 +1503,7 @@ static int mes_v12_0_late_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        /* it's only intended for use in mes_self_test case, not for s0ix a=
nd reset */
-       if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &=
&
-           !adev->enable_uni_mes)
+       if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend)
                amdgpu_mes_self_test(adev);

        return 0;
--
2.41.0

