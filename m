Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9BC3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E88B20838
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gUhdSwR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E88B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6236E102;
	Wed,  4 Mar 2020 21:45:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CD96E102
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 21:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMQVEX5SgTDzn19yBizOj82TP9uueUlDYda8KDpQTSZjRkcle8PV1RAYpot9wQ9ipYIs/jet1ko6f4+o5ur86MYb7yeuHaizYi7aYoLHpmSLFhAwNa564jJjWV/q+80P5iSYIbQXIXuWt5l13WhgzZ1vcy9uenzrlPXQx2QeNCoKkJQMPglYwyLsJVJCpu6L8aQeWnhCmUiD/NV8biDEYr7IF7ftpeXqpUgT501Qs2oPGNseUG+YIsDzHf6TwQOGmpx6cLtJcoiFvuIjfIBaiuvNmYevWMMxDi06zSCaAm1B5j1MPBBeRUQVbR+82VUCa7L5155B8Wr9a5j4+tFJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIR/mC0NUobzimmDkTaJAI8Xne3Ujb++4Z38FLp3V74=;
 b=mAbuaLh/DjTBy5R96dtWI1b+8TmYMRr6DUbuoc8pAlgiOmqmb0stoIvNy6sT4Q+2wMfPywIj2sgo0Ht+aQHOrYGu7pA1HYsvN0DMkfTiZ+r+VT707ztdSyMj+oU9j6FrnX0V5AA3Nf65a/nh5BzgtMRbgGhTfUvf6bpRAcrxaZJAJU9C/Rbh7IDlEAGYAnQcyTGxTL8UMo2JQBlHzTspRvxJIdI/L/WrWWAn65F9Nt1Qg3DaUbKCJa9fnMmP9L4toq557Rn2gBHaFBEtDBHVGiVHVnEQJC6guXE5dj6sYaZVf0iS4JSUquDDMxQCwNRDeCn9mSPOkl+a5pos5IGRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIR/mC0NUobzimmDkTaJAI8Xne3Ujb++4Z38FLp3V74=;
 b=gUhdSwR2KnVCPNuFnEm7kf5lCO9vgHe+oZH1yvgM5CK50ejYe5wwRak/O44Ekg6eOXgZLHdUeHL949K0xc8e7aNEkZh+Bx2yWnMbz1HUEp5znQ8JdGjukvp3jyB1CmCu/x8TSxZ7X548hhrcvvoQVJkekEYBkMKRpAZAB9l8ln8=
Received: from MWHPR12CA0054.namprd12.prod.outlook.com (2603:10b6:300:103::16)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 21:45:21 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::f2) by MWHPR12CA0054.outlook.office365.com
 (2603:10b6:300:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Wed, 4 Mar 2020 21:45:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 21:45:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 15:45:17 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 15:45:17 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix GPU reset error.
Date: Wed, 4 Mar 2020 16:45:16 -0500
Message-ID: <1583358316-2388-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(428003)(199004)(189003)(336012)(186003)(44832011)(26005)(86362001)(316002)(2616005)(54906003)(70586007)(36756003)(426003)(7696005)(70206006)(8936002)(8676002)(81156014)(81166006)(2906002)(4326008)(356004)(6916009)(5660300002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4109; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84da9dba-1172-464a-f81f-08d7c0855541
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109B6A98A9D772C2B9A1C34EAE50@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPaY54mPZtjbS+QQ6XF1NaWscAuVfF3rmy3gZjLZJywg6OuijdJNm6HLpbEy7UbEpyT7TPKuoU1VeX2KtsDmm0AGeG8noVHC1fLq6bpFbk9YGIaAYYLvc3ChHxbHQiYPbXmcnSzrJPXPZLYZLzMyCRl6cG1qni1TGh3pxvnbOCG7nGJvBuiRjDasrEnUFYkqdhhNQzFCbH1dkiPGgFmg2kWKPIxzI24xdnquyIO5fczylS5JFNCTINrkCjXSalmXVGpk44oRw2opgWcPWua+htuM3J8DAw4KVQoutCNVr8AvmKFVlHqaAG+6iuHNC0dQn62xL8XMPsJvmgJcQGMTMD2GmXqOiT2djCwkYoqczRZo2hZTS1YcITUwGHM8TRZ481AKAiZsTKdb3qvQdBmAvmK8JEE2GoLonrx/wWHYkWn4WhvtE3TEzUdPAwlQOp4x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 21:45:18.8175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84da9dba-1172-464a-f81f-08d7c0855541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Problem:
During GU reset PSP's sysfs was being wrongly reinitialized
during call to amdgpu_device_ip_late_init which was failing
with duplicate error.
Fix:
Move psp_sysfs_init to psp_sw_init to avoid this. Add guards
in sysfs file's read and write hooks agains premature call
if PSP is not finished initialization.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3836acc..6d9b05e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -117,16 +117,6 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
-static int psp_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (adev->asic_type == CHIP_NAVI10)
-		return psp_sysfs_init(adev);
-
-	return 0;
-}
-
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -150,6 +140,13 @@ static int psp_sw_init(void *handle)
 		return ret;
 	}
 
+	if (adev->asic_type == CHIP_NAVI10) {
+		ret= psp_sysfs_init(adev);
+		if (ret) {
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1843,6 +1840,11 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	uint32_t fw_ver;
 	int ret;
 
+	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
+		DRM_INFO("PSP block is not ready yet.");
+		return -EBUSY;
+	}
+
 	mutex_lock(&adev->psp.mutex);
 	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
 	mutex_unlock(&adev->psp.mutex);
@@ -1868,6 +1870,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	char fw_name[100];
 	const struct firmware *usbc_pd_fw;
 
+	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
+		DRM_INFO("PSP block is not ready yet.");
+		return -EBUSY;
+	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
 	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
@@ -1919,7 +1925,7 @@ static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
 const struct amd_ip_funcs psp_ip_funcs = {
 	.name = "psp",
 	.early_init = psp_early_init,
-	.late_init = psp_late_init,
+	.late_init = NULL,
 	.sw_init = psp_sw_init,
 	.sw_fini = psp_sw_fini,
 	.hw_init = psp_hw_init,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
