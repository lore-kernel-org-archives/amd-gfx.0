Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DECEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E3220823
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E97VQ8Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E3220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4156EB86;
	Wed, 24 Jun 2020 14:41:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA4C6EB86
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe1CayS9F/BJW1FwTsUJVKJ21C6knrcYmF9EblFD2iEzdhsLQhXb6/Ho6giyWwxeXaoh23ktr0NwUlr6/RevF+Z3Bw/h8JbtQeexNBDjNVT+Jlok4s1xeBj7MkGbgh65ghStusSAMZPDxF9vQN569XF59k87GFbS9Yq7QdpeFJqA5s8EAgAT+uuOlpehsNqf5DK9aiWmi7L2qDTp3Nf3ZlH3r2xw+QscjGR90ziJBBca4qr1lthAj/RScMtTS+6LiIBNc6B4Aniw5NAuEwIUFSHyaPdcu2NOvUjDHhVK2wsOI3t5X3+EPfZOXyTOUjjE09WSMfJ11ynVoMCL0MmbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apd5Dh2VobwpQf8Fc0LtfbEDrNH1uCyZsAntokIP+uM=;
 b=C4i5vm2WjaGyZ9OAnmIPoWaQcBv8hAJo+CB/JFrl90ypQTxWnKhewxvO+QEXq0SWAOBK2uPpY565mpW19e1Ycneka1Vpqaz0siJcpNnOlX3pPwIcNTomcda1XnohEiauegzeEdtW8CGUo/aeNVfeBemvOJ4wx2DSODn4etjG2nDnwuQYZdW9Jcb1k+/1TZHQWQI32G9IrmsX996IiUnqYNwAcHiQ5dv9qBTfCcpK5MoxpdijpKxv1DCpbbEpjUfGMIoss93PaYKUv16aDYIP3q2EGFnRjaZcbVOEfDv0F/8InGWFkEZ4ZYU1KSS3Q9dJNEpahDuAJPWO1N0PQ3QEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apd5Dh2VobwpQf8Fc0LtfbEDrNH1uCyZsAntokIP+uM=;
 b=E97VQ8RnHhyxgoRbXMQMkLEA6gmXTP/TBVcE1CTvZJGNw9eZGuqow7ehMT72tM6ULApFCdEXDWOBJVW08xqIU4biGPfxjWOYS2cIWT2yCEW47tY7T3RosU6DyMN6XYzAiGWSh66HP2mAVYkWvPM+1UZ81qXsYE2g2UI9lGtMGHU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3863.namprd12.prod.outlook.com (2603:10b6:610:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 14:41:16 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:41:16 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: invoke req full access early enough
Date: Wed, 24 Jun 2020 22:40:20 +0800
Message-Id: <20200624144021.4297-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624144021.4297-1-Wenhui.Sheng@amd.com>
References: <20200624144021.4297-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR02CA0157.apcprd02.prod.outlook.com
 (2603:1096:201:1f::17) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0157.apcprd02.prod.outlook.com (2603:1096:201:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:41:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c250c1e-37c5-4c5d-6ab5-08d8184ca6b0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38633F30E6315FB27DBCBE328C950@CH2PR12MB3863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvPfhKDl7XYSzCMaYoSnaXRaf997AkcYeUz4w2kvXl35wkujTQxD8Zgt5gcnV7XuDlgRz1kSKnD3fjwhDwAS4OkDRAfDWknY7HWngje6SGRqShL93XjSxgwPvmIdB+g0dQS7UzKTTTwcI5Ki3zIN3hftubg9wyo6wxzgGaj4vNb0f07BElZ5K8zSNw6G090dn3mjWBAU+aybQfjFzfciCNr1kxgmhvpAci1tEvqIA/luu9rNZoWwn5IgoiyRuCL37ksa7Ze68SRSbf00VqzEWmWvBthLv2n/0x997rIBZIXuLP88uEXg2wqsMA+UD/WJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(86362001)(478600001)(16526019)(6666004)(186003)(83380400001)(5660300002)(6486002)(36756003)(26005)(1076003)(4326008)(6916009)(66946007)(316002)(8936002)(66556008)(2906002)(956004)(54906003)(52116002)(7696005)(66476007)(8676002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /dRAUyxd0gNmmUV1z6wJvmSpy79qQdp05vdElpmpXt84kITKa0Jhc2TRGp+yznaJmK6xHXwl2zdsWkuXQEfiufrfZFtDo+rFFkJH2QTPHJBloGtE904SfI2Q/KIbR6PJcWUzbngS7aJv791dxo3w7qJOnzWfBMEp1iKUyaCz+R/2Hjs0XROLk6+qCod9CIbjhUAUfq2ujwNF/hB+5I0I9Gj9vkw9e8r388RoZjLbeCxmlSkSStugbgctcENMp7R0rFsOIGVVfDpMELCRLufFVy7UM8Kux6DBI5FXu4pKDMV0POLzKxOLZn1AsuLz1RS4l1aByahrbl7fPvmgZf98qMIzeljav+qzyR00OlJowdUndJu9MFbbyuk2Y0zsIaErjYh3U+sOnB75Ac2j+dK4FvUiXkby6gwZGM6RTCiGsh231H6v0xp5shsoOf1N7qDeHbmR00EpX2jhqPw57zppIx+NRfCxrSM+dMYClCN8WSUQhZKik/IITUb5QVyeXofp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c250c1e-37c5-4c5d-6ab5-08d8184ca6b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:41:16.7738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zrxZAXISaodA/89s555ZBcRAq7UROJE64lEEhUoU4gLWHt0U3+YfA8vdgU/b/VMwpGo70xT8OXhfqb5rD2PCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3863
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
