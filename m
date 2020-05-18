Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 09:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC0C2070A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFw852Lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214786E219;
	Mon, 18 May 2020 09:01:27 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D87A6E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 09:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBojHcUzRwSSZF65qL431PZyuPbIlb8HnIgaVkykrgB2zWWzNavjem/d84AdpnmX1DdAtN1+XHfv/bMjSu7xVMDaDwnayZazIfTuFeQYt1orwqM9mhMDggQApTN6TgH9b5kjor6c+cms6W2WpOtGGnh4Kcv7EzEQwP6p6adIPeXtNNVYqfrCra/NJ9GIMWQbgoZS6jGEYBGwgmNqSTNXgsS/REaUtdS5i5f0ky0VVXf+RteFL5Lb78J13rlRCs97qIRQiUCe71LbZxW4OSC7Gms3Irz/IxhKW45MbMpRAbOjO2rEzbgIbMcLe0edPjBK5Z40kGl0SafV0NGcPKJMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko0MqPZ3Wl1wFww92o43nwYFUu3NxDFx5nbbB++sGpA=;
 b=XFdvFV4BsIw8xSGrXZHj20SKEulIjE85oIEiLAv7hpt0QIXtdVa8xo5zTmFUdmOTUbdrJd4xhsbLeUZqO0C73ndyZIJ6k7HV0MV5bkWO4uejBb1Oo9R6wq4BixADjYxNSxj5103u6rq8jnG8EIw5j6aVpm79q9WgLc7NEEc+3idX1TbVUtXDHsjUkFpR0O3Dh+llyUbBGQim2YGXIh8HcefoyWDzwYNI4xrmaryO2WmlXwElawwQPyuZVNNCpvEG1OeSMctPvCiWrSshAlulPz9UZf6NHVgI6XD7UlUi6OjWsToJqDZe+ake5b0MYBuSaAMrJqblQ3iD5cXMKwkWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko0MqPZ3Wl1wFww92o43nwYFUu3NxDFx5nbbB++sGpA=;
 b=zFw852Lfb7/2yhd4RueroQvkcc3Is347zZlr5CGvNMn7/Z3s+n4UVsv7Jr5cVFiGEmYNpaGKhJLahY1FzmpePSekJ8nm88WrGk1Kc6yq1uafbiE2G2DMVdsmqDfKJCQq+3AHGW0SQ0VZwgHvrPRZaekdxANaE9xNNQ4Bk37yIyk=
Received: from DM6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:5:190::23)
 by CY4PR1201MB0134.namprd12.prod.outlook.com (2603:10b6:910:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 09:01:25 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::d8) by DM6PR11CA0010.outlook.office365.com
 (2603:10b6:5:190::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 09:01:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3000.19 via Frontend Transport; Mon, 18 May 2020 09:01:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 May
 2020 04:01:23 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 May
 2020 04:01:23 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 18 May 2020 04:01:22 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Date: Mon, 18 May 2020 17:00:53 +0800
Message-ID: <1589792453-10553-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(2906002)(36756003)(7696005)(2616005)(82310400002)(8936002)(8676002)(316002)(478600001)(186003)(26005)(86362001)(426003)(47076004)(4326008)(5660300002)(336012)(82740400003)(356005)(6916009)(81166007)(70586007)(6666004)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8599c08-960b-4fd8-3c21-08d7fb0a0aba
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0134:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0134FAD28AA477A296905F30BBB80@CY4PR1201MB0134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTFk8/c9xU3wghfVdX3FATQTzfz8Pjdk8nc4ynfd0MlglxT79tn3gSNV63tHfrht1Tm9A+DH8KAEU/bf7SMYY7ii89UGCYciHXVFSLsFg57z5Jtzp+4+YjgQ7EBwhgTG+y42cJlGmMNp6XerOxeTEhxArFajFJGQgEg/oqbzcwqbijlVAzAGlbIVigw1bs9wP+gZchfFOTv9f8z9VdtSGpllnNEo7CUsN2PWRdaP09A/7R8LHJn2jWA3nkruBSjgn0I/femx1DNklHsuvboBKxxjrhZ+hSYXfXRkR8G/7YtVef2YFOrUUMbSUUeRU771J0j+swVITahJfm7Z6gBQC52DhQQQludf1wjTRVnhkAFHpIwuvgNfWwdKo4CghGPhlGMrbcKNwhMTYE4ZhwnA3wyFB4udNdbqTHVJTCp++/hlUeUV1NSEEF9y6x1YTD3UbuwdIKYJo9cYHAx33tUmSff5KjH6DlIDyuXlKAkmbZAGAKy+eLGN4FIt3sVfZK4jXDv5IhXD3ST25d/PKFzCkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 09:01:24.3537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8599c08-960b-4fd8-3c21-08d7fb0a0aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0134
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under xgmi setup,some sysfs fail to create for the second time of kmd
driver loading. It's due to sysfs nodes are not removed appropriately
in the last unlod time.

Changes of this patch:
1. remove sysfs for dev_attr_xgmi_error
2. remove sysfs_link adev->dev->kobj with target name.
   And it only needs to be removed once for a xgmi setup
3. remove sysfs_link hive->kobj with target name

In amdgpu_xgmi_remove_device:
1. amdgpu_xgmi_sysfs_rem_dev_info needs to be run per device
2. amdgpu_xgmi_sysfs_destroy needs to be run on the last node of
device.

v2: initialize array with memset

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index e9e59bc..3b46ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,9 +325,19 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 					  struct amdgpu_hive_info *hive)
 {
+	char node[10];
+	memset(node, 0, sizeof(node));
+
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
-	sysfs_remove_link(&adev->dev->kobj, adev->ddev->unique);
-	sysfs_remove_link(hive->kobj, adev->ddev->unique);
+	device_remove_file(adev->dev, &dev_attr_xgmi_error);
+
+	if (adev != hive->adev) {
+		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
+	}
+
+	sprintf(node, "node%d", hive->number_devices);
+	sysfs_remove_link(hive->kobj, node);
+
 }
 
 
@@ -583,14 +593,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	if (!hive)
 		return -EINVAL;
 
-	if (!(hive->number_devices--)) {
+	task_barrier_rem_task(&hive->tb);
+	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	mutex_unlock(&hive->hive_lock);
+
+	if(!(--hive->number_devices)){
 		amdgpu_xgmi_sysfs_destroy(adev, hive);
 		mutex_destroy(&hive->hive_lock);
 		mutex_destroy(&hive->reset_lock);
-	} else {
-		task_barrier_rem_task(&hive->tb);
-		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
-		mutex_unlock(&hive->hive_lock);
 	}
 
 	return psp_xgmi_terminate(&adev->psp);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
