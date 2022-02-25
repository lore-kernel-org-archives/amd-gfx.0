Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC51C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 20:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8839B10E207;
	Fri, 25 Feb 2022 20:13:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86F310E207
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 20:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5nD9HGW0K7Lv1DbcOSmCMT0uPI+T4nTc2xx6qipPASenBXtYm2afL82LUjggFyr5DDYtfkIcFNxsW3UDzDsOc7Fe8H3bxOin4kN0eJPpKgIJZ2IUPSvpG/QqUClxY6OC9FHBlNZFSU4yEDDV5rUr6PwfLWRbm20uSQbq+OdnJHHtU8zHeGGDZkdJKrdO9XntObPGOiSKTEFRWjGCRMpputvbG83OFPbgGnt1QKPdhziNeieeDWuskh7GaMcVaLbSYJcy7KafO6rt407M1R78FXJRc5cwxrf/74tVNY+h5p2a2x+YHxjEcWNpL6eyjzeG3DAGlpigtQ7G1kfrqBwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/linkgD7NuYHfRJ/fCdpCmKw+TN7mE6K47IfPTdsvo=;
 b=fGbBGFhMF6jzinxIpw80UJChKw0W9nTevUCdaMzwS4b163+ZYBICH2laXaOKcwqEyMzve386nLjWtstfUcy6RpMpPMvjD7cniceojjcAMtEz1LVflj25Cv7YkN+ZWy4OQPPvSmxJSxzkr9wEx/cUH+PEaZKLhADiJYy0K0QSqLQyES9t1x0tyhL/PGeSW8fcxS/UD3TOgrHiSz7IxbTAJLFwnvVO2jjoMJsouKZaaN0uGEtHlZa4XIzfSmcDMmGhX2a1/HTtHD/HPaj8nOxnqqzw8SPUQwj4W88xaDFg99Td10a1wJOBDvlkc6aLQLMksl7oQRWvoAoIjb30HMUo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/linkgD7NuYHfRJ/fCdpCmKw+TN7mE6K47IfPTdsvo=;
 b=Ir7sbKXX9+oR7e9bHi7dlLTcnypD04ausPNHVszow41qtDYNyw97+gb32rsfdFhn8JEIub4nO7t7zYcIDrDlDoeruPzps/GrOL4cUJthrjUVt0NLweN8DYKdKzI+wSHcdfA7w7M/fp7vK1ltxKp/Aws6X4lGmtg3abSSc+Nmub8=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 20:13:01 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::8) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 20:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 20:13:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 14:12:58 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amdkfd: process_info lock not needed for svm"
Date: Fri, 25 Feb 2022 15:12:30 -0500
Message-ID: <20220225201230.6441-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d41167e-aeec-4db3-d720-08d9f89b3897
X-MS-TrafficTypeDiagnostic: MN0PR12MB5955:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB595507679B2E68119FD29E77E63E9@MN0PR12MB5955.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+L8HczHYmQsa+Spln5YaOkCWlOhnMmaea1eV2RWQdErezbUBCjoydGff49LyFc2m90Zah3u8YCujh4adxTV0HIIsO3Bl1pCipsFoO8bGre71KHS7+7FnoJ6gydQREYqwnvV4dvm3ycwo1HUl6xIGiviFXhMe6dwgRC8JX1N3Lq1OQFaa6FdQNPyKvab0IfyZVf9iN/8EP7Yn0EhFBLtaiLbOV+EdGZ3tqOrII4dgv65akm9QE3fM5JV1OMkprHIkAa8vBgCr5rs1XwRcFIM4DDTme9KdGhCyKoMr1OOfoFe/5ZNPWorxYei1DqcFnRnEhnMXmA6BvTS26BwZi8deM4+TIRN/oJN3JntASekj+nhCS2oYD1h/Rt+DJvLNXTNpM92/YZteJRX09APodFLRpJTSBNQJ4TNbWGZHxP+eJSV8SSRxdJfO16KxRWMjOI+YZmTKBd0bw4vGB6alvAxtHRAFzmg5soWVBJZyXRlrq7VcV6kqppnnJzgSQhPWzROD6gjT2eSh2V4b9hXV0DFS0gDnn0FwDYLWIvg81WTTkGYfx5Uf2+/lsbIk0Pnz4fRH8MqljOXGgeAgg1Q/EWavxDP+R9uu8bH3V7SbA+0Y93qkW4ZQSSCYiIPZY/27i4cJtS+T8b74jkIRgbBojAgrh2G6jhgAqgEhxICkPCtmydvbErsFM82COKzNIwqocIc0X4PlhOLZbcOUwkT792MlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(2906002)(5660300002)(8676002)(70586007)(26005)(4326008)(1076003)(336012)(2616005)(16526019)(8936002)(70206006)(7696005)(426003)(186003)(508600001)(83380400001)(40460700003)(356005)(36860700001)(6916009)(316002)(36756003)(82310400004)(54906003)(81166007)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 20:13:00.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d41167e-aeec-4db3-d720-08d9f89b3897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3abfe30d803e62cc75dec254eefab3b04d69219b.

To fix deadlock in kFDSVMEvictTest when xnack off.
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b71d47afd243..509d915cbe69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1629,6 +1629,7 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 static void svm_range_restore_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
+	struct amdkfd_process_info *process_info;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
@@ -1645,6 +1646,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	pr_debug("restore svm ranges\n");
 
 	p = container_of(svms, struct kfd_process, svms);
+	process_info = p->kgd_process_info;
 
 	/* Keep mm reference when svm_range_validate_and_map ranges */
 	mm = get_task_mm(p->lead_thread);
@@ -1653,6 +1655,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		return;
 	}
 
+	mutex_lock(&process_info->lock);
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
 
@@ -1705,6 +1708,7 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
+	mutex_unlock(&process_info->lock);
 	mmput(mm);
 
 	/* If validation failed, reschedule another attempt */
@@ -3209,6 +3213,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		   uint64_t start, uint64_t size, uint32_t nattr,
 		   struct kfd_ioctl_svm_attribute *attrs)
 {
+	struct amdkfd_process_info *process_info = p->kgd_process_info;
 	struct list_head update_list;
 	struct list_head insert_list;
 	struct list_head remove_list;
@@ -3226,6 +3231,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	svms = &p->svms;
 
+	mutex_lock(&process_info->lock);
+
 	svm_range_list_lock_and_flush_work(svms, mm);
 
 	r = svm_range_is_valid(p, start, size);
@@ -3300,6 +3307,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 out:
+	mutex_unlock(&process_info->lock);
+
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-- 
2.17.1

