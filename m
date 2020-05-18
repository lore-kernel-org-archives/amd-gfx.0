Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F2C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 04:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F03F2067D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 04:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1PaUl2JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F03F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEE26E1A2;
	Mon, 18 May 2020 04:45:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3BD6E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 04:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UanUYCfWwBtlAjqd3IgCRczfYK2tJFXR/GwkUTOAsN9dOkc+NMKcxKvYCVKi83+Idjkc4fqxNUubqEI6O7e9hFcVebkTdv+xDKrmKPv35A3OmN/ibqnPk7JcvoJFSsscTaGl5A+CfdBQYfgrOTMX7wrpRtdgR7xSlfTR2ti25gP89dgSL9Ws1kowcmYEEPpbDB4kF0WgPNdUsOT93mlUMeUjXij2MoSlASrMx1Rbp2rGuNDSyWCpVabNrE91/eMahd1nk1kWBbTrAdvlZZOzyLAFlxfZfmEBg3oif2Kb5+H+hSkhUxw4IigdmPZEVM1B82O1qC8M0tgQS/2eBZ+9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXjYxtNQApi+dIr7bZ1JGbKL0A9y2ogKnV2EPNvMCZk=;
 b=aF1PzDboJL38fbkSEoM8WaErLaw2rz8olNCeRu6tDOqECL3c0wC+1eHjLeWWi0QjK2s5ztuaxz2kVZLaiqD4wpiGP1w7YHUKJAFnUgLPVhy2/+2NChi2evBMgyYQ0FgmkowZlPL3jJSaPfPHQUFggEUQWR06zFD2v2wpJXPM1s1Lb5K1EAps24kJbu7KiG5TT4P8tDFw+wkOCyIMCYh6zxNpzr4oZNrk0DduGMjWr7pROSaLEcIJBrti80XxcnAS+/IWrqjP1uf7q69hkhw60PffSJClirC10UpucezLhPKAcVdxCcpp1DSmx9jcFIG2VNZFtWXsyHm6IIoZFBTgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXjYxtNQApi+dIr7bZ1JGbKL0A9y2ogKnV2EPNvMCZk=;
 b=1PaUl2JWYtz8c4fYTbAfdLFPo6s0wKO4CA99YjboBjFpcMW1cIfAgs5kS39zDNumztUgw7gpc7EPL9nfzTpT68Te2KGlBmN4Iow4ypa9C+vok8u6DTX7/Y+Crw5tKx6/8/WrmTlU4A/xO31h+BOsopn55Eia+OaFB3/PHLEEfy4=
Received: from MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) by DM6PR12MB4041.namprd12.prod.outlook.com
 (2603:10b6:5:210::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 04:45:25 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::2b) by MWHPR1201CA0011.outlook.office365.com
 (2603:10b6:301:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 04:45:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3000.19 via Frontend Transport; Mon, 18 May 2020 04:45:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 17 May
 2020 23:45:23 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 17 May
 2020 23:45:23 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 17 May 2020 23:45:22 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
Date: Mon, 18 May 2020 12:44:53 +0800
Message-ID: <1589777093-8738-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(186003)(8936002)(82740400003)(81166007)(8676002)(47076004)(356005)(70206006)(2906002)(5660300002)(86362001)(70586007)(6916009)(426003)(2616005)(6666004)(478600001)(316002)(336012)(7696005)(36756003)(82310400002)(26005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed002eb3-deb8-4b8f-0363-08d7fae6479a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041FB82F04CFE610649B292BBB80@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo5JYKGRF/f9fpQrBW/aifR6yziAw9uIL19wiplwPHrOv1gJoBhc0q2DeSNEqVH7ZvWulS+4A6fkxrmcASHzrbDTu5QLiCblDlfM5XQGPoiTrQa23TlEO69LQtfwpkVTazga7TDumw7EmtyqPngRREylA5I8n7Y+CWSC7vMqZKNsseSEJiTpvptCFJchesf1MaWkWoobT6JAqsJXdNLRuxf+ExNR2mcrROUpPlZEC9fY2zfsgAExbJ9QThnc9xRGD9zcqo7QRcPR9EHY6r5HKMYPchyN/RQ2AyuOZ0XmUS/iij1guO4Wm9wntWjZJ91cEJjhKzRSbhIo7ok/i1Nps43aneSJ9/VbexdD3IEVBAytjFyTrK/jS0YQFQGF374Y7Br0B4YBTlrcWWgz6SGxtXWCd0wS8pyiS03+fUezgXi4Vb6KNkOrzSFJdNGlKbiPepJ1UZvQYMwbiIjr8UaLF6klcsTPgfJVgLOcOaPKjP15ekXT2mFH97vZiQe7sBGY5prlgHFNbLMkixZbq8TNUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 04:45:24.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed002eb3-deb8-4b8f-0363-08d7fae6479a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index e9e59bc..bfe2468 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,9 +325,17 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 					  struct amdgpu_hive_info *hive)
 {
+	char node[10] = { 0 };
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
 
 
@@ -583,14 +591,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
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
