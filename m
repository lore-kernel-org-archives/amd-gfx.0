Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F703C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 23:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E1C6108B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 23:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E1C6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77006E88A;
	Wed, 26 May 2021 23:57:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A4D6E88A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 23:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj7ahAZlgSrjTvcrCX0N4h8pxhgDAPRQ+0UdHaz4rK86Mmos0VNm5TiW1Kcai9QODY8NJLhNa0HgaDFO2QfbEzvk/p9y9lnjkhUCbC0ELGgcZke4TRNEPnXIzH4xqur+SrTt3eF+8LTgGEfYoKyMSx+ykVdRUIaLZDPSUdwi/6KckrB/P88B8P9OeI/Llio5PSOyMq0PxshOxXIV8addWBKY+JLKr3awwr490scGqVgfpCtKft3tG1myjHfIHimg9trh6X8wr8b5hFm9vFrTdxsieVDANHG9Fk8klDrP8jENoSED+NPfLrFX196MXgWsj45IV4nHe+5bgg4FF67NVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZvQa/lvvCvt78R9TA9BinFegi0vfD0fdo3LTjkRmN4=;
 b=nDfKbaQqtf5BEc9FxovxIoziumnu3Rs4ZiAnJBQJsI0/ChhoM3ObJSDpBS29dgyG6pYwIGVQ/1yNzrHJviiILtojELkw2xkQQ3zGZrBZEmcEslVbfKp6U/VEFq11ZsVml8940QKeQaZHpTlPEwPzoX48D7YRJOfwBfUk8NXf0gbm7WNWAlz7iQhQlKXfQPjdaocGGzBnPEBjaqjDg1ub8UPfhcXBrllxFXwa0sKWoF4MiBGP7yu/p7bZHm2wLq4WfVZdawMX9ebMSfJcs13fw88KE7QXuTz4LeAWBadUQO5xv98auqOJPxbmjRTSlAJqPBALK7hND+HfjYbBGu0r6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZvQa/lvvCvt78R9TA9BinFegi0vfD0fdo3LTjkRmN4=;
 b=K6ldyBemwgIlwRcpPvqnrbwBpQS8qmgE/FHZEePahDgoDRarkulnPcQdV8+xBgfrLtMmP5RzfmihiyBC8HN3UB1H8fLUfVLtQ1xDoFrQsUnnOhLP5vA/F/JHIFoRW/bXpGQzbK18LDZ3A7xDbc487rA/lJ1xwcw81PounyXoDn4=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 23:57:44 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e%6]) with mapi id 15.20.4173.022; Wed, 26 May 2021
 23:57:44 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Li, Xin (Justin)" <Xin2.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Topic: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Index: AQHXUhfDs+l87n3b50W6CbIc2GV1LKr2b9IQ
Date: Wed, 26 May 2021 23:57:44 +0000
Message-ID: <BL1PR12MB52692DDE6DC4D82AEB5E4A6784249@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210526101310.1872892-1-xin2.li@amd.com>
In-Reply-To: <20210526101310.1872892-1-xin2.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T23:57:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1516841d-70ab-49ec-a6d8-3bc30d6e721f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 500b2fbd-44e7-48e2-ae85-08d920a20e4e
x-ms-traffictypediagnostic: BL0PR12MB5538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5538A0D780F8EA36EC4C1CC284249@BL0PR12MB5538.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FB+hcN1f2r2xbkgAuSBTN8uV9rS3e4JgqMHw6DcqpRGicy9KhJIqbuXXONgllAdzQc+zTAzOWMW88Wzhr7lqQqEGV2IOwj4V2coVEo89m35bboRVc1h7JA1URo6XmG2cZZRau85fNGfDC/cG21hrfeOaX9xp3zgtw+1lOT2jBNTiRBoJ+XSTP4DZfrZqc36KyxZdnyBh3E1NJ3zghLfx3oQjJDZjN4lQTrulRRZwAmX0yntdlrN5ChGyrq8wJZQOGjPJsLQ+jHQ8JEFCCATUVYDhxT14JGd7REYy2ZWYFR1CbzmQF61Y2R6OaNz0+U2j3y3PdX8vNj+X5mWUP+CO0TRfQXNhU1quIfc6WBv0pkoDK0rLQgix1Sl/e63el8wxbJ1l5vQ61c/KQ6v9OKTy7sLtaV3bccMYiT8qD1askv0oVtcBHfcOheNiCrKl/OEDY+TYeMR/QK27wid+jKuDDKl/jsIma73nKuoRqq+ylKTd1cf9+NrOqRnGNFwyPpjXAQk11FTaH0LJyvmduTZJfoFpwxWJzYgfDJW1IJ8TZEAnqdLTIjXiIsD1VlHKefxalWlCusJFk1pzeYSMvCrEVpslDBFalT+rELMcZR8kdLHolstErDAJHSakNfoc3w7JOVFeL/wsBt7cWgK36+biuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(376002)(366004)(136003)(478600001)(76116006)(52536014)(53546011)(6506007)(9686003)(66476007)(8936002)(45080400002)(66446008)(7696005)(316002)(4326008)(64756008)(186003)(5660300002)(66946007)(66556008)(26005)(122000001)(38100700002)(54906003)(55016002)(966005)(83380400001)(86362001)(8676002)(71200400001)(33656002)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pzONdkv+iqb48NXGQbGtcnvHO8f3794N3dpT9Wp8XAB6CBMg1sLNq6eKgcJD?=
 =?us-ascii?Q?N4RxCQNfiF7bD5Vo4iSKvEYbbYJQkoDDPITfdbT7+5PJXIvlsTIQLF1hlb6T?=
 =?us-ascii?Q?RQpKp13Co/kjITp3jpVgNvrTjruJFSPg+MqC5hq8PClJN26jI6MwBs/azmLV?=
 =?us-ascii?Q?FtK9ZvwvhgvB9Kk0iL/n6/1kVGzgIPpyXQ+R7H5ouoyBH9sHRmgoqeX+QwPb?=
 =?us-ascii?Q?HR6m3WEt/oZcuDT2+lC9HC/4wg/Vim/sId/64fTeXjRTggizI2IeXzQ9iGiG?=
 =?us-ascii?Q?KxQAvLNYfbYU9eB0YfzFMjqdA+WcwtYkVs+3epD6Ic//S3i10Nci82Y4K8cX?=
 =?us-ascii?Q?ZZNzIrYBF2Qk5alZck7kbYtUb6MOb8VR/tCc51ahZq+nH1b8l9lLr+WmyVCP?=
 =?us-ascii?Q?4MOgW1zsxK0Jt+pl3yBfaCIKBo/ADxgn9jC8eKKKEYOolNV7oDLmpV4rc2Wm?=
 =?us-ascii?Q?phnaMWAU/M/95BGGFJ6F/lfxswIYm35oAw0cSfnuM5Hq/5isBMPjT8iF9deP?=
 =?us-ascii?Q?reVBfGLYBY1rtq5xG12jn4+a6AnXFLr4FN9mi6C7J3vrWoHkOuWkVdBBfzu5?=
 =?us-ascii?Q?VZRrxxp7lyUhWQJlpXFG8W+vk0aGWMg79RxxVJVUC4GEtQk+S6TSlJFAqdxI?=
 =?us-ascii?Q?gHIoo+MZeZG5pqAr1MERtgpHEiZUGd2Z0IDSz9dxH+dC+KdMFPI0SNrsfy+6?=
 =?us-ascii?Q?DTbeh8iPif3/VXnFduJlpmm6DjujAE29W1wRimi2Gkq9fD2Cxf/3Dh5rCPuG?=
 =?us-ascii?Q?nbuWsIZkdEUsrOp2S3SmRhRjYP89Do8szIQI5Ef+5/gSuR0j09u//EVVSPsM?=
 =?us-ascii?Q?O3TAytqrjMFtdFxv1WxMd15L6dko+ELGnyTrAHd/hUTUFOOdPZH4/aELhjrt?=
 =?us-ascii?Q?PutTW6Gqb7/1/C8ytcBIW5f7GmKLNbX9UQJJ9lrik+Mz+vVMC0zP5RDXGVkx?=
 =?us-ascii?Q?AONo05t86BZi5jzhKrKCo9xLEMzYLL4n50jnANTaFi4mI90IPMM3RO/Z0WAY?=
 =?us-ascii?Q?6f1SoMPRKcljKf2civ7lhjKzFK1GriyFoldbcbgvvOy4aA7x80C9rH7seIZ/?=
 =?us-ascii?Q?ktuRMgqqlE+BI1eCLKKs2dPG1dp/tAoyPwO3EL3ZieWm0fnbgzaMIJJD5vno?=
 =?us-ascii?Q?SODbsP0hfxTFhY7TegM/lkLh0xW4JhP+1c+bSLxICZayck/TqUgooY9VJx3B?=
 =?us-ascii?Q?FMYYKTtuEc4kXg3gwTOdbh4qlPwpUZM5eLfuQECPtCDjAUNXy+q83J/ibxyF?=
 =?us-ascii?Q?jP0TySoH5Idyv4FW2Pg3ULxlQCylNeRYzfbAEiiMYbJl9x131XN8Wg3r/s6Y?=
 =?us-ascii?Q?KcJzUlOVkH9w6bhz6SDm5DjU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500b2fbd-44e7-48e2-ae85-08d920a20e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 23:57:44.4452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1/e2QdA+Elo3GwddYmABflwtgf8v372vL4WahlhK7jfSQsxhcyhMc5hK4zqWCcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
Cc: "Li, Xin \(Justin\)" <Xin2.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks it lack enough background for people to review:


-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready ||
+				(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev)))
 				++num_rings;

[ml] why for SRIOV navi12 is forced to have those DEC rings ? since  SRIOV navi12 have no decode capability , any explain here ?


-		if (amdgpu_is_tmz(adev))
-			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
[ML] why this is removed ? is it related to your issue ?


Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li, Xin (Justin)
Sent: Wednesday, May 26, 2021 6:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Xin (Justin) <Xin2.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Min, Frank <Frank.Min@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing

since vcn decoding ring is not required, so just disable it.

Cc: Alex.Deucher <alexander.deucher@amd.com>
Cc: Christian.Konig <christian.koenig@amd.com>
Signed-off-by: Li.Xin.Justin <xin2.li@amd.com>
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 524e4fe5efe8..614e6b06e94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready ||
+				(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev)))
 				++num_rings;
 		}
 		ib_start_alignment = 16;
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
 		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
-		if (amdgpu_is_tmz(adev))
-			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c546db..dc8a36766c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
-	int i, r;
+	int i, r = -1;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		vcn_v2_0_start_sriov(adev);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		goto done;
+		if (adev->asic_type == CHIP_NAVI12)
+			ring->sched.ready = false;
+	} else {
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			goto done;
+	}
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+		DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
+			(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev))?"":"decode and",
+			(adev->pg_flags &
+				AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=cMllN28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
