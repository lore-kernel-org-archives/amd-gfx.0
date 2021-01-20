Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F54C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFF422472
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFF422472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381026E045;
	Wed, 20 Jan 2021 01:53:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9B16E045
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 01:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgnYo7NqoLnqfgp5M3p9LEySNmrc23LkTMe8srfIbYYJThu+PburYuMRB0QcoJcCB559je8GobtaW9XrLp6XXBDJANfHpuKaVjV3SMS3SWNBp5UUGeg+XJoZdoahoeeFV5ZS0F6uuLD16Vh1yhhusDtC+x2F4QA/GNFDRxukXuit0P3BCOfqCip4UFMQBr5rHP2Z7bRY3QB2ABPTvu8erApNtAIJzPEIn9ZvlpnO2ZzRWcQJkntx8tQ2yAuPfHsjZvckf6JgqEnVgnOsGBqMYwqEw5exOHd7gd1jim7g1k2sOkYwh6TuhncznuJvPUKqDXWW9Av7Y5Firfsfn7LfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrsTwGh4cmtRvWyGt5FcrZ6+s9G1l62xp8JzrZSdDYI=;
 b=ZIbhQLuX+vQ307Zf0KNy2Pw1GtqAfrgZW4bS7M4HqWmgNcjz5OjFJEPwSCO21IocbPNNz1YR5Zw3vSO5E323lsoqLucQyDW9dYqj5SkqW5bxB8gGedKK8MzIL/00ymz3b0x9LIWK1SlRGJ0ZMEG7/amnMOBQphe0gQg2nCm1jumOPmawaZ1pKEAx++Q1ZvJrfHgEVQb9TcBNNsgWlW8qogprKVyTiOYdKcjD3rhoV5pkBTM7pZTVa9QJhBaFEs6EowGkqPKpyKYgoOx/dFqBEjVVUL/5VftLaP3GSdv8y4n3ZrclEb3I5/11FgKzS9HhuIczKOXbMThENHjNLAbmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrsTwGh4cmtRvWyGt5FcrZ6+s9G1l62xp8JzrZSdDYI=;
 b=CFqYxhpPVgzuAXn1yhz56Mbe69FmL1Rm9ltGv5LiBUfSniEQ93saQmOZ1+f0uBqUBp3RlG6QHaojbBbqiiItzJ7tzlmRmUjMZ72fqZto9MR1gCziZGM5foBEdb5oR0ikKtOI/1Uvsrl501B/fqMs81t3nCRqipYPgOtV7fqafvA=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 01:53:31 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:53:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
Thread-Topic: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
Thread-Index: AQHW7qNatogKvQGpTkqI9pMDetgxA6ovwDGQ
Date: Wed, 20 Jan 2021 01:53:31 +0000
Message-ID: <CY4PR12MB1287A29EC329C779B7D25289F1A20@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-20T01:53:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5883c276-3418-4269-bae6-9bf138e9f4dc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76adeaa6-69a5-4c72-ebae-08d8bce630be
x-ms-traffictypediagnostic: CY4PR1201MB0184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01849DC1381885775500B22FF1A20@CY4PR1201MB0184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YafZnts+z0shqFn313VAXo+/s7S2vigBdqDNipKILkmN4DLfwX585Y0dxJVC9j0LshrZ9nWVvWB9I5wB5W8gHhP466VwXRcNkGunzvoMGGrHMREmo4nvbU+fME1Kn6+HaBIjygIpgQHt2Ur9h0AfU8U2du4gQkPi1Y6XWo+3p8Ex/KKbMf0I4VHWdrorgQeyvLmQoxE/SzpMyt1gpEYfHWM7NfFmbS9bwVvz4qjbxuC2TwNOzcoOw4nuJu93vFGRA1cgRvN4fbmYJPVbZ5V31Ht+h5X0MdZNnfhvelyeCC1OYP4pY2YFUP/Hmy+bz6Ih0LUirOuB8LETTvwIjDXOKFUN/KheusFO79H2m/Qs99moaAcGtsGkXX1zMp2dGPM7M3Yt/vKnk/n0xQUR5FUDlLPV9TeSv9pmgIyYOcB4dEUuGmVXwuQlGVO7tEAoyMMPLm1CptdDZtrmsxm8pgTxY6GIMD9oIBVp6PpzdiAiCPNPMCV5BDvcG3TeXr6LrFbL6TKHJkVAdErKDJ8oagVubFhir/kOD2W+7avIgC9C1oH56ZGyZ8vUAgMkcCZmJD8GWEFPxMt3ETAB0tP0A7PTeb9bhg9jxoZLWHeMrBAypCY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(66556008)(33656002)(8676002)(186003)(83380400001)(55016002)(9686003)(5660300002)(66476007)(7696005)(76116006)(54906003)(71200400001)(86362001)(316002)(2906002)(4326008)(110136005)(6636002)(26005)(52536014)(478600001)(66446008)(66946007)(45080400002)(6506007)(64756008)(53546011)(8936002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wRu931LtAW0LTVG7K8RtnZYcpxksrmpeGWcCQH7bAQrewpfxDeLtK5istunB?=
 =?us-ascii?Q?NvhjlhkoeIcorQVOYtjA6FXSMRCc9OKNyA1GHhJPkQZgU4Pz1V9NCoazh3zh?=
 =?us-ascii?Q?0JplYqnyPi7JDvUee/+V7PDXsMtOA2t+HBL7pqcQyyYAzfKWab1NWqqH4U7E?=
 =?us-ascii?Q?/0VWiVfT2SVTbrhOnZgcXFp3q3CGy1X7HRwEDBmFuLnq7nA3/W5lbxkPjUg0?=
 =?us-ascii?Q?feChYDj15/2ryZIlm4RMTmuAV7wUnPzu3B5XBwMVmtXlOIXr2SSsf2oNcGQm?=
 =?us-ascii?Q?qf9oZLzMXS+/3lQbt34v9ACOyPalbqS1A12crQeVMpWc+A//6nvA5vM7sXDH?=
 =?us-ascii?Q?OekPD4aNhaV9WbdL08VqoY9XheUzeZJnDHOPMLh6+Qdkz9ad34tal13e6Ryu?=
 =?us-ascii?Q?fPncjIgw6s1s+2E6teKG0/NA0P1oFUdUgYeyaJVa/ki7llXdjLGn7VnwwpPL?=
 =?us-ascii?Q?GGZTLf8hPBuYqwDSIkGI1UolTptzCBBTHzIVfnhsbXjYh4qZCCgPdp02pRu9?=
 =?us-ascii?Q?0N4ToO++sAI22c24HyBYtS+xdsSEmw+rCo711AB4AToLkNBW//9EMYcYhLLX?=
 =?us-ascii?Q?8HDtdEh64MVr1LgWmjfT7HqHd7L69JSRTwZxvydP7jyIW3WX/pHOQPvHIuDM?=
 =?us-ascii?Q?aUwwlXPwf2Pt+uSR8sZkhzw6uIWvO9XZFbjbMmVFu3MqALVmpMz5eOAlaGo8?=
 =?us-ascii?Q?e70cE1+WxStviDo2fNCZ9Sl5x5WDOa9fAirsQadO6coCQl/4w6hn21QVysCA?=
 =?us-ascii?Q?Lwe3FTKiGpDpDX4Qamv0iffmkabSWXE7jH5njnONTb8sdhbb0L37QSbXFI8u?=
 =?us-ascii?Q?Kck0Elm5/wh1lsI58v5Cxc/1aY2oMNaHB2VJLYdWRdI5jjvX0bhIzfc2AVtN?=
 =?us-ascii?Q?8UqQFoNX9/D1EIWIV/bnR5+1lIXnNdzAhdumXSEk9mH1XnAeJVC86P6kryWZ?=
 =?us-ascii?Q?kScz1ddSSPhlR8hJ0Kt2kO8Pgkz9BFc2ebhuSJuYnmfXBvJ+rBNCM7KeskN7?=
 =?us-ascii?Q?Psba?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76adeaa6-69a5-4c72-ebae-08d8bce630be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 01:53:31.8544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+eOVOCLDahe6GelMmDHFrHGNKtfA+MGXnA+WfnQT7UkDUmX0EyraObRewa0+rsgNFsicavUaTeMJaDw/11czQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);

This looks to be one coding style issue. It's better to modify it to kzalloc(sizeof(*da),...)

https://www.kernel.org/doc/html/latest/process/coding-style.html#allocating-memory

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bhawanpreet Lakha
Sent: Wednesday, January 20, 2021 4:41 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Implement functions to let DC allocate GPU memory

From: Harry Wentland <harry.wentland@amd.com>

[Why]
DC needs to communicate with PM FW through GPU memory. In order to do so we need to be able to allocate memory from within DC.

[How]
Call amdgpu_bo_create_kernel to allocate GPU memory and use a list in amdgpu_display_manager to track our allocations so we can clean them up later.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++++  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 +++++++++++++++++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e490fc2486f7..83ec92a69cba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1017,6 +1017,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.soc_bounding_box = adev->dm.soc_bounding_box;
 
+	INIT_LIST_HEAD(&adev->dm.da_list);
+
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 38bc0f88b29c..49137924a855 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -130,6 +130,13 @@ struct amdgpu_dm_backlight_caps {
 	bool aux_support;
 };
 
+struct dal_allocation {
+	struct list_head list;
+	struct amdgpu_bo *bo;
+	void *cpu_ptr;
+	u64 gpu_addr;
+};
+
 /**
  * struct amdgpu_display_manager - Central amdgpu display manager device
  *
@@ -350,6 +357,8 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 	bool force_timing_sync;
+
+	struct list_head da_list;
 };
 
 enum dsc_clock_force_state {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3244a6ea7a65..5dc426e6e785 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -652,8 +652,31 @@ void *dm_helpers_allocate_gpu_mem(
 		size_t size,
 		long long *addr)
 {
-	// TODO
-	return NULL;
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct dal_allocation *da;
+	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
+		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
+	int ret;
+
+	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
+	if (!da)
+		return NULL;
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				      domain, &da->bo,
+				      &da->gpu_addr, &da->cpu_ptr);
+
+	*addr = da->gpu_addr;
+
+	if (ret) {
+		kfree(da);
+		return NULL;
+	}
+
+	/* add da to list in dm */
+	list_add(&da->list, &adev->dm.da_list);
+
+	return da->cpu_ptr;
 }
 
 void dm_helpers_free_gpu_mem(
@@ -661,5 +684,16 @@ void dm_helpers_free_gpu_mem(
 		enum dc_gpu_mem_alloc_type type,
 		void *pvMem)
 {
-	// TODO
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct dal_allocation *da;
+
+	/* walk the da list in DM */
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (pvMem == da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C85ba845fc320487d19cb08d8bcba7b46%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637466856421596284%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kaDroqYYgq4ooRdvMDm93i%2BNbtvBGjdWKLd4Op1yemc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
