Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF0C77B7E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 18:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3336810E094;
	Mon, 29 May 2023 18:53:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D2410E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 18:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7gvQ6XTh1KfQfrOoLMHwtkkgLrQG2SQFFkZu1uexjKZqOhIQmBlbH4XEtp3hpbdomN4f35XKnYgJwBWYnKl+vr6nOY7ZTWdYoFBjj5tLSjUnwrhkkf9uy9QzbbaXQEdlpSv3T1l0sWZP/G8MYOkWPVqAqiTSSRa7ZizoS6cvwN8MG/GH0jJWNI9onU2Fg1r+mw1CAZRrTJY/kd6ZT65HoPpFeinVSof0Qz4t5aJjTAoNm5byqjJIPNh/CRN+b4Jf9fH9+tRSrPQK7eZGLjQqITkItmQsheSolvDMFqM0Y/QNff0etkDbz/i56SA8RTIiDRsinT4QsmZqEN9w/U08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w46xxvbzQp49QQdG6Ks9Rsy22EVewfFsPYaMMHI9URE=;
 b=AAPC23z57fmTF6XYcnyuzlz7JALl9Va3lpIN8CRdJS+ezD1KLlAFLnuvmygyr1OxonuhSoum33daldwhZPah50vldWd399ffgJISCRbB7dsZLNvk81gZAyDXA2/Qca/J2gXp0c6eSDhCywIi4cQLtTBou8MWY/VlIEKHf+Gv9+6gwLZjAicsPmQvJLve1ysJsHGRyNKI7+7CKDq1K/JZwpItng1Nu5Abruv2C1gzC4sSca6hZ0Kz7trw0l6IGobcBwXeEzqnKd9ZNL12W8gRara4EypbBzquR7M5EA+6sPH94uzJPJpVxSfsqe+p8ipSNPDbuj1l8E98ssFt9V/Egw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w46xxvbzQp49QQdG6Ks9Rsy22EVewfFsPYaMMHI9URE=;
 b=inlQmrpAYbSteie6fHn/KkVxwpI7j8JaDmLMuHq0YST0xsM8CCWtsDe5PR+sM9JFI3qGyc6mRmNDEZ2Ff5aJVZrBPvVNh6WT0x2e0E+GNZxKNtwjyIP7TFFw+mhJnG+zJLKKQTInm0chh4jSHqOIP2l8Wru2qCUAAv7iryblmn4=
Received: from BN0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:408:142::27)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 18:53:15 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::64) by BN0PR08CA0028.outlook.office365.com
 (2603:10b6:408:142::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 18:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 18:53:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 13:53:14 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Mon, 29 May 2023 13:53:12 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix Null pointer dereference error in
 amdgpu_device_recover_vram
Date: Mon, 29 May 2023 14:53:12 -0400
Message-ID: <20230529185312.49427-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc1a2c6-5858-4e3b-5029-08db6075f567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JM/dUZ+D7/OzNmG6+9Pk3KAZaly9lglAEeeo6ek69Ojt955iAvSBGZTbH4abpixly1NVtNuFfPJblla8q9nu1zahauW7eeGvxzmjftkS0ccC/2mXPikIs+Dir8mrKBo6O7v6ussYb+dtzR1xJ7QWd/2Mi1O3Wa6QRvzK5Tzw8G+uqd+W0keE2HYOo3ekYq2S4yfYHQWliBZJlA/K8T8Z7+s2T8yAdofITnqa3Euav5kbeMFa/83bSsJcMDdALxT3GatWAEaFs2WMIUDD+oXUN6791aGJU/etouWMMncZVbgu3LqY4tiSkY0QJSVBTEOSECYGODrOV0aSFDD6ExPfO+7uXF69B+PIJG+mpfIJbM/xeT3grjIElvD3+/rPcHY0Qno/HE4SdQPiOkTv+4MKmN/rGh6QD7J5OAYlmPSC02aun3gbmLrEk/HCUpdurt6d/ur6HVcTbMLUxcWsCNGgDJZ9ojF9qbwH5gEu8keacnlM8QW9uu9yQeXF32oi+WktxzOzf0hXr9QH0APoWrbq1LfKpRhCdf1cpNSykhX5c7DvS9582ULlxfcAkKI6jH5kAsfMOaJZO8eKTIqgcvCxNfsrbDXovvVSzSM3GALvQVTSaXTp8LA3pCqM4Q7hnNqU1vpmSKk8UPdui4ujs25lGJLATHfWsF7UN1xthoRp1RZ9lcTzm4zmrp1SD5TB72yd9L3j7mkMFtLbw6Ry+RKR2IF8yX3bNvFPQQwmSeVUIEviRrHfSDYOId2C73aB50dRWpEfZNGsMLkCgFDgNGf1Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(83380400001)(47076005)(5660300002)(316002)(70586007)(70206006)(6916009)(4326008)(82310400005)(36756003)(82740400003)(81166007)(8676002)(8936002)(356005)(41300700001)(7696005)(86362001)(40480700001)(54906003)(2906002)(2616005)(186003)(426003)(336012)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 18:53:14.7373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc1a2c6-5858-4e3b-5029-08db6075f567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, xinhui pan <xinhui.pan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the function of amdgpu_bo_vm_destroy to handle the resource release
of shadow bo. During the amdgpu_mes_self_test, shadow bo released, but
vmbo->shadow_list was not, which caused a null pointer reference error
in amdgpu_device_recover_vram when GPU reset.

Fixes: cd7050908070 ("drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 46f249912b67..4e46f8f1b3de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -79,9 +79,10 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
-	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo *shadow_bo = ttm_to_amdgpu_bo(tbo), *bo;
 	struct amdgpu_bo_vm *vmbo;
 
+	bo = shadow_bo->parent;
 	vmbo = to_amdgpu_bo_vm(bo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
 	if (!list_empty(&vmbo->shadow_list)) {
@@ -711,11 +712,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
-	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
-	/* Set destroy callback to amdgpu_bo_vm_destroy after vmbo->shadow_list
-	 * is initialized.
-	 */
-	bo_ptr->tbo.destroy = &amdgpu_bo_vm_destroy;
 	return r;
 }
 
@@ -732,6 +728,8 @@ void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
 
 	mutex_lock(&adev->shadow_list_lock);
 	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
+	vmbo->shadow->parent = amdgpu_bo_ref(&vmbo->bo);
+	vmbo->shadow->tbo.destroy = &amdgpu_bo_vm_destroy;
 	mutex_unlock(&adev->shadow_list_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index cc3b1b596e56..dea1a64be44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -573,7 +573,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return r;
 	}
 
-	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
 	amdgpu_bo_add_to_shadow_list(*vmbo);
 
 	return 0;
-- 
2.34.1

