Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC1EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 21:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9921189FAC;
	Tue, 18 Jan 2022 21:28:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE9F89FAC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 21:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs9JjAqVDTeS5L2VnPUK8VT5HvjnsbOmpB716GnhyI44DVuPOKZtbSlhLJ2lmagzYlzNDYDkt2D9Gh1xIGHJcrsu0mOJNVzc09XA9i/STDuHVxgME3MZ2y+U9r0EsBtRWi6IK31R7eWvqK3MhsXQdEXjcQdeUmX06f/+pZhtBBjGEdwWNo7oUQiKy+AH38VQSYVwDJNjtLKNtV5yTROAczXTapc0qyiiNNL3VqchcM9+lGKw9+l6RS2KCF97EVQdLOTfwHtO+pwpi7MNzimxWNkPzSLJJpSsrlrbbYAaGDdMxf1LcvAcueFhr2SFmukFfLC8hQqH7X0bJnmRmmlp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C304a3JxfuAIsGbl1gvHM83D5f6WCCgJVST8F7bWdmY=;
 b=IoWVCZZ/ILPFvLbKY57LMZi2piwed6X/jBeL/DUc9qzLpFJVFgM2XGhhMDTxeR60OMICb9jRZd9OO0fzSbikR/EdR2bcE5fiX5Q9qK5WfgXRFtI4s2fPPYUKR7PmN16vUKAXGne2OyGFTCgV7EbTGUIOHm9IVfukN5wtM5mRcGCeLkUZeyjKC0qPeGchw8WGGh2wN9PM0bGupeNW+weVkNnl0oeq3rfYiQsCDGDAjmbb3M3xQb6kZYlbRPcWia3olM1NVblGbYUxaY9O+nGui7SzYns+A+/mi0uR71Ej64/p6xG2zgAbR0TiWGdXjUQNS+mE3ozk5m3KIlSVCvwLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C304a3JxfuAIsGbl1gvHM83D5f6WCCgJVST8F7bWdmY=;
 b=Y2tgIK0GZPolQq0H0Jcah+PMLuXESal/0DRKDsYex/ZplrdKKGbaa2+XgmQ3U3NUq/lWqPF192TMsmTz62NWlCiJC9HxW1Iq7SCbXBFwhSms1grluipIwGFHwQ0SoGXhjcg/uQXTdWIMsxT4gM86kZIx3c23bFaRuTWYTs43frM=
Received: from MWHPR14CA0038.namprd14.prod.outlook.com (2603:10b6:300:12b::24)
 by MN2PR12MB3391.namprd12.prod.outlook.com (2603:10b6:208:c3::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 21:28:28 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::9d) by MWHPR14CA0038.outlook.office365.com
 (2603:10b6:300:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Tue, 18 Jan 2022 21:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 21:28:27 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 18 Jan 2022 15:28:24 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Date: Tue, 18 Jan 2022 16:28:08 -0500
Message-ID: <20220118212808.23392-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a11a0c4-99f8-40fd-dedf-08d9dac97742
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB339175248D166FC113496B4982589@MN2PR12MB3391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWIuP8Vd0so/sDTd3chlwAqxU2oyJhq2JIfDHJnJ9NrZtGNduA+g3yABUiBnQChzrjwe7Ml3IndaK8tAVh2C1V8CDrWx13/DtkL9puqlyHQD0na7y5tY1ZILKVEA7N3DZpGElWPDLa0N+dpAFj3hP37ArLJMSRtbs44w3x8ooA/UFT4Fqr5qIw7tvqYEvTAkRy1tZbat4fONFBzRjYJCCJ/Y9mal/cN0YB1mqyUOFjkF6HffZii097cjEzyKlJE9qr178UYy939WeKol5GrVmHtc4uMx+oYt3DBhv9Sec4VdIYBMsHXDbB4fiKMGwkkbUU5mTloykxR4wWEEqjjhKuA9DTOGv8mkHAJrwrfrOWJUXbN4oolChfMIBc2SwvVMZzh9eYawm1wF+j0OBie8v7MeuYBahQdadVYUceeMqt/1ewtYucJeXWCSm9Stuhi7aS/hDtvxMNvA7v5SXkw2BULYuJ8C4r+raaacqW4TJ5N1ep5/z/vKAy0jjZByQNa/mOVJTnyjZX3zQkgap/txw+h04DbVrzcaSN4x77gct29W70EjI/e6XBQktLyEy2fa++hmhC8T8JFybmCt4Cvh19hDActi9YzG8Rvp8zV2w29uyzz4hwajgrpLS/9sxRROK26LkGnQMykgJfx8uRDaZjOzRdIt+G24VQcgCnzVf2VOSltQ83r1PTVZewokWkOQL2VROOoJhBab9LIohMyTuRqICvRnzWpj990nZmJtbwsXnXKQRmqVAUZmTh5lq/5tbLiO2gmx2VgwommjHztm8Z8MBs7jKqWKYOJQTtElP56TmQAClJvVRaz+gmhSMHiTwwOlwus65RlI54VxYrTfDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(6666004)(6916009)(5660300002)(47076005)(40460700001)(426003)(70206006)(4326008)(2616005)(86362001)(356005)(16526019)(81166007)(2906002)(1076003)(8676002)(82310400004)(508600001)(316002)(336012)(36860700001)(186003)(7696005)(8936002)(70586007)(83380400001)(26005)(36756003)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:28:27.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a11a0c4-99f8-40fd-dedf-08d9dac97742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA FW fixes the hang issue for adding heavy-weight TLB
flush on Arcturus, so we can enable it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a64cbbd943ba..f1fed0fc31d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1892,10 +1892,13 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
-	/* Only apply no TLB flush on Aldebaran to
-	 * workaround regressions on other Asics.
+	/* Only apply no TLB flush on Aldebaran and Arcturus
+	 * to workaround regressions on other Asics.
 	 */
-	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
+	if (table_freed &&
+	    (adev->asic_type != CHIP_ALDEBARAN) &&
+	    (adev->asic_type != CHIP_ARCTURUS ||
+	     adev->sdma.instance[0].fw_version < 18))
 		*table_freed = true;
 
 	goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b570c0454ce9..0e4a76dca809 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1806,7 +1806,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	    (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
+	     dev->adev->sdma.instance[0].fw_version >= 18)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
-- 
2.25.1

