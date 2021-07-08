Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4FAC07E9C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 19:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E2F6162D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E2F6162D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043D56E993;
	Thu,  8 Jul 2021 19:53:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AEE6E991
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 19:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfezcyrvJtwVsO7EcuO94DaizV5A0gpZbRp+oEj8TvdznrqBzyXp33mWmDePuKQeoTH+uP/LxRoYeSWrpDCRuKrqNJ7qZCaMJuNdV2w7ZPi9M93SuGWy0JItsXuVe0uWy9B7IyK2wNpEQoasbKQ6AvHnZ+WYVL8k2uc8eIsAPk8hN3etEYRLLh/pkmYaggzJN1oU3qst0aRzYv+BxtTDBRcuqOyubtYQ6ckU/mN+BjUxnKCuQJ+mMwfh/Xjp9Si84mv76e78ni8LLTYt4nhiWJ/zV69wWOVSSLb+ntzvuVwJEvmfeq5UXZmamq0MttIU5gOVzyRJI+Di3eZb7rjVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JAD9hgJQmszhN0XPtzRE/ZVIKlJ8u5qvguZUzCtRgc=;
 b=V0j8LmLhSQ5mXj+4zZu4RsiU/j2MqdY3fVpNASuZnXm6J6AXKp9Fw4o2Qd/Q1ZdAeOxpa9qfrZSfZmOIXI7gfAO24FGTkO71DC3xg3OBHtmOPdgEB8NXLkw6ir9SH90iXstLwAQ3dBrOMppATJf8MEAhud9SW92fVzqR4IYAKD5d6bKhc8XbpcgXwl/v8heMB72koi4c2l3XaeGX9OiGtDeDqHMH4pEZDTP2kxOsBsUd6PB3W93OVY9cwkZONNKZTBKij2XoLXlLkIhlZ5NDkQmxa9fDpadwlzOfI8TuDsjALBvtCmsUsdhnT4BDi9I3rZowmsBx/ibhL7MaW3rT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JAD9hgJQmszhN0XPtzRE/ZVIKlJ8u5qvguZUzCtRgc=;
 b=BwvOnhO1Sz6qv74EBD8Saxnqii7XfnUYjVrkcBCAbL+YUBC/v9wLtDKmKaJBlxvbjGo/jIdgA7oBrmNiSo1BHhjLBg6pFj/zipjuKKLFvbkzfCWbdVQ4sS4PQ8JORsdSdBWp6tiY2n/m/um5jyYXegwhnKl8xhu8DDLnX3wqkt4=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by DM6PR12MB4777.namprd12.prod.outlook.com (2603:10b6:5:16f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 19:53:55 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::98) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Thu, 8 Jul 2021 19:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 19:53:55 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 8 Jul 2021 14:53:54 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
Date: Thu, 8 Jul 2021 15:53:33 -0400
Message-ID: <20210708195333.322119-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db98646b-4873-48a1-cc09-08d9424a1e6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4777:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47774BF1610D4D4757065E4382199@DM6PR12MB4777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6k9NCZ00pmiKyVS3PGKUwLmbbH3eycrhuTi1JQSVgO54Ag7amzd+VUeajeZ/9H65Y065E9xHq2jWaAKDGZpEU7ZQheGRU0yniycuMMKQuG6ErDDIKRjiV7r9+WrxCmEeS9Zplydsahg1S6r3olXYeEQUkbnDgfWSI0FrwZoRK1Ane2W6p0PLzLHvC1e9wtb+ntoAUIi3EfQdtLxACl7U4HZERNal5XppukDJKF96d/Yyg+VIqdT4ejEBrwPPvmtgzQKh5p397i6HBglhNJwfzqxy1Ln1OV/cz08LVFo41Ry2jNS85J9ypp64OcsVikcTdR0VXal4uy7mmxzr5f2MAVmYEhfyfdwcdJk0twzXTk9rD8RnLPvwrSnTALduAAHdu+Vcq1jPogol0tcLvviOp7m9+6Bcn+b9vWEbxw1T0scUDDeL7OPhN2gHMAF/oGUqc/PQXCaRVsleFYaOtNuqZmjS/sxf4G1gZqapcJ0xQrRvoxv08s3tkh5p6J0Xjh3HPjjUcMq4LuFfwpmoybqu6g5+zj6QoABhL1oekIKXJDeWXb7HcSuXMuqAEkL5axw4zGR7Rz+RcJFtqCteah0ERf5/rY6cZOpUQhz84MwfABuxA5enZq4ktAabCO1cTxaG0/lUrGrsbQu9qrUdAPiEgOgx0LPA5USLGuY2N4JKGtd81tw3wOfn6AUXyvIz4vCK05/qvQUpcq2aCxEOxUMgsPsOv4rBu374jUwYdHCHcOw6pI/qblcvxgS0LN6bYxu8GAXomh0E6hmAgRToDjQv6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(2906002)(86362001)(82310400003)(82740400003)(426003)(356005)(81166007)(36860700001)(83380400001)(6916009)(186003)(5660300002)(26005)(336012)(16526019)(1076003)(47076005)(2616005)(6666004)(36756003)(70206006)(4326008)(7696005)(8936002)(8676002)(70586007)(316002)(478600001)(54906003)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 19:53:55.4772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db98646b-4873-48a1-cc09-08d9424a1e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4777
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to workaround HW bug on other Asics and based on
reverting two commits:
  drm/amdkfd: Add heavy-weight TLB flush after unmapping
  drm/amdkfd: Add memory sync before TLB flush on unmap

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 37 +++++++++++++-----------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ebb4872c5a9d..5f2655cf0162 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1773,26 +1773,29 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
-	if (err) {
-		pr_debug("Sync memory failed, wait interrupted by user signal\n");
-		goto sync_memory_failed;
-	}
+	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
+		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
+				(struct kgd_mem *) mem, true);
 
-	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
-			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-			amdgpu_read_unlock(peer->ddev);
+		if (err) {
+			pr_debug("Sync memory failed, wait interrupted by user signal\n");
+			goto sync_memory_failed;
 		}
-	}
 
+		/* Flush TLBs after waiting for the page table updates to complete */
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+				amdgpu_read_unlock(peer->ddev);
+			}
+		}
+	}
 	kfree(devices_arr);
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
