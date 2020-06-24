Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07673C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3562073E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YGrcBwla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3562073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A9C88FB2;
	Wed, 24 Jun 2020 22:53:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FABE6E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 22:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LulIEaK1m4gtsVrCQAO5pjzO4rCN66KuOm5A3L3r4YAPtrKJI52vqn8gApOkDNSmnkf5OyaFwCXb0RyZi2q8YdXnK5z2RYJiI0PSrBega0y/wwsgn85SN7WzFXFf62vIFQsCIsKVTTAuFBa+BzcGWoVwa2//oyVKh3o7ioRWDh8g5ctgZTLmbOSvt7NM/Yhje5U9x50nYdKbSyb1PmTFYnCTpbIb7M5JHhT7NuMVMkX2F9Gpo+mewiPdJnKgbzKNeo4AUK/KzZKiHnEuIBsUnB6/VlTXCJZe/eiY1BWDXMvzth7sEcwlAGCHWOy+ULblNZwPHeGXYJlspcc0QrzYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apd5Dh2VobwpQf8Fc0LtfbEDrNH1uCyZsAntokIP+uM=;
 b=Wo8ygqOTJ94QYCQ7QkqryFxlFx9XSfOnuXVFCUdN8kLll8yi3A8kwZjpleAYUDHoDVbUY9PuS1UcEMaq0q0Vn9wlgr/WPZ4Omm7K155rbfuiFNAGLOOfuHDcnNwpzMYMUGS5hqXMj9ywdUZ1Ihia4D9tFcHCqQ6KGlHiYzHG+q3OpAEBlaAYBblOoiPiKqYbwy0Hzhf/Rzoq/NOgmw+ThdNtGZlINzo7ctccjMk0MohYDbiiYqws67A8o9XHDSPh7qnc1GDYR1pV3hTWE+uG1WA4UoPh0g0KzG/LNNDJCHtP7MkegYAEAPtQoHgf+VYI8+VyAojWzlHzCHd/DiF4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apd5Dh2VobwpQf8Fc0LtfbEDrNH1uCyZsAntokIP+uM=;
 b=YGrcBwlaGhBpUOQfVoB8G4JJp3JPxuAVFj7xFFQwaUVzjKfy67dG/dkrnJ5bWHIpbuuPDOR12WGvCsy/dYZbC6yQDZtkXRrxSFIu0jQYWQ/hT04mihp5f9Y6CJBvNOJ0PJOMduInIwRWrBYkZq/iQSvwRHvHDXsnu1gKfTu9eT4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 22:52:56 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 22:52:56 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: invoke req full access early enough
Date: Thu, 25 Jun 2020 06:52:31 +0800
Message-Id: <20200624225232.7616-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
References: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.24 via Frontend Transport; Wed, 24 Jun 2020 22:52:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c68176c-686f-4631-ec7f-08d818915616
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408547943D0774DE09E2BC478C950@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XgwWSRzYXZLCAS+IfI7eZeNlIzcUowaz8nSED6Ecn/Exvw0V3GXjsVA4GoEthW6FaOikcl/QeZA1zyBIerL2Uj3dk1BSNv4NboCkh3ZyR+NU9XHOfy2mpyAMrtWUAb9KtXIuklYEi9LLMlbV9P25h4Qw8xTqDaFnVwNNWfupRksZYTgICVNhLNJMF7MRdz8c05HZGCjGa0sPh6p1h6bZaW/WdSiLs9Nc9FED+UssYdRH19pg6lfY9y7bQm9zlMf2EjnRHMANEvtVi0Aa325BCOr6L3gVswgjZrZMSH9jhAdz/wFCJgxFXczqOl1SKDF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(86362001)(66946007)(83380400001)(52116002)(7696005)(66556008)(4326008)(66476007)(2906002)(8676002)(956004)(478600001)(316002)(1076003)(2616005)(6916009)(6486002)(26005)(5660300002)(8936002)(16526019)(186003)(54906003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9USu4lJtHc/kKioAR/3hjD36dh++qGOJE7ZClDJRkGKONQgijsTh3vCi+sxDSBRzDqM2gotiXbQdKNNhSTc1YZ9maAuvw/5hu8KSeAbCT0PgrySnPJd3o4NiO3ux11SSrcZuaGf97IGi4MfHAGJKAM19fVsx52sjCG8yMXrKlqD8a7j+jF5LiXnoulFUVFITXo2Ym4ksfHm+gl+ZwSvB2DnydWmIJgsHCwITI7fV0c//Njo0ThEjtHIitnh0LwNA8KM7uxB+XMjgyMLPyB4W9gOhpKaBcNpzC0JOfDqb/zzmB+dEePa86YOjOvs3OLr9XYw1kKcFNgx0BluFZZoImOuyV054e+kwnmHrCnSiouOi1hC4I0iWpcXKg5OH3PPEfs4Ur/ZfnCvTm8mkN4ie+c9h5oVCggr06lDWrO9DtZ2gEPCi4TzbMu74mdGuOeAFzItHOMpwE35xdalWr3KCNTbT7eE6MljgMKCZURi3hXFERVSWGYYT2MrOaKoC4Kyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c68176c-686f-4631-ec7f-08d818915616
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 22:52:56.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHASKzJ3bqRtQjEpUTDY7CFlyQXggzE9E3RDUq8gI19DyFMITKjhyrgNGfGqdGu5jtomt/Kcgq+lrpsdpJKcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

From SIENNA_CICHLID, HW introduce a new protection
feature which can control the FB, doorbell and MMIO
write access for VF, so guest driver should request
full access before ip discovery, or we couldn't access
ip discovery data in FB.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 +++++++++-------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2858c09fd8c0..138ace9c28d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1722,6 +1722,29 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 	amdgpu_device_enable_virtual_display(adev);
 
+	if (amdgpu_sriov_vf(adev)) {
+		/* handle vbios stuff prior full access mode for new handshake */
+		if (adev->virt.req_init_data_ver == 1) {
+			if (!amdgpu_get_bios(adev)) {
+				DRM_ERROR("failed to get vbios\n");
+				return -EINVAL;
+			}
+
+			r = amdgpu_atombios_init(adev);
+			if (r) {
+				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
+				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
+				return r;
+			}
+		}
+
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r) {
+			amdgpu_atombios_fini(adev);
+			return r;
+		}
+	}
+
 	switch (adev->asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_SI
 	case CHIP_VERDE:
@@ -1801,31 +1824,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_probe(adev);
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* handle vbios stuff prior full access mode for new handshake */
-		if (adev->virt.req_init_data_ver == 1) {
-			if (!amdgpu_get_bios(adev)) {
-				DRM_ERROR("failed to get vbios\n");
-				return -EINVAL;
-			}
-
-			r = amdgpu_atombios_init(adev);
-			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-				return r;
-			}
-		}
-	}
-
-	/* we need to send REQ_GPU here for legacy handshaker otherwise the vbios
-	 * will not be prepared by host for this VF */
-	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver < 1) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
-	}
-
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
@@ -1987,12 +1985,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver > 0) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return -EAGAIN;
-	}
-
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
