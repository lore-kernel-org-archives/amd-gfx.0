Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A59C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 22:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1141D89E65;
	Tue, 18 Jan 2022 22:45:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE7C10E38D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 22:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zloj2t9ROFz6K/ewJmIXlJt7jfcYiUDZiXLldQy5O/GMJ3fara+IP7L4hBJeaA/kJuB73Fzy/WX2NJspH+bDglcskU3LIXX8jD07vEpdlheGrcFl5xYwR5s3bkB6v0GGHLf2YOFtwCXrF9UZKuQXdm9F9HiSH8nf02vLWq5RdX2TFryeBO979sOCfBksItzSxiCMEs2pG5YDmJXAuham1k5mOnrSpqFhrcxA+kEeZYYwNvyw0KgMQ96lQGsEDx9v4kFh5WT4ajigTbxF10NDmIwT9NLZkpovVCkq97smBuUQnUjINMBidZVS2XJi/FcOWVgiU6Ka+710Rx0k6IRISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZscp/0F5M0xauAx98ra0njN5vgxiTNWvrP0nER10r0=;
 b=QuKgzndiH9GZnpKWq5M+NyP8TdoRPF45l/D6Lo1cxhgnfe3jR5lGDHdUMKz01+LdxX4l1R513esYJzzE02Jz6nCn4ADznGyq6yY/gSD9Z3y/Kr7HVTvBxqWt0Fk19s4/8hPvbiAVQHPcOtCThFFtJCIsUfxYnupWa5wZTOoN08mMRNT8bC9p/V8jWHQYWYqCX6DY77txTfAXEeojc0BcI9hbIyAwEE0sPM10a1KDbnaDtUZLoNtDA8sGpI9XfnLTMf3uQMti3/mL/bw7IoCAIIML+7gIj4OkNV3nzexz5/02+1ItAJMk75KPlf1QdE3CrTJl4MK5JJ+dgvwz0/XIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZscp/0F5M0xauAx98ra0njN5vgxiTNWvrP0nER10r0=;
 b=KKp3epI9LEpolVta1sJR9fJr3OxdSzIRF+WQwNDnuD1Hobq3YIwC8A0OEmp93ydB+LKFBw9iOoVwVCubFCyk9IFW4nG4nxoSHZJTjDFmBkWtgNSKq6nXcDiVuhKzEX2S1QwEdGO56WZJjpGzn7Rb2K4uvBnG1cFrdnAV/Wv7vkc=
Received: from DM6PR07CA0112.namprd07.prod.outlook.com (2603:10b6:5:330::27)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:45:33 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::8a) by DM6PR07CA0112.outlook.office365.com
 (2603:10b6:5:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 22:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 22:45:32 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 18 Jan 2022 16:45:30 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Date: Tue, 18 Jan 2022 17:45:13 -0500
Message-ID: <20220118224513.26563-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bfe7c81-7d81-49b9-38a0-08d9dad43c52
X-MS-TrafficTypeDiagnostic: BN9PR12MB5340:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53405D39EC6AE140E7C2991482589@BN9PR12MB5340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAPXtCqdKqubId5Q4oCf3L8OrO3W7oRrcaGzCusg4nYifrxLL93duNIPeLPjXqcXwpSE1X9RzXmY8nSDfmOONxsB8xsA7kBfULaKdQwZhQ6yt+jnOiDnkUOIPRG53HfSvTuLmmoVtBDqqvXV725UUW3kaIArO3S3g+LPaes6wZHmZsDtXjvu7Ud9rzBh9/BZCKTtfMId66faFvniO+1URLDwZuD+FIQK9ezDxuRsMuk+hhOXNtLoYym35TPhuLZV2PfMlL0/TlY3SgniOwcQzYNgXHU2/25coX20Hl/7Q+Wq+9TAMKt4YAXVd6kOSn0TfygsFgH1e0pi8k9TWIhBmqB1VqokshgCdff/5/D6gWbui7VWRELgL+0F5uaTg57juTy68iUYXaDtFK334kOrPxE4i7+rBp904LSBd/3a+m+qhKv7IPQSuCAU7cqgQSO0Ei3Ep41n4y+XAx596Ah0P/iGOuQKIJ8Ynqlbj01C1GZTrphX+PZX55ggZ5DEdF5iNIGEWNgf746Tjzri9VE75HI9VMkCIvD20kgAg3myfqImtLY3GLabgXup/YT5Z6l9e3ygOX+24chblHG3/iVf0xHJUhQWzwZ9yFKdQ3/W00gpqYuYaAq/vjnIsBfWc4qTBa1I0zXDSw/1anO/107ttQTyHDxyqu2OfXZ5g2wBEusAx68KL/hH50zbQSeFFqgJ4sapjeDC3W8U/94vmSEHvFaw20qrGVChkkGKl+GsahrzsBt2JVNgHAXSoPHpFJbEUF3a8qjzVP0LlGraPIhRxcHdOGTv6zdrxN73kpWswqUa8gESWTO8aGdfsBUGY3nj7XAn3oqBV1aYjWZgXBLSfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(81166007)(316002)(426003)(36756003)(2906002)(5660300002)(8936002)(1076003)(2616005)(8676002)(83380400001)(16526019)(40460700001)(186003)(7696005)(4326008)(36860700001)(356005)(70586007)(70206006)(82310400004)(47076005)(26005)(6666004)(508600001)(336012)(6916009)(86362001)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 22:45:32.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfe7c81-7d81-49b9-38a0-08d9dad43c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 ------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 10 ++++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a64cbbd943ba..acb4fd973e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
-	/* Only apply no TLB flush on Aldebaran to
-	 * workaround regressions on other Asics.
-	 */
-	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
-		*table_freed = true;
-
 	goto out;
 
 out_unreserve:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b570c0454ce9..485d4c52c7de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1596,6 +1596,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	return ret;
 }
 
+static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
+	        dev->adev->sdma.instance[0].fw_version >= 18);
+}
+
 static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 					struct kfd_process *p, void *data)
 {
@@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	if (table_freed) {
+	if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
 		for (i = 0; i < args->n_devices; i++) {
 			peer = kfd_device_by_id(devices_arr[i]);
 			if (WARN_ON_ONCE(!peer))
@@ -1806,7 +1812,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
+	if (kfd_flush_tlb_after_unmap(dev)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
-- 
2.25.1

