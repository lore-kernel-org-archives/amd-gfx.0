Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581DC8303D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 02:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8740210E302;
	Wed,  2 Jul 2025 02:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbUFYat1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C9710E307
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 02:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpxXOo7yiymtH/B5JUXQbVYp7zg+/OgwkEQbIkgOuactaUWaE6kPWw1yk8xqeNnr7A4uky/uSnz1eo3ZTYOuMHhMbN6PKwwjaLGiCSpg+3A7E5D9K6JL46aaasE7aafVuxIpt/vMThpWr2dc4P4QPWYzvbk12mJcyZm3PQY2K0tmJ3AeTFAjFdBnu8vbh0gIEq5nHbE5hjUgdxuOL968NvckwXCB/sAWUFVbs3WeWqhUrvMlgXD2/uYkukp5tXr8ko7BmKSX3WPcopsRPOsq2rTw1WpTuQ0rcw+NVMJWoZspKra97KNkFCu/1gjtlgU36AwsouCBK5yXt7sLiq8lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15FgqX10ZPKTV2KoDYwTrGOkKhF+jqgJWa4qWVs0bDg=;
 b=ZXRTUMSgCAOPdssVMRC6p3Ipgs3VdZ2GoxmcNtjIP1LZGRsjvj+ALmdiQ493H5mLIEeaBeD7foUw6+oMBHjbkDd/UW+EeXEW0XsXq5hrUOtYQ/RJE+TqVSOAz4OijjNClknk5C8d45Ky8Vj+fucHceOVXC8sLbOtOgRJj79aGxA/3TLRhOS47YktARQtbKwSYO1scOl/Ci+9CvIwc6VB4r/H3C67lGIn+vtnEnXFIJ78k3k/jrRCy0bZD/D4DjxtXBa1eGBOYCtlvDiTOjV0AvHmPL3VB182mX6+4lrxlYe6vf5BkPM9tYC5sPA2nIE7yNHSGSzYMT3ne9ZdC8pL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15FgqX10ZPKTV2KoDYwTrGOkKhF+jqgJWa4qWVs0bDg=;
 b=mbUFYat1nsh4wroGLr9Vcd413EwdCi/qlBqNU3PQbRWpEpJO4WfHe2bm69xk+Q3AfiJHMNpJ26zxdM+Ss3/4G7Cq2krU+GZTE+RZg65eQn7UFW9wOCMQj7MXOj0xiLPzn9Mvhg9azcwNMAIHd88b3GT0VDsSK0cIGMnrH5Deakk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 02:40:47 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 02:40:47 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/28] drm/amdgpu/sdma: allow caller to handle kernel
 rings in engine reset
Thread-Topic: [PATCH 02/28] drm/amdgpu/sdma: allow caller to handle kernel
 rings in engine reset
Thread-Index: AQHb6rhMQpneH3KkAkqY34sXtR5v1bQeH/bw
Date: Wed, 2 Jul 2025 02:40:47 +0000
Message-ID: <DM4PR12MB5152BCDDDF544713F673379DE340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-3-alexander.deucher@amd.com>
In-Reply-To: <20250701184451.11868-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T02:40:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6371:EE_
x-ms-office365-filtering-correlation-id: 743b2072-b101-40a1-da05-08ddb911d99c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cj2YGF71/1+uieoQRnE0i78+GG/w5gRtpZmh/NL8iw5Gad9ycsVeCWgqMBiv?=
 =?us-ascii?Q?DN2p2IUJTHfrEo2o03f9YHq4mJMccrCxix0jv3gP1xFTNIvtCunC8O06eOJA?=
 =?us-ascii?Q?hWmxXynY1/Z4BU6p2heizu1jOs3Ih9NA71tvEqPpjJPtxrEP2xtm6oSuFgt4?=
 =?us-ascii?Q?jbjSfdj0KOuCT8EQOUftru1M/IvAA2BpZdsD+cnvgWIeE3oz4m1OZpGTj7BE?=
 =?us-ascii?Q?687Ji17Vg78O07FBnaWgXpt+Gg0tTq9b5pdqRIH/yDbem0wIuO/m9tJiG8yA?=
 =?us-ascii?Q?zsbfB1f+bBzvxsIuR5h8t09CiVIpHhQuMBFt2mtEuTPodocwJr/IlyXDv+2X?=
 =?us-ascii?Q?SHoajamVdgZF7hA8JdtwBnNUi0jEmd8cOYWGlbNSp9OBqD7KH/WUxeiKmXuQ?=
 =?us-ascii?Q?7tdvxJilKIeVzPanrRMDSkKsTjjRPC5GAG9LDrF77x9e15PAy4ah9AmaE8Bv?=
 =?us-ascii?Q?sXodc2AzWacDYVCRVKz1dPU5eVp9oCKTbrMD0dis/wdFJE01xgS+rFredliP?=
 =?us-ascii?Q?lmePs/f0/1cwQLB2fgf+KOoSzO1X2RUvO0O7q//vRTTmvCmsbvno2Ud8ayK5?=
 =?us-ascii?Q?DCjXme8JuLF3lvuL6yfAT4XRx/issZ7+KH0LShZdhJykbHI99K3szM3sJBBm?=
 =?us-ascii?Q?DSWTK0NkAaJtcCPtfpKnVYeGnYiYFwfK2uL3FRO+9Zzrwsi20m1eZWR2cSXF?=
 =?us-ascii?Q?r49kLXXc+QGNCqRTHB4K2J3ChOalob9FcTE81HHUyXUaI0VjWSUVtUcGhppA?=
 =?us-ascii?Q?iXEk4W5aPnR8/YKAo7c0z8IVC97nnBpDJNwz0zQY0qPQAUBpze0J4/cGezJu?=
 =?us-ascii?Q?tGw3q/1bc+vTQl52mNVbK2+eUGecM0f8zeKGBFbd0uzV3ivMdhfkZ1c7ARpF?=
 =?us-ascii?Q?tBYWAL0WDcdU4hM+KXHei0H7u5M42MF6zN9QkwfhPKZf8bFVCGZXJc3GCU2i?=
 =?us-ascii?Q?HHQHpdw6DHjMf4Mc0EFb/WrsywrNUx7CGiNlKfWkSPta0Nw20LhrF2PbYQsn?=
 =?us-ascii?Q?EqgYbbSSD5CdZS/VhMTCTozb07F2YkVJtBS/LVqfbYU0BT7rfiQtA1usYX7r?=
 =?us-ascii?Q?qNr3VZHlak+73Ne3CbZbHMlIrsXa8mqMymJRELlTbchKZB98I54HdqoGrDr7?=
 =?us-ascii?Q?wA7PbUh2Q8UIxSakwYqfO4fQP/Ud6oVxwsz494vikNGr8lHWarrYMVHCSkoW?=
 =?us-ascii?Q?FOZO8rRZsMe+CrbDmDkIPxxRdDa7SaCdbJmKCDP/p/UflllI3v5zQkAZ1nVK?=
 =?us-ascii?Q?8EJigWroOh7OSSAhoR7HeD+7jiTRrgioeptXodrWwwkY8DTenv/XXdMUfM1p?=
 =?us-ascii?Q?w0BNxf1dj7kJegvMzwU+dSYFHk04b8ah6XTC4ZC83t//EwoilOol50mQyu5l?=
 =?us-ascii?Q?HW22Ny+/9Sku3Kw880kyELxB+zWkA4D0XacNpxgBlqL7SEPuY9UCPRMh0FhB?=
 =?us-ascii?Q?weSkjD1L7HyP1Qs6+aE4d0RU/+sccd+ijF+aa860ZPc5IJM37TCeOjiVcHXb?=
 =?us-ascii?Q?I8Tc6uHPABsHl1U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdMyo0Wm/+4+PsRr1JU2vuYChPKXo8j2BYru1tsaI8FkUs4NTZOPIiP8oqcD?=
 =?us-ascii?Q?9c78HqXxCm0Z1nsuaqpmwoc+rLHG0VNlTqTe1d585fO9xP3zYUFbtqhCYGeO?=
 =?us-ascii?Q?vRKjGBU8VsoDmAlSZ65jJBrXI6XQRS8gYb4h8wXEFkq6QBH360e+1d9xVIsk?=
 =?us-ascii?Q?olNIddKN+Ju3qOopG4VqPUJzZd3KSbbPUdYGI+jl7D7LHUxQDm8M8RXxRHlg?=
 =?us-ascii?Q?paJrAIhUj7TYPWo02LRHSDM5DxkOaO/IDCtEyYAWp2ehbCogBCYc9CF92+Ft?=
 =?us-ascii?Q?BJ/cfjrmJW4DVxS+gq8BKb+6KuC1jAs+5UM1KdAJJBeoND2CVIR6iwwcHJEh?=
 =?us-ascii?Q?2WLxgbEUys6jP1cuqOX4w4Khsi7vzo3ubkl2VR5belrXUb0LDYJ0So9f3sov?=
 =?us-ascii?Q?DOXTJenFPzHAvVsY/ixVXTKH29G+mFfR2pKCdYK1DyH4Pihq8CDnDsQDjREr?=
 =?us-ascii?Q?U7p7GKvhw8xt10R5qkFQWi7np6vC+lAHQjC14djLkD8Oxe5+Fv4+jhTGKRAH?=
 =?us-ascii?Q?OBAwW1IGh3UYmj30tlT3voKgzi6+M3xfqE3vkHNk756SlfOhraVvsCozViRH?=
 =?us-ascii?Q?OOAr8bW1aZOz8sNM1Yenaz/cWpC7poq1LZbPpDImXCiWZYIPAKPShQR5f2Jh?=
 =?us-ascii?Q?hGSyOpRUfxPZli6cKxHUt/0VfVC/PeNztbE4RFn8/Ig8dRiycTweaEDOkwXM?=
 =?us-ascii?Q?6j+6igABY9u6KbL0K40KFhLgjUga2OK6CEsT84vJNIvoFU1Xfo1EBT/5Owdp?=
 =?us-ascii?Q?DY317tjDRkNpZnsBEVO6Dl0V6aal5NYT9R5FqKy0k+VygNFPg983HiblJ121?=
 =?us-ascii?Q?Gsg5EAQ1BcKLAo4A+7drmmyqCrqMtgWUvFNZn5x3zAUs5adZwaoWvoA2W8uo?=
 =?us-ascii?Q?vTESHeMQAoXwf6aEou88PL+CH8IUMdRrV31nJ6EbPfoE43GqBK9R3da7pv34?=
 =?us-ascii?Q?EV5llguQFTFp7DLi0n2BzqU5Al/UVQOcalglW3JiEJgg0HquQOq3oOYHX1de?=
 =?us-ascii?Q?t93UMjGOjudXbAi8cdAYNnZA+2dnlPudHWixK8F1SAQI+T2nxmf/ztpT2Y7u?=
 =?us-ascii?Q?UU/PHx375brzjOv3grT53Mi1ukwfGhm+yxej/C50wZ9HRhhQ1I3ZClh8sdoz?=
 =?us-ascii?Q?Fi1yEd8bBMxpVx+mhGKIx6jKCdHfvrJwbNNQvTS3fO6L4ds2TbKiz13nHh/U?=
 =?us-ascii?Q?LN/OBspmG89RHAQ18wcPwYIVcwiwCsQAaDROk286hfvKE5iFsNe1w3zqesOt?=
 =?us-ascii?Q?Zbjr57j22iCI6MK8XwFnhN8SXdtNyYiWczvdojQoowhkApkDOWlpoQgKjW+M?=
 =?us-ascii?Q?9ZMSxhMyi5iAzRsHp26mc0pRP/QsrgL7hm1M++kAGnsa2fvai00L8Oev+gu+?=
 =?us-ascii?Q?A+v/Cx0kiNJgzHmq3R7nE1oPccdfqgJpoiWAvtCGNLqCN8y7oAezGElO/aSf?=
 =?us-ascii?Q?/00+74mIZT1O5KqE01wrmAe9ifsHq93R743h2GwRbFoZ5EfHvHC/Hkpsh8bI?=
 =?us-ascii?Q?9STlo3YRUDHRTGOoJfbScPo23BpK6vyNXK9Cd5v5Cg7rna3W0OxaBSovlqgk?=
 =?us-ascii?Q?5/JZpZWW4+2cMp/CPmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b2072-b101-40a1-da05-08ddb911d99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 02:40:47.2742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qn6b2JKujxFr3BIxy1OLH4NRqrHwF7xBTlCJAx7MsGF8RWZsuuomECrQP6u7OoBIg0xAcea7w3wnNR/JNcu45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, July 2, 2025 2:44 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 02/28] drm/amdgpu/sdma: allow caller to handle kernel rings=
 in engine reset

Add a parameter to amdgpu_sdma_reset_engine() to let the caller handle the =
kernel rings.  This allows the kernel rings to back up their unprocessed st=
ate if the reset comes in via the drm scheduler rather than KFD.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 44 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 91e8f45fe886e..4f98d4920f5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -528,10 +528,13 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_devic=
e *adev, u32 instance_id)
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: Logical ID of the SDMA engine instance to reset
+ * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
+ * will handle it.
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance=
_id)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance=
_id,
+                            bool caller_handles_kernel_queues)
 {
        int ret =3D 0;
        struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instance=
[instance_id];
@@ -539,14 +542,17 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id)
        struct amdgpu_ring *page_ring =3D &sdma_instance->page;

        mutex_lock(&sdma_instance->engine_reset_mutex);
-       /* Stop the scheduler's work queue for the GFX and page rings if th=
ey are running.
-       * This ensures that no new tasks are submitted to the queues while
-       * the reset is in progress.
-       */
-       drm_sched_wqueue_stop(&gfx_ring->sched);

-       if (adev->sdma.has_page_queue)
-               drm_sched_wqueue_stop(&page_ring->sched);
+       if (!caller_handles_kernel_queues) {
+               /* Stop the scheduler's work queue for the GFX and page rin=
gs if they are running.
+                * This ensures that no new tasks are submitted to the queu=
es while
+                * the reset is in progress.
+                */
+               drm_sched_wqueue_stop(&gfx_ring->sched);
+
+               if (adev->sdma.has_page_queue)
+                       drm_sched_wqueue_stop(&page_ring->sched);
+       }

        if (sdma_instance->funcs->stop_kernel_queue) {
                sdma_instance->funcs->stop_kernel_queue(gfx_ring);
@@ -568,16 +574,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id)
        }

 exit:
-       /* Restart the scheduler's work queue for the GFX and page rings
-        * if they were stopped by this function. This allows new tasks
-        * to be submitted to the queues after the reset is complete.
-        */
-       if (!ret) {
-               amdgpu_fence_driver_force_completion(gfx_ring);
-               drm_sched_wqueue_start(&gfx_ring->sched);
-               if (adev->sdma.has_page_queue) {
-                       amdgpu_fence_driver_force_completion(page_ring);
-                       drm_sched_wqueue_start(&page_ring->sched);
+       if (!caller_handles_kernel_queues) {
+               /* Restart the scheduler's work queue for the GFX and page =
rings
+                * if they were stopped by this function. This allows new t=
asks
+                * to be submitted to the queues after the reset is complet=
e.
+                */
+               if (!ret) {
+                       amdgpu_fence_driver_force_completion(gfx_ring);
+                       drm_sched_wqueue_start(&gfx_ring->sched);
+                       if (adev->sdma.has_page_queue) {
+                               amdgpu_fence_driver_force_completion(page_r=
ing);
+                               drm_sched_wqueue_start(&page_ring->sched);
+                       }
                }
        }
        mutex_unlock(&sdma_instance->engine_reset_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h
index e5f8951bbb6f4..34311f32be4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -172,7 +172,8 @@ struct amdgpu_buffer_funcs {
                                 uint32_t byte_count);
 };

-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance=
_id);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance=
_id,
+                            bool caller_handles_kernel_queues);

 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_=
funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))  #define amdgpu_emit_fil=
l_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib=
), (s), (d), (b)) diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/d=
rivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 572d105420ec3..c0c418aa2c299 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1668,7 +1668,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring=
 *ring,
                return -EOPNOTSUPP;

        amdgpu_amdkfd_suspend(adev, true);
-       r =3D amdgpu_sdma_reset_engine(adev, id);
+       r =3D amdgpu_sdma_reset_engine(adev, id, false);
        amdgpu_amdkfd_resume(adev, true);
        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index ed1706da7deec..5a1098bdd8256 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1548,7 +1548,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *=
ring,
        int r;

        amdgpu_amdkfd_suspend(adev, true);
-       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
+       r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
        amdgpu_amdkfd_resume(adev, true);

        return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index b87a4b44fa939..6843c2c3d71f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1461,7 +1461,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *=
ring,
        int r;

        amdgpu_amdkfd_suspend(adev, true);
-       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
+       r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
        amdgpu_amdkfd_resume(adev, true);

        return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a4..f0d19f6ed9ba8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2312,7 +2312,7 @@ static int reset_hung_queues_sdma(struct device_queue=
_manager *dqm)
                                continue;

                        /* Reset engine and check. */
-                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
+                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, fal=
se) ||
                            dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->d=
ev->adev, i, j) ||
                            !set_sdma_queue_as_reset(dqm, doorbell_off)) {
                                r =3D -ENOTRECOVERABLE;
--
2.50.0

