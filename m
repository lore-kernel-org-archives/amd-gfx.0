Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE102C8303D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 02:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE310E2F6;
	Wed,  2 Jul 2025 02:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dq1Mj4y2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B4410E282
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 02:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8h7jjCpg1K4U1Q0e94lqL2KcpRYOd145nkyD7MKFjCyX/Mvog8Unak1+dsJ4DH6wlbFfgyufoPjcQa8v5RqmmZjQwPkabPL64KDO2dO5wyWUvQb8CA9c5YoCMKyBIQt3ixzVJX0XqrOW+XxddN9P+yEB3WWkLTxQAyp0aJRF1ZyrieZRSuqlmNraMCBhMyZb//j13Wi5yI3jCT2HkgXjqYi8FbhrR5CevIBzwh2ADSGjwwO7jrMY6iP8XMUMfZgPCZuS3LTNDqDmRaVW5B9UsjTW7Y/gZA5uvxkTnVJ3xXvvE3F/Z39uUmEK0TMrH17vAjgzdii+XkCT/k+5eaRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJSQQYLhFTFTByNaEiW1FEmNuk1o4RSW5ViDtOWvqNI=;
 b=VnQ4MoGHYvAClUJaWrQc2r5T6+o30d0zuxLhyNM/Ub8rGJOvWnI+f6dHP9gmApi7uOSJudSXGmwTvy5VHF0Ium+rHfmnBol0GKRPPVB4GU0gbkmQGTtjqO4d3mcFkHEFb40mNIyDjHFJ435dgZKUDBjczUwwOkMxJmKe+3mARIfE1MbKbPXjYqZKisDt3aJUgLTPQNQ9lLvKivEutAII3EQTlndEJGzvhCE54Z3E5z7eE1D4p7VKha3/c89Dv0iqknDyLy59Z86eulMK2xWFBah2p+UOPvKwMwuGl5sDtySz71Z74xwrETBjN2FRiECOIC7bd57KobpD99IrBtVobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJSQQYLhFTFTByNaEiW1FEmNuk1o4RSW5ViDtOWvqNI=;
 b=Dq1Mj4y2EkKgsTVAVmFkN+8MWvx7AZr7DCTzYB5LIZGMeJmNR/FH93bO8O50dUF4Ig6332CMce+z52OMEWv8FkoNhAQJ+0PPHghI702Rv+JuTBkkt4aPmsXp96PcYEBYOEwyMQNfNLTKCJOvwfcHgqAFFp6F07/xY1D5AO+kFGA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 02:49:18 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 02:49:18 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 12/28] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Thread-Topic: [PATCH 12/28] drm/amdgpu/sdma7: re-emit unprocessed state on
 ring reset
Thread-Index: AQHb6rhNvduWoYTE+UWRxCXtPTLUZ7QeIlnw
Date: Wed, 2 Jul 2025 02:49:18 +0000
Message-ID: <DM4PR12MB51524EB7C84A5A0A38F16AE8E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-13-alexander.deucher@amd.com>
In-Reply-To: <20250701184451.11868-13-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T02:49:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6371:EE_
x-ms-office365-filtering-correlation-id: cefad657-d9e7-46c0-1066-08ddb9130a45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZsXF4dPwpa9Gh2Lo1hIdpi3Xm5W9ERw7IoYftnRGQbiAwYmMT4GiRXej/VVr?=
 =?us-ascii?Q?rwHGBLauuf88rVEzuaE42oKW2/3VTA+eU0vIQ2vGNsmrOtThFB4Zfiq+fqTc?=
 =?us-ascii?Q?lBDZHzOYC8ZSQDqD7DjeuacRsp5Gwn7o/+J2Q7U+GmLzZWex4+zcV807cKpn?=
 =?us-ascii?Q?GsJ/cTAe5PiyvlC91kHPrFmFnL/qiHeP142TYwPPkBx8y/ix4g76J626hsRq?=
 =?us-ascii?Q?INn07hZcomwKsyDw2jL3gxfil9i0B4ljEgbPQcB2pcccYbv+rFP9IrqtlTcf?=
 =?us-ascii?Q?lwLyrYlalEGljHnMrU6pr1LAxIHOZTYTvVfGYZ73dIXmdR7OYNxbdu+5+cKu?=
 =?us-ascii?Q?wtWcgfniqjj5GbaEnfQAtd2DLjLUmVkGk38YVJtQfStNczCRZMqCIlQSzv73?=
 =?us-ascii?Q?1mDg5WL/H/xiT2RUafTL0+U8AtaWMAtaj53kYIDpXTFRPgZ0fwJnAru8wVXu?=
 =?us-ascii?Q?aEdroFepwNzOK34Fw6fjcHxuz9FWkKt/xhb7n/a6TOpl2KhISJwUSxmH5UFs?=
 =?us-ascii?Q?d6mAF3DnGdeEG87J4HxNZ1Xle8NNoOPSKEJLqyMbTdzzj/rEC0Im6k00lLjJ?=
 =?us-ascii?Q?HfAt+CWhA5tfbJaSW59ASgmRq7288oFyinytndx4kJax5ldVp/tMBX9qM0qm?=
 =?us-ascii?Q?I0r+IDx0/8Yap3QD/BYDodUpPRGGnp+kovk/rTC4BiEs1zNUzsDnLi+nyrEK?=
 =?us-ascii?Q?XY5YleerVeVY4CaNQNAGp8RUalNBkJhnlqrJmAAB5J0PLIN6FVjJYMbP7dCG?=
 =?us-ascii?Q?QAkM+FHAcmiz6yMOaC3S9asblTg/ar+ZyDnuCziy4UOQrPamqWNWckcQ2XBx?=
 =?us-ascii?Q?90WL/wIiB52Q21Mia4IeVop0OoPu9TKMogHXsBwrbBOUvbR42+zIjqfQZeTB?=
 =?us-ascii?Q?/oBy6gOTrMHUyB5+lpsEmMOUytnyEuAxIFM88l0BJ5UVHxLRUog+MKNgKh9k?=
 =?us-ascii?Q?1TBhhsSS8DLVcUKO6lYhH9rUutTx2ENUkGOCFo6I+q9zYJtf7ti9bH6VKgjI?=
 =?us-ascii?Q?/9lffkb/DhsuttEkaiarN6OJfUl6h6ssiVPtcCzgZ+v0ynUzTPFUtJoJhf+1?=
 =?us-ascii?Q?at3oMECbAvjTIAHrt/GiS5hE56sOq41OLHgnriC5lZxthrWyfO7RcIL0Oysd?=
 =?us-ascii?Q?GekL21Sn6ATXrXbEDjdHw9rJmtgQ2B8h70AbPQUuMKoyWoiozX9xidNLX1B4?=
 =?us-ascii?Q?2jJsQBGETT19AXdijQafoLd9Kb8H92LlohT3BPzX9Oy38QW3BBs0NYN2F6cI?=
 =?us-ascii?Q?spR6sbELq4iaGBEzSFanTTICuOOTGEpE1Aip7J0PXZDrrPAH1yh6TCF5e91J?=
 =?us-ascii?Q?diY5PyMJyJegYIOmL9jCnJ4mAIbuiDYR/NG3ybQOfedpfvgKlD/zMUv3r/HH?=
 =?us-ascii?Q?xyDFYq9dRtPf5ZPgTOrywvWw+ZleZOlmv8Ddo5FuMdCVBe8pxQkTFwhme5ex?=
 =?us-ascii?Q?lBm9fRNZbI7FgaDxgpyYANAsGqbi/tJHciGW0j40vVFRsRPchGu2IXxlUP0s?=
 =?us-ascii?Q?wWGbF8dqWNQrWEY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qfg5QoidRiGEZGXK2ZS6Y/fyZv/yhc6nSUoEADRtZcJhweegz+OJ3JY35flX?=
 =?us-ascii?Q?iBwZOH35lj1QWeEGpv3WV3SMUx39X2uvU78WelSaiKza75HaZtZhjRasQWjc?=
 =?us-ascii?Q?y33gI5Hvt0hHM7EDc3TJUXQbkmPMi0IOek7zy8CVjx+oGLLulKrYoK6BdFz4?=
 =?us-ascii?Q?o19GQBVH3mCnwjm3poCjXkhUiEuMr3rvFCXXviVeyvVW6ML/MweFDlyVTwsQ?=
 =?us-ascii?Q?58/jOrjVhP2K69fMFHN0Pphl+oCDvCwxEq3oqlx2kg6v8VxR9fxPFWH2t2pV?=
 =?us-ascii?Q?swwyxqTGkm39U4bBKa8L3JE5mkEy+kyQjHBlnKb/3YBX2YLvk94p27HETT+Q?=
 =?us-ascii?Q?sBkq7pDfzY7YW1AU0KzrbmuRr8uI8M2UFxDGPaSZKT+dK6TOXwNzrjLEMea2?=
 =?us-ascii?Q?wGcjrgut0W3rBqsawcCLucajKx7qQh1AvnCM/2z1RE+LHTzKbReUXquXyMQq?=
 =?us-ascii?Q?E9hiT+oCjLsw+n0qlFmPd39jD9V2mpmmqx/bQJekfCc5pSi4EiKpylLW5XL6?=
 =?us-ascii?Q?Cpm1fTnZNB01FvweT1NdcROmKTOhqMUmqcCTpYy00/3cLatWtBLBXG53qNRU?=
 =?us-ascii?Q?tspL6OVugxEHB0PseInvIZG0pPiIG4Yc9CIWDv1tBxBOvLVjc/naWPi8r43b?=
 =?us-ascii?Q?oMxWiQWwOtgQkNsUErMTYs/LnXpzfdNy5vXjYNth3zcumlG5/rD8kBDfVxWX?=
 =?us-ascii?Q?1AOCTrImManHFJChWwtcYQGL5e5qD5EaoWqO4Z34ZbMEu9f2DN3543A4MHzu?=
 =?us-ascii?Q?gxNWCHD6O/JnbSRQPl05KaVsiPT+HrEysexR4V55Ayf9XmRokCsewgbG8OB/?=
 =?us-ascii?Q?lDo8m1MmzWlqyAe8Ir6AwdvMMCSH6+JslqfUQO6oxZJxGT4IolTJwqV+x/B2?=
 =?us-ascii?Q?6GM6ppXU3uJ2VpnVx0YUVocv4Wb1XfjUCBC2wwuSjVm1QyfQ+QsKL5Hvi2kv?=
 =?us-ascii?Q?F3vfEIhEl7a0SM0YfnEiKg9/0mdb+IiBZT9BQR4oQZyXGZjETqHQVP9eK34E?=
 =?us-ascii?Q?zR9OjBYvcI8AFtBz5zdmbGPUoeSXXZjStedXcizwE67hPQn3qTnjpKLZSBKw?=
 =?us-ascii?Q?aMVq/ttOpxh7HxsVw+BbBzS5xtY0DH7G5uqgTqNvN9vzrUZgCeZ4jRIuY3NF?=
 =?us-ascii?Q?vzPsfHifisu/+fXL0mQJsOSIC6y3Z7RfUdAGZLVBErq2D7lkwE/fJdtwq9i5?=
 =?us-ascii?Q?gygW07t7lo50YCcyKd+mCKmKDcKXE/d+GwryyV8cASTj8fNELVfjLONygQ/q?=
 =?us-ascii?Q?96M51teA/74EsFfF9L56u9vXc8u3dM2k38u1XheBFB4uBb1/Ekr2VQMT7hR/?=
 =?us-ascii?Q?gKXP4p1TQyhzxQaTx9E/pFifknkF04GeaSm9iumVKple493icn0yKSDL+wON?=
 =?us-ascii?Q?uZuanwKF34/OivOlOWjiiU3xL93ULgwr8iId7lB70lD5ybXvnTdQ6GSZ9TKW?=
 =?us-ascii?Q?9R4PavOfdKVB9MZgZmJ9p80IHnTXDNYJCineUUrgZg5jO+oiX2ratDFMGAgW?=
 =?us-ascii?Q?bvcxNIuCdSxoGWWoadyUckbI2Id48OB7fGHsWMYxNJed7ttYwcweb0q3b6ns?=
 =?us-ascii?Q?lkiH3H6hrRgw6p+pLL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefad657-d9e7-46c0-1066-08ddb9130a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 02:49:18.3787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUr4AcgGXYtHwa2GSYVbi5YwtK8JlWW2xnHZbSOmz0EpYvH4/gl/Bw4xh76BdWoOVDKn/GlinNUgyAYfRQh9Yg==
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
Sent: Wednesday, July 2, 2025 2:45 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 12/28] drm/amdgpu/sdma7: re-emit unprocessed state on ring =
reset

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c
index 99a080bad2a3d..64322a836ebbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,33 +807,27 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *=
ring,
                                 struct amdgpu_fence *timedout_fence)  {
        struct amdgpu_device *adev =3D ring->adev;
-       int i, r;
+       int r;

        if (amdgpu_sriov_vf(adev))
                return -EINVAL;

-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (ring =3D=3D &adev->sdma.instance[i].ring)
-                       break;
-       }
-
-       if (i =3D=3D adev->sdma.num_instances) {
+       if (ring->me >=3D adev->sdma.num_instances) {
                DRM_ERROR("sdma instance not found\n");
                return -EINVAL;
        }

-       drm_sched_wqueue_stop(&ring->sched);
+       amdgpu_ring_reset_helper_begin(ring, timedout_fence);

        r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
        if (r)
                return r;

-       r =3D sdma_v7_0_gfx_resume_instance(adev, i, true);
+       r =3D sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
        if (r)
                return r;
-       amdgpu_fence_driver_force_completion(ring);
-       drm_sched_wqueue_start(&ring->sched);
-       return 0;
+
+       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }

 /**
--
2.50.0

