Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 07:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87B760FC4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 07:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A87B760FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD97F6E9FA;
	Fri, 29 Oct 2021 07:20:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128886E9F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 07:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VULpAZoxh8ZJmqXA+i87qIDcE5fHtPMew87qCfu36R8NqefuYhN68tME7+NMhaJNLbjG4GL+egCHg1vcKS/imcZpJJDNGw5Ywos5AW5C9Ko1KBrma0w8vkGOlZHLuE17C2siXgRVt/83oBsbombXi5TGIZg/hVbTO2Cq7iTY2IHBYMcSi4pmucq3gETwZWnZS2BpFAC2LTBgUgKtibwoQe1k7/HY2Depgf3igTkcd0m0upBNvhDF+3fSODC4pKgSb1sEwuRXRPmT/Pt3bIWmnzZZZobDyUoe2QTC2jqYLUqiDV5GjKBaJ6fKtfDI1CvQikIo+CgbhPQmKFtRsvP9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw6RdFyAauoGxSDiANR1WhggyBhnxBKNixmHIGxksKc=;
 b=l8Y9H84twFGCuYkGD663bn4nAPL+VJqQxWkzBu2YumZI6yZrNMtEa6Uu7pDPmC6Mdzwr6QHFe7e6YyD49tOmGrd2wRYowvM9VeWPBsWUwPgzntVzvCNXDss69CIj8lpeWq/7MTHV4ZHSwald/vAiC6b5CYksdiAZdjZNUJfqd0oAF46Zf9Q/gSqa+tkNxXbrwDIFzPg1NFjCHaoVYbBoLVbnQdUez/qwC2Px54GVRg8slOvcYg9VM+tN5wEkmV4A+GiWyhCRqcdHyGhzjNDoG561XxHWmotI3XVUxa1SOVWNnFLf18VN3FU7D5bjng7WKmqneDTRKHX/VJ0GZTr6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw6RdFyAauoGxSDiANR1WhggyBhnxBKNixmHIGxksKc=;
 b=VVmx2GCnnXsrvIDJsBdL/fw+l9WcMmolDKxJRHwRoMRxiU6B+RNH850IO+pVXfTHNZcbfnfJq152yxNUB1QvfbvY6Cg1b9JHlFc3sOngGbD3F8B7cNBRuBH3EJ2833cOtm+nJxucnXMTzQaZ+7vdkfxPkD++mO1/gnxrc66ZE2I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 07:20:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 07:20:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Min, Frank" <Frank.Min@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Oak
 Zeng <Oak.Zeng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use correct register mask to extract field
Thread-Topic: [PATCH] drm/amdgpu: use correct register mask to extract field
Thread-Index: AQHXzJUFU9CV+zyoxkCPk7ju2U77lqvpkYkA
Date: Fri, 29 Oct 2021 07:20:06 +0000
Message-ID: <BN9PR12MB5257E6A82D747B0134A65480FC879@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211029071657.2013815-1-KevinYang.Wang@amd.com>
In-Reply-To: <20211029071657.2013815-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=af5ebab3-764a-4ade-87a9-08236efbf329;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-29T07:19:46Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85e2d041-b4e2-445f-67c1-08d99aac8861
x-ms-traffictypediagnostic: BN9PR12MB5114:
x-microsoft-antispam-prvs: <BN9PR12MB511495B64F74790B5A8DE452FC879@BN9PR12MB5114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYvSLizGl7Qf5IsrfrIomhu239zCAoWuLAdbacGrcP4wn6Ozm4Gtlj4f57uSSnx5c4ka6LdnzKmD2qEZ9JmVyAvPOKe+n+lLjNbz61A1WxA+xFONYep0yItaiJ/y1UrTbpraXm3Qq02U78riuyTIFDft2ogO55tfyLJOJF1s+ey0TBch8S/ofbY7gwWPEgCI2CcVoJ5toPhXF5bh9EcdR5ZFe7Wbg1UTc3Hmt9yz0ZD5juDYrTAuFRM9XmXAnq/B8TlfgUh7kOmvG8qTcE844mJ+qA3+a7jrcwXG2Z3jGrMdQAgqaYd/HxvOx2cf/ppzdbdBuP1bLV9tI42GXp9ZKRtVcxXCsLnxvx62uOFkbcwC30FnkEOfP7xzsuPYsCY92N1J8p4u3JFJhRo6592RVd7dpnw/LAqPOKlGzH6RzKOPOduSLh7rKr79L4vu4cD1r6hllMseWFcLqU/XKs/IkJ7e4kZRprePyK7dsWsaww7OMi20IueKq7Xc0sBOfh8NBQMK/x6BTDBA8oDAujfjj0iMaL/PkwSQ+VkD9Jc/ZVdFCh9UJrXM4HF7OrwjgtipFP7oTARE9fCqH3aaH5gvOLVSQMa+riaYLcGVIZjRvhrrCffd/8V4qquKNLrSENhg6nG1meMrvgccVXDfWCm+/U8mj4MDG1sjolFT0ssQyXpcaJgi2NSbGMhyw1rDyOXWMKCdOJ34sNIxemcGLlRvxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(53546011)(6506007)(54906003)(4326008)(5660300002)(110136005)(52536014)(508600001)(316002)(38070700005)(66946007)(26005)(55016002)(86362001)(186003)(7696005)(38100700002)(122000001)(9686003)(8936002)(71200400001)(33656002)(66446008)(76116006)(66556008)(66476007)(8676002)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koWRk606s8tYTFX31fOwls6Am1GyQJ+oewWsaQHV3RD7BSmWTEp7Za+tLU77?=
 =?us-ascii?Q?DqV7oChZAnL+oAHMYPV+nTho0rHuwanYTajmXrxHGgKoj3tVrno3Tk0qsuRf?=
 =?us-ascii?Q?RUZEG+pXtim4bYuPtfdsCjRwhWHz8LYf1/qcOSQNKzQk2ElzTgdcWtvYFMGv?=
 =?us-ascii?Q?V4QhY8Q4c3urBE9iclFxuz3QCj8Ui7a9Sy/xoKk5zKuim3rMOxrXugdNNZss?=
 =?us-ascii?Q?Rrs8UwnnZBTPCLUkqbGzqILtr/v0BE8IBEqfHgn4V9N6xzZ+mFt6ydn/91Wy?=
 =?us-ascii?Q?1lQlFAxEvu2a+2mIV1gWfuVTR6FEOhqpdChsPX9N76LkHXVZr/32soxn+wg+?=
 =?us-ascii?Q?+bPUoJwIh9dTL+vWhO24RbpZ8r1AZN7w7r3F++mizR+bsZIy5tFBVhKFPRYq?=
 =?us-ascii?Q?/xZOLhKt8HJpaUjJgrzF590CQH2IxCGKyBENU9v9JtMVF7EvufR/UM85vZpl?=
 =?us-ascii?Q?xX409otiI73X4qlwi+AtkIPqvj+HRan1GhWe4BvSIo9V02CngTVfGvIIBW1G?=
 =?us-ascii?Q?6WlwlFxv/IM6cfk8ed9Za8ONA4m25KuGvVSfdwtwJLHDktQ+bcb3Irxm7Rn5?=
 =?us-ascii?Q?LwFZQHdjzCIljS5rq7Aj58NFTZth9m5r16bYedvMnkM0T3Qg7Ud7RW0lFXyr?=
 =?us-ascii?Q?Fx7ZIbzSuKK4hYKmK6eNJOoNHLFwShLfCQvzJOkqyDunskQ6ysMzO+Fsa2Pt?=
 =?us-ascii?Q?vcwcp242IF5FdksXVp1sBAae3LZOR6F5u3iM+r6naBAxNrkyem87siAKRqiJ?=
 =?us-ascii?Q?DRHKDnZgbz/1/uhqQ4p4HpAsPR/Yhzx9Uv9ZQfYl0GGiIVDMPDQxAMfr/dn7?=
 =?us-ascii?Q?FanY50q3CPJN0U5NAY9S684Spb73O84GOQrMSs/tTlXeT7sthn/787vZAr0Y?=
 =?us-ascii?Q?yXuXubUYwlJ5jzHUfctY+iiLpFA39baB+871vV2HLzItaeLcy7Wm1kjQD0f4?=
 =?us-ascii?Q?xrPn2qkrSUAJT0rgU2SID/Gpd21ZtFbdHhWmeas6+p3ks62mhUfFPhRmVGEQ?=
 =?us-ascii?Q?PvCLwlyqtfIbW+SpW3XJkVQLK74JV+tZNQhO8a8yH7SEUnv3vdHDLuYbzvP+?=
 =?us-ascii?Q?0jyt372ZtESHmdLkEvrM4ab8jLB924VwzxtyQvuM89+UwvsUOThbgsrxWhbV?=
 =?us-ascii?Q?bMfMVbtR/xlxxBK3A5j/keudZHhEbLhLwscAvUyk2VU9SC2Bd02BrLZ5aB1R?=
 =?us-ascii?Q?yJUcGIRoWDMJZQoONbyTOYKrQAeW04LBWh5uqSAsV1gfNAOPK+zw2sffA27+?=
 =?us-ascii?Q?EuTonTp2UT1mUGq3x91+swG3ffQ+j9nldWZBI54LbQM+emb0G/DHNTE5JMim?=
 =?us-ascii?Q?oaWZ9riBKfuSwQk7FX43qhxE0FHGJR9lVhXTJclPtrjnhsyZwoyJtE1rjcdG?=
 =?us-ascii?Q?FhpVHv5sTpxzPxMLXLD51sf2LwH7nUGlVTNe0yEZGa+FC3Mbszwu8oof3oRc?=
 =?us-ascii?Q?SF01lOqwMhPfLFbKacD/5Jab7PTy0NVbZivuLObolka+XzfB+r5MJCV94i6E?=
 =?us-ascii?Q?oDXmDRTmN5r/V+XDJ7iwatBmVFftjqVQS8YShM2F9ZKiqW28o18r+vypjPyM?=
 =?us-ascii?Q?nn0t8aOCi0/emmC87tZ5uKuS82BxzV51NV5jrM3S3udeHLCLKKYaDq2DTKyE?=
 =?us-ascii?Q?o/idKLUgHRrwkKMoCb2DBzU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e2d041-b4e2-445f-67c1-08d99aac8861
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 07:20:06.1668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUvMuAE17ZhrFQALq/HWHbR8eRTJ+2WhOI/obxWE5UsUTg7KKAFgFJOlmMZbhlpjTMytuFCKr3zYWyjE3tLvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, October 29, 2021 15:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.com>;=
 Lazar, Lijo <Lijo.Lazar@amd.com>; Oak Zeng <Oak.Zeng@amd.com>; Zhang, Hawk=
ing <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use correct register mask to extract field

From: Oak Zeng <Oak.Zeng@amd.com>

Aldebaran has different register mask definitions for regiter MC_VM_XGMI_LF=
B_CNTL. Use the correct masks to interpret fields of this register.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_1.c
index 497b86c376c6..90f0aefbdb39 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -54,15 +54,17 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *ade=
v)
                seg_size =3D REG_GET_FIELD(
                        RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE_ALDE),
                        MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+               max_region =3D
+                       REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL_AL=
DE,
+PF_MAX_REGION);
        } else {
                xgmi_lfb_cntl =3D RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL=
);
                seg_size =3D REG_GET_FIELD(
                        RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE),
                        MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+               max_region =3D
+                       REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, P=
F_MAX_REGION);
        }

-       max_region =3D
-               REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_RE=
GION);


        switch (adev->asic_type) {
@@ -89,9 +91,15 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev=
)
                if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_no=
des)
                        return -EINVAL;

-               adev->gmc.xgmi.physical_node_id =3D
-               REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL,
-                             PF_LFB_REGION);
+               if (adev->asic_type =3D=3D CHIP_ALDEBARAN) {
+                       adev->gmc.xgmi.physical_node_id =3D
+                               REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB=
_CNTL_ALDE,
+                                               PF_LFB_REGION);
+               } else {
+                       adev->gmc.xgmi.physical_node_id =3D
+                               REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB=
_CNTL,
+                                               PF_LFB_REGION);
+               }

                if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
                        return -EINVAL;
--
2.25.1

